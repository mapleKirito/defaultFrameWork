package com.ow.framework.listener.event;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import bsh.This;

import com.opensymphony.xwork2.ActionSupport;
import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.BaseAction;
import com.ow.framework.data.dao.SessionFactory;
import com.ow.framework.data.handler.config.Permission;
import com.ow.framework.data.po.AbstractBean;
import com.ow.framework.data.po.ImitationStepData;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.proxy.Factory;

public abstract class BaseExecutor implements Executor {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private static HashMap<String,Object> pmsIndex;
	/** sqlSession对象 */
	private SqlSession sqlSession;
	/** 系统结果集返回对象 */
	private ResultData resultData;
	/** 数据处理bean对象，主要包括参数对象或者结果集对象 */
	private String dataHandleBean;
	/** 控制器基类（action） */
	private BaseAction baseAction;
	/** 系统权限代码 */
	private String code;
	/** 权限对象信息 */
	private Permission permission;
	/** 数据源名 */
	private String dsname;
	/** 是否支持事物 */
	private String istransaction;
	/** 记录日志内容动态系替换字段 */
	private String logColumn;
	/** 记录是否所有事件都成功运行*/
	private ExecutorResult executorResult;
	/**分页相关参数对象*/
	private PaginatedData paginatedData;
	
	public BaseExecutor(BaseAction baseAction) throws Exception {
		this.baseAction = baseAction;
		if (this.baseAction != null) {
			/**执行器执行结果存放对象初始化*/
			executorResult = new ExecutorResult();
			/** 系统权限代码 */
			this.code = getPermissionCode();
			/** 相关属性信息初始化 */
			setPropertiesByCode(this.code);			
		}
	}
	
	public BaseExecutor(BaseAction baseAction,String code) throws Exception {
//		if (code == null || "".equals(code))
//		{
//			log.debug("permission code is null");
//			throw new Exception("permission code is null");
//		}		
		this.baseAction = baseAction;
		if (this.baseAction != null) {
			/**执行器执行结果存放对象初始化*/
			executorResult = new ExecutorResult();
			/** 系统权限代码 */
			this.code = code;
			/** 相关属性信息初始化 */
			setPropertiesByCode(this.code);
		}
	}

	/**
	 * 设置系统相关属性初始化信息
	 * @param code
	 * @throws Exception 
	 */
	public void setPropertiesByCode(String code) throws Exception {
		if(code != null && !code.equals(""))
		{
			/** 根据code获取权限对象信息 */
			this.permission = this.getPermission(code);
			/** 数据源名 */
			this.dsname = permission.getDataSource();
			/** 是否支持事物 */
			this.istransaction = permission.getIsTransaction();
			/** 设置跳转目标文件，若不为空则不进行设置 */
			if  (this.getBaseAction().getDirectFile() == null ||
					"".equals(this.getBaseAction().getDirectFile()))
			{
				String forwordcode = permission.getCode();
				if(forwordcode.equals("003015")){
					this.getBaseAction().setDirectFile("UniteCount/WebContent/countDital.jsp");	
				}else{
					this.getBaseAction().setDirectFile(permission.getDirectName());
				}

			}
			/** 设置数据结果集处理bean */
			this.setDataHandleBean(permission.getDataHandlerBean());
			/** 设置系统跳转状态*/
			this.recordSimulateStep();
			/**分页相关参数设置*/
			if (this.permission != null && baseAction != null){
				int pageSize=8;
				try{
					pageSize = Integer.parseInt(baseAction.getPageSize());
				}
				catch(Exception e){}
				int currentPage = 1;
				try{
					currentPage = Integer.parseInt(baseAction.getCurrentPage());
				}
				catch(Exception e){}				
				paginatedData = new PaginatedData(this.permission.getDataSource(),pageSize,currentPage);
				baseAction.getParamMap().put(Constant.PAGE_START, String.valueOf(paginatedData.getStart()));
				baseAction.getParamMap().put(Constant.PAGE_OFFSET, String.valueOf(paginatedData.getOffset()));
			}			
			/** 对参数对象paramMap内存储的数据通过映射bean进行处理 */
			this.paramDataHandle(baseAction.getParamMap(),"0");
			/**设置当前code的子权限代码*/
			this.baseAction.setSubPermission(this.getSubPermission(this.code));			
		}
		/** 设置权限信息页面直接获取的索引*/
		this.configPermissionIndex();	
	}
	
	/**
	 * 初始化设置系统SqlSession
	 * @throws Exception
	 */
	public void initSqlSession() throws Exception
	{
		/** 设置sqlSession对象 */
		if (this.istransaction != null && (this.istransaction.equals("1") || this.istransaction.equals("true"))) {
			this.setSqlSession(SessionFactory.getInstance().getSQLSession(this.dsname, ExecutorType.BATCH, false));
		} else {
			this.setSqlSession(SessionFactory.getInstance().getSQLSession(this.dsname, ExecutorType.SIMPLE, true));
		}		
	}
	/**
	 * 根据跳转步骤编号，记录跳转步骤的各个状态
	 * @param code    系统权限代码
	 */
	private void recordSimulateStep()
	{
		String imitateBack = this.baseAction.getImitateBack();
		String  imitationStep = this.permission.getImitationStep();
		/**只有配置模拟步骤信息的权限，才进行模拟信息记录*/
		if (imitationStep != null && !"".equals(imitationStep))
		{
			if (this.baseAction != null && this.baseAction.session != null &&
					imitateBack != null && !"1".equals(imitateBack))
			{
				ImitationStepData  imitationStepData = new ImitationStepData();
				/***设置记录权限代码*/
				imitationStepData.setCode(this.baseAction.getCode());
				/***设置记录目标跳转文件*/
				imitationStepData.setDirectFile(this.baseAction.getDirectFile());
				/***设置记录系统参数对象*/
				imitationStepData.setParamMap(this.baseAction.getParamMap());
				/**设置模拟对象类到session*/
				this.baseAction.session.put(imitationStep,imitationStepData);
			}
		}
	}
	
	/**
	 * 获取正常跳转code或模拟跳转步骤的code
	 * 若为模拟code，还要重新设这相关目标文件和相关参数信息
	 */
	private String getPermissionCode()
	{
		String pcode = null;
		try{
			String imitateBack = this.baseAction.getImitateBack();
			String targetStep = this.baseAction.getImitateStep();
			/**如果目标模拟参数不为空直接走模拟步骤*/
			/**否则走正常流程*/
			if (imitateBack != null && "1".equals(imitateBack) 
					&& targetStep != null && !"".equals(targetStep))
			{
				ImitationStepData  imitationStepData = null;
				Object obj = this.baseAction.session.get(targetStep);
				/**验证是否是模拟对象实例，若不是走正常业务流程*/
				if (obj instanceof ImitationStepData)
				{
					imitationStepData = (ImitationStepData)obj;
					/***重新设置记录权限代码*/
					String tcode = imitationStepData.getCode() == null ? "" :imitationStepData.getCode();
					this.baseAction.setCode(tcode);
					/***重新设置目标跳转文件*/
					String tdirectFile = imitationStepData.getDirectFile() == null ? "" :imitationStepData.getDirectFile();
					this.baseAction.setDirectFile(tdirectFile);
					/***重新设置记录系统权限对象*/
					HashMap<String,String> pmap = imitationStepData.getParamMap() == null ? new HashMap<String,String>() :imitationStepData.getParamMap();
					this.baseAction.setParamMap(pmap);	
					pcode =  tcode;
				}		
				else{
					pcode = this.baseAction.getCode();
				}
			}
			else
			{
				pcode = this.baseAction.getCode();
			}
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, BaseExecutor.class);
			log.debug(error);
		}
		return pcode;
	}
	
	/**
	 * 根据code获取权限信息对象
	 * 
	 * @param code
	 * @return
	 * @throws Exception 
	 */
	public Permission getPermission(String code) throws Exception {
		try{
			if (this.baseAction.session.get(Constant.S_LOGINC_PERMISSION) != null) {
				if (this.baseAction.session.get(Constant.S_LOGINC_PERMISSION) instanceof List){
					List<HashMap> list = (List)this.baseAction.session.get(Constant.S_LOGINC_PERMISSION);
					if (list != null) {
						for (int i = 0; i < list.size(); i++) {
							Permission pms = this.mapToBean(list.get(i));
							if (pms != null) {
								if (code.equals(pms.getCode())) {
									return pms;
								} else {
									continue;
								}
							}
						}
					}
				}
			}
			if (Constant.PERMISSION_GLOBAL_LIST != null) {
				List<HashMap> list = Constant.PERMISSION_GLOBAL_LIST;
				if (list != null) {
					for (int i = 0; i < list.size(); i++) {
						Permission pms = this.mapToBean(list.get(i));
						if (pms != null) {
							if (code.equals(pms.getCode())) {
								return pms;
							} else {
								continue;
							}
						}
					}
				}
			}			
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, BaseExecutor.class);
			log.debug(error);
			throw e;			
		}
		Permission rpms = new Permission();
		rpms.setDirectName("noAccess.jsp");
		return rpms;
	}
	
	/**
	 * 获取所有配置索引的权限信息
	 * @return
	 * @throws Exception 
	 */
	public void configPermissionIndex()
	{
		try{
		    if (pmsIndex == null)
		    	pmsIndex= new HashMap<String,Object>();
		    else
		    	pmsIndex.clear();
			if (this.baseAction.session.get(Constant.S_LOGINC_PERMISSION) != null) {
				if (this.baseAction.session.get(Constant.S_LOGINC_PERMISSION) instanceof List){
					List<HashMap> list = (List)this.baseAction.session.get(Constant.S_LOGINC_PERMISSION);
					if (list != null) {
						for (int i = 0; i < list.size(); i++) {
							Permission pms = this.mapToBean(list.get(i));
							if (pms != null) {
								if (pms.getIndex() != null && !"".equals(pms.getIndex())) {
									pmsIndex.put(pms.getIndex(), pms);
								} else {
									continue;
								}
							}
						}
					}
				}
			}
			if (Constant.PERMISSION_GLOBAL_LIST != null) {
				List<HashMap> list = Constant.PERMISSION_GLOBAL_LIST;
				if (list != null) {
					for (int i = 0; i < list.size(); i++) {
						Permission pms = this.mapToBean(list.get(i));
						if (pms != null) {
							if (pms.getIndex() != null && !"".equals(pms.getIndex())) {
								pmsIndex.put(pms.getIndex(), pms);
							} else {
								continue;
							}
						}
					}
				}
			}				
			baseAction.setPmsIndex(pmsIndex);
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, BaseExecutor.class);
			log.debug(error);
		}		
	}
	
	/**
	 * 获取当前code的所有直接子权限信息
	 * @param pcode   父权限代码
	 * @return
	 * @throws Exception 
	 */
	public ArrayList<Permission> getSubPermission(String pcode) throws Exception
	{
		ArrayList<Permission> subPermission = new ArrayList<Permission>();
		ArrayList<Permission> allPermission = new ArrayList<Permission>();
		HttpServletRequest request = ServletActionContext.getRequest();
		
		try{
			try{
				long icode = Long.parseLong(pcode);
				if (icode < 0){
					pcode = Constant.PERMISSION_START_CODE;
				}
			}
			catch(Exception e){
				pcode = Constant.PERMISSION_START_CODE;
			}
			List<HashMap> list = null;
			String navigation = "";
			if (this.baseAction.session.get(Constant.S_LOGINC_PERMISSION) != null) {
				if (this.baseAction.session.get(Constant.S_LOGINC_PERMISSION) instanceof List){
					list = (List)this.baseAction.session.get(Constant.S_LOGINC_PERMISSION);
					if (list != null) {
						for (int i = 0; i < list.size(); i++) {
							Permission pms = this.mapToBean(list.get(i));	
							allPermission.add(pms);
							if (pcode.equals(pms.getParentCode())) {
								if (!"0".equals(pms.getType())){
									subPermission.add(pms);
								}
							}
							else{
								continue;
							}
						}
					}
					if (!pcode.equals("0")){
						int len = pcode.length();
						int div = ((int)len/3);
						for (int i=0; i<div; i++){
							String tempCode =  pcode.substring(0,(i+1)*3);
							if (list != null) {
								for (int j = 0; j < list.size(); j++) {
									Permission pms = this.mapToBean(list.get(j));	
									
									if (tempCode.equals(pms.getCode())) {
										if (pms.getParentCode().equals("0")){
											navigation += pms.getName();
										}
										else{
											navigation += " &gt; "+ pms.getName();
										}
									}
									else{
										continue;
									}
								}
							}							
						}
					}					
				}
			}
			//设置全部权限
			baseAction.setAllPermission(allPermission);
			baseAction.setNavigation(navigation);	
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, BaseExecutor.class);
			log.debug(error);
			throw e;			
		}	
		return subPermission;	
	}
	/**
	 * hashmap到实体bean的转换
	 * @param hashMap
	 * @return
	 */
	private Permission mapToBean(HashMap hashMap){
		Permission permission = new Permission();
		permission.setIndex(hashMap.get("pmsIndex")== null?"":hashMap.get("pmsIndex").toString());
		permission.setCode(hashMap.get("pmsCode")== null?"":hashMap.get("pmsCode").toString());
		permission.setParentCode(hashMap.get("pmsParentCode")== null?"":hashMap.get("pmsParentCode").toString());
		permission.setName(hashMap.get("pmsName")== null?"":hashMap.get("pmsName").toString());
		permission.setType(hashMap.get("pmsType")== null?"":hashMap.get("pmsType").toString());
		permission.setIsValid(hashMap.get("pmsIsValid")== null?"":hashMap.get("pmsIsValid").toString());
		permission.setDataSource(hashMap.get("pmsDataSource")== null?"":hashMap.get("pmsDataSource").toString());
		permission.setInitEvent(hashMap.get("pmsInitEvent")== null?"":hashMap.get("pmsInitEvent").toString());
		permission.setDefaultEvent(hashMap.get("pmsDefaultEvent")== null?"":hashMap.get("pmsDefaultEvent").toString());
		permission.setExtendEvent(hashMap.get("pmsExtendEvent")== null?"":hashMap.get("pmsExtendEvent").toString());
		permission.setIcon(hashMap.get("pmsIcon")== null?"":hashMap.get("pmsIcon").toString());
		permission.setDirectName(hashMap.get("pmsDirectFile")== null?"":hashMap.get("pmsDirectFile").toString());
		permission.setIsTransaction(hashMap.get("pmsTransaction")== null?"":hashMap.get("pmsTransaction").toString());
		permission.setImitationStep(hashMap.get("pmsImitationStep")== null?"":hashMap.get("pmsImitationStep").toString());
		permission.setDataHandlerBean(hashMap.get("pmsDataHandlerBean")== null?"":hashMap.get("pmsDataHandlerBean").toString());
		permission.setBeforeExecuteCode(hashMap.get("pmsBeforeExecuteCode")== null?"":hashMap.get("pmsBeforeExecuteCode").toString());
		permission.setAfterExecuteCode(hashMap.get("pmsAfterExecuteCode")== null?"":hashMap.get("pmsAfterExecuteCode").toString());
		return permission;
	}
	
	/**
	 * 页面paramMap内参数处理方法
	 * @param paramMap   页面参数对象
	 * @param flag       0：页面参数 1：数据库记录
	 */
	public void paramDataHandle(HashMap paramMap, String flag) {
		if (dataHandleBean != null && !dataHandleBean.equals("")) {
			String dataBean[] = dataHandleBean.split(",");
			if (dataBean != null && dataBean.length > 0) {
				for (int i = 0; i < dataBean.length; i++) {
					try {
						Object obj = Factory.getInstance().getInstanceNoProxy(dataBean[i]);
						if (obj instanceof AbstractBean) {
							AbstractBean abstractBean = (AbstractBean) obj;
							/** 数据库结果集处理，设置成1 */
							/** 页面数据处理设置成0 */
							abstractBean.setDataType(flag);
							Field[] field = abstractBean.getClass().getDeclaredFields();
							if (field != null && field.length > 0) {
								for (int j = 0; j < field.length; j++) {
									Field f = field[j];
									f.setAccessible(true);
									try {
										if (paramMap.get(f.getName()) != null) {
											try {
												BeanUtils.setProperty(obj, f.getName(), paramMap.get(f.getName()));
												BeanUtils.getProperty(obj, f.getName());
												paramMap.put(f.getName(),BeanUtils.getProperty(obj,f.getName()));
											} catch (InvocationTargetException e) {
												String error = DetailException.expDetail(e,BaseExecutor.class);
												log.debug(error);
											} catch (NoSuchMethodException e) {
												String error = DetailException.expDetail(e,BaseExecutor.class);
												log.debug(error);
											}
										} else {
											continue;
										}
									} catch (IllegalArgumentException e) {
										String error = DetailException.expDetail(e,BaseExecutor.class);
										log.debug(error);
									} catch (IllegalAccessException e) {
										String error = DetailException.expDetail(e,BaseExecutor.class);
										log.debug(error);
									}
								}
							}
						}
					} catch (Exception e) {
						String error = DetailException.expDetail(e,BaseExecutor.class);
						log.debug(error);
					}
				}
			}
		}
	}

	/**
	 * 数据库结果集数据处理，bean对象映射数据处理
	 * 
	 * @param resultList
	 */
	public void resultDataHandle(ResultData resultData) {
		if (resultData.getOne() != null) {
			if (resultData.getOne() instanceof HashMap) {
				HashMap rmap = (HashMap) resultData.getOne();
				paramDataHandle(rmap, "1");
			}
		}
		if (resultData.getList() != null) {
			for (int i = 0; i < resultData.getList().size(); i++) {
				if (resultData.getList().get(i) instanceof HashMap) {
					HashMap rmap = (HashMap) resultData.getList().get(i);
					paramDataHandle(rmap, "1");
				}
			}
		}
	}

	/**
	 * 获取页面提示信息
	 * @param code 权限代码
	 * @param paramMap 对象参数集合
	 * @param actionSupport
	 * @param suffix 名字
	 * @return
	 */
	public String getPromptInfo(String code, HashMap<String, String> paramMap,
			ActionSupport actionSupport, String suffix) {
		String optContent = "";
		String keyInfoArr[] = null;
		String colArr[] = this.getLogColumn(paramMap).split(",");
		if (colArr.length > 0) {
			keyInfoArr = new String[colArr.length];
		}
		for (int i = 0; i < colArr.length; i++) {
			if (paramMap.get(colArr[i]) != null) {
				keyInfoArr[i] = paramMap.get(colArr[i]) == null ? "" : paramMap
						.get(colArr[i]).toString();
			}
		}
		optContent = actionSupport.getText(this.code + suffix, keyInfoArr);
		return optContent;
	}

	/**
	 * 获得日志记录字段
	 * 
	 * @return
	 */

	public String getLogColumn(HashMap paramMap) {
		if (paramMap != null)
			this.logColumn = paramMap.get(Constant.LOG_COLUMN) == null ? ""
					: paramMap.get(Constant.LOG_COLUMN).toString();
		return this.logColumn;
	}

	public SqlSession getSqlSession() {
		return sqlSession;
	}

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public ResultData getResultData() {
		return resultData;
	}

	public void setResultData(ResultData resultData) {
		this.resultData = resultData;
	}

	public String getDataHandleBean() {
		return dataHandleBean;
	}

	public void setDataHandleBean(String dataHandleBean) {
		this.dataHandleBean = dataHandleBean;
	}

	public BaseAction getBaseAction() {
		return baseAction;
	}

	public void setBaseAction(BaseAction baseAction) {
		this.baseAction = baseAction;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Permission getPermission() {
		return permission;
	}

	public void setPermission(Permission permission) {
		this.permission = permission;
	}

	public String getDsname() {
		return dsname;
	}

	public void setDsname(String dsname) {
		this.dsname = dsname;
	}

	public String getLogColumn() {
		return logColumn;
	}

	public void setLogColumn(String logColumn) {
		this.logColumn = logColumn;
	}

	public String getIstransaction() {
		return istransaction;
	}

	public void setIstransaction(String istransaction) {
		this.istransaction = istransaction;
	}

	public ExecutorResult getExecutorResult() {
		return executorResult;
	}

	public void setExecutorResult(ExecutorResult executorResult) {
		this.executorResult = executorResult;
	}

	public PaginatedData getPaginatedData() {
		return paginatedData;
	}

	public void setPaginatedData(PaginatedData paginatedData) {
		this.paginatedData = paginatedData;
	}
	
}
