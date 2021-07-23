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
        case 'selectEqptSoftData':
            var flag = "0";
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#eqptSoftDetailDesc").val(SelectData["equipmentDetailDesc"]);
            $("#dateOfProcurement").val(SelectData["procurementDate"]);
            $("#eqptSoftwareCost").val(SelectData["procurementCost"]);
            SelectData["equipmentID"] = $("#eqptSoftwareName").val();
            if(SelectData["equipmentDetailDesc"]!=undefined)
            {  
             for(var l=0;l<list.length;l++){   
                 if(SelectData["equipmentID"]==list[l]["equipmentID"]){
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
        case 'getEqptSoftNames':
            $("#eqptSoftwareName").empty();
            $("#eqptSoftwareName").append(xhr.responseText);
            getLowerGridData();
            break;
        case 'validateData':
            tempValidateData=xhr.responseText;
            
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
                 if(childData[key]["equipmentID"]==list[l]["equipmentID"]){
                    flag="1"; 
                 }
             }
             if(flag=="0"){
            list.push(childData[key]);
             }
            }
            
            getGridData();
            parentData = SelectDataForUpgrade["parentMap"];
            $("#transactionDate").val(parentData["transactionDate"]);
            $("#departmentName").val(parentData["departmentCode"]);
            $("#academicYear").val(parentData["academicYear"]);
            $("#headerRemarks").val(parentData["headerRemarks"]);
            break;
    }
});

function getCommonMasterTable()
{
    $("#dateOfProcurement").prop("disabled", true);
   
}

function getEqptSoftwareData()
{
    if (jQuery.trim($('#departmentName').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentName').focus();
        $("#eqptSoftwareName").val("");
        return false;
    } 
    if (jQuery.trim($('#academicYear').val()) == 0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        $("#eqptSoftwareName").val("");
        return false;
    } 
    
    
    jData = {};
    jData.service = "EquipmentTransactionServlet";
    jData.handller = "selectEqptSoftData";
    jData.eqptSoftID = $("#eqptSoftwareName").val();
    $(document).getServace(jData);  
    $('#departmentName').attr('disabled', true);
    $('#academicYear').attr('disabled', true);
    $('#headerRemarks').attr('disabled', true);
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
    if (jQuery.trim($('#eqptSoftwareName').val()) == 0) {
        alert("Please Select the Eqpt/Software Name.");
        $('#eqptSoftwareName').focus();
        return false;
    } 
    if (jQuery.trim($('#eqptSoftwareUsage').val()) == 0) {
        alert("Please Select the Eqpt/Software Usage.");
        $('#eqptSoftwareUsage').focus();
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
     $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 12%'>Equipment Code</th><th style='width: 14%'>Equipment Name</th><th style='width: 25%'>Eqpt/Software Detail Desc</th><th style='width: 10%'>Eqpt/Software Cost</th><th style='width: 10%'>Date Of Procurement</th><th style='width: 12%'>Eqpt/Software Usage</th><th style='width: 12%'>Eqpt/Software Remarks</th>");
    
    for (var x = 0; x < list.length; x++) {
            
           if ($("#eqptSoftwareName").val() == list[x]["equipmentID"]) {
            list[x]["eqptSoftwareUsage"] = getSoftwareUsage($("#eqptSoftwareUsage").val());
            list[x]["eqptSoftRemarks"] = $("#eqptSoftRemarks").val();
        } else
        {
            if ((list[x]["equipmentUsage"] != undefined || list[x]["detailRemarks"] != undefined) && $("#eqptSoftwareName").val()==0) {
                list[x]["eqptSoftwareUsage"] = getSoftwareUsage(list[x]["equipmentUsage"]);
                list[x]["eqptSoftRemarks"] = list[x]["detailRemarks"];
            } else
            {
                if(list[x]["eqptSoftwareUsage"]!=undefined){
                list[x]["eqptSoftwareUsage"] = list[x]["eqptSoftwareUsage"];
                list[x]["eqptSoftRemarks"] = list[x]["eqptSoftRemarks"];
                }else
                    {
                 list[x]["eqptSoftwareUsage"] = getSoftwareUsage(list[x]["equipmentUsage"]);
                list[x]["eqptSoftRemarks"] = list[x]["detailRemarks"];       
                    }
            }
        }
        if(list[x]["eqptSoftRemarks"]==null)
            {
                list[x]["eqptSoftRemarks"]="";
            }
     table = table + "<tr><td  style='width: 5%'>"+(x+1)+"</td><td  style='width: 12%'><a href='javascript:void(0)' onClick='getData(\"" + list[x]["equipmentID"] + "\",\"" + list[x]["equipmentDetailDesc"] + "\",\"" + list[x]["eqptSoftwareUsage"] + "\",\"" + list[x]["procurementDate"] + "\",\"" + list[x]["procurementCost"] + "\",\"" + list[x]["eqptSoftRemarks"] + "\")'>" + list[x]["equipmentCode"]+ "</a></td><td  style='width: 14%'>"+list[x]["equipmentName"]+"</td><td  style='width: 25%'>"+list[x]["equipmentDetailDesc"]+"</td><td  style='width: 10%'>"+list[x]["procurementCost"]+"</td><td  style='width: 10%'>"+list[x]["procurementDate"]+"</td><td  style='width: 12%'>"+list[x]["eqptSoftwareUsage"]+"</td><td  style='width: 12%'>"+list[x]["eqptSoftRemarks"]+"</td>";
     
   }
    
    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());
}

function getSoftwareUsage(softwareUsageCode)
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


function getSoftwareUsageCode(softwareUsageCode)
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
    if (jQuery.trim($('#eqptSoftwareName').val()) == 0) {
        alert("Please Select the Eqpt/Software Name.");
        $('#eqptSoftwareName').focus();
        return false;
    } 
    if (jQuery.trim($('#eqptSoftwareUsage').val()) == 0) {
        alert("Please Select the Eqpt/Software Usage.");
        $('#eqptSoftwareUsage').focus();
        return false;
    } 
    
    var dataList=[];
    for(var z=0;z<list.length;z++)
        {
            var detailDataList={};
        detailDataList.companyID=$("#compsession").val();
        detailDataList.instituteID=$("#instsession").val();
        detailDataList.transactionDate=$("#transactionDate").val();
        detailDataList.equipmentID=list[z]["equipmentID"];
        detailDataList.equipmentUsage=list[z]["eqptSoftwareUsage"];
        detailDataList.detailRemarks=list[z]["eqptSoftRemarks"];
        dataList.push(detailDataList);
        }
        
    jData = {};
    jData.transactionID = $("#transactionID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.transactionDate=$("#transactionDate").val();
    jData.academicYear=$("#academicYear").val();
    jData.departmentCode=$("#departmentName").val();
    jData.headerRemarks=$("#headerRemarks").val();
    jData.entryBy = $("#entryBy").val();
   
    
    jData.service = "EquipmentTransactionServlet";
    jData.handller = "saveupdate";
    jData.para = dataList;
    $(document).getServace(jData);
    
}

function resetValues()
{
  $("#departmentName").prop("disabled", false); 
  $("#academicYear").prop("disabled", false);
  $("#headerRemarks").prop("disabled", false);
  $("#transactionID").val("0");
    $("#transactionDate").val("");
    $("#departmentName").val("");
    $("#academicYear").val("");
    $("#headerRemarks").val("");
    $("#eqptSoftwareName").val("");
    $("#eqptSoftDetailDesc").val("");
    $("#eqptSoftwareUsage").val("0");
    $("#dateOfProcurement").val("");
    $("#eqptSoftwareCost").val("");
    $("#eqptSoftRemarks").val("");
    
    location.reload(); 
}

function resetValues1()
{
  $("#departmentName").prop("disabled", false); 
  $("#academicYear").prop("disabled", false);
  $("#headerRemarks").prop("disabled", false);
  $("#transactionID").val("0");
    $("#transactionDate").val("");
    $("#departmentName").val("");
    $("#academicYear").val("");
    $("#headerRemarks").val("");
    $("#eqptSoftwareName").val("");
    $("#eqptSoftDetailDesc").val("");
    $("#eqptSoftwareUsage").val("0");
    $("#dateOfProcurement").val("");
    $("#eqptSoftwareCost").val("");
    $("#eqptSoftRemarks").val("");
    
}

function getLowerGridData()
{
    jData = {};
    jData.service = "EquipmentTransactionServlet";
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
     $("#lowerGridHead").html("<th style='width: 5%'>Sl No.</th><th style='width: 22%'>Transaction ID</th><th style='width: 22%'>Transaction Date</th><th style='width: 24%'>Department Name</th><th style='width: 22%'>Academic Year</th><th style='width: 5%'></th>");
   for(var key in lowerGridData){
     table = table + "<tr><td  style='width: 5%'>"+key+"</td><td  style='width: 22%'>" + lowerGridData[key]["transactionID"]+ "</td><td  style='width: 22%'>"+lowerGridData[key]["transactionDate"]+"</td><td  style='width: 24%'>"+lowerGridData[key]["departmentName"]+"</td><td  style='width: 22%'>"+lowerGridData[key]["academicYear"]+"</td>";
     table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + lowerGridData[key]["transactionID"] + "\")'></td></tr>";    
   }
    
    $("#lowerGridBody").html("");
    $("#lowerGridBody").html("" + table);
    $("#lowerGrid1").css("width", $("#lowerGrid").width());
}

function updateMasterRecord(transactionID)
{
    jData = {};
    jData.service = "EquipmentTransactionServlet";
    jData.handller = "selectForUpgrade";
    jData.transactionID = transactionID;
    $(document).getServace(jData); 
    $("#transactionID").val(transactionID);
    $('#departmentName').attr('disabled', true);
    $('#academicYear').attr('disabled', true);
    $('#headerRemarks').attr('disabled', true);
    list=[];
    resetValue();
}

function getData(equipmentID,eqptSoftDetailDesc,equipmentSoftwareUsage,procurementDate,procurementCost,equipSoftRemarks)
{
    $("#eqptSoftwareName").val(equipmentID);
    $("#eqptSoftDetailDesc").val(eqptSoftDetailDesc);
    $("#eqptSoftwareUsage").val(getSoftwareUsageCode(equipmentSoftwareUsage));
    $("#eqptSoftwareCost").val(procurementCost);
    $("#dateOfProcurement").val(procurementDate);
    $("#eqptSoftRemarks").val(equipSoftRemarks);
//    jData = {};
//    jData.service = "EquipmentTransactionServlet";
//    jData.handller = "setHeaderData";
//    jData.equipmentID = equipmentID;
//    $(document).getServace(jData); 
    $('#departmentName').attr('disabled', true);
    $('#academicYear').attr('disabled', true);
    $('#headerRemarks').attr('disabled', true);

}

function getValidate()
{
    jData = {};
    jData.service = "EquipmentTransactionServlet";
    jData.handller = "validateData";
    jData.departmentName = $("#departmentName").val();
    jData.academicYear = $("#academicYear").val();
    jData.eqptSoftwareName = $("#eqptSoftwareName").val();
    $(document).getServace(jData);   
}

function resetValue()
{
    $("#eqptSoftwareName").val("");
    $("#eqptSoftDetailDesc").val("");
    $("#eqptSoftwareUsage").val("0");
    $("#dateOfProcurement").val("");
    $("#eqptSoftwareCost").val("");
    $("#eqptSoftRemarks").val("");
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

function getEqptSoftNames()
{
    jData = {};
    jData.service = "EquipmentTransactionServlet";
    jData.handller = "getEqptSoftNames";
    jData.departmentName = $("#departmentName").val();
    $(document).getServace(jData);     
}