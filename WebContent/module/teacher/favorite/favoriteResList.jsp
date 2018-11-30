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
       				{operate:'delRes',name:'${pmsIndex.my_favorite_del_res.name}',disabled:'false',isvalid:'${!empty pmsIndex.my_favorite_del_res}',param:'code=${pmsIndex.my_favorite_del_res.code}'},
       				{operate:'detail',name:'${pmsIndex.my_favorite_res_detail.name}',disabled:'false',isvalid:'${!empty pmsIndex.my_favorite_res_detail}',param:'code=${pmsIndex.my_favorite_res_detail.code}'}
		        ]
		    },
	    	columnDesc:{
		    	//列表要显示的列（在json中对应的key）
				showColumn: ['resName'],
				//列表头显示名称
				columnName:   ['资源名称'],
				//列表头宽度
				columnWidth:   ['13%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["frmId"],
				//要增加链接的列，可以为多个
				linkColumn:[{name:'',url:'',param:''}]
	    	},		
	    	ajax:{
	        	url:'ajaxAction.action',
	        	data:'code=${code}'
		    },
		    //是否有分页工具条
		    isPagination:'false',	    
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
                data:'code=${pmsIndex.my_favorite_move.code}'
                 }
            });
        	$('#grid').gridTB(ujdata,ujoption);
         });

        $('#moveFavorite').screenTB({
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
	    				data = $.extend(data,{content:'请选择您要移动的资源!'});
	    			}
	    			else{
	    				$.extend(data,{returnValue:'true'})
	    				var faction = $("#actionForm").attr("action");
	    				$("#actionForm").attr("action",faction +"?code=${pmsIndex.my_favorite_move.code}");
	    				$("#actionForm").submit();		    			
	    			}
    			}
    		});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="text" name="paramMap.favoriteId" value="${paramMap.favoriteId}"> 

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
	   <td class="tableCcenter">
		      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTDLine">
		         <tr>
		          <td class="SkyTDLine">
		            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTableLine">
		             <tr align="center" class="MeNewTDLine">
						<td align="right" class="SkyTDLine" width="10%">&nbsp;移动资源收藏夹名称：</td>
						<td align="left" class="SkyTDLine" width="30%">
						&nbsp;&nbsp;
						<select style="width:200;" name="paramMap.moveFavoriteId" id="moveFavoriteId">						
							<s:iterator value="initMap.favoriteList" id="favorite" status="ind">
								<option value="${favorite.favoriteId}">${favorite.name}</option>
							</s:iterator>						
						</select>
						</td>											
						<td align="center" class="SkyTDLine" width="20%">
							<s:if test="pmsIndex.my_favorite_move">
								<a href="javascript:void(0)" id=moveFavorite><img src="<%=request.getContextPath()%>/${pmsIndex.my_favorite_move.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.my_favorite_move.name}</a>
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
					<s:if test="pmsIndex.my_favorite_move">
					<a href="decorateForwardAction.action?code=${pmsIndex.my_favorite_move.code}"><img src="<%=request.getContextPath()%>/${pmsIndex.my_favorite_move.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.my_favorite_move.name}</a>
					</s:if>
					<s:if test="pmsIndex.my_favorite_del_res">
					<a id="delete_user" href="javascript:void(0)"><img src="<%=request.getContextPath()%>/${pmsIndex.my_favorite_del_res.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.my_favorite_del_res.name}</a>
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
