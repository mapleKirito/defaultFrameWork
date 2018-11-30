<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/date/todayDate.css">
<script src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("body",parent.document).find('.menuTabTextNavigation').html('历史上的今天>'+$("#findYear").val()+$("#findMonth").val()+$("#findDay").val());
	$('#table2page').pageTB();
	 $(".history-today .btnHistory").click(function () {
	        if ($(".history-today").attr("data-count") == undefined) {
	            $(".history-today").attr("data-count", $(".history-today .historys li").length);
	        }
	        if ($(".history-today").attr("data-index") == undefined) {
	            $(".history-today").attr("data-index", 1);
	        }
	        var type = $(this).attr("data-type");
	        var historys = $(".history-today .historys ul");
	        if (type == "pre") {
	            if ($(".history-today").attr("data-index") >= $(".history-today").attr("data-count")) {
	            	art.dialog.alert("后面没有了~~");
	                return;
	            }
	            historys.animate({ left: "-=145px" });
	            $(".history-today").attr("data-index", parseInt($(".history-today").attr("data-index")) + 1);
	        } else if (type == "next") {
	            if ($(".history-today").attr("data-index") <=1) {
	                art.dialog.alert('前面没有了!!!');
	                return;
	            }
	            historys.animate({ left: "+=145px" });
	            $(".history-today").attr("data-index", parseInt($(".history-today").attr("data-index")) - 1);
	        }
	    });
});

function showHistory(id){
	//window.parent.tabClick("menu_name","历史上的今天详细",'9010',"paramMap.historyID="+id);
	window.parent.art.dialog.data('contextPath', '<%=request.getContextPath()%>');
	window.parent.art.dialog.open('decorateForwardAction.action?code=9010&paramMap.historyID='+id,{width:994,height:608,title:'历史上的今天详细',lock:'true',background:'#666666',opacity: '0.15'}) ;
}
</script>
<style type="text/css">
ul li{ list-style-type:none; white-space:nowrap; text-overflow:ellipsis; overflow: hidden; }
.tabcontent, ul li{width:660px; }
.pageb{margin: 0 auto; float: right;}
.my-answer-list li{ background-color: #957F65;}
.my-answer-list li:nth-child(2n){ background-color:#BEAF9D; }
.my-answer-list { color:white; }
.my-answer-list li em{ color:white; }
.tabcontent{float: left;}
.my-answer-list{padding-top: 15px;}
#CalendarMain { border: 0px solid #ccc; width: 380px; height: 380px; position: relative; z-index: 9999; right: 0px; top: 10px; background: #ae9b84; }
#title { width: 380px; height: 75px; line-height: 75px; font-size: 18px; font-weight: bold; position: relative; border-bottom: 1px solid #beaf9d; color: white; }
.gridright { float: right; width: 380px; display: inline; margin-top: 15px; }
a.currentitem:visited { color: #88361f; text-decoration: none; }
a.currentitem:link { color: #88361f; text-decoration: none; }
a:visited { color: #fff; text-decoration: none; }
a:link { color: #fff; text-decoration: none; }
.title a{vertical-align: middle;}
.my-answer-list li a{margin-left: 20px;}
.my-answer-list li em{margin-right: 20px;}
</style>
</head>
<body>
<input type="hidden" id="findYear" value="<%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %>">
<input type="hidden" id="findMonth" value="${paramMap.findMonth }">
<input type="hidden" id="findDay" value="${paramMap.findDay }">
<div id="layout_mainbody">
	<div class="page-container">	
		<div class="tabcontent">
            <ul class="my-answer-list">
                 <li>
                 	<a href="javascript:void(0);">事件</a>
                	 <em>时间</em>
                 </li>
            
            	<s:iterator value="initMap.history" id="history"  status="historyIndex">
               		<li onclick="showHistory(${history.historyID })">
               		<a href="javascript:void(0);">${history.historyTitle}</a>
               		<em>${history.historyNum}</em>
               		</li>
                </s:iterator>
            </ul>
            <div class="pageb" id="table2page">
				${initMap.paginated.pageContent}
			</div>
        </div>
        <!-- 日历选择 -->
		<div class="gridright">
				<div class="history-today">
					<div class="title">
						历史上的今天<span><a href="javascript:void(0)" onclick="window.parent.tabClick('9011','历史上的今天','9011',
						<%-- 'paramMap.historyNum=-<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>');">更多</a></span> --%>
						'paramMap.historyNum=-<%= new java.text.SimpleDateFormat("MM-dd").format(new java.util.Date()) %>&paramMap.findMonth=<%= new java.text.SimpleDateFormat("-MM").format(new java.util.Date())%>&paramMap.findDay=<%= new java.text.SimpleDateFormat("-dd").format(new java.util.Date())%>');">更多</a></span>
						<!-- -'+manth+'-'+dath+'&paramMap.findMonth='+findMonth+'&paramMap.findDay='+findDay-->
					</div>
					<a href="javascript:void(0)" data-type="next" class="btn btnHistory pre">&lt;</a>
				    <a href="javascript:void(0)" data-type="pre" class="btn btnHistory next">&gt;</a>
					<div class="historys">
						 <ul>
							 <s:iterator value="initMap.historyList" id="h" status="fv">
							 	<li onclick="showHistory(${h.historyID })">
								<a class="history" href="#">
									<span>${h.historyTitle }</span>
									<p>${h.historyInfo} </p>
								</a>
							</li>
							 </s:iterator>
							 </ul>
					</div>
				</div>
				
				<div id="CalendarMain">
							
					<DIV id="title">
						<A class="selectBtn month" onclick="CalendarHandler.CalculateLastMonthDays();" 
					href="javascript:void(0)"></A>
						<A class="selectBtn selectYear"></A>
						<A class="selectBtn selectMonth" onclick="CalendarHandler.CreateSelectMonth()"></A> 
					<A class="selectBtn nextMonth" onclick="CalendarHandler.CalculateNextMonthDays();" 
					href="javascript:void(0)"></A>
						<a class="selectBtn currentDay" onclick="CalendarHandler.CreateCurrentCalendar(0,0,0)" href="javascript:void(0)">今天 </a>
						<!-- <A class="selectBtn currentDay" onclick="CalendarHandler.CreateCurrentCalendar(0,0,0);" href="javascript:void(0)">今天</A> -->
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

<script src="js/date/scripts.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/date/todayDate.js"></script>
</body>
</html>