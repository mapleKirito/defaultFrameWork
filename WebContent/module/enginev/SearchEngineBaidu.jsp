<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
body {
	margin: 0 0 0 0px;
	background: #ffffff
}

td,div {
	font-size: 12px;
	line-height: 18px
}

.logo {
	width: 72px;
}

.logo img {
	border: 0
}

.sb{
	margin-left:5px;
}
</style>
</head>
<body>
	<SCRIPT language=javascript> 
var ch = "";
var tr = "iU-nPX0pWEC";
 
var paramObj = {
	'tn': 'xiegr8_pg',
	'tr': tr
};
if(ch){
	paramObj['ch'] = ch;
}
 
var queryParam = [];
var hiddenField = [];
for (var i in paramObj) {
	queryParam.push(i + '=' + paramObj[i])
	hiddenField.push(
		'<input type="hidden" name="',
		i,
		'" value="',
		paramObj[i],
		'">'
	);
}
queryParam = queryParam.join('&');
 
function g(formname)	{
var url = "http://www.baidu.com/s";
formname.action = url;
return true;
}
</SCRIPT>

	<table width=99% height=100% border="0" cellspacing="0" bgcolor="#F7F7F7" cellpadding="0">
		<form name="search_form" target="_blank" onsubmit="return g(this)">
			<script>document.write(hiddenField.join(''));</script>
			<input name="tn" type="hidden" value=xiegr8_pg>
			<tr>
				<td>
					<table cellspacing="0" cellpadding="0" bgcolor="#F7F7F7">
						<tr>
							<td class="logo" align=center><img src="<%=request.getContextPath()%>/images/baidu.gif" border="0" width="100" height="30" alt="百度中文搜索引擎"></td>
							<td nowrap>
								<input id="word" name="word" value='<s:property value="#session.nameother" />'
									style="width: 103px;margin-left:2px;" onMouseOver="this.focus()"
									onBlur="if (this.value =='') this.value='关键字'"
									onFocus="this.select()"
									onClick="if (this.value=='关键字') this.value=''">
								
							</td>
							<td><input type="submit" class="sb" value="百&nbsp;度&nbsp;搜&nbsp;索" style="width: 92px; height: 22px" /></td>
						</tr>
					</table>	
				</td>
			</tr>
			</form>
	</table>
</body>
</html>
