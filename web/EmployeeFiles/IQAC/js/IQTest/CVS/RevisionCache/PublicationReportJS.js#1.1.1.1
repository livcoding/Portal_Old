var IqacReport_uri="";
var IqacReport = function() {
  this.url1 = "/rest/PublicationReportServices";
  this.typ="get";
  this.contType="application/json";
};

function printDiv()
{

  var divToPrint=document.getElementById('report');

  var newWin=window.open('','Print-Window','width=80,height=80');

  newWin.document.open();

  newWin.document.write('<html><head></head><body onload="window.print()" >'+divToPrint.innerHTML+'</body></html>');

  newWin.document.close();

 }



$(document).ready(function(){
  $("#fac").hide();
$("#Public").hide();
$("#institute").click(function(){
     if($("#company").val()=='')
    {alert("Please choose company first ");return false;}
});


$("#publicationyear").click(function(){
    if($("#institute").val()=='')
    {alert("Please choose institute first ");return false;}
});
$("#Department").click(function(){
    if($("#publicationyear").val()=='')
    {alert("Please choose publication year first ");return false;}
});
$("#wise1").click(function(){
    if($("#Department").val()=='')
    {
        alert("Please choose department first ");return false;}
});

$("#Publication").click(function(){
    if($("#Department").val()=='')
    {
        alert("Please choose department first ");return false;}
});
////$("#departmentcode").click(function(){
//    if($("#academicyear").val()=='')
//    {alert("Please choose academic year first ");return false;}
//});



$("#company").change(function(){
IqacReport_uri='/institute?company='+$("#company").val()+'';
ReqResforCombobox(IqacReport_uri,"institute");
});

/*$("#institute").change(function(){
IqacReport_uri='/acdemicyear?institute='+$("#institute").val()+'';
ReqResforCombobox(IqacReport_uri,"academicyear");
});*/

$("#institute").change(function(){
   // alert("Gyam");

IqacReport_uri='/publicyear?company='+$("#company").val()+'';
ReqResforCombobox(IqacReport_uri,"publicationyear");
});

$("#publicationyear").change(function(){
   // alert("Gyam");
IqacReport_uri='/department?company='+$("#company").val()+'&publicyear='+$("#publicationyear").val()+'';
ReqResforCombobox(IqacReport_uri,"Department");
});

$("#Department").change(function(){
   // 
  if ($('input[id=wise1]:checked').val()) {//alert("Gyam");
IqacReport_uri='/publicationid?company='+$("#company").val()+'&publicyear='+$("#publicationyear").val()+'&department='+$("#Department").val()+'';
ReqResforCombobox(IqacReport_uri,"Publication");
  }  });

$("#wise1").click(function(){
   //
  if ($('input[id=wise1]:checked').val()) {//alert("Gyam");
IqacReport_uri='/publicationid?company='+$("#company").val()+'&publicyear='+$("#publicationyear").val()+'&department='+$("#Department").val()+'';
ReqResforCombobox(IqacReport_uri,"Publication");
  }  });
$("#wise2").click(function(){
   //
  if ($('input[id=wise2]:checked').val()) {
IqacReport_uri='/faculty?company='+$("#company").val()+'&department='+$("#Department").val()+'';
ReqResforCombobox(IqacReport_uri,"Faculty");
  }  });

$("#Department").change(function(){
   //
  if ($('input[id=wise2]:checked').val()) {
IqacReport_uri='/faculty?company='+$("#company").val()+'&department='+$("#Department").val()+'';
ReqResforCombobox(IqacReport_uri,"Faculty");
  }  });
/*$("#submitbutton").click(function(){
    IqacReport_uri='/publicationreport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&academicyear='+$("#academicyear").val()+'';
    ReqResforReport(IqacReport_uri,"reportpart");
});*/
/*if ($('input[name=wise]:checked').val()) {
    alert($('input[name=wise]:checked').val());
}*/

$("#wise1").click(function(){
  if($("#Department").val()!='')
{if ($('input[id=wise1]:checked').val()) {


$("#fac").hide();
$("#Public").show();
}else
{
$("#fac").show();
$("#Public").hide();
}}
});
$("#wise2").click(function(){
  if($("#Department").val()!='')
{if ($('input[id=wise2]:checked').val()) {
$("#Public").hide();
$("#fac").show();
}else
{
$("#fac").hide();
$("#Public").show();
}}
});



$("#Publication").change(function(){
IqacReport_uri='/publicationreport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&publicyear='+$("#publicationyear").val()+'&publication='+$("#Publication").val()+'&department='+$("#Department").val()+'';
ReqResforReport(IqacReport_uri,"reportpart");
});


$("#Faculty").change(function(){
IqacReport_uri='/facultyreport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&publicyear='+$("#publicationyear").val()+'&faculty='+$("#Faculty").val()+'&department='+$("#Department").val()+'';
ReqResforReport(IqacReport_uri,"reportpart");
});

/*if($("#wise1").check())
{
 $("#Publication").show();
}else
{
$("#Publication").hide();
}

});*/



function ReqResforReport(IqacReport_uri,element)
{
    try{
        var R1 = new IqacReport();

   //alert(R1.url1+IqacReport_uri+"$$$$$"+R1.typ+"^^^^^"+R1.contType);
 $.ajax({
         url:R1.url1+IqacReport_uri,
         type:R1.typ,
        beforeSend:function()
        {
           // alert(element);
            $("#"+element).html("<center><font color='green' size='2'>Please Wait.....</font></center>");
        },
 success:function(e){
             $("#"+element).empty();
           //   alert(e);
           $("#"+element).html(e);
},
error : function (e){
       // alert(e);
    // alert("Error in geting Program...");
            }
 });
}catch(e)
{
  alert(e);
}
}




function ReqResforCombobox(IqacReport_uri,element)
{ try{var R1 = new IqacReport();

    //    alert(R1.url1+IqacReport_uri+"$$$$$"+R1.typ+"^^^^^"+R1.contType);
 $.ajax({
         url:R1.url1+IqacReport_uri,
         type:R1.typ,
         contentType:R1.contType,
         success:function(e){
       
                 $("#"+element).empty();
        $("#"+element).append("<option value=''>Select</option>");
for (var key in e)
            {
            $("#"+element).append("<option value='"+key+"'>"+ e[key]+"</option>");
            }},

        error : function (){

    // alert("Error in geting Program...");
            }
    });
}catch(e)
{
    alert(e);
}
}

});