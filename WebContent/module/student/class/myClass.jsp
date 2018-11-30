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
<script type="text/javascript">
$(document).ready(function(){	
	var $div_li =$(".looktab li");
	$div_li.click(function(){
		$(this).addClass("curr")            //当前<li>元素高亮
			   .siblings().removeClass("curr");  //去掉其它同辈<li>元素的高亮
		var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
		$(".table_9")   	//选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
				.eq(index).show()   //显示 <li>元素对应的<div>元素
				.siblings().hide(); //隐藏其它几个同辈的<div>元素
	});		
	$("#questionBtn").click(function(){
		window.location.href = "decorateForwardAction.action?code=001004001&paramMap.step=${pmsIndex.my_class_mgr.imitationStep}";
	});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_1">
					  <tr>
						<td height="30">
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px solid #cdcdcd;">
                              <tr>
                                <td width="2%" height="20">&nbsp;</td>
                                <td width="13%" class="size_2">所在班级：
                                <s:iterator value="session.s_userOrgMapper" id="uo" status="uoindx">
                                   ${uo.orgName}
                                </s:iterator>
                                </td>
                                <td width="16%" class="size_2">当前班级人数：<span class="font_1">${initMap.stdCount}</span>人</td>
                                <td width="69%" class="size_2" align="right">
                                	<input type="button" name="questionBtn" id="questionBtn" class="ztft"/>
                                </td>
                              </tr>
                            </table>
                        </td>
					  </tr>
					  <tr>
						<td valign="top" bgcolor="#FFFFFF">
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_13">
							  <tr>
								<td style="background:url(images/main/teacher_13.jpg) repeat-x; height:33px;">
									<ul class="looktab">
										<li class="curr">作业习题</li>
										<li>学生提问</li>
									</ul>
                               	</td>
							  </tr>
							</table>
                            <div>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
                                      <tr style="background:url(images/main/teacher_14.jpg) repeat-x;">
                                        <th height="34" colspan="2">标题</th>
                                        <th>未完成数</th>
                                        <th width="11%">回复/查看</th>
                                        <th width="26%">发表时间</th>
                                      </tr>
									  <s:iterator value="initMap.stdClassTask" id="task" status="tindx">
									  <s:if test="tindx%2 == 0">
									  <tr bgcolor="#ae9b84">
                                        <td width="2%" height="35" class="tatd"><img src="images/main/bg_13.png" width="13" height="14"></td>
                                        <td width="51%" height="35" class="tatd"><a href="decorateForwardAction.action?code=001001003&paramMap.taskId=${task.taskId}">${task.title}</a></td>
                                        <td width="10%" height="35" align="center" class="tatd">1&nbsp;</td>
                                        <td height="35" align="center" class="tatd">${task.replyCount}/${task.viewCount}&nbsp;</td>
                                        <td height="35" align="center" class="tatd">${task.createTime}&nbsp;</td>
									  </tr>								  
									  </s:if>
									  <s:if test="tindx%2 != 0">
									  <tr>
                                        <td width="2%" height="35" class="tatd"><img src="images/main/bg_13.png" width="13" height="14"></td>
                                        <td width="51%" height="35" class="tatd"><a href="decorateForwardAction.action?code=001001003&paramMap.taskId=${task.taskId}">${task.title}</a></td>
                                        <td width="10%" height="35" align="center" class="tatd">1&nbsp;</td>
                                        <td height="35" align="center" class="tatd">${task.replyCount}/${task.viewCount}&nbsp;</td>
                                        <td height="35" align="center" class="tatd">${task.createTime}&nbsp;</td>
									  </tr>
									  </s:if>
									  </s:iterator>                                      
                                      <tr>
                                        <td colspan="5">
                                            <div class="pageb">
                                            ${initMap.classTaskPaginated.pageContent}
                                            </div>								
                                         </td>
                                      </tr>
                            	</table>
                            	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
                                      <tr style="background:url(images/main/teacher_14.jpg) repeat-x;">
                                        <th height="34" colspan="2">标题</th>
                                        <th>未完成数</th>
                                        <th width="11%">回复/查看</th>
                                        <th width="26%">发表时间</th>
                                      </tr>
									  <s:iterator value="initMap.stdClassQuestion" id="question" status="tindx">
									  <s:if test="tindx%2 == 0">
									  <tr bgcolor="#ae9b84">
                                        <td width="2%">
								  	  		<s:if test="#question.isLock==1">
												<img src="images/main/bg_15.png" width="13" height="14">										
											</s:if>
										</td>
										<td width="2%" class="tatd">
										
										<s:if test="#question.isRecommend==1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
										</td>
                                        <td width="51%" height="35" class="tatd"><a href="decorateForwardAction.action?code=001001003&paramMap.taskId=${question.taskId}">${question.title}</a></td>
                                        <td width="10%" height="35" align="center" class="tatd">1&nbsp;</td>
                                        <td height="35" align="center" class="tatd">${question.replyCount}/${question.viewCount}&nbsp;</td>
                                        <td height="35" align="center" class="tatd">${question.createTime}&nbsp;</td>
									  </tr>								  
									  </s:if>
									  <s:if test="tindx%2 != 0">
									  <tr>
                                        <td width="2%" height="35" class="tatd"><img src="images/main/bg_13.png" width="13" height="14"></td>
                                        <td width="51%" height="35" class="tatd"><a href="decorateForwardAction.action?code=001001003&paramMap.taskId=${question.taskId}">${question.title}</a></td>
                                        <td width="10%" height="35" align="center" class="tatd">1&nbsp;</td>
                                        <td height="35" align="center" class="tatd">${question.replyCount}/${question.viewCount}&nbsp;</td>
                                        <td height="35" align="center" class="tatd">${question.createTime}&nbsp;</td>
									  </tr>
									  </s:if>
									  </s:iterator>                                      
                                      <tr>
                                        <td colspan="5">
                                            <div class="pageb">
                                            ${initMap.classQuestionPaginated.pageContent}
                                            </div>								
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