<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<style>
body {
	background: rgb(187, 171, 155);
	background-position: center;
}
</style>
</head>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

function getRemoteRequest() {
	document.getElementById("request").value = "";
	$.ajax({
		
		url : 'RemoteRequestServlet/Remote',
		
		type : 'post',
		
		timeout : '60000',
		
		data : Array(),
		
		dataType : 'json',
		
		beforeSend : function(request) {
		},
		
		complete : function(request, textStatus) {
		},
		
		success : function(jsonData, textStatus) {
			
			
			if (textStatus == "success") {
				document.getElementById("request").value = jsonData.s;
			}
		},
		
		error : function(request, textStatus, error) {
		}
	});
}
function setRemoteResponse() {
	var RemoteResponse = document.getElementById("response").value;
	if ("" == RemoteResponse) {
		alert("请输入修改码");
		return false;
	}
	$.ajax({
		
		url : 'RemoteRequestServlet/Remote?RemoteResponse='+ encodeURIComponent(RemoteResponse),
		
		type : 'post',
		
		timeout : '60000',
		
		data : Array(),
		
		dataType : 'json',
		
		beforeSend : function(request) {
		},
		
		complete : function(request, textStatus) {
		},
		
		success : function(jsonData, textStatus) {
			
			
			if (textStatus == "success") {
				if (jsonData.s == "YES") {
					alert("注册成功！");
					$("#t_ #centerres").html("请先退出浏览器，重新启动服务后正式使用");
				} else {
					alert("注册失败,错误码：" + jsonData.s);
				}
			}
		},
		
		error : function(request, textStatus, error) {
		}
	});
}
</script>
<BODY>
	<DIV>
		<form>
			<TABLE height="50%" cellSpacing=0 cellPadding=0 width="100%"
				border="0">
				<TR>
					<TD height="700" align="center">

						<table align="center" height="20px" border="0" style="  background: rgb(157, 131, 104);margin-top: 10%;" id="t_">
							<tr align="center" height="20px">
								<td colspan="2" align="center"><span style="  color: white;font-size: 32px;font-weight: bolder;">系统注册</span>
								</td>
							</tr>
							<tr align="center" height="20px">
								<td height="120px" colspan="2" align="center"><textarea
										name="textarea" id="request"
										style="width: 550px; height: 100px"></textarea>
								</td>
							</tr>
							<tr align="center" height="20px">
								<td colspan="2" align="center"><input type="button"
									name="Submit" value="获取申请码" onClick="getRemoteRequest();"
									style="width: 150px">
								</td>
							</tr>
							<tr align="center" height="20px">
								<td height="120px" colspan="2" valign="top"><textarea
										name="textarea2" id="response"
										style="width: 550px; height: 100px"></textarea>
								</td>
							</tr>
							<tr align="center" height="20px">
								<td colspan="2" height="50px" valign="middle"><input type="button"
									name="Submit2" value="提交修改码" onClick="setRemoteResponse();"
									style="width: 150px">
								</td>
							</tr>
							<tr align="center" height="40px">
								<td  colspan="2" align="center" id="centerres">
									
								</td>
							</tr>
						</table></TD>
				</TR>
			</TABLE>
		</form>
	</DIV>
</BODY>
</HTML>
