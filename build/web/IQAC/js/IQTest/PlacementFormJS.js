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
            if (xhr.responseText == "")
            {
                alert("Record Saved Successfully");
            } else
            {
                alert("Record Saved Successfully");
            }
           resetValues();
            getSelectGridData("0");
            break;
            case 'select':
             // alert("SELECT");
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;
        case 'SelectforUpdate':
            alert("You can Edit the Record");
            var SelectData = {};
          
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#interdispID").val(SelectData["intDisp"]);
            $("#slNo").val(SelectData["SLNO"]);
            $("#cmpCode").val(SelectData["cName"]);
            $("#offerMade").val(SelectData["nOffer"]);
            $("#branche").val(SelectData["plaBranch"]);
            $("#area").val(SelectData["plaArea"]);
            $("#compNat").val(SelectData["cNature"]);
            $("#size").val(SelectData["cSize"]);
            $("#salPkg").val(SelectData["pkgOffer"]);
            $("#cOnOFF").val(SelectData["cType"]);
             $("#apstud").val(SelectData["tstud"]);

            break;
        case 'Delete':
           getSelectGridData("0");
            break;

    }
});

function getCommonMasterTable() {
//alert("DATE");

$("#transactionDate").prop("disabled", true);
   // $(".nondecimal").numbernondecimal();
    $("#pagging").getPagging();
   // $("#paggingPopUp").getPagging();

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
 

}
function getSelectGridData(pno) {
//alert("BABU");
    jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
    jData.service = "PlacementFormServlet";
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
    $("#gridhead").html("");//Name of Company  Number of offers Made Branch Area Nature of Company
    $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 21%'>Name of Company</th><th style='width: 19%'>Number of offers Made </th><th style='width: 18%'>Branch</th><th style='width: 19%'>Area</th><th style='width: 20%'>Nature of Company</th><th style='width: 5%'>Edit</th><th style='width: 5%'>Delete</th>");

    for (var key in gridData) {
//        var rMarks=gridData[key]["QUALIFIEDRANK"];
//        if (rMarks == null)
//        {
//            rMarks = "";
//        }

        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 20%'>" + gridData[key]["cName"] + "</td><td  style='width: 16%'>" + gridData[key]["offer"] + "</td>";
        table = table + "<td  style='width: 18%'>" + gridData[key]["branch"] + "</td><td  style='width: 18%'>" + gridData[key]["area"] + "</td><td  style='width: 15%'>" + gridData[key]["nature"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["interdispID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["interdispID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}
function updateMasterRecord(intDispID)
{
//alert("UpdateGrid");
    jData = {};
    jData.service = "PlacementFormServlet";
    jData.handller = "SelectforUpdate";
    jData.interdispID = intDispID;
    $(document).getServace(jData);
}
function formsubmit()
{
    //cmpCode offerMade branche area salPkg cOnOFF
    alert("SAVING DATA");
    if (jQuery.trim($('#cmpCode').val()) == 0) {
        alert("Please Enter the Name of Company.");
        $('#cmpCode').focus();
        return false;
    }
    if (jQuery.trim($('#offerMade').val()) == "") {
        alert("Please Enter the Offerd Made.");
        $('#offerMade').focus();
        return false;
    }
    if (jQuery.trim($('#branche').val()) == "") {
        alert("Please Enter the Branch .");
        $('#branche').focus();
        return false;
    }
    if (jQuery.trim($('#area').val()) == "") {
        alert("Please Enter the Area.");
        $('#area').focus();
        return false;
    }
   if (jQuery.trim($('#compNat').val()) == "") {
        alert("Please Enter the Nature of Company");
        $('#compNat').focus();
        return false;
    }
    if (jQuery.trim($('#size').val()) == "") {
        alert("Please Enter the Size of company.");
        $('#size').focus();
        return false;
    }
    if (jQuery.trim($('#salPkg').val()) == "") {
        alert("Please Enter the Salary Pkg");
        $('#salPkg').focus();
        return false;
    }
  if (jQuery.trim($('#cOnOFF').val()) == "") {
        alert("Please Enter On Campus Or Off Campus ");
        $('#cOnOFF').focus();
        return false;
    }
  if (jQuery.trim($('#apstud').val()) == "") {
        alert("Please Enter Total No. Of Student Appeared ");
        $('#apstud').focus();
        return false;
    }
      var facultyNamesDataList = [];

      //  if ($("#facultyID" + i).val() != "0") {
            var facultyNamesData = {};

//alert("HELLO");
          
           facultyNamesData.companyID = $("#compsession").val();//COMPANYID 
           facultyNamesData.instID = $("#instsession").val();//INSTITUTEID
          //  alert($("#instsession").val());
           facultyNamesData.interdispID = $("#interdispID").val();//TRANSACTIONID
           facultyNamesData.staffID = $("#staffID").val();//APFACULTYID
           facultyNamesData.entryBy = $("#entryBy").val();//ENTRYBY
           facultyNamesData.transactionDate = $("#transactionDate").val();// TRANSACTIONDATE cOnOFF
           facultyNamesData.cName = $("#cmpCode").val();
           facultyNamesData.offer = $("#offerMade").val();
           facultyNamesData.branch = $("#branche").val();
           facultyNamesData.area = $("#area").val();
           facultyNamesData.nature = $("#compNat").val();
           facultyNamesData.size = $("#size").val();
           facultyNamesData.salPkg = $("#salPkg").val();
           facultyNamesData.slNo = $("#slNo").val();
           facultyNamesData.onOff = $("#cOnOFF").val();
            facultyNamesData.apstud = $("#apstud").val();
           facultyNamesDataList.push(facultyNamesData);

        //   alert($("#salPkg").val());
           jData = {};
          
           jData.companyID = $("#compsession").val();//COMPANYID
           jData.instID = $("#instsession").val();//INSTITUTEID
           jData.interdispID = $("#interdispID").val();//TRANSACTIONID
           jData.staffID = $("#staffID").val();//APFACULTYID
           jData.entryBy = $("#entryBy").val();//ENTRYBY
           jData.transactionDate = $("#transactionDate").val();// TRANSACTIONDATE
           jData.cName = $("#cmpCode").val();
           jData.offer = $("#offerMade").val();
           jData.branch = $("#branche").val();
           jData.area = $("#area").val();
           jData.nature = $("#compNat").val();
           jData.size = $("#size").val();
           jData.salPkg = $("#salPkg").val();
           jData.onOff = $("#cOnOFF").val();
            jData.apstud = $("#apstud").val();
           jData.slNo= $("#slNo").val();
// alert($("#salPkg").val());
          jData.service = "PlacementFormServlet";
          jData.handller = "saveupdate";
          jData.para = facultyNamesDataList;
        $(document).getServace(jData);
}

function resetValues()
{
    //  cmpCode offerMade branche area compNat size salPkg cOnOFF
   alert("RESETTING VALUES");
    $("#interdispID").val("0");
    $("#cmpCode").val("");
    $("#offerMade").val("");
    $("#branche").val("");
    $("#area").val("");
    $("#compNat").val("");
    $("#size").val("");
    $("#salPkg").val("");
    $("#cOnOFF").val("");
     $("#apstud").val("");

    location.reload();
}


  function deleteMasterRecord(intDispID)
{
   var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "PlacementFormServlet";
        jData.handller = "Delete";
        jData.interdispID = intDispID;
        $(document).getServace(jData);
    }
    else {
    }

}

