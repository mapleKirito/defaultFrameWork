//显示表情菜单
function showFace(showid, target, img_path) {
	if(typeof($('#' + showid+'_menu'))=='object' && $('#' + showid+'_menu').css('display') == "block" ){ 
		$('#' + showid+'_menu').hide();
		return false;
	}
	var div = $('#uchome_face_bg');
	if($('#uchome_face_bg').length == 0) {
		div = document.createElement('div');
		div.id = 'uchome_face_bg';
		div.style.position = 'absolute';
		div.style.left = div.style.top = '0px';
		div.style.width = '100%';
		div.style.height = document.body.scrollHeight + 'px';
		div.style.backgroundColor = '#FFFFFF';
		div.style.zIndex = 10000;
		div.style.display = 'none';
		div.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=0,finishOpacity=100,style=0)';
		div.style.opacity = 0;
	}
	div.onclick = function() {
		$('#' + showid+'_menu').hide();
		$('#uchome_face_bg').hide();
	}
	$('#append_parent').append(div);
	
	if($('#' + showid + '_menu').length>0) {
		$('#' + showid+'_menu').show();
	} else {
		var faceDiv = function(){
    		var parentDiv=$('<div></div>');        
    		parentDiv.attr('id', showid+'_menu');
    		parentDiv.addClass('facebox');
			parentDiv.css({'width':'250px','background':'#fff','border':'1px solid #ccc','padding':'8px','z-index':'100000','position':'absolute'});

    		var ulDiv=$('<ul style="padding:0;"></ul>');
    		ulDiv.attr('id','facelist');
   		 	ulDiv.appendTo(parentDiv);
			
			var face_item = '';
			for(i=1; i<31; i++) {
				face_item += '<li style="width:25px; height:25px; float:left; overflow:hidden;"><img src="'+img_path+'face/'+i+'.gif" onclick="insertFace(\''+showid+'\','+i+', \''+ target +'\')" style="cursor:pointer; position:relative;" /></li>';
			}
			ulDiv.html(face_item);
			
			$('#append_parent').show().append(parentDiv);
		}
		faceDiv();
	}
	//定位菜单
	setMenuPosition(showid, 0);
	$('#uchome_face_bg').show();
}
//插入表情
function insertFace(showid, id, target) {
	var faceText = '[em:'+id+':]';
	if($('#'+target).length > 0) {
		$('#'+target).insertAtCaret(faceText);
		//insertContent(target, faceText);
	}
	if($("#content").val().length<=140)
		$('.state_num').html($("#content").val().length+"/140")  //获取评论框字符长度并添加到ID="num"元素上 
	else{
		$('.state_num').html("<font color='#FF0000'>"+ $("#content").val().length+"/140</font>")  //获取评论框字符长度并添加到ID="num"元素
	}
	$('#'+showid+'_menu').hide();
	$('#uchome_face_bg').hide();
}

function setMenuPosition(showid, offset) {

	var showobj = $('#'+showid);
	var menuobj = $('#'+showid + '_menu');
	var s_o = showobj.offset();
	var s_l = s_o.left;
	var s_t = s_o.top;
	var s_w = showobj.width();
	var s_h = showobj.height();
	
	var m_o = menuobj.offset();
	var m_l = m_o.left;
	var m_t = m_o.top;
	
	var left = s_l;
	var top = s_t + s_h;
	menuobj.css('left', left);
	menuobj.css('top', top);
}


(function($){
	$.fn.extend({
		insertAtCaret: function(myValue){
			var $t=$(this)[0];
			if (document.selection) {
				this.focus();
				sel = document.selection.createRange();
				sel.text = myValue;
				this.focus();
			} else if ($t.selectionStart || $t.selectionStart == '0') {
				var startPos = $t.selectionStart;
				var endPos = $t.selectionEnd;
				var scrollTop = $t.scrollTop;
				$t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
				this.focus();
				$t.selectionStart = startPos + myValue.length;
				$t.selectionEnd = startPos + myValue.length;
				$t.scrollTop = scrollTop;
			} else {
				this.value += myValue;
				this.focus();
			}
		}
  })
})(jQuery);
