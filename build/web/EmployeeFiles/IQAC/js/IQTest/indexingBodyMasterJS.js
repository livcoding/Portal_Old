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
        case 'saveupdate':
            getGridData("0");
            resetValues();
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;
        case 'Delete':
            if (xhr.responseText>= 1)
            {
                alert("Record already exist you can't delete it.");
            }
            getSelectGridData(cupage.pr);
            break;
        case 'SelectforUpdate':
            var selectData = jQuery.parseJSON(xhr.responseText);
            $("#indexingBodyID").val(selectData["indexingBodyID"]);
            $("#indexingBodyCode").val(selectData["indexingBodyCode"]);
            $("#indexingBodyName").val(selectData["indexingBodyName"]);
            $("#indexingBodyRating").val(selectData["rating"]);
            $("#indexingBodyRemarks").val(selectData["indexingBodyRemarks"]);
            $("#apiScore").val(selectData["apiScore"]);
            $("#hIndex").val(selectData["hIndex"]);
            $("#startValue").val(selectData["startValue"]);
            $("#endValue").val(selectData["endValue"]);
            if (selectData["deactive"] == 'Y')
            {
                $("#activeY").prop("checked", true);
            } else
            {
                $("#activeN").prop("checked", true)
            }
            $("#remarks").val(selectData["remarks"]);
            break;
    }
});


function getCommonMasterTable()
{
    $("#activeN").prop("checked", true);
    $(".number").numeric();
    $(".nondecimal").numbernondecimal();
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

function formsubmit()
{
    if (jQuery.trim($('#indexingBodyCode').val()) =="") {
        alert("Please Enter the Indexing Body Code.");
        $('#indexingBodyCode').focus();
        return false;
    } 
    if (jQuery.trim($('#indexingBodyName').val()) == "") {
        alert("Please Enter the Indexing Body Name.");
        $('#indexingBodyName').focus();
        return false;
    } 
    if (jQuery.trim($('#indexingBodyRating').val()) == "") {
        alert("Please Enter the Indexing Body Rating.");
        $('#indexingBodyRating').focus();
        return false;
    } 
    if (jQuery.trim($('#apiScore').val()) == "") {
        alert("Please Enter the API Score.");
        $('#apiScore').focus();
        return false;
    } 
    if (jQuery.trim($('#hIndex').val()) == "") {
        alert("Please Enter the Hindex.");
        $('#hIndex').focus();
        return false;
    } 
    if (jQuery.trim($('#startValue').val()) == "") {
        alert("Please Enter the Start Value.");
        $('#startValue').focus();
        return false;
    } 
    if (jQuery.trim($('#endValue').val()) == "") {
        alert("Please Enter the End Value.");
        $('#endValue').focus();
        return false;
    } 
   
    if ($('input[name=active]:checked').length <= 0)
    {
        alert("Please choose Deactive Y/N.");
        return false;
    }
    
    jData = {};
    jData.companyID = $("#compsession").val();
    jData.indexingBodyID = $("#indexingBodyID").val();
    jData.indexingBodyCode = $("#indexingBodyCode").val();
    jData.indexingBodyName = $("#indexingBodyName").val();
    jData.indexingBodyRating=$("#indexingBodyRating").val();
    jData.indexingBodyRemarks=$("#indexingBodyRemarks").val();
    jData.apiScore=$("#apiScore").val();
    jData.hIndex=$("#hIndex").val();
    jData.startValue=$("#startValue").val();
    jData.endValue=$("#endValue").val();
    if ($("#activeY").prop("checked")) {
        jData.deactive="Y";
    }
    if ($("#activeN").prop("checked")) {
        jData.deactive="N";
    }
    jData.remarks=$("#remarks").val();
    jData.entryBy = $("#entryBy").val();
    jData.service = "IndexingBodyMasterServlet";
    jData.handller = "saveupdate";
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
    jData.service = "IndexingBodyMasterServlet";
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
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 12%'>Indexing Body Code</th><th style='width: 18%'>Indexing Body Name</th><th style='width: 12%'>API Score</th><th style='width: 12%'>Hindex</th><th style='width: 12%'>Start Value</th><th style='width: 12%'>End Value</th><th style='width: 7%'>Deactive</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 12%'>" + gridData[key]["indexingBodyCode"] + "</td><td  style='width: 18%'>" + gridData[key]["indexingBodyName"] + "</td><td  style='width: 12%'>" + gridData[key]["apiScore"] + "</td>";
        table = table + "<td  style='width: 12%'>" + gridData[key]["hIndex"] + "</td><td  style='width: 12%'>" + gridData[key]["startValue"] + "</td><td  style='width: 12%'>" + gridData[key]["endValue"] + "</td>";
        table = table + "<td  style='width: 7%'>" + gridData[key]["deactive"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["indexingBodyID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["indexingBodyID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());
}

function updateMasterRecord(indexingBodyID)
{
    
    jData = {};
    jData.service = "IndexingBodyMasterServlet";
    jData.handller = "SelectforUpdate";
    jData.indexingBodyID = indexingBodyID;
    $(document).getServace(jData);
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getSelectGridData("0");
    }
});

function resetValues()
{
    $("#indexingBodyID").val("0");
    $("#indexingBodyCode").val("");
    $("#indexingBodyName").val("");
    $("#indexingBodyRating").val("");
    $("#indexingBodyRemarks").val("");
    $("#apiScore").val("");
    $("#hIndex").val("");
    $("#startValue").val("");
    $("#endValue").val("");
    $("#remarks").val("");
    $("#activeN").prop("checked", true);
    location.reload();

}

function getValidateValue()
{
    var startValue = $("#startValue").val();
    var endValue = $("#endValue").val();
    if (startValue > endValue && startValue != "" && endValue != "")
    {
        alert("End value must be greater than Start value");
        $("#endValue").val("")
    }
    
}

function deleteMasterRecord(indexID)
{
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

    jData = {};
    jData.service = "IndexingBodyMasterServlet";
    jData.handller = "Delete";
    jData.indexingBodyID = indexID;
    $(document).getServace(jData);
    }
    else {
    }
}