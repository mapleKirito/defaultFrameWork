package com.SmartServer.util;
import java.io.File;    
import java.io.IOException;
import javax.xml.parsers.DocumentBuilder;    
import javax.xml.parsers.DocumentBuilderFactory;       
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;    
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;    
import org.xml.sax.SAXException;
import java.io.FileOutputStream;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Node; 

public class SmartIpXml {
	public static String Xml(String path) {
		String s = null;
		try {
			File f = new File(path);
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(f);
			NodeList nl = doc.getElementsByTagName("data");
			for (int i = 0; i < nl.getLength(); i++) {
				s = doc.getElementsByTagName("loginUrl").item(i).getFirstChild().getNodeValue();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}
	public static void updateXml(String ips,String path) throws ParserConfigurationException, SAXException, IOException, TransformerException { 
		String pathxml[] = {path,path.replace("webapps", "webapps1")};
		String portwebpp[] = {"8086","8081"};
		updateXml(ips, pathxml, portwebpp);
	}
	public static void updateXml(String ips,String pathXml[],String portwebpp[]) throws ParserConfigurationException, SAXException, IOException, TransformerException{
		for(int j = 0;j < pathXml.length;j++){
			System.out.println(pathXml[j]);
			File f = new File(pathXml[j]);
			if(f.exists()){
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				Document doc = builder.parse(f);
				NodeList nl = doc.getElementsByTagName("data");
		
				Element root = doc.getDocumentElement(); 
				//得到节点的子节点 
				NodeList books = root.getChildNodes(); 
				if (books != null) { 
					for (int i = 0; i < books.getLength(); i++) { 
						Node book = books.item(i); 
						System.out.println(book.toString());
						if(book.toString().equals("[requestURL: null]")){
							for(int i0=0;i0<nl.getLength();i0++){
								doc.getElementsByTagName("requestURL").item(i0).setTextContent("http://"+ips+":"+portwebpp[j]+"/dm/ajaxAction.action");
							}
						}
						if(book.toString().equals("[loginUrl: null]")){
							for(int i1=0;i1<nl.getLength();i1++){
								doc.getElementsByTagName("loginUrl").item(i1).setTextContent("http://"+ips+":"+portwebpp[j]+"/dm/ajaxAction.action");
								doc.getElementsByTagName("chuceUrl").item(i1).setTextContent("http://"+ips+":"+portwebpp[j]+"/dm/commonForwardAction.action?code=-1501");
								doc.getElementsByTagName("askUrl").item(i1).setTextContent("http://"+ips+":"+portwebpp[j]+"/dm/commonForwardAction.action?code=-1401");
								doc.getElementsByTagName("mainUrl").item(i1).setTextContent("http://"+ips+":"+portwebpp[j]+"/dm/forwardAction.action?code=-1700");	
							}
						}
					}
				}
				//保存xml文件
				TransformerFactory transformerFactory=TransformerFactory.newInstance();
				Transformer transformer=transformerFactory.newTransformer();
				DOMSource domSource=new DOMSource(doc);
				//设置编码类型
				transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
				StreamResult result=new StreamResult(new FileOutputStream(pathXml[j]));
				//把DOM树转换为xml文件
				transformer.transform(domSource, result);
			}
		}
	}
}
