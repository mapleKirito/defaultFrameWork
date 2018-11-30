$(document).keydown(function(event) {
	if (event.keyCode == 123) {
		window.event.returnValue = false;
	}
});
$(document).ready(function() {
	$(document).bind("contextmenu",
	function() {
		return false;
	});
	$(document).bind("selectstart",
	function() {
		return false;
	});
	$(document).keydown(function() {
		return key(arguments[0]);
	});
});