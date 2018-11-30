(function($){
	$.fn.kkPages = function(options){		
		var opts = $.extend({},$.fn.kkPages.defaults, options);
		return this.each(function(){	  			
			var $this = $(this);
			var $PagesClass = opts.PagesClass; // 分页元素
			/*var $AllMth = $this.find($PagesClass).length;  //总个数*/	
			var $AllMth = opts.PageCount;//改变之后的计算总个数的方法
			var $Mth = opts.PagesMth; //每页显示个数
			var $NavMth = opts.PagesNavMth; // 导航显示个数			
			var $Index = opts.Pageindex; // 当前循环遍历出的第几个，标注，因为计算向数据库 查询的start值和end值的
			var path = opts.path;//获取路径信息
			var perEnd = opts.PageCountX;//获取最后一页的时候的总数
			var pathID = opts.pathID;	
			var CountS = opts.Count;
			// 定义分页导航
			var PagesNavHtml = "<div class=\"Pagination\"><a href=\"javascript:;\" class=\"homePage\">首页</a><a href=\"javascript:;\" class=\"PagePrev\">上一页</a><span class=\"Ellipsis\"><b>...</b></span><div class=\"pagesnum\"></div><span class=\"Ellipsis\"><b>...</b></span><a href=\"javascript:;\" class=\"PageNext\">下一页</a><a href=\"javascript:;\" class=\"lastPage\">尾页</a><cite class=\"FormNum\">直接到第<input type=\"text\" name=\"PageNum\" id=\"PageNum\">页</cite><a href=\"javascript:;\" class=\"PageNumOK\">确定</a></div>";
			var PerSpace = 80+($Index*(perEnd-4));//记录每个球负责的区域的以及点击的每个值域
			
			/*默认初始化显示*/			
			if($AllMth > $Mth){					
					//判断显示
					var relMth = $Mth - 1;
					$this.find($PagesClass).filter(":gt("+relMth+")").hide();
					// 计算数量,页数
					var PagesMth = Math.ceil($AllMth / $Mth); // 计算页数
					var PagesMthTxt = "<span>共<b>"+$AllMth+"</b>条，共<b>"+PagesMth+"</b>页</span>";
					$this.append(PagesNavHtml).find(".Pagination").append(PagesMthTxt);				
					
					// 计算分页导航显示数量						
						var PagesNavNum = "";
						for(var i=1;i<=PagesMth;i++){							
							PagesNavNum = PagesNavNum + "<a href=\"javascript:;\">"+i+"</a>";					
						};						
						$this.find(".pagesnum").append(PagesNavNum).find("a:first").addClass("PageCur");					
					//判断是否显示省略号
					if($NavMth < PagesMth){							
							$this.find("span.Ellipsis:last").show();
							var relNavMth = $NavMth - 1;
							$this.find(".pagesnum a").filter(":gt("+relNavMth+")").hide();							
						}else{						
								$this.find("span.Ellipsis:last").hide();
							};					
					
				/*默认显示已完成,下面是控制区域代码*/			
				
				//跳转页面
				var $input = $this.find(".Pagination #PageNum");
				var $submit = $this.find(".Pagination .PageNumOK");
				
				//跳转页面文本框
				$input.keyup(function(){					
						var pattern_d = /^\d+$/; //全数字正则						
						if(!pattern_d.exec($input.val())) {                    		 	
							alert("友情提示：\n\n请填写正确的数字！");
							$input.focus().val("");
							return false;							
                		};						
					});
				
				//跳转页面确定按钮
				$submit.click(function(){
						if($input.val() == ""){							
							alert("友情提示：\n\n请填写您要跳转到第几页！");
							$input.focus().val("");
							return false;							
							}if($input.val() > PagesMth){								
								alert("友情提示：\n\n您跳转的页面不存在！");
								$input.focus().val("");
								return false;								
								}else{
									//判断所有记录是否大于20条
									if(CountS<20){
										showPages($input.val());
									}else{
										var ItemLength = $(".wrap  .pagelist").find(".item").length;
										if(ItemLength>=$input.val()*4){
											showPages($input.val());
										}else{
											var startNum = PerSpace+ItemLength;
											var endNum = 4;
											//还要判断一个，就是直接点的
											//就是判断最后一页的endnum要修改，，因为他可能不是完整的一页，需要将最后的一个参数进行修改
											var gapLength = ($input.val()-1)*4-$AllMth;	//此处考虑到最后一页的情况，因为有可能不够4条数据						
											if(gapLength>-4){
												startNum = PerSpace+ItemLength;
												endNum = $AllMth-($input.val()-1)*4;
											}
											//如何当前的图片个数，小于了要跳转的页面之前该有的个数，就该让这个endNum的值延长至要要跳转的页面的个数
											//需要的个数大于4，，
											var MustIterm = $input.val()*4-ItemLength;
											if(MustIterm>0){
												//先拿，需要的总数是否大于了所管理的范围
												if($input.val()*4<$AllMth){
													endNum = MustIterm;
												}else{
													endNum = $AllMth-ItemLength;
												}
												
											}
											var Items= "";
											$.ajax({
												url:		'ajaxAction.action?code=-2019&path='+path+'&paramMap.erProvince='+pathID+'&paramMap.erCity='+pathID+'&type=1&paramMap.startNum='+startNum+'&paramMap.endNum='+endNum+'&currentDate='+new Date().getTime(),
												type:	    'post',
												timeout:	'60000',
												data:	Array(),
												dataType:	'json',
												beforeSend:function(request){},
												complete:function(request,textStatus){},
												success:function(jsonData,textStatus){							
													if (jsonData.data.length > 0){	
										
														for (var i=0; i<jsonData.data.length-1;i++){										
															Items+="<div class='item'>"+
																"<a  href='#'  onclick='clickMap(this)'   hrefT='&path="+jsonData.data[i].area_path+"&paramMap.erType=1011&paramMap.fileType=1011&paramMap.erID="+jsonData.data[i].erID+"&paramMap.erGangID="+jsonData.data[i].erGangID+"&paramMap.st=1&paramMap.temppname=erID&paramMap.temppid="+jsonData.data[i].erID+"&paramMap.name="+jsonData.data[i].erName+"&paramMap.cateSign=exhibition&paramMap.roomtype=exhibition&paramMap.map=map'>"+
																"<img style=''  src='"+jsonData.data[i].erThumbnail+"' width='100' height='80' title='"+jsonData.data[i].erName+"'/></a></div>" ;
														}
														$(".Pagination").before(Items);
														showPages($input.val());
													  }
													},	
													error:function(request,textStatus,error){}
												});			
										}
									}
													
							  };
					
					});			
				
				//导航控制分页
				var $PagesNav = $this.find(".pagesnum a"); //导航指向
				var $PagesFrist = $this.find(".homePage"); //首页
				var $PagesLast = $this.find(".lastPage"); //尾页
				var $PagesPrev = $this.find(".PagePrev"); //上一页
				var $PagesNext = $this.find(".PageNext"); //下一页
				
				//导航指向
				$PagesNav.click(function(){		
					var NavTxt = $(this).text();	
					var ItemLength = $(".wrap  .pagelist").find(".item").length;
						//判断所有记录是否大于20条
					if(CountS<20){
						showPages(NavTxt);
					}else{
						if(ItemLength>=NavTxt*4){
							showPages(NavTxt);
						}else{
							//当前有几个图片
							var startNum = PerSpace+ItemLength;
							var endNum = 4;
							//还要判断一个，就是直接点的
							//就是判断最后一页的endnum要修改，，因为他可能不是完整的一页，需要将最后的一个参数进行修改
							
							var gapLength = (NavTxt-1)*4-$AllMth;							
							if(gapLength>-4){
								startNum = PerSpace+ItemLength;
								endNum = $AllMth-(NavTxt-1)*4;
							}
							//如何当前的图片个数，小于了要跳转的页面之前该有的个数，就该让这个endNum的值延长至要要跳转的页面的个数
							//需要的个数大于4，，
							var MustIterm = NavTxt*4-ItemLength;
							if(MustIterm>0){
								//先拿，需要的总数是否大于了所管理的范围
								if(NavTxt*4<$AllMth){
									endNum = MustIterm;
								}else{
									endNum = $AllMth-ItemLength;
								}
								
							}
							var Items= "";
							$.ajax({
								url:		'ajaxAction.action?code=-2019&path='+path+'&paramMap.erProvince='+pathID+'&paramMap.erCity='+pathID+'&type=1&paramMap.startNum='+startNum+'&paramMap.endNum='+endNum+'&currentDate='+new Date().getTime(),
								type:	    'post',
								timeout:	'60000',
								data:	Array(),
								dataType:	'json',
								beforeSend:function(request){},
								complete:function(request,textStatus){},
								success:function(jsonData,textStatus){							
									if (jsonData.data.length > 0){	
										for (var i=0; i<jsonData.data.length-1;i++){
											
											Items+="<div class='item'>"+
												"<a href='#'  onclick='clickMap(this)'   hrefT='&path="+jsonData.data[i].area_path+"&paramMap.erType=1011&paramMap.fileType=1011&paramMap.erID="+jsonData.data[i].erID+"&paramMap.erGangID="+jsonData.data[i].erGangID+"&paramMap.st=1&paramMap.temppname=erID&paramMap.temppid="+jsonData.data[i].erID+"&paramMap.name="+jsonData.data[i].erName+"&paramMap.cateSign=exhibition&paramMap.roomtype=exhibition&paramMap.map=map'>"+
												"<img style=''  src='"+jsonData.data[i].erThumbnail+"' width='100' height='80' title='"+jsonData.data[i].erName+"'/></a></div>" ;
										}
										$(".Pagination").before(Items);
										showPages(NavTxt);
									  }
									},	
									error:function(request,textStatus,error){}
								});	
							}
					  }
				//导航指向结束		
				 });
								
				//首页
				$PagesFrist.click(function(){					
						showPages(1);					
					});
					
				//尾页
				$PagesLast.click(function(){
				var ItemLength = $(".wrap  .pagelist").find(".item").length;
					
					//判断是否大于20条记录
					if(CountS<20){
						showPages(PagesMth);
					}else{
						//判断是否执行ajax。是否添加数据
						if(ItemLength>=PagesMth*4){
							showPages(PagesMth);
						}else{
							var startNum = PerSpace+ItemLength;
							var endNum = 4;
							
							//还要判断一个，就是直接点的
							//就是判断最后一页的endnum要修改，，因为他可能不是完整的一页，需要将最后的一个参数进行修改
							
							var gapLength = (PagesMth-1)*4-$AllMth;							
							if(gapLength>-4){
								startNum = PerSpace+ItemLength;
								endNum = $AllMth-(PagesMth-1)*4;
							}
							//如何当前的图片个数，小于了要跳转的页面之前该有的个数，就该让这个endNum的值延长至要要跳转的页面的个数
							//需要的个数大于4，，
							var MustIterm = PagesMth*4-ItemLength;
							if(MustIterm>0){
								//先拿，需要的总数是否大于了所管理的范围
								if(PagesMth*4<$AllMth){
									endNum = MustIterm;
								}else{
									endNum = $AllMth-ItemLength;
								}
								
							}
						
							var Items= "";
							$.ajax({
								url:		'ajaxAction.action?code=-2019&path='+path+'&paramMap.erProvince='+pathID+'&paramMap.erCity='+pathID+'&type=1&paramMap.startNum='+startNum+'&paramMap.endNum='+endNum+'&currentDate='+new Date().getTime(),
								type:	    'post',
								timeout:	'60000',
								data:	Array(),
								dataType:	'json',
								beforeSend:function(request){},
								complete:function(request,textStatus){},
								success:function(jsonData,textStatus){							
									if (jsonData.data.length > 0){										
										for (var i=0; i<jsonData.data.length-1;i++){										
											Items+="<div class='item'>"+
												"<a href='#'  onclick='clickMap(this)'   hrefT='&path="+jsonData.data[i].area_path+"&paramMap.erType=1011&paramMap.fileType=1011&paramMap.erID="+jsonData.data[i].erID+"&paramMap.erGangID="+jsonData.data[i].erGangID+"&paramMap.st=1&paramMap.temppname=erID&paramMap.temppid="+jsonData.data[i].erID+"&paramMap.name="+jsonData.data[i].erName+"&paramMap.cateSign=exhibition&paramMap.roomtype=exhibition&paramMap.map=map'>"+
												"<img style=''  src='"+jsonData.data[i].erThumbnail+"' width='100' height='80' title='"+jsonData.data[i].erName+"'/></a></div>" ;
										}
										$(".Pagination").before(Items);
										showPages(PagesMth);
									  }
									},	
									error:function(request,textStatus,error){}
								});
						}	
					}
				});
					
				//上一页
				$PagesPrev.click(function(){
					var OldNav = $this.find(".pagesnum a[class=PageCur]");							
					if(OldNav.text() == 1){alert("友情提示：\n\n不要再点啦~已经是首页啦！");}else{									
						var NavTxt = parseInt(OldNav.text()) - 1;
						//判断是否大于20条记录
						if(CountS<20){
							showPages(NavTxt);
						}else{
							var ItemLength = $(".wrap  .pagelist").find(".item").length;
							if(ItemLength>=NavTxt*4){
								showPages(NavTxt);
							}else{
								var startNum = PerSpace+(NavTxt-1)*$Mth;
								var endNum = 4;
								//还要判断一个，就是直接点的
								//就是判断最后一页的endnum要修改，，因为他可能不是完整的一页，需要将最后的一个参数进行修改
								
								var gapLength = (NavTxt-1)*4-$AllMth;							
								if(gapLength>-4){
									startNum = PerSpace+(NavTxt-1)*$Mth;
									endNum = $AllMth-(NavTxt-1)*4;
								}
								//如何当前的图片个数，小于了要跳转的页面之前该有的个数，就该让这个endNum的值延长至要要跳转的页面的个数
								//需要的个数大于4，，
								var MustIterm = NavTxt*4-ItemLength;
								if(MustIterm>0){
									//先拿，需要的总数是否大于了所管理的范围
									if(NavTxt*4<$AllMth){
										endNum = MustIterm;
									}else{
										endNum = $AllMth-ItemLength;
									}
									
								}
								var Items= "";
								$.ajax({
									url:		'ajaxAction.action?code=-2019&path='+path+'&paramMap.erProvince='+pathID+'&paramMap.erCity='+pathID+'&type=1&paramMap.startNum='+startNum+'&paramMap.endNum='+endNum+'&currentDate='+new Date().getTime(),
									type:	    'post',
									timeout:	'60000',
									data:	Array(),
									dataType:	'json',
									beforeSend:function(request){},
									complete:function(request,textStatus){},
									success:function(jsonData,textStatus){							
										if (jsonData.data.length > 0){										
											for (var i=0; i<jsonData.data.length-1;i++){										
												Items+="<div class='item'>"+
													"<a href='#'  onclick='clickMap(this)'   hrefT='&path="+jsonData.data[i].area_path+"&paramMap.erType=1011&paramMap.fileType=1011&paramMap.erID="+jsonData.data[i].erID+"&paramMap.erGangID="+jsonData.data[i].erGangID+"&paramMap.st=1&paramMap.temppname=erID&paramMap.temppid="+jsonData.data[i].erID+"&paramMap.name="+jsonData.data[i].erName+"&paramMap.cateSign=exhibition&paramMap.roomtype=exhibition&paramMap.map=map'>"+
													"<img style=''  src='"+jsonData.data[i].erThumbnail+"' width='100' height='80' title='"+jsonData.data[i].erName+"'/></a></div>" ;
											}
											$(".Pagination").before(Items);
											showPages(NavTxt);
										  }
										},	
										error:function(request,textStatus,error){}
									});		
								}
							}
						};				
					});
					
				//下一页
				$PagesNext.click(function(){
					var OldNav = $this.find(".pagesnum a[class=PageCur]");	
					if(OldNav.text() == PagesMth){alert("友情提示：\n\n不要再点啦~已经是最后一页啦！");}else{									
					var NavTxt = parseInt(OldNav.text()) + 1;
					//判断是否大于20条记录
					if(CountS<20){
						showPages(NavTxt);
					}else{
						var ItemLength = $(".wrap  .pagelist").find(".item").length;
						if(ItemLength>=NavTxt*4){
							showPages(NavTxt);
						}else{
							var startNum = PerSpace+(NavTxt-1)*$Mth;
							var endNum = 4;
							//还要判断一个，就是直接点的
							//就是判断最后一页的endnum要修改，，因为他可能不是完整的一页，需要将最后的一个参数进行修改
							
							var gapLength = (NavTxt-1)*4-$AllMth;							
							if(gapLength>-4){
								startNum = PerSpace+(NavTxt-1)*$Mth;
								endNum = $AllMth-(NavTxt-1)*4;
							}
							
							//如何当前的图片个数，小于了要跳转的页面之前该有的个数，就该让这个endNum的值延长至要要跳转的页面的个数
							//需要的个数大于4，，							
							var Items= "";
							$.ajax({
								url:		'ajaxAction.action?code=-2019&path='+path+'&paramMap.erProvince='+pathID+'&paramMap.erCity='+pathID+'&type=1&paramMap.startNum='+startNum+'&paramMap.endNum='+endNum+'&currentDate='+new Date().getTime(),
								type:	    'post',
								timeout:	'60000',
								data:	Array(),
								dataType:	'json',
								beforeSend:function(request){},
								complete:function(request,textStatus){},
								success:function(jsonData,textStatus){							
									if (jsonData.data.length > 0){										
										for (var i=0; i<jsonData.data.length-1;i++){										
											Items+="<div class='item'>"+
												"<a href='#'  onclick='clickMap(this)'   hrefT='&path="+jsonData.data[i].area_path+"&paramMap.erType=1011&paramMap.fileType=1011&paramMap.erID="+jsonData.data[i].erID+"&paramMap.erGangID="+jsonData.data[i].erGangID+"&paramMap.st=1&paramMap.temppname=erID&paramMap.temppid="+jsonData.data[i].erID+"&paramMap.name="+jsonData.data[i].erName+"&paramMap.cateSign=exhibition&paramMap.roomtype=exhibition&paramMap.map=map'>"+
												"<img style=''  src='"+jsonData.data[i].erThumbnail+"' width='100' height='80' title='"+jsonData.data[i].erName+"'/></a></div>" ;
										}
										$(".Pagination").before(Items);
										showPages(NavTxt);
									  }
									},	
									error:function(request,textStatus,error){}
								});	
							}
						}
					};					
			});
			
			// 主体显示隐藏分页函数
			function showPages(page){
					$PagesNav.each(function(){
						var NavText = $(this).text();						
						if(NavText == page){					
							$(this).addClass("PageCur").siblings().removeClass("PageCur");				
						};
					});
				
				//显示导航样式
				var AllMth = PagesMth / $NavMth;
				for(var i=1;i<=AllMth;i++){					
						if(page > (i*$NavMth)){							
							$PagesNav.filter(":gt("+(i*$NavMth-1)+")").show();
							$PagesNav.filter(":gt("+(i*$NavMth-1+$NavMth)+")").hide();
							$PagesNav.filter(":lt("+(i*$NavMth)+")").hide();								
							$this.find("span.Ellipsis:first").show();							
						};
						if(page <= $NavMth){							
							$PagesNav.filter(":gt("+($NavMth-1)+")").hide();
							$PagesNav.filter(":lt("+$NavMth+")").show();								
							$this.find("span.Ellipsis:first").hide();								
						};
				};					
					//隐藏掉后面省略号
					var PageShowMth = $PagesNav.filter(":last").css("display");

					if(PageShowMth == "block"){						
							$this.find("span.Ellipsis:last").hide();						
						}else{$this.find("span.Ellipsis:last").show();}				
					
					// 显示内容区域
					var LeftPage = $Mth * (page-1);
					var NowPage = $Mth * page;				
					$this.find($PagesClass).hide();
					$this.find($PagesClass).filter(":lt("+(NowPage)+")").show();
					$this.find($PagesClass).filter(":lt("+(LeftPage)+")").hide();					
				};				
			}; //判断结束		
				
		}); //主体代码
	};
	
	// 默认参数
	$.fn.kkPages.defaults = {		
		PagesClass:'.item', //需要分页的元素
		PagesMth:4, //每页显示个数		
		PagesNavMth:5 //显示导航个数
	};	
	$.fn.kkPages.setDefaults = function(settings) {
		$.extend( $.fn.kkPages.defaults, settings );
	};	
})(jQuery);