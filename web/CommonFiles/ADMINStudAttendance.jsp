<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="",mSID="";
String QryAcad="",QryProgramCode="",mSpecialApproval="",mREGCONFIRMATIONDATE1=""; int QrySem=0;
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Class Attendance ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
	' 
*************************************************************************************************
	' *												
	' * File Name		:		ADMINStudAttendance.JSP	[For Students]
	' * Author			:		Vijay Kumar
	' * Date			:		14th Feb 2007
	' * Version			:		1.0
	' * Description		:		Batch cum Subject wise Student's Class Attendance
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry1="",qry="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="",qrtyyy="",mREGCONFIRMATIONDATERG="";
String mInst="";
int msno=0;
String mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mSem="",mName="";
String mINSTITUTECODE="";
String mEmployeeID="";
String mSUBJECTCODE="";
String mEName="";
String mClasstype="", mClassType="", QryFaculty="", QryExam="", QryType="";
long mPresent=0, mL=0, mT=0, mP=0, mLP=0, mTP=0, mPP=0;
long mPercL=0,mPercT=0,mPercP=0;
long mPercLT=0;
ResultSet rs=null,rs1=null,rsyyyy=null;

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
if (request.getParameter("INSCODE")==null)
{
	mINSTITUTECODE ="";
}
else
{
	mINSTITUTECODE =request.getParameter("INSCODE").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
}
if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}

if (request.getParameter("SID")==null)
{
	mSID="";
}
else
{
	mSID=request.getParameter("SID").toString().trim();
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
	qry="Select WEBKIOSK.ShowLink('87','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
		out.println(e.getMessage());
	}
	
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana">Student Class Attendance</font>
</td>
<td align=right><font color=brown face=verdana size=2><b>Login User :&nbsp; &nbsp;</b><%=mName%><b>[Emp. Code: </b><%=mDMemberCode%>]</font></td>
</tr>
</table>
<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<input id="INSCODE" name="INSCODE" value="<%=mINSTITUTECODE%>" type="hidden">
<input type=hidden value=<%=mSID%> id=SID Name=SID>
<table width=100%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Student Name&nbsp;:&nbsp;</STRONG></font><%=GlobalFunctions.getUserName(mSID,"S")%>
<%
	qry="Select nvl(ACADEMICYEAR,' ') ACADEMICYEARCODE, nvl(ENROLLMENTNO,' ') ENROLLMENTNO, nvl(STUDENTNAME,' ') STUDENTNAME, nvl(PROGRAMCODE,' ') COURSECODE, nvl(BRANCHCODE,' ') BRANCHCODE,nvl(Semester,0) Semester , StudentID SID from StudentMaster  where InstituteCode='"+mINSTITUTECODE+"' and StudentID='"+mSID+"' and enrollmentno is not null order by StudentName,AcademicYearCode";
	rs=db.getRowset(qry);
	if(rs.next())
	{
	mSem=rs.getString("Semester");
	mProg=rs.getString("COURSECODE");
	mBranch=rs.getString("BRANCHCODE");
%>
&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Program-Branch&nbsp;:&nbsp;</STRONG></font><%=mProg%>-<%=mBranch%>
&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Present Semester&nbsp;:&nbsp;</STRONG></font><%=mSem%>
<br>

&nbsp;&nbsp;<font color=black face=arial size=2><b>Enrollment No :</b> <%=rs.getString("ENROLLMENTNO")%>

</td>
</tr>
<%
}
%>
	<td>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
<%
  qry="select distinct nvl(examcode,' ')examcode from exammaster where institutecode='"+mINSTITUTECODE+"'";
	qry=qry+" and nvl(EXCLUDEINATTENDANCE,'N')='N' and nvl(deactive,'N')='N' ";
	qry=qry+" and examcode in ( select examcode from V#StudentSubjectTagging where StudentID='"+mSID+"' group by examcode) order by examcode desc";
  rs=db.getRowset(qry);
//out.print(qry);
%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 140px">	
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font color=black face=arial size=2><STRONG>Class Type</STRONG></font>
<%
  qry="select distinct nvl(attendancetype,'R')attendancetype from studentattendance where nvl(deactive,'N')='N' order by attendancetype";
  rs=db.getRowset(qry);
//out.print(qry);
	%>
	<select name="ClassType" tabindex="0" id="ClassType" style="WIDTH: 100px">	
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
</select>
<input type="submit" value="View Attendance"></td></tr>
</table></form>
<%
if(request.getParameter("x")!=null)
{
	if(request.getParameter("exam")==null)
		QryExam="";
	else
		QryExam=request.getParameter("exam").toString().trim();	
	
	if(request.getParameter("ClassType")==null)
	{
		QryType="";
	}
	else
	{
		QryType=request.getParameter("ClassType").toString().trim();
	}



	if(request.getParameter("SID")==null)
	{
		mSID="";
	}
	else
	{
		mSID=request.getParameter("SID").toString().trim();
	}
	mMemberID=mSID;
} 

//out.print(mSID+"*************33333333333***********");
%>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="98%" border=1 >
<thead>
<tr bgcolor="#c00000">
 <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td Title="Click on Subject to Sort"><b><font color="White">Subject</font></b></td>
  <td  Title="Click on Lecture+Tutorial(%) to Sort"><b><font color="White">Lecture+Tutorial(%)</font></b></td> 
 <td align=center Title="Click on Lecture(%) to Sort"><b><font color="White">Lecture(%)</font></b></td> 
 <td align=center Title="Click on Tutorial(%) to Sort"><b><font color="White">Tutorial(%)</font></b></td> 
 <td align=center Title="Click on Practical(%) to Sort"><b><font color="White">Practical(%)</font></b></td> 
</tr>
</thead>
<tbody>
<%
	
mMemberID=mSID;
/*
	qry="select distinct nvl(SUBJECT,' ')Subject, NVL(SUBJECTID,' ')SUBJECTID, NVL(SUBJECTCODE,' ')SUBJECTCODE,ACADEMICYEAR, SEMESTER, STUDENTID,NVL(SEMESTERTYPE,' ')SEMESTERTYPE ";
	qry=qry+" FROM V#STUDENTATTENDANCE WHERE EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
	qry=qry+" and STUDENTID='"+mSID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(DEACTIVE,'N')='N'";
	
	*/
	
String	mREGCONFIRMATIONDATE="",qry2="",QrySemType="",QrySecBr="",QrySubSec="",QryEmpID="";
ResultSet rsBatchDate=null;
qry="select distinct nvl(SUBJECT,' ') ||' - '|| NVL(SUBJECTCODE,' ') Subject , SUBJECTID,ACADEMICYEAR, SEMESTER, STUDENTID,NVL(SEMESTERTYPE,' ')SEMESTERTYPE ";
//qry="select distinct nvl(SUBJECT,' ') ||' - '|| NVL(SUBJECTCODE,' ') Subject , SUBJECTID,ACADEMICYEAR, SEMESTER, STUDENTID,NVL(SEMESTERTYPE,' ')SEMESTERTYPE, SECTIONBRANCH SECBR, SUBSECTIONCODE SUBSEC,employeeid,employeename,employeecode ";
				qry=qry+" ,  A.AcademicYear AcademicYear,A.ProgramCode ProgramCode from V#STUDENTLTPDETAIL A where  NVL(A.DEACTIVE,'N')='N'  and A.examcode='"+QryExam+"' and a.STUDENTID='"+mMemberID+"'  and a.INSTITUTECODE='"+mINSTITUTECODE+"' ";
				qry=qry+"order by Subject";
	
	
	
	rs=db.getRowset(qry);
//out.print(qry);
	msno=0;
	
	while(rs.next())
	{
	msno++ ;

		QryAcad=rs.getString("AcademicYear").toString().trim();
								QryProgramCode=rs.getString("ProgramCode").toString().trim();	
		QrySemType=rs.getString("SEMESTERTYPE").toString().trim();
	 
	QrySem=rs.getInt("SEMESTER");

		 			qry2=" Select nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE,nvl(to_char(REGCONFIRMATIONDATE,'yyyymmdd'),' ') REGCONFIRMATIONDATE1 ,nvl(SPECIALAPPROVAL,'N')SPECIALAPPROVAL   From StudentRegistration Where INSTITUTECODE='"+mINSTITUTECODE+"'";
					qry2=qry2+" AND EXAMCODE='"+QryExam+"' ";
					//qry2=qry2+" AND SEMESTER='"+rs.getString("SEMESTER")+"' AND NVL(SEMESTERTYPE,' ')='REG' ";
					qry2=qry2+" AND STUDENTID='"+rs.getString("STUDENTID")+"' ";					
					qry2=qry2+" AND ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' ";
 //out.print(qry2);
					rsBatchDate=db.getRowset(qry2);
					 if(rsBatchDate.next())
					{
							mSpecialApproval=rsBatchDate.getString("SPECIALAPPROVAL");

							mREGCONFIRMATIONDATE1=rsBatchDate.getString("REGCONFIRMATIONDATE1");

						if(rsBatchDate.getString("REGCONFIRMATIONDATE")==null) 
							mREGCONFIRMATIONDATE="";
						else
							mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
						mREGCONFIRMATIONDATERG=rsBatchDate.getString(1);
					}
					else
					{
						mREGCONFIRMATIONDATE="";
					}



					




//----------------------------------------  1314  B.T DUAL  JIIT J128------


int hghg=0,hhhhhhh=0;
if( (mINSTITUTECODE.equals("JIIT") || mINSTITUTECODE.equals("J128")) && (QryProgramCode.equals("B.T") || QryProgramCode.equals("DUAL"))
&& QryAcad.equals("1314")  
	&& 9==8)
					{

	hghg++;
				QrySem=1;
					//mREGCONFIRMATIONDATE="16-08-2013";
					//out.print("&**&*&*&**&*&*&*&*&8");
					}else if( (mINSTITUTECODE.equals("JPBS")  ) && (QryProgramCode.equals("MBA")  )
&& QryAcad.equals("1314")  
	&& 8==9)
					{

	hhhhhhh++;
				QrySem=1;
					//mREGCONFIRMATIONDATE="16-08-2013";
					//out.print("&**&*&*&**&*&*&*&*&8");
					}
					else
					{
						hghg=0;
				QrySem=QrySem;
				mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE;
					}




//----------------------------------------special case -----------------------------//

 if(mSpecialApproval.equals("Y"))
	QrySem=1;
 else
	 QrySem=QrySem;

//----------------------------------------special case -----------------------------//

int mREGCONFIRMATIONDATE1int = Integer.parseInt(mREGCONFIRMATIONDATE1); 


if(QrySem==1 && mREGCONFIRMATIONDATE1int<=(20130816) && hghg>0  ){
	mREGCONFIRMATIONDATE="16-08-2013";
	//out.print(mREGCONFIRMATIONDATE1int+"20130816");

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int >(20130816) && hghg>0  ){
	//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"****1111111111*******"+mREGCONFIRMATIONDATE+"    &nbsp;&nbsp;&nbsp;&nbsp;"); 
//	mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE+1;
 	
qrtyyy="select to_char(to_date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')+1,'dd-mm-yyyy')Regdate from dual";
rsyyyy=db.getRowset(qrtyyy);
if(rsyyyy.next()){
mREGCONFIRMATIONDATE=rsyyyy.getString("Regdate");
//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"*****22222222222******"+mREGCONFIRMATIONDATE);
}

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int<=(20130630) && hhhhhhh>0  ){
	mREGCONFIRMATIONDATE="30-06-2013";
	//out.print(mREGCONFIRMATIONDATE1int+"20130816");

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int >(20130630) && hhhhhhh>0  ){
	//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"****1111111111*******"+mREGCONFIRMATIONDATE+"    &nbsp;&nbsp;&nbsp;&nbsp;"); 
//	mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE+1;
 	
qrtyyy="select to_char(to_date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')+1,'dd-mm-yyyy')Regdate from dual";
rsyyyy=db.getRowset(qrtyyy);
if(rsyyyy.next()){
mREGCONFIRMATIONDATE=rsyyyy.getString("Regdate");
//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"*****22222222222******"+mREGCONFIRMATIONDATE);
}

}else{

mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE;
//out.print(mREGCONFIRMATIONDATE+"&nbsp;&nbsp;20130816"+"################");
}

	%>
	<tr>
		<td><%=msno%></td>	
		<td><%=rs.getString("SUBJECT")%></td>
	<%
	
		/*qry1="select NVL(LTP,' ')LTP, count(*)Tcount from V#STUDENTATTENDANCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(DEACTIVE,'N')='N' Group By LTP";
		qry1=qry1+" union all select NVL(LTP,' ')LTP, count(*)Tcount from STUDENTPREVATTENDENCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(DEACTIVE,'N')='N' Group By LTP";
*/

// Find total No. of Classes


String mLFSTID="";
String mTFSTID="";
String mPFSTID="";
String prevLFSTID="";
String prevTFSTID="";
String prevPFSTID="";


qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='L' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
 //out.print(qry1+"////////////");
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mLFSTID=rs1.getString("fstid");			
		}

qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='T' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
//out.println(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mTFSTID=rs1.getString("fstid");			
		}

		qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='P' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mPFSTID=rs1.getString("fstid");			
		}





qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='L' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'  AND  a.LTP='L' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ) ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevLFSTID=rs1.getString("fstid");			
		}

qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='T' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'  AND  a.LTP='T' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ) ";
//out.println(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevTFSTID=rs1.getString("fstid");			
		}

	qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='P' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'  AND  a.LTP='P' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ) ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevPFSTID=rs1.getString("fstid");			
		}

long mNotAttendedAttendance=0;


// Process for L Type
mNotAttendedAttendance=0;
qry=" SELECT distinct nvl(count(pcount ),0)  pcount FROM (select distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='L' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mLFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+rs.getString("SubjectID")+"' and  b.LTP='L' and  b.FSTID='"+mLFSTID+"')))  ";                            
qry=qry+" and (("+QrySem+">1)  or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
qry=qry+" and trunc(a.classtimefrom)<  nvl((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='L' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='L' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>= TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )    )";
   //out.print(qry+"<BR><BR><BR>");
rs1=db.getRowset(qry);
 
 //out.print(qry);
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
			
		}

qry=" select count(distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='L' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevLFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='L' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+rs.getString("SubjectID")+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='L' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevLFSTID+"' )";
qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";     


//rs1=db.getRowset(qry); 
rs1=db.getRowset(qry);

 
  //out.print(qry);
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}

 
qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'   and a.ltp='L' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       

qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";     
 //out.print(qry1);
 

rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mL=rs1.getLong("pcount");
			
		}
mL=mL+mNotAttendedAttendance;

qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'  and a.ltp='L' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";  
 
rs1=db.getRowset(qry1);
//out.print(qry1);

while(rs1.next())
		{
		mLP=rs1.getLong("pcount");
			
		}





//-- For T

mNotAttendedAttendance=0;
qry=" SELECT distinct nvl(count(pcount ),0)  pcount FROM (select distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='T' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mTFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+rs.getString("SubjectID")+"' and  b.LTP='T' and  b.FSTID='"+mTFSTID+"')))  ";                            
qry=qry+" and (("+QrySem+">1)  or ( "+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  nvl((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )    )";
rs1=db.getRowset(qry);
//out.print(qry);

while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
		
		}

 qry=" select count(distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='T' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevTFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+rs.getString("SubjectID")+"' and c.studentid='"+mMemberID+"'   ";
qry=qry+"  and c.LTP='T' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevTFSTID+"' )";
qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";     

rs1=db.getRowset(qry);
//out.print(qry);

while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
		//out.print("mNotAttendedAttendance"+mNotAttendedAttendance);	
		}
qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'   and a.ltp='T' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";      
//out.print(qry1);

rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mT=rs1.getLong("pcount");
		//out.print("MT"+mT);
			
		}
mT=mT+mNotAttendedAttendance;

qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'   and a.ltp='T' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";    

rs1=db.getRowset(qry1);
//out.print(qry1);
while(rs1.next())
		{
		mTP=rs1.getLong("pcount");			
		}



// For P

mNotAttendedAttendance=0;
qry=" SELECT distinct nvl(count(pcount ),0)  pcount FROM (select distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='P' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mPFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+rs.getString("SubjectID")+"' and  b.LTP='P' and b.FSTID='"+mPFSTID+"')))  ";                            
qry=qry+" and ( ("+QrySem+">1)  or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  nvl(( SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='P' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)< nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='P' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )    )";
rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
			
		}

 qry=" select count(distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='P' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevPFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='P' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+rs.getString("SubjectID")+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='P' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevPFSTID+"' )";
qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";     

rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}
qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'   and a.ltp='P' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) "; 
//out.print(qry1);


rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mP=rs1.getLong("pcount");
			
		}
mP=mP+mNotAttendedAttendance;

qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'  and a.ltp='P' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>= TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";  

rs1=db.getRowset(qry1);
//out.print(qry1);
while(rs1.next())
		{
		mPP=rs1.getLong("pcount");
			
		}



if(mL>0)
{
	//out.print(mLP+"*****"+mL);
		mPercL=Math.round((mLP*100)/mL);
		mPercLT=Math.round(((mLP+mTP)*100)/(mL+mT));


			//out.print(mPercLT+"sdff");         
		%>
	<td align=center><a Title="View Date wise Lecture + Tutorial Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=LT&amp;mRegConfirmDate=<%=mREGCONFIRMATIONDATE%>&amp;mRegConfirmDateOrg=<%=mREGCONFIRMATIONDATERG%>&amp;prevTFSTID=<%=prevTFSTID%>&amp;prevLFSTID=<%=prevLFSTID%>&amp;mLFSTID=<%=mLFSTID%>&amp;mTFSTID=<%=mTFSTID%>&amp;SID=<%=mMemberID%>&amp;INSTCODE=<%=mINSTITUTECODE%>'><%=mPercLT%></a></td>
	
	<td align=center><a Title="View Date wise Lecture Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=L&amp;mRegConfirmDate=<%=mREGCONFIRMATIONDATE%>&amp;mRegConfirmDateOrg=<%=mREGCONFIRMATIONDATERG%>&amp;prevLFSTID=<%=prevLFSTID%>&amp;mLFSTID=<%=mLFSTID%>&amp;SID=<%=mMemberID%>&amp;INSTCODE=<%=mINSTITUTECODE%>'><font color=blue><%=mPercL%></font></a></td>
<%
		
}
else
{
%>
<td>&nbsp;</td>
<td>&nbsp;</td>
<%
}
if(mT>0)
{
		mPercT=Math.round((mTP*100)/mT);
	
		%>
		<td align=center><a Title="View Date wise Tutorial Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=T&amp;mRegConfirmDate=<%=mREGCONFIRMATIONDATE%>&amp;mRegConfirmDateOrg=<%=mREGCONFIRMATIONDATERG%>&amp;prevTFSTID=<%=prevTFSTID%>&amp;mTFSTID=<%=mTFSTID%>&amp;SID=<%=mMemberID%>&amp;INSTCODE=<%=mINSTITUTECODE%>'><%=mPercT%></a></td>
		<%
		
}
else
{
%>
<td>&nbsp;</td>
<%
}
if(mP>0)
{
		mPercP=((mPP*100)/mP);
		
		%>
		<td align=center><a Title="View Date wise Practical Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=P&amp;&amp;mRegConfirmDate=<%=mREGCONFIRMATIONDATE%>&amp;mRegConfirmDateOrg=<%=mREGCONFIRMATIONDATERG%>&amp;prevPFSTID=<%=prevPFSTID%>&amp;mPFSTID=<%=mPFSTID%>&amp;SID=<%=mMemberID%>&amp;INSTCODE=<%=mINSTITUTECODE%>'><%=mPercP%></a></td>
		<%
		
}
else
{
%>
<td>&nbsp;</td>
<%
}
mL=0;
mT=0;
mP=0;
mLP=0;
mTP=0;
mPP=0;
%>
</tr>	
<%
}
%>
</tbody>
</table>		
<table><tr><td><font size=2 color=red face=arialblack>&nbsp;&nbsp;&nbsp;Hint: </font><font face=arialblack size=2 color=Green>If the '%' attendance of Lecture, Tutorial or Practical is less than 50%, It will be appeared in Red color</font></td></tr></table>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>
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
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br> 
   <%
	}
    		 //-----------------------------
  }   //2
else
{
	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	
}
%>
<br><br><br><br><br>
</body>
</html>

