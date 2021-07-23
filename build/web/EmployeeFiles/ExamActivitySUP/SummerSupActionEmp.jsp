<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%  

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rsi=null,rs2=null,rss=null;
GlobalFunctions gb =new GlobalFunctions();
String  qry1="",qry2="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="",mInst="",mDMemberCode="",mWebEmail="";

ResultSet  StudentRecordSet=null; 	  
String qry="";
String mName ="";
String mEnrollment="";
String mInstituteCode="",mInstName="";
String mSID="";
String mSname="";
String mProg="";
String mBranch="";
String FeeAmt="",qrys="";
String mSem="",mObjName="",mexamcode="",QryExam="",mPrevExmCode="",mComp="",Quota="",mLoginComp="";
String StudentID="",PrevExmCode="",SumExamCode="",mAcadYear="";
int mSems=0;
int mFlag=0,SrNo1=0;	
String mAcad="";
String mSumRegCode="";

	
if (session.getAttribute("MemberID")==null)
	{
		mMemberID="";
	}
	else
	{
		mMemberID=session.getAttribute("MemberID").toString().trim();
	}
	if (session.getAttribute("InstituteCode")==null )
	{
		mInst="";
	}
	else
	{
	   mInst=session.getAttribute("InstituteCode").toString().trim();
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



if (request.getParameter("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=request.getParameter("ProgramCode").toString().trim();
}

if (request.getParameter("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=request.getParameter("BranchCode").toString().trim();
}

if (request.getParameter("Semester")==null)
{
	mSem="";
}
else
{
	mSem=request.getParameter("Semester").toString().trim();
}




if (request.getParameter("StudentID")==null)
{
	StudentID="";
}
else
{
	StudentID=request.getParameter("StudentID").toString().trim();
}
if (request.getParameter("PrevExmCode")==null)
{
	PrevExmCode="";
}
else
{
	PrevExmCode=request.getParameter("PrevExmCode").toString().trim();
}

if (request.getParameter("SumExamCode")==null)
{
	SumExamCode="";
}
else
{
	SumExamCode=request.getParameter("SumExamCode").toString().trim();
}

if (request.getParameter("SumRegCode")==null)
{
	mSumRegCode="";
}
else
{
	mSumRegCode=request.getParameter("SumRegCode").toString().trim();
}

int mMaxsem=0;
double mMinsem=5.2;

if (request.getParameter("mMaxsem")==null)
{
	mMaxsem=0;
}
else
{
	mMaxsem=Integer.parseInt(request.getParameter("mMaxsem"));
}


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE> <%=mHead%> [SUMMER SEMESTER ]</TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 background="../../Images/Speciman.jpg">
<%
try
{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("")) 
	{
	mDMemberCode=enc.decode(mMemberCode);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
qry="Select WEBKIOSK.ShowLink('271','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{



//out.print("ASDAD");
%>
<form name="frm" method=post>
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr>
			<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><u><b>SUMMER SEMESTER 
			<!-- <br>LAST DATE OF RECIEPT IN REGISTRAR OFFICE - 12th March 2010 -->
			</b></U>
			</font>
			</td>
			</tr>
			</table>
			<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
			<tr><td nowrap><font color=#00008b face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="Vardana"><%=GlobalFunctions.toTtitleCase(mName)%> [<%=mDMemberCode%>]</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="Vardana"><%=mProg%>(<%=mBranch%>)</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="Vardana"><%=mSem%></font></td></tr>
			<tr><td ALIGN=CENTER><font color=#00008b face=arial size=2><STRONG>&nbsp; Exam Code : <%=SumExamCode%></STRONG></font>
			
			</td></tr>

			
			</table>
			<style type="text/css">
				@media print 
				{
				input#btnPrint 
				{
					display: none;
				}
				}
				</style>
				<center><input type="button" id="btnPrint" onclick="window.print();" value="Click To Print (2 copies)"/></center>
			</form>
			<%
			

				
			
		qry="Select EnrollmentNo enrollmentno,Studentname Name, StudentID , Semester, nvl(ProgramCODE,'UNK') ProgramCode, nvl(BranchCode,'UNK') BranchCode,quota,AcademicYear From StudentMaster where studentid='"+StudentID+"' and InstiTuteCode='"+mInst+"'";
		//out.print(qry); 
	 
  StudentRecordSet = db.getRowset(qry); 	
  if (StudentRecordSet.next())
  { 
	mEnrollment=StudentRecordSet.getString("enrollmentno");
	mSID=StudentRecordSet.getString("StudentID");
	mSname=StudentRecordSet.getString("Name");
	mProg=StudentRecordSet.getString("ProgramCode");
	mBranch=StudentRecordSet.getString("BranchCode");
	mSems=StudentRecordSet.getInt("Semester");
	Quota=StudentRecordSet.getString("quota");
	mAcadYear=StudentRecordSet.getString("AcademicYear");
  }
//  out.print("sdfsdfsfsfd");

//*********12-03-2010***********************
int mSupFees=0;

/*qry="SELECT NVL(PREVEXAMCODE,' ')PREVEXAMCODE, SUPFEES,NVL(SUPREGCODE,' ')SUPREGCODE  FROM EXAMMASTER where InstiTuteCode='"+mInst+"' and examcode='"+SumExamCode+"' and NVL(LOCKEXAM,'N')='N'";
//out.println(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	mPrevExmCode=rs.getString("PREVEXAMCODE");
	//mSupFees=rs.getInt("SUPFEES");
	mSumRegCode=rs.getString("SUPREGCODE");
}*/








//*********12-03-2010***********************
%>
	
<form name="frm1" method=post>
	<p><b>Registrar Copy</b></p>
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	<tr bgcolor=#ff8c00>
	<td><FONT COLOR=WHITE><b>Enrollment No</b></font></td>
	<td><FONT COLOR=WHITE><b>Student Name</b></font></td>
	<td><FONT COLOR=WHITE><b>Programme</b></font></td>
	<td><FONT COLOR=WHITE><b>Branch</b></font></td>
	<td><FONT COLOR=WHITE><b>Semester</b></font></td>
	</tr>
	<tr bgcolor='white'>
	<td><FONT COLOR=black><b><%=mEnrollment%></b></font></td>
	<td><FONT COLOR=black><b><%=mSname%></b></font></td>
	<td><FONT COLOR=black><b><%=mProg%></b></font></td>
	<td><FONT COLOR=black><b><%=mBranch%></b></font></td>
	<td><FONT COLOR=black><b><%=mSem%></b></font></td>
	</tr>

	<Tr bgcolor=white>
		<td COLSPAN=5><b>&nbsp;&nbsp;</td>
	</Tr>

	<TR><TD COLSPAN=5>
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	<TR BGCOLOR=#ff8c00>
	<TD><FONT COLOR=WHITE><b>Slno</b></FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Code</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Name</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Semester</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Grade</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Credits</FONT></TD>
	<TD align=center><FONT COLOR=WHITE><b>Fee</b></FONT></TD>
	</TR>
     <%
	int SrNo=0,mflag=0;
	int sno=0,mError=0;
	long mTot=0;
	double ctot=0,CourseCreditTot=0;
String 	msubject="";
/*	qry="SELECT distinct a.enrollmentno en2,v.subjectid, v.subject, v.subjectcode, v.semester, b.grade,       e.coursecreditpoint, TO_CHAR (examperiodto, 'Month YYYY') exammonth  FROM studentmaster a,       studentresultdetail b,       exammaster d,       v#studentltpdetail v,       programsubjecttagging e WHERE a.institutecode =  '"+ mInst +"' and a.INSTITUTECODE=e.INSTITUTECODE and b.EXAMCODE=e.EXAMCODE   AND a.studentid = b.studentid   AND a.studentid = v.studentid   AND b.studentid = v.studentid   AND d.examcode = b.examcode   AND d.institutecode = a.institutecode   AND b.fstid = v.fstid   AND b.examcode = v.examcode   AND b.examcode = '"+mPrevExmCode+"'    AND b.grade LIKE '%F%'   AND a.studentid =  '"+StudentID+"'";*/

if(request.getParameter("SrNo")==null)
	sno=0;
else
	sno=Integer.parseInt(request.getParameter("SrNo"));

String  qryhead="",mGLID="",mPostComp="",mFEEHEAD="";
ResultSet rshead=null;
qryhead="SELECT GLID, POSTINGCOMPANY,FEEHEAD FROM FEEHEADS WHERE INSTITUTECODE='"+mInst+"' AND  FEEHEAD='SUMTF' AND COMPANYCODE='"+mLoginComp+"' ";
//out.print(qryhead);
						rshead=db.getRowset(qryhead);
						if(rshead.next())
						{
							mGLID=rshead.getString("GLID");
							mPostComp=rshead.getString("POSTINGCOMPANY");
							mFEEHEAD=rshead.getString("FEEHEAD");
						}
//delete old record from SUPPLEMENTARYSUBJECTTAGGING for this student

qry="DELETE FROM SUPPLEMENTARYSUBJECTTAGGING WHERE studentid='"+StudentID+"' and examcode='"+SumExamCode+"'  AND INSTITUTECODE='"+mInst+"' and REGCODE= '"+mSumRegCode+"' ";
//out.print(qry);
int b=db.update(qry);
//out.print(sno+"aaaa"+mSupFees);
for(int yy =1; yy<=sno;yy++)
{
	if(request.getParameter("Checked"+yy)==null)
		{
			msubject="N";
		}
		else
		{
			msubject=request.getParameter("SubjectID"+yy);
			
		}


	if(request.getParameter("SupFees"+yy)==null)
		{
			mSupFees=0;
		}
		else
		{
			mSupFees=Integer.parseInt(request.getParameter("SupFees"+yy));
			
		}
		
		


	if(!msubject.equals("N"))
	{
		

/*
qry="SELECT DISTINCT C.enrollmentno en2, c.subjectid subjectid, c.subject,                c.subjectcode, c.semester, ' ' grade, a.coursecreditpoint,                a.supfees           FROM offersubjecttagging a,                DEBARSTUDENTDETAIL b,                 v#studentltpdetail c          WHERE a.institutecode = '"+ mInst +"'      and a.subjectid='"+msubject+"'    AND  C.STUDENTID=B.STUDENTID             AND c.subjectid = a.subjectid            AND b.subjectid = a.subjectid            AND c.subjectid = b.subjectid             AND NVL(b.REGISTEREDSTATUS,'N')='N'            AND a.examcode = '"+SumExamCode+"'                       AND NVL (C.deactive, 'N') = 'N'                        AND a.institutecode = C.institutecode                        AND a.institutecode = b.institutecode                        AND a.institutecode = c.institutecode                        AND c.institutecode = b.institutecode                        AND NVL (C.deactive, 'N') = 'N'            AND C.studentid = '"+StudentID+"' AND (C.studentid, C.subjectid) IN (                  SELECT studentid, subjectid                     FROM debarstudentdetail                    WHERE examcode = '"+PrevExmCode+"'                        AND studentid ='"+StudentID+"'                      AND institutecode = '"+ mInst +"'    and a.subjectid='"+msubject+"'                   ) union ";*/


qry="SELECT DISTINCT c.enrollmentno en2, c.subjectid subjectid, c.subject,                c.subjectcode, c.semester, ' ' grade, a.coursecreditpoint,                a.supfees           FROM offersubjecttagging a,                 v#studentltpdetail c          WHERE a.institutecode =  '"+ mInst +"' and a.subjectid='"+msubject+"'             AND c.subjectid = a.subjectid            AND a.examcode ='"+SumExamCode+"'             AND NVL (c.deactive, 'N') = 'N'            AND a.institutecode = c.institutecode                     AND NVL (c.deactive, 'N') = 'N'            AND c.studentid = '"+StudentID+"'             AND (c.studentid, c.subjectid) IN (                   SELECT studentid, subjectid                     FROM debarstudentdetail                    WHERE examcode = '"+PrevExmCode+"'        and subjectid='"+msubject+"'                     AND studentid = '"+StudentID+"'                       AND institutecode = '"+ mInst +"' AND NVL (registeredstatus, 'N') = 'N')                      and                          (c.studentid, c.subjectid) not IN (                SELECT studentid, subjectid                     FROM studentresult                    WHERE studentid = '"+StudentID+"'                       AND institutecode =  '"+ mInst +"'   and subjectid='"+msubject+"'    ) union ";
qry=qry+="SELECT DISTINCT v.enrollmentno en2, c.subjectid subjectid, c.subject,                c.subjectcode, B.semester, b.grade, a.coursecreditpoint,                a.supfees FROM offersubjecttagging a, studentresult b, studentmaster v,subjectmaster c WHERE a.subjectid='"+msubject+"' and a.institutecode = '"+ mInst +"' AND v.studentid = b.studentid AND v.studentid = v.studentid AND C.subjectid = a.subjectid AND B.subjectid = a.subjectid AND C.subjectid = B.subjectid AND NVL (b.fail, 'N') = 'Y'  and a.examcode = '"+SumExamCode+"' and nvl(v.DEACTIVE,'N')='N'  AND A.INSTITUTECODE=V.INSTITUTECODE AND A.INSTITUTECODE=B.INSTITUTECODE AND  A.INSTITUTECODE=C.INSTITUTECODE AND C.INSTITUTECODE=B.INSTITUTECODE  AND NVL(V.DEACTIVE,'N')='N'  AND V.studentid = '"+StudentID+"'   union SELECT DISTINCT v.enrollmentno en2, c.subjectid subjectid, c.subject,                c.subjectcode, B.semester, b.grade, a.coursecreditpoint,          a.supfees  FROM offersubjecttagging a, studentresult b, studentmaster v,subjectmaster c WHERE a.subjectid='"+msubject+"' and a.institutecode = '"+ mInst +"' AND v.studentid = b.studentid AND v.studentid = v.studentid and nvl(v.DEACTIVE,'N')='N' AND NVL(V.DEACTIVE,'N')='N' AND C.subjectid = a.subjectid AND C.subjectid = B.subjectid AND a.examcode = '"+SumExamCode+"' AND A.INSTITUTECODE=V.INSTITUTECODE AND A.INSTITUTECODE=B.INSTITUTECODE AND A.INSTITUTECODE=V.INSTITUTECODE AND A.INSTITUTECODE=C.INSTITUTECODE AND A.INSTITUTECODE=V.INSTITUTECODE AND C.INSTITUTECODE=B.INSTITUTECODE AND  b.GRADE not in ('A','A+','B+')  AND V.studentid = '"+StudentID+"'   and V.STUDENTID IN ( SELECT A.STUDENTID FROM STUDENTSGPACGPA A,STUDENTMASTER B  WHERE A.semester="+mMaxsem+" AND A.STUDENTID=B.STUDENTID AND CGPA< "+mMinsem+" ) union SELECT DISTINCT v.enrollmentno en2, c.subjectid subjectid, c.subject,                 c.subjectcode, B.semester, 'Not Registered' grade, a.coursecreditpoint,                a.supfees FROM offersubjecttagging a, nrstudentfailsubjects b,studentmaster v,subjectmaster c WHERE a.subjectid='"+msubject+"' and a.institutecode = '"+ mInst +"' AND v.studentid = b.studentid AND v.studentid = v.studentid and nvl(v.DEACTIVE,'N')='N' AND NVL(V.DEACTIVE,'N')='N' AND a.subjectid = b.subjectid AND a.subjectid = b.subjectid  and a.examcode ='"+SumExamCode+"' and a.subjectid=c.subjectid and a.subjectid=b.subjectid and a.institutecode=c.institutecode and a.institutecode=v.institutecode AND NVL(REGISTERED,'N')='N' AND V.studentid = '"+StudentID+"'   ORDER BY coursecreditpoint DESC";
		//out.print(CourseCreditTot+"CourseCreditTot");

		//out.print(qry);
        StudentRecordSet = db.getRowset(qry); 	
			if (StudentRecordSet.next())
			{
			SrNo++;
			sno++;
			ctot+=StudentRecordSet.getDouble("CourseCreditPoint");
			
			%>
			<TR>
			<TD><b><%=SrNo%></b></TD>
			<TD><b><%=StudentRecordSet.getString("SubjectCode")%></b></TD>
			<TD><b><%=StudentRecordSet.getString("Subject")%></b></TD>
			<TD><b><%=StudentRecordSet.getInt("Semester")%></b></TD>
			<TD><b><%=StudentRecordSet.getString("Grade")%></b></TD>
			<TD align=right><b><%=StudentRecordSet.getDouble("CourseCreditPoint")%></b></TD>
			 
			<TD align=right> <b> <%=mSupFees%></b></TD>
			</TR>
			<%

			


			qry2="select 'Y' from SUPPLEMENTARYSUBJECTTAGGING where studentid='"+mSID+"' and examcode='"+SumExamCode+"' AND SUBJECTID ='"+msubject+"' ";
			//	out.print(qry2);
			rs1= db.getRowset(qry2); 
			if(!rs1.next())
				{
				mTot+=mSupFees;
			//	out.print(mTot+"mTot");

				qry1="INSERT INTO SUPPLEMENTARYSUBJECTTAGGING (   INSTITUTECODE, COMPANYCODE, EXAMCODE,    REGCODE, STUDENTID, SUBJECTID,    SEMESTERTYPE,   OLDFSTID,  ENTRYBY, ENTRYDATE) VALUES ('"+mInst+"' , '"+mLoginComp+"','"+SumExamCode+"','"+mSumRegCode+"' ,'"+mSID+"', '"+msubject+"' ,'SUP','SUMMER', '"+mSID+"' ,SYSDATE )";
			//	out.print(qry1);
				int vv=db.insertRow(qry1);
					
					if(vv>0)
						mError=0;
					else
						mError=1;

				}
				else
				{
									mTot+=mSupFees;
				}

				qrys="SELECT 'Y' FROM FEESTRUCTUREINDIVIDUAL WHERE INSTITUTECODE='"+mInst+"' AND FEEHEAD LIKE '%SUMTF%' AND  STUDENTID='"+StudentID+"' AND REGCODE= '"+mSumRegCode+"' AND SEMESTER='"+mSems+"' ";
				//out.print(qrys);
				rss=db.getRowset(qrys);
				if(!rss.next())
					{
						

						qry="INSERT INTO FEESTRUCTUREINDIVIDUAL (   COMPANYCODE, INSTITUTECODE, ACADEMICYEAR,    PROGRAMCODE, BRANCHCODE, SEMESTER,    SEMESTERTYPE, FEEHEAD, CURRENCYCODE,    STUDENTID, FEEAMOUNT,     ENTRYBY, ENTRYDATE,    REGCODE, POSTINGCOMPANY,GLID,DEACTIVE) VALUES ( '"+mLoginComp+"','"+mInst+"' ,'"+mAcadYear+"' ,'"+mProg+"','"+mBranch+"' ,'"+mSems+"' ,'SUP','"+mFEEHEAD+"','INR'	,'"+mSID+"' ,'"+mTot+"' ,'"+mSID+"',SYSDATE,'"+mSumRegCode+"','"+mPostComp+"' ,'"+mGLID+"','N' )";
						//	 out.print(qry);mGLID="",mPostComp=""
						int c=db.insertRow(qry);

						if(c>0)
						mError=0;
					else
						mError=1;
					}
					else	
					{
						qry=" UPDATE FEESTRUCTUREINDIVIDUAL SET   FEEAMOUNT='"+mTot+"' WHERE 				INSTITUTECODE  = '"+mInst+"' AND    FEEHEAD  ='"+mFEEHEAD+"' AND STUDENTID ='"+StudentID+"' and COMPANYCODE='"+mLoginComp+"' ";
						int xx=db.insertRow(qry);

						if(xx>0)
						mError=0;
					else
						mError=1;

					}

			}
			
			
		qry2="Select 'Y' from Studentregistration where studentid='"+mSID+"' and Examcode='"+SumExamCode+"' ";
		rs2=db.getRowset(qry2);
		if(!rs2.next())
		{

			//mSems=mSems-1; CAMPUS.


		qry="alter trigger CAMPUS.TRG_PoplateCoreSubjects disable";
		int x=db.update(qry);


		
		qry1="INSERT INTO STUDENTREGISTRATION (   COMPANYCODE, INSTITUTECODE, EXAMCODE,    REGCODE, ACADEMICYEAR, PROGRAMCODE,    TAGGINGFOR, SECTIONBRANCH, SEMESTER,    SEMESTERTYPE, STUDENTID, REGALLOW,    REGALLOWUSER, REGALLOWDATE,BRANCHCODE) VALUES ( '"+mLoginComp+"','"+mInst+"' ,'"+SumExamCode+"' ,'"+mSumRegCode+"' ,'"+mAcadYear+"' ,'"+mProg+"' ,'B' ,'"+mBranch+"' ,'"+mSems+"' ,'SUP','"+mSID+"'  ,'Y' ,'"+mSID+"' ,sysdate,'"+mBranch+"')";
	//	out.print(qry1);
		int n=db.insertRow(qry1);

					if(n>0)
						mError=0;
					else
						mError=1;

			
		qry="alter trigger CAMPUS.TRG_PoplateCoreSubjects enable";
		int s=db.update(qry);
			
		//out.print("sdfsdfsfsf");			
		}

	

	}
//ctot=0;
}


if(mError==0)
{
//out.print(ctot+"sdfsdfsfsf");		
	if(ctot<=12)
		{

	%>
	<tr><TD colspan=6 align=right><b>Total Credit: <%=ctot%></b></td>
	<TD>&nbsp; &nbsp;</TD>
	</tr>
	
	<tr><TD colspan=7 align=right><B>Payment Total Rs. &nbsp;&nbsp; <%=mTot%>/-</B></td>
	
	</tr> 

	</TABLE>
	</TD></TR>
	</TABLE>
	<hr>
	<p align=left>I Mr./Ms. <b><%=mSname%></b> here by apply for the Examination <B><%=SumExamCode%></B>. <br>I am enclosing a receipt of payment/demand draft of Rs. .......................... for .............................. number of subjects @ Rs. <%=mTot%>/- 
	<br><br>
	<table width='100%' border=0 cellpadding= cellspacing=0>

<tr><td>Place: </td><td align=Right><b></b>
<tr><td>Date: </td><td align=Right><b></td></tr>
<tr><td colspan=2 align=Right><b>Signature of Student (<%=mSname%>)</b></td></tr>
</table>


	<hr>
	<p><b>Student Copy</b></p>
		<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	<tr bgcolor=#ff8c00>
	<td><FONT COLOR=WHITE><b>Enrollment No</b></font></td>
	<td><FONT COLOR=WHITE><b>Student Name</b></font></td>
	<td><FONT COLOR=WHITE><b>Programme</b></font></td>
	<td><FONT COLOR=WHITE><b>Branch</b></font></td>
	<td><FONT COLOR=WHITE><b>Semester</b></font></td>
	</tr>
	<tr bgcolor='white'>
	<td><FONT COLOR=black><b><%=mEnrollment%></b></font></td>
	<td><FONT COLOR=black><b><%=mSname%></b></font></td>
	<td><FONT COLOR=black><b><%=mProg%></b></font></td>
	<td><FONT COLOR=black><b><%=mBranch%></b></font></td>
	<td><FONT COLOR=black><b><%=mSem%></b></font></td>
	</tr>

	<Tr bgcolor=white>
		<td COLSPAN=5><b>&nbsp;&nbsp;</td>
	</Tr>

	<TR><TD COLSPAN=5>
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	<TR BGCOLOR=#ff8c00>
	<TD><FONT COLOR=WHITE><b>Slno</b></FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Code</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Name</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Semester</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Grade</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Credits</FONT></TD>
	<TD align=center><FONT COLOR=WHITE><b>Fee</b></FONT></TD>
	</TR>
	<%
     for(int cc =1; cc<=sno;cc++)
{
	if(request.getParameter("Checked"+cc)==null)
		{
			msubject="N";
		}
		else
		{
			msubject=request.getParameter("SubjectID"+cc);
			
		}


	if(request.getParameter("SupFees"+cc)==null)
		{
			mSupFees=0;
		}
		else
		{
			mSupFees=Integer.parseInt(request.getParameter("SupFees"+cc));
			
		}
		
		


	if(!msubject.equals("N"))
	{
		


qry="SELECT DISTINCT c.enrollmentno en2, c.subjectid subjectid, c.subject,                c.subjectcode, c.semester, ' ' grade, a.coursecreditpoint,                a.supfees           FROM offersubjecttagging a,                 v#studentltpdetail c          WHERE a.institutecode =  '"+ mInst +"' and a.subjectid='"+msubject+"'             AND c.subjectid = a.subjectid            AND a.examcode ='"+SumExamCode+"'             AND NVL (c.deactive, 'N') = 'N'            AND a.institutecode = c.institutecode                     AND NVL (c.deactive, 'N') = 'N'            AND c.studentid = '"+StudentID+"'             AND (c.studentid, c.subjectid) IN (                   SELECT studentid, subjectid                     FROM debarstudentdetail                    WHERE examcode = '"+PrevExmCode+"'        and subjectid='"+msubject+"'                     AND studentid = '"+StudentID+"'                       AND institutecode = '"+ mInst +"' AND NVL (registeredstatus, 'N') = 'N')                      and                          (c.studentid, c.subjectid) not IN (                SELECT studentid, subjectid                     FROM studentresult                    WHERE studentid = '"+StudentID+"'                       AND institutecode =  '"+ mInst +"'   and subjectid='"+msubject+"'    ) union ";
qry=qry+="SELECT DISTINCT v.enrollmentno en2, c.subjectid subjectid, c.subject,                c.subjectcode, B.semester, b.grade, a.coursecreditpoint,                a.supfees FROM offersubjecttagging a, studentresult b, studentmaster v,subjectmaster c WHERE a.subjectid='"+msubject+"' and a.institutecode = '"+ mInst +"' AND v.studentid = b.studentid AND v.studentid = v.studentid AND C.subjectid = a.subjectid AND B.subjectid = a.subjectid AND C.subjectid = B.subjectid AND NVL (b.fail, 'N') = 'Y'  and a.examcode = '"+SumExamCode+"' and nvl(v.DEACTIVE,'N')='N'  AND A.INSTITUTECODE=V.INSTITUTECODE AND A.INSTITUTECODE=B.INSTITUTECODE AND  A.INSTITUTECODE=C.INSTITUTECODE AND C.INSTITUTECODE=B.INSTITUTECODE  AND NVL(V.DEACTIVE,'N')='N'  AND V.studentid = '"+StudentID+"'   union SELECT DISTINCT v.enrollmentno en2, c.subjectid subjectid, c.subject,                c.subjectcode, B.semester, b.grade, a.coursecreditpoint,          a.supfees  FROM offersubjecttagging a, studentresult b, studentmaster v,subjectmaster c WHERE a.subjectid='"+msubject+"' and a.institutecode = '"+ mInst +"' AND v.studentid = b.studentid AND v.studentid = v.studentid and nvl(v.DEACTIVE,'N')='N' AND NVL(V.DEACTIVE,'N')='N' AND C.subjectid = a.subjectid AND C.subjectid = B.subjectid AND a.examcode = '"+SumExamCode+"' AND A.INSTITUTECODE=V.INSTITUTECODE AND A.INSTITUTECODE=B.INSTITUTECODE AND A.INSTITUTECODE=V.INSTITUTECODE AND A.INSTITUTECODE=C.INSTITUTECODE AND A.INSTITUTECODE=V.INSTITUTECODE AND C.INSTITUTECODE=B.INSTITUTECODE AND  b.GRADE not in ('A','A+','B+')  AND V.studentid = '"+StudentID+"'   and V.STUDENTID IN ( SELECT A.STUDENTID FROM STUDENTSGPACGPA A,STUDENTMASTER B  WHERE A.semester="+mMaxsem+" AND A.STUDENTID=B.STUDENTID AND CGPA< "+mMinsem+" ) union SELECT DISTINCT v.enrollmentno en2, c.subjectid subjectid, c.subject,                 c.subjectcode, B.semester, 'Not Registered' grade, a.coursecreditpoint,                a.supfees FROM offersubjecttagging a, nrstudentfailsubjects b,studentmaster v,subjectmaster c WHERE a.subjectid='"+msubject+"' and a.institutecode = '"+ mInst +"' AND v.studentid = b.studentid AND v.studentid = v.studentid and nvl(v.DEACTIVE,'N')='N' AND NVL(V.DEACTIVE,'N')='N' AND a.subjectid = b.subjectid AND a.subjectid = b.subjectid  and a.examcode ='"+SumExamCode+"' and a.subjectid=c.subjectid and a.subjectid=b.subjectid and a.institutecode=c.institutecode and a.institutecode=v.institutecode AND NVL(REGISTERED,'N')='N' AND V.studentid = '"+StudentID+"'   ORDER BY coursecreditpoint DESC";
		//out.print(CourseCreditTot+"CourseCreditTot");

		//out.print(qry);
        StudentRecordSet = db.getRowset(qry); 	
			if (StudentRecordSet.next())
			{
			SrNo1++;
			sno++;
			//ctot+=StudentRecordSet.getDouble("CourseCreditPoint");
			
			%>
			<TR>
			<TD><b><%=SrNo1%></b></TD>
			<TD><b><%=StudentRecordSet.getString("SubjectCode")%></b></TD>
			<TD><b><%=StudentRecordSet.getString("Subject")%></b></TD>
			<TD><b><%=StudentRecordSet.getInt("Semester")%></b></TD>
			<TD><b><%=StudentRecordSet.getString("Grade")%></b></TD>
			<TD align=right><b><%=StudentRecordSet.getDouble("CourseCreditPoint")%></b></TD>
			 
			<TD align=right> <b> <%=mSupFees%></b></TD>
			</TR>
			<%
			}
	}
}
			%>

	<tr><TD colspan=6 align=right><b>Total Credit: <%=ctot%></b></td>
	<TD>&nbsp; &nbsp;</TD>
	</tr>
	
	<tr><TD colspan=7 align=right><B>Payment Total Rs. &nbsp;&nbsp; <%=mTot%>/-</B></td>
	
	</tr> 

	</TABLE>
	</TD></TR>
	</TABLE>
	<p align=right><BR><BR><B>Signature of Representative of Registrar</B>
	

	

<%
		}
else
		{
	%>
			<p align=Center ><font color=RED size=4> <b>Maximum Total Course Credit Point allowed is 12 !
			</font>
		</p>
			<%
		}
}
else
		{
	%>
			<center><font color=RED size=5 face="verdana" ><b> Error in Saving !
			</b></font>
		</center>
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
	out.print(e);
}
%>
  </body>
</html>
