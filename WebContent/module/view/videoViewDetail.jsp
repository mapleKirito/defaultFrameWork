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
                                                <td width="71%" height="50" class="bbottm"><span class="tit" style="color:#023156">&nbsp;${initMap.videoDetail.erName}</span></td>
                                        		<td width="29%" class="bbottm" align="right">资源编号：<span class="bh">&nbsp;${initMap.videoDetail.erCode}</span></td>
                                              </tr>
                                            </table>
                                        </td>
                                      </tr>
                                      <tr>
                                        <td align="center" height="300">
                                        	<b style="font-size:36px;">
											<object id="player" height="500" width="500" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6">
											    <param NAME="AutoStart" VALUE="-1">
											    <!--是否自动播放-->
											    <param NAME="Balance" VALUE="0">
											    <!--调整左右声道平衡,同上面旧播放器代码-->
											    <param name="enabled" value="-1">
											    <!--播放器是否可人为控制-->
											    <param NAME="EnableContextMenu" VALUE="-1">
											    <!--是否启用上下文菜单-->
											    <param NAME="url" value="<%=request.getContextPath()%>/${initMap.videoDetail.erUpload}">
											    <!--播放的文件地址-->
											    <param NAME="PlayCount" VALUE="1">
											    <!--播放次数控制,为整数-->
											    <param name="rate" value="1">
											    <!--播放速率控制,1为正常,允许小数,1.0-2.0-->
											    <param name="currentPosition" value="0">
											    <!--控件设置:当前位置-->
											    <param name="currentMarker" value="0">
											    <!--控件设置:当前标记-->
											    <param name="defaultFrame" value="">
											    <!--显示默认框架-->
											    <param name="invokeURLs" value="0">
											    <!--脚本命令设置:是否调用URL-->
											    <param name="baseURL" value="">
											    <!--脚本命令设置:被调用的URL-->
											    <param name="stretchToFit" value="0">
											    <!--是否按比例伸展-->
											    <param name="volume" value="50">
											    <!--默认声音大小0%-100%,50则为50%-->
											    <param name="mute" value="0">
											    <!--是否静音-->
											    <param name="uiMode" value="mini">
											    <!--播放器显示模式:Full显示全部;mini最简化;None不显示播放控制,只显示视频窗口;invisible全部不显示-->
											    <param name="windowlessVideo" value="0">
											    <!--如果是0可以允许全屏,否则只能在窗口中查看-->
											    <param name="fullScreen" value="0">
											    <!--开始播放是否自动全屏-->
											    <param name="enableErrorDialogs" value="-1">
											    <!--是否启用错误提示报告-->
											    <param name="SAMIStyle" value>
											    <!--SAMI样式-->
											    <param name="SAMILang" value>
											    <!--SAMI语言-->
											    <param name="SAMIFilename" value>
											    <!--字幕ID-->
											</object>
											</b>
                                        </td>
                                      </tr>
                                      <tr>
                                        <td align="center" height="40">
                                        	<a href="downloadAction.action?code=-705&paramMap.erID=${initMap.videoDetail.erID}" ><img src="<%=request.getContextPath()%>/images/main/down.jpg" border="0"></a>
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
                            <div class="linee"></div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_yj">
                              <tr>
                                <td height="6" width="6"><img src="<%=request.getContextPath()%>/images/table/table_1.jpg"></td>
                                <td width="100%" background="<%=request.getContextPath()%>/images/table/table_2.jpg"></td>
                                <td height="6" width="6"><img src="<%=request.getContextPath()%>/images/table/table_3.jpg"></td>
                              </tr>
                              <tr>
                                <td background="<%=request.getContextPath()%>/images/table/table_4.jpg" width="6"></td>
                                <td width="100%" bgcolor="#F7F7F7" style="padding:10px;">
                                	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td width="10%" align="center" valign="top"><img src="<%=request.getContextPath()%>/images/main/pic_4.jpg"></td>
                                        <td width="90%">
                                        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_5">
                                              <tr bgcolor="#FFFFFF">
                                                <td width="8%" height="24">适用学段、年级</td>
                                                <td width="26%" height="24">&nbsp;${initMap.videoDetail.erHabitat}</td>
                                                <td width="7%" height="24">资源下载</td>
                                                <td width="26%" height="24"><img src="<%=request.getContextPath()%>/images/main/ima_27.jpg" width="20" height="11">下载</td>
                                                <td width="7%">资源类型</td>
                                                <td width="26%">&nbsp;${initMap.videoDetail.erType}</td>
                                              </tr>
                                              <tr bgcolor="#F0F0F0">
                                                <td height="25">中文名</td>
                                                <td height="25" colspan="3">&nbsp;${initMap.videoDetail.erName}</td>
                                                <td>保存地</td>
                                                <td>&nbsp;${initMap.videoDetail.erBiologicalReserve}</td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF">
                                                <td height="25">四级分类</td>
                                                <td height="25" colspan="5">&nbsp;${initMap.videoDetail.erOrder}</td>
                                              </tr>
                                              <%-- <tr bgcolor="#F0F0F0">
                                                <td height="25">中文科名</td>
                                                <td height="25" colspan="5">&nbsp;${initMap.videoDetail.erFamily}</td>
                                              </tr> --%>
                                              <%-- <tr bgcolor="#FFFFFF">
                                                <td height="25">中文属名</td>
                                                <td height="25" colspan="5">&nbsp;${initMap.videoDetail.erGenus}</td>
                                              </tr> --%>
                                              <%-- <tr bgcolor="#F0F0F0">
                                                <td height="25">拉丁学名</td>
                                                <td height="25" colspan="5">&nbsp;${initMap.videoDetail.erLatinName}</td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF">
                                                <td height="25">性状</td>
                                                <td height="25" colspan="5">&nbsp;${initMap.videoDetail.erCharacteristics}</td>
                                              </tr>
                                              <tr bgcolor="#F0F0F0">
                                                <td height="25">描述</td>
                                                <td height="25" colspan="5">&nbsp;${initMap.videoDetail.erDescription}</td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF">
                                                <td height="25">采集人</td>
                                                <td height="25">${initMap.videoDetail.erHunters}</td>
                                                <td height="25">&nbsp;采集号</td>
                                                <td height="25">&nbsp;${initMap.videoDetail.erSpecimensNo}</td>
                                                <td height="25">采集日期</td>
                                                <td height="25">&nbsp;${initMap.videoDetail.erSpecimensDate}</td>
                                              </tr> --%>
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
