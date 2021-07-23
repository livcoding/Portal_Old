/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editorr.
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
            // alert("REFRESH GRID");
            gridData = jQuery.parseJSON(xhr.responseText);
          //  alert(JSON.stringify(SelectData));
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;

        case 'SelectforUpdate':
            var SelectData = {};
            var childData = {};
            var i = 1;
            SelectData = jQuery.parseJSON(xhr.responseText);
           // alert(JSON.stringify(SelectData));
            $("#interdispID").val(SelectData["interdispID"]);
            $("#transactionDate").val(SelectData["transactionDate"]);
            $("#departmentCode").val(SelectData["empNAME"]);
            $("#fIds").val(SelectData["empID"]);
             $("#hubName").val(SelectData["hubName"]);
           //  alert(SelectData.childMap["1"].activity);
             //alert()

            var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
            for (var m = 0; m <= lRow; m++) {
                $('.dinterdisciplinaryRow').trigger('click');
            }
            $("#row" + lRow).attr("id", "row1");
            $("#row1").html("1.");

            childData = SelectData["childMap"];
            for (var key in childData) {
                if (i != 1) {
                    addInterdisciplinaryRow();

                }

                var subrow = childData[i];
                for (var key1 in subrow) {
                    $("#" + key1 + i).val(subrow[key1]);
                }
               // alert(SelectData.childMap[i].activity);
                $("#facultyName"+i).val(SelectData.childMap[i].activity);
                $("#detailName"+i).val(SelectData.childMap[i].detailEvent);
                 $("#eventName"+i).val(SelectData.childMap[i].fSupport);
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
    //alert("START");
     $("#fIds").prop("disabled", true);
      $("#transactionDate").prop("disabled", true);
    $(".nondecimal").numbernondecimal();
    $("#pagging").getPagging();
    $("#paggingPopUp").getPagging();
     $("#departmentNameTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
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
               // $("#facultyType1").val("");
               // $("#detailName1").val("");
               // $("#eventName1").val("");
                $("#facultyName1").val("");
                $("#detailName1").val("");
                $("#eventName1").val("");
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
      // $("#searchNamesDepartment").val("");
        $("#departmentCodes").dialog("open");
        getDepartmentNames("0");

    });
});
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
                    case 'eventName':
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
function getDepartmentNames(pno)
{
// alert("Play Begins From Here");

     var totIDS = 0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectDepartmentInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }

   // jData = {};

    jData.searchNames = $("#searchNamesDepartment").val();
    jData.service = "HubActivityServlet";
    jData.handller = "selectDepartmentInfo";
    $(document).getServace(jData);

}
function getSelectDeparmentInfoInPopUp(){
   // alert("POPUP>>>");
    var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Employee Code </th><th style='width: 48%'>Employee Name </th>");

     for (var key in selectDepartmentInfo) {
        table = table + "<tr ondblclick='setNamesEmployee("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectDepartmentInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectDepartmentInfo[key]["employeecode"] + "</td><td  style='width: 48%;text-align: left'>" + selectDepartmentInfo[key]["employeename"] + "</td></tr>";
    }

    $("#departmentNameBody").html("");
    $("#departmentNameBody").html("" + table);

 $("#popupHeaderTable").css("width",$("#departmentNameBody").width());
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
       getDepartmentNames(0)
        getSelectGridData("0");
    }
});
function setNamesEmployee(key)
{

    $("#departmentCode").val(selectDepartmentInfo[key]["employeename"]);
    $("#fIds").val(selectDepartmentInfo[key]["employeeId"]);
    $("#departmentCodes").dialog("close");

}

function getSelectGridData(pno) {
//alert("TEST");
    jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
     jData.staffID = $("#staffID").val();
    jData.searchbox = $("#searchbox").val();
    jData.service = "HubActivityServlet";
    jData.handller = "select";

    $(document).getServace(jData);
}

function formsubmit()
{

   if (jQuery.trim($('#hubName').val()) == 0) {
        alert("Please Select the Hub Name.");
        $('#hubName').focus();
        return false;
    }
    if (jQuery.trim($('#departmentCode').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentCombo').focus();
        return false;
    }

    var count = 0;
    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    for (var x = 1; x <= lRow; x++)
    {
        if ($("#facultyName" + x).val() != "" && $("#detailName" + x).val()!="" )
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
      //  if ($("#facultyID" + i).val() != "0") {
            var facultyNamesData = {};


            facultyNamesData.facultyID = $("#facultyID" + i).val();
            facultyNamesData.companyID = $("#compsession").val();//COMPANYID
            facultyNamesData.instID = $("#instsession").val();//INSTITUTEID
            facultyNamesData.interdispID = $("#interdispID").val();//TRANSACTIONID
            facultyNamesData.staffID = $("#staffID").val();//APFACULTYID
            facultyNamesData.entryBy = $("#entryBy").val();//ENTRYBY
            facultyNamesData.transactionDate = $("#transactionDate").val();// TRANSACTIONDATE
            facultyNamesData.activity = $("#facultyName" + i).val();//ACTIVITY
            facultyNamesData.detailName = $("#detailName" + i).val();//DETAILEVENT
            facultyNamesData.financeName = $("#eventName" + i).val();//FINANCESUPPORT
            facultyNamesData.transactionDate = $("#transactionDate").val();//TRANSACTIONDATE
            
            facultyNamesDataList.push(facultyNamesData);
       // }
    } 

    jData = {};
    jData.interdispID = $("#interdispID").val(); //TRANSACTIONID
    jData.companyID = $("#compsession").val();//COMPANYID
    jData.transactionDate = $("#transactionDate").val();///TRANSACTIONDATE
    jData .staffID = $("#staffID").val();//APFACULTYID
    jData.entryBy = $("#entryBy").val(); //ENTRYDATE
    jData.instID = $("#instsession").val();//INSTITUTEID
    jData.hubName = $("#hubName").val();//HUBNAME
    jData.fIds = $("#fIds").val();//FACUTLYID
    jData.service = "HubActivityServlet";
    jData.handller = "saveupdate";
    jData.para = facultyNamesDataList;
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
    $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 27%'>Transaction Date</th><th style='width: 27%'>Name of Hub </th><th style='width: 27%'>Faculty co ordinator</th><th style='width: 5%'>Edit</th><th style='width: 5%'>Delete</th>");

    for (var key in gridData) {
        var rMarks=gridData[key]["QUALIFIEDRANK"];
        if (rMarks == null)
        {
            rMarks = "";
        }

        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 26%'>" + gridData[key]["transactionDate"] + "</td><td  style='width: 26%'>" + gridData[key]["hubName"] + "</td>";
        table = table + "<td  style='width: 26%'>" + gridData[key]["employeeName"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["interdispID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["interdispID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}
function updateMasterRecord(intDispID)
{
 
    jData = {};
    jData.service = "HubActivityServlet";
    jData.handller = "SelectforUpdate";
    jData.interdispID = intDispID;
    $(document).getServace(jData);
}
function resetValues()
{
    $("#interdispID").val("0");
    $("#hubName").val("");
    $("#departmentCode").val("");
    $("#fIds").val("");
    $("#facultyName1").val("");
    $("#detailName1").val("");
    $("#eventName1").val("");

    location.reload();
}

function deleteMasterRecord(intDispID)
{
   var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "HubActivityServlet";
        jData.handller = "Delete";
        jData.interdispID = intDispID;
        $(document).getServace(jData);
    }
    else {
    }

}
