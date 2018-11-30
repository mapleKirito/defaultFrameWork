package com.ow.framework.data.handler.config;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.ow.framework.common.Constant;
import com.ow.framework.data.dao.SessionFactory;
import com.ow.framework.data.handler.IHandlerCriteria;
import com.ow.framework.exception.DetailException;


public class SqlSessionConfig implements IHandlerCriteria
{
	private String fileName;
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private static ArrayList<String> dataSource = new ArrayList<String>();	
	/**
	 * 数据库初始化  
	 */
	public SqlSessionConfig(String fileName)
	{
		this.fileName = fileName;
	}

	public void appInit() {
		try {
			 SAXReader reader = new SAXReader(); 
			 reader.setValidation(false);
			 reader.setEntityResolver(new EntityResolver() {
                public InputSource resolveEntity(String publicId,
                        String systemId) throws SAXException, IOException {
                    return new InputSource(new ByteArrayInputStream("<?xml version=\"1.0\" encoding=\"UTF-8\"?>".getBytes()));
                }
            });		
			InputStream in = new FileInputStream(new File(fileName)); 
			Document doc = reader.read(in);
			Element environments = doc.getRootElement();
			for(Iterator iterator = environments.elementIterator();iterator.hasNext();) 
            { 
                Element node = (Element)iterator.next(); 
                String nodeName = node.getName();
                if (nodeName != null && nodeName.equals("environments")){
                	for(Iterator nodeiterator = node.elementIterator();nodeiterator.hasNext();) 
                    {
                		Element environment = (Element)nodeiterator.next(); 
                        String environmentName = environment.getName();
                		if (environmentName != null && environmentName.equals("environment")){
                         	if(environment.attributes()!=null && environment.attributes().size()>0) 
             	            { 
             	                for(Iterator subiterator = environment.attributeIterator();subiterator.hasNext();) 
             	                { 
            	                    Attribute item = (Attribute)subiterator.next(); 
            	                    String attrName = item.getName();
            	                    String attrValue = item.getValue();
            	                    if (attrName != null && attrName.equals("id")){
            	    					boolean ismap = false;
            	    					int idx = attrValue.indexOf("_");
            	    					if (idx > -1){						
            	    						String dstype = attrValue.substring(0,idx);
            	    						for (int j=0; j<Constant.DATASOURCE_TYPE.length; j++){
            	    							if (dstype.equals(Constant.DATASOURCE_TYPE[j])){
            	    								ismap = true;
            	    								break;
            	    							}
            	    						}
            	    						if (!ismap){
            	    							throw new Exception("ibatis.config.xml 配置文件:environment id 属性格式错误.");
            	    						}
            	    						else{
            	    							dataSource.add(attrValue);
            	    						}
            	    					}
            	    					else{
            	    						throw new Exception("ibatis.config.xml 配置文件:environment id 属性格式错误.");
            	    					}
            	                    }     	                	
             	                }
             	            }                			 
                		}
                    }
                }
            }
			SqlSessionFactoryBuilder sfb = new SqlSessionFactoryBuilder();
			for(int i =0 ;i<dataSource.size();i++){
				System.out.println("系统" + dataSource.get(i)+ "数据源DAO对象正在加载中，请稍后.....");
				FileReader reader2 = new FileReader(new File(fileName));
				SqlSessionFactory sf = sfb.build(reader2,dataSource.get(i));
				if(sf!=null){
					SessionFactory.getInstance().getSqlSessionFactoryMap().put(dataSource.get(i), sf);
					System.out.println("系统" + dataSource.get(i) + "数据源DAO对象加载成功！");
				}else{
					System.out.println("系统" + dataSource.get(i) + "数据源DAO对象加载失败！");
				}
				if (reader != null)
					reader2.close();
			}
		} catch (Exception e) {
			String error = DetailException.expDetail(e,  PermissionConfig.class);
			log.error(error);
			System.exit(-2);
		}
	}
	
}
