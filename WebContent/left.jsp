<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/mztreeview.js"></script>
<title><s:text name="systemName"/></title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE1 {font-size: 12px}
.STYLE3 {font-size: 12px; font-weight: bold; }
.STYLE4 {
	color: #03515d;
	font-size: 12px;
}
-->
</style></head>
<body>
<table width="168" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0"  style="table-layout:fixed;">
      <tr>
        <td><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
          <tr>
            <td height="23" background="images/main/main_29.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="40%">&nbsp;</td>
                <td width="42%"><font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">管理菜单</font></td>
                <td width="18%">&nbsp;</td>
              </tr>
            </table>
           </td>
          </tr>
          <tr>
            <td bgcolor="#e5f4fd" valign="top"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	              <tr class="STYLE1">
					<td valign="top" width="10">&nbsp;</td> 		
	                <td valign="top" > 
	                <SCRIPT LANGUAGE="JavaScript" type="text/javascript">
						window.tree = new MzTreeView("tree");
						tree.icons["property"] = "property.gif";
						tree.icons["css"] = "collection.gif";
						tree.icons["event"] = "collection.gif";
						tree.icons["book"]  = "book.gif";
						tree.iconsExpand["book"] = "bookopen.gif"; //展开时对应的图片
						tree.setIconPath("./images/tree/"); //可用相对路径
						tree.nodes["-1_PMS${code}"] = "text:根目录;"
							<s:iterator value="subPermission" id="pms" status="ind">
								tree.nodes["PMS${pms.parentCode}_PMS${pms.code}"] = "text:${pms.name};url:decorateForwardAction.action?code=${pms.code};"
						    </s:iterator>	
						tree.setTarget("centerFrame${code}");
						document.write(tree.toString());
					</SCRIPT>
	             </td>
	           </tr>
            </table></td>
          </tr>
          <tr>
            <td height="23" background="images/main/main_45.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="18%">&nbsp;</td>
                <td width="64%"><div align="center"><font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">版本2010 V1.1 </font></div></td>
                <td width="18%">&nbsp;</td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
