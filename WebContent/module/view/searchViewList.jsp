<%@page import="com.ow.framework.listener.event.EventExecutor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>

<html>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/style.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/autoscroll.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
	<script src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
$(document).ready(
			function() {
				if ('${paramMap.cateSign}' != 'expand') {
					$("#funbig2").hide();
					$("#funbig1").show();
				} else {
					$("#funbig2").show();
					$("#funbig1").hide();
				}

				$('#table2page').pageTB();
				$('#table3page').pageTB();

				//（翻页/回显）获取页面两种展示方式效果 之一    1：imageflow展示     2：块状缩略图展示

				var type = '${paramMap.changeType}';
				if(type=='1'){ 
					$(".table_to").eq(type).show().siblings().hide();
				}
				if(type=='0'){ 
					 $(".table_to").eq(type).show().siblings().hide();
				}
				
});
	//级联更新分类信息
	function selectFour() {
		var ciValue = $('#si');
		var string = $('#path').val();
		var sArray = string.split(',');
		var catePath = "," + sArray[1] + "," + sArray[2] + "," + sArray[3]
				+ ",";
		//document.write(catePath);
		var cateLevel = 4;
		//ciValue.html("");
		//ciValue.append('<option value="">请选择五级分类</option>');
		$.ajax({
			url : 'ajaxAction.action?code=003006009&paramMap.cateLevel='
					+ cateLevel + '&paramMap.catePath=' + catePath,
			type : 'post',
			timeout : '60000',
			data : Array(),
			dataType : 'json',
			beforeSend : function(request) {
			},
			complete : function(request, textStatus) {
			},
			success : function(jsonData, textStatus) {
				var cateList = new Array();
				if (textStatus == "success") {
					if (jsonData.data) {
						jrinitData = jsonData.data;
						for (var i = 0; i < jsonData.data.length; i++) {
							var cateID = jsonData.data[i].cateID;
							var cateName = jsonData.data[i].cateName;
							var catePath = jsonData.data[i].catePath;
							var cateLevel = jsonData.data[i].cateLevel;
							ciValue.append('<option value="'+catePath+'">'
									+ cateName + '</option>');
						}
						ciValue.append(html.join(''));
					}
				}
			}
		});
	}
	function selectFive() {
		var ciValue = $('#wu');
		var catePath = $('#si').val();
		var cateLevel = 5;
		ciValue.html("");
		//ciValue.append('<option value="">请选择五级分类</option>');
		$.ajax({
			url : 'ajaxAction.action?code=003006009&paramMap.cateLevel='
					+ cateLevel + '&paramMap.catePath=' + catePath,
			type : 'post',
			timeout : '60000',
			data : Array(),
			dataType : 'json',
			beforeSend : function(request) {
			},
			complete : function(request, textStatus) {
			},
			success : function(jsonData, textStatus) {
				var cateList = new Array();
				if (textStatus == "success") {
					if (jsonData.data) {
						jrinitData = jsonData.data;
						for (var i = 0; i < jsonData.data.length; i++) {
							var cateID = jsonData.data[i].cateID;
							var cateName = jsonData.data[i].cateName;
							var catePath = jsonData.data[i].catePath;
							var cateLevel = jsonData.data[i].cateLevel;
							ciValue.append('<option value="'+catePath+'">'
									+ cateName + '</option>');
						}
						ciValue.append('<option value="">' + "五级分类结束"
								+ '</option>');
						ciValue.append(html.join(''));

					}
				}
			}
		});
	}
	function changeList(v) {
		//根据五级分类异步请求分类内容
		var catePath;
		var cateLevel;
		//判断有没有五级分类
		if ($('#wu').val() == "") {
			catePath = $('#si').val();
			cateLevel = 4;
		} else {
			catePath = $('#wu').val();
			cateLevel = 5;
		}
		window.location.href = "decorateForwardAction.action?code=-701&paramMap.path="
				+ catePath
				+ "&paramMap.cateLevel="
				+ cateLevel
				+ "&paramMap.erTotalID=2&paramMap.cateSign=exhibition&pageSize=8&type=1";
	}
	
	function reshen(grade,id){
		art.dialog.data('contextPath','/dm');
		art.dialog.open('decorateForwardAction.action?code=-170102&paramMap.testGrades ='+grade+ '&paramMap.testID ='+ id+ '&paramMap.testNum =1',
			{
				width : 950,
				height : 604,
				title : '探究热身',
				lock : 'true',
				background : '#666666',
				opacity : '0.15'
			});
	
	}
	function tanjiugc(createkeywords,id){
		window.parent.tabClick("munu_name","问题浏览",'-1890002','&paramMap.createkeywords='+createkeywords+ '&paramMap.htaskID ='+ id);
	
	}
	function tanjiucg(htaskKeywords,id){
		window.parent.tabClick("munu_name","问题浏览",'-1890002','&paramMap.htaskID='+id+'&pageSize=8&type=1&paramMap.htaskKeywords='+htaskKeywords);
	}
</script>
<script type="text/javascript">
	
	function tab_click(flag) {
		if (flag == 0) {
			$("#funbig1").hide();
			$("#funbig2").show();
			$("#changeType").val(1);
		}
		if (flag == 1) {
			$("#funbig1").show();
			$("#funbig2").hide();
			$("#changeType").val(0);
		}

	}
</script>

<style type="text/css">

</style>
</head>
<body leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0">
<input type="hidden" id="changeType" value="${paramMap.changeType }">
	<div id="layout_mainbody">
		<!--资源列表开始-->
		<div class="page-container">
		
			<div class="res-list">
				<div class="res-list-query">
					<span class="list-type">
					<a  onclick="tab_click(0)" href="javascript:void(0)"
						class="list-type-list"></a>
					 <a onclick="tab_click(1)"
						href="javascript:void(0)" class="list-type-grid"></a> 
					
					</span>
				</div>
			</div>

			<s:if test="initMap.resView.isEmpty()">
				<center>
					<h3 style="color: red; margin-top: 100px;">没有相关数据</h3>
					<script type="text/javascript">
						$(".table_to").hide();
						$("#ladingImag").hide();
					</script>
				</center>
			</s:if>
			<input type="hidden" id="path" name="path"
				value="${paramMap.catePath}" /> <input type="hidden" id="resType"
				value="${paramMap.cateSign}" />
			<div class="rg-image-controls"
				style="width: 100%; background-color: #e8e8e8; position: fixed; z-index: 300; top: 0px; left: 0px; display: none;">
				<table border="0" width="100%" height="100%" cellspacing="0"
					cellpadding="0" id="talbe_screen"
					style="opacity: 0.8; margin: 0 auto; color: #333;">
				</table>
				<div class="rg-image-fo"
					style="text-align: right; margin-right: 20px;">
					<img src="images/left.png" border="0">
				</div>
			</div>

			<form name="actionForm" method="post"
				action="decorateForwardAction.action" id="actionForm"
				>
				<s:if test="initMap.resView.isEmpty()== false">

					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="table_to res_info" id="funbig1" style="display: none;">
						<tr>
							<s:iterator value="initMap.resView" id="fv" status="fvindx">
								
								<s:if test="#fvindx.index%4 ==0">
									<tr>
									<tr height="20px">
									</tr>
								</s:if>
								<td align="center">
									<div id="boxgrid<s:property value=" #fvindx.index " />"  class="gallery" style="position: relative; top: 5px;">
										<div style="height: 180px; background: #e8ddd0;" id="outdiv">
										<s:if test="#fv.resType == 'question' ">
												<s:if test="#fv.code == '1701' ">
													<a  onclick="reshen('${fv.testGrades }','${fv.id }')" href="javascript:void(0);"> 
														<span  style="color: #000000;"> 
															<img src="images/resImage/tanjiu.png" alt="${fv.name}" style="" height="180px" class="image eightPic"  id="imas<s:property value=" #fvindx.index" />" />
														</span>
													</a>
												
												</s:if>
												<s:elseif test="#fv.code == '1890002' ">
												     <a  onclick="tanjiugc('${fv.createkeywords }','${fv.id }')" href="javascript:void(0);"> 
														<span  style="color: #000000;"> 
															<img src="images/resImage/tanjiu.png" alt="${fv.name}" style="" height="180px" class="image eightPic"  id="imas<s:property value=" #fvindx.index" />" />
														</span>
													</a>
												</s:elseif>
												<s:elseif test="#fv.code == '1890003' ">
												     <a  onclick="tanjiucg('${fv.htaskKeywords }','${fv.id }')" href="javascript:void(0);"> 
														<span  style="color: #000000;"> 
															<img src="images/resImage/tanjiu.png" alt="${fv.name}" style="" height="180px" class="image eightPic"  id="imas<s:property value=" #fvindx.index" />" />
														</span>
													</a>
												</s:elseif>
													
												<div class="textPdown title" id="textPdown${fvindx.index}">
													<span>
													 <a href="javascript:void(0)" style="color: white;">
														 <s:if test="#fv.name.length() > 9"> <s:property value="#fv.name.substring(0,9)" /> ... </s:if>
														  <s:else> <s:property value="#fv.name" /> </s:else>
													</a>
													</span>
													<!-- 如果是文物博览室带音频的资源应该与提示 -->
													<p>
														<a href="javascript:void(0)" style="background: url(images/icon-spriter.png) no-repeat;left: 65px;background-position: 2px -950px;" class="icon-qrcode"></a>
														<a href="javascript:void(0)" style=" background:url(images/media-types.png) no-repeat;background-position: 0px 0px;left: 125px;" class="icon-love"></a>
													</p>
	
												</div>
								        </s:if>
								        <s:else>
								        	<s:set name="pcode" value="''" />
											<s:set name="pname" value="''" />
											<s:set name="expurl" value="''" />
											<s:if test="#fv.resType == 'exhibition'">
												<s:set name="pcode" value="'-701003'" />
												<s:set name="pname" value="'erID'" />
												<s:set name="broomname" value="'er'" />
												<s:if test="#fv.fileType == '1011'">
													<s:set name="pcode" value="'-701001'" />
												</s:if>
												<s:if
													test="#fv.fileType == '1073' || #fv.fileType == '1084'">
													<s:set name="pcode" value="'-701002'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
													<s:set name="pcode" value="'-701018'" />
												</s:if>
											</s:if>
											<s:if test="#fv.resType == 'observation'">
												<s:set name="pcode" value="'-701006'" />
												<s:set name="pname" value="'orID'" />
												<s:set name="broomname" value="'or'" />
												<s:if
													test="#fv.fileType == '1011' || #fv.fileType == '1022' || #fv.fileType == '2055'">
													<s:set name="pcode" value="'-701004'" />
												</s:if>
												<s:if test="#fv.fileType == '4033' ">
													<s:set name="pcode" value="'-701023'" />
												</s:if>
												<s:if
													test="#fv.fileType == '1084'">
													<s:set name="pcode" value="'-701005'" />
												</s:if>
												<s:if
													test="#fv.fileType == '1073'">
													<s:set name="pcode" value="'-701004'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033' ">
													<s:set name="pcode" value="'-701019'" />
												</s:if>
											</s:if>
											<s:if test="#fv.resType == 'laboratory'">
												<s:set name="pcode" value="'-701009'" />
												<s:set name="pname" value="'lrID'" />
												<s:set name="broomname" value="'lr'" />
												<s:if
													test="#fv.fileType == '1011' || #fv.fileType == '1022' ||#fv.fileType == '1073' || #fv.fileType == '2055'">
													<s:set name="pcode" value="'-701007'" />
												</s:if>
												<s:if
													test="#fv.fileType == '1084'">
													<s:set name="pcode" value="'-701008'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033' ">
													<s:set name="pcode" value="'-701020'" />
												</s:if>
											</s:if>
											<s:if test="#fv.resType == 'projection'">
												<s:set name="pcode" value="'-701012'" />
												<s:set name="pname" value="'prID'" />
												<s:set name="broomname" value="'pr'" />
												<s:if
													test="#fv.fileType == '1011' || #fv.fileType == '1022' || #fv.fileType == '2055'">
													<s:set name="pcode" value="'-701010'" />
												</s:if>
												<s:if test="#fv.fileType == '1084'">
													<s:set name="pcode" value="'-701011'" />
												</s:if>
												<s:if test="#fv.fileType == '1073'">
													<s:set name="pcode" value="'-701024'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033' ">
													<s:set name="pcode" value="'-701021'" />
												</s:if>
											</s:if>
											<s:if test="#fv.resType == 'lovely'">
												<s:set name="pcode" value="'-701013'" />
												<s:set name="pname" value="'crID'" />
												<s:set name="broomname" value="'cr'" />
												<s:if
													test="#fv.fileType == '1011' || #fv.fileType == '1022' ||#fv.fileType == '1073' || #fv.fileType == '2055'">
													<s:set name="pcode" value="'-701016'" />
												</s:if>
												<s:if
													test="#fv.fileType == '1084'">
													<s:set name="pcode" value="'-701017'" />
												</s:if>
												<s:if test="#fv.fileType == '2095' ">
													<s:set name="pcode" value="'-701013'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033' ">
													<s:set name="pcode" value="'-701022'" />
												</s:if>
												<s:if test="#fv.crTaskId != null && #fv.crTaskId != ''">
													<s:set name="expurl" value="#fv.crContent" />
												</s:if>
											</s:if>
											<s:if test="#expurl == ''">
												<a href="javascript:void(0)" code="${pcode}"
													onclick="window.parent.showView(this)"
													param="&path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.fileType=${fv.fileType}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
													<img src="${fv.thumbnail}" alt="${fv.name}"
													style="" height="180px"
													class="image eightPic"
													id="imas<s:property value=" #fvindx.index
								" />" />
												</a>
											</s:if>
											<s:if test="#expurl != ''">
												<s:if test="session.s_userType == 1">
													<a href="${expurl}&code=002001004"> <span
														style="color: #000000;"> <img src="${fv.thumbnail}"
															alt="${fv.name}" style="" height="180px"
															class="image eightPic"
															id="imas<s:property value=" #fvindx.index
										" />" />
													</span>
													</a>
												</s:if>
												<s:if test="session.s_userType == 2">
													<a href="${expurl}&code=001001003"> <span
														style="color: #000000;"> <img src="${fv.thumbnail}"
															alt="${fv.name}" style="" height="180px"
															class="image eightPic"
															id="imas<s:property value=" #fvindx.index
										" />" />
													</span>
													</a>
												</s:if>
												<s:if test="session.s_userType == 3">
													<a href="${expurl}&code=3002001004"> <span
														style="color: #000000;"> <img src="${fv.thumbnail}"
															alt="${fv.name}" style="" height="180px"
															class="image eightPic"
															id="imas<s:property value=" #fvindx.index
										" />" />
													</span>
													</a>
												</s:if>
											</s:if>
											<div class="textPdown title" id="textPdown${fvindx.index}">
												<span> <a href="javascript:void(0)"
													style="color: white;"> <s:if
															test="#fv.name.length() > 9">
															<s:property value="#fv.name.substring(0,9)" />
								...
							</s:if> <s:else>
															<s:property value="#fv.name" />
														</s:else>
												</a>
												</span>
												<!-- 如果是文物博览室带音频的资源应该与提示 -->

												<p>
													<a href="javascript:void(0)" style="background: url(images/icon-spriter.png) no-repeat;left: 65px;background-position: 2px -950px;" class="icon-qrcode"></a>
													<!-- //收藏 -->
													<!-- <a href="javascript:void(0)" style=" background:url(images/media-types.png) no-repeat;background-position: 0px 0px;left: 125px;" class="icon-love"></a> -->
													<!-- 音频提示 -->
													<s:if test="#fv.audio!=''&&#fv.audio!=null">
													<a href="javascript:void(0)" style=" background:url(images/media-types.png) no-repeat;background-position: 0px 0px;left: 125px;" class="icon-love"></a>
													</s:if>
												</p>

											</div>
													<%-- <em class="res-type" roomtype="${fv.rrResourceType}" resid="${fv.rrResourceID }" ><i class="res-type-media"></i><label></label></em> --%>
										
								        </s:else>
								    </div>	
												
								</td>
							</s:iterator>
						</tr>
						<tr height="20px">
						</tr>
						<tr>
							<td colspan="7" height="30" align="right">
								<div class="pageb" id="table2page">
									${initMap.paginated.pageContent}</div>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="table_to table_list" id="funbig2"
						style="line-height: 30px; margin-top: 20px; display: none;">

						<thead>
							<tr>
								<th>条形码号</th>
								<th>资源类型</th>
								<th>中文名</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<s:iterator value="initMap.resView" id="fv" status="fvindx">
							
							<s:set name="pcode" value="''" />
							<s:set name="pname" value="''" />
							<s:set name="expurl" value="''" />
							<s:set name="type" value="''" />
							<s:if test="#fv.resType == 'exhibition'">
								<s:set name="pcode" value="'-1001003'" />
								<s:set name="pname" value="'erID'" />
								<s:set name="broomname" value="'er'" />
								<s:if test="#fv.fileType == '1011'">
									<s:set name="pcode" value="'-1001001'" />
									<s:set name="type" value="'高清图片'" />
								</s:if>
							</s:if>
							<s:if test="#fv.resType == 'observation'">
								<s:set name="pcode" value="'-1001006'" />
								<s:set name="pname" value="'orID'" />
								<s:set name="broomname" value="'or'" />
								<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
									<s:set name="pcode" value="'-1001004'" />
									<s:set name="type" value="'高清图片'" />
								</s:if>
								<s:if test="#fv.fileType == '4033' ">
									<s:set name="pcode" value="'-1001021'" />
									<s:set name="type" value="'多维观察'" />
								</s:if>
								<s:if test="#fv.fileType == '1084'">
									<s:set name="type" value="'高清视频'" />
									<s:set name="pcode" value="'-1001005'" />
								</s:if>
								
								<s:if test="#fv.fileType == '1073'">
									<s:set name="type" value="'音频'" />
									<s:set name="pcode" value="'-1001004'" />
								</s:if>
							</s:if>
							<s:if test="#fv.resType == 'laboratory'">
								<s:set name="pcode" value="'-1001009'" />
								<s:set name="pname" value="'lrID'" />
								<s:set name="broomname" value="'lr'" />
								<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
									<s:set name="pcode" value="'-1001007'" />
									<s:set name="type" value="'高清图片'" />
								</s:if>
								<s:if test="#fv.fileType == '1084'">
									<s:set name="pcode" value="'-1001008'" />
									<s:set name="type" value="'高清视频'" />
								</s:if>
								<s:if test="#fv.fileType == '1073'">
									<s:set name="pcode" value="'-1001007'" />
									<s:set name="type" value="'音频'" />
								</s:if>
								
								<s:if test="#fv.fileType == '2002'">
									<s:set name="pcode" value="'-1001009'" />
									<s:set name="type" value="'虚拟仿真实验'" />
								</s:if>
								<s:if
									test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
									<s:set name="pcode" value="'-1001018'" />
									<s:set name="type" value="'文档课件'" />
								</s:if>
							</s:if>
							<s:if test="#fv.resType == 'projection'">
								<s:set name="pcode" value="'-1001012'" />
								<s:set name="pname" value="'prID'" />
								<s:set name="broomname" value="'pr'" />
								<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
									<s:set name="pcode" value="'-1001010'" />
									<s:set name="type" value="'高清图片'" />
								</s:if>
								<s:if test="#fv.fileType == '1073'">
									<s:set name="type" value="'音频'" />
									<s:set name="pcode" value="'-1001023'" />
								</s:if>
								<s:if test="#fv.fileType == '1084'">
									<s:set name="type" value="'高清视频'" />
									<s:set name="pcode" value="'-1001011'" />
								</s:if>
							</s:if>
							<s:if test="#fv.resType == 'lovely'">
								<s:set name="pcode" value="'-1001013'" />
								<s:set name="pname" value="'crID'" />
								<s:set name="broomname" value="'cr'" />
								<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
									<s:set name="pcode" value="'-1001014'" />
									<s:set name="type" value="'高清图片'" />
								</s:if>
								<s:if test="#fv.fileType == '1073'">
									<s:set name="type" value="'音频'" />
									<s:set name="pcode" value="'-1001024'" />
								</s:if>
								<s:if test="#fv.fileType == '1084'">
									<s:set name="type" value="'高清视频'" />
									<s:set name="pcode" value="'-1001015'" />
								</s:if>
								<s:if test="#fv.fileType == '2095' ">
									<s:set name="pcode" value="'-1001013'" />
									<s:set name="type" value="'swf文件'" />
								</s:if>
								<s:if
									test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
									<s:set name="type" value="'文档课件'" />
									<s:set name="pcode" value="'-1001020'" />
								</s:if>
								<s:if test="#fv.crTaskId != null && #fv.crTaskId != ''">
									<s:set name="expurl" value="#fv.crContent" />
								</s:if>
							</s:if>
							<tr>
								<td width="10%" class="onlyex" align="center">
									<s:if test="#fv.resType == 'question' ">
										<img src="images/resImage/tanjiu.png" border="0" width="16" height="16" style="cursor: default;">
									</s:if>
									<s:else>
										<img src="<%=request.getContextPath()%>/images/resImage/s_<s:property value="#fv.fileType " escape="false " />.gif" border="0" style="cursor: default;">
									</s:else>
									<span>${fvindx.index+1}</span>
								</td>
								<td width="10%" class="onlyex" align="center">
									<s:if test="#fv.resType == 'question' ">
										探究答疑
									</s:if>
									<s:else>
										${type}
									</s:else>
								</td>
								<td width="45%" class="onlyex" align="left">&nbsp;&nbsp; 
									<s:if test="#fv.resType == 'question' ">
										<s:if test="#fv.code == '1701' ">
											<a  onclick="reshen('${fv.testGrades }','${fv.id }')" href="javascript:void(0);"> 
											<span> ${fv.name}</span>
										</a>
										</s:if>
										<s:elseif test="#fv.code == '1890002' ">
											<a  onclick="tanjiugc('${fv.createkeywords }','${fv.id }')" href="javascript:void(0);"> 
												<span> ${fv.name}</span>
											</a>
										</s:elseif>
										<s:elseif test="#fv.code == '1890003' ">
											 <a  onclick="tanjiucg('${fv.htaskKeywords }','${fv.id }')" href="javascript:void(0);"> 
												<span> ${fv.name}</span>
											</a>
										</s:elseif>
									</s:if>
									<s:else>
										<a onclick="window.parent.frames.showView(this)" name="${fv.name}"
										codeNum="${pcode}"
										param="&path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.fileType=${fv.fileType}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
											<span> <s:property value="#fv.name" /></span>
										</a>
									</s:else>
								</td>
								<td width="10%" align="center" class="onlyex">
										<s:property value="#fv.createTime" />
							
									</td>
								<td width="25%" class="onlyex" align="left">&nbsp; 
									<s:if test="#fv.resType == 'question' ">
										<s:if test="#fv.code == '1701' ">
											<a class="lt-button fade-button"
												 onclick="reshen('${fv.testGrades }','${fv.id }')" href="javascript:void(0);">
												预览 </a>
										</s:if>
										<s:elseif test="#fv.code == '1890002' ">
											<a class="lt-button fade-button"
												 onclick="tanjiugc('${fv.createkeywords }','${fv.id }')" href="javascript:void(0);">
												预览 </a>
										</s:elseif>
										<s:elseif test="#fv.code == '1890003' ">
											<a class="lt-button fade-button"
												 onclick="tanjiucg('${fv.htaskKeywords }','${fv.id }')" href="javascript:void(0);">
												预览 </a>
										</s:elseif>
									</s:if>
									<s:else>
										<s:if test="#fv.upload != ''">
											<a class="lt-button fade-button"
												 href="javascript:void(0)" code="${pcode}"
														onclick="window.parent.showView(this)"
														param="&path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.fileType=${fv.fileType}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
														
												预览 </a>
											<a class="lt-button fade-button"
												href="downloadAction.action?code=-706&paramMap.resDownRoom=${fv.resType}&paramMap.resDownType=${fv.fileType}&paramMap.resPath=${fv.upload}">
												资源下载 </a>	
										</s:if> 
										<s:if
											test="#fv.rrAudio!= '' and #fv.rrAudio!= null   and #fv.fileType == '1011'">
	
											<a
												href="downloadAction.action?code=-706&paramMap.resDownRoom=${fv.resType}&paramMap.resDownType=${fv.fileType}&paramMap.resPath=<s:property value="
							#fv.audio " />"
												class="lt-button fade-button">音频下载</a>
										</s:if>
									</s:else>
								</td>
							</tr>

						</s:iterator>
						<tfoot>
							<tr>
								<td colspan="5" align="right">
									<div class="pageb" id="table3page">
										${initMap.paginated.pageContent}</div>
								</td>
							</tr>
						</tfoot>
					</table>

				</s:if>
			</form>
		</div>
	</div>
	
	<script src="js/tweenmax.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="js/jQuery.welcome.js"></script>
</body>
</HTML>