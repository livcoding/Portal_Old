<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%  
   int ctr=0;
				

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	SignUpMemberBulk.JSP		[For Employee]			   *
	' * Author:		Ashok Kumar Singh1 						         *
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
<%
object word2=null;
object mail=null;
Set word2 = CreateObject("word.application") ;
Set mail = word2.documents.open("C:\Word.doc") ;
word2.Visible = True ;
%>
</body>
</html> 
     

