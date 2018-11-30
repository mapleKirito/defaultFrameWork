<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title>${promptInfo.totalDescInfo}</title>
<head>
<script language="javascript" src="<%=request.getContextPath()%>/js/formValidator.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/formValidatorRegex.js" type="text/javascript"></script>
<style type="text/css">
.w744{width:722px;}
h3.type4{ font-size:12px;color:#555;height:32px; line-height:32px; background:#eee; text-indent:1em; font-weight:normal}
.info .setUl { PADDING-BOTTOM: 25px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; HEIGHT: auto; OVERFLOW: hidden; PADDING-TOP: 3px }
.info .setUl LI { WIDTH: 100%; OVERFLOW: hidden }
.info .setUl LI A { PADDING-BOTTOM: 5px; PADDING-LEFT: 15px; WIDTH: 100%; PADDING-RIGHT: 15px; DISPLAY: inline-block; HEIGHT: 100%; COLOR: #555555; PADDING-TOP: 5px }
.info .setUl LI A:hover { BACKGROUND: #f5f5f5 }
.info .setUl LI A.hover { BACKGROUND: #f5f5f5 }
.info .informUl { PADDING-BOTTOM: 10px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; HEIGHT: auto; OVERFLOW: hidden; PADDING-TOP: 10px }
.info .informUl LI { PADDING-BOTTOM: 10px; PADDING-LEFT: 15px; PADDING-RIGHT: 15px; PADDING-TOP: 10px }
.info .underline { BORDER-BOTTOM: #999999 1px dotted; HEIGHT: auto; OVERFLOW: hidden }
.info .apply { PADDING-LEFT: 15px; BACKGROUND: url(/bsms/space/setico.gif) no-repeat left center; COLOR: #347ab8 }
.info .edit { PADDING-LEFT: 15px; BACKGROUND: url(/bsms/space/editico.gif) no-repeat left center; COLOR: #347ab8 }
.info .setPic { MARGIN: 20px auto; WIDTH: 702px; HEIGHT: 440px; OVERFLOW: hidden }
</style>
</head>
<body>
  <div class="w744 fr pdt15 info">
        	<h3 class="type4">基本信息</h3>
            <ul class="informUl">
            	<li><a id="to_user_img" href="javascript:void(0);">修改头像</a></li>
            	<li>用户名：         ${initMap.si.userAccount}</li>
            	<li>
            		<form action="#" method="post" onsubmit="return to_ajax(this)">
            		<span id="0">
            			真实姓名：      ${initMap.si.userName}
            		</span>
            		<a href="javascript:void(0);" class="edit fr infoEditName">编辑</a>
            		</form>
            	</li>
            	<li>
            		<form action="#" method="post" onsubmit="return to_ajax(this)">
            		<span id="0">
            			空间名称：      ${initMap.si.spaceName}
            		</span>
            		<a href="javascript:void(0);" class="edit fr infoEditSpace">编辑</a>
            		</form>
            	</li>
                <li>
                	<form action="#" method="post" onsubmit="return to_ajax(this)">
                	<span id="0">
                    	性　　别：${initMap.si.userGender==1?'男':'女'}
                                    							         
                    </span>
                	<a href="javascript:void(0);" class="edit fr infoEditSex">编辑</a>
                    </form>
                </li>
                                <li>
                	<form action="/index.php?r=center/person/Account/AjaxType" method="post" onsubmit="return to_ajax(this)">
                	<span id="0">
                    	身　　份：${initMap.si.userType==1?'教师':(initMap.si.userType==2?'学生':'机构')}
                    </span>
                	<a href="javascript:void(0);" class="edit fr infoEditType">编辑</a>
                    </form>
               </li>
               <li>
               		<form action="#" method="post" onsubmit="return to_ajax(this)">
            		<span id="0">
            			邮　　箱：      ${initMap.si.userEmail==""?'该用户暂未绑定邮箱':initMap.si.userEmail}
            		</span>
            		<a href="javascript:void(0);" class="edit fr infoEditEmail">编辑</a>
            		</form>
               </li>
            <li>
                	<form action="#" method="post" onsubmit="return to_ajax(this)">
            		<span id="0">
            			手　　机：      ${initMap.si.userMobilePhone==""?'该用户暂未绑定手机号':initMap.si.userMobilePhone}
            		</span>
            		<a href="javascript:void(0);" class="edit fr infoEditMobilePhone">编辑</a>
            		</form>
            </li>
             <li>
                	<form action="#" method="post" onsubmit="return to_ajax(this)">
            		<span id="0">
            			推送关键字：      ${initMap.si.spaceLike==""?'没有关键字':initMap.si.spaceLike}
            		</span>
            		<a href="javascript:void(0);" class="edit fr infoEditSpaceLike">编辑</a>
            		</form>
            </li>
            <li>
                	<form action="#" method="post" onsubmit="return to_ajax(this)">
            		<span id="${initMap.si.userArea }" ar="${initMap.si.userAreaName}" sc="${initMap.si.userSchoolName }" >
            			地区：      ${initMap.si.userAreaName==""?'没有地区信息':initMap.si.userAreaName}<br/><br/>
            			机构：      ${initMap.si.userSchoolName==""?'没有机构信息':initMap.si.userSchoolName}
            		</span>
            		<a href="javascript:void(0);" class="edit fr infoEditArea">编辑</a>
            		</form>
            </li>
            </ul>
                       <%--  <h3 class="type4">班级信息</h3>
            <ul class="informUl">
            	<li class="underline"><span class="fl">所在学校：      ${initMap.si.userSchool}</span><a href="/index.php?r=center/person/JoinSchool/JoinSchool" class="apply fr">申请转校</a></li>
                <li><span class="fl">所在班级：      ${initMap.si.userClass}</span><a href="/index.php?r=center/person/JoinClass" class="apply fr">申请转班</a></li>
            </ul> --%>
            
<script type="text/javascript">
$("#to_user_img").click(function(){
	$("#space_info").load("decorateForwardAction.action?code=-600102&suiji="+new Date().getTime());
	$("#main_info").hide();
	$("#space_info").show().css({
		"height":"610px"
  	});
});
$(document).ready(function(){	
	
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示');},onsuccess:function(){}}); 
	$("input[name='userEmail']").formValidator({}).regexValidator({regexp:"email",datatype:"enum",onerror:"文件格式不正确"});
	$("input[name='userMobilePhone']").formValidator({}).regexValidator({regexp:"mobile",datatype:"enum",onerror:"文件格式不正确"});
	
});
function to_ajax(obj){
	var currentTime= new Date().getTime();
	var html="";
	var url='ajaxAction.action?code=-6001&suiji='+currentTime;
	var data = $(obj).find("span").find("#cg").val();
	var name=$(obj).find("span").find("#cg").attr("name");
	if(data==null||name==null){
		var data1=$(obj).find("span").find("#ar").val();
		var data2=$(obj).find("span").find("#sc").val();
		url+='&paramMap.changeName=ar&paramMap.area='+data1+'&paramMap.school='+data2;
	}else{
		data = encodeURI(encodeURI(data)); 
		url+='&paramMap.changeName='+name+'&paramMap.'+name+'='+data;
	}
	
	$.ajax({
		url:		url,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success"){
				var t_obj=$('.infoEditName');
				if($(obj).find("span").find("#cg").attr("name")=="userName"){
					t_obj=$('.infoEditName');
					html="真是姓名："+$(obj).find("span").find("#cg").val();
				}
				if($(obj).find("span").find("#cg").attr("name")=="userSpace"){
					t_obj=$('.infoEditSpace');
					html="空间名称："+$(obj).find("span").find("#cg").val();
				}
				if($(obj).find("span").find("#cg").attr("name")=="userGender"){
					t_obj=$('.infoEditSex');
					html="性　　别："+($(obj).find("span").find("#cg").val()==1?'男':'女');
				}
				if($(obj).find("span").find("#cg").attr("name")=="userType"){
					t_obj=$('.infoEditType');
					html="身　　份："+($(obj).find("span").find("#cg").val()==1?'教师':($(obj).find("span").find("#cg").val()==2?'学生':'机构'));
				}
				if($(obj).find("span").find("#cg").attr("name")=="userEmail"){
					t_obj=$('.infoEditEmail');
					html="邮　　箱："+$(obj).find("span").find("#cg").val();
					if($(obj).find("span").find("#cg").val()!=""){
						var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
						if (!filter.test($(obj).find("span").find("#cg").val())){
							alert('您的电子邮件格式不正确');
							return false;
						}			
					}
				}
				if($(obj).find("span").find("#cg").attr("name")=="userMobilePhone"){
					t_obj=$('.infoEditMobilePhone');
					html="手　　机："+$(obj).find("span").find("#cg").val();
					if($(obj).find("span").find("#cg").val()!=""){
						var filter = /^1[3|4|5|8][0-9]\d{4,8}$/;
						if (!filter.test($(obj).find("span").find("#cg").val())){
							alert('您的手机格式不正确');
							return false;
						}
					}
					

						 
					
				}
				if($(obj).find("span").find("#cg").attr("name")=="spaceLike"){
					t_obj=$('.infoEditSpaceLike');
					html="推送关键字："+$(obj).find("span").find("#cg").val();
				}
				if($(obj).find("span").find("#ar").attr("name")=="area"){
					t_obj=$('.infoEditArea');
					html="地区："+$(obj).find("span").attr("ar");
					html+='<br/><br/>'+"机构："+$(obj).find("span").attr("sc");
				}
				$('#CancelEdit').remove();
				var span_obj=t_obj.parent().find('span').first();
				span_obj.html(html);
				t_obj.show();
			}
		},
		error:function(request,textStatus,error){}
	}); 
	isEdit=false;
	return false;
}
       
var isEdit=false;

$('.infoEditName').click(function(){
	if(!isEdit){
		isEdit=true;
		var t_obj=$(this);
		var span_obj=t_obj.parent().find('span');
		var html='';
		html='<input id="cg" type="text" name="userName" value="${initMap.si.userName}" />';
		html='真实姓名：      '+html;
		var button='<span style="float:right" id="CancelEdit"> <input class="inp_blue1 f14" type="submit" value="修改"> <input class="inp_blue1 f14" onclick="CancelEdit0(\''+encodeURI(span_obj.text())+'\')" type="button" value="取消"></span>'
		span_obj.html(html);
		span_obj.after(button);
		t_obj.hide();
	}
});

function CancelEdit0(text){
	isEdit=false;
	text=decodeURI(text);
	$('#CancelEdit').remove();
	var t_obj=$('.infoEditName');
	var span_obj=t_obj.parent().find('span');
	span_obj.text(text);
	t_obj.show();
	
}
$('.infoEditSex').click(function(){
	if(!isEdit){
		isEdit=true;
		var t_obj=$(this);
		var span_obj=t_obj.parent().find('span');
		var id=span_obj.attr('id');
		var option=new Array();
		option[1]='男';
		option[0]='女';
		var html='';
		for(var i=0;i<option.length;i++){
			var selected='';
			if(id!=undefined && id==i)selected='selected';
			html+='<option  value="'+i+'" '+selected+'>'+option[i]+'</option>';
		}
		html='<select id="cg" name="userGender" class="inp">'+html+'</select>';
		html='性　　别：      '+html;
		var button='<span style="float:right" id="CancelEdit"> <input class="inp_blue1 f14" type="submit" value="修改"> <input class="inp_blue1 f14" onclick="CancelEdit1(\''+encodeURI(span_obj.text())+'\')" type="button" value="取消"></span>'
		span_obj.html(html);
		span_obj.after(button);
		t_obj.hide();
	}
});
function CancelEdit1(text){
	isEdit=false;
	text=decodeURI(text);
	$('#CancelEdit').remove();
	var t_obj=$('.infoEditSex');
	var span_obj=t_obj.parent().find('span');
	span_obj.text(text);
	t_obj.show();
	
}

$('.infoEditType').click(function(){
	if(!isEdit){
		isEdit=true;
		var t_obj=$(this);
		var span_obj=t_obj.parent().find('span');
		var id=span_obj.attr('id');
		var option=new Array();
		option[3]='机构';
		option[2]='测试';
		option[1]='学生';
		option[0]='教师';
		var html='';
		for(var i=0;i<option.length;i++){
			if(i==2){
				continue;
			}
			var selected='';
			if(id!=undefined && id==i)selected='selected';
			html+='<option value="'+(i+1)+'" '+selected+'>'+option[i]+'</option>';
		}
		html='<select id="cg" name="userType" class="inp">'+html+'</select>';
		html='身　　份：      '+html;
		var button='<span style="float:right" id="CancelEdit"> <input class="inp_blue1 f14" type="submit" value="修改"> <input class="inp_blue1 f14" onclick="CancelEdit2(\''+encodeURI(span_obj.text())+'\')" type="button" value="取消"></span>'
		span_obj.html(html);
		span_obj.after(button);
		t_obj.hide();
	}
});
function CancelEdit2(text){
	isEdit=false;
	text=decodeURI(text);
	$('#CancelEdit').remove();
	var t_obj=$('.infoEditType');
	var span_obj=t_obj.parent().find('span');
	span_obj.text(text);
	t_obj.show();
	
}

$('.infoEditEmail').click(function(){
	if(!isEdit){
		isEdit=true;
		var t_obj=$(this);
		var span_obj=t_obj.parent().find('span');
		var html='';
		html='<input id="cg" type="text" name="userEmail" value="${initMap.si.userEmail}" />';
		html='邮　　箱：      '+html;
		var button='<span style="float:right" id="CancelEdit"> <input class="inp_blue1 f14" type="submit" value="修改"> <input class="inp_blue1 f14" onclick="CancelEdit3(\''+encodeURI(span_obj.text())+'\')" type="button" value="取消"></span>'
		span_obj.html(html);
		span_obj.after(button);
		t_obj.hide();
	}
});

function CancelEdit3(text){
	isEdit=false;
	text=decodeURI(text);
	$('#CancelEdit').remove();
	var t_obj=$('.infoEditEmail');
	var span_obj=t_obj.parent().find('span');
	span_obj.text(text);
	t_obj.show();
	
}
$('.infoEditMobilePhone').click(function(){
	if(!isEdit){
		isEdit=true;
		var t_obj=$(this);
		var span_obj=t_obj.parent().find('span');
		var html='';
		html='<input id="cg" type="text" name="userMobilePhone" value="${initMap.si.userMobilePhone}" />';
		html='手　　机：     '+html;
		var button='<span style="float:right" id="CancelEdit"> <input class="inp_blue1 f14" type="submit" value="修改"> <input class="inp_blue1 f14" onclick="CancelEdit4(\''+encodeURI(span_obj.text())+'\')" type="button" value="取消"></span>'
		span_obj.html(html);
		span_obj.after(button);
		t_obj.hide();
	}
});

function CancelEdit4(text){
	isEdit=false;
	text=decodeURI(text);
	$('#CancelEdit').remove();
	var t_obj=$('.infoEditMobilePhone');
	var span_obj=t_obj.parent().find('span');
	span_obj.text(text);
	t_obj.show();
	
}
$('.infoEditSpaceLike').click(function(){
	if(!isEdit){
		isEdit=true;
		var t_obj=$(this);
		var span_obj=t_obj.parent().find('span');
		var html='';
		html='<input id="cg" type="text" name="spaceLike" value="${initMap.si.spaceLike}" />';
		html='推送关键字&nbsp<font color="red">(多个关键字用英文逗号“,”隔开)</font>：     '+html;
		var button='<span style="float:right" id="CancelEdit"> <input class="inp_blue1 f14" type="submit" value="修改"> <input class="inp_blue1 f14" onclick="CancelEdit5(\''+encodeURI(span_obj.text())+'\')" type="button" value="取消"></span>'
		span_obj.html(html);
		span_obj.after(button);
		t_obj.hide();
	}
});

function CancelEdit5(text){
	isEdit=false;
	text=decodeURI(text);
	$('#CancelEdit').remove();
	var t_obj=$('.infoEditSpaceLike');
	var span_obj=t_obj.parent().find('span');
	span_obj.text(text);
	t_obj.show();
	
}

$('.infoEditSpace').click(function(){
	if(!isEdit){
		isEdit=true;
		var t_obj=$(this);
		var span_obj=t_obj.parent().find('span');
		var html='';
		html='<input id="cg" type="text" name="userSpace" value="${initMap.si.spaceName}" />';
		html='空间名称：      '+html;
		var button='<span style="float:right" id="CancelEdit"> <input class="inp_blue1 f14" type="submit" value="修改"> <input class="inp_blue1 f14" onclick="CancelEdit6(\''+encodeURI(span_obj.text())+'\')" type="button" value="取消"></span>'
		span_obj.html(html);
		span_obj.after(button);
		t_obj.hide();
	}
});

function CancelEdit6(text){
	isEdit=false;
	text=decodeURI(text);
	$('#CancelEdit').remove();
	var t_obj=$('.infoEditSpace');
	var span_obj=t_obj.parent().find('span');
	span_obj.text(text);
	t_obj.show();
	
}

$('.infoEditArea').click(function(){
	if(!isEdit){
		isEdit=true;
		var currentTime= new Date().getTime();
		var t_obj=$(this);
		var span_obj=t_obj.parent().find('span');
		var id=span_obj.attr('id');
		var html='<option value=""">请选择所在地区</option>';
		$.ajax({
			url:		'ajaxAction.action?code=-0005&suiji='+currentTime,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					for (var i=0; i<jsonData.data.length;i++){
						var areaID = jsonData.data[i].areaID;
						var areaName = jsonData.data[i].areaName;
						html+='<option value="'+areaID+'">'+areaName+'</option>';
					}
					html='<select id="ar" name="area" class="inp">'+html+'</select>';
					html='地区：      '+html+'<br/><br/>';
					
					var html2='<option value=""">请选择所在机构</option>';
					$.ajax({
						url:		'ajaxAction.action?code=-0006&paramMap.areaID='+id+'&suiji='+currentTime,
						type:	    'post',
						timeout:	'60000',
						data:	Array(),
						dataType:	'json',
						beforeSend:function(request){},
						complete:function(request,textStatus){},
						success:function(jsonData,textStatus){
							if (textStatus == "success"){
								for (var i=0; i<jsonData.data.length;i++){
									var schID = jsonData.data[i].schID;
									var schName = jsonData.data[i].schName;
									html2+='<option value="'+schID+'">'+schName+'</option>';
								}
								html2='<select id="sc" name="school" class="inp" >'+html2+'</select>';
								html+='机构：      '+html2;
								var button='<span style="float:right" id="CancelEdit"> <input class="inp_blue1 f14" type="submit" value="修改"> <input class="inp_blue1 f14" onclick="CancelEdit7(\''+encodeURI(span_obj.html())+'\')" type="button" value="取消"></span>'
								span_obj.html(html);
								span_obj.after(button);
								t_obj.hide();
								
								$("#ar").live("change",function(){
									span_obj.attr('id',$(this).val());
									span_obj.attr('ar',$(this).find("option:selected").text());
									$.ajax({
										url:		'ajaxAction.action?code=-0006&paramMap.areaID='+$(this).val()+'&suiji='+currentTime,
										type:	    'post',
										timeout:	'60000',
										data:	Array(),
										dataType:	'json',
										beforeSend:function(request){},
										complete:function(request,textStatus){},
										success:function(jsonData,textStatus){
											if (textStatus == "success"){
												$("#sc").html('');
												for (var i=0; i<jsonData.data.length;i++){
													var schID = jsonData.data[i].schID;
													var schName = jsonData.data[i].schName;
													$("#sc").append('<option value="'+schID+'">'+schName+'</option>');
												}		
											}
											span_obj.attr('sc',$("#sc").find("option:selected").text());
										},
										error:function(request,textStatus,error){}
									});
								})
								
								$("#sc").live("change",function(){
									span_obj.attr('sc',$(this).find("option:selected").text());
								})
							}
						},
						error:function(request,textStatus,error){}
					});
					
				}
			},
			
			error:function(request,textStatus,error){}
		});
	}
	
	
	
});

function CancelEdit7(text){
	isEdit=false;
	text=decodeURI(text);
	$('#CancelEdit').remove();
	var t_obj=$('.infoEditArea');
	var span_obj=t_obj.parent().find('span');
	span_obj.html(text);
	t_obj.show();
	
}
</script> 
            </div>

</body>
</html>
