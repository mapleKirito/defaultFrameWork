/*
 * contactable 1.2.1 - jQuery Ajax contact form
 *
 * Copyright (c) 2009 Philip Beel (http://www.theodin.co.uk/)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) 
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * Revision: $Id: jquery.contactable.js 2010-01-18 $
 *
 */
 
//extend the plugin
(function($){

	//define the new for the plugin ans how to call it	
	$.fn.contactable = function(options) {
		//set default options  
		var defaults = {
			hideOnSubmit: true
		};

		//call in the default otions
		var options = $.extend(defaults, options);
		//act upon the element that is passed into the design    
		return this.each(function(options){
			//construct the form
			//$(this).html(''+defaults.disclaimer+'');
			//show / hide function
			$('div#contactable').toggle(function() {
				//$('#overlay').css({display: 'block'});
				$(this).css({'background-image':'url(images/fold.jpg)'});
				$(this).animate({"marginLeft": "-=5px"}, "fast"); 
				$('#contactForm').animate({"marginLeft": "-=0px"}, "fast");
				$(this).animate({"marginLeft": "+=549px"}, "slow"); 
				$('#contactForm').animate({"marginLeft": "+=550px"}, "slow"); 
			}, 
			function() {
				$(this).css({'background-image':'url(images/unfold.jpg)'});
				$('#contactForm').animate({"marginLeft": "-=550px"}, "slow");
				$(this).animate({"marginLeft": "-=549px"}, "slow").animate({"marginLeft": "+=5px"}, "fast"); 
				//$('#overlay').css({display: 'none'});
			});
		});
	};
})(jQuery);

