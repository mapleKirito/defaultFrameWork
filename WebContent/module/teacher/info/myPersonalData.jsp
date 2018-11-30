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
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	var $div_li =$(".teacherTab li");
	$div_li.click(function(){
		$(this).addClass("curr")            //当前<li>元素高亮
			   .siblings().removeClass("curr");  //去掉其它同辈<li>元素的高亮
		var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
		$(".table_9")   	//选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
				.eq(index).show()   //显示 <li>元素对应的<div>元素
				.siblings().hide(); //隐藏其它几个同辈的<div>元素
	});
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#loginID").formValidator({onshow:"请输入登陆账号",onfocus:"登陆账号不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"输入正确"});
	
	$("#name").formValidator({onshow:"请输入你的姓名",onfocus:"姓名不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"输入正确"});
	$("#userNo").formValidator({onshow:"请输入教师证号",onfocus:"教师证号不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"教师证号不能为空"});
	$("#userAnswer").formValidator({onshow:"请填写密码提示问题答案",onfocus:"密码提示问题答案必填",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"密码提示问题答案不能为空"});
	$("#answerType").formValidator({onshow:"请选择密码提示问题",onfocus:"密码提示问题必选",oncorrect:"输入正确"});
	
});
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.userID" value="${initMap.userInfo.userID}"> 
<input type="hidden" name="imitateStep" value="my_info_mgr_modify_2"> 
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9" >
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">姓名：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.name" value="${initMap.userInfo.userName}" type="text" maxlength="180" id="name"  style="width: 200px;" />&nbsp;
									<font color="red">*</font><span id="nameTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">性别：</td>
									<td width="85%" class="tatd" align="left">
	                                 <s:if test="initMap.userInfo.userGender == 1">
										<input type="radio" name="paramMap.gender" checked="checked" value="1" />男 &nbsp;
										<input type="radio" value="0" name="paramMap.gender" />女&nbsp;
	                                 </s:if> 
									 <s:if test="initMap.userInfo.userGender == 0">
										<input type="radio" name="paramMap.gender" value="1" />男 &nbsp;
										<input type="radio" value="0" name="paramMap.gender"  checked="checked" />女&nbsp;
									 </s:if>										
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">教师号：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.userNo" value="${initMap.userInfo.userNo}" type="text" maxlength="180" id="userNo"  style="width: 200px;" />&nbsp;
									<font color="red">*</font><span id="userNoTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">邮箱：</td>
									<td width="85%" class="tatd">
									<input name="paramMap.email" id="email" value="${initMap.userInfo.userEmail}" type="text" maxlength="200" style="width: 200px;" />&nbsp;
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">电话：</td>
									<td width="85%" class="tatd">
									<input name="paramMap.mobilePhone" value="${initMap.userInfo.userMobilePhone}" type="text" maxlength="200" id="mobilePhone" style="width: 200px;" />&nbsp;
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">密码提示问题：</td>
									<td width="85%" class="tatd" align="left">
									<select style="width:200;" name="paramMap.userDicType" id="answerType">
									   <option value="">请选择密码提示问题</option>
									   <option value="1"  ${initMap.userInfo.userDicType == 1 ? 'selected':'' }>我爸爸的姓名</option>
									   <option value="2"  ${initMap.userInfo.userDicType == 2 ? 'selected':'' }>我妈妈的姓名</option>
									   <option value="3"  ${initMap.userInfo.userDicType == 3 ? 'selected':'' }>我最喜爱的一本书</option>
									   <option value="4"  ${initMap.userInfo.userDicType == 4 ? 'selected':'' }>我最喜欢的运动</option>
									   <option value="5"  ${initMap.userInfo.userDicType == 5 ? 'selected':'' }>我最喜欢的歌曲</option>
									   <option value="6"  ${initMap.userInfo.userDicType == 6 ? 'selected':'' }>我最喜欢的电影</option>
									   <option value="7"  ${initMap.userInfo.userDicType == 7 ? 'selected':'' }>我最喜欢的颜色</option>
									   <option value="8"  ${initMap.userInfo.userDicType == 8 ? 'selected':'' }>我的好朋友是谁</option>
									</select>&nbsp;<font color="red">*</font><span id="answerTypeTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">密码提示答案：</td>
									<td width="85%" class="tatd" align="left">                                              
									<input id="userAnswer" name="paramMap.userAnswer" type="text"  value="${initMap.userInfo.userAnswer}" style="width: 200px;" />&nbsp;
									<font color="red">*</font><span id="userAnswerTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">描述：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.description" type="text" id="description" value="${initMap.userInfo.userDesc}" style="width: 200px;" />&nbsp;
									</td>
								  </tr>									  
								  <tr bgcolor="#ae9b84">
									<td colspan="4" style="text-align: center;">
										<input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
										<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
									</td>
								  </tr>
								</table>
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