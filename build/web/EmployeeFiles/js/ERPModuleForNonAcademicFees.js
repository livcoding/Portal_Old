/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var rc = 0;
var gridData = {};
var totalCount=0;
(function($) {
    $.fn.getServace = function(para)
    {
        //alert("1222222");
        // alert(JSON.stringify(para));
        $.ajax({
            type: 'POST',
            timeout: 50000,
            dataType: "json",
            handller: para.handller,
            url: '../' + para.service,
            data : 'jdata='+JSON.stringify(para).replace(/&/g,"").replace(/%/g,"")+'&d='+new Date(),

            error: function() {
                rc++;
                if (rc != 3) {

                }
                $("errorDiv").html("An Error Occured With Request.....");
            }
        });
         console.log(this);
        return this;
        
    };
}(jQuery));

$(document).ajaxComplete(function(event, xhr, settings) {
    switch (settings.handller) {
       case 'academicYearComboWithInstCode1':
            $("#academicYear").empty();
            $("#academicYear").append(xhr.responseText);
            getProgramCode();
            break;
        case 'programCodeCombo1':
            $("#programCode").empty();
            $("#programCode").append(xhr.responseText);
            //getQuota();
            getBranchCode();
            break;
        case 'branchCodeCombo1':
            $("#branchCode").empty();
            $("#branchCode").append(xhr.responseText);
            getEnrollMentNo();
            break;
       case 'EnrollmentNoCombo':
            $("#enrollmentno").empty();
            $("#enrollmentno").append(xhr.responseText);
            break;
             
    }
});


function getAcademicYear()
{
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.service = "CommonComboServlet";
    jData.handller = "academicYearComboWithInstCode1";
    jData.comboId = "academicYearComboWithInstCode1";
    $(document).getServace(jData);
}

function getProgramCode()
{
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.academicYear = $("#academicYear").val();
    jData.service = "CommonComboServlet";
    jData.handller = "programCodeCombo1";
    jData.comboId = "programCodeCombo1";
    $(document).getServace(jData);


}

function getBranchCode()
{
    if($("#programCode").val()=='ALL')
        {
            $('#branchCode').attr('disabled', true);
            $("#branchCode").empty();
            $("#branchCode").append("<option value='0'>Select Branch Code</option>");
            getEnrollMentNo();
        }else{
            $('#branchCode').attr('disabled', false);
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.academicYear = $("#academicYear").val();
    jData.programCode = $("#programCode").val();
    jData.service = "CommonComboServlet";
    jData.handller = "branchCodeCombo1";
    jData.comboId = "branchCodeCombo1";
    $(document).getServace(jData);
        }

}
function getEnrollMentNo()
{
    jData = {};
    jData.instituteCode = $("#instituteCode").val();
    jData.academicYear = $("#academicYear").val();
    jData.programCode = $("#programCode").val();
    jData.branchCode = $("#branchCode").val();
    jData.service = "CommonComboServlet";
    jData.handller = "EnrollmentNoCombo";
    jData.comboId = "EnrollmentNoCombo";
    $(document).getServace(jData);
}
