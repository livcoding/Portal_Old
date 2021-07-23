<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet Rs=null;
ResultSet rs=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String mWebEmail="", mInst="", mComp="";
String mRightsID="179";
String QryWFCode="";

if (session.getAttribute("WebAdminEmail")==null)
	mWebEmail="";
else
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();

if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();

if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();

if(request.getParameter("WFC")==null)
	QryWFCode="";
else
	QryWFCode=request.getParameter("WFC").toString().trim();	
	
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Page Wise Message Detail ] </TITLE>
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
	
	if(!mMemberID.equals("") && !mMemberCode.equals(""))
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
		//----------------------
		  	%>
			<form name="frm" method="post">
			<input id="x" name="x" type=hidden>
			<input id="WFC" name="WFC" type=hidden value="<%=QryWFCode%>">

			<table align=center width="103%" bottommargin=0 topmargin=0 leftmargin=0 rightmargin=0>
<!-------------Page Heading and Marquee Message----------------------->
			<%
			try
			{
				String mPageHeader="Advance Request", mMarqMsg="", CurrDate="";
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
				qry="Select nvl(B.PAGEHEADER,'Advance Request')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mPageHeader=rs.getString("PageHeader");
					%>
					<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=QryWFCode%> <%=mPageHeader%> </FONT></u></b></font></td></tr>
					<%
				}
				else
				{
					%>
					<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=QryWFCode%> <%=mPageHeader%> </FONT></u></b></font></td></tr>
					<%
				}
			}
			catch(Exception e)
			{}
			%>
<!-------------Page Heading and Marquee Message----------------------->
			</table></center><br>

			<br>
			<table ALIGN=CENTER cellspacing=5 cellpadding=5 Bordercolor="#de6400" bottommargin=5 topmargin=5 border=2 rules=group>
			<tr bgcolor="#de6400"><TD colspan=0 align=middle><font color="White" style="FONT-SIZE: small; FONT-FAMILY: fantasy"><b>Available Options</b></font></td></tr>
			<%
			if(QryWFCode.equals("LEAVE"))
			{
				qry="Select WEBKIOSK.ShowLink('173','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Click to Get Self Leave Request Detail"  href='LeaveWF/PendingLeaveRequest.jsp'><FONT face="Arial" size=2 color=Blue>Self Leave Status</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('142','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				//out.print(qry);
			      Rs = db.getRowset(qry);
			      if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Leave Request - By an Individual" href='LeaveWF/LeaveRequestSelf.jsp'><FONT face="Arial" color=Blue size=2>Leave Request</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('174','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				//out.print(qry);
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Modify Leave Request" href='LeaveWF/ModifyLeaveRequest.jsp'><FONT face="Arial" color=Blue size=2>Leave Modify</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('165','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
			      Rs = db.getRowset(qry);
			      if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Cancel Leave Request " href='LeaveWF/CancelLeaveRequest.jsp'><FONT face="Arial" color=Blue size=2>Leave Cancel</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('148','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Work Flow wise Leave Request Approval By  Granted Authority" href='LeaveWF/LeaveRequestInbox.jsp'><FONT face="Arial"  color=Blue size=2>Leave Approval</font></a>
					</b></font></td></tr>
					<%
				}
			}
			else if(QryWFCode.equals("NOC"))
			{
				qry="Select WEBKIOSK.ShowLink('162','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="NOC Request" href='NOCWF/RequestforNOC.jsp'><FONT face="Arial" color=blue size=2>NOC Request</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('177','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Modify NOC Request" href='NOCWF/EditRequestNOC.jsp'><FONT face="Arial" color=blue size=2>NOC Modify</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('178','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Cancel NOC Request" href='NOCWF/RequestNOCCancel.jsp'><FONT face="Arial" color=blue size=2>NOC Cancel</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('163','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Approval NOC Request" href='NOCWF/ApprovalforNOC.jsp'><FONT face="Arial" color=blue size=2>NOC Approval</font></a>
					</b></font></td></tr>
					<%
				}
			}
			else if(QryWFCode.equals("ADVANCE"))
			{
				qry="Select WEBKIOSK.ShowLink('170','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Advance Request" href='AdvanceWF/AdvanceRequestEntry.jsp'><FONT face="Arial" color=Blue  size=2>Advance Request</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('175','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Modify Advance Request" href='AdvanceWF/AdvanceRequestEdit.jsp'><FONT face="Arial" color=Blue  size=2>Advance Edit</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('176','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Cancel Advance Request" href='AdvanceWF/AdvanceRequestCancel.jsp'><FONT face="Arial" color=Blue  size=2>Advance Cancel</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('171','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Work Flow wise Advance Request Approval By Granted Authority" href='AdvanceWF/AdvanceRequestInbox.jsp'><FONT face="Arial" color=Blue size=2>Advance Approval</font></a>
					</b></font></td></tr>
					<%
				}
			}
			else if(QryWFCode.equals("LTC"))
			{
				qry="Select WEBKIOSK.ShowLink('5','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="LTC Request" href='LTCWF/LTCRequestEntry.jsp'><FONT face="Arial" color=Blue  size=2>LTC Request</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('182','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Modify LTC Request" href='LTCWF/LTCRequestEdit.jsp'><FONT face="Arial" color=Blue  size=2>LTC Edit</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('181','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Cancel LTC Request" href='LTCWF/LTCRequestCancel.jsp'><FONT face="Arial" color=Blue  size=2>LTC Cancel</font></a>
					</b></font></td></tr>
					<%
				}

				qry="Select WEBKIOSK.ShowLink('180','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
				Rs = db.getRowset(qry);
				if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
					%>
					<tr><TD colspan=0 align=middle><b>
					<a target="DetailSection" title="Work Flow wise LTC Request Approval By Granted Authority" href='LTCWF/LTCRequestInbox.jsp'><FONT face="Arial" color=Blue size=2>LTC Approval</font></a>
					</b></font></td></tr>
					<%
				}
			}
			%>
			</table>
			</form>
			<%
		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		}
 		else
   		{
		%>
		<br>
		<font color=red>
		<h3><br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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
}//try end
catch(Exception e)
{
}
%>
<br><br>
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