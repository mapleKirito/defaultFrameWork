<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<html><% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>
<head> 
<style type="text/css"></style>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/htask/common803.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/htask/detail803.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/htask/circle.css" />
<link href="<%=request.getContextPath()%>/qc/css/style.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/qc/css/calendar.css" rel="stylesheet" />
<script type="text/javascript">
var htaskIssplit = '${initMap.testdetailInfo.htaskIssplit}';
document.onreadystatechange = function () {   
    if(document.readyState=="complete") {
    	
    }  
};    
$(document).ready(function() {
	//alert("${session.srUnicomNet}");
	var $tab = $("#tags ul li");
	var thehtaskID = '${paramMap.htaskID}';
	var taskchoosetagindexhref = '${paramMap.taskchoosetagindexhref}' == ''?'1':'${paramMap.taskchoosetagindexhref}';
	
	$("#taskchoosetagindex").val(taskchoosetagindexhref);
	
	//多任务展示
	if(parseInt(htaskIssplit)==1){
		if(taskchoosetagindexhref != ""){
			$tab.eq(taskchoosetagindexhref-1).addClass("selected").siblings().removeClass("selected");
			$("#taskchoosetag").load("decorateForwardAction.action?code=-1895&paramMap.htaskSplitIndex="+(taskchoosetagindexhref)+"&paramMap.htaskID=${paramMap.htaskID}");
			$("#taskchoosetaganswer").load("decorateForwardAction.action?code=-1897&paramMap.htaskSplitIndex="+(taskchoosetagindexhref)+"&paramMap.htaskID=${paramMap.htaskID}");
			$("#best-answer").show().load("decorateForwardAction.action?code=-1899&paramMap.htaskSplitIndex="+(taskchoosetagindexhref)+"&paramMap.htaskID=${paramMap.htaskID}&suiji="+new Date().getTime());
		}else{
			$("#taskchoosetag").load("decorateForwardAction.action?code=-1895&paramMap.htaskSplitIndex="+(1)+"&paramMap.htaskID=${paramMap.htaskID}");
			$("#taskchoosetaganswer").load("decorateForwardAction.action?code=-1897&paramMap.htaskSplitIndex="+(1)+"&paramMap.htaskID=${paramMap.htaskID}");
			$("#best-answer").show().load("decorateForwardAction.action?code=-1899&paramMap.htaskSplitIndex="+(1)+"&paramMap.htaskID=${paramMap.htaskID}&suiji="+new Date().getTime());
		}
	} 
	
	
	$tab.click(function(){
		
		var index = $tab.index(this);
		$("#best-answer").hide();
		var theindex = index;
		if(index == 0){ theindex = 1; }
		$.ajax({
			url:		'ajaxAction.action?code=-12899&paramMap.htaskSplitIndex='+(theindex)+'&paramMap.htaskID='+thehtaskID,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					//alert(jsonData.singleData);
					if(parseInt(jsonData.singleData) > 0){
						$("#taskchoosetagindex").val((index+1));
						$tab.eq(index).addClass("selected").siblings().removeClass("selected");
						$("#taskchoosetag").load("decorateForwardAction.action?code=-1895&paramMap.htaskSplitIndex="+(index+1)+"&paramMap.htaskID="+thehtaskID);
						$("#taskchoosetaganswer").load("decorateForwardAction.action?code=-1897&paramMap.htaskSplitIndex="+(index+1)+"&paramMap.htaskID="+thehtaskID);
						$("#best-answer").load("decorateForwardAction.action?code=-1899&paramMap.htaskSplitIndex="+(index+1)+"&paramMap.htaskID="+thehtaskID);
					}else{
						alert("当前任务选出的最佳答案时，继续回答下一个任务");
					}
				}
			},
			
			error:function(request,textStatus,error){}
		});
	});
	
	var th = '${initMap.testdetailInfo.htaskIsAnswer}';
	//alert(th);
	if(th != ""){
		$("#shmt-5").hide();
		 
	}else{
		$("#shmt-5").show();
		
	}
	
	if(parseInt('${fn:length(initMap.answerAllInfo)}') > 0){
		$("#taskchoosetaganswer").show();
	}	
	$("#answercount").html($(".bd.answer.answer-first").size());
	
	if(parseInt('${fn:length(initMap.answerAcceptInfo)}') > 0){
		$("#best-answer").show();
	}	
	
	$(".bd.answer.answer-first").each(function(i){
		var taIsMeAppend = $(this).find(".replyask-content").children("pre").last().attr("taIsMeAppend");
		if(parseInt(taIsMeAppend)<=0){
			$(this).find(".continue-reply").hide();
			$(this).find(".modify-reply").show();
		}else{
			$(this).find(".continue-reply").show();
			$(this).find(".modify-reply").hide();
		} 
	});
	
	$(".modify-reply").toggle(function(){
		$(this).siblings(".answer-bar-editor-update").show();
		
		var htmleditor = $(this).parents(".answer-first").find(".replyask-content").children("pre").last().html();
		var editormodifyid = $(this).attr("editorsetid");
		CKEDITOR.instances["editormodify"+editormodifyid].setData(htmleditor);
	},function(){
		$(this).siblings(".answer-bar-editor-update").hide();
	});
	
	var concoleCode = "-1892";
	$(".continue-reply").die().live("click", function () {
		//alert(123);
		var $a = $(this).siblings(".answer-bar-editor-update");
		if($a.css("display")=="none"){
			$a.show();
			concoleCode = "-1891";
			
			var htmleditor = $(this).parents(".answer-first").find(".replyask-content").children("pre").last().html();
			var editormodifyid = $(this).attr("editorsetid");
			CKEDITOR.instances["editormodify"+editormodifyid].setData();
		}else{
			$a.hide();
		}
	});
	
	$("#answer-bar").die().live("click",function(){
		var answerbareditor = $("#answer-bar-editor").css("display");
		var answerbarsub = $("#answer-bar-sub").css("display");
		if(answerbareditor=="none" && answerbarsub=="none"){
			$("#answer-bar-editor,#answer-bar-sub").show();
			if("${session.srUnicomNet}"=="1")
				$("#answer-bar-img").attr("src", "images/htask/theup.png").siblings("#answer-bar-search").show();
		}else{
			$("#answer-bar-editor,#answer-bar-sub").hide();
			if("${session.srUnicomNet}"=="1")
				$("#answer-bar-img").attr("src", "images/htask/thedown.png").siblings("#answer-bar-search").hide();
		}
	});
	
	$("#modify-reply-1909588606").toggle(function() {
		$("#answer-bar-editor-by-update").show();
	},
	function() {
		$("#answer-bar-editor-by-update").hide();
	});
	
	$(".btn-32-green-submit").die().live("click",function(){
		concoleCode = "-1891";
		var htaskID = '${paramMap.htaskID}';
		var mhtaskID = "";
		if(parseInt(htaskIssplit)==1){
			mhtaskID = $(this).parent("div").siblings("textarea").attr("manyAnswerID");
		}
		var getAttrID = $(this).parent("div").siblings("textarea").attr("id");
		var rcontent = CKEDITOR.instances[getAttrID].getData() == '' ? false: true;
		var appparam = "&paramMap.taHtaskIndex="+$("#taskchoosetagindex").val();
		if (rcontent) {
			$.ajax({
				url: 'ajaxAction.action?code='+concoleCode+'&paramMap.mhtaskID=' + mhtaskID + '&paramMap.taHtaskID='+'${paramMap.htaskID}&paramMap.taContent=' + CKEDITOR.instances[getAttrID].getData() + '&paramMap.taUserID=' + '${paramMap.s_userID}' + appparam,
				type: 'post',
				timeout: '60000',
				data: Array(),
				dataType: 'json',
				beforeSend: function(request) {},
				complete: function(request, textStatus) {},
				success: function(jsonData, textStatus) {
					if (textStatus == "success") {
						location.href = "decorateForwardAction.action?code=-1890002&paramMap.taskchoosetagindexhref="+$("#taskchoosetagindex").val()+"&paramMap.htaskID=" + htaskID;
					}
				},
				error: function(request, textStatus, error) {}
			});
		} else {
			alert("内容不能为空！！！");
		}	
	});
	
	$(".btn-32-green-submit-modify").die().live("click",function(){
		var htaskID = '${paramMap.htaskID}';
		var taID = '${initMap.testdetailCurrAnsInfo.taID}';
		var mhtaskID = "";
		if(parseInt(htaskIssplit)==1){
			taID = $(this).attr("currentid");
			if(taID == ''){
				taID = $(this).attr("answerid");	
			}
		}
		
		var taParentsID = $(this).attr("answerid");
		
		var getAttrID = $(this).siblings("textarea").attr("id");
		var rcontent = CKEDITOR.instances[getAttrID].getData() == '' ? false: true;
		var appparam = "&paramMap.taHtaskIndex="+$("#taskchoosetagindex").val();
		var answer=CKEDITOR.instances[getAttrID].getData();
		var paramArr=answer.split(""); 
		 for(var i=0;i<=paramArr.length;i++){
			 if("&"==paramArr[i]){
				 paramArr[i]="%26";
			 }
		 }
		var answer_format=paramArr.join(""); 
		//alert( answer_format);
		if (rcontent) {
			$.ajax({
				url: 'ajaxAction.action?code='+concoleCode+'&paramMap.taParentsID=' + taParentsID + '&paramMap.taHtaskID='+'${paramMap.htaskID}&paramMap.taID=' + taID + '&paramMap.taContent='+answer_format+'&paramMap.taUserID=' + '${paramMap.s_userID}' + appparam,
				type: 'post',
				timeout: '60000',
				data: Array(),
				dataType: 'json',
				beforeSend: function(request) {},
				complete: function(request, textStatus) {},
				success: function(jsonData, textStatus) {
					if (textStatus == "success") {
						location.href = "decorateForwardAction.action?code=-1890002&paramMap.taskchoosetagindexhref="+$("#taskchoosetagindex").val()+"&paramMap.htaskID=" + htaskID;
					}
				},
				error: function(request, textStatus, error) {}
			});
		} else {
			alert("内容不能为空！！！");
		}
	});
	
});
</script>
</head>
<body>
<input type="hidden" id="taskchoosetagindex" value="1">
<div id="layout_mainbody" style =" visibility : hidden">	
		<div class="page-container ssjh">
			<div class="ssjh-taskview">
				<div class="left">
					<div class="wgt-ask accuse-response line mb-5  panel" id="wgt-ask">
						<p class="title topborder">问题详细</p>
						<div class="wgt-body"  style="padding: 18px;">
							<h5><span>【题目】</span>${initMap.testdetailInfo.htaskTitle}</h5>
							<div class="line f-aid mb-10" id="ask-info">
								<s:if test="initMap.testdetailInfo.htaskIssplit == 0">
									<span>
										财富值${initMap.testdetailInfo.htaskWealthval}(系统奖励1+悬赏${initMap.testdetailInfo.htaskWealthval-1})
									</span>
									<span class="f-pipe">
										&nbsp;&nbsp;&nbsp;&nbsp;
									</span>
								</s:if>
								<span>
									关键词：${initMap.testdetailInfo.htaskKeywords==""?"暂无关键字":initMap.testdetailInfo.htaskKeywords}
								</span>
								<span style="float: right;">
									提问时间：${initMap.testdetailInfo.htaskCreatetime}
								</span>
							</div>
							<s:if test="initMap.testdetailInfo.htaskIssplit == 1">
								<div class="tabcontents">
									<div class="tabcontent tlfb" style="position: relative;" id="tags">
										<a href="javascript:void(0);" class="fb-task-list-prev"></a>
										<a href="javascript:void(0);" class="fb-task-list-next"></a>
										<ul class="task-list fb">
											<s:iterator value="initMap.htasksort" id="hsid" status="hsindex">
												<s:if test="#hsid.htaskIsAccept == 1"><li><a href="javascript:void(0);" class="completed"><i class="icon-right-arrow-big"></i><em>${hsindex.index+1}</em>已完成</a></li></s:if>
												<s:if test="#hsid.htaskIsAccept == 0"><li><a href="javascript:void(0);" class="uncompleted"><i class="icon-right-arrow-big"></i><em>${hsindex.index+1}</em>未完成</a></li></s:if>
											</s:iterator>
										</ul>
									</div>
								</div>
							</s:if>
							<div class="paddingdiv">
								<h5><span>【问题补充】</span></h5>
								<div class="mt-10 mb-10 f-12 f-gray guide-count-down" style="color: #999;">
									${initMap.testdetailInfo.htaskContent}
								</div>
							</div>
							<div id="taskchoosetag">
								
								<s:if test="#session.s_userType != 3 ">
								<div id="shmt-5">
									<span class="mt-5 mb-10 f-12 f-blue inline-block" id="answer-bar">我来解答</span>
									<img id="answer-bar-img" src="images/htask/theup.png" height="7px" border="0">
									<s:if test="#session.srUnicomNet == 1 ">
									<span id="answer-bar-search">
										<span class="f-pipe f-12 search-relate-pipe">|</span>
										<a class="mb-10 mt-5 search-relate" href="http://www.baidu.com/s?wd=${initMap.testdetailInfo.htaskTitle}" target="_blank"><span></span>搜索资料</a>
									</span>
									</s:if>
									<div class="mt-10 mb-10 f-12 f-gray" id="answer-bar-editor">
										<textarea cols="50"  id="editorAnswer" rows="10"></textarea>
									    <script type="text/javascript">
											  CKEDITOR.replace('editorAnswer',{height : 120, filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
										</script>
										<div id="answer-bar-sub">
											<input type="submit" class="btn-32-green btn-32-green-submit question-submit" value="提交回答" data-old-bg="rgb(230, 71, 71)" style="background-color: rgb(230, 71, 71);">
										</div>
									</div>
								</div>
								</s:if>
							</div>
						</div>
					</div>
					<div class="wgt-best " id="best-answer" style="margin-top: 5px;display: none;">
						<i class="sccpetiamge" style="display: block;margin-left: 18px;float: left;width: 41px;height: 57px;background-image: url('images/asspetimg.png');"></i>
						<p class="title line" style="line-height: 57px;">问题采纳</p>
						<div class="bd answer" id="answer" style="padding: 0px 18px 18px 18px;">
							<div class="line info f-aid">
								<a class="user-name" rel="nofollow"   href="decorateForwardAction.action?code=-25200&paramMap.userID=${fv.taUserID}" title="${fv.taUserAccount }">
											${fv.taUserAccount}
										</a>
							</div>
							<div class="replyask line pt-5 pb-5 readlast">
								<s:iterator value="initMap.answerAcceptInfo" id="fvAccpet" status="fvAccpetindx">
									<s:if test="#fvAccpet.taIsMeAppend != 1 "><div class="reply f-12 grid">回答</div></s:if>
									<s:else><div class="ask f-12 grid">追问</div></s:else>
									<div class="line ml-10" style="margin-left: 40px;">
										<span class="grid-r pos-time">${fvAccpet.taCreateTime}</span>
										<pre>${fvAccpet.taContent}</pre>
									</div>
								</s:iterator>
							</div>
						</div>
					</div>
					<div id="taskchoosetaganswer" class="answer-list-panel panel" style="display: none;">
						<div class="wgt-answers" id="wgt-answers">
							<div class="hd line title topborder-green" id="answerTop" >
								<span class="grid-r f-12" style="float: right;display:none;">
									<span>
										按默认排序
									</span>
									<span class="f-pipe">
										|
									</span>
									<a rel="nofollow" href="javascript:void(0)">
										按时间排序
									</a>
								</span>
								<p class="title line">其它<span id="answercount">0</span>条回答</p>
							</div>
							<s:iterator value="initMap.answerAllInfo" id="fv" status="fvindx">	
								<div class="bd answer answer-first">
									<div class="line info f-aid">
										<a class="user-name" rel="nofollow"   href="decorateForwardAction.action?code=-25200&paramMap.userID=${fv.taUserID}" title="${fv.taUserAccount }">
											${fv.taUserAccount}
										</a>
									</div>
									
									<div class="replyask line pt-5 pb-5 readlast">
										<s:if test="#fv.taIsMeAppend != 1 "><div class="reply f-12 grid">回答</div></s:if>
										<s:else><div class="ask f-12 grid">追问</div></s:else>
										
										<div class="replyask-content line ml-10">
											<span class="grid-r pos-time">${fv.taCreateTime}</span>
											<pre class="readlastpre" taIsMeAppend="${fv.taIsMeAppend}">${fv.taContent}</pre>
										</div>
									</div>
									
									<div class="replyask line pt-5 pb-5 readlast">
									<s:iterator value="initMap.answerAllChildrenInfo" id="fvChi" status="fvChiindx">
										<s:if test="#fv.taID == #fvChi.taParentsID">	
											<s:if test="#fvChi.taIsMeAppend != 1 "><div class="reply f-12 grid">回答</div></s:if>
											<s:else><div class="ask f-12 grid">追问</div></s:else>
											<div class="replyask-content line ml-10">
												<span class="grid-r pos-time">${fvChi.taCreateTime}</span>
												<pre class="readlastpre" taIsMeAppend="${fvChi.taIsMeAppend}">${fvChi.taContent}</pre>
											</div>
										</s:if>
									</s:iterator>
									</div>
									
									<s:if test="#session.s_userType != 3 ">
									<s:if test="#fv.taIsAccept != 1 && initMap.testdetailInfo.htaskIsAccept != 1">
										<s:if test="#fv.taUserID == session.s_userID">
											<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask continue-reply" editorsetid="${fv.index+1}" style="color: #e64747;display: none;">继续回答</a>
											<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask modify-reply" editorsetid="${fv.index+1}" style="color: #e64747">完善我的回答</a>
											<!-- <a hidefocus="true" class="btn-del-mine btn-24-disabled mr-10" id="del-reply-1906995184">删除我的回答</a> -->
										</s:if>
									</s:if>
									</s:if>
									
									
									<div class="mt-10 mb-10 f-12 f-gray answer-bar-editor-update" style="display: none;margin-top: 43px;">
										<textarea cols="50"  id="editormodify${fvindx.index+1}" rows="10"></textarea>
									    <script type="text/javascript">
									    	  CKEDITOR.replace('editormodify${fvindx.index+1}',{height : 120, filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
										</script>
										<a answerid="${fv.taID}" class="btn-32-green btn-32-green-submit-modify" style="margin-top: 5px;">
											提交回答
										</a>
									</div>
								</div>
							</s:iterator>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="article-list-panel panel">
						<p class="title topborder">相关问题</p>
						<div class="body">
							<ul class="article-list">
								<s:iterator value="initMap.htaskRightList" id="fv" status="fvindx">
									<li class="askList" createkeywords="${fv.htaskKeywords}" createhtaskID="${fv.htaskID}" createuser="${fv.htaskUserCreate}"><a href="javascript:void(0);"><i></i>${fv.htaskTitle }</a></li>
								</s:iterator>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="<%=request.getContextPath()%>/qc/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/qc/js/tweenmax.min.js"></script>
<script src="<%=request.getContextPath()%>/qc/js/scripts.js"></script>
<script src="<%=request.getContextPath()%>/qc/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script src="js/jquery.bxslider.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(".tlfb>ul").bxSlider({
            maxSlides: 3,
            infiniteLoop: false,
            slideWidth: 199,
            slideMargin: 12,
            controls: true,
            nextText: "",
            prevText: "",
            prevSelector: "a.fb-task-list-prev",
            nextSelector: "a.fb-task-list-next",
            pager: false
        });
        $(".tlcy>ul").bxSlider({
            maxSlides: 3,
            infiniteLoop: false,
            slideWidth: 199,
            slideMargin: 12,
            controls: true,
            nextText: "",
            prevText: "",
            prevSelector: "a.cy-task-list-prev",
            nextSelector: "a.cy-task-list-next",
            pager: false
        });
        
        $(".askList").click(function(){
    		var createuser = $(this).attr("createuser");
    		var s_userID = '${paramMap.s_userID}';
    		var createhtaskID = $(this).attr("createhtaskID");
    		var createkeywords = $(this).attr("createkeywords");
    		createkeywords = encodeURI(createkeywords); 
    		createkeywords = encodeURI(createkeywords); 
    		var thecode = "-1890002";
    		if(parseInt(createuser) == parseInt(s_userID)){
    			thecode = "-1890001";
    		}
    		//alert(thecode);
    		window.parent.tabClick("munu_name","问题浏览",thecode,"&paramMap.createkeywords="+createkeywords+"&paramMap.htaskID="+createhtaskID+"&pageSize=8&type=1");
    	});
    });
    var i = setTimeout('check()',500);
    function check() {
    	$("#layout_mainbody").attr("style","");
    }
</script>

</body>
</HTML>