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
String mBranch="";
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

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
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

if (session.getAttribute("AcademicYearCode")==null)
{
	mAcad="";
}
else
{
	mAcad=session.getAttribute("AcademicYearCode").toString().trim();
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
qry="Select WEBKIOSK.ShowLink('270','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

%>
<p align=center>
<font size=4 face=verdana><U>Special Summer Semester for JBS – April 2016 </U>
</p>
<p><font size=2 face=verdana> <strong>Courses will be done at JBS only</strong></font></p>
<!-- <p><font size=2 face=verdana><strong> Those who wish to apply for hostel must 
  contact Chief Admin. Manager and Register yourself for the hostel. Hostel fee 
  shall be Rs. 6000/-.</strong></font> </p> -->
<p>
<font size=2 face=verdana> <U><b>Parameters</b></U> 
<OL>
  <LI> <font size="2" face="Verdana, Arial, Helvetica, sans-serif">	Duration – 01 April 2016 to 16 April 2016
<br>
   Spl Summer Term Mid Term Test – 9th April 2016
<br>
  Spl Summer Term End Term Test – 16th April 2016 </font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> Last date for Registration – 04 Apr 2016 </font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Exams & Marks – Mid Term (30) , End Term (40) , Teacher’s Assess (30)</font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Number of credits allowed to be registered - 6 (maximum) </font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Student failed or debarred from appearing in End Term Test in 6th Term ,will be eligible to opt for Spl Summer semester 2016 courses  </font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Restriction</b> - students of 1st year are not allowed to register for the summer semester.  </font>
  <LI><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong> Subjects to be offered - As per List on the Webkiosk</strong></font>
  <LI> <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Time table - As announced by JBS..</strong></font>
  <LI> <font size="2" face="Verdana, Arial, Helvetica, sans-serif">Attendance for registered students is mandatory. Attendance rules shall apply.  </font>

    <p><font size="2"><br>
      <strong><U>Fee structure</U></strong> <br>
			1. Rs. 6000/- per Course..</font></p>

    </font> 
    <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><br>
      <strong>(Registrar)</strong><br>
      </font><font face="Verdana, Arial, Helvetica, sans-serif"> </font> </p>
    <br>
</OL>
</p>
<p>
	<font color="RED" face=verdana Size=5><b><a href='SummerSupJPBS.jsp'>>>Click to proceed with Summer Semester</a></b></font>
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
