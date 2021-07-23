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

        case 'setDuration':
            $("#durationOfProject").val(xhr.responseText);
            if($("#projectEndDate").val()!=""){
            getValidateDate();
            }
            getCheckProjectStatusOnDate();
            break;
        case 'saveupdate':
            if(xhr.responseText!="")
                {
                    alert("Record Saved Successfully");
                }
            resetValues();
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            if (gridData["0"] != 0) {
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
             }
            break;
        case 'SelectforUpdate':
            var selectData = jQuery.parseJSON(xhr.responseText);
            $("#projectID").val(selectData["projectID"]);
            $("#projectCode").val(selectData["projectCode"]);
            $("#projectTitle").val(selectData["projectTitle"]);
            $("#projectGrandAmount").val(selectData["projectGrandAmount"]);
            $("#projectAuthority").val(selectData["projectAuthority"]);
            $("#sponsoredAuthority").val(selectData["sponsoredAuthority"]);
            $("#departmentName").val(selectData["departmentName"]);
            $("#projectType").val(selectData["projectType"]);
            $("#projectPerStatus").val(selectData["projectPerStatus"]);  
            $("#projectStatus").val(selectData["projectStatus"]);
            $("#projectStatusAsOnDate").val(selectData["projectStatusOnDate"]);
            $("#projectStartDate").val(selectData["projectStartDate"]);
            $("#projectEndDate").val(selectData["projectEndDate"]);
            $("#projectRemarks").val(selectData["projectRemarks"]);
            $("#projectAPIScore").val(selectData["projectAPIScore"]);
            $("#CollaborativeInstitute").val(selectDate["CollaborativeInstitute"]);
           
            if (selectData["active"] == 'N')
            {
                $("#activeN").prop("checked", true);
            } else
            {
                $("#activeY").prop("checked", true);
            }
            getDuration();
            getProjectStatus();
            break;
    }
});


function getCommonMasterTable()
{
    $("#activeY").prop("checked", true);
    $(".number").numeric();
    $("#projectStatus").prop("disabled", true); 
    $("#durationOfProject").prop("disabled", true);
    $("#pagging").getPagging();
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
    
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
   
    if(dd<10){
        dd="0"+dd
    } 
    if (mm < 10) {
        $("#projectStatusAsOnDate").val(dd + "-" +"0"+ mm + "-" + yyyy);
    } else
    {
        $("#projectStatusAsOnDate").val(dd + "-" + mm + "-" + yyyy);
    }
}

function getDuration()
{
    jData = {};
    jData.projectStartDate = $("#projectStartDate").val();
    jData.projectEndDate = $("#projectEndDate").val();
    jData.service = "ProjectMasterServlet";
    jData.handller = "setDuration";
    $(document).getServace(jData);
}

function getProjectStatus()
{
    
    var projectPerStatus = $("#projectPerStatus").val();
    if (eval(projectPerStatus) < 100 && eval(projectPerStatus) > 0)
    {
        $("#projectStatus").val("On going");
    }
    if (eval(projectPerStatus) == 0)
    {
        $("#projectStatus").val("Rejected");
    }
    if (eval(projectPerStatus) == 100)
    {
        $("#projectStatus").val("Complete");
    }
    
    if (projectPerStatus == "")
    {
        $("#projectStatus").val("");
    }
    if (eval(projectPerStatus)>100)
    {
        alert("Please Enter Project(% of work) between 0 to 100");
        $("#projectPerStatus").val("");
        $("#projectPerStatus").focus();
        $("#projectStatus").val("");
    }
}

function formsubmit()
{
    if (jQuery.trim($('#projectCode').val()) == "") {
        alert("Please Enter the Project Code.");
        $('#projectCode').focus();
        return false;
    } 
    if (jQuery.trim($('#projectTitle').val()) == "") {
        alert("Please Enter the Project Title.");
        $('#projectTitle').focus();
        return false;
    } 
    if (jQuery.trim($('#projectGrandAmount').val()) == "") {
        alert("Please Enter the Project Grant Amount.");
        $('#projectGrandAmount').focus();
        return false;
    } 
    if (jQuery.trim($('#projectAuthority').val()) == "") {
        alert("Please Enter the Project Authority.");
        $('#projectAuthority').focus();
        return false;
    } 
    if (jQuery.trim($('#sponsoredAuthority').val()) == "") {
        alert("Please Enter the Sponsored Authority.");
        $('#sponsoredAuthority').focus();
        return false;
    } 
    if (jQuery.trim($('#departmentName').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentName').focus();
        return false;
    } 
    if (jQuery.trim($('#projectType').val()) == 0) {
        alert("Please Select the Project Type.");
        $('#projectType').focus();
        return false;
    } 
    if (jQuery.trim($('#projectStatusAsOnDate').val()) == "") {
        alert("Please Enter the Project Status on Date.");
        $('#projectStatusAsOnDate').focus();
        return false;
    } 
    if (jQuery.trim($('#projectPerStatus').val()) == "") {
        alert("Please Enter the Project(% of work).");
        $('#projectPerStatus').focus();
        return false;
    } 
    if (jQuery.trim($('#projectStartDate').val()) == "") {
        alert("Please Enter the Project Start Date.");
        $('#projectStartDate').focus();
        return false;
    } 
    if (jQuery.trim($('#projectEndDate').val()) == "") {
        alert("Please Enter the Project End Date.");
        $('#projectEndDate').focus();
        return false;
    } 
    
    if ($('input[name=active]:checked').length <= 0)
    {
        alert("Please choose Active Y/N.");
        return false;
    }
    
    jData = {};
    jData.projectID = $("#projectID").val();
    jData.companyid = $("#compsession").val();
    jData.projectCode = $("#projectCode").val();
    jData.projectTitle=$("#projectTitle").val();
    jData.projectGrandAmount=$("#projectGrandAmount").val();
    jData.projectAuthority=$("#projectAuthority").val();
    jData.sponsoredAuthority=$("#sponsoredAuthority").val();
    jData.departmentName=$("#departmentName").val();
    jData.projectType=$("#projectType").val();
    jData.projectStatusAsOnDate=$("#projectStatusAsOnDate").val();
    jData.projectPerStatus=$("#projectPerStatus").val();
    jData.projectStatus=getProjectStatusCode($("#projectStatus").val());
    jData.projectStartDate=$("#projectStartDate").val();
    jData.projectEndDate=$("#projectEndDate").val();
    jData.projectRemarks=$("#projectRemarks").val();
    jData.projectAPIScore=$("#projectAPIScore").val();
    jData.CollaborativeInstitute=$("#CollaborativeInstitute").val();
    jData.one=$("#one").val();
    jData.two=$("#two").val();
    jData.three=$("#three").val();
    if ($("#activeY").prop("checked")) {
        jData.deactive="N";
    }
    if ($("#activeN").prop("checked")) {
        jData.deactive="Y";
    }
    jData.entryBy = $("#entryBy").val();
    jData.service = "ProjectMasterServlet";
    jData.handller = "saveupdate";
    $(document).getServace(jData);  
}

function getProjectStatusCode(projectStatus)
{
    var pStatus = "";
    if (projectStatus == "On going")
    {
        pStatus = "O";
    }
    if (projectStatus == "Complete")
    {
        pStatus = "C";
    }
    if (projectStatus == "Rejected")
    {
        pStatus = "R";
    }
    return pStatus;
}

function resetValues()
{
    $("#projectCode").val("");
    $("#projectTitle").val("");
    $("#projectGrandAmount").val("");
    $("#projectAuthority").val("");
    $("#sponsoredAuthority").val("");
    $("#departmentName").val("");
    $("#projectType").val("0");
    $("#projectPerStatus").val("");
    $("#projectStatus").val("");
    $("#projectStatusAsOnDate").val("");
    $("#projectStartDate").val("");
    $("#projectEndDate").val("");
    $("#projectRemarks").val("");
    $("#projectAPIScore").val("");
    $("input:radio").attr("checked", false);
    $("#durationOfProject").val("");
    $("#CollaborativeInstitute").val("");
      $("#one").val("");
      $("#two").val("");
      $("#three").val("");

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
    jData.service = "ProjectMasterServlet";
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
    var rMarks="";
    var apiScore="";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 13%'>Department Name</th><th style='width: 6%'>Project Code</th><th style='width: 9%'>Project Title</th><th style='width: 5%'>Project Grant Amount</th><th style='width: 6%'>Project Authority</th><th style='width: 7%'>Sponsered Authority</th><th style='width: 6%'>Project Type</th><th style='width: 10%'>Project Period</th><th style='width: 6%'>Project(% of work)</th><th style='width: 6%'>Project Status</th><th style='width: 6%'>Project Remarks</th><th style='width: 6%'>Project API Score</th><th style='width: 4%'>Active Y/N</th><th style='width: 5%'></th>");

    for (var key in gridData) {
        rMarks=gridData[key]["projectRemarks"];
        apiScore=gridData[key]["projectAPIScore"];
        if(rMarks==null)
            {
             rMarks="";   
            }
        if(apiScore==null)
            {
             apiScore="";   
            }
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 13%'>" + gridData[key]["departmentName"] + "</td><td  style='width: 6%'>" + gridData[key]["projectCode"] + "</td><td  style='width: 9%'>" + gridData[key]["projectTitle"] + "</td>";
        table = table + "<td  style='width: 5%'>" + gridData[key]["projectGrandAmount"] + "</td><td  style='width: 6%'>" + gridData[key]["projectAuthority"] + "</td>";
        table = table + "<td  style='width: 7%'>" + gridData[key]["sponsoredAuthority"] + "</td><td  style='width: 6%'>" + getProjectType(gridData[key]["projectType"]) + "</td><td  style='width: 10%'>" + gridData[key]["projectStartDate"]+"/"+gridData[key]["projectEndDate"] + "</td>";
        table = table + "<td  style='width: 6%'>" + gridData[key]["projectPerStatus"] + "</td><td  style='width: 6%'>" + getProjectStatusName(gridData[key]["projectStatus"]) + "</td><td  style='width: 6%'>" +rMarks+ "</td>";
        table = table + "<td  style='width: 6%'>" + apiScore + "</td><td  style='width: 4%'>" + gridData[key]["active"]+ "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["projectID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function updateMasterRecord(projectID)
{
    jData = {};
    jData.service = "ProjectMasterServlet";
    jData.handller = "SelectforUpdate";
    jData.projectID = projectID;
    $(document).getServace(jData);
}


function getProjectType(pType)
{
    var tempValue="";
   if(pType=="R")
   {
     tempValue="Research";  
   }
   if(pType=="C")
   {
     tempValue="Consultancies";  
   }
   return tempValue;
}

function getProjectStatusName(pStatus)
{
   var tempValue="";
   if(pStatus=="O")
   {
     tempValue="On going";  
   }
   if(pStatus=="C")
   {
     tempValue="Complete";  
   }
   if(pStatus=="R")
   {
     tempValue="Rejected";  
   }
   return tempValue; 
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getSelectGridData("0");
    }
});

function getValidateDate()
{
    
    
    var startDate = $.datepicker.parseDate('dd-mm-yy', $('#projectStartDate').val());
    var endDate = $.datepicker.parseDate('dd-mm-yy', $('#projectEndDate').val());
    
      if (startDate > endDate) {
            alert('End Date must be greater than Start Date');
             $('#projectEndDate').val("");
            return false;
      }
      
      
}

function getCheckProjectStatusOnDate()
{
    var startDate = $.datepicker.parseDate('dd-mm-yy', $('#projectStartDate').val());
    var endDate = $.datepicker.parseDate('dd-mm-yy', $('#projectEndDate').val());
    var projectStatusAsOnDate = $.datepicker.parseDate('dd-mm-yy', $('#projectStatusAsOnDate').val());
    
    if (projectStatusAsOnDate < startDate && startDate!=null && projectStatusAsOnDate!=null)
    {
        alert('Project Status on Date must be equal or greater than Project Start Date');
        $('#projectStatusAsOnDate').val("");
        return false;
    }
    if (projectStatusAsOnDate > endDate && endDate!=null && projectStatusAsOnDate!=null)
    {
        alert('Project Status on Date must be equal or less than Project End Date');
        $('#projectStatusAsOnDate').val("");
        return false;
    }
}