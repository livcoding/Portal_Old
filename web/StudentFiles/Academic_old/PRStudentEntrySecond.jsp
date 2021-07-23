<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
ResultSet rsChApr=null,rs=null,rs1=null,rss1=null,rsc=null,rse=null,rse1=null,rse2=null,rsso=null;
String qry="",qry1="", mDID="",mProg="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
double mMinCrLmt=0, mMaxCrLmt=0, mMinCrLmtTkn=0, mMaxCrLmtTkn=0, mCourseCrPt=0, mTotalCrLmtTkn=0;
String mSect="",	mSubSect="", mTag="",mElective="",mSCode="";
String mExam="", mFailGraders="F", meid="", mPrcode="";
String mName1="", mName2="",mName3="", mName4="", mName5="", mName6="", mName7="", mName8="", mName9="", mName10="";
int mochoice=0, mochoice1=0;
/*
*************************************************************************************************
	' *
	' * File Name:	PRStudentEntrySecond.jsp		[For Students]					
	' * Author:		Vijay Kumar
	' * Date:		25th Oct 2008
	' * Version:	1.0								
	' * Description:	Pre Registration of Students [Re-Choices for Back & Curr Core+Elective+FreeElective]
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
<style type="text/css"> 
body {scrollbar-3dlight-color:#ffd700;
scrollbar-arrow-color:#ff0; 
scrollbar-base-color:=:#000ff0;
scrollbar-darkshadow-color:#000000; 
scrollbar-face-color:#de6400; 
scrollbar-highlight-color:#9900005;
scrollbar-shadow-color:#f0f} 
</style> 
<TITLE>#### <%=mHead%> [ Subject Selection for the comming classes(Re-Pre Registration of Students) ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<Html>
<head>
<script language=javascript>
<!--
function FunMustChoice(j,k)
{
	var x=parseInt(j);
	var y=parseInt(k);
	var TotCtr=document.frm1.TotalRec.value;
	mName1="CHK"+y;
	if(document.frm1[mName1].checked==false)
	{
		alert('You are recommended to add backlog core subject in your choice list.');
		document.frm1[mName1].checked=true;
	}
	else
	{
		FunRefresh(j,k);
	}
}
function FunRefresh(j,k)
{
	var TotCCP, TotCCPAld, x, y, TotCtr, TotCCPTkn;
	TotCCP=document.frm1.TotalCCP.value;
	TotCCPAld=document.frm1.TotalCCPAld;
	var z;
	TotCtr=document.frm1.TotalRec.value;
	x=parseInt(j);
	y=parseInt(k);
	mName1="CHK"+y;
	//alert(mName1);
	if(document.frm1[mName1].checked==true)
	{
		z=parseInt(TotCCPAld.value)+x;
		TotCCPAld.setAttribute("value",z);
		alert('You have taken (Cource Credit Point) : '+z+' (including all previous approved choices) and Total allowed : '+TotCCP);
	}
	else
	{
		z=parseInt(TotCCPAld.value)-x;
		TotCCPAld.setAttribute("value",z);
		alert('You have taken (Cource Credit Point) : '+z+' (including all previous approved choices) and Total allowed : '+TotCCP);
	}
}
-->
 </SCRIPT>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm1.x.value='ddd';
    	    document.frm1.submit();
	}
-->
 </script>

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
int mSem=0, mSno=0, mChoice=1, mTot=0;
String mySect="";
String mFELFinal="N", mCoreFinal="N";
int mSemester=0;
String mSemType="", mSubjType="", mSubjTypeDesc="", mSubjId="", mSubjName="", mBasket="";
String mColor="white";
String mCol1="lightyellow";
String mElecCode="", OldmELECTIVECODE="",mELECTIVECODE="";
String mCol2="#F8F8F8";

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
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  	//-----------------------------
	//-- Enable Security Page Level  
	//-----------------------------
	qry="Select WEBKIOSK.ShowLink('109','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

	mComp=session.getAttribute("CompanyCode").toString().trim();
	mInst=session.getAttribute("InstituteCode").toString().trim();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());

	qry="select nvl(PREREGEXAMID,' ') EXAMID from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mInst+"'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if (rs.next())
		mExam=rs.getString(1);
	
	qry=" Select distinct nvl(STUDENTID, ' ') STUDENTID, nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
	qry=qry+" SEMESTER SEMESTER, TaggingFor, ACADEMICYEAR, SECTIONBRANCH from ";
	qry=qry+" STUDENTREGISTRATION where StudentID='" +mDID+ "' and examcode='"+mExam+"' and  InstituteCode='" + mInst + "' and ";
	qry=qry+" (EXAMCODE,REGCODE) in (SELECT  ExamCode,REGCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst +"' ";
	qry=qry+" and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
	qry=qry+" AND NVL(DEACTIVE,'N')='N') and ";
	qry=qry+"  STUDENTID IN (SELECT MemberID FROM PREVENTS WHERE INSTITUTECODE='"+ mInst +"' and nvl(SSTPOPULATED,'N')='N'";
	qry=qry+" AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst +"'";
	qry=qry+" and ExamCode='"+mExam+"' and NVL(APPROVED,'N')='N' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
	qry=qry+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='S' and MEMBERID='"+mDID+"'";
	qry=qry+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N')";
	rs=db.getRowset(qry);
 	//out.print(qry);

	if (rs.next())
	{
		mSEMESTER=rs.getString("SEMESTER");
		//mSem=rs.getInt("SEMESTER")+1;

//--------------------Changed by Vijay---------------
		mSem=rs.getInt("SEMESTER");
//--------------------Changed by Vijay---------------

		mSname=session.getAttribute("MemberName").toString().trim();

		mSCode=enc.decode(session.getAttribute("MemberCode").toString().trim());
		mProg=rs.getString("PROGRAMCODE");
		mBranch=rs.getString("BRANCHCODE");
		mSect=rs.getString("SECTIONBRANCH");
		mTag=rs.getString("TaggingFor");
		mAcad=rs.getString("ACADEMICYEAR");
		mySect=mSect;

//-------------------------------------------------------------------------------
//-----Query For Checking whether Data is available other than Current Core------
//-------------------------------------------------------------------------------
		qry="Select 'Y' from (";
		qry=qry+" (select distinct A.semester Semester, 'C' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'A')BASKET from PROGRAMSCHEME A,SUBJECTMASTER B";
		qry=qry+" where A.institutecode='"+mInst +"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
		qry=qry+" and A.semester<"+mSem+" AND A.BASKET='A' AND A.institutecode=B.institutecode and A.subjectID=B.subjectID )";
		qry=qry+" union ";
		qry=qry+" (select distinct A.semester Semester, 'E' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')'||'***'||nvl(A.ELECTIVECODE,' ') SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'D')BASKET from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B";
		qry=qry+" where A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
		qry=qry+" and A.semester<="+mSem+" AND A.BASKET IN ('B','D') AND A.institutecode=B.institutecode and A.subjectID=B.subjectID )";
		qry=qry+" union ";
		qry=qry+" (select distinct A.semester Semester, 'F' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'C')BASKET from FREEELECTIVE A,SUBJECTMASTER B";
		qry=qry+" where A.institutecode='"+mInst +"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
		qry=qry+" and A.semester<="+mSem+" AND A.BASKET='C' AND A.institutecode=B.institutecode and A.subjectID=B.subjectID ))";
		qry=qry+" WHERE SubjectID Not In( select SUBJECTID from STUDENTRESULT d where d.institutecode='"+mInst+"' ";
		qry=qry+" and d.grade<>'"+mFailGraders+"' And d.studentid='"+mChkMemID+"' ) And SubjectID IN";
		qry=qry+" ((SELECT O.SUBJECTID SUBJECTID FROM OFFERSUBJECTTAGGING O WHERE O.INSTITUTECODE='"+mInst+"' ";
		qry=qry+" AND O.EXAMCODE='"+mExam+"' AND O.ACADEMICYEAR='"+mAcad+"' AND O.PROGRAMCODE='"+mProg+"' AND O.TAGGINGFOR='"+mTag+"' ";
		qry=qry+" AND O.SECTIONBRANCH='"+mySect+"' AND O.SEMESTER<="+mSem+" AND O.BASKET IN (SELECT BASKET FROM BASKETMASTER WHERE INSTITUTECODE='"+mInst+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER<"+mSem+" and NVL(DEACTIVE,'N')='N') AND NVL(DEACTIVE,'N')='N')";
		qry=qry+" UNION (SELECT P.SUBJECTID SUBJECTID FROM PROGRAMSUBJECTTAGGING P WHERE P.INSTITUTECODE='"+mInst+"' ";
		qry=qry+" AND P.EXAMCODE='"+mExam+"' AND P.ACADEMICYEAR='"+mAcad+"' AND P.PROGRAMCODE='"+mProg+"' AND P.TAGGINGFOR='"+mTag+"' ";
		qry=qry+" AND P.SECTIONBRANCH='"+mySect+"' AND P.SEMESTER<"+mSem+" AND P.BASKET IN (SELECT BASKET FROM BASKETMASTER WHERE INSTITUTECODE='"+mInst+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER<"+mSem+" and NVL(DEACTIVE,'N')='N') AND NVL(DEACTIVE,'N')='N'))";
//-------------------------------------------------------------------------------
		rse1=db.getRowset(qry);
		//out.print(qry);
		if(rse1.next())
		{
//-------------------------------------------------------------------------------
//-----Query For Checking whether Initial Pre Registration is Finalized by HOD---------
//-------------------------------------------------------------------------------
		qry="SELECT 'Y' from PREVENTS WHERE INSTITUTECODE='"+mInst+"' and nvl(ELRNNINGFINALIZEDBYHOD,'N')='Y' and PREVENTCODE IN (SELECT PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"') AND MEMBERTYPE='E' and MEMBERID IN (SELECT EMPLOYEEID MEMBERID FROM HODLIST WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"'";
		qry=qry+" AND DEPARTMENTCODE IN (SELECT DEPARTMENTCODE FROM BRANCHDEPTTAGGING WHERE INSTITUTECODE='"+mInst+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND  TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"'))";
//-------------------------------------------------------------------------------
		rse2=db.getRowset(qry);
		//out.print(qry);
		if(rse2.next())
		{
		   qry="SELECT MINCREDITPOINT MINCRPT, MAXCREDITPOINT MAXCRPT FROM PR#PROGRAMMINMAXCP WHERE INSTITUTECODE='"+mInst+"' AND (EXAMCODE,REGCODE) in ";
		   qry=qry+" (SELECT  ExamCode,REGCODE from PREVENTMASTER WHERE INSTITUTECODE='"+mInst+"' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S' AND NVL(DEACTIVE,'N')='N')";
		   qry=qry+" AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND SEMESTER='"+mSem+"'";
		   rsso=db.getRowset(qry);
		   if(rsso.next())
		   {
			mMinCrLmt=rsso.getDouble(1);
			mMaxCrLmt=rsso.getDouble(2);
		   }
		   qry=" SELECT Subjectid, COURSECREDITPOINT FROM ProgramScheme WHERE INSTITUTECODE='"+mInst+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND BASKET ='A'";
		   qry=qry+" AND SUBJECTID IN (SELECT SUBJECTID FROM pr#studentsubjectchoice WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND CHOICE>0 AND STUDENTID='"+mChkMemID+"' AND SUBJECTTYPE='C')";
		   qry=qry+" UNION";
		   qry=qry+" SELECT Subjectid, COURSECREDITPOINT FROM pr#electiveSubjects WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND BASKET IN ('B','D')";
		   qry=qry+" AND SUBJECTID IN (SELECT SUBJECTID FROM pr#studentsubjectchoice WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND CHOICE>0 AND STUDENTID='"+mChkMemID+"' AND SUBJECTTYPE='E') AND nvl(SUBJECTRUNNING,'N')='Y'";
		   qry=qry+" UNION";
		   qry=qry+" SELECT Subjectid, COURSECREDITPOINT FROM FREEELECTIVE WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND BASKET='C'";
		   qry=qry+" AND SUBJECTID IN (SELECT SUBJECTID FROM pr#studentsubjectchoice WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND CHOICE>0 AND STUDENTID='"+mChkMemID+"' AND SUBJECTTYPE='F') AND nvl(SUBJECTRUNNING,'N')='Y'";
		   rsso=db.getRowset(qry);
		   //out.print(qry);
		   while(rsso.next())
		   {
			mMaxCrLmtTkn=mMaxCrLmtTkn+rsso.getDouble("COURSECREDITPOINT");
		   }
		   //out.print(mMaxCrLmtTkn);
		   qry= " select nvl(ELRNNINGFINALIZEDBYHOD,'N') EL from PREVENTS where INSTITUTECODE='"+mInst+"' ";
		   qry= qry + " And nvl(SSTPOPULATED,'N')='N' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst +"'";
		   qry= qry + " and ExamCode='"+mExam+"' and NVL(APPROVED,'N')='N' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='E'";
		   qry= qry + " AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='E' " ;
		   qry= qry + "  and MEMBERID in (select EMPLOYEEID from HODLIST where DEPARTMENTCODE in (select DEPARTMENTCODE from BRANCHDEPTTAGGING where ";
		   qry= qry + " ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' ";
		   qry= qry + " and SECTIONBRANCH='"+mySect+"' and nvl(DEACTIVE,'N')='N' ) ) ";
	   	   rsso=db.getRowset(qry);
		   //out.print(qry);

		   if(rsso.next())
		   {
 			if(!rsso.getString("EL").equals("Y") && !mCoreFinal.equals("Y") && !mFELFinal.equals("Y"))
			{
		      qry=" Select nvl(SENDTOHOD,'N') SENDTOHOD,PREVENTCODE PREVENTCODE FROM PREVENTS";
			qry=qry+" WHERE INSTITUTECODE='"+ mInst +"' and nvl(SSTPOPULATED,'N')='N' and nvl(ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(APPROVED,'N')='N' and nvl(LOADDISTRIBUTIONSTATUS,'N') not in ('F','A') AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst +"'";
			qry=qry+" And ExamCode='"+mExam+"' And nvl(FREEELECTIVERUNFINALIZED,'N')='N' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
			qry=qry+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='S' and MEMBERID='"+mDID+"'";
			qry=qry+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N'";
		   	rss1=db.getRowset(qry);
			//out.print(qry);
		   	if(!rss1.next())
	    		{
				%>
				<P><br><br><br><font size=4 color=red>Event period is already completed or Pre Reg. event has not been declared for you!</font>
				<P><font size=4>Check/View <a href="PRStudentView.jsp">Pre-registration detail</a>, your opted Subjects </font><br><br><br><br><br><br><hr><br>
				<%
			}
		      else if(rss1.getString("SENDTOHOD").equals("Y"))
			{
				%>
				<P><br><br><br><font size=4 color=red>You have already submitted your choice2 earlier for the required semester</font>
				<P> <font size=4>Check/View <a href="PRStudentView.jsp">Pre-registration detail</a>, your opted Subjects </font><br><br><br><br><br><br><hr><br>
				<%
			}
			else
	      	{
				mPrcode=rss1.getString("PREVENTCODE");
				%>
				<table border=0 groups=columns cellspacing=0 width='100%' >
				<form name="frm1" method=post action="PRStudentActionSecond.jsp">
				<tr>
				<td colspan=3 align=center><b>
				<input Type=hidden id=mExam name=mExam value=<%=mExam%>>
				<input Type=hidden id=mSem name=mSem value=<%=mSem%>>
				<input Type=hidden id=mProg name=mProg value=<%=mProg%>>
				<input Type=hidden id=mSname name=mSname value=<%=mSname%>>
				<input Type=hidden id=mBranch name=mBranch value=<%=mBranch%>>
				<input Type=hidden id=mSect name=mSect value=<%=mySect%>>		
				<input Type=hidden id=mTag name=mTag value=<%=mTag%>>
				<input Type=hidden id=mAcad name=mAcad value=<%=mAcad%>>
				<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>STUDENT RE-PRE REGISTRATION/SUBJECT CHOICE ENTRY SCREEN</b></font></td>
				</tr>
				</table>
				<table border=1 groups=columns cellspacing=0 width='100%' >
				<tr>
			     	<td colspan=2><FONT face=Arial size=2 color=black><STRONG>Student Name - </STRONG></FONT><%=GlobalFunctions.toTtitleCase(mSname)%> (<%=mSCode%>)</td>
				<td><FONT face=Arial size=2 color=black><STRONG>Institute Code &nbsp; </STRONG></FONT><select name=InstCode id=InstCode><option value='<%=mInst%>'><%=mInst%></option></select></td>		  
				</tr>
				<tr>
				<td><FONT face=Arial size=2 color=black><STRONG>Exam Code </STRONG></FONT><select name=ExamCode id=ExamCode><option value=<%=mExam%>><%=mExam%></option></select></td>
				<td><FONT face=Arial size=2 color=black><STRONG>Academic Year </STRONG></FONT><select name=AcadYear id=AcadYear><option value='<%=mAcad%>'><%=mAcad%></option></select></td>
				<td><FONT face=Arial size=2 color=black><STRONG>Program Code &nbsp;</STRONG></FONT><select id=ProgCode Name=ProgCode><option value='<%=mProg%>'><%=mProg%></option></select></td>
			    	</tr>
				<tr><td><FONT face=Arial size=2 color=black><STRONG>Pre Registration for Semester </STRONG></FONT><select name=sem id=sem><option value=<%=String.valueOf(mSem)%>><%=mSem%></option></select></td>
				<td><FONT face=Arial size=2 color=black><STRONG>Section Code &nbsp;&nbsp; </STRONG></FONT><select name=Sect id=Sect><option Value='<%=mySect%>'><%=mySect%></option></select>
				<!-- 
				<FONT face=Arial size=2 color=black><STRONG>SubSection Code &nbsp;&nbsp; </STRONG></FONT><Select Name=SubSect id=SubSect><option value='<%=mSubSect%>'><%=mSubSect%></option></select>
				-->
				<td><FONT face=Arial size=2 color=black><STRONG>Tagging For &nbsp; &nbsp; </STRONG></FONT><select Name=TaggingFor id=TaggingFor><option Value='<%=mTag%>'><%=mTag%></option></td>
				</tr>
				<tr><td colspan=3>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
				<thead>
				<tr bgcolor="#ff8c00">
				<td><font color=white face=arial size=2><b>SrNo<b></font></td>
				<td colspan=2 align=center><font color=white face=arial size=2><b>Subject Type<b></font></td>
				<td><font color=white face=arial size=2><b>Subject (Subject Code)<b></font></td>
				<td title="Cource Credit Point"><font color=white face=arial size=2><b>CCP<b></font></td>
				<td><font color=white face=arial size=2><b>Choice<b></font></td>
				</tr>
				</thead>
				<tbody>
				<%

//-----------------------------------------------------
//----------- START OF BACK ELECTIVE ------------------
//-----------------------------------------------------

				qry="Select distinct Semester, SEMESTERTYPE, SUBJECTTYPE, SUBJECTID, SUBJECT Subj, COURSECREDITPOINT COURSECREDITPOINT, nvl(BASKET,' ')BASKET";
				qry=qry+" from (";
				qry=qry+" (select distinct A.semester Semester, 'RWJ' SEMESTERTYPE, 'E' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')'||'***'||nvl(A.ELECTIVECODE,' ') SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'D')BASKET from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
				qry=qry+" and A.semester<"+mSem+" AND A.BASKET IN ('B','D') AND A.institutecode=B.institutecode and A.subjectID=B.subjectID ))";
				qry=qry+" WHERE SubjectID Not In( select SUBJECTID from STUDENTRESULT d where d.institutecode='"+mInst+"' ";
				qry=qry+" and d.grade<>'"+mFailGraders+"' And d.studentid='"+mChkMemID+"' ) And SubjectID IN";
				qry=qry+" ((SELECT O.SUBJECTID SUBJECTID FROM OFFERSUBJECTTAGGING O WHERE O.INSTITUTECODE='"+mInst+"' ";
				qry=qry+" AND O.EXAMCODE='"+mExam+"' AND O.ACADEMICYEAR='"+mAcad+"' AND O.PROGRAMCODE='"+mProg+"' AND O.TAGGINGFOR='"+mTag+"' ";
				qry=qry+" AND O.SECTIONBRANCH='"+mySect+"' AND O.SEMESTER<"+mSem+" AND O.BASKET IN (SELECT BASKET FROM BASKETMASTER WHERE INSTITUTECODE='"+mInst+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER<"+mSem+" and NVL(DEACTIVE,'N')='N') AND NVL(DEACTIVE,'N')='N')";
				qry=qry+" UNION (SELECT P.SUBJECTID SUBJECTID FROM PROGRAMSUBJECTTAGGING P WHERE P.INSTITUTECODE='"+mInst+"' ";
				qry=qry+" AND P.EXAMCODE='"+mExam+"' AND P.ACADEMICYEAR='"+mAcad+"' AND P.PROGRAMCODE='"+mProg+"' AND P.TAGGINGFOR='"+mTag+"' ";
				qry=qry+" AND P.SECTIONBRANCH='"+mySect+"' AND P.SEMESTER<"+mSem+" AND P.BASKET IN (SELECT BASKET FROM BASKETMASTER WHERE INSTITUTECODE='"+mInst+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER<"+mSem+" and NVL(DEACTIVE,'N')='N') AND NVL(DEACTIVE,'N')='N'))";
				qry=qry+" order by SUBJECTTYPE, Subject";
				//out.print(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					mSno++;
					mColor="LightGrey";
					mSemester=rs.getInt("Semester");
					mSemType=rs.getString("SEMESTERTYPE");
					mSubjType=rs.getString("SUBJECTTYPE");
					mSubjId=rs.getString("SUBJECTID");
					mSubjName=rs.getString("Subj");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					mBasket=rs.getString("BASKET");
					mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;
					if(mSubjType.equals("E"))
					{
						int len=0;
						int pos1=0;
						len=mSubjName.length();
						pos1=mSubjName.indexOf("***");
						mElecCode=mSubjName.substring(pos1+3,len);
						mSubjName=mSubjName.substring(0,pos1);
					}
					mName1="CHK"+String.valueOf(mSno).trim(); 
					mName2="SEM"+String.valueOf(mSno).trim(); 
					mName3="SEMTYP"+String.valueOf(mSno).trim(); 
					mName4="SUBJTYP"+String.valueOf(mSno).trim(); 
					mName5="SUBJID"+String.valueOf(mSno).trim(); 
					mName6="SUBJ"+String.valueOf(mSno).trim(); 
					mName7="CCP"+String.valueOf(mSno).trim(); 
					mName8="ELCODE"+String.valueOf(mSno).trim();
					mName9="BASKET"+String.valueOf(mSno).trim(); 
					mName10="CHOICE"+String.valueOf(mSno).trim(); 

					%>
				 	<tr bgcolor="<%=mColor%>">
					<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
					<td align=center><Font face=arial size=2>BACKLOG</font></td>
					<%
					if(mSubjType.equals("E"))
					{
						mSubjTypeDesc="ELECTIVE";
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%> (<%=mElecCode%>)</font></td>
						<%
					}
					else
					{
						mSubjTypeDesc=" ";
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%></font></td>
						<%
					}
					%>
					<td><Font face=arial size=2><%=mSubjName%></font></td>
					<td align=center><Font face=arial size=2><%=mCourseCrPt%></font></td>
					<%
					qry="Select 'Y' from pr#electiveSubjects WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND BASKET IN('B','D') AND nvl(SUBJECTRUNNING,'N')='Y'";
					qry=qry+" AND SUBJECTID IN (SELECT SUBJECTID FROM pr#studentsubjectchoice WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND CHOICE>0 AND SEMESTERTYPE='RWJ' AND STUDENTID='"+mChkMemID+"' AND SUBJECTID='"+mSubjId+"' AND SUBJECTTYPE='E' AND ELECTIVECODE='"+mElecCode+"')";
					rs1=db.getRowset(qry);
					//out.print(qry);
					if(rs1.next())
					{
						%>
						<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' checked disabled></td>
						<%
					}
					else
					{
						%>
						<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>')"></td>
						<%
					}
					%>
					<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
					<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='<%=mSemType%>'>
					<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
					<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
					<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
					<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
					<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
					<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>
					<input Type=hidden id='<%=mName10%>' name='<%=mName10%>' value='<%=mChoice%>'>
					</tr>
					<%
				}

//-----------------------------------------------------
//------------- END OF BACK ELECTIVE ------------------
//-----------------------------------------------------

//---------------------------------------

//-----------------------------------------------------
//-------START OF CURR ELECTIVE [WHERE BASKET-'D']-----
//-----------------------------------------------------

				qry="Select distinct Semester, SEMESTERTYPE, SUBJECTTYPE, SUBJECTID, SUBJECT Subj, COURSECREDITPOINT COURSECREDITPOINT, nvl(BASKET,' ')BASKET";
				qry=qry+" from (";
				qry=qry+" (select distinct A.semester Semester, 'REG' SEMESTERTYPE, 'E' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')'||'***'||nvl(A.ELECTIVECODE,' ') SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'D')BASKET from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
				qry=qry+" and A.semester="+mSem+" AND A.BASKET='D' AND A.institutecode=B.institutecode and A.subjectID=B.subjectID)";
				qry=qry+" )order by SUBJECTTYPE, Subject";
				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					mSno++;
					mColor="White";
					mSemester=rs.getInt("Semester");
					mSemType=rs.getString("SEMESTERTYPE");
					mSubjType=rs.getString("SUBJECTTYPE");
					mSubjId=rs.getString("SUBJECTID");
					mSubjName=rs.getString("Subj");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					mBasket=rs.getString("BASKET");
					mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;
					if(mSubjType.equals("E"))
					{
						int len=0;
						int pos1=0;
						len=mSubjName.length();
						pos1=mSubjName.indexOf("***");
						mElecCode=mSubjName.substring(pos1+3,len);
						mSubjName=mSubjName.substring(0,pos1);
						//out.print(mElecCode+" "+mSubjName);
					}

					mName1="CHK"+String.valueOf(mSno).trim(); 
					mName2="SEM"+String.valueOf(mSno).trim(); 
					mName3="SEMTYP"+String.valueOf(mSno).trim(); 
					mName4="SUBJTYP"+String.valueOf(mSno).trim(); 
					mName5="SUBJID"+String.valueOf(mSno).trim(); 
					mName6="SUBJ"+String.valueOf(mSno).trim(); 
					mName7="CCP"+String.valueOf(mSno).trim(); 
					mName8="ELCODE"+String.valueOf(mSno).trim(); 
					mName9="BASKET"+String.valueOf(mSno).trim(); 
					mName10="CHOICE"+String.valueOf(mSno).trim(); 

					%>
				 	<tr bgcolor="<%=mColor%>">
					<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
					<td align=center><Font face=arial size=2>CURRENT</font></td>
					<%
					if(mSubjType.equals("E"))
					{
						mSubjTypeDesc="ELECTIVE";
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%> (<%=mElecCode%>)</font></td>
						<%
					}
					else
					{
						mSubjTypeDesc=" ";
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%></font></td>
						<%
					}
					%>
					<td><Font face=arial size=2><%=mSubjName%></font></td>
					<td align=center><Font face=arial size=2><%=mCourseCrPt%></font></td>
					<%
					qry="Select 'Y' from pr#electiveSubjects WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND BASKET='D' AND nvl(SUBJECTRUNNING,'N')='Y'";
					qry=qry+" AND SUBJECTID IN (SELECT SUBJECTID FROM pr#studentsubjectchoice WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND CHOICE>0 AND SEMESTERTYPE='REG' AND STUDENTID='"+mChkMemID+"' AND SUBJECTID='"+mSubjId+"' AND SUBJECTTYPE='E' AND ELECTIVECODE='"+mElecCode+"')";
					rs1=db.getRowset(qry);
					//out.print(qry);
					if(rs1.next())
					{
						%>
						<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' checked disabled></td>
						<%
					}
					else
					{
						%>
						<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>')"></td>
						<%
					}
					%>
					<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
					<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='<%=mSemType%>'>
					<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
					<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
					<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
					<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
					<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
					<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>
					<input Type=hidden id='<%=mName10%>' name='<%=mName10%>' value='<%=mChoice%>'>
					</tr>
					<%
				}
//-----------------------------------------------------
//----------END OF ELECTIVE [WHERE BASKET-'D']---------
//-----------------------------------------------------

//---------------------------------------

//-----------------------------------------------------
//---------START OF ELECTIVE [WHERE BASKET='B']--------
//-----------------------------------------------------

				qry="Select count(A.ELECTIVECODE)cnt,A.ELECTIVECODE ELECTIVECODE, nvl(A.BASKET,'B')BASKET From PR#ELECTIVESUBJECTS A";
				qry=qry+" where A.INSTITUTECODE='"+mInst+"' and A.EXAMCODE='"+mExam+"' and A.ACADEMICYEAR='"+mAcad+"'";
				qry=qry+" and A.PROGRAMCODE='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' and A.SECTIONBRANCH='"+mySect+"'";
				qry=qry+" and A.SEMESTER="+mSem+" and nvl(A.BASKET,'B')='B' and nvl(A.DEACTIVE,'N')='N'";
				qry=qry+" group by A.ELECTIVECODE, A.BASKET";
				rsc=db.getRowset(qry);
				while(rsc.next())
				{
					mTot=rsc.getInt("cnt");
					mElecCode=rsc.getString("ELECTIVECODE");
					mBasket=rsc.getString("BASKET");

					qry="Select A.SUBJECTID SUBJECTID, B.Subject||'('||B.SubjectCode||')' Subj, A.COURSECREDITPOINT COURSECREDITPOINT From PR#ELECTIVESUBJECTS A,  SubjectMaster B ";
					qry=qry+" where A.INSTITUTECODE='"+mInst+"' and A.EXAMCODE='"+mExam+"' and A.ACADEMICYEAR='"+mAcad+"'";
					qry=qry+" and A.ELECTIVECODE='"+mElecCode+"' and A.PROGRAMCODE='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' and A.SECTIONBRANCH='"+mySect+"'";
					qry=qry+" and A.SEMESTER="+mSem+" and nvl(A.DEACTIVE,'N')='N'  and nvl(b.deactive,'N')='N' and B.subjectID=A.subjectID ";
					qry=qry+" Group By A.SUBJECTID , B.Subject||'('||B.SubjectCode||')', A.COURSECREDITPOINT ";
					//out.print(qry);
					rs1=db.getRowset(qry);
					while(rs1.next())
					{
						mSno++;
						mColor="White";
						mSemester=mSem;
						mSemType="REG";
						mSubjType="E";
						mSubjId=rs1.getString("SUBJECTID");
						mSubjName=rs1.getString("Subj");
						mCourseCrPt=rs1.getDouble("COURSECREDITPOINT");
						mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;

						mELECTIVECODE=mElecCode;
				
						qry="Select choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER='"+mSem+"' ";
						qry=qry+" and SEMESTERTYPE='REG' and STUDENTID='"+mChkMemID+"' and SUBJECTID='"+mSubjId+"' ";
						qry=qry+" and SUBJECTTYPE='E'";
						rse=db.getRowset(qry);
						if(rse.next())
						{
							mochoice=rse.getInt("chc");	
						}
						else
						{
							mochoice=0; 			
						}

						if (!mELECTIVECODE.equals(OldmELECTIVECODE))
						{
							if (mChoice==0)
								mChoice=1 ;
							else
								mChoice=0 ;
							OldmELECTIVECODE=mELECTIVECODE;
						}
						if (mChoice==0) 
							mColor=mCol1;
						else
						      mColor=mCol2;

						mName1="CHK"+String.valueOf(mSno).trim(); 
						mName2="SEM"+String.valueOf(mSno).trim(); 
						mName3="SEMTYP"+String.valueOf(mSno).trim(); 
						mName4="SUBJTYP"+String.valueOf(mSno).trim(); 
						mName5="SUBJID"+String.valueOf(mSno).trim(); 
						mName6="SUBJ"+String.valueOf(mSno).trim(); 
						mName7="CCP"+String.valueOf(mSno).trim(); 
						mName8="ELCODE"+String.valueOf(mSno).trim(); 
						mName9="BASKET"+String.valueOf(mSno).trim(); 
						mName10="CHOICE"+String.valueOf(mSno).trim(); 

	      			      if(!mElective.equals(mElecCode))
						{
							mElective=mElecCode;
							%>
							<tr bgcolor="<%=mColor%>">
							<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
							<td align=center><Font face=arial size=2>CURRENT</font></td>
							<td align=center><Font face=arial size=2>ELECTIVE (<%=mElecCode%>)</font></td>
							<td align=left><Font face=arial size=2><%=mSubjName%></font></td>
							<td align=center><Font face=arial size=2><%=mCourseCrPt%></font></td>
							<td>
							<%
							qry="Select nvl(SUBJECTRUNNING,'N')SUBJECTRUNNING from pr#electiveSubjects WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND BASKET='B' AND nvl(SUBJECTRUNNING,'N')='Y'";
							qry=qry+" AND SUBJECTID IN (SELECT SUBJECTID FROM pr#studentsubjectchoice WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND CHOICE>0 AND SEMESTERTYPE='REG' AND STUDENTID='"+mChkMemID+"' AND SUBJECTTYPE='E' AND ELECTIVECODE='"+mElecCode+"')";
							rs=db.getRowset(qry);
							//out.print(qry);
							if(rs.next())
							{
								qry="Select nvl(SUBJECTRUNNING,'N')SUBJECTRUNNING from pr#electiveSubjects WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND BASKET='B' AND nvl(SUBJECTRUNNING,'N')='Y'";
								qry=qry+" AND SUBJECTID IN (SELECT SUBJECTID FROM pr#studentsubjectchoice WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND CHOICE>0 AND SEMESTERTYPE='REG' AND STUDENTID='"+mChkMemID+"' AND SUBJECTID='"+mSubjId+"' AND SUBJECTTYPE='E' AND ELECTIVECODE='"+mElecCode+"')";
								//out.print(qry);
								rsChApr=db.getRowset(qry);
								if(rsChApr.next())
								{
									%>
									<input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' checked disabled>
									<%
								}
								else
								{
									%>
									<input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' disabled>
									<%
								}
								%>
								<select name='<%=mName10%>' id='<%=mName10%>' style="Width:40" disabled>
								<%
							}
							else
							{
								%>
								<input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>')">
								<select name='<%=mName10%>' id='<%=mName10%>' style="Width:40">
								<%
							}
							for (int m=1;m<=mTot;m++)
							{
								if(mochoice==m)
								{	
									%>
									<option selected Value=<%=m%>><%=m%>
									<%
								}
								else
								{
									%>
									<option Value=<%=m%>><%=m%>
									<%
								}
							}
							%>
							</select>
							</td>
							<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
							<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='<%=mSemType%>'>
							<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
							<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
							<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
							<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
							<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
							<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>
							</tr>
							<%
						}
						else
						{
							%>
						 	<tr bgcolor="<%=mColor%>">
							<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
							<td align=center><Font face=arial size=2>CURRENT</font></td>
							<td>&nbsp;</td>
							<!--<td align=center><Font face=arial size=2>ELECTIVE (<%=mElecCode%>)</font></td>-->
							<td align=left><Font face=arial size=2><%=mSubjName%></font></td>
							<td align=center><Font face=arial size=2><%=mCourseCrPt%></font></td>
							<td>
							<%
							qry="Select nvl(SUBJECTRUNNING,'N')SUBJECTRUNNING from pr#electiveSubjects WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND BASKET='B' AND nvl(SUBJECTRUNNING,'N')='Y'";
							qry=qry+" AND SUBJECTID IN (SELECT SUBJECTID FROM pr#studentsubjectchoice WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND CHOICE>0 AND SEMESTERTYPE='REG' AND STUDENTID='"+mChkMemID+"' AND SUBJECTTYPE='E' AND ELECTIVECODE='"+mElecCode+"')";
							rs=db.getRowset(qry);
							//out.print(qry);
							if(rs.next())
							{
								qry="Select nvl(SUBJECTRUNNING,'N')SUBJECTRUNNING from pr#electiveSubjects WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND BASKET='B' AND nvl(SUBJECTRUNNING,'N')='Y'";
								qry=qry+" AND SUBJECTID IN (SELECT SUBJECTID FROM pr#studentsubjectchoice WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"' AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND CHOICE>0 AND SEMESTERTYPE='REG' AND STUDENTID='"+mChkMemID+"' AND SUBJECTID='"+mSubjId+"' AND SUBJECTTYPE='E' AND ELECTIVECODE='"+mElecCode+"')";
								//out.print(qry);
								rsChApr=db.getRowset(qry);
								if(rsChApr.next())
								{
									%>
									<input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' checked disabled>
									<%
								}
								else
								{
									%>
									<input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' disabled>
									<%
								}
								%>
								<select name='<%=mName10%>' id='<%=mName10%>' style="Width:40" disabled>
								<%
							}
							else
							{
								%>
								<input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>')">
								<select name='<%=mName10%>' id='<%=mName10%>' style="Width:40">
								<%
							}
							for (int m=1;m<=mTot;m++)
							{
								if(mochoice==m)
								{	
									%>
									<option selected Value=<%=m%>><%=m%>
									<%
								}
								else
								{
									%>
									<option Value=<%=m%>><%=m%>
									<%
								}
							}
							%>	
							</select>
							<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
							<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='<%=mSemType%>'>
							<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
							<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
							<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
							<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
							<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
							<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>
							</td>
							</tr>
							<%
						} //closing of else 
					} // closing of while rs1
				} // closing of while rsc

//-----------------------------------------------------
//----------END OF ELECTIVE [WHERE BASKET='B']---------
//-----------------------------------------------------

				%>
				</tbody>
				<tr><td colspan=6 align=center>
				<input Type=Submit name=btn1 id=btn1 Value='&nbsp;Save&nbsp;'></td>
				<input Type=hidden id="TotalCCP" name="TotalCCP" value=<%=mMaxCrLmt%>>
				<input Type=hidden id="TotCrLmtTkn" name="TotCrLmtTkn" value=<%=mTotalCrLmtTkn%>>
				<input Type=hidden id="TotalCCPAld" name="TotalCCPAld" value=<%=mMaxCrLmtTkn%>>
				<input Type=hidden id="TotalRec" name="TotalRec" value=<%=mSno%>>
				<input Type=hidden id=PREVENTCODE name=PREVENTCODE value='<%=mPrcode%>'>
				</td></tr>
				</table>
				</td>
				</tr>			
				</form>
				</table>
				<marquee scrolldelay=100 behavior=alternate><font color=red><b>NOTE:-<br># Checked subject(s) appears to be within the permissible credit limit.</font></b><br>
				<font color=red># Once choices are sent to HOD, you can not enter or modify your choice.</font></marquee>
				<%
			} //closing of else
		   }
		   else
		   {
			%>
			<font color=red>
			<h3><br><img src='../../Images/Error1.jpg'>
			Pre- Registration / Subjects Choices have been already Finalized by HOD! <br>
			<%
		   }
  		}
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>		
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
		 <%
		}
	   }
	   else
	   {
		%>
		<font color=RED>
		<h3><br>Your Initial Pre Registration Choice(s) is under process.</FONT><Br><BR>
		<%
	   }
	   }
	   else
	   {
		%>
		<font color=Green>
		<h3><br>Your Choice(s) has been sent automatically by the system...</FONT><Br><BR>
		<%
	   }
	}	
	else
	{
	%>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
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
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
   <%
   }
	  //-----------------------------
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
}
%>
<center>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</Html>