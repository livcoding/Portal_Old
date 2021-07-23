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
           // alert("RAMJII");
            var selectData = jQuery.parseJSON(xhr.responseText);
            $("#indexingBodyID").val(selectData["indexingBodyID"]);
            $("#authName").val(selectData["authName"]);
            $("#instName").val(selectData["instName"]);
            $("#instCode").val(selectData["instCode"]);
            
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
    //alert("GULLU");
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
   // alert("LLLLLL");
    //alert("BABU");
    if (jQuery.trim($('#authName').val()) =="") {
        alert("Please Enter Author Name.");
        $('#authName').focus();
        return false;
    }
    if (jQuery.trim($('#instName').val()) == "") {
        alert("Please Enter the Name Of Institute.");
        $('#instName').focus();
        return false;
    }
    if (jQuery.trim($('#instCode').val()) == "") {
        alert("Please Enter the Institute Code.");
        $('#instCode').focus();
        return false;
    }
  
  
    if ($('input[name=active]:checked').length <= 0)
    {
        alert("Please choose Deactive Y/N.");
        return false;
    }
//authName indexingBodyID  instCode instName  active entryBy
    jData = {};
    jData.authName = $("#authName").val();
    jData.indexingBodyID = $("#indexingBodyID").val();
    jData.entryBy = $("#entryBy").val();
    jData.instName = $("#instName").val();
    jData.instCode = $("#instCode").val();
    //alert($("#instCode").val());
   //alert($("#instCode").val());
    if ($("#activeY").prop("checked")) {
        jData.deactive="Y";
    }
    if ($("#activeN").prop("checked")) {
        jData.deactive="N";
    }
    
    jData.entryBy = $("#entryBy").val();
    jData.service = "otherTransactionAuthorServlet";
    jData.handller = "saveupdate";
    $(document).getServace(jData);
}
function resetValues()
{
    $("#indexingBodyID").val("0");
    $("#authName").val("");
    $("#instName").val("");
    $("#instCode").val("");
   
    $("#activeN").prop("checked", true);
    location.reload();

}
function getSelectGridData(pno) {
//alert("RAJU");
    jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
    jData.service = "otherTransactionAuthorServlet";
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
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 12%'>Author Name</th><th style='width: 18%'>Institute Name</th><th style='width: 12%'>Institute Code</th><th style='width: 7%'>Deactive</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 12%'>" + gridData[key]["authName"] + "</td><td  style='width: 18%'>" + gridData[key]["instName"] + "</td>";
        table = table + "<td  style='width: 12%'>" + gridData[key]["instCode"] + "</td>";
        table = table + "<td  style='width: 7%'>" + gridData[key]["deactive"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["indexingBodyID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["indexingBodyID"] + "\")'></td></tr>";
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
function updateMasterRecord(indexingBodyID)
{
//alert("BABUUU");
    jData = {};
    jData.service = "otherTransactionAuthorServlet";
    jData.handller = "SelectforUpdate";
    jData.indexingBodyID = indexingBodyID;
    $(document).getServace(jData);
}
function deleteMasterRecord(indexID)
{
   // alert("JAI");
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

    jData = {};
    jData.service = "otherTransactionAuthorServlet";
    jData.handller = "Delete";
 
    jData.indexingBodyID = indexID;
    $(document).getServace(jData);
    }
    else {
    }
}