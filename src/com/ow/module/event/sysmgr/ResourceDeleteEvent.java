package com.ow.module.event.sysmgr;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;

/**
 * 
 * 删除资源类
 * 删除数据之后，将资源文件删除
 * 
 */
public class ResourceDeleteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ResourceDeleteEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			String selectRes = eventExecutor.getSqlidArr()[0];	//查询当前资源ID
			String delResource = eventExecutor.getSqlidArr()[1];	//删除资源表
			String delRes = eventExecutor.getSqlidArr()[2];	//删除资源信息表
			String delGrade = eventExecutor.getSqlidArr()[3];	//删除适用学段、年级信息表
			String delReviw = eventExecutor.getSqlidArr()[4];	//删除评论
			HashMap parmap = eventExecutor.getBaseAction().getParamMap();
			
			List<Object> list = eventExecutor.getSqlSession().selectList(selectRes,parmap) ;
			for(Object one : list){
				if(one != null){
					if(one instanceof HashMap){
						String resType = (String) parmap.get("rrResourceType") ;
						if("exhibition".equals(resType)) {	
							BigDecimal resID = (BigDecimal)(((HashMap<String,BigDecimal>)one).get("erID"));
							parmap.put("erID", resID.toString()) ;
							parmap.put("srPID", resID.toString()) ;
							parmap.put("srPtype", "exhibition") ;
						}else if("observation".equals(resType)) {	
							BigDecimal resID = (BigDecimal)(((HashMap<String,BigDecimal>)one).get("orID"));
							parmap.put("orID", resID.toString()) ;
							parmap.put("srPID", resID.toString()) ;
							parmap.put("srPtype", "observation") ;
						}else if("laboratory".equals(resType)) {	
							BigDecimal resID = (BigDecimal)(((HashMap<String,BigDecimal>)one).get("lrID"));
							parmap.put("lrID", resID.toString()) ;
							parmap.put("srPID", resID.toString()) ;
							parmap.put("srPtype", "laboratory") ;
						}else if("projection".equals(resType)) {	
							BigDecimal resID = (BigDecimal)(((HashMap<String,BigDecimal>)one).get("prID"));
							parmap.put("prID", resID.toString()) ;
							parmap.put("srPID", resID.toString()) ;
							parmap.put("srPtype", "projection") ;
						}else if("lovely".equals(resType)) {	
							BigDecimal resID = (BigDecimal)(((HashMap<String,BigDecimal>)one).get("crID"));
							parmap.put("crID", resID.toString()) ;
							parmap.put("srPID", resID.toString()) ;
							parmap.put("srPtype", "lovely") ;
						}
						
						try{
							int rvalue = eventExecutor.getSqlSession().delete(delResource, parmap);
							
							rvalue = eventExecutor.getSqlSession().delete(delRes, parmap);
							
							rvalue = eventExecutor.getSqlSession().delete(delGrade, parmap);
							
							rvalue = eventExecutor.getSqlSession().delete(delReviw, parmap);
							
							rvalue = eventExecutor.getSqlSession().delete("recom.delete_by_resid", parmap);
							
							resultData.setIntResult(1);
							
						}
						catch (Exception e){
							e.printStackTrace();
						}

						DBUtil.modifyCategoryStatus(eventExecutor, one, resType) ;
						
					}
				}
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ResourceDeleteEvent.class);
			log.error(error);
			throw e;
		}
	}
}