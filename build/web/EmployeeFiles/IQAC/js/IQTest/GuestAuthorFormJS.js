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
          //  alert("DELETE");
            if (xhr.responseText>= 1)
            {
                alert("Record already exist you can't delete it.");
            }
           getSelectGridData(cupage.pr);
            break;
        case 'SelectforUpdate':
           // alert("RAMJIII");
            var selectData = jQuery.parseJSON(xhr.responseText);
            $("#indexingBodyID").val(selectData["indexingBodyID"]);
            $("#gName").val(selectData["gName"]);
            $("#dName").val(selectData["dName"]);
            $("#instName").val(selectData["instName"]);

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

function getCommanMasterTable() 
{ 
    //alert("GULLUUU");
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

function formsubmit(){
//alert("SAVE");
    if(jQuery.trim($("#gName").val())== "" ){
    alert("Please Enter Guest Author Name");
    $("#gName").focus();
    return false;
    }
    if(jQuery.trim($("#dName").val())== ""){
        alert("Please Enter Guest Designation Name");
        $("#dName").focus();
return false;
    }

if(jQuery.trim($("#instName").val())== ""){
    alert("Please Enter Institute Name");
    $("#instName").focus();
    return false;

}

    if ($('input[name=active]:checked').length <= 0)
    {
        alert("Please choose Deactive Y/N.");
        return false;
    }
if($('input [name=active]:checked').length <0 ){
    alert("Please Choose Deactive Yes/No");

return false;
}
 jData = {};
 jData.gName= $("#gName").val();
 jData.dName= $("#dName").val();
 jData.instName= $("#instName").val();
 jData.indexingBodyID= $("#indexingBodyID").val();
 jData.enterBy = $("#entryBy").val();
 if($("#activeY").prop("checked")){
     jData.deactive="Y"
 }
 if($("#activeN").prop("checked")){
     jData.deactive="N";
      }
      jData.service="GuestAuthorFormServlet";
      jData.handller="saveupdate";
        $(document).getServace(jData);
     // $(document).getservace(jData);
}
function getSelectGridData(pno) {
//alert("RAJUUUU");
    jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
 //  alert($("#searchbox").val());
    jData.service = "GuestAuthorFormServlet";
    jData.handller = "select";
    $(document).getServace(jData);
}
function getGridData() {
   // alert("GRIDDDDD");
    $("#mastergrid").yattable({
        width: "100%",
        height: 300,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 12%'>Guest Name</th><th style='width: 18%'>Institute Name</th><th style='width: 12%'>Designation Code</th><th style='width: 7%'>Deactive</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 12%'>" + gridData[key]["gName"] + "</td><td  style='width: 18%'>" + gridData[key]["instName"] + "</td>";
        table = table + "<td  style='width: 12%'>" + gridData[key]["dName"] + "</td>";
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
    jData.service = "GuestAuthorFormServlet";
    jData.handller = "SelectforUpdate";
    jData.indexingBodyID = indexingBodyID;
    $(document).getServace(jData);
}
function resetValues()
{
    $("#indexingBodyID").val("0");
    $("#gName").val("");
    $("#dName").val("");
    $("#instName").val("");

    $("#activeN").prop("checked", true);
    location.reload();

}
function deleteMasterRecord(indexID)
{
    //alert("JAIHO");
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

    jData = {};
    jData.service = "GuestAuthorFormServlet";
    jData.handller = "Delete";
  //  alert ($('indexID').val());
    jData.indexingBodyID = indexID;
    $(document).getServace(jData);
    }
    else {
    }
}