$(document).ready(function() {
	findChildArea(0);
	$(".BMap_center").css({
		"overflow" : "visible",
		"width" : "800px"
	});
	ctreatMap();
});
function ctreatMap (){
	var map = new BMap.Map("allmap",{mapType: BMAP_HYBRID_MAP});   
		map.centerAndZoom(new BMap.Point(30, 39), 3);
		map.enableScrollWheelZoom();

		function getBoundary(){       
		    var bdary = new BMap.Boundary();
		    bdary.get("内蒙古", function(rs){       //获取行政区域
		        var count = rs.boundaries.length; //行政区域的点有多少个
		        for(var i = 0; i < count; i++){
		            var ply = new BMap.Polygon(rs.boundaries[i], {strokeWeight: 2, strokeColor: "#ff0000"}); //建立多边形覆盖物
		            map.addOverlay(ply);  //添加覆盖物
		            map.setViewport(ply.getPath());    //调整视野         
		        }                
		    });   
		}
		

}
function findChildArea(level) {
	var parentID = 0;
	if (level == 1) {
		parentID = $("#erShi").val();
		$("#erShiName").val($("#erShi").find("option:selected").text());
		$("#erDiliName").val("");
		$("#erQuanName").val("");
		$("#erJieName").val("");
		$("#erDaiName").val("");
		$("#cateSign").val($("#erShi").find("option:selected").attr("cateSign"));
	} else if (level == 2) {
		parentID = $("#erDili").val();
		$("#erDiliName").val($("#erDili").find("option:selected").text());
		$("#erQuanName").val("");
		$("#erJieName").val("");
		$("#erDaiName").val("");
	} else if (level == 3) {
		parentID = $("#erQuan").val();
		$("#erQuanName").val($("#erQuan").find("option:selected").text());
		$("#erJieName").val("");
		$("#erDaiName").val("");
	} else if (level == 0) {
		parentID = 0;
	} else if (level == 4) {
		parentID = $("#erJie").val();
		$("#erJieName").val($("#erJie").find("option:selected").text());
		$("#erDaiName").val("");
	} else if (level == 5) {
		parentID = $("#erDai").val();
		$("#erDaiName").val($("#erDai").find("option:selected").text());

	}
	if (level == 0) {
		$("#erDili").empty();
		$("#erQuan").empty();

		$("#erShi").append($("<option>").text("--请选择室别--").val(""));
		$("#erDili").append($("<option>").text("--请选择一级目录--").val(""));
		$("#erQuan").append($("<option>").text("--请选择二级目录--").val(""));
		$("#erJie").append($("<option>").text("--请选择三级目录--").val(""));
		$("#erDai").append($("<option>").text("--请选择四级目录--").val(""));

		document.getElementById("erDili").disabled = true;
		document.getElementById("erQuan").disabled = true;
		document.getElementById("erJie").disabled = true;
		document.getElementById("erDai").disabled = true;

	} else if (level == 1) {
		$("#erDili").empty();
		$("#erQuan").empty();
		$("#erJie").empty();
		$("#erDai").empty();
		
		$("#erDili").append($("<option>").text("--请选择一级目录--").val(""));
		$("#erQuan").append($("<option>").text("--请选择二级分类--").val(""));
		$("#erJie").append($("<option>").text("--请选择三级目录--").val(""));
		$("#erDai").append($("<option>").text("--请选择四级目录--").val(""));
		
		document.getElementById("erQuan").disabled = true;

		document.getElementById("erJie").disabled = true;
		document.getElementById("erDai").disabled = true;

	} else if (level == 2) {
		$("#erQuan").empty();
		$("#erJie").empty();
		$("#erDai").empty();
		
		$("#erQuan").append($("<option>").text("--请选择二级分类--").val(""));
		$("#erJie").append($("<option>").text("--请选择三级目录--").val(""));
		$("#erDai").append($("<option>").text("--请选择四级目录--").val(""));
		
		document.getElementById("erJie").disabled = true;
		document.getElementById("erDai").disabled = true;

	} else if (level == 3) {
		$("#erJie").empty();
		$("#erDai").empty();
		
		$("#erJie").append($("<option>").text("--请选择三级目录--").val(""));
		$("#erDai").append($("<option>").text("--请选择四级目录--").val(""));
		

		document.getElementById("erDai").disabled = true;

	} else if (level == 4) {
		$("#erDai").empty();

		$("#erDai").append($("<option>").text("--请选择四级目录--").val(""));

	}
	$
			.ajax({
				url : 'ajaxAction.action?code=003006008&paramMap.id='
						+ parentID,
				type : 'post',
				timeout : '60000',
				data : Array(),
				dataType : 'json',
				beforeSend : function(request) {
				},// ajax执行前调用函数
				complete : function(request, textStatus) {
				},// ajax请求完成后调用函数
				success : function(jsonData, textStatus) {// ajax请求成功调用函数
					var cateList = new Array(); 
					if (textStatus == "success" && jsonData.data) {
						if (jsonData.data.length > 0 && level != 5) {
							jrinitData = jsonData.data;
							$("#resInfo").html("");
							for (var i = 0; i < jsonData.data.length; i++) {
								var optVal = jsonData.data[i].cateID;
								var optText = jsonData.data[i].cateName;
								var optPath = jsonData.data[i].catePath;
								var cateSign = jsonData.data[i].cateSign;
								var optPathId = jsonData.data[i].cateID;
								if(optText=='专题研读室' || optText=='教学研究室' || optText=='影像资料室' || optText=='自主探究室' || optText=='人文地理' || optText=='区域地理' || optText=='灾害地理' || optText=='地球与地图'  || optText=='大气圈'  || optText=='水圈' || optText=='岩石圈'){
									continue;
								}
								if (optVal != '' && optText != '') {
									var option = $(
											'<option cateSign=' + cateSign
													+ ' path=' + optPath
													+ ' optPathId=' + optPathId
													+ '></option>').text(
											optText).val(optVal);
									if (level == 0) {
										$("#erShi").append(option);
									} else if (level == 1) {
										if(optPathId!='4'){
											$("#erDili").append(option);
										}
									} else if (level == 2) {
										$("#erQuan").append(option);
									} else if (level == 3) {
										$("#erJie").append(option);
									} else if (level == 4) {
										$("#erDai").append(option);
									}
								}
							}
							if (level == 1) {
								document.getElementById("erDili").disabled = false;
								document.getElementById("erQuan").disabled = true;

							} else if (level == 2) {
								document.getElementById("erQuan").disabled = false;

							} else if (level == 3) {
								document.getElementById("erJie").disabled = false;

							} else if (level == 4) {
								document.getElementById("erDai").disabled = false;

							}
						} else {
							
							var href ="";
							res = $("#cateSign").val();
							var pathID = 0;
							var path = 0;
							if (level == 1) {
								var erShiValue = document
										.getElementById("erQuan");
								pathID = $(
										erShiValue.options[$(
												"#erShi option:selected")
												.index()]).attr("optPathId");
								path = $(
										erShiValue.options[$(
												"#erShi option:selected")
												.index()]).attr("path");

							} else if (level == 2) {
								var erDiliValue = document
										.getElementById("erDili");
								pathID = $(
										erDiliValue.options[$(
												"#erDili option:selected")
												.index()]).attr("optPathId");
								path = $(
										erDiliValue.options[$(
												"#erDili option:selected")
												.index()]).attr("path");

							} else if (level == 3) {
								
								
								var erQuanValue = document.getElementById("erQuan");
									pathID = $(
											erQuanValue.options[$(
													"#erQuan option:selected")
													.index()]).attr("optPathId");
									path = $(
											erQuanValue.options[$(
													"#erQuan option:selected")
													.index()]).attr("path");
									
								
									var erQuanValue = document.getElementById("erQuan");
			
								
									var erQuanID = $(
											erQuanValue.options[$(
													"#erQuan option:selected").index()])
											.attr("optpathid");
							
									href = 'ajaxAction.action?code=' + -2110
											+ '&paramMap.path=' + path
											+ '&paramMap.cateID=' + pathID
											+ '&paramMap.erJieID=' + erQuanID
											+ '&paramMap.start1=0&paramMap.cateSign=exhibition&paramMap.pageSize=8&currentDate=' 
											+ new Date().getTime();
							} else if (level == 4) {
															
									var erJieValue = document.getElementById("erJie");
									pathID = $(
											erJieValue.options[$(
													"#erJie option:selected")
													.index()]).attr("optPathId");
									path = $(
											erJieValue.options[$(
													"#erJie option:selected")
													.index()]).attr("path");
									
								
									var erJieValue = document.getElementById("erJie");
			
								
									var erJieID = $(
											erJieValue.options[$(
													"#erJie option:selected").index()])
											.attr("optpathid");
							
									href = 'ajaxAction.action?code=' + -2110
											+ '&paramMap.path=' + path
											+ '&paramMap.cateID=' + pathID
											+ '&paramMap.erSecoID=' + erJieID
											+ '&paramMap.start1=0&paramMap.cateSign=exhibition&paramMap.pageSize=8&currentDate=' 
											+ new Date().getTime();


							} else if (level == 5) {
								var erDaiValue = document
										.getElementById("erDai");
								pathID = $(
										erDaiValue.options[$(
												"#erDai option:selected")
												.index()]).attr("optPathId");
								path = $(
										erDaiValue.options[$(
												"#erDai option:selected")
												.index()]).attr("path");
								
							
								var erDaiValue = document.getElementById("erDai");

							
								var erDaiID = $(
										erDaiValue.options[$(
												"#erDai option:selected").index()])
										.attr("optpathid");
						
								href = 'ajaxAction.action?code=' + -2110
										+ '&paramMap.path=' + path
										+ '&paramMap.cateID=' + pathID
										+ '&paramMap.erGangID=' + erDaiID
										+ '&paramMap.start1=0&paramMap.cateSign=exhibition&paramMap.pageSize=8&currentDate=' 
										+ new Date().getTime();
							}
						
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
				    							var JsonDataCount = jsonData.data[jsonData.data.length-1].count;//获取到了总数	
				    							   $("#count").val(JsonDataCount);
				    							  var Items="<ul>";
				        						   for (var i=0; i<jsonData.data.length-1;i++){	
				        							   var di = jsonData.data[i].thumbnail;
														Items +="<li><a href='#' path='"+jsonData.data[i].path+"' onclick='showMap("+jsonData.data[i].id+",this)'><img  src='"
														+jsonData.data[i].thumbnail+"' width='80' height='80' title='"+jsonData.data[i].name+"'/><p class='pName'>"+jsonData.data[i].name+"</p></a></li>" ;
														
				        						   }
				        						   Items +="</ul>";
				        						   $("#resInfo").empty().append(Items);				        						   
				        						   $("#start").val(8);		
				        					}		
				    		    		 }
				        			},
				        			
				        			error:function(request,textStatus,error){}
				        		});							
							
						}
					}

				},
				// ajax请求错误后调用函数
				error : function(request, textStatus, error) {
				}
			});
}
function attr(y) {
	var reg = /^\s+$/;
	return (typeof y != 'undefined' && y != '' && y != null && !reg.test(y) && y != 'null');
}