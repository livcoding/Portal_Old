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

        case 'formNameCombo':
            $("#formName").empty();
            $("#formName").append(xhr.responseText);
            break;
        case 'saveupdate':
            resetValues();
            break;
        case 'Delete':
            getSelectGridData(cupage.pr);
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;
        case 'SelectforUpdate':
            var selectData = jQuery.parseJSON(xhr.responseText);
            $("#eventID").val(selectData["eventID"]);
            $("#categoryName").val(selectData["categoryID"]);
            getFormInfo(selectData["formID"]);
            $("#academicYear").val(selectData["academicYear"]);
            $("#eventCode").val(selectData["eventCode"]);
            $("#eventFromDate").val(selectData["eventFromDate"]);
            $("#eventToDate").val(selectData["eventToDate"]);
            $("#eventDescription").val(selectData["eventDescription"]);
            if (selectData["deactive"] == 'Y')
            {
                $("#activeY").prop("checked", true);
            } else
            {
                $("#activeN").prop("checked", true)
            }
            break;
    }
});



function getCommonMasterTable()
{
    getFormInfo();
    $("#activeN").prop("checked", true);
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
    
}


function getFormInfo(formID)
{
    
    jData = {};
    jData.service = "EventMasterServlet";
    jData.handller = "formNameCombo";
    jData.categoryID = $("#categoryName").val();
    if (formID != undefined)
    {
        jData.formID = formID;
    }
    if (formID == undefined)
    {
        jData.formID = "0";
    }
    $(document).getServace(jData);
}

function formsubmit()
{
    if (jQuery.trim($('#categoryName').val()) == 0) {
        alert("Please Select the Category Name.");
        $('#categoryName').focus();
        return false;
    } 
    if (jQuery.trim($('#formName').val()) == 0) {
        alert("Please Select the Form Name.");
        $('#formName').focus();
        return false;
    } 
    if (jQuery.trim($('#academicYear').val()) == 0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        return false;
    } 
    if (jQuery.trim($('#eventCode').val()) == "") {
        alert("Please Enter the Event Code.");
        $('#eventCode').focus();
        return false;
    } 
    if (jQuery.trim($('#eventFromDate').val()) == "") {
        alert("Please Enter the Event From Date.");
        $('#eventFromDate').focus();
        return false;
    } 
    if (jQuery.trim($('#eventToDate').val()) == "") {
        alert("Please Enter the Event To Date.");
        $('#eventToDate').focus();
        return false;
    } 
    if (jQuery.trim($('#eventDescription').val()) =="") {
        alert("Please Enter the Event Description.");
        $('#eventDescription').focus();
        return false;
    } 
    
    if ($('input[name=active]:checked').length <= 0)
    {
        alert("Please choose Deactive Y/N.");
        return false;
    }
    
    jData = {};
    jData.eventID = $("#eventID").val();
    jData.companyid = $("#compsession").val();
    jData.categoryName = $("#categoryName").val();
    jData.formName=$("#formName").val();
    jData.academicYear=$("#academicYear").val();
    jData.eventCode=$("#eventCode").val();
    jData.eventFromDate=$("#eventFromDate").val();
    jData.eventToDate=$("#eventToDate").val();
    jData.eventDescription=$("#eventDescription").val();
    if ($("#activeY").prop("checked")) {
        jData.deactive="Y";
    }
    if ($("#activeN").prop("checked")) {
        jData.deactive="N";
    }
    jData.entryBy = $("#entryBy").val();
    jData.service = "EventMasterServlet";
    jData.handller = "saveupdate";
    $(document).getServace(jData);  
}

function resetValues()
{
    $("#eventID").val("0");
    $("#categoryName").val("");
    $("#formName").val("");
    $("#academicYear").val("");
    $("#eventCode").val("");
    $("#eventFromDate").val("");
    $("#eventToDate").val("");
    $("#eventDescription").val("");
    $("input:radio").attr("checked", false);
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
    jData.service = "EventMasterServlet";
    jData.handller = "select";
    $(document).getServace(jData);
}

function getGridData() {
    $("#mastergrid").yattable({
        width: "100%",
        height: 300,
        scrolling: "yes"
    });
    var table = "";
    var rMarks="";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 12%'>Category Name</th><th style='width: 12%'>Academic Year</th><th style='width: 12%'>Event Code</th><th style='width: 18%'>Event Description</th><th style='width: 12%'>Event From Date</th><th style='width: 12%'>Event To Date</th><th style='width: 7%'>Deactive</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 12%'>" + gridData[key]["category"] + "</td><td  style='width: 12%'>" + gridData[key]["academicYear"] + "</td><td  style='width: 12%'>" + gridData[key]["eventCode"] + "</td>";
        table = table + "<td  style='width: 18%'>" + gridData[key]["eventDescription"] + "</td><td  style='width: 12%'>" + gridData[key]["eventFromDate"] + "</td><td  style='width: 12%'>" + gridData[key]["eventToDate"] + "</td>";
        table = table + "<td  style='width: 7%'>" + gridData[key]["deactive"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["eventID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["eventID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function updateMasterRecord(eventID)
{
    jData = {};
    jData.service = "EventMasterServlet";
    jData.handller = "SelectforUpdate";
    jData.eventID = eventID;
    $(document).getServace(jData);
}


$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getSelectGridData("0");
    }
});

function deleteMasterRecord(eveID)
{
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

    jData = {};
    jData.service = "EventMasterServlet";
    jData.handller = "Delete";
    jData.eventID = eveID;
    $(document).getServace(jData);
    }
    else {
    }
}
