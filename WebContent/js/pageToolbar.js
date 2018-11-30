$(function(){
	
	window.onresize = function(){ 
		if($("#windowwidth",parent.document).val()-280<750){
			/*$(".pageb #goPageBtn").hide();
			$(".pageb #goPage").hide();*/
		}else{
			$(".pageb #goPageBtn").show();
			$(".pageb #goPage").show();
		}
	};
	
	if($("#windowwidth",parent.document).val()-280<750){
		/*$(".pageb #goPageBtn").hide();
		$(".pageb #goPage").hide();*/
	}
	
	$(".pageb #pageBack").click(function(){
		var url = $(".pageb #pageBackParam").val();
		var changeType = $("#changeType").val();
		var change_type = $("#change_type").val();
		var selectscreenidtrpage = $("#selectscreenidtrpage").val();
		var selectscreenidtr4v = $("#selectscreenidtr4v").val();
		
		if (changeType){
			url += "&paramMap.changeType=" + changeType+"&paramMap.selectscreenidtr="+selectscreenidtrpage+"&paramMap.selectscreenidtr4v="+selectscreenidtr4v;
		}
		if (change_type){
			url += "&paramMap.change_type=" + change_type;
		}
		
		window.location = url;
	});
	$(".pageb #pageNext").click(function(){
		var url = $(".pageb #pageNextParam").val();
		var changeType = $("#changeType").val();
		var change_type = $("#change_type").val();
		var selectscreenidtrpage = $("#selectscreenidtrpage").val();
		var selectscreenidtr4v = $("#selectscreenidtr4v").val();
		
		if (changeType){
			url += "&paramMap.changeType=" + changeType+"&paramMap.selectscreenidtr="+selectscreenidtrpage+"&paramMap.selectscreenidtr4v="+selectscreenidtr4v;
		}
		if (change_type){
			url += "&paramMap.change_type=" + change_type;
		}
		
		window.location = url;
	});	
	$(".pageb a").click(function(){
		var page = $(this).text();
		var url = $("#page"+parseInt(page)).val();
		var changeType = $("#changeType").val();
		var change_type = $("#change_type").val();
		var selectscreenidtrpage = $("#selectscreenidtrpage").val();
		var selectscreenidtr4v = $("#selectscreenidtr4v").val();
		
		if (changeType){
			url += "&paramMap.changeType=" + changeType+"&paramMap.selectscreenidtr="+selectscreenidtrpage+"&paramMap.selectscreenidtr4v="+selectscreenidtr4v;
		}
		if (change_type){
			url += "&paramMap.change_type=" + change_type;
		}
		window.location = url;
	});

	$(".pageb #goPageBtn").click(function(){
		var gpage = $(".pageb #goPage").val();
		var cnt = $(".pageb #pageCount").val();
		var url = $(".pageb #pageCountParam").val();
	
		if (parseInt(gpage) <=0)
	    {
	    	alert("输入的页数不能小于或等于零！");
	        $("#goPage").focus();
	        return false;
	        
	    }
	    if (parseInt(gpage) > parseInt(cnt)){
		    alert("输入的页数不能大于总页数！");
		    $("#goPage").focus();
		    return false;
		}
	    if (!gpage.match(/^[0-9]*[0-9]$/))
	    {
	        alert("跳转页数必须为数字！");
	        $("#goPage").focus();
	        return false;
	        
	    }		
		var changeType = $("#changeType").val();
		var change_type = $("#change_type").val();
		var selectscreenidtrpage = $("#selectscreenidtrpage").val();
		var selectscreenidtr4v = $("#selectscreenidtr4v").val();
		
		if (changeType){
			url += "&paramMap.changeType=" + changeType+"&paramMap.selectscreenidtr="+selectscreenidtrpage+"&paramMap.selectscreenidtr4v="+selectscreenidtr4v;
		}
		if (change_type){
			url += "&paramMap.change_type=" + change_type;
		}
		window.location = url+"&currentPage=" + gpage;
	});	
	$(".pageb #goPageBtn").show();
	$(".pageb #goPage").show();
});