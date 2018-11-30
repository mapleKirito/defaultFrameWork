<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
            String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <title></title>
<head>
<script type="text/javascript">
$(document).ready(function(){	
 //input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示')},onsuccess:function(){}});//表单提交 
	$("#pointValid").formValidator({onshow:"该积分有效期为保单生成积分有效期，内容为N年。",onfocus:"请输入年数",oncorrect:"输入正确"}).regexValidator({regexp:'intege1',datatype:"enum",onerror:"积分有效期为正整数"});
	$("#rewardPointValid").formValidator({onshow:"该积分有效期为所有奖励积分有效期，内容为N天。",onfocus:"请输入天数",oncorrect:"输入正确"}).regexValidator({regexp:'intege1',datatype:"enum",onerror:"积分有效期为正整数"});
	$("#registerPoint").formValidator({onshow:"注册奖励积分不能为空。",onfocus:"请输入积分数量",oncorrect:"输入正确"}).regexValidator({regexp:'intege1',datatype:"enum",onerror:"注册奖励积分为正整数"});
	$("#modifyInformationPoint").formValidator({onshow:"个人信息维护奖励积分不能为空。",onfocus:"请输入积分数量",oncorrect:"输入正确"}).regexValidator({regexp:'intege1',datatype:"enum",onerror:"个人信息维护奖励积分为正整数"});
	$("#mobileBindingPoint").formValidator({onshow:"绑定手机奖励积分不能为空。",onfocus:"请输入积分数量",oncorrect:"输入正确"}).regexValidator({regexp:'intege1',datatype:"enum",onerror:"绑定手机奖励积分为正整数"});
	$("#friendRecommendPoint").formValidator({onshow:"好友推荐奖励积分不能为空。",onfocus:"请输入积分数量",oncorrect:"输入正确"}).regexValidator({regexp:'intege1',datatype:"enum",onerror:"好友推荐奖励积分为正整数"});
	$("#mailLogo").formValidator({onshow:"xx商城Logo不能为空",onfocus:"请输入xx商城Logo",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"xx商城Logo不能为空,请确认"});
	$("#mailShopURL").formValidator({onshow:"xx商城URL不能为空",onfocus:"请输入xx商城URL",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"xx商城URL不能为空,请确认"});
	$("#mailLoginURL").formValidator({onshow:"xx商城登录URL不能为空",onfocus:"请输入xx商城登录URL",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"xx商城登录URL不能为空,请确认"});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" >
<input type="hidden" name="code" id="code" value="${pmsIndex.config_global_param_create.code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.config_global_param.imitationStep}"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
<tr>
<td class="tableCcenter">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
        <tr>
            <td class="SkyTDLine">
                <table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="95%" border="0" align="center">
                    <tr class="MeNewTDLine" align="center">
                        <td align="center">
                            <table class="Ntable" id="paramTable" cellSpacing="1" cellPadding="0" width="100%" border="0">
        						<s:set name="pointValid" value="0"></s:set>		
								<s:set name="rewardPoint" value="0"></s:set>	
								<s:set name="modifyInformation" value="0"></s:set>
								<s:set name="mobileBindingPoint" value="0"></s:set>
								<s:set name="friendRecommendPoint" value="0"></s:set>
								<s:set name="mailLogo" value="0"></s:set>
                                <s:iterator value="initMap.paramInfo" id="par" status="ind">
									 <s:if test="#par.parName == 'pointValid'">
										<s:set name="pointValid" value="#par.parValue" ></s:set>	
									 </s:if>
									<s:if test="#par.parName == 'rewardPointValid'">
										<s:set name="rewardPointValid" value="#par.parValue" ></s:set>	
									 </s:if>	
									 <s:if test="#par.parName == 'registerPoint'">
										<s:set name="registerPoint" value="#par.parValue"></s:set>			
									 </s:if>
									 <s:if test="#par.parName == 'modifyInformationPoint'">
										<s:set name="modifyInformationPoint" value="#par.parValue"></s:set>			
									 </s:if>
									<s:if test="#par.parName == 'mobileBindingPoint'">
										<s:set name="mobileBindingPoint" value="#par.parValue"></s:set>			
									 </s:if>
									<s:if test="#par.parName == 'friendRecommendPoint'">
										<s:set name="friendRecommendPoint" value="#par.parValue"></s:set>			
									 </s:if>
									<s:if test="#par.parName == 'mailLogo'">
										<s:set name="mailLogo" value="#par.parValue"></s:set>			
									 </s:if>
									<s:if test="#par.parName == 'mailShopURL'">
										<s:set name="mailShopURL" value="#par.parValue"></s:set>			
									 </s:if>
									<s:if test="#par.parName == 'mailLoginURL'">
										<s:set name="mailLoginURL" value="#par.parValue"></s:set>			
									 </s:if>
                                </s:iterator>	
                                <tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parDesc" id="parDesc" value="积分有效期" style="width:70%;background:#ECE9D8;"></td>
									<td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parName" id="parName" value="pointValid" style="width:70%;background:#ECE9D8;"></td>
									<td align="left" class="SkyTDLine" width="60%">&nbsp;
										<input type="text" name="paramMap.parValue" id="pointValid" style="width:120" maxlength="2" value="${pointValid}"> 年&nbsp;&nbsp;
										&nbsp;<font color="red">*</font><span id="pointValidTip" style="position:absolute;height:22px;width:300px"></span>
									</td>
                                </tr>
								<tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parDesc" id="parDesc" value="奖励积分有效期" style="width:70%;background:#ECE9D8;"></td>
									<td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parName" id="parName" value="rewardPointValid" style="width:70%;background:#ECE9D8;"></td>
									<td align="left" class="SkyTDLine" width="60%">&nbsp;
										<input type="text" name="paramMap.parValue" id="rewardPointValid" style="width:120" maxlength="60" value="${rewardPointValid}"> 天&nbsp;&nbsp;
										&nbsp;<font color="red">*</font><span id="rewardPointValidTip" style="position:absolute;height:22px;width:300px"></span>
									</td>
                                </tr>
                                <tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parDesc" id="parDesc" value="注册奖励积分" style="width:70%;background:#ECE9D8;"></td>
									<td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parName" id="parName" value="registerPoint" style="width:70%;background:#ECE9D8;"></td>
									<td align="left" class="SkyTDLine" width="60%">&nbsp;
										<input type="text" name="paramMap.parValue" id="registerPoint" style="width:120" maxlength="10" value="${registerPoint}"> 积分
										&nbsp;<font color="red">*</font><span id="registerPointTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
                                </tr>
                                <tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parDesc" id="parDesc" value="个人信息维护奖励积分" style="width:70%;background:#ECE9D8;"></td>
									<td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parName" id="parName" value="modifyInformationPoint" style="width:70%;background:#ECE9D8;"></td>
									<td align="left" class="SkyTDLine" width="60%">&nbsp;
										<input type="text" name="paramMap.parValue" id="modifyInformationPoint" style="width:120" maxlength="10" value="${modifyInformationPoint}"> 积分
										&nbsp;<font color="red">*</font><span id="modifyInformationPointTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
                                </tr>
								<tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parDesc" id="parDesc" value="绑定手机奖励积分" style="width:70%;background:#ECE9D8;"></td>
									<td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parName" id="parName" value="mobileBindingPoint" style="width:70%;background:#ECE9D8;"></td>
									<td align="left" class="SkyTDLine" width="60%">&nbsp;
										<input type="text" name="paramMap.parValue" id="mobileBindingPoint" style="width:120" maxlength="10" value="${mobileBindingPoint}"> 积分
										&nbsp;<font color="red">*</font><span id="mobileBindingPointTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
                                </tr>
								<tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parDesc" id="parDesc" value="好友推荐奖励积分" style="width:70%;background:#ECE9D8;"></td>
									<td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parName" id="parName" value="friendRecommendPoint" style="width:70%;background:#ECE9D8;"></td>
									<td align="left" class="SkyTDLine" width="60%">&nbsp;
										<input type="text" name="paramMap.parValue" id="friendRecommendPoint" style="width:120" maxlength="10" value="${friendRecommendPoint}"> 积分
										&nbsp;<font color="red">*</font><span id="friendRecommendPointTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
                                </tr>
								<tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parDesc" id="parDesc" value="xx商城LOGO" style="width:70%;background:#ECE9D8;"></td>
									<td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parName" id="parName" value="mailLogo" style="width:70%;background:#ECE9D8;"></td>
									<td align="left" class="SkyTDLine" width="60%">&nbsp;
										<input type="text" name="paramMap.parValue" id="mailLogo" style="width:120" maxlength="100" value="${mailLogo}"> 
										&nbsp;<font color="red">*</font>
										<span id="mailLogoTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
                                </tr>
								<tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parDesc" id="parDesc" value="xx商城会员登录URL" style="width:70%;background:#ECE9D8;"></td>
									<td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parName" id="parName" value="mailLoginURL" style="width:70%;background:#ECE9D8;"></td>
									<td align="left" class="SkyTDLine" width="60%">&nbsp;
										<input type="text" name="paramMap.parValue" id="mailLoginURL" style="width:120" maxlength="100" value="${mailLoginURL}"> 
										&nbsp;<font color="red">*</font>
										<span id="mailLoginURLTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
                                </tr>
								<tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parDesc" id="parDesc" value="xx商城URL" style="width:70%;background:#ECE9D8;"></td>
									<td align="center" class="SkyTDLine" width="20%"><input type="text" readonly="readonly" name="paramMap.parName" id="parName" value="mailShopURL" style="width:70%;background:#ECE9D8;"></td>
									<td align="left" class="SkyTDLine" width="60%">&nbsp;
										<input type="text" name="paramMap.parValue" id="mailShopURL" style="width:120" maxlength="100" value="${mailShopURL}"> 
										&nbsp;<font color="red">*</font>
										<span id="mailShopURLTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
                                </tr>
                              </table> 
                          </td>
                      </tr>
					<tr class="MeNewTDLine" align="center">
						<td colSpan="2" class="SkyTDLine" height="20">
					      <input type="submit" name="BtnOk" value="保存" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />
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
