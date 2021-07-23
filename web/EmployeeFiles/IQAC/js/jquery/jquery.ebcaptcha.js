(function($){

	jQuery.fn.ebcaptcha = function(options){

		var element = this; 
		var button = $(this).find('input[type=button]');

	//	$('<div style="width:50%;text-align:center;background:green" id="ebcaptchatext" ></div>').insertBefore(button);
		$('<label id="ebcaptchatext"  style="width:40%;text-align:center;"></label>').insertBefore(button);
		$('<input type="text" class="textbox" id="ebcaptchainput" style="width:30%;"/><br/><br/><br/>').insertBefore(button);
		var input = this.find('#ebcaptchainput'); 
		var label = this.find('#ebcaptchatext'); 
		$(element).find('input[type=button]').attr('disabled','disabled');
//		var randomNr1 = 0;
//		var randomNr2 = 0;
//		var totalNr = 0;
//		randomNr1 = Math.floor(Math.random()*10);
//		randomNr2 = Math.floor(Math.random()*10);
//		randomNr3 = Math.floor(Math.random()*10);
//		randomNr4 = Math.floor(Math.random()*10);
//		totalNr = randomNr1 + randomNr2;
//		var texti = "What is "+randomNr1+" + "+randomNr2 +" =   ";
 var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
            var string_length =5;// Math.floor((Math.random() * 5) + 1);
            var randomstring = '';
            for (var i = 0; i < string_length; i++) {
                var rnum = Math.floor(Math.random() * chars.length);
                randomstring += chars.substring(rnum, rnum + 1)+"";
            }
		var texti = randomstring;
		$(label).text(texti);
         $("#caid").val(texti.replace(/ /g,""));
        $(input).keyup(function(){
			var nr = $(this).val();
            $(this).val(nr.replace(" ", ""));

//            nr= nr.replace(" ","");
//            $("#caid").val(nr);
//			if(nr==totalNr)
//			{
//				$(element).find('input[type=button]').removeAttr('disabled');
//                 $('.errordiv').html("");
//			}
//			else{
//            $('.errordiv').html("Text Value is ("+"What is "+randomNr1+" + "+randomNr2 +" ="+totalNr+")");
//            $('#ebcaptchainput').focus();
//				$(element).find('input[type=button]').attr('disabled','disabled');
//			}
			
		});

		$(document).keypress(function(e)
		{
			if(e.which==13)
			{
				if((element).find('input[type=button]').is(':disabled')==true)
				{
					e.preventDefault();
					return false;
				}
			}

		});

	};

})(jQuery);

(function ($) {
    $.fn.progressbar = function (options)
    {
        var settings = $.extend({
        width:'300px',
        height:'25px',
        color:'#0ba1b5',
        padding:'0px',
        border:'1px solid #ddd'},options);

        //Set css to container
        $(this).css({
            'width':settings.width,
            'border':settings.border,
            'border-radius':'5px',
            'overflow':'hidden',
            'display':'inline-block',
            'padding': settings.padding,
            'margin':'0px 10px 5px 5px'
            });

        // add progress bar to container
        var progressbar =$("<div></div>");
        progressbar.css({
        'height':settings.height,
        'text-align': 'right',
        'vertical-align':'middle',
        'color': '#fff',
        'width': '0px',
        'border-radius': '3px',
        'background-color': settings.color
        });

        $(this).append(progressbar);

        this.progress = function(value)
        {
            var width = $(this).width() * value/100;
            progressbar.width(width).html(value+"% ");
        }
        return this;
    };

}(jQuery));