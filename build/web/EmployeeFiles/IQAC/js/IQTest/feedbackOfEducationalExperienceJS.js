/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var rc=0;
var gridData = {};
var lowerGridData = {};
var tempValue="";
var flag2="";
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
        case 'feedbackID':
            var d = new Date();
            var month = d.getMonth() + 1;
            var day = d.getDate();
            var output = (day < 10 ? '0' : '') + day + '-' + (month < 10 ? '0' : '') + month + '-' + d.getFullYear();
            $("#transactionDate").val(output);
            $("#feedbackName").val(xhr.responseText);
            var res = xhr.responseText.substring(0, 11);
            var feedbackID = res;
            $("#feedbackID").val(feedbackID);
            getQuestions(feedbackID);
            getValidate();
            break;
        case 'courseCodeCombo':
            $("#courseCode1").empty();
            $("#courseCode1").append(xhr.responseText);
            break;
        case 'gradeObtainedCombo':
            var comboData = jQuery.parseJSON(xhr.responseText);
            $("#gradeObtained" + comboData["rownum"]).empty();
            $("#gradeObtained" + comboData["rownum"]).append(comboData["combo"]);
            break;
        case 'saveupdate':
            resetValues();
            location.reload();
            break;
        case 'validateData':
            flag2 = xhr.responseText;
            break;
        case 'lowerGrid':
            lowerGridData = jQuery.parseJSON(xhr.responseText);
            getSelectGridData();
            break;
        case 'checkExpiryDate':
            tempValue = xhr.responseText;

            if (tempValue == "false")
            {
                for (var key in gridData)
                {
                    $('#rating' + key).attr('disabled', true);
                    $('#remarks' + key).attr('disabled', true);
                }
             var lRow=$('[name="courseCode"]').last().attr('id').substring(10);
             for(var t=1;t<=lRow;t++)
                 {
                      $("#courseCode"+t).prop("disabled", true);
                      $("#courseName"+t).prop("disabled", true);
                      $("#courseCredit"+t).prop("disabled", true);
                      $("#gradeObtained"+t).prop("disabled", true);
                     
                 }
            }
            break;
        case 'selectDataForUpgrade':
            resetValues();
            var mainData = {};
            var headerData={};
            var questionData={};
            var courseCreditData={};
            mainData = jQuery.parseJSON(xhr.responseText);
            
            headerData=mainData["headerMap"];
            if(headerData["transactionID"]==undefined)
                {
                   $("#transactionID").val("0");   
                }else{
                  $("#transactionID").val(headerData["transactionID"]);  
                }
                if(headerData["apFeedbackID"]==undefined)
                {
                   $("#feedbackID").val("0");   
                }else{
                  $("#feedbackID").val(headerData["apFeedbackID"]);  
                }
                
            $("#transactionDate").val(headerData["transactiondate"]);
            $("#departmentName").val(headerData["departmentCode"]);
            $("#exchangeProgramName").val(headerData["nameOfExchangeProgram"]);
            $("#universityVisitedAbroad").val(headerData["universityVisitedAbroad"]);
            $("#departmentNameVisited").val(headerData["departmentCodeAbroad"]);
            $("#fromDate").val(headerData["durationFromDate"]);
            $("#toDate").val(headerData["durationToDate"]);
            $("#purposeOfTheVisit").val(headerData["purposeOfVisit"]);
            
            
             questionData = mainData["questionMap"];
            for (var key1 in questionData) {
                for (var key in gridData) {
                    //$("#rating" + key).val("");
                    if (gridData[key]["questionid"] == questionData[key1]["questionID"]) {
                        var temp=questionData[key1]["rating"];
                        if(temp==null)
                            {
                                temp="";
                            }
                            
                        $("#rating" + key).val(temp);
                        if (questionData[key1]["rating"] == null) {
                            var rMarks=questionData[key1]["userRemarks"];
                            if(rMarks==null || rMarks=='null')
                                {
                                 rMarks="";   
                                }
                                
                            $("#rating" + key).val(rMarks);
                        }
                        $("#remarks" + key).val(questionData[key1]["questionRemarks"]);
                        continue;

                    }

                }
            }
             var lRow=$('[name="courseCode"]').last().attr('id').substring(10);
             for(var m = 0;m<=lRow;m++){
             $('.dCourseCodeRow').trigger('click');
             }
              $("#courseCode"+lRow).attr("id","courseCode1");
              $("#courseName"+lRow).attr("id","courseName1");
              $("#courseCredit"+lRow).attr("id","courseCredit1");
              $("#gradeObtained"+lRow).attr("id","gradeObtained1");
              $("#row"+lRow).attr("id","row1");
              $("#row1").html("1.");
            var propertyNames = Object.keys(gridData);
            gridLength=(propertyNames.length-1);
            courseCreditData=mainData["courseCreditMap"];
            var i=1;
            for (var key2 in courseCreditData)
            {
                if (i != 1) {
                    AddCourseCodeRow();
                }
             $("#courseCode"+key2).val(courseCreditData[key2]["programCode"]);
             getCourseName("courseCode"+key2,courseCreditData[key2]["gradeObtained"]);
             $("#courseCredit"+key2).val(courseCreditData[key2]["courseCredit"]);
            // $("#gradeObtained"+key2).val(courseCreditData[key2]["gradeObtained"]);
             i++;
            }
            
            if (tempValue == "false")
            {
            for(var key in gridData)
                {
                    $('#rating'+key).attr('disabled', true);
                    $('#remarks'+key).attr('disabled', true);
                }
            var lRow=$('[name="courseCode"]').last().attr('id').substring(10);
           for(var t=1;t<=lRow;t++)
                 {
                      $("#courseCode"+t).prop("disabled", true);
                      $("#courseName"+t).prop("disabled", true);
                      $("#courseCredit"+t).prop("disabled", true);
                      $("#gradeObtained"+t).prop("disabled", true);
                     
                 }
            }
            break;
        case 'selectProgramName':
            var selectData=jQuery.parseJSON(xhr.responseText);
            $("#courseName"+selectData["rownum"]).val(selectData["courseName"]);
            getGradeObtainedCombo(selectData["courseCode"],selectData["rownum"],selectData["preselect"]);
            break;
        case 'selectGridData':
            gridData = jQuery.parseJSON(xhr.responseText);
            
            getGridData(gridData);
           // getTransactionID();
           if (tempValue == "false")
            {
                for (var key in gridData)
                {
                    $('#rating' + key).attr('disabled', true);
                    $('#remarks' + key).attr('disabled', true);
                }
             var lRow=$('[name="courseCode"]').last().attr('id').substring(10);
             for(var t=1;t<=lRow;t++)
                 {
                      $("#courseCode"+t).prop("disabled", true);
                      $("#courseName"+t).prop("disabled", true);
                      $("#courseCredit"+t).prop("disabled", true);
                      $("#gradeObtained"+t).prop("disabled", true);
                     
                 }
            }
            break;

    }
});


function getCommonMasterTable()
{
    $(".number").numeric();
    $(".addCourseCodeRow").click('click', function(e) {
        var rowCount = $('#courseCodeTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#courseCodeTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddCourseCodeRow();
        }
    });
    
    
    $(".dCourseCodeRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.courseCodeRow1').length)==1){
              $("#courseCode1").val("");$("#courseName1").val("");$("#courseCredit1").val(""); $("#gradeObtained1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(14);
                 $("#dCourseCodeRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });
    
    $("#courseCodeTable").yattable({
        width: "100%",
        height: 120,
        scrolling: "yes"
    });
    getCourseCodeCombo();
    getLowerGrid();
    getCheckExpiryDate();
    
} 

function AddCourseCodeRow(){
    var lRow=$('[name="courseCode"]').last().attr('id').substring(10);
    var newRow = $('.courseCodeRow1:eq(0)').clone(true);
    newRow.insertAfter($('.courseCodeRow1:last'));
    $(".courseCodeRow1").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'courseCode':{
                        $(this).val("");break;
                    }
                    case 'courseName':{
                        $(this).val("");break;
                    }
                    case 'courseCredit':{
                        $(this).val("");break;
                    }
                    case 'gradeObtained':{
                        $(this).val("");break;
                    }
                    
                }
            }
        });
    });
    $("#row"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dCourseCodeRow"+(eval(lRow))).hide();
    $("#dCourseCodeRow"+(eval(lRow)+1)).show();
    
}

function getFeedBackID()
{
    jData = {};
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.handller = "feedbackID";
    $(document).getServace(jData);  
}

function getCourseCodeCombo()
{
    jData = {};
    jData.service = "CourseCodeComboServlet";
    jData.handller = "courseCodeCombo";
    jData.comboId = "courseCodeCombo";
    $(document).getServace(jData);  
}

function getCourseName(id,gradeObtained)
{
    
    jData = {};
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.handller = "selectProgramName";
    jData.rowno = id.substr(10);
    jData.courseCode = $("#" + id).val();
    if (gradeObtained == undefined)
    {
        jData.preselect = "0";
    } else
    {
        jData.preselect =encodeURIComponent(gradeObtained);
    }
    $(document).getServace(jData); 
}

function getQuestions(feedbackID)
{
    jData = {};
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.handller = "selectGridData";
    jData.feedbackid = feedbackID;
    $(document).getServace(jData);
}

function getGridData()
{
     $("#mastergrid").yattable({
        width: "100%",
        height: 300,
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
     $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 33%'>Questions</th><th style='width: 31%'>Rating</th><th style='width: 31%'>Remarks</th>");
     // $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 50%'>Questions</th><th style='width: 45%'>Feedback/Rating</th>");
    for (var key in gridData) {
        if(gridData[key]["slno"]!=undefined){
        if(gridData[key]["flag"]=='Y'){
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["questionbody"] + "</td><td  style='width: 31%'></td><td  style='width: 31%'></td>";   
            }else{
          if(gridData[key]["color"]=="blue"){
           table = table + "<tr><td  style='width: 5%;color:blue'>" + gridData[key]["slno"] + "</td><td  style='width: 33%;color:blue'>" + gridData[key]["questionbody"] + "</td><td  style='width: 31%'>"+getRating(gridData["rating"][gridData[key]["ratingid"]],key)+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' style='width:75%' maxlength='100'></td>";         
          }else
          {
           table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 33%'>" + gridData[key]["questionbody"] + "</td><td  style='width: 31%'>"+getRating(gridData["rating"][gridData[key]["ratingid"]],key)+"</td><td  style='width: 31%'><input type='text' class='textbox' id='remarks"+key+"' style='width:75%' maxlength='100'></td>";            
          }
            }
    }
    }
    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());
}
function getRating(li,key) {
    
    var op="";
    if (li != undefined) {
        var opli = jQuery.parseJSON(li);
        if(opli.length==1){
          op = op+"<input type='text' id='rating"+key+"' size='12' class='textbox' style='width:75%'>"  
        }else{
            var sec="";
             sec = sec+"<option value='' selected>Select Rating</option>"
        for (var k = 0; k < opli.length; k++) {
            var ril=opli[k].split("@@");
             sec = sec+"<option value='"+ril[0]+"'>"+ril[1]+"</option>"
        }
        op =op+"<select id='rating"+key+"' class='combo' style='width:80%'>"+sec+"</select>"
        }
    }
    return op;
}


function getTransactionID()
{
    
    jData = {};
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.handller = "selectData";
    jData.feedbackid = $("#feedbackID").val();
    $(document).getServace(jData);
}

function getGradeObtainedCombo(courseCode,rownum,preselect)
{
    
    jData = {};
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.handller = "gradeObtainedCombo";
    jData.courseCode = courseCode;
    jData.rownum = rownum;
    jData.preselect =encodeURIComponent(preselect);
    $(document).getServace(jData);
}

function formsubmit()
{
    if(tempValue=="false")
        {
            return false;
        }
    if (jQuery.trim($('#transactionDate').val()) == "") {
        alert("Please Enter the Transaction Date.");
        $('#transactionDate').focus();
        return false;
    }
    if (jQuery.trim($('#departmentName').val()) == 0) {
        alert("Please Select the Department Name.");
        $('#departmentName').focus();
        return false;
    }
    if (jQuery.trim($('#exchangeProgramName').val()) =="") {
        alert("Please Enter the Exchange Program Name.");
        $('#exchangeProgramName').focus();
        return false;
    }
    if (jQuery.trim($('#universityVisitedAbroad').val()) =="") {
        alert("Please Enter the University Visited Abroad.");
        $('#universityVisitedAbroad').focus();
        return false;
    }
    if (jQuery.trim($('#departmentNameVisited').val()) ==0) {
        alert("Please Select the Department Name Visited.");
        $('#departmentNameVisited').focus();
        return false;
    }
    if (jQuery.trim($('#fromDate').val()) =="") {
        alert("Please Enter the From Date.");
        $('#fromDate').focus();
        return false;
    }
    if (jQuery.trim($('#toDate').val()) =="") {
        alert("Please Enter the To Date.");
        $('#toDate').focus();
        return false;
    }
    if (jQuery.trim($('#purposeOfTheVisit').val()) =="") {
        alert("Please Enter the Purpose Of The Visit.");
        $('#purposeOfTheVisit').focus();
        return false;
    }
    if (jQuery.trim($('#courseCode1').val()) ==0) {
        alert("Please Select the Course Code.");
        $('#courseCode1').focus();
        return false;
    }
    if (jQuery.trim($('#courseCredit1').val()) =="") {
        alert("Please Enter the Course Credits.");
        $('#courseCredit1').focus();
        return false;
    }
    if (jQuery.trim($('#gradeObtained1').val()) ==0) {
        alert("Please Select the Grade Obtained.");
        $('#gradeObtained1').focus();
        return false;
    }
    
    var count="0";
    for (var key in gridData)
    {
        if (jQuery.trim($('#rating' + key).val()) != '' || jQuery.trim($('#remarks'+key).val()) != '')
        {
            count = "1"
        }
    }
    
    if(count=="0")
        {
        alert("Please Enter the Feedback of atleast one questions."); 
        return false;
        }
        
        if(flag2=="11" && $("#transactionID").val()==0)
         {
             alert("Feedback of student is already exists ,please choose update.");
             return false;
         }
  
    var lRow=$('[name="courseCode"]').last().attr('id').substring(10);
    var courseDataList=[];
   
    for(var i=1;i<=lRow;i++){
       
        var courseData={};
        if($("#courseCode"+i).val()!=null && $("#courseCredit"+i).val()!=null && $("#gradeObtained"+i).val()!=null){
        courseData.companyID=$("#compsession").val();
        courseData.instituteID=$("#instsession").val();
        courseData.transactionDate=$("#transactionDate").val();
        courseData.apFeedbackID=$("#feedbackID").val();
        courseData.programCode=$("#courseCode"+i).val();
        courseData.courseCredit=$("#courseCredit"+i).val();
        courseData.gradeObtained=encodeURIComponent($("#gradeObtained"+i).val());
        courseDataList.push(courseData);
        }
    }
    
    var questionsDataList=[];
    for (var key in gridData) {
       var questionsData={};
        if(($('#rating'+key).val()!='' || $('#remarks'+key).val()!='' )&& $('#rating'+key).val()!=undefined)
            {
        questionsData.companyid=$("#compsession").val();
        questionsData.instituteid=$("#instsession").val();
        questionsData.transactionDate=$("#transactionDate").val();
        questionsData.feedbackName=$("#feedbackID").val();
        questionsData.questionID=gridData[key]["questionid"];
        questionsData.questions=gridData[key]["questionbody"];
        questionsData.ratingid=gridData[key]["ratingid"];
        if($("#rating"+key).val().length>1){
        questionsData.remarks=$("#rating"+key).val();  
        }else{
        questionsData.rating=$("#rating"+key).val();
        }
        questionsData.appfeedbackItemRemarks=$("#remarks"+key).val();
        questionsDataList.push(questionsData);   
            }
        
    }
   
    var mainList=[];
    mainList.push(courseDataList);
    mainList.push(questionsDataList);
    
    
    jData = {};
    jData.transactionID = $("#transactionID").val();
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.transactionDate=$("#transactionDate").val();
    jData.apFeedbackID=$("#feedbackID").val();
    jData.apStudentID=$("#studentID").val();
    jData.departmentCode=$("#departmentName").val();
    jData.nameOfExchangeProgram=$("#exchangeProgramName").val();
    jData.universityVisitedAbroad=$("#universityVisitedAbroad").val();
    jData.departmentCodeAbroad=$("#departmentNameVisited").val();
    jData.durationFromDate=$("#fromDate").val();
    jData.durationToDate=$("#toDate").val();
    jData.purposeOfVisit=$("#purposeOfTheVisit").val();
    jData.entryBy = $("#studentID").val();
    
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.handller = "saveupdate";
    jData.para = mainList;
    $(document).getServace(jData);
}

function resetValues()
{
    $("#transactionID").val("0");
    $("#departmentName").val("");
    $("#exchangeProgramName").val("");
    $("#universityVisitedAbroad").val("");
    $("#departmentNameVisited").val("");
    $("#fromDate").val("");
    $("#toDate").val("");
    $("#purposeOfTheVisit").val("");
    var lRow = $('[name="courseCode"]').last().attr('id').substring(10);
    for (var t = 1; t <= lRow; t++)
    {
        $("#courseCode" + t).val("");
        $("#courseName" + t).val("");
        $("#courseCredit" + t).val("");
        $("#gradeObtained" + t).val("");

    }
    for (var key in gridData)
    {
        $('#rating' + key).val("");
        $('#remarks' + key).val("");
    }
}

function getLowerGrid()
{
    jData = {};
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.studentID =$("#studentID").val();
    jData.handller = "lowerGrid";
    $(document).getServace(jData);  
}


function getSelectGridData()
{
  $("#lowerGrid").yattable({
        width: "100%",
        height: 200,
        scrolling: "yes"
    });
    var table = "";
   $("#gridLower").html("");
     // $("#gridLower").html("<th style='width: 19%'>Feedback ID</th><th style='width: 19%'>Program Name</th><th style='width: 19%'>Department</th><th style='width: 19%'>Academic Year</th><th style='width: 19%'>Remarks</th><th style='width: 5%'></th>");
     $("#gridLower").html("<th style='width: 13%'>Transaction Date</th><th style='width: 13%'>Student Name</th><th style='width: 17%'>Department Name</th><th style='width: 13%'>Exchange Program Name</th><th style='width: 13%'>University Visited Abroad</th><th style='width: 13%'>Duration From Date</th><th style='width: 13%'>Duration To Date</th><th style='width: 5%'></th>");
    for (var key in lowerGridData) {
        
        table = table + "<tr><td  style='width: 13%'>" + lowerGridData[key]["transactionDate"] + "</td><td  style='width: 13%'>" + lowerGridData[key]["studentName"] + "</td><td  style='width: 17%'>"+lowerGridData[key]["department"]+"</td><td  style='width: 13%'>"+lowerGridData[key]["nameOfExchangeProgram"]+"</td><td  style='width: 13%'>"+lowerGridData[key]["universityVisitedAbroad"]+"</td><td  style='width: 13%'>"+lowerGridData[key]["durationFromDate"]+"</td><td  style='width: 13%'>"+lowerGridData[key]["durationToDate"]+"</td>";   
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + lowerGridData[key]["transactionID"] + "\")'></td></tr>";
    }
    $("#gridLowerBody").html("");
    $("#gridLowerBody").html("" + table);
    $("#lowerGrid1").css("width", $("#lowerGrid").width());  
    
}

function updateMasterRecord(transactionID)
{
    
    jData = {};
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.handller = "selectDataForUpgrade";
    jData.transactionID = transactionID;
    $(document).getServace(jData);
    
}

function getCheckExpiryDate()
{
    var d = new Date();
    var month = d.getMonth() + 1;
    var day = d.getDate();
    var output = (day < 10 ? '0' : '') + day + '-' + (month < 10 ? '0' : '') + month + '-' + d.getFullYear();
    jData = {};
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.handller = "checkExpiryDate";
    jData.todayDate = output;
    $(document).getServace(jData);
}

function getValidate()
{
    jData = {};
    jData.service = "FeedbackOfEducationalExperienceServlet";
    jData.handller = "validateData";
    jData.studentID = $("#studentID").val();
    jData.feedbackid = $("#feedbackID").val();
    $(document).getServace(jData);  
}