(function($){
$.fn.extend({
insertAtCaret: function(myValue){
var $t=$(this)[0];
if (document.selection) {
this.focus();
sel = document.selection.createRange();
sel.text = myValue;
this.focus();
}
else
if ($t.selectionStart || $t.selectionStart == '0') {
var startPos = $t.selectionStart;
var endPos = $t.selectionEnd;
var scrollTop = $t.scrollTop;
$t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
this.focus();
$t.selectionStart = startPos + myValue.length;
$t.selectionEnd = startPos + myValue.length;
$t.scrollTop = scrollTop;
}
else {
this.value += myValue;
this.focus();
}
}
})
})(jQuery);
//function AddOnPos(nowObj,inserValue)
//{
//		// 要插入的文本框
//	var $obj = nowObj;
//		//要插入的字符
//	var charvalue =inserValue;  
//    $obj.focus();
//    var r = document.selection.createRange();
//    var ctr = $obj.createTextRange();
//    var i;
//    var s = $obj.value;
//    //注释掉的这种方法只能用在单行的输入框input内
//    //对多行输入框textarea无效
//    //r.setEndPoint("StartToStart", ctr);
//    //i = r.text.length;
//    //取到光标位置----Start----
//    if($obj.type == 'textarea'){
//    var ivalue = "&^asdjfls2FFFF325%$^&"; 
//    r.text = ivalue;
//    i = $obj.value.indexOf(ivalue);
//    }
//    r.moveStart("character", -ivalue.length);
//    r.text = "";
//    //取到光标位置----End----
//    //插入字符
//    $obj.value = s.substr(0,i) + charvalue + s.substr(i,s.length);
//    ctr.collapse(true);
//    ctr.moveStart("character", i + charvalue.length);
//    ctr.select();
//}