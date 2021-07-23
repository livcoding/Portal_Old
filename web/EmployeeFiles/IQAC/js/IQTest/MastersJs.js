/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var jData = {};
var res = {};
var gridData = {};
var cupage = {};

function getCommonMasterTable() {
    jData = {};
    jData.menuid = $("#menuid").val();
    jData.service = "CommonMasterServlet";
    jData.handller = "mastertable";
    $('#commonmasterid').getServace(jData);
    $("#pagging").getPagging();
    ///////////////////////////////////// 
    cupage.pr = 0;
    $("#previous").hide();
    $("#first").hide();
    $(document).on('click', "input.chkbox", function() {
        if (!$(this).is(':checked')) {
            $("#deactive").val("Y");
        } else {
            $("#deactive").val("N");
        }
    });
    $("#pagging").click(function() {
        cupage.pr = eval($("#pagging").val());
    });
    $("#first").click(function() {
        getGridData("0")
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
        if (cupage.pr > (eval(gridData.totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val())))
        {
            $("#next").hide();
            $("#last").hide();
        }
        $("#previous").show();
        $("#first").show();
    });
    $("#last").click(function() {
        getGridData((eval(gridData.totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val())));
        cupage.pr = (eval(gridData.totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val()));
        $("#next").hide();
        $("#last").hide();
        $("#previous").show();
        $("#first").show();
    });
    ///////////////////////////////

   


}
//////////////////////////////////////////////////////////////////////////
$(document).ajaxComplete(function(event, xhr, settings) {
    switch (settings.handller) {
        case 'mastertable':
            res = jQuery.parseJSON(xhr.responseText);
            $('#commonmasterid').empty();
            $('#commonmasterid').html(JSON.stringify(res.tabledesign).toString());
            $('#windowheader').html(res.windowheader);
            //Fucntion For Values in only static combo :effected from Combojs.js and reflected from masterController.java item id
            $('#apcategorytype').getCategoryType();
            $('#APPUBLICATIONTYPE').getPublicationType();
           
            getGridData("0");
            getComboDataMap();
            $(".number").numeric();
            $(".number").twoDecimalFormat();
            $(".nondecimal").numbernondecimal();
            $(".nametext").alphanumeric();
            $(".date").datepicker({
                dateFormat: 'dd-mm-yy',
                changeMonth: true,
                changeYear: true,
                yearRange: '-100:+0'
            });
            break;
        case 'saveupdate':
            getGridData("0");
            resetValues();
            location.reload(); 
           break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            resetValues();
            //alert(JSON.stringify(gridData));
            mastreGrid();
           if(gridData.totalrecordgridDatas!=undefined){
            $('#TOT').html("Total No.of Record(s): " + gridData.totalrecordgridDatas);
            }

            break;
        case 'Delete':
            getGridData("0");
            break;
        case 'SelectforUpdate':
            var SelectData = {};
            SelectData = jQuery.parseJSON(xhr.responseText);
            for (var i = 0; i < res.column.length; i++) {
                if(res.column[i]=="entrydate"){
                $('#' + res.column[i]).val("to_date(sysdate,'dd-MM-RRRR HH:SS PM')");   
                }else{
                $('#' + res.column[i]).val(SelectData[res.column[i]]);
                }
            }
            if ($("#deactive").val() == "Y")
            {
                $("#deactive").prop("checked", false);
                $("#deactive").val("Y");
            } else {
                $("#deactive").prop("checked", true);
                $("#deactive").val("N");
            }
            break;
        case 'chkUniqueValue':
            var uData = {};
            uData = jQuery.parseJSON(xhr.responseText);
            if (uData.success != 0) {
                $("#" + uData.col).val("");
                alert("Duplicate Value : This " + res.gridcolumn[(uData.col)] + " is already in use !");
                $("#" + uData.col).focus();
            }
            break;
        case 'commonCombo':
            $("#" + settings.ciid).empty();
            $("#" + settings.ciid).append(xhr.responseText);
            mastreGrid();

            break;
    }
});
//////////////////////////////////////////////////////////////////////////////////////////////
function formsubmit() {
    var allparamatervalue = {};
    var col = [];
    col = res.column;
    if (formValidate() == true) {
        allparamatervalue.tablename = res.tablename;
        allparamatervalue.column = col;
        for (var i = 0; i < col.length; i++) {
            allparamatervalue[col[i]] = $("#" + col[i]).val();
        }
        jData = {};
        jData.service = "DataAccessServlet";
        jData.handller = "saveupdate";
        jData.para = allparamatervalue;
        $('#commonmasterid').getServace(jData);
    }
}
////////////////////////////////////////////////
function formValidate() {
    var req = [];
    req = res.required;
    for (var i = 0; i < req.length; i++) {
        if ($("#" + req[i]).val() == "") {
            alert("Please fill all mandatory (*) fields.");
            $("#" + req[i]).focus();
            return  false;
        }
    }
    return  true;
}
/////////////////////////////////////////////////////////
function getGridData(pno) {
//alert("helloo"+pno);
    jData = {};
    var allparamatervalue = {};
    if ($("#pagging").val() == "ALL") {
        allparamatervalue.epg = gridData.totalrecords;
    } else {
        allparamatervalue.epg = (eval(pno) + eval($("#pagging").val()));
    }
    allparamatervalue.tablename = res.tablename;
    allparamatervalue.spg = pno;
    allparamatervalue.column = res.column;
    allparamatervalue.gridcolumn = res.gridcolumn;
    allparamatervalue.searchbox = $("#searchbox").val();
    jData.service = "DataAccessServlet";
    jData.handller = "select";
    jData.para = allparamatervalue;
    $('#commonmasterid').getServace(jData);
}
function mastreGrid() {
    var thead = "<tr><th style='width: 6%;'>Sl.No.</th>";
    for (var i = 0; i < (gridData.gridheaderorder).length; i++) {
        thead = thead + "<th>" + res.gridcolumn[gridData.gridheaderorder[i]] + "</th>";
    }
    thead = thead + "<th style='width: 4%;'>Edit</th><th style='width: 4%;'>Delete</th></tr>";
    $("#gridhead").html("");
    $("#gridhead").html(thead);
    //  alert(res.gridcolumn[gridData.gridheaderorder[i]]);
    $("#mastergrid").yattable({
        width: "100%",
        height: ($(window).height() - 350),
        scrolling: "yes"
    });
    var trdata = "";
    for (var j = 0; j < (gridData.gridrowdata).length; j++) {
        trdata = trdata + "<tr><td style='width: 6%;'>" + gridData.gridrowdata[j]['sno'] + ".</td>"
        for (var i = 0; i < (gridData.gridheaderorder).length; i++) {
             var currid="";
            if(res.combocolumn[gridData.gridheaderorder[i]]!=undefined){
                currid =gridData.gridheaderorder[i];
            }
           if(gridData.gridheaderorder[i]==currid){
            trdata = trdata + "<td>" + $("#"+gridData.gridheaderorder[i]+"> option[value='"+gridData.gridrowdata[j][gridData.gridheaderorder[i]]+"']").html()+ "</td>";
            }else{
            trdata = trdata + "<td>" + gridData.gridrowdata[j][gridData.gridheaderorder[i]] + "</td>";
            }
            currid="";
        }
        trdata = trdata + "<td style='width: 4%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record'  onclick='UpdateMasterRecord(\"" + gridData.gridrowdata[j][res.column[0]] + "\")'></td><td style='width: 4%;'><img src='../images/delete.png' title='Delete Record'  style='cursor: pointer' onclick='deleteMasterRecord(\"" + gridData.gridrowdata[j][res.column[0]] + "\")'></td></tr>";
    }
    trdata = trdata + ""
    // var bb = thead + trdata;
    $("#gridbody").html("");
    $("#gridbody").html(trdata);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}
$(document).keydown(function(e) {
    if (e.keyCode == 13) {
        getGridData("0");
    }
});
function  deleteMasterRecord(delid) {
    var answer = confirm("Do You Want To Delete This record?")
    if (answer) {

        jData = {};
        jData.service = "DataAccessServlet";
        jData.handller = "Delete";
        jData.id = delid;
        jData.tablename = res.tablename;
        jData.Colname = res.column[0];
        //[0] >> always categoryid
        $('#commonmasterid').getServace(jData);
    }
    else {
    }
}
function  UpdateMasterRecord(delid) {
    jData = {};
    jData.service = "DataAccessServlet";
    jData.handller = "SelectforUpdate";
    jData.id = delid;
    jData.tablename = res.tablename;
    jData.Colname = res.column;
    $('#commonmasterid').getServace(jData);
}
function resetValues() {
    for (var i = 2; i < res.column.length; i++) {
        if(res.column[i]!="entryby" && res.column[i]!="entrydate"){
        $('#' + res.column[i]).val("");
        }
    }
    $('#' + res.column[0]).val("0");
    $("#deactive").val("N");
    if ($("#companyid").val()!= "") {
        $("#companyid").val($("#companyid").val());
    }
    if ($("#instsession").val() != "") {
        $("#instituteid").val($("#instsession").val());
    }
    if ($("#entryby").val()!= "") {
        $("#entryby").val($("#entryby").val());
    }
    if ($("#entrydate").val()!= "") {
        $("#entrydate").val($("#entrydate").val());
    }
   
}

////// ********************(  )******************

$(document).on('onfocus', res.uniqevalue, function() {
    var txt = ($(this).val());
    alert(txt);

});
function getUniqueValue(i) {
    if ($("#" + (res.column[eval(i)])).val() != "") {
        jData = {};
        jData.service = "DataAccessServlet";
        jData.handller = "chkUniqueValue";
        jData.id = (res.column[eval(0)]);
        jData.idval = $("#" + res.column[eval(0)]).val();
        jData.tablename = res.tablename;
        jData.Colname = (res.column[eval(i)]);
        jData.Colnameval = $("#" + (res.column[eval(i)])).val();
        $('#commonmasterid').getServace(jData);
    }
}
//$(document).on('click', "input.date", function() {
//    
//});
function getComboDataMap() {
    var combomap ={}
    combomap = res.combocolumn;
    for (var key in combomap) {
      
        jData = {};
        jData.service = "CommonComboServlet";
        jData.handller ="commonCombo";
        jData.ciid = key;
        jData.comboId = combomap[key];
        $('#commonmasterid').getServace(jData);
    }
}
    