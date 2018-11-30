$(function(){
		   //点击页面其他地方隐藏moreList
		   $("body").click(function(event){
				if($(event.target).attr("id") != "moreList" && $(event.target).attr("id") != "moreTabBtn" && $(event.target).attr("id") != "tabClose"){
					if($(event.target).parent().parent().parent().attr("id") != "moreList"){
						$("#moreList").hide();
						$("#moreTabBtn").removeClass("onMore");
						$("#moreTabBtn").removeClass("downMore");
					}
				}
			 });
		   //显示隐藏moreList
			$(".moreTabBtn").hover(function(){
						$(this).addClass("onMore");
					},function(){
						if($(".moreList").css("display") == "none"){
							$(this).removeClass("onMore");
						}
				}).click(function(){
					if($(".moreList").css("display") == "none"){
						$(".moreList").show();
						$(this).addClass("downMore");
					}else{
						$(".moreList").hide();
						$(this).removeClass("downMore");
					}
			});
			//tabClose鼠标停留、离开效果及删除
			$(".tabClose").mouseover(function(){
				$(this).addClass("tabShut");
				}).mouseout(function(){
					$(this).removeClass("tabShut");
				}).click(function(){
					$(this).parent().remove(); 
			});
			//moreList > ul >li 鼠标经过改变背景色
			$("#moreList > ul >li").hover(function(){
												   		$(this).addClass("on");
												   },function(){
														$(this).removeClass("on")
			});
			//列表缩略图切换
			$("#qh").toggle(function(){
									 $(this).attr("src","images/main/ima_29.jpg")
									 $(".table_2").hide();
									 $(".table_3").show();
									 },function(){
										 $(this).attr("src","images/main/ima_30.jpg")
										 $(".table_2").show();
										 $(".table_3").hide();
			});

//这里是最新添加的JS
			//移动
			$(".yd").css("cursor","pointer");
			$(".yd").click(function(){
									$(this).parent().parent().parent().siblings().find(".yidong").hide().end().find(".yd").attr("src","images/main/bg_3.png");
									if($(this).parent().next().css("display") == "none"){
											$(this).parent().next().show().end().children().attr("src","images/main/bg_2.png");
										}else{
											$(this).parent().next().hide().end().children().attr("src","images/main/bg_3.png");
											}
										return false;
			})
			$(document).bind('click', function(e) {
                								var $clicked = $(e.target);
												var $parent = $clicked.closest("td");
												//console.log($parent);
                								if (! ($clicked.hasClass("yd") ||  $parent.find("div").hasClass("yidong")) ){
                									$(".yidong").hide();
													$(".yd").attr("src","images/main/bg_3.png");
													return false;	
                								}
            });

//
			$(function(){
				var $div_li =$(".teacherTab li");
				$div_li.click(function(){
					$(this).addClass("curr")            //当前<li>元素高亮
						   .siblings().removeClass("curr");  //去掉其它同辈<li>元素的高亮
					var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
					$(".table_9")   	//选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
							.eq(index).show()   //显示 <li>元素对应的<div>元素
							.siblings().hide(); //隐藏其它几个同辈的<div>元素
				})
			})
})