package com.ow.module.event.sysmgr.htask;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class HtaskViewEvent
  implements EventListener
{
  static Logger log = Logger.getLogger("FRAMEWORK");
  private ResultData resultData;

  public HtaskViewEvent()
  {
    this.resultData = new ResultData();
  }

  public ResultData event(EventExecutor eventExecutor)
    throws Exception
  {
    try
    {
      String sid = eventExecutor.getSqlidByIndex(0);
      String sid1 = eventExecutor.getSqlidByIndex(1);
      HashMap map = eventExecutor.getBaseAction().getParamMap();

      if (!"".equals(sid))
      {
        List rlist = eventExecutor.getSqlSession().selectList(sid, map);
        Object obj = eventExecutor.getSqlSession().selectOne(sid1, map);
        this.resultData.setList(rlist);
      }
      return this.resultData;
    }
    catch (Exception e)
    {
      String error = DetailException.expDetail(e, HtaskViewEvent.class);
      log.error(error);
      throw e;
    }
  }
}