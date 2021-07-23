/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



var IndusInterReport = function() {
  this.url1 = "/rest/IndusInterReport";
  this.typ="get";
  this.contType="application/json";
};

function printDiv()
{

  var divToPrint=document.getElementById('report');

  var newWin=window.open('','Print-Window','width=80,height=80');

  newWin.document.open();

  newWin.document.write('<html><head></head><body onload="window.print()">'+divToPrint.innerHTML+'</body></html>');

  newWin.document.close();

  setTimeout(function(){newWin.close();},10);

}






function ReqResforCombo(uri,element)
{ try{var R = new IndusInterReport();
      //  alert(R.url1+uri+"$$$$$"+R.typ+"^^^^^"+R.contType);
   $.ajax({
         url:R.url1+uri,
        type:R.typ,
        contentType:R.contType,
         success:function(e){
        $("#"+element).empty();
        $("#"+element).append("<option value=''>Select</option>");
for (var key in e)
            {
            $("#"+element).append("<option value='"+key+"'>"+ e[key]+"</option>");
            }},

        error : function (){
               
               alert("Error in geting company...");
            }
       
    });}catch(e)
{
    alert(e);
}
}


function rndlabText(uri,element)
{ 
    try{
        var R = new IndusInterReport();
        $.ajax({
            url:R.url1+uri,
            type:"GET",
        //    contentType:"text/HTML",
        //    timeout:8000,
            success:function(e){
             var rndlab=e.split("@");
               $("#rndLab").empty();
                $("#scholar").empty();
                $("#rndLab").val(rndlab[0]);
                $("#scholar").val(rndlab[1]);
            },
            error : function (){
                alert("Error in geting rndlab...");
            }
        });
    }catch(e)

    {
        alert(e);
    }
}


function reportText(uri,element)
{
    try{
        var R = new IndusInterReport();
        $.ajax({
            url:R.url1+uri,
            type:"GET",
        //    contentType:"text/HTML",
        //    timeout:8000,
            success:function(e){
              //  alert(e);
               $("#reportpart").empty();
               $("#reportpart").append(e);
              
            },
            error : function (){
                alert("Error in geting reportpart...");
            }
        });
    }catch(e)

    {
        alert(e);
    }
}

$(document).ready(function(){
   var uri='/company';
   ReqResforCombo(uri,"company");
$("#company").change(function(){
    uri='/'+$("#company").val();
  ReqResforCombo(uri,"institute");
});

$("#institute").click(function(){
    if($("#company").val()=='')
    {
        alert("Please choose company first...");
        return false;
    }
});

$("#transactiondate").click(function(){
    if($("#institute").val()=='')
    {
        alert("Please choose institute first...");
        return false;
    }
});

$("#department").click(function(){
    if($("#transactiondate").val()=='')
    {
        alert("Please choose transaction date first...");
        return false;
    }
});



$("#institute").change(function(){
    
 uri='/'+$("#company").val()+'/'+$("#institute").val();
  ReqResforCombo(uri,"transactiondate");
});
$("#transactiondate").change(function(){
 uri='/Department?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val();
  ReqResforCombo(uri,"department");
});
$("#department").change(function(){
 uri='/rnd?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val()+'&dept='+$("#department").val();
  rndlabText(uri,"rndLab");

});
$("#department").change(function(){
   // alert($("#department").val());
 uri='/rnd?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val()+'&dept='+$("#department").val();
  rndlabText(uri,"rndLab");});
    $("#submitbutton").click(function(){
    if($("#company").val()=='')
    {
        alert("Please choose a company");
        return false;
    }

 if($("#company").val()=='')
    {
        alert("Please choose a company");
        return false;
    }
     if($("#institute").val()=='')
    {
        alert("Please choose a institute");
        return false;
    }
     if($("#transactiondate").val()=='')
    {
        alert("Please choose a transaction date");
        return false;
    }
    if($("#department").val()=='')
        {
        alert("Please choose a department");
        return false;
    }




 uri='/IndusReport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val()+'&dept='+$("#department").val();
  reportText(uri,"reportpart");

 });


$("#getIndusFeedback_submit").click(function(){
 if($("#company").val()=='')
    {
        alert("Please choose a company");
        return false;
    }
     if($("#institute").val()=='')
    {
        alert("Please choose a institute");
        return false;
    }
     if($("#transactiondate").val()=='')
    {
        alert("Please choose a transaction date");
        return false;
    }
    if($("#department").val()=='')
        {
        alert("Please choose a department");
        return false;
    }




 uri='/IndusInterFeedbackReport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val()+'&dept='+$("#department").val();
  reportText(uri,"reportpart");

 });







/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*$(document).ready(function() {
             $(".date").datepicker({
                dateFormat: 'dd-mm-yy',
                changeMonth: true,
                changeYear: true,
                yearRange: '-100:+0'
            });
            $("#startdate").datepicker({
                     dateFormat: 'dd-mm-yy',
        //numberOfMonths: 2,
     //     minDate: 0,

        onSelect: function(selected) {

          $("#enddate").datepicker("option","minDate", selected)
        }
    });

    $("#enddate").datepicker({
       // numberOfMonths: 2,
       dateFormat: 'dd-mm-yy',
        onSelect: function(selected) {
           $("#startdate").datepicker("option","maxDate", selected)
        }
    });
});


/*Getting department on page load*/
/*$(document).ready(function(){
    $.ajax({
        url: "/rest/WorkshopReport/department",
        type: "post",
        contentType: "application/json",

       success:function(e){
            for (var key in e){
                $("#department").append("<option value='"+key+"'>"+ e[key]+"</option>");
            }
        }
    });

});
/*Start ajax for getting company*/
/*$(document).ready(function(){
    $.ajax({
        url: "/rest/WorkshopReport/company",
        type: "get",
        contentType: "application/json",
    success:function(e){
         for (var key in e){
                $("#company").append("<option value='"+key+"'>"+ e[key]+"</option>");
            }
        }
    });
});
/*End ajax for getting company*/
/*Start ajax for getting Institute*/
/*$(document).ready(function(){
  $("#company").change(function(){
       $.ajax({
        url: "/rest/WorkshopReport/"+$("#company").val()+"",
        type: "get",
        contentType: "application/json",
    success:function(e){
         $("#institute").empty();
           $("#institute").append(" <option>Select Institute</option>");
         for (var key in e){
                $("#institute").append("<option value='"+key+"'>"+ e[key]+"</option>");
            }
        }
    });
    });
});
/*End ajax for getting Institute*/

/*Start ajax for getting Institute*/
/*$(document).ready(function(){
  $("#institute").change(function(){
       $.ajax({
        url: "/rest/WorkshopReport/"+$("#company").val()+"/"+$("#institute").val()+"",
        type: "get",
        contentType: "application/json",
    success:function(e){
         $("#transactiondetail").empty();
           $("#transactiondetail").append(" <option>Select Transaction Detail</option>");
         for (var key in e){
                $("#transactiondetail").append("<option value='"+key+"'>"+ e[key]+"</option>");
                 }
        }
    });
    });
});
/*End ajax for getting Institute*/
///*Start ajax for getting transaction date*/
//$(document).ready(function(){
//$("#transactiondate").val("");
//  $("#transactiondetail").change(function(){
//       $.ajax({
//        url: "/rest/WorkshopReport/"+$("#company").val()+"/"+$("#institute").val()+"/"+$("#transactiondetail").val()+"",
//        type: "get",
//        contentType: "application/json",
//    success:function(e){
//         $("#transactiondate").val();
//         $("#transactiondate").val(e.transdate);
//
//        }
//    });
//    });
//});
/*End ajax for getting transaction date*/

/*Start ajax for getting Industrail Interactions Details Report*/
/*$(document).ready(function(){
 $("#submitbutton").click(function(){
      //alert("Gyan");
       $.ajax({
        url: "/rest/WorkshopReport/IndusReport?company="+$("#company").val()+"&institute="+$("#institute").val()+"&transid="+$("#transactiondetail").val()+"&transdate="+$("#transactiondate").val()+"",
        type: "get",
        contentType: "application/json",
    success:function(e){
            $('#reportpart').append("<div style='width: 55%; padding: 10px ;border: .2em solid;margin-left:22%;' id=report></div>");
            $("#report").empty();
            $("#report").append("<table id='reporttable' style='z-index:5%'>");
            $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:20%;' align='center' colspan='2'><font size='3' ><br><u>Industrial Interactions</u><br><br></font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' >Department</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> : "+e.department+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;' colspan='2' ><font size='2' ><u>Details Of Guest Lectures by Industrial experts</u></font></tr>");

      $.ajax({
        url: "/rest/WorkshopReport/GuestLect?company="+$("#company").val()+"&institute="+$("#institute").val()+"&transid="+$("#transactiondetail").val()+"&transdate="+$("#transactiondate").val()+"",
        type: "get",
        contentType: "application/json",
    success:function(ee){
            $("#reporttable").append("<tr><td align='center' colspan='2'><table style='margin-left:10%' id='GuestLectData' rules='all' border='2' width='80%' border-color='black'>");

            $("#GuestLectData").append("<tr><td nowrap><font size='2' >Sl No.</td><td nowrap><font size='2' >Name</td><td nowrap><font size='2'>Topic</td><td nowrap><font size='2' >Duration including dates</td><td nowrap><font size='2'>Number Of Participants</td></tr>");

            for(var k=0; k<ee.length;k++)
            {
            $("#GuestLectData").append("<tr><td nowrap><font size='2' >"+k+1+"</td><td nowrap><font size='2' >"+ee[k].guestname+"</td><td><font size='2' >"+ee[k].Topic+"</td><td nowrap><font size='2' >"+ee[k].durationdates+"</td><td nowrap><font size='2' >"+ee[k].participant+"</td></tr>");
           }
           $("#GuestLectData").append("</table></td></tr>");
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;' colspan='2' ><font size='2' ><u>Industrial visits nad tours</u></font></tr>");
           $.ajax({
        url: "/rest/WorkshopReport/IndusVisits?company="+$("#company").val()+"&institute="+$("#institute").val()+"&transid="+$("#transactiondetail").val()+"&transdate="+$("#transactiondate").val()+"",
        type: "get",
        contentType: "application/json",
    success:function(eee){
           $("#reporttable").append("<tr><td align='center' colspan='2'><table style='margin-left:10%' id='IndusVisitData' rules='all' border='2' width='80%' border-color='black'>");
           $("#IndusVisitData").append("<tr><td nowrap><font size='2'>Sl No.</td><td nowrap><font size='2' >Name of Industry visited</td><td nowrap><font size='2'>Tour Details</td><td nowrap><font size='2' >Duration including dates</td><td nowrap><font size='2'>Number Of Participants</td></tr>");
           for(var k=0; k<eee.length;k++)
            {
           $("#IndusVisitData").append("<tr><td nowrap><font size='2' >"+k+1+"</td><td nowrap><font size='2' >"+eee[k].indusname+"</td><td><font size='2' >"+eee[k].tourdetails+"</td><td nowrap><font size='2' >"+eee[k].durationdates+"</td><td nowrap><font size='2' >"+eee[k].participant+"</td></tr>");
            }
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;'  nowrap colspan='2'><font size='2' >Details of Industry sponsored R & D Laboratories at the Institute</font></td></tr>")
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;' colspan='2' ><font size='2' > : "+e.rnd+"</td></tr>");
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;'  nowrap colspan='2'><font size='2' >Details of Industry sponsored Scholarships/fellowships for students</font></td></tr>")
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;' colspan='2' ><font size='2' > : "+e.fellowdeatails+"</td></tr>");
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;'  nowrap colspan='2'><font size='2' >Details of Collaborative degree programs in hte department,If any</font></td></tr>")
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;' colspan='2' ><font size='2' > : "+e.collaborative+"</td></tr>");
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;'  nowrap colspan='2'><font size='2' >Details of Authorship and Attribution of Joint Articles,Publications,and Presentations</font></td></tr>")
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;' colspan='2' ><font size='2' > : "+e.authar+"</td></tr>");
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;'  nowrap colspan='2'><font size='2' >Details of Industry Support for Education Conferences and Meetings/Social Events</font></td></tr>")
           $("#reporttable").append("<tr><td style='text-align:left;width:100%;' colspan='2' ><font size='2' > : "+e.indusdetails+"</td></tr>");

            $("#reporttable").append("</table>");
           $('#reportpart').append("<center><button id='Print' onclick='return printDiv();' >Print</button></center>");

 }
    });

 }


});}*/
/*End ajax for getting Industrail Interactions Details Report*/
      /* });
       
       });*/

       });