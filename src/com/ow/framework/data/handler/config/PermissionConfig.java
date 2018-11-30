package com.ow.framework.data.handler.config;



import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.dao.SessionFactory;
import com.ow.framework.data.handler.IHandlerCriteria;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.impl.GODEvent;
import com.ow.framework.util.DateUtil;

public class PermissionConfig implements IHandlerCriteria
{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	/**初始化文件的路径*/
	private String fileUrl;
	/**数据源名称*/
	private String dsname;
	/**数据库操作SqlSession对象,获取事物方式sqlsession*/
	private SqlSession sqlSession;
    /**
     * fileUrl is a folder
     * @param fileUrl
     */
    public PermissionConfig(String fileUrl,String dsname)
    {
    	this.fileUrl = fileUrl;
    	this.dsname = dsname;
    	//设置数据库源名到常量类
    	Constant.DATA_SOURCE = dsname;

    }
    
    public PermissionConfig(String fileUrl)
    {
    	this.fileUrl = fileUrl;
    }
    
	public void appInit()
	{
		if(GODEvent.getInstancegod()){
			try
			{
				System.out.println("系统功能权限模块文件解析并进行数据库初始化，请稍后……");
				String fileName = null;
				File file = null;
				File f = new File(fileUrl);
		    	try {
					this.sqlSession = SessionFactory.getInstance().getSQLSession(this.dsname,ExecutorType.BATCH,false);
				} catch (Exception e) {
					String debug = DetailException.expDetail(e, PermissionConfig.class);
					log.debug(debug);
					throw e;
				}				
				/**删除所有模块权限数据*/
				//sqlSession.delete("permission.delete");
				int index = 0;
				for ( int i = 0 ; i < f.listFiles().length ; i ++ )
				{
					ArrayList<Permission> arrayList = new ArrayList<Permission>();
					try{
						file = f.listFiles()[i];
						fileName = file.getName();
						if (fileName.toLowerCase().indexOf("xml") > -1)
						{
							index++;
							if (f.exists())
							{
								/**读取XML文件并形成Permissions Bean 对象*/
								Permissions permissions = Permissions.getInstance(f+File.separator+fileName);
								arrayList = permissions.getPermissionList();
								System.out.println("第  "+(index)+" 个名称为: "+fileName+"的文件读取并解析成功！");						
							}
						}
					}
					catch (Exception e)
					{
						System.out.println("第  "+(index)+" 个名称为: "+fileName+"的文件读取并解析失败！");
						String debug = DetailException.expDetail(e, PermissionConfig.class);
						log.debug(debug);
						throw e;
					}
					try{
						if (arrayList != null && arrayList.size() > 0)
						{
							for (int d=0; d<arrayList.size(); d++)
							{
								Permission permission = arrayList.get(d);
								HashMap<String,String> pmap = new HashMap<String,String>();
								pmap.put("pmsIndex",permission.getIndex());
								pmap.put("pmsCode",permission.getCode());
								pmap.put("pmsParentCode",permission.getParentCode());
								pmap.put("pmsName",permission.getName());
								pmap.put("pmsType",permission.getType());
								pmap.put("pmsIsValid",permission.getIsValid());
								pmap.put("pmsDataSource",permission.getDataSource());
								pmap.put("pmsInitEvent",permission.getInitEvent());
								pmap.put("pmsDefaultEvent",permission.getDefaultEvent());
								pmap.put("pmsExtendEvent",permission.getExtendEvent());
								pmap.put("pmsDataHandlerBean",permission.getDataHandlerBean());
								pmap.put("pmsDesc","");
								pmap.put("pmsIcon",permission.getIcon());
								pmap.put("pmsDirectFile",permission.getDirectName());
								pmap.put("pmsTransaction",permission.getIsTransaction());
								pmap.put("pmsImitationStep",permission.getImitationStep());
								pmap.put("pmsCreateTime",DateUtil.getCurrentDateString(DateUtil.DATETIME_PATTERN));
								pmap.put("pmsBeforeExecuteCode",permission.getBeforeExecuteCode());
								pmap.put("pmsAfterExecuteCode",permission.getAfterExecuteCode());
								pmap.put("paixu",permission.getPaixu());
								pmap.put("pmsCreator","system");	
								//type = 0 权限添加到普通存放对象中
								if (permission.getType() != null && (permission.getType().equals("0") || permission.getType().equals("2")))
									Constant.PERMISSION_GLOBAL_LIST.add(pmap);
								Object obj = sqlSession.selectOne("permission.select_by_code", pmap);
								if (obj == null){
									sqlSession.insert("permission.insert", pmap);
								}
								else{
									String id = ((HashMap)obj).get("pmsID") == null ?"":((HashMap)obj).get("pmsID").toString();
									if (!id.equals("")){
										pmap.put("pmsID", id);
										sqlSession.update("permission.update", pmap);
									}
								}
							}
							System.out.println("第  "+(index)+" 个名称为: "+fileName+"数据库初始化成功！");
						}
					}catch(Exception e){
						System.out.println("第  "+(index)+" 个名称为: "+fileName+"数据库初始化失败！");
						String debug = DetailException.expDetail(e, PermissionConfig.class);
						log.debug(debug);
						throw e;
					}
				}
				/**提交事物*/
				if (sqlSession != null)
				{
					sqlSession.commit();
					sqlSession.close();
				}
				System.out.println("系统功能权限模块文件解析并进行数据库初始化成功！");
			}
			catch (Exception e)
			{
				/**提交事物*/
				if (sqlSession != null)
				{
					sqlSession.commit();
					sqlSession.close();
				}			
				String error = DetailException.expDetail(e, PermissionConfig.class);
				log.error(error);
				System.out.println("系统功能权限模块文件解析并进行数据库初始化失败！");
				/**只要只要配置文件读取解析失败或数据库初始化失败应用停止启动，退出*/
				System.exit(0);
			}		
		}
	}
}