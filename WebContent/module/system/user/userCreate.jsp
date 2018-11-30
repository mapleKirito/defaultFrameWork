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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.autocomplete.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rsync_progress_bar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/res/category.js"></script>
<script type="text/javascript">
var setting = {
	async: {
		enable: true,
		url:"ajaxAction.action?code=-600",
		dataType:"json",
		autoParam:["id"],
		dataFilter: filter
	},
	callback: {
		beforeAsync: beforeAsync,
		//beforeClick: beforeClick,
		onClick: onClick
	}
};

function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	if (childNodes.data){
		childNodes = childNodes.data;
	}
	return childNodes;
}
function beforeAsync(treeId, treeNode) {
	return treeNode ? treeNode.level < 5 : true;
}

function onClick(e, treeId, treeNode) {
	var id = treeNode.id;
	var name = treeNode.name;
	$("#userOrgID").attr("value", id);
	$("#userOrgName").attr("value", name);
	hideMenu();
}

function showMenu() {
	var cityObj = $("#userOrgName");
	var cityOffset = $("#userOrgName").offset();
	$("#menuContent").css({
		left : cityOffset.left + "px",
		top : cityOffset.top + cityObj.outerHeight() + "px"
	}).slideDown("fast");

	$("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
	$("#menuContent").hide();
	$("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
	if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(
			event.target).parents("#menuContent").length > 0)) {
		hideMenu();
	}
}
$(document).ready(function(){
	
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示");}}); 
	//$("#userOrgName").formValidator({onshow:"请选择机构",onfocus:"请选择机构",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"机构不能为空,请确认"});
	$("#name").formValidator({onshow:"请输入用户名",onfocus:"请输入您的用户名",oncorrect:"输入正确"}).inputValidator({min:4,max:15,onerror:"用户名的长度不正确"});
	//需要什么正则表达式可以在formValidatorRegex.js里面自己写
	$("#loginID").formValidator({onshow:"请输入账号",onfocus:"账号至少4个字符,最多15个字符",oncorrect:"该账号可用"}).inputValidator({min:4,max:15,onerror:"账号的长度不正确"}).regexValidator({regexp:"username",datatype:"enum",onerror:"用户名格式不正确"}).ajaxValidator({
		
		type : "get",
		url : "ajaxAction.action",
		datatype : "json",
		data: "code=${pmsIndex.sys_check_account.code}",
		success : function(jsonData){
			if( jsonData.singleData == "0" )
			{
                return true;
			}
            else
			{
                return false;
			}
		},
		buttons: $("#button"),
		error: function(){alert("服务器没有返回数据，可能服务器忙，请重试");},
		onerror : "该账号已存在，请更换用户账号",
		onwait : "正在对账号进行合法性校验，请稍候..."
	});
	$("#password").formValidator({onshow:"请输入密码",onfocus:"密码由6-15位的字母或数字组成",oncorrect:"密码合法"}).inputValidator({min:6,max:15,empty:{leftempty:false,rightempty:false,emptyerror:"密码两边不能有空符号"},onerror:"密码的长度不正确"}).regexValidator({regexp:"password",datatype:"enum",onerror:"密码格式不正确"});
	$("#confirmPwd").formValidator({onshow:"请输入重复密码",onfocus:"两次密码必须一致",oncorrect:"密码一致"}).inputValidator({min:6,max:15,empty:{leftempty:false,rightempty:false,emptyerror:"重复密码两边不能有空符号"},onerror:"重复密码的长度不正确"}).compareValidator({desid:"password",operateor:"=",onerror:"两次密码不一致,请确认"});
	//$("#email").formValidator({onshow:"请输入邮箱地址",onfocus:"邮箱地址不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"邮箱地址不能为空"}).regexValidator({regexp:"email",datatype:"enum",onerror:"你输入的邮箱不符合规范"});
	$("#userAnswer").formValidator({onshow:"请填写密码提示问题答案",onfocus:"密码提示问题答案必填",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"密码提示问题答案不能为空"});
	//$("#mobilePhone").formValidator({onshow:"请输入移动电话",onfocus:"移动电话不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"移动电话不能为空"}).regexValidator({regexp:"mobile",datatype:"enum",onerror:"你输入的移动电话不符合规范"});
	//$("#officePhone").formValidator({onshow:"请输入办公电话",onfocus:"办公电话不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"办公电话不能为空"}).regexValidator({regexp:"tel",datatype:"enum",onerror:"你输入的办公电话不符合规范, 如 010-25478563"});
	$("#userDicType").formValidator({onshow:"请选择密码提示问题",onfocus:"密码提示问题不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"请选择密码提示问题,请确认"});
	$("#userAnswer").formValidator({onshow:"请输入密码提示答案",onfocus:"密码提示答案不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"请输入密码提示答案,请确认"});


	$("#password").passStrength({ 
		shortPass: "top_shortPass", 
		badPass: "top_badPass", 
		goodPass: "top_goodPass", 
		strongPass: "top_strongPass", 
		userid: "#loginID"
	}); 
	$.fn.zTree.init($("#treeDemo"), setting);
	
	$(".type").click(function(){
		var vch = $(this).attr("checked");
		var v = $(this).val();
		if (v == 1){
			$("#student").hide();
			$("#teacher").show();	
			$("#tidno").show();
			$("#user_img").val("images/default/default_teacher.jpg");
			$("#idNo").formValidator({onshow:"请输入教师证号",onfocus:"教师证号不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"教师证号不能为空"});
			//$("#email").formValidator({onshow:"请输入邮箱地址",onfocus:"邮箱地址不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"邮箱地址不能为空"}).regexValidator({regexp:"email",datatype:"enum",onerror:"你输入的邮箱不符合规范"});
			$("#userOrgID").formValidator({onshow:"请选择管理班级",onfocus:"请选择管理班级",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"请选择管理班级"});
			$("#userAnswer").formValidator({onshow:"请填写密码提示问题答案",onfocus:"密码提示问题答案必填",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"密码提示问题答案不能为空"});
		}
		else{
			$("#student").show();
			$("#teacher").hide();
			$("#tidno").hide();
			$("#user_img").val("images/default/default_student.jpg");
			$("#idNo").formValidator({});
			//$("#email").formValidator({onshow:"请输入邮箱地址",onfocus:"邮箱地址不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"邮箱地址不能为空"}).regexValidator({regexp:"email",datatype:"enum",onerror:"你输入的邮箱不符合规范"});
			$("#userOrgID").formValidator({});
		}
	});
});
</script>
</head>
<body >
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 160px;height: 280;overflow: auto;"></ul>
</div>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" id="user_img" value="images/default/default_student.jpg" name="paramMap.userImg" /> 
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input name="paramMap.userOrgID" type="hidden" id="userOrgID" style="width: 200px;" />
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_user_mgr.imitationStep}"> 
<!-- <input name="paramMap.type" type="hidden" class="type" value="1" id="type"/> -->
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#e8e8e8" valign="top">
							<div>
								<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
									<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0" style="background-color: #F5F9FC;">
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">用户类型：</td>
											<td class="tatd">
											<input name="paramMap.type" type="radio" class="type" value="2" checked="checked" id="type"/>学生
											<input name="paramMap.type" type="radio" class="type" value="1" id="type"/>教师
											</td>
										</tr>									
										<%-- <tr bgcolor="#ae9b84" id="teacher" style="display:none;">
											<td align="right" class="tatd" width="15%">管理班级：</td>
											<td  class="tatd"> 
											   <iframe src="forwardAction.action?code=${pmsIndex.sys_org_tree.code}&tempCode=${code}" frameborder="0" scrolling="auto" width="200" height="100"></iframe>
											   <font color="red" style="vertical-align: top;">*</font><span id="userOrgIDTip" style="position:absolute;height:22px;width:250px"></span>						
											</td>
										</tr>
										<tr bgcolor="#ae9b84" id="student">
											<td align="right" class="tatd" width="15%">归属班级：</td>
											<td  class="tatd"> 
											  <input name="paramMap.userOrgName" type="text" maxlength="180" readonly id="userOrgName" style="width: 200px;" /> 
											  <a id="menuBtn" href="javascript:void(0)" onclick="showMenu(); return false;">选择</a>						
											</td>
										</tr> --%>							
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">用户名：</td>
											<td class="tatd"><input name="paramMap.name" type="text" maxlength="180" id="name" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="nameTip" style="position:absolute;height:22px;width:250px"></span></td>
										</tr>
										<tr bgcolor="#ae9b84" id="tidno" style="display:none;">
											<td align="right" class="tatd" width="15%">教师证号：</td>
											<td class="tatd"><input name="paramMap.idNo" type="text" maxlength="180" id="idNo" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="idNoTip" style="position:absolute;height:22px;width:250px"></span></td>
										</tr>							
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">帐号：</td>
											<td class="tatd"><input name="paramMap.loginID" type="text" maxlength="180" id="loginID" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="loginIDTip" style="position:absolute;height:22px;width:250px"></span></td>
										</tr>
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">密码：</td>
											<td class="tatd">
			                                  <input name="paramMap.password" type="password" maxlength="15" id="password" style="width: 200px;"/>&nbsp;<font color="red">*</font><span id="passwordTip" style="position:absolute;height:22px;width:250px"></span>
			                                  <br><span id="password_style" class='testresult'><span class="defaultPass">密码强度</span></span>
			                                </td>
										</tr>
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">确认密码：</td>
											<td class="tatd"><input name="paramMap.confirmPwd" type="password" maxlength="15" id="confirmPwd" style="width: 200px;"/>&nbsp;<font color="red">*</font><span id="confirmPwdTip" style="position:absolute;height:22px;width:250px"></span></td>
										</tr>
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">性别：</td>
											<td class="tatd">&nbsp;<input type="radio" name="paramMap.gender" checked="checked" value="1" />男 &nbsp;<input type="radio" value="0" name="paramMap.gender" />女&nbsp;</td>
										</tr>
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">电话：</td>
											<td class="tatd"><input name="paramMap.mobilePhone" type="text" maxlength="15" id="mobilePhone" style="width: 200px;" /></td>
										</tr>
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">邮箱：</td>
											<td class="tatd"><input name="paramMap.email" type="text" maxlength="200" id="email" style="width: 200px;" />&nbsp;</td>
										</tr>
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">密码提示问题：</td>
											<td class="tatd">
												<select style="width:200;" name="paramMap.userDicType" id="userDicType">
												   <option value="" >请选择密码提示问题</option>	
												   <option value="1" >我爸爸的姓名</option>
												   <option value="2" >我妈妈的姓名</option>
												   <option value="3" >我最喜爱的一本书</option>
												   <option value="4" >我最喜欢的运动</option>
												   <option value="5" >我最喜欢的歌曲</option>
												   <option value="6" >我最喜欢的电影</option>
												   <option value="7" >我最喜欢的颜色</option>
												   <option value="8" >我的好朋友是谁</option>
												</select>&nbsp;
												<font color="red">*</font><span id="userDicTypeTip" style="position:absolute;height:22px;width:250px"></span>
											</td>
										</tr>
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="15%">密码提示问题答案：</td>
											<td class="tatd">
												<input name="paramMap.userAnswer" type="text" id="userAnswer" style="width: 200px;" />&nbsp;
													<font color="red">*</font><span id="userAnswerTip" style="position:absolute;height:22px;width:250px"></span>		
											</td>
										</tr>							
										<tr bgcolor="#ae9b84" align="center">
										<td colSpan="2" class="tatd">
												<input type="submit" name="BtnOk" value="创建" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
												<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
										</td>
										</tr>
									</table>
                         		</form>
							</div>						
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
