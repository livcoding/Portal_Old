/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var rc = 0;
var selectPersonsInfo = {};
var selectStudentInfo = {};
var gridData = {};
var currRowNo=0;
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

        case 'selectPersonsInfo':
            selectPersonsInfo = jQuery.parseJSON(xhr.responseText);
            getSelectPersonsInfoInPopUp(selectPersonsInfo);
            $('#TOTAL').html("Total No.of Record(s): " + selectPersonsInfo[1].totalrecords);
            break;
             case 'selectStudentInfo':
            selectStudentInfo = jQuery.parseJSON(xhr.responseText);
            getSelectStudentInfoInPopUp(selectStudentInfo);
            $('#TOTAL').html("Total No.of Record(s): " + selectStudentInfo[1].totalrecords);
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
            getSelectGridData("0");
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;
        case 'SelectforUpdate':
            var SelectData = {};
            var childData = {};
            var i = 1;
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#transactionID").val(SelectData["transactionID"]);
            $("#transactionDate").val(SelectData["transactiondate"]);
            $("#departmentName").val(SelectData["departmentcode"]);
            $("#titleOfTheProgram").val(SelectData["programtitle"]);
            $("#programType").val(SelectData["programtype"]);
            $("#startDate").val(SelectData["startdate"]);
            $("#endDate").val(SelectData["enddate"]);
            $("#objectiveOfProgram").val(SelectData["programobjective"]);
            $("#targetAudience").val(SelectData["targetaudience"]);
            $("#tentativeBudget").val(SelectData["tentativebudget"]);
            if(SelectData["hodapproval"]=='Y')
                {
                    $("#approvalOfHODY").prop("checked",true);
                }else
                    {
                      $("#approvalOfHODN").prop("checked",true)  
                    }
            if(SelectData["vcapproval"]=='Y')
                {
                    $("#approvalOfVCY").prop("checked",true);
                }else
                    {
                       $("#approvalOfVCN").prop("checked",true)  
                    }
            $("#programRemarks").val(SelectData["programremarks"]);
            
            var lRow=$('[name="personName"]').last().attr('id').substring(10);
             for(var m = 0;m<=lRow;m++){
             $('.dWorkShopTransactionRow').trigger('click');
             }
              $("#employeeid"+lRow).attr("id","employeeid1");
              $("#personName"+lRow).attr("id","personName1");
              $("#designation"+lRow).attr("id","designation1");
              $("#affiliation"+lRow).attr("id","affiliation1");
              $("#expertise"+lRow).attr("id","expertise1");
              $("#remarks"+lRow).attr("id","remarks1");
              $("#row"+lRow).attr("id","row1");
              $("#row1").html("1.");
            childData = SelectData["childMap"];
            for (var key in childData) {
                if (i != 1) {
                    AddWorkShopTransaction();
                }
                var subrow = childData[i];
                for (var key1 in subrow) {
                    $("#" + key1 + i).val(subrow[key1]);

                }
                i++;
            }

            break;
        case 'Delete':
            getSelectGridData(cupage.pr);
            break;
        
    }
});

function getCommonMasterTable()
{
   // alert("WORKSHOP");
    
    $(".number").numeric();
    $(".nondecimal").numbernondecimal();
    $(".nametext").alphanumeric();
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
        $("#transactionDate").val(dd + "-" +"0"+ mm + "-" + yyyy);
    } else
    {
        $("#transactionDate").val(dd + "-" + mm + "-" + yyyy);
    }
    
    
    
    $("#paggingPopUp").getPagging();
    $(".addWorkShopTransactionRow").click('click', function(e) {
        var rowCount = $('#workshopTransactionTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#workshopTransactionTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddWorkShopTransaction();
        }
    });
    $("#workshopTransactionTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    $("#resourcePersonNamestable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    
    
    $(".dWorkShopTransactionRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.workshopTransactionRow1').length)==1){
              $("#personName1").val("");$("#designation1").val("");$("#affiliation1").val(""); $("#expertise1").val("");$("#remarks1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(23);
                 $("#dWorkShopTransactionRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });
    
}


    
    function AddWorkShopTransaction(){
    var lRow=$('[name="personName"]').last().attr('id').substring(10);
    var newRow = $('.workshopTransactionRow1:eq(0)').clone(true);
    newRow.insertAfter($('.workshopTransactionRow1:last'));
    $(".workshopTransactionRow1").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'personName':{
                        $(this).val("");break;
                    }
                    case 'designation':{
                        $(this).val("");break;
                    }
                    case 'affiliation':{
                        $(this).val("");break;
                    }
                    case 'expertise':{
                        $(this).val("");break;
                    }
                    case 'remarks':{
                        $(this).val("");break;
                    }
                }
            }
        });
    });
    $("#row"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dWorkShopTransactionRow"+(eval(lRow))).hide();
    $("#dWorkShopTransactionRow"+(eval(lRow)+1)).show();
    
}

$(function() {
    $("#resourcePersonNames").dialog({
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
    $("#personName1").click(function() {
        $("#resourcePersonNames").dialog("open");
        currRowNo = (this.id).substr(10, 1);
        $("#searchNames").val("");
        if ($("#member").val() == "S") {
            getStudentNames("0");
        } else
        {
            getStaffNames("0");
        }
    });
});
function getStudentsInfo(){
    //alert("AAAAAAAAAAa");
  //  alert($("#member").val());
    if ($("#member").val() == "S") {
        getStudentNames("0");
    } else
    {
        getStaffNames("0");
    }
}

function getMemberNames(pno)
{
   //  alert($("#member").val());
 if ($("#member").val() == "S") {
        getStudentNames(pno);
    } else
    {
        getStaffNames(pno);
    }
}
function getStaffNames(pno)
{
    //alert("STAFFNAME");
    var totIDS = 0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectPersonsInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    var lRow = $('[name="personName"]').last().attr('id').substring(10);
    for (var x = 1; x <= lRow; x++)
    {
        totIDS = totIDS + "," + $("#employeeid" + x).val();
    }
    var arr = totIDS.split(",");
    var str = '';
    for (var y = 0; y < arr.length; y++)
    {
        str = str + "'" + arr[y] + "',";
    }
    str = str.substr(0, str.lastIndexOf(","));
    jData.spg = pno;
    jData.personsIDS = str;
    jData.transactionDate = $("#transactionDate").val();
    jData.searchNames = $("#searchNames").val();
    jData.service = "WorkShopTransactionServlet";
    jData.handller = "selectPersonsInfo";
    $(document).getServace(jData);

}

function getSelectPersonsInfoInPopUp(){ 
     var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 15%'>Employee Code</th><th style='width: 30%'>Employee Name</th><th style='width: 25%'>Department</th><th style='width: 20%'>Designation </th>");
    
     for (var key in selectPersonsInfo) {
        table = table + "<tr ondblclick='setNames("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectPersonsInfo[key]["sno"] + "</td><td  style='width: 15%;text-align: left'>" + selectPersonsInfo[key]["employeecode"] + "</td><td  style='width: 30%;text-align: left'>" + selectPersonsInfo[key]["employeename"] + "</td><td  style='width: 25%';text-align: left>" + selectPersonsInfo[key]["department"] + "</td><td  style='width: 20%;text-align: left'>" + selectPersonsInfo[key]["designation"] + "</td></tr>";
    }

    $("#resourcePersonNamesBody").html("");
    $("#resourcePersonNamesBody").html("" + table);
   
 $("#popupHeaderTable").css("width",$("#resourcePersonNamesBody").width());
}

function  getStudentNames(pno)
{
   // alert("STUDENTNAME");
    var totIDS = 0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectStudentInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    var lRow = $('[name="personName"]').last().attr('id').substring(10);
    for (var x = 1; x <= lRow; x++)
    {
        totIDS = totIDS + "," + $("#employeeid" + x).val();
    }
    var arr = totIDS.split(",");
    var str = '';
    for (var y = 0; y < arr.length; y++)
    {
        str = str + "'" + arr[y] + "',";
    }
    str = str.substr(0, str.lastIndexOf(","));
    jData.spg = pno;
    jData.personsIDS = str;
    jData.transactionDate = $("#transactionDate").val();
    jData.searchNames = $("#searchNames").val();
    jData.service = "WorkShopTransactionServlet";
    jData.handller = "selectStudentInfo";
    $(document).getServace(jData);

}
function getSelectStudentInfoInPopUp(){
     var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 15%'>Employee Code</th><th style='width: 30%'>Employee Name</th><th style='width: 25%'>Department</th><th style='width: 20%'>Designation </th>");

     for (var key in selectStudentInfo) {
        table = table + "<tr ondblclick='setNames("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectStudentInfo[key]["sno"] + "</td><td  style='width: 15%;text-align: left'>" + selectStudentInfo[key]["employeecode"] + "</td><td  style='width: 30%;text-align: left'>" + selectStudentInfo[key]["employeename"] + "</td><td  style='width: 25%';text-align: left>" + selectStudentInfo[key]["department"] + "</td><td  style='width: 20%;text-align: left'>" + selectStudentInfo[key]["designation"] + "</td></tr>";
    }

    $("#resourcePersonNamesBody").html("");
    $("#resourcePersonNamesBody").html("" + table);

 $("#popupHeaderTable").css("width",$("#resourcePersonNamesBody").width());
}

$(document).keydown(function(e) {
     if (e.keyCode == 13) {
        if ($("#member").val() == "S") {
            getStudentNames("0");
        } else
        {
            getStaffNames("0");
        }
        getSelectGridData("0");
    }
});

function setNames(key)
{
    if ($("#member").val()== 'F'){
      //  alert("EMPLOYEESET");
    
    $("#employeeid" + currRowNo).val(selectPersonsInfo[key]["employeeid"]);
    $("#personName" + currRowNo).val(selectPersonsInfo[key]["employeename"]);
    $("#designation" + currRowNo).val(selectPersonsInfo[key]["designation"]);
    
    
}else
    {
     // alert("OTHERSET");
     $("#employeeid" + currRowNo).val(selectStudentInfo[key]["employeeid"]);
    $("#personName" + currRowNo).val(selectStudentInfo[key]["employeename"]);
    $("#designation" + currRowNo).val(selectStudentInfo[key]["designation"]);

    }

$("#resourcePersonNames").dialog("close");
}
function formsubmit()
{
    if (jQuery.trim($('#departmentName').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentName').focus();
        return false;
    }
     if (jQuery.trim($('#titleOfTheProgram').val()) =="") {
        alert("Please Enter the Title of the Program.");
        $('#titleOfTheProgram').focus();
        return false;
    }
    if (jQuery.trim($('#programType').val()) ==0) {
        alert("Please Select the Program Type.");
        $('#programType').focus();
        return false;
    }
    if (jQuery.trim($('#startDate').val()) =="") {
        alert("Please Enter the Start Date.");
        $('#startDate').focus();
        return false;
    }
    if (jQuery.trim($('#endDate').val()) =="") {
        alert("Please Enter the End Date.");
        $('#endDate').focus();
        return false;
    }
    if (jQuery.trim($('#objectiveOfProgram').val()) =="") {
        alert("Please Enter the Objective of Program.");
        $('#objectiveOfProgram').focus();
        return false;
    }
    if (jQuery.trim($('#targetAudience').val()) =="") {
        alert("Please Enter the Target audience.");
        $('#targetAudience').focus();
        return false;
    }
    if (jQuery.trim($('#tentativeBudget').val()) =="") {
        alert("Please Enter the Tentative Budget.");
        $('#tentativeBudget').focus();
        return false;
    }
    
    if ($('input[name=approvalOfHOD]:checked').length <= 0)
    {
        alert("Please choose Approval Of HOD ");
        return false;
    }
    if ($('input[name=approvalOfVC]:checked').length <= 0)
    {
        alert("Please choose Approval Of VC ");
        return false;
    }
    
   if (jQuery.trim($('#personName1').val()) =="") {
        alert("Please Enter the Resource Person Name.");
        $('#personName1').focus();
        return false;
    }
    if (jQuery.trim($('#designation1').val()) =="") {
        alert("Please Enter the Designation.");
        $('#designation1').focus();
        return false;
    }
    if (jQuery.trim($('#affiliation1').val()) =="") {
        alert("Please Enter the Affiliation.");
        $('#affiliation1').focus();
        return false;
    }
    if (jQuery.trim($('#expertise1').val()) =="") {
        alert("Please Enter the Expertise.");
        $('#expertise1').focus();
        return false;
    }
    
    var lRow=$('[name="personName"]').last().attr('id').substring(10);
    var personNamesDataList=[];
    for(var i=1;i<=lRow;i++){
       
        var personNamesData={};
        
        personNamesData.employeeid=$("#employeeid"+i).val();
        personNamesData.personName=$("#personName"+i).val();
        personNamesData.designation=$("#designation"+i).val();
        personNamesData.affiliation=$("#affiliation"+i).val();
        personNamesData.expertise=$("#expertise"+i).val();
        personNamesData.remarks=$("#remarks"+i).val();
        personNamesDataList.push(personNamesData);
    }
     
    jData = {};
    jData.transactionID = $("#transactionID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.transactionDate=$("#transactionDate").val();
    jData.departmentName=$("#departmentName").val();
    jData.titleOfTheProgram=$("#titleOfTheProgram").val();
    jData.programType=$("#programType").val();
    jData.startDate=$("#startDate").val();
    jData.endDate=$("#endDate").val();
    jData.objectiveOfProgram=$("#objectiveOfProgram").val();
    jData.targetAudience=$("#targetAudience").val();
    jData.tentativeBudget=$("#tentativeBudget").val();
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
    jData.programRemarks = $("#programRemarks").val();
    jData.entryBy = $("#entryBy").val();
    
    jData.service = "WorkShopTransactionServlet";
    jData.handller = "saveupdate";
    jData.para = personNamesDataList;
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
     jData.entryBy = $("#entryBy").val();
    jData.service = "WorkShopTransactionServlet";
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
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 14%'>Transaction Date</th><th style='width: 15%'>Department Name</th><th style='width: 14%'>Title of the Program </th><th style='width: 14%'>Program Type</th><th style='width: 14%'>Start Date</th><th style='width: 14%'>End Date</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 14%'>" + gridData[key]["transactiondate"] + "</td><td  style='width: 15%'>" + gridData[key]["department"] + "</td><td  style='width: 14%'>" + gridData[key]["programtitle"] + "</td>";
        table = table + "<td  style='width: 14%'>" + gridData[key]["programtype"] + "</td><td  style='width: 14%'>" + gridData[key]["startdate"] + "</td><td  style='width: 14%'>" + gridData[key]["enddate"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["transactionid"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["transactionid"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}


function updateMasterRecord(transactionid)
{
    jData = {};
    jData.service = "WorkShopTransactionServlet";
    jData.handller = "SelectforUpdate";
    jData.transactionid = transactionid;
    $(document).getServace(jData);
}

function deleteMasterRecord(transactionID)
{
    
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "WorkShopTransactionServlet";
        jData.handller = "Delete";
        jData.transactionID = transactionID;
        $(document).getServace(jData);
    }
    else {
    }

}

function getValidateDate()
{
    
    
    var startDate = $.datepicker.parseDate('dd-mm-yy', $('#startDate').val());
    var endDate = $.datepicker.parseDate('dd-mm-yy', $('#endDate').val());
    
      if (startDate > endDate) {
            alert('End Date must be greater than Start Date');
             $('#endDate').val("");
            return false;
      }
      
}

function resetValues()
{
    $("#transactionID").val("0");
    $("#departmentName").val("");
    $("#titleOfTheProgram").val("");
    $("#programType").val("0");
    $("#startDate").val("");
    $("#endDate").val("");
    $("#objectiveOfProgram").val("");
    $("#targetAudience").val("");
    $("#tentativeBudget").val("");
    $("#programRemarks").val("");
    $("input:radio").attr("checked", false);
    $("#employeeid1").val("");
    $("#personName1").val("");
    $("#designation1").val("");
    $("#affiliation1").val("");
    $("#expertise1").val("");
    $("#remarks1").val("");
    location.reload(); 
}
   
    
