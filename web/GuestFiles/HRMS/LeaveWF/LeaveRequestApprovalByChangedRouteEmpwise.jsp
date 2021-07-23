<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rsFrIndv=null,rsFrEmp=null,rsFrDept=null;
ResultSet rs=null, rs1=null, rs2=null;

int ctr=0, CTR=0, mMaxLevel=0, mLeaveApprovalLevel=0, mTotOnWFL=0, mTotOnWFLevel=0;
int mWFSeq=0, mWFSeqc=0, QryWFLevel=0;
int mLevelEdit=0, QryLevelEdit=0, mMaxLevelEdit=0;
double mTotalLvDays=0;
String mApprBy="", mApprAuth="", mApprovalById="", mAprMemID="", mApprovalByName="";
String mDeptCode="", mDptCode="", QryDept="", mChangeCase="";
String mEmpName="", mEmpCode="", QryEmp="", mEmpID="";
String mDegsName="", mDegsCode="", QryDegs="", mFacType="I";
String qry="", mTextToFwd="", mTextToDsp="";
String mComp="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String QryReqDate="", QryRID="", QryFaculty="", QryWFCode="LEAVE", QryWFType="", QryLvDateFr="", QryLvDateTo="", QryLvPurp="";
String QryChDvFor="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName8="",mName10="", mName11="", mName13="", mName12="", mName14="";

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

if(request.getParameter("LEAVECODE")==null)
{
	QryWFType="";
}
else
{
	QryWFType=request.getParameter("LEAVECODE").toString().trim();	
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
//out.print(mDeptCode);
if(request.getParameter("LeaveDays")==null)
{
	mTotalLvDays=0;
}
else
{
	mTotalLvDays=Double.parseDouble(request.getParameter("LeaveDays").toString().trim());
}

if(QryChDvFor.equals("CurrCase"))
	mChangeCase="[for this request only]";
else if(QryChDvFor.equals("CurrEmp"))
	mChangeCase="[for this employee only]";
else if(QryChDvFor.equals("CurrDept"))
	mChangeCase="[for this department only]";

//out.print("EID "+QryFaculty+" WFCode "+QryWFCode+" WFType "+QryWFType+" From "+QryLvDateFr+" To "+QryLvDateTo+" Root for "+QryChDvFor);

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
<TITLE>#### <%=mHead%> [ Leave Request Approval ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<SCRIPT LANGUAGE="JavaScript"> 
function FunAddDropLvl()
{
	var TotCtr=document.frm.TotalCount.value;
	for(i=1;i<=TotCtr;i++)
	{
		mName1="ApprAuth_"+i;
		mName2="ApprByH_"+i;
		mName3="ApprByO_"+i;
		mName4="ApprByE_"+i;
		mName5="ApprByD_"+i;
		mName6="Checked_"+i;
		mName8="WFSeq_"+i;
		mName10="RequiredNext_"+(i-1);
		mName11="ActiveCurr_"+i;
		mName12="RequiredNext_"+i;
		mName12C="SetTextToFwd_"+i;
		mName14="TextToFwd_"+i;
		if(document.frm.AddDropLvl[0].checked==true)
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
			document.frm[mName12].checked=true;
			document.frm[mName12].disabled=false;
			document.frm[mName12C].checked=false;
			document.frm[mName12C].disabled=false;
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
			document.frm[mName12].checked=true;
			document.frm[mName12].disabled=false;
			document.frm[mName12C].checked=false;
			document.frm[mName12C].disabled=true;
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
		mName8="WFSeq_"+i;
		mName10="RequiredNext_"+i;
		mName11="ActiveCurr_"+i;
		mName12C="SetTextToFwd_"+i;
		mName14="TextToFwd_"+i;
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
			document.frm[mName12C].disabled=false;
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
			document.frm[mName12C].checked=false;
			document.frm[mName12C].disabled=true;
			document.frm[mName14].disabled=true;
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
		mName8="WFSeq_"+i;
		mName10="RequiredNext_"+(i-1);
		mName11="ActiveCurr_"+i;
		mName12="RequiredNext_"+i;
		mName12C="SetTextToFwd_"+i;
		mName14="TextToFwd_"+i;
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
		}
	}
}
function FunLReqBy()
{
	var TotCtr=document.frm.TotalCount.value;
	for(i=1;i<=TotCtr;i++)
	{
		mName1="ApprAuth_"+i;
		mName2="ApprByH_"+i;
		mName3="ApprByO_"+i;
		mName4="ApprByE_"+i;
		mName5="ApprByD_"+i;
		mName12C="SetTextToFwd_"+i;
		mName14="TextToFwd_"+i;

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
		mName12C="SetTextToFwd_"+i;
		mName14="TextToFwd_"+i;
		if(document.frm[mName12C].checked==true)
		{
			//alert('checked');
			document.frm[mName14].disabled=false;
		}
		else
		{
			//alert('unchecked');
			document.frm[mName14].disabled=true;
		}
	}
}
</SCRIPT>
<SCRIPT>
function FunSubmit1()
{
	document.frm.action="LeaveRequestInbox.jsp" ;
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

//-------------------------------------------------------
//-------------------------------------------------------
//---------------For Individual Department----------------
//-------------------------------------------------------
//-------------------------------------------------------
			if(QryChDvFor.equals("CurrEmp"))
			{
				%>
				<form name="frm1" method="POST">
				<input id="y" name="y" type=hidden>
				<table id=id1 width=100% ALIGN=CENTER bottommargin=0  topmargin=0>
				<!--Hiddens****-->
				<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
				<input type=hidden Name='WFCode' ID='WFCode' value='<%=QryWFCode%>'>
				<input type=hidden Name='DeptCode' ID='DeptCode' value='<%=mDeptCode%>'>
				<input type=hidden Name='LEAVECODE' ID='LEAVECODE' value='<%=QryWFType%>'>
				<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
				<input type=hidden Name='EID' ID='EID' value='<%=QryFaculty%>'>
				<input type=hidden Name='DATEFROM' ID='DATEFROM' value='<%=QryLvDateFr%>'>
				<input type=hidden Name='DATETO' ID='DATETO' value='<%=QryLvDateTo%>'>
				<input type=hidden Name='POL' ID='POL' value='<%=QryLvPurp%>'>
				<input type=hidden Name='Divert' ID='Divert' value='<%=QryChDvFor%>'>
				<input type=hidden Name='LeaveDays' ID='LeaveDays' value='<%=mTotalLvDays%>'>
				<tr><TD colspan=0 align=middle>
				<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Divert/Change Route For <%=QryWFCode%> [<%=QryWFType%>] Work Flow</B></font><br><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><%=mChangeCase%></font></TD>
				</font></td></tr>
				</TABLE>
				<table id="table-1" cellpadding=2 cellspacing=0 align=center rules=groups border=2>
				<tr><td><font color=black face=arial size=2><STRONG>Level</STRONG></font></td>
				<td nowrap>
				<%
				qry="Select Distinct nvl(WFLevel,0)WFL From WF#EMPWISEWORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInstitute+"' AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' AND nvl(DEACTIVE,'N')='N' ORDER BY WFL";
				rs1=db.getRowset(qry);
				//out.print(qry);
				%>
				<select name=LEVELEDIT tabindex="0" id=LEVELEDIT>
				<%
				if(request.getParameter("y")==null)
				{
					while(rs1.next())
					{
					 	mLevelEdit=rs1.getInt("WFL");
						if(QryLevelEdit==0)
						{
							QryLevelEdit=mLevelEdit;
							%>
							<option selected value=<%=mLevelEdit%>><%=mLevelEdit%></option>
							<%
						}
						else
						{
							%>
							<option value=<%=mLevelEdit%>><%=mLevelEdit%></option>
							<%
						}
						mMaxLevelEdit=mLevelEdit;
					}
					mLevelEdit=1000;
					%>
					<option value=<%=mLevelEdit%>>Add New</option>
					<%
				}
				else
				{
					while(rs1.next())
					{
			   			mLevelEdit=rs1.getInt("WFL");
					   	if(mLevelEdit==Integer.parseInt(request.getParameter("LEVELEDIT").toString().trim()))
						{
							%>
							<option selected value=<%=mLevelEdit%>><%=mLevelEdit%></option>
							<%
				  		}
						else
		      			{
							%>
							<option value=<%=mLevelEdit%>><%=mLevelEdit%></option>
							<%
						}
						mMaxLevelEdit=mLevelEdit;
					}
					mLevelEdit=1000;
					%>
					<option value=<%=mLevelEdit%>>Add New</option>
					<%
				}
				%>
				</select>
				</td>
				<td><INPUT id=Show style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit title="Show and set Criteria based Approval Authority" name=Show value="Show"></td>
				</tr></table>
				</form>
				<%
				if(request.getParameter("y")!=null)
				{
					if(request.getParameter("LEVELEDIT")==null)
						QryLevelEdit=0;
					else
						QryLevelEdit=Integer.parseInt(request.getParameter("LEVELEDIT").toString().trim());
				}
				//out.print("Level To Be Edit "+QryLevelEdit);
				qry="Select nvl(WEBKIOSK.HasPendingWF('"+mComp+"','"+mInstitute+"','"+QryWFCode+"','"+QryWFType+"','"+mDeptCode+"','QryFaculty','"+QryLevelEdit+"'),'Zero')HasPendWF from dual";
				rs=db.getRowset(qry);
				//out.print(qry);
				if((rs.next() && rs.getString("HasPendWF").equals("N")) && (QryLevelEdit!=1000))
				{
					%>
					<form name="frm" method="POST" ACTION="LeaveRequestApprovalByChangedRouteActionForIndvEmp.jsp">
					<input id="x" name="x" type=hidden>
					<input id="y" name="y" type=hidden>

					<table id="table-2" cellpadding=2 cellspacing=0 align=center rules=groups border=1>
					<!--Hiddens****-->
					<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
					<input type=hidden Name='WFCode' ID='WFCode' value='<%=QryWFCode%>'>
					<input type=hidden Name='DeptCode' ID='DeptCode' value='<%=mDeptCode%>'>
					<input type=hidden Name='LEAVECODE' ID='LEAVECODE' value='<%=QryWFType%>'>
					<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
					<input type=hidden Name='EID' ID='EID' value='<%=QryFaculty%>'>
					<input type=hidden Name='DATEFROM' ID='DATEFROM' value='<%=QryLvDateFr%>'>
					<input type=hidden Name='DATETO' ID='DATETO' value='<%=QryLvDateTo%>'>
					<input type=hidden Name='POL' ID='POL' value='<%=QryLvPurp%>'>
					<input type=hidden Name='Divert' ID='Divert' value='<%=QryChDvFor%>'>
					<input type=hidden Name='LeaveDays' ID='LeaveDays' value='<%=mTotalLvDays%>'>
					<%

					qry="select nvl(PURPOSEOFLEAVE,'No such reason')POL, nvl(PAID,0)PAID, nvl(WITHOUTPAY,0)LWP, to_char(ENTRYDATE,'DD-MM-YYYY')ReqDate from LeaveRequest where RequestID='"+QryRID+"'";
					rs=db.getRowset(qry);
					if(rs.next())
					{
						QryLvPurp=rs.getString("POL");
						QryReqDate=rs.getString("ReqDate");
					}
					qry="Select 'Y' from WF#EMPWISEWORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInstitute+"' AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and nvl(DEACTIVE,'N')='N'";
					rsFrDept=db.getRowset(qry);
					//out.print(qry);

					if(rsFrDept.next())
					{
//---------------Start Of Approval Authority for if(rsFrDept.next())----
						%>
						<input type="radio" value="KP" Name="AddDropLvl" ID="AddDropLvl" checked onclick="FunAddDropLvl()"><STRONG><font face=arial size=2 color=green>Keep Enabled</font></STRONG>
						<input type="radio" value="DC" Name="AddDropLvl" ID="AddDropLvl" onclick="FunAddDropLvl()"><STRONG><font face=arial size=2 color=RED>Discard This Level From Workflow</font></STRONG>
						<tr><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp; Divert/Change Route For <font color=Darkmaroon>Level <%=QryLevelEdit%></Font><font color=black> As : <img src="../../../Images/arrow.gif"></STRONG></td></tr>
						<%
						qry="select Distinct WFSEQUENCE WFSEQC, APPROVALBY APPRBY, APPROVALAUTHORITY APPRAUTH, CRITERIABASEDON CRTBSD, FROMVALUE FRVAL, TOVALUE TOVAL";
						qry=qry+" from WF#EMPWISEWORKFLOWAUTHORITY WHERE CompanyCode='"+mComp+"' and InstituteCode='"+mInstitute+"' AND WORKFLOWCODE='"+QryWFCode+"'";
						qry=qry+" AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and WFLEVEL='"+QryLevelEdit+"' ORDER BY FRVAL, TOVAL";
				    		rs=db.getRowset(qry);
						//out.print(qry);
						String QryCrtbsdEdit="";
						int FrCbtBsdVal=0, ToCbtBsdVal=0;
						while(rs.next())
						{
							mWFSeqc=rs.getInt("WFSEQC");
							QryCrtbsdEdit=rs.getString("CRTBSD");
							if(QryCrtbsdEdit.equals("D"))
							{
								FrCbtBsdVal=rs.getInt("FRVAL");
								ToCbtBsdVal=rs.getInt("TOVAL");
							}
							//out.print(FrCbtBsdVal+" "+ToCbtBsdVal);
							ctr++;
							mName1="ApprAuth_"+String.valueOf(ctr).trim();
							mName2="ApprByH_"+String.valueOf(ctr).trim();
							mName3="ApprByO_"+String.valueOf(ctr).trim();
							mName4="ApprByE_"+String.valueOf(ctr).trim();
							mName5="ApprByD_"+String.valueOf(ctr).trim();
							mName6="Checked_"+String.valueOf(ctr).trim();
							mName8="WFSeq_"+String.valueOf(ctr).trim();
							mName10="RequiredNext_"+String.valueOf(ctr).trim();
							mName11="ActiveCurr_"+String.valueOf(ctr).trim();
							mName12="SetTextToFwd_"+String.valueOf(ctr).trim();
							mName13="ActiveCurrCell_"+String.valueOf(ctr).trim();
							mName14="TextToFwd_"+String.valueOf(ctr).trim();
							%>
							<input type=Hidden name='QryWFL' id='QryWFL' value="<%=QryLevelEdit%>">
							<input type=Hidden name='<%=mName8%>' id='<%=mName8%>' value="<%=mWFSeqc%>">
							<tr><td nowrap>
							<font color=Navy face=arial size=2><STRONG>&nbsp; Criteria <%=FrCbtBsdVal%> to <%=ToCbtBsdVal%> : <img src="../../../Images/arrow.gif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </STRONG>
							<input type="radio" value="E" Name="<%=mName11%>" ID="<%=mName11%>" checked onclick="FunActCurr()"><STRONG><font face=arial size=2 color=green>Keep Enabled</font></STRONG>
							<input type="radio" value="D" Name="<%=mName11%>" ID="<%=mName11%>" onclick="FunActCurr()"><STRONG><font face=arial size=2 color=RED>Discard</font></STRONG>
							</td>
							</tr>

							<tr>
							<td><table border=2 bordercolor="#de6400" cellpadding=0 cellspacing=0 rules="none">
							<tr>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="H" Name="<%=mName1%>" ID="<%=mName1%>" checked><font color=black face=arial size=2><STRONG>HOD [Self]</STRONG></font></td>
							<%
							qry="Select nvl(EmployeeName,' ')EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (Select EmployeeID From HODLIST WHERE DEPARTMENTCODE='"+mDeptCode+"') and nvl(DEACTIVE,'N')='N'";
							rs1=db.getRowset(qry);
							//out.print(qry);
							rs1.next();
							%>
							<td nowrap><input type="text" value="<%=rs1.getString("EmpName")%> [<%=mDeptCode%>]" Name="<%=mName2%>" ID="<%=mName2%>" size=38 READONLY></td>
							</tr>

							<tr>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="O" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>HOD [Others]</STRONG></font></td>
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
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="E" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Employee</STRONG></font></td>
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
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="D" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Designation Based</STRONG></font></td>
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
							<td nowrap width=300px><input type='checkbox' name='<%=mName12%>' id='<%=mName12%>' value="Y" onclick="FunTxtToFwd()"><font color=black face=arial size=2><STRONG>Text of Leave Recommendation</STRONG></font></td>
							<td nowrap>
							<select name=<%=mName14%> tabindex="0" id=<%=mName14%> disabled>
							<%
							if(request.getParameter("mName14")==null)
						   	{
								mTextToFwd="A";
								%>
								<OPTION Value=A selected>Approve</option>
								<OPTION Value=F>Forward</option>
								<OPTION Value=G>Grant</option>
								<OPTION Value=R>Recommend</option>
								<%
						  	}
							else
							{
								mTextToFwd=request.getParameter("mName14");
								if(mTextToDsp.equals(""))
									mTextToDsp=mTextToFwd;
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
							<input type='hidden' name='<%=mName6%>' id='<%=mName6%>' value='Checked'>
							<%
							if(rs.isLast())
							{
								%>
								<a target=_new href="AddCrBasedWorkFlowLevelForIndvEmp.jsp?DeptCode=<%=mDeptCode%>&amp;WFC=<%=QryWFCode%>&amp;WFT=<%=QryWFType%>&amp;WFL=<%=QryLevelEdit%>&amp;EID=<%=QryFaculty%>" title="Click to add more Approval Level"><marquee behavior=alternate scrolldelay=100 width=100% style="cursor:hand"><font color="blue" face=arial size=2><STRONG>Next Criteria-Based Approval Authority Required ?</STRONG></font></marquee></a>
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
							</table></td>
							</tr>
							<%
						}

//---------------End Of Approval Level for if(rsFrDept.next())----
					}
					%>
					<tr><td align=center><HR>
					<INPUT id=submit1 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Go Back To Re-Divert" name=submit1 value="Back" onclick="FunSubmit1()" onsubmit="FunSubmit1()"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <INPUT id=submit2 style="Background-Color: LightYellow; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 title="Save" name=submit2 value="Save"></td></tr>
					<input type=hidden Name='TotalCount' ID='TotalCount' value='<%=ctr%>'>
					</table>
					<%
				}
				else if(QryLevelEdit==1000)
				{
					QryLevelEdit=mMaxLevelEdit+1;
					%>
					<BR><BR><CENTER><font face=arial color=darkbrown size=3>Do you want to add new level?</font></CENTER>
					<BR><BR><CENTER><a href="AddWorkFlowLevelForIndvEmp.jsp?DeptCode=<%=mDeptCode%>&amp;WFC=<%=QryWFCode%>&amp;WFT=<%=QryWFType%>&amp;WFL=<%=QryLevelEdit%>&amp;EID=<%=QryFaculty%>" title="Click To Add New Approval Level"><marquee behavior=alternate scrolldelay=100 width=50% style="cursor:hand"><font color="blue" face=arial size=2><STRONG>Click To Proceed New Level (Level <%=QryLevelEdit%>)...</STRONG></font></marquee></a></CENTER>
					<%
				}
				else
				{
					%><CENTER><%
					out.print("<img src='../../../Images/Error1.gif'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>On Current Level, Root Diversion of This Department is not Permissible! Some Other Request(s) are Pending to Approve/Cancel...</font> <br>");
					%></CENTER><%
				}
			}
	//-----------------------------
	//---Enable Security Page Level  
	//-----------------------------
		}
		else
		{
			%>
			<br>
			<font color=RED>
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='RED'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
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