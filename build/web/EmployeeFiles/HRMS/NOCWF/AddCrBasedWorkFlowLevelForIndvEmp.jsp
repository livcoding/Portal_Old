<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rsFrIndv=null,rsFrEmp=null,rsFrDept=null;
ResultSet rs=null, rs1=null, rs2=null;

GlobalFunctions gb =new GlobalFunctions();
int n=0, ctr=0, CTR=0, TotalInRequestWiseTbl=0;
int mCBOnLevel=0, mCBFR=0, mCBTO=0;
int mPAID=0, mLWP=0, mWFSeq=0, mWFSeqc=0, QryWFLevel=0;
double mTotalLvDays=0;
int mSetCBFrom=0,mSetCBTo=0;
String mApprBy="", mApprAuth="", mApprovalById="", mAprMemID="", mApprovalByName="";
String mDepartmentCode="", mDeptCode="", QryDept="", mChangeCase="";
String mEmpName="", mEmpCode="", QryEmp="", mEmpID="", mChkLevel="";
String mDegsName="", mDegsCode="", QryDegs="", QryFaculty="", mFacType="I";
String qry="",qry1="", mTextToDisp="", mTextToFwd="";
String mColor="",mComp="",TRCOLOR="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mFacultyName="",mFaculty="", mMsg="";
String QryReqDate="", QryRID="", QryWFCode="", QryWFType="", QryLvDateFr="", QryLvDateTo="", QryLvPurp="";
String mChDvFor="";
String mENM="",mcolor="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="";
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
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if(request.getParameter("DeptCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=request.getParameter("DeptCode").toString().trim();	
}

if(request.getParameter("WFC")==null)
{
	QryWFCode="";
}
else
{
	QryWFCode=request.getParameter("WFC").toString().trim();	
}

if(request.getParameter("EID")==null)
{
	QryFaculty="";
}
else
{
	QryFaculty=request.getParameter("EID").toString().trim();	
}

if(request.getParameter("WFT")==null)
{
	QryWFType="";
}
else
{
	QryWFType=request.getParameter("WFT").toString().trim();	
}

if(request.getParameter("WFL")==null)
{
	QryWFLevel=0;
}
else
{
	QryWFLevel=Integer.parseInt(request.getParameter("WFL").toString().trim());
}
//out.print("WFC-"+QryWFCode+" WFT-"+QryWFType+" WFL-"+QryWFLevel+" EID-"+QryFaculty);
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ NOC Work Flow ] </TITLE>

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
<SCRIPT>
function FunSubmit1()
{
	//document.frm.action="LeaveRequestInbox.jsp" ;
	window.close();
}
function FunLReqBy()
{
	if(document.frm.ApprBy[0].checked==true)
	{
		document.frm.HODSelf.disabled=false;
		document.frm.HODOther.disabled=true;
		document.frm.EmpWise.disabled=true;
		document.frm.DegsBased.disabled=true;
	}
	else if(document.frm.ApprBy[1].checked==true)
	{
		document.frm.HODSelf.disabled=true;
		document.frm.HODOther.disabled=false;
		document.frm.EmpWise.disabled=true;
		document.frm.DegsBased.disabled=true;
	}
	else if(document.frm.ApprBy[2].checked==true)
	{
		document.frm.HODSelf.disabled=true;
		document.frm.HODOther.disabled=true;
		document.frm.EmpWise.disabled=false;
		document.frm.DegsBased.disabled=true;
	}
	else if(document.frm.ApprBy[3].checked==true)
	{
		document.frm.HODSelf.disabled=true;
		document.frm.HODOther.disabled=true;
		document.frm.EmpWise.disabled=true;
		document.frm.DegsBased.disabled=false;
	}
}
function FunLReq()
{
	//alert(document.frm.ChkLevel.checked);
	if(document.frm.ChkLevel.checked==false)
	{
		document.frm.CBFR.disabled=true;
		document.frm.CBTO.disabled=true;
		document.frm.HODSelf.disabled=true;
		document.frm.HODOther.disabled=true;
		document.frm.EmpWise.disabled=true;
		document.frm.DegsBased.disabled=true;
		document.frm.submit2.disabled=true;
		document.frm.ApprBy[0].disabled=true
		document.frm.ApprBy[1].disabled=true
		document.frm.ApprBy[2].disabled=true
		document.frm.ApprBy[3].disabled=true
		document.frm.TextToBeDisp.disabled=true;
	}
	else
	{
		document.frm.CBFR.disabled=false;
		document.frm.CBTO.disabled=false;
		document.frm.ApprBy[0].disabled=false;
		document.frm.ApprBy[1].disabled=false;
		document.frm.ApprBy[2].disabled=false;
		document.frm.ApprBy[3].disabled=false;
		if(document.frm.ApprBy[0].checked==true)
		{
			document.frm.HODSelf.disabled=false;
		}
		else if(document.frm.ApprBy[1].checked==true)
		{
			document.frm.HODOther.disabled=false;
		}
		else if(document.frm.ApprBy[2].checked==true)
		{
			document.frm.EmpWise.disabled=false;
		}
		else if(document.frm.ApprBy[3].checked==true)
		{
			document.frm.DegsBased.disabled=false;
		}
		document.frm.submit2.disabled=false;
		document.frm.TextToBeDisp.disabled=false;
	}
}
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onload="FunLReq()">
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
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
		qry="Select WEBKIOSK.ShowLink('148','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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

			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if(rs.next())
				mInstitute=rs.getString(1);
			else
				mInstitute="JIIT";
	  //----------------------
	%>
	<form name="frm"  method="post">
	<input id="x" name="x" type=hidden>
	<table id=id1 width=100% ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Add New Criteria On This Level For <%=QryWFCode%> [<%=QryWFType%>] Work Flow</B></font></td></tr>
	</TABLE>
	<table id="table-1" cellpadding=2 cellspacing=0 align=center rules=groups border=2>
	<!--Institute****-->
	<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
	<input type=hidden Name='DeptCode' ID='DeptCode' value='<%=mDeptCode%>'>
	<input type=hidden Name='WFC' ID='WFC' value='<%=QryWFCode%>'>
	<input type=hidden Name='WFL' ID='WFL' value='<%=QryWFLevel%>'>
	<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
	<input type=hidden Name='WFT' ID='WFT' value='<%=QryWFType%>'>
	<input type=hidden Name='DATEFROM' ID='DATEFROM' value='<%=QryLvDateFr%>'>
	<input type=hidden Name='DATETO' ID='DATETO' value='<%=QryLvDateTo%>'>
	<input type=hidden Name='TLD' ID='TLD' value='<%=mTotalLvDays%>'>
	<%

	qry="Select 'Y' from WF#EMPWISEWORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInstitute+"' AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' and FACULTYTYPE='"+mFacType+"' and nvl(DEACTIVE,'N')='N'";
	rsFrDept=db.getRowset(qry);
	//out.print(qry);

	if(rsFrDept.next())
	{
		qry="select nvl(Max(WFSEQUENCE),0)WFSEQC from WF#EMPWISEWORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInstitute+"' AND";
		qry=qry+" WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' and FACULTYTYPE='"+mFacType+"'";
		qry=qry+" GROUP BY COMPANYCODE, INSTITUTECODE, WORKFLOWCODE, WORKFLOWTYPE, EMPLOYEEID,FACULTYTYPE";
		rs2=db.getRowset(qry);
		//out.print(qry);
		if(rs2.next())
		{
			mWFSeqc=rs2.getInt("WFSEQC");
		}
	}
	mWFSeqc++;
	qry="Select Max(TOVALUE) MaxToVal from WF#EMPWISEWORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInstitute+"' AND ";
	qry=qry+" WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' and FACULTYTYPE='"+mFacType+"' AND WFLEVEL='"+QryWFLevel+"'";
	qry=qry+" GROUP BY COMPANYCODE, INSTITUTECODE, WORKFLOWCODE, WORKFLOWTYPE, EMPLOYEEID, FACULTYTYPE, WFLEVEL";
	rs2=db.getRowset(qry);
	//out.print(qry);
	if(rs2.next())
	{
		mSetCBFrom=rs2.getInt("MaxToVal")+1;
		mSetCBTo=rs2.getInt("MaxToVal")+1;
	}
	%>
	<tr><td nowrap>
	<font color=darkpink face=arial size=2>
	<STRONG><input type='checkbox' name='ChkLevel' id='ChkLevel' value='Required' onclick="FunLReq()"> Level <%=QryWFLevel%> : <img src="../../../Images/arrow.gif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </STRONG>
	<STRONG> Set Criteria From <input type=text style="text-align:right" size=1 width=8px maxlength=5 name='CBFR' id='CBFR' value=<%=mSetCBFrom%>></STRONG>
	<STRONG> To <input type=text style="text-align:right" size=1 width=8px maxlength=5 name='CBTO' id='CBTO' value=<%=mSetCBTo%>></STRONG>
	</td>
	</tr>
	<tr><td><table border=2 bordercolor="#de6400" width=100% cellpadding=0 cellspacing=0 bgcolor="" rules="none">
	<tr><td align=center><font color=navy face=arial size=2><STRONG>&nbsp; Approval By <img src="../../../Images/arrow.gif"></STRONG></font></td>
	<td align=center><font color=navy face=arial size=2><STRONG>&nbsp; Approval Authority <img src="../../../Images/arrow.gif"></STRONG></font></td></tr>
	<tr>
	<td nowrap><input type="radio" onclick="FunLReqBy()" value="H" Name="ApprBy" ID="ApprBy" checked><font color=black face=arial size=2><STRONG>HOD [Self Department]</STRONG></font></td>
	<%
	qry="Select nvl(EmployeeName,' ')EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (Select EmployeeID From HODLIST WHERE DEPARTMENTCODE='"+mDeptCode+"') and nvl(DEACTIVE,'N')='N'";
	rs1=db.getRowset(qry);
	rs1.next();
	%>
	<td nowrap><input type="text" value="<%=rs1.getString("EmpName")%> [<%=mDeptCode%>]" Name="HODSelf" ID="HODSelf" size=38 READONLY></td>
	</tr>
	<tr>
	<td nowrap><input type="radio" onclick="FunLReqBy()" value="O" Name="ApprBy" ID="ApprBy"><font color=black face=arial size=2><STRONG>HOD [Other Department]</STRONG></font></td>
	<td nowrap>
	<%
	qry="Select nvl(E.EmployeeName,' ')EName, nvl(D.DepartmentCode,' ')Dept from EmployeeMaster E, HODList D where E.EmployeeID=D.EmployeeID and nvl(E.Deactive,'N')='N' and nvl(D.Deactive,'N')='N'";
	qry=qry+" MINUS ";
	qry=qry+" Select nvl(E.EmployeeName,' ')EName, nvl(D.DepartmentCode,' ')Dept from EmployeeMaster E, HODList D where E.EmployeeID=D.EmployeeID and nvl(E.Deactive,'N')='N' and nvl(D.Deactive,'N')='N' and D.Departmentcode='"+mDeptCode+"' ";
	rs1=db.getRowset(qry);
	//out.print(qry);
		%>
		<select name=HODOther tabindex="0" id=HODOther>
		<%
		if(request.getParameter("x")==null)
		{
			while(rs1.next())
			{
			 	mDepartmentCode=rs1.getString("Dept");
				if(QryDept.equals(""))
				{
					QryDept=mDepartmentCode;
				}
				%>
				<option value=<%=mDepartmentCode%>><%=rs1.getString("EName")%> [<%=mDepartmentCode%>]</option>
				<%
			}
		}
		else
		{
			while(rs1.next())
			{
		   		mDepartmentCode=rs1.getString("Dept");
				%>
				<option value=<%=mDepartmentCode%>><%=rs1.getString("EName")%> [<%=mDepartmentCode%>]</option>
				<%
			}
		}
		%>
		</select>
		</td>
		</tr>
		<tr>
		<td nowrap><input type="radio" onclick="FunLReqBy()" value="E" Name="ApprBy" ID="ApprBy"><font color=black face=arial size=2><STRONG>Employee</STRONG></font></td>
		<td nowrap>
		<%
		qry="Select nvl(EmployeeID,' ')EmpID, nvl(EmployeeCode,' ')EmpCode, nvl(EmployeeName,' ')EmpName from EmployeeMaster";
		qry=qry+" where COMPANYCODE='"+mComp+"' and nvl(Deactive,'N')='N' Order By EmpName";
		rs1=db.getRowset(qry);
		//out.print(qry);
		%>
		<select name=EmpWise tabindex="0" id=EmpWise>
		<%
		if(request.getParameter("x")==null)
		{
			while(rs1.next())
			{
			 	mEmpID=rs1.getString("EmpID");
			 	mEmpCode=rs1.getString("EmpCode");
			 	mEmpName=rs1.getString("EmpName");
				if(QryEmp.equals(""))
				{
					QryEmp=mEmpID;
				}
				%>
				<option value=<%=mEmpID%>><%=mEmpName%> (<%=mEmpCode%>)</option>
				<%
			}
		}
		else
		{
			while(rs1.next())
			{
			 	mEmpID=rs1.getString("EmpID");
			 	mEmpCode=rs1.getString("EmpCode");
			 	mEmpName=rs1.getString("EmpName");
				%>
				<option value=<%=mEmpID%>><%=mEmpName%> (<%=mEmpCode%>)</option>
				<%
			}
		}
		%>
		</select>
		</td>
		</tr>
		<tr>
		<td nowrap><input type="radio" onclick="FunLReqBy()" value="D" Name="ApprBy" ID="ApprBy"><font color=black face=arial size=2><STRONG>Designation Based</STRONG></font></td>
		<td nowrap>
		<%
		qry="SELECT D.DESIGNATIONCODE DEGSCD, D.DESIGNATION DEGSNM From Designationmaster D where nvl(DEACTIVE,'*')='N'";
		qry=qry+" and D.DESIGNATIONCODE IN(Select E.DESIGNATIONCODE from EMPLOYEEMASTER E where nvl(E.DEACTIVE,'N')='N'";
 		qry=qry+" and E.CompanyCode='"+mComp+"' GROUP By E.DESIGNATIONCODE HAVING Count(*)=1)";
		rs1=db.getRowset(qry);
		//out.print(qry);
		%>
		<select name=DegsBased tabindex="0" id=DegsBased>
		<%
		if(request.getParameter("x")==null)
		{
			while(rs1.next())
			{
			 	mDegsCode=rs1.getString("DEGSCD");
			 	mDegsName=rs1.getString("DEGSNM");
				if(QryDegs.equals(""))
				{
					QryDegs=mDegsCode;
				}
				%>
				<option value=<%=mDegsCode%>><%=mDegsName%></option>
				<%
			}
		}
		else
		{
			while(rs1.next())
			{
			 	mDegsCode=rs1.getString("DEGSCD");
			 	mDegsName=rs1.getString("DEGSNM");
				%>
				<option value=<%=mDegsCode%>><%=mDegsName%></option>
				<%
			}
		}
		%>
		</select>
		</td></tr>
		<tr>
		<td nowrap width=300px><font color=navy face=arial size=2><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Text of NOC Recommendation</STRONG></font></td>
		<td nowrap>
		<select name="TextToBeDisp" tabindex="0" id="TextToBeDisp" disabled>
		<%
		if(request.getParameter("TextToBeDisp")==null)
	   	{
			mTextToDisp="A";
			%>
			<OPTION Value=A selected>Approve</option>
			<OPTION Value=F>Forward</option>
			<OPTION Value=G>Grant</option>
			<OPTION Value=R>Recommend</option>
			<%
	  	}
		else
		{
			mTextToFwd=request.getParameter("TextToBeDisp");
			if(mTextToDisp.equals(""))
				mTextToDisp="A";
			if(mTextToFwd.equals("A"))
			{
				%>
				<OPTION Value=A selected>Approve</option>
				<OPTION Value=F>Forward</option>
				<OPTION Value=G>Grant</option>
				<OPTION Value=R>Recommend</option>
				<%
		      }
			else if(mTextToFwd.equals("F"))
			{
				%>
				<OPTION Value=A>Approve</option>
				<OPTION Value=F selected>Forward</option>
				<OPTION Value=G>Grant</option>
				<OPTION Value=R>Recommend</option>
				<%
			}
			else if(mTextToFwd.equals("G"))
			{
				%>
				<OPTION Value=A>Approve</option>
				<OPTION Value=F>Forward</option>
				<OPTION Value=G selected>Grant</option>
				<OPTION Value=R>Recommend</option>
				<%
			}
			else if(mTextToFwd.equals("R"))
			{
				%>
				<OPTION Value=A>Approve</option>
				<OPTION Value=F>Forward</option>
				<OPTION Value=G>Grant</option>
				<OPTION Value=R selected>Recommend</option>
				<%
			}
		}
		%>
		</select>
		</td>
		</tr>
		</table></td></tr>
		<%
	//}
	%>
	<tr><td align=center><HR><INPUT id=submit1 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Close without adding any Level" name=submit1 value="Close" onclick="FunSubmit1()" onsubmit="FunSubmit1()"> &nbsp; <INPUT id=submit2 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Save" name=submit2 value="Save"></td></tr>
	</table>
	<%
	if(request.getParameter("x")!=null)
	{
		if(request.getParameter("CBFR")==null)
			mCBFR=0;
		else
			mCBFR=Integer.parseInt(request.getParameter("CBFR").toString().trim());

		if(request.getParameter("CBTO")==null)
			mCBTO=0;
		else
			mCBTO=Integer.parseInt(request.getParameter("CBTO").toString().trim());

		if(request.getParameter("ChkLevel")==null)
			mChkLevel="";
		else
			mChkLevel=request.getParameter("ChkLevel").toString().trim();

		if(request.getParameter("ChkLevel")==null)
			mChkLevel="";
		else
			mChkLevel=request.getParameter("ChkLevel").toString().trim();

		if(request.getParameter("ApprBy")==null)
			mApprBy="";
		else
			mApprBy=request.getParameter("ApprBy").toString().trim();

		if(mApprBy.equals("H"))
		{
			if (request.getParameter("HODSelf")!=null)
				mApprAuth=mDeptCode;
			else
				mApprAuth="";
		}
		else if(mApprBy.equals("O"))
		{
			if (request.getParameter("HODOther")!=null)
				mApprAuth=request.getParameter("HODOther");
			else
				mApprAuth="";
		}
		else if(mApprBy.equals("E"))
		{
			if (request.getParameter("EmpWise")!=null)
				mApprAuth=request.getParameter("EmpWise");
			else
				mApprAuth="";
		}
		else if(mApprBy.equals("D"))
		{
			if (request.getParameter("DegsBased")!=null)
				mApprAuth=request.getParameter("DegsBased");
			else
				mApprAuth="";
		}
		if (request.getParameter("TextToBeDisp")!=null)
			mTextToDisp=request.getParameter("TextToBeDisp");
		else
			mTextToDisp="";
		//out.print("ApprBy "+mApprBy+" ApprAuth "+mApprAuth+" SetCriteriaFrom "+mCBFR+" SetCriteriaTo "+mCBTO);

		if(mChkLevel.equals("Required"))
		{
		   if(!mApprAuth.equals(""))
		   {
			qry="Select 'Y' from WF#EMPWISEWORKFLOWAUTHORITY WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInstitute+"' AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' and FACULTYTYPE='"+mFacType+"' AND WFLEVEL='"+QryWFLevel+"'";
			qry=qry+" and ((FROMVALUE between '"+mCBFR+"' AND '"+mCBFR+"') OR (TOVALUE between '"+mCBFR+"' AND '"+mCBFR+"'))";
			rs=db.getRowset(qry);
			//out.print(qry);
			if(!rs.next())
			{
				qry="INSERT INTO WF#EMPWISEWORKFLOWAUTHORITY (COMPANYCODE, INSTITUTECODE, WORKFLOWCODE, WORKFLOWTYPE, EMPLOYEEID, FACULTYTYPE, WFSEQUENCE, APPROVALBY, APPROVALAUTHORITY, WFLEVEL, CRITERIABASEDON, FROMVALUE, TOVALUE, ENTRYBY, ENTRYDATE, APPROVALTEXTTOBEDISPLAYED)";
				qry=qry+"VALUES('"+mComp+"','"+mInstitute+"','"+QryWFCode+"','"+QryWFType+"','"+QryFaculty+"','"+mFacType+"','"+mWFSeqc+"','"+mApprBy+"','"+mApprAuth+"','"+QryWFLevel+"','D','"+mCBFR+"','"+mCBTO+"','"+mChkMemID+"',sysdate, '"+mTextToDisp+"')";
				n=db.insertRow(qry);
				//out.print(qry);
				if(n>0)
				{
					%><CENTER><br><%
					out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>NOC WorkFlow Criteria Addition Successful...</font> <br>");
					%></CENTER><%
					qry="Select Employeecode from Employeemaster where employeeid='"+mChkMemID+"'";
					rs=db.getRowset(qry);
					rs.next();
				  //-----------Log Entry------------
					db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"WORK FLOW LEVEL CRITERIA ADDITION - FOR NOC", "WFCode: "+QryWFCode+" WFType: "+QryWFType+" WFLevel: "+QryWFLevel+" WFSeq: "+mWFSeqc+" Dept: "+mDeptCode, "No MAC Address" , mIPAddress);
				  //----------------------------------
				}
				else
				{
					%><CENTER><br><%
					out.print("<img src='../../../Images/Error1.gif'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error while adding!</font> <br>");
					%></CENTER><%
				}
			}
			else
			{
				%><CENTER><br><%
				out.print("<img src='../../../Images/Error1.gif'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Criteria-Based From Value / To Value are already exists!</font> <br>");
				%></CENTER><%
			}
		   }
		}
		else
		{
			%><CENTER><br><%
			out.print("<img src='../../../Images/Error1.gif'>");
			out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Plese Check Level!</font> <br>");
			%></CENTER><%
		}
	} //closing of outer if
	qry="Select WFLEVEL, nvl(FROMVALUE,0)CBFR, nvl(TOVALUE,0)CBTO, Decode(APPROVALTEXTTOBEDISPLAYED,'A','Approve','F','Forward','G','Grant','R','Recommend','Approve') AprTxt ";
	qry=qry+" FROM WF#EMPWISEWORKFLOWAUTHORITY WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInstitute+"' ";
	qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' and FACULTYTYPE='"+mFacType+"' AND WFLEVEL='"+QryWFLevel+"' Order By CBFR, CBTO";
	rs=db.getRowset(qry);
	//out.print(qry);
	%>
	<table align=center width="100%" bottommargin=0 topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Existing Criteria</FONT></u></b></font></td></tr>
	</table>
	<table class="sort-table" id="table-1" border=1 cellpadding=0 cellspacing=0 align=center>
	<thead>
		<tr bgcolor="#ff8c00">
		<td align=center nowrap><font color=white><B>Level</B></font></td>
		<td align=center nowrap><font color=white><B>Criteria</B></font></td>
		<td align=center nowrap><font color=white><B>From Value</B></font></td>
		<td align=center nowrap><font color=white><B>To Value</B></font></td>						
		<td align=center nowrap><font color=white><B>Approval Text</B></font></td>
		</tr>
	</thead>
	<tbody>
	<%
	int mSno=0;
	while(rs.next())
	{
		mSno++;
		%>
		<tr>
		<td align=center><font color=<%=mColor%>><%=QryWFLevel%></font></td>
		<td align=center><font color=<%=mColor%>><%=mSno%></font></td>
		<td align=center><font color=<%=mColor%>><%=rs.getInt("CBFR")%></font></td>
		<td align=center><font color=<%=mColor%>><%=rs.getInt("CBTO")%></font></td>
		<td align=center><font color=<%=mColor%>><%=rs.getString("AprTxt")%></font></td>
		</tr>
		<%
	}
	%>
	</tbody>
	</table>
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
	//out.print(e.getMessage());
}
%>
</form>
</body>
</html>