<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="";
int ctr=0,n=0,ChkFlag=0;
int mTotal=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="", mInst="";
String mEID="",mLeaveCode="",mDate1="",mDate2="", mPurposeOfLeave="";
String mAprStat="";
int mAprFlag=0,mFlag=0,mRecFlag=0;
String mEid="",mLeavecode="",mLeaveDesc="",mDateFr="",mDateTo="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="";
String mChk="", mSTAFF="", mLCODE="", mSDATE="", mEDATE="", mSHDAY="", mEHDAY="";
String mWebEmail="";

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

if (request.getParameter("InstCode")==null)
{
	mInstitute="";
}
else
{	
	mInstitute=request.getParameter("InstCode").toString().trim();
}

if (request.getParameter("TotalCount")==null)
{
	mTotal=0;
}
else
{
	mTotal=Integer.parseInt(request.getParameter("TotalCount").toString().trim());
}

if (request.getParameter("EID")==null)
{
	mEID="";
}
else
{	
	mEID=request.getParameter("EID").toString().trim();
}

if (request.getParameter("LEAVECODE")==null)
{
	mLeaveCode="";
}
else
{	
	mLeaveCode=request.getParameter("LEAVECODE").toString().trim();
}

if (request.getParameter("DATEFROM")==null)
{
	mDate1="";
}
else
{	
	mDate1=request.getParameter("DATEFROM").toString().trim();
}

if (request.getParameter("DATETO")==null)
{
	mDate2="";
}
else
{	
	mDate2=request.getParameter("DATETO").toString().trim();
}

if (request.getParameter("POL")==null)
{
	mPurposeOfLeave="";
}
else
{	
	mPurposeOfLeave=request.getParameter("POL").toString().trim();
}

if (request.getParameter("APRFLAG")==null)
{
	mAprFlag=0;
}
else
{	
	mAprFlag=Integer.parseInt(request.getParameter("APRFLAG").toString().trim());
}
if (request.getParameter("APRFLAG")==null)
{
	mAprStat="";
}
else
{	
	mAprStat=request.getParameter("APRSTAT").toString().trim();
}

//out.print(mAprFlag);
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Leave Request Approval ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInstitute=rs.getString(1);	
		else
			mInstitute="JIIT";

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	  
		qry="Select WEBKIOSK.ShowLink('148','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
		   if(mAprFlag==100)
		   {
			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Leave Request Approval</b></font></td></tr>
			</TABLE>
			<br>
			<%
			String mEnm="";
			qry="select EmployeeName from EmployeeMaster where EmployeeID='"+mEID+"'";
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mEnm=rs1.getString(1);
			}
			qry="select nvl(A.LEAVEDESCRIPTION,' ')LDESC from LEAVEMASTER A where A.LEAVECODE='"+mLeaveCode+"'";
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mLeaveDesc=rs1.getString("LDESC");
			}
			%>
			<br><br>
			<TABLE rules=none cellSpacing=0 cellPadding=0 border=2 align=center>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Staff Name </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mEnm%></Font></td></tr>
			<tr><td colspan=3>&nbsp;</td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Leave Code </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mLeaveCode%>-[<%=mLeaveDesc%>]</Font></td></tr>
			<tr><td colspan=3>&nbsp;</td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Leave Period </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mDate1%> to <%=mDate2%></Font></td></tr>
			<tr><td colspan=3>&nbsp;</td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Purpose of Leave </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mPurposeOfLeave%></Font></td></tr>
			</table>
			<br><br>
			<!--<table border=0 width=100% align=center><tr><td align=center><a href="LeaveRequestApproval.jsp" atl="BACK"><Font color=blue><img src="../../../Images/Back.jpg"></font></a></td></tr></table>-->
			</form>
			<%
		   }
		   else
		   {
			if (request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
			{
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
					mName1="Checked_"+String.valueOf(i).trim();
					mName2="STAFF_"+String.valueOf(i).trim();
					mName3="LCODE_"+String.valueOf(i).trim();
					mName4="SDATE_"+String.valueOf(i).trim();
					mName5="EDATE_"+String.valueOf(i).trim();
					mName6="SHDAY_"+String.valueOf(i).trim();
					mName7="ENDAY_"+String.valueOf(i).trim();
				
					if(request.getParameter(mName1)!=null)
						mChk=request.getParameter(mName1);
					else
						mChk="";
					if (request.getParameter(mName2)!=null)
						mSTAFF=request.getParameter(mName2);
					else
						mSTAFF="";
					if (request.getParameter(mName3)!=null)
						mLCODE=request.getParameter(mName3);
					else
						mLCODE="";
					if (request.getParameter(mName4)!=null)
						mSDATE=request.getParameter(mName4);
					else
						mSDATE="";
					if (request.getParameter(mName5)!=null)
						mEDATE=request.getParameter(mName5);
					else
						mEDATE="";
					if (request.getParameter(mName6)!=null)
						mSHDAY=request.getParameter(mName6);
					else
						mSHDAY="";
					if (request.getParameter(mName7)!=null)
						mEHDAY=request.getParameter(mName7);
					else
						mEHDAY="";
					if(mSHDAY.trim().equals("PreLunch"))
						mSHDAY="B";
					else if(mSHDAY.trim().equals("PostLunch"))
						mSHDAY="A";
					else
						mSHDAY="";
					if(mEHDAY.trim().equals("PreLunch"))
						mEHDAY="B";
					else if(mEHDAY.trim().equals("PostLunch"))
						mEHDAY="A";
					else
						mEHDAY="";

					//out.print(mSHDAY+mEHDAY);
					String mEnm="";
					qry="select EmployeeName from EmployeeMaster where EmployeeID='"+mSTAFF+"'";
					rs1=db.getRowset(qry);
					if(rs1.next())
					{
						mEnm=rs1.getString(1);
					}

				//-------------
				//--Update here
				//-------------
					mInst=mInstitute;
					if(!mChk.equals(""))
					{
						if(mChk.equals("Y"))
						{
							qry="UPDATE LEAVEREQUEST SET APPROVEDSTATUS='A', APPROVEDBY='"+mChkMemID+"', APPROVEDDATE=sysdate";
							//qry=qry+" , APPROVEDREMARKS='"+mAprRemarks+"'";
							qry=qry+" Where EMPLOYEEID='"+mSTAFF+"' AND LEAVECODE='"+mLCODE+"' AND trunc(STARTDATE)=trunc(to_date('"+mSDATE+"','dd-mm-yyyy'))";
							qry=qry+" AND trunc(ENDDATE)=trunc(to_date('"+mEDATE+"','dd-mm-yyyy')) AND (STARTHALFDAY='"+mSHDAY+"' or STARTHALFDAY='N' or STARTHALFDAY IS NULL) AND (ENDHALFDAY='"+mEHDAY+"' or ENDHALFDAY='N' or ENDHALFDAY IS NULL)";
							out.print(qry);
							n=db.update(qry);

							if(n>0)
							{
								mFlag=5;
								mRecFlag=mFlag;
							// Log Entry
							//-----------------
							      db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"LEAVE APPROVAL", "Staff:"+mEnm+" From:"+ mSDATE+" To:"+ mEDATE+" Leave Code:"+mLCODE, "NO MAC Address" , mIPAddress);
							//-----------------
							}
							mFlag=0;
						}
						else if(mChk.equals("A"))
						{
							qry="UPDATE LEAVEREQUEST SET APPROVEDSTATUS='', APPROVEDBY='', APPROVEDDATE=''";
							//qry=qry+" , APPROVEDREMARKS='"+mAprRemarks+"'";
							qry=qry+" Where EMPLOYEEID='"+mSTAFF+"' AND LEAVECODE='"+mLCODE+"' AND trunc(STARTDATE)=trunc(to_date('"+mSDATE+"','dd-mm-yyyy'))";
							qry=qry+" AND trunc(ENDDATE)=trunc(to_date('"+mEDATE+"','dd-mm-yyyy')) AND (STARTHALFDAY='"+mSHDAY+"' or STARTHALFDAY IS NULL) AND (ENDHALFDAY='"+mEHDAY+"' or ENDHALFDAY IS NULL)";
							//out.print(qry);
							n=db.update(qry);

							if(n>0)
							{
								mFlag=5;
								mRecFlag=mFlag;
							// Log Entry
							//-----------------
							      db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"LEAVE DE-APPROVAL", "Staff:"+mEnm+" From:"+ mSDATE+" To:"+ mEDATE+" Leave Code:"+mLCODE, "NO MAC Address" , mIPAddress);
							//-----------------
							}
							mFlag=0;
						}
					}
					else
					{
						ChkFlag++;
					}
				}

				//out.print("Remarks : "+mAprRemarks);
				if(mTotal==ChkFlag)
				{
					RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestApproval.jsp");
					request.setAttribute("message","Msg1");
					rd.forward(request,response);
					%><BR><CENTER><%
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>No Record Selected...</font></b><br>");
					%></CENTER><%
				}
				RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestApproval.jsp");
				rd.forward(request,response);
			}
			else
			{
		      	%>
				<center><br><br><font size=4 color=RED>&nbsp; &nbsp;No Record Found...</font></center>
				<%
			}
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
		<h3><br><img src='../../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
		<P>This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font><br><br><br><br> 
   		<%
  		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
out.print("Vijay Error Hai!");
}
%>
<br><br>
<table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../../Images/CampusConnectLogo.bmp">
<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
</td></tr></table>
</body>
</html>