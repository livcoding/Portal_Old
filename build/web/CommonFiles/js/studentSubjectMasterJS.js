/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.Vivek Soni 
 */


var rc = 0;
var gridData = {};
var totalCount=0;
(function($) {
    $.fn.getServace = function(para)
    {
        // alert(JSON.stringify(para));

        $.ajax({
            type: 'POST',
            timeout: 50000,
           // dataType: "json",
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
        case 'examCodeComboSSM':
             $(".custom-combobox-input").val("");
            $("#examCode").empty();
            $("#examCode").append(xhr.responseText);
            getSubject();
            break;
        case 'subjectCombo':
            $("#subject").empty();
            $("#subject").append(xhr.responseText);
            if (xhr.responseText == "" && $("#instituteCode").val() != "" && $("#examCode").val() != "" && $("#ltp").val() != "0")
            {
                $("#excelSubjects").html("");
                $("#excelSubjects").html("No Subjects Found");
            }else if(xhr.responseText != "" && $("#instituteCode").val() != "" && $("#examCode").val() != "" && $("#ltp").val() != "0")
                {
                  $("#excelSubjects").html("");
                  $("#excelSubjects").html("<FONT size='2'><u>Generate Subjects in <font color='green' size='4'><b>Excel</b></font></u></font>");
                }
            $("#subject").combobox();
            break;

    }
});


function getExamCode()
{
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.service = "CommonComboServlet";
    jData.handller = "examCodeComboSSM";
    jData.comboId = "examCodeComboSSM";
    $(document).getServace(jData);
}

function getSubject()
{
    $(".custom-combobox-input").val("");
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.examCode = $("#examCode").val();
    jData.ltp = $("#ltp").val();
    jData.service = "CommonComboServlet";
    jData.handller = "subjectCombo";
    jData.comboId = "subjectCombo";
    $(document).getServace(jData);
    if($("#instituteCode").val()!="" && $("#examCode").val()!="" && $("#ltp").val()!="0")
    {
        $("#excelSubjects").show();

    }else
        {
           $("#excelSubjects").hide();
        }
}

function getCommonMasterTable()
{


}

 function generateReportSSM()
{
    if (jQuery.trim($('#instituteCode').val()) == 0) {
        alert("Please Select the Institute Code.");
        $('#instituteCode').focus();
        return false;
    }
    if (jQuery.trim($('#examCode').val()) == 0) {
        alert("Please Select the Exam Code.");
        $('#examCode').focus();
        return false;
    }
    $("#total").html("");
    $("#gridhead").html("");
    $("#gridbody").html("");
    $("#gridbody").html(" <tr><td><img src='images/progressbar.gif' /></td></tr>");
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.examCode = $("#examCode").val();
    jData.ltp = $("#ltp").val();
    jData.deactive = $("#deactive").val();
    jData.subject = $("#subject").val();
    jData.service = "StudentSubjectMasterServlet";
    jData.handller = "generateReport";
    $(document).getServace(jData);
}

function getGridData() {
    

    var table = "";
    var rMarks="";
    var apiScore="";
   if(gridData[0]!=0){
   $("#total").html("<font color='Black' size='3' style='font-family:arial;width:2%'><b>Total Records</b></font>:-<b><font size='3'>"+totalCount+"</font><b>");
   $("#gridhead").html("");
   // $("#gridhead").html("<input type='hidden' name='institute' id='institute' value="+$("#instituteCode").val()+">");
      $("#gridhead").html("<tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Institute Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Employee Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Employee Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Academic Year</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Exam Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Program Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Section Branch</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Subsection Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Semester</font></td><td nowrap><b><font color='white' size='1' style='font-family:arial;width:5%'>Semester Type</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Subject Type</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Subject Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:13%'>Subject</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>LTP</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Enrollment No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:10%'>Student Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Student Deactive</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Email Id</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Mob.No.</font></td></tr>");

    for (var key in gridData) {
        if(key!="totalrecords"){
        table = table + "<tr><td  style='width: 2%'><font size='1' style='font-family:arial'>" + key + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["instituteCode"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["employeeName"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["employeeCode"] + "</font></td>";
        table = table + "<td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["academicYear"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["examCode"] + "</font></td>";
        table = table + "<td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["programCode"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" +gridData[key]["sectionBranch"]+ "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["subsectionCode"]+"</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + gridData[key]["semester"] + "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["semesterType"] + "</font></td><td  style='width: 8%'><font size='1' style='font-family:arial'>" + gridData[key]["subjectType"] + "</font></td>";
        table = table + "<td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["subjectCode"] + "</font></td><td  style='width: 13%'><font size='1' style='font-family:arial'>" + gridData[key]["subject"]+ "</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["ltp"]+ "</font></td>";
        table = table + "<td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["enrollmentNo"] + "</font></td><td  style='width: 10%'><font size='1' style='font-family:arial'>" + gridData[key]["studentName"]+ "</font></td><td  style='width:5%'><font size='1' style='font-family:arial'>" + gridData[key]["deactive"]+ "</font></td>";
        table = table + "<td  style='width: 5%'><font size='1' style='font-family:arial'>" + gridData[key]["stemailid"] + "</font></td><td  style='width: 10%'><font size='1' style='font-family:arial'>" + gridData[key]["stcellno"]+ "</font></td>";
        }}}else{
        $("#total").html("");
        $("#gridhead").html("");
        table =table+ "<tr bgcolor='red'><td><b><font size='1' style='font-family:arial;' color='white'>No Records Found</font></b></td></tr>";
    }
    if(gridData[0]!=0)
        {
       //table = table + "<tr><td colspan='9' style='width: 50%' align='right'><input type='hidden' name='exceldata'  value='"+table.replace("'","\"")+"'><input type='button' id='printReport' value='Print' onclick='JavaScript:window.print();' ></td><td style='width: 50%' colspan='9'><input type='submit' id='generateReport' value='Generate Report'  ></td></tr>";
       table = table + "<tr><td colspan='9' style='width: 50%' align='right'><input type='button' id='printReport' value='Print' onclick='JavaScript:window.print();' ></td><td style='width: 50%' colspan='11'><input type='button' id='generateReport' value='Generate Report' onclick='exportReport()' ></td></tr>";
        }
    $("#gridbody").html("");
    $("#gridbody").html("" + table);

}

function exportReport()
{

    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.examCode = $("#examCode").val();
    jData.ltp = $("#ltp").val();
    jData.deactive = $("#deactive").val();
    jData.subject = $("#subject").val();
    jData.handller = "exportReport";
     jQuery("<form action='../StudentSubjectMasterServlet' method='post' target ='_blank'><input type='hidden' name='jdata'  value='"+(JSON.stringify(jData))+"'></form>").appendTo("body").submit().remove();
    //$(document).getServace(jData);
}

function generateExcelReportForSubjects()
{
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.examCode = $("#examCode").val();
    jData.ltp = $("#ltp").val();
    jData.deactive = $("#deactive").val();
    jData.subject = $("#subject").val();
    jData.handller = "exportSubjects";
     jQuery("<form action='../StudentSubjectMasterServlet' method='post' target ='_blank'><input type='hidden' name='jdata'  value='"+(JSON.stringify(jData))+"'></form>").appendTo("body").submit().remove();
    //$(document).getServace(jData);
}