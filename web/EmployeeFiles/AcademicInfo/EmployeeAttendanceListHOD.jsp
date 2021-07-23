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
<TITLE>#### <%=mHead%> [View Facultywise Dept. Class Attendance] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(exam,DataComboFac,Faculty)
{
	removeAllOptions(Faculty);
	mflag=0;
	var optn1 = document.createElement("OPTION");
	optn1.text='ALL';
	optn1.value='ALL';
	Faculty.options.add(optn1);
	ssec='ALL';
	for(i=0;i<DataComboFac.options.length;i++)
	{
		var v1;
		var pos;
		var exams;
		var len;
		var facul;
		var v1=DataComboFac.options(i).value;
		len= v1.length ;
		pos=v1.indexOf('///');
		facul=v1.substring(0,pos);
		exams=v1.substring(pos+3,len);
		if (exams==exam)
		 { 	
			var optn1 = document.createElement("OPTION");
			optn1.text=DataComboFac.options(i).text;
			optn1.value=facul;
			Faculty.options.add(optn1);
		}
	}	
}
function removeAllOptions(selectbox)
{
	var i;
	for(i=selectbox.options.length-1;i>=0;i--)
	{
	selectbox.remove(i);
	}
}
</SCRIPT>	
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
	' 
*************************************************************************************************
	' *												
	' * File Name	:	EmployeeAttendanceList.JSP		[For DOAA/Admin]					
	' * Author		:	Vijay
	' * Date		:	1st Feb 07								
	' * Version		:	1.0								
	' * Description	:	Faculty Class Attendance Detail
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",qry2="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="", mEmpID="";
int msno=0;
String mFName="", mFID="", mECode="", mExamFac="";
String QryFaculty="", QryExam="", QryType="", mFaculty="", mFacultyID="", mFacultyName="",mLTP="";
String mexamcode="",mfaculty="", mName="",mDate1="",mDate2="", mEm, mTcount="", mEcount="";
long mTotClass=0,mTotExc=0;
String mINSTITUTECODE="", mProg="", mSub="",mSec="";
String mEmployeeID="", mAttBy="", mAttDate="";
String mSUBJECTCODE="",mSUBJECTID="";
String mEName="";
String mClassType="";
String mClasstype="";
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null;

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
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
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
	qry="Select WEBKIOSK.ShowLink('84','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Self Department's Faculty Class Attendance</b><font size=3></font</font></td></tr>
</table>
<table width=100%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td nowrap><font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
<%
  qry="Select examcode, examperiodfrom from";
  qry=qry+" (select nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mINSTITUTECODE+"'";
  qry=qry+" and nvl(EXCLUDEINATTENDANCE,'N')='N' and nvl(deactive,'N')='N' and nvl(LOCKEXAM,'N')='N' order by EXAMPERIODFROM desc)";
  qry=qry+" where rownum <=8";
  rs=db.getRowset(qry);
//out.print(qry);
%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 120px" onChange= "return ChangeOptions(exam.value,DataComboFac,Faculty);" onClick="return ChangeOptions(exam.value,DataComboFac,Faculty);">
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
</td>
<td nowrap><font color=black face=arial size=2><STRONG>Faculty&nbsp;</STRONG>
<%
qry="select distinct nvl(entrybyfacultyid,' ')Faculty, nvl(ENTRYBYFACULTYNAME,' ')FacultyName from v#studentattendance where ";
qry=qry +" entrybyfacultyid in (select Employeeid from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
qry=qry +" hodlist where employeeid='"+mChkMemID+"' and nvl(deactive,'N')='N')) and ExamCode='"+QryExam+"' and nvl(deactive,'N')='N'  order by FacultyName ";
//out.print(qry);
  rs=db.getRowset(qry);
	%>
	<select name="Faculty" tabindex="0" id="Faculty" style="WIDTH: 230px" >
	<%   	
	if(request.getParameter("x")==null)
	{	
			QryFaculty="ALL";
		%>	
			<OPTION selected value=ALL>ALL</option>
		<%
		while(rs.next())
		{
		 	mFaculty=rs.getString("Faculty");
		 	mFacultyName=rs.getString("FacultyName");
			%>
				<option value=<%=mFaculty%>><%=mFacultyName%></option>
			<%
			
		}
	}
	else
	{
		if (request.getParameter("Faculty").toString().trim().equals("ALL"))
 		{
			QryFaculty="ALL";
		%>
	 		<OPTION selected value=ALL>ALL</option>
		<%
		}
		else
		{
		%>
			<OPTION value=ALL>ALL</option>
		<%
		}
	  while(rs.next())
	  {
	   	mFaculty=rs.getString("Faculty");
	   	mFacultyName=rs.getString("FacultyName");
	   	if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
			{
		   QryFaculty=mFaculty;
				%>
	    		<option selected value=<%=mFaculty%>><%=mFacultyName%></option>
		  	<%
		  }	
	    else
      {		
	   		%>
	    		<option  value=<%=mFaculty%>><%=mFacultyName%></option>
	   		<%
	    }	
	  }
  }
%>
</select>
<!--********DataComboFac***********-->
<%
try
{ 
	qry="select Distinct nvl(ENTRYBYFACULTYID,' ') EMPLOYEEID, nvl(examcode,' ') examcode, ";
	qry=qry+" nvl(ENTRYBYFACULTYNAME,' ') EMPLOYEENAME,nvl(ENTRYBYFACULTYCODE,' ')EMPLOYEECODE from V#Studentattendance ";
	qry=qry+" where entrybyfacultyid in (select Employeeid from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry+" hodlist where employeeid='"+mChkMemID+"' and nvl(deactive,'N')='N')) and ExamCode='"+QryExam+"'";
	qry=qry+" and nvl(deactive,'N')='N' order by examcode, EMPLOYEENAME, EMPLOYEECODE ";
//out.print(qry);
	rs=db.getRowset(qry);
	if (request.getParameter("DataComboFac")==null)
	{
		%>
		<select name='DataComboFac' tabindex="0" id="DataComboFac" style="WIDTH: 0px">	
		<%   
		while(rs.next())
		{
			mFID=rs.getString("EMPLOYEEID");
			mECode=rs.getString("examcode");
			mExamFac=mFID+"///"+mECode;
			mFName=rs.getString("EMPLOYEENAME");
			if(mExamFac.equals(""))
 			%>
			<OPTION Value =<%=mExamFac%>><%=mFName%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<select name='DataComboFac' tabindex="0" id="DataComboFac" style="WIDTH: 0px">	
		<%
		  while(rs.next())
		{
			mFID=rs.getString("EMPLOYEEID");
			mECode=rs.getString("examcode");
			mExamFac=mFID+"///"+mECode;
			mFName=rs.getString("EMPLOYEENAME");

			if(mExamFac.equals(request.getParameter("DataComboFac").toString().trim()))
 			{
				mfaculty=mFID;
				%>
				<OPTION selected Value =<%=mExamFac%>><%=mFName%></option>
				<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mExamFac%>><%=mFName%></option>
		      	<%			
		   	}
		}
		%>
		</select></td>
	  	<%
	 }
 }    
catch(Exception e)
{
	// out.println("aaaaaaaaaaaaaaaaa");
}
%>

<td nowrap colspan=2><font color=black face=arial size=2><STRONG>Class Type</STRONG></font>
<%
  qry="select distinct nvl(attendancetype,'R')attendancetype from studentattendance where nvl(deactive,'N')='N' order by attendancetype";
  rs=db.getRowset(qry);
//out.print(qry);
	%>
	<select name="ClassType" tabindex="0" id="ClassType" style="WIDTH: 80px">	
	<%   	
      if(request.getParameter("x")==null)
	{	
			QryType="ALL";
		%>	
			<OPTION selected value=ALL>ALL</option>
		<%
		while(rs.next())
		{
		 	mClasstype=rs.getString("attendancetype");
			if(mClasstype.equals("R"))
				mClassType="Regular";
			else
				mClassType="Extra";
			%>
				<option value=<%=mClasstype%>><%=mClassType%></option>
			<%
			
		}
	}
	else
	{
		if (request.getParameter("ClassType").toString().trim().equals("ALL"))
 		{
			QryType="ALL";
		%>
	 		<OPTION selected value=ALL>ALL</option>
		<%
		}
		else
		{
		%>
			<OPTION value=ALL>ALL</option>
		<%
		}
	  while(rs.next())
	  {
	   	mClasstype=rs.getString("attendancetype");			
	   	if(mClasstype.equals(request.getParameter("ClassType").toString().trim()))
	    {
		   QryType=mClasstype;
	    	if(mClasstype.equals("R"))
					mClassType="Regular";
		   	else
					mClassType="Extra";
			%>
	    	<option selected value=<%=mClasstype%>><%=mClassType%></option>
		  <%
		  }	
	    else
      {		
      	if(mClasstype.equals("R"))
					mClassType="Regular";
				else
					mClassType="Extra";
	   	%>
	    <option  value=<%=mClasstype%>><%=mClassType%></option>
	   	<%
	    }	
	  }
  }
%>
</select></td></tr>
<%
if (request.getParameter("x")!=null)
{
		mDate1=request.getParameter("TXT1").toString().trim();
		mDate2=request.getParameter("TXT2").toString().trim();
}
else
{
mDate1=mPrevDate;
mDate2=mCurrDate;
}
%>
<tr><td nowrap colspan=3><font color=black face=arial size=2><STRONG>Date/Period From</font><font face=arialblack size=2 color=Green>&nbsp;&nbsp;(DD-MM-YYYY)&nbsp;</font></STRONG></font>&nbsp;<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> <font color=black face=arial size=2><STRONG>To</STRONG></font> <input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10>
	<input type="submit" value="View Attendance"></td></tr>
</table>
<table><tr><td nowrap align=center><font size=2 color=red face=arialblack>&nbsp;Hint: </font><font face=arialblack size=2 color=Green>In case of <b>Dates</b> remain blank, the whole attendance will be displayed</font></td></tr></table>
</form>
<%
if(request.getParameter("x")!=null)
{
	if(request.getParameter("exam")==null)
	{
		QryExam="";
	}
	else
	{
		QryExam=request.getParameter("exam").toString().trim();	
	}
	if(request.getParameter("ClassType")==null)
	{
		QryType="";
	}
	else
	{
		QryType=request.getParameter("ClassType").toString().trim();
	}
	if(request.getParameter("Faculty")==null)
	{
		QryFaculty="";
	}
	else
	{
		QryFaculty=request.getParameter("Faculty").toString().trim();
	}
	if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
		mDate1="";
	else
		mDate1=request.getParameter("TXT1").toString().trim();

	if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals(""))
		mDate2="";
	else
		mDate2=request.getParameter("TXT2").toString().trim();
}
if((!mDate1.equals("") && gb.iSValidDate(mDate1)==true ||mDate1.equals("")) && (!mDate2.equals("") && gb.iSValidDate(mDate2)==true ||mDate2.equals("")))
{
%>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1>
<thead>
<tr bgcolor="#ff8c00">
 <td nowrap align=center Title="Click on Faculty to Sort"><b><font color="White">Attendance By</font></b></td> 
 <td Title="Click on Subject to Sort"><b><font color="White">Subject</font></b></td>
 <td align=center Title="Click on LTP to Sort"><b><font color="White">LTP</font></b></td>
 <td align=center Title="Click on Program to Sort"><b><font color="White">Program</font></b></td>
 <td align=center Title="Click on Group to Sort"><b><font color="White">Group</font></b></td>
 <td nowrap align=left Title="Click on Total Classes to Sort"><b><font color="White">Total Classes</font></b></td>
 <td nowrap align=left Title="Click on Total Excuses to Sort"><b><font color="White">Total Excuses</font></b></td>
</tr>
</thead>
<tbody>
<%
	qry="select distinct nvl(ENTRYBYFACULTYID,' ')EmpID, nvl(ENTRYBYFACULTYNAME,' ')AttendanceBy, nvl(SUBJECT,' ')Subject, ";
	qry=qry+" NVL(SUBJECTID,' ')SUBJECTID, NVL(SUBJECTCODE,' ')SUBJECTCODE, nvl(LTP,' ')LTP, decode(LTP,'L',1,'T',2,3)LTPNO, nvl(Programcode,' ')PCode, nvl(SECTIONBRANCH,' ')Sec, nvl(SUBSECTIONCODE,' ')Sub FROM V#STUDENTATTENDANCE ";
	qry=qry+" WHERE EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
	qry=qry+" and ENTRYBYFACULTYID=Decode('"+QryFaculty+ "','ALL',ENTRYBYFACULTYID,'"+QryFaculty+"') and INSTITUTECODE='"+mINSTITUTECODE+"'";
	qry=qry+" and trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) and nvl(DEACTIVE,'N')='N'";
	qry=qry+" and EMPLOYEEID in (select Employeeid from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry+" hodlist where employeeid='"+mChkMemID+"' and nvl(deactive,'N')='N')) Order By AttendanceBy, Subject, LTPNO, PCode, Sec, Sub";
	rs=db.getRowset(qry);
//out.print(qry);
	msno=0;
	while(rs.next())
	{
		msno++ ;
		mAttBy=rs.getString("EmpID");
		mSUBJECTID=rs.getString("SUBJECTID");
		mSUBJECTCODE=rs.getString("SUBJECTCODE");
		mLTP=rs.getString("LTP");
		mEmpID=rs.getString("EmpID");
		mProg=rs.getString("PCode");
		mSec=rs.getString("Sec");
		mSub=rs.getString("Sub");
		
	%>
	<tr>
		<td nowrap><%=rs.getString("AttendanceBy")%></td>
		<td nowrap><%=rs.getString("SUBJECT")%>(<%=mSUBJECTCODE%>)</td>
		<td align=Left>&nbsp;&nbsp;&nbsp;&nbsp;<%=mLTP%></td>	
		<td>&nbsp;&nbsp;&nbsp;&nbsp;<%=rs.getString("PCode")%></td>
		<td nowrap><%=rs.getString("Sec")%>-<%=rs.getString("Sub")%></td>
	<%
	qry1="select distinct nvl(ENTRYBYFACULTYID,' ')EmpID, nvl(ENTRYBYFACULTYNAME,' ')AttendanceBy, nvl(SUBJECT,' ')Subject, ";
	qry1=qry1+" NVL(SUBJECTID,' ')SUBJECTID, NVL(SUBJECTCODE,' ')SUBJECTCODE, nvl(LTP,' ')LTP, decode(LTP,'L',1,'T',2,3)LTPNO, nvl(Programcode,' ')PCode, nvl(SECTIONBRANCH,' ')Sec, nvl(SUBSECTIONCODE,' ')Sub, count(distinct classtimefrom)Tcount FROM V#STUDENTATTENDANCE ";
	qry1=qry1+" WHERE ENTRYBYFACULTYID='"+mAttBy+"' and SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and Programcode='"+mProg+"' and SECTIONBRANCH='"+mSec+"' and SUBSECTIONCODE='"+mSub+"'";
	qry1=qry1+" and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
	qry1=qry1+" and ENTRYBYFACULTYID=Decode('"+QryFaculty+ "','ALL',ENTRYBYFACULTYID,'"+QryFaculty+"') and INSTITUTECODE='"+mINSTITUTECODE+"'";
	qry1=qry1+" and trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) and nvl(DEACTIVE,'N')='N'";
	qry1=qry1+" Group By ENTRYBYFACULTYID, ENTRYBYFACULTYNAME, SUBJECT, SUBJECTID, SUBJECTCODE, LTP, Programcode, SECTIONBRANCH, SUBSECTIONCODE Order By AttendanceBy, Subject, LTPNO";
	rs1=db.getRowset(qry1);
//out.print(qry1);
	while(rs1.next())
	{
		mTotClass=rs1.getLong("Tcount");
	}
%>
		<td align=center><a Title="View Date wise Attendance History" target=_New href='ViewDatewiseStudAttendanceHOD.jsp?EXAM=<%=QryExam%>&amp;FAC=<%=mEmpID%>&amp;TYPE=<%=QryType%>&amp;SID=<%=mSUBJECTID%>&amp;SC=<%=mSUBJECTCODE%>&amp;LTP=<%=mLTP%>&amp;PROG=<%=mProg%>&amp;SEC=<%=mSec%>&amp;SUB=<%=mSub%>&amp;AttDate=<%=mAttDate%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>&amp;TotClass=<%=mTotClass%>'><%=mTotClass%></a></td>
	<%
	qry1="select count(REMARKS)Ecount from STUDENTATTENDANCEEXCUSED where trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) and";
	qry1=qry1+" ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"') and ENTRYBYFACULTYID=Decode('"+QryFaculty+ "','ALL',ENTRYBYFACULTYID,'"+QryFaculty+"') and nvl(DEACTIVE,'N')='N'";
	qry1=qry1+" and FSTID In(select FSTID from V#STUDENTATTENDANCE where trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) and";
	qry1=qry1+" ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"') and ENTRYBYFACULTYID=Decode('"+QryFaculty+ "','ALL',ENTRYBYFACULTYID,'"+QryFaculty+"') and nvl(DEACTIVE,'N')='N'";
	qry1=qry1+" and PROGRAMCODE='"+mProg+"' and SECTIONBRANCH='"+mSec+"' and SUBSECTIONCODE='"+mSub+"' and SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"')";
	rs1=db.getRowset(qry1);
//out.print(qry1);
	while(rs1.next())
	{
		mTotExc=rs1.getLong("Ecount");
	}
	%>
		<td align=center><a Title="View Date wise Excused Attendance History" target=_New href='ViewDatewiseStudAttendanceExcuseHOD.jsp?EXAM=<%=QryExam%>&amp;FAC=<%=mEmpID%>&amp;TYPE=<%=QryType%>&amp;SID=<%=mSUBJECTID%>&amp;SC=<%=mSUBJECTCODE%>&amp;LTP=<%=mLTP%>&amp;PROG=<%=mProg%>&amp;SEC=<%=mSec%>&amp;SUB=<%=mSub%>&amp;AttDate=<%=mAttDate%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>&amp;TotClass=<%=mTotClass%>'><%=mTotExc%></a></td>
	</tr>	
	<%
}
mTotClass=0;
mTotExc=0;
%>
</tbody>
</table>		
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","Number","Number"]);
</script>
<%

	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Please Enter Valid Date!</font> <br>");
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
</body>
</html>