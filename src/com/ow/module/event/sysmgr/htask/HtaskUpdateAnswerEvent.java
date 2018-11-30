package com.ow.module.event.sysmgr.htask;
import java.util.HashMap;
import org.apache.log4j.Logger;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.FileHelper;
public class HtaskUpdateAnswerEvent implements EventListener {
	static Logger log = Logger.getLogger("FRAMEWORK");
	private ResultData resultData;
	public HtaskUpdateAnswerEvent() {
		this.resultData = new ResultData();
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String update = eventExecutor.getSqlidByIndex(0);
			String taContent = (String)paramMap.get("taContent");
			if(FileHelper.isMessyCode(taContent)){
				taContent = new String(taContent.toString().getBytes("ISO-8859-1"),"utf-8");
				paramMap.put("taContent", taContent);
			}
			eventExecutor.getSqlSession().update(update, paramMap);
			this.resultData.setIntResult(1);
			return this.resultData;
		} catch (Exception e) {
			this.resultData.setIntResult(0);
			String error = DetailException.expDetail(e,
					HtaskUpdateAnswerEvent.class);
			log.error(error);
		}
		return this.resultData;
	}
}