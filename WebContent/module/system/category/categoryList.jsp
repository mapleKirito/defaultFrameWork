<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<html>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>

<head>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/styleCate.css" />

<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.dynamic.grid.tree.js" type="text/javascript"></script>
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
    			{operate:'modify',name:'${pmsIndex.bsms_category_modify.name}',disabled:'false',isvalid:'${!empty pmsIndex.bsms_category_modify}',param:'code=${pmsIndex.bsms_category_modify.code}'},
    			{operate:'detail',name:'${pmsIndex.bsms_category_detail.name}',disabled:'false',isvalid:'${!empty pmsIndex.bsms_category_detail}',param:'code=${pmsIndex.bsms_category_detail.code}'},
    			{operate:'del',name:'${pmsIndex.bsms_category_delete.name}',disabled:'true',isvalid:'${!empty pmsIndex.bsms_category_delete}',param:'code=${pmsIndex.bsms_category_delete.code}'}
	        ]
	    },
	    //父亲节点是否可操作（true：可操作 false：不可操作）
	    isParentNodeOpt:'true',
    	//列表要显示的列（在json中对应的key）
		tableShowColumn: ['cateName'],
		//列表头显示名称
		tableColumnName:   ['分类名称'],
		//列表头宽度
		tableColumnWidth:   ['65%'],
		//可以作为主键的类，在页面传送的过程中为paramMap.key{1}(主键个数值)=value的形式
		//多个主键的时候为["orgID","orgCode"]:paramMap.key1=value&paramMap.key2=value
		primkeyColumn:["cateID","cateSign","cateParentID"],
		//要进行树型显示的列，支持一列
		treeShowColumn:'cateName',
		//树型菜单，起始根值
		treeNodeStartValue:'0',
		//属性菜单子列
		treeChildColumn:'cateID',
		//属性菜单父列
		treeParendColumn:'cateParentID',
		//属性菜单级别
		treeLevel:'cateLevel',
		//属性菜单级别
		treeIsChild:'cateIsChild',
    	ajax:{
			
			url:'ajaxAction.action', 
			
			data:'code=${code}'
		}
    	//tableTreeData:eval(info)
	};
var joptions = {};
$(document).ready(function(){	
	$('#gridTree').gridDynamicTreeTB(jsdata,joptions);	
});

</script> 
</head>
<body >

<div id="layout_mainbody" >

<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC_category list-table" > 
<tr>
<td  align="left"> 
<div class="lt-title">${pmsIndex.bsms_category_mgr.name}</div>
<div class="lt-command">
	<s:if test="pmsIndex.bsms_category_create"> 
		<a href="decorateForwardAction.action?code=${pmsIndex.bsms_category_create.code}"><span>${pmsIndex.bsms_category_create.name}</span></a>
	</s:if>
</div>						
</td>
</tr>
<tr > <td class="tableCcenter lt-command" id="gridTree" valign="top"></td> </tr>
</table> 
</form>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>

</body>
</HTML>
