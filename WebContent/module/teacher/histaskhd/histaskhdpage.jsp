<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<html> 
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>
<head>
<script type="text/javascript">
$(document).ready(function(){	
	$("#answercount").html($(".bd.answer.answer-first").size());
	
	$(".pump-ask-continue").toggle(function(){
		$(this).siblings(".pump-ask-editor").show();
		
		var htmleditor = $(this).parents(".answer-first").find(".replyask-content").children("pre").last().html();
		var editormodifyid = $(this).attr("editorsetid");
		CKEDITOR.instances["editorAnswer"+editormodifyid].setData();
	},function(){
		$(this).siblings(".pump-ask-editor").hide();
	});
	
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
	
	if(parseInt('${initMap.testdetailAccpect}') > 0){
		$(".pump-ask-continue,.pump-ask-mofify,.pump-ask-accpet").hide();
	}
	
});
</script>
</head>
<body>
<div class="wgt-answers">
	<div class="hd line title topborder-green" id="answerTop">
		<span class="grid-r f-12" style="float: right;display:none;">
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
	<script type="text/javascript">
		var isanswerAllInfo = '${fn:length(initMap.answerAllInfo)}';
		if(parseInt(isanswerAllInfo) <= 0 && parseInt('${initMap.testdetailAccpect}') <= 0){
			$(".wgt-answers-isnull").show();
		}else{
			$(".wgt-answers-isnull").hide();
		}
		
		if(parseInt(isanswerAllInfo) <= 0 ){
			$("#answerTop").hide();
		}
	</script>
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
				<s:if test="#fv.taIsAccept != 1">
					<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask pump-ask-accpet" answerid="${fv.taID}" ansUID="${fv.taUserID}" style="color: #FF0000;">采纳</a>
					<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask pump-ask-mofify" editorsetid="${fvindx.index+1}" style="color: #FF0000;display: none;">完善</a>
					<a class="btn-24-white goon-ask grid mr-10 pumpstyle pump-ask pump-ask-continue" editorsetid="${fvindx.index+1}" style="color: #FF0000">追问</a>
				</s:if>
				</s:if>
				
				<div class="mt-10 mb-10 f-12 f-gray pump-ask-editor" style="display:none;margin-top: 30px;">
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
</body>
</HTML>