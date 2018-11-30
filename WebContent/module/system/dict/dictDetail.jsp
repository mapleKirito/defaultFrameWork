
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
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
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
                                      <td align="right" class="SkyTDLine" width="10%">类型名称：</td>
                                      <td class="SkyTDLine">&nbsp;${initMap.dictionaryInfo[0].typeName}

                                     </td>
                                 </tr>
                                 <tr class="MeNewTDLine">
                                     <td align="right" class="SkyTDLine" width="10%">参数名：</td>
                                     <td class="SkyTDLine">&nbsp;${initMap.dictionaryInfo[0].alias}
                                     </td>
                                 </tr>
                                 <tr class="MeNewTDLine">
                                     <td align="right" class="SkyTDLine" width="10%">参数值：</td>
                                     <td class="SkyTDLine">&nbsp;${initMap.dictionaryInfo[0].value}
                                     </td>
                                 </tr>
                                 <tr class="MeNewTDLine">
                                     <td align="right" class="SkyTDLine">参数描述：</td>
                                     <td class="SkyTDLine">&nbsp;${initMap.dictionaryInfo[0].description}
                                     </td>
                                 </tr>
                                 <tr class="MeNewTDLine" align="center">
                                     <td colSpan="2" class="SkyTDLine">
                                         <input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'"  onclick="window.history.back();" />
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
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableF">
    <tr>
        <td class="tableFleft">&nbsp;</td>
        <td class="tableFcenter">&nbsp;</td>
        <td class="tableFright">&nbsp;</td>
    </tr>
</table>
</form>
</body>
</html>
