package com.ow.module.event.sysmgr.exhibition.servlet;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.ow.module.event.sysmgr.exhibition.mod.SmallExhibitionMod;
import com.ow.module.event.sysmgr.laboratory.mod.SmallLaboratoryMod;
import com.ow.module.event.sysmgr.lovely.mod.SmallLovelyMod;
import com.ow.module.event.sysmgr.observation.mod.SmallObservationMod;
import com.ow.module.event.sysmgr.projection.mod.SmallProjectionMod;

public class SmallServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	public SmallServlet() {
		super();
	}
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException,IOException{
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException,IOException{
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out = resp.getWriter();
		String ID =  req.getParameter("ID");
		String roomname =  req.getParameter("roomname");
		if(roomname.equals("exhibition")){
			if(!ID.equals(null)){
				String Url = req.getSession().getServletContext().getRealPath("/WEB-INF/classes/jdbc.properties").replaceAll("%20", " ");
				JSONObject SmallObj = (JSONObject) SmallExhibitionMod.SmallEx(ID,Url);
				out.println(SmallObj);
				out.flush();
				out.close();
			}
		}else if(roomname.equals("laboratory")){
			if(!ID.equals(null)){
				String Url = req.getSession().getServletContext().getRealPath("/WEB-INF/classes/jdbc.properties").replaceAll("%20", " ");
				JSONObject SmallObj = (JSONObject) SmallLaboratoryMod.SmallEx(ID,Url);
				out.println(SmallObj);
				out.flush();
				out.close();
			}
		}
		else if(roomname.equals("observation")){
			if(!ID.equals(null)){
				String Url = req.getSession().getServletContext().getRealPath("/WEB-INF/classes/jdbc.properties").replaceAll("%20", " ");
				JSONObject SmallObj = (JSONObject) SmallObservationMod.SmallEx(ID,Url);
				out.println(SmallObj);
				out.flush();
				out.close();
			}
		}
		else if(roomname.equals("projection")){
			if(!ID.equals(null)){
				String Url = req.getSession().getServletContext().getRealPath("/WEB-INF/classes/jdbc.properties").replaceAll("%20", " ");
				JSONObject SmallObj = (JSONObject) SmallProjectionMod.SmallEx(ID,Url);
				out.println(SmallObj);
				out.flush();
				out.close();
			}
		}
		else if(roomname.equals("lovely")){
			if(!ID.equals(null)){
				String Url = req.getSession().getServletContext().getRealPath("/WEB-INF/classes/jdbc.properties").replaceAll("%20", " ");
				JSONObject SmallObj = (JSONObject) SmallLovelyMod.SmallEx(ID,Url);
				out.println(SmallObj);
				out.flush();
				out.close();
			}
		}
	}
}
