package com.ow.framework.util;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import com.ow.framework.data.dao.SessionFactory;
import com.ow.module.event.sysmgr.laboratory.LaboratoryUploadHelp;

public class ToPicReferenceUtil3 implements Runnable {
	private String fileRealPath;
	private String upload;
	private String savepath;
	private String resType;
	private String isflag;
	@SuppressWarnings("rawtypes")
	private HashMap paramMap;
	private String dsname;
	
	public ToPicReferenceUtil3(String fileRealPath, String upload, String isflag,String savepath, String resType, HashMap paramMap, String dsname) {
		super();
		this.fileRealPath = fileRealPath;
		this.upload = upload;
		this.savepath = savepath;
		this.resType = resType;
		this.isflag = isflag;
		this.paramMap = paramMap;
		this.dsname = dsname;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void run() {
		String roomType=StringUtil.reResAbbreviated(resType);
		try {
			//paramMap.put(roomType+"Upload", this.outputpath.substring(outputpath.lastIndexOf("\\")+1)) ;
			LaboratoryUploadHelp.laboratoryHandlePptDocPdf(fileRealPath, upload, savepath, resType, paramMap,"");
			
			paramMap.put(roomType+"StoryState", "处理完成");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			paramMap.put(roomType+"StoryState", "处理失败");
		} 
		try {
			SqlSession sqlsession=SessionFactory.getInstance().getSQLSession(dsname);
			
			String updatestate = "";
			
			if(isflag.equals("isstory")){
				updatestate = resType+".update_storystate";
			}
			
			int r=sqlsession.update(updatestate, paramMap) ;
			System.out.println(r);

			sqlsession.commit();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			//System.err.println("文档转换状态更新失败");
		}
		
	}

	/*public static void main(String[] args) {
		toFlv("D:\\1.wmv");
	}
*/
}
