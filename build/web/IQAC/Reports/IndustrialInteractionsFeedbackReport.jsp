<%-- 
    Document   : IndustrialInteractionsFeedbackReport
    Created on : Apr 10, 2015, 2:52:03 PM
    Author     : Gyanendra.Bhatt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">


<html>
    <head>
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
        <script src="../js/IQTest/IndustrialInteractionReport.js"></script>
    </head>
    <body>
        <!-- Above Is  to handle  the session values   -->
        <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:95px;" >
            <FONT SIZE="2" COLOR="black" style="margin-left:70%;">
            Form:QA-PSA-2A</FONT><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:33%;" >Institute Academic Quality Assurance Cell
            <FONT SIZE="2" COLOR="black" style="margin-left:14%;" >Frequency-Every Semester Jan/July</FONT><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:18%;">Professional and Social Activities Committee</FONT><FONT SIZE="2" COLOR="black" style="margin-left:13%">Date-</FONT><br>
            <B><FONT SIZE="4" COLOR="black" >Industrail Interactions Feedback Report</FONT></B>

        </div>
        <div style="width: 90%; padding: 10px ;border: .3em solid;border-radius: 25px;margin-left:4%;margin-top:3%;" >
            <table  id="commonmasterid" style="text-align: left;;font-size: 18px; border:1px;width:95%;">
                <tr>
                    <td style="text-align: right" width="10%">Company<span class="req"> *</span> :</td>
                    <td width="40%"><select  name='company' id='company'  class='combo' style='width:100%'  title='Company Code'>
                            <option value="">Select Company</option>
                        </select>
                    </td>
                    <td style="text-align: right" width="10%">Institute<span class="req"> *</span> :</td>
                    <td width="40%">
                        <select  name='institute' id='institute'  class='combo' style='width:100%'  title='Institute'>
                            <option value="">Select Institute</option>
                        </select>
                    </td>
                </tr>
                <tr>
                     <td width="10%" align="right" nowrap>Transaction Date<span class="req"> *</span> :</td>

                    <td width="40%">
                        <select  name='transactiondate' id='transactiondate'  class='combo' style='width:100%'  title='Transaction Date'>
                            <option value="">Select Transaction Date</option>
                        </select>
                    </td>
                    <td width="10%" align="right" nowrap>Department<span class="req"> *</span> :</td>
                    <td width="40%">
                        <select  name='department' id='department'  class='combo' style='width:100%'  title='Department'>
                            <option value="">Select Department</option>
                        </select>
                    </td>
                   
                   
                </tr>
             
                <tr>
                    <td style="text-align: right;" width="100%" colspan="4" nowrap>
                        <button name="getIndusFeedback_submit" id="getIndusFeedback_submit"  class="button" style="width:120px;height:25px;margin-left:140px;">Generate Report</button>
                    </td>
                </tr>
            </table>
        </div>
        <br>
        <div id="reportpart"></div>
    </body>
</html>
