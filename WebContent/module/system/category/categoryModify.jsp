<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.autocomplete.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0_reset.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rsync_progress_bar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/res/category.js"></script>
<script type="text/javascript">
var setting = {
		async: {
			enable: true,
			url:"ajaxAction.action?code=003006007",
			dataType:"json",
			autoParam:["id"],
			dataFilter: filter
		},
		callback: {
			beforeAsync: beforeAsync,
			onClick: onClick
		}
	};

	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		if (childNodes.data){
			childNodes = childNodes.data;
		}
		return childNodes;
	}
	function beforeAsync(treeId, treeNode) {
		return treeNode ? treeNode.level < 5 : true;
	}

	function onClick(e, treeId, treeNode) {
		var id = treeNode.id;
		var name = treeNode.name;
		var level = treeNode.level;
		var path = treeNode.path;
		$("#cateParentID").attr("value", id);
		$("#cateParentName").attr("value", name);
		hideMenu();
		if (id == 0){
			$("#cateLevel").val("1");
			$("#oldCatePath").val(",0,");
			$("#selectName").show();
			$("#inputName").hide();
			$("#inputName").val("");
			$("#cateParentName").formValidator({onshow:"请选择上级分类",onfocus:"请选择上级分类",oncorrect:"选择正确"});
			/* $("#cateSelectSign").formValidator({onshow:"请选择分类标识",onfocus:"请选择当前目录",oncorrect:"选择正确"}); */
			/* $("#cateInputSign").formValidator(); */
		}
		else{
			//var sort = treeNode.sort;
			$("#cateLevel").val(level + 1);
			$("#oldCatePath").val(path);		
			//$("#rfSort").val(sort);
			$("#selectName").hide();
			$("#inputName").show();	
			$("#cateParentName").formValidator({onshow:"请选择上级分类",onfocus:"请选择上级分类",oncorrect:"选择正确"});
			/* $("#cateInputSign").formValidator({onshow:"请输入分类标识",onfocus:"请输入分类标识",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"分类标识不能为空,请确认"}).regexValidator({regexp:"username",datatype:"enum",onerror:"分类标识格式不正确"});; */
			/* $("#cateSelectSign").formValidator(); */
		}
	}

	function showMenu() {
		var cityObj = $("#cateParentName");
		var cityOffset = $("#cateParentName").offset();
		$("#menuContent").css({
			left : cityOffset.left + "px",
			top : cityOffset.top + cityObj.outerHeight() + "px"
		}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#menuContent").hide();
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(
				event.target).parents("#menuContent").length > 0)) {
			hideMenu();
		}
	}
	function checkCount(){
		if($("#OldcateName").val() ==  $("#cateName").val()){
			$("#check").val(0);
		}else{
			var cateName = $("#cateName").val();
			cateName = encodeURI(cateName);
			cateName = encodeURI(cateName);
			$.ajax({
				url:		'ajaxAction.action?code=003006010&paramMap.cateParentID='+$("#cateParentID").val()+'&paramMap.cateName=' +cateName,
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					if (textStatus == "success" && jsonData.data){
						if (jsonData.data.length > 0){
							$("#cateNameTip").attr("class","onError").html("分类名称重复");
							$("#check").val(1);
						}	else{
							$("#check").val(0);
						}			
					}
				},
				
				error:function(request,textStatus,error){
				
				}
			});
		}
		
	}
	$(document).ready(function() {
		$.fn.zTree.init($("#treeDemo"), setting);
		$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}});
		$("#cateParentName").formValidator({onshow:"请选择上级分类",onfocus:"请选择上级分类",oncorrect:"选择正确"});
		/* $("#cateInputSign").formValidator({onshow:"请输入分类标识",onfocus:"请输入分类标识",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"分类标识不能为空,请确认"}).regexValidator({regexp:"username",datatype:"enum",onerror:"分类标识格式不正确"}); */
		$("#cateName").formValidator({onshow:"请输入分类名称",onfocus:"请输入分类名称",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"分类名称不能为空,请确认"});
		$("#cateSort").formValidator({onshow:"请输入分类（数字）排序",onfocus:"请输入分类（数字）排序",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"分类排序（数字）不能为空,请确认"}).regexValidator({regexp:"num",datatype:"enum",onerror:"你输入不规范"})
		/* $("#cateSelectSign").formValidator();	 */
		$("#actionForm").submit(function(){
			
			if ($("#check").val() == 1){
				$("#cateNameTip").attr("class","onError").html("分类名称重复");
				alert("分类名称重复");
				return false;
			}else{
				return true;
			}		
		});
	});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" id="cateSign" name="paramMap.cateSign" /> 
<input type="hidden" name="paramMap.cateLevel" id="cateLevel"/> 
<input type="hidden"  id="check"  value="0"/> 
<input type="hidden" id="OldcateName" value="${initMap.categoryInfo.cateName}"/>
<input name="paramMap.cateID" type="hidden" id="cateID" value="${initMap.categoryInfo.cateID}"/>
<input name="paramMap.oldCatePath" type="hidden" id="oldRelation" value="${initMap.categoryInfo.catePath}"/>
<input name="paramMap.oldCateParentID" type="hidden" id="oldParentID" value="${initMap.categoryInfo.cateParentID}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.bsms_category_mgr.imitationStep}"> 
<div id="menuContent" class="menuContent" style="display: none; position: absolute;z-index: 1;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; "></ul>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div>
								<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
									<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0" style="background-color: #ae9b84;">
										<tr class="MeNewTDLine">
											<td width="15%" class="tatd" align="right">上级分类：</td>
											<td width="85%" class="tatd" align="left">
										    <input name="paramMap.cateParentID" type="hidden" maxlength="180" id="cateParentID" style="width: 200px;"  value="${initMap.categoryInfo.cateParentID}" /> 
										    &nbsp;<input name="paramMap.cateParentName" type="text" maxlength="180" readonly id="cateParentName" value="${initMap.categoryInfo.cateParentName}" style="width: 200px;"/> 
										    <a id="menuBtn" href="javascript:void(0)" onclick="showMenu(); return false;">选择</a>
											<font color="red">*</font><span id="rpParentNameTip"  style="position:absolute;height:22px;width:250px;"></span>									
											</td>
										  </tr>							
										<s:if test="paramMap.cateParentID != 0">
										  <tr id="inputName" class="MeNewTDLine">
											<td width="15%" class="tatd" class="tatd" align="right">分类标识：</td>
											<td width="85%" class="tatd" align="left">
											&nbsp;<input name="paramMap.cateInputSign" type="text" value="${initMap.categoryInfo.cateSign}" maxlength="180" id="cateInputSign"  style="width: 200px;" />&nbsp;
											<font color="red">*</font><span id="cateInputSignTip" style="position:absolute;height:22px;width:250px"></span>
											</td>
										  </tr>  
										  <tr id="selectName" style="display:none;" class="MeNewTDLine">
											<td width="15%" class="tatd" height="35" class="tatd" align="right">分类标识：</td>
											<td width="85%"  class="tatd" align="left">
											&nbsp;<select name="paramMap.cateSelectSign" id="cateSelectSign" style="width:200px;">
											  <option value="">请选择顶级分类</option>		
											  <option value="exhibition">文物博览室</option>
											  <option value="observation">专题研读室</option>
											  <option value="laboratory">教学研究室</option>
											  <option value="projection">影像资料室</option>
											  <option value="expand">自主探究室</option>
											</select>
											&nbsp;<font color="red">*</font><span id="cateSelectSignTip" style="position:absolute;height:22px;width:250px"></span>
											</td>
										  </tr>		
										</s:if>
															
										<tr class="MeNewTDLine">
											<td align="right" class="tatd" width="10%">分类名称：</td>
											<td class="tatd">
											&nbsp;<input name="paramMap.cateName" type="text" maxlength="180" id="cateName" onblur="checkCount()" style="width: 200px;" value="${initMap.categoryInfo.cateName}" />
											&nbsp;<font color="red">*</font><span id="cateNameTip"  style="position:absolute;height:22px;width:250px;"></span></td>
										</tr>
										<tr class="MeNewTDLine">
											<td align="right" class="tatd" width="10%">分类排序：</td>
											<td class="tatd">&nbsp;<input name="paramMap.cateSort" type="text" maxlength="180" id="cateSort" value="${initMap.categoryInfo.cateSort}" style="width: 200px;" />
											&nbsp;<font color="red">*</font><span id="cateSortTip" style="position:absolute;height:22px;width:250px"></span></td>
										</tr>
										<tr class="MeNewTDLine" align="center">
											<td colSpan="2" class="tatd">
													<input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
													<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
										</tr>
									</table>
                         		</form>
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