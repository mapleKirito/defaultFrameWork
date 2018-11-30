package com.ow.framework.controller.interceptor;

import java.util.HashMap;
import java.util.Iterator;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class EncodingInterceptor  extends AbstractInterceptor{

	/**
	 * 暂时没用
	 */
	private static final long serialVersionUID = -4509573407830500221L;
	private HashMap<String, String> paramKey; 
	
	public String intercept(ActionInvocation invocation) throws Exception {
        Iterator ite = paramKey.keySet().iterator();
        while (ite.hasNext()) {
            Object obj = ite.next();
            Object objValue = paramKey.get(obj.toString());
            if (objValue instanceof String || objValue instanceof Integer) {
            	paramKey.put(obj.toString(), new String(objValue.toString().getBytes("GBK"),"UTF-8"));
            }
        }
		return invocation.invoke();
	}
	public HashMap<String, String> getParamKey() {
		return paramKey;
	}
	public void setParamKey(HashMap<String, String> paramKey) {
		this.paramKey = paramKey;
	}

}
