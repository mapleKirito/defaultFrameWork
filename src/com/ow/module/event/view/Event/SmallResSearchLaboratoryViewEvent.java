package com.ow.module.event.view.Event;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.ContractNumber;
import com.ow.module.event.view.ResSearchViewEvent;
import com.ow.upload.servlet.ComparatorToList;

public class SmallResSearchLaboratoryViewEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SmallResSearchLaboratoryViewEvent()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String keyword = paramMap.get("name") == null ? "" : new String(((String)paramMap.get("name")).getBytes("ISO-8859-1"), "UTF-8") ;
			String lrID = paramMap.get("lrID") == null ? "" : (String)paramMap.get("lrID");
			paramMap.put("keyword", keyword) ;
				
			Map mapmap = new HashMap();
			mapmap.put("lrID", lrID);
			Object obj = eventExecutor.getSqlSession().selectOne("laboratory.select_by_id",mapmap);
			String lrName = ((HashMap)obj).get("lrName") == null ? "":((HashMap)obj).get("lrName").toString();
			String labonly = keyword.substring(0,ContractNumber.isContractNum(keyword));
			if(keyword.equals("")){
				labonly = lrName.substring(0,ContractNumber.isContractNum(lrName));
				mapmap.put("keyword", labonly);
			}else{
				mapmap.remove("lrID");
				mapmap.put("keyword", labonly);
			}
			int listtotal = 0,index1 = 0;
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;
			List<HashMap<String, Object>> list3 = eventExecutor.getSqlSession().selectList("laboratory.select_page_other", mapmap);//教学研究室
			//int li3 = list3.size();
			for(HashMap<String, Object> res : list3) {
				if(res.get("lrType").equals("1011")){
					index1++;
				}
				HashMap<String, Object> map2 = new HashMap<String, Object>() ;
				map2.put("name", res.get("lrName")) ;
				map2.put("id", res.get("lrID")) ;
				map2.put("code", "YJS");
				map2.put("upload", res.get("lrUpload")) ;
				map2.put("thumbnail", res.get("lrThumbnail")) ;
				map2.put("inThum", res.get("lrInThum")) ;
				map2.put("labflvflv", res.get("lrFileSwf")) ;
				map2.put("path", "") ;
				map2.put("fileType", res.get("lrType")) ;
				map2.put("resType", "laboratory") ;
				map2.put("creator", res.get("lrCreator")) ;
				map2.put("fileSwf", res.get("lrFileSwf"));
				map2.put("createTime", res.get("lrCreateTime")) ;
				map2.put("Remarks", res.get("lrRemarks")) ;
				list.add(map2);
			}
		
			Collections.sort(list, new ComparatorToList());
			eventExecutor.getBaseAction().session.put("listnoequalpic",(list.size()-index1));
			eventExecutor.getBaseAction().session.put("listtotal",index1);
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
