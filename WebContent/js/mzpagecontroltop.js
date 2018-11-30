var pchis =
{
  redJut    : "pchBlueJut.gif",
  redLeft   : "pchBlueLeft.gif",
  redBg     : "pchBlueBg.gif",
  redRight  : "pchBlueRight.gif",

  goldJut   : "pchBlueJut.gif",
  goldLeft  : "pchBlueLeft.gif",
  goldBg    : "pchBlueBg.gif",
  goldRight : "pchBlueRight.gif",

  grassJut    : "pchBlueJut.gif",
  grassLeft   : "pchBlueLeft.gif",
  grassBg     : "pchBlueBg.gif",
  grassRight  : "pchBlueRight.gif",

  orangeJut   : "pchBlueJut.gif",
  orangeLeft  : "pchBlueLeft.gif",
  orangeBg    : "pchBlueBg.gif",
  orangeRight : "pchBlueRight.gif",

  plumJut   : "pchBlueJut.gif",
  plumLeft  : "pchBlueLeft.gif",
  plumBg    : "pchBlueBg.gif",
  plumRight : "pchBlueRight.gif",

  lightblueJut   : "pchLightBlueJut.gif",
  lightblueLeft  : "pchLightBlueLeft.gif",
  lightblueBg    : "pchLightBlueBg.gif",
  lightblueRight : "pchLightBlueRight.gif",

  purpleJut   : "pchPurpleJut.gif",
  purpleLeft  : "pchPurpleLeft.gif",
  purpleBg    : "pchPurpleBg.gif",
  purpleRight : "pchPurpleRight.gif",

  blueJut   : "pchBlueJut.gif",
  blueLeft  : "pchBlueLeft.gif",
  blueBg    : "pchBlueBg.gif",
  blueRight : "pchBlueRight.gif",
  pchBg     : "pchBg.gif"
}
function PrestorePicture(b)
{

    for(i in pchis)
    {
        var tem   = b ? pchis[i] : pchis[i].src;
        pchis[i]  = new Image();
        pchis[i].src = tem;

    }
    setTimeout(PrestorePicture, 100000);
}


function MzPageControlTop(Tname)
{
    if(typeof(Tname) != "string" || Tname == "")
    {
        throw(new Error(-1, '声明类的时候请把类实例的引用变量名传递进来！'));
    }
    this.items    = new Array();
    this.iframes  = null;
    this.name     = Tname;
    this.self     = this;
    this.imgPath  = null;
    this.pchBgs   = new Array("blue",    "red",     "purple",  "gold",    "plum",    "lightblue","orange",    "grass");
  //  this.colors   = new Array("#ACDDAE", "#E7A89F", "#AEB9D4", "#DFAB7D", "#D5A4BB", "#91BAAE",  "#F6B078", "#B7C997");
    this.colors   = new Array("#AEB9D4", "#AEB9D4", "#AEB9D4", "#AEB9D4", "#AEB9D4", "#AEB9D4",  "#AEB9D4", "#AEB9D4");
    this.activeNum= -1; //active table's index(global)

    this.add = function(caption, url)
    {
        var newItem = new item(this.headBg(this.items.length), caption, url);
        this.items[this.items.length] = newItem;
        return newItem;
    }
    this.headBg   = function(num){return this.pchBgs[num%this.pchBgs.length];}
    this.headColor= function(num){return this.colors[num%this.pchBgs.length];}
    this.toString = function()
    {
        PrestorePicture(true);
        var str = "<table id='PageControlTable' border=0 cellpadding=0 cellspacing=0 height='100%' width='100%'>"+
        "<tr><td height=20 bgcolor='#EBEBEB' valign=bottom nowrap>"+
        "<div style='height: 20' id='PageControlHeadCase' nowrap>"+
        "<table border=0 cellspacing=0 cellpadding=0 align=left><tr><td width=50></td>"+
        "<td width=16 height=20 background='"+ pchis["redJut"].src +"'><div onselectstart='return false' "+
        "style='width: 100%; height: 100%; border-bottom: #3B619C 1px solid;'></div></td></tr></table>";
        for(var i=0; i<this.items.length; i++)
           str += this.items[i].toString(i);
        str += "</div></td></tr><tr><td id='PageControlPanel' style='padding: 5' bgcolor='#8AA7E3'>";
        for(var i=0; i<this.items.length; i++)
        {
            str += "<iframe name='content"
            + (i+1)
            + "' width='100%' "
            + "height='100%' framespacing='0' frameborder='0' style='overflow:auto;display: none; border: 0.5px solid #003399'></iframe>";
        }
        str += "</td></tr></table>";
        return str;

    }
    this.setActive= function(num)
    {
        var pcc = getObjectById("PageControlHeadCase");
        if(!pcc)
        {
            throw(new Error(-1, 'Page Control 容器创建失败！'));
        }
        var tab = pcc.getElementsByTagName("TABLE");

        if(num<1)
        {
            return;
        }
        if (this.iframes==null)
        {
            this.iframes = getObjectById("PageControlPanel").getElementsByTagName("IFRAME");
        }
        if(this.activeNum != -1)
        {
            with(tab[this.activeNum-1].rows[0])
            {
                cells[cells.length-1].firstChild.style.borderBottom = "#3B619C 1px solid";
                cells[cells.length-1].firstChild.style.backgroundImage = "none";
            }
            with(tab[this.activeNum].rows[0])
            {
                cells[0].firstChild.style.borderBottom = cells[1].firstChild.style.borderBottom;
                cells[2].firstChild.style.borderBottom = "#3B619C 1px solid";
            }
        }
        this.activeNum = num;
        with(tab[num-1].rows[0])
        {
        	alert(cells[cells.length-1].firstChild)
            if(cells[cells.length-1].firstChild.style)
            {
                borderBottom = this.headColor(num-1) +" 1px solid";
                backgroundImage = "url('"+ pchis[this.headBg(num-1)+"Jut"].src +"')";
            }
        }
        with(tab[num].rows[0])
        {
            cells[0].firstChild.style.borderBottom = cells[1].firstChild.style.borderBottom;
            cells[2].firstChild.style.borderBottom = this.headColor(num-1) +" 1px solid";
        }
        getObjectById("PageControlPanel").bgColor = this.headColor(num-1);
        for(var i=0; i<this.iframes.length; i++)
        {
            this.iframes[i].style.display = "none";
        }
        with(this.iframes[num-1])
        {
            if(src=="")
            {
                src=this.items[num-1].url;
            }
           // getObjectById("content" + num).src = src;
            //this.iframes[num-1].src = src;
            style.display="";
        }
    }

    //window.attachEvent("onload", function(){eval(Tname).setActive(1)});
    function item(color, text, url)
    {

        this.text     = text  ? text  : "无标题";
        this.color    = color ? color : "blue";
        this.url      = url   ? url   : "about:blank";
        this.toString = function(num)
        {
            var dcs = " style='width: 100%; height: 100%; cursor: default; border-bottom: 0px solid #3B619C;'"
            var str = "<table border=0  cellpadding=0 cellspacing=0 align=left><tr>"+
            "<td width=5 height=20 background='"+ pchis[this.color+"Left"].src +"'><div"+ dcs +"></div></td>"+
            "<td background='"+ pchis[this.color+"Bg"].src +"'><div"+ dcs +" style='padding: 4 2 0 10;"+
            " font-size: 9pt' noWrap onclick='"+ Tname +".setActive("+(num+1)+")'>"+ this.text +"</div></td>"+
            "<td width=16 background='"+ pchis[this.color+"Right"].src +"'><div"+ dcs +"></div></td>"+
            "</tr></table>";
//            alert(str)
            return str;

        }
    }
}
function getObjectById(id)
{
    if (typeof(id) != "string" || id == "")
    {
        throw(new Error(-1, '传到函数 getObjectById 里的参数不对！'));
    }
    if (document.all)
    {
        return document.all(id);
    }
    try
    {
        return document.getElementById(id);
    }
    catch(e)
    {
        return eval(id);
    }
}
//-->
