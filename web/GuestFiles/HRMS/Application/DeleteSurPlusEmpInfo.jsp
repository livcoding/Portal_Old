<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Delete Surplus Staff Info ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<script language=javascript>
	<!--
	function RefreshContents()
	{
    	document.frm.x.value='ddd';
	document.frm.x.value='ddd';
	}
	//-->
    </script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
	OLTEncryption enc=new OLTEncryption();
try
{
	DBHandler db=new DBHandler();
	ResultSet rs=null, rs1=null;
	String qry="";
	int SNo=0;
	String mMemberID="", mMemberType="";
	String mMemberCode="", mEMemberCode="";
	String mInst="", mComp="", mEmpID="", mEmpName="";
	String mDegs="", mDegsName="", mDept="", mDeptName="";

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

	if(!mMemberID.equals("") && !mMemberType.equals("")) 
	{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();

	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('144','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();


if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------

		//----------------------
		%>
		<form name="frm">
		<input id="x" name="x" type=hidden>
		<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
		 <tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Delete Surplus Staff [By HOD] </FONT></u></b></font></td></tr>
		</table>
		<Center>
		<%
		if (request.getParameter("Inst").trim()==null)
		{
			mInst="";
		}
		else
		{
			mInst=request.getParameter("Inst").toString().trim();
		}
		if (request.getParameter("Comp").trim()==null)
		{
			mComp="";
		}
		else
		{
			mComp=request.getParameter("Comp").toString().trim();
		}
		if (request.getParameter("Emp").trim()==null)
		{
			mEmpID="";
		}
		else
		{
			mEmpID=request.getParameter("Emp").toString().trim();
		}
		qry="Select nvl(EMPLOYEENAME,' ') EMPLOYEENAME, nvl(A.DEPARTMENTCODE,' ') DEPARTMENTCODE, nvl(B.DEPARTMENT,' ')DEPARTMENTNAME, nvl(A.DESIGNATIONCODE,' ') DESIGNATIONCODE, nvl(C.DESIGNATION,' ')DESIGNATIONNAME ";
		qry=qry+" FROM EMPLOYEEMASTER A, DEPARTMENTMASTER B, DESIGNATIONMASTER C Where A.COMPANYCODE='"+mComp+"' ";
		qry=qry+" and A.EMPLOYEEID='"+mEmpID+"' AND A.DEPARTMENTCODE=B.DEPARTMENTCODE AND A.DESIGNATIONCODE=C.DESIGNATIONCODE";
		//out.print(qry);
		rs= db.getRowset(qry);
		if (rs.next())
		{
			mDeptName=rs.getString("DEPARTMENTNAME");
			mDept=rs.getString("DEPARTMENTCODE");
			mDegsName=rs.getString("DESIGNATIONNAME");
			mDegs=rs.getString("DESIGNATIONCODE");
			mEmpName=rs.getString("EMPLOYEENAME");
		}
		%>
		<br><br<br><br>
		<table cellpadding=2 cellspacing=0 align=center>
		<tr><td><STRONG><FONT color=black face=Arial size=2>&nbsp;SurPlus Staff:</FONT></STRONG></FONT>&nbsp;<%=mEmpName%></td></tr>
		<tr><td><STRONG><FONT color=black face=Arial size=2>&nbsp;Designation:</FONT></STRONG></FONT>&nbsp;<%=mDegsName%></td></tr>
		<tr><td><STRONG><FONT color=black face=Arial size=2>&nbsp;Department:</FONT></STRONG></FONT>&nbsp;<%=mDeptName%></td></tr>
		</table>
		<input type=hidden name='Inst' id='Inst' value="<%=mInst%>">
		<input type=hidden name='Comp' id='Comp' value="<%=mComp%>">
		<input type=hidden name='Emp' id='Emp' value="<%=mEmpID%>">
		<%
		qry="DELETE FROM HR#SURPLUSSTAFF WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mInst+"' ";
		qry=qry+" and EMPLOYEEID='"+mEmpID+"' and SURPLUSFROMDEPARTMENT='"+mDept+"' and SURPLUSFROMDESIGNATION='"+mDegs+"'";
		qry=qry+" and CONSUMEDDEPARTMENT is null and CONSUMEDDESIGNATION is null and CONSUMEDDATE is null";
		int n=db.update(qry);
		//out.print(qry);
		if (n>0)
		{	
			out.print(" &nbsp;&nbsp;&nbsp <br><br><b><font size=3 face='Arial' color='Green'>Surplus Staff detail deleted successfully...</font><br>");
			db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"DELETE SURPLUS STAFF BY HOD LOGIN", "EmpID: "+mEmpID, "No MAC Address" , mIPAddress);
			response.sendRedirect("SurPlusEmpInfo.jsp");
		}
		else
		{
			out.print("<br><br><img src='../../../Images/Error1.jpg'  >");
			out.print(" &nbsp;<b><font size=3 face='Arial' color='Red'>Error while deleting the Surplused Staff Info! &nbsp; Surplus Staff might be assigned to others!</font><br>");
		}
		%>
		<br><br><br><tr><td><a href="SurPlusEmpInfo.jsp"><b>BACK</b></a></td></tr>
		</Center>
		</form>
		<%
		//-----------------------------
	}
 	else
	{
		%>
		<font color=red>
		<h3><br><img src='../../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
		<P>This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font><br><br>
		<%
	}
	//-----------------------------
	//-- Enable Security Page Level  
	//-----------------------------
	}
	else
	{
	out.print("<center><img src='../../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font></b></center>");
	}
}
catch(Exception e)
{
//out.print("Hello Catch Error!");
}
%>
</table>
</body>
</html>