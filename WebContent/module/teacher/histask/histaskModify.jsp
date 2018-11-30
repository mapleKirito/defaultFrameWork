<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
.table_9_addren{border-collapse: collapse;}
.table_9_addren .tatd { border: 1px dashed  #bbbfc2; }
</style>
<script type="text/javascript">  
$(document).ready(function(){
	//修改财富值在原有基础上追加
	$("#contentScroll").height(500);
	//input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示')},onsuccess:function(){}});//表单提交 
	$("#htaskTitle").formValidator({onshow:"请输入标题",onfocus:"请输入标题",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"标题不能为空,请确认"});
	$("#htaskClass").formValidator({onshow:"请输入问题分类",onfocus:"请输入问题分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"问题分类不能为空,请确认"});
	
	//回显问题是否拆分
	var htaskIssplit = '${initMap.histaskInfo.htaskIssplit}';
    if(htaskIssplit!=null && htaskIssplit.indexOf("1")>-1){
    	$("input#htaskIssplit:checkbox").attr("checked",true);
    	$("#htaskIssplitTR").show();
    	$("#taskcontent").hide();
    }
	
    //回显悬赏财富
	/* var htaskWealthval = '${initMap.histaskInfo.htaskWealthval}';
	if(htaskWealthval!=''){
    	$(".htaskWealthval[value='"+htaskWealthval+"']").attr("checked",'checked');
    	if(htaskIssplit!=null && htaskIssplit.indexOf("0")>-1){
    		$(".htaskWealthval[value='"+(htaskWealthval-1)+"']").attr("checked",'checked');	
    	}
    } */
    
  	//点击+号操作
	$(".table_9_addren img").die().live("click", function() {
		var sibinput = $(this).siblings("input").val();
		
		var numren = $(".numren").size();
		if(numren<10){
			if (sibinput != "") {
				$(this).remove();
				var name = $("#rewuname").html();
				var a = "<tr bgcolor='#ae9b84'><td width='10%' class='tatd' align='center'>" + name + "<span class='numren'>" + parseInt(numren + 1) + "</span></td><td width='90%' class='tatd' align='left'><input name='paramMap.htaskManyTitle' type='hidden' style='width: 350px;' value='title"+parseInt(numren + 1)+"'/>&nbsp;<img src='images/add.png' border='0' height='20px;' id='addren'><br /><br /><textarea cols='50'  id='htaskManyContent"+parseInt(numren + 1)+"' name='paramMap.htaskManyContent' rows='10'></textarea></td></tr>";
				$(".table_9_addren").append(a);
				getCkeditorByn(parseInt(numren + 1));
			} else {
				alert("任务标题不能为空");
				return false;
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
			alert("当前帐号财富值为" + userwalth + "财富，请重新选择。");
			$("input.htaskWealthval:eq(0)").attr("checked", 'checked');
		}
	});
	
});

document.onreadystatechange = function () {   
    if(document.readyState=="complete") { 
    	var l = "";
    	$(".table_9_addren tr").each(function(){
    		var a = parseInt($(this).children(".show").children("input").attr("hhwealth"));
    			if(a!=1){
    				a+=1;	
    			}
		   l += "," + a;
		});
    	$("#htaskManyWealthval").val(l.replace(/,/,""));
    	
    	$(".table_9_addren tr").last().children(".show").children("input").after("<img src='images/add.png' border='0' height='20px' id='addcate'>");
    }  
};    

function getCkeditorByn(n){
	CKEDITOR.replace('htaskManyContent' + n, {
		height: 60,
		filebrowserUploadUrl: 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID=' + '${paramMap.s_userID}',
		filebrowserImageUploadUrl: 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID=' + '${paramMap.s_userID}',
		filebrowserFlashUploadUrl: 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID=' + '${paramMap.s_userID}'
	});
}
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
	
	var usedWealth=0;
	if($("#htaskIssplit").attr("checked")=='checked'){
		
		$("input[name='paramMap.htaskManyTitle']").each(function(i) {
			//alert(hval * (i + 1) + " -- " + hz);
			
			var b = parseInt($("#defauWealth").val());
			if (i + 1 <= hz) {
				var c = parseInt(hval) + b;
				usedWealth+=parseInt(hval);
				a += "," + c;
			} else {
				a += "," + b;
			}
		});
	}else{
		usedWealth=parseInt(hval);
	}
	
	//alert(usedWealth);
	$("#htaskManyWealthval").val(a.replace(/,/, ""));
	$("#usedWealth").val(usedWealth);
	//验证每个任务是否为空
	var numren = $(".numren").size();
	
	var isEmpty=true;
	if (numren==2){
		numren=0;
	}
	for (var i=1;i<=numren;i++){
		var content=CKEDITOR.instances["htaskManyContent"+i].getData();
		content=content.replace("<p>","");
		content=content.replace("</p>","");
		//alert(content);
		if(content==""){
			alert("任务"+i+"标题不能为空");
			isEmpty=false;
		}
	}
	return isEmpty;
}
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" onsubmit="return dosubmit();">
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.tea_histask_param.imitationStep}">
<input name="paramMap.htaskID" type="hidden" id="htaskID" value="${initMap.histaskInfo.htaskID}"/>
<input name="paramMap.htaskWealthvalatu" type="hidden" id="htaskWealthval" value="${initMap.histaskInfo.htaskWealthval}"/>
<input type="hidden" name="paramMap.usedWealth" id="usedWealth">
<input type="hidden" name="paramMap.nowWealth" value="${initMap.userWealth.wealth}">
<s:if test="session.s_userType == 1 "><input type="hidden" name="paramMap.htaskIsReview" id="htaskIsReview" value="${session.srTeaIsAuditing}"></s:if>
<s:if test="session.s_userType == 2 "><input type="hidden" name="paramMap.htaskIsReview" id="htaskIsReview" value="${session.srStuIsAuditing}"></s:if>
<input type="hidden" name="paramMap.htaskManyWealthval" id="htaskManyWealthval" value="">
<input type="hidden" name="paramMap.defauWealth" value="0" id="defauWealth">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#e8e8e8" valign="top">
							<div  id="contentScroll" style="width: 100%;overflow: scroll;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
									 <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">问题标题：</td>
										<td width="85%" class="tatd" align="left">
											<input name="paramMap.htaskTitle" type="text" id="htaskTitle" style="width: 200px;" value="${initMap.histaskInfo.htaskTitle}"/>
											&nbsp;<font color="red">*</font><span id="htaskTitleTip" style="height:22px;"></span>
										</td>
									  </tr>
									  <tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">考题分类：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.htaskClass" id="htaskClass">
												<option>----请选择----</option>
												<option value="209" ${initMap.histaskInfo.htaskClass eq '209' ? 'selected':'' }>文物探究</option>
												<option value="210" ${initMap.histaskInfo.htaskClass eq '210' ? 'selected':'' }>事件探究</option>
												<option value="211" ${initMap.histaskInfo.htaskClass eq '211' ? 'selected':'' }>人物探究</option>
												<option value="212" ${initMap.histaskInfo.htaskClass eq '212' ? 'selected':'' }>其他</option>
											</select>
											&nbsp;<font color="red">*</font><span id="htaskClassTip" style="height:22px;width:297px"></span>
										</td>
									</tr>
									  <%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">问题是否拆分：</td>
											<td width="85%" class="tatd" align="left">
												<input type="checkbox" name="paramMap.htaskIssplit" id="htaskIssplit" value="${initMap.histaskInfo.htaskIssplit}" >									
											</td>
									  </tr> --%>
									  <tr bgcolor="#ae9b84" height="40px;">
										<td width="15%" class="tatd" align="right">追加悬赏财富：</td>
											<td width="85%" class="tatd" align="left" id="issplitValTR">
											<span>
											<input type="radio" name="paramMap.htaskWealthval" id="htaskWealthval1"class="htaskWealthval" value="0" checked="checked"><span>不悬赏</span>
											<input type="radio" name="paramMap.htaskWealthval" id="htaskWealthval2"class="htaskWealthval" value="10" ><span>10财富</span>
											<input type="radio" name="paramMap.htaskWealthval" id="htaskWealthval3"class="htaskWealthval" value="20" ><span>20财富</span>
											<input type="radio" name="paramMap.htaskWealthval" id="htaskWealthval4"class="htaskWealthval" value="50" ><span>50财富</span>
											<input type="radio" name="paramMap.htaskWealthval" id="htaskWealthval5"class="htaskWealthval" value="100" ><span>100财富</span>
											</span>
										</td>
									  </tr>
									  <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">问题关键词：</td>
											<td width="85%" class="tatd" align="left">
											<input name="paramMap.htaskKeywords" type="text" id="htaskKeywords" style="width: 250px;" value="${initMap.histaskInfo.htaskKeywords}" />	
											<font color="red">*</font><span>多个关键词用、(中文顿号)符号隔开</span>								
										</td>
									  </tr>
									  <tr bgcolor="#ae9b84" id="taskcontent">
										<td width="15%" class="tatd" align="right">问题内容：</td>
											<td width="85%" class="tatd" align="left">
												<textarea cols="50"  id="editorhtaskContent" name="paramMap.htaskContent" rows="10">${initMap.histaskInfo.htaskContent}</textarea>
											    <script type="text/javascript">
													  CKEDITOR.replace('editorhtaskContent',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
												</script>							
											</td>
									  </tr>
									  <tr bgcolor="#ae9b84" id="htaskIssplitTR" style="display: none;">
										<td width="15%" class="tatd" align="right">任务拆分：</td>
										<td width="85%" class="tatd" align="left">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9_addren">
											 	<s:iterator value="initMap.manytitleInfo" id="many" status="manyindx" >
											 	 <tr bgcolor="#ae9b84">
													<td width="10%" class="tatd" align="center"><span id="rewuname">任务</span><span class="numren">${manyindx.index+1}</span></td>
													<td width="90%" class="tatd show" align="left">
														<input name="paramMap.htaskManyTitle" type="hidden" hhwealth="${many.htaskWealthval-1!=0?many.htaskWealthval-1:1}" style="width: 350px;" value="${many.htaskTitle}"/><br /><br />
														<textarea cols="50"  id="htaskManyContent${manyindx.index+1}" name="paramMap.htaskManyContent" rows="10">${many.htaskContent}</textarea>
													    <script type="text/javascript">
													    	  getCkeditorByn('${manyindx.index+1}');
														</script>	
													</td>
												  </tr>
											 	</s:iterator>
											</table>
										</td>
									  </tr>
									<tr bgcolor="#ae9b84" align="center">
										<td colspan="4"><input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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