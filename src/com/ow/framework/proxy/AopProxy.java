package com.ow.framework.proxy;



/**
 * AOP代理接口
 * @author 
 *
 */
public interface AopProxy 
{
	/**
	 * 必须实现的方法
	 * @param obj		需要绑定的类
	 * @return
	 * @throws Exception
	 */
	public Object bind(Object obj)	throws Exception;
}
