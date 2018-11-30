package com.expansion.module;

import java.io.ObjectInputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.expansion.bean.VersionBean;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.sysmgr.exhibition.ExhibitionViewDetailEventSmall;

public class GetVersionAjaxEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public GetVersionAjaxEvent(){
		resultData = new ResultData();
	}
	@Override
	public ResultData event(EventExecutor eventExecutor){
		try
		{
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			HttpServletResponse resp = ServletActionContext.getResponse();
			PrintWriter out = resp.getWriter();
			JSONObject json = new JSONObject(); 
			String urls="http://www.lkyd.com.cn:80/HittoryVersionManagement/GetVersion";
			URL url=new URL(urls);
			URLConnection con=url.openConnection();
			ObjectInputStream ois=new ObjectInputStream(con.getInputStream());
			
			VersionBean version=(VersionBean)ois.readObject();
		//	System.out.println("最新版本号:"+version.getVersion());
		//	System.out.println("最新更新地址:"+version.getUpdateURL());
			json.put("nowVersion", version.getVersion());
			json.put("updateURL", version.getUpdateURL());
			out.println(json);
			out.flush();
			out.close();
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExhibitionViewDetailEventSmall.class);
			log.error(error);
		}
		return resultData;
	}

}
