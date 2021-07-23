<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="";

int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";

String mSubj="", mSubjID="", mCtype="", mProg="",mSec="",mSub="";
String mExam="", mFaculty="";
String mLTP="", mDate1="", mDate2="";
String mExcuse="";
String mAttendanceDate="", mClassFrom="", mClassUpto="";
String mEmpID="";
String mCType="";
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
<TITLE>#### <%=mHead%> [Student Attendance Report (Class Excused History)]</TITLE>
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
	qry="Select WEBKIOSK.ShowLink('87','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
			if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Class Excused Detail</b></font></td>
</tr>
</TABLE>
<%
String mSnm="", mENo="";
qry="select Employeename, Employeecode from EmployeeMaster where EmployeeID='"+mFaculty+"'";
//Decode('"+mFaculty + "','ALL',EmployeeID,'"+ mFaculty +"')";
rs1=db.getRowset(qry);
if(rs1.next())
{
mSnm=rs1.getString(1);
mENo=rs1.getString(2);
}
%>
<table width="100%">
<tr><td align=center><font face=arial color="#00008b">Faculty: <B><%=mSnm%> [<%=mENo%>]</B>&nbsp; &nbsp;Program: <B><%=mProg%></B>&nbsp; &nbsp;Group: <B><%=mSec%>-<%=mSub%></B></font></td></tr>
<tr><td align=center><font face=arial color="#00008b">Subject Code: <b><%=mSubj%></B>&nbsp; &nbsp;LTP: <B><%=GlobalFunctions.getLTPDescWSQ(mLTP)%></B></font></td>
</tr></table>
 <TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="90%" border=1 >
<thead>
<tr bgcolor="#ff8c00">
 <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td nowrap Title="Click on Date to Sort"><b><font color="White">Date</font></b></td>
 <td align=center nowrap Title="Click on Date to Sort"><b><font color="White">Period</font></b></td>
 <td nowrap Title="Click on Class Type to Sort"><b><font color="White">Class Type</font></b></td> 
 <td nowrap Title="Click on Excuse/Remarks to Sort"><b><font color="White">Excuse/Remarks</font></b></td> 
</tr>
</thead>
<tbody>
<%
	qry="select distinct to_char(A.ATTENDANCEDATE,'DD-MM-YYYY')ADate, to_char(A.classtimefrom,'HH:MI PM')Classf, to_char(A.classtimeupto,'HH:MI PM')Classt, nvl(A.ATTENDANCETYPE,' ')CType,";
	qry=qry+" nvl(A.Remarks,'None')Excuse from STUDENTATTENDANCEEXCUSED A";
	qry=qry+" where trunc(A.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',A.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',A.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))and nvl(A.DEACTIVE,'N')='N'";
	qry=qry+" and A.ENTRYBYFACULTYID='"+mFaculty+"' and A.FSTID IN(select FSTID from V#STUDENTATTENDANCE where Entrybyfacultyid='"+mFaculty+"' and subjectID='"+mSubjID+"' and ";
	qry=qry+" LTP='"+mLTP+"' and Programcode='"+mProg+"' and Sectionbranch='"+mSec+"' and Subsectioncode='"+mSub+"' and nvl(DEACTIVE,'N')='N') "; 
	qry=qry+" order by ADATE DESC";
//out.print(qry);
	rs=db.getRowset(qry);
	mSNO=0;
	while(rs.next())
	{
		mSNO++;
		mAttendanceDate=rs.getString("ADate");
		mClassFrom=rs.getString("Classf");
		mClassUpto=rs.getString("Classt");
		mExcuse=rs.getString("Excuse");
		if(rs.getString("CType").equals("R"))
			mCtype="Regular";
		else
			mCtype="Extra";
%>
		<tr>
		<td><%=mSNO%>.</td>
		<td nowrap><%=mAttendanceDate%></td>
		<td nowrap><%=mClassFrom%>-<%=mClassUpto%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;<%=mCtype%></td>
		<td nowrap><%=mExcuse%></td>
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
