
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
 <%@page contentType="text/html"%> 
<%
ResultSet  rs=null,rs1=null,rss1=null,rsc=null,rse=null,rse1=null,rsso=null,rsexam=null,rsCCP=null;
String qry="",qry1="";
String mDID="",mProg="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
double mMinCrLmt=0, mMaxCrLmt=0, mMinCrLmtTkn=0, mMaxCrLmtTkn=0, mMaxCrLmtAld=0, mCourseCrPt=0, mTotalCrLmtTkn=0;
String mSect="",	mSubSect="", mTag="",mElective="",mSCode="";
String mExam="", mFailGraders="F", mPrcode="",mSENDTOHOD="",	mSemtype="", mSubtype="",msg="";
String mName1="", mName2="",mName3="", mName4="", mName5="", mName6="", mName7="", mName8="", mName9="", mName10="";
int mochoice=0, mochoice1=0,Count=0,chk=0,m=1;
int CourseCrPtBasketD=1;
double mMinBasketD=0,mMaxBasketD=0,sumcrt=0,mCCP=0;
/*
*************************************************************************************************
	' *												
	' * File Name:	PRStudentEntry.jsp		[For Students]					
	' * Author:		Ashok Singh,Ankur,Sunny
	' * Date:		06th Nov 2008
	' * Version:	1.0								
	' * Description:	Pre Registration of Students [Choices for Back & Curr Core+Elective+FreeElective]
*************************************************************************************************
*/

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subject Selection for the comming classes(Pre Registration of Students) ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<Html>
 <script>
<!--
if(window.history.forward(1) != null)
window.history.forward(1);
-->
</script>
</head>

<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<cenTer>
<% 
String mSEMESTER="", mSname="";
String mBranch="", mAcad="";
String mInst="", mComp="", mWebEmail="";
int mSem=0, mSno=0, mChoice=1, mTot=0,msno=0,msno1=0;
String mySect="";
String mFELFinal="N", mCoreFinal="N";
int mSemester=0;
String mSemType="", mSubjType="", mSubjTypeDesc="", mSubjId="", mSubjName="", mBasket="";
String mColor="white";
String mCol1="lightyellow";
String mElecCode="", OldmELECTIVECODE="",mELECTIVECODE="",mPrevent="";
String mCol2="#F8F8F8";

String mysum="";

if (request.getParameter("sum")==null)
{
	 mysum="";
}	 
else
{
	mysum=request.getParameter("sum").toString().trim();
}

if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

try
{
OLTEncryption enc=new OLTEncryption();
if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
		response.setContentType("application/msword");
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	
		mInst=request.getParameter("instituteCode");
		mDID=request.getParameter("studentID");
		mExam=request.getParameter("examcode");
		mySect=request.getParameter("secbranch");
		mProg=request.getParameter("programcode");
		mPrevent=request.getParameter("Prevent");

		mSem=Integer.parseInt(request.getParameter("semester"));

		String mExamDesc="";
		qry="SELECT EXAMDESCRIPTION FROM EXAMMASTER where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"' ";
		rsexam=db.getRowset(qry);
			if(rsexam.next())
		   {
				mExamDesc=rsexam.getString("EXAMDESCRIPTION");
		   }

	%>	
<table border=0 width ="68%" align="center">
		<tr>
		<br>
		<td>
			<B>Name: </B><%=session.getAttribute("MemberName").toString().trim()%>
		</td>
		<td>
		<B>Enrollment No.: </B> <%=enc.decode(session.getAttribute("MemberCode").toString().trim())%>
		</tD>
		</tr>
		<%
String pc="",bc="",sc="";
			qry=" Select distinct  nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
			qry=qry+" SEMESTER SEMESTER from ";
			qry=qry+" STUDENTREGISTRATION where StudentID='" +mDID+ "' and examcode='"+mExam+"' and  InstituteCode='" + mInst + "'  ";
			rs=db.getRowset(qry);
 			//out.print(qry);
			
			
			if (rs.next())
			{
				
				pc=rs.getString("PROGRAMCODE");
				bc=rs.getString("BRANCHCODE");
				sc=rs.getString("SEMESTER");			
			
			}
		%>
		<tr>
		<td>
			<B>Program Code:</B> <%=pc%>
		</td>
		<td>
		 <B>Branch Code: </B><%=bc%>
		</tD>
		</tr>
		<tr>
		<td>
			<B>Semester: </B> <%=sc%>
		</td>
		<%
	qry="Select to_char(Sysdate,'dd-mm-yyyy hh:mi PM')date1 from Dual";	
		rs=db.getRowset(qry);
 			//out.print(qry);
			
			
			if (rs.next())
			{
				%>
				<td><b> Run Date :</b>  <%=rs.getString("date1")%></td>
				<%
			}
		%>		</tr>
		
	</table>
		


<BR>
<center><b>LSIT OF SUBJECT/CHOICE FOR <%=mExamDesc%></b></center>

<table bgcolor=#fce9c5 class="sort-table"  bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
<thead>
<tr bgcolor="#ff8c00">
  <td><b><font color=white>SNo.</font></b></td>
  <td><b><font color=white>Course Type</font></b></td>	
  <td><b><font color=white>Subject</font></b></td>
  <td><b><font color=white>Priority</font></b></td>
  <td><b><font color=white>Credit</font></b></td>
  </tr>
</thead>
	<tbody>

	<%	
	qry="select nvl(SENDTOHOD,' ') SENDTOHOD  from PREVENTS where PREVENTCODE='"+mPrevent+"'and MEMBERTYPE='"+mChkMType+"' and MEMBERID='"+mDID+"' ";
	rs=db.getRowset(qry);
	//out.print(qry);
	while(rs.next())
	{
	mSENDTOHOD=rs.getString("SENDTOHOD");
	}
qry="select DISTINCT nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
qry=qry+"nvl(B.CHOICE,'') CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,decode(B.subjecttype,'C','Core','E','Elective')ELECTIVECODE, ";
qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE,C.COURSECREDITPOINT COURSECREDITPOINT  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B,PROGRAMSCHEME C";
qry=qry+" where B.examcode='"+mExam+"' And a.subjectid=c.subjectid and b.subjectid=c.subjectid  And B.SemesterType='REG' and B.institutecode='"+mInst+"'";
qry=qry+" and B.studentid='"+mDID+"' and A.subjectID=B.subjectID AND A.INSTITUTECODE=C.INSTITUTECODE AND C.ACADEMICYEAR=B.ACADEMICYEAR AND C.SECTIONBRANCH=B.SECTIONBRANCH AND C.TAGGINGFOR=B.TAGGINGFOR AND C.SEMESTER=B.SEMESTER   order by SUBJECT ,ELECTIVECODE ";
 
rs1=db.getRowset(qry);
msno=0;
msno1=0;
while(rs1.next())
   {
      msno1++;
      mSubtype=rs1.getString("ELECTIVECODE");	
      msno++ ;
	%>
   	<tr  bgcolor='white'>
	<td><%=msno%></td>
	<td><%=mSubtype%></TD>
	<td><%=rs1.getString("SUBJECT")%></td>
	<td><%=rs1.getString("CHOICE")%></TD>
	<td><%=rs1.getString("COURSECREDITPOINT")%> </td>
	<%	
	sumcrt=sumcrt+rs1.getDouble("COURSECREDITPOINT");
	%>
	</tr>
  	<%
	}


qry="select DISTINCT nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, c.ELECTIVECODE type, ";
qry=qry+"nvl(B.CHOICE,0) CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,decode(c.ELECTIVECODE,'PD','Elective(PD)','DE','Elective',c.ELECTIVECODE)ELECTIVECODE, ";
qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE,nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C";
qry=qry+" where B.examcode='"+mExam+"'   And a.subjectid=c.subjectid and b.subjectid=c.subjectid And B.SemesterType='REG' and B.institutecode='"+mInst+"' And C.examcode='"+mExam+"' and C.institutecode='"+mInst+"'";
qry=qry+" and B.studentid='"+mDID+"' and A.subjectID=B.subjectID AND A.INSTITUTECODE=C.INSTITUTECODE AND C.ACADEMICYEAR=B.ACADEMICYEAR AND C.SECTIONBRANCH=B.SECTIONBRANCH AND C.TAGGINGFOR=B.TAGGINGFOR AND C.SEMESTER=B.SEMESTER   order by type,choice ";
rs1=db.getRowset(qry);
//out.print(qry);
while(rs1.next())
     {
	if(rs1.getString("type").equals("1")){
		%><tr bgcolor='lightyellow'><%
	}else if(rs1.getString("type").equals("2")){
			%><tr bgcolor='white'><%
	}else{
				%><tr bgcolor='white'><%
	}
	%>
	   	
		
		
		<td><%=++msno%></td>
		<%		 
		mSubtype=rs1.getString("ELECTIVECODE");	
	
			%>

		<td><%=mSubtype%></TD>
		<td><%=rs1.getString("SUBJECT")%></td>
		<td><%=rs1.getString("CHOICE")%></TD>
		<td><%=rs1.getString("COURSECREDITPOINT")%> </td>
		<%
		//mCourseCrPt=
		sumcrt=sumcrt+Double.parseDouble(rs1.getString("COURSECREDITPOINT"));
		%>
		</tr>	

    		<%
	
	}	






%>
</tbody>
</table>	
<br>
<center><b>LIST OF BACKLOG PAPER REGISTERED </b></center>
<table bgcolor=#fce9c5 class="sort-table" id="table-2" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
<thead>
<tr bgcolor="#ff8c00">
<td><b><font color=white>SNo.</font></b></td>
<td><b><font color=white>Course Type</font></b></td>	
<td><b><font color=white>Subject</font></b></td>
<td><b><font color=white>Priority</font></b></td>
<td><b><font color=white>Credit</font></b></td>
</tr>
</thead>
<tbody>
<%
qry="select DISTINCT a.SubjectID SubjectID, nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT  ,";
qry=qry+"nvl(B.CHOICE,0) CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,decode(B.subjecttype,'C','Core','E','Elective')ELECTIVECODE, ";
qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE   from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
qry=qry+" where B.examcode='"+mExam+"' and B.institutecode='"+mInst+"' And b.semestertype in ('RWJ','SAP') ";
qry=qry+" and B.studentid='"+mDID+"' And B.SUBJECTTYPE='C' and  A.subjectID=B.subjectID  ";
//out.print(qry);
	rs1=db.getRowset(qry);
	msno=0;
	while(rs1.next())
	{
	msno++ ;
	qry="select max(COURSECREDITPOINT)COURSECREDITPOINT from (Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT From PROGRAMSUBJECTTAGGING C where examcode='"+mExam+"'  And subjectid='"+rs1.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"'";
	qry=qry+" UNION Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT   From OfferSubjectTagging C where examcode='"+mExam+"'  And subjectid='"+rs1.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"')";
	//out.print(qry);
	rsCCP=db.getRowset(qry);
	if (rsCCP.next())
	{
		mCCP=rsCCP.getDouble("COURSECREDITPOINT");
	}
	else
	{
		mCCP=0;
	}
	mSubtype=rs1.getString("ELECTIVECODE");
	%>
	<tr bgcolor='#FFB9B9'>
        <td><%=msno%></td>		
	<td><%=mSubtype%></TD>
	<td><%=rs1.getString("SUBJECT")%></td>
	<td><%=rs1.getString("Choice")%></TD>
	<td><%=mCCP%></td></tr>		   
 	<%
	sumcrt=sumcrt+mCCP;
	}

qry="select DISTINCT nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
qry=qry+"nvl(B.CHOICE,'') CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,decode(B.subjecttype,'C','Core','E','Elective')ELECTIVECODE, ";
qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE,C.COURSECREDITPOINT COURSECREDITPOINT  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B,PR#ELECTIVESUBJECTS C ";
qry=qry+" where B.examcode='"+mExam+"'  And B.SUBJECTTYPE<>'C' And a.subjectid=c.subjectid and b.subjectid=c.subjectid  and B.SemesterType='RWJ' and B.institutecode='"+mInst+"' And C.examcode='"+mExam+"' and C.institutecode='"+mInst+"'";
qry=qry+" and B.studentid='"+mDID+"' and A.subjectID=B.subjectID AND A.INSTITUTECODE=C.INSTITUTECODE AND C.ACADEMICYEAR=B.ACADEMICYEAR AND C.SECTIONBRANCH=B.SECTIONBRANCH AND C.TAGGINGFOR=B.TAGGINGFOR AND C.SEMESTER=B.SEMESTER  order by SUBJECT ,ELECTIVECODE";



%>

</tbody>
</table>	


<%
 
%>
<table width="100%" align=cetner>
	<tr>
<td  align="center"><font color="green" face=verdana size=3><b>Total Course Credit Point : <%=mysum%></b></font></td>
</tr>
	</table>

<%



		
		}
else
{
%>
<br>
Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
<%
}
}
catch(Exception e)
{
	//out.print(e);
}
%>

</body>
</Html>