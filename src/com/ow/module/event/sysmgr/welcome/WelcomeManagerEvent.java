package com.ow.module.event.sysmgr.welcome;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.view.ResSearchViewEvent;

public class WelcomeManagerEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public WelcomeManagerEvent()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;
			List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);//文物博览室
			for(HashMap<String, Object> res : list1) {
				HashMap<String, Object> map = new HashMap<String, Object>() ;
				map.put("name", res.get("reName")) ;
				map.put("id", res.get("reID")) ;
				map.put("recoFileup", res.get("reRecoFileUP")) ;
				map.put("upload", res.get("reUpload")) ;
				map.put("thumbnail", res.get("reThumbnail")) ;
				map.put("inThum", res.get("reInThum")) ;
				map.put("size", res.get("reSize")) ;
				map.put("resType", paramMap.get("reRecommendType")) ;
				list.add(map);
			}
			
			resultData.setList(list);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ResSearchViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}