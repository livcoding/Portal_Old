<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rse=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qrye="";
int ctr=0,n=0,ChkFlag=0;
int mTotal=0;
int mAprFlag=0,mFlag=0,mRecFlag=0,mWFLevel=0;
double mPAID=0,mLWP=0,mTotalLvDays=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="", mComp="";
String mEID="",mLeaveCode="",mDate1="",mDate2="", mPurposeOfLeave="";
String mAprStat="";
String mEid="";
String mChk="", mSHDAY="", mEHDAY="",mAppDate="";
String mWebEmail="";
String QryFaculty="",QryRID="",QryWFType="",QryWFCode="LEAVE",mDeptCode="";
String mRemarksFlag="",mRemark="";
int len=0,pos1=0;
int mFlag1=1;
int mFla=0;
ResultSet rsFrIndv=null,rsFrEmp=null,rsFrDept=null ;
ResultSet rs3=null;
ResultSet rs4=null;
String qry1="",qry2="",qry3="";
String mWFC="",mWFT="" ;
String  mApprovalById="",mApprovalByName="",mApprBy="",mApprAuth="";


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
if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (request.getParameter("InstCode")==null)
{
	mInst="";
}
else
{	
	mInst=request.getParameter("InstCode").toString().trim();
}

if(request.getParameter("EID")==null)
{
	QryFaculty="";
}
else
{
	QryFaculty=request.getParameter("EID").toString().trim();	
}

if(request.getParameter("WFC")==null)
{
	mWFC="";
}
else
{
	mWFC=request.getParameter("WFC").toString().trim();	
}
if(request.getParameter("WFT")==null)
{
	mWFT="";
}
else
{
	mWFT=request.getParameter("WFT").toString().trim();	
}

if(request.getParameter("RID")==null)
{
	QryRID="";
}
else
{
	QryRID=request.getParameter("RID").toString().trim();	
}

if (request.getParameter("LEAVECODE")==null)
{
	mLeaveCode="";
	//QryWFType="";
}
else
{	
	mLeaveCode=request.getParameter("LEAVECODE").toString().trim();
//	QryWFType=request.getParameter("LEAVECODE").toString().trim();
}

if (request.getParameter("DATEFROM")==null)
{
	mDate1="";
}
else
{	
	mDate1=request.getParameter("DATEFROM").toString().trim();
}

if (request.getParameter("DATETO")==null)
{
	mDate2="";
}
else
{	
	mDate2=request.getParameter("DATETO").toString().trim();
}
if (request.getParameter("POL")==null)
{
	mPurposeOfLeave="";
}
else
{	
	mPurposeOfLeave=request.getParameter("POL").toString().trim();
}
if (request.getParameter("APRSTAT")==null)
{
	mAprStat="";
}
else
{	
	mAprStat=request.getParameter("APRSTAT").toString().trim();
}

//out.print(mAprFlag);
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Self Leave Status ] </TITLE>
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
    	    document.frm.submit();
	}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInst=rs.getString(1);	
		else
			mInst="JIIT";
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('173','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
		 		   
			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Leave Request Detail</b></font></td></tr>
			</TABLE>
			<%
			String mENM="";
			qry="select EmployeeName||' ['||EmployeeCode||']' ENM,nvl(DEPARTMENTCODE,' ')DeptCode from employeemaster where employeeid='"+QryFaculty+"' and nvl(Deactive,'N')='N' and employeeid IN (Select nvl(employeeid,' ') from LeaveRequest where REQUESTID='"+QryRID+"')  ";
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mENM=rs1.getString("ENM");
				mDeptCode=rs1.getString("DeptCode");
			}
		
			qry="select nvl(B.PAID,0)PAID,nvl(B.WITHOUTPAY,0)LWP,nvl(to_char(B.APPROVEDDATE,'dd-mm-yyyy'),'')APPDATE from LEAVEREQUEST B  WHERE B.EMPLOYEEID='"+QryFaculty+"' and B.LEAVECODE='"+mLeaveCode+"' and B.COMPANYCODE='"+mComp+"'and B.REQUESTID='"+QryRID+"'"; 
			rs=db.getRowset(qry);
			if(rs.next())
			  {
				mPAID=rs.getDouble("PAID");
				mLWP=rs.getDouble("LWP");
				mTotalLvDays=mPAID+mLWP;
				mAppDate=rs.getString("APPDATE");
			 }
			 
			qry="select DISTINCT Decode(B.STARTHALFDAY,'B','PreLunch','A','PostLunch',' ')SHDAY, Decode(B.ENDHALFDAY,'B','PreLunch','A','PostLunch',' ')EHDAY from LEAVEREQUEST B,EMPLOYEEMASTER A WHERE B.EMPLOYEEID=A.EMPLOYEEID AND B.EMPLOYEEID='"+QryFaculty+"' and B.LEAVECODE='"+mLeaveCode+"' and B.COMPANYCODE='"+mComp+"' AND  B.REQUESTID='"+QryRID+"' ";
			rs=db.getRowset(qry);
			if(rs.next())
			   {
				mSHDAY=rs.getString("SHDAY");
				mEHDAY=rs.getString("EHDAY");
				
				if(mSHDAY.trim().equals(""))
					{
						mSHDAY="None";
					}
					else
					{
						mSHDAY=rs.getString("SHDAY");
					}
					if(mEHDAY.trim().equals(""))
					{
						mEHDAY="None";
					}
					else
					{
						mEHDAY=rs.getString("EHDAY");
					}
			   }
			qry="Select max(nvl(WFLEVEL,0))MaxLevel from WF#WORKFLOWDETAIL where REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND WORKFLOWCODE='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND DEPARTMENTCODE='"+mDeptCode+"' GROUP BY REQUESTID,INSTITUTECODE,WORKFLOWCODE,WORKFLOWTYPE,DEPARTMENTCODE ";
			rs=db.getRowset(qry);	
			if(rs.next())
			{
				mWFLevel=rs.getInt("MaxLevel");
			}
			%>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u>Status</u></b></font></td></tr>
			</table>
			<TABLE   rules=none cellSpacing=1 cellPadding=1 border=2 align=center>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Staff Name</B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><%=mENM%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Leave :</b> (<%=mLeaveCode%>)&nbsp;  </Font></td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;No. of Days Leave [<%=mLeaveCode%>] Applied </B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><%=mTotalLvDays%>&nbsp;<b>&nbsp;&nbsp;(&nbsp;</b><%=mDate1%>&nbsp; <b>to &nbsp; </b><%=mDate2%><b>&nbsp;)</b></Font></td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Half Day </B></td>
			<td><b>&nbsp; : &nbsp;</td></font><td><FONT Color=Black face=arial size=2><B>Start Day &nbsp;:&nbsp;</B><%=mSHDAY%></Font>&nbsp;&nbsp;<FONT Color=Black face=arial size=2><b>End Day&nbsp;:&nbsp;</b><%=mEHDAY%></font></td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Purpose of Leave </B></td><td><b>&nbsp; : </B></td><td> </Font><FONT Color=Black face=arial size=2><%=mPurposeOfLeave%></Font></td></tr>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Current Status </B></td><td><b>&nbsp; : &nbsp;</B></td>
<%
		if(mAprStat.equals("A"))
			{ 
				mFlag1=1;
			%>
			<td></Font><FONT Color=Black face=arial size=2> Leave Approved</Font></td></tr>
			<%
			}
			else if(mAprStat.equals("C"))
			{
			%>
		<td></Font><FONT Color=Black face=arial size=2> Leave Cancelled </Font></td></tr>			<%
			}
			else if(mAprStat.equals("P"))
			{
				mFlag1=1;
			%>
			<td> </Font><FONT Color=Black face=arial size=2>Approved upto <b><%=mWFLevel%></b>&nbsp; Level(s)</Font></td></tr>
			<%
			}
		if(mFlag1==1)
	   {
%>
			<tr>
			<td colspan=3>
			<table width=100% border=1 cellspacing=1 cellpadding=1>
			<tr bgcolor=orange>
			<td><font color=white><b>&nbsp;Level</b></font></td>
			<td><font color=white><b>&nbsp;Approval Authority</b></font></td>
			<td><font color=white><b>&nbsp;Approval Date</b></font></td>
			<td><font color=white><b>&nbsp;Approval Status</b></font></td>
			<td><font color=white><b>&nbsp;Remarks</b></font></td>
			</tr>
			<%
			qry="Select 'Y' from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"' and nvl(DEACTIVE,'N')='N'";
			rsFrIndv=db.getRowset(qry);
		
			qry1="Select 'Y' from WF#EMPWISEWORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' and workflowcode='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND EMPLOYEEID='"+QryFaculty+"'  and nvl(DEACTIVE,'N')='N'";
			rsFrEmp=db.getRowset(qry1);
			
			qry2="Select 'Y' from WF#WORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"'  and workflowcode='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND DEPARTMENTCODE='"+mDeptCode+"' and nvl(DEACTIVE,'N')='N'";
			rsFrDept=db.getRowset(qry2);
//out.print(qry2);
			if(rsFrIndv.next())
			{  //---1
				qry3="select nvl(WFLEVEL,0)WFLEVEL,nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"'";
				qry3=qry3+" and InstituteCode='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"' GROUP BY WFLEVEL,APPROVALBY,APPROVALAUTHORITY order by WFLEVEL desc";
			   	rs3=db.getRowset(qry3);
				// out.print(qry3);
				while(rs3.next())
	{ // ----2
	mApprBy=rs3.getString("APPRBY");
	mApprAuth=rs3.getString("APPRAUTH");

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
						rs4=db.getRowset(qry);
						if(rs4.next())
						{
							mApprovalById=rs4.getString("EmpId");
							mApprovalByName=rs4.getString("EmpName");
						}

	qry="Select nvl(WFLEVEL,0)WFLEVEL,decode(STATUS,'A','Approved','F','Forwarded','G','Granted','R','Recommended','C','Cancelled','Pending')STATUS,nvl(REMARKS,' ')REMARKS,nvl(REMARKSFLAG,' ')REMARKSFLAG,nvl(to_char(APPROVALDATETIME,'dd-mm-yyyy'),' ')APPROVALDATETIME from WF#WORKFLOWDETAIL where REQUESTID='"+QryRID+"'  AND WORKFLOWCODE='"+mWFC+"' AND  wflevel='"+rs3.getString("WFLEVEL")+"' and  WORKFLOWTYPE='"+mWFT+"'  GROUP BY REQUESTID,WORKFLOWCODE,WFLEVEL,STATUS,WORKFLOWTYPE,DEPARTMENTCODE,REMARKS,REMARKSFLAG,APPROVALDATETIME order by WFLEVEL desc";
	rs=db.getRowset(qry);	
	if(rs.next())
	{		//---3
	mFla=1;
			mRemarksFlag=rs.getString("REMARKSFLAG");
			len=mRemarksFlag.length();
			pos1=mRemarksFlag.indexOf("R");
			if(pos1>-1)
			{
				mRemark=rs.getString("REMARKS");
			}
			else
			{
				mRemark=" ";
			}
		%>
			<tr bgcolor=lightgreen>
			<td align=center><%=rs.getString("WFLEVEL")%></td>
			<td><%=mApprovalByName%></td>
			<td>&nbsp;&nbsp;<%=rs.getString("APPROVALDATETIME")%></td>
			<%
			if(rs.getString("STATUS").equals("Cancelled"))
			{
			%>
			<td><font color=red>&nbsp; &nbsp;<b><%=rs.getString("STATUS")%></b></font></td>
			<%
			}
			else
{
			%>
			<td >&nbsp; &nbsp;<b><%=rs.getString("STATUS")%></b></td>
			<%
			}
			%>
			<td>&nbsp;<%=mRemark%></td>
			</tr>

			  <%
			if(!rs3.isLast())
		{
		%>
		</tr>
		  <tr><td align=center colspan=6><img src="../../../Images/2aniarr1.gif"></td></tr>
		<%
		}
		
	 }  //---3
		if(mFla==0)
		{
		%>
			<tr bgcolor=lightyellow>
			<td align=center><%=rs3.getString("WFLEVEL")%></td>
			<td><%=mApprovalByName%></td>
			<td>&nbsp;</td>
			<td>&nbsp; &nbsp;Pending</td>
			<td>&nbsp;</td>
			</tr>
						 <%
			if(!rs3.isLast())
		{
		%>
		</tr>
		  <tr><td align=center colspan=6><img src="../../../Images/2aniarr1.gif"></td></tr>
		<%
		}

		
		}
		mFla=0;
			} // closing of while rs3---2

			
			} // closing of ---1
else if(rsFrEmp.next())
{  //----4

qry3="Select nvl(WFLEVEL,0)WFLEVEL,nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH  from WF#EMPWISEWORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND   workflowcode='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' AND  EMPLOYEEID='"+QryFaculty+"' and ( '"+mTotalLvDays+"' between FROMVALUE and TOVALUE )and nvl(DEACTIVE,'N')='N' GROUP BY WFLEVEL,APPROVALBY,APPROVALAUTHORITY order by WFLEVEL desc ";
rs3=db.getRowset(qry3);
while(rs3.next())
{ // ----2

mApprBy=rs3.getString("APPRBY");
	mApprAuth=rs3.getString("APPRAUTH");

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
						rs4=db.getRowset(qry);
						if(rs4.next())
						{
							mApprovalById=rs4.getString("EmpId");
							mApprovalByName=rs4.getString("EmpName");
						}
	qry="Select nvl(WFLEVEL,0)WFLEVEL,decode(STATUS,'A','Approved','F','Forwarded','G','Granted','R','Recommended','C','Cancelled','Pending')STATUS,nvl(REMARKS,' ')REMARKS,nvl(REMARKSFLAG,' ')REMARKSFLAG,nvl(to_char(APPROVALDATETIME,'dd-mm-yyyy'),' ')APPROVALDATETIME from WF#WORKFLOWDETAIL where REQUESTID='"+QryRID+"'  AND WORKFLOWCODE='"+mWFC+"' AND  wflevel='"+rs3.getString("WFLEVEL")+"' and  WORKFLOWTYPE='"+mWFT+"'  GROUP BY REQUESTID,WORKFLOWCODE,WFLEVEL,STATUS,WORKFLOWTYPE,DEPARTMENTCODE,REMARKS,REMARKSFLAG,APPROVALDATETIME order by WFLEVEL desc";
	rs=db.getRowset(qry);	
	if(rs.next())
	{		//---3
	mFla=1;
			mRemarksFlag=rs.getString("REMARKSFLAG");
			len=mRemarksFlag.length();
			pos1=mRemarksFlag.indexOf("R");
			if(pos1>-1)
			{
				mRemark=rs.getString("REMARKS");
			}
			else
			{
				mRemark=" ";
			}
		%>
			<tr bgcolor=lightgreen>
			<td align=center><%=rs.getString("WFLEVEL")%></td>
			<td><%=mApprovalByName%></td>
			<td>&nbsp;&nbsp;<%=rs.getString("APPROVALDATETIME")%></td>
						<%
			if(rs.getString("STATUS").equals("Cancelled"))
			{
			%>
			<td><font color=red>&nbsp; &nbsp;<b><%=rs.getString("STATUS")%></b></font></td>
			<%
			}
			else
{
			%>
			<td >&nbsp; &nbsp;<b><%=rs.getString("STATUS")%></b></td>
			<%
			}
			%>

			<td>&nbsp;<%=mRemark%></td>
			<%
			if(!rs3.isLast())
		{
		%>
		</tr>
		  <tr><td align=center colspan=6><img src="../../../Images/2aniarr1.gif"></td></tr>
		<%
		}
		
	 }  //---3
		if(mFla==0)
		{
		%>
			<tr bgcolor=lightyellow>
			<td align=center><%=rs3.getString("WFLEVEL")%></td>
			<td><%=mApprovalByName%></td>
			<td>&nbsp;</td>
			<td>&nbsp; &nbsp;Pending</td>
			<td>&nbsp;</td>
			<%
			if(!rs3.isLast())
		{
		%>
		</tr>
		  <tr><td align=center colspan=6><img src="../../../Images/2aniarr1.gif"></td></tr>
		<%
		}
		}
		mFla=0;
			} // closing of while rs3---2
	}  // closingf of ---4
	else if(rsFrDept.next())
	{  // ---5

qry3="Select nvl(WFLEVEL,0)WFLEVEL,nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH  from WF#WORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"'   and workflowcode='"+mWFC+"' AND WORKFLOWTYPE='"+mWFT+"' and ( '"+mTotalLvDays+"' between FROMVALUE and TOVALUE ) AND  nvl(DEACTIVE,'N')='N' GROUP BY WFLEVEL,APPROVALBY,APPROVALAUTHORITY order by WFLEVEL desc ";
rs3=db.getRowset(qry3);

while(rs3.next())
{ // ----2

mApprBy=rs3.getString("APPRBY");
	mApprAuth=rs3.getString("APPRAUTH");

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
						rs4=db.getRowset(qry);
						if(rs4.next())
						{
							mApprovalById=rs4.getString("EmpId");
							mApprovalByName=rs4.getString("EmpName");
						}

//**************************************

	qry="Select nvl(WFLEVEL,0)WFLEVEL,decode(STATUS,'A','Approved','F','Forwarded','G','Granted','R','Recommended','C','Cancelled','Pending')STATUS,nvl(REMARKS,' ')REMARKS,nvl(REMARKSFLAG,' ')REMARKSFLAG,nvl(APPROVALBY,' ')APPROVALBY,nvl(to_char(APPROVALDATETIME,'dd-mm-yyyy'),' ')APPROVALDATETIME from WF#WORKFLOWDETAIL where REQUESTID='"+QryRID+"'  AND WORKFLOWCODE='"+mWFC+"' AND  wflevel='"+rs3.getString("WFLEVEL")+"' and  WORKFLOWTYPE='"+mWFT+"'  GROUP BY REQUESTID,WORKFLOWCODE,WFLEVEL,STATUS,WORKFLOWTYPE,DEPARTMENTCODE,REMARKS,REMARKSFLAG,APPROVALBY,APPROVALDATETIME order by WFLEVEL desc";

	rs=db.getRowset(qry);	
	if(rs.next())
	{		//---3
	qrye="select NVL(employeename,' ')employeename from V#staff where employeeid='"+rs.getString("APPROVALBY")+"' and nvl(DEACTIVE,'N')='N'  ";
	rse=db.getRowset(qrye);
	if(rse.next())
	{
		mApprovalByName=rse.getString("employeename");
	}
	else
	{
		mApprovalByName="";
	}
			mFla=1;
			mRemarksFlag=rs.getString("REMARKSFLAG");
			len=mRemarksFlag.length();
			pos1=mRemarksFlag.indexOf("R");
			if(pos1>-1)
			{
				mRemark=rs.getString("REMARKS");
			}
			else
			{
				mRemark=" ";
			}
		%>
			<tr bgcolor=lightgreen>
			<td align=center><%=rs.getString("WFLEVEL")%></td>
			<td><%=mApprovalByName%></td>
			<td>&nbsp;&nbsp;<%=rs.getString("APPROVALDATETIME")%></td>
						<%
			if(rs.getString("STATUS").equals("Cancelled"))
			{
			%>
			<td><font color=red>&nbsp; &nbsp;<b><%=rs.getString("STATUS")%></b></font></td>
			<%
			}
			else
{
			%>
			<td >&nbsp; &nbsp;<b><%=rs.getString("STATUS")%></b></td>
			<%
			}
			%>

			<td>&nbsp;<%=mRemark%></td>
			</tr>
			</tr>
			<%
	if(!rs3.isLast())
	{
	%>
	  <tr><td align=center colspan=6><img src="../../../Images/2aniarr1.gif"></td></tr>
	<%
	}
	
	 }  //---3
		if(mFla==0)
		{
			%>
			<tr bgcolor=lightyellow>
			<td align=center><%=rs3.getString("WFLEVEL")%></td>
			<td><%=mApprovalByName%></td>
			<td>&nbsp;</td>
			<td>&nbsp; &nbsp;Pending</td>
			<td>&nbsp;</td>
			</tr>
			<%
		if(!rs3.isLast())
		{
		%>
		</tr>
		  <tr><td align=center colspan=6><img src="../../../Images/2aniarr1.gif"></td></tr>
		<%
		}
		}
		mFla=0;
			} // closing of while rs3---2
	}  // closing of ---5
	
	%>
		</table>
			</td>
			</tr>
			<%
	   }
				%>
			</table>
			<br>
			<table align='center' width='50%'>
			<tr><td bgcolor=lightgreen width=10%>&nbsp;&nbsp;&nbsp</td><td>Level Processed</td>
			<td bgcolor=lightyellow width=10%>&nbsp;&nbsp;&nbsp</td><td>Level to be Processed</td>
			</tr></table>

			</form>
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
		<h3><br><img src='../../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
		<P>This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font><br><br><br><br> 
   		<%
  		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}//try end
catch(Exception e)
{
//out.print(e);
}
%>

</body>
</html>