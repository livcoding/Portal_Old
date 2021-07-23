<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="",mCompCode="";
String mCandCode="", MName="";
String mCandName="",mEmpID="";
String mDeptNM="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<TITLE>#### <%=mHead%> [ Change Web Kiosk Role/Web Page Title] </TITLE>


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>

	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
//GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mDNO="";
String qry="",mInst="",x="";
int msno=0;
ResultSet rs=null;
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

if (session.getAttribute("BASEINSTITUTECODE")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
}

if (request.getParameter("DNO")==null)
{
	mDNO="";
}
else
{
	mDNO=request.getParameter("DNO").toString().trim();
}
OLTEncryption enc=new OLTEncryption();

qry="Select nvl(COMPANYTAGGING,'UNIV')COMP from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'";
rs=db.getRowset(qry);
if(rs.next())
{
	mCompCode=rs.getString("COMP");
}

if(!mDNO.equals("")) 
{
	qry="Select nvl(DEPARTMENT,' ') DEPARTMENT from DepartmentMaster where dEPARTMENTcODE='"+mDNO+"'";
	rs=db.getRowset(qry);
	if(rs.next())
	 mDeptNM=rs.getString(1);
	else
	 mDeptNM="";
	%>
	<Table align=center width=90%>
	<tr bgcolor="orange"><td align=right><font color=RED><b><marquee scrolldelay=100 behavior=alternate><b>A D M I N</b></marquee></b></font></td></tr>
	</table>
	<Table align=center width=100%>
	<tr><td align=center><font color='#c00000'><b>List of Employee of <u><%=GlobalFunctions.toTtitleCase(mDeptNM)%></u> Department</b></Font></td></tr>
	</table>
	<table class="sort-table" id="TblEmpView" rules=rows cellSpacing=1 cellPadding=0  align=center border=1>
	<thead>
	<tr bgcolor="#c00000">
	<td nowrap title="Click here to sort list on Serial No."><font color="white"><b>SNo</b></font></td>
	<td nowrap title="Click here to sort list on Employee Name"><font color="white"><b>Employee Name (Code)</b></font></td>
	<td nowrap title="Click here to sort list on Designation"><font color="white"><b>Designation</b></font></td>
	<td nowrap title="Change/Update Web Kiosk Member Role"><font color="white"><b>Web Kiosk Role</b></font></td>
	<td nowrap title="Change/Update Web Page Title"><font color="white"><b>Web Page Title</b></font></td>
	</tr>
	</thead>
	<%
	qry="Select Distinct EMPLOYEEID, nvl(EmployeeCode,' ') EmployeeCode,nvl( EMPLOYEENAME,' ')  EMPLOYEENAME, nvl(DESIGNATIONCODE,' ') DESIGNATIONCODE from V#Staff";
	qry=qry+" where CompanyCode='"+ mCompCode +"' and DepartmentCode='"+mDNO+"' and nvl(Deactive,'N')='N' order by EmployeeName,EmployeeCode";			
	//out.print(qry);
	rs=db.getRowset(qry);
	while(rs.next())
	{
		msno++;				
		mEmpID=rs.getString("EMPLOYEEID");	
		%>
		<tr>
		<td Align=center><%=msno%>.</td>
		<td nowrap>&nbsp;<font size=1><%=rs.getString("EmployeeName")%>&nbsp;&nbsp;(<b><%=rs.getString("EmployeeCode")%></b>)</font></td>
		<td><font size=2x>&nbsp;&nbsp;<%=rs.getString("DESIGNATIONCODE")%></font></td>
		<td nowrap align=center><a href='ChangeWebkioskRole.jsp?DNO=<%=mDNO%>&amp;EID=<%=mEmpID%>' Title='Change/Update Web Kiosk Role of <%=rs.getString("EmployeeName")%>' ><font size=1x><b>CHANGE ROLE</b></font></a></td>
		<td nowrap align=center><a href='ChangeWebPageTitle.jsp?DNO=<%=mDNO%>&amp;EID=<%=mEmpID%>' Title='Change/Update Web Page Title of <%=rs.getString("EmployeeName")%>' ><font size=1x><b>CHANGE TITLE</b></font></a></td>
		</tr>
		<%
	}
	%>
	</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("TblEmpView"),["Number","CaseInsensitiveString","CaseInsensitiveString"]);
	</script>
	<%
}
else
{
//	out.print("<br><img src='../../Images/Error1.jpg'>");
//	out.print(" &nbsp; &nbsp; &nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
	int kk=0;
	for(kk=0;kk<7;kk++)
	{
	%>
	<table width=100%><tr><td align=center nowrap><b><font size=10 face='Arial' color='lightyellow'> ADMIN Page</font></b></td></tr><br></table>
	<%
	}
}
}
catch(Exception e)
{
}
%>
</body>
</html>