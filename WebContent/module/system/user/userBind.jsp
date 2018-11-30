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
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.grid.tree.js" type="text/javascript"></script>
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
		tableShowColumn: ['roleName'],
		//列表头显示名称
		tableColumnName:   ['角色名称'],
		//列表头宽度
		tableColumnWidth:   ['70%'],
		//可以作为主键的类，在页面传送的过程中为paramMap.key{1}(主键个数值)=value的形式
		//多个主键的时候为["orgID","orgCode"]:paramMap.key1=value&paramMap.key2=value
		primkeyColumn:["roleID"],
		//要增加链接的列，可以为多个
		tableLinkColumn:[],
		//要进行树型显示的列，支持一列
		treeShowColumn:'roleName',
		//树型菜单，起始根值
		treeNodeStartValue:'0',
		//属性菜单子列
		treeChildColumn:'roleID',
		//属性菜单父列
		treeParendColumn:'roleParentID',
		ajax:{
			
			url:'ajaxAction.action', 
			
			data:'code=${pmsIndex.sys_user_role_info.code}&paramMap.userCreator=${paramMap.userCreator}'//列出用户可选的用户组，只能在用户创建者所属用户组中进行选择
		}
		//tableTreeData:eval(info)
	};
	var jinitData = {
		
		url:		'ajaxAction.action',
		
		type:	    'post',
		
		timeout:	'60000',
		
		data:	'code=${pmsIndex.sys_user_role_info_selected.code}&paramMap.userID=${paramMap.userID}',//勾选出user已绑定的userGroup
		
		dataType:	'json',
		
		beforeSend:function(request){},
		
		complete:function(request,textStatus){},
		
		success:function(jsonData,textStatus){
			
			
			if (textStatus == "success"){
				$("#gridTreeTable tbody tr .jq_treeCheckbox").each(function(i){
					var cval = $(this).val().replace("roleID=","");;
					var userID = $("#userID").val();
					if (jsonData.data){
						for (var i=0; i<jsonData.data.length;i++){
							var urmUserID = jsonData.data[i].urmUserID;
							var urmRoleID = jsonData.data[i].urmRoleID;
							if (userID && userID ==urmUserID 
									&& cval && urmRoleID && urmRoleID == cval){
								$(this).attr("checked","checked");
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
			}
			else{
				$("#gridTreeTable tbody tr .jq_treeCheckbox[type='checkbox']:checked").each(function(){
					if ($(this).attr("id").indexOf(id) > -1){
						$(this).attr("checked",false);
					}
				});
			}
		}
	};
	$('#gridTree').gridTreeTB(jdata,joption);
	$('#selectAll').click(function(){
		var $ca = $(this);
		if ($ca.attr("checked") == true){
			$("#gridTreeTable tbody tr .jq_treeCheckbox[type='checkbox']").each(function(){
					$(this).attr("checked",true);
			});	
		}
		else{
			$("#gridTreeTable tbody tr .jq_treeCheckbox[type='checkbox']").each(function(){
				if($(this).attr("disabled") == false){
					$(this).attr("checked",false);
				}
			});				
		}		
	});	
	
});
</script>
</head>
<body >
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" name="paramMap.userID" id="userID" value="${paramMap.userID}">
<input type="hidden" name="code" value="${pmsIndex.sys_user_bind.code}">
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_user_mgr.imitationStep}"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
			         <tr>
						<td>
							<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0" style="background-color: #F5F9FC;">	
								<tr>
									<!-- <td align="left" class="tatd">角色名称：</td> -->
								</tr>
			          		</table>
			           </tr>
			         </table>
				</td>
			  </tr>
               <tr>
                   <td valign="top" id="gridTree" class="MeNewTDLine"></td>
               </tr>
			   <tr  align="center">
				   <td height="45" style="border:1px solid #bdd7e3;border-top:1px dotted  #CBD2D8;">
                    <input type="submit" name="BtnOk" value="绑定" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
                    <input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();"  />
                   </td>
			    </tr>
           </table>
       </td>
    </tr>
</table>
</form>
</body>
</HTML>
