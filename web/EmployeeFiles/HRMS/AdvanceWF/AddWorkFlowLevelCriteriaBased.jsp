<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;

GlobalFunctions gb =new GlobalFunctions();
int ctr=0, CTR=0, mMaxLevel=0, mLeaveApprovalLevel=0,mFrVal=0,mToVal=0;
int mTotalLvDays=0, mPAID=0, mLWP=0, mWFSeq=0, mWFSeqc=0;
String mApprBy="", mApprAuth="", mApprovalById="", mAprMemID="", mApprovalByName="";
String mDepartmentCode="", mDeptCode="", QryDept="", mChangeCase="";
String mEmpName="", mEmpCode="", QryEmp="", mEmpID="";
String mDegsName="", mDegsCode="", QryDegs="", x1="",x2="",mChkCB="";
String qry="",qry1="";
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
String QryReqDate="", QryRID="", QryWFLevel="", QryWFCode="", QryWFType="", QryLvDateFr="", QryLvDateTo="", QryLvPurp="";
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
if(request.getParameter("RID")==null)
{
	QryRID="";
}
else
{
	QryRID=request.getParameter("RID").toString().trim();	
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
	QryWFLevel="";
}
else
{
	QryWFLevel=request.getParameter("WFL").toString().trim();
}

if(request.getParameter("DATEFROM")==null)
{
	QryLvDateFr="";
}
else
{
	QryLvDateFr=request.getParameter("DATEFROM").toString().trim();
}

if(request.getParameter("DATETO")==null)
{
	QryLvDateTo="";
}
else
{
	QryLvDateTo=request.getParameter("DATETO").toString().trim();
}

if(request.getParameter("TLD")==null)
{
	mTotalLvDays=0;
}
else
{
	mTotalLvDays=Integer.parseInt(request.getParameter("TLD").toString().trim());
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
<SCRIPT>
function FunSubmit1()
{
	//document.frm.action="LeaveRequestInbox.jsp" ;
	window.close();
}
function FunCBLReq()
{
	//alert(document.frm.ChkCB.checked);
	if(document.frm.ChkCB.checked==false)
	{
		document.frm.FromVal.disabled=true;
		document.frm.ToVal.disabled=true;
	}
	else
	{
		document.frm.FromVal.disabled=false;
		document.frm.ToVal.disabled=false;
	}
}
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if(rs.next())
				mInstitute=rs.getString(1);
			else
				mInstitute="JIIT";
	  //----------------------
	%>
	<table id=id1 width=100% ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Add Approval Level For <%=QryWFCode%> [<%=QryWFType%>] Work Flow</B></font></td></tr>
	</TABLE>
	<form name="frm"  method="post">
	<input id="x" name="x" type=hidden>
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
	qry="select nvl(Max(WFLEVEL),0)MaxLevel from WF#WORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInstitute+"'";
	qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' GROUP BY COMPANYCODE, INSTITUTECODE, WORKFLOWCODE, WORKFLOWTYPE, DEPARTMENTCODE";
    	rs=db.getRowset(qry);
	//out.print(qry);
	while(rs.next())
	{
		CTR=rs.getInt("MaxLevel");
		CTR++;
	}
	qry="select nvl(Max(WFSEQUENCE),0)WFSEQC from WF#WORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInstitute+"'";
	qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"'";
	qry=qry+" GROUP BY COMPANYCODE, INSTITUTECODE, WORKFLOWCODE, WORKFLOWTYPE, DEPARTMENTCODE";
	rs2=db.getRowset(qry);
	//out.print(qry);
	if(rs2.next())
	{
		mWFSeqc=rs2.getInt("WFSEQC");
		mWFSeqc++;
	}
	//out.print(mWFSeqc);
	%>
	<tr><td nowrap>
	<font color=darkpink face=arial size=2><STRONG>&nbsp; Level <%=CTR%> : <img src="../../../Images/arrow.gif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </STRONG>
	</td>
	</tr>
	<tr><td><table border=2 bordercolor="#de6400" width=100% cellpadding=0 cellspacing=0 bgcolor="" rules="none">
	<tr><td align=center><font color=navy face=arial size=2><STRONG>&nbsp; Approval By <img src="../../../Images/arrow.gif"></STRONG></font></td>
	<td align=center><font color=navy face=arial size=2><STRONG>&nbsp; Approval Authority <img src="../../../Images/arrow.gif"></STRONG></font></td></tr>
	<tr>
	<td nowrap><input type="radio" value="H" Name="ApprBy" ID="ApprBy" checked><font color=black face=arial size=2><STRONG>HOD [Self Department]</STRONG></font></td>
	<%
	qry="Select nvl(EmployeeName,' ')EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (Select EmployeeID From HODLIST WHERE DEPARTMENTCODE='"+mDeptCode+"') and nvl(DEACTIVE,'N')='N'";
	rs1=db.getRowset(qry);
	rs1.next();
	%>
	<td nowrap><input type="text" value="<%=rs1.getString("EmpName")%> [<%=mDeptCode%>]" Name="HODSelf" ID="HODSelf" size=38 READONLY></td>
	</tr>
	<tr>
	<td nowrap><input type="radio" value="O" Name="ApprBy" ID="ApprBy"><font color=black face=arial size=2><STRONG>HOD [Other Department]</STRONG></font></td>
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
		<td nowrap><input type="radio" value="E" Name="ApprBy" ID="ApprBy"><font color=black face=arial size=2><STRONG>Employee</STRONG></font></td>
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
		<td nowrap><input type="radio" value="D" Name="ApprBy" ID="ApprBy"><font color=black face=arial size=2><STRONG>Designation Based</STRONG></font></td>
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
		</td>
		</tr>
		<tr><td colspan=2 align=left nowrap><input type='checkbox' name='ChkCB' id='ChkCB' value='Required' onclick="FunCBLReq()"><font color="#000099" face=arial size=2><STRONG>Criteria Based Level Required ?</font></td></tr>
		<tr><td><font color=black face=arial size=2><STRONG>&nbsp; &nbsp; &nbsp;From Value </STRONG></font><input type='text' name='FromVal' id='FromVal' value="" size=2></td>
		<td><font color=black face=arial size=2><STRONG>To Value </STRONG></font><input type='text' name='ToVal' id='ToVal' value="" size=2></td></tr>
		</table></td></tr>
		<%
	//}
	%>
	<tr><td align=center><HR><INPUT id=submit1 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Close without adding any Level" name=submit1 value="Back" onclick="FunSubmit1()" onsubmit="FunSubmit1()"> &nbsp; <INPUT id=submit2 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Save" name=submit2 value="Save"></td></tr>
	</form>
	</table>
	<%
	if(request.getParameter("x")!=null)
	{
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
		//out.print("ApprBy "+mApprBy+" ApprAuth "+mApprAuth);

		if (request.getParameter("ChkCB")!=null)
			mChkCB=request.getParameter("ChkCB");
		else
			mChkCB="";

		if(mChkCB.equals("Required"))
		{
			if((request.getParameter("FromVal")!=null && !request.getParameter("FromVal").toString().trim().equals("")) && (request.getParameter("ToVal")!=null && !request.getParameter("ToVal").toString().trim().equals("")))
			{
				x1=request.getParameter("FromVal").toString().trim();
				x2=request.getParameter("ToVal").toString().trim();
				if (gb.isNumeric(x1)==true && gb.isNumeric(x2)==true)
				{
					mFrVal=Integer.parseInt(request.getParameter("FromVal"));
					mToVal=Integer.parseInt(request.getParameter("ToVal"));
				}
				else
				{
					%><BR><CENTER><%
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>From Value and To Value must be numeric!</font></b><br>");
					%></CENTER><%
				}
			}
			else
			{
				%><BR><CENTER><%
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>For Criteria Based, From Value and To Value can't be left blank!</font></b><br>");
				%></CENTER><%
			}
		}
	} //closing of outer if

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