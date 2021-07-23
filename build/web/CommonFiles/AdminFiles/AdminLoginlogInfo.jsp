<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%
String x="",y="",mLoginID1="";
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null,rso=null;
String qry="", qry1="";
String mComp="", mInst="",mAcad="",mFacultyID="",mFaculty="",mfaculty="",mSubhead="";
String mMemberID="";
String mMembertype="";
String mMemberCode="",LTP="";
String mDMemberCode="",mDMemberID="";
String mMemberName="",mDMemberType="";
String mWebEmail="",MType="";
int ctr=0;
String mDate1="",mDate2="";	
String mMemberType="",mLoginID="",mEmp="",mEcode="",mMember="",mDept="",logid="";

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1, to_Char((Sysdate-6),'dd-mm-yyyy') date2 from dual";
rs=db.getRowset(qry);
rs.next();
String mCurrDate=rs.getString("date1");
String mPrevDate=rs.getString("date2");

if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
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
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		   mHead=session.getAttribute("PageHeading").toString().trim();
	else
		   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [View Login Log Information] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%	
try{
OLTEncryption enc=new OLTEncryption();
	// mDMemberType=enc.decode(mMemberType);

String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("BASELOGINID")==null || session.getAttribute("BASELOGINID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("BASELOGINID").toString().trim();

if (session.getAttribute("BASELOGINTYPE")==null || session.getAttribute("BASELOGINTYPE").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();

if (session.getAttribute("BASEINSTITUTECODE")==null)
	mInst="JIIT";
else
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();

qry="Select nvl(COMPANYTAGGING,'UNIV')COMP from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'";
rs=db.getRowset(qry);
if(rs.next())
{
	mComp=rs.getString("COMP");
}

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);
 
//--------------------------------------
String mIPAddress=session.getAttribute("IPADD").toString().trim();
String mLoginIDFrSes="";
if(mInst.equals("JIIT"))
	mLoginIDFrSes="asklJIITADMINaskl";
else if(mInst.equals("JPBS"))
	mLoginIDFrSes="asklJPBSADMINaskl";
else if	(mInst.equals("J128"))
	mLoginIDFrSes="asklJ128ADMINaskl";
else
	mLoginIDFrSes="asklADMINaskl";
//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes);
	if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A")) 
{
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>View Login Log Information</B></font></td></tr>
</TABLE>
<table align=center bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0>
<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
if (request.getParameter("x")!=null)
{
	mDate1=request.getParameter("TXT1").toString().trim();
	mDate2=request.getParameter("TXT2").toString().trim();
}
else
{
	mDate1=mPrevDate;
	mDate2=mCurrDate;
}
%>
<tr><TD colspan=3 nowrap>
<b>&nbsp;View Signin Log information for the Period : <input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> to <input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10></b>
</td></tr>
<tr><td nowrap>
<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; Member Type</STRONG>&nbsp;&nbsp;</FONT></FONT>
<select ID=MType Name=MType style="WIDTH: 100px">
<%
	if(request.getParameter("MType")==null)
	{
		%>
		<option value="A" selected>Admin</option>
		<option value="S">Student</option>
	     	<option value="E">Employee</option>
		<%
	}
	else
	{
		if(request.getParameter("MType").toString().trim().equals("A"))
		{
			%>
			<option value="A" Selected>Admin</option>
			<%
		}
		else
		{
			%>
			<option value="A">Admin</option>
			<%
		}

		if(request.getParameter("MType").toString().trim().equals("S"))
		{
			%>
			<option value="S" Selected>Student</option>
			<%
		}
		else
		{
			%>
			<option value="S">Student</option>
			<%
		}	
			
		if(request.getParameter("MType").toString().trim().equals("E"))
		{
			%>
			<option value="E" Selected>Employee</option>
			<%
		}
		else
		{
			%>
			<option value="E">Employee</option>
			<%
		}
	}
	%>	
	</select>
	<%

if(request.getParameter("loginid")==null)
logid=" ";
else
logid=request.getParameter("loginid").toString().trim();
%>
&nbsp; <B>Login Id :</B>
<input type=text name=loginid id=loginid value='<%=logid%>' style="WIDTH: 80px; HEIGHT: 22px" size=45 ><font color=red>(if Individual)</font>
<INPUT Type="submit" Value="Show/Refresh"></td></tr></table></form>
<Center><font color=green  size=3># Login Id must be left blank for all members </font>
&nbsp; &nbsp;<font color=blue><a onClick="window.print();"><img src="../../Images/printer.gif" style="cursor:hand"><b>&nbsp; Click to Print</b></a></font></Center>

<table class="sort-table" id="table-1"  align=center bottommargin=0 rules=groups topmargin=0 cellspacing=1 cellpadding=0 border=1 >
<thead>
<tr bgcolor="#ff8c00" >
<td Title="Click here to sort Table Data on SNO"><b><font color=white>SNo.</font></b></td>
<td Title="Click here to sort Table Data on Member Name"><b><font color=white>Member Name<br>/Login ID</font></b></td>
<td Title="Click here to sort Table Data on Department"><b><font color=white>Department<br>/Program(Branch)</font></b></td>
<td ><b><font color="white">Date/Time</font></b></td>
<td ><b><font color=white>IP Address</font></b></td>
</tr>
</thead>
<tbody>
<%
if(request.getParameter("x")!=null)
{
	if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
		mDate1="**";
	else
		mDate1=request.getParameter("TXT1").toString().trim();

	if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals(""))
		mDate2="**";
	else
		mDate2=request.getParameter("TXT2").toString().trim();

	if ((mDate1.equals("**") || GlobalFunctions.iSValidDate(mDate1)==true )&& (mDate2.equals("**") || GlobalFunctions.iSValidDate(mDate2)))
	{
		mMembertype=request.getParameter("MType").toString().trim();

		if (request.getParameter("loginid")==null || request.getParameter("loginid").equals(""))
			mLoginID="***";
		else
			mLoginID=request.getParameter("loginid").toString().trim();

		if(mMembertype.equals("E"))
		{
			qry="select employeeid from employeemaster where COMPANYCODE='"+mComp+"' AND employeecode=decode('"+mLoginID+"','***',employeecode,'"+mLoginID+"') ";
		}
		else if(mMembertype.equals("S"))
		{
			qry="select studentid employeeid from studentmaster where InstituteCode='"+mInst+"' and enrollmentno=decode('"+mLoginID+"','***',enrollmentno,'"+mLoginID+"') ";
		}
		else
		{
			qry="select 'ADMIN' employeeid from dual ";
		}
		rso=db.getRowset(qry);		  
		while(rso.next())
		{
			mLoginID1=rso.getString("employeeid");

			qry="select memberid ,IPaddress,to_char(logindatetime,'dd-mm-yyyy hh:mi PM')datetime from  memberloginfo ";
			qry=qry+" where memberType='"+mMembertype+"' and memberid=decode('"+mLoginID1+"','***',memberid,'"+mLoginID1+"') ";		
			qry=qry+" and trunc(LOGINDATETIME) between decode('"+mDate1+"','**',trunc(LOGINDATETIME),to_Date('"+mDate1+"','dd-mm-yyyy')) and decode('"+mDate2+"','**',trunc(LOGINDATETIME),to_Date('"+mDate2+"','dd-mm-yyyy')) ";
			rs=db.getRowset(qry);
			//out.print(qry);
			while (rs.next())
			{
				ctr++;
				mMember=rs.getString("memberid");
				if(mMembertype.equals("E"))
				{
					qry1="select A.employeename,A.employeecode,A.departmentcode,B.department ";
					qry1=qry1+" from employeemaster A,departmentmaster B where A.COMPANYCODE='"+mComp+"' and A.employeeid='"+mMember+"' and A.departmentcode=B.departmentcode ";
					rs1=db.getRowset(qry1);		  
					if(rs1.next())
					{
						mEmp=rs1.getString("employeename");
						mEcode=rs1.getString("employeecode");
						mDept=rs1.getString("department");
					}
					%>
					<tr>
					<td><%=ctr%>.</td>
					<td nowrap><%=mEmp%>&nbsp;(<%=mEcode%>)</td>
					<td><%=mDept%></td>
					<%
				}
				else if(mMembertype.equals("S")) 
				{   
					qry1="select studentname,enrollmentno,programcode||' ( ' || Branchcode || ' ) ' Programbranch from studentmaster where InstituteCode='"+mInst+"' and studentid='"+mMember+"' ";
					rs1=db.getRowset(qry1);	
	  				if(rs1.next())
					{
						mEmp=rs1.getString("studentname");
						mEcode=rs1.getString("enrollmentno");
						mDept=rs1.getString("Programbranch");
					}
					%>
					<tr>
					<td><%=ctr%>.</td>
					<td nowrap><%=mEmp%>&nbsp;(<%=mEcode%>)</td>
					<td><%=mDept%></td>
					<%
				}
				else if(mMembertype.equals("A"))
				{
					%>
					<tr>
					<td><%=ctr%>.</td>
					<td nowrap align=center>ADMIN</td>
					<td nowrap align=center>ADMIN</td>
					<%
				}
			  	%>
				<td><%=rs.getString("datetime")%></td>
				<td><%=rs.getString("IPaddress")%></td>
				</tr>
				<%
			} // closing of while
		} // closing of outer while
		%>
		</tbody>
		</table>
		<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Date"]);
		</script>
		<%	
	}	// Validate Date
	else
	{
		out.print("<br><img src='../Images/Error1.jpg'>");
		out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Valid Date Format is DD-MM-YYYY only</font> <br>");
	}
}  //*************** closing of (request.getParameter("x")!=null)
}
else
{
	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
 //out.print("error"+qry);
}      
%>
</body>
</html>







