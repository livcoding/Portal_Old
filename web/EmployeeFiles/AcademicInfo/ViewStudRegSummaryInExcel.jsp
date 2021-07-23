<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

DBHandler db = new DBHandler();
ResultSet rs = null, rss = null;
GlobalFunctions gb = new GlobalFunctions();
String qry = "";
int CTR=0, TotStudAllow=0, TotStudConf=0, TotStudNotConf=0, TotalStudFeePaid=0, TotAllow=0, TotRegConf=0, TotRegNConf=0, TotFeePaid=0;
String mMemberID="", mDMemberID="", mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="", mMemberName="";
String mInst = "", mComp = "", mSrcType = "", mRightsID="", qsysdate="", mOldData="", mDataType="", mViewType="";
String mExam = "", qryexam="", mProgram="", mBranch="", mSemester="", mRegCode="", TopMessage="";

if (session.getAttribute("InstituteCode") == null) 
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

if (session.getAttribute("CompanyCode") == null)
	mComp = "";
else
	mComp = session.getAttribute("CompanyCode").toString().trim();

%>
<HTML>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
 <title>Hide Stuff and Print</title>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
		qry = "select to_Char(Sysdate,'dd-mm-yyyy hh:mi PM') date1 from dual";
		rs = db.getRowset(qry);
		if (rs.next()) 
                 	qsysdate = rs.getString(1);
		else
			qsysdate = "";
		//----------------------
		if(request.getParameter("ExamCode")==null)
			qryexam="";
		else
			qryexam=request.getParameter("ExamCode").toString().trim();

		if(request.getParameter("DataType")==null)
			mDataType="SUM";
		else
			mDataType=request.getParameter("DataType").toString().trim();

		if(request.getParameter("ViewType")==null)
			mViewType="";
		else
			mViewType=request.getParameter("ViewType").toString().trim();

		//out.print(qryexam);

		if(mViewType.equals("ALW"))
			TopMessage="List of Registration Allowed Students";
		else if(mViewType.equals("CNF"))
			TopMessage="List of Registration Confirmed Students";
		else if(mViewType.equals("NCNF"))
			TopMessage="List of Registration Not Confirmed Students";
		else if(mViewType.equals("PAID"))
			TopMessage="List of Fees Paid Students";
		else
			TopMessage="Student Registration Summary";
		%>
		<START OF FILE>
		<%@page contentType="text/html"%>
	   	<%
		response.setContentType("application/vnd.ms-excel");
		%>
	      <center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><B><U><%=TopMessage%></U></b></font></Center>
		<%

		qry="Select RegCode from StudentRegistration where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"'";
		rs=db.getRowset(qry);
		if(rs.next())
			mRegCode=rs.getString("RegCode");

		//out.print("Default Exam Code - "+qryexam);
		if(mDataType.equals("SUM"))
		{
			%>
			<BR>
			<table bgcolor=white border=2 bordercolor=navy align=center>
			<tr bgcolor=white>
			<td Nowrap colspan=8 align=center><Font color=navy face=arial size=2><B>Registration Code - </B><%=mRegCode%></font></td>
			</tr>
			</table>
			<%
		}
		%>
		<BR>
		<CENTER><Font face=arial size=2 color=navy><B>Summary as on : <U><%=qsysdate%></U></B></FONT></CENTER>
		<table bgcolor=#fce9c5 class="sort-table" id="table-2" align=center topmargin=0 cellspacing=0 cellpadding=0 border=1 rules=rows>
		<%
//-----------------------------------------
		if(mDataType.equals("SUM"))
//-----------------------------------------
		{
			qry="SELECT DISTINCT PROGRAMCODE, SECTIONBRANCH, SEMESTER FROM STUDENTREGISTRATION WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' ORDER BY PROGRAMCODE, SECTIONBRANCH, SEMESTER";
			//out.print(qry);
			rs=db.getRowset(qry);
			while(rs.next())
			{
				if(CTR==0)
				{
					%>
					<THEAD>
					<TR bgcolor="#ff8c00">
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Serial Number">SNo.</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Program Running in the selected Exam Code">Program</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Branch Running in the selected Exam Code / Program">Branch</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Semester Running in the selected Exam Code / Program / Branch">Semester</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Total Student whose RegAllow='Y'">Total Student</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Total Student whose RegConfirmation='Y'">Registered</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Total Student whose RegConfirmation='N'">Not Registered</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Total Student whose Fee is Paid">Fee Paid</font></b></TD>
					</TR>
					</THEAD>
					<TBODY>
					<%
				}
				mProgram=rs.getString(1);
				mBranch=rs.getString(2);
				mSemester=rs.getString(3);

				qry="select count(*)TotStudAllow from StudentRegistration Where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"' Group By PROGRAMCODE, SECTIONBRANCH, SEMESTER ";
				//out.print(qry);
				rss=db.getRowset(qry);
				if(rss.next())
					TotStudAllow=rss.getInt("TotStudAllow");

				qry="select count(*)TotStudConf from StudentRegistration Where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(REGCONFIRMATION,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"' Group By PROGRAMCODE, SECTIONBRANCH, SEMESTER ";
				//out.print(qry);
				rss=db.getRowset(qry);
				if(rss.next())
					TotStudConf=rss.getInt("TotStudConf");

				qry="select count(*)TotStudNotConf from StudentRegistration Where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(REGCONFIRMATION,'N')='N' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"' Group By PROGRAMCODE, SECTIONBRANCH, SEMESTER ";
				//out.print(qry);
				rss=db.getRowset(qry);
				if(rss.next())
					TotStudNotConf=rss.getInt("TotStudNotConf");

				qry="select count(*)TotalStudFeePaid from StudentRegistration Where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(FEESPAID,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"' Group By PROGRAMCODE, SECTIONBRANCH, SEMESTER ";
				//out.print(qry);
				rss=db.getRowset(qry);
				if(rss.next())
					TotalStudFeePaid=rss.getInt("TotalStudFeePaid");

				CTR++;

				%>
				<TR>
				<TD bgcolor=white align=left><Font face=Arial size=2><B><%=CTR%></B>.</Font></TD>
				<%
				if(!mOldData.equals(mProgram))
				{
					mOldData=mProgram;
					%>
					<TD bgcolor=white align=left><Font face=Arial size=2><%=mProgram%></Font></TD>
					<%
				}
				else
				{
					%>
					<TD bgcolor=white align=left><Font face=Arial size=2>&nbsp;</Font></TD>
					<%
				}
				%>
				<TD bgcolor=white align=left><Font face=Arial size=2><%=mBranch%></Font></TD>
				<TD bgcolor=white align=center><Font face=Arial size=2><%=mSemester%></Font></TD>
				<TD bgcolor=white align=center><Font face=Arial color=blue size=2><%=TotStudAllow%></Font></TD>
				<TD bgcolor=white align=center><Font face=Arial color=blue size=2><%=TotStudConf%></Font></TD>
				<TD bgcolor=white align=center><Font face=Arial color=blue size=2><%=TotStudNotConf%></Font></TD>
				<TD bgcolor=white align=center><Font face=Arial color=blue size=2><%=TotalStudFeePaid%></Font></TD>
				</TR>
				<%
				TotAllow=TotAllow+TotStudAllow;
				TotRegConf=TotRegConf+TotStudConf;
				TotRegNConf=TotRegNConf+TotStudNotConf;
				TotFeePaid=TotFeePaid+TotalStudFeePaid;

				TotStudAllow=0;
				TotStudConf=0;
				TotStudNotConf=0;
				TotalStudFeePaid=0;
			}
			%>
			<TR>
			<TD bgcolor=white align=right colspan=4><Font Color=Black face=Arial size=2><B>Total Count - </B></Font></TD>
			<TD bgcolor=white align=center><Font Color=Blue face=Arial size=2><B><%=TotAllow%></B></Font></TD>
			<TD bgcolor=white align=center><Font Color=Green face=Arial size=2><B><%=TotRegConf%></B></Font></TD>
			<TD bgcolor=white align=center><Font Color=Red face=Arial size=2><B><%=TotRegNConf%></B></Font></TD>
			<TD bgcolor=white align=center><Font Color=Green face=Arial size=2><B><%=TotFeePaid%></B></Font></TD>
			</TR>
			</TBODY>
			<%
		}
//-----------------------------------------
		else if(mDataType.equals("DET"))
//-----------------------------------------
		{
			if(request.getParameter("Program")==null)
				mProgram="";
			else
				mProgram=request.getParameter("Program").toString().trim();

			if(request.getParameter("Branch")==null)
				mBranch="";
			else
				mBranch=request.getParameter("Branch").toString().trim();

			if(request.getParameter("Sem")==null)
				mSemester="";
			else
				mSemester=request.getParameter("Sem").toString().trim();

			//out.print(mDataType+" "+mViewType+" "+qryexam+" "+mProgram+" "+mBranch+" "+mSemester);

			if(mViewType.equals("ALW"))
			{
				qry="Select EnrollmentNo, StudentName From StudentMaster where institutecode='"+mInst+"' and studentid in (select studentid from StudentRegistration where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"') ORDER BY EnrollmentNo";
			}
			else if(mViewType.equals("CNF"))
			{
				qry="Select EnrollmentNo, StudentName From StudentMaster where institutecode='"+mInst+"' and studentid in (select studentid from StudentRegistration where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(REGCONFIRMATION,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"') ORDER BY EnrollmentNo";
			}
			else if(mViewType.equals("NCNF"))
			{
				qry="Select EnrollmentNo, StudentName From StudentMaster where institutecode='"+mInst+"' and studentid in (select studentid from StudentRegistration where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(REGCONFIRMATION,'N')='N' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"') ORDER BY EnrollmentNo";
			}
			else if(mViewType.equals("PAID"))
			{
				qry="Select EnrollmentNo, StudentName From StudentMaster where institutecode='"+mInst+"' and studentid in (select studentid from StudentRegistration where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(FEESPAID,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"') ORDER BY EnrollmentNo";
			}
			//out.print(qry);
			rs=db.getRowset(qry);
			%>
			<table bgcolor=white border=2 bordercolor=navy align=center>
			<tr bgcolor=white>
			<td Nowrap colspan=3>
			<Font color=navy face=arial size=2><B>Registration Code - </B><%=mRegCode%></font>
			&nbsp; 
			<Font color=navy face=arial size=2><B>Program - </B><%=mProgram%></font>
			&nbsp; 
			<Font color=navy face=arial size=2><B>Branch - </B><%=mBranch%></font>
			</td>
			</tr>
			</table>
			<BR>
			<table bgcolor=#fce9c5 class="sort-table" id="table-2" align=center topmargin=0 cellspacing=0 cellpadding=0 border=1>
			<%
			while (rs.next())
			{
				CTR++;
				if(CTR==1)
				{
					%>
					<THEAD>
					<TR bgcolor="#ff8c00">
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Serial Number">SNo.</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Serial Number">Enrollment No.</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Serial Number">Student Name</font></b></TD>
					</TR>
					</THEAD>
					<TBODY>
					<%
				}
				%>
				<TR>
				<TD bgcolor=white align=left><Font face=Arial size=2><B><%=CTR%></B>.</Font></TD>
				<TD bgcolor=white align=left><Font face=Arial size=2><%=rs.getString("EnrollmentNo")%></Font></TD>
				<TD bgcolor=white align=left><Font face=Arial size=2><%=rs.getString("StudentName")%></Font></TD>
				</TR>
				<%
			}
			%>
			</TBODY>
			<%
//-----------------------------------------
		}
//-----------------------------------------
		%>
		</TABLE>
		<END OF FILE>
		<%
} catch (Exception e)
{
}
%>
</body>
</html>