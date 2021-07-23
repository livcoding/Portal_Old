/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var rc = 0;
var selectStaffInfo = {};
var selectStudentInfo = {};
var gridData = {};
var cupage = {};
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
        case 'formNameCombo':
            $("#formName").empty();
            $("#formName").append(xhr.responseText);
            break;
        case 'selectStaffInfo':
            selectStaffInfo = jQuery.parseJSON(xhr.responseText);
            getSelectStaffInfoInPopUp(selectStaffInfo);
            $('#TOTAL').html("Total No.of Record(s): " + selectStaffInfo[1].totalrecords);
            break;
        case 'selectStudentInfo':
            selectStudentInfo = jQuery.parseJSON(xhr.responseText);
            getSelectStudentInfoInPopUp(selectStudentInfo);
            $('#TOTAL').html("Total No.of Record(s): " + selectStudentInfo[1].totalrecords);
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
            getSelectGridData("0");
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;
        case 'SelectforUpdate':
            var SelectData = {};
            var childData = {};
            var i = 1;
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#bookID").val(SelectData["bookID"]);
            $("#transactionDate").val(SelectData["transactionDate"]);
            $("#bookCode").val(SelectData["bookCode"]);
            $("#bookTitle1").val(SelectData["bookTitle1"]);
            $("#bookNature").val(SelectData["bookNature"]);
            $("#bookTitle2").val(SelectData["bookTitle2"]);
            $("#role").val(SelectData["role"]);
            $("#bookChapter").val(SelectData["chapterName"]);
            $("#apiScore").val(SelectData["apiScore"]);
            $("#bookRemarks").val(SelectData["bookRemarks"]);
            $("#publicationYear").val(SelectData["publicationYear"]);
            $("#academicYear").val(SelectData["academicYear"]);
            $("#isbn").prop("disabled", true);
            $("#publication").prop("disabled", true);
           // $("#isbn").val(SelectData["isbn"]);
           // $("#publication").val(SelectData["publication"]);

           childData = SelectData["childMap"];
            $("#departmentCombo").val(childData[1]["departmentCode"]);
            $("#departmentCombo").prop("disabled", true);
            //$("#isbn").prop("disabled", true);
            // $("#publication").prop("disabled", true);
            var lRow = $('[name="memberName"]').last().attr('id').substring(10);
            for (var x = 0; x <= lRow; x++)
            {
                $("#memberName" + x).prop("disabled", false);
                $("#departmentName" + x).prop("disabled", false);
            }
             var lRow=$('[name="memberName"]').last().attr('id').substring(10);
             for(var m = 0;m<=lRow;m++){
             $('.dBookTransactionRow').trigger('click');
             }
              $("#memberID"+lRow).attr("id","memberID1");
              $("#memberType"+lRow).attr("id","memberType1");
              $("#choose" + lRow).attr("id", "choose1");
              $("#departmentCode"+lRow).attr("id","departmentCode1");
              $("#memberName"+lRow).attr("id","memberName1");
              $("#departmentName"+lRow).attr("id","departmentName1");
              $("#row"+lRow).attr("id","row1");
              $("#row1").html("1.");
            
            
            for (var key in childData) {
                if (i != 1) {
                    AddBookTransaction();
                }
                var subrow = childData[i];
                for (var key1 in subrow) {
                    if(key1=="choose"){
                    $("#" + key1 + i).html("<b>"+getType(subrow[key1])+"</b>");   
                    }else{
                    $("#" + key1 + i).val(subrow[key1]);
                }

                }
                i++;
            }

            break;
        case 'Delete':
            getSelectGridData(cupage.pr);
            break;
        
    }
});

function getType(code)
{
    var temp = "";
    if (code == "S")
    {
        temp = "Student";
    } else
    {
        temp = "Faculty";
    }
    return temp;
}

function getCommonMasterTable()
{
    
    var lRow = $('[name="memberName"]').last().attr('id').substring(10);
    for(var x=0;x<=lRow;x++)
        {
        $("#memberName"+x).prop("disabled", true); 
        $("#departmentName"+x).prop("disabled", true); 
        }
    $(".nondecimal").numbernondecimal();
    $("#pagging").getPagging();
    $("#paggingPopUp").getPagging();
    
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
    
    $(".addBookTransactionRow").click('click', function(e) {
        var rowCount = $('#bookTransactionTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#bookTransactionTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddBookTransaction();
        }
    });
    
    $(".dBookTransactionRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.bookTransactionRow1').length)==1){
                $("#memberID1").val("0");
                $("#memberType1").val("");
                $("#departmentCode1").val("");
                $("#memberName1").val("");
                $("#choose1").html("");
                $("#departmentName1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(19);
                 $("#dBookTransactionRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });
    $("#bookTransactionTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    $("#facultyNamestable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    getSelectGridData("0");
    cupage.pr = 0;
    $("#previous").hide();
    $("#first").hide();
    
//    $("#pagging").click(function() {
//        cupage.pr = eval($("#pagging").val());
//    });
    $("#first").click(function() {up
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

function AddBookTransaction(){
    var lRow=$('[name="memberName"]').last().attr('id').substring(10);
    var newRow = $('.bookTransactionRow1:eq(0)').clone(true);
    newRow.insertAfter($('.bookTransactionRow1:last'));
    $(".bookTransactionRow1").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'memberID':
                        {
                            $(this).val("0");
                            break;
                        }
                    case 'memberType':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'departmentCode':
                        {
                            $(this).val("");
                            break;
                        }
                    case 'memberName':
                        {
                            $(this).val("")
                            break;
                        }
                    case 'departmentName':
                        {
                            $(this).val("");
                            break;
                        }
                }
            }
        });
    });
    $("#choose" + (eval(lRow) + 1)).html("");
    $("#row"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dBookTransactionRow"+(eval(lRow))).hide();
    $("#dBookTransactionRow"+(eval(lRow)+1)).show();
    
}

$(function() {
    $("#facultyNames").dialog({
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
    $("#memberName1").click(function() {
        $("#facultyNames").dialog("open");
        currRowNo = (this.id).substr(10, 1);
        $("#searchNames").val("");
        if ($("#member").val() == "S") {
            getStudentNames("0");
        } else
        {
            getStaffNames("0");
        }
    });
});

function getStaffNames(pno)
{
    var totIDS=0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectStaffInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    jData.spg = pno;
    var lRow=$('[name="memberName"]').last().attr('id').substring(10);
    for (var x = 1; x <= lRow; x++)
    {
      totIDS=totIDS+","+$("#memberID" + x).val();
    }
    var arr= totIDS.split(",");
    var str='';
    for (var y = 0; y < arr.length; y++)
    {
     str=str+"'"+arr[y]+"',";
    }
    str=str.substr(0,str.lastIndexOf(","));
    jData.totalStaffIDS =str;
    jData.departmentID = $("#departmentCombo").val();
    jData.bookID = $("#bookID").val();
    jData.searchNames = $("#searchNames").val();
    jData.service = "BookTransactionServlet";
    jData.handller = "selectStaffInfo";
    $(document).getServace(jData);

}

function getStudentsInfo(){
    if ($("#member").val() == "S") {
        getStudentNames("0");
    } else
    {
        getStaffNames("0");
    }
}


function getStudentNames(pno)
{
     var totIDS = 0;
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectStudentInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    jData.spg = pno;
    var lRow = $('[name="memberName"]').last().attr('id').substring(10);
    for (var x = 1; x <= lRow; x++)
    {
        totIDS = totIDS + "," + $("#memberID" + x).val();
    }
    var arr = totIDS.split(",");
    var str = '';
    for (var y = 0; y < arr.length; y++)
    {
        str = str + "'" + arr[y] + "',";
    }
    str = str.substr(0, str.lastIndexOf(","));
    jData.totalStudentIDS = str;
    jData.departmentID = $("#departmentCombo").val();
    jData.searchNames = $("#searchNames").val();
    jData.service = "BookTransactionServlet";
    jData.handller = "selectStudentInfo";
    $(document).getServace(jData);
}


function getSelectStaffInfoInPopUp(){
     var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Faculty Name</th><th style='width: 48%'>Department</th>");
    
     for (var key in selectStaffInfo) {
        table = table + "<tr ondblclick='setNames("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectStaffInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectStaffInfo[key]["memberName"] + "</td><td  style='width: 48%';text-align: left>" + selectStaffInfo[key]["department"] + "</td></tr>";
    }

    $("#facultyNamesBody").html("");
    $("#facultyNamesBody").html("" + table);
   
 $("#popupHeaderTable").css("width",$("#facultyNamesBody").width());
}

function getSelectStudentInfoInPopUp(){
    var table = "";
    $("#popupHeader").html("");
    $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Student Names</th><th style='width: 48%'>Department</th>");

    for (var key in selectStudentInfo) {
        table = table + "<tr ondblclick='setNames(" + key + ")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectStudentInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectStudentInfo[key]["memberName"] + "</td><td  style='width: 48%';text-align: left>" + selectStudentInfo[key]["department"] + "</td></tr>";
    }

    $("#facultyNamesBody").html("");
    $("#facultyNamesBody").html("" + table);

    $("#popupHeaderTable").css("width", $("#facultyNamesBody").width());
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
        if ($("#member").val() == "S") {
            getStudentNames("0");
        } else
        {
            getStaffNames("0");
        }
        getSelectGridData("0");
    }
});

function setNames(key)
{
   if($("#member").val() == "S") {
        $("#memberID" + currRowNo).val(selectStudentInfo[key]["memberID"]);
        $("#memberType" + currRowNo).val(selectStudentInfo[key]["memberType"]);
        $("#choose" + currRowNo).html("<b>" + getType(selectStudentInfo[key]["memberType"]) + "</b>");
        $("#memberName" + currRowNo).val(selectStudentInfo[key]["memberName"]);
        $("#departmentCode" + currRowNo).val(selectStudentInfo[key]["departmentCode"]);
        $("#departmentName" + currRowNo).val(selectStudentInfo[key]["department"]);      
    }else
        {
        $("#memberID" + currRowNo).val(selectStaffInfo[key]["memberID"]);
        $("#memberType" + currRowNo).val(selectStaffInfo[key]["memberType"]);
        $("#choose" + currRowNo).html("<b>" + getType(selectStaffInfo[key]["memberType"]) + "</b>");
        $("#memberName" + currRowNo).val(selectStaffInfo[key]["memberName"]);
        $("#departmentCode" + currRowNo).val(selectStaffInfo[key]["departmentCode"]);
        $("#departmentName" + currRowNo).val(selectStaffInfo[key]["department"]);      
        }
    $("#facultyNames").dialog("close");
}

function formsubmit()
{
    
    if (jQuery.trim($('#departmentCombo').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentCombo').focus();
        return false;
        }
        
    /*f (jQuery.trim($('#bookCode').val()) == "") {
        alert("Please Enter the Book Code.");
        $('#bookCode').focus();
        return false; 
    } */
     if (jQuery.trim($('#bookTitle1').val()) =="") {
        alert("Please Enter the Book Title1.");
        $('#bookTitle1').focus();
        return false;
    }
    if (jQuery.trim($('#bookNature').val()) ==0) {
        alert("Please Select the Book Nature.");
        $('#bookNature').focus();
        return false;
    }
    if (jQuery.trim($('#role').val()) ==0) {
        alert("Please Select the Role.");
        $('#role').focus();
        return false;
    }
    if (jQuery.trim($('#publicationYear').val()) =="") {
        alert("Please Enter the Publication Year.");
        $('#publicationYear').focus();
        return false;
    }
    if (jQuery.trim($('#academicYear').val()) ==0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        return false;
    }
   
    
//    if($('#bookNature option:selected').text()=="Chapter" && $('#bookChapter').val()=="")
//        {
//            alert("Please Enter the Book Chapter.");
//            $('#bookChapter').focus();
//            return false;
//        }
        
        
        
        
    var count=0;
    var lRow = $('[name="memberName"]').last().attr('id').substring(10);
    for (var x = 0; x <= lRow; x++)
    {
        if ($("#memberName" + x).val() != "" && $("#departmentName" + x).val())
        {
         count=1;
        }
    }
    if (count == 0)
    {
     alert("Please Enter atleast one Faculty/Student Name and Department Name.");
     return false;
    }
    var lRow=$('[name="memberName"]').last().attr('id').substring(10);
    var staffNamesDataList=[];
    for(var i=1;i<=lRow;i++){
        if($("#memberID"+i).val()!="0"){
        var staffNamesData={};
        
        staffNamesData.companyID=$("#compsession").val();
        staffNamesData.bookID=$("#bookID").val();
        staffNamesData.employeeType=$("#memberType"+i).val();
        staffNamesData.staffID=$("#memberID"+i).val();
        staffNamesData.departmentCode=$("#departmentCode"+i).val();
        staffNamesData.entryBy=$("#entryBy").val();
        staffNamesDataList.push(staffNamesData);
        }
    }
    jData = {};
    jData.bookID = $("#bookID").val();
    jData.companyID = $("#compsession").val();
    jData.transactionDate=$("#transactionDate").val();
    jData.role=$("#role").val();
    jData.bookCode=$("#bookCode").val();
    jData.bookTitle1=$("#bookTitle1").val();
    jData.bookTitle2=$("#bookTitle2").val();
    jData.bookNature=$("#bookNature").val();
    jData.publicationYear = $("#publicationYear").val();
    jData.academicYear = $("#academicYear").val();
    jData.bookRemarks = $("#bookRemarks").val();
    jData.bookChapter = $("#bookChapter").val();
    jData.apiScore = $("#apiScore").val();
    jData.entryBy = $("#entryBy").val();
    jData.isbn = $("#isbn").val();
    jData.publication = $("#publication").val();
    jData.service = "BookTransactionServlet";
    jData.handller = "saveupdate";
    jData.para = staffNamesDataList;
    $(document).getServace(jData);
}



function resetValues()
{
    $("#bookID").val("0");
    $("#bookCode").val("");
    $("#bookTitle1").val("");
    $("#bookNature").val("0");
    $("#bookTitle2").val("");
    $("#role").val("0");
    $("#bookChapter").val("");
    $("#publicationYear").val("");
    $("#academicYear").val("");
    $("#apiScore").val("");
    $("#bookRemarks").val("");
    $("#memberID1").val("0");
    $("#memberType1").val("");
    $("#departmentCode1").val("");
    $("#memberName1").val("");
    $("#departmentName1").val("");
    $("#departmentCombo").val("");
    $("#departmentCombo").prop("disabled", false);
    $("#isbn").val("");
    $("#publication").val("");
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
    jData.service = "BookTransactionServlet";
    jData.handller = "select";

    $(document).getServace(jData);
}

function getGridData() {
    $("#mastergrid").yattable({
        width: "100%",
        height: 200,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 10%'>Book Title1</th><th style='width: 10%'>Book Title2</th><th style='width: 10%'>Book Nature</th><th style='width: 15%'>Publication Year</th><th style='width: 10%'>Book Remarks</th><th style='width: 10%'>API Score</th><th style='width: 10%'>Book Chapter</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        var booktitle2 = gridData[key]["bookTitle2"];
        var bookchapter = gridData[key]["bookChapterName"];
        var bookRemarks=gridData[key]["bookRemarks"];
        var apiScore= gridData[key]["apiScore"];
        if (booktitle2 == null)
        {
            booktitle2 = "";
        }
        if (bookchapter == null)
        {
            bookchapter = "";
        }
        if (bookRemarks == null)
        {
            bookRemarks = "";
        }
        if (apiScore == null)
        {
            apiScore = "";
        }
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 10%'>" + gridData[key]["bookTitle1"] + "</td>";
        table = table + "<td  style='width: 10%'>" + booktitle2 + "</td><td  style='width: 10%'>" + getBookNature(gridData[key]["bookNature"]) + "</td><td  style='width: 15%'>" + gridData[key]["publicationYear"]+ "</td>";
        table = table + "<td  style='width: 10%'>" + bookRemarks + "</td><td  style='width: 10%'>" + apiScore+ "</td><td  style='width: 10%'>" + bookchapter + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["bookID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["bookID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function updateMasterRecord(bookid)
{
    jData = {};
    jData.service = "BookTransactionServlet";
    jData.handller = "SelectforUpdate";
    jData.bookID = bookid;
    $(document).getServace(jData);
}

function deleteMasterRecord(bookid)
{
    
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "BookTransactionServlet";
        jData.handller = "Delete";
        jData.bookID = bookid;
        $(document).getServace(jData);
    }
    else {
    }

}

function getBookNature(bookNatureCode)
{
    var tempVal = "";
    if (bookNatureCode == "C")
    {
        tempVal = "Case Study";
    } else if (bookNatureCode == "T")
    {
        tempVal = "Technical Report";
    } else
    {
        tempVal = "Project Report";
    }
    return tempVal;   
}

function getMemberNames(pNo)
{
 if ($("#member").val() == "S") {
        getStudentNames(pNo);
    } else
    {
        getStaffNames(pNo);
    }   
}

function getVisible()
{
    if ($("#departmentCombo").val() != 0)
    {
        var lRow = $('[name="memberName"]').last().attr('id').substring(10);
        for (var x = 0; x <= lRow; x++)
        {
            $("#memberName" + x).prop("disabled", false);
            $("#departmentName" + x).prop("disabled", false);
        }
        $("#departmentCombo").prop("disabled", true);
    } else
    {
        var lRow = $('[name="memberName"]').last().attr('id').substring(10);
        for (var x = 0; x <= lRow; x++)
        {
            $("#memberName" + x).prop("disabled", true);
            $("#departmentName" + x).prop("disabled", true);
        }
    }
}

