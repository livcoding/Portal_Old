<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="", mComp="";
String mRID="",mEID="",mWFCode="",mWFType="",mAdvAmount="", mAdvDesc="", mDateOfAdv="", mPurposeOfRequest="";
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

if (session.getAttribute("INSTITUTECODE")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("INSTITUTECODE").toString().trim();
}

if (session.getAttribute("COMPANYCODE")==null)
{
	mComp="JIIT";
}
else
{
	mComp=session.getAttribute("COMPANYCODE").toString().trim();
}

if (request.getParameter("RID")==null)
{
	mRID="";
}
else
{	
	mRID=request.getParameter("RID").toString().trim();
}

if (request.getParameter("EID")==null)
{
	mEID="";
}
else
{	
	mEID=request.getParameter("EID").toString().trim();
}

if (request.getParameter("WFCODE")==null)
{
	mWFCode="";
}
else
{	
	mWFCode=request.getParameter("WFCODE").toString().trim();
}

if (request.getParameter("WFTYPE")==null)
{
	mWFType="";
}
else
{	
	mWFType=request.getParameter("WFTYPE").toString().trim();
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


	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	  
		qry="Select WEBKIOSK.ShowLink('171','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
			%>
			<form name="frm"  method="get">
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Advance Request Status</b></font></td></tr>
			</TABLE>
			<br>
			<%
			String mEName="", mECode="", mDateOfReq="";
			qry="Select nvl(A.EMPLOYEENAME,' ') STAFF, A.EMPLOYEECODE EMPCODE, B.ADVANCETYPE||' ('||C.ADVANCEDESC||')' ADVDESC, B.ADVANCEAMOUNT ADVAMOUNT, nvl(B.REQUESTREMARKS,' ') POA,";
			qry=qry+" to_char(ADVANCEDATE,'DD-MM-YYYY')ADATE, to_char(REQUESTDATE,'DD-MM-YYYY')RDATE FROM V#STAFF A, PAY#EMPOTHERADVANCEREQUEST B, PAY#ADVANCETYPEMASTER C where B.COMPANYCODE='"+mComp+"' and B.INSTITUTECODE='"+mInst+"'";
			qry=qry+" and A.EMPLOYEEID=B.MEMBERID and A.EMPLOYEEID='"+mEID+"' and B.REQUESTID='"+mRID+"' and B.ADVANCETYPE='"+mWFType+"'";
			qry=qry+" and B.COMPANYCODE=C.COMPANYCODE and B.ADVANCETYPE=C.ADVANCETYPE ORDER BY ADVAMOUNT, ADVDESC DESC";
			//out.print(qry);
		    	rs=db.getRowset(qry);
			if(rs.next())
			{
				mEName=rs.getString("STAFF");
				mECode=rs.getString("EMPCODE");
				mAdvDesc=rs.getString("ADVDESC");
				mAdvAmount=rs.getString("ADVAMOUNT");
				mPurposeOfRequest=rs.getString("POA");
				mDateOfReq=rs.getString("RDATE");
				mDateOfAdv=rs.getString("ADATE");
				
			}
			%>
			<TABLE rules=none cellSpacing=0 cellPadding=0 border=2 align=center>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Staff Name </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mEName%> [<%=mECode%>]</Font></td></tr>
			<tr><td colspan=3>&nbsp;</td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Advance Type </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mAdvDesc%></Font></td></tr>
			<tr><td colspan=3>&nbsp;</td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Advance Amount </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mAdvAmount%></Font></td></tr>
			<tr><td colspan=3>&nbsp;</td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Date of Advance </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mDateOfAdv%></Font></td></tr>
			<tr><td colspan=3>&nbsp;</td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Date of Request </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mDateOfReq%></Font></td></tr>
			<tr><td colspan=3>&nbsp;</td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Purpose of Request </B></td><td><b>&nbsp; : &nbsp;</B></td><td> </Font><FONT Color=Navy face=arial size=2><%=mPurposeOfRequest%></Font></td></tr>
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
}
%>
</body>
</html>