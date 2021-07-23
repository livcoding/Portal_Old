/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var rc = 0;
(function($) {
    $.fn.getServace = function(para)
    {
         //alert(JSON.stringify(para));
        $.ajax({
            type: 'POST',
            timeout: 50000,
            dataType: "json",
            handller: para.handller,
            url: '../../' + para.service,
            data : 'jdata='+JSON.stringify(para).replace(/&/g,"").replace(/%/g,"")+'&d='+new Date(),
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
        case 'programComboAE':
            $("#abc").html("");
            $("#abc").html("<select  name='programName' id='programName' class='combo' multiple='multiple' style=''  title='Program' onchange='getBranchCode()'>" + xhr.responseText + "</select>");
            $("#programName").multiselect();
            break;
        case 'branchComboAE':
            $("#abc1").html("");
            $("#abc1").html("<select  name='branchCode' id='branchCode' class='combo' multiple='multiple' style=''  title='Branch' onchange='getSubjects()'>" + xhr.responseText + "</select>");
            $("#branchCode").multiselect();
            break;
        case 'subjectsComboAE':
            $("#abc2").html("");
            $("#abc2").html("<select  name='subjects' id='subjects' class='combo' multiple='multiple' style=''  title='Subjects' >" + xhr.responseText + "</select>");
            $("#subjects").multiselect();
            break;
    }
        
});


function getCommonMasterTable()
{
    $("#programName").multiselect();
             $("#subjects").multiselect();
              $("#branchCode").multiselect();
    jData = {};
    jData.employeeID = $("#employeeID").val();
    jData.companyCode = $("#companyCode").val();
    jData.instituteCode = $("#instituteCode").val();
    jData.examCode = $("#examCode").val();
    jData.service = "CommonComboServlet";
    jData.handller = "programComboAE";
    jData.comboId = "programComboAE";
    $(document).getServace(jData);  
}

function getBranchCode()
{
    var tempStr=$("#programName").val();
    var temArray =tempStr; 
    var tString="";
    for(var i=0;i<temArray.length;i++)
        {
         tString=tString+"'"+temArray[i]+"'"+",";
        }
        tString = tString.substring(0, tString.length - 1);
    jData = {};
    jData.programName = tString;
    jData.employeeID = $("#employeeID").val();
    jData.companyCode = $("#companyCode").val();
    jData.instituteCode = $("#instituteCode").val();
    jData.examCode = $("#examCode").val();
    jData.service = "CommonComboServlet";
    jData.handller = "branchComboAE";
    jData.comboId = "branchComboAE";
    $(document).getServace(jData);  
}

function getSubjects()
{
   var tempStr=$("#programName").val();
    var temArray =tempStr; 
    var tString="";
    for(var i=0;i<temArray.length;i++)
        {
         tString=tString+"'"+temArray[i]+"'"+",";
        }
        tString = tString.substring(0, tString.length - 1);
    var tempStr1=$("#branchCode").val();
    var temArray1 =tempStr1; 
    var tString1="";
    for(var i=0;i<temArray1.length;i++)
        {
         tString1=tString1+"'"+temArray1[i]+"'"+",";
        }
        tString1 = tString1.substring(0, tString1.length - 1);
    jData = {};
    jData.programName = tString;
    jData.branch = tString1;
    jData.employeeID = $("#employeeID").val();
    jData.companyCode = $("#companyCode").val();
    jData.instituteCode = $("#instituteCode").val();
    jData.examCode = $("#examCode").val();
    jData.service = "CommonComboServlet";
    jData.handller = "subjectsComboAE";
    jData.comboId = "subjectsComboAE";
    $(document).getServace(jData);   
}

function generateReport()
{
    if (jQuery.trim($('#programName').val()) == 0) {
        alert("Please Select the Program.");
        $('#programName').focus();
        return false;
    } 
    if (jQuery.trim($('#branchCode').val()) == 0) {
        alert("Please Select the Branch.");
        $('#branchCode').focus();
        return false;
    } 
    if (jQuery.trim($('#subjects').val()) == 0) {
        alert("Please Select the Subjects .");
        $('#subjects').focus();
        return false;
    } 
    $("#gridbody").html();
    $("#gridbody").html("<tr><td><Font size='2'>Please Wait...</Font></td></tr>");
    jQuery("<form action='PRRegElectiveSubjToBeRun.jsp' method='post'><input name='examcode' value='"+$("#examCode").val()+"'><input name='programName' value='"+$("#programName").val()+"'><input name='branchCode' value='"+$("#branchCode").val()+"'><input name='subjects' value='"+$("#subjects").val()+"'></form>").appendTo("body").submit().remove();
}