<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  

String qry="",qry1="",qryname="",mWebEmail="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

GlobalFunctions gb =new GlobalFunctions();

ResultSet rs=null, rs1=null,rsname=null;

String mMemberID="",mMemberType="",mMemberCode="",mCurDate="";
String mDateFrom="",mDateTo="",mEmpName="",mCompCode="",mInst="",mDN="";
String mEmpCode="",QryDept="",mAttType="",mEmpID="",mDeptCode="",mDept="",mDName="";
String mArrTime="",mDepTime="",mATime="",mDTime="";
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


if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
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
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Early Late Attendance of Employees] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<script type="text/javascript" src="js/TimePicker.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

</head>
<!-- <body  topmargin=4 rightmargin=0 leftmargin=0 bottommargin=0 bgColor="#fce9c5"> -->
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>

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

	
	qry="Select WEBKIOSK.ShowLink('191','"+mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {

			if(request.getParameter("x")==null)
		   {
				mArrTime="10:00 am";
				mDepTime="5:00 pm";
		   }
		   else
		   {
			   mArrTime=request.getParameter("ArrivalTime");
   			   mDepTime=request.getParameter("DepTime");
		   }
				  
%>
	<form name="frm"  method="post" >
	<input id="x" name="x" type=hidden>
	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"><b>Employee Late Arrival and Early Departure Attendance List</B></font></TD>
	</font></td></tr>
	</TABLE>

	<table cellpadding=2 cellspacing=0 width="90%" align=center rules=groups border=2>
	<tr><td>
	<font color=black face=arial size=2><STRONG>Attendance For Department</STRONG></font>
<%
	//qry="select DEPARTMENT,DEPARTMENTCODE from DepartmentMaster where nvl(Deactive,'N')='N' and DEPARTMENT is not null";
	qry="select distinct B.DEPARTMENTCODE , nvl(A.DEPARTMENT,' ')DEPARTMENT from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N' and B.companycode in (select companycode from companyinstitutetagging where companycode='"+mCompCode+"' and institutecode='"+mInst+"')";
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
	%>
	</select>
	</td></tr>
	<tr valign=bottom>
	<td valign=bottom><font color=black face=arial size=2><STRONG>Arrival After</STRONG></font>
	<input id='ArrivalTime' name='ArrivalTime' type='text' value='<%=mArrTime%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,ArrivalTime)" STYLE="cursor:hand">
	&nbsp;&nbsp;<STRONG><FONT color=black face=Arial size=2> and Departure Before </FONT></STRONG>
	<input id='DepTime' name='DepTime' type='text' value='<%=mDepTime%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,DepTime)" STYLE="cursor:hand">
	<td></tr>
	<tr>
	<td ><font color=black face=arial size=2><STRONG>Attendance for Employee Code</STRONG></font>
	<INPUT type="text" id="EmpCode" name="EmpCode" style="FONT-SIZE: x-small; WIDTH: 100px; HEIGHT: 20px" size=11 value="<%=mECode%>">&nbsp; 
	<A TITLE="Click To View" HREF="EmployeeListLate.jsp"><STRONG><font  color=Blue  face=sans-serif size=3>....</font></STRONG></A> <font  color=green face='arial' size=1><b>Search Employee</b></font>  &nbsp; &nbsp;<font color=Teal><i>leave blank to list all employee</i></font></td>
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
	if(request.getParameter("ArrivalTime")==null)
		mATime="";
	else
		mATime=request.getParameter("ArrivalTime").toString().trim();

	if(request.getParameter("DepTime")==null)
		mDTime="";
	else
		mDTime=request.getParameter("DepTime").toString().trim();

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
			qry = "select a.MemberCode, a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi:ss PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),' ')OUTTIME from ATT_ATTENDLOG  b, v#allmembers a  where b.InstiTuteCode=a.InstituteCode and a.InstituteCode='"+mInst+"' and a.MEMBERID=b.USERID  and a.MemberType= b.USERTYPE and a.MemberType='"+mChkMType+"' And trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy')))";
		}
	else if (QryDept.equals("") && !mEmpCode.equals(""))
		{			
			qry = "select a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi:ss PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),' ')OUTTIME  from ATT_ATTENDLOG  b, v#allmembers a  where b.InstiTuteCode = a.InstituteCode and a.InstituteCode='"+mInst+"' and a.MEMBERID=b.USERID  and b.UserID='"+mEmpID+"' and a.MemberType= b.USERTYPE and a.MemberType='E' And trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy')))	 ";
		}
	else if(!QryDept.equals("") && mEmpCode.equals("")) 
		{
			qry="select a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi:ss PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),' ')OUTTIME  from ATT_ATTENDLOG  b, v#allmembers a  where b.InstiTuteCode  = a.InstituteCode and a.InstituteCode='"+mInst+"' and a.MEMBERID=b.USERID  and  a.DEPARTMENTCODE ='"+QryDept+"' and a.MemberType= b.USERTYPE and a.MemberType='E' And trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) ";
		}
	else if (!QryDept.equals("") && !mEmpCode.equals(""))
		{
			qry="select a.MemberCode,a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi:ss PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),' ')OUTTIME  from ATT_ATTENDLOG  b, v#allmembers a  where b.InstiTuteCode= a.InstituteCode And a.InstituteCode='"+mInst+"' and a.MEMBERID=b.USERID  and  a.DEPARTMENTCODE ='"+QryDept+"' and b.UserID='"+mEmpID+"' and a.MemberType= b.USERTYPE and a.MemberType='E' And trunc(WORKINGDATE)	between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',b.WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy'))) ";
		}
if(!mATime.equals(""))
		{
qry=qry+" and To_Char(INTIME,'HH24MISS')>=To_Char(To_Date('"+mATime+"','HH:MI PM'),'HH24MI') "; 
		}
else
		{
qry=qry+" and  To_Char(OUTTIME,'HH24MI')<=To_Char(to_Date('"+mDTime+"','HH:MI PM'),'HH24MI') ";
		}

qry=qry+"  order by EmployeeName,to_date(workingdate,'dd-Mon-yyyy') desc";
//out.println(qry);

%>
<table width=80% align=center>
<tr>
<td nowrap align=center title="Click to Print" valign=top>
<table width=10% align=center border=2 bordercolor=magroon><tr><td align=center nowrap><font color=blue>
<b>Click  <a style="CURSOR:hand" onClick="window.print();"><img src="../../Images/printer.gif"></a> To Print</b></font></td></tr></table></td>
</tr>
</table>

	<table ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"><B><%=mDName%></B></TD>
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
//sassaa

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
