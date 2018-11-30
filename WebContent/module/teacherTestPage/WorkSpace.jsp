<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="qc/css/style.css" rel="stylesheet" />
<link href="qc/css/calendar.css" rel="stylesheet" />
<script src="qc/js/jquery-1.7.2.min.js"></script>
    <script src="qc/js/tweenmax.min.js"></script>
    <script src="qc/js/scripts.js"></script>
<style type="text/css">
.childrenxt li{margin:15px 0px;}
body{margin: 0px; font-size: 12px;}
a{ text-decoration:none;color: #333;}
a:hover{ text-decoration:none;color: #333;}
.qqImg{
/* for IE */
  filter:alpha(opacity=0);
  /* CSS3 standard */
  opacity:0.0;
}

	.menu_title{
	
		font-size: 14px;
		font-weight: bold;
	}
</style>
<script>
$(document).ready(function(){
/* 	$("#childrenMain").height($(window).height());
 */	var url='${paramMap.url }';
	//alert(url);
	if(url!=""){
		$("#childrenMain").attr("src","decorateForwardAction.action?code="+url+"&paramMap.userID=${s_userID}&suijichileren="+new Date());	
	}
	$(".left dl dd").click(function(i){
		var id_li_a = $(this).find("a").attr("id");
		if(id_li_a=="prea_"){
			
		}else{
		    $("#childrenMain").attr("src","decorateForwardAction.action?code="+id_li_a+"&paramMap.userID=${s_userID}&suijichileren="+new Date());		
		}
	});
});

	/* 解决头像问题 */
	$(document).ready(function(){
	    $('.left  img').each(function(){               
	        if($(this).attr('src')==''){                   
	            $(this).attr('src','images/default/default_img.jpg');               
	        }           
	    });                   
	}); 

</script>
</head>
<body>
	<div id="layout_mainbody">
		<div class="page-container ssjh" style="padding-bottom: 0px;">
			<div class="ssjh-grxx">
				<div class="left">
					<div style="padding-top: 10px;height: 230px;text-align: center;">
						<img style="width: 128px;height: 128px;" src="${initMap.userInfo.userImg } " onerror="this.src='images/default/default_img.jpg'" />
						<p>名称：${initMap.userInfo.userName}</p>
		                <p>类型：${(initMap.userInfo.userType==1)?'老师':(initMap.userInfo.userType==2?'学生':'管理员')}</p>
		                <p>财富值：${initMap.userInfo.wealth}</p>
		 
		                 <s:if test="initMap.userInfo.qq !='' && initMap.userInfo.qq !=null">
		                <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${initMap.userInfo.qq}&site=qq&menu=yes"><img border="0" src="images/qqLink.gif" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
					     </s:if>
					</div>
					<dl>
						<dt class="menu_title" style="position: relative;">个人空间<i class="icon-menu"></i></dt>
						<dd>
							<a id="${pmsIndex.myWelcome.code}&paramMap.gaShare=1" href="javascript:void(0);">个人中心<i></i><em></em>
							</a>
						</dd>
						<dd>
							<a id="002032005"  href="javascript:void(0);">文章<i></i><em></em>
							</a>
						</dd>
						<dd>
							<a id="002032008"  href="javascript:void(0);">相册<i></i><em></em>
							</a>
						</dd>
						<dd>
							<a id="002032004" href="javascript:void(0);">关注<i></i><em></em>
							</a>
						</dd>
						<dd>
							<a id="002032002" href="javascript:void(0);">小组<i></i><em></em>
							</a>
						</dd>
						
						<dt class="menu_title" style="position: relative;">网络协作<i class="icon-menu"></i>
						</dt>
						<%-- <dd>
							<a id="${pmsIndex.myNetbk.code}"  href="javascript:void(0);">网络备课(老师有)<i></i><em></em>
							</a>
						</dd> --%>
						<%-- <s:if test="session.s_userType == 1 ">
							<dd>
								<a  id="prea_" target="_block" href="pcp://start">备课中心<i></i><em></em>
								</a>
							</dd>
							<dd>
								<a id="002032010"  href="javascript:void(0);">探究热身<i></i><em></em>
								</a>
							</dd>
						</s:if> --%>
						<dd>
							<a id="002032001" href="javascript:void(0);">探究广场<i></i><em></em>
							</a>
						</dd>
						<dd>
							<a id="002032003" href="javascript:void(0);">我的资源<i></i><em></em>
							</a>
						</dd>
						
						<dt class="menu_title" style="position: relative;">个人管理<i class="icon-menu"></i>
						</dt>
						<dd>
							<a id="002032006"  href="javascript:void(0);">评论<i></i><em></em>
							</a>
						</dd>
						<dd>
							<a id="002032009"  href="javascript:void(0);">信息设置<i></i><em></em>
							</a>
						</dd>
						
					</dl>
				</div>
				<div class="right" style="height: auto;overflow: inherit;">
					<iframe id="childrenMain" name="childrenMain" scrolling="no" marginheight="0" marginwidth="0" frameborder="0" src="decorateForwardAction.action?code=002032000&paramMap.gaShare=1&paramMap.userID=${s_userID}" width="715px" height='870px'  ></iframe>
				</div>
				
			</div>
		</div>
	</div>

</body>
</html>