<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html> 
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>
<head>
<script type="text/javascript">
var gridtb;
$(document).ready(function(){	
	var ujdata = {
		//表单ID
		formID: 'actionForm',
		globalParam: $("#actionForm").formSerialize(),
		//first,last
		checkbox: {
			name: '',
			type: 'first',
			width: '5%'
		},
		shortcut: {
			name: '操作',
			url: 'decorateForwardAction.action',
			width: '',
			event: []
		},
		columnDesc: {
			//列表要显示的列（在json中对应的key）
			showColumn: ['htaskTitle', 'htaskKeywords', 'htaskCreatetime'],
			//列表头显示名称
			columnName: ['问题标题', '问题关键词', '创建时间'],
			//列表头宽度
			columnWidth: ['65%', '20%', '10%'],
			//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
			//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
			primkeyColumn: ["htaskID","htaskUserCreate"],
			//要增加链接的列，可以为多个
			linkColumn: [{
				name: 'htaskTitle',
				url: 'decorateForwardAction.action',
				param: 'code=-1890002&paramMap.htaskSplitIndex=1'
			}]
		},
		ajax: {
			url: 'ajaxAction.action',
			data: 'code=${pmsIndex.stu_histask_hd_param_search.code}'
		},
		//是否有分页工具条
		isPagination: 'true',
		paginationData: {
			pageSize: '10'
		}
	};
	var ujoption = {
		autoclose: true,
		columnAlias: function(col, val) {
			return val;
		},
		extendDrawShortcut: function(key) {
			return '';
		}
	};
	$('#grid').gridTB(ujdata, ujoption);
	$("#search_").click(function() {
		ujdata = $.extend(ujdata, {
			globalParam: $("#actionForm").formSerialize(),
			ajax: {
				url: 'ajaxAction.action',
				data: 'code=${pmsIndex.stu_histask_hd_param_search.code}&type=1'
			}
		});
		$('#grid').gridTB(ujdata, ujoption);
	});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC" >
   <tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;   background-repeat:repeat;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
				<tr height="32px">
				<td class="leftmiddl">
		 			<span>名称</span>：
					<input type="text" name="searchMap.htaskTitle" value="${paramMap.htaskTitle}" id="htaskTitle" style="width: 200px;" />
					
					<s:if test="pmsIndex.stu_histask_hd_param_search">
						<a href="javascript:void(0)" id="search_"><img src="<%=request.getContextPath()%>/images/common/216.gif" align="absmiddle" width="14" border="0" height="14"><span>${pmsIndex.stu_histask_hd_param_search.name}</span></a>
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