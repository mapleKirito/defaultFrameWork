package com.ow.framework.data.dao;

import java.util.HashMap;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;

public class SessionFactory {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
    /**多数据库SessionFactory，按源名称，全局存储*/    
	private HashMap<String,SqlSessionFactory> sqlSessionFactoryMap = new HashMap<String,SqlSessionFactory>();
	private static SessionFactory sqlSessionfactory = null;
	
	private SessionFactory(){}
	
	/**
	 * 单例模式，实例化工厂类
	 * @return
	 */
	public synchronized static SessionFactory getInstance()
	{
		if (sqlSessionfactory == null)
		{
			sqlSessionfactory = new SessionFactory();
			return(sqlSessionfactory);
		}
		else
		{
			return(sqlSessionfactory);
		}
	}	
	
	/**
	 * 获得sqlsession 进行数据库操作
	 * @param dsname 数据源名称
	 * @param et  ExecutorType.BATCH;
				ExecutorType.REUSE;
				ExecutorType.SIMPLE
	 * @param autoCommit 是否自动提交  缺省为false 
	 * @return
	 * @throws Exception
	 */
	public SqlSession getSQLSession(String dsname,ExecutorType et , boolean autoCommit)throws Exception{
		SqlSessionFactory  sf  = this.sqlSessionFactoryMap.get(dsname)==null?null:sqlSessionFactoryMap.get(dsname);
		SqlSession ss = null;
		if(sf==null){
			throw new RuntimeException("there's no such name database :"+dsname);
		}
		ss = sf.openSession(et, autoCommit);
		return ss;
		
	}
	
	
	
	/**
	 * 获得sqlsession 进行数据库操作
	 * @param dsname 数据源名称
	 * @param et  ExecutorType.BATCH;
				ExecutorType.REUSE;
				ExecutorType.SIMPLE
	 * @param autoCommit 是否自动提交  缺省为false 
	 * @return
	 * @throws Exception
	 */
	public SqlSession getSQLSession(String dsname)throws Exception{ 
		SqlSessionFactory  sf  = this.sqlSessionFactoryMap.get(dsname)==null?null:sqlSessionFactoryMap.get(dsname);
		SqlSession ss = null;
		if(sf==null){
			throw new RuntimeException("there's no such name database :"+dsname);
		}
		ss = sf.openSession();
		return ss;
	}

	public HashMap<String, SqlSessionFactory> getSqlSessionFactoryMap() {
		return sqlSessionFactoryMap;
	}

	public void setSqlSessionFactoryMap(
			HashMap<String, SqlSessionFactory> sqlSessionFactoryMap) {
		this.sqlSessionFactoryMap = sqlSessionFactoryMap;
	}
}
