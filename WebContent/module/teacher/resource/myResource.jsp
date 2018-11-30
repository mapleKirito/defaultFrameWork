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
	var change_type = '${paramMap.change_type}';
	if (change_type != '') {
		$(".table_yj").eq(change_type).show().siblings().hide();
		$(".ziyuantab a.ltselect").eq(change_type).addClass("lt-private").siblings().removeClass("lt-private");
	}
	
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
	
	$("#createresbyroom").click(function(){
		var clickthis = $("#change_type").val();
		if(clickthis==0){
			window.location.href="decorateForwardAction.action?code=002032003001001" ;
		}else if(clickthis==1){
			window.location.href="decorateForwardAction.action?code=002032003001002" ;
		}else if(clickthis==2){
			window.location.href="decorateForwardAction.action?code=002032003001003" ;
		}else if(clickthis==3){
			window.location.href="decorateForwardAction.action?code=002032003001004" ;
		}else if(clickthis==4){
			window.location.href="decorateForwardAction.action?code=002032003001005" ;
		}
	});	
	 $(".shareBtn").die().live("click",function(){
		var code=$(this).attr("code");
		
		var pValue=$(this).attr("pValue");
		var share=$(this).attr("share");
		var grShare=share.substring(share.indexOf('=')+1);
		var grResourceType="";
		var roomFlag=share.substring(share.indexOf('.')+1,share.indexOf('.')+3);
		if (roomFlag=="er"){
			grResourceType="exhibition";
		}else if(roomFlag=="or"){
			grResourceType="observation";
		}else if(roomFlag=="pr"){
			grResourceType="projection";
		}else if(roomFlag=="cr"){
			grResourceType="lovely";
		}else if(roomFlag=="lr"){
			grResourceType="laboratory";
		}
		var grResourceID=pValue.substring(pValue.indexOf('=')+1);
	  
		var liObj=$(this);
		var str="确定要分享这个资源吗";
		if(share.charAt(share.length - 1)=="0"){
			str="确定要取消分享这个资源吗";
		}
		if(confirm(str)){
			$.ajax({
				url:		'ajaxAction.action?code='+code+'&'+pValue+'&'+share+'&paramMap.grIsShare='+grShare+'&paramMap.grResourceType='+grResourceType+'&paramMap.grResourceID='+grResourceID+'&paramMap.rrIsShare='+grShare+'&paramMap.rrResourceType='+grResourceType+'&paramMap.rrResourceID='+grResourceID,
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					if (textStatus == "success"){
						
						//if(jsonData.flag>0){
							if(share.charAt(share.length - 1)=="0"){
								alert("取消分享成功");
								//liObj.parent().remove();
								var reg = /\d+/g;
								share = share.replace(reg, function($0){
								    var i = parseInt($0, 10);
								    if(i==1){
								    	i=0;
								    }else if(i==0){
								    	i=1;
								    }
								    return i;
								});
								//alert(share);
								liObj.attr("share",share);
								liObj.html("分享");
							}else{
							alert("分享成功");
							//liObj.parent().remove();
							var reg = /\d+/g;
							share = share.replace(reg, function($0){
							    var i = parseInt($0, 10);
							    if(i==1){
							    	i=0;
							    }else if(i==0){
							    	i=1;
							    }
							    return i;
							});
							//alert(share);
							liObj.attr("share",share);
							liObj.html("已分享");
							//liObj.parent().parent().remove();
							}		
					}
					}	
				//}
			}); 
		}
		
	})
}); 
</script>
</head>
<body >
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" id="change_type" value="${(paramMap.change_type==null||paramMap.change_type=='')?0:paramMap.change_type}">
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
											<span>${pmsIndex.res_exhibition_room_upload.name}</span>
										</a>
										<a href="javascript:void(0)" id="${pmsIndex.res_observation_room_upload.code}" class="ltselect">
											<span>${pmsIndex.res_observation_room_upload.name}</span>
										</a>
										<a href="javascript:void(0)" id="${pmsIndex.res_laboratory_room_upload.code}" class="ltselect">
											<span>${pmsIndex.res_laboratory_room_upload.name}</span>
										</a>
										<a href="javascript:void(0)" id="${pmsIndex.res_projection_room_upload.code}" class="ltselect">
											<span>${pmsIndex.res_projection_room_upload.name}</span>
										</a>
										<a href="javascript:void(0)" id="${pmsIndex.res_lovely_room_upload.code}" class="ltselect">
											<span>${pmsIndex.res_lovely_room_upload.name}</span>
										</a>
										<div style="float: right;margin-right: 15px;">
							 				<a href="javascript:void(0)" id="createresbyroom">
                                    		<span>创建+</span>
                                    	</a>
							 			</div>
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
			                                   				<s:set name="pcode" value="'-701001'" />
			                                   			</s:if>
			                                            <td width="43%"><span><a onclick="window.parent.parent.parent.showView_redirect(this)" param="&path=${exhibit.path}&paramMap.roomtype=exhibition&paramMap.${pname}=${exhibit.erID}&paramMap.st=1&paramMap.name=${exhibit.erName}" code="${pcode}" href="javascript:void(0)">${exhibit.erName}</a></span></td>
			                                            <td width="15%"><span>${exhibit.erJie}</span></td>
			                                            <td width="18%"><span>${exhibit.erCreateTime}</span></td>
			                                            <td width="17%">
			                                            	<s:if test="pmsIndex.res_exhibition_room_upload_share">
			                                            		<span><a class="shareBtn" share="paramMap.erIsShare=${exhibit.erIsShare=='1'?'0':'1'}" code="${pmsIndex.res_exhibition_room_upload_share.code}" pValue="paramMap.${pname}=${exhibit.erID}" href="javascript:void(0)">${exhibit.erIsShare=='1'?'已分享':'分享'}</a></span>
			                                            	</s:if>
			                                            	<s:if test="pmsIndex.res_exhibition_room_upload_modify">
			                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_exhibition_room_upload_modify.code}&path=${exhibit.path}&paramMap.roomtype=exhibition&paramMap.${pname}=${exhibit.erID}&paramMap.st=1">修改</a></span>
			                                            	</s:if>
			                                            	<s:if test="pmsIndex.res_exhibition_room_upload_delete">
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
			                                   			<s:if test="#observation.orType == '1011' || #observation.orType == '1022'|| #observation.orType == '1073'|| #observation.orType == '4033'">
			                                   				<s:set name="pcode" value="'-701004'" />
			                                   			</s:if>
			                                   			<s:if test="#observation.orType == '4033' ">
			                                   				<s:set name="pcode" value="'-701004'" />
			                                   			</s:if>
			                                   			<s:if test="#observation.orType == '1084'">
			                                   				<s:set name="pcode" value="'-701005'" />
			                                   			</s:if>     
			                                   			<s:if test="#observation.orType == '2041' || #observation.orType == '2033' || #observation.orType == '2055'">
			                                   				<s:set name="pcode" value="'-701019'" />
			                                   			</s:if>                                       
			                                            <td width="43%"><span>
			                                            <a onclick="window.parent.parent.parent.showView_redirect(this)" 
			                                            	code="${pcode}"
			                                            	param="&path=${observation.path}&paramMap.roomtype=observation&paramMap.${pname}=${observation.orID}&paramMap.st=1&paramMap.name=${observation.orName}" 
			                                            	href="javascript:void(0)">${observation.orName}</a></span></td>
			                                            <td width="15%"><span>${observation.orCategoryName}</span></td>
			                                            <td width="18%"><span>${observation.orCreateTime}</span></td>
			                                            <td width="17%">
			                                            	<s:if test="pmsIndex.res_observation_room_upload_share">
			                                            		<span><a class="shareBtn" share="paramMap.orIsShare=${observation.orIsShare=='1'?'0':'1'}" code="${pmsIndex.res_observation_room_upload_share.code}" pValue="paramMap.${pname}=${observation.orID}" href="javascript:void(0)">${observation.orIsShare=='1'?'已分享':'分享'}</a></span>
			                                            	</s:if>
			                                            	<s:if test="pmsIndex.res_observation_room_upload_modify">
			                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_observation_room_upload_modify.code}&path=${observation.path}&paramMap.roomtype=observation&paramMap.${pname}=${observation.orID}&paramMap.st=1">修改</a></span>
			                                            	</s:if>
			                                            	<s:if test="pmsIndex.res_observation_room_upload_delete">
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
		                                   			<s:if test="#laboratory.lrType == '1011' || #laboratory.lrType == '1022'|| #laboratory.lrType == '1073'|| #laboratory.lrType == '4033'">
		                                   				<s:set name="pcode" value="'-701007'" />
		                                   			</s:if>
		                                   			<s:if test="#laboratory.lrType == '1084'">
		                                   				<s:set name="pcode" value="'-701008'" />
		                                   			</s:if>            
		                                   			<s:if test="#laboratory.lrType == '2041' || #laboratory.lrType == '2033' || #laboratory.lrType == '2055'">
		                                   				<s:set name="pcode" value="'-701020'" />
		                                   			</s:if>                                       
		                                            <td width="43%"><span>
		                                            <a  onclick="window.parent.parent.parent.showView_redirect(this)" 
			                                            	code="${pcode}"
			                                            	param="&path=${laboratory.path}&paramMap.roomtype=laboratory&paramMap.${pname}=${laboratory.lrID}&paramMap.st=1&paramMap.name=${laboratory.lrName}"
			                                            	href="javascript:void(0)">${laboratory.lrName}</a></span></td>
		                                            <td width="15%"><span>${laboratory.lrCategoryName}</span></td>
		                                            <td width="18%"><span>${laboratory.lrCreateTime}</span></td>
		                                            <td width="17%">
		                                           		<s:if test="pmsIndex.res_laboratory_room_upload_share">
		                                           			<span><a class="shareBtn" share="paramMap.lrIsShare=${laboratory.lrIsShare=='1'?'0':'1'}" code="${pmsIndex.res_laboratory_room_upload_share.code}" pValue="paramMap.${pname}=${laboratory.lrID}" href="javascript:void(0)">${laboratory.lrIsShare=='1'?'已分享':'分享'}</a></span>
		                                            	</s:if>
		                                            	<s:if test="pmsIndex.res_laboratory_room_upload_modify">
		                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_laboratory_room_upload_modify.code}&path=${laboratory.path}&paramMap.roomtype=laboratory&paramMap.${pname}=${laboratory.lrID}&paramMap.st=1">修改</a></span>
		                                            	</s:if>
		                                            	<s:if test="pmsIndex.res_laboratory_room_upload_delete">
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
                                   				<s:set name="pcode" value="'-701011'" />
                                   			</s:if>           
                                   			<s:if test="#projection.prType == '1073'">
                                   				<s:set name="pcode" value="'-701024'" />
                                   			</s:if>
                                            <td width="43%"><span>
                                            <a onclick="window.parent.parent.parent.showView_redirect(this)" 
			                                   code="${pcode}"
			                                   param="&path=${projection.path}&paramMap.roomtype=projection&paramMap.${pname}=${projection.prID}&paramMap.st=1&paramMap.name=${projection.prName}"
			                                   href="javascript:void(0)">${projection.prName}</a></span></td>
                                            <td width="15%"><span>${projection.prCategoryName}</span></td>
                                            <td width="18%"><span>${projection.prCreateTime}</span></td>
                                            <td width="17%">
                                            	<s:if test="pmsIndex.res_projection_room_upload_share">
                                            		<span><a class="shareBtn" share="paramMap.prIsShare=${projection.prIsShare=='1'?'0':'1'}" code="${pmsIndex.res_projection_room_upload_share.code}" pValue="paramMap.${pname}=${projection.prID}" href="javascript:void(0)">${projection.prIsShare=='1'?'已分享':'分享'}</a></span>
                                            	</s:if>
                                            	<s:if test="pmsIndex.res_projection_room_upload_modify">
                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_projection_room_upload_modify.code}&path=${projection.path}&paramMap.roomtype=projection&paramMap.${pname}=${projection.prID}&paramMap.st=1">修改</a></span>
                                            	</s:if>
                                            	<s:if test="pmsIndex.res_projection_room_upload_delete">
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
                                   			<s:set name="pname" value="'crID'" />
                                   			<s:if test="#lovely.crType == '1011'||#lovely.crType == '1022'||#lovely.crType == '1073'||#lovely.crType == '4033'">
                                   				<s:set name="pcode" value="'-701016'" />
                                   			</s:if>   
                                   			<s:if test="#lovely.crType == '1084'">
                                   				<s:set name="pcode" value="'-701017'" />
                                   			</s:if> 
                                   			<s:if
												test="#lovely.crType == '2041' || #lovely.crType == '2033' || #lovely.crType == '2055'">
												<s:set name="pcode" value="'-701022'" />
											</s:if>
                                            <td width="43%"><span>
                                            <a onclick="window.parent.parent.parent.showView_redirect(this)" 
			                                   code="${pcode}"
			                                   param="&path=${lovely.path}&paramMap.roomtype=lovely&paramMap.${pname}=${lovely.crID}&paramMap.st=1&paramMap.name=${lovely.crName}"
			                                   href="javascript:void(0)" >${lovely.crName}</a></span></td>
                                            <td width="15%"><span>${lovely.crCategoryName}</span></td>
                                            <td width="18%"><span>${lovely.crCreateTime}</span></td>
                                            <td width="17%">
                                           
                                            	<s:if test="pmsIndex.res_lovecountry_room_upload_share">
                             
                                            		<span><a class="shareBtn" share="paramMap.crIsShare=${lovely.crIsShare=='1'?'0':'1'}" code="${pmsIndex.res_lovecountry_room_upload_share.code}" pValue="paramMap.crID=${lovely.crID}" href="javascript:void(0)">${lovely.crIsShare=='1'?'已分享':'分享'}</a></span>
                                            	</s:if>
                                            	<s:if test="pmsIndex.res_lovely_room_upload_modify">
                                            		<span><a href="decorateForwardAction.action?code=${pmsIndex.res_lovely_room_upload_modify.code}&path=${lovely.path}&paramMap.roomtype=lovely&paramMap.crID=${lovely.crID}&paramMap.st=1">修改</a></span>
                                            	</s:if>
                                            	<s:if test="pmsIndex.res_lovely_room_upload_delete">
                                      		      	<span><a href="decorateForwardAction.action?code=${pmsIndex.res_lovely_room_upload_delete.code}&paramMap.roomtype=lovely&paramMap.crID=${lovely.crID}">删除</a></span>
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
