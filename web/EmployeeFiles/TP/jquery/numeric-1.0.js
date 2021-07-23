/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
jQuery.fn.numeric = function(decimal, callback)
{
	decimal = decimal || ".";
	callback = typeof callback == "function" ? callback : function(){};
	this.keypress(
		function(e)
		{
			var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
			// allow enter/return key (only when in an input box)
			if(key == 13 && this.nodeName.toLowerCase() == "input")
			{
				return true;
			}
			else if(key == 13)
			{
				return false;
			}
			var allow = false;

                        if(e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 35 || e.keyCode == 36 || e.keyCode == 37 || e.keyCode == 39 || e.keyCode == 46) return true;
			// allow Ctrl+A
			if((e.ctrlKey && key == 97 /* firefox */) || (e.ctrlKey && key == 65) /* opera */) return true;
			// allow Ctrl+X (cut)
			if((e.ctrlKey && key == 120 /* firefox */) || (e.ctrlKey && key == 88) /* opera */) return true;
			// allow Ctrl+C (copy)
			if((e.ctrlKey && key == 99 /* firefox */) || (e.ctrlKey && key == 67) /* opera */) return true;
			// allow Ctrl+Z (undo)
			if((e.ctrlKey && key == 122 /* firefox */) || (e.ctrlKey && key == 90) /* opera */) return true;
			// allow or deny Ctrl+V (paste), Shift+Ins
			if((e.ctrlKey && key == 118 /* firefox */) || (e.ctrlKey && key == 86) /* opera */
			|| (e.shiftKey && key == 45)) return true;
			// if a number was not pressed
			if(key < 48 || key > 57)
			{
				/* '-' only allowed at start */
				if(key == 45 && this.value.length == 0) return true;
				/* only one decimal separator allowed */
				if(key == decimal.charCodeAt(0) && this.value.indexOf(decimal) != -1)
				{
					allow = false;
				}
				// check for other keys that have special purposes
				if(
					key != 8 /* backspace */ &&
					key != 9 /* tab */ &&
					key != 13 /* enter */ &&
					key != 35 /* end */ &&
					key != 36 /* home */ &&
					key != 37 /* left */ &&
					key != 39 /* right */ &&
					key != 46 /* del */
				)
				{
					allow = false;
				}
				else
				{
					// for detecting special keys (listed above)
					// IE does not support 'charCode' and ignores them in keypress anyway
					if(typeof e.charCode != "undefined")
					{
						// special keys have 'keyCode' and 'which' the same (e.g. backspace)
						if(e.keyCode == e.which && e.which != 0)
						{
							allow = true;
						}
						// or keyCode != 0 and 'charCode'/'which' = 0
						else if(e.keyCode != 0 && e.charCode == 0 && e.which == 0)
						{
							allow = true;
						}
					}
				}
				// if key pressed is the decimal and it is not already in the field
				if(key == decimal.charCodeAt(0) && this.value.indexOf(decimal) == -1)
				{
					allow = true;
				}
                                else{
                                        allow=false;
                                }
			}
			else
			{
				allow = true;
			}
			return allow;
		}
	)
	.blur(
		function()
		{
			var val = jQuery(this).val();
			if(val != "")
			{
				var re = new RegExp("^\\d+$|\\d*" + decimal + "\\d+");
				if(!re.exec(val))
				{
					callback.apply(this);
				}
			}
		}
	);
	return this;
}
jQuery.fn.numbernondecimal =function()
{
    return this.each(function()
    {
        $(this).keydown(function(e)
        {
            var key = e.charCode || e.keyCode || 0;
            // allow backspace, tab, delete, arrows, numbers and keypad numbers ONLY
            return (
                key == 8 || key == 36 || key == 13 ||
                key == 9 ||
                key == 46 ||
                (key >= 37 && key <= 40) ||
                (key >= 48 && key <= 57) ||
                (key >= 96 && key <= 105));
        })
    })
};
(function($){
    $.fn.alphanumeric = function(p) {
		p = $.extend({
			ichars: "!@#$%^&*()+=[]\\\';,/{}|\":<>?~`.- ",
			nchars: "",
			allow: ""
		  }, p);
		return this.each
			(
				function()
				{
					if (p.nocaps) p.nchars += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
					if (p.allcaps) p.nchars += "abcdefghijklmnopqrstuvwxyz";
					s = p.allow.split('');
					for ( i=0;i<s.length;i++) if (p.ichars.indexOf(s[i]) != -1) s[i] = "\\" + s[i];
					p.allow = s.join('|');
					var reg = new RegExp(p.allow,'gi');
					var ch = p.ichars + p.nchars;
					ch = ch.replace(reg,'');
					$(this).keypress
						(
							function (e)
								{
									if (!e.charCode) k = String.fromCharCode(e.which);
										else k = String.fromCharCode(e.charCode);
									if (ch.indexOf(k) != -1) e.preventDefault();
									if (e.ctrlKey&&k=='v') e.preventDefault();
								}
						);
					$(this).bind('contextmenu',function () {return false});
				}
			);
	};
        $.fn.numericalpha = function(p) {
		var az = "abcdefghijklmnopqrstuvwxyz";
		az += az.toUpperCase();
		p = $.extend({
			nchars: az
		  }, p);
		return this.each (function()
			{
				$(this).alphanumeric(p);
			}
		);
	};
})(jQuery);
(function($) {
    $.fn.twoDecimalFormat = function() {
        this.each( function( i ) {
            $(this).change( function( e ){
                if( isNaN( parseFloat( this.value ) ) ) return;
                this.value = parseFloat(this.value).toFixed(2);
            });
        });
        return this; //for chaining
    }
})( jQuery );


