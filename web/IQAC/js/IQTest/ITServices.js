/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

// Changes Date 16.10.2017


var rc = 0;
var selectPersonsInfo = {};
var gridData = {};
var currRowNo=0;
var cupage = {};
var parentQuestion="";
var lowerGridData = {};
var gridLength="";
var tempValue="";
var flag2="";
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
            data : 'jdata='+JSON.stringify(para).replace(/&/g,"@@@").replace(/%/g,""),
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
        case 'departmentNameCombo':
            $("#dName").html();
            $("#dName").html("<select  name='departmentName' id='departmentName'  class='combo' style=''  title='Department Name'>" + xhr.responseText + "</select>");
            break;
        case 'validateData':
            flag2 = xhr.responseText;
            break;
        case 'onload':
            var d = new Date();
            var month = d.getMonth() + 1;
            var day = d.getDate();
            var output = (day < 10 ? '0' : '') + day + '-' + (month < 10 ? '0' : '') + month + '-' + d.getFullYear();
            $("#transactionDate").val(output);
            getQuestions();
            break;
        case 'headID':
            parentQuestion=xhr.responseText;
            break;
        case 'saveupdate':
            
             if(xhr.responseText!="")
                {
                    alert("Record Saved Successfully");
                }
            else {
                 alert("Record Not Saved ");
            }

            resetValues();
            location.reload();
            break;

             case 'finalsave':

             if(xhr.responseText!="")
                {
                    alert("Record Finally Save Successfully");
                }
            else {
                 alert("Record Not Saved ");
            }

            resetValues();
            location.reload();
            break;
        case 'selectGridData':
            gridData = jQuery.parseJSON(xhr.responseText);
            $('#finalSaveForm').prop('disabled',false);
            $('#DraftSaveForm').prop('disabled',false);
            $("#headerremarks").val(gridData["headerremarks"]);
            getGridData(gridData);
            break;

    }
});


function getQuestions()
{
     
    jData = {};
    jData.service = "ITServicesServlet";
    jData.handller = "selectGridData";
    jData.EventCode = $("#EventCode").val();
    jData.institute = $("#instsession").val();
    $(document).getServace(jData);
}

function getGridData()
{

     //$("#headerremarks").val(gridData["headerremarks"]);
  //  alert(gridData["headerremarks"]);
     $("#mastergrid").yattable({
        width: "100%",
        height: 300,
        scrolling: "yes"
    });
     //alert("outside for"+JSON.stringify(gridData[1]["slno"]));
    var table = "";
   $("#gridhead").html("");
     $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 33%'>Questions</th><th style='width: 31%'>Rating</th><th style='width: 31%'>Remarks</th>");
   
    for (var key in gridData) {

   if(gridData[key]["docMode"]=='F'){
       if(gridData[key]["slno"]!=undefined){
        if(gridData[key]["flag"]=='Y'){

        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["QUESTIONBODY"] + "</td><td  style='width: 31%'></td><td  style='width: 31%'></td>";
        }else{
        if(gridData[key]["MANDATORYQUESTION"]=='Y'){
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["QUESTIONBODY"] + "<span class='req'> *</span></td><td  style='width: 31%'>"+getFRating(gridData["rating"][gridData[key]["RATINGID"]],key,gridData[key]["ratingdes"])+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' value='"+[gridData[key]["remarks"]]+"' style='width:75%' disabled maxlength='100'></td>";
        }else
        {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["QUESTIONBODY"] + "</td><td  style='width: 31%'>"+getFRating(gridData["rating"][gridData[key]["RATINGID"]],key,gridData[key]["ratingdes"])+"</td><td  style='width: 31%'><input type='text' class='textbox' value='"+[gridData[key]["remarks"]]+"' id='remarks"+key+"' style='width:75%' disabled maxlength='100'></td>";
        }
    }
            $('#finalSaveForm').prop('disabled',true);
            $('#DraftSaveForm').prop('disabled',true);
    }
    }// END OF IF.......................
    else  if(gridData[key]["docMode"]=='D'){
       if(gridData[key]["slno"]!=undefined){
        if(gridData[key]["flag"]=='Y'){

        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["QUESTIONBODY"] + "</td><td  style='width: 31%'></td><td  style='width: 31%'></td>";
        }else{
        if(gridData[key]["MANDATORYQUESTION"]=='Y'){
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["QUESTIONBODY"] + "<span class='req'> *</span></td><td  style='width: 31%'>"+getDRating(gridData["rating"][gridData[key]["RATINGID"]],key,gridData[key]["ratingdes"])+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' value='"+[gridData[key]["remarks"]]+"' style='width:75%' maxlength='100'></td>";
        }else
        {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["QUESTIONBODY"] + "</td><td  style='width: 31%'>"+getDRating(gridData["rating"][gridData[key]["RATINGID"]],key,gridData[key]["ratingdes"])+"</td><td  style='width: 31%'><input type='text' class='textbox' value='"+[gridData[key]["remarks"]]+"' id='remarks"+key+"' style='width:75%' maxlength='100'></td>";
        }
    }
    }
    }else {// END OF ELSE IF.......................
        if(gridData[key]["slno"]!=undefined){
        if(gridData[key]["flag"]=='Y'){

        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["QUESTIONBODY"] + "</td><td  style='width: 31%'></td><td  style='width: 31%'></td>";
        }else{
        if(gridData[key]["MANDATORYQUESTION"]=='Y'){
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["QUESTIONBODY"] + "<span class='req'> *</span></td><td  style='width: 31%'>"+getRating(gridData["rating"][gridData[key]["RATINGID"]],key)+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' style='width:75%' maxlength='100'></td>";
        }else
        {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["QUESTIONBODY"] + "</td><td  style='width: 31%'>"+getRating(gridData["rating"][gridData[key]["RATINGID"]],key)+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' style='width:75%' maxlength='100'></td>";
        }
    }
    }// END OF IF.......................
    }
    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());
}//END OF FOR ............
}
function getRating(li,key) {

    var op="";
    if (li != undefined) {
        var opli = jQuery.parseJSON(li);
 //alert("Value"+opli);
 //alert("Length"+opli.length);

        if(opli=='blank'){
       // alert("Zero Length"+opli.length);
        }else  if(opli.length==1){
          op = op+"<input type='text' id='rating"+key+"' size='12' class='textbox' style='width:75%'>"+"<input type='hidden' id='subjective"+key+"' value='y'>"
          
         
        }else{
            var sec="";
             sec = sec+"<option value='' selected>Select Rating</option>"
        for (var k = 0; k < opli.length; k++) {
            var ril=opli[k].split("@@");
             sec = sec+"<option value='"+ril[0]+"'>"+ril[1]+"</option>"
              $("#subjective"+key).val("n")

        }
        op =op+"<select id='rating"+key+"' class='combo' style='width:80%'>"+sec+"</select>"+"<input type='hidden' id='subjective"+key+"' value='n'>"
        }
    }
    return op;
}
// Set Rating Description for Draft mode

function getDRating(li,key,Desc) {

    var op="";
    if (li != undefined) {
        var opli = jQuery.parseJSON(li);
 //alert("Value"+opli);
 //alert("Length"+opli.length);

        if(opli=='blank'){
       // alert("Zero Length"+opli.length);
        }else  if(opli.length==1 && Desc=='<--Select-->'){
          op = op+"<input type='text' id='rating"+key+"' size='12' class='textbox' style='width:75%'>"+"<input type='hidden' id='subjective"+key+"' value='y'>"


        }else  if(opli.length==1 && Desc!='<--Select-->'){
          op = op+"<input type='text' id='rating"+key+"' value='"+Desc+"'size='12' class='textbox' style='width:75%'>"+"<input type='hidden' id='subjective"+key+"' value='y'>"


        }else{
            var sec="";
            if(Desc=='<--Select-->'){
             sec = sec+"<option value='' selected>Select Rating</option>"
            }else{
             sec = sec+"<option value='"+Desc+"'>"+Desc+"</option>"
            }
        for (var k = 0; k < opli.length; k++) {
            var ril=opli[k].split("@@");
            if(ril[1]!=Desc){
             sec = sec+"<option value='"+ril[0]+"'>"+ril[1]+"</option>"
              $("#subjective"+key).val("n")
              }
        }
        op =op+"<select id='rating"+key+"' class='combo'  style='width:80%'>"+sec+"</select>"+"<input type='hidden' id='subjective"+key+"' value='n'> "
        }
    }
    return op;
}

function getFRating(li,key,Desc) {

    var op="";
    if (li != undefined) {
        var opli = jQuery.parseJSON(li);
 //alert("Value"+opli);
 //alert("Length"+opli.length);

        if(opli=='blank'){
       // alert("Zero Length"+opli.length);
        }else  if(opli.length==1 && Desc=='<--Select-->'){
          op = op+"<input type='text' id='rating"+key+"' disabled size='12' class='textbox' style='width:75%'>"+"<input type='hidden' id='subjective"+key+"' value='y'>"


        }else  if(opli.length==1 && Desc!='<--Select-->'){
          op = op+"<input type='text' id='rating"+key+"' disabled value='"+Desc+"'size='12' class='textbox' style='width:75%'>"+"<input type='hidden' id='subjective"+key+"' value='y'>"


        }else{
            var sec="";
            if(Desc=='<--Select-->'){
             sec = sec+"<option value='' selected>Select Rating</option>"
            }else{
             sec = sec+"<option value='"+Desc+"'>"+Desc+"</option>"
            }
        for (var k = 0; k < opli.length; k++) {
            var ril=opli[k].split("@@");
            if(ril[1]!=Desc){
             sec = sec+"<option value='"+ril[0]+"'>"+ril[1]+"</option>"
              $("#subjective"+key).val("n")
              }
        }
        op =op+"<select id='rating"+key+"' class='combo' disabled style='width:80%'>"+sec+"</select>"+"<input type='hidden' id='subjective"+key+"' value='n'> "
        }
    }
    return op;
}




function formsubmit()
{
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

    if (jQuery.trim($('#EventCode').val()) == 0) {
        alert("Please Select the Event Code.");
        $('#EventCode').focus();
        return false;
    }


    var count="0";
    for (var key in gridData)
    {
        if (jQuery.trim($('#rating' + key).val()) != '' || jQuery.trim($('#remarks'+key).val()) != '')
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
         if (jQuery.trim($('#rating'+key).val()) == '' && jQuery.trim($('#remarks'+key).val()) == '' && gridData[key]["MANDATORYQUESTION"]=='Y') {
        alert("Please Enter the Feedback of all mandatory questions.");
        $('#rating'+key).focus();
        return false;
    }
        }
        }
    var questionsDataList=[];
    for (var key in gridData) {
       var questionsData={};
        if(($('#rating'+key).val()!='' || $('#remarks'+key).val()!='' )&& $('#rating'+key).val()!=undefined)
     {
         //alert(($('#rating'+key).val()));
        questionsData.questionID=gridData[key]["QUESTIONID"];
        questionsData.questions=gridData[key]["QUESTIONBODY"];
        questionsData.ratingid=gridData[key]["RATINGID"];
        questionsData.entryBy = $("#entryBy").val();
        questionsData.rating=$("#rating"+key).val();

         if($("#subjective"+key).val()=='y'){
              questionsData.issubjective='y';
         }else{
              questionsData.issubjective='n';
         }
        questionsData.Remarks=$("#remarks"+key).val();
        questionsDataList.push(questionsData);
      }

    }
    jData = {};
    if($('#rating1').val()!=undefined){
    jData.transactionID = $("#transactionID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.transactionDate=$("#transactionDate").val();
    jData.EventCode=$("#EventCode").val();
    jData.programName="B.T";
    jData.headerremarks=$("#headerremarks").val();
    
    jData.entryBy = $("#entryBy").val();
    }
    jData.service = "ITServicesServlet";
    jData.handller = "saveupdate";
     jData.para = questionsDataList;
    
    $(document).getServace(jData);
}

//---------------------------------------Final Save Form--------------------------------------------------------

function finalsubmit()
{
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

    if (jQuery.trim($('#EventCode').val()) == 0) {
        alert("Please Select the Event Code.");
        $('#EventCode').focus();
        return false;
    }
    var count="0";
    for (var key in gridData)
    {
        if (jQuery.trim($('#rating' + key).val()) != '' || jQuery.trim($('#remarks'+key).val()) != '')
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
         if (jQuery.trim($('#rating'+key).val()) == '' && jQuery.trim($('#remarks'+key).val()) == '' && gridData[key]["MANDATORYQUESTION"]=='Y') {
        alert("Please Enter the Feedback of all mandatory questions.");
        $('#rating'+key).focus();
        return false;
    }
        }
        }
    var questionsDataList=[];
    for (var key in gridData) {
       var questionsData={};
        if(($('#rating'+key).val()!='' || $('#remarks'+key).val()!='' )&& $('#rating'+key).val()!=undefined)
     {
        questionsData.questionID=gridData[key]["QUESTIONID"];
        questionsData.questions=gridData[key]["QUESTIONBODY"];
        questionsData.ratingid=gridData[key]["RATINGID"];
        questionsData.entryBy = $("#entryBy").val();
        questionsData.rating=$("#rating"+key).val();

         if($("#subjective"+key).val()=='y'){
              questionsData.issubjective='y';
         }else{
              questionsData.issubjective='n';
         }
        questionsData.Remarks=$("#remarks"+key).val();
        questionsDataList.push(questionsData);
      }

    }
    jData = {};
    if($('#rating1').val()!=undefined){
    jData.transactionID = $("#transactionID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.transactionDate=$("#transactionDate").val();
    jData.EventCode=$("#EventCode").val();
    jData.programName="B.T";
    jData.remarks=$("#remarks").val();
    jData.entryBy = $("#entryBy").val();
    }
    jData.service = "ITServicesServlet";
    jData.handller = "finalsave";
     jData.para = questionsDataList;

    $(document).getServace(jData);
}





















function getTransactionID()
{

    jData = {};
    jData.service = "ITServicesDB";
    jData.handller = "selectData";
    jData.feedbackid = $("#feedbackID").val();
    $(document).getServace(jData);
}


function getDate()
{
    
            var d = new Date();
            var month = d.getMonth() + 1;
            var day = d.getDate();
            var output = (day < 10 ? '0' : '') + day + '-' + (month < 10 ? '0' : '') + month + '-' + d.getFullYear();
            $("#transactionDate").val(output);
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
     $("#gridLower").html("<th style='width: 23%'>Feedback ID</th><th style='width: 26%'>Department</th><th style='width: 23%'>Academic Year</th><th style='width: 23%'>Remarks</th><th style='width: 5%'></th>");
    for (var key in lowerGridData) {
        var rMarks=lowerGridData[key]["remarks"];
        if(rMarks==null)
            {
             rMarks="";
            }
        table = table + "<tr><td  style='width: 23%'>" + lowerGridData[key]["feedbackid"] + "</td><td  style='width: 26%'>" + lowerGridData[key]["department"] + "</td><td  style='width: 23%'>"+lowerGridData[key]["academicyear"]+"</td><td  style='width: 23%'>"+rMarks+"</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + lowerGridData[key]["transactionID"] + "\")'></td></tr>";
    }
    $("#gridLowerBody").html("");
    $("#gridLowerBody").html("" + table);
    $("#lowerGrid1").css("width", $("#lowerGrid").width());

}

function updateMasterRecord(transactionID)
{
    jData = {};
    jData.service = "ITServicesDB";
    jData.handller = "selectDataForUpgrade";
    jData.transactionID = transactionID;
    $(document).getServace(jData);
}

function resetValues()
{
   location.reload();
    $("#EventCode").val("");
    $("#remarks").val("");
    for(var x=1;x<=gridLength;x++)
        {
        $("#rating"+x).val("");
        $("#remarks"+x).val("");
        }
}


function getDepartmentCombo()
{

    jData = {};
    jData.service = "DepartmentComboServlet";
    jData.handller = "departmentNameCombo";
    jData.comboId = "departmentComboShortNameisNull";
    if($("#dNameValue").val()!=undefined && $("#dNameValue").val()!=null){
    jData.selectedValue =$("#dNameValue").val();
    }else
        {
        jData.selectedValue="";
        }
    $(document).getServace(jData);
}


