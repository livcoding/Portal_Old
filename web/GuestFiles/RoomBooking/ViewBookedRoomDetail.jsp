<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="";
int ctr=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="",mfactype="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mBookedBy="", mRoomType="", mRoomTyp="", mRoomCode="", mRoomNo="", mReqDate="";
String mRoomFrDt="", mRoomToDt="", mRoomFrTm="", mRoomToTm="", mBookPurp="";
String mExam="";
String mName1="",mName2="",mName3="",mName4="",mName5="";
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
 
if (request.getParameter("ROOMTYPE").toString().trim()==null)
{
	mRoomType="";
}
else
{	
	mRoomType=request.getParameter("ROOMTYPE").toString().trim();
}

if (request.getParameter("ROOMCODE").toString().trim()==null)
{
	mRoomCode="";
}
else
{	
	mRoomCode=request.getParameter("ROOMCODE").toString().trim();
}

if (request.getParameter("BOOKEDBY").toString().trim()==null)
{
	mBookedBy="";
}
else
{	
	mBookedBy=request.getParameter("BOOKEDBY").toString().trim();
}

if (request.getParameter("RDATE").toString().trim()==null)
{
	mReqDate="";
}
else
{	
	mReqDate=request.getParameter("RDATE").toString().trim();
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Booked Room Detail ] </TITLE>
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
	  
		qry="Select WEBKIOSK.ShowLink('145','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>View Booked Room Detail</b></font></td></tr>
			</TABLE>
			<br>
			<%
			String mEnm="";
			qry="select EmployeeName from EmployeeMaster where EmployeeID='"+mBookedBy+"'";
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mEnm=rs1.getString(1);
			}
			qry="select nvl(ROOMDESC,' ')RNo from ROOMMASTER where ROOMCODE='"+mRoomCode+"'";
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mRoomNo=rs1.getString(1);
			}
			qry="select nvl(ROOMTYPEDESC,' ')RType from ROOMTYPE where ROOMTYPE='"+mRoomType+"'";
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mRoomTyp=rs1.getString(1);
			}
			%>				<tr bgcolor='#e68a06'>

			<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 bordercolor="#00008b" align=center>
			<form name="frm1" ID="frm1" method=post>
			<%
				if(mDMemberType.equals("E"))
					 mfactype="I";	
				else if(mDMemberType.equals("V"))
					 mfactype="E";

				qry="select nvl(A.ROOMCODE,' ')RC, nvl(A.BOOKINGPURPOSE,' ' )BP, to_char(A.BOOKINGDATETIME,'DD-MM-YYYY')RD,";
				qry=qry+" to_char(A.BOOKINGFROMDATE,'DD-MM-YYYY')BDF, to_char(A.BOOKINGUPTODATE,'DD-MM-YYYY')BDT, ";
				qry=qry+" to_char(A.BOOKINGFROMTIME,'HH:MI PM')BTF, to_char(A.BOOKINGUPTOTIME,'HH:MI PM')BTT,";
				qry=qry+" nvl(A.CANCELLATIONSTATUS,'N')CanStat, nvl(B.ROOMDESC,' ')ROOMDESC, nvl(B.ROOMTYPE,' ')ROOMTYPE, nvl(B.ROOMFOR,' ')ROOMFOR, nvl(C.Employeename,' ')EmpName,";
				qry=qry+" nvl(C.EmployeeID,' ')EmpID From ROOMBOOKINGINFO A, ROOMMASTER B, EMPLOYEEMASTER C Where ";
				qry=qry+" NVL(A.DEACTIVE,'N')='N' AND A.ROOMCODE=B.ROOMCODE AND NVL(B.DEACTIVE,'N')='N' AND C.EMPLOYEEID=A.BOOKEDBY";
				qry=qry+" and B.RoomType=Decode('"+mRoomType+ "','ALL',B.ROOMTYPE,'"+mRoomType+"')";
				qry=qry+" and B.RoomCode=Decode('"+mRoomCode+ "','ALL',B.ROOMCODE,'"+mRoomCode+"')";
				qry=qry+" and A.BookedBy=Decode('"+mBookedBy+ "','ALL',A.BOOKEDBY,'"+mBookedBy+"')";
				qry=qry+" and (trunc(A.BOOKINGDATETIME))=trunc(to_date('"+mReqDate+"','dd-mm-yyyy')) ORDER BY BDF, BTF, BDT, BTT DESC";
				rs=db.getRowset(qry);
				//out.print(qry);
				if(rs.next())
				{
					mRoomFrDt=rs.getString("BDF");
					mRoomToDt=rs.getString("BDT");
					mRoomFrTm=rs.getString("BTF");
					mRoomToTm=rs.getString("BTT");
					mReqDate=rs.getString("RD");
					mBookPurp=rs.getString("BP");
					%>
					<tr>
					<td bgcolor='#e68a06'><Font color="lightyellow"><B>Booking Period</B></font></td>
					<td nowrap><%=mRoomFrDt%> To <%=mRoomToDt%> [ <%=mRoomFrTm%> - <%=mRoomToTm%> ]</td>
					</tr>	
					<tr>
					<td bgcolor='#e68a06'><Font color="lightyellow"><B>Room Type</font></B></td>
					<td><%=GlobalFunctions.toTtitleCase(mRoomTyp)%></td>
					</tr>	
					<tr>
					<td bgcolor='#e68a06'><Font color="lightyellow"><B>Room No</B></font></td>
					<td><%=mRoomNo%></td>
					</tr>	
					<tr>
					<td bgcolor='#e68a06'><Font color="lightyellow"><B>Room For</B></font></td>
					<td><%=rs.getString("ROOMFOR")%></td>
					</tr>	
					<tr>
					<td bgcolor='#e68a06'><Font color="lightyellow"><B>Booking Purpose</B></font></td>
					<td><%=mBookPurp%></td>
					</tr>
					<tr>
					<td bgcolor='#e68a06'><Font color="lightyellow"><B>Booking Date</B></font></td>
					<td><%=mReqDate%></td>
					</tr>	
					<tr>
					<td bgcolor='#e68a06'><Font color="lightyellow"><B>Booked By</B></font></td>
					<td><%=mEnm%></td>
					</tr>	
					<%
				}
			%>
			</form>
			</TABLE>
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
}
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