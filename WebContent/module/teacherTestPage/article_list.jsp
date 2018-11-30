<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><s:text name="systemName" /></title>
<link href="qc/css/style.css" rel="stylesheet" />
<link href="qc/css/calendar.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<style type="text/css">
.mem_class {
	position: relative;
}

.mem_remove {
	position: absolute;
	right: 6px;
	top: 4px;
	color: #ea183f;
	font-size: 12px;
	cursor: pointer;
}

.mem_add {
	color: #ea183f;
	cursor: pointer;
}

#addMember {
	width: 600px;
	height: 400px;
	top: 69px;
	background: #fff;
	position: absolute;
}
</style>

<!-- 于齐紫 -->

<script type="text/javascript">
	$(function() {
		$("#mem_serach")
				.click(
						function() {
							$
									.ajax({
										url : 'ajaxAction.action?suiji='
												+ new Date().getTime()
												+ '&code=0020320020203&paramMap.name='
												+ $("#mem_key").val()
												+ '&paramMap.tID=${paramMap.tID }',
										type : 'post',
										timeout : '60000',
										data : Array(),
										dataType : 'json',
										beforeSend : function(request) {
										},//ajax执行前调用函数
										complete : function(request, textStatus) {
										},//ajax请求完成后调用函数
										success : function(jsonData, textStatus) {//ajax请求成功调用函数
											if (textStatus == "success") {
												//alert(jsonData.list.length);
												$(".tInfo").remove();
												for ( var i = 0; i < jsonData.list.length; i++) {

													var tr = $("<tr class='tInfo'></tr>");
													var td = $("<td></td>");
													td
															.append("<a href='decorateForwardAction.action?code=002034&paramMap.uID="
																	+ jsonData.list[i].userID
																	+ "' >"
																	+ jsonData.list[i].userName
																	+ "</a>");
													tr.append(td);
													td = $("<td></td>");
													td
															.append(jsonData.list[i].userType);
													tr.append(td);
													td = $("<td></td>");
													td
															.append("<a uType='"+jsonData.list[i].userType+"' uName='"+jsonData.list[i].userName+"' uImg='"+jsonData.list[i].userImg+"' uid='"+jsonData.list[i].userID+"' class='mem_add' >添加</a>");
													tr.append(td);
													$("#mTable").append(tr);
												}

											}
										},
										//ajax请求错误后调用函数
										error : function(request, textStatus,
												error) {
										}
									});
						})

		$(".mem_remove")
				.die()
				.live(
						"click",
						function() {
							var uid = $(this).attr("uid");
							var tid = $('#teamid').val();
							var liObj = $(this);
							if (confirm("确定要移除此用户吗")) {
								$
										.ajax({
											url : 'ajaxAction.action?code=0020320020202&paramMap.uID='
													+ uid
													+ '&paramMap.tID='
													+ tid,
											type : 'post',
											timeout : '60000',
											data : Array(),
											dataType : 'json',
											beforeSend : function(request) {
											},
											complete : function(request,
													textStatus) {
											},
											success : function(jsonData,
													textStatus) {
												if (textStatus == "success") {
													if (jsonData.flag > 0) {
														alert("删除成功！");
														liObj.parent().remove();
													}
												}
											}
										});
							}

						})

		$(".mem_add")
				.die()
				.live(
						"click",
						function() {
							var uid = $(this).attr("uid");
							var uImg = $(this).attr("uImg");
							var uName = $(this).attr("uName");
							var uLevel = $(this).attr("uLevel");
							var uType = $(this).attr("uType");
							var tid = $('#teamid').val();
							var liObj = $(this);
							$
									.ajax({
										url : 'ajaxAction.action?code=0020320020201&paramMap.uID='
												+ uid + '&paramMap.tID=' + tid,
										type : 'post',
										timeout : '60000',
										data : Array(),
										dataType : 'json',
										beforeSend : function(request) {
										},
										complete : function(request, textStatus) {
										},
										success : function(jsonData, textStatus) {
											if (textStatus == "success") {
												if (jsonData.flag > 0) {
													alert("添加成功！");
													//liObj.parent().remove();
													var type = "";
													if (uType == "1") {
														type = "老师";
													} else if (uType == "2") {
														type = "学生";
													} else {
														type = "管理员";
													}

													var li = '<li class="mem_class">'
															+ '<div uid="'+uid+'" class="mem_remove">移除</div>'
															+ '<a href="#uid='+uid+'" class="left">'
															+ '<img src="'+uImg+'" width="64" height="64" />'
															+ '</a>'
															+ '<div class="right">'
															+ '<h5><a href="javascript:void(0)">'
															+ uName
															+ '</a></h5>'
															+ "<p>用户身份：<em>"
															+ type
															+ "</em></p>"
															+ '<p>成员权限：<span class="red">成员</span></p>'
															+ '</div>'
															+ '</li>';
													$(".tabcontent .groups")
															.append(li);
													liObj.parent().parent()
															.remove();
												}
											}
										}
									});
						})

		$("#addClose").click(function() {
			$("#addMember").hide();
		});
		$("#addOpen").click(function() {
			$("#addMember").css({
				"left" : ($(document.body).width() - 600) / 2 + "px"
			});
			$("#addMember").show();
		});
	})
</script>
</head>
<body>
	<div id="layout_mainbody" style="position: relative; overflow: hidden; height: 681px;">
		<div class="rollbar-path-horizontal" style="z-index: 10; display: none; left: 0px; width: 1408px;">
			<div class="rollbar-handle" style="width: 30%; opacity: 0.5; left: 0px;"></div>
		</div>
		<div class="rollbar-content" style="position: relative; top: 0px; left: 0px; overflow: hidden;">
			<div class="page-container ssjh">
				<div class="my-article panel">
					<input type="hidden" id="teamid" value="${paramMap.tID }">
					<p class="title topborder">文章列表</p>
					<div class="tabcontent">
						<ul class="rank-list" style="margin-left:20px;margin-right: 20px;">
								<s:iterator id="t" value="initMap.TarticleList" status="index">
									<li><i class="icon-no ${index.index<3?'top3':'' }">${index.index+1}</i>
										<a title="${t.aTitle}" href="decorateForwardAction.action?code=002031003&paramMap.aID=${t.aID}">
											${t.aTitle}
										</a>
									</li>
								</s:iterator>
						</ul>
						<div class="pageb" id="table3page" style="margin-right: 20px;">
				             ${initMap.paginated.pageContent}</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<script src="qc/js/jquery-1.7.2.min.js"></script>
	<script src="qc/js/tweenmax.min.js"></script>
	<script src="qc/js/jquery.bxslider.min.js"></script>
	<script src="qc/js/scripts.js"></script>
</body>
</html>