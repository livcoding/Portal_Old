/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var rc = 0;
var gridData = {};
var cupage = {};
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
            data:'jdata='+JSON.stringify(para).replace(/&/g,"@@@").replace(/%/g,""),
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
        case 'SelectforUpdate':
            var SelectData = {};
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#transactionID").val(SelectData["transactionID"]);
            $("#transactionDate").val(SelectData["transactionDate"]);
            $("#departmentName").val(SelectData["department"]);
            $("#titleOfTheProgram").val(SelectData["programTitle"]);
            $("#programType").val(SelectData["programType"]);
            $("#startDate").val(SelectData["startDate"]);
            $("#endDate").val(SelectData["endDate"]);
            $("#speakerFeedback").val(SelectData["speakerFeedback"]);
            $("#guestParticipantsFeedback").val(SelectData["guestParticipantsFeedback"]);
            $("#industrialVisitFeedback").val(SelectData["industrialVisitFeedback"]);
            $("#feedbackOfParticipants").val(SelectData["feedbackOfParticipants"]);
            $("#feedbackOfIndustry").val(SelectData["feedbackOfIndustry"]);
            $("#industrialSuggestions").val(SelectData["industrialSuggestions"]);
            $("#overallProjectFeedback").val(SelectData["overallProjectFeedback"]);
            $("#feedbackOfPICOPI").val(SelectData["feedbackOfPICOPI"]);
            $("#projectSuggestions").val(SelectData["projectSuggestions"]);
            $("#instructorFeedback").val(SelectData["instructorFeedback"]);
            $("#industryLedParticipantsFeedback").val(SelectData["industryLedParticipantsFeedback"]);
            $("#resourcePersonFeedback").val(SelectData["resourcePersonFeedback"]);
            $("#industryLedSuggestions").val(SelectData["industryLedSuggestions"]);
            $("#remarks").val(SelectData["remarks"]);    
            break;
        case 'saveupdate':
            resetValues();
            getSelectGridData("0");
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            if (gridData["0"] != 0) {
                getGridData(gridData);
                $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            }
            break;
        case 'selectHeadingInfo':
            var SelectData = {};
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#transactionID").val(SelectData["transactionID"]);
            $("#transactionDate").val(SelectData["transactionDate"]);
            $("#departmentName").val(SelectData["department"]);
            $("#titleOfTheProgram").val(SelectData["programTitle"]);
            $("#programType").val(SelectData["programType"]);
            $("#startDate").val(SelectData["startDate"]);
            $("#endDate").val(SelectData["endDate"]);
            $("#speakerFeedback").val(SelectData["speakerFeedback"]);
            $("#guestParticipantsFeedback").val(SelectData["guestParticipantsFeedback"]);
            $("#industrialVisitFeedback").val(SelectData["industrialVisitFeedback"]);
            $("#feedbackOfParticipants").val(SelectData["feedbackOfParticipants"]);
            $("#feedbackOfIndustry").val(SelectData["feedbackOfIndustry"]);
            $("#industrialSuggestions").val(SelectData["industrialSuggestions"]);
            $("#overallProjectFeedback").val(SelectData["overallProjectFeedback"]);
            $("#feedbackOfPICOPI").val(SelectData["feedbackOfPICOPI"]);
            $("#projectSuggestions").val(SelectData["projectSuggestions"]);
            $("#instructorFeedback").val(SelectData["instructorFeedback"]);
            $("#industryLedParticipantsFeedback").val(SelectData["industryLedParticipantsFeedback"]);
            $("#resourcePersonFeedback").val(SelectData["resourcePersonFeedback"]);
            $("#industryLedSuggestions").val(SelectData["industryLedSuggestions"]);
            $("#remarks").val(SelectData["remarks"]);
            break;
        case 'Delete':
            $("#gridhead").html("");
            $("#gridbody").html("");
            getSelectGridData(cupage.pr);
            break;
        
    }
});


function getCommonMasterTable()
{
    $("#pagging").getPagging();
    getSelectGridData("0");
    ///////////////////////////////////// 
    cupage.pr = 0;
    $("#previous").hide();
    $("#first").hide();
    
//    $("#pagging").click(function() {
//        cupage.pr = eval($("#pagging").val());
//    });
    $("#first").click(function() {
        getSelectGridData("0");
        cupage.pr = 0;
        if (cupage.pr == "0") {
            $("#previous").hide();
            $("#first").hide();
        }
        $("#next").show();
        $("#last").show();
    });
    $("#previous").click(function() {
        getSelectGridData((eval(cupage.pr) - eval($("#pagging").val())));
        cupage.pr = (eval(cupage.pr) - eval($("#pagging").val()));
        if (cupage.pr == "0") {
            $("#previous").hide();
            $("#first").hide();
        }
        $("#next").show();
        $("#last").show();
    });
    $("#next").click(function() {
        getSelectGridData((eval(cupage.pr) + eval($("#pagging").val())));
        cupage.pr = (eval(cupage.pr) + eval($("#pagging").val()));
        if (cupage.pr > (eval(gridData[1].totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val())))
        {
            $("#next").hide();
            $("#last").hide();
        }
        $("#previous").show();
        $("#first").show();
    });
    $("#last").click(function() {
    
        getSelectGridData((eval(gridData[1].totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val())));
        cupage.pr = (eval(gridData[1].totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val()));
        $("#next").hide();
        $("#last").hide();
        $("#previous").show();
        $("#first").show();
    });
}

function formsubmit()
{
    if (jQuery.trim($('#transactionID').val()) == 0) {
        alert("Please Select the Interactions Details.");
        $('#transactionID').focus();
        return false;
    }
    if (jQuery.trim($('#transactionDate').val()) == "") {
        alert("Please Enter the Transaction Date.");
        $('#transactionDate').focus();
        return false;
    }
    if (jQuery.trim($('#departmentName').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentName').focus();
        return false;
    }
    if (jQuery.trim($('#programType').val()) == 0) {
        alert("Please Select the Program Type.");
        $('#programType').focus();
        return false;
    }
    if (jQuery.trim($('#titleOfTheProgram').val()) == "") {
        alert("Please Enter the Title of the Program.");
        $('#titleOfTheProgram').focus();
        return false;
    }
    if (jQuery.trim($('#startDate').val()) == "") {
        alert("Please Enter the Start Date.");
        $('#startDate').focus();
        return false;
    }
    if (jQuery.trim($('#endDate').val()) == "") {
        alert("Please Enter the End Date.");
        $('#endDate').focus();
        return false;
    }
    if (jQuery.trim($('#speakerFeedback').val()) == 0) {
        alert("Please Select the Feedback Of Speaker.");
        $('#speakerFeedback').focus();
        return false;
    }
    if (jQuery.trim($('#guestParticipantsFeedback').val()) == 0) {
        alert("Please Select the Guest Participants Feedback.");
        $('#guestParticipantsFeedback').focus();
        return false;
    }
    if (jQuery.trim($('#industrialVisitFeedback').val()) == "") {
        alert("Please Enter the Industrial Visit Feedback.");
        $('#industrialVisitFeedback').focus();
        return false;
    }
    if (jQuery.trim($('#feedbackOfParticipants').val()) == 0) {
        alert("Please Select the Feedback Of Participants.");
        $('#feedbackOfParticipants').focus();
        return false;
    }
    if (jQuery.trim($('#feedbackOfIndustry').val()) == 0) {
        alert("Please Select the Feedback Of Industry.");
        $('#feedbackOfIndustry').focus();
        return false;
    }
    if (jQuery.trim($('#industrialSuggestions').val()) == "") {
        alert("Please Enter the Industrial Suggestions.");
        $('#industrialSuggestions').focus();
        return false;
    }
    if (jQuery.trim($('#overallProjectFeedback').val()) == 0) {
        alert("Please Select the Overall Project Feedback.");
        $('#overallProjectFeedback').focus();
        return false;
    }
    if (jQuery.trim($('#feedbackOfPICOPI').val()) == 0) {
        alert("Please Select the Feedback Of PI/CO-PI.");
        $('#feedbackOfPICOPI').focus();
        return false;
    }
    if (jQuery.trim($('#projectSuggestions').val()) == "") {
        alert("Please Enter the Project Suggestions.");
        $('#projectSuggestions').focus();
        return false;
    }
    if (jQuery.trim($('#instructorFeedback').val()) == 0) {
        alert("Please Select the Instructor Feedback.");
        $('#instructorFeedback').focus();
        return false;
    }
     if (jQuery.trim($('#industryLedParticipantsFeedback').val()) == 0) {
        alert("Please Select the Participants Feedback.");
        $('#industryLedParticipantsFeedback').focus();
        return false;
    }
    if (jQuery.trim($('#resourcePersonFeedback').val()) == "") {
        alert("Please Enter the Resource Person Feedback.");
        $('#resourcePersonFeedback').focus();
        return false;
    }
    if (jQuery.trim($('#industryLedSuggestions').val()) == "") {
        alert("Please Enter the Industry Led Suggestions.");
        $('#industryLedSuggestions').focus();
        return false;
    }
     var paramatervalue = {};
    paramatervalue.companyid = $("#compsession").val();
    paramatervalue.instituteid = $("#instsession").val();
    paramatervalue.transactionID = $("#transactionID").val();
    paramatervalue.transactionDate = $("#transactionDate").val();
    paramatervalue.departmentName = $("#departmentName").val();
    paramatervalue.titleOfTheProgram = $("#titleOfTheProgram").val();
    paramatervalue.programType = $("#programType").val();
    paramatervalue.startDate = $("#startDate").val();
    paramatervalue.endDate = $("#endDate").val();
    paramatervalue.speakerFeedback = $("#speakerFeedback").val();
    paramatervalue.guestParticipantsFeedback = $("#guestParticipantsFeedback").val();
    paramatervalue.industrialVisitFeedback = $("#industrialVisitFeedback").val();
    paramatervalue.feedbackOfParticipants = $("#feedbackOfParticipants").val();
    paramatervalue.feedbackOfIndustry = $("#feedbackOfIndustry").val();
    paramatervalue.industrialSuggestions = $("#industrialSuggestions").val();
    paramatervalue.overallProjectFeedback = $("#overallProjectFeedback").val();
    paramatervalue.feedbackOfPICOPI = $("#feedbackOfPICOPI").val();
    paramatervalue.projectSuggestions = $("#projectSuggestions").val();
    paramatervalue.instructorFeedback = $("#instructorFeedback").val();
    paramatervalue.industryLedParticipantsFeedback = $("#industryLedParticipantsFeedback").val();
    paramatervalue.resourcePersonFeedback = $("#resourcePersonFeedback").val();
    paramatervalue.industryLedSuggestions = $("#industryLedSuggestions").val();
    paramatervalue.remarks = $("#remarks").val();
    

    jData = {};
    jData.entryBy = $("#entryBy").val();
    jData.service = "IndustrialInteractionsFeedbackServlet";
    jData.handller = "saveupdate";
    jData.para = paramatervalue;
    $(document).getServace(jData);

}

function getData()
{
    jData = {};
    jData.service = "IndustrialInteractionsFeedbackServlet";
    jData.handller = "selectHeadingInfo";
    jData.transactionID = $("#transactionID").val();
    $(document).getServace(jData);
}


function getSelectGridData(pno)
{
     jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
    jData.service = "IndustrialInteractionsFeedbackServlet";
    jData.handller = "select";
    $(document).getServace(jData);
}

function getGridData() {
    $("#mastergrid").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 18%'>Transaction Date</th><th style='width: 18%'>Department </th><th style='width: 18%'>Title of the Program </th><th style='width: 18%'>Start Date</th><th style='width: 18%'>End Date</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 18%'>" + gridData[key]["transactionDate"] + "</td><td  style='width: 18%'>" + gridData[key]["department"] + "</td>";
        table = table + "<td  style='width: 18%'>" + gridData[key]["programTitle"] + "</td><td  style='width: 18%'>" + gridData[key]["startDate"] + "</td><td  style='width: 18%'>" + gridData[key]["endDate"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["transactionID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["transactionID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function updateMasterRecord(transactionID)
{
    jData = {};
    jData.service = "IndustrialInteractionsFeedbackServlet";
    jData.handller = "SelectforUpdate";
    jData.transactionID = transactionID;
    $(document).getServace(jData);
}

function resetValues()
{
    $("#transactionID").val("");
    $("#transactionDate").val("");
    $("#departmentName").val("");
    $("#programType").val("");
    $("#titleOfTheProgram").val("");
    $("#startDate").val("");
    $("#endDate").val("");
    $("#speakerFeedback").val("0");
    $("#guestParticipantsFeedback").val("0");
    $("#industrialVisitFeedback").val("");
    $("#feedbackOfParticipants").val("0");
    $("#feedbackOfIndustry").val("0");
    $("#industrialSuggestions").val("");
    $("#overallProjectFeedback").val("0");
    $("#feedbackOfPICOPI").val("0");
    $("#projectSuggestions").val("");
    $("#instructorFeedback").val("0");
    $("#industryLedParticipantsFeedback").val("0");
    $("#resourcePersonFeedback").val("");
    $("#industryLedSuggestions").val("");
    $("#remarks").val("");
    
}

function deleteMasterRecord(transactionID){
     var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "IndustrialInteractionsFeedbackServlet";
        jData.handller = "Delete";
        jData.transactionID = transactionID;
        $(document).getServace(jData);
    }
    else {
    }
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
        getSelectGridData("0");
    }
});