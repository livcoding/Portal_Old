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
String LoginIDTime="", mDeptCode="", mRightsID="", mSRCType="";
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

if (session.getAttribute("DepartmentCode")==null)
{
    mDeptCode="";
}
else
{
    mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
}

if(request.getParameter("SRCType")==null)
	mSRCType="";
else
	mSRCType=request.getParameter("SRCType").toString().trim();

if(mSRCType.equals("A"))
{
	mRightsID="190";
}
else if(mSRCType.equals("H"))
{
	mRightsID="206";
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Employee Lists] </TITLE>
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
	qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
	%>
	<form name="frm"  method="post" >
	<input id="x" name="x" type=hidden>
	<input id="SRCType" name="SRCType" type=hidden value="<%=mSRCType%>">
	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Employee Search</b></font></TD>
	</font></td></tr>
	</TABLE>
	<table id=id1 ALIGN=CENTER  border=2 cellspacing=0 cellpadding=1>
		<TR>
		<TD valign=top><FONT COLOR=BLACK SIZE=2 FACE='ARIAL'><STRONG>Employee Name (Like in Capital Letters)</strong>&nbsp;&nbsp;
		<INPUT TYPE="text" NAME="EmpName" id="EmpName">
		&nbsp;&nbsp;
		<INPUT id=Submit style="FONT-SIZE: x-small; VERTICAL-ALIGN: top; WIDTH: 75px; FONT-FAMILY:    Arial; HEIGHT: 25px" tabIndex=3 type=submit value=Search name=Submit height="19" ></font>

		</td></tr>
	</table>	
	</form>
<%
if(request.getParameter("x")!=null)
{
 if(request.getParameter("EmpName")==null)
	{
	 mEmpName="";
	}
	else
	{
		//mEmpName=UCASE("%"+(request.getParameter("EmpName").trim())+"%");
		mEmpName=request.getParameter("EmpName").toString().trim();
	}
%>
	<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center >
	<thead>
	<tr bgcolor="#ff8c00">
	<td align=center nowrap><font color=white><B>Employee Code</B></font></td>
	<td align=center nowrap><font color=white><B>Employee Name</B></font></td>
	<td align=center nowrap><font color=white><B>Designation</B></font></td>
	<td align=center nowrap><font color=white><B>Department</B></font></td>
	</tr>
	</thead>
	<tbody>
	<% 
	if(mDeptCode.equals("") || !mRightsID.equals("206"))
	{
		qry="select  employeeid,nvl(EmployeeCode,'Not Assigned')EmployeeCode,EmployeeName,Designation,Department From  v#Employeelist where EmployeeName Like ('%"+mEmpName+"%') and CompanyCode='"+mCompCode+"' order by EmployeeName";
	}
	else
	{
		qry="select  employeeid,nvl(EmployeeCode,'Not Assigned')EmployeeCode,EmployeeName,Designation,Department From  v#Employeelist where EmployeeName Like ('%"+mEmpName+"%') and CompanyCode='"+mCompCode+"' and DepartmentCode='"+mDeptCode+"' order by EmployeeName";
	}
	//out.println(qry);
	rs=db.getRowset(qry);
	if(rs.next())
	{
		while(rs.next())
		{
			%>
			<tr>
			<td nowrap align=center>&nbsp;<%=rs.getString("EmployeeCode")%></td>	
			<td nowrap align=left>&nbsp;<A Title="Click Employee Name To View Detail"HREF="EmployeeAttendanceDetail.jsp?SRCType=<%=mSRCType%>&amp;ECD=<%=rs.getString("EmployeeCode")%>"><%=rs.getString("EmployeeName")%></A></td>	
			<td nowrap align=left>&nbsp;<%=rs.getString("Designation")%></td>	
			<td nowrap align=left>&nbsp;<%=rs.getString("Department")%></td>	
			</tr>
			<%
		}
		%>
		<tr>
		<td colspan=4 align=middle><FONT face="Arial" size=2 color=Green><STRONG>List of Employee 
		(Please click a Employee Name)</STRONG></FONT></td> 	  
		</tr>
		</tbody>
		</table>
		
<%
		}
		else
		{
			%>
			<TABLE ALIGN=CENTER>
			<br>
			<TD>
			<FONT FACE=ARIAL SIZE=2 Color="red"><B>Please 
			Enter a valid/Existing Employee Name</B></FONT>
			</TD>
			</TABLE>
<%
		}
//-----------------------------
//-- Enable Security Page Level  
//-----------------------------
}
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
