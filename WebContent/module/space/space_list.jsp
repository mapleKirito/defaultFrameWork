<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>数字生物馆</title>
<SCRIPT type=text/javascript src="space/jquery.js"></SCRIPT>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
</head>
<body>
<input type="hidden" id="tagName" value="${paramMap.tag }">
<input type="hidden" id="list_start" value="10">
<div>
	<select id="resTypeSelect" class="inpBtn-Gray12" style="height: 30px;">
		<option value="all">===选择科室类别===</option>
		<option value="exhibition">陈列室</option>
		<option value="observation">观察室</option>
		<option value="laboratory">实验室</option>
		<option value="projection">放映室</option>
		<option value="expand" ${(s_userType=='2'&&paramMap.tag=='res')?'selected':''}>拓展室</option>
		<option value="all">全部</option>
	</select>
	<script type="text/javascript">
	if("${s_userType}"==2&&$("#tagName").val()=="res"){
		$("#resTypeSelect").attr("disabled",true);
		$("#res_add").attr("disabled",false).css({"cursor":"pointer"}).removeClass("inpBtn-Gray12").addClass("inpBtn-Blue12");
	}
	
	$("#resTypeSelect").die().live("change",function(){
		$("#res_create").html("努力加载中。。。。");
		var t=$(".list_more");
		$("#ul_lists").show();
		$("#res_create").hide();
		$("#space_frame").hide();
		var choose=$(this).val(); 
		var tableList=["exhibition","observation","laboratory","projection","expand"];
		if("${s_userType}"==2){
			tableList=["expand"];
			
		}
		//alert($("#tagName").val()=="res"&&$.inArray(choose,tableList)>=0);
		if($("#tagName").val()=="res"&&$.inArray(choose,tableList)>=0){
			$("#res_add").attr("disabled",false).css({"cursor":"pointer"}).removeClass("inpBtn-Gray12").addClass("inpBtn-Blue12");
		}else{
			$("#res_add").attr("disabled",true).css({"cursor":"default"}).removeClass("inpBtn-Blue12").addClass("inpBtn-Gray12");
		}
		var currentTime= new Date().getTime();
		$.ajax({
			url:		"ajaxAction.action?code=-6002&paramMap.space_id="+$("#space_id").val()+"&paramMap.tag="+$("#tagName").val()+"&paramMap.tableName="+choose+"&suiji="+currentTime,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
/* 					alert(jsonData.list.length); */
					var html="";
					var content_html="";
					var pcode;
					var pname;
					if(jsonData.list.length<=0){
						html="<LI>&nbsp;&nbsp;暂无动态 </LI>";
					}
					
						
						for(var i=0;i<jsonData.list.length;i++){
							if(jsonData.list[i].tableName=="exhibition"){
								pname="erID";
								if(jsonData.list[i].type=="1011"){
									pcode="-0051011009";
								}
							}else if(jsonData.list[i].tableName=="observation"){
								pname="orID";
								if(jsonData.list[i].type=="1011"){
									pcode="-0051012009";
								}
								else if(jsonData.list[i].type=="4033"){
									pcode="-0051012014";
								}
								else if(jsonData.list[i].type=="1073"||jsonData.list[i].type=="1084"){
									pcode="-0051012010";
								}
							}else if(jsonData.list[i].tableName=="laboratory"){
								pname="lrID";
								if(jsonData.list[i].type=="1011"){
									pcode="-0051013009";
								}
								else if(jsonData.list[i].type=="2041"||jsonData.list[i].type=="2033"||jsonData.list[i].type=="2055"){
									pcode="-0051013013";
								}
								else if(jsonData.list[i].type=="1073"||jsonData.list[i].type=="1084"){
									pcode="-0051013010";
								}
							}else if(jsonData.list[i].tableName=="projection"){
								pname="prID";
								if(jsonData.list[i].type=="1073"||jsonData.list[i].type=="1084"){
									pcode="-0051014010";
								}
							}else if(jsonData.list[i].tableName=="expand"){
								pname="erID";
								if(jsonData.list[i].type=="1011"){
									pcode="-0051015011";
								}
								else if(jsonData.list[i].type=="1073"||jsonData.list[i].type=="1084"){
									pcode="-0051015012";
								}
								else if(jsonData.list[i].type=="2041"||jsonData.list[i].type=="2033"||jsonData.list[i].type=="2055"){
									pcode="-0051015013";
								}
							}
							
							content_html='<a target="_blank" href="decorateForwardAction.action?code='+pcode+'&paramMap.roomtype='+jsonData.list[i].tableName+'&paramMap.'+pname+'='+jsonData.list[i].rID+'&paramMap.st=1">'
					  				+jsonData.list[i].content
				  			+'</a>';
				  		var del="";
				  		var modify="";
				  		var rf="";
						if($("#tagName").val()=="favoriteRes"){
							rf="data-rfId="+jsonData.list[i].rfId;
						}
				  		if($("#tagName").val()=="res"){
				  			modify='&nbsp<A class=modify href="javascript:void(0);" data-state="modify"  data-restype="'+jsonData.list[i].type+'" data-resid="'+jsonData.list[i].rID+'" data-tablename="'+jsonData.list[i].tableName+'" data-resname="'+jsonData.list[i].content+'">修改</A>';
				  		}
				  		if($("#tagName").val()!="like"&&!($("#tagName").val()=="res"&&jsonData.list[i].rcheck==1)){
				  			del='<DIV class=mFun>'+
				  			'<A class=feed_opt href="javascript:void(0)">'+
			  				'<EM class=btn_ldrop></EM>'+
			  			'</A>'+
				  		'<DIV class=mFunDrop>'+
				  		'<A class=list_del_btn href="javascript:void(0);" '+rf+' data-status="ini" data-restype="'+jsonData.list[i].type+'" data-resid="'+jsonData.list[i].rID+'" data-tablename="'+jsonData.list[i].tableName+'" data-resname="'+jsonData.list[i].content+'">移除</A>'+
				  		modify+
				  		'</DIV>'+
			  		'</DIV>';
				  		}
						html+='<LI class="clearfix " >'+
				  		del+
				  		'<DIV class=userPic>'+
				  		'<A target="_blank" href="decorateForwardAction.action?code='+pcode+'&paramMap.roomtype='+jsonData.list[i].tableName+'&paramMap.'+pname+'='+jsonData.list[i].rID+'&paramMap.st=1">'+
				  				'<IMG src="'+jsonData.list[i].Thumbnail+'" width=70 height=70>'+
				  			'</A>'+
				  		'</DIV>'+
				  		'<DIV class=msgBox>'+
					  		'<DIV class=userName>'+
					  			'<STRONG>'+
					  				content_html+	
					  			'</STRONG>'+
					  		'</DIV>'+
					  		'<DIV class="msgCnt f14">'+'<A class=blue href="javascript:void(0)"></A>'+'</DIV>'+
					  		'<DIV style="PADDING-TOP: 5px" class=msgImg></DIV>'+
					  		'<DIV class="pubInfo clearfix">'+
					  			'<SPAN class=fl>'+jsonData.list[i].time+'</SPAN>'+
					  			'<SPAN class=fr>'+
					  			'</SPAN> '+
					  		'</DIV>'+
				  		'</DIV>'+
				  	'</LI>';
					}
					$("#sdList").html(html);
				
				if(jsonData.list.length>=10){
					$("#list_start").val(parseInt($("#list_start").val())+10);
					t.data("status","ini");
					t.html('更多消息');
				}else{
					t.data("status","end");
					t.html('已经全部加载，没有更多了^o^');
				}	
				
				}
			},
			
			error:function(request,textStatus,error){}
		});
	});
	</script>
	&nbsp
	<input id="res_add" disabled="disabled" style="cursor:default;${paramMap.tag=='res'?'':'display:none' };"type="button" class="inpBtn-Gray12" value="添加">
	<script type="text/javascript">
	$("#res_add").die().live("click",function(){
		//alert($("#resTypeSelect").val());
		//$("#ul_lists").hide();
		if($("#resTypeSelect").val() == "exhibition") {
			parent.Cheight(1300);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001001");
			//location.href="decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001001";
			//$("#res_create").load("decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001001");
			$("#ul_lists").hide();
			$("#space_frame").show();
		}else if($("#resTypeSelect").val() == "observation") {
			parent.Cheight(970);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001002");
			//$("#res_create").load("decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001002");
			$("#ul_lists").hide();
			$("#space_frame").show();
		}else if($("#resTypeSelect").val() == "laboratory") {
			parent.Cheight(1160);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001003");
			//$("#res_create").load("decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001003");
			$("#ul_lists").hide();
			$("#space_frame").show();
		}else if($("#resTypeSelect").val() == "projection") {
			parent.Cheight(750);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001004");
			//$("#res_create").load("decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001004");
			$("#ul_lists").hide();
			$("#space_frame").show();
		}else if($("#resTypeSelect").val() == "expand") {
			parent.Cheight(1150);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001005");
			//$("#res_create").load("decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001005");
			$("#ul_lists").hide();
			$("#space_frame").show();
		}
	});
	</script>
</div>
<div id="ul_lists">
<UL id="sdList" class="talkList clearfix weibo_talkList">
	<s:if test="initMap.sl.isEmpty()">
		<LI>&nbsp;&nbsp;暂无动态 </LI>
	</s:if>
	<s:iterator value="initMap.sl" id="list" status="fvindx">
	<LI class="clearfix" >
	<s:if test="#list.tableName=='exhibition'">
						  		<s:set name="pcode" value="'003011011'" />
	                   			<s:set name="pname" value="'erID'" />
	                   			<s:if test="#list.type == '1011'">
	                   				<s:set name="pcode" value="'-0051011009'" />
	                   			</s:if>
                   			</s:if>
                   			<s:if test="#list.tableName=='observation'">
						  		<s:set name="pcode" value="'003011011'" />
	                   			<s:set name="pname" value="'orID'" />
	                   			<s:if test="#list.type == '1011'|| #list.type == '1022'">
	                   				<s:set name="pcode" value="'-0051012009'" />
	                   			</s:if>
	                   			<s:if test="#list.type == '4033'">
	                   				<s:set name="pcode" value="'-0051012014'" />
	                   			</s:if>
	                   			<s:if test="#list.type == '1073'||#list.type == '1084'">
	                   				<s:set name="pcode" value="'-0051012010'" />
	                   			</s:if>
	                   			<s:if test="#list.type == '2041'||#list.type == '2033'||#list.type == '2055'">
	                   				<s:set name="pcode" value="'-0051013013'" />
	                   			</s:if>
                   			</s:if>
                   			<s:if test="#list.tableName=='laboratory'">
	                   			<s:set name="pname" value="'lrID'" />
	                   			<s:if test="#list.type == '1011'|| #list.type == '1022'">
	                   				<s:set name="pcode" value="'-0051013009'" />
	                   			</s:if>
	                   			<s:if test="#list.type == '1073'||#list.type == '1084'">
	                   				<s:set name="pcode" value="'-0051013010'" />
	                   			</s:if>
	                   			<s:if test="#list.type == '2041'||#list.type == '2033'||#list.type == '2055'">
	                   				<s:set name="pcode" value="'-0051013013'" />
	                   			</s:if>
	                   			<s:if test="#list.type == '2002'">
	                   				<s:set name="pcode" value="'-0051013011'" />
	                   			</s:if>
                   			</s:if>
                   			<s:if test="#list.tableName=='projection'">
						  		<s:set name="pcode" value="'003011011'" />
	                   			<s:set name="pname" value="'prID'" />
	                   			<s:if test="#list.type == '1073'||#list.type == '1084'">
	                   				<s:set name="pcode" value="'-0051014010'" />
	                   			</s:if>
                   			</s:if>
                   			<s:if test="#list.tableName=='expand'">
						  		<s:set name="pcode" value="'003011011'" />
	                   			<s:set name="pname" value="'erID'" />
	                   			<s:if test="#list.type == '1011'|| #list.type == '1022'">
	                   				<s:set name="pcode" value="'-0051015011'" />
	                   			</s:if>
	                   			<s:if test="#list.type == '1073'||#list.type == '1084'">
	                   				<s:set name="pcode" value="'-0051015012'" />
	                   			</s:if>
	                   			<s:if test="#list.type == '2041'||#list.type == '2033'||#list.type == '2055'">
	                   				<s:set name="pcode" value="'-0051015013'" />
	                   			</s:if>
	                   			<s:if test="#list.type == '2095'">
	                   				<s:set name="pcode" value="'-0051015014'" />
	                   			</s:if>
                   			</s:if>
	<s:if test="paramMap.tag!='like'&&!(paramMap.tag=='res'&&#list.rcheck==1) ">
	<DIV class=mFun>
				  			<A class=feed_opt href="javascript:void(0)">
				  				<EM class=btn_ldrop></EM>
				  			</A>
					  		<DIV class=mFunDrop>
					  			<A class=list_del_btn href="javascript:void(0);"  data-rfId="${list.rfId }"  data-status="ini" data-resType="${list.type }" data-resID="${list.rID}" data-tableName="${list.tableName }" data-resName="${list.content }">
					  			移除</A>
					  			<s:if test="paramMap.tag=='res'">
					  			&nbsp
					  			<A class=modify href="javascript:void(0);" data-state="modify" data-resType="${list.type }" data-resID="${list.rID}" data-tableName="${list.tableName }" data-resName="${list.content }">
					  			修改</A>
					  			</s:if>
					  		</DIV>
				  		</DIV>
	</s:if>
				  		<DIV class=userPic>
				  			<a target="_blank" href="decorateForwardAction.action?code=${pcode}&paramMap.roomtype=${list.tableName }&paramMap.${pname}=${list.rID}&paramMap.st=1">
				  				<IMG src="${list.Thumbnail }" width=70 height=70>
				  			</A>
				  		</DIV>
				  		<DIV class=msgBox>
					  		
                   			<DIV class=resName>
					  			<STRONG>
					  				<a target="_blank" href="decorateForwardAction.action?code=${pcode}&paramMap.roomtype=${list.tableName }&paramMap.${pname}=${list.rID}&paramMap.st=1">
					  				${list.content }
					  				</a>
					  			</STRONG>
					  		</DIV>
					  		<DIV class="msgCnt f14">
					  			<A class=blue href="#${list.type }"><%-- ${list.userName } --%></A>
					  		</DIV>
					  		<DIV style="PADDING-TOP: 5px" class=msgImg></DIV>
					  		<DIV class="pubInfo clearfix">
					  			<SPAN class=fl>${list.time }</SPAN>
					  			<SPAN class=fr>
					  			</SPAN> 
					  		</DIV>
				  		</DIV>
				  	</LI>
		</s:iterator>
</UL>
	<s:if test="initMap.sl.isEmpty()">
		
	</s:if>
	<s:else >
		<p class="tc pdb10" style="padding:20px 0;">
			<a href="javascript:void(0);" class="inpGray-3 list_more"  id="more" data-status="ini">更多消息</a>
		</p>
	</s:else>

<script type="text/javascript">
//更多按钮
$(".list_more").die().live("click",function(){
	var t = $(this);
	var status = $(this).data("status");
	if(status=="ini"){
		t.data("status","getting");
		var currentTime= new Date().getTime();
		$(this).html('加载中，请稍等...');
		$("#more").removeClass("list_more");
		//ajax调用vc
		$.ajax({
			url:		"ajaxAction.action?code=-600503&paramMap.space_id="+$("#space_id").val()+"&paramMap.tag="+$("#tagName").val()+"&paramMap.tableName="+$("#resTypeSelect").val()+"&paramMap.s_start="+$("#list_start").val()+"&paramMap.s_end=10&suiji="+currentTime,
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
							//alert(jsonData.list.length);
							if(jsonData.list[i].tableName=="exhibition"){
								pname="erID";
								if(jsonData.list[i].type=="1011"){
									pcode="-0051011009";
								}
							}else if(jsonData.list[i].tableName=="observation"){
								pname="orID";
								if(jsonData.list[i].type=="1011"){
									pcode="-0051012009";
								}
								else if(jsonData.list[i].type=="4033"){
									pcode="-0051012014";
								}
								else if(jsonData.list[i].type=="1073"||jsonData.list[i].type=="1084"){
									pcode="-0051012010";
								}
							}else if(jsonData.list[i].tableName=="laboratory"){
								pname="lrID";
								if(jsonData.list[i].type=="1011"){
									pcode="-0051013009";
								}
								else if(jsonData.list[i].type=="2041"||jsonData.list[i].type=="2033"||jsonData.list[i].type=="2055"){
									pcode="-0051013013";
								}
								else if(jsonData.list[i].type=="1073"||jsonData.list[i].type=="1084"){
									pcode="-0051013010";
								}
							}else if(jsonData.list[i].tableName=="projection"){
								pname="prID";
								if(jsonData.list[i].type=="1073"||jsonData.list[i].type=="1084"){
									pcode="-0051014010";
								}
							}else if(jsonData.list[i].tableName=="expand"){
								pname="erID";
								if(jsonData.list[i].type=="1011"){
									pcode="-0051015011";
								}
								else if(jsonData.list[i].type=="1073"||jsonData.list[i].type=="1084"){
									pcode="-0051015012";
								}
								else if(jsonData.list[i].type=="2041"||jsonData.list[i].type=="2033"||jsonData.list[i].type=="2055"){
									pcode="-0051015013";
								}
							}
							
							content_html='<a target="_blank" href="decorateForwardAction.action?code='+pcode+'&paramMap.roomtype='+jsonData.list[i].tableName+'&paramMap.'+pname+'='+jsonData.list[i].rID+'&paramMap.st=1">'
					  				+jsonData.list[i].content
				  			+'</a>';
							var del="";
							var modify="";
							var rf="";
							if($("#tagName").val()=="favoriteRes"){
								rf="data-rfId="+jsonData.list[i].rfId;
							}
					  		if($("#tagName").val()=="res"){
					  			modify='&nbsp<A class=modify href="javascript:void(0);" data-state="modify"  data-restype="'+jsonData.list[i].type+'" data-resid="'+jsonData.list[i].rID+'" data-tablename="'+jsonData.list[i].tableName+'" data-resname="'+jsonData.list[i].content+'">修改</A>';
					  		}
					  		if($("#tagName").val()!="like"&&!($("#tagName").val()=="res"&&jsonData.list[i].rcheck==1)){
					  			del='<DIV class=mFun>'+
					  			'<A class=feed_opt href="javascript:void(0)">'+
				  				'<EM class=btn_ldrop></EM>'+
				  			'</A>'+
					  		'<DIV class=mFunDrop>'+
					  		'<A class=list_del_btn href="javascript:void(0);" '+rf+' data-status="ini"  data-restype="'+jsonData.list[i].type+'" data-resid="'+jsonData.list[i].rID+'" data-tablename="'+jsonData.list[i].tableName+'" data-resname="'+jsonData.list[i].content+'">移除</A>'+
					  		modify+
					  		'</DIV>'+
				  		'</DIV>';
					  		}	
						html+='<LI class="clearfix " >'+
				  		del+
				  		'<DIV class=userPic>'+
				  		'<A target="_blank" href="decorateForwardAction.action?code='+pcode+'&paramMap.roomtype='+jsonData.list[i].tableName+'&paramMap.'+pname+'='+jsonData.list[i].rID+'&paramMap.st=1">'+
				  				'<IMG src="'+jsonData.list[i].Thumbnail+'" width=70 height=70>'+
				  			'</A>'+
				  		'</DIV>'+
				  		'<DIV class=msgBox>'+
					  		'<DIV class=userName>'+
					  			'<STRONG>'+
					  				'<A class=blue href="javascript:void(0)">'+content_html+'</A>'+
					  			'</STRONG>'+
					  		'</DIV>'+
					  		'<DIV class="msgCnt f14">'+'<A class=blue href="javascript:void(0)"></A>'+'</DIV>'+
					  		'<DIV style="PADDING-TOP: 5px" class=msgImg></DIV>'+
					  		'<DIV class="pubInfo clearfix">'+
					  			'<SPAN class=fl>'+jsonData.list[i].time+'</SPAN>'+
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
						$("#list_start").val(parseInt($("#list_start").val())+10);
						t.data("status","ini");
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
		})
		
	}
});	
//删除
$(".list_del_btn").die().live("click",function(){
	var resID = $(this).data("resid");
	var tableName = $(this).data("tablename");
	var resName = $(this).data("resname");
	resName=encodeURI(encodeURI(resName));
	var resType = $(this).data("restype");
	var rfid = $(this).data("rfid");
	var tmpLi=$(this);
	var status = $(this).data("status");
	if(status=="ini"){
		tmpLi.data("status","doing");
		if(confirm("确定移除吗?")){
			var currentTime= new Date().getTime();
			$.ajax({
				url:		"ajaxAction.action?code=-006102&paramMap.tableName="+tableName+"&paramMap.rfId="+rfid+"&paramMap.resType="+resType+"&paramMap.resName="+resName+"&paramMap.resID="+resID+"&suiji="+currentTime+"&paramMap.tag="+$("#tagName").val(),
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					
					if(jsonData.rslt>0){
						//alert(tmpLi.parent().parent().parent().html());
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
$(".modify").die().live("click",function(){
	var m=$(this);
	var state=$(this).data("state");
	var id=$(this).data("resid");
	var tableName=$(this).data("tablename");
	//alert(state+"\n"+id+"\n"+tableName);
	if(state=="modify"){
		if(tableName == "exhibition") {
			parent.Cheight(1300);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001006&paramMap.erID="+id);
			$("#ul_lists").hide();
			$("#space_frame").show();
		}else if(tableName == "observation") {
			parent.Cheight(900);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001007&paramMap.orID="+id);
			$("#ul_lists").hide();
			$("#space_frame").show();
		}else if(tableName == "laboratory") {
			parent.Cheight(1160);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001008&paramMap.lrID="+id);
			$("#ul_lists").hide();
			$("#space_frame").show();
		}else if(tableName == "projection") {
			parent.Cheight(750);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001009&paramMap.prID="+id);
			$("#ul_lists").hide();
			$("#space_frame").show();
		}else if(tableName == "expand") {
			parent.Cheight(1150);
			$("#cont").attr("src","decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-006104001010&paramMap.erID="+id);
			$("#ul_lists").hide();
			$("#space_frame").show();
		}
	}
});
</script>
</div>
<div id="ans" style="display: none;">努力加载中。。。。</div>
<div id="res_create" style="display: none;">努力加载中。。。。</div>
<div id="space_frame" style="display: none;"><IFRAME id="cont" name="left" frameBorder=0 scrolling=no src="" width="100%" ></IFRAME></div>
<div id="preload" style="display: none;"></div>
</body>
</html>