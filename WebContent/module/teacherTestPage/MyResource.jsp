<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>

<html>
<%
	String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/pageToolbar2.js"></script>
<!--[if IE]> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main_help.css">
<![endif]-->
<script type="text/javascript">
$(document).ready(function(){	
	var $zy_li =$(".ziyuantab a.ltselect");
	$zy_li.click(function(){
		$(this).addClass("lt-private").siblings().removeClass("lt-private");
		var index =  $zy_li.index(this);  
		$("#change_type").val(index);
		$(".table_yj").eq(index).show().siblings().hide(); 
	});
	
	$('#table1page').pageTB();
	$('#table2page').pageTB();
	$('#table3page').pageTB();
	$('#table4page').pageTB();
	
});
</script>
</head>
<body >
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" id="uid" value="${paramMap.userID }" >
<input type="hidden" id="change_type" value="0">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_1" style="border: 1px solid #fff">
					  <tr>
						<td valign="top" bgcolor="#E6E6EA">
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_12 list-table" >
							  <tr>
								<td style="height:32px;border-bottom: 1px solid #fff;">
									<div class="ziyuantab lt-command">
										<a href="javascript:void(0)" id="${pmsIndex.res_exhibition_room_upload.code}" class="ltselect">
											<span>文物博览室</span>
										</a>
										<a href="javascript:void(0)" id="${pmsIndex.res_observation_room_upload.code}" class="ltselect">
											<span>专题研读室</span>
										</a>
										<a href="javascript:void(0)" id="${pmsIndex.res_laboratory_room_upload.code}" class="ltselect">
											<span>教学研究室</span>
										</a>
										<a href="javascript:void(0)" id="${pmsIndex.res_projection_room_upload.code}" class="ltselect">
											<span>影像资料室</span>
										</a>
										<a href="javascript:void(0)" id="${pmsIndex.res_lovely_room_upload.code}" class="ltselect">
											<span>情系家园</span>
										</a>
									</div>
								</td>
							  </tr>
							</table>
                            <div>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_yj">
                                  <tr>
                                    <td class="tabler3td">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#ae9b84">
	                                         <s:iterator value="initMap.exhibit" id="exhibit" status="exindx">	
		                                          <tr>
			                                            <td width="7%" height="35" align="center" valign="bottom">
				                                            <s:if test="#exhibit.erThumbnail == null">
				                                            	<img src="images/file/xwj_1.gif" width="30" height="25">
				                                            </s:if>
				                                            <s:if test="#exhibit.erThumbnail != null">
				                                            	<img src="${exhibit.erThumbnail}" width="30" height="25">
				                                            </s:if>
				                                        </td>
			                                   			<s:set name="pcode" value="'003023001007'" />
			                                   			<s:set name="pname" value="'erID'" />
			                                   			<s:if test="#exhibit.erType == '1011'">
			                                   				<s:set name="pcode" value="'003023001007'" />
			                                   			</s:if>
			                                            <td width="43%"><span>
			                                            <a onclick="window.parent.parent.parent.showView_redirect(this)"
			                                            	code="${pcode}" 
			                                            	href="javascript:void(0)"
			                                            	param="&path=${exhibit.path}&paramMap.roomtype=exhibition&paramMap.${pname}=${exhibit.erID}&paramMap.st=1&paramMap.name=${exhibit.erName}"
			                                            	>${exhibit.erName}</a></span></td>
			                                            <td width="15%"><span>${exhibit.erJie}</span></td>
			                                            <td width="18%"><span>${exhibit.erCreateTime}</span></td>
			                                            <td width="17%">
			                                            	<s:if test="pmsIndex.res_exhibition_room_upload_modify&&paramMap.userID==#session.s_userID">
			                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_exhibition_room_upload_modify.code}&path=${exhibit.path}&paramMap.roomtype=exhibition&paramMap.${pname}=${exhibit.erID}&paramMap.st=1">修改</a></span>
			                                            	</s:if>
			                                            	<s:if test="pmsIndex.res_exhibition_room_upload_delete&&paramMap.userID==#session.s_userID">
			                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_exhibition_room_upload_delete.code}&paramMap.roomtype=exhibition&paramMap.${pname}=${exhibit.erID}">删除</a></span>
			                                            	</s:if>
			                                            </td>
		                                          </tr>
	                                          </s:iterator>
	                                           <tr style="height: 45px;">
												<td colspan="5">
													<div class="pageb" id="table1page">
														${initMap.exhibitPaginated.pageContent}
													</div>
												</td>
											  </tr>
                                        </table>
                                    </td>
                                  </tr>
                                </table>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_yj hide">
                                  <tr>
                                    <td class="tabler3td">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#ae9b84">
	                                         <s:iterator value="initMap.observation" id="observation" status="obindx">	
		                                          <tr>
			                                            <td width="7%" height="35" align="center" valign="bottom">
				                                            <s:if test="#observation.orThumbnail == null">
				                                            	<img src="images/file/xwj_1.gif" width="30" height="25">
				                                            </s:if>
				                                            <s:if test="#observation.orThumbnail != null">
				                                            	<img src="${observation.orThumbnail}" width="30" height="25">
				                                            </s:if>                                            
			                                            </td>
				                                   		<s:set name="pcode" value="'003023002007'" />
			                                   			<s:set name="pname" value="'orID'" />
			                                   			<s:if test="#observation.orType == '1011' || #observation.orType == '1022'">
			                                   				<s:set name="pcode" value="'003023002007'" />
			                                   			</s:if>
			                                   			<s:if test="#observation.orType == '4033' ">
			                                   				<s:set name="pcode" value="'003023002012'" />
			                                   			</s:if>
			                                   			<s:if test="#observation.orType == '1073' || #observation.orType == '1084'">
			                                   				<s:set name="pcode" value="'003023002008'" />
			                                   			</s:if>     
			                                   			<s:if test="#observation.orType == '2041' || #observation.orType == '2033' || #observation.orType == '2055'">
			                                   				<s:set name="pcode" value="'003023002009'" />
			                                   			</s:if>                                       
			                                            <td width="43%"><span>
			                                            <a onclick="window.parent.parent.parent.showView_redirect(this)"
			                                            	code="${pcode}" 
			                                            	href="javascript:void(0)"
			                                            param="&path=${observation.path}&paramMap.roomtype=observation&paramMap.${pname}=${observation.orID}&paramMap.st=1&paramMap.name=${observation.orName}">${observation.orName}</a></span></td>
			                                            <td width="15%"><span>${observation.orCategoryName}</span></td>
			                                            <td width="18%"><span>${observation.orCreateTime}</span></td>
			                                            <td width="17%">
			                                            	<s:if test="pmsIndex.res_observation_room_upload_modify&&paramMap.userID==#session.s_userID">
			                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_observation_room_upload_modify.code}&path=${observation.path}&paramMap.roomtype=observation&paramMap.${pname}=${observation.orID}&paramMap.st=1">修改</a></span>
			                                            	</s:if>
			                                            	<s:if test="pmsIndex.res_observation_room_upload_delete&&paramMap.userID==#session.s_userID">
			                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_observation_room_upload_delete.code}&paramMap.roomtype=observation&paramMap.${pname}=${observation.orID}">删除</a></span>
			                                            	</s:if>
			                                            </td>
		                                          </tr>
	                                          </s:iterator>
	                                          <tr style="height: 45px;">
												<td colspan="5">
													<div class="pageb" id="table2page">
														${initMap.observationPaginated.pageContent}
													</div>
												</td>
											  </tr>
                                        </table>
                                    </td>
                                  </tr>
                                </table>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_yj hide">
                                  <tr>
                                    <td class="tabler3td">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#ae9b84">
	                                          <s:iterator value="initMap.laboratory" id="laboratory" status="iabindx">	
		                                          <tr>
		                                            <td width="7%" height="35" align="center" valign="bottom">
			                                            <s:if test="#laboratory.lrThumbnail == null">
			                                            	<img src="images/file/xwj_1.gif" width="30" height="25">
			                                            </s:if>
			                                            <s:if test="#laboratory.lrThumbnail != null">
			                                            	<img src="${laboratory.lrThumbnail}" width="30" height="25">
			                                            </s:if>  
		                                            </td>
		                                   			<s:set name="pcode" value="'003023003007'" />
		                                   			<s:set name="pname" value="'lrID'" />
		                                   			<s:if test="#laboratory.lrType == '1011' || #laboratory.lrType == '1022'">
		                                   				<s:set name="pcode" value="'003023003007'" />
		                                   			</s:if>
		                                   			<s:if test="#laboratory.lrType == '1073' || #laboratory.lrType == '1084'">
		                                   				<s:set name="pcode" value="'003023003008'" />
		                                   			</s:if>            
		                                   			<s:if test="#laboratory.lrType == '2041' || #laboratory.lrType == '2033' || #laboratory.lrType == '2055'">
		                                   				<s:set name="pcode" value="'003023003009'" />
		                                   			</s:if>                                       
		                                            <td width="43%"><span>
		                                            <a onclick="window.parent.parent.parent.showView_redirect(this)"
			                                            code="${pcode}" 
			                                            href="javascript:void(0)"
		                                            param="&path=${laboratory.path}&paramMap.roomtype=laboratory&paramMap.${pname}=${laboratory.lrID}&paramMap.st=1&paramMap.name=${laboratory.lrName}">${laboratory.lrName}</a></span></td>
		                                            <td width="15%"><span>${laboratory.lrCategoryName}</span></td>
		                                            <td width="18%"><span>${laboratory.lrCreateTime}</span></td>
		                                            <td width="17%">
		                                            	<s:if test="pmsIndex.res_laboratory_room_upload_modify&&paramMap.userID==#session.s_userID">
		                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_laboratory_room_upload_modify.code}&path=${laboratory.path}&paramMap.roomtype=laboratory&paramMap.${pname}=${laboratory.lrID}&paramMap.st=1">修改</a></span>
		                                            	</s:if>
		                                            	<s:if test="pmsIndex.res_laboratory_room_upload_delete&&paramMap.userID==#session.s_userID">
		                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_laboratory_room_upload_delete.code}&paramMap.roomtype=laboratory&paramMap.${pname}=${laboratory.lrID}">删除</a></span>
		                                            	</s:if>
		                                            </td>
		                                          </tr>
	                                          </s:iterator>
	                                          <tr style="height: 45px;">
												<td colspan="5">
													<div class="pageb" id="table3page">
														${initMap.laboratoryPaginated.pageContent}
													</div>
												</td>
											  </tr>
                                        </table>
                                    </td>
                                  </tr>
                                </table>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_yj hide">
                                  <tr>
                                    <td class="tabler3td">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#ae9b84">
                                          <s:iterator value="initMap.projection" id="projection" status="proindx">	
                                          <tr>
                                            <td width="7%" height="35" align="center" valign="bottom">
                                             <s:if test="#projection.prThumbnail == null">
                                            	<img src="images/file/xwj_1.gif" width="30" height="25">
                                            </s:if>
                                            <s:if test="#projection.prThumbnail != null">
                                            	<img src="${projection.prThumbnail}" width="30" height="25">
                                            </s:if>  
                                            </td>
                                   			<s:set name="pcode" value="'003023004008'" />
                                   			<s:set name="pname" value="'prID'" />
                                   			<s:if test="#projection.prType == '1084'">
                                   				<s:set name="pcode" value="'003023004008'" />
                                   			</s:if>           
                                   			<s:if test="#projection.prType == '1073'">
                                   				<s:set name="pcode" value="'003023004012'" />
                                   			</s:if>
                                            <td width="43%"><span>
                                            <a onclick="window.parent.parent.parent.showView_redirect(this)"
			                                   code="${pcode}" 
			                                   href="javascript:void(0)"
                                            param="&path=${projection.path}&paramMap.roomtype=projection&paramMap.${pname}=${projection.prID}&paramMap.st=1&paramMap.name=${projection.prName}">${projection.prName}</a></span></td>
                                            <td width="15%"><span>${projection.prCategoryName}</span></td>
                                            <td width="18%"><span>${projection.prCreateTime}</span></td>
                                            <td width="17%">
                                            	<s:if test="pmsIndex.res_projection_room_upload_modify&&paramMap.userID==#session.s_userID">
                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_projection_room_upload_modify.code}&path=${projection.path}&paramMap.roomtype=projection&paramMap.${pname}=${projection.prID}&paramMap.st=1">修改</a></span>
                                            	</s:if>
                                            	<s:if test="pmsIndex.res_projection_room_upload_delete&&paramMap.userID==#session.s_userID">
                                      		      	<span><a href="decorateForwardAction.action?code=${pmsIndex.res_projection_room_upload_delete.code}&paramMap.roomtype=projection&paramMap.${pname}=${projection.prID}">删除</a></span>
                                            	</s:if>
                                            </td>
                                          </tr>
                                          </s:iterator>
                                          <tr style="height: 45px;">
												<td colspan="5">
													<div class="pageb" id="table4page">
														${initMap.projectionPaginated.pageContent}
													</div>
												</td>
											  </tr>
                                        </table>
                                    </td>
                                  </tr>
                                </table>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_yj hide">
                                  <tr>
                                    <td class="tabler3td">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#ae9b84">
                                          <s:iterator value="initMap.lovely" id="lovely" status="crlindx">	
                                          <tr>
                                            <td width="7%" height="35" align="center" valign="bottom">
                                             <s:if test="#lovely.crThumbnail == null">
                                            	<img src="images/file/xwj_1.gif" width="30" height="25">
                                            </s:if>
                                            <s:if test="#lovely.crThumbnail != null">
                                            	<img src="${lovely.crThumbnail}" width="30" height="25">
                                            </s:if>  
                                            </td>
                                   			<s:set name="pcode" value="'003023004008'" />
                                   			<s:set name="pname" value="'prID'" />
                                   			<s:if test="#lovely.crType == '1084'">
                                   				<s:set name="pcode" value="'003023004008'" />
                                   			</s:if>           
                                   			<s:if test="#lovely.crType == '1073'">
                                   				<s:set name="pcode" value="'003023004012'" />
                                   			</s:if>
                                            <td width="43%"><span>
                                            <a onclick="window.parent.parent.parent.showView_redirect(this)" 
			                                   code="${pcode}"
			                                   param="&path=${lovely.path}&paramMap.roomtype=lovely&paramMap.${pname}=${lovely.crID}&paramMap.st=1&paramMap.name=${lovely.crName}"
			                                   href="javascript:void(0)" >${lovely.crName}</a></span></td>
                                            <td width="15%"><span>${lovely.crCategoryName}</span></td>
                                            <td width="18%"><span>${lovely.crCreateTime}</span></td>
                                            <td width="17%">
                                            	<s:if test="pmsIndex.res_lovely_room_upload_modify&&paramMap.userID==#session.s_userID">
                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_lovely_room_upload_modify.code}&path=${lovely.path}&paramMap.roomtype=lovely&paramMap.${pname}=${lovely.crID}&paramMap.st=1">修改</a></span>
                                            	</s:if>
                                            	<s:if test="pmsIndex.res_lovely_room_upload_delete&&paramMap.userID==#session.s_userID">
                                      		      	<span><a href="decorateForwardAction.action?code=${pmsIndex.res_lovely_room_upload_delete.code}&paramMap.roomtype=lovely&paramMap.${pname}=${lovely.crID}">删除</a></span>
                                            	</s:if>
                                            </td>
                                          </tr>
                                          </s:iterator>
                                          <tr style="height: 45px;">
												<td colspan="5">
													<div class="pageb" id="table4page">
														${initMap.lovalyPaginated.pageContent}
													</div>
												</td>
											  </tr>
                                        </table>
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
</HTML>
