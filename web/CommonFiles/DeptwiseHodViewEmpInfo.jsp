<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
String mHead="",mCompCode ="";
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

<TITLE>#### <%=mHead%> [ View Employee Profile/information ] </TITLE>
 

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>
<!--
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
String qry="",x="",mDeptCode="";
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

	if (session.getAttribute("CompanyCode")==null)
	{
		mCompCode="JIIT";
	}
	else
	{
		mCompCode=session.getAttribute("CompanyCode").toString().trim();
	}

	

	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("") ) 
	{
		mMemberCode=enc.decode(mMemberCode);
		mMemberType=enc.decode(mMemberType);
		mMemberID=enc.decode(mMemberID);
		
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;
		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		qry="Select WEBKIOSK.ShowLink('229','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		{
			qry="Select nvl(a.DEPARTMENT,' ') DEPARTMENT,b.DepartmentCode DepartmentCode from DepartmentMaster a,hodlist b where a.dEPARTMENTcODE=b.departmentcode and b.employeeid='"+mChkMemID+"'   ";
			rs=db.getRowset(qry);
			if(rs.next())
			{
				mDeptNM=rs.getString(1);
				mDeptCode=rs.getString("DepartmentCode");
			}
			else
			{
				mDeptNM="";
				mDeptCode="";
			}
			%>
			<Table align=center width=100%>
			<tr><td align=right><a href='DeptwiseEmpViewEmpInfo.jsp'><font color=GREEN><b>Back...</b></font></a> &nbsp; &nbsp; &nbsp;</td>
			</tr>
			<tr><td align=center><font color='#c00000'><b>List of Employee of <u><%=mDeptNM%></u> Department</b></Font></td></tr>
			</table>
			<table class="sort-table" id="TblEmpView" rules=rows cellSpacing=1 cellPadding=0  align=center border=1>
			<thead>
			<tr bgcolor="#c00000">
			<td title="Click here to sort list on Serial No."><font color="white"><b>Sno</b></font></td>
			<td title="Click here to sort list on Employee Name"><font color="white"><b>Employee Name (Code)</b></font></td>
			<td title="Click here to sort list on Designation"><font color="white"><b>Designation</b></font></td>
		<!-- 	<td><font color="white"><b>View SRS</b></font></td> -->
			</tr>
			</thead>
			<%
			qry="Select Distinct EMPLOYEEID, nvl(EmployeeCode,' ') EmployeeCode,nvl( EMPLOYEENAME,' ')  EMPLOYEENAME, nvl(DESIGNATIONCODE,' ') DESIGNATIONCODE from EmployeeMaster  where CompanyCode='"+ mCompCode +"' and DepartmentCode='"+mDeptCode+"' and nvl(Deactive,'N')='N' order by EmployeeName,EmployeeCode";			
			rs=db.getRowset(qry);
//out.print(qry);
			while(rs.next())
			{
				msno++;				
				mEmpID=rs.getString("EMPLOYEEID");	
				%>
				<tr>
				<td Align=right><%=msno%></td>
				<td nowrap>&nbsp;<font size=2><A title='Click here to explore detailed of <%=rs.getString("EmployeeName")%>' href="EmpAdminOption.jsp?SID=<%=mEmpID%>"><%=rs.getString("EmployeeName")%>&nbsp;&nbsp;(<%=rs.getString("EmployeeCode")%>)</a></font></td>
				<td><font size=2x><%=rs.getString("DESIGNATIONCODE")%></font></td>
				<!-- <td><a href='ADMNEmpSRSTeachRatingDetailInd.jsp?EID=<%=mEmpID%>' Title='View SRS Report of <%=rs.getString("EmployeeName")%>' Target=_NEW><font size=2x><b>View SRS</b></font></a></td> -->
					</tr>
					<%
			}
			%>
			</table>
			<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("TblEmpView"),["Number","CaseInsensitiveString","CaseInsensitiveString"]);
			</script>
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
			<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br>
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
}
%>
</body>
</html>