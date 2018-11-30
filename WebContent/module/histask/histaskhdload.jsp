<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<html> 
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>
<head>
<script type="text/javascript">
$(document).ready(function(){	
	if(parseInt('${fn:length(initMap.answerAcceptInfo)}') >0){
		$("#best-answer").show();
	}
});
</script>
</head>
<body>
<div id="best-answer-load" class="title topborder-green">
	<%-- <div class="hd line mb-10">
		<span class="grid-r f-aid pos-time mt-20">${initMap.testdetailInfo.htaskAccpetTime}</span>
		<span class="answer-type answer-best grid">
		</span>
		<span class="answer-title h2 grid">
			提问者采纳
		</span>
	</div> --%>
	<i class="sccpetiamge" style="display: block;margin-left: 18px;float: left;width: 41px;height: 57px;background-image: url('images/asspetimg.png');"></i>
	<p class="title line" style="line-height: 57px;">问题采纳</p>
	<div class="bd answer" style="padding: 0px 18px 18px 18px;">
		<div class="line info f-aid">
			${fvAccpet.taUserAccount}
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
</body>
</HTML>