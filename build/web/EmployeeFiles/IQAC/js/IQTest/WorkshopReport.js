/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */




/*Getting department on page load*/
$(document).ready(function(){
 $("#department").change(function(){
//   alert("Gyan");
   $("#startdate").val("");
   $("#enddate").val("");
 });
 
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






/* Getting Program title click on page title (Start)*/
$(document).ready(function(){
$("#enddate").change(function()
{//alert("Gyan");
$.ajax({

        url: "/rest/WorkshopReport/programtitle?department="+$("#department").val()+"&startdate="+$("#startdate").val()+"&enddate="+$("#enddate").val(),
        type: "get",
        contentType: "application/json",
        
       success:function(e){
            $("#programtitle").empty();
            $("#programtitle").append("<option>Select A Program Title</option>");
           
           for (var key in e){
                $("#programtitle").append("<option value='"+key+"'>"+ e[key]+"</option>");
            }
            },
        error : function (e){
              alert("Please fill correct combination department and Dates for getting Title Of Program");
            }
    });
});

});
/*Getting Program title click on page title (End)*/

/* Generate report  (Start)*/
$(document).ready(function() {
$("#submitbutton").click(function()
{//alert("Gyan");
$.ajax({
        url: "/rest/WorkshopReport/report?department="+$("#department").val()+"&startdate="+$("#startdate").val()+"&enddate="+$("#enddate").val()+"&programtitle="+$("#programtitle").val(),
        type: "get",
        contentType: "application/json",
beforesuccess:function(){
    $('body').append("<div style='width: 90%; padding: 10px ;margin-left:4%;' id='wait'><font size=2 color='blue'>Please wait report is loading.....</div>");
},

success:function(e){
            $("#wait").empty();
            $('#reportpart').empty();
            $('#reportpart').append("<div style='width: 55%; padding: 10px ;border: .2em solid;margin-left:22%;' id=report></div>");
            $("#report").empty();
            $("#report").append("<table id='reporttable' style='z-index:5%'>");
            $("#reporttable").append("<tr><td style='text-align:right;width:100%;height:20%;' align='center' ><font size='2' >Form:QA-PSA-2A<br>Frequency-Every Semester Jan/July<br>Date:"+e.sysdate+"</font></td></tr>");
            //$("#reporttable").append("<tr><td style='text-align:left;width:100%;height:20%;' align='center' ><font size='3' ><u>Professional and Social Activities Committee</u></font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:ceneter;width:100%;height:20%;' align='center' ><font size='3' colspan='2' ><u>Institute Academic Quality Assurance Cell<br>Professional and Social Activities Committee<br>Performa for approval of VC for Conducting Workshops/Courses/Guest Lectures/FDP</u><br><br></font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Department : "+e.department+"</font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Name of Program(Workshops/Special Course/Guest Lecture/Faculty Development Program)</font><font size='2' nowrap> : "+e.programtype+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Title of Program</font><font size='2' nowrap> : "+e.programtitle+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Duration and Date of Program</font><font size='2' nowrap> :  "+e.duerations+" days -("+e.startdate+" To "+e.enddate+")</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:20%;' valign='bottom' colspan='2' nowrap><font size='2' ><br><u>Name Of Resource Person With Designation and Affilation</u></font></td></tr>");
        $.ajax({
        url: "/rest/WorkshopReport/griddata?transactionid="+e.transid,
        type: "get",
        contentType: "application/json",
      
    success:function(ee){
            $("#reporttable").append("<tr><td align='center' colspan='2'><table style='margin-left:10%' id='griddata' rules='all' border='2' width='80%' border-color='black'>");
            $("#griddata").append("<tr><td><font size='2' >Sl No.</td><td><font size='2' >Name</td><td><font size='2' >Affilation</td><td><font size='2' >Designation</td><td><font size='2' >Expertise</td></tr>");
            for(var k=0; k<ee.length;k++)
            {
            $("#griddata").append("<tr><td><font size='2' >"+(k+1)+"</td><td><font size='2' >"+ee[k].employeename+"</td><td><font size='2' >"+ee[k].affilation+"</td><td><font size='2' >"+ee[k].DESIGNATION+"</td><td><font size='2' >"+ee[k].Expertise+"</td></tr>");
            }
            $("#griddata").append("</table></td></tr><tr></tr>");

            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' ><br><br>Objective Of Program</font><font size='2' nowrap> : "+e.objective+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' >Target Audience</font><font size='2' nowrap> : "+e.audience+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' >Tentative Budget</font><font size='2' nowrap> : Rs."+e.budget+"/=</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;' valign='bottom' ><font size='1' >(Attach seprate sheet to give breakup of tentative budget)</font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;' valign='bottom' ><font size='2' ><br><br><br>Signature of the Applicant with Date:</font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;' valign='bottom' ><font size='2' ><br><br><br>Recommendation of the HOD:</font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;' valign='bottom' ><font size='2' ><br><br><br><br>Approval of Vice Chancellor:</font></td></tr>");
            $("#reporttable").append("</table>");
            $('#reportpart').append("<center><button id='Print' onclick='return printDiv();' >Print</button></center>");

           // $("#report").append("<div style='width: 60%; padding: 10px ;;margin-left:20%;' id=aftergrid></div>");

}
});
           
           },
       
       error : function (){
              alert("Please Choose Correct Parameteres For Generating The Report.");
            }
    });
});

});

/* Generate report  (End)*/

$(document).ready(function() {
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


function printDiv()
{

  var divToPrint=document.getElementById('report');

  var newWin=window.open('','Print-Window','width=80,height=80');

  newWin.document.open();

  newWin.document.write('<html><head></head><body onload="window.print()">'+divToPrint.innerHTML+'</body></html>');

  newWin.document.close();

  setTimeout(function(){newWin.close();},10);

}










//$(document).ajaxComplete(function(event, xhr, settings) {
//
// var SelectData = {};
//            SelectData = jQuery.parseJSON(xhr.responseText);
//       for (var key in SelectData){
//           $("#department").append("<option value='"+key+"'>"+ SelectData[key]+"</option>");
//       }
//
//});