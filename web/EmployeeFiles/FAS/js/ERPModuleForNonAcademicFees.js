/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var rc = 0;
var gridData = {};
var totalCount=0;
(function($) {
    $.fn.getServace = function(para)
    {
        alert("1222222");
         alert(JSON.stringify(para));
        $.ajax({
            type: 'POST',
            timeout: 50000,
            dataType: "json",
            handller: para.handller,
            url: '../' + para.service,
            data : 'jdata='+JSON.stringify(para).replace(/&/g,"").replace(/%/g,"")+'&d='+new Date(),
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
            totalCount = gridData["totalrecords"];
            getGridData(gridData);
            break;
        case 'examCodeCombo':
            $("#examCode").empty();
            $("#examCode").append(xhr.responseText);
            break;
        case 'academicYearComboWithInstCode':
            $("#academicYear").empty();
            $("#academicYear").append(xhr.responseText);
            getProgramCode();
            break;
        case 'programCodeCombo':
            $("#programCode").empty();
            $("#programCode").append(xhr.responseText);
            getQuota();
            getBranchCode();
            break;
        case 'branchCodeCombo':
            $("#branchCode").empty();
            $("#branchCode").append(xhr.responseText);
            getExamCode();
            break;
        case 'quotaCombo':
            $("#quota").empty();
            $("#quota").append(xhr.responseText);
            break;
    }
});



function   getCommonMasterTable(){

}

function generateReportSM()
{

    if (jQuery.trim($('#instituteCode').val()) == 0) {
        alert("Please Select the Institute Code.");
        $('#instituteCode').focus();
        return false;
    }
    if (jQuery.trim($('#academicYear').val()) == 0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        return false;
    }
    $("#total").html("");
    $("#gridhead").html("");
    $("#gridbody").html("");
    $("#gridbody").html(" <tr><td><img src='images/progressbar.gif' /></td></tr>");
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.academicYear = $("#academicYear").val();
    jData.programCode = $("#programCode").val();
    jData.branchCode = $("#branchCode").val();
    jData.regConfirmation = $("#regConfirmation").val();
    jData.deactive = $("#deactive").val();
    jData.examCode = $("#examCode").val();
    jData.quota = $("#quota").val();
    jData.gender = $("#gender").val();
    jData.service = "StudentMasterServlet";
    jData.handller = "generateReport";
    $(document).getServace(jData);
}
function exportReport()
{
    if (jQuery.trim($('#instituteCode').val()) == 0) {
        alert("Please Select the Institute Code.");
        $('#instituteCode').focus();
        return false;
    }
    if (jQuery.trim($('#academicYear').val()) == 0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        return false;
    }

    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.academicYear = $("#academicYear").val();
    jData.programCode = $("#programCode").val();
    jData.branchCode = $("#branchCode").val();
    jData.regConfirmation = $("#regConfirmation").val();
    jData.deactive = $("#deactive").val();
    jData.examCode = $("#examCode").val();
    jData.quota = $("#quota").val();
    jData.gender = $("#gender").val();
    jData.handller = "exportReport";
     jQuery("<form action='../StudentMasterServlet' method='post' target ='_blank'><input type='hidden' name='jdata'  value='"+(JSON.stringify(jData))+"'></form>").appendTo("body").submit().remove();
    //$(document).getServace(jData);
}

function getGridData() {

    var table = "";
    var rMarks="";
    var apiScore="";
   if(gridData[0]!=0){
   $("#total").html("<font color='Black' size='3' style='font-family:arial;width:2%'><b>Total Records</b></font>:-<b>"+totalCount+"<b>");
   $("#gridhead").html("");
   // $("#gridhead").html("<input type='hidden' name='institute' id='institute' value="+$("#instituteCode").val()+">");
      $("#gridhead").html("<tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Institute Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Academic Year</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Enrollment No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Exam Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:6%'>Student Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Gender</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Program Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Branch Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Subsection Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Semester</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Deactive</font></td><td nowrap><b><font color='white' size='1' style='font-family:arial;width:5%'>Date of Birth</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Father Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Quota</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Reg Confirmation</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Phone Number</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Mail ID</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Current Address</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Permanent Address</font></td>");

    for (var key in gridData) {
        if(key!="totalrecords"){
        table = table + "<tr><td  style='width: 2%'><font size='1' style='font-family:arial'>" + key + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["instituteCode"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["academicYear"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["enrollmentNo"] + "</font></td>";
        table = table + "<td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["examCode"] + "</font></td><td  style='width: 6%'><font size='1' style='font-family:arial'>" + gridData[key]["studentName"] + "</font></td><td  style='width: 2%'><font size='1' style='font-family:arial'>" + gridData[key]["gender"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["programCode"] + "</font></td>";
        table = table + "<td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["branchCode"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" +gridData[key]["subSectionCode"]+ "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["Semester"]+"</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + gridData[key]["deactive"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["dateOfBirth"] + "</font></td><td  style='width: 8%'><font size='1' style='font-family:arial'>" + gridData[key]["fatherName"] + "</font></td>";
        table = table + "<td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["quota"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["regConfirmation"]+ "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["phoneNo"]+ "</font></td>";
        table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + gridData[key]["mailID"] + "</font></td><td  style='width: 8%'><font size='1' style='font-family:arial'>" + gridData[key]["currentAddress"]+ "</font></td><td  style='width:8%'><font size='1' style='font-family:arial'>" + gridData[key]["permanentAddress"]+ "</font></td>";
        }}}else{
        $("#total").html("");
        $("#gridhead").html("");
        table =table+ "<tr bgcolor='red'><td><b><font size='1' style='font-family:arial;' color='white'>No Records Found</font></b></td></tr>";
    }
    if(gridData[0]!=0)
        {
       //table = table + "<tr><td colspan='9' style='width: 50%' align='right'><input type='hidden' name='exceldata'  value='"+table.replace("'","\"")+"'><input type='button' id='printReport' value='Print' onclick='JavaScript:window.print();' ></td><td style='width: 50%' colspan='9'><input type='submit' id='generateReport' value='Generate Report'  ></td></tr>";
       table = table + "<tr><td colspan='9' style='width: 50%' align='right'><input type='button' id='printReport' value='Print' onclick='JavaScript:window.print();' ></td><td style='width: 50%' colspan='9'><input type='button' id='generateReport' value='Generate Report' onclick='exportReport()' ></td></tr>";
        }
    $("#gridbody").html("");
    $("#gridbody").html("" + table);

}

function getExamCode()
{
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.academicYear = $("#academicYear").val();
    jData.programCode = $("#programCode").val();
    jData.branchCode = $("#branchCode").val();
    jData.service = "CommonComboServlet";
    jData.handller = "examCodeCombo";
    jData.comboId = "examCodeCombo";
    $(document).getServace(jData);
}

function getAcademicYear()
{
    alert("1121212");
    jData = {};
    alert("1121213");
    jData.instituteCode = $("#instituteCode").val();
    alert("1121214");
    jData.service = "CommonComboServlet";
      alert("1121212");
    jData.handller = "academicYearComboWithInstCode";
      alert("1121212");
    jData.comboId = "academicYearComboWithInstCode";
      alert("1121212");
    $(document).getServace(jData);
      alert("1121212");
}

function getProgramCode()
{
    
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.academicYear = $("#academicYear").val();
    jData.service = "CommonComboServlet";
    jData.handller = "programCodeCombo";
    jData.comboId = "programCodeCombo";
    $(document).getServace(jData);


}

function getBranchCode()
{
    if($("#programCode").val()=='ALL')
        {
            $('#branchCode').attr('disabled', true);
            $("#branchCode").empty();
            $("#branchCode").append("<option value='0'>Select Branch Code</option>");
            getExamCode();
        }else{
            $('#branchCode').attr('disabled', false);
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.academicYear = $("#academicYear").val();
    jData.programCode = $("#programCode").val();
    jData.service = "CommonComboServlet";
    jData.handller = "branchCodeCombo";
    jData.comboId = "branchCodeCombo";
    $(document).getServace(jData);
        }

}

function getQuota()
{

        jData.instituteCode = $("#instituteCode").val();
        jData.academicYear = $("#academicYear").val();
        jData.service = "CommonComboServlet";
        jData.handller = "quotaCombo";
        jData.comboId = "quotaCombo";
        $(document).getServace(jData);

}