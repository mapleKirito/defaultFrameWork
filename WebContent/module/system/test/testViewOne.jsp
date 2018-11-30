<%@page import="java.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.text.*" %>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<html>
<title>${promptInfo.totalDescInfo}</title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/testview.js" type="text/javascript"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
#optiontab1 input,#optiontab1 span,#optiontab2 input,#optiontab2 span,#optiontab3 input,#optiontab3 span{vertical-align: middle;}
#right_num img,#right_num span{vertical-align: middle;}
#right_info img{float: right; margin: 40px 45px 0px 0px; }
#right_n{text-align: center;}
#num{margin: 0 10px;}
td, th {font-size: 16px;}
#right_y #rightnextytb #rightnexty p{line-height: 20px;text-indent: 32px;}
#jiexi img{margin-left: 32px; float: left;height: 19px;} 
#left tr td img{height: 20px;}
#rightnexty textarea{padding-top: 10px;margin-left: 33px;line-height: 16px;}
#climate_app span{margin-right: 5px;}
.colockbox span{ float: left; display: block; width: 48px; height: 48px; line-height: 41px; font-size: 26px; text-align: center; color: #ffffff; margin: 0 12px 0 0; }
.colockbox span.second{margin:0;}
#optiontab1 tr td,#texttypes,#right_num,#num{color: #464646;}
.td-dt { position: relative; height: 53px; line-height: 53px; text-indent: 50px; background: #7c6d5b; font-size: 18px; color: white; }
.icon-tongji{ position: absolute; width: 25px; height: 25px; display: block; background-image: url(images/icon-spriter.png); background-repeat: no-repeat;
left: 15px; top: 15px; width: 22px; height: 21px; background-position: -128px -500px; }
#left{background: #ae9b84;color: white;height: 446px;}
div#timer span.minute { width: 68px; height: 43px; line-height: 43px; text-align: center; float: left; display: inline;
background: url(images/icon-spriter.png) 0px -1000px no-repeat; }
div#timer span.second { width: 68px; height: 43px; line-height: 43px; text-align: center; float: left; display: inline; 
background: url(images/icon-spriter.png) 0px -1000px no-repeat; }
.dati.title { color: white; text-indent: 10px; height: 53px; line-height: 53px; background-color: #ff5a5a; font-size: 18px; }
#right_title { padding: 20px; border: 1px solid #ecd2d2; background: #ffecec; color: #464646; border-radius: 3px; }
#right_optiones { padding: 30px; border: 1px solid #e0e0e0; background: #f7f7f7; color: #464646; border-radius: 3px; }
#right{color: white;border: 1px solid #d1d1d1;}
.optiontrheight{height: 35px;}
#break_butsmt{
float: right;
margin-right: 15px;
color: white;
}
#butsmt,#butback,#butsmtogeter,#butInfo,#testInfo,#butnext,#overtest{ width: 137px; height: 41px; display: inline-block; margin-right: 15px;
line-height: 41px; text-align: center; line-height: 41px; font-size: 14px; color: white; border-radius: 2px; }
.page-container.ssjh { width: 950px; padding-bottom: 20px; margin: 0px auto; }
.panel>p.title.topborder { border-top: 3px solid #ea183f; }
.panel { width: auto; overflow: hidden; border: 1px solid #dcdcdc; }
.topborder.title{position: relative; height: 34px; line-height: 34px; font-size: 14px; color: #666666; text-indent: 10px; border-bottom: 1px solid #e1e1e1;}

#todayInfo{
	border: 5px white solid;
}

#today{
	border: 1px black solid;
	z-index: 100;
	left:320px;
	top:100px;
	position: absolute;
}

</style>
<script type="text/javascript">
var timer;
var userAgent = navigator.userAgent, 
rMsie = /(msie\s|trident.*rv:)([\w.]+)/, 
rFirefox = /(firefox)\/([\w.]+)/, 
rOpera = /(opera).+version\/([\w.]+)/, 
rChrome = /(chrome)\/([\w.]+)/, 
rSafari = /version\/([\w.]+).*(safari)/;
var browser;
var version;
var ua = userAgent.toLowerCase();
$(document).ready(function(){	
	var skips = ["311","312","313","321","322","323"];
	var grade=${paramMap.testGrades};
	var gradeTitleName="";
	if(grade=="311"){
		gradeTitleName="七年级";
	}else if(grade=="312"){
		gradeTitleName="八年级";
	}else if(grade=="313"){
		gradeTitleName="九年级";
	}else if(grade=="321"){
		gradeTitleName="必修一";
	}else if(grade=="322"){
		gradeTitleName="必修二";
	}else if(grade=="323"){
		gradeTitleName="必修三";
	}
	$("#gradeTitle").html(gradeTitleName+$("#gradeTitle").html());
	var testNum=${paramMap.testNum};
	//alert(testNum);
	selecttest(testNum,1);
	
	$("#butsmtogeter,#overtest").click(function (){
		var num=parseInt($("#answeredNum span").html());
		if(num>0){
			uwatchcount();
		}else{
			alert("还没有答题，不能提交");
		}
		
	}); 
	
	$("#butsmt").click(function (){
		var checkBoxSize=$("#right_optiones ").find("input[type='checkbox']:checked").length;
		var radioSize=$("#right_optiones ").find("input[type='radio']:checked").length;
		if(checkBoxSize>0||radioSize>0){
			clearInterval(timer);
			$("#djs").empty().html("<div class='colockbox' id='timer'> <span class='minute'>00</span> <span class='second'>00</span> </div>");
			
			submity();
		}
	}); 
	
	$("#break_butsmt").click(function (){
		
		cleartime();
		
		var testpage = parseInt($("#textpage").val())+1;
		$("#textpage").val(testpage);
		selecttest(testpage-1,1);
		$("#num").html(testpage);
		
		if($(this).attr("tag")=="0"){
			var tobreak = parseInt($("#left #tobreak span").html());
			$("#left #tobreak span:eq(0)").html(tobreak+1);
		}
		
		$(".ynisshow").show();
		$("#butback").hide();
		$("#right_y").hide();
		$("#right_info").hide();
		$("#right_n").hide();
		$("#testInfo").hide();
	 	var testcountval = parseInt($("#testcountval").val()); //该分类下题目总数
		
		if(testpage == testcountval){
			//$("#break_butsmt").hide();
		}
		var answeredNum = parseInt($("#left #toy span").html())+parseInt($("#left #ton span").html())+parseInt($("#left #tobreak span").html());
		$("#answeredNum span").html(answeredNum);
		 
	});
	
	$("#butback").click(function (){
		
		cleartime();
		
		var testpage = parseInt($("#textpage").val())+1;
		$("#backpage").val(testpage-1);
		//alert(testpage);
		selecttest(testpage-2,1); 
		
		$("#textbreaknum").val(parseInt($("#textbreaknum").val())+1); 
		
		$(".ynisshow").show();
		$("#butback").hide();
		$("#right_n").hide();
		
		var testcountval = parseInt($("#testcountval").val()); //该分类下题目总数
		
		if(testpage>testcountval){
			testpage = testcountval;
		}
		
		var testpage1 = parseInt($("#textpage").val());
		if(testpage1 != testcountval){
			//$("#break_butsmt").show();
		}else{
			//$("#break_butsmt").hide();
		}
	});
	
	$("#bradky").click(function (){
		
		cleartime();
		
		var testpage = parseInt($("#textpage").val())+1;
		$("#textpage").val(testpage);
		selecttest(testpage-1,1);
		$("#num").html(testpage);
		
		/* var tobreak = parseInt($("#left #tobreak span").html());
		$("#left #tobreak span:eq(0)").html(tobreak+1); */
		
		$(".ynisshow").show();
		$("#butback").hide();
		$("#right_y").hide();
		$("#right_info").hide();
		$("#right_n").hide();
		$("#testInfo").hide();
		var testcountval = parseInt($("#testcountval").val()); //该分类下题目总数
		
		if(testpage == testcountval){
			//$("#break_butsmt").hide();
		}else{
			//$("#break_butsmt").show();
		}
	});
	
	$("#testInfo").click(function(){
		$("#right_info").show();
		$("#right_y").hide();
		$("#testInfo").hide();
	});
	
	$("#butnext").click(function (){
		
		cleartime();
		
		var testpage = parseInt($("#textpage").val())+1;
		$("#textpage").val(testpage);
		selecttest(testpage-1,1);
		$("#num").html(testpage);
		
		$(".ynisshow").show();
		$("#butback").hide();
		$("#right_y").hide();
		$("#right_info").hide();
		var testcountval = parseInt($("#testcountval").val()); //该分类下题目总数
		$("#testInfo").hide();
		//alert(testpage == testcountval);
		
		if(testpage == testcountval){
			//$("#break_butsmt").hide();
		}else{
			//$("#break_butsmt").show();
		}
	});
	
	var picval = '${paramMap.expResType}';
	var $pic = $("#total #welImage img");
	var $pic2 = $("#total #welImage2 #welImage2_1");
	var picpath = "images/test/",picpath2 = "images/test/";

	if(picval == 197){
		picpath += "zrdl_bk.jpg";
		picpath2 += "zrdl.png";
	}
	else if(picval == 999){
		picpath += "rwdl_bk.jpg";
		picpath2 += "rwdl.png";
	}
	else if(picval == 1000){
		picpath += "qudl_bk.jpg";
		picpath2 += "qudl.png";
	}
	else if(picval == 1001){
		picpath += "zhdl_bk.jpg";
		picpath2 += "zhdl.png";
	}
	else if(picval == 1002){
		picpath += "zht_pk.jpg";
		picpath2 += "zht.png";
	}
	$pic.attr("src",picpath);
	$pic2.attr("src",picpath2);
	
	var browserMatch = uaMatch(userAgent.toLowerCase());
	if (browserMatch.browser) {
		browser = browserMatch.browser;
		version = browserMatch.version;
	}	
	
	$("#total").css("height",$("#windowheight", parent.document).val()-3+"px");
	$("#welImage img").LoadImage(true, $("#windowwidth", parent.document).val(), $("#windowheight", parent.document).val()-3);
	
});
function uwatchcount(){
	var userType="${session.s_userType}";
	//alert(userType);
	
	if(userType=="2"||userType=="1"){
		var tcAnswerT = parseInt($("#left #toy span").html())+parseInt($("#left #ton span").html())+parseInt($("#left #tobreak span").html());
		//var date=new Date().Format(this, "yyyy-MM-dd").toLocaleDateString();
		var da=new Date();
		var date=da.toLocaleDateString().replace("/", "-").replace("/", "-");
		
		
		var addWealth=parseInt($("#left #toy span").html());
		$.ajax({
			url:		'ajaxAction.action?code=-170103&paramMap.tcAUserID='+'${paramMap.s_userID}'+'&paramMap.userID='+'${paramMap.s_userID}'+'&paramMap.newWealth='+addWealth+'&paramMap.tcAnswerT='+tcAnswerT+'&paramMap.tcAnswerY='+$("#left #toy span").html()+'&paramMap.tcAnswerN='+$("#left #ton span").html()+'&paramMap.tcAnswerP='+$("#left #tobreak span").html()+'&paramMap.tcCreateTime='+date,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					var info=jsonData.data[0];
					$("#todayInfo #answeredNum span").html(info.T);
					$("#todayInfo #toy span").html(info.Y);
					$("#todayInfo #ton span").html(info.N);
					$("#todayInfo #tobreak span").html(info.P);
					var per=info.Y/info.T*100;
					var per2=per+" ";
					var persent=per2.substring(0, 5);
					//$("#todayInfo #tob span").html(persent+"%");
					$("#todayInfo #tob span").html(Math.floor(parseInt(info.Y)/parseInt(info.T)*100)+"%");  
					document.getElementById("today").style.visibility="visible";
					$("#butInfo").click(function(){
						window.parent.tabClick("munu_name","探究热身","-17010","");
					});
					//window.parent.tabClick("munu_name","探究热身","-17010","");
				}
			},
			error:function(request,textStatus,error){}
		});
	}else{
		alert("非教师学生用户不能提交");
	}
	
}

function uaMatch(ua) {
	var match = rMsie.exec(ua);
	if (match != null) {
		return { browser : "IE", version : match[2] || "0" };
	}
	var match = rFirefox.exec(ua);
	if (match != null) {
		return { browser : match[1] || "", version : match[2] || "0" };
	}
	var match = rOpera.exec(ua);
	if (match != null) {
		return { browser : match[1] || "", version : match[2] || "0" };
	}
	var match = rChrome.exec(ua);
	if (match != null) {
		return { browser : match[1] || "", version : match[2] || "0" };
	}
	var match = rSafari.exec(ua);
	if (match != null) {
		return { browser : match[2] || "", version : match[1] || "0" };
	}
	if (match != null) {
		return { browser : "", version : "0" };
	}
}
function cleartime(){
	clearInterval(timer);
	$("#djs").empty().html("<div class='colockbox' id='timer'> <span class='minute'>00</span> <span class='second'>00</span> </div>");
	countDown("#timer .minute","#timer .second");
}
function countDown(minute_elem,second_elem){
	//alert();
	var end_time = new Date();
		end_time.setSeconds(end_time.getSeconds()+60);
		end_time = end_time.getTime();
	var sys_second = (end_time-new Date().getTime())/1000;
	
	timer = setInterval(function(){
		if (sys_second > 0) {
			sys_second -= 1;
			var minute = Math.floor((sys_second / 60) % 60) == -1?0:Math.floor((sys_second / 60) % 60);
			var second = Math.floor(sys_second % 60) == -1?0:Math.floor(sys_second % 60);
			$(minute_elem).text(minute<10?"0"+minute:minute);
			$(second_elem).text(second<10?"0"+second:second);
		} else { 
			var num = parseInt($("#numval").val());
			if(num==0){
				submity();
				$("#numval").val("1");
			}else if(num==1){
				$("#right_n").show();
				$("#right_y").hide();
				$("#right_info").hide();
				$(".ynisshow").hide();
				$("#butsmt").hide();
				$("#butback").show();
				$("#testInfo").hide();
				if(textpage < testcountval){
					$("#bradky").show();	
				}
			}
		}
	}, 1000);
}
function submity(){
	var typeval = $("#testtypeval").val();
	var testIndivAnswerval = $("#testIndivAnswer").val();
	var clival = "";
	
	if("1,3".indexOf(typeval) >-1){
		clival = $('input.option'+typeval+':radio:checked').val();
	}else{
		$('input.option'+typeval+':checkbox:checked').each(function(i){
			clival+="," + $(this).val();
		});
		clival = clival.replace(/,/,"");
	}
	
	if("1,3".indexOf(typeval) >-1){
		var testcountval = parseInt($("#testcountval").val()); //该分类下题目总数
		var textpage = parseInt($("#textpage").val()); //该分类下当前题号 
		
		var toy = parseInt($("#left #toy span").html());
		var ton = parseInt($("#left #ton span").html());
		
		//$("#break_butsmt").hide();
		
		if(typeof clival != 'undefined' && clival == testIndivAnswerval){
			$("#right_y").show();
			$("#right_info").hide();
			$("#right_n").hide();
			$(".ynisshow").hide();
			$("#butsmt").hide();
			//$("#butsmtogeter").hide();
			if($("#hasTestInfo").val()=="1"){
				$("#testInfo").show();
			}
			var textpageisn1 = $("#textpage").val();
			var textpageisn2 = $("#backpage").val();
			
			if(textpageisn1!=textpageisn2){
				$("#left #toy span:eq(0)").html(toy+1);
			}
			
			$("#left #tob span:eq(0)").html(Math.floor(parseInt($("#left #toy span").html())/parseInt($("#textpage").val())*100)+"%");  
			
			if(textpage == testcountval){
				$("#butnext").hide();
				$("#overtest").show();
			}else{
				$("#butnext").show();	
			}
		}else{
			$("#right_n").show();
			$("#right_y").hide();
			$("#right_info").hide();
			$(".ynisshow").hide();
			$("#butsmt").hide();
			//$("#butsmtogeter").hide();
			$("#butback").show();
			$("#testInfo").hide();
			var textpageisn1 = $("#textpage").val();
			var textpageisn2 = $("#backpage").val();
			
			if(textpageisn1!=textpageisn2){
				$("#left #ton span:eq(0)").html(ton+1);	
			}
			
			$("#left #tob span:eq(0)").html(Math.floor(parseInt($("#left #toy span").html())/parseInt($("#textpage").val())*100)+"%");
			
			if(textpage < testcountval){
				$("#bradky").show();		
			}
			
		}
	}else{
		var testcountval = parseInt($("#testcountval").val()); //该分类下题目总数
		var textpage = parseInt($("#textpage").val()); //该分类下当前题号 
		
		var toy = parseInt($("#left #toy span").html());
		var ton = parseInt($("#left #ton span").html());
		
		//$("#break_butsmt").hide();
		
		if(typeof clival != 'undefined' && clival != '' && ignoreSpaces(testIndivAnswerval) == ignoreSpaces(clival)){
			$("#right_y").show();
			$("#right_n").hide();
			$("#right_info").hide();
			$(".ynisshow").hide();
			$("#butsmt").hide();
			//$("#butsmtogeter").hide();
			$("#testInfo").show();
			var textpageisn1 = $("#textpage").val();
			var textpageisn2 = $("#backpage").val();
			
			if(textpageisn1!=textpageisn2){
				$("#left #toy span:eq(0)").html(toy+1);
			}
			
			$("#left #tob span:eq(0)").html(Math.floor(parseInt($("#left #toy span").html())/parseInt($("#textpage").val())*100)+"%");
			
			if(textpage == testcountval){
				$("#butnext").hide();
				$("#overtest").show();
			}else{
				$("#butnext").show();	
			}
			
		}else{
			$("#right_n").show();
			$("#right_y").hide();
			$("#right_info").hide();
			$(".ynisshow").hide();
			$("#butsmt").hide();
			//$("#butsmtogeter").hide();
			$("#butback").show();
			$("#testInfo").hide();
			var textpageisn1 = $("#textpage").val();
			var textpageisn2 = $("#backpage").val();
			
			if(textpageisn1!=textpageisn2){
				$("#left #ton span:eq(0)").html(ton+1);	
			}
			
			$("#left #tob span:eq(0)").html(Math.floor(parseInt($("#left #toy span").html())/parseInt($("#textpage").val())*100)+"%");
			
			if(textpage < testcountval){
				$("#bradky").show();	
			}	
		}
	}

	var answeredNum = parseInt($("#left #toy span").html())+parseInt($("#left #ton span").html())+parseInt($("#left #tobreak span").html());
	$("#answeredNum span").html(answeredNum);
	$("#break_butsmt").attr("tag","1");
}

function ignoreSpaces(string) {
	var temp = "";
	string = '' + string;
	splitstring = string.split(" ");
	for(i = 0; i < splitstring.length; i++)
	temp += splitstring[i];
	return temp;
}
function selecttest(s,o){ 
	$.ajax({
		url:		'ajaxAction.action?code=-170102&paramMap.testGrades ='+'${paramMap.testGrades}'+ '&paramMap.testID ='+ '${paramMap.testID}'+ '&paramMap.testNum =1',
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success"){
				if (jsonData.data){
					if(jsonData.data.length > 0){
						for (var i=0; i<jsonData.data.length;i++){
							var testName = jsonData.data[i].testName;
							var testType = jsonData.data[i].testType;
							var testRemarks = jsonData.data[i].testRemarks;
							$("#right_title").empty().append(testName);
							$("#testtypeval").val(testType);
							
							var types = "";
							if(testType==1){types = "单项选择题";}else if(testType==2){types = "多项选择题";}else if(testType==3){types = "判断题";}
							$("#texttypes").html(types);
							//alert(testRemarks);
							if(testRemarks==null||testRemarks==undefined){
								$("#hasTestInfo").val(0);
							}else{
								$("#hasTestInfo").val(1);
							}
							$("#right_info #rightnextytb #rightnexty textarea").html(testRemarks);
							
							if("1,2".indexOf(testType) >-1){
								var testIndivOptionA = jsonData.data[i].testIndivOptionA;
								var testIndivOptionB = jsonData.data[i].testIndivOptionB;
								var testIndivOptionC = jsonData.data[i].testIndivOptionC;
								var testIndivOptionD = jsonData.data[i].testIndivOptionD;
								var testIndivAnswer = jsonData.data[i].testIndivAnswer;
								$("#testIndivAnswer").val(testIndivAnswer);
								
								if(typeof testIndivOptionC != 'undefined' && testIndivOptionC!=null && testIndivOptionC!=''){$("#optiontab"+testType+" td:eq(2) span").empty().append("<span>&nbsp;C："+testIndivOptionC+"</span>");}else{$("#optiontab"+testType+" td:eq(2)").hide();}
								if(typeof testIndivOptionD != 'undefined' && testIndivOptionD!=null && testIndivOptionD!=''){$("#optiontab"+testType+" td:eq(3) span").empty().append("<span>&nbsp;D："+testIndivOptionD+"</span>");}else{$("#optiontab"+testType+" td:eq(3)").hide();}
								
								$("#optiontab"+testType).show(); 
								$("#optiontab3").hide();
								$("#optiontab"+testType+" td:eq(0) span").empty().append("<span>&nbsp;A："+testIndivOptionA+"</span>");
								$("#optiontab"+testType+" td:eq(1) span").empty().append("<span>&nbsp;B："+testIndivOptionB+"</span>");
							}
							else if(testType==3){
								$("#optiontab"+testType).show(); 
								$("#optiontab1").hide();
								$("#optiontab2").hide();
								$("#optiontab"+testType+" td:eq(0) span").empty().append("<span>&nbsp;对</span>");
								$("#optiontab"+testType+" td:eq(1) span").empty().append("<span>&nbsp;错</span>");
								var testJudgeAnswer = jsonData.data[i].testJudgeAnswer;
								$("#testIndivAnswer").val(testJudgeAnswer);
							}
						}
						$("#butsmt").show();
						if(parseInt($("#num").html())==1){
							//$("#butsmtogeter").hide();
						}else{
							//$("#butsmtogeter").show();
						}
						$("#right_num").show();
						$("#butnext").hide();
						$("#bradky").hide();
						
						$("input[name='paramMap.option"+testType+"']").each(function(){
						   $(this).attr("checked",false);
						});
						
						//alert(jsonData.data.length);
						$("#break_butsmt").attr("tag","0");
						if(jsonData.data.length==1){
							//$("#break_butsmt").hide();
						}
						
					}else{
						$("#butsmt").hide();
						//$("#butsmtogeter").hide();
						//$("#break_butsmt").hide();
						$("#right_title").html("暂无题目").attr("valign","middle").css({"text-align":"center","padding-left":"0px"});
					}
				} 
			}
		},
		error:function(request,textStatus,error){}
	});
	if(s+1<parseInt("${paramMap.testcount}")){
		$("#textpage").val(s+1);
	}else{
		$("#textpage").val(1);
	}
	
}
document.onreadystatechange = function () {   
    if(document.readyState=="complete") { 
    	$("#ladingImag").hide();
    	$("#total").show();
    	$("#welImagetb").show();
    	countDown("#timer .minute","#timer .second");
    }  
};    
</script>
</head>
<body>	
<input type="hidden" id="testtypeval" value="${paramMap.testType}">
<input type="hidden" id="testcountval" value="${paramMap.testcount}">
<input type="hidden" id="testIndivAnswer">
<input type="hidden" id="textpage" value="${paramMap.testNum}">
<input type="hidden" id="backpage" value="0">
<input type="hidden" id="hasTestInfo" value="1">
<input type="hidden" id="textbreaknum" value="0">
<input type="hidden" id="numval" value="0">
<table id='ladingImag' width="100%"><tr><td align="center" valign="middle"><img src='<%=request.getContextPath()%>/images/loadingl.gif' border='0'></td></tr></table>
<div class="page-container ssjh">
    <div class="ssjh-rsdt panel">
        <p id="gradeTitle" class="title topborder">题库，共&nbsp;1&nbsp;题</p>
        <div class="body">
            <table height="100%" border="0" cellspacing="0" cellpadding="0" id="welImagetb" style="display: none;margin: 0 auto;margin-bottom: 40px;margin-top: 40px;">
			  <tr>
			    <td valign="middle" align="center">
					<table width="320px" height="381px" border="0" cellspacing="0" cellpadding="0" id="left">
						<tr>
							<td align="left" colspan="2" class="td-dt"><i class="icon-tongji"></i>数据统计</td>
						</tr>
						<tr>
							<td align="center" width="30%"><span>倒计时:</span></td>
							<td align="center" width="70%" id="djs">
								<div class="colockbox" id="timer">
									<span class="minute">00</span><span class="second">00</span>
								</div>
							</td>
						</tr>
						<tr>
							<td align="center" width="30%">已 答：</td>
							<td align="center" width="70%" id="answeredNum"><span>0</span></td>
						</tr>
						<tr>
							<td align="center" width="30%">答 对：</td>
							<td align="center" width="70%" id="toy"><span>0</span></td>
						</tr>
						<tr>
							<td align="center" width="30%">答 错：</td>
							<td align="center" width="70%" id="ton"><span>0</span></td>
						</tr>
						<tr>
							<td align="center" width="30%">跳 过：</td>
							<td align="center" width="70%" id="tobreak"><span>0</span></td>
						</tr>
						<tr>
							<td align="center" width="30%">正确率：</td>
							<td align="center" width="70%" id="tob"><span>0%</span></td>
						</tr>
						<tr>
							<td align="center" colspan="2">
								<a id="butsmtogeter" href="javascript:;" data-val="ok" class="qo-ok" data-old-bg="#ae9b84" style="background-color: #ff5a5a;">保存成绩</a>
							</td>
						</tr>
					</table>
				</td>
				<td valign="middle" align="center">
					<table width="550px" height="446px" border="0" cellspacing="0" cellpadding="0" id="right">
						<tr style="height: 53px;">
							<td>
								<p class="title dati">答题<a id="break_butsmt" tag="0" href="javascript:;" ><!-- 跳过 --></a></p>
								
								
							</td>
						</tr>
						<tr>
							<td align="center" valign="top">
								<table border="0" cellspacing="0" cellpadding="0" style="padding: 10px 20px 0px 20px;width: 100%;">
									<tr class="ynisshow">
										<td id="right_num" style="display: none;padding-bottom: 10px;">
											第<span id="num">1</span>题:<span id="texttypes"></span>
										</td>
									</tr>
									<tr class="ynisshow">
										<td id="right_title" valign="top"></td>
									</tr>
									<tr style="height: 10px;">
										<td></td>
									</tr>
									<tr class="ynisshow">
										<td id="right_optiones" valign="bottom">
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" id="optiontab1" style="display: none;">
												<tr class="optiontrheight">
													<td><input type="radio" name="paramMap.option1" class="option1" value="A"><span></span></td>
												</tr>
												<tr class="optiontrheight">
													<td><input type="radio" name="paramMap.option1" class="option1" value="B"><span></span></td>
												</tr>
												<tr class="optiontrheight">
													<td><input type="radio" name="paramMap.option1" class="option1" value="C"><span></span></td>
												</tr>
												<tr class="optiontrheight">
													<td><input type="radio" name="paramMap.option1" class="option1" value="D"><span></span></td>
												</tr>
											</table>
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" id="optiontab2" style="display: none;">
												<tr class="optiontrheight">
													<td><input type="checkbox" name="paramMap.option2" class="option2" value="A"><span></span></td>
												</tr>
												<tr class="optiontrheight">
													<td><input type="checkbox" name="paramMap.option2" class="option2" value="B"><span></span></td>
												</tr>
												<tr class="optiontrheight">
													<td><input type="checkbox" name="paramMap.option2" class="option2" value="C"><span></span></td>
												</tr>
												<tr class="optiontrheight">
													<td><input type="checkbox" name="paramMap.option2" class="option2" value="D"><span></span></td>
												</tr>
											</table>
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" id="optiontab3" style="display: none;">
												<tr class="optiontrheight">
													<td><input type="radio" name="paramMap.option3" class="option3" value="y"><span></span></td>
													<td><input type="radio" name="paramMap.option3" class="option3" value="n"><span></span></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr id="right_info" style="display: none;">
										<td valign="top">
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" id="rightnextytb">
												<tr>
													<td id="jiexi" valign="top">
														<img src="" border="0">
													</td>
												</tr>
												<tr>
													<td width="100%" id="rightnexty" valign="top" align="center">
														<textarea cols="62" rows="8"></textarea>
													</td>
												</tr>
												<tr>
													<td width="100%" height="100px"  align="center">
														<img src="" border="0" height="100px" style="margin: 0;float: none;">		
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr id="right_y" style="display: none;">
										<td align="center" valign="bottom"><img src="images/test/y.png" border="0" ></td>
									</tr>
									<tr id="right_n" style="display: none;">
										<td valign="bottom"><img src="images/test/n.png" border="0" ></td>
									</tr>
									<tr>
										<td align="center" valign="middle" style="padding-top: 15px;">
											<a id="butsmt" href="javascript:;" data-val="ok" class="qo-ok" data-old-bg="#ff5a5a" style="background-color: #ff5a5a;">确认</a>
											
											<a id="butback" href="javascript:;" data-val="ok" class="qo-ok" data-old-bg="#ff5a5a" style="background-color: #ff5a5a;display: none;">重新再答</a>
											<a id="testInfo" href="javascript:;" data-val="ok" class="qo-ok" data-old-bg="#ff5a5a" style="background-color: #ff5a5a;display: none;">答案解析</a>
											<!-- <a id="butnext" href="javascript:;" data-val="ok" class="qo-ok" data-old-bg="#ff5a5a" style="background-color: #ff5a5a;display: none;">下一题</a> -->
											<a id="overtest" href="javascript:;" data-val="ok" class="qo-ok" data-old-bg="#ff5a5a" style="background-color: #ff5a5a;display: none;">答题完成</a>
										</td>
									</tr>
								</table>			
							</td>
						</tr>
					</table>		
				</td>
			  </tr>
			</table>
        </div>
        <div id="today" style="visibility: hidden;">
        
        
	   		<div id="todayInfo" >
				<!-- 今日答题结果统计开始 -->
				<table width="320px" height="381px" border="0" cellspacing="0" cellpadding="0" id="left">
					<tr>
						<td align="left" colspan="2" class="td-dt"><i class="icon-tongji"></i>今日答题统计</td>
					</tr>
					<%-- <tr>
						<td align="center" width="30%"><span>倒计时:</span></td>
						<td align="center" width="70%" id="djs">
							<div class="colockbox" id="timer">
								<span class="minute">00</span><span class="second">00</span>
							</div>
						</td>
					</tr> --%>
					<tr>
						<td align="center" width="30%">今日已答：</td>
						<td align="center" width="70%" id="answeredNum"><span>0</span></td>
					</tr>
					<tr>
						<td align="center" width="30%">答对：</td>
						<td align="center" width="70%" id="toy"><span>0</span></td>
					</tr>
					<tr>
						<td align="center" width="30%">答错：</td>
						<td align="center" width="70%" id="ton"><span>0</span></td>
					</tr>
					<tr>
						<td align="center" width="30%">跳过：</td>
						<td align="center" width="70%" id="tobreak"><span>0</span></td>
					</tr>
					<tr>
						<td align="center" width="30%">正确率：</td>
						<td align="center" width="70%" id="tob"><span>0%</span></td>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<a id="butInfo" href="javascript:;" data-val="ok" class="qo-ok" data-old-bg="#ae9b84" style="background-color: #ff5a5a;">确定</a>
						</td>
					</tr>
				</table>
				
				<!-- 今日答题结果统计 结束-->
   		</div>
    	</div>
    </div>
</div>
</body>
</html>