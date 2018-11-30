<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.6.2.js"
	type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<style> 
body{
background:url("images/dldz.png");
background-position:center;
} 
.inButtonColor {
 width: 150px;
 height: 37px;
}
table tr td{word-break:break-all; word-wrap:break-word;}
table tr td span,table tr td input{vertical-align: middle;}
</style> 
</head>
<script type="text/javascript">
	function getIp() {
		document.getElementById("request").value = "";
		$.ajax({
			
			url : 'SmartIpXmlServlet/SmartIpXml?ips=getIp',
			
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
					document.getElementById("request").value = jsonData.ipd;
				}
			},
			
			error : function(request, textStatus, error) {
			}
		});
	}
	function GetLocalIPAddress() {
		document.getElementById("request1").value = "";
		$.ajax({
			
			url : 'SmartIpXmlServlet/SmartIpXml?ips=getLocalIp',
			
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
					document.getElementById("request1").value = jsonData.ipd;
				}
			},
			
			error : function(request, textStatus, error) {
			}
		});
	}
	function isIP(strIP) {
		var re = /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/g;
		if (re.test(strIP)) {
			if (RegExp.$1 < 256 && RegExp.$2 < 256 && RegExp.$3 < 256
					&& RegExp.$4 < 256)
				return true;
		}
		return false;
	}
	function IpConfig() {
		var ips = document.getElementById("responseIp").value;
		
		if (isIP(ips)) {
			$.ajax({
				
				url : 'SmartIpXmlServlet/SmartIpXml?setIp=setIp&ips=' + ips,
				
				type : 'post',
				
				timeout : '60000',
				
				data : Array(),
				
				dataType : 'json',
				
				beforeSend : function(request) {
				},
				
				complete : function(request, textStatus) {
				},
				
				success : function(jsonData, textStatus) {
					if (isIP(ips)) {
						$("#centerres").html("IP设置成功！请先退出浏览器并重新启动tomcat。重启完毕后请您在浏览器地址栏输入您设定的ip加端口号来访问本系统。您的完整地址：http://服务器IP地址:8086/dm");
						$("#forwd").val(ips);
					}else{
						$("#centerres").html("IP设置失败！请刷新重试");
					}
					
				},
				
				error : function(request, textStatus, error) {
				}
			});
		}else{
			alert("请检查IP地址是否输入正确！");
		}
	}
</script>
<input type="hidden" id="forwd" value="">
<BODY >
		<TABLE height="50%" cellSpacing=0 cellPadding=0 width="100%" border="0">
			<TBODY>
				<TR>
					<TD height="700" align="center">
						
							<table align="center" height="20px" border="0" width="875px">
								<!-- <tr height="20px">
									<td colspan="2" height="0" valign="top" align="center">
									<input type="text" id="request" style="width: 270px; height: 20px"></input>
									</td>
								</tr>
								<tr height="20px">
									<td height="31" colspan="2" align="center">
									<input type="button" name="Submit" value="获取软件IP" onClick="getIp();" style="width: 150px">
									</td>
								</tr> -->
								<tr height="20px">
									<td colspan="2" height="50px" valign="top" align="center"  style="line-height: 26px">
										操作提示：点击"本机IP"，将"本机IP"复制粘贴到"软件IP",点击"设置软件IP"。
									</td>
								</tr>
								<tr height="20px">
									<td height="0" colspan="2" valign="top"  align="center"><span>本机IP</span>&nbsp;<input type="text" id="request1" style="width: 270px; height: 20px"></input>
									</td>
								</tr>
								<tr height="20px">
									<td height="31" colspan="2"  valign="middle"align="center"><input type="button" name="Submit" value="获取本机IP" onClick="GetLocalIPAddress();" style="width: 150px">
									</td>
								</tr>
								<tr height="20px">
									<td colspan="2" height="0" valign="top" align="center"><span>软件IP</span>&nbsp;
									<input type="text" id="responseIp" style="width: 270px; height: 20px"></input>
									</td>
								</tr>
								<tr height="20px">
									<td colspan="2" height="50px" valign="middle" align="center">
									<input type="button" name="Submit2" value="设置软件IP" onClick="IpConfig();" style="width: 150px">
									</td>
								</tr>
								<tr height="20px">
									<td colspan="2" height="50px" valign="middle" align="center" id="centerres" style="line-height: 26px">
									</td>
								</tr>
							</table>
					</TD>
				</TR>
			</TBODY>
				
		</TABLE>
</BODY>
</html>