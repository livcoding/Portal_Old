<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
ResultSet  rs=null,rs1=null,rss1=null,rsc=null,rse=null;
String qry="";
String mDID="",mProg="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
int mSem=0;
String mSect="",	mSubSect="", mTag="",mElective="";
String mExam="";
String mName1="";
String mName2="",mName4="",meid="",mEl="",mCh="";
String mName3="";
String mName5="";
String msubject="",mSubject="";
String msubject1="",mSubject1="",mMS="",mChoice="";
String mSemes="",mSemType="",mSubjectType="",mMemberType="",mMemberID="";
long mSemester=0;
int msno=0;	
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
/*
	' 
*************************************************************************************************
	' *												
	' * File Name:	PRStudentEntryBackPaper.JSP		[For Students]					
	' * Author:		Rituraj Tyagi
	' * Date:		03-Apr-2007								
	' * Version:		1.0								
	' * Description:	Pre Registration of Students (Back Papers)
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
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<Html>
<head>
<title></title>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>


<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
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
String mSEMESTER  ="";
String mSname="";
String mCOURSENAME ="";
String mBranch="",mAcad="";
String mInst="",mWebEmail="";
try{
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
		if (session.getAttribute("InstituteCode")==null || session.getAttribute("InstituteCode").toString().equals(""))
		   mInst="";
		else
		if (session.getAttribute("WebAdminEmail")==null)
		{
		 mWebEmail="";
		}	 
		else
		{
		mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
	      }
	mInst=session.getAttribute("InstituteCode").toString().trim();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());


//-------------------------------------
//----- For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();

if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------

if (request.getParameter("mSc")==null)
{
	mSubject="";
}
else
{
	mSubject=request.getParameter("mSc").toString().trim();
}

if (request.getParameter("mEc")==null)
{
	mExam="";
}
else
{
	mExam=request.getParameter("mEc").toString().trim();
}

if (request.getParameter("mAca")==null)
{
	mAcad="";
}
else
{
	mAcad=request.getParameter("mAca").toString().trim();
}
if (request.getParameter("mCh")==null)
{
	mChoice="";
}
else
{
	mChoice=request.getParameter("mCh").toString().trim();
}

qry="delete from PR#STUDENTSUBJECTCHOICE where institutecode='"+mInst+"' and academicyear='"+mAcad+"'";
qry=qry+" and Examcode='"+mExam+"' and SubjectID='"+mSubject+"' and semestertype='RWJ' ";
qry=qry+" and studentid='"+mDID+"' and choice='"+mChoice+"' ";	
int n=db.update(qry);

  db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"DELETE REGISTRATION FOR BACKPAPER", "ExamCode: "+mExam+"Academic year :"+ mAcad+"Subject :"+mSubject, "NO MAC Address" , mIPAddress);
 //response.sendRedirect("PRStudentEntryBackPaper.jsp?TestCode="+mTC+"&amp;institutecode="+mInst);
 response.sendRedirect("PRStudentEntryBackPaper.jsp");




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
			 //out.print(qry);
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