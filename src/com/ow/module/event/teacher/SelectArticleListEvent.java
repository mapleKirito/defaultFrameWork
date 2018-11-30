package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;
import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class SelectArticleListEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SelectArticleListEvent()
	{
		resultData = new ResultData();
	}		 
	@SuppressWarnings("rawtypes")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();
			if (!"".equals(sid))
			{
				List rlist = eventExecutor.getSqlSession().selectList(sid, map);
				for (Object object : rlist) {
					String content=((HashMap<String, String>)object).get("aContent");
					// 过滤文章内容中的html
					content = content.replaceAll("</?[^<]+>", "");
					// 去除字符串中的空格 回车 换行符 制表符 等
					content = content.replaceAll("\\s*|\t|\r|\n", "");
					// 去除空格
					content = content.replaceAll("&nbsp;", "");
					((HashMap<String, String>)object).put("aContent", content);
				}
				resultData.setList(rlist);
			}
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectArticleListEvent.class);
			log.error(error);
			throw e;
		}
	}
}
