/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var rc = 0;
var cupage = {};
var gridData = {};
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
            data : 'jdata='+JSON.stringify(para).replace(/&/g,"").replace(/%/g,""),
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

        case 'saveupdate':
            if (xhr.responseText == "")
            {
                alert("Record Not Saved");
            } else
            {
                alert("Record Saved Successfully");
            }
            resetValues();
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;
        case 'SelectforUpdate':
            var SelectData = {};
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#departmentName").prop("disabled", true); 
            $("#conferenceID").val(SelectData["conferenceID"]);
            $("#departmentName").val(SelectData["departmentCode"]);
            $("#proposedConferenceName").val(SelectData["conferenceName"]);
            $("#typeOfConference").val(SelectData["conferenceType"]);
            $("#specificFocusArea").val(SelectData["specificFocusArea"]);
            $("#objectives").val(SelectData["objectives"]);
            $("#proposedOutComes").val(SelectData["proposedOutComes"]);
            $("#proposedBudget").val(SelectData["proposedBudget"]);
            $("#supportingOrgName").val(SelectData["supportOrgName"]);
            $("#supportingOrgAmount").val(SelectData["supportOrgBudget"]);
            $("#conferenceStartDate").val(SelectData["conferenceStartDate"]);
            $("#conferenceEndDate").val(SelectData["conferenceEndDate"]);
            $("#expectedParticipants").val(SelectData["participantsNo"]);
            $("#expectedPapers").val(SelectData["papersNo"]);
            $("#noOfKeynoteSpeakers").val(SelectData["keyNoteSpeakerNo"]);
            $("#keynoteSpeakerName").val(SelectData["keyNoteSpeakerName"]);
            $("#noOfInvitedSpeakers").val(SelectData["invitedSpeakerNo"]);
            $("#invitedSpeakerName").val(SelectData["invitedSpeakerName"]);
            $("#noOfParallelSessions").val(SelectData["parallelSessionNo"]);
            $("#tutorialWithConference").val(SelectData["tutorialWithConference"]);
            $("#annualEvent").val(SelectData["annualEvent"]);
            $("#gainArea").val(SelectData["gainArea"]);
            $("#nameOfOrganizingSecretary").val(SelectData["organizingSecretaryName"]);
            if (SelectData["hodApproval"] == 'Y')
            {
                $("#approvalOfHODY").prop("checked", true);
            } else
            {
                $("#approvalOfHODN").prop("checked", true)
            }
            if (SelectData["vcApproval"] == 'Y')
            {
                $("#approvalOfVCY").prop("checked", true);
            } else
            {
                $("#approvalOfVCN").prop("checked", true)
            }
            getNoOfDays();
            break;
        case 'Delete':
            getSelectGridData(cupage.pr);
            break;
        case 'setDays':
            $("#noOfDays").val(xhr.responseText);
            break;
    }
});



function getCommonMasterTable()
{
    $("#pagging").getPagging();
    $(".number").numeric();
    $(".nondecimal").numbernondecimal();
    $("#noOfDays").prop("disabled", true); 
    getSelectGridData("0");
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
    
    if (jQuery.trim($('#departmentName').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentName').focus();
        return false;
    }
    if (jQuery.trim($('#proposedConferenceName').val()) == "") {
        alert("Please Enter the Proposed Conference Name.");
        $('#proposedConferenceName').focus();
        return false;
    }
    if (jQuery.trim($('#typeOfConference').val()) == 0) {
        alert("Please Select the Type Of Conference.");
        $('#typeOfConference').focus();
        return false;
    }
    if (jQuery.trim($('#proposedBudget').val()) == "") {
        alert("Please Enter the Proposed Budget.");
        $('#proposedBudget').focus();
        return false;
    }
    if (jQuery.trim($('#conferenceStartDate').val()) == "") {
        alert("Please Enter the Conference Start Date.");
        $('#conferenceStartDate').focus();
        return false;
    }
    if (jQuery.trim($('#conferenceEndDate').val()) == "") {
        alert("Please Enter the  Conference End Date.");
        $('#conferenceEndDate').focus();
        return false;
    }
    if (jQuery.trim($('#noOfKeynoteSpeakers').val()) == "") {
        alert("Please Enter the No. Of Keynote Speakers.");
        $('#noOfKeynoteSpeakers').focus();
        return false;
    }
    if (jQuery.trim($('#keynoteSpeakerName').val()) == "") {
        alert("Please Enter the Keynote Speaker Name.");
        $('#keynoteSpeakerName').focus();
        return false;
    }
    if (jQuery.trim($('#annualEvent').val()) == 0) {
        alert("Please Select the Annual Event.");
        $('#annualEvent').focus();
        return false;
    }
    if (jQuery.trim($('#nameOfOrganizingSecretary').val()) == "") {
        alert("Please Enter the Name Of Organizing Secretary.");
        $('#nameOfOrganizingSecretary').focus();
        return false;
    }
    if ($('input[name=approvalOfHOD]:checked').length <= 0)
    {
        alert("Please choose Approval Of HOD ");
        return false;
    }
    if ($('input[name=approvalOfVC]:checked').length <= 0)
    {
        alert("Please choose Approval Of VC ");
        return false;
    }
    
    jData = {};
    jData.conferenceID = $("#conferenceID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.departmentName=$("#departmentName").val();
    jData.proposedConferenceName=$("#proposedConferenceName").val();
    jData.typeOfConference=$("#typeOfConference").val();
    jData.specificFocusArea=$("#specificFocusArea").val();
    jData.objectives=$("#objectives").val();
    jData.proposedOutComes=$("#proposedOutComes").val();
    jData.proposedBudget=$("#proposedBudget").val();
    jData.proposedOutComes=$("#proposedOutComes").val();
    jData.proposedBudget=$("#proposedBudget").val();
    jData.supportingOrgName=$("#supportingOrgName").val();
    jData.supportingOrgAmount=$("#supportingOrgAmount").val();
    jData.conferenceStartDate=$("#conferenceStartDate").val();
    jData.conferenceEndDate=$("#conferenceEndDate").val();
    jData.expectedParticipants=$("#expectedParticipants").val();
    jData.expectedPapers=$("#expectedPapers").val();
    jData.noOfKeynoteSpeakers=$("#noOfKeynoteSpeakers").val();
    jData.keynoteSpeakerName=$("#keynoteSpeakerName").val();
    jData.noOfInvitedSpeakers=$("#noOfInvitedSpeakers").val();
    jData.invitedSpeakerName=$("#invitedSpeakerName").val();
    jData.noOfParallelSessions=$("#noOfParallelSessions").val();
    jData.tutorialWithConference=$("#tutorialWithConference").val();
    jData.annualEvent=$("#annualEvent").val();
    jData.gainArea=$("#gainArea").val();
    jData.nameOfOrganizingSecretary=$("#nameOfOrganizingSecretary").val();
    if ($("#approvalOfHODY").prop("checked")) {
        jData.approvalOfHOD="Y";
    }
    if ($("#approvalOfHODN").prop("checked")) {
        jData.approvalOfHOD="N";
    }
    if ($("#approvalOfVCY").prop("checked")) {
        jData.approvalOfVC = "Y";
    }
    if ($("#approvalOfVCN").prop("checked")) {
        jData.approvalOfVC = "N";
    }
    jData.entryBy = $("#entryBy").val();
    
    jData.service = "ConferenceTransactionServlet";
    jData.handller = "saveupdate";
    $(document).getServace(jData);
    
    
}

function resetValues()
{
    $("#conferenceID").val("0");
    $("#departmentName").val("");
    $("#proposedConferenceName").val("");
    $("#typeOfConference").val("0");
    $("#specificFocusArea").val("");
    $("#objectives").val("");
    $("#proposedOutComes").val("");
    $("#proposedBudget").val("");
    $("#supportingOrgName").val("");
    $("#supportingOrgAmount").val("");
    $("#conferenceStartDate").val("");
    $("#conferenceEndDate").val("");
    $("#noOfDays").val("");
    $("#expectedParticipants").val("");
    $("#expectedPapers").val("");
    $("#noOfKeynoteSpeakers").val("");
    $("#keynoteSpeakerName").val("");
    $("#noOfInvitedSpeakers").val("");
    $("#invitedSpeakerName").val("");
    $("#noOfParallelSessions").val("");
    $("#tutorialWithConference").val("");
    $("#annualEvent").val("0");
    $("#gainArea").val("");
    $("#nameOfOrganizingSecretary").val("");
    $("input:radio").attr("checked", false);
    $("#departmentName").prop("disabled", false); 
    location.reload(); 
}

function getSelectGridData(pno) {

    jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
    jData.departmentName = $("#departmentName").val();
    jData.service = "ConferenceTransactionServlet";
    jData.handller = "select";

    $(document).getServace(jData);
}

function getGridData() {
    $("#mastergrid").yattable({
        width: "100%",
        height: 300,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 8%'>Department Name</th><th style='width: 7%'>Proposed Conference Name</th><th style='width: 7%'>Type Of Conference </th><th style='width: 7%'>Proposed Budget</th><th style='width: 7%'>Conference Start Date</th><th style='width: 7%'>Conference End Date</th><th style='width: 7%'>No. Of Keynote Speakers</th><th style='width: 7%'>Keynote Speaker Name</th><th style='width: 7%'>Annual Event</th><th style='width: 7%'>Name Of Organizing Secretary</th><th style='width: 7%'>Approval Of HOD</th><th style='width: 7%'>Approval Of VC</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 8%'>" + gridData[key]["departmentName"] + "</td><td  style='width: 7%'>" + gridData[key]["conferenceName"] + "</td><td  style='width: 7%'>" +getConferenceType(gridData[key]["conferenceType"]) + "</td>";
        table = table + "<td  style='width: 7%'>" + gridData[key]["proposedBudget"] + "</td><td  style='width: 7%'>" + gridData[key]["conferenceStartDate"] + "</td><td  style='width: 7%'>" + gridData[key]["conferenceEndDate"] + "</td>";
        table = table + "<td  style='width: 7%'>" + gridData[key]["keynoteSpeakersNo"] + "</td><td  style='width: 7%'>" + gridData[key]["keynoteSpeakersName"] + "</td><td  style='width: 7%'>" +getAnnualEvent(gridData[key]["annualEvent"]) + "</td>";
        table = table + "<td  style='width: 7%'>" + gridData[key]["organizingSecretaryName"] + "</td><td  style='width: 7%'>" + gridData[key]["hodApproval"] + "</td><td  style='width: 7%'>" + gridData[key]["vcApproval"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["conferenceID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["conferenceID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function updateMasterRecord(conferenceID)
{
    jData = {};
    jData.service = "ConferenceTransactionServlet";
    jData.handller = "SelectforUpdate";
    jData.conferenceID = conferenceID;
    $(document).getServace(jData);
}

function deleteMasterRecord(conferenceID)
{
    
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "ConferenceTransactionServlet";
        jData.handller = "Delete";
        jData.conferenceID = conferenceID;
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

function getNoOfDays()
{
    
    jData = {};
    jData.conferenceStartDate = $("#conferenceStartDate").val();
    jData.conferenceEndDate = $("#conferenceEndDate").val();
    jData.service = "ConferenceTransactionServlet";
    jData.handller = "setDays";
    $(document).getServace(jData);
}

function getConferenceType(conferenceType)
{
    var cType = "";
    if (conferenceType == "I")
    {
        cType = "International";
    } else
    {
        cType = "National";
    }
    return cType;
}

function getAnnualEvent(annualEvent)
{
    var aEvent = "";
    if (annualEvent == "Y")
    {
        aEvent = "Yes";
    } else
    {
        aEvent = "No";
    }
    return aEvent;
}

function getValidateCost()
{
    if ($("#proposedBudget").val() < 0)
    {
        alert("Proposed Budget must be Positive");
        $('#proposedBudget').val("");
         return false;
    }
}

function getValidateAmount()
{
    if ($("#supportingOrgAmount").val() < 0)
    {
        alert("Supporting Org. Amount must be Positive");
        $('#supportingOrgAmount').val("");
         return false;
    }
}
