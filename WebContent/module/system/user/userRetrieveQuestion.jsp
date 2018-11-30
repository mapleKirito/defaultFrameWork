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
<link href="<%=request.getContextPath()%>/css/his/hismain/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/validator.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>  
<link href="<%=request.getContextPath()%>/qc/css/style.css" rel="stylesheet" />
<script language="javascript" src="<%=request.getContextPath()%>/js/formValidator.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/formValidatorRegex.js" type="text/javascript"></script>
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
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#userAccount").formValidator({onshow:"请输入您的账号",onfocus:"用户名至少4个字符,最多15个字符",oncorrect:"输入正确"}).inputValidator({min:4,max:15,onerror:"用户账号的长度不正确"}).regexValidator({regexp:"username",datatype:"enum",onerror:"用户账号格式不正确"});
	$("#userDicType").formValidator({onshow:"请选择密码提示问题",onfocus:"密码提示问题为空",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"密码提示问题不能为空"});
	$("#userAnswer").formValidator({onshow:"请输入密码提示答案",onfocus:"密码提示答案不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"密码提示答案不能为空"});
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
<body class="page-login" style="overflow-y:auto">
<div id="layout_mainbody" >
    <a class="pl-logo"><img src="images/his/biglogo.png" /></a>
    <div class="reg-form">
        <div class="reg-form-inner">
            <form name="actionForm" method="post" action="retrieveQuestionAction.action" id="actionForm">
            	<input type="hidden" name="code" value="-1502"> 
                <div class="reg-input">
                    <label for="field-name">登录账号</label>
                    <input name="paramMap.userAccount" type="text" id="userAccount"  />
                    <em>*</em><span id="userAccountTip" style="position:absolute;height:22px;width:250px"></span>
                </div>
                <div class="reg-input">
                    <label for="field-class">密码提示问题</label>
                    <select style="width:200;" name="paramMap.userDicType" id="userDicType">
                       <option value="">请选择密码提示问题</option>	
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
                    <label for="field-account">密码提示答案</label>
                    <input name="paramMap.userAnswer" type="text" id="userAnswer" value="${initMap.userInfo.userAnswer}"  />
                    <em>*</em><span id="userAnswerTip" style="position:absolute;height:22px;width:250px"></span>
                </div>         
                <div class="reg-input">
                    <label for="field-description">&nbsp;</label>
                    <input class="reg-button" type="submit" name="submit" value="下一步" />
                </div>
            </form>
        </div>
    </div>
</div> 
</body>
</html>