<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
ResultSet  rs=null,rs1=null,rs2=null;
String qry="",qry1="",qry2="";
String mStat="";
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
	mHead="JIIT";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Back Paper or Not Registered Subjects of Students) ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
 
<Html>
<head>
  
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
String mSemType="", mSubjType="", mSubjTypeDesc="", mSubjId="", mSubjName="", mBasket="",mInstCode="";
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

if (session.getAttribute("INSCODE")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("INSCODE").toString().trim();
}

try
{

if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	String mChkMemID=request.getParameter("SID").toString().trim();
	String mStatus="";
	ResultSet RsChk=null;

  	//-----------------------------
	//-- Enable Security Page Level  
	//-----------------------------

	if (1==1)
	{
		mComp=session.getAttribute("CompanyCode").toString().trim();
		//mInst=session.getAttribute("InstituteCode").toString().trim();
		mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
		qry=" Select SEMESTER from  STUDENTMASTER where StudentID='" +mChkMemID+ "' and InstituteCode='" + mInst + "'";
		//out.print(qry);
	      rs=db.getRowset(qry);
		if (rs.next())
		mSem=rs.getInt("SEMESTER");
		qry="Select distinct nvl(STUDENTID, ' ') STUDENTID, nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
		qry=qry+"   ACADEMICYEAR , StudentName, enrollmentno from ";
		qry=qry+" STUDENTMASTER where StudentID='" +mChkMemID+ "' and  InstituteCode='" + mInst + "'";
		//out.print(qry);
		rs=db.getRowset(qry);
		if (rs.next())
		{
			mSname=rs.getString("StudentName").trim();
			mSCode=rs.getString("enrollmentno").trim();
			mProg=rs.getString("PROGRAMCODE");
			mBranch=rs.getString("BRANCHCODE");
			mAcad=rs.getString("ACADEMICYEAR");		
		}
		

		qry="select EXAMCODEFORATTENDNACEENTRY ed from CompanyInstituteTagging where InstituteCode='" + mInst + "' and CompanyCode='" + mComp + "'";
		//out.print(qry);
		rs=db.getRowset(qry);
		if (rs.next())
		{
		  mExam=rs.getString("ed");
		}

		qry="Select distinct A.Semester Semester, A.SubjectID SubjectID, C.Subject||' ('||C.SubjectCode||')' Subj, 'Fail' Status From STUDENTRESULT A, SubjectMaster C ";
		qry=qry+" where A.institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"'  ";
		qry=qry+" and nvl(Fail,'N')='Y' AND NVL(GRADE,'N') <> 'X' And A.semester<"+(mSem)+" AND A.institutecode=C.institutecode and A.subjectID=C.subjectID";
		qry=qry+" UNION ";
		qry=qry+" Select distinct A.Semester Semester, A.SubjectID SubjectID, C.Subject||' ('||C.SubjectCode||')' Subj ,'NR on date' Status From NRSTUDENTFAILSUBJECTS A, SubjectMaster C ";
		qry=qry+" where A.institutecode='"+mInst +"' and nvl(a.REGISTERED,'N')='N' And A.studentid= '"+mChkMemID+"' ";
		qry=qry+" And A.semester< "+(mSem)+" AND A.institutecode=C.institutecode and A.subjectID=C.subjectID";
		qry=qry+" order by Semester,Subj";

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
		<td><font face=verdana size=2 color=white><b>Semester</b></font></td><td><font face=verdana size=2 color=white><b>Subject</b></font></td><td><font face=verdana size=2 color=white><b>Subject Type</b></font></td><td><font face=verdana size=2 color=white><b>Credit</b></font></td></td><td><font face=verdana size=2 color=white><b>Remarks</b></font></td><td><font face=verdana size=2 color=white><b>Current Status</b></font></td>
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
		mStat=rs.getString("Status");
		qry="Select distinct  B.COURSECREDITPOINT COURSECREDITPOINT,  BASKET from ProgramSubjectTagging B where ";
		qry=qry+" B.iNSTITUTEcODE='"+ mInst +"' AND b.PROGRAMCODE='"+mProg +"' and b.SECTIONBRANCH='"+mBranch+"' And b.academicyear='"+mAcad+"' aND B.subjectID='"+ mSubjID +"'";
		//out.print(qry);	
		rs1=db.getRowset(qry);
		if (rs1.next())
			{
				mCourseCrPt=rs1.getDouble("COURSECREDITPOINT");
				mBasket=rs1.getString("BASKET");
			}
		
		if(mBasket.equals("A"))
			mSubjTypeDesc="CORE";
		else if(mBasket.equals("E"))
			mSubjTypeDesc="ELECTIVE";					
				else if(mBasket.equals("D"))
					mSubjTypeDesc="ELECTIVE";					
					else if(mBasket.equals("B"))
						mSubjTypeDesc="ELECTIVE";					


		mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;

		qry="Select  SubjectID from ";
		qry=qry+" FacultySubjectTagging B ";
		qry=qry+" where B.institutecode='"+mInst +"' And B.ExamCode='"+mExam+"' ";
		qry=qry+" And B.subjectID='"+ mSubjID +"'";

	//	out.println(qry+"<br>");
		rs1=db.getRowset(qry);
		if(rs1.next())
		{
			qry2="Select distinct SubjectID from V#studentltpdetail B where B.institutecode='"+mInst+"' And B.ExamCode='"+mExam+"' and studentid='"+mChkMemID+"' and  nvl(DEACTIVE,'N')='N' and  nvl(STUDENTDEACTIVE,'N')='N' and B.subjectID='"+ mSubjID +"'";
			//out.println(qry);
			rs2=db.getRowset(qry2);
			if(rs2.next())
			{
			   mStatus="<font color=Green><b>Registered</b>";
			}
			else
			{
				mStatus="<font color=Red><b>Not Registered</b>";
			}
		}
		else
		{
			mStatus="<font color=Red><b>Not Offered</b>";
	}
	%>
	<tr><td><font size=2 face='verdana'><%=mSemester%></font></td>					
	<td><font size=2 face='verdana'><%=mSubjName%></font></td>
	<td><font size=2 face='verdana'><%=mSubjTypeDesc%></font></td>
	<td><font size=2 face='verdana'><%=mCourseCrPt%></font></td>
	<td><font size=2 face='verdana'><%=mStat%></font></td>
	<td><font size=2 face='verdana'><%=mStatus%></font></td>
	</tr>
	<%
	}
	%>
	<tr><td colspan=3 align=right><b>Total Course Credit:</b> </td><td><b><%=mTotalCrLmtTkn%></b></td><td>&nbsp;</td><td>&nbsp;</td></tr>
     </table> 
	<br>	<br>	<br>
	<A href="StudAdminOption.jsp?INSCODE=<%=mInst%>&amp;SID=<%=mChkMemID%>"><font color=red size=2 face='verdana'><b>Click to View Webkiosk</b></font></A>
	<%			
	}
	else
	{
	String URL="StudAdminOption.jsp?SID="+mChkMemID;
	response.sendRedirect(URL);
	}
%>

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
	 		out.print(qry);

}
%>
</body>
</Html>