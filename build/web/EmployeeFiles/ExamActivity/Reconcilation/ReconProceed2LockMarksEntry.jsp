<%@ page language="java" import="java.sql.*,java.math.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
String  qryin="", qryt="", mDebarGrade="", qry4="", qry22="",mAcademicYeay="", mTypeofaction="",qry11="",mSem1="",Studid="",mFSTIDD="",mREGCONFIRMATIONDATE="",mLTP="",mLFSTID="",prevLFSTID="",qryspe="",mSpecial="",qrys="";

String qrytat="";  ResultSet rstat=null;
String qertu=""; ResultSet rsqertu=null; double xL=0;
double mTATTOTAL=0;
int k=0;
double  mL=0,mLP=0,mPercL=0;
int ctr=0 ,DRejected=0,Rejected=0,DERejected=0;
double mMarksawarded2=0,mMassCutMarks=0,mNetMarks=0,mTATotalMarks=0,mMarksAdd=0 ,mLimit=0,StudentGradeCalculationMarksAwarded1=0,StudentGradeCalculationMarks=0,mStudentMean=0,mGlobalMean=0,mStudentMeanSum=0,mStudentGradeCalculationMean=0;
ResultSet  rsBatchDate=null , rs11=null ,rs22=null ,rse=null ,rss=null ,rsst=null;
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mDesg="",mDept="",mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDMemberID="";
String mEC="",mSemester="",mStudentid="",mComp="", mInst="",mEventsubevent="";
String mExam="",mSC="",mSubject="",mSID="",mProceed="",mProrataEvent="",mSMarks="",mDetained ="";
double xWEIGHTAGE1=0;
ResultSet rs = null, rs1=null, rs2=null,rs3=null,rs6=null,rs4=null;
String mIC="";
String qry = "",qry2="",qry1="",qry3="";
String mself="";

		double mDebarProrata=0,mTotWeig=0;
		double mSumMarksProrata=0;
		double mSProrataMarks=0,mSWeight=0,mProrataWeightage=0,mProrataTotalMarks=0;

if (session.getAttribute("Click")==null)
{
	mself="";
}
else
{
	mself=session.getAttribute("Click").toString().trim();
}
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}

if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
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

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Proceed to Lock Marks Entry ] </TITLE>


<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<%	try{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk1=null;

  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------

	qry="Select WEBKIOSK.ShowLink('399','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk1= db.getRowset(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	   {
  //----------------------

  mIC=request.getParameter("institute");
  mEventsubevent=request.getParameter("EventSubevent").toString().trim();
  mEC=request.getParameter("Exam");
  mSC=request.getParameter("subjectcode");
  if(request.getParameter("Proceed")!=null)
	mProceed="Y";
  else
       mProceed="N";



  qry="select distinct A.fstid,nvl(A.studentid,' ')studentid,nvl(A.studentname,' ')studentname, ";
  qry=qry+" nvl(A.enrollmentno,' ')enrollmentno,nvl(A.semester,0)semester,A.subsectioncode, ";
  qry=qry+ "nvl(A.programcode,' ')programcode,nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a";
  qry=qry+" where A.institutecode='"+mIC+"' and studentid   IN  (select studentid from studentregistration  where nvl(REGALLOW,'N')='Y' and EXAMCODE='"+mEC+"'  and institutecode='"+mIC+"'   ) and A.EVENTSUBEVENT='"+mEventsubevent+"' and nvl(A.PROCEEDSECOND,'N')='N' and nvl(A.locked,'N')='N' and nvl(A.PUBLISHED,'N')='N' and nvl(a.DEACTIVE,'N')='N' and ";
  qry=qry+" A.examcode='"+mEC+"' and (A.ltp='L' or (A.LTP='E' AND A.PROJECTSUBJECT='Y') OR A.LTP='P') and A.subjectID='"+mSC+"'";
// and A.employeeid='"+mDMemberID+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";
  qry=qry+" AND (A.fstid) in ((select fstid from facultysubjecttagging where examcode='"+mEC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N' AND (LTP='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') ";
  qry=qry+" UNION select A.fstid from FACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and FSTID in (select fstid from facultysubjecttagging where examcode='"+mEC+"' AND subjectID='"+mSC+"'))";
  if(!mself.equals("Self"))
  {
	qry=qry+" UNION select A.fstid from EX#SUBJECTGRADECOORDINATOR where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mDMemberID+"' and FSTID in (select fstid from facultysubjecttagging where examcode='"+mEC+"' AND subjectID='"+mSC+"')";
  }
  qry=qry+") and not exists (select 'y' from V#STUDENTEVENTSUBJECTMARKS b where a.fstid=b.fstid and a.studentid=b.studentid AND EVENTSUBEVENT='"+mEventsubevent+"' and a.EVENTSUBEVENT=b.EVENTSUBEVENT and (nvl(detained,'N')='D' or nvl(detained,'N')='A' or nvl(marksawarded1,-1)>=0 )) order by enrollmentno ";
//out.println("JILIT 1111 - "+qry);

if(mself.equals("Self"))
{
	qry1="select distinct A.fstid,nvl(A.studentid,' ')studentid,nvl(A.studentname,' ')studentname, ";
	qry1=qry1+" nvl(A.enrollmentno,' ')enrollmentno,nvl(A.semester,0)semester,A.subsectioncode, ";
	qry1=qry1+" nvl(A.programcode,' ')programcode,nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a";
	qry1=qry1+" where a.institutecode='"+mIC+"' and studentid   IN  (select studentid from studentregistration  where nvl(REGALLOW,'N')='Y' and EXAMCODE='"+mEC+"'  and institutecode='"+mIC+"' )  and nvl(a.DEACTIVE,'N')='N' and nvl(a.PROCEEDSECOND,'N')='N' and nvl(a.locked,'N')='N' and nvl(a.PUBLISHED,'N')='N' and ";
	qry1=qry1+" a.examcode='"+mEC+"' and (a.ltp='L' OR (a.LTP='E' AND a.PROJECTSUBJECT='Y') OR a.LTP='P' ) and a.subjectID='"+mSC+"' ";
	qry1=qry1+" AND ((a.EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual)) OR (a.fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mIC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E'))";
	qry1=qry1+" AND a.EVENTSUBEVENT='"+mEventsubevent+"' " ;
	qry1=qry1+" and not exists (select 'y' from V#STUDENTEVENTSUBJECTMARKS b where a.fstid=b.fstid and a.studentid=b.studentid  AND EVENTSUBEVENT='"+mEventsubevent+"' and (nvl(detained,'N')='D'       OR  NVL (detained, 'N') = 'U'                            OR NVL (detained, 'N') = 'M'              or nvl(detained,'N')='A' or nvl(marksawarded1,-1)>=0 ))";
	qry1=qry1+" GROUP BY a.fstid, a.studentid, a.StudentName, a.enrollmentno, a.Semester, a.programcode, a.SECTIONBRANCH, a.subsectioncode";
	qry1=qry1+" order by enrollmentno";
}
else if(!mself.equals("Self"))
{
	qry1="select distinct A.fstid,nvl(A.studentid,' ')studentid,nvl(A.studentname,' ')studentname, ";
	qry1=qry1+" nvl(A.enrollmentno,' ')enrollmentno,nvl(A.semester,0)semester,A.subsectioncode, ";
	qry1=qry1+" nvl(A.programcode,' ')programcode,nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a";
	qry1=qry1+" where a.institutecode='"+mIC+"' and studentid   IN  (select studentid from studentregistration  where nvl(REGALLOW,'N')='Y' and EXAMCODE='"+mEC+"'  and institutecode='"+mIC+"'   ) and nvl(a.DEACTIVE,'N')='N' and nvl(a.PROCEEDSECOND,'N')='N' and nvl(a.locked,'N')='N' and nvl(a.PUBLISHED,'N')='N' and ";
	qry1=qry1+" a.examcode='"+mEC+"'  and (a.ltp='L' OR (a.LTP='E' AND a.PROJECTSUBJECT='Y') OR a.LTP='P' ) and a.subjectID='"+mSC+"' ";
	qry1=qry1+" And a.EVENTSUBEVENT='"+mEventsubevent+"' " ;
	qry1=qry1+" AND a.FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mDMemberID+"')";
	qry1=qry1+" and not exists (select 'y' from V#STUDENTEVENTSUBJECTMARKS b where a.fstid=b.fstid and a.studentid=b.studentid   AND EVENTSUBEVENT='"+mEventsubevent+"' and (nvl(detained,'N')='D'                             OR  NVL (detained, 'N') = 'U'                            OR NVL (detained, 'N') = 'M'   or nvl(detained,'N')='A' or nvl(marksawarded1,-1)>=0 ))";
	qry1=qry1+" GROUP BY a.fstid, a.studentid, a.StudentName, a.enrollmentno, a.Semester, a.programcode, a.SECTIONBRANCH, a.subsectioncode";
	qry1=qry1+" order by enrollmentno";
}
//System.out.println("JILIT - "+qry1);
 ///out.println("JILIT - "+qry1);


  rs=db.getRowset(qry1);
  //out.print(qry1);
  String mflag="";
  int Sno=0;

  mflag="Y";
  while(rs.next())
  {
	Sno++;
	if(mflag.equals("Y"))
	{
		mflag="N";
		%>
		<table border=1 align=center rules='rows' width="75%" >
		<tr><td align=center colspan=3><font color=red><b>Warning: Marks of following students have not been entered.<br>You can not lock marks entry.</b></font>  </td></tr>
		<tr bgcolor=ff8c00>
		<td><b><Font color=white face=arial>SNo.</Font></b></td>
		<td><b><Font color=white face=arial>Enrollment No.</Font></b></td>
		<td><b><Font color=white face=arial>Student Name</Font></b></td></tr>
      	<%
	}
	%>
	<tr bgcolor=white>
	<td><%=Sno%></td>
	<td><%=rs.getString("enrollmentno")%></td>
	<td><%=GlobalFunctions.toTtitleCase(rs.getString("studentname"))%></td>
	</tr>
	<%
  }//END OF WHILE
  int a=0;
  if(mflag.equals("N"))
  {
	%>
	<tr><td colspan=3 align=center><a href='ReconMarksEntryGridVersion.jsp'><font color=blue><b>Continue with Marks Entry</b></font></a></td></tr>
	</table>
	<%
  }
  else
  {
	if (mProceed.equals("Y"))
	{
		//out.println(mself);
		if(mself.equals("Self"))
		{
			qry="Update EXAMEVENTSUBJECTTAGGING Set PROCEEDSECOND='Y',PUBLISHED='Y' where EVENTSUBEVENT='"+mEventsubevent+"'";
			qry=qry+" and FSTID in (select FSTID from FacultySubjectTagging where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"' and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P') and EMPLOYEEID='"+mDMemberID+"'";
			qry=qry+" UNION (Select FSTID from FACULTYSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' AND EMPLOYEEID='"+mDMemberID+"' and FSTID IN (Select FSTID from FacultySubjectTagging Where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"' and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P')) and facultytype=decode('"+mDMemberType+"','E','I','E')))";
			//out.println(qry);
      		a=db.update(qry);

			qry="Update STUDENTEVENTSUBJECTMARKS set LOCKED='Y' where EVENTSUBEVENT='"+mEventsubevent+"'";
			qry=qry+" and FSTID in (select FSTID from FacultySubjectTagging where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"' and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P') and EMPLOYEEID='"+mDMemberID+"'";
			qry=qry+" UNION (Select FSTID from FACULTYSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' AND EMPLOYEEID='"+mDMemberID+"' and FSTID IN (Select FSTID from FacultySubjectTagging Where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"' and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P')) and facultytype=decode('"+mDMemberType+"','E','I','E')))";
			//out.println(qry);
      		a=db.update(qry);
		}
		else
		{
			qry="Update EXAMEVENTSUBJECTTAGGING Set PROCEEDSECOND='Y',PUBLISHED='Y' where EVENTSUBEVENT='"+mEventsubevent+"'";
			qry=qry+" and FSTID in (select FSTID from FacultySubjectTagging where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"' and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P') and EMPLOYEEID='"+mDMemberID+"'";
			qry=qry+" UNION (Select FSTID from EX#SUBJECTGRADECOORDINATOR where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' AND FACULTYID='"+mDMemberID+"' and FSTID IN (Select FSTID from FacultySubjectTagging Where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"' and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P')) and facultytype=decode('"+mDMemberType+"','E','I','E')))";
			//out.println(qry);
			a=db.update(qry);

			qry="Update STUDENTEVENTSUBJECTMARKS set LOCKED='Y' where EVENTSUBEVENT='"+mEventsubevent+"'";
			qry=qry+" and FSTID in (select FSTID from FacultySubjectTagging where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"' and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P') and EMPLOYEEID='"+mDMemberID+"'";
			qry=qry+" UNION (Select FSTID from EX#SUBJECTGRADECOORDINATOR where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' AND FACULTYID='"+mDMemberID+"' and FSTID IN (Select FSTID from FacultySubjectTagging Where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"' and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P')) and facultytype=decode('"+mDMemberType+"','E','I','E')))";
			//out.println(qry);
            a=db.update(qry);
		}


//out.print(qry);

try{

//UFM Marks zero


int  xx=0;
String qry7="SELECT distinct  b.studentname,b.ENROLLMENTNO, nvl(a.EVENTSUBEVENT,'N') PEVENTSUBEVENT,  B.WEIGHTAGE WEIGHTAGE,A.PRORATA,b.EVENTSUBEVENT, b.STUDENTID,b.FSTID FROM DEBARSTUDENTDETAIL A,V#STUDENTEVENTSUBJECTMARKS b WHERE   a.STUDENTID=b.STUDENTID and a.FSTID=b.FSTID and b.EXAMCODE='"+mEC+"' AND NVL(A.UFMMARKS,'N')='Y'  and b.EVENTSUBEVENT='"+mEventsubevent+"' and b.INSTITUTECODE='"+mIC+"'   and b.subjectid='"+mSC+"'  and a.INSTITUTECODE=b.INSTITUTECODE and a.EXAMCODE=b.EXAMCODE and a.EVENTSUBEVENT=b.EVENTSUBEVENT  AND B.EVENTSUBEVENT IN (SELECT  EXAMEVENTCODE FROM EXAMEVENTMASTER C  WHERE      C.EXAMCODE='"+mEC+"' AND C.INSTITUTECODE='"+mIC+"' AND NVL(C.PRORATAMARKS,'N')='Y'    ) ";
//out.println(qry7);
ResultSet rs7=db.getRowset(qry7);
    while(rs7.next())
	{
//		out.print("UFM");
xx++;
if(xx==1)
		{
	%>
<TABLE WIDTH="80%" align=center rules=group  class="sort-table"   cellSpacing=1 cellPadding=1  border=1>
					<thead>
					<tr bgcolor="#ff8c00">


						<td ><Font color=white><b>Student Name</b></font></td>
						<td ><Font color=white><b>Enrollment No.</b></font></td>
<td ><Font color=white><b>Event Sub-Event</b></font></td>
<td ><Font color=white><b>Marks</b></font></td>

<td ><Font color=white><b>Type</b></font></td>
					</tr>
					</thead>
					<tbody>
<%

		}



 qry="Select 'Y' From StudentEventSubjectMarks Where FSTID='"+rs7.getString("fstid")+"' and EVENTSUBEVENT='"+rs7.getString("PEVENTSUBEVENT")+"' and STUDENTID='"+rs7.getString("studentid")+"'";
                //System.out.println(qry);
                rs=db.getRowset(qry);
                if(rs.next())
					{

					qry="Update StudentEventSubjectMarks set MARKSAWARDED1=0, MARKSAWARDED2=0, DETAINED='U' Where FSTID='"+rs7.getString("fstid")+"' and EVENTSUBEVENT='"+rs7.getString("PEVENTSUBEVENT")+"' and STUDENTID='"+rs7.getString("studentid")+"'";
				//	out.println(qry);
					db.update(qry);
					int Upd22=db.update(qry);

	if(Upd22>0)
	 {
						//out.print
						%>
						<tr>
						<td><%=rs7.getString("studentname")%> </td>
					    <td><%=rs7.getString("ENROLLMENTNO")%> </td>
						<td><%=rs7.getString("PEVENTSUBEVENT")%> </td>
						<td>0 </td>
						<td><font color=red size=2>UFM Marks </font> </td>
						</tr>

	<%
	}
	}
	}



//out.println("After All Options");

//prorata Student detail




qry1="SELECT distinct b.studentname,b.ENROLLMENTNO, nvl(a.EVENTSUBEVENT,'N') PEVENTSUBEVENT,  B.WEIGHTAGE WEIGHTAGE,A.PRORATA,b.EVENTSUBEVENT, b.STUDENTID,b.FSTID FROM DEBARSTUDENTDETAIL A,V#STUDENTEVENTSUBJECTMARKS b WHERE   a.STUDENTID=b.STUDENTID and a.FSTID=b.FSTID and b.EXAMCODE='"+mEC+"' AND NVL(A.PRORATA,'N')='Y'  and b.INSTITUTECODE='"+mIC+"' and b.EVENTSUBEVENT='"+mEventsubevent+"'   and b.subjectid='"+mSC+"'  and a.INSTITUTECODE=b.INSTITUTECODE and a.EXAMCODE=b.EXAMCODE and a.EVENTSUBEVENT=b.EVENTSUBEVENT  AND B.EVENTSUBEVENT IN (SELECT  EXAMEVENTCODE FROM EXAMEVENTMASTER C  WHERE      C.EXAMCODE='"+mEC+"' AND C.INSTITUTECODE='"+mIC+"' AND NVL(C.PRORATAMARKS,'N')='Y'    ) ";

//out.println(qry1);
rs6=db.getRowset(qry1);
               while(rs6.next())
			{

					//out.print("Prorata");
	//	System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKK");

					mDebarProrata=1;
					mProrataWeightage=rs6.getDouble("WEIGHTAGE");
					mProrataEvent=rs6.getString("PEVENTSUBEVENT");

//	System.out.println("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
			//sum of prorata marks 		MARKSAWARDED1 except TA

			qry2="Select sum(MARKSAWARDED1)SUMMARKSAWARDED1 ";
		    qry2=qry2+"  from V#STUDENTEVENTSUBJECTMARKS ";
		    qry2=qry2+" where  EVENTSUBEVENT<>'"+mProrataEvent+"'  and INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry2=qry2+"   EVENTSUBEVENT not like '%TA%'  ";
		    qry2=qry2+" AND  fstid='"+rs6.getString("fstid")+"' and STUDENTID='"+rs6.getString("studentid")+"' ";
	//	out.println(qry2);
		    rs4=db.getRowset(qry2);
                if(rs4.next())
                {
                    mSProrataMarks = rs4.getDouble("SUMMARKSAWARDED1");
				}
                else
                {
                    mSProrataMarks = 0;
                }

//sum of WEIGHTAGE EXCEPT	prorata event
			qry3="Select sum(WEIGHTAGE)SUMWEIGHTAGE ";
		    qry3=qry3+"  from V#STUDENTEVENTSUBJECTMARKS ";
		    qry3=qry3+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry3=qry3+"   EVENTSUBEVENT not like '%TA%'  ";
		    qry3=qry3+" AND fstid='"+rs6.getString("fstid")+"' and STUDENTID='"+rs6.getString("studentid")+"' ";
		//	out.println("<bR>ooooooooooooooooooooooooooooooooooooooooooooooooo"+qry3);
		    rs3=db.getRowset(qry3);
                if(rs3.next())
                {
                    mSWeight = rs3.getDouble("SUMWEIGHTAGE");
				}
                else
                {
                    mSWeight = 0;
                }

//sum of WEIGHTAGE mSWeight(T1+T2) + (Prorata Event) mProrataWeightage(T3)
mTotWeig= mSWeight-mProrataWeightage;

//System.out.println("<br><br>"+mSProrataMarks+"mSProrataMarks"+mTotWeig+"mTotWeig"+mProrataWeightage+"mProrataWeightage"+mSWeight);
//Formula of Averagge marks

mSumMarksProrata=((mSProrataMarks/mTotWeig)*100);

//Formula of Total marks to be assigned

mProrataTotalMarks=((mSumMarksProrata/100)*mProrataWeightage);

//System.out.println(mProrataTotalMarks+"mSMarksProrata"+mSumMarksProrata);

mSMarks=Double.toString((mProrataTotalMarks));
//System.out.println(mProrataTotalMarks+"mSMarksProrata"+mSumMarksProrata+"mSMarks"+mSMarks);
//out.println(mProrataTotalMarks+"mSMarksProrata"+mSumMarksProrata+"mSMarks"+mSMarks);
//mSMarks=mProrataTotalMarks;


 qry="Select 'Y' From StudentEventSubjectMarks Where FSTID='"+rs6.getString("fstid")+"' and EVENTSUBEVENT='"+mProrataEvent+"' and STUDENTID='"+rs6.getString("studentid")+"'";
                //System.out.println(qry);
                rs=db.getRowset(qry);
                if(!rs.next())
				{
					qry = "Insert Into StudentEventSubjectMarks (FSTID, EVENTSUBEVENT, STUDENTID, MARKSAWARDED1, MARKSAWARDED2, DETAINED, LOCKED, ENTRYDATE, ENTRYBY, DEACTIVE, DETAINED2,PRORATA) VALUES (";
					qry += "'" + rs6.getString("fstid") + "',";
					qry += "'" + mProrataEvent + "',";
					qry += "'" + rs6.getString("studentid") + "',";
					qry += "'" + mSMarks + "',";
					qry += "'" + mSMarks + "',";
					qry += "'" + mDetained + "',";
					qry += "'N',";
					qry += "sysdate,";
					qry += "'" + mDMemberID + "',";
					qry += "'N',";
					qry += "'" + mDetained + "','Y' ";
					qry += ") ";
					//out.println(qry);
					int Ins1=db.insertRow(qry);

				}
				else
				{

				qry="Update StudentEventSubjectMarks set MARKSAWARDED1='"+mSMarks+"', MARKSAWARDED2='"+mSMarks+"', DETAINED='"+mDetained+"', DETAINED2='"+mDetained+"', PRORATA='Y' Where FSTID='"+rs6.getString("fstid")+"' and EVENTSUBEVENT='"+mProrataEvent+"' and STUDENTID='"+rs6.getString("studentid")+"'";
				//out.println(qry);
				db.update(qry);
				int Upd1=db.update(qry);

				}


%>
						<tr>
						<td><%=rs6.getString("studentname")%></td>
						<td><%=rs6.getString("ENROLLMENTNO")%></td>
						<td><%=rs6.getString("PEVENTSUBEVENT")%></td>
<td><%=mSMarks%> </td>
<td><font color=black size=2>PRORATA Marks</font> </td>

						</tr>

<%
	}
String qry88="",qry99="";
ResultSet  rs88=null,rs99=null;
 double zWEIGHTAGE1=0;
/// <---- START MASSCUT

if(mIC.equals("JPBS")) {

qry88="SELECT   NVL (WEIGHTAGE, '0') WEIGHTAGE1  FROM   exameventmaster WHERE       institutecode = '"+mIC+"'        AND examcode = '"+mEC+"'         and nvl(MASSCUTSAPPLICABLE,'N')='Y' AND exameventcode LIKE '%TA%'  ";
rs88=db.getRowset(qry88);
//out.println(qry88);
if(rs88.next()){
			   //	out.print(qry88);
xWEIGHTAGE1=rs88.getDouble("WEIGHTAGE1");

			   }



qry11="SELECT   DISTINCT eventsubevent, NVL ( (WEIGHTAGE), '0') WEIGHTAGET    FROM   EXAMEVENTSUBJECTTAGGING b   WHERE       eventsubevent LIKE '%TA%'           AND NVL (published, 'N') = 'Y'           AND NVL (proceedsecond, 'N') = 'Y'                     AND entryby ='"+mDMemberID+"'           AND EXISTS                 (SELECT   'Y'                    FROM   v#studentltpdetail a                   WHERE       a.subjectid = '"+mSC+"'                           AND a.institutecode = '"+mIC+"'                           AND a.employeeid = '"+mDMemberID+"'                           AND a.examcode = '"+mEC+"'                           AND a.LTP <> 'T' and a.fstid=b.fstid ) GROUP BY   eventsubevent, WEIGHTAGE ";
 //out.println(qry11);

//out.println(qry11);


 //qry11="  SELECT  nvl(SUM (WEIGHTAGE),'0') WEIGHTAGET FROM   EXAMEVENTSUBJECTTAGGING WHERE       fstid  IN  ( SELECT distinct     b.FSTID FSTID  FROM    V#STUDENTEVENTSUBJECTMARKS b WHERE       b.EXAMCODE = '"+mEC+"'        AND b.INSTITUTECODE = '"+mIC+"'         AND b.subjectid ='"+mSC+"'        and employeeid='"+mDMemberID+"'         and LTP <> 'T' )       and eventsubevent LIKE  'TA#%'    AND NVL (published, 'N') = 'Y'         AND NVL (proceedsecond, 'N') = 'Y'         AND NVL (locked, 'N') = 'Y' ";

rs11=db.getRowset(qry11);
               while(rs11.next()){


zWEIGHTAGE1=zWEIGHTAGE1 + rs11.getDouble("WEIGHTAGET");

			   }

//out.print(zWEIGHTAGE1+"********"+xWEIGHTAGE1);

// out.println(zWEIGHTAGE1+"**11*"+xWEIGHTAGE1);
if(zWEIGHTAGE1==xWEIGHTAGE1   && xWEIGHTAGE1 >0  && zWEIGHTAGE1>0 ){


			      qry99="  SELECT distinct     b.FSTID FSTID  FROM    V#STUDENTEVENTSUBJECTMARKS b WHERE       b.EXAMCODE = '"+mEC+"'        AND b.INSTITUTECODE = '"+mIC+"'         AND b.subjectid ='"+mSC+"'        and employeeid='"+mDMemberID+"'         and LTP <> 'T' ";
rs99=db.getRowset(qry99);
//out.println(qry99+"***");
               while(rs99.next()){








/// qry22=" SELECT    DISTINCT b.studentname,    b.studentid,   b.ENROLLMENTNO,     B.WEIGHTAGE WEIGHTAGE,   b.EVENTSUBEVENT,         b.STUDENTID,                   b.FSTID ,  b.semester semester FROM    V#STUDENTEVENTSUBJECTMARKS b  WHERE       b.EXAMCODE = '"+mEC+"'        AND b.INSTITUTECODE =  '"+mIC+"'         AND b.subjectid = '"+mSC+"'          and employeeid='"+mDMemberID+"'         and LTP <> 'T'         and fstid=  '"+rs99.getString("FSTID")+"' ";
//rs22=db.getRowset(qry22);
//out.println(qry22+"***");
//while(rs22.next()){



//mSem1=rs22.getString("semester");


/// Start of masscut


qry2="select  a.SEMESTER SEMESTER ,a.fstid,b.ltp, a.institutecode,a.ExamCode,NVL( A.SEMESTER,0)SEMESTER,a.semestertype,a.subjectID,a.studentid studentid,";
qry2=qry2+" a.enrollmentno,NVL ( ceil(sum((a.marksawarded2/a.maxmarks)*b.weightage)),0)marksawarded2, ";
qry2=qry2+" a.studentname,NVL(sum(b.weightage),0)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in('"+rs99.getString("FSTID")+"') ";
//qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
//qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
//qry2=qry2+" institutecode='"+mInst+"' and nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mEC+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSC+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid  AND A.STUDENTID NOT IN   (SELECT STUDENTID FROM DEBARSTUDENTDETAIL WHERE EXAMCODE='"+mEC+"' AND NVL(MEDICALWITHDRAWAL,'N')='Y')";
qry2=qry2+" group by  a.SEMESTER , a.fstid ,b.ltp, a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname";
rs2=db.getRowset(qry2);
 // I M HERE
 // System.out.println(qry2);
String sname="";
while(rs2.next())
    {
	ctr=ctr++;
	mL=0; xL=0;
	mSem1=rs2.getString("semester");
	mMarksawarded2=rs2.getDouble("marksawarded2");
	Studid=rs2.getString("studentid");
	mLTP="L','T";
	mFSTIDD=rs2.getString("fstid");

 //Start Attendance calculation JPBS

qry=" Select nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE , nvl(to_char(REGCONFIRMATIONDATE,'yyyymmdd'),' ') REGCONFIRMATIONDATE1  ,ACADEMICYEAR  From StudentRegistration Where INSTITUTECODE='"+mInst+"'";
qry=qry+" AND EXAMCODE='"+mEC+"'";
//qry=qry+"   AND NVL(SEMESTERTYPE,' ')='REG'"; updtae by mohit 10/18/2013
qry=qry+" AND STUDENTID='"+Studid+"'";
//qry=qry+" AND ACADEMICYEAR='"+rs2.getString("ACADEMICYEAR")+"'";
 //  out.print(qry);
rsBatchDate=db.getRowset(qry);
if(rsBatchDate.next())
{

mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
mAcademicYeay=rsBatchDate.getString("ACADEMICYEAR");
}
else
{
mREGCONFIRMATIONDATE="";
}


qry1="select  LTP,fstid from V#StudentLTPDetail a where SubjectID= '"+mSC+"' and EXAMCODE= '"+mEC+"' AND INSTITUTECODE='"+mInst+"' and a.studentid='"+Studid+"' and a.ltp  IN ('"+mLTP+"') group by LTP,fstid";


rs1=db.getRowset(qry1);
if(rs1.next())
{
mLFSTID=rs1.getString("fstid");
}


qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+mSC+"' and EXAMCODE= '"+mEC+"' AND  a.LTP  IN ('"+mLTP+"') ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"' and a.studentid='"+Studid+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+mSC+"' and EXAMCODE= '"+mEC+"'  AND  a.LTP  IN ('"+mLTP+"') and INSTITUTECODE='"+mInst+"' and a.studentid='"+Studid+"' ) ";

rs1=db.getRowset(qry1);
if(rs1.next())
{
prevLFSTID=rs1.getString("fstid");
}




long mNotAttendedAttendance=0;


// Process for L Type
mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select distinct  CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSC+"'  and LTP  IN ('"+mLTP+"') and EXAMCODE= '"+mEC+"'  AND  ( A.FSTID='"+mLFSTID+"'   OR (A.FSTID  IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+mEC+"' and b.institutecode='"+mInst+"' and b.SUBJECTID='"+mSC+"' and  b.LTP  IN ('"+mLTP+"') and b.FSTID='"+mLFSTID+"')))  ";
qry=qry+" and (("+mSem1+">1) or ("+mSem1+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+Studid+"' ";
qry=qry+" and trunc(a.classtimefrom)<  NVL((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+Studid+"' and c.SubjectID= '"+mSC+"'  and c.LTP  IN ('"+mLTP+"') and c.EXAMCODE= '"+mEC+"' and c.institutecode='"+mInst+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mInst+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  NVL((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+Studid+"' and  c.SubjectID= '"+mSC+"'  and c.LTP  IN ('"+mLTP+"') and c.EXAMCODE= '"+mEC+"' and c.institutecode='"+mInst+"' ),a.classtimefrom) ";
qry=qry+" and (('"+mSem1+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+mSem1+">1)        )   )";
 //out.print(qry);
//if(mSID.equals("J1281100708"))
//   out.print(qry);
rs1=db.getRowset(qry);

//out.print(qry);
if(rs1.next())
{
mNotAttendedAttendance=rs1.getLong("pcount");

}

qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSC+"'  and LTP  IN ('"+mLTP+"') and EXAMCODE=  '"+mEC+"' ";
qry=qry+"  AND  A.FSTID='"+prevLFSTID+"'   and INSTITUTECODE='"+mInst+"'   and a.studentid<>'"+Studid+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+Studid+"' and c.SubjectID= '"+mSC+"'  and c.LTP  IN ('"+mLTP+"') and c.EXAMCODE= '"+mEC+"' and c.institutecode='"+mInst+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSC+"' and c.studentid='"+Studid+"' ";
qry=qry+"  and c.LTP  IN ('"+mLTP+"') and c.EXAMCODE=  '"+mEC+"' and c.institutecode='"+mInst+"'   and c.fstid='"+prevLFSTID+"' ) ";

qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+mSem1+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+mSem1+">1) ) ";

//if(mSID.equals("J1281100708"))
   // out.print(qry);
rs1=db.getRowset(qry);

if(rs1.next())
{
mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");

}


qry1="SELECT   count(pcount ) pcount FROM (select distinct  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSC+"' and EXAMCODE= '"+mEC+"' AND  a.ltp  IN ('"+mLTP+"') and a.studentid='"+Studid+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+mSem1+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+mSem1+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select   distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSC+"'     AND ltp   IN ('"+mLTP+"')    ";
qry1=qry1+" AND examcode =  '"+mEC+"'   AND studentid = '"+Studid+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+mSem1+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+mSem1+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"'  )";
//if(mSID.equals("J1281100708"))
  // out.print(qry1);



rs1=db.getRowset(qry1);
if(rs1.next())
{
mL=rs1.getLong("pcount");

}
mL=mL+mNotAttendedAttendance;
//out.println(mL+"*********************1");


//Special For L

qry1="SELECT   count(pcount ) pcount,to_Char(CLASSTIMEFROM,'dd-mm-yyyy') CLASSTIMEFROMX FROM (select distinct CLASSTIMEFROM,  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSC+"' and EXAMCODE= '"+mEC+"' AND  a.ltp  IN ('"+mLTP+"') and a.studentid='"+Studid+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+mSem1+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+mSem1+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select   distinct CLASSTIMEFROM, CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSC+"'     AND ltp   IN ('"+mLTP+"')    ";
qry1=qry1+" AND examcode =  '"+mEC+"'   AND studentid = '"+Studid+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+mSem1+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+mSem1+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"'  ) group by CLASSTIMEFROM ,pcount";
//if(mSID.equals("J1281100708"))
   //out.print(qry1);





rs1=db.getRowset(qry1);
while(rs1.next())
{
	qertu=" select 'Y' from ATTENDANCESPECIALAPPROVAL where INSTITUTECODE ='"+mInst+"'  and EXAMCODE ='"+mEC+"' and SUBJECTID ='"+mSC+"' and STUDENTID ='"+Studid+"'  and  ((TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') BETWEEN FROMPERIOD AND TOPERIOD ) OR (TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')                BETWEEN FROMPERIOD AND TOPERIOD ) OR (FROMPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')) OR (TOPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')))      ";


rsqertu=db.getRowset(qertu);
 //out.println(qertu+"**");
if(rsqertu.next()){


	xL++;
}

}


mL=mL-xL;










qry1="SELECT   count(pcount ) pcount FROM (select distinct   CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSC+"' and EXAMCODE= '"+mEC+"' AND   a.ltp IN ('L','T') and a.studentid='"+Studid+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+mSem1+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+mSem1+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSC+"'     AND ltp IN ('L','T')    ";
qry1=qry1+" AND examcode =  '"+mEC+"'   AND studentid = '"+Studid+"' and nvl(present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+mSem1+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+mSem1+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"' )";
//if(mMemberID.equals("J1281100708"))
 //out.print(qry1);;
rs1=db.getRowset(qry1);

if(rs1.next())
{
mLP=rs1.getLong("pcount");
}

//out.print(mL+" ::mL "+mLP);


// ------------------------------ Special Approval attendance -----------------------
 qryspe="SELECT  nvl(NOOFDAYS,0)NOOFDAYS  FROM AttendanceSpecialApproval A  WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE= '"+mEC+"' AND A.STUDENTID= '"+Studid+"'  AND A.SUBJECTID='"+mSC+"' ";

//out.print(qryspe);
rse=db.getRowset(qryspe);
if(rse.next())
		 {


		mSpecial="Special Approval";
		 }
		 else
	 {
		 	mSpecial="";
		 }




//out.println(mLP+"*********"+mL);
if(mL!=0 && mLP!=0)
	{
mPercL=Math.ceil(((mLP*100)/mL));
	}


	if(mPercL>100){
	mPercL=100;
	}else{

	mPercL=mPercL;
	}

//if(Studid.equals("00021300191")){
 //out.println(Studid+"*******"+mFSTIDD+"*****"+xL+"*******"+mLP+"******"+ctr+"********"+mPercL+"*****"+mL);
//}
///End of attendancecalculation jPBS

///start of masscut

qrys="SELECT  distinct nvl(b.academicyear,'N')academicyear ,A.EXAMEVENTCODE,nvl(A.MASSCUTSAPPLICABLE,'N')MASSCUTSAPPLICABLE,NVL(A.NEGATIVEMASSCUTSALLOWED,'N')NEGATIVEMASSCUTSALLOWED ,nvl(b.MASSCUTS,0)MASSCUTS,nvl(b.typeofaction,' ')typeofaction  FROM EXAMEVENTMASTER A,MASSCUTSCRITERIA B,V#STUDENTEVENTSUBJECTMARKS c WHERE                         A.EXAMCODE='"+mEC+"'  and b.EXAMCODE=c.EXAMCODE and a.EXAMCODE=c.EXAMCODE and c.STUDENTID='"+Studid+"'  and a.INSTITUTECODE=c.INSTITUTECODE and nvl(c.DEACTIVE,'N')='N' AND A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE=B.EXAMCODE AND A.EXAMEVENTCODE=B.EXAMEVENTCODE and a.INSTITUTECODE=b.INSTITUTECODE     and TO_NUMBER ("+mPercL+") between TO_NUMBER (b.attendancepercentagefrom) and  TO_NUMBER (b.attendancepercentageto)  and nvl(b.TYPEOFACTION,'N')='-' AND C.PROGRAMCODE NOT IN('PHD','PHDP','PHDS') ";
qrys=qrys+"  and nvl(b.MASSCUTS,0) > 0  AND b.ACADEMICYEAR='"+mAcademicYeay+"' and b.academicyear=c.academicyear";
//and EXAMEVENTCODE='"+cccc+"' ";
//System.out.println(qrys+"MASSCUT");
rss=db.getRowset(qrys);
if(rss.next())
{

mTypeofaction=rss.getString("typeofaction").toString().trim();


//out.print(mTotalMarksAdd+" :: mTotalMarksAdd :: "+mNetMarks + ": mFinalMarks1 :"+mFinalMarks1 +" :: mTATotalMarks : "+mTATotalMarks  );

if(rss.getString("MASSCUTSAPPLICABLE").equals("Y") && rss.getString("NEGATIVEMASSCUTSALLOWED").equals("Y") && mTypeofaction.equals("-"))
{

mMassCutMarks=rss.getDouble("masscuts");

//out.print(rs2.getString("enrollmentno")+"LLL"+mMarksAdd+"sdfsdf"+AcadYear+"KKKKKKKKKKK"+rss.getString("academicyear")+"PP"+mTypeofaction);

//CALCULATION

if(mMassCutMarks!=0 )
{
mNetMarks=mTATotalMarks-mMassCutMarks;
}



if(mMassCutMarks > (mTATotalMarks+mMarksAdd) )
{
mNetMarks=0;
}
else
{
mNetMarks=(mTATotalMarks+mMarksAdd)-mMassCutMarks;
}


}
}
else
{
mMassCutMarks=0;
//  mNetMarks=mTATotalMarks ;
}
//end of masscut
mMarksawarded2=mMarksawarded2-mMassCutMarks;
//end masscut
	//debar students
	//int DRejected=0;
qry1=" select distinct NVL(A.GRADE,'N')GRADE from DEBARSTUDENTDETAIL a  WHERE a.EXAMCODE='"+mEC+"'   and a.INSTITUTECODE='"+mInst+"' and a.STUDENTID='"+Studid+"' AND A.SUBJECTID='"+mSC+"' and  NVL(A.PRORATA,'N')='N' AND nvl(a.DEACTIVE,'N')='N' AND (NVL(A.MEDICALCASE,'Y')='Y'   OR  NVL(A.ABSENTCASE,'N')='N' OR NVL(A.UFM,'N')='N' OR NVL (a.DEBAR, 'N') = 'Y' ) AND A.GRADE IS NOT NULL ";
/// out.print(qry1);
rs1=db.getRowset(qry1);
if(rs1.next())
{
DRejected++;
Rejected++;
mDebarGrade=rs1.getString("GRADE");
StudentGradeCalculationMarksAwarded1=mMarksawarded2;
}
else
{
mDebarGrade="N";
StudentGradeCalculationMarksAwarded1=mMarksawarded2;
}

//int DERejected=0;
	qry3="select DECODE(NVL(DETAINED,'N'),'D',1,'A',2,3),nvl(Detained,'N')Detained,enrollmentno  from V#STUDENTEVENTSUBJECTMARKS where institutecode='"+mInst+"' ";
	qry3=qry3+" and examcode='"+mEC+"' and subjectID='"+mSC+"' and ";
	qry3=qry3+" studentid='"+Studid+"' and nvl(LOCKED,'N')='Y' ";
	// qry3=qry3+" and nvl(DETAINED,'N')<>'N' and RowNum=1 ";
	qry3=qry3+" and nvl(DETAINED,'N') in ('D','A','M') ORDER BY 1";
// out.print("Detained"+qry3);
	rs3=db.getRowset(qry3);

	if(rs3.next())
		{



			mDetained=rs3.getString("Detained");
			/*
			mDetained=mDetained+rs3.getString(2);
		//out.print(mDetained+"=="+mDetained+"<br>");
			mDetained=rs3.getString("Detained");
			*/





			if(mDetained.equals("D"))
			{
				//Rejected++;
				DERejected++;
//out.print("rer"+Rejected);

				StudentGradeCalculationMarksAwarded1=mMarksawarded2;
			}
			else
			{
				if(mDetained.equals("A"))
				{
				StudentGradeCalculationMarksAwarded1=mMarksawarded2;
				}
			}
			if(mDetained.equals("M"))
			{
					qry4="select nvl(ParameterValue,0)ParameterValue  from Parameters where CompanyCode='JIIT' ";
					qry4=qry4+" and ModuleName='SIS' and ParameterID='C1.3' and ";
					qry4=qry4+" RowNum=1 ";
					rs4=db.getRowset(qry4);
					if(rs4.next())
					{
						mLimit=rs4.getDouble(1);

						if(mMarksawarded2>mLimit)
						{
							mLimit=mLimit;
						}
						else
						{
							mLimit=mMarksawarded2;
						}
					} // closing of rs4
					else
					{
						mLimit=mMarksawarded2;
					}

					StudentGradeCalculationMarksAwarded1=mLimit;

			}  // closing of mDeatined 'M'
		} // CLOSING OF IF
		else
		{



			mDetained="N";
			StudentGradeCalculationMarksAwarded1=mMarksawarded2;

		}
//- -------------------------Masscuts
//StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1-MassCuts;
//StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1-0;
// *****************************************


if(StudentGradeCalculationMarks<0){
StudentGradeCalculationMarks=0;

}else{

StudentGradeCalculationMarks=StudentGradeCalculationMarks;
}

	mStudentMean=mGlobalMean-StudentGradeCalculationMarksAwarded1;
	mStudentMeanSum=mStudentMean*mStudentMean;
	mStudentGradeCalculationMean=mStudentGradeCalculationMean+mStudentMeanSum;
//out.print(mStudentMean+":mStudentMean:"+mCount1+"<BR>"+mStudentMeanSum+":mStudentMeanSum:"+":mStudentGradeCalculationMean:"+mStudentGradeCalculationMean+"<BR>");

//Start masscut old

qrytat="   select nvl( sum(MARKSAWARDED2),'0') TATOTAL from v#studenteventsubjectmarks where fstid='"+mFSTIDD+"' and studentid ='"+Studid+"'  and eventsubevent  LIKE '%TA%'  and EXAMCODE='"+mEC+"'  ";
rstat=db.getRowset(qrytat);
//out.println(qrytat);
if(rstat.next())
{
	//out.println(mTATTOTAL+"****&&***"+k);
mTATTOTAL=rstat.getDouble("TATOTAL");
}else {
mTATTOTAL=0;
}
//out.println(mTATTOTAL+"*******"+k);


if (mTATTOTAL<mMassCutMarks){

mMarksawarded2=(mMarksawarded2)+(mMassCutMarks-mTATTOTAL);

}
else{
mMarksawarded2=mMarksawarded2;
}

//out.println(mTATTOTAL+"*******"+k);
qryt="select 'Y' from STUDENTGRADEMASSCUTS where fstid='"+mFSTIDD+"'  and studentid='"+Studid+"' and INSTITUTECODE='"+mInst+"'   ";
//out.print(qryt);
rsst=db.getRowset(qryt);
//out.print(qryt);
if(!rsst.next())
{
k++;
qryin="INSERT INTO STUDENTGRADEMASSCUTS (  EXAMCODE,INSTITUTECODE, FSTID, STUDENTID, MASSCUTS,    ENTRYDATE, ENTRYBY, DEACTIVE,    MARKSAWARDED,   ATTENDANCEPERCENTAGE ,TATOTAL) VALUES ( '"+mEC+"' ,'"+mInst+"','"+mFSTIDD +"' ,'"+Studid+"' ,'"+mMassCutMarks+"' ,sysdate    ,'"+mChkMemID+"' , 'N', '"+mMarksawarded2+"'   ,'"+mPercL+"'  ,'"+mTATTOTAL+"' ) ";
 //System.out.println(qryin);
 int Ins=db.insertRow(qryin);
}else{
k++;
qryin="UPDATE STUDENTGRADEMASSCUTS SET    MASSCUTS  = '"+mMassCutMarks+"' , MARKSAWARDED='"+mMarksawarded2+"' , EXAMCODE='"+mEC+"' , ATTENDANCEPERCENTAGE='"+mPercL+"',entrydate=sysdate ,TATOTAL='"+mTATTOTAL+"'  WHERE  FSTID = '"+mFSTIDD+"'  AND    STUDENTID  = '"+Studid+"'  ";
int Upd=db.update(qryin);
//System.out.println(qryin);
}
//out.print(mPercL+"***"+mMassCutMarks);
}

/// End of Masscut





//}










			  // }
			   }
			   }else{

 k=1;

}


if(k>0){



}else{
out.print("ERROR IN MASSCUT SECTION!!");
}


/// END MASSCUT

}


}
catch(Exception e)
{
	out.print(e);
}







		if (a>0)
		{

                    RequestDispatcher rd= request.getRequestDispatcher("../../ReconMarksEntryExcelGenerateServlet");
                     rd.forward(request, response);
			%>
			<br><hr><p><font color=Green size=4><ul>
			<li>Marks Entry For this Event-Subevent has been locked successfully!
			<li>Now you can not change students Marks or Detained/Absent status.
			<li>For any changes take a written permission from VC/Dean and then contact Registrar/Dy. Registrar.
			</ul></font><hr>
			<%
		}
	}
	else
	{
 		%><br><hr>
		<ul><font color=red size=4><li>Marks has not been locked yet.
		<li>You can change marks till the Event Date remains.
		<li>You are requested to lock/freeze Marks entry process otherwise Grade Entry process may face problem later.
		<%
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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	</font>	<br>	<br>	<br>	<br>
	<%
   }
//---------closing of session loop
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
//------------------try
}
catch(Exception e)
{
	// out.print("last catch"+qry);
}
%>
</body>
</html>

