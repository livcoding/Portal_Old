<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%  
   int ctr=0;
				

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	SignUpMemberBulk.JSP		[For Employee]			   *
	' * Author:		Ashok Kumar Singh 						         *
	' * Date:		3rd Nov 2006	 							   *
	' * Version:		1.0									   *	
	' **********************************************************************************************************
*/
%>
<html>
<head>
<meta http-equiv="Content-Type" content="application/msword">
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
-->
</style>
<title>Hide Stuff and Print</title>
</head>

<body leftmargin=5 topmargin=5>
<table border=1 Align=Left cellSpacing=0 cellPadding=0 >
<START OF FILE>
<%@page contentType="application/msword"%>
<%
	  response.setContentType("application/msword");
int j=0;
	  for (j=1;j<=10;j++)		
		{
		%>
		<tr><td><%=j%></td></tr>
		<%
		}  //closing of total count if
	%>
</table>
<END OF FILE>
</body>
</html> 
     

