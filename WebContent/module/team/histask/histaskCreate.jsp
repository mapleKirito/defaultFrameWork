<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
.table_9_addren{border-collapse: collapse;}
.table_9_addren .tatd { border: 1px dashed  #bbbfc2; }
</style>
<script type="text/javascript">
$(document).ready(function(){	
	$("#contentScroll").height(500);
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#htaskTitle").formValidator({onshow:"请输入内容",onfocus:"内容不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"输入正确"});
	$("#htaskContent").formValidator({onshow:"请输入内容",onfocus:"内容不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"输入正确"});
	$("#htaskWealthval").formValidator({}).regexValidator({regexp:"num1",datatype:"enum",onerror:"问题默认财富值为10。输入追加财富值。"});
	
	//点击+号操作
	$(".table_9_addren img").die().live("click", function() {
		var sibinput = $(this).siblings("input").val();
		var numren = $(".numren").size();
		if(numren<10){
			if (sibinput != "") {
				$(this).remove();
				var name = $("#rewuname").html();
				var a = "<tr bgcolor='#ae9b84'><td width='10%' class='tatd' align='center'>" + name + "<span class='numren'>" + parseInt(numren + 1) + "</span></td><td width='90%' class='tatd' align='left'><input name='paramMap.htaskManyTitle' type='text' style='width: 350px;' value=''/>&nbsp;<img src='images/add.png' border='0' height='20px;' id='addren'><br /><br /><textarea cols='50'  id='htaskManyContent"+parseInt(numren + 1)+"' name='paramMap.htaskManyContent' rows='10'></textarea></td></tr>";
				$(".table_9_addren").append(a);
				getCkeditorByn(parseInt(numren + 1));
			} else {
				alert("当前任务不能为空");
			}	
		}else{
			alert("任务总数不得超过10个");
		}	
	});
	
	$("#htaskIssplit").click(function() {
		//选中任务拆分
		if ($('input#htaskIssplit:checkbox:checked').val() == "0") {
			$("#htaskIssplitTR").show();
			$("#htaskIssplit").val(1);
			$("#taskcontent").hide();
		} else {
			$("#htaskIssplitTR").hide();
			$("#htaskIssplit").val(0);
			$("#taskcontent").show();
		}
	});
	
	$(".htaskWealthval").click(function() {
		var hval = $('input.htaskWealthval:radio:checked').val();
		var userwalth = '${initMap.userWealth.wealth}';
	
		if (parseInt(hval) > parseInt(userwalth)) {
			alert("当前帐号财富值为" + hval + "财富，请重新选择。");
			$("input.htaskWealthval:eq(0)").attr("checked", 'checked');
		}
	});
	
});
function dosubmit() {
	var a = "", hz = "", hy = "";
	var numren = $(".numren").size();
	var userwalth = '${initMap.userWealth.wealth}';
	var hval = $('input.htaskWealthval:radio:checked').val();
	if (hval != 0) {
		hz = parseInt(userwalth) / parseInt(hval);
		hy = parseInt(userwalth) % parseInt(hval);
	} else {
		hz = hy = parseInt($("#defauWealth").val());
	}

	$("input[name='paramMap.htaskManyTitle']").each(function(i) {
		//alert(hval * (i + 1) + " -- " + hz);
		var b = parseInt($("#defauWealth").val());
		if (i + 1 <= hz) {
			var c = parseInt(hval) + b;
			a += "," + c;
		} else {
			a += "," + b;
		}
	});

	$("#htaskManyWealthval").val(a.replace(/,/, ""));
}

function getCkeditorByn(n){
	CKEDITOR.replace('htaskManyContent' + n, {
		height: 60,
		filebrowserUploadUrl: 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID=' + '${paramMap.s_userID}',
		filebrowserImageUploadUrl: 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID=' + '${paramMap.s_userID}',
		filebrowserFlashUploadUrl: 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID=' + '${paramMap.s_userID}'
	});
}
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action" onsubmit="return dosubmit();">
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.tea_histask_param.imitationStep}">
<s:if test="session.s_userType == 1 "><input type="hidden" name="paramMap.htaskIsReview" id="htaskIsReview" value="${session.srTeaIsAuditing}"></s:if>
<s:if test="session.s_userType == 2 "><input type="hidden" name="paramMap.htaskIsReview" id="htaskIsReview" value="${session.srStuIsAuditing}"></s:if>

<input type="hidden" name="paramMap.htaskManyWealthval" id="htaskManyWealthval" value="">
<input type="hidden" name="paramMap.defauWealth" value="1" id="defauWealth">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div  id="contentScroll" style="width: 100%;overflow: scroll;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">问题标题：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.htaskTitle" type="text" id="htaskTitle" style="width: 350px;" />
										<font color="red">*</font><span id="htaskTitleTip"  style="position:absolute;height:22px;width:250px;"></span>									
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">问题是否拆分：</td>
										<td width="85%" class="tatd" align="left">
											<input type="checkbox" name="paramMap.htaskIssplit" id="htaskIssplit" value="0">									
										</td>
								  </tr>
								  <tr bgcolor="#ae9b84" height="40px;">
									<td width="15%" class="tatd" align="right">悬赏财富：</td>
										<td width="85%" class="tatd" align="left" id="issplitValTR">
										<span>
										<input type="radio" name="paramMap.htaskWealthval" class="htaskWealthval" value="0" checked="checked"><span>不悬赏</span>
										<input type="radio" name="paramMap.htaskWealthval" class="htaskWealthval" value="10" ><span>10财富</span>
										<input type="radio" name="paramMap.htaskWealthval" class="htaskWealthval" value="20" ><span>20财富</span>
										<input type="radio" name="paramMap.htaskWealthval" class="htaskWealthval" value="50" ><span>50财富</span>
										<input type="radio" name="paramMap.htaskWealthval" class="htaskWealthval" value="100" ><span>100财富</span>
										</span>
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">问题关键词：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.htaskKeywords" type="text" id="htaskKeywords" style="width: 250px;"/>	
										<font color="red">*</font><span>多个关键词用、(中文顿号)符号隔开</span>								
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84" id="taskcontent">
									<td width="15%" class="tatd" align="right">问题内容：</td>
										<td width="85%" class="tatd" align="left">
											<textarea cols="50"  id="editorhtaskContent" name="paramMap.htaskContent" rows="10"></textarea>
										    <script type="text/javascript">
												  CKEDITOR.replace('editorhtaskContent',{height : 60, filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
											</script>							
										</td>
								  </tr>
								  <tr bgcolor="#ae9b84" id="htaskIssplitTR" style="display: none;">
									<td width="15%" class="tatd" align="right">任务拆分：</td>
									<td width="85%" class="tatd" align="left">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9_addren">
										  <tr bgcolor="#ae9b84">
											<td width="10%" class="tatd" align="center"><span id="rewuname">任务</span><span class="numren">1</span></td>
											<td width="90%" class="tatd" align="left">
												<input name="paramMap.htaskManyTitle" type="text" style="width: 350px;" value=""/>	
												<img src="images/add.png" border="0" height="20px;" id="addcate"><br /><br />
												<textarea cols="50"  id="htaskManyContent1" name="paramMap.htaskManyContent" rows="10"></textarea>
											    <script type="text/javascript">
													  CKEDITOR.replace('htaskManyContent1',{height : 60, filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
												</script>							
											</td>
										  </tr>
										</table>
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td colspan="2" style="text-align: center;">
										<input type="submit" name="BtnOk" value="确认" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
										<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
									</td>
								  </tr>
								</table>	
							</div>			
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