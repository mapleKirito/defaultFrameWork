<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>     
<title><s:text name="systemName"/></title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT"> 
<link href="css/style.css" rel="stylesheet" />

<script type="text/javascript">
//图片详情
function showView(index){
	
	var param = $(index).attr("param");
	var code = $(index).attr("code");
	var name = $(index).attr("name");
	tabClick("ziayun",'资源详细',code,param);	
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
							 Info += '<dd subIndex='+i+'><a key="0" href="javascript:void(0);" path="'+jsonData.data[i].catePath+'" lave ="'+(leval+1)+'" cateSign="'+roomtype+'" onclick="findChildCategory_sub(this)">'+jsonData.data[i].cateName+'</a></dd>';
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
							var name = "";
							 if(jsonData.data[i].cateName.length>10){
								 name = name.substring(0,9)+"...";
							 }else{
								 name = jsonData.data[i].cateName;
							 }
							 
							
							 Info += '<dd class="sub_res'+index_parent+'" style="background:#E7E7E7;color:black;"><a  path="'+jsonData.data[i].catePath+'"  onclick="findChildCategory_sub_a(this)" style="color: black;"   href="javascript:void(0);">'+jsonData.data[i].cateName+'</a></dd>';
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
							
								Info += '<dd class="sub_res'+parent_id+'"  subIndex='+i+'><a key="0" href="javascript:void(0);" id="'+jsonData.data[i].id+'" onclick="findChildArea_sub(this)"    >'+jsonData.data[i].name+'</a></dd>';
							
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
	var parent_id = $(this_).attr("id");
	var subMenu = $(this_).parent();
	tabClick("省份查询",'查询','-801',"&path=,0,1,&paramMap.erProvince="+parent_id +"&pageSize=8&type=1");	
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
						
							Info += '<dd  class="sub_res'+parent_id+' style="background:#E7E7E7;color:black;" subIndex='+i+'><a key="0" onclick="findChildArea_sub_city(this)"  href="javascript:void(0);" id="'+jsonData.data[i].id+'" onclick=""    >'+jsonData.data[i].name+'</a></dd>';
						
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
	var parent_id = $(this_).attr("id");
	tabClick("省份查询",'查询','-801',"&path=,0,1,&paramMap.erCity="+parent_id +"&pageSize=8&type=1");	

}
</script>
<script src="js/jquery-main-tag.js"></script>
<style type="text/css">
#layout_left_pms{ float: left;position:absolute; top:-40px; left:0; width:192px; height:100%; background:#504538;display:block; z-index:2;}

</style>
</head>
<body >
<s:include value="top.jsp"></s:include>	
		<div id="layout_left">
	
			<div class="layout_left_menutab">
			
				<p class="layout_left_menutab_title">
					<a href="javascript:;" class="on" title="功能"><i class="icon-cat"></i></a> 
					<a href="javascript:;" title="区域"><i class="icon-position"></i></a>
					<a href="javascript:;" title="学段、年级"><i class="icon-data"></i></a> 
					<a href="javascript:;" title="资源"><i class="icon-list"></i></a>
				</p>
				<div class="left_menutab_body">
				
					<ul class="menutab_body menu-nav"  >
						<li roomtype="exhibition"><a href="javascript:void(0);" path=",0,1," key="0" onclick="message('exhibition',this)">文物博览室<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i>
							</a>
							<dl class="sub-menu" style="display: none;">
								
							</dl>
						</li>
						<li roomtype="observation"><a href="javascript:void(0);"  path=",0,219,"  key="0" onclick="message('observation',this)">专题研读室<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" style="display: none;">
								
							</dl>
						</li>
						<li roomtype="projection"><a  href="javascript:void(0);" path=",0,213,"  key="0" onclick="message('projection',this)">影像资料室<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" style="display: none;">
								
							</dl>
						</li>
						<li roomtype="expand"><a  href="javascript:void(0);" path=",0,206," key="0" onclick="message('expand',this)">自主探究室<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" style="display: none;">
								
							</dl>
						</li>
						<li roomtype="laboratory"><a href="javascript:void(0);" path=",0,218,"  key="0" onclick="message('laboratory',this)">教学研究室<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" style="display: none;">
								
							</dl>
						</li>
						<li roomtype="lovely"><a href="javascript:void(0);" path=",0,259,"  key="0" onclick="message('lovely',this)">情系家园<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" style="display: none;">
								
							</dl>
						</li>
					</ul>
					<ul class="menutab_body menu-nav" style="display: none">
						<li><a  key="0" id="1"  class="on" onclick="findChildArea(this)">中国<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu">
								
							</dl>
						</li>
						
					</ul>
					<ul class="menutab_body menu-nav" style="display: none">
						<li><a>初中<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" style="display: none;">
								
								<dd>
									<a onclick="tabClick('G_Grade','七年级资源','-901','paramMap.grGrade=311&pageSize=8&type=1');" href="javascript:void(0);">七年级</a>
								</dd>
								<dd>
									<a onclick="tabClick('G_Grade','八年级资源','-901','paramMap.grGrade=312&pageSize=8&type=1');" href="javascript:void(0);">八年级</a>
								</dd>
							</dl></li>
						<li><a>高中<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" style="display: none;">
								<dd>
									<a onclick="tabClick('G_Grade','必修一资源','-901','paramMap.grGrade=321&pageSize=8&type=1');" href="javascript:void(0);">必修1</a>
								</dd>
								<dd>
									<a onclick="tabClick('G_Grade','必修二资源','-901','paramMap.grGrade=322&pageSize=8&type=1');" href="javascript:void(0);">必修2</a>
								</dd>
								<dd>
									<a onclick="tabClick('G_Grade','必修三资源','-901','paramMap.grGrade=323&pageSize=8&type=1');" href="javascript:void(0);">必修3</a>
								</dd>
								<dd>
									<a  onclick="tabClick('G_Grade','选修一资源','-901','paramMap.grGrade=327&pageSize=8&type=1');" href="javascript:void(0);">选修1</a>
								</dd>
								<dd>
									<a onclick="tabClick('G_Grade','选修二资源','-901','paramMap.grGrade=325&pageSize=8&type=1');" href="javascript:void(0);">选修2</a>
								</dd>
								<dd>
									<a onclick="tabClick('G_Grade','选修三资源','-901','paramMap.grGrade=326&pageSize=8&type=1');" href="javascript:void(0);">选修3</a>
								</dd>
							</dl></li>
					</ul>
					<ul class="menutab_body menu-nav" style="display: none">
						<li><a>素材<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" style="display: none;">
								<dd>
									<a onclick="tabClick('R_Res','高清图片','-1001','paramMap.rrType=1011&pageSize=8&type=1');" href="javascript:void(0);">高清图片</a>
								</dd>
								<dd>
									<a onclick="tabClick('R_Res','3D图片','-1001','paramMap.rrType=1022&pageSize=8&type=1');" href="javascript:void(0);">3D图片</a>
								</dd>
								<dd>
									<a onclick="tabClick('R_Res','音频','-1001','paramMap.rrType=1073&pageSize=8&type=1');" href="javascript:void(0);">音频</a>
								</dd>
								<dd>
									<a onclick="tabClick('R_Res','高清视频','-1001','paramMap.rrType=1084&pageSize=8&type=1');" href="javascript:void(0);">高清视频</a>
								</dd>
								<dd>
									<a onclick="tabClick('R_Res','虚拟仿真实验','-1001','paramMap.rrType=2002&pageSize=8&type=1');" href="javascript:void(0);">虚拟仿真实验</a>
								</dd>
							</dl></li>
						<li><a>课件<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" style="display: none;">
								<dd>
									<a onclick="tabClick('R_Res','PPT课件','-1001','paramMap.rrType=2041&pageSize=8&type=1');" href="javascript:void(0);">PPT课件</a>
								</dd>
								<dd>
									<a onclick="tabClick('R_Res','WORD课件','-1001','paramMap.rrType=2033&pageSize=8&type=1');" href="javascript:void(0);">word课件</a>
								</dd>
								<dd>
									<a onclick="tabClick('R_Res','PDF课件','-1001','paramMap.rrType=2055&pageSize=8&type=1');" href="javascript:void(0);">PDF课件</a>
								</dd>
							</dl>
						</li>
					</ul>
					
				</div>
			</div>
		</div>
		<div id="layout_left_pms" style="display:none;" >
	
			<div class="layout_left_menutab_pms">
			
				<div class="left_menutab_pms_body">
					<ul  class="menutab_body menu-nav">
						
						<li class="left"><a>科室管理<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" >
						
							
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.res_exhibition_room_mgr.code}">${pmsIndex.res_exhibition_room_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.res_observation_room_mgr.code}">${pmsIndex.res_observation_room_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.res_projection_room_mgr.code}">${pmsIndex.res_projection_room_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.res_expand_room_mgr.code}">${pmsIndex.res_expand_room_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.res_laboratory_room_mgr.code}">${pmsIndex.res_laboratory_room_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.res_lovely_room_mgr.code}">${pmsIndex.res_lovely_room_mgr.name}
									</a>
								</dd>
								</dl>
					</li>
					<li class="left"><a>系统设置<i class="icon-menu"></i><i
								class="icon-menu-arrow"></i></a>
							<dl class="sub-menu" >
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.sys_resource_history.code}">${pmsIndex.sys_resource_history.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.sys_count_mgr.code}" >${pmsIndex.sys_count_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.sys_role_mgr.code}">${pmsIndex.sys_role_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.sys_user_mgr.code}">${pmsIndex.sys_user_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.bsms_category_mgr.code}">${pmsIndex.bsms_category_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.sys_area_mgr.code}">${pmsIndex.sys_area_mgr.name}
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.sys_operate_log.code}">操作日志
									</a>
								</dd>
								<dd>
									<a href="javascript:void(0);" id="${pmsIndex.sys_settings_db_param.code}">系统设置
									</a>
								</dd>
							
						
						</dl>
					</li>
					
					</ul>
					
				</div>
			</div>
		</div>
	<div id="layout_right">	
		<iframe height="100%" width="100%" id="mainFrameWelcome" name="mainFrameWelcome" scrolling="no" marginheight="0" marginwidth="0" allowtransparency="true" hspace="0" frameborder="0" 
		 <c:if test="${empty param.url }">src="welcome.jsp"</c:if>
		 <c:if test="${not empty param.url }">src="${param.url }"</c:if>
		></iframe>
	</div> 
	
<input type="hidden" id="windowheight" />
<input type="hidden" id="mainFrameheight" />
<input type="hidden" id="windowwidth" />
<input type="hidden" id="mainFramewidth" />
	 
<script src="js/jquery-1.7.2.min.js"></script>	
<script src="js/tweenmax.min.js"></script>
<script src="js/scripts.js"></script>

<script type="text/javascript">
$(document).ready(function(){	
	$("#windowheight").val($(window).height());
	$("#mainFrameheight").val($(window).height() - 48 - 120);
	$("#windowwidth").val($(window).width());
	$("#mainFramewidth").val($(window).width() - 618);
	

    $("dl.sub-menu>dd").hover(function () {
    	//查询子集分类  传入相关ID
    //	alert($(this).index());
        $("#div_sub_submenu").hide();
        var index = $("dl.sub-menu>dd").index(this);
        var submenus = $(this).find("textarea.sub-menu-data");
        var thirdMenu = $("#div_sub_submenu");
        var thirdMenuContainer = $("#div_sub_submenu>ul");
        var $this = $(this);
        if (submenus && submenus.length > 0) {
            thirdMenuContainer.empty();
            $(submenus.val()).appendTo(thirdMenuContainer);
            thirdMenu.css({ top: 130+index*35 }).show();
        }
    });
    $(".left dl dd").click(function(i){

    	var id_li_a = $(this).find("a").attr("id");
    	if(id_li_a == '003015'){
    		tabClickHref("http://localhost:8086/UniteCount/countSet.jsp");
		}else{
    		tabClick("系统维护",'系统维护',id_li_a,"&pageSize=8&type=1");	
		}
    });
});
</script>

</body>
</html>