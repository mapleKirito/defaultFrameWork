jQuery.fn.LoadImage = function(scaling, width, height) {
	return this.each(function() {
		var t = $(this);
		var src = $(this).attr("src");
		var img = new Image();
		img.src = src;
		var autoScaling = function() {
			if (scaling) {
				if (img.width > 0 && img.height > 0) {
					if (img.height > height) {
						t.height(height);
						if((img.width * height) / img.height < $("#windowwidth", parent.document).val()-285){
							t.width($("#windowwidth", parent.document).val()-285);
						}else{
							t.width((img.width * height) / img.height);
						}
						
					} else {
						t.width(img.width);
						t.height(img.height);
					}
				}
			}
		};
		if (img.complete) {
			autoScaling();
			return;
		}
		$(this).attr("src", "");
		var loading = $("<img alt=\"\" title=\"图片加载中\" src=\"\" />");
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

jQuery.fn.LoadImagex = function(scaling, width, height) {
	return this.each(function() {
		var t = $(this);
		var src = $(this).attr("src");
		var img = new Image();
		img.src = src;
		var autoScaling = function() {
			if (scaling) {
				if (img.width > 0 && img.height > 0) {
					if (img.height > height) {
						t.height(height);
							t.width((img.width * height) / img.height);
					} else {
						t.width(img.width);
						t.height(img.height);
					}
				}
			}
		};
		if (img.complete) {
			autoScaling();
			return;
		}
		$(this).attr("src", "");
		var loading = $("<img alt=\"\" title=\"图片加载中\" src=\"\" />");
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