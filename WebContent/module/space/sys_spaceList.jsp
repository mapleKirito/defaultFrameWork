<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
    <%
        String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
    %>
    <title>${promptInfo.totalDescInfo}</title>
    <head>
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
		    	width:'15%',
		    	event:[
					{operate:'recom',name:'${pmsIndex.the_space_mgr_recom.name}',disabled:'false',isvalid:'${!empty pmsIndex.the_space_mgr_recom}',param:'code=${pmsIndex.the_space_mgr_recom.code}'}
	    		]
		    },
	    	columnDesc:{
		    	//列表要显示的列（在json中对应的key）
				showColumn: ['spaceName','userName','userType','userCreateTime','userRecom'],
				//列表头显示名称
				columnName:   ['空间名称','用户名','用户类型','创建时间','推荐状态'],
				//列表头宽度
				columnWidth:   ['24%','23%','9%','16%','8%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["userID"],
				//为ujoption中columnCode_替换值做准备
				typeColumn:["userType"],
				//为ujoption中name替换值做准备
				nameColumn:["spaceName"],
				//要增加链接的列，可以为多个
				linkColumn:[{name:'spaceName',url:'decorateForwardAction.action',param:'code=-6003'}]
	    	},		
	    	ajax:{
	        	url:'ajaxAction.action',
	        	data:'code=${pmsIndex.the_space_mgr_search.code}'
		    },
		    //是否有分页工具条
		    isPagination:'true',	    
	    	paginationData:{
				pageSize:'6'
	    	}
		};
	var filetype = '';
		var ujoption = {
			autoclose: true,
			columnAlias:function(col,val){
				if(col == 'userType') {
					if (val == '1') {
						filetype = val;
						val = "教师"; 
					}else if (val == '4') {
						filetype = val;
						val = "机构";
					}else if (val == '2') {
						filetype = val;
						val = "学生";
					}
				}
				
				if(col == 'userRecom') {
					if (val == '1') { 
						val = "已推荐"; 
					}else{
						val = "<font style='color:red;'>未推荐</font>";  
					}
				}
				
				return val;
			}
		};
	    $('#grid').gridTB(ujdata,ujoption);
        $("#search_res").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.the_space_mgr_search.code}&type=1'
                 }
            })
            $('#grid').gridTB(ujdata, ujoption);
         });
	    $('#manyrecom').screenTB({
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
	   				data = $.extend(data,{content:'请选择您要推荐的参数记录！'})
	   			}
	   			else{
	   				$.extend(data,{returnValue:'true'})
	   				var faction = $("#actionForm").attr("action");
	   				$("#actionForm").attr("action",faction +"?code=${pmsIndex.the_space_mgr_manyrecom.code}");
	   				$("#actionForm").submit();   
	   			}
	   		}
	   	});
	    $('#delete_recom').screenTB({
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
					data = $.extend(data,{content:'请选择您要取消推荐的资源！'});
				}
				else{
					$.extend(data,{returnValue:'true'})
					var faction = $("#actionForm").attr("action");
					$("#actionForm").attr("action",faction +"?code=${pmsIndex.the_space_mgr_deleteRecom.code}");
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
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC" >
   <tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;   background-repeat:repeat;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
				<tr >
				<td class="leftmiddl">
				 	<s:if test="pmsIndex.the_space_mgr_manyrecom">
				 		<a id="manyrecom" href="javascript:void(0)">
				 			<div id="create_5_div"><img src="<%=request.getContextPath()%>/${pmsIndex.res_expand_room_manyrecom.icon}" align="top" width="14" border="0" height="14"><span>${pmsIndex.res_expand_room_manyrecom.name}</span></div>
				 		</a>
				 	</s:if>
				 	<s:if test="pmsIndex.the_space_mgr_deleteRecom">
				 		<a id="delete_recom" href="javascript:void(0)">
				 			<div id="create_2_div"><img src="<%=request.getContextPath()%>/${pmsIndex.sys_res_recom_deleteRecom.icon}" align="top" width="14" border="0" height="14"><span>${pmsIndex.sys_res_recom_deleteRecom.name}</span></div>
				 		</a>
				 	</s:if>
				 	</td>
				<td align="right">
		       		<span>名称</span>：
					<input type="text" name="searchMap.spaceName" value="${paramMap.spaceName}" id="erName"  />
					
						<s:if test="pmsIndex.the_space_mgr_search">
							<a href="javascript:void(0)" id="search_res"><img src="<%=request.getContextPath()%>/images/common/216.gif" align="absmiddle" width="14" border="0" height="14"><span>${pmsIndex.the_space_mgr_search.name}</span></a>
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
                    <td valign="top" colspan="6" id="paginationList" class="MeNewTDLine"><div id="grid"></div>&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
</body>
</HTML>
