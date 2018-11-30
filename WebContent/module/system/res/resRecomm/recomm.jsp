<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title></title>
<head>
<link href="<%=request.getContextPath()%>/qc/css/style.css" rel="stylesheet" />
 <script src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<style type="text/css">
.my-answer.tabcontrol {
margin-top: 0px;border: 1px solid #E2E2E2;padding-bottom: 30px;}
.my-answer-list ul{float: left;}
.my-answer-list li{height:140px;width: 139px;float: left;border-bottom: 0px dotted #979797;}
.tabcontrol .tabcontents {
border: 0px solid #E2E2E2;}
.tabcontrol div.tabtitle-bg {
border-right: 1px solid #E2E2E2;border-left: 1px solid #E2E2E2;
border-bottom: 1px solid #E2E2E2;border-top: 0px solid #E2E2E2;}
.my-answer-list li p{;
height: 25px;
line-height: 25px;width: 130px;}
.search-box{width: 686px;margin-bottom: 20px;}
.search-box input[type="text"] {
width: 640px;}
</style>
<script type="text/javascript">
$(document).ready(function(){
if(IEversion()<= 8){
	$("#search_res").css({
		"padding-left":"50px",
		"line-height":"50px",
		"text-indent":"0px"
	});
	
		}else if(IEversion()== 9 ){}
		
});
function getValue(name_id){
	
	if(document.frames){
       
		return $(parent.document.frames['mainFrameWelcome'].document.getElementById(name_id)).val();
    	 
     }else{
          
    	 return $(parent.document.getElementById('mainFrameWelcome').contentWindow.document.getElementById(name_id)).val();
    	
     }
   
}
//关键字 显示隐藏
function viewsidden(resID,_this){
	
	var viewID = resID+",";
	var flag= $(_this).attr("flag");

	if(flag == 1){
		
		//隐藏该数据
		var relations = getValue('relations');
		
		setValue('relations',relations+viewID);
		$(_this).attr("flag","0");
		$(_this).html("已隐藏");
		
	}else if(flag == 0){
		
		//显示该数据
		var relations = getValue('relations');
		
		if(relations.indexOf(viewID)==0){
			relations = relations.substr(viewID.length,relations.length-1);
		}else{
			relations = relations.replace(","+resID+",",",");
		}
		setValue('relations',relations);
		$(_this).attr("flag","1");
		$(_this).html("显示");
	}
	
}

//设置关键字 显示隐藏 方法
function setValue(name_id,relations){

    if(document.frames){
           
    	 $(parent.document.frames['mainFrameWelcome'].document.getElementById(name_id)).val(relations);
    	 
     }else{
         $(parent.document.getElementById('mainFrameWelcome').contentWindow.document.getElementById(name_id)).val(relations);

     }
   
}

//设置名称匹配显示隐藏 方法
function setRelation(_this,id){

		var roomtype = $(_this).attr("roomtype"); 
		var relaID = roomtype+"-"+id+",";
		var flag= $(_this).attr("flag");
		if(flag == 1){
			//隐藏该数据
			var relations = getValue('setRelations');
			
			
			if(relations.indexOf(relaID)==0){
				relations = relations.substr(relaID.length,relations.length-1);
			}else{
				relations = relations.replace(","+relaID+"",",");
			}
			setValue('setRelations',relations);
			$(_this).attr("flag","0");
			$(_this).html("未关联");
			
		}else if(flag == 0){
			
			//显示该数据
			var relations = getValue('setRelations');
			
			if(relations.indexOf(relaID)==0){
				relations = relations.substr(relaID.length,relations.length-1);
			}else{
				relations = relations.replace(","+relaID+"",",");
			}
			setValue('setRelations',relations+relaID);
			$(_this).attr("flag","1");
			$(_this).html("已关联");
		}
}

//搜索 名称匹配 keywords 更多按钮
$(".search_keywords_more").die().live("click",function(){
	var t = $(this);
	var status = $(this).data("status");
	if(status=="ini"){
		var currentTime= new Date().getTime();
		$(this).html('加载中，请稍等...');
		$("#more_keywords").removeClass("search_keywords_more");
		var keyWords=$("#keyword").val();
		keyWords = encodeURI(keyWords);
		keyWords = encodeURI(keyWords); 
		$.ajax({
			url:		"ajaxAction.action?code=-110001005&paramMap.keyWords="+keyWords+"&paramMap.s_start="+$("#s_start_keyword").val()+"&paramMap.offsetAbout=10&suiji="+currentTime,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					if(jsonData.data.length>0){	
					 var tem = "";
						for (var i=0; i<jsonData.data.length;i++){							
							var cateName = jsonData.data[i].name;
							var catePath = jsonData.data[i].thumbnail;
							var cateId = jsonData.data[i].id;
							var resType = jsonData.data[i].resType;
							var inThum = jsonData.data[i].thumbnail;	
							var about = jsonData.data[i].about;
							
							if(cateName.length>5){
								cateName = cateName.substr(0,5)+'...';
							}
							
							tem += '<li> <a href="javascript:void(0);"  >';
							tem += '<img src="'+inThum+'" width="130" height="110"></a>';
							tem += '<p>'+cateName;
		     				
							tem += '<span style="float:right;"><a href="javascript:void(0);" >';
							
	     					
	     					tem +='</a></span></p></li>';
						}
						
						$("#search_keywords_list").append(tem);
					    $("#more_keywords").addClass("search_keywords_more");
					}else{
						t.data("status","end");
						t.html('已经全部加载，没有更多了^o^');
					}
					if(jsonData.data.length>=10){
						$("#s_start_keyword").val(parseInt($("#s_start_keyword").val())+10);
						t.html('更多消息');
					}else{
						t.data("status","end");
						t.html('已经全部加载，没有更多了^o^');
					} 	
				}
			},
			error:function(request,textStatus,error){}
		});
	}
});
//同级分类 更多按钮
$(".search_cate_more").die().live("click",function(){
	var t = $(this);
	var status = $(this).data("status");
	if(status=="ini"){
		var currentTime= new Date().getTime();
		$(this).html('加载中，请稍等...');
		$("#more").removeClass("search_cate_more");
		var href = "";
		if($("#roomtype").val() == "exhibition"){
			href = "ajaxAction.action?code=-110001004&paramMap.resType="+$("#resType").val()+"&paramMap.roomtype=exhibition&paramMap"+$("#resID").attr("info")+"="+$("#resID").val()
					+"&paramMap.erGenusID="+$("#erGenusID").val()
					+"&paramMap.erCategory="+$("#erGenusID").val()
					+"&paramMap.erOrderID="+$("#erGenusID").val()
					+"&paramMap.erGangID="+$("#erGenusID").val()
					+"&paramMap.erChorID="+$("#erChorID").val()
					+"&paramMap.erJieID="+$("#erJieID").val()
					+"&paramMap.s_start="+$("#s_start").val()+"&paramMap.offsetAbout=10&suiji="+currentTime;
		}else if($("#roomtype").val() == "observation"){
			href = "ajaxAction.action?code=-110001004&paramMap.resType="+$("#resType").val()+"&paramMap.roomtype=observation&paramMap"+$("#resID").attr("info")+"="+$("#resID").val()
			+"&paramMap.orCategory="+$("#orCategory").val()
			+"&paramMap.orCateTwLevel="+$("#orCateTwLevel").val()
			+"&paramMap.s_start="+$("#s_start").val()+"&paramMap.offsetAbout=10&suiji="+currentTime;
		}else if($("#roomtype").val() == "laboratory"){
			href = "ajaxAction.action?code=-110001004&paramMap.resType="+$("#resType").val()+"&paramMap.roomtype=laboratory&paramMap"+$("#resID").attr("info")+"="+$("#resID").val()
			+"&paramMap.lrCategory="+$("#lrCategory").val()
			+"&paramMap.lrCateTwLevel="+$("#lrCateTwLevel").val()
			+"&paramMap.s_start="+$("#s_start").val()+"&paramMap.offsetAbout=10&suiji="+currentTime;
		}else if($("#roomtype").val() == "projection"){
			href = "ajaxAction.action?code=-110001004&paramMap.resType="+$("#resType").val()+"&paramMap.roomtype=projection&paramMap"+$("#resID").attr("info")+"="+$("#resID").val()
			+"&paramMap.prCategory="+$("#prCategory").val()
			+"&paramMap.prCateTwLevel="+$("#prCateTwLevel").val()
			+"&paramMap.s_start="+$("#s_start").val()+"&paramMap.offsetAbout=10&suiji="+currentTime;
		}else if($("#roomtype").val() == "lovely"){
			href = "ajaxAction.action?code=-110001004&paramMap.resType="+$("#resType").val()+"&paramMap.roomtype=lovely&paramMap"+$("#resID").attr("info")+"="+$("#resID").val()
			+"&paramMap.crCategory="+$("#crCategory").val()
			+"&paramMap.crCateTwLevel="+$("#crCateTwLevel").val()
			+"&paramMap.s_start="+$("#s_start").val()+"&paramMap.offsetAbout=10&suiji="+currentTime;
		}
		//ajax调用vc
		$.ajax({
			url:		href,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				 if(jsonData.data.length>0){	
						
					 var tem = "";
						for (var i=0; i<jsonData.data.length;i++){							
							var cateName = jsonData.data[i].name;
							var thumbnail = jsonData.data[i].thumbnail;
							var id = jsonData.data[i].id;
							var viewflag = jsonData.data[i].viewflag;
							var showInfo = "显示";
							if(viewflag == 0){
								showInfo = "已隐藏";
							}
							if(cateName.length>5){
								cateName = cateName.substr(0,5)+'...';
							}
							 
							tem += '<li> <a href="javascript:void(0);"  >';
							tem += '<img src="'+thumbnail+'" width="130" height="110"></a>';
							tem += '<p>'+cateName;
		     				
							tem += '<span style="float:right;"><a href="javascript:void(0);"  onclick="viewsidden('+id+',this)" flag="'+viewflag+'">';
							
							tem += showInfo;
	     					
	     					tem +='</a></span></p></li>';
						}
						
						$("#search_cate_list").append(tem);
					    $("#more").addClass("search_cate_more");
					}else{
						t.data("status","end");
						t.html('已经全部加载，没有更多了^o^');
					}
					if(jsonData.data.length>=10){
						$("#s_start").val(parseInt($("#s_start").val())+10);
						t.html('更多消息');
					}else{
						t.data("status","end");
						t.html('已经全部加载，没有更多了^o^');
					} 
			 },
			
			error:function(request,textStatus,error){alert(error);}
	   });
	}
});


//搜索名称匹配按钮
$("#search_btn_res_name").die().live("click",function(){
	var keyword = $("#search_res").val() ;
	var title = "查询资源" ;
	if(keyword==''){
	   return false;
	}
	keyword = encodeURI(keyword);
	keyword = encodeURI(keyword); 
	var relations = getValue('setRelations');
	var currentTime= new Date().getTime();
	
	$.ajax({
		url:		'ajaxAction.action?code=-110001006&paramMap.keyword=' + keyword+"&paramMap.relations="+relations+"&paramMap.s_start=0&suiji="+currentTime,
		type:	    'post',
		timeout:	'60000',
		data:	Array(), 
		dataType:	'json',
		beforeSend:function(request){},//ajax执行前调用函数
		complete:function(request,textStatus){},//ajax请求完成后调用函数
		success:function(jsonData,textStatus){//ajax请求成功调用函数
			 if(jsonData.data.length>0){	
				$("#seacherRes").html("");
				if (jsonData.data.length>0){
					var tem = "";
					for (var i=0; i<jsonData.data.length;i++){							
						var cateName = jsonData.data[i].name;
						var thumbnail = jsonData.data[i].thumbnail;
						var roomtype = jsonData.data[i].roomtype;
						var id = jsonData.data[i].id;
						var flag = jsonData.data[i].flag;
						var showInfo = "未关联";
						if(flag == 1){
							showInfo = "已关联";
						}
						
						if(cateName.length>5){
							cateName = cateName.substr(0,5)+'...';
						}
						
						tem += '<li> <a href="javascript:void(0);"  >';
						tem += '<img src="'+thumbnail+'" width="130" height="110"></a>';
						tem += '<p>'+cateName;
	     				
						tem += '<span style="float:right;"><a href="javascript:void(0);"  flag="'+flag+'" roomtype="'+roomtype+'"  onclick="setRelation(this,'+id+')">';
						tem += showInfo;			
   					tem +='</a></span></p></li>';
					}
					
					$("#seacherRes").append(tem);
				}
			} 
			
		},
		
		error:function(request,textStatus,error){}
		
	});
});
//搜索 更多按钮
$(".search_search_more").die().live("click",function(){
	
	var keyword = $("#search_res").val() ;
	var title = "查询资源" ;
	if(keyword==''){
	   return false;
	}
	keyword = encodeURI(keyword);
	keyword = encodeURI(keyword); 

	var t = $(this);
	var status = $(this).data("status");
	if(status=="ini"){
		var currentTime= new Date().getTime();
		$(this).html('加载中，请稍等...');
		$("#more_search").removeClass("search_search_more");
		var href = "";
		var relations = getValue('setRelations');
		//ajax调用vc
		$.ajax({
			url:		"ajaxAction.action?code=-110001006&paramMap.keyword="+keyword+"&paramMap.relations="+relations+"&paramMap.s_start="+$("#s_start_search").val()+"&suiji="+currentTime,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				 if(jsonData.data.length>0){	
						
					 var tem = "";
						for (var i=0; i<jsonData.data.length;i++){							
							var cateName = jsonData.data[i].name;
							var thumbnail = jsonData.data[i].thumbnail;
							var roomtype = jsonData.data[i].roomtype;
							var id = jsonData.data[i].id;
							var flag = jsonData.data[i].flag;
							var showInfo = "未关联";
							if(flag == 1){
								showInfo = "已关联";
							}
							if(cateName.length>5){
								cateName = cateName.substr(0,5)+'...';
							}
							
							tem += '<li> <a href="javascript:void(0);"  >';
							tem += '<img src="'+thumbnail+'" width="130" height="110"></a>';
							tem += '<p>'+cateName;
		     				
							tem += '<span style="float:right;"><a href="javascript:void(0);" flag="'+flag+'"  roomtype="'+roomtype+'"  onclick="setRelation(this,'+id+')" >';
							tem += showInfo;  					
	     					tem +='</a></span></p></li>';
						}
						
						$("#seacherRes").append(tem);
					    $("#more_search").addClass("search_search_more");
					}else{
						t.data("status","end");
						t.html('已经全部加载，没有更多了^o^');
					}
					if(jsonData.data.length>=10){
						$("#s_start_search").val(parseInt($("#s_start_search").val())+10);
						t.html('更多消息');
					}else{
						t.data("status","end");
						t.html('已经全部加载，没有更多了^o^');
					} 
			 },
			
			error:function(request,textStatus,error){alert(error);}
	   });
	}
});
function IEversion(){
	var browser=navigator.appName; 
	var b_version=navigator.appVersion;
	var version=b_version.split(";");
	if (version.length<2){
        return "";
	}else{
	var trim_Version=version[1].replace(/[ ]/g,""); 
	if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
	{ 
		return "6.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") 
	{ 
		return "7.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
	{ 
		return "8.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0") 
	{ 
		return "9.0";
	}
	}
}


</script>
</head>
<body style="background-color: white;height: 450px;width: 100%;height: 100%;">
<input name="paramMap.relationView" type="hidden" id="relations" value=""/>

<div id="layout_mainbody" >
                <div class="page-container tjcg">
                    <div class="ssjh-tjcg">
                        <div class="left" style="margin-left: 93px;">
						
                            <!--我的回答-->
                            <div class="my-answer tabcontrol">
                                <div class="tabtitle-bg"></div>
                                <p class="tabtitle">
                                    <a href="javascript:void(0);" class="tab on">关键字匹配</a>
                                    <a href="javascript:void(0);" class="tab">同级分类匹配</a>
                                    <a href="javascript:void(0);" class="tab">手动搜搜</a>
                                </p>
                                <div class="tabcontents">
                                    <div class="tabcontent">
                                      <input type="hidden" id="keyword" value="${paramMap.keyword}">
                                      <input type="hidden" id="s_start_keyword" value="9">
                                        <ul class="my-answer-list"  id="search_keywords_list">
                                          <s:iterator value="initMap.resKeyViewExhibition" id="fv" status="fvindx">
													<li>
									     				<a href="javascript:void(0);"  >
									     					<img src="${fv.thumbnail}" onclick="preImg(2,this)"  _index="${fvindx.index }"  alt="${fv.name}"  width="130" height="110"/> 
									     					
									     				</a>
									     				<p>
										     				<s:if test="#fv.name.length() > 4"><s:property value="#fv.name.substring(0,4)" />...</s:if>
										     				<s:else><s:property value="#fv.name" /></s:else>
										     			</p>
								     				</li>		
											</s:iterator>
											
											
                                         </ul>
                                     
                                       <div href="javascript:void(0);" style="text-align: center;position: absolute;width: 695px;bottom: 10px;" data-status="ini" id="more_keywords"  class="search_keywords_more" >  继续显示</div>
                                        
                                    </div>
                                    <div class="tabcontent" style="display:none">
                                      <input type="hidden" id="resType" value="${paramMap.resType}">
                                      <input type="hidden" id="roomtype" value="${paramMap.roomtype}">
                                      <input type="hidden" id="s_start" value="9">
                                      
                                    <s:if test="paramMap.roomtype=='exhibition'">
										<!-- 资源id-->
										<input type="hidden"  id="resID" info="erID" value="${paramMap.erID }">
										<input type="hidden"  id="erGenusID" info="erGenusID" value="${paramMap.erGenusID }">
										<input type="hidden"  id="erCategory" info="erCategory" value="${paramMap.erCategory }">
										<input type="hidden"  id="erOrderID" info="erOrderID" value="${paramMap.erOrderID }">
										<input type="hidden"  id="erGangID" info="erGangID" value="${paramMap.erGangID }">
										<input type="hidden"  id="erChorID" info="erChorID" value="${paramMap.erChorID }">
										<input type="hidden"  id="erJieID" info="erJieID" value="${paramMap.erJieID }">
										
									</s:if>
									<s:if test="paramMap.roomtype=='observation'">
										<!-- 资源id -->
										<input type="hidden"  id="resID" info="orID"  value="${paramMap.orID}">
										<input type="hidden"  id="orCategory" info="orCategory" value="${paramMap.orCategory }">
										<input type="hidden"  id="orCateTwLevel" info="orCateTwLevel" value="${paramMap.orCateTwLevel }">
									</s:if>
									<s:if test="paramMap.roomtype=='laboratory'">
										<!-- 资源id -->
										<input type="hidden"   id="resID" info="lrID" value="${paramMap.lrID }">
										<input type="hidden"  id="lrCategory" info="lrCategory" value="${paramMap.lrCategory }">
										<input type="hidden"  id="lrCateTwLevel" info="lrCateTwLevel" value="${paramMap.lrCateTwLevel }">
								
									</s:if>
									<s:if test="paramMap.roomtype=='projection'">
										<!-- 影片id-->
										<input type="hidden"   id="resID" info="prID" value="${paramMap.prID}">
										<input type="hidden"  id="prCategory" info="prCategory" value="${paramMap.prCategory }">
										<input type="hidden"  id="prCateTwLevel" info="prCateTwLevel" value="${paramMap.prCateTwLevel }">
								
									</s:if>
									<s:if test="paramMap.roomtype=='lovely'">
										<!-- 资源id -->
										<input type="hidden"   id="resID" info="crID"  value="${paramMap.crID}">
										<input type="hidden"  id="crCategory" info="crCategory" value="${paramMap.crCategory }">
										<input type="hidden"  id="crCateTwLevel" info="crCateTwLevel" value="${paramMap.crCateTwLevel }">
								
									</s:if>
										
										<div>

	                                        <ul class="my-answer-list" id="search_cate_list" >
	                                           
	                                            <s:iterator value="initMap.resCateView" id="fv" status="fvindx">
														<li>
										     				<a href="javascript:void(0);"  >
										     					<img src="${fv.thumbnail}" alt="${fv.name}"  width="130" height="110"/> 
										     					
										     				</a>
										     					<p>
											     				<s:if test="#fv.name.length() > 4"><s:property value="#fv.name.substring(0,4)" />...</s:if>
											     				<s:else><s:property value="#fv.name" /></s:else>
											     				<span style="float:right;"><a href="javascript:void(0);" onclick="viewsidden(${fv.id },this)" flag="${fv.viewflag }">
											     					
											     					<s:if test="#fv.viewflag == 0">已隐藏</s:if>
											     					<s:else>
											     					显示
											     					</s:else>
											     					
											     				</a></span>
											     				</p>
											     					
									     				</li>		
												</s:iterator>     
	                                     	</ul>
	                                     </div>
                                 	    <div href="javascript:void(0);" style="text-align: center;position: absolute;width: 695px;bottom: 10px;" data-status="ini" id="more"  class="search_cate_more">  继续显示</div>
                                 	
                                 		
                                    </div>
                                    <div class="tabcontent" style="display:none">
                                        <div class="search-box">
											<i class="icon-search"></i> 
											<input type="hidden"  id="s_start_search"  value="9"/>
											<input type="text"   name="searchText" id="search_res" placeholder="输入查询内容" />
											
											
											<input type="button" class="gosearch" id="search_btn_res_name" />
										</div>       
                                       <input type="hidden" id="s_start_search" value="9">
                                        <ul class="my-answer-list" id="seacherRes">
                                        
                                     	</ul>
                                 	    <div  data-status="ini" id="more_search"  class="search_search_more"  style="text-align: center;position: absolute;width: 695px;bottom: 10px;" >  继续显示</div>
                                 	
                                    </div>
                                </div>
                            </div>
                                    
                             
                            

                        </div>
                     
                    </div>
                </div>
            </div>
   
    <script src="<%=request.getContextPath()%>/js/scripts.js"></script>  
</body>
</html>