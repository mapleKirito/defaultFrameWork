<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<%
        String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>
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
		tableShowColumn: ['nodeNodeName','nodeStatus'],
		//列表头显示名称
		tableColumnName:   ['栏目名称','栏目状态'],
		//列表头宽度
		tableColumnWidth:   ['50%','60%'],
		//可以作为主键的类，在页面传送的过程中为paramMap.key{1}(主键个数值)=value的形式
		//多个主键的时候为["orgID","orgCode"]:paramMap.key1=value&paramMap.key2=value
		primkeyColumn:["nodeID"],
		//要增加链接的列，可以为多个
		tableLinkColumn:[],
		//要进行树型显示的列，支持一列
		treeShowColumn:'nodeNodeName',
		//树型菜单，起始根值
		treeNodeStartValue:'0',
		//属性菜单子列
		treeChildColumn:'nodeID',
		//属性菜单父列
		treeParendColumn:'nodeParentID',
		ajax:{
			
			url:'ajaxAction.action', 
			
			data:'code=${pmsIndex.sys_role_node_selected.code}&paramMap.roleID=${paramMap.roleID}&paramMap.roleParentID=${paramMap.roleParentID}'
		}
		//tableTreeData:eval(info)
	};
	
	var jinitData = {
		
		url:'ajaxAction.action',
		
		type:'post',
		
		timeout:'60000',
		
		data:'code=${pmsIndex.sys_role_node_mapper.code}&paramMap.roleID=${paramMap.roleID}&paramMap.roleRelation=${paramMap.roleRelation}',
		
		dataType:'json',
		
		beforeSend:function(request){},
		
		complete:function(request,textStatus){},
		
		success:function(jsonData,textStatus){
			
			
			if (textStatus == "success"){
				$("#gridTreeTable tbody tr .jq_treeCheckbox").each(function(){
					var cval = $(this).val();
					var roleID = $("#roleID").val();
					if (jsonData.data){
						jrinitData = jsonData.data;
						for (var i=0; i<jsonData.data.length;i++){
							var unmRoleVal = jsonData.data[i].unmRoleID;
							var unmNodeVal = jsonData.data[i].unmNodeID;
							if (roleID && roleID ==unmRoleVal 
									&& cval && unmNodeVal && unmNodeVal == cval){
								$(this).attr("checked","checked");
							}
							else if(cval && unmNodeVal && unmNodeVal == cval){
								$(this).attr("checked","checked");
								$(this).attr("disabled","true");
							}
						}
					} 
				});		
						
			}
		},
		
		error:function(request,textStatus,error){}
	};	
	
	var joption = {
		columnAlias:function(col,val){
			if(col == 'nodeStatus')
			{
				if (val == '1')
					val = "<font color='green'><b>启用</b></font>";
				else if (val == '0')
					val =  "<font color='red'><b>禁用</b></font>";
			}
			return val;
		},			
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
<input type="hidden" name="paramMap.roleID" id="roleID" value="${paramMap.roleID}">
<input type="hidden" name="code" value="${pmsIndex.sys_role_node_bind.code}">
<input type="hidden" name="paramMap.roleRelation" id="roleRelation" value="${paramMap.roleRelation}">
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_role_node_bind.imitationStep}"> 
<input type="hidden" name="paramMap.treeUncheckedVal" id="treeUncheckedVal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
    <tr>
        <td class="tableCleft">&nbsp;</td>
        <td class="tableCcenter">
          <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine">
			 <tr class="MeNewTDLine" align="center">
				<td>
			    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
			         <tr>
			           	<td class="SkyTDLine" align="left" style="background:#9CC7FF;height:20;" >
				 			<input type="checkbox" id="selectAll">全选
				     	</td>
			           </tr>
						<tr>
							<td align="left" class="SkyTDLine">栏目名称：${paramMap.roleName}</td>
						</tr>
			         </table>
				</td>
			</tr>
            <tr>
                <td valign="top" id="gridTree" class="MeNewTDLine"></td>
            </tr>
			<tr class="MeNewTDLine" align="center">
				<td class="SkyTDLine" height="20"><input
					type="submit" name="BtnOk" value="绑定" id="BtnOk"
					class="SkyButtonBlur"
					onMouseOut="this.className='SkyButtonBlur'"
					onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input
					type="button" name="BtnOk" value="返回" id="BtnOk"
					class="SkyButtonBlur"
					onMouseOut="this.className='SkyButtonBlur'"
					onMouseOver="this.className='SkyButtonFocus'"
					onclick="window.location.href ='decorateForwardAction.action?code=${pmsIndex.sys_role_mgr.code}'" />
                </td>
			</tr>
            </table>
        </td>
        <td class="tableCright">&nbsp;</td>
    </tr>
</table>
</form>
</body>
</HTML>
