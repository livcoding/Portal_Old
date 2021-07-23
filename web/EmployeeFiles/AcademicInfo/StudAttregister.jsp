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
ResultSet rs=null, EmployeeRecordSet=null,rsImage=null,rs2=null;
String SName="",CAddress1 ="", CAddress2="",CAddress3="", CDistrict="",CPin="",CCity="",CState="";
String PAddress1 ="", PAddress2="",PAddress3="", PDistrict="", PPin="",qry1="", PCity="",PState="",EnrollmentNo="",FatherName="",HusbandName="", MotherName="";
String DOB="",DOJ="",Grade="", Dept="", Desig="", Category="",AccountNo="", BankName="",PFNO="", PANNO="",PassportNo="";
String pPhone ="",cPhone ="",pCell="" ,pEmail="",PassportValidUpto ="", PassportIssueFrom="",pIssueDate="";
String mMemberID="",mMemberType="",mMemberCode="";


String mSubj="", mSubjID="", mCtype="", mProg="",mSec="",mSub="";
String mExam="", mFaculty="",  mDate1="", mDate2="";
String  mTotal="";
String mAttendanceDate="", mClassFrom="", mClassUpto="",mInst="",qry2="",moldDate="";
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
<TITLE>####<%=mHead%>[Student Attendance Register]</TITLE>
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
<TD ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial">Student Attendance Register</TD>
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


<table id=id2 cellpadding=1 cellspacing=1 width="70%" align=center rules=rows border=2 align="center">

<!--Institute****-->

<tr ALIGN="center"><td nowrap colspan=2>
<FONT color=black face=Arial size=2><b>&nbsp; Date From</b></FONT>&nbsp;&nbsp;<INPUT TYPE="text" NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE='<%=mDateFrom%>' readonly
	><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
	<b>&nbsp;to&nbsp;</b>&nbsp;<INPUT TYPE="text" NAME=DATE2 ID=DATE2 size=9 tabindex=2
	VALUE='<%=mDateTo%>' readonly><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit"  VALUE="View Attendance"></TD> </tr></table>

</form>
<%

if (request.getParameter("x")!=null) 
	{
//out.print("aajaj");
if(request.getParameter("DATE1")==null)
		mDateFrom="";
	else
		mDateFrom=request.getParameter("DATE1").toString().trim();
	
	if(request.getParameter("DATE2")==null)
		mDateTo="";
	else
		mDateTo=request.getParameter("DATE2").toString().trim();

mFaculty=mChkMemID;


  


%>

 <TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="50%" border=1 >
<thead>
<tr bgcolor="#ff8c00">
 <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td nowrap Title="Click on Date to Sort"><b><font color="White">Attendance Date & Time</font></b></td>
 <td nowrap Title="Click on Attendance by to Sort"><b><font color="White">Student Present (%)</font></b></td> 
 <td nowrap Title="Click on Class Type to Sort"><b><font color="White">Class Type</font></b></td> 
</tr>
</thead>
<tbody>
<%
	//mSTUDID="",mFSTID="",mATTTYPE="",mEXAMCODE="",mLTP="",mBRANCH="",mSUBSEC="",mAcademicYear=""; 
/*qry = "SELECT studentid,ENROLLMENTNO,Studentname, present, classtimefrom,       TO_CHAR (attendancedate, 'DD-MM-YYYY') attendancedate  FROM v#studentattendance WHERE   attendancetype='"+mATTTYPE+"' and trunc(ATTENDANCEDATE)  between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) AND ACADEMICYEAR = DECODE ('"+mqryacademicyear+"', 'ALL', ACADEMICYEAR, '"+mqryacademicyear+"')  AND LTP = DECODE ('"+mLTP+"', 'ALL', LTP, '"+mLTP+"')  AND SECTIONBRANCH = DECODE ('"+mBRANCH+"', 'ALL', SECTIONBRANCH, '"+mBRANCH+"')  AND SUBSECTIONCODE = DECODE ('"+mSUBSEC+"', 'ALL', SUBSECTIONCODE, '"+mSUBSEC+"')  AND EXAMCODE = DECODE ('"+mEXAMCODE+"', 'ALL', EXAMCODE, '"+mEXAMCODE+"')  AND SUBJECTID = DECODE ('"+MSUBID+"', 'ALL', SUBJECTID, '"+MSUBID+"')  order by   Studentname ";*/

qry="select distinct nvl(FSTID,' ')FSTID, to_char(classtimefrom,'DD-MM-YYYY HH:MI PM')ADate, to_char(classtimefrom,'HH:MI PM')Classf, to_char(classtimeupto,'HH:MI PM')Classt, nvl(ATTENDANCETYPE,' ')CType, nvl(Programcode,' ')Prog, nvl(Sectionbranch,' ')Sec, nvl(Subsectioncode,' ')Sub,to_char(ATTENDANCEDATE,'YYYYmmdd')AADate from V#STUDENTATTENDANCE ";
	qry=qry+" where  INSTITUTECODE='"+mInst+"'"; 
//	qry=qry+" and ATTENDANCETYPE=Decode('"+mATTTYPE + "','ALL',ATTENDANCETYPE,'"+ mATTTYPE +"')";
if(mSUBSEC.equals("ALL")  )
	{
		qry=qry+" and subsectioncode=decode('"+mSUBSEC+"','ALL',subsectioncode,'"+mSUBSEC+"')";
	}
	else
	{
		qry=qry+" and subsectioncode in ("+mSUBSEC+")";
	}

	qry=qry+"  and ACADEMICYEAR = DECODE ('"+mqryacademicyear+"', 'ALL', ACADEMICYEAR, '"+mqryacademicyear+"')  AND LTP = DECODE ('"+mLTP+"', 'ALL', LTP, '"+mLTP+"')  AND SECTIONBRANCH = DECODE ('"+mBRANCH+"', 'ALL', SECTIONBRANCH, '"+mBRANCH+"')    AND EXAMCODE = DECODE ('"+mEXAMCODE+"', 'ALL', EXAMCODE, '"+mEXAMCODE+"')  AND SUBJECTID = DECODE ('"+MSUBID+"', 'ALL', SUBJECTID, '"+MSUBID+"')  and ENTRYBYFACULTYID='"+mFaculty+"' ";
	qry=qry+" and trunc(ATTENDANCEDATE)  between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) ";
	qry=qry+" order by AADate DESC";

//out.print(qry);
rs = db.getRowset(qry);
while (rs.next())
      {
		
     	mFSTID=rs.getString("FSTID");
		mAttendanceDate=rs.getString("ADate");
		mClassFrom=rs.getString("Classf");
		mClassUpto=rs.getString("Classt");
		if(rs.getString("CType").equals("R"))
			mCtype="Regular";
		else
			mCtype="Extra";
		qry2="select to_char(ATTENDANCEDATE,'DD-MM-YYYY')ADate, to_char(classtimefrom,'HH:MI PM')Classf, to_char(classtimeupto,'HH:MI PM')Classt, nvl(ATTENDANCETYPE,' ')CType, nvl(Programcode,' ')Prog, nvl(Sectionbranch,' ')Sec, nvl(Subsectioncode,' ')Sub, count(STUDENTID)TotStrength,nvl(NULL,'None') Remarks from V#STUDENTATTENDANCE ";
		qry2=qry2+" where EXAMCODE='"+mEXAMCODE+"' And INSTITUTECODE='"+mInst+"'";
//		qry2=qry2+" and ATTENDANCETYPE=Decode('"+mATTTYPE + "','ALL',ATTENDANCETYPE,'"+ mATTTYPE +"')";
		qry2=qry2+" and SUBJECTID='"+MSUBID+"' and LTP='"+mLTP+"'";
		qry2=qry2+" and ENTRYBYFACULTYID='"+mFaculty+"' and nvl(DEACTIVE,'N')='N'";
		qry2=qry2+" and Sectionbranch='"+rs.getString("Sec")+"' and Subsectioncode='"+rs.getString("Sub")+"' ";
		qry2=qry2+" and to_char(ClassTimeFrom,'dd-mm-yyyy hh:mi PM')='"+mAttendanceDate+"' and to_char(ClassTimeUpto,'hh:mi PM')='"+mClassUpto+"'";
		qry2=qry2+" Group By ATTENDANCEDATE, classtimefrom, classtimeupto, ATTENDANCETYPE, Programcode, Sectionbranch, Subsectioncode";
		rs2=db.getRowset(qry2);
	//	out.print(qry2);
		if(rs2.next())
		{
			mTotalStrength=rs2.getDouble("TotStrength");
		}
		qry2="select to_char(ATTENDANCEDATE,'DD-MM-YYYY')ADate, to_char(classtimefrom,'HH:MI PM')Classf, to_char(classtimeupto,'HH:MI PM')Classt, nvl(ATTENDANCETYPE,' ')CType, nvl(Programcode,' ')Prog, nvl(Sectionbranch,' ')Sec, nvl(Subsectioncode,' ')Sub, count(STUDENTID)TotPresent,nvl(NULL,'None') Remarks from V#STUDENTATTENDANCE ";
		qry2=qry2+" where EXAMCODE='"+mEXAMCODE+"' and nvl(PRESENT,'N')='Y' And INSTITUTECODE='"+mInst+"'";
//		qry2=qry2+" and ATTENDANCETYPE=Decode('"+mATTTYPE + "','ALL',ATTENDANCETYPE,'"+ mATTTYPE +"')";
		qry2=qry2+" and SUBJECTID='"+MSUBID+"' and LTP='"+mLTP+"'";
		qry2=qry2+" and ENTRYBYFACULTYID='"+mFaculty+"' and nvl(DEACTIVE,'N')='N'";
		qry2=qry2+"  and  Sectionbranch='"+rs.getString("Sec")+"' and Subsectioncode='"+rs.getString("Sub")+"' ";
		qry2=qry2+" and to_char(ClassTimeFrom,'dd-mm-yyyy hh:mi PM')='"+mAttendanceDate+"' and to_char(ClassTimeUpto,'hh:mi PM')='"+mClassUpto+"'";
		qry2=qry2+" Group By ATTENDANCEDATE, classtimefrom, classtimeupto, ATTENDANCETYPE, Programcode, Sectionbranch, Subsectioncode";
		rs2=db.getRowset(qry2);
		//out.print(qry2);
		if(rs2.next())
		{
			mTotalPresent=rs2.getDouble("TotPresent");
			mPerc=((mTotalPresent*100)/mTotalStrength);
		}
		if(!moldDate.equals(mAttendanceDate))
		{
          		mSNO++;
			moldDate=mAttendanceDate;
			%>
			<tr>
			<td><%=mSNO%>.</td>
			<td nowrap><%=rs.getString("ADate")%>-<%=rs.getString("Classt")%></td>
			<%
			if(mPerc<50)
			{
				%>
			
			<td align=center><font color='RED' face=arial><a href="StudAttregisterDetail.jsp?RightsID=<%=mRightsID%>&amp;EXAM=<%=mEXAMCODE%>&amp;FAC=<%=mFaculty%>&amp;TYPE=<%=rs.getString("CType")%>&amp;SID=<%=MSUBID%>&amp;SC=<%=mSubj%>&amp;LTP=<%=mLTP%>&amp;SEC=<%=rs.getString("Sec")%>&amp;SUB=<%=rs.getString("Sub")%>&amp;AttDate=<%=rs.getString("ADate")%>&amp;ClassFr=<%=rs.getString("Classf")%>&amp;ClassTo=<%=rs.getString("Classt")%>&amp;Date1=<%=mDateFrom%>&amp;Date2=<%=mDateTo%>&amp;TotClass=<%=mTotal%>" target="NEW" title="Click To view Complete Attendance"><font color='blue' size=2  face=arial><%=gb.getRound(mPerc,2)%></a></font></td>
				
				<%
			}
			else
			{
				%>
				<td align=center><font color='BLACK' face=arial><a href="StudAttregisterDetail.jsp?RightsID=<%=mRightsID%>&amp;EXAM=<%=mEXAMCODE%>&amp;FAC=<%=mFaculty%>&amp;TYPE=<%=rs.getString("CType")%>&amp;SID=<%=MSUBID%>&amp;SC=<%=mSubj%>&amp;LTP=<%=mLTP%>&amp;SEC=<%=rs.getString("Sec")%>&amp;SUB=<%=rs.getString("Sub")%>&amp;AttDate=<%=rs.getString("ADate")%>&amp;ClassFr=<%=rs.getString("Classf")%>&amp;ClassTo=<%=rs.getString("Classt")%>&amp;Date1=<%=mDateFrom%>&amp;Date2=<%=mDateTo%>&amp;TotClass=<%=mTotal%>"  target="NEW" title="Click To view Complete Attendance"><font color='blue' size=2 face=arial><%=gb.getRound(mPerc,2)%></a></font></td>
				<%
			}
			%>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;<%=mCtype%></td>
			</tr>
			<%
		}
	}
	mTotalPresent=0;
	mTotalStrength=0;
	mPerc=0;
	%>
	</tbody>
	</TABLE>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
	</script>


	<table align=center bgcolor=white  cellmargin=0 bottommargin=0 border=1>
    <tr ALIGN=CENTER><td  colspan="4"><input type="button" value=" Print this page "
           onclick="window.print();return false;" /></td></TABLE>
    <%
	}

		
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

