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
            <script src="../js/IQTest/IndustrialInteractionReport.js"></script>
            </head>
        <body>
        <!-- Above Is  to handle  the session values   -->
				<div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:95px" >
                    <FONT SIZE="2" COLOR="black" style="margin-left:70%">
                            Form:QA-PSA-3B</FONT><br>
                         <B><FONT SIZE="4" COLOR="black" style="margin-left:33%" >Institute Academic Quality Assurance Cell
                         <FONT SIZE="2" COLOR="black" style="margin-left:14%" >Frequency-Annually in July</FONT><br>
                          <B><FONT SIZE="4" COLOR="black" style="margin-left:18%">Professional and Social Activities Committee</FONT><FONT SIZE="2" COLOR="black" style="margin-left:13%">Date-</FONT><br>
                          <B><FONT SIZE="4" COLOR="black" >Feedack on Conference</FONT></B>

                </div>
                <div style="width: 80%; padding: 10px ;border: .3em solid;border-radius: 25px;margin-left:8%;margin-rigth:5%" >
                    <table  id="commonmasterid" style="text-align: left;;font-size: 18px; border:1px">
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
                            <td style="text-align: right" width="10%" nowrap>Department<span class="req"> *</span> :</td>
                            <td  width="40%"><select  name='departmentid' id='departmentid'  class='combo' style='width:100%'  title='Department Code'>
                                    <option>Select Department</option>
                                </select>
                            </td>
                            <td style="text-align: right" width="10%">Conference<span class="req"> *</span> :</td>
                            <td  width="40%"><select  name='conference' id='conference'  class='combo' style='width:100%'  title='Conference Code'>
                                    <option>Select Conference</option>
                                </select>
                        </td></tr>
                        <tr>
                            <td style="text-align: right" width="10%">Budget Id<span class="req"> *</span> :</td>
                            <td  width="40%"><select  name='budgetid' id='budgetid'  class='combo' style='width:100%'  title='Budget Id'>
                                    <option>Select Conference</option>
                                </select>
                        </td> <td style="text-align: right" colspan="2" nowrap><button name="submitButtonConfFeedback" id="submitButtonConfFeedback"  class="button" style="width:120px;height:25px;margin-left:140px;">Generate Report</button>
                            </td>
                        </tr>
                    </table>
                </div>
                <br>
              <div id="reportpart"></div>
        </body>
</html>