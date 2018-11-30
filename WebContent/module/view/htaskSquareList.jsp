<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/skin.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link href="<%=request.getContextPath()%>/qc/css/style.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/qc/css/calendar.css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/qc/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/qc/js/tweenmax.min.js"></script>
<script src="<%=request.getContextPath()%>/js/scripts.js"></script>
<script src="<%=request.getContextPath()%>/qc/js/jquery.bxslider.min.js"></script> 
<style type="text/css">
#table2page input[type=button] ,#table2page input[type=text],#table1page input[type=button] ,#table1page input[type=text],#table3page input[type=button] ,#table3page input[type=text],
#table4page input[type=button] ,#table4page input[type=text],#table5page input[type=button] ,#table5page input[type=text],
#table6page input[type=button] ,#table6page input[type=text]  {
border:none; background:#ae9b84; color:white; padding-bottom:4px; text-align:center; height:29px; line-height:29px;width:70px;margin-left: 10px;margin-right: 10px;position: relative;top:-1px; }
#goPage{line-height:29px;}
.ssjh-tjrs .left { width: 630px; }
</style>
</head>
<body>
   <!--师生交互内容开始-->
   
    <div id="layout_mainbody" style =" visibility : hidden">
        <div class="page-container tjgc">
            <div class="ssjh-tjgc">
                <!--任务进度-->
                <div class="my-task panel topget">
                	<p class="title topborder">任务进度</p>
                    <div class="body">
                        <div class="my-tasks tabcontrol">
                        	<h5><span>【题目】</span>${initMap.htaskSquareTopTitle.htaskTitle}</h5>
                            <div class="tabcontents">
                                <div class="tabcontent tlfb">
                                    <a href="javascript:void(0);" class="fb-task-list-prev"></a>
                                    <a href="javascript:void(0);" class="fb-task-list-next"></a>
                                    <ul class="task-list fb">
                                    	<s:iterator id="fvtop" status="fvtopindx" value="initMap.htaskSquareTop">
                                    		<s:if test="#fvtop.htaskIsAccept == 1"><li taskchoosetagindexhref="${fvtopindx.index+1}" createkeywords="${initMap.htaskSquareTopTitle.htaskKeywords}" createhtaskID="${initMap.htaskSquareTopTitle.htaskID}" createuser="${initMap.htaskSquareTopTitle.htaskUserCreate}" class="top_li"><a href="javascript:void(0);" class="completed"><i class="icon-right-arrow-big"></i><em>${fvtopindx.index+1}</em>已完成</a></li></s:if>
                                    		<s:if test="#fvtop.htaskIsAccept == 0"><li taskchoosetagindexhref="${fvtopindx.index+1}" createkeywords="${initMap.htaskSquareTopTitle.htaskKeywords}" createhtaskID="${initMap.htaskSquareTopTitle.htaskID}" createuser="${initMap.htaskSquareTopTitle.htaskUserCreate}" class="top_li"><a href="javascript:void(0);" class="uncompleted"><i class="icon-right-arrow-big"></i><em>${fvtopindx.index+1}</em>未完成</a></li></s:if>
                                    	</s:iterator>
                                    	<s:if test="initMap.htaskSquareTop.isEmpty()">
				                    		<div class="nulldata-htaskSquareTop"></div>
					                        <script type="text/javascript">
				                   		  		$(".nulldata-htaskSquareTop").html($(".topget .title").html()+"下数据暂时为空!!!");
				           
				                   		  		$(".topget h5,.topget .fb-task-list-prev,.topget .fb-task-list-next").hide();
				                   		  	</script>
				                        </s:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
				
				<p class="course-list">
	                <a href="javascript:void(0);" id="course-a" class="course-a on">文物探究</a>
	                <a href="javascript:void(0);" id="course-a" class="course-a">事件探究</a>
	                <a href="javascript:void(0);" id="course-a" class="course-a">人物探究</a>
	                <a href="javascript:void(0);" id="course-a" class="course-a">其他</a>
	                <s:if test="session.s_userType == 1 || session.s_userType == 2 ">
	                <span id="addBtn" style="width: 100px;height: 37px;line-height: 32px;display: inline-block;text-align: center;color: white;font-size: 12px;border-radius: 2px;cursor: pointer;float: right;background: url(images/icon-spriter.png) 0px -1050px no-repeat;" id="course-a" class="course-a">创建</span>
	            	</s:if>
                </p>
                
                <div class="my-answer-panel panel course-list-panellist1">
				   <p class="title topborder"><i class="icon-title-line"></i>提问列表</p>
				   <div class="body">
						<ul class="my-answer-panel-list">
						    <s:iterator id="fv" status="fvindx" value="initMap.htaskSquarelist01">
	                            <li>
	                                <h5><a htaskIssplit="${fv.htaskIssplit }" createkeywords="${fv.htaskKeywords}" createhtaskID="${fv.htaskID}" createuser="${fv.htaskUserCreate}"	class="htaskTitle" style="cursor: pointer;"><s:if test="#fv.htaskIssplit == 1"><span>【任务】<span></s:if><s:else><span>【问题】<span></s:else>${fv.htaskTitle}</a></h5>
	                                <p class="answer-info">${fv.htaskhdCount}个回答&nbsp;|&nbsp;提问者：${fv.htaskUserAccount}<em><s:date name="#fv.htaskCreatetime" format="yyyy-MM-dd hh:mm:ss"/></em></p>
	                            </li>
	                        </s:iterator>
	                        <s:if test="initMap.htaskSquarelist01.isEmpty()">
	                    	<li class="nulldata-htaskSquarelist01"></li>
		                        <script type="text/javascript">
			                        var dataindex = 1;
	                       		  	$(".nulldata-htaskSquarelist0"+dataindex).html($(".course-list a").eq(dataindex-1).html()+"分类下数据暂时为空!!!");
	                       		  	$("#table"+dataindex+"page").hide();
	                   		  	</script>
	                        </s:if>
					   </ul>
					   <p class="ssjh-pager pageb" id="table1page">
						   ${initMap.HtaskSquareList01.pageContent}
					   </p>
				   </div>
				</div>
				<div class="my-answer-panel panel course-list-panellist2" style="display: none;">
				   <p class="title topborder"><i class="icon-title-line"></i>提问列表</p>
				   <div class="body">
						<ul class="my-answer-panel-list">
						    <s:iterator id="fv" status="fvindx" value="initMap.htaskSquarelist02">
	                            <li>
	                                <h5><a htaskIssplit="${fv.htaskIssplit }" createkeywords="${fv.htaskKeywords}" createhtaskID="${fv.htaskID}" createuser="${fv.htaskUserCreate}"	class="htaskTitle" style="cursor: pointer;"><s:if test="#fv.htaskIssplit == 1"><span>【任务】<span></s:if><s:else><span>【问题】<span></s:else>${fv.htaskTitle}</a></h5>
	                                <p class="answer-info">${fv.htaskhdCount}个回答&nbsp;|&nbsp;提问者：${fv.htaskUserAccount}<em><s:date name="#fv.htaskCreatetime" format="yyyy-MM-dd hh:mm:ss"/></em></p>
	                            </li>
	                        </s:iterator>
	                        <s:if test="initMap.htaskSquarelist02.isEmpty()">
	                    	<li class="nulldata-htaskSquarelist02"></li>
		                        <script type="text/javascript">
			                        var dataindex = 2;
	                       		  	$(".nulldata-htaskSquarelist0"+dataindex).html($(".course-list a").eq(dataindex-1).html()+"分类下数据暂时为空!!!");
	                       		  	$("#table"+dataindex+"page").hide();
	                   		  	</script>
	                        </s:if>
					   </ul>
					   <p class="ssjh-pager pageb" id="table2page">
						   ${initMap.HtaskSquareList02.pageContent}
					   </p>
				   </div>
				</div>		
				<div class="my-answer-panel panel course-list-panellist3" style="display: none;">
				   <p class="title topborder"><i class="icon-title-line"></i>提问列表</p>
				   <div class="body">
						<ul class="my-answer-panel-list">
						    <s:iterator id="fv" status="fvindx" value="initMap.htaskSquarelist03">
	                            <li>
	                                <h5><a htaskIssplit="${fv.htaskIssplit }" createkeywords="${fv.htaskKeywords}" createhtaskID="${fv.htaskID}" createuser="${fv.htaskUserCreate}"	class="htaskTitle" style="cursor: pointer;"><s:if test="#fv.htaskIssplit == 1"><span>【任务】<span></s:if><s:else><span>【问题】<span></s:else>${fv.htaskTitle}</a></h5>
	                                <p class="answer-info">${fv.htaskhdCount}个回答&nbsp;|&nbsp;提问者：${fv.htaskUserAccount}<em><s:date name="#fv.htaskCreatetime" format="yyyy-MM-dd hh:mm:ss"/></em></p>
	                            </li>
	                        </s:iterator>
	                        <s:if test="initMap.htaskSquarelist03.isEmpty()">
	                    	<li class="nulldata-htaskSquarelist03"></li>
		                        <script type="text/javascript">
			                        var dataindex = 3;
	                       		  	$(".nulldata-htaskSquarelist0"+dataindex).html($(".course-list a").eq(dataindex-1).html()+"分类下数据暂时为空!!!");
	                       		  	$("#table"+dataindex+"page").hide();
	                   		  	</script>
	                        </s:if>
					   </ul>
					   <p class="ssjh-pager pageb" id="table3page">
						   ${initMap.HtaskSquareList03.pageContent}
					   </p>
				   </div>
				</div>
				<div class="my-answer-panel panel course-list-panellist4" style="display: none;">
				   <p class="title topborder"><i class="icon-title-line"></i>提问列表</p>
				   <div class="body">
						<ul class="my-answer-panel-list">
						    <s:iterator id="fv" status="fvindx" value="initMap.htaskSquarelist04">
	                            <li>
	                                <h5><a htaskIssplit="${fv.htaskIssplit }" createkeywords="${fv.htaskKeywords}" createhtaskID="${fv.htaskID}" createuser="${fv.htaskUserCreate}"	class="htaskTitle" style="cursor: pointer;"><s:if test="#fv.htaskIssplit == 1"><span>【任务】<span></s:if><s:else><span>【问题】<span></s:else>${fv.htaskTitle}</a></h5>
	                                <p class="answer-info">${fv.htaskhdCount}个回答&nbsp;|&nbsp;提问者：${fv.htaskUserAccount}<em><s:date name="#fv.htaskCreatetime" format="yyyy-MM-dd hh:mm:ss"/></em></p>
	                            </li>
	                        </s:iterator>
	                        <s:if test="initMap.htaskSquarelist04.isEmpty()">
	                    	<li class="nulldata-htaskSquarelist04"></li>
		                        <script type="text/javascript">
			                        var dataindex = 4;
	                       		  	$(".nulldata-htaskSquarelist0"+dataindex).html($(".course-list a").eq(dataindex-1).html()+"分类下数据暂时为空!!!");
	                       		  	$("#table"+dataindex+"page").hide();
	                   		  	</script>
	                        </s:if>
					   </ul>
					   <p class="ssjh-pager pageb" id="table3page">
						   ${initMap.HtaskSquareList04.pageContent}
					   </p>
				   </div>
				</div>
            </div>
        </div>
    </div>
       
    <input type="hidden" id="htaskSquarelistavalue" value="1">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tlfb>ul").bxSlider({
                maxSlides: 3,
                infiniteLoop: false,
                slideWidth: 209,
                slideMargin: 12,
                controls: true,
                nextText: "",
                prevText: "",
                prevSelector: "a.fb-task-list-prev",
                nextSelector: "a.fb-task-list-next",
                pager: false
            });
            
            $("#addBtn").click(function(){
        		window.parent.tabClick("munu_name","发起提问","-13900","");
        	});
            $(".top_li").click(function(){
        		var createuser = $(this).attr("createuser");
        		var s_userID = '${paramMap.s_userID}';
        		var createhtaskID = $(this).attr("createhtaskID");
        		var createkeywords = $(this).attr("createkeywords");
        		createkeywords = encodeURI(createkeywords); 
        		createkeywords = encodeURI(createkeywords); 
        		var taskchoosetagindexhref = $(this).attr("taskchoosetagindexhref");
        		var thecode = "-1890002";
        		if(parseInt(createuser) == parseInt(s_userID)){
        			thecode = "-1890001";
        		}
        		//alert(thecode);
        		window.parent.tabClick("munu_name","问题浏览",thecode,"&paramMap.createkeywords="+createkeywords+"&paramMap.htaskID="+createhtaskID+"&paramMap.taskchoosetagindexhref="+taskchoosetagindexhref+"&pageSize=8&type=1");
        	});
            
            $(".htaskTitle").click(function(){
        		var createuser = $(this).attr("createuser");
        		var s_userID = '${paramMap.s_userID}';
        		var createhtaskID = $(this).attr("createhtaskID");
        		var createkeywords = $(this).attr("createkeywords");
        		createkeywords = encodeURI(createkeywords); 
        		createkeywords = encodeURI(createkeywords); 
        		var htaskIssplit=$(this).attr("htaskIssplit");
        		var thecode = "-1890001";
        		if(htaskIssplit==1){
        			thecode = "-1890002";
        		}
        		window.parent.tabClick("munu_name","问题浏览",thecode,"paramMap.taskchoosetagindexhref=1&paramMap.createkeywords="+createkeywords+"&paramMap.htaskID="+createhtaskID+"&pageSize=8&type=1");
        	});
            
            var $tab = $(".course-list a");
            
    		$tab.each(function(i){
    			$("#table"+(i+1)+"page").pageTB();
    		});
    		
    		var htaskSquarelistavalue = '${paramMap.htaskSquarelistavalue}';
    		if(htaskSquarelistavalue != ''){
    			$(".course-list-panellist"+(htaskSquarelistavalue)).show().siblings(".my-answer-panel").hide();
    			$tab.eq(htaskSquarelistavalue-1).addClass("on").siblings().removeClass("on");
    		}
    		
    		$tab.click(function(){
    			var index = $tab.index(this);
    			$("#htaskSquarelistavalue").val(index+1);
    			$(".course-list-panellist"+(index+1)).show().siblings(".my-answer-panel").hide();
    			$(this).addClass("on").siblings().removeClass("on");
    		});
        });
        var i = setTimeout('check()',100);
        function check() {
        	$("#layout_mainbody").attr("style","");
        }
    </script>
</body>
</html>