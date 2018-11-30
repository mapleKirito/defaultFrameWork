package com.ow.module.event.view;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.StringUtil;




public class AddFavoriteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private HashMap phashMap;
	public AddFavoriteEvent()
	{
		resultData = new ResultData();
		phashMap = new HashMap();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap hashMap = eventExecutor.getBaseAction().getParamMap();
			String sid = eventExecutor.getSqlidByIndex(0);
			String scount = eventExecutor.getSqlidByIndex(1);
			String update_1 = eventExecutor.getSqlidByIndex(2);
			String update_2 = eventExecutor.getSqlidByIndex(3);
			if (!"".equals(sid))
			{
				String pname_ = hashMap.get("param") == null? "" : hashMap.get("param").toString();
				pname_ = URLDecoder.decode(pname_ , "utf-8");
				String param_[] = {"code","path","paramMap.roomtype","paramMap.st","paramMap.name","paramMap.rfResType","pid"};
				String url = "";
				String pname[] = pname_.split("\\|");
				String url_ = ""; 
					System.out.println(param_[0]+"---"+pname[0]);	
					System.out.println(param_[1]+"---"+pname[1]);	
					System.out.println(param_[2]+"---"+pname[2]);	
					System.out.println(param_[3]+"---"+pname[3]);	
					System.out.println(param_[4]+"---"+pname[4]);	
					System.out.println(param_[5]+"---"+pname[5]);	
					System.out.println(param_[6]+"---"+pname[6]);	
					
				for(int i=0;i<param_.length;i++){
					System.out.println(pname[i]);
					if(pname[i]!=null && !pname[i].equals("")){
						
						if(FileHelper.isMessyCode(pname[i])){
							pname[i] = new String(pname[i].toString().getBytes("ISO-8859-1"),"utf-8");
						}
						
						if(param_[i].equals("pid"))
							url_+="&"+"paramMap."+StringUtil.reResAbbreviated(pname[2])+"ID"+"="+pname[i];
						else
							url_+="&"+param_[i]+"="+pname[i];
						
					}
				}
				url += url_.replaceFirst("&", "").trim()+"&";
				String userID = hashMap.get("s_userID") == null? "" : hashMap.get("s_userID").toString();
				phashMap.put("rfParentId", "0");
				phashMap.put("rfResourceURL", url);
				phashMap.put("rfResID", pname[6]);
				phashMap.put("rfSort", pname[2]);
				phashMap.put("rfResType", pname[5]);
				phashMap.put("rfResTypeName", pname[5]);
				phashMap.put("rfType", "1");
				phashMap.put("rfSortName", pname[2]);
				phashMap.put("rfPath", "0");
				phashMap.put("rfLevel", "0");
				phashMap.put("rfName", pname[4]);
				phashMap.put("rfIsPath", "0");
				phashMap.put("rfIsChild", "0");
				phashMap.put("s_userID", userID);
				
				
				
				Map map = new HashMap();
				map.put("rfResID", pname[6]);
				map.put("rfPath", "0");
				map.put("rfParentId", "0");
				map.put("rfSort", pname[2]);
				map.put("s_userID", userID);

				HttpServletResponse response = ServletActionContext.getResponse();
				response.setContentType("text/html;charset=UTF-8");
				response.setCharacterEncoding("utf-8");  
				PrintWriter out = response.getWriter();
				JSONObject js = new JSONObject();
				
				Object obj =  eventExecutor.getSqlSession().selectOne(scount, map);
				int rcount = 0;
				if (obj instanceof Integer){
					rcount = (Integer)obj;
				}
				if (rcount <= 0){
					int rvalue = eventExecutor.getSqlSession().insert(sid, phashMap);
					Map map_favorite = new HashMap();
					map_favorite.put("rfResType", StringUtil.resToType(pname[5]));
					map_favorite.put("rfSort", StringUtil.addfavoriteToChina(pname[2]));
					map_favorite.put("rfResType1", pname[5]);
					map_favorite.put("rfSort1", pname[2]);
					
					Object obj_update_1 =  eventExecutor.getSqlSession().update(update_1, map_favorite);
					Object obj_update_2 =  eventExecutor.getSqlSession().update(update_2, map_favorite);
					
					js.put("content", "资源收藏成功!");
					resultData.setIntResult(1);
				}
				else{
					js.put("content", "您已经收藏过此资源!");					
				}
				
				out.println(js);
				out.flush();
				out.close();
				
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, AddFavoriteEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
