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
            $("#transactionDate").val(SelectData["transactionDate"]);
            $("#departmentCombo").val(SelectData["departmentCode"]);
            $("#typeOfWorkDone").val(SelectData["typeOfWorkDone"]);
            $("#detailsOfWorkDone").val(SelectData["detailsOfWorkDone"]);
            $("#forTheYear").val(SelectData["forTheYear"]);
            $("#remarks").val(SelectData["remarks"]);
            
            
            var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
            for (var m = 0; m <= lRow; m++) {
                $('.dinterdisciplinaryRow').trigger('click');
            }
            $("#facultyID" + lRow).attr("id", "facultyID1");
            $("#facultyType" + lRow).attr("id", "facultyType1");
            $("#departmentCode" + lRow).attr("id", "departmentCode1");
            $("#facultyName" + lRow).attr("id", "facultyName1");
            $("#departmentName" + lRow).attr("id", "departmentName1");
            $("#roleOfFaculty" + lRow).attr("id", "roleOfFaculty1");
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
                i++;
            }

            break;
    }
});



function getCommonMasterTable()
{
    $(".nondecimal").numbernondecimal();
    $("#pagging").getPagging();
    $("#paggingPopUp").getPagging();
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
                    case 'departmentName':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'roleOfFaculty':
                        {
                            $(this).val("0");
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
    jData.service = "InterdisciplinaryServlet";
    jData.handller = "selectFacultyInfo";
    $(document).getServace(jData);

}

function getSelectFacultyInfoInPopUp(){
     var table = "";
    $("#popupHeader").html("");
    $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Faculty Names</th><th style='width: 48%'>Department</th>");

    for (var key in selectFacultyInfo) {
        table = table + "<tr ondblclick='setNames(" + key + ")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectFacultyInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectFacultyInfo[key]["facultyName"] + "</td><td  style='width: 48%';text-align: left>" + selectFacultyInfo[key]["departmentName"] + "</td></tr>";
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
        $("#facultyID" + currRowNo).val(selectFacultyInfo[key]["facultyID"]);
        $("#facultyType" + currRowNo).val(selectFacultyInfo[key]["facultyType"]);
        $("#facultyName" + currRowNo).val(selectFacultyInfo[key]["facultyName"]);
        $("#departmentCode" + currRowNo).val(selectFacultyInfo[key]["departmentCode"]);
        $("#departmentName" + currRowNo).val(selectFacultyInfo[key]["departmentName"]);      
        $("#facultyNames").dialog("close");
}

function formsubmit()
{
    if (jQuery.trim($('#departmentCombo').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentCombo').focus();
        return false;
    }
    
    if (jQuery.trim($('#typeOfWorkDone').val()) == 0) {
        alert("Please Select the Type Of The Work Done.");
        $('#typeOfWorkDone').focus();
        return false;
    }
    if (jQuery.trim($('#detailsOfWorkDone').val()) == "") {
        alert("Please Enter the Details Of Work Done.");
        $('#detailsOfWorkDone').focus();
        return false;
    }
    if (jQuery.trim($('#forTheYear').val()) == "") {
        alert("Please Enter the For The Year.");
        $('#forTheYear').focus();
        return false;
    }
    


    var count = 0;
    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    for (var x = 1; x <= lRow; x++)
    {
        if ($("#facultyName" + x).val() != "" && $("#departmentName" + x).val()!="" && $("#roleOfFaculty" + x).val()!=0)
        {
            count = 1;
        }
    }
    
    if (count == 0)
    {
        alert("Please Enter atleast one Faculty Name and Department Name and Select Role Of Faculty.");
        return false;
    }
    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    var facultyNamesDataList = [];
    for (var i = 1; i <= lRow; i++) {
        if ($("#facultyID" + i).val() != "0") {
            var facultyNamesData = {};

            facultyNamesData.companyID = $("#compsession").val();
            facultyNamesData.interdispID = $("#interdispID").val();
            facultyNamesData.transactionDate = $("#transactionDate").val();
            facultyNamesData.facultyType = $("#facultyType" + i).val();
            facultyNamesData.facultyID = $("#facultyID" + i).val();
            facultyNamesData.departmentCode = $("#departmentCode" + i).val();
            facultyNamesData.roleOfFaculty = $("#roleOfFaculty" + i).val();
            facultyNamesData.entryBy = $("#entryBy").val();
            facultyNamesDataList.push(facultyNamesData);
        }
    }
    jData = {};
    jData.interdispID = $("#interdispID").val();
    jData.companyID = $("#compsession").val();
    jData.transactionDate = $("#transactionDate").val();
    jData.departmentCombo = $("#departmentCombo").val();
    jData.typeOfWorkDone = $("#typeOfWorkDone").val();
    jData.forTheYear = $("#forTheYear").val();
    jData.detailsOfWorkDone = $("#detailsOfWorkDone").val();
    jData.remarks = $("#remarks").val();
    jData.entryBy = $("#entryBy").val();

    jData.service = "InterdisciplinaryServlet";
    jData.handller = "saveupdate";
    jData.para = facultyNamesDataList;
    $(document).getServace(jData);
}


function resetValues()
{
    $("#interdispID").val("0");
    $("#departmentCombo").val("");
    $("#typeOfWorkDone").val("0");
    $("#detailsOfWorkDone").val("");
    $("#forTheYear").val("");
    $("#remarks").val("");
    $("#facultyID1").val("0");
    $("#facultyType1").val("");
    $("#departmentCode1").val("");
    $("#facultyName1").val("");
    $("#departmentName1").val("");
    $("#roleOfFaculty1").val("0");
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
    jData.service = "InterdisciplinaryServlet";
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
    $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 10%'>Transaction Date</th><th style='width: 20%'>Department Name</th><th style='width: 15%'>Type Of Work Done</th><th style='width: 20%'>Details Of Work Done</th><th style='width: 10%'>For The Year</th><th style='width: 15%'>Remarks</th><th style='width: 5%'></th>");

    for (var key in gridData) {
        var rMarks=gridData[key]["remarks"];
        if (rMarks == null)
        {
            rMarks = "";
        }
       
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 10%'>" + gridData[key]["transactionDate"] + "</td><td  style='width: 20%'>" + gridData[key]["department"] + "</td>";
        table = table + "<td  style='width: 15%'>" + getType(gridData[key]["typeOfWorkDone"]) + "</td><td  style='width: 20%'>" + gridData[key]["detailsOfWorkDone"] + "</td><td  style='width: 10%'>" + gridData[key]["forTheYear"] + "</td>";
        table = table + "<td  style='width: 15%'>" + rMarks + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["interdispID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function getType(code)
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
}

function updateMasterRecord(intDispID)
{
    jData = {};
    jData.service = "InterdisciplinaryServlet";
    jData.handller = "SelectforUpdate";
    jData.interdispID = intDispID;
    $(document).getServace(jData);
}