
var startTime;

$(document).ready(function () {
	$(".subButton").click(function () {
		var r_File = $("#uploadBigFile").val() ;
		if(r_File!=""){
			var myDate = new Date();
			startTime = myDate.getTime();
			$(this).attr("disabled", true);
			$("#uploadForm").submit();
			$("#progress").show();
			window.setTimeout("getProgressBar()", 1000);
		}else{
			alert("请选择资源文件");
		}
	});
	$("#close").click(function(){$("#progress").hide();});
});
function getProgressBar() {
	var timestamp = (new Date()).valueOf();
	var bytesReadToShow = 0;
	var contentLengthToShow = 0;
	var bytesReadGtMB = 0;
	var contentLengthGtMB = 0;
	$.getJSON("./uploadFile/getBar/bar", {"t":timestamp}, function (json) {
		var bytesRead = (json.pBytesRead / 1024).toString();
		if (bytesRead > 1024) {
			bytesReadToShow = (bytesRead / 1024).toString();
			bytesReadGtMB = 1;
		}else{
			bytesReadToShow = bytesRead.toString();
		}
		var contentLength = (json.pContentLength / 1024).toString();
		if (contentLength > 1024) {
			contentLengthToShow = (contentLength / 1024).toString();
			contentLengthGtMB = 1;
		}else{
			contentLengthToShow= contentLength.toString();
		}
		bytesReadToShow = bytesReadToShow.substring(0, bytesReadToShow.lastIndexOf(".") + 3);
		contentLengthToShow = contentLengthToShow.substring(0, contentLengthToShow.lastIndexOf(".") + 3);
		if (bytesRead == contentLength) {
			$("#close").show();
			$("#isUpload").val("1");
			$("#uploaded").css("width", "427px");
			$("#uploaded").html("100%"); //显示百分比 
			if (contentLengthGtMB == 0) {
				$("div#info").html("\u4e0a\u4f20\u5b8c\u6210\uff01\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "KB.\u5b8c\u6210100%");
			} else {
				$("div#info").html("\u4e0a\u4f20\u5b8c\u6210\uff01\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "MB.\u5b8c\u6210100%");
			}
			window.clearTimeout(interval);
			$(".subButton").attr("disabled", false);
		} else {
			var pastTimeBySec = (new Date().getTime() - startTime) / 1000;
			var sp = (bytesRead / pastTimeBySec).toString();
			var speed = sp.substring(0, sp.lastIndexOf(".") + 3);
			var percent = Math.floor((bytesRead / contentLength) * 100) + "%";
			$("#uploaded").css("width", percent);
			$("#uploaded").html(percent); //显示百分比 
			if (bytesReadGtMB == 0 && contentLengthGtMB == 0) {
				$("div#info").html("\u4e0a\u4f20\u901f\u5ea6:" + speed + "KB/Sec,\u5df2\u7ecf\u8bfb\u53d6" + bytesReadToShow + "KB,\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "KB.\u5b8c\u6210" + percent);
			} else {
				if (bytesReadGtMB == 0 && contentLengthGtMB == 1) {
					$("div#info").html("\u4e0a\u4f20\u901f\u5ea6:" + speed + "KB/Sec,\u5df2\u7ecf\u8bfb\u53d6" + bytesReadToShow + "KB,\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "MB.\u5b8c\u6210" + percent);
				} else {
					if (bytesReadGtMB == 1 && contentLengthGtMB == 1) {
						$("div#info").html("\u4e0a\u4f20\u901f\u5ea6:" + speed + "KB/Sec,\u5df2\u7ecf\u8bfb\u53d6" + bytesReadToShow + "MB,\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "MB.\u5b8c\u6210" + percent);
					}
				}
			}
		}
	});
	var interval = window.setTimeout("getProgressBar()", 500);
}

