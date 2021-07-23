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
         //alert(JSON.stringify(para));
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
            alert("totalCount"+totalCount);
            getGridData(gridData);
            break;
    }
});

function getCommonMasterTable()
{

}

function generateReportBBAApplicantDetail()
{
    if (jQuery.trim($('#admissionYear').val()) == 0) {
        alert("Please Select the Admission Year.");
        $('#admissionYear').focus();
        return false;
    }
    if (jQuery.trim($('#applicationType').val()) == 0) {
        alert("Please Select the Application Type.");
        $('#applicationType').focus();
        return false;
    }
    if (jQuery.trim($('#sortBy').val()) == 0) {
        alert("Please Select the Sort By.");
        $('#sortBy').focus();
        return false;
    }
    $("#total").html("");
    $("#gridhead").html("");
    $("#gridbody").html("");
    $("#gridbody").html(" <tr><td><img src='images/progressbar.gif' /></td></tr>");
    jData = {};
    jData.admissionYear = $("#admissionYear").val();
    jData.applicationType = $("#applicationType").val();
    jData.sortBy = $("#sortBy").val();    
    jData.service = "BBAApplicantDetailServlet";    
    jData.handller = "generateReport";
    $(document).getServace(jData);
   
}


function exportReport()
{
    
     if (jQuery.trim($('#admissionYear').val()) == 0) {
        alert("Please Select the Admission Year.");
        $('#admissionYear').focus();
        return false;
    }
    if (jQuery.trim($('#applicationType').val()) == 0) {
        alert("Please Select the Application Type.");
        $('#applicationType').focus();
        return false;
    }
    if (jQuery.trim($('#sortBy').val()) == 0) {
        alert("Please Select the Sort By.");
        $('#sortBy').focus();
        return false;
    }

    jData = {};
    jData.admissionYear = $("#admissionYear").val();
    jData.applicationType = $("#applicationType").val();
    jData.sortBy = $("#sortBy").val();
    jData.handller = "exportReport";
     jQuery("<form action='../BBAApplicantDetailServlet' method='post' target ='_blank'><input type='hidden' name='jdata'  value='"+(JSON.stringify(jData))+"'></form>").appendTo("body").submit().remove();
}


function getGridData() {

alert("in grid");

    var table = "";
    var rMarks="";
    var apiScore="";
   if(gridData[0]!=0){
   $("#total").html("<font color='Black' size='3' style='font-family:arial;width:2%'><b>Total Records</b></font>:-<b>"+totalCount+"<b>");
   $("#gridhead").html("");
   // $("#gridhead").html("<input type='hidden' name='institute' id='institute' value="+$("#instituteCode").val()+">");
      $("#gridhead").html("<tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Application SL No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Application No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Student Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Father Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Date of Birth</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Category</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Gender</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:6%'>Address1</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:6%'>Address2</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>City</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>State</font></td><td nowrap><b><font color='white' size='1' style='font-family:arial;width:3%'>Pin</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Phone No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Email ID</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Cheque DD No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Cheque DD Date</font></td> <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Cheque DD Type</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Amount</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Bank Name</font></td></tr>");

    for (var key in gridData) {
        if(key!="totalrecords"){
        table = table + "<tr><td  style='width: 1%'><font size='1' style='font-family:arial'>" + key + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["applicationSLNO"]==""?"&nbsp;":gridData[key]["applicationSLNO"]) + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["applicationNO"]==""?"&nbsp;":gridData[key]["applicationNO"]) + "</font></td>";
        table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["studentName"]==""?"&nbsp;":gridData[key]["studentName"]) + "</font></td>";
        table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["fatherName"]==""?"&nbsp;":gridData[key]["fatherName"]) + "</font></td>";
	table = table + "<td  style='width: 3%' nowrap><font size='1' style='font-family:arial'>" + (gridData[key]["dateOfBirth"]==""?"&nbsp;":gridData[key]["dateOfBirth"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["category"]==""?"&nbsp;":gridData[key]["category"]) + "</font></td>";
	table = table + "<td  style='width: 1%'><font size='1' style='font-family:arial'>" + (gridData[key]["gender"]==""?"&nbsp;":gridData[key]["gender"]) + "</font></td>";
        table = table + "<td  style='width: 6%'><font size='1' style='font-family:arial'>" + (gridData[key]["address1"]==""?"&nbsp;":gridData[key]["address1"]) + "</font></td>";
	table = table + "<td  style='width: 6%'><font size='1' style='font-family:arial'>" +(gridData[key]["address2"]==""?"&nbsp;":gridData[key]["address2"])+ "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["city"]==""?"&nbsp;":gridData[key]["city"])+"</font></td>";
        table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["stateName"]==""?"&nbsp;":gridData[key]["stateName"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["pin"]==""?"&nbsp;":gridData[key]["pin"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["phone"]==""?"&nbsp;":gridData[key]["phone"]) + "</font></td>";
        table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["emailID"]==""?"&nbsp;":gridData[key]["emailID"]) + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["chequeDDNo"]==""?"&nbsp;":gridData[key]["chequeDDNo"]) + "</font></td>";
        table = table + "<td  style='width: 2%' nowrap><font size='1' style='font-family:arial'>" + (gridData[key]["chequeDDDate"]==""?"&nbsp;":gridData[key]["chequeDDDate"]) + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["chequeDDType"]==""?"&nbsp;":gridData[key]["chequeDDType"])+ "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["amount"]==""?"&nbsp;":gridData[key]["amount"]) + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["bankName"]==""?"&nbsp;":gridData[key]["bankName"]) + "</font></td></tr>";
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


