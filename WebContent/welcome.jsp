<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>     
<title><s:text name="systemName"/></title>
<metahttp-equiv=X-UA-Compatiblecontent=IE=EmulateIE7> 
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT"> 
<link href="css/style.css" rel="stylesheet" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/date/date.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript">
function closeOpen(){
	$(". aui_state_focus aui_state_lock").remove();
}
function showHistory(id){
	//window.parent.tabClick("menu_name","历史上的今天详细",'9010',"paramMap.historyID="+id);
	window.parent.art.dialog.data('contextPath', '<%=request.getContextPath()%>');
	window.parent.art.dialog.open('decorateForwardAction.action?code=9010&paramMap.historyID='+id,{width:1299,tu_big:0,height:299,title:'历史上的今天详细',lock:'true',background:'#666666',opacity: '0.15'}) ;
}
</script>
</head>
<body >
<div id="layout_mainbody" >
     <!-- 历史卷轴 -->
    <div id="page_taday" class="page-container" >
			<div class="auto-tab">
				<a href="javascript:void(0)" class="auto-tab-prev"></a> <a href="javascript:void(0)"
					class="auto-tab-next"></a>
				<div class="auto-tab-title">
					<ul>
					<s:iterator value="initMap.newsnews" id="fv" status="fvindx">
					<li>${fv.newsTitle}</li>
					</s:iterator>
					</ul>
				</div>
				<div class="auto-tab-content">
				<s:iterator value="initMap.newsnews" id="fv" status="fvindx">
					<div class="tabContent"  onclick="showInfo(${fv.newsID})" style="<s:property value="%{#fvindx.count==1?'':'display: none'}"/>;cursor:pointer" >
						<b class="t">${fv.newsTitle}</b>
						<%-- ${fv.newsInfo} --%>
						<s:if test="#fv.newsInfo.length() >100">
														 <s:property value="#fv.newsInfo.substring(0,100)" /> ...
								                     </s:if> <s:else>
															 <s:property value="#fv.newsInfo" />
													 </s:else>
					</div>
					</s:iterator>
				</div>
			</div>

			<div id="metrogrid" class="metro-grid">
				<a href="javascript:void(0)" onclick="res_funtion('observation_1')" class="h2 dark-brown"><span><i class="grid-icon1"></i>艺术史</span></a>
			    <a href="javascript:void(0)" onclick="res_funtion('observation_2')" class="w2 light-brown"><span><i class="grid-icon2"></i>历史人物</span> </a> 
				<a href="javascript:void(0)" onclick="res_funtion('observation_3')" class="green"><span><i class="grid-icon3"></i>政治制度史</span></a> 
				<a href="javascript:void(0)" onclick="res_funtion('observation_4')" class="sred"><span><i class="grid-icon4"></i>思想史</span></a> 
				<a href="javascript:void(0)" onclick="res_funtion('observation_5')" class="red"><span><i class="grid-icon5"></i>经济制度史</span></a>
				 
				<a href="javascript:void(0)" onclick="res_funtion('projection_1')" class="w2 cray"><span><i class="grid-icon6"></i>近代影像资料</span></a> 
				<a href="javascript:void(0)" onclick="res_funtion('projection_2')" class="h2 light-brown"><span><i class="grid-icon7"></i>纪录片</span></a> 
				<a href="javascript:void(0)" onclick="res_funtion('projection_3')"class="purple"><span><i class="grid-icon8"></i>科学还原</span></a>
				<a href="javascript:void(0)" onclick="res_funtion('projection_4')" class="gray"><span><i class="grid-icon9"></i>历史剧</span></a> 
				 
				<a href="javascript:void(0)" onclick="res_funtion('expand_1')" class="red"><span><i class="grid-icon10"></i>探究热身</span></a> 
				<a href="javascript:void(0)" onclick="res_funtion('expand_2')" class="red"><span><i class="grid-icon11"></i>探究广场</span></a>
				<a href="javascript:void(0)" onclick="res_funtion('expand_3')" class="orange"><span><i class="grid-icon12"></i>探究成果</span></a>
				 
				<a href="javascript:void(0)" onclick="res_funtion('laboratory_1')" class="green"><span><i class="grid-icon13"></i>课件参考</span></a>
				<a href="javascript:void(0)" onclick="res_funtion('laboratory_2')" class="blue"><span><i class="grid-icon14"></i>公开课</span></a>
				<a href="javascript:void(0)" onclick="res_funtion('lovecountry_2')" class="w2 green fr"><span><i class="grid-icon8"></i>校园追风</span></a>
			</div>

			<div class="gridright">
				<div class="history-today">
					<div class="title">
						历史上的今天<span><a href="javascript:void(0)" onclick="window.parent.tabClick('9011','历史上的今天','9011','paramMap.historyNum=<%= new java.text.SimpleDateFormat("-MM-dd").format(new java.util.Date())%>&paramMap.findMonth=<%= new java.text.SimpleDateFormat("-MM").format(new java.util.Date())%>&paramMap.findDay=<%= new java.text.SimpleDateFormat("-dd").format(new java.util.Date())%>');">更多</a></span>
					</div>
					<a href="javascript:void(0)" data-type="next" class="btn pre">&lt;</a> <a href="javascript:void(0)"
						data-type="pre" class="btn next">&gt;</a>
					<div class="historys">
						 <ul>	
							 <!-- 放到initMap中取值 -->
							 <s:iterator value="initMap.historyList" id="h" status="fv">
							 	<li onclick="showHistory(${h.historyID })">
								<a class="history" href="#">
									<span>${h.historyTitle }</span>
									<%-- <p>${h.historyInfo} </p> --%> 
								</a>
							</li>
							 </s:iterator>
							 </ul>
					</div>
				</div>
				
				<div id="calendar">
					<div id="calendar_center">
					 <div id="CalendarMain">
							
							<DIV id="title">
								<A class="selectBtn month" onclick="CalendarHandler.CalculateLastMonthDays();" 
							href="javascript:void(0)"></A>
								<A class="selectBtn selectYear"></A>
								<A class="selectBtn selectMonth" onclick="CalendarHandler.CreateSelectMonth()"></A> 
							<A class="selectBtn nextMonth" onclick="CalendarHandler.CalculateNextMonthDays();" 
							href="javascript:void(0)"></A>
								<A class="selectBtn currentDay" onclick="CalendarHandler.CreateCurrentCalendar(0,0,0);" href="javascript:void(0)">今天</A>
							</DIV>
							<DIV id="context">
								<DIV class="week">
									<H3 style="float: left;	font-family: "Microsoft Yahei Font";	text-align: center;	margin: 0;	padding: 0;	margin-top: 5px;font-size: 20px;"> 一 </H3>
									<H3 style="float: left;	font-family: "Microsoft Yahei Font";	text-align: center;	margin: 0;	padding: 0;	margin-top: 5px;font-size: 20px;"> 二 </H3>
									<H3 style="float: left;	font-family: "Microsoft Yahei Font";	text-align: center;	margin: 0;	padding: 0;	margin-top: 5px;font-size: 20px;"> 三 </H3>
									<H3 style="float: left;	font-family: "Microsoft Yahei Font";	text-align: center;	margin: 0;	padding: 0;	margin-top: 5px;font-size: 20px;"> 四 </H3>
									<H3 style="float: left;	 font-family: "Microsoft Yahei Font";   text-align: center;	margin: 0;	padding: 0;	margin-top: 5px;font-size: 20px;"> 五 </H3>
									<H3 style="float: left;	font-family: "Microsoft Yahei Font";	text-align: center;	margin: 0;	padding: 0;	margin-top: 5px;font-size: 20px;"> 六 </H3>
									<H3 style="float: left;	font-family: "Microsoft Yahei Font";	text-align: center;	margin: 0;	padding: 0;	margin-top: 5px;font-size: 20px;"> 日 </H3>
								</DIV>
								<DIV id="center" style="width: 300px;overflow: hidden;">
									<DIV id="centerMain" style="width: 900px; margin-left: -300px;">
										<DIV id="selectYearDiv" style="float: left;"></DIV>
											<DIV id="centerCalendarMain" style="float: left;">
										<DIV id="Container" style="overflow: hidden;float: left;"></DIV></DIV>
									<DIV id="selectMonthDiv" style="float: left;"></DIV></DIV>
								</DIV>	
						
							</div>
						</div>
					 </div>
				</div> 
		</div>
	</div>
</div>
<script src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/date/date.js"></script>
<script src="js/tweenmax.min.js"></script>
<script src="js/scripts.js"></script>
<script src="js/jQuery.welcome.js"></script>
</body>
</html>