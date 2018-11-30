package com.ow.framework.listener.event.impl;

import com.ice.jni.registry.NoSuchValueException;
import com.ice.jni.registry.RegistryException;
import com.ow.framework.listener.timer.job.TaskTerminateJob;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.prefs.BackingStoreException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;


public class FrequencyDemo {

	static String pathh = (FrequencyDemo.class.getResource("")+"test.dtj").replaceAll("%20", " ");
	static String pathh2 = (TaskTerminateJob.class.getResource("")+"time.dtj").replaceAll("%20", " ");
	static String path1 = pathh.substring(pathh.indexOf(":")+2, pathh.length());
	static String path2 = pathh2.substring(pathh2.indexOf(":")+2, pathh2.length());
	//static String path2 = "C:/Windows/System32/drivers/etc/time.dtj";
	private static long a1 = 0l;
	
	public FrequencyDemo(){}

	public static boolean Frequency()
    throws ParserConfigurationException, SAXException, IOException, TransformerException, BackingStoreException, NoSuchValueException, RegistryException
{
    return false;
}

public static String ReadNumberDemoXML()
    throws ParserConfigurationException, SAXException, IOException, TransformerException, BackingStoreException, NoSuchValueException, RegistryException
{
    String keyva = "";
    String jiqima = "";
    String xuliehao = "";
    Document document = null;
    try
    {
        document = (new SAXReader()).read(path2).getDocument();
    }
    catch(DocumentException e1)
    {
        e1.printStackTrace();
    }
    for(Iterator iterator = document.getRootElement().elements().iterator(); iterator.hasNext();)
    {
        Element Start = (Element)iterator.next();
        keyva = Start.element("DemoNum").getText();
        jiqima = Start.element("jiqima").getText();
        xuliehao = Start.element("xuliehao").getText();
    }

    return (new StringBuilder(String.valueOf(keyva))).append("-").append(jiqima).append("-").append(xuliehao).toString();
}

public static boolean iseq(String a, String b)
{
    return a.equalsIgnoreCase(b);
}

private static void createXml2(String patch)
{
    Document doc = DocumentHelper.createDocument();
    Element rootElement = doc.addElement("IndexValues");
    Element diyiceng1 = rootElement.addElement("Start");
    Element acquiesce = diyiceng1.addElement("DemoNum");
    acquiesce.addText("");
    Element acquiesce1 = diyiceng1.addElement("jiqima");
    acquiesce1.addText("");
    Element acquiesce2 = diyiceng1.addElement("xuliehao");
    acquiesce2.addText("");
    Element acquiesce3 = diyiceng1.addElement("DemoNumtrue");
    acquiesce3.addText("");
    Element firsttime = diyiceng1.addElement("firsttime");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
    Date date = new Date();
    String timefir = sdf.format(date);
    firsttime.addText(timefir);
    Element lasttime = diyiceng1.addElement("lasttime");
    Date lastdate = new Date();
    String timelast = sdf.format(lastdate);
    lasttime.addText((new StringBuilder(String.valueOf(lastdate.getTime()))).toString());
    Element disttime = diyiceng1.addElement("disttime");
    disttime.addText("0");
    Element trytime = diyiceng1.addElement("trytime");
    trytime.addText("");
    Element endtime = diyiceng1.addElement("endtime");
    endtime.addText("");
    try
    {
        OutputFormat fmt = new OutputFormat();
        fmt.setEncoding("utf-8");
        XMLWriter writer = new XMLWriter(fmt);
        OutputStream out = new FileOutputStream(patch);
        writer.setOutputStream(out);
        writer.write(doc);
        out.close();
        writer.close();
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
}

public static void WriteNumberDemoXML(String write, String p, String p1, String succeva)
    throws ParserConfigurationException, SAXException, IOException, TransformerException
{
    String patch = path2;
    File f = new File(patch);
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    org.w3c.dom.Document doc = builder.parse(f);
    NodeList nl = doc.getElementsByTagName("Start");
    org.w3c.dom.Element root = doc.getDocumentElement();
    NodeList books = root.getChildNodes();
    if(books != null)
    {
        for(int i = 0; i < books.getLength(); i++)
        {
            Node book = books.item(i);
            for(int i1 = 0; i1 < nl.getLength(); i1++)
            {
                doc.getElementsByTagName("DemoNum").item(i1).setTextContent(write);
                doc.getElementsByTagName("DemoNumtrue").item(i1).setTextContent(succeva);
                doc.getElementsByTagName("jiqima").item(i1).setTextContent(p);
                doc.getElementsByTagName("xuliehao").item(i1).setTextContent(p1);
            }

        }

    }
    TransformerFactory transformerFactory = TransformerFactory.newInstance();
    Transformer transformer = transformerFactory.newTransformer();
    DOMSource domSource = new DOMSource(doc);
    transformer.setOutputProperty("encoding", "UTF-8");
    StreamResult result = new StreamResult(new FileOutputStream(patch));
    transformer.transform(domSource, result);
}

public static int WriteNumRegedit(String dit1, String dit2, String dit3)
    throws NoSuchValueException, RegistryException, ParserConfigurationException, SAXException, IOException, TransformerException, BackingStoreException
{
    Document document = null;
    try
    {
        document = (new SAXReader()).read(path1).getDocument();
    }
    catch(DocumentException e1)
    {
        e1.printStackTrace();
    }
    return 1;
}

public static boolean TureFalse2()
{
    String n = "";
    String dt = "";
    String firsttime = "";
    String trytime = "";
    String lasttime = "";
    String disttime = "";
    if((new File(path2)).exists())
    {
        Document document = null;
        try
        {
            document = (new SAXReader()).read(path2).getDocument();
        }
        catch(DocumentException e1)
        {
            e1.printStackTrace();
        }
        for(Iterator iterator = document.getRootElement().elements().iterator(); iterator.hasNext();)
        {
            Element Start = (Element)iterator.next();
            n = Start.element("DemoNum").getText();
            dt = Start.element("DemoNumtrue").getText();
            firsttime = Start.element("firsttime").getText();
            lasttime = Start.element("lasttime").getText();
            trytime = Start.element("trytime").getText();
            disttime = Start.element("disttime").getText();
        }

        fun();
        return !n.equals("") && n != null && !dt.equals("") && dt != null && n.equalsIgnoreCase(dt);
    } else
    {
        createXml2(path2);
        return false;
    }
}

public static boolean fun()
{
    String firsttime = "";
    String trytime = "";
    String endtime = "";
    String lasttime = "";
    String disttime = "";
    long tryti = 0L;
    long endti = 0L;
    Document document = null;
    try
    {
        document = (new SAXReader()).read(path2).getDocument();
    }
    catch(DocumentException e1)
    {
        e1.printStackTrace();
    }
    for(Iterator iterator = document.getRootElement().elements().iterator(); iterator.hasNext();)
    {
        Element Start = (Element)iterator.next();
        firsttime = Start.element("firsttime").getText();
        trytime = Start.element("trytime").getText();
    }

    int days = 0;
    if(trytime == "")
        days = Integer.parseInt("60");
    else
        days = Integer.parseInt(trytime);
    Date todayDate = null;
    String afterDate = "";
    try
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
        todayDate = sdf.parse(firsttime);
        Format formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        long afterTime = todayDate.getTime() / 1000L + (long)(0x15180 * days);
        todayDate.setTime(afterTime * 1000L);
        afterDate = formatter.format(todayDate);
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    try
    {
        File f = new File(path2);
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        org.w3c.dom.Document doc = builder.parse(f);
        NodeList nl = doc.getElementsByTagName("Start");
        org.w3c.dom.Element root = doc.getDocumentElement();
        NodeList books = root.getChildNodes();
        if(books != null)
        {
            for(int i = 0; i < books.getLength(); i++)
            {
                Node book = books.item(i);
                for(int i1 = 0; i1 < nl.getLength(); i1++)
                {
                    doc.getElementsByTagName("trytime").item(i1).setTextContent((new StringBuilder(String.valueOf(days))).toString().trim());
                    doc.getElementsByTagName("endtime").item(i1).setTextContent(afterDate);
                }

            }

        }
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        DOMSource domSource = new DOMSource(doc);
        transformer.setOutputProperty("encoding", "UTF-8");
        StreamResult result = new StreamResult(new FileOutputStream(path2));
        transformer.transform(domSource, result);
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    return true;
}

public static int funtwo()
{
    String firsttime = "";
    String afterDate = "";
    String trytime = "";
    String endtime = "";
    String lasttime = "";
    String disttime = "";
    String distday = "";
    Document document = null;
    try
    {
        document = (new SAXReader()).read(path2).getDocument();
    }
    catch(DocumentException e1)
    {
        e1.printStackTrace();
    }
    for(Iterator iterator = document.getRootElement().elements().iterator(); iterator.hasNext();)
    {
        Element Start = (Element)iterator.next();
        firsttime = Start.element("firsttime").getText();
        lasttime = Start.element("lasttime").getText();
        disttime = Start.element("disttime").getText();
        trytime = Start.element("trytime").getText();
        endtime = Start.element("endtime").getText();
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
    Date date = new Date();
    long currtimeL = Long.parseLong(sdf.format(date).replace(":", "").replace(" ", ""));
    long lasttimeL = 0L;
    String nowtime = "";
    try
    {
        long lastL = Long.parseLong(lasttime.trim());
        Date nowDate = new Date();
        long nowL = nowDate.getTime();
        Long m = Long.valueOf(nowL - lastL);
        if(m.longValue() > 0L)
            try
            {
                Long quot = Long.valueOf(m.longValue() / 1000L / 60L / 60L / 24L);
                distday = (new StringBuilder(String.valueOf(Integer.parseInt(disttime) + quot.intValue()))).toString();
                File f = new File(path2);
                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                DocumentBuilder builder = factory.newDocumentBuilder();
                org.w3c.dom.Document doc = builder.parse(f);
                NodeList nl = doc.getElementsByTagName("Start");
                org.w3c.dom.Element root = doc.getDocumentElement();
                NodeList books = root.getChildNodes();
                if(books != null)
                {
                    for(int i = 0; i < books.getLength(); i++)
                    {
                        Node book = books.item(i);
                        for(int i1 = 0; i1 < nl.getLength(); i1++)
                        {
                            doc.getElementsByTagName("lasttime").item(i1).setTextContent((new StringBuilder(String.valueOf(nowL))).toString().trim());
                            doc.getElementsByTagName("disttime").item(i1).setTextContent(distday);
                        }

                    }

                }
                TransformerFactory transformerFactory = TransformerFactory.newInstance();
                Transformer transformer = transformerFactory.newTransformer();
                DOMSource domSource = new DOMSource(doc);
                transformer.setOutputProperty("encoding", "UTF-8");
                StreamResult result = new StreamResult(new FileOutputStream(path2));
                transformer.transform(domSource, result);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        else
            try
            {
                Long quot = Long.valueOf(0L);
                if(m.longValue() == 0L)
                {
                    distday = (new StringBuilder(String.valueOf(Integer.parseInt(disttime)))).toString();
                } else
                {
                    m = Long.valueOf(-m.longValue());
                    quot = Long.valueOf(m.longValue() / 1000L / 60L / 60L / 24L);
                    if(quot.longValue() == 0L)
                        quot = Long.valueOf(1L);
                    distday = (new StringBuilder(String.valueOf(Integer.parseInt(disttime) + quot.intValue()))).toString();
                }
                File f = new File(path2);
                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                DocumentBuilder builder = factory.newDocumentBuilder();
                org.w3c.dom.Document doc = builder.parse(f);
                NodeList nl = doc.getElementsByTagName("Start");
                org.w3c.dom.Element root = doc.getDocumentElement();
                NodeList books = root.getChildNodes();
                if(books != null)
                {
                    for(int i = 0; i < books.getLength(); i++)
                    {
                        Node book = books.item(i);
                        for(int i1 = 0; i1 < nl.getLength(); i1++)
                        {
                            doc.getElementsByTagName("lasttime").item(i1).setTextContent((new StringBuilder(String.valueOf(nowL))).toString().trim());
                            doc.getElementsByTagName("disttime").item(i1).setTextContent((new StringBuilder(String.valueOf(Integer.parseInt(disttime) + quot.intValue()))).toString());
                        }

                    }

                }
                TransformerFactory transformerFactory = TransformerFactory.newInstance();
                Transformer transformer = transformerFactory.newTransformer();
                DOMSource domSource = new DOMSource(doc);
                transformer.setOutputProperty("encoding", "UTF-8");
                StreamResult result = new StreamResult(new FileOutputStream(path2));
                transformer.transform(domSource, result);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
    }
    catch(Exception e1)
    {
        e1.printStackTrace();
    }
    long firstimeL = 0L;
    Date todayDate = null;
    try
    {
        todayDate = sdf.parse(firsttime);
        afterDate = sdf.format(todayDate).replace(":", "").replace(" ", "");
        firstimeL = Long.parseLong(afterDate);
    }
    catch(Exception e1)
    {
        e1.printStackTrace();
    }
    long endtimeL = Long.parseLong(endtime);
    if(currtimeL < firstimeL)
        return 1;
    if(currtimeL < endtimeL)
        return 2;
    return currtimeL <= endtimeL ? 0 : 3;
}
	
}
