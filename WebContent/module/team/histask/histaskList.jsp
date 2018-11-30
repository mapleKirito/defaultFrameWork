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
			width: '15%',
			event: [{
				operate: 'modify',
				name: '${pmsIndex.tea_histask_param_modify.name}',
				disabled: 'false',
				isvalid: '${!empty pmsIndex.tea_histask_param_modify}',
				param: 'code=${pmsIndex.tea_histask_param_modify.code}'
			},
			{
				operate: 'del',
				name: '${pmsIndex.tea_histask_param_delete.name}',
				disabled: 'false',
				isvalid: '${!empty pmsIndex.tea_histask_param_delete}',
				param: 'code=${pmsIndex.tea_histask_param_delete.code}'
			}]
		},
		columnDesc: {
			//列表要显示的列（在json中对应的key）
			showColumn: ['htaskTitle', 'htaskKeywords', 'htaskCreatetime'],
			//列表头显示名称
			columnName: ['问题标题', '问题关键词', '创建时间'],
			//列表头宽度
			columnWidth: ['50%', '20%', '10%'],
			//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
			//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
			primkeyColumn: ["htaskID"],
			//要增加链接的列，可以为多个
			linkColumn: [{
				name: '',
				url: '',
				param: ''
			}]
		},
		ajax: {
			url: 'ajaxAction.action',
			data: 'code=${pmsIndex.tea_histask_param_search.code}'
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
			if (col == 'isHot') {
				if (val == 'Yes') {
					val = "已显示";
				} else if (val == 'No') {
					val = "已隐藏";
				}
			}
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
				data: 'code=${pmsIndex.tea_histask_param_search.code}&type=1'
			}
		});
		$('#grid').gridTB(ujdata, ujoption);
	});

	$('#delete_htask').screenTB({
		windowDocument: window.parent.document,
		width: '250',
		height: '150',
		content: '测试内容',
		contentAlign: 'center',
		contentValign: 'middle',
		title: '系统提示信息',
		buttonValueYes: '确定',
		buttonValueNo: '取消',
		dialogType: 'alert',
		iframeSrc: ''
	},
	{
		clickEvent: function(data) {
			if ($("#grid tbody input[type='checkbox']:checked").size() == 0) {
				data = $.extend(data, {
					content: '请选择您要删除的问题！'
				});
			} else {
				$.extend(data, {
					returnValue: 'true'
				});
				var faction = $("#actionForm").attr("action");
				$("#actionForm").attr("action", faction + "?code=${pmsIndex.tea_histask_param_manydelete.code}");
				$("#actionForm").submit();
			}
		}
	});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" id="tID" name="paramMap.tID" value="${paramMap.tID}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC" >
   <tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;   background-repeat:repeat;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
				<tr >
				<td class="leftmiddl">
		 			<s:if test="pmsIndex.tea_histask_param_create">
						<a href="decorateForwardAction.action?code=${pmsIndex.tea_histask_param_create.code}">
						 	<div id="create_1_div"><img src="<%=request.getContextPath()%>/${pmsIndex.tea_histask_param_create.icon}" align="top" width="14" border="0" height="14"><span>${pmsIndex.tea_histask_param_create.name}</span></div>
					 	</a>
				 	</s:if>
				 	<s:if test="pmsIndex.tea_histask_param_delete">
				 		<a id="delete_htask" href="javascript:void(0)">
				 			<div id="create_2_div"><img src="<%=request.getContextPath()%>/${pmsIndex.tea_histask_param_delete.icon}" align="top" width="14" border="0" height="14"><span>${pmsIndex.tea_histask_param_delete.name}</span></div>
				 		</a>
				 	</s:if>
				 	<s:if test="pmsIndex.res_team_member_mgr">
				 		<a href="decorateForwardAction.action?code=${pmsIndex.res_team_member_mgr.code}&paramMap.tID=${paramMap.tID}">
				 			<div id="create_1_div"><img src="<%=request.getContextPath()%>/${pmsIndex.res_team_member_mgr.icon}" align="top" width="14" border="0" height="14"><span>${pmsIndex.res_team_member_mgr.name}</span></div>
				 		</a>
				 	</s:if>
				</td>
				<td align="right">
		       		<span>名称</span>：
					<input type="text" name="searchMap.htaskTitle" value="${paramMap.htaskTitle}" id="htaskTitle" style="width: 200px;" />
					
					<s:if test="pmsIndex.tea_histask_param_search">
						<a href="javascript:void(0)" id="search_"><img src="<%=request.getContextPath()%>/images/common/216.gif" align="absmiddle" width="14" border="0" height="14"><span>${pmsIndex.tea_histask_param_search.name}</span></a>
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