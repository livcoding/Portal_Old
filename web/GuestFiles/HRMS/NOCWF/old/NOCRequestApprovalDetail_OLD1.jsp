<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*"%>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rsFrIndv=null,rsFrEmp=null,rsFrDept=null;
ResultSet rs=null, rs1=null, rs2=null;

GlobalFunctions gb =new GlobalFunctions();
int mSno=0, CTR=0, mAprLevel=0, mMaxLevel=0, mLeaveApprovalLevel=0,mTotOnWFLevel=0;
int mWFSeq=0, mWFSequence=0, mWFLevel=0, mDelFlag=0;
int n=0, n1=0, mSendInfoFlag=0, InfoRemFlag=0;
double mTotalLvDays=0, mPAID=0, mLWP=0;
String mApprBy="", mApprAuth="", mApprovalById="", mAprMemID="", mApprovalByName="", mApproveBy="", mRemarks1="", mRemarks2="";
String mDeptCode="", mDepartment="", mFacType="I", mDiffPath="", CanStat="", CurrStat="";
String qry="",qry1="";
String mCanAllow="", mAprTxt="", mTextToAprDisp="", mTextToAprFrom="";
String mColor="",TRCOLOR="", mRightsID="162", mShowRemTo="", mShowRemarksTo="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="", mComp="";
String mFacultyName="",mFaculty="", mMsg="";
String QryReqDate="", QryRID="", QryFaculty="", QryWFCode="", QryWFType="", QryLvDateFr="", QryLvDateTo="", QryLvPurp="";
String mConsAs="", mFullCons="";
String mENM="",mcolor="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="";
String 	mRepDate="",mRelDate="",mRemark="",mWFC="",mWFT="";
int mNoticeDay=0;

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

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
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

if(request.getParameter("DiffPath")==null)
{
	mDiffPath="";
}
else
{
	mDiffPath=request.getParameter("DiffPath").toString().trim();	
}


//out.print("EID "+QryFaculty+" WFCode "+QryWFCode+" WFType "+QryWFType+" From "+QryLvDateFr+" To "+QryLvDateTo);
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ NOC Request Approval ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
 for (var i = 0; i < document.frm.elements.length; i++) 
 {
  var e = document.frm.elements[i]; 
  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
  { 
   e.checked = document.frm.allbox.checked;
  }
 }
}
</SCRIPT>
<SCRIPT>
function FunSubmit1()
{
	document.frm.action="LeaveRequestApprovalToNextLevel.jsp" ;
}
function FunSubmit2()
{
	document.frm.action="NOCRequestApprovalToChangedRoute.jsp" ;
}
function validate()
{
	maxlength=200;
	for (var i = 0; i < document.frm.elements.length; i++) 
	{
		var e = document.frm.elements[i]; 
		if (e.type == 'textarea') 
		{ 
			if(e.value.length>=maxlength)
			{
				alert("Remarks & Information to be delevered must be 200 characters or less");
				e.focus();
				return false;
			}
 		} 
	}
	return true;
}
function FunCopy()
{
	if(document.frm.COPY.checked==true)
	{
		var aaa=document.frm.Remarks1.value;
		document.frm.Remarks2.value = aaa;
		document.frm.COPY.checked=false;
	}
}
</SCRIPT>
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
		qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{


qry="select nvl(DEPARTMENTCODE,' ')DeptCode, EmployeeName||' ['||EmployeeCode||']' ENM from employeemaster where  nvl(Deactive,'N')='N'";
		qry=qry+" and employeeid IN (Select nvl(employeeid,' ') from employeeleaving where RequestID='"+QryRID+"')";
		rs=db.getRowset(qry);
		if(rs.next())
		{
				mENM=rs.getString("ENM");
				mDeptCode=rs.getString("DeptCode");
		}
		qry="SELECT nvl(EMPLOYEEID,' ')EMPLOYEEID,nvl(TYPE,' ')TYPE, nvl(to_char(REPORTINGDATE,'dd-mm-yyyy'),' ')REPORTINGDATE,nvl(to_char(DATEOFRELIEVING,'dd-mm-yyyy'),' ')DATEOFRELIEVING,nvl(REMARKS,' ')REMARKS,nvl(NOTICEDAYS,0)NOTICEDAYS,nvl(WORKFLOWCODE,' ')WORKFLOWCODE,nvl(WORKFLOWTYPE,' ')WORKFLOWTYPE FROM EMPLOYEELEAVING where  REQUESTID='"+QryRID+"' ";
		rs=db.getRowset(qry);
		// EMPLOYEEID='"+QryFaculty+"' and REQUESTID='"+QryRID+"' ";
		
		if(rs.next())
		{
			QryFaculty=rs.getString("EMPLOYEEID");
			mRepDate=rs.getString("REPORTINGDATE");
			mRelDate=rs.getString("DATEOFRELIEVING");
			mRemark=rs.getString("REMARKS");
			mNoticeDay=rs.getInt("NOTICEDAYS");
			mWFC=rs.getString("WORKFLOWCODE");
			mWFT=rs.getString("WORKFLOWTYPE");
		}

		   qry="Select NVL(STATUS,' ')STATUS FROM WF#WORKFLOWDETAIL WHERE REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"'";
		   rs=db.getRowset(qry);
		   //out.print(qry);
		   while(rs.next())
		   {
			CurrStat=rs.getString("STATUS");
			if(CurrStat.equals("C"))
			{
			   CanStat=CurrStat;
			   mDelFlag++;
			}
		   }
		   if(!CanStat.equals("C"))
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
			<form name="frm"  method="post" >
			<input id="x" name="x" type=hidden>
			<table id=id1 ALIGN=CENTER topmargin=0 cellspacing=0 cellpadding=0 rightmargin=0 leftmargin=0 bottommargin=0 width=103%>
<!-------------Page Heading and Marquee Message----------------------->
			<%
			try
			{
				String mPageHeader="NOC Work Flow For Approval/Cancellation", mMarqMsg="", CurrDate="";
				qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					CurrDate=rs.getString("CurrDate");
				}
				qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightsID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mMarqMsg=rs.getString("MarqMsg");
					%>
					<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
					<%
				}
				qry="Select nvl(B.PAGEHEADER,'NOC Work Flow For Approval/Cancellation')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mPageHeader=rs.getString("PageHeader");
					%>
					<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
					<%
				}
				else
				{
					%>
					<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
					<%
				}
			}
			catch(Exception e)
			{}
			%>
<!-------------Page Heading and Marquee Message----------------------->
			</table>
		
		
		
			<%
			qry="select nvl(DEPARTMENTCODE,' ')DeptCode, EmployeeName||' ['||EmployeeCode||']' ENM from employeemaster where employeeid='"+QryFaculty+"' and nvl(Deactive,'N')='N'";
			qry=qry+" and employeeid IN (Select nvl(employeeid,' ') from LeaveRequest where RequestID='"+QryRID+"')";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				mENM=rs.getString("ENM");
				mDeptCode=rs.getString("DeptCode");
			}

			qry="SELECT nvl(EMPLOYEEID,' ')EMPLOYEEID,nvl(TYPE,' ')TYPE, nvl(to_char(REPORTINGDATE,'dd-mm-yyyy'),' ')REPORTINGDATE,nvl(to_char(DATEOFRELIEVING,'dd-mm-yyyy'),' ')DATEOFRELIEVING,nvl(REMARKS,' ')REMARKS,nvl(NOTICEDAYS,0)NOTICEDAYS,nvl(WORKFLOWCODE,' ')WORKFLOWCODE,nvl(WORKFLOWTYPE,' ')WORKFLOWTYPE FROM EMPLOYEELEAVING where  REQUESTID='"+QryRID+"' ";
		rs=db.getRowset(qry);
		// EMPLOYEEID='"+QryFaculty+"' and REQUESTID='"+QryRID+"' ";
		
		if(rs.next())
		{
			QryFaculty=rs.getString("EMPLOYEEID");
			mRepDate=rs.getString("REPORTINGDATE");
			mRelDate=rs.getString("DATEOFRELIEVING");
			mRemark=rs.getString("REMARKS");
			mNoticeDay=rs.getInt("NOTICEDAYS");
			mWFC=rs.getString("WORKFLOWCODE");
			mWFT=rs.getString("WORKFLOWTYPE");
		}
			%>

			<table id="table-1" cellpadding=2 cellspacing=0 align=left rules=groups border=2>
				<!--Hiddens****-->
			<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInst%>'>
			<input type=hidden Name='WFCode' ID='WFCode' value='<%=QryWFCode%>'>
			<input type=hidden Name='LEAVECODE' ID='LEAVECODE' value='<%=QryWFType%>'>
			<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
			<input type=hidden Name='EID' ID='EID' value='<%=QryFaculty%>'>
			<tr><td nowrap><font color=black face=arial size=2><STRONG>&nbsp;NOC Request </STRONG></font></td>
			<td nowrap><font color=black face=arial size=2><b>: &nbsp; &nbsp;</b></font></td>
			<td nowrap><font color=black face=arial size=2><%=mWFC%> [<%=mWFT%>]</Font></td>
			<td nowrap><font color=black face=arial size=2><STRONG>&nbsp; &nbsp;&nbsp;Employee name : &nbsp;</STRONG></font></td>
			<td nowrap><font color=black face=arial size=2><%=mENM%></Font></td></tr>
			<tr><td nowrap><font color=black face=arial size=2><STRONG>&nbsp;Notice Period  </STRONG></font></td>
			<td nowrap><font color=black face=arial size=2><b>: &nbsp; &nbsp;</b></font></td>
			<td nowrap><font color=black face=arial size=2><%=mNoticeDay%><STRONG> day(s)</STRONG></Font></td>
			<td nowrap><font color=black face=arial size=2><STRONG>&nbsp; &nbsp; Reporting Date : &nbsp;</STRONG></font></td>
			<td nowrap><font color=black face=arial size=2><%=mRepDate%></Font></td></tr>
			<tr><td nowrap><font color=black face=arial size=2><STRONG>&nbsp;Relieving Date </STRONG></font></td>
			<td nowrap><font color=black face=arial size=2><b>: &nbsp; &nbsp;</b></font></td>
			<td nowrap><font color=black face=arial size=2><%=mRelDate%></Font></td>
			<td nowrap><font color=black face=arial size=2><STRONG>&nbsp; &nbsp; &nbsp; &nbsp;: &nbsp;</STRONG></font></td>
			<td nowrap><font color=black face=arial size=2>&nbsp;</Font></td></tr>
			<tr><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp;Remark  : &nbsp;</STRONG><%=mRemark%></Font></td>
			<tr><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp;NOC Approval/Cancellation Authority : &nbsp; <img src="../../../Images/arrow.gif"></STRONG></td></tr>
			<tr><td colspan=5 nowrap>
		<table><tr>
			<%

			qry="Select 'Y' from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"' and nvl(DEACTIVE,'N')='N'";
			rsFrIndv=db.getRowset(qry);
		
			qry1="Select 'Y' from WF#EMPWISEWORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' and workflowcode='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND EMPLOYEEID='"+QryFaculty+"'  and nvl(DEACTIVE,'N')='N'";
			rsFrEmp=db.getRowset(qry1);
			
			qry2="Select 'Y' from WF#WORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"'  and workflowcode='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND DEPARTMENTCODE='"+mDeptCode+"' and nvl(DEACTIVE,'N')='N'";
			rsFrDept=db.getRowset(qry2);

			//out.print(qry);
			if(rsFrIndv.next())
			{
				mTextToAprFrom="I";
//---------------Start Of if(rsFrIndv.next())----

				qry="Select nvl(MIN(WFL),0) WFL FROM";
				qry=qry+" (Select nvl(WFLEVEL,0)WFL from WF#REQUESTWORKFLOWPATH Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"' GROUP BY WFLEVEL";
				qry=qry+" MINUS ";
				qry=qry+" Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWDETAIL Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND REQUESTID='"+QryRID+"' GROUP BY WFLEVEL)";
				rs1=db.getRowset(qry);
				//out.print(qry);
				if(rs1.next())
				{
						mLeaveApprovalLevel=rs1.getInt("WFL");
				}
				qry="select nvl(WFLEVEL,0)MaxLevel from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"'";
				qry=qry+" and InstituteCode='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"' GROUP BY WFLEVEL order by MaxLevel Asc";
		    	rs=db.getRowset(qry);
				try
				{
					while(rs.next())
					{
						//out.print(QryRID);
						
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
						//out.print(qry);
						rs2=db.getRowset(qry);
						if(rs2.next())
						{
							mApprovalById=rs2.getString("EmpId");
							mApprovalByName=rs2.getString("EmpName");
						}
					//------------------------------
						if(CTR>=mLeaveApprovalLevel)
						{
							//------------------------------
							 if(CTR==mLeaveApprovalLevel)
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
					//out.print(e.getMessage()+"From Department");
				}
//---------------End Of if(rsFrIndv.next())----
			}
			else if(rsFrEmp.next())
			{
				mTextToAprFrom="E";
//---------------Start Of if(rsFrEmp.next())----

				qry="Select nvl(MIN(WFL),0) WFL FROM";
				qry=qry+" (Select nvl(WFLEVEL,0)WFL from WF#EMPWISEWORKFLOWAUTHORITY Where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' GROUP BY WFLEVEL";
				qry=qry+" MINUS ";
				qry=qry+" Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWDETAIL Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND REQUESTID='"+QryRID+"' GROUP BY WFLEVEL)";
				rs1=db.getRowset(qry);
				//out.print(qry);
				if(rs1.next())
				{
						mLeaveApprovalLevel=rs1.getInt("WFL");
				}

				qry="select nvl(WFLEVEL,0)MaxLevel from WF#EMPWISEWORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
				qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' GROUP BY WFLEVEL order by MaxLevel Asc";
			    	rs=db.getRowset(qry);
				//out.print(qry);
				try
				{
					while(rs.next())
					{
						//out.print(QryRID);
						
						CTR=rs.getInt("MaxLevel");

						qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(WFSEQUENCE,0)WFSEQ FROM WF#EMPWISEWORKFLOWAUTHORITY WHERE ";
						qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"'";
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
						//out.print(qry);
						rs2=db.getRowset(qry);
						if(rs2.next())
						{
							mApprovalById=rs2.getString("EmpId");
							mApprovalByName=rs2.getString("EmpName");
						}
						//------------------------------
						if(CTR>=mLeaveApprovalLevel)
						{
							//------------------------------
							 if(CTR==mLeaveApprovalLevel)
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
					//out.print(e.getMessage()+"From Department");
				}
//---------------End Of if(rsFrEmp.next())----
			}
			else if(rsFrDept.next())
			{
				mTextToAprFrom="D";
//---------------Start Of if(rsFrDept.next())----

			qry="Select nvl(MIN(WFL),0) WFL FROM";
			qry=qry+" (Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWAUTHORITY Where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND DEPARTMENTCODE='"+mDeptCode+"' GROUP BY WFLEVEL";
			qry=qry+" MINUS ";
			qry=qry+" Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWDETAIL Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND REQUESTID='"+QryRID+"' GROUP BY WFLEVEL)";
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
					mLeaveApprovalLevel=rs1.getInt("WFL");
			}

		
				qry="select nvl(WFLEVEL,0)MaxLevel from WF#WORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
				qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' GROUP BY WFLEVEL order by MaxLevel Asc";
				rs=db.getRowset(qry);
				try
				{
					while(rs.next())
					{
						//out.print(QryRID);
						
						CTR=rs.getInt("MaxLevel");

						qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(WFSEQUENCE,0)WFSEQ FROM WF#WORKFLOWAUTHORITY WHERE ";
						qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"'";
						qry=qry+" AND DEPARTMENTCODE='"+mDeptCode+"' AND WFLEVEL='"+CTR+"'";
						qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, DEPARTMENTCODE, WFSEQUENCE";
						rs1=db.getRowset(qry);
						
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
							qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"'";
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
						//out.print(qry);
						rs2=db.getRowset(qry);
						if(rs2.next())
						{
							mApprovalById=rs2.getString("EmpId");
							mApprovalByName=rs2.getString("EmpName");
						}
						//------------------------------
						if(CTR>=mLeaveApprovalLevel)
						{
							//------------------------------
							if(mLeaveApprovalLevel<=0)
							{
								//out.print(qry);
								%>
								<td nowrap><table cellspacing=0 cellpadding=0 border=0>
								<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Green><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
								<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
								</table></td>
								<%
							}
							else if(CTR==mLeaveApprovalLevel)
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
								<input type=hidden Name='DiffPath' ID='DiffPath' value='<%=mDiffPath%>'>
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
					//out.print(e.getMessage()+"From Department");
				}
//---------------End Of if(rsFrDept.next())----
			}
			%>
			</tr></table>
			</td></tr>
			<%
			if(mAprMemID.equals(mChkMemID))
			{
				if(mTextToAprFrom.equals("I"))
				{
					qry="Select Decode(APPROVALTEXTTOBEDISPLAYED,'A','Approve','F','Forward','G','Grant','R','Recommend','','Approve',APPROVALTEXTTOBEDISPLAYED) TXTDISP1, nvl(APPROVALTEXTTOBEDISPLAYED,'A')TXTDISP2, nvl(CANCELALLOWED,'Y') CANALLOW from WF#REQUESTWORKFLOWPATH WHERE ";
					qry=qry+" REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
					qry=qry+" AND DEPARTMENTCODE='"+mDeptCode+"' AND WFLEVEL='"+mLeaveApprovalLevel+"'";
				}
				else if(mTextToAprFrom.equals("E"))
				{
					qry="Select Decode(APPROVALTEXTTOBEDISPLAYED,'A','Approve','F','Forward','G','Grant','R','Recommend','','Approve',APPROVALTEXTTOBEDISPLAYED) TXTDISP1, nvl(APPROVALTEXTTOBEDISPLAYED,'A')TXTDISP2, nvl(CANCELALLOWED,'Y') CANALLOW from WF#EMPWISEWORKFLOWAUTHORITY WHERE ";
					qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"'";
					qry=qry+" AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and nvl(DEACTIVE,'N')='N' AND WFLEVEL='"+mLeaveApprovalLevel+"'";
				}
				else if(mTextToAprFrom.equals("D"))
				{
				qry="Select Decode(APPROVALTEXTTOBEDISPLAYED,'A','Approve','F','Forward','G','Grant','R','Recommend','','Approve',APPROVALTEXTTOBEDISPLAYED) TXTDISP1, nvl(APPROVALTEXTTOBEDISPLAYED,'A')TXTDISP2, nvl(CANCELALLOWED,'Y') CANALLOW from WF#WORKFLOWAUTHORITY WHERE ";
					qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"'";
					qry=qry+" AND DEPARTMENTCODE='"+mDeptCode+"' AND WFLEVEL='"+mLeaveApprovalLevel+"'";
				}
				rs=db.getRowset(qry);
				//out.print(qry);
				if(rs.next())
				{
					mTextToAprDisp=rs.getString("TXTDISP1");
					mAprTxt=rs.getString("TXTDISP2");
					if(mTextToAprDisp.equals(""))
						mTextToAprDisp="Approve";
					mCanAllow=rs.getString("CANALLOW");
				}
				%>
				<tr><td colspan="5">
				&nbsp;<font color=black face=arial size=2><STRONG>NOC Recommendation As : &nbsp;</STRONG></font>
				&nbsp; &nbsp; &nbsp; <input type="radio" value="A" name="AprStat" checked><b><font face="arial" size="2" color=green> <%=mTextToAprDisp%> </STRONG></font>
				<%
				if(mCanAllow.equals("Y"))
				{
				%>
				&nbsp; &nbsp; &nbsp; <input type="radio" value="C" name="AprStat"><b><font face="arial" size="2" color=RED> Cancel </STRONG></font>
				<%
				}
				%>
				</tr><td>
				<tr><td valign=middle colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp;Remarks for Approval/Cancellation ( If Any? ) : <img src="../../../Images/arrow.gif"></STRONG></font>
				<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; &nbsp; &nbsp;Show Remarks To </STRONG></font>
				<select name="ShowRemTo" tabindex="0" id="ShowRemTo">
				<%
				if(request.getParameter("ShowRemTo")==null)
	   			{
					mShowRemTo="S";
					%>
					<OPTION Value=A>All</option>
					<OPTION Value=J>Junior</option>
					<OPTION Value=S selected>Senior</option>
					<OPTION Value=R>Requestee</option>
					<OPTION Value=N>None</option>
					<%
	  			}
				else
				{
					mShowRemarksTo=request.getParameter("ShowRemTo");
					if(mShowRemTo.equals(""))
						mShowRemTo="S";
					if(mShowRemarksTo.equals("A"))
					{
						%>
						<OPTION Value=A selected>All</option>
						<OPTION Value=J>Junior</option>
						<OPTION Value=S>Senior</option>
						<OPTION Value=R>Requestee</option>
						<OPTION Value=N>None</option>
						<%
				      }
					else if(mShowRemarksTo.equals("J"))
					{
						%>
						<OPTION Value=A>All</option>
						<OPTION Value=J selected>Junior</option>
						<OPTION Value=S>Senior</option>
						<OPTION Value=R>Requestee</option>
						<OPTION Value=N>None</option>
						<%
					}
					else if(mShowRemarksTo.equals("S"))
					{
						%>
						<OPTION Value=A>All</option>
						<OPTION Value=J>Junior</option>
						<OPTION Value=S selected>Senior</option>
						<OPTION Value=R>Requestee</option>
						<OPTION Value=N>None</option>
						<%
					}
					else if(mShowRemarksTo.equals("R"))
					{
						%>
						<OPTION Value=A>All</option>
						<OPTION Value=J>Junior</option>
						<OPTION Value=S>Senior</option>
						<OPTION Value=R selected>Requestee</option>
						<OPTION Value=N>None</option>
						<%
					}
					else
					{
						%>
						<OPTION Value=A>All</option>
						<OPTION Value=J>Junior</option>
						<OPTION Value=S>Senior</option>
						<OPTION Value=R>Requestee</option>
						<OPTION Value=N selected>None</option>
						<%
					}
				}
				%>
				</select></td></tr>
				<tr><td colspan=5 nowrap>&nbsp;
				<%
				if(request.getParameter("x")==null)
				{
					%>
					<TextArea style="background-color:'offwhite'" Name='Remarks1' Id='Remarks1' maxlength=200 cols=71 rows=2></TextArea><FONT color=red>*</FONT>
					<%
				}
				else
				{
					%>
					<TextArea style="background-color:'offwhite'" Name='Remarks1' Id='Remarks1' maxlength=200 cols=71 rows=2 READONLY></TextArea><FONT color=red>*</FONT>
					<%
				}
				%>
				</td></tr>
				<tr><td valign=middle colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp;Details Regarding Information : <img src="../../../Images/arrow.gif"></STRONG></font>
				<font color=black face=arial size=2><font color=darkpink face=arial size=2><STRONG><input type='checkbox' style="back-color:yellow" name='COPY' id='COPY' value='Y' onclick="FunCopy()"></font><font color=Navy size=1>Copy from top</font><STRONG>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<font color=black><%=mTextToAprDisp%> Information Deliver To : <img src="../../../Images/arrow.gif"></STRONG></font></td></tr>
				<tr><td colspan=5 nowrap>&nbsp;
				<%
				if(request.getParameter("x")==null)
				{
					%>
					<TextArea style="background-color:'offwhite'" Name='Remarks2' Id='Remarks2' maxlength=200 cols=35 rows=3></TextArea><FONT color=red>*</FONT>
					<%
				}
				else
				{
					%>
					<TextArea style="background-color:'offwhite'" Name='Remarks2' Id='Remarks2' maxlength=200 cols=35 rows=3 READONLY></TextArea><FONT color=red>*</FONT>
					<%
				}
				qry="select distinct nvl(EMPLOYEEID,' ')EID, nvl(EMPLOYEECODE,' ')ECODE, nvl(EMPLOYEENAME,' ')ENAME, nvl(EMPLOYEETYPE,'I')ETYPE from V#STAFF where nvl(deactive,'N')='N' ORDER BY ENAME";
				//out.print(qry);
				rs=db.getRowset(qry);
				%>
				&nbsp; &nbsp; &nbsp;<SELECT id=EMP multiple size=3 name=EMP>
				<%
				while(rs.next())
				{
					%>
					<OPTION value=<%=rs.getString("EID")%>@@@<%=rs.getString("ETYPE")%>><%=rs.getString("ENAME")%> (<%=rs.getString("ECODE")%>)</OPTION>
					<%
				}
				%>
				</SELECT>
				</td></tr>
				<%
				if(mDiffPath.equals("Y"))
				{
				%>
				<tr><td colspan=5 align=left nowrap>
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
				<INPUT id=submit1 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 140px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Save & Forward To Next Level" name=submit1 value="Save & Forward" OnSubmit="return validate()">
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				<INPUT id=submit2 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 140px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Change Work Flow Route From Current Level To Be Approved Onwards..." name=submit2 value="Change Route" target=_New onclick="FunSubmit2()" onsubmit="FunSubmit2()">
				</td></tr>
				<%
				}
				else
				{
				%>
				<tr><td colspan=5 align=center nowrap>
				<INPUT id=submit1 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 140px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Save & Forward To Next Level" name=submit1 value="Save & Forward">
				</td></tr>
				<%
				}
			}
			%>
			<tr><td colspan="5"><HR>
			<table align=left><tr>
			<td bgcolor=Green align=left>&nbsp; &nbsp; &nbsp;</td>
			<td align=center><Font color=black face="arial" size=2><B>Level Approved &nbsp; &nbsp;</B></font></td>
			<td bgcolor=yellow align=center>&nbsp; &nbsp; &nbsp;</td>
			<td align=right><Font color=black face="arial" size=2><B>Level To Be Approved Currently &nbsp; &nbsp;</B></font></td>
			<td bgcolor=lightyellow align=left>&nbsp; &nbsp; &nbsp;</td>
			<td align=right><Font color=black face="arial" size=2><B>Level To Be Approved Sequently</B></font></td>
			</tr></table>
			</td></tr>
			<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("Remarks1")==null)
					mRemarks1="";
				else
					mRemarks1=request.getParameter("Remarks1").toString().trim();
				if(request.getParameter("Remarks2")==null)
					mRemarks2="";
				else
					mRemarks2=request.getParameter("Remarks2").toString().trim();
				if(request.getParameter("ShowRemTo")==null)
					mShowRemTo="";
				else
					mShowRemTo=request.getParameter("ShowRemTo").toString().trim();
				String mEMP[]=request.getParameterValues("EMP");

				if(request.getParameter("AprStat")==null)
					mFullCons="";
				else
					mFullCons=request.getParameter("AprStat").toString().trim();
				if(request.getParameter("ApproveBy")==null)
					mApproveBy="";
				else
					mApproveBy=request.getParameter("ApproveBy").toString().trim();
				if(request.getParameter("DeptCode")==null)
					mDepartment="";
				else
					mDepartment=request.getParameter("DeptCode").toString().trim();
				if(request.getParameter("WFSeq")==null)
					mWFSequence=0;
				else
					mWFSequence=Integer.parseInt(request.getParameter("WFSeq").toString().trim());
				if(request.getParameter("WFLevel")==null)
					mWFLevel=0;
				else
					mWFLevel=Integer.parseInt(request.getParameter("WFLevel").toString().trim());

				//out.print(mShowRemTo+"-"+mRemarks1+"-"+mFullCons+"-"+mApproveBy+"-"+mDepartment+"-"+mWFSequence+"-"+mWFLevel);

			qry="select 'Y' from WF#WORKFLOWDETAIL where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"'";
			qry=qry+" AND DEPARTMENTCODE='"+mDeptCode+"' AND WFSEQUENCE="+mWFSeq+" AND WFLEVEL="+mWFLevel+" AND REQUESTID='"+QryRID+"'";
				//out.print(qry);
				rs=db.getRowset(qry);
				if(!rs.next())
				{
					if(!mRemarks1.equals("") && mRemarks1.length()<=200)
					{
	qry="INSERT INTO WF#WORKFLOWDETAIL(COMPANYCODE, INSTITUTECODE, WORKFLOWCODE, WORKFLOWTYPE, DEPARTMENTCODE, WFSEQUENCE, WFLEVEL, REQUESTID, STATUS, REMARKS, APPROVALBY, APPROVALDATETIME, APPROVALTEXTTOBEDISPLAYED, CANCELALLOWED, REMARKSFLAG)";
					qry=qry+" VALUES('"+mComp+"', '"+mInst+"', '"+mWFC+"', '"+mWFT+"', '"+mDeptCode+"', "+mWFSeq+", "+mWFLevel+", '"+QryRID+"', '"+mFullCons+"',  '"+mRemarks1+"', '"+mApproveBy+"', sysdate, '"+mTextToAprDisp+"', '"+mCanAllow+"', '"+mShowRemTo+"')";
			//		*************************************************************
						n=db.insertRow(qry);
						//out.print(qry);
						if(n>0 && mFullCons.equals("A"))
						{
						  //-----------Log Entry------------
						db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"NOC WORK FLOW APPROVAL/CANCELLATION", "Staff: "+QryFaculty+"  Request: "+QryRID+" - Approved", "No MAC Address" , mIPAddress);
						  //----------------------------------
							if(mDiffPath.equals("Y"))
							{
								%>
								<LEFT><Br><b><font size=2 face='Arial' color='Green'>
								NOC Recommendation on Current Level is Successful... <a href='NOCRequestApprovalToChangedRoute.jsp?EID=<%=QryFaculty%>&amp;RID=<%=QryRID%>&amp;LEAVECODE=<%=QryWFType%>&amp;DeptCode=<%=mDeptCode%>' style='cursor:hand'><font color=blue>Click </font></a>To Change Subsequent Route
								</font></LEFT>
								<%
								//RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestApprovalToChangedRoute.jsp");
								//rd.forward(request,response);
							}
							else
							{
								//RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestApprovalDetail.jsp");
								//request.setAttribute("message","Msg1");
								//rd.forward(request,response);
								%><CENTER><%
								out.print("<br>&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Green'>NOC Recommendation on Current Level is Successful...</font> <br>");
								%></CENTER><%
							}
							mSendInfoFlag++;
						}
						else if(n>0 && mFullCons.equals("C"))
						{
							%><CENTER><%
							out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Green'>NOC </Font><Font color='RED'>Cancellation</Font> <Font color='Green'>Successful...</font> <br>");
							%></CENTER><br><%
						  //-----------Log Entry------------
							db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"NOC WORK FLOW APPROVAL/CANCELLATION", "Staff: "+QryFaculty+" Request: "+QryRID+" - Canceled", "No MAC Address" , mIPAddress);
						  //----------------------------------
							mSendInfoFlag++;
						}
						else
						{
						%><CENTER><%
							out.print("<img src='../../Images/Error1.gif'>");
							out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error while NOC Approval/Cancellation!</font> <br>");
							%></CENTER><%
						}
						if(mSendInfoFlag>0)
						{
							String mEmpID="", mEmpId="", mEmpType="";
							if(mEMP!=null)
							{
							for (int i=0;i<mEMP.length;i++)
							{
								mEmpId=mEMP[i];
								if(mEmpId.indexOf("@@@")>0)
								{
									int lenReq=mEmpId.length();
									int posReq=mEmpId.indexOf("@@@");
									mEmpID=mEmpId.substring(0,posReq);
									mEmpType=mEmpId.substring(posReq+3,lenReq);
								}
								if(!mRemarks2.equals(""))
								{
								   if(mRemarks2.length()<=200)
								   {
									qry="Select 'Y' from MESSAGEFORME WHERE MEMBERID='"+mEmpID+"' AND MEMBERTYPE='"+mEmpType+"' AND REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND WFSEQUENCE='"+mWFSeq+"'";
									rs=db.getRowset(qry);
									if(!rs.next())
									{
										qry="INSERT INTO MESSAGEFORME (MEMBERID, MEMBERTYPE, REQUESTID, COMPANYCODE, INSTITUTECODE, WORKFLOWCODE, WORKFLOWTYPE, DEPARTMENTCODE, WFSEQUENCE, STATUS,  REMARKS, APPROVALBY, APPROVALDATETIME, MSGFLAG, DEACTIVE)";
										qry=qry+" VALUES('"+mEmpID+"', '"+mEmpType+"', '"+QryRID+"', '"+mComp+"', '"+mInst+"', '"+mWFC+"', '"+mWFT+"', '"+mDeptCode+"', "+mWFSeq+", '"+mFullCons+"', , '"+mRemarks2+"', '"+mApproveBy+"', sysdate, '', 'N')";
										n1=db.insertRow(qry);
										//out.print(qry);
										if(n1>0 && mFullCons.equals("A"))
										{
										  //-----------Log Entry------------
													db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"INFO FOR NOC WORK FLOW APPROVAL/CANCELLATION", "Informed To: "+mEmpID+" Request ID: "+QryRID+" - Approved", "No MAC Address" , mIPAddress);
										  //----------------------------------
										}
										else if(n1>0 && mFullCons.equals("C"))
										{
										  //-----------Log Entry------------
												db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"INFO FOR NOC WORK FLOW APPROVAL/CANCELLATION", "Informed To: "+mEmpID+" Request ID: "+QryRID+" - Cancelled", "No MAC Address" , mIPAddress);
										  //----------------------------------
										}
									}
								   }
								   else
								   {
									InfoRemFlag++;
								   }
								}
							}
							}
							if(InfoRemFlag>0)
							{
								%><LEFT><%
								out.print("&nbsp;&nbsp;&nbsp <Br><b><font size=2 face='Arial' color='RED'>Details about information to be delivered can't be more than 200 characters</font><br>");
								%></LEFT><br><%
							}
							if(n1>0)
							{
								%><LEFT><%
								out.print("&nbsp;&nbsp;&nbsp <Br><b><font size=2 face='Arial' color='Green'>An intimation is being sent to concerned people regarding this Recommendation...</font><br>");
								%></LEFT><br><%
							}
						}
					}
					else
					{
						%><CENTER><%
						out.print("<img src='../../../Images/Error1.gif'>");
						out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'>Remarks for NOC Recommendation can't be left blank or more than 200 characters!</font> <br>");
						%></CENTER><%
					}
				}
				//out.print(mMaxLevel+" -- "+mWFLevel);
				if(mWFLevel==mMaxLevel)
				{
					qry="UPDATE EMPLOYEELEAVING SET";
					qry=qry+" NODUESSTATUS='"+mFullCons+"',";
					qry=qry+" APPROVEDBY='"+mApproveBy+"',";
					qry=qry+" APPROVEDDATE=sysdate ";
					qry=qry+" where REQUESTID='"+QryRID+"' AND EMPLOYEEID='"+QryFaculty+"'  ";
					int nn=db.update(qry);
					int nn=db.update(qry);
					//out.print(qry);
					if (nn>0)
					{
						%><CENTER><%
						out.print("<img src='../../../Images/Error1.gif'>");
						out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>NOC Request Approval/Cancellation has been finalised successfully... </font> <br>");
						%></CENTER><br><%
					}
				}
			} //closing of outer if
		   }
		   else
		   {
			if(mWFLevel==mMaxLevel)
			{
				qry="UPDATE EMPLOYEELEAVING SET";
					qry=qry+" NODUESSTATUS='"+CanStat+"',";
					qry=qry+" APPROVEDBY='"+mApproveBy+"',";
					qry=qry+" APPROVEDDATE=sysdate ";
					qry=qry+" where REQUESTID='"+QryRID+"' AND EMPLOYEEID='"+QryFaculty+"'  ";
				int nn=db.update(qry);
				//out.print(qry);
			}
		%><CENTER><%
			out.print("<img src='../../../Images/Error1.gif'>");
			out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>NOC Workflow of this request has been cancelled!</font> <br>");
			%></CENTER><%
		   }
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3>	<br><img src='../../../Images/Error1.gif'>	Access Denied (authentication_failed) </h3><br>
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
}
%>
</table>
</form>
</body>
</html>