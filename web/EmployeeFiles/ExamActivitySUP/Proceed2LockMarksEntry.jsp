<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mDesg="",mDept="",mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDMemberID="";
String mEC="",mSemester="",mStudentid="",mComp="", mInst="",mEventsubevent="";
String mExam="",mSC="",mSubject="",mSID="",mProceed="",mProrataEvent="",mSMarks="",mDetained ="";
        
		  ResultSet rs = null, rs1=null, rs2=null,rs3=null,rs6=null,rs4=null;
     
String  mIC="";

	String qry = "",qry2="",qry1="",qry3="";
String mself="";

		double  	mDebarProrata=0,mTotWeig=0;
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

	qry="Select WEBKIOSK.ShowLink('60','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
  qry=qry+" where A.institutecode='"+mIC+"' and A.EVENTSUBEVENT='"+mEventsubevent+"' and nvl(A.PROCEEDSECOND,'N')='N' and nvl(A.locked,'N')='N' and nvl(A.PUBLISHED,'N')='N' and nvl(a.DEACTIVE,'N')='N' and ";
  qry=qry+" A.examcode='"+mEC+"' and (A.ltp='L' or (A.LTP='E' AND A.PROJECTSUBJECT='Y') OR A.LTP='P') and A.subjectID='"+mSC+"'";
// and A.employeeid='"+mDMemberID+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";
  qry=qry+" AND (A.fstid) in ((select fstid from facultysubjecttagging where examcode='"+mEC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N' AND (LTP='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') ";
  qry=qry+" UNION select A.fstid from FACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and FSTID in (select fstid from facultysubjecttagging where examcode='"+mEC+"' AND subjectID='"+mSC+"'))";
  if(!mself.equals("Self"))
  {
	qry=qry+" UNION select A.fstid from EX#SUBJECTGRADECOORDINATOR where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mDMemberID+"' and FSTID in (select fstid from facultysubjecttagging where examcode='"+mEC+"' AND subjectID='"+mSC+"')";
  }
  qry=qry+") and not exists (select 'y' from V#STUDENTEVENTSUBJECTMARKS b where a.fstid=b.fstid and a.studentid=b.studentid and a.EVENTSUBEVENT=b.EVENTSUBEVENT and (nvl(detained,'N')='D' or nvl(detained,'N')='A' or nvl(marksawarded1,-1)>=0 )) order by enrollmentno ";


if(mself.equals("Self"))
{
	qry1="select distinct A.fstid,nvl(A.studentid,' ')studentid,nvl(A.studentname,' ')studentname, ";
	qry1=qry1+" nvl(A.enrollmentno,' ')enrollmentno,nvl(A.semester,0)semester,A.subsectioncode, ";
	qry1=qry1+" nvl(A.programcode,' ')programcode,nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a";
	qry1=qry1+" where a.institutecode='"+mIC+"' and nvl(a.DEACTIVE,'N')='N' and nvl(a.PROCEEDSECOND,'N')='N' and nvl(a.locked,'N')='N' and nvl(a.PUBLISHED,'N')='N' and ";
	qry1=qry1+" a.examcode='"+mEC+"' and (a.ltp='L' OR (a.LTP='E' AND a.PROJECTSUBJECT='Y') OR a.LTP='P' ) and a.subjectID='"+mSC+"' ";
	qry1=qry1+" AND ((a.EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual)) OR (a.fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mIC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E'))";
	qry1=qry1+" AND a.EVENTSUBEVENT='"+mEventsubevent+"' " ;
	qry1=qry1+" and not exists (select 'y' from V#STUDENTEVENTSUBJECTMARKS b where a.fstid=b.fstid and a.studentid=b.studentid and a.EVENTSUBEVENT=b.EVENTSUBEVENT and (nvl(detained,'N')='D'       OR  NVL (detained, 'N') = 'U'                            OR NVL (detained, 'N') = 'M'              or nvl(detained,'N')='A' or nvl(marksawarded1,-1)>=0 ))";
	qry1=qry1+" GROUP BY a.fstid, a.studentid, a.StudentName, a.enrollmentno, a.Semester, a.programcode, a.SECTIONBRANCH, a.subsectioncode";
	qry1=qry1+" order by enrollmentno";
}
else if(!mself.equals("Self"))
{
	qry1="select distinct A.fstid,nvl(A.studentid,' ')studentid,nvl(A.studentname,' ')studentname, ";
	qry1=qry1+" nvl(A.enrollmentno,' ')enrollmentno,nvl(A.semester,0)semester,A.subsectioncode, ";
	qry1=qry1+" nvl(A.programcode,' ')programcode,nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a";
	qry1=qry1+" where a.institutecode='"+mIC+"' and nvl(a.DEACTIVE,'N')='N' and nvl(a.PROCEEDSECOND,'N')='N' and nvl(a.locked,'N')='N' and nvl(a.PUBLISHED,'N')='N' and ";
	qry1=qry1+" a.examcode='"+mEC+"'  and (a.ltp='L' OR (a.LTP='E' AND a.PROJECTSUBJECT='Y') OR a.LTP='P' ) and a.subjectID='"+mSC+"' ";
	qry1=qry1+" And a.EVENTSUBEVENT='"+mEventsubevent+"' " ;
	qry1=qry1+" AND a.FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mDMemberID+"')";
	qry1=qry1+" and not exists (select 'y' from V#STUDENTEVENTSUBJECTMARKS b where a.fstid=b.fstid and a.studentid=b.studentid and a.EVENTSUBEVENT=b.EVENTSUBEVENT and (nvl(detained,'N')='D'                             OR  NVL (detained, 'N') = 'U'                            OR NVL (detained, 'N') = 'M'                       or nvl(detained,'N')='A' or nvl(marksawarded1,-1)>=0 ))";
	qry1=qry1+" GROUP BY a.fstid, a.studentid, a.StudentName, a.enrollmentno, a.Semester, a.programcode, a.SECTIONBRANCH, a.subsectioncode";
	qry1=qry1+" order by enrollmentno";
}
//System.out.println("JILIT - "+qry1);
//out.println("JILIT - "+qry1);


  rs=db.getRowset(qry1);
// out.print(qry1);
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
		<table border=1 align=center rules='rows' width=75%>
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
	<tr><td colspan=3 align=center><a href='MarksEntryGridVersion.jsp'><font color=blue><b>Continue with Marks Entry</b></font></a></td></tr>
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
String qry7="SELECT distinct  b.studentname,b.ENROLLMENTNO, nvl(a.EVENTSUBEVENT,'N') PEVENTSUBEVENT,  B.WEIGHTAGE WEIGHTAGE,A.PRORATA,b.EVENTSUBEVENT, b.STUDENTID,b.FSTID FROM DEBARSTUDENTDETAIL A,V#STUDENTEVENTSUBJECTMARKS b WHERE   a.STUDENTID=b.STUDENTID and a.FSTID=b.FSTID and b.EXAMCODE='"+mEC+"' AND NVL(A.UFMMARKS,'N')='Y'  and b.INSTITUTECODE='"+mIC+"'   and b.subjectid='"+mSC+"'  and a.INSTITUTECODE=b.INSTITUTECODE and a.EXAMCODE=b.EXAMCODE and a.EVENTSUBEVENT=b.EVENTSUBEVENT  AND B.EVENTSUBEVENT IN (SELECT  EXAMEVENTCODE FROM EXAMEVENTMASTER C  WHERE      C.EXAMCODE='"+mEC+"' AND C.INSTITUTECODE='"+mIC+"' AND NVL(C.PRORATAMARKS,'N')='Y'    ) ";
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




qry1="SELECT distinct b.studentname,b.ENROLLMENTNO, nvl(a.EVENTSUBEVENT,'N') PEVENTSUBEVENT,  B.WEIGHTAGE WEIGHTAGE,A.PRORATA,b.EVENTSUBEVENT, b.STUDENTID,b.FSTID FROM DEBARSTUDENTDETAIL A,V#STUDENTEVENTSUBJECTMARKS b WHERE   a.STUDENTID=b.STUDENTID and a.FSTID=b.FSTID and b.EXAMCODE='"+mEC+"' AND NVL(A.PRORATA,'N')='Y'  and b.INSTITUTECODE='"+mIC+"'   and b.subjectid='"+mSC+"'  and a.INSTITUTECODE=b.INSTITUTECODE and a.EXAMCODE=b.EXAMCODE and a.EVENTSUBEVENT=b.EVENTSUBEVENT  AND B.EVENTSUBEVENT IN (SELECT  EXAMEVENTCODE FROM EXAMEVENTMASTER C  WHERE      C.EXAMCODE='"+mEC+"' AND C.INSTITUTECODE='"+mIC+"' AND NVL(C.PRORATAMARKS,'N')='Y'    ) ";
   
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
		    qry2=qry2+" AND fstid='"+rs6.getString("fstid")+"' and STUDENTID='"+rs6.getString("studentid")+"' ";
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

}
catch(Exception e)
{
	out.print(e);
}


		if (a>0)
		{
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

