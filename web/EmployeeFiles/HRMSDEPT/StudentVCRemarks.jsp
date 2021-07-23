<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
	String mEnroll="",mSysDate="";


%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student VC Remarks] </TITLE>


</HEAD>
<%
String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="";
DBHandler db=new DBHandler();
ResultSet rs=null;
String mWebEmail="";
String mInst="";

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}


if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
%>

<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto onLoad="Documentdisable();">
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('188','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA">Remarks for Students</font>
</td>
</tr>
</TABLE>
<form name="frm"  method="post" action="StudentVCRemarksAct.jsp">
<input type=hidden name="x" id="x">
<table align=center rules=groups border=1 cellspacing=0 cellpadding=0 width=60%>
<tr>
<td><b>Student Enrollment no</b></td>
<td><input type=text  name="Enrollment" id="Enrollment" maxlength=20></td>
<td><input type=submit value="Submit"></td>
</tr>
</table>
<input type=hidden name="FLAG" value='S'>
</form>

<br>
<br>
<br>
<table width="100%" ALIGN=CENTER bottommargin=0 cellspacing=0 cellpadding=0 topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA">Remarks for Employees</font>
</td>
</tr>
</TABLE>
<form name="frm1"  method="post" action="StudentVCRemarksAct.jsp">
<input type=hidden name="y" id="y">
<table align=center rules=groups border=1 width=60% cellspacing=0 cellpadding=0>
<tr>
<td><b>Employee Code</b></td>
<td><input type=text  name="Enrollment" id="Enrollment" maxlength=20></td>
<td><input type=submit value="Submit"></td>
</tr>
</table>
<input type=hidden name="FLAG" value='E'>
</form>
<%


 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
   {
   %>
<br>	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }
  //-----------------------------

}
else
{
out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp'>Login</a> to continue</font> <br>");
}
%>
<br>
<br>
<br>
</BODY>
</HTML>