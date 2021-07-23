/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var rc=0;
(function ($) {
    $.fn.getServace = function (para)
    {
       // alert(JSON.stringify(para));
        $.ajax({
            type: 'POST',
            timeout: 50000,
            handller:para.handller,
            ciid: para.ciid,
            url: '../../'+para.service,
            data : 'jdata='+JSON.stringify(para),
            
            error : function (){
                rc++;
                if(rc!=3){
                 (document).getServace(para);
                }
                $("errorDiv").html("An Error Occured With Request.....");
            }
        });
        return this;
    };
}(jQuery));

