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
<TITLE>#### <%=mHead%> [ Grade Approval By DOAA ]</TITLE>


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>

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

DBHandler db1=new DBHandler();
ResultSet rs=null,rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String x="";
int mTotal=0;
int n=0;
int mFlag=0;
int mRecFlag=0;
int ChkFlag=0;
String mName1="",mName2="",mName3="",mName4="";
String mSCode="", mAprRemarks="";

String mMemberID="",mTransId="",mFSTID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mECode="",mChk="";
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

if (request.getParameter("Remarks")==null)
{
	mAprRemarks="";
}
else
{
	mAprRemarks=GlobalFunctions.replaceSignleQuot(request.getParameter("Remarks").toString().trim());
}
//out.print("mAprRemarks :"+mAprRemarks);
%>
<br>
<hr>
<center><font size=4 face=Verdana color=green>Grade Approval</font>
<hr>
<font size=3 face='Verdana'><b>Approval for Exam Code : <%=mECode%></b></font></center>
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
		qry="Select WEBKIOSK.ShowLink('246','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
				mName1="Checked_"+String.valueOf(i).trim();
				mName2="SubjCode_"+String.valueOf(i).trim();
                mName3="TransId_"+String.valueOf(i).trim();
                mName4="FSTID_"+String.valueOf(i).trim();
				if(request.getParameter(mName1)!=null)
					mChk=request.getParameter(mName1);
				else
					mChk="";
				if (request.getParameter(mName2)!=null)
					mSCode=request.getParameter(mName2);
				else
					mSCode="";
                if (request.getParameter(mName3)!=null)
					mTransId=request.getParameter(mName3);
				else
					mTransId="";
                if (request.getParameter(mName4)!=null)
					mFSTID=request.getParameter(mName4);
				else
					mFSTID="";


			//-------------
			//--Update here
			//-------------
				if(!mChk.equals(""))
				{
					if(mChk.equals("D") && !mSCode.equals(""))///for approval
					{
						qry="UPDATE UPDREQ#STUDENTWISEGRADE SET APPROVALFLAG='A', APPROVEDBY='"+mChkMemID+"',";
						qry=qry+" APPROVALDATE=sysdate, APPROVALREMARKS='"+mAprRemarks+"'";
						qry=qry+" WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mECode+"' AND FSTID='"+mFSTID+"' AND TRANSID='"+mTransId+"'";
						//out.print(qry);
						n=db1.update(qry);

						if(n>0)
                          {
                            qry="SELECT EXAMCODE,FSTID,BREAK#SLNO,STUDENTID,OLDGRDAE,NEWGRADE FROM UPDREQ#STUDENTWISEGRADE  WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mECode+"' AND FSTID='"+mFSTID+"' AND TRANSID='"+mTransId+"' AND NVL(APPROVALFLAG,'D')='A'";
						   // out.print(qry);
                            rs=db1.getRowset(qry);
                            if(rs.next())
                                {
                            qry="UPDATE STUDENTWISEGRADE SET FINALGRADE='"+rs.getString("NEWGRADE")+"' WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mECode+"' AND FSTID='"+mFSTID+"' AND BREAK#SLNO='"+rs.getString("BREAK#SLNO")+"' AND STUDENTID='"+rs.getString("STUDENTID")+"'";
                            int m= db1.update(qry);
                                }
                            //mFlag=5;
							//mRecFlag=mFlag;
						// Log Entry
						//-----------------
						      db1.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"GRADE APPROVAL", "ExamCode:"+mECode +" SubjectID:"+ mSCode, "NO MAC Address" , mIPAddress);
						//-----------------
						}
						//mFlag=0;
					}
				/*	else if(mChk.equals("A") && !mSCode.equals(""))/// for GRADE DE-APPROVAL or cancled
					{
						qry="UPDATE GRADECALCULATION SET STATUS='D', APPROVEDBY='"+mChkMemID+"', ";
						qry=qry+" APPROVEDDATE=sysdate, APPROVEDREMARKS='"+mAprRemarks+"'";
						qry=qry+" WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mECode+"' AND SUBJECTID='"+mSCode+"'";
						//out.print(qry);
						n=db1.update(qry);

						if(n>0)
						{
							mFlag=5;
							mRecFlag=mFlag;
						// Log Entry
						//-----------------
						      db1.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"GRADE DE-APPROVAL", "ExamCode:"+mECode +" SubjectID:"+ mSCode, "NO MAC Address" , mIPAddress);
						//-----------------
						}
						mFlag=0;
					}*/

				}
				else
				{
					ChkFlag++;
				}
			}
			//out.print("Remarks : "+mAprRemarks);
			if(mTotal==ChkFlag)
			{
				%><BR><CENTER><%
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>No Record Selected...</font></b><br>");
				%></CENTER><%
			}
//-----------------------------
            %>
            <table border=1 bordercolor=orange cellpadding=1 cellspacing=1 rules="All" align=center>
				<tr bgcolor=ff8c00>
				<td><b><Font color=white face=arial>Subject</font></b></td>
                <td><b><Font color=white face=arial>Old Grade</font></b></td>
                <td><b><Font color=white face=arial>New Grade</font></b></td>
				<td><b><Font color=white face=arial>Approval Status</font></b></td>
				<td><b><Font color=white face=arial>Approved By</font></b></td>
				</tr>
            <%

              for (int i=1;i<=mTotal;i++)
			{
                 
				mRecFlag=0;
				mName1="Checked_"+String.valueOf(i).trim();
				mName2="SubjCode_"+String.valueOf(i).trim();
                mName3="TransId_"+String.valueOf(i).trim();
                mName4="FSTID_"+String.valueOf(i).trim();
				if(request.getParameter(mName1)!=null)
					mChk=request.getParameter(mName1);
				else
					mChk="";
               // out.print("mChk :"+mChk);
				if (request.getParameter(mName2)!=null)
					mSCode=request.getParameter(mName2);
				else
					mSCode="";
                if (request.getParameter(mName3)!=null)
					mTransId=request.getParameter(mName3);
				else
					mTransId="";
                if (request.getParameter(mName4)!=null)
					mFSTID=request.getParameter(mName4);
				else
					mFSTID="";
                if(mChk.equals("D"))
                    {
				qry="select Distinct A.EXAMCODE EXAMCODE,A.OLDGRDAE,A.NEWGRADE, B.SUBJECTID SUBJECTID,B.SUBJECTCODE SUBJCODE, B.SUBJECT SUBJNAME, decode(A.APPROVALFLAG,'A','Approved','C','Cancelled','D','Pending','F','Finalized','Not Approved')Status, nvl(A.APPROVEDBY,' ') AprBy";
				qry=qry+" from UPDREQ#STUDENTWISEGRADE A, SUBJECTMASTER B, facultysubjecttagging c where a.institutecode = c.institutecode AND a.FSTID=c.FSTID AND b.institutecode = c.institutecode AND b.subjectid = c.subjectid And A.INSTITUTECODE='"+mInst+"'";
				qry=qry+" And A.EXAMCODE='"+mECode+"' And A.TRANSID='"+mTransId+"' And A.FSTID='"+mFSTID+"' And A.APPROVALFLAG='A' Order by SUBJNAME";
				rs=db1.getRowset(qry);
				//out.print(qry);
    
				String mApprovedBy="", mEMPName="";
				while(rs.next())
				{
					mApprovedBy=rs.getString("AprBy");
					qry="Select nvl(EMPLOYEENAME,' ') EName FROM EMPLOYEEMASTER WHERE EMPLOYEEID='"+mApprovedBy+"'";
					rs1=db1.getRowset(qry);
					if(rs1.next())
						mEMPName=rs1.getString("EName");
					else
						mEMPName=" ";
					%>
					<tr>
					<td align=left><%=rs.getString("SUBJNAME")%></td>
                    <td align=left><%=rs.getString("OLDGRDAE")%></td>
                    <td align=left><%=rs.getString("NEWGRADE")%></td>

					<%
					if(rs.getString("Status").equals("Approved"))
					{
						%>
						<td align=center><font color=green><%=rs.getString("Status")%></font></td>
						<%
					}
					else if(rs.getString("Status").equals("Finalized"))
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
					if(!mEMPName.equals(" "))
					{
					%>
					<td align=left><%=mEMPName%></td>
					</tr>
					<%
					}
					else
					{
					%>
					<td>&nbsp;</td>
					</tr>
					<%
					}
				}
                }
                 }
				%>
				</table>
				<center><font size=2 color=green># Once you have approved the Grade, you cann't change that entry!</font></center>
				<%
               
			}
			else
			{
			%>
				<center><br><br><font size=4 color=RED>No Record Found !</font></center>
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