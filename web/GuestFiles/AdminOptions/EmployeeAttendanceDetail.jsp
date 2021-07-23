<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  
String qry="",qry1="",qryname="",mWebEmail="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

GlobalFunctions gb =new GlobalFunctions();

ResultSet rs=null, rs1=null,rsname=null;

String mMemberID="",mMemberType="",mMemberCode="",mCurDate="", mRightsID="", mSRCType="", mHeading="";
String mDateFrom="",mDateTo="",mEmpName="",mCompCode="",mInst="",mDN="";
String mEmpCode="",QryDept="",mAttType="",mEmpID="",mDeptCode="",mDCode="",mDept="",mDName="";

int SrNo=0;
String mColor="",mECode="";

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

/*if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}*/

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
	mDCode="";
}
else
{
	mDCode=session.getAttribute("DepartmentCode").toString().trim();
}

if(request.getParameter("ECD")==null)
{
	mECode="";
}
else
{
	mECode=request.getParameter("ECD").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

if(request.getParameter("SRCType")==null)
	mSRCType="A";
else
	mSRCType=request.getParameter("SRCType").toString().trim();

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ ALL Attendance of Employees] </TITLE>
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
	
	if(mSRCType.equals("A"))
	{
		mRightsID="190";
		mHeading="Self Attendance Detail";
	}
	else if(mSRCType.equals("H"))
	{
		mRightsID="206";
		mHeading="Departmental Attendance Detail";
	}

	qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
				  
%>
	<form name="frm"  method="post" >
	<input id="x" name="x" type=hidden>
	<input id="SRCType" name="SRCType" type=hidden value="<%=mSRCType%>">
	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><%=mHeading%></B></font></TD>
	</font></td></tr>
	</TABLE>

	<table cellspacing=0 cellpadding=0 align=center border=2>
	<tr>
	<td nowrap><font color=black face=arial size=2><STRONG>Attendance Report</STRONG></font>&nbsp;&nbsp;

	<select name="AttType" tabindex="0" id="AttType" style="WIDTH: 80px">	
		<%
		if(request.getParameter("x")==null)
		   {
				mAttType="ALL";
				%>
				<option selected Value="D">Detailed</option>
				<option Value="S">Summary</option>
				<%							
		   }
		   else
		   {
			   if(request.getParameter("AttType").equals("D"))
					{
					%>
					<option selected Value="D">Detailed</option>
					<option Value="S">Summary</option>
					<%
					}
						
			 else if(request.getParameter("AttType").equals("S"))
					{
					%>
					<option selected Value="S">Summary</option>
					<option Value="D">Detailed</option>
					<%
					}
			 }
%>
</select>&nbsp;&nbsp;

	<span><font color=black face=arial size=2><STRONG>Attendance For Department</STRONG></font></span>
<%
	if(mSRCType.equals("A"))
	{
		qry="select DEPARTMENT,DEPARTMENTCODE from DepartmentMaster where nvl(Deactive,'N')='N' and DEPARTMENT is not null";
		rs=db.getRowset(qry);
		if(request.getParameter("x")==null)
		{
			QryDept="ALL";
			%>
			<select name="Dept" id="Dept" tabindex="0">
			<option selected value="ALL">ALL</option>
			<%
			while(rs.next())
			{
				mDept=rs.getString("DEPARTMENT");
				mDeptCode=rs.getString("DEPARTMENTCODE");
				%>
				<option value =<%=mDeptCode%>><%=mDept%></option>
				<%
			}
		}
		else
		{
			%>	
			<select name="Dept" tabindex="0" id="Dept">	
			<%
			if(request.getParameter("Dept").toString().trim().equals("ALL"))
			{
				%>
				<option selected value="ALL">ALL</option>
				<%
			}
			else
			{	
				%>
				<option value="ALL">ALL</option>
				<%
			}
			while(rs.next())
			{
				mDept=rs.getString("DEPARTMENT");
				mDeptCode=rs.getString("DEPARTMENTCODE");
		
				if(mDeptCode.equals(request.getParameter("Dept").toString().trim()))
				{
					QryDept=mDeptCode;
					%>
					<option selected value =<%=mDeptCode%>><%=mDept%></option>
					<%
				}
				else
				{
					%>
					<option  value =<%=mDeptCode%>><%=mDept%></option>
					<%
				}
			}
		}
	}
	else if(mSRCType.equals("H"))
	{
		qry="select DEPARTMENT,DEPARTMENTCODE from DepartmentMaster where nvl(Deactive,'N')='N' and DEPARTMENT is not null and Departmentcode='"+mDCode+"'";
		rs=db.getRowset(qry);
		if(request.getParameter("x")==null)
		{
			%>
			<select name="Dept" id="Dept" tabindex="0">
			<%
			while(rs.next())
			{
				mDept=rs.getString("DEPARTMENT");
				QryDept=mDeptCode;
				mDeptCode=rs.getString("DEPARTMENTCODE");
				%>
				<option value =<%=mDeptCode%>><%=mDept%></option>
				<%
			}
		}
		else
		{
			%>	
			<select name="Dept" tabindex="0" id="Dept">	
			<%
			while(rs.next())
			{
				mDept=rs.getString("DEPARTMENT");
				mDeptCode=rs.getString("DEPARTMENTCODE");
		
				if(mDeptCode.equals(request.getParameter("Dept").toString().trim()))
				{
					QryDept=mDeptCode;
					%>
					<option selected value =<%=mDeptCode%>><%=mDept%></option>
					<%
				}
				else
				{
					%>
					<option  value =<%=mDeptCode%>><%=mDept%></option>
					<%
				}
			}
		}
	}
	%>
	</select>
	</td>
	</tr>
	<tr>
	<td nowrap><font color=black face=arial size=2><STRONG>Attendance for Employee Code</STRONG></font>
	<INPUT type="text" id="EmpCode" name="EmpCode" style="FONT-SIZE: x-small; WIDTH: 100px; HEIGHT: 20px" size=11 value="<%=mECode%>">&nbsp; 
	<A TITLE="Click To View" HREF="EmployeeList.jsp?SRCType=<%=mSRCType%>"><STRONG><font  color=Blue  face=sans-serif size=3>....</font></STRONG></A> <font  color=green face='arial' size=1><b>Search Employee</b></font>  &nbsp; &nbsp;<font color=Teal><i>leave blank to list all employee</i></font></td>
	</tr>

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
	<tr><td nowrap><font color=black face=arial font size=2><b>Attendance From The Period</b></font><font color=green face=arialblack font size=1><b> 
	( DD-MM-YYYY )&nbsp;</b></font>&nbsp;&nbsp;<INPUT TYPE="text" NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE='<%=mDateFrom%>' readonly
	><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
	<b>&nbsp;to&nbsp;</b>&nbsp;<INPUT TYPE="text" NAME=DATE2 ID=DATE2 size=9 tabindex=2
	VALUE='<%=mDateTo%>' readonly><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit"  VALUE="View Attendance"></TD> 
	</tr>
	</table>
	</form>
	<%
	if(request.getParameter("x")!=null)
	{
	if(request.getParameter("AttType")==null)
		mAttType="";
	else
		mAttType=request.getParameter("AttType").toString().trim();

	if(request.getParameter("Dept")==null)
		QryDept="";
	else
		QryDept=request.getParameter("Dept").toString().trim();

	if(request.getParameter("EmpCode")==null)
		mEmpCode="";
	else
		mEmpCode=request.getParameter("EmpCode").toString().trim();
	

	if(request.getParameter("DATE1")==null)
		mDateFrom="";
	else
		mDateFrom=request.getParameter("DATE1").toString().trim();
	
	if(request.getParameter("DATE2")==null)
		mDateTo="";
	else
		mDateTo=request.getParameter("DATE2").toString().trim();

if(QryDept.equals("ALL"))
{
	QryDept="";
	mDName="Attendance for All Department";
}
else
{
qryname="select nvl(DepartMent,' ')DepartMent from DepartMentMaster where DepartmentCode='"+QryDept+"' ";
	rsname=db.getRowset(qryname);	
	if(rsname.next())
	{
		mDN=rsname.getString("DepartMent");
	}
	mDName="Attendance for the Department of "+mDN+" ("+QryDept+")";
}		
	if(mAttType.equals("S"))
		{
			if(mEmpCode.equals(""))
			{
				//public void WeekReg4JSPAll(String AccFdate ,String AccTDate, String pDeptCode ,String CompCode, String pLoginCardIDTime, String LWPInclude ,String ODInclude ,String WInclude ,String AbsentInclude, String LeaveInclude ,String PresentInclude, String HoliDayInclude, String VacationInclude , String InstCode, String PresentWhenOneSwap)
				//out.print("SS"+QryDept);
				db.WeekReg4JSPAll(mDateFrom,mDateTo,QryDept,mCompCode,LoginIDTime,
					"Y","Y","Y","Y","Y","Y","Y","Y",mInst,"Y");
			}
			else
			{
				qry1="select EmployeeID from V#EmployeeList where EmployeeCode='"+mEmpCode+"' and CompanyCode='"+mCompCode+"' ";
				//out.println(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{
					mEmpID=rs1.getString("EmployeeID");
				}
				//out.println("Employee id"+mEmpID);
				db.WeekReg4JSP(mDateFrom,mDateTo,mEmpID,mChkMType,
				mCompCode,LoginIDTime,"Y","Y","Y","Y","Y","Y","Y","Y",mInst,"Y");
			}
			
			if (QryDept.equals("") && mEmpCode.equals(""))
				{
					qry = "select distinct a.MEMBERID,a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE,nvl(b.LeaveStatus,'')LeaveStatus,a.COMPANYCODE from att_tempweekrec b, v#allmembers a  where a.COMPANYCODE =b.COMPANYCODE  and a.COMPANYCODE ='"+mCompCode+"' and a.MEMBERID=b.MemberID  and a.MemberType= b.MemberType and a.MemberType='E' and b.LOGINCARDIDTIME='"+LoginIDTime+"' and 	trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy')))	order by a.EmployeeName,to_date(workingdate,'dd-mm-yyyy') desc";
				}
			else if (QryDept.equals("") && !mEmpCode.equals(""))
				{
 					qry="select distinct a.MEMBERID,a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE,nvl(b.LeaveStatus,'')LeaveStatus,a.COMPANYCODE from att_tempweekrec b, v#allmembers a  where a.COMPANYCODE =b.COMPANYCODE  and a.COMPANYCODE ='"+mCompCode+"' and a.MEMBERID=b.MemberID and b.MemberID='"+mEmpID+"' and a.MemberType= b.MemberType and a.MemberType='E' and b.LOGINCARDIDTIME='"+LoginIDTime+"' and trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) order by EmployeeName,to_date(workingdate,'dd-mm-yyyy') desc";
				}
			else if(!QryDept.equals("") && mEmpCode.equals("")) 
				{
					qry="select distinct a.MEMBERID,a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE,nvl(b.LeaveStatus,'')LeaveStatus,a.COMPANYCODE from att_tempweekrec b, v#allmembers a  where a.COMPANYCODE =b.COMPANYCODE  and a.COMPANYCODE ='"+mCompCode+"' and a.MEMBERID=b.MemberID  and a.DEPARTMENTCODE ='"+QryDept+"' and a.MemberType= b.MemberType and a.MemberType='E' and b.LOGINCARDIDTIME='"+LoginIDTime+"' and trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) order by EmployeeName,to_date(workingdate,'dd-mm-yyyy') desc";
				}
			else if (!QryDept.equals("") && !mEmpCode.equals(""))
				{
					qry="select distinct a.MEMBERID,a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE,nvl(b.LeaveStatus,'')LeaveStatus,a.COMPANYCODE from att_tempweekrec b, v#allmembers a  where a.COMPANYCODE =b.COMPANYCODE  and a.COMPANYCODE ='"+mCompCode+"' and a.MEMBERID=b.MemberID  and b.MemberID='"+mEmpID+"' and a.DEPARTMENTCODE ='"+QryDept+"' and a.MemberType= b.MemberType and a.MemberType='E' and b.LOGINCARDIDTIME='"+LoginIDTime+"' and trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) order by EmployeeName,to_date(workingdate,'dd-mm-yyyy') desc"; 
				}
			//out.println(qry);
			%>
	
	<table ALIGN=CENTER bottommargin=0 topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B><%=mDName%></B></TD>
	</font></td>	
	</table>
	<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center  >
	<thead>
	<tr bgcolor="#ff8c00">
	<td align=center nowrap><font color=white><B>Employee Code</B></font></td>
	<td align=center nowrap><font color=white><B>Employee Name</B></font></td>
	<td align=center nowrap><font color=white><B>Designation</B></font></td>
	<td align=center nowrap><font color=white><B>Working Date</B></font></td>
	<td align=center nowrap><font color=white><B>Attendance Status</B></font></td>
	</tr>
	</thead>
	<tbody>
	<%

		rs=db.getRowset(qry);
		while(rs.next())
		   {
			SrNo++;
				if(SrNo%2==0)
					mColor="white";
				else if(SrNo%2==1)
					mColor="#F1F1F1";
				else
					mColor="";
			%>
			<tr bgcolor="<%=mColor%>">
			<td align=center><%=rs.getString("MemberCode")%></td>	
			<td align=left><%=rs.getString("EmployeeName")%></td>	
			<td align=left><%=rs.getString("Designation")%></td>	

			<%
			if(rs.getString("LEAVESTATUS").equals("P"))
			{
			%>
			<td><a title="Click to View Detail" target=New_ href="DailyAttendanceALL.jsp?WorkDt=<%=rs.getString("WORKINGDATE")%>&amp;EID=<%=rs.getString("MEMBERID")%>"><%=rs.getString("WORKINGDATE")%></a></td>	
			<td align=center><font color=green size=2><b>Present</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("F"))
			{
			%>
			<td><a title="Click to View Detail" target=New_ href="DailyAttendanceALL.jsp?WorkDt=<%=rs.getString("WORKINGDATE")%>&amp;EID=<%=rs.getString("MEMBERID")%>"><%=rs.getString("WORKINGDATE")%></a></td>	
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
			<td align=center><font color=paleyellow size=2><b>LWP</b></font></td>
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
			<td><a title="Click to View Detail" target=New_ href="DailyAttendanceALL.jsp?WorkDt=<%=rs.getString("WORKINGDATE")%>&amp;EID=<%=rs.getString("MEMBERID")%>">
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
			<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","String","Number","Number","String","String"]);
			</script>
		<center>
		<Pre>
		<P align=left>
		<Marquee  bgcolor=Tan  scrolldelay=200>Click on Working date to show In/Out Detailed</marquee>
		<br>
		<u>Note: </u>  
		   i.  Attendanace record(s) are based on Smart card showing/punching. 
		   ii. <b>Current Day (IN)</b> attendance status may change next day.
		</Pre>   
		</center>
<%
	}
else if(mAttType.equals("D"))
	{	
		qry1="select EmployeeID from V#EmployeeList where EmployeeCode='"+mEmpCode+"' and CompanyCode='"+mCompCode+"' ";
				//out.println(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{
					mEmpID=rs1.getString("EmployeeID");
				}
			//out.println("Employee id"+mEmpID);
				
	if (QryDept.equals("") && mEmpCode.equals(""))
				{
					qry = "select a.MemberCode, a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi:ss PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),' ')OUTTIME from ATT_ATTENDLOG  b, v#allmembers a  where b.InstiTuteCode=a.InstituteCode and a.InstituteCode='"+mInst+"' and a.MEMBERID=b.USERID  and a.MemberType= b.USERTYPE and a.MemberType='"+mChkMType+"' And trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) order by EmployeeName,to_date(workingdate,'dd-Mon-yyyy') desc";
				}
	else if (QryDept.equals("") && !mEmpCode.equals(""))
				{			
					qry = "select a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi:ss PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),' ')OUTTIME  from ATT_ATTENDLOG  b, v#allmembers a  where b.InstiTuteCode = a.InstituteCode and a.InstituteCode='"+mInst+"' and a.MEMBERID=b.USERID  and b.UserID='"+mEmpID+"' and a.MemberType= b.USERTYPE and a.MemberType='E' And trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) order by EmployeeName,to_date(workingdate,'dd-Mon-yyyy') desc";
				}
	else if(!QryDept.equals("") && mEmpCode.equals("")) 
				{
					qry="select a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi:ss PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),' ')OUTTIME  from ATT_ATTENDLOG  b, v#allmembers a  where b.InstiTuteCode  = a.InstituteCode and a.InstituteCode='"+mInst+"' and a.MEMBERID=b.USERID  and  a.DEPARTMENTCODE ='"+QryDept+"' and a.MemberType= b.USERTYPE and a.MemberType='E' And trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) order by EmployeeName,to_date(workingdate,'dd-Mon-yyyy') desc";
				}
	else if (!QryDept.equals("") && !mEmpCode.equals(""))
				{
					qry="select a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi:ss PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),' ')OUTTIME  from ATT_ATTENDLOG  b, v#allmembers a  where b.InstiTuteCode= a.InstituteCode And a.InstituteCode='"+mInst+"' and a.MEMBERID=b.USERID  and  a.DEPARTMENTCODE ='"+QryDept+"' and b.UserID='"+mEmpID+"' and a.MemberType= b.USERTYPE and a.MemberType='E' And trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) order by EmployeeName,to_date(workingdate,'dd-Mon-yyyy') desc";
				}
	//out.println(qry);

%>
	<table ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B><%=mDName%></B></TD>
	</font></td>	
	</table>
	<table class="sort-table" id="table-2" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center  >
	<thead>
	<tr bgcolor="#ff8c00">
	<td align=center nowrap><font color=white><B>Employee Code</B></font></td>
	<td align=center nowrap><font color=white><B>Employee Name</B></font></td>
	<td align=center nowrap><font color=white><B>Designation</B></font></td>
	<td align=center nowrap><font color=white><B>Working Date</B></font></td>
	<td align=center nowrap><font color=white><B>IN Time</B></font></td>
	<td align=center nowrap><font color=white><B>OUT Time</B></font></td>
	</tr>
	</thead>
	<tbody>
	<%
		rs=db.getRowset(qry);
		while(rs.next())
		   {
			SrNo++;
				if(SrNo%2==0)
					mColor="white";
				else if(SrNo%2==1)
					mColor="#F1F1F1";
				else
					mColor="";
			%>
			<tr bgcolor="<%=mColor%>">
			<td nowrap align=center>&nbsp;<%=rs.getString("MemberCode")%></td>	
			<td nowrap align=left>&nbsp;<%=rs.getString("EmployeeName")%></td>	
			<td nowrap align=left>&nbsp;<%=rs.getString("Designation")%></td>	
			<td nowrap align=center>&nbsp;<%=rs.getString("WORKINGDATE")%></td>	
			<td nowrap align=center>&nbsp;<%=rs.getString("InTime")%></td>	
			<td nowrap align=center>&nbsp;<%=rs.getString("OutTime")%></td>	
			</tr>
			<%
			}
%>
	</tbody>
	</TABLE>
		<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-2"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","Date","Date","Date"]);
		</script>
<%
	}
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
	//out.println(e.getMessage());
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
