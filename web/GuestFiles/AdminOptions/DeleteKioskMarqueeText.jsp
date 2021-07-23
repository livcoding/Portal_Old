<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="", qry2="";

int mSNO=0;
String mMemberID="";
String mMemberType="",mInst="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";

String mMText="", mMType="", mDate1="", mDate2="";
long mMLevel=0;
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

	if (request.getParameter("MTEXT").toString().trim()==null)
	{
		mMText="";
	}
	else
	{	
		mMText=request.getParameter("MTEXT").toString().trim();
	}

	if (request.getParameter("MTYPE").toString().trim()==null)
	{
		mMType="";
	}
	else
	{
		mMType=request.getParameter("MTYPE").toString().trim();
	}

	mMLevel=Long.parseLong(request.getParameter("MLEVEL").toString().trim());
//out.print(mMLevel);
if (request.getParameter("INST").toString().trim()==null)
	{
		mInst="";
	}
	else
	{
		mInst=request.getParameter("INST").toString().trim();
	}

	if (request.getParameter("MDATE1").toString().trim()==null)
	{
		mDate1="";
	}
	else
	{
		mDate1=request.getParameter("MDATE1").toString().trim();
	}

	if (request.getParameter("MDATE2").toString().trim()==null)
	{
		mDate2="";
	}
	else
	{
		mDate2=request.getParameter("MDATE2").toString().trim();
	}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Delete Webkiosk Marquee Text]</TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("")) 
	{
	mDMemberCode=enc.decode(mMemberCode);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('101','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
			if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
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

//--------------------------------------
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Delete Marquee Message</b></font></td>
</tr>
</TABLE>
<%
qry="Update KIOSKMARQUEETEXT set Active='N' where APPLICABLEFOR='"+mMType+"' and MSGPRIORITY='"+mMLevel+"' and to_char(DISPLAYFROM,'DD-MM-YYYY')='"+mDate1+"' and to_char(DISPLAYTILL,'DD-MM-YYYY')='"+mDate2+"' and nvl(ACTIVE,'Y')='Y'";
//MSGPRIORITY='', 
int r=db.update(qry);
// Log Entry
	  		   //-----------------
			    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Deactive KioskMarqueeText", "Applicable For : "+mMType+" Display From :"+ mDate1+"Upto"+mDate2, "No MAC Address" , mIPAddress);
			   //-----------------
//out.print(qry);
if(r>0)
{
response.sendRedirect("KioskMarqueeText.jsp");
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='RED'>Marquee Message already deactive!</font> <br>");
	%>
		<table><tr><td colspan=0 align=center><a href="KioskMarqueeText.jsp"><u><font size=4>Back </font></td></tr></table>
	<%
}	
 //-----------------------------
  //-- Enable Security Page Level  
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
}
%>
</body>
</html>