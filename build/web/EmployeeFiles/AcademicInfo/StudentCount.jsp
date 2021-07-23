<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
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
String mDMemberID="",mExam="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="",mViewType="";
String mInstitute="",mSrcType="",mDeptCode="",mCompany="",QryDept="",mDeptName="", mDept="";
String mPREvent="",mSubject="",mprevent="",mSubj="",mGroup="",mcolor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="";
String mSExam="",mSemester="";
String mSES="",mRightsID="";
String qryprevent="",qrysubj="",qrysec="";
String mPrn="N",elecode="",program="",branch="";
int NofStudent=0,NofStudentGivenChoice=0,NofStudentNotGivenChoice=0;
int Ctr=0;
boolean flag=false;

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
<TITLE>#### <%=mHead%> [ Semesterwise Students List ] </TITLE>

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
{   
OLTEncryption enc=new OLTEncryption();
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
mRightsID="222";
else if(mSrcType.equals("D"))
mRightsID="221";
//-----------------------------
//-- Enable Security Page Level
//-----------------------------
qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
//out.print(qry);
RsChk= db.getRowset(qry);
if (RsChk.next() && RsChk.getString("SL").equals("Y"))
{
//----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<input id="SrcType" name="SrcType" type=hidden value=<%=mSrcType%>>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Semester wise Student Count given their choice for Elective Subjects</b></TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>

<tr><td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
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
//out.println(e.getMessage());
}
%>
<!--*********Exam**********-->
&nbsp;<FONT color=black face=Arial size=2><b>PR Reg.Code</b></FONT>
<%
try
{
//qry="Select Distinct nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where ";
//qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and Nvl(FINALIZED,'N')='N' order by //EXAMPERIODFROM DESC";

qry="select nvl(B.PREVENTCODE,' ')PREVENTCODE from PREVENTS B where nvl(B.SSTPOPULATED,'N')='N' and B.PREVENTCODE IN (select nvl(A.PREVENTCODE,' ')PREVENTCODE from PREVENTMASTER A where nvl(A.PRCOMPLETED,'N')='N' and PRREQUIREDFOR='S' and A.INSTITUTECODE=B.INSTITUTECODE and A.PREVENTCODE=B.PREVENTCODE) Group By PREVENTCODE";
rs=db.getRowset(qry);
if (request.getParameter("x")==null)
{
%>
<Select Name=PREvent tabindex="0" id="PREvent" style="WIDTH: 125px">
<%
while(rs.next())
{
mPREvent=rs.getString("PREVENTCODE");
if(mprevent.equals(""))
{
mprevent=mPREvent;
qryprevent=mPREvent;
%>
<OPTION Selected Value =<%=mPREvent%>><%=rs.getString("PREVENTCODE")%></option>
<%
}
else
{
%>
<OPTION Value =<%=mPREvent%>><%=rs.getString("PREVENTCODE")%></option>
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
<select name="PREvent" tabindex="0" id="PREvent" style="WIDTH: 125px">
<%
while(rs.next())
{
mPREvent=rs.getString("PREVENTCODE");
if(mPREvent.equals(request.getParameter("PREvent").toString().trim()))
{
mprevent=mPREvent;
qryprevent=mPREvent;
%>
<OPTION selected Value =<%=mPREvent%>><%=rs.getString("PREVENTCODE")%></option>
<%
}
else
{
%>
<OPTION Value =<%=mPREvent%>><%=rs.getString("PREVENTCODE")%></option>
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
// out.println("Error Msg");
}
%>
<!--*********Department**********-->
&nbsp; <FONT color=black><FONT face=Arial size=2><STRONG>Department</STRONG></FONT></FONT>
<%
//out.print("mSrcType :"+mSrcType);
//--------------------------------------------HOD-------------------------------------
if(mSrcType.equals("H"))
{
//qry="select distinct B.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N'";
//qry=qry+" And B.EMPLOYEEID IN (Select EMPLOYEEID from EMPLOYEEMASTER where DEPARTMENTCODE IN (Select DEPARTMENTCODE from HODLIST ";
//qry=qry+" where INSTITUTECODE='"+mInstitute+"' And COMPANYCODE='"+mCompany+"' And EMPLOYEEID='"+mChkMemID+"'))  order by DeptName";

qry="select distinct A.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A ";
qry=qry+" where DEPARTMENTCODE IN (Select DEPARTMENTCODE from HODLIST ";
qry=qry+" where INSTITUTECODE='"+mInstitute+"' And COMPANYCODE='"+mCompany+"' And EMPLOYEEID='"+mChkMemID+"') order by DeptName";
}
//--------------------------------------------DOAA-------------------------------------
else if(mSrcType.equals("D"))
{
qry="select distinct B.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N' and B.DEPARTMENTCODE in (Select nvl(DEPARTMENTCODE,' ')DEPARTMENTCODE from branchdepttagging where nvl(Deactive,'N')='N') order by DeptName";
}
//--------------------------------------------SELF-------------------------------------
else
{
qry="select distinct B.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N'";
qry=qry+" And B.EMPLOYEEID='"+mChkMemID+"' order by DeptName";
}
//out.print(qry);
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
</select>
&nbsp;<FONT color=black face=Arial size=2><b>Semester</b></FONT>
<select id="Semester" name="Semester" tabindex="1" style="WIDTH: 100px">
<%
if(request.getParameter("x")==null)
{
%>
<option value="all">All</option>
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}
else
{
if(request.getParameter("Semester").equals("all"))
{
%>
<option selected value="all">All</option>
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}
else if(request.getParameter("Semester").equals("1"))
{
%>
<option value="all">All</option>
<option selected value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}


else if(request.getParameter("Semester").equals("2"))
{
%>
<option value="all">All</option>
<option  value="1">1</option>
<option selected value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}
else if(request.getParameter("Semester").equals("3"))
{
%>
<option value="all">All</option>
<option  value="1">1</option>
<option  value="2">2</option>
<option selected value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}
else if(request.getParameter("Semester").equals("4"))
{
%>
<option value="all">All</option>
<option  value="1">1</option>
<option  value="2">2</option>
<option value="3">3</option>
<option selected value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}
else if(request.getParameter("Semester").equals("5"))
{
%>
<option value="all">All</option>
<option  value="1">1</option>
<option  value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option selected value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}
else if(request.getParameter("Semester").equals("6"))
{
%>
<option value="all">All</option>
<option  value="1">1</option>
<option  value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option selected value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}
else if(request.getParameter("Semester").equals("7"))
{
%>
<option value="all">All</option>
<option  value="1">1</option>
<option  value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option selected value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}
else if(request.getParameter("Semester").equals("8"))
{
%>
<option value="all">All</option>
<option  value="1">1</option>
<option  value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option selected value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<%
}
else if(request.getParameter("Semester").equals("9"))
{
%>
<option value="all">All</option>
<option  value="1">1</option>
<option  value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option selected value="9">9</option>
<option value="10">10</option>
<%
}
else if(request.getParameter("Semester").equals("10"))
{
%>
<option value="all">All</option>
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option selected value="10">10</option>
<%
}
}
%>
</select></td></tr>
<tr><td align=right> <INPUT Type="submit" Value="Show/Refresh">
&nbsp;

</td></tr>
</table>
</form>
<%
if(request.getParameter("x")!=null)
{
mPREvent=request.getParameter("PREvent").toString().trim();
mInstitute=request.getParameter("InstCode").toString().trim();
mDeptCode=request.getParameter("Dept").toString().trim();
mSemester=request.getParameter("Semester").toString().trim();

%>

<table bgcolor=#fce9c5 class="sort-table" id="table-2" width='80%' align=center topmargin=0 cellspacing=0 cellpadding=0 border=1 >
<thead>
<tr bgcolor="#ff8c00">
<td  align="center"><b><font color=white> SNo. </font></b></td>
<td  align="center"><b><font color=white> Programe </font> </b></td>
<td  align="center"><b><font color=white> Branch </font> </b></td>
<td  align="center"><b><font color=white> Semester </font> </b></td>
<td  align="center"><b><font color=white> Student Strength </font> </b></td>
<td  align="center"><b><font color=white> No. of Student given choice </font></b></td>
<td  align="center"><b><font color=white> No. of Student not given choice </font></b></td>
</tr>
</thead>
<tbody>
<%
//And ExamCode='"+mExam+"' 
qry="select ExamCode from PREVENTMaster where PREventCode='"+mPREvent+"'";
//out.print("qry :"+qry);
rs=db.getRowset(qry);
if(rs.next())
{
 mExam=rs.getString(1);
}



if(!mSemester.equals("all"))
{
qry="select nvl(PROGRAMCODE,' ')PROGRAMCODE,nvl(SECTIONBRANCH,' ')SECTIONBRANCH , count(STUDENTID)StudentStrength from studentregistration where INSTITUTECODE='"+mInstitute +"' And ExamCode='"+mExam+"' and SEMESTER='"+mSemester+"' and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDeptCode+"') and STUDENTID in (select MEMBERID STUDENTID from prevents where INSTITUTECODE='"+mInstitute+"' and PREVENTCODE= '"+mPREvent+"' and MEMBERTYPE='S') group by PROGRAMCODE,SECTIONBRANCH,SEMESTER";


//out.print("1."+qry);
rs1=db.getRowset(qry);
while(rs1.next())
{
NofStudent=Integer.parseInt(rs1.getString("StudentStrength"));

// qry="select count(MEMBERID)StudentStrength from prevents where INSTITUTECODE='JIIT' and PREVENTCODE='PRS-2009EVE' and MEMBERTYPE='S' and MEMBERID in (select nvl(STUDENTID,' ')MEMBERID from studentmaster where INSTITUTECODE='JIIT' and SEMESTER=8 and BRANCHCODE in (select distinct sectionbranch branchcode from branchdepttagging where departmentcode='0002')) and MEMBERID in (select nvl(STUDENTID,' ')MEMBERID from pr#studentsubjectchoice where INSTITUTECODE='JIIT' and SEMESTER=8 and choice is not null or choice2 is not null and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='0002')) group by MEMBERID";


qry="select count(STUDENTID)StudentStrength from studentregistration  where INSTITUTECODE='"+mInstitute+"'  And ExamCode='"+mExam+"' and SEMESTER='"+mSemester+"' and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"' and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDeptCode+"') and STUDENTID in (select MEMBERID STUDENTID from prevents where INSTITUTECODE='"+mInstitute+"'and PREVENTCODE= '"+mPREvent+"' and MEMBERTYPE='S')  and STUDENTID in (select nvl(STUDENTID,' ')STUDENTID from pr#studentsubjectchoice where INSTITUTECODE='"+mInstitute+"' and SEMESTER='"+mSemester+"'and choice is not null or choice2 is not null and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDeptCode+"')) group by semester";

//out.print("2."+qry);
rs=db.getRowset(qry);
if(rs.next())
NofStudentGivenChoice =Integer.parseInt(rs.getString("StudentStrength"));
else
NofStudentGivenChoice= 0;
NofStudentNotGivenChoice=NofStudent-NofStudentGivenChoice;
%>
<tr>
<%
if(rs1.getString("PROGRAMCODE").equals(program))
{
flag=false;
%>
<td>&nbsp;</td>
<td>&nbsp;</td>
<%
}
else
{
Ctr++;
%>
<td align="center"><%=Ctr%></td>
<td align="center"><%=rs1.getString("PROGRAMCODE")%></td>
<%
program= rs1.getString("PROGRAMCODE");
flag=true;
}
if(rs1.getString("SECTIONBRANCH").equals(branch)&&flag==false)
{
%>
<td>&nbsp;</td>
<%
}
else
{
%>
<td align="center"><%=rs1.getString("SECTIONBRANCH")%></td>
<%
branch=rs1.getString("SECTIONBRANCH");
}
%>
<td align="center"><%=mSemester%></td>
<td align="center"><%=NofStudent%>&nbsp;&nbsp;<a Title="Click to View Student Detail" target=_New href="StudentDetail.jsp?Institute=<%=mInstitute%>&amp;SrcType=<%=mSrcType%>&amp;PRCode=<%=mPREvent%> &amp;Department=<%=mDeptCode%>&amp;Program=<%=rs1.getString("PROGRAMCODE")%>&amp;Branch=<%=rs1.getString("SECTIONBRANCH")%>&amp;Semester=<%=mSemester%>&amp;DepartmentName=<%=mDeptName%>&amp;View=All">...</a></td>
<td align="center"><%=NofStudentGivenChoice%>&nbsp;&nbsp;<a Title="Click to View Student Detail" target=_New href="StudentDetail.jsp?Institute=<%=mInstitute%>&amp;SrcType=<%=mSrcType%>&amp;PRCode=<%=mPREvent%> &amp;Department=<%=mDeptCode%>&amp;Program=<%=rs1.getString("PROGRAMCODE")%>&amp;Branch=<%=rs1.getString("SECTIONBRANCH")%>&amp;Semester=<%=mSemester%>&amp;DepartmentName=<%=mDeptName%>&amp;View=GivenChoice">...</a></td>
<td align="center"><%=NofStudentNotGivenChoice%>&nbsp;&nbsp;<a Title="Click to View Student Detail" target=_New href="StudentDetail.jsp?Institute=<%=mInstitute%>&amp;SrcType=<%=mSrcType%>&amp;PRCode=<%=mPREvent%> &amp;Department=<%=mDeptCode%>&amp;Program=<%=rs1.getString("PROGRAMCODE")%>&amp;Branch=<%=rs1.getString("SECTIONBRANCH")%>&amp;Semester=<%=mSemester%>&amp;DepartmentName=<%=mDeptName%>&amp;View=NotGivenChoice">...</a></td>
</tr>
<% } %>
</tbody>
</table>
<!--<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-2"),["Number","CaseInsensitiveString", "CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>-->
<%
}
else
{
qry="select nvl(SEMESTER,'')SEMESTER,nvl(PROGRAMCODE,' ')PROGRAMCODE,nvl(SECTIONBRANCH,' ')SECTIONBRANCH , count(STUDENTID)StudentStrength from studentregistration  where INSTITUTECODE='"+mInstitute+"'  And ExamCode='"+mExam+"' and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDeptCode+"') and STUDENTID in (select MEMBERID STUDENTID from prevents where INSTITUTECODE='"+mInstitute+"'and PREVENTCODE= '"+mPREvent+"' and MEMBERTYPE='S') group by PROGRAMCODE,SECTIONBRANCH,SEMESTER order by PROGRAMCODE,SECTIONBRANCH,SEMESTER asc";
//out.print("1."+qry);
rs1=db.getRowset(qry);
while(rs1.next())
{


NofStudent=Integer.parseInt(rs1.getString("StudentStrength"));
//out.print("NofStudent :"+NofStudent);
%>
<tr>

<%
if(rs1.getString("PROGRAMCODE").equals(program))
{
flag=false;
%>
<td>&nbsp;</td>
<td>&nbsp;</td>
<%
}
else
{
Ctr++;
%>
<td align="center"><%=Ctr%></td>
<td align="center"><%=rs1.getString("PROGRAMCODE")%></td>
<%
program= rs1.getString("PROGRAMCODE");
flag=true;
}
if(rs1.getString("SECTIONBRANCH").equals(branch)&&flag==false)
{
%>
<td>&nbsp;</td>
<%
}
else
{
%>
<td align="center"><%=rs1.getString("SECTIONBRANCH")%></td>
<%
branch=rs1.getString("SECTIONBRANCH");
}
%>
<td align="center"><%=rs1.getString("SEMESTER")%></td>
<td align="center"><%=rs1.getString("StudentStrength")%>&nbsp;&nbsp;<a Title="Click to View Student Detail" target=_New href="StudentDetail.jsp?Institute=<%=mInstitute%>&amp;SrcType=<%=mSrcType%>&amp;PRCode=<%=mPREvent%> &amp;Department=<%=mDeptCode%>&amp;Program=<%=rs1.getString("PROGRAMCODE")%>&amp;Branch=<%=rs1.getString("SECTIONBRANCH")%>&amp;Semester=<%=rs1.getString("SEMESTER")%>&amp;DepartmentName=<%=mDeptName%>&amp;View=All">...</a></td>


<%
qry="select count(STUDENTID)StudentStrength from studentregistration  where INSTITUTECODE='"+mInstitute+"'  And ExamCode='"+mExam+"' and SEMESTER='"+rs1.getString("SEMESTER")+"' and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"' and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDeptCode+"') and STUDENTID in (select MEMBERID STUDENTID from prevents where INSTITUTECODE='"+mInstitute+"'and PREVENTCODE= '"+mPREvent+"' and MEMBERTYPE='S') and STUDENTID in (select nvl(STUDENTID,' ')STUDENTID from pr#studentsubjectchoice where INSTITUTECODE='"+mInstitute+"' and SEMESTER='"+rs1.getString("SEMESTER")+"'and choice is not null or choice2 is not null and sectionbranch in(select distinct sectionbranch branchcode from branchdepttagging where departmentcode='"+mDeptCode+"')) group by semester";
//out.print("2."+qry);
rs=db.getRowset(qry);
if(rs.next())
NofStudentGivenChoice =Integer.parseInt(rs.getString("StudentStrength"));
else
NofStudentGivenChoice =0;
NofStudentNotGivenChoice=NofStudent-NofStudentGivenChoice;

%>
<td align="center"><%=NofStudentGivenChoice%>&nbsp;&nbsp;<a Title="Click to View Student Detail" target=_New href="StudentDetail.jsp?Institute=<%=mInstitute%>&amp;SrcType=<%=mSrcType%>&amp;PRCode=<%=mPREvent%> &amp;Department=<%=mDeptCode%>&amp;Program=<%=rs1.getString("PROGRAMCODE")%>&amp;Branch=<%=rs1.getString("SECTIONBRANCH")%>&amp;Semester=<%=rs1.getString("SEMESTER")%>&amp;DepartmentName=<%=mDeptName%>&amp;View=GivenChoice">...</a></td>
<td align="center"><%=NofStudentNotGivenChoice%>&nbsp;&nbsp;<a Title="Click to View Student Detail" target=_New href="StudentDetail.jsp?Institute=<%=mInstitute%>&amp;SrcType=<%=mSrcType%>&amp;PRCode=<%=mPREvent%> &amp;Department=<%=mDeptCode%>&amp;Program=<%=rs1.getString("PROGRAMCODE")%>&amp;Branch=<%=rs1.getString("SECTIONBRANCH")%>&amp;Semester=<%=rs1.getString("SEMESTER")%>&amp;DepartmentName=<%=mDeptName%>&amp;View=NotGivenChoice">...</a></td>
</tr>
<%
}
%>
</tbody>
</table>
<%

}
}
//-----------------------------
//---Enable Security Page Level
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
//   out.print("error"+qry);
}
%>
</body>
</html>
