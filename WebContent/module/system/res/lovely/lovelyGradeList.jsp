<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
    <%
        String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
    %>
    <title></title>
    <head>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript">
var gridtb;
$(document).ready(function(){	

	var ujdata = {
			//表单ID
			formID:'actionForm',			
			globalParam:$("#actionForm").formSerialize(),
		    //first,last
	    	checkbox:{name:'',type:'first',width:'8%'},
	    	shortcut:{
	    		name:'操作',
		    	url:'decorateForwardAction.action',
		    	width:'25%',
		    	event:[
		        ]
		    },
	    	columnDesc:{
		    	//列表要显示的列（在json中对应的key）
				showColumn: ['erName','erCreator'],
				//列表头显示名称
				columnName:   ['拓展名称','创建人'],
				//列表头宽度
				columnWidth:   ['10%','15%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["erID","erName","erThumbnail"],
				//要增加链接的列，可以为多个
				linkColumn:[{name:'',url:'',param:''}]
	    	},		
	    	ajax:{
	        	url:'ajaxAction.action',
	        	data:'code=${pmsIndex.res_expand_room_grade_search.code}'
		    },
		    //是否有分页工具条
		    isPagination:'true',	    
	    	paginationData:{
				pageSize:'6'
	    	}
		};
	    $('#grid').gridTB(ujdata);
        $("#search_res").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.res_expand_room_grade_search.code}'
                 }
            })
        	$('#grid').gridTB(ujdata);
         });
	    
        
        $('#returnRes').click(function(){
    		var chk_value =[];    
    		$('input[id="gridCheckboxVal"]:checked').each(function(){    
    			chk_value.push($(this).val());    
    		});
    		if(chk_value.length == 0) {
    			alert('你还没有选择任何记录！');
    		}else if(chk_value.length > 1) {
    			alert('只能选择一条记录！');
    		}else {
    			var str = chk_value[0].split("##") ;
    			var resID = str[0].split("=")[1] ;
    			var resName = str[1].split("=")[1] ;
    			var resThumbnail = str[2].split("=")[1] ;
    			var resType = str[4].split("=")[1] ;
    			art.dialog.data('resID', resID);//资源ID
    			art.dialog.data('resName', resName);//资源名称
    			art.dialog.data('resThumbnail', resThumbnail);//资源缩略图
    			art.dialog.data('resUpload', "");//资源
    			art.dialog.data('resType', "");//资源类型
    			art.dialog.close(); 
    		}
    	});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" name="searchMap.erIsGrade" id="erIsGrade" value="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCcenter">
			<table width="100%" border="0" align="center" cellpadding="0"
				cellspacing="1" class="SkyTDLine">
				<tr>
					<td class="SkyTDLine">
						<table width="100%" border="0" cellpadding="0" cellspacing="1"
							class="SkyTableLine">
							<tr align="center" class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">&nbsp;名称：</td>
								<td align="left" class="SkyTDLine" width="30%">&nbsp;&nbsp;<input type="text" name="searchMap.erName" value="${paramMap.erName}" id="erName" style="width: 200px;" /></td>
								<td align="center" class="SkyTDLine" width="20%">
									<s:if test="pmsIndex.res_expand_room_grade_search">
										<a href="javascript:void(0)" id="search_res"><img src="<%=request.getContextPath()%>/${pmsIndex.res_expand_room_grade_search.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.res_expand_room_grade_search.name}</a>
									</s:if>
								</td>
							</tr>
						</table></td>
				</tr>
			</table>
		</td>
	</tr>
    <tr>
        <td class="tableCcenter">
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
		     <tr>
		       <td class="SkyTDLine" align="right" style="background:#9CC7FF;height:22;" >
				<a href="javascript:void(0);" id="returnRes">选择并返回</a>
				</td>
		    </tr>
		  </table>      
       </td>
   </tr>
    <tr>
        <td class="tableCcenter">
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine">
                <tr>
                    <td valign="top" colspan="6" id="paginationList" class="MeNewTDLine"><div id="grid"></div></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
</body>
</HTML>
