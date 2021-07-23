/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var rc = 0;
var gridData = {};
var cupage = {};
function getCommonMasterTable() {
    $("#pagging").getPagging();
     getSelectGridData("0");
    ///////////////////////////////////// 
    cupage.pr = 0;
    $("#previous").hide();
    $("#first").hide();
    
    $("#pagging").click(function() {
        cupage.pr = eval($("#pagging").val());
    });
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
    ///////////////////////////////




}
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
            data: 'jdata=' + JSON.stringify(para),
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

        case 'saveupdate':
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
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#feedbackid").val(SelectData["feedbackid"]);
            $("#examcode").val(SelectData["examcode"]);
            $("#feedbackcode").val(SelectData["feedbackcode"]);
            $("#feedbackdesc").val(SelectData["feedbackdesc"]);
            $("#eventfromdate").val(SelectData["eventfromdate"]);
            $("#eventtodate").val(SelectData["eventtodate"]);
            $("#eventcompleted").prop("checked", SelectData["eventcompleted"] == 'Y' ? true : false);
            $("#eventbroadcast").prop("checked", SelectData["eventbroadcast"] == 'Y' ? true : false);

            $("#feedbackremarks").val(SelectData["feedbackremarks"]);
            break;
        case 'Delete':
            getSelectGridData("0");
            break;

    }
});
function formsubmit()
{
    if (jQuery.trim($('#examcode').val()) == 0) {
        alert("Please Select the Exam Code.");
        $('#examcode').focus();
        return false;
    }
    if (jQuery.trim($('#feedbackcode').val()) == "") {
        alert("Please Enter the Feedback Code.");
        $('#feedbackcode').focus();
        return false;
    }
    if (jQuery.trim($('#feedbackdesc').val()) == "") {
        alert("Please Enter the Feedback Description.");
        $('#feedbackdesc').focus();
        return false;
    }
    if (jQuery.trim($('#eventfromdate').val()) == "") {
        alert("Please Enter the EventFrom Date.");
        $('#eventfromdate').focus();
        return false;
    }
    if (jQuery.trim($('#eventtodate').val()) == "") {
        alert("Please Enter the EventTo Date.");
        $('#eventtodate').focus();
        return false;
    }
    if (jQuery.trim($('#feedbackremarks').val()) == "") {
        alert("Please Enter the Feedback Remarks.");
        $('#feedbackremarks').focus();
        return false;
    }

    var paramatervalue = {};
    paramatervalue.companyid = $("#compsession").val();
    paramatervalue.instituteid = $("#instsession").val();
    paramatervalue.examcode = $("#examcode").val();
    paramatervalue.feedbackcode = $("#feedbackcode").val();
    paramatervalue.feedbackdesc = $("#feedbackdesc").val();
    paramatervalue.eventfromdate = $("#eventfromdate").val();
    paramatervalue.eventtodate = $("#eventtodate").val();
    paramatervalue.feedbackid = $("#feedbackid").val();
    if ($('#eventcompleted').is(':checked'))
    {
        paramatervalue.eventcompleted = "Y";
    } else
    {
        paramatervalue.eventcompleted = "N";
    }
    if ($('#eventbroadcast').is(':checked'))
    {
        paramatervalue.eventbroadcast = "Y";
    } else
    {
        paramatervalue.eventbroadcast = "N";
    }
    paramatervalue.feedbackremarks = $("#feedbackremarks").val();

    jData = {};
    jData.entryBy = $("#entryBy").val();
    jData.service = "FacultyFeedbackMasterServlet";
    jData.handller = "saveupdate";
    jData.para = paramatervalue;
    //jData.grid = gridData;
    $(document).getServace(jData);

}

function getSelectGridData(pno) {

    jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData.totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
    jData.service = "FacultyFeedbackMasterServlet";
    jData.handller = "select";

    $('#commonmasterid').getServace(jData);
}


function getGridData() {
    $("#mastergrid").yattable({
        width: "100%",
        height: ($(window).height() - 350),
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 10%'>Exam Code</th><th style='width: 15%'>Feedback Code</th><th style='width: 15%'>Feedback Description </th><th style='width: 15%'>EventFrom Date</th><th style='width: 15%'>EventTo Date</th><th style='width: 15%'>Feedback Remarks</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 10%'>" + gridData[key]["examcode"] + "</td><td  style='width: 15%'>" + gridData[key]["feedbackcode"] + "</td><td  style='width: 15%'>" + gridData[key]["feedbackdesc"] + "</td>";
        table = table + "<td  style='width: 15%'>" + gridData[key]["eventfromdate"] + "</td><td  style='width: 15%'>" + gridData[key]["eventtodate"] + "</td><td  style='width: 15%'>" + gridData[key]["feedbackremarks"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["feedbackid"] + "\",\"" + gridData[key]["examcode"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["feedbackid"] + "\",\"" + gridData[key]["examcode"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function resetValues()
{
    $("#feedbackid").val("0");
    $("#examcode").val("0");
    $("#feedbackcode").val("");
    $("#feedbackdesc").val("");
    $("#eventfromdate").val("");
    $("#eventtodate").val("");
    $("#eventcompleted").prop("checked",false);
    $("#eventbroadcast").prop("checked",false);
    $("#feedbackremarks").val("");
    getSelectGridData("0");
}

function updateMasterRecord(feedbackid, examcode)
{

    jData = {};
    jData.service = "FacultyFeedbackMasterServlet";
    jData.handller = "SelectforUpdate";
    jData.feedbackid = feedbackid;
    jData.examcode = examcode;
    $(document).getServace(jData);

}

function  deleteMasterRecord(feedbackid, examcode) {
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "FacultyFeedbackMasterServlet";
        jData.handller = "Delete";
        jData.feedbackid = feedbackid;
        jData.examcode = examcode;
        $(document).getServace(jData);
    }
    else {
    }
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
        getSelectGridData("0");
    }
});