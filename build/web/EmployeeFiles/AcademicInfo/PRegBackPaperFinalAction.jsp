<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Back Log Paper Approval/Finalization by DOAA ] </TITLE>

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
//-->
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String x="",mySect="",mfactype="";
int mTotal=0;
int n=0,n1=0;
int mFlag=0;
int mRecFlag=0;
int LockFlag=0;
String mName1="",mName2="",mName3="",mName4="",mName5="";
String mELECTIVECODE="";
String mSubj="", mSid="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="", CurrDate="";
String mECode="",mChk="",mLockBackLog="";
String mSType="",mWebEmail="";

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";
rs=db.getRowset(qry);
if(rs.next())
  CurrDate=rs.getString(1);
else
  CurrDate="";	

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

if (request.getParameter("TotalCount")==null)
{
	mTotal=0;
}
else
{
	mTotal=Integer.parseInt(request.getParameter("TotalCount").toString().trim());
}

if (request.getParameter("InstCode")==null)
{
	mInst="";
}
else
{
	mInst=request.getParameter("InstCode").toString().trim();
}
if (request.getParameter("ExamCode")==null)
{
	mECode="";
}
else
{
	mECode=request.getParameter("ExamCode").toString().trim();
}

if (request.getParameter("SubjectType")==null)
{
	mSType="";
}
else
{
	mSType=request.getParameter("SubjectType").toString().trim();
}

if (request.getParameter("ChkBackLog")==null)
{
	mLockBackLog="";
}
else
{
	mLockBackLog=request.getParameter("ChkBackLog").toString().trim();
}
%>

<br>
	<center><font size=4 face=Verdana color=green>Back Log Subject Approval Detail</font>
	<hr>
	<%
/*	String mtyp="";
	if(mSType.equals("C")) mtyp="Core Subjects";
	if(mSType.equals("F")) mtyp="Free Elective Subjects";
	if(mSType.equals("E")) mtyp="Elective Subjects";
	%>
	<font size=3 face='Verdana'><b>Subject Type : <%=mtyp%></b></font></center>
<%
*/
%>
	<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
	<tr bgcolor="#ff8c00">
	<td><b><font color=white>Subject</font></b></td>
	<td><b><font color=white>Approval Status</font></b></td>
	</tr>
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
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('112','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
		if (request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
		{  

			if(mDMemberType.equals("E"))
			{
			 mfactype="I";	
			}
			else if(mDMemberType.equals("V"))
			{
			 mfactype="E";
			} 

			// For Log Entry Purpose
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

			for (int i=1;i<=mTotal;i++)
			{
				mRecFlag=0;
				mName1="checked_"+String.valueOf(i).trim();
				mName2="Subject_"+String.valueOf(i).trim();
				mName3="Elective_"+String.valueOf(i).trim();
				mName4="SubjectType_"+String.valueOf(i).trim();
				mName5="SID_"+String.valueOf(i).trim();
				
				if(request.getParameter(mName1)!=null)
					mChk=request.getParameter(mName1);
				else
					mChk="";
				if (request.getParameter(mName2)!=null)
					mSubj=request.getParameter(mName2);
				else
					mSubj="";
				if (request.getParameter(mName3)!=null)
					mELECTIVECODE=request.getParameter(mName3);
				else
					mELECTIVECODE="";
				if (request.getParameter(mName4)!=null)
					mSType=request.getParameter(mName4);
				else
					mSType="";
				if (request.getParameter(mName5)!=null)
					mSid=request.getParameter(mName5);
				else
					mSid="";
				
				if(mSType.equals("Core"))
					mSType="C";
				else if(mSType.equals("Elective"))
					mSType="E";
				else if(mSType.equals("Free Elective"))
					mSType="F";
				else
					mSType="";
			//-------------
			//--Update here
			//-------------
				if(mChk.equals("Y") && !mSubj.equals(""))
				{
					qry="UPDATE PR#STUDENTSUBJECTCHOICE SET SUBJECTRUNNING='Y'";
					qry=qry+" WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mECode+"' AND SEMESTERTYPE='RWJ' AND SUBJECTID='"+mSid+"'";
					qry=qry+" AND SUBJECTTYPE='"+mSType+"' AND nvl(ELECTIVECODE,' ')='"+mELECTIVECODE+"' AND NVL(DEACTIVE,'N')='N'";

					n=db.update(qry);
					//out.print(qry);
					if(n>0)
					{
						mFlag=5;
						mRecFlag=mFlag;
					// Log Entry
					//-----------------
					      db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG BACK LOG SUBJECT APPROVAL", "ExamCode:"+mECode +" Subject:"+ mSubj, "NO MAC Address" , mIPAddress);
					//-----------------
					}
				mFlag=0;
				}
				else if(!mChk.equals("Y") && !mSubj.equals(""))
				{
					qry="UPDATE PR#STUDENTSUBJECTCHOICE SET SUBJECTRUNNING='N'";
					qry=qry+" WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mECode+"' AND SEMESTERTYPE='RWJ' AND SUBJECTID='"+mSid+"'";
					qry=qry+" AND SUBJECTTYPE='"+mSType+"' AND nvl(ELECTIVECODE,' ')='"+mELECTIVECODE+"' AND NVL(DEACTIVE,'N')='N'";

					n=db.update(qry);
					//out.print(qry);
					if(n>0)
					{
						mFlag=6;
						mRecFlag=mFlag;
					// Log Entry
					//-----------------
					      db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG BACK LOG SUBJECT DEAPPROVAL", "ExamCode:"+mECode +" Subject:"+ mSubj, "NO MAC Address" , mIPAddress);
					//-----------------
					}
				mFlag=0;
				}
			}
			if(mLockBackLog.equals("Y"))
			{
				qry="UPDATE PREVENTMASTER SET BACKLOGSUBJECTFINALIZED='Y'";
				qry=qry+" WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mECode+"'";
				//out.print(qry);
				n1=db.update(qry);
			}
			if(n1>0)
			{
				// Log Entry
				//-----------------
			      db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"LOCK PRE-REG BACK LOG SUBJECT APPROVAL", "Lock BackLog:"+ mLockBackLog, "NO MAC Address" , mIPAddress);
				//-----------------
				LockFlag=1;
			}
//-------------------------------------------------------
//------------------------------------------------
			if(mRecFlag==5)
			{
				%><BR><%
				out.print("<center> <b><font size=2 face='Arial' color='Green'> Back Log Paper(s) are approved successfully...</font> </center><br>");
			}
			else if(mRecFlag==6)
			{
				%><BR><%
				out.print("<center><b><font size=2 face='Arial' color='Green'> Back Log Paper(s) are approved successfully...</font></center> <br>");
			}	
//------------------------------------------------
//-------------------------------------------------------
//-----------------------------
			if(mRecFlag==0)
			{
				%><BR><%out.print("<img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'>Either No Record selected or Error while approving/unapproving...</font> <br>");
			}
				qry="select DISTINCT nvl(A.SUBJECTID,' ')SID, nvl(B.SUBJECTCODE,' ')SC, decode(A.SUBJECTRUNNING,'Y','Approved','Not Approved') SRUN, ";
				qry=qry+" nvl(B.SUBJECT,' ')SUBJ from PR#STUDENTSUBJECTCHOICE A, SUBJECTMASTER B ";
				qry=qry+" where A.INSTITUTECODE='"+mInst+"' AND A.SUBJECTID=B.SUBJECTID ";
				qry=qry+" and A.EXAMCODE='"+mECode+"' and A.SEMESTERTYPE='RWJ' and A.SUBJECTTYPE='"+mSType+"' and nvl(A.DEACTIVE,'N')='N'";
				qry=qry+" GROUP BY A.SUBJECTID, B.SUBJECTCODE, A.SUBJECTRUNNING, B.SUBJECT ORDER BY SUBJ";
				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					%>
					<tr>
					<td align=left><%=rs.getString("SUBJ")%> (<%=rs.getString("SC")%>)</td>
					<%
					if(rs.getString("SRUN").equals("Approved"))
					{
						%>
						<td align=center><font color=green><%=rs.getString("SRUN")%></font></td>
						<%
					}
					else
					{
						%>
						<td align=center><font color=red><%=rs.getString("SRUN")%></font></td>
						<%
					}
					%>				
					</tr>
					<%
				}

//-----------------------------
//-- Enable Security Page Level
//-----------------------------
			%>
			</table>
			<%
				response.sendRedirect("PRRegBackPaperFinalDOAA.jsp");
			}
			if(LockFlag==1)
			{
				%>
				<font size=2 color=green># Back Logger's Approval has been Freezed. Now you cann't change any approval entry.</font><br>
				<font size=2 color=green># Now the respective students can see their approval status.</font>
				<%
				response.sendRedirect("PRRegBackPaperFinalDOAA.jsp");
			}
			else
			{
			%>
			<table width=100%><tr><td>
			<font size=2 color=green># You are recommended to approve all backloggers including Core, Elective and Free Elective prior to Freeze the approval. Once you mark to 'Yes', you cann't change that entry!</font>
			</td></tr></table>
			<%
			}
		}
		else
   		{
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br><br><br>
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
 
}
%><br><br><br><br>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>