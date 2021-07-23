/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var rc = 0;
var cupage = {};
var gridData = {};
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

        case 'saveUpdate':
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
            var guestLectureData = {};
            var industryVisitedData = {};
            var industryLedTrainingData = {};
            var i = 1;
            var j = 1;
            var k = 1;
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#transactionID").val(SelectData["transactionID"]);
            $("#transactionDate").val(SelectData["transactionDate"]);
            $("#departmentName").val(SelectData["departmentCode"]);
            $("#rdLab").val(SelectData["randDLabDetails"]);
            $("#scholarship").val(SelectData["scholarFellowshipDetails"]);
            $("#collaborativeDegree").val(SelectData["collaborativeDegreeDetails"]);
            $("#authorshipAttribution").val(SelectData["authorShipAttributionDetails"]);
            $("#industrySupport").val(SelectData["industrySupportDetails"]);
            $("#giftCompensation").val(SelectData["giftCompensationDetails"]);
            $("#industryRelatedActivity").val(SelectData["industryRelatedActivityDetails"]);
            if (SelectData["hodApproval"] == 'Y')
            {
                $("#approvalOfHODY").prop("checked", true);
            } else
            {
                $("#approvalOfHODN").prop("checked", true)
            }
            if (SelectData["vcApproval"] == 'Y')
            {
                $("#approvalOfVCY").prop("checked", true);
            } else
            {
                $("#approvalOfVCN").prop("checked", true)
            }
            $("#programRemarks").val(SelectData["programRemarks"]);
            guestLectureData = SelectData["guestLectureMap"];
            for (var key in guestLectureData) {
                if (i != 1) {
                    AddGuestLecture();
                }
                var subrow = guestLectureData[i];
                for (var key1 in subrow) {
                    $("#" + key1 + i).val(subrow[key1]);

                }
                i++;
            }

            industryVisitedData = SelectData["industryVisitedMap"];
            for (var key2 in industryVisitedData) {
                if (j != 1) {
                    AddIndustryVisited();
                }
                var subrow1 = industryVisitedData[j];
                for (var key3 in subrow1) {
                    $("#" + key3 + j).val(subrow1[key3]);

                }
                j++;
            }
            industryLedTrainingData = SelectData["industryLedTrainingMap"];
            for (var key4 in industryLedTrainingData) {
                if (k != 1) {
                    AddIndustryLedTraining();
                }
                var subrow2 = industryLedTrainingData[k];
                for (var key5 in subrow2) {
                    $("#" + key5 + k).val(subrow2[key5]);

                }
                k++;
            }
            break;
        case 'Delete':
            getSelectGridData(cupage.pr);
            break;
           
        
    }
});

$(function() {
$( "#tabs" ).tabs();
});
function getCommonMasterTable()
{
    
    
    $(".number").numeric();
    $(".nondecimal").numbernondecimal();
    $(".nametext").alphanumeric();
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
    ///////////////////////////////

   
    $(".addGuestLectureRow").click('click', function(e) {
        var rowCount = $('#guestLectureTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#guestLectureTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddGuestLecture();
        }
    });
    
     $(".addIndustryVisitedRow").click('click', function(e) {
        var rowCount = $('#industryVisitedTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#industryVisitedTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddIndustryVisited();
        }
    });
    $(".addIndustryLedTrainingRow").click('click', function(e) {
        var rowCount = $('#industryLedTrainingTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#industryLedTrainingTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddIndustryLedTraining();
        }
    });
    $("#guestLectureTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    $("#industryVisitedTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    $("#industryLedTrainingTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    });
    
    $(".dGuestLectureRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.guestLectureRow1').length)==1){
              $("#guestLectureName1").val("");$("#topic1").val("");$("#glFromDate1").val(""); $("#glToDate1").val("");$("#guestLectureNoOfParticipants1").val("");$("#guestLectureRemarks1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(16);
                 $("#dGuestLectureRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });
    
    $(".dIndustryVisitedRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.industryVisitedRow1').length)==1){
              $("#industryVisitedName1").val("");$("#tourDetails1").val("");$("#ivFromDate1").val(""); $("#ivToDate1").val("");$("#industryVisitedNoOfParticipants1").val("");$("#industryVisitedRemarks1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(19);
                 $("#dIndustryVisitedRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });
    $(".dIndustryLedTrainingRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.industryLedTrainingRow1').length)==1){
              $("#industryLedTrainingName1").val("");$("#topicOfTheTraining1").val("");$("#itFromDate1").val(""); $("#itToDate1").val("");$("#industryLedTrainingNoOfParticipants1").val("");$("#industryLedTrainingRemarks1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(23);
                 $("#dIndustryLedTrainingRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });
}


function AddGuestLecture(){
    var lRow=$('[name="guestLectureName"]').last().attr('id').substring(16);
    var newRow = $('.guestLectureRow1:eq(0)').clone(true);
    newRow.insertAfter($('.guestLectureRow1:last'));
    $(".guestLectureRow1").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'guestLectureName':{
                        $(this).val("");break;
                    }
                    case 'topic':{
                        $(this).val("");break;
                    }
                    case 'glFromDate':{
                        $(this).val("");break;
                    }
                    case 'glToDate':{
                        $(this).val("");break;
                    }
                    case 'guestLectureNoOfParticipants':{
                        $(this).val("");break;
                    }
                    case 'guestLectureRemarks':{
                        $(this).val("");break;
                    }
                }
            }
        });
    });
    $("#firstRow"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dGuestLectureRow"+(eval(lRow))).hide();
    $("#dGuestLectureRow"+(eval(lRow)+1)).show();
    jQuery(".date").removeClass("hasDatepicker").datepicker({
        dateFormat: 'dd-mm-yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+0'
    });
}

function AddIndustryVisited(){
    var lRow=$('[name="industryVisitedName"]').last().attr('id').substring(19);
    var newRow = $('.industryVisitedRow1:eq(0)').clone(true);
    newRow.insertAfter($('.industryVisitedRow1:last'));
    $(".industryVisitedRow1").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'industryVisitedName':{
                        $(this).val("");break;
                    }
                    case 'tourDetails':{
                        $(this).val("");break;
                    }
                    case 'ivFromDate':{
                        $(this).val("");break;
                    }
                    case 'ivToDate':{
                        $(this).val("");break;
                    }
                    case 'industryVisitedNoOfParticipants':{
                        $(this).val("");break;
                    }
                    case 'industryVisitedRemarks':{
                        $(this).val("");break;
                    }
                }
            }
        });
    });
    $("#SecondRow"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dIndustryVisitedRow"+(eval(lRow))).hide();
    $("#dIndustryVisitedRow"+(eval(lRow)+1)).show();
    jQuery(".date").removeClass("hasDatepicker").datepicker({
        dateFormat: 'dd-mm-yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+0'
    });
}

function AddIndustryLedTraining(){
    var lRow=$('[name="industryLedTrainingName"]').last().attr('id').substring(23);
    var newRow = $('.industryLedTrainingRow1:eq(0)').clone(true);
    newRow.insertAfter($('.industryLedTrainingRow1:last'));
    $(".industryLedTrainingRow1").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'industryLedTrainingName':{
                        $(this).val("");break;
                    }
                    case 'topicOfTheTraining':{
                        $(this).val("");break;
                    }
                    case 'itFromDate':{
                        $(this).val("");break;
                    }
                    case 'itToDate':{
                        $(this).val("");break;
                    }
                    case 'industryLedTrainingNoOfParticipants':{
                        $(this).val("");break;
                    }
                    case 'industryLedTrainingRemarks':{
                        $(this).val("");break;
                    }
                }
            }
        });
    });
    $("#ThirdRow"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dIndustryLedTrainingRow"+(eval(lRow))).hide();
    $("#dIndustryLedTrainingRow"+(eval(lRow)+1)).show();
    jQuery(".date").removeClass("hasDatepicker").datepicker({
        dateFormat: 'dd-mm-yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+0'
    });
}

function formsubmit()
{
    if (jQuery.trim($('#transactionDate').val()) == "") {
        alert("Please Enter Transaction Date.");
        $('#transactionDate').focus();
        return false;
    }
    if (jQuery.trim($('#departmentName').val()) == 0) {
        alert("Please Select Department Name.");
        $('#departmentName').focus();
        return false;
    }
    if (jQuery.trim($('#rdLab').val()) == "") {
        alert("Please Enter Details of Industry Sponsored R&D Lab.At Institute.");
        $('#rdLab').focus();
        return false;
    }
    if (jQuery.trim($('#scholarship').val()) == "") {
        alert("Please Enter Details of Industry Sponsored Scholarship/Fellowships for Students.");
        $('#scholarship').focus();
        return false;
    }
    if (jQuery.trim($('#collaborativeDegree').val()) == "") {
        alert("Please Enter Details Of Collaborative Degree Program in Department.");
        $('#collaborativeDegree').focus();
        return false;
    }
    if (jQuery.trim($('#authorshipAttribution').val()) == "") {
        alert("Please Enter Details Of Authorship & Attribution Of Joint Article,Publications,and Presentations.");
        $('#authorshipAttribution').focus();
        return false;
    }
    if (jQuery.trim($('#industrySupport').val()) == "") {
        alert("Please Enter Details Of Industry Support For Education Conferences and Meetings/Social Events.");
        $('#industrySupport').focus();
        return false;
    }
    if (jQuery.trim($('#giftCompensation').val()) == "") {
        alert("Please Enter Details Of Gift & Compensation Received By Any Teaching/Non-Teaching Staff.");
        $('#giftCompensation').focus();
        return false;
    }
    if (jQuery.trim($('#industryRelatedActivity').val()) == "") {
        alert("Please Enter Other Industry Related Activities To Be Conducted By Department.");
        $('#industryRelatedActivity').focus();
        return false;
    }
    if ($('input[name=approvalOfHOD]:checked').length <= 0)
    {
        alert("Please choose Approval Of HOD ");
        return false;
    }
    if ($('input[name=approvalOfVC]:checked').length <= 0)
    {
        alert("Please choose Approval Of VC ");
        return false;
    }
    if (jQuery.trim($('#guestLectureName1').val()) == "") {
        alert("Please Enter Guest Lecture Name.");
        $('#guestLectureName1').focus();
        return false;
    }
    if (jQuery.trim($('#topic1').val()) == "") {
        alert("Please Enter Topic.");
        $('#topic1').focus();
        return false;
    }
    if (jQuery.trim($('#glFromDate1').val()) == "") {
        alert("Please Enter From Date.");
        $('#glFromDate1').focus();
        return false;
    }
    if (jQuery.trim($('#glToDate1').val()) == "") {
        alert("Please Enter To Date.");
        $('#glToDate1').focus();
        return false;
    }
    if (jQuery.trim($('#guestLectureNoOfParticipants1').val()) == "") {
        alert("Please Enter No. Of Participants.");
        $('#guestLectureNoOfParticipants1').focus();
        return false;
    }
    
    $("#tabs").tabs("option", "active", eval("1"));
    
    if (jQuery.trim($('#industryVisitedName1').val()) == "") {
        alert("Please Enter Name of Industry Visited/Tours.");
        $('#industryVisitedName1').focus();
        return false;
    }
    if (jQuery.trim($('#tourDetails1').val()) == "") {
        alert("Please Enter Tour Details.");
        $('#tourDetails1').focus();
        return false;
    }
    if (jQuery.trim($('#ivFromDate1').val()) == "") {
        alert("Please Enter From Date.");
        $('#ivFromDate1').focus();
        return false;
    }
    if (jQuery.trim($('#ivToDate1').val()) == "") {
        alert("Please Enter To Date.");
        $('#ivToDate1').focus();
        return false;
    }
    if (jQuery.trim($('#industryVisitedNoOfParticipants1').val()) == "") {
        alert("Please Enter No. Of Participants.");
        $('#industryVisitedNoOfParticipants1').focus();
        return false;
    }
    
    $("#tabs").tabs("option", "active", eval("2"));
    
     if (jQuery.trim($('#industryLedTrainingName1').val()) == "") {
        alert("Please Enter Name of Industry-Led Training Name.");
        $('#industryLedTrainingName1').focus();
        return false;
    }
    if (jQuery.trim($('#topicOfTheTraining1').val()) == "") {
        alert("Please Enter Topic of the Training.");
        $('#topicOfTheTraining1').focus();
        return false;
    }
    if (jQuery.trim($('#itFromDate1').val()) == "") {
        alert("Please Enter From Date.");
        $('#itFromDate1').focus();
        return false;
    }
    if (jQuery.trim($('#itToDate1').val()) == "") {
        alert("Please Enter To Date.");
        $('#itToDate1').focus();
        return false;
    }
    if (jQuery.trim($('#industryLedTrainingNoOfParticipants1').val()) == "") {
        alert("Please Enter No. Of Participants.");
        $('#industryLedTrainingNoOfParticipants1').focus();
        return false;
    }
    
    
    
    var lRow=$('[name="guestLectureName"]').last().attr('id').substring(16);
    var guestLectureDetailsList=[];
    for(var i=1;i<=lRow;i++){
       
        var guestLectureData={};
        guestLectureData.guestLectureID=$("#guestLectureID"+i).val();
        guestLectureData.guestLectureName=$("#guestLectureName"+i).val();
        guestLectureData.topic=$("#topic"+i).val();
        guestLectureData.glFromDate=$("#glFromDate"+i).val();
        guestLectureData.glToDate=$("#glToDate"+i).val();
        guestLectureData.guestLectureNoOfParticipants=$("#guestLectureNoOfParticipants"+i).val();
        guestLectureData.guestLectureRemarks=$("#guestLectureRemarks"+i).val();
        guestLectureDetailsList.push(guestLectureData);
    }
    
    
    
    
    var lRow=$('[name="industryVisitedName"]').last().attr('id').substring(19);
    var industryVisitedDetailsList=[];
    for(var i=1;i<=lRow;i++){
       
        var industryVisitedData={};
        industryVisitedData.industryVisitedNameID=$("#industryVisitedNameID"+i).val();
        industryVisitedData.industryVisitedName=$("#industryVisitedName"+i).val();
        industryVisitedData.tourDetails=$("#tourDetails"+i).val();
        industryVisitedData.ivFromDate=$("#ivFromDate"+i).val();
        industryVisitedData.ivToDate=$("#ivToDate"+i).val();
        industryVisitedData.industryVisitedNoOfParticipants=$("#industryVisitedNoOfParticipants"+i).val();
        industryVisitedData.industryVisitedRemarks=$("#industryVisitedRemarks"+i).val();
        industryVisitedDetailsList.push(industryVisitedData);
    }
    
    var lRow=$('[name="industryLedTrainingName"]').last().attr('id').substring(23);
    var industryLedTrainingDetailsList=[];
    for(var i=1;i<=lRow;i++){
       
        var industryLedTrainingData={};
        industryLedTrainingData.industryLedTrainingID=$("#industryLedTrainingID"+i).val();
        industryLedTrainingData.industryLedTrainingName=$("#industryLedTrainingName"+i).val();
        industryLedTrainingData.topicOfTheTraining=$("#topicOfTheTraining"+i).val();
        industryLedTrainingData.itFromDate=$("#itFromDate"+i).val();
        industryLedTrainingData.itToDate=$("#itToDate"+i).val();
        industryLedTrainingData.industryLedTrainingNoOfParticipants=$("#industryLedTrainingNoOfParticipants"+i).val();
        industryLedTrainingData.industryLedTrainingRemarks=$("#industryLedTrainingRemarks"+i).val();
        industryLedTrainingDetailsList.push(industryLedTrainingData);
    }
     
    jData = {};
    jData.transactionID = $("#transactionID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.transactionDate=$("#transactionDate").val();
    jData.departmentName=$("#departmentName").val();
    jData.rdLab=$("#rdLab").val();
    jData.scholarship=$("#scholarship").val();
    jData.collaborativeDegree=$("#collaborativeDegree").val();
    jData.authorshipAttribution=$("#authorshipAttribution").val();
    jData.industrySupport=$("#industrySupport").val();
    jData.giftCompensation=$("#giftCompensation").val();
    jData.industryRelatedActivity=$("#industryRelatedActivity").val();
    if ($("#approvalOfHODY").prop("checked")) {
        jData.approvalOfHOD="Y";
    }
    if ($("#approvalOfHODN").prop("checked")) {
        jData.approvalOfHOD="N";
    }
    if ($("#approvalOfVCY").prop("checked")) {
        jData.approvalOfVC = "Y";
    }
    if ($("#approvalOfVCN").prop("checked")) {
        jData.approvalOfVC = "N";
    }
    jData.programRemarks = $("#programRemarks").val();
    jData.entryBy = $("#entryBy").val();
    
    jData.service = "IndustrialInteractionsServlet";
    jData.handller = "saveUpdate";
    jData.para = guestLectureDetailsList;
    jData.para1=industryVisitedDetailsList;
    jData.para2=industryLedTrainingDetailsList;
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
    jData.service = "IndustrialInteractionsServlet";
    jData.handller = "select";

    $(document).getServace(jData);
}

function getGridData() {
    $("#mastergrid").yattable({
        width: "100%",
        height: 100,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 17%'>Transaction ID</th><th style='width: 17%'>Transaction Date</th><th style='width: 17%'>Department </th><th style='width: 17%'>R&D Lab.At Institute</th><th style='width: 17%'>Industry Related Activity</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 17%'>" + gridData[key]["transactionID"] + "</td><td  style='width: 17%'>" + gridData[key]["transactiondate"] + "</td><td  style='width: 17%'>" + gridData[key]["department"] + "</td>";
        table = table + "<td  style='width: 17%'>" + gridData[key]["rdLab"] + "</td><td  style='width: 17%'>" + gridData[key]["industryRelatedActivity"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["transactionID"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["transactionID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function updateMasterRecord(transactionID)
{
    jData = {};
    jData.service = "IndustrialInteractionsServlet";
    jData.handller = "SelectforUpdate";
    jData.transactionID = transactionID;
    $(document).getServace(jData);
}

function deleteMasterRecord(transactionID)
{
   var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "IndustrialInteractionsServlet";
        jData.handller = "Delete";
        jData.transactionID = transactionID;
        $(document).getServace(jData);
    }
    else {
    }

}

function resetValues()
{
    $("#transactionID").val("0");
    $("#departmentName").val("");
    $("#rdLab").val("");
    $("#scholarship").val("");
    $("#collaborativeDegree").val("");
    $("#authorshipAttribution").val("");
    $("#industrySupport").val("");
    $("#giftCompensation").val("");
    $("#industryRelatedActivity").val("");
    $("#programRemarks").val("");
    $("input:radio").attr("checked", false);
    location.reload(true); 
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getSelectGridData("0");
    }
});