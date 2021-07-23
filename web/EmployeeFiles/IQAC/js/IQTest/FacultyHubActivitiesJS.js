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
            //  alert("FACULTY");
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
        case 'selectForUpdate':
            var SelectData = {};
            var childData = {};
            var i = 1;
           
            SelectData = jQuery.parseJSON(xhr.responseText);
            // alert(JSON.stringify(SelectData));
            $("#interdispID").val(SelectData["interdispID"]);
            //  alert($("#interdispID").val());
            $("#transactionDate").val(SelectData["transactionDate"])
            $("#classCode").val(SelectData["class"]);//departmentCode
            $("#bsCode").val(SelectData["batch"]);
            $("#degree").val(SelectData["degree"]);
            $("#degree").val(SelectData["degree"]);
            $("#departmentCode").val(SelectData["department"]);
          //  alert($("#departmentCode").val());
          
            //alert($("#departmentCode").val());
//                        var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
//                        for (var m = 0; m <= lRow; m++) {
//                            $('.dinterdisciplinaryRow').trigger('click');
//                        }
                        //$("#facultyID" + 1).attr("id", "facultyID1");
                        $("#facultyType" + 1).attr("id", "facultyType1");
                        $("#departmentCode" + 1).attr("id", "departmentCode1");
                        $("#facultyName" + 1).attr("id", "facultyName1");
                        $("#departmentName" + 1).attr("id", "departmentName1");
                        $("#roleOfFaculty" + 1).attr("id", "roleOfFaculty1");
                           $("#range" + 1).attr("id", "range1");
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
   // alert("JSPONLOADjs")
    //alert("GRIDDATA    ");
  //  alert("HELLO!!!!!!!!!!!!!");
    //  $("#activeY").prop("checked", true);
    $(".nondecimal").numbernondecimal();
    $("#pagging").getPagging();
    $("#paggingPopUp").getPagging();
    
   
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
    // alert("GRIDDATA");
    getSelectGridData("0");
    cupage.pr = 0;
    $("#previous").hide();
    $("#first").hide();

    //alert("DATE");
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
//$("#activeY").click(function(){
//  $("#awardName1").prop("disabled","true");
//});

function getHeadData()
{
   // alert("HELLOUUUUU");
    if ($("#activeY").prop("checked", true)) {
        $("#instName1").attr('disabled',false);
        $("#tName1").attr('disabled',false);
        $("#dName1").attr('disabled',false);
        $("#sName1").attr('disabled',false);
        $("#toainstName1").attr('disabled',true);
        $("#nofName1").attr('disabled',true);
        $("#dspName1").attr('disabled',true);
        $("#yoiName1").attr('disabled',true);
    //  $("#detailHeader").html( "Name of Institute/Org/Univ");
    //$("#did").html("Degree");
    // $("#spid").html("Specialization (Area/Branch/Field)");
    }
}
function getHeadData1()
{
    //alert("BUTTON CLICK");
    //
    if ($("#activeN").prop("checked", true)) {
        $("#toainstName1").attr('disabled',false);
        $("#nofName1").attr('disabled',false);
        $("#dspName1").attr('disabled',false);
        $("#yoiName1").attr('disabled',false);
        $("#instName1").attr('disabled',true);
        $("#tName1").attr('disabled',true);
        $("#dName1").attr('disabled',true);
        $("#sName1").attr('disabled',true);
    // $("#detailHeader").html( "Type of Activity / firm Establishment");
    // $("#did").html("Year of Initiation");
    //$("#spid").html(" Deliverables Services /Product");
    }
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
    //  alert($("#departmentCode").val());
 
    var totIDS = 0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectFacultyInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    jData.spg = pno;
    //    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    //    for (var x = 1; x <= lRow; x++)
    //    {
    //        totIDS = totIDS + "," + $("#facultyID" + x).val();
    //    }
    //    var arr = totIDS.split(",");
    //    var str = '';
    //    for (var y = 0; y < arr.length; y++)
    //    {
    //        str = str + "'" + arr[y] + "',";
    //    }
    //    str = str.substr(0, str.lastIndexOf(","));
    //    jData.totalStudentIDS = str;z
    
    jData.departmentID = $("#departmentCode").val();
    jData.instID = $("#instsession").val();
    jData.searchNames = $("#searchNames").val();
    jData.service = "FacultyHubActivitiesServlet";
    jData.handller = "selectFacultyInfo";
    $(document).getServace(jData);

}
function setNames(key)
{
 //   alert(selectFacultyInfo[key]["studentID"]);
    $("#facultyID" + currRowNo).val(selectFacultyInfo[key]["studentID"]);
   // alert($("#facultyID" + currRowNo).val());
    $("#facultyName" + currRowNo).val(selectFacultyInfo[key]["studentName"]);
    $("#facultyNames").dialog("close");
}


function getSelectFacultyInfoInPopUp(){  
    //alert("POPUPPPPPPPPPPPP");
    var table = "";
    $("#popupHeader").html("");
    $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Student Names</th><th style='width: 48%'>Enrollment No.</th>");

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
function getSelectGridData(pno) {

    jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
    jData.service = "FacultyHubActivitiesServlet";
    jData.handller = "select";

    $(document).getServace(jData);
}

function getGridData() {
   // alert("GRID");
    $("#mastergrid").yattable({
        width: "100%",
        height: 200,
        scrolling: "yes"
    });
    var table = "";
    $("#gridhead").html("");
    $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 47%'>Name of Student/Faculty </th><th style='width: 48%'>Student Type</th>");

    for (var key in gridData) {
        var rMarks=gridData[key]["QUALIFIEDRANK"];
        if (rMarks == null)
        {
            rMarks = "";
        }

        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["rowNO"] + "</td><td  style='width: 45%'>" + gridData[key]["STUDENTNAME"] + "</td><td  style='width: 39%'>" + gridData[key]["STUDENTTYPE"] + "</td>";
        // table = table + "<td  style='width: 10%'>" + rMarks + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["interdispID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}
function updateMasterRecord(intDispID)
{
    // alert("TEST GRID DATA");
    jData = {};
    jData.service = "FacultyHubActivitiesServlet";
    jData.handller = "selectForUpdate";
    jData.interdispID = intDispID;
    $(document).getServace(jData);
}

function formsubmit()
{
  //  alert("MANDETORY");
//        if (jQuery.trim($('#classCode').val()) == 0) {
//            alert("Please Select the Class Field Name.....");
//            $('#classCode').focus();
//            return false;
//          }

//    if (jQuery.trim($('#bsCode').val()) == 0) {
//        alert("Please Select the Section/Batch Field Name.");  
//        $('#bsCode').focus();
//        return false;
//    }

    if (jQuery.trim($('#degree').val()) == 0) {
        alert("Please Select the DegreeField from drop/Down Name.");
        $('#degree').focus();
        return false;
    }
    if (jQuery.trim($('#departmentCode').val()) == 0) {
        alert("Please Select the Department Field Name......");
        $('#departmentCode').focus();
        return false;
    }
    var count = 0;
    //    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    //    for (var x = 1; x <= lRow; x++)
    //    {
    //        if ($("#facultyName" + x).val() != "" && $("#detailName" + x).val()!="" )
    //        {
    //            count = 1;
    //        }
    //    }
    //
    //    if (count == 0)
    //    {
    //        alert("Please Enter atleast one Faculty Name and detailName and eventName and rankName.....");
    //        return false;
    //    }
    //    var lRow = $('[name="facultyName"]').last().attr('id').substring(11);
    var facultyNamesDataList = [];
   
    if ($("#facultyID").val() != "0") {
        //classCode bsCode degree departmentCode       instName toainstName tName nofName dName dspName sName yoiName
        var facultyNamesData = {};
        //          ENTRYBY  ENTRYDATE
        facultyNamesData.companyID = $("#compsession").val();//COMPANYID
        facultyNamesData.instID = $("#instsession").val();//INSTITUTEID
        facultyNamesData.interdispID = $("#interdispID").val();//TRANSACTIONID
        facultyNamesData.staffID = $("#staffID").val();//FACULTYID
        facultyNamesData.transactionDate = $("#transactionDate").val();//TRANSACTIONDATE
        facultyNamesData.studentID = $("#facultyID"+1).val();// APFACULTYID instName
        facultyNamesData.instName = $("#instName"+1).val();
        facultyNamesData.toainstName = $("#toainstName"+1).val();
      //  alert($("#toainstName"+1).val());
        facultyNamesData.tName = $("#tName"+1).val();
        facultyNamesData.nofName = $("#nofName"+1).val();
        facultyNamesData.dName = $("#dName"+1).val();
        facultyNamesData.dspName = $("#dspName"+1).val();
        facultyNamesData.sName = $("#sName"+1).val();
        facultyNamesData.yoiName = $("#yoiName"+1).val();
        facultyNamesData.departmentCode = $("#departmentCode").val();// DEPARTMENTCODE

        // alert( $("#facultyID").val());
        //facultyNamesData.studentID=$("#facultyID").val();
        //            facultyNamesData.yearName = $("#sName1" + i).val();
        //            facultyNamesData.rankName = $("#rankName" + i).val();
        //  alert($("#departmentCode").val());
        if ($("#activeY").prop("checked")) {
            facultyNamesData.type="S";
        }
        else if ($("#activeN").prop("checked")) {
            facultyNamesData.type="E";
        }
        else {
            facultyNamesData.type="";

        }
        facultyNamesDataList.push(facultyNamesData);
    }
    
    //alert(JSON.stringify(facultyNamesDataList));
    jData = {};
    jData.interdispID = $("#interdispID").val(); //TRANSACTIONID
    jData.companyID = $("#compsession").val();//INSTITUTEID
    jData.transactionDate = $("#transactionDate").val();///TRANSACTIONDATE
    jData .staffID = $("#staffID").val();//APFACULTYID
    jData.studentID = $("#facultyID").val();
    jData.departmentCode = $("#departmentCode").val();// DEPARTMENTCODE
    jData.entryBy = $("#entryBy").val(); //ENTRYDATE
    jData.instID = $("#instsession").val();//COMPANYID
    jData.cName = $("#classCode").val();//CLASS
    jData.bsName = $("#bsCode").val();//BATCH
    jData.degree = $("#degree").val();//DEGREE
    jData.service = "FacultyHubActivitiesServlet";
    jData.handller = "saveupdate";
   
    jData.para = facultyNamesDataList;

    $(document).getServace(jData);
}

