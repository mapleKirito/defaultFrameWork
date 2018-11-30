package com.ow.framework.listener.event.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import jxl.Cell;
import jxl.Workbook;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DateUtil;
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.KeyHelper;
import com.ow.framework.util.TxtHandler;

/**
 * 数据上传业务处理
 * 
 * @author Administrator
 */
public class UploadDataEvent implements EventListener {
	private static String fileSplit = "/";
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	TxtHandler txtHandler = TxtHandler.getInstance();
	List list = null;
	SimpleDateFormat sfDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	StringBuffer strBuf = new StringBuffer("");
	int count  = 0;
	public UploadDataEvent() {
		resultData = new ResultData();
	}

	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try{
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				String fileName = null;
				String realPath = ServletActionContext.getServletContext()
						.getRealPath(fileSplit)
						+ ((UploadDataAction) eventExecutor.getBaseAction())
								.getSavePath() + fileSplit;
				File[] files = ((UploadDataAction) eventExecutor.getBaseAction()).getUpload();
				List<Object> realPathList = new ArrayList<Object>();
				if (files != null) {
					List<String> tempPath = getTempPath(eventExecutor
							.getBaseAction().getParamMap().get("swapPath"),files.length);
					for (int i = 0; i < files.length; i++) {
						fileName = DateUtil.sDateFormat()
								+ ((UploadDataAction) eventExecutor.getBaseAction()).getUploadFileName()[i];
						FileHelper.createFolder(realPath + tempPath.get(i)
								+ fileSplit);
						if (!FileHelper.writeFile(new File(realPath + tempPath.get(i)
										+ fileSplit + fileName), files[i])) {
							resultData.setIntResult(-1);
							return resultData;
						}
						realPathList.add(realPath + tempPath.get(i) + fileSplit
								+ fileName);
					}
					boolean succFlag = true;
					String columnName = eventExecutor.getBaseAction().getParamMap()
							.get("columnName") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("columnName").toString();
					String[] columnNames = columnName.split("&");
					for (int i = 0; i < realPathList.size(); i++) {
						String filePath = realPathList.get(i).toString();
						if (filePath.toLowerCase().endsWith(Constant.IMPORTFILETYPE)) {
							succFlag = xlsOperator(filePath, columnNames,eventExecutor);
						} else {
							succFlag = textOperator(filePath, columnNames,eventExecutor);
						}
					}
					if (succFlag)
						resultData.setIntResult(1);
					else
						resultData.setIntResult(0);
				}
			}
		}catch(Exception e){
			/** 执行器执行失败 */
			String error = DetailException.expDetail(e, UploadDataEvent.class);
			log.error(error);
			throw e;
		}
		return resultData;
	}

	/** 对多文件上传的路径处理方法 */
	private List<String> getTempPath(String str, int length) {
		List<String> returnList = new ArrayList<String>();
		/** 当隐藏域没有配置 */
		if (str == null) {
			for (int i = 0; i < length; i++) {
				returnList.add(fileSplit);
			}
			return returnList;
		} else {
			/** 当上传多文件的时候两种情况 */
			String strs[] = str.split("&");
			if (strs.length > 0 && strs.length < length) {
				for (int i = 0; i < strs.length; i++) {
					returnList.add(strs[i] + fileSplit);
				}
				for (int j = 0; j < length - strs.length; j++) {
					returnList.add(fileSplit);
				}
				return returnList;
			} else {
				returnList.add(str);
				for (int i = 0; i < length - 1; i++) {
					returnList.add(fileSplit);
				}
				return returnList;
			}
		}
	}

	/** 插入excel文件数据 */
	public boolean xlsOperator(String filePath, String[] columnNames,
			EventExecutor eventExecutor)throws Exception {
//		int temp=0;
		boolean isSuccFlag = true;
		try {
			InputStream is = new FileInputStream(filePath);
			jxl.Workbook rwb = Workbook.getWorkbook(is);
			int sheetNum = rwb.getNumberOfSheets();
			for (int s = 0; s < sheetNum; s++) {
				jxl.Sheet rs = rwb.getSheet(s);
				int num = rs.getRows();
				int counter = 0;
				List<HashMap<String, String>> arrayList = new ArrayList<HashMap<String, String>>();
//				if (Constant.BATCH_NUM > 100)
//					BATCH_NUMBER = Constant.BATCH_NUM;
				for (int i = 1; i < num; i++) {
//					if (counter == BATCH_NUMBER) {
//						HashMap<String, String> dataMap = null;
//						String path = ServletActionContext.getServletContext().getRealPath(fileSplit)+((UploadDataAction) eventExecutor.getBaseAction()).getSavePath() + fileSplit;
//						for (int j = 0; j < arrayList.size(); j++) {
//							String autoPrimaryKey = KeyHelper.getKey();
//							if (arrayList.get(j) instanceof HashMap) {
//								try {
//									dataMap = arrayList.get(j);
//									if (dataMap.size() == 0) {
//										isSuccFlag = false;
//										continue;
//									}
//									String sid = eventExecutor
//											.getSqlidByIndex(0);
//									String taskId = eventExecutor.getBaseAction().getParamMap()
//									.get("taskId") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("taskId").toString();
//									if(!taskId.equals("")){
//										dataMap.put("taskId", taskId);
//									}
//									dataMap.put("autoPrimaryKey",
//											autoPrimaryKey);
//									if (!"".equals(sid)) {
//										eventExecutor.getSqlSession().insert(
//												sid, dataMap);
//									}
//								} catch (Exception e) {
//									if(dataMap.get("taskId") != null || !dataMap.get("taskId").equals("")){
//										FileHelper.createFolder(path+dataMap.get("taskId")+fileSplit);
//										strBuf.append("错误时间"+sfDate.format(new Date())+"\r\n");
//										strBuf.append("第"+(j+1)+"行数据没有添加到数据库\r\n");
//										for(int k = 0 ;k<columnNames.length;k++){
//											strBuf.append(dataMap.get(columnNames[k])+",");
//										}
//										strBuf.append("\r\n");
//									}
//								}
//							}
//						}
//						if(!strBuf.toString().equals("")){
//							txtHandler.writeTxtFile("", path+dataMap.get("taskId")+fileSplit, dataMap.get("taskId")+".txt",list, new String[]{strBuf.toString()},new String[]{});
//						}
//						arrayList.clear();
//						counter = 0;
//					}
					Cell[] cell = rs.getRow(i);
					HashMap<String, String> hm = new HashMap<String, String>();
					for (int j = 0; j < columnNames.length; j++) {
						String mapValue = cell[j].getContents().trim();
						if(mapValue.indexOf("/")!=-1 && mapValue.split("/").length>2){
							if(mapValue.split("/").length==3 && mapValue.split("/")[2].length()==4){
								mapValue = mapValue.split("/")[2]+"-"+mapValue.split("/")[1]+"-"+mapValue.split("/")[0];
							}
						}
//						if (j == 0) {
//							if (mapValue.equals("")) {
//								break;
//							} else {
//								hm.put(columnNames[j], mapValue);
//							}
//						} else
						hm.put(columnNames[j], mapValue);
//						temp++;
					}
					arrayList.add(hm);
					counter++;
				}
				if (counter > 0) {
					HashMap<String, String> dataMap = null;
					String path = ServletActionContext.getServletContext().getRealPath(fileSplit)+((UploadDataAction) eventExecutor.getBaseAction()).getSavePath() + fileSplit;
					for (int j = 0; j < arrayList.size(); j++) {
						String autoPrimaryKey = KeyHelper.getKey();
						if (arrayList.get(j) instanceof HashMap) {
							try {
								dataMap = arrayList.get(j);
								if (dataMap.size() == 0) {
									isSuccFlag = false;
									continue;
								}
								String sid = eventExecutor.getSqlidByIndex(0);
								String taskId = eventExecutor.getBaseAction().getParamMap()
								.get("taskId") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("taskId").toString();
								if(!taskId.equals("")){
									dataMap.put("taskId", taskId);
								}
								String sid0 = eventExecutor.getSqlidByIndex(2);
								if (!"".equals(sid0)) {
									Object one = eventExecutor.getSqlSession().selectOne(sid0,dataMap);
									if(!one.equals("0")){
										FileHelper.createFolder(path+dataMap.get("taskId")+fileSplit);
										strBuf.append("错误时间"+sfDate.format(new Date())+"\r\n");
										strBuf.append("第"+(j+1)+"行数据没有添加到数据库,由于同一批次的账号重复\r\n");
										for(int k = 0 ;k<columnNames.length;k++){
											strBuf.append(dataMap.get(columnNames[k])+",");
										}
										strBuf.append("\r\n");
										count++;
										continue;
									}
									String sid3 = eventExecutor.getSqlidByIndex(3);
									dataMap.put("account", dataMap.get("USER_SerialNO"));
									Object obj = eventExecutor.getSqlSession().selectOne(sid3,dataMap);
									if(obj!=null && obj instanceof HashMap){
										dataMap.put("USER_SerialNO",((HashMap)obj).get("userID").toString());
									}else{
										dataMap.put("USER_SerialNO", "");
									}
									dataMap.put("autoPrimaryKey", autoPrimaryKey);
									if (!"".equals(sid)) {
										eventExecutor.getSqlSession().insert(sid,
												dataMap);
									}
								}
							} catch (Exception e) {
								if(dataMap.get("taskId") != null || !dataMap.get("taskId").equals("")){
									FileHelper.createFolder(path+dataMap.get("taskId")+fileSplit);
									strBuf.append("错误时间"+sfDate.format(new Date())+"\r\n");
									strBuf.append("第"+(j+1)+"行数据没有添加到数据库\r\n");
									for(int k = 0 ;k<columnNames.length;k++){
										strBuf.append(dataMap.get(columnNames[k])+",");
									}
									strBuf.append("\r\n");
									count++;
								}
							}
						}
					}
					if(!strBuf.toString().equals("")){
						txtHandler.writeTxtFile("", path+dataMap.get("taskId")+fileSplit, dataMap.get("taskId")+".txt",list, new String[]{strBuf.toString()},new String[]{});
						String sid1 = eventExecutor.getSqlidByIndex(1);
						if (!"".equals(sid1)) {
							dataMap.put("importDetailUrl", path+dataMap.get("taskId")+fileSplit+dataMap.get("taskId")+".txt");
							eventExecutor.getSqlSession().update(sid1,dataMap);
						}
					}
					((UploadDataAction)eventExecutor.getBaseAction()).setSingleData("导入完成，有"+count+"条错误。在任务列表查看！");
					arrayList.clear();
					counter = 0;
				}
			}
			is.close();
			return isSuccFlag;
		} catch (Exception e) {
			/** 执行器执行失败 */
			String error = DetailException.expDetail(e, UploadDataEvent.class);
			log.error(error);
			throw e;
		}
	}

	/** 插入TxT文件数据 */
	public  boolean textOperator(String filePath, String[] columnNames,
			EventExecutor eventExecutor)throws Exception {
		boolean isSuccFlag = true;
		BufferedReader br = null; 
		String lineContent = null;
		try {
			br = new BufferedReader(new InputStreamReader(new FileInputStream(filePath), "GB2312"));
			lineContent = br.readLine();
			int counter = 1;
			int batchCounter = 0;
			List<HashMap<String, String>> arrayList = new ArrayList<HashMap<String, String>>();
//			if (Constant.BATCH_NUM > 100)
//				BATCH_NUMBER = Constant.BATCH_NUM;
			while (lineContent != null) {
//				if (batchCounter == BATCH_NUMBER) {
//					HashMap<String, String> dataMap = null;
//					for (int i = 0; i < arrayList.size(); i++) {
//						String autoPrimaryKey = KeyHelper.getKey();
//						if (arrayList.get(i) instanceof HashMap) {
//							try {
//								dataMap = arrayList.get(i);
//								if (dataMap.size() == 0) {
//									isSuccFlag = false;
//									continue;
//								}
//								String sid = eventExecutor.getSqlidByIndex(0);
//								dataMap.put("autoPrimaryKey",autoPrimaryKey);
//								if (!"".equals(sid)) {
//									eventExecutor.getSqlSession().insert(sid, dataMap);
//								}
//							} catch (Exception e) {
//								isSuccFlag = false;
//								throw e;
//							}
//						}
//					}
//					arrayList.clear();
//					batchCounter = 0;
//				}
				HashMap<String, String> hm = new HashMap<String, String>();
				String[] lineContents = lineContent.split("\t");
				for (int i = 0; i < columnNames.length; i++) {
					String mapValue = lineContents[i];
					if (i == 0) {
						if (mapValue.equals("")) {
							break;
						} else {
							hm.put(columnNames[i], mapValue);
						}
					} else {
						if (mapValue.equals("")) {
							continue;
						}
						hm.put(columnNames[i], mapValue);
					}
				}
				arrayList.add(hm);
				counter++;
				batchCounter++;
				lineContent = br.readLine();
			}
			if (batchCounter > 0) {
				HashMap<String, String> dataMap = null;
				for (int i = 0; i < arrayList.size(); i++) {
					String autoPrimaryKey = KeyHelper.getKey();
					if (arrayList.get(i) instanceof HashMap) {
						try {
							dataMap = arrayList.get(i);
							if (dataMap.size() == 0) {
								isSuccFlag = false;
								continue;
							}
							String sid = eventExecutor.getSqlidByIndex(0);
							dataMap.put("autoPrimaryKey", autoPrimaryKey);
							if (!"".equals(sid)) {
								eventExecutor.getSqlSession().insert(sid,dataMap);
							}
						} catch (Exception e) {
							isSuccFlag = false;
							throw e;
						}
					}
				}
				arrayList.clear();
				batchCounter = 0;
			}
			br.close();
			return isSuccFlag;
		} catch (Exception e) {
			/** 执行器执行失败 */
			String error = DetailException.expDetail(e, UploadDataEvent.class);
			log.error(error);
			throw e;
		}
	}
}
