<%--
    Document   : Workshop
    Created on : Mar 3, 2015, 11:34:09 AM
    Author     : Gyanendra.Bhatt
--%>

<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>

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
            <script src="../js/IQTest/WorkshopFeedbackReport.js"></script>
            </head>
        <body>
        <!-- Above Is  to handle  the session values   -->
				<div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:95px" >
                    <FONT SIZE="2" COLOR="black" style="margin-left:70%">
                            Form:QA-PSA-2A</FONT><br>
                         <B><FONT SIZE="4" COLOR="black" style="margin-left:33%" >Institute Academic Quality Assurance Cell
                         <FONT SIZE="2" COLOR="black" style="margin-left:14%" >Frequency-Every Semester Jan/July</FONT><br>
                          <B><FONT SIZE="4" COLOR="black" style="margin-left:18%">Professional and Social Activities Committee</FONT><FONT SIZE="2" COLOR="black" style="margin-left:13%">Date-</FONT><br>
                          <B><FONT SIZE="4" COLOR="black" >Workshops,Special Courses,Guest Lectures,Faculty Development Program Feedback</FONT></B>

                </div>
                <div style="width: 90%; padding: 10px ;border: .3em solid;border-radius: 25px;margin-left:4%" >
                 <table  id="commonmasterid" style="text-align: left;;font-size: 18px; border:1px">
                <tr>
                    <td style="text-align: right">Department<span class="req"> *</span> :</td>
                    <td ><select  name='department' id='department'  class='combo' style='width:100%'  title='Department Code'>
                    <option>Select Department</option>
                    </select>
                    </td>
                    <td width="150px;" align="right" nowrap>Start Date<span class="req"> *</span> :</td>
                    <td>
                    <input type='text' name='StartDate' id='startdate'  value='' maxlength='10' class='date' style='width:120px;font-weight:bold;' title='Start Date' readonly/>
                    </td>
                    <td width="100px;" align="right" nowrap>End Date<span class="req"> *</span> :</td>
                    <td>
                    <input type='text' name='EndDate' id='enddate'  value='' maxlength='10' class='date' style='width:120px;font-weight:bold;' title='End Date' readonly/>
                    </td>

                  </tr>
                    <tr>
                    <td style="text-align: right" nowrap>Title Of Program<span class="req"> *</span> :</td>
                    <td colspan="6" nowrap><select  name='programtitle' id='programtitle'  class='combo'  title='ProgramTitle' style="width:70%">
                    <option>Select A Program Title</option>
                    </select>
                     <button name="submitButton" id="submitbutton"  class="button" style="width:120px;height:25px;margin-left:140px;">Generate Report</button>
                    </td>
                    </tr>
                    </table>
                </div>
                <br>
              <div id="reportpart"></div>
        </body>
</html>