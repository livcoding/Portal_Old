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
<TITLE>#### <%=mHead%> [ Student Class Attendance ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

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


<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
	' 
*************************************************************************************************
	' *												
	' * File Name  :	StudentAttendanceList.JSP		[For Students]					
	' * Author     :		Vijay
	' * Date       :		25th Jan 07								
	' * Version    :		1.0								
	' * Description:	Current Student Attendance Detail
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="";
long mPresent=0, mL=0, mT=0, mP=0, mLP=0, mTP=0, mPP=0;
int msno=0;
String mSem="",QryExam="", QryType="R";
int mSemPlusOne=0;
String mexamcode="",mexam="",mProg="",mBranch="",mName="", mBasket="", mEm;
long mPercL=0,mPercT=0,mPercP=0,mPercLT=0;
String mINSTITUTECODE="";
String mEmployeeID="";
String mEName="";
String mClassType="";
String mClasstype="";
ResultSet rs=null,rs1=null,rs2=null;

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
if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
	mSemPlusOne=(Integer.parseInt(mSem))+0;
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
	qry="Select WEBKIOSK.ShowLink('88','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>Student Attendance</b></font>
</td>
</tr>
</table>
<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<table width=100%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td><font color=black face=arial size=2><STRONG> Name:&nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mName)%>[<%=mDMemberCode%>]</td>
<td><font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><%=mProg%>(<%=mBranch%>)</td>
<td><font color=black face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><%=mSemPlusOne%></td></tr>
<tr>
	<td><font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
<%
		qry="SELECT DISTINCT EXAMCODE,EXAMPERIODFROM FROM(select distinct nvl(examcode,' ')examcode,EXAMPERIODFROM FROM   exammaster where institutecode='"+mINSTITUTECODE+"'";
	qry=qry+" and nvl(EXCLUDEINATTENDANCE,'N')='N' and nvl(deactive,'N')='N' ";
 	qry=qry+" and examcode in ( select examcode from V#StudentAttendance where " +
            "StudentID='"+mMemberID+"' AND institutecode='"+mINSTITUTECODE+"' group by examcode)  " +
            "UNION  ALL  SELECT DISTINCT NVL (examcode, ' ') examcode, examperiodfrom " +
            "FROM exammaster  WHERE institutecode = '"+mINSTITUTECODE+"'  " +
            "AND NVL (excludeinattendance, 'N') = 'N' AND NVL (deactive, 'N') = 'N'            " +
            "AND examcode IN (SELECT examcodeforattendnaceentry  " +
            "FROM companyinstitutetagging  " +
            "WHERE institutecode = '"+mINSTITUTECODE+"') " +
            "AND examcode IN ( SELECT   examcode  " +
            "FROM studentprevattendence                       WHERE studentid = '"+mMemberID+"'         AND institutecode = '"+mINSTITUTECODE+"'                    GROUP BY examcode)                     AND ROWNUM <= 1  ORDER BY examperiodfrom DESC)   ORDER BY examperiodfrom DESC ";
	//out.print(qry);
  	rs=db.getRowset(qry);

//  rs=db.getRowset(qry);
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
</td>
<td colspan=2>
<input type="submit" value="View Attendance"></td></tr>
</table></form>
<%
if(request.getParameter("x")!=null)
  {

			if(request.getParameter("exam")==null)
				QryExam="";
			else
				QryExam=request.getParameter("exam").toString().trim();	
	
	 		
}
%>
 <TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="98%" border=1 >
  <thead>
  <tr bgcolor="#c00000">
  <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
  <td Title="Click on Subject to Sort"><b><font color="White">Subject</font></b></td>
  <!--  <td Title="Click on Subject to Sort"><b><font color="White">Employee </font></b></td>-->
  <td  Title="Click on Lecture+Tutorial(%) to Sort"><b><font color="White">Lecture+Tutorial(%)</font></b></td> 
  <td align=center Title="Click on Lecture(%) to Sort"><b><font color="White">Lecture(%)</font></b></td> 
  <td align=center Title="Click on Tutorial(%) to Sort"><b><font color="White">Tutorial(%)</font></b></td> 
  <td align=center Title="Click on Practical(%) to Sort"><b><font color="White">Practical(%)</font></b></td> 
  </tr>
  </thead>
 <tbody>
<%
String	mREGCONFIRMATIONDATE="",qry2="",QrySemType="",QrySecBr="",QrySubSec="",QryEmpID="",mSpecialApproval="";
ResultSet rsBatchDate=null;
int QrySem=0;

/*	qry="select distinct nvl(SUBJECT,' ') ||' - '|| NVL(SUBJECTCODE,' ') Subject , SUBJECTID,ACADEMICYEAR, SEMESTER, STUDENTID,NVL(SEMESTERTYPE,' ')SEMESTERTYPE, SECTIONBRANCH SECBR, SUBSECTIONCODE SUBSEC,employeeid ";
	qry=qry+" FROM V#STUDENTATTENDANCE WHERE EXAMCODE='"+QryExam+"' ";
	qry=qry+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(DEACTIVE,'N')='N'";
	qry=qry+" union  select nvl(b.SUBJECT,' ') ||' - '|| NVL(b.SUBJECTCODE,' ') Subject , b.SUBJECTID,ACADEMICYEAR, SEMESTER, STUDENTID,NVL(SEMESTERTYPE,' ')SEMESTERTYPE, SECTIONBRANCH SECBR, SUBSECTIONCODE SUBSEC,employeeid  from STUDENTPREVATTENDENCE a,subjectmaster b where a.EXAMCODE='"+QryExam+"' ";
	qry=qry+" and a.STUDENTID='"+mMemberID+"' and a.INSTITUTECODE=b.INSTITUTECODE and a.subjectid=b.subjectid and a.INSTITUTECODE='"+mINSTITUTECODE+"'  ";
*/
qry="select distinct nvl(SUBJECT,' ') ||' - '|| NVL(SUBJECTCODE,' ') Subject , SUBJECTID,ACADEMICYEAR, SEMESTER, STUDENTID,NVL(SEMESTERTYPE,' ')SEMESTERTYPE ";
//qry="select distinct nvl(SUBJECT,' ') ||' - '|| NVL(SUBJECTCODE,' ') Subject , SUBJECTID,ACADEMICYEAR, SEMESTER, STUDENTID,NVL(SEMESTERTYPE,' ')SEMESTERTYPE, SECTIONBRANCH SECBR, SUBSECTIONCODE SUBSEC,employeeid,employeename,employeecode ";
				qry=qry+" from V#STUDENTLTPDETAIL A where  NVL(A.DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' and A.examcode='"+QryExam+"' and a.STUDENTID='"+mMemberID+"'  and a.INSTITUTECODE='"+mINSTITUTECODE+"'  ";
				qry=qry+" order by Subject";

	//out.print(qry);
	rs=db.getRowset(qry);
	msno=0;
	while(rs.next())
	{
		msno++ ;

		//QrySecBr=rs.getString("SECBR").toString().trim();
		//QrySubSec=rs.getString("SUBSEC").toString().trim();
		QrySemType=rs.getString("SEMESTERTYPE").toString().trim();
	//QryEmpID=rs.getString("employeeid").toString().trim();

	QrySem=rs.getInt("SEMESTER");

					

		 			qry2=" Select nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE ,nvl(SPECIALAPPROVAL,'N')SPECIALAPPROVAL   From StudentRegistration Where INSTITUTECODE='"+mINSTITUTECODE+"'";
					qry2=qry2+" AND EXAMCODE='"+QryExam+"' ";
					//qry2=qry2+" AND SEMESTER='"+rs.getString("SEMESTER")+"' AND NVL(SEMESTERTYPE,' ')='REG' ";
					qry2=qry2+" AND STUDENTID='"+rs.getString("STUDENTID")+"' ";					
					qry2=qry2+" AND ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' ";
//out.print(qry2);
					rsBatchDate=db.getRowset(qry2);
					 if(rsBatchDate.next())
					{
							mSpecialApproval=rsBatchDate.getString("SPECIALAPPROVAL");

						if(rsBatchDate.getString("REGCONFIRMATIONDATE")==null) 
							mREGCONFIRMATIONDATE="";
						else
							mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
					}
					else
					{
						mREGCONFIRMATIONDATE="";
					}


					
				// ##--------------------------------->>    Special case     <<------------------------------## //

												if(mSpecialApproval.equals("Y"))
													QrySem=1;
												else
													QrySem=QrySem;

				// ##---------------------------------->>     Special case      <<----------------------------------##  //

	%>
	<tr>
		<td><%=msno%></td>	
		<td><%=rs.getString("SUBJECT")%></td>
	<%

String mLFSTID="";
String mTFSTID="";
String mPFSTID="";
String prevLFSTID="";
String prevTFSTID="";
String prevPFSTID="";


qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='L' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
//out.print(qry1);
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
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )    )";
//out.print(qry);
rs1=db.getRowset(qry);
 
//out.print("aaa1");
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

rs1=db.getRowset(qry);

 
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");			
		}

 /* change by ankur
qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+QryExam+"'   and a.ltp='L' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"')";  
*/

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

while(rs1.next())
		{
		mLP=rs1.getLong("pcount");
		}

//-- For T

mNotAttendedAttendance=0;
qry=" SELECT distinct nvl(count(pcount ),0)  pcount FROM (select distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='T' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mTFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+rs.getString("SubjectID")+"' and  b.LTP='T' and  b.FSTID='"+mTFSTID+"')))  ";                            
qry=qry+" and (("+QrySem+">1)  or ( "+QrySem+"=1 and trunc(A.attendancedate) >=trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  nvl((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )    )";
rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
		//out.print("mNotAttendedAttendance  First"+mNotAttendedAttendance);		
		}

 qry=" select count(distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='T' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevTFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+rs.getString("SubjectID")+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='T' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevTFSTID+"' )";
qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";     

rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
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
//		For P

mNotAttendedAttendance=0;
qry=" SELECT distinct nvl(count(pcount ),0)  pcount FROM (select distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='P' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mPFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+rs.getString("SubjectID")+"' and  b.LTP='P' and b.FSTID='"+mPFSTID+"')))  ";                            
qry=qry+" and ( ("+QrySem+">1)  or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  nvl(( SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='P' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)< nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='P' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)))";
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
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
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
//out.print(mPP);

if(mL>0)
{
		//out.print(mLP+"------*-------"+mL);
		mPercL=Math.round((mLP*100)/mL);
		mPercLT=Math.round(((mLP+mTP)*100)/(mL+mT));


			//out.print(mLP+"-----**------"+mL);
		%>
	<td align=center><a Title="View Date wise Lecture + Tutorial Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=LT&amp;mRegConfirmDate=<%=mREGCONFIRMATIONDATE%>&amp;prevTFSTID=<%=prevTFSTID%>&amp;prevLFSTID=<%=prevLFSTID%>&amp;mLFSTID=<%=mLFSTID%>&amp;mTFSTID=<%=mTFSTID%>'><%=mPercLT%></a></td>
	
	<td align=center><a Title="View Date wise Lecture Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=L&amp;&amp;mRegConfirmDate=<%=mREGCONFIRMATIONDATE%>&amp;prevLFSTID=<%=prevLFSTID%>&amp;mLFSTID=<%=mLFSTID%>'><font color=blue>    <%=mPercL%></font></a></td>
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
		<td align=center><a Title="View Date wise Tutorial Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=T&amp;mRegConfirmDate=<%=mREGCONFIRMATIONDATE%>&amp;prevTFSTID=<%=prevTFSTID%>&amp;mTFSTID=<%=mTFSTID%>'><%=mPercT%></a></td>
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
		<td align=center><a Title="View Date wise Practical Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=P&amp;&amp;mRegConfirmDate=<%=mREGCONFIRMATIONDATE%>&amp;prevPFSTID=<%=prevPFSTID%>&amp;mPFSTID=<%=mPFSTID%>'><%=mPercP%></a></td>
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
<table>
<!-- 
<tr><td><font size=2 color=blue face=verdana><B>&nbsp;Hint:</B> </font>
 <UL>
	<font face="verdana" size=2 color=Green><LI>
	<B>If the '%' attendance of Lecture, Tutorial or Practical is less than 50%, It will appear in blue color.</B> 
	<LI><B>By clicking on '%' link you can view attendance datewise.</B>
	<LI><B>In case of any doubt, contact respective faculty.</B></font>
 </UL>

</font></td></tr> -->


<tr><td><font size=2 color=blue face=verdana><B>&nbsp;Note:</B>
 <UL>
	<font face="verdana" size=2 color=black>
	<LI><B>Attendance of Monday to Wednesday  will be updated by Saturday of the current week. </B> 
	<LI><B>Attendance of Thursday to Saturday will be updated by Wednesday of the following week. </B>
</font>
 </UL>
</td></tr>


</table>
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
	<font color=blue>
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
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='blue'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	//out.print(qry);
}
%>
</body>
</html>