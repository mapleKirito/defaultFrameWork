<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><s:text name="systemName"/></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link href="qc/css/style.css" rel="stylesheet" />
<link href="qc/css/calendar.css" rel="stylesheet" />
<script src="qc/js/scripts.js"></script>
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
.bAttented{
position: absolute;
right: 6px;
top: 4px;
color: #ea183f;
font-size: 12px;
cursor:pointer;
}
.mem_add{
color: #ea183f;
cursor:pointer;
}
#addMember{
width: 600px;
height:400px;
top: 69px;
background: #fff;
position: absolute;
}
</style>

<script type="text/javascript">
$(function(){
	$("#mem_serach").click(function(){
		var name=$("#mem_key").val();
		name=encodeURI(encodeURI(name));
		//alert(name);
		$.ajax({
			url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=002032004002&paramMap.name='+name,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},//ajax执行前调用函数
			complete:function(request,textStatus){},//ajax请求完成后调用函数
			success:function(jsonData,textStatus){//ajax请求成功调用函数
				if (textStatus == "success"){
					//alert(jsonData.list.length);
					$(".tInfo").remove();
					if(jsonData.list.length==0){
						var tr=$("<tr height='100px;' class='tInfo'></tr>");
						var td=$("<td></td>");
						//td.append("<a href='decorateForwardAction.action?code=-25200&paramMap.userID="+jsonData.list[i].userID+"' >"+jsonData.list[i].userName+"</a>");
						tr.append(td);
						td=$("<td  colspan='2' h>没有查询到相关用户！</td>");
						tr.append(td);
						$("#mTable").append(tr);
					}else{
					for(var i=0;i<jsonData.list.length;i++){
						var qqInfo=jsonData.list[i].qq;
						if(jsonData.list[i].qq==null){
							qqInfo="未设置qq";
						}
						var tr=$("<tr class='tInfo'></tr>");
						var td=$("<td></td>");
						td.append("<img height='40px' width='30px'   src='"+jsonData.list[i].userImg+"' />");
						tr.append(td);
						td=$("<td></td>");
						td.append("<a target='_parent' href='decorateForwardAction.action?code=-25200&paramMap.userID="+jsonData.list[i].userID+"' >"+jsonData.list[i].userName+"</a>");
						tr.append(td);
						td=$("<td></td>");
						td.append(jsonData.list[i].userType==1?'老师':'学生');
						tr.append(td);
						td=$("<td></td>");
						td.append("<a uType='"+jsonData.list[i].userType+"' uQQ='"+qqInfo+"' uName='"+jsonData.list[i].userName+"' uImg='"+jsonData.list[i].userImg+"' uid='"+jsonData.list[i].userID+"' class='mem_add' >添加</a>");
						tr.append(td);
						$("#mTable").append(tr);
					}
					
				}
				}
			},
			//ajax请求错误后调用函数
			error:function(request,textStatus,error){}
		}); 
	})
	
	$(".mem_remove").die().live("click",function(){
		var uid=$(this).attr("uid");
		var liObj=$(this);
		if(confirm("确定要取消关注此用户吗")){
			$.ajax({
				url:		'ajaxAction.action?code=002032004001&paramMap.attentionType=remove&paramMap.targetID='+uid,
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
							//liObj.parent().remove();
							window.location.href="decorateForwardAction.action?code=${pmsIndex.myAttention.code}&paramMap.userID=${s_userID}&suijichileren="+new Date();
						}
					}
				}
			}); 
		}
		
	})
	
	$(".mem_add").die().live("click",function(){
		var uid=$(this).attr("uid");
		var uImg=$(this).attr("uImg");
		if(uImg==''){                   
			uImg='images/default/default_img.jpg';
	    }       
		var uName=$(this).attr("uName");
		var uQQ=$(this).attr("uQQ");
		var uType=$(this).attr("uType");
		var tid=$('#teamid').val();
		var liObj=$(this);
		$.ajax({
			url:		'ajaxAction.action?code=002032004001&paramMap.attentionType=add&paramMap.targetID='+uid,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					//alert(jsonData.flag);
					if(jsonData.flag>0){
						
						//liObj.parent().remove();
						var type="";
						if(uType=="1"){
							type="老师";
						}else if(uType=="2"){
							type="学生";
						}else{
							type="管理员";
						}
						
						var li='<li class="mem_class">'+
							'<div uid="'+uid+'" class="mem_remove">取消关注</div>'+
							'<a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID='+uid+'" class="left">'+
								'<img src="'+uImg+'"   width="64" height="64" />'+
							'</a>'+
							'<div class="right">'+
								'<h5><a href="javascript:void(0)">'+uName+'</a></h5>'+
								"<p>用户身份：<em>"+type+"</em></p>"+
								'<p>qq：<span class="red">'+uQQ+'</span></p>'+
							'</div>'+
						'</li>';
						$("#attentionList .groups").append(li);
						$(".dataEmpty1").hide();
						liObj.parent().parent().remove();
					}
				}
			}
		}); 
	})
	
	$("#addClose").click(function(){
		$("#addMember").hide();
	});
	$("#addOpen").click(function(){
		//alert();
		$("#addMember").css({"left":($(document.body).width()-600)/2+"px"});
		$(".tInfo").remove();
		$("#addMember").show();
	});
	
	$(".tabcontrol .tabtitle a").click(function(){

		var index=$(".tabcontrol .tabtitle a").index(this);
		$(this).addClass("on").siblings().removeClass("on");
		if(index==1){
			$("#attentionList").hide();
			$("#page1").hide();
			$("#addOpen").hide();
			$("#beAttentedList").show();
			$("#page4").show();
			
		}else if(index==0){
			$("#attentionList").show();
			$("#page1").show();
			$("#addOpen").show();
			$("#beAttentedList").hide();
			$("#page4").hide();
		}
		//alert(index);
		//$("#resourceUploadFrameWelcome").attr("src","decorateForwardAction.action?code=" + $(this).attr("id"));
	});

});


/* 修正小组头像的问题 */
$(document).ready(function(){
	
	$('.groups img').each(function(){               
        if($(this).attr('src')==''){                   
            $(this).attr('src','images/default/default_img.jpg');
        }           
    }); 
});


</script>
</head>
<body>
	<div id="layout_mainbody">
	
		<!-- <div class="my-article panel" style="margin-top: 0px"> -->
		<div class="my-article tabcontrol" style="margin-top: 0px;background: white;">
			<input type="hidden" id="userID" value="${session.s_userID }">
			<%-- <p class="title topborder">
				我的关注 
				<span> <a id="addOpen" href="javascript:void(0)">添加</a> </span>
			</p> --%>
			<div class="tabtitle-bg"></div>
                 <p class="tabtitle">
                     <a href="javascript:;" class="tab on">我的关注 </a>
                     <a href="javascript:;" class="tab">谁关注我</a>
                     <span id="addOpen" style="float: right;margin-right: 26px;color: #666666;"><a href="javascript:void(0)">添加</a></span>
                 </p>
			<div class="tabcontents">
				<div id="attentionList" class="tabcontent">
					<ul class="groups">
						<s:iterator id="l" value="initMap.lists1">
							<li class="mem_class">
									<div uid="${l.targetID}" class="mem_remove">取消关注</div>
								<a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.targetID}" class="left"><img
									src="${l.userImg}" onerror="this.src='images/default/default_img.jpg'" width="64" height="64" /> </a>
								<div class="right">
									<%-- <h5>
										<a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.targetID}" >${l.userName}</a>
									</h5> --%>
									
									<!-- 修正用户名过长可能导致的排版问题 -->
									<s:if test="#l.userName.length() gt 6">
	                                	<h5><a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.targetID}" title="${l.userName }"><s:property value="#l.userName.substring(0,5)+'...'" /></a></h5>
                                    </s:if>
                                    <s:else>
	                                    <h5><a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.targetID}" title="${l.userName }"><s:property value="#l.userName" /></a></h5>
	                                </s:else>
									
									
									<p>
										用户身份：<em>${(l.userType==1)?'老师':(l.userType==2?'学生':'管理员')}</em>
									</p>
									<p>
										qq：<span class="red">${(l.qq==null||l.qq=='')?'未设置qq':l.qq}</span>
									</p>
								</div></li>
						</s:iterator>
						<s:if test="initMap.lists1.isEmpty()">
							<p class="dataEmpty1">暂无数据<p>
						</s:if>
					</ul>
				
					
				</div>
				<div id="beAttentedList" class="tabcontent" style="display:none">
					<ul class="groups">
						<s:iterator id="l" value="initMap.lists2">
							<li class="mem_class">
									<%-- <div uid="${l.targetID}" class="bAttented">关注TA</div> --%>
								<a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.userID}" class="left"><img
									src="${l.userImg}" onerror="this.src='images/default/default_img.jpg'" width="64" height="64" /> </a>
								<div class="right">
									<%-- <h5>
										<a  target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.userID}" >${l.userName}</a>
									</h5> --%>
									
									
									<!-- 修正用户名过长可能导致的排版问题 -->
									<s:if test="#l.userName.length() gt 6">
	                                	<h5><a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.targetID}" title="${l.userName }"><s:property value="#l.userName.substring(0,5)+'...'" /></a></h5>
                                    </s:if>
                                    <s:else>
	                                    <h5><a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.targetID}" title="${l.userName }"><s:property value="#l.userName" /></a></h5>
	                                </s:else>
									
									
									<p>
										用户身份：<em>${(l.userType==1)?'老师':(l.userType==2?'学生':'管理员')}</em>
									</p>
									<p>
										qq：<span class="red">${l.qq}</span>
									</p>
								</div></li>
						</s:iterator>
						<s:if test="initMap.lists2.isEmpty()">
							<p class="dataEmpty2">暂无数据<p>
						</s:if>
					</ul>
				
					
				</div>
				<div>
				<div class="pageb" id="page1" style="margin-right: 20px;">
						${initMap.paginated.pageContent}</div>
				<div class="pageb" id="page4" style="margin-right: 20px;display: none;">
						${initMap.paginated2.pageContent}</div>
						</div>
			</div>
		</div>

		
	</div>
	<div id="addMember" class="my-article panel" style="display: none;">
			<p class="title topborder">
				添加关注<span><input type="text" id="mem_key" /><input
					type="button" id="mem_serach" value="查询" />&nbsp&nbsp <a
					id="addClose" href="javascript:void(0)">关闭</a> </span>
			</p>
			<div class="tabcontent" style="text-align: center; overflow-y: auto;">
				<table width="400px" border="0" cellspacing="0" cellpadding="0"
					style="margin: auto; width: 80%;">
					<tr>
						<td colspan="4"
							style="height: 30px; border-bottom: 1px dotted #ffffff;">
							<div>
								<table id="mTable">
									<tr>
									<td style="width: 100px">头像</td>
										<td style="width: 100px">名称</td>
										<td style="width: 100px">类型</td>
										<td style="width: 100px">操作</td>
									</tr>

								</table>
							</div></td>
					</tr>
				</table>
			</div>
		</div>

	<script type="text/javascript">
$(document).ready(function () {
	$('#page1').pageTB();
	$('#page4').pageTB();
})

</script>
</body>
</html>