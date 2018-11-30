<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
</head>
<body >
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:10px;padding:10px 0 10px 10px\9;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td height="20">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_1">
					  <tr>
						<td colspan="3" height="10"></td>
					  </tr>
					  <tr>
						<td colspan="3" valign="top" style="border:2px solid #FFFFFF; background-color:#E5E5E5; padding:10px;">
                        	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_yj">
                              <tr>
                                <td height="6" width="6"><img src="<%=request.getContextPath()%>/images/table/table_1.jpg"></td>
                                <td width="100%" background="<%=request.getContextPath()%>/images/table/table_2.jpg"></td>
                                <td height="6" width="6"><img src="<%=request.getContextPath()%>/images/table/table_3.jpg"></td>
                              </tr>
                              <tr>
                                <td background="<%=request.getContextPath()%>/images/table/table_4.jpg" width="6"></td>
                                <td width="100%" bgcolor="#F7F7F7">
                                	<table width="100%" border="0" cellpadding="0" cellspacing="0">
                                      <tr>
                                        <td height="50">
                                        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td width="60%" height="50" class="bbottm"><span class="tit" style="color:#023156">&nbsp;${initMap.videoDetail.erName}</span></td>
                                        		<td width="40%" class="bbottm" align="right">资源编号：<span class="bh">&nbsp;${initMap.videoDetail.erCode}</span></td>
                                              </tr>
                                            </table>
                                        </td>
                                      </tr>
                                      <tr>
                                        <td style="padding-top:10px;">
                                        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_5">
                                              <tr>
                                                <td width="15%" rowspan="5" bgcolor="#FFFFFF"><img src="<%=request.getContextPath()%>/images/main/ima_32.jpg" width="165" height="130"></td>
                                                <td width="9%" height="30">适用学段、年级</td>
                                                <td width="33%" height="30">&nbsp;${initMap.fileDetail.erHabitat}</td>
                                                <td width="9%" height="30">资源类别</td>
                                                <td width="34%" height="30">&nbsp;${initMap.fileDetail.erType}</td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF">
                                                <td height="30" >分类选择</td>
                                                <td height="30">&nbsp;${initMap.fileDetail.erCategory}</td>
                                                <td height="30">鉴定人</td>
                                                <td height="30">&nbsp;${initMap.fileDetail.erIdentifier}</td>
                                              </tr>
                                              <tr>
                                                <td height="30">中文名</td>
                                                <td height="30" colspan="3">&nbsp;${initMap.fileDetail.erName}</td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF">
                                                <td height="30">四级分类</td>
                                                <td height="30" colspan="3">&nbsp;${initMap.fileDetail.erOrder}</td>
                                              </tr>
                                              <%-- <tr>
                                                <td height="30">中文科名</td>
                                                <td height="30" colspan="3">&nbsp;${initMap.fileDetail.erFamily}</td>
                                              </tr> --%>
                                              <%-- <tr bgcolor="#FFFFFF">
                                                <td rowspan="4" bgcolor="#FFFFFF">
                                                <a href="downloadAction.action?code=-705&paramMap.erID=${initMap.fileDetail.erID}" ><img src="<%=request.getContextPath()%>/images/main/ima_33.jpg" width="158" height="62" border="0"></a>
                                                </td>
                                                <td height="30">中文属名</td>
                                                <td height="30" colspan="3">&nbsp;${initMap.fileDetail.erGenus}</td>
                                              </tr> --%>
                                              <%-- <tr>
                                                <td height="30">拉丁学名</td>
                                                <td height="30" colspan="3">&nbsp;${initMap.fileDetail.erLatinName}</td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF">
                                                <td height="30">资源描述</td>
                                                <td height="30" colspan="3">&nbsp;${initMap.fileDetail.erDescription}</td>
                                              </tr> --%>
                                              <tr>
                                                <td height="30">备注</td>
                                                <td height="30" colspan="3">&nbsp;${initMap.fileDetail.erRemarks}</td>
                                              </tr>
                                            </table>
                                        </td>
                                      </tr>
                                    </table>
                                </td>
                                <td background="<%=request.getContextPath()%>/images/table/table_5.jpg" width="6"></td>
                              </tr>
                              <tr>
                                <td height="6" width="6"><img src="<%=request.getContextPath()%>/images/table/table_6.jpg"></td>
                                <td width="100%" background="<%=request.getContextPath()%>/images/table/table_7.jpg"></td>
                                <td height="6" width="6"><img src="<%=request.getContextPath()%>/images/table/table_8.jpg"></td>
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
</HTML>
