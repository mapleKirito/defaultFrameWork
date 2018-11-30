<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.io.File"%>
<%@ page language="java" import="java.lang.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="java.net.*"%>
<%@ page language="java" import="com.ambow.base.grm.onlineread.web.OnlineReadEntrance"%>
<%
	// error: 0  正常
	// 		  1 没有该文件
	// 		  2 pdf转化异常  
	// 		  3 swf转化异常new String(group.getBytes("ISO-8859-1"),"utf-8"); 
 
	request.setCharacterEncoding("UTF-8");  
	String filePath = URLDecoder.decode(request.getParameter("filePath"), "UTF-8");   ;
	System.out.println(filePath);
	String realPath = application.getRealPath(File.separator)+request.getServletPath();
	String errorStr="";
	String swfPath = "";
	//判断传入参数是否有空值
	try{
		if(filePath==null||filePath.equals("")){
			//没有传入参数，页面显示错误
			errorStr="传入参数信息有误";
		}else{
			OnlineReadEntrance ore = new OnlineReadEntrance();
			HashMap<String,String> rtnMap = ore.getSWF(filePath,realPath);
			if(rtnMap.get("error") != null && rtnMap.get("error").toString().equals("0")){
				swfPath = rtnMap.get("swfPath")==null?"":rtnMap.get("swfPath").toString();
			}else if(rtnMap.get("error") != null && rtnMap.get("error").toString().equals("1")){
				errorStr="该文件类型无法进行转换";
			}else if(rtnMap.get("error") != null && rtnMap.get("error").toString().equals("2")){
				errorStr="该文件类型无法进行转换";
			}else if(rtnMap.get("error") != null && rtnMap.get("error").toString().equals("3")){
				errorStr="Sorry,该文件转换pdf失败";			
			}else if(rtnMap.get("error") != null && rtnMap.get("error").toString().equals("4")){
				errorStr="Sorry,该文件转换swf失败";
			}
		}
	}catch(Exception e){
			e.printStackTrace();
		}
%>
<html>
    <head> 
        <title>在线阅读</title>                
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<script type="text/javascript" src="js/flexpaper_flash_debug.js"></script>
		<script type="text/javascript" src="js/jquery-1.4.4.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {	
				var errorMsg = '<%=errorStr%>';
				if(errorMsg != ''){
					$("#showFlash").hide();
					alert(errorMsg);
				}
			});
		</script>
    </head> 
    <body> 
    <input type="hidden" id="swfPath" name="swfpath" value="<%=swfPath%>">
  	<div style="position:absolute;left:10px;top:10px;" id="showFlash">
	        <a id="viewerPlaceHolder" style="width:800px;height:600px;display:block"></a>
	        <script type="text/javascript"> 
	        	var swfPath = $("#swfPath").val();
				var fp = new FlexPaperViewer(	
						 'FlexPaperViewer',
						 'viewerPlaceHolder', { config : {
						 SwfFile : swfPath,
						 Scale : 1.3, 
						 ZoomTransition : 'easeOut',
						 ZoomTime : 0.5,
						 ZoomInterval : 0.2,
						 FitPageOnLoad : false,
						 FitWidthOnLoad : false,
						 PrintEnabled : true,
						 FullScreenAsMaxWindow : false,
						 ProgressiveLoading : false,
						 MinZoomSize : 0.2,
						 MaxZoomSize : 5,
						 SearchMatchAll : false,
						 InitViewMode : 'Portrait',
						 ViewModeToolsVisible : true,
						 ZoomToolsVisible : true,
						 NavToolsVisible : true,
						 CursorToolsVisible : true,
						 SearchToolsVisible : true,
  						 localeChain: 'en_US'
						 }});
	        </script>  
        </div>
   </body> 
</html> 