<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subjectwise Students List ] </TITLE>
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
	document.frm.x.value='ddd';
	}
	//-->
    </script>

<script>
<!--
  if(window.history.forward(1) != null)
  window.history.forward(1);
-->
</script>
</HEAD>
<%
String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="";
String mMCode="";
String mEMCode="";
String mPageTitle="";
String mDPageTitle="";
String mNewTitle="";
String mENewTitle="";
String mOldTitle="";
DBHandler db=new DBHandler();
ResultSet rs=null;
String mWebEmail="",mInst="";
String mMemCD="";

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
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
%>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;

// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();


if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;


if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//----------------------------------

//-------------------------------
//-- Enable Security Page Level  
//-------------------------------
	qry="Select WEBKIOSK.ShowLink('67','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))     
	{
//----------------------
				 mMemCD=enc.decode(session.getAttribute("MemberCode").toString().trim());
	
				mEMCode=request.getParameter("ORACD").toString().trim();
				mOldTitle=request.getParameter("OLDTITLE").toString().trim();
				mInst=request.getParameter("INSTITUTECODE").toString().trim();
	
	 				if (request.getParameter("NewTitle")==null || request.getParameter("NewTitle").equals(""))		
					{
						mNewTitle="";
						mENewTitle="";
					}
					else
					{
						mNewTitle=request.getParameter("NewTitle").toString().trim();
						mENewTitle=enc.encode(mNewTitle);
					}
					if(!mNewTitle.equals(""))
					{
						mENewTitle=GlobalFunctions.replaceSignleQuot(mENewTitle);
						qry="update MEMBERMASTER set PAGEHEADING='"+mENewTitle+"' where ORACD='"+mEMCode+"' and nvl(DEACTIVE,'N')='N'";
						//out.print(qry);
						int n=db.update(qry);
						if(n>0)						  
						{
						%>
						<hr><table align=center> <tr><td >
						<font size=3 face='Arial' color='Green'><b>Title changed successfully...</b></font>
						</td></tr></table>
						<hr>
						<table align=center rules=groups border=0 >
						<tr><td valign=top>
						<font size=3 face='Arial' ><br>Old Title is :&nbsp; &nbsp;<%=mOldTitle%></td></tr>
						<tr><td>
						<font size=3 face='Arial'<br>New Title is :&nbsp; &nbsp;<%=mNewTitle%>
						</td></tr></table>
						<%

			    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"CHANGE MEMBER WEBPAGE TITLE", "Member Code : "+mMemCD, "No MAC Address" , mIPAddress);
						}
						else
						{
						 out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp<b><font size=3 face='Arial' color='Red'>Error while changing New Title</b></center>");
						}
					  
					}   // ---------- closing of mNewTitle
					else 
					{
					   out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Enter New Heading/Title</font></b></center>");
					%>
					<P align=center><a href="WebPageTitle.jsp"><font color=Red size=5> Back </font></u></a></p>

					<%	
					  }
		
				
 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	}
	else
	{
   	%>
	<br><font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br><br><br>
  	<%
	}
  //-----------------------------
}
else
{
out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp'>Login</a> to continue</font> <br>");
}
%>
<br><br><br><br><br><br><br><table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		</td></tr></table>
</BODY>
</HTML>