// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DemoTrueF.java

package com.ow.framework.listener.event.servlet;

import com.ow.framework.listener.event.impl.FrequencyDemo;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import net.sf.json.JSONObject;

public class DemoTrueF extends HttpServlet
{

    public DemoTrueF()
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
        String no = request.getParameter("no") != null ? request.getParameter("no") : "";
        int tbs = Integer.parseInt(no);
        FrequencyDemo de = new FrequencyDemo();
        PrintWriter out = response.getWriter();
        if(tbs == 0)
        {
            if(FrequencyDemo.TureFalse2())
            {
                if(FrequencyDemo.funtwo() == 1)
                    json.put("demo", Integer.valueOf(1));
                else
                if(FrequencyDemo.funtwo() == 2)
                    json.put("demo", Integer.valueOf(2));
                else
                if(FrequencyDemo.funtwo() == 3)
                    json.put("demo", Integer.valueOf(3));
                out.println(json);
            } else
            {
                json.put("demo", Integer.valueOf(4));
                out.println(json);
            }
        } else
        {
            json.put("demo", Integer.valueOf(4));
            out.println(json);
        }
        System.out.println(json);
        out.flush();
        out.close();
    }

    private static final long serialVersionUID = 1L;
}
