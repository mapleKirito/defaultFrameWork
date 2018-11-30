<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="java.io.*,java.util.* "%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script>
$(document).ready(function(){ 
	if(IEversion()<= 8){
		$("#search_").css({
			"padding-left":"30px",
			"line-height":"50px",
			"text-indent":"0px"
		});
		
			}else if(IEversion()== 9 ){}
			
	
	//根据用户类型修改提示文字
	if('${session.s_userType}' == 1){
		$("#002032 span").html("教师工作室");
		
	}else if('${session.s_userType}' == 2){
		$("#002032 span").html("学生学习室");
	}
	//点击头像菜单自动收回左侧
	$(".xt li").click(function () {
        var leftWidth = $("#layout_left").width();
        if (leftWidth == 0) {
            
        } else {
            $(".search-box").css({ left: 0 });
            $(".page-controller").css({ left: 0 });
			$("#navigation").stop(true,true).animate({ left: 0 });
            $("#navigation").show().animate({ width: '100%' });           
		   $("#layout_left").stop(true, true).animate({ width: 0 }, 500, function () {
               // $(this).hide();
            });
		   $("#layout_left_pms").stop(true, true).animate({ width: 0 }, 500, function () {
              // $(this).hide();
           });
            $("#btn_scale").stop(true, true).animate({ left: 0 }, 500);
            $("#layout_right").stop(true, true).animate({ left: 0 }, 500);
            $("#btn_scale a").html("&gt;");
        }
    });
	
	$(".menuTabTextNavigation").html("系统主页");
	
	//alert(window.navigator.userAgent);
	if('${session.s_userType}' != 3){
		$.ajax({
			url:		'ajaxAction.action?code=-0450',
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				var cateList = new Array();
				if (textStatus == "success"){
					if (jsonData.data){
						for (var i=0; i<jsonData.data.length;i++){
							var userImg = jsonData.data[i].userImg;
							$("#userimg").attr("src",userImg);
						}
					} 
				}
			},	
			error:function(request,textStatus,error){}
		});
	}
	
	//隐藏事件
	$("#div_sub_submenu").hover(function () {
        $(this).attr("isOnMouseOver", true);
        $(this).show();
    }, function () {
        $(this).hide();
        $(this).removeAttr("isOnMouseOver");
    });
	
	//备课中心
	$("#backupCenter").click(function(){
		tabClick('munu','高级查询','-1301','');
	});
	//高级查询
	$("#bigserach_").click(function(){
		tabClick('munu','高级查询','-1301','');
	});
	//系统信息
	$("#sysInfo").click(function(){
		tabClick('munu','高级查询','-1301','');
	});

	//地图定位
	$("#area").click(function(){
		tabClick(4,'地图定位','-2019','');
	});
	
	//系统退出
	$("#logout_").click(function(){
		/* if (confirm("您确认要退出吗?"))
			location = "index.jsp"; */
		art.dialog({ content: '您确认要退出吗', title:'退出系统提示', width:160, height:60, lock: true,  
		    background: '#666666', opacity: 0.15, icon: 'question', ok: function () { location = "exit.jsp"; }, cancelVal: '取消', cancel: true });
	});	
	
	//返回首页
	$("#logo").click(function(){
		//location.reload();
		location.href="forwardAction.action?code=-1700&id=0&suiji="+new Date().getTime();
	});
	
	
	//回退
	$("#houtui").click(function(){
		history.go(-1);
	});
	
	//前进
	$("#qianjin").click(function(){
		history.go(+1);
	});
		
	//搜索 ----自动搜索数据---------开始
	
	$("#search_btn").click(function(){
		var keyword = $("#search_").val().replace(/(^\s*)|(\s*$)/g,'') ;
		var title = "查询资源" ;
		if(keyword==''){
			art.dialog.alert('查询内容不能为空!!!');
		   return false;
		}
		forwardUrl = "decorateForwardAction.action";
		tabClick("-1101", title, '-1101','paramMap.resType=' + "-1101" + '&paramMap.keyword=' + keyword +"&pageSize=8");
	});
	
		var $searchInput = $('#search_'); 
		//关闭浏览器提供给输入框的自动完成
		$searchInput.attr('autocomplete','off');
		//创建自动完成的下拉列表，用于显示服务器返回的数据,插入在搜索按钮的后面，等显示的时候再调整位置 
		var $autocomplete = $('<div class="autocomplete"></div>').hide().insertAfter('#search_btn'); 
		//清空下拉列表的内容并且隐藏下拉列表区 
		var clear = function(){ 
		$autocomplete.empty().hide(); 
		}; 
		//注册事件，当输入框失去焦点的时候清空下拉列表并隐藏 
		$searchInput.blur(function(){ 
		  setTimeout(clear,500); 
		});
		//下拉列表中高亮的项目的索引，当显示下拉列表项的时候，移动鼠标或者键盘的上下键就会移动高亮的项目，想百度搜索那样 
		var selectedItem = null; 
		//timeout的ID 
		var timeoutid = null; 
		//设置下拉项的高亮背景 
		var setSelectedItem = function(item){ 
		//更新索引变量 
		selectedItem = item ; 
		//按上下键是循环显示的，小于0就置成最大的值，大于最大值就置成0 
		if(selectedItem < 0){ 
		selectedItem = $autocomplete.find('li').length - 1; 
		} 
		else if(selectedItem > $autocomplete.find('li').length-1 ) { 
		selectedItem = 0; 
		} 
		//首先移除其他列表项的高亮背景，然后再高亮当前索引的背景 
		$autocomplete.find('li').removeClass('highlight') 
		.eq(selectedItem).addClass('highlight'); 
		}; 
		var ajax_request=function(){
			var name=encodeURI($searchInput.val());
			$.ajax({
				url:		'ajaxAction.action?code=-3000&paramMap.erName='+name,
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					if (textStatus == "success"){
						for (var i=0; i<jsonData.data.length;i++){
							$('<li id="auto_list"></li>').text(jsonData.data[i]).appendTo($autocomplete).addClass("clickable")
							.hover(function(){ 
								//下拉列表每一项的事件，鼠标移进去的操作 
								$(this).siblings().removeClass('highlight'); 
								$(this).addClass('highlight'); 
								selectedItem = i; 
								},function(){ 
								//下拉列表每一项的事件，鼠标离开的操作 
								$(this).removeClass('highlight'); 
								//当鼠标离开时索引置-1，当作标记 
								selectedItem = -1; 
								}) 
								.click(function(){ 
								//鼠标单击下拉列表的这一项的话，就将这一项的值添加到输入框中 
								//alert($(this).html());
								$searchInput.val($(this).html()); 
								//清空并隐藏下拉列表 
								$autocomplete.empty().hide(); 
							});
						}
						var ypos = $searchInput.position().top; 
						var hpos = $searchInput.height(); 
						var xpos = $searchInput.position().left; 
						$autocomplete.css('width','198px'); 
						$autocomplete.css({'position':'absolute','left':xpos + "px",'top':ypos+hpos +"px"}); 
						setSelectedItem(0); 
						//显示下拉列表 
						$autocomplete.show(); 
					}
				}
			});
		};
		//对输入框进行事件注册 
		$searchInput.keyup(function(event) { 
			//字母数字，退格，空格 
			if(event.keyCode > 40 || event.keyCode == 8 || event.keyCode ==32) { 
				if($searchInput.val() != ''){
					//首先删除下拉列表中的信息 
					$autocomplete.empty().hide(); 
					clearTimeout(timeoutid); 
					timeoutid = setTimeout(ajax_request,100); 
				}
			} 
			else if(event.keyCode == 38){ 
				//上 
				//selectedItem = -1 代表鼠标离开 
				if(selectedItem == -1){ 
					setSelectedItem($autocomplete.find('li').length-1); 
				} 
				else { 
				//索引减1 
					setSelectedItem(selectedItem - 1); 
				} 
				event.preventDefault(); 
			} 
			else if(event.keyCode == 40) { 
			//下 
			//selectedItem = -1 代表鼠标离开 
				if(selectedItem == -1){ 
					setSelectedItem(0); 
				} 
				else { 
				//索引加1 
					setSelectedItem(selectedItem + 1); 
				} 
				event.preventDefault(); 
			} 
		}).keypress(function(event){ 
			//enter键 
			if(event.keyCode == 13) { 
			//列表为空或者鼠标离开导致当前没有索引值 
				if($autocomplete.find('li').length == 0 || selectedItem == -1) { 
					return; 
				} 
				$searchInput.val($autocomplete.find('li').eq(selectedItem).text()); 
				$autocomplete.empty().hide(); 
				event.preventDefault(); 
			} 
		}).keydown(function(event){ 
			//esc键 
			if(event.keyCode == 27 ) { 
				$autocomplete.empty().hide(); 
				event.preventDefault(); 
			} 
		}); 
	
	//搜索 ----自动搜索数据---------结束
	
	
	//悬浮菜单
	
});
function menuTabTextNavigation(t){
	var isOpen=$("#isOpen",window.parent.document).attr("value");
	//alert(isOpen);
	if(isOpen==0){
	if(t!=null && t!=""){
		$(".menuTabTextNavigation").html(t);	
	}else{
		$(".menuTabTextNavigation").html("系统主页");
	}
	}else{}
	$("#isOpen",window.parent.document).attr("value",0);
}
function manager_pms(flag){
	if(flag==1){
		$("#layout_left").show();
		$("#layout_left_pms").hide();
	}else if(flag==0){
		$("#layout_left").hide();
		$("#layout_left_pms").show();
	}else if(flag==2){
        var localIp=GetLocalIPAddr();
        //alert(localIp);
	//跳转，统计页面
		tabClickHref(localIp+"/UniteCount-school/ShowDitalServlet");
	}
	
}
 function GetLocalIPAddr(){ 
	 var url=window.location.href;
 	 var startoint = url.indexOf("//");
 	 var endPoint = url.indexOf("8086");
 	 return url.substring(startoint, endPoint+4);

 }
 function IEversion(){
		var browser=navigator.appName; 
		var b_version=navigator.appVersion;
		var version=b_version.split(";");
		if (version.length<2){
	        return "";
		}else{
		var trim_Version=version[1].replace(/[ ]/g,""); 
		if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
		{ 
			return "6.0";
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") 
		{ 
			return "7.0";
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
		{ 
			return "8.0";
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0") 
		{ 
			return "9.0";
		}
		}
	}
</script>
<div id="layout_top">
	<div class="logo">
		<a id="logo" href="javascript:void(0)"> <img src="images/logo_wulogo.png" />
		</a>
		 <div id="btn_scale"><a href="javascript:;" id="closeLeft">&lt;</a></div>
        <div id="div_sub_submenu">
            <i class="nano"></i>
            <ul></ul>
        </div>	</div>
       
	<div class="search-box">
		<i class="icon-search"></i> 
		<input type="text"   name="searchText" id="search_" placeholder="输入查询内容" />
		<input type="button" class="gosearch" id="search_btn" />
	</div>
	<div class="page-controller">
		<a id="houtui" href="javascript:void(0)" class="fade-button prev" data-type="prev"
			data-fade-to="#504538"><i class="icon-page-prev"></i>后退</a> 
		<a id="qianjin" href="javascript:void(0)" class="fade-button next" data-type="next"
			data-fade-to="#504538"><i class="icon-page-next"></i>前进</a>
	</div>
	<div class="right-top-menu">
		
		<!-- <a href="javascript:void(0)" class="fade-button" data-fade-to="#504538"><i
			class="icon-skin"></i>皮肤
		</a> -->
		<div class="login-info">
			
			<s:if test="session.s_userType == 3"> <a href="javascript:void(0)"><img src="images/manager.png" width="30" height="30" /> </s:if>
			<s:if test="session.s_userType == 2">
			<a href="javascript:void(0)" id="userInfoChange" code="002032" url="${pmsIndex.tea_info_mgr.code}">
			<img src="images/teacher.png" onerror="this.src='images/default/default_img.jpg'" width="30" height="30" id="userimg"/> 
			</s:if>
			<s:if test="session.s_userType == 1">
			<a href="javascript:void(0)" id="userInfoChange" code="002032" url="${pmsIndex.tea_info_mgr.code}">
			<img src="images/student.png" onerror="this.src='images/default/default_img.jpg'" width="30" height="30" id="userimg"/> 
			</s:if>
			${s_userLoginName}
			<i class="icon-down-arrow"></i></a>
			<ul class="login-info-more" id="menu">
				<s:iterator value="subPermission" id="pms" status="ind">			
					<!-- 管理员 -->
					<s:if test="session.s_userType == 3 ">
						<s:if test="#pms.code != '004' && #pms.code != '005'">
							<li class="mli">
								<div class="label_${session.s_userType}" id="${pms.code}" ></div>
								<ul >
									<s:iterator value="allPermission" id="allpms" status="allind">	
										<s:if test="#pms.code == #allpms.parentCode and #allpms.code != '003016' and #allpms.code != '003000'">	
                                            
											<li><a href="javascript:void(0);" onclick="manager_pms(0)" id="${allpms.code}">&nbsp;<span>${allpms.name}</span></a></li>
											
										</s:if>
		 					</s:iterator>				
								</ul>
							</li>
						</s:if>
						<li><a href="javascript:void(0)" data-fade-to="#ca3d3d" onclick="manager_pms(2)">信息统计</a></li> 
						<li><a href="javascript:void(0)" data-fade-to="#ca3d3d" onclick="manager_pms(1)">返回浏览</a></li>
						<li><a href="javascript:void(0)" data-fade-to="#ca3d3d">下载备课中心客户端</a></li>
						
					</s:if>	
					<!-- 老师 或者 学生 -->
					<s:if test="session.s_userType == 1 || session.s_userType == 2 ">
						<s:if test="#pms.code != '004' && #pms.code != '005'">
							<li class="mli">
								<div class="label_${session.s_userType}" id="${pms.code}" ></div>
								<ul class="xt">
									<s:iterator value="allPermission" id="allpms" status="allind">	
										<s:if test="#pms.code == #allpms.parentCode and #allpms.code != '003016' and #allpms.code != '003000'">
											<li><a href="javascript:void(0);" id="${allpms.code}">&nbsp;<span>${allpms.name}</span></a></li>
										</s:if> 
				 					</s:iterator>				
								</ul>
							</li>
							<s:if test=" session.s_userType == 1 ">
								<li><a href="javascript:void(0)" data-fade-to="#ca3d3d">下载备课中心客户端</a></li>
							</s:if>
						</s:if>
					</s:if>
 				</s:iterator>
				<!-- <li><a href="javascript:void(0)" data-fade-to="#ca3d3d">编辑资料</a></li>
				 -->
				<li><a href="javascript:void(0)" data-fade-to="#ca3d3d" id="logout_">退出系统</a></li>
			</ul>
		</div>
		
		 
		<!-- <a href="javascript:void(0)" id="area" class="fade-button" data-fade-to="#504538"><i class="icon-position-white"></i>地图定位
		</a> --> 
		<div class="sys_info" style="position:relative;   display: inline; float: right;overflow: visible; z-index: 14;">
			<a href="javascript:void(0)" class="fade-button" data-fade-to="#504538" title="系统信息" style="padding-right: 38px;  height: 48px; display: block;">
				<i style="background: url('images/top/help_top.png');width: 35px;height: 35px;left: 0px; top: 7px;" class="icon-advsearch"></i>
			</a>
			<ul id="sys_info_more"  style="position:absolute;display:none; top:48px; right:0px; width:170px; height:auto; background:#504538;" >
					<li style="display:block;"><a style="height:34px; background:#504538; line-height:30px; text-align:center; display:block; clear:both;" href="javascript:void(0)" data-fade-to="#ca3d3d" onclick="alert('当前版本:${paramMap.version}');" >系统信息</a></li> 
					<li style="display:block;"><a style="height:34px; background:#504538; line-height:30px; text-align:center; display:block; clear:both;" href="javascript:void(0)" data-fade-to="#ca3d3d" onclick="alert('暂无信息');">系统升级</a></li>
			</ul>
		</div>
		<s:if test="session.s_userType == 3 || session.s_userType == 1 ">
		<!-- <a href="javascript:void(0)" id="backupCenter" class="fade-button" data-fade-to="#504538" title="备课中心" style="padding-right: 62px;">
			<i style="background: url('images/beike.png');" class="icon-advsearch"></i>
		</a> -->
		</s:if>
		<div style="float: right;display: inline;position: relative;right: 0px;">
			<a href="javascript:void(0)" id="bigserach_" class="fade-button" data-fade-to="#504538" title="高级查询" style="padding-right: 36px;display: block;height: 48px;background-color: rgba(0, 0, 0, 0);">
				<i class="icon-advsearch"></i>
			</a>
		</div>
	</div>
</div>
<div class="navigation" id="navigation">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-home"></i>位置：<span class="menuTabTextNavigation"></span>
</div>
<script src="js/jquery-main-tag.js"></script>