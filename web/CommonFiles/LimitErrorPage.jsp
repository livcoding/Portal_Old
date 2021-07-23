<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
GlobalFunctions gb=new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String mHead="",qry="", mWebEmail="";
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
String mInst="",mUserType="",mEnrollment="",mFName="",mDob="",mStudentId="",mPassword="",mFullName="";
String mop="";
String swaid="", answer="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> </TITLE>

</head>
<BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=no>
<BR><BR><BR><BR><BR><HR>


				<CENTER><font color="red" size="5">Maximum limit to attempt for login in a day has been exceeded.. Thank You!</font></CENTER>
				<center>
			
<hr>
<br>
<table ALIGN=Center VALIGN=TOP>
		<tr><td valign=middle><IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>

</BODY> 
</HTML>
