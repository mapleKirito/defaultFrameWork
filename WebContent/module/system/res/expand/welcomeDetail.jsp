<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/welcomanager.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dragsort/jquery.dragsort-0.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/welcome_manger.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	init_('${fn:length(initMap.welcomeManager)}');
});
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.res_expand_room_mgr.imitationStep}">
<input type="hidden" name="paramMap.name" value="${pmsIndex.res_expand_room_welcome_manager.name}"> 
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" >
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#e8e8e8" valign="top" height="100%">
							<table border="0" cellspacing="0" cellpadding="0" class="table_9" style="width:100%;  height: 100%;">
								<tr bgcolor="#ae9b84">
									<td width="85%" align="center">
										<h2>分辨率选择
											<input type="radio" name="screenwidth_" value="1440"  checked="checked"><span>1024*768</span>
											<input type="radio" name="screenwidth_" value="1440"  checked="checked"><span>1440*900</span>
											<input type="radio" name="screenwidth_" value="1600"><span>1600*900</span>
											<input type="radio" name="screenwidth_" value="1920"><span>1920*1080</span>
										</h2>
									</td>
									<td align="center" width="15%"><input type="submit" name="BtnOk" value="保存" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" /></td>								
								</tr>
								<tr bgcolor="#ae9b84" ><td width="100%" align="center" colspan="2"><h2>触控版首页图片展示预览&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;红色框中图片将在触控版首页展示</h2></td></tr>
								<tr bgcolor="#ae9b84" >
									<td width="100%" class="tatd div_td" height="100%" colspan="3" align="center">
										<div id="div_li">
											<ul class="dragsort" id="list1" >
												<s:iterator value="initMap.welcomeManager" id="welMan" status="ind">
													<li id="img_li_${ind.index}">
														<div id="img_div"><img src="<%=request.getContextPath()%>/${welMan.recoFileup}" border="0" title="${welMan.name}" id="img_div_${ind.index}"><div id="text_div">${welMan.name}</div></div>
														<input type="hidden" value="${welMan.id}" alt="${welMan.name}">
													</li>
												</s:iterator>	
											</ul>	
											<div id="div_li_down"></div>
										</div>
										<s:if test="initMap.welcomeManager.isEmpty()">
											<h3 style="color: red;">本科室暂无首页数据</h3>
										</s:if>
										<input name="paramMap.list1SortOrder" type="hidden"  class="list1SortOrder" />
										<input name="paramMap.list1Itemidx" type="hidden" class="list1Itemidx" />
										<script type="text/javascript">
										$("#list1").dragsort({
											dragSelector: "div", 
											dragBetween: false, 
											dragEnd: saveOrder, 
											placeHolderTemplate: "<li class='placeHolder'><div></div></li>",
											scrollSpeed: 5
										});
										function saveOrder() {
											var data = $("#list1 li").map(function(){
												return $(this).children("input").val();
											}).get();
											$("input[class='list1SortOrder']").val(data.join("|"));
										};
										</script>
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