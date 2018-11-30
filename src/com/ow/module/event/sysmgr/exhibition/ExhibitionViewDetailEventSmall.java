package com.ow.module.event.sysmgr.exhibition;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ExhibitionViewDetailEventSmall implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ExhibitionViewDetailEventSmall()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectGradeSqlId = eventExecutor.getSqlidByIndex(1);
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId,map );
//			if(obj != null) {
//				eventExecutor.getBaseAction().getParamMap().put("grResourceType", "exhibition") ;
//				eventExecutor.getBaseAction().getParamMap().put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("erID")) ;
//				Object obj2 = eventExecutor.getSqlSession().selectList(selectGradeSqlId, eventExecutor.getBaseAction().getParamMap());
//				if(obj2 != null){
//					((HashMap)obj).put("grGrade", ((HashMap)obj2).get("grGrade")) ;
//				}					
//			}
			resultData.setOne(obj);
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExhibitionViewDetailEventSmall.class);
			log.error(error);
		}
		return resultData;
	}
}
