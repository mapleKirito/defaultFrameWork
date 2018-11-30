<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<%
        String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.autocomplete.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rsync_progress_bar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/res/category.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.grid.tree_radio.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />

<script type="text/javascript">
$(document).ready(function(){
	var jdata = {
	    globalParam:'',
		//树是否全部展开true：展开,false:合并
		isOpen:'true',
   		//列表树结构显示字段是否有复选框 
   		treeCheckbox: 'true',
   		//父亲节点是否可操作（true：可操作 false：不可操作）
   		isParentNodeOpt:'true',
		//列表要显示的列（在json中对应的key）
		tableShowColumn: ['pmsName'],
		//列表头显示名称
		tableColumnName:   ['全选权限名称'],
		//列表头宽度
		tableColumnWidth:   ['40%'],
		//多个主键的时候为["orgID","orgCode"]:paramMap.key1=value&paramMap.key2=value
		primkeyColumn:["pmsCode"],
		//要增加链接的列，可以为多个
		tableLinkColumn:[],
		//要进行树型显示的列，支持一列
		treeShowColumn:'pmsName',
		//树型菜单，起始根值
		treeNodeStartValue:'0',
		//属性菜单子列
		treeChildColumn:'pmsCode',
		//属性菜单父列
		treeParendColumn:'pmsParentCode',
		ajax:{
			url:'ajaxAction.action', 
			data:'code=${pmsIndex.sys_permission_info.code}&paramMap.roleID=${paramMap.roleID}&paramMap.roleParentID=${paramMap.roleParentID}'
		}
		//tableTreeData:eval(info)
	};
	var jrinitData = {};
	var jinitData = {
		url:'ajaxAction.action',
		type:'post',
		timeout:'60000',
		data:'code=${pmsIndex.sys_role_pms_mapper.code}&paramMap.roleID=${paramMap.roleID}&paramMap.roleRelation=${paramMap.roleRelation}',
		dataType:'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success"){
				$("#pmsCode").val('');
				$("#gridTreeTable tbody tr .jq_treeCheckbox").each(function(){
					var cval = $(this).val().replace("pmsCode=","");
					var roleID = $("#roleID").val();
					if (jsonData.data){
						jrinitData = jsonData.data;
						for (var i=0; i<jsonData.data.length;i++){
							var tmpRoleVal = jsonData.data[i].rpmRoleID;
							var tmpPmsVal = jsonData.data[i].rpmPmsCode;
							if (roleID && roleID ==tmpRoleVal 
									&& cval && tmpPmsVal && tmpPmsVal == cval){
								$(this).attr("checked","checked");
							}
							else if(cval && tmpPmsVal && tmpPmsVal == cval){
								$(this).attr("checked","checked");
								$(this).attr("disabled","disabled");
							}
						}
					} 
				});		
			}
		},
		error:function(request,textStatus,error){}
	};	
	var joption = {
		extendInit:function(){
			$.ajax(jinitData);	
		},
		checkboxClick:function($obj){
			var id = $obj.attr("id");
			var val = $obj.val();
			if ($obj.attr("checked")){
				var arr = id.split("-");
				var tmpid = '';
				for (var i=0; i<arr.length;i++){
					if (i == 0){
						if (id != arr[i]){
							tmpid = arr[i];
							$("#"+tmpid).attr("checked",true);
						}
					}
					else{
						if (id != tmpid + "-" + arr[i]){
							tmpid = tmpid + "-" + arr[i];
							$("#"+tmpid).attr("checked",true);
						}
					}
				}
				$("#gridTreeTable tbody tr .jq_treeCheckbox[type='checkbox']").each(function(){
					if ($(this).attr("id").indexOf(id) > -1){
						$(this).attr("checked",true);
					}
				});
				$("#gridTreeTable tbody tr .jq_treeCheckbox[type='checkbox']").each(function(){
					if ($(this).attr("id").indexOf(id.substring(0,14)) < 0){
						$(this).attr("disabled","disabled");
						$(this).attr("checked",false);
					}else{
						$(this).attr("disabled",false);
					}
				});			
			}
			else{
				$("#treeUncheckedVal").val(function(){
					if (jrinitData){
						for (var i=0; i<jrinitData.length;i++){
							var tmpRoleVal = jrinitData[i].rpmRoleID;
							var tmpPmsVal = jrinitData[i].rpmPmsCode;
							if (tmpPmsVal == val){
								var uv = $(this).val();
								if (!uv)
									$(this).val(tmpPmsVal);
								else
									$(this).val(uv + "," + tmpPmsVal);
							}
						}	
					}
					return $(this).val();
				});			
				$("#gridTreeTable tbody tr .jq_treeCheckbox[type='checkbox']:checked").each(function(){
					if ($(this).attr("id").indexOf(id) > -1){
						$(this).attr("checked",false);
					}
				});
				$("#gridTreeTable tbody tr .jq_treeCheckbox[type='checkbox']").each(function(){
					$(this).attr("disabled",false);
				});
			}
		}
	};
	$('#gridTree').gridTreeTB_radio(jdata,joption);	
});
</script>
</head>
<body >
<div id="layout_mainbody" >
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" name="paramMap.roleID" id="roleID" value="${paramMap.roleID}">
<input type="hidden" name="paramMap.roleParentID" id="roleParentID" value="${paramMap.roleParentID}">
<input type="hidden" name="code" value="${pmsIndex.sys_role_grant.code}">
<input type="hidden" name="paramMap.roleRelation" id="roleRelation" value="${paramMap.roleRelation}">
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_role_mgr.imitationStep}"> 
<input type="hidden" name="paramMap.treeUncheckedVal" id="treeUncheckedVal">
<input type="hidden" name="paramMap.roleName" id="roleName" value="${paramMap.roleName}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
			         <tr>
						<td bgcolor="#ae9b84" style="border-bottom: 1px solid #ffffff;">
							<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0">			         
					     		<tr>
									<td align="left" class="tatd"><span style="color:#ffffff;">角色名称：${paramMap.roleName}</span></td>
								</tr>
							</table>
						</td>
			         </table>
				</td>
			</tr>
            <tr>
                <td valign="top" id="gridTree" class="MeNewTDLine"></td>
            </tr>
			<tr bgcolor="#ae9b84" align="center">
				<td height="45" style="border:1px solid #bdd7e3;border-top:1px dotted  #CBD2D8;">
				<input type="submit" name="BtnOk" value="授权" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />
				&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'"
					onMouseOver="this.className='SkyButtonFocus'" onclick="window.location.href ='decorateForwardAction.action?code=${pmsIndex.sys_role_mgr.code}'" />
                </td>
			</tr>
            </table>
        </td>
    </tr>
</table>
</form>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>

</body>
</HTML>
