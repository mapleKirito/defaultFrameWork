function MM_preloadImages() { //v3.0
	var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
    var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
    var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
        d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
    if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
    for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
    if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
    var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
        if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function funcExit()
{
	var rv = confirm("您确认要注销退出吗？");
	if (rv)
	{
		location = "exit.jsp";
	}
}

function labelActive(num,cnt,code) 
{		
	for (var i=1; i<=cnt; i++)
	{
		var _jutObj = document.getElementById("jut" + (parseInt(i) - 1));
		var jutObj = document.getElementById("jut" + i);
		var leftObj = document.getElementById("left" + i);
		var bgObj = document.getElementById("bg" + i);
		var rightObj = document.getElementById("right" + i);
		if (parseInt(num) == i)
		{
			if (_jutObj) 
			{
				_jutObj.className = "labelonJut";		
			}		
			if (leftObj) 
			{
				leftObj.className = "labelonLeft";		
			}
			if (bgObj) 
			{
				bgObj.className = "labelonBg";			
			}
			if (rightObj) 
			{
				rightObj.className = "labelonRight";			
			}	
			if (jutObj) 
			{
				jutObj.className = "labelonRight";			
			}
		}
		else
		{	
			if (leftObj) 
			{
				leftObj.className = "labeloutLeft";		
			}
			if (bgObj) 
			{
				bgObj.className = "labeloutBg";			
			}
			if (rightObj) 
			{
				rightObj.className = "labeloutRight";			
			}	
			if (jutObj) 
			{
				jutObj.className = "labeloutRight";			
			}				
		}
		if (num != 1)
		{
			var _jutObj = document.getElementById("jut0");
			if (_jutObj) 
			{
				_jutObj.className = "labeloutJut";			
			}				
		}
	}		
	for (var j=1; j<=cnt; j++)
	{
		var contentObj = document.getElementById("content" + j);
		if (contentObj)
		{
			if (j == num)
			{
				if (!contentObj.src)
					contentObj.src = "forwardAction.action?code=" + code;
				contentObj.style.display = "block";
			}
			else
			{
				contentObj.style.display = "none";
			}
		}
	}
}
function selectAll(obj)
{
	var dom = document.getElementsByTagName("input");
	if (obj.checked)
	{
	   for(var i = 0; i < dom.length; i ++ )
	   {
	      if(dom[i].name == "checkValue" && dom[i].tagName.toLowerCase() == "input" && dom[i].type.toLowerCase() == "checkbox")
	      {
	    		  dom[i].checked = true;
	      }
	   }
	}
	else
	{
	   for(var i = 0; i < dom.length; i ++ )
	   {
	      if(dom[i].name == "checkValue" && dom[i].tagName.toLowerCase() == "input" && dom[i].type.toLowerCase() == "checkbox")
	      {
	         dom[i].checked = false;
	      }
	   }		
	}
}
function funcover(obj) {
	obj.className = "btnout";
}
function funcout(obj) {
	obj.className = "btnover";
}
function funcJump(pageUrl)
{
	window.location = pageUrl  + "&" + Form.serialize(document.forms[0].name);
}
function funcSelectJump(obj,pageUrl,params)
{
	var cpage = obj.options[obj.selectedIndex].value;
	if (!cpage)
		cpage = 1;
	window.location = pageUrl + "?currentPage="  + cpage + "&" + params;
	//  + "&" + Form.serialize(document.forms[0].name);
}
function pointJump(pageCount)
{
    var targetPage = document.getElementById("targetPage").value;
    if (targetPage <= 0 || targetPage > pageCount)
    {
        alert("您输入的页数不正确！");
        document.getElementById("targetPage").focus();
        return false;
    }
    if (!targetPage.match(/^[0-9]*[0-9]$/))
    {
        alert("跳转页数必须为数字！");
        document.getElementById("targetPage").focus();
        return false;
    }

}



    