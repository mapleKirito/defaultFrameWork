<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>数字生物馆</title>
<SCRIPT type=text/javascript src="space/jquery.js"></SCRIPT>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
</head>
<script type="text/javascript">
$(function(){
	CKEDITOR.appendTo( 'preload' );
});
</script>
<body>
<input type="hidden" id="tagName" value="${paramMap.tag }">
<input type="hidden" id="userID" value="${session.s_userID }">
<input type="hidden" id="list_start" value="10">
<div>
	<input id="res_add"  style="cursor:pointer;height: 30px;" type="button" class="inpBtn-Blue12" value="发表文章">
	<script type="text/javascript">
	$("#res_add").click(function(){
		//alert($("#resTypeSelect").val());
		//$("#ul_lists").hide();
			//location.href="decorateForwardAction.action?code=-006104001001";
			/* $.get("decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-600701",function(data){ //初始將a.html include div#iframe
				$("#res_create").html(data);
			});  */
			parent.Cheight(500);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-600701");
			//location.href="decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-600701";
			//$("#res_create").load("decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-600701");
			$("#ul_lists").hide();
			$("#space_frame").show();
	});
	</script>
</div>
<div id="ul_lists">
<UL id="sdList" class="talkList clearfix weibo_talkList">
	<s:if test="initMap.wl.isEmpty()">
		<LI>&nbsp;&nbsp;暂无动态 </LI>
	</s:if>
	<s:iterator value="initMap.wl" id="list" status="fvindx">
	<LI class="clearfix" >
	<DIV class=mFun>
				  			<A class=feed_opt href="javascript:void(0)">
				  				<EM class=btn_ldrop></EM>
				  			</A>
					  		<DIV class=mFunDrop>
					  			<A class=write_del_btn href="javascript:void(0);"  data-status="ini" data-wID="${list.wID}" data-resName="${list.wTitle }">
					  			删除文章</A>
					  		</DIV>
				  		</DIV>
				  		<DIV class=msgBox>
                   			<DIV class=resName>
					  			<STRONG>
					  			<a target="_blank" href="decorateForwardAction.action?code=-00505&paramMap.userID=${session.s_userID }&paramMap.wID=${list.wID }&paramMap.st=1">
					  				${list.wTitle }
					  				</a>
					  			</STRONG>
					  		</DIV>
					  		<DIV style="PADDING-TOP: 5px" class=msgImg></DIV>
					  		<DIV class="pubInfo clearfix">
					  			<SPAN class=fl>${list.wTime }</SPAN>
					  			<SPAN class=fr>
					  			</SPAN> 
					  		</DIV>
				  		</DIV>
				  	</LI>
		</s:iterator>
</UL>
<s:else>
	<p class="tc pdb10" style="padding:20px 0;">
		<a href="javascript:void(0);" class="inpGray-3 list_more"  id="more" data-status="ini">更多文章</a>
    </p>
</s:else>

<script type="text/javascript">
//更多按钮
$(".list_more").die().live("click",function(){
	var t = $(this);
	var status = $(this).data("status");
	t.data("status","getting");
	if(status=="ini"){
		var currentTime= new Date().getTime();
		$(this).html('加载中，请稍等...');
		$("#more").removeClass("list_more");
		//ajax调用vc
		$.ajax({
			url:		"ajaxAction.action?code=-600702&paramMap.space_id="+$("#space_id").val()+"&paramMap.s_start="+$("#list_start").val()+"&suiji="+currentTime,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
					//动态更新
					var html="";
					var content_html="";
					var pcode;
					var pname;
					if(jsonData.list.length>0){
						
						for(var i=0;i<jsonData.list.length;i++){
							content_html='<a target="_blank" href="decorateForwardAction.action?code=-00505&&paramMap.userID='+$("#userID").val()+'&paramMap.wID='+jsonData.list[i].wID+'&paramMap.st=1">'
					  				+jsonData.list[i].wTitle
				  			+'</a>';
				  			
						html+='<LI class="clearfix " >'+
				  		'<DIV class=mFun>'+
				  			'<A class=feed_opt href="javascript:void(0)">'+
				  				'<EM class=btn_ldrop></EM>'+
				  			'</A>'+
				  		'<DIV class=mFunDrop>'+
				  			'<A class=write_del_btn href="javascript:void(0);"  data-wID="'+jsonData.list[i].wID+'" data-resName="'+jsonData.list[i].wTitle+'">'+
				  			'删除文章</A>'+
				  		'</DIV>'+
				  		'</DIV>'+
				  		'<DIV class=msgBox>'+
					  		'<DIV class="msgCnt f14">'+content_html+'</DIV>'+
					  		'<DIV style="PADDING-TOP: 5px" class=msgImg></DIV>'+
					  		'<DIV class="pubInfo clearfix">'+
					  			'<SPAN class=fl>'+jsonData.list[i].wTime+'</SPAN>'+
					  			'<SPAN class=fr>'+
					  			'</SPAN> '+
					  		'</DIV>'+
				  		'</DIV>'+
				  	'</LI>';
					}
					$("#sdList").append(html);
					$("#more").addClass("list_more");
					}else{
						t.data("status","end");
						t.html('已经全部加载，没有更多了^o^');
					}
					if(jsonData.list.length>=10){
						t.data("status","ini");
						$("#list_start").val(parseInt($("#list_start").val())+10);
						t.html('更多消息');
					}else{
						t.data("status","end");
						t.html('已经全部加载，没有更多了^o^');
					}
				/* else{
					t.data("status","end");
					t.html('已经全部加载，没有更多了^o^');
				} */
			}
		});
		
	}
});	
//删除
$(".write_del_btn").die().live("click",function(){
	var wID = $(this).data("wid");
	var resName = $(this).data("resname");
	var tmpLi=$(this);
	var status = $(this).data("status");
	tmpLi.data("status","doing");
	if(status=="ini"){
		if(confirm("确定移除吗?")){
			var currentTime= new Date().getTime();
			$.ajax({
				url:		"ajaxAction.action?code=-600704&paramMap.resName="+resName+"&paramMap.wID="+wID+"&suiji="+currentTime+"&paramMap.tag="+$("#tagName").val(),
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					if(jsonData.rslt>0){
						tmpLi.parent().parent().parent().remove();
					}else{
						alert("移除失败");
					}
				}
			});
			
		}
		tmpLi.data("status","ini");
	}
	
});
</script>
</div>
<!-- <div id="res_create" style="display: none;">努力加载中。。。。</div> -->
<div id="ans" style="display: none;">努力加载中。。。。</div>
<div id="space_frame" style="display: none;height:500px;"><IFRAME id="cont" height="100%" name="left" frameBorder=0 scrolling=no src="" width="100%" ></IFRAME></div>
<div id="preload" style="display: none;"></div>
</body>
</html>