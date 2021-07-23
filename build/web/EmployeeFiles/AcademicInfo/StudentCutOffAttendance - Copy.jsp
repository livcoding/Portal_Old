<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Student Cut-Off Attendance ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>


<SCRIPT TYPE="text/javascript">

function AlertMe()
{
dd.twait.value='';
}


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
<body  onload="AlertMe()" aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
	' 
*************************************************************************************************
	' *												
	' * File Name:		StudentCutOffAttendance.jsp		[For DOAA/Admin]					
	' * Author:			Vijay
	' * Date:			1st Feb 09
	' * Version:		1.0								
	' * Description:	Faculty Class Attendance Detail
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",qry2="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String QryAcadYr="", mAcadYr="";
String mInst="", mEmpID="";
String OldEnNo="", OldSubj="", OldLTPVal="";
int Ctr=0, CTR=0;
long QryTotCls=0, QryTotPrs=0 ;
double mCutOffVal=0,QryPercAtt=0;
String mFName="", mFID="", mECode="", mExamFac="", mSubject="";
String QryFaculty="", QryExam="", QryType="", mFaculty="", mFacultyID="", mFacultyName="",mLTP="";
String mexamcode="",mfaculty="", mName="",mDate1="",mDate2="", mEm, mTcount="", mEcount="";
long mTotClass=0,mTotExc=0;
String mProgCode="", QryProgCode="", mSub="",mSec="";
String mEmployeeID="", mAttBy="", mAttDate="";
String mSUBJECTCODE="", mSUBJECTID="", mFSTID="";
String mEName="";
String mClassType="";
String mClasstype="",QrySemType="",mSemType="";
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs2=null;

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1, to_Char((Sysdate-6),'dd-mm-yyyy') date2 from dual";
rs=db.getRowset(qry);
rs.next();
String mCurrDate=rs.getString("date1");
String mPrevDate=rs.getString("date2");

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

if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
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

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}
try 
{  //1
   if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
   {  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('235','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		//out.println(e.getMessage());
	}
	%>
	<form name="frm" method=get >
	<input id="x" name="x" type=hidden>
	<table ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><b>Student Cut-Off Attendance</b><font size=3></font</font></td></tr>
	</table>
	<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
	<tr><td nowrap>
	<font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
	<%
	  qry="Select examcode, examperiodfrom from";
	  qry=qry+" (select nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mInst+"'";
	  qry=qry+" and nvl(EXCLUDEINATTENDANCE,'N')='N' and nvl(deactive,'N')='N' and nvl(LOCKEXAM,'N')='N' order by EXAMPERIODFROM desc)";
	  qry=qry+" where rownum <=8";
	  rs=db.getRowset(qry);
	  //out.print(qry);
	%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 120px">
	<%
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mexamcode=rs.getString("examcode");
			if(QryExam.equals(""))
 			{			
				QryExam=mexamcode;
				%>
				<OPTION Selected Value =<%=mexamcode%>><%=mexamcode%></option>
				<%
			}
			else
			{
				%>
				<option value=<%=mexamcode%>><%=mexamcode%></option>
				<%
			}
		}
	}
	else
	{
		while(rs.next())
		{
		   mexamcode=rs.getString("examcode");			
		   if(mexamcode.equals(request.getParameter("exam").toString().trim()))
		   {	
			QryExam=mexamcode;
			%>
			<option selected value=<%=mexamcode%>><%=mexamcode%></option>
	 		<%
		   }
		   else
		   {
			%>
			<option  value=<%=mexamcode%>><%=mexamcode%></option>
			<%
		   }
		}
	}
	%>
	</select>
	<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; Academic Year</STRONG></font>
	<%
	  qry="Select Distinct AcademicYear from StudentRegistration where institutecode='"+mInst+"' and studentid in (select studentid from studentltpdetail where nvl(DEACTIVE,'N')='N' ) Order By AcademicYear Desc";
	  rs=db.getRowset(qry);
	  //out.print(qry);
	%>
	<select name=ACAD tabindex="0" id="ACAD" style="WIDTH: 120px">
	<%
	try
	{
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mAcadYr=rs.getString("AcademicYear");
			if(QryAcadYr.equals(""))
 			{			
				QryAcadYr=mAcadYr;
				%>
				<OPTION Selected Value =<%=mAcadYr%>><%=mAcadYr%></option>
				<%
			}
			else
			{
				%>
				<option value=<%=mAcadYr%>><%=mAcadYr%></option>
				<%
			}
		}
	}
	else
	{
		while(rs.next())
		{
		   mAcadYr=rs.getString("AcademicYear");			
		   if(mAcadYr.equals(request.getParameter("ACAD").toString().trim()))
		   {	
			QryAcadYr=mAcadYr;
			%>
			<option selected value=<%=mAcadYr%>><%=mAcadYr%></option>
	 		<%
		   }
		   else
		   {
			%>
			<option  value=<%=mAcadYr%>><%=mAcadYr%></option>
			<%
		   }
		}
	}
	}
	catch(Exception e)
	{
	}
	%>
	</select>

	<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; Program Code</STRONG></font>
	<%
	  qry="Select Distinct ProgramCode from StudentRegistration where institutecode='"+mInst+"' and  studentid in (select studentid from studentltpdetail where nvl(DEACTIVE,'N')='N' ) Order By ProgramCode";
	  rs=db.getRowset(qry);
	  //out.print(qry);
	%>
	<select name="PROG" tabindex="0" id="PROG" style="WIDTH: 120px">
	<%
	try
	{
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mProgCode=rs.getString("ProgramCode");
			if(QryProgCode.equals(""))
 			{			
				QryProgCode=mProgCode;
				%>
				<OPTION Selected Value =<%=mProgCode%>><%=mProgCode%></option>
				<%
			}
			else
			{
				%>
				<option value=<%=mProgCode%>><%=mProgCode%></option>
				<%
			}
		}
	}
	else
	{
		while(rs.next())
		{
		   mProgCode=rs.getString("ProgramCode");			
		   if(mProgCode.equals(request.getParameter("PROG").toString().trim()))
		   {	
			QryProgCode=mProgCode;
			%>
			<option selected value=<%=mProgCode%>><%=mProgCode%></option>
	 		<%
		   }
		   else
		   {
			%>
			<option  value=<%=mProgCode%>><%=mProgCode%></option>
			<%
		   }
		}
	}
	}
	catch(Exception e)
	{
	}
	%>
	</select>
	<%
	try
	{
		if(request.getParameter("x")==null)
			mCutOffVal=50;
		else
			mCutOffVal=Double.parseDouble(request.getParameter("CUTOFF").toString().trim());	
	}
	catch (Exception e)
	{
		mCutOffVal=0;
	}
	%>
	</td></tr>
	<tr>
	<TD NOWRAP>
	<FONT color=black face=Arial size=2><b> Semester Type </b></FONT>
<select name=SemType id=SemType>
<%

if(request.getParameter("SemType")==null)
{
	if(QrySemType.equals(""))
		QrySemType=mSemType;
	%>
	
	<option value='REG'>REG</option>
	<option selected value='RWJ'>RWJ-SAP</option>
	<%
}
else
{
	mSemType=request.getParameter("SemType").toString().trim();
	QrySemType=mSemType;
	if(mSemType.equals("ALL"))
	{
		%>
		<!--<option selected value='ALL'>ALL</option>-->
		<option value='REG'>REG</option>
		<option value='RWJ'>RWJ-SAP</option>
 		<%
	}
	else if(mSemType.equals("REG"))
	{
		%>
		<!--<option value='ALL'>ALL</option>-->
		<option selected value='REG'>REG</option>
	   	<option value='RWJ'>RWJ-SAP</option>
 		<%
	}	
	else 
	{
		%>
		<!--<option value='ALL'>ALL</option>-->
		<option value='REG'>REG</option>
	  	<option selected value='RWJ'>RWJ-SAP</option>
		<%
	}
}
%>
</select>
	 &nbsp;&nbsp; &nbsp;
	<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; &nbsp; &nbsp; Cut-Off Value <= </font><input Name=CUTOFF Name=CUTOFF Type=text Value='<%=mCutOffVal%>' maxlength=5 onKeyPress="return numbersonly(this, event);" size=4>&nbsp;  &nbsp; &nbsp;
	<input type="submit" value="View Attendance">
	</td></tr>
	</table>
	</form>


	<%
	if(request.getParameter("x")!=null)
	{
		%>
		
<form name="dd" id="dd">
<center>
<input style="width:210px;font-size:20px; 
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ; background-color:transparent"  name="twait" id="twait" readonly type="text" value="Please Wait.......">
</center>
</form>

<form name="frm1" method=POST action="StudentCutOffAttendanceExcel.jsp">
	
		
		<%


		if(request.getParameter("exam")==null)
			QryExam="";
		else
			QryExam=request.getParameter("exam").toString().trim();	

		
if(request.getParameter("SemType")==null)
				mSemType="";
			else
				mSemType=request.getParameter("SemType").toString().trim();
			

		if(request.getParameter("ACAD")==null)
			QryAcadYr="";
		else
			QryAcadYr=request.getParameter("ACAD").toString().trim();	
		if(request.getParameter("PROG")==null)
			QryProgCode="";
		else
			QryProgCode=request.getParameter("PROG").toString().trim();	
		try
		{
			if(request.getParameter("CUTOFF")==null)
				mCutOffVal=0;
			else
				mCutOffVal=Double.parseDouble(request.getParameter("CUTOFF").toString().trim());	
		}
		catch (Exception e)
		{
			mCutOffVal=0;
		}
		if(mCutOffVal >= 0 && mCutOffVal <=100)
		{
ResultSet rsBatchDate=null,rs11=null,rs1=null;
String mREGCONFIRMATIONDATE="",QryEmpID="",mStudentid="";
long mPresent=0, mL=0, mT=0, mP=0, mLP=0, mTP=0, mPP=0;

								long mPercL=0,mPercT=0,mPercP=0,mPercLT=0;
			qry="select distinct A.Studentid Studentid, A.StudentName StudentName, A.EnrollmentNo EnrollmentNo, A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.SUBJECTCODE SUBJECTCODE, A.SUBJECT SUBJECT, A.LTP LTP, A.SEMESTER SEMESTER, A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE SUBSEC,a.ACADEMICYEAR,NVL(a.SEMESTERTYPE,' ')SEMESTERTYPE From v#studentltpdetail A";
			qry=qry+" where  A.ExamCode='"+QryExam+"' and nvl(A.STUDENTDEACTIVE,'N')='N' and A.ACADEMICYEAR='"+QryAcadYr+"' AND A.PROGRAMCODE='"+QryProgCode+"' AND A.INSTITUTECODE='"+mInst+"' ";
			
			if(mSemType.equals("RWJ"))
									qry=qry+" AND A.SEMESTERTYPE IN ('RWJ', 'SAP') ";
								else
									qry=qry+" AND A.SEMESTERTYPE IN ('REG') ";

			qry=qry+"   order By EnrollmentNo, SUBJECT, LTP, FSTID";
			rs11=db.getRowset(qry);
			//out.print(qry); 
			//and EnrollmentNo='10102210' and  subjectcode='10B11PD411'
			String QryLTPVal="";
			while(rs11.next())
			{
				Ctr++;
				mSubject=rs11.getString("SUBJECTID");
				
				//out.print(mSubject);

				mStudentid=rs11.getString("Studentid");
				QryLTPVal=rs11.getString("LTP");
				if(QryLTPVal.equals("L") || QryLTPVal.equals("T"))
					QryLTPVal="'L','T'";
				else
					QryLTPVal="'P'";

				QrySemType=rs11.getString("SEMESTERTYPE").toString().trim();
				//QryEmpID=rs11.getString("employeeid").toString().trim();



					qry2=" Select distinct nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE  From StudentRegistration Where INSTITUTECODE='"+mInst+"'";
					qry2=qry2+" AND EXAMCODE='"+QryExam+"' ";
					qry2=qry2+" AND SEMESTER='"+rs11.getString("SEMESTER")+"' AND NVL(SEMESTERTYPE,' ')='REG' ";
					qry2=qry2+" AND STUDENTID='"+rs11.getString("STUDENTID")+"' ";					
					qry2=qry2+" AND ACADEMICYEAR='"+rs11.getString("ACADEMICYEAR")+"' ";
//out.print(qry2);
					rsBatchDate=db.getRowset(qry2);
					 if(rsBatchDate.next())
					{
						if(rsBatchDate.getString("REGCONFIRMATIONDATE")==null) 
							mREGCONFIRMATIONDATE="";
						else
							mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
					}
					else
					{
						mREGCONFIRMATIONDATE="";
					}

				//out.print(QryLTPVal);
				if(Ctr==1)
				{
					%>
					<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 border=1>
					<thead>
					<tr bgcolor="#ff8c00">
					 <td nowrap align=left><b><font color="White">SNo.</font></b></td> 
					 <td nowrap align=left><b><font color="White">Student</font></b></td> 
					 <td nowrap align=left><b><font color="White">Subject</font></b></td> 
					 <td nowrap align=center><b><font color="White">LTP</font></b></td> 
					 <td nowrap align=center><b><font color="White">Attendance (%)</font></b></td> 
					</tr>
					</thead>
					<tbody>
					<%
				}



String mLFSTID="";
String mTFSTID="";
String mPFSTID="";
String prevLFSTID="";
String prevTFSTID="";
String prevPFSTID="";
  mMemberID=mStudentid;
String mINSTITUTECODE=mInst;

int QrySem=rs11.getInt("SEMESTER");


qry1="select  LTP,fstid from V#StudentLTPDetail a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' group by LTP,fstid";

 
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		if(rs1.getString("LTP").equals("L"))			
			mLFSTID=rs1.getString("fstid");			
		else if(rs1.getString("LTP").equals("T"))
			mTFSTID=rs1.getString("fstid");	
		else if(rs1.getString("LTP").equals("P"))	
			mPFSTID=rs1.getString("fstid");
		}


qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='L' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  AND  a.LTP='L' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ) ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevLFSTID=rs1.getString("fstid");			
		}

qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='T' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"'and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  AND  a.LTP='T' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ) ";
//out.println(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevTFSTID=rs1.getString("fstid");			
		}

	qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='P' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  AND  a.LTP='P' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ) ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevPFSTID=rs1.getString("fstid");			
		}



	
long mNotAttendedAttendance=0;


// Process for L Type
mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select distinct  CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='L' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mLFSTID+"'   OR (A.FSTID  IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='L' and b.FSTID='"+mLFSTID+"')))  ";  qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) > trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and not exists (select 1 from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and not exists (select 1 from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )   )";
//out.print(qry);
//if(mMemberID.equals("J1281100708"))
//	out.print(qry);
rs1=db.getRowset(qry);
  
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
			
		}

qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSubject+"'  and LTP='L' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevLFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubject+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='L' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevLFSTID+"' ) ";
//if(mMemberID.equals("J1281100708"))
//	out.print(qry);
rs1=db.getRowset(qry);

while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}

 
qry1="SELECT   count(pcount ) pcount FROM (select distinct  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.ltp='L' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select   distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )";       
//if(mMemberID.equals("J1281100708"))
//	out.print(qry1);

 

rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mL=rs1.getLong("pcount");
			
		}
mL=mL+mNotAttendedAttendance;

qry1="SELECT   count(pcount ) pcount FROM (select distinct   CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND   a.ltp='L' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' )";       
//if(mMemberID.equals("J1281100708"))
//	out.print(qry1);;
rs1=db.getRowset(qry1);

while(rs1.next())
		{
		mLP=rs1.getLong("pcount");
			
		}





//-- For T

mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select  distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='T' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mTFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='T' and b.FSTID='"+mTFSTID+"')))  ";                           
qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) > trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";

 qry=qry+" and not exists (select 1 from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
 qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and not exists (select 1 from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )   ) ";
rs1=db.getRowset(qry);

//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
		//out.print("mNotAttendedAttendance  First"+mNotAttendedAttendance);		
		}

 qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSubject+"'  and LTP='T' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevTFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubject+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='T' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevTFSTID+"' )  ";
rs1=db.getRowset(qry);

while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
		}
qry1="SELECT   count(pcount ) pcount FROM (select  distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.ltp='T' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select distinct   CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )";       


rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mT=rs1.getLong("pcount");
		//out.print("MT"+mT);
			
		}
mT=mT+mNotAttendedAttendance;

qry1="SELECT   count(pcount ) pcount FROM (select distinct  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' and a.ltp='T' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' )";       

rs1=db.getRowset(qry1);
  
while(rs1.next())
		{
		mTP=rs1.getLong("pcount");
			
		}






//		For P

mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select distinct  CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='P' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mPFSTID+"'   OR ( A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='P' and b.FSTID='"+mPFSTID+"')))  ";                            
qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) > trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and not exists (select 1 from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='P' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and not exists (select 1 from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='P' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )   )  ";
rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
			
		}

 qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSubject+"'  and LTP='P' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevPFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='P' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubject+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='P' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevPFSTID+"' )  ";
//out.print(qry);
rs1=db.getRowset(qry);

//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}
qry1="SELECT   count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' and a.ltp='P' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' )";       
//out.print(qry1);


rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mP=rs1.getLong("pcount");
			
		}
mP=mP+mNotAttendedAttendance;

qry1="SELECT   count(pcount ) pcount FROM (select  distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  and a.ltp='P' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )" ;       
//out.print(qry1);
rs1=db.getRowset(qry1);

while(rs1.next())
		{
		mPP=rs1.getLong("pcount");
			
		}




if(mL>0)
{
		mPercL=Math.round(((mLP*100)/mL));
		
}
if(mT>0)
{
		mPercT=Math.round((mTP*100)/mT);
		
}

if((mL+mT)>0)
{
mPercLT=Math.round(((mLP+mTP)*100)/(mL+mT));

}
 if(mP>0)
{
		mPercP=Math.round((mPP*100)/mP);
}

mL=0;
mT=0;
mP=0;
mLP=0;
mTP=0;
mPP=0;

				//out.print("<br>"+mCutOffVal+"xxxx"+QryPercAtt+"QryPercAtt::"+QryTotPrs+"QryTotPrs::"+QryTotCls+"QryTotCls::");
				if(mPercLT<=mCutOffVal  &&  mPercP<=mCutOffVal)
				{
					//out.print("SSS"+rs.getString("SUBJECT"));
					%>
					<tr>
					<%
					if(!OldEnNo.equals(rs11.getString("EnrollmentNo")))
					{
						CTR++;
						OldEnNo=rs11.getString("EnrollmentNo");

						%>
						<td align=right><%=CTR%>. &nbsp; &nbsp; &nbsp; </td>
						<td nowrap><%=rs11.getString("StudentName")%> &nbsp; [<%=rs11.getString("EnrollmentNo")%>]</td>
						<td nowrap><%=rs11.getString("SUBJECT")%> &nbsp; [<%=rs11.getString("SUBJECTCODE")%>]</td>
						<%
						if(QryLTPVal.equals("'P'"))
						{
							%>
							<td nowrap align=center>P</td>
							<td nowrap align=center><%=mPercP%></td>
							<%
						}
						else
						{
							%>
							<td nowrap align=center>L and/or T</td>
							<td nowrap align=center><%=mPercLT%></td>
							<%
						}
					}
					else
					{
						if(!OldSubj.equals(mSubject) || !OldLTPVal.equals(QryLTPVal) )
						{
							OldSubj=rs11.getString("SUBJECTID");
							OldLTPVal=QryLTPVal;

						
							%>
							<td align=right><FONT Color=white><%=CTR%>. &nbsp; &nbsp; &nbsp; </FONT></td>
							<td nowrap><FONT Color=white><%=rs11.getString("StudentName")%> &nbsp; [<%=rs11.getString("EnrollmentNo")%>]</FONT></td>
							<td nowrap><%=rs11.getString("SUBJECT")%> &nbsp; [<%=rs11.getString("SUBJECTCODE")%>]</td>
							<%
							if(QryLTPVal.equals("'P'"))
							{
								%>
								<td nowrap align=center>P</td>
								<td nowrap align=center><%=mPercP%></td>
								<%
							}
							else
							{
								%>
								<td nowrap align=center>L and/or T</td>
								<td nowrap align=center><%=mPercLT%></td>
								<%
							}
						}
					}
					%>
					</tr>	
					<%
				}
			}
		}
		else
		{
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Cut-Off Value must be between '0' and '100' !</font> <br>");
		}
	}	
	%>
	</tbody>
	</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","Number"]);
	</script>
	<%
	if(Ctr>0)
	{
		%>
		<table align=center bgcolor=white width=90% cellmargin=0 bottommargin=0 border=1>
		<tr>
		<td align=middle><font color=blue face=arial size=3><b>Total Student(s) - <%=CTR%></b></font></td>
		</tr>
		</table>
		<%
	}
%>

<input id="SemType" type=hidden name="SemType" value="<%=mSemType%>">
<input id="exam" type=hidden name="exam" value="<%=QryExam%>">
<input id="ACAD" type=hidden name="ACAD" value="<%=QryAcadYr%>">
<input id="PROG" type=hidden name="PROG" value="<%=QryProgCode%>">
<input id="CUTOFF" type=hidden name="CUTOFF" value="<%=mCutOffVal%>">


	<table bgcolor=#fce9c5 class="sort-table" id="table-1"  bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
					<tr><td align=center colspan=7>
					<font color=blue><a onClick="window.print();">
					<img src="../../../Images/printer.gif"  style="cursor:hand"><b>Click to Print</b></a>
				
					&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT Type="submit" Value="Save In Excel">
							</td>	
					</tr>
					</table>
					<%
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
		<P>	This page is not authorized/available to you.
		<br>For assistance, contact your network support team. 
		</font>	<br>	<br>	<br>	<br> 
	   <%
	}
    		 //-----------------------------
   }   //2
   else
   {
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
   }
}	//1	
catch(Exception e)
{
}
%>
</form>
</body>
</html>