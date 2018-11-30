<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>数字历史管主页</title>
    <link href="qc/css/style.css" rel="stylesheet" />
    <link href="qc/css/gallery.css" rel="stylesheet" />
    <script src="qc/js/jquery-1.7.2.min.js"></script>
    <style type="text/css">
    .my-info {  }
    </style>
    
    <script type="text/javascript">
    	

    	
    	function toTuKu(){
    		//alert(123);
    		$("#childrenMain" , parent.document).attr("src","decorateForwardAction.action?code=002032008&paramMap.userID=${s_userID}&suijichileren="+new Date());		
		    //alert($("#childrenMain" , parent.document).attr("src")  );
    	}
    	function toWenZhang(){
    		//alert(123);
    		$("#childrenMain" , parent.document).attr("src","decorateForwardAction.action?code=002032005&paramMap.userID=${s_userID}&suijichileren="+new Date());		
		    //alert($("#childrenMain" , parent.document).attr("src")  );
    	}
    	function toTeam(){
    		var flag1=$('#myteam').css('display');
    		var flag2=$('#myattention').css('display');
    		if(flag2=="none"){
        		$("#childrenMain" , parent.document).attr("src","decorateForwardAction.action?code=002032002&paramMap.userID=${s_userID}&suijichileren="+new Date());		

    		}else if(flag1=="none"){
        		$("#childrenMain" , parent.document).attr("src","decorateForwardAction.action?code=002032004&paramMap.userID=${s_userID}&suijichileren="+new Date());		

    		}
    	}
    	function toxiangce(f){
    		//alert(123);
    		$("#childrenMain" , parent.document).attr("src","decorateForwardAction.action?code=002032008007&paramMap.gaParentId="+f+"&paramMap.userID=${paramMap.userID }&suijichileren="+new Date());		
		    //alert($("#childrenMain" , parent.document).attr("src")  );
    	}
    	function noPermission(){
    		alert("对不起，您还未加入该小组，请加入后重试！");
    	}
    </script>
    
    
</head>
<body>
    <div id="layout_main">
        <div id="layout_right" style="left: 0px;">
            <div id="layout_mainbody">
                
                <div class="page-container ssjh">
                    <div class="ssjh-index" style="margin-top: 0px;width: 705px;">

                        <div class="ssjh-index-row3 tabcontrol" style="margin-top: 0px;width: 700px">
                            <div class="tabtitle-bg"></div>
                            <p class="tabtitle">
                                <a href="javascript:;" class="tab on">小组</a>
                                <a href="javascript:;" class="tab">关注</a>
                               <a href="javascript:;" class="more" id="more_one_xiao" style="font-size: 11px;color: #8f8f8f;float: right; margin-right: 20px;line-height: 40px;vertical-align: bottom;" flag="1" onclick="toTeam();">更多</a>
                               <!--  <a href="javascript:;" class="tab">分享资源</a> -->
                            </p>
                            <div class="tabcontents">
                                <div class="tabcontent" id="myteam">
                                    <ul class="groups">
                                  	<s:iterator id="t" value="initMap.teamList" status="s">
                                  	 <s:if test="4 >  #s.index">
                                        <li>
                                  
                                        <s:if test="#t.joinState==0">
												<div style="  position: relative;right: -166px;top: 4px;color: #ea183f;font-size: 12px;cursor: pointer;">待审核</div>
											</s:if>
                                            <a   target="_parent" 
                                            <s:if test="#t.joinState==0&&#t.isPublic==0"> href="javascript:;" onclick="noPermission();" </s:if>
													
													<s:else> href="decorateForwardAction.action?code=00203200201&paramMap.tID=${t.tID }"</s:else>>
													<img src="${t.userImg}" title="${t.tName}" onerror="this.src='images/default/default_team.jpg'" width="64" height="64" alt="images/default/default_team.jpg"/>
                                            </a>
                                            <div class="right">
                                                <h5>
                                                <a href="javascript:void(0)"  title="${t.tName}" >
	                                                <s:if test="#t.tName.length() > 5">
														 <s:property value="#t.tName.substring(0,5)" /> ...
								                     </s:if> <s:else>
															 <s:property value="#t.tName" />
													 </s:else>
                                               </a>
                                               </h5>
                                                <p>成员数量：<em>${t.peoples}</em></p>
                                                <p>创建人：<span class="red">${t.tUserName }</span></p>
                                            </div>
                                        </li>
                                        </s:if>
                                    </s:iterator>
                                    
                                    <s:if test="initMap.teamList.isEmpty()">
										<p class="dataEmpty2">暂无数据<p>
									</s:if>
                                    </ul>
                                </div>
                                <div class="tabcontent" style="display:none" id="myattention">
                                    <ul class="groups">
                                    	<s:iterator id="t" value="initMap.userList" status="s">
                                    	<s:if test="4 > #s.index">
	                                        <li>
	                                            <a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${t.targetID }" class="left">
	                                            	<img src="${t.userImg}" onerror="this.src='images/default/default_img.jpg'" width="64" height="64" alt="images/default/default_team.jpg"/>
	                                            </a>
	                                            <div class="right">
	                                                <%-- <h5><a href="javascript:void(0)">${t.userName }</a></h5> --%>
	                                                
	                                               <s:if test="#t.userName.length() gt 9">
	                         						<h5><a href="javascript:void(0)" title="${t.userName }"><s:property value="#t.userName.substring(0,9)+'...'" /></a></h5>
                          							</s:if>
						                           <s:else>
							                           <h5><a href="javascript:void(0)" title="${t.userName }"><s:property value="#t.userName" /></a></h5>
							                       </s:else>
	                                                
	                                                
	                                                <p>用户身份：<em>${(t.userType==1)?'老师':(t.userType==2?'学生':'管理员')}</em></p>
	                                                <p>qq：<span class="red">${t.qq }</span></p>
	                                            </div>
	                                        </li>
	                                         </s:if>
                                    	</s:iterator>
                                    	 <s:if test="initMap.userList.isEmpty()">
										<p class="dataEmpty2">暂无数据<p>
									</s:if>
                                    </ul>
                                </div>
                                <%-- <div class="tabcontent" style="display:none" >
                                    <ul class="groups">
                                    	<s:iterator id="t" value="initMap.userList" status="s">
                                    	<s:if test="#s.index<4">
	                                        <li>
	                                            <a href="decorateForwardAction.action?code=00203200201&paramMap.userID=${t.userID }" class="left">
	                                            	<img src="${t.userImg}" width="64" height="64" />
	                                            </a>
	                                            <div class="right">
	                                                <h5><a href="javascript:void(0)">${t.userName }</a></h5>
	                                                <p>用户身份：<em>${(t.userType==1)?'老师':(t.userType==2?'学生':'管理员')}</em></p>
	                                                <p>qq：<span class="red">${t.qq }</span></p>
	                                            </div>
	                                        </li>
	                                         </s:if>
                                    	</s:iterator>
                                    </ul>
                                </div> --%>
                            </div>
                        </div> 
                        
                        <div class="my-article panel">
                                <p class="title topborder">我的文章
                                 <a href="javascript:;" class="more" id="more_one" style="font-size: 11px;color: #666666;float: right; margin-right: 20px;line-height: 40px;vertical-align: bottom;" onclick="toWenZhang();">更多</a>
                                </p>
                               
                                <div class="body">
                                    <ul class="my-article-list">
                                    <s:iterator id="t" value="initMap.articleList" status="s">
                                    <s:if test="4 > #s.index">
                                        <li>
                                            <div class="user-info-area">
                                                <img style="width: 64px;height: 64px;" src="${t.userImg }" />
                                                <a target="_parent" href="decorateForwardAction.action?code=-25200&paramMap.userID=${t.aCreater }">${t.aCreaterName }</a>
                                                <p><em>${t.aTime }</em></p>
                                            </div>
                                            <div class="article-info-area">
                                                <p class="title">${t.aTitle }</p>
                                                <p class="content">
                                                   ${t.aContent }...[<a href="decorateForwardAction.action?code=002031003&paramMap.aID=${t.aID }" class="red">查看原文</a>]
                                                </p>
                                            </div>
                                        </li>
                                          </s:if>
                                        </s:iterator>                    
                                    </ul>
                                </div>
                            </div>
                            
                            <div class="my-article panel" style="margin-top: 0px;">
			<p class="title topborder">
				我的相册
				<a href="javascript:;" class="more" id="more_one_t" style="font-size: 11px;color: #666666;float: right; margin-right: 20px;line-height: 40px;vertical-align: bottom;" onclick="toTuKu();">更多</a>
				<span></span>
			</p>
			<div class="body">
				<ul class="groups">
					<s:iterator id="t" value="initMap.imgList" status="s">
					 <s:if test="#t.gaParentId==null||#t.gaParentId==0">
					<s:if test="3 > #s.index">
						<li class="mem_class" style="height: 160px;">
							<div class="imgDiv">
								<span></span> <a target="_parent" title="${t.gaDescription }" 
									href="javascript:void(0)" gaID="${t.gaID }"  onclick="toxiangce('${t.gaID }')">
									<img src="${t.gaSrc}"
									onload="if(this.width >= 128){this.height=(this.height/this.width)*128;this.width = 128;}if(this.height >= 100){this.width=(this.width/this.height)*100;this.height = 100;}" />
								</a>
							</div>
							<p
								style="width: 218px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${(t.gaDescription)==""?"&nbsp":(t.gaDescription)
								}</p>
							<p>
								时间：${t.gaCreateTime }
							</p>
						</li>
						 </s:if>
						 </s:if>
					</s:iterator>
				</ul>
			</div>
			

		</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="qc/js/jquery-1.7.2.min.js"></script>
    <script src="qc/js/tweenmax.min.js"></script>
    <script src="qc/js/jquery.bxslider.min.js"></script>
    <script src="qc/js/scripts.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".rs-slider>ul").bxSlider({
                controls: true,
                nextText: "",
                prevText: "",
                auto: true,
                autoStart:true,
                prevSelector: "em.rs-prev",
                nextSelector: "em.rs-next",
                pager:false
            });
        });
    </script>
</body>
</html>
