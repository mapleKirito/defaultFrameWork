<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
    <%
        String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
    %>
    <title></title>
    <head>
<script type="text/javascript">
$(document).ready(function(){	

});
</script>
<style type="text/css">
.SkyTableLine tr td a img,.SkyTableLine tr td a span{vertical-align: middle;}
.SkyTableLine{padding-top: 8px;}
</style>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC" >

	<tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;background-repeat:repeat;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="SkyTableLine">
				<tr>
				<td align="left">
					<a href="decorateForwardAction.action?code=${pmsIndex.sys_export_db_upload.code}"><img src="<%=request.getContextPath()%>/${pmsIndex.sys_export_db_upload.icon}" align="absmiddle" width="14" border="0" height="14"><span>上传更新文件</span></a>
					&nbsp;&nbsp;
					<a href="decorateForwardAction.action?code=${pmsIndex.sys_export_db_import.code}"><img src="<%=request.getContextPath()%>/${pmsIndex.sys_export_db_import.icon}" align="absmiddle" width="14" border="0" height="14"><span>${pmsIndex.sys_export_db_import.name}</span></a>
					&nbsp;&nbsp;
		       		<a href="decorateForwardAction.action?code=${pmsIndex.sys_export_db_export.code}"><img src="<%=request.getContextPath()%>/${pmsIndex.sys_export_db_export.icon}" align="absmiddle" width="14" border="0" height="14"><span>${pmsIndex.sys_export_db_export.name}</span></a>
			   		 &nbsp;&nbsp;
					<a href="downloadAction.action?code=${pmsIndex.sys_export_db_download.code}"><img src="<%=request.getContextPath()%>/${pmsIndex.sys_export_db_download.icon}" align="absmiddle" width="14" border="0" height="14"><span>${pmsIndex.sys_export_db_download.name}</span></a>
					&nbsp;&nbsp; 				
				</td>
				</tr>
		  	</table> 
		  </div>     
       </td>
   </tr>
	  <tr>
	      <td class="tableCcenter">
	          <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine">
	              <tbody><tr>
	                  <td valign="top" colspan="6" id="paginationList" class="MeNewTDLine">
						  <table border="0" width="100%" cellspacing="1" cellpadding="0" id="gridTable" class="gridTable">
							  <thead class="gridHeadThead">
								  <tr class="gridHeadTr">
									  <th width="25%" align="center" class="gridHeadTh">文件名称</th>
									  <th width="25%" align="center" class="gridHeadTh">导出库</th>
									  <th width="25%" align="center" class="gridHeadTh">文件大小</th>
									  <th align="center" width="25%" class="gridHeadTh">操作</th>
								  </tr>
							  </thead>
							  <tbody id="gridTbody">
							  <s:iterator value="initMap.exportList" id="export" status="ind">
								  <tr class="gridBodyTrOutEven">
									  <td class="gridBodyTd" align="center" style="word-wrap: break-word; word-break: break-all; ">${export.fileName }</td>
									  <td class="gridBodyTd" align="center" style="word-wrap: break-word; word-break: break-all; ">${export.tableCnName }</td>
									  <td class="gridBodyTd" align="center" style="word-wrap: break-word; word-break: break-all; ">${export.fileSize }</td>
									  <td class="gridBodyTd" width="25%" align="center" style="word-wrap: break-word; word-break: break-all; ">
									  <span>&nbsp;&nbsp;<a name="0" href="decorateForwardAction.action?code=${pmsIndex.sys_export_db_del_file.code}&paramMap.tableName=${export.tableName }" id="modify" class="ashortcut">删除</a></span>
									  </td>
								  </tr>
							  </s:iterator>
							  </tbody>
						  </table>
						  </td>
	              </tr>
	          </tbody></table>
	       </td>
     </tr>
</table>
</form>
</body>
</HTML>
