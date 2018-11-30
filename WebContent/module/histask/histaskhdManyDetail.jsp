<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<html><% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>
<head>
<style type="text/css"></style>
<script type="text/javascript">
$(document).ready(function() {
	
	var th = '${initMap.testmanyCount}';
	var testdetailAccpect = '${initMap.testdetailAccpect}';

	if(parseInt(th) == 0){
		$("#shmt-5").show();
	}else{
		$("#shmt-5").hide();
	}

	if(parseInt(testdetailAccpect) > 0){
		$("#shmt-5").hide();
	}
	
});
</script>
</head>
<body>
<div class="mt-10 mb-10 f-12 f-gray">
	<ul class="guide-count-down">
		<li>
			${initMap.testmanydetail.htaskContent}
		</li>
	</ul>
</div>
<%-- <s:if test="initMap.testmanydetail.htaskIssplit == 0">
<div class="guide-tip mt-10 mb-10 f-12 f-gray">
	<ul class="guide-count-down">
		<li>
			您的回答被采纳后将获得系统奖励 <span class="f-red f-bold ml-5">${initMap.testmanydetail.htaskWealthval}</span>（悬赏分+基础分）
		</li>
	</ul>
</div>
</s:if> --%>
<s:if test="#session.s_userType != 3 ">
<div id="shmt-5">
	<span class="mt-5 mb-10 f-12 f-blue inline-block" id="answer-bar">我来解答</span>
	<img id="answer-bar-img" src="images/htask/theup.png" height="7px" border="0">
	<span id="answer-bar-search">
		<span class="f-pipe f-12 search-relate-pipe">|</span>
		<a class="mb-10 mt-5 search-relate" href="http://www.baidu.com/s?wd=${initMap.testmanydetail.htaskTitle}" target="_blank"><span></span>搜索资料</a>
	</span>
	<div class="mt-10 mb-10 f-12 f-gray" id="answer-bar-editor">
		<textarea cols="50" manyAnswerID="${initMap.testmanydetail.htaskID}" id="editorAnswer${paramMap.htaskSplitIndex}" rows="10"></textarea>
	    <script type="text/javascript">
			  CKEDITOR.replace('editorAnswer${paramMap.htaskSplitIndex}',{height : 120, filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
		</script>
		<div id="answer-bar-sub" style="margin-top: 10px;">
			<a href="javascript:void(0)" class="btn-32-green btn-32-green-submit">
				提交回答
			</a>
		</div>
	</div>
</div>
</s:if>
</body>
</HTML>