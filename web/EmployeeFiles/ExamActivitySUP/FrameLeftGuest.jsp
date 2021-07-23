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
String mMemberID="", mMemberType="", mRole="",mIPAddress="", mPCompCode="", mDeptCode="";

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
	if (session.getAttribute("DepartmentCode")==null)
	{
		mDeptCode="";
	}
	else
	{
		mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
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
			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Change eMailID/Contact Numbers" href="PersonalInfo/GuestModifyEmailIDTelephone.jsp"><FONT face="Arial" color =white size=2>Edit Info.</font></a><br>
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
  <div class="menutitle" onclick="SwitchMenu('sub2')">HRMS &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<img src="../Images/arrow.gif"></div>
  <span class="submenu" id="sub2">
	<%	 

	qry="Select WEBKIOSK.ShowLink('169','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Leave Detail" target="DetailSection" href="HRMS/PageWiseMessageEntry.jsp"><FONT face="Arial" color =white size=2>Page wise msg</font></a><br>
	<%
	}


      if (mMemberID.equals("TIET-R00001"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Application form related vacancy/interview" target="_new" href='HRMS/Application/ApplicationForm.jsp'><FONT face="Arial" color =white size=2>Application</font></a><br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('141','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Man-power Indent for the concern department" target="DetailSection" href='HRMS/Application/ManPowerIndent.jsp'><FONT face="Arial" color =white size=2>Man-Power Req.</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('143','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Approval of Man-power Indent for the concern department" target="DetailSection" href='HRMS/Application/ManPowerIndentApproval.jsp'><FONT face="Arial" color =white size=2>Man-Power Req./ <font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Indent Approval</font></a><br>
	<%
	}

	 
	qry="Select WEBKIOSK.ShowLink('149','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Shortlist of Candidate(s)" target="DetailSection" href='HRMS/Application/ShortListApplicant.jsp'><FONT face="Arial" color =white size=2>Short List</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('144','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Surplus Employee Info. - By HOD" href='HRMS/Application/SurPlusEmpInfo.jsp'><FONT face="Arial" color=white size=2>SurplusEmployee<small></small></font></a><br>
	<%
	}

//--------------------------
	qry="Select WEBKIOSK.ShowLink('179','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	Rs = db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Advance Work Flow" href='HRMS/WorkFlowMenuOptions.jsp?WFC=ADVANCE'><FONT face="Arial" color=white size=2>Advance Workflow</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Leave Work Flow" href='HRMS/WorkFlowMenuOptions.jsp?WFC=LEAVE'><FONT face="Arial" color=white size=2>Leave Workflow</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Leave Travel Consession (LTC) Work Flow" href='HRMS/WorkFlowMenuOptions.jsp?WFC=LTC'><FONT face="Arial" color=white size=2>LTC Workflow</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="NOC Work Flow" href='HRMS/WorkFlowMenuOptions.jsp?WFC=NOC'><FONT face="Arial" color=white size=2>NOC Workflow</font></a><br>
	<%
	}
//--------------------------

	qry="Select WEBKIOSK.ShowLink('172','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	Rs = db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Work Flow Approval Level" href='HRMS/WorkFlowApprovalLevel.jsp?DEPTCODE=<%=mDeptCode%>'><FONT face="Arial" color=white size=2>Work Flow Level<small></small></font></a><br>
	<%
	}
	%>
 </span>
 <div class="menutitle" onclick="SwitchMenu('sub3')">SRS&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<img src="../Images/arrow.gif"></div>
 <span class="submenu" id="sub3">
	<%
	qry="Select WEBKIOSK.ShowLink('12','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View Submitted SRS for Printing Approval" target="DetailSection" href="SRS\SrsApprovalEmployee.jsp"><FONT face="Arial" color =white size=2>Allow SRS Print</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('78','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS Report Before Finalization" target="DetailSection" href="SRS\EmpSRSTeachRatingRepBeforeFinalized.jsp"><FONT face="Arial" color =white size=2>PreFinalizedSRS</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('47','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Finalization os SRS After Printing" target="DetailSection" href="SRS\FinalizedSRSAfterPrint.jsp"><FONT face="Arial" color =white size=2>SRS Finalization</font></a><br>
	<%
	}

	
	qry="Select WEBKIOSK.ShowLink('77','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="DateWise SRS" target="DetailSection" href="SRS\DateWiseSRSDetailRep.jsp"><FONT face="Arial" color =white size=2>DateWise SRS</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('40','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View Personal SRS Report (Summary-Overall Average)" target="DetailSection" href="SRS\EmpSRSTeachRatingRepInd.jsp"><FONT face="Arial" color =white size=2>Personal SRS<br><FONT face="Arial" color='#de6400' size=2>&nbsp;&nbsp;&nbsp;</font>Summary</font></a><br>
	<%
	}

      
	qry="Select WEBKIOSK.ShowLink('10','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{      
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS Report" target="DetailSection" href="SRS\EmpSRSTeachRatingRep.jsp"><FONT face="Arial" color =white size=2>SRS Summary</font></a><br>
	<%
	}
	//else
	//{
	  qry="Select WEBKIOSK.ShowLink('41','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
        Rs = db.getRowset(qry);
        if (Rs.next() && Rs.getString("SL").equals("Y"))
	  {
 	  %>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS Report (Department wise)" target="DetailSection" href="SRS\EmpSRSTeachRatingRepHOD.jsp"><FONT face="Arial" color =white size=2>Department wise <br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>SRS Summary</font></a><br>
	  <%
	  }
	//}

	qry="Select WEBKIOSK.ShowLink('55','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View Personal SRS detailed" target="DetailSection" href="SRS\EmpSRSTeachRatingDetailInd.jsp"><FONT face="Arial" color =white size=2>Self SRS Detail</font></a><br>	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('11','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS detailed" target="DetailSection" href="SRS\EmpSRSTeachRatingDetailRep.jsp"><FONT face="Arial" color =white size=2>All SRS Detail</font></a><br>	
	<%
	}
	else
	{
		qry="Select WEBKIOSK.ShowLink('54','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	Rs = db.getRowset(qry);
	      if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
	  	<img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS detailed Department wise" target="DetailSection" href="SRS\EmpSRSTeachRatingDetailHOD.jsp"><FONT face="Arial" color =white size=2>Department wise<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>SRS Detail</font></a><br>	
		<%
		}
	}
	

	qry="Select WEBKIOSK.ShowLink('49','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Datewise SRS Count" target="DetailSection" href=..SRS\SrsSubmitionCount.jsp><FONT face="Arial" color =white size=2>SRS Count</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('140','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Semester/Programwise Students SRS Count" target="DetailSection" href=..SRS\SrsDetailReport.jsp><FONT face="Arial" color =white size=2>Stud SRS Status</font></a><br>
	<%
	}

	

	qry="Select WEBKIOSK.ShowLink('79','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Total Sent/Left SRS Count" target="DetailSection" href=..SRS\SentLeftSRSList.jsp><FONT face="Arial" color =white size=2>Sent/Left Count</font></a><br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('69','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View Abusing Word Suggestion" target="DetailSection" href=..SRS\ViewSrsAbusingWord.jsp><FONT face="Arial" color =white size=2>Abused SRS</font></a><br>
	<%
	}
	
	qry="Select WEBKIOSK.ShowLink('104','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View SRS Rating Graph" href="SRS\GraphEmpSRSTeachRatingRep.jsp"><FONT face="Arial" color =white size=2>SRS Graphs</font></a><br>
	<%
	}

	%>
  </span>

   <div class="menutitle" onclick="SwitchMenu('sub4')">Journals Info.&nbsp;<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub4">
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

	qry="Select WEBKIOSK.ShowLink('127','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
//	out.print(qry);
        Rs = db.getRowset(qry);
        if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="_New" title="Counselling Seats Status (Refreshing Seats Window) " href="SeatStatus/CounsSeat.jsp"><FONT face="Arial" color=white size=2>Couns Seats</font></a><br>
	<%

	}

	qry="Select WEBKIOSK.ShowLink('128','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
        Rs = db.getRowset(qry);
        if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="_New" title="Students having completed Counselling (Scrolling Window)" href="StudentStatus/CounsStud.jsp"><FONT face="Arial" color =white size=2>Couns. Stud.</font></a><br>
	<%
	}
 


	int mok=0;
	qry="Select WEBKIOSK.ShowLink('105','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	mok=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A  href="AcademicInfo/TeachingLoad.jsp" title="View/Modify Teaching Load"  target="DetailSection"><FONT face="Arial" size =2 color=white>Teaching Load</FONT></A></br>
	<%
	}
	if (mok==0)
	{
		qry="Select WEBKIOSK.ShowLink('106','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
			<img src="../Images/bullet4.gif">&nbsp;<A  href="AcademicInfo/TeachingLoad.jsp" title="View/Modify Teaching Load"  target="DetailSection"><FONT face="Arial" size =2 color=white>Teaching Load</FONT></A></br>
		<%
		}
	 }



      qry="Select WEBKIOSK.ShowLink('82','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A  href="AcademicInfo/DailyStudentAttendanceEntry.jsp" title="Student Attendance Entry-for the current working Days/class only"  target="DetailSection"><FONT face="Arial" size =2 color=white>Attendance Entry</FONT></A></br>
		<img src="../Images/bullet4.gif">&nbsp;<A  href="AcademicInfo/DailyStudentAttendanceReport.jsp" title="Student wise Class percentage(%) Attendance " target="DetailSection"><FONT face="Arial" size =2 color=white>Student Attendance</FONT></A></br>
	<%
	}

     qry="Select WEBKIOSK.ShowLink('89','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Authorization/Permition to Grant Special Permition to take attendance of Students from Other Batches" href="StudAttendByOtherFacltyRequest.jsp" title="Subject Choice entry for the comming batch" target="DetailSection"><FONT face="Arial" size =2 color=white>Student Attend.<br><FONT face="Arial" color='#de6400' size=2> &nbsp;&nbsp;&nbsp;</font>by Other Faculty</FONT></A></br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('83','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Personal Class Attendance" href="AcademicInfo/EmployeeAttendanceListPersonal.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>My Batch Attend.</FONT></A></br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('84','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Department wise Class Attendance taken by the concerned Faculty" href="AcademicInfo/EmployeeAttendanceListHOD.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Deptwise Attend.</FONT></A></br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('87','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/ViewAttendanceSummary.jsp?SrcType=A" title="Subject wise Student percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Attendance Summary</FONT></A></br>
		<img src="../Images/bullet4.gif">&nbsp;<A title="List of Attendance taken by all Faculty" href="../EmployeeFiles/AcademicInfo/EmployeeAttendanceListALL.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>All Batch Attend</FONT></A></br>
	<%
	}
    qry="Select WEBKIOSK.ShowLink('235','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Student Cut-Off Attendance" href="../EmployeeFiles/AcademicInfo/StudentCutOffAttendance.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Cut-Off Attendance</FONT></A></br>
	<%
	}
	

	qry="Select WEBKIOSK.ShowLink('85','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="List of All Students in a particular Subject and Teacher " href="../EmployeeFiles/AcademicInfo/EmpSubjectStudentLoadViewDOAA.jsp" title="Subject Choice entry for the comming batch" target="_new"><FONT face="Arial" size =2 color=white>Facultywise <br><FONT face="Arial" color='#de6400' size=2>&nbsp;&nbsp;&nbsp;</font>Class List</FONT></A></br>

	<%
	}

	qry="Select WEBKIOSK.ShowLink('86','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Count of All Students in a particular Subject and Teacher " href="../EmployeeFiles/AcademicInfo/EmpSubjectStudentLoadCount.jsp" title="Total Count in a Section/Subsection against selected Subject" target="_new"><FONT face="Arial" size =2 color=white>Total Classes<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Count</FONT></A></br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('50','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject Choices Entry/Request" href="AcademicInfo/EmpSubjectChoiceEntry.jsp" title="Subject Choice entry for the comming batch" target="DetailSection"><FONT face="Arial" size =2 color=white>Subj. Preference</FONT></A></br>
		<%
	}

	qry="Select WEBKIOSK.ShowLink('110','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject's Room and Daywise Time Preference Entry/Request" href="AcademicInfo/EmpSubjectDateTimePrefEntry.jsp" target="DetailSection"><FONT face="Arial" size =2 color=white>Day/Time Pref.</FONT></A></br>
		<%
	}


	qry="Select WEBKIOSK.ShowLink('51','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject choice View" href="AcademicInfo/EmpSubjectChoiceView.jsp" title="Subject Choice entry for the comming batch" target="DetailSection"><FONT face="Arial" size =2 color=white>Selected/Opted<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Subjects in PR </FONT></A></br>	
		<%
	}

	int h=0;
	qry="Select WEBKIOSK.ShowLink('126','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		h=1;
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject choice View" href="AcademicInfo/EmpSbjChoiceNoChoices.jsp?Type=D" title="Subject Choice/No choices sent by Faculty" target="DetailSection"><FONT face="Arial" size =2 color=white>Faculty Choices</FONT></A></br>	
		<%
	}

	if(h==0)
	{
	qry="Select WEBKIOSK.ShowLink('125','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		h=1;
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject choice View" href="AcademicInfo/EmpSbjChoiceNoChoices.jsp?Type=H" title="Subject Choice/No choices sent by Faculty" target="DetailSection"><FONT face="Arial" size =2 color=white>Faculty Choices</FONT></A></br>	
		<%
	}
	}


	qry="Select WEBKIOSK.ShowLink('114','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registratiomn - Elective Subjects to be Run by HOD" href="AcademicInfo/PRRegElectiveSubjToBeRun.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Elective Subjects<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>to be run-HOD</FONT></A></br>
		<%
	}

	qry="Select WEBKIOSK.ShowLink('123','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registratiom - Student Subject Choice of Electives" href="AcademicInfo/PRRegStudentChoice.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Student Choice<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font> of Electives</FONT></A></br>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registratiomn - Approval of finalized Elective Subjects by DOAA" href="AcademicInfo/PRRegApprovElectiveSubjByDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Approve Electives</FONT></A></br>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registratiomn - Free Elective Subjects to be Run by DOAA" href="AcademicInfo/PRRegFreeSubjToBeRunByDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Free Elective(s)<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>subj. finialization</FONT></A></br>
		<%
	}

	qry="Select WEBKIOSK.ShowLink('112','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration BackLog Paper Apprval/Finalization by DOAA" href="AcademicInfo/PRRegBackPaperFinalDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>BackLog Papers<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Approval - DOAA</FONT></A></br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('56','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - HOD Load Distribution" href="AcademicInfo/PRRegLoadDistributionHOD.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Load Distribution</FONT></A></br>	
	<%
	}

	int m129=0;
	qry="Select WEBKIOSK.ShowLink('129','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m129=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - DOAA" href="AcademicInfo/EmpAssignedLoadDistribution.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Assigned Load</FONT></A></br>
	<%
	}

	if (m129==0)
	{
	qry="Select WEBKIOSK.ShowLink('130','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - Departmentwise" href="AcademicInfo/EmpAssignedLoadDistribution.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Assigned Load</FONT></A></br>
	<%
	}
	}

	//--------------------------------
	int mm129=0;
	qry="Select WEBKIOSK.ShowLink('129','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	mm129=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - DOAA" href="AcademicInfo/EmpAssignedLoadDistributionaApproved.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Teaching Load<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Approved/Finalized</FONT></A></br>
	<%
	}

	if (mm129==0)
	{
	qry="Select WEBKIOSK.ShowLink('130','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - Departmentwise" href="AcademicInfo/EmpAssignedLoadDistributionaApproved.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Teaching Load</FONT></A></br>
	<%
	}
	}

	//--------------------------------
	int m133=0;
	qry="Select WEBKIOSK.ShowLink('133','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m133=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Subjects and its respective Faculty member for Assigned Load Distribution - DOAA" href="AcademicInfo/EmpSubjectwiseAssignedLoadDistribution.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Subj. wise Load</FONT></A></br>
	<%
	}

	if (m133==0)
	{
	qry="Select WEBKIOSK.ShowLink('132','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Subjects and its respective Faculty member for Assigned Load Distribution  - Departmentwise" href="AcademicInfo/EmpSubjectwiseAssignedLoadDistribution.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Subj. wise Load</FONT></A></br>
	<%
	}
	}
	//--------------------------------

	qry="Select WEBKIOSK.ShowLink('113','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration Cancellation of HOD Load Distribution Subejcts by DOAA" href="AcademicInfo/PRRegLoadDistributionCancelDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Load Distribution<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Cancel By DOAA</FONT></A></br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('113','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration Load Distribution Approval and FSTID Generation by DOAA" href="AcademicInfo/PRRegLoadDistributionApprovalDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Load Distribution<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Approval - DOAA</FONT></A></br>	
	<%
	}

	int m121=0;
	qry="Select WEBKIOSK.ShowLink('121','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m121=1;

	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration Subjects Load Distribution Report by DOAA" href="AcademicInfo/SubjectLoadList.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Subject Load List</FONT></A></br>
	<%
	}

	if (m121==0)
	{
	qry="Select WEBKIOSK.ShowLink('122','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration Subjects Load Distribution Report by HOD" href="AcademicInfo/SubjectLoadList.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Subject Load List</FONT></A></br>
	<%
	}
	}

	int m119=0;
	qry="Select WEBKIOSK.ShowLink('119','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m119=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration List of Elective/Free Elective Subjects Running  by DOAA" href="AcademicInfo/ElectiveSubjectRunningList.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Elective Subject<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Running List</FONT></A></br>	
	<%
	}
	if (m119==0)
	{
	qry="Select WEBKIOSK.ShowLink('120','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration List of Elective/Free Elective Subjects Running by HOD" href="AcademicInfo/ElectiveSubjectRunningList.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Elective Subject<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Running List</FONT></A></br>	
	<%
	}
	}

	int m135=0;
	qry="Select WEBKIOSK.ShowLink('135','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m135=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Time Table for DOAA" href="AcademicInfo/EmpTimeTableView.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Time Table</FONT></A></br>	
	<%
	}
	if (m135==0)
	{
	m135=1;
	qry="Select WEBKIOSK.ShowLink('136','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Time Table for all HODs" href="AcademicInfo/EmpTimeTableView.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Time Table</FONT></A></br>	
	<%
	}
	}
	if (m135==0)
	{
	m135=1;
	qry="Select WEBKIOSK.ShowLink('137','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Time Table for Faculty Member" href="AcademicInfo/EmpTimeTableView.jsp?Type=F" target=DetailSection><FONT face="Arial" size =2 color=white>Time Table</FONT></A></br>	
	<%
	}

	}
	%>
    </span>
   <div class="menutitle" onclick="SwitchMenu('sub6')">Exam. Activity<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub6">
	<%

	qry="Select WEBKIOSK.ShowLink('246','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	//out.print(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Modified Grade Approval" href="../EmployeeFiles/ExamActivity/ApproveChangedStudGrade.jsp"><FONT face="Arial" color=white size=2>Approve Changed<br><FONT face="Arial" color='#de6400' size=2>&nbsp;&nbsp; </font><FONT face="Arial" color=white size=2>Grades</font></a><br>
		<%
	}

    // Provide Link when Date Seet/Seating Plan Has been prepared and Exam Last Date is applicable
	
    int Ed=0;
    qry="Select WEBKIOSK.GetDateSheetCodes('"+pInstCode+"') SL from dual";
    Rs = db.getRowset(qry);
    if (Rs.next() && !Rs.getString("SL").equals("N"))
     {
		
	qry="Select WEBKIOSK.ShowLink('20','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{  Ed=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Date Sheat Complete (For Admin users)" href="ExamActivity/EmpViewDateSheet.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Date Sheet-All</font></a><br>
	<%
	}
 	if(Ed==0)
	{
	qry="Select WEBKIOSK.ShowLink('97','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		Ed=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Date Sheat Departmentwise" href="ExamActivity/EmpViewDateSheet.jsp?SrcType=H"><FONT face="Arial" color =white size=2>Date Sheet-HOD</font></a><br>
	<%
	}
	}
	if(Ed==0)
	{
	qry="Select WEBKIOSK.ShowLink('98','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		Ed=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Date Sheat - individual Faculty" href="ExamActivity/EmpViewDateSheet.jsp?SrcType=I"><FONT face="Arial" color =white size=2>Date Sheet-Indv.</font></a><br>
	<%
	}
	}
	int Sp=0;
	qry="Select WEBKIOSK.ShowLink('21','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		Sp=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Seating plan for all employee" href="ExamActivity/EmpViewSeatPlan.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Seating plan -All</font></a><br>					
	<%
	}
	if(Sp==0)
	{
	qry="Select WEBKIOSK.ShowLink('34','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
        Rs = db.getRowset(qry);
        if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	  Sp=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Seating plan (Departmentwise)" href="ExamActivity/EmpViewSeatPlan.jsp?SrcType=H"><FONT face="Arial" color =white size=2>Seating plan-<small>HOD</small></font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" href="ExamActivity/EmpViewSubjectwiseStrength.jsp?RightsID=34"><FONT face="Arial" color=white size=2>Exam Stud Strength</font></a>
	<%
	}
     }

     if(Sp==0)
	{
	 qry="Select WEBKIOSK.ShowLink('35','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
         Rs = db.getRowset(qry);
         if (Rs.next() && Rs.getString("SL").equals("Y"))
	 {
	   Sp=1;
	  %>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Seating plan for indifidula employee" href="ExamActivity/EmpViewSeatPlan.jsp?SrcType=I"><FONT face="Arial" color =white size=2>Seating plan-Indv.</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" href="ExamActivity/EmpViewSubjectwiseStrength.jsp?RightsID=35"><FONT face="Arial" color =white size=2>Exam Stud Strength</font></a>
	<%
	}
       }
	
	int Dt=0;

	qry="Select WEBKIOSK.ShowLink('115','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	Dt=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Duty plan for all employee" href="ExamActivity/DutyStatus.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Exam Duty-All</font></a><br>					
	<%
	}
	 if(Dt==0)
	{
	qry="Select WEBKIOSK.ShowLink('116','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	Dt=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Duty plan (Departmentwise)" href="ExamActivity/DutyStatus.jsp?SrcType=H"><FONT face="Arial" color =white size=2>Exam Duty-<small>HOD</small></font></a><br>					
	<%
	}
      }
  	if(Dt==0)
	{
	qry="Select WEBKIOSK.ShowLink('117','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	Dt=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Duty plan for individual employee" href="ExamActivity/DutyStatus.jsp?SrcType=I"><FONT face="Arial" color =white size=2>My Exam Duty</font></a><br>					
	<%
	}

	}
}
  // Closing of Date seet date checking


	qry="Select WEBKIOSK.ShowLink('91','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
    //out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Invigilation Duty Holiday/Time Pref. Request - Self" href='../EmployeeFiles/ExamActivity/InvigilationTimePrefDultHoliday.jsp'><FONT face="Arial" color =white size=2>Invig. Time Pref./<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Duty Request</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('107','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Invigilation Duty Holiday/Time Pref. Request - By HOD" href='ExamActivity/InvigilationTimePrefDultHolidayHOD.jsp'><FONT face="Arial" color=white size=2>Inv. Rqst by <small>HOD</small></font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('108','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Invigilation Duty Holiday/Time Pref. Request - By DOAA" href='../EmployeeFiles/ExamActivity/InvigilationTimePrefDultHolidayADMIN.jsp'><FONT face="Arial" color=white size=2>Inv. Rqst by <small>DOAA</small></font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('92','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Invigilation Duty Holiday/Time Pref. Request " href='../EmployeeFiles/ExamActivity/InvigilationTimePrefDultHolidayApproval.jsp'><FONT face="Arial" color =white size=2>Invig. Time Pref.<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Request Approval</font></a><br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('95','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Invigilation Time Pref./Duty Holiday Request Status" href="ExamActivity/InvigilationStatus.jsp?SrcType=I"><FONT face="Arial" color =white size=2>Invig. Time Pref.<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Status (Self)</font></a><br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('93','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Invigilation Time Pref./Duty Holiday Request Status" href="../EmployeeFiles/ExamActivity/InvigilationStatus.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Invig. Time Pref.<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Status (All)</font></a><br>
	<%
	}
	
	
	qry="Select WEBKIOSK.ShowLink('94','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Invigilation Time Pref./Duty Holiday Request Status" href="ExamActivity/InvigilationStatus.jsp?SrcType=H"><FONT face="Arial" color =white size=2>Invig. Time Pref.<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Status  Deptwise</font></a><br>	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('58','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
   // out.print(qry);
    Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A  title="Tagging of Subject as per Examination, Weightage & Full Marks"  href="ExamActivity/EmpExamEventSubjTagging.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Pre Marks Entry</FONT></A></br>
	<%
	}
   qry="Select WEBKIOSK.ShowLink('218','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
	//out.print(qry);
   Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A  title="View Marks Entry Status by Admin"  href="../EmployeeFiles/ExamActivity/EmpExamMarksStatusList.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Entry Status</FONT></A></br>
		<%
	}
	qry="Select WEBKIOSK.ShowLink('59','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A  title="View Personal Batch Tagged Subjects (Event/Sub Event) as per Examination, Weightage & Full Marks"  href="ExamActivity/ViewExamEventSubjTagging.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Exam Events</FONT></A></br>
	<%
	}




	qry="Select WEBKIOSK.ShowLink('102','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A  title="Change Personal Batch Tagged Weightage (Event/Sub Event) as per Exam & Subject"  href="ExamActivity/ChangeExamEventSubjWeightage.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Re-Weightage</FONT></A></br>
	<%
	}



	
	qry="Select WEBKIOSK.ShowLink('61','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Marks View" href="ExamActivity/EmpMarksView.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks View</FONT></A><BR>
	<%
	}


	int md=0;
	qry="Select WEBKIOSK.ShowLink('57','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		md=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Ongoing performance record of Students (Departmental Manual)" href="ExamActivity/EmpPeformanceReportStud.jsp?Type=H" target="_New"><FONT face="Arial" size =2 color=white>Stud. performace</FONT></A><BR>
	<%
	}

	if (md==0)
	{
		qry="Select WEBKIOSK.ShowLink('111','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	Rs = db.getRowset(qry);
	      if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
			<img src="../Images/bullet4.gif">&nbsp;<A title="Ongoing performance record of Students (Departmental Manual)" href="ExamActivity/EmpPeformanceReportStud.jsp?Type=I" target="_New"><FONT face="Arial" size =2 color=white>Stud. performace</FONT></A><BR>
		<%
		}
	}



	/*
	qry="Select WEBKIOSK.ShowLink('64','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Marks Updation" href="ExamActivity/MarksEntryDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Updation</FONT></A><BR>

	<%
	}
	*/

	qry="Select WEBKIOSK.ShowLink('103','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Allow for MakeUp Test" href="ExamActivity/MakeUpTest.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Allow for MakeUp</FONT></A><BR>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('124','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{

	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Students Makeup Marks Entry " href="ExamActivity/MakeupMarksEntry.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Makeup Marks</FONT></A><BR>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('66','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="SCGPA/CGPA wise Subject List" href="ExamActivity/ListStudentByCGPAMarks.jsp"><FONT face="Arial" color =white size=2>Stud. Marks Qry</font></a><br>
	<%
	}
    qry="Select WEBKIOSK.ShowLink('226','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Subject List For Grade Entry of Students  " href = "../EmployeeFiles/ExamActivity/SubListForGradeEntry.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Subjects for Grading</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('18','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Paperwise distribtion" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Paperwise dist.</font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('146','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";

      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade Entry of Students  " href="ExamActivity/GradeCalculation.jsp"><FONT face="Arial" color =white size=2>Grade Entry</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade View of Students  " href="ExamActivity/GradePrint.jsp"><FONT face="Arial" color =white size=2>Grade View</font></a><br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('147','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade Entry of Students  " href="../EmployeeFiles/ExamActivity/GradeCalculationApprovalDOAA.jsp"><FONT face="Arial" color =white size=2>Grade Approval</font></a><br>

			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade Entry of Students  " href="ExamActivity/GradeEntryStatus.jsp"><FONT face="Arial" color =white size=2>Grade Entry Status<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Subject wise</font></a><br>

		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade Entry of Students  " href="ExamActivity/GradeEntryStatusStudent.jsp"><FONT face="Arial" color =white size=2>Grade Entry Status<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Student Wise</font></a><br>
	<%
	}
	%>	
    </span>


    <div class="menutitle" onclick="SwitchMenu('sub7')">Admin Option <img src="../Images/arrow.gif"></div>
    <span class="submenu" id="sub7">
	<%
	qry="Select WEBKIOSK.ShowLink('190','"+ mMemberID +"','G','"+mRole+"','"+mIPAddress+"') SL from dual";
		//out.print(qry);
		Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Employee Attendance Detail" href="../EmployeeFiles/AdminOptions/EmployeeAttendanceDetail.jsp"><FONT face="Arial" color =white size=2>Staff Attendance</font></a><br>
			<%
		}

	qry="Select WEBKIOSK.ShowLink('191','"+ mMemberID +"','G','"+mRole+"','"+mIPAddress+"') SL from dual";
	//out.print(qry);
	Rs = db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Employee Attendance Detail" href="../EmployeeFiles/AdminOptions/EmployeeLateEarlyAttendance.jsp"><FONT face="Arial" color =white size=2>Emp Late/Early Att</font></a><br>
		<%
	}


	qry="Select WEBKIOSK.ShowLink('0','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Signup in bulk (create LoginID for New Students)" href="../CommonFiles/SignUpStudents.jsp"><FONT face="Arial" color=white size=2>Bulk Signup of<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Student</font></a><br>
	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('70','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Signup Member(create LoginID for Employee/Student/Visiting Staff/Guest one by one) " href="../CommonFiles/SignUp.jsp"><FONT face="Arial" color=white size=2>Signup Member</font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('38','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Change Role of Employee" href="AdminOptions/ChangeEmpRole.jsp"><FONT face="Arial" color=white size=2>Change Role</font></a><br>	
	<%
	}
	qry="Select WEBKIOSK.ShowLink('39','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Reset Password of any Member " href="AdminOptions/ResetPasswordForciblyNew.jsp"><FONT face="Arial" color=white size=2>Reset Password</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('67','"+ mMemberID +"','G','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Assign/Reset Employee KIOSK Page Heading/Title " href="AdminOptions/WebPageTitle.jsp"><FONT face="Arial" color=white size=2>Webpage Title</font></a><br>
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
	%>
   </span>
   <div class="menutitle" onclick="SwitchMenu('sub8')">Room booking<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub8">
	<%
	qry="Select WEBKIOSK.ShowLink('26','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Book a Room" href="RoomBooking/EmpBookRoom.jsp"><FONT face="Arial" color =white size=2>Room Booking</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('27','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Cancel a Booked Room by the respective Employee" href="RoomBooking/EmpCancelRoomBooking.jsp"><FONT face="Arial" color =white size=2>Cancel Room</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('28','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Cancel Room Forcibly" href="RoomBooking/EmpForcebilyCancelRoom.jsp"><FONT face="Arial" color =white size=2>Cancel Forcibly</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('96','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Booked Room History" href="RoomBooking/EmpBookedRoomHistory.jsp"><FONT face="Arial" color =white size=2>Booked History</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('145','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Room Wise Room Booking History" href="RoomBooking/EmpBookedRoomHistoryRoomWise.jsp"><FONT face="Arial" color =white size=2>Roomwise Hist.</font></a><br>
	<%
	}
	%>
   </span>

<div class="menutitle" onclick="SwitchMenu('sub9')">Purchase &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub9">
<%
    

    qry="Select WEBKIOSK.ShowLink('156','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
    Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  target="_new" title="Purchase Requisition" href="PRI/PurchaseRequisition.jsp"><FONT face="Arial" color =white size=2>Purchase<br><font color='#de6400'>&nbsp; &nbsp</font>Requisition</font></a><br>
	<%
	}
		
	%>
 </span>

</td>
</tr>
<TD><img src="../Images/bull.gif">&nbsp;<A title="FAQ" href="../FAQ/FAQEmployee.HTML" target=_New><FONT face="Arial" color =white size=2><STRONG>FAQ</STRONG></FONT></A></TD></TR></FONT></FONT> 
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
<td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Secret Question" href="../CommonFiles/AskSecretQuestion.jsp" target="DetailSection"><FONT face="Arial" size =2 color=white><STRONG>Secret Question</STRONG></FONT></A></TD>
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
