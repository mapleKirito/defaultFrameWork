package com.ow.framework.data.handler.config;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Properties;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.dao.SessionFactory;
import com.ow.framework.data.handler.IHandlerCriteria;
import com.ow.framework.exception.DetailException;

/**
 * 服务器 数据库 初始化 配置
 */
public class ServerSqlConfig implements IHandlerCriteria {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	/**初始化文件的路径*/
	private String fileUrl = "server-sql-config.properties";
	/**数据源名称*/
	private String dsname;
	/**数据库操作SqlSession对象,获取事物方式sqlsession*/
	private SqlSession sqlSession;
    /**
     * fileUrl is a folder
     * @param fileUrl
     */
	public ServerSqlConfig(String fileUrl, String dsname) {
		this.fileUrl = fileUrl ;
		this.dsname = dsname;
	}

	public ServerSqlConfig(String dsname) {
		this.dsname = dsname;
	}
    
    public void appInit() {
		try {
			/**为数据库表设置主键起始值*/
			Properties readServerSqlProps=new Properties();
			readServerSqlProps.load(new FileInputStream(this.fileUrl));
			String startPrimaryKey = readServerSqlProps.getProperty("start_primary_key") ;
			try{
				Constant.initSnNO = Integer.parseInt(startPrimaryKey) == 0 ? 1 : Integer.parseInt(startPrimaryKey) ;
			}catch(Exception e){}
			String isStart = readServerSqlProps.getProperty("is_start") ;
			if("true".equals(isStart) && !"0".equals(startPrimaryKey)){
				System.out.println("系统数据库主键起始值初始化，请稍后……");
		    	/*try {
					this.sqlSession = SessionFactory.getInstance().getSQLSession(this.dsname,ExecutorType.BATCH,false);
				} catch (Exception e) {
					String debug = DetailException.expDetail(e, ServerSqlConfig.class);
					log.debug(debug);
					throw e;
				}
				String tables = Constant.exportTable ;
				String[] table = tables.split(",") ;
				Connection conn = null ;
				Statement st = null ;
				try{
					conn = sqlSession.getConnection() ;
					st = conn.createStatement() ;
					for ( int i = 0 ; i < table.length ; i ++ ) {
						String sql = "ALTER TABLE "+table[i]+" AUTO_INCREMENT=" + startPrimaryKey ;
						st.executeUpdate(sql) ;
					}
				}catch(Exception e){
					System.out.println("数据库执行主键初始化失败！");
					String debug = DetailException.expDetail(e, ServerSqlConfig.class);
					log.debug(debug);
					throw e;
				}finally{
					st.close();
					//conn.close();
				}
				FileOutputStream fos=null ;
				try{
					readServerSqlProps.setProperty("is_start", "true") ;
					fos=new FileOutputStream(this.fileUrl) ;
					readServerSqlProps.store(fos, "已经初始化完成！") ;
				}finally{
					fos.close();
				}
				
				
				*//**提交事物*//*
				if (sqlSession != null)
				{
					sqlSession.commit();
					sqlSession.close();
				}*/
				System.out.println("系统数据库主键起始值初始化成功！");
			}
		}
		catch (Exception e)
		{
			/**提交事物*/
			if (sqlSession != null)
			{
				sqlSession.commit();
				sqlSession.close();
			}			
			String error = DetailException.expDetail(e, ServerSqlConfig.class);
			log.error(error);
			System.out.println("系统数据库主键起始值初始化失败！");
			/**只要只要配置文件读取解析失败或数据库初始化失败应用停止启动，退出*/
			System.exit(0);
		}		
	}
    
    
}
