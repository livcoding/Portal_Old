<%-- 
    Document   : ParentFeedbackTransaction
    Created on : Mar 27, 2015, 4:46:37 PM
    Author     : Gyanendra.Bhatt
--%>


<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0);
%>
<!DOCTYPE HTML>

<html>
<head>
    <meta http-equiv='cache-control' content='no-cache'>
    <meta http-equiv='expires' content='0'>
    <meta http-equiv='pragma' content='no-cache'>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../css/Style.css">
    <link rel="stylesheet" href="../css/jquery-ui.css"/>
    <style type="text/css">
        html, body{ margin: 0; border: 0 none; padding: 0;    }
        html, body, #wrapper, #left, #right {  margin-top: auto }
        #wrapper { margin: 0 auto;  width: 960px;  }
        #mastergrid  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
        #mastergrid tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
        #mastergrid td { padding:5px; border:#999 1px solid; }
        #mastergrid1 th { padding:5px; border:#999 1px solid; }
        #mastergrid :hover, .applicantclass:focus, .applicantclass:active{background: skyblue !important;}

    </style>
    <script src="../js/jquery/jquery-1.10.2.js"></script>
    <script src="../js/jquery/jquery-ui.js"></script>
    <script src="../js/jquery/yattable.js"></script>
    <script src="../js/IQTest/jQuery.print.js"></script>
    <script src="../js/IQTest/jQuery.print.js"></script>
    <link rel="stylesheet" href="../Style_1.css">
    <link rel="stylesheet" href="../css/jquery-ui.css"/>
    <script src="../js/IQTest/ParentFeedbackTransaction.js"></script>
        <script>
     $.ajaxSetup ({
    // Disable caching of AJAX responses
    cache: false
});
        </script>
</head>
<%
   
String studid=request.getParameter("studentid")==null?"":request.getParameter("studentid");
%>
<body>
    <input type='hidden' name='studentid' id='studentid' value="<%=studid%>">
    <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:30px;width:95%;margin-left:25px;" >
        <B><FONT SIZE="4" COLOR="black">Parent Feedback Transaction (QA-SR-6)</FONT></B>
    </div>
    <div style="width:95%;margin-left:25px;border: .3em solid;border-radius: 25px;" >
        <table  id="HeaderTable" style="text-align: left;font-size: 18px; border:1px;margin-left:35px;">
         
          <tr><td  colspan=8 align='left'>&nbsp;<font color=navy face=arial size=2><STRONG>Transaction Date &nbsp;
                        </STRONG>
                        <input type='text' name='StartDate' id='startdate'  value='' maxlength='10' class='textbox' style='width:120px;margin-left:33px;' title='Start Date' readonly/>
                </font></td>
            </tr>
            <tr>
                <td style="text-align: right" width="10%" nowrap>Feedback Code & Name<span class="req"> *</span> </td>
                <td width="40%" nowrap>
                    <select  name='feedback' id='feedback'  class='combo' style='width:80%'  title='Feedback Code & Name'>
                       
                    </select>
                </td>
                <td style="text-align: left" width="10%" nowrap ><!--Feedback Remarks First Year<span class="req"> *</span>--> </td>
                <td width="40%" nowrap colspan="4" align="left" >
                    <input type="hidden" name="firstyearremarks" id="firstyearremarks" class="textbox" title='Feedback Remarks First Year' style='width:95%;'>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" width="10%" nowrap>Student Code & Name<span class="req"> *</span> </td>
                <td width="40%" nowrap >
                    <select  name='studcodename' id='studcodename' class='combo' style='width:80%'  title='Feedback Code & Name'>
                       
                    </select>
                </td>
                <td style="text-align: left" width="10%" nowrap ><!--Feedback Remarks Last Year<span class="req"> *</span>--> </td>
                <td width="40%" nowrap colspan="4">
                   <input type="hidden" name="lastyearremarks" id="lastyearremarks" class="textbox" title='Feedback Remarks Last Year' style='width:95%;'>
                </td>
            </tr>
            <tr>
                <td  colspan=8 align='left' >&nbsp;Program Code & Name&nbsp;
                    <input type="text" name="program" id="program" class="textbox" title='Program Code & Name' readonly style='width:30%;margin-left:10px;'>
                    <input type="hidden" name="programcode" id="programcode"  title='Program Code & Name' readonly style='width:30%;margin-left:10px;'>

              </td>
            </tr>
            <tr>
                <td style="text-align: right" width="10%" nowrap>Year Of Admission<span class="req"> *</span> </td>
                <td width="20%" nowrap>
                <input type="text" name="yearofAdmi" id="yearofAdmi" class="textbox" title='Year Of Admission' readonly style='width:20%;'>
                </td>
                <td style="width:5%;" nowrap align="right" > <!-- studying/pass out<span class="req"> *</span>--> </td>
                <td width="20%" nowrap >
                <input type="hidden" name="yearofPass" id="yearofPass" maxlength="5" class="textbox" title='Year Of Passing'  style='width:30%;'>
                </td>
                <td style="width:5%;" nowrap ><!--Semester<span class="req"> *</span>--> </td>
                <td width="20%" nowrap>
                <input type="hidden" name="semester" id="semester" class="textbox" title='Semester' readonly style='width:30%;'>
                <input type="hidden" name="institute" id="institute" />
               </td>
            </tr>
        </table>
        
    </div>
    <div class="ui-widget-header ui-corner-all" style="height:30px;width:95%;margin-left:25px;" id="finaldivsave">
                <input type="button" title='Load Record'  class="button" id="loadForm" style="cursor:pointer;margin-left: 80%;display:none;" onclick="loadData()" value="Load">
                <input type="button" title='Save Record'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 60%;display: none;" onclick="feedbackformsubmit()" value="Save">
                <input type="button"  title='Reset Fields'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 60%;display: none;" onclick=" resetValues()" value="Reset"-->
                <input type="button" title='Exit Form'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 90%;" onClick="history.go(-1);" value="Exit"></div>
                <table id="mastergrid" style="height:30px;width:95%;margin-left:25px;font-size: 18px;text-align: center;table-layout:fixed;" >
                    <thead id="gridhead">
                     <tr><th align="left" style="width: 5%" >Sl No.</th>
                     <th align="left" style="width: 45%"  colspan="2" >Item Code/ Description</th>
                     <th  align="left" style="width: 20%" >Feedback/Rating</th>
                     <!--th  align="left" style="width: 25%"  >Item Remarks</th-->
                     </tr>
                    </thead>
                     <tbody id="gridbody"></tbody>
                     <div id="buttons"></div>
                </table>
              
</body></html>