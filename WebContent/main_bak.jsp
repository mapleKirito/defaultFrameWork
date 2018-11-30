<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title><s:text name="systemName"/></title>
<s:include value="head.jsp"></s:include>
<style type="text/css">
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: none;
}
a:active {
	text-decoration: none;
}
</style>
<script language="JavaScript" >
$(document).ready(function(){
	$(".labelonLeft:gt(0)").toggleClass("labeloutLeft");
	$(".labelonBg:gt(0)").toggleClass("labeloutBg");
	$(".labelonRight:gt(0)").toggleClass("labeloutRight");
	$(".labelonBgA:gt(0)").toggleClass("labeloutBgA");
	$("#PageControlPanel > div:eq(0)").show();
	$("#PageControlPanel > div > span").bind("click", function(event) { 
	});	
	$("#userExit").click(function(){
		var rv = confirm("您确认要注销退出吗？");
		if (rv)
		{
			location = "exit.jsp";
		}		
	});
});
function funcChange(index,code){
	$(".labelonLeft").addClass("labeloutLeft");
	$(".labelonBg").addClass("labeloutBg");
	$(".labelonRight").addClass("labeloutRight");
	$(".labelonBgA").addClass("labeloutBgA");
	$("#labelleft"+index).removeClass().addClass("labelonLeft");
	$("#labelbg"+index).removeClass().addClass("labelonBg");
	$("#labelright"+index).removeClass().addClass("labelonRight");
	$("#labelbgA"+index).removeClass().addClass("labelonBgA");
	
	$("#PageControlPanel > div:eq("+index+")").show();
	$("#PageControlPanel > div:lt("+index+")").hide();
	$("#PageControlPanel > div:gt("+index+")").hide();
	var src = $("#leftMenu" + code).attr("src");
	$("#leftMenu" + code).attr("src","forwardAction.action?code="+code);
	$(".centerFrame").attr("src","welcome.jsp");
	
}
function funcSwitch(index)
{
	$("#frmTitle"+index).toggle();

}
function timeClock() {
    var today = new Date();
    var year = today.getFullYear() + "-" + (today.getMonth()+1) + "-" + today.getDate();
    var time=CurentTime();
    var tim = year + " " + time;
    $("#nowtime").text(tim);
}
 function CurentTime(){
    var now = new Date();
    var hh = now.getHours();
    var mm = now.getMinutes();
    var ss = now.getTime() % 60000;
    ss = (ss - (ss % 1000)) / 1000;
    var clock = hh+':';
    if (mm < 10) clock += '0';
    clock += mm+':';
    if (ss < 10) clock += '0';
    clock += ss;
    return(clock);
}
//注意：在js中实现按时调用必须是这种方式——定时调用自己
function Timer(){
	timeClock();
	setTimeout("Timer()", 1000); // 循环定时调用
}		
</script>
</head>
<body onLoad="Timer();">
<div id="message__" class="showDiv">
</div>
<div id="screen__">
    <iframe id="iframeScreen__" scrolling="no" frameborder="0">
    </iframe>
</div>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="50"><s:include value="top.jsp"></s:include></td>
	</tr>
	<tr>
		<td >
		<table border=0 cellpadding=0 cellspacing=0 height='100%'  width='100%'>
			<tr >
    			<td style="background:url(images/top/tab_bg.jpg);" height="26">
				  <table width="100%" border="0"  height="26" style="background:url(images/top/tab.jpg) no-repeat;" cellspacing="0" cellpadding="0">
					<tr>
						<td height="26" width="180">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="26" width="100%" align="center"><font color="#fffff7">欢迎您,${s_userLoginName}</font></td>
								</tr>
							</table>
						</td>
						<td width="86%" height="26" align="left" valign="bottom">
							<table border=0 id="label" height="21"  cellspacing=0 cellpadding=0 align=left>
								<tr>
									<td width=20  height="21"></td>
							       <s:iterator value="subPermission" id="pms" status="ind">
									<td id="labelleft${ind.index}" class="labelonLeft"></td>
									<td id="labelbg${ind.index}" class="labelonBg" valign="bottom"><a href="javascript:void(0)" id="labelbgA${ind.index}" class="labelonBgA" onclick="funcChange('${ind.index}','${pms.code}')">${pms.name}</a></td>
									<td id="labelright${ind.index}" class="labelonRight"></td>
							       </s:iterator>	
		                            <s:if test="subPermission.size() <= 0" >
									<td id="labelleft0" class="labeloutLeft">&nbsp;</td>
									<td id="labelbg0" class="labeloutBg" valign="bottom"><a href="javascript:void(0)"><s:text name="labelDefaultInfo"/></a></td>
									<td id="labelright0" class="labeloutRight">&nbsp;</td>	
		                            </s:if>
								 </tr>
							</table>
						</td>
					  </tr>
				   </table>
                </td>
			</tr>
			<tr>
				<td  height='100%' colspan="2" style='padding:6;' bgcolor='#296194'>
				   <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
					<tr>
                      <td id='PageControlPanel' width="100%" height="100%">
						<s:iterator value="subPermission" id="pms" status="ind">
							<div style="display:none;height:100%;" id="content${ind.index}">
							   <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="168" id="frmTitle${ind.index}" height="100%" align="center" valign="top">
                                     <s:if test="#ind.index == 0">
										<iframe name="leftMenu${pms.code}" id="leftMenu${pms.code}" height="100%" width="168" src="forwardAction.action?code=${pms.code}" frameborder="0" style='overflow:auto;'></iframe>
                                     </s:if>
									 <s:else>
										<iframe name="leftMenu${pms.code}" id="leftMenu${pms.code}" height="100%" width="168" frameborder="0" style='overflow:auto;'></iframe>
									 </s:else>
									</td>
									<td width="5" valign="middle" bgcolor="#296194" onclick="funcSwitch('${ind.index}')">
									<span class="navPoint" id="switchPoint" title="关闭/打开左栏"> 
										<img src="images/main/main_41.gif" name="img1" width="7" height="52" id="img1">
									</span>
									</td>
									<td align="center" valign="top" height="100%">
									  <iframe name="centerFrame${pms.code}" id="centerFrame${pms.code}" class="centerFrame" height="100%" width="100%" src="welcome.jsp" frameborder="0" scrolling="yes"></iframe>
                                    </td> 
								   </tr>
							    </table>				
					        </div>
					    </s:iterator>
                         <s:if test="subPermission.size() <= 0" >
							<div style="display:block;height:100%;" id="content0">
							   <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td align="center" valign="top" width="100%" height="100%">
									  <iframe name="centerFrame" id="centerFrame" height="100%" width="100%" src="info.jsp" frameborder="0" scrolling="yes"></iframe>
                                    </td> 
								   </tr>
							    </table>				
					        </div>
                          </s:if>
					 </td>  
                    </tr>
				 </table>
				</td>
			</tr>
		</table>
       </td>
	</tr>
	<tr>
		<td height="30"><s:include value="foot.jsp"></s:include></td>
	</tr>
</table>
</body>
</html>
