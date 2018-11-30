<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
    <%
    	String basePath = "http://" + request.getLocalAddr() + ":"
    			+ request.getLocalPort() + request.getContextPath();
    %>
    <title>${promptInfo.totalDescInfo}</title>
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
    	checkbox:{name:'',type:'first',width:'4%'},
    	shortcut:{
    		name:'操作',
	    	url:'decorateForwardAction.action',
	    	width:'29%',
	    	event:[
				{operate:'preview',name:'${pmsIndex.my_team_info.name}',disabled:'false',isvalid:'${!empty pmsIndex.my_team_info}',param:'code=${pmsIndex.tea_histask_param_t.code}'},
      			{operate:'del',name:'${pmsIndex.res_team_del.name}',disabled:'false',isvalid:'${!empty pmsIndex.res_team_del}',param:'code=${pmsIndex.res_team_del.code}'}
      		]
	    },
    	columnDesc:{
	    	//列表要显示的列（在json中对应的key）
			showColumn: ['tID','tName','tDescription','tUserName'],
			//列表头显示名称
			columnName:   ['小组编号','小组名称','小组描述','小组所有者'],
			//列表头宽度
			columnWidth:   ['12%','27%','14%','14%'],
			//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
			//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
			primkeyColumn:["tID"]
			//为ujoption中columnCode_替换值做准备
			//linkColumn:[{name:'resName',url:'decorateForwardAction.action',param:'code=002018001013'}]
    	},		
    	ajax:{
        	url:'ajaxAction.action',
        	data:'code=${pmsIndex.my_team_mgr.code}'
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
			if(col == 'srCheck') {
				if (val == '1') { 
					val = "已审核"; 
				}else{
					val = "<font style='color:red;'>未审核</font>";
				}
			}
			return val;
		},
		extendDrawShortcut:function(key){
			return '';
		}
	};
    $('#grid').gridTB(ujdata, ujoption);
   	$("#search_review").click(function(){
   		ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
       	ajax:{
           url:'ajaxAction.action',
           data:'code=${pmsIndex.review_search.code}'
            }
       	})
       	$('#grid').gridTB(ujdata, ujoption);
    });
    $('#delete_review').screenTB({
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
   				data = $.extend(data,{content:'请选择您要删除的评论！'})
   			}
   			else{
   				$.extend(data,{returnValue:'true'})
   				var faction = $("#actionForm").attr("action");
   				$("#actionForm").attr("action",faction +"?code=${pmsIndex.review_delete.code}");
   				$("#actionForm").submit();   
   			}
   		}
   	});
    $('#manycheck').screenTB({
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
   				data = $.extend(data,{content:'请选择您要审核的评论！'})
   			}
   			else{
   				$.extend(data,{returnValue:'true'})
   				var faction = $("#actionForm").attr("action");
   				$("#actionForm").attr("action",faction +"?code=${pmsIndex.review_manycheck.code}");
   				$("#actionForm").submit();   
   			}
   		}
   	});
    $('#delete_check').screenTB({
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
   				data = $.extend(data,{content:'请选择您要取消审核的评论！'})
   			}
   			else{
   				$.extend(data,{returnValue:'true'})
   				var faction = $("#actionForm").attr("action");
   				$("#actionForm").attr("action",faction +"?code=${pmsIndex.review_delcheck.code}");
   				$("#actionForm").submit();   
   			}
   		}
   	});
    
    
    $("#grid").height( $("#iframeHeight",parent.document).val()).css("overflow-y","scroll");
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
				 	<s:if test="pmsIndex.res_team_add">
				 		<a href="decorateForwardAction.action?code=${pmsIndex.res_team_add.code}">
						 	<div id="create_1_div"><img src="<%=request.getContextPath()%>/${pmsIndex.res_team_add.icon}" align="top" width="14" border="0" height="14"><span>${pmsIndex.res_team_add.name}</span></div>
					 	</a>
				 	</s:if>
				 	<s:if test="pmsIndex.res_team_del">
				 		<a id="team_del" href="javascript:void(0)">
				 			<div id="create_2_div"><img src="<%=request.getContextPath()%>/${pmsIndex.res_team_del.icon}" align="top" width="14" border="0" height="14"><span>${pmsIndex.res_team_del.name}</span></div>
				 		</a>
				 	</s:if>
				</td>
				<%-- <td  align="right">
	       		   	<span>名称：</span>
	       		    <input type="text" name="searchMap.erName" value="${paramMap.erName}" id="erName" style="width: 200px;" />
	       		    <s:if test="pmsIndex.review_search">
					<a href="javascript:void(0)" id="search_exhibition"><img src="<%=request.getContextPath()%>/images/common/216.gif" align="absmiddle" width="14" border="0" height="14"><span>${pmsIndex.review_search.name}</span></a>
					</s:if>
				</td> --%>
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
