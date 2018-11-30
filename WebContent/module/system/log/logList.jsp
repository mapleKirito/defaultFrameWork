<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
   String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<html>
<title></title>
<head>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.dynamic.grid.tree.js" type="text/javascript"></script>
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
		    	width:'10%',
		    	event:[
		    		{operate:'del',name:'删除',isvalid:'${!empty pmsIndex.sys_ol_delete}',param:'code=${pmsIndex.sys_ol_delete.code}'}
		        ]
		    },
	    	columnDesc:{
	    		//列表要显示的列（在json中对应的key）
				showColumn: ['userName','olAccessIP','olOperateTime','olContent'],
				//列表头显示名称
				columnName:   ['用户姓名','登录IP','记录日期','操作内容'],
				//列表头宽度
				columnWidth:   ['15%','15%','15%','40%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["olID"]
				//要增加链接的列，可以为多个
				//linkColumn:[{name:'',param:''}]
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
				if(col == 'userName') {
					if (val == 'defaultadmin') { 
						val = "游客"; 
					}else if(val == 'admin'){
						val = "管理员";
					}
				}
				
				if(col == 'olContent') {
					if (val.indexOf("defaultadmin")>-1) { 
						val = val.replace("用户defaultadmin"," 游客 "); 
					}else{
						val = val.replace("用户admin"," 管理员 "); 
					}
				}
				
				
				return val;
			},
			extendDrawShortcut:function(key){
				return '';
			}		
		};
	    $('#grid').gridTB(ujdata,ujoption);
        $("#search_ol").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.sys_ol_search.code}&type=1'
                 }
            });
        	$('#grid').gridTB(ujdata,ujoption);
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
    				data = $.extend(data,{content:'请选择您要删除的日志记录！'})
    			}
    			else{
    				$.extend(data,{returnValue:'true'})
    				var faction = $("#actionForm").attr("action");
    				$("#actionForm").attr("action",faction +"?code=${pmsIndex.sys_ol_delete.code}");
    				$("#actionForm").submit();
    			}
    		}
    	});
        $("#export_ol").click(function(){
			$("#name1").val($("#name").val());
			$("#timeStart1").val($("#timeStart").val());
			$("#timeEnd1").val($("#timeEnd").val());
			$("#select_default_value1").val($("#select_default_value").val());
			$("#dataForm").submit();
         });
      	 $('#orgbtn').screenTB({
 	     	windowDocument:window.parent.parent.document,
 	 		width:'300',
 	 		height:'350',
 	 		content:'测试内容',
 	 		contentAlign:'center',
 	 		contentValign:'middle',
 				title:'系统提示信息',
 				buttonValueYes:'确定',	
 				buttonValueNo:'取消',	
 				dialogType:'iframe',
 				iframeSrc:'forwardAction.action?code=${pmsIndex.sys_org_tree.code}&tempCode=${code}'				
 	 		},{});	         
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
       		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="SkyTableLine">
				<tr>
				<td align="left" >
					<div class="lt-title">${pmsIndex.sys_operate_log.name}</div>
					<div class="lt-command">
	 					<s:if test="pmsIndex.sys_ol_export">
	 						<a href="decorateForwardAction.action?code=${pmsIndex.sys_ol_export.code}" class="fade-button" data-old-bg="rgb(124, 109, 91)" style="background-color: rgb(124, 109, 91);">
							 	${pmsIndex.sys_ol_export.name}+
						 	</a>
					 	</s:if>
					 	<s:if test="pmsIndex.sys_ol_delete">
	 						<a href="javascript:void(0);" id="delete_dictionary">
							 	${pmsIndex.sys_ol_delete.name}×
						 	</a>
					 	</s:if>
					 	<div style="float: right;margin-right: 15px;">
						 	&nbsp;<span>用户姓名：</span>
							<input type="text" name="searchMap.name" value="${paramMap.name}" id="name" style="width: 200px;" />
							<s:if test="pmsIndex.sys_ol_search">
							<a href="javascript:void(0)" id="search_ol"><img src="<%=request.getContextPath()%>/${pmsIndex.sys_ol_search.icon}" align="absmiddle" width="14" border="0" height="14"><span>${pmsIndex.sys_ol_search.name}</span></a>
						    </s:if>
						</div>
				 	</div>
			   	</td> 
				</tr>
		  	</table>   
       </td>
   </tr>
     <tr>
        <td class="tableCcenter">
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine" style="border-collapse: collapse;border: 1px solid #dfdfdf;">
                <tr>
                    <td  valign="top" colspan="6" id="paginationList" class="MeNewTDLine"><div id="grid">  </div></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
<form name="dataForm" method="post" action="decorateForwardAction.action?code=${pmsIndex.sys_ol_export.code}" id="dataForm">
	<input type="hidden" id="name1" name="paramMap.name1"/>
	<input type="hidden" id="timeStart1" name="paramMap.timeStart1"/>
	<input type="hidden" id="timeEnd1" name="paramMap.timeEnd1"/>
	<input type="hidden" id="select_default_value1" name="paramMap.select_default_value1"/>
</form>
  </body>
</html>