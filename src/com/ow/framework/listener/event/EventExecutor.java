package com.ow.framework.listener.event;

import java.util.Iterator;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.BaseAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.proxy.Factory;



public class EventExecutor extends BaseExecutor implements Executor  {
	
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private static String SQL_ID = "sqlid";
	private static String MAPPER_KEY = "mapperkey";
	private static String CONSTANT = "constant";
	
	public EventExecutor(BaseAction baseAction) throws Exception {
		super(baseAction);
	}
	public EventExecutor(BaseAction baseAction,String code) throws Exception {
		super(baseAction,code);
	}
    /**多sqlid存放对象数组*/
	private String sqlidArr [] = null;
	private String jsonParam = null;

	public String[] getSqlidArr() {
		return sqlidArr;
	}
	public void setSqlidArr(String[] sqlidArr) {
		this.sqlidArr = sqlidArr;
	}
	
	
	public String getJsonParam() {
		return jsonParam;
	}
	public void setJsonParam(String jsonParam) {
		this.jsonParam = jsonParam;
	}
	/**
	 * 初始化执行器
	 */
	public void initEventExecutor()
	{
		String ininEvent = "";
		try{
			if (this.getPermission() != null){
				ininEvent = this.getPermission().getInitEvent() == null ? "":this.getPermission().getInitEvent();
			}
			if (!ininEvent.equals(""))
			{
				//初始化设置sqlsession
				super.initSqlSession();	
				String event [] = this.getPermission().getInitEvent().trim().split("\\|");
				if (event != null && event.length > 0)
				{
					for (int i=0; i<event.length; i++)
					{
						String paramStr = event[i].trim();
						int indx = paramStr.indexOf("{");
						/**只有indx大于0，才认为是合法的值*/
						if (indx > 0)
						{
							/**类路径名称*/
							String clsname = paramStr.substring(0, indx);
							String param = paramStr.substring(indx,paramStr.length());
							//设置json格式参数 ，提供给子类使用
							setJsonParam(param);
							JSONArray jsonArray = null;
							try
							{
								jsonArray = JSONArray.fromObject("["+param+"]");
							}
							catch(Exception e){
								System.out.println(e.getMessage());
							}
							if (jsonArray == null){
								continue;
							}
							for (int s=0;s<jsonArray.size();s++){
					    		JSONObject  jsonObject =(JSONObject)jsonArray.toArray()[s];
					    		//sqlid
					    		JSONArray sqlid = null;
					    		//查询结果存储对象
					    		String mapperkey = null;
					    		JSONArray jsonArrayConst = null;
					    		try{
					    			sqlid = jsonObject.getJSONArray(this.SQL_ID);
					    			if (sqlid != null){
					    				sqlidArr = new String[sqlid.size()];
							    		for (int j=0; j<sqlid.size();j++){
							    			Object obj = sqlid.get(j);
							    			if (obj != null){
							    				sqlidArr[j] = obj.toString();
							    			}
							    		}
					    			}
					        	}
					        	catch(Exception e){
					        		Object obj = jsonObject.get(this.SQL_ID);
					        		if (obj != null){
					        			sqlidArr = new String[]{obj.toString()};
					        		}
					        	}
					        	try{
					    			mapperkey = jsonObject.get(this.MAPPER_KEY) == null?"" : jsonObject.get(this.MAPPER_KEY).toString();
					        	}
					        	catch(Exception e){
					        		System.out.println("[mapperkey] config error:"+e.getMessage());
					        	}
					        	try{
					    			jsonArrayConst = jsonObject.getJSONArray(this.CONSTANT);
					    			if (jsonArrayConst != null){
							    		for (int j=0; j<jsonArrayConst.size();j++){
							    			JSONObject  jsonObjectConst =(JSONObject)jsonArrayConst.toArray()[j];
							    			Iterator ite =  jsonObjectConst.keys();
							    			while(ite.hasNext()){
							    				String key = (String)ite.next();
							    				String value = (String)jsonObjectConst.get(key);
							    				//获取常量参数，并放到paramMap对象中
							    				super.getBaseAction().getParamMap().put(key, value);
							    			}
							    		}
					    			}
					        	}
					        	catch(Exception e){
					        	}
	
								try {
									Object obj = Factory.getInstance().getInstanceByProxy(clsname.trim());
									if (obj instanceof EventListener)
									{
										ResultData resultData = ((EventListener)obj).event(this);
										/**结果集合处理*/
										if (resultData != null)
										{
											this.resultDataHandle(resultData);
											if (resultData.getList() != null){
												/**存放结果到initMap对象提供给页面*/
												this.getBaseAction().getInitMap().put(mapperkey,resultData.getList());
											}
											if (resultData.getOne() != null){
												/**存放结果到initMap对象提供给页面*/
												this.getBaseAction().getInitMap().put(mapperkey,resultData.getOne());
											}
											if (resultData.getContent() != null){
												/**存放结果到initMap对象提供给页面*/
												this.getBaseAction().getInitMap().put(mapperkey,resultData.getContent());
											}	
											if (resultData.getPaginatedData() != null){
												String contextName  = "paginated";
												if (resultData.getPaginatedData().getContextName() != null)
													contextName = resultData.getPaginatedData().getContextName();
												/**存放结果到initMap对象提供给页面*/
												this.getBaseAction().getInitMap().put(contextName,resultData.getPaginatedData());
											}
											/**存放结果到执行器结果存放对象*/
											this.getExecutorResult().putResultData(resultData);
										}		
									}		
								} catch (Exception e) {
									/**出现异常设置执行器执行失败*/
									this.getExecutorResult().setResult("0");
									String error = DetailException.expDetail(e, EventExecutor.class);
									log.debug(error);
									throw e;
								}					    		
					    	}
						}
						else{
							try {
								Object obj = Factory.getInstance().getInstanceByProxy(paramStr.trim());
								if (obj instanceof EventListener)
								{
									ResultData resultData = ((EventListener)obj).event(this);
									/**存放结果到执行器结果存放对象*/
									this.getExecutorResult().putResultData(resultData);									
								}
							} catch (Exception e) {
								/**出现异常设置执行器执行失败*/
								this.getExecutorResult().setResult("0");
								String error = DetailException.expDetail(e, EventExecutor.class);
								log.debug(error);
								throw e;
							}	
						}
					}
				}
			}	
		}
		catch (Exception e)
		{
			/**出现异常设置执行器执行失败*/
			this.getExecutorResult().setResult("0");
			String error = DetailException.expDetail(e, EventExecutor.class);
			log.debug(error);
		}	
		finally{
			if (!ininEvent.equals("")){
				//关闭连接
				super.getSqlSession().close();			
			}
		}
		//登录后重新设置子权限信息
		try {
			this.getBaseAction().setSubPermission(this.getSubPermission(this.getCode()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
    
	/**
	 * 通用事件执行器
	 * @return
	 */
	public ExecutorResult  generalEventExecutor()
	{
		String generalEnevt = "";
		try{
			if (this.getPermission() != null)
			{
				generalEnevt = this.getPermission().getDefaultEvent() == null?"":this.getPermission().getDefaultEvent();
				if (generalEnevt.equals("")){
					generalEnevt = this.getPermission().getExtendEvent() == null?"":this.getPermission().getExtendEvent();
				}
			}
			if (!generalEnevt.equals(""))
			{
				//初始化设置sqlsession
				super.initSqlSession();				
				boolean isexe = false;
				//多个不通实现类之间用竖线分割
				String event [] = generalEnevt.trim().split("\\|");
				ResultData resultData = null;
				if (event != null && event.length > 0)
				{
					for (int i=0; i<event.length; i++)
					{
						if(event[i] == null)
							continue;
						int indxl = event[i].indexOf("{");
						Object obj = null;
						/**只有indxl大于0，才认为是合法的值*/
						if (indxl > 0)
						{
							isexe = true;
							/**类路径名称*/
							String clsname = event[i].substring(0, indxl).trim();
							//参数信息
							String param = event[i].substring(indxl,event[i].length());
							//设置json格式参数 ，提供给子类使用
							setJsonParam(param);
							
							JSONArray jsonArray = null;
							try {
								jsonArray = JSONArray.fromObject("["+param+"]");
							} catch (Exception e) {
								System.out.println(e.getMessage());
							}
							
							for (int s=0;s<jsonArray.size();s++){
					    		JSONObject  jsonObject =(JSONObject)jsonArray.toArray()[s];
					    		//sqlid
					    		JSONArray sqlid = null;
					    		//查询结果存储对象
					    		String mapperkey = null;
					    		JSONArray jsonArrayConst = null;
					    		try{
					    			sqlid = jsonObject.getJSONArray(this.SQL_ID);
					    			if (sqlid != null){
					    				sqlidArr = new String[sqlid.size()];
							    		for (int j=0; j<sqlid.size();j++){
							    			Object objTemp = sqlid.get(j);
							    			if (objTemp != null){
							    				sqlidArr[j] = objTemp.toString();
							    			}
							    		}
					    			}
					        	}
					        	catch(Exception e){
					        		Object objTemp = jsonObject.get(this.SQL_ID);
					        		if (objTemp != null){
					        			sqlidArr = new String[]{objTemp.toString()};
					        		}
					        	}
					        	try{
					    			jsonArrayConst = jsonObject.getJSONArray(this.CONSTANT);
						        	//读取常量参数
					    			if (jsonArrayConst != null){
							    		for (int j=0; j<jsonArrayConst.size();j++){
							    			JSONObject  jsonObjectConst =(JSONObject)jsonArrayConst.toArray()[j];
							    			Iterator ite =  jsonObjectConst.keys();
							    			while(ite.hasNext()){
							    				String key = (String)ite.next();
							    				String value = (String)jsonObjectConst.get(key);
							    				//获取常量参数，并放到paramMap对象中
							    				super.getBaseAction().getParamMap().put(key, value);
							    			}
							    		}	
					    			}
					        	}
					        	catch(Exception e){
					        		//System.out.println("[constant] config error" + e.getMessage());
					        	}

								try {
									obj = Factory.getInstance().getInstanceByProxy(clsname.trim());
								} catch (Exception e) {
									/**出现异常设置执行器执行失败*/
									this.getExecutorResult().setResult("0");
									String error = DetailException.expDetail(e, EventExecutor.class);
									log.debug(error);
									throw e;
								}					    		
					    	}		
						}
						else if (event[i].length() > 0){
							isexe = true;
							//没有参数的执行类
							obj = Factory.getInstance().getInstanceByProxy(event[i]);							
						}
						//执行具体时间，并设置返回结果
						if (obj instanceof EventListener)
						{
							resultData = ((EventListener)obj).event(this);
							/**结果集合处理*/
							if (resultData != null){
								this.resultDataHandle(resultData);
							}
							/**执行结果存放到执行器结果存储对象*/
							this.getExecutorResult().putResultData(resultData);
						}						
					}
					if (resultData != null){
						/**设置执行器执行成功*/
						this.getExecutorResult().setResult(String.valueOf(resultData.getIntResult()));
					}
					else{
						this.getExecutorResult().setResult("0");
					}
				}
				if (!isexe)
				{
					log.info("INFO [Framework] defaultEvent is null");	
					System.err.print("INFO [Framework] defaultEvent is null");
				}
			}
			else
			{
				log.info("Framework config:defaultEvent is null");	
				System.err.print("INFO [Framework] defaultEvent is null");
			}
			/**判断是否启动事物，若是事物则进行事物提交*/
			if (super.getIstransaction() != null && (super.getIstransaction().equals("1") || super.getIstransaction().equals("true"))) {
				super.getSqlSession().commit();
			}			
		}
		catch (Exception e)
		{
			/**出现异常设置执行器执行失败*/
			if (e.getMessage() != null && e.getMessage().toLowerCase() != null && (e.getMessage().toLowerCase().indexOf("ora-00001") > -1
				|| e.getMessage().toLowerCase().indexOf("duplicate") > -1
				|| e.getMessage().toLowerCase().indexOf("unique key") > -1 
				|| e.getMessage().toLowerCase().indexOf("unique constraint") > -1)){
				this.getExecutorResult().setResult("2");
			}
			else{
				this.getExecutorResult().setResult("0");
			}
			String error = DetailException.expDetail(e, EventExecutor.class);
			log.debug(error);
		}
		finally{
			if (!generalEnevt.equals("")){
				//关闭连接
				super.getSqlSession().close();	
			}
		}		
		//登录后重新设置子权限信息
		try {
			this.getBaseAction().setSubPermission(this.getSubPermission(this.getCode()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}			
		return this.getExecutorResult();		
	}
	
	/**
	 * 根据索引顺序，获取sqlid
	 * @param index
	 * @return
	 */
    public String getSqlidByIndex(int index)
    {
    	String sqlid = "";
    	if (sqlidArr != null)
    	{
    		try{
    			sqlid = sqlidArr[index];
    		}
    		catch (Exception e)
    		{
    			sqlid = "";
    		}
    	}
    	return sqlid.trim();
    }
}
