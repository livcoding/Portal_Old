<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();
String  mInst="", mHead="";
if (session.getAttribute("BASEINSTITUTECODE")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
}

mHead=mInst+" - ADMIN (Change Admin Password)";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Change Password ] </TITLE>  



</HEAD>
<%

String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="";
DBHandler db=new DBHandler();
ResultSet rs=null;
String mWebEmail="";
int mMaxPWD=20;
int mMinPWD=5;

try{

if (session.getAttribute("MinPasswordLength")==null)
{
	mMinPWD=5;
}
else
{
	mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());
}

if (session.getAttribute("MaxPasswordLength")==null)
{
	mMaxPWD=20;
}
else
{
	mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());
}


}
catch(Exception e)
{
mMaxPWD=20;
mMinPWD=4;

}

if (session.getAttribute("BASELOGINID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("BASELOGINID").toString().trim();
}

if (session.getAttribute("BASELOGINTYPE")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();
}

if (session.getAttribute("BASELOGINID")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("BASELOGINID").toString().trim();
}

%>

<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{

	
%>
<br>
<P align=right><Font color=red><b>ADMIN</b></font><br>
<a href="SignOut.jsp">Signout</a></p>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Change ADMIN Login Password</B></font>
</td>
</tr>
</TABLE>
<form name="ChangePassword" ID="ChangePassword" action="ChangePasswordActionADMN.jsp" method="post">
<table align=center rules=groups border=2 style="WIDTH: 350px; HEIGHT: 100px">
<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
<tr>
	<td><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=black>Old Password</FONT></STRONG></FONT></td>
	<td><INPUT ID="OldPassword" Name="OldPassword" Type="password" style="WIDTH: 160px; HEIGHT: 22px" maxLength=<%=mMaxPWD%>><FONT color=red>* </FONT></td>
</tr>
<tr>
	<td><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=black>New Password</FONT></STRONG></FONT></td>
	<td><INPUT ID="NewPassword" Name="NewPassword" Type="password" style="WIDTH: 160px; HEIGHT: 22px" maxLength=<%=mMaxPWD%>><FONT color=red>* </FONT>
	<A href='PasswordHint.htm' target=_New title 'How can i secure my password'><FONT size=1 color=green><br>Hint: Min <%=mMinPWD%> Max <%=mMaxPWD%> Characters</FONT></a></td>
</tr>

<tr>
	<td><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=black>Retype Password</FONT></STRONG></FONT></td>
	<td><INPUT ID="RetypePassword" Name="RetypePassword" Type="password" style="WIDTH: 160px; HEIGHT: 22px" maxLength=<%=mMaxPWD%>><FONT color=red>* </FONT></td>
</tr>
<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
<tr>
	<td colspan=2 align="center"><INPUT Type="submit" Value="Save">
	<INPUT Type="reset" Value="Reset"></td>    
</tr>
<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
<!--<tr>
	<td>&nbsp;<STRONG><FONT color=blue face=Arial size=2><B>Forgot Password?</B></FONT></STRONG></td>
	<td align=right><FONT face=Arial color=teal size=2><FONT color=red>*</FONT>Mandatory Information!</FONT></td>    
</tr>-->
</table>
<div align="center">
<h6><font face=arial>Note: Keep changing your password for better security</font></h6>
<b><hr>
</div>
<%
}
else
{
out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp'>Login</a> to continue</font> <br>");
}
%>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		
		</td></tr></table>
</BODY>
</HTML>
