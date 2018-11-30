<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>

<html>
<%
	String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<title>${promptInfo.totalDescInfo}</title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/pageToolbar2.js"></script>
<!--[if IE]> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main_help.css">
<![endif]-->
<script type="text/javascript">
$(document).ready(function(){	
	var $zy_li =$(".ziyuantab li");
	$zy_li.click(function(){
		$(this).addClass("curr").siblings().removeClass("curr"); 
		var index =  $zy_li.index(this);  
		$("#change_type").val(index);
		$(".table_yj").eq(index).show().siblings().hide(); 
	});
	
	
	
	var change_type_index = '${paramMap.change_type}' == '' ? '0' : '${paramMap.change_type}';
	$zy_li.eq(change_type_index).addClass("curr").siblings().removeClass("curr");
	$(".table_yj").eq(change_type_index).show().siblings().hide();
	$("#change_type").val(change_type_index);
	$('#table1page').pageTB();
	$('#table2page').pageTB();
	$('#table3page').pageTB();
	$('#table4page').pageTB();
	$('#table5page').pageTB();
});
</script>
</head>
<body >
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" id="change_type" value="0">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_1" style="border: 1px solid #606373">
					  <tr>
						<td valign="top" bgcolor="#E6E6EA">
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_12" >
							  <tr>
								<td style="background:#E6E6EA; height:32px;border-bottom: 1px solid #E6E6EA;">
									<ul class="ziyuantab">
								    	<li class="curr">陈列室</li>
										<li>观察室</li>
										<li>实验室</li>
                                        <li>放映室</li>
										<li>拓展室</li>
									</ul>
                                    <div class="right"><a href="decorateForwardAction.action?code=-006104001"><div id="create_1_div"><img src="images/main/teacher_0.png" border="0" />&nbsp;&nbsp;<span>创建</span></div></a></div>
								</td>
							  </tr>
							</table>
                            <div>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_yj">
                                  <tr>
                                    <td class="tabler3td">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#606373">
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
			                                   			<s:set name="pcode" value="'003011011'" />
			                                   			<s:set name="pname" value="'erID'" />
			                                   			<s:if test="#exhibit.erType == '1011'">
			                                   				<s:set name="pcode" value="'003011009'" />
			                                   			</s:if>
			                                   			<s:if test="#exhibit.erType == '1073' || #exhibit.erType == '1084'">
			                                   				<s:set name="pcode" value="'003011010'" />
			                                   			</s:if>
			                                   			<s:if test="#exhibit.erType == '2041' || #exhibit.erType == '2033' || #exhibit.erType == '2055'">
			                                   				<s:set name="pcode" value="'003011013'" />
			                                   			</s:if>
			                                            <td width="43%"><a href="decorateForwardAction.action?code=${pcode}&path=${exhibit.path}&paramMap.roomtype=exhibition&paramMap.${pname}=${exhibit.erID}&paramMap.st=1">${exhibit.erName}</a></td>
			                                            <td width="15%">${exhibit.erJie}</td>
			                                            <td width="18%">${exhibit.erCreateTime}</td>
			                                            <td width="17%">
			                                            	<s:if test="pmsIndex.res_exhibition_room_upload_modify">
			                                            		<a href="decorateForwardAction.action?code=-006104001006&path=${exhibit.path}&paramMap.roomtype=exhibition&paramMap.${pname}=${exhibit.erID}&paramMap.st=1">修改</a>
			                                            	</s:if>
			                                            	<s:if test="pmsIndex.res_exhibition_room_upload_delete">
			                                            		<a href="decorateForwardAction.action?code=-006104001011&paramMap.change_type=0&paramMap.roomtype=exhibition&paramMap.${pname}=${exhibit.erID}">删除</a>
			                                            	</s:if>
			                                            </td>
		                                          </tr>
	                                          </s:iterator>
	                                           <tr>
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
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#606373">
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
				                                   		<s:set name="pcode" value="'003012011'" />
			                                   			<s:set name="pname" value="'orID'" />
			                                   			<s:if test="#observation.orType == '1011' || #observation.orType == '1022'">
			                                   				<s:set name="pcode" value="'003012009'" />
			                                   			</s:if>
			                                   			<s:if test="#observation.orType == '1073' || #observation.orType == '1084'">
			                                   				<s:set name="pcode" value="'003012010'" />
			                                   			</s:if>     
			                                   			<s:if test="#observation.orType == '2041' || #observation.orType == '2033' || #observation.orType == '2055'">
			                                   				<s:set name="pcode" value="'003012013'" />
			                                   			</s:if>                                       
			                                            <td width="43%"><a href="decorateForwardAction.action?code=${pcode}&path=${observation.path}&paramMap.roomtype=observation&paramMap.${pname}=${observation.orID}&paramMap.st=1">${observation.orName}</a></td>
			                                            <td width="15%">${observation.orCategoryName}</td>
			                                            <td width="18%">${observation.orCreateTime}</td>
			                                            <td width="17%">
			                                            	<s:if test="pmsIndex.res_observation_room_upload_modify">
			                                            		<a href="decorateForwardAction.action?code=-006104001007&path=${observation.path}&paramMap.roomtype=observation&paramMap.${pname}=${observation.orID}&paramMap.st=1">修改</a>
			                                            	</s:if>
			                                            	<s:if test="pmsIndex.res_observation_room_upload_delete">
			                                            		<a href="decorateForwardAction.action?code=-006104001012&paramMap.change_type=1&paramMap.roomtype=observation&paramMap.${pname}=${observation.orID}">删除</a>
			                                            	</s:if>
			                                            </td>
		                                          </tr>
	                                          </s:iterator>
	                                          <tr>
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
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#606373">
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
		                                   			<s:set name="pcode" value="'003013011'" />
		                                   			<s:set name="pname" value="'lrID'" />
		                                   			<s:if test="#laboratory.lrType == '1011' || #laboratory.lrType == '1022'">
		                                   				<s:set name="pcode" value="'003013009'" />
		                                   			</s:if>
		                                   			<s:if test="#laboratory.lrType == '1073' || #laboratory.lrType == '1084'">
		                                   				<s:set name="pcode" value="'003013010'" />
		                                   			</s:if>            
		                                   			<s:if test="#laboratory.lrType == '2041' || #laboratory.lrType == '2033' || #laboratory.lrType == '2055'">
		                                   				<s:set name="pcode" value="'003013013'" />
		                                   			</s:if>                                       
		                                            <td width="43%"><a href="decorateForwardAction.action?code=${pcode}&path=${laboratory.path}&paramMap.roomtype=laboratory&paramMap.${pname}=${laboratory.lrID}&paramMap.st=1">${laboratory.lrName}</a></td>
		                                            <td width="15%">${laboratory.lrCategoryName}</td>
		                                            <td width="18%">${laboratory.lrCreateTime}</td>
		                                            <td width="17%">
		                                            	<s:if test="pmsIndex.res_laboratory_room_upload_modify">
		                                            		<a href="decorateForwardAction.action?code=-006104001008&path=${laboratory.path}&paramMap.roomtype=laboratory&paramMap.${pname}=${laboratory.lrID}&paramMap.st=1">修改</a>
		                                            	</s:if>
		                                            	<s:if test="pmsIndex.res_laboratory_room_upload_delete">
		                                            		<a href="decorateForwardAction.action?code=-006104001013&paramMap.change_type=2&paramMap.roomtype=laboratory&paramMap.${pname}=${laboratory.lrID}">删除</a>
		                                            	</s:if>
		                                            </td>
		                                          </tr>
	                                          </s:iterator>
	                                          <tr>
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
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#606373">
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
                                   			<s:set name="pcode" value="'003014011'" />
                                   			<s:set name="pname" value="'prID'" />
                                   			<s:if test="#projection.prType == '1011' || #projection.prType == '1022'">
                                   				<s:set name="pcode" value="'003014009'" />
                                   			</s:if>
                                   			<s:if test="#projection.prType == '1084'">
                                   				<s:set name="pcode" value="'003014010'" />
                                   			</s:if>           
                                   			<s:if test="#projection.prType == '2041' || #projection.prType == '2033' || #projection.prType == '2055'">
                                   				<s:set name="pcode" value="'003014013'" />
                                   			</s:if> 
                                   			<s:if test="#projection.prType == '1073'">
                                   				<s:set name="pcode" value="'003014014'" />
                                   			</s:if>
                                            <td width="58%"><a href="decorateForwardAction.action?code=${pcode}&path=${projection.path}&paramMap.roomtype=projection&paramMap.${pname}=${projection.prID}&paramMap.st=1">${projection.prName}</a></td>
                                            <td width="18%">${projection.prCreateTime}</td>
                                            <td width="17%">
                                            	<s:if test="pmsIndex.res_projection_room_upload_modify">
                                            		<a href="decorateForwardAction.action?code=-006104001009&path=${projection.path}&paramMap.roomtype=projection&paramMap.${pname}=${projection.prID}&paramMap.st=1">修改</a>
                                            	</s:if>
                                            	<s:if test="pmsIndex.res_projection_room_upload_delete">
                                      		      	<a href="decorateForwardAction.action?code=-006104001014&paramMap.change_type=3&paramMap.roomtype=projection&paramMap.${pname}=${projection.prID}">删除</a>
                                            	</s:if>
                                            </td>
                                          </tr>
                                          </s:iterator>
                                          <tr>
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
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_4_1" style="background-color:#606373">
                                          <s:iterator value="initMap.lovely" id="lovely" status="expindx">	
                                          <tr>
                                            <td width="7%" height="35" align="center" valign="bottom">
                                             <s:if test="#lovely.erThumbnail == null">
                                            	<img src="images/file/xwj_1.gif" width="30" height="25">
                                            </s:if>
                                            <s:if test="#lovely.erThumbnail != null">
                                            	<img src="${lovely.erThumbnail}" width="30" height="25">
                                            </s:if>  
                                            </td>
                                            <s:set name="pcode" value="'003015008'" />
                                   			<s:set name="pname" value="'erID'" />
                                   			<s:if test="#lovely.erType == '1011' || #lovely.erType == '1022'">
                                   				<s:set name="pcode" value="'003015011'" />
                                   			</s:if>
                                   			<s:if test="#lovely.erType == '1073' || #lovely.erType == '1084'">
                                   				<s:set name="pcode" value="'003015012'" />
                                   			</s:if>
                                   			<s:if test="#lovely.erType == '2041' || #lovely.erType == '2033' || #lovely.erType == '2055'">
                                   				<s:set name="pcode" value="'003015013'" />
                                   			</s:if>
                                            <td width="58%">
                                            <s:if test="#lovely.erTaskId == null or #lovely.erTaskId == ''">
                                            <a href="decorateForwardAction.action?code=${pcode}&path=${lovely.path}&paramMap.roomtype=lovely&paramMap.${pname}=${lovely.erID}&paramMap.st=1">${lovely.erName}</a>
                                            </s:if>
                                            </td>
                                            <td width="18%">${lovely.erCreateTime}</td>
                                            <td width="17%">
                                            	<s:if test="pmsIndex.res_expand_room_upload_modify">
                                            		<a href="decorateForwardAction.action?code=-006104001010&path=${lovely.path}&paramMap.roomtype=lovely&paramMap.${pname}=${lovely.erID}&paramMap.st=1">修改</a>
                                            	</s:if>
                                            	<s:if test="pmsIndex.res_expand_room_upload_delete">
                                            		<a href="decorateForwardAction.action?code=-006104001015&paramMap.change_type=4&paramMap.roomtype=lovely&paramMap.${pname}=${lovely.erID}">删除</a>
                                            	</s:if>
                                            </td>
                                          </tr>
                                          </s:iterator>
                                           <tr>
												<td colspan="5">
													<div class="pageb" id="table5page">
														${initMap.expandPaginated.pageContent}
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
