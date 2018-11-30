<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/pageToolbar2.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<link href="slideBox/css/jquery.slideBox.css" rel="stylesheet" type="text/css" />
<script src="slideBox/js/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="slideBox/js/jquery.slideBox.js" type="text/javascript"></script>
<script>
jQuery(function($){
	$('#demo4').slideBox({
		hideBottomBar : true//隐藏底栏
	});
});
</script>
<script type="text/javascript">

$(function(){
	var $div_li =$(".teacherTab li");
	$div_li.click(function(){
		$(this).addClass("curr").siblings().removeClass("curr");  
		var index =  $div_li.index(this);  
		$("#change_type").val(index);
		$(".table_9").eq(index).show().siblings().hide();
	});
	
	var change_type_index = '${paramMap.change_type}' == '' ? '0' : '${paramMap.change_type}';
	$div_li.eq(change_type_index).addClass("curr").siblings().removeClass("curr");
	$(".table_9").eq(change_type_index).show().siblings().hide();
	$("#change_type").val(change_type_index);
	
	
})
</script>
</head>
<body style="background-color:#e0ebee; margin:0; padding:0; font-family:'微软雅黑'" id="tt">
<input type="hidden" id="change_type" value="0">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="info_tb">
	<tr>
		<td>
			<div style="width: 650px;height:319px;float: left;background: gray;">
				<h3>推荐资源轮播图片区</h3>
				<div id="demo4" class="slideBox">
				  <ul class="items">
				    <li><a href="javascript:void(0)" title="这里是测试标题一"><img src="slideBox/img/1.jpg"></a></li>
				    <li><a href="javascript:void(0)" title="这里是测试标题二"><img src="slideBox/img/2.jpg"></a></li>
				    <li><a href="javascript:void(0)" title="这里是测试标题三"><img src="slideBox/img/3.jpg"></a></li>
				    <li><a href="javascript:void(0)" title="这里是测试标题四"><img src="slideBox/img/4.jpg"></a></li>
				    <li><a href="javascript:void(0)" title="这里是测试标题五"><img src="slideBox/img/5.jpg"></a></li>
				  </ul>
				</div>
			</div>
			<div style="width: 650px;height:319px;float:left;background: red;">
				<h3>荣誉榜单</h3>
				
			</div>
		</td>
	</tr>
	  <tr>			
		<td width="100%" bgcolor="#606373" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_8">
			  <tr>
				<td style="height:32px;">
					<ul class="teacherTab">
						<li class="curr">探究广场</li>
						<li>探究成果</li>
						<li>学习小组</li>
						<li>最新文章</li>
						<li>师生空间</li>
					</ul>								
				</td>
			  </tr>
			</table>
			<div>				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
				  	<tr bgcolor="#ae9b84">					  	  
						<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
							<div>
								<table>
									<tr>
										<th>标题</th>
										<th>提问者</th>
										<th>创建时间</th>
									</tr>
									
									<s:subset source="initMap.tasklist" start="0" count="10">
										<s:iterator id="task" status="newsIndex">
										<tr>
											<td><a href="decorateForwardAction.action?code=002019006&paramMap.htaskID=${task.htaskID}">${task.htaskTitle }</a></td>
											<td>${task.htaskCreaterName}</td>
											<td>${task.htaskCreatetime }</td>
										</tr>
										</s:iterator>
									</s:subset>
								
								</table>
							</div>
						</td>	
						
				  	<tr>
				</table>
				
				<table id="grid" width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
				  <tr bgcolor="#ae9b84">
					<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
						<div>
						<table>
						<tr>
							<th>标题</th>
							<th>提问者</th>
							<th>创建时间</th>
						</tr>
						
						<s:subset source="initMap.taskAcceptList" start="0" count="10">
							<s:iterator id="task" status="newsIndex">
							<tr>
								<td><a href="decorateForwardAction.action?code=002019006&paramMap.htaskID=${task.htaskID}">${task.htaskTitle }</a></td>
								<td>${task.htaskCreaterName}</td>
								<td>${task.htaskCreatetime }</td>
							</tr>
							</s:iterator>
						</s:subset>
						
						</table>
						</div>
					</td>
				  </tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
				  <tr bgcolor="#ae9b84">
					<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
						<div>
						<table>
						<tr>
							<th>小组名称</th>
							<th>小组简介</th>
							<th>创建人</th>
						</tr>
						
						<s:subset source="initMap.teamList" start="0" count="10">
							<s:iterator id="t" status="newsIndex">
							<tr>
								<td><a href="decorateForwardAction.action?code=002033&paramMap.tID=${t.tID }">${t.tName }</td>
								<td>${t.tDescription}</td>
								<td>${t.tUserName }</td>
							</tr>
							</s:iterator>
						</s:subset>
						
						</table>
						</div>
					</td>
				  </tr>
				</table>		
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
				  <tr bgcolor="#ae9b84">
					<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
						<div>
						<table>
						<tr>
							<th>文章标题</th>
							<th>发表人</th>
							<th>最后修改时间</th>
						</tr>
						
						<s:subset source="initMap.articleList" start="0" count="10">
							<s:iterator id="a" status="newsIndex">
							<tr>
								<td>${a.aTitle }</td>
								<td>${a.aCreaterName}</td>
								<td>${a.aTime }</td>
							</tr>
							</s:iterator>
						</s:subset>
						
						</table>
						</div>
					</td>
				  </tr>
				</table>	
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
				  <tr bgcolor="#ae9b84">
					<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
						<div>
						<table>
						<tr>
							<th>名称</th>
							<th>类型</th>
							<th>财富</th>
							<th>qq</th>
						</tr>
						
						<s:subset source="initMap.spaceList" start="0" count="10">
							<s:iterator id="a" status="newsIndex">
							<tr>
								<td>${a.userName }</td>
								<td>${a.userType==1?'老师':(a.userType==2?'学生':'管理员')}</td>
								<td>${a.wealth }</td>
								<td>${a.qq }</td>
							</tr>
							</s:iterator>
						</s:subset>
						
						</table>
						</div>
					</td>
				  </tr>
				</table>						
			</div>						
			</td>
	     </tr>
	</table>
</body>
</html>
