<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="FCK" uri="/WEB-INF/taglib/FCKeditor.tld" %>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript">
var gridTreeTB,treeTB;
$(document).ready(function(){	
	
});
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" action="operateAction.action">
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 160px;"></ul>
</div>
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.res_expand_room_mgr.imitationStep}">
<input name="paramMap.grID" type="hidden" id="grID" value="${initMap.gradeInfo.grID}"/>
<input type="hidden" name="paramMap.grResourceID" id="grResourceID" value="${initMap.gradeInfo.grResourceID}">
<input type="hidden" name="paramMap.grResourceIDOld" id="grResourceIDOld" value="${initMap.gradeInfo.grResourceID}">
<input type="hidden" name="paramMap.grThumbnail" id="grThumbnail" value="${initMap.gradeInfo.grThumbnail}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCcenter">
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
			<tr>
				<td class="SkyTDLine">
				<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<tr class="MeNewTDLine" align="center">
						<td align="center">
						<table class="Ntable" cellSpacing="1" cellPadding="0" width="100%" border="0">
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="15%">初中分类：</td>
								<td class="SkyTDLine">
									${initMap.gradeInfo.grGrade eq "11" ? '小学一年级':'' }
									${initMap.gradeInfo.grGrade eq "12" ? '小学二年级':'' }
									${initMap.gradeInfo.grGrade eq "13" ? '小学三年级':'' }
									${initMap.gradeInfo.grGrade eq "14" ? '小学四年级':'' }
									${initMap.gradeInfo.grGrade eq "15" ? '小学五年级':'' }
									${initMap.gradeInfo.grGrade eq "16" ? '小学六年级':'' }
									${initMap.gradeInfo.grGrade eq "21" ? '七年级':'' }
									${initMap.gradeInfo.grGrade eq "22" ? '八年级':'' }
									${initMap.gradeInfo.grGrade eq "31" ? '必修一':'' }
									${initMap.gradeInfo.grGrade eq "32" ? '必修二':'' }
									${initMap.gradeInfo.grGrade eq "33" ? '必修三':'' }
								</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="15%">资源类别：</td>
								<td class="SkyTDLine">
										${initMap.gradeInfo.grResourceType eq "exhibition" ? '文物博览室':'' }
										${initMap.gradeInfo.grResourceType eq "observation" ? '专题研读室':'' }
										${initMap.gradeInfo.grResourceType eq "laboratory" ? '教学研究室':'' }
										${initMap.gradeInfo.grResourceType eq "projection" ? '影像资料室':'' }
										${initMap.gradeInfo.grResourceType eq "expand" ? '自主探究室':'' }
								</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="15%">资源名称：</td>
								<td class="SkyTDLine">
									${initMap.gradeInfo.grName} &nbsp;
									<s:if test="initMap.gradeInfo.grResourceType == 'exhibition'">
										<a href="decorateForwardAction.action?code=${pmsIndex.res_exhibition_room_detail.code}&paramMap.erID=${initMap.gradeInfo.grResourceID}">详细</a>
									</s:if>
									<s:if test="initMap.gradeInfo.grResourceType == 'observation'">
										<a href="decorateForwardAction.action?code=${pmsIndex.res_observation_room_detail.code}&paramMap.orID=${initMap.gradeInfo.grResourceID}">详细</a>
									</s:if>
									<s:if test="initMap.gradeInfo.grResourceType == 'laboratory'">
										<a href="decorateForwardAction.action?code=${pmsIndex.res_laboratory_room_detail.code}&paramMap.lrID=${initMap.gradeInfo.grResourceID}">详细</a>
									</s:if>
									<s:if test="initMap.gradeInfo.grResourceType == 'projection'">
										<a href="decorateForwardAction.action?code=${pmsIndex.res_projection_room_detail.code}&paramMap.prID=${initMap.gradeInfo.grResourceID}">详细</a>
									</s:if>
									<s:if test="initMap.gradeInfo.grResourceType == 'expand'">
										<a href="decorateForwardAction.action?code=${pmsIndex.res_expand_room_detail.code}&paramMap.erID=${initMap.gradeInfo.grResourceID}">详细</a>
									</s:if>
								</td>
							</tr>
							<tr class="MeNewTDLine" align="center">
								<td colSpan="2" class="SkyTDLine">&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
