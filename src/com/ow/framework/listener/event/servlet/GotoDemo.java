// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   GotoDemo.java

package com.ow.framework.listener.event.servlet;

import com.ow.framework.listener.event.impl.*;
import com.ow.framework.util.Encrypt;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import net.sf.json.JSONObject;

public class GotoDemo extends HttpServlet
{

    public GotoDemo()
    {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        JSONObject json = new JSONObject();
        PrintWriter out = response.getWriter();
        String t = request.getParameter("t") != null ? request.getParameter("t") : "";
        String jimahou = request.getParameter("jimahou");
        String succeva = request.getParameter("succeva") != null ? request.getParameter("succeva") : "";
        String jiemabefore = request.getParameter("jiemabefore") != null ? request.getParameter("jiemabefore") : "";
        String xuliebefore = request.getParameter("xuliebefore") != null ? request.getParameter("xuliebefore") : "";
        String xuliehao = request.getParameter("xuliehao");
        String g = request.getParameter("g") != null ? request.getParameter("g") : "";
        boolean istrue = false;
        if(!g.equals(""))
            try
            {
                String a = FrequencyDemo.ReadNumberDemoXML();
                String s[] = a.split("-");
                json.put("jiema", s[1]);
                json.put("xulie", s[2]);
                out.println(json);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        else
        if(!succeva.equals(""))
            try
            {
                FrequencyDemo.WriteNumberDemoXML((new StringBuilder(String.valueOf(Encrypt.getMD5((new StringBuilder(String.valueOf(jiemabefore))).append(xuliebefore).toString())))).toString(), jiemabefore, xuliebefore, succeva);
                String a = FrequencyDemo.ReadNumberDemoXML();
                String s[] = a.split("-");
                istrue = FrequencyDemo.iseq(succeva, s[0]);
                if(istrue)
                {
                	KeyTransition.regTime();
                    json.put("istrue", "1");
                    out.println(json);
                } else
                {
                    json.put("istrue", "0");
                    out.println(json);
                }
            }
            catch(Exception e)
            {
            	e.printStackTrace();
                json.put("istrue", "0");
                out.println(json);
            }
        else
        if(t.equals("0"))
        {
            long firstimeL = 0L;
            Date todayDate = null;
            String afterDate = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
            try
            {
                todayDate = sdf.parse(sdf.format(new Date()));
            }
            catch(ParseException e)
            {
                e.printStackTrace();
            }
            afterDate = sdf.format(todayDate).replace(":", "").replace(" ", "");
            firstimeL = Long.parseLong(afterDate);
            String up = (new StringBuilder(String.valueOf(GetpcInfo.getCPUSerial()))).append(GetpcInfo.getMotherboardSN()).append(firstimeL).toString();
            up = Encrypt.getMD5(up);
            json.put("demovalue", up);
            out.println(json);
        } else
        {
            String e = fxp.deco(jimahou, xuliehao);
            if(e.equals("nokey"))
                out.println(0);
            else
            if(e.equals("novalue"))
                out.println(4);
            else
                out.println(1);
        }
        out.flush();
        out.close();
    }

    private static final long serialVersionUID = 1L;
}
