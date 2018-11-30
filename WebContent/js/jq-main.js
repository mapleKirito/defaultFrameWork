
//图片详情
function showView(index){
	
	var param = $(index).attr("param");
	var code = $(index).attr("code");
	var name = $(index).attr("name");
	tabClick("ziayun",'资源详细',code,param);	
}
//图片详情
function showOtherView(this_){
	

}
//新标签跳转
function showView_redirect(index){
	
	var param = $(index).attr("param");
	var code = $(index).attr("code");
	
	var name = $(index).attr("name");
	tabClick_redirect("ziayun",'资源详细',code,param);	
}
// 分类资源
function message(objects,this_){
	//文物博览室
	if (objects == 'exhibition'){
		findChildCategory('exhibition',',0,1,',2,this_);
	}
	else if (objects == 'observation'){
		findChildCategory('observation',',0,219,',2,this_);
	}
	else if (objects == 'laboratory'){	
		findChildCategory('laboratory',',0,218,',2,this_);
	}//自助探究
	else if (objects == 'expand'){	
		findChildCategory('expand',',0,206,',2,this_);
	}
	else if (objects == 'projection'){
		findChildCategory('projection',',0,213,',2,this_);
	} 
	else if (objects == 'lovely'){
		findChildCategory('lovely',',0,259,',2,this_);
	}
	else if (objects == 'xiaoshiguan'){
		findChildCategory('xiaoshiguan',',0,600,',2,this_);
	}
	
}
function findChildCategory(roomtype,path,leval,this_) {
	
	var subMenu = $(this_).parent().find(".sub-menu");
	var Info = '';
	if($(this_).attr("key") == 0){
		$.ajax({
			url:		'ajaxAction.action?code=-0987&paramMap.catePath='+path+'&paramMap.cateLevel='+leval+'&suiji='+new Date().getTime(),
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					if (jsonData.data.length > 0) {
						
						for (var i = 0; i < jsonData.data.length; i++) {
						


						Info += '<dd subIndex='+i+'><a title="'+jsonData.data[i].cateName+'" key="0" href="javascript:void(0);" path="'+jsonData.data[i].catePath+'" lave ="'+(leval+1)+'" cateSign="'+roomtype+'" onclick="findChildCategory_sub(this)">'+jsonData.data[i].cateName+'</a></dd>';
						}
						subMenu.html(Info);
						$(this_).attr("key","1");
					}
				}
			},
			error:function(request,textStatus,error){}
		});
	}
}

function findChildCategory_sub(this_){
	
	tabColor(this_);
	var index_parent = $(this_).parent().attr("subIndex");
	var path = $(this_).attr("path");
	var lavi = $(this_).attr("lave");
	var cateSign = $(this_).attr("cateSign");
	if(path == ',0,206,207,'){
		tabClick("expand_0000","探究热身",'-17010',"path="+path+"&pageSize=8&type=1");
	}else if(path == ',0,206,208,'){
		tabClick("expand_0000","探究广场",'-13899',"path="+path+"&pageSize=8&type=1");
	}else if(path == ',0,206,212,'){
		tabClick("expand_0000","探究成果",'-14899',"path="+path+"&pageSize=8&type=1");
	}else{
	
		var paramPath =path.split(',');
		var param = "path="+path + "&pageSize=8&type=1";
		var path_length = paramPath.length;
		if (cateSign == 'exhibition'){
			 	if (  path_length == 5){//第一级
				
				param += "&paramMap.erTotalID=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.erJieID=" + paramPath[4];
			}
		}
		else if (cateSign == 'observation'){
			if (path_length == 5){
				param += "&paramMap.orCategory=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.orCateTwLevel=" + paramPath[4];
			}
		}
		else if (cateSign == 'laboratory'){
			if (path_length == 5){
				param += "&paramMap.lrCategory=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.lrCateTwLevel=" + paramPath[4];
			}
		}
		else if (cateSign == 'projection'){
			if (path_length == 5){
				param += "&paramMap.path="+path+"&paramMap.prCategory=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.prCateTwLevel=" + paramPath[4];
			}
		}
		else if (cateSign == 'lovely'){
			if (path_length == 5){
				param += "&paramMap.path="+path+"&paramMap.crResType=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.crCateTwLevel=" + paramPath[4];
			}
		}
		else if (cateSign == 'xiaoshiguan'){
			if (path_length == 5){
				param += "&paramMap.xrCategory=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.xrCateTwLevel=" + paramPath[4];
			}
		}
		//alert(param);
		tabClick(cateSign+"_name",'查询','-701',param +"&pageSize=8&type=1");	
		
	}

	var subMenu = $(this_).parent();
	var Info = '';
	if($(this_).attr("key") == 0){
		$.ajax({
			url:		'ajaxAction.action?code=-0987&paramMap.catePath='+path+'&paramMap.cateLevel='+lavi+'&suiji='+new Date().getTime(),
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					if (jsonData.data.length > 0) {
						
						for (var i = 0; i < jsonData.data.length; i++) {
							var cateName = "";
						if(jsonData.data[i].cateName.length>9){
							cateName = jsonData.data[i].cateName.substr(0,8)+'...';
						}else{
							cateName = jsonData.data[i].cateName;
						}
							 Info += '<dd class="sub_res'+index_parent+'  sub_res_sub" style="background:#E7E7E7;color:black;"><a  path="'+jsonData.data[i].catePath+'"  onclick="findChildCategory_sub_a(this)" style="color: black;"   href="javascript:void(0);" title="'+jsonData.data[i].cateName+'" >'+cateName+'</a></dd>';
						}
						$(this_).attr("key","1");
						subMenu.after(Info);
					}
				}
			},
			error:function(request,textStatus,error){}
		});
	}  else if($(this_).attr("key") == 1){
		$(this_).attr("key","2");
		subMenu = $(this_).parent().parent().find(".sub_res"+index_parent).hide();
	} else if($(this_).attr("key") == 2){
		$(this_).attr("key","1");
		subMenu = $(this_).parent().parent().find(".sub_res"+index_parent).show();
	}
}
function findChildCategory_sub_a(this_){
  
	tabColor(this_);
	var cateSign = $(this_).parent().parent().parent().attr("roomtype");
    var path = $(this_).attr("path");
    var paramPath =path.split(',');
	var param = "path="+path + "&pageSize=8&type=1";
	
	var path_length = paramPath.length;
	if (cateSign == 'exhibition'){
		if (  path_length == 5){//第一级
			param += "&paramMap.erTotalID=" + paramPath[3];
		}
		else if (path_length == 6){
			param += "&paramMap.erJieID=" + paramPath[4];
		}
	}
	else if (cateSign == 'observation'){
		if (path_length == 5){
			param += "&paramMap.orCategory=" + paramPath[3];
		}
		else if (path_length == 6){
			param += "&paramMap.orCateTwLevel=" + paramPath[4];
		}
	}
	else if (cateSign == 'laboratory'){
		if (path_length == 5){
			param += "&paramMap.lrCategory=" + paramPath[3];
		}
		else if (path_length == 6){
			param += "&paramMap.lrCateTwLevel=" + paramPath[4];
		}
	}
	else if (cateSign == 'projection'){
		if (path_length == 5){
			param += "&paramMap.path="+path+"&paramMap.prCategory=" + paramPath[3];
		}
		else if (path_length == 6){
			param += "&paramMap.prCateTwLevel=" + paramPath[4];
		}
	}
 	else if (cateSign == 'lovely'){
		if (path_length == 5){
			param += "&paramMap.path="+path+"&paramMap.crResType=" + paramPath[3];
		}
		else if (path_length == 6){
			param += "&paramMap.crCateTwLevel=" + paramPath[4];
		}
	}
	//alert(param);
	tabClick(cateSign+"_name",'查询','-701',param +"&pageSize=8&type=1");	
}



/*中国分类*/
 function findChildArea(this_) {
		var parent_id = $(this_).attr("id");
		var subMenu =  $(this_).parent().find(".sub-menu");
		var Info = '';
		if($(this_).attr("key") == 0){
			$.ajax({
				url:		'ajaxAction.action?code=-800&paramMap.id='+parent_id+'&suiji='+new Date().getTime(),
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					if (textStatus == "success"){
						if (jsonData.data.length > 0) {
							
							for (var i = 0; i < jsonData.data.length; i++) {
							
								Info += '<dd class="sub_res'+parent_id+'"  subIndex='+i+'><a key="0" path="'+jsonData.data[i].path+'" href="javascript:void(0);" id="'+jsonData.data[i].id+'" onclick="findChildArea_sub(this)"    >'+jsonData.data[i].name+'</a></dd>';
							
							}
							subMenu.html(Info);
						
							$(this_).attr("key","1");
						}
					}
				},
				error:function(request,textStatus,error){}
			});
		} else if($(this_).attr("key") == 1){
			$(this_).attr("key","2");
			subMenu = $(this_).parent().parent().find(".sub_res"+parent_id).hide();
		} else if($(this_).attr("key") == 2){
			$(this_).attr("key","1");
			subMenu = $(this_).parent().parent().find(".sub_res"+parent_id).show();
		}
		
	}
	
function findChildArea_sub(this_) {
	
	tabColor(this_);
	
	var parent_id = $(this_).attr("id");
	var subMenu = $(this_).parent();
	var parent_path = $(this_).attr("path");
	tabClick("省份查询",'查询','-801',"&path="+parent_path+"&paramMap.erProvince="+parent_id +"&pageSize=8&type=1");	
	var Info = '';
	if($(this_).attr("key") == 0){
		$.ajax({
			url:		'ajaxAction.action?code=-800&paramMap.id='+parent_id+'&suiji='+new Date().getTime(),
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					if (jsonData.data.length > 0) {
						
						for (var i = 0; i < jsonData.data.length; i++) {
					
							Info += '<dd class="sub_res'+parent_id+' sub_res_sub" subIndex='+i+' style="background:#E7E7E7;color:black;"><a key="0" path="'+jsonData.data[i].path+'" onclick="findChildArea_sub_city(this)"  href="javascript:void(0);" id="'+jsonData.data[i].id+'" style="color: black;"   href="javascript:void(0);">'+jsonData.data[i].name+'</a></dd>';
								
						}
						subMenu.after(Info);
					
						$(this_).attr("key","1");
					}
				}
			},
			error:function(request,textStatus,error){}
		});
	} else if($(this_).attr("key") == 1){
		$(this_).attr("key","2");
		subMenu = $(this_).parent().parent().find(".sub_res"+parent_id).hide();
	} else if($(this_).attr("key") == 2){
		$(this_).attr("key","1");
		subMenu = $(this_).parent().parent().find(".sub_res"+parent_id).show();
	}
	
}

function findChildArea_sub_city(this_){

	tabColor(this_);	
	var parent_id = $(this_).attr("id");
	var parent_path = $(this_).attr("path");
	
	tabClick("省份查询",'查询','-801',"&path="+parent_path+"&paramMap.erCity="+parent_id +"&pageSize=8&type=1");	

}
function tabColor(this_){
	var classFlag = $(this_).parent().parent().parent().attr("roomtype");
	
	$(".menu-nav dd").css("background","");
	$(".menu-nav").find(".sub_res_sub").css("background","#E7E7E7");
	
	//单签选中的变颜色
	$("."+classFlag+" .sub-menu dd").eq($(this_).parent().index()).css("background","#ca3d3d").siblings().css("background","");
	//颜色不同的变颜色
	$(this_).parent().parent().find(".sub_res_sub").css("background","#E7E7E7");
	//自己
	$("."+classFlag+" .sub-menu dd").eq($(this_).parent().index()).css("background","#ca3d3d");

}
function resType(this_,txt,name,code,param){
	var index_parent = $(this_).parent().attr("subIndex");
	tabColor(this_);
	tabClick(txt,name,code,param);
	if($(this_).attr("key") == 1){
		$(this_).attr("key","2");
		subMenu = $(this_).parent().parent().find(".sub_res"+index_parent).hide();
	} else if($(this_).attr("key") == 2){
		$(this_).attr("key","1");
		subMenu = $(this_).parent().parent().find(".sub_res"+index_parent).show();
	}
}
function tabSetting(this_){
	tabColor(this_);	

	var id_li_a = $(this_).attr("id");
	if(id_li_a == '003015'){
		var ip=GetLocalIPAddr();
	
		tabClickHref(ip+"/UniteCount-school/SetMsgServlet");
	}else{
		
		tabClick("系统维护",'系统维护',id_li_a,"&pageSize=8&type=1");	
	}
}

//
function GetLocalIPAddr(){ 
	 var url=window.location.href;
 	 var startoint = url.indexOf("//");
 	 var endPoint = url.indexOf("8086");
 	 return url.substring(startoint, endPoint+4);

	 }
function insert_fav(_this){
	  var id = $(_this).attr("id");
	  id = encodeURI(id);
	  id = encodeURI(id);
	  $.ajax({
			//ajax请求url
			url:		'ajaxAction.action?code=-701014&paramMap.param=' +id,
			//ajax提交方式
			type:	    'post',
			//ajax请求超时时长
			timeout:	'60000',
			//ajax请求参数
			data:	Array(),
			//////////////
			contentType: "application/json; charset=utf-8",
			//请求数据类型，包括json和xml两种
			dataType:	'json',
			//ajax执行前调用函数
			beforeSend:function(request){},
			//ajax请求完成后调用函数
			complete:function(request,textStatus){},
			//ajax请求成功调用函数
			success:function(jsonData,textStatus){
				//如果正常返回,设置GRIDTREE.data.tableTreeData
				//为ajax请求放回的json格式的数据
				
				if (textStatus == "success"){
					
					if(jsonData.content!=null){
						alert(jsonData.content); 
					}
						
				}
			},
			//ajax请求错误后调用函数
			error:function(request,textStatus,error){
			}
		});  
}