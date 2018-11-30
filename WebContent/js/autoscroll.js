jQuery.fn.LoadImage = function(scaling, height, loadpic,flag) {
	if (loadpic == null)
		loadpic = "load3.gif";
	return this.each(function() {
		var t = $(this);
		var src = $(this).attr("src");
		var img = new Image();
		// alert("Loading")
		img.src = src;
		// 自动缩放图片
		var autoScaling = function() {
			if (scaling) {
				if (img.width > 0 && img.height > 0) {					
					t.width(img.width/(img.height/height));					
				}
				
				if(flag){	
					$("#textPdown"+loadpic).width(t.width()-1);						
				}else{//如果flag为假，标识使用id值获取不到数据
					$(".textPdown").eq(loadpic).width(t.width()-1);
					
				}	
				if(window.screen.width<=1024){
					if(t.width()>=150){
						$("#textPdown"+loadpic).width(150-1);		
					}
					
				}else{
					if(t.width()>=200){
						$("#textPdown"+loadpic).width(200-1);		
					}
				}
				
			}
		};
		
		// 处理ff下会自动读取缓存图片
		if (img.complete) {
			// alert("getToCache!");
			autoScaling();
			return;
		}
	
		$(img).load(function() {
			autoScaling();
		});

	});
}