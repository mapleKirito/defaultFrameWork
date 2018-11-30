<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>     
<title><s:text name="systemName"/></title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT"> 
<s:include value="head.jsp"></s:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; overflow:hidden;  font-size:14px;color:#333;}
ul, li{list-style-type:none;}
</style>
<script language="JavaScript" src="js/jquery.fn.screen.js"></script>
<script language="JavaScript" >
$(document).ready(function(){
	
	$(".classmoreCentral ul li div").click(function(){
		closeAll();
	});
	
	/* 原备课中心模块  */
	$("ul li a#002014").parent().hide();

	/* 原学生学习室模块 */
	//$("ul li a#001002").parent().hide();
	$("ul li a#001007").parent().hide();
	$("ul li a#001005").parent().hide();
	$("ul li a#001008").parent().hide();
	$("ul li a#001003").parent().hide();
	
	$("ul li a#003015").parent().hide();
	
	$("#001001").click(function() {
		window.parent.tabClick('R_001001', '我的主页', '001001', 'paramMap.rrType=001001&pageSize=8&type=1');
	});
	
	$("#001002").click(function() {
		window.parent.tabClick('R_001002', ' 我的收藏夹', '001002', 'paramMap.rrType=001002&pageSize=8&type=1');
	});
	
	$("#001006").click(function() {
		window.parent.tabClick('R_001006', '密码修改', '001006', 'paramMap.rrType=001006&pageSize=8&type=1');
	});

	$("#002013").click(function() {
		window.parent.tabClick('R_002013', '个人资料', '002013', 'paramMap.rrType=002013&pageSize=8&type=1');
	});
	
	$("#002002").click(function() {
		window.parent.tabClick('R_002002', ' 我的收藏夹', '002002', 'paramMap.rrType=002002&pageSize=8&type=1');
	});
	
	$("#002009").click(function() {
		window.parent.tabClick('R_002009', '密码修改', '002009', 'paramMap.rrType=002009&pageSize=8&type=1');
	});
	
	$("#windowheight_").val($(window).height());
	
});
function f(){
	return $(window).height();
}
//: 判断网页是否加载完成  
document.onreadystatechange = function () {   
    if(document.readyState=="complete") { 
    	$(".mainloading").hide();
        $(".main").show();
    }  
};    
function setareaval(b,h){
	$("#"+b).contents().find("#erLoLa").val(h);
}
function getareaval(c){
	return $("#"+c).contents().find("#erLoLa").val();
}
var funcsetting = {
	async: {
		enable: true,
		url:"ajaxAction.action",
		autoParam:["id","rootSign"],
		otherParam:{"code":"-700"},					
		dataFilter: filter
	},
	callback: {
		onClick: funcOnclick
	}
};
var areasetting = {
	async: {
		enable: true,
		url:"ajaxAction.action",
		autoParam:["id"],
		otherParam:{"code":"-800"},					
		dataFilter: filter
	},
	callback: {
		onClick: areaOnclick
	}
};
function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	if (childNodes.data){
		childNodes = childNodes.data;
	}		
	return childNodes;
}
function funcOnclick(e,treeId, treeNode) {
	if (treeNode.ischild == '0'){
		
		forwardUrl = "decorateForwardAction.action";
		var id = treeNode.id;
		var txt = treeNode.name;
		var path  = treeNode.path;
		var level = treeNode.clevel;
		var rootSign = treeNode.rootSign;
		var ischild = treeNode.ischild;	
		var param = "path="+path + "&paramMap.ischild="+ischild+"&paramMap.cateLevel="+level+"&pageSize=8&type=1"; 
		
		var tcode = "";
		if(id == 197){//探究热身
			tcode = "-170102";
		}
		else if(id == 199){//探究广场
			tcode = "-13899";
		}
		else if(id == 198){//探究成果
			tcode = "-14899";
		}
		else{
			tcode = "-701";
		}	
		
		tabClick("munu_name",txt,tcode,roomtreeNodeiszero(rootSign,level,param,id));
		
	}else{
		
		forwardUrl = "decorateForwardAction.action";
		var zTree = $.fn.zTree.getZTreeObj("functionTree");
		zTree.expandNode(treeNode);		
		var level = treeNode.clevel;
		var rootSign = treeNode.rootSign;
		if (level == 1){		
			/* var txt = treeNode.name;
			var path  = treeNode.path;
			if (rootSign == 'exhibition'){
				if(isalert==1){
					tabClick("munu_name",txt,'-1800',"path="+path);
				}else{
					tabClick("munu_name",txt,'-701',"paramMap.path=,0,1,&paramMap.cateSign=exhibition&pageSize=8&type=1");
				}
			}
			else if (rootSign == 'observation'){			
				if(isalert==1){
					tabClick("munu_name",txt,'-1900',"path="+path);
				}else{
					tabClick("munu_name",txt,'-701',"paramMap.path=,0,1076&paramMap.cateSign=observation&pageSize=8&type=1");
				}
			}
			else if (rootSign == 'laboratory'){			
				if(isalert==1){
					tabClick("munu_name",txt,'-2000',"path="+path);
				}else{
					tabClick("munu_name",txt,'-701',"paramMap.path=,0,1081&paramMap.cateSign=laboratory&pageSize=8&type=1");
				}
			}
			else if (rootSign == 'projection'){				
				if(isalert==1){
					tabClick("munu_name",txt,'-2100',"path="+path);
				}else{
					tabClick("munu_name",txt,'-701',"paramMap.path=,0,1089&paramMap.cateSign=projection&pageSize=8&type=1");
				}
			}
			else if (rootSign == 'expand'){				
				if(isalert==1){
					tabClick("munu_name",txt,'-2200',"path="+path);
				}else{
					tabClick("munu_name",txt,'-701',"paramMap.path=,0,1094&paramMap.cateSign=expand&pageSize=8&type=1");
				}
			} */
		}
		else{		
			var id = treeNode.id;
			var txt = treeNode.name;
			var path  = treeNode.path;
			var param = "path="+path;
			if (rootSign == 'exhibition'){
				if (level == 2){
					param += "&paramMap.erTotalID=" + id;
				}
				else if (level == 3){
					param += "&paramMap.erJieID=" + id;
				}
				else if (level == 4){
					param += "&paramMap.erChorID=" + id;
				}
				else if (level == 5){
					param += "&paramMap.erGangID=" + id;
				}
				else if (level == 6){
					param += "&paramMap.erOrderID=" + id;
				}
				else if (level == 7){
					param += "&paramMap.erCategory=" + id;
				}
			}
			else if (rootSign == 'observation'){
				if (level == 2){
					param += "&paramMap.orJieID=" + id;
				}
				else if (level == 3){
					param += "&paramMap.orGangID=" + id;
				}
				else if (level == 4){
					param += "&paramMap.orOrderID=" + id;
				}					
			}
			else if (rootSign == 'laboratory'){
				param += "&paramMap.lrCategory=" + id;
			}
			else if (rootSign == 'projection'){
				param += "&paramMap.prCategory=" + id;
			}
			else if (rootSign == 'expand'){
				if (level == 2){
					param += "&paramMap.expResType=" + id;	
				}
				else if (level == 3){
					param += "&paramMap.erCateTwLevel=" + id;	
				} 
			}
			tabClick("munu_name",txt,'-701',param +"&paramMap.cateLevel="+level+"&pageSize=8&type=1");			
		}
	}
}

function roomtreeNodeiszero(rootSign,level,param,id){
	if (rootSign == 'exhibition'){
		if (level == 2){
			param += "&paramMap.erTotalID=" + id;
		}
		else if (level == 3){
			param += "&paramMap.erJieID=" + id;
		}
		else if (level == 4){
			param += "&paramMap.erChorID=" + id;
		}
		else if (level == 5){
			param += "&paramMap.erGangID=" + id;
		}
		else if (level == 6){
			param += "&paramMap.erOrderID=" + id;
		}
		else if (level == 7){
			param += "&paramMap.erCategory=" + id;
		}
	}
	
	if (rootSign == 'expand'){
		if (level == 2){
			param += "&paramMap.expResType=" + id;	
		}
		else if (level == 3){
			param += "&paramMap.erCateTwLevel=" + id;	
		} 
	}
	
	return param;
} 



function areaOnclick(e,treeId, treeNode) {
	var level = treeNode.level ;
	if (treeNode.ischild != '0'){
		var zTree = $.fn.zTree.getZTreeObj("areaTree");
		zTree.expandNode(treeNode);
	}
	var id = treeNode.id;
	var txt = treeNode.name;	
	var path  = treeNode.path;
	var param = "path="+path ;
	if(level == 0) {
		param += "&paramMap.erCountry=" + id ;
	}else if(level == 1) {
		param += "&paramMap.erProvince=" + id ;
	}else if(level == 2) {
		param += "&paramMap.erCity=" + id ;
	}else if(level == 3) {
		param += "&paramMap.erArea=" + id ;
	}
	tabClick("-801",txt,'-801',param+"&type=1");
}
function closeAll(){
	var zTree = $.fn.zTree.getZTreeObj("functionTree");
	zTree.expandAll(false);
}
$(document).ready(function(){
   //点击页面其他地方隐藏moreList
   $("body").click(function(event){
		if($(event.target).attr("id") != "moreList" && $(event.target).attr("id") != "moreTabBtn" && $(event.target).attr("id") != "tabClose"){
			$("#moreList").hide();
			$("#moreTabBtn").removeClass("onMore");
			$("#moreTabBtn").removeClass("downMore");
		}
	 });
   //显示隐藏moreList
	$(".moreTabBtn").hover(function(){
			$(this).addClass("onMore");
	},function(){
			if($(".moreList").css("display") == "none"){
				$(this).removeClass("onMore");
			}
	}).click(function(){
		if($(".moreList").css("display") == "none"){
			$(".moreList").show();
			$(this).addClass("downMore");
		}else{
			$(".moreList").hide();
			$(this).removeClass("downMore");
		}
	});
   
	//tabClose鼠标停留、离开效果及删除
	$(".tabClose").mouseover(function(){
		$(this).addClass("tabShut");
		}).mouseout(function(){
			$(this).removeClass("tabShut");
		}).click(function(){
			$(this).parent().remove(); 
	});
	//moreList > ul >li 鼠标经过改变背景色
	$("#moreList > ul >li").hover(function(){
		$(this).addClass("on");
	},function(){
		$(this).removeClass("on");
	});	
	
	//菜单tab
	var $tab = $(".classificationTop ul li");
	$tab.click(function() {
		$(".classificationCentral").animate({"height":openup_h_main + "px"});
		$(".xt").hide();
		$(".classmoreCentral > ul > li > div").show();
		$(this).addClass("selected").siblings().removeClass("selected");
		var index = $tab.index(this);
		$(".tabDiv").eq(index).show().siblings().hide();
		
		if('${session.s_userType}' == 1){
			$("#menu li.mli div").removeClass("onmynu_div_2").addClass("label_1");
		}else if('${session.s_userType}' == 2){
			$("#menu li.mli div").removeClass("onmynu_div_1").addClass("label_2");
		}else if('${session.s_userType}' == 3){
			$("#menu li.mli div").removeClass("onmynu_div_3").addClass("label_3");
		}
		
	});
	$("#menu li.mli div").click(function(){
		$(".classificationTop ul li").eq(0).addClass("selected").siblings().removeClass("selected");
		$(".tabDiv").eq(0).show().siblings().hide();
		
		if('${session.s_userType}' == 1){
			$(this).removeClass("label_1").addClass("onmynu_div_2");
		}else if('${session.s_userType}' == 2){
			$(this).removeClass("label_2").addClass("onmynu_div_1");
		}else if('${session.s_userType}' == 3){
			$(this).removeClass("label_3").addClass("onmynu_div_3");
		}
	});
	
	var $menu=$("#functionTree li a");
	$menu.live("click",function() {
		$(".classificationCentral").animate({"height":openup_h_main + "px"});
		$(".xt").hide();
		$("#top_menu tr td").removeClass("top_menu_select");
		
		if('${session.s_userType}' == 1){
			$("#menu li.mli div").removeClass("onmynu_div_2").addClass("label_1");
		}else if('${session.s_userType}' == 2){
			$("#menu li.mli div").removeClass("onmynu_div_1").addClass("label_2");
		}else if('${session.s_userType}' == 3){
			$("#menu li.mli div").removeClass("onmynu_div_3").addClass("label_3");
		}
	});
	
	$.fn.zTree.init($("#functionTree"), funcsetting);
	$.fn.zTree.init($("#areaTree"), areasetting);
	
	//学生或老师flash弹出
	/* $("#menu div").click(function(){
		var id = $(this).attr("id");
		if (id == '001'){
			//学生flash
			tabClick("student_00000","学生实习室 ","-2500","");
		}
		else if (id == '002'){
			//老师flash
			tabClick("teacher_00000","教师工作室","-2600","");
		}
	}); */
});
function newsView(index){	
	tabClick("9009","专题", '9009','paramMap.newsID='+index);	
}
function historyView(index){	
	tabClick("9010","历史上的今天", '9010','paramMap.historyID='+index);	
}
function showView(index){
	
	var param = $(index).attr("param");
	var codeNum = $(index).attr("codeNum");
	var name = $(index).attr("name");
	tabClick("munu_name",name,codeNum,param);	
}
function search(){
	var keyword = $("#keyword").val() ;
	var title = "查询资源" ;
	if(document.getElementById('keyword').value==''){
	   art.dialog.alert('查询内容不能为空!!!');
	   return false;
	}
	forwardUrl = "decorateForwardAction.action";
	tabClick("-1101", title, '-1101','paramMap.resType=' + "-1101" + '&paramMap.keyword=' + keyword +"&pageSize=8");
}
function taskAlert(tcount){   
	$.ajax({
		
		url:		'ajaxAction.action?code=-1201',
		
		type:	    'post',
		
		timeout:	'60000',
		
		data:	Array(),
		
		dataType:	'json',
		
		beforeSend:function(request){},
		
		complete:function(request,textStatus){},
		
		success:function(jsonData,textStatus){
			
			
			if (textStatus == "success"){
				if (jsonData.singleData){
					if (jsonData.singleData.userType == 1){
						$("#correctTask").text("("+jsonData.singleData.unfinishCorrectTaskCount+")");
						$("#todayTask").text(jsonData.singleData.todayTaskCount);
						$("#yestodayTask").text(jsonData.singleData.yestodayTaskCount);
						$("#lastweekTask").text(jsonData.singleData.lastweekTaskCount);
						$("#lastmonthTask").text(jsonData.singleData.lastmonthTaskCount);	
						if (jsonData.singleData.unfinishCorrectTaskCount > 0){
							$("#tb_top tr td #email_t img").show();
							$("#tb_top tr td #email_t img").wrap("<a href='#' id='taskAlert'>"+jsonData.singleData.unfinishCorrectTaskCount+"</a>");
							$("#taskAlert").click(function(){
								$("html",window.document).find("#screen__").css("display","none");
								$("html",window.document).find("#message__").css("display","none");			
								tabClick("002007003","未批改作业","002007003","");
							});	 							
						}else{
							$("#tb_top tr td #email_t img").hide();
						}
					}
					else if (jsonData.singleData.userType == 2) {
						$("#unfinishTask").text("("+jsonData.singleData.unfinishCorrectTaskCount+")");
						$("#todayTask").text(jsonData.singleData.todayTaskCount);
						$("#yestodayTask").text(jsonData.singleData.yestodayTaskCount);
						$("#lastweekTask").text(jsonData.singleData.lastweekTaskCount);
						$("#lastmonthTask").text(jsonData.singleData.lastmonthTaskCount);	
						if (jsonData.singleData.unfinishCorrectTaskCount > 0){
							$("#tb_top tr td #email_s img").show();
							$("#tb_top tr td #email_s img").wrap("<a href='#' id='taskAlert'>"+jsonData.singleData.unfinishCorrectTaskCount+"</a>");
							$("#taskAlert").click(function(){
								$("html",window.document).find("#screen__").css("display","none");
								$("html",window.document).find("#message__").css("display","none");			
								tabClick("001005","未完成作业","001005","");
							});								
						}else{
							$("#tb_top tr td #email_s img").hide();
						}
					}
				}
			}
		},
		
		error:function(request,textStatus,error){}
	});  	
}
function insert_fav(_this){
	  var id = $(_this).attr("id");
	 // alert("id --- " + id);
	  $.ajax({
			
			url:		'ajaxAction.action?code=-701014&paramMap.param=' + encodeURI(id),
			
			type:	    'post',
			
			timeout:	'60000',
			
			data:	Array(),
			
			contentType: "application/json; charset=utf-8",
			
			dataType:	'json',
			
			beforeSend:function(request){},
			
			complete:function(request,textStatus){},
			
			success:function(jsonData,textStatus){
				
				
				if (textStatus == "success"){
					if(jsonData.content!=null)
						alert(jsonData.content); 
				}
			},
			
			error:function(request,textStatus,error){}
		});  
}
function message(objects){
	if (objects == 'exhibition'){
		tabClick("exhibition_0000","文物博览室",'-1800',"path=,0,1&pageSize=8&type=1");
	}
	else if (objects == 'observation'){
		tabClick("observation_0000","专题研读室",'-1900',"path=,0,2&pageSize=8&type=1");
	}
	else if (objects == 'laboratory'){	
		tabClick("laboratory_0000","教学研究室",'-2000',"path=,0,3&pageSize=8&type=1");
	}
	else if (objects == 'projection'){	
		tabClick("projection_0000","影像资料室",'-2100',"path=,0,4&pageSize=8&type=1");
	}
	else if (objects == 'expand'){
		tabClick("expand_0000","自主探究室",'-2200',"path=,0,5&pageSize=8&type=1");
	}
}
</script>
<style type="text/css">
.ztree li button.switch {visibility:hidden; width:1px;}
.ztree li button.switch.roots_docu {visibility:visible; width:1px;}
.ztree li button.switch.center_docu {visibility:visible; width:1px;}
.ztree li button.switch.bottom_docu {visibility:visible; width:1px;}
.ztree li button.pIcon01_ico_open{background: url(images/tree/tree.icon.2.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li button.pIcon01_ico_close{background: url(images/tree/tree.icon.1.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li button.root_open{background: url(images/tree/open.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li button.root_close{background: url(images/tree/close.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
#lookimage_{position: absolute;z-index: 9999;overflow: auto;text-align: center;display: none;}
#lookimageclose{position: absolute;z-index: 10000;width: 40px;height: 40px;display: none;right:40px;cursor: pointer;}
.mainloading{position: absolute;top:50%;left:50%;}
</style>
</head>
<input type="hidden" id="username" value="${s_userLoginName}"/>
<input type="hidden" id="windowheight_" />
<input type="hidden" id="windowheight" />
<input type="hidden" id="windowwidth" />
<body onload="redraw('${session.indextotal}','${session.s_userType}');$.menuTab();taskAlert(1);" style="background-color:transparent">
<div id="lookimage_" class="lookimage_"><img src="" border="0"></div>
<div id="lookimageclose" class="lookimageclose" ><img src="images/deleted_1.png" border="0"></div>
<div id="message__" class="showDiv"></div>
<div id="message_only" class="message_only"><s:include value="messonly.jsp"></s:include></div>
<div id="message_refer" class="message_refer"><s:include value="messrefer.jsp"></s:include></div>
<div id="screen__"><iframe id="iframeScreen__" scrolling="no" frameborder="0"></iframe></div>
<s:include value="top.jsp"></s:include>
<div class="mainloading" ><img src='<%=request.getContextPath()%>/images/loadingl.gif' border='0'></div>
<div class="main" style="display: none;">
		<div class="main_l">
	    	<div class="classificationTop" >
	           	<ul>
	            	<li id="li_1" class="li_1 selected" title="功能"></li>
	                <li id="li_2" class="li_2" title="区域"></li>
	                <li id="li_3" class="li_3" title="适用学段、年级" ></li>
	                <li id="li_4" class="li_4" title="资源"></li>
	            </ul>
	        </div>
       		<div class="classificationCentral">
           		<div class="tabDiv">
              		<ul id="functionTree" class="ztree"></ul>
               </div>
               
               <div class="tabDiv hide">
                   <ul id="areaTree" class="ztree"></ul>
               </div>
               
                <div class="tabDiv hide">
                 <ul class="tree">
               		<!-- <li>
                     	<div class="level">小学</div>
                     	<ul class="levelTwo hide">
                         	 <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','三年级资源','-901','paramMap.grGrade=303&pageSize=8&type=1');">三年级</a></div>
                           	 </li>
                             <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','四年级资源','-901','paramMap.grGrade=304&pageSize=8&type=1');">四年级</a></div>
                           	 </li>
                             <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','五年级资源','-901','paramMap.grGrade=305&pageSize=8&type=1');">五年级</a></div>
                           	 </li>
                             <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','六年级资源','-901','paramMap.grGrade=306&pageSize=8&type=1');">六年级</a></div>
                           	 </li>
                         </ul>
                     </li>  --> 
                    <li>
                     	<div class="level">初中</div>
                     	<ul class="levelTwo hide">
                    	   	<li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','七年级资源','-901','paramMap.grGrade=311&pageSize=8&type=1');">七年级</a></div>
                           </li>
                            <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','八年级资源','-901','paramMap.grGrade=312&pageSize=8&type=1');">八年级</a></div>
                           </li>                  
                         </ul>
                     </li>
                     <li>
                     	<div class="level">高中</div>
                     	<ul class="levelTwo hide">
                     		<li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','必修一资源','-901','paramMap.grGrade=321&pageSize=8&type=1');">必修一</a></div>
                           	</li>
                            <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','必修二资源','-901','paramMap.grGrade=322&pageSize=8&type=1');">必修二</a></div>
                           	</li>
                            <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','必修三资源','-901','paramMap.grGrade=323&pageSize=8&type=1');">必修三</a></div>
                           	</li>
                            <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','选修一资源','-901','paramMap.grGrade=327&pageSize=8&type=1');">选修一</a></div>
                            </li>
                            <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','选修二资源','-901','paramMap.grGrade=325&pageSize=8&type=1');">选修二</a></div>
                            </li>
                            <li>
                            	 <div class="level_div"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('G_Grade','选修三资源','-901','paramMap.grGrade=326&pageSize=8&type=1');">选修三</a></div>
                            </li>
                         </ul>
                     </li> 
                                     
                 </ul>
               </div>
               <div class="tabDiv hide">
                   <ul class="tree">
                   	<li>
                   		<div class="level">素材</div>
                       	<ul class="levelTwo hide">
                           	<li class="level_li"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('R_Res','高清图片','-1001','paramMap.rrType=1011&pageSize=8&type=1');">高清图片</a></li>
							<li class="level_li"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('R_Res','3D图片','-1001','paramMap.rrType=1022&pageSize=8&type=1');">3D图片</a></li>
							<li class="level_li"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('R_Res','音频','-1001','paramMap.rrType=1073&pageSize=8&type=1');">音频</a></li>
							<li class="level_li"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('R_Res','高清视频','-1001','paramMap.rrType=1084&pageSize=8&type=1');">高清视频</a></li>
							<li class="level_li"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('R_Res','虚拟仿真实验','-1001','paramMap.rrType=2002&pageSize=8&type=1');">虚拟仿真实验</a></li>
						</ul>
                   	</li>
                   	<li>
                   		<div class="level">课件</div>
                       	<ul class="levelTwo hide" >
                       		<li class="level_li"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('R_Res','PPT课件','-1001','paramMap.rrType=2041&pageSize=8&type=1');">PPT课件</a></li>
                          	<li class="level_li"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('R_Res','WORD课件','-1001','paramMap.rrType=2033&pageSize=8&type=1');" >WORD课件</a></li>
							<li class="level_li"><a style="color:#000000;text-decoration:none;" href="javascript:void(0);" onclick="tabClick('R_Res','PDF课件','-1001','paramMap.rrType=2055&pageSize=8&type=1');" >PDF课件</a></li>
					    </ul>
                   	</li>	
                   	</ul>
               </div>
        	</div>
        	<!-- 系统维护 / 学生 /老师 -->
       		<div class="classmoreCentral">
	       		<ul id="menu" style="float:left; width:100%;">
					<s:iterator value="subPermission" id="pms" status="ind">			
						<s:if test="#pms.code != '004' && #pms.code != '005'">
							<li class="mli">
								<div class="label_${session.s_userType}" id="${pms.code}" ></div>
								<ul class="xt">
									<s:iterator value="allPermission" id="allpms" status="allind">	
										<s:if test="#pms.code == #allpms.parentCode and #allpms.code != '003016' and #allpms.code != '003000'">
											<li><a href="javascript:void(0);" id="${allpms.code}">&nbsp;<span>${allpms.name}</span></a></li>
										</s:if> 
				 					</s:iterator>				
								</ul>
							</li>
						</s:if>
	 				</s:iterator>
					<s:if test="session.indextotal == 'Zero' ">
						<div style="height: 49px;width:189px;margin-left:2px;  background-color: #F9F9F7;"></div>
					</s:if>				
				</ul>
       		</div>
     		<div class="classmoreBottom"></div>
    	</div>
	    <div class="main_c">
	    	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tt">
	          <tr>
	            <td valign="middle" style="background-color: gray;"><img src="images/main/ima_23.png" id="yc" style="cursor: pointer;width: 5px; " /></td>
	          </tr>
	      </table>
	    </div>
	    <div class="main_r">
			<!-- <div class="menuTabTextNavigation" style="height: 32px;line-height: 32px;">
				          
			</div> -->
			<!-- 右侧小查询一下div -->
			<div class="iform" id="content" >
				<iframe id="mainFrameWelcome" name="mainFrameWelcome" scrolling="no" marginheight="0" marginwidth="0" allowtransparency="true" hspace="0" frameborder="0" src="welcome.jsp" width="100%"></iframe>
			</div>
	    </div>
	    <div style="clear:both"></div>
</div>
<s:include value="foot.jsp"></s:include>
</body>
</html>