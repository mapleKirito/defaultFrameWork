package com.ow.module.event.sysmgr.test;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.FileHelper;

public class TestModifyEvent
  implements EventListener
{
  static Logger log = Logger.getLogger("FRAMEWORK");
  static int gradedefault = 1;
  private ResultData resultData;

  public TestModifyEvent()
  {
    this.resultData = new ResultData();
  }

  public ResultData event(EventExecutor eventExecutor) throws Exception
  {
    try {
      HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
      String update = eventExecutor.getSqlidByIndex(0);

      String testJudgeAnswer = (String)paramMap.get("testJudgeAnswer") == null ? "" : (String)paramMap.get("testJudgeAnswer");
      String testIndivAnswer = (String)paramMap.get("testIndivAnswer") == null ? "" : (String)paramMap.get("testIndivAnswer");

      String[] testIndivAnswers = testIndivAnswer.split(",");
      if (testIndivAnswers != null) {
        paramMap.put("testIndivAnswer", FileHelper.testA(testIndivAnswers));
      }

      if ("1,2".indexOf(testJudgeAnswer) > -1) {
        paramMap.put("testJudgeAnswer", "");
      }
      if ("3".indexOf(testIndivAnswer) > -1) {
        paramMap.put("testIndivAnswer", "");
      }

      int rvalue = eventExecutor.getSqlSession().update(update, paramMap);
      this.resultData.setIntResult(1);

      return this.resultData;
    }
    catch (Exception e)
    {
      this.resultData.setIntResult(0);
      String error = DetailException.expDetail(e, TestModifyEvent.class);
      log.error(error);
    }
    return this.resultData;
  }
}