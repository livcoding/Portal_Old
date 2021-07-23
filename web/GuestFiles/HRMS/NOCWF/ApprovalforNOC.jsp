<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
try
{
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String qry="";
ResultSet rs=null;
String mHead="",mMemberCode="";
String mDMemberID="";
String mDMemberCode="";
String mDMemberType="";
String mInst="";

String mMemberID="",mCompanyCode="",mDepartmentCode="";
String mMemberType="",mMemberName="";
String mGetPLRID="";
String mEmpType="";
		String qrys="",mRightsID="162";
		ResultSet rss=null;
		String mPrint="",mPrintS="";
		int len=0,pos=0;
String mRID="",mFlag="";

	int lenReq=0,posReq=0;
	int lenDfPath=0,posDfPath=0;
	String CurrRID="",RestRID="";
	String  mDiffPathRID="",mDiffPath="";

int ctr=0;

int mSno=0;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
{
	mHead=session.getAttribute("PageHeading").toString().trim();
}
else
{
	mHead="JIIT ";
}
if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("DepartmentCode")==null)
{
	mDepartmentCode="";
}
else
{
	mDepartmentCode=session.getAttribute("DepartmentCode").toString().trim();
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
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Request for NOC ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
	if(window.history.forward(1)!=null)
	window.history.forward(1);	
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
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
%>
	<table align=center width="100%" bottommargin=0 topmargin=0>
	<%
	try
			{
				String mPageHeader="NOC Work Flow For Approval/Cancellation", mMarqMsg="", CurrDate="";
				qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					CurrDate=rs.getString("CurrDate");
				}
				qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightsID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mMarqMsg=rs.getString("MarqMsg");
					%>
					<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
					<%
				}
				qry="Select nvl(B.PAGEHEADER,'NOC Work Flow For Approval/Cancellation')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
				rs=db.getRowset(qry);
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
	</table>
	
<%
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('162','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";
			
qry="select EMPLOYEETYPE EmpType from V#STAFF WHERE COMPANYCODE='"+mCompanyCode+"' AND EMPLOYEEID='"+mChkMemID+"' ";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mEmpType=rs.getString("EmpType");
	}

	qry="Select 	 	 nvl(WEBKIOSK.GetPendingDuesNOCRequestIDEMP('"+mCompanyCode+"','"+mInst+"','"+mChkMemID+"','"+mEmpType+"'),'Zero') GetPLRID from dual";
	rs=db.getRowset(qry);
	
	if(rs.next() && !rs.getString("GetPLRID").equals("Zero"))
	{
		mGetPLRID=rs.getString("GetPLRID");
		
	%>
<BR><table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center>
		<thead>
		<tr bgcolor="#ff8c00">
			<td align=left  nowrap><font color=white><B>Staff</B></font></td>
			<td align=left  nowrap><font color=white><B>Reporting Date</B></font></td>
			<td align=left  nowrap><font color=white><B>Date of Relieving</B></font></td>
			<td align=center  nowrap><font color=white><B>Type</B></font></td>
			<td align=center nowrap ><font color=white><B> Notice days</B></font></td>
			<td align=center  nowrap Title="See Approval Status"><b><font color="white"></font><font color="white">Status</font></b></td>
		</tr>
		</thead>
		<tbody>
	<%
	//	08020000004=N#08020000012=N#08020000013=N

if(mGetPLRID.indexOf("#")>0)
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
	qrys="select nvl(B.EMPLOYEENAME,' ')EMPLOYEENAME,nvl(A.EMPLOYEEID,' ')EMPLOYEEID,nvl(A.TYPE,' ')TYPE,nvl(to_char(A.REPORTINGDATE,'dd-mm-yyyy'),' ')REPORTINGDATE,nvl(to_char(A.DATEOFRELIEVING,'dd-mm-yyyy'),' ')DATEOFRELIEVING,nvl(A.NOTICEDAYS,0)NOTICEDAYS,nvl(A.NODUESSTATUS,' ')NODUESSTATUS from Employeeleaving A ,EMPLOYEEMASTER B where A.requestid in ('"+CurrRID+"') AND A.EMPLOYEEID=B.EMPLOYEEID and  NVL(B.DEACTIVE,'N')='N' ";
	rss=db.getRowset(qrys);
	while(rss.next())
	{
		mSno++;
%>
	<tr>
<td nowrap align=left><a Title="Click to Approve <%=rss.getString("EMPLOYEENAME")%>'s NOC Request" href='NOCRequestApprovalDetail.jsp?RID=<%=CurrRID%>&amp;DiffPath=<%=mDiffPath%>'><FONT COLOR=GREEN><%=rss.getString("EMPLOYEENAME")%></FONT></a></td>
<td align=center><%=rss.getString("REPORTINGDATE")%></td>
<td align=center><%=rss.getString("DATEOFRELIEVING")%></td>
<%
	if(rss.getString("TYPE").equals("R"))
		mPrint="Resign";
	%>
	<td align=center><%=mPrint%></td>
	<td align=center><%=rss.getInt("NOTICEDAYS")%></td>
	<%
	if(rss.getString("NODUESSTATUS").equals("D"))
		mPrintS="Pending";
	else if(rss.getString("NODUESSTATUS").equals("A"))
		mPrintS="Approved";
	else
		mPrintS="Cancelled";
	%>
	<td align=center><%=mPrintS%></td>
	</tr>
<%
	}  // closing of while

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

				qrys="select nvl(B.EMPLOYEENAME,' ')EMPLOYEENAME,nvl(A.EMPLOYEEID,' ')EMPLOYEEID,nvl(A.TYPE,' ')TYPE,nvl(to_char(A.REPORTINGDATE,'dd-mm-yyyy'),' ')REPORTINGDATE,nvl(to_char(A.DATEOFRELIEVING,'dd-mm-yyyy'),' ')DATEOFRELIEVING,nvl(A.NOTICEDAYS,0)NOTICEDAYS,nvl(A.NODUESSTATUS,' ')NODUESSTATUS from Employeeleaving A ,EMPLOYEEMASTER B where A.requestid in ('"+CurrRID+"') AND A.EMPLOYEEID=B.EMPLOYEEID and  NVL(B.DEACTIVE,'N')='N' ";
	rss=db.getRowset(qrys);
	while(rss.next())
	{
		mSno++;
%>
	<tr>
<td nowrap align=left><a Title="Click to Approve <%=rss.getString("EMPLOYEENAME")%>'s NOC Request" href='NOCRequestApprovalDetail.jsp?RID=<%=CurrRID%>&amp;DiffPath=<%=mDiffPath%>'><FONT COLOR=GREEN><%=rss.getString("EMPLOYEENAME")%></FONT></a></td>
<td align=center><%=rss.getString("REPORTINGDATE")%></td>
<td align=center><%=rss.getString("DATEOFRELIEVING")%></td>
<%
	if(rss.getString("TYPE").equals("R"))
		mPrint="Resign";
	%>
	<td align=center><%=mPrint%></td>
	<td align=center><%=rss.getInt("NOTICEDAYS")%></td>
	<%
	if(rss.getString("NODUESSTATUS").equals("D"))
		mPrintS="Pending";
	else if(rss.getString("NODUESSTATUS").equals("A"))
		mPrintS="Approved";
else
		mPrintS="Cancelled";
	%>
	<td align=center><%=mPrintS%></td>
	</tr>
<%
	}  // closing of while
					break;
			}  // closing of if(mGetPLRID.indexOf("#")<0)
	} // closing of while 1==1
}
else
{  //--1
			CurrRID=mGetPLRID;
			if(CurrRID.indexOf("=")>=0)
				{
						lenDfPath=CurrRID.length();
						posDfPath=CurrRID.indexOf("=");
						mDiffPathRID=CurrRID.substring(0,posDfPath);
						mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
						CurrRID=mDiffPathRID;
				}
			qrys="select nvl(B.EMPLOYEENAME,' ')EMPLOYEENAME,nvl(A.EMPLOYEEID,' ')EMPLOYEEID,nvl(A.TYPE,' ')TYPE,nvl(to_char(A.REPORTINGDATE,'dd-mm-yyyy'),' ')REPORTINGDATE,nvl(to_char(A.DATEOFRELIEVING,'dd-mm-yyyy'),' ')DATEOFRELIEVING,nvl(A.NOTICEDAYS,0)NOTICEDAYS,nvl(A.NODUESSTATUS,' ')NODUESSTATUS from Employeeleaving A ,EMPLOYEEMASTER B where A.requestid in ('"+CurrRID+"') AND A.EMPLOYEEID=B.EMPLOYEEID and  NVL(B.DEACTIVE,'N')='N' ";
	rss=db.getRowset(qrys);
	while(rss.next())
	{
		mSno++;
%>
	<tr>
<td nowrap align=left><a Title="Click to Approve <%=rss.getString("EMPLOYEENAME")%>'s NOC Request" href='NOCRequestApprovalDetail.jsp?RID=<%=CurrRID%>&amp;DiffPath=<%=mDiffPath%>'><FONT COLOR=GREEN><%=rss.getString("EMPLOYEENAME")%></FONT></a></td>
<td align=center><%=rss.getString("REPORTINGDATE")%></td>
<td align=center><%=rss.getString("DATEOFRELIEVING")%></td>
<%
	if(rss.getString("TYPE").equals("R"))
		mPrint="Resign";
	%>
	<td align=center><%=mPrint%></td>
	<td align=center><%=rss.getInt("NOTICEDAYS")%></td>
	<%
	if(rss.getString("NODUESSTATUS").equals("D"))
		mPrintS="Pending";
	else if(rss.getString("NODUESSTATUS").equals("A"))
		mPrintS="Approved";
else
		mPrintS="Cancelled";
	%>
	<td align=center><%=mPrintS%></td>
	</tr>
<%
	}  // closing of while
}  //--1


}  // closing of if(rs.next() && !rs.getString("GetPLRID").equals("Zero"))
if(mSno>0)
{
		%>
		<Table width=100% align=left><tr><td align=left nowrap>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<Font color="#f00000" size=3 face="arial black">You Have <Font color="Blue" size=3 face="arial black"><%=mSno%></font> NOC Request to Approve...</font></td></tr>
		<tr><td></td></tr></table><br>
		<%
	}
	else
	{
		%>
		<Table width=100% align=left><tr><td align=left nowrap>&nbsp; &nbsp; &nbsp;<Font color="#f00000" size=3 face="arial black">You Have <Font color="Blue" size=3 face="arial black">No</font> New NOC Request to Approve...</font></td></tr></table><br>
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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>  
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
//out.print(e);
}
%>
</body>
</html>

