<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rsFrIndv=null,rsFrEmp=null,rsFrDept=null;
ResultSet rs=null, rs1=null, rs2=null;

GlobalFunctions gb =new GlobalFunctions();
int CTR=0, mMaxLevel=0, mReqApprLevel=0, mTotOnWFLevel=0, mWFSeq=0;
double QryTotReqVal=0;
String mApprBy="", mApprAuth="", mApprovalById="", mAprMemID="", mApprovalByName="";
String qry="", mDeptCode="", mFacType="I";
String mComp="", mInst="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String QryRID="", QryFaculty="", QryWFCode="", QryWFType="", QryDOA="", QryDOR="";
String mWFMaxLvlApr="";
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
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if(request.getParameter("EID")==null)
{
	QryFaculty="";
}
else
{
	QryFaculty=request.getParameter("EID").toString().trim();	
}

if(request.getParameter("RID")==null)
{
	QryRID="";
}
else
{
	QryRID=request.getParameter("RID").toString().trim();	
}
if(request.getParameter("WFCode")==null)
{
	QryWFCode="ADVANCE";
}
else
{
	QryWFCode=request.getParameter("WFCode").toString().trim();	
}

if(request.getParameter("WFType")==null)
{
	QryWFType="";
}
else
{
	QryWFType=request.getParameter("WFType").toString().trim();	
}

if(request.getParameter("DOA")==null)
{
	QryDOA="";
}
else
{
	QryDOA=request.getParameter("DOA").toString().trim();
}

if(request.getParameter("DOR")==null)
{
	QryDOR="";
}
else
{
	QryDOR=request.getParameter("DOR").toString().trim();
}

if(request.getParameter("DeptCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=request.getParameter("DeptCode").toString().trim();
}

if(request.getParameter("WFMaxLvlApr")==null)
{
	mWFMaxLvlApr="";
}
else
{
	mWFMaxLvlApr=request.getParameter("WFMaxLvlApr").toString().trim();
}

if(request.getParameter("REQVAL")==null)
{
	QryTotReqVal=0;
}
else
{
	QryTotReqVal=Double.parseDouble(request.getParameter("REQVAL").toString().trim());
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ <%=GlobalFunctions.toTtitleCase(QryWFCode)%> Request Approval ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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
    	document.frm.submit();
}
//-->
</script>
	
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('171','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
	  //----------------------
	%>
	<form name="frm"  method="post" Action="AdvanceRequestApprovalByChangedRoute.jsp">
	<input id="x" name="x" type=hidden>
	<table id=id1 width=100% ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Divert/Change Route For <%=QryWFCode%> [<%=QryWFType%>] Work Flow</B></TD>
	</font></td></tr>
	</TABLE>
	<table id="table-1" cellpadding=2 cellspacing=0 align=center rules=groups border=2>
	<!--Institute****-->
	<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInst%>'>
	<input type=hidden Name='WFCode' ID='WFCode' value='<%=QryWFCode%>'>
	<input type=hidden Name='WFType' ID='WFType' value='<%=QryWFType%>'>
	<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
	<input type=hidden Name='EID' ID='EID' value='<%=QryFaculty%>'>
	<input type=hidden Name='DOA' ID='DOA' value='<%=QryDOA%>'>
	<input type=hidden Name='DOR' ID='DOR' value='<%=QryDOR%>'>
	<input type=hidden Name='DeptCode' ID='DeptCode' value='<%=mDeptCode%>'>
	<input type=hidden Name='REQVAL' ID='REQVAL' value='<%=QryTotReqVal%>'>
	<%
	if(mWFMaxLvlApr.equals("Y"))
	{
		%>
		<tr><td nowrap><input type="radio" value="CurrCase" name="Divert" disabled><font color=black face=arial size=2><STRONG>Change/Divert route for this case only</STRONG></font></td></tr>
		<tr><td nowrap><input type="radio" value="CurrEmp" name="Divert" checked><font color=black face=arial size=2><STRONG>Change/Divert route always for this employee only</STRONG></font></td></tr>
		<tr><td nowrap><input type="radio" value="CurrDept" name="Divert"><font color=black face=arial size=2><STRONG>Change/Divert route always for all employees of this department only</STRONG></font><hr></td></tr>
		<%
	}
	else
	{
		%>
		<tr><td nowrap><input type="radio" value="CurrCase" name="Divert" checked><font color=black face=arial size=2><STRONG>Change/Divert route for this case only</STRONG></font></td></tr>
		<tr><td nowrap><input type="radio" value="CurrEmp" name="Divert"><font color=black face=arial size=2><STRONG>Change/Divert route always for this employee only</STRONG></font></td></tr>
		<tr><td nowrap><input type="radio" value="CurrDept" name="Divert"><font color=black face=arial size=2><STRONG>Change/Divert route always for all employees of this department only</STRONG></font><hr></td></tr>
		<%
	}
	%>
	<tr><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp; Current Route (Complete) : <img src="../../../Images/arrow.gif"></STRONG></td></tr>
	<tr><td colspan=5 nowrap>
	<table><tr>
	<%
	qry="Select 'Y' from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"' and nvl(DEACTIVE,'N')='N'";
	rsFrIndv=db.getRowset(qry);
	//out.print(qry);

	qry="Select 'Y' from WF#EMPWISEWORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and nvl(DEACTIVE,'N')='N'";
	rsFrEmp=db.getRowset(qry);
	//out.print(qry);

	qry="Select 'Y' from WF#WORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' and nvl(DEACTIVE,'N')='N'";
	rsFrDept=db.getRowset(qry);
	//out.print(qry);

	if(rsFrIndv.next())
	{
//---------------Start Of if(rsFrIndv.next())----
		qry="select nvl(WFLEVEL,0)MaxLevel from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"'";
		qry=qry+" and InstituteCode='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"' GROUP BY WFLEVEL order by MaxLevel Asc";
	    	rs=db.getRowset(qry);
		//out.print(qry);
		try
		{
			while(rs.next())
			{
				qry="Select nvl(MIN(WFL),0) WFL FROM";
				qry=qry+" (Select nvl(WFLEVEL,0)WFL from WF#REQUESTWORKFLOWPATH Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"' GROUP BY WFLEVEL";
				qry=qry+" MINUS ";
				qry=qry+" Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWDETAIL Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' GROUP BY WFLEVEL)";
				rs1=db.getRowset(qry);
				//out.print(qry);
				if(rs1.next())
				{
					mReqApprLevel=rs1.getInt("WFL");
				}
				CTR=rs.getInt("MaxLevel");

				qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(WFSEQUENCE,0)WFSEQ FROM WF#REQUESTWORKFLOWPATH WHERE ";
				qry=qry+" REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
				qry=qry+" AND DEPARTMENTCODE='"+mDeptCode+"' AND WFLEVEL='"+CTR+"'";
				qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, DEPARTMENTCODE, WFSEQUENCE";
				rs1=db.getRowset(qry);
				//out.print(qry);
				if(rs1.next())
				{
					mApprBy=rs1.getString("APPRBY");
					mApprAuth=rs1.getString("APPRAUTH");
					mWFSeq=rs1.getInt("WFSEQ");
				}

				if(mApprBy.equals("E"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID='"+mApprAuth+"'";
				}
				else if(mApprBy.equals("H"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (SELECT EmployeeID from HODLIST where DepartmentCode='"+mApprAuth+"' AND nvl(DEACTIVE,'N')='N')";
				}
				else if(mApprBy.equals("O"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (SELECT EmployeeID from HODLIST where DepartmentCode='"+mApprAuth+"' AND nvl(DEACTIVE,'N')='N')";
				}
				else if(mApprBy.equals("D"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and DESIGNATIONCODE='"+mApprAuth+"' AND NVL(DEACTIVE,'N')='N'";
				}
				rs2=db.getRowset(qry);
				if(rs2.next())
				{
					mApprovalById=rs2.getString("EmpId");
					mApprovalByName=rs2.getString("EmpName");
				}
				//------------------------------
				if(CTR<mReqApprLevel)
				{
					%>
					<td nowrap><table cellspacing=0 cellpadding=0 border=0>
					<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Green><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
					<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
					</table></td>
					<%
				}
				else
				{
					//------------------------------
					if(CTR==mReqApprLevel)
					{
						if(mAprMemID.equals(""))
						mAprMemID=mApprovalById;
						%>
						<td nowrap><table cellspacing=0 cellpadding=0 border=0>
						<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Yellow><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
						<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
						</table></td>
						<input type=hidden Name='ApproveBy' ID='ApproveBy' value='<%=mApprovalById%>'>
						<input type=hidden Name='WFSeq' ID='WFSeq' value='<%=mWFSeq%>'>
						<input type=hidden Name='WFLevel' ID='WFLevel' value='<%=CTR%>'>
						<%
					}
					else
					{
						%>
						<td nowrap><table cellspacing=0 cellpadding=0 border=0>
						<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=LightYellow><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
						<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
						</table></td>
						<%
					}
					//------------------------------
				}
				//------------------------------
				mApprovalById="";
				mApprovalByName="";
			}
			mMaxLevel=CTR;
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}
//---------------End Of if(rsFrIndv.next())----
	}
	else if(rsFrEmp.next())
	{
//---------------Start Of if(rsFrEmp.next())----
		qry="select nvl(WFLEVEL,0)MaxLevel from WF#EMPWISEWORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
		qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' GROUP BY WFLEVEL order by MaxLevel Asc";
	    	rs=db.getRowset(qry);
		//out.print(qry);
		try
		{
			while(rs.next())
			{
				qry="Select nvl(MIN(WFL),0) WFL FROM";
				qry=qry+" (Select nvl(WFLEVEL,0)WFL from WF#EMPWISEWORKFLOWAUTHORITY Where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' GROUP BY WFLEVEL";
				qry=qry+" MINUS ";
				qry=qry+" Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWDETAIL Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' GROUP BY WFLEVEL)";
				rs1=db.getRowset(qry);
				//out.print(qry);
				if(rs1.next())
				{
					mReqApprLevel=rs1.getInt("WFL");
				}
				CTR=rs.getInt("MaxLevel");

				qry="select nvl(count(WFLEVEL),0) Total from WF#EMPWISEWORKFLOWAUTHORITY WHERE CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
				qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and WFLEVEL='"+CTR+"'";
				qry=qry+" group BY CompanyCode, InstituteCode, WORKFLOWCODE, WORKFLOWTYPE, EMPLOYEEID";
			    	rs1=db.getRowset(qry);
				//out.print(qry);
				if(rs1.next())
				{
					mTotOnWFLevel=rs1.getInt("Total");
				}
				if(mTotOnWFLevel>1)
				{
					qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(WFSEQUENCE,0)WFSEQ FROM WF#EMPWISEWORKFLOWAUTHORITY WHERE ";
					qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"'";
					qry=qry+" AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' AND WFLEVEL='"+CTR+"' AND "+QryTotReqVal+" between FROMVALUE and TOVALUE";
					qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, EMPLOYEEID, WFSEQUENCE";
					rs1=db.getRowset(qry);
					//out.print(qry);
					if(rs1.next())
					{
						mApprBy=rs1.getString("APPRBY");
						mApprAuth=rs1.getString("APPRAUTH");
						mWFSeq=rs1.getInt("WFSEQ");
					}
				}
				else
				{
					qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(WFSEQUENCE,0)WFSEQ FROM WF#EMPWISEWORKFLOWAUTHORITY WHERE ";
					qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"'";
					qry=qry+" AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' AND WFLEVEL='"+CTR+"'";
					qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, EMPLOYEEID, WFSEQUENCE";
					rs1=db.getRowset(qry);
					//out.print(qry);
					if(rs1.next())
					{
						mApprBy=rs1.getString("APPRBY");
						mApprAuth=rs1.getString("APPRAUTH");
						mWFSeq=rs1.getInt("WFSEQ");
					}
				}

				if(mApprBy.equals("E"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID='"+mApprAuth+"'";
				}
				else if(mApprBy.equals("H"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (SELECT EmployeeID from HODLIST where DepartmentCode='"+mApprAuth+"' AND nvl(DEACTIVE,'N')='N')";
				}
				else if(mApprBy.equals("O"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (SELECT EmployeeID from HODLIST where DepartmentCode='"+mApprAuth+"' AND nvl(DEACTIVE,'N')='N')";
				}
				else if(mApprBy.equals("D"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and DESIGNATIONCODE='"+mApprAuth+"' AND NVL(DEACTIVE,'N')='N'";
				}
				rs2=db.getRowset(qry);
				if(rs2.next())
				{
					mApprovalById=rs2.getString("EmpId");
					mApprovalByName=rs2.getString("EmpName");
				}
				//------------------------------
				if(CTR<mReqApprLevel)
				{
					%>
					<td nowrap><table cellspacing=0 cellpadding=0 border=0>
					<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Green><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
					<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
					</table></td>
					<%
				}
				else
				{
					//------------------------------
					if(CTR==mReqApprLevel)
					{
						if(mAprMemID.equals(""))
						mAprMemID=mApprovalById;
						%>
						<td nowrap><table cellspacing=0 cellpadding=0 border=0>
						<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Yellow><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
						<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
						</table></td>
						<input type=hidden Name='ApproveBy' ID='ApproveBy' value='<%=mApprovalById%>'>
						<input type=hidden Name='WFSeq' ID='WFSeq' value='<%=mWFSeq%>'>
						<input type=hidden Name='WFLevel' ID='WFLevel' value='<%=CTR%>'>
						<%
					}
					else
					{
						%>
						<td nowrap><table cellspacing=0 cellpadding=0 border=0>
						<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=LightYellow><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
						<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
						</table></td>
						<%
					}
					//------------------------------
				}
				//------------------------------
				mApprovalById="";
				mApprovalByName="";
			}
			mMaxLevel=CTR;
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}
//---------------End Of if(rsFrEmp.next())----
	}
	else if(rsFrDept.next())
	{
//---------------Start Of if(rsFrDept.next())----
		qry="select nvl(WFLEVEL,0)MaxLevel from WF#WORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
		qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' GROUP BY WFLEVEL order by MaxLevel Asc";
	    	rs=db.getRowset(qry);
		//out.print(qry);
		try
		{
			while(rs.next())
			{
				qry="Select MIN(WFL) WFL FROM";
				qry=qry+" (Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWAUTHORITY Where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' GROUP BY WFLEVEL";
				qry=qry+" MINUS ";
				qry=qry+" Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWDETAIL Where REQUESTID='"+QryRID+"' AND REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' GROUP BY WFLEVEL)";
				rs1=db.getRowset(qry);
				//out.print(qry);
				if(rs1.next())
				{
					mReqApprLevel=rs1.getInt("WFL");
				}
				CTR=rs.getInt("MaxLevel");

				qry="select nvl(count(WFLEVEL),0) Total from WF#WORKFLOWAUTHORITY WHERE CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
				qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' and WFLEVEL='"+CTR+"'";
				qry=qry+" group BY CompanyCode, InstituteCode, WORKFLOWCODE, WORKFLOWTYPE, DEPARTMENTCODE";
			    	rs1=db.getRowset(qry);
				//out.print(qry);
				if(rs1.next())
				{
					mTotOnWFLevel=rs1.getInt("Total");
				}
				if(mTotOnWFLevel>1)
				{
					qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(WFSEQUENCE,0)WFSEQ FROM WF#WORKFLOWAUTHORITY WHERE ";
					qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND WFLEVEL='"+CTR+"' AND "+QryTotReqVal+" between FROMVALUE and TOVALUE";
					qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, DEPARTMENTCODE, WFSEQUENCE";
					rs1=db.getRowset(qry);
					//out.print(qry);
					if(rs1.next())
					{
						mApprBy=rs1.getString("APPRBY");
						mApprAuth=rs1.getString("APPRAUTH");
						mWFSeq=rs1.getInt("WFSEQ");
					}
				}
				else
				{
					qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(WFSEQUENCE,0)WFSEQ FROM WF#WORKFLOWAUTHORITY WHERE ";
					qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND WFLEVEL='"+CTR+"'";
					qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, DEPARTMENTCODE, WFSEQUENCE";
					rs1=db.getRowset(qry);
					//out.print(qry);
					if(rs1.next())
					{
						mApprBy=rs1.getString("APPRBY");
						mApprAuth=rs1.getString("APPRAUTH");
						mWFSeq=rs1.getInt("WFSEQ");
					}
				}

				if(mApprBy.equals("E"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID='"+mApprAuth+"'";
				}
				else if(mApprBy.equals("H"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (SELECT EmployeeID from HODLIST where DepartmentCode='"+mApprAuth+"' AND nvl(DEACTIVE,'N')='N')";
				}
				else if(mApprBy.equals("O"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (SELECT EmployeeID from HODLIST where DepartmentCode='"+mApprAuth+"' AND nvl(DEACTIVE,'N')='N')";
				}
				else if(mApprBy.equals("D"))
				{
					qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and DESIGNATIONCODE='"+mApprAuth+"' AND NVL(DEACTIVE,'N')='N'";
				}
				rs2=db.getRowset(qry);
				if(rs2.next())
				{
					mApprovalById=rs2.getString("EmpId");
					mApprovalByName=rs2.getString("EmpName");
				}
				//------------------------------
				if(CTR<mReqApprLevel)
				{
					%>
					<td nowrap><table cellspacing=0 cellpadding=0 border=0>
					<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Green><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
					<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
					</table></td>
					<%
				}
				else
				{
					//------------------------------
					if(CTR==mReqApprLevel)
					{
						if(mAprMemID.equals(""))
						mAprMemID=mApprovalById;
						%>
						<td nowrap><table cellspacing=0 cellpadding=0 border=0>
						<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Yellow><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
						<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
						</table></td>
						<input type=hidden Name='ApproveBy' ID='ApproveBy' value='<%=mApprovalById%>'>
						<input type=hidden Name='DeptCode' ID='DeptCode' value='<%=mDeptCode%>'>
						<input type=hidden Name='WFSeq' ID='WFSeq' value='<%=mWFSeq%>'>
						<input type=hidden Name='WFLevel' ID='WFLevel' value='<%=CTR%>'>
						<%
					}
					else
					{
						%>
						<td nowrap><table cellspacing=0 cellpadding=0 border=0>
						<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=LightYellow><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
						<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
						</table></td>
						<%
					}
					//------------------------------
				}
				//------------------------------
				mApprovalById="";
				mApprovalByName="";
			}
			mMaxLevel=CTR;
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}
//---------------End Of if(rsFrDept.next())----
	}
	%>
	</tr></table>
	</td></tr>
	<tr><td colspan="5">
	<table align=left><tr>
	<td bgcolor=Green align=left>&nbsp; &nbsp; &nbsp;</td>
	<td align=center><Font color=black face="arial" size=2><B>Level Approved &nbsp; &nbsp; </B></font></td>
	<td bgcolor=yellow align=center>&nbsp; &nbsp; &nbsp;</td>
	<td align=right><Font color=black face="arial" size=2><B>Level To Be Approved Currently &nbsp; &nbsp; </B></font></td>
	<td bgcolor=lightyellow align=left>&nbsp; &nbsp; &nbsp;</td>
	<td align=right><Font color=black face="arial" size=2><B>Level To Be Approved Sequently</B></font></td>
	</tr></table>

	<tr><td align=left><HR><INPUT id=submit style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 140px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Continue..." name=submit1 value="Continue..."></td></tr>
	</table>
	</form>
	<%
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
}
else
{
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../../Images/Error1.gif'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>  
   <%
}
//-----------------------------
}
else
{
	out.print("<br><img src='../../../Images/Error1.gif'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
}
%>
</body>
</html>