package com.ow.framework.data.handler.config;

import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.handler.IHandlerCriteria;

public class SystemDataConfig implements IHandlerCriteria
{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	
	public SystemDataConfig()
	{
		
	}

	public void appInit() {
		//使用延期
	}
	
}
