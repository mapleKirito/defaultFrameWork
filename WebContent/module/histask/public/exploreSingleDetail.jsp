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
$(function(){
	var isMeAppend=0;
	//继续回答与追问控制
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
	
	//
	$(".continue-reply").die().live("click", function () {
		//alert(123);
		var $a = $(this).siblings(".pump-ask-editor");
		if($a.css("display")=="none"){
			$a.show();
			isMeAppend=0;
			var editormodifyid = $(this).attr("editorsetid");
			CKEDITOR.instances["editormodify"+editormodifyid].setData();
		}else{
			$a.hide();
		}
	});
	
	//回答框控制
	$("#answer-bar").die().live("click",function(){
		var answerbareditor = $("#answer-bar-editor").css("display");
		var answerbarsub = $("#answer-bar-sub").css("display");
		if(answerbareditor=="none" && answerbarsub=="none"){
			$("#answer-bar-editor,#answer-bar-sub").show();
			if("${session.srUnicomNet}"=="1")
				$("#answer-bar-img").attr("src", "images/htask/thedown.png").siblings("#answer-bar-search").show();
		}else{
			$("#answer-bar-editor,#answer-bar-sub").hide();
			if("${session.srUnicomNet}"=="1")
				$("#answer-bar-img").attr("src", "images/htask/theup.png").siblings("#answer-bar-search").hide();
		}
	});
	//回答
	$("#anser_question").live("click",function(){
		concoleCode = "-1891";
		var htaskID = '${paramMap.htaskID}';
		var keywords='${initMap.testdetailInfo.htaskKeywords}';
		var getAttrID = $(this).parent("div").siblings("textarea").attr("id");
		var rcontent = CKEDITOR.instances[getAttrID].getData() == '' ? false: true;
		if (rcontent) {
			$.ajax({
				url: 'ajaxAction.action?code='+concoleCode + '&paramMap.taHtaskID='+'${paramMap.htaskID}&paramMap.taContent=' + CKEDITOR.instances[getAttrID].getData() + '&paramMap.taUserID=' + '${paramMap.s_userID}',
				type: 'post',
				timeout: '60000',
				data: Array(),
				dataType: 'json',
				beforeSend: function(request) {},
				complete: function(request, textStatus) {},
				success: function(jsonData, textStatus) {
					if (textStatus == "success") {
						//alert("success");
						alert("回复成功");
						location.href = "decorateForwardAction.action?code=-1890001&paramMap.htaskKeywords="+keywords+"&paramMap.htaskID=" + htaskID;
					}
				},
				error: function(request, textStatus, error) {}
			});
		} else {
			alert("内容不能为空！！！");
		}	
	});
	//采纳
	$(".pump-ask-accpet").die().live("click",function(){ 
		var keywords='${initMap.testdetailInfo.htaskKeywords}';
		var htaskID = '${paramMap.htaskID}';
		var taID = $(this).attr("answerid");
		var ansUID = $(this).attr("ansUID");
		var addWealth = $("#wealth").val();
		$.ajax({
			url: 'ajaxAction.action?code=-189401&paramMap.htaskID=' + htaskID + '&paramMap.taID=' + taID+ '&paramMap.addWealth=' + addWealth+ '&paramMap.ansUID=' + ansUID,
			type: 'post',
			timeout: '60000',
			data: Array(),
			dataType: 'json',
			beforeSend: function(request) {},
			complete: function(request, textStatus) {},
			success: function(jsonData, textStatus) {
				if (textStatus == "success") {
					alert("采纳成功");
					location.href = "decorateForwardAction.action?code=-1890001&paramMap.htaskKeywords="+keywords+"&paramMap.htaskID=" + htaskID;
				}
			},
			error: function(request, textStatus, error) {}
		});
	});
	
	//完善回答控制
	$(".modify-reply").toggle(function(){
		$(this).siblings(".answer-bar-editor-update").show();
		
		var htmleditor = $(this).parents(".answer-first").find(".replyask-content").children("pre").last().html();
		var editormodifyid = $(this).attr("editorsetid");
		CKEDITOR.instances["editormodify"+editormodifyid].setData(htmleditor);
	},function(){
		$(this).siblings(".answer-bar-editor-update").hide();
	});
	
	//完善回答提交
	$(".btn-32-green-submit-modify").die().live("click",function(){
		var htaskID = '${paramMap.htaskID}';
		var taID = $(this).attr("currentid");
		var keywords='${initMap.testdetailInfo.htaskKeywords}';
		var getAttrID = $(this).siblings("textarea").attr("id");
		var rcontent = CKEDITOR.instances[getAttrID].getData() == '' ? false: true;
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
				url: 'ajaxAction.action?code=-1892&paramMap.taID=' + taID + '&paramMap.taContent='+answer_format+'&paramMap.taUserID=' + '${paramMap.s_userID}',
				type: 'post',
				timeout: '60000',
				data: Array(),
				dataType: 'json',
				beforeSend: function(request) {},
				complete: function(request, textStatus) {},
				success: function(jsonData, textStatus) {
					if (textStatus == "success") {
						location.href = "decorateForwardAction.action?code=-1890001&paramMap.htaskKeywords="+keywords+"&paramMap.htaskID=" + htaskID;
					}
				},
				error: function(request, textStatus, error) {}
			});
		} else {
			alert("内容不能为空！！！");
		}
	});
	
	//追问控制
	$(".pump-ask-continue").toggle(function(){
		$(this).siblings(".pump-ask-editor").show();
		isMeAppend=1;
		var editormodifyid = $(this).attr("editorsetid");
		CKEDITOR.instances["editorAnswer"+editormodifyid].setData();
	},function(){
		$(this).siblings(".pump-ask-editor").hide();
	});
	//追问提交
	$(".btn-32-green-submit").die().live("click",function(){
		var htaskID = '${paramMap.htaskID}';
		var taID = $(this).attr("answerid");
		var currentid = $(this).attr("currentid");
		var keywords='${initMap.testdetailInfo.htaskKeywords}';
		var getAttrID = $(this).siblings("textarea").attr("id");
		var rcontent = CKEDITOR.instances[getAttrID].getData() == '' ? false: true;
		//alert(isMeAppend);
		if (rcontent) {
			$.ajax({
				url: 'ajaxAction.action?code=-1893&paramMap.taID='+currentid+'&paramMap.taIsMeAppend='+isMeAppend+'&paramMap.taHtaskID='+htaskID+'&paramMap.taUserID=${paramMap.s_userID}&paramMap.taParentsID=' + taID + '&paramMap.taContent=' + CKEDITOR.instances[getAttrID].getData() ,
				type: 'post',
				timeout: '60000',
				data: Array(),
				dataType: 'json',
				beforeSend: function(request) {},
				complete: function(request, textStatus) {},
				success: function(jsonData, textStatus) {
					if (textStatus == "success") {
						location.href = "decorateForwardAction.action?code=-1890001&paramMap.htaskKeywords="+keywords+"&paramMap.htaskID=" + htaskID;
					}
				},
				error: function(request, textStatus, error) {}
			});
		} else {
			alert("内容不能为空！！！");
		}
	});
	
	//自动展开回答框
	var answerbareditor = $("#answer-bar-editor").css("display");
	var answerbarsub = $("#answer-bar-sub").css("display");
	if(answerbareditor=="none" && answerbarsub=="none"){
		$("#answer-bar-editor,#answer-bar-sub").show();
		if("${session.srUnicomNet}"=="1")
			$("#answer-bar-img").attr("src", "images/htask/thedown.png").siblings("#answer-bar-search").show();
	}
});
</script>
</head>
<body>
<input type="hidden" id="wealth" value="${initMap.testdetailInfo.htaskWealthval}">
<div id="layout_mainbody" style =" visibility : hidden">	
		<div class="page-container ssjh">
			<div class="ssjh-taskview">
				<div class="left">
					<div class="wgt-ask accuse-response line mb-5  panel" id="wgt-ask">
						<p class="title topborder">问题详细</p>
						<div class="wgt-body"  style="padding: 18px;">
							<h5><span>【题目】</span>${initMap.testdetailInfo.htaskTitle}</h5>
							<div class="line f-aid mb-10" id="ask-info">
									<span>
										财富值${initMap.testdetailInfo.htaskWealthval}(系统奖励1+悬赏${initMap.testdetailInfo.htaskWealthval-1})
									</span>
									<span class="f-pipe">
										&nbsp;&nbsp;&nbsp;&nbsp;
									</span>
								<span>
									关键词：${initMap.testdetailInfo.htaskKeywords==""?"暂无关键字":initMap.testdetailInfo.htaskKeywords}
								</span>
								<span style="float: right;">
									提问时间：${initMap.testdetailInfo.htaskCreatetime}
									<%-- 提问人:${initMap.testdetailInfo.htaskUserCreate } --%>
								</span>
							</div>
							<div class="paddingdiv">
								<h5><span>【问题内容】</span></h5>
								<div class="mt-10 mb-10 f-12 f-gray guide-count-down" style="color: #999;">
									${initMap.testdetailInfo.htaskContent}
								</div>
							</div>
							<div id="taskchoosetag">
								
								<s:if test="#session.s_userType != 3&&initMap.testIsAnswer==0&&initMap.testdetailInfo.htaskIsAccept != 1&&initMap.testdetailInfo.htaskUserCreate != session.s_userID ">
								<div id="shmt-5">
									<span class="mt-5 mb-10 f-12 f-blue inline-block" id="answer-bar">我来解答</span>
									<img id="answer-bar-img" src="images/htask/theup.png" height="7px" border="0">
									<s:if test="#session.srUnicomNet == 1 ">
									<span id="answer-bar-search" style="display: none;">
										<span class="f-pipe f-12 search-relate-pipe">|</span>
										<a class="mb-10 mt-5 search-relate" href="http://www.baidu.com/s?wd=${initMap.testdetailInfo.htaskTitle}" target="_blank"><span></span>搜索资料</a>
									</span>
									</s:if>
									<div class="mt-10 mb-10 f-12 f-gray" id="answer-bar-editor" style="display: none;">
										<textarea cols="50"  id="editorAnswer" rows="10"></textarea>
									    <script type="text/javascript">
											  CKEDITOR.replace('editorAnswer',{height : 120, filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
										</script>
										<div id="answer-bar-sub" style="display: none;">
											<input id="anser_question" type="submit" class="btn-32-green btn-32-green-submit question-submit" value="提交回答" data-old-bg="rgb(230, 71, 71)" style="background-color: rgb(230, 71, 71);">
										</div>
									</div>
								</div>
								</s:if>
							</div>
						</div>
					</div>
					<!--最佳答案  -->
					<s:if test="initMap.answerAcceptInfo.taUserAccount!=null ">
					<div class="wgt-best " id="best-answer" style="margin-top: 5px;">
						<i class="sccpetiamge" style="display: block;margin-left: 18px;float: left;width: 41px;height: 57px;background-image: url('images/asspetimg.png');"></i>
						<p class="title line" style="line-height: 57px;">问题采纳</p>
						<div class="bd answer" id="answer" style="padding: 0px 18px 18px 18px;">
							<div class="line info f-aid">
								${initMap.answerAcceptInfo.taUserAccount}
							</div>
							<div class="replyask line pt-5 pb-5 readlast">
									<s:if test="initMap.answerAcceptInfo.taIsMeAppend != 1 "><div class="reply f-12 grid">回答</div></s:if>
									<s:else><div class="ask f-12 grid">追问</div></s:else>
									<div class="line ml-10" style="margin-left: 40px;">
										<span class="grid-r pos-time">${initMap.answerAcceptInfo.taCreateTime}</span>
										<pre>${initMap.answerAcceptInfo.taContent}</pre>
									</div>
							</div>
						</div>
					</div>
					</s:if>
					<!--回答列表  -->
					<div id="taskchoosetaganswer" class="answer-list-panel panel">
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
								<p class="title line">其它<span id="answercount">${fn:length(initMap.answerAllInfo)}</span>条回答</p>
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
										<s:if test="initMap.testdetailInfo.htaskUserCreate == session.s_userID">
											<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask pump-ask-accpet" answerid="${fv.taID}" ansUID="${fv.taUserID}" style="color: #e64747;">采纳</a>
											<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask pump-ask-continue" editorsetid="${fv.index+1}" style="color: #e64747">追问</a>
										</s:if>
										<s:if test="#fv.taUserID == session.s_userID">
											<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask continue-reply" editorsetid="${fv.index+1}" style="color: #e64747;display: none;">继续回答</a>
											<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask modify-reply" editorsetid="${fv.index+1}" style="color: #e64747">完善我的回答</a>
										</s:if>
									</s:if>
									</s:if>
									
									
									<div class="mt-10 mb-10 f-12 f-gray answer-bar-editor-update" style="display: none;margin-top: 43px;">
										<textarea cols="50"  id="editormodify${fvindx.index+1}" rows="10"></textarea>
									    <script type="text/javascript">
									    	  CKEDITOR.replace('editormodify${fvindx.index+1}',{height : 120, filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
										</script>
										<a currentid="${initMap.testdetailCurrAnsInfo.taID}" answerid="${fv.taID}" class="btn-32-green btn-32-green-submit-modify" style="margin-top: 5px;">
											提交回答
										</a>
									</div>
									<div class="mt-10 mb-10 f-12 f-gray pump-ask-editor" style="display:none;margin-top: 43px;">
											<textarea cols="50"  id="editorAnswer${fvindx.index+1}" rows="10"></textarea>
										    <script type="text/javascript">
												  CKEDITOR.replace('editorAnswer${fvindx.index+1}',{height : 120, filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
											</script>
											<a currentid="${initMap.testdetailCurrAnsInfo.taID}" answerid="${fv.taID}" class="btn-32-green btn-32-green-submit" style="margin-top: 5px">
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
									<li class="askList" htaskIssplit="${fv.htaskIssplit }" createkeywords="${fv.htaskKeywords}" createhtaskID="${fv.htaskID}" createuser="${fv.htaskUserCreate}"><a href="javascript:void(0);"><i></i>${fv.htaskTitle }</a></li>
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
    	$(".askList").click(function(){
    		var s_userID = '${paramMap.s_userID}';
    		var createhtaskID = $(this).attr("createhtaskID");
    		var keywords=$(this).attr("createkeywords");
    		var htaskIssplit=$(this).attr("htaskIssplit");
    		var thecode = "-1890001";
    		if(htaskIssplit==1){
    			thecode = "-1890002";
    		}
    		window.parent.tabClick("munu_name","问题浏览",thecode,"paramMap.htaskID="+createhtaskID+"&paramMap.taskchoosetagindexhref=1&pageSize=8&type=1&paramMap.htaskKeywords="+keywords);
    	});
    });
    var i = setTimeout('check()',500);
    function check() {
    	$("#layout_mainbody").attr("style","");
    }
</script>

</body>
</HTML>