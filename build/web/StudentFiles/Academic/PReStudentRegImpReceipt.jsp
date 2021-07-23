<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%  


DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rsi=null,rs2=null;
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
String FeeAmt="";
String mSem="",mObjName="",QryExam="",mPrevExmCode="",mComp="",Quota="";
String StudentID="",PrevExmCode="",mExamCode="",mAcadYear="";
int mSems=0;
int mFlag=0,SrNo1=0;	
int mFeeAmt=0,mTot=0,SrNo=0;
String mAcad="";
double ctot=0,mCCP=0;
String mSumRegCode="";


	ResultSet				rs12=null;
	ResultSet rss=null,rsCCP=null;
	String qry123="";
	String 			qrys="";


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

if (request.getParameter("mExamCode")==null)
{
	mExamCode="";
}
else
{
	mExamCode=request.getParameter("mExamCode").toString().trim();
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
<TITLE> <%=mHead%> [ PRE-REGISTRATION IMPROVEMENT SUBJECT FEE RECEIPT ]</TITLE>
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
qry="Select WEBKIOSK.ShowLink('52','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{



//out.print("ASDAD");
%>
<form name="frm" method=post>
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr>
			<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><u><b>PRE-REGISTRATION GRADE IMPROVEMENT SUBJECT FEE RECEIPT 
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
			<tr><td ALIGN=CENTER><font color=#00008b face=arial size=2><STRONG>&nbsp; Exam Code : <%=mExamCode%></STRONG></font>
			
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

	%>
<form name="frm1" method=post>
	<p><font face=arial size=2 > Registrar Copy</p>
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
	<TD><FONT COLOR=WHITE><b>Subject Name - Subject Code</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Semester</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Credits</FONT></TD>
	<TD align=center><FONT COLOR=WHITE><b>Fee</b></FONT></TD>
	</TR>

	<%
//-------------- IMPROVEMENT SUBJECT ONLY


 qry123="Select SUBJECTID,subject,nvl(choice,0) abc,subjectrunning,decode(electivecode,'B', 1,null,2,'PDE',3,'DE',4)aa,electivecode,decode(electivecode,null,'Core','PDE','Elective(PDE)','DE','Elective(DE)','B','BackCore',subjecttype)subjecttype,semestertype,SEMESTER from (SELECT DISTINCT   A.SUBJECTID , NVL (a.subject, ' ')                 || '('                || NVL (a.subjectcode, ' ')                || ')' subject,                NVL (b.choice, 0) choice,                NVL (b.subjectrunning, ' ') subjectrunning,                NVL (b.electivecode, '') electivecode,                NVL (b.subjecttype, '') subjecttype,                NVL (b.semestertype, '') semestertype  ,b.SEMESTER         FROM subjectmaster a, pr#studentsubjectchoice b          WHERE  nvl(b.IMPROVEMENTSUBJECT,'')='Y' and  b.examcode = '"+mExamCode+"'            AND b.institutecode = '"+mInst+"'            AND b.semestertype = 'GIP'            AND b.subjecttype = 'C'            AND b.studentid = '"+mChkMemID+"'   and a.INSTITUTECODE=b.INSTITUTECODE          AND a.subjectid = b.subjectid            union       SELECT DISTINCT  A.SUBJECTID ,  NVL (a.subject, ' ')                || '('                || NVL (a.subjectcode, ' ')                || ')' subject,                NVL (b.choice, 0) choice,                NVL (b.subjectrunning, ' ') subjectrunning,                NVL (b.electivecode, '') electivecode,                NVL (b.subjecttype, '') subjecttype,                NVL (b.semestertype, '') semestertype    ,b.SEMESTER        FROM subjectmaster a, pr#studentsubjectchoice b          WHERE  NVL (b.improvementsubject, '') = 'Y' and  b.examcode = '"+mExamCode+"'             AND b.institutecode = '"+mInst+"'             AND b.semestertype = 'GIP'             AND b.subjecttype = 'E'             AND b.studentid = '"+mChkMemID+"'      and a.INSTITUTECODE=b.INSTITUTECODE        AND a.subjectid = b.subjectid                  ORDER BY subjecttype,electivecode)       order by aa,abc";	
					//		out.println(qry123);
								rs12=db.getRowset(qry123);		
							while(rs12.next())
							{
									
SrNo++;
								qry="select max(COURSECREDITPOINT)COURSECREDITPOINT from (Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT From PROGRAMSUBJECTTAGGING C where examcode='"+mExamCode+"'  And subjectid='"+rs12.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"'";
								qry=qry+" UNION Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT   From OfferSubjectTagging C where examcode='"+mExamCode+"'  And subjectid='"+rs12.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"'";
								qry=qry+" UNION Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT   From pr#electivesubjects C where examcode='"+mExamCode+"'  And subjectid='"+rs12.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"' )";
								//out.print(qry);
								rsCCP=db.getRowset(qry);
								if (rsCCP.next())
								{
									mCCP=rsCCP.getDouble("COURSECREDITPOINT");
								}
								else
								{
									mCCP=0;
								}


					 			qrys="SELECT FEEAMOUNT FROM FEESTRUCTUREINDIVIDUAL WHERE INSTITUTECODE='"+mInst+"' AND FEEHEAD LIKE 'GIEF%' AND  STUDENTID='"+mChkMemID+"'  AND SEMESTER='"+rs12.getString("SEMESTER")+"' ";
			//	out.print(qrys);
				 rss=db.getRowset(qrys);
				if(rss.next())
								{
					mFeeAmt=rss.getInt("FEEAMOUNT");

					mTot=mTot+mFeeAmt;
								}
								

						ctot+=mCCP;

												%>
												<tr >
														<TD><b><%=SrNo%></b></TD>
												<td><%=rs12.getString("subject")%></td>
												<td align=center><%=rs12.getString("SEMESTER")%></td>
												<td align=right>&nbsp;<%=mCCP%></td>
												<td align=center>&nbsp;<%=mFeeAmt%></td>
											
											
											</tr>
												<%
							}
if(ctot<=12)
		{

	%>
	<tr><TD colspan=4 align=right><b>Total Credit: <%=ctot%></b></td>
	<TD>&nbsp; &nbsp;</TD>
	</tr>
	
	<tr><TD colspan=5 align=right><B>Payment Total Rs. &nbsp;&nbsp; <%=mTot%>/-</B></td>
	
	</tr> 

	</TABLE>

		<hr>
	<p align=left>I Mr./Ms. <b><%=mSname%></b> here by apply for Subjects Lectuer______ & Lab_____ the Examination <B><%=mExamCode%></B>. <br>I am enclosing a receipt of payment/demand draft of Rs. .......................... for .............................. number of subjects @ Rs. <%=mTot%>/- 
	<br><br>
	<table width='100%' border=0 cellpadding= cellspacing=0>

<tr><td>Place: </td><td align=Right><b></b>
<tr><td>Date: </td><td align=Right><b></td></tr>
<tr><td colspan=2 align=Right>Signature of Student (<%=mSname%>)</b></td></tr>
</table>


	<hr>
	<p ><font face=arial size=2 > Student Copy </p>
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
	<TD><FONT COLOR=WHITE><b>Subject Name - Subject Code</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Semester</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Credits</FONT></TD>
	<TD align=center><FONT COLOR=WHITE><b>Fee</b></FONT></TD>
	</TR>

	
	<%
//-------------- IMPROVEMENT SUBJECT ONLY


 qry123="Select SUBJECTID,subject,nvl(choice,0) abc,subjectrunning,decode(electivecode,'B', 1,null,2,'PDE',3,'DE',4)aa,electivecode,decode(electivecode,null,'Core','PDE','Elective(PDE)','DE','Elective(DE)','B','BackCore',subjecttype)subjecttype,semestertype,SEMESTER from (SELECT DISTINCT   A.SUBJECTID , NVL (a.subject, ' ')                 || '('                || NVL (a.subjectcode, ' ')                || ')' subject,                NVL (b.choice, 0) choice,                NVL (b.subjectrunning, ' ') subjectrunning,                NVL (b.electivecode, '') electivecode,                NVL (b.subjecttype, '') subjecttype,                NVL (b.semestertype, '') semestertype  ,b.SEMESTER         FROM subjectmaster a, pr#studentsubjectchoice b          WHERE  nvl(b.IMPROVEMENTSUBJECT,'')='Y' and  b.examcode = '"+mExamCode+"'            AND b.institutecode = '"+mInst+"'            AND b.semestertype = 'GIP'            AND b.subjecttype = 'C'            AND b.studentid = '"+mChkMemID+"'   and a.INSTITUTECODE=b.INSTITUTECODE          AND a.subjectid = b.subjectid            union       SELECT DISTINCT  A.SUBJECTID ,  NVL (a.subject, ' ')                || '('                || NVL (a.subjectcode, ' ')                || ')' subject,                NVL (b.choice, 0) choice,                NVL (b.subjectrunning, ' ') subjectrunning,                NVL (b.electivecode, '') electivecode,                NVL (b.subjecttype, '') subjecttype,                NVL (b.semestertype, '') semestertype    ,b.SEMESTER        FROM subjectmaster a, pr#studentsubjectchoice b          WHERE  NVL (b.improvementsubject, '') = 'Y' and  b.examcode = '"+mExamCode+"'             AND b.institutecode = '"+mInst+"'             AND b.semestertype = 'GIP'             AND b.subjecttype = 'E'             AND b.studentid = '"+mChkMemID+"'      and a.INSTITUTECODE=b.INSTITUTECODE        AND a.subjectid = b.subjectid                  ORDER BY subjecttype,electivecode)       order by aa,abc";	
							//out.println(qry123);
								rs12=db.getRowset(qry123);		
							while(rs12.next())
							{
									
SrNo1++;
								qry="select max(COURSECREDITPOINT)COURSECREDITPOINT from (Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT From PROGRAMSUBJECTTAGGING C where examcode='"+mExamCode+"'  And subjectid='"+rs12.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"'";
								qry=qry+" UNION Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT   From OfferSubjectTagging C where examcode='"+mExamCode+"'  And subjectid='"+rs12.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"'";
								qry=qry+" UNION Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT   From pr#electivesubjects C where examcode='"+mExamCode+"'  And subjectid='"+rs12.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"' )";
							//	out.print(qry);
								rsCCP=db.getRowset(qry);
								if (rsCCP.next())
								{
									mCCP=rsCCP.getDouble("COURSECREDITPOINT");
								}
								else
								{
									mCCP=0;
								}


					 			qrys="SELECT FEEAMOUNT FROM FEESTRUCTUREINDIVIDUAL WHERE INSTITUTECODE='"+mInst+"' AND FEEHEAD LIKE 'GIEF%' AND  STUDENTID='"+mChkMemID+"'  AND SEMESTER='"+rs12.getString("SEMESTER")+"' ";
			//	out.print(qrys);
				 rss=db.getRowset(qrys);
				if(rss.next())
								{
					mFeeAmt=rss.getInt("FEEAMOUNT");

					//mTot1=mTot+mFeeAmt;
								}
								

					//	ctot+=mCCP;

												%>
												<tr >
														<TD><b><%=SrNo1%></b></TD>
												<td><%=rs12.getString("subject")%></td>
												<td align=center><%=rs12.getString("SEMESTER")%></td>
												<td align=right>&nbsp;<%=mCCP%></td>
												<td align=center>&nbsp;<%=mFeeAmt%></td>
											
											
											</tr>
												<%
							}

												%>

	<tr><TD colspan=4 align=right><b>Total Credit: <%=ctot%></b></td>
	<TD>&nbsp; &nbsp;</TD>
	</tr>
	
	<tr><TD colspan=5 align=right><B>Payment Total Rs. &nbsp;&nbsp; <%=mTot%>/-</B></td>
	
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
