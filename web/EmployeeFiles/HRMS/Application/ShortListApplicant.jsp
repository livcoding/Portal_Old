<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="",mCurrDate="";
String mDesignationCode="",mDepartmentCode="",mApplicantName="";
String mDepartment1="",mDate1="",mDate2="",mValue="";
String mDeg="",mEmpType="",mIndentNumber="",mRightsID="149";
int counter=0,mSno=0;
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
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
<TITLE>#### <%=mHead%> [ Short List Applicants ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
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
if(window.history.forward(1) != null)
window.history.forward(1);	
</script>
<script>
function fun()
{
	var mValue;
	var mIndentNo;
	var mIndentDate;
	var mRequieDate;
	var Department;
	var mManpower;
	var mExp;
	var mDesignation;
	var mEmpType
	var pos;
	var pos1;
	mValue=document.frm.Indent.value;	
	pos=mValue.indexOf('~~~');
	mIndentNo=mValue.substring(0,pos);
	//document.frm.Indentno.value=mIndentNo;	
	pos=mValue.indexOf('~~~')+3;
	pos1=mValue.indexOf('!!!');
	mManpower=mValue.substring(pos,pos1);
	document.frm.ManPower.value=mManpower;	
	pos=mValue.indexOf('!!!')+3;
	pos1=mValue.indexOf('@@@');
	mIndentDate=mValue.substring(pos,pos1);
	document.frm.IndentDate.value=mIndentDate;	
	pos=mValue.indexOf('@@@')+3;
	pos1=mValue.indexOf('$$$');
	mRequieDate=mValue.substring(pos,pos1);
	document.frm.ReqDate.value=mRequieDate;	
	pos=mValue.indexOf('$$$')+3;
	pos1=mValue.indexOf('^^^');
	Department=mValue.substring(pos,pos1);
	document.frm.Department.value=Department;	
	pos=mValue.indexOf('^^^')+3;
	pos1=mValue.indexOf('```');
	mExp=mValue.substring(pos,pos1);
	document.frm.Exp.value=mExp;	
	pos=mValue.indexOf('```')+3;
	pos1=mValue.indexOf('###');
	mDesignation=mValue.substring(pos,pos1);
	document.frm.Designation2.value=mDesignation;
	pos=mValue.indexOf('###')+3;
	pos1=mValue.indexOf('&&&');
	mEmpType=mValue.substring(pos,pos1);	
	document.frm.EmpType3.value=mEmpType;
	RadioClick();
}
function RadioClick()
{
	if(document.frm.ShotlistCriteria[0].checked==true)
	{	
		document.frm.Indent.disabled=true;
		document.frm.ManPower.disabled=true;
		//document.frm.Indentno.disabled=true;
		document.frm.IndentDate.disabled=true
		document.frm.ReqDate.disabled=true;
		document.frm.Department.disabled=true;
		document.frm.Exp.disabled=true;
		document.frm.Designation2.disabled=true
		document.frm.EmpType3.disabled=true;
	}
	else
	{		
		document.frm.Indent.disabled=false;
		document.frm.ManPower.disabled=false;
		//document.frm.Indentno.disabled=false;
		document.frm.IndentDate.disabled=false
		document.frm.ReqDate.disabled=false;
		document.frm.Department.disabled=false;
		document.frm.Exp.disabled=false;
		document.frm.Designation2.disabled=false;
		document.frm.EmpType3.disabled=false;		
	}
	if(document.frm.ShotlistCriteria[1].checked==true)
	{
		document.frm.Designation.disabled=true;
		document.frm.EmpType.disabled=true;
	}
	else
	{
		document.frm.Designation.disabled=false;
		document.frm.EmpType.disabled=false;
	}
}
function isNumber(e)
{	
	var unicode=e.charCode? e.charCode : e.keyCode
	if (unicode!=8)
	{ //if the key isn't the backspace key (which we should allow)
		if ((unicode<48||unicode>57)) //if not a number
		return false //disable key press
	}
}
function isNumeric(e)
{	
	var unicode=e.charCode? e.charCode : e.keyCode
	if (unicode!=8)
	{ //if the key isn't the backspace key (which we should allow)
		if (unicode<49||unicode>57) //if not a number
		return false //disable key press
	}
}
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin="0" topmargin="0" onLoad="fun();">
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
		qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		%>
			<form name="frm"  method="post" action="ShortListApplicantAction.jsp">
			<input id="x" name="x" type=hidden>
			<center>
		<table id=id1 width="852" ALIGN=CENTER  topmargin=0 cellspacing=0 cellpadding=0 rightmargin=0 leftmargin=0 bottommargin=0 >

	
<!-------------Page Heading and Marquee Message----------------------->
<%
try
{
	String mPageHeader="Short List Applicant", mMarqMsg="", CurrDate="";
	qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		CurrDate=rs.getString("CurrDate");
	}
	qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightsID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mMarqMsg=rs.getString("MarqMsg");
		%>
		<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
		<%
	}
	qry="Select nvl(B.PAGEHEADER,'"+mPageHeader+"')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mPageHeader=rs.getString("PageHeader");
		%>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
		<%
	}
	else
	{
		%>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
		<%
	}
}
catch(Exception e)
{}
%>
<!-------------Page Heading and Marquee Message----------------------->
			</table>
			</center>
			<%
			try
			{
				qry="select distinct B.DEPARTMENTCODE DEPARTMENTCODE,C.DESIGNATIONCODE DESIGNATIONCODE,nvl(A.EMPLOYEENAME,' ')EMPLOYEENAME, nvl(A.EMPLOYEECODE,' ')EMPLOYEECODE ,B.DEPARTMENT DEPARTMENT,C.DESIGNATION DESIGNATION from EMPLOYEEMASTER A,DEPARTMENTMASTER B, DESIGNATIONMASTER C where A.employeeid='"+mChkMemID+"' and A.DEPARTMENTCODE=B.DEPARTMENTCODE and A.DESIGNATIONCODE=C.DESIGNATIONCODE and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' and nvl(C.DEACTIVE,'N')='N' ";
				//out.println(qry);
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mEmployeeName=rs.getString("EMPLOYEENAME");
					mEmployeeCode=rs.getString("EMPLOYEECODE");
					mDepartment1=rs.getString("DEPARTMENT");
					mDesignation1=rs.getString("DESIGNATION");
					mDesignationCode=rs.getString("DESIGNATIONCODE");
					mDepartmentCode=rs.getString("DEPARTMENTCODE");
				}
			}catch(Exception e)
			{/*out.print("Exception e");*/}
			%>			
			<center>			
			<table align=center cellpadding="0" cellspacing="0" border="1" rules="groups" width=99%>
			<tr>
				<td colspan=8><font color="#00008b" face=times new roman size=2><b>&nbsp;<%=mEmployeeName%> </b></font>
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Designation </font> </B>
				<font color="#00008b" face=times new roman><b> &nbsp;<%=GlobalFunctions.toTtitleCase(mDesignation1)%> </b></font>
				<b><FONT face=Arial size=2>&nbsp; Department </font></B><font color="#00008b" face=times new roman><b>&nbsp;&nbsp;<%=GlobalFunctions.toTtitleCase(mDepartment1)%></b></font><hr>
				</td>
			</tr>			
				<%
				qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
				rs=db.getRowset(qry);
				while(rs.next())
				{					
					%>		
					<input type="hidden" name="INST" value=<%=rs.getString("IC")%>>
					<%					
				}
				%>
				<input type="hidden" name="Comp" value=<%=mComp%>>				
			</tr>
			<tr>
				<td colspan="3"><b><FONT face=Arial size=2>&nbsp;Application lies between</b></font>&nbsp;&nbsp;&nbsp;&nbsp;
				<input Name=TXT1 Id=TXT1 Type="text" style="height=20px;" maxlength=10 size=8 value='<%=mDate1%>' READONLY onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ><a href="javascript:NewCal('TXT1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ></a>
				<b><FONT face=Arial size=2>&nbsp;To</font></b>
				<input Name=TXT2 Id=TXT2 Type=text style="height=20px;" maxlength=10 size=8 value='<%=mDate2%>' READONLY onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ><a href="javascript:NewCal('TXT2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ></a><hr>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<font face="arial" size="2" color="navy"><b>&nbsp;Select Applicants</b></font><br>&nbsp;&nbsp;&nbsp;<input type="radio" value="AllApplicant" name="Criteria"><b><font face="arial" size="2">All </font>
					<input type="radio" value="notInterViewed" name="Criteria" checked><b><font face="arial" size="2">Those aren't interviewed yet </b></font>
					<input type="radio" value="BeforeInterviewed" name="Criteria"><b><font face="arial" size="2">Interviewed before <input type="text" name="Months" value="<%=6%>" id="Months" maxlength="2" style= "width=30px; height=20px;" onkeypress="return isNumber(event)"> months</b></font><hr>
				</td>
			</tr>			
			<tr>
				<td colspan="3"><b><font face="arial" size="2" color="navy">&nbsp;Short List Applicants according to</font></b><br>&nbsp;<b><font face="arial" size="2">Without Indent</font></b>&nbsp;&nbsp;<input type="Radio" name="ShotlistCriteria" id="ShotlistCriteria" onClick="RadioClick()" checked value="withoutindent"><b><font face="arial" size="2">Designation</font></b>
					<select name="Designation" id="Designation" style= "width=162px; height=19px; font-size: 10pt; font-family: Times New Roman; font-weight: normal;">
					<%
					//qry="Select DESIGNATIONCODE, DESIGNATION from DESIGNATIONMASTER where nvl(DEACTIVE,' ')<>'Y'";

				qry="select distinct A.DESIGNATIONCODE,B.DESIGNATION from HR#DEPDESIGTAGGING A, DESIGNATIONMASTER B where A.DESIGNATIONCODE=B.DESIGNATIONCODE  and nvl(A.DEACTIVE,'N')<>'Y'  and nvl(B.DEACTIVE,'N')<>'Y' order by B.DESIGNATION ";
				// out.print(qry);

						rs=db.getRowset(qry);
						while(rs.next())
						{						
							if(mDeg.equals(""))
							{
								mDeg=rs.getString("DESIGNATIONCODE");
								%>
								<option value="<%=mDeg%>" selected><%=gb.toTtitleCase(rs.getString("DESIGNATION"))%></option>
								<%
							}
							else
							{
								%>
								<option value="<%=rs.getString("DESIGNATIONCODE")%>"><%=gb.toTtitleCase(rs.getString("DESIGNATION"))%></option>
								<%
							}
						}
					%>
					</select>
				<b><font face="arial" size="2">&nbsp;Emp. Type</font></b>
				<select name="EmpType" id="EmpType" style= "width=190px; height=19px; font-size: 10pt; font-family: Times New Roman; font-weight: normal;">
				<%
				qry="select EMPLOYEETYPE, EMPLOYEETYPEDESC from EMPLOYEETYPEMASTER where nvl(DEACTIVE,'N')='N' ";

				//qry="select DISTINCT A.EMPLOYEETYPE,A.EMPLOYEETYPEDESC from EMPLOYEETYPEMASTER A,HR#APPLICATIONMASTER B where nvl(A.DEACTIVE,'N')<>'Y' AND A.EMPLOYEETYPE=B.EMPLOYEETYPE ";
				rs=db.getRowset(qry);
				while(rs.next())
				{
					if(mEmpType.equals(""))
					{
						mEmpType=rs.getString("EMPLOYEETYPE");
						%>
						<option value="<%=mEmpType%>" selected><%=gb.toTtitleCase(rs.getString("EMPLOYEETYPEDESC"))%></option>
						<%
					}
					else
					{
						%>
						<option value="<%=rs.getString("EMPLOYEETYPE")%>" ><%=gb.toTtitleCase(rs.getString("EMPLOYEETYPEDESC"))%></option>
						<%
					}
				}
				%>
				</select>
			</tr>
			<tr>
				<td colspan="3">&nbsp;<b><font face="arial" size="2" color="#4B4B4B">Indent Based</font></b>&nbsp;&nbsp;&nbsp;&nbsp;<input type="Radio" name="ShotlistCriteria" id="ShotlistCriteria" onClick="RadioClick()" value="2"><!-- b><font face="arial" size="2">Requirment Indent</b></font> --><b><font face="arial" size="2" color="#4B4B4B">Indent &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></b>
				<select name="Indent" id="Indent" style= "width=162px; height=19px; font-size: 10pt; font-family: Times New Roman; font-weight: normal;" onChange="fun();">				
				<%
					qry="select INDENTNO,nvl(DESIGNATION,' ')DESIGNATION,INDENTREFNO, to_char(INDENTDATE,'dd-mm-yyyy')INDENTDATE, nvl(DEPARTMENT,' ')DEPARTMENT,decode(TOTALEXPERIENCEREQ,'',' ',TOTALEXPERIENCEREQ)TOTALEXPERIENCEREQ,nvl(to_char(REQUIREDDATE,'dd-mm-yyyy'),' ')REQUIREDDATE,decode(REQUIREDMANPOWER,'',' ',REQUIREDMANPOWER)REQUIREDMANPOWER, nvl(EMPLOYEETYPEDESC,' ')EMPLOYEETYPEDESC,nvl(CATEGORY,' ')CATEGORY from HR#MANPOWERINDENT A,DESIGNATIONMASTER B,EMPLOYEETYPEMASTER C,CATEGORYMASTER D,DEPARTMENTMASTER E where nvl(A.DEACTIVE,'N')<>'Y' and nvl(D.DEACTIVE,'N')<>'Y' and nvl(B.DEACTIVE,'N')<>'Y' and nvl(C.DEACTIVE,'N')<>'Y' and nvl(E.DEACTIVE,'N')<>'Y' and A.AUTORIZEDSTATUS='F' and to_date(A.REQUIREDDATE,'dd-mm-yyyy')<=to_date(sysdate,'dd-mm-yyyy')and A.INDENTDESIGNATIONCODE=B.DESIGNATIONCODE and A.EMPLOYEETYPE=C.EMPLOYEETYPE and D.CATEGORYCODE=A.CATEGORYCODE and E.DEPARTMENTCODE=A.INDENTDEPARTMENTCODE order by INDENTNO";
					//System.out.println(qry);
					rs=db.getRowset(qry);
					while(rs.next())
					{											    
						mValue=gb.toTtitleCase(rs.getString("INDENTREFNO"))+"~~~"+gb.toTtitleCase(rs.getString("REQUIREDMANPOWER"))+"!!!"+gb.toTtitleCase(rs.getString("INDENTDATE"))+"@@@"+gb.toTtitleCase(rs.getString("REQUIREDDATE"))+"$$$"+gb.toTtitleCase(rs.getString("DEPARTMENT"))+"^^^"+gb.toTtitleCase(rs.getString("TOTALEXPERIENCEREQ"))+"```"+gb.toTtitleCase(rs.getString("DESIGNATION"))+"###"+gb.toTtitleCase(rs.getString("EMPLOYEETYPEDESC"))+"&&&"+rs.getString("INDENTNO");					
						if(mIndentNumber.equals(""))
						{
							mIndentNumber=rs.getString("INDENTNO");
							%>
							<option value="<%=mValue%>" selected><%=gb.toTtitleCase(rs.getString("INDENTREFNO"))+" "+" ("+rs.getString("INDENTNO")+")"%></option>
							<%
						}
						else
						{
							%>
							<option value="<%=mValue%>"><%=gb.toTtitleCase(rs.getString("INDENTREFNO"))+"  "+" ("+rs.getString("INDENTNO")+")"%></option>
							<%
						}
					}					
					%>
				</select>
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<center>
				<table cellpadding="0" cellspacing="0" border="0" width="100%" >				
				<tr>
					<td><b><font face="Arial" size="2" color="#4B4B4B">&nbsp;&nbsp;&nbsp;&nbsp;Designation</font></b></td>
					<td>&nbsp;<input type="text" name="Designation2" style= "background-color: #fce9c5; border=0; width=220px; height=19px; font-size: 12pt; font-family: Times New Roman; font-weight: normal;" readonly ></td>
					<td><b><font face="Arial" size="2" color="#4B4B4B">&nbsp;Ind. Date </font></b></td>
					<td>&nbsp;<input type="text" name="IndentDate" style= "background-color: #fce9c5; border=0; width=70Px; height=19px; font-size: 10pt; font-family: Times New Roman; font-weight: normal;" readonly><b><font face="Arial" size="2" color="#4B4B4B">&nbsp;Req. Date </font></b>&nbsp;<input type="text" name="ReqDate" style= "background-color: #fce9c5; border=0; width=70Px; height=19px; font-size: 10pt; font-family: Times New Roman; font-weight: normal;" readonly ></td>					
				</tr>
				<tr>
					<td><b><font face="Arial" size="2" color="#4B4B4B">&nbsp;&nbsp;&nbsp;&nbsp;Emp. Type</font></b></td>
					<td>&nbsp;<input type="text" name="EmpType3" style= "background-color: #fce9c5; border=0; width=220px; height=19px; font-size: 12pt; font-family: Times New Roman; font-weight: normal;"readonly ></td>					
					<td><b><font face="Arial" size="2" color="#4B4B4B">&nbsp;Req. Man </font></b></td>
					<td>&nbsp;<input type="text" name="ManPower" style= "background-color: #fce9c5; border=0; width=30px; height=19px; font-size: 10pt; font-family: Times New Roman; font-weight: normal;" readonly ><b><font face="Arial" size="2" color="#4B4B4B">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Req. Exp. </font></b>&nbsp;<input type="text" name="Exp" style= "background-color: #fce9c5; border=0; width=50px; height=19px; font-size: 10pt; font-family: Times New Roman; font-weight: normal;" readonly ></td>
				</tr>
				<tr>
					<td><b><font face="Arial" size="2" color="#4B4B4B">&nbsp;&nbsp;&nbsp;&nbsp;Department</font></b></td>
					<td colspan=3>&nbsp;<input type="text" name="Department" style= "background-color: #fce9c5; border=0; width=480px; height=19px; font-size: 12pt; font-family: Times New Roman; font-weight: normal;" readonly></td>
				</tr>				
				</table>
				</center>
				</td>
			</tr>
			<tr>
				<td colspan="4"><hr>&nbsp;&nbsp;&nbsp;<input type="radio" name="ShortListWholeApplicant" value="AllApplicant" checked><b><font face="arial" size="2">Short List all Applicants.</font></b>
				<input type="radio" name="ShortListWholeApplicant" value="TopApplicant"><b><font face="arial" size="2">Short List top</b> (as per the Experience) <b><input type="text" name="NoTopApplicant" value=<%=20%> maxlength=3 size="3" style="height=20px;" onkeypress="return isNumber(event)"> Applicants</font></b></td>
			</tr>
			<tr>
				<td colspan="4"><hr><b><font color="navy" size="2" face="arial">Order By</font></b><br>&nbsp;&nbsp;&nbsp;<input type="radio" name="OrderBy" value="EXPERIENCEINMONTHS"><b><font face="arial" size="2">Experience</font></b>&nbsp;<input type="radio" name="OrderBy" value="APPLICANTNAME" checked><b><font face="arial" size="2">Name</font></b>&nbsp;<input type="radio" name="OrderBy" value="DATESUB"><b><font face="arial" size="2">Date of Summation</font></b>&nbsp;&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="Asending" value="DESC"><b><font face="arial" size="2">Descending</font></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="Submit" name="Shortlistnow" value="Short List Now" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 120px; HEIGHT: 20px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;"></td>
			</tr>
			</table>
			</center>
		<%
		}
		else
		{
			%>
				<br>
				<font color=red>
				<h3><br><img src='images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
				<P>	This page is not authorized/available for you.
				<br>For assistance, contact your network support team. 
				</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{	
	/*out.print("Exception e"+e);	*/
}
%>
</form>
</body>
</html>