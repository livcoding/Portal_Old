<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>  
<%  
	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	FrameLeftStudent.JSP		[For Students]			   *
	' * Author:		Ashok Kumar Singh 						         *
	' * Date:		20th Oct 2006	 							   *
	' * Version:	1.0										   *	
	' **********************************************************************************************************
	*/

String qry="";
String pInstCode="TIET";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
ResultSet Rs =null;
String mMemberID="", mMemberType="", mRole="",mIPAddress="", mPCompCode="";

try
{
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
	if (session.getAttribute("ROLENAME")==null)
	{
		mRole="";
	}
	else
	{
		mRole=session.getAttribute("ROLENAME").toString().trim();
	}
	if (session.getAttribute("IPADD")==null)
	{
		mIPAddress="";
	}
	else
	{
		mIPAddress=session.getAttribute("IPADD").toString().trim();
	}
	if (session.getAttribute("ParentCompanyCode")==null)
	{
		mPCompCode="";
	}
	else
	{
		mPCompCode=session.getAttribute("ParentCompanyCode").toString().trim();
	}
%>
<HTML>
<HEAD>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<style type="text/css">
<!--
BODY{
scrollbar-face-color:#fce9c5;
scrollbar-arrow-color:darkpink;
scrollbar-track-color:darkpink;
scrollbar-shadow-color:'';
scrollbar-highlight-color:'';
scrollbar-3dlight-color:'';
scrollbar-darkshadow-Color:'';
}
-->
</style>
<style type="text/css">
.menutitle{
cursor:pointer;
margin-bottom: 4px;
background-color:#fce9c5;
color:#c00000;
width:110px;
padding:1px;
text-align:Left;
font-weight:bold;
/*/*/border:1px solid #000000;/* */
}

.submenu
{
	margin-bottom: 0.5em;
}
</style>

<script type="text/javascript">

/***********************************************
* Switch Menu scriptby Martial B of http://getElementById.com/
* Modified by Dynamic Drive for format & NS4/IE4 compatibility
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

var persistmenu="yes" //"yes" or "no". Make sure each SPAN content contains an incrementing ID starting at 1 (id="sub1", id="sub2", etc)
var persisttype="sitewide" //enter "sitewide" for menu to persist across site, "local" for this page only

if (document.getElementById){ //DynamicDrive.com change
document.write('<style type="text/css">\n')
document.write('.submenu{display: none;}\n')
document.write('</style>\n')
}
function SwitchMenu(obj)
{
	if(document.getElementById)
	{
		var el = document.getElementById(obj);
		var ar = document.getElementById("masterdiv").getElementsByTagName("span"); //DynamicDrive.com change
		if(el.style.display != "block")
		{
			 //DynamicDrive.com change
			for (var i=0; i<ar.length; i++)
			{
				if (ar[i].className=="submenu") //DynamicDrive.com change
				ar[i].style.display = "none";
			}
			el.style.display = "block";
		}
		else
		{
			el.style.display = "none";
		}
	}
}

function get_cookie(Name)
{ 
	var search = Name + "="
	var returnvalue = "";
	if (document.cookie.length > 0)
	{
		offset = document.cookie.indexOf(search)
		if (offset != -1)
		{ 
			offset += search.length
			end = document.cookie.indexOf(";", offset);
			if (end == -1) end = document.cookie.length;
			returnvalue=unescape(document.cookie.substring(offset, end))
		}
	}
	return returnvalue;
}

function onloadfunction()
{
	if (persistmenu=="yes")
	{
		var cookiename=(persisttype=="sitewide")? "switchmenu" : window.location.pathname
		var cookievalue=get_cookie(cookiename)
		if (cookievalue!="")
			document.getElementById(cookievalue).style.display="block"
	}
}

function savemenustate()
{
	var inc=1, blockid=""
	while (document.getElementById("sub"+inc))
	{
		if (document.getElementById("sub"+inc).style.display=="block")
		{
			blockid="sub"+inc
			break
		}
		inc++
	}
	var cookiename=(persisttype=="sitewide")? "switchmenu" : window.location.pathname
	var cookievalue=(persisttype=="sitewide")? blockid+";path=/" : blockid
	document.cookie=cookiename+"="+cookievalue
}

if (window.addEventListener)
	window.addEventListener("load", onloadfunction, false)
else if (window.attachEvent)
	window.attachEvent("onload", onloadfunction)
else if (document.getElementById)
	window.onload=onloadfunction

if (persistmenu=="yes" && document.getElementById)
	window.onunload=savemenustate
</script>

<script language="Javascript1.1"> 	 
function UnLoadWindows()
{		
	alert("For better security you must close this window....");		
	top.close();
	window.open("../CommonFiles/SignOut.jsp");	 
} 
</script>
</HEAD>
<BODY vLink=#00000b link=#00000b bgcolor="#de6400" leftMargin=1 topMargin=0 marginheight="0" marginwidth="0" >
<%
if(!mMemberID.equals("") || !mMemberType.equals(""))
{
	mMemberID=enc.decode(mMemberID);
	mMemberType=enc.decode(mMemberType);
	mRole=enc.decode(mRole);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------

	qry="Select WEBKIOSK.ShowLink('189','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	//out.print(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
		%>
		<TABLE cellSpacing=0 width="100%" align=center bgcolor="#de6400" valign="top" >
		<TR><TD nowrap align=center><FONT color=lightyellow size=2 face=verdana><STRONG>Available options</STRONG></FONT>
		<br><img height=2 src="../Images/ColorBar.gif" width=110><br><br>
		</td></tr>
		<tr>
		<td>
		<!-Keep all menus within masterdiv-->
		<div id="masterdiv">
		<div class="menutitle" onclick="SwitchMenu('sub1')">Personal Info.&nbsp;<img src="../Images/arrow.gif"></div>
		<span class="submenu" id="sub1">
		<%
		qry="Select WEBKIOSK.ShowLink('1','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
		//out.print(qry);
		Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Personal Information" href="PersonalInfo\GuestPersonalInfo.jsp"><FONT face="Arial" color =white size=2>Personal Detail</font></a><br>
			<%
		}

		qry="Select WEBKIOSK.ShowLink('48','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
		Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			<!--<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Change eMailID/Contact Numbers" href="PersonalInfo/GuestModifyEmailIDTelephone.jsp"><FONT face="Arial" color =white size=2>Edit Info.</font></a><br>-->
			<%
		}
	qry="Select WEBKIOSK.ShowLink('9','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
     if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Message for Me" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Inbox</font></a><br>		

	<%
	}
	%>
 </span>

   <!--<div class="menutitle" onclick="SwitchMenu('sub4')">Journals Info.&nbsp;<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub4">-->
	<%
	qry="Select WEBKIOSK.ShowLink('13','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  title="Post New Research work/Journals" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Post Journal</font></a><br>
	<%
	}	
	qry="Select WEBKIOSK.ShowLink('14','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  title="Modify Research work/Journals" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Modify Journals</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('15','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  title="View Research work/Journals" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>View Journals</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('16','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Seminar Attended history posting" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Write Seminar</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('17','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Seminar attended detail" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>View Seminar</font></a><br>
	<%
	}
	%>
   </span>
   <div class="menutitle" onclick="SwitchMenu('sub5')">Academic info <img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub5">
       <%
       qry="Select WEBKIOSK.ShowLink('601','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	//out.print(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="List of Attendance taken by all Faculty" href="../EmployeeFiles/AcademicInfo/EmployeeAttendanceListALL.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>All Batch Attend</FONT></A></br>
		<%
	}

	%>
   </span>
    <div class="menutitle" onclick="SwitchMenu('sub7')">Admin Option <img src="../Images/arrow.gif"></div>
    <span class="submenu" id="sub7">
	<%
	qry="Select WEBKIOSK.ShowLink('0','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Signup in bulk (create LoginID for New Students)" href="../CommonFiles/SignUpStudents.jsp"><FONT face="Arial" color=white size=2>Bulk Signup of<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</FONT>Student</font></a><br>
	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('70','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Signup Member(create LoginID for Employee/Student/Visiting Staff/Guest one by one) " href="../CommonFiles/SignUp.jsp"><FONT face="Arial" color=white size=2>Signup Member</FONT></a><br>
	<!--<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Undelivered Student ID & Password for Student" href="AdminOptions/UndeliveredIdOnEmail.jsp"><FONT face="Arial" color=white size=2>Undelivered ID</font></a><br>-->
	<%
	}

	qry="Select WEBKIOSK.ShowLink('38','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Change Role of Employee" href="AdminOptions/ChangeEmpRole.jsp"><FONT face="Arial" color=white size=2>Change Role</FONT></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('39','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	//out.print(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Reset Password of any Member " href="AdminOptions/ResetPasswordForciblyNew.jsp"><FONT face="Arial" color=white size=2>Reset Password</FONT></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('67','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Assign/Reset Employee KIOSK Page Heading/Title " href="AdminOptions/WebPageTitle.jsp"><FONT face="Arial" color=white size=2>Webpage Title</FONT></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('68','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Deactive WebKiosk Member" href="AdminOptions/DeactiveWebkioskMember.jsp"><FONT face="Arial" color =white size=2>Lock/Unlock ID</font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('81','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Locked WebKiosk Member List" href="AdminOptions/ListLockedMember.jsp"><FONT face="Arial" color =white size=2>Locked Members</font></a><br>	
	<%
	}
	
	qry="Select WEBKIOSK.ShowLink('101','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Change WebKiosk Marquee Text" href="AdminOptions/KioskMarqueeText.jsp"><FONT face="Arial" color =white size=2>Change Marquee</font></a><br>	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('90','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Employee Information (Department wise)" href="../CommonFiles/DeptwiseEmpViewEmpInfo.jsp"><FONT face="Arial" color =white size=2>Department wise<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Employee Info.</font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('72','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Employee Information" href="../CommonFiles/EmpViewEmpInfo.jsp"><FONT face="Arial" color =white size=2>Employee Info</font></a><br>	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('71','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Students Information" href="../CommonFiles/EmpViewStdInfo.jsp"><FONT face="Arial" color =white size=2>Student Info</font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('246','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	//out.print(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Modified Grade Approval" href="../EmployeeFiles/ExamActivity/ApproveChangedStudGrade.jsp"><FONT face="Arial" color=white size=2>Approve Changed<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Grade</font></a><br>
		<%
	}

	qry="Select WEBKIOSK.ShowLink('602','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	//out.print(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
                <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Employee Attendance Detail" href="../EmployeeFiles/AdminOptions/EmployeeAttendanceDetail.jsp"><FONT face="Arial" color =white size=2>Staff Attendance</font></a><br>
		<%
	}
      
	%>

   </span>

</td>
</tr>
<!--<TD><img src="../Images/bull.gif">&nbsp;<A title="FAQ" href="../FAQ/FAQEmployee.HTML" target=_New><FONT face="Arial" color =white size=2><STRONG>FAQ</STRONG></FONT></A></TD></TR></FONT></FONT>--> 
<%
qry="Select WEBKIOSK.ShowLink('46','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
Rs = db.getRowset(qry);
if (Rs.next() && Rs.getString("SL").equals("Y"))
{
%>
</tr>
<tr>
	<td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Change Password" href="../CommonFiles/ChangePassword.jsp" title="Change password" target="DetailSection"><FONT face="Arial" size =2 color=white><STRONG>Change PIN</STRONG></FONT></A></TD>
</tr>
<%
}
%>

<tr>
<!--<td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Secret Question" href="../CommonFiles/AskSecretQuestion.jsp" target="DetailSection"><FONT face="Arial" size =2 color=white><STRONG>Secret Question</STRONG></FONT></A></TD>-->
</tr>

<tr>
	<td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Logout/Signout" href="javascript:UnLoadWindows();" onClick()="javascript:self.window.close();"><FONT face="Arial" size =2 color=white><STRONG>Logout</STRONG></FONT></A></td>
</tr>
</TBODY></TABLE>
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
	<h3>	<br><img src='../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
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
//out.print(e.getMessage());
}
%>
</BODY></HTML>
