package com.ow.module.event.sysmgr.team;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;
import com.ow.framework.util.StringUtil;
import com.staticHtml.bean.PageInfoBean;
import com.staticHtml.util.GetProjectPath;
import com.staticHtml.util.InitStaticHtml;
import com.staticHtml.util.StaticTableFactory;
import com.staticHtml.util.ToHtmlByOpenOffice;
import com.staticHtml.util.To_Html;

public class TeamCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	private static String fileSplit = "/";

	public TeamCreateEvent() {
		resultData = new ResultData();
	}

	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String insert = eventExecutor.getSqlidByIndex(0);
			String insertMapping = eventExecutor.getSqlidByIndex(1);
			paramMap.put("userImg", "images/default/default_team.jpg");
			Object obj=eventExecutor.getSqlSession().insert(insert, paramMap);
			obj=eventExecutor.getBaseAction().getParamMap().get("generatedKey");
			paramMap.put("tID", obj);
			paramMap.put("uID", paramMap.get("s_userID"));
			paramMap.put("uState", 2);
			obj=eventExecutor.getSqlSession().insert(insertMapping, paramMap);
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, TeamCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}

	/** 对多文件上传的路径处理方法 */
	@SuppressWarnings("unused")
	private List<String> getTempPath(String str, int length) {
		List<String> returnList = new ArrayList<String>();
		/** 当隐藏域没有配置 */
		if (str == null) {
			for (int i = 0; i < length; i++) {
				returnList.add(fileSplit);
			}
			return returnList;
		} else {
			/** 当上传多文件的时候两种情况 */
			String strs[] = str.split("&");
			if (strs.length > 0 && strs.length < length) {
				for (int i = 0; i < strs.length; i++) {
					returnList.add(strs[i] + fileSplit);
				}
				for (int j = 0; j < length - strs.length; j++) {
					returnList.add(fileSplit);
				}
				return returnList;
			} else {
				returnList.add(str);
				for (int i = 0; i < length - 1; i++) {
					returnList.add(fileSplit);
				}
				return returnList;
			}
		}
	}

}
