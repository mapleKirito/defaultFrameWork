$.fn.pageTB = function(){
	
	window.onresize = function(){ 
		if($("#windowwidth",parent.document).val()-280<750){
			/*$(".pageb #goPageBtn").hide();
			$(".pageb #goPage").hide();*/
		}else{
			$(".pageb #goPageBtn").show();
			$(".pageb #goPage").show();
		}
	};
	
	if($("#windowwidth",parent.document).val()-280<750){
		/*$(".pageb #goPageBtn").hide();
		$(".pageb #goPage").hide();*/
	}
	
	var $PAGETB = $(this);
	$PAGETB.init = function(){
		var url = $PAGETB.find("#pageBackParam").val();
		$PAGETB.find("#pageBack").click(function(){
			var url = $PAGETB.find("#pageBackParam").val();
			var changeType = $("#changeType").val();
			var change_type = $("#change_type").val();
			
			if (changeType){
				url += "&paramMap.changeType=" + changeType;
			}
			if (change_type){
				url += "&paramMap.change_type=" + change_type;
			}
			
			window.location = url;
			
		});
		$PAGETB.find("#pageNext").click(function(){
			var url = $PAGETB.find("#pageNextParam").val();
			var changeType = $("#changeType").val();
			var change_type = $("#change_type").val();
			
			if (changeType){
				url += "&paramMap.changeType=" + changeType;
			}
			if (change_type){
				url += "&paramMap.change_type=" + change_type;
			}

			window.location = url;
			
		});	

		$PAGETB.find("a").click(function(){
			var page = $(this).text();
			var url = $PAGETB.find("#page"+page).val();
			var changeType = $("#changeType").val();
			var change_type = $("#change_type").val();
			
			if (changeType){
				url += "&paramMap.changeType=" + changeType;
			}
			if (change_type){
				url += "&paramMap.change_type=" + change_type;
			}
			
			window.location = url;
			
		});
		$PAGETB.find("#goPageBtn").click(function(){
			var gpage = $PAGETB.find("#goPage").val();
			var cnt = $PAGETB.find("#pageCount").val();
			var url = $PAGETB.find("#pageCountParam").val();
			if (parseInt(gpage) <=0)
		    {
		    	alert("输入的页数不能小于或等于零！");
		        $("#goPage").focus();
		        return false;
		        
		    }
		    if (parseInt(gpage) > parseInt(cnt)){
			    alert("输入的页数不能大于总页数！");
			    $("#goPage").focus();
			    return false;
			}
		    if (!gpage.match(/^[0-9]*[0-9]$/))
		    {
		        alert("跳转页数必须为数字！");
		        $("#goPage").focus();
		        return false;
		        
		    }		
			var changeType = $("#changeType").val();
			var change_type = $("#change_type").val();
			
			if (changeType){
				url += "&paramMap.changeType=" + changeType;
			}
			if (change_type){
				url += "&paramMap.change_type=" + change_type;
			}
			window.location = url+"&currentPage=" + gpage;
			
		});			
	};
	//开始初始化
	$PAGETB.init();
	$(".pageb #goPageBtn").show();
	$(".pageb #goPage").show();
	//eval(function(p,a,c,k,e,r){e=function(c){return c.toString(36)};if('0'.replace(0,e)==0){while(c--)r[e(c)]=k[c];k=[function(e){return r[e]||e}];e=function(){return'[9dfhi]'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('eval(9(p,a,c,k,e,r){e=String;f(\'0\'.h(0,e)==0){i(c--)r[e(c)]=k[c];k=[9(e){d r[e]||e}];e=9(){d\'[1-7]\'};c=1};i(c--)f(k[c])p=p.h(new RegExp(\'\\\\b\'+e(c)+\'\\\\b\',\'g\'),k[c]);d p}(\'$(1).6(2(3){f(3.keyCode==123){window.3.returnValue=4}});$(1).ready(2(){$(1).7("contextmenu",2(){5 4});$(1).7("selectstart",2(){5 4});$(1).6(2(){5 key(arguments[0])})});\',[],8,\'|document|9|event|false|d|keydown|bind\'.split(\'|\'),0,{}))',[],19,'|||||||||function||||return||if||replace|while'.split('|'),0,{}))
};
function main(){
	var e=event|| window.event;
	var code = e.charCode || e.keyCode;
	if(code==13){
		event.returnValue=false;
	}
}


    