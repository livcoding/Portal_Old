<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;

GlobalFunctions gb =new GlobalFunctions();
int CTR=0, mMaxLevel=0, mAprLevel=0;
String qry="",qry1="";
String mComp="", mInst="", mRightsID="172";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String mDeptCode="", mWFC="", mWFCode="", mWFDesc="", mWFType="";
String QryWFCode="", QryWFType="";
String mApprovalByName="", mApprovalById="";
String AprByDeptOrEmp="", AprAuthFor="", CritBasedOn="";
int CritFrom=0, CritTo=0;
int mTotOnLevel=0;
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

if(request.getParameter("DEPTCODE")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=request.getParameter("DEPTCODE").toString().trim();
}

if(request.getParameter("WFC")==null)
{
	mWFC="";
}
else
{
	mWFC=request.getParameter("WFC").toString().trim();
}
//out.print(mWFC+" - "+mDeptCode);
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Work Flow Approval Level ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
 for (var i = 0; i < document.frm1.elements.length; i++) 
 {
  var e = document.frm1.elements[i]; 
  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
  { 
   e.checked = document.frm1.allbox.checked;
  }
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
<script>
var oPopup = window.createPopup();
function richDropDown()
{
    oPopup.document.body.innerHTML = oContextHTML.innerHTML; 
    oPopup.show(0, 28, 305, 100, dropdowno);
}
function richToolTip()
{
    var lefter = event.offsetY+0;
    var topper = event.offsetX+15;
    oPopup.document.body.innerHTML = oToolTip.innerHTML; 
    oPopup.show(topper, lefter, 170, 120, ttip);
}
function richDialog()
{
    oPopup.document.body.innerHTML = oDialog.innerHTML; 
    oPopup.show(100, 50, 400, 300);
}
function richContext()
{
    var lefter2 = event.offsetY+0;
    var topper2 = event.offsetX+15;
    oPopup.document.body.innerHTML = oContext2.innerHTML; 
    oPopup.show(topper2, lefter2, 210, 88, contextobox);
}
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
		qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	
	  //----------------------
	%>
	<form name="frm" method="get">
	<input id="x" name="x" type=hidden>
	<input id="WFC" name="WFC" type=hidden value=<%=mWFC%>>
	<input id='DEPTCODE' type=hidden Name='DEPTCODE' value='<%=mDeptCode%>'>

	<table id=id1 width="125%" ALIGN=CENTER  topmargin=0 cellspacing=0 cellpadding=0 rightmargin=0 leftmargin=0 bottommargin=0 >

<!-------------Page Heading and Marquee Message----------------------->
<%
try
{
	String mPageHeader="Work Flow Approval Level", mMarqMsg="", CurrDate="";
	qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		CurrDate=rs.getString("CurrDate");
	}
	qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightsID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mMarqMsg=rs.getString("MarqMsg");
		%>
		<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
		<%
	}
	qry="Select nvl(B.PAGEHEADER,'"+mPageHeader+"')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
	rs=db.getRowset(qry);
	//out.print(qry);
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

	<table id="table-1" cellpadding=2 cellspacing=0 align=center rules=groups border=2>
<!--*********Work Flow Code**********-->
	<td nowrap title="Work Flow Code"><Font color=black face=arial size=2><STRONG>Work Flow Code</STRONG></font>
	<%
	if(!mWFC.equals(""))
	{
		qry="select distinct nvl(A.WORKFLOWCODE,' ')WFCode, nvl(B.WORKFLOWDESC,' ')WFDesc from WF#WORKFLOWAUTHORITY A, WF#WORKFLOWMASTER B where A.WORKFLOWCODE='"+mWFC+"' AND A.WORKFLOWCODE=B.WORKFLOWCODE";
		qry=qry +" AND A.COMPANYCODE=B.COMPANYCODE AND A.INSTITUTECODE=B.INSTITUTECODE AND nvl(A.DEACTIVE,'N')='N' order by WFDesc";
	}
	else
	{
		qry="select distinct nvl(A.WORKFLOWCODE,' ')WFCode, nvl(B.WORKFLOWDESC,' ')WFDesc from WF#WORKFLOWAUTHORITY A, WF#WORKFLOWMASTER B where A.WORKFLOWCODE=B.WORKFLOWCODE";
		qry=qry +" AND A.COMPANYCODE=B.COMPANYCODE AND A.INSTITUTECODE=B.INSTITUTECODE AND nvl(A.DEACTIVE,'N')='N' order by WFDesc";
	}
	//out.print(qry);
	rs=db.getRowset(qry);
	%>
	<select name="WFCode" tabindex="0" id="WFCode">
	<%
	if(request.getParameter("x")==null)
	{	
		while(rs.next())
		{
		 	mWFCode=rs.getString("WFCode");
		 	mWFDesc=rs.getString("WFDesc");
			if(QryWFCode.equals(""))
				QryWFCode=mWFCode;
			%>
			<option value=<%=mWFCode%>><%=mWFDesc%></option>
			<%
		}
	}
	else
	{
		while(rs.next())
		{
		 	mWFCode=rs.getString("WFCode");
		 	mWFDesc=rs.getString("WFDesc");
		   	if(mWFCode.equals(request.getParameter("WFCode").toString().trim()))
			{
				%>
	    			<option selected value=<%=mWFCode%>><%=mWFDesc%></option>
				<%
		  	}
			else
      		{		
	   		   %>
	    			<option  value=<%=mWFCode%>><%=mWFDesc%></option>
	   		   <%
			}	
		}
	}
	%>
	</select>
	</td>
<!--*********Work Flow Type**********-->
	<td nowrap title="Work Flow Type / Sub Type"><Font color=black face=arial size=2><STRONG>&nbsp; &nbsp; &nbsp; Work Flow Type</STRONG></font>
	<%
	if(!mWFC.equals(""))
	{
		qry="select distinct nvl(A.WORKFLOWTYPE,' ')WFType from WF#WORKFLOWAUTHORITY A Where A.WORKFLOWCODE='"+mWFC+"' AND nvl(A.DEACTIVE,'N')='N' order by WFType";
	}
	else
	{
		qry="select distinct nvl(A.WORKFLOWTYPE,' ')WFType from WF#WORKFLOWAUTHORITY A Where nvl(A.DEACTIVE,'N')='N' order by WFType";
	}
	//out.print(qry);
	rs=db.getRowset(qry);
	%>
	<select name="WFType" tabindex="0" id="WFType">
	<%
	if(request.getParameter("x")==null)
	{	
		while(rs.next())
		{
		 	mWFType=rs.getString("WFType");
			if(QryWFType.equals(""))
				QryWFType=mWFType;
			%>
			<option value=<%=mWFType%>><%=mWFType%></option>
			<%
		}
	}
	else
	{
		while(rs.next())
		{
		 	mWFType=rs.getString("WFType");
		   	if(mWFType.equals(request.getParameter("WFType").toString().trim()))
			{
				%>
	    			<option selected value=<%=mWFType%>><%=mWFType%></option>
				<%
		  	}
			else
      		{		
	   		   %>
	    			<option  value=<%=mWFType%>><%=mWFType%></option>
	   		   <%
			}	
		}
	}
	%>
	</select>

	<INPUT id=submit style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 115px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Show / Refresh" name=submit title="Show Level"></table></td></tr>
	</form>
	<%
	if(request.getParameter("x")!=null)
	{
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
	} //closing of outer if
//--------------------
	qry="select Distinct nvl(WFLEVEL,0)MaxLevel from WF#WORKFLOWAUTHORITY where WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"'";
    	rs=db.getRowset(qry);
	//out.print(qry);
	while(rs.next())
	{
		mMaxLevel++;
	}
//--------------------
//------------------------
	try
	{
	qry="select Distinct nvl(WFLEVEL,0)MaxLevel from WF#WORKFLOWAUTHORITY where WORKFLOWCODE='"+QryWFCode+"' AND WORKFLOWTYPE='"+QryWFType+"' order by MaxLevel Desc";
    	rs=db.getRowset(qry);
	//out.print(qry);
	%>
	<table align=center Border=0 bottommargin=0 topmargin=0>
	<%
	while(rs.next())
	{
	   CTR++;
	   mAprLevel=rs.getInt("MaxLevel");
	   %>
	   <tr><td Nowrap cellspacing=0 cellpadding=0><table cellspacing=0 cellpadding=0 bordercolor=orange border=4>
	   <tr bgcolor=lightyellow><td nowrap><FONT SIZE=2 face=arial COLOR=blue><B> Level <%=mAprLevel%></b></Font><img src="../../Images/arrow_cool.gif"></td></tr></table></td>
	   <%
		qry1="SELECT decode(CRITERIABASEDON,'D','Days','A','Amount',' ')CBO, nvl(FROMVALUE,0)FV, nvl(TOVALUE,0)TV, nvl(APPROVALBY,' ')APRBY, nvl(APPROVALAUTHORITY,' ') APRAUTH FROM WF#WORKFLOWAUTHORITY";
		qry1=qry1+" WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND WORKFLOWCODE='"+QryWFCode+"' and WORKFLOWTYPE='"+QryWFType+"'";
		qry1=qry1+" AND DEPARTMENTCODE='"+mDeptCode+"' and WFLEVEL='"+mAprLevel+"' and nvl(Deactive,'N')='N' order by FV";
		rs1=db.getRowset(qry1);
		//out.print(qry1);
		while(rs1.next())
		{
			AprByDeptOrEmp=rs1.getString("APRAUTH");
			AprAuthFor=rs1.getString("APRBY");
			CritBasedOn=rs1.getString("CBO");
			CritFrom=rs1.getInt("FV");
			CritTo=rs1.getInt("TV");

			if(AprAuthFor.equals("E"))
			{
				qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID='"+AprByDeptOrEmp+"'";
			}
			else if(AprAuthFor.equals("H"))
			{
				qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (SELECT EmployeeID from HODLIST where DepartmentCode='"+AprByDeptOrEmp+"' AND nvl(DEACTIVE,'N')='N')";
			}
			else if(AprAuthFor.equals("O"))
			{
				qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeID IN (SELECT EmployeeID from HODLIST where DepartmentCode='"+AprByDeptOrEmp+"' AND nvl(DEACTIVE,'N')='N')";
			}
			else if(AprAuthFor.equals("D"))
			{
				qry="Select EmployeeID EmpID, EmployeeName EmpName from EmployeeMaster where CompanyCode='"+mComp+"' and DESIGNATIONCODE='"+AprByDeptOrEmp+"' AND NVL(DEACTIVE,'N')='N'";
			}
			rs2=db.getRowset(qry);
			//out.print(qry);
			if(rs2.next())
			{
				mApprovalById=rs2.getString("EmpId");
				mApprovalByName=rs2.getString("EmpName");
			}
		//out.print(AprAuthFor+AprByDeptOrEmp+CritBasedOn+CritFrom+CritTo);
		%>
		<td align=left nowrap><table width=100% Border=4 align=left cellspacing=0 cellpadding=0 bordercolor="#de6400"><tr bgcolor=LightYellow><td align=left nowrap><font color="darkpink" style="FONT-SIZE: medium; FONT-FAMILY: arial"><b><FONT SIZE=2 COLOR=DarkPink><%=mApprovalByName%> (<%=CritFrom%> to <%=CritTo%> <%=CritBasedOn%>)</FONT></b></font></td><tr></table></td>
		<%
		}
	   %>
	   </tr>
	   <%
	   if(CTR<mMaxLevel)
	   {
	   %>
	   <tr><td align=CENTER colspan=<%=mTotOnLevel%>><img src="../../Images/2aniarr1.gif"></td></tr>
	   <%
	   }
	}
	%>
	</table>
	<%
	}
	catch(Exception e)
	{
	}
//------------------------
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
}
else
{
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>  
   <%
}
//-----------------------------
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
}
%>
</body>
</html>