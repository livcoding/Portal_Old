<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%  

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
String  qry1="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="",mInst="",mDMemberCode="",mWebEmail="";

ResultSet  StudentRecordSet=null; 	  
String qry="";
String mSname ="";
String mEnrollment="";
String mInstituteCode="",mInstName="";
String mSID="";

String mProg="";
String mBranch="";
String FeeAmt="500";
String mMonthYear="December 2009";
String mSem="",mObjName="",mexamcode="",QryExam="",mStudID="",mInstCode="";

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
	
if (request.getParameter("SID")==null)
{
	mStudID ="";
}
else
{
	mStudID =request.getParameter("SID").toString().trim();
}
if (request.getParameter("INSCODE")==null)
{
	mInst ="";
}
else
{
	mInst =request.getParameter("INSCODE").toString().trim();
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



String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE> <%=mHead%> [Supplimentary Registration Form for Registrar]</TITLE>
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
qry="Select WEBKIOSK.ShowLink('250','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

 qry="Select EnrollmentNo enrollmentno,Studentname Name, StudentID , Semester, nvl(ProgramCODE,'UNK') ProgramCode, nvl(BranchCode,'UNK') BranchCode From StudentMaster where studentid='"+mStudID+"' and InstiTuteCode='"+mInst+"'";
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
  }

//out.print("ASDAD");
%>
<form name="frm" method=post>
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr>
			<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><u><b>SUPPLIMENTARY REGISTRATION FORM 
			<br>LAST DATE OF RECIEPT IN REGISTRAR OFFICE - November 4th,2009 
			</b></U>
			</font>
			</td>
			</tr>
			</table>
			<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
			<tr><td><font color=#00008b face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="Vardana"><%=GlobalFunctions.toTtitleCase(mSname)%> [<%=mEnrollment%>]</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="Vardana"><%=mProg%>(<%=mBranch%>)</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="Vardana"><%=mSem%></font></td></tr>
			<tr><td ALIGN=CENTER><HR><font color=#00008b face=arial size=2><STRONG>&nbsp; Exam Code</STRONG></font>
			<%
			qry="select distinct nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mInst+"'";
			qry=qry+" and nvl(deactive,'N')='N' and EXAMCODE IN (SELECT EXAMCODE FROM STUDENTWISEGRADE where studentid='"+mSID+"' AND  institutecode='"+mInst+"'  ) order by examcode Desc";
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
			
		qry="Select EnrollmentNo enrollmentno,Studentname Name, StudentID , Semester, nvl(ProgramCODE,'UNK') ProgramCode, nvl(BranchCode,'UNK') BranchCode From StudentMaster where studentid='"+mSID+"' and InstiTuteCode='"+mInst+"'";
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
  }
//  out.print("sdfsdfsfsfd");
%>
	

	

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
		<td COLSPAN=5><b>Backlogs: (<sup>*</sup> Write 'YES' Against the Course You wish to Register)</td>
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
	<TD align=center><FONT COLOR=WHITE><b>YES</b><sup>*</sup></FONT></TD>
	</TR>
     <%
	int sno=0;
	double ctot=0;
	qry="SELECT distinct a.enrollmentno en2,v.subjectid, v.subject, v.subjectcode, v.semester, b.grade,       e.coursecreditpoint, TO_CHAR (examperiodto, 'Month YYYY') exammonth  FROM studentmaster a,       studentresultdetail b,       exammaster d,       v#studentltpdetail v,       programsubjecttagging e WHERE a.institutecode =  '"+ mInst +"' and a.INSTITUTECODE=e.INSTITUTECODE and b.EXAMCODE=e.EXAMCODE   AND a.studentid = b.studentid   AND a.studentid = v.studentid   AND b.studentid = v.studentid   AND d.examcode = b.examcode   AND d.institutecode = a.institutecode   AND b.fstid = v.fstid   AND b.examcode = v.examcode   AND b.examcode = '"+QryExam+"'    AND b.grade LIKE '%F%'   AND a.studentid =  '"+mSID+"'";
	
	// out.print(qry);
        StudentRecordSet = db.getRowset(qry); 	

	while (StudentRecordSet.next())
	{
	sno++;
	ctot+=StudentRecordSet.getDouble("CourseCreditPoint");
	%>
	<TR>
	<TD><b><%=sno%></b></TD>
	<TD><b><%=StudentRecordSet.getString("SubjectCode")%></b></TD>
	<TD><b><%=StudentRecordSet.getString("Subject")%></b></TD>
	<TD><b><%=StudentRecordSet.getInt("Semester")%></b></TD>
	<TD><b><%=StudentRecordSet.getString("Grade")%></b></TD>
	<TD align=right><b><%=StudentRecordSet.getDouble("CourseCreditPoint")%></b></TD>
	 
	<TD align=center>_______</TD>
	</TR>
	<%
	}
	%>
	<tr><TD colspan=6 align=right><b><%=ctot%></b></td>
	<TD>&nbsp; &nbsp;</TD>
	</tr>
	<tr><TD colspan=6 align=right><B>Total No. of Subject(s) Registered: </B></td>
	<TD  align=center>_______</TD>
	</tr>
	<tr><TD colspan=6 align=right><B>Payment @Rs. <%=FeeAmt%> per subject:&nbsp;&nbsp; </B>&nbsp;</td>
	<TD align=center><b>Rs.</B>_______</TD>
	</tr>

	</TABLE>
	</TD></TR>
	</TABLE>
	<hr>
	<p align=left>I Mr./Ms. <b><%=mSname%></b> hereby apply for the Supplementary Examination <B><%=QryExam%>SUP</B>. <br>I am enclosing a receipt of payment/demand draft of Rs. ................................... for .......................................... number of subjects @ Rs. <%=FeeAmt%>/- per subject.
	<br><br>
	<table width='100%' border=0 cellpadding= cellspacing=0>
<tr><td colspan=2 align=Right><b>Signature of Student</b></td></tr>
<tr><td>Place: </td><td align=Right><b>(<%=mSname%>)</b>
<tr><td>Date: </td><td align=Right><b>or &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<BR><br>(Signature of Representative of Student)<br></b></td></tr>
<tr><td colspan=2 align=Right>Name :&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td></tr>
<tr><td colspan=2 align=Right>Relationship with Student:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td></tr>
</table>




	<hr>
	<p><b>Receipt From Registrar Office</b>
	<p Align=Left>Received Registration Fee for Supplementary Examination (<B><%=QryExam%>SUP</B>) and receipt of Payment/DD form.
	<br>
	Enrollment Number: <b><%=mEnrollment%></b>   Student Name : <b><%=mSname%></b>
	
	<p align=right>Signature of representative of Registrar
	<br>
<br>
<br>
	<p align=left>Please retain this receipt as authority for the hostel students to avail of hostel facilities for the duration of supplementary exam.
<br>
	<p align=center><A style="CURSOR:hand" onClick="window.print();" title="Click here to print this Receipt"><font color=blue size=4><b>Click here to Print</b></font></a>
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
}
%>
  </body>
</html>
