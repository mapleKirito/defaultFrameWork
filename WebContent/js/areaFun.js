function clickMap(th){
	var href = $(th).attr("fd");
	window.parent.tabClick('R_701','资源详细','-701001',href);	
}
function showMap(id,src){
	var oBj = $(src).find("img");
	var pathd = $(oBj).attr("src");
	var my_array = new Array();
	var jing = new Array();
	var wei = new Array();
	var pathT = $(src).attr("path");
	var hrefUrl = 'ajaxAction.action?code=-2011&paramMap.areaDistriResID='+id+'&currentDate='+new Date().getTime();
	//alert(hrefUrl+" -- " + pathT + " -- " + pathd);
	$.ajax({
		url:		hrefUrl,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){		
			if (jsonData.data.length > 0) {
				//alert(jsonData.data.length);
				for (var i = 0; i < jsonData.data.length; i++) {
					
					var areaDistriLatitude = jsonData.data[i].areaDistriLatitude;
					var areaDistriLongitude = jsonData.data[i].areaDistriLongitude;
					var areaDistriResID = jsonData.data[i].areaDistriResID;								
					var areaDistriName = jsonData.data[i].areaDistriName;		
					var areaDistriResName = jsonData.data[i].areaDistriResName;		
					jing[i] = areaDistriLatitude;
					wei[i] = areaDistriLongitude;	
				
					my_array[i]="<div style=\"width:250px;text-align:center;\">" + 
					"<a onclick='clickMap(this)' href='#' fd='decorateForwardAction.action?code=-701001&path="+pathT+
					"&paramMap.erType=1011&paramMap.fileType=1011&paramMap.erID="+areaDistriResID+
					"&paramMap.st=1&paramMap.temppname=erID&paramMap.temppid="+areaDistriResID+"&paramMap.name="+areaDistriResName+
					"&paramMap.cateSign=exhibition&paramMap.roomtype=exhibition&paramMap.map=map'>"+
					"<img style='margin:4px' id='imgDemo' src='"+pathd+"' width='139' height='104'/>" + 
					"</a><div style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'></div>" + 
					"</div>";

				}
			}else{
				art.dialog.alert('此资源暂时没有录入分布地区');
			}			

			var map = new BMap.Map("allmap",{mapType: BMAP_HYBRID_MAP});   
			map.centerAndZoom(new BMap.Point(30,39), 3);
			map.enableScrollWheelZoom();


			function addMarker(point){
			  var marker = new BMap.Marker(point);
			  map.addOverlay(marker);
			  
			  var infoWindow = new BMap.InfoWindow(sContent);  // 创建信息窗口对象
			  
			     marker.addEventListener("click", function(){          
			     this.openInfoWindow(infoWindow);
			     //图片加载完毕重绘infowindow
			     document.getElementById('imgDemo').onload = function (){
			         infoWindow.redraw();
			     };
			    });
			  
			  marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
			 }
			setTimeout(function(){
				// 随机向地图添加25个标注
				var ddmap={};	
				var ji = 0;
				var d = 0;
				var ischina = true;
				var ischinajing = 0;
				var ischinaweid = 0;
				
				for (var i = 0; i < jing.length; i ++) {
					ji =wei[i];
					d = jing[i];
					
					ischinajing = d;
					ischinaweid = ji;
					
					if(d>=73.33 && d<=135.05 && ji>=3.51 && ji<= 53.33){
						ischina = false;
						ischinajing = d;
						ischinaweid = ji;
					}
					
					  ddmap['point'+i] = new BMap.Point(ji,d );
					  ddmap['marker'+i] = new BMap.Marker(ddmap['point'+i]);
					  ddmap['marker'+i].index=i;
					  map.addOverlay(ddmap['marker'+i]);
					  ddmap['infoWindow'+i]= new BMap.InfoWindow(my_array[i]);  // 创建信息窗口对象						  
					  ddmap['marker'+i].addEventListener("click", function(){ 	
						  var index=this.index;
						  this.openInfoWindow(ddmap['infoWindow'+index]);
						  $(".Pagination").remove();
					  });
					  ddmap['marker'+i].setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
				}
				
				if(jing.length!=0 && ischina){
					setTimeout(function(){
						map.setCenter(new BMap.Point(ischinaweid, ischinajing));  
						map.setZoom(5); 	  
					}, 1500);	
						
				}
				
			}, 1000);					
			},
			
			error:function(request,textStatus,error){}
	      });
	
		
	}
function prev(flag){
		var pathID = 0;
		var path = 0;
		var erDaiValue = document
					.getElementById("erDai");
			pathID = $(
					erDaiValue.options[$(
							"#erDai option:selected")
							.index()]).attr("optpathid");
			path = $(
					erDaiValue.options[$(
							"#erDai option:selected")
							.index()]).attr("path");
	
		var erJieValue = document.getElementById("erJie");
		var erDiliValue = document.getElementById("erDili");
		var erDaiValue = document.getElementById("erDai");
		var erQuanValue = document.getElementById("erQuan");

		var erTotalID = $(
				erDiliValue.options[$(
						"#erDili option:selected").index()])
				.attr("optpathid");
		var erJieID = $(
				erJieValue.options[$(
						"#erJie option:selected").index()])
				.attr("optpathid");
		var erQuanID = $(
				erQuanValue.options[$(
						"#erQuan option:selected").index()])
				.attr("optpathid");
		var erDaiID = $(
				erDaiValue.options[$(
						"#erDai option:selected").index()])
				.attr("optpathid");
		
		if(flag==0){
			if(parseInt($("#start").val()) <= 0){
				/*alert("已经是第一页了");*/
				art.dialog.alert('已经是第一页了');
				return;
			}
			if((parseInt($("#start").val()) -8)<0)
				$("#start").val(0);
			$("#start").val($("#start").val()-8);
			//向上查找
			var href = 'ajaxAction.action?code=' + -2110
			+ '&paramMap.path=' + path
			+ '&paramMap.cateID=' + pathID
			+ '&paramMap.erTotalID=' + erTotalID
			+ '&paramMap.erJieID=' + erQuanID
			+ '&paramMap.erChorID=' + erJieID
			+ '&paramMap.erGangID=' + erDaiID
			
			+ '&paramMap.start1='+$("#start").val()+'&paramMap.cateSign=exhibition&paramMap.flag=flag&paramMap.pageSize=8&currentDate=' 
			+ new Date().getTime();
			
			if($("#resInfo").html()!=''){
				$.ajax({
					url:		href,
					type:	    'post',
					timeout:	'55000',
					data:	Array(), 
					dataType:	'json',
					beforeSend:function(request){},
					complete:function(request,textStatus){},
					success:function(jsonData,textStatus){
						if (textStatus == "success" && jsonData.data){
							if (jsonData.data.length > 1){
								$("#resInfo").html("");
								   var Items="<ul>";
								   for (var i=0; i<jsonData.data.length;i++){	
									   var di = jsonData.data[i].thumbnail;
										Items +="<li><a href='#' path='"+jsonData.data[i].path+"'  onclick='showMap("+jsonData.data[i].id+",this)'><img  src='"
										+jsonData.data[i].thumbnail+"' width='80' height='80' title='"+jsonData.data[i].name+"'/><p class='pName'>"+jsonData.data[i].name+"</p></a></li>" ;
										
								   }
								   Items +="</ul>";
								   $("#resInfo").append(Items);	
							}		
						 }
					},
					
					error:function(request,textStatus,error){}
				});
			}
			
		}else{
			if(parseInt($("#start").val()) >= parseInt($("#count").val())){
				/*alert("已经是最后一页了");*/
				art.dialog.alert('已经是最后一页了');
				return;
			}
			//向下查找
			var href = 'ajaxAction.action?code=' + -2110
			+ '&paramMap.path=' + path
			+ '&paramMap.cateID=' + pathID
			+ '&paramMap.erTotalID=' + erTotalID
			+ '&paramMap.erJieID=' + erQuanID
			+ '&paramMap.erChorID=' + erJieID
			+ '&paramMap.erGangID=' + erDaiID
			+ '&paramMap.start1='+$("#start").val()+'&paramMap.cateSign=exhibition&paramMap.flag=flag&paramMap.pageSize=8&currentDate=' 
			+ new Date().getTime();
			//alert(href);
			if($("#resInfo").html()!=''){
				$.ajax({
					url:		href,
					type:	    'post',
					timeout:	'55000',
					data:	Array(), 
					dataType:	'json',
					beforeSend:function(request){},
					complete:function(request,textStatus){},
					success:function(jsonData,textStatus){
						if (textStatus == "success" && jsonData.data){
						
							if (jsonData.data.length > 1){
							
								$("#resInfo").html("");
								   var Items="<ul>";
								   for (var i=0; i<jsonData.data.length;i++){	
									   var di = jsonData.data[i].thumbnail;
										Items +="<li><a href='#' path='"+jsonData.data[i].path+"' onclick='showMap("+jsonData.data[i].id+",this)'><img  src='"
										+jsonData.data[i].thumbnail+"' width='80' height='80' title='"+jsonData.data[i].name+"'/><p class='pName'>"+jsonData.data[i].name+"</p></a></li>" ;
										
								   }
								   Items +="</ul>";
								   $("#resInfo").append(Items);	
								   var dd = parseInt($("#start").val())+8;
								   $("#start").val(dd);		
							}		
						 }
					},
					
					error:function(request,textStatus,error){}
				});
			}
			
		}
}
var fal = 1;
function show(){
	if(fal == 1){
		$("#conT").width(0);
		$("#CON").css("left","0px");
		$("#allmap").css("left","10px");
		$("#allmap").css("width","100%");
		document.getElementById('CON').style.background="url(images/top/zuo.png) no-repeat";
		fal = 0;
	}else{
		$("#conT").width(200);
		$("#CON").css("left","200px");
		document.getElementById('CON').style.background="url(images/top/you.png) no-repeat";
	    $("#allmap").css("left","210px");		
		fal = 1;
		
	}
	
}
function Search_area(){
	var keyword = $("#search_area").val() ;
	if(keyword==''){
	   alert('查询内容不能为空');
	   return false;
	}
	keyword = encodeURI(keyword);
	keyword = encodeURI(keyword); 
	$.ajax({
		url:		'ajaxAction.action?code=-2019&paramMap.resType=-1101&paramMap.keyword=' + keyword +'&pageSize=20' ,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success"){				
				if (jsonData.data.length >= 1){					
					 $("#resInfo").html("");
					 $("#resInfo").css("overflow","visible");					 
					 var Items="<ul>";
					 for (var i=0; i<jsonData.data.length;i++){	
							Items +="<li><a href='#' path='"+jsonData.data[i].erPath+"'  onclick='showMap("+jsonData.data[i].erID+",this)'><img  src='"
							+jsonData.data[i].erThumbnail+"' width='80' height='80' title='"+jsonData.data[i].erName+"'/><p class='pName'>"+jsonData.data[i].erName+"</p></a></li>" ;
						}
					   Items +="</ul>";
					   $("#resInfo").append(Items);				        						   
					   $("#resInfo").css("overflow","scroll");
				}
			}
		},		
		error:function(request,textStatus,error){}		
	});
}	