<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
</head>
<body>
<script type="text/javascript">
$(function(){
	
	$(".tableCcenter .lt-command a").click(function(){
		$(this).addClass("lt-private").siblings().removeClass("lt-private");
		$("#expandFrameWelcome").attr("src","decorateForwardAction.action?code=" + $(this).attr("id"));
	});
	
});
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="list-table" >
	<tr>
        <td class="tableCcenter">
        	<div class="lt-title">${pmsIndex.res_expand_room_mgr.name}</div>
			<div class="lt-command">
				<a href="javascript:void(0)" id="${pmsIndex.sys_test_param.code}" class="ltselect">
					<span>${pmsIndex.sys_test_param.name}</span>
				</a>
				<a href="javascript:void(0)" id="${pmsIndex.sys_histask_param.code}" class="ltselect">
					<span>${pmsIndex.sys_histask_param.name}</span>
				</a>
				<a href="javascript:void(0)" id="${pmsIndex.sys_result_param.code}" class="ltselect">
					<span>${pmsIndex.sys_result_param.name}</span>
				</a>
		 	</div>
        </td>
    </tr>
</table>
<iframe id="expandFrameWelcome" name="expandFrameWelcome" scrolling="no" marginheight="0" marginwidth="0" frameborder="0" src="decorateForwardAction.action?code=${pmsIndex.sys_test_param.code}" width="100%" height="552px"></iframe>
</body>
</html>