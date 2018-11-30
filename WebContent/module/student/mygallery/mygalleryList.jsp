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
	var ujdata = {
		//表单ID
		formID:'actionForm',			
		globalParam:$("#actionForm").formSerialize(),
	    //first,last
    	checkbox:{name:'',type:'first',width:'5%'},
    	shortcut:{
    		name:'操作',
	    	url:'decorateForwardAction.action',
	    	width:'25%',
	    	event:[
				{operate:'create',name:'${pmsIndex.stu_images_create.name}',disabled:'false',isvalid:'${!empty pmsIndex.stu_images_create}',param:'code=${pmsIndex.stu_images_create.code}'},
				{operate:'modify',name:'${pmsIndex.stu_images_modify.name}',disabled:'false',isvalid:'${!empty pmsIndex.stu_images_modify}',param:'code=${pmsIndex.stu_images_modify.code}'},
      			{operate:'del',name:'${pmsIndex.stu_images_delete.name}',disabled:'false',isvalid:'${!empty pmsIndex.stu_images_delete}',param:'code=${pmsIndex.stu_images_delete.code}'}
      	    ]
	    },
    	columnDesc:{
	    	//列表要显示的列（在json中对应的key）
			showColumn: ['erName','erType','erTotal','erStoryState'],
			//列表头显示名称
			columnName:   ['中文名','资源类型','资源分类','资源简介状态'],
			//列表头宽度
			columnWidth:   ['40%','11%','11%','8%'],
			//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
			//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
			primkeyColumn:["erID","erCode"],
			//为ujoption中columnCode_替换值做准备
			typeColumn:["erType"],
			//为ujoption中name替换值做准备
			nameColumn:["erName"],
			//要增加链接的列，可以为多个
			linkColumn:[{name:'',url:'',param:''}]
    	},		
    	ajax:{
        	url:'ajaxAction.action',
        	data:'code=${pmsIndex.stu_images_mgr.code}'
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
			
			return val;
			
		},
		columnCode_:function(col,val){
			
		},
		extendDrawShortcut:function(key){
			return '';
		}
	};
    $('#grid').gridTB(ujdata, ujoption);
   	$("#search_exhibition").click(function(){
   		ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
       	ajax:{
           url:'ajaxAction.action',
           data:'code=${pmsIndex.res_exhibition_room_search.code}'
            }
       	})
       	$('#grid').gridTB(ujdata, ujoption);
    });
    $('#delete_dictionary').screenTB({
    	windowDocument:window.parent.document,
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
   				data = $.extend(data,{content:'请选择您要删除的参数记录！'})
   			}
   			else{
   				$.extend(data,{returnValue:'true'})
   				var faction = $("#actionForm").attr("action");
   				$("#actionForm").attr("action",faction +"?code=${pmsIndex.stu_images_delete.code}");
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
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableCcenter" >
	<tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;   background-repeat:repeat;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
				<tr>
				<td align="left">
	 				<s:if test="pmsIndex.stu_images_create">
						<a href="decorateForwardAction.action?code=${pmsIndex.stu_images_create.code}">
						 	<div id="create_1_div"><img src="<%=request.getContextPath()%>/${pmsIndex.stu_images_create.icon}" align="top" width="14" border="0" height="14"><span>${pmsIndex.stu_images_create.name}</span></div>
					 	</a>
				 	</s:if>
				 	<s:if test="pmsIndex.stu_images_delete">
				 		<a id="delete_dictionary" href="javascript:void(0)">
				 			<div id="create_2_div"><img src="<%=request.getContextPath()%>/${pmsIndex.stu_images_delete.icon}" align="top" width="14" border="0" height="14"><span>${pmsIndex.stu_images_delete.name}</span></div>
				 		</a>
				 	</s:if>
				</td>
				<td  align="right">
	       		   	<span>名称：</span>
	       		    <input type="text" name="searchMap.erName" value="${paramMap.erName}" id="erName" style="width: 200px;" />
	       		    <s:if test="pmsIndex.res_exhibition_room_search">
					<a href="javascript:void(0)" id="search_exhibition"><img src="<%=request.getContextPath()%>/images/common/216.gif" align="absmiddle" width="14" border="0" height="14"><span>${pmsIndex.res_exhibition_room_search.name}</span></a>
					</s:if>
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
