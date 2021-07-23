/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var rc = 0;
var cupage = {};
var gridData = {};
var currRowNo=0;
var selectFacultyInfo = {};
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

          case 'selectDepartmentInfo':
            selectDepartmentInfo = jQuery.parseJSON(xhr.responseText);
            getSelectDeparmentInfoInPopUp(selectDepartmentInfo);
           // $('#TOTALStudent').html("Total No.of Record(s): " + selectDepartmentInfo[1].totalrecords);
            break;
        case 'selectFacultyInfo':
            selectFacultyInfo = jQuery.parseJSON(xhr.responseText);
            getSelectFacultyInfoInPopUp(selectFacultyInfo);
            $('#TOTAL').html("Total No.of Record(s): " + selectFacultyInfo[1].totalrecords);
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
        $("#interdispID").val(SelectData["interdispID"]);
           // alert("UPPOOLLLLL");
           // alert(JSON.stringify(SelectData));
           $("#transactionDate").val(SelectData["transactionDate"]);
            $("#departmentCode").val(SelectData["departmentCode"]);
           $("#departmentDesc").val(SelectData["department"]);
//
            var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
            for (var m = 0; m <= lRow; m++) {
               $('.dinterdisciplinaryRow').trigger('click');
            }
//            $("#facultyID" + lRow).attr("id", "facultyID1");
//            $("#facultyType" + lRow).attr("id", "facultyType1");
//            $("#departmentCode" + lRow).attr("id", "departmentCode1");
//            $("#facultyName" + lRow).attr("id", "facultyName1");
//            $("#departmentName" + lRow).attr("id", "departmentName1");
//            $("#roleOfFaculty" + lRow).attr("id", "roleOfFaculty1");
//               $("#range" + lRow).attr("id", "range1");
//            $("#row" + lRow).attr("id", "row1");
//            $("#row1").html("1.");

            childData = SelectData["childMap"];
            for (var key in childData) {
                if (i != 1) {
                    addInterdisciplinaryRow();
                }
                $("#facultyName"+i).val(SelectData.childMap[i].facultyName);

                if (SelectData.childMap[i].awdetail == 'A')

            {
               $("#detailName"+i).val(SelectData.childMap[i].detailName);
               $("#activeY").prop("checked", true);
               $("#detailName1").attr('disabled',true);
               $("#yearName1").attr('disabled',true);
               $("#rankName1").attr('disabled',true);
                $("#eventName1").attr('disabled',true);
                   $("#awardName1").attr('disabled',true);
                // alert("HELLOOUUULLL");
            } else
            {
                //  alert("hiiiiOOO");
                $("#examName"+i).val(SelectData.childMap[i].detailName);
                 $("#activeN").prop("checked", true);
                 $("#examName1").attr('disabled',true);
                  $("#eventName1").attr('disabled',true);
                   $("#awardName1").attr('disabled',true);
                    $("#yearName1").attr('disabled',true);
               $("#rankName1").attr('disabled',true);
                // alert("KKKKKUKKK");
            }
                
                 $("#eventName"+i).val(SelectData.childMap[i].eventName);
                 $("#awardName"+i).val(SelectData.childMap[i].awardName);
                 $("#yearName"+i).val(SelectData.childMap[i].yearName);
                 $("#rankName"+i).val(SelectData.childMap[i].rankName);


//                var subrow = childData[i];
//                for (var key1 in subrow) {
//                    $("#" + key1 + i).val(subrow[key1]);
//                }
                i++;
            }

            break;
    }
});



function getCommonMasterTable()
{
  //  alert("BABUBAJRANGIJI");
    $(".nondecimal").numbernondecimal();
    $("#pagging").getPagging();
    $("#paggingPopUp").getPagging();
     $("#departmentNameTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
     $("#detailName1").prop("disabled", true);
      $("#examName1").prop("disabled", true);
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

    $(".addinterdisciplinaryRow").click('click', function(e) {
        var rowCount = $('#interdisciplinaryTable tbody').length;
        if (eval(rowCount) == 20) {
            alert('Maximum 20 Rows Allowed');
            $('#interdisciplinaryTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else {
            addInterdisciplinaryRow();
        }
    });
    $(".dinterdisciplinaryRow").click('click', function(e) {
        if ($('#deleteStatus').val() != '0') {
            if (eval($('.interdisciplinaryRow1').length) == 1) {
                $("#facultyID1").val("0");
                $("#facultyType1").val("");
                $("#departmentCode1").val("");
                $("#facultyName1").val("");
                $("#departmentName1").val("");
                $("#roleOfFaculty1").val("0");
                $("#range1").val("0");
            }
            else {
                $(this).parent().parent().parent().remove();
                var lR = $(this).attr('id').substring(21);
                $("#dinterdisciplinaryRow" + (eval(lR) - 1)).show();
            }
        } else {
            alert('No Authority To Delete');
        }
    });
    $("#interdisciplinaryTable").yattable({
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
$("#activeY").click(function(){
  $("#awardName1").prop("disabled","true");
});

 function getHeadData() 
{
    alert("DISABLE EXAMSSSSSS");
   // $('input[name=title_format]').click(function()  {
    //$('input[name=doc-title]').value('Title changed to 2');
//};
//alert("...............");examName1
   //
    if ($("#activeY").prop("checked", true)) {
        $("#examName1").attr('disabled',true);
         $("#detailName1").attr('disabled',false);
         $("#yearName1").attr('disabled',true);
          $("#rankName1").attr('disabled',true);
          $("#eventName1").attr('disabled',false);
          $("#awardName1").attr('disabled',false);
       //  $("#detailHeader").html( "Detail of Awards");

    }
}
function getHeadData1()
{
alert("HIIIIeee...............");
   //
    if ($("#activeN").prop("checked", true)) {
         $("#eventName1").attr('disabled',true);
         $("#detailName1").attr('disabled',true);
          $("#awardName1").attr('disabled',true);
           $("#yearName1").attr('disabled',false);
          $("#rankName1").attr('disabled',false);
           $("#examName1").attr('disabled',false);
         // $("#detailHeader").html( "Name of competitive exam");

    }
    }
function addInterdisciplinaryRow(){
    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    var newRow = $('.interdisciplinaryRow1:eq(0)').clone(true);
    newRow.insertAfter($('.interdisciplinaryRow1:last'));
    $(".interdisciplinaryRow1").each(function(rowNumber, currentRow) {
        $("*", currentRow).each(function() {
            if (this.id.match(/(\d+)+$/)) {
                this.id = this.id.replace(RegExp.$1, rowNumber + 1);
            }
            if (currentRow == newRow.get(0))
            {
                switch (this.name)
                {
                    case 'facultyID':
                        {
                            $(this).val("0");
                            break;
                        }
                    case 'facultyType':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'departmentCode':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'facultyName':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'detailName':
                        {
                            $(this).val("");
                            break;
                        }
                          case 'examName':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'eventName':
                        {
                            $(this).val("");
                            break;
                        }
                        case 'awardName':
                            {
                                $(this).val("");
                                break;

                            }
                            case 'yearName':
                            {
                                $(this).val("");
                                break;

                            }
                            case 'rankName':
                            {
                                $(this).val("");
                                break;

                            }
                }
            }
        });
    });
    $("#row" + (eval(lRow) + 1)).html(eval(lRow) + 1 + ".");
    $("#dinterdisciplinaryRow" + (eval(lRow))).hide();
    $("#dinterdisciplinaryRow" + (eval(lRow) + 1)).show();

}
$(function() {
    $("#departmentCodes").dialog({
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
    $("#departmentCode").click(function() {
       // $("#searchNamesStudent").val("");
        $("#departmentCodes").dialog("open");
        getDepartmentNames("0");

    });
});

function getDepartmentNames(pno)
{
     jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectDepartmentInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }

    jData = {};

    jData.searchNames = $("#searchNamesStudent").val();
    jData.service = "AwardAndAchievementtServlet";
    jData.handller = "selectDepartmentInfo";
    $(document).getServace(jData);

}
function setNamesDepartments(key)
{

    $("#departmentCode").val(selectDepartmentInfo[key]["departmentName"]);
    $("#departmentDesc").val(selectDepartmentInfo[key]["departmentDesc"]);
    $("#departmentCodes").dialog("close");


}


function getSelectDeparmentInfoInPopUp(){
     var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Department Code</th><th style='width: 48%'>Department Desc</th>");

     for (var key in selectDepartmentInfo) {
        table = table + "<tr ondblclick='setNamesDepartments("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectDepartmentInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectDepartmentInfo[key]["departmentName"] + "</td><td  style='width: 48%;text-align: left'>" + selectDepartmentInfo[key]["departmentDesc"] + "</td></tr>";
    }

    $("#departmentNameBody").html("");
    $("#departmentNameBody").html("" + table);

 $("#popupHeaderTable").css("width",$("#departmentNameBody").width());
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
    $("#facultyName1").click(function() {
        $("#facultyNames").dialog("open");
        currRowNo = (this.id).substr(11, 1);
        $("#searchNames").val("");
        getFacultyNames("0");
    });
});

function getFacultyNames(pno)
{
    var totIDS = 0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectFacultyInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    jData.spg = pno;
    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    for (var x = 1; x <= lRow; x++)
    {
        totIDS = totIDS + "," + $("#facultyID" + x).val();
    }
    var arr = totIDS.split(",");
    var str = '';
    for (var y = 0; y < arr.length; y++)
    {
        str = str + "'" + arr[y] + "',";
    }
    str = str.substr(0, str.lastIndexOf(","));
    jData.totalStaffIDS = str;
    jData.searchNames = $("#searchNames").val();
    jData.service = "AwardAndAchievementtServlet";
    jData.handller = "selectFacultyInfo";
    $(document).getServace(jData);

}

function getSelectFacultyInfoInPopUp(){
     var table = "";
    $("#popupHeader").html("");
    $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Faculty Names</th><th style='width: 48%'>Department</th>");

    for (var key in selectFacultyInfo) {
        table = table + "<tr ondblclick='setNames(" + key + ")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectFacultyInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectFacultyInfo[key]["studentName"] + "</td><td  style='width: 47%;text-align: left'>" + selectFacultyInfo[key]["enrollmentNo"] + "</td></tr>";
    }

    $("#facultyNamesBody").html("");
    $("#facultyNamesBody").html("" + table);

    $("#popupHeaderTable").css("width", $("#facultyNamesBody").width());
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
        getFacultyNames("0");
        getSelectGridData("0");
    }
});

function setNames(key)
{
        $("#facultyID" + currRowNo).val(selectFacultyInfo[key]["studentID"]);
        $("#facultyName" + currRowNo).val(selectFacultyInfo[key]["studentName"]);
       // $("#facultyName" + currRowNo).val(selectFacultyInfo[key]["facultyName"]);
       // $("#departmentCode" + currRowNo).val(selectFacultyInfo[key]["departmentCode"]);
       // $("#departmentName" + currRowNo).val(selectFacultyInfo[key]["departmentName"]);
        $("#facultyNames").dialog("close");
}

function formsubmit()
{
    alert("BABU");
    if (jQuery.trim($('#departmentCode').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentCombo').focus();
        return false;
    }

    var count = 0;
    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    for (var x = 1; x <= lRow; x++)
    {
        if ($("#facultyName" + x).val() != ""  )
        {
            count = 1;
        }
    }

    if (count == 0)
    {
        alert("Please Enter atleast one Faculty Name and detailName and eventName and rankName.....");
        return false;
    }
    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    var facultyNamesDataList = [];
    for (var i = 1; i <= lRow; i++) {
        if ($("#facultyID" + i).val() != "0") {
            var facultyNamesData = {};

            facultyNamesData.companyID = $("#compsession").val();
            facultyNamesData.instID = $("#instsession").val();
            facultyNamesData.interdispID = $("#interdispID").val();
            facultyNamesData.staffID = $("#staffID").val();
            facultyNamesData.transactionDate = $("#transactionDate").val();
            facultyNamesData.facultyID = $("#facultyID" + i).val();
            facultyNamesData.departmentCode = $("#departmentCode").val();
          //  facultyNamesData.detailName = $("#detailName" + i).val();
            facultyNamesData.eventName = $("#eventName" + i).val();
            facultyNamesData.awardName = $("#awardName" + i).val();
            facultyNamesData.yearName = $("#yearName" + i).val();
            facultyNamesData.rankName = $("#rankName" + i).val();
            facultyNamesData.transactionDate = $("#transactionDate").val();
              if ($("#activeY").prop("checked")) {
        facultyNamesData.type="A";
         facultyNamesData.detailName = $("#detailName" + i).val();
    }
   else if ($("#activeN").prop("checked")) {
        facultyNamesData.type="E";
        facultyNamesData.detailName = $("#examName" + i).val();
    }
    else {
         facultyNamesData.type="";
//facultyNamesData.detailName = $("#examName" + i).val();
    }
            facultyNamesDataList.push(facultyNamesData);
        }
    }

    jData = {};
    jData.interdispID = $("#interdispID").val(); //TRANSACTIONID
    jData.companyID = $("#compsession").val();//INSTITUTEID
    jData.transactionDate = $("#transactionDate").val();///TRANSACTIONDATE
    jData .staffID = $("#staffID").val();//APFACULTYID
    jData.departmentCode = $("#departmentCode").val();// DEPARTMENTCODE
    jData.entryBy = $("#entryBy").val(); //ENTRYDATE
    jData.instID = $("#instsession").val();//COMPANYID
    jData.service = "AwardAndAchievementtServlet";
    jData.handller = "saveupdate";
    jData.para = facultyNamesDataList;
    $(document).getServace(jData);
}


function resetValues()
{
    $("#interdispID").val("0");
    $("#departmentCode").val("");
    $("#departmentDesc").val("");
    $("#facultyName1").val("");
    $("#detailName1").val("");
    $("#eventName1").val("");
    $("#awardName1").val("");
    $("#yearName1").val("");
    $("#rankName1").val("");

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
    jData.staffID = $("#staffID").val();
    jData.searchbox = $("#searchbox").val();
    jData.service = "AwardAndAchievementtServlet";
    jData.handller = "select";

    $(document).getServace(jData);
}

function getGridData() {
   // alert("GRIDDDDDDD");
    $("#mastergrid").yattable({
        width: "100%",
        height: 200,
        scrolling: "yes"
    });
    var table = "";
    $("#gridhead").html("");
    $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 15%'>Transaction Date</th><th style='width: 15%'>Department Name</th><th style='width: 15%'>Student Nameeee</th><th style='width: 10%'>Details</th><th style='width: 10%'>Rank</th><th style='width: 5%'>Edit</th>");

    for (var key in gridData) {
        var rMarks=gridData[key]["QUALIFIEDRANK"];
        if (rMarks == null)
        {
            rMarks = "";
        }

        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 15%'>" + gridData[key]["transactionDate"] + "</td><td  style='width: 15%'>" + gridData[key]["department"] + "</td>";
        table = table + "<td  style='width: 15%'>" + gridData[key]["STUDENTNAME"] + "</td><td  style='width: 10%'>" + gridData[key]["DETAILAWARD"] + "</td>";
        table = table + "<td  style='width: 10%'>" + rMarks + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["interdispID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

/* function getType(code)
{
    var temp = "";
    if (code == "T")
    {
        temp = "[T]hesis Supervised";
    } else if (code == "D")
    {
        temp = "[D]issertation Supervised";
    } else
    {
        temp = "[P]ublication";
    }
    return temp;
} */

function updateMasterRecord(intDispID)
{
    jData = {};
    jData.service = "AwardAndAchievementtServlet";
    jData.handller = "SelectforUpdate";
    jData.interdispID = intDispID;
    $(document).getServace(jData);
}