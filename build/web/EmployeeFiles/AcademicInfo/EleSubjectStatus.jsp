<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	EleSubjectStatus.JSP		[For Employee]	   *	
	' * Author:		Suman Saurabh 					   *
	' * Date:		23th Oct 2008                          *
	' * Version:	1.0								   *	
	' **********************************************************************************************************

*/
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry2="";
String qry1="",mLTP="",mBasket="",mTagg="";
long mSNo=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="",mViewType="";
String mComp="", mInstitute="",mSrcType="",mDeptCode="",mCompany="",QryDept="",mDeptName="", mDept="";
String mExam="",mSubject="",mexam="",mSubj="",mGroup="",mcolor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="";
String mSExam="",StudentCount="";
String mSES="",mRightsID="";
String qryexam="",qrysubj="",qrysec="";
String mPrn="N",elecode="",status="";


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
mInstitute="";
}
else
{
mInstitute=session.getAttribute("InstituteCode").toString().trim();
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
if (session.getAttribute("CompanyCode")==null)
{
mCompany="";
}
else
{
mCompany=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("DepartmentCode")==null)
{
mDept="";
}
else
{
mDept=session.getAttribute("DepartmentCode").toString().trim();
}

if (request.getParameter("SrcType")==null)
{
mSrcType="";
}
else
{
mSrcType=request.getParameter("SrcType").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
mHead=session.getAttribute("PageHeading").toString().trim();
else
mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subjectwise Students List ] </TITLE>

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
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
{   OLTEncryption enc=new OLTEncryption();
mDMemberID=enc.decode(mMemberID);
mDMemberCode=enc.decode(mMemberCode);
mDMemberType=enc.decode(mMemberType);

String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
String mIPAddress =session.getAttribute("IPADD").toString().trim();
String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
ResultSet RsChk=null;
if(mSrcType.equals("I"))
mRightsID="";
else if(mSrcType.equals("H"))
mRightsID="220";
else if(mSrcType.equals("D"))
mRightsID="219";
//-----------------------------
//-- Enable Security Page Level
//-----------------------------
qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
RsChk= db.getRowset(qry);
if (RsChk.next() && RsChk.getString("SL").equals("Y"))
{
//----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<input id="SrcType" name="SrcType" type=hidden value=<%=mSrcType%>>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><B>Elective Subject Running 
List</b></TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<!--*********Exam**********-->
<tr><td nowrap><FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
<%
try
{
qry="Select Distinct nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInstitute+"' AND nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and Nvl(FINALIZED,'N')='N' ";
qry=qry+" AND EXAMCODE IN (SELECT EXAMCODE FROM PR#STUDENTSUBJECTCHOICE Where INSTITUTECODE='"+mInstitute+"' ) order by EXAMPERIODFROM DESC";
rs=db.getRowset(qry);
if (request.getParameter("x")==null)
{
%>
<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">
<%
while(rs.next())
{
mExam=rs.getString("Exam");
if(mexam.equals(""))
{
mexam=mExam;
qryexam=mExam;
%>
<OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
<%
}
else
{
%>
<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
<%
}
}
%>
</select>
<%
}
else
{
%>
<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">
<%
while(rs.next())
{
mExam=rs.getString("Exam");
if(mExam.equals(request.getParameter("Exam").toString().trim()))
{
mexam=mExam;
qryexam=mExam;
%>
<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
<%
}
else
{
%>
<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
<%
}
}
%>
</select>
<%
}
}
catch(Exception e)
{
}
%>
&nbsp;&nbsp;<FONT color=black face=Arial size=2><b>View Type</b></FONT>
<select id="vtype" name="vtype" tabindex="1" style="WIDTH: 100px">
<%
if(request.getParameter("x")==null)
{
%>
<option value="Y">Approved</option>
<option value="N">Unapproved</option>
<%
}
else
{
if(request.getParameter("vtype").equals("Y"))
{
%>
<option selected value="Y">Approved</option>
<option value="N">Unapproved</option>
<%
}
else
{
%>
<option  value="Y">Approved</option>
<option selected value="N">Unapproved</option>
<%
}
}
%>
</select>
&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
<%
try
{
qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster Where InstituteCode='"+mInstitute+"' and nvl(Deactive,'N')='N' ";
rs=db.getRowset(qry);
if (request.getParameter("x")==null)
{
%>
<select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
<%
while(rs.next())
{
mInstitute=rs.getString("InstCode");
if(mInstitute.equals(""))
mInstitute=mInstitute;
%>
<OPTION selected Value =<%=mInstitute%>><%=mInstitute%></option>
<%
}
%>
</select>
<%
}
else
{
%>
<select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
<%
while(rs.next())
{
mInstitute=rs.getString("InstCode");
if(mInstitute.equals(request.getParameter("InstCode").toString().trim()))
{
%>
<OPTION selected Value =<%=mInstitute%>><%=mInstitute%></option>
<%
}
else
{
%>
<OPTION Value =<%=mInstitute%>><%=mInstitute%></option>
<%
}
}
%>
</select>
<%
}
}
catch(Exception e)
{
}
%>
<!--*********Department**********-->
&nbsp; <FONT color=black><FONT face=Arial size=2><STRONG>Department</STRONG></FONT></FONT>
<%
//--------------------------------------------HOD-------------------------------------
if(mSrcType.equals("H"))
{
qry="select distinct A.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A ";
qry=qry+" where DEPARTMENTCODE IN (Select DEPARTMENTCODE from HODLIST ";
qry=qry+" where INSTITUTECODE='"+mInstitute+"' And COMPANYCODE='"+mCompany+"' And EMPLOYEEID='"+mChkMemID+"') order by DeptName";
}
//--------------------------------------------DOAA-------------------------------------
else if(mSrcType.equals("D"))
{
qry="select distinct B.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N' and B.DEPARTMENTCODE in(select DEPARTMENTCODE from pr#departmentsubjecttagging) order by DeptName";
}
//--------------------------------------------SELF-------------------------------------
else
{
qry="select distinct B.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N'";
qry=qry+" And B.EMPLOYEEID='"+mChkMemID+"' order by DeptName";
}
// out.print(qry);
rs=db.getRowset(qry);
%>
<select name="Dept" tabindex="1" id="Dept">
<%
if(request.getParameter("x")==null)
{
while(rs.next())
{
mDeptCode=rs.getString("DeptCode");
if(QryDept.equals(""))
QryDept=mDeptCode;
mDeptName=rs.getString("DeptName");
%>
<option value=<%=mDeptCode%>><%=GlobalFunctions.toTtitleCase(mDeptName)%></option>
<%
}
}
else
{
while(rs.next())
{
mDeptCode=rs.getString("DeptCode");
mDeptName=rs.getString("DeptName");
if(mDeptCode.equals(request.getParameter("Dept").toString().trim()))
{
QryDept=mDeptCode;
%>
<option selected value=<%=mDeptCode%>><%=GlobalFunctions.toTtitleCase(mDeptName)%></option>
<%
}
else
{
%>
<option  value=<%=mDeptCode%>><%=GlobalFunctions.toTtitleCase(mDeptName)%></option>
<%
}
}
}
%>
</select>&nbsp;</td></tr>
<tr><td align=right> <INPUT Type="submit" Value="Show/Refresh">
&nbsp;
</td></tr>
</table>
</form>
<%
if(request.getParameter("x")!=null)
{
mExam=request.getParameter("Exam").toString().trim();
mViewType=request.getParameter("vtype").toString().trim();
mInstitute=request.getParameter("InstCode").toString().trim();
mDeptCode=request.getParameter("Dept").toString().trim();

%>
<table bgcolor=#fce9c5 class="sort-table" id="table-2" width='98%' align=center topmargin=0 cellspacing=0 cellpadding=0 border=1 >
<thead>
<tr bgcolor="#ff8c00">

<td title='Click on Sno to Sort Data' rowspan=2 ><b><font color=white>SNo.</font></b></td>

<td title='Click on Elective Code to Sort Data' rowspan=2><b><font color=white> Elective<br>&nbsp;&nbsp;Code </font> </b></td>


<td title='Click on Sno to Sort Data' rowspan=2 ><b><font color=white>Semester </font></b></td>

<td title='Click on Sno to Sort Data' rowspan=2 ><b><font color=white>Program Code.</font></b></td>

<td title='Click on Sno to Sort Data' rowspan=2 ><b><font color=white>Section Branch.</font></b></td>


<td title='Click on Subject Desc to Sort Data' rowspan=2 align="center"><b><font color=white> Subject Description </font></b></td>



<td title='Click on Credit to Sort Data' rowspan=2><b><font color=white>Credit</font></b></td>
<%
if(!mViewType.equals("Y"))
{
%>
<td title='Click on this to Sort Data' rowspan=2 align="center" ><b><font color=white> Student Count </font></b></td>
<%
}
if(mViewType.equals("Y"))
{
%>
<td title='Click on this to Sort Data' rowspan=2 align="Center" nowrap><b><font color=white> No. of Student<br>&nbsp;&nbsp;&nbsp;Alloted </font></b></td>
<%
}
%>
<td title='Click on Status to Sort Data' rowspan=2 align="Center"><b><font color=white> Status </font></b></td>
<%
if(mViewType.equals("Y"))
{
%>
<td title='Click on this to Sort Data' rowspan=2 nowrap align="Center"><b><font color=white> Approved By </font></b></td>
<%}%>
</tr>
<!--<tr bgcolor="#ff8c00">
<td title='Click on this to Sort Data'><b><font color=white> Choice </font></b></td>
<td title='Click on this to Sort Data'><b><font color=white> Choice2 </font></b></td>
</tr>-->
</thead>
<tbody>
<%
qry="SELECT Distinct b.semester semester ,b.SECTIONBRANCH,b.PROGRAMCODE, NVL(A.ELECTIVECODE,' ')ELECTIVECODE ,NVL(A.SUBJECTID,' ')SUBJECTID , NVL(A.COURSECREDITPOINT,'')CREDIT ,nvl(A.SUBJECTRUNNING,'N')SUBJECTRUNNING";
qry=qry+" FROM PR#ELECTIVESUBJECTS A,PR#STUDENTSUBJECTCHOICE B WHERE A.EXAMCODE='"+mExam+"' ";
qry=qry+" AND  NVL(B.SUBJECTRUNNING,'N')='"+mViewType+"' AND NVL(A.SUBJECTRUNNING,'N')='"+mViewType+"' ";
qry=qry+" AND A.INSTITUTECODE='"+mInstitute+"' AND A.subjectid in (select distinct subjectid subjectid from pr#departmentsubjecttagging where departmentcode='"+mDeptCode+"') ";
qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.EXAMCODE=B.EXAMCODE and A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.TAGGINGFOR=B.TAGGINGFOR and A.SECTIONBRANCH=B.SECTIONBRANCH and A.SEMESTER=B.SEMESTER and A.SUBJECTID=B.SUBJECTID";
qry=qry+" and B.studentid in (select studentid from studentregistration where COMPANYCODE='"+mInstitute+"' AND INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mExam+"' AND REGALLOW='Y')";
qry=qry+" order by ELECTIVECODE";
//out.print(qry);
rs1=db.getRowset(qry);
int Ctr=0;
while(rs1.next())
{
	Ctr++;
%>
<tr>


<%
//if(!elecode.equals(rs1.getString("ELECTIVECODE")))
//{

%>
<td align="center"><%=Ctr%></td>

<%
	//elecode=rs1.getString("ELECTIVECODE");
//}
//else
//{
%>


<%
//}
%>
<td align="left"><%=rs1.getString("ELECTIVECODE")%></td>
<td align="left"><%=rs1.getString("semester")%></td>

<td align="left"><%=rs1.getString("PROGRAMCODE")%></td>
<td align="left"><%=rs1.getString("SECTIONBRANCH")%></td>


<%
qry="select nvl(subject,' ')subject,nvl(subjectcode,' ')subjectcode from subjectmaster where subjectid='"+rs1.getString("SUBJECTID")+"' and institutecode='"+mInstitute+"'";
rs=db.getRowset(qry);
//out.print(qry);
if(rs.next())
{
	%>
	<td align="left" nowrap><%=rs.getString("subject")%> (<%=rs.getString("subjectcode")%>)</td>
	<%
}
%>
<td align="center"><%=rs1.getString("CREDIT")%></td>
<%
qry="SELECT INSTITUTECODE, EXAMCODE, SUBJECTID, COUNT(STUDENTID)TOTALSTD FROM PR#STUDENTSUBJECTCHOICE WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mExam+"' ";
qry=qry+" AND PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'  and   SUBJECTID='"+rs1.getString("SUBJECTID")+"' AND NVL(ELECTIVECODE,' ')='"+rs1.getString("ELECTIVECODE")+"' ";
qry=qry+" and studentid in (select studentid from studentregistration where nvl(regallow,'N')='Y' and examcode='"+mExam+"')";
//qry=qry+" AND sectionbranch in (select distinct sectionbranch branchcode from pr#departmentsubjecttagging where departmentcode='"+mDeptCode+"') ";
qry=qry+" AND CHOICE is not null";
qry=qry+" GROUP BY INSTITUTECODE, EXAMCODE, SUBJECTID,PROGRAMCODE,SECTIONBRANCH";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	if(!mViewType.equals("Y"))
	{
		%>
		<td align="center"><%=rs.getString("TOTALSTD")%></td>
		<%
	}
}

qry="SELECT INSTITUTECODE, EXAMCODE, SUBJECTID, COUNT(STUDENTID)TOTALSTDCH FROM PR#STUDENTSUBJECTCHOICE WHERE PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'  and INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mExam+"' ";
qry=qry+" AND SUBJECTID='"+rs1.getString("SUBJECTID")+"' AND NVL(ELECTIVECODE,' ')='"+rs1.getString("ELECTIVECODE")+"' ";
qry=qry+" AND CHOICE is not null AND NVL(SUBJECTRUNNING,'N')='"+mViewType+"' ";
qry=qry+" and studentid in (select studentid from studentregistration where nvl(regallow,'N')='Y' and examcode='"+mExam+"')";
//qry=qry+" AND sectionbranch in (select distinct sectionbranch branchcode from pr#departmentsubjecttagging where departmentcode='"+mDeptCode+"') ";
qry=qry+" and SUBJECTRUNNING in (Select SUBJECTRUNNING FROM PR#ELECTIVESUBJECTS WHERE INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mExam+"' AND SUBJECTID='"+rs1.getString("SUBJECTID")+"' AND NVL(ELECTIVECODE,' ')='"+rs1.getString("ELECTIVECODE")+"' AND nvl(SUBJECTRUNNING,'N')='Y' AND nvl(DEACTIVE,'N')='N')";
qry=qry+" GROUP BY INSTITUTECODE, EXAMCODE, SUBJECTID,PROGRAMCODE,SECTIONBRANCH";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	if(mViewType.equals("Y"))
	{
		%>
		<td align="center"><%=rs.getString("TOTALSTDCH")%></td>
		<%
	}
}
if(rs1.getString("SUBJECTRUNNING").equals("Y"))
{
status="Approved";
}
else
{
status="Unapproved";
}
%>
<td align="center"><%=status%></td>
<%
if(mViewType.equals("Y"))
{
%>
<td nowrap align="center">N/A</td>
<%
}
%>
</tr>

<%
}
%>
</tbody>
</table>
<!--<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-2"),["Number","CaseInsensitiveString", "CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>-->
<%
//-----------------------------
//---Enable Security Page Level
//-----------------------------
}
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
//   out.print("error"+qry);
}
%>
</body>
</html>
