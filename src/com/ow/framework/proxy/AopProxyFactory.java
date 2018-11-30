package com.ow.framework.proxy;

/**
 * 
 * @author sunny
 *
 */
public class AopProxyFactory 
{
	private AopProxy aopProxy;
	
	public AopProxyFactory()
	{
		aopProxy = new StandardAopProxy();
	}

	public AopProxy getAopProxy()
	{
		return(aopProxy);
	}
}
