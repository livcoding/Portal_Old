<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;

GlobalFunctions gb =new GlobalFunctions();
int mSno=0, TotInboxItem=0;
String qry="",qry1="";
String mColor="",mComp="",TRCOLOR="White";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mFacultyName="",mFaculty="", mMsg="";
String QryFaculty="",mEID="",mENM="",mcolor="",mRightsID="148";
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
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Leave Request Approval ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
 for (var i = 0; i < document.frm1.elements.length; i++) 
 {
  var e = document.frm1.elements[i]; 
  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
  { 
   e.checked = document.frm1.allbox.checked;
  }
 }
}
</SCRIPT>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
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
	
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
		qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	
	  //----------------------
	%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	
<table id=id1 width="852" ALIGN=CENTER  topmargin=0 cellspacing=0 cellpadding=0 rightmargin=0 leftmargin=0 bottommargin=0 >

	
<!-------------Page Heading and Marquee Message----------------------->
<%
try
{
	String mPageHeader="Leave Request Approval", mMarqMsg="", CurrDate="";
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
	</TABLE>
<!--Institute****-->
	<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInst%>'>
	<%
	String mGetPLRID="", mEmpType="", CurrRID="", RestRID="", mDiffPath="N", mDiffPathRID="";
	qry="select EMPLOYEETYPE EmpType from V#STAFF WHERE COMPANYCODE='"+mComp+"' AND EMPLOYEEID='"+mChkMemID+"' ";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mEmpType=rs.getString("EmpType");
	}
	qry="Select nvl(WEBKIOSK.GetPendingLeaveRequestID('"+mComp+"','"+mInst+"','LEAVE','"+mChkMemID+"','"+mEmpType+"'),'Zero') GetPLRID from dual";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next() && !rs.getString("GetPLRID").equals("Zero"))
	{
		mGetPLRID=rs.getString("GetPLRID");
		//out.print(mGetPLRID);
		int lenReq=0, lenDfPath=0, posReq=0, posDfPath=0;
		%>
		<BR><table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center>
		<thead>
		<tr bgcolor="#ff8c00">
			<td align=left rowspan=2 nowrap><font color=white><B>Staff</B></font></td>
			<td align=center rowspan=2 nowrap><font color=white><B>Leave<br>Code</B></font></td>
			<td align=center nowrap colspan=2><font color=white><B>Period</B></font></td>
			<td align=center nowrap colspan=2><font color=white><B>Half Day</B></font></td>
			<td align=center nowrap colspan=3><font color=white><B>Leave Type</B></font></td>						
			<td align=center rowspan=2 nowrap Title="See Approval Status"><b><font color="white"></font><font color="white">Status</font></b></td>
		</tr>
		<tr bgcolor="#ff8c00">
			<td align=center nowrap><font color=white><B>Start Date</B></font></td>
			<td align=center nowrap><font color=white><B>End Date</B></font></td>
			<td align=center nowrap><font color=white><B>Start</B></font></td>
			<td align=center nowrap><font color=white><B>End</B></font></td>
			<td align=center nowrap><font color=white><B>Paid</B></font></td>
			<td align=center nowrap><font color=white><B>LWP</B></font></td>
			<td align=center nowrap><font color=white><B>Absent</B></font></td>
		</tr>
		</thead>
		<tbody>
		<%
		if(mGetPLRID.indexOf("#")>=0)
		{
			while(1==1)
			{
				lenReq=mGetPLRID.length();
				posReq=mGetPLRID.indexOf("#");
				CurrRID=mGetPLRID.substring(0,posReq);
				RestRID=mGetPLRID.substring(posReq+1,lenReq);
				mGetPLRID=RestRID;
				if(CurrRID.indexOf("=")>=0)
				{
					lenDfPath=CurrRID.length();
					posDfPath=CurrRID.indexOf("=");
					mDiffPathRID=CurrRID.substring(0,posDfPath);
					mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
					CurrRID=mDiffPathRID;
				}
				qry="Select Distinct '"+mDiffPath+"' DiffPath, B.RequestID RID, B.EMPLOYEEID EMPLOYEEID, nvl(A.EMPLOYEENAME,' ') STAFF, nvl(B.PURPOSEOFLEAVE,' ')POL, B.LeaveCode LEAVE, B.LeaveCode||' ('||C.LEAVEDESCRIPTION||')' LCODE, to_char(B.STARTDATE,'dd-mm-yyyy') SDATE, nvl(to_char(B.ENDDATE,'dd-mm-yyyy'),' ')EDATE, Decode(B.STARTHALFDAY,'B','PreLunch','A','PostLunch',' ')SHDAY, Decode(B.ENDHALFDAY,'B','PreLunch','A','PostLunch',' ')EHDAY,";
				qry=qry+" nvl(B.APPROVEDSTATUS,' ')APPROVEDSTATUS, nvl(B.PAID,0)PAID, nvl(B.WITHOUTPAY,0)LWP, nvl(B.ABSENT,0)ABSENT FROM EMPLOYEEMASTER A, LEAVEREQUEST B, LEAVEMASTER C where ";
				qry=qry+" A.EMPLOYEEID=B.EMPLOYEEID and A.COMPANYCODE='"+mComp+"' and B.REQUESTID='"+CurrRID+"'";
				qry=qry+" and B.COMPANYCODE=C.COMPANYCODE and B.LEAVECODE=C.LEAVECODE ORDER BY SDATE, EDATE, LCODE DESC";
				//out.print(qry);
			    	rs=db.getRowset(qry);
				if(rs.next())
				{
					mSno++;
					%>
					<tr bgcolor="<%=TRCOLOR%>">
					<td nowrap align=left><a target="" Title="Click to Approve <%=rs.getString("STAFF")%>'s Leave Request" href='LeaveRequestApprovalDetail.jsp?RID=<%=rs.getString("RID")%>&amp;DiffPath=<%=rs.getString("DiffPath")%>&amp;EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>'><FONT COLOR=GREEN><%=rs.getString("STAFF")%></FONT></a></td>
					<td nowrap align=Left><font color=<%=mColor%>><%=rs.getString("LEAVE")%></font></td>
					<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("SDATE")%></font></td>
					<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("EDATE")%></font></td>
					<%
					if(rs.getString("SHDAY").trim().equals(""))
					{
						%>
						<td nowrap align=center><font color=<%=mColor%>>&nbsp;</font></td>
						<%
					}
					else
					{
						%>
						<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("SHDAY")%></font></td>
						<%
					}
					if(rs.getString("EHDAY").trim().equals(""))
					{
						%>
						<td nowrap align=center><font color=<%=mColor%>>&nbsp;</font></td>
						<%
					}
					else
					{
						%>
						<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("EHDAY")%></font></td>
						<%
					}
					%>
					<td nowrap align=right><font color=<%=mColor%>><%=rs.getDouble("PAID")%></font></td>
					<td nowrap align=right><font color=<%=mColor%>><%=rs.getDouble("LWP")%></font></td>
					<td nowrap align=right><font color=<%=mColor%>><%=rs.getDouble("ABSENT")%></font></td>
					<%
					if(!rs.getString("APPROVEDSTATUS").trim().equals("A"))
					{
						%>
						<td nowrap align=left><a target="" Title="Click to View <%=rs.getString("STAFF")%>'s UnApproved Leave Request" target=_New href='LeaveRequestApprovalAction.jsp?EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRFLAG=100&amp;APRSTAT=U'><FONT COLOR=BLUE>Not Approved</FONT></a></td>
						<%
					}
					else
					{
						%>
						<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s Approved Leave Request" target=_New href='LeaveRequestApprovalAction.jsp?EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRFLAG=100&amp;APRSTAT=A'><FONT COLOR=GREEN>Approved</FONT></a></td>
						<%
					}
					%>
					</tr>
					<%
				}
				/*out.print(CurrRID+" --- "+mDiffPath+" --- "+RestRID);
				%><BR><%*/
				if(mGetPLRID.indexOf("#")<0)
				{
					CurrRID=mGetPLRID;
					if(CurrRID.indexOf("=")>=0)
					{
						lenDfPath=CurrRID.length();
						posDfPath=CurrRID.indexOf("=");
						mDiffPathRID=CurrRID.substring(0,posDfPath);
						mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
						CurrRID=mDiffPathRID;
					}

					qry="Select Distinct '"+mDiffPath+"' DiffPath, B.RequestID RID, B.EMPLOYEEID EMPLOYEEID, nvl(A.EMPLOYEENAME,' ') STAFF, nvl(B.PURPOSEOFLEAVE,' ')POL, B.LeaveCode LEAVE, B.LeaveCode||' ('||C.LEAVEDESCRIPTION||')' LCODE, to_char(B.STARTDATE,'dd-mm-yyyy') SDATE, nvl(to_char(B.ENDDATE,'dd-mm-yyyy'),' ')EDATE, Decode(B.STARTHALFDAY,'B','PreLunch','A','PostLunch',' ')SHDAY, Decode(B.ENDHALFDAY,'B','PreLunch','A','PostLunch',' ')EHDAY,";
					qry=qry+" nvl(B.APPROVEDSTATUS,' ')APPROVEDSTATUS, nvl(B.PAID,0)PAID, nvl(B.WITHOUTPAY,0)LWP, nvl(B.ABSENT,0)ABSENT FROM EMPLOYEEMASTER A, LEAVEREQUEST B, LEAVEMASTER C where ";
					qry=qry+" A.EMPLOYEEID=B.EMPLOYEEID and A.COMPANYCODE='"+mComp+"' and B.REQUESTID='"+CurrRID+"'";
					qry=qry+" and B.COMPANYCODE=C.COMPANYCODE and B.LEAVECODE=C.LEAVECODE ORDER BY SDATE, EDATE, LCODE DESC";
					//out.print(qry);
				    	rs=db.getRowset(qry);
					if(rs.next())
					{
						mSno++;
						%>
						<tr bgcolor="<%=TRCOLOR%>">
						<td nowrap align=left><a Title="Click to Approve <%=rs.getString("STAFF")%>'s Leave Request" href='LeaveRequestApprovalDetail.jsp?RID=<%=rs.getString("RID")%>&amp;DiffPath=<%=rs.getString("DiffPath")%>&amp;EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>'><FONT COLOR=GREEN><%=rs.getString("STAFF")%></FONT></a></td>
						<td nowrap align=Left><font color=<%=mColor%>><%=rs.getString("LEAVE")%></font></td>
						<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("SDATE")%></font></td>
						<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("EDATE")%></font></td>
						<%
						if(rs.getString("SHDAY").trim().equals(""))
						{
							%>
							<td nowrap align=center><font color=<%=mColor%>>&nbsp;</font></td>
							<%
						}
						else
						{
							%>
							<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("SHDAY")%></font></td>
							<%
						}
						if(rs.getString("EHDAY").trim().equals(""))
						{
							%>
							<td nowrap align=center><font color=<%=mColor%>>&nbsp;</font></td>
							<%
						}
						else
						{
							%>
							<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("EHDAY")%></font></td>
							<%
						}
						%>
						<td nowrap align=right><font color=<%=mColor%>><%=rs.getDouble("PAID")%></font></td>
						<td nowrap align=right><font color=<%=mColor%>><%=rs.getDouble("LWP")%></font></td>
						<td nowrap align=right><font color=<%=mColor%>><%=rs.getDouble("ABSENT")%></font></td>
						<%
						if(!rs.getString("APPROVEDSTATUS").trim().equals("A"))
						{
							%>
							<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s UnApproved Leave Request" target=_New href='LeaveRequestApprovalAction.jsp?EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRFLAG=100&amp;APRSTAT=U'><FONT COLOR=BLUE>Not Approved</FONT></a></td>
							<%
						}
						else
						{
							%>
							<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s Approved Leave Request" target=_New href='LeaveRequestApprovalAction.jsp?EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRFLAG=100&amp;APRSTAT=A'><FONT COLOR=GREEN>Approved</FONT></a></td>
							<%
						}
						%>
						</tr>
						<%
					}
					//out.print(CurrRID+" --- "+mDiffPath);
					break;
				}
			}
		}
		else
		{
			CurrRID=mGetPLRID;
			if(CurrRID.indexOf("=")>=0)
			{
				lenDfPath=CurrRID.length();
				posDfPath=CurrRID.indexOf("=");
				mDiffPathRID=CurrRID.substring(0,posDfPath);
				mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
				CurrRID=mDiffPathRID;
			}

			qry="Select Distinct '"+mDiffPath+"' DiffPath, B.RequestID RID, B.EMPLOYEEID EMPLOYEEID, nvl(A.EMPLOYEENAME,' ') STAFF, nvl(B.PURPOSEOFLEAVE,' ')POL, B.LeaveCode LEAVE, B.LeaveCode||' ('||C.LEAVEDESCRIPTION||')' LCODE, to_char(B.STARTDATE,'dd-mm-yyyy') SDATE, nvl(to_char(B.ENDDATE,'dd-mm-yyyy'),' ')EDATE, Decode(B.STARTHALFDAY,'B','PreLunch','A','PostLunch',' ')SHDAY, Decode(B.ENDHALFDAY,'B','PreLunch','A','PostLunch',' ')EHDAY,";
			qry=qry+" nvl(B.APPROVEDSTATUS,' ')APPROVEDSTATUS, nvl(B.PAID,0)PAID, nvl(B.WITHOUTPAY,0)LWP, nvl(B.ABSENT,0)ABSENT FROM EMPLOYEEMASTER A, LEAVEREQUEST B, LEAVEMASTER C where ";
			qry=qry+" A.EMPLOYEEID=B.EMPLOYEEID and A.COMPANYCODE='"+mComp+"' and B.REQUESTID='"+CurrRID+"'";
			qry=qry+" and B.COMPANYCODE=C.COMPANYCODE and B.LEAVECODE=C.LEAVECODE ORDER BY SDATE, EDATE, LCODE DESC";
			//out.print(qry);
		    	rs=db.getRowset(qry);
			if(rs.next())
			{
				mSno++;
				%>
				<tr bgcolor="<%=TRCOLOR%>">
				<td nowrap align=left><a Title="Click to Approve <%=rs.getString("STAFF")%>'s Leave Request" href='LeaveRequestApprovalDetail.jsp?RID=<%=rs.getString("RID")%>&amp;DiffPath=<%=rs.getString("DiffPath")%>&amp;EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>'><FONT COLOR=GREEN><%=rs.getString("STAFF")%></FONT></a></td>
				<td nowrap align=Left><font color=<%=mColor%>><%=rs.getString("LEAVE")%></font></td>
				<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("SDATE")%></font></td>
				<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("EDATE")%></font></td>
				<%
				if(rs.getString("SHDAY").trim().equals(""))
				{
					%>
					<td nowrap align=center><font color=<%=mColor%>>&nbsp;</font></td>
					<%
				}
				else
				{
					%>
					<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("SHDAY")%></font></td>
					<%
				}
				if(rs.getString("EHDAY").trim().equals(""))
				{
					%>
					<td nowrap align=center><font color=<%=mColor%>>&nbsp;</font></td>
					<%
				}
				else
				{
					%>
					<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("EHDAY")%></font></td>
					<%
				}
				%>
				<td nowrap align=right><font color=<%=mColor%>><%=rs.getDouble("PAID")%></font></td>
				<td nowrap align=right><font color=<%=mColor%>><%=rs.getDouble("LWP")%></font></td>
				<td nowrap align=right><font color=<%=mColor%>><%=rs.getDouble("ABSENT")%></font></td>
				<%
				if(!rs.getString("APPROVEDSTATUS").trim().equals("A"))
				{
					%>
					<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s UnApproved Leave Request" target=_New href='LeaveRequestApprovalAction.jsp?EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRFLAG=100&amp;APRSTAT=U'><FONT COLOR=BLUE>Not Approved</FONT></a></td>
					<%
				}
				else
				{
					%>
					<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s Approved Leave Request" target=_New href='LeaveRequestApprovalAction.jsp?EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRFLAG=100&amp;APRSTAT=A'><FONT COLOR=GREEN>Approved</FONT></a></td>
					<%
				}
				%>
				</tr>
				<%
			}
			//out.print(CurrRID+" --- "+mDiffPath);
		}
		%>
		</tbody>
		</table>
		<%
	}
	if(mSno>0)
	{
		%>
		<Table width=100% align=left><tr><td align=left nowrap>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<Font color="#f00000" size=3 face="arial black">You Have <Font color="Blue" size=3 face="arial black"><%=mSno%></font> Leave Request to Approve...</font></td></tr>
		<tr><td></td></tr></table><br>
		<%
	}
	else
	{
		%>
		<Table width=100% align=left><tr><td align=left nowrap>&nbsp; &nbsp; &nbsp;<Font color="#f00000" size=3 face="arial black">You Have <Font color="Blue" size=3 face="arial black">No</font> New Leave Request to Approve...</font></td></tr></table><br>
		<%
	}
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
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
out.print(e);
}
%>
</body>
</html>