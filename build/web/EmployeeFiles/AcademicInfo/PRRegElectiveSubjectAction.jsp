<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

ResultSet rs=null;
ResultSet rs1=null,rss=null,rsc=null,rse=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="",qrys="",qryc="",qrye="",qry2="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="",mInstitute="",mDMemberCode="",mWebEmail="",mSID="", mProg="",mAYear="";
String mComp="",mPCode="",mSubjectID="",mSecBranch="",mInst="",mDMemberID="",mDMemberType="",mExamID="";
int mSems=0;
int mFlag=0;
String mEarned="",mCGPA="",mSGPA="",mradio1="",mradio2="",mradio3="";
String mRadio1="",mRadio2="",mRadio3="",mName1="",mName2="",mName3="",mName0="",mExam="";
String mEARNED="",mSEMESTER="",mSEMTYPE="";
int mSNo=1,mECount=0,mCCount=0,mSCount=0;
int  mTotalRec1 = 0,mTotalRec2 = 0,mTotalRec3 = 0;
String mApproved="";
String mExamCode="";
String mINSTITUTECODE="";
String mEmployeeID="";
String mPROGRAMCODE="";
String mSUBJECTCODE="",mSemester="",mSubjectType="",mSemType="";
String  mSTUDID="",mAYEAR="",mPCODE="",mSECTION="",mEXAMID="",mSUBID="",mSUBTYPE="",mSubjectRunning="",mTAGG="";			
String mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="",mName11="",mName12="",mName13="";
int kk=0;
int kk1=0;



String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Pre Reqest Approval Update Action ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<%

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
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

if (request.getParameter("ProCode")==null)
{
	mPCode="";
}
else
{
	mPCode=request.getParameter("ProCode").toString().trim();
}
if (request.getParameter("SubID")==null)
{
	mSubjectID="";
}
else
{
	mSubjectID=request.getParameter("SubID").toString().trim();
}
if (request.getParameter("Section")==null)
{
	mSecBranch="";
}
else
{
	mSecBranch=request.getParameter("Section").toString().trim();
} 

if (request.getParameter("ADYear")==null)
{
	mAYear="";
}
else
{
	mAYear=request.getParameter("ADYear").toString().trim();
} 

if (request.getParameter("Exam")==null)
{
	mExam="";
}
else
{
	mExam=request.getParameter("Exam").toString().trim();
}
if (request.getParameter("Semester")==null)
{
	mSemester="";
}
else
{
	mSemester=request.getParameter("Semester").toString().trim();
}
if (request.getParameter("SubjectType")==null)
{
	mSubjectType="";
}
else
{
	mSubjectType=request.getParameter("SubjectType").toString().trim();
}
if (request.getParameter("SemType")==null)
{
	mSemType="";
}
else
{
	mSemType=request.getParameter("SemType").toString().trim();
}

if (request.getParameter("INSTITUTECODE")==null)
{
	mInst="";
}
else
{
	mInst=request.getParameter("INSTITUTECODE").toString().trim();
}
%>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<!-- <center><font size=4>Update Elective Subjects </font></center> -->
<hr>

<%
try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	mDMemberID=enc.decode(mMemberID);
	mDMemberCode=enc.decode(mMemberCode);
	mDMemberType=enc.decode(mMemberType);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('114','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------

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
mINSTITUTECODE= request.getParameter("INSTITUTECODE");

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

//////
qry="Update PR#STUDENTSUBJECTCHOICE set CUSTOMFINALIZED='N' where subjectid='"+mSubjectID+"' and INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"' and PROGRAMCODE='"+mPCode+"' and  SECTIONBRANCH='"+mSecBranch+"' and ACADEMICYEAR='"+mAYear+"'  ";
		int q=db.update(qry);	
		if(q>0)
		{
			//out.println("Hogaya");	
		}
		else
		{
			//out.println("Nahi hu");	
		}

	
	

	if (request.getParameter("TotalRec1")!=null && Integer.parseInt(request.getParameter("TotalRec1").toString().trim())>0)
	{  //3
	mTotalRec1 =Integer.parseInt(request.getParameter("TotalRec1").toString().trim());
	
	
	for (kk=1;kk<=mTotalRec1 ;kk++)
	{
		    mName0="SCGPA_"+String.valueOf(kk).trim();
			mName1="Checked1_"+String.valueOf(kk).trim();
			
			mSubjectRunning="RUNNING_"+String.valueOf(kk).trim();
			
			mName2="Earned_"+String.valueOf(kk).trim();
			mName3="CGPA_"+String.valueOf(kk).trim();		
			mName4="StudentID_"+String.valueOf(kk).trim(); 
			mName5="ExamID_"+String.valueOf(kk).trim(); 
			mName6="Academic_"+String.valueOf(kk).trim(); 
			mName7="SubjectID_"+String.valueOf(kk).trim();
			mName8="Section_"+String.valueOf(kk).trim();
			mName9="ProgramCode_"+String.valueOf(kk).trim();
			
			mName10="SubjectType_"+String.valueOf(kk).trim();
			mName11="Semester_"+String.valueOf(kk).trim();
			mName12="SemType_"+String.valueOf(kk).trim();	
			mName13="Tagg_"+String.valueOf(kk).trim();
		try
		{
			
	
		if (request.getParameter(mName1)==null)
			{
				mApproved="N";
			}
			else
			{
				mApproved=request.getParameter(mName1).toString().trim();
			}


			if (request.getParameter(mName2)==null)
			{
				mEARNED="";
			}
			else
			{
				mEARNED=request.getParameter(mName2).toString().trim();
			}
		
			if (request.getParameter(mName0)==null)
			{
				mSGPA="";
			}
			else
			{
				mSGPA=request.getParameter(mName0).toString().trim();
			}

			if (request.getParameter(mName3)==null)
			{
				mCGPA="";
			}
			else
			{
				mCGPA=request.getParameter(mName3).toString().trim();
			}

		mSTUDID= request.getParameter(mName4).toString().trim();
		mEXAMID=request.getParameter(mName5).toString().trim();
		mAYEAR= request.getParameter(mName6).toString().trim();
		mSUBID=request.getParameter(mName7).toString().trim();
		mSECTION=request.getParameter(mName8).toString().trim();
		mPCODE= request.getParameter(mName9).toString().trim();

		mSUBTYPE= request.getParameter(mName10).toString().trim();
		mSEMESTER= request.getParameter(mName11).toString().trim();
		mSEMTYPE= request.getParameter(mName12).toString().trim();
		mTAGG=request.getParameter(mName13).toString().trim();

		}
		catch(Exception e)
		{
			//out.print(e);
		}
		
		

		
		//out.print(mApproved+" Approved "+mSubjectRunning);

//		!mSubjectRunning.equals(mApproved)

		if(mApproved.equals("Y") )
		{	
		
			if(!mEARNED.equals("") || !mSGPA.equals("") || !mCGPA.equals("") )
			{
				
				qry="select 'Y' from PR#CUSTOMEELECTIVEFINALIZATION A,PR#STUDENTSUBJECTCHOICE B where 	A.ACADEMICYEAR=B.ACADEMICYEAR AND A.PROGRAMCODE=B.PROGRAMCODE AND A.SECTIONBRANCH=B.SECTIONBRANCH AND A.EXAMCODE=B.EXAMCODE AND A.SEMESTER=B.SEMESTER AND A.SEMESTERTYPE=B.SEMESTERTYPE AND A.SUBJECTID=B.SUBJECTID 	AND			A.subjectid='"+mSubjectID+"' and A.INSTITUTECODE='"+mInst+"' and A.EXAMCODE='"+mExam+"' and A.PROGRAMCODE='"+mPCode+"' and  A.SECTIONBRANCH='"+mSecBranch+"' and A.ACADEMICYEAR='"+mAYear+"' and A.SEMESTER='"+mSemester+"' and A.SEMESTERTYPE='"+mSemType+"'";
	
				//out.print(qry+"<br>");
				rs=db.getRowset(qry);
				if(rs.next())	
				{
					qry="Update PR#STUDENTSUBJECTCHOICE set SUBJECTRUNNING='Y',CUSTOMFINALIZED='Y',FACULTYID='"+mMemberID+"' , FACULTYTYPE='"+mMemberType+"' where studentid='"+mSTUDID+"' and subjectid='"+mSUBID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and EXAMCODE='"+mEXAMID+"' and PROGRAMCODE='"+mPCODE+"' and  SECTIONBRANCH='"+mSECTION+"' and ACADEMICYEAR='"+mAYEAR+"' and SEMESTER='"+mSEMESTER+"' and SEMESTERTYPE='"+mSEMTYPE+"' AND SUBJECTTYPE='"+mSUBTYPE+"' AND TAGGINGFOR='"+mTAGG+"'  ";
					
					int n=db.update(qry);	

					qry2="Update PR#ELECTIVESUBJECTS  set SUBJECTRUNNING='Y',CUSTOMFINALIZED='Y' where  subjectid='"+mSUBID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and EXAMCODE='"+mEXAMID+"' and PROGRAMCODE='"+mPCODE+"' and  SECTIONBRANCH='"+mSECTION+"' and ACADEMICYEAR='"+mAYEAR+"' and SEMESTER='"+mSEMESTER+"'  AND TAGGINGFOR='"+mTAGG+"'  ";
	

					int r=db.update(qry2);
					//out.print(qry2);
					//out.print(qry);	
					if(!mEARNED.equals(""))
					{
						qry1="Update PR#CUSTOMEELECTIVEFINALIZATION set EARNEDCREDITVALUE='"+mEARNED+"',ENTRYDATE=Sysdate,ENTRYBY='"+mMemberID+"'  where  EXAMCODE='"+mEXAMID+"' and PROGRAMCODE='"+mPCODE+"' and  SECTIONBRANCH='"+mSECTION+"' and ACADEMICYEAR='"+mAYEAR+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and SEMESTER='"+mSEMESTER+"' and SEMESTERTYPE='"+mSEMTYPE+"' AND SUBJECTID='"+mSUBID+"' and SUBJECTTYPE='"+mSUBTYPE+"'  ";
					}
					else if(!mSGPA.equals(""))
					{
						qry1="Update PR#CUSTOMEELECTIVEFINALIZATION set SGPACRITERIAVALUE='"+mSGPA+"',ENTRYDATE=Sysdate,ENTRYBY='"+mMemberID+"' where  EXAMCODE='"+mEXAMID+"' and PROGRAMCODE='"+mPCODE+"' and  SECTIONBRANCH='"+mSECTION+"' and ACADEMICYEAR='"+mAYEAR+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and SEMESTER='"+mSEMESTER+"' and SEMESTERTYPE='"+mSEMTYPE+"' and SUBJECTID='"+mSUBID+"' AND SUBJECTTYPE='"+mSUBTYPE+"'  ";
					}
					else if(!mCGPA.equals(""))
					{
						qry1="Update PR#CUSTOMEELECTIVEFINALIZATION set CGPACRITERIAVALUE='"+mCGPA+"',ENTRYDATE=Sysdate,ENTRYBY='"+mMemberID+"' where  EXAMCODE='"+mEXAMID+"' and PROGRAMCODE='"+mPCODE+"' and  SECTIONBRANCH='"+mSECTION+"' and ACADEMICYEAR='"+mAYEAR+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and SEMESTER='"+mSEMESTER+"' and SEMESTERTYPE='"+mSEMTYPE+"' AND SUBJECTID='"+mSUBID+"' and SUBJECTTYPE='"+mSUBTYPE+"'  ";
					}
					int p=db.update(qry1);	
					//out.print(qry1);	
					if(n>0 || p>0 || r>0) 
					{				
						// Log Entry
						//-----------------
						db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"Elective Subject Choice by Student", "StudentRunnig,StudentID:"+mSTUDID+" ExamID:"+mEXAMID+"		SubjectID:"+mSUBID+" ProgramCode:"+mPCODE, "No MAC Address" , mIPAddress);
						mFlag=4;
					}
					else
					{
						mFlag=2;
					}

				}
				else
				{
					qry="Update PR#STUDENTSUBJECTCHOICE set SUBJECTRUNNING='Y',CUSTOMFINALIZED='Y',ENTRYDATE=Sysdate,FACULTYID='"+mMemberID+"' , FACULTYTYPE='"+mMemberType+"' where studentid='"+mSTUDID+"' and subjectid='"+mSUBID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and EXAMCODE='"+mEXAMID+"' and PROGRAMCODE='"+mPCODE+"' and  SECTIONBRANCH='"+mSECTION+"' and ACADEMICYEAR='"+mAYEAR+"' and SEMESTER='"+mSEMESTER+"' and SEMESTERTYPE='"+mSEMTYPE+"' AND SUBJECTTYPE='"+mSUBTYPE+"' AND TAGGINGFOR='"+mTAGG+"' ";
					
					int n=db.update(qry);	
					
					qry2="Update PR#ELECTIVESUBJECTS  set SUBJECTRUNNING='Y',CUSTOMFINALIZED='Y' where  subjectid='"+mSUBID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and EXAMCODE='"+mEXAMID+"' and PROGRAMCODE='"+mPCODE+"' and  SECTIONBRANCH='"+mSECTION+"' and ACADEMICYEAR='"+mAYEAR+"' and SEMESTER='"+mSEMESTER+"'  AND TAGGINGFOR='"+mTAGG+"'  ";
	
					int r=db.update(qry2);

					qry1="INSERT INTO PR#CUSTOMEELECTIVEFINALIZATION (INSTITUTECODE, EXAMCODE, ACADEMICYEAR,PROGRAMCODE,SECTIONBRANCH, SEMESTER, SEMESTERTYPE, SUBJECTID, SUBJECTTYPE, CGPACRITERIAVALUE, SGPACRITERIAVALUE, EARNEDCREDITVALUE, MINUMFAILEDSUBJECTS, FACULTYTYPE, FACULTYID, ENTRYDATE, ENTRYBY, DEACTIVE) VALUES ('"+mINSTITUTECODE+"' ,'"+mEXAMID+"' ,'"+mAYEAR+"' ,'"+mPCODE+"', '"+mSECTION+"', '"+mSEMESTER+"','"+mSEMTYPE+"','"+mSUBID+"' ,'"+mSUBTYPE+"' ,'"+mCGPA+"','"+mSGPA+"' ,'"+mEARNED+"' ,'','"+mMemberType+"' ,'"+mMemberID+"' ,Sysdate ,'"+mMemberID+"' ,'')";
					//out.println(qry1);
					int m=db.insertRow(qry1);
					if(m>0 || n>0 || r>0)
					{
						db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"Elective Subject Choice by Student", "StudentRunnig,StudentID:"+mSTUDID+" ExamID:"+mEXAMID+" SubjectID:"+mSUBID+" ProgramCode:"+mPCODE, "No MAC Address" , mIPAddress);
						mFlag=1;
						
					}
					else
					{
						mFlag=2;
					}
				}	
			}	
		}
		else  if (mApproved.equals("N") && !mSubjectRunning.equals(mApproved))  
//			
		{
			
			qry="Update PR#STUDENTSUBJECTCHOICE set CUSTOMFINALIZED='N',ENTRYDATE=Sysdate,FACULTYID='"+mMemberID+"' ,FACULTYTYPE='"+mMemberType+"' where studentid='"+mSTUDID+"' and subjectid='"+mSUBID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and EXAMCODE='"+mEXAMID+"' and PROGRAMCODE='"+mPCODE+"' and  SECTIONBRANCH='"+mSECTION+"' and ACADEMICYEAR='"+mAYEAR+"' and SEMESTER='"+mSEMESTER+"' and SEMESTERTYPE='"+mSEMTYPE+"' AND SUBJECTTYPE='"+mSUBTYPE+"' AND TAGGINGFOR='"+mTAGG+"' ";	
			
			int n=db.update(qry);	
			
			// Log Entry
		    //-----------------
			 db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"Elective Subject Choice by Student", "StudentRunnig,StudentID:"+mSTUDID +" ExamID:"+mEXAMID +" SubjectID:"+mSUBID +" ProgramCode:"+mPCODE, "No MAC Address" , mIPAddress);
			 mFlag=3;
			   //-----------------
		}
		
		}//End of For Loop
		
		if(mFlag==1)
		{	
			out.print("<CENTER><b><font size=4 face='Times' color='Green'>Students subject choice is Approved !</font></CENTER> <br>");	
			%>
			<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
			<tr bgcolor=ff8c00>
			<td NOWRAP><b>Student Name</b></td>
			<td NOWRAP><b>Subject Name</b></td>
			<td NOWRAP><b>Status</b></td>
			</tr>
			<%
				qry="SELECT A.STUDENTID STUDENTID,B.ENROLLMENTNO ENROLLMENTNO,B.STUDENTNAME STUDENTNAME,C.SUBJECT SUBJECT,C.SUBJECTCODE SUBJECTCODE,decode(A.CUSTOMFINALIZED,'Y','Approved','N','NotApproved','C','Custom')CUSTOMFINALIZED FROM PR#STUDENTSUBJECTCHOICE A,STUDENTMASTER B,SUBJECTMASTER C WHERE A.ACADEMICYEAR=B.ACADEMICYEAR AND A.STUDENTID=B.STUDENTID AND A.SUBJECTID=C.SUBJECTID AND A.EXAMCODE='"+mEXAMID+"' AND A.PROGRAMCODE='"+mPCode+"' AND A.SECTIONBRANCH='"+mSecBranch+"' AND A.ACADEMICYEAR='"+mAYear+"' AND A.SUBJECTID='"+mSubjectID+"' and A.INSTITUTECODE='"+mINSTITUTECODE+"' and NVL(A.DEACTIVE,'N')='N' AND A.SEMESTER='"+mSemester+"' and A.SUBJECTTYPE='"+mSubjectType+"' and A.SEMESTERTYPE='"+mSemType+"' AND  NVL(A.DEACTIVE,'N')='N'  order by CUSTOMFINALIZED  "; 
				
			//out.println("<BR>"+qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					%>
					<tr>
					<td NOWRAP><%=rs.getString("STUDENTNAME")%>-<%=rs.getString("ENROLLMENTNO")%></td>
					<td NOWRAP><%=rs.getString("SUBJECT")%>-<%=rs.getString("SUBJECTCODE")%></td>
					<td nowrap><%=rs.getString("CUSTOMFINALIZED")%></td>
					</tr>
					<%
				}
					%>
		</table>
		
		<br><br>
	<%	}
		else if(mFlag==2)
		{
			out.print("<CENTER><b><font size=4 face='Times' color='Green'>Error is There!!</font></CENTER> <br>");	
		}
		else if(mFlag==3)
		{
			out.print("<CENTER><b><font size=4 face='Times' color='Green'>Students subject choice is Not Approved !</font></CENTER> <br>");	
			%>
			<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
			<tr bgcolor=ff8c00>
			<td NOWRAP><b>Student Name</b></td>
			<td NOWRAP><b>Subject Name</b></td>
			<td NOWRAP><b>Status</b></td>
			</tr>
			<%
				qry="SELECT A.STUDENTID STUDENTID,B.ENROLLMENTNO ENROLLMENTNO,B.STUDENTNAME STUDENTNAME,C.SUBJECT SUBJECT,C.SUBJECTCODE SUBJECTCODE,decode(A.CUSTOMFINALIZED,'Y','Approved','N','NotApproved')CUSTOMFINALIZED FROM PR#STUDENTSUBJECTCHOICE A,STUDENTMASTER B,SUBJECTMASTER C WHERE A.ACADEMICYEAR=B.ACADEMICYEAR AND A.STUDENTID=B.STUDENTID AND A.SUBJECTID=C.SUBJECTID AND A.EXAMCODE='"+mEXAMID+"' AND A.PROGRAMCODE='"+mPCode+"' AND A.SECTIONBRANCH='"+mSecBranch+"' AND A.ACADEMICYEAR='"+mAYear+"' AND A.SUBJECTID='"+mSubjectID+"' and A.INSTITUTECODE='"+mINSTITUTECODE+"' and A.SEMESTER='"+mSemester+"' and A.SUBJECTTYPE='"+mSubjectType+"' and A.SEMESTERTYPE='"+mSemType+"' AND NVL(A.DEACTIVE,'N')='N'  order by CUSTOMFINALIZED "; 
				
				//out.println("<BR>"+qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					%>
					<tr>
					<td NOWRAP><%=rs.getString("STUDENTNAME")%>-<%=rs.getString("ENROLLMENTNO")%></td>
					<td NOWRAP><%=rs.getString("SUBJECT")%>-<%=rs.getString("SUBJECTCODE")%></td>
					<td NOWRAP><%=rs.getString("CUSTOMFINALIZED")%></td>
					</tr>
					<%
				}
				
		}
		else if(mFlag==4)
		{
			out.print("<CENTER><b><font size=4 face='Times' color='Green'>Students subject choice is Updated !</font></CENTER> <br>");	
			%>
			<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
			<tr bgcolor=ff8c00>
			<td><b>Student Name</b></td>
			<td><b>Subject Name</b></td>
			<td><b>Status</b></td>
			</tr>
			<%
				qry="SELECT A.STUDENTID STUDENTID,B.ENROLLMENTNO ENROLLMENTNO,B.STUDENTNAME STUDENTNAME,C.SUBJECT SUBJECT,C.SUBJECTCODE SUBJECTCODE,decode(A.CUSTOMFINALIZED,'Y','Approved','N','NotApproved','C','Custom')CUSTOMFINALIZED FROM PR#STUDENTSUBJECTCHOICE A,STUDENTMASTER B,SUBJECTMASTER C WHERE A.ACADEMICYEAR=B.ACADEMICYEAR AND A.STUDENTID=B.STUDENTID AND A.SUBJECTID=C.SUBJECTID AND A.EXAMCODE='"+mEXAMID+"' AND A.PROGRAMCODE='"+mPCode+"' AND A.SECTIONBRANCH='"+mSecBranch+"' AND A.ACADEMICYEAR='"+mAYear+"' AND A.SUBJECTID='"+mSubjectID+"' and A.INSTITUTECODE='"+mINSTITUTECODE+"' and NVL(A.DEACTIVE,'N')='N' AND A.SEMESTER='"+mSemester+"' and A.SUBJECTTYPE='"+mSubjectType+"' and A.SEMESTERTYPE='"+mSemType+"' AND  NVL(A.DEACTIVE,'N')='N'  order by CUSTOMFINALIZED ";
						
				//out.println("<BR>"+qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					%>
					<tr>
					<td NOWRAP><%=rs.getString("STUDENTNAME")%>-<%=rs.getString("ENROLLMENTNO")%></td>
					<td NOWRAP><%=rs.getString("SUBJECT")%>-<%=rs.getString("SUBJECTCODE")%></td>
					<td NOWRAP><%=rs.getString("CUSTOMFINALIZED")%></td>
					</tr>
					<%
				}
		}
	
 	} //3
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select the check box to approve!</font> <br>");
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
  //-----------------------------

}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	out.print("No Item Selected..."+e);
}
%>
<br>
<br>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>