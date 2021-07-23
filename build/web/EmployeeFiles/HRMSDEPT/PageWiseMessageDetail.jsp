<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="",mComp="";
String mWebEmail="";
String mRights="",mMessage="",mRelate="",mMsgFrom="",mMsgTo="",mEventTo="",mEventFrom="";
String mStudent="",mEmployee="",mStaff="",mRightsInfo="";

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
if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (request.getParameter("InstCode")==null)
{
	mInst="";
}
else
{	
	mInst=request.getParameter("InstCode").toString().trim();
}

if(request.getParameter("RIGHTSID")==null)
{
	mRights="";
}
else
{
	mRights=request.getParameter("RIGHTSID").toString().trim();	
}
	
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

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInst=rs.getString(1);	
		else
			mInst="JIIT";
		
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	  
		qry="Select WEBKIOSK.ShowLink('169','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
		  	%>
			<form name="frm" method="post" >
			<input id="x" name="x" type=hidden>
		
			<table width="100%" ALIGN=CENTER bottommargin=1  topmargin=1>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Page Wise Message Detail</b></font></td></tr>
			</TABLE>
			<%
			qry="SELECT nvl(A.RIGHTSID,0)RIGHTS,NVL(A.MARQUEEMESSAGE,' ')MARQUEE,NVL(B.RIGHTSINFO,' ')RIGHTSINFO,	decode(A.RELATEDTO,'E','Employee','S','Student','V','Visting Staff','EV','Employee,  Visting Staff','ES','Employee, Student','VS','Visting Staff, Student','SE','Student, Employee','SVE','Visting Staff, Employee, Student')RELATEDTO,nvl(to_char(A.EVENTFROMDATETIME,'dd-mm-yyyy'),' ')EVENTFROM, nvl(to_char(A.EVENTTODATETIME,'dd-mm-yyyy'),' ')EVENTTO, nvl(to_char(A.MESSAGEFLASHFROMDATETIME,'dd-mm-yyyy'),' ')MESSFROM,nvl(to_char(A.MESSAGEFLASHUPTODATETIME,'dd-mm-yyyy'),' ')MESSTO FROM PAGEBASEDMEESSAGES A,WEBKIOSKRIGHTSMASTER B where A.RIGHTSID=B.RIGHTSID AND A.RIGHTSID='"+mRights+"'"; 
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
					mRights=rs.getString("RIGHTS");
					mRightsInfo=rs.getString("RIGHTSINFO");
					mMessage=rs.getString("MARQUEE");
					mRelate=rs.getString("RELATEDTO");
					mEventFrom=rs.getString("EVENTFROM");
					mEventTo=rs.getString("EVENTTO");
					mMsgFrom=rs.getString("MESSFROM");
					mMsgTo=rs.getString("MESSTO");
			}
			%>
			<br>
			<TABLE  rules=none cellSpacing=1 cellPadding=3 border=1  align=center >
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Rights Information</B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><%=mRightsInfo%>&nbsp;&nbsp;<b>RightsID</b>&nbsp;[&nbsp;<%=mRights%>&nbsp;]</Font></td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Marquee Message </B></td><td><b>&nbsp; : </B></td><td> </Font><FONT Color=Black face=arial size=2><%=mMessage%></Font></td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Message View By </B></td><td><b>&nbsp; : </B></td><td> </Font><FONT Color=Black face=arial size=2><%=mRelate%></Font></td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Event Period  </B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><B>From&nbsp;&nbsp;&nbsp;(&nbsp;</b><%=mEventFrom%>&nbsp; <b>to &nbsp; </b><%=mEventTo%><b>&nbsp;)</b></Font></td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Marquee Message </B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><B>From&nbsp;&nbsp;&nbsp;(&nbsp;</b><%=mMsgFrom%>&nbsp; <b>to &nbsp; </b><%=mMsgTo%><b>&nbsp;)</b></Font></td></tr>
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
out.print(" Error is there!!!!");
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