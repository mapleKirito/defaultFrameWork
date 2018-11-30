$(document).ready(function() {
	$.ajax({
		url: 'ModuleStatesServlet/Module?no=index',
		type: 'post',
		timeout: '60000',
		data: Array(),
		dataType: 'json',
		beforeSend: function(request) {},
		complete: function(request, textStatus) {},
		success: function(jsonData, textStatus) {
			if (textStatus == "success") {
				
				if (jsonData.key == 1 || jsonData.key == 2) {
					window.location.href = '/dm/SmartServerRemoteRequest.jsp';
				}else if (jsonData.key == 4) {
					window.location.href = '/dmangetime.jsp';
				}else if (jsonData.key == 3) {
					window.location.href = '/dm/overclick.jsp';
				}else if (jsonData.key == 5) {
					window.location.href = '/dm/overtime.jsp';
				}else if (jsonData.key == 6) {
					window.location.href = '/dm/overchange.jsp'; //硬件改动
				}
			}
		},
		error: function(request, textStatus, error) {}
	});
});