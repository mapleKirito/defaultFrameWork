<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>

<html>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.dynamic.grid.tree.js" type="text/javascript"></script>

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/styleCate.css" />
<script type="text/javascript">
var jsdata = {
		//表单ID
		formID:'actionForm',
	    globalParam:$("#actionForm").formSerialize(),
		//树是否全部展开true：展开,false:合并
		isOpen:'false',
	    //first,last
    	checkbox:{name:'',type:'first',width:'10%',disabled:'true'},
    	shortcut:{
    		name:'操作',
	    	url:'decorateForwardAction.action',
	    	width:'25%',
	    	event:[
    			{operate:'modify',name:'${pmsIndex.sys_area_modify.name}',disabled:'false',isvalid:'${!empty pmsIndex.sys_area_modify}',param:'code=${pmsIndex.sys_area_modify.code}'},
    			{operate:'detail',name:'${pmsIndex.sys_area_detail.name}',disabled:'false',isvalid:'${!empty pmsIndex.sys_area_detail}',param:'code=${pmsIndex.sys_area_detail.code}'},
    			{operate:'del',name:'${pmsIndex.sys_area_delete.name}',disabled:'true',isvalid:'${!empty pmsIndex.sys_area_delete}',param:'code=${pmsIndex.sys_area_delete.code}'}
	        ]
	    },
	    //父亲节点是否可操作（true：可操作 false：不可操作）
	    isParentNodeOpt:'true',
    	//列表要显示的列（在json中对应的key）
		tableShowColumn: ['areaName'],
		//列表头显示名称
		tableColumnName:   ['地区名称'],
		//列表头宽度
		tableColumnWidth:   ['65%'],
		//可以作为主键的类，在页面传送的过程中为paramMap.key{1}(主键个数值)=value的形式
		//多个主键的时候为["orgID","orgCode"]:paramMap.key1=value&paramMap.key2=value
		primkeyColumn:["areaID","areaSign","areaParentID"],
		//要进行树型显示的列，支持一列
		treeShowColumn:'areaName',
		//树型菜单，起始根值
		treeNodeStartValue:'0',
		//属性菜单子列
		treeChildColumn:'areaID',
		//属性菜单父列
		treeParendColumn:'areaParentID',
		//属性菜单级别
		treeLevel:'areaLevel',
		//属性菜单级别
		treeIsChild:'areaIsChild',
    	ajax:{
			
			url:'ajaxAction.action', 
			
			data:'code=${code}'
		}
    	//tableTreeData:eval(info)
	};
var joptions = {};
$(document).ready(function(){	
	$('#gridTree').gridDynamicTreeTB(jsdata,joptions);	
	$('#delete_org').screenTB({
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
				data = $.extend(data,{content:'请选择您要删除的机构！'})
			}
			else{
				$.extend(data,{returnValue:'true'})
				var faction = $("#actionForm").attr("action");
				$("#actionForm").attr("action",faction +"?code=${pmsIndex.sys_area_delete.code}");
				$("#actionForm").submit();
			}
		}
	});
});

</script>
</head>
<body >
<div id="layout_mainbody" >
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableCcenter list-table" >
	<tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8; background-repeat:repeat;" >
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="SkyTableLine" >
				<tr>
					<td  align="left">
					
						<div class="lt-title">${pmsIndex.sys_area_mgr.name}</div>
						<div class="lt-command">
							<s:if test="pmsIndex.sys_area_create"> 
								<a href="decorateForwardAction.action?code=${pmsIndex.sys_area_create.code}"><span>${pmsIndex.sys_area_create.name}</span></a>
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
                    <td  valign="top" colspan="6" id="paginationList" class="MeNewTDLine lt-command"><div id="gridTree">  </div></td>
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
