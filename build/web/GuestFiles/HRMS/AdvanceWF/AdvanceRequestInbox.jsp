<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;

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
String mWFCode="ADVANCE", mFacultyName="",mFaculty="", mMsg="";
String QryFaculty="",mEID="",mENM="",mcolor="";
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

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Advance Request Approval ] </TITLE>

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
		qry="Select WEBKIOSK.ShowLink('171','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
	  //----------------------
	%>
	<form name="frm" method="post">
	<input id="x" name="x" type=hidden>
	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Advance Request Approval</B></TD>
	</font></td></tr>
	</TABLE>
	<%
	String mGetPARID="", mEmpType="", CurrRID="", RestRID="", mDiffPath="Y", mDiffPathRID="";
	qry="select EMPLOYEETYPE EmpType from V#STAFF WHERE COMPANYCODE='"+mComp+"' AND EMPLOYEEID='"+mChkMemID+"'";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mEmpType=rs.getString("EmpType");
	}
	qry="Select nvl(WEBKIOSK.GetPendingAdvanceRequestID('"+mComp+"','"+mInst+"','"+mWFCode+"','"+mChkMemID+"','"+mEmpType+"'),'Zero') GetPLRID from dual";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next() && !rs.getString("GetPLRID").equals("Zero"))
	{
		mGetPARID=rs.getString("GetPLRID");
		//out.print(mGetPARID);
		int lenReq=0, lenDfPath=0, posReq=0, posDfPath=0;
		%>
		<BR><table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center>
		<thead>
		<tr bgcolor="#ff8c00">
			<td align=left nowrap><font color=white><B>Staff</B></font></td>
			<td align=center nowrap><font color=white><B>Advance Type</B></font></td>
			<td align=center nowrap><font color=white><B>Amount</B></font></td>
			<td align=center nowrap Title="See Approval Status"><b><font color="white"></font><font color="white">Status</font></b></td>
		</tr>
		</thead>
		<tbody>
		<%
		if(mGetPARID.indexOf("#")>=0)
		{
			while(1==1)
			{
				lenReq=mGetPARID.length();
				posReq=mGetPARID.indexOf("#");
				CurrRID=mGetPARID.substring(0,posReq);
				RestRID=mGetPARID.substring(posReq+1,lenReq);
				mGetPARID=RestRID;
				if(CurrRID.indexOf("=")>=0)
				{
					lenDfPath=CurrRID.length();
					posDfPath=CurrRID.indexOf("=");
					mDiffPathRID=CurrRID.substring(0,posDfPath);
					mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
					CurrRID=mDiffPathRID;
				}
				qry="Select Distinct '"+mDiffPath+"' DiffPath, nvl(B.RequestID,' ') RID, B.MEMBERID MEMBERID, nvl(A.EMPLOYEENAME,' ') STAFF, A.EMPLOYEECODE EMPCODE, B.ADVANCETYPE ADVTYPE, B.ADVANCETYPE||' ('||C.ADVANCEDESC||')' ADVDESC, B.ADVANCEAMOUNT ADVAMOUNT,";
				qry=qry+" nvl(B.APPROVEDSTATUS,' ')APPROVEDSTATUS FROM V#STAFF A, PAY#EMPOTHERADVANCEREQUEST B, PAY#ADVANCETYPEMASTER C where ";
				qry=qry+" A.EMPLOYEEID=B.MEMBERID and B.COMPANYCODE='"+mComp+"' and B.INSTITUTECODE='"+mInst+"' and B.REQUESTID='"+CurrRID+"'";
				qry=qry+" and B.COMPANYCODE=C.COMPANYCODE and B.ADVANCETYPE=C.ADVANCETYPE ORDER BY ADVAMOUNT, ADVDESC DESC";
				//out.print(qry);
			    	rs=db.getRowset(qry);
				if(rs.next())
				{
					mSno++;
					%>
					<tr bgcolor="<%=TRCOLOR%>">
					<td nowrap align=left><a target="" Title="Click to Approve <%=rs.getString("STAFF")%>'s Advance Request" href='AdvanceRequestApprovalDetail.jsp?RID=<%=rs.getString("RID")%>&amp;DiffPath=<%=rs.getString("DiffPath")%>&amp;EID=<%=rs.getString("MEMBERID")%>&amp;WFCODE=<%=mWFCode%>&amp;WFTYPE=<%=rs.getString("ADVTYPE")%>'><FONT COLOR=GREEN><%=rs.getString("STAFF")%> [<%=rs.getString("EMPCODE")%>]</FONT></a></td>
					<td nowrap align=Left><font color=<%=mColor%>><%=rs.getString("ADVDESC")%></font></td>
					<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("ADVAMOUNT")%></font></td>
					<%
					if(!rs.getString("APPROVEDSTATUS").trim().equals("A"))
					{
						%>
						<td nowrap align=left><a target="" Title="Click to View <%=rs.getString("STAFF")%>'s UnApproved Advance Request" target=_New href='AdvanceRequestStatus.jsp?RID=<%=rs.getString("RID")%>&amp;EID=<%=rs.getString("MEMBERID")%>&amp;WFCODE=<%=mWFCode%>&amp;WFTYPE=<%=rs.getString("ADVTYPE")%>'><FONT COLOR=BLUE>Not Approved</FONT></a></td>
						<%
					}
					else
					{
						%>
						<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s Approved Advance Request" target=_New href='AdvanceRequestStatus.jsp?RID=<%=rs.getString("RID")%>&amp;EID=<%=rs.getString("MEMBERID")%>&amp;WFCODE=<%=mWFCode%>&amp;WFTYPE=<%=rs.getString("ADVTYPE")%>&amp;APRFLAG=100&amp;APRSTAT=A'><FONT COLOR=GREEN>Approved</FONT></a></td>
						<%
					}
					%>
					</tr>
					<%
				}
				/*out.print(CurrRID+" --- "+mDiffPath+" --- "+RestRID);
				%><BR><%*/
				if(mGetPARID.indexOf("#")<0)
				{
					CurrRID=mGetPARID;
					if(CurrRID.indexOf("=")>=0)
					{
						lenDfPath=CurrRID.length();
						posDfPath=CurrRID.indexOf("=");
						mDiffPathRID=CurrRID.substring(0,posDfPath);
						mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
						CurrRID=mDiffPathRID;
					}

					qry="Select Distinct '"+mDiffPath+"' DiffPath, B.RequestID RID, B.MEMBERID MEMBERID, nvl(A.EMPLOYEENAME,' ') STAFF, A.EMPLOYEECODE EMPCODE, B.ADVANCETYPE ADVTYPE, B.ADVANCETYPE||' ('||C.ADVANCEDESC||')' ADVDESC, ADVANCEAMOUNT ADVAMOUNT,";
					qry=qry+" nvl(B.APPROVEDSTATUS,' ')APPROVEDSTATUS FROM V#STAFF A, PAY#EMPOTHERADVANCEREQUEST B, PAY#ADVANCETYPEMASTER C where ";
					qry=qry+" A.EMPLOYEEID=B.MEMBERID and B.COMPANYCODE='"+mComp+"' and B.INSTITUTECODE='"+mInst+"' and B.REQUESTID='"+CurrRID+"'";
					qry=qry+" and B.COMPANYCODE=C.COMPANYCODE and B.ADVANCETYPE=C.ADVANCETYPE ORDER BY ADVAMOUNT, ADVDESC DESC";
					//out.print(qry);
				    	rs=db.getRowset(qry);
					if(rs.next())
					{
						mSno++;
						%>
						<tr bgcolor="<%=TRCOLOR%>">
						<td nowrap align=left><a Title="Click to Approve <%=rs.getString("STAFF")%>'s Advance Request" href='AdvanceRequestApprovalDetail.jsp?RID=<%=rs.getString("RID")%>&amp;DiffPath=<%=rs.getString("DiffPath")%>&amp;EID=<%=rs.getString("MEMBERID")%>&amp;WFCODE=<%=mWFCode%>&amp;WFTYPE=<%=rs.getString("ADVTYPE")%>'><FONT COLOR=GREEN><%=rs.getString("STAFF")%> [<%=rs.getString("EMPCODE")%>]</FONT></a></td>
						<td nowrap align=Left><font color=<%=mColor%>><%=rs.getString("ADVDESC")%></font></td>
						<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("ADVAMOUNT")%></font></td>
						<%
						if(!rs.getString("APPROVEDSTATUS").trim().equals("A"))
						{
							%>
							<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s UnApproved Advance Request" target=_New href='AdvanceRequestStatus.jsp?RID=<%=rs.getString("RID")%>&amp;EID=<%=rs.getString("MEMBERID")%>&amp;WFCODE=<%=mWFCode%>&amp;WFTYPE=<%=rs.getString("ADVTYPE")%>'><FONT COLOR=BLUE>Not Approved</FONT></a></td>
							<%
						}
						else
						{
							%>
							<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s Approved Advance Request" target=_New href='AdvanceRequestStatus.jsp?RID=<%=rs.getString("RID")%>&amp;EID=<%=rs.getString("MEMBERID")%>&amp;WFCODE=<%=mWFCode%>&amp;WFTYPE=<%=rs.getString("ADVTYPE")%>&amp;APRFLAG=100&amp;APRSTAT=A'><FONT COLOR=GREEN>Approved</FONT></a></td>
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
			CurrRID=mGetPARID;
			if(CurrRID.indexOf("=")>=0)
			{
				lenDfPath=CurrRID.length();
				posDfPath=CurrRID.indexOf("=");
				mDiffPathRID=CurrRID.substring(0,posDfPath);
				mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
				CurrRID=mDiffPathRID;
			}

			qry="Select Distinct '"+mDiffPath+"' DiffPath, B.RequestID RID, B.MEMBERID MEMBERID, nvl(A.EMPLOYEENAME,' ') STAFF, A.EMPLOYEECODE EMPCODE, B.ADVANCETYPE ADVTYPE, B.ADVANCETYPE||' ('||C.ADVANCEDESC||')' ADVDESC, ADVANCEAMOUNT ADVAMOUNT,";
			qry=qry+" nvl(B.APPROVEDSTATUS,' ')APPROVEDSTATUS FROM V#STAFF A, PAY#EMPOTHERADVANCEREQUEST B, PAY#ADVANCETYPEMASTER C where ";
			qry=qry+" A.EMPLOYEEID=B.MEMBERID and B.COMPANYCODE='"+mComp+"' and B.INSTITUTECODE='"+mInst+"' and B.REQUESTID='"+CurrRID+"'";
			qry=qry+" and B.COMPANYCODE=C.COMPANYCODE and B.ADVANCETYPE=C.ADVANCETYPE ORDER BY ADVAMOUNT, ADVDESC DESC";
			//out.print(qry);
		    	rs=db.getRowset(qry);
			if(rs.next())
			{
				mSno++;
				%>
				<tr bgcolor="<%=TRCOLOR%>">
				<td nowrap align=left><a Title="Click to Approve <%=rs.getString("STAFF")%>'s Advance Request" href='AdvanceRequestApprovalDetail.jsp?RID=<%=rs.getString("RID")%>&amp;DiffPath=<%=rs.getString("DiffPath")%>&amp;EID=<%=rs.getString("MEMBERID")%>&amp;WFCODE=<%=mWFCode%>&amp;WFTYPE=<%=rs.getString("ADVTYPE")%>'><FONT COLOR=GREEN><%=rs.getString("STAFF")%> [<%=rs.getString("EMPCODE")%>]</FONT></a></td>
				<td nowrap align=Left><font color=<%=mColor%>><%=rs.getString("ADVDESC")%></font></td>
				<td nowrap align=center><font color=<%=mColor%>><%=rs.getString("ADVAMOUNT")%></font></td>
				<%
				if(!rs.getString("APPROVEDSTATUS").trim().equals("A"))
				{
					%>
					<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s UnApproved Advance Request" target=_New href='AdvanceRequestStatus.jsp?RID=<%=rs.getString("RID")%>&amp;EID=<%=rs.getString("MEMBERID")%>&amp;WFCODE=<%=mWFCode%>&amp;WFTYPE=<%=rs.getString("ADVTYPE")%>'><FONT COLOR=BLUE>Not Approved</FONT></a></td>
					<%
				}
				else
				{
					%>
					<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s Approved Advance Request" target=_New href='AdvanceRequestStatus.jsp?RID=<%=rs.getString("RID")%>&amp;EID=<%=rs.getString("MEMBERID")%>&amp;WFCODE=<%=mWFCode%>&amp;WFTYPE=<%=rs.getString("ADVTYPE")%>&amp;APRFLAG=100&amp;APRSTAT=A'><FONT COLOR=GREEN>Approved</FONT></a></td>
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
		<Table width=100% align=left><tr><td align=left nowrap>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<Font color="#f00000" size=3 face="arial black">You Have <Font color="Blue" size=3 face="arial black"><%=mSno%></font> Advance Request to Approve...</font></td></tr>
		<tr><td></td></tr></table><br>
		<%
	}
	else
	{
		%>
		<Table width=100% align=left><tr><td align=left nowrap>&nbsp; &nbsp; &nbsp;<Font color="#f00000" size=3 face="arial black">You Have <Font color="Blue" size=3 face="arial black">No</font> New Advance Request to Approve...</font></td></tr></table><br>
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
	//out.print(e);
}
%>
</body>
</html>