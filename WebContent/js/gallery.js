$(function() {

	$.fn.imagesLoaded = function( callback ) {
		var $images = this.find('img'), len 	= $images.length, _this 	= this, blank 	= 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==';

		function triggerCallback() {
			callback.call( _this, $images );
		}

		function imgLoaded() {
			if ( --len <= 0 && this.src !== blank ){
				setTimeout( triggerCallback );
				$images.off( 'load error', imgLoaded );
			}
		}
	
		if ( !len ) {
			triggerCallback();
		}
	
		$images.on( 'load error',  imgLoaded ).each( function() {
			if (this.complete || this.complete === undefined){
				var src = this.src;
				this.src = blank;
				this.src = src;
			}
		});

		return this;
	};

	var $rgGallery	= $('#rg-gallery'), $esCarousel = $rgGallery.find('div.es-carousel-wrapper'), $items = $esCarousel.find('ul#es-carouselul > li'), itemsCount = $items.length;
	
	Gallery	= (function() {

				var current = 0, mode = 'carousel', anim = false, 
				init = function() {
				$items.add('<img style="margin-top:200px;margin-left:200px;" src="images/ajax-loader.gif"/><img src="images/black.png"/>').imagesLoaded( function() {

					
					
				    
					_addViewModes();
				 	
					_addImageWrapper();
					
					_showImage( $items.eq( current ) );
				
					
				});
				
				if( mode === 'carousel' )
					_initCarousel();
				
		},
		_initCarousel	= function() {
	
			$esCarousel.show().elastislide({
				imageW 	: 65,
				onClick	: function( $item ) {
					if( anim ) return false;
					anim	= true;
			
					_showImage($item);
				
					current	= $item.index();
				}
			});
			
			$esCarousel.elastislide( 'setCurrent', current );
			
		},
		_addViewModes	= function() {		
				
		},
		_addImageWrapper= function() {
			
			
		//	$('#img-wrapper-tmpl').tmpl( {itemsCount : itemsCount} ).appendTo( $rgGallery );
			
			if( itemsCount > 1 ) {
				var $navPrev		= $rgGallery.find('a.rg-image-nav-prev'),
					$navNext		= $rgGallery.find('a.rg-image-nav-next'),
					$imgWrapper		= $rgGallery.find('div.rg-image');

				$navPrev.click(function(){
					 $(".rg-image-controls table").hide();
		              $(".rg-image-fo").html("<img src='images/right.png' border=0 />");
				});
				
				$navNext.click(function(){
					 $(".rg-image-controls table").hide();
		              $(".rg-image-fo").html("<img src='images/right.png' border=0 />");
				});
				
				$navPrev.on('click.rgGallery', function( event ) {
					_navigate( 'left' );
					return false;
				});	
				
				$navNext.on('click.rgGallery', function( event ) {
					_navigate( 'right' );
					return false;
				});
				
				// add touchwipe events on the large image wrapper
				$imgWrapper.touchwipe({
					wipeLeft			: function() {
						_navigate( 'right' );
					},
					wipeRight			: function() {
						_navigate( 'left' );
					},
					preventDefaultEvents: false
				});
			
				$(document).on('keyup.rgGallery', function( event ) {
					if (event.keyCode == 39)
						_navigate( 'right' );
					else if (event.keyCode == 37)
						_navigate( 'left' );	
				});
				
			}
			
		},
		_navigate		= function( dir ) {
			
			// navigate through the large images
			
			if( anim ) return false;
			anim	= true;
			
			if( dir === 'right' ) {
				if( current + 1 >= itemsCount )
					current = 0;
				else
					++current;
			}
			else if( dir === 'left' ) {
				if( current - 1 < 0 )
					current = itemsCount - 1;
				else
					--current;
			}
			
			_showImage( $items.eq( current ) );
			
		},
		_showImage		= function( $item ) {
			
			// shows the large image that is associated to the $item
			var $loader	= $rgGallery.find('div.rg-loading').show();
			
			$items.removeClass('selected');
			$item.addClass('selected');
				 
			var $thumb		= $item.find('img'),
				largesrc	= $thumb.data('large'),
				title		= $thumb.data('description');
			       
		      //点击顶部按钮触发事件
		      $('div.rg-image-fo').toggle(function () {
	              $(".rg-image-controls table").hide();
	              $(".rg-image-fo").html("<img src='images/right.png' border=0 />");
	          }, function () {
	        	  $(".rg-image-controls table").show();
	        	  $(".rg-image-fo").html("<img src='images/left.png' border=0 />");
	          });
			
			  $('<img/>').load( function() {
				  var cliheight =  $("#windowheight",parent.document).val();    
			      var cliwidth = document.body.clientWidth;  
			      
			      //定义两旁按钮
			      var wi = ($('div.rg-image').width()-cliwidth)/2;
			      $(".rg-image-nav a").css("left",wi+40);
			      $(".rg-image-nav a.rg-image-nav-next").css("left",wi + cliwidth-10);
				  
		      	  var tw=0,th=0;
		      	  var img = new Image();
				  img.src = largesrc;
				  if (img.width > 0 && img.height > 0) {
						if (img.width / img.height >= cliwidth / cliheight) {
							if (img.width > cliwidth) {
								tw=(cliwidth);
								th=((img.height * cliwidth) / img.width);
							} else {
								tw=(img.width);
								th=(img.height);
							}
						} else {
							if (img.height > cliheight) {
								th=(cliheight);
								tw=((img.width * cliheight) / img.height);
							} else {
								tw=(img.width);
								th=(img.height);
							}
						}
				  }
				  
				  
				  
				 	$rgGallery.find('div.rg-image').empty().append('<img src="' + largesrc + ',width="'+tw+'"" height="'+th+'"  />');
			
					$loader.hide();
				
					if( mode === 'carousel' ) {
						$esCarousel.elastislide( 'reload' );
						$esCarousel.elastislide( 'setCurrent', current );
					}
					
					anim	= false;
					
			}).attr( 'src', largesrc );
			
		},
		addItems		= function( $new ) {
		
			$esCarousel.find('ul#es-carouselul').append($new);
			$items 		= $items.add( $($new) );
			itemsCount	= $items.length; 
			$esCarousel.elastislide( 'add', $new );
		
		};
		
		return { 
			init 		: init,
			addItems	: addItems
		};
	
	})();

	Gallery.init();
	
	function isFieldNull(fieldName){
		var reg = /^\s+$/;
	    if(typeof fieldName != 'undefined' && fieldName != '' && !reg.test(fieldName)){
	    	  return true;
	    }
	    return false;
    }
	 
});