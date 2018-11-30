package com.ow.framework.controller.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.ow.framework.common.Constant;
import com.ow.framework.data.handler.config.Permission;
import com.ow.framework.data.handler.config.PermissionConfig;
import com.ow.framework.data.po.PromptInfo;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.Executor;
import com.ow.framework.proxy.Factory;
import com.ow.framework.util.DateUtil;

public abstract class BaseAction extends ActionSupport implements IAction{

	private static final long serialVersionUID = -712070397964873089L;
    /**系统权限代码，触发事件的代码*/
    private String code;
    /**进入操作页面类型，1:代表从左边菜单点击进入 0:其他无实际意义*/
    private String type; 
    /*下拉树主键*/
    private String id; 
    private String rootSign;  
    /**查询参数设置对象*/
    private HashMap<String,String> searchMap = new HashMap<String,String>();    
    /**页面参数存储对象*/
    private HashMap<String,String> paramMap = new HashMap<String,String>();
	/**页面跳转前，处理初始化页面信息存储对象*/
    private HashMap<String,Object> initMap = new HashMap<String,Object>();
    /**通过配置的索引值获取任意一个权限代码对应的数值*/
    private HashMap<String,Object> pmsIndex = new HashMap<String,Object>();
    /**servlet context 对象*/
    public ActionContext ctx;
    /**servlet session 对象*/
	public Map session;
	/**事件处理器*/
	public Executor eventExecutor;
	/**页面提示信息*/
	private PromptInfo promptInfo = new PromptInfo(); 
	/**页面跳转目标文件*/
	private String directFile;
	/**当前code对应的所有直接子权限*/
	private ArrayList<Permission> subPermission;
	/**所有权限*/
	private ArrayList<Permission> allPermission;
    /**目标跳转步骤*/
    private String imitateStep;
    /**翻页默认每页页面显示记录数*/
    private String pageSize = "8";
    /**翻页时当前页数*/
    private String currentPage = "0";
    /**是否是模拟跳转*/
    private String imitateBack = "0";
    /**导航描述信息*/
    private String navigation;
    /**业务导航信息*/
    private String bussessNavigation;
    /**属性结构中的path 描述*/
    private String path;

	/**log 日志对象*/
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	/**系统根目录*/
	private static String systemPath;
	//将是否是小窗口的标志放到session中，在页面中进行判断是否更改全局的位置信息
    
	public String execute()
	{
		try
		{
			/**获取系统根目录*/
			HttpServletRequest request = ServletActionContext.getRequest();   
			systemPath = request.getSession().getServletContext().getRealPath("/");
			if (systemPath == null)
				systemPath = request.getSession().getServletContext().getResource("/").toString();
			/**在paramMap中加入一个系统时间*/
			getParamMap().put("currentDate", DateUtil.dateToStringWithTime());
			if (id != null){
				getParamMap().put("id", id);
			}
		    /**servlet context 对象*/
		    ctx = ActionContext.getContext();
		    /**servlet session 对象*/
			session = ctx.getSession();	
			//request.getSession().setAttribute("isOpen", getParamMap().get("isOpen"));
			/***********************************************************/
			/**只有在type等于空的情况下，根据code，获取跳页值,否者清空跳页值***/
			/***********************************************************/
			if (type == null){
				if (currentPage != null){
					try{
						//大于0说面点翻页，否者currentPage等于0
						if (Integer.parseInt(currentPage) > 0){
							session.put(code, currentPage);
						}
						else{
							if (session.get(code) != null){
								currentPage = "1";
							}
						}
					}
					catch(Exception e){}
				}
			}
			else{
				Iterator ite = session.keySet().iterator();
				while (ite.hasNext())
				{
					Object obj = ite.next();
					Object objValue = session.get(obj.toString());
					if (objValue instanceof String)
					{
						if (obj.toString().indexOf(code) > -1){
							session.remove(obj.toString());
						}
					}
				}				
				
			}
			
			/***********************************************************/
			/**获取session种的对象到paramMap参数对象中*/
			/***********************************************************/
			Iterator iterator = session.keySet().iterator();
			while (iterator.hasNext())
			{
				Object obj = iterator.next();
				Object objValue = session.get(obj.toString());
				
				if (objValue instanceof String || objValue instanceof Integer || objValue instanceof BigDecimal || objValue instanceof Short)
				{
					paramMap.put(obj.toString(), objValue.toString());
				}
			}
			/***********************************************************/
			/**获取searchMap中的所有需要检索的条件值到paramMap参数对象中*/
			/***********************************************************/
			if(!searchMap.isEmpty()){
				Iterator searchMapIter = searchMap.keySet().iterator();
				while (searchMapIter.hasNext())
				{
					Object obj = searchMapIter.next();
					Object objValue = searchMap.get(obj.toString());
					if (objValue instanceof String || objValue instanceof Integer)
					{
						paramMap.put(obj.toString(), objValue.toString());
					}
				}
			}

			try{
				/**事件执行器初始化*/
				eventExecutor = (Executor) Factory.getInstance().getInstanceProxyByParam(EventExecutor.class.getName(), new Object[]{this});
			}
			catch(Exception e){
				System.err.print(e.getMessage());			
			}
			/**执行监听事件*/
			return subExecute();				
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e,  PermissionConfig.class);
			log.error(error);
			return ActionSupport.ERROR;
		}
	}
	
	/**
	 * 子类实现的方法
	 * @return
	 */
	public abstract String subExecute ()throws Exception;
	

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public HashMap<String,String> getSearchMap() {
		return searchMap;
	}

	public void setSearchMap(HashMap<String,String> searchMap) {
		this.searchMap = searchMap;
	}



	public HashMap<String, String> getParamMap() {
		return paramMap;
	}

	public void setParamMap(HashMap<String, String> paramMap) {
		this.paramMap = paramMap;
	}

	public HashMap<String,Object> getInitMap() {
		return initMap;
	}

	public void setInitMap(HashMap<String,Object> initMap) {
		this.initMap = initMap;
	}

	public PromptInfo getPromptInfo() {
		return promptInfo;
	}

	public void setPromptInfo(PromptInfo promptInfo) {
		this.promptInfo = promptInfo;
	}
	public String getDirectFile() {
		return directFile;
	}

	public void setDirectFile(String directFile) {
		this.directFile = directFile;
	}

	public ArrayList<Permission> getSubPermission() {
		return subPermission;
	}

	public void setSubPermission(ArrayList<Permission> subPermission) {
		this.subPermission = subPermission;
	}

	
	
	public String getImitateStep() {
		return imitateStep;
	}

	public void setImitateStep(String imitateStep) {
		this.imitateStep = imitateStep;
	}

	public String getPageSize() {
		if (pageSize.equals("0"))
			pageSize = "8";		
		return pageSize;
	}

	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}

	public String getCurrentPage() {
		if (currentPage.equals("0"))
			currentPage = "1";
		return currentPage;
	}

	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}

	public HashMap<String, Object> getPmsIndex() {
		return pmsIndex;
	}

	public void setPmsIndex(HashMap<String, Object> pmsIndex) {
		this.pmsIndex = pmsIndex;
	}

	public String getImitateBack() {
		return imitateBack;
	}

	public void setImitateBack(String imitateBack) {
		this.imitateBack = imitateBack;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSystemPath() {
		return systemPath;
	}

	public void setSystemPath(String systemPath) {
		this.systemPath = systemPath;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public ArrayList<Permission> getAllPermission() {
		return allPermission;
	}

	public void setAllPermission(ArrayList<Permission> allPermission) {
		this.allPermission = allPermission;
	}

	public String getNavigation() {
		return navigation;
	}

	public void setNavigation(String navigation) {
		this.navigation = navigation;
	}

	public String getBussessNavigation() {
		return bussessNavigation;
	}

	public void setBussessNavigation(String bussessNavigation) {
		this.bussessNavigation = bussessNavigation;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getRootSign() {
		return rootSign;
	}

	public void setRootSign(String rootSign) {
		this.rootSign = rootSign;
	}


	
}
