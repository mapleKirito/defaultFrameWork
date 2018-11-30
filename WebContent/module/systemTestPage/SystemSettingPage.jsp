<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<title></title>
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
.childrenxt li{margin:15px 0px;}
body{margin: 0px; font-size: 12px;}
a{ text-decoration:none;color: #333;}
a:hover{ text-decoration:none;color: #333;}
</style>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.main.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialogDown.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<link href="qc/css/style.css" rel="stylesheet" />
<link href="qc/css/calendar.css" rel="stylesheet" />
<script src="qc/js/jquery-1.7.2.min.js"></script>
<script src="qc/js/tweenmax.min.js"></script>
<script src="qc/js/scripts.js"></script>
<script>
$(document).ready(function(){
	
	/* $("#welcome").click(function(){
		$("#childrenMain").attr("src","childrenwelcome.jsp");		
	});
	
	$(".childrenxt li").click(function(i){
		var id_li_a = $(this).children().attr("id");
	    $("#childrenMain").attr("src","decorateForwardAction.action?code="+id_li_a+"&suijichileren="+new Date());	
	}); */
	
	$(".menuTabTextNavigation",parent.document).html("${pmsIndex.sys_mgr.name} &gt; <a href='decorateForwardAction.action?code=${pmsIndex.sys_systempage_mgr.code}'>${pmsIndex.sys_systempage_mgr.name}</a>");
	
	$(".left dl dd").click(function(i){
		var id_li_a = $(this).find("a").attr("id");
	    $("#childrenMain").attr("src","decorateForwardAction.action?code="+id_li_a+"&suijichileren="+new Date());	
	});
		
});
function manager_pms(flag){
    if(flag==3){

	//跳转，统计页面
		tabClickHref("http://localhost:8086/UniteCount/countSet.jsp");
	}
	
}
</script>
</head>
<style>
.page-container.ssjh { width: 100%; }
.ssjh-grxx div.right { float: left; display: inline;} 
.ssjh-grxx div.left { width: 120px; }
.ssjh-grxx div.left dl dd { text-indent: 11px; margin-bottom: 0px;}
.ssjh-grxx div.right { width: 850px; margin-left: 5px;}
.ssjh-grxx { width: 980px; margin: 3% auto 0px; }
.icon-menu { right: 15px; }
.ssjh-grxx div.left dl dt { text-indent: 15px; }
</style>
<body>
<div id="layout_mainbody">
		<div class="page-container ssjh">
			<div class="ssjh-grxx">
				<div class="left">
					<dl>
						<dt style="position: relative;">
							科室管理<i class="icon-menu"></i>
						</dt>
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
						<dt style="position: relative;margin-top: 10px;">
							系统设置<i class="icon-menu"></i>
						</dt>
						<%-- <dd>
							<a id="${pmsIndex.myNetbk.code}"  href="javascript:void(0);">网络备课(老师有)
							</a>
						</dd> --%>
						<dd>
							<a href="javascript:void(0);" id="${pmsIndex.sys_resource_history.code}">${pmsIndex.sys_resource_history.name}
							</a>
						</dd>
						<%-- <dd>
							<a href="javascript:void(0);" id="${pmsIndex.sys_org_mgr.code}">${pmsIndex.sys_org_mgr.name}
							</a>
						</dd> --%>
						<dd>
							<a href="javascript:void(0);" id="${pmsIndex.sys_count_mgr.code}">${pmsIndex.sys_count_mgr.name}
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
							<a href="javascript:void(0);" id="${pmsIndex.sys_count_mgr.code}">统计设置
							</a>
						</dd>
					    <dd>
							<a href="javascript:void(0);" id="${pmsIndex.sys_settings_db_param.code}">系统设置
							</a>
						</dd>
					</dl>
				</div>
				<div class="right">
					<iframe id="childrenMain" name="childrenMain" scrolling="no" marginheight="0" marginwidth="0" frameborder="0" src="decorateForwardAction.action?code=${pmsIndex.res_exhibition_room_mgr.code}" width="100%" style="width: 850px; height: 600px"></iframe>
				</div>
				
			</div>
		</div>
	</div>
</body>
</html>