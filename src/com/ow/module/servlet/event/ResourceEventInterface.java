package com.ow.module.servlet.event;

import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;

public interface ResourceEventInterface {
	
	public String insert(ServletContext context, HttpServletRequest request, SqlSession sqlSession, HashMap<String,String> paramMap) ;
	
	public String update(ServletContext context, HttpServletRequest request, SqlSession sqlSession, HashMap<String,String> paramMap) ;
}
