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
<TITLE>#### <%=mHead%>[HOD wise Load Distribution Approval by DOAA (Pre Registration)]</TITLE>


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
DBHandler db1=new DBHandler();
ResultSet rs=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String x="",mySect="",mfactype="E";
int mTotal=0;
int n=0,n1=0;
int mFlag=0;
int mRecFlag=0;
int LockFlag=0;
int ChkFlag=0;
String mName1="",mName2="",mName3="";
String mHODID="";
String mDept="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="", CurrDate="";
String mECode="",mChk="",mLockBackLog="";
String mSType="",mWebEmail="", mPrExCode="";
String mCompcode="";

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";
rs=db1.getRowset(qry);
if(rs.next())
  CurrDate=rs.getString(1);
else
  CurrDate="";
if (session.getAttribute("CompanyCode")==null)
{
	mCompcode="";
}
else
{
	mCompcode=session.getAttribute("CompanyCode").toString().trim();
}

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

if (request.getParameter("SemType")==null)
{
	mSType="";
}
else
{
	mSType=request.getParameter("SemType").toString().trim();
}

if (request.getParameter("PREVENT")==null)
{
	mPrExCode="";
}
else
{
	mPrExCode=request.getParameter("PREVENT").toString().trim();
}
//out.print(mPrExCode+"hiiiii");
%>
<br>
	<center><font size=4 face=Verdana color=green>HOD wise Load Distribution Approval Detail</font>
	<hr>
	<%
	String mtyp="";
	if(mSType.equals("ALL")) mtyp="REG & RWJ";
	if(mSType.equals("REG")) mtyp="REG";
	if(mSType.equals("RWJ")) mtyp="RWJ";
	%>
	<font size=3 face='Verdana'><b>Semester Type : <%=mtyp%></b></font></center>
	<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
	<tr bgcolor=ff8c00>
	<td><b>Faculty Name</b></td>
	<td><b>Department</b></td>
	<td><b>Approval Status</b></td>
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
		qry="Select WEBKIOSK.ShowLink('113','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db1.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
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
				mName1="checked_"+String.valueOf(i).trim();
				mName2="Department_"+String.valueOf(i).trim();
				mName3="HODID_"+String.valueOf(i).trim();
				
				if(request.getParameter(mName1)!=null)
					mChk=request.getParameter(mName1);
				else
					mChk="";
				if (request.getParameter(mName2)!=null)
					mDept=request.getParameter(mName2);
				else
					mDept="";
				if (request.getParameter(mName3)!=null)
					mHODID=request.getParameter(mName3);
				else
					mHODID="";
			//-------------
			//--Update here
			//-------------
			//out.print(mChk+"  Check");
				if(!mChk.equals(""))
				{
					if(mChk.equals("Y") && !mDept.equals(""))
					{
						out.print("******************************");
						qry="UPDATE PR#HODLOADDISTRIBUTION SET STATUS='A' ,APPROVEDBY='"+mChkMemID+"' ,APPROVEDDATE=sysdate";
						qry=qry+" WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mECode+"' AND DEPARTMENTRUNNIG='"+mDept+"'";
						qry=qry+" AND ENTRYBY 	in (select EMPLOYEEID from USERWISELOADPERMITION where      EXAMCODE= '"+mECode+"' and  INSTITUTECODE='"+mInst+"' and DEPARTMENTCODE ='"+mDept+"'   and nvl(DEACTIVE,'N')='N')";
						qry=qry+" AND NVL(DEACTIVE,'N')='N' AND MERGEWITHFSTID IS NULL";
						out.print(qry);
						n=db1.update(qry);
						
						qry="UPDATE PR#HODLOADDISTRIBUTION SET STATUS='A' ,APPROVEDBY='"+mChkMemID+"' ,APPROVEDDATE=sysdate";
						qry=qry+" WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mECode+"' AND DEPARTMENTRUNNIG='"+mDept+"'";
						qry=qry+" AND ENTRYBY 	in (select EMPLOYEEID from USERWISELOADPERMITION where      EXAMCODE= '"+mECode+"' and   INSTITUTECODE='"+mInst+"' and DEPARTMENTCODE ='"+mDept+"'    and nvl(DEACTIVE,'N')='N')";						
						qry=qry+" AND NVL(DEACTIVE,'N')='N' AND MERGEWITHFSTID IS NOT NULL";
						n+=db1.update(qry);
						//out.println(qry);
						qry=" Update USERWISELOADPERMITION set FREEZED='Y' where EXAMCODE='"+mECode+"'  and  INSTITUTECODE='"+mInst+"' and EMPLOYEEID='"+mChkMemID+"' and DEPARTMENTCODE='"+mDept+"'";
						//out.println(qry);
						int u2=db.update(qry);

						qry="UPDATE PREVENTS SET LOADDISTRIBUTIONSTATUS='A', LOADDISTAPPROVEDBY='"+mChkMemID+"', LOADDISTAPPROVALDATE=sysdate";
						qry=qry+" WHERE INSTITUTECODE='"+mInst+"' AND PREVENTCODE='"+mPrExCode+"' AND MEMBERTYPE='"+mfactype+"'";
						qry=qry+" AND MEMBERID in (select EMPLOYEEID from USERWISELOADPERMITION where      EXAMCODE= '"+mECode+"' and   INSTITUTECODE='"+mInst+"' and DEPARTMENTCODE ='"+mDept+"'   and nvl(FREEZED,'N')='Y'  and nvl(DEACTIVE,'N')='N') AND NVL(DEACTIVE,'N')='N'";
						//out.print(qry);
						n1=db1.update(qry);

						if(n>0 && n1>0)
						{
							mFlag=5;
							mRecFlag=mFlag;
						// Log Entry
						//-----------------
						      db1.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG HOD LOAD DISTRIBUTION APPROVAL", "ExamCode:"+mECode +" Department:"+ mDept, "NO MAC Address" , mIPAddress);
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
			if(mTotal==ChkFlag)
			{
				%><BR><%
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>No Record Selected...</font></b><br>");
			}

//-------------------------------------------------------
//------------------------------------------------
		/*	if(mRecFlag==5)
			{
				%><BR><%
			//	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>HOD wise Load Distribution(s) are approved successfully...</font> <br>");
			}
			else
			{
				%><BR><%out.print("<img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Error while approving Load Distribution...</font> <br>");
			}	*/
//------------------------------------------------
//-------------------------------------------------------
//-----------------------------

				qry="select Distinct nvl(A.DEPARTMENTRUNNIG,' ') Dept, decode(A.Status,'A','Approved','C','Cancelled','Not Approved')Status, nvl(B.EMPLOYEEID,' ') HOD, nvl(C.EMPLOYEENAME,' ') HODName";
				qry=qry+" from PR#HODLOADDISTRIBUTION A, USERWISELOADPERMITION B, EMPLOYEEMASTER C where  A.ENTRYBY=C.EMPLOYEEID AND  B.EMPLOYEEID=C.EMPLOYEEID AND A.INSTITUTECODE=B.INSTITUTECODE AND A.EXAMCODE=B.EXAMCODE And A.INSTITUTECODE='"+mInst+"'";
				qry=qry+" AND A.DEPARTMENTRUNNIG=B.DEPARTMENTCODE AND NVL(A.DEACTIVE,'N')='N' And A.EXAMCODE='"+mECode+"' and A.SEMESTERTYPE=decode('"+mSType+"','ALL',A.SEMESTERTYPE,'"+mSType+"') Order by Dept";

				rs=db1.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					%>
					<tr>
					<td align=left><%=rs.getString("HODName")%></td>
					<td align=left><%=rs.getString("Dept")%></td>
					<%
					if(rs.getString("Status").equals("Approved"))
					{
						%>
						<td align=center><font color=green><%=rs.getString("Status")%></font></td>
						<%
					}
					else if(rs.getString("Status").equals("Cancelled"))
					{
						%>
						<td align=center><font color=green><%=rs.getString("Status")%></font></td>
						<%
					}
					else
					{
						%>
						<td align=center><font color=red><%=rs.getString("Status")%></font></td>
						<%
					}
					%>
					</tr>
					<%
				}
				%>
				</table>
				<center><font size=2 color=green># Once you have approved the Load Distribution, you cann't change that entry!</font></center>
				<%
			}
			else
			{
			%>
				<center><br><br><font size=4 color=RED>!&nbsp; &nbsp;No Record Found...</font></center>
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
			<h3><br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed)</h3><br>
			<P>This page is not authorized/available for you.
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
%><br><br>
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