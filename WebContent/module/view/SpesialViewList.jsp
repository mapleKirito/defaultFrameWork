<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>


<html>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>
    <style type="text/css">
         html,body {height:100%;}
         body {margin:0;}
         img {width:680px; height:auto; position:absolute; left:50%; top:50%; margin-top:-230px; margin-left:-340px;}
         #bg {width:100%; height:100%; position:absolute; left:0; top:0; filter:alpha(opacity:60); opacity:0.6; background:black; z-index:1;}
         #prog {width:324px; height:40px; background:url(images/bar.png) no-repeat 0 20px; position:absolute; z-index:2; top:50%; left:50%; margin:-20px 0 0 -162px; font-family:arial; font-size:12px; color:#fff; text-align:center;}
         #prog span {font-family:"宋体";}
         #bar {width:0%; height:16px; background:url(images/bar_line.gif) repeat-x; overflow:hidden; position:absolute; bottom:2px; left:2px;}
     </style>
<script type="text/javascript">

</script>
</head>

<body style="background-color: #2b2b2b">
    <script type="text/javascript">
        window.onload = function () {
            var SCALE = 10;
            var oImg = document.getElementById('img1');
            var oTxt = document.getElementById('prog').getElementsByTagName('span')[0];
            var oBar = document.getElementById('bar');
            var aImg = [];
            var Count = 89;
            var iImgCount=Count;
            var iLoaded = 0;
            var iNow = 0;
            var i = 0;
            var k = 0;
            var mode=1;
			var path1 = 'a2';
            //加载所有资源
            if (mode=='1'){
            iImgCount=Count*2;
            }
            for (i = 0; i < Count; i++) {
                (function (i) {
                    var oNewImg = new Image();
                    oNewImg.onload = function () {
                        oTxt.innerHTML = oBar.style.width = Math.ceil(100 * iLoaded / iImgCount) + '%';
                        oNewImg.onload = null;
                        var oImg = document.createElement('img');
                        oImg.src = this.src;
                        oImg.style.display = 'none';
                        document.body.appendChild(oImg);
                        aImg[i] = oImg;
                         if (++iLoaded == iImgCount) onLoad();
                    };
                    oNewImg.src = '<%=request.getContextPath()%>/upload/a2/3d_image (' + i + ').jpg';
                })(i);
            }
            if (mode=='1'){
            for (k = i; k < iImgCount; k++) {
            var j=iImgCount-k-1;
                (function (k) {
                    var oNewImg = new Image();
                    oNewImg.onload = function () {
                        oTxt.innerHTML = oBar.style.width = Math.ceil(100 * iLoaded / iImgCount) + '%';
                        oNewImg.onload = null;
                        var oImg = document.createElement('img');
                        oImg.src = this.src;
                        oImg.style.display = 'none';
                        document.body.appendChild(oImg);
                        aImg[k] = oImg;
                        if (++iLoaded == iImgCount) onLoad();
                    };
                    oNewImg.src = '<%=request.getContextPath()%>/upload/a2/3d_image (' + j + ').jpg';
                })(k);
            }
            }
            //效果
            function onLoad() {
                for (i = 0; i < iImgCount; i++) if (!aImg[i]) alert('资源加载失败，请刷新重试');
                var lastImg = null;
                document.getElementById('prog').style.display = document.getElementById('bg').style.display = 'none';
                //document.body.removeChild(oImg);
                var body = document.body;
                oImg = null;
                var timer = null;
                var num = iNow;
                var speed = 0;
 
                aImg[0].style.display = 'block';
                lastImg = aImg[0];
                document.ontouchstart = function (ev) {
                    var oEvent = ev;
                    var startX = oEvent.targetTouches[0].clientX;
                    var lastX = startX;
 
                    if (body.setCapture) {
                        body.ontouchmove = onMove;
                        body.ontouchend = onUp;
 
                        body.setCapture();
                    }
                    else {
                        document.ontouchmove = onMove;
                        document.ontouchend = onUp;
                    }
 
                    function onMove(ev) {
                        var oEvent = ev;
                        var i = -(oEvent.targetTouches[0].clientX - startX) / SCALE;
 
                        num = (iNow + i + Math.abs(Math.floor(i / iImgCount)) * iImgCount) % iImgCount;
 
                        if (lastImg != aImg[parseInt(num)]) {
                            lastImg.style.display = 'none';
                            aImg[parseInt(num)].style.display = 'block';
                            lastImg = aImg[parseInt(num)];
                        }
 
                        speed = -(oEvent.targetTouches[0].clientX - lastX) / SCALE;
                        lastX = oEvent.targetTouches[0].clientX;
 
                        return false;
                    }
 
                    function onUp() {
                        this.ontouchmove = null;
                        this.ontouchend = null;
 
                        if (body.releaseCapture) body.releaseCapture();
 
                        iNow = num;
 
                        startMove();
                    }
 
                    stopMove();
 
                    return false;
                };
                document.onmousedown = function (ev) {
                    var oEvent = ev || event;
                    var startX = oEvent.clientX;
                    var lastX = startX;
 
                    if (body.setCapture) {
                        body.onmousemove = onMove;
                        body.onmouseup = onUp;
 
                        body.setCapture();
                    }
                    else {
                        document.onmousemove = onMove;
                        document.onmouseup = onUp;
                    }
 
                    function onMove(ev) {
                        var oEvent = ev || event;
                        var i = -(oEvent.clientX - startX) / SCALE;
 
                        num = (iNow + i + Math.abs(Math.floor(i / iImgCount)) * iImgCount) % iImgCount;
 
                        if (lastImg != aImg[parseInt(num)]) {
                            lastImg.style.display = 'none';
                            aImg[parseInt(num)].style.display = 'block';
                            lastImg = aImg[parseInt(num)];
                        }
 
                        speed = -(oEvent.clientX - lastX) / SCALE;
                        lastX = oEvent.clientX;
 
                        return false;
                    }
 
                    function onUp() {
                        this.onmousemove = null;
                        this.onmouseup = null;
 
                        if (body.releaseCapture) body.releaseCapture();
 
                        iNow = num;
 
                        startMove();
                    }
 
                    stopMove();
 
                    return false;
                };
 
                function startMove() {
                    timer = setInterval(function () {
                        iNow = (iNow + speed + Math.abs(Math.floor(i / iImgCount)) * iImgCount) % iImgCount;
                        lastImg.style.display = 'none';
                        aImg[parseInt(iNow)].style.display = 'block';
                        lastImg = aImg[parseInt(iNow)];
 
                        speed *= 0.884;
 
                        if (Math.abs(speed) <= 1) {
                            clearInterval(timer);
                            speed = 0;
                        }
                    }, 30);
                }
 
                function stopMove() {
                    clearInterval(timer);
                }
            }
        };
    </script>
    <div id="bg" style="text-align: center; padding-left: 20px;">
        <div id="prog">
            <span style="color: #FFFFFF;">载入中......0%</span>
            <div id="bar">
            </div>
        </div>
    </div>
    
</body>
</HTML>
