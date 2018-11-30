<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
    <%
        String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
    %>
    <title></title>
    <head>
<script type="text/javascript">
var gridtb;
$(document).ready(function(){	

	var ujdata = {
			//表单ID
			formID:'actionForm',			
		    //first,last
	    	checkbox:{name:'',type:'first',width:'10%'},
	    	shortcut:{
	    		name:'操作',
		    	url:'decorateForwardAction.action',
		    	width:'25%',
		    	event:[
	    			{operate:'modify',name:'${pmsIndex.config_dict_type_modify.name}',disabled:'false',isvalid:'${!empty pmsIndex.config_dict_type_modify}',param:'code=${pmsIndex.config_dict_type_modify.code}'},
       				{operate:'del',name:'${pmsIndex.config_dict_type_delete.name}',disabled:'false',isvalid:'${!empty pmsIndex.config_dict_type_delete}',param:'code=${pmsIndex.config_dict_type_delete.code}'}
		        ]
		    },
	    	columnDesc:{
		    	//列表要显示的列（在json中对应的key）
				showColumn: ['dtName','dtValue'],
				//列表头显示名称
				columnName:   ['字典类型名称','字典类型变量'],
				//列表头宽度
				columnWidth:   ['20%','20%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["dtID","dtValue"],
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
	    $('#grid').gridTB(ujdata);
	    $('#delete_ictionaryt').screenTB({
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
    				data = $.extend(data,{content:'请选择您要删除的字典类型！'})
    			}
    			else{
    				$.extend(data,{returnValue:'true'})
    				var faction = $("#actionForm").attr("action");
    				$("#actionForm").attr("action",faction +"?code=${pmsIndex.config_dict_type_delete.code}");
    				$("#actionForm").submit();        			
    			}
    		}
    	});
		document.onkeydown = function(e){  
	    var ev = document.all ? window.event : e;
	    //屏蔽当输入页码后的键盘回车事件
	    if(ev.keyCode==13) {
		    return false;
	       }
	  	}
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="2" class="tableC">
    <tr>
        <td class="tableCcenter">
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
         <tr>
           <td class="SkyTDLine" align="right" style="background:#9CC7FF;height:22;" >
		   <s:if test="pmsIndex.config_dict_type_create">
			 <a href="decorateForwardAction.action?code=${pmsIndex.config_dict_type_create.code}"><img src="<%=request.getContextPath()%>/${pmsIndex.config_dict_type_create.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.config_dict_type_create.name}</a>
			</s:if>
			<s:if test="pmsIndex.config_dict_type_delete">
			<a id="delete_ictionaryt" href="javascript:void(0)"><img src="<%=request.getContextPath()%>/${pmsIndex.config_dict_type_delete.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.config_dict_type_delete.name}</a>
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
              <td valign="top" colspan="6" id="paginationList" class="MeNewTDLine"><div id="grid"></div>&nbsp;</td>
          </tr>
      </table>
    </td>
</tr>
</table>
</form>
</body>
</HTML>
