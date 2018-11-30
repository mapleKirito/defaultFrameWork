<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
<link href="qc/css/style.css" rel="stylesheet" />
<link href="qc/css/calendar.css" rel="stylesheet" />

<style type="text/css">

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
	$(function() {
		$(".team_applyIn")
				.die()
				.live(
						"click",
						function() {
							var tid = $(this).attr("tid");
							var liObj = $(this);
							if (confirm("确定要申请加入该小组吗")) {
								$
										.ajax({
											url : 'ajaxAction.action?code=0020320020206&paramMap.uID=${s_userID}&paramMap.tID='
													+ tid,
											type : 'post',
											timeout : '60000',
											data : Array(),
											dataType : 'json',
											beforeSend : function(request) {
											},
											complete : function(request,
													textStatus) {
											},
											success : function(jsonData,
													textStatus) {
												if (textStatus == "success") {
													if (jsonData.flag > 0) {
														//alert("删除成功！");
														liObj.remove();
													}
												}
											}
										});
							}

						});

	})
	function noPermission(){
		alert("对不起，您还未加入该小组，请加入后重试！");
	}
</script>
<style type="text/css">
.mem_class {
	position: relative;
}

.team_applyIn {
	position: absolute;
	right: 6px;
	top: 4px;
	color: #ea183f;
	font-size: 12px;
	cursor: pointer;
}
.team_applying{
	position: absolute;
	right: 6px;
	top: 4px;
	color: #ea183f;
	font-size: 12px;
}
</style>
</head>
<body>
	<div id="layout_mainbody">
		<div class="page-container ssjh-index">
			<div class="ssjh-index">
				<div class="ssjh-index-row1">
					<div class="recommend-res left" style="width: 490px;">
						<p class="title" style="width: 490px;">
							<i class="icon-title-line"></i>最新图片 <span class="rs-control">
								<em class="rs-prev"></em> <em class="rs-next"></em> </span>
						</p>
						<div class="rs-slider">
							<ul>
								<li><a href="javascript:void(0)"><img
										src="qc/uploadfiles/1.jpg" /><span style="width: 490px;">1师生风采</span>
								</a></li>
								<li><a href="javascript:void(0)"><img
										src="qc/uploadfiles/2.jpg" /><span style="width: 490px;">2师生互动</span>
								</a></li>
								<li><a href="javascript:void(0)"><img
										src="qc/uploadfiles/3.jpg" /><span style="width: 490px;">3互帮互助</span>
								</a></li>
							</ul>
						</div>
					</div>
					<div class="right tabcontrol" style="width: 220px;">
						<p class="tabtitle">
							<a href="javascript:void(0)" class="tab on">积分榜</a> 
							<a href="javascript:void(0)" class="tab">答题榜</a>
						</p>
						<div class="tabcontents">
							<div class="tabcontent">
								<ul class="rank-list">
									<s:subset source="initMap.wealthList" start="0" count="7">
										<s:iterator id="t" status="index">
											<li><i class="icon-no ${index.index<3?'top3':'' }">${index.index+1
													}</i><a href="#paramMap.userID=${t.userID }">${t.userName }</a>
											</li>
										</s:iterator>
									</s:subset>

								</ul>
							</div>
							<div class="tabcontent" style="display: none">
								<ul class="rank-list">
									<s:subset source="initMap.ansList" start="0" count="7">
										<s:iterator id="t" status="index">
											<li><i class="icon-no ${index.index<3?'top3':'' }">${index.index+1}</i><a
												href="#paramMap.userID=${t.taUserID }">${t.taUserName}</a>
											</li>
										</s:iterator>
									</s:subset>
								</ul>
							</div>
						</div>
					</div>
				</div>
                        <div class="ssjh-index-row3 tabcontrol">
                            <div class="tabtitle-bg"></div>
                            <p class="tabtitle">
                                <a href="javascript:;" class="tab on">活跃小组</a>
                                <a href="javascript:;" class="tab">最新空间</a>
                                <a href="decorateForwardAction.action?code=002031001" class="more" id="more_one">更多</a>
                            </p>
                            
                            <div class="tabcontents">
                                <div class="tabcontent">
                                    <ul class="groups">
										<s:subset source="initMap.teamList" start="0" count="10">
											<s:iterator id="t" status="newsIndex">
												<li class="mem_class">
													<s:if test="#t.stateT==0">
													<div tid="${t.tID }" class="team_applyIn">申请加入</div>
													</s:if>
													<a
													<s:if test="#t.stateT==0&&#t.isPublic==0"> href="javascript:;" onclick="noPermission();" </s:if>
													<s:if test="#t.stateT==1&&#t.isPublic==0"> href="javascript:;" onclick="noPermission();" </s:if>
													<s:else> href="decorateForwardAction.action?code=00203200201&paramMap.tID=${t.tID }"</s:else>
													class="left"> <img src="${t.userImg}"
														onerror="this.src='images/default/default_team.jpg'"
														width="64" height="64" /> </a>
													<div class="right">
														<h5>
															<a
																<s:if test="#t.stateT==0&&#t.isPublic==0">href="javascript:;" onclick="noPermission();"</s:if>
																<s:if test="#t.stateT==1&&#t.isPublic==0">href="javascript:;" onclick="noPermission();"</s:if>
																<s:else>href="decorateForwardAction.action?code=00203200201&paramMap.tID=${t.tID }" </s:else>
																title="${t.tName }">
																<s:if
																	test="#t.tName.length() > 5">
																	<s:property value="#t.tName.substring(0,5)" /> ...
										                     </s:if> <s:else>
																	<s:property value="#t.tName" />
																</s:else> </a>
														</h5>
		
														<p>
															成员数量：<em>${t.peoples}</em>
														</p>
														<p>
															创建人：<span class="red">${t.tUserName }</span>
														</p>
													</div>
												</li>
											</s:iterator>
										</s:subset>
									</ul>
                                </div>
                                <div class="tabcontent" style="display:none">
                                    <ul class="groups">
                                    <s:subset source="initMap.spaceList" start="0" count="10">
											<s:iterator id="t" status="newsIndex">
	                                        <li>
	                                            <a href="decorateForwardAction.action?code=-25200&paramMap.userID=${t.userID }" class="left">
	                                            	<img src="${t.userImg}" onerror="this.src='images/default/default_img.jpg'"  width="64" height="64" />
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
                                    	</s:iterator>
                                    	</s:subset>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
						<div class="ssjh-index-row2 tabcontrol">
                            <div class="tabtitle-bg"></div>
                            <p class="tabtitle">
                            	<a href="javascript:;" class="tab on">教师专栏</a>
                                <a href="javascript:;" class="tab">学生专栏</a>
                                <a href="decorateForwardAction.action?code=002031010&paramMap.uType=1" class="more" id="more_two">更多</a>
                            </p>
                            <div class="tabcontents">
                            	<div class="tabcontent">
                                    <ul class="rank-list">
                                    	<s:subset source="initMap.TarticleList" start="0" count="10">
                                    	<s:iterator id="t" status="index">
                                        	<li><i class="icon-no ${index.index<3?'top3':'' }">${index.index+1 }</i><a title="${t.aTitle}" href="decorateForwardAction.action?code=002031003&paramMap.aID=${t.aID}">${t.aTitle}</a></li>
                                        </s:iterator>
                                        </s:subset>
                                    </ul>
                                </div>
                                <div class="tabcontent" style="display:none">
                                    <ul class="rank-list">
                                   	 	<s:subset source="initMap.SarticleList" start="0" count="10">
                                    	<s:iterator id="t" status="index">
                                        	<li><i class="icon-no ${index.index<3?'top3':'' }">${index.index+1 }</i><a title="${t.aTitle}" href="decorateForwardAction.action?code=002031003&paramMap.aID=${t.aID}">${t.aTitle}</a></li>
                                        </s:iterator>
                                        </s:subset>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <div class="ssjh-index-row1 tabcontrol">
                            <div class="tabtitle-bg"></div>
                            <p class="tabtitle">
                                <a href="javascript:;" class="tab on">探究广场</a>
                                <a href="javascript:;" class="tab">探究成果</a>
                                <a href="decorateForwardAction.action?code=002031011" class="more" id="more_three">更多</a>
                            </p>
                            <div class="tabcontents">
                                <div class="tabcontent">
                                    <ul class="rank-list">
                                    <s:subset source="initMap.tasklist" start="0" count="10">
                                    	<s:iterator id="task" status="index">
                                        	<li><i class="icon-no ${index.index<3?'top3':'' }">${index.index+1 }</i>
                                        		<a href="decorateForwardAction.action?code=${task.htaskIssplit==1?'-1890002':'-1890001' }&paramMap.htaskKeywords=${task.htaskKeywords }&paramMap.taskchoosetagindexhref=1&paramMap.htaskID=${task.htaskID}">${task.htaskTitle}</a>
                                        		</li>
                                    	</s:iterator>
                                    </s:subset>
                                    </ul>
                                </div>
                                <div class="tabcontent" style="display:none">
                                    <ul class="rank-list">
                                    	<s:subset source="initMap.taskAcceptList" start="0" count="10">
                                    	<s:iterator id="t" status="index">
                                        	<li><i class="icon-no ${index.index<3?'top3':'' }">${index.index+1 }</i>
                                        		<a href="decorateForwardAction.action?code=${t.htaskIssplit==1?'-1890002':'-1890001' }&paramMap.htaskKeywords=${t.htaskKeywords }&paramMap.taskchoosetagindexhref=1&paramMap.htaskID=${t.htaskID}">${t.htaskTitle }</a>
                                        	</li>
                                    	</s:iterator>
                                    </s:subset>
                                    </ul>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
				


	<script src="qc/js/jquery-1.7.2.min.js"></script>
	<script src="qc/js/tweenmax.min.js"></script>
	<script src="qc/js/scripts.js"></script>

	<!--师生交互JS-->
	<script src="qc/js/jquery.bxslider.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".rs-slider>ul").bxSlider({
				controls : true,
				nextText : "",
				prevText : "",
				auto : true,
				autoStart : true,
				prevSelector : "em.rs-prev",
				nextSelector : "em.rs-next",
				pager : false
			});

		});

		/* 切换第 '更多'的链接地址 */
		$(".tabcontrol .tabtitle a")
				.click(
						function() {

							var index = $(".tabcontrol .tabtitle a")
									.index(this);
							console.info(index);
							if (index == 2) {
								$("#more_one")
										.attr("href",
												"decorateForwardAction.action?code=002031001");
							} else if (index == 3) {
								$("#more_one")
										.attr("href",
												"decorateForwardAction.action?code=002031002");
							} else if (index == 5) {
								$("#more_two")
										.attr("href",
												"decorateForwardAction.action?code=002031010&paramMap.uType=1");
							} else if (index == 6) {
								$("#more_two")
										.attr("href",
												"decorateForwardAction.action?code=002031010&paramMap.uType=2");
							} else if (index == 8) {
								$("#more_three")
										.attr("href",
												"decorateForwardAction.action?code=002031011");
							} else if (index == 9) {
								$("#more_three")
										.attr("href",
												"decorateForwardAction.action?code=002031012");
							}
						});

		/* 将没有头像的小组设为默认头像 */
		$(document).ready(function() {
			$('.tabcontrol .tabcontents img').each(function() {
				if ($(this).attr('src') == '') {
					$(this).attr('src', 'images/default/default_img.jpg');
				}
			});
		});
	</script>

</body>
</html>
