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
        case 'Delete':
            if (xhr.responseText == "1")
            {
            alert("Record already exist you can't delete it.");
            }
            getSelectGridData(cupage.pr);
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;
        case 'SelectforUpdate':
            var selectData = jQuery.parseJSON(xhr.responseText);
            $("#equipmentID").val(selectData["equipmentID"]);
            $("#departmentName").val(selectData["departmentName"]);
            $("#equipmentCode").val(selectData["equipmentCode"]);
            $("#equipmentName").val(selectData["equipmentName"]);
            $("#equipmentDescription").val(selectData["equipmentDescription"]);
            $("#equipmentSoftware").val(selectData["equipmentSoftware"]);
            $("#procurmentDate").val(selectData["procurmentDate"]);
            $("#procurmentCost").val(selectData["procurmentCost"]);
            $("#amcDueDate").val(selectData["amcDueDate"]);
            $("#amcAmount").val(selectData["amcAmount"]);
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

    if (jQuery.trim($('#equipmentCode').val()) == "") {
        alert("Please Enter the Equipment Code.");
        $('#equipmentCode').focus();
        return false;
    } 
    if (jQuery.trim($('#equipmentName').val()) == "") {
        alert("Please Enter the Equipment Name.");
        $('#equipmentName').focus();
        return false;
    } 
    if (jQuery.trim($('#equipmentSoftware').val()) == 0) {
        alert("Please Select the Equipment/Software.");
        $('#equipmentSoftware').focus();
        return false;
    } 
    if (jQuery.trim($('#equipmentDescription').val()) == "") {
        alert("Please Enter the Equipment Description.");
        $('#equipmentDescription').focus();
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
   
    if ($('input[name=active]:checked').length <= 0)
    {
        alert("Please choose Deactive Y/N.");
        return false;
    }
    
    jData = {};
    jData.companyID = $("#compsession").val();
    jData.instituteID = $("#instsession").val();
    jData.equipmentID = $("#equipmentID").val();
    jData.departmentName = $("#departmentName").val();
    jData.equipmentCode = $("#equipmentCode").val();
    jData.equipmentName=$("#equipmentName").val();
    jData.equipmentSoftware=$("#equipmentSoftware").val();
    jData.equipmentDescription=$("#equipmentDescription").val();
    jData.amcDueDate=$("#amcDueDate").val();
    jData.amcAmount=$("#amcAmount").val();
    jData.procurmentDate=$("#procurmentDate").val();
    jData.procurmentCost=$("#procurmentCost").val();
    if ($("#activeY").prop("checked")) {
        jData.deactive="Y";
    }
    if ($("#activeN").prop("checked")) {
        jData.deactive="N";
    }
    jData.entryBy = $("#entryBy").val();
    jData.service = "EquipmentMasterServlet";
    jData.handller = "saveupdate";
    $(document).getServace(jData);  
}

function resetValues()
{

    $("#equipmentID").val("0");
    $("#departmentName").val("");
    $("#equipmentCode").val("");
    $("#equipmentName").val("");
    $("#equipmentDescription").val("");
    $("#equipmentSoftware").val("0");
    $("#procurmentDate").val("");
    $("#procurmentCost").val("");
    $("#amcDueDate").val("");
    $("#amcAmount").val("");
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
    jData.service = "EquipmentMasterServlet";
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
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 12%'>Department Name</th><th style='width: 12%'>Equipment Code</th><th style='width: 12%'>Equipment Name</th><th style='width: 18%'>Equipment Description</th><th style='width: 12%'>Procurment Date</th><th style='width: 12%'>Procurment Cost</th><th style='width: 7%'>Deactive</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 12%'>" + gridData[key]["departmentName"] + "</td><td  style='width: 12%'>" + gridData[key]["equipmentCode"] + "</td><td  style='width: 12%'>" + gridData[key]["equipmentName"] + "</td>";
        table = table + "<td  style='width: 18%'>" + gridData[key]["equipmentDesc"] + "</td><td  style='width: 12%'>" + gridData[key]["procurmentDate"] + "</td><td  style='width: 12%'>" + gridData[key]["procurmentCost"] + "</td>";
        table = table + "<td  style='width: 7%'>" + gridData[key]["deactive"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["equipmentID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["equipmentID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function updateMasterRecord(equipmentID)
{
    jData = {};
    jData.service = "EquipmentMasterServlet";
    jData.handller = "SelectforUpdate";
    jData.equipmentID = equipmentID;
    $(document).getServace(jData);
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getSelectGridData("0");
    }
});

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
        alert('Procurement Date must be smaller or equal to Current Date');
        $('#procurmentDate').val("");
        return false;
    }
}

function deleteMasterRecord(equipID)
{
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

    jData = {};
    jData.service = "EquipmentMasterServlet";
    jData.handller = "Delete";
    jData.equipmentID = equipID;
    $(document).getServace(jData);
    }
    else {
    }
}