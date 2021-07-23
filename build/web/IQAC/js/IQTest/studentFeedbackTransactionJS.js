/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var rc = 0;
var selectPersonsInfo = {};
var gridData = {};
var currRowNo=0;
var cupage = {};
var parentQuestion="";
var lowerGridData = {};
var selectStudentName={};
var gridLength="";
var flag2="";
var tempValue="";
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
        case 'selectDataForUpgrade':
            getGridData();
             var SelectData = {};
            var childData = {};
            var i = 1;
            SelectData = jQuery.parseJSON(xhr.responseText);
            
            if(SelectData["transactionID"]==undefined)
                {
                   $("#transactionID").val("0");   
                }else{
                  $("#transactionID").val(SelectData["transactionID"]);  
                }
              
            $("#studentName").val(SelectData["studentName"]);
            $("#transactionDate").val(SelectData["transactiondate"]);
            $("#academicYear").val(SelectData["academicYear"]);
             $("#programName").val(SelectData["programcode"]);
            $("#remarks").val(SelectData["feedbackRemarks"]);
           
            childData = SelectData["childMap"];
            for (var key1 in childData) {
                for (var key in gridData) {
                    //$("#rating" + key).val("");
                    if (gridData[key]["questionid"] == childData[key1]["questionID"]) {
                        
                        $("#rating" + key).val(childData[key1]["rating"]);
                        if (childData[key1]["rating"] == null) {
                            $("#rating" + key).val(childData[key1]["userRemarks"]);
                        }
                        $("#remarks" + key).val(childData[key1]["questionRemarks"]);
                        continue;

                    }

                }
            }
            var propertyNames = Object.keys(gridData);
            gridLength=(propertyNames.length-1);
            if (tempValue == "false")
            {
            for(var key in gridData)
                {
                    $('#rating'+key).attr('disabled', true);
                    $('#remarks'+key).attr('disabled', true);
                }
            }
            break;
        case 'lowerGrid':
            lowerGridData = jQuery.parseJSON(xhr.responseText);
            getSelectGridData();
            break;
        case 'checkExpiryDate':
            tempValue = xhr.responseText;
             
            if (tempValue == "false")
            {
                for (var key in gridData)
                {
                    $('#rating' + key).attr('disabled', true);
                    $('#remarks' + key).attr('disabled', true);
                }
            }
            break;
        case 'studentNamesInPopUp':
            selectStudentName = jQuery.parseJSON(xhr.responseText);
            getSelectStudentNameInPopUp(selectStudentName);
            $('#TOTAL').html("Total No.of Record(s): " + selectStudentName[1].totalrecords);
            break;
        case 'feedbackID':
            var d = new Date();
            var month = d.getMonth() + 1;
            var day = d.getDate();
            var output = (day < 10 ? '0' : '') + day + '-' + (month < 10 ? '0' : '') + month + '-' + d.getFullYear();
            $("#transactionDate").val(output);
            $("#feedbackName").val(xhr.responseText);
            var res = xhr.responseText.substring(0, 11); 
            var feedbackID=res;
            $("#feedbackID").val(feedbackID);
            getQuestions(feedbackID);
            break;
        case 'headID':
            parentQuestion=xhr.responseText;
            break;
        case 'saveupdate':
            alert("Record Saved Successfully");
            //resetValues();
            $("#transactionID").val("0");
            location.reload(); 
            break;
        case 'selectGridData':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            getTransactionID();
            getCheckExpiryDate(); 
            break;
        case 'validateData':
            flag2=xhr.responseText;
            break;
        case 'selectData':
            var SelectData = {};
            var childData = {};
            var i = 1;
            SelectData = jQuery.parseJSON(xhr.responseText);
             $("#transactionID").val("0");
            $("#academicYear").val("");
            $("#programName").val("");
            $("#departmentName").val("");
            $("#remarks").val("");
            
            childData = SelectData["childMap"];
            for (var key1 in childData) {
                for (var key in gridData) {
                    if (gridData[key]["questionid"] == childData[key1]["questionID"]) {
                        $("#rating" + key).val("");
                        if (childData[key1]["rating"] == null) {
                            $("#rating" + key).val("");
                        }
                        $("#remarks" + key).val("");
                        continue;

                    }

                }
            }
            var propertyNames = Object.keys(gridData);
            gridLength=(propertyNames.length-1);
                

           if (tempValue == "false")
            {
            for(var key in gridData)
                {
                    $('#rating'+key).attr('disabled', true);
                    $('#remarks'+key).attr('disabled', true);
                }
            }
            break;
    }
});

function getSelectStudentNameInPopUp(){
     var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Student ID</th><th style='width: 48%'>Student Name</th>");
    
     for (var key in selectStudentName) {
         
        table = table + "<tr ondblclick='setNames("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectStudentName[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectStudentName[key]["studentID"] + "</td><td  style='width: 48%;text-align: left'>" + selectStudentName[key]["studentName"] + "</td></tr>";
    }

    $("#studentNamesBody").html("");
    $("#studentNamesBody").html("" + table);
   
 $("#popupHeaderTable").css("width",$("#studentNamesBody").width());
}

function getCommonMasterTable()
{
   $("#paggingPopUp").getPagging();
   $("#studentNamesTable").yattable({
        width: "100%",
        height: 200,
        scrolling: "yes"
    });
    
 if (jQuery.trim($('#academicYear').val()) != "") {
        
    getLowerGrid();
    }

getValidate();
}

function getQuestions(feedbackID)
{
    jData = {};
    jData.service = "StudentFeedbackTransactionServlet";
    jData.handller = "selectGridData";
    jData.feedbackid = feedbackID;
    $(document).getServace(jData);
}

function getGridData()
{
     $("#mastergrid").yattable({
        width: "100%",
        height: 300,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
     $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 33%'>Questions</th><th style='width: 31%'>Rating</th><th style='width: 31%'>Remarks</th>");
     // $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 50%'>Questions</th><th style='width: 45%'>Feedback/Rating</th>");
    for (var key in gridData) {
        if(gridData[key]["slno"]!=undefined){
        if(gridData[key]["flag"]=='Y'){
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["questionbody"] + "</td><td  style='width: 31%'></td><td  style='width: 31%'></td>";   
       // table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 50%'>" + gridData[key]["questionbody"] + "</td><td  style='width: 45%'></td>";   
            }else{
                if(gridData[key]["mandatoryQuestion"]=='Y'){
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["questionbody"] + "<span class='req'> *</span></td><td  style='width: 31%'>"+getRating(gridData["rating"][gridData[key]["ratingid"]],key)+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' style='width:75%' maxlength='100'></td>";
                }else
                    {
          table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["questionbody"] + "</td><td  style='width: 31%'>"+getRating(gridData["rating"][gridData[key]["ratingid"]],key)+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' style='width:75%' maxlength='100'></td>";              
                    }
                    // table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 50%'>" + gridData[key]["questionbody"] + "</td><td  style='width: 45%'>"+getRating(gridData["rating"][gridData[key]["ratingid"]],key)+"</td>";
            }// table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["transactionid"] + "\")'></td></tr>";
    }
    }
    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());
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

function formsubmit()
{
    
    if(tempValue=="false")
        {
            return false;
        }
    if (jQuery.trim($('#transactionDate').val()) == "") {
        alert("Please Enter the Transaction Date.");
        $('#transactionDate').focus();
        return false;
    }
    
    if (jQuery.trim($('#studentName').val()) == "") {
        alert("Please Enter the Student Name.");
        $('#studentName').focus();
        return false;
    }
    if (jQuery.trim($('#programName').val()) == "") {
        alert("Please Enter the Program Name.");
        $('#programName').focus();
        return false;
    }
    if (jQuery.trim($('#academicYear').val()) == "") {
        alert("Please Enter the Academic Year.");
        $('#academicYear').focus();
        return false;
    }
    
    var count="0";
    for (var key in gridData)
    {
        if (jQuery.trim($('#rating' + key).val()) != '')
        {
            count = "1"
        }
    }
    
    if(count=="0")
        {
        alert("Please Enter the Feedback of all mandatory questions."); 
        return false;
        }
    
    
    for(var key in gridData)
        {
        if(gridData[key]["slno"]!=undefined){
         if (jQuery.trim($('#rating'+key).val()) == '' && gridData[key]["mandatoryQuestion"]=='Y') {
        alert("Please Enter the Feedback of all mandatory questions.");
        $('#rating'+key).focus();
        return false;
    }   
        }    
        }
      
     if(flag2=="11" && $("#transactionID").val()==0)
         {
             alert("You have already filled the detail for this academic year ,please choose update.");
             return false;
         }
    var questionsDataList=[];
    for (var key in gridData) {
       var questionsData={};
        if($('#rating'+key).val()!='' && $('#rating'+key).val()!=undefined)
            {
        questionsData.companyid=$("#compsession").val();
        questionsData.instituteid=$("#instsession").val();
        questionsData.transactionDate=$("#transactionDate").val();
        questionsData.feedbackName=$("#feedbackID").val();;
        questionsData.questionID=gridData[key]["questionid"];
        questionsData.questions=gridData[key]["questionbody"];
        questionsData.ratingid=gridData[key]["ratingid"];
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
    if($('#rating1').val()!=undefined){
    jData.transactionID = $("#transactionID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.transactionDate=$("#transactionDate").val();
    jData.feedbackName=$("#feedbackID").val();
    jData.studentID=$("#studentID").val();
    jData.academicYear=$("#academicYear").val();
    jData.programName=$("#programName").val();
    jData.departmentName=$("#departmentName").val();
    jData.remarks=$("#remarks").val();
    jData.entryBy = $("#studentID").val();
    }
   
    jData.service = "StudentFeedbackTransactionServlet";
    jData.handller = "saveupdate";
     jData.para = questionsDataList;
    $(document).getServace(jData);
}

function getTransactionID()
{
    
    jData = {};
    jData.service = "StudentFeedbackTransactionServlet";
    jData.handller = "selectData";
    jData.feedbackid = $("#feedbackID").val();
    $(document).getServace(jData);
}


function getFeedBackID()
{
    jData = {};
    jData.service = "StudentFeedbackTransactionServlet";
    jData.handller = "feedbackID";
    $(document).getServace(jData);  
}

function getLowerGrid()
{
    jData = {};
    jData.service = "StudentFeedbackTransactionServlet";
    jData.academicYear = $("#academicYear").val();
    jData.studentID = $("#studentID").val();
    jData.handller = "lowerGrid";
    $(document).getServace(jData);  
}

function getSelectGridData()
{
  $("#lowerGrid").yattable({
        width: "100%",
        height: 200,
        scrolling: "yes"
    });
    var table = "";
   $("#gridLower").html("");
     // $("#gridLower").html("<th style='width: 19%'>Feedback ID</th><th style='width: 19%'>Program Name</th><th style='width: 19%'>Department</th><th style='width: 19%'>Academic Year</th><th style='width: 19%'>Remarks</th><th style='width: 5%'></th>");
     $("#gridLower").html("<th style='width: 33%'>Feedback ID</th><th style='width: 31%'>Program Name</th><th style='width: 31%'>Academic Year</th><th style='width: 5%'></th>");
    for (var key in lowerGridData) {
        table = table + "<tr><td  style='width: 33%'>" + lowerGridData[key]["feedbackid"] + "</td><td  style='width: 31%'>" + lowerGridData[key]["programcode"] + "</td><td  style='width: 31%'>"+lowerGridData[key]["academicyear"]+"</td>";   
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + lowerGridData[key]["transactionID"] + "\")'></td></tr>";
    }
    $("#gridLowerBody").html("");
    $("#gridLowerBody").html("" + table);
    $("#lowerGrid1").css("width", $("#lowerGrid").width());  
    
}

function updateMasterRecord(transactionID)
{
    jData = {};
    jData.service = "StudentFeedbackTransactionServlet";
    jData.handller = "selectDataForUpgrade";
    jData.transactionID = transactionID;
    $(document).getServace(jData);
}

function resetValues()
{
    $("#transactionID").val("0");
    $("#programName").val("");
    $("#studentName").val("");
    $("#academicYear").val("");
    $("#remarks").val("");
    for(var x=1;x<=gridLength;x++)
        {
        $("#rating"+x).val("");
        $("#remarks"+x).val("");    
        }
}



//$(function() {
//$( "#studentNames" ).dialog({
//autoOpen: false,
//show: {
//effect: "blind",
//duration: 1000
//},
//hide: {
//effect: "explode",
//duration: 1000
//}
//});
//$( "#studentName" ).click(function() {
//$( "#studentNames" ).dialog( "open" );
//getStudentNames("0");
//});
//});

function getStudentNames(pno)
{
     jData = {};
     
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectPersonsInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    
    jData.spg = pno;
    jData.service = "StudentFeedbackTransactionServlet";
    jData.searchNames = $("#searchNames").val();
    jData.handller = "studentNamesInPopUp";
    $(document).getServace(jData);  

}

function setNames(key)
{
    $("#studentName").val(selectStudentName[key]["studentName"]);
    $("#programName").val(selectStudentName[key]["programCode"]);
    $("#academicYear").val(selectStudentName[key]["academicYear"]);
    $("#studentID").val(selectStudentName[key]["studentID"]);
    $("#studentNames").dialog("close");
    if (jQuery.trim($('#academicYear').val()) != "") {
        
    getLowerGrid();
    }

}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getStudentNames("0");  
    }
});


function getValidate()
{
    jData = {};
    jData.service = "StudentFeedbackTransactionServlet";
    jData.handller = "validateData";
    jData.studentID = $("#studentID").val();
    jData.programName = $("#programName").val();
    jData.academicYear = $("#academicYear").val();
    $(document).getServace(jData);  
}

function getCheckExpiryDate()
{
    var d = new Date();
    var month = d.getMonth() + 1;
    var day = d.getDate();
    var output = (day < 10 ? '0' : '') + day + '-' + (month < 10 ? '0' : '') + month + '-' + d.getFullYear();
    jData = {};
    jData.service = "StudentFeedbackTransactionServlet";
    jData.handller = "checkExpiryDate";
    jData.todayDate = output;
    $(document).getServace(jData);
}

