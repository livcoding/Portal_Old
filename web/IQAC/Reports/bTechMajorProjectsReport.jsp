<%-- 
    Document   : bTechMajorProjectsReport
    Created on : Jul 25, 2015, 3:23:07 PM
    Author     : nipun.gupta
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jilit.db.CommonComboData"%>
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
                        <script src="../js/IQTest/bTechMajorProjectsReportJS.js"></script>
            </head>
            <% CommonComboData ccd = new CommonComboData();
            SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
            %>
            <script>
           var currentDate='<%=sdf.format(new java.util.Date())%>';
        </script>
        <body>
        <!-- Above Is  to handle  the session values   -->
                     <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:95px" >
                        <FONT SIZE="2" COLOR="black" style="margin-left:70%">QA-AR-Form 6</FONT><br>
                        <B><FONT SIZE="4" COLOR="black" style="margin-left:20%" >Institute Academic Quality Assurance Cell
                        <FONT SIZE="2" COLOR="black" style="margin-left:15%" >Frequency-Every Year</FONT><br>
                        <B><FONT SIZE="4" COLOR="black" style="margin-left:25%">Academic ( Research)</FONT><FONT SIZE="2" COLOR="black" style="margin-left:29%">Date:-<%=sdf.format(new java.util.Date())%></FONT><br>
                            <B><FONT SIZE="4" COLOR="black" style="margin-right:16%">B.Tech. Major Projects</FONT></B>

                    </div>
                <div style="width: 90%; padding: 10px ;border: .3em solid;border-radius: 25px;margin-left:4%" >
                 <table  id="commonmasterid" style="text-align: left;font-size: 18px; border:1px">
                <tr>
                    <td style="text-align: right">Company<span class="req"> *</span> :</td>
                    <td>
                    <select  name='company' id='company'  class='combo' style='width:400px'  title='Institute Code'>
                    <%=ccd.commonJspCombo("{\"comboId\":\"companyMasterCombo\"}")%>
                    </select>
                    </td>
                  </tr>
                  <tr>
                     <td style="text-align: right" nowrap>Academic Year<span class="req"> *</span> :</td>
                    <td colspan="6" nowrap>
                    <select  name='academicYear' id='academicYear'  class='combo'  title='Academic Year' style="width:60%">
                    <%=ccd.commonJspCombo("{\"comboId\":\"academicyearcomboAllYear\"}")%>
                    </select>
                    </td>
                  </tr>
                    <tr>
                    <td style="text-align: right" nowrap>Department<span class="req"> *</span> :</td>
                    <td colspan="6" nowrap>
                    <select  name='department' id='department'  class='combo'  title='Department' style="width:60%">
                    <%=ccd.commonJspCombo("{\"comboId\":\"departmentCombo\"}")%>
                    </select>
                    <button name="submitButton" id="submitbutton"  class="button" style="width:120px;height:25px;margin-left:140px;" onclick="generateReport()">Generate Report</button>
                    </td>
                    </tr>
                    </table>
                </div>
                <br>
              <div id="reportpart"></div>
        </body>
</html>