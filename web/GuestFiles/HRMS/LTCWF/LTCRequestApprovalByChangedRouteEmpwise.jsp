<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rsFrIndv=null,rsFrEmp=null,rsFrDept=null;
ResultSet rs=null, rs1=null, rs2=null;

int ctr=0, mWFSeqc=0;
int mLevelEdit=0, QryLevelEdit=0, mMaxLevelEdit=0;
double QryTotReqVal=0;
String mDeptCode="", mDptCode="", QryDept="", mChangeCase="";
String mEmpName="", mEmpCode="", QryEmp="", mEmpID="";
String mDegsName="", mDegsCode="", QryDegs="", mFacType="I";
String qry="", mTextToFwd="", mTextToDsp="";
String mComp="", mInst="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String QryRID="", QryFaculty="", QryWFCode="", QryWFType="", QryDOA="", QryDOR="", QryLvlAuth="";
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
	QryWFCode="";
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
//out.print("cdafsfdsaf "+mDeptCode);
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

//out.print("EID "+QryFaculty+" WFCode "+QryWFCode+" WFType "+QryWFType+" Adv Date - "+QryDOA+" Req Date - "+QryDOR+" Root for "+QryChDvFor);

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
<TITLE>#### <%=mHead%> [ <%=QryWFCode%> Request Approval ] </TITLE>

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
		qry="Select WEBKIOSK.ShowLink('148','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if(rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	

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
				<input type=hidden Name='WFCode' ID='WFCode' value='<%=QryWFCode%>'>
				<input type=hidden Name='DeptCode' ID='DeptCode' value='<%=mDeptCode%>'>
				<input type=hidden Name='WFType' ID='WFType' value='<%=QryWFType%>'>
				<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
				<input type=hidden Name='EID' ID='EID' value='<%=QryFaculty%>'>
				<input type=hidden Name='DOA' ID='DOA' value='<%=QryDOA%>'>
				<input type=hidden Name='DOR' ID='DOR' value='<%=QryDOR%>'>
				<input type=hidden Name='Divert' ID='Divert' value='<%=QryChDvFor%>'>
				<input type=hidden Name='REQVAL' ID='REQVAL' value='<%=QryTotReqVal%>'>
				<tr><TD colspan=0 align=middle>
				<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Divert/Change Route For <%=QryWFCode%> [<%=QryWFType%>] Work Flow</B></font><br><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><%=mChangeCase%></font></TD>
				</font></td></tr>
				</TABLE>
				<table id="table-1" cellpadding=2 cellspacing=0 align=center rules=groups border=2>
				<tr><td><font color=black face=arial size=2><STRONG>Level</STRONG></font></td>
				<td nowrap>
				<%
				qry="Select Distinct nvl(WFLevel,0)WFL From WF#EMPWISEWORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' AND nvl(DEACTIVE,'N')='N' ORDER BY WFL";
				rs1=db.getRowset(qry);
				//out.print(qry);
				%>
				<select name=LEVELEDIT tabindex="0" id=LEVELEDIT>
				<%
				if(request.getParameter("y")==null)
				{
					%>
					<option selected value=0>ALL</option>
					<%
					while(rs1.next())
					{
					 	mLevelEdit=rs1.getInt("WFL");
						if(mLevelEdit>0)
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
					%>
					<option value=0>ALL</option>
					<%
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
				qry="Select nvl(WEBKIOSK.HasPendingWF('"+mComp+"','"+mInst+"','"+QryWFCode+"','"+QryWFType+"','"+mDeptCode+"','QryFaculty','"+QryLevelEdit+"'),'Zero')HasPendWF from dual";
				rs=db.getRowset(qry);
				//out.print(qry);
				if((rs.next() && rs.getString("HasPendWF").equals("N")) && (QryLevelEdit!=1000))
				{
					%>
					<form name="frm" method="POST" ACTION="LTCRequestApprovalByChangedRouteActionForIndvEmp.jsp">
					<input id="x" name="x" type=hidden>
					<input id="y" name="y" type=hidden>

					<table id="table-2" cellpadding=2 cellspacing=0 align=center rules=groups border=1>
					<!--Hiddens****-->
					<input type=hidden Name='WFCode' ID='WFCode' value='<%=QryWFCode%>'>
					<input type=hidden Name='DeptCode' ID='DeptCode' value='<%=mDeptCode%>'>
					<input type=hidden Name='WFType' ID='WFType' value='<%=QryWFType%>'>
					<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
					<input type=hidden Name='EID' ID='EID' value='<%=QryFaculty%>'>
					<input type=hidden Name='DOA' ID='DOA' value='<%=QryDOA%>'>
					<input type=hidden Name='DOR' ID='DOR' value='<%=QryDOR%>'>
					<input type=hidden Name='Divert' ID='Divert' value='<%=QryChDvFor%>'>
					<input type=hidden Name='REQVAL' ID='REQVAL' value='<%=QryTotReqVal%>'>
					<%
					qry="Select 'Y' from WF#EMPWISEWORKFLOWAUTHORITY where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and nvl(DEACTIVE,'N')='N'";
					rsFrDept=db.getRowset(qry);
					//out.print(qry);

					if(rsFrDept.next())
					{
//---------------Start Of Approval Authority for if(rsFrDept.next())----
						if(QryLevelEdit==0)
						{
							%>
							<tr><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp; Divert/Change Route For <font color=Darkmaroon>All Level</Font><font color=black> As : <img src="../../../Images/arrow.gif"></STRONG></td></tr>
							<%
						}
						else
						{
							%>
							<tr><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>&nbsp; Divert/Change Route For <font color=Darkmaroon>Level <%=QryLevelEdit%></Font><font color=black> As : <img src="../../../Images/arrow.gif"></STRONG></td></tr>
							<%
						}
						qry="select Distinct nvl(WFLEVEL,0)WFLEVEL, WFSEQUENCE WFSEQC, APPROVALBY APPRBY, APPROVALAUTHORITY APPRAUTH from WF#EMPWISEWORKFLOWAUTHORITY";
						qry=qry+" WHERE CompanyCode='"+mComp+"' and InstituteCode='"+mInst+"' AND WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"'";
						qry=qry+" AND EMPLOYEEID='"+QryFaculty+"' AND FACULTYTYPE='"+mFacType+"' and WFLEVEL=DECODE('"+QryLevelEdit+"',0,WFLEVEL,'"+QryLevelEdit+"') ORDER BY WFLEVEL";
				    		rs=db.getRowset(qry);
						//out.print(qry);
						while(rs.next())
						{
							QryLvlAuth=rs.getString("APPRBY");
							mWFSeqc=rs.getInt("WFSEQC");
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
							<font color=Navy face=arial size=2><STRONG>&nbsp; Level <%=rs.getInt(1)%> : <img src="../../../Images/arrow.gif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </STRONG>
							<input type="radio" value="E" Name="<%=mName11%>" ID="<%=mName11%>" checked onclick="FunActCurr()"><STRONG><font face=arial size=2 color=green>Keep This Level Enabled</font></STRONG>
							<input type="radio" value="D" Name="<%=mName11%>" ID="<%=mName11%>" onclick="FunActCurr()"><STRONG><font face=arial size=2 color=red>Discard This Level From Work Flow</font></STRONG>
							</td></tr>

							<tr>
							<td><table border=2 bordercolor="#de6400" cellpadding=0 cellspacing=0 rules="none">
							<tr>
							<%
							if(QryLvlAuth.equals("H"))
							{
							%>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="H" Name="<%=mName1%>" ID="<%=mName1%>" checked><font color=black face=arial size=2><STRONG>HOD [Self]</STRONG></font></td>
							<%
							}
							else
							{
							%>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="H" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>HOD [Self]</STRONG></font></td>
							<%
							}
							qry="Select nvl(EmployeeName,' ')EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (Select EmployeeID From HODLIST WHERE DEPARTMENTCODE='"+mDeptCode+"') and nvl(DEACTIVE,'N')='N'";
							rs1=db.getRowset(qry);
							//out.print(qry);
							rs1.next();
							%>
							<td nowrap><input type="text" value="<%=rs1.getString("EmpName")%> [<%=mDeptCode%>]" Name="<%=mName2%>" ID="<%=mName2%>" size=38 READONLY></td>
							</tr>

							<tr>
							<%
							if(QryLvlAuth.equals("O"))
							{
							%>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="O" Name="<%=mName1%>" ID="<%=mName1%>" Checked><font color=black face=arial size=2><STRONG>HOD [Others]</STRONG></font></td>
							<%
							}
							else
							{
							%>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="O" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>HOD [Others]</STRONG></font></td>
							<%
							}
							%>
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
							<%
							if(QryLvlAuth.equals("E"))
							{
							%>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="E" Name="<%=mName1%>" ID="<%=mName1%>" Checked><font color=black face=arial size=2><STRONG>Employee</STRONG></font></td>
							<%
							}
							else
							{
							%>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="E" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Employee</STRONG></font></td>
							<%
							}
							%>
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
							<%
							if(QryLvlAuth.equals("D"))
							{
							%>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="D" Name="<%=mName1%>" ID="<%=mName1%>" Checked><font color=black face=arial size=2><STRONG>Designation Based</STRONG></font></td>
							<%
							}
							else
							{
							%>
							<td nowrap><input type="radio" onclick="FunLReqBy()" value="D" Name="<%=mName1%>" ID="<%=mName1%>"><font color=black face=arial size=2><STRONG>Designation Based</STRONG></font></td>
							<%
							}
							%>
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
							<td nowrap width=300px><input type='checkbox' name='<%=mName12%>' id='<%=mName12%>' value="Y" onclick="FunTxtToFwd()"><font color=black face=arial size=2><STRONG>Text of <%=QryWFCode%> Recommendation</STRONG></font></td>
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