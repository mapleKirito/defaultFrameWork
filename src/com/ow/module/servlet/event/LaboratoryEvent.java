package com.ow.module.servlet.event;

import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;

public class LaboratoryEvent implements ResourceEventInterface {

	@Override
	public String insert(ServletContext context, HttpServletRequest request,
			SqlSession sqlSession, HashMap<String, String> paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String update(ServletContext context, HttpServletRequest request,
			SqlSession sqlSession, HashMap<String, String> paramMap) {
		// TODO Auto-generated method stub
		return null;
	}
}
