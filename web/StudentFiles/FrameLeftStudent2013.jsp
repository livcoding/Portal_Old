<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>  
<%  
/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	FrameLeftStudent.JSP		[For Students]						           *
	' * Author:		Ashok Kumar Singh 							           *
	' * Date:		20th Oct 2006	   *
	' * Version:		1.0									   *	
	' **********************************************************************************************************
*/

String qry="";
String pInstCode="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
ResultSet Rs =null;

String mMemberID="", mMemberType="", mRole="",mIPAddress="";
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

 
if (session.getAttribute("InstituteCode")==null)
{
	pInstCode="";
}
else
{
	pInstCode=session.getAttribute("InstituteCode").toString().trim();
}

%>
<HTML>
<HEAD>
<Style Type="text/css"> 
body {scrollbar-3dlight-color:#ffd700;
scrollbar-arrow-color:#ff0; 
scrollbar-base-color:=:#000ff0;
scrollbar-darkshadow-color:#000000; 
scrollbar-face-color:#de6400; 
scrollbar-highlight-color:#9900005;
scrollbar-shadow-color:#f0f} 
</style> 
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
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<style type="text/css">
.menutitle{
cursor:pointer;
margin-bottom: 4px;
background-color:#fce9c5;
color:#c00000;
width:115px;
padding:1px;
text-align:Left;
font-weight:bold;
/*/*/border:1px solid #000000;/* */
}

.submenu{
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
function SwitchMenu(obj){
	if(document.getElementById){
	var el = document.getElementById(obj);
	var ar = document.getElementById("masterdiv").getElementsByTagName("span"); //DynamicDrive.com change
		if(el.style.display != "block"){ //DynamicDrive.com change
			for (var i=0; i<ar.length; i++){
				if (ar[i].className=="submenu") //DynamicDrive.com change
				ar[i].style.display = "none";
			}
			el.style.display = "block";
		}else{
			el.style.display = "none";
		}
	}
}

function get_cookie(Name) { 
var search = Name + "="
var returnvalue = "";
if (document.cookie.length > 0) {
offset = document.cookie.indexOf(search)
if (offset != -1) { 
offset += search.length
end = document.cookie.indexOf(";", offset);
if (end == -1) end = document.cookie.length;
returnvalue=unescape(document.cookie.substring(offset, end))
}
}
return returnvalue;
}

function onloadfunction(){
if (persistmenu=="yes"){
var cookiename=(persisttype=="sitewide")? "switchmenu" : window.location.pathname
var cookievalue=get_cookie(cookiename)
if (cookievalue!="")
document.getElementById(cookievalue).style.display="block"
}
}

function savemenustate(){
var inc=1, blockid=""
while (document.getElementById("sub"+inc)){
if (document.getElementById("sub"+inc).style.display=="block"){
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
<BODY vLink=#00000b link=#00000b  bgcolor="#de6400" leftMargin=1 topMargin=0 marginheight="0" marginwidth="0" >
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
	qry="Select WEBKIOSK.ShowLink('42','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
	  //----------------------
	%>
<TABLE cellSpacing=0 width="98%" align=center bgcolor=peru valign="top" style="LEFT: 6px; TOP: 2px">
  <TBODY  bgcolor="#de6400">   
  <TR><TD align=center><FONT color='#fce9c5' size=3><STRONG>Available options</STRONG></FONT>
</td></tr>
<tr><td><img height=2 src="../Images/ColorBar.gif" width=110>
</td></tr>
	<tr>
   <td>
   <!-Keep all menus within masterdiv-->


	<div id="masterdiv">

   <div class="menutitle" onclick="SwitchMenu('sub1')">Personal Info.&nbsp;<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub1">
	<%
    qry="Select WEBKIOSK.ShowLink('1','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
    Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Personal Information" href="PersonalFiles\StudPersonalInfo.jsp"><FONT face="Arial" color =white size=2>Personal detail</font></a><br>
	<%
	}

    qry="Select WEBKIOSK.ShowLink('29','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
    Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Change eMailID/Contact Numbers" href="PersonalFiles\StudModifyEmailIDTelephone.jsp"><FONT face="Arial" color =white size=2>Edit Info.</font></a><br>
	<%
	}


	
   qry="Select WEBKIOSK.ShowLink('268','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
    Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Attendance" href="PersonalFiles\StudSelfAttendance.jsp"><FONT face="Arial" color =white size=2>Self Attendance</font></a><br>
	<%
	}
	%>



  </span>

	<div class="menutitle" onclick="SwitchMenu('sub2')">SRS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../Images/arrow.gif"></div>
	<span class="submenu" id="sub2">
	<%
	    qry="Select WEBKIOSK.ShowLink('30','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a title="New SRS Entry" target="DetailSection" href="SRS\StudNewSrsEntry.jsp"><FONT face="Arial" color =white size=2>New SRS Entry</font></a><br>
		<%
		}
	    qry="Select WEBKIOSK.ShowLink('37','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  title="View Submitted/sent SRS" target="DetailSection" href="SRS\StudSrsView.jsp"><FONT face="Arial" color =white size=2>View sent SRS</font></a><br>
		<%
		}
		%>

	</span>


   <div class="menutitle" onclick="SwitchMenu('sub3')">Fee Detail&nbsp; &nbsp; &nbsp; &nbsp;<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub3">
   <%
	 qry="Select WEBKIOSK.ShowLink('31','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	 Rs = db.getRowset(qry);
	 if (Rs.next() && Rs.getString("SL").equals("Y") || 1==1)
	   {
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  title="Academic Fee history" target="DetailSection" href="FAS\StudRegFee.jsp"><FONT face="Arial" color =white size=2>Reg. Fee Info</font></a><br>

		<%
	    }
		

	qry="Select WEBKIOSK.ShowLink('151','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	Rs= db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
	   {
	  %>
   	      <img src="../Images/bullet4.gif">&nbsp;<a href='../CommonFiles/SelfStudEmpDrCrAdvice.jsp' Title='Veiw Debit/Credit Advive' Target=_NEW><font  face="Arial" color =white size=2>Dr/Cr Advice</font></a><br>
	  <%
	   }


		%>
   </span>
   <div class="menutitle" onclick="SwitchMenu('sub4')">Academic Info.<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub4">
	<%
      qry="Select WEBKIOSK.ShowLink('52','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);

      if (Rs.next() && Rs.getString("SL").equals("Y"))
	  {
	   %>
	    <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Pre Registration/Subject Choice Entry" href="Academic\BackLogSubjectsList.jsp"><FONT face="Arial" color =white size=2>Pre Registration</font></a><br>	
	   <%
	  }

      qry="Select WEBKIOSK.ShowLink('109','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);

      if (Rs.next() && Rs.getString("SL").equals("Y"))
 	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="BackPaper Registration/Subject Choice Entry" href="Academic\PRStudentEntryBackPaper.jsp"><FONT face="Arial" color =white size=2>BackPaper Reg.</font></a><br>	
	<%
	}

	    qry="Select WEBKIOSK.ShowLink('53','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Registered/opted Subject" href="Academic\PRStudentView.jsp"><FONT face="Arial" color =white size=2>Pre. Reg. Subj.</font></a><br>	
		<%
		}


	    qry="Select WEBKIOSK.ShowLink('88','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Attendance Detail" href="Academic\StudentAttendanceList.jsp"><FONT face="Arial" color =white size=2>My Attendance</font></a><br>	
		<%
		}
	    qry="Select WEBKIOSK.ShowLink('33','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View opted/registered subjects" href="Academic\StudSubjectTaken.jsp"><FONT face="Arial" color =white size=2>Subject Regtd.</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View opted/registered Student faculty subjects" href="Academic\StudSubjectFaculty.jsp"><FONT face="Arial" color =white size=2>Subject Faculty</font></a><br>
		<%
		}

		qry="Select WEBKIOSK.ShowLink('134','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      Rs = db.getRowset(qry);
	      if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View current Time Table"  href="Academic\StudentTimeTable.jsp"><FONT face="Arial" color =white size=2>Time Table</font></a><br>
		<%
		}
	 qry="Select WEBKIOSK.ShowLink('210','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	     Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Disciplinary Action"  href="Academic\DisciplinaryAction.jsp"><FONT face="Arial" color =white size=2>Disciplinary Actions</font></a><br>
		<%
		}
	 
	 
		qry="Select WEBKIOSK.ShowLink('211','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
		 
	     Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Disciplinary Action taken by Hostel warden"  href="Academic\StudentDisciplinaryAction.jsp"><FONT face="Arial" color =white size=2>Hoste warden actions</font></a><br>
		<%
		}


	%>
  </span>

   <div class="menutitle" onclick="SwitchMenu('sub5')">Exam. Info.&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub5">
	<%
	    // This link will be available when he/she will be assigned Student Load
	    qry="Select * from OTHERSTAFFLOADTAGGING where EXAMONDWMYE is not null and nvl(deactive,'N')='N' and STAFFID='"+ mMemberID +"'";
	    Rs = db.getRowset(qry);
	    if (Rs.next())
		{
			    qry="Select WEBKIOSK.ShowLink('91','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
			    Rs = db.getRowset(qry);
			    if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
	
				%>
				<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Request of not availability in Invigilation Duty" href="Exam\InvigilationTimePrefDultHolidaySTUD.jsp"><FONT face="Arial" color =white size=2>Invigilation Duty<br><FONT face="Arial" color='#de6400' size=2>&nbsp;&nbsp;&nbsp;</font>Request</font></a><br>
				<%
				}
			    qry="Select WEBKIOSK.ShowLink('95','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
			    Rs = db.getRowset(qry);
			    if (Rs.next() && Rs.getString("SL").equals("Y"))
				{
				%>
				<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Request of not availability in Invigilation Duty" href="..\EmployeeFiles\ExamActivity\InvigilationStatus.jsp"><FONT face="Arial" color =white size=2>Invigilation Duty<br><FONT face="Arial" color='#de6400' size=2>&nbsp;&nbsp;&nbsp;</font>Status</font></a><br>	
				<%
				}

		 }


  // Provide Link when Date Seet Has been prepared and Exam Last Date is applicable

    qry="Select WEBKIOSK.GetDateSheetCodes('"+pInstCode+"') SL from dual";

    Rs = db.getRowset(qry);
    while (Rs.next() && !Rs.getString(1).equals("N"))
	{

	    qry="Select WEBKIOSK.ShowLink('99','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";

	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Date Sheat" href="Exam\StudViewDateSheet.jsp"><FONT face="Arial" color =white size=2>My Date Sheet</font></a><br>
		<%
		}
      }
  // Provide Link when Duty Seet/Seating Plan Has been prepared and Exam Last Date is applicable

    String mDSCODE="";
    qry="Select WEBKIOSK.GetSeatingPlanCodes('"+pInstCode+"') SL from dual";
    Rs = db.getRowset(qry);
    while (Rs.next())
	{
		if(!Rs.getString("SL").equals("N"))
		{
		  if(mDSCODE.equals("")) 	
			mDSCODE=Rs.getString(1);
		  else
			mDSCODE=mDSCODE+Rs.getString(1);
		}
	}
	
	if ( !mDSCODE.equals(""))
       {
	    qry="Select 'Y' from INVIGILATIONDUTYALLOCATION A where A.institutecode='"+pInstCode+"' and  ";
	    qry=qry+" A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in("+mDSCODE+") ";
	    qry=qry+" and A.INVIGILATORID='"+mMemberID+"' and A.INVIGILATORTYPE='S'";
	    qry=qry+" and A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in (select S.EXAMCODE||'('||S.EXAMEVENTCODE||')-'||S.SPCODE from SEATINGPLAN S where ";
	    qry=qry+" S.EXAMCODE||'('||S.EXAMEVENTCODE||')-'||S.SPCODE in ("+mDSCODE+") and nvl(Status,'N')='F') ";	
 
	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString(1).equals("Y"))	
		{
		    qry="Select WEBKIOSK.ShowLink('118','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
			
		    Rs = db.getRowset(qry);
		    if (Rs.next() && Rs.getString("SL").equals("Y"))
			{		   
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Examination Duty Datte/Time and Center/Room" href="Exam\DutyStatusByStudent.jsp"><FONT face="Arial" color =white size=2>My Exam. Duty</font></a><br>
			<%
			}
		}
}
	    qry="Select WEBKIOSK.ShowLink('36','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	//out.print(qry);
	    Rs = db.getRowset(qry);
	  
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Seating plan" href="Exam\StudViewSeatPlan.jsp"><FONT face="Arial" color =white size=2>My Seating Plan</font></a><br>					
		<%
		}
   
//  }

// Closing of Date seet date checking
		

		qry="Select WEBKIOSK.ShowLink('62','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title='View Event Subject Marks' href='Exam\StudentEventMarksView.jsp'><FONT face="Arial" color =white size=2>Exam Marks</font></a><br>	
		<%
		}
		qry="Select WEBKIOSK.ShowLink('100','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    Rs = db.getRowset(qry);
	    //out.println(qry);
	//if (Rs.next() && Rs.getString("SL").equals("Y"))
if(1==1)
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title='View Event Subject Grades' href='Exam\StudentEventGradesView.jsp'><FONT face="Arial" color =white size=2>Exam Grades</font></a><br>
		<%
		}

	    qry="Select WEBKIOSK.ShowLink('138','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title='View SGPA/CGPA ' href='Exam\StudCGPAReport.jsp'><FONT face="Arial" color =white size=2>View <small>SGPA/CGPA</small></font></a><br>
		<%
		}

	 qry="Select WEBKIOSK.ShowLink('249','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    Rs = db.getRowset(qry);
	    if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title='Supplimentary Registration Form ' href='Exam\RegistrationActionJIIT.jsp'><FONT face="Arial" color =white size=2>Supplimentary <br><FONT face="Arial" color='#de6400' size=2>&nbsp;&nbsp;&nbsp;</font>Reg. Form</font></a><br>
		<%
		}



		%>

	</span>

   </td>
   </tr>



    <TR>
    <TD><img src="../Images/bull.gif">&nbsp;<A title="FAQ" href="../FAQ/FAQStud.HTML" target=_New><FONT face="Arial" color =white size=2><STRONG>FAQ</STRONG></FONT></A></TD></TR></FONT></FONT> 
	<%
	qry="Select WEBKIOSK.ShowLink('46','"+ mMemberID +"','S','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
    <tr>   <td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Change Password" href="../CommonFiles/ChangePassword.jsp" title="Change password" target="DetailSection"><FONT face="Arial" size =2 color=white><STRONG>Change PIN</STRONG></FONT></A></TD>
   </tr>
	
	<%
	}
	%>

<tr>
	<td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Secret Question" href="../CommonFiles/AskSecretQuestion.jsp" target="DetailSection"><FONT face="Arial" size =2 color=white><STRONG>Secret Question</STRONG></FONT></A></TD>
</tr>



    <tr>
   <td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Logout/Signout" href="javascript:UnLoadWindows();" onClick()="javascript:self.window.close();"><FONT face="Arial" size =2 color=white><STRONG>Logout</STRONG></FONT></A></TD>    
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
	<font color=white>
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
// out.print(qry);
}

%>

</BODY></HTML>
