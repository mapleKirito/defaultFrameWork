<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
            String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<html>
<title></title>
<head>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.dynamic.grid.tree.js" type="text/javascript"></script>
<script type="text/javascript">
var gridtb;
$(document).ready(function(){	
	   
	var ujdata = {
			//表单ID
			formID:'actionForm',
		    globalParam:$("#actionForm").formSerialize(),
		    //type ：first,last
		    //order ：a(升序),d(降序)
	    	//serialno:{name:'编号',type:'first',width:'10%',order:'a'},			    
		    //first,last
	    	checkbox:{name:'',type:'first',width:'10%'},
	    	shortcut:{
	    		name:'操作',
		    	url:'decorateForwardAction.action',
		    	width:'50%',
		    	event:[
	    			{operate:'modify',name:'${pmsIndex.my_favorite_modify.name}',disabled:'false',isvalid:'${!empty pmsIndex.my_favorite_modify}',param:'code=${pmsIndex.my_favorite_modify.code}'},
       				{operate:'del',name:'${pmsIndex.my_favorite_delete.name}',disabled:'false',isvalid:'${!empty pmsIndex.my_favorite_delete}',param:'code=${pmsIndex.my_favorite_delete.code}'},
       				{operate:'detail',name:'${pmsIndex.my_favorite_detail.name}',disabled:'false',isvalid:'${!empty pmsIndex.my_favorite_detail}',param:'code=${pmsIndex.my_favorite_detail.code}'}
		        ]
		    },
	    	columnDesc:{
		    	//列表要显示的列（在json中对应的key）
				showColumn: ['name'],
				//列表头显示名称
				columnName:   ['收藏夹名称'],
				//列表头宽度
				columnWidth:   ['13%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["favoriteId"],
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
	var ujoption = {
			autoclose: true,
			columnAlias:function(col,val){
				if(col == 'userGender')
				{
					if (val == '1')
						val = "男";
					else if (val == '0')
						val =  "女";
				}
				if(col == 'userType')
				{
					if (val == '2')
						val = "学生";
					else if (val == '1')
						val =  "老师";
				}				
				return val;
			},
			extendDrawShortcut:function(key){
				return '';
			}
		};
	    $('#grid').gridTB(ujdata,ujoption);
        $("#search_favorite").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.my_favorite_search.code}'
                 }
            });
        	$('#grid').gridTB(ujdata,ujoption);
         });

        $('#delete_user').screenTB({
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
	    				data = $.extend(data,{content:'请选择您要删除的用户！'});
	    			}
	    			else{
	    				$.extend(data,{returnValue:'true'})
	    				var faction = $("#actionForm").attr("action");
	    				$("#actionForm").attr("action",faction +"?code=${pmsIndex.sys_user_delete.code}");
	    				$("#actionForm").submit();		    			
	    			}
    			}
    		});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
	   <td class="tableCcenter">
		      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTDLine">
		         <tr>
		          <td class="SkyTDLine">
		            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTableLine">
		             <tr align="center" class="MeNewTDLine">
						<td align="right" class="SkyTDLine" width="10%">&nbsp;收藏夹名称：</td>
						<td align="left" class="SkyTDLine" width="30%">
						&nbsp;&nbsp;<input type="text" name="searchMap.name" value="${paramMap.name}" id="favoriteName" style="width: 200px;" />
						</td>
												
						<td align="center" class="SkyTDLine" width="20%">
							<s:if test="pmsIndex.my_favorite_search">
							<a href="javascript:void(0)" id="search_favorite"><img src="<%=request.getContextPath()%>/${pmsIndex.my_favorite_search.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.my_favorite_search.name}</a>
							</s:if>
						</td>
					 </tr>
		              </table>
		            </td>
		         </tr>
		      </table>
	     </td>
	   </tr>
	   <tr>
	    <td class="tableCcenter" align="right">
		    <table width="100%" border="0" align="center" cellpadding="4" cellspacing="1" class="SkyTableLine">
	          <tr>
	            <td class="SkyTDLine" align="right" style="background:#9CC7FF;height:22;" >
					<s:if test="pmsIndex.my_favorite_create">
					<a href="decorateForwardAction.action?code=${pmsIndex.my_favorite_create.code}"><img src="<%=request.getContextPath()%>/${pmsIndex.my_favorite_create.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.my_favorite_create.name}</a>
					</s:if>
					<s:if test="pmsIndex.my_favorite_delete">
					<a id="delete_user" href="javascript:void(0)"><img src="<%=request.getContextPath()%>/${pmsIndex.my_favorite_delete.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.my_favorite_delete.name}</a>
					</s:if>
			     </td>
	            </tr>
	          </table>                         
	       </td>
	    </tr>
	    <tr>
	        <td class="tableCcenter">
	            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine">
	                <tr>
	                    <td valign="top" id="grid" class="MeNewTDLine">
	                     &nbsp;
	                    </td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
</form>
</body>
</html>
