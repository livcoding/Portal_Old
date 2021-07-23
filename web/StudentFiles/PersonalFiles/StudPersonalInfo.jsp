<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

ResultSet  rs=null;
String qry="";
String mDID="";
DBHandler db=new DBHandler();
ResultSet  Qrs=null;
GlobalFunctions gb =new GlobalFunctions();

/*
	'
*************************************************************************************************
	' *
	' * File Name:	StudPersonalInfo.JSP		[For Students]
	' * Author:		Vivek Soni
	' * Date:		08th may 2017
	' * Version:		1.0
	' * Description:	Displays Personal Info. of Students
 *          Last changes                   Student Adhar Card no
*************************************************************************************************
*/

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>

<style type="text/css">
body {scrollbar-3dlight-color:#ffd700;
scrollbar-arrow-color:#ff0;
scrollbar-base-color:=:#000ff0;
scrollbar-darkshadow-color:#000000;
scrollbar-face-color:#de6400;
scrollbar-highlight-color:#9900005;
scrollbar-shadow-color:#f0f}
</style>
<TITLE>#### <%=mHead%> [ Student Personal Information ] </TITLE>

</head>
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<%
String mSEMESTER  ="";
String mSname="";
String mCOURSENAME ="";
String mSUBSECTIONCODE="";
String mBRANCHCODE="", mcaddress1 ="", mcaddress2="", mcaddress3="",mcDistrict="",mcPIN="",mcCity="";
String mcState="",mpaddress1="", mpaddress2="",mpaddress3="", mpDistrict="",mpPIN="",mpCity="";
String mpState="",mENROLLMENTNO ="", mFATHERNAME="",mStudentTel;
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="",mAdhar="";
String mInst="",mWebEmail="";
try{
// session.getAttribute("MemberID").toString().trim()
OLTEncryption enc=new OLTEncryption();
if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{        //uv 2

        String mStudentID=enc.decode(session.getAttribute("SudentID").toString().trim());
        String mCode=enc.decode(session.getAttribute("Code").toString().trim());
        //String mMemberCode=
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

	if (session.getAttribute("InstituteCode")==null || session.getAttribute("InstituteCode").toString().equals(""))
   mInst="";
else
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}
mInst=session.getAttribute("InstituteCode").toString().trim();
mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
qry= " Select nvl(fathername,' ') fathername,nvl(ENROLLMENTNO, ' ') ENROLLMENTNO, ";
qry=qry +" nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
qry=qry +" nvl(SEMESTER,0) SEMESTER,nvl(caddress1,' ') caddress1,nvl(caddress2,' ') caddress2, ";
qry=qry +" nvl(caddress3,' ') caddress3,nvl(cdistrict,' ') cdistrict,nvl(ccity,' ') ccity, ";
qry=qry +" nvl(to_char(cpin),' ') cpin,nvl(cstate,' ') cstate,nvl(paddress1,' ') paddress1, ";
qry=qry +" nvl(paddress2,' ') paddress2,nvl(paddress3,' ') paddress3,nvl(pdistrict,' ') pdistrict, ";
qry=qry +" nvl(pcity,' ') pcity,nvl(to_char(ppin),' ') ppin,nvl(pstate,' ') pstate , ";
qry=qry +" nvl(studentname,' ') studentname,";
qry=qry +" NVL (CPHONENO, ' ') PHONENUMBER , AADHARNO, nvl(SUBSECTIONCODE,' ') SUBSECTIONCODE from ";
qry=qry +" StudentMaster a , studentaddress b where ";
qry=qry +" a.StudentID='" +mDID+ "'" + " and  ";
qry=qry +" a.studentid = b.studentid (+) and InstituteCode='" + mInst + "' ";

//out.println(qry);

rs=db.getRowset(qry);
if ( rs.next())
{
mSEMESTER=rs.getString(5);
mSname=rs.getString(20);

//out.println("mSname " + mSname);

mCOURSENAME=rs.getString(3);
if (rs.getString(4)==null)
	mBRANCHCODE="";
else
	mBRANCHCODE=rs.getString(4);

if (rs.getString(6)==null)
	mcaddress1="";
else
	mcaddress1=rs.getString(6);
if (rs.getString(7)==null)
	mcaddress2	="";
else
	mcaddress2=rs.getString(7);
if (rs.getString(8)==null)
	mcaddress3="";
else
	mcaddress3=rs.getString(8);

if (rs.getString(9)==null)
	mcDistrict="";
else
  mcDistrict=rs.getString(9);

if (rs.getString(11)==null)
	mcPIN="";
else
	mcPIN=rs.getString(11);

if (rs.getString(10)==null)
	mcCity="";
else
	mcCity=rs.getString(10);

if (rs.getString(12)==null)
   mcState="";
else
mcState=rs.getString(12);

if (rs.getString(13)==null)
   mpaddress1="";
else
   mpaddress1=rs.getString(13);

if (rs.getString(14)==null)
   mpaddress2="";
else
   mpaddress2=rs.getString(14);

if (rs.getString(15)==null)
   mpaddress3="";
else
   mpaddress3=rs.getString(15);

if (rs.getString(16)==null)
	mpDistrict = "";
else
	mpDistrict = rs.getString(16);

if (rs.getString(17)==null)
	mpCity = "";
else
	mpCity = rs.getString(17);

if (rs.getString(18)==null)
	mpPIN ="";
else
	mpPIN = rs.getString(18);

if (rs.getString(19)==null)
	mpState = "";
else
	mpState = rs.getString(19) ;

if (rs.getString(2) ==null)
	mENROLLMENTNO="";
else
	mENROLLMENTNO=rs.getString(2);

if (rs.getString(1)==null)
	mFATHERNAME="";
else
	mFATHERNAME=rs.getString(1);

if (rs.getString(21)==null)
	mStudentTel="";
else
	mStudentTel=rs.getString(21);
if (rs.getString(22)==null)
	mAdhar	="";
else
	mAdhar=rs.getString(22);
	


if(rs.getString(23)==null)
    mSUBSECTIONCODE="";
else
   mSUBSECTIONCODE=rs.getString(23);


//out.println("The mStudentTel No>>>>>= " + mStudentTel);

// FOR CONTACT DETAILS

qry="select nvl(StStdCode,' ')||'-'||nvl(StTelNo,' ') sTel,nvl(StCellNo,' ') SCell,nvl(StEmailid,' ') sEmail,nvl(PaStdCode,' ')||'-'||nvl(PaTelNo,' ') pTel,nvl(PaCellNo,'') pCell,nvl(PaEmailid,'') pEmail from Studentphone where STUDENTID='" +mDID+ "'";
//out.println("Second qry is = " + qry);
rs=db.getRowset(qry);
 if ( rs.next())
{
	if (rs.getString("SCell")==null)
		mSCellNo="";
	else
	   	mSCellNo=rs.getString("SCell");

	if (rs.getString("pCell")==null)
		 mPCellNo="";
	else
		 mPCellNo=rs.getString("pCell");


	if(rs.getString("sTel")==null)
		 mSTelNo="";
	else
		mSTelNo=rs.getString("sTel");
	//out.println("mSTelNo jjjjjjjjjj= " + mSTelNo);

	if(rs.getString("pTel")==null)
		mPTelNo="";
	else
		mPTelNo=rs.getString("pTel");

	if(rs.getString("sEmail")==null)
		 mSEmail="";
	else
		 mSEmail=rs.getString("sEmail");

	if(rs.getString("pEmail")==null)
		 mPEmail="";
	else
		 mPEmail=rs.getString("pEmail");

 }
session.setAttribute("mStudentID",mDID);
%>
 <CENTER><STRONG><FONT color=black face=Arial size=2>PERSONAL INFORMATION
</FONT></STRONG></CENTER>
 <CENTER>

<TABLE cellspacing=0  cellpadding=2 frame=box align="center" border=1 style="FONT-FAMILY: Arial;
FONT-SIZE: x-small" borderColor=black borderColorDark=white >
   <TR>
	<td colspan=3>&nbsp;
	</td>
   	<td colspan=2  rowspan=8 align="center" style="width:130px; height:180px">
		<!-- <img SRC="ShowStudentImage.jsp" align="center" style="width:130px; height:180px "> -->
	</TD>
	</tr>
	<tr>
    <TD><FONT color=black face=Arial size=2
     >&nbsp;Name
      </FONT> </TD>
	<td colspan=2><FONT color=black>&nbsp;<%=GlobalFunctions.toTtitleCase(mSname) %></FONT>&nbsp;</td></TR>
	<TR><TD><FONT face=Arial size="2"><FONT color=black>&nbsp;Enrollment
      No.</FONT> </FONT> </TD>
	<TD colspan=2><FONT color=black>&nbsp; <%=mENROLLMENTNO%></FONT>&nbsp;</TD></TR>
	<TR><TD><FONT color=black face=Arial size=2
     >&nbsp;Father's
      Name   </FONT></TD>
	<TD colspan=2><FONT color=black>&nbsp;
<%=GlobalFunctions.toTtitleCase(mFATHERNAME)%></FONT>&nbsp;</TD></TR>
	<TR><TD><FONT color=black face=Arial size=2
     >&nbsp;Course </FONT></TD>
	<TD colspan=2><FONT color=black>&nbsp; <%=mCOURSENAME%>
<FONT face=Arial size=2>( <%=mBRANCHCODE %>)</FONT>  </FONT>	</TD></TR>
        <TR><TD><FONT color=black face=Arial size=2
     >&nbsp;Batch </FONT></TD>
	<TD colspan=2><FONT color=black>&nbsp; <%=mSUBSECTIONCODE%></FONT></TD></TR>
	<tr><TD><font color="black" face=Arial size=2
     >&nbsp;Semester</font></TD><TD align="left" colspan="2"><FONT color=black>&nbsp;
<%=mSEMESTER%></FONT>&nbsp;</TD></tr>

        <tr><TD><font color="black" face=Arial size=2
     >&nbsp;Adhar No.</font></TD><TD align="left" colspan="2"><FONT color=black>&nbsp;
<%=mAdhar%></FONT>&nbsp;</TD></tr>

     <TR align="middle">
		<TD colspan="2"><P align=left><FONT color=maroon face=Arial size=2><STRONG>&nbsp;Student Contact detail</STRONG></FONT></P></TD>
		<TD colspan="2"><P align=left><FONT color=maroon face=Arial size=2><STRONG>&nbsp;Parent/Guardian Contact detail</STRONG></FONT></P></TD>
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mSCellNo %></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mPCellNo %></FONT>&nbsp;</td>
	</TR>
	<TR>

		<%
		//out.println("The Telephone No= " + mSTelNo);

		//out.println("The mStudentTel No<<<<<<= " + mStudentTel);

			//boolean bl=mSTelNo.equals(mStudentTel);

			//out.println("b11111 = " + bl);
//***************TelephoneNo,studentphone table 05-03-2010*****


		%>


	<%
	if(mSTelNo.equals(mStudentTel)){

	%>
	<%
	//out.println("The Telephone No= " + mSTelNo);

	//out.println("The mStudentTel No<<<<<<>>>>>= " + mStudentTel);
	%>
		<TD><FONT color=black face=Arial size=2>&nbsp;Telephone</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mSTelNo%></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;Telephone</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mPTelNo %></FONT>&nbsp;</td>

	</TR>
	<%}else{
	//out.println("The Telephone No=llllllll " + mStudentTel);

	%>
	<TR>

			<TD><FONT color=black face=Arial size=2>&nbsp;Telephone</FONT></TD>
			<td><FONT color=black>&nbsp;<%=mStudentTel%></FONT>&nbsp;</td>
			<TD><FONT color=black face=Arial size=2>&nbsp;Telephone</FONT></TD>
			<td><FONT color=black>&nbsp;<%=mPTelNo %></FONT>&nbsp;</td>

	</TR>
	<%
	}

	//************************************************************
	%>








	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mSEmail %></FONT>&nbsp;</td>
		<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mPEmail %></FONT>&nbsp;</td>
	</TR>


	<TR align="middle" Rowspan='2"' colspan="2"><TD colspan="2">
      <P align=left><FONT color=maroon face=Arial size=2
     ><STRONG>&nbsp;Correspondence Address</STRONG></FONT></P></TD><td colspan="2">
      <P align=left><FONT color=maroon face=Arial size=2><STRONG>&nbsp;Permanent Address
</STRONG></FONT></P></td> </TR>
     <TR align=left vAlign=top><TD><FONT color=black face=Arial size=2>&nbsp;Address </FONT>
</TD>
	<TD><FONT color=black>&nbsp; <%=GlobalFunctions.toTtitleCase(mcaddress1)%></FONT><br>
	    <FONT color=black>&nbsp; <%=GlobalFunctions.toTtitleCase(mcaddress2) %></FONT><br>
	<FONT color=black>&nbsp;<%=mcaddress3%></FONT></TD>
	    <td><FONT color=black face=Arial size=2
     >&nbsp;Address </FONT> </td>
	<TD><FONT color=black>&nbsp; <%=GlobalFunctions.toTtitleCase(mpaddress1)%></FONT><br>
	    <FONT color=black>&nbsp; <%=GlobalFunctions.toTtitleCase(mpaddress2)%></FONT><br>
	    <FONT color=black>&nbsp; <%=mpaddress3%></FONT></TD>	</TR>

	<tr><td><FONT color=black face=Arial size=2
     >&nbsp;District </FONT></td>
	<TD><FONT color=black>&nbsp;
<%=GlobalFunctions.toTtitleCase(mcDistrict)%></FONT>&nbsp;</TD>

	<td><FONT color=black face=Arial size=2
     >&nbsp;District </FONT></td>
	<td><FONT color=black>&nbsp;
<%=GlobalFunctions.toTtitleCase(mpDistrict)%></FONT>&nbsp;</td></tr>

	<tr><TD><FONT face=Arial size="2"><FONT color=black>&nbsp;City/PIN</FONT> </FONT> </TD>
	<TD><FONT color=black>&nbsp; <%=GlobalFunctions.toTtitleCase(mcCity)%><FONT face=Arial
size=2>/<%=GlobalFunctions.toTtitleCase(mcPIN) %></FONT></FONT></TD>
	<td><FONT color=black face=Arial size=2
     >&nbsp;City/PIN</FONT></td>
	<td><FONT color=black>&nbsp; <%=GlobalFunctions.toTtitleCase(mpCity)%><FONT face=Arial
size=2>/<%=GlobalFunctions.toTtitleCase(mpPIN)%></FONT></FONT></td></tr>

	<tr><TD><FONT color=black face=Arial size=2
     >&nbsp;State </FONT> </TD>
	<TD><FONT color=black>&nbsp; <%=GlobalFunctions.toTtitleCase(mcState)
%></FONT>&nbsp;</TD>

	<td><FONT color=black face=Arial size=2
     >&nbsp;State </FONT></td>
	<td><FONT color=black>&nbsp;
<%=GlobalFunctions.toTtitleCase(mpState)%></FONT>&nbsp;</td></tr>
</TABLE></CENTER>

<!-- Student Qualifications -->
<%
	String Qqry="Select nvl(NameOfBoard,' ') NameOfBoard, nvl(ExamPassed,' ') ExamPassed, nvl(YearOfPassing,0) YearOfPassing, nvl(Division,' ') Division, nvl(MaxMarks,0) MaxMarks, nvl(MarksObtained,0) MarksObtained, ";
	Qqry = Qqry + " nvl(PercentOfMarks,0) PercentOfMarks, nvl(Grade,' ') Grade ";
	Qqry = Qqry + " From STUDENTQUALIFICATION Where StudentID ='" + mDID+ "' order by YearOfPassing desc";

 	//out.print(SID);

	Qrs=db.getRowset(Qqry);
      %>
<BR><CENTER><STRONG><FONT color=black face=Arial size=2>QUALIFICATION DETAILS</FONT></STRONG></CENTER>

	 <table align=center bgcolor=#fce9c5 class="sort-table" id="table-1" border=1 cellpadding=0 cellspacing=0 style="face=Arial;size=2">
	 <tr bgcolor="#ff8c00">
	  <TH><font color=white><b>Name of Board</b></font></TH>
	  <TH><font color=white><b>Exam Passed</b></font></TH>
	  <TH><font color=white><b>Year of Passing</b></font></TH>
	  <TH><font color=white><b>Division</b></font></TH>
	  <TH><font color=white><b>Max Marks</b></font></TH>
	  <TH><font color=white><b>Marks Obtained</b></font></TH>
	  <TH><font color=white><b>% of Marks</b></font></TH>
	  <TH><font color=white><b>Grade</b></font></TH>
	  </tr>

	  <%
  	 while (Qrs.next())
	 {
	%>
      <tr>
		<td><%=Qrs.getString("NameOfBoard")%></td>
		<td><Font face=Arial size=2><%=Qrs.getString("ExamPassed")%></font></td>
		<td><%=Qrs.getString("YearOfPassing")%></td>
		<td><%=Qrs.getString("Division")%></td>
		<td align=right><%=Qrs.getString("MaxMarks")%></td>
		<td align=right><%=Qrs.getString("MarksObtained")%></td>
		<td align=right><%=Qrs.getString("PercentOfMarks")%></td>
		<td align=center><%=Qrs.getString("Grade")%></td>
      </tr>

    <%
    }
   %>
	</TABLE><BR>
  <%


}
else
{
%>
<P><FONT face=Arial size="2"><FONT color=black>Name</FONT><FONT
	color=crimson>:&nbsp;&nbsp; </FONT><FONT color=black>Profile not found</FONT></FONT></P>
 <%
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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
<br>
Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
<%
}
}
catch(Exception e)
{
out.print("Unable to find profile...");
}
%>
<center>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
		</td></tr></table></body>
</Html>