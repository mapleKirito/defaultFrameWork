package com.ow.module.event.sysmgr.htask;
import java.util.HashMap;
import org.apache.log4j.Logger;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.FileHelper;
public class HtaskInsertAnswerEvent implements EventListener {
	static Logger log = Logger.getLogger("FRAMEWORK");
	private ResultData resultData;
	public HtaskInsertAnswerEvent() {
		this.resultData = new ResultData();
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String insert = eventExecutor.getSqlidByIndex(0);
			String taContent = (String)paramMap.get("taContent");
			if(FileHelper.isMessyCode(taContent)){
				taContent = new String(taContent.toString().getBytes("ISO-8859-1"),"utf-8");
				paramMap.put("taContent", taContent);
			}
			eventExecutor.getSqlSession().insert(insert, paramMap);
			int count = 0;
			Object mapobj = eventExecutor.getSqlSession().selectOne("histaskmapper.select_isinsert_count", paramMap);
			if (mapobj != null){
				count = (Integer)mapobj;
				if(count<=0){
					eventExecutor.getSqlSession().insert("histaskmapper.insert", paramMap);
				}
			}
			eventExecutor.getSqlSession().update("histaskmapper.update_htaskIsAnswer", paramMap);
			paramMap.put("taID", eventExecutor.getBaseAction().getParamMap().get("generatedKey"));
			eventExecutor.getSqlSession().update("tahistask.update_isNewTeameq0", paramMap);
			eventExecutor.getSqlSession().update("tahistask.update_isNewTeameq1", paramMap);
			this.resultData.setIntResult(1);
			return this.resultData;
		} catch (Exception e) {
			this.resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HtaskInsertAnswerEvent.class);
			log.error(error);
		}
		return this.resultData;
	}
}