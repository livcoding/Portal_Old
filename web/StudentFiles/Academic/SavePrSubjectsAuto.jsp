<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%@page contentType="text/html"%>

<%
ResultSet  rs=null,rs1=null,rss1=null,rsc=null,rse=null,rse1=null,rsso=null,rsexam=null;
String qry="",qry1="";
String mDID="",mProg="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
double mMinCrLmt=0, mMaxCrLmt=0, mMinCrLmtTkn=0, mMaxCrLmtTkn=0, mMaxCrLmtAld=0, mCourseCrPt=0, mTotalCrLmtTkn=0;
String mSect="",	mSubSect="", mTag="",mElective="",mSCode="";
String mExam="", mFailGraders="F", mPrcode="";
String mName1="", mName2="",mName3="", mName4="", mName5="", mName6="", mName7="", mName8="", mName9="", mName10="";
int mochoice=0, mochoice1=0,Count=0,chk=0,m=1;
int CourseCrPtBasketD=1;
double mMinBasketD=0,mMaxBasketD=0;
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
		response.setContentType("application/msword");
		mInst=request.getParameter("instituteCode");
		mDID=request.getParameter("studentID");
		mExam=request.getParameter("examcode");
		mAcad=request.getParameter("academicyear");
		mySect=request.getParameter("secbranch");
		mProg=request.getParameter("programcode");
		mTag=request.getParameter("tag");
		mSem=Integer.parseInt(request.getParameter("semester"));

		String mExamDesc="";
		qry="SELECT EXAMDESCRIPTION FROM EXAMMASTER where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"' ";
		rsexam=db.getRowset(qry);
			if(rsexam.next())
		   {
				mExamDesc=rsexam.getString("EXAMDESCRIPTION");
		   }

		%>
		<br>
		<font face=verdana color='darkbrown' size=4><b><%=mExamDesc%></b></font>
	
		<table border=0 width ="100%" align="center">
		<tr>
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
			<B>Semester:</B> <%=sc%>
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
		%>
		</tr>
		</table>
		
		<font color=Green>
		<h3><br>You have automatically been registered for following</FONT>
		
		<Br><br>
			<table border=1 width ="100%" align="center">
			<tr bgcolor="#ff8c00" >
			<td><font color=White size=3><b>Sno</b></font></td><td><b><font size=3 color=White>Subject(Subject Code)</b></font></td><td><b><font size=3 color=White>Credit</b></font></td></tr>
		<%
				double sumcrt=0;
				qry="Select  B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'A')BASKET from PROGRAMSCHEME A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst +"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
				qry=qry+" and A.semester="+mSem+" AND A.BASKET='A' AND A.institutecode=B.institutecode and A.subjectID=B.subjectID  order by Subject";
				//out.print(qry);
				int mysno=0;	
				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					mysno++;
					mSubjName=rs.getString("Subject");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					%>

					<tr><td><%=mysno%>.</td>
					<td><%=mSubjName%></td>
					<%
						sumcrt=sumcrt+mCourseCrPt;
						%>
					<td><%=mCourseCrPt%></td>
					</tr>
					<%
			
				}
			%>
			<tr><td colspan=3 align=right ><Font color=green  size=4><B>Total Course Credit Point Taken By You : <%=sumcrt%><b></font></td></tr>
					</tr>
		</table>
		<br>
		<center><INPUT TYPE="button" name="Print" Value="Click to Print"  onClick="window.print();"></center>
		
		<BR>
		</form>
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