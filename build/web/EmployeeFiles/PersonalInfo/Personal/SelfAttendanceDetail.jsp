<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  
String qry="",mWebEmail="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

GlobalFunctions gb =new GlobalFunctions();

ResultSet rs=null, Rs=null;

String mMemberID="",mMemberType="",mMemberCode="",mCurDate="";
String mDateFrom="",mDateTo="",mEmpName="",mCompCode="",mInst="";

qry="select to_Char(Sysdate,'dd-mm-yyyy')date1 from dual";
rs=db.getRowset(qry);
rs.next();
mCurDate=rs.getString("date1");
try
{
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mCompCode="";
}
else
{
	mCompCode=session.getAttribute("CompanyCode").toString().trim();
}
//out.println(mCompCode);

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

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Self Attendance] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
</head>
<body  topmargin=4 rightmargin=0 leftmargin=0 bottommargin=0 bgColor="#fce9c5">
<% 
if(!mMemberID.equals("") || !mMemberCode.equals(""))
{
mMemberID=enc.decode(mMemberID);
mMemberCode=enc.decode(mMemberCode);
	
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;

	String  LoginIDTime="";
	HttpSession sess = request.getSession();
	LoginIDTime= sess.getId();

		if(LoginIDTime.length() >= 20)
			LoginIDTime=LoginIDTime.substring(0,20);

	//out.println(LoginIDTime);
	
	qry="Select WEBKIOSK.ShowLink('185','"+mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
		qry="SELECT COMPANYCODE,EMPLOYEENAME FROM EMPLOYEEMASTER where EMPLOYEEID='"+mChkMemID+"' and COMPANYCODE='"+mCompCode+"' ";
		//out.println(qry);
		rs=db.getRowset(qry);
		if(rs.next())
		   {
			mEmpName=rs.getString("EMPLOYEENAME");
		   }
		  
%>
	<form name="frm"  method="post" >
	<input id="x" name="x" type=hidden>
	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Attendance Detail of <%=mEmpName%></font></TD>
	</font></td></tr>
	</TABLE>
	<%
	if (request.getParameter("x")!=null)
	{
	mDateFrom=request.getParameter("DATE1").toString().trim();
	mDateTo=request.getParameter("DATE2").toString().trim();
	}
	else
	{
	mDateFrom=mCurDate;
	mDateTo=mCurDate;
	}
	%>
	<TABLE rules=none cellSpacing=1 cellPadding=4 border=2 align=center width=70%>
	<tr><td nowrap><font color=black face=arial font size=2><b>Attendance From The Period</b></font><font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font></td>
	<td><INPUT TYPE="text" NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE='<%=mDateFrom%>' readonly
	><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
	</td><td><b>&nbsp;to&nbsp;</b></td>
	<td><INPUT TYPE="text" NAME=DATE2 ID=DATE2 size=9 tabindex=2
	VALUE='<%=mDateTo%>' readonly><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;</td>
	<TD><INPUT TYPE="submit"  VALUE="Show"></TD> 
	</tr>
	</table>
	</form>
	<%
	if (request.getParameter("x")!=null)
	{
	if(request.getParameter("DATE1")==null)
		mDateFrom="";
	else
		mDateFrom=request.getParameter("DATE1").toString().trim();
	
	if(request.getParameter("DATE2")==null)
		mDateTo="";
	else
		mDateTo=request.getParameter("DATE2").toString().trim();
		
	
	db.WeekReg4JSP(mDateFrom,mDateTo,mChkMemID,mChkMType,
	mCompCode,LoginIDTime,"Y","Y","Y","Y","Y","Y","Y","Y",mInst,"Y");

	%>
	<table ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B><u>Available List</u> </B></TD>
	</font></td>	
	</table>
	<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center  >
	<thead>
	<tr bgcolor="#ff8c00">
	<td align=center nowrap><font color=white><B>Working Date</B></font></td>
	<td align=center nowrap><font color=white><B>Attendance Status</B></font></td>
	</tr>
	</thead>
	<tbody>
	<%
		qry="SELECT  MEMBERID, to_char(WORKINGDATE,'dd-mm-yyyy')WORKINGDATE, nvl(LEAVESTATUS,' ')LEAVESTATUS,COMPANYCODE,MEMBERTYPE,LOGINCARDIDTIME FROM ATT_TEMPWEEKREC where  MEMBERID='"+mChkMemID+"' and COMPANYCODE='"+mCompCode+"' and LOGINCARDIDTIME='"+LoginIDTime+"' and trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) ";
		//out.println(qry);
		rs=db.getRowset(qry);
		while(rs.next())
		   {
			%>
			<tr>
			<%
			if(rs.getString("LEAVESTATUS").equals("P"))
			{
			%>
			<td><a title="Click to View Detail" target=New_ href="DailyAttendance.jsp?WorkDt=<%=rs.getString("WORKINGDATE")%>"><%=rs.getString("WORKINGDATE")%></a></td>	
			<td align=center><font color=green size=2><b>Present</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("F"))
			{
			%>
			<td><a title="Click to View Detail" target=New_ href="DailyAttendance.jsp?WorkDt=<%=rs.getString("WORKINGDATE")%>"><%=rs.getString("WORKINGDATE")%></a></td>	
			<td align=center><font color=brown size=2><b>Half Day</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("A"))
			{
			%>
			<td>
			<%=rs.getString("WORKINGDATE")%></td>	
			<td align=center><font color=red size=2><b>Absent</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("W"))
			{
			%>
			<td><%=rs.getString("WORKINGDATE")%></td>	
			<td align=center><font color=yellow size=2><b>LWP</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("O"))
			{
			%>
			<td><%=rs.getString("WORKINGDATE")%></td>	
			<td align=center><font color=purple size=2><b>Weekly Off</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("IN"))
			{
			%>
			<td><a title="Click to View Detail" target=New_ href="DailyAttendance.jsp?WorkDt=<%=rs.getString("WORKINGDATE")%>">
			<%=rs.getString("WORKINGDATE")%></a></td>	
			<td align=center><font color=mazenta size=2><b>Current Day</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("L"))
			{
			%>
			<td><%=rs.getString("WORKINGDATE")%></td>	
			<td align=center><font color=#f04443 size=2><b>Leave</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("H"))
			{
			%>
			<td><%=rs.getString("WORKINGDATE")%></td>	
			<td align=center><font color=#a2ab49 size=2><b>Holiday</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("V"))
			{
			%>
			<td><%=rs.getString("WORKINGDATE")%></td>	
			<td align=center><font color=#0a0403 size=2><b>Vacation</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("T"))
			{
			%>
			<td><%=rs.getString("WORKINGDATE")%></td>	
			<td align=center><font color=#ff4443 size=2>Tour</font></td>
			<%
			}
			%>
			 
			 </tr>
			 <%
		   }
			%>
			</tbody>
			</table>
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
	<h3>	<br><img src='.../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}//end of try
catch(Exception e)
{
	out.println(e.getMessage());
}

%>
<!-- <center>
	<table ALIGN=Center VALIGN=TOP>
	<tr>
	<td valign=middle>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
	A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
	<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 		</td></tr></table> -->
</body>
</Html>
