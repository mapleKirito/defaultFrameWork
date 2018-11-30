<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<html>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/skin.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link href="<%=request.getContextPath()%>/qc/css/style.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/qc/css/calendar.css" rel="stylesheet" />
<style type="text/css">
#table2page input[type=button] ,#table2page input[type=text],#table1page input[type=button] ,#table1page input[type=text],#table3page input[type=button] ,#table3page input[type=text],
#table4page input[type=button] ,#table4page input[type=text],#table5page input[type=button] ,#table5page input[type=text],
#table6page input[type=button] ,#table6page input[type=text]  {
border:none; background:#ae9b84; color:white; padding-bottom:4px; text-align:center; height:29px; line-height:29px;width:70px;margin-left: 10px;margin-right: 10px;position: relative;top:-1px; }
#goPage{line-height:29px;}
.ssjh-tjrs .left { width: 630px; }
.my-answer-panel-list li h5,.gain-list li{cursor: pointer;}
ul li{ list-style-type:none; white-space:nowrap; text-overflow:ellipsis; overflow: hidden; }
</style>
<script type="text/javascript">

var userAgent = navigator.userAgent, 
rMsie = /(msie\s|trident.*rv:)([\w.]+)/, 
rFirefox = /(firefox)\/([\w.]+)/, 
rOpera = /(opera).+version\/([\w.]+)/, 
rChrome = /(chrome)\/([\w.]+)/, 
rSafari = /version\/([\w.]+).*(safari)/;
var browser;
var version;
var ua = userAgent.toLowerCase();

document.onreadystatechange = function () {
   if(document.readyState=="complete") {
     
    } ;
}; 

function uaMatch(ua) {
	var match = rMsie.exec(ua);
	if (match != null) {
		return { browser : "IE", version : match[2] || "0" };
	}
	var match = rFirefox.exec(ua);
	if (match != null) {
		return { browser : match[1] || "", version : match[2] || "0" };
	}
	var match = rOpera.exec(ua);
	if (match != null) {
		return { browser : match[1] || "", version : match[2] || "0" };
	}
	var match = rChrome.exec(ua);
	if (match != null) {
		return { browser : match[1] || "", version : match[2] || "0" };
	}
	var match = rSafari.exec(ua);
	if (match != null) {
		return { browser : match[2] || "", version : match[1] || "0" };
	}
	if (match != null) {
		return { browser : "", version : "0" };
	}
}
</script>
</head>
<body>
<input type="hidden" id="squarehidden" value="1">
<body>
    <div id="layout_mainbody">
        <div class="page-container tjcg">
            <div class="ssjh-tjcg">
                <div class="left">
						<div class="my-answer-panel panel panelstyle">
                        <p class="title topborder"><i class="icon-title-line"></i><span style="left:0px;">成果列表</span></p>
                        <div class="body">
                            <ul class="my-answer-panel-list">
                            	<s:iterator id="fvoverlist" status="fvoverlistindex" value="initMap.htaskResultlist">
                            		<li>
	                                    <h5><a htaskIssplit="${fvoverlist.htaskIssplit }" keyword="${fvoverlist.htaskKeywords}" createhtaskID="${fvoverlist.htaskID}" createuser="${fvoverlist.htaskUserCreate}" class="htaskTitle"><s:if test="#fvoverlist.htaskIssplit == 1"><span>【任务】<span></s:if><s:else><span>【问题】<span></s:else>${fvoverlist.htaskTitle}</a></h5>
	                                    <p class="answer-info">${fvoverlist.htaskhdCount}个回答&nbsp;|&nbsp;提问者：${fvoverlist.htaskUserAccount}<em><s:date name="#fvoverlist.htaskCreatetime" format="yyyy-MM-dd hh:mm:ss"/></em></p>
	                                </li>
                            	</s:iterator>
                            	<s:if test="initMap.htaskResultlist.isEmpty()">
			                    	<li class="nulldata-htaskResultlist"></li>
			                        <script type="text/javascript">
	                      		  	$(".nulldata-htaskResultlist").html($(".left .topborder span").html()+"下数据暂时为空!!!");
	                      		  	</script>
		                        </s:if>  
                            </ul>
                        </div>
                        <div class="pageb" id="table3page" style="margin-right: 20px;">
							${initMap.paginated.pageContent}
						</div>
                    </div>
                </div>
                <div class="right">
                    <div class="panel">
                        <p class="title topborder">
                                                                                           成果排名
                            
                        </p>
                        <div style=" text-align: center;  height: 30px;line-height: 30px;"><span class="ranking-type"><a href="#" data-type="click" class="on">点击量</a> | <a href="#" data-type="answer">回答量</a></span></div>
                        <div class="body">
                            <ul class="gain-list">
                                <s:iterator id="fv" status="fvindx" value="initMap.htaskclicklist">
									<li>·<a htaskIssplit="${fv.htaskIssplit }" createhtaskID="${fv.htaskID}" createuser="${fv.htaskUserCreate}" class="htaskTitle">${fv.htaskTitle}</a></li>
								</s:iterator>
								<s:if test="initMap.htaskclicklist.isEmpty()">
			                    	<li class="nulldata-htaskclicklist"></li>
			                        <script type="text/javascript">
	                      		  		$(".nulldata-htaskclicklist").html($(".right .title span a").eq(0).html()+"下数据暂时为空!!!");
	                      		  	</script>
		                        </s:if>
                            </ul>
                            <ul class="gain-list" style="display: none">
                                <s:iterator id="fv" status="fvindx" value="initMap.htaskhdnumlist">
									<li>·<a createhtaskID="${fv.htaskID}" createuser="${fv.htaskUserCreate}" class="htaskTitle">${fv.htaskTitle}</a></li>
								</s:iterator>
								<s:if test="initMap.htaskhdnumlist.isEmpty()">
			                    	<li class="nulldata-htaskhdnumlist"></li>
			                        <script type="text/javascript">
	                      		  		$(".nulldata-htaskhdnumlist").html($(".right .title span a").eq(1).html()+"下数据暂时为空!!!");
	                      		  	</script>
		                        </s:if>
                           </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="<%=request.getContextPath()%>/qc/js/jquery-1.7.2.min.js"></script>
    <script src="<%=request.getContextPath()%>/qc/js/tweenmax.min.js"></script>
    <script src="<%=request.getContextPath()%>/qc/js/scripts.js"></script>
    <script src="<%=request.getContextPath()%>/qc/js/jquery.bxslider.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
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

            $(".ranking-type>a").click(function () {
                var tabcontent = $(".gain-list");
                var index = $(".ranking-type>a").index(this);

                $(".ranking-type>a").removeClass("on");
                $(this).addClass("on");
                
                tabcontent.hide();
                tabcontent.eq(index).show();
            });
            
            $('#table3page').pageTB();
        	
            $(".htaskTitle").click(function(){
        		var createuser = $(this).attr("createuser");
        		var s_userID = '${paramMap.s_userID}';
        		var createhtaskID = $(this).attr("createhtaskID");
        		var keywords=$(this).attr("keyword");
        		var htaskIssplit=$(this).attr("htaskIssplit");
        		var thecode = "-1890001";
        		if(htaskIssplit==1){
        			thecode = "-1890002";
        		}
        		
        		//alert(thecode);
        		window.parent.tabClick("munu_name","问题浏览",thecode,"paramMap.htaskID="+createhtaskID+"&paramMap.taskchoosetagindexhref=1&pageSize=8&type=1&paramMap.htaskKeywords="+keywords);
        	});
        	
        });
    </script>
</body>
</html>