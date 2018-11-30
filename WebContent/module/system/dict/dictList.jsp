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
			globalParam:$("#actionForm").formSerialize(),
		    //first,last
	    	checkbox:{name:'',type:'first',width:'8%'},
	    	shortcut:{
	    		name:'操作',
		    	url:'decorateForwardAction.action',
		    	width:'25%',
		    	event:[
	    			{operate:'modify',name:'${pmsIndex.config_data_dict_modify.name}',disabled:'false',isvalid:'${!empty pmsIndex.config_data_dict_modify}',param:'code=${pmsIndex.config_data_dict_modify.code}'},
       				{operate:'del',name:'${pmsIndex.config_data_dict_delete.name}',disabled:'false',isvalid:'${!empty pmsIndex.config_data_dict_delete}',param:'code=${pmsIndex.config_data_dict_delete.code}'}
		        ]
		    },
	    	columnDesc:{
		    	//列表要显示的列（在json中对应的key）
				showColumn: ['dtName','dicName','dicValue','dicDesc'],
				//列表头显示名称
				columnName:   ['字典类型','参数名','参数值','参数描述'],
				//列表头宽度
				columnWidth:   ['20%','15%','15%','15%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["dicID"],
				//要增加链接的列，可以为多个
				linkColumn:[{name:'',url:'',param:''}]
	    	},		
	    	ajax:{
	        	url:'ajaxAction.action',
	        	data:'code=${pmsIndex.config_data_dict_search.code}'
		    },
		    //是否有分页工具条
		    isPagination:'true',	    
	    	paginationData:{
				pageSize:'6'
	    	}
		};
	    $('#grid').gridTB(ujdata);
        $("#search_dictionary").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.config_data_dict_search.code}&type=1'
                 }
            })
        	$('#grid').gridTB(ujdata);
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
    				$("#actionForm").attr("action",faction +"?code=${pmsIndex.config_data_dict_delete.code}");
    				$("#actionForm").submit();   
    			}
    		}
    	});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="2" class="tableC">
    <tr>
        <td class="tableCcenter">
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine">
                <tr>
                    <td class="SkyTDLine">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTableLine">
                          <tr align="center" class="MeNewTDLine" >
                              <td align="right" class="SkyTDLine" width="15%">&nbsp;字典类型名称：</td>
                              <td align="left" class="SkyTDLine" width="25%">&nbsp;
                                  <select style="width:200;" name="paramMap.dicDictTypeID">
                                  <option value="">全部</option>
                                  <s:iterator value="initMap.dictInfo" id="dict" status="ind">
									<s:if test="#dict.dtID == paramMap.dicDictTypeID">
										<option selected="selected" value="${dict.dtID}">${dict.dtName}</option>
									</s:if>
                                    <s:else>
										<option value="${dict.dtID}">${dict.dtName}</option>
                                    </s:else>
                                  </s:iterator>
                                  </select>
                             </td>
                              <td align="right" class="SkyTDLine" width="15%">&nbsp;参数名：</td>
                              <td align="left" class="SkyTDLine" width="25%">&nbsp;
                                  <input type="text" name="searchMap.name" value="${paramMap.name}" id="name" style="width:200;"/>
                              </td>
	                          <td align="center" class="SkyTDLine" width="20%">
								<s:if test="pmsIndex.config_data_dict_search">
								<a href="javascript:void(0)" id="search_dictionary"><img src="<%=request.getContextPath()%>/${pmsIndex.config_data_dict_search.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.config_data_dict_search.name}</a>
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
        <td class="tableCcenter">
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
		     <tr>
		       <td class="SkyTDLine" align="right" style="background:#9CC7FF;height:22;" >
				<s:if test="pmsIndex.config_data_dict_create">
				<a href="decorateForwardAction.action?code=${pmsIndex.config_data_dict_create.code}"><img src="<%=request.getContextPath()%>/${pmsIndex.config_data_dict_create.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.config_data_dict_create.name}</a>
				</s:if>
				<s:if test="pmsIndex.config_data_dict_delete">
				<a id="delete_dictionary" href="javascript:void(0)"><img src="<%=request.getContextPath()%>/${pmsIndex.config_data_dict_delete.icon}" align="absmiddle" width="14" border="0" height="14">${pmsIndex.config_data_dict_delete.name}</a>
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
