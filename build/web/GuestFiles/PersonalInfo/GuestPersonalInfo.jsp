<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	EmpPersonalInfo.JSP		[For Employee]			   *
	' * Author:		Ashok Kumar Singh 						         *
	' * Date:		26th Oct 2006	 							   *
	' * Version:	1.0									   *	
	' **********************************************************************************************************
*/

String qry="",mWebEmail="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null;
String GID="", GName="", mDegs="", mAddress1="", mAddress2="", mCityState="", mPhone="", mEmail="";
String mParentComp="";
String mMemberID="",mMemberType="",mMemberCode="";

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
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

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Personal Information ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>


</head>

<body   topmargin=4 rightmargin=0 leftmargin=0 bottommargin=0 bgColor="#fce9c5">
<% 
if(!mMemberID.equals("") || !mMemberCode.equals(""))
{
mMemberID=enc.decode(mMemberID);
mMemberCode=enc.decode(mMemberCode);


	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
qry="Select WEBKIOSK.ShowLink('1','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
RsChk= db.getRowset(qry);
if (RsChk.next() && RsChk.getString("SL").equals("Y"))
{
//----------------------
try
{
qry="Select NVL(GUESTCODE,' ')GID, NVL(GUESTNAME,' ')GNAME, NVL(DESIGNATION,' ')DEGS, NVL(ADDRESS1,' ')ADD1, NVL(ADDRESS2,' ')ADD2, ";
qry=qry+" NVL(CITYSTATE,' ')CTST, NVL(PHONENOS,' ')PHNO, NVL(EMAILID,' ')EID, NVL(CELLNO,' ')CNO, NVL(PARENTCOMPANYNAME,'')PCN ";
qry=qry+" from GUEST WHERE GUESTID='"+mMemberID+"'";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
   GID=rs.getString("GID");
   GName=rs.getString("GNAME");
   mDegs=rs.getString("DEGS");
   mAddress1=rs.getString("ADD1");
   mAddress2=rs.getString("ADD2");
   mCityState=rs.getString("CTST");
   mPhone=rs.getString("PHNO");
   mEmail=rs.getString("EID");
   mParentComp=rs.getString("PCN");
%>
<CENTER><FONT face="MS Sans Serif"><FONT 
face="Arial" color=mahroon size=3><b>PERSONAL INFORMATION</b></FONT></CENTER><br>
<CENTER>    
 <TABLE cellspacing=0 border=1 frame=box cellpadding=2   align="center"  style="FONT-FAMILY: Verdana; FONT-SIZE: x-small; HEIGHT: 324px; WIDTH: 601px" borderColor=black borderColorDark=white>
   <TR>
    <TD><FONT face=Verdana><FONT color=black size=2>&nbsp;Guest Name</FONT><FONT face=Verdana> </FONT></FONT> </TD>
        <td colspan=3>&nbsp; <%=GName%></FONT></td></TR>	
        <TR><TD nowrap><FONT face=Verdana><FONT color=black size=2>&nbsp;Guest Code</FONT> </FONT> </TD>
        <TD colspan=3><FONT face=Verdana color=black size=2>&nbsp; <%=GID%></FONT></TD></TR>
        <TR>

        <TD><FONT color=black face="Verdana" size=2>&nbsp;Parent Company Name </FONT></TD>
      	<TD colspan=3><FONT face=Verdana color=black size=2>&nbsp; <%=mParentComp%></FONT></TD>
	  </tr>
	  <tr>
            <TD><FONT color=black face="Verdana" size=2>&nbsp;Designation </FONT></TD>
            <TD align="left" colspan=3><FONT face=Verdana color=black size=2>&nbsp; <%=mDegs%></FONT></TD>				
        </TR>	

	<TR>
		<TD><FONT color=black face="Verdana">&nbsp;Phone</FONT></TD>	
		<TD colspan=3>&nbsp; <%=mPhone%></TD>
	</TR>
	<TR>
		<TD><FONT color=black face="Verdana">&nbsp;E-Mail </FONT></TD>	
		<TD colspan=3>&nbsp; <%=mEmail%></TD>
	</TR>
      <TR  Rowspan="2" colspan="2"><TD colspan=4><STRONG>
        <FONT face ="Verdana" color=#a00000>&nbsp;Correspondences Address</FONT></STRONG></TD>
	</tr>
        <TR style="VERTICAL-ALIGN: top"><TD><FONT color=black face="Verdana" >&nbsp;Address </FONT> </TD>
                <TD nowrap colspan=3><FONT face="Verdana">&nbsp; <%=GlobalFunctions.toTtitleCase(mAddress1)  %><br>&nbsp; <%=GlobalFunctions.toTtitleCase(mAddress2)%></FONT></TD>

        <tr><td><FONT color=black face="Verdana">&nbsp;City / State </FONT></td> 	
        <TD colspan=3>&nbsp; <%=GlobalFunctions.toTtitleCase(mCityState)%></TD>
	</TABLE></CENTER>
	<%
	}
	else
	{
		%>
		<P><FONT size=2><FONT face=Verdana color=black><B>&nbsp;&nbsp; Profile not found</B></FONT></P>
		<%
	}
}
catch(Exception e)
{
//out.print(e.getMessage());
}
//-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
}
else
{
	%>
	<br>
	<font color=red>
	<h3>	<br><img src='.../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
	<%
}
//-----------------------------
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Verdana' color='Red'><B>Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</B></font> <br>");
}
%>
<center>
	<table ALIGN=Center VALIGN=TOP>
	<tr>
	<td valign=middle>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
	A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
	<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 		</td></tr></table>
</body>
</Html>
