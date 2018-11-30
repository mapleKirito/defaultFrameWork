package com.ow.module.event.sysmgr;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class SelectNameEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SelectNameEvent()
	{
		resultData = new ResultData();
	}	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlName = null;
			List list=new ArrayList<String>();
			HashMap map = null;
			map=eventExecutor.getBaseAction().getParamMap();
			String name=map.get("erName") == null ? "" : new String(((String)map.get("erName")).getBytes("ISO-8859-1"), "UTF-8") ;
			map.put("erName", name.replaceAll("\'", "").trim());
			for(int i=0;i<5;i++){
				selectSqlName=eventExecutor.getSqlidByIndex(i);	
				list.addAll(
						eventExecutor.getSqlSession().selectList(selectSqlName,map)==null?
								new ArrayList():eventExecutor.getSqlSession().selectList(selectSqlName,map));
			}
			Collections.sort(list);
			if(list.size()>9){
				list=list.subList(0, 10);
			}
			
			
			
//			if(obj != null) {
//				eventExecutor.getBaseAction().getParamMap().put("grResourceType", "exhibition") ;
//				eventExecutor.getBaseAction().getParamMap().put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("erID")) ;
//				Object obj2 = eventExecutor.getSqlSession().selectList(selectGradeSqlId, eventExecutor.getBaseAction().getParamMap());
//				if(obj2 != null){
//					((HashMap)obj).put("grGrade", ((HashMap)obj2).get("grGrade")) ;
//				}					
//			}
			//测试
			if(list!=null){
				for (Object object : list) {
				//	System.out.println((String)object);
				}
			}
			//测试
			resultData.setList(list);
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, SelectNameEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
