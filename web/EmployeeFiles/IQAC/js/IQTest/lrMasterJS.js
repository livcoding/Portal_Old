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
            if (xhr.responseText == "1")
            {
                alert("Record already exist you can't delete it.");
            }
            getSelectGridData(cupage.pr);
            break;
        case 'SelectforUpdate':
            var selectData = jQuery.parseJSON(xhr.responseText);
            $("#lrID").val(selectData["lrID"]);
            $("#departmentName").val(selectData["departmentName"]);
            $("#lrCode").val(selectData["lrCode"]);
            $("#lrName").val(selectData["lrName"]);
            $("#lrDescription").val(selectData["lrDescription"]);
            $("#procurmentDate").val(selectData["procurmentDate"]);
            $("#procurmentCost").val(selectData["procurmentCost"]);
            $("#lrType").val(selectData["lrType"]);
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
    $("#activeN").prop("checked", true);
    $(".number").numeric();
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
    if (jQuery.trim($('#departmentName').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentName').focus();
        return false;
    } 
    if (jQuery.trim($('#lrCode').val()) == "") {
        alert("Please Enter the LR Code.");
        $('#lrCode').focus();
        return false;
    } 
    if (jQuery.trim($('#lrName').val()) == "") {
        alert("Please Enter the LR Name.");
        $('#lrName').focus();
        return false;
    } 
    
    if (jQuery.trim($('#procurmentDate').val()) == "") {
        alert("Please Enter the Procurment Date.");
        $('#procurmentDate').focus();
        return false;
    } 
    if (jQuery.trim($('#procurmentCost').val()) == "") {
        alert("Please Enter the Procurment Cost.");
        $('#procurmentCost').focus();
        return false;
    } 
    if (jQuery.trim($('#lrType').val()) == 0) {
        alert("Please Select the LR Type.");
        $('#lrType').focus();
        return false;
    } 
   
   
    if ($('input[name=active]:checked').length <= 0)
    {
        alert("Please choose Deactive Y/N.");
        return false;
    }
    
    jData = {};
    jData.companyID = $("#compsession").val();
    jData.instituteID = $("#instsession").val();
    jData.lrID = $("#lrID").val();
    jData.departmentName = $("#departmentName").val();
    jData.lrCode = $("#lrCode").val();
    jData.lrName=$("#lrName").val();
    jData.lrDescription=$("#lrDescription").val();
    jData.procurmentDate=$("#procurmentDate").val();
    jData.procurmentCost=$("#procurmentCost").val();
    jData.lrType=$("#lrType").val();
    if ($("#activeY").prop("checked")) {
        jData.deactive="Y";
    }
    if ($("#activeN").prop("checked")) {
        jData.deactive="N";
    }
    jData.entryBy = $("#entryBy").val();
    jData.service = "LRMasterServlet";
    jData.handller = "saveupdate";
    $(document).getServace(jData);  
}

function resetValues()
{
    $("#lrID").val("0");
    $("#departmentName").val("");
    $("#lrCode").val("");
    $("#lrName").val("");
    $("#lrDescription").val("");
    $("#procurmentDate").val("");
    $("#procurmentCost").val("");
    $("#lrType").val("0");
    $("#activeN").prop("checked", true);
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
    jData.service = "LRMasterServlet";
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
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 12%'>Department Name</th><th style='width: 12%'>LR Code</th><th style='width: 12%'>LR Name</th><th style='width: 18%'>LR Description</th><th style='width: 12%'>Procurment Date</th><th style='width: 12%'>Procurment Cost</th><th style='width: 7%'>Deactive</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        var lrdesc= gridData[key]["lrDescription"];
        if(lrdesc==null)
            {
                lrdesc="";
            }
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 12%'>" + gridData[key]["departmentName"] + "</td><td  style='width: 12%'>" + gridData[key]["lrCode"] + "</td><td  style='width: 12%'>" + gridData[key]["lrName"] + "</td>";
        table = table + "<td  style='width: 18%'>" +lrdesc + "</td><td  style='width: 12%'>" + gridData[key]["procurmentDate"] + "</td><td  style='width: 12%'>" + gridData[key]["procurmentCost"] + "</td>";
        table = table + "<td  style='width: 7%'>" + gridData[key]["deactive"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["lrID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["lrID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getSelectGridData("0");
    }
});

function updateMasterRecord(lrID)
{
    
    jData = {};
    jData.service = "LRMasterServlet";
    jData.handller = "SelectforUpdate";
    jData.lrID = lrID;
    $(document).getServace(jData);
}

function getValidateDate()
{
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
    var currentDate = "";
    if (dd < 10) {
        dd = "0" + dd
    }
    if (mm < 10) {
        currentDate = dd + "-" + "0" + mm + "-" + yyyy;
    } else
    {
        currentDate = dd + "-" + mm + "-" + yyyy;
    }
    var procurmentDate = $.datepicker.parseDate('dd-mm-yy', $('#procurmentDate').val());
    var currDate = $.datepicker.parseDate('dd-mm-yy', currentDate);
    if (procurmentDate > currDate) {
        alert('Procurment Date must be smaller or equal to Current Date');
        $('#procurmentDate').val("");
        return false;
    }
}

function getValidateCost()
{
    if ($("#procurmentCost").val() < 0)
    {
        alert("Procurment Cost must be Positive");
        $('#procurmentCost').val("");
        return false;
    }
}

function deleteMasterRecord(lrid)
{
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

    jData = {};
    jData.service = "LRMasterServlet";
    jData.handller = "Delete";
    jData.lrID = lrid;
    $(document).getServace(jData);
    }
    else {
    }
}