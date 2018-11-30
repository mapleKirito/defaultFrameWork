var cliheight = $("#windowheight_",parent.document).val();
$(document).ready(function(){
	$("#resView").css("height",$("#windowheight",parent.document).val());
	
	fieldControl();
	
	$(".es-carousel-wrapper .es-carousel .es-carouselwai ul li a img").click(function() {	
		var params = $(this).parent().attr("params");
		isinfor(params);	
	});
	
	$(".addFavorite").click(function(){
		$("#screen__",parent.document).css({
			"width":window.screen.width+"px",
			"height":$("#windowheight_",parent.document).val()+"px"
		}).show();
		$(".message_only",parent.document).css({
			"top":($("#windowheight_",parent.document).val()-150)/2+"px",
			"left":(window.screen.width-250)/2+"px"
		}).show();
		$(".message_only #container #container_text",parent.document).html("确认将此资源加入收藏吗?");
	});
	
	$(".WtableTBig_close .WtableTBig ._close",parent.document).click(function(){
		$(".message_only",parent.document).hide();
		$("#screen__",parent.document).hide();
		if($(this).attr('class').indexOf('jq_screen_alertBtn_true')>-1)
			window.parent.insert_fav($(".addFavorite"));
	});
	
	//初始化相关资源展示事件（缩略图展示、缩略图翻页）
	$("#s1").xslider({
		unitdisplayed:4,
		movelength:3,
		unitlen:176,
		autoscroll:null
	});
	   //点击顶部按钮触发事件
    $('div.rg-image-fo').toggle(function () {
        $(".rg-image-controls table").hide();
        $(".rg-image-fo").html("<img src='images/right.png' border=0 />");
    }, function () {
  	  $(".rg-image-controls table").show();
  	  $(".rg-image-fo").html("<img src='images/left.png' border=0 />");
    });
    if($("#es-carouselul li").length==0){
    	$("#cotrol").hide();
    }
    
    // 资源概述按钮
	$("#story_btn").click(function(){
		var path = 'paramMap.rrType='+$("#srotyIDH").val()+"&paramMap.roomname="+$(".roomname").val();
		window.parent.tabClick('story','资源简介','9119',path);
		
	 });
 // 图片切换左按钮
	$("#detailLeft").click(function(){
		var currentIndex = $("#resView").attr("_index");
		var allPic = $("#es-carouselul li").length;
		//说明 如果是0.就是说明是第一个，那就显示最后一个数据
		if(currentIndex==0){
			
		}else{
			$("#resView").attr("_index",parseInt(currentIndex)-1);
			var upload = $("#es-carouselul li").eq(parseInt(currentIndex)-1).find("a").attr("upload");			
			var inthum = $("#es-carouselul li").eq(parseInt(currentIndex)-1).find("a").attr("inthum");
			//同步div中的看见的 图片
			$("#resView").attr("src",inthum);			
			//同步div中的upload字段....div中显示的资源
			$("#resView").attr("upload",upload);
			//同步下载
			$("#download").attr("href",'downloadAction.action?code=-706&paramMap.resPath='+upload);
			//同步查看大图
			$("#imagesview_btnnew").attr("path",upload);
			
			var params = $("#es-carouselul li").eq(parseInt(currentIndex)-1).find("a").attr("params");
			isinfor(params);
			
		}		
		
	 });
	 // 图片切换右按钮
	$("#detailRight").click(function(){
		var currentIndex = $("#resView").attr("_index");
		var allPic = $("#es-carouselul li").length;
		//说明数据到结束了，需要从第一个数据开始
		if(currentIndex==(parseInt(allPic)-1)){
			
		}else{
			//需要将数据依次向后展示
			$("#resView").attr("_index",parseInt(currentIndex)+1);
			var upload = $("#es-carouselul li").eq(parseInt(currentIndex)+1).find("a").attr("upload");			
			var inthum = $("#es-carouselul li").eq(parseInt(currentIndex)+1).find("a").attr("inthum");
			//同步div中的看见的 图片
			$("#resView").attr("src",inthum);			
			//同步div中的upload字段....div中显示的资源
			$("#resView").attr("upload",upload);
			//同步下载
			$("#download").attr("href",'downloadAction.action?code=-706&paramMap.resPath='+upload);
			//同步查看大图
			$("#imagesview_btnnew").attr("path",upload);
			
			var params = $("#es-carouselul li").eq(parseInt(currentIndex)+1).find("a").attr("params");
			isinfor(params);
			
		}	
	 });
		
	// 1.初始化点击详细信息触发事件
	$("#lookdetail").click(function(){
		var isView = $(".rg-controls-lookdetail").css("display");		
		if(isView=="none"){
				
			$(".rg-controls-locatiarea").fadeOut(600);
			$(".rg-controls-interlinki").fadeOut(600);		   
			$(".rg-controls-lookdetail").fadeIn(600);
			if(($("#windowheight",parent.document).val()-68)<$(".rg-controls-lookdetail").height()){		
				 $(".rg-controls-lookdetail").css("height","100%");
			 }
				
		}else{
			$(".rg-controls-lookdetail").fadeOut(600);
		}
	 });

	//2.初始化点击网络链触发事件
	 $("#interlinki").click(function(){
		 var isView = $(".rg-controls-interlinki").css("display");
		 if(isView=="none"){
			 $(".rg-controls-locatiarea").fadeOut(600);
			 $(".rg-controls-lookdetail").fadeOut(600);
			 $(".rg-controls-interlinki").fadeIn(600); 
		 }else{
			 $(".rg-controls-interlinki").fadeOut(600);
		 }
	 });
	//3.初始化点击地球触发事件
	 $("#locatiarea").click(function(){
		 var isView = $(".rg-controls-locatiarea").css("display");
		 if(isView=="none"){		
			 $(".rg-controls-interlinki").fadeOut(600);
			 $(".rg-controls-lookdetail").fadeOut(600);
	         $(".rg-controls-locatiarea").fadeIn(600);   
		 }else{
        	 $(".rg-controls-locatiarea").fadeOut(600);	
         }
	 });
	 //初始化点击底部标签切换事件
	 var $tab = $("#thumleft table tr td.tabtd");
	 $tab.click(function(){
		var index = $tab.index(this);
		if(index == 1){
			$(".es-carousel-wrapper .es-nav span").hide();
			$(".scrolllist .abtn").show();
		}else{
			$(".es-carousel-wrapper .es-nav span").show();	
			$(".scrolllist .abtn").hide();
		} 
		
		$(this).addClass("selected").siblings().removeClass("selected");
		$("div.tabdiv").eq(index).show().siblings("div.tabdiv").hide();
		if($(".es-nav").css("display")=="none"){
	     	 $(".es-nav").show();	
			 $(".es-carousel-wrapper").animate({ height:$("#thumleft").height() + $(".es-carouselwai").height() + 3 }, 'slow');
			 $("#thumleft table tr td img").attr("src","images/right.png");
		}
		
	});
	 	 
	 //初始化点击底部方向箭头触发事件
	 $("#thumleft table tr td img").click(function(){
		 if($(".es-nav").css("display")=="none"){
			 $(".es-nav").show();	
			 $(".es-carousel-wrapper").animate({ height:$("#thumleft").height() + $(".es-carouselwai").height() + 3 }, 'slow');
			 $("#thumleft table tr td img").attr("src","images/right.png");
		}else{
			 setTimeout(function() {
				 $(".es-nav").hide();	
			 },1000);
			// $("#es-carouselul").animate({ height: 'toggle', opacity: 'toggle' }, "slow");	
			 $(".es-carousel-wrapper").animate({ height:$("#thumleft").height() }, 'slow');  
			 $("#thumleft table tr td img").attr("src","images/left.png");
		}	
	});
	 
	 var cliwidth = document.body.clientWidth;   
	 $(".rg-controls-lookdetail").css("top","40px");
	 $("#thumleft").css("width","51%");
	 $(".scrolllist").css("width","100%");
	 $(".scrolllist .imglist_w").css("width",cliwidth-38+"px");
	 var detailHeigh = $(".rg-controls-lookdetail").height();
	 if(($("#windowheight",parent.document).val()-68)<detailHeigh){
		 $(".rg-controls-lookdetail").css("height","100%");
	 }
	
	$("#imagesview_btnnew").click(function(){
		 LookImgFun();
	});	
	
	$(".lookimageclose",parent.document).click(function(){
		 $(this).hide();
		 
		 if($(".lookimage_ img",parent.document).length>0){
			 $(".lookimage_ img",parent.document).remove();
			 $(".lookimage_",parent.document).hide();
		 }
		 
		 
		 $("html",window.parent.document).find("#screen__").hide();
	});	
	
	 
	 $("#cotrol img").css("margin-top",($("#windowheight",parent.document).val()-90)/2+"px");
	
});      
function LookImgFun(){var h = 0,w = 0;
	var h = 0,w = 0;
	var img = new Image();
	img.src = $('img#resView').attr('upload');
	art.dialog.data('imgpath', img.src);
	art.dialog.data('contextPath', 'dm');
	art.dialog.open('/dm/lookimg.jsp',{window: 'top',width:'100%',height:'100%',title:'高清图片查看大图(点击图片,全局查看)',lock:'true',background:'#666666',opacity: '0.15'}) ;
	//window.open(img.src,'','status=0,directories=0,resizable=1,toolbar=0,top=0,left=0,menubar=no,location=0,scrollbars=1,width='+window.screen.availWidth+',height='+window.screen.availHeight);
	//window.open("FullScreen.jsp?imgURL="+img.src,'','fullscreen=1');
}
//: 判断网页是否加载完成  
document.onreadystatechange = function () {   
    if(document.readyState=="complete") {      
        document.getElementById('rg-thumbs').style.display='';   
    }  
};       
function isFieldNull(fieldName){
	var reg = /^\s+$/;
    if(typeof fieldName == 'undefined' || fieldName == '' || reg.test(fieldName)){
    	  return true;
    }
    return false;
}
function isNull(filename){
	if(typeof filename != 'undefined' && filename != '' && filename != null){
  	  return true;
	}
	return false;
}
function getWordW(){
	var word = document.getElementById("word2").value;
	window.open('http://zh.wikipedia.org/wiki/'+word,'','status=0,directories=0,resizable=1,toolbar=0,menubar=no,location=0,scrollbars=1,width=837,height=525');
}
function getWordH(){
	var word = document.getElementById("word1").value;
	window.open('http://www.hudong.com/wiki/'+word+'&prd=button_doc_jinru','','status=0,directories=0,resizable=1,toolbar=0,menubar=no,location=0,scrollbars=1,width=837,height=525');
}

function isinfor(params){
	var id = "",room = "";
		if(params.indexOf("exhibition") > -1){
			id = "erID";room = "exhibition";
		}else if(params.indexOf("observation") > -1){
			id = "orID";room = "observation";
		}else if(params.indexOf("laboratory") > -1){
			id = "lrID";room = "laboratory";
		}else if(params.indexOf("projection") > -1){
			id = "prID";room = "projection";
		}else if(params.indexOf("lovely") > -1){
			id = "erID";room = "lovely";
		}
		
		params = params.substring(params.indexOf(id)+5,params.length);
		params = params.substring(0,params.indexOf("&")); 
		
		var serid = params;

		if(isNull(serid) && isNull(room)){
			$.ajax({
			  	url:		'SmallServlet/ser?ID='+serid+'&roomname='+room,
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					if (textStatus == "success"){
						if($(".roomname").val() == 'exhibition'){
							  
							  if(isNull(jsonData.ER_Content)){
						 		  $("#story_btn").parent().show();
						 		  $("#srotyIDH").val(serid);
					 		  }else{
					 			  $("#story_btn").parent().hide();
					 		  }
							
							 
							  $(".addFavorite").attr("id","-701001|"+jsonData.ER_Path+"|exhibition|1"+"|"+jsonData.ER_Name+"|1011|"+serid);
							  
					    	  $("#download").attr("href",'downloadAction.action?code=-706&paramMap.resPath='+jsonData.ER_Upload+"&paramMap.cname="+jsonData.ER_Name+"&paramMap.ctype="+jsonData.ER_Type+"&paramMap.cid="+jsonData.ER_Type+"&paramMap.croom=exhibition");
							  //初始化 资源编号 tr
						      $(".erCode").html(jsonData.ER_Code);
						      //初始化 资源名称 tr
						      $(".erName").html(jsonData.ER_Name);
						      //初始化 资源分类 tr
						      $(".erTotal").html(jsonData.ER_Total);
						      //初始化 二级分类 tr
						      //alert(jsonData.ER_Jie);
						      if(isNull(jsonData.ER_Jie)){
						    	  $(".erJie").parent().show();
						    	  $(".erJie").html(jsonData.ER_Jie);
						      }else{
						    	  $(".erJie").parent().hide();
						      }
						     //初始化 三级分类 tr
						      //alert(jsonData.ER_Chor);
						      if(isNull(jsonData.ER_Chor)){
						    	  $(".erChor").parent().show();
						    	  $(".erChor").html(jsonData.ER_Chor);
						      }else{
						    	  $(".erChor").parent().hide();
						      }
						      //初始化 四级分类 tr
						      //alert(jsonData.ER_Gang);
						      if(isNull(jsonData.ER_Gang)){
						    	  $(".erGang").parent().show();
						    	  $(".erGang").html(jsonData.ER_Gang);
						      }else{
						    	  $(".erGang").parent().hide();
						      }
						      //初始化 五级分类 tr
						      //alert(jsonData.ER_Order);
						      if(isNull(jsonData.ER_Order)){
						    	  $(".erOrder").parent().show();
						    	  $(".erOrder").html(jsonData.ER_Order);
						      }else{
						    	  $(".erOrder").parent().hide();
						      }
						      //初始化 中文科名 tr
						      //alert(jsonData.ER_CategoryName);
						      /*if(isNull(jsonData.ER_CategoryName)){
						    	  $(".erCategoryName").parent().show();
						    	  $(".erCategoryName").html(jsonData.ER_CategoryName);
						      }else{
						    	  $(".erCategoryName").parent().hide();
						      }*/
							  //初始化 中文属名 tr
						      //alert(jsonData.ER_Genus);
						      /*if(isNull(jsonData.ER_Genus)){
						    	  $(".erGenus").parent().show();
						    	  $(".erGenus").html(jsonData.ER_Genus);
						      }else{
						    	  $(".erGenus").parent().hide();
						      }*/
						      /*//初始化 俗名 tr
						      //alert(jsonData.ER_Custom);
						      if(isNull(jsonData.ER_Custom)){
						    	  $(".erCustom").parent().show();
						    	  $(".erCustom").html(jsonData.ER_Custom);
						      }else{
						    	  $(".erCustom").parent().hide();
						      }*/
						      /*//初始化 拉丁学名 tr
						      //alert(jsonData.ER_LatinName);
						      if(isNull(jsonData.ER_LatinName)){
						    	  $(".erLatinName").parent().show();
						    	  $(".erLatinName").html(jsonData.ER_LatinName);
						      }else{
						    	  $(".erLatinName").parent().hide();
						      }
						      //初始化 保存地 tr
						      //alert(jsonData.ER_BiologicalReserve);
						      if(isNull(jsonData.ER_BiologicalReserve)){
						    	  $(".erBiologicalReserve").parent().show();
						    	  $(".erBiologicalReserve").html(jsonData.ER_BiologicalReserve);
						      }else{
						    	  $(".erBiologicalReserve").parent().hide();
						      }
						      //初始化 采集人 tr
						      //alert("ER_Hunters=="+jsonData.ER_Hunters);
						      if(isNull(jsonData.ER_Hunters)){
						    	  $(".erHunters").parent().show();
						    	  $(".erHunters").html(jsonData.ER_Hunters);
						      }else{
						    	  $(".erHunters").parent().hide();
						      }
						      //初始化 采集编号 tr
						      //alert("ER_SpecimensNo=="+jsonData.ER_SpecimensNo);
						      if(isNull(jsonData.ER_SpecimensNo)){
						    	  $(".erSpecimensNo").parent().show();
						    	  $(".erSpecimensNo").html(jsonData.ER_SpecimensNo);
						      }else{
						    	  $(".erSpecimensNo").parent().hide();
						      }*/
						      //初始化 国家 tr
						      //alert("ER_CountryName=="+jsonData.ER_CountryName);
						      if(isNull(jsonData.ER_CountryName)){
						    	  $(".erCountryName").parent().show();
						    	  $(".erCountryName").html(jsonData.ER_CountryName);
						      }else{
						    	  $(".erCountryName").parent().hide();  
						      }
						       //初始化 省份 tr
						      //alert("ER_ProvinceName=="+jsonData.ER_ProvinceName);
						      if(isNull(jsonData.ER_ProvinceName)){
						    	  $(".erProvinceName").parent().show();
						    	  $(".erProvinceName").html(jsonData.ER_ProvinceName);
						      }else{
						    	  $(".erProvinceName").parent().hide();
						      }
						      //初始化 市县区 tr
						      //alert("ER_City=="+jsonData.ER_City);
						      if(isNull(jsonData.ER_City)){
						    	  $(".erCity").parent().show();
						    	  $(".erCity").html(jsonData.ER_City);
						      }else{
						    	  $(".erCity").parent().hide();
						      }
						      /*//初始化 地名 tr
						      //alert("ER_PlaceName=="+jsonData.ER_PlaceName);
						      if(isNull(jsonData.ER_PlaceName)){
						    	  $(".erPlaceName").parent().show();
						    	  $(".erPlaceName").html(jsonData.ER_PlaceName);
						      }else{
						    	  $(".erPlaceName").parent().hide();
						      }*/
						      /*//初始化 纬度 tr
						      //alert("ER_Latitude=="+jsonData.ER_Latitude);
						      if(isNull(jsonData.ER_Latitude)){
						    	  $(".erLatitude").parent().show();
						    	  $(".erLatitude").html(jsonData.ER_Latitude);
						      }else{
						    	  $(".erLatitude").parent().hide();
						      }
						      //初始化 经度 tr
						      //alert("ER_Longitude=="+jsonData.ER_Longitude);
						      if(isNull(jsonData.ER_Longitude)){
						    	  $(".erLongitude").parent().show();
						    	  $(".erLongitude").html(jsonData.ER_Longitude);
						      }else{
						    	  $(".erLongitude").parent().hide();
						      }
						      //初始化 生境 tr
						      //alert("ER_Habitat=="+jsonData.ER_Habitat);
						      if(isNull(jsonData.ER_Habitat)){
						    	  $(".erHabitat").parent().show();
						    	  $(".erHabitat").html(jsonData.ER_Habitat);
						      }else{
						    	  $(".erHabitat").parent().hide();
						      }
						      //初始化 性状 tr
						      //alert("ER_Characteristics=="+jsonData.ER_Characteristics);
						      if(isNull(jsonData.ER_Characteristics)){
						    	  $(".erCharacteristics").parent().show();
						    	  $(".erCharacteristics").html(jsonData.ER_Characteristics);
						      }else{
						    	  $(".erCharacteristics").parent().hide();
						      }
						      //初始化 详细说明 tr
						      //alert("ER_Description=="+jsonData.ER_Description);
						      if(isNull(jsonData.ER_Description)){
						    	  $(".erDescription").parent().show();
						    	  $(".erDescription").html(jsonData.ER_Description);
						      }else{
						    	  $(".erDescription").parent().hide();
						      }
						      //初始化 海拔 tr
						      //alert("ER_Elevation=="+jsonData.ER_Elevation);
						      if(isNull(jsonData.ER_Elevation)){
						    	  $(".erElevation").parent().show();
						    	  $(".erElevation").html(jsonData.ER_Elevation);
						      }else{
						    	  $(".erElevation").parent().hide();
						      }
						      //初始化 鉴定人 tr
						      //alert("ER_Identifier=="+jsonData.ER_Identifier);
						      if(isNull(jsonData.ER_Identifier)){
						    	  $(".erIdentifier").parent().show();
						    	  $(".erIdentifier").html(jsonData.ER_Identifier);
						      }else{
						    	  $(".erIdentifier").parent().hide();
						      }
						      //初始化 鉴定日期 tr
						      //alert("ER_IdentifierDate=="+jsonData.ER_IdentifierDate);
						      if(isNull(jsonData.ER_IdentifierDate)){
						    	  $(".erIdentifierDate").parent().show();
						    	  $(".erIdentifierDate").html(jsonData.ER_IdentifierDate);
						      }else{
						    	  $(".erIdentifierDate").parent().hide();
						      }
						      //初始化 用途 tr
						      //alert("ER_Use=="+jsonData.ER_Use);
						      if(isNull(jsonData.ER_Use)){
						    	  $(".erUse").parent().show();
						    	  $(".erUse").html(jsonData.ER_Use);
						      }else{
						    	  $(".erUse").parent().hide();
						      }*/
						      //初始化 备注 tr
						      //alert("ER_Remarks=="+jsonData.ER_Remarks);
						      if(isNull(jsonData.ER_Remarks)){
						    	  $(".erRemarks").parent().show();
						    	  $(".erRemarks").html(jsonData.ER_Remarks);
						      }else{
						    	  $(".erRemarks").parent().hide();
						      }
					 	}else if($(".roomname").val() == 'observation'){
					 		  if(isNull(jsonData.OR_Content)){
						 		  $("#story_btn").parent().show();
						 		  $("#srotyIDH").val(serid);
					 		  }else{
					 			  $("#story_btn").parent().hide();
					 		  }
					 		  
					 		 $(".addFavorite").attr("id","-701004|"+jsonData.OR_Path+"|observation|1"+"|"+jsonData.OR_Name+"|1011|"+serid);
					 		  
					 		  $("#download").attr("href",'downloadAction.action?code=-706&paramMap.resPath='+jsonData.OR_Upload+"&paramMap.cname="+jsonData.OR_Name+"&paramMap.ctype="+jsonData.OR_Type+"&paramMap.cid="+jsonData.OR_Type+"&paramMap.croom=observation");
					 		  //初始化 资源编号 tr
					 		  //alert(jsonData.OR_NO);
						      $(".orNO").html(jsonData.OR_NO);
					 		  //初始化 资源名称 tr
						      //alert(jsonData.OR_Name);
						      $(".orName").html(jsonData.OR_Name);
						      //初始化 资源分类 tr
						      //alert(jsonData.OR_CategoryName);
						      $(".orCategoryName").html(jsonData.OR_CategoryName);
						      //初始化 二级分类 tr
						      //alert(jsonData.OR_CateTwLevel_Name);
						      if(isNull(jsonData.OR_CateTwLevel_Name)){
						    	  $(".orCateTwLevelName").parent().show();
						    	  $(".orCateTwLevelName").html(jsonData.OR_CateTwLevel_Name);
						      }else{
						    	  $(".orCateTwLevelName").parent().hide();
						      }
						      /*//初始化 俗名 tr
						      //alert(jsonData.OR_Custom);
						      if(isNull(jsonData.OR_Custom)){
						    	  $(".orCustom").parent().show();
						    	  $(".orCustom").html(jsonData.OR_Custom);
						      }else{
						    	  $(".orCustom").parent().hide();
						      }*/
						      /*//初始化 拉丁学名 tr
						      //alert(jsonData.OR_LatinName);
						      if(isNull(jsonData.OR_LatinName)){
						    	  $(".orLatinName").parent().show();
						    	  $(".orLatinName").html(jsonData.OR_LatinName);
						      }else{
						    	  $(".orLatinName").parent().hide();
						      }
						      //初始化 鉴定人 tr
						      //alert(jsonData.OR_Identifier);
						      if(isNull(jsonData.OR_Identifier)){
						    	  $(".orIdentifier").parent().show();
						    	  $(".orIdentifier").html(jsonData.OR_Identifier);
						      }else{
						    	  $(".orIdentifier").parent().hide();
						      }*/
						      //初始化 备注  tr
						      //alert(jsonData.OR_Remarks);
						      if(isNull(jsonData.OR_Remarks)){
						    	  $(".orRemarks").parent().show();
						    	  $(".orRemarks").html(jsonData.OR_Remarks);
						      }else{
						    	  $(".orRemarks").parent().hide();
						      }
						    	  
					 	}else if($(".roomname").val() == 'laboratory'){
					 		  if(isNull(jsonData.LR_Content)){
						 		  $("#story_btn").parent().show();
						 		  $("#srotyIDH").val(serid);
					 		  }else{
					 			  $("#story_btn").parent().hide();
					 		  }
					 		  
					 		 $(".addFavorite").attr("id","-701007|"+jsonData.LR_Path+"|laboratory|1"+"|"+jsonData.LR_Name+"|1011|"+serid);
					 		  
					 		  $("#download").attr("href",'downloadAction.action?code=-706&paramMap.resPath='+jsonData.LR_Upload+"&paramMap.cname="+jsonData.LR_Name+"&paramMap.ctype="+jsonData.LR_Type+"&paramMap.cid="+jsonData.LR_Type+"&paramMap.croom=laboratory");
					 		  //初始化 资源编号 tr
						      $(".lrNO").html(jsonData.LR_NO);
					 		  //初始化 资源名称 tr
						      $(".lrName").html(jsonData.LR_Name);
						      //初始化 资源分类 tr
						      $(".lrCategoryName").html(jsonData.LR_CategoryName);
						      //初始化 二级分类 tr
						      if(isNull(jsonData.LR_CateTwLevel_Name)){
						    	  $(".lrCateTwLevelName").parent().show();
						    	  $(".lrCateTwLevelName").html(jsonData.LR_CateTwLevel_Name);
						      }else{
						    	  $(".lrCateTwLevelName").parent().hide();
						      }
						      //初始化 详细信息 tr
						      if(isNull(jsonData.LR_Content)){
						    	  $(".lrContent").parent().show();
						    	  $(".lrContent").html(jsonData.LR_Content);
						      }else{
						    	  $(".lrContent").parent().hide();
						      }
					    }else if($(".roomname").val() == 'lovely'){
					    	 if(isNull(jsonData.CR_Content)){
						 		  $("#story_btn").parent().show();
						 		  $("#srotyIDH").val(serid);
					 		  }else{
					 			  $("#story_btn").parent().hide();
					 		  }
					    	 
					    	 $(".addFavorite").attr("id","-701007|"+jsonData.CR_Path+"|lovely|1"+"|"+jsonData.CR_Name+"|1011|"+serid);
					    	 
					 		  $("#download").attr("href",'downloadAction.action?code=-706&paramMap.resPath='+jsonData.CR_Upload+"&paramMap.cname="+jsonData.CR_Name+"&paramMap.ctype="+jsonData.CR_Type+"&paramMap.cid="+jsonData.CR_Type+"&paramMap.croom=lovely");
					 		  //初始化 资源编号 tr
					 		  //alert(jsonData.ER_No);
						      $(".crNo").html(jsonData.CR_No);
					 		  //初始化 资源名称 tr
						      //alert(jsonData.ER_Name);
						      $(".crName").html(jsonData.CR_Name);
						      //初始化 资源分类 tr
						      //alert(jsonData.ER_ResTypeName);
						      $(".crResTypeName").html(jsonData.CR_ResTypeName);
						      //初始化 二级分类 tr
						      //alert(jsonData.ER_CateTwLevel_Name);
						      if(isFieldNull(jsonData.CR_CateTwLevel_Name)){
						    	  $(".crCateTwLevelName").parent().show();
						    	  $(".crCateTwLevelName").html(jsonData.CR_CateTwLevel_Name);
						      }else{
						    	  $(".crCateTwLevelName").parent().hide();
						      }
						      //初始化 详细信息 tr
						      //alert(jsonData.ER_Content);
						      if(isFieldNull(jsonData.CR_Content)){
						    	  $(".crContent").parent().show();
						    	  $(".crContent").html(jsonData.CR_Content);
						      }else{
						    	  $(".crContent").parent().hide();
						      }
						 }
					};
				},			
				error:function(request,textStatus,error){}
			}); 
		}
}