
var rc=0;
///////////////////////////////////////////////////////////////////////////////////////////
(function ($) {
    $.fn.getServace = function (para)
    {
        var $t = $(this);
        debugger;
        $.ajax({
            type: 'POST',
            timeout: 50000,
            mname:para.mname,
            url: '../CounsellingRequest?sid='+para.sid+'&refor=Hr_ApplicationMasterService',
            data : 'jdata='+JSON.stringify(para),
            success: function(e) {
               $t.empty();$t.append(e);

            },
            error : function (){
                rc++;
                if(rc!=3){
                  $t.getServace(para);
                }
                $("errorDiv").html("An Error Occured With Request.....");
            }
        });
        return this;
    };
}(jQuery));
////////////////////////////////////Save Service////////////////////////////////////////////
(function ($) {
    $.fn.saveServace = function (mname,sid,para)
    {
        alert(sid);
        $.ajax({
            type: 'POST',
            timeout: 50000,
            mname:mname,
            url: '../CounsellingRequest?sid='+sid+'&refor=Hr_ApplicationMasterService',
            data : 'jdata='+JSON.stringify(para),
            success: function(e) {

            },
            error : function (){
                rc++;
                if(rc!=3){
                  saveServace(para);
                }
                $("errorDiv").html("An Error Occured With Request.....");
            }
        });
        return this;
    };
}(jQuery));
//////////////////////////////////////////////////////////////////////////
$(document).ajaxComplete(function( event, xhr, settings ) {
    switch(settings.mname) {
        case 'cCountry':
            $("#pCountry").empty(); $("#pCountry").append(xhr.responseText);
            var jpara = {};
        jpara.sid='1004';
        jpara.mname='qualification';
        jpara.labelname='Select Qualification';
        $("#qualification1").getServace(jpara);
            break;
        case 'cState':
            if($('#pState').children('option').length==0){
                $("#pState").empty();$("#pState").append(xhr.responseText);
            }
            break;
        case 'cCity':
            if($('#pCity').children('option').length==0){
                $("#pCity").empty(); $("#pCity").append(xhr.responseText);
            }
            break;
        case 'pState':
            $("#pState").empty();$("#pState").append("<option selected value='0'>Select State</option>");$("#pState").append(xhr.responseText);
            break;
        case 'pCity':
            $("#pCity").empty(); $("#pCity").append(xhr.responseText);
            break;
        case 'basicInformationSave':
            $("#hrappid").val(xhr.responseText);

            uiMessage("Basic Information ","Save Successfully","green")
            break;
        case 'addressInformationSave':
            if(xhr.responseText=='success'){
                uiMessage("Address ","Save Successfully","green");
            }
            break;
        case 'experienceInformationSave':
              uiMessage("Experience ",xhr.responseText,"green");
             break;
        case 'bookPublicationInformationSave':
              uiMessage("Book Publication ",xhr.responseText,"green");
             break;
        case 'paperPublicationInformationSave':
              uiMessage("Paper Publication ",xhr.responseText,"green");
             break;
        case 'workShopInformationSave':
              uiMessage("Work Shop ",xhr.responseText,"green");
             break;
        case 'presentationInformationSave':
              uiMessage("Work Shop ",xhr.responseText,"green");
             break;
        case 'qualification':
           alert(xhr.responseText);

           break;

    }
});
//////////////////////////////////////////////////////////////////////////////////////////////
function getCountryCombo1(){
    jpara.sid='1001';
    jpara.mname='cCountry';
    jpara.labelname='Select Country';
    $("#pCountry").getServace(jpara);
}

function getStateCombo(){
   jpara.sid='1002';
   jpara.mname='cState';
   jpara.labelname='Select State';
   jpara.countryid=$("#cCountry").val();
   $("#cState").getServace(jpara);
}

function getStateCombo1(){
   jpara.sid='1002';
   jpara.mname='pState';
   jpara.labelname='Select State';
   jpara.countryid=$("#pCountry").val();
   $("#pState").getServace(jpara);
    $("#pCity").empty();
}

function getCityCombo(){
   jpara.sid='1003';
   jpara.mname='cCity';
   jpara.labelname='Select City';
   jpara.stateid=$("#cState").val();
   $("#cCity").getServace(jpara);
}

function getCityCombo1(){
   jpara.sid='1003';
   jpara.mname='pCity';
   jpara.labelname='Select City';
   jpara.stateid=$("#pState").val();
   $("#pCity").getServace(jpara);
}

function uiMessage(title,msg,color){
    $.blockUI({
        message: "<h1>"+title+"<h1>"+msg,
        fadeIn: 700,
        fadeOut: 700,
        timeout: 5000,
        showOverlay: false,
        centerY: false,
        css: {
            width: '300px',
            top: '10px',
            left: '10px',
            border: 'none',
            padding: '5px',
            cursor: 'arrow',
            backgroundColor: color,
            '-webkit-border-radius': '10px',
            '-moz-border-radius': '10px',
            opacity: .6,
            color: '#fff'
        }
    });
}



