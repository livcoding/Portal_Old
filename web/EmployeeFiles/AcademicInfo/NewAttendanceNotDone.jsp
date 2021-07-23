<%-- 
    Document   : AttendanceRgister
    Created on : Sep 12, 2012, 6:13:27 PM
    Author     : Mohit.sharma
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	AttendanceRegister.JSP		[For Employee]			   *
	' * Author:		Mohit Sharma						         *
	' * Date:		12 Sep 2012	 							   *
	' * Version:		1.0									   *
	' **********************************************************************************************************
*/

String qry="",mWebEmail="",MSUBID="",mqryacademicyear="",mDateFrom="",mDateTo="";
String mSTUDID="",mFSTID="",mATTTYPE="",mEXAMCODE="",mLTP="",mBRANCH="",mSUBSEC="",mAcademicYear="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null, EmployeeRecordSet=null,rsImage=null,rs2=null;
String SName="",CAddress1 ="", CAddress2="",CAddress3="", CDistrict="",CPin="",CCity="",CState="";
String PAddress1 ="", PAddress2="",PAddress3="", PDistrict="", PPin="",qry1="", PCity="",PState="",EnrollmentNo="",FatherName="",HusbandName="", MotherName="";
String DOB="",DOJ="",Grade="", Dept="", Desig="", Category="",AccountNo="", BankName="",PFNO="", PANNO="",PassportNo="";
String pPhone ="",cPhone ="",pCell="" ,pEmail="",PassportValidUpto ="", PassportIssueFrom="",pIssueDate="";
String mMemberID="",mMemberType="",mMemberCode="";


String mSubj="", mSubjID="", mCtype="", mProg="",mSec="",mSub="";
String mExam="", mFaculty="",  mDate1="", mDate2="";
String  mTotal="";
String mAttendanceDate="", mClassFrom="", mClassUpto="",mInst="",qry2="",moldDate="",mStatus="",mColor="",mColor1="",mName="";
String mCType="", mRightsID="82";
double mPerc=0, mTotalStrength=0, mTotalPresent=0;

int mSNO=0;


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

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

//-------- 

	if (request.getParameter("ACAD").toString().trim()==null)
   {
	mqryacademicyear="";
   }
   else
   {	
	mqryacademicyear=request.getParameter("ACAD").toString().trim();
    }


	if (request.getParameter("STUDID").toString().trim()==null)
   {
	mSTUDID="";
   }
   else
   {	
	mSTUDID=request.getParameter("STUDID").toString().trim();
    }
	
	if (request.getParameter("FSTID").toString().trim()==null)
   {
	mFSTID="";
   }
   else
   {	
	mFSTID=request.getParameter("FSTID").toString().trim();
    }	if (request.getParameter("ATTTYPE").toString().trim()==null)
   {
	mATTTYPE="";
   }
   else
   {	
	mATTTYPE=request.getParameter("ATTTYPE").toString().trim();
    }
		if (request.getParameter("EXAMCODE").toString().trim()==null)
   {
	mEXAMCODE="";
   }
   else
   {	
	mEXAMCODE=request.getParameter("EXAMCODE").toString().trim();
    }
		if (request.getParameter("LTP").toString().trim()==null)
   {
	mLTP="";
   }
   else
   {	
	mLTP=request.getParameter("LTP").toString().trim();
    }
		if (request.getParameter("BRANCH").toString().trim()==null)
   {
	mBRANCH="";
   }
   else
   {	
	mBRANCH=request.getParameter("BRANCH").toString().trim();
    }
		if (request.getParameter("SUBSEC").toString().trim()==null)
   {
	mSUBSEC="";
   }
   else
   {	
	mSUBSEC=request.getParameter("SUBSEC").toString().trim();
    }
		

				if (request.getParameter("SUBID").toString().trim()==null)
   {
	MSUBID="";
   }
   else
   {	
	MSUBID=request.getParameter("SUBID").toString().trim();
    }

		////out.print(mSTUDID+"rgret"+mFSTID+"tertert"+mATTTYPE+"reter"+mEXAMCODE+"eryey"+mLTP+"rey"+mBRANCH+"eryey"+mSUBSEC+"eryer");
//-----------
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";
%>
<HTML>
<head>
<TITLE>####<%=mHead%>[Student Not Attended Classes]</TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<link rel="stylesheet" href="../CSSS/style.css" type="text/css" media="screen, projection, tv" />
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<link rel="stylesheet" href="css/style-print.css" type="text/css" media="print" />

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
    //-- Enable Security Page Level

    %>
    <table ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial">Student Not Attended Classes</TD>
</font>
</td>
</tr>
</TABLE>

		
    <%
    qry="Select WEBKIOSK.ShowLink('82','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
		try
		{
%>

<form name="frm" method="post" >
<input id="x" name="x" type=hidden>


<%
String mSnm="", mENo="",mSubject="";
qry="select StudentName, Enrollmentno from StudentMaster where StudentID='"+mSTUDID+"'  and INSTITUTECODE='"+mInst+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mSnm=rs1.getString(1);
mENo=rs1.getString(2);
}

qry="select subject||'('|| subjectcode ||')' subject From subjectmaster where subjectid='"+ MSUBID +"'  and INSTITUTECODE='"+mInst+"'";
	rs1=db.getRowset(qry);
	if(rs1.next())
	{
		mSubject=rs1.getString(1);
	}
%>
	<table align=center bgcolor=white  cellmargin=0 bottommargin=0 border=1>
    <tr ALIGN=CENTER><td  colspan="4"><input type="button" value=" Print this page "
           onclick="window.print();return false;" /></td></TABLE>



<table width="100%">
<tr><td align=center>
 <font color="#00008b">Subject Code: <b><%=mSubject%></B> &nbsp; &nbsp;Student Name: <B><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</B> &nbsp; &nbsp; LTP: <B><%=GlobalFunctions.getLTPDescWSQ(mLTP)%></B></font>
</td></tr></table>
 <TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="70%" border=1 >
<thead>
    <%
String mStCellNo="",mStEmail="";

qry="SELECT DISTINCT  NVL(STCELLNO,' ')STCELLNO, NVL(STEMAILID,' ')STEMAILID  " +
        "FROM STUDENTPHONE A WHERE A.STUDENTID='"+mSTUDID+"' ";
		rs2=db.getRowset(qry);
		if(rs2.next())
			{
				mStCellNo= rs2.getString("STCELLNO");
					mStEmail=rs2.getString("STEMAILID");
			}
		out.print("<br><font color=red size=2> Attendance entry is missing for this student   </font><br>");
		out.print("<font color=red size=2> Student MobileNo. : "+mStCellNo+" , Email-ID : "+ mStEmail +" ");
        %>
<tr bgcolor="#c00000">
 <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td Title="Click on Date to Sort"><b><font color="White">Date</font></b></td>
 <td Title="Click on Attendance by to Sort"><b><font color="White">Attendance By</font></b></td>
 <td align=center Title="Click on Status to Sort"><b><font color="White">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status</font></b></td>
 <td Title="Click on Class Type to Sort"><b><font color="White">Class Type</font></b></td>
  <%
if(mLTP.equals("'L','T'"))
		   {
mLTP="LT";
		   }
		   else if(mLTP.equals("'L'"))
		   {
mLTP="L";
		   }
		    else if(mLTP.equals("'T'"))
		   {
mLTP="T";
		   }
		       else if(mLTP.equals("'P'"))
		   {
		   mLTP="P";
		   }

if(mLTP.equals("LT")  )
    {
     %><td align=center Title=""><b><font color="White">LTP</font></b></td> <%
    }
%>
</tr>
</thead>
<tbody>
<%

 mSNO=0;

qry=" select distinct to_char(CLASSTIMEFROM,'dd-mm-yy hh:mi am')CLASSTIMEFROM  , ATTENDANCETYPE,LTP,  nvl(PRESENT,'N') PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME from V#STUDENTATTENDANCE a where" +
        " SubjectID= '"+MSUBID+"'  and LTP='"+mLTP+"' and EXAMCODE= '"+mEXAMCODE+"'  AND studentid ='"+mSTUDID+"' order by to_date(CLASSTIMEFROM,'dd-mm-rrrr hh:mi am')" ;
rs1=db.getRowset(qry);
		while(rs1.next())
		{
		mSNO++;

		if(rs1.getString("ATTENDANCETYPE").equals("R"))
			mCtype="Regular";
		else
			mCtype="Extra";


			if(rs1.getString("PRESENT").equals("Y"))
			{
				mStatus="Present";
				mColor="Green";
			}
			else
			{
				mStatus="Absent";
				mColor="RED";
			}

			%>
			<tr>
			<td align=center NOWRAP><%=mSNO%>.</td>
			<td align=center NOWRAP><%=rs1.getString("CLASSTIMEFROM")%></td>
			<td align=center NOWRAP><%=rs1.getString("EMPLOYEENAME")%></td>
			<td align=center NOWRAP><font color=<%=mColor%>><B><%=mStatus%></B></font></td>
				<td><%=mCtype%></td>
            <%
            if(mLTP.equals("LT"))
            {

		if(rs1.getString("LTP").equals("Lecture"))
				{
				mColor1="Blue";
				}
				else
				{
					mColor1="Black";
				}
            %>
            <td align=center Title=""><b><font color="<%=mColor1%>"><%=rs1.getString("LTP")%></font></b></td>
            <%
            }
		    %>
            </tr>
			 <%


	}
%>
</tbody>
</TABLE>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","Number"]);
</script>


</tr>
</thead>
<tbody>
<%

 
    
	
		
    }
    catch(Exception e)
    {
      //out.print(e.getMessage());
    }

    }

    else
    {
	%>




	<br>
	<font color=red>
	<h3><br><img src='.../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	</font><br><br><br><br>
	<%
    }
	//-----------------------------
	}
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
	%>

	<center><!-- 
	<table align=center><tr><td align=left>
	<IMG style="WIDTH: 75px; HEIGHT: 50px" src="../../Images/CampusLynx.png">
	<FONT size =4 style="FONT-FAMILY: cursive"><b>CampusLynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
	A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
	<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
	</td></tr></table> -->
	</body>
	</Html>

