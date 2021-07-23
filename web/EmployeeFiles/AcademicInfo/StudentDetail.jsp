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
int mSNO=0,Ctr=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="",mProgram="",mBranch="",mSemester="";
String mInst="", mRightsID="",mDepartmentName="",mView="";
String mSubj="", mSubjID="", mCtype="", mProg="",mSec="",mSub="";
String mExam="", mFaculty="", mFSTID="", mDate1="", mDate2="";
String mColor="", mLTP="", mTotal="",mDepartment="",mInstitute="",mPRCode="";
String mCType="", mAttDate="", mClassFr="", mClassTo="",mSrcType="";
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


if (request.getParameter("Institute").toString().trim()==null)
{
mInstitute="";
}
else
{
mInstitute=request.getParameter("Institute").toString().trim();
}
if (request.getParameter("PRCode").toString().trim()==null)
{
	mPRCode="";
}
else
{
	mPRCode=request.getParameter("PRCode").toString().trim();
}
if (request.getParameter("Department").toString().trim()==null)
{
mDepartment="";
}
else
{
	mDepartment=request.getParameter("Department").toString().trim();
}

if (request.getParameter("Program").toString().trim()==null)
{
mProgram="";
}
else
{
	mProgram=request.getParameter("Program").toString().trim();
}

if (request.getParameter("Branch").toString().trim()==null)
{
mBranch="";
}
else
{
	mBranch=request.getParameter("Branch").toString().trim();
}

if (request.getParameter("Semester").toString().trim()==null)
{
mSemester="";
}
else
{
	mSemester=request.getParameter("Semester").toString().trim();
}


if (request.getParameter("DepartmentName").toString().trim()==null)
{
	mDepartmentName="";
}
else
{
	mDepartmentName=request.getParameter("DepartmentName").toString().trim();
}

if (request.getParameter("View").toString().trim()==null)
{
mView="";
}
else
{
mView=request.getParameter("View").toString().trim();
}
if (request.getParameter("SrcType")==null)
{
mSrcType="";
}
else
{
mSrcType=request.getParameter("SrcType").toString().trim();
//out.print("mSrcType :"+mSrcType);
}
if(mSrcType.equals("I"))
mRightsID="";
else if(mSrcType.equals("H"))
mRightsID="222";
else if(mSrcType.equals("D"))
mRightsID="221";

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
mHead=session.getAttribute("PageHeading").toString().trim();
else
mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student Detail]</TITLE>
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
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Student  Detail</b></font></td>
</tr>
</TABLE>
<table width="60%" align=center border=1>
<tr><td  nowrap><font face=arial color="#00008b" size=2>Institute:<B><%=mInstitute%></B></td>
<td> <font face=arial color="#00008b" size=2>PR Reg Code: <B><%=mPRCode%></B></td></tr>
<tr><td colspan=2><font face=arial color="#00008b" size=2>Department: <B><%=mDepartmentName%></B><br></td></tr>
<tr><td><font face=arial color="#00008b" size=2>Program: <B><%=mProgram%></B></td>
<td><font face=arial color="#00008b" size=2>Branch: <B><%=mBranch%></B></font></td></tr>
</table>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="60%" border=1 >
<thead>
<tr bgcolor="#ff8c00">
<td align=center Title="Click to sort SNo"><b><font color="White">SNo</font></b></td>
<td align=center nowrap Title="Click to Sort Enrollemnt No"><b><font color="White">Enrollment No</font></b></td>
<td  nowrap Title="Click to Sort Student Name"><b><font color="White">Student Name</font></b></td>

</tr>
</thead>
<tbody>

<%

//And ExamCode='"+mExam+"' 
qry="select ExamCode from PREVENTMaster where PREventCode='"+mPRCode+"'";
//out.print("qry :"+qry);
rs=db.getRowset(qry);
if(rs.next())
{
 mExam=rs.getString(1);
}


if(mView.equals("All"))
{
   qry="select nvl(STUDENTNAME,' ')STUDENTNAME,nvl(ENROLLMENTNO,' ')ENROLLMENTNO ,nvl(STUDENTID,'')STUDENTID from studentmaster where INSTITUTECODE='"+mInstitute+"' and PROGRAMCODE='"+mProgram+"' and BRANCHCODE='"+mBranch+"' and STUDENTID in(select STUDENTID from studentregistration where INSTITUTECODE='"+mInstitute+"' and ExamCode='"+mExam+"' and PROGRAMCODE='"+mProgram+"' and  SEMESTER='"+mSemester+"' and SECTIONBRANCH='"+mBranch+"' and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDepartment+"') and STUDENTID in (select MEMBERID STUDENTID from prevents where INSTITUTECODE='"+mInstitute+"'and PREVENTCODE= '"+mPRCode+"' and MEMBERTYPE='S'))";
}
else if(mView.equals("GivenChoice"))
{
   qry="select nvl(STUDENTNAME,' ')STUDENTNAME,nvl(ENROLLMENTNO,' ')ENROLLMENTNO ,nvl(STUDENTID,'')STUDENTID from studentmaster where INSTITUTECODE='"+mInstitute+"' and PROGRAMCODE='"+mProgram+"' and BRANCHCODE='"+mBranch+"' and STUDENTID in(select STUDENTID from studentregistration where INSTITUTECODE='"+mInstitute+"'  and ExamCode='"+mExam+"' and SEMESTER='"+mSemester+"' and PROGRAMCODE='"+mProgram+"' and SECTIONBRANCH='"+mBranch+"' and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDepartment+"') and STUDENTID in (select MEMBERID STUDENTID from prevents where INSTITUTECODE='"+mInstitute+"'and PREVENTCODE= '"+mPRCode+"' and MEMBERTYPE='S') and STUDENTID in (select nvl(STUDENTID,' ')STUDENTID from pr#studentsubjectchoice where INSTITUTECODE='"+mInstitute+"' and SEMESTER='"+mSemester+"'and choice is not null or choice2 is not null and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDepartment+"')))";
}
else
{
   qry="select nvl(STUDENTNAME,' ')STUDENTNAME,nvl(ENROLLMENTNO,' ')ENROLLMENTNO ,nvl(STUDENTID,'')STUDENTID from studentmaster where INSTITUTECODE='"+mInstitute+"' and PROGRAMCODE='"+mProgram+"' and BRANCHCODE='"+mBranch+"' and STUDENTID in(select STUDENTID from studentregistration where INSTITUTECODE='"+mInstitute+"' And ExamCode='"+mExam+"' and SEMESTER='"+mSemester+"' and PROGRAMCODE='"+mProgram+"' and SECTIONBRANCH='"+mBranch+"' and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDepartment+"') and STUDENTID in (select MEMBERID STUDENTID from prevents where INSTITUTECODE='"+mInstitute+"'and PREVENTCODE= '"+mPRCode+"' and MEMBERTYPE='S') and STUDENTID not in (select nvl(STUDENTID,' ')STUDENTID from pr#studentsubjectchoice where INSTITUTECODE='"+mInstitute+"' and SEMESTER='"+mSemester+"'and choice is not null or choice2 is not null and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDepartment+"')))";
}


//out.print("qry :"+qry);
rs=db.getRowset(qry);
while(rs.next())
{
Ctr++;
%>
<tr>
<td align="center" ><%=Ctr%></td>
<td align="center"><%=rs.getString("ENROLLMENTNO")%></td>
<td ><%=rs.getString("STUDENTNAME")%></td>
</tr>
<%
}
%>
</tbody>
</TABLE>
<!--<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>-->
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
<h3>    <br><img src='../../Images/Error1.jpg'> Access Denied (authentication_failed) </h3><br>
<P> This page is not authorized/available for you.
<br>For assistance, contact your network support team.
</font> <br>    <br>    <br>    <br>
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
