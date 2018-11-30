<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<html>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link href="<%=request.getContextPath()%>/qc/css/style.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/qc/css/calendar.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<style type="text/css">
#table2page input[type=button],#table2page input[type=text],#table1page input[type=button],#table1page input[type=text],#table3page input[type=button],#table3page input[type=text],#table4page input[type=button],#table4page input[type=text],#table5page input[type=button],#table5page input[type=text],#table6page input[type=button],#table6page input[type=text]
	{
	border: none;
	background: #ae9b84;
	color: white;
	padding-bottom: 4px;
	text-align: center;
	height: 29px;
	line-height: 29px;
	width: 70px;
	margin-left: 10px;
	margin-right: 10px;
	position: relative;
	top: -1px;
}

#goPage {
	line-height: 29px;
}

.ssjh-tjrs .left {
	width: 730px;
}

div.LunBo {
	position: relative;
	list-style-type: none;
	height: 170px;
	width: 730px;
}

div.LunBo ul li {
	position: absolute;
	height: 170px;
	width: 620px;
	left: 0px;
	top: 0px;
	display: none;
	padding-top: 20px;
}

div.LunBo ul li.CurrentPic {
	display: block;
}

div.LunBo div.LunBoNum {
	position: absolute;
	left: 620px;
	bottom: 11px;
	width: 60px;
	text-align: right;
	/* background-color: #999; */
	padding-left: 10px;
}

div.LunBo div.LunBoNum span {
	height: 20px;
	width: 15px;
	display: block;
	line-height: 20px;
	text-align: center;
	margin-top: 5px;
	margin-bottom: 5px;
	float: left;
	cursor: pointer;
}

div.LunBo div.LunBoNum span.CurrentNum {
	background-color: #e64747;
}
</style>
</head>
<body>
	<!--师生交互内容开始-->
	<div id="layout_mainbody">
		<div class="page-container tjrs">
			<div class="ssjh-tjrs">
				<div class="left" style="float: left; display: inline; zoom: 1;">
					<div class="LunBo tjrs-panel panel">
						<p class="title topborder" style="font-size: 14px;">小试身手</p>
						<ul id="dateT">
							<s:if test="null==initMap.topTitle||initMap.topTitle.isEmpty()">
                       			暂时没有题目
                       		</s:if>
							<s:else>
						
								<s:iterator value="initMap.topTitle" id="t" status="index">
									<li class="${index.index==0?'CurrentPic':'' }">
										<div tgrades="${t.testGrades }" tindex="${t.t_index }"
											class="body testTitle"
											style="font-size: 14px; padding: 0px; width: 700px; margin-left: 15px; height: 100px; margin-top: 10px; overflow: hidden;cursor:pointer;">
											${t.testName } </br>
											<s:if test="#t.testType == 1 ||#t.testType == 2 ">
												<span style="color:black;font-weight:bold">${t.testIndivOptionA==""?"":"A."}&nbsp;</span>${t.testIndivOptionA}&nbsp;&nbsp;
												<span style="color:black;font-weight:bold">${t.testIndivOptionB==""?"":"B."}&nbsp;</span>${t.testIndivOptionB}&nbsp;&nbsp;
												<span style="color:black;font-weight:bold">${t.testIndivOptionC==""?"":"C."}&nbsp;</span>${t.testIndivOptionC}&nbsp;&nbsp;
												<span style="color:black;font-weight:bold">${t.testIndivOptionD==""?"":"D."}&nbsp;</span>${t.testIndivOptionD }
											</s:if>
												<s:if test="#t.testType == 3 ">
												<span style="color:black;font-weight:bold">对&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
												<span style="color:black;font-weight:bold">错&nbsp;</span>
											</s:if>

										</div>
									</li>
								</s:iterator>
							</s:else>
						</ul>
						<s:if test="null==initMap.topTitle||initMap.topTitle.isEmpty()">

						</s:if>
						<s:else>
							
							<script type="text/javascript" language="javascript">
								
								var i = 0 ;
								setInterval(function(){
									if(i==$("#dateT").find("li").length){
										i=0;
									}
									$("#dateT").find("li").eq(i).fadeIn(600).siblings().hide();
									   i++;
							    },3000);
							</script>
						</s:else>
					</div>

					<p class="course-list">
						<a href="javascript:void(0);" id="course-a" class="course-a on">七年级</a>
						<a href="javascript:void(0);" id="course-a" class="course-a">八年级</a>
						<a href="javascript:void(0);" id="course-a" class="course-a">九年级</a>
						<a href="javascript:void(0);" id="course-a" class="course-a">必修一</a>
						<a href="javascript:void(0);" id="course-a" class="course-a">必修二</a>
						<a href="javascript:void(0);" id="course-a" class="course-a">必修三</a>
						<a href="javascript:void(0);" id="course-a" class="course-a">其他</a>
					</p>

					<div class="my-answer-panel panel course-list-panellist1">
						<p class="title topborder">
							<i class="icon-title-line"></i>所有题目
						</p>
						<div class="body">
							<ul class="my-answer-panel-list">
								<s:iterator value="initMap.bx01testview" id="fvbx01"
									status="fvbx01indx">
									<li pageNum="${initMap.bx01Paginated.currentPage}" num="${fvbx01indx.index}">
										<h5>
											<a href="javascript:void(0);"> <%-- <span>【问题】</span> --%>
												<s:if test="#fvbx01.htaskIssplit == 1">
													<span>【任务】</span>
												</s:if> <s:else>
													<span>【问题】</span>
										
												</s:else> ${fvbx01.testName} </a>
										</h5>
										<p class="answer-info">&nbsp;&nbsp;创建时间：${fvbx01.testCreateTime}</p>
									</li>
								</s:iterator>
								<s:if test="initMap.bx01testview.isEmpty()">
									<li class="nulldata-panel-li-1"></li>
									<script type="text/javascript">
										var dataindex = 1;
										$(".nulldata-panel-li-" + dataindex).html($(".course-list a").eq(dataindex - 1).html()+ "分类下数据暂时为空!!!");
										$("#table" + dataindex + "page").hide();
									</script>
								</s:if>
							</ul>
							<p class="ssjh-pager pageb" id="table1page">
								${initMap.bx01Paginated.pageContent}</p>
						</div>
					</div>
					<div class="my-answer-panel panel course-list-panellist2"
						style="display: none;">
						<p class="title topborder">
							<i class="icon-title-line"></i>所有题目
						</p>
						<div class="body">
							<ul class="my-answer-panel-list">
								<s:iterator value="initMap.bx02testview" id="fvbx02" status="fvbx02indx">
									<li pageNum="${initMap.bx02Paginated.currentPage}"
										num="${fvbx02indx.index}">
										<h5>
											<a href="javascript:void(0);"><span>【问题】</span>${fvbx02.testName}</a>
										</h5>
										<p class="answer-info">&nbsp;&nbsp;创建时间：${fvbx02.testCreateTime}</p>
									</li>
								</s:iterator>
								<s:if test="initMap.bx02testview.isEmpty()">
									<li class="nulldata-panel-li-2"></li>
									<script type="text/javascript">
										var dataindex = 2;
										$(".nulldata-panel-li-" + dataindex).html($(".course-list a").eq(dataindex - 1).html()+ "分类下数据暂时为空!!!");
										$("#table" + dataindex + "page").hide();
									</script>
								</s:if>
							</ul>
							<p class="ssjh-pager pageb" id="table2page">
								${initMap.bx02Paginated.pageContent}</p>
						</div>
					</div>
					<div class="my-answer-panel panel course-list-panellist3"
						style="display: none;">
						<p class="title topborder">
							<i class="icon-title-line"></i>所有题目
						</p>
						<div class="body">
							<ul class="my-answer-panel-list">
								<s:iterator value="initMap.bx03testview" id="fvbx03" status="fvbx03indx">
									<li pageNum="${initMap.bx03Paginated.currentPage}"
										num="${fvbx03indx.index}">
										<h5>
											<a href="javascript:void(0);"><span>【问题】</span>${fvbx03.testName}</a>
										</h5>
										<p class="answer-info">&nbsp;&nbsp;创建时间：${fvbx03.testCreateTime}</p>
									</li>
								</s:iterator>
								<s:if test="initMap.bx03testview.isEmpty()">
									<li class="nulldata-panel-li-3"></li>
									<script type="text/javascript">
										var dataindex = 3;
										$(".nulldata-panel-li-" + dataindex).html($(".course-list a").eq(dataindex - 1).html()+ "分类下数据暂时为空!!!");
										$("#table" + dataindex + "page").hide();
									</script>
								</s:if>
							</ul>
							<p class="ssjh-pager pageb" id="table3page">
								${initMap.bx03Paginated.pageContent}</p>
						</div>
					</div>
					<div class="my-answer-panel panel course-list-panellist4"
						style="display: none;">
						<p class="title topborder">
							<i class="icon-title-line"></i>所有题目
						</p>
						<div class="body">
							<ul class="my-answer-panel-list">
								<s:iterator value="initMap.xx01testview" id="fvxx01" status="fvxx01indx">
									<li pageNum="${initMap.xx01Paginated.currentPage}"
										num="${fvxx01indx.index}">
										<h5>
											<a href="javascript:void(0);"><span>【问题】</span>${fvxx01.testName}</a>
										</h5>
										<p class="answer-info">&nbsp;&nbsp;创建时间：${fvxx01.testCreateTime}</p>
									</li>
								</s:iterator>
								<s:if test="initMap.xx01testview.isEmpty()">
									<li class="nulldata-panel-li-4"></li>
									<script type="text/javascript">
										var dataindex = 4;
										$(".nulldata-panel-li-" + dataindex).html($(".course-list a").eq(dataindex - 1).html()+ "分类下数据暂时为空!!!");
										$("#table" + dataindex + "page").hide();
									</script>
								</s:if>
							</ul>
							<p class="ssjh-pager pageb" id="table4page">
								${initMap.xx01Paginated.pageContent}</p>
						</div>
					</div>
					<div class="my-answer-panel panel course-list-panellist5" style="display: none;">
						<p class="title topborder">
							<i class="icon-title-line"></i>所有题目
						</p>
						<div class="body">
							<ul class="my-answer-panel-list">
								<s:iterator value="initMap.xx02testview" id="fvxx02" status="fvxx02indx">
									<li pageNum="${initMap.xx02Paginated.currentPage}"
										num="${fvxx02indx.index}">
										<h5>
											<a href="javascript:void(0);"><span>【问题】</span>${fvxx02.testName}</a>
										</h5>
										<p class="answer-info">&nbsp;&nbsp;创建时间：${fvxx02.testCreateTime}</p>
									</li>
								</s:iterator>
								<s:if test="initMap.xx02testview.isEmpty()">
									<li class="nulldata-panel-li-5"></li>
									<script type="text/javascript">
										var dataindex = 5;
										$(".nulldata-panel-li-" + dataindex).html($(".course-list a").eq(dataindex - 1).html()+ "分类下数据暂时为空!!!");
										$("#table" + dataindex + "page").hide();
									</script>
								</s:if>
							</ul>
							<p class="ssjh-pager pageb" id="table5page">
								${initMap.xx02Paginated.pageContent}</p>
						</div>
					</div>
					<div class="my-answer-panel panel course-list-panellist6"
						style="display: none;">
						<p class="title topborder">
							<i class="icon-title-line"></i>所有题目
						</p>
						<div class="body">
							<ul class="my-answer-panel-list">
								<s:iterator value="initMap.xx03testview" id="fvxx03"
									status="fvxx03indx">
									<li pageNum="${initMap.xx03Paginated.currentPage}"
										num="${fvxx03indx.index}">
										<h5>
											<a href="javascript:void(0);"><span>【问题】</span>${fvxx03.testName}</a>
										</h5>
										<p class="answer-info">&nbsp;&nbsp;创建时间：${fvxx03.testCreateTime}</p>
									</li>
								</s:iterator>
								<s:if test="initMap.xx03testview.isEmpty()">
									<li class="nulldata-panel-li-6"></li>
									<script type="text/javascript">
										var dataindex = 6;
										$(".nulldata-panel-li-" + dataindex).html($(".course-list a").eq(dataindex - 1).html()+ "分类下数据暂时为空!!!");
										$("#table" + dataindex + "page").hide();
									</script>
								</s:if>
							</ul>
							<p class="ssjh-pager pageb" id="table6page">
								${initMap.xx03Paginated.pageContent}</p>
						</div>
					</div>
					<div class="my-answer-panel panel course-list-panellist7" style="display: none;">
						<p class="title topborder">
							<i class="icon-title-line"></i>所有题目
						</p>
						<div class="body">
							<ul class="my-answer-panel-list">
								<s:iterator value="initMap.qt01testview" id="fvqt01" status="fvqt01indx">
									<li pageNum="${initMap.qt01Paginated.currentPage}" num="${fvqt01indx.index}">
										<h5>
											<a href="javascript:void(0);"><span>【问题】</span>${fvqt01.testName}</a>
										</h5>
										<p class="answer-info">&nbsp;&nbsp;创建时间：${fvqt01.testCreateTime}</p>
									</li>
								</s:iterator>
								<s:if test="initMap.qt01testview.isEmpty()">
									<li class="nulldata-panel-li-7"></li>
									<script type="text/javascript">
										var dataindex = 7;
										$(".nulldata-panel-li-" + dataindex).html($(".course-list a").eq(dataindex - 1).html()+ "分类下数据暂时为空!!!");
										$("#table" + dataindex + "page").hide();
									</script>
								</s:if>
							</ul>
							<p class="ssjh-pager pageb" id="table6page">
								${initMap.qt01Paginated.pageContent}</p>
						</div>
					</div>
				</div>
				<div class="right" style="float: right; display: inline; zoom: 1;">
					<div class="spanel tjrs right">
						<p class="title">今日之星</p>
						<div class="body">
							<ul class="user-list">
								<s:iterator value="initMap.testGradesView" id="testGradesid"
									status="testgradesindex">
									<li><a style="background-image: none;"href="javascript:void(0);">
											<img width="64px" height="64px" src="${testGradesid.tcUserImg}" onerror="this.src='images/default/default_img.jpg'" />
										</a>
										<p class="info">
											<a href="javascript:void(0);"><s:property
													value="#testGradesid.tcAccount" /> </a> <span><s:property
													value="#testGradesid.tcCreateTime" /> </span>
										</p>
									</li>
								</s:iterator>
								<s:if test="initMap.testGradesView.isEmpty()">
									<li class="nulldata-testGradesView"></li>
									<script type="text/javascript">
										$(".nulldata-testGradesView").html($(".right .title").html()+ "下数据暂时为空!!!");
									</script>
								</s:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--师生交互内容结束-->
	<script src="<%=request.getContextPath()%>/qc/js/jquery-1.7.2.min.js"></script>
	<script src="<%=request.getContextPath()%>/qc/js/tweenmax.min.js"></script>
	<script src="<%=request.getContextPath()%>/qc/js/scripts.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
	<input type="hidden" id="course-list-a-value" value="${(paramMap.courselistavalue==null||paramMap.courselistavalue=='')?1:paramMap.courselistavalue}">
	<script type="text/javascript">
		$(document).ready(function() {
			var screenWidth=window.screen.width;
			var screenHeight= window.screen.height;
			if(screenWidth<=1024 && screenHeight<=768){
			    var leftWidth = $("#layout_left",window.parent.document).width();
		        if (leftWidth == 0) {
		            $(".search-box",window.parent.document).css({ left: 0 });
		            $(".page-controller",window.parent.document).css({ left: 0 });
		            $("#navigation",window.parent.document).stop(true,true).animate({ left: 192 });
		            $("#navigation",window.parent.document).show().animate({ width: ($(window).innerWidth()-192) }, 500)
		            $(this).html("&lt;");
					$("#layout_left",window.parent.document).animate({ width: 192 }, 500);
					$("#layout_left_pms",window.parent.document).animate({ width: 192 }, 500);
		            $("#layout_right",window.parent.document).stop(true,true).animate({ left: 192 });
		            $("#btn_scale",window.parent.document).stop(true, true).animate({ left: 192 });
		        } else {
		            $(".search-box",window.parent.document).css({ left: 0 });
		            $(".page-controller",window.parent.document).css({ left: 0 });
					$("#navigation",window.parent.document).stop(true,true).animate({ left: 0 });
		            $("#navigation",window.parent.document).show().animate({ width: '100%' });           
				   $("#layout_left",window.parent.document).stop(true, true).animate({ width: 0 }, 500, function () {
		               // $(this).hide();
		            });
				   $("#layout_left_pms",window.parent.document).stop(true, true).animate({ width: 0 }, 500, function () {
		              // $(this).hide();
		           });
		            $("#btn_scale",window.parent.document).stop(true, true).animate({ left: 0 }, 500);
		            $("#layout_right",window.parent.document).stop(true, true).animate({ left: 0 }, 500);
		            $(this).html("&gt;");
		        } 
		   
			}
			
			var $tab = $(".course-list a");
			$tab.each(function(i) {
					$("#table" + (i + 1) + "page").pageTB(); 
				});
			var courselistavalue = '${paramMap.courselistavalue}';
			if (courselistavalue != '') {
				$(".course-list-panellist" + (courselistavalue)).show().siblings(".my-answer-panel").hide();
				$tab.eq(courselistavalue - 1).addClass("on").siblings().removeClass("on");
			}

			$tab.click(function() {
				var index = $tab.index(this);
				$("#course-list-a-value").val(index + 1);
				$(".course-list-panellist" + (index + 1)).show().siblings(".my-answer-panel").hide();
				$(this).addClass("on").siblings().removeClass("on");
			});

			var $skip = $(".my-answer-panel .body li");
			var skips = [ "311", "312", "313", "321", "322","323", "400" ];
				$skip.each(function() {
				var pn = parseInt($(this).attr("pageNum"));
				var i = parseInt($(this).attr("num"));
				$(this).find("a").click(
					function() {
						var testNum=((pn-1)*8+i);
						//var testNum = i;
						//alert(testNum);
						var index_ = $("#course-list-a-value").val();
						//window.parent.tabClick("munu_name",skips[index_-1],'-1701',"paramMap.testGrades = " + skips[index_-1]);
						//alert(skips[index_-1]+"==="+testNum);
						art.dialog.data('contextPath','/dm');
						art.dialog.open('decorateForwardAction.action?code=-1701&paramMap.testGrades ='+ skips[index_ - 1]+ '&paramMap.testNum ='+ testNum,
							{
								width : 950,
								height : 604,
								title : '探究热身',
								lock : 'true',
								background : '#666666',
								opacity : '0.15'
							});
						});
					});
					$(".testTitle").each(function() {
						$(this).click(function() {
							//alert($(this).attr("tgrades")+"==="+$(this).attr("tindex"));
							art.dialog.data('contextPath','/dm');
							art.dialog.open('decorateForwardAction.action?code=-1701&paramMap.testGrades ='+ $(this).attr("tgrades")+ '&paramMap.testNum ='+ $(this).attr("tindex"),
								{
									width : 950,
									height : 604,
									title : '探究热身',
									lock : 'true',
									background : '#666666',
									opacity : '0.15'
								});

						});
					});
				});

		/*修正小组成员头像问题*/
		$(document).ready(function() {
			$('.user-list img').each(function() {
				if ($(this).attr('src') == '') {
					$(this).attr('src', 'images/default/default_img.jpg');
				}
			});
		});
	</script>

</body>
</html>