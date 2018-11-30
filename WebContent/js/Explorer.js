function Explorer() 
{ 
   var explorer = window.navigator.userAgent ;
	//ie 
	if (explorer.indexOf("MSIE") >= 0) {
		//alert("ie");
		return "ie";
	}
	//firefox 
	else if (explorer.indexOf("Firefox") >= 0) {
		//alert("Firefox");
		return "Firefox";
	}
	//Chrome
	else if(explorer.indexOf("Chrome") >= 0){
		//alert("Chrome");
		return "Chrome";
	}
	//Opera
	else if(explorer.indexOf("Opera") >= 0){
		//alert("Opera");
		return "Opera";
	}
	//Safari
	else if(explorer.indexOf("Safari") >= 0){
		//alert("Safari");
		return "Safari";
	} 
} 

function IEversion(){
	var browser=navigator.appName; 
	var b_version=navigator.appVersion;
	var version=b_version.split(";"); 
	var trim_Version=version[1].replace(/[ ]/g,""); 
	if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
	{ 
		return "6.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") 
	{ 
		return "7.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
	{ 
		return "8.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0") 
	{ 
		return "9.0";
	} 
}