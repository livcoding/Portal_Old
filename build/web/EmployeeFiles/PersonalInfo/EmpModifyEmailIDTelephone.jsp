<!--
Changes By      Vivek Kumar Soni
Date            07.06.2017
Modification    Adhar And UAN no Added
-->


<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="",maadhar="";
String mInst="",mWebEmail="";
String mMem="";
String mMemID="";
String mDID="";
String qry="";
String mScellNo="";
String mSStd="";
String mStelNo="";
String mCPNo="";
String mSemail="",mDMemC="",mInstC="",mMemberID="",mMemberType="";
String mCADDRESS1="",mCADDRESS2="",mCADDRESS3="";
String mCAdd3="",mCAdd2="",mCAdd1="",mPOLSTATION="",mDISTRICT="",mSTATE="";
String mADDRESS1="",mADDRESS2="",mADDRESS3="",mCITY="",mPIN="",mPOSTOFFICE="",mRAILSTATION="";
int n=0;
String x="";
ResultSet rs=null,rsi=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();

try
{
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}


if (session.getAttribute("InstituteCode")==null)
{
    mInstC="";
}
else
{
    mInstC=session.getAttribute("InstituteCode").toString().trim();
}
if(session.getAttribute("MemberCode")==null)
{
	mMem="";
}
else
{
	mMem=session.getAttribute("MemberCode").toString().trim();
}
/*
if(session.getAttribute("MemberID")==null)
{
	mMemID="";
}
else
{
	mMemID=session.getAttribute("MemberID").toString().trim();
}
*/
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



if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	OLTEncryption enc=new OLTEncryption();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
	mDMemC=enc.decode(session.getAttribute("MemberCode").toString().trim());

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();


if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;


if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------


  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('48','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------


        qry="select nvl(a.PPHONENOS,' ') sTel, nvl(a.CPHONENOS,' ') CPNo, nvl(a.MOBILE,' ') SCell,nvl(a.EMAILID,' ') sEmail,nvl(a.CADDRESS1,' ')CADDRESS1,nvl(a.CADDRESS2,' ')CADDRESS2," +
        " nvl(a.CADDRESS3,' ')CADDRESS3,NVL(a.CCITY,' ')CCITY,NVL(a.CDISTRICT,' ')CDISTRICT,NVL(a.CSTATE,' ')CSTATE,NVL(a.CPIN,'')CPIN " +
        " ,nvl(b.Aadharno,' ') AADHARNO from EMPLOYEEADDRESS a , Employeedetail b where a.EMPLOYEEID=b.EMPLOYEEID and a.EMPLOYEEID='" +mDID+ "'";
//out.print(qry);
rs=db.getRowset(qry);
if ( rs.next())
{
	if (rs.getString("SCell").equals(" "))
		mSCellNo="";
	else
	   	mSCellNo=rs.getString("SCell");


	if(rs.getString("sTel").equals(" "))
		 mSTelNo="";
	else
		mSTelNo=rs.getString("sTel");


	if(rs.getString("CPNo").equals(" "))
		 mCPNo="";
	else
		mCPNo=rs.getString("CPNo");


	if(rs.getString("sEmail").equals(" "))
		mSEmail="";
	else
		mSEmail=rs.getString("sEmail");

	if(rs.getString("CADDRESS1").equals(" "))
		mADDRESS1="";
	else
		mADDRESS1=rs.getString("CADDRESS1");

   if(rs.getString("CADDRESS2").equals(" "))
		mADDRESS2="";
	else
		mADDRESS2=rs.getString("CADDRESS2");

   if(rs.getString("CADDRESS3").equals(" "))
		mADDRESS3="";
	else
		mADDRESS3=rs.getString("CADDRESS3");

	if(rs.getString("CCITY").equals(" "))
		mCITY="";
	else
		mCITY=rs.getString("CCITY");

	if(rs.getString("CDISTRICT").equals(" "))
		mDISTRICT="";
	else
		mDISTRICT=rs.getString("CDISTRICT");

	if(rs.getString("CSTATE").equals(" "))
		mSTATE="";
	else
		mSTATE=rs.getString("CSTATE");

	if(rs.getString("CPIN")==null)
		mPIN="";
	else
		mPIN=rs.getString("CPIN");

        if(rs.getString("AADHARNO").equals(" "))
		maadhar="";
	else
		maadhar=rs.getString("AADHARNO");



}

%>

<html>
<head>
<title>#### <%=mHead%> [ Change Contact information ]</title>
<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->
</script>



<script language=javascript>
	<!--
	function RefreshContents()
	{
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script language="JavaScript" type ="text/javascript">
<!--
if (top != self) top.document.title = document.title;
-->
</script>
<SCRIPT TYPE="text/javascript">
<!--
// copyright 1999 Idocs, Inc. http://www.idocs.com
// Distribute this script freely but keep this notice in place
function numbersonly(myfield, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

// control keys
if ((key==null) || (key==0) || (key==8) ||
    (key==9) || (key==13) || (key==27) )
   return true;

// numbers
else if ((("0123456789.").indexOf(keychar) > -1))
   return true;

// decimal point jump
else if (dec && (keychar == "."))
   {
   myfield.form.elements[dec].focus();
   return false;
   }
else
   return false;
}

//-->
</SCRIPT>


</head>
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>

<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Change Employee Contact Information</font>
</td>
</tr>
</TABLE>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>


<TABLE cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial;
FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
     <TR align="middle" bgcolor="#ff8c00">
		<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Employee Contact Detail (Current)</STRONG></FONT></P></TD>
		<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Employee Contact Detail (New)</STRONG></FONT></P></TD>
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mSCellNo%> </FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
		<td><INPUT ID="SCellNo" Name="SCellNo" Type="text" value="<%=mSCellNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Correspondence Phone</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mCPNo%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;Correspondence Phone</FONT></td>
		<TD><INPUT ID="CPN" Name="CPN" Type="text" value="<%=mCPNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>
	</TR>

	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Permanent Phone</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mSTelNo%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;Permanent Phone</FONT></td>
		<TD><INPUT ID="STelNo" Name="STelNo" Type="text" value="<%=mSTelNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>
	</TR>

	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mSEmail%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
		<td><INPUT ID="SEMail" Name="SEMail" Type="text" value="<%=mSEmail%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=60><font color=red>*</font></td>
	</TR>

        <TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;AAdhar No</FONT></TD>
		<td><FONT color=black>&nbsp;<%=maadhar%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;AAdhar No</FONT></TD>
		<td><INPUT ID="aadhar" Name="aadhar" Type="text" value="<%=maadhar%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=60><font color=red>*</font></td>
	</TR>

     <TR align="middle" bgcolor="#ff8c00">
		<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Correspondance Address (Current)</STRONG></FONT></P></TD>
		<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Correspondance Address(New)</STRONG></FONT></P></TD>
	</TR>
	<TR>
	    <TD><FONT color=black face=Arial size=2>&nbsp;Address 1</font></TD>
		<td><FONT color=black>&nbsp;<%=mADDRESS1%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;Address 1</font></TD>
		<td><Input type="text" style="WIDTH: 160px; HEIGHT: 22px" maxLength=60 id="Address1" name="Address1"  value="<%=mADDRESS1%>"></td>
	</TR>
	<TR>
	    <TD><FONT color=black face=Arial size=2>&nbsp;Address 2</font></TD>
		<td><FONT color=black>&nbsp;<%=mADDRESS2%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;Address 2</font></TD>
		<td><Input type="text" style="WIDTH: 160px; HEIGHT: 22px" maxLength=60 id="Address2" name="Address2"  value="<%=mADDRESS2%>"></td>

	</TR>
	<TR>
	   <TD><FONT color=black face=Arial size=2>&nbsp;Address 3</font></TD>
		<td><FONT color=black>&nbsp;<%=mADDRESS3%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;Address 3</font></TD>
		<td><Input type="text" style="WIDTH: 160px; HEIGHT: 22px" maxLength=60 id="Address3" name="Address3"  value="<%=mADDRESS3%>"></td>
	</TR>
	<TR>
	    <TD><FONT color=black face=Arial size=2>&nbsp;City</font></TD>
		<td><FONT color=black>&nbsp;<%=mCITY%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;City</font></TD>
		<td><Input type="text" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30 id="City" name="City"  value="<%=mCITY%>"></td>

	</TR>
	<TR>
	   <TD><FONT color=black face=Arial size=2>&nbsp;PIN</font></TD>
		<td><FONT color=black>&nbsp;<%=mPIN%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;PIN</font></TD>
		<td><Input type="text" style="WIDTH: 160px; HEIGHT: 22px" maxLength=6 id="Pin" name="Pin"  value="<%=mPIN%>" onKeyPress="return numbersonly(this, event);"></td>

	</TR>
	<TR>
	    <TD><FONT color=black face=Arial size=2>&nbsp;District</font></TD>
		<td><FONT color=black>&nbsp;<%=mDISTRICT%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;District</font></TD>
		<td><Input type="text" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30 id="District" name="District"  value="<%=mDISTRICT%>"></td>

	</TR>
	<TR>
	    <TD><FONT color=black face=Arial size=2>&nbsp;State</font></TD>
		<td><FONT color=black>&nbsp;<%=mSTATE%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;State</font></TD>
		<td><Input type="text" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30 id="State" name="State"  value="<%=mSTATE%>"></td>

	</TR>

	<TR><td colspan=4 align=center><INPUT Type="submit" Value="Save"></td></TR>
	</TABLE></form>
<%


	if (request.getParameter("x")!=null)
	{
		if(request.getParameter("SCellNo")==null)
			mScellNo="";
		else
			mScellNo=GlobalFunctions.replaceSignleQuot(request.getParameter("SCellNo").toString().trim());

		if(request.getParameter("CPN")==null)
			mCPNo="";
		else
			mCPNo=GlobalFunctions.replaceSignleQuot(request.getParameter("CPN").toString().trim());

		if(request.getParameter("STelNo")==null)
			mStelNo="";
		else
			mStelNo=GlobalFunctions.replaceSignleQuot(request.getParameter("STelNo").toString().trim());

		if(request.getParameter("SEMail")==null)
			mSemail="";
		else
			mSemail=GlobalFunctions.replaceSignleQuot(request.getParameter("SEMail").toString().trim());

		if(request.getParameter("Address1")==null)
			mADDRESS1="";
		else
			mADDRESS1=GlobalFunctions.replaceSignleQuot(request.getParameter("Address1").toString().trim());

		if(request.getParameter("Address2")==null)
			mADDRESS2="";
		else
			mADDRESS2=GlobalFunctions.replaceSignleQuot(request.getParameter("Address2").toString().trim());

		if(request.getParameter("Address3")==null)
			mADDRESS3="";
		else
			mADDRESS3=GlobalFunctions.replaceSignleQuot(request.getParameter("Address3").toString().trim());

		if(request.getParameter("City")==null)
			mCITY="";
		else
			mCITY=GlobalFunctions.replaceSignleQuot(request.getParameter("City").toString().trim());
		if(request.getParameter("Pin")==null)
		{
			mPIN="";
		}
		else
		{
			mPIN=GlobalFunctions.replaceSignleQuot(request.getParameter("Pin").toString().trim());
		}
		if(request.getParameter("District")==null)
			mDISTRICT="";
		else
			mDISTRICT=GlobalFunctions.replaceSignleQuot(request.getParameter("District").toString().trim());
		if(request.getParameter("State")==null)
			mSTATE="";
		else
			mSTATE=GlobalFunctions.replaceSignleQuot(request.getParameter("State").toString().trim());
                if(request.getParameter("aadhar")==null)
			maadhar="";
		else
			maadhar=GlobalFunctions.replaceSignleQuot(request.getParameter("aadhar").toString().trim());

 	    try
	    {

		if(!mSemail.equals(""))
		{
 	         	qry="SELECT 'y' FROM EmployeeAddress where EMPLOYEEID='"+mDID+"' ";
			rs=db.getRowset(qry);
			if (rs.next())
			{
		 		qry="update EMPLOYEEADDRESS set MOBILE='"+mScellNo+"',PPHONENOS='"+mStelNo+"',CPHONENOS='"+mCPNo+"', ";
				qry=qry +" EMAILID='"+mSemail+"',CADDRESS1='"+mADDRESS1+"',CADDRESS2='"+mADDRESS2+"',CADDRESS3='"+mADDRESS3+"',CCITY='"+mCITY+"',CDISTRICT='"+mDISTRICT+"',CSTATE='"+mSTATE+"',CPIN='"+mPIN+"' WHERE EMPLOYEEID='"+mDID+"' ";

                                String qryupd="update employeedetail set AADHARNO='"+maadhar+"' WHERE EMPLOYEEID='"+mDID+"'";

				n=db.update(qry);
                                int m=db.update(qryupd);
			}
			else
			{
				qry=" Insert into EMPLOYEEADDRESS (EMPLOYEEID, PPHONENOS, CPHONENOS, MOBILE, EMAILID,CADDRESS1,CADDRESS2,CADDRESS3,CCITY,CDISTRICT,CSTATE,CPIN)";
				qry=qry+" Values('"+mDID+"', '"+mStelNo+"', '"+mCPNo+"', '"+mScellNo+"', '"+mSemail+"','"+mADDRESS1+"','"+mADDRESS2+"','"+mADDRESS3+"','"+mCITY+"','"+mDISTRICT+"','"+mSTATE+"','"+mPIN+"') ";
				n =db.insertRow(qry);


                                String qryupd="update employeedetail set AADHARNO='"+maadhar+"' WHERE EMPLOYEEID='"+mDID+"'";
                                int m=db.update(qryupd);
			}
			if(n>0)
			{
				// Log Entry
	  		   //-----------------

			    db.saveTransLog(mInstC,mLogEntryMemberID,mLogEntryMemberType ,"EDIT PERSONAL INFORMATION", "Member Code :"+ mDMemC, "No MAC Address" , mIPAddress);
			   //-----------------
				out.print("<b><font size=3 face='Arial' color='Green'><center>Information changed successfully</center></font></b><br>");
				response.sendRedirect("EmpModifyEmailIDTelephone.jsp");
			}
		}
		else
		{
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>E-Mail can't be left blank</font></b><br>");
		}
	    }
	    catch(Exception e)
	    {
	    }
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
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
   <%
}
  //-----------------------------
}
else
{
%>
<br>Session timeout! Please <a href="../index.jsp">Login</a> to continue...
 <%

}

 %><br><br><br><br><br><br>
<center>
</body>
<%
}
catch(Exception e)
{
    e.printStackTrace();
}
%>
</html>
