
var startTime;
$(document).ready(function () {
	$("#rsyncSubButton").click(function () {
		var r_File = $("#rsyncUploadBigFile").val() ;
		if(r_File!=""){
			var myDate = new Date();
			startTime = myDate.getTime();
			$(this).attr("disabled", true);
			$("#rsyncUploadForm").submit();
			$("#rsyncProgress").show();
			window.setTimeout("getRsyncProgressBar()", 1000);
		}else{
			alert("请选择资源文件");
		}
	});
	$("#rsyncClose").click(function(){$("#rsyncProgress").hide();});
});
function getRsyncProgressBar() {
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
			$("#rsyncClose").show();
			$("#rsyncUploaded").css("width", "427px");/*上传完成*/
			$("#rsyncUploaded").html("100%"); //显示百分比 
			if (contentLengthGtMB == 0) {
				$("div#rsyncInfo").html("\u4e0a\u4f20\u5b8c\u6210\uff01\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "KB.\u5b8c\u6210100%");
			} else {
				$("div#rsyncInfo").html("\u4e0a\u4f20\u5b8c\u6210\uff01\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "MB.\u5b8c\u6210100%");
			}
			window.clearTimeout(interval);
			$("#rsyncSubButton").attr("disabled", false);
		} else {
			var pastTimeBySec = (new Date().getTime() - startTime) / 1000;
			var sp = (bytesRead / pastTimeBySec).toString();
			var speed = sp.substring(0, sp.lastIndexOf(".") + 3);
			/*修改开始*/
			var percent = Math.floor((bytesRead / contentLength) * 100) + "%";
			$("#rsyncUploaded").css("width", percent);/*上传进度*/
			$("#rsyncUploaded").html(percent); //显示百分比 
			/*修改结束*/
			if (bytesReadGtMB == 0 && contentLengthGtMB == 0) {
				$("div#rsyncInfo").html("\u4e0a\u4f20\u901f\u5ea6:" + speed + "KB/Sec,\u5df2\u7ecf\u8bfb\u53d6" + bytesReadToShow + "KB,\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "KB.\u5b8c\u6210" + percent);
			} else {
				if (bytesReadGtMB == 0 && contentLengthGtMB == 1) {
					$("div#rsyncInfo").html("\u4e0a\u4f20\u901f\u5ea6:" + speed + "KB/Sec,\u5df2\u7ecf\u8bfb\u53d6" + bytesReadToShow + "KB,\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "MB.\u5b8c\u6210" + percent);
				} else {
					if (bytesReadGtMB == 1 && contentLengthGtMB == 1) {
						$("div#rsyncInfo").html("\u4e0a\u4f20\u901f\u5ea6:" + speed + "KB/Sec,\u5df2\u7ecf\u8bfb\u53d6" + bytesReadToShow + "MB,\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "MB.\u5b8c\u6210" + percent);
					}
				}
			}
		}
	});
	var interval = window.setTimeout("getRsyncProgressBar()", 500);
}

