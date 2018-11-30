<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<html>
<title></title>
<head>

<meta http-equiv=“X-UA-Compatible” content=“IE=8″>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/validator.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/password_style.css"/>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<link href="<%=request.getContextPath()%>/qc/css/style.css" rel="stylesheet" />
<script language="javascript" src="<%=request.getContextPath()%>/js/formValidator.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/formValidatorRegex.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/password_strength_plugin.js"></script>
<!–[if lt IE 9]>
<script src=”http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js”></script>
<![endif]–>
<script type="text/javascript">

$(document).ready(function(){
	if(IEversion()<= 8){
		
		$(".page-login a.pl-logo ").css("top","10%");
		$(".userinfo").css({
			"padding-left":"50px",
			"width":"305px",
			"line-height":"60px",
			"text-indent":"0px"
		});
		$("#userDicType").css({
			"height":"40px",
		    "line-height":"40px",
		    "padding":"8px 0"
		});
		}else if(IEversion()== 9 ){
		$(".page-login a.pl-logo ").css("top","40%");
		
	}
	if(IEversion()<= 8){
			$(".page-login").css({
			"background-size":"100% 100%",
			"background-repeat":"repeat",
			"background-position-y":"top"
		});
	}else if(IEversion()== 9 ){

		$(".page-login").css({
			"background-size":"100% 100%",
			"background-repeat":"repeat",
			"background-position-y":"top"
			
		});
	}
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 	
	//$("#userOrgName").formValidator({onshow:"请选择所在班级",onfocus:"请选择所在班级",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"所在班级不能为空,请确认"});
	$("#name").formValidator({onshow:"请输入用户名",onfocus:"请输入您的用户名",oncorrect:"输入正确"}).inputValidator({min:1,max:15,onerror:"用户名的长度不正确"});	
	$("#loginID").formValidator({onshow:"请输入账号",onfocus:"账号至少4个字符,最多15个字符",oncorrect:"该账号可用"}).inputValidator({min:4,max:15,onerror:"账号的长度不正确"}).regexValidator({regexp:"username",datatype:"enum",onerror:"账号格式不正确"}).ajaxValidator({
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
		onerror : "该用户账号已存在，请更换用户账号",
		onwait : "正在对用户名进行合法性校验，请稍候..."
	});
	
	$("#password").formValidator({onshow:"请输入密码",onfocus:"密码由6-15位的字母或数字组成",oncorrect:"密码合法"}).inputValidator({min:6,max:15,empty:{leftempty:false,rightempty:false,emptyerror:"密码两边不能有空符号"},onerror:"密码的长度不正确"}).regexValidator({regexp:"password",datatype:"enum",onerror:"密码格式不正确"});
	$("#confirmPwd").formValidator({onshow:"请输入重复密码",onfocus:"两次密码必须一致",oncorrect:"密码一致"}).inputValidator({min:6,max:15,empty:{leftempty:false,rightempty:false,emptyerror:"重复密码两边不能有空符号"},onerror:"重复密码的长度不正确"}).compareValidator({desid:"password",operateor:"=",onerror:"两次密码不一致,请确认"});
	$("#userDicType").formValidator({onshow:"请选择密码提示问题",onfocus:"密码提示问题不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"请选择密码提示问题,请确认"});
	$("#userAnswer").formValidator({onshow:"请输入密码提示答案",onfocus:"密码提示答案不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"请输入密码提示答案,请确认"});

	$("#password").passStrength({ 
		shortPass: "top_shortPass", 
		badPass: "top_badPass", 
		goodPass: "top_goodPass", 
		strongPass: "top_strongPass", 
		userid: "#loginID"
	}); 
	/* $.fn.zTree.init($("#treeDemo"), setting); */
	
	/* $(".type").click(function(){
		var vch = $(this).attr("checked");
		var v = $(this).val();
		if (v == 1){
			$("#student").hide();
			$("#teacher").show();	
			$("#tidno").show();
			$("#idNo").formValidator({onshow:"请输入教师证号",onfocus:"教师证号不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"教师证号不能为空"});
		}
		else{
			$("#student").show();
			$("#teacher").hide();
			$("#tidno").hide();
			$("#idNo").formValidator({});
		}
	}); */
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
<body class="page-login">
<div id="layout_mainbody" >
    <a class="pl-logo"><img src="images/his/biglogo.png" /></a>
    <div class="reg-form">
        <div class="reg-form-inner">
            <form name="actionForm" method="post" action="registerAction.action" id="actionForm">
            <input name="paramMap.userOrgID" type="hidden" id="userOrgID" style="width: 200px;" />
			<input type="hidden" name="code" value="${code}"> 
			<input type="hidden" value="2" name="paramMap.type" /> 
                <!-- <div class="reg-input">
                    <label for="field-class">归属班级</label>
                    <input name="paramMap.userOrgName" type="text" maxlength="180" readonly id="userOrgName" style="width: 200px;" /> 
						  <a id="menuBtn" href="javascript:void(0)" onclick="showMenu(); return false;">选择</a>
                </div> -->
                 <div class="reg-input">
                    <label for="field-name">用户名</label>
                    <input type="text" id="name" placeholder="用户名" name="paramMap.name"/>
                    <em>*</em><span id="nameTip" style="position:absolute;height:22px;width:250px"></span>
                </div> 
                <div class="reg-input">
                    <label for="field-account">账号</label>
                    <input type="text" id="loginID" placeholder="账号" name="paramMap.loginID"/>
                    <em>*</em><span id="loginIDTip" style="position:absolute;height:22px;width:250px"></span>
                </div>
                <div class="reg-input">
                    <label for="field-pass">密码</label>
                    <input type="password" id="password" placeholder="密码" name="paramMap.password" />
                    <em>*</em><span id="passwordTip" style="position:absolute;height:22px;width:250px"></span>
                </div>
                <div class="reg-input">
                    <label for="field-pass2">确认密码</label>
                    <input type="password" id="confirmPwd" placeholder="确认密码" name="paramMap.confirmPwd"/>
                    <em>*</em><span id="confirmPwdTip" style="position:absolute;height:22px;width:250px"></span>
                </div>
               <!--  <div class="reg-input">
                    <label for="field-sex">性别</label>
                    <input type="text" id="field-sex" placeholder="性别" />
                </div>
                <div class="reg-input">
                    <label for="field-phone">电话</label>
                    <input type="text" id="field-phone" placeholder="电话" />
                </div>
                <div class="reg-input">
                    <label for="field-email">邮箱</label>
                    <input type="text" id="field-email" placeholder="邮箱" />
                </div> -->
                <div class="reg-input">
                    <label for="field-pass-secrity">密码提示问题</label>
                    <select name="paramMap.userDicType" id="userDicType">
                       <option selected="selected">请输入密码提示问题</option>
                       <option value="1" >我爸爸的姓名</option>
					   <option value="2" >我妈妈的姓名</option>
					   <option value="3" >我最喜爱的一本书</option>
					   <option value="4" >我最喜欢的运动</option>
					   <option value="5" >我最喜欢的歌曲</option>
					   <option value="6" >我最喜欢的电影</option>
					   <option value="7" >我最喜欢的颜色</option>
					   <option value="8" >我的好朋友是谁</option>
                    </select>
                    <em>*</em><span id="userDicTypeTip" style="position:absolute;height:22px;width:250px"></span>
                </div>
                <div class="reg-input">
                    <label for="field-pass-secrity2">密码提示答案</label>
                    <input type="text" id="userAnswer" placeholder="答案" name="paramMap.userAnswer"/>
                    <em>*</em><span id="userAnswerTip" style="position:absolute;height:22px;width:250px"></span>
                </div>
                <!-- <div class="reg-input">
                    <label for="field-description">描述</label>
                    <input type="text" name="field-description" placeholder="描述" />
                </div> -->
                <div class="reg-input">
                    <label for="field-description">&nbsp;</label>
                    <input class="reg-button" type="submit" name="submit" value="注册" />
                    <span>已有账号，<a href="index.jsp" class="red">请登录</a></span>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>
</body>
</html>