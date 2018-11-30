$(document).ready(function(){
	//window.parent.menuTabTextNavigation($("#navigationhead").html());
	//alert($("#navigationhead").html());

	if( typeof window.parent.menuTabTextNavigation === 'function' ){
	    //存在且是function
		window.parent.menuTabTextNavigation($("#navigationhead").html());
	}else if( typeof window.parent.parent.menuTabTextNavigation === 'function' ){
	    //不存在或不是function
		window.parent.parent.menuTabTextNavigation($("#navigationhead").html());
	}else{
		
	}
	
});