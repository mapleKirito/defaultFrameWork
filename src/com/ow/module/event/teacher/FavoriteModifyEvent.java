package com.ow.module.event.teacher;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class FavoriteModifyEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public FavoriteModifyEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String uid = eventExecutor.getSqlidByIndex(0);
			String sid = eventExecutor.getSqlidByIndex(1);
			String scid = eventExecutor.getSqlidByIndex(2);
			String ucid = eventExecutor.getSqlidByIndex(3);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			if (!"".equals(uid))
			{
				String oldParentId = paramMap.get("oldParentId") == null?"0":paramMap.get("oldParentId").toString();
				String rfParentId = paramMap.get("rfParentId") == null?"0":paramMap.get("rfParentId").toString();
				//若相等上级目录没有变化
				if (oldParentId.equals(rfParentId)){
					eventExecutor.getSqlSession().update(uid, paramMap);
				}
				else{
					String oldPath = paramMap.get("rfPath") == null?"0":paramMap.get("rfPath").toString();
					Object obj = eventExecutor.getSqlSession().selectOne(sid, paramMap);
					if (obj instanceof HashMap){
						String path = oldPath.replace(","+oldParentId+",",","+rfParentId+",");
						String level = ((HashMap)obj).get("rfLevel") == null ? "1":((HashMap)obj).get("rfLevel").toString();
						paramMap.put("rfPath", path);
						paramMap.put("rfLevel", (Integer.parseInt(level) + 1));
					}
					eventExecutor.getSqlSession().update(uid, paramMap);
					//修改新父节点ischild属性
					paramMap.put("rfParentId", rfParentId);
					paramMap.put("rfIsChild", "1");
					eventExecutor.getSqlSession().update(ucid, paramMap);
					paramMap.put("rfParentId", oldParentId);
					//判断上级是否还有子节点，若没有将父节点修改成子节点（ischild=0）
					Object cobj = eventExecutor.getSqlSession().selectOne(scid, paramMap);
					if (cobj instanceof Integer){
						int c = (Integer)cobj;
						if (c <= 0){
							paramMap.put("rfIsChild", "0");
							eventExecutor.getSqlSession().update(ucid, paramMap);
						}
					}
				}
				resultData.setIntResult(1);
			}				
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, FavoriteModifyEvent.class);
			log.error(error);
			throw e;
		}
		return resultData;
	}

}
