/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */




/*Getting department on page load*/
$(document).ready(function(){
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
 $("#department").change(function(){
//   alert("Gyan");
   $("#startdate").val("");
   $("#enddate").val("");
 });


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
   // alert(e.msg);
    if(e.msg!='Y'){
            $("#wait").empty();
            $('#reportpart').empty();
            $('#reportpart').append("<div style='width: 50%; padding: 10px ;border: .2em solid;margin-left:24%;' id=report></div>");
            $("#report").empty();
            $("#report").append("<table id='reporttable' style='z-index:5%'>");
            $("#reporttable").append("<tr><td style='text-align:right;width:100%;height:20%;' align='center' ><font size='2' >Form:QA-PSA-2B<br>Frequency-Every Semester Jan/July<br>Date:"+e.sysdate+"</font></td></tr>");
            //$("#reporttable").append("<tr><td style='text-align:left;width:100%;height:20%;' align='center' ><font size='3' ><u>Professional and Social Activities Committee</u></font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:ceneter;width:100%;height:20%;' align='center' ><font size='3' colspan='2' ><u>Institute Academic Quality Assurance Cell<br>Professional and Social Activities Committee<br>Workshops,Special Courses,Guest Lecturees,Faculty Development Program Feedback</u><br><br></font></td></tr>");
                        $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;'><font size='2' >Department</font><font size='2' > : "+e.department+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;'  ><font size='2' >Name Of Program (Workshops/Special Course/Guest Lecture/Faculty Development Program)</font><font size='2' > : "+e.programtype+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;'  ><font size='2' >Title Of Program</font><font size='2' > : "+e.programtitle+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' >Duration and date Of Program</font><font size='2' nowrap> :  "+e.duerations+" days -("+e.startdate+" To "+e.enddate+")</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' >Participant's feedback(Overall) Enclose Summary Sheet</font><font size='2' nowrap> : "+e.participantfeedback+" [5(Highest) ..... 1(Least)]</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' >Any Specific Comment</font><font size='2' nowrap> : "+e.participantcomment+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;'  ><font size='2' >Feedback Of Resource Persons</font><font size='2' nowrap> : "+e.personfeedback+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' >Any Specific Comment</font><font size='2' nowrap> : "+e.personcomment+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;'  nowrap><font size='2' ><u>Funding Details </u>:</font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' nowrap>Funds Raised For Program</font><font size='2' nowrap> : "+e.raisedfund+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' nowrap>Actual Funds Spent</font><font size='2' nowrap> : "+e.spendfund+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;' valign='bottom' colspan='2' nowrap><font size='1' >(Attach seprate sheet to give breakup of tentative budget)</font></td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' nowrap>Whether the program write-up has been sent for updating on website?</font><font size='2' nowrap> : "+e.websiteupdate+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' nowrap>Whether the program write-up has been sent to departmental represntative for adding to database of department?</font><font size='2' nowrap> : "+e.databaseupdate+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:25%;height:10%;' ><font size='2' nowrap>Feedback of faculty organizers regarding administrative support for program:<br>Any Specific comment</font><font size='2' nowrap> : "+e.facultycomment+"</td></tr>");
            $("#reporttable").append("<tr><td style='text-align:left;width:100%;height:10%;' valign='bottom' colspan='2' nowrap><font size='2' ><br><br><br><br>(Name and Signature of Organizer)</font></td></tr>");
            $('#reportpart').append("<center><button id='Print' onclick='return printDiv();' >Print</button></center>");
    }else
    {
    alert("Please choose another criteria");
return false;
}
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