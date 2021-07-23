<%-- 
    Document   : StudFeedbackAnalysisTheoryReport
    Created on : Apr 17, 2015, 2:05:37 PM
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
        <script src="../js/IQTest/IQACReport.js"></script>

   </head>


    <body>
        <!-- Above Is  to handle  the session values   -->
        <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:95px;" >
            <FONT SIZE="2" COLOR="black" style="margin-left:70%;">
            Form:QA-AC-3</FONT><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:33%;" >Institute Academic Quality Assurance Cell</FONT></B>
            <FONT SIZE="2" COLOR="black" style="margin-left:14%;" >Frequency-Every Semester</FONT><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:24%;">Academic(Teaching and Learning)</FONT><FONT SIZE="2" COLOR="black" style="margin-left:22%">Date-</FONT></B><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:5%;" >Faculty Feedback(Lecture/Lab Course)</FONT></B>

        </div>
        <br>   <br>
        <div style="width: 90%; padding: 10px ;border: .3em solid;border-radius: 25px;margin-left:4%" >
            <table  id="commonmasterid" style="text-align: left;font-size: 18px; border:1px;width:90%">
                <tr>
                    <td style="text-align: right" width="10%">Company<span class="req"> *</span> :</td>
                    <td width="40%">
                        <select  name='company' id='company'  class='combo' style='width:100%'  title='Company Code'>
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
                     <td width="10%" align="right" nowrap>Exam Code<span class="req"> *</span> :</td>
                    <td width="40%">
                    <select  name='examcode' id='examcode'  class='combo' style='width:50%'  title='Exam code'>
                            <option value="">Select Exam Code</option>
                        </select>
                    </td><td width="10%" align="right" nowrap>Faculty<span class="req"> *</span> :</td>
                    <td width="40%">
                        <select  name='faculty' id='faculty'  class='combo' style='width:100%'  title='Faculty'>
                            <option value="">Select Faculty</option>

                        </select>
                    </td>
                </tr>
                <tr>
                <td width="10%" align="right" nowrap>Acadmic Year<span class="req"> *</span> :</td>
                    <td width="40%">
                        <input type="text" name="acadyear" id="acadyear" readonly class="textbox" title="Acadmic Year">
                    </td>
                     <td width="10%" align="right" nowrap>Subject<span class="req"> *</span> :</td>
                    <td width="40%">
                    <select  name='subject' id='subject'  class='combo' style='width:100%'  title='Subject'>
                            <option value="">Select Subject</option>

                        </select>
                </td>

                </tr>

                <tr>
                    <td style="text-align: right" width="15%">Section Branch<span class="req"> *</span> :</td>
                    <td width="40%">
                        <select  name='branch' id='branchcode'  class='combo' style='width:40%'  title='Section Brach'>
                            <option value="">Select Branch</option>
                        </select>
                    </td>
                     <td style="text-align: right" width="15%">Section Code <span class="req"> *</span> :</td>
                    <td width="40%">
                        <select  name='section' id='section'  class='combo' style='width:50%'  title='Section Brach'>
                            <option value="">Section Code</option>
                        </select>
                    </td>
                </tr>
                  <tr>
                    <td style="text-align: right;" width="100%" colspan="4" nowrap>
                        <button name="submitbutton_StudThoery" id="submitbutton_StudThoery"  class="button" style="width:120px;height:25px;margin-left:140px;">Generate Report</button>
                    </td>
                </tr>
            </table>
        </div>
        <br>
        <div id="reportpart"></div>
    </body>
</html>