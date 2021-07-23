<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		mHead=session.getAttribute("PageHeading").toString().trim();
	else
		mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [View Room Time Preference]</TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<%
try
{
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet RS1=null;

GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="", qry2="";
int ctr=0;
String mMemberID="",mFSTID="",mLTP="";
String mMemberType="",mEID="";
String mDMemberType="", mcolor="Black";
String mMemberCode="", mFaculty="", mFacCode="", mEvent="",mFacid="",mSEMEID="";
String mDMemberCode="",mexam="",mSubject="",mFac="";
String mMemberName="",mSubjectid="", mSubjectcode="",mExamCode="";
String mEXAMCODE1="",mFacultyId1="",mSUBJECTCODE1="",mSub="",mClass="",mClasstype="";
String mPREFTIMEFROM="",mPREFTIMETO="",mREQROOMTYPE="",mPREFDAY="";
String mInst="JIIT";

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

	if (request.getParameter("EC").toString().trim()==null)
	{
		mExamCode="";
	}
	else
	{
		mExamCode=request.getParameter("EC").toString().trim();
	}

	if (request.getParameter("SBJ").toString().trim()==null)
	{
		mSubjectcode="";
	}
	else
	{
		mSubjectcode=request.getParameter("SBJ").toString().trim();
	}
		
	if (request.getParameter("EID").toString().trim()==null)
	{
		mEID="";
	}
	else
	{
		mEID=request.getParameter("EID").toString().trim();
	}

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
	qry="Select WEBKIOSK.ShowLink('51','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

//--------------------------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>

<table width="90%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>View Room Time Preference</b></font></td>
</tr>

</TABLE>
		<input type=hidden name="INST" id="INST" value="<%=mInst%>">
		<input type=hidden name="EXAMCODE" id="EXAMCODE" value="<%=mExamCode%>"> 
		<input type=hidden name="FacultyId" id="FacultyId" value="<%=mEID%>"> 
 		<input type=hidden name="SUBJECTCODE" id="SUBJECTCODE" value="<%=mSubjectcode%>">
<%
qry="select nvl(EmployeeName,' ')EN, nvl(EmployeeCode,' ')FC from EmployeeMaster where EmployeeID='"+mChkMemID+"' and nvl(Deactive,'N')='N'";
rs=db.getRowset(qry);
while(rs.next())
{
mFaculty=rs.getString("EN");
mFacCode=rs.getString("FC");
}
/*
qry=" Select Distinct nvl(A.subjectcode,' ') subjectcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject";
qry=qry+" from  PR#FACULTYDAYTIMEPREFERENCE A,Subjectmaster B where A.EXAMCODE='"+mExamCode+"' and A.Subjectcode=B.Subjectcode"; 
*/
qry=" Select Distinct nvl(A.subjectid,' ') subjectid,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject";
qry=qry+" from  PR#FACULTYDAYTIMEPREFERENCE A,Subjectmaster B where A.EXAMCODE='"+mExamCode+"' and A.subjectid=B.subjectid "; 

rs=db.getRowset(qry);
if(rs.next())
{
mSub=rs.getString("subject");
}
%>
<table align=center rules=groups border=3>
<tr><td colspan=4>
<font color="#00008b" face=arial size=2><STRONG>Member&nbsp;: &nbsp;</STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mFaculty%>[<%=mFacCode%>]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td><FONT color="#00008b" face=Arial size=2><STRONG>Subject Code&nbsp;: &nbsp;</STRONG><%=mSub%></FONT></td></tr>
</table>

<table bgcolor=#fce9c5 bottommargin=0 rules=group/s topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
	
	<tr bgcolor="#ff8c00">
	<td><font color="white"><b>SNo.</b></font></td>
	<td align=left>&nbsp; <font color="white"><b>Day</b></font></td>
	<td align=center><table>
	<tr><td colspan=2 align=center><font color="white"><b>Pref. Time</b></font></td></tr>
	<tr><td align=center><font color="white"><b>From</b></font>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
	<td align=left><font color="white"><b>To</b></font></td></tr>
	</table></td>
	<td align=center><font color="white"><b>Pref. <br>Room Type</b></font></td>
	</tr>
	
<%
	qry="select Distinct decode(PREFDAY,'MON','Monday','TUE','Tuesday','WED','Wednessday','THU','Thrusday','FRI','Friday','SAT','Saturday','SUN','Sunday')PREFDAY,";
	qry=qry+" decode(PREFDAY,'MON',1,'TUE',2,'WED',3,'THU',4,'FRI',5,'SAT',6,'SUN',7)PREFDAY2, nvl(rtrim(PREFFROMTIME),'No Pref.')PREFFROMTIME, ";
	qry=qry+" nvl(rtrim(PREFTOTIME),'No Pref.')PREFTOTIME, decode(ltrim(rtrim(REQROOMTYPE)),'LT','Lecture Theater 1','LT2','Lecture Theater 2','PR','Projector Room','TR','Tutorial Room','CL','Class Room','No Pref.')REQROOMTYPE ";
	qry=qry+" from PR#FACULTYDAYTIMEPREFERENCE where examcode='"+mExamCode+"' and facultyid='"+mEID+"' ";
	qry=qry+" and SUBJECTid='"+mSubjectcode+"' and nvl(Deactive,'N')='N' order by PREFDAY2";
	//out.print(qry);
	rs1=db.getRowset(qry);
    
	while(rs1.next())
	{
		ctr++; 
	  	mPREFDAY=rs1.getString("PREFDAY");
		mPREFTIMEFROM=rs1.getString("PREFFROMTIME");
		mPREFTIMETO=rs1.getString("PREFTOTIME");
		mREQROOMTYPE=rs1.getString("REQROOMTYPE");
		%>
		<tr>
			<td>&nbsp;&nbsp;<font color="#00008b"><%=ctr%></font>.</td>
			<td><font color="#00008b"><b><%=mPREFDAY%></b></font></td>
			<%
			if(rs1.getString("PREFFROMTIME").equals("No Pref."))
				mcolor="brown";
			else
				mcolor="black";
			%>
			<td><table><tr>
			<td align=left><font color=<%=mcolor%>><%=mPREFTIMEFROM%></font> &nbsp; &nbsp;</td>
			<%
			if(rs1.getString("PREFTOTIME").equals("No Pref."))
				mcolor="brown";
			else
				mcolor="black";
			%>
			<td align=right><font color=<%=mcolor%>><%=mPREFTIMETO%></font></td>
			<%
			if(rs1.getString("REQROOMTYPE").equals("No Pref."))
				mcolor="brown";
			else
				mcolor="black";
			%>
			</tr></table></td>
			<td><font color=<%=mcolor%>>&nbsp; &nbsp;<%=mREQROOMTYPE%></font></td>
		</tr>
		<%
	}
		%>				
		</table></form>
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
<br><br><br><br><br>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		</td></tr></table>
</body>
</html>