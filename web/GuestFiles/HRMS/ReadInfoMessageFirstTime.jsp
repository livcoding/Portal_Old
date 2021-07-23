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
String mInst="",mReqID="", mFactType="", mWFCode="";
String mEmpID="", mEmpName="", mEmpCode="", mEmpDegs="", mEmpDept="", mEmpCtgy="";

if (request.getParameter("RID")==null)
	mReqID="";
else
	mReqID=request.getParameter("RID").toString().trim();

if (request.getParameter("WFS")==null)
	mWFSeq=0;
else
	mWFSeq=Integer.parseInt(request.getParameter("WFS").toString().trim());

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
		if(mDMemberType.equals("E"))
		{
			mFactType="I";
		}
		else
		{
			mFactType="E";
		}
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
			qry="Update MESSAGEFORME SET MSGFLAG='R' where MEMBERID='"+mDMemberID+"' AND MEMBERTYPE='"+mFactType+"' AND REQUESTID='"+mReqID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' And WFSEQUENCE="+mWFSeq+"";
			int n=db.update(qry);	
			//out.print(qry);

			qry="SELECT DISTINCT WORKFLOWCODE WFC from MESSAGEFORME WHERE MEMBERID='"+mDMemberID+"' AND MEMBERTYPE='"+mFactType+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND REQUESTID='"+mReqID+"'";
			RsChk=db.getRowset(qry);
			//out.print(qry);
			if(RsChk.next())
			{
				mWFCode=RsChk.getString("WFC");
			}
			if(mWFCode.equals("LEAVE"))
			{
				qry="SELECT DISTINCT EMPLOYEEID EID, to_char(STARTDATE,'DD-MM-YYYY')SDATE, to_char(ENDDATE,'DD-MM-YYYY')EDATE from LEAVEREQUEST WHERE REQUESTID='"+mReqID+"'";
			}
			else if(mWFCode.equals("OUTNOC"))
			{
			}
			RsChk=db.getRowset(qry);
			if(RsChk.next())
			{
				mEmpID=RsChk.getString("EID");
				mSDate=RsChk.getString("SDATE");
				mEDate=RsChk.getString("EDATE");
			}
			qry="SELECT nvl(EMPLOYEENAME,' ')ENAME, nvl(DESIGNATIONCODE,' ')EDEGS, nvl(DEPARTMENTCODE,' ')EDEPT, nvl(EMPLOYEECODE,' ')ECODE, nvl(EMPCATEGORYCODE,' ')ECTGY from EMPLOYEEMASTER WHERE EMPLOYEEID='"+mEmpID+"' AND COMPANYCODE='"+mComp+"'";
			RsChk=db.getRowset(qry);
			if(RsChk.next())
			{
				mEmpName=RsChk.getString("ENAME");
				mEmpCode=RsChk.getString("ECODE");
				mEmpDegs=RsChk.getString("EDEGS");
				mEmpDept=RsChk.getString("EDEPT");
				mEmpCtgy=RsChk.getString("ECTGY");
			}
			qry="SELECT A.WORKFLOWCODE WFC, A.WORKFLOWTYPE WFT, nvl(B.WFLEVEL,0) WFL, nvl(A.APPROVEDREQVALUE,' ')AVAL, to_char(A.APPROVALDATETIME,'DD-MM-YYYY')ADATE, DECODE(A.STATUS,'A','Approved','C','Cancelled','UnApproved/Pending') STATUS FROM MESSAGEFORME A, WF#WORKFLOWDETAIL B ";
			qry=qry+" WHERE A.MEMBERID='"+mDMemberID+"' AND A.MEMBERTYPE='"+mFactType+"' AND A.REQUESTID='"+mReqID+"' AND A.COMPANYCODE='"+mComp+"' AND A.INSTITUTECODE='"+mInst+"' AND A.WFSEQUENCE='"+mWFSeq+"'";
			qry=qry+" AND A.REQUESTID=B.REQUESTID AND A.COMPANYCODE=B.COMPANYCODE AND A.INSTITUTECODE=B.INSTITUTECODE AND A.WORKFLOWCODE=B.WORKFLOWCODE AND A.WORKFLOWTYPE=B.WORKFLOWTYPE AND A.DEPARTMENTCODE=B.DEPARTMENTCODE AND A.WFSEQUENCE=B.WFSEQUENCE";
		 	//out.print(qry);
			RsChk= db.getRowset(qry);
			%>
			<BR><BR><BR><font size=3 color='#4f5f' Face='Verdana'><b>
			<%
			if(RsChk.next())
		   	{
				%>
				<font size=3 color='Navy' Face='ARIAL'>&nbsp; &nbsp; Member Name :  <%=mMemberName%> &nbsp; (<%=mDMemberCode%>)</font><br><BR>
				<hr>
				&nbsp; &nbsp; Staff Name :  <%=mEmpName%> &nbsp; (<%=mEmpCode%>)<br>
				&nbsp; &nbsp; RequestID :<%=mReqID%><br>
				&nbsp; &nbsp; Workflow Code :<%=RsChk.getString("WFC")%>
				&nbsp; &nbsp; Workflow Type :<%=RsChk.getString("WFT")%><br>
				&nbsp; &nbsp; <%=RsChk.getString("WFC")%> Period From <%=mSDate%> to <%=mEDate%> [<%=RsChk.getString("AVAL")%> Day(s)] <br>
				&nbsp; &nbsp; Workflow Level Processed: <%=RsChk.getString("WFL")%>&nbsp; &nbsp; &nbsp; &nbsp; Dated : <%=RsChk.getString("ADATE")%><br>
				&nbsp; &nbsp; <font size=3 color='Blue'>Request Status : <%=RsChk.getString("STATUS")%></font>
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