<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
ResultSet  rs=null,rs1=null,rss1=null,rsc=null,rse=null,rse1=null,rsso=null;
String qry="",qry1="";
String mDID="",mProg="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
double mMinCrLmt=0, mMaxCrLmt=0, mMinCrLmtTkn=0, mMaxCrLmtTkn=0, mMaxCrLmtAld=0, mCourseCrPt=0, mTotalCrLmtTkn=0;
String mSect="",	mSubSect="", mTag="",mElective="",mSCode="";
String mExam="", mFailGraders="F", mPrcode="";
String mName1="", mName2="",mName3="", mName4="", mName5="", mName6="", mName7="", mName8="", mName9="", mName10="";
int mochoice=0, mochoice1=0,Count=0,chk=0,m=1;

/*
*************************************************************************************************
	' *												
	' * File Name:	PRStudentEntry.jsp		[For Students]					
	' * Author:		Vijay Kumar
	' * Date:		07th Oct 2008
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
<head>
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
String mCol2="#F8F8F8";
OLTEncryption enc=new OLTEncryption();
mSname=session.getAttribute("MemberName").toString().trim();
mSCode=enc.decode(session.getAttribute("MemberCode").toString().trim());

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

if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	String mStatus="";
	ResultSet RsChk=null;
  	//-----------------------------
	//-- Enable Security Page Level  
	//-----------------------------
	qry="Select WEBKIOSK.ShowLink('52','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
	



qry=" Select SEMESTER from  STUDENTREGISTRATION where StudentID='" +mDID+ "' and examcode='"+mExam+"' and  InstituteCode='" + mInst + "' And nvl(regallow,'N')='Y'";
//out.print(qry);
rs=db.getRowset(qry);
if (rs.next())
	mSem=rs.getInt("SEMESTER");

qry="Select distinct nvl(STUDENTID, ' ') STUDENTID, nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
qry=qry+"   ACADEMICYEAR from ";
qry=qry+" STUDENTMASTER where StudentID='" +mChkMemID+ "' and  InstituteCode='" + mInst + "'";

	rs=db.getRowset(qry);
	if (rs.next())
	{
		mSname=session.getAttribute("MemberName").toString().trim();
		mSCode=enc.decode(session.getAttribute("MemberCode").toString().trim());
		mProg=rs.getString("PROGRAMCODE");
		mBranch=rs.getString("BRANCHCODE");
		mAcad=rs.getString("ACADEMICYEAR");		
	}
		

qry="Select distinct A.Semester Semester, decode(nvl(COURSETYPE,'C'),'C','A','B') BASKET, A.SubjectID SubjectID, C.Subject||' ('||C.SubjectCode||')' Subj, B.COURSECREDITPOINT COURSECREDITPOINT From STUDENTRESULT A, ProgramSubjectTagging B, SubjectMaster C ";
qry=qry+" where A.semester=b.semester and A.institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"' And  A.InstituteCode=B.InstituteCode And ";
qry=qry+" b.PROGRAMCODE='"+mProg +"' And b.academicyear='"+mAcad+"'";
qry=qry+" and A.grade='"+mFailGraders+"' And A.semester< "+(mSem-1)+" AND A.institutecode=C.institutecode and A.subjectID=B.subjectID And A.subjectID=C.subjectID";
qry=qry+" order by Basket , Subj";

//out.print(qry);
rs=db.getRowset(qry);
if (rs.next())
{
%>
<center>
				<font color=darkbrown size=4><b>List of total Back Log/Fail Subjects</font></B>
</center>				
				<br>

<FONT face=Arial size=2 color=black><STRONG>Student Name - </STRONG></FONT><%=GlobalFunctions.toTtitleCase(mSname)%> (<%=mSCode%>)
<br>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
<tr bgcolor=darkblue>
<td><font color=white><b>Semester</b></font></td><td><font color=white><b>Subject</b></font></td><td><font color=white><b>Subject Type</b></font></td><td><font color=white><b>Credit</b></font></td></td><td><font color=white><b>Present Status</b></font></td>
</tr>
<%

//out.print(qry);
String mSubjID="";

				rs=db.getRowset(qry);
				while(rs.next())
				{
					mSno++;
					mColor="#FF6464";
					mSemester=rs.getInt("Semester");
					mSubjName=rs.getString("Subj");
					mSubjID=rs.getString("SubjectID");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					mBasket=rs.getString("BASKET");
					 
					mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;
					if(mBasket.equals("A"))
						mSubjTypeDesc="CORE";
					else if(mBasket.equals("E"))
						mSubjTypeDesc="ELECTIVE";					

						
						
						
				qry="Select  SubjectID from ( ";
				qry=qry+" (Select B.SubjectID  From ProgramSubjectTagging B ";
				qry=qry+" where B.institutecode='"+mInst +"' And B.ExamCode='"+mExam+"' ";
				qry=qry+" And B.semester< "+(mSem-1)+" and B.subjectID='"+ mSubjID +"')";
				qry=qry+" union ";
				qry=qry+" (select A.SUBJECTID from PR#ELECTIVESUBJECTS A";
				qry=qry+"  where A.institutecode='"+mInst+"' And A.ExamCode='"+mExam+"' And A.SubjectID='"+mSubjID+"'";
				qry=qry+"  and A.semester<"+(mSem-1)+" ) ";						
				qry=qry+"  union ";
				qry=qry+" (select A.SUBJECTID From OFFERSUBJECTTAGGING A";
				qry=qry+"  where A.institutecode='"+mInst+"' And A.ExamCode='"+mExam+"' ";
				qry=qry+"  and A.subjectID='"+ mSubjID +"'))";					 
				//out.println(qry);
				rs1=db.getRowset(qry);
				if(rs1.next())
				{
					mStatus="<font color=Green><b>Offered Now</b>";
				}
				else
				{
					mStatus="<font color=Red><b>Not Offered</b>";
				}



						
					%>
						<tr><td><%=mSemester%></td>					
						<td><Font face=arial><%=mSubjName%></font></td>
						<td><Font face=arial><%=mSubjTypeDesc%></font></td>
						<td><Font face=arial><%=mCourseCrPt%></font></td>
						<td><%=mStatus%></td>
					</tr>
			<%
			}
			%>
				</table> 
				 
				
			<%
			
	}
	else
	{
	%>
	 

 

	<%
	}
%>
<font color=Green face=verdana Size=4><b><a href='PRStudentEntry.jsp'>Click to proceed Registration Process</a></b></font>	
<div class=Section1>

<b><u><span style="mso-bidi-font-size: 10.0pt">General<o:p></o:p></span></u></b>

<p class=MsoNormal style="MARGIN:

 6pt 0in 0pt 0.5in; TEXT-INDENT: -0.5in; TEXT-ALIGN: justify; mso-list: l0 level1 lfo1; tab-stops: list .5in .75in"><![if !supportLists]><span
 style ="mso-bidi-font-size: 10.0pt; mso-bidi-font-family: 'Times New Roman'"><span
 style="mso-list: Ignore">1.<span style="FONT: 7pt 'Times New Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style="mso-bidi-font-size: 10.0pt">Pre-registration
shall be carried out for the students as follows:-<o:p></o:p></span></p>

<p class=MsoNormal style="MARGIN:

 3pt 0in 0pt 1in; TEXT-INDENT: -0.5in; TEXT-ALIGN: justify; mso-list: l1 level1 lfo2; tab-stops: list 1.0in"><![if !supportLists]><span
 style ="mso-bidi-font-size: 10.0pt; mso-bidi-font-family: 'Times New Roman'"><span
 style="mso-list: Ignore">(a)<span style="FONT: 7pt 'Times New Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style="mso-bidi-font-size: 10.0pt">Students
of all <span class=SpellE>programmes</span> /semesters who have backlog in core
courses which are on offer.<o:p></o:p></span></p>

<p class=MsoNormal style="MARGIN:

 3pt 0in 0pt 1in; TEXT-INDENT: -0.5in; TEXT-ALIGN: justify; mso-list: l1 level1 lfo2; tab-stops: list 1.0in"><![if !supportLists]><span
 style ="mso-bidi-font-size: 10.0pt; mso-bidi-font-family: 'Times New Roman'"><span
 style="mso-list: Ignore">(b)<span style="FONT: 7pt 'Times New Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style="mso-bidi-font-size: 10.0pt">Students
who have to exercise the choice of elective courses.<o:p></o:p></span></p>

<p class=MsoNormal style="MARGIN:

 12pt 0in 0pt 0.5in; TEXT-INDENT: -0.5in; TEXT-ALIGN: justify; mso-list: l0 level1 lfo1; tab-stops: list .5in .75in"><![if !supportLists]><span
 style ="mso-bidi-font-size: 10.0pt; mso-bidi-font-family: 'Times New Roman'"><span
 style="mso-list: Ignore">2.<span style="FONT: 7pt 'Times New Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style="mso-bidi-font-size: 10.0pt">Therefore,
any student who do not have a backlog in core courses as also who do not have
to exercise the choice of elective (e.g. students of <span class=SpellE>B.Tech</span>-
2<sup>nd</sup>, 4<sup>th</sup> &amp; 6<sup>th</sup> <span class=SpellE>Sem</span>)
need not pre register themselves as their registration shall automatically be
done in the system and displayed to each one of them at appropriate time (to be
notified).<o:p></o:p></span></p>

<p class=MsoNormal style="MARGIN:

 12pt 0in 0pt 0.5in; TEXT-INDENT: -0.5in; TEXT-ALIGN: justify; mso-list: l0 level1 lfo1; tab-stops: list .5in .75in"><![if !supportLists]><span
 style ="mso-bidi-font-size: 10.0pt; mso-bidi-font-family: 'Times New Roman'"><span
 style="mso-list: Ignore">3.<span style="FONT: 7pt 'Times New Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style="mso-bidi-font-size: 10.0pt">The
pre-registration shall be done through the webkiosk. The system shall allow the
student to proceed with pre-registration in following priority only:<o:p></o:p></span><br>

<p>Only upto the authorized credit limit i.e. 31. In case
    of any problem student should contact counselor/HOD
  <br>(a)Priority-1 – Backlog core papers on offer.
<br>(b) Priority-2 – Current core papers on offer.<br>
(c)Priority-3
– compulsory electives e.g. PD <o:p></o:p></span></br>
&nbsp;courses of 8<sup>th</sup> semester.<br>
(d)Priority-4
– other electives on offer.<o:p></o:p></span></p>

<p class=MsoNormal style="MARGIN:

 12pt 0in 0pt 0.5in; TEXT-INDENT: -0.5in; TEXT-ALIGN: justify; mso-list: l0 level1 lfo1; tab-stops: list .5in .75in"><![if !supportLists]><span
 style ="mso-bidi-font-size: 10.0pt; mso-bidi-font-family: 'Times New Roman'"><span
 style="mso-list: Ignore">4.<span style="FONT: 7pt 'Times New Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style="mso-bidi-font-size: 10.0pt">The
pre-registration shall be carried out from May 08, 2009 till May 10,
2009 after which the kiosk window shall automatically close and hence
pre-registration facility thereafter shall not be available to the students.<o:p></o:p></span></p>

<p align=left><font color=red face=verdana size=2><B><U>NOTE :</U> <br>

1. For Pre registration related problem contact to Registrar Office / JILIT Support Team  <br>
2. For Subject related issues contact to your Counselor/HOD 
</font></B>
</p>

</div>	
	
	
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
	out.print(e);
}
%>
</body>
</Html>