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
    if (jQuery.trim($('#startdate').val()) == 0) {
        alert("Please Select the Start Date.");
        $('#startdate').focus();
        return false;
    }
    if (jQuery.trim($('#enddate').val()) == 0) {
        alert("Please Select the End Date.");
        $('#enddate').focus();
        return false;
    }
    getValidateDate();
    if (jQuery.trim($('#department').val()) == 0) {
        alert("Please Select the Department.");
        $('#department').focus();
        return false;
    }
    $("#abc").html("("+companyName+")");
    jData = {};
    jData.company = $("#company").val();
    jData.startdate = $("#startdate").val();
    jData.startdate = $("#startdate").val();
    jData.enddate = $("#enddate").val();
    jData.department = $("#department").val();
    jData.service = "PatentTransactionReportServlet";
    jData.handller = "generateReport";
    $(document).getServace(jData);
}

function getValidateDate()
{
    
    
    var startDate = $.datepicker.parseDate('dd-mm-yy', $('#startdate').val());
    var endDate = $.datepicker.parseDate('dd-mm-yy', $('#enddate').val());
    
      if (startDate > endDate) {
            alert('End Date must be greater than Start Date');
             $('#enddate').val("");
            return false;
      }
      
}

function getGridData() {
            var count = 1;
    $('#reportpart').empty();
    $('#reportpart').append("<div style='width: 80%; padding: 10px ;border: .2em solid;margin-left:8%;' id=report></div>");
    $("#report").empty();
    $("#report").append("<table id='reporttable' border='1' style='z-index:5%;font-size: 18px'>");
    $("#reporttable").append("<tr><td align='center' colspan='10'><u style='margin-left:25%'>Institute Academic Quality Assurance Cell</u><u style='margin-left:20%'>QA-AR-Form 4</u><br><u style='margin-left:35%'>Academic ( Research)</u><u style='margin-left:30%'>Frequency-Every Year</u></br><u style='margin-left:20%'>Patent Registered by Faculty / Students ("+companyName+")</u><u style='margin-left:20%'>Date:-"+currDate+"</u></td></tr>");
    $("#reporttable").append("<tr><td style='width: 10%'>S.No</td><td style='width: 15%'>Name of faculty/student<br>(Specify Applicant & co-applicant)</td><td style='width: 15%'>Title of the patent</td><td style='width: 10%'>Patent<br>No.</td><td style='width: 8%'>Country **</td><td style='width: 15%'>Nature of patent application</td><td style='width: 15%'>Date of filing</td><td style='width: 15%'>Status</td><td style='width: 15%'>API Score</td></tr>");
    
    for (var key in gridData) {
        $("#reporttable").append("<tr><td style='width: 10%'>" + count + "</td><td style='width: 15%'>"+gridData[key]["employeeName"]+"</td><td style='width: 15%'>"+gridData[key]["patentTitle"]+"</td><td style='width: 10%'>"+gridData[key]["patentno"]+"</td><td style='width: 8%'>"+gridData[key]["country"]+"</td><td style='width: 15%'>"+getPatentNature(gridData[key]["patentType"])+"</td><td style='width: 15%'>"+gridData[key]["patentFilingDate"]+"</td><td style='width: 15%'>"+getPatentStatus(gridData[key]["patentStatus"])+"</td><td style='width: 15%'>"+gridData[key]["apiScore"]+"</td></tr>");
        count++;
    }
    
    $("#reporttable").append("</table>");
    $("#report").append("<table id='reporttable1' style='z-index:5%;font-size: 18px'>");
    $("#reporttable1").append("<tr><td align='center' colspan='10'>(*) 30 for each granted National Level Patent and 50 for each granted International Level Patent.</td></tr>");
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


function getPatentNature(code)
{
    var tempVal = "";
    if (code == "P")
    {
        tempVal = "Provisional";
    } else if (code == "F")
    {
        tempVal = "Full Length";
    } else if (code == "N")
    {
        tempVal = "National";
    } else
    {
        tempVal = "PCT";
    }
    return tempVal;
}

function getPatentStatus(code)
{
    var tempVal = "";
    if (code == "F")
    {
        tempVal = "Filed";
    } else
    {
        tempVal = "Granted";
    }
    return tempVal;
}