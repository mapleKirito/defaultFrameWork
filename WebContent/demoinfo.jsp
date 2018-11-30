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
		var jimahou = document.getElementById("jimahou").value;
		var xuliehao = document.getElementById("xuliehao").value;
		
		if(jimahou!='' && xuliehao!=''){
			$.ajax({
				//ajax请求url
				url : 'GotoDemo/Test?jimahou=' + jimahou + "&xuliehao=" + xuliehao,
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
					if(jsonData==1){window.location.href = '<%=request.getContextPath()%>/demoinfo2.jsp';}
				},
				//ajax请求错误后调用函数
				error : function(request, textStatus, error) {
				}
			});
		}else if(xuliehao==''){
			alert("请填写序列号!");
		}

	});
});
	function jimihounext() {
		$.ajax({
			//ajax请求url
			url : 'GotoDemo/Test?t=0',
			//ajax提交方式
			type : 'post',
			//ajax请求超时时长
			timeout : '60000',
			//ajax请求参数
			data : Array(),
			//请求数据类型，包括json和xml两种
			dataType : 'json',
			//ajax执行前调用函数
			beforeSend : function(request) {document.getElementById("jimahou").value= "正在生成机器码,请等待......";	
			},
			//ajax请求完成后调用函数
			complete : function(request, textStatus) {
			},
			//ajax请求成功调用函数
			success : function(jsonData, textStatus) {
				if(textStatus){
					document.getElementById("jimahou").value= jsonData.demovalue;				
				}
			},
			//ajax请求错误后调用函数
			error : function(request, textStatus, error) {
			}
		});
	}
</script>
<BODY onload="jimihounext();" style="background-image: url('images/xtzc.png');"  >
	<DIV>
		<form>
			<TABLE height="620px" cellSpacing=0 cellPadding=0 width="100%" border="0">
				<TBODY>
					<TR>
						<TD align="center" valign="middle">
							<table align="center" height="357" width="727"   border="0" cellpadding="0" cellspacing="0" style="padding-top:40px;  background-image: url('images/xtzc1.png');  ">
								<tr height="20px" >
									<td align="right"  width="30%">机器码：</td>
									<td colspan="2" height="0"  align="left"  > 
										<input type="text" id="jimahou" style="width: 270px; height: 20px" readonly="readonly"></input>
									</td>
								</tr>
								<tr height="20px">
									<td align="right" width="30%">序列号：</td>
									<td colspan="2" height="0" align="left">
										<input type="text" id="xuliehao" style="width: 270px; height: 20px"></input>
									</td>
								</tr>
								<tr height="20px">
									<td colspan="3" height="20px" valign="middle" align="center">
									<input type="button" name="next" value="下一步" id="nextpage"  style="width: 150px">
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