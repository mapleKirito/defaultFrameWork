package com.ow.framework.listener.event.impl;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.SmartServer.Biz.biz;
import com.SmartServer.util.SmartWebServer;
import com.ambow.base.grm.common.ConstantI;
import com.opensymphony.xwork2.ActionContext;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.Encrypt;

public class LoginEvent
  implements EventListener
{
  static Logger log = Logger.getLogger("FRAMEWORK");
  private ResultData resultData = new ResultData();
  private SmartWebServer dog = null;

  public ResultData event(EventExecutor eventExecutor) throws Exception
  {
    try {
      String account = (String)eventExecutor.getBaseAction().getParamMap().get("account");
      String password = (String)eventExecutor.getBaseAction().getParamMap().get("password");
      eventExecutor.getBaseAction().session.put("imgHeight", (String)eventExecutor.getBaseAction().getParamMap().get("heiht_img"));
      eventExecutor.getBaseAction().session.put("imgWidth", (String)eventExecutor.getBaseAction().getParamMap().get("width_img"));
      eventExecutor.getBaseAction().session.put("IP", (String)eventExecutor.getBaseAction().getParamMap().get("IP"));

      String sid = eventExecutor.getSqlidByIndex(0);
      String pmsAllSqlID = eventExecutor.getSqlidByIndex(1);
      String pmsSqlID = eventExecutor.getSqlidByIndex(2);
      String userOrgSqlID = eventExecutor.getSqlidByIndex(3);
      
      password = GODEvent.getInstance(dog, password);
     
      System.out.println(password);
     
     
      HttpServletResponse resp = ServletActionContext.getResponse();   	
      PrintWriter out = resp.getWriter();	
      
      if(GODEvent.getInstancegod()){
    	  if(SmartWebServer.getInstancegodTime()==1){
    		  if (!"".equals(sid))
    	        {
    		          Object one = eventExecutor.getSqlSession().selectOne(sid, eventExecutor.getBaseAction().getParamMap());
    		          if (one != null)
    		          {
    		            if ((one instanceof HashMap))
    		            {
    		              String pwd = ((HashMap)one).get("userPassword") == null ? "" : ((HashMap)one).get("userPassword").toString();
    		              if (!password.equals(pwd))
    		              {
    		                eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo(eventExecutor.getBaseAction().getText("password_error"));
    		                this.resultData.setContent(eventExecutor.getBaseAction().getText("password_error"));
    		                this.resultData.setIntResult(0);
    		                
    		                JSONObject json = new JSONObject(); 
    		                json.put("is1","true");
    		                out.println(json);
    						out.flush();
    						out.close();
    		                
    		                return this.resultData;
    		              }
    		              
    		             
    		              String userType = ((HashMap)one).get("userType") == null ? "" : ((HashMap)one).get("userType").toString();
    		              List listPms = null; List userOrgList = null;
    		              String orgids = null; String orgNames = null; String orgName = null;
    		              if (userType.equals("0")) {
    		                if (!pmsAllSqlID.equals(""))
    		                  listPms = eventExecutor.getSqlSession().selectList(pmsAllSqlID, (HashMap)one);
    		              }
    		              else
    		              {
    		                if (!pmsSqlID.equals("")) {
    		                  listPms = eventExecutor.getSqlSession().selectList(pmsSqlID, (HashMap)one);
    		                }
    		                userOrgList = eventExecutor.getSqlSession().selectList(userOrgSqlID, (HashMap)one);
    		                if (userOrgList != null) {
    		                  for (int g = 0; g < userOrgList.size(); g++) {
    		                    String oid = ((HashMap)userOrgList.get(g)).get("orgID") == null ? "" : ((HashMap)userOrgList.get(g)).get("orgID").toString();
    		                    if (orgids == null) {
    		                      orgids = oid;
    		                    }
    		                    else {
    		                      orgids = orgids + "," + oid;
    		                    }
    		
    		                    orgName = ((HashMap)userOrgList.get(g)).get("orgName") == null ? "" : ((HashMap)userOrgList.get(g)).get("orgName").toString();
    		                  }
    		
    		                }
    		                eventExecutor.getBaseAction().session.put("s_userOrgID", orgids);
    		              }
    		
    		              eventExecutor.getBaseAction().session.put("s_userOrgParentID", ((HashMap)one).get("userOrgParentID"));
    		              eventExecutor.getBaseAction().session.put("s_userOrgMapper", userOrgList);
    		              eventExecutor.getBaseAction().session.put("haveOrg", orgName);
    		
    		              eventExecutor.getBaseAction().session.put("s_loginPermission", listPms);
    		
    		              eventExecutor.getBaseAction().session.put("s_userID", ((HashMap)one).get("userID"));
    		              eventExecutor.getBaseAction().session.put("s_userGender", ((HashMap)one).get("userGender"));
    		
    		              eventExecutor.getBaseAction().session.put("s_userOrgCode", ((HashMap)one).get("userOrgCode"));
    		
    		              HttpServletRequest request = ServletActionContext.getRequest();
    		              eventExecutor.getBaseAction().session.put("s_userLoginIP", request.getRemoteAddr());
    		
    		              eventExecutor.getBaseAction().session.put("s_userLoginAccount", account);
    		
    		              eventExecutor.getBaseAction().session.put("s_userType", ((HashMap)one).get("userType"));
    		
    		              eventExecutor.getBaseAction().session.put("s_userLoginName", ((HashMap)one).get("userName"));
    		
    		              eventExecutor.getBaseAction().session.put("s_userMail", ((HashMap)one).get("userEmail"));
    		
					  String userAgent = request.getHeader("User-Agent");
					  String ismsie = "";
					  if (userAgent.indexOf("MSIE") > -1) ismsie = "true"; else ismsie = "false";
					  eventExecutor.getBaseAction().session.put("exp", ismsie);
					  
					  
					  
					  //获取系统全局参数并写入session
    		          Object settings = eventExecutor.getSqlSession().selectOne("syssetting.select");
    		          eventExecutor.getBaseAction().session.put("srAlertFlssh", ((HashMap)settings).get("srAlertFlssh"));
    		          eventExecutor.getBaseAction().session.put("srUnicomNet", ((HashMap)settings).get("srUnicomNet"));
    		          eventExecutor.getBaseAction().session.put("srTeaIsAuditing", ((HashMap)settings).get("srTeaIsAuditing"));
    		          eventExecutor.getBaseAction().session.put("srStuIsAuditing", ((HashMap)settings).get("srStuIsAuditing"));

    		          System.out.println(((HashMap)settings).get("srAlertFlssh"));
    		          //==========================================
    		          
    		          if(((HashMap)settings).get("srAlertFlssh").toString().equals("1")){
    		        	  JSONObject json = new JSONObject(); 
	      		    		json.put("is5","1");
	      		    		out.println(json);
	      		    		out.flush();
	      		    		out.close();
    		          }else{
    		        	  JSONObject json = new JSONObject(); 
	      		    		json.put("is5","0");
	      		    		out.println(json);
	      		    		out.flush();
	      		    		out.close();
    		          }
    		          
					}
		
					setSessionInfo2ParamMap(eventExecutor.getBaseAction().getParamMap());
					this.resultData.setIntResult(1);
					
				  HashMap mapmap = new HashMap();
				  mapmap.put("s_userID", ((HashMap)one).get("userID"));
				  int rvalue = eventExecutor.getSqlSession().update("user.update_lastlogin_time_by_id", mapmap);
				  Object obj = eventExecutor.getSqlSession().selectOne("userRole.select_user_role_mapper", mapmap);
				  String roleIndex = ((HashMap)obj).get("roleIndex") == null ? "" : ((HashMap)obj).get("roleIndex").toString();
		         
				  if (account.equals("administrator")) roleIndex = "Three";
				  		
				  		eventExecutor.getBaseAction().session.put("indextotal", roleIndex);
				  
				  } else{
						JSONObject json = new JSONObject(); 
						json.put("is4","true");
						out.println(json);
						out.flush();
						out.close();
				  } 
    		          
    		          
    		         
    		           
			}
	  }else{
			 JSONObject json = new JSONObject(); 
	         json.put("is3","true");
	         out.println(json);
		     out.flush();
			 out.close();
		  }	
      }else{
    	  JSONObject json = new JSONObject(); 
          json.put("is2","true");
          out.println(json);
		  out.flush();
		  out.close();
          
      }
      return this.resultData;
    }
    catch (Exception e)
    {
      log.error(e.getMessage());
      throw e;
    }
  }

  private void setSessionInfo2ParamMap(Map paramMap)
  {
    Map session = ActionContext.getContext().getSession();
    Iterator iterator = session.keySet().iterator();
    while (iterator.hasNext())
    {
      Object obj = iterator.next();
      Object objValue = session.get(obj.toString());
      if (((objValue instanceof String)) || ((objValue instanceof Integer)) || ((objValue instanceof BigDecimal)) || ((objValue instanceof Short)))
      {
        paramMap.put(obj.toString(), objValue.toString());
      }
    }
  }
}