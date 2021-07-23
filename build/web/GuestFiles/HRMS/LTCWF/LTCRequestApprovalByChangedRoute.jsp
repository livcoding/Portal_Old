<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rsFrIndv=null,rsFrEmp=null,rsFrDept=null;
ResultSet rs=null, rs1=null, rs2=null;

int ctr=0, CTR=0, mMaxLevel=0, mReqApprLevel=0, mTotOnWFL=0, mTotOnWFLevel=0;
int mWFSeq=0, mWFSeqc=0, QryWFLevel=0;
double QryTotReqVal=0;
String mApprBy="", mApprAuth="", mApprovalById="", mAprMemID="", mApprovalByName="";
String mDepartmentCode="", mDeptCode="", mDptCode="", mSelfDeptCode="", QryDept="", mChangeCase="";
String mEmpName="", mEmpCode="", QryEmp="", mEmpID="";
String mDegsName="", mDegsCode="", QryDegs="", mFacType="I", mTextToFwd="";
String qry="", mComp="", mInst="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String QryRID="", QryFaculty="", QryWFCode="", QryWFType="", QryDOA="", QryDOR="";
String QryChDvFor="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="", mName10="", mName11="", mName12="", mName13="";
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
	mComp="JIIT";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="JIIT";
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

if(request.getParameter("CTR")==null)
{
	QryWFLevel=0;
}
else
{
	QryWFLevel=Integer.parseInt(request.getParameter("CTR").toString().trim());
}

if(request.getParameter("WFType")==null)
{
	QryWFType="";
}
else
{
	QryWFType=request.getParameter("WFType").toString().trim();	
}

if(request.getParameter("WFCode")==null)
{
	QryWFCode="";
}
else
{
	QryWFCode=request.getParameter("WFCode").toString().trim();	
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

if(request.getParameter("Divert")==null)
{
	QryChDvFor="";
}
else
{
	QryChDvFor=request.getParameter("Divert").toString().trim();
}

if(request.getParameter("DeptCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=request.getParameter("DeptCode").toString().trim();
}

if(request.getParameter("REQVAL")==null)
{
	QryTotReqVal=0;
}
else
{
	QryTotReqVal=Double.parseDouble(request.getParameter("REQVAL").toString().trim());
}

if(QryChDvFor.equals("CurrCase"))
	mChangeCase="[for this request only]";
else if(QryChDvFor.equals("CurrEmp"))
	mChangeCase="[for this employee only]";
else if(QryChDvFor.equals("CurrDept"))
	mChangeCase="[for this department only]";

//out.print("DEPT - "+mDeptCode+" REQVAL - "+QryTotReqVal+" EID "+QryFaculty+" WFCode "+QryWFCode+" WFType "+QryWFType+" Adv Date - "+QryDOA+" Req Date - "+QryDOR+" Root for "+QryChDvFor);

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<style type="text/css">
<!--
BODY{
scrollbar-face-color:#fce9c5;
scrollbar-arrow-color:darkpink;
scrollbar-track-color:darkpink;
scrollbar-shadow-color:'';
scrollbar-highlight-color:'';
scrollbar-3dlight-color:'';
scrollbar-darkshadow-Color:'';
}
-->
</style>
<TITLE>#### <%=mHead%> [ <%=GlobalFunctions.toTtitleCase(QryWFCode)%> Request Approval ] </TITLE>

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

function FunActCurr()
{
	var TotCtr=document.frm.TotalCount.value;
	//alert(TotCtr);
	for(i=1;i<=TotCtr;i++)
	{
		mName1="ApprAuth_"+i;
		mName2="ApprByH_"+i;
		mName3="ApprByO_"+i;
		mName4="ApprByE_"+i;
		mName5="ApprByD_"+i;
		mName6="Checked_"+i;
		mName7="WFLevel_"+i;
		mName8="WFSeq_"+i;
		mName9="SelfDept_"+i;
		mName10="RequiredNext_"+i;
		mName11="ActiveCurr_"+i;
		mName12="SetTextToFwd_"+i;
		mName13="TextToFwd_"+i;
		//alert(document.frm[mName11][0].checked);
		if(document.frm[mName11][0].checked==true)
		{
			document.frm[mName1][0].disabled=false;
			document.frm[mName1][1].disabled=false;
			document.frm[mName1][2].disabled=false;
			document.frm[mName1][3].disabled=false;
			if(document.frm[mName1][0].checked==true)
			{
				document.frm[mName2].disabled=false;
			}
			if(document.frm[mName1][1].checked==true)
			{
				document.frm[mName3].disabled=false;
			}
			if(document.frm[mName1][2].checked==true)
			{
				document.frm[mName4].disabled=false;
			}
			if(document.frm[mName1][3].checked==true)
			{
				document.frm[mName5].disabled=false;
			}
			document.frm[mName12].disabled=false;
			//document.frm[mName6].disabled=false;
			//FunReqNxt(i);
		}
		else
		{
			document.frm[mName1][0].disabled=true;
			document.frm[mName1][1].disabled=true;
			document.frm[mName1][2].disabled=true;
			document.frm[mName1][3].disabled=true;
			document.frm[mName2].disabled=true;
			document.frm[mName3].disabled=true;
			document.frm[mName4].disabled=true;
			document.frm[mName5].disabled=true;
			document.frm[mName12].checked=false;
			document.frm[mName12].disabled=true;
			document.frm[mName13].disabled=true;
			//document.frm[mName6].disabled=true;
			//FunReqNxt(i);
		}
	}
}
function FunReqNxt(j)
{
	var x=parseInt(j);
	var TotCtr=document.frm.TotalCount.value;
	for(i=x+1;i<=TotCtr;i++)
	{
		mName1="ApprAuth_"+i;
		mName2="ApprByH_"+i;
		mName3="ApprByO_"+i;
		mName4="ApprByE_"+i;
		mName5="ApprByD_"+i;
		mName6="Checked_"+i;
		mName7="WFLevel_"+i;
		mName8="WFSeq_"+i;
		mName9="SelfDept_"+i;
		mName10="RequiredNext_"+(i-1);
		mName11="ActiveCurr_"+i;
		mName12="RequiredNext_"+i;
		mName12C="SetTextToFwd_"+i;
		mName13="TextToFwd_"+i;
		if(document.frm[mName10].checked==true)
		{
			if(document.frm[mName11][1].checked==false)
			{
				document.frm[mName1][0].disabled=false;
				document.frm[mName1][1].disabled=false;
				document.frm[mName1][2].disabled=false;
				document.frm[mName1][3].disabled=false;
				if(document.frm[mName1][0].checked==true)
				{
					document.frm[mName2].disabled=false;
				}
				else if(document.frm[mName1][1].checked==true)
				{
					document.frm[mName3].disabled=false;
				}
				else if(document.frm[mName1][2].checked==true)
				{
					document.frm[mName4].disabled=false;
				}
				else if(document.frm[mName1][3].checked==true)
				{
					document.frm[mName5].disabled=false;
				}
			}
			document.frm[mName11][0].disabled=false;
			document.frm[mName11][1].disabled=false;
			if(i<TotCtr)
			{
				document.frm[mName12].checked=true;
				document.frm[mName12].disabled=false;
			}
			document.frm[mName12C].checked=false;
			document.frm[mName12C].disabled=false;
			document.frm[mName13].disabled=false;
		}
		else
		{
			document.frm[mName1][0].disabled=true;
			document.frm[mName1][1].disabled=true;
			document.frm[mName1][2].disabled=true;
			document.frm[mName1][3].disabled=true;
			document.frm[mName2].disabled=true;
			document.frm[mName3].disabled=true;
			document.frm[mName4].disabled=true;
			document.frm[mName5].disabled=true;
			document.frm[mName11][0].disabled=true;
			document.frm[mName11][1].disabled=true;
			if(i<TotCtr)
			{
				document.frm[mName12].checked=false;
				document.frm[mName12].disabled=true;
			}
			document.frm[mName12C].checked=false;
			document.frm[mName12C].disabled=true;
			document.frm[mName13].disabled=true;
		}
	}
}
function FunLReqBy()
{
	var TotCtr=document.frm.TotalCount.value;
	//alert('ssss');
	for(i=1;i<=TotCtr;i++)
	{
		mName1="ApprAuth_"+i;
		mName2="ApprByH_"+i;
		mName3="ApprByO_"+i;
		mName4="ApprByE_"+i;
		mName5="ApprByD_"+i;

		document.frm[mName1][0].disabled=false;
		document.frm[mName1][1].disabled=false;
		document.frm[mName1][2].disabled=false;
		document.frm[mName1][3].disabled=false;

		if(document.frm[mName1][0].checked==true)
		{
			document.frm[mName2].disabled=false;
			document.frm[mName3].disabled=true;
			document.frm[mName4].disabled=true;
			document.frm[mName5].disabled=true;
		}
		else if(document.frm[mName1][1].checked==true)
		{
			document.frm[mName2].disabled=true;
			document.frm[mName3].disabled=false;
			document.frm[mName4].disabled=true;
			document.frm[mName5].disabled=true;
		}
		else if(document.frm[mName1][2].checked==true)
		{
			document.frm[mName2].disabled=true;
			document.frm[mName3].disabled=true;
			document.frm[mName4].disabled=false;
			document.frm[mName5].disabled=true;
		}
		else if(document.frm[mName1][3].checked==true)
		{
			document.frm[mName2].disabled=true;
			document.frm[mName3].disabled=true;
			document.frm[mName4].disabled=true;
			document.frm[mName5].disabled=false;
		}
	}
}
function FunTxtToFwd()
{
	var TotCtr=document.frm.TotalCount.value;
	for(i=1;i<=TotCtr;i++)
	{
		mName12="SetTextToFwd_"+i;
		mName13="TextToFwd_"+i;
		if(document.frm[mName12].checked==true)
		{
			//alert('checked');
			document.frm[mName13].disabled=false;
		}
		else
		{
			//alert('unchecked');
			document.frm[mName13].disabled=true;
		}
	}
}

</SCRIPT>
<SCRIPT>
function FunSubmit1()
{
	document.frm.action="LTCRequestInbox.jsp" ;
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
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onload="FunLReqBy()">
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
//-------------------------------------------------------
//-------------------------------------------------------
//---------------For Individual Request-------------------
//-------------------------------------------------------
//-------------------------------------------------------
			if(QryChDvFor.equals("CurrCase"))
			{
			%>
			<form name="frm" method="POST" ACTION="LTCRequestApprovalByChangedRouteActionForIndvReq.jsp">
			<input id="x" name="x" type=hidden>
			<table id=id1 width=100% ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Divert/Change Route For <%=QryWFCode%> [<%=QryWFType%>] Work Flow</B></font><br><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><%=mChangeCase%></font></TD>
			</font></td></tr>
			</TABLE>

			<table id="table-1" cellpadding=2 cellspacing=0 align=center rules=groups border=2>
			<!--Hiddens****-->
			<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInst%>'>
			<input type=hidden Name='WFCode' ID='WFCode' value='<%=QryWFCode%>'>
			<input type=hidden Name='WFType' ID='WFType' value='<%=QryWFType%>'>
			<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
			<input type=hidden Name='EID' ID='EID' value='<%=QryFaculty%>'>
			<input type=hidden Name='DOA' ID='DOA' value='<%=QryDOA%>'>
			<input type=hidden Name='DOR' ID='DOR' value='<%=QryDOR%>'>
			<input type=hidden Name='Divert' ID='Divert' value='<%=QryChDvFor%>'>
			<input type=hidden Name='REQVAL' ID='REQVAL' value='<%=QryTotReqVal%>'>

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
						qry=qry+" Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWDETAIL Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND REQUESTID='"+QryRID+"' GROUP BY WFLEVEL)";
						rs1=db.getRowset(qry);
						//out.print(qry);
						if(rs1.next())
						{
							mReqApprLevel=rs1.getInt("WFL");
						}
						CTR=rs.getInt("MaxLevel");

						qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, DEPARTMENTCODE DEPTCODE, WFSEQUENCE WFSEQ FROM WF#REQUESTWORKFLOWPATH WHERE ";
						qry=qry+" REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
						qry=qry+" AND DEPARTMENTCODE='"+mDeptCode+"' AND WFLEVEL='"+CTR+"'";
						qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, DEPARTMENTCODE, WFSEQUENCE";
					    	rs1=db.getRowset(qry);
						//out.print(qry);
						if(rs1.next())
						{
							mApprBy=rs1.getString("APPRBY");
							mApprAuth=rs1.getString("APPRAUTH");
							mSelfDeptCode=rs1.getString("DEPTCODE");
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
							<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Green><td nowrap> <img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
							<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
							</table></td>
							<%
						}
						else if(CTR==mReqApprLevel)
						{
							if(mAprMemID.equals(""))
								mAprMemID=mApprovalById;
							%>
							<td nowrap><table cellspacing=0 cellpadding=0 border=0>
							<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Yellow><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
							<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
							</table></td>
							<input type=hidden Name='ApproveBy' ID='ApproveBy' value='<%=mApprovalById%>'>
							<input type=hidden Name='DeptCode' ID='DeptCode' value='<%=mSelfDeptCode%>'>
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
						mApprovalById="";
						mApprovalByName="";
					}
					mMaxLevel=CTR;
				}
				catch(Exception e)
				{
					//out.print(e.getMessage());
				}
//---------------Start Of Approval Authority for if(rsFrIndv.next())----
				%>
				</tr></table>
				</td></tr>
				<tr><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp; Divert/Change Route As : <img src="../../../Images/arrow.gif"></STRONG></td></tr>
				<%
				qry="select nvl(WFLEVEL,0)MaxLevel from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND";
				qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"'";
				qry=qry+" GROUP BY REQUESTID, CompanyCode, InstituteCode, DEPARTMENTCODE, WFLEVEL order by MaxLevel Asc";
		    		rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					ctr++;
					CTR=rs.getInt("MaxLevel");

					qry="select nvl(WFSEQUENCE,0)WFSEQC, nvl(DEPARTMENTCODE,' ')SelfDeptCode from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"'";
					qry=qry+" AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' AND DEPARTMENTCODE='"+mDeptCode+"' and WFLEVEL='"+CTR+"'";
				    	rs2=db.getRowset(qry);
					//out.print(qry);
					if(rs2.next())
					{
						mWFSeqc=rs2.getInt("WFSEQC");
						mDepartmentCode=rs2.getString("SelfDeptCode");
					}

					mName1="ApprAuth_"+String.valueOf(ctr).trim();
					mName2="ApprByH_"+String.valueOf(ctr).trim();
					mName3="ApprByO_"+String.valueOf(ctr).trim();
					mName4="ApprByE_"+String.valueOf(ctr).trim();
					mName5="ApprByD_"+String.valueOf(ctr).trim();
					mName6="Checked_"+String.valueOf(ctr).trim();
					mName7="WFLevel_"+String.valueOf(ctr).trim();
					mName8="WFSeq_"+String.valueOf(ctr).trim();
					mName9="SelfDept_"+String.valueOf(ctr).trim();
					mName10="RequiredNext_"+String.valueOf(ctr).trim();
					mName11="ActiveCurr_"+String.valueOf(ctr).trim();
					mName12="SetTextToFwd_"+String.valueOf(ctr).trim();
					mName13="TextToFwd_"+String.valueOf(ctr).trim();
					%>
					<input type=Hidden name='<%=mName7%>' id='<%=mName7%>' value="<%=CTR%>">
					<input type=Hidden name='<%=mName8%>' id='<%=mName8%>' value="<%=mWFSeqc%>">
					<input type=Hidden name='<%=mName9%>' id='<%=mName9%>' value="<%=mDepartmentCode%>">
					<tr><td nowrap>
					<font color=Navy face=arial size=2><STRONG>&nbsp; Level <%=CTR%> : <img src="../../../Images/arrow.gif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </STRONG>
					<input type="radio" value="E" Name="<%=mName11%>" ID="<%=mName11%>" checked onclick="FunActCurr()"><STRONG><font face=arial size=2 color=green>Keep This Level Enabled</font></STRONG>
					<input type="radio" value="D" Name="<%=mName11%>" ID="<%=mName11%>" onclick="FunActCurr()"><STRONG><font face=arial size=2 color=red>Discard This Level From Work Flow</font></STRONG>
					</td>
					</tr>
					<tr><td><table border=2 bordercolor="#de6400" cellpadding=0 cellspacing=0 rules="none">
					<tr>
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="H" Name="<%=mName1%>" ID="<%=mName1%>" checked><font color=black face=arial size=2><STRONG>HOD [Self Department]</STRONG></font></td>
					<%
					qry="Select nvl(EmployeeName,' ')EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (Select EmployeeID From HODLIST WHERE DEPARTMENTCODE='"+mSelfDeptCode+"') and nvl(DEACTIVE,'N')='N'";
					rs1=db.getRowset(qry);
					//out.print(qry);
					rs1.next();
					%>
					<td nowrap><input type="text" value="<%=rs1.getString("EmpName")%> [<%=mSelfDeptCode%>]" Name="<%=mName2%>" ID="<%=mName2%>" size=38 READONLY></td>
					</tr>

					<tr>
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="O" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>HOD [Other Department]</STRONG></font></td>
					<td nowrap>
					<%
					qry="Select nvl(E.EmployeeName,' ')EName, nvl(D.DepartmentCode,' ')Dept from EmployeeMaster E, HODList D where E.EmployeeID=D.EmployeeID and nvl(E.Deactive,'N')='N' and nvl(D.Deactive,'N')='N'";
					qry=qry+" MINUS ";
					qry=qry+" Select nvl(E.EmployeeName,' ')EName, nvl(D.DepartmentCode,' ')Dept from EmployeeMaster E, HODList D where E.EmployeeID=D.EmployeeID and nvl(E.Deactive,'N')='N' and nvl(D.Deactive,'N')='N' and D.Departmentcode='"+mSelfDeptCode+"' ";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<select name=<%=mName3%> tabindex="0" id=<%=mName3%>>
					<%
					if(request.getParameter("x")==null)
					{
						while(rs1.next())
						{
						 	mDptCode=rs1.getString("Dept");
							if(QryDept.equals(""))
							{
								QryDept=mDptCode;
							}
							%>
							<option value=<%=mDptCode%>><%=rs1.getString("EName")%> [<%=mDptCode%>]</option>
							<%
						}
					}
					else
					{
						while(rs1.next())
						{
					   		mDptCode=rs1.getString("Dept");
							%>
							<option value=<%=mDptCode%>><%=rs1.getString("EName")%> [<%=mDptCode%>]</option>
							<%
						}
					}
					%>
					</select>
					</td>
					</tr>

					<tr>
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="E" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Employee</STRONG></font></td>
					<td nowrap>
					<%
					qry="Select nvl(EmployeeID,' ')EmpID, nvl(EmployeeCode,' ')EmpCode, nvl(EmployeeName,' ')EmpName from EmployeeMaster";
					qry=qry+" where COMPANYCODE='"+mComp+"' and nvl(Deactive,'N')='N' Order By EmpName";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<select name=<%=mName4%> tabindex="0" id=<%=mName4%>>
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
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="D" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Designation Based</STRONG></font></td>
					<td nowrap>
					<%

					qry="SELECT D.DESIGNATIONCODE DEGSCD, D.DESIGNATION DEGSNM From Designationmaster D where nvl(DEACTIVE,'*')='N'";
					qry=qry+" and D.DESIGNATIONCODE IN(Select E.DESIGNATIONCODE from EMPLOYEEMASTER E where nvl(E.DEACTIVE,'N')='N'";
			 		qry=qry+" and E.CompanyCode='"+mComp+"' GROUP By E.DESIGNATIONCODE HAVING Count(*)=1)";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<select name=<%=mName5%> tabindex="0" id=<%=mName5%>>
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
					<tr>
					<td nowrap width=300px><input type='checkbox' name='<%=mName12%>' id='<%=mName12%>' value="Y" onclick="FunTxtToFwd()"><font color=black face=arial size=2><STRONG>Text of <%=GlobalFunctions.toTtitleCase(QryWFCode)%> Recommendation</STRONG></font></td>
					<td nowrap>
					<select name=<%=mName13%> tabindex="0" id=<%=mName13%> disabled>
					<%
					if(request.getParameter("mName13")==null)
				   	{
						%>
						<OPTION Value=A selected>Approve</option>
						<OPTION Value=F>Forward</option>
						<OPTION Value=G>Grant</option>
						<OPTION Value=R>Recommend</option>
						<%
				  	}
					else
					{
						mTextToFwd=request.getParameter("mName13");
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
					<tr><td colspan=2 align=left nowrap>
					<%
					if(CTR<mReqApprLevel)
					{
						%>
						<input type='hidden' name='<%=mName6%>' id='<%=mName6%>' value='UnChecked'>
						<%
					}
					else
					{
						%>
						<input type='hidden' name='<%=mName6%>' id='<%=mName6%>' value='Checked'>
						<%
					}
					if(rs.isLast())
					{
						%>
						<a target=_new href="AddWorkFlowLevelForIndvReq.jsp?EID=<%=QryFaculty%>&amp;DeptCode=<%=mSelfDeptCode%>&amp;WFC=<%=QryWFCode%>&amp;WFT=<%=QryWFType%>&amp;WFL=<%=CTR%>&amp;RID=<%=QryRID%>&amp;TRV=<%=QryTotReqVal%>&amp;DOA=<%=QryDOA%>&amp;DOR=<%=QryDOR%>" title="Click to add more Approval Level"><marquee behavior=alternate scrolldelay=100 width=300px% style="cursor:hand"><font color="blue" face=arial size=2><STRONG>Next Approval Authority Required ?</STRONG></font></marquee></a>
						<%
					}
					else
					{
						%>
						<input type='checkbox' name='<%=mName10%>' id='<%=mName10%>' value='Required' checked onclick="FunReqNxt('<%=ctr%>')"><font color="#000099" face=arial size=2><STRONG>Change In Next Approval Authority Required ?</font>
						<%
					}
					%>
					</td></tr>
					</table></td></tr>
					<%
				}
//---------------End Of Approval Level for if(rsFrIndv.next())----
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
						qry=qry+" Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWDETAIL Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND REQUESTID='"+QryRID+"' GROUP BY WFLEVEL)";
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
							mTotOnWFL=rs1.getInt("Total");
						}
						if(mTotOnWFL>1)
						{
							qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(WFSEQUENCE,0)WFSEQ FROM WF#EMPWISEWORKFLOWAUTHORITY WHERE ";
							qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"'";
							qry=qry+" AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' AND WFLEVEL='"+CTR+"' AND "+QryTotReqVal+" between FROMVALUE and TOVALUE";
							qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, EMPLOYEEID, WFSEQUENCE";
						}
						else
						{
							qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(WFSEQUENCE,0)WFSEQ FROM WF#EMPWISEWORKFLOWAUTHORITY WHERE ";
							qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"'";
							qry=qry+" AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' AND WFLEVEL='"+CTR+"'";
							qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, EMPLOYEEID, WFSEQUENCE";
						}
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
						//out.print(qry);
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
							<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Green><td nowrap> <img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
							<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
							</table></td>
							<%
						}
						else if(CTR==mReqApprLevel)
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
						mApprovalById="";
						mApprovalByName="";
					}
					mMaxLevel=CTR;
				}
				catch(Exception e)
				{
					//out.print(e.getMessage());
				}
//---------------Start Of Approval Authority for if(rsFrEmp.next())----
				%>
				</tr></table>
				</td></tr>
				<tr><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp; Divert/Change Route As : <img src="../../../Images/arrow.gif"></STRONG></td></tr>
				<%
				qry="select nvl(WFLEVEL,0)MaxLevel from WF#EMPWISEWORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
				qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"'";
				qry=qry+" GROUP BY CompanyCode, InstituteCode, WORKFLOWCODE, WORKFLOWTYPE, EMPLOYEEID, FACULTYTYPE, WFLEVEL order by MaxLevel Asc";
		    		rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					ctr++;
					CTR=rs.getInt("MaxLevel");
					qry="select nvl(count(WFLEVEL),0) Total from WF#EMPWISEWORKFLOWAUTHORITY WHERE CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
					qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and WFLEVEL='"+CTR+"'";
					qry=qry+" group BY CompanyCode, InstituteCode, WORKFLOWCODE, WORKFLOWTYPE, EMPLOYEEID, FACULTYTYPE";
				    	rs1=db.getRowset(qry);
					//out.print(qry);
					if(rs1.next())
					{
						mTotOnWFLevel=rs1.getInt("Total");
					}
					if(mTotOnWFLevel>1)
					{
						qry="select nvl(WFSEQUENCE,0)WFSEQC from WF#EMPWISEWORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
						qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and WFLEVEL='"+CTR+"' AND "+QryTotReqVal+" between FROMVALUE and TOVALUE";
					    	rs2=db.getRowset(qry);
						//out.print(qry);
						if(rs2.next())
						{
							mWFSeqc=rs2.getInt("WFSEQC");
						}
					}
					else
					{
						qry="select nvl(WFSEQUENCE,0)WFSEQC from WF#EMPWISEWORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
						qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and WFLEVEL='"+CTR+"'";
					    	rs2=db.getRowset(qry);
						//out.print(qry);
						if(rs2.next())
						{
							mWFSeqc=rs2.getInt("WFSEQC");
						}
					}
					mName1="ApprAuth_"+String.valueOf(ctr).trim();
					mName2="ApprByH_"+String.valueOf(ctr).trim();
					mName3="ApprByO_"+String.valueOf(ctr).trim();
					mName4="ApprByE_"+String.valueOf(ctr).trim();
					mName5="ApprByD_"+String.valueOf(ctr).trim();
					mName6="Checked_"+String.valueOf(ctr).trim();
					mName7="WFLevel_"+String.valueOf(ctr).trim();
					mName8="WFSeq_"+String.valueOf(ctr).trim();
					mName9="SelfDept_"+String.valueOf(ctr).trim();
					mName10="RequiredNext_"+String.valueOf(ctr).trim();
					mName11="ActiveCurr_"+String.valueOf(ctr).trim();
					mName12="SetTextToFwd_"+String.valueOf(ctr).trim();
					mName13="TextToFwd_"+String.valueOf(ctr).trim();
					%>
					<input type=Hidden name='<%=mName7%>' id='<%=mName7%>' value="<%=CTR%>">
					<input type=Hidden name='<%=mName8%>' id='<%=mName8%>' value="<%=mWFSeqc%>">
					<input type=Hidden name='<%=mName9%>' id='<%=mName9%>' value="<%=mDeptCode%>">
					<tr><td nowrap>
					<font color=Navy face=arial size=2><STRONG>&nbsp; Level <%=CTR%> : <img src="../../../Images/arrow.gif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </STRONG>
					<input type="radio" value="E" Name="<%=mName11%>" ID="<%=mName11%>" checked onclick="FunActCurr()"><STRONG><font face=arial size=2 color=green>Keep This Level Enabled</font></STRONG>
					<input type="radio" value="D" Name="<%=mName11%>" ID="<%=mName11%>" onclick="FunActCurr()"><STRONG><font face=arial size=2 color=red>Discard This Level From Work Flow</font></STRONG>
					</td>
					</tr>
					<tr><td><table border=2 bordercolor="#de6400" cellpadding=0 cellspacing=0 rules="none">
					<tr>
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="H" Name="<%=mName1%>" ID="<%=mName1%>" checked><font color=black face=arial size=2><STRONG>HOD [Self Department]</STRONG></font></td>
					<%
					qry="Select nvl(EmployeeName,' ')EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (Select EmployeeID From HODLIST WHERE DEPARTMENTCODE='"+mDeptCode+"') and nvl(DEACTIVE,'N')='N'";
					rs1=db.getRowset(qry);
					//out.print(qry);
					rs1.next();
					%>
					<td nowrap><input type="text" value="<%=rs1.getString("EmpName")%> [<%=mDeptCode%>]" Name="<%=mName2%>" ID="<%=mName2%>" size=38 READONLY></td>
					</tr>

					<tr>
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="O" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>HOD [Other Department]</STRONG></font></td>
					<td nowrap>
					<%
					qry="Select nvl(E.EmployeeName,' ')EName, nvl(D.DepartmentCode,' ')Dept from EmployeeMaster E, HODList D where E.EmployeeID=D.EmployeeID and nvl(E.Deactive,'N')='N' and nvl(D.Deactive,'N')='N'";
					qry=qry+" MINUS ";
					qry=qry+" Select nvl(E.EmployeeName,' ')EName, nvl(D.DepartmentCode,' ')Dept from EmployeeMaster E, HODList D where E.EmployeeID=D.EmployeeID and nvl(E.Deactive,'N')='N' and nvl(D.Deactive,'N')='N' and D.Departmentcode='"+mDeptCode+"' ";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<select name=<%=mName3%> tabindex="0" id=<%=mName3%>>
					<%
					if(request.getParameter("x")==null)
					{
						while(rs1.next())
						{
						 	mDptCode=rs1.getString("Dept");
							if(QryDept.equals(""))
							{
								QryDept=mDptCode;
							}
							%>
							<option value=<%=mDptCode%>><%=rs1.getString("EName")%> [<%=mDptCode%>]</option>
							<%
						}
					}
					else
					{
						while(rs1.next())
						{
					   		mDptCode=rs1.getString("Dept");
							%>
							<option value=<%=mDptCode%>><%=rs1.getString("EName")%> [<%=mDptCode%>]</option>
							<%
						}
					}
					%>
					</select>
					</td>
					</tr>

					<tr>
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="E" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Employee</STRONG></font></td>
					<td nowrap>
					<%
					qry="Select nvl(EmployeeID,' ')EmpID, nvl(EmployeeCode,' ')EmpCode, nvl(EmployeeName,' ')EmpName from EmployeeMaster";
					qry=qry+" where COMPANYCODE='"+mComp+"' and nvl(Deactive,'N')='N' Order By EmpName";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<select name=<%=mName4%> tabindex="0" id=<%=mName4%>>
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
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="D" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Designation Based</STRONG></font></td>
					<td nowrap>
					<%

					qry="SELECT D.DESIGNATIONCODE DEGSCD, D.DESIGNATION DEGSNM From Designationmaster D where nvl(DEACTIVE,'*')='N'";
					qry=qry+" and D.DESIGNATIONCODE IN(Select E.DESIGNATIONCODE from EMPLOYEEMASTER E where nvl(E.DEACTIVE,'N')='N'";
			 		qry=qry+" and E.CompanyCode='"+mComp+"' GROUP By E.DESIGNATIONCODE HAVING Count(*)=1)";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<select name=<%=mName5%> tabindex="0" id=<%=mName5%>>
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
					<tr>
					<td nowrap width=300px><input type='checkbox' name='<%=mName12%>' id='<%=mName12%>' value="Y" onclick="FunTxtToFwd()"><font color=black face=arial size=2><STRONG>Text of <%=GlobalFunctions.toTtitleCase(QryWFCode)%> Recommendation</STRONG></font></td>
					<td nowrap>
					<select name=<%=mName13%> tabindex="0" id=<%=mName13%> disabled>
					<%
					if(request.getParameter("mName13")==null)
				   	{
						%>
						<OPTION Value=A selected>Approve</option>
						<OPTION Value=F>Forward</option>
						<OPTION Value=G>Grant</option>
						<OPTION Value=R>Recommend</option>
						<%
				  	}
					else
					{
						mTextToFwd=request.getParameter("mName13");
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
					<tr><td colspan=2 align=left nowrap>
					<%
					if(CTR<mReqApprLevel)
					{
						%>
						<input type='hidden' name='<%=mName6%>' id='<%=mName6%>' value='UnChecked'><!--<font color="#000099" face=arial size=2><STRONG>Change Approval Authority ?</font>-->
						<%
					}
					else
					{
						%>
						<input type='hidden' name='<%=mName6%>' id='<%=mName6%>' value='Checked'><!--<font color="#000099" face=arial size=2><STRONG>Change Approval Authority ?</font>-->
						<%
					}
					if(rs.isLast())
					{
						%>
						<a target=_new href="AddWorkFlowLevelForIndvReq.jsp?EID=<%=QryFaculty%>&amp;DeptCode=<%=mDeptCode%>&amp;WFC=<%=QryWFCode%>&amp;WFT=<%=QryWFType%>&amp;WFL=<%=CTR%>&amp;RID=<%=QryRID%>&amp;TRV=<%=QryTotReqVal%>&amp;DOA=<%=QryDOA%>&amp;DOR=<%=QryDOR%>" title="Click to add more Approval Level"><marquee behavior=alternate scrolldelay=100 width=300px% style="cursor:hand"><font color="blue" face=arial size=2><STRONG>Next Approval Authority Required ?</STRONG></font></marquee></a>
						<%
					}
					else
					{
						%>
						<input type='checkbox' name='<%=mName10%>' id='<%=mName10%>' value='Required' checked onclick="FunReqNxt('<%=ctr%>')"><font color="#000099" face=arial size=2><STRONG>Change In Next Approval Authority Required ?</font>
						<%
					}
					%>
					</td></tr>
					</table></td></tr>
					<%
				}
//---------------End Of Approval Level for if(rsFrEmp.next())----
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
						qry="Select nvl(MIN(WFL),0) WFL FROM";
						qry=qry+" (Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWAUTHORITY Where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' GROUP BY WFLEVEL";
						qry=qry+" MINUS ";
						qry=qry+" Select nvl(WFLEVEL,0)WFL from WF#WORKFLOWDETAIL Where REQUESTID='"+QryRID+"' AND CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND REQUESTID='"+QryRID+"' GROUP BY WFLEVEL)";
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
							mTotOnWFL=rs1.getInt("Total");
						}
						if(mTotOnWFL>1)
						{
							qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(DEPARTMENTCODE,' ')DEPTCODE, nvl(WFSEQUENCE,0)WFSEQ FROM WF#WORKFLOWAUTHORITY WHERE ";
							qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND WFLEVEL='"+CTR+"' AND "+QryTotReqVal+" between FROMVALUE and TOVALUE";
							qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, DEPARTMENTCODE, WFSEQUENCE";
						}
						else
						{
							qry="Select nvl(APPROVALBY,' ')APPRBY, nvl(APPROVALAUTHORITY,' ')APPRAUTH, nvl(DEPARTMENTCODE,' ')DEPTCODE, nvl(WFSEQUENCE,0)WFSEQ FROM WF#WORKFLOWAUTHORITY WHERE ";
							qry=qry+" CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' and WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' AND WFLEVEL='"+CTR+"'";
							qry=qry+" GROUP BY APPROVALBY, APPROVALAUTHORITY, DEPARTMENTCODE, WFSEQUENCE";
						}
						rs1=db.getRowset(qry);
						//out.print(qry);
						if(rs1.next())
						{
							mApprBy=rs1.getString("APPRBY");
							mApprAuth=rs1.getString("APPRAUTH");
							mSelfDeptCode=rs1.getString("DEPTCODE");
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
						if(CTR<mReqApprLevel)
						{
							%>
							<td nowrap><table cellspacing=0 cellpadding=0 border=0>
							<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Green><td nowrap> <img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
							<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
							</table></td>
							<%
						}
						else if(CTR==mReqApprLevel)
						{
							if(mAprMemID.equals(""))
								mAprMemID=mApprovalById;
							%>
							<td nowrap><table cellspacing=0 cellpadding=0 border=0>
							<tr><td align=middle nowrap><table cellspacing=0 cellpadding=0 border=5 bordercolor="#de6400"><tr bgcolor=Yellow><td nowrap><img src="../../../Images/arrow_cool.gif"> <b><FONT SIZE=2 face=arial color=Navy><%=mApprovalByName%></FONT></b></td><tr></table></td></tr>
							<tr><td align=middle nowrap><b><FONT SIZE=2 face=arial color=Navy>Level <%=CTR%></FONT></b></td></tr>
							</table></td>
							<input type=hidden Name='ApproveBy' ID='ApproveBy' value='<%=mApprovalById%>'>
							<input type=hidden Name='DeptCode' ID='DeptCode' value='<%=mSelfDeptCode%>'>
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
						mApprovalById="";
						mApprovalByName="";
					}
					mMaxLevel=CTR;
				}
				catch(Exception e)
				{
					//out.print(e.getMessage());
				}
//---------------Start Of Approval Authority for if(rsFrDept.next())----
				%>
				</tr></table>
				</td></tr>
				<tr><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp; Divert/Change Route As : <img src="../../../Images/arrow.gif"></STRONG></td></tr>
				<%
				qry="select nvl(WFLEVEL,0)MaxLevel from WF#WORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
				qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"'";
				qry=qry+" GROUP BY CompanyCode, InstituteCode, WORKFLOWCODE, WORKFLOWTYPE, DEPARTMENTCODE, WFLEVEL order by MaxLevel Asc";
		    		rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					ctr++;
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
						qry="select nvl(WFSEQUENCE,0)WFSEQC, nvl(DEPARTMENTCODE,' ')SelfDeptCode from WF#WORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
						qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' and WFLEVEL='"+CTR+"' AND "+QryTotReqVal+" between FROMVALUE and TOVALUE";
					    	rs2=db.getRowset(qry);
						//out.print(qry);
						if(rs2.next())
						{
							mWFSeqc=rs2.getInt("WFSEQC");
							mDepartmentCode=rs2.getString("SelfDeptCode");
						}
					}
					else
					{
						qry="select nvl(WFSEQUENCE,0)WFSEQC, nvl(DEPARTMENTCODE,' ')SelfDeptCode from WF#WORKFLOWAUTHORITY where CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"'";
						qry=qry+" AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND DEPARTMENTCODE='"+mDeptCode+"' and WFLEVEL='"+CTR+"'";
					    	rs2=db.getRowset(qry);
						//out.print(qry);
						if(rs2.next())
						{
							mWFSeqc=rs2.getInt("WFSEQC");
							mDepartmentCode=rs2.getString("SelfDeptCode");
						}
					}
					mName1="ApprAuth_"+String.valueOf(ctr).trim();
					mName2="ApprByH_"+String.valueOf(ctr).trim();
					mName3="ApprByO_"+String.valueOf(ctr).trim();
					mName4="ApprByE_"+String.valueOf(ctr).trim();
					mName5="ApprByD_"+String.valueOf(ctr).trim();
					mName6="Checked_"+String.valueOf(ctr).trim();
					mName7="WFLevel_"+String.valueOf(ctr).trim();
					mName8="WFSeq_"+String.valueOf(ctr).trim();
					mName9="SelfDept_"+String.valueOf(ctr).trim();
					mName10="RequiredNext_"+String.valueOf(ctr).trim();
					mName11="ActiveCurr_"+String.valueOf(ctr).trim();
					mName12="SetTextToFwd_"+String.valueOf(ctr).trim();
					mName13="TextToFwd_"+String.valueOf(ctr).trim();
					%>
					<input type=Hidden name='<%=mName7%>' id='<%=mName7%>' value="<%=CTR%>">
					<input type=Hidden name='<%=mName8%>' id='<%=mName8%>' value="<%=mWFSeqc%>">
					<input type=Hidden name='<%=mName9%>' id='<%=mName9%>' value="<%=mDepartmentCode%>">
					<tr><td nowrap>
					<font color=Navy face=arial size=2><STRONG>&nbsp; Level <%=CTR%> : <img src="../../../Images/arrow.gif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </STRONG>
					<input type="radio" value="E" Name="<%=mName11%>" ID="<%=mName11%>" checked onclick="FunActCurr()"><STRONG><font face=arial size=2 color=green>Keep This Level Enabled</font></STRONG>
					<input type="radio" value="D" Name="<%=mName11%>" ID="<%=mName11%>" onclick="FunActCurr()"><STRONG><font face=arial size=2 color=red>Discard This Level From Work Flow</font></STRONG>
					</td>
					</tr>
					<tr><td><table border=2 bordercolor="#de6400" cellpadding=0 cellspacing=0 rules="none">
					<tr>
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="H" Name="<%=mName1%>" ID="<%=mName1%>" checked><font color=black face=arial size=2><STRONG>HOD [Self Department]</STRONG></font></td>
					<%
					qry="Select nvl(EmployeeName,' ')EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (Select EmployeeID From HODLIST WHERE DEPARTMENTCODE='"+mSelfDeptCode+"') and nvl(DEACTIVE,'N')='N'";
					rs1=db.getRowset(qry);
					//out.print(qry);
					rs1.next();
					%>
					<td nowrap><input type="text" value="<%=rs1.getString("EmpName")%> [<%=mSelfDeptCode%>]" Name="<%=mName2%>" ID="<%=mName2%>" size=38 READONLY></td>
					</tr>

					<tr>
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="O" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>HOD [Other Department]</STRONG></font></td>
					<td nowrap>
					<%
					qry="Select nvl(E.EmployeeName,' ')EName, nvl(D.DepartmentCode,' ')Dept from EmployeeMaster E, HODList D where E.EmployeeID=D.EmployeeID and nvl(E.Deactive,'N')='N' and nvl(D.Deactive,'N')='N'";
					qry=qry+" MINUS ";
					qry=qry+" Select nvl(E.EmployeeName,' ')EName, nvl(D.DepartmentCode,' ')Dept from EmployeeMaster E, HODList D where E.EmployeeID=D.EmployeeID and nvl(E.Deactive,'N')='N' and nvl(D.Deactive,'N')='N' and D.Departmentcode='"+mSelfDeptCode+"' ";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<select name=<%=mName3%> tabindex="0" id=<%=mName3%>>
					<%
					if(request.getParameter("x")==null)
					{
						while(rs1.next())
						{
						 	mDptCode=rs1.getString("Dept");
							if(QryDept.equals(""))
							{
								QryDept=mDptCode;
							}
							%>
							<option value=<%=mDptCode%>><%=rs1.getString("EName")%> [<%=mDptCode%>]</option>
							<%
						}
					}
					else
					{
						while(rs1.next())
						{
					   		mDptCode=rs1.getString("Dept");
							%>
							<option value=<%=mDptCode%>><%=rs1.getString("EName")%> [<%=mDptCode%>]</option>
							<%
						}
					}
					%>
					</select>
					</td>
					</tr>

					<tr>
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="E" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Employee</STRONG></font></td>
					<td nowrap>
					<%
					qry="Select nvl(EmployeeID,' ')EmpID, nvl(EmployeeCode,' ')EmpCode, nvl(EmployeeName,' ')EmpName from EmployeeMaster";
					qry=qry+" where COMPANYCODE='"+mComp+"' and nvl(Deactive,'N')='N' Order By EmpName";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<select name=<%=mName4%> tabindex="0" id=<%=mName4%>>
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
					<td nowrap width=300px><input type="radio" onclick="FunLReqBy()" value="D" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Designation Based</STRONG></font></td>
					<td nowrap>
					<%

					qry="SELECT D.DESIGNATIONCODE DEGSCD, D.DESIGNATION DEGSNM From Designationmaster D where nvl(DEACTIVE,'*')='N'";
					qry=qry+" and D.DESIGNATIONCODE IN(Select E.DESIGNATIONCODE from EMPLOYEEMASTER E where nvl(E.DEACTIVE,'N')='N'";
			 		qry=qry+" and E.CompanyCode='"+mComp+"' GROUP By E.DESIGNATIONCODE HAVING Count(*)=1)";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<select name=<%=mName5%> tabindex="0" id=<%=mName5%>>
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
					<tr>
					<td nowrap width=300px><input type='checkbox' name='<%=mName12%>' id='<%=mName12%>' value="Y" onclick="FunTxtToFwd()"><font color=black face=arial size=2><STRONG>Text of <%=GlobalFunctions.toTtitleCase(QryWFCode)%> Recommendation</STRONG></font></td>
					<td nowrap>
					<select name=<%=mName13%> tabindex="0" id=<%=mName13%> disabled>
					<%
					if(request.getParameter("mName13")==null)
				   	{
						%>
						<OPTION Value=A selected>Approve</option>
						<OPTION Value=F>Forward</option>
						<OPTION Value=G>Grant</option>
						<OPTION Value=R>Recommend</option>
						<%
				  	}
					else
					{
						mTextToFwd=request.getParameter("mName13");
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
					<tr><td colspan=2 align=left nowrap>
					<%
					if(CTR<mReqApprLevel)
					{
						%>
						<input type='hidden' name='<%=mName6%>' id='<%=mName6%>' value='UnChecked'><!--<font color="#000099" face=arial size=2><STRONG>Change Approval Authority ?</font>-->
						<%
					}
					else
					{
						%>
						<input type='hidden' name='<%=mName6%>' id='<%=mName6%>' value='Checked'><!--<font color="#000099" face=arial size=2><STRONG>Change Approval Authority ?</font>-->
						<%
					}
					if(rs.isLast())
					{
						%>
						<a target=_new href="AddWorkFlowLevelForIndvReq.jsp?DeptCode=<%=mSelfDeptCode%>&amp;WFC=<%=QryWFCode%>&amp;WFT=<%=QryWFType%>&amp;WFL=<%=CTR%>&amp;RID=<%=QryRID%>&amp;TLD=<%=QryTotReqVal%>&amp;DOA=<%=QryDOA%>&amp;DOR=<%=QryDOR%>" title="Click to add more Approval Level"><marquee behavior=alternate scrolldelay=100 width=300px% style="cursor:hand"><font color="blue" face=arial size=2><STRONG>Next Approval Authority Required ?</STRONG></font></marquee></a>
						<%
					}
					else
					{
						%>
						<input type='checkbox' name='<%=mName10%>' id='<%=mName10%>' value='Required' checked onclick="FunReqNxt('<%=ctr%>')"><font color="#000099" face=arial size=2><STRONG>Change In Next Approval Authority Required ?</font>
						<%
					}
					%>
					</td></tr>
					</table></td></tr>
					<%
				}

//---------------End Of Approval Level for if(rsFrDept.next())----
//---------------End Of if(rsFrDept.next())----
			}
			%>
			<tr><td colspan="5" nowrap>
			<table align=left><tr>
			<td bgcolor=Green align=left nowrap>&nbsp; &nbsp; &nbsp;</td>
			<td align=center nowrap><Font color=black face="arial" size=2><B>Level Approved &nbsp; &nbsp;</B></font></td>
			<td bgcolor=yellow align=center nowrap>&nbsp; &nbsp; &nbsp;</td>
			<td align=right nowrap><Font color=black face="arial" size=2><B>Level To Be Approved Currently &nbsp; &nbsp;</B></font></td>
			<td bgcolor=lightyellow align=left nowrap>&nbsp; &nbsp; &nbsp;</td>
			<td align=right nowrap><Font color=black face="arial" size=2><B>Level To Be Approved Sequently</B></font></td>
			</tr></table>
			<tr><td align=left><HR>
			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <INPUT id=submit1 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Go Back To Re-Divert" name=submit1 value="Back" onclick="FunSubmit1()" onsubmit="FunSubmit1()"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <INPUT id=submit2 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Save" name=submit2 value="Save"></td></tr>
			<input type=hidden Name='TotalCount' ID='TotalCount' value='<%=ctr%>'>
			</table>
			</form>
			<%
			}
//-------------------------------------------------------
//-------------------------------------------------------
//---------------For Individual Employee------------------
//-------------------------------------------------------
//-------------------------------------------------------
			else if(QryChDvFor.equals("CurrEmp"))
			{
				RequestDispatcher rd=request.getRequestDispatcher("LTCRequestApprovalByChangedRouteEmpwise.jsp");
				rd.forward(request,response);
			}
//-------------------------------------------------------
//-------------------------------------------------------
//---------------For Indvidual Department----------------
//-------------------------------------------------------
//-------------------------------------------------------
			else if(QryChDvFor.equals("CurrDept"))
			{
				//response.sendRedirect("LTCRequestApprovalByChangedRouteDeptwise.jsp");
				RequestDispatcher rd=request.getRequestDispatcher("LTCRequestApprovalByChangedRouteDeptwise.jsp");
				rd.forward(request,response);
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
</body>
</html>