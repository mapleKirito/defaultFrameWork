$(document).ready(function(){	
	var $screen_ = $('input:radio[name="screenwidth_"]');
	$screen_.click(function(){
		
		var index = $screen_.index(this) + 1;
		//leftMenuClose();
		if(window.screen.width<1280){
			alert("在当前分辨率下右测框不适合调整，将隐藏左侧菜单。");
			var body_w = window.screen.width;
			var center_w = $(".main_c",parent.document).outerWidth();
			
			//leftMenuClose();
			/*$(".main_l",parent.document).hide();
			$("#yc",parent.document).attr("src", "images/main/ima_231.png").attr("cf","");
			$(".main_r",parent.document).css({
				left : "9px",
				width : body_w - center_w-1
			});*/
		}
		
		var screen_w = $('input:radio[name="screenwidth_"]:checked').val();
		$("#recomType").val(screen_w);
		if( screen_w=='1920'){
			screen_w -= 128; 
			$("#div_li").css("width",(screen_w-770)/1.5+20+"px").css("max-height","430px").css("overflow","auto");
			$(".table_9 tr td ul#list2").css("width",(screen_w-770)/1.5+"px");
			$("#div_li_down").css("width",(screen_w-770)/1.5+"px");
			$("#list1").hide();
			$("#list2").show();
		}else if( screen_w=='1024'){
			screen_w -= 150; 
			$("#div_li").css("width","460px").css("max-height","430px").css("overflow","auto");
			$(".table_9 tr td ul#list1").css("width","440px");
			$("#div_li_down").css("width","440px");
			$("#list1").show();
			$("#list2").hide();
		}
	
		
		if(index==1){
			$("#div_li_down").css("height",431-105-5 + "px");	
		}else{
			$("#div_li_down").css("height",431-5 + "px");
		}
		
		//1440：1440-130、1600：1600-132、1920：1920-131 welcomeDetail.jsp
	});
});
function init_(index_){
	$("#recomType").val('1024');
	var data = ($("#list1 li").map(function(){return $(this).children("input").val();}).get()).join("|");
	$("input[class='list1SortOrder1024']").val(data);
	var data2 = ($("#list2 li").map(function(){return $(this).children("input").val();}).get()).join("|");
	$("input[class='list1SortOrder1920']").val(data2);
	var da_id = ($("#list1 li").map(function(){return parseInt($(this).attr("data-itemidx"))+1;}).get()).join("|");
	$("input[class='list1Itemidx']").val(da_id); 
	var isXauto =  1.5;
	var width_screen = 1440-130;
	var height_screen_down = 431;
	
	$("#div_li").css("width",(width_screen-350)/isXauto+20+"px").css("max-height","448px").css("overflow","auto");
	$(".table_9 tr td ul#list1").css("width",(width_screen-550)/isXauto+"px").css("height","100%");
	$("#div_li_down").css("width",(width_screen-550)/isXauto+"px").css("height",height_screen_down-5 + "px");
	for(var i = 0;i < index_;i++){
		$("#img_div_"+i).autoZoomLoadImage(true,isXauto);
		$("#img_div2_"+i).autoZoomLoadImage(true,isXauto);
	}
}

jQuery.fn.autoZoomLoadImage = function(scaling,isX) {
	return this.each(function() {
		var t = $(this);
		var src = $(this).attr("src");
		var img = new Image();
		img.src = src;
		var autoScaling = function() {
			if (scaling) {
				if (img.width > 0 && img.height > 0) {
					t.css("width",img.width/isX+"px").css("height",img.height/isX+"px");
					t.parent().css("width",img.width/isX+"px").css("height",img.height/isX+"px");
					t.siblings().css("width",img.width/isX+"px");
				}
			}
		};
		if (img.complete) {
			autoScaling();
			return;
		}
		$(this).attr("src", "");
		var loading = $("<img alt=\"加载中\" title=\"图片加载中\" src=\"\"  width=\""+img.width/isX+"\" height=\""+img.height/isX+"\"/>");
		t.hide();
		t.after(loading);
		$(img).load(function() {
			autoScaling();
			loading.remove();
			t.attr("src", this.src);
			t.show();
		});
		
		if(navigator.appVersion.split(";")[1].replace(/[ ]/g,"").indexOf("IE") > -1){
			$("#div_li").css("height", t.parent().parent().position().top + +135 +"px");
			$(".table_9 tr td ul.dragsort").css("height",t.parent().parent().position().top+135+"px");
		}
	});	 
};