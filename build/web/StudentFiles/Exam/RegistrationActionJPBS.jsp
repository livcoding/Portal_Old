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
String FeeAmt="500";
String mSem="",mObjName="",mexamcode="",QryExam="",mPrevExmCode="",mComp="",Quota="";
String qrydebar="";
ResultSet  rsdebar=null;
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


if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


//out.print(mComp+"iksdfklsf");

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



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script language="JavaScript" type ="text/javascript">

function CheckProgram()
	{
		
		var chk=document.frm1.Checked;
	
		var tt=false;	

		if(chk.length==undefined  )
		{
			if(chk.checked==true)
			{
				tt=true;
			}
			
		}

		for(var i=0;i<chk.length;i++)
		{
			
		
			if(chk[i].checked==true)
			{
				tt=true;
			}
			
		}
		if(tt==false)
			{
				alert('Please Select the Subject');
					return false;
			}
			
	}
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



%>
<form name="frm" method=post>
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr>
			<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><u><b>SUPPLEMENTARY REGISTRATION FORM .
			
			</b></U>
			</font>
			</td>
			</tr>
			</table>
			<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
			<tr><td><font color=#00008b face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="Vardana"><%=GlobalFunctions.toTtitleCase(mName)%> [<%=mDMemberCode%>]</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="Vardana"><%=mProg%>(<%=mBranch%>)</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="Vardana"><%=mSem%></font></td></tr>
			<tr><td ALIGN=CENTER><HR><font color=#00008b face=arial size=2><STRONG>&nbsp; Exam Code</STRONG></font>
			<%
			qry="select distinct nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mInst+"' AND (eXAMCODE LIKE 'SUP%' ) and nvl(deactive,'N')='N' and nvl(LOCKEXAM,'N')='N'    order by examcode Desc";
			//out.println(qry);
			rs=db.getRowset(qry);
			%>
			<select name="exam" tabindex="0" id="exam" style="WIDTH: 200px">	
			<option selected value='' > << Select Exam Code  >>  </option>
			<%
			if(request.getParameter("x")==null)
			{
				while(rs.next())
				{
				 	mexamcode=rs.getString("examcode");
					if(mexamcode.equals(""))
						QryExam=mexamcode;
					%>
					<option value=<%=mexamcode%>><%=mexamcode%></option>
					<%
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
			&nbsp;<input type="submit" value="Show"></td></tr>
			</table>
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
			
		qry="Select EnrollmentNo enrollmentno,Studentname Name, StudentID , Semester, nvl(ProgramCODE,'UNK') ProgramCode, nvl(BranchCode,'UNK') BranchCode,quota From StudentMaster where studentid='"+mChkMemID+"' and InstiTuteCode='"+mInst+"'";
		//out.print(qry);
	 
  StudentRecordSet = db.getRowset(qry); 	
  if (StudentRecordSet.next())
  { 
	mEnrollment=StudentRecordSet.getString("enrollmentno");
	mSID=StudentRecordSet.getString("StudentID");
	mSname=StudentRecordSet.getString("Name");
	mProg=StudentRecordSet.getString("ProgramCode");
	mBranch=StudentRecordSet.getString("BranchCode");
	mSem=StudentRecordSet.getString("Semester");
	Quota=StudentRecordSet.getString("quota");
  }
//  out.print("sdfsdfsfsfd");

//*********12-03-2010***********************



String mSupFees="",mSumExam="";

qry="SELECT SUMMEREXAMCODE, PREVEXAMCODE, SUPFEES FROM EXAMMASTER where InstiTuteCode='"+mInst+"' and examcode='"+QryExam+"' and NVL(LOCKEXAM,'N')='N'";
out.println(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	mPrevExmCode=rs.getString("PREVEXAMCODE");
	mSupFees=rs.getString("SUPFEES");
	mSumExam=rs.getString("SUMMEREXAMCODE");
}


//*********12-03-2010***********************

/*qry="SELECT 'Y' FROM DEBARSTUDENTDETAIL WHERE EXAMCODE='"+mPrevExmCode+"' AND INSTITUTECODE='"+mInst+"' AND studentid='"+mChkMemID+"' and NVL(REGISTEREDSTATUS,'N')='N'";
//out.print(qry);
rs=db.getRowset(qry);
//rs1=db.getRowset(qry);
if(!rs.next())
{*/

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

<INPUT TYPE="hidden" NAME="EnrollmentNo" ID="EnrollmentNo" value="<%=mEnrollment%>">

<INPUT TYPE="hidden" NAME="StudentID" ID="StudentID" value="<%=mSID%>">

<INPUT TYPE="hidden" NAME="Name" ID="Name" value="<%=mSname%>">

<INPUT TYPE="hidden" NAME="ProgramCode" ID="ProgramCode" value="<%=mProg%>">

<INPUT TYPE="hidden" NAME="BranchCode" ID="BranchCode" value="<%=mBranch%>">

<INPUT TYPE="hidden" NAME="Semester" ID="Semester" value="<%=mSem%>">

<INPUT TYPE="hidden" NAME="quota" ID="quota" value="<%=Quota%>">


<INPUT TYPE="hidden" NAME="SupExamCode" ID="SupExamCode" value="<%=QryExam%>">


<INPUT TYPE="hidden" NAME="SummerExamCode" ID="SummerExamCode" value="<%=mSumExam%>">

<INPUT TYPE="hidden" NAME="PrevExmCode" ID="PrevExmCode" value="<%=mPrevExmCode%>">

	<TR bgcolor=white >
	<TD COLSPAN=5><b>&nbsp;&nbsp;</td>
	</TR>
	<TR><TD COLSPAN=5 >
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	<TR BGCOLOR=#ff8c00>
	<TD><FONT COLOR=WHITE><b>Slno</b></FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Code</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Name</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Semester</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Grade</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Credits</FONT></TD>
	<TD align=center><FONT COLOR=WHITE><b>Click to Select</b><sup>*</sup></FONT></TD>
	</TR>
     <%
	int sno=0,mFLAG=0;
	double ctot=0;
	String Checked="";
/*	qry="SELECT distinct a.enrollmentno en2,v.subjectid, v.subject, v.subjectcode, v.semester, b.grade,       e.coursecreditpoint, TO_CHAR (examperiodto, 'Month YYYY') exammonth  FROM studentmaster a,       studentresultdetail b,       exammaster d,       v#studentltpdetail v,       programsubjecttagging e WHERE a.institutecode =  '"+ mInst +"' and a.INSTITUTECODE=e.INSTITUTECODE and b.EXAMCODE=e.EXAMCODE   AND a.studentid = b.studentid   AND a.studentid = v.studentid   AND b.studentid = v.studentid   AND d.examcode = b.examcode   AND d.institutecode = a.institutecode   AND b.fstid = v.fstid   AND b.examcode = v.examcode   AND b.examcode = '"+mPrevExmCode+"'    AND b.grade LIKE '%F%'   AND a.studentid =  '"+mChkMemID+"'";*/
	
	qry="SELECT DISTINCT a.enrollmentno en2, v.subjectid subjectid, v.subject, v.subjectcode,                v.semester, b.grade, B.coursecreditpoint,                TO_CHAR (examperiodto, 'Month YYYY') exammonth           FROM studentmaster a,                studentresultdetail b,                exammaster d,                v#studentltpdetail v                       WHERE a.institutecode ='"+ mInst +"'            AND a.studentid = b.studentid            AND a.studentid = v.studentid            AND b.studentid = v.studentid            AND d.examcode = b.examcode            AND d.institutecode = a.institutecode    AND b.fstid = v.fstid            AND b.examcode = v.examcode            AND  b.examcode in( '"+mPrevExmCode+"','"+mSumExam+"')   AND NVL(b.fail,'N')='Y'  AND a.studentid =  '"+mChkMemID+"'  ";

if(	mInst.equals("JIIT"))
qry=qry+ "	AND  (v.subject NOT LIKE '%PROJECT%'            OR v.subject LIKE '%PROJECT MANAGEMENT%') " ;

	qry=qry+ " AND    SUBJECTID NOT IN (             SELECT SUBJECTID FROM debarstudentdetail WHERE (NVL (debar, 'N') = 'Y' or NVL (UFM, 'N') = 'Y')  AND institutecode ='"+ mInst +"'             AND examcode IN ('"+mPrevExmCode+"') AND studentid ='"+mChkMemID+"'              )";
	qry=qry+" UNION  SELECT DISTINCT a.enrollmentno en2, v.subjectid subjectid, v.subject, v.subjectcode,                v.semester, b.grade, B.coursecreditpoint,                TO_CHAR (examperiodto, 'Month YYYY') exammonth           FROM studentmaster a,                studentresultdetail b,                exammaster d,                v#studentltpdetail v                       WHERE a.institutecode ='"+ mInst +"'            AND a.studentid = b.studentid            AND a.studentid = v.studentid            AND b.studentid = v.studentid            AND d.examcode = b.examcode            AND d.institutecode = a.institutecode    AND b.fstid = v.fstid            AND b.examcode = v.examcode            AND  b.examcode in('"+mSumExam+"') AND NVL(b.fail,'N')='Y'  AND a.studentid =  '"+mChkMemID+"'  ";

if(	mInst.equals("JIIT"))
qry=qry+ "	AND  (v.subject NOT LIKE '%PROJECT%'            OR v.subject LIKE '%PROJECT MANAGEMENT%') " ;


	out.print(qry);
        StudentRecordSet = db.getRowset(qry); 	
int SrNo=0;
	while (StudentRecordSet.next())
	{
		SrNo++;
		/*
	qrydebar="SELECT 'Y' FROM DEBARSTUDENTDETAIL WHERE INSTITUTECODE ='"+ mInst +"'   and STUDENTID='"+mChkMemID+"'  AND  examcode in( '"+mPrevExmCode+"','"+mSumExam+"')   AND  SUBJECTID='"+StudentRecordSet.getString("subjectid")+"'  AND (NVL(DEBAR,'N')='Y'  or NVL (MEDICALCASE, 'N') = 'Y'  )";*/


/*
	qrydebar="SELECT 'Y' FROM DEBARSTUDENTDETAIL WHERE INSTITUTECODE ='"+ mInst +"'   and STUDENTID='"+mChkMemID+"'    AND  SUBJECTID='"+StudentRecordSet.getString("subjectid")+"'     AND (examcode IN ('"+mPrevExmCode+"') AND NVL (debar, 'N') = 'Y' OR NVL (medicalcase, 'N') = 'N')   AND (examcode NOT IN ('"+mSumExam+"') AND NVL (debar, 'N') = 'Y' ) ";*/


qrydebar="SELECT DISTINCT a.enrollmentno en2, v.subjectid subjectid, v.subject,                v.subjectcode, v.semester, b.grade, b.coursecreditpoint,   TO_CHAR (examperiodto, 'Month YYYY') exammonth    FROM studentmaster a,   studentresultdetail b,                exammaster d,                v#studentltpdetail v     WHERE a.institutecode = '"+ mInst +"'            AND a.studentid = b.studentid     AND a.studentid = v.studentid    AND b.studentid = v.studentid            AND d.examcode = b.examcode            AND d.institutecode = a.institutecode    AND b.fstid = v.fstid            AND b.examcode = v.examcode            AND B.examcode in( '"+mPrevExmCode+"','"+mSumExam+"')                    AND a.studentid = '"+mChkMemID+"' and (a.studentid,v.subjectid)  in             (select studentid,subjectid from  DEBARSTUDENTDETAIL where             EXAMCODE IN ( '"+mPrevExmCode+"')       and studentid='"+mChkMemID+"' AND INSTITUTECODE='"+ mInst +"'  AND (NVL (debar, 'N') = 'Y' or NVL (UFM, 'N') = 'Y')  AND  (a.studentid, v.subjectid)  IN (                   SELECT studentid, subjectid                     FROM debarstudentdetail                    WHERE examcode IN ( '"+mSumExam+"')                            AND studentid = '"+mChkMemID+"'                      AND institutecode = '"+ mInst +"'                       AND (NVL (debar, 'N') = 'Y' or NVL (UFM, 'N') = 'Y') )      and  (v.subject NOT LIKE '%PROJECT%'            OR v.subject LIKE '%PROJECT MANAGEMENT%') )";

		rsdebar=db.getRowset(qrydebar);
		//out.print(qrydebar);
		if(!rsdebar.next())
		{

	sno++;
	ctot+=StudentRecordSet.getDouble("CourseCreditPoint");

		qry1="SELECT 'Y' FROM SUPPLEMENTARYSUBJECTTAGGING WHERE INSTITUTECODE='"+ mInst +"' AND examcode in( '"+QryExam+"') AND  STUDENTID='"+mChkMemID+"' AND  SUBJECTID='"+StudentRecordSet.getString("subjectid")+"' ";	
		// out.print(qry1);
		rs1=db.getRowset(qry1);
		if(rs1.next())
		{
			mFLAG=1;
		}
	%>
	<TR>
	<TD><b><%=sno%></b></TD>
	<TD><b><%=StudentRecordSet.getString("SubjectCode")%></b></TD>
	<TD><b><%=StudentRecordSet.getString("Subject")%></b></TD>
	<TD><b><%=StudentRecordSet.getInt("Semester")%></b></TD>
	<TD><b><%=StudentRecordSet.getString("Grade")%></b></TD>
	<TD align=right><b><%=StudentRecordSet.getDouble("CourseCreditPoint")%></b></TD>
	<%
		if(mFLAG==1)
		{ 
			Checked="checked ";
		}
		else
		{
			Checked=" ";
		}
		%>
	<TD align=center>   <INPUT TYPE="checkbox" NAME="Checked<%=sno%>" <%=Checked%> id="Checked"></TD>
	<input type="hidden" name="sno" id="sno" value="<%=sno%>">
	<input type="hidden" name="SubjectID<%=sno%>" id="SubjectID<%=sno%>" value="<%=StudentRecordSet.getString("subjectid")%>">
	</TR>
	<%
	mFLAG=0;
	}
	}
	%>
	<input type="hidden" name="SrNo" id="SrNo" value="<%=SrNo%>">
	<tr><TD colspan=6 align=right><b><%=ctot%></b></td>
	<TD>&nbsp; &nbsp;</TD>
	</tr>
	<!-- <tr><TD colspan=6 align=right><B>Total No. of Subject(s) Registered: </B></td>
	<TD  align=center>_______</TD>
	</tr> -->
	<tr><TD colspan=6 align=right><font size=2><B>Payment @Rs. <%=mSupFees%> per subject:&nbsp;&nbsp; </B></font>&nbsp;</td>
	<TD align=center> <INPUT TYPE="submit" value="Click To Register" onclick="return CheckProgram();"> </TD>
	</tr> 
	</TABLE>
	</TD></TR>
	</TABLE>
<% int ss=0;
	qry="SELECT DISTINCT a.enrollmentno en2, v.subjectid subjectid, v.subject,                v.subjectcode, v.semester, b.grade, b.coursecreditpoint,   TO_CHAR (examperiodto, 'Month YYYY') exammonth    FROM studentmaster a,   studentresultdetail b,                exammaster d,                v#studentltpdetail v     WHERE a.institutecode = '"+ mInst +"'            AND a.studentid = b.studentid     AND a.studentid = v.studentid    AND b.studentid = v.studentid            AND d.examcode = b.examcode            AND d.institutecode = a.institutecode    AND b.fstid = v.fstid            AND b.examcode = v.examcode            AND B.examcode in( '"+mPrevExmCode+"','"+mSumExam+"')                    AND a.studentid = '"+mChkMemID+"' and (a.studentid,v.subjectid)  in             (select studentid,subjectid from  DEBARSTUDENTDETAIL where             EXAMCODE IN ( '"+mPrevExmCode+"')       and studentid='"+mChkMemID+"' AND INSTITUTECODE='"+ mInst +"'  AND (NVL (debar, 'N') = 'Y' or NVL (UFM, 'N') = 'Y')   )  AND  (a.studentid, v.subjectid)  IN (                   SELECT studentid, subjectid                     FROM debarstudentdetail                    WHERE examcode IN ( '"+mSumExam+"')                            AND studentid = '"+mChkMemID+"'                      AND institutecode = '"+ mInst +"'                       AND (NVL (debar, 'N') = 'Y'                           OR  NVL (UFM, 'N') = 'Y'                         ))      and  (v.subject NOT LIKE '%PROJECT%'            OR v.subject LIKE '%PROJECT MANAGEMENT%') ";

	/*qry=qry+" UNION ALL SELECT DISTINCT a.enrollmentno en2, v.subjectid subjectid, v.subject,                v.subjectcode, v.semester, b.grade, b.coursecreditpoint,                TO_CHAR (examperiodto, 'Month YYYY') exammonth           FROM studentmaster a,                studentresultdetail b,                exammaster d,                v#studentltpdetail v          WHERE a.institutecode = '"+ mInst +"'            AND a.studentid = b.studentid            AND a.studentid = v.studentid            AND b.studentid = v.studentid            AND d.examcode = b.examcode            AND d.institutecode = a.institutecode            AND b.fstid = v.fstid         AND b.examcode = v.examcode            AND  B.examcode in( '"+mPrevExmCode+"','"+mSumExam+"')                       AND a.studentid = '"+mChkMemID+"' and (a.studentid,v.subjectid)  in             (select studentid,subjectid from  DEBARSTUDENTDETAIL where            examcode in( '"+mPrevExmCode+"','"+mSumExam+"')  and studentid='"+mChkMemID+"' AND INSTITUTECODE='"+ mInst +"'  AND (NVL(DEBAR,'N')='Y'  or NVL (MEDICALCASE, 'N') = 'Y' )   )  AND v.subject LIKE '%PROJECT MANAGEMENT%' ";*/
	//out.print(qry);
	rs=db.getRowset(qry);
	rs1=db.getRowset(qry);
	if(rs1.next())
		    {
			%>
	<center>
	<font face=verdana color=red size=2 ><b>
	Due to you being debarred in a following subject(s) you are not allowed<br> to register for the same !
	</b></font>
	</center>
	
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	
	<TR BGCOLOR=#ff8c00>	
	<TD><FONT COLOR=WHITE><b>Slno</b></FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Code</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Name</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Semester</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Grade</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Credits</FONT></TD>
	</TR>
			<%
		}
		  while(rs.next())
		  {
		  ss++;
		  %>
		  <TR>
	<TD><b><%=ss%></b></TD>
	<TD><b><%=rs.getString("SubjectCode")%></b></TD>
	<TD><b><%=rs.getString("Subject")%></b></TD>
	<TD><b><%=rs.getInt("Semester")%></b></TD>
	<TD><b><%=rs.getString("Grade")%></b></TD>
	<TD align=right><b><%=rs.getDouble("CourseCreditPoint")%></b></TD>
	</tr>
		  <%
		}





		/*	}
			else
				{
				out.print("<center><font size=2 face=verdana color=red><b>Supplimentary Registration Done</b></font></center>");

				}*/

 // }
  
			/*}
			else
				{
					out.print("<center><font size=3 face=verdana color=red><b>Due to you being debarred in a certain exam you are not allowed<br> to register for the same !</b></font></center>");
				}*/

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
}
%>
  </body>
</html>
