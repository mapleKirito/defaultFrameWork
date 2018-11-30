<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
    <%
    	String basePath = "http://" + request.getLocalAddr() + ":"
    			+ request.getLocalPort() + request.getContextPath();
    %>
    <title></title>
    <head>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bodyfocus.js"></script>
<script type="text/javascript">
var gridtb;
$(document).ready(function(){
	document.onkeydown=function(evt){
		if(evt.keyCode ==13){
			return false;
		}
	}
	var ujdata = {
		//表单ID
		formID:'actionForm',			
		globalParam:$("#actionForm").formSerialize(),
	    //first,last
    	checkbox:{name:'',type:'first',width:'5%'},
    	shortcut:{
    		name:'操作',
	    	url:'decorateForwardAction.action',
	    	width:'10%',
	    	event:[
				{operate:'preview',name:'${pmsIndex.sys_histask_param_review.name}',disabled:'false',isvalid:'${!empty pmsIndex.sys_histask_param_review}',param:'code=${pmsIndex.sys_histask_param_review.code}'},
      			{operate:'del',name:'${pmsIndex.sys_histask_param_delete.name}',disabled:'false',isvalid:'${!empty pmsIndex.sys_histask_param_delete}',param:'code=${pmsIndex.sys_histask_param_delete.code}'}
	      		]
	    },
    	columnDesc:{
	    	//列表要显示的列（在json中对应的key）
			showColumn: ['htaskTitle','htaskKeywords','htaskIsReview','htaskCreatetime'],
			//列表头显示名称
			columnName:   ['中文名','关键词','状态','创建时间'],
			//列表头宽度
			columnWidth:   ['43%','22%','10%','10%'],
			//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
			//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
			primkeyColumn:["htaskID"],
			//为ujoption中columnCode_替换值做准备
			//要增加链接的列，可以为多个
			linkColumn:[{name:'',url:'',param:''}]
    	},		
    	ajax:{
        	url:'ajaxAction.action',
        	data:'code=${pmsIndex.sys_histask_param_search.code}'
	    },
	    //是否有分页工具条
	    isPagination:'true',	    
    	paginationData:{
			pageSize:'6'
    	}
	};
	var ujoption = {
		autoclose: true,
		columnAlias:function(col,val){
			if(col == 'htaskIsReview') {
				if (val == '1') { 
					val = "已审核"; 
				}else{
					val = "未审核";
				}
			}
			return val;
			
		},
		columnCode_:function(col,val){
			
		},
		extendDrawShortcut:function(key){
			return '';
		}
	};
    $('#grid').gridTB(ujdata, ujoption);
   	$("#search_").click(function(){
   		ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
       	ajax:{
           url:'ajaxAction.action',
           data:'code=${pmsIndex.sys_histask_param_search.code}'
            }
       	});
   		
       	$('#grid').gridTB(ujdata, ujoption);
    });
   	
   	
   	$('#close_histask').screenTB({
    	windowDocument:window.parent.parent.document,
   		width:'250',
   		height:'150',
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
   			if ($("#grid tbody input[type='checkbox']:checked").size() == 0){
   				$.extend(data,{returnValue:'true'});
   				alert("请选择要审核的记录！");
   			}
   			else{
   				$.extend(data,{returnValue:'true'})
   				var faction = $("#actionForm").attr("action");
   				$("#actionForm").attr("action",faction +"?code=${pmsIndex.sys_histask_param_review.code}");
   				$("#actionForm").submit();   
   			}
   		}
   	});
    $('#delete_dictionary').screenTB({
    	windowDocument:window.parent.parent.document,
   		width:'250',
   		height:'150',
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
   			if ($("#grid tbody input[type='checkbox']:checked").size() == 0){
   				$.extend(data,{returnValue:'true'});
   				alert("请选择要删除的问题记录！");
   			}
   			else{
   				$.extend(data,{returnValue:'true'})
   				var faction = $("#actionForm").attr("action");
   				$("#actionForm").attr("action",faction +"?code=${pmsIndex.sys_histask_param_delete.code}");
   				$("#actionForm").submit();   
   			}
   		}
   	});
    
});
</script>
<style type="text/css">
html,body{overflow: hidden;}
</style>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="list-table" >
	<tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;   background-repeat:repeat;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
				<tr>
				<td align="left">
				 	<%-- <div class="lt-title">${pmsIndex.sys_test_param.name}</div> --%>
					<div class="lt-command">
	 					<s:if test="pmsIndex.sys_histask_param_review">
	 						<a id="close_histask" href="javascript:void(0)">
					 			<span>${pmsIndex.sys_histask_param_review.name}</span>
					 		</a>
					 	</s:if>
					 	<s:if test="pmsIndex.sys_histask_param_delete">
	 						<a href="javascript:void(0);" id="delete_dictionary">
							 	${pmsIndex.sys_histask_param_delete.name}×
						 	</a>
					 	</s:if>
					 	<div style="float: right;margin-right:15px;">
					 		<span>名称：</span>
			       		    <input type="text" name="searchMap.htaskTitle" value="${paramMap.htaskTitle}" id="htaskTitle" style="width: 200px;" />
			       		    <s:if test="pmsIndex.sys_histask_param_search">
							<a href="javascript:void(0)" id="search_"><span>${pmsIndex.sys_histask_param_search.name}</span></a>
							</s:if>
					 	</div>
				 	</div>
				</td>
				</tr>
		  	</table> 
		  </div>     
       </td>
   </tr>
    <tr>
        <td class="tableCcenter">
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine" style="background-color: #E7E7E7">
                <tr>
                    <td  valign="top" colspan="6" id="paginationList" class="MeNewTDLine"><div id="grid">  </div></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
</body>
</HTML>
