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
String FeeAmt="500",qrys="";
String mSem="",mObjName="",mexamcode="",QryExam="",mPrevExmCode="",mComp="",Quota="";
String StudentID="",PrevExmCode="",SupExamCode="",mAcadYear="",SummerExamCode="";
int mSems=0;
int mFlag=0;	
String mAcad="";
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
}



if (request.getParameter("PrevExmCode")==null)
{
	PrevExmCode="";
}
else
{
	PrevExmCode=request.getParameter("PrevExmCode").toString().trim();
}

if (request.getParameter("SupExamCode")==null)
{
	SupExamCode="";
}
else
{
	SupExamCode=request.getParameter("SupExamCode").toString().trim();
}


if (request.getParameter("SummerExamCode")==null)
{
	SummerExamCode="";
}
else
{
	SummerExamCode=request.getParameter("SummerExamCode").toString().trim();
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
<HTML>
<head>
<TITLE> <%=mHead%> [Supplimentary Registration Form]</TITLE>
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
qry="Select WEBKIOSK.ShowLink('249','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{



//out.print("ASDAD");
%>
<form name="frm" method=post>
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr>
			<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><u><b>SUPPLEMENTARY REGISTRATION FORM 
			<!-- <br>LAST DATE OF RECIEPT IN REGISTRAR OFFICE - 12th March 2010 -->
			</b></U>
			</font>
			</td>
			</tr>
			</table>
			<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
			<tr><td><font color=#00008b face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="Vardana"><%=GlobalFunctions.toTtitleCase(mName)%> [<%=mDMemberCode%>]</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="Vardana"><%=mProg%>(<%=mBranch%>)</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="Vardana"><%=mSem%></font></td></tr>
			<tr><td ALIGN=CENTER><HR><font color=#00008b face=arial size=2><STRONG>&nbsp; Exam Code : <%=SupExamCode%></STRONG></font>
			
			</td></tr>

			
			</table><br>
			<style type="text/css">
				@media print 
				{
				input#btnPrint 
				{
					display: none;
				}
				}
				</style>
				<center><input type="button" id="btnPrint" onclick="window.print();" value="Click To Print"/></center>
			</form>
			<%
			

				
			
		qry="Select EnrollmentNo enrollmentno,Studentname Name, StudentID , Semester, nvl(ProgramCODE,'UNK') ProgramCode, nvl(BranchCode,'UNK') BranchCode,quota,AcademicYear From StudentMaster where studentid='"+mChkMemID+"' and InstiTuteCode='"+mInst+"'";
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
String mSupRegcode="";
qry="SELECT NVL(PREVEXAMCODE,' ')PREVEXAMCODE, SUPFEES,NVL(SUPREGCODE,' ')SUPREGCODE  FROM EXAMMASTER where InstiTuteCode='"+mInst+"' and   examcode='"+SupExamCode+"' and NVL(LOCKEXAM,'N')='N'";
//out.println(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	mPrevExmCode=rs.getString("PREVEXAMCODE");
	mSupFees=rs.getInt("SUPFEES");
	mSupRegcode=rs.getString("SUPREGCODE");
}


//*********12-03-2010***********************
%>
	
<form name="frm1" method=post action="RegistrationSaveJIIT.jsp">
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
	int SrNo=0;
	int sno=0,mTot=0;
	double ctot=0;
String 	msubject="";
/*	qry="SELECT distinct a.enrollmentno en2,v.subjectid, v.subject, v.subjectcode, v.semester, b.grade,       e.coursecreditpoint, TO_CHAR (examperiodto, 'Month YYYY') exammonth  FROM studentmaster a,       studentresultdetail b,       exammaster d,       v#studentltpdetail v,       programsubjecttagging e WHERE a.institutecode =  '"+ mInst +"' and a.INSTITUTECODE=e.INSTITUTECODE and b.EXAMCODE=e.EXAMCODE   AND a.studentid = b.studentid   AND a.studentid = v.studentid   AND b.studentid = v.studentid   AND d.examcode = b.examcode   AND d.institutecode = a.institutecode   AND b.fstid = v.fstid   AND b.examcode = v.examcode   AND b.examcode = '"+mPrevExmCode+"'    AND b.grade LIKE '%F%'   AND a.studentid =  '"+mChkMemID+"'";*/

if(request.getParameter("SrNo")==null)
	sno=0;
else
	sno=Integer.parseInt(request.getParameter("SrNo"));

String  qryhead="",mGLID="",mPostComp="",mFEEHEAD="";
ResultSet rshead=null;
qryhead="SELECT GLID, POSTINGCOMPANY,FEEHEAD FROM FEEHEADS WHERE INSTITUTECODE='"+mInst+"' AND  FEEHEAD='SEF' AND COMPANYCODE='"+mComp+"' ";
//out.print(qryhead);
						rshead=db.getRowset(qryhead);
						if(rshead.next())
						{
							mGLID=rshead.getString("GLID");
							mPostComp=rshead.getString("POSTINGCOMPANY");
							mFEEHEAD=rshead.getString("FEEHEAD");
						}

qry="DELETE FROM SUPPLEMENTARYSUBJECTTAGGING WHERE studentid='"+mSID+"' and examcode='"+SupExamCode+"'  AND INSTITUTECODE='"+mInst+"'  ";
//out.print(qry);

int b=db.update(qry);
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
		
	//out.print(msubject+"aaaa");
	if(!msubject.equals("N"))
	   {
		
		
		qry="SELECT DISTINCT v.fstid fstid , a.enrollmentno en2, v.subjectid subjectid, v.subject, v.subjectcode,   v.semester semester,v.semestertype semestertype, b.grade, B.coursecreditpoint,                TO_CHAR (examperiodto, 'Month YYYY') exammonth           FROM studentmaster a,                studentresultdetail b,                exammaster d,                v#studentltpdetail v                       WHERE a.institutecode ='"+ mInst +"'            AND a.studentid = b.studentid            AND a.studentid = v.studentid            AND b.studentid = v.studentid   and v.subjectid='"+msubject+"'         AND d.examcode = b.examcode            AND d.institutecode = a.institutecode    AND b.fstid = v.fstid            AND b.examcode = v.examcode            AND  B.examcode in( '"+mPrevExmCode+"','"+SummerExamCode+"')   AND NVL(b.fail,'N')='Y' AND a.studentid =  '"+mChkMemID+"'";
	
		
		

	//	out.print(qry);
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
			 
			<TD align=center> <b> <%=mSupFees%></b></TD>
			</TR>
			<%

			qry1="select 'Y' from SUPPLEMENTARYSUBJECTTAGGING where studentid='"+mSID+"' and examcode='"+SupExamCode+"' AND SUBJECTID ='"+msubject+"' ";
			rs1= db.getRowset(qry1); 
			if(!rs1.next())
				{
				mTot+=mSupFees;
				qry1="INSERT INTO SUPPLEMENTARYSUBJECTTAGGING (   INSTITUTECODE, COMPANYCODE, EXAMCODE,    REGCODE, STUDENTID, SUBJECTID,    SEMESTERTYPE, OLDFSTID,    ENTRYBY, ENTRYDATE) VALUES ('"+mInst+"' , '"+mComp+"','"+SupExamCode+"','"+mSupRegcode+"' ,'"+mSID+"', '"+msubject+"' ,'SUP','"+StudentRecordSet.getString("fstid")+"', '"+mSID+"' ,SYSDATE )";
				//out.print(qry1);
				int vv=db.insertRow(qry1);
					
				}
				else
				{
									mTot+=mSupFees;
				}

				qrys="SELECT 'Y' FROM FEESTRUCTUREINDIVIDUAL WHERE INSTITUTECODE='"+mInst+"' AND FEEHEAD LIKE '%SEF%' AND  STUDENTID='"+mChkMemID+"' AND REGCODE= '"+mSupRegcode+"' AND SEMESTER='"+mSems+"' ";
				//out.print(qrys);
				rss=db.getRowset(qrys);
				if(!rss.next())
					{
						

						qry="INSERT INTO FEESTRUCTUREINDIVIDUAL (   COMPANYCODE, INSTITUTECODE, ACADEMICYEAR,    PROGRAMCODE, BRANCHCODE, SEMESTER,    SEMESTERTYPE, FEEHEAD, CURRENCYCODE,    STUDENTID, FEEAMOUNT,     ENTRYBY, ENTRYDATE,    REGCODE, POSTINGCOMPANY,GLID,DEACTIVE) VALUES ( '"+mComp+"','"+mInst+"' ,'"+mAcadYear+"' ,'"+mProg+"','"+mBranch+"' ,'"+mSems+"' ,'SUP','"+mFEEHEAD+"','INR'	,'"+mSID+"' ,'"+mTot+"' ,'"+mSID+"',SYSDATE,'"+mSupRegcode+"','"+mPostComp+"' ,'"+mGLID+"','N' )";
						//	 out.print(qry);mGLID="",mPostComp=""
						int c=db.insertRow(qry);
					}
					else	
					{
						qry=" UPDATE FEESTRUCTUREINDIVIDUAL SET   FEEAMOUNT='"+mTot+"' WHERE 				INSTITUTECODE  = '"+mInst+"' AND    FEEHEAD  ='"+mFEEHEAD+"' AND STUDENTID ='"+mChkMemID+"' and COMPANYCODE='"+mComp+"' ";
						int xx=db.insertRow(qry);

					}

			}
			
			
		qry2="Select 'Y' from Studentregistration where studentid='"+mSID+"' and Examcode='"+SupExamCode+"' ";
		rs2=db.getRowset(qry2);
		if(!rs2.next())
		{

			//mSems=mSems-1;


		qry="alter trigger CAMPUS.TRG_PoplateCoreSubjects disable";
		int x=db.update(qry);


		
		qry1="INSERT INTO CAMPUS.STUDENTREGISTRATION (   COMPANYCODE, INSTITUTECODE, EXAMCODE,    REGCODE, ACADEMICYEAR, PROGRAMCODE,    TAGGINGFOR, SECTIONBRANCH, SEMESTER,    SEMESTERTYPE, STUDENTID, REGALLOW,    REGALLOWUSER, REGALLOWDATE,BRANCHCODE) VALUES ( '"+mComp+"','"+mInst+"' ,'"+SupExamCode+"' ,'"+mSupRegcode+"' ,'"+mAcadYear+"' ,'"+mProg+"' ,'B' ,'"+mBranch+"' ,'"+mSems+"' ,'SUP','"+mSID+"'  ,'Y' ,'"+mSID+"' ,sysdate,'"+mBranch+"')";
		//out.print(qry1);
		int n=db.insertRow(qry1);

			
		qry="alter trigger CAMPUS.TRG_PoplateCoreSubjects enable";
		int s=db.update(qry);
			
		//out.print("sdfsdfsfsf");			
		}

		
	}
}

		

	%>
	<tr><TD colspan=6 align=right><b><%=ctot%></b></td>
	<TD>&nbsp; &nbsp;</TD>
	</tr>
	
	<tr><TD colspan=6 align=right><B>Payment @Rs. <%=mSupFees%> per subject:&nbsp;&nbsp; </B>&nbsp;</td>
	<TD > <b>Total Rs. <%=mTot%> </b></TD>
	</tr> 

	</TABLE>
	</TD></TR>
	</TABLE>
	<hr>
	<p align=left>I Mr./Ms. <b><%=mSname%></b> hereby apply for the Supplementary Examination <B><%=SupExamCode%></B>. <br>I am enclosing a receipt of payment/demand draft of Rs. ................................... for .......................................... number of subjects @ Rs. <%=mSupFees%>/- per subject.
	<br><br>
	<table width='100%' border=0 cellpadding= cellspacing=0>
<tr><td colspan=2 align=Right><b>Signature of Student</b></td></tr>
<tr><td>Place: </td><td align=Right><b>(<%=mSname%>)</b>
<tr><td>Date: </td><td align=Right><b>or &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<BR><br>(Signature of Representative of Student)<br></b></td></tr>
<tr><td colspan=2 align=Right>Name :&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr><td colspan=2 align=Right>Relationship with Student: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;</td></tr>
</table>




	<hr>
	<p><b>Receipt From Registrar Office</b>
	<p Align=Left>Received Registration Fee for Supplementary Examination (<B><%=SupExamCode%></B>) and receipt of Payment/DD form.
	<br>
	Enrollment Number: <b><%=mEnrollment%></b>   Student Name : <b><%=mSname%></b>
	
	<p align=right>Signature of representative of Registrar
	<br>
<br>
<br>
	<p align=left>Please retain this receipt as authority for the hostel students to avail of hostel facilities for the duration of supplementary exam.

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
}
%>
  </body>
</html>
