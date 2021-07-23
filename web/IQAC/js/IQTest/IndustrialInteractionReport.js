/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



var IndusInterReport = function() {
  this.url1 = "/rest/IndusInterReport";
  this.typ="get";
  this.contType="application/json";
};

function ReqResforCombo(uri,element)
{ try{var R = new IndusInterReport();
       //alert(R.url1+uri+"$$$$$"+R.typ+"^^^^^"+R.contType);
   $.ajax({
         url:R.url1+uri,
         type:R.typ,
         contentType:R.contType,
         success:function(e){
        //alert(e);
        $("#"+element).empty();
        $("#"+element).append("<option value=''>Select</option>");
for (var key in e)
            {
            $("#"+element).append("<option value='"+key+"'>"+ e[key]+"</option>");
            }},
            error : function (){
               
               //alert("Error in geting company...");
            }
       
    });}catch(e)
{
    alert(e);
}
}


function rndlabText(uri,element)
{ 
    try{
        var R = new IndusInterReport();
        $.ajax({
            url:R.url1+uri,
            type:"GET",
        //    contentType:"text/HTML",
        //    timeout:8000,
            success:function(e){
             var rndlab=e.split("@");
               $("#rndLab").empty();
                $("#scholar").empty();
                $("#rndLab").val(rndlab[0]);
                $("#scholar").val(rndlab[1]);
            },
            error : function (){
               // alert("Error in geting rndlab...");
            }
        });
    }
    catch(e)
    {
        alert(e);
    }
}


function reportText(uri,element)
{
    try{
        var R = new IndusInterReport();
        $.ajax({
            url:R.url1+uri,
            type:"GET",
        //    contentType:"text/HTML",
        //    timeout:8000,
            success:function(e){
              //  alert(e);
               $("#reportpart").empty();
               $("#reportpart").append(e);
              
            },
            error : function (){
               // alert("Error in geting reportpart...");
            }
        });
    }catch(e)

    {
        alert(e);
    }
}

$(document).ready(function(){
   var uri='/company';
   ReqResforCombo(uri,"company");
$("#company").change(function(){
   
    uri='/'+$("#company").val();
  ReqResforCombo(uri,"institute");
});

$("#institute").click(function(){
    if($("#company").val()=='')
    {
        alert("Please choose company first...");
        return false;
    }
});
var url = window.location.pathname;
var filename = url.substring(url.lastIndexOf('/')+1);

if(filename=="MasterandPhD.jsp"||filename=="BookReport.jsp"||filename=="InterdisReport.jsp"||filename=="AwardandAchievmentReport.jsp")
{

 $("#departmentid").click(function(){
        if($("#institute").val()=='')
    {
        alert("Please choose institute  first...");
        return false;
    }});
if(filename=="MasterandPhD.jsp"){
    $("#institute").change(function(){

 uri='/DepartmentforProjectsPhd?company='+$("#company").val()+'&institute='+$("#institute").val()+'';
 
  ReqResforCombo(uri,"departmentid");
});

$("#submitButton_ProjectPHD").click(function(){

 uri='/ProjectReportPhD?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'';
// alert(uri);
 reportText(uri,"reportpart");
});

}
if(filename=="InterdisReport.jsp")
{
$("#institute").change(function(){

 uri='/DepartmentforInterdis?company='+$("#company").val()+'&institute='+$("#institute").val()+'';

  ReqResforCombo(uri,"departmentid");
});

$("#submitButton_Interdis").click(function(){

 uri='/InterdisReport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'';
// alert(uri);
 reportText(uri,"reportpart");
});


}
if(filename=="BookReport.jsp")
{
$("#institute").change(function(){

 uri='/DepartmentforBooks?company='+$("#company").val()+'&institute='+$("#institute").val()+'';

  ReqResforCombo(uri,"departmentid");
});

$("#submitButton_Book").click(function(){

 uri='/BookReport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'';
// alert(uri);
 reportText(uri,"reportpart");
});

}


if(filename=="AwardandAchievmentReport.jsp")
{
$("#institute").change(function(){

 uri='/DepartmentforAward?company='+$("#company").val()+'&institute='+$("#institute").val()+'';

  ReqResforCombo(uri,"departmentid");
});

$("#submitButton_Award").click(function(){

 uri='/AwardReport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'';
// alert(uri);
 reportText(uri,"reportpart");
});


}
}




if(filename=="ProjectReport.jsp")
{
$(document).ready(function() {
             $(".date").datepicker({
                dateFormat: 'dd-mm-yy',
                changeMonth: true,
                changeYear: true,
                yearRange: '-100:+0'
            });
            $("#startdate").datepicker({
                     dateFormat: 'dd-mm-yy',
        //numberOfMonths: 2,
     //     minDate: 0,

        onSelect: function(selected) {

          $("#enddate").datepicker("option","minDate", selected)
        }
    });

    $("#enddate").datepicker({
       // numberOfMonths: 2,
       dateFormat: 'dd-mm-yy',
        onSelect: function(selected) {
           $("#startdate").datepicker("option","maxDate", selected)
        }
    });
});






    $("#departmentid").click(function(){
        if($("#institute").val()=='')
    {
        alert("Please choose institute  first...");
        return false;
    }});

    $("#institute").change(function(){

 uri='/DepartmentforProjects?company='+$("#company").val()+'&institute='+$("#institute").val()+'';
  ReqResforCombo(uri,"departmentid");
});

$("#submitButton_Project").click(function(){

 uri='/ProjectReport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'&startdate='+$("#startdate").val()+'&enddate='+$("#enddate").val()+'';
// alert(uri);
 reportText(uri,"reportpart");
});

}




if(filename=="ConfernceApproval.jsp"||filename=="BudgetSheetReport.jsp"||filename=="Feedback_Conference.jsp")
{$("#departmentid").click(function(){
    if($("#institute").val()=='')
    {
        alert("Please choose institute  first...");
        return false;
    }});

$("#conference").click(function(){
    if($("#departmentid").val()=='')
    {
        alert("Please choose department  first...");
        return false;
    }});

$("#institute").change(function(){
 uri='/Departmentforconf?company='+$("#company").val()+'&institute='+$("#institute").val()+'';
  ReqResforCombo(uri,"departmentid");
});

$("#departmentid").change(function(){
 uri='/conference?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'';
  ReqResforCombo(uri,"conference");
});

$("#submitButtonConf").click(function(){
 uri='/conferencereport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'&conference='+$("#conference").val()+'';
  reportText(uri,"reportpart");
});
if(filename=="BudgetSheetReport.jsp"||filename=="Feedback_Conference.jsp")
    {
  $("#conference").change(function(){
 uri='/budgetid?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'&conference='+$("#conference").val()+'';
  ReqResforCombo(uri,"budgetid");
});  
    

 }



$("#submitButtonConfBudget").click(function(){
 uri='/conferencebudgetreport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'&conference='+$("#conference").val()+'&budgetid='+$("#budgetid").val()+'';
  reportText(uri,"reportpart");
});

$("#submitButtonConfFeedback").click(function(){
 uri='/conferencefeedbackreport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&department='+$("#departmentid").val()+'&conference='+$("#conference").val()+'&budgetid='+$("#budgetid").val()+'';
  reportText(uri,"reportpart");
});



}else{


$("#transactiondate").click(function(){
    if($("#institute").val()=='')
    {
        alert("Please choose institute first...");
        return false;
    }
});

$("#department").click(function(){
    if($("#transactiondate").val()=='')
    {
        alert("Please choose transaction date first...");
        return false;
    }
});



$("#institute").change(function(){
    
 uri='/'+$("#company").val()+'/'+$("#institute").val();
  ReqResforCombo(uri,"transactiondate");
});
$("#transactiondate").change(function(){
 uri='/Department?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val();
  ReqResforCombo(uri,"department");
});
$("#department").change(function(){
 uri='/rnd?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val()+'&dept='+$("#department").val();
  rndlabText(uri,"rndLab");

});
$("#department").change(function(){
   // alert($("#department").val());
 uri='/rnd?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val()+'&dept='+$("#department").val();
  rndlabText(uri,"rndLab");});
    $("#submitbutton").click(function(){
    if($("#company").val()=='')
    {
        alert("Please choose a company");
        return false;
    }

 if($("#company").val()=='')
    {
        alert("Please choose a company");
        return false;
    }
     if($("#institute").val()=='')
    {
        alert("Please choose a institute");
        return false;
    }
     if($("#transactiondate").val()=='')
    {
        alert("Please choose a transaction date");
        return false;
    }
    if($("#department").val()=='')
        {
        alert("Please choose a department");
        return false;
    }




 uri='/IndusReport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val()+'&dept='+$("#department").val();
  reportText(uri,"reportpart");

 });


$("#getIndusFeedback_submit").click(function(){
 if($("#company").val()=='')
    {
        alert("Please choose a company");
        return false;
    }
     if($("#institute").val()=='')
    {
        alert("Please choose a institute");
        return false;
    }
     if($("#transactiondate").val()=='')
    {
        alert("Please choose a transaction date");
        return false;
    }
    if($("#department").val()=='')
        {
        alert("Please choose a department");
        return false;
    }



//alert("Gyan");
 uri='/IndusInterFeedbackReport?company='+$("#company").val()+'&institute='+$("#institute").val()+'&transid='+$("#transactiondate").val()+'&dept='+$("#department").val();
  reportText(uri,"reportpart");

 });}

function printDiv()
{

  var divToPrint=document.getElementById('report');

  var newWin=window.open('','Print-Window','width=80,height=80');

  newWin.document.open();

  newWin.document.write('<html><head></head><body onload="window.print()">'+divToPrint.innerHTML+'</body></html>');

  newWin.document.close();

  setTimeout(function(){newWin.close();},10);

}
});