/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

(function($){

    $.yattable = {
        // Default options
        defaults: {
            //specify a pixel dimension, auto, or 100%
            width: "900px",
            height: "300px",
            scrolling: "yes"
        }

		};

		$.fn.yattable = function(options){

		// Extend default options
		var options = $.extend({}, $.yattable.defaults, options);
		return this.each(function(){

				// Add jQuery methods to the element
				var $this = $(this);
				var $uniqueID = $(this).attr("ID") + ("wrapper");


				//Add dimentsions from user or default parameters to the DOM elements
				$(this).css('width', options.width).addClass("_scrolling");

				$(this).wrap('<div class="scrolling_outer"><div id="'+$uniqueID+'" class="scrolling_inner"></div></div>');

				$(".scrolling_outer").css({'position':'relative'});
				$("#"+$uniqueID).css(

					 {
                                             //'border':'1px solid #CCCCCC',
						'overflow-x':'hidden',
						'overflow-y':'auto'
                                                //'padding-right':'17px'
						//'padding-right':'17px'
						});

				$("#"+$uniqueID).css('height', options.height);
				$("#"+$uniqueID).css('width', options.width);

				// clone an exact copy of the scrolling table and add to DOM before the original table
				// replace old class with new to differentiate between the two
				$(this).before($(this).clone().attr("id", "").addClass("_thead").css(

						{
                                                    'width' : 'auto',
                                                    'display' : 'block',
                                                    'position':'absolute',
                                                    'border':'none'
                                                    //'border-bottom':'1px solid #CCC',
                                                    //'top':'1px'
                                                }));


				// remove all children within the cloned table after the thead element
				$('._thead').children('tbody').remove();


				$(this).each(function( $this ){
					// if the width is auto, we need to remove padding-right on scrolling container

					if (options.width == "100%" || options.width == "auto") {

						$("#"+$uniqueID).css({'padding-right':'0px'});
					}
				});

				// Get a relative reference to the "sticky header"
				$curr = $this.prev();

				// Copy the cell widths across from the original table
				$("thead:eq(0)>tr th",this).each( function (i) {

					$("thead:eq(0)>tr th:eq("+i+")", $curr).width( $(this).width());

				});

				//check to see if the width is set to auto, if not, we don't need to call the resizer function
				if (options.width == "100%" || "auto"){

						// call the resizer function whenever the table width has been adjusted
						$(window).resize(function(){
                                                        resizer($this);
						});
					}
				});

    };

		// private function to temporarily hide the header when the browser is resized

		function resizer($this) {

				// Need a relative reference to the "sticky header"
				$curr = $this.prev();

				$("thead:eq(0)>tr th", $this).each( function (i) {

					$("thead:eq(0)>tr th:eq("+i+")", $curr).width( $(this).width());

				});
  	};


})(jQuery);
/////////////////////////////////
//$("#materialTableList").yattable({
//        width: "100%",
//        height: $(window).height()-$('#toolBarTable').height()-$('#searchTable').height()-50+"px",
//        scrolling: "yes"
//    });

