<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>数字生物馆</title>
<SCRIPT type=text/javascript src="space/jquery.js"></SCRIPT>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
</head>
<script type="text/javascript">
function beforeSub(){
	 var str=CKEDITOR.instances["wContent"].document.getBody().getText();
	 alert(str);
}
</script>
<body>
<div id="writeInfo">
<form id="wForm" name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadWriteAction.action" onsubmit="beforeSub()">
	<input type="hidden" name="code" value="-600701"> 
	<!-- <input type="hidden" id="wc" name="paramMap.wContent" > 
	<input type="hidden" id="wt" name="paramMap.wTitle" >  -->
	<input type="hidden" id="wu" name="paramMap.wUserID"  value="${session.s_userID }"> 
	<input type="hidden" id="wText" name="paramMap.wText"  > 

	<input type="text" name="paramMap.wTitle" id="writeTitle" value="在此处输入标题" style="width: 300px;margin:15px 0px 10px 220px;">
	<textarea cols="80" name="paramMap.wContent" id="wContent"  rows="10"></textarea>
	<input type="submit" value="保存" id="OKbtn">&nbsp&nbsp
	<input type="button" value="返回" id="Cbtn">
</form>
	<script type="text/javascript">
	
	var tm=$("#writeTitle").val();
	$("#writeTitle").focus(function(){
		if($(this).val()==tm){
			$(this).val("");
		}
	}).blur(function(){
		if($(this).val()==""){
			$(this).val(tm);
		}
	});
	if(CKEDITOR.instances.wContent){
		 var editor = CKEDITOR.instances["wContent"];  
         if(editor) editor.destroy(true); 
	}
		CKEDITOR.replace('wContent',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=space', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=space', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=space' });
		/* $("#OKbtn").click(function(){
			var title=$("#writeTitle").val();
			//title = encodeURI(encodeURI(title));
			var userID=${session.s_userID };
			var data = CKEDITOR.instances.wContent.getData();
			//data = encodeURI(encodeURI(data));
			//alert("title="+title+"\n"+"content="+data);
			$("#wc").val(data);
			$("#wt").val(title);
			$("#wForm").submit(); */
			/* $.ajax({
				url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=-600701&paramMap.wUserID=' + userID
						+'&paramMap.wContent=' +data
						+'&paramMap.wTitle=' +title,
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					if (textStatus == "success"){
						$("#ans",window.parent.document).html("成功");
					}
					else{
						$("#ans",window.parent.document).html("失败");
					}
					$("#ans",window.parent.document).show();
					$("#space_frame",window.parent.document).hide();
				},
				
				error:function(request,textStatus,error){}
			}); */
		/* });  */
		
		$("#Cbtn").click(function(){
			$("#cont",window.parent.document).attr("src","");
			$("#ul_lists",window.parent.document).show();
			$("#space_frame",window.parent.document).hide();
		});
		
	</script>
</div>
</body>
</html>