<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
int mSno=0, TotInboxItem=0;
String qry="",qry1="";
String mColor="Green",mComp="",TRCOLOR="White",mWebEmail="";
String mMemberID="", mDMemberID="", mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="", mMemberName="";
String mInst="", myFlag="0";
String mFactType="";
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

String mTime="";
qry="Select to_char(Sysdate,'DD-Mon-yyyy HH:MI:SS PM') mTime from Dual";
rs=db.getRowset(qry);
if (rs.next())
	mTime=rs.getString("mTime");
else
	mTime="";

String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
  mHead=session.getAttribute("PageHeading").toString().trim();
else
  mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Alert/Message Window ] </TITLE>
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
<p align=right>
<font color=darkbrown size=2 face='verdana' size=2><b>Mesage/Alert Last Refresh Date Time: <%=mTime%></b></font>
</p>
<center>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
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
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	
		 	 //----------------------

			qry="SELECT A.WORKFLOWCODE WFC, A.WORKFLOWTYPE WFT, A.REQUESTID RID, A.WFSEQUENCE WFS, B.WFLEVEL WFL, to_char(A.APPROVALDATETIME,'DD-MM-YYYY')ADATE, DECODE(A.STATUS,'A','Approved','C','Cancelled',' ') STATUS FROM MESSAGEFORME A, WF#WORKFLOWDETAIL B ";
			qry=qry+" WHERE A.MEMBERID='"+mDMemberID+"' AND A.MEMBERTYPE='"+mFactType+"' AND nvl(A.MSGFLAG,'N')='N' AND A.COMPANYCODE='"+mComp+"' AND A.INSTITUTECODE='"+mInst+"' AND nvl(A.DEACTIVE,'N')='N'";
			qry=qry+" AND A.REQUESTID=B.REQUESTID AND A.COMPANYCODE=B.COMPANYCODE AND A.INSTITUTECODE=B.INSTITUTECODE AND A.WORKFLOWCODE=B.WORKFLOWCODE AND A.WORKFLOWTYPE=B.WORKFLOWTYPE AND A.DEPARTMENTCODE=B.DEPARTMENTCODE AND A.WFSEQUENCE=B.WFSEQUENCE";
			rs=db.getRowset(qry);
			//out.print(qry);
			while(rs.next())
			{
				if(myFlag.equals("0"))
				{
					myFlag="1";
					%>
					<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Information Message Regarding Other's Request(s) Approval/Cancellation</B></font>
					<table border=1 bordercolor='silver' bgcolor='white'  cellpadding=0 cellspacing=0 width='50%'>
					<tr bgcolor='Green'>
					<td nowrap align=center><FONT COLOR=WHITE face=verdana size=2><B>Workflow Code</b></font></td>
					<td nowrap align=center><FONT COLOR=WHITE face=verdana size=2><B>Workflow Type</b></font></td>
					<td nowrap align=center><FONT COLOR=WHITE face=verdana size=2><B>Request ID</b></font></td>
					<td nowrap align=center><FONT COLOR=WHITE face=verdana size=2><B>Workflow Level</b></font></td>
					<td nowrap align=center title="Date of Approval/Cancellation of this Level"><FONT COLOR=WHITE face=verdana size=2><B>Date of Process</b></font></td>
					<td nowrap align=center><FONT COLOR=WHITE face=verdana size=2><B>Status</b></font></td>
					</tr>
					<%
				}
				%>
				<tr>
				<td nowrap> &nbsp; <Font face=verdana size=2><%=rs.getString("WFC")%></font></td>
				<td nowrap> &nbsp; <Font face=verdana size=2><%=rs.getString("WFT")%></font></td>
				<td nowrap align=center><A Title="Click to View Leave Request" target="_New" href='../HRMS/ReadInfoMessageFirstTime.jsp?RID=<%=rs.getString("RID")%>&amp;WFS=<%=rs.getInt("WFS")%>'><FONT COLOR=BLUE face=verdana size=2><%=rs.getString("RID")%></FONT></a>
				<td nowrap align=center><font face=verdana size=2><%=rs.getString("WFL")%></font></td>
				<td nowrap align=center><font face=verdana size=2><%=rs.getString("ADATE")%></font></td>
				<td nowrap><font face=verdana size=2><%=rs.getString("STATUS")%></font></td>
				</tr>	
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}  
}
catch(Exception e)
{
 
}

%>
<br>
<table align=center><tr><td align=left><br><br><br><br>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp"><br>
<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 		
</body>
</Html>
