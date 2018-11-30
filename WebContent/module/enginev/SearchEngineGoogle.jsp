<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
	function getWord() {
		var word = document.getElementById("word").value;

		window
				.open(
						'http://www.google.com.hk/#hl=zh-CN&newwindow=1&safe=strict&q='
								+ word
								+ '&oq='
								+ word
								+ '&gs_l=serp.12...14672.14750.0.15828.2.2.0.0.0.0.0.0..0.0...0.0..0.1c.toziQuHGRZE&bav=on.2,or.r_gc.r_pw.&fp=99bda128ad866c31&biw=1366&bih=635',
						'',
						'status=0,directories=0,resizable=1,toolbar=0,menubar=no,location=0,scrollbars=1,width=837,height=525');
	}
</script>
</head>
<body>
	


</body>
</html>