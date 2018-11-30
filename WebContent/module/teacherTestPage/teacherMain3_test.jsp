<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/pageToolbar2.js"></script>
<script type="text/javascript">

$(function(){
	var $div_li =$(".teacherTab li");
	$div_li.click(function(){
		$(this).addClass("curr").siblings().removeClass("curr");  
		var index =  $div_li.index(this);  
		$("#change_type").val(index);
		$(".table_9").eq(index).show().siblings().hide();
	});
	
	var change_type_index = '${paramMap.change_type}' == '' ? '0' : '${paramMap.change_type}';
	$div_li.eq(change_type_index).addClass("curr").siblings().removeClass("curr");
	$(".table_9").eq(change_type_index).show().siblings().hide();
	$("#change_type").val(change_type_index);
	
	
	$("#welcome").click(function(){
		$("#r_content").hide();
		$("#r_welcome").show();
	});
	$("#ask").click(function(){
		$("#r_content").load("decorateForwardAction.action?code=002032001",function(){
			$("#r_welcome").hide();
			$("#r_content").show();
		});
	});
	$("#team").click(function(){
		$("#r_content").load("decorateForwardAction.action?code=002032002",function(){
			$("#r_welcome").hide();
			$("#r_content").show();
		});
	});
	$("#res").click(function(){
		$("#r_content").load("decorateForwardAction.action?code=002032003",function(){
			$("#r_welcome").hide();
			$("#r_content").show();
		});
	});
	$("#attention").click(function(){
		$("#r_content").load("decorateForwardAction.action?code=002032004 .main",function(){
			$("#r_welcome").hide();
			$("#r_content").show();
		});
	});
	$("#article").click(function(){
		$("#r_content").load("decorateForwardAction.action?code=002032005 .main",function(){
			$("#r_welcome").hide();
			$("#r_content").show();
		});
	});
	$("#review").click(function(){
		$("#r_content").load("decorateForwardAction.action?code=002032006 .main",function(){
			$("#r_welcome").hide();
			$("#r_content").show();
		});
	});
	$("#netbk").click(function(){
		$("#r_content").load("decorateForwardAction.action?code=002032007 .main",function(){
			$("#r_welcome").hide();
			$("#r_content").show();
		});
	});
	
})
</script>
<title><s:text name="systemName"/></title>
<style type="text/css">
.Tmain{
height: 700px;
width: 1000px;
}
</style>
</head>
<body>
<input type="hidden" id="userID" value="${paramMap.uID }">
<div class="Tmain">
	<div class="content" style="background-color:#e0ebee; margin:0; padding:0; font-family:'微软雅黑'">
		<input type="hidden" id="change_type" value="0">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="info_tb">
	<tr>
		<td>
			<div style="width: 800px;height:200px;float: left;background: gray;">
				<table width="90%" border="0" cellspacing="0" cellpadding="0" style="line-height: 30px;margin:10px auto;border-collapse: collapse;border: 1px dotted green;">
	<tr>
		<td width="100%" class="onlyex" style="border-bottom: 1px dotted green;">
			<h3>${initMap.htaskSquareTopTitle.htaskTitle}</h3>
		</td>
	</tr>
	<tr>
		<td width="100%" class="onlyex" align="center" style="border-bottom: 1px dotted green;">
			<div id=tags style="height: 36px;">
				<ul><li>任务进度：</li></ul>
				<ul id="curr">
					<s:iterator value="initMap.htaskSquareTop" id="square" status="squareindex">
						<s:if test="#square.htaskLock == 0">
							<li id="li_1" class="title_li li_1"><span><b>任务${squareindex.index+1}</b></span></li>
							<li>>></li>
						</s:if>
						<s:if test="#square.htaskLock == 1">
							<li id="li_1" class="title_li li_1 selected"><span><b>任务${squareindex.index+1}</b></span></li>
							<li>>></li>
							<script type="text/javascript">
								$("#squarehidden").val('${squareindex.index+1}'); 
							</script>
						</s:if>
					</s:iterator>	
				</ul>
			</div>
		</td>
	</tr>
	<tr>
		<td width="100%" class="onlyex">
			<ul id="curr_content">
				<s:iterator value="initMap.htaskSquareTop" id="square" status="squareindex">
					<li style="display: none;"  class="squarecontent${squareindex.index+1}">${square.htaskContent}</li>
				</s:iterator>	
			</ul>
		</td>
	</tr>
	</table>
			</div>
		</td>
	</tr>
	  <tr>			
		<td width="100%" bgcolor="#606373" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_8">
			  <tr>
				<td style="height:32px;">
					<ul class="teacherTab">
						<li class="curr">TA的提问</li>
						<li>TA的回答</li>
						<li>TA的文章</li>
						<li>收藏的资源</li>
						<li>推荐的资源</li>
						<li>上传的资源（老师）</li>
					</ul>								
				</td>
			  </tr>
			</table>
			<div>				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
				  	<tr bgcolor="#ae9b84">					  	  
						<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
							<div>
								<table>
									<tr>
										<th>标题</th>
										<th>财富值</th>
										<th>关键词</th>
										<th>创建时间</th>
									</tr>
									
									<s:subset source="initMap.asklist" start="0" count="10">
										<s:iterator id="l" status="newsIndex">
										<tr>
											<td>${l.htaskTitle}</td>
											<td>${l.htaskWealthval}</td>
											<td>${l.htaskKeywords}</td>
											<td>${l.htaskCreatetime }</td>
										</tr>
										</s:iterator>
									</s:subset>
								
								</table>
							</div>
						</td>	
						
				  	<tr>
				</table>
				
				<table id="grid" width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
				  <tr bgcolor="#ae9b84">
					<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
						<div>
						<table>
									<tr>
										<th>ID</th>
										<th>内容</th>
										<th>参与问题</th>
										<th>创建时间</th>
									</tr>
									
									<s:subset source="initMap.ansList" start="0" count="10">
										<s:iterator id="l" status="newsIndex">
										<tr>
											<td>${l.taID}</td>
											<td>${l.taContent}</td>
											<td>${l.taHtaskID}</td>
											<td>${l.taCreateTime }</td>
										</tr>
										</s:iterator>
									</s:subset>
								
								</table>
						</div>
					</td>
				  </tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
				  <tr bgcolor="#ae9b84">
					<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
						<div>
						<table>
									<tr>
										<th>ID</th>
										<th>标题</th>
										<th>创建时间</th>
									</tr>
									
									<s:subset source="initMap.articleList" start="0" count="10">
										<s:iterator id="l" status="newsIndex">
										<tr>
											<td>${l.aID}</td>
											<td>${l.aTitle}</td>
											<td>${l.aTime}</td>
										</tr>
										</s:iterator>
									</s:subset>
								
								</table>
						</div>
					</td>
				  </tr>
				</table>		
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
				  <tr bgcolor="#ae9b84">
					<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
						<div>
						<table>
									<tr>
										<th>资源名称</th>
										<th>所属科室</th>
										<th>资源类型</th>
									</tr>
									
									<s:subset source="initMap.shoucangList" start="0" count="10">
										<s:iterator id="l" status="newsIndex">
										<tr>
											<td>${l.rfName}</td>
											<td>${l.rfSort}</td>
											<td>${l.rfResType}</td>
										</tr>
										</s:iterator>
									</s:subset>
								
								</table>
						</div>
					</td>
				  </tr>
				</table>	
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
				  <tr bgcolor="#ae9b84">
					<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
						<div>
						<table>
									<tr>
										<th>资源名称</th>
										<th>所属科室</th>
										<th>资源类型</th>
									</tr>
									
									<s:subset source="initMap.tuijianList" start="0" count="10">
										<s:iterator id="l" status="newsIndex">
										<tr>
											<td>${l.content}</td>
											<td>${l.tableName}</td>
											<td>${l.type}</td>
										</tr>
										</s:iterator>
									</s:subset>
								
								</table>
						</div>
					</td>
				  </tr>
				</table>	
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
				  <tr bgcolor="#ae9b84">
					<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
						<div>
						<table>
									<tr>
										<th>资源名称</th>
										<th>所属科室</th>
										<th>资源类型</th>
									</tr>
									
									<s:subset source="initMap.shangchuanList" start="0" count="10">
										<s:iterator id="l" status="newsIndex">
										<tr>
											<td>${l.rName}</td>
											<td>${l.rTable}</td>
											<td>${l.rType}</td>
										</tr>
										</s:iterator>
									</s:subset>
								
								</table>
						</div>
					</td>
				  </tr>
				</table>					
			</div>						
			</td>
	     </tr>
	</table>
	</div>
</div>

</body>
</html>