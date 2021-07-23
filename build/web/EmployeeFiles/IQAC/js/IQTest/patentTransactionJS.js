/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var rc = 0;
var selectStaffInfo = {};
var selectStudentInfo = {};
var gridData = {};
var cupage = {};
var currRowNo=0;
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
            data: 'jdata=' + JSON.stringify(para).replace(/&/g, "").replace(/%/g, ""),
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
        case 'formNameCombo':
            $("#formName").empty();
            $("#formName").append(xhr.responseText);
            break;
        case 'selectStaffInfo':
            selectStaffInfo = jQuery.parseJSON(xhr.responseText);
            getSelectStaffInfoInPopUp(selectStaffInfo);
            $('#TOTAL').html("Total No.of Record(s): " + selectStaffInfo[1].totalrecords);
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
            $("#patentID").val(SelectData["patentID"]);
            $("#transactionDate").val(SelectData["transactionDate"]);
            $("#patentCode").val(SelectData["patentCode"]);
            $("#patentTitle").val(SelectData["patentTitle"]);
            $("#patentFee").val(SelectData["patentFee"]);
            $("#patentFilingDate").val(SelectData["patentFilingDate"]);
            $("#patentValidTillDate").val(SelectData["patentValidTillDate"]);
            $("#patentRemarks").val(SelectData["patentRemarks"]);
            $("#patentStatus").val(SelectData["patentStatus"]);
            $("#apiScore").val(SelectData["apiScore"]);
            $("#natureOfPatent").val(SelectData["patentNature"]);
            childData = SelectData["childMap"];
            $("#departmentCombo").val(childData[1]["departmentCode"]);
            $("#departmentCombo").prop("disabled", true);
             $("#patentno").prop("disabled", true);
              $("#country").prop("disabled", true);
            var lRow = $('[name="memberName"]').last().attr('id').substring(10);
            for (var x = 0; x <= lRow; x++)
            {
                $("#memberName" + x).prop("disabled", false);
                $("#departmentName" + x).prop("disabled", false);
            }
            var lRow = $('[name="memberName"]').last().attr('id').substring(10);
            for (var m = 0; m <= lRow; m++) {
                $('.dPatentTransactionRow').trigger('click');
            }
            $("#memberID" + lRow).attr("id", "memberID1");
            $("#memberType" + lRow).attr("id", "memberType1");
            $("#choose" + lRow).attr("id", "choose1");
            $("#departmentCode" + lRow).attr("id", "departmentCode1");
            $("#memberName" + lRow).attr("id", "memberName1");
            $("#departmentName" + lRow).attr("id", "departmentName1");
            $("#row" + lRow).attr("id", "row1");
            $("#row1").html("1.");

            
            for (var key in childData) {
                if (i != 1) {
                    addPatentTransaction();
                }
                var subrow = childData[i];
                for (var key1 in subrow) {
                    if(key1=="choose"){
                    $("#" + key1 + i).html("<b>"+getType(subrow[key1])+"</b>");   
                    }else{
                    $("#" + key1 + i).val(subrow[key1]);
                }
                }
                i++;
            }

            break;
        case 'Delete':
            getSelectGridData(cupage.pr);
            break;

    }
});

function getType(code)
{
    var temp = "";
    if (code == "S")
    {
        temp = "Student";
    } else
    {
        temp = "Faculty";
    }
    return temp;
}

function getCommonMasterTable()
{
    var lRow = $('[name="memberName"]').last().attr('id').substring(10);
    for(var x=0;x<=lRow;x++)
        {
        $("#memberName"+x).prop("disabled", true); 
        $("#departmentName"+x).prop("disabled", true); 
        }
    
    $(".number").numeric();
    $(".nondecimal").numbernondecimal();
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = "0" + dd
    }
    if (mm < 10) {
        $("#transactionDate").val(dd + "-" + "0" + mm + "-" + yyyy);
    } else
    {
        $("#transactionDate").val(dd + "-" + mm + "-" + yyyy);
    }
    $("#pagging").getPagging();
    $("#paggingPopUp").getPagging();
    $(".addPatentTransactionRow").click('click', function(e) {
        var rowCount = $('#patentTransactionTable tbody').length;
        if (eval(rowCount) == 20) {
            alert('Maximum 20 Rows Allowed');
            $('#patentTransactionTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else {
            addPatentTransaction();
        }
    });
    $(".dPatentTransactionRow").click('click', function(e) {
        if ($('#deleteStatus').val() != '0') {
            if (eval($('.patentTransactionRow1').length) == 1) {
                $("#memberID1").val("0");
                $("#memberType1").val("");
                $("#departmentCode1").val("");
                $("#memberName1").val("");
                $("#choose1").html("");
                $("#departmentName1").val("");
            }
            else {
                $(this).parent().parent().parent().remove();
                var lR = $(this).attr('id').substring(21);
                $("#dPatentTransactionRow" + (eval(lR) - 1)).show();
            }
        } else {
            alert('No Authority To Delete');
        }
    });
    $("#patentTransactionTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    $("#facultyNamestable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
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
}



function addPatentTransaction(){
    var lRow = $('[name="memberName"]').last().attr('id').substring(10);
    var newRow = $('.patentTransactionRow1:eq(0)').clone(true);
    newRow.insertAfter($('.patentTransactionRow1:last'));
    $(".patentTransactionRow1").each(function(rowNumber, currentRow) {
        $("*", currentRow).each(function() {
            if (this.id.match(/(\d+)+$/)) {
                this.id = this.id.replace(RegExp.$1, rowNumber + 1);
            }
            if (currentRow == newRow.get(0))
            {
                switch (this.name)
                {
                    case 'memberID':
                        {
                            $(this).val("0");
                            break;
                        }
                    case 'memberType':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'departmentCode':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'memberName':
                        {
                            $(this).val("")
                            break;
                        }
                    case 'departmentName':
                        {
                            $(this).val("");
                            break;
                        }
                }
            }
        });
    });
    $("#choose" + (eval(lRow) + 1)).html("");
    $("#row" + (eval(lRow) + 1)).html(eval(lRow) + 1 + ".");
    $("#dPatentTransactionRow" + (eval(lRow))).hide();
    $("#dPatentTransactionRow" + (eval(lRow) + 1)).show();
    
}

$(function() {
    $("#facultyNames").dialog({
        autoOpen: false,
        show: {
            effect: "blind",
            duration: 1000
        },
        hide: {
            effect: "explode",
            duration: 1000
        },
        width: $(window).width() - 130,
        height: 300

    });
    $("#memberName1").click(function() {
        $("#facultyNames").dialog("open");
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

function getStaffNames(pno)
{
    var totIDS = 0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectStaffInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    jData.spg = pno;
    var lRow = $('[name="memberName"]').last().attr('id').substring(10);
    for (var x = 1; x <= lRow; x++)
    {
        totIDS = totIDS + "," + $("#memberID" + x).val();
    }
    var arr = totIDS.split(",");
    var str = '';
    for (var y = 0; y < arr.length; y++)
    {
        str = str + "'" + arr[y] + "',";
    }
    str = str.substr(0, str.lastIndexOf(","));
    jData.totalStaffIDS = str;
    jData.departmentID = $("#departmentCombo").val();
    jData.searchNames = $("#searchNames").val();
    jData.service = "PatentTransactionServlet";
    jData.handller = "selectStaffInfo";
    $(document).getServace(jData);

}

function getStudentsInfo(){
    if ($("#member").val() == "S") {
        getStudentNames("0");
    } else
    {
        getStaffNames("0");
    }
}

function getStudentNames(pno)
{
     var totIDS = 0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectStudentInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    jData.spg = pno;
    var lRow = $('[name="memberName"]').last().attr('id').substring(10);
    for (var x = 1; x <= lRow; x++)
    {
        totIDS = totIDS + "," + $("#memberID" + x).val();
    }
    var arr = totIDS.split(",");
    var str = '';
    for (var y = 0; y < arr.length; y++)
    {
        str = str + "'" + arr[y] + "',";
    }
    str = str.substr(0, str.lastIndexOf(","));
    jData.totalStudentIDS = str;
    jData.departmentID = $("#departmentCombo").val();
    jData.searchNames = $("#searchNames").val();
    jData.service = "PatentTransactionServlet";
    jData.handller = "selectStudentInfo";
    $(document).getServace(jData);
}

function getSelectStudentInfoInPopUp(){
    var table = "";
    $("#popupHeader").html("");
    $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Student Names</th><th style='width: 48%'>Department</th>");

    for (var key in selectStudentInfo) {
        table = table + "<tr ondblclick='setNames(" + key + ")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectStudentInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectStudentInfo[key]["memberName"] + "</td><td  style='width: 48%';text-align: left>" + selectStudentInfo[key]["department"] + "</td></tr>";
    }

    $("#facultyNamesBody").html("");
    $("#facultyNamesBody").html("" + table);

    $("#popupHeaderTable").css("width", $("#facultyNamesBody").width());
}

function getSelectStaffInfoInPopUp(){
     var table = "";
    $("#popupHeader").html("");
    $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Faculty Names</th><th style='width: 48%'>Department</th>");

    for (var key in selectStaffInfo) {
        table = table + "<tr ondblclick='setNames(" + key + ")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectStaffInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectStaffInfo[key]["memberName"] + "</td><td  style='width: 48%';text-align: left>" + selectStaffInfo[key]["department"] + "</td></tr>";
    }

    $("#facultyNamesBody").html("");
    $("#facultyNamesBody").html("" + table);

    $("#popupHeaderTable").css("width", $("#facultyNamesBody").width());
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
    if($("#member").val() == "S") {
        $("#memberID" + currRowNo).val(selectStudentInfo[key]["memberID"]);
        $("#memberType" + currRowNo).val(selectStudentInfo[key]["memberType"]);
        $("#choose" + currRowNo).html("<b>" + getType(selectStudentInfo[key]["memberType"]) + "</b>");
        $("#memberName" + currRowNo).val(selectStudentInfo[key]["memberName"]);
        $("#departmentCode" + currRowNo).val(selectStudentInfo[key]["departmentCode"]);
        $("#departmentName" + currRowNo).val(selectStudentInfo[key]["department"]);      
    }else
        {
        $("#memberID" + currRowNo).val(selectStaffInfo[key]["memberID"]);
        $("#memberType" + currRowNo).val(selectStaffInfo[key]["memberType"]);
        $("#choose" + currRowNo).html("<b>" + getType(selectStaffInfo[key]["memberType"]) + "</b>");
        $("#memberName" + currRowNo).val(selectStaffInfo[key]["memberName"]);
        $("#departmentCode" + currRowNo).val(selectStaffInfo[key]["departmentCode"]);
        $("#departmentName" + currRowNo).val(selectStaffInfo[key]["department"]);      
        }
    $("#facultyNames").dialog("close");
}

function formsubmit()
{
    if (jQuery.trim($('#patentCode').val()) == "") {
        alert("Please Enter the Patent Code.");
        $('#patentCode').focus();
        return false;
    }
    
    if (jQuery.trim($('#patentTitle').val()) == "") {
        alert("Please Enter the Patent Title.");
        $('#patentTitle').focus();
        return false;
    }
    if (jQuery.trim($('#patentFee').val()) == "") {
        alert("Please Enter the Patent Fee.");
        $('#patentFee').focus();
        return false;
    }
    if (jQuery.trim($('#natureOfPatent').val()) == 0) {
        alert("Please Select the Nature Of Patent.");
        $('#natureOfPatent').focus();
        return false;
    }
    if (jQuery.trim($('#patentStatus').val()) == 0) {
        alert("Please Select the Patent Status.");
        $('#patentStatus').focus();
        return false;
    }
    if (jQuery.trim($('#patentFilingDate').val()) == "") {
        alert("Please Enter the Patent Filing Date.");
        $('#patentFilingDate').focus();
        return false;
    }
    if (jQuery.trim($('#patentValidTillDate').val()) == "") {
        alert("Please Enter the Patent Valid Till Date.");
        $('#patentValidTillDate').focus();
        return false;
    }
    
    if (jQuery.trim($('#departmentCombo').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentCombo').focus();
        return false;
    }


    var count = 0;
    var lRow = $('[name="memberName"]').last().attr('id').substring(10);
    for (var x = 0; x <= lRow; x++)
    {
        if ($("#memberName" + x).val() != "" && $("#departmentName" + x).val())
        {
            count = 1;
        }
    }
    if (count == 0)
    {
        alert("Please Enter atleast one Faculty/Student Name and Department Name.");
        return false;
    }
    var lRow = $('[name="memberName"]').last().attr('id').substring(10);
    var staffNamesDataList = [];
    for (var i = 1; i <= lRow; i++) {
        if ($("#memberID" + i).val() != "0") {
            var staffNamesData = {};

            staffNamesData.companyID = $("#compsession").val();
            staffNamesData.patentID = $("#patentID").val();
            staffNamesData.employeeType = $("#memberType" + i).val();
            staffNamesData.staffID = $("#memberID" + i).val();
            staffNamesData.departmentCode = $("#departmentCode" + i).val();
            staffNamesData.entryBy = $("#entryBy").val();
            staffNamesDataList.push(staffNamesData);
        }
    }
    jData = {};
    jData.patentID = $("#patentID").val();
    jData.companyID = $("#compsession").val();
    jData.transactionDate = $("#transactionDate").val();
    jData.patentCode = $("#patentCode").val();
    jData.apiScore = $("#apiScore").val();
    jData.patentTitle = $("#patentTitle").val();
    jData.patentFee = $("#patentFee").val();
    jData.natureOfPatent = $("#natureOfPatent").val();
    jData.patentStatus = $("#patentStatus").val();
    jData.patentFilingDate = $("#patentFilingDate").val();
    jData.patentValidTillDate = $("#patentValidTillDate").val();
    jData.patentRemarks = $("#patentRemarks").val();
    jData.entryBy = $("#entryBy").val();
    jData.patentno= $("#patentno").val();
    jData.country= $("#country").val();
    jData.service = "PatentTransactionServlet";
    jData.handller = "saveupdate";
    jData.para = staffNamesDataList;
    $(document).getServace(jData);
}

function resetValues()
{
    $("#patentID").val("0");
    $("#patentCode").val("");
    $("#apiScore").val("");
    $("#patentTitle").val("");
    $("#patentFee").val("");
    $("#natureOfPatent").val("0");
    $("#patentStatus").val("0");
    $("#patentFilingDate").val("");
    $("#patentValidTillDate").val("");
    $("#patentRemarks").val("");
    $("#memberID1").val("0");
    $("#memberType1").val("");
    $("#departmentCode1").val("");
    $("#memberName1").val("");
    $("#departmentName1").val("");
    $("#patentno").val("");
    $("#country").val("");
    $("#departmentCombo").val("");
    $("#departmentCombo").prop("disabled", false);
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
    jData.service = "PatentTransactionServlet";
    jData.handller = "select";

    $(document).getServace(jData);
}

function getGridData() {
    $("#mastergrid").yattable({
        width: "100%",
        height: 200,
        scrolling: "yes"
    });
    var table = "";
    $("#gridhead").html("");
    $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 10%'>Patent Code</th><th style='width: 10%'>Patent Fee</th><th style='width: 10%'>Patent Title</th><th style='width: 10%'>Nature Of Patent</th><th style='width: 15%'>Patent Period</th><th style='width: 10%'>Patent Remarks</th><th style='width: 10%'>API Score</th><th style='width: 10%'>Patent Status</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        var rMarks=gridData[key]["patentRemarks"];
        var apiScore=gridData[key]["apiScore"];
        if (rMarks == null)
        {
            rMarks = "";
        }
        if (apiScore == null)
        {
            apiScore = "";
        }
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 10%'>" + gridData[key]["patentCode"] + "</td><td  style='width: 10%'>" + gridData[key]["patentFee"] + "</td>";
        table = table + "<td  style='width: 10%'>" + gridData[key]["patentTitle"] + "</td><td  style='width: 10%'>" + getPatentNature(gridData[key]["patentNature"]) + "</td><td  style='width: 15%'>" + gridData[key]["patentFilingDate"] + "/" + gridData[key]["patentValidTillDate"] + "</td>";
        table = table + "<td  style='width: 10%'>" + rMarks + "</td><td  style='width: 10%'>" +apiScore+ "</td><td  style='width: 10%'>" + getPatentStatus(gridData[key]["patentStatus"]) + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["patentID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["patentID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function updateMasterRecord(patentid)
{
    jData = {};
    jData.service = "PatentTransactionServlet";
    jData.handller = "SelectforUpdate";
    jData.patentID = patentid;
    $(document).getServace(jData);
}

function deleteMasterRecord(patentid)
{

    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "PatentTransactionServlet";
        jData.handller = "Delete";
        jData.patentID = patentid;
        $(document).getServace(jData);
    }
    else {
    }

}

function getPatentNature(code)
{
    var tempVal = "";
    if (code == "P")
    {
        tempVal = "Provisional";
    } else if (code == "F")
    {
        tempVal = "Full Length";
    } else if (code == "N")
    {
        tempVal = "National";
    } else
    {
        tempVal = "PCT";
    }
    return tempVal;
}

function getPatentStatus(code)
{
    var tempVal = "";
    if (code == "F")
    {
        tempVal = "Filed";
    } else
    {
        tempVal = "Granted";
    }
    return tempVal;
}

function getMemberNames(pNo)
{
 if ($("#member").val() == "S") {
        getStudentNames(pNo);
    } else
    {
        getStaffNames(pNo);
    }   
}

function getVisible()
{
    if ($("#departmentCombo").val() != 0)
    {
        var lRow = $('[name="memberName"]').last().attr('id').substring(10);
        for (var x = 0; x <= lRow; x++)
        {
            $("#memberName" + x).prop("disabled", false);
            $("#departmentName" + x).prop("disabled", false);
        }
        $("#departmentCombo").prop("disabled", true);
    } else
    {
        var lRow = $('[name="memberName"]').last().attr('id').substring(10);
        for (var x = 0; x <= lRow; x++)
        {
            $("#memberName" + x).prop("disabled", true);
            $("#departmentName" + x).prop("disabled", true);
        }
    }
}