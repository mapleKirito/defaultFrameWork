<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><s:text name="systemName"/></title>
<style type="text/css">
#create_1_div{background: #606373;padding: 4px 15px;float: left;}
</style>
</head>
<body>
<script type="text/javascript">
$(function(){
	
	$("#askFrameWelcome").height($(window).height());
	$("#histasktw").click(function(){
		$("#askFrameWelcome").attr("src","decorateForwardAction.action?code=${pmsIndex.tea_histask_param.code}");
	});
	
	$("#histaskhd").click(function(){
		$("#askFrameWelcome").attr("src","decorateForwardAction.action?code=${pmsIndex.tea_histask_hd_param.code}");
	});
	
});
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="list-table" >
	<tr>
        <td class="tableCcenter">
        	<div class="lt-title">${pmsIndex.myAsk.name}</div>
			<div class="lt-command">
				<a href="javascript:void(0)" id="histasktw">
					<span>${pmsIndex.tea_histask_param.name}</span>
				</a>
			 	<a href="javascript:void(0)" id="histaskhd">
					<span>${pmsIndex.tea_histask_hd_param.name}</span>
				</a>
		 	</div>
        </td>
    </tr>
</table>                      
<iframe id="askFrameWelcome" name="askFrameWelcome" scrolling="no" marginheight="0" marginwidth="0" frameborder="0" src="decorateForwardAction.action?code=${pmsIndex.tea_histask_param.code}" width="100%" ></iframe>
</body>
</html>