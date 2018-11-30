package com.ow.module.event.sysmgr.test;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.FileHelper;

public class TestRecomEvent
  implements EventListener
{
  static Logger log = Logger.getLogger("FRAMEWORK");
  static int gradedefault = 1;
  private ResultData resultData;

  public TestRecomEvent()
  {
    this.resultData = new ResultData();
  }

  public ResultData event(EventExecutor eventExecutor) throws Exception
  {
    try {
      HashMap<String, String> paramMap = eventExecutor.getBaseAction().getParamMap();
      String update = eventExecutor.getSqlidByIndex(0);
      
      String testID = paramMap.get("testID") == null ? "" : (String)paramMap.get("testID") ;
      if(!"".equals(testID)){
    	  String[] testIDs = testID.split(",");
    	  for(int i=0;i<testIDs.length;i++){
    		  paramMap.put("reRecommendID", testIDs[i]) ;
    		  paramMap.put("testID", testIDs[i]) ;
    		  HashMap<String, String> one =  (HashMap<String, String>) eventExecutor.getSqlSession().selectOne("test.select_by_id", paramMap);
    		  
    		  paramMap.put("reRecommendType", "expand");
    		  paramMap.put("reName", one.get("testName"));
    		  paramMap.put("reThumbnail", one.get("testGrades")) ;
    		  paramMap.put("reInThum", "expand");
    		  paramMap.put("reUpload", "expand");
    		  paramMap.put("reType",  one.get("testGrades")) ;
    		  paramMap.put("reSize", "expand");
    		  paramMap.put("reRecoFileUP", "expand");
  			  eventExecutor.getSqlSession().insert("recom.insert_test", paramMap);

       	  }
      }
      return this.resultData;
    }
    catch (Exception e)
    {
      this.resultData.setIntResult(0);
      String error = DetailException.expDetail(e, TestRecomEvent.class);
      log.error(error);
    }
    return this.resultData;
  }
}