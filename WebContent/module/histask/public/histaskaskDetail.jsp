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
	var $tab = $("#tags ul li");
	var taskchoosetagindexhref = '${paramMap.taskchoosetagindexhref}' == ''?'1':'${paramMap.taskchoosetagindexhref}';
	var thehtaskID = '${paramMap.htaskID}';
	
	$("#taskchoosetagindex").val(taskchoosetagindexhref);
	
	 if(parseInt(htaskIssplit)==1 && taskchoosetagindexhref != ""){
		$tab.eq(taskchoosetagindexhref-1).addClass("selected").siblings().removeClass("selected");
		
		$("#taskchoosetaganswer").load("decorateForwardAction.action?code=-1898&paramMap.htaskSplitIndex="+(taskchoosetagindexhref)+"&paramMap.htaskID="+thehtaskID+"&suiji="+new Date().getTime());
		$("#best-answer").show().load("decorateForwardAction.action?code=-1899&paramMap.htaskSplitIndex="+(taskchoosetagindexhref)+"&paramMap.htaskID="+thehtaskID+"&suiji="+new Date().getTime()).show();
		$(".guide-count-down").load("decorateForwardAction.action?code=-11899&paramMap.htaskSplitIndex="+(taskchoosetagindexhref)+"&paramMap.htaskID="+thehtaskID+"&suiji="+new Date().getTime());
	}else{
		if(parseInt(htaskIssplit)==1){
		$("#taskchoosetaganswer").load("decorateForwardAction.action?code=-1898&paramMap.htaskSplitIndex="+(1)+"&paramMap.htaskID=${paramMap.htaskID}&suiji="+new Date().getTime());
		$("#best-answer").show().load("decorateForwardAction.action?code=-1899&paramMap.htaskSplitIndex="+(1)+"&paramMap.htaskID=${paramMap.htaskID}&suiji="+new Date().getTime()).show();
		$(".guide-count-down").load("decorateForwardAction.action?code=-11899&paramMap.htaskSplitIndex="+(1)+"&paramMap.htaskID=${paramMap.htaskID}&suiji="+new Date().getTime());
		}
	} 
	
	$tab.click(function(){		
		var index = $tab.index(this);		
		var theindex = index;
		if(index == 0){ theindex = 1; }
		$("#best-answer").hide();
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
						$("#taskchoosetaganswer").load("decorateForwardAction.action?code=-1898&paramMap.htaskSplitIndex="+(index+1)+"&paramMap.htaskID="+thehtaskID);
						$("#best-answer").load("decorateForwardAction.action?code=-1899&paramMap.htaskSplitIndex="+(index+1)+"&paramMap.htaskID="+thehtaskID);
						$(".guide-count-down").load("decorateForwardAction.action?code=-11899&paramMap.htaskSplitIndex="+(index+1)+"&paramMap.htaskID="+thehtaskID);
					}else{
						alert("当前任务选出的最佳答案时，继续回答下一个任务");
					}
				}
			},
			
			error:function(request,textStatus,error){}
		});
	});
	
	var htaskIsAccept = '${initMap.testdetailInfo.htaskIsAccept}';
	if(parseInt(htaskIsAccept) == 1){
		$(".pump-ask-accpet").hide();	
	}
	
	var answerAllInfoLen = '${fn:length(initMap.answerAllInfo)}';
	if(parseInt(answerAllInfoLen) < 0 && parseInt(htaskIsAccept) != 1){
		$(".wgt-answers").hide();
		$(".wgt-answers-isnull").show();
	}
	
	if(parseInt('${fn:length(initMap.answerAllInfo)}') > 0){
		$("#answerTop").show();
	}
	$("#answercount").html($(".bd.answer.answer-first").size());
	
	if(parseInt('${fn:length(initMap.answerAcceptInfo)}') > 0){
		$("#best-answer").show();
	}	
	
	$(".bd.answer.answer-first").each(function(i){
		var taIsMeAppend = $(this).find(".replyask-content").children("pre").last().attr("taIsMeAppend");
		if(parseInt(taIsMeAppend)<=0){
			$(this).find(".pump-ask-mofify").hide();
			$(this).find(".pump-ask-continue").show();
		}else{
			$(this).find(".pump-ask-mofify").show();
			$(this).find(".pump-ask-continue").hide();
		} 
	});
	
	var concoleCode = "-1893";
	$(".pump-ask-continue").toggle(function(){
		$(this).siblings(".pump-ask-editor").show();
		
		var htmleditor = $(this).parents(".answer-first").find(".replyask-content").children("pre").last().html();
		var editormodifyid = $(this).attr("editorsetid");
		CKEDITOR.instances["editorAnswer"+editormodifyid].setData(htmleditor);
	},function(){
		$(this).siblings(".pump-ask-editor").hide();
	});
	
	$(".pump-ask-mofify").die().live("click", function () {
		var $a = $(this).siblings(".pump-ask-editor");
		if($a.css("display")=="none"){
			concoleCode = "-1892";
			$a.show();
			
			var htmleditor = $(this).parents(".answer-first").find(".replyask-content").children("pre").last().html();
			var editormodifyid = $(this).attr("editorsetid");
			CKEDITOR.instances["editorAnswer"+editormodifyid].setData(htmleditor);
		}else{
			$a.hide();
		}
	});
	
	$(".btn-32-green-submit").die().live("click",function(){
		var htaskID = '${paramMap.htaskID}';
		var taID = $(this).attr("answerid");
		var currentid = $(this).attr("currentid");
		
		var getAttrID = $(this).siblings("textarea").attr("id");
		var rcontent = CKEDITOR.instances[getAttrID].getData() == '' ? false: true;
		var appparam = "&paramMap.taHtaskIndex="+$("#taskchoosetagindex").val();
		
		if (rcontent) {
			$.ajax({
				url: 'ajaxAction.action?code='+concoleCode+'&paramMap.taID='+currentid+'&paramMap.taIsMeAppend=1&paramMap.taHtaskID='+htaskID+'&paramMap.taUserID=${paramMap.s_userID}&paramMap.taParentsID=' + taID + '&paramMap.taContent=' + CKEDITOR.instances[getAttrID].getData() + appparam,
				type: 'post',
				timeout: '60000',
				data: Array(),
				dataType: 'json',
				beforeSend: function(request) {},
				complete: function(request, textStatus) {},
				success: function(jsonData, textStatus) {
					if (textStatus == "success") {
						location.href = "decorateForwardAction.action?code=-1890001&paramMap.taskchoosetagindexhref="+$("#taskchoosetagindex").val()+"&paramMap.htaskID=" + htaskID;
					}
				},
				error: function(request, textStatus, error) {}
			});
		} else {
			alert("内容不能为空！！！");
		}
	});
	
	$(".pump-ask-accpet").die().live("click",function(){ 
		var htaskID = '${paramMap.htaskID}';
		var taID = $(this).attr("answerid");
		var ansUID = $(this).attr("ansUID");
		var addWealth = $("#manycontent-issh").attr("wealth");
		$.ajax({
			url: 'ajaxAction.action?code=-1894&paramMap.ishtaskIssplit='+htaskIssplit+'&paramMap.htaskSplitIndex='+$("#taskchoosetagindex").val()+'&paramMap.htaskID=' + htaskID + '&paramMap.taID=' + taID+ '&paramMap.addWealth=' + addWealth+ '&paramMap.ansUID=' + ansUID,
			type: 'post',
			timeout: '60000',
			data: Array(),
			dataType: 'json',
			beforeSend: function(request) {},
			complete: function(request, textStatus) {},
			success: function(jsonData, textStatus) {
				if (textStatus == "success") {
					location.href = "decorateForwardAction.action?code=-1890001&paramMap.taskchoosetagindexhref="+$("#taskchoosetagindex").val()+"&paramMap.htaskID=" + htaskID;
				}
			},
			error: function(request, textStatus, error) {}
		});
	});
	
});
</script>
<style type="text/css">

</style>
</head>
<body>
<input type="hidden" id="taskchoosetagindex" value="1">
<div id="layout_mainbody"  style =" visibility : hidden" >
		
		<div class="page-container ssjh">
			<div class="ssjh-taskview">
				<div class="left">
					<div class="wgt-ask accuse-response line mb-5  panel" id="wgt-ask">
						<p class="title topborder">问题详细</p>
						<div class="wgt-body">
							<div class="paddingdiv">
								<h5><span>【题目】</span>${initMap.testdetailInfo.htaskTitle}</h5>
								<div class="line f-aid mb-10" id="ask-info">
									<span>
										提问者悬赏：
										<s:if test="initMap.testdetailInfo.htaskIssplit == 0">${initMap.testdetailInfo.htaskWealthval-1}</s:if>
										<s:else>${initMap.testdetailInfo.htaskWealthval}</s:else>
										财富
									</span>
									<span class="f-pipe">
										&nbsp;&nbsp;&nbsp;&nbsp;
									</span>
									<span>
										搜索关键词：${initMap.testdetailInfo.htaskKeywords}
									</span>
									<span class="f-pipe">
										&nbsp;&nbsp;&nbsp;&nbsp;
									</span>
									<span>
										<a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.targetID}" title="${l.userName }">发起人：${initMap.testdetailInfo.htaskUserAccount}</a>
									</span>
									<span style="float: right;">
										${initMap.testdetailInfo.htaskCreatetime}
									</span>
								</div>
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
									<div id="manycontent-issh" wealth="${initMap.testdetailInfo.htaskWealthval}">
										<ul>
											<li>
												${initMap.testdetailInfo.htaskContent}
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="wgt-best " id="best-answer" style="margin-top: 5px;display: none;">
						<div id="best-answer-load" class="title topborder-green">
							<i class="sccpetiamge" style="display: block;margin-left: 18px;float: left;width: 41px;height: 57px;background-image: url('images/asspetimg.png');"></i>
							<p class="title line" style="line-height: 57px;">问题采纳</p>
							<div class="bd answer" style="padding: 0px 18px 18px 18px;">
								<div class="line info f-aid">
									热心网友
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
					</div>
					<div id="taskchoosetaganswer" class="answer-list-panel panel">
						<div class="wgt-answers">
							<div class="hd line title topborder-green" id="answerTop" style="display:none;">
								<span class="grid-r f-12" style="float: right;">
									<span>
										按默认排序
									</span>
									<span class="f-pipe">
										|
									</span>
									<a rel="nofollow" >
										按时间排序
									</a>
								</span>
								<p class="title line">其它<span id="answercount">0</span>条回答</p>
							</div>
							<s:iterator value="initMap.answerAllInfo" id="fv" status="fvindx">	
								<div class="bd answer answer-first">
									<div class="line">
										<div class="line info f-aid">
											<a class="user-name" rel="nofollow"  >
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
											<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask pump-ask-accpet" answerid="${fv.taID}" ansUID="${fv.taUserID}" style="color: #e64747;">采纳</a>
											<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask pump-ask-mofify" editorsetid="${fv.index+1}" style="color: #e64747;display: none;">完善</a>
											<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask pump-ask-continue" style="color: #e64747">追问</a>
										</s:if>
										</s:if>
										
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
								</div>
							</s:iterator>
						</div>		
					</div>
					<div class="wgt-answers-isnull" style="display: none;">
						<div class="wgt-asker-banner mb-5 line">
							<div class="asker-banner-middle">
								<div class="line">
									<p class="f-yahei">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<i class="i-pop-regret mr-15">
										</i>
										很遗憾，您的问题没有收到解答...
									</p>
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
            slideWidth: 209,
            slideMargin: 12,
            controls: true,
            nextText: "",
            prevText: "",
            prevSelector: "a.fb-task-list-prev",
            nextSelector: "a.fb-task-list-next",
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