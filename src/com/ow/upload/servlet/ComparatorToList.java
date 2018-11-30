package com.ow.upload.servlet;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ComparatorToList implements Comparator{

	@Override
	public int compare(Object arg0, Object arg1) {
		// TODO Auto-generated method stub
		String s1="",s2="";
		int a1=0,a2=0;
		Map<String, Object> map1 = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		try{
			map1 = (Map<String, Object>)arg0;
			map2 = (Map<String, Object>)arg1;
			
			s1 = (String)map1.get("fileType");
			s2 = (String)map2.get("fileType");
			
			a1 = Integer.parseInt(s1);
			a2 = Integer.parseInt(s2);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("package com.ow.upload.servlet.ComparatorToList出错");
			
		}
		
	
		/*for(Object o : list1){
			s1 = (String)map1.get("fileType");
		}
		for(Object o : list2){
			s2 = (String)map2.get("fileType");
		}*/
		
		return a2-a1;

	}

}
