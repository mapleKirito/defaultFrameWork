<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><s:text name="systemName"/></title>
<link href="qc/css/style.css" rel="stylesheet" />
<link href="qc/css/calendar.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script src="qc/js/scripts.js"></script>
<script type="text/javascript">
$(function(){
	$(".mem_remove").die().live("click",function(){
		var uid=$(this).attr("uid");
		var liObj=$(this);
		if(confirm("确定要解散该小组吗")){
			$.ajax({
				url:		'ajaxAction.action?code=00203200207&paramMap.tID='+uid,
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					if (textStatus == "success"){
						if(jsonData.flag>0){
							//alert("删除成功！");
							liObj.parent().remove();
							window.location.href="decorateForwardAction.action?code=${pmsIndex.myTeam.code}&paramMap.userID=${s_userID}&suijichileren="+new Date();
						}
					}
				}
			}); 
		}
		
	})
	
})


	/*解决头像显示问题*/
    
    /* 	$(document).ready(function(){
		    $('.groups img').each(function(){               
		        if($(this).attr('src')==''){                   
		            $(this).attr('src','images/default/default_team.jpg');               
		        }           
		    });                   
		});  */

		function noPermission(){
    		alert("对不起，您还未加入该小组，请加入后重试！");
    	}
</script>
<style type="text/css">
.mem_class{
position: relative;
}
.mem_remove{
position: absolute;
right: 6px;
top: 4px;
color: #ea183f;
font-size: 12px;
cursor:pointer;
}
.mem_applying{
position: absolute;
right: 6px;
top: 4px;
color: #ea183f;
font-size: 12px;
}
</style>
</head>
<body>
	<div id="layout_mainbody">
		<div class="my-article panel" style="margin-top: 0px">
			<p class="title topborder">
				我的小组<span><a
					href="decorateForwardAction.action?code=00203200206">创建</a> </span>
			</p>
			<div class="body">
				<ul class="groups">
					<s:iterator id="t" value="initMap.teamList">
						<li class="mem_class"><s:if
								test="#t.createrID==#session.s_userID">
								<div uid="${t.tID }" class="mem_remove">解散小组</div>
							</s:if> 
							<s:if test="#t.joinState==0">
								<div uid="${t.tID }" class="mem_applying">待审核</div>
							</s:if>
							<a target="_parent"
							<s:if test="#t.joinState==0&&#t.isPublic==0"> href="javascript:;" onclick="noPermission();" </s:if>
												
													<s:else> href="decorateForwardAction.action?code=00203200201&paramMap.tID=${t.tID }"</s:else>
													
							class="left"> <img src="${t.userImg}" alt="images/default/default_team.jpg" onerror="this.src='images/default/default_team.jpg'" width="64" height="64" />
						</a>
							<div class="right">
								<h5>
									<a title="${t.tName }" target="_parent" href="decorateForwardAction.action?code=00203200201&paramMap.tID=${t.tID }" >
									 <s:if test="#t.tName.length() > 5">
														 <s:property value="#t.tName.substring(0,5)" /> ...
								                     </s:if> <s:else>
															 <s:property value="#t.tName" />
													 </s:else>

								</a>
								</h5>
								<p>
									创建人：<em><a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${t.createrID }">${t.tUserName }</a></em>
								</p>
								<p>
									当前人数：<span class="red">${t.peoples}</span>
								</p>
							</div>
						</li>
					</s:iterator>
				</ul>
			</div>
			<div class="pageb" id="table3page" style="margin-right: 20px;">
				${initMap.paginated.pageContent}</div>
		</div>
	</div>
	<script type="text/javascript">
$(document).ready(function () {
	$('#table3page').pageTB();

})
</script>
</body>
</html>