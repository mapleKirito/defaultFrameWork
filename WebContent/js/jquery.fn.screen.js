
$.screenTB = function(data,opt){
	var SCREEN = this;
	//是否锁屏标识
	
	var isLock = false;
	var setting = {
		//window document 类型，区分子窗体，父窗体
		windowDocument:'',			
		//confirm 类型对话框返回值 1：确定按钮，0:取消按钮
		returnValue:'',
		width:'300',
		height:'300',
		content:'',
		contentAlign:'center',
		contentValign:'top',
		title:'',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		//alert 信息提示框  ，confirm 是否兑换框 ，iframe 子窗体引用
		dialogType:'alert',
		//如果dialogType为iframe，iframeSrc不能为空
		iframeSrc:'',
		//原属绑定事件
		elmfunction:'click'
	};
	var option ={
		clickEvent:false
	};
	var icon = {
		ALERT:'images/window/icon-info.gif',
		DIAHEAD:'images/window/bg.gif',
		POST:'images/window/post.gif',
		CLOSE:'images/window/close.png',
		CLOSED:'images/window/closed.png'	
	};    
	//将配置的数据替换，增加到data对象中
	$.extend(setting,data);
	//将配置的数据替换，增加到option对象中
	$.extend(option,opt);
	
	//锁屏时设置select不可用
	SCREEN.disableSelect = function()
	{
		$("select").each(function(){
			$(this).css("disabled","true");
		});
	};
	
	//解屏时设置select可用
	SCREEN.enableSelect = function()
	{
		$("select").each(function(){
			$(this).css("disabled","false");
		});		
	};	
	
	//锁屏函数
	SCREEN.lockScreen = function()
	{
		
	    var swidth = $(setting.windowDocument).width()-21;
	    var sheight = $(setting.windowDocument).height()-6;
		$(setting.windowDocument).find("#screen__").css("width","100%").css("height",sheight).css("display","block").css("filter","alpha(opacity=50)");		
	};
	
	//解屏函数
	SCREEN.clearScreen = function()
	{
		$(setting.windowDocument).find("#screen__").css("display","none");
		$(setting.windowDocument).find("#message__").css("display","none");
		SCREEN.enableSelect();
	};
	
	//对话框函数
	SCREEN.dialog = function()
	{
	    var swidth = $(setting.windowDocument).width();
	    var sheight = $(setting.windowDocument).height();
	    var otherfl= SCREEN.data.otherflag;
	    
	    var top = sheight/ 2 - setting.height/2;
	    var left = swidth/ 2 - setting.width/2;
	    
	  
	    
	    if(otherfl == 'videowmv'){
	    	 left = '1020px';
	    }
	    var conetent =  "";
	       conetent +="<table width='100%' height='100%' border='0' style='background:#606373;' cellpadding='1' cellspacing='1'>"
					+ "<tr>"
					+ "<td height='22' style='background:#606373;'>"
						+ "<table width='100%' height='22' border='0' cellpadding='0' cellspacing='0'>"
						+ "<tr>"
						+ "<td height='22'>" 
					    	+ "<table width='100%' height='22' border='0' cellspacing='0' cellpadding='0' class='TheTbig'>"
					    	+ "<tr>"
					    	/*+ "<td width='20' style='line-height:0.4px' >&nbsp;<img src='images/default/tab/tb.gif' border='0' width='16' height='16'></td>"*/
					    	+ "<td class='WtableTBig'><b style='color:#ffffff;'>"+setting.title+"</b></td>"
					    	+ "<td class='WtableTBig' width='30'align='center'><img id='_dialogImg' src='images/window/close.png' border='0' width='16' height='16'/></td>"
					    	+ "</tr>"
					    	+ "</table>"					
						+ "</td>"
						+ "</tr>"
						+ "</table>"
					+ "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td style='background:#e8e8e8;'>"
						+ "<table width='100%' height='100%' border='0' cellpadding='0' cellspacing='0'>"
						+ "<tr>"
						+ "<td align='center'>";
					    if (setting.dialogType == "alert"){
					    	conetent += "&nbsp;<img src='images/window/icon-info.gif' valign='absmiddle' width='32' height='32' border='0'>";
					    	conetent += "&nbsp;" + setting.content
					    }
					    else if (setting.dialogType == "confirm"){
					    	conetent += "&nbsp;<img src='images/window/icon-info.gif' valign='absmiddle' width='32' height='32' border='0'>";
					    	conetent += "&nbsp;" + setting.content					    	
					    }
					    else if (setting.dialogType == "iframe"){
					    	if (!setting.iframeSrc){
					    		alert("setting.iframeSrc is not null")
					    	}
					    	conetent += "<iframe width='100%' height='100%' src='"+setting.iframeSrc+"' scrolling='auto' frameborder='0'></iframe>";
					    }
					    conetent+="</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td height='30' valign='top'>"
						    	+ "<table  height='30' style='background:#ECE9D8;' id='jq_screen_operate' width='100%' border='0' cellpadding='0' cellspacing='0'>"
						    	+ "<tr>"
						    	+ "<td>&nbsp;</td>"
						    	+ "<td align='center' valign='middle'>";
							    if (setting.dialogType == "alert"){
							    	conetent += "<input type='button' class='jq_screen_alertBtn' value='" 
							    			 + setting.buttonValueYes 
							    			 + "' name='jq_screen_alertBtn' id='jq_screen_alertBtn'>";
							    }
							    else if (setting.dialogType == "confirm"){
							    	conetent += "<input type='button' class='jq_screen_yesBtn' value='" 
						    			 + setting.buttonValueYes 
						    			 + "' name='jq_screen_yesBtn' id='jq_screen_yesBtn'>"	
						    			 + "&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' class='jq_screen_noBtn' value='" 
						    			 + setting.buttonValueNo 
						    			 + "' name='jq_screen_noBtn' id='jq_screen_noBtn'>";	
							    }
							    else if (setting.dialogType == "iframe"){
							    	conetent += "<input type='button' class='jq_screen_iframeBtn' value='" 
						    			 + setting.buttonValueYes 
						    			 + "' name='jq_screen_iframeBtn' id='jq_screen_iframeBtn'>";				    	
							    }						    	
							    conetent += "<td>&nbsp;</td>"
						    	+ "</tr>"
						    	+ "</table>";		
							conetent += "</td>"
							+ "</tr>"					
							+ "</table>"
						+ "</td>"
						+ "</tr>"							
						+ "</table>";
					conetent+="</td>"
					+ "</tr>"	
					+ "</table>";
	    $(setting.windowDocument).find("#message__")
	    .css("margin-top",top)
	    .css("margin-left",left)
	    .css("width",setting.width)
		.css("height",setting.height)
		.css("display","block")
		.html(conetent);
	};	
	
    //绑定事件函数
	SCREEN.bindEvent = function()
	{
		$(setting.windowDocument).find("#_dialogImg").bind("click",function(){
			isLock = false;
			SCREEN.clearScreen();
		}).bind("mouseover",function(){
			$(this).attr("src",icon.CLOSED);
		}).bind("mouseout",function(){
			$(this).attr("src",icon.CLOSE);
		});
		
		$("#jq_screen_operate",setting.windowDocument).find("input").bind("click",function(){
			var intputid = $(this).attr("id");
			if (intputid == 'jq_screen_alertBtn'){
				isLock = false;
				SCREEN.clearScreen();
			}
			else if (intputid == 'jq_screen_yesBtn'){
				isLock = false;
				setting.returnValue = '1';
				SCREEN.clearScreen();					
			}
			else if (intputid == 'jq_screen_noBtn'){
				isLock = false;
				setting.returnValue = '0';
				SCREEN.clearScreen();					
			}
			else if (intputid == 'jq_screen_closeBtn'){
				isLock = false;
				SCREEN.clearScreen();					
			}
			else{
				isLock = false;
				SCREEN.clearScreen();				
			}
		}).bind("mouseover",function(){
			$(this).css("border-color","#E27907");		
		}).bind("mouseout",function(){
			$(this).css("border-color","#C8C8C6");
		});
		//浏览器窗口变化时，自动调整锁屏大小
//		$(window).wresize(function(){
//			if (isLock){
//			    var swidth = $("html",setting.windowDocument).find("body").width()-14;
//			    var sheight = $("html",setting.windowDocument).find("body").height()-14;
//				$("html",setting.windowDocument).find("#screen").css("width",swidth)
//				.css("height",sheight).css("display","block");
//			}
//		});		
	};
	
	//初始化函数
	SCREEN.init = function(){
		var rvalue = false;
		if (typeof option.clickEvent == 'function'){
			rvalue = option.clickEvent(setting);
		}
		if(!rvalue){
			//触发锁频函数标识
			isLock = true;
			//设置下拉框不可用
			SCREEN.disableSelect();
			//锁屏函数
			SCREEN.lockScreen();
			//对话框函数
			SCREEN.dialog();
		    //绑定事件函数
			SCREEN.bindEvent();		
		}
		return rvalue;
	};
	
	//初始化函数
	SCREEN.init();
};