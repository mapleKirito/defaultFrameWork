<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><s:text name="systemName"/></title>
<link href="qc/css/style.css" rel="stylesheet">
<link href="qc/css/calendar.css" rel="stylesheet">
<script src="qc/js/jquery-1.7.2.min.js"></script>
<style type="text/css">
.mo{
background: pink;
border:1px dashed #000;
}
.mem_class{
position: relative;
text-align: center;
}
.mem_remove{
position: absolute;
right: 6px;
top: 4px;
color: #ea183f;
font-size: 12px;
cursor:pointer;
}
.mem_share{
position: absolute;
right: 6px;
top: 26px;
color: #ea183f;
font-size: 12px;
cursor:pointer;
}
.imgDiv{
position: relative;
left: 45px;
margin:0 auto;
width: 128px;
height: 100px;
background: #f3f3f3;
border: 1px solid #504538;

/*非IE的主流浏览器识别的垂直居中的方法*/ 
display: table-cell; 
vertical-align:middle; 
/*设置水平居中*/ 
text-align:center; 
/* 针对IE的Hack */ 
*display: block; 
*font-size: 175px;/*约为高度的0.873，200*0.873 约为175*/ 
*font-family:Arial;/*防止非utf-8引起的hack失效问题，如gbk编码*/ 
}
.imgDiv img{
/*设置图片垂直居中*/ 
vertical-align:middle; 
}

.topImgDiv{
position: relative;
margin: 0 auto;
width: 184px;
height: 170px;
background: #F3F3F3;
display: table-cell;
vertical-align: middle;
text-align: center;
}

.attention{
	margin-top: 20px;
}


/* "更多"的样式 */
.more {
	font-size: 12px;
	float: right;
	margin-right: 20px;
	line-height: 40px;
	vertical-align: bottom;
}

.more:hover {
	color: red;
}
</style>

<script type="text/javascript">

	/* 修正小组头像的问题 */
	$(document).ready(function(){
		
		$('.group-creator img').each(function(){               
	        if($(this).attr('src')==''){                   
	            $(this).attr('src','images/default/default_img.jpg');               
	        }           
	    }); 
	});
	
	
	$(document).ready(function(){
		
		$('.group-user-list img').each(function(){               
	        if($(this).attr('src')==''){                   
	            $(this).attr('src','images/default/default_img.jpg');               
	        }           
	    }); 
	});
	

</script>

</head>
<body>
<input type="hidden" id="userID" value="${s_userID }">
<input type="hidden" id="teamID" value="${paramMap.tID }">
<input type="hidden" id="teamCreaterID" value="${initMap.team.createrID }">
<!--师生交互内容开始-->
            <div id="layout_mainbody" style="position: relative; overflow: hidden; height: 681px;">
            <div class="rollbar-path-horizontal" style="z-index: 10; display: none; left: 0px; width: 1408px;"><div class="rollbar-handle" style="width: 30%; opacity: 0.5; left: 0px;"></div></div>
                <div class="rollbar-content" style="position: relative; top: 0px; left: 0px; overflow: hidden;">
                <div class="page-container ssjh">
                    <div class="ssjh-xxxz">
                        <div class="left">
                            <!--任务进度-->
                            <%-- <div class="my-task panel">
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
			                                    		<s:if test="#fvtop.htaskIssplit == 1"><li><a href="javascript:void(0);" class="completed"><i class="icon-right-arrow-big"></i><em>${fvtopindx.index+1}</em>已完成</a></li></s:if>
			                                    		<s:if test="#fvtop.htaskIssplit == 0"><li><a href="javascript:void(0);" class="uncompleted"><i class="icon-right-arrow-big"></i><em>${fvtopindx.index+1}</em>未完成</a></li></s:if>
			                                    	</s:iterator>
			                                    </ul>
			                                </div>
                                        </div>
                                    </div>
                                </div>
                            </div> --%>
                            
                            <div class="panel">
                            	<p class="title topborder">小组公告</p>
                                <div class="body" >
                                    <div class="attention tabcontrol" style="margin-top: 5px;">
                                        <div class="tabcontents" style="width: auto;">
                                            <div class="tabcontent tlfb" id="attention-body" style="text-align: center;">
			                                    <s:if test="initMap.team.attention.isEmpty()">
			                                    	<p>小组内暂无公告……</p>
			                                    </s:if>
			                                    	<s:else>
			                                    		<p style="line-height: 30px;">${initMap.team.attention }</p>
			                                    	</s:else>
			                                </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--最新活动-->
                            <!--我的文章-->
						<div class="my-article panel">
							<p class="title topborder">
								最新动态
								<%-- <span><a href="javascript:void(0)">更多</a></span> --%>
							</p>
							<div class="body">
								<ul class="my-article-list">
								<s:subset source="initMap.articleList" start="0" count="8">
								<s:iterator id="l" status="newsIndex">
									<li>
										<div class="user-info-area">
											<img style="width: 64px;height: 64px;display: block;" src="${l.userImg}" /> <a href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.aCreater }">${l.aCreaterName}</a>
											<p>${l.aTime}</p>
										</div>
										<div class="article-info-area">
											<p class="title">
												${l.aTitle}
											</p>
											<p class="content">
												
												 <s:if test="#l.aContent.length() > 200">
													<s:property value="#l.aContent.substring(0,200)" />
															...
												 </s:if> 
												 <s:else>
													<s:property value="#l.aContent" />
												 </s:else>
    												[<a href="decorateForwardAction.action?code=002031003&paramMap.aID=${l.aID}"class="red">查看原文</a>]
											</p>
										</div>
									</li>
								</s:iterator>
								</s:subset>
								</ul>
							</div>
						</div>
						<!--我的图库-->
						<div class="my-article panel" style="margin-top: 0px;">
							<p class="title topborder">
								相册
								<span>
								 <a href="decorateForwardAction.action?code=00203200208&paramMap.teamID=${paramMap.tID }&paramMap.tID=${paramMap.tID }" class="more" id="more_one">更多</a>
									
								</span>
							</p>
							<div class="body">
								<ul class="groups">
									<s:subset source="initMap.imgList" start="0" count="8">
									<s:iterator id="t" status="index">
									 <s:if test="#t.gaParentId==null||#t.gaParentId==0">
										<li class="mem_class" style="height: 160px;padding-top: 6px;">
											<div class="imgDiv">
												<span></span> <a 
									href="decorateForwardAction.action?code=00203200208007&paramMap.gaParentId=${t.gaID }&paramMap.teamID=${paramMap.tID }&paramMap.picNum=${index.index}">
													<img src="${t.gaSrc}" onerror="this.src='images/default/default_img.jpg'"
													onload="if(this.width >= 128){this.height=(this.height/this.width)*128;this.width = 128;}if(this.height >= 100){this.width=(this.width/this.height)*100;this.height = 100;}"/>
												</a>
											</div>
											<p
												style="width: 218px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${(t.gaDescription)==""?"&nbsp":(t.gaDescription)}</p>
											<p>上传人:<a href="decorateForwardAction.action?code=-25200&paramMap.userID=${t.gaUserID }">${t.user_name }</a></p>
											<p>
												${t.gaCreateTime }
											</p>
										</li>
										</s:if>
									</s:iterator>
									</s:subset>
								</ul>
							</div>
				
						</div>
                        </div>
                        <div class="right">
                            <!--社区相册-->
                            <div class="group-album panel">
                                <p class="title topborder">社区相册<span><!-- <a href="javascript:void(0);">我也发一张</a> --></span></p>
                                <div class="body imgDiv2">
                                <s:subset source="initMap.imgList" start="0" count="1">
									<s:iterator id="t" status="index">
									 <s:if test="#t.gaParentId==null||#t.gaParentId==0">
                                    <a target="_blank"
                                    href="decorateForwardAction.action?code=002032008004&paramMap.teamID=${paramMap.tID }&paramMap.picNum=${index.index}" class="topImgDiv">
                                        <img src="${t.gaSrc}" onerror="this.src='images/default/default_img.jpg'"
                                        onload="if(this.width >= 184){this.height=(this.height/this.width)*184;this.width = 184;}if(this.height >= 170){this.width=(this.width/this.height)*170;this.height = 170;}">
                                        <span>${(t.gaDescription)==""?"&nbsp":(t.gaDescription)}</span>
                                    </a>
                                    </s:if>
                                    </s:iterator></s:subset>
                                </div>
                            </div>
                            <!--小组介绍-->
                            <div class="group-desc panel">
                                <div class="body">
                                    <div class="group-creator">
                                        <img src="${initMap.team.userImg }" onerror="this.src='images/default/default_team.jpg'" width="64" height="64" alt="images/default/default_team.jpg">
                                        <a href="javascript:void(0);" title="${initMap.team.tName  }">
                                        
                                        <s:if test="#initMap.team.tName.length() > 5">
											 <s:property value="#initMap.team.tName.substring(0,5)" /> ...
					                     </s:if> <s:else>
												 <s:property value="#initMap.team.tName" />
										 </s:else>
                                        </a>
                                        <span>创建人：<em class="red"><a href="decorateForwardAction.action?code=-25200&paramMap.userID=${initMap.team.createrID }">${initMap.team.tUserName }</a></em></span>
                                    </div>
                                    <div class="group-description" style="width: 183px;padding: 0px;">
                                        <p class="gd-title" style=" border-top: 3px solid red;"><span style="width:173px ;border-bottom: 1px solid #d6d6d6;padding-left: 10px;">小组简介</span></p>
                                        <p class="gd-content" style="text-indent: 2em;padding: 10px;" >
	                                       ${initMap.team.tDescription }
                                       </p>
                                    </div>
                                </div>
                            </div>

                            <p class="group-operator">
                                <a href="decorateForwardAction.action?code=00203200202&paramMap.tID=${paramMap.tID }&paramMap.createrID=${initMap.team.createrID }" class="op-user" data-old-bg="rgb(230, 71, 71)">成员管理</a>
                               <%--  <a href="decorateForwardAction.action?code=00203200203&paramMap.tID=${paramMap.tID }" class="op-group" data-old-bg="rgb(230, 71, 71)" style="background-color: rgb(230, 71, 71);">小组设置</a> --%>
                               <a href="#" class="op-group" data-old-bg="rgb(230, 71, 71)" style="background-color: rgb(230, 71, 71);" onclick="isCreater()">小组设置</a>
                            </p>

                            <!--社区成员-->
                            <div class="group-user panel">
                                <p class="title topborder">新加入成员<span>
                                <a href="decorateForwardAction.action?code=00203200202&paramMap.tID=${paramMap.tID }">更多</a></span></p>
                                <div class="body">
                                    <ul class="group-user-list">
	                                    <s:iterator id="l" value="initMap.memlist" >
	                                   		<li>
	                                   			<a style="background-image: none;" href="decorateForwardAction.action?code=-25200&paramMap.userID=${l.userID }" title="${l.tUserName}"><img style="width: 82px;height: 82px;display: block;" src="${l.userImg}" onerror="this.src='images/default/default_img.jpg'" ></a>
	                                   			<span>${l.tUserName}</span>
	                                   		</li>
	                                    </s:iterator>  
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
             </div>

                
            </div>
            <!--师生交互内容结束-->

    <script src="qc/js/jquery-1.7.2.min.js"></script>
    <script src="qc/js/tweenmax.min.js"></script>
    <script src="qc/js/jquery.bxslider.min.js"></script>
    <script src="qc/js/scripts.js"></script>

    <!--师生交互JS-->
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
        });
        
        function isCreater(){
        	var userID=$("#userID").val();
        	var createrID=$("#teamCreaterID").val();
        	if(userID==createrID){
        		window.location.href="decorateForwardAction.action?code=00203200203&paramMap.tID="+${paramMap.tID };
        	}else{
        		alert("你不是小组创建者哦！");
        	}
        }
        
    </script>

</body>
</html>