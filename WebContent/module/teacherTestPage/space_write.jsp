<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#aTitle").formValidator({onshow:"请输入标题",onfocus:"标题不能为空（最多255个字符）",oncorrect:"输入正确"}).inputValidator({min:1,max:255,onerror:"标题的长度不正确"});
	$("#BtnOk").click(function(){
		var text=CKEDITOR.instances.aContent.document.getBody().getText();
		//alert(text);
		$("#aText").val(text);
		//return false;
	})
});
function checkAticle(){
	var text=CKEDITOR.instances.aContent.document.getBody().getText();
	//alert(text);
	//alert($("#aText").val(text));
	var aticleLong=getStrLength(text);
	//alert(aticleLong);
	if(aticleLong<524288){
		return true;
	}else{
		return false;
	}
}

function getStrLength(str) {  
    var cArr = str.match(/[^\x00-\xff]/ig);  
    return str.length + (cArr == null ? 0 : cArr.length);  
} 
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action" onsubmit="checkAticle();">
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.myArticle.imitationStep}"> 
<input type="hidden" id="wu" name="paramMap.aUserID"  value="${session.s_userID }"> 
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
							  <tr bgcolor="#ae9b84">
								<td width="15%" class="tatd" align="center">文章标题</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.aTitle" type="text" id="aTitle" style="width: 350px;" />
									<font color="red">*</font><span id="aTitleTip" style="position:absolute;height:22px;width:250px;"></span>									
								</td>
							  </tr>
							  <tr bgcolor="#ae9b84">
								<td width="15%" class="tatd" align="center">文章正文</td>
								<td width="85%" class="tatd" align="left">
									<input type="hidden" id="aText" name="paramMap.aText" > 
									<textarea cols="80" name="paramMap.aContent" id="aContent"  rows="10"></textarea>
								    <script type="text/javascript">
										  CKEDITOR.replace('aContent',{height : 320, filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
									</script>							
								</td>
							  </tr>
							  <tr bgcolor="#ae9b84">
								<td colspan="2" style="text-align: center;">
									<input type="submit" name="BtnOk" value="确认" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
									<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
								</td>
							  </tr>
							</table>				
						 </td>
				      </tr>
					</table>
			  	</td>
			</tr>
		</table>
	</td>
  </tr>
</table>
</form>
</body>
</html>