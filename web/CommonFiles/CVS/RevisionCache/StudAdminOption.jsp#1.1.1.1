
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%

String mHead="",mInstCode ="",mStudID="";
String mCandCode="", MName="";
String mCandName="";
String mMemberName="";
String mmMemberName="";
String mCompanyCode="";



if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Students Profile/available information ] </TITLE>


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>
 
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>

<body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<br><br>
<%
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String qry="",x="";
int msno=0;
ResultSet rs=null;

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
	mmMemberName=GlobalFunctions.toTtitleCase(mMemberName.trim());
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
  
if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}

/*if (session.getAttribute("InstituteCode")==null)
{
	mInstCode ="JIIT";
}
else
{
	mInstCode =session.getAttribute("InstituteCode").toString().trim();
}
*/

if (request.getParameter("SID")==null)
{
	mStudID ="";
}
else
{
	mStudID =request.getParameter("SID").toString().trim();
}


if (session.getAttribute("INSCODE")==null)
{
	mInstCode="";
}
else
{
	mInstCode=session.getAttribute("INSCODE").toString().trim();
}

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

		qry="Select WEBKIOSK.ShowLink('71','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
		  //----------------------
			qry="Select nvl(ACADEMICYEAR,' ') ACADEMICYEARCODE, nvl(ENROLLMENTNO,' ') ENROLLMENTNO, nvl(STUDENTNAME,' ') STUDENTNAME, nvl(PROGRAMCODE,' ') COURSECODE, nvl(BRANCHCODE,' ') BRANCHCODE,nvl(Semester,0) Semester , StudentID SID from StudentMaster  where InstituteCode=decode( '"+mInstCode +"','All',InstituteCode,'"+mInstCode +"') and StudentID='"+mStudID+"' and enrollmentno is not null order by StudentName,AcademicYearCode";
			rs=db.getRowset(qry);
		//out.print(qry);
			if(rs.next())
			  {
			%>
			<table width=90% valign=middle align=center border=1 bordercolor=brown cellpadding=2 cellspacing=1>
			<tr><td bgcolor='#b22222' colspan=2 align=center><font size=4 color=white face="verdana"><b>Student Information System [SIS]</b></font></td></tr>
			<tr><td><font color='#b22222' face="verdana" size=2><b>Enrollment No.:<%=rs.getString("EnrollmentNo")%></b></font></td>
				<td><font color='#b22222' face="verdana" size=2><b>Student Name: <%=rs.getString("StudentName")%></b></font></td>
			 </tr>
				 <td><font color='#b22222' face="verdana" size=2><b>Academic Year: <%=rs.getString("AcademicYearCode")%></b></font> </td>
				<td><font color='#b22222' face="verdana" size=2><b>Present Semester: <%=rs.getString("Semester")%></b></font></td>
			 </tr>
			 <tr><td colspan=2><font color='#b22222' face="verdana" size=2><b>Program-Branch: <%=rs.getString("CourseCode")%>-<%=rs.getString("BranchCode")%>
				</b></font></td>
			</tr>

			<tr><td colspan=2 align=center><font size=4 color=DarkBrown face='Arial'><br><b>Available Options</b></font></td></tr>
			<tr>
			<td colspan=2><b>
			<p><font color=Blue><UL type="square"><br>
				<%
				qry="Select WEBKIOSK.ShowLink('22','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
				    
			         <li><a href='ADMNStudPersonalInfo.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='Students Personal information' Target=_NEW><font size=4 color=Blue face='Arial'><b>Student Personal information/Address</b></font>
				  <%
				   }

				qry="Select WEBKIOSK.ShowLink('25','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
			        <li><a href='EmpStudEventMarksView.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='Students Examination Marks (Event/Sub Eventwise)' Target=_NEW><font size=4 color=Blue face='Arial'><b>Student Examination (Event/Sub Event) Marks</b></font>
				  <%
				   }

		
				qry="Select WEBKIOSK.ShowLink('139','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
			        <li><a href='EmpStudSCPACGPAView.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='View Students SCPA/CGPA .........' Target=_NEW><font size=4 color=Blue face='Arial'><b>Student SGPA/CGPA</b></font>
				  <%
				   }


				qry="Select WEBKIOSK.ShowLink('23','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
 			        <li><a href='AdminStudentEventGradesView.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='Students End-Sem/Final Marks/Grade' Target=_NEW><font size=4 color=Blue face='Arial'><b>Student Grades</b></font>

				  <%
				   }
				
				qry="Select WEBKIOSK.ShowLink('159','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
 			        <li><a href='AdminChangeStudGrade.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='Change Student Grade' Target=_NEW><font size=4 color=Red face='Arial'><b>Student Grade Change Request</b></font>

				  <%
				   }
				qry="Select WEBKIOSK.ShowLink('159','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
 			       <%-- <li><a href='AdminApproveChangedStudGrade.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='Approve Changed Student Grade' Target=_NEW><font size=4 color=Red face='Arial'><b>Approve Changed Student Grade</b></font>--%>
				  <%
				   }

			
			
				qry="Select WEBKIOSK.ShowLink('80','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
			        <li><a href='ADMINStudSubjView.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='Opted Subjects of Students'  Target=_NEW><font size=4 color=Blue face='Arial'><b>Opted Subjects of Students</b></font>
				  <%
				   }
				
				qry="Select WEBKIOSK.ShowLink('150','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				%>
			        <li><a href='ADMNStudRegFee.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>'  Title='Students Paid Course fee detail' Target=_NEW><font size=4 color=Blue face='Arial'><b>Course Fees paid by Students</b></font>
				<%
				  }
				qry="Select WEBKIOSK.ShowLink('87','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
			        <li><a href='ADMINStudAttendance.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='Classwise/Subjectwise Students Attendance Information' Target=_NEW><font size=4 color=Blue face='Arial'><b>Batch/Subject-wise Student Attendance</b></font>
				  <%
				   }
				qry="Select WEBKIOSK.ShowLink('24','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      //out.println(qry);
		      RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
			        <li><a href='ADMNStudQualification.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='Students Qualification information' Target=_NEW><font size=4 color=Blue face='Arial'><b>Student Qualifications</b></font>
				  <%
				   }
			qry="Select WEBKIOSK.ShowLink('33','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	
		      	//out.println(qry);
		      	
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				   {
				  %>
			      <li><a href='adminstudsubjectfaculty.jsp?INSCODE=<%=mInstCode%>&amp;SID=<%=mStudID%>' Title='Students Qualification information' Target=_NEW><font size=4 color=Blue face='Arial'><b>Student Subject Faculty</b></font>
				  <%
				}

				qry="Select WEBKIOSK.ShowLink('153','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				{
					%>
			      	<li><a href='ADMNEmpStudDrCrAdvice.jsp?INSCODE=<%=mInstCode%>&amp;mType=S&amp;SID=<%=mStudID%>' Title='Debit/Credit Advive of Student' Target=_NEW><font size=4 color=Blue face='Arial'><b>Debit Credit Advice</b></font>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('210','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	   			RsChk1=db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				{
					%>
			      	<li><a href='StudentDisciplinaryAction.jsp?INSCODE=<%=mInstCode%>&amp;mType=S&amp;SID=<%=mStudID%>' Title='View Student Disciplinary Action' Target=_NEW><font size=4 color=Blue face='Arial'><b>Disciplinary Message (taken by the institute if any)</b></font>
					<%
				}
			
				qry="Select WEBKIOSK.ShowLink('250','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	   			RsChk1=db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				{
					%>
			      	<li><a href='SupRegistrationForm.jsp?INSCODE=<%=mInstCode%>&amp;mType=S&amp;SID=<%=mStudID%>' Title='View Supplimentary Registration Form' Target=_NEW><font size=4 color=Blue face='Arial'><b>Supplimentary Registration Form</b></font>
					<%
				}
				%>

			</OL></b></font>
			</p>
			</td>
			</tr>
			</TABLE>
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
		<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
		<P>	This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font>	<br>	<br>	<br>	<br>
	   <%
	   }
	  //-----------------------------
  }
  else
  {
	out.print("<br><img src='Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
  }
%>
</body>
</html>
