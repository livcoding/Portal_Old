<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
int mWFSeq=0;
String qry="";
String mComp="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mSDate="", mEDate="";
String mInst="",mrid="", mFactType="", mWFCode="";
String mEmpID="", mEmpName="", mEmpCode="", mEmpDegs="", mEmpDept="", mEmpCtgy="";


if (session.getAttribute("CompanyCode")==null)
	mComp="JIIT";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("InstituteCode")==null)
	mInst="JIIT";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();

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

if (session.getAttribute("mrid")==null)
	mrid="";
else
	mrid=session.getAttribute("mrid").toString().trim();



if (request.getParameter("mrid")==null)
	mrid="";
else
	mrid=request.getParameter("mrid").toString().trim();



%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Read Information Message First Time ] </TITLE>
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
			qry="Update MESSAGESLIST SET DEACTIVE='Y'  where  trim(MSGFROMUSERD)||trim(MSGFROMMEMBERTYPE)||trim(to_char(MSGDATETIME,'yyyymmddhh24missss'))='"+mrid+"'";
			int n=db.update(qry);
				out.print(qry);
			response.sendRedirect("GetINBOXMessage.jsp");
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3><br><img src='../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br><P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br><br><br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{	
	//out.print("Exception e"+qry);	
}
%>
</form>
</body>
</html>