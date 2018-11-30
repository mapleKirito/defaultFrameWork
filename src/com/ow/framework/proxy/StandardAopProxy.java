package com.ow.framework.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.ow.framework.controller.action.BaseAction;
import com.ow.framework.data.handler.config.Permission;
import com.ow.framework.data.po.PromptInfo;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.Executor;

/**
 * 
 * @author sunny
 * 
 */
public class StandardAopProxy implements InvocationHandler, AopProxy {
	static Logger log = Logger.getLogger("PLATFORM");
	public static Pattern pattern = Pattern.compile("generalEventExecutor");
	public static Pattern initPattern = Pattern.compile("initEventExecutor");
	private Object proxyObj;

	/**
	 * 把执行类绑定动态代理
	 * 
	 * @param obj
	 *            被调用的类
	 * @return
	 * @throws Exception
	 */
	public Object bind(Object obj) throws Exception {
		try {
			synchronized (obj) {
				proxyObj = obj;
				return (Proxy.newProxyInstance(obj.getClass().getClassLoader(),obj.getClass().getInterfaces(), this));
			}

		} catch (IllegalArgumentException e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * AOP内部调用类事件，被绑定类里面所有方法执行，都需要通过它 所以我们可以在invoke前后执行一些外部配置的事件
	 * 
	 * @param proxy
	 *            代理对象
	 * @param method
	 *            执行方法
	 * @param args
	 *            执行参数
	 * @return
	 * @throws OperationNotPermitException
	 * @throws Exception
	 */
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Exception {
		Matcher defaultMatch = pattern.matcher(method.getName());
		Matcher initMatch = initPattern.matcher(method.getName());
		boolean isDefaultExecute = defaultMatch.find();
		boolean isInitExecute = initMatch.find();
		Executor target = null;
		BaseAction ba = null;
		Executor aspectObj = null;
		String[] beforeCodes = null;
		String[] afterCodes = null;
		Permission per = null;
		Object result = null;
		try {
			if (isDefaultExecute || isInitExecute) {
				target =   (Executor) proxy;
				per = target.getPermission();
				beforeCodes = per.getBeforeExecuteCode() == null ? new String[0] : per.getBeforeExecuteCode().split(",");
				afterCodes = per.getAfterExecuteCode() == null ? new String[0] : per.getAfterExecuteCode().split(",");
				aspectObj = null;
				ba = target.getBaseAction();
				/** 加载配置文件内的国际化内容 */
				String totalDesc = target.getPromptInfo(target.getCode(), ba.getParamMap(), ba, "_total_desc");
				String contentDesc = target.getPromptInfo(target.getCode(), ba.getParamMap(), ba, "_content_desc");
				String helpDesc = target.getPromptInfo(target.getCode(), ba.getParamMap(), ba, "_help_desc");
				ba.getPromptInfo().setTotalDescInfo(totalDesc);
				ba.getPromptInfo().setContentDescInfo(contentDesc);
				ba.getPromptInfo().setHelpDescInfo(helpDesc);
				//前执行配置code
				for (int i = 0; i < beforeCodes.length; i++) {
					if (beforeCodes[i] == null || beforeCodes[i].equals("")){
						continue;
					}
					aspectObj = new EventExecutor(ba, beforeCodes[i]);
					((EventExecutor) aspectObj).generalEventExecutor();

				}				
			}
			try{
				result = method.invoke(proxyObj, args);
			}
			catch (Exception ex){
				if (ex.getMessage() == null){
					throw new Exception(ex.getCause().getMessage());
				}
				else{
					throw new Exception(ex.getMessage());
				}
			}
			if (isDefaultExecute) {
				/** 加载配置文件内的国际化内容 */
				String optContent = "";
				if (target.getExecutorResult().getResult() != null &&
						target.getExecutorResult().getResult().equals("1")) {
					optContent = target.getPromptInfo(ba.getCode(), ba
							.getParamMap(), ba, "_succ");
				}
				else if (target.getExecutorResult().getResult() != null &&
						target.getExecutorResult().getResult().equals("0")) {
					optContent = target.getPromptInfo(ba.getCode(), ba
							.getParamMap(), ba, "_fail");
				}
				else if (target.getExecutorResult().getResult() != null &&
						target.getExecutorResult().getResult().equals("2")) {
					optContent = target.getPromptInfo(ba.getCode(), ba
							.getParamMap(), ba, "_rep");
				}				
				if(ba.getPromptInfo().getResultDescInfo()==null||ba.getPromptInfo().equals("")){
					ba.getPromptInfo().setResultDescInfo(optContent);
				}
				ba.getParamMap().put("OL_Content", optContent);
				//后执行配置code
				for (int i = 0; afterCodes != null && i < afterCodes.length; i++) {
					if (afterCodes[i] == null || afterCodes[i].equals("")){
						continue;
					}				
					if(target.getExecutorResult().getResult() == null ||
							!target.getExecutorResult().getResult().equals("1")){
						continue;
					}
					aspectObj = new EventExecutor(ba, afterCodes[i]);
					((EventExecutor) aspectObj).generalEventExecutor();
				}				
			}

		} catch (Exception e) {
			throw e;
		}
		return (result);
	}
}
