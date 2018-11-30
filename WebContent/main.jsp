<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><s:text name="systemName" />
</title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
<link href="css/style.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/style.css"
	rel="stylesheet" />
<script src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-main-tag.js"></script>
<script src="<%=request.getContextPath()%>/js/jq-main.js"></script>
<script type="text/javascript">

function myfun()
{
	var isFlash='${paramMap.flash}';
	var ipPath =window.location.href ;
	var exceptStr=ipPath.indexOf("code=-1700&url=");
	if(exceptStr<0){
		if(isFlash = 1){
			
			
			 var startoint = ipPath.indexOf("path"); 
			 
				 if(startoint>=0){
					 var code="-701";
						ipPath = ipPath.substring(startoint,ipPath.length );
						if(ipPath.indexOf("zizhureshen")>=0){
							code="-17010";
						}else if(ipPath.indexOf("zizhuguang")>=0){
							code="-13899";
						}else if(ipPath.indexOf("zizhuchengguo")>=0){
							code="-14899";
						}else{
							code="-701";
						}
						  $("#mainFrameWelcome").attr("src","decorateForwardAction.action?code="+code+"&"+ipPath);
				 }else{
					  $("#mainFrameWelcome").attr("src","decorateForwardAction.action?code=004");
				 }
	
			 
		}else{
			 $("#mainFrameWelcome").attr("src","decorateForwardAction.action?code=004");
		}
	}
	
}
window.onload=myfun;//不要括号
</script>

<style type="text/css">
#layout_left_pms {
	float: left;
	position: absolute;
	top: -40px;
	left: 0;
	width: 192px;
	height: 100%;
	background: #504538;
	display: block;
	z-index: 2;
}

#lookimage_ {
	position: absolute;
	z-index: 9999;
	overflow: auto;
	text-align: center;
	display: none;
}

#lookimageclose {
	position: absolute;
	z-index: 10000;
	width: 40px;
	height: 40px;
	display: none;
	right: 40px;
	cursor: pointer;
}

.mainloading {
	position: fixed;
	top: 50%;
	left: 50%;
}
</style>
<script type="text/javascript">
function jumpCity(){
	
	 var localIp=GetLocalIPAddr();
		var url=localIp+"/UniteCount-school/ShowDitalServlet?type=City";
	    $("#mainFrameWelcome").attr("src",url);
}
function jumpNext(this_){
	var id=	$(this_).attr("id");
	 var localIp=GetLocalIPAddr();
		var url=localIp+"/UniteCount-school/ShowDitalServlet?type=dis&id="+id;
	    $("#mainFrameWelcome").attr("src",url);
}
function jumpSchool(this_){
	var id=	$(this_).attr("id");
	 var localIp=GetLocalIPAddr();
		var url=localIp+"/UniteCount-school/ShowDitalServlet?type=school&id="+id;
	    $("#mainFrameWelcome").attr("src",url);
}

</script>

</head>

<body >
<input type="hidden"  id="isOpen" value="0">
<input type="hidden"  id="code" value="${param.code }">
<input type="hidden"  id="path" value="${param.path }">
<input type="hidden"  id="pageSize" value="${param.pageSize }">
<input type="hidden"  id="paramMap.path" value="${param.paramMap.path }">
<input type="hidden"  id="paramMap.orCategory" value="${param.paramMap.orCategory }">
<input type="hidden"  id="pageSize" value="${param.pageSize }">
<input type="hidden"  id="type" value="${param.type }">
	<div id="message__" class="showDiv" style="display: none;"></div>
	<div id="lookimage_" class="lookimage_" style="display: none;">
		<img src="" border="0">
	</div>
	<div id="lookimageclose" class="lookimageclose" style="display: none;">
		<img src="images/deleted_1.png" border="0">
	</div>
	<div id="message_only" class="message_only" style="display: none;">
		<s:include value="messonly.jsp"></s:include>
	</div>
	<div id="message_refer" class="message_refer" style="display: none;">
		<s:include value="messrefer.jsp"></s:include>
	</div>
	<div id="screen__">
		<iframe id="iframeScreen__" scrolling="no" frameborder="0"
			style="display: none;"></iframe>
	</div>
	<s:include value="top.jsp"></s:include>
	<div id="layout_left">

		<div class="layout_left_menutab">

			<p class="layout_left_menutab_title">
				<a href="javascript:void(0);" class="on" title="功能"><i class="icon-cat"></i>
				</a> <a href="javascript:void(0);" title="区域"><i class="icon-position"></i>
				</a> <a href="javascript:void(0);" title="学段、年级"><i class="icon-data"></i>
				</a> <a href="javascript:void(0);" title="资源"><i class="icon-list"></i>
				</a>
			</p>
			<div class="left_menutab_body">

				<ul class="menutab_body menu-nav">
					<li class="exhibition" roomtype="exhibition"><a
						href="javascript:void(0);" path=",0,1," key="0" title="文物博览室"
						onclick="message('exhibition',this)">文物博览室<i class="icon-menu"></i><i
							class="icon-menu-arrow"></i> </a>
						<dl class="sub-menu" style="display: none;">

						</dl></li>
					<li class="observation" roomtype="observation"><a
						href="javascript:void(0);" path=",0,219," key="0" title="专题研读室"
						onclick="message('observation',this)">专题研读室<i
							class="icon-menu"></i><i class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu" style="display: none;">

						</dl></li>
					<li class="projection" roomtype="projection"><a
						href="javascript:void(0);" path=",0,213," key="0" title="影像资料室"
						onclick="message('projection',this)">影像资料室<i class="icon-menu"></i><i
							class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu" style="display: none;">

						</dl></li>
					<li class="expand" roomtype="expand"><a
						href="javascript:void(0);" path=",0,206," key="0" title="自主探究室"
						onclick="message('expand',this)">自主探究室<i class="icon-menu"></i><i
							class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu" style="display: none;">

						</dl></li>
					<li class="laboratory" roomtype="laboratory"><a
						href="javascript:void(0);" path=",0,218," key="0" title="教学研究室"
						onclick="message('laboratory',this)">教学研究室<i class="icon-menu"></i><i
							class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu" style="display: none;">

						</dl></li>
					<li class="lovely" roomtype="lovely"><a
						href="javascript:void(0);" path=",0,259," key="0" title="情系家园"
						onclick="message('lovely',this)">情系家园<i class="icon-menu"></i><i
							class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu" style="display: none;">

						</dl></li>
						
				</ul>
				<ul class="menutab_body menu-nav" style="display: none">
					<li class="area" roomtype="area"><a key="0" id="1" class="on" title="中国"
						onclick="findChildArea(this)">中国<i class="icon-menu"></i><i
							class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu">

						</dl></li>

				</ul>
				<ul class="menutab_body menu-nav" style="display: none">
					<li class="middlegrade" roomtype="middlegrade"><a>初中<i
							class="icon-menu"></i><i class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu" style="display: none;">

							<dd subindex="0">
								<a key="2"
									onclick="resType(this,'G_Grade','七年级资源','-901','paramMap.grGrade=311&pageSize=8&type=1');"
									href="javascript:void(0);">七年级</a>
							</dd>
							<dd class="sub_res0  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','七年级资源','-901','paramMap.grGrade=311&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res0  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','七年级资源','-901','paramMap.grGrade=311&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="1">
								<a key="2"
									onclick="resType(this,'G_Grade','八年级资源','-901','paramMap.grGrade=312&pageSize=8&type=1');"
									href="javascript:void(0);">八年级</a>
							</dd>
							<dd class="sub_res1  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','八年级资源','-901','paramMap.grGrade=312&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res1  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','八年级资源','-901','paramMap.grGrade=312&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="2">
								<a key="2"
									onclick="resType(this,'G_Grade','九年级资源','-901','paramMap.grGrade=313&pageSize=8&type=1');"
									href="javascript:void(0);">九年级</a>
							</dd>
							<dd class="sub_res2  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','九年级资源','-901','paramMap.grGrade=313&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res2  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','九年级资源','-901','paramMap.grGrade=313&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
						</dl>
					</li>
					<li class="highgrade" roomtype="highgrade"><a>高中<i
							class="icon-menu"></i><i class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu" style="display: none;">
							<dd subindex="3">
								<a key="2"
									onclick="resType(this,'G_Grade','必修一资源','-901','paramMap.grGrade=321&pageSize=8&type=1');"
									href="javascript:void(0);">必修一</a>
							</dd>
							<dd class="sub_res3  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','必修一资源','-901','paramMap.grGrade=321&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res3  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','必修一资源','-901','paramMap.grGrade=321&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="4">
								<a key="2"
									onclick="resType(this,'G_Grade','必修二资源','-901','paramMap.grGrade=322&pageSize=8&type=1');"
									href="javascript:void(0);">必修二</a>
							</dd>
							<dd class="sub_res4  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','必修二资源','-901','paramMap.grGrade=322&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res4  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','必修二资源','-901','paramMap.grGrade=322&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="5">
								<a key="2"
									onclick="resType(this,'G_Grade','必修三资源','-901','paramMap.grGrade=323&pageSize=8&type=1');"
									href="javascript:void(0);">必修三</a>
							</dd>
							<dd class="sub_res5  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','必修三资源','-901','paramMap.grGrade=323&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res5  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','必修三资源','-901','paramMap.grGrade=323&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="6">
								<a key="2"
									onclick="resType(this,'G_Grade','选修一资源','-901','paramMap.grGrade=331&pageSize=8&type=1');"
									href="javascript:void(0);">选修一</a>
							</dd>
							<dd class="sub_res6  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修一资源','-901','paramMap.grGrade=331&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res6  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修一资源','-901','paramMap.grGrade=331&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="7">
								<a key="2"
									onclick="resType(this,'G_Grade','选修二资源','-901','paramMap.grGrade=332&pageSize=8&type=1');"
									href="javascript:void(0);">选修二</a>
							</dd>
							<dd class="sub_res7  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修二资源','-901','paramMap.grGrade=332&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res7  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修二资源','-901','paramMap.grGrade=332&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="8">
								<a key="2"
									onclick="resType(this,'G_Grade','选修三资源','-901','paramMap.grGrade=333&pageSize=8&type=1');"
									href="javascript:void(0);">选修三</a>
							</dd>
							<dd class="sub_res8  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修三资源','-901','paramMap.grGrade=333&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res8  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修三资源','-901','paramMap.grGrade=333&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="9">
								<a key="2"
									onclick="resType(this,'G_Grade','选修四资源','-901','paramMap.grGrade=334&pageSize=8&type=1');"
									href="javascript:void(0);">选修四</a>
							</dd>
							<dd class="sub_res9  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修四资源','-901','paramMap.grGrade=334&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res9  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修四资源','-901','paramMap.grGrade=334&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="10">
								<a key="2"
									onclick="resType(this,'G_Grade','选修五资源','-901','paramMap.grGrade=335&pageSize=8&type=1');"
									href="javascript:void(0);">选修五</a>
							</dd>
							<dd class="sub_res10  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修五资源','-901','paramMap.grGrade=335&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res10  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修五资源','-901','paramMap.grGrade=335&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
							<dd subindex="11">
								<a key="2"
									onclick="resType(this,'G_Grade','选修六资源','-901','paramMap.grGrade=336&pageSize=8&type=1');"
									href="javascript:void(0);">选修六</a>
							</dd>
							<dd class="sub_res11  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修六资源','-901','paramMap.grGrade=336&pageSize=8&type=1&paramMap.resTypeName=sucai');" style="color: black;" href="javascript:void(0);" title="素材">
									素材
								</a>
							</dd>
							<dd class="sub_res11  sub_res_sub" style="display:none;background:#E7E7E7;color:black;">
								<a path=",0,1,160,163," onclick="resType(this,'G_Grade','选修六资源','-901','paramMap.grGrade=336&pageSize=8&type=1&paramMap.resTypeName=kejian');" style="color: black;" href="javascript:void(0);" title="课件">
									课件
								</a>
							</dd>
						</dl>
					</li>
				</ul>
				<ul class="menutab_body menu-nav" style="display: none">
					<li class="resmedia" roomtype="resmedia"><a>素材<i
							class="icon-menu"></i><i class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu" style="display: none;">
							<dd>
								<a
									onclick="resType(this,'R_Res','高清图片','-1001','paramMap.rrType=1011&pageSize=8&type=1');"
									href="javascript:void(0);">高清图片</a>
							</dd>
							<!-- <dd>
								<a
									onclick="resType(this,'R_Res','3D图片','-1001','paramMap.rrType=1022&pageSize=8&type=1');"
									href="javascript:void(0);">3D图片</a>
							</dd> -->
							<dd>
								<a
									onclick="resType(this,'R_Res','音频','-1001','paramMap.rrType=1073&pageSize=8&type=1');"
									href="javascript:void(0);">音频</a>
							</dd>
							<dd>
								<a
									onclick="resType(this,'R_Res','高清视频','-1001','paramMap.rrType=1084&pageSize=8&type=1');"
									href="javascript:void(0);">高清视频</a>
							</dd>
							<dd>
								<a
									onclick="resType(this,'R_Res','其他','-1001','paramMap.rrType=2002&pageSize=8&type=1');"
									href="javascript:void(0);">其他</a>
							</dd>
						</dl>
					</li>
					<li class="resbook" roomtype="resbook"><a>课件<i
							class="icon-menu"></i><i class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu" style="display: none;">
							<dd>
								<a
									onclick="resType(this,'R_Res','PPT课件','-1001','paramMap.rrType=2041&pageSize=8&type=1');"
									href="javascript:void(0);">PPT课件</a>
							</dd>
							<dd>
								<a
									onclick="resType(this,'R_Res','WORD课件','-1001','paramMap.rrType=2033&pageSize=8&type=1');"
									href="javascript:void(0);">word课件</a>
							</dd>
							<dd>
								<a
									onclick="resType(this,'R_Res','PDF课件','-1001','paramMap.rrType=2055&pageSize=8&type=1');"
									href="javascript:void(0);">PDF课件</a>
							</dd>
							<dd>
								<a
									onclick="resType(this,'R_Res','Flash课件','-1001','paramMap.rrType=2002&pageSize=8&type=1');"
									href="javascript:void(0);">Flash课件</a>
							</dd>
						</dl></li>
				</ul>

			</div>
		</div>
	</div>
	<div id="layout_left_pms" style="display: none;">

		<div class="layout_left_menutab_pms">

			<div class="left_menutab_pms_body">
				<ul class="menutab_body menu-nav">
					<li
						style="line-height: 41px; text-indent: 65px; font-size: 14px; color: white;">${pmsIndex.sys_systempage_mgr.name}</li>
					<li class="left manager" roomtype="manager"><a>科室管理<i
							class="icon-menu"></i><i class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu">


							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.res_exhibition_room_mgr.code}">${pmsIndex.res_exhibition_room_mgr.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.res_observation_room_mgr.code}">${pmsIndex.res_observation_room_mgr.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.res_projection_room_mgr.code}">${pmsIndex.res_projection_room_mgr.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.res_expand_room_mgr.code}">${pmsIndex.res_expand_room_mgr.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.res_laboratory_room_mgr.code}">${pmsIndex.res_laboratory_room_mgr.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.res_lovely_room_mgr.code}">${pmsIndex.res_lovely_room_mgr.name}
								</a>
							</dd>
							
						</dl></li>
					<li class="left setting" roomtype="setting"><a>系统设置<i
							class="icon-menu"></i><i class="icon-menu-arrow"></i>
					</a>
						<dl class="sub-menu">
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.sys_resource_history.code}">${pmsIndex.sys_resource_history.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.sys_resource_news.code}">${pmsIndex.sys_resource_news.name}
								</a>
							</dd>
							 <dd>
									<a href="javascript:void(0);" onclick="tabSetting(this)" id="${pmsIndex.sys_count_mgr.code}" >${pmsIndex.sys_count_mgr.name}
									</a>
								</dd> 
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.sys_role_mgr.code}">${pmsIndex.sys_role_mgr.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.sys_user_mgr.code}">${pmsIndex.sys_user_mgr.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.bsms_category_mgr.code}">${pmsIndex.bsms_category_mgr.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.sys_area_mgr.code}">${pmsIndex.sys_area_mgr.name}
								</a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.sys_operate_log.code}">操作日志 </a>
							</dd>
							<dd>
								<a href="javascript:void(0);" onclick="tabSetting(this)"
									id="${pmsIndex.sys_settings_db_param.code}">系统设置 </a>
							</dd>
                        </dl></li>

				</ul>

			</div>
		</div>
	</div>
	<div id="layout_right">
	
		<iframe height="100%" width="100%" id="mainFrameWelcome"
			name="mainFrameWelcome" scrolling="no" marginheight="0"
			marginwidth="0" allowtransparency="true" hspace="0" frameborder="0"
			src="${param.url==null?paramMap.welcome:param.url }"
			></iframe>

	</div>

	<input type="hidden" id="windowheight" />
	<input type="hidden" id="mainFrameheight" />
	<input type="hidden" id="windowwidth" />
	<input type="hidden" id="mainFramewidth" />
	<script src="js/tweenmax.min.js"></script>
	<script src="js/scripts.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#windowheight").val($(window).height());
			$("#mainFrameheight").val($(window).height() - 48 - 120);
			$("#windowwidth").val($(window).width());
			$("#mainFramewidth").val($(window).width() - 618);

			$("dl.sub-menu>dd").hover(function() {
				//查询子集分类  传入相关ID
				$("#div_sub_submenu").hide();
				var index = $("dl.sub-menu>dd").index(this);
				var submenus = $(this).find("textarea.sub-menu-data");
				var thirdMenu = $("#div_sub_submenu");
				var thirdMenuContainer = $("#div_sub_submenu>ul");
				var $this = $(this);
				if (submenus && submenus.length > 0) {
					thirdMenuContainer.empty();
					$(submenus.val()).appendTo(thirdMenuContainer);
					thirdMenu.css({
						top : 130 + index * 35
					}).show();
				}
			});
		});
	</script>
</body>
</html>