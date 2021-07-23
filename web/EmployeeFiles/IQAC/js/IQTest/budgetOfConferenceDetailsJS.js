/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var rc = 0;
var selectConferenceInfo = {};
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

        case 'selectConferenceInfo':
            selectConferenceInfo = jQuery.parseJSON(xhr.responseText);
            getSelectConferenceInfoInPopUp(selectConferenceInfo);
            $('#TOTAL').html("Total No.of Record(s): " + selectConferenceInfo[1].totalrecords);
            break;
        case 'setReceiptName':
            var receiptInfo = jQuery.parseJSON(xhr.responseText);
            $("#receiptName").val(receiptInfo["receiptName"]);
            $("#receiptType").val(receiptInfo["receiptType"]);
            break;
        case 'saveupdate':
            resetValues();
            break;
        case 'Delete':
            getSelectGridData(cupage.pr);
            break;
        case 'setExpenditureName':
            var expenditureInfo = jQuery.parseJSON(xhr.responseText);
            $("#expenditureName").val(expenditureInfo["expenditureName"]);
            $("#expenditureType").val(expenditureInfo["expenditureType"]);
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;
        case 'SelectforUpdate':
            var headerData = {};
            var receiptData = {};
            var expenditureData = {};
            headerData = jQuery.parseJSON(xhr.responseText);
            $("#budgetID").val(headerData["budgetID"]);
            $("#proposedConferenceName").val(headerData["conferenceName"]);
            $("#departmentName").val(headerData["department"]);
            $("#departmentCode").val(headerData["departmentCode"]);
            $("#typeOfConference").val(headerData["conferenceType"]);
            $("#supportingOrgName").val(headerData["supportOrgName"]);
            $("#supportingOrgAmount").val(headerData["supportOrgBudget"]);
            $("#conferenceID").val(headerData["conferenceID"]);
            $("#keyNoteSpeakersNo").val(headerData["keyNoteSpeakerNo"]);
            $("#keyNoteSpeakersNames").val(headerData["keyNoteSpeakerName"]);
            $("#invitedSpeakerNo").val(headerData["invitedSpeakerNo"]);
            $("#invitedSpeakerNames").val(headerData["invitedSpeakerName"]);
            $("#conferenceStartDate").val(headerData["conferenceStartDate"]);
            $("#conferenceEndDate").val(headerData["conferenceEndDate"]);
            $("#organizingSecretaryName").val(headerData["organizingSecretaryName"]);
            if (headerData["hodApproval"] == 'Y')
            {
                $("#approvalOfHODY").prop("checked", true);
            } else
            {
                $("#approvalOfHODN").prop("checked", true)
            }
            if (headerData["vcApproval"] == 'Y')
            {
                $("#approvalOfVCY").prop("checked", true);
            } else
            {
                $("#approvalOfVCN").prop("checked", true)
            }
            receiptData = headerData["receiptMap"];
            $("#receiptType").val(receiptData["receiptType"]);
            $("#receiptCode").val(receiptData["receiptCode"]);
            $("#receiptName").val(receiptData["receiptName"]);
            $("#receiptNo").val(receiptData["receiptNo"]);
            $("#receiptValue").val(receiptData["receiptValue"]);
            $("#receiptAmount").val(receiptData["receiptAmount"]);
            expenditureData= headerData["expenditureMap"];
            $("#expenditureType").val(expenditureData["expenditureType"]);
            $("#expenditureCode").val(expenditureData["expenditureCode"]);
            $("#expenditureName").val(expenditureData["expenditureName"]);
            $("#expenditureNo").val(expenditureData["expenditureNo"]);
            $("#expenditureValue").val(expenditureData["expenditureValue"]);
            $("#expenditureAmount").val(expenditureData["expenditureAmount"]);
            break;
    }
});


function getCommonMasterTable()
{
    $(".number").numeric();
    $(".nondecimal").numbernondecimal();
    $("#pagging").getPagging();
    $("#paggingPopUp").getPagging();
    $("#conferenceNameTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    $("#departmentName").prop("disabled", true); 
    $("#typeOfConference").prop("disabled", true);
    $("#specificFocusArea").prop("disabled", true);
    $("#objectives").prop("disabled", true);
    $("#proposedOutComes").prop("disabled", true);
    $("#proposedBudget").prop("disabled", true);
    $("#supportingOrgName").prop("disabled", true);
    $("#supportingOrgAmount").prop("disabled", true);
    $("#receiptName").prop("disabled", true); 
    $("#expenditureName").prop("disabled", true); 
    $("#receiptType").prop("disabled", true); 
    $("#expenditureType").prop("disabled", true); 
    
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
    if (jQuery.trim($('#proposedConferenceName').val()) == "") {
        alert("Please Enter the Proposed Conference Name.");
        $('#proposedConferenceName').focus();
        return false;
    }
    
    jData = {};
    jData.budgetID=$("#budgetID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.departmentName=$("#departmentName").val();
    jData.departmentCode=$("#departmentCode").val();
    jData.conferenceID = $("#conferenceID").val();
    jData.typeOfConference=$("#typeOfConference").val();
    jData.proposedConferenceName=$("#proposedConferenceName").val();
    jData.noOfKeynoteSpeakers=$("#keyNoteSpeakersNo").val();
    jData.keynoteSpeakerName=$("#keyNoteSpeakersNames").val();
    jData.noOfInvitedSpeakers=$("#invitedSpeakerNo").val();
    jData.invitedSpeakerName=$("#invitedSpeakerNames").val();
    jData.supportingOrgName=$("#supportingOrgName").val();
    jData.supportingOrgAmount=$("#supportingOrgAmount").val();
    jData.conferenceStartDate=$("#conferenceStartDate").val();
    jData.conferenceEndDate=$("#conferenceEndDate").val();
    jData.nameOfOrganizingSecretary=$("#organizingSecretaryName").val();
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
     jData.receiptType = $("#receiptType").val();
     jData.receiptCode = $("#receiptCode").val();
     jData.receiptName = $("#receiptName").val();
     jData.receiptNo = $("#receiptNo").val();
     jData.receiptValue = $("#receiptValue").val();
     jData.receiptAmount = $("#receiptAmount").val();
     jData.expenditureType = $("#expenditureType").val();
     jData.expenditureCode = $("#expenditureCode").val();
     jData.expenditureName = $("#expenditureName").val();
     jData.expenditureNo = $("#expenditureNo").val();
     jData.expenditureValue = $("#expenditureValue").val();
     jData.expenditureAmount = $("#expenditureAmount").val();
    
    jData.entryBy = $("#entryBy").val();
    jData.service = "BudgetOfConferenceDetailsServlet";
    jData.handller = "saveupdate";
    $(document).getServace(jData);
}

$(function() {
    $("#conferenceNames").dialog({
        autoOpen: false,
        show: {
            effect: "blind",
            duration: 1000
        },
        hide: {
            effect: "explode",
            duration: 1000
        },
        width:$( window ).width()-130,
        height:300
        
    });
    $("#proposedConferenceName").click(function() {
        $("#conferenceNames").dialog("open");
        getConferenceNames("0");

    });
});

function getConferenceNames(pno)
{
    
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectConferenceInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    jData.spg = pno;
    jData.searchNames = $("#searchNames").val();
    jData.service = "BudgetOfConferenceDetailsServlet";
    jData.handller = "selectConferenceInfo";
    $(document).getServace(jData);

}

function getSelectConferenceInfoInPopUp(){
     var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 19%'>Department</th><th style='width: 19%'>Conference Name</th><th style='width: 19%'>Conference Start Date</th><th style='width: 19%'>Conference End Date</th><th style='width: 19%'>Organizing Secretary Name </th>");
    
     for (var key in selectConferenceInfo) {
        table = table + "<tr ondblclick='setNames("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectConferenceInfo[key]["sno"] + "</td><td  style='width: 19%;text-align: left'>" + selectConferenceInfo[key]["department"] + "</td><td  style='width: 19%;text-align: left'>" + selectConferenceInfo[key]["conferenceName"] + "</td><td  style='width: 19%';text-align: left>" + selectConferenceInfo[key]["conferenceStartDate"] + "</td><td  style='width: 19%';text-align: left>" + selectConferenceInfo[key]["conferenceEndDate"] + "</td><td  style='width: 19%;text-align: left'>" + selectConferenceInfo[key]["organizingSecretaryName"] + "</td></tr>";
    }

    $("#conferenceNamesBody").html("");
    $("#conferenceNamesBody").html("" + table);
   
 $("#popupHeaderTable").css("width",$("#conferenceNamesBody").width());
}


function setNames(key)
{   
    $("#conferenceID").val(selectConferenceInfo[key]["conferenceID"]);
    $("#departmentName").val(selectConferenceInfo[key]["department"]);
    $("#departmentCode").val(selectConferenceInfo[key]["departmentCode"]);
    $("#proposedConferenceName").val(selectConferenceInfo[key]["conferenceName"]);
    $("#typeOfConference").val(selectConferenceInfo[key]["conferenceType"]);
    $("#supportingOrgName").val(selectConferenceInfo[key]["supportOrgName"]);
    $("#supportingOrgAmount").val(selectConferenceInfo[key]["supportOrgBudget"]);
    $("#keyNoteSpeakersNo").val(selectConferenceInfo[key]["keyNoteSpeakerNo"]);
    $("#keyNoteSpeakersNames").val(selectConferenceInfo[key]["keyNoteSpeakerName"]);
    $("#invitedSpeakerNo").val(selectConferenceInfo[key]["invitedSpeakerNo"]);
    $("#invitedSpeakerNames").val(selectConferenceInfo[key]["invitedSpeakerName"]);
    $("#conferenceStartDate").val(selectConferenceInfo[key]["conferenceStartDate"]);
    $("#conferenceEndDate").val(selectConferenceInfo[key]["conferenceEndDate"]);
    $("#organizingSecretaryName").val(selectConferenceInfo[key]["organizingSecretaryName"]);
    if (selectConferenceInfo[key]["hodApproval"] == 'Y')
    {
        $("#approvalOfHODY").prop("checked", true);
    } else
    {
        $("#approvalOfHODN").prop("checked", true)
    }
    if (selectConferenceInfo[key]["vcApproval"] == 'Y')
    {
        $("#approvalOfVCY").prop("checked", true);
    } else
    {
        $("#approvalOfVCN").prop("checked", true)
    }
    $("#conferenceNames").dialog("close");
    
}

function getReceiptName()
{
    jData = {};
    jData.service = "BudgetOfConferenceDetailsServlet";
    jData.handller = "setReceiptName";
    jData.receiptCode = $("#receiptCode").val();
    $(document).getServace(jData);
}

function getExpenditureName()
{
    jData = {};
    jData.service = "BudgetOfConferenceDetailsServlet";
    jData.handller = "setExpenditureName";
    jData.expenditureCode = $("#expenditureCode").val(); 
    $(document).getServace(jData); 
}

function getSelectGridData(pno) {  
alert("HELLO");
    jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
     jData.staffID = $("#entryBy").val();
    jData.searchbox = $("#searchbox").val();
    jData.service = "BudgetOfConferenceDetailsServlet";
    jData.handller = "select";

    $(document).getServace(jData);
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getConferenceNames("0");  
      getSelectGridData("0");
    }
});


function getGridData() {
    $("#mastergrid").yattable({
        width: "100%",
        height: 200,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 14%'>Rec./Exp. Type</th><th style='width: 14%'>Rec./Exp. Code</th><th style='width: 15%'>Rec./Exp. Name</th><th style='width: 14%'>Rec./Exp. No</th><th style='width: 14%'>Rec./Exp. Value</th><th style='width: 14%'>Rec./Exp. Amount</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        var recexpno = gridData[key]["recExpNo"];
        if (recexpno == null)
        {
            recexpno = "";
        }
        var recexprate = gridData[key]["recExpRate"];
        if (recexprate == null)
        {
            recexprate = "";
        }
        var recexpamount = gridData[key]["recExpAmount"];
        if (recexpamount == null)
        {
            recexpamount = "";
        }
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 14%'>" + gridData[key]["recExpType"] + "</td><td  style='width: 14%'>" + gridData[key]["recExpCode"] + "</td><td  style='width: 15%'>" + gridData[key]["recExpName"] + "</td>";
        table = table + "<td  style='width: 14%'>" + recexpno + "</td><td  style='width: 14%'>" + recexprate + "</td><td  style='width: 14%'>" + recexpamount + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["budgetID"] + "\",\"" + gridData[key]["recExpType"] + "\",\"" + gridData[key]["recExpCode"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["budgetID"] + "\",\"" + gridData[key]["recExpType"] + "\",\"" + gridData[key]["recExpCode"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function updateMasterRecord(budgetID,recExpType,recExpCode)
{
    jData = {};
    jData.service = "BudgetOfConferenceDetailsServlet";
    jData.handller = "SelectforUpdate";
    jData.budgetID = budgetID;
    jData.recExpType = recExpType;
    jData.recExpCode = recExpCode;
    $(document).getServace(jData);

}

function resetValues()
{
    $("#conferenceID").val("0");
    $("#budgetID").val("0");
    $("#departmentName").val("");
    $("#proposedConferenceName").val("");
    $("#typeOfConference").val("0");
    $("#supportingOrgName").val("");
    $("#supportingOrgAmount").val("");
    $("#conferenceStartDate").val("0");
    $("#conferenceEndDate").val("0");
    $("#keyNoteSpeakersNo").val("0");
    $("#keyNoteSpeakersNames").val("0");
    $("#invitedSpeakerNo").val("");
    $("#invitedSpeakerNames").val("");
    $("#organizingSecretaryName").val("");
    $("input:radio").attr("checked", false);
    $("#receiptType").val("");
    $("#receiptCode").val("");
    $("#receiptName").val("");
    $("#receiptNo").val("");
    $("#receiptValue").val("");
    $("#receiptAmount").val("");
    $("#expenditureType").val("");
    $("#expenditureCode").val("");
    $("#expenditureName").val("");
    $("#expenditureNo").val("");
    $("#expenditureValue").val("");
    $("#expenditureAmount").val("");
    location.reload(); 
}

function deleteMasterRecord(budgetID,recExpType,recExpCode)
{
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "BudgetOfConferenceDetailsServlet";
        jData.handller = "Delete";
        jData.budgetID = budgetID;
        jData.recExpType = recExpType;
        jData.recExpCode = recExpCode;
        $(document).getServace(jData);
    }
    else {
    }
}

function getReceiptAmount()
{
    var rNo=$("#receiptNo").val();
    var rValue=$("#receiptValue").val();
    $("#receiptAmount").val(rNo*rValue);
}

function getExpenditureAmount()
{
    var eNo=$("#expenditureNo").val();
    var eValue=$("#expenditureValue").val();
    $("#expenditureAmount").val(eNo*eValue);
}