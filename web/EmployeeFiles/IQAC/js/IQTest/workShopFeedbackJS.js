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
            cache:false,
            dataType: "json",
            handller: para.handller,
            url: '../../' + para.service,
            data : 'jdata='+JSON.stringify(para).replace(/&/g,"@@@").replace(/%/g,""),
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

        
        case 'selectHeadingInfo':
            var SelectData = {};
            var childData = {};
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#transactionID").val(SelectData["transactionID"]);
            $("#transactionDate").val(SelectData["transactionDate"]);
            $("#departmentName").val(SelectData["department"]);
            $("#titleOfTheProgram").val(SelectData["programTitle"]);
            $("#programType").val(SelectData["programType"]);
            $("#startDate").val(SelectData["startDate"]);
            $("#endDate").val(SelectData["endDate"]);
            $("#tentativeBudget").val(SelectData["tentativeBudget"]);
            $("#targetAudience").val(SelectData["targetaudience"]);
            $("#fundRaised").val(SelectData["fundsraised"]);
            
            if (SelectData["websiteupdate"] == 'Y')
            {
                $("#websiteUpdateY").prop("checked", true);
            } 
            if(SelectData["websiteupdate"] == 'N')
            {
                $("#websiteUpdateN").prop("checked", true)
            }
            $("#fundSpent").val(SelectData["fundsspent"]);
            if (SelectData["databaseupdate"] == 'Y')
            {
                $("#databaseUpdateY").prop("checked", true);
            } 
            if(SelectData["databaseupdate"] == 'N')
            {
                $("#databaseUpdateN").prop("checked", true)
            }
            if(SelectData["websiteupdate"]==null)
                {
                   $("input:radio").attr("checked", false);  
                }
            $("#remarks").val(SelectData["programremarks"]);
            $("#participantsFeedbackValue").val(SelectData["participantsfeedback"]);
            $("#participantsFeedbackComment").val(SelectData["participantsfeedbackcomment"]);
            $("#resourcePersonFeedbackValue").val(SelectData["resourcepersonfeedback"]);
            $("#resourcePersonFeedbackComment").val(SelectData["resourcepersonfbcomment"]);
            $("#organizerFeedbackValue").val(SelectData["organizerFeedbackValue"]);
            $("#organizerFeedbackComment").val(SelectData["organizerFeedbackComment"]);
            break;
        case 'saveupdate':
            resetValues();
            getSelectGridData("0");
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            if (gridData["0"] != 0) {
                getGridData(gridData);
                $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
                
            }
            break;
        case 'SelectforUpdate':
            var SelectData = {};
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#transactionID").val(SelectData["transactionid"]);
            $("#transactionDate").val(SelectData["transactiondate"]);
            $("#departmentName").val(SelectData["department"]);
            $("#titleOfTheProgram").val(SelectData["programtitle"]);
            $("#programType").val(SelectData["programtype"]);
            $("#startDate").val(SelectData["startdate"]);
            $("#endDate").val(SelectData["enddate"]);
            $("#tentativeBudget").val(SelectData["tentativebudget"]);
            $("#targetAudience").val(SelectData["targetaudience"]);
            $("#fundRaised").val(SelectData["fundsraised"]);
            if (SelectData["websiteupdate"] == 'Y')
            {
                $("#websiteUpdateY").prop("checked", true);
            } else
            {
                $("#websiteUpdateN").prop("checked", true)
            }
            $("#fundSpent").val(SelectData["fundsspent"]);
            if (SelectData["databaseupdate"] == 'Y')
            {
                $("#databaseUpdateY").prop("checked", true);
            } else
            {
                $("#databaseUpdateN").prop("checked", true)
            }
            $("#remarks").val(SelectData["programremarks"]);
            $("#participantsFeedbackValue").val(SelectData["participantsfeedback"]);
            $("#participantsFeedbackComment").val(SelectData["participantsfeedbackcomment"]);
            $("#resourcePersonFeedbackValue").val(SelectData["resourcepersonfeedback"]);
            $("#resourcePersonFeedbackComment").val(SelectData["resourcepersonfbcomment"]);
            $("#organizerFeedbackValue").val(SelectData["organizerFeedbackValue"]);
            $("#organizerFeedbackComment").val(SelectData["organizerFeedbackComment"]);
            break;
        case 'Delete':
            $("#gridhead").html("");
            $("#gridbody").html("");
            getSelectGridData(cupage.pr);
            break;
        
    }
});


function getCommonMasterTable()
{
    $(".nondecimal").numbernondecimal();
    $(".number").numeric();
    $("#pagging").getPagging();
     getSelectGridData("0");
    ///////////////////////////////////// 
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
    ///////////////////////////////

}

function getHeadingInfo()
{
    jData = {};
    jData.service = "WorkShopFeedBackServlet";
    jData.handller = "selectHeadingInfo";
    jData.transactionID = $("#transactionID").val();
    $(document).getServace(jData);
}

function formsubmit()
{
    if (jQuery.trim($('#transactionID').val()) == 0) {
        alert("Please Select Program Details.");
        $('#transactionID').focus();
        return false;
    }
    if (jQuery.trim($('#fundRaised').val()) == "") {
        alert("Please Enter the Fund Raised.");
        $('#fundRaised').focus();
        return false;
    }
    if (jQuery.trim($('#fundSpent').val()) == "") {
        alert("Please Enter the Fund Spent.");
        $('#fundSpent').focus();
        return false;
    }
    if ($('input[name=websiteUpdate]:checked').length <= 0)
    {
        alert("Please choose Website Update.");
        return false;
    }
    if ($('input[name=databaseUpdate]:checked').length <= 0)
    {
        alert("Please choose Database Update.");
        return false;
    }
    if (jQuery.trim($('#participantsFeedbackValue').val()) == 0) {
        alert("Please Select the Participants Feedback Value.");
        $('#participantsFeedbackValue').focus();
        return false;
    }
    if (jQuery.trim($('#participantsFeedbackComment').val()) == "") {
        alert("Please Enter the Participants Feedback Comment.");
        $('#participantsFeedbackComment').focus();
        return false;
    }
    if (jQuery.trim($('#resourcePersonFeedbackValue').val()) == 0) {
        alert("Please Select the Resource Person Feedback Value.");
        $('#resourcePersonFeedbackValue').focus();
        return false;
    }
    if (jQuery.trim($('#resourcePersonFeedbackComment').val()) == "") {
        alert("Please Enter the Resource Person Feedback Comment.");
        $('#resourcePersonFeedbackComment').focus();
        return false;
    }
    if (jQuery.trim($('#organizerFeedbackValue').val()) == 0) {
        alert("Please Select the Feedback of Organizer regarding Administrative Support Feedback Value.");
        $('#organizerFeedbackValue').focus();
        return false;
    }
    if (jQuery.trim($('#organizerFeedbackComment').val()) == "") {
        alert("Please Enter the Feedback of Organizer regarding Administrative Support Feedback Comment.");
        $('#organizerFeedbackComment').focus();
        return false;
    }
    
    var paramatervalue = {};
    paramatervalue.companyid = $("#compsession").val();
    paramatervalue.instituteid = $("#instsession").val();
    paramatervalue.transactionID = $("#transactionID").val();
    paramatervalue.transactionDate = $("#transactionDate").val();
    paramatervalue.departmentName = $("#departmentName").val();
    paramatervalue.titleOfTheProgram = $("#titleOfTheProgram").val();
    paramatervalue.programType = $("#programType").val();
    paramatervalue.startDate = $("#startDate").val();
    paramatervalue.endDate = $("#endDate").val();
    paramatervalue.fundRaised = $("#fundRaised").val();
    paramatervalue.fundSpent = $("#fundSpent").val();
     if ($("#websiteUpdateY").prop("checked")) {
        paramatervalue.websiteUpdate="Y";
    }
    if ($("#websiteUpdateN").prop("checked")) {
        paramatervalue.websiteUpdate="N";
    }
    if ($("#databaseUpdateY").prop("checked")) {
        paramatervalue.databaseUpdate = "Y";
    }
    if ($("#databaseUpdateN").prop("checked")) {
        paramatervalue.databaseUpdate = "N";
    }
    paramatervalue.remarks = $("#remarks").val();
    paramatervalue.participantsFeedbackValue = $("#participantsFeedbackValue").val();
    paramatervalue.participantsFeedbackComment = $("#participantsFeedbackComment").val();
    paramatervalue.resourcePersonFeedbackValue = $("#resourcePersonFeedbackValue").val();
    paramatervalue.resourcePersonFeedbackComment = $("#resourcePersonFeedbackComment").val();
    paramatervalue.organizerFeedbackValue = $("#organizerFeedbackValue").val();
    paramatervalue.organizerFeedbackComment = $("#organizerFeedbackComment").val();
    
    jData = {};
    jData.entryBy = $("#entryBy").val();
    jData.service = "WorkShopFeedBackServlet";
    jData.handller = "saveupdate";
    jData.para = paramatervalue;
    $(document).getServace(jData);

}

function getSelectGridData(pno)
{
    
     jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
    jData.service = "WorkShopFeedBackServlet";
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
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 18%'>Transaction Date</th><th style='width: 18%'>Department </th><th style='width: 18%'>Title of the Program </th><th style='width: 18%'>Start Date</th><th style='width: 18%'>End Date</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 18%'>" + gridData[key]["transactiondate"] + "</td><td  style='width: 18%'>" + gridData[key]["department"] + "</td>";
        table = table + "<td  style='width: 18%'>" + gridData[key]["programtitle"] + "</td><td  style='width: 18%'>" + gridData[key]["startdate"] + "</td><td  style='width: 18%'>" + gridData[key]["enddate"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["transactionid"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["transactionid"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function resetValues()
{
    $("#transactionID").val("");
    $("#transactionDate").val("");
    $("#departmentName").val("");
    $("#titleOfTheProgram").val("");
    $("#programType").val("");
    $("#endDate").val("");
    $("#startDate").val("");
    $("#tentativeBudget").val("");
    $("#targetAudience").val("");
    $("#fundRaised").val("");
    $("input:radio").attr("checked", false);
    $("#fundSpent").val("");
    $("#remarks").val("");
    $("#participantsFeedbackValue").val("0");
    $("#participantsFeedbackComment").val("");
    $("#resourcePersonFeedbackValue").val("0");
    $("#resourcePersonFeedbackComment").val("");
    $("#organizerFeedbackValue").val("0");
    $("#organizerFeedbackComment").val("");
}

function updateMasterRecord(transactionID)
{
    jData = {};
    jData.service = "WorkShopFeedBackServlet";
    jData.handller = "SelectforUpdate";
    jData.transactionid = transactionID;
    $(document).getServace(jData);
}

function deleteMasterRecord(transactionID)
{
    
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "WorkShopFeedBackServlet";
        jData.handller = "Delete";
        jData.transactionID = transactionID;
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