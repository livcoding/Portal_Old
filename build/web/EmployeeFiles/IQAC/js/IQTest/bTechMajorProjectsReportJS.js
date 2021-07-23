/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var currDate="";
 $(document).ready(function() {
                $(".date").datepicker({
                    dateFormat: 'dd-mm-yy',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '-100:+0'
                });
               currDate=currentDate;
            });

var rc = 0;
var gridData = {};
var companyName="";
(function($) {
    $.fn.getServace = function(para)
    {
        // alert(JSON.stringify(para));
        $.ajax({
            type: 'POST',
            timeout: 50000,
            dataType: "json",
            handller: para.handller,
            url: '../../' + para.service,
            data: 'jdata=' + JSON.stringify(para).replace(/&/g, "").replace(/%/g, ""),
            error: function() {
                rc++;
                if (rc != 3) {

                }
                $("errorDiv").html("An Error Occured With Request.....");
            }
        });
        return this;
    };
}(jQuery));

$(document).ajaxComplete(function(event, xhr, settings) {
    switch (settings.handller) {
        case 'generateReport':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            break;
    }
});

function generateReport()
{
    companyName=$("#company").val();
    if (jQuery.trim($('#company').val()) == 0) {
        alert("Please Select the Company.");
        $('#company').focus();
        return false;
    }
    if (jQuery.trim($('#academicYear').val()) == 0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        return false;
    }
    if (jQuery.trim($('#department').val()) == 0) {
        alert("Please Select the Department.");
        $('#department').focus();
        return false;
    }
    
    jData = {};
    jData.company = $("#company").val();
    jData.academicYear = $("#academicYear").val();
    jData.department = $("#department").val();
    jData.service = "BTechMajorProjectsReportServlet";
    jData.handller = "generateReport";
    $(document).getServace(jData);
}



function getGridData() {
            var count = 1;
    $('#reportpart').empty();
    $('#reportpart').append("<div style='width: 80%; padding: 10px ;border: .2em solid;margin-left:8%;' id=report></div>");
    $("#report").empty();
    $("#report").append("<table id='reporttable' border='1' style='z-index:5%;font-size: 18px'>");
    $("#reporttable").append("<tr><td align='center' colspan='10'><u style='margin-left:25%'>Institute Academic Quality Assurance Cell</u><u style='margin-left:20%'>QA-AR-Form 6</u><br><u style='margin-left:35%'>Academic ( Research)</u><u style='margin-left:25%'>Frequency-Every Year</u></br><u style='margin-left:30%'>B.Tech. Major Projects</u><u style='margin-left:25%'>Date:-"+currDate+"</u></td></tr>");
    $("#reporttable").append("<tr><td style='width: 8%'>S.No</td><td style='width: 8%'>ProjectID</td><td style='width: 23%'>Title</td><td style='width: 23%'>Student Name<br>Enroll.No.</td><td style='width: 23%'>Name(s) of faculty involved</td><td style='width: 23%'>Academic year</td><td style='width: 23%'>Publications</td></tr>");
    
    for (var key in gridData) {
        $("#reporttable").append("<tr><td style='width: 8%'>" + count + "</td><td style='width: 23%'>"+gridData[key]["projectid"]+"</td><td style='width: 23%'>"+gridData[key]["projectTitle"]+"</td><td style='width: 23%'>"+gridData[key]["studentname"]+ "</td><td style='width: 23%'>"+gridData[key]["employeeName"]+"</td><td style='width: 23%'>"+gridData[key]["academicYear"]+"</td><td style='width: 23%'>"+gridData[key]["publicationType"]+"</td></tr>");
        count++;
    }
    
    $("#reporttable").append("</table>");
    $("#report").append("<table id='reporttable1' style='z-index:5%;font-size: 18px'>");
    $("#reporttable1").append("<BR>");
    $("#reporttable1").append("<BR>");
    $("#reporttable1").append("<tr><td align='left' colspan='10'>(Name and Signature)</td></tr>");
    $("#reporttable1").append("</table>");
    $('#reportpart').append("<center><button id='Print' onclick='return printDiv();' >Print</button></center>");
}

function printDiv()
{

  var divToPrint=document.getElementById('report');

  var newWin=window.open('','Print-Window','width=800,height=800');

  newWin.document.open();

  newWin.document.write('<html><head></head><body onload="window.print()">'+divToPrint.innerHTML+'</body></html>');

  newWin.document.close();

  setTimeout(function(){newWin.close();},10);

}




