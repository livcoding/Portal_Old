/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var rc=0;
var formdata={};
var gridData = {};
var cupage = {};
(function ($) {
    $.fn.getServace = function (para)
    {
     // alert(JSON.stringify(para));
        $.ajax({
            type: 'POST',
            timeout: 50000,
            dataType:"json",
            handller:para.handller,
            url: '../../'+para.service,
            data : 'jdata='+JSON.stringify(para),
            error : function (){
                rc++;
                if(rc!=3){
               
                }
                $("errorDiv").html("An Error Occured With Request.....");
            }
        });
        return this;
    };
}(jQuery));

$(document).ajaxComplete(function(event, xhr, settings) {
    switch (settings.handller) {
       
        case 'feedbackcodecombo':
            $("#feedbackcode").empty();
            $("#feedbackcode").append(xhr.responseText);
            break;
        case 'saveupdate':
            getGridData("0");
            $("#headid").val(xhr.responseText);
            window.open("popupSubHeadwindow.jsp?noofsubhead="+$("#noofsubhead").val()+"&parentheadid="+$("#headid").val(),"myPopup", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=400, height=400");
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            getGrid(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
            break;
        case 'SelectforUpdate':
            var SelectData = {};
            SelectData = jQuery.parseJSON(xhr.responseText);
            $("#headid").val(SelectData["headid"]);
            $("#examcode").val(SelectData["examcode"]);
            getFeedbackCode(SelectData["feedbackid"]);
            $("#componenttype").val(SelectData["componenttype"]);
            $("#tick").prop("checked", true);
            $("#headcode").val(SelectData["headcode"]);
            getHeadData();
            $("#headdesc").val(SelectData["headdesc"]);
            $("#weigtage").val(SelectData["weigtage"]);
            $("#seqid").val(SelectData["seqid"]);
            getsubheadcount(SelectData["headid"]);
            //$("#feedbackcode").val(SelectData["feedbackid"]);
            break;
        case 'selectsubheadcount':
            var count = xhr.responseText;
            $("#noofsubhead").val(count);
            break;
        case 'popupSubHeadData':
           var SelectData = {};
            SelectData = jQuery.parseJSON(xhr.responseText);
            for(var key in SelectData)
            {    
            $("#headid"+key).val(SelectData[key]["headid"])   
            $("#headcode"+key).val(SelectData[key]["headcode"]);
            $("#headdesc"+key).val(SelectData[key]["headdesc"]);
            $("#weigtage"+key).val(SelectData[key]["weigtage"]);
            $("#seqid"+key).val(SelectData[key]["seqid"]);
            }
            break;
        case 'Delete':
            getGridData("0");
            break;
        case 'saveupdatesubhead':
            resetValues();
            getGridData("0");
            break;
        
    }
});


function getCommonMasterTable()
{
   
     $("#pagging").getPagging();
     getGridData("0");
    ///////////////////////////////////// 
    cupage.pr = 0;
    $("#previous").hide();
    $("#first").hide();
    
    $("#pagging").click(function() {
        cupage.pr = eval($("#pagging").val());
    });
    $("#first").click(function() {
        getGridData("0");
        cupage.pr = 0;
        if (cupage.pr == "0") {
            $("#previous").hide();
            $("#first").hide();
        }
        $("#next").show();
        $("#last").show();
    });
    $("#previous").click(function() {
        getGridData((eval(cupage.pr) - eval($("#pagging").val())));
        cupage.pr = (eval(cupage.pr) - eval($("#pagging").val()));
        if (cupage.pr == "0") {
            $("#previous").hide();
            $("#first").hide();
        }
        $("#next").show();
        $("#last").show();
    });
    $("#next").click(function() {
        getGridData((eval(cupage.pr) + eval($("#pagging").val())));
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
    
        getGridData((eval(gridData[1].totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val())));
        cupage.pr = (eval(gridData[1].totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val()));
        $("#next").hide();
        $("#last").hide();
        $("#previous").show();
        $("#first").show();
    });
    ///////////////////////////////




}


function getFeedbackCode(id)
{
        jData = {};
        jData.service = "CommonComboServlet";
        jData.handller = "feedbackcodecombo";
        jData.comboId = "feedbackcodecombo";
        jData.examcode=$("#examcode").val();
        jData.preselect=id;
        $(document).getServace(jData);
}

function getHeadData()
{
    if ($('#tick').is(':checked')) {
        $("#head1").show();
        $("#head2").show();
        $("#head3").show();
        $("#head4").show();
    } else
    {
        $("#head1").hide();
        $("#head2").hide();
        $("#head3").hide();
        $("#head4").hide();
    }
}

function getPopupWindow()
{
    if (jQuery.trim($('#noofsubhead').val()) == "") {
        alert("Please Enter the No. of Sub Head");
        $('#noofsubhead').focus();
        return false;
    }
    if (jQuery.trim($('#noofsubhead').val()) == 0) {
        alert("Please Enter the No. of Sub Head");
        $('#noofsubhead').focus();
        return false;
    }
    
    formsubmit($("#headid").val());
    
     
   
     
}

function getSubHeadData(parentheadid)
{
    jData = {};
    jData.service = "FacultyQuestionHeadServlet";
    jData.handller = "popupSubHeadData";
    jData.parentheadid = parentheadid;
    $(document).getServace(jData); 
      
}

function formsubmit(headid)
{
     var paramatervalue = {};
    paramatervalue.companyid = $("#compsession").val();
    paramatervalue.instituteid = $("#instsession").val();
    paramatervalue.examcode = $("#examcode").val();
    paramatervalue.feedbackid = $("#feedbackcode").val();
    paramatervalue.componenttype = $("#componenttype").val();
    paramatervalue.headcode = $("#headcode").val();
    paramatervalue.headdesc = $("#headdesc").val();
    paramatervalue.weigtage = $("#weigtage").val();
    paramatervalue.seqid = $("#seqid").val();
    

    jData = {};
    jData.service = "FacultyQuestionHeadServlet";
    jData.handller = "saveupdate";
    jData.headid = headid;
    jData.para = paramatervalue;
    $(document).getServace(jData);

}

function formsubmitsubHead(noofsubhead,parentheadid)
{
    
   var subHeadDataInfo=[];
   
    for(var i=1;i<=noofsubhead;i++){
       
        var subHeadData={};
        
        subHeadData.headid=$("#headid"+i).val();
        subHeadData.headcode=$("#headcode"+i).val();
        subHeadData.headdesc=$("#headdesc"+i).val();
        subHeadData.weigtage=$("#weigtage"+i).val();
        subHeadData.seqid=$("#seqid"+i).val();
        subHeadDataInfo.push(subHeadData);
    }
 opener.getchilddata(subHeadDataInfo,parentheadid);
window.close();
}
function getchilddata(subHeadDataInfo,parentheadid) {
    jData = {};
    jData.parentheadid = parentheadid;
    jData.companyid = $("#compsession").val();
    jData.instituteid = $("#instsession").val();
    jData.examcode = $("#examcode").val();
    jData.feedbackid = $("#feedbackcode").val();
    jData.componenttype = $("#componenttype").val();
    jData.service = "FacultyQuestionHeadServlet";
    jData.handller = "saveupdatesubhead";
    jData.para = subHeadDataInfo;
    $(document).getServace(jData);

}

function getGridData(pno)
{
    jData = {};
   
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
    jData.service = "FacultyQuestionHeadServlet";
    jData.handller = "select";
    $(document).getServace(jData);
  
}

function getGrid() {
    $("#mastergrid").yattable({
        width: "100%",
        height: ($(window).height() - 350),
        scrolling: "yes"
    });
    var table = "";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 20%'>Head Code</th><th style='width: 25%'>Head Description</th><th style='width: 20%'>Weigtage </th><th style='width: 20%'>Seq ID</th><th style='width: 5%'></th><th style='width: 5%'></th>");

    for (var key in gridData) {
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 20%'>" + gridData[key]["headcode"] + "</td><td  style='width: 25%'>" + gridData[key]["headdesc"] + "</td><td  style='width: 20%'>" + gridData[key]["weigtage"] + "</td>";
        table = table + "<td  style='width: 20%'>" + gridData[key]["seqid"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["headid"] + "\")'></td><td style='width: 5%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData[key]["headid"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}


function updateMasterRecord(headid)
{
    jData = {};
    jData.service = "FacultyQuestionHeadServlet";
    jData.handller = "SelectforUpdate";
    jData.headid = headid;
    $(document).getServace(jData);
}

function getsubheadcount(headid)
{
    jData = {};
    jData.service = "FacultyQuestionHeadServlet";
    jData.handller = "selectsubheadcount";
    jData.headid = headid;
    $(document).getServace(jData);
}
function deleteMasterRecord(headid)
{
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

    jData = {};
    jData.service = "FacultyQuestionHeadServlet";
    jData.handller = "Delete";
    jData.headid = headid;
    $(document).getServace(jData);
    }
    else {
    }
}


function resetValues()
{
   $("#headid").val("0");
   $("#examcode").val("");
   $("#feedbackcode").val("");
   $("#componenttype").val("L");
   $("#tick").prop("checked", false);
   getHeadData();
   $("#headcode").val("");
   $("#headdesc").val("");
   $("#weigtage").val("");
   $("#seqid").val("");
   $("#noofsubhead").val("");
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
        getGridData("0");
    }
});