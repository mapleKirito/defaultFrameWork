
//计算tab标签存放的最大个数
var maxCount = parseInt((screen.width - 170)/117) - 1;
//tab 极限个数
var limitSize = 15;
//显示标签页面元素容器
var $showTabContainer;
//更多按钮页面元素对象
var $moreTabBtn;
//隐藏标签存放层对象
var $moreTabList;
//隐藏标签页面元素容器
var $hideTabContainer;
//url
var forwardUrl = "decorateForwardAction.action";

//创建或显示iframe主操作界面
createIframe2 = function(id,txt,code,param){
	//隐藏显示的iframe
	$("#content iframe").hide();
	//获取iframe的id判断是否存在，若存在直接显示此iframe
	var ifid = $("#content_"+id).attr("id");
	if (!ifid){
		//如果此id不存在，则创建一个新的iframe
		$("#content").append(
			$("<iframe></iframe>").attr("id","content_"+id).attr("name","content_"+id)
			.attr("width","100%").attr("height",iframeHeight).attr("frameborder","0")
			.attr("scrolling","auto").attr("src",forwardUrl+ "?code="+code +"&"+param)
		);
	}
	else{
		//显示iframe
		$("#content_"+id).show();
	}	
};
//显示标签和隐藏标签调换
$.changeTab = function(code,txt){

	//清除其它显示标签样式
	$("li",$showTabContainer).each(function(){
		$(this).removeClass();
	});
	//追加新的li到显示标签的最后面，并处于选中状态
	$showTabContainer.append(
		$("<li></li>").append(
			$("<em></em>").attr("id",code).addClass("mainFont").append(txt)
		).append(
			$("<span></span>").addClass("mainClose")
		).addClass("curr")
	);
	//显示tab文本内容
	var showTabContainerText = $("li",$showTabContainer).first().find(".mainFont").text();
	//显示tab的id
	var showTabContainerID = $("li",$showTabContainer).first().find(".mainFont").attr("id");
	//删除显示标签的第一个
	$("li",$showTabContainer).first().remove();
	//删除隐藏标签中做交换的标签
	$("#"+code,$hideTabContainer).parent().remove();
	//把显示标签的第一个放到下拉层里面（删除在创建信息的元素）
	$hideTabContainer.append(
		$("<li></li>").append(
			$("<a></a>").attr("id",showTabContainerID).append("href","#").text(showTabContainerText+"")
		).append(
			$("<div></div>").addClass("tabClose").attr("id","tabClose")
		)
	);	
};
//关闭显示标签处理函数
$.closeShowTab = function($cshowTab){
	$("#top_menu tr td").removeClass("top_menu_select");
	
	//删除此tab标签元素
	$cshowTab.parent().remove();
	//删除图片，前面一个元素的id
	var rmid = $cshowTab.prev().attr("id");	
	//删除iframe
	$("#content_"+rmid).remove();	
	//隐藏标签的数量
    var hideTabSize = $("li",$hideTabContainer).size();

	//如果隐藏标签大于0，将隐藏标签第一个从隐藏容器内删除，并追加到显示标签的最后显示
	if (hideTabSize > 0){
		//隐藏元素第一个
		var $hideFirst = $("li",$hideTabContainer).first();
		//隐藏标签对应的id
		var hideCode = $("a",$hideFirst).attr("id");
		//隐藏标签对应的文本内容
		var hideTxt = $("a",$hideFirst).text();
		
		//清除其它显示标签样式
		$("li",$showTabContainer).each(function(){
			$(this).removeClass();
		});
		//追加新的li到显示标签的最后面，并处于选中状态
		$showTabContainer.append(
			$("<li></li>").append(
				$("<em></em>").attr("id",hideCode).addClass("mainFont").append(hideTxt)
			).append(
				$("<span></span>").addClass("mainClose")
			).addClass("curr")
		);		
		//显示iframe
		$("#content_"+hideCode).show();
		//删除本隐藏标签
		$hideFirst.remove();
		if (hideTabSize == 1){
			//关闭隐藏按钮
			$moreTabBtn.hide();		
			//隐藏下拉层
			$moreTabList.hide();
		}		
	}	
	else{	
		//已经被选中的标签数量
		var showSize = $(".curr",$showTabContainer).size();
		//只有为0时代表没有其它标签被选中，并设置最后一个为选中状态
		if (showSize == 0){
			//每删除一个，默认最后一个处于被选中状态
			$("li",$showTabContainer).last().addClass("curr");			
		}
		//获取最后一个显示标签id
		var defaultCode = $("li",$showTabContainer).last().find(".mainFont").attr("id");
		//设置最后一个标签对应的iframe显示
		$("#content_"+defaultCode).show();	
		//如入显示标签个数为0，显示欢迎页面
		var ssize = $("li",$showTabContainer).size();
		if (ssize == 0){
			$("#mainFrameWelcome").show();
		}
	}
	//调用显示标签事件处理函数
	$.showTabEvent();	
};
//显示标签事件处理函数
$.showTabEvent = function (){

	//显示标签关闭事件和鼠标移入，移出事件
	$(".mainClose",$showTabContainer).unbind("click").click(function(){
		//关闭显示标签处理函数
		$.closeShowTab($(this));
	}).unbind("mouseover").mouseover(function(){
		//鼠标悬停事件
		$(this).removeClass().addClass("mainShut");
	}).unbind("mouseout").mouseout(function(){
		//鼠标离开事件
		$(this).removeClass().addClass("mainClose");
	});	
	//显示标签显示主操作区域内容事件
	$(".mainFont",$showTabContainer).unbind("click").bind("click",function(){
		var id = $(this).attr("id");
		//清楚其它标签选中样式
		$("li",$showTabContainer).each(function(){
			$(this).removeClass();
		});
		//设置当前 标签被选中
		$(this).parent().addClass("curr");
		//动态话显示主操作区域ifram
		//隐藏显示的iframe
		$("#content iframe").hide();
		//显示iframe
		$("#content_"+id).show();
	});		
};
//隐藏标签处理事件
$.hideTabEvent = function(){
	//隐藏标签鼠标关闭，悬停，移出事件
	$("div",$hideTabContainer).unbind("mouseover").mouseover(function(){
		$(this).addClass("tabShut");
	}).unbind("mouseout").mouseout(function(){
		$(this).removeClass("tabShut");
	}).unbind("click").click(function(){
		$(this).parent().remove();
		var rmid = $(this).prev().attr("id");
		//删除iframe
		$("#content_"+rmid).remove();
		var hsize = $("li",$hideTabContainer).size();
		if (hsize == 0){
			//关闭隐藏按钮
			$moreTabBtn.hide();	
			//隐藏下拉层
			$moreTabList.hide();
		}
	});	
	//隐藏标签鼠标点击事件，悬停，移出事件
	$("li",$hideTabContainer).unbind("mouseover").mouseover(function(){
		$(this).addClass("on");
	}).unbind("mouseout").mouseout(function(){
		$(this).removeClass("on");
	});
	$("a",$hideTabContainer).unbind("click").click(function(){
		//清除其它显示标签样式
		$("li",$showTabContainer).each(function(){
			$(this).removeClass();
		});
		//隐藏显示出来的标签
		$moreTabList.hide();
		//设置更多按钮为正常样式
		$moreTabBtn.removeClass("onMore").removeClass("downMore");
		//隐藏Tab文本内容
		var hideTabContainerText = $(this).text();
		//隐藏Tab的id
		var hideTabContainerTextID = $(this).attr("id");
		//删除所选的li
		$(this).parent().remove();
		//追加新的li到显示标签的最后面，并处于选中状态
		$showTabContainer.append(
			$("<li></li>").append(
				$("<em></em>").attr("id",hideTabContainerTextID).addClass("mainFont").append(hideTabContainerText)
			).append(
				$("<span></span>").addClass("mainClose")
			).addClass("curr")
		);
		//显示tab文本内容
		var showTabContainerText = $("li",$showTabContainer).first().find(".mainFont").text();
		//显示tab的id
		var showTabContainerID = $("li",$showTabContainer).first().find(".mainFont").attr("id");
		//删除显示标签的第一个
		$("li",$showTabContainer).first().remove();
		//把显示标签的第一个放到下拉层里面（删除在创建信息的元素）
		$hideTabContainer.append(
			$("<li></li>").append(
				$("<a></a>").attr("id",showTabContainerID).append("href","#").text(showTabContainerText)
			).append(
				$("<div></div>").addClass("tabClose").attr("id","tabClose")
			)
		);
		//调用显示标签事件处理函数
		$.showTabEvent();
		//调用隐藏标签事件处理函数
		$.hideTabEvent();		
		//隐藏显示的iframe
		$("#content iframe").hide();
		//显示iframe
		$("#content_"+hideTabContainerTextID).show();
	});	
};



$("#menu .xt li a").click(function(){
	
	var code = $(this).attr("id");
	var forwardSrc = forwardUrl+ "?code="+code;
	var functionve=document.getElementById('mainFrameWelcome');
	//背景图片
	if(forwardSrc.match(/code=002/i)=="code=002" ){
		$("#mainFrameWelcome").attr("src",forwardSrc);
		functionve.style.backgroundImage="url(images/body1.png)";
		
	}else{
		$("#mainFrameWelcome").attr("src",forwardSrc);
		functionve.style.backgroundImage="";

	}
});	 
$("#userInfoChange").click(function(){

	var code = $(this).attr("code");
	var url = $(this).attr("url");
	var ifid = $("#content_"+code).attr("id");
	
	//收回左侧目录
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
  //背景图片
    var forwardSrc = forwardUrl+ "?code="+code+"&paramMap.url="+url;
	var functionve=document.getElementById('mainFrameWelcome');
	if(forwardSrc.match(/code=002/i)=="code=002" ){
		$("#mainFrameWelcome").attr("src",forwardSrc);
		functionve.style.backgroundImage="url(images/body1.png)";			
	}else{
		$("#mainFrameWelcome").attr("src",forwardSrc);
		functionve.style.backgroundImage="";			
	}
});	 
function tabClickHref(href){
	
	var functionve=document.getElementById('mainFrameWelcome');
	if(href.match(/code=002/i)=="code=002" ){
		$("#mainFrameWelcome").attr("src",href);
		functionve.style.backgroundImage="url(images/body1.png)";
		
	}else{
		$("#mainFrameWelcome").attr("src",href);
		functionve.style.backgroundImage="";
	}
	
	//页面单一跳转
	
}
function tabClick(id,txt,code,param){
	  //背景图片

	var src = forwardUrl+ "?code="+code +"&"+param;
	var functionve=document.getElementById('mainFrameWelcome');
	if(src.match(/code=002/i)=="code=002" ){
		$("#mainFrameWelcome").attr("src",src);
		functionve.style.backgroundImage="url(images/body1.png)";
		
	}else{
		$("#mainFrameWelcome").attr("src",src);
		functionve.style.backgroundImage="";

	}
	
	/*if(txt.length>=5){
		txt = txt.substring(0,5) + "...";
	}
	var ifid = $("#content_"+id).attr("id");
	//显示的tab标签计数
	var showTabCount =1;
	//隐藏的tab标签计数
	var hideTabCount = $("li",$hideTabContainer).size();
	//所有标签的数量
	var tempCount = showTabCount + hideTabCount;
	//如果此id已经存在值直接显示，不在画新的页面
	if (ifid){
		//获取隐藏标签id
		var compareid = $("#" + id,$hideTabContainer).attr("id");
		//如果此id存在说面本次点击的为隐藏区域内的标签
		if (compareid){
			//显示标签和隐藏标签调换
			$.changeTab(id,txt); 	
			//获取iframe src
			//var src = $("#content_"+id).attr("src")+ "&"+new Date();
			//从新请求src 加载页面
			$("#content_"+id).attr("src",forwardUrl+ "?code="+code +"&"+param + "&"+new Date());				
			//显示iframe
			$("#content_"+id).show();		
			//调用显示标签事件处理函数
			$.showTabEvent();		
			//调用隐藏标签事件处理函数
			$.hideTabEvent();					
		}
		else{
			//清除其它标签选中样式
			$("li",$showTabContainer).each(function(){
				$(this).removeClass();
			});
			//设置当前 标签被选中
			$("#"+id,$showTabContainer).parent().addClass("curr");
			//设置文本内容
 			$("#"+id,$showTabContainer).text(txt);
			//动态话显示主操作区域ifram
			//隐藏显示的iframe
			$("#content iframe").hide(); 
			//获取iframe src
			//var src = $("#content_"+id).attr("src")+ "&"+new Date();
			//从新请求src 加载页面
			$("#content_"+id).attr("src",forwardUrl+ "?code="+code +"&"+param + "&"+new Date());
			//显示iframe
			$("#content_"+id).show();
		}
	}
	else{
		if (showTabCount < maxCount){
		
			//清除其它显示标签样式
			$("li",$showTabContainer).each(function(){
				$(this).removeClass();
			});
			//最新加的显示标签在最后
			$showTabContainer.append($("<li style='cursor: pointer;'></li>").append(
					$("<em></em>").attr("id",id).addClass("mainFont").append(txt)
				).append(
					$("<span></span>").addClass("mainClose")
				).addClass("curr")
			);
			//创建或显示iframe主操作界面
			alert(id+""+txt+""+code+""+param);
			createIframe2(id,txt,code,param);
			//调用显示标签事件处理函数
			$.showTabEvent();
		}
		else if(maxCount <= showTabCount && tempCount < limitSize){
			//显示标签和隐藏标签调换
			$.changeTab(id,txt);
			//调用显示标签事件处理函数
			$.showTabEvent();
			//调用隐藏标签事件处理函数
			$.hideTabEvent();		
			//创建或显示iframe主操作界面
			$.createIframe2(id,txt,code,param);
			//如果标签的计数个数达到显示最大值，则显示 ">>" 按钮
			if(showTabCount == maxCount){
				$moreTabBtn.show();
			}
		}
		else{
			alert("已经到达标签数量极限，请关闭其它标签，在打开新的。");
		}
	}	*/	
}
//重定向到的新的窗口
function tabClick_redirect(id,txt,code,param){
	
	//替换其中的&
	var paramArr=param.split(""); 
	 for(var i=0;i<=paramArr.length;i++){
		 if("&"==paramArr[i]){
			 paramArr[i]="%26";
		 }
	 }
	var param_format=paramArr.join("");
	var url=forwardUrl+"?code="+code+"%26"+param_format;//param中的&必须换为%26
	//alert(window.location.href+"&url="+url);
	//alert(1);
	//window.open(window.location.href+"&url="+url);
	
	window.open("forwardAction.action?code=-1700&url="+url);
	
}