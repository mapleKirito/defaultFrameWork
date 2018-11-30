 $(document).ready(function(){
	 $("body").click(function(event){
	 	if($(event.target).attr("id") != "moreList" && $(event.target).attr("id") != "moreList"){
			$("html",window.parent.document).find(".moreList").hide();
	 		$("html",window.parent.document).find(".moreTabBtn").removeClass("onMore");
	 		$("html",window.parent.document).find(".moreTabBtn").removeClass("downMore");	 
		}
	 });
 });