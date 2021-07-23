<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mReqID="";

if (request.getParameter("RID")==null)
	mReqID="";
else
	mReqID=request.getParameter("RID").toString().trim();

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
<TITLE>#### <%=mHead%> [ Read Leave Request Status First Time ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
	<script language=javascript>
		if(window.history.forward(1) != null)
			window.history.forward(1);	
	</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>

<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin="0" topmargin="0">
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

		qry="Select WEBKIOSK.ShowLink('164','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			qry="Update LEAVEREQUEST Set READFLAG='Y' where COMPANYCODE='"+mComp+"' And REQUESTID='"+mReqID+"' And EMPLOYEEID='"+mDMemberID+"'";			 
			int n=db.update(qry);	
 	
			qry="select EMPCATEGORYCODE, LEAVECODE, to_char(STARTDATE,'dd-MM-yyyy') SDate, to_char(ENDDATE,'DD-MM-YYYY') EDate, nvl(PAID,0) PAID, nvl(WITHOUTPAY,0) WITHOUTPAY, nvl(ABSENT,0) ABSENT, LEAVEYEARCODE, nvl(PURPOSEOFLEAVE,'N/A') PURPOSEOFLEAVE, nvl(STATUS,'D') STATUS ";
			qry=qry + " From LEAVEREQUEST  Where COMPANYCODE='"+mComp+"' And REQUESTID='"+mReqID+"' And EMPLOYEEID='"+mDMemberID+"'";			 
			 
			RsChk= db.getRowset(qry);
			%>
			<font size=3 color='#4f5f' Face='Verdana'><b>
			<%
			if(RsChk.next())
		   	{
				%>
				Member Name :  <%=mMemberName%> &nbsp; (<%=enc.decode(mMemberCode)%>) &nbsp; &nbsp; &nbsp;
				Member Category : <%=RsChk.getString("EMPCATEGORYCODE")%><br>
				<hr>
				RequestID :<%=mReqID%><br>
				Leave Code :<%=RsChk.getString("LEAVECODE")%>
				Leave Period From <%=RsChk.getString("SDate")%> to <%=RsChk.getString("EDate")%> <br>
				No. of Paid Leave(s): <%=RsChk.getString("PAID")%>&nbsp; &nbsp; &nbsp; &nbsp; UnPaid/LWP : <%=RsChk.getString("WITHOUTPAY")%> and Absent (if any): <%=RsChk.getString("ABSENT")%><br>
				Purpose of Leave <%=RsChk.getString("PURPOSEOFLEAVE")%><br>
				<%
				if (RsChk.getString("STATUS").equals("A"))
				{
					%>
					<font color=Green size=3 face=Verdana><b>Request Status : Approved</b></font>
					<%
				}
				else if (RsChk.getString("STATUS").equals("C"))
				{
					%>
					<font color=Red size=3 face=Verdana><b>Request Status : Cancelled</b></font>
					<%
				}
				else
				{
					%>
					<font color=Blue size=3 face=Verdana><b>Request Status : UnApproved/Pending</b></font>
					<%
				}
				%>
				<hr>
				<b></font>
				<%
			}
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3><br><img src='../../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br><P>This page is not authorized/available for you.
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
	out.print("Exception e"+qry);	
}
%>
</form>
</body>
</html>