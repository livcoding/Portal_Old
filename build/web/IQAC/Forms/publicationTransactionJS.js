/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var rc = 0;
var selectAuthorInfo = {};
var dataList=[];
var lowerGridData={};
var tempVal="";
var currRowNo=0;
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

        case 'selectAuthorInfo':
            selectAuthorInfo = jQuery.parseJSON(xhr. responseText);
            getSelectAuthorInfoInPopUp(selectAuthorInfo);
            $('#TOTAL').html("Total No.of Record(s): " + selectAuthorInfo[1].totalrecords);
            break;
        case 'selectLowerGridData':
            lowerGridData = jQuery.parseJSON(xhr.responseText);
            getSelectLowerGridData();
            break;
        case 'validateData':
            tempVal = xhr.responseText;
            if (dataList.length == 0) {
                displayGridData("new");
            } else
            {
                displayGridData("update");
            }
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
            break;
        case 'selectForUpgrade':
            var i = 1;
            dataList = [];
            dataList = jQuery.parseJSON(xhr.responseText);
            dataList[0]["companyID"]=$("#compsession").val();
            $("#transactionID").val(dataList[0]["transactionID"]);
            $("#transactionDate").val(dataList[0]["transactionDate"]);
            $("#publicationType").val(dataList[0]["publicationTypeID"]);
           // getPublicationCombo(dataList[0]["publicationID"]);
            $("#publicationName").val(dataList[0]["publicationName"]);
            $("#completeReference").val(dataList[0]["completeReference"]);
            $("#apiScore").val(dataList[0]["apiScore"]);
            $("#impactFactor").val(dataList[0]["impactFactorID"]);
            $("#indexingBody").val(dataList[0]["indexingBodyID"]);
            $("#publicationYear").val(dataList[0]["publicationYear"]);
            $("#impactFactorValue").val(dataList[0]["impactFactorValue"]);
             $("#intpub").val(dataList[0]["intpub"]);
              $("#intpub").prop("disabled", true);
              $("#hindex").prop("disabled", true);
            var lRow = $('[name="authorName"]').last().attr('id').substring(10);
            for (var m = 0; m <= lRow; m++) {
                $('.dPublicationTransactionRow').trigger('click');
            }
            $("#staffID" + lRow).attr("id", "staffID1");
            $("#staffType" + lRow).attr("id", "staffType1");
            $("#authorType" + lRow).attr("id", "authorType1");
            $("#departmentCode" + lRow).attr("id", "departmentCode1");
            $("#authorName" + lRow).attr("id", "authorName1");
            $("#departmentName" + lRow).attr("id", "departmentName1");
            $("#row" + lRow).attr("id", "row1");
            $("#row1").html("1.");
            var childData = dataList[1];
            for (var key in childData) {
                if (i != 1) {
                    addPublicationTransactionRow();
                }
                var subrow = childData[i];
                for (var key1 in subrow) {

                    if((subrow[key1]=='E' || subrow[key1]=='I') && key1!="staffType"){
                    $("#" + key1 + i).val(getEmployeeType(subrow[key1]));
                    }else
                        {
                     $("#" + key1 + i).val(subrow[key1]);
                        }
                }
                i++;
            }
            getGridData();
            break;

    }
});

function getCommonMasterTable(){
    $(".nondecimal").numbernondecimal();
    $(".number").numeric();
    $("#paggingPopUp").getPagging();

    $("#authorNameTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });

     var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();

    if(dd<10){
        dd="0"+dd
    }
    if (mm < 10) {
        $("#transactionDate").val(dd + "-" +"0"+ mm + "-" + yyyy);
    } else
    {
        $("#transactionDate").val(dd + "-" + mm + "-" + yyyy);
    }


    $(".addPublicationTransactionRow").click('click', function(e) {
        var rowCount = $('#PublicationTransactionTable tbody').length;
        if (eval(rowCount) == 20) {
            alert('Maximum 20 Rows Allowed');
            $('#PublicationTransactionTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else {
            addPublicationTransactionRow();
        }
    });

    $(".dPublicationTransactionRow").click('click', function(e) {
        if ($('#deleteStatus').val() != '0') {
            if (eval($('.publicationTransactionRow1').length) == 1) {
                $("#staffID1").val("0");
                $("#departmentCode1").val("0");
                $("#authorName1").val("");
                $("#departmentName1").val("");
                $("#authorType1").val("");
            }
            else {
                $(this).parent().parent().parent().remove();
                var lR = $(this).attr('id').substring(26);
                $("#dPublicationTransactionRow" + (eval(lR) - 1)).show(); 
            }
        } else {
            alert('No Authority To Delete');
        }
    });

    $("#PublicationTransactionTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    getLowerGridData();
}

function charMax() {
//alert("Hellooooo");
 if (document.getElementById("completeReference").value.length >=500) { 
       alert("You have exceeded the maximum characters 500 allowed Plz click Exit Button & Re-enter the Data");

        return false;
    }
     return true;
}
function addPublicationTransactionRow(){
    var lRow = $('[name="authorName"]').last().attr('id').substring(10);
    var newRow = $('.publicationTransactionRow1:eq(0)').clone(true);
    newRow.insertAfter($('.publicationTransactionRow1:last'));
    $(".publicationTransactionRow1").each(function(rowNumber, currentRow) {
        $("*", currentRow).each(function() {
            if (this.id.match(/(\d+)+$/)) {
                this.id = this.id.replace(RegExp.$1, rowNumber + 1);
            }
            if (currentRow == newRow.get(0))
            {
                switch (this.name)
                {
                    case 'staffID':
                        {
                            $(this).val("0");
                            break;
                        }
                    case 'authorName':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'departmentCode':
                        {
                            $(this).val("0");
                            break;
                        }
                    case 'departmentName':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'authorType':
                        {
                            $(this).val("");
                            break;
                        }
                }
            }
        });
    });
    $("#row" + (eval(lRow) + 1)).html(eval(lRow) + 1 + ".");
    $("#dPublicationTransactionRow" + (eval(lRow))).hide();
    $("#dPublicationTransactionRow" + (eval(lRow) + 1)).show();

}

$(function() {
    $("#authorNames").dialog({
        autoOpen: false,
        show: {
            effect: "blind",
            duration: 1000
        },
        hide: {
            effect: "explode",
            duration: 1000
        },
        width:$( window ).width()-130,
        height:300

    });
    $("#authorName1").click(function() {
        $("#authorNames").dialog("open");
        currRowNo = (this.id).substr(10, 1);
        getAuthorNames("0");

    });
});

function getAuthorNames(pno)
{
    var totIDS = 0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectAuthorInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    jData.spg = pno;
    var lRow = $('[name="authorName"]').last().attr('id').substring(10);
    for (var x = 1; x <= lRow; x++)
    {
        totIDS = totIDS + "," + $("#staffID" + x).val();
    }
    var arr = totIDS.split(",");
    var str = '';
    for (var y = 0; y < arr.length; y++)
    {
        str = str + "'" + arr[y] + "',";
    }
    str = str.substr(0, str.lastIndexOf(","));
    jData.totalStaffIDS = str;
    jData.searchNames = $("#searchNames").val();
    jData.service = "PublicationTransactionServlet";
    jData.handller = "selectAuthorInfo";
    $(document).getServace(jData);

}

function getSelectAuthorInfoInPopUp(){
     var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 23%'>Author Code</th><th style='width: 23%'>Author Name</th><th style='width: 26%'>Department Name</th><th style='width: 23%'>Author Type</th>");

     for (var key in selectAuthorInfo) {
        table = table + "<tr ondblclick='setNames("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectAuthorInfo[key]["sno"] + "</td><td  style='width: 23%;text-align: left'>" + selectAuthorInfo[key]["employeeCode"] + "</td><td  style='width: 23%;text-align: left'>" + selectAuthorInfo[key]["employeename"] + "</td><td  style='width: 26%;text-align: left'>" + selectAuthorInfo[key]["departmentName"] + "</td><td  style='width: 23%;text-align: left'>" + getEmployeeType(selectAuthorInfo[key]["employeeType"]) + "</td></tr>";
    }

    $("#authorNameBody").html("");
    $("#authorNameBody").html("" + table);

 $("#popupHeaderTable").css("width",$("#authorNameBody").width());
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getAuthorNames("0");
    }
});


function getEmployeeType(code)
{
    var tempValue = "";
    if (code == 'E')
    {
        tempValue = "Visiting Faculty";
    } else {
        tempValue = "Employee";
    }

    return tempValue;
}

function setNames(key)
{
    $("#staffID"+currRowNo).val(selectAuthorInfo[key]["employeeID"]);
    $("#authorName"+currRowNo).val(selectAuthorInfo[key]["employeename"]);
    $("#departmentCode"+currRowNo).val(selectAuthorInfo[key]["departmentCode"]);
    $("#departmentName"+currRowNo).val(selectAuthorInfo[key]["departmentName"]);
    $("#staffType"+currRowNo).val(selectAuthorInfo[key]["employeeType"]);
    $("#authorType"+currRowNo).val(getEmployeeType(selectAuthorInfo[key]["employeeType"]));
    $("#authorNames").dialog("close");

}



function displayGridData(action)
{


    if(tempVal=="true" && $("#transactionID").val()=="0")
        {
            alert("Record already exist, please choose another");
            resetValues();
            return false;
        }

    if (jQuery.trim($('#transactionDate').val()) == "") {
        alert("Please Enter the Transaction Date.");
        $('#transactionDate').focus();
        return false;
    }

    if (jQuery.trim($('#publicationType').val()) == 0) {
        alert("Please Select the Publication Type.");
        $('#publicationType').focus();
        return false;
    }

   /* if (jQuery.trim($('#publicationName').val()) == "") {
        alert("Please Enter the Publication Name.");
        $('#publicationName').focus();
        return false;
    } */
    if (jQuery.trim($('#completeReference').val()) == 0) {
        alert("Please Enter the Complete Reference.");
        $('#completeReference').focus();
        return false;
    }
    if (jQuery.trim($('#impactFactor').val()) == 0) {
        alert("Please Select the Impact Factor.");
        $('#impactFactor').focus();
        return false;
    }
    if (jQuery.trim($('#indexingBody').val()) == 0) {
        alert("Please Select the Indexing Body.");
        $('#indexingBody').focus();
        return false;
    }
    if (jQuery.trim($('#publicationYear').val()) == "") {
        alert("Please Enter the Publication Year.");
        $('#publicationYear').focus();
        return false;
    }
    if (jQuery.trim($('#impactFactorValue').val()) == "") {
        alert("Please Enter the Impact Factor Value.");
        $('#impactFactorValue').focus();
        return false;
    }

    $("#transactionDate").prop("disabled", true);
    $("#publicationType").prop("disabled", true);
    $("#publicationName").prop("disabled", true);
    $("#completeReference").prop("disabled", true);
    $("#indexingBody").prop("disabled", true);
    $("#publicationYear").prop("disabled", true);
    $("#impactFactor").prop("disabled", true);
    $("#impactFactorValue").prop("disabled", true);
    $("#intpub").prop("disabled", true);
    $("#hindex").prop("disabled", true);
    if(action=="new"){
        for (var x = 0; x < dataList.length; x++)
    {
        if (dataList[x]["departmentName"] == $('#departmentName option:selected').text() && dataList[x]["publicationType"] == $('#publicationType option:selected').text() && dataList[x]["authorName"] == $("#authorName").val() && dataList[x]["publicationName"] == $('#publicationName').val() && dataList[x]["completeReference"] == $("#completeReference").val() && dataList[x]["impactFactor"] == $('#impactFactor option:selected').text() && dataList[x]["indexingBody"] == $('#indexingBody option:selected').text() && dataList[x]["publicationYear"] == $('#publicationYear').val() && dataList[x]["impactFactorValue"] == $('#impactFactorValue').val()&& dataList[x]["intpub"] == $('#intpub').val() && $("#transactionID").val()=="0")
        {
         alert("Record already exist");
         return false;
        }
    }

        var detailDataList={};
        detailDataList.transactionDate=$("#transactionDate").val();
        detailDataList.companyID=$("#compsession").val();
        detailDataList.departmentName=$('#departmentName option:selected').text();
        detailDataList.departmentID=$("#departmentName").val();
        detailDataList.publicationType=$('#publicationType option:selected').text();
        detailDataList.publicationTypeID=$("#publicationType").val();
        detailDataList.authorName=$("#authorName").val();
        detailDataList.authorID=$("#staffID").val();
        detailDataList.publicationName=$('#publicationName').val();
        detailDataList.publicationID=$("#publicationName").val();
        detailDataList.completeReference=$("#completeReference").val();
        detailDataList.apiScore=$("#apiScore").val();
        detailDataList.impactFactor=$('#impactFactor option:selected').text();
        detailDataList.impactFactorID=$("#impactFactor").val();
        detailDataList.indexingBody=$('#indexingBody option:selected').text();
        detailDataList.indexingBodyID=$("#indexingBody").val();
        detailDataList.publicationYear=$("#publicationYear").val();
        detailDataList.impactFactorValue=$("#impactFactorValue").val();
        detailDataList.intpub=$("#intpub").val();
        detailDataList.hindex=$("#hindex").val();
        if(dataList.length<1){
        dataList.push(detailDataList);
        }
    }else
        {
        dataList[0]["transactionDate"]=$("#transactionDate").val();
        dataList[0]["companyID"]=$("#compsession").val();
        dataList[0]["departmentName"] = $('#departmentName option:selected').text();
        dataList[0]["departmentID"] = $("#departmentName").val();
        dataList[0]["publicationType"] = $('#publicationType option:selected').text();
        dataList[0]["publicationTypeID"] = $("#publicationType").val();
        dataList[0]["authorName"] = $("#authorName").val();
        dataList[0]["authorID"] = $("#staffID").val();
        dataList[0]["publicationName"] = $('#publicationName').val();
        dataList[0]["publicationID"] = $("#publicationName").val();
        dataList[0]["completeReference"] = $("#completeReference").val();
        dataList[0]["apiScore"] = $("#apiScore").val();
        dataList[0]["impactFactor"] = $('#impactFactor option:selected').text();
        dataList[0]["impactFactorID"] = $("#impactFactor").val();
        dataList[0]["indexingBody"] = $('#indexingBody option:selected').text();
        dataList[0]["indexingBodyID"] = $("#indexingBody").val();
        dataList[0]["publicationYear"] = $("#publicationYear").val();
        dataList[0]["impactFactorValue"] = $("#impactFactorValue").val();
        }
    getGridData();
}

function getGridData()
{
     $("#mastergrid").yattable({
        width: "100%",
        height: 80,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
     $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 12%'>Publication Type</th><th style='width: 23%'>Complete Reference</th><th style='width: 12%'>Indexing Body</th><th style='width: 12%'>Publication Year</th><th style='width: 12%'>Impact Factor</th><th style='width: 12%'>Impact Factor Value</th>");
     var x=0;

     table = table + "<tr><td  style='width: 5%'>"+(x+1)+"</td><td  style='width: 12%'>"+dataList[x]["publicationType"]+"</td><td  style='width: 23%'>"+dataList[x]["completeReference"]+"</td><td  style='width: 12%'>"+dataList[x]["indexingBody"]+"</td><td  style='width: 12%'>"+dataList[x]["publicationYear"]+"</td><td  style='width: 12%'>"+dataList[x]["impactFactor"]+"</td><td  style='width: 12%'>"+dataList[x]["impactFactorValue"]+"</td>";




    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());
}

function formsubmit()
{

    if (dataList.length == 0)
    {
        alert("Please Enter the all mandatory details before saving the record.");
        return false;
    }
    if(dataList.length == 1)
    {
        if (jQuery.trim($('#transactionDate').val()) == "") {
        alert("Please Enter the Transaction Date.");
        $('#transactionDate').focus();
       return false;
   }

    if (jQuery.trim($('#publicationType').val()) == 0) {
       alert("Please Select the Publication Type.");
       $('#publicationType').focus();
       return false;
    }

   /* if (jQuery.trim($('#publicationName').val()) == 0) {
        alert("Please Select the Publication Name.");
        $('#publicationName').focus();
        return false;
    } */
    if (jQuery.trim($('#indexingBody').val()) == 0) {
        alert("Please Select the Indexing Body.");
        $('#indexingBody').focus();
        return false;
    }
   if (jQuery.trim($('#publicationYear').val()) == "") {
       alert("Please Enter the Publication Year.");
        $('#publicationYear').focus();
        return false;
    }
    
     if (jQuery.trim($('#impactFactorValue').val()) == "") {
        alert("Please Enter the Impact Factor Value.");
        $('#impactFactorValue').focus();
        return false;
    }
   


        }

     var count = 0;
    var lRow = $('[name="authorName"]').last().attr('id').substring(10);
    for (var x = 0; x <= lRow; x++)
    {
        if ($("#authorName"+x).val() != "" && $("#authorName"+x).val()!=undefined)
        {
            count = 1;
        }
    }

    if (count == 0)
    {
        alert("Please Select atleast one Author Name.");
        return false;
    }

    var lRow = $('[name="authorName"]').last().attr('id').substring(10);
    var authorNamesDataList = [];
    for (var i = 1; i <= lRow; i++) {
        if ($("#staffID"+i).val() != "0") {
            var authorNamesData = {};
            authorNamesData.companyID = $("#compsession").val();
            authorNamesData.transactionID = $("#transactionID").val();
            authorNamesData.transactionDate = $("#transactionDate").val();
            authorNamesData.publicationTypeID=$("#publicationType").val();
            authorNamesData.publicationID=$("#publicationName").val();
            authorNamesData.publicationName=$('#publicationName').val();
            authorNamesData.staffType=$("#staffType"+i).val();
            authorNamesData.staffID=$("#staffID"+i).val();
            authorNamesData.departmentCode=$("#departmentCode"+i).val();
            authorNamesData.entryBy = $("#entryBy").val();
            authorNamesData.intpub = $("#intpub").val();
             authorNamesData.hindex = $("#hindex").val();
            authorNamesDataList.push(authorNamesData);
        }
    }
    var tempDataList=[];
    tempDataList[0]=dataList[0];
    jData = {};
    jData.entryBy = $("#entryBy").val();
    jData.service = "PublicationTransactionServlet";
    jData.handller = "saveupdate";
    jData.transactionID = $("#transactionID").val();
    jData.para = tempDataList;
    jData.para1 = authorNamesDataList;
    $(document).getServace(jData);
}

function getLowerGridData()
{
    jData = {};
    jData.transactionDate = $("#transactionDate").val();
    jData.departmentName = $("#departmentName").val();
    jData.service = "PublicationTransactionServlet";
    jData.handller = "selectLowerGridData";
    $(document).getServace(jData);
}

function getSelectLowerGridData()
{
    $("#lowerGrid").yattable({
        width: "100%",
        height: 100,
        scrolling: "yes"
    });
    var table = "";
   $("#lowerGridHead").html("");
     $("#lowerGridHead").html("<th style='width: 5%'>Sl No.</th><th style='width: 18%'>Transaction Date</th><th style='width: 18%'>Publication Type</th><th style='width: 18%'>Publication Year</th><th style='width: 18%'>Impact Factor Value</th><th style='width: 5%'></th>");
   for(var key in lowerGridData){
     table = table + "<tr><td  style='width: 5%'>"+key+"</td><td  style='width: 18%'>" + lowerGridData[key]["transactionDate"]+ "</td><td  style='width: 18%'>"+lowerGridData[key]["publicationTypeName"]+"</td><td  style='width: 18%'>"+lowerGridData[key]["publicationYear"]+"</td><td  style='width: 18%'>"+lowerGridData[key]["impactFactorValue"]+"</td>";
     table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + lowerGridData[key]["transactionID"] + "\")'></td></tr>";
   }

    $("#lowerGridBody").html("");
    $("#lowerGridBody").html("" + table);
    $("#lowerGrid1").css("width", $("#lowerGrid").width());
}

function validateData()
{
     var impvalue=$("#impactFactorValue").val();
    if(impvalue<0 || impvalue>99)
        {
            alert("Please Enter the Impact Factor Value between 0 and 99");
            return false;
        }

    jData = {};
    jData.service = "PublicationTransactionServlet";
    jData.publicationTypeID = $("#publicationType").val();
    jData.publicationID = $("#publicationName").val();
    jData.impactFactor = $("#impactFactor").val();
    jData.indexingBodyID = $("#indexingBody").val();
    jData.publicationYear = $("#publicationYear").val();
    jData.impactFactorValue = $("#impactFactorValue").val();
    jData.intpub = $("#intpub").val();
    jData.handller = "validateData";
    $(document).getServace(jData);
}

function resetValues()
{
    $("#transactionID").val("0");
    $("#transactionDate").val("");
    $("#publicationType").val("");
    $("#publicationName").val("");
    $("#completeReference").val("");
    $("#apiScore").val("");
    $("#impactFactor").val("0");
    $("#indexingBody").val("");
    $("#publicationYear").val("");
    $("#impactFactorValue").val("");
    $("#staffID1").val("0");
    $("#departmentCode1").val("0");
    $("#staffType1").val("");
    $("#authorName1").val("");
    $("#departmentName1").val("");
    $("#authorType1").val("");
     $("#intpub").val("");
     $("#hindex").val("");
    $("#transactionDate").prop("disabled", false);
    $("#publicationType").prop("disabled", false);
    $("#publicationName").prop("disabled", false);
    $("#completeReference").prop("disabled", false);
    $("#indexingBody").prop("disabled", false);
    $("#publicationYear").prop("disabled", false);
    $("#impactFactor").prop("disabled", false);
    $("#impactFactorValue").prop("disabled", false);
    $("#intpub").prop("disabled", false);
    $("#hindex").prop("disabled", false);
    location.reload();
}

function updateMasterRecord(transactionID)
{
    jData = {};
    jData.service = "PublicationTransactionServlet";
    jData.handller = "selectForUpgrade";
    jData.transactionID = transactionID;
    $(document).getServace(jData);

}


