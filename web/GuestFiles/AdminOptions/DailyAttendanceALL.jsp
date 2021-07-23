<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  

String qry="",mWebEmail="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null, Rs=null;
String mMemberID="",mMemberType="",mMemberCode="",mCurDate="";
String mEmpName="",mWorkDt="",mCompCode="",mInst="",mEID="";
String LoginIDTime="";
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
if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}

/*if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}*/

if(request.getParameter("WorkDt")==null)
	{
		mWorkDt="";
	}
	else
	{
		mWorkDt=request.getParameter("WorkDt").toString().trim();
	}

if(request.getParameter("EID")==null)
	{
		mEID="";
	}
	else
	{
		mEID=request.getParameter("EID").toString().trim();
	}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Daily Attendance] </TITLE>
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
	
	
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('190','"+mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
		qry="SELECT COMPANYCODE,EMPLOYEENAME FROM EMPLOYEEMASTER where EMPLOYEEID='"+mEID+"' and COMPANYCODE='"+mCompCode+"' ";
		//out.println(qry);
		//out.println(qry);
		rs=db.getRowset(qry);
		if(rs.next())
		   {
			mEmpName=rs.getString("EMPLOYEENAME");
			//mCompCode=rs.getString("COMPANYCODE");
		   }
%>
	<form name="frm"  method="post" >
	<input id="x" name="x" type=hidden>
	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Attendance Detail of <%=mEmpName%> for <br>the Working Date <%=mWorkDt%></B></font></TD>
	</font></td></tr>
	</TABLE>
	<br>
	<br>
		
	<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center >
	<thead>
	<tr bgcolor="#ff8c00">
	<td align=center nowrap><font color=white><B>Login Time</B></font></td>
	<td align=center nowrap><font color=white><B>Logout Time</B></font></td>
	<td align=center nowrap><font color=white><B>Attendance Status</B></font></td>
	<td align=center nowrap><font color=white><B>Login Terminal</B></font></td>
	<td align=center nowrap><font color=white><B>Logout Terminal</B></font></td>
	<td align=center nowrap><font color=white><B>Worked in Minutes</B></font></td>
	</tr>
	</thead>
	<tbody>
	<% int Time=0,TotalWork,TotalHrs;
		qry="select to_char(INTIME,'HH:MI PM')INTIME, nvl(to_char(OUTTIME,'HH:MI PM'),' ')OUTTIME, nvl(WORKHRS_MINUTE,0) WORKHRS_MINUTE,decode(ISMANUAL,'Y','Manual','N','By Card','By Card',ISMANUAL)ISMANUAL,decode(trim(INTERMINAL),'00','Registrar Office','01','Faculty-LRC','02','Tel.Exchange Room(Ist Floor)','03','Data Room(Ist Floor)',INTERMINAL)INTERMINAL,decode(trim(OUTTERMINAL),'00','Registrar Office','01','Faculty-LRC','02','Tel.Exchange Room(Ist Floor)','03','Data Room(Ist Floor)','',' ',OUTTERMINAL)OUTTERMINAL from Att_AttendLog where INSTITUTECODE='"+mInst+"' and USERID='"+mEID+"' and USERTYPE='"+mChkMType+"' and to_char(WORKINGDATE,'dd-Mon-yyyy')='"+mWorkDt+"' and COMPANYCODE='"+mCompCode+"' order by WorkingDate,InTime";
		//out.println(qry);
		rs=db.getRowset(qry);
		while(rs.next())
		   {

			%>
			<tr>
			<td align=center>&nbsp;<%=rs.getString("INTIME")%></td>	
			<td align=center>&nbsp;<%=rs.getString("OUTTIME")%></td>	
			<td align=center>&nbsp;<%=rs.getString("ISMANUAL")%></td>	
			<td align=center>&nbsp;<%=rs.getString("INTERMINAL")%></td>	
			<td align=center>&nbsp;<%=rs.getString("OUTTERMINAL")%></td>	
			<td align=center>&nbsp;<%=rs.getInt("WORKHRS_MINUTE")%></td>	
		    </tr>
			 <%
			if(rs.getString("WORKHRS_MINUTE")!=null)
			   {
					Time=Time + rs.getInt("WORKHRS_MINUTE");
			   }
		   }
			%>
			</tbody>
			
			<%
TotalWork=(Time/60);
TotalHrs=Time-(TotalWork*60);
%>
<tr>
<td align=right colspan=6><FONT 
      face="verdana" size=2><b>Total Worked:&nbsp; <%=TotalWork%>                      &nbsp;Hrs. <%=TotalHrs%> Min.</b></FONT></td>
</tr>
</table>
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
//	out.println(e.getMessage());
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
