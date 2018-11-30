$(document).ready(function() {
	var t = $("#windowwidth",parent.document).val()-273-5-97-80; 
	$("img").each(function(){
   		if($(this).width()>t){
   			$(this).LoadImage(true,t);
   		}
 	});
});
jQuery.fn.LoadImage = function(scaling, width) {
	return this.each(function() {
		var t = $(this);
		var src = $(this).attr("src");
		var img = new Image();
		img.src = src;
		var autoScaling = function() {
			if (scaling) {
				if (img.width > 0) {
					t.width(width);
					t.height((img.height * width) / img.width);
				}
			}
		};
		
		if (img.complete) {
			autoScaling();
			return;
		}
		$(this).attr("src", "");
		var loading = $("<img alt=\"加载中\" title=\"图片加载中\" src=\"\" />");
		t.hide();
		t.after(loading);
		$(img).load(function() {
			autoScaling();
			loading.remove();
			t.attr("src", this.src);
			t.show();
		});
	});
};