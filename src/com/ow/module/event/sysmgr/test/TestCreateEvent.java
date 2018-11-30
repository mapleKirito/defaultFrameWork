package com.ow.module.event.sysmgr.test;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class TestCreateEvent
  implements EventListener
{
  static Logger log = Logger.getLogger("FRAMEWORK");
  private ResultData resultData;

  public TestCreateEvent()
  {
    this.resultData = new ResultData();
  }

  public ResultData event(EventExecutor eventExecutor) throws Exception
  {
    try
    {
      HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
      String insert = eventExecutor.getSqlidByIndex(0);

      if (((UploadDataAction)eventExecutor.getBaseAction() instanceof UploadDataAction))
      {
        int rvalue = eventExecutor.getSqlSession().insert(insert, paramMap);
        eventExecutor.getSqlSession().update("user_info.add_wealth", eventExecutor.getBaseAction().getParamMap());
        this.resultData.setIntResult(1);
      }

      return this.resultData;
    }
    catch (Exception e)
    {
      this.resultData.setIntResult(0);
      String error = DetailException.expDetail(e, TestCreateEvent.class);
      log.error(error);
    }
    return this.resultData;
  }
}