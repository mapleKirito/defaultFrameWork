function res_funtion(objects){
	//alert(objects);
	if (objects == 'exhibition'){
		window.parent.window.parent.tabClick("exhibition_0000","文物博览室",'-701',"path=,0,1,&pageSize=8&type=1");
	}
	else if (objects == 'observation'){
		window.parent.tabClick("observation_0000","专题研读室",'-701',"path=,0,219,&pageSize=8&type=1");
	}
	else if (objects == 'laboratory'){	
		window.parent.tabClick("laboratory_0000","教学研究室",'-701',"path=,0,218,&pageSize=8&type=1");
	}
	else if (objects == 'projection'){	
		window.parent.tabClick("projection_0000","影像资料室",'-701',"path=,0,213,&pageSize=8&type=1");
	}
	/*else if (objects == 'expand'){
		window.parent.tabClick("expand_0000","自主探究室",'-701',"path=,0,203&pageSize=8&type=1");
	}*/
	
	//文物博览室  子分类
	
	else if (objects == 'exhibition_1'){
		window.parent.tabClick("exhibition_1","春秋战国时期",'-701',"path=,0,1,2,&paramMap.erCategory=2&pageSize=8&type=1");
	}
	else if (objects == 'exhibition_2'){	
		window.parent.tabClick("exhibition_2","辽宋金元时期",'-701',"path=,0,1,26,&paramMap.erCategory=26&pageSize=8&type=1");
	}
	else if (objects == 'exhibition_3'){	
		window.parent.tabClick("exhibition_3","明清时期",'-701',"path=,0,1,51,&paramMap.erCategory=51&pageSize=8&type=1");
	}
	else if (objects == 'exhibition_4'){
		window.parent.tabClick("exhibition_4","秦汉时期",'-701',"path=,0,1,77,&paramMap.erCategory=77&pageSize=8&type=1");
	}
	else if (objects == 'exhibition_5'){
		window.parent.tabClick("exhibition_5","三国两晋南北朝",'-701',"path=,0,1,100,&paramMap.erCategory=100&pageSize=8&type=1");
	}
	else if (objects == 'exhibition_6'){	
		window.parent.tabClick("exhibition_6","隋唐五代时期",'-701',"path=,0,1,113,&paramMap.erCategory=113&pageSize=8&type=1");
	}
	else if (objects == 'exhibition_7'){	
		window.parent.tabClick("exhibition_7","夏商周时期",'-701',"path=,0,1,135,&paramMap.erCategory=135&pageSize=8&type=1");
	}
	else if (objects == 'exhibition_8'){
		window.parent.tabClick("exhibition_8","原始社会",'-701',"path=,0,1,150,&paramMap.erCategory=150&pageSize=8&type=1");
	}
	else if (objects == 'exhibition_9'){
		window.parent.tabClick("exhibition_8","中国近代史",'-701',"path=,0,1,159,&paramMap.erCategory=159&pageSize=8&type=1");
	}
	
	//专题研读室  子分类
	
	else if (objects == 'observation_1'){
		window.parent.tabClick("observation_1","艺术史",'-701',"path=,0,219,227,&paramMap.orCategory=227&pageSize=8&type=1");
	}
	else if (objects == 'observation_2'){	
		//alert(123465);
		window.parent.tabClick("observation_2","近现代历史人物",'-701',"path=,0,219,228,&paramMap.orCategory=228&pageSize=8&type=1");
	}
	else if (objects == 'observation_3'){	
		window.parent.tabClick("observation_3","政治制度史",'-701',"path=,0,219,224,&paramMap.orCategory=224&pageSize=8&type=1");
	}
	else if (objects == 'observation_4'){
		window.parent.tabClick("observation_4","思想史",'-701',"path=,0,219,226,&paramMap.orCategory=226&pageSize=8&type=1");
	}
	else if (objects == 'observation_5'){
		window.parent.tabClick("observation_5","经济制度史",'-701',"path=,0,219,225,&paramMap.orCategory=225&pageSize=8&type=1");
	}
	else if (objects == 'observation_6'){
		window.parent.tabClick("observation_6","历史与社会",'-701',"path=,0,219,239,&paramMap.orCategory=239&pageSize=8&type=1");
	}
		
	//影像资料室  子分类
	
	else if (objects == 'projection_1'){
		window.parent.tabClick("projection_1","近代影像资料",'-701',"path=,0,213,214,&paramMap.prCategory=214&pageSize=8&type=1");
	}
	else if (objects == 'projection_2'){	
		window.parent.tabClick("projection_2","纪录片",'-701',"path=,0,213,215,&paramMap.prCategory=215&pageSize=8&type=1");
	}
	else if (objects == 'projection_3'){	
		window.parent.tabClick("projection_3","科学还原",'-701',"path=,0,213,217,&paramMap.prCategory=217&pageSize=8&type=1");
	}
	else if (objects == 'projection_4'){
		window.parent.tabClick("projection_4","历史剧",'-701',"path=,0,213,216,&paramMap.prCategory=216&pageSize=8&type=1");
	}
	
	/*//情系探究 子分类
	
	else if (objects == 'lovely_1'){
		window.parent.tabClick("lovely_1","家乡探秘",'-701',"path=,0,259,260,&pageSize=8&type=1");
	}
	else if (objects == 'lovely_2'){	
		window.parent.tabClick("lovely_2","校园追风",'-701',"path=,0,259,265,&pageSize=8&type=1");
	}*/
	
	//教学研究室  子分类
	
	else if (objects == 'laboratory_1'){
		window.parent.tabClick("laboratory_1","课件参考",'-701',"path=,0,218,221,&paramMap.lrCategory=221&pageSize=8&type=1");
	}
	else if (objects == 'laboratory_2'){	
		window.parent.tabClick("laboratory_2","微课程",'-701',"path=,0,218,222,&paramMap.lrCategory=222&pageSize=8&type=1");
	}
	else if (objects == 'laboratory_3'){	
		window.parent.tabClick("laboratory_3","集体备课",'-701',"path=,0,218,223,&paramMap.lrCategory=223&pageSize=8&type=1");
	}
	
	//自主探究 子分类
	
	else if (objects == 'expand_1'){
		window.parent.tabClick("expand_0000","探究热身",'-17010',"path=,0,206,207,&paramMap.erCategory=207&pageSize=8&type=1");
	}
	else if (objects == 'expand_2'){	
		window.parent.tabClick("expand_0000","探究广场",'-13899',"path=,0,206,208,&paramMap.erCategory=208&pageSize=8&type=1");
	}
	else if (objects == 'expand_3'){
		window.parent.tabClick("expand_0000","探究成果",'-14899',"path=,0,206,212,&paramMap.erCategory=212&pageSize=8&type=1");		
	}
	//情系家园分类
	
	else if (objects == 'lovecountry_1'){
		window.parent.tabClick("lovecountry_1","家乡探秘",'-701',"path=,0,259,260,&paramMap.crResType=260&pageSize=8&type=1");
	}
	else if (objects == 'lovecountry_2'){	
		window.parent.tabClick("lovecountry_2","校园追风",'-701',"path=,0,259,265,&paramMap.crResType=265&pageSize=8&type=1");
	}
	
}
function showInfo(id){
	/*var curWwwPath=window.document.location.href; 
	var pathName=window.document.location.pathname;*/ 
	
	window.parent.art.dialog.data('contextPath', '<%=request.getContextPath()%>');
	window.parent.art.dialog.open('forwardAction.action?code=-9009&paramMap.newsID='+id,{width:1299,tu_big:0,height:299,title:'详细信息',lock:'true',background:'#666666',opacity: '0.15'}) ;

}

function showMoreInfo(){
	/*var curWwwPath=window.document.location.href; 
	var pathName=window.document.location.pathname;*/ 
	
	window.parent.art.dialog.data('contextPath', '<%=request.getContextPath()%>');
	window.parent.art.dialog.open('forwardAction.action?code=-003018',{width:1299,tu_big:0,height:299,title:'详细信息',lock:'true',background:'#666666',opacity: '0.15'}) ;

}