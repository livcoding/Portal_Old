<%-- 
    Document   : FacultyQuestionHead
    Created on : Feb 7, 2015, 10:41:01 AM
    Author     : nipun.gupta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jilit.db.CommonComboData"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/Style.css">
        <link rel="stylesheet" href="../css/jquery-ui.css"/>
        <style type="text/css">
            html, body{ margin: 0; border: 0 none; padding: 0;    height: 100%; min-height: 100%; overflow: hidden;   }
            html, body, #wrapper, #left, #right { height: 110%; min-height: 110%; margin-top: auto }
            #wrapper { margin: 0 auto; overflow: hidden; width: 960px;  }
            #mastergrid  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid td { padding:5px; border:#999 1px solid; }
            #mastergrid1 th { padding:5px; border:#999 1px solid; }
            #mastergrid :hover, .applicantclass:focus, .applicantclass:active   {
                background: skyblue !important;}

        </style>
        <script src="../js/jquery/jquery-1.10.2.js"></script>
        <script src="../js/jquery/jquery-ui.js"></script>
        <script src="../js/jquery/yattable.js"></script>
        <script src="../js/IQTest/ComboJs.js"></script>
        <script src="../js/IQTest/FacultyQuestionHeadJS.js"></script>
        <script>
            $(document).ready(function() {
                getCommonMasterTable();

                $(document).tooltip({
                    track: true
                });
            });
        </script>
    </head><%
        CommonComboData ccd=new CommonComboData();
        request.getParameter("");
    %>
    <body >
        <form name="masterform" >
            <input type="hidden" id="compsession"  value="UNIV"/>
            <input type="hidden" id="instsession"  value="JIIT"/>
            <input type="hidden" id="headid"  value="0"/>
            
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:28px " >Faculty Question Head Master</div> 
            <div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table  id="commonmasterid" style="text-align: center;font-size: 18px; border:1px">
                <tr>
                    <td style="text-align: right" >Exam Code<span class="req"> *</span> :</td><td style="padding-left: 10px;text-align: left"><select  name='examcode' id='examcode'  class='combo' style=''  title='Exam Code' onchange="getFeedbackCode()"><%=ccd.commonJspCombo("{\"comboId\":\"examcode\"}")%></select></td>
                </tr> 
                <tr>
                    <td style="text-align: right">FeedBack Code<span class="req"> *</span> :</td><td style="padding-left: 10px;text-align: left"><select  name='feedbackcode' id='feedbackcode'  class='combo' style=''  title='Feedback Code'></select></td>
                </tr> 
                <tr>
                    <td style="text-align: right" >Component Type<span class="req"> *</span> :</td>
                    <td colspan="2" style="padding-left: 10px">
                        <select name="componenttype" class='combo' id="componenttype" >
                                <option value="L">Lecture</option>
                                <option value="T">Tutorial</option>
                                <option value="P">Practical</option>
                              </select>
                        <input type="checkbox" id="tick" name="tick" value="N" onclick="getHeadData()">Show Head
                    </td>
                    
                </tr> 
                <tr id="head1" style="display: none">
                   <td style="text-align: right">Head Code<span class="req"> *</span> :</td><td style="padding-left: 10px;text-align: left"><input type='text' name='headcode' id='headcode' value='' maxlength='100' class='textbox' style='' title='Head Code'/></td>
                </tr> 
                <tr id="head2" style="display: none">
                   <td style="text-align: right">Head Description<span class="req"> *</span> :</td><td style="padding-left: 10px;text-align: left"><input type='text' name='headdesc' id='headdesc' value='' maxlength='100' class='textbox' style='' title='Head Description'/></td>
                </tr>
                <tr id="head3" style="display: none">
                   <td style="text-align: right">Weigtage<span class="req"> *</span> :</td><td style="padding-left: 10px;text-align: left"><input type='text' name='weigtage' id='weigtage' value='' maxlength='100' class='textbox' style='' title='Weightage'/></td>
                </tr>
                <tr id="head4" style="display: none">
                   <td style="text-align: right">Seq ID<span class="req"> *</span> :</td><td style="padding-left: 10px;text-align: left"><input type='text' name='seqid' id='seqid' value='' maxlength='100' class='textbox' style='' title='Seq ID'/></td>
                   <td style="text-align: right"></td><td><input type='button' name='addsubhead' id='addsubhead' value='Save and Add Sub Head' class='button' style='' title='Save and Add Sub Head' onclick="getPopupWindow()"/>&nbsp;No. of Sub Head&nbsp;<input type="text" id="noofsubhead" name="noofsubhead" value="" title="No. of Sub Head"></td>
                </tr>
                </table>
            </div>
                
            <div class="ui-widget-header ui-corner-all" style="text-align:left;width:100%;" id="finaldivsave">
                <span style="font-size: 14px;margin-left: 2%">Search :</span> <input type="text" class="textbox" id="searchbox" title='Type and Search Into Grid'style="width: 120px"/>
                <!--<input type="button" title='Save Record'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 60%" onclick="formsubmit()" value="Save">-->
                <input type="button"  title='Reset Fields'  class="button" id="finalResetForm" style="cursor:pointer;margin-left: 60%" onclick=" resetValues()" value="Reset">
                <input type="button" title='Exit Form'  class="button" id="finalExitForm" style="cursor:pointer;" onClick="history.go(-1);" value="Exit"></div>
            <table id="mastergrid1" style="width: 100%;font-size: 18px;text-align: center;" ><thead id="gridhead"></thead></table>
            <table id="mastergrid" style="width: 100%;font-size: 18px;text-align: center;word-wrap: break-word" ><tbody id="gridbody"></tbody></table>
            <div class="ui-widget-header ui-corner-all" style="text-align:right;width:100%;" >
                <span id="TOT" style="font-size:15px;alignment-adjust: auto "> </span>
                <select id="pagging"  title='Select No. of Records Per Page' onchange="getGridData(0)"  style="text-align:left" ></select>
                <input type='button'  class='button' id="first" value='|< First'  title='Jump to the First Page' >
                <input type='button'  title='Go to the Prev. Page'  class='button' id="previous" value='< Previous' >
                <input type='button'  title='Go to the Next Page'  class='button' id="next" value='Next >' >
                <input type='button' title='Jump to the Last Page'  class='button' id="last" value='Last >|'  >
            </div>  
        </form>
    </body>
</html>
