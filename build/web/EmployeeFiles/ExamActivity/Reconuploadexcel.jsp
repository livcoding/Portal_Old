<%-- 
    Document   : uploadexcel
    Created on : Aug 10, 2016, 2:18:05 PM
    Author     : satendrak.chauhan
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page isELIgnored="false" errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@ taglib prefix="ntb" uri="http://www.nitobi.com"%>
<html xmlns:ntb>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
String mHead=""; 
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";
session.setAttribute("CurrEvent",""); 
session.setAttribute("PrevEvent","");

response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
String testMarks=request.getParameter("testMarks");
String _marksOfTest=request.getParameter("marksOfStudent");
if(_marksOfTest!=null && !_marksOfTest.equals("")){
session.setAttribute("test_marks", _marksOfTest);
}


%>
<script>
function goBack() {
    window.history.back()
}
</script>
<script>
    function reconcileReport()
{
    document.excelUploadForm.action="../../ReconcileMarksEntryReportServlet";
    document.excelUploadForm.submit();
}
 
</SCRIPT>
<TITLE>#### <%=mHead%> [ Event-Wise Marks Entry ] </TITLE>
    </head>
    <body bgcolor=#fce9c5>
        <div align="center">
         <form name="excelUploadForm" id="excelUploadForm" method="post" enctype="multipart/form-data" >
              <table width="90%" ALIGN=CENTER bottommargin=0  topmargin=0 border="2" >
                <tr bgcolor="#8B0000"><TD colspan=0 align=middle><font color="white" style="FONT-SIZE: medium; FONT-FAMILY: arial"><B>Event/Sub Event wise Students Marks Entry</B></TD>
                </font></td></tr>
                <% if(!testMarks.equals("")){%>
                            <tr>

                            <td align="center">
                              
                            &nbsp; &nbsp; &nbsp;
                            <% if(!testMarks.equalsIgnoreCase("fnf")){%>
                                <input type="button" id="reconcile" name="reconcile" value="Click to Reconcile" onclick="reconcileReport()">
                                <font color="green"><h3>Your Excel has been Successfully Uploaded...</h3></font>
                                <%}else{%>
                                <input type="button" id="reconcile" name="reconcile" value="Click to Reconcile" disabled>
                                 <font color="RED"><h3>No File Exist for Reconciliation....</h3></font>
                                <%}%>
                            </td>
                            </tr>
                    <%  }%>
                           
                          </table>
                          <% if(testMarks.equals("")){ %>
                              <font color="RED"><h3>Error in File Uploading From Server ....</h3></font>
                              <font color="green"><marquee scrolldelay="140"> Please contact to support team.....</marquee></font>
                              


<%}else{%>


<%}%> 
</form>
         </div>
    </body>
</html>
