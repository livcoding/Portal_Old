<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		mHead=session.getAttribute("PageHeading").toString().trim();
	else
		mHead="JIIT ";
	%>
	<HTML>
	<head>
	<TITLE>#### <%=mHead%> [ WebKiosk Department's Role/Page Title Detail ] </TITLE>
	<script language="JavaScript" type ="text/javascript">
	<!-- 
	 if (top != self) top.document.title = document.title;
	-->
	</script>
	<script type="text/javascript" src="js/sortabletable.js"></script>
	<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
	<script language=javascript>
	<!--
	function RefreshContents()
	{
    	document.frm.x.value='ddd';
			document.frm.x.value='ddd';
	}
	//-->

	function MemberCode_onchange() 
	{
		var mUserCode;
		mUserCode=frm.MemberCode.value;	 
		frm.MemberCode.value = mUserCode.toUpperCase();
	}
  </script>
  <script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
  </script>
</head>
<BODY vLink=#00000b link=#00000b bgcolor="#fce9c5" leftMargin=1 topMargin=0 marginheight="0" marginwidth="0" >
<!--<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >-->
<%
	OLTEncryption enc=new OLTEncryption();
	DBHandler db=new DBHandler();
	ResultSet rs=null;
	ResultSet rs1=null,rsi=null,rs2=null;

	long mDt=0, msno=0;
	String qry="", mInst="";

// For Log Entry Purpose
//--------------------------------------
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
else	
	mLoginIDFrSes="asklADMINaskl";
//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes);
	if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A")) 
	{
		try
		{
			%>
			<table class="sort-table" id="TblEmpView" rules=rows cellSpacing=1 cellPadding=0 width="100%" align=center valign=center border=0>
			<thead>
			<tr bgcolor="#c00000">
			<td title="Click here to sort list on Department Name"><font color="white"><b>Department</b></font></td>
			</tr>
			</thead>
			<%
			qry="Select A.DEPARTMENTCODE, nvl(A.DEPARTMENT , ' ') DEPARTMENT, count(Distinct B.EmployeeID) DeptSize from DEPARTMENTMASTER A, V#Staff B ";
			qry=qry+" where A.DEPARTMENTCODE=B.DEPARTMENTCODE and nvl(A.Deactive,'N')='N' AND nvl(B.Deactive,'N')='N' AND A.DEPARTMENTCODE IN (SELECT DEPARTMENTCODE FROM V#Staff WHERE NVL(Deactive,'N')='N' AND ";
			qry=qry+" COMPANYCODE = (Select nvl(COMPANYTAGGING,'UNIV') from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'))";
			qry=qry+" AND B.COMPANYCODE = (Select nvl(COMPANYTAGGING,'UNIV') from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N')";
			qry=qry+" Group by A.DEPARTMENTCODE,A.DEPARTMENT order by A.DEPARTMENT";
			rs=db.getRowset(qry);
			//out.print(qry);
			while(rs.next())
			{	
				msno++;
				mDt=rs.getLong("DeptSize");
				%>
				<tr><td></td></tr>
				<tr><td></td></tr>
				<tr bgcolor="#fce9c5">
					<td nowrap>&nbsp;<font size=1 face="Arial"><b><A target="DetSection" title='Click here to List employee of <%=rs.getString("Department")%>(<%=mDt%>) department' href="IndvDeptEmpRoleTitleInfo.jsp?DNO=<%=rs.getString("DepartmentCode")%>"><%=GlobalFunctions.toTtitleCase(rs.getString("Department"))%>&nbsp;&nbsp;(<%=rs.getString("DepartmentCode")%>)</a></b></font></td>
				</tr>
				<tr><td></td></tr>
				<%
			}
			%>
			</table>
			<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("TblEmpView"),["Number","CaseInsensitiveString","Number"]);
			</script>
			<%
		}
		catch(Exception e)
		{
		}
	}
}
catch(Exception e)
{
}		
%>         
</body>
</html>