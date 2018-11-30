<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
    <link href="qc/css/style.css" rel="stylesheet" />
    <link href="qc/css/gallery.css" rel="stylesheet" />
<script type="text/javascript">
$(function(){
	
	$(".tabcontrol .tabtitle a").click(function(){


		$(this).addClass("on").siblings().removeClass("on");
		$("#resourceUploadFrameWelcome").attr("src","decorateForwardAction.action?code=" + $(this).attr("id")+"&paramMap.userID=${session.s_userID}");
	});
	
});
</script>
<style type="text/css">
.tabcontentT{padding: 20px;background: white;}
.tabcontrol {
width: 705px;}
.tabcontrol div.tabtitle-bg {width: 705px;}

</style>
</head>
<body>
<div class="ssjh-index-row3 tabcontrol">
     <div class="tabtitle-bg"></div>
	     <p class="tabtitle">
	         <a href="javascript:void(0);" id="${pmsIndex.my_favorite_mgr.code}" class="ltselect tab on">${pmsIndex.my_favorite_mgr.name}</a>
	         <s:if test="session.s_userType == 1 ">
	         <a href="javascript:void(0);" id="${pmsIndex.my_resource_mgr.code}" class="ltselect tab">${pmsIndex.my_resource_mgr.name}</a>
	         </s:if>
	         <a href="javascript:void(0);" id="${pmsIndex.res_movement.code}" class="ltselect tab">${pmsIndex.res_movement.name}</a>
	     </p>
	  <div class="tabcontents">
	      <div class="tabcontentT">
	   	 	 <iframe id="resourceUploadFrameWelcome" name="resourceUploadFrameWelcome" scrolling="no" marginheight="0" marginwidth="0" frameborder="0" src="decorateForwardAction.action?code=${pmsIndex.my_favorite_mgr.code}" width="100%" height="552px"></iframe>
	  	 </div>
     </div>
 </div> 
<%-- <table width="100%" border="0" cellpadding="0" cellspacing="0" class="list-table" >
	<tr>
        <td class="tableCcenter">
        	<div class="lt-title">${pmsIndex.myRes.name}</div>
			<div class="lt-command">
				<a href="javascript:void(0)" id="${pmsIndex.my_favorite_mgr.code}" class="ltselect">
					<span>${pmsIndex.my_favorite_mgr.name}</span>
				</a>
				<s:if test="session.s_userType == 1 ">
					<a href="javascript:void(0)" id="${pmsIndex.my_resource_mgr.code}" class="ltselect">
						<span>${pmsIndex.my_resource_mgr.name}</span>
					</a>
				</s:if>
				<a href="javascript:void(0)" id="${pmsIndex.res_movement.code}" class="ltselect">
					<span>${pmsIndex.res_movement.name}</span>
				</a>
		 	</div>
        </td>
    </tr>
</table> --%>
 <script src="qc/js/jquery-1.7.2.min.js"></script>
    <script src="qc/js/tweenmax.min.js"></script>
    <script src="qc/js/jquery.bxslider.min.js"></script>
    <script src="qc/js/scripts.js"></script>

</body>
</html>