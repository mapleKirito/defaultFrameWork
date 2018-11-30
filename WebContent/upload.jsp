<%@ page contentType="text/html; charset=UTF-8" %>
<html>
 <title></title>
<head>   
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/default.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/uploadify.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.uploadify.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/swfobject.js" type="text/javascript"></script>
<script type="text/javascript">   
      $(document).ready(function() {   
          $("#uploadify").uploadify({   
              'uploader'       : '<%=request.getContextPath()%>/flash/uploadify.swf',//指定uploadify.swf路径   
              'script'         : 'uploadAction.action',//后台处理的请求的servlet,同时传递参数,由于servlet只能接收一个参数，所以将两个参数合并成一个。   
              'cancelImg'      : '<%=request.getContextPath()%>/images/upload/cancel.png',
              'fileDataName'   : 'uploadify',   
              'folder'         : '/',                  
              'queueID'        : 'fileQueue',//与下面的id对应   
              'queueSizeLimit'  :3,//当允许多文件生成时，设置选择文件的个数   
              'fileDesc'    : 'txt、jpg、gif、swf文件',               
              'fileExt' :    '*.txt;*.jpg;*.gif;*.swf;', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc   
              'auto'           : false,//是否自动上传，即选择了文件即刻上传。   
              'multi'          : true, //是否允许同时上传多文件，默认false   
              'simUploadLimit' : 2,//多文件上传时，同时上传文件数目限制   
              'buttonText'     : 'BROWSE',   
              'displayData'    : 'percentage',   
        	  onComplete: function (evt, queueID, fileObj, response, data) {}   
          });   
      });   
  
</script>  
</head>

<body bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0" >
<form name="actionForm" method="post" enctype="multipart/form-data" id="actionForm">
<table border="0"  style="background-image: url(images/main/welcomebg.gif)" width="100%" height="100%">
<tr>
<td width="100%" height="100%" bgcolor="#F7F2FF" background="images/main/welcomebg.gif">
<div id="fileQueue"></div>   
<input type="file" name=uploadify id="uploadify" />   
<br/>   
 <p><br/>   
<a href="javascript:jQuery('#uploadify').uploadifyUpload()">开始上传</a>&nbsp;   
<a href="javascript:jQuery('#uploadify').uploadifyClearQueue()">取消所有上传</a>   
</p>  
</td>
</tr>
</table>
</form>
</body>
</html>
