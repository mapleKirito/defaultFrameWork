$.fn.screenTB = function(data,opt){
	var SCREEN = this;
	//是否锁屏标识
	var isLock = false;
	SCREEN.data = {
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
		//是否存在确定按钮
		buttons:'yes',
		//如果dialogType为iframe，iframeSrc不能为空
		iframeSrc:'',
		//原属绑定事件
		elmfunction:'click'
	};
	SCREEN.option ={
		clickEvent:false,
		submitEvent:false,
		paramEvent:false
	};
	SCREEN.icon = {
		ALERT:'images/window/icon-info.gif',
		DIAHEAD:'images/window/bg.gif',
		POST:'images/window/post.gif',
		CLOSE:'images/window/close.png',
		CLOSED:'images/window/closed.png'	
	};    
	//将配置的数据替换，增加到data对象中
	SCREEN.data = $.extend(SCREEN.data,data);
	//将配置的数据替换，增加到option对象中
	SCREEN.option = $.extend(SCREEN.option,opt);
	
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
	
	    var swidth = $("html",SCREEN.data.windowDocument).find("body").width()-21;
	    var sheight = $("html",SCREEN.data.windowDocument).find("body").height()-6;
		$("html",SCREEN.data.windowDocument).find("#screen__").css("width","100%").css("height",sheight).css("display","block");		
	};
	
	//解屏函数
	SCREEN.clearScreen = function()
	{
		$("html",SCREEN.data.windowDocument).find("#screen__").css("display","none");
		//$("html",SCREEN.data.windowDocument).find("#message__").html("");
		$("html",SCREEN.data.windowDocument).find("#message__").css("display","none");
		SCREEN.enableSelect();
	};
	
	//对话框函数
	SCREEN.dialog = function($obj)
	{
	    var swidth = $("html",SCREEN.data.windowDocument).find("body").width();
	    var sheight = $("html",SCREEN.data.windowDocument).find("body").height();
	    var otherfl= SCREEN.data.otherflag;
	    var top = sheight/ 2 - SCREEN.data.height/2;
	    var left = swidth/ 2-SCREEN.data.width/2;
	    
	 
	    
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
					    	+ "<table width='100%' height='22' border='0' cellspacing='0' cellpadding='0'>"
					    	+ "<tr>"
					    	/*+ "<td width='20' style='line-height:0.4px' >&nbsp;<img src='images/default/tab/tb.gif' border='0' width='16' height='16'></td>"*/
					    	+ "<td class='WtableTBig'><b style='color:#ffffff;'>"+SCREEN.data.title+"</b></td>"
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
						+ "<table width='100%' height='100%' border='0' id='container' cellpadding='0' cellspacing='0'>"
						+ "<tr>"
						+ "<td align='center'>";
					    if (SCREEN.data.dialogType == "alert"){
					    	conetent += "&nbsp;<img src='images/window/icon-info.gif' valign='absmiddle' width='32' height='32' border='0'>";
					    	conetent += "&nbsp;" + SCREEN.data.content;
					    }
					    else if (SCREEN.data.dialogType == "confirm"){
					    	conetent += "&nbsp;<img src='images/window/icon-info.gif' valign='absmiddle' width='32' height='32' border='0'>";
					    	conetent += "&nbsp;" + SCREEN.data.content;				    	
					    }
					    else if (SCREEN.data.dialogType == "iframe"){
					    	if (!SCREEN.data.iframeSrc){
					    		alert("SCREEN.data.iframeSrc is not null");
					    	}
					    	var param = "";
					    	if (typeof SCREEN.option.paramEvent == 'function'){
					    		param = SCREEN.option.paramEvent(SCREEN.data,$obj);
							}
					    	conetent += "<iframe width='100%' name='iframeDialog' id='iframeDialog' height='100%' src='"+SCREEN.data.iframeSrc+"&"+param +"' scrolling='auto' frameborder='0'></iframe>";
					    }
					    else{
					    	conetent += SCREEN.data.content;
					    }
					    conetent+="</td>"
						+ "</tr>";
						if (SCREEN.data.buttons == "yes"){
							conetent += "<tr>"
							+ "<td height='50' valign='top'>"
							    	+ "<table  height='50' id='jq_screen_operate' width='100%' border='0' cellpadding='0' cellspacing='0'>"
							    	+ "<tr>"
							    	+ "<td>&nbsp;</td>"
							    	+ "<td align='center' valign='middle'>";
								    if (SCREEN.data.dialogType == "alert"){
								    	conetent += "<input type='button' class='jq_screen_alertBtn' value='" 
								    			 + SCREEN.data.buttonValueYes 
								    			 + "' name='jq_screen_alertBtn' id='jq_screen_alertBtn'>";
								    }
								    else if (SCREEN.data.dialogType == "confirm"){
								    	conetent += "<input type='button' class='jq_screen_yesBtn' value='" 
							    			 + SCREEN.data.buttonValueYes 
							    			 + "' name='jq_screen_yesBtn' id='jq_screen_yesBtn'>"	
							    			 + "&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' class='jq_screen_noBtn' value='" 
							    			 + SCREEN.data.buttonValueNo 
							    			 + "' name='jq_screen_noBtn' id='jq_screen_noBtn'>";	
								    }
								    else if (SCREEN.data.dialogType == "iframe"){
								    	conetent += "<input type='button' class='jq_screen_iframeBtn' value='" 
							    			 + SCREEN.data.buttonValueYes 
							    			 + "' name='jq_screen_iframeBtn' id='jq_screen_iframeBtn'>";				    	
								    }	
								    else{
								    	conetent += "<input type='button' class='jq_screen_alertBtn' value='" 
							    			 + SCREEN.data.buttonValueYes 
							    			 + "' name='jq_screen_alertBtn' id='jq_screen_alertBtn'>";								    	
								    }
								    conetent += "<td>&nbsp;</td>"
							    	+ "</tr>"
							    	+ "</table>";		
								conetent += "</td>"
								+ "</tr>"					
								+ "</table>"
							+ "</td>"
							+ "</tr>";
						}
						+ "</table>";
					conetent+="</td>"
					+ "</tr>"	
					+ "</table>";
	    $("html",SCREEN.data.windowDocument).find("#message__")
	    .css("margin-top",top).css("margin-left",left)
	    .css("width",SCREEN.data.width)
		.css("height",SCREEN.data.height)
		.css("display","block")
		.html(conetent);
	};	
	
    //绑定事件函数
	SCREEN.bindEvent = function($obj)
	{
		$("html",SCREEN.data.windowDocument).find("#_dialogImg").bind("click",function(){
			isLock = false;
			SCREEN.clearScreen();
		}).bind("mouseover",function(){
			$(this).attr("src",SCREEN.icon.CLOSED);
		}).bind("mouseout",function(){
			$(this).attr("src",SCREEN.icon.CLOSE);
		});
		$("html",SCREEN.data.windowDocument).find("input").bind("click",function(){
			var intputid = $(this).attr("id");
			if (intputid == 'jq_screen_alertBtn'){
				isLock = false;
				SCREEN.clearScreen();
			}
			else if (intputid == 'jq_screen_yesBtn'){
				isLock = false;
				SCREEN.data.returnValue = '1';
				SCREEN.clearScreen();
				if (typeof SCREEN.option.submitEvent == 'function'){
					SCREEN.option.submitEvent(SCREEN.data,$obj);
				}
			}
			else if (intputid == 'jq_screen_noBtn'){
				isLock = false;
				SCREEN.data.returnValue = '0';
				SCREEN.clearScreen();					
			}
			else if (intputid == 'jq_screen_closeBtn'){
				isLock = false;
				SCREEN.clearScreen();					
			}
			else if (intputid == 'jq_screen_iframeBtn'){
				isLock = false;
				SCREEN.clearScreen();	
				if (typeof SCREEN.option.submitEvent == 'function'){
					SCREEN.option.submitEvent(SCREEN.data,SCREEN);
				}				
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
		$(window).wresize(function(){
			if (isLock){
			    var swidth = $("html",SCREEN.data.windowDocument).find("body").width()-4;
			    var sheight = $("html",SCREEN.data.windowDocument).find("body").height()-4;
				$("html",SCREEN.data.windowDocument).find("#screen").css("width",swidth)
				.css("height",sheight).css("display","block");
			}
		});		
	};
	
	//初始化函数
	SCREEN.init = function(){
		//绑定鼠标单击事件
		$(this).each(function(){
			$(this).bind(SCREEN.data.elmfunction,function(){
				
				if (typeof SCREEN.option.clickEvent == 'function'){
					SCREEN.option.clickEvent(SCREEN.data,$(this));
				}
				if(SCREEN.data.returnValue != 'true'){
					//触发锁频函数标识
					isLock = true;
					//设置下拉框不可用
					SCREEN.disableSelect();
					//锁屏函数
					SCREEN.lockScreen();
					//对话框函数
					SCREEN.dialog($(this));
				    //绑定事件函数
					SCREEN.bindEvent($(this));		
					return false;
				}
				else{
					return true;
				}
			});			
		});

	};
	
	//初始化函数
	SCREEN.init();
};