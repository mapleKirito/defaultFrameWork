package com.staticHtml.util;

import java.util.List;

public class Worker extends Thread {
	private List<InitStaticHtml> workList;

	public List<InitStaticHtml> getWorkList() {
		return workList;
	}

	public void setWorkList(List<InitStaticHtml> workList) {
		this.workList = workList;
	}

	private boolean init(){
		boolean rslt=true;
		if(workList!=null&&workList.size()>0){
			System.out.println("===>list size:"+workList.size());
		}else{
			System.out.println("===>workList is null");
			rslt=false;
		}
		
		
		return rslt;
		
	}
	
	private void doWork(){
		boolean isEnd=false;
		while(!isEnd){
			workList.get(0).run();
			if(workList.size()>1){
				workList.remove(0);
			}else{
				isEnd=true;
			}
		}
	}
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
		System.out.println();
		System.out.println("===>worker init");
		if(init()){
			System.out.println("===>working...");
			doWork();
		}
		
	}
	
	
}
