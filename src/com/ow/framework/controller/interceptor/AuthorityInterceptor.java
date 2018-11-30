package com.ow.framework.controller.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.IAction;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class AuthorityInterceptor extends AbstractInterceptor
{
    /**
	 *  Action拦截器
	 */
	private static final long serialVersionUID = -1725268388381071432L;
	private static String encoding = "utf-8";
	private static String contentType = "text/html;charset=utf-8";

	public String intercept(ActionInvocation invocation) throws Exception
	{
		/**系统编码转换*/
		HttpServletResponse response = null;  
		HttpServletRequest request = null;
		response = ServletActionContext.getResponse();  
		request = ServletActionContext.getRequest();
		request.setCharacterEncoding(encoding);    
		response.setContentType(contentType);
		ActionContext ctx = invocation.getInvocationContext();
		Map session = ctx.getSession();
		Object obj = session.get(Constant.S_USER_LOGIN_ACCOUNT);
		if (obj != null)
		{
			return invocation.invoke();
		}
		return IAction.LOGINOUT;
    }
}

