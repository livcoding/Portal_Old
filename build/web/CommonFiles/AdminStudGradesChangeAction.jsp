<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Student Grade Card (Eventwise) ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
 
<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
' 
*************************************************************************************************
	' *												
	' * File Name:	AdminStudGradesChange.JSP		[For Admin]					
	' * Author:		Vijay Kumar
	' * Date:		3rd Aug 2007
	' * Version:	2.0							
	' * Description:	Grade Card of Students
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String qry1="", qry2="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="", mGFlag="";
String QryExam="", mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mSem="",mName="";
String mINSTITUTECODE="";
String mEmployeeID="";
String mSUBJECTCODE="", ABC="";
String mEName="",mSID="";
ResultSet rs=null,rs1=null,rs2=null,rss1=null;

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
if (session.getAttribute("InstituteCode")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
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

if (request.getParameter("SID")==null)
{
	mSID="";
}
else
{
	mSID=request.getParameter("SID").toString().trim();
}

try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('159','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		//out.println(e.getMessage());
	}


String mSnm="", mENo="";
String mProgr="",mBran="";
int mSem1=0;
int mFlag=0;
qry="select StudentName, Enrollmentno ,semester,programcode,branchcode from StudentMaster where StudentID='"+mSID+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mSnm=rs1.getString("StudentName");
mENo=rs1.getString("Enrollmentno");
mSem1=rs1.getInt("semester");	
mProgr=rs1.getString("programcode");
mBran=rs1.getString("branchcode");
}

	
%>
 
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Student Grade Modification Status </b></font></td></tr>
</table>
<BR>
<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td NOWRAP><font color=black face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="Vardana"><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</font>
&nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="Vardana"><%=mProgr%>(<%=mBran%>)</font>
&nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="Vardana"><%=mSem1%></font></td></tr>
</TABLE>
<%
int SNO=0,mTot=0;
String mObjName="",mBRKNO="",mFSTID="";
String mSBJID="",mOGrd="",mNGrd="";

if (request.getParameter("Tot")==null)
	 mTot=0;
 else
	mTot=Integer.parseInt(request.getParameter("Tot").toString().trim());


for (SNO=1;SNO<=mTot;SNO++)
{
 mObjName="SUBJ"+SNO;
 if (request.getParameter(mObjName)==null)
	 mSBJID="";
 else
	mSBJID=request.getParameter(mObjName).toString().trim();

 mObjName="OLDGRADE"+SNO;
 if (request.getParameter(mObjName)==null)
	 mOGrd="";
 else
	mOGrd=request.getParameter(mObjName).toString().trim();

 mObjName="NEWGRADE"+SNO;
 if (request.getParameter(mObjName)==null)
	 mNGrd="";
 else
	mNGrd=request.getParameter(mObjName).toString().trim();

 mObjName="FSTID"+SNO;
 if (request.getParameter(mObjName)==null)
	 mFSTID="";
 else
	mFSTID=request.getParameter(mObjName).toString().trim();

 mObjName="BRKNO"+SNO;
 if (request.getParameter(mObjName)==null)
	 mBRKNO="";
 else
	mBRKNO=request.getParameter(mObjName).toString().trim();
 
 if (!mNGrd.equals(mOGrd))
	{
	qry="Update STUDENTWISEGRADE Set FINALGRADE='"+mNGrd+"', ENTRYDATE=sysdate, ENTRYBY='"+mMemberID+"' Where FSTID='"+mFSTID+"' And BREAK#SLNO='"+mBRKNO+"' And STUDENTID='"+mSID+"'";
	int n=db.update(qry);
	mFlag+=n;
	  if (n>0)
	  {
		//---- Log Entry
	  	//-----------------
     	      db.saveTransLog(mINSTITUTECODE,mMemberID,mMemberType,"Grdae Changed" ,  " For FSTID:"+mFSTID +" SubjID:"+mSBJID+" StudID : "+mSID+ " Old "+mOGrd+" New:"+mNGrd , "No MAC Address" , mIPAddress);
		//-----------------
	  }
	}
 }
if (mFlag>0)
{
	%>
	<BR><BR><BR><BR><CENTER><font color=Green Size=4 face='Verdana'>Student Grade(s) changed successfully...</font></CENTER>
	<%
}
else
{
	%>
	<BR><BR><BR><BR></CENTER><font color=Red Size=4 face='Verdana'>Error while Grade change! </font></CENTER>
	<%
}
//-----------------------------
//-- Enable Security Page Level  
//-----------------------------
	}//3
  else
  {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br> 
   <%
	}
    		 //-----------------------------
}   //2
else
{
	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
}
%>
</body>
</html>