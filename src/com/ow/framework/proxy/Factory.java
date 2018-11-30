package com.ow.framework.proxy;

import java.lang.reflect.Constructor;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;

/**
 * 类工厂(此类为单例模式)
 * 
 * @author allen
 * 
 */

public class Factory {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);

	private static Factory factory = null;

	private Factory() {
	}

	/**
	 * 单例模式，实例化工厂类
	 * 
	 * @return
	 */
	public synchronized static Factory getInstance() {
		if (factory == null) {
			factory = new Factory();
			return (factory);
		} else {
			return (factory);
		}
	}

	/**
	 * 通过代理创建一个类
	 * 
	 * @param className
	 *            类完全路径名称
	 * @return
	 * @throws Exception
	 */
	public Object getInstanceByProxy(String className) throws Exception {
		try {
			return (this.createInstance(className, true));
		} catch (Exception e) {
			log.error("Factory.getInstanceViaProxy error:" + e);
			throw new Exception("Factory.getInstanceViaProxy error:" + e);
		}
	}

	
	
	/**
	 * 通过类名和参数动态构造对象
	 * @param className
	 * @param args
	 * @return
	 * @throws Exception
	 */
			
	@SuppressWarnings({ "unchecked", "finally" })
	public Object getInstanceProxyByParam(String className, Object[] args)
			throws Exception {
		if (args.length == 0) {
			return getInstanceByProxy(className);
		}

		Object obj = null;
		try {
			Constructor[] constructors = Class.forName(className)
					.getConstructors();
			for (int i = 0; i < constructors.length; i++) {
				try {
					if (args.length == constructors[i]
							.getGenericParameterTypes().length) {
						obj = constructors[i].newInstance(args);
						break;
					}

				} catch (Exception e1) {
					if (e1 instanceof InstantiationException
							|| e1 instanceof IllegalAccessException
							|| e1 instanceof IllegalArgumentException
							|| e1 instanceof IllegalArgumentException) {
						continue;
					}

				}
			}
			
		} catch (Exception e) {
			throw new Exception("there is no consreuctor use :["+args+"] as params to instance "+className );
		} finally {
			if(obj == null){
				throw new Exception("there is no consreuctor use :["+args+"] as params to instance "+className );
			}else {
				AopProxyFactory aopProxyFactory = new AopProxyFactory();
				obj = aopProxyFactory.getAopProxy().bind(obj);
				return obj;
			}
		}

	}

	/**
	 * 不通过代理创建一个类
	 * 
	 * @param className
	 *            类完全路径名称
	 * @return
	 * @throws Exception
	 */
	public Object getInstanceNoProxy(String className) throws Exception {
		try {
			return (this.createInstance(className, false));
		} catch (Exception e) {
			log.error("Factory.getInstanceNonProxy error:" + e);
			throw new Exception("Factory.getInstanceNonProxy error:" + e);
		}
	}

	/**
	 * 创建类
	 * 
	 * @param className
	 *            类完全路径名称
	 * @param boundProxyflag
	 *            是否绑定代理
	 * @return
	 * @throws Exception
	 */
	public Object createInstance(String className, boolean boundProxyFlag)
			throws Exception {
		try {
			Object obj = (Object) Class.forName(className).newInstance();
			// 绑定AOP代理
			if (boundProxyFlag) {
				AopProxyFactory aopProxyFactory = new AopProxyFactory();
				obj = aopProxyFactory.getAopProxy().bind(obj);
			}

			return (obj);
		} catch (Exception e) {
			log.error("Factory.createInstance(" + className + ") error:" + e);
			throw new Exception("Factory.createInstance(" + className
					+ ") error:" + e);
		}
	}
}
