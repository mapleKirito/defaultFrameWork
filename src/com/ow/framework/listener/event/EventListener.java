package com.ow.framework.listener.event;

import com.ow.framework.data.po.ResultData;

public interface EventListener {
	
	/**
	 * 系统监听事件
	 * @param baseAction  action对象
	 */
	public ResultData event(EventExecutor eventExecutor) throws Exception;

}
