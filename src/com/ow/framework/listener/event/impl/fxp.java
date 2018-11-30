// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   fxp.java

package com.ow.framework.listener.event.impl;

import com.ow.framework.util.Encrypt;
import java.io.IOException;
import java.io.PrintStream;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.xml.sax.SAXException;

// Referenced classes of package com.ow.framework.listener.event.impl:
//            FrequencyDemo

public class fxp
{

    public fxp()
    {
    }

    public static String deco(String p, String p1)
    {
        String val = (new StringBuilder(String.valueOf(Encrypt.getMD5((new StringBuilder(String.valueOf(p))).append(p1).toString())))).toString();
        try
        {
            System.out.println(val);
            FrequencyDemo.WriteNumberDemoXML(val, p, p1, "");
        }
        catch(ParserConfigurationException e)
        {
            e.printStackTrace();
        }
        catch(SAXException e)
        {
            e.printStackTrace();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
        catch(TransformerException e)
        {
            e.printStackTrace();
        }
        return val;
    }

    private static final char FlashFXP_Key[] = "yA36zA48dEhfrvghGRg57h5UlDv3".toCharArray();

}
