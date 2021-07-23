<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="", qry2="";
String moldDate="";
int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="", mRightsID="";
String mSubj="", mSubjID="", mCtype="", mProg="",mSec="",mSub="";
String mExam="", mFaculty="", mFSTID="", mDate1="", mDate2="";
String mColor="", mLTP="", mTotal="";
String mCType="", mAttDate="", mClassFr="", mClassTo="";
double mPerc=0, mTotalStrength=0, mTotalPresent=0;

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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

	if (request.getParameter("RightsID").toString().trim()==null)
	{
		mRightsID="";
	}
	else
	{	
		mRightsID=request.getParameter("RightsID").toString().trim();
	}
	if (request.getParameter("EXAM").toString().trim()==null)
	{
		mExam="";
	}
	else
	{	
		mExam=request.getParameter("EXAM").toString().trim();
	}
	if (request.getParameter("FAC").toString().trim()==null)
	{
		mFaculty="";
	}
	else
	{
		mFaculty=request.getParameter("FAC").toString().trim();
	}
	if (request.getParameter("TYPE").toString().trim()==null)
	{
		mCType="";
	}
	else
	{
		mCType=request.getParameter("TYPE").toString().trim();
	}

	if (request.getParameter("SID").toString().trim()==null)
	{
		mSubjID="";
	}
	else
	{
		mSubjID=request.getParameter("SID").toString().trim();
	}

	if (request.getParameter("SC").toString().trim()==null)
	{
		mSubj="";
	}
	else
	{
		mSubj=request.getParameter("SC").toString().trim();
	}

	if (request.getParameter("LTP").toString().trim()==null)
	{
		mLTP="";
	}
	else
	{	
		mLTP=request.getParameter("LTP").toString().trim();
	}

	if (request.getParameter("PROG").toString().trim()==null)
	{
		mProg="";
	}
	else
	{	
		mProg=request.getParameter("PROG").toString().trim();
	}

	if (request.getParameter("SEC").toString().trim()==null)
	{
		mSec="";
	}
	else
	{	
		mSec=request.getParameter("SEC").toString().trim();
	}

	if (request.getParameter("SUB").toString().trim()==null)
	{
		mSub="";
	}
	else
	{	
		mSub=request.getParameter("SUB").toString().trim();
	}
	if (request.getParameter("AttDate").toString().trim()==null)
	{
		mAttDate="";
	}
	else
	{	
		mAttDate=request.getParameter("AttDate").toString().trim();
	}
	if (request.getParameter("ClassFr").toString().trim()==null)
	{
		mClassFr="";
	}
	else
	{	
		mClassFr=request.getParameter("ClassFr").toString().trim();
	}
	if (request.getParameter("ClassTo").toString().trim()==null)
	{
		mClassTo="";
	}
	else
	{	
		mClassTo=request.getParameter("ClassTo").toString().trim();
	}
	if (request.getParameter("TotClass").toString().trim()==null)
	{
		mTotal="";
	}
	else
	{	
		mTotal=request.getParameter("TotClass").toString().trim();
	}
	if (request.getParameter("Date1").toString().trim()==null)
	{
		mDate1="";
	}
	else
	{	
		mDate1=request.getParameter("Date1").toString().trim();
	}
	if (request.getParameter("Date2").toString().trim()==null)
	{
		mDate2="";
	}
	else
	{	
		mDate2=request.getParameter("Date2").toString().trim();
	}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student Attendance Report (Class Attendance History)]</TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
	qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
		%>
		<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr>
		<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Student wise Class Attendance Detail</b></font></td>
		</tr>
		</TABLE>
		<%
		String mSnm="", mENo="";
		qry="select Employeename, Employeecode from EmployeeMaster where EmployeeID='"+mFaculty+"'";
		rs1=db.getRowset(qry);
		if(rs1.next())
		{
			mSnm=rs1.getString(1);
			mENo=rs1.getString(2);
		}
		%>
		<table align=center>
		<tr><td align=center nowrap><font face=arial color="#00008b" size=2>Faculty: <B><%=mSnm%> [<%=mENo%>]</B>&nbsp; &nbsp;Program: <B><%=mProg%></B>&nbsp; &nbsp;Group: <B><%=mSec%>-<%=mSub%></B></font></td></tr>
		<tr><td align=center nowrap><font face=arial color="#00008b" size=2>Subject Code: <b><%=mSubj%></B>&nbsp; &nbsp;LTP: <B><%=GlobalFunctions.getLTPDescWSQ(mLTP)%></B>&nbsp; &nbsp;Class Time: <B><%=mAttDate%> [<%=mClassFr%>-<%=mClassTo%>]</B></font></td>
		</tr></table>
		<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="90%" border=1 >
		<thead>
		<tr bgcolor="#ff8c00">
		<td Title="Click to sort SNo"><b><font color="White">SNo</font></b></td>
		<td align=center nowrap Title="Click to Sort Enrollemnt No"><b><font color="White">Enrollment No</font></b></td>
		<td nowrap Title="Click to Sort Student Name"><b><font color="White">Student Name</font></b></td>
		<td nowrap Title="Click to Sort P/A"><b><font color="White">Attendance</font></b></td> 
		<td nowrap Title="Click to SortClass Type"><b><font color="White">Class Type</font></b></td> 
		</tr>
		</thead>
		<tbody>
		<%
		qry2="select nvl(ENROLLMENTNO,' ')ENRNO, nvl(STUDENTNAME,' ')STUDNM, decode(PRESENT,'Y','PRESENT','N','ABSENT','N/A')Attendance, DECODE(ATTENDANCETYPE,'R','REGULAR','EXTRA')CType";
		qry2=qry2+" from V#STUDENTATTENDANCE where EXAMCODE='"+mExam+"' And INSTITUTECODE='"+mInst+"'";
		qry2=qry2+" and ATTENDANCETYPE=Decode('"+mCType + "','ALL',ATTENDANCETYPE,'"+ mCType +"')";
		qry2=qry2+" and SUBJECTID='"+mSubjID+"' and LTP='"+mLTP+"'";
		qry2=qry2+" and ENTRYBYFACULTYID='"+mFaculty+"' and nvl(DEACTIVE,'N')='N'";
		qry2=qry2+" and ProgramCode='"+mProg+"' and Sectionbranch='"+mSec+"' and Subsectioncode='"+mSub+"'";
		qry2=qry2+" and AttendanceDate=to_date('"+mAttDate+"','dd-mm-yyyy') and to_char(ClassTimeFrom,'hh:mi PM')='"+mClassFr+"' and to_char(ClassTimeUpto,'hh:mi PM')='"+mClassTo+"'";
		qry2=qry2+" order by ENRNO";
		//out.print(qry2);
		rs=db.getRowset(qry2);
		mSNO=0;
		while(rs.next())
		{
          		mSNO++;
			if(rs.getString("Attendance").equals("PRESENT"))
				mColor="Green";
			else
				mColor="Red";
			%>
			<tr>
			<td nowrap><font face=arial><%=mSNO%>.</font></td>
			<td nowrap><font face=arial><%=rs.getString("ENRNO")%></font></td>
			<td nowrap><font face=arial><%=rs.getString("STUDNM")%></font></td>
			<td nowrap><font face=arial color=<%=mColor%>><B><%=rs.getString("Attendance")%></B></font></td>
			<td nowrap><font face=arial><%=rs.getString("CType")%></font></td>
			</tr>
			<%
		}
		%>
		</tbody>
		</TABLE>
		<script type="text/javascript">
		var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
		</script>
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
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}		
catch(Exception e)
{
}
%>
</body>
</html>
