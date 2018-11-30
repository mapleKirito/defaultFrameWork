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
	/* document.getElementById("gridTree").height="320px"; */
	var ujdata = {
		//表单ID
		formID:'actionForm',
	    globalParam:$("#actionForm").formSerialize(),
	    //type ：first,last
	    //order ：a(升序),d(降序)
    	//serialno:{name:'编号',type:'first',width:'10%',order:'a'},			    
	    //first,last
    	checkbox:{name:'',type:'first',width:'5%'},
       	shortcut:{
       		name:'操作',
   	    	url:'decorateForwardAction.action',
   	    	width:'25%',
   	    	event:[
       			{
           			operate:'modify',name:'${pmsIndex.sys_role_modify.name}',
           			disabled:'false',isvalid:'${!empty pmsIndex.sys_role_modify}',
           			param:'code=${pmsIndex.sys_role_modify.code}'
               	},
       			{
           			operate:'detail',name:'${pmsIndex.sys_role_detail.name}',
           			disabled:'false',isvalid:'${!empty pmsIndex.sys_role_detail}',
           			param:'code=${pmsIndex.sys_role_detail.code}'
               	},
       			{
           			operate:'grant',name:'${pmsIndex.sys_role_grant.name}',
           			disabled:'false',isvalid:'${!empty pmsIndex.sys_role_grant}',
           			param:'code=${pmsIndex.sys_role_grant.code}'
               	},
       			{
           			operate:'del',name:'${pmsIndex.sys_role_delete.name}',
           			disabled:'true',isvalid:'${!empty pmsIndex.sys_role_delete}',
           			param:'code=${pmsIndex.sys_role_delete.code}'
               	}
   	        ] 
   	    },
    	columnDesc:{
	    	//列表要显示的列（在json中对应的key）
			showColumn: ['roleName','roleDesc'],
			//列表头显示名称
			columnName:   ['角色名称','角色描述'],
			//列表头宽度
			columnWidth:   ['35%','35%'],
			//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
			//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
			primkeyColumn:["roleID","roleName"],
			//要增加链接的列，可以为多个
			linkColumn:[{name:'',url:'',param:''}]
    	},		
    	ajax:{
        	url:'ajaxAction.action',
        	data:'code=${code}'
	    },
	    //是否有分页工具条
	    isPagination:'true',	    
    	paginationData:{
			pageSize:'6'
    	}		    		 
	};
	var joption = {
	};
	$('#gridTree').gridTB(ujdata,joption);	
	$('#delete_role').screenTB({
		windowDocument:window.parent.document,
		width:'250',
		height:'130',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'alert',
		iframeSrc:''				
		},{
		clickEvent:function(data){
			if ($("#gridTree tbody input[type='checkbox']:checked").size() == 0){
				data = $.extend(data,{content:'请选择您要删除的角色！'})
			}
			else{
				$.extend(data,{returnValue:'true'})
				var faction = $("#actionForm").attr("action");
				$("#actionForm").attr("action",faction +"?code=${pmsIndex.sys_role_delete.code}");
				$("#actionForm").submit();
			}
		}
	});
});
</script>
<style type="text/css">
.SkyTableLine tr td a img,.SkyTableLine tr td a span{vertical-align: middle;}
</style>
</head>
<body>
 <form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="list-table" >
	<tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;   background-repeat:repeat;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="SkyTableLine" >
				<tr>
					<td>
			 			<div class="lt-title">${pmsIndex.sys_role_mgr.name}</div>
						<div class="lt-command">
		 					<s:if test="pmsIndex.sys_role_create">
		 						<a href="decorateForwardAction.action?code=${pmsIndex.sys_role_create.code}" class="fade-button" data-old-bg="rgb(124, 109, 91)" style="background-color: rgb(124, 109, 91);">
								 	${pmsIndex.sys_role_create.name}+
							 	</a>
						 	</s:if>
					 	</div>
					</td>
				</tr>
		  	</table> 
		  </div>    
       </td>
   </tr>
     <tr>
        <td class="tableCcenter">
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine" style="border-collapse: collapse;border: 1px solid #dfdfdf;">
                <tr>
                     <td  valign="top" colspan="6" id="paginationList" class="MeNewTDLine"><div id="gridTree">  </div></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
</body>
</HTML>
