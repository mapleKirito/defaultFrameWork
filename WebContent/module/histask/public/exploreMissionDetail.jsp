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
	
	
	/* var isMeAppend=0;
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
	}); */
	
	//回答框控制
	$("#answer-bar").die().live("click",function(){
		var answerbareditor = $("#answer-bar-editor").css("display");
		var answerbarsub = $("#answer-bar-sub").css("display");
		if(answerbareditor=="none" && answerbarsub=="none"){
			$("#answer-bar-editor,#answer-bar-sub").show();
			$("#answer-bar-img").attr("src", "images/htask/thedown.png");
			if("${session.srUnicomNet}"=="1")
				$("#answer-bar-search").show();
		}else{
			$("#answer-bar-editor,#answer-bar-sub").hide();
			$("#answer-bar-img").attr("src", "images/htask/theup.png");
			if("${session.srUnicomNet}"=="1")
				$("#answer-bar-search").hide();
		}
	});
	//回答
	$("#anser_question").live("click",function(){
		concoleCode = "-1891";
		//var htaskID = '${paramMap.htaskID}';
		var htaskID=$("#manyAnswerID").val();
		var taskchoosetagindex=$("#taskchoosetagindex").val();
		var appparam = "&paramMap.taHtaskIndex="+taskchoosetagindex;
		var keywords='${initMap.testdetailInfo.htaskKeywords}';
		var getAttrID = $(this).parent("div").siblings("textarea").attr("id");
		var rcontent = CKEDITOR.instances[getAttrID].getData() == '' ? false: true;
		if (rcontent) {
			$.ajax({
				url: 'ajaxAction.action?code='+concoleCode + '&paramMap.taHtaskID='+htaskID+'&paramMap.taContent=' + CKEDITOR.instances[getAttrID].getData() + '&paramMap.taUserID=' + '${paramMap.s_userID}'+appparam,
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
						location.href = "decorateForwardAction.action?code=-1890002&paramMap.taskchoosetagindexhref="+taskchoosetagindex+"&paramMap.htaskKeywords="+keywords+"&paramMap.htaskID=${paramMap.htaskID}";
					}
				},
				error: function(request, textStatus, error) {}
			});
		} else {
			alert("内容不能为空！！！");
		}	
	});
	/* //采纳
	$(".pump-ask-accpet").die().live("click",function(){ 
		var keywords='${initMap.testdetailInfo.htaskKeywords}';
		var htaskID =$("#manyAnswerID").val();
		var taskchoosetagindex=$("#taskchoosetagindex").val();
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
					location.href = "decorateForwardAction.action?code=-1890002&paramMap.taskchoosetagindexhref="+taskchoosetagindex+"&paramMap.htaskKeywords="+keywords+"&paramMap.htaskID=${paramMap.htaskID}";
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
		var htaskID = $("#manyAnswerID").val();
		var taskchoosetagindex=$("#taskchoosetagindex").val();
		var taID = $(this).attr("answerid");
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
						location.href = "decorateForwardAction.action?code=-1890002&paramMap.taskchoosetagindexhref="+taskchoosetagindex+"&paramMap.htaskKeywords="+keywords+"&paramMap.htaskID=${paramMap.htaskID}";
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
		var htaskID = $("#manyAnswerID").val();
		var taskchoosetagindex=$("#taskchoosetagindex").val();
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
						location.href = "decorateForwardAction.action?code=-1890002&paramMap.taskchoosetagindexhref="+taskchoosetagindex+"&paramMap.htaskKeywords="+keywords+"&paramMap.htaskID=${paramMap.htaskID}";
					}
				},
				error: function(request, textStatus, error) {}
			});
		} else {
			alert("内容不能为空！！！");
		}
	}); */
	
	
	//多任务相关
	var $tab = $("#tags ul li");
	var $tab2 = $("#tags2 ul");
	$tab.click(function(){
		$("#answer-bar-editor,#answer-bar-sub").hide();
		$("#answer-bar-img").attr("src", "images/htask/theup.png");
		$("#shmt-5").hide();
		$("#missionWealth").hide();
		$("#manyAnswerID").val($(this).attr("missionID"));
		var index = $tab.index(this);
		//$("#best-answer").hide();
		var theindex = index+1;
		$("#taskchoosetagindex").val(theindex);
		$tab2.find("li").eq(index).show().siblings('li').hide();
		
		checkAnswer(index);
		$("#answerContent").html($("#defaultAnswerContent").html());
		$("#answerContent").load("decorateForwardAction.action?code=-1897&paramMap.htaskSplitIndex="+(theindex)+"&paramMap.htaskID="+$("#manyAnswerID").val());
	});
	
	//初始化默认子任务回答列表
	var taskchoosetagindex=$("#taskchoosetagindex").val();
	$("#answerContent").load("decorateForwardAction.action?code=-1897&paramMap.htaskSplitIndex="+(taskchoosetagindex)+"&paramMap.htaskID="+$("#tags ul").find("li").eq(taskchoosetagindex-1).attr("missionID"));
	
	checkAnswer(taskchoosetagindex-1);
	
	
	
	//自动展开回答框
	var answerbareditor = $("#answer-bar-editor").css("display");
	var answerbarsub = $("#answer-bar-sub").css("display");
	if(answerbareditor=="none" && answerbarsub=="none"){
		$("#answer-bar-editor,#answer-bar-sub").show();
		if("${session.srUnicomNet}"=="1")
			$("#answer-bar-img").attr("src", "images/htask/thedown.png").siblings("#answer-bar-search").show();
	}
});

function checkAnswer(i){
	
	var sUserType='${session.s_userType}';
	var sUserID='${session.s_userID}';
	var creater='${initMap.testdetailInfo.htaskUserCreate}';
	var isAccept=$("#tags ul").find("li").eq(i).attr("isAccept");
	var missionID=$("#tags ul").find("li").eq(i).attr("missionID");
	$("#manyAnswerID").val(missionID);
	var isAnswer=$("#isAnswer_"+missionID).val();
	$("#missionWealth").html("财富值"+$("#wealth_"+i).val()+"(系统奖励1+悬赏"+(parseInt($("#wealth_"+i).val())-1)+")");
	if(isAnswer==null){
		isAnswer=0;
	}
	//alert(sUserType!='3'&&isAnswer=='0'&&isAccept!='1'&&creater!=sUserID);
	if(sUserType!='3'&&isAnswer=='0'&&isAccept!='1'&&creater!=sUserID){
		$("#shmt-5").show();
	}
	if(isAccept!='1'){
		$("#missionWealth").show();
	}
	
}
</script>
</head>
<body>
<input type="hidden" id="taskchoosetagindex" value="${paramMap.taskchoosetagindexhref }">
<div id="layout_mainbody" style =" visibility : hidden">	
		<div class="page-container ssjh">
			<div class="ssjh-taskview">
				<div class="left">
					<div class="wgt-ask accuse-response line mb-5  panel" id="wgt-ask">
						<p class="title topborder">问题详细</p>
						<div class="wgt-body"  style="padding: 18px;">
							<h5><span>【题目】</span>${initMap.testdetailInfo.htaskTitle}</h5>
							<div class="line f-aid mb-10" id="ask-info">
									<span id="missionWealth" style="display: none;">
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
							<s:if test="initMap.testdetailInfo.htaskContent!=''">
							<div class="paddingdiv_main">
								<h5><span>【问题内容】</span></h5>
								<div class="mt-10 mb-10 f-12 f-gray guide-count-down" style="color: #999;">
									${initMap.testdetailInfo.htaskContent}
								</div>
							</div>
							</s:if>
							<div class="tabcontents" style="  height: 50px;">
									<div class="tabcontent tlfb" style="position: relative;  padding-top: 7px;" id="tags">
										<a href="javascript:void(0);" class="fb-task-list-prev"></a>
										<a href="javascript:void(0);" class="fb-task-list-next"></a>
										<ul class="task-list fb">
											<s:iterator value="initMap.htasksort" id="hsid" status="hsindex">
												<s:if test="#hsid.htaskIsAccept == 1"><li isAccept="${hsid.htaskIsAccept }" missionID="${hsid.htaskID }"><a href="javascript:void(0);" class="completed"><i class="icon-right-arrow-big"></i><em>${hsindex.index+1}</em>已完成</a></li></s:if>
												<s:if test="#hsid.htaskIsAccept == 0"><li isAccept="${hsid.htaskIsAccept }" missionID="${hsid.htaskID }"><a href="javascript:void(0);" class="uncompleted"><i class="icon-right-arrow-big"></i><em>${hsindex.index+1}</em>未完成</a></li></s:if>
												<s:if test="#hsid.htaskIsAccept == 2"><li isAccept="${hsid.htaskIsAccept }" missionID="${hsid.htaskID }"><a href="javascript:void(0);" class="procing"><i class="icon-right-arrow-big"></i><em>${hsindex.index+1}</em>未完成</a></li></s:if>
											</s:iterator>
										</ul>
									</div>
							</div>
							<div id="taskchoosetag">
							<input type="hidden" id="manyAnswerID" />
							<s:iterator value="initMap.testIsAnswer" id="tia" status="tiaIndex">
								<input type="hidden" id="isAnswer_${tia.htaskID }" value="${tia.isAnswer }" />
							</s:iterator>
							
							<div class="mt-10 mb-10 f-12 f-gray" id="tags2">
								<ul class="guide-count-down">
									<s:iterator value="initMap.htasksort" id="hsid" status="hsindex">
										<li style="${(paramMap.taskchoosetagindexhref==(hsindex.index+1))?'':'display:none'}" >
											<input type="hidden" id="wealth_${hsindex.index }" value="${hsid.htaskWealthval}">
											<h5><span>【任务${hsindex.index+1 }】</span></h5>
											${hsid.htaskContent}
										</li>
									</s:iterator>
								</ul>
							</div>
								
								<div id="shmt-5" style="display: none;">
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
							</div>
						</div>
					</div>
					<!--回答  -->
					<div id="answerContent">
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
									<p class="title line">其它<span id="answercount">0</span>条回答</p>
								</div>
							</div>
						</div>
					</div>
					<div id="defaultAnswerContent" style="display: none;">
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
									<p class="title line">其它<span id="answercount">0</span>条回答</p>
								</div>
							</div>
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