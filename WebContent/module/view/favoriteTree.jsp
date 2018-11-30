<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
            String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/skin.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript">
var setting = {
	data: {
		simpleData: {
			enable: true
		}
	},
	callback: {
		onClick: onClick
	}
};
function onClick(e, treeId, treeNode) {
	$("#favoriteId").val(treeNode.id);
	$("#level").val(treeNode.level);
	$("#sort").val(treeNode.sort);
	$("#fpath").val(treeNode.path);
}	
var zNodes = ${initMap.favoriteInfo};
$(document).ready(function(){
	$("#BtnClose").click(function(){
		$("html",window.parent.document).find("#screen__").css("display","none");
		$("html",window.parent.document).find("#message__").css("display","none");
	});	
	
	$("#BtnOk").click(function(){
		var fval = $("#favoriteId").val();
		if (!fval){
			alert("请选择要收藏夹！");
		}
		else{
			var id = $("#favoriteId").val();
			var sort = $("#sort").val();
			var level = $("#level").val();
			var fpath = $("#fpath").val();
			var param = 'code=-701014&paramMap.tempCode=${tempCode}'
			+'&paramMap.grGrade=${paramMap.grGrade}&paramMap.path=${path}&paramMap.temppname=${paramMap.pname}'
			+'&paramMap.resType='+sort+'&paramMap.pid=${paramMap.pid}&paramMap.temppid=${paramMap.temppid}&paramMap.st=${paramMap.st}'  
			+'&paramMap.resname=${paramMap.resname}&paramMap.favoriteId=' + id
			+'&paramMap.sort='+sort + '&paramMap.level='+level +'&paramMap.fpath=' + fpath +'&'+ new Date();
			$.ajax({
				
				url:		'ajaxAction.action',
				
				type:	    'get',
				
				timeout:	'60000',
				
				data:	param,
				
				dataType:	'json',
				
				beforeSend:function(request){},
				
				complete:function(request,textStatus){},
				
				success:function(jsonData,textStatus){
					
					
					if (textStatus == "success"){
						if (jsonData.resultData.intResult > 0){
							alert("加入收藏夹成功！");
						}
						else{
							alert(jsonData.resultData.content);
						}
						$("html",window.parent.document).find("#screen__").css("display","none");
						$("html",window.parent.document).find("#message__").css("display","none");
					}
				},
				
				error:function(request,textStatus,error){}
			}); 			
		}
	});		
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	//var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	//zTree.setting.check.chkboxType = {"Y":"ps", "N":"s"};
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" id="favoriteId">
<input type="hidden" id="level">
<input type="hidden" id="sort">
<input type="hidden" id="fpath">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;" height="250" width="280">
		<div id="menuContent" class="menuContent" style="position:absolute;width:280px;height:250px;overflow:auto;">
			<ul id="treeDemo" class="ztree" style="margin:0px;width:260px;"></ul>
		</div>    	
	</td>
  </tr>
  <!-- 
  <tr>
    <td valign="top" style="padding:5px;" height="80" width="280">
    	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
		    <tr>
		    <td valign="top" style="padding:5px;" width="280">
    			<input type="text" name="f" id="f"/>
    		</td>
    		</tr>    	
		    <tr>
		    <td valign="top" style="padding:5px;" width="280">
    			<input type="button" name="BtnNew" value="新建文件夹" id="BtnNew" class="SkyButtonBlurLong" onMouseOut="this.className='SkyButtonBlurLong'" onMouseOver="this.className='SkyButtonFocusLong'"/>
    		</td>
    		</tr>
    	</table>
    </td>
  </tr>  
   -->
  <tr>
    <td valign="top" align="center" height="50" style="padding:5px;">
    	<input type="button" name="BtnOk" value="确定" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
    	<input type="button" name="BtnOk" value="关闭" id="BtnClose"  class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
	</td>
  </tr>    
</table>
</form>
</body>
</html>
