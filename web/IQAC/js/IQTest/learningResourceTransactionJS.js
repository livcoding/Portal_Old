/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var rc = 0;
var SelectData = {};
var lowerGridData = {};
var list=[];
 var SelectDataForUpgrade = {};
 var parentData={};
 var childData = {};
  var tempValidateData="";
 var boolFlag="false";
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
        case 'selectLearningResourceData':
            var flag = "0";
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#learningResourceDate").val(SelectData["learnResourceDate"]);
            $("#learningResourceAmount").val(SelectData["learnResourceAmount"]);
            SelectData["learnResourceID"] = $("#learningResourceName").val();
            if(SelectData["learnResourceName"]!=undefined)
            {  
             for(var l=0;l<list.length;l++){   
                 if(SelectData["learnResourceID"]==list[l]["learnResourceID"]){
                    flag="1"; 
                 }
             }
             
             if(flag=="0")
             list.push(SelectData);
            }
            getValidate();
            break;
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
        case 'selectLowerGridData':
            lowerGridData = jQuery.parseJSON(xhr.responseText);
            getSelectLowerGridData();
            break;
        case 'validateData':
            tempValidateData = xhr.responseText;

            break;
        case 'setHeaderData':
            var headerData = jQuery.parseJSON(xhr.responseText);
            $("#eqptSoftwareName").val(headerData["equipmentID"]);
            $("#eqptSoftDetailDesc").val(headerData["equipmentDetailDesc"]);
            $("#eqptSoftwareUsage").val(headerData["equipmentUsage"]);
            $("#dateOfProcurement").val(headerData["procurementDate"]);
            $("#eqptSoftwareCost").val(headerData["procurementCost"]);
            $("#eqptSoftRemarks").val(headerData["detailRemarks"]);
            break;
        case 'selectForUpgrade':
            boolFlag="true";
            var flag="0";
            SelectDataForUpgrade = jQuery.parseJSON(xhr.responseText);
            childData=SelectDataForUpgrade["childMap"];
            for(var key in childData){
            for(var l=0;l<list.length;l++){   
                 if(childData[key]["learnResourceID"]==list[l]["learnResourceID"]){
                    flag="1"; 
                 }
             }
             if(flag=="0")
            list.push(childData[key]);
            }
            
            getGridData();
            parentData = SelectDataForUpgrade["parentMap"];
            $("#transactionDate").val(parentData["transactionDate"]);
            $("#departmentName").val(parentData["departmentCode"]);
            $("#academicYear").val(parentData["academicYear"]);
            $("#facultyName").val(parentData["staffID"]);
            $("#commonRemarks").val(parentData["headerRemarks"]);
            break;
    }
});


function getCommonMasterTable()
{
    
   $("#learningResourceDate").prop("disabled", true); 
}

function getLearningResourceData()
{
    if (jQuery.trim($('#departmentName').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentName').focus();
        $("#learningResourceName").val("");
        return false;
    } 
    if (jQuery.trim($('#academicYear').val()) == 0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        $("#learningResourceName").val("");
        return false;
    }
    if (jQuery.trim($('#facultyName').val()) == 0) {
        alert("Please Select the Faculty Name.");
        $('#facultyName').focus();
        $("#learningResourceName").val("");
        return false;
    }
    
    jData = {};
    jData.service = "LearningResourceTransactionServlet";
    jData.handller = "selectLearningResourceData";
    jData.learnResourceID = $("#learningResourceName").val();
    $(document).getServace(jData);  
    $('#departmentName').attr('disabled', true);
    $('#academicYear').attr('disabled', true);
    $('#facultyName').attr('disabled', true);
    $('#commonRemarks').attr('disabled', true);
}

function displayGridData()
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
    if (jQuery.trim($('#academicYear').val()) == 0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        return false;
    } 
    if (jQuery.trim($('#facultyName').val()) == 0) {
        alert("Please Select the Faculty Name.");
        $('#facultyName').focus();
        return false;
    } 
    if (jQuery.trim($('#learningResourceName').val()) == 0) {
        alert("Please Select the Learning Resource Name.");
        $('#learningResourceName').focus();
        return false;
    } 
    if (jQuery.trim($('#learningResourceUsage').val()) == 0) {
        alert("Please Select the Learning Resource Usage.");
        $('#learningResourceUsage').focus();
        return false;
    } 
    
    if(tempValidateData=="true" && $("#transactionID").val()==0)
        {
            alert("Record already exist, Please choose update");
            resetValues1();
            return false;
            
        }
    getGridData();
}

function getGridData()
{
     $("#mastergrid").yattable({
        width: "100%",
        height: 200,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
     $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 15%'>Learning Resource Code</th><th style='width: 20%'>Learning Resource Name</th><th style='width: 15%'>Learning Resource Amount</th><th style='width: 15%'>Learning Resource Date</th><th style='width: 15%'>Learning Resource Usage</th><th style='width: 15%'>Remarks</th>");
    
    for (var x = 0; x < list.length; x++) {

        
        if ($("#learningResourceName").val() == list[x]["learnResourceID"]) {
            
            list[x]["learningResourceUsage"] = getLearnResourceUsage($("#learningResourceUsage").val());
            list[x]["learningResourceRemarks"] = $("#learningResourceRemarks").val();
        } else
        {
            if ((list[x]["learnResourceUsage"] != undefined || list[x]["detailRemarks"] != undefined) && $("#learningResourceName").val()==0) {
                list[x]["learningResourceUsage"] = getLearnResourceUsage(list[x]["learnResourceUsage"]);
                list[x]["learningResourceRemarks"] = list[x]["detailRemarks"];
            } else
            {
                if(list[x]["learningResourceUsage"]!=undefined){
                list[x]["learningResourceUsage"] = list[x]["learningResourceUsage"];
                list[x]["learningResourceRemarks"] = list[x]["learningResourceRemarks"];
                }else
                    {
                list[x]["learningResourceUsage"] = getLearnResourceUsage(list[x]["learnResourceUsage"]);
                list[x]["learningResourceRemarks"] = list[x]["detailRemarks"];        
                    }
            }
        }
        if(list[x]["learningResourceRemarks"]==null)
            {
                list[x]["learningResourceRemarks"]="";
            }
     table = table + "<tr><td  style='width: 5%'>"+(x+1)+"</td><td  style='width: 15%'><a href='javascript:void(0)' onClick='getData(\"" + list[x]["learnResourceID"] + "\",\"" + list[x]["detailRemarks"] + "\",\"" + list[x]["learnResourceUsage"] + "\",\"" + list[x]["learnResourceDate"] + "\",\"" + list[x]["learnResourceAmount"] + "\")'>" + list[x]["learnResourceCode"]+ "</a></td><td  style='width: 20%'>"+list[x]["learnResourceName"]+"</td><td  style='width: 15%'>"+list[x]["learnResourceAmount"]+"</td><td  style='width: 15%'>"+list[x]["learnResourceDate"]+"</td><td  style='width: 15%'>"+list[x]["learningResourceUsage"]+"</td><td  style='width: 15%'>"+list[x]["learningResourceRemarks"]+"</td>";
     
   }
    
    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());
}


function getLearnResourceUsage(softwareUsageCode)
{
    var tempString = "";
    if (softwareUsageCode == "H")
    {
        tempString = "High";
    } else if (softwareUsageCode == "M")
    {
        tempString = "Medium";
    } else if (softwareUsageCode == "L")
    {
        tempString = "Low";
    } else
    {
        tempString = "Not Used";
    }

    return tempString;
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
    if (jQuery.trim($('#academicYear').val()) == 0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        return false;
    } 
    if (jQuery.trim($('#facultyName').val()) == 0) {
        alert("Please Select the Faculty Name.");
        $('#facultyName').focus();
        return false;
    } 
    if (jQuery.trim($('#learningResourceName').val()) == 0) {
        alert("Please Select the Learning Resource Name.");
        $('#learningResourceName').focus();
        return false;
    } 
    if (jQuery.trim($('#learningResourceUsage').val()) == 0) {
        alert("Please Select the Learning Resource Usage.");
        $('#learningResourceUsage').focus();
        return false;
    } 
    
    var dataList=[];
    for(var z=0;z<list.length;z++)
        {
            var detailDataList={};
        detailDataList.companyID=$("#compsession").val();
        detailDataList.instituteID=$("#instsession").val();
        detailDataList.transactionDate=$("#transactionDate").val();
        detailDataList.learnResourceID=list[z]["learnResourceID"];
        detailDataList.learnResourceUsage=list[z]["learningResourceUsage"];
        detailDataList.detailRemarks=list[z]["learningResourceRemarks"];
        dataList.push(detailDataList);
        }
        
    jData = {};
    jData.transactionID = $("#transactionID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.transactionDate=$("#transactionDate").val();
    jData.academicYear=$("#academicYear").val();
    jData.departmentCode=$("#departmentName").val();
    jData.facultyName=$("#facultyName").val();
    jData.headerRemarks=$("#commonRemarks").val();
    jData.entryBy = $("#entryBy").val();
   
    
    jData.service = "LearningResourceTransactionServlet";
    jData.handller = "saveupdate";
    jData.para = dataList;
    $(document).getServace(jData);
    
}

function resetValues()
{
  $("#departmentName").prop("disabled", false); 
  $("#academicYear").prop("disabled", false);
  $("#facultyName").prop("disabled", false);
  $("#commonRemarks").prop("disabled", false);
  $("#transactionID").val("0");
    $("#transactionDate").val("");
    $("#departmentName").val("");
    $("#academicYear").val("");
    $("#facultyName").val("");
    $("#commonRemarks").val("");
    $("#learningResourceName").val("");
    $("#learningResourceUsage").val("0");
    $("#learningResourceDate").val("");
    $("#learningResourceAmount").val("");
    $("#learningResourceRemarks").val("");
    
    location.reload(); 
}

function resetValues1()
{
  $("#departmentName").prop("disabled", false); 
  $("#academicYear").prop("disabled", false);
  $("#facultyName").prop("disabled", false);
  $("#commonRemarks").prop("disabled", false);
  $("#transactionID").val("0");
    $("#transactionDate").val("");
    $("#departmentName").val("");
    $("#academicYear").val("");
    $("#facultyName").val("");
    $("#commonRemarks").val("");
    $("#learningResourceName").val("");
    $("#learningResourceUsage").val("0");
    $("#learningResourceDate").val("");
    $("#learningResourceAmount").val("");
    $("#learningResourceRemarks").val("");
    
}


function getLowerGridData()
{
    jData = {};
    jData.service = "LearningResourceTransactionServlet";
    jData.handller = "selectLowerGridData";
    jData.departmentCode = $("#departmentName").val();
    jData.academicYear = $("#academicYear").val();
    $(document).getServace(jData); 
}

function getSelectLowerGridData()
{
    $("#lowerGrid").yattable({
        width: "100%",
        height: 300,
        scrolling: "yes"
    });
    var table = "";
   $("#lowerGridHead").html("");
     $("#lowerGridHead").html("<th style='width: 5%'>Sl No.</th><th style='width: 18%'>Transaction ID</th><th style='width: 18%'>Transaction Date</th><th style='width: 18%'>Department Name</th><th style='width: 18%'>Academic Year</th><th style='width: 18%'>Faculty Name</th><th style='width: 5%'></th>");
   for(var key in lowerGridData){
     table = table + "<tr><td  style='width: 5%'>"+key+"</td><td  style='width: 18%'>" + lowerGridData[key]["transactionID"]+ "</td><td  style='width: 18%'>"+lowerGridData[key]["transactionDate"]+"</td><td  style='width: 18%'>"+lowerGridData[key]["departmentName"]+"</td><td  style='width: 18%'>"+lowerGridData[key]["academicYear"]+"</td><td  style='width: 18%'>"+lowerGridData[key]["staffID"]+"</td>";
     table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + lowerGridData[key]["transactionID"] + "\")'></td></tr>";    
   }
    
    $("#lowerGridBody").html("");
    $("#lowerGridBody").html("" + table);
    $("#lowerGrid1").css("width", $("#lowerGrid").width());
}


function updateMasterRecord(transactionID)
{
    jData = {};
    jData.service = "LearningResourceTransactionServlet";
    jData.handller = "selectForUpgrade";
    jData.transactionID = transactionID;
    $(document).getServace(jData); 
    $("#transactionID").val(transactionID);
    $('#departmentName').attr('disabled', true);
    $('#academicYear').attr('disabled', true);
    $('#facultyName').attr('disabled', true);
    $('#commonRemarks').attr('disabled', true);
    list=[];
    resetValue();
}

function getData(learnResourceID,learnResourceRemarks,learnResourceUsage,learnResourceDate,learnResourceAmount)
{
    
    $("#learningResourceName").val(learnResourceID);
    $("#learningResourceRemarks").val(learnResourceRemarks);
    $("#learningResourceUsage").val(learnResourceUsage);
    $("#learningResourceDate").val(learnResourceDate);
    $("#learningResourceAmount").val(learnResourceAmount);
}

function getLearnResourceUsageCode(softwareUsageCode)
{
    var tempString = "";
    if (softwareUsageCode == "High")
    {
        tempString = "H";
    } else if (softwareUsageCode == "Medium")
    {
        tempString = "M";
    } else if (softwareUsageCode == "Low")
    {
        tempString = "L";
    } else
    {
        tempString = "N";
    }

    return tempString;
}

function getValidate()
{
    jData = {};
    jData.service = "LearningResourceTransactionServlet";
    jData.handller = "validateData";
    jData.departmentName = $("#departmentName").val();
    jData.academicYear = $("#academicYear").val();
    jData.learningResourceName = $("#learningResourceName").val();
    $(document).getServace(jData);   
}

function resetValue()
{
    $("#learningResourceName").val("");
    $("#learningResourceUsage").val("0");
    $("#learningResourceDate").val("");
    $("#learningResourceAmount").val("");
    $("#learningResourceRemarks").val("");
}

function getValidateDate()
{
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
    var currentDate = "";
    if (dd < 10) {
        dd = "0" + dd
    }
    if (mm < 10) {
        currentDate = dd + "-" + "0" + mm + "-" + yyyy;
    } else
    {
        currentDate = dd + "-" + mm + "-" + yyyy;
    }
    var transactionDate = $.datepicker.parseDate('dd-mm-yy', $('#transactionDate').val());
    var currDate = $.datepicker.parseDate('dd-mm-yy', currentDate);
    if (transactionDate > currDate) {
        alert('Transaction Date must be smaller or equal to Current Date');
        $('#transactionDate').val("");
        return false;
    }
}