<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.lang.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%  

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rsi=null,rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String  qry1="",qry2="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="",mInst="",mDMemberCode="",mWebEmail="";

ResultSet  StudentRecordSet=null; 	  
String qry="";
String mName ="";
String mEnrollment="";
String mInstituteCode="",mInstName="";
String mSID="";
String mSname="";
String mProg="";
String mBranch="",mLoginComp="";
long  FeeAmt=0;
String mSem="",mObjName="",mexamcode="",QryExam="",mPrevExmCode="",mComp="",Quota="",mAcad="";
String qrydebar="";
ResultSet  rsdebar=null;
int mSems=0;
int mFlag=0;	

if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}
	
if (session.getAttribute("MemberID")==null)
	{
		mMemberID="";
	}
	else
	{
		mMemberID=session.getAttribute("MemberID").toString().trim();
	}
	if (session.getAttribute("InstituteCode")==null )
	{
		mInst="";
	}
	else
	{
	   mInst=session.getAttribute("InstituteCode").toString().trim();
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


if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}



if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}




//out.print(mComp+"iksdfklsf");

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE> <%=mHead%> [Summer Semester Registration Form]</TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>



</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 background="../../Images/Speciman.jpg">
<%
if(!mAcad.equals("0910"))
{

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
qry="Select WEBKIOSK.ShowLink('271','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

%>
<p align=center>
<font size=4 face=verdana><U>Announcing Summer Semester –June-July 2012</U>
</p>
<p><font size=2 face=verdana> <strong>Courses will be done at Sector-62 only</strong></font></p>
<p><font size=2 face=verdana><strong> Those who wish to apply for hostel must 
  contact Chief Admin. Manager and Register yourself for the hostel. Hostel fee 
  shall be Rs. 6000/-.</strong></font> </p>
<p>
<font size=2 face=verdana> <U><b>Parameters</b></U> 
<OL>
  <LI> <font size="2" face="Verdana, Arial, Helvetica, sans-serif">Duration 
   &nbsp;    &nbsp;   &nbsp;   &nbsp;    &nbsp;   &nbsp; - 11 June to 13 July <br>
    Summer Term T-1 - 23-25 June 2012<br>
    Summer Term T-2 - 11-13 July 2012 </font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> Last date - 
    10 June, 2012 </font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> Exams &amp; 
    Marks - T1 (30) , T2 (40) , Teacher&#8217;s Assess (30)</font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> Number of credits 
    allowed to be registered - 12 (maximum)</font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> Amongst the 
    projects only one project (whether minor or major) can be registered. When 
    a student registers for the project course he/she is entitled to register 
    for additional courses as follows:<br>
    (a) Along with Minor project &#8211; One theory or two lab subjects of 1 credit 
    each or one lab subject of 2 credits.<br>
    (b) Along with Major project &#8211; One lab subject.</font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> Student failed 
    or debarred from appearing in T3 exam in Even Semester ,will be eligible to 
    opt for summer semester 2012 courses</font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> Those students 
    who wish to improve Grades (Separate Instructions/Guidelines for same are 
    being issued) shall also be allowed to register for the Summer Semester courses.</font>
  <LI> <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Restriction 
    </strong>- students of 3rd year who have to undergo industrial training are 
    not allowed to register for the summer semester.</font>
  <LI> <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Subjects 
    to be offered - As per List Put up </strong></font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong> Time 
    table  &nbsp;&nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp; - As Put up on Notice Board</strong></font>
  <LI> <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Students 
    can select subjects which are on offer and after studying the time table. 
    No subjects should be registered where time table is clashing.</strong></font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> Attendance 
    for registered students is mandatory. Attendance rules shall apply. </font><font face="Verdana, Arial, Helvetica, sans-serif">
    <p><font size="2"><br>
      <strong><U>Fee structure</U></strong> <br>
      1. Theory courses / projects - Rs. 6000/- per course/project<br>
      2. Lab courses (one credit) - Rs. 4000/- per course<br>
      3. Lab courses (two credits) - Rs. 5000/- per course</font></p>
    </font> 
    <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><br>
      <strong>(Registrar)</strong><br>
      </font><font face="Verdana, Arial, Helvetica, sans-serif"> </font> </p>
    <br>
</OL>
</p>
<p>
	<font color="RED" face=verdana Size=5><b><a href='SummerSupEmp.jsp'>>>Click to proceed with Summer Semester</a></b></font>
</p>

<%



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
	}   //2
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}	//1	
catch(Exception e)
{
}
}
%>
  </body>
</html>
