
var startTime;
$(document).ready(function () {
	$("#BtnOk").click(function () {
		var r_File = $("#uploadBigFile").val() ;
		if(r_File!=""){
			var myDate = new Date();
			startTime = myDate.getTime();
			$("#uploadForm").submit();
			window.setTimeout("getProgressBar()", 1000);
		}else{
			alert("请选择资源文件");
		}
	});
});
function getProgressBar() {
	var timestamp = (new Date()).valueOf();
	var bytesReadToShow = 0;
	var contentLengthToShow = 0;
	var bytesReadGtMB = 0;
	var contentLengthGtMB = 0;
	$.getJSON("././uploadFile/getBar/bar", {"t":timestamp}, function (json) {
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
			//上传完成
			window.clearTimeout(interval);
			$("#actionForm").submit();
		} else {
			var pastTimeBySec = (new Date().getTime() - startTime) / 1000;
			var sp = (bytesRead / pastTimeBySec).toString();
			var speed = sp.substring(0, sp.lastIndexOf(".") + 3);
			var percent = Math.floor((bytesRead / contentLength) * 100) + "%";
		}
	});
	var interval = window.setTimeout("getProgressBar()", 500);
}