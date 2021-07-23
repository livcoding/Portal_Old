<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%@ page import="java.util.ArrayList,java.util.Iterator" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT",mAprStatus=""; 
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="",mStatus="";
String mInstitute="",mInst="",mtext="",mDate1="",mCurrDate="",mRightsID="143";
int mStudent=0,mFaculty=0,mDefault=15,mNoStudent=0,mSlno=0,count=0;
double mRequiredFaculty=0;
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();
if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();
if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Approve/Cancel ManPower Indent ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
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
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
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
		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			// For Log Entry Purpose
			//--------------------------------------
			String mLogEntryMemberID="",mLogEntryMemberType="";
			if (session.getAttribute("LogEntryMemberID")==null ||	session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
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
			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			<center>
	
	<table id=id1 width=852 ALIGN=CENTER  topmargin=0 cellspacing=0 cellpadding=0 rightmargin=0 leftmargin=0 bottommargin=0 >
			
<!-------------Page Heading and Marquee Message----------------------->
<%
try
{
	String mPageHeader="Approve/Cancel ManPower Indent", mMarqMsg="", CurrDate="";
	qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		CurrDate=rs.getString("CurrDate");
	}
	qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightsID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mMarqMsg=rs.getString("MarqMsg");
		%>
		<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
		<%
	}
	qry="Select nvl(B.PAGEHEADER,'"+mPageHeader+"')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mPageHeader=rs.getString("PageHeader");
		%>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
		<%
	}
	else
	{
		%>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
		<%
	}
}
catch(Exception e)
{}
%>
<!-------------Page Heading and Marquee Message----------------------->

			</table>
			</center><br>
			<%
			qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
			rsi=db.getRowset(qry);
			while(rsi.next())
			{
				mInst=rsi.getString("IC");
			}
			%>
			<center>
			<table cellpadding="0" cellspacing="0" width="30%" >
			<tr>
				<td align="center">
					<font Size=2 face="arial"><b>Status&nbsp;&nbsp;</b></font>
					<select name="AprStatus" ID="AprStatus" style="WIDTH: 90px">
					<%
					if(request.getParameter("x")==null)
					{
						mAprStatus="ALL";
						%>
							<OPTION Value=ALL selected>ALL</option>
							<OPTION Value=F>Finalized</option>
							<OPTION Value=C>Canceled</option>
							<OPTION Value=A>Pending</option>
						<%
					}
					else
					{
						if(request.getParameter("AprStatus").toString().trim().equals("ALL"))
						{
							%>
							<OPTION Value=ALL selected>ALL</option>
							<OPTION Value=F>Finalized</option>
							<OPTION Value=C>Canceled</option>
							<OPTION Value=A>Pending</option>
							<%
						}
						else if (request.getParameter("AprStatus").toString().trim().equals("F"))
						{
							%>
							<OPTION Value=ALL>ALL</option>
							<OPTION Value=F selected>Finalized</option>
							<OPTION Value=C>Canceled</option>
							<OPTION Value=A>Pending</option>
							<%
						}
						else if (request.getParameter("AprStatus").toString().trim().equals("C"))
						{
							%>
							<OPTION Value=ALL>ALL</option>
							<OPTION Value=F>Finalized</option>
							<OPTION Value=C selected>Canceled</option>
							<OPTION Value=A>Pending</option>
							<%
						}
						else
						{
							%>	
							<OPTION Value=ALL>ALL</option>
							<OPTION Value=A selected>Pending</option>
							<OPTION Value=F>Finalized</option>
							<OPTION Value=>Canceled</option>
							<%
						}
					}
					%>
				</td>
				<td>&nbsp;<input style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; border-width:1;" type="submit" name="submit" value="Show"></td>
			</tr>
			</table>
			</center>
			<br>
			<%	
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("AprStatus")==null)
					mAprStatus="";
				else
					mAprStatus=request.getParameter("AprStatus");
			}
			try
			{							
				qry="Select INDENTNO,INDENTREFNO,decode(INDENTSTATUS,'P',1,'A',2,'F',3,'C',4)STATUS, to_char(INDENTDATE,'dd/mm/yyyy')INDENTDATE,decode(INDENTSTATUS,'A','Pending','C','Canceled','F','Finalized',' ')INDENTSTATUS,to_char(REQUIREDDATE,'dd/mm/yyyy')REQUIREDDATE from HR#MANPOWERINDENT where INDENTSTATUS=decode('"+mAprStatus+"','ALL',INDENTSTATUS,'"+mAprStatus+"') and nvl(INDENTSTATUS,' ')<>'P' and to_date(REQUIREDDATE,'dd/mm/yyyy')>=To_date(sysdate,'dd/mm/yyyy') order by STATUS, INDENTNO";				
				//out.println(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					mStatus=rs.getString("INDENTSTATUS");
					if(count==0)
					{
					%>
						<center>
						<table class="sort-table" id="table-1" cellpadding="0"	cellspacing="0" border='1' width="60%">
						<tr bgcolor="#ff8c00">
							<td nowrap><font color="white"><b>Sr.No</b></font></td>
							<td nowrap>&nbsp;<font color="white"><b>Indent Refrence No.</b></font></td>
							<td nowrap>&nbsp;<font color="white"><b>Indent Date</b></font></td>
							<td nowrap>&nbsp;<font color="white"><b>Indent Status</b></font></td>
							<td nowrap>&nbsp;<font color="white"><b>Require Date</b></font></td>
						</tr>
					<%
						count++;
					}
					%>
						<tr>
							<td align=right><%=++mSlno%>.&nbsp;&nbsp;</td>
							<td>&nbsp;<a title="Click to show Qualifications details" target=_new  href="IndentQualification1.jsp?&IntendNo=<%=rs.getString("INDENTNO")%>"><font color='blue'><b><%=rs.getString("INDENTREFNO")%></B></FONT></A></td>
							<td>&nbsp;<%=rs.getString("INDENTDATE")%></td>
						<%
						if(mStatus.equals("Pending"))
						{
							%>
								<td align="center">&nbsp;<a href="ManPowerIndentApprovelAction.jsp?&IndentNo=<%=rs.getString("INDENTNO")%>" title="Click to Finalized/Cancel" style="cursor:hand; border-width:0; text-align: Left; font-family:Arial; text-decoration:underline; font-weight:bold; color:Blue;"><%=mStatus%></a></td>
							<%
						}
						else if(mStatus.equals("Finalized"))
						{
							%>
								<td align="center">&nbsp;<a title="" style=" background-color:; border-width:0; text-align: Left; font-family:Arial; font-weight:bold; color:green;"><%=mStatus%></a></td>
							<%				
						}
						else if(mStatus.equals("Canceled"))
						{
							%>
								<td align="center">&nbsp;<a title="" style=" background-color: ; border-width:0; text-align: Left; font-family:Arial; font-weight:bold; color:red;"><%=mStatus%></a></td>
							<%				
						}
						else
						{
							%>
								<td>&nbsp;</td>
							<%				
						}
					%>				
							<td>&nbsp;<%=rs.getString("REQUIREDDATE")%></td>							
						</tr>
					<%
				}
				%>
				<table>
				</center>
				<%				
			}catch(Exception e)
			{/*System.out.println("Exception e:-"+e);	*/	}
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3>	<br><img src='../../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br> 
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
	//out.print("Catch Block");	
}
%>
</form>
</body>
</html>