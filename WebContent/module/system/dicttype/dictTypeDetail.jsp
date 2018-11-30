<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
        String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" onsubmit="return Validator.Validate(this,3);">
<input type="hidden" value="name" name="logColumn" /> <input type="hidden" value="true" name="islog" />
<input type="hidden" name="code" value="${code}">
<input type="hidden" name="paramMap.key" value="${paramMap.key}">
<input type="hidden" name="imitateStep" value="1"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
    <tr>
        <td class="tableCcenter">
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
                <tr>
                    <td class="SkyTDLine">
                        <table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
                            <tr class="MeNewTDLine" align="center">
                                <td align="left">
                                    <table class="Ntable" cellSpacing="1" cellPadding="0"
                                           width="100%" border="0">
                                        <tr class="MeNewTDLine">
                                            <td align="right" class="SkyTDLine" width="10%">类别别名：&nbsp;</td>
                                            <td class="SkyTDLine">&nbsp;
				                               <input name="paramMap.value" type="text" maxlength="180" id="value" value="${initMap.dictionaryInfo[0].value}" readonly/>
												&nbsp;<font color="red">*</font>
                                         </td>
                                     </tr>
                                     <tr class="MeNewTDLine">
                                         <td align="right" class="SkyTDLine" width="10%">类别名称：&nbsp;</td>
                                         <td class="SkyTDLine">&nbsp;
                                             <input name="paramMap.alias" type="text" maxlength="180" id="alias" value="${initMap.dictionaryInfo[0].alias}" readonly/>&nbsp;<font color="red">*</font>
                                         </td>
                                     </tr>
                                     <tr class="MeNewTDLine">
                                         <td align="right" class="SkyTDLine">类别描述：&nbsp;</td>
                                         <td class="SkyTDLine">&nbsp;
                                             <input name="paramMap.description"  value="${initMap.dictionaryInfo[0].description}" readonly/>
                                         </td>
                                     </tr>
                                     <tr class="MeNewTDLine" align="center">
                                         <td colSpan="2" class="SkyTDLine">
                                             <input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
                                            </td>
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