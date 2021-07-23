/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var rc = 0;
var selectConferenceInfo = {};
var gridData = {};
var gridDataForQuestion={};
var list=[];
var tempgrid={};
var gridcount={"c":0,"urrow":"","uerow":""};
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
            getSelectGridData("0");
            break;
        case 'feedbackID':
            var feedID=xhr.responseText;
            $("#feedbackID").val(feedID)
            getQuestions(feedID);
            break;
        case 'setExpenditureName':
            var expenditureInfo = jQuery.parseJSON(xhr.responseText);
            $("#expenditureName").val(expenditureInfo["expenditureName"]);
            $("#expenditureType").val(expenditureInfo["expenditureType"]);
            break;
        case 'selectGridDataForQuestions':
            gridDataForQuestion = jQuery.parseJSON(xhr.responseText);
            getGridDataForQuestions(gridDataForQuestion);
            break;
        case 'upgradeForQuestions':
            var childData=jQuery.parseJSON(xhr.responseText);
            for (var key1 in childData) {
                for (var key in gridDataForQuestion) {
                    //$("#rating" + key).val("");
                    if (gridDataForQuestion[key]["questionid"] == childData[key1]["questionID"]) {
                        var temp=childData[key1]["rating"];
                        if(temp==null)
                            {
                                temp="";
                            }
                            
                        $("#rating" + key).val(temp);
                        if (childData[key1]["rating"] == null) {
                            var rMarks=childData[key1]["userRemarks"];
                            if(rMarks==null || rMarks=='null')
                                {
                                 rMarks="";   
                                }
                                
                            $("#rating" + key).val(rMarks);
                        }
                        $("#remarks" + key).val(childData[key1]["questionRemarks"]);
                        continue;

                    }

                }
            }
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            break;
        case 'SelectforUpdate':
            var headerData = {};
            var recExpData = {};
            headerData = jQuery.parseJSON(xhr.responseText);
            $("#budgetID").val(headerData["budgetID"]);
            $("#actualConferenceName").val(headerData["actualConferenceName"]);
            $("#departmentName").val(headerData["department"]);
            $("#departmentCode").val(headerData["departmentCode"]);
            $("#typeOfConference").val(headerData["conferenceType"]);
            $("#supportingOrgName").val(headerData["supportOrgName"]);
            $("#supportingOrgAmount").val(headerData["supportOrgBudget"]);
            $("#conferenceID").val(headerData["conferenceID"]);
            getQuestionGridData($("#conferenceID").val());
            $("#keyNoteSpeakersNo").val(headerData["keyNoteSpeakerNo"]);
            $("#keyNoteSpeakersNames").val(headerData["keyNoteSpeakerName"]);
            $("#invitedSpeakerNo").val(headerData["invitedSpeakerNo"]);
            $("#invitedSpeakerNames").val(headerData["invitedSpeakerName"]);
            $("#conferenceStartDate").val(headerData["conferenceStartDate"]);
            $("#conferenceEndDate").val(headerData["conferenceEndDate"]);
            $("#organizingSecretary").val(headerData["organizingSecretary"]);
            $("#actualOutComes").val(headerData["actualOutComes"]);
            $("#actualBudget").val(headerData["actualBudget"]);
            $("#specificFocusArea").val(headerData["specificFocusArea"]);
            $("#objectives").val(headerData["objectives"]);
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
            tempgrid = headerData["recExpMap"];
            displayGridData();
            var count=0;
            for(var key in tempgrid)
                {
                    count++;
                }
            gridcount={"c":count,"urrow":"","uerow":""};
            $("#actualConferenceName").prop("disabled", true);
            $("#typeOfConference").prop("disabled", true);
            $("#organizingSecretary").prop("disabled", true);
            $("#supportingOrgName").prop("disabled", true);
            $("#supportingOrgAmount").prop("disabled", true);
            $("#departmentName").prop("disabled", true);
            break;
    }
});

$(function() {
$( "#tabs" ).tabs();
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
    getSelectGridData("0");
    getFeedBackID();
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
    $("#actualConferenceName").click(function() {
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
    jData.service = "FeedbackOfConferenceServlet";
    jData.handller = "selectConferenceInfo";
    $(document).getServace(jData);

}

function getSelectConferenceInfoInPopUp(){
     var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 19%'>Department</th><th style='width: 19%'>Conference Name</th><th style='width: 19%'>Conference Start Date</th><th style='width: 19%'>Conference End Date</th><th style='width: 19%'>Organizing Secretary Name </th>");
    
     for (var key in selectConferenceInfo) {
        table = table + "<tr ondblclick='setNames("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectConferenceInfo[key]["sno"] + "</td><td  style='width: 19%;text-align: left'>" + selectConferenceInfo[key]["departmentName"] + "</td><td  style='width: 19%;text-align: left'>" + selectConferenceInfo[key]["conferenceName"] + "</td><td  style='width: 19%';text-align: left>" + selectConferenceInfo[key]["conferenceStartDate"] + "</td><td  style='width: 19%';text-align: left>" + selectConferenceInfo[key]["conferenceEndDate"] + "</td><td  style='width: 19%;text-align: left'>" + selectConferenceInfo[key]["organizingSecretaryName"] + "</td></tr>";
    }

    $("#conferenceNamesBody").html("");
    $("#conferenceNamesBody").html("" + table);
   
 $("#popupHeaderTable").css("width",$("#conferenceNamesBody").width());
}

function setNames(key)
{   
    $("#budgetID").val(selectConferenceInfo[key]["budgetID"]);
    $("#conferenceID").val(selectConferenceInfo[key]["conferenceID"]);
    $("#departmentName").val(selectConferenceInfo[key]["departmentName"]);
    $("#departmentCode").val(selectConferenceInfo[key]["departmentCode"]);
    $("#actualConferenceName").val(selectConferenceInfo[key]["conferenceName"]);
    $("#typeOfConference").val(selectConferenceInfo[key]["conferenceType"]);
    $("#supportingOrgName").val(selectConferenceInfo[key]["supportOrgName"]);
    $("#supportingOrgAmount").val(selectConferenceInfo[key]["supportOrgBudget"]);
    $("#keyNoteSpeakersNo").val(selectConferenceInfo[key]["keyNoteSpeakerNo"]);
    $("#keyNoteSpeakersNames").val(selectConferenceInfo[key]["keyNoteSpeakerName"]);
    $("#invitedSpeakerNo").val(selectConferenceInfo[key]["invitedSpeakerNo"]);
    $("#invitedSpeakerNames").val(selectConferenceInfo[key]["invitedSpeakerName"]);
    $("#conferenceStartDate").val(selectConferenceInfo[key]["conferenceStartDate"]);
    $("#conferenceEndDate").val(selectConferenceInfo[key]["conferenceEndDate"]);
    $("#organizingSecretary").val(selectConferenceInfo[key]["organizingSecretaryName"]);
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
    $("#actualConferenceName").prop("disabled", true); 
    $("#typeOfConference").prop("disabled", true); 
    $("#organizingSecretary").prop("disabled", true); 
    $("#supportingOrgName").prop("disabled", true); 
    $("#supportingOrgAmount").prop("disabled", true);
    $("#departmentName").prop("disabled", true);
    $("#conferenceNames").dialog("close");
    getQuestionGridData($("#conferenceID").val());
}

function getReceiptName()
{
    jData = {};
    jData.service = "FeedbackOfConferenceServlet";
    jData.handller = "setReceiptName";
    jData.receiptCode = $("#receiptCode").val();
    $(document).getServace(jData);
}

function getExpenditureName()
{
    jData = {};
    jData.service = "FeedbackOfConferenceServlet";
    jData.handller = "setExpenditureName";
    jData.expenditureCode = $("#expenditureCode").val();
    $(document).getServace(jData); 
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

function formsubmit()
{
    
    if (jQuery.trim($('#actualConferenceName').val()) == "") {
        alert("Please Enter the Conference Name.");
        $('#actualConferenceName').focus();
        return false;
    }
    if (jQuery.trim($('#actualBudget').val()) == "") {
        alert("Please Enter the Actual Budget.");
        $('#actualBudget').focus();
        return false;
    }
    
    $("#tabs").tabs("option", "active", eval("1"));
    var count="0";
    
    if ((jQuery.trim($('#rating6').val()) != '' && jQuery.trim($('#remarks6').val()) != '') && (jQuery.trim($('#rating7').val()) != '' && jQuery.trim($('#remarks7').val()) != ''))
    {
        count = "1"
    }
    if(count=="0")
        {
        alert("Please Enter the Feedback and Remarks of all mandatory questions."); 
        return false;
        }
        
    
        var questionsDataList=[];
    for (var key in gridDataForQuestion) {
       var questionsData={};
        if(($('#rating'+key).val()!='' || $('#remarks'+key).val()!='' )&& $('#rating'+key).val()!=undefined)
            {
        questionsData.companyid=$("#compsession").val();
        questionsData.instituteid=$("#instsession").val();
        questionsData.conferenceID=$("#conferenceID").val();
        questionsData.feedbackName=$("#feedbackID").val();
        questionsData.questionID=gridDataForQuestion[key]["questionid"];
        questionsData.questions=gridDataForQuestion[key]["questionbody"];
        questionsData.ratingid=gridDataForQuestion[key]["ratingid"];
        if($("#rating"+key).val().length>1){
        questionsData.remarks=$("#rating"+key).val();  
        }else{
        questionsData.rating=$("#rating"+key).val();
        }
        questionsData.appfeedbackItemRemarks=$("#remarks"+key).val();
        questionsDataList.push(questionsData);   
            }
        
    }
    
    jData = {};
    jData.budgetID=$("#budgetID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.departmentName=$("#departmentName").val();
    jData.departmentCode=$("#departmentCode").val();
    jData.conferenceID = $("#conferenceID").val();
    jData.typeOfConference=$("#typeOfConference").val();
    jData.actualConferenceName=$("#actualConferenceName").val();
    jData.noOfKeynoteSpeakers=$("#keyNoteSpeakersNo").val();
    jData.keynoteSpeakerName=$("#keyNoteSpeakersNames").val();
    jData.noOfInvitedSpeakers=$("#invitedSpeakerNo").val();
    jData.invitedSpeakerName=$("#invitedSpeakerNames").val();
    jData.supportingOrgName=$("#supportingOrgName").val();
    jData.supportingOrgAmount=$("#supportingOrgAmount").val();
    jData.conferenceStartDate=$("#conferenceStartDate").val();
    jData.conferenceEndDate=$("#conferenceEndDate").val();
    jData.nameOfOrganizingSecretary=$("#organizingSecretary").val();
    jData.actualOutComes=$("#actualOutComes").val();
    jData.actualBudget=$("#actualBudget").val();
    jData.specificFocusArea=$("#specificFocusArea").val();
    jData.objectives=$("#objectives").val();
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
     
    
    jData.para = questionsDataList;
    jData.para1 = tempgrid;
    jData.entryBy = $("#entryBy").val();
    jData.service = "FeedbackOfConferenceServlet";
    jData.handller = "saveupdate";
    $(document).getServace(jData);
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
    jData.service = "FeedbackOfConferenceServlet";
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
    $("#mastergrid_Budget").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead_Budget").html("");
      $("#gridhead_Budget").html("<th style='width: 5%'>Sl No.</th><th style='width: 15%'>Conference Name</th><th style='width: 15%'>Organizing Secretary</th><th style='width: 15%'>Department Name</th><th style='width: 15%'>Support Org. Name</th><th style='width: 15%'>Support Org. Amount</th><th style='width: 15%'>Specific Focus Area</th><th style='width: 5%'></th>");

    for (var key in gridData) {
        var specificFocusArea = gridData[key]["specificFocusArea"];
        if (specificFocusArea == null)
        {
            specificFocusArea = "";
        }
        
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 14%'>" + gridData[key]["conferenceName"] + "</td><td  style='width: 14%'>" + gridData[key]["organizingSecretaryName"] + "</td><td  style='width: 15%'>" + gridData[key]["departmentName"] + "</td>";
        table = table + "<td  style='width: 14%'>" +  gridData[key]["supportOrgName"]  + "</td><td  style='width: 14%'>" + gridData[key]["supportOrgAmount"] + "</td><td  style='width: 14%'>" + specificFocusArea + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["budgetID"] + "\")'></td></tr>";
    }

    $("#gridbody_Budget").html("");
    $("#gridbody_Budget").html("" + table);
    $("#mastergrid1_Budget").css("width", $("#mastergrid_Budget").width());

}

function updateMasterRecord(budgetID)
{
    jData = {};
    jData.service = "FeedbackOfConferenceServlet";
    jData.handller = "SelectforUpdate";
    jData.budgetID = budgetID;
    $(document).getServace(jData);

}

function resetValues()
{
    $("#conferenceID").val("0");
    $("#budgetID").val("0");
    $("#departmentName").val("");
    $("#actualConferenceName").val("");
    $("#typeOfConference").val("0");
    $("#supportingOrgName").val("");
    $("#supportingOrgAmount").val("");
    $("#conferenceStartDate").val("0");
    $("#conferenceEndDate").val("0");
    $("#keyNoteSpeakersNo").val("0");
    $("#keyNoteSpeakersNames").val("0");
    $("#invitedSpeakerNo").val("");
    $("#invitedSpeakerNames").val("");
    $("#organizingSecretary").val("");
    $("#specificFocusArea").val("");
    $("#objectives").val("");
    $("#actualOutComes").val("");
    $("#actualBudget").val("");
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
    $("#actualConferenceName").prop("disabled", false); 
    $("#typeOfConference").prop("disabled", false); 
    $("#organizingSecretary").prop("disabled", false); 
    $("#supportingOrgName").prop("disabled", false); 
    $("#supportingOrgAmount").prop("disabled", false);
    $("#departmentName").prop("disabled", false);
    location.reload(); 
}

function getFeedBackID()
{
    jData = {};
    jData.service = "FeedbackOfConferenceServlet";
    jData.handller = "feedbackID";
    $(document).getServace(jData);  
}

function getQuestions(feedID)
{
    
    jData = {};
    jData.service = "FeedbackOfConferenceServlet";
    jData.handller = "selectGridDataForQuestions";
    jData.feedbackID = feedID;
    $(document).getServace(jData);
}

function getGridDataForQuestions()
{
     $("#mastergrid_Feedback").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead_Feedback").html("");
     $("#gridhead_Feedback").html("<th style='width: 5%'>Sl No.</th><th style='width: 33%'>Questions</th><th style='width: 31%'>Rating</th><th style='width: 31%'>Remarks</th>");
     // $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 50%'>Questions</th><th style='width: 45%'>Feedback/Rating</th>");
    for (var key in gridDataForQuestion) {
        if(gridDataForQuestion[key]["slno"]!=undefined){
        if(gridDataForQuestion[key]["flag"]=='Y'){
        table = table + "<tr><td  style='width: 5%'>" + gridDataForQuestion[key]["slno"] + "</td><td  style='width: 33%'>" + gridDataForQuestion[key]["questionbody"] + "</td><td  style='width: 31%'></td><td  style='width: 31%'></td>";   
       // table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 50%'>" + gridData[key]["questionbody"] + "</td><td  style='width: 45%'></td>";   
            }else{
                if(gridDataForQuestion[key]["slno"]=="6" || gridDataForQuestion[key]["slno"]=="7"){
           table = table + "<tr><td  style='width: 5%'>" + gridDataForQuestion[key]["slno"] + "</td><td  style='width: 33%'>" + gridDataForQuestion[key]["questionbody"] + "<span class='req'> *</span></td><td  style='width: 31%'>"+getRating(gridDataForQuestion["rating"][gridDataForQuestion[key]["ratingid"]],key)+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' style='width:75%' maxlength='100'></td>";                 
                }else{
           table = table + "<tr><td  style='width: 5%'>" + gridDataForQuestion[key]["slno"] + "</td><td  style='width: 33%'>" + gridDataForQuestion[key]["questionbody"] + "</td><td  style='width: 31%'>"+getRating(gridDataForQuestion["rating"][gridDataForQuestion[key]["ratingid"]],key)+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' style='width:75%' maxlength='100'></td>";         
                }         // table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 50%'>" + gridData[key]["questionbody"] + "</td><td  style='width: 45%'>"+getRating(gridData["rating"][gridData[key]["ratingid"]],key)+"</td>";
            }// table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["transactionid"] + "\")'></td></tr>";
    }
    }
    $("#gridbody_Feedback").html("");
    $("#gridbody_Feedback").html("" + table);
   
}
function getRating(li,key) {
    
    var op="";
    if (li != undefined) {
        var opli = jQuery.parseJSON(li);
        if(opli.length==1){
          op = op+"<input type='text' id='rating"+key+"' size='12' class='textbox' style='width:75%'>"  
        }else{
            var sec="";
             sec = sec+"<option value='' selected>Select Rating</option>"
        for (var k = 0; k < opli.length; k++) {
            var ril=opli[k].split("@@");
             sec = sec+"<option value='"+ril[0]+"'>"+ril[1]+"</option>"
        }
        op =op+"<select id='rating"+key+"' class='combo' style='width:80%'>"+sec+"</select>"
        }
    }
    return op;
}

function deleteMasterRecord(budgetID)
{
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "FeedbackOfConferenceServlet";
        jData.handller = "Delete";
        jData.budgetID = budgetID;
        $(document).getServace(jData);
    }
    else {
    }
}

function getQuestionGridData(confID)
{
    jData = {};
    jData.service = "FeedbackOfConferenceServlet";
    jData.handller = "upgradeForQuestions";
    jData.conferenceID = confID;
    $(document).getServace(jData);
}

function displayGridData()
{
   if (jQuery.trim($('#actualConferenceName').val()) == "") {
        alert("Please Enter the Conference Name.");
        $('#actualConferenceName').focus();
        return false;
    } 
    
    if (jQuery.trim($('#actualBudget').val()) == "") {
        alert("Please Enter the Actual Budget.");
        $('#actualBudget').focus();
        return false;
    } 
    
    getGridDataForRecExp();
}

function getGridDataForRecExp()
{
    var recexprow={};
     $("#recExpGrid").yattable({
        width: "100%",
        height: 100,
        scrolling: "yes"
    });
    var table = "";
     $("#recExpHead").html("");
     $("#recExpHead").html("<th style='width: 5%'>Sl No.</th><th style='width: 19%'>RecExp Code</th><th style='width: 19%'>RecExp Name</th><th style='width: 19%'>RecExp No.</th><th style='width: 19%'>RecExp Value</th><th style='width: 19%'>RecExp Amount</th>");
    //-----------------------------------------
   for(var s in tempgrid){
      if(tempgrid[s]["recexpcode"]==$("#expenditureCode").val()){
          gridcount.uerow=s;
      } 
      if(tempgrid[s]["recexpcode"]==$("#receiptCode").val()){
          gridcount.urrow=s;
      } 
   }
   if(gridcount.uerow!=""){
       
     tempgrid[gridcount.uerow]["recexpcode"]=$("#expenditureCode").val();
     tempgrid[gridcount.uerow]["recexpname"]=$("#expenditureName").val();
     tempgrid[gridcount.uerow]["recexptype"]=$("#expenditureType").val();
     tempgrid[gridcount.uerow]["recexpno"]=$("#expenditureNo").val();
     tempgrid[gridcount.uerow]["recexpvalue"]=$("#expenditureValue").val();
     tempgrid[gridcount.uerow]["recexpamount"]=$("#expenditureAmount").val();
     gridcount.uerow="";
   }else{
    if($("#expenditureCode").val()!="" && $("#expenditureNo").val()!="" && $("#expenditureValue").val()!="" && $("#expenditureAmount").val()!=""){
    recexprow.recexpcode=$("#expenditureCode").val();
    recexprow.recexpname=$("#expenditureName").val();
    recexprow.recexptype=$("#expenditureType").val();
    recexprow.recexpno=$("#expenditureNo").val();
    recexprow.recexpvalue=$("#expenditureValue").val();
    recexprow.recexpamount=$("#expenditureAmount").val();
    tempgrid[gridcount.c]=recexprow;
    gridcount.c=gridcount.c+1;
   }
   }
    recexprow={};
    ///-------------------------------------------
    if(gridcount.urrow!=""){
        tempgrid[gridcount.urrow]["recexpcode"] = $("#receiptCode").val();
        tempgrid[gridcount.urrow]["recexpname"] = $("#receiptName").val();
        tempgrid[gridcount.urrow]["recexptype"] = $("#receiptType").val();
        tempgrid[gridcount.urrow]["recexpno"] = $("#receiptNo").val();
        tempgrid[gridcount.urrow]["recexpvalue"] = $("#receiptValue").val();
        tempgrid[gridcount.urrow]["recexpamount"] = $("#receiptAmount").val();
        gridcount.urrow=""
    }else{
        if($("#receiptCode").val()!="" && $("#receiptNo").val()!="" && $("#receiptValue").val()!="" && $("#receiptAmount").val()!=""){
        recexprow.recexpcode = $("#receiptCode").val();
        recexprow.recexpname = $("#receiptName").val();
        recexprow.recexptype = $("#receiptType").val();
        recexprow.recexpno = $("#receiptNo").val();
        recexprow.recexpvalue = $("#receiptValue").val();
        recexprow.recexpamount = $("#receiptAmount").val();
        tempgrid[gridcount.c] = recexprow;
        gridcount.c = gridcount.c + 1;
        }
    }
    for(var key in tempgrid){
     table = table + "<tr><td  style='width: 5%'>"+(eval(key)+1)+"</td><td  style='width: 19%'>"+tempgrid[key]["recexpcode"]+"</td><td  style='width: 19%'>"+tempgrid[key]["recexpname"]+"</td><td  style='width: 19%'>"+tempgrid[key]["recexpno"]+"</td><td  style='width: 19%'>"+tempgrid[key]["recexpvalue"]+"</td><td  style='width: 19%'>"+tempgrid[key]["recexpamount"]+"</td>";
    }
    getReset();
    
    $("#recExpGridBody").html("");
    $("#recExpGridBody").html("" + table);
    $("#recExpGrid1").css("width", $("#recExpGrid").width());
}

function getReset()
{
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
}