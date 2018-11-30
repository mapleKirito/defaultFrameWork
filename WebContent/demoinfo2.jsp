<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>数字生物馆</title>
</head>
<script language="javascript"src="<%=request.getContextPath()%>/js/jquery-1.6.2.js"type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#nextpage").click(function(){
		var succeva = document.getElementById("succeva").value;
		var jiemabefore = document.getElementById("jiemabefore").value;
		var xuliebefore = document.getElementById("xuliebefore").value;
		
		if(succeva!=''){
			$.ajax({
				//ajax请求url
				url : 'GotoDemo/Test?succeva=' + succeva+"&jiemabefore="+jiemabefore+"&xuliebefore="+xuliebefore,
				//ajax提交方式
				type : 'post',
				//ajax请求超时时长
				timeout : '60000',
				//ajax请求参数
				data : Array(),
				//请求数据类型，包括json和xml两种
				dataType : 'json',
				//ajax执行前调用函数
				beforeSend : function(request) {
				},
				//ajax请求完成后调用函数
				complete : function(request, textStatus) {
				},
				//ajax请求成功调用函数
				success : function(jsonData, textStatus) {
					 if(jsonData.istrue==1){window.location.href = '<%=request.getContextPath()%>/login.jsp' }
					 else{alert("您填写有误!");}
				},
				//ajax请求错误后调用函数
				error : function(request, textStatus, error) {
				}
			});
		}else{
			alert("请填写注册码!");
		}
		
		
	
	
	});
});
function getBefore() {
	$.ajax({
		//ajax请求url
		url : 'GotoDemo/Test?g=0',
		//ajax提交方式
		type : 'post',
		//ajax请求超时时长
		timeout : '60000',
		//ajax请求参数
		data : Array(),
		//请求数据类型，包括json和xml两种
		dataType : 'json',
		//ajax执行前调用函数
		beforeSend : function(request) {
		},
		//ajax请求完成后调用函数
		complete : function(request, textStatus) {
		},
		//ajax请求成功调用函数
		success : function(jsonData, textStatus) {
			if(textStatus){
				document.getElementById("jiemabefore").value= jsonData.jiema;	
				document.getElementById("xuliebefore").value= jsonData.xulie;	
			}
		},
		//ajax请求错误后调用函数
		error : function(request, textStatus, error) {
		}
	});
}
</script>
<BODY  onload="getBefore();"  style="background-image: url('images/xtzc.png');">
	<DIV>
		<form>
			<TABLE  height="620px" cellSpacing=0 cellPadding=0 width="100%" border="0">
				<TBODY>
					<TR>
						<TD align="center" >
							<table align="center" height="357" width="727" border="0" cellpadding="0" cellspacing="0" style="padding-top:45px;  background-image: url('images/xtzc1.png');  ">
								<tr height="40px">
									<td align="right"  width="30%">机器码：</td>
									<td colspan="2" height="0"  align="left">
										<input type="text" id="jiemabefore" style="width: 270px; height: 20px" readonly="readonly"  ></input>
									</td>
								</tr>
								<tr height="40px">
									<td align="right"  width="30%">序列号：</td>
									<td colspan="2" height="0" align="left">
										<input type="text" id="xuliebefore" style="width: 270px; height: 20px" readonly="readonly"  ></input>
									</td>
								</tr>
								<tr height="40px">
									<td align="right"  width="30%">注册码：</td>
									<td colspan="2" height="0"  align="left">
									<input type="text" id="succeva" style="width: 270px; height: 20px"></input>
									</td>
								</tr>
								<tr height="20px">
									<td colspan="3" height="0" valign="top" align="left"   style="padding-left: 150px;">
										<p>
										请将机器码、序列号发至linktones@126.com邮箱<br /><br />或拨打电话询问注册码&nbsp;&nbsp;010-56258959&nbsp;&nbsp;&nbsp;&nbsp;</p>
									</td>
								</tr>
								<tr height="20px">
									<td colspan="3" height="20px" valign="middle" align="center">
									<input type="button" name="next" value="完成" id="nextpage"  style="width: 150px">
									</td>
								</tr>
							</table>
						</TD>
					</TR>
				</TBODY>

			</TABLE>
		</form>
	</DIV>
</BODY>
</html>