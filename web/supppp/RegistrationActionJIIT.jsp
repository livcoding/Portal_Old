<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%  
/*

	' ********************************************************************************
	' *													   *
	' * File Name:	AppicationQueryActionJIIT.JSP		[For Students]				  
	' * Author:		Ashok Kumar Singh 							      
	' * Date:		20th March 2007								      
	' * Version:		1.1										
	' * Description:	Displays Application form status
	' **********************************************************************************
*/

ResultSet  StudentRecordSet=null; 	  
String qry="";
String mName ="";
String mValue="";
String mInstituteCode="",mInstName="";
String mSID="";
String mSname="";
String mProg="";
String mBranch="";
String FeeAmt="500";
String mMonthYear="December 2008";
String mSem="",mObjName="";
String pExamCode="2008ODDSEM";
try
{

mValue=request.getParameter("txtValue");
mInstituteCode=request.getParameter("InstCode");
DBHandler db=new DBHandler();
//out.print("ASDAD");
%>
<html>
   <head>
   <HEAD><CENTER><FONT COLOR = 'RED' FACE = 'VERDANA' SIZE=3 ><B>LAST DATE OF RECIEPT IN REGISTRAR OFFICE - DECEMEBER 24,2008</FONT></B></CENTER></HEAD>
       <title>Registration Form</title>		
 </head>
<body topmargin=5 rightmargin=0 leftmargin=0 bottommargin=0 bgcolor=LightGrey>
<center>
 
<% 

if (request.getParameter("txtValue")!=null && !mValue.equals(""))
{
  qry="Select Studentname Name, StudentID , Semester, nvl(ProgramCODE,'UNK') ProgramCode, nvl(BranchCode,'UNK') BranchCode From StudentMaster where nvl(EnrollmentNo,'*')='" + mValue  + "' and InstiTuteCode='"+mInstituteCode+"'";
//out.print(qry);
	 
  StudentRecordSet = db.getRowset(qry); 	
  if (StudentRecordSet.next())
  { 

	mSID=StudentRecordSet.getString("StudentID");
	mSname=StudentRecordSet.getString("Name");
	mProg=StudentRecordSet.getString("ProgramCode");
	mBranch=StudentRecordSet.getString("BranchCode");
	mSem=StudentRecordSet.getString("Semester");
      qry = "Select nvl(INSTITUTENAME,INSTITUTECODE) INSTITUTENAME From INSTITUTEMASTER where InstiTuteCode='"+mInstituteCode+"' and nvl(deactive,'N')='N'";

 

      StudentRecordSet = db.getRowset(qry); 	
	if (StudentRecordSet.next())
	  	mInstName=StudentRecordSet.getString("INSTITUTENAME");
	else
		mInstName=mInstituteCode;
  
%>
	<table align=center width='100%' cellpading=0 cellspacing=0 border=1>	
	<Tr>
	<td colspan=5>
     <table width=100%>
	<tr>
		<td nowrap align=center><font face='Verdana' size=3 color=black><b><%=mInstName%><b><font></td>		 
	</Tr>
	<Tr>
		<td  align=center><font face='Verdana' size=3 color=black><b>SUPPLEMENTARY EXAMINATION<b><font></td>
		 
	</Tr>
	<Tr>
		<td  align=center><font face='Verdana' size=2 color=black><b>REGISTRATION FORM</b></font></font></td>

	</Tr>

	<Tr>
		<td align=right><font face='Verdana' size=2 color=black><font face='Verdana' size=2 color=black><b>Exam Code: <%=pExamCode%></b></font></td>

	</Tr>

	</table>
	</td>
	</tr>
	<tr bgcolor=black>
	<td><FONT COLOR=WHITE><b>Enrollment No</b></font></td>
	<td><FONT COLOR=WHITE><b>Student Name</b></font></td>
	<td><FONT COLOR=WHITE><b>Programme</b></font></td>
	<td><FONT COLOR=WHITE><b>Branch</b></font></td>
	<td><FONT COLOR=WHITE><b>Semester</b></font></td>
	</tr>
	<tr bgcolor='#dcdcdc'>
	<td><FONT COLOR=black><b><%=mValue%></b></font></td>
	<td><FONT COLOR=black><b><%=mSname%></b></font></td>
	<td><FONT COLOR=black><b><%=mProg%></b></font></td>
	<td><FONT COLOR=black><b><%=mBranch%></b></font></td>
	<td><FONT COLOR=black><b><%=mSem%></b></font></td>
	</tr>

	<Tr bgcolor=white>
		<td COLSPAN=5><b>Backlogs: (<sup>*</sup> Write 'YES' Against the Course You wish to Register)</td>
	</Tr>

	<TR><TD COLSPAN=5>
	<TABLE width=100% cellpadding=0 cellspacing=0 border=1>
	<TR BGCOLOR=BLACK>
	<TD><FONT COLOR=WHITE>Slno</FONT></TD>
	<TD><FONT COLOR=WHITE>Code</FONT></TD>
	<TD><FONT COLOR=WHITE>Subject</FONT></TD>
	<TD><FONT COLOR=WHITE>Sem</FONT></TD>
	<TD><FONT COLOR=WHITE>Grade</FONT></TD>
	<TD><FONT COLOR=WHITE>Credits</FONT></TD>
	<TD align=center><FONT COLOR=WHITE>YES<sup>*</sup></FONT></TD>
	</TR>
     <%
	int sno=0;
	double ctot=0;
	/*qry = " Select Subject,b.SubjectCode SubjectCode, b.Semester Semester, Grade, CourseCreditPoint ";
	qry =	qry+" from StudentMaster a, StudentResultDetail b, SubjectMaster C  ";
	qry =	qry+" Where a.InstituteCode  = '" + mInstituteCode +"'";
	qry =	qry+" And     a.StudentID       = b.Studentid ";
	qry =	qry+" And     b.SubjectCode   = c.SubjectCode ";
	qry =	qry+" And     b.ExamCode      = '"+pExamCode +"'";
	qry =	qry+" And     b.Grade         = 'F' ";
	qry =	qry+" And    a.StudentID      = '"+mSID +"'";
	qry =	qry+" And    b.SubjectCode not in ('07B53CI981','07B71BT901','07B71CI901','07B71EC901','07M31CI901','07M31EC901','07M31PM901','BT 910P','EC805P') ";
	qry =	qry+" Order By   b.Semester,b.SubjectCode ";
	*/

	qry="select a.Enrollmentno en2, V.Subject,  V.SubjectCode, V.Semester, B.Grade, CourseCreditPoint, to_Char(ExamPeriodTo,'Month YYYY') ExamMonth ";
	qry=qry+" from StudentMaster a, StudentResultDETAIL b, ExamMaster D,v#studentltpdetail V Where a.InstituteCode  = '"+ mInstituteCode  +"' And     a.StudentID       = b.Studentid ";
	qry=qry+" And     a.StudentID       = v.Studentid And     B.StudentID       = V.Studentid And     d.ExamCode = b.ExamCode And d.InstituteCode   = a.InstituteCode ";
	qry=qry+" And     b.FSTID           = V.FSTID AND     B.ExamCode        = V.EXAMCODE And     b.ExamCode  = '"+pExamCode+"' And b.Grade like '%F%'  And    a.StudentID= '"+mSID+"'";
	// out.print(qry);
        StudentRecordSet = db.getRowset(qry); 	

	while (StudentRecordSet.next())
	{
	sno++;
	ctot+=StudentRecordSet.getDouble("CourseCreditPoint");
	%>
	<TR>
	<TD><%=sno%></TD>
	<TD><%=StudentRecordSet.getString("SubjectCode")%></TD>
	<TD><%=StudentRecordSet.getString("Subject")%></TD>
	<TD><%=StudentRecordSet.getInt("Semester")%></TD>
	<TD><%=StudentRecordSet.getString("Grade")%></TD>
	<TD align=right><%=StudentRecordSet.getDouble("CourseCreditPoint")%></TD>
	 
	<TD align=center>_______</TD>
	</TR>
	<%
	}
	%>
	<tr><TD colspan=6 align=right><%=ctot%></td>
	<TD>&nbsp; &nbsp;</TD>
	</tr>
	<tr><TD colspan=6 align=right>Total No. of Subject(s) Registered: </td>
	<TD  align=center>_______</TD>
	</tr>
	<tr><TD colspan=6 align=right>Payment @Rs. <%=FeeAmt%> per subject: Rs.&nbsp;</td>
	<TD align=center>_______</TD>
	</tr>

	</TABLE>
	</TD></TR>
	</TABLE>
	<hr>
	<p align=left>I Mr./Ms. <%=mSname%> hereby apply for the Supplementary Examination <%=mMonthYear%>. <br>I am enclosing a receipt of payment/demand draft of Rs. ................................... for .......................................... number of subjects @ Rs. <%=FeeAmt%>/- per subject.
	<br><br>
	<table width='100%' border=0 cellpadding= cellspacing=0>
<tr><td colspan=2 align=Right><b>Signature of Student</b></td></tr>
<tr><td>Place: </td><td align=Right><b>(<%=mSname%>)</b>
<tr><td>Date: </td><td align=Right><b>or &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<BR><br>(Signature of Representative of Student)<br></b></td></tr>
<tr><td colspan=2 align=Right>Name :&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td></tr>
<tr><td colspan=2 align=Right>Relationship with Student:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td></tr>
</table>




	<hr>
	<p><b>Receipt from Registrar Office</b>
	<p Align=Left>Received Registration Fee for Supplementary examination (<%=pExamCode%>) and receipt of payment/DD form.
	<br>
	Enrollment Number: .............................   Student Name : ..............................
	
	<p align=right>Signature of representative of Registrar
	<br>
<br>
<br>
	<p align=left>Please retain this receipt as authority for the hostel students to avail of hostel facilities for the duration of supplementary exam.
<br>
	<p><A style="CURSOR:hand" onClick="window.print();" title="Click here to print this Receipt"><font color=blue>Click here to Print</font></a>
<%

  }
  else
  {
	%>
		<Center>
		<font color=red size=6><u>Sorry !</u></Center><br>
		<hr>
		<Center>
		<font color=Red size=4>No Such Enrollment Number found....</font></Center>
		<hr><br><br>
	<%	
  }

  }
  else
  {
	%>
		<Center>
		<font color=red size=6><u>Sorry !</u></Center><br>
		<hr>
		<Center>
		<font color=Red size=4>Please enter a Valid Enrollment Number</font></Center>
		<hr><br><br>
	<%	
  }



}
catch(Exception e)
{

}
%>

  </body>
</html>
