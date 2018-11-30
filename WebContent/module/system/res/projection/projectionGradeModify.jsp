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
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
<script type="text/javascript">
var gridTreeTB,treeTB;
$(document).ready(function(){	
 //input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示')},onsuccess:function(){}});//表单提交
	/* $("#grGrade").formValidator({onshow:"请选择初中分类",onfocus:"请选择初中分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"初中分类不能为空,请确认"}); */
	
});
</script>
</head>
<body>
<div id="layout_mainbody" >
<form name="actionForm" method="post" id="actionForm" action="operateAction.action">
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 160px;"></ul>
</div>
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.res_projection_room_mgr.imitationStep}">
<input name="paramMap.grID" type="hidden" id="grID" value="${initMap.gradeInfo.grID}"/>
<input type="hidden" name="paramMap.grResourceID" id="grResourceID" value="${initMap.projectionInfo.prID}">
<input type="hidden" name="paramMap.grThumbnail" id="grThumbnail" value="${initMap.projectionInfo.prThumbnail}">
<input type="hidden" name="paramMap.grResourceType" id="grResourceType" value="projection">
<input type="hidden" name="paramMap.grUpload" id="grUpload" value="${initMap.projectionInfo.porUpload}">
<input type="hidden" name="paramMap.grType" id="grType" value="${initMap.projectionInfo.prType }">
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
								<select name="paramMap.grGrade" id="grGrade">
									<option value="">--请选择初中分类--</option>
									<!-- <option value="11" ${initMap.gradeInfo.grGrade eq "11" ? 'selected':'' }>小学一年级</option>
									<option value="12" ${initMap.gradeInfo.grGrade eq "12" ? 'selected':'' }>小学二年级</option>
									<option value="13" ${initMap.gradeInfo.grGrade eq "13" ? 'selected':'' }>小学三年级</option>
									<option value="14" ${initMap.gradeInfo.grGrade eq "14" ? 'selected':'' }>小学四年级</option>
									<option value="15" ${initMap.gradeInfo.grGrade eq "15" ? 'selected':'' }>小学五年级</option>
									<option value="16" ${initMap.gradeInfo.grGrade eq "16" ? 'selected':'' }>小学六年级</option> -->
									<option value="21" ${initMap.gradeInfo.grGrade eq "21" ? 'selected':'' }>七年级</option>
									<option value="22" ${initMap.gradeInfo.grGrade eq "22" ? 'selected':'' }>八年级</option>
									<option value="31" ${initMap.gradeInfo.grGrade eq "31" ? 'selected':'' }>必修一</option>
									<option value="32" ${initMap.gradeInfo.grGrade eq "32" ? 'selected':'' }>必修二</option>
									<option value="33" ${initMap.gradeInfo.grGrade eq "33" ? 'selected':'' }>必修三</option>
								</select>
								&nbsp;
								<font color="red">*</font><span id="grGradeTip" style="position:absolute;height:22px;width:297px"></span></td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="15%">资源类别：</td>
								<td class="SkyTDLine">
									<select disabled="disabled">
										<option value="exhibition">文物博览室</option>
										<option value="observation" >专题研读室</option>
										<option value="laboratory" >教学研究室</option>
										<option value="projection" selected>影像资料室</option>
										<option value="expand" >自主探究室</option>
									</select>
								&nbsp;
								<span id="grResourceTypeTip" style="position:absolute;height:22px;width:297px"></span></td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="15%">资源名称：</td>
								<td class="SkyTDLine">
								<input name="paramMap.grName" type="text" maxlength="16" id="grName" style="width: 200px;" value="${initMap.projectionInfo.prName}" readonly="readonly" />
								&nbsp;
								<span id="grNameTip" style="position:absolute;height:22px;width:297px"></span>
								</td>
							</tr>
							<tr class="MeNewTDLine" align="center">
								<td colSpan="2" class="SkyTDLine"><input type="submit" name="BtnOk" value="创建" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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
</div>
<script src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>
</body>
</html>
