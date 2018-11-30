<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<html>
<title>${promptInfo.totalDescInfo}</title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
#climate_app span{margin-right: 5px;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	
	//input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示');},onsuccess:function(){}});//表单提交 
	//$("input[name='paramMap.testType']").formValidator({tipid:"testTypetsTip",onshow:"请至少选择一项考题类型",onfocus:"请至少选择一项考题类型",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"你选的个数不对"});
	$("#testName").formValidator({onshow:"请输入考题题目",onfocus:"请输入考题题目",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"考题题目不能为空,请确认"});
	//$("#testClass").formValidator({onshow:"请输入考题分类",onfocus:"请输入考题分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"考题分类不能为空,请确认"});
	
	$("#teIndivOptionA").formValidator({onshow:"请输入考题选项",onfocus:"请输入考题选项",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"考题选项不能为空,请确认"});
	$("#teIndivOptionB").formValidator({onshow:"请输入考题选项",onfocus:"请输入考题选项",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"考题选项不能为空,请确认"});
	$("#teIndivOptionC").formValidator({onshow:"请输入考题选项",onfocus:"请输入考题选项",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"考题选项不能为空,请确认"});
	$("#teIndivOptionD").formValidator({onshow:"请输入考题选项",onfocus:"请输入考题选项",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"考题选项不能为空,请确认"});
	$("#testRemarks").formValidator({onshow:"请输入答案解析",onfocus:"请输入答案解析",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"答案解析不能为空,请确认"});
	
	$("input.testGrades:checkbox").click(function(){
		if($(this).is(':checked')){
			$(this).siblings().attr('disabled', true);		
		}else{
			$(this).siblings().attr('disabled', false);
		}
	});
	
	var inittype = '${initMap.testInfo.testType}';
	initparam(inittype);
	
	$('[name="paramMap.testType"]:radio').each(function(){
		$(this).click(function(){
			var resType = $(this).val() ;
			initparam(resType);
			if(resType==3){
				 $("#teIndivOptionA").formValidator({});
				 $("#teIndivOptionB").formValidator({});
				 $("#teIndivOptionC").formValidator({});
				 $("#teIndivOptionD").formValidator({});
			}
		});
	});
	
	$('#actionForm').submit(function(){
		var typesub = $('input.testType:radio:checked').val(); 
		if(typesub == 3){
			 $("input[name='paramMap.testIndivAnswer']").each(function(){
			   $(this).attr("checked",false);
			 });  
			 $("#teIndivOptionA").formValidator({});
			 $("#teIndivOptionB").formValidator({});
			 $("#teIndivOptionC").formValidator({});
			 $("#teIndivOptionD").formValidator({});
			 $(".teIndivOption").val("");
		}
		if("1,2".indexOf(typesub) > -1){
			 $("input[name='paramMap.testJudgeAnswer']").each(function(){
			   	 $(this).attr("checked",false);
			 });  
		}
		if(typesub == 1){
			 $("input[type='checkbox']").each(function(){
			   	 $(this).attr("checked",false);
			 });  
		}
		if(typesub == 2){
			 $("input[type='radio']").each(function(){
			   	 $(this).attr("checked",false);
			 });  
		}
		if(typesub == 2&&$(".Manya input[type=checkbox][name=paramMap.testIndivAnswer][checked]").length<2){
			alert("多选题最少要有两个选项答案");
			return false;
		}
	});
});

function initparam(resType){
	if(resType == 1){
		$(".Indivoption").show();
		$(".Indiv").show();
		$(".Manya").hide();
		$(".Judge").hide();
	}else if(resType == 2){
		$(".Indivoption").show();
		$(".Indiv").hide();
		$(".Manya").show();
		$(".Judge").hide();
	}else{
		$(".Indivoption").hide();
		$(".Indiv").hide();
		$(".Manya").hide();
		$(".Judge").show();
		$("#teIndivOptionA").formValidator({});
		 $("#teIndivOptionB").formValidator({});
		 $("#teIndivOptionC").formValidator({});
		 $("#teIndivOptionD").formValidator({});
	}
}
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" name="code" value="${code}">
<input type="hidden" name="paramMap.testID" value="${initMap.testInfo.testID}">  
<input type="hidden" name="imitateStep" value="tea_test_param_step_1">
<input type="hidden" value="197" name="paramMap.testClass">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" >
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#e8e8e8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
									<%-- <tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">考题类型：</td>
										<td width="85%" class="tatd" align="left">
											<input type="radio" name="paramMap.testType" class="testType" value="1" ${initMap.testInfo.testType eq '1' ? 'checked':''}><span>单项选择题</span>
											<input type="radio" name="paramMap.testType" class="testType" value="2" ${initMap.testInfo.testType eq '2' ? 'checked':''}><span>多项选择题</span>
											<input type="radio" name="paramMap.testType" class="testType" value="3" ${initMap.testInfo.testType eq '3' ? 'checked':''}><span>判断题</span>
										</td>
									</tr>	 --%>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">考题题目：</td>
										<td width="85%" class="tatd" align="left">
											<input name="paramMap.testName" type="text" maxlength="180" id="testName" value="${initMap.testInfo.testName}"/>
											&nbsp;<font color="red">*</font><span id="testNameTip" style="position:absolute;height:22px;width:297px"></span>
										</td>
									</tr>
									<%-- <tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">考题分类：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.testClass" id="testClass">
												<option>----请选择----</option>
												<option value="998" ${initMap.testInfo.testClass eq '998' ? 'selected':'' }>自然地理</option>
												<option value="999" ${initMap.testInfo.testClass eq '999' ? 'selected':'' }>人文地理</option>
												<option value="1000" ${initMap.testInfo.testClass eq '1000' ? 'selected':'' }>区域地理</option>
												<option value="1001" ${initMap.testInfo.testClass eq '1001' ? 'selected':'' }>灾害地理</option>
												<option value="1002" ${initMap.testInfo.testClass eq '1002' ? 'selected':'' }>综合试卷</option>
											</select>
											&nbsp;<font color="red">*</font><span id="testClassTip" style="position:absolute;height:22px;width:297px"></span>
										</td>
									</tr> --%>	
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">考题分值：</td>
										<td width="85%" class="tatd" align="left">
											<input name="paramMap.testVal" type="text" maxlength="180" id="testVal" value="${initMap.testInfo.testVal}"/>
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84" class="Indivoption">
										<td width="15%" class="tatd" align="right">考题选项(选择题)：</td>
										<td width="85%" class="tatd" align="left">
											<%-- <span>A：</span><input name="paramMap.testIndivOptionA" type="text" id="teIndivOptionA" class="teIndivOption" value="${initMap.testInfo.testIndivOptionA}"/>
											<span>B：</span><input name="paramMap.testIndivOptionB" type="text" id="teIndivOptionB" class="teIndivOption" value="${initMap.testInfo.testIndivOptionB}"/>
											<span>C：</span><input name="paramMap.testIndivOptionC" type="text" id="teIndivOptionC" class="teIndivOption" value="${initMap.testInfo.testIndivOptionC}"/>
											<span>D：</span><input name="paramMap.testIndivOptionD" type="text" id="teIndivOptionD" class="teIndivOption" value="${initMap.testInfo.testIndivOptionD}"/> --%>
										
											<table width="70%" height="100%" border="0" cellspacing="0" cellpadding="0" >
												<tr>
													<td style="border: none;">
														<label><span>A：</span><input name="paramMap.testIndivOptionA" type="text" id="teIndivOptionA" value="${initMap.testInfo.testIndivOptionA}"/></label>
														&nbsp;<font color="red">*</font><span id="teIndivOptionATip" style="position:absolute;height:22px;width:297px"></span>
													</td>
														</tr>
												<tr>
															<td style="border: none;">
														<label><span>B：</span><input name="paramMap.testIndivOptionB" type="text" id="teIndivOptionB" value="${initMap.testInfo.testIndivOptionB}"/></label>
														&nbsp;<font color="red">*</font><span id="teIndivOptionBTip" style="position:absolute;height:22px;width:297px"></span>
													</td>
												</tr>
												<tr>
													<td style="border: none;"><label><span>C：</span><input name="paramMap.testIndivOptionC" type="text" id="teIndivOptionC" value="${initMap.testInfo.testIndivOptionC}"/></label>
													&nbsp;<font color="red">*</font><span id="teIndivOptionCTip" style="position:absolute;height:22px;width:297px"></span>
													</td>
													</tr>
												<tr>
													<td style="border: none;"><label><span>D：</span><input name="paramMap.testIndivOptionD" type="text" id="teIndivOptionD" value="${initMap.testInfo.testIndivOptionD}"/></label>
													&nbsp;<font color="red">*</font><span id="teIndivOptionDTip" style="position:absolute;height:22px;width:297px"></span>
													</td>
												</tr>
											</table>
										</td>
									</tr>	
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">考题选项(判断题)：</td>
										<td width="85%" class="tatd" align="left">
											<span>对</span><input type="radio" name="paramMap.teJudgeOption" value="y">
											<span>错</span><input type="radio" name="paramMap.teJudgeOption" value="n">
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84" class="Indiv">
										<td width="15%" class="tatd" align="right">考题答案(单项选择题)：</td>
										<td width="85%" class="tatd" align="left">
											<span>A</span><input type="radio" name="paramMap.testIndivAnswer" value="A" <s:if test="initMap.testInfo.testType == 1 and initMap.testInfo.testIndivAnswer.indexOf('A') > -1">checked</s:if>>
											<span>B</span><input type="radio" name="paramMap.testIndivAnswer" value="B" <s:if test="initMap.testInfo.testType == 1 and initMap.testInfo.testIndivAnswer.indexOf('B') > -1">checked</s:if>>
											<span>C</span><input type="radio" name="paramMap.testIndivAnswer" value="C" <s:if test="initMap.testInfo.testType == 1 and initMap.testInfo.testIndivAnswer.indexOf('C') > -1">checked</s:if>>
											<span>D</span><input type="radio" name="paramMap.testIndivAnswer" value="D" <s:if test="initMap.testInfo.testType == 1 and initMap.testInfo.testIndivAnswer.indexOf('D') > -1">checked</s:if>>
										</td>
									</tr>	
									<tr bgcolor="#ae9b84" class="Manya" style="display: none;">
										<td width="15%" class="tatd" align="right">考题答案(多项选择题)：</td>
										<td width="85%" class="tatd" align="left">
											<span>A</span><input type="checkbox" name="paramMap.testIndivAnswer" value="A" <s:if test="initMap.testInfo.testType == 2 and initMap.testInfo.testIndivAnswer.indexOf('A') > -1">checked</s:if>>
											<span>B</span><input type="checkbox" name="paramMap.testIndivAnswer" value="B" <s:if test="initMap.testInfo.testType == 2 and initMap.testInfo.testIndivAnswer.indexOf('B') > -1">checked</s:if>>
											<span>C</span><input type="checkbox" name="paramMap.testIndivAnswer" value="C" <s:if test="initMap.testInfo.testType == 2 and initMap.testInfo.testIndivAnswer.indexOf('C') > -1">checked</s:if>>
											<span>D</span><input type="checkbox" name="paramMap.testIndivAnswer" value="D" <s:if test="initMap.testInfo.testType == 2 and initMap.testInfo.testIndivAnswer.indexOf('D') > -1">checked</s:if>>
										</td>
									</tr>	
									<tr bgcolor="#ae9b84" class="Judge" style="display: none;">
										<td width="15%" class="tatd" align="right">考题答案(判断题)：</td>
										<td width="85%" class="tatd" align="left">
											<span>对</span><input type="radio" name="paramMap.testJudgeAnswer" value="y" ${initMap.testInfo.testJudgeAnswer eq 'y' ? 'checked':''}>
											<span>错</span><input type="radio" name="paramMap.testJudgeAnswer" value="n" ${initMap.testInfo.testJudgeAnswer eq 'n' ? 'checked':''}>
										</td>
									</tr>			
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">答案解析：</td>
										<td width="85%" class="tatd" align="left">
											<textarea cols="80" id="testRemarks" name="paramMap.testRemarks" >${initMap.testInfo.testRemarks}</textarea>
											&nbsp;<font color="red">*</font><span id="testRemarksTip" style="position:absolute;height:22px;width:297px"></span>
										</td>
									</tr>	
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">考题年级：</td>
										 <td width="85%" class="tatd" align="left" id="testGradesTR">
										    <input type="checkbox" name="paramMap.testGrades"  value="311" <s:if test="initMap.testInfo.testGrades.indexOf('311') > -1">checked</s:if>><span>七年级</span>&nbsp;
											<input type="checkbox" name="paramMap.testGrades"  value="312" <s:if test="initMap.testInfo.testGrades.indexOf('312') > -1">checked</s:if>><span>八年级</span>&nbsp;
											<input type="checkbox" name="paramMap.testGrades"  value="313" <s:if test="initMap.testInfo.testGrades.indexOf('313') > -1">checked</s:if>><span>九年级</span>
											<input type="checkbox" name="paramMap.testGrades"  value="321" <s:if test="initMap.testInfo.testGrades.indexOf('321') > -1">checked</s:if>><span>必修一</span>&nbsp;
											<input type="checkbox" name="paramMap.testGrades"  value="322" <s:if test="initMap.testInfo.testGrades.indexOf('322') > -1">checked</s:if>><span>必修二</span>&nbsp;
											<input type="checkbox" name="paramMap.testGrades"  value="323" <s:if test="initMap.testInfo.testGrades.indexOf('323') > -1">checked</s:if>><span>必修三</span>&nbsp;
											<input type="checkbox" name="paramMap.testGrades"  value="400" <s:if test="initMap.testInfo.testGrades.indexOf('400') > -1">checked</s:if>><span>其他</span>&nbsp;
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