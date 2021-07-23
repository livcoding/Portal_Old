<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%
try
{
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qryd="";
String qryi="";
String qrys="";
String qrys1="";
ResultSet rss1=null;
ResultSet rss=null;
ResultSet rsd=null;
ResultSet rs=null;
String mDate="";
String mHead="",mMemberCode="";
String mDMemberID="";
String mDMemberCode="";
String mDMemberType="";
String mInst="";
String mSysdate="";
String mMemberID="",mCompanyCode="",mDepartmentCode="";
String mMemberType="",mMemberName="";
String mRepDate="",mRelvDate="",mType="",mRemarks="";
int mNoticeDays=0;
int ctr=0;
String mNOC=""; 
String mPrint="";
String mPrintS="",mEID="",mReportDt="",mRelivingDt="";	
String mEname="",mRID="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
{
	mHead=session.getAttribute("PageHeading").toString().trim();
}
else
{
	mHead="JIIT ";
}
if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("DepartmentCode")==null)
{
	mDepartmentCode="";
}
else
{
	mDepartmentCode=session.getAttribute("DepartmentCode").toString().trim();
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
if(request.getParameter("EID")==null)
{
	mEID="";
}
else
{
	mEID=request.getParameter("EID").toString().trim();	
}

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Request for NOC ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
 
<script language=javascript>
 
function RefreshContents()
{ 	
	document.frm.x.value='ddd';
    	document.frm.submit();
}
//-->
</script>
<SCRIPT LANGUAGE="JavaScript">
 
function isNumber(e)
{
	var unicode=e.charCode? e.charCode : e.keyCode

	if (unicode!=8)
	{ //if the key isn't the backspace key (which we should allow)
		if ((unicode<48||unicode>57) && unicode!=46) //if not a number
		return false //disable key press
	}
}
function Validate()
{
if(document.frm.Remarks.value=="" || document.frm.Remarks.value==" " )
	{
	alert('Please Enter Some Remarks!');
	document.frm.Remarks.value="";
	frm.Remarks.focus();
	return false;
	}
if(document.frm.NoticeDays.value=="")
	{
	alert('Please Enter Some Numeric Value!');
	document.frm.NoticeDays.value="";
	frm.NoticeDays.focus();
	return false;
	}
}
</script>
<script>
	if(window.history.forward(1)!=null)
	window.history.forward(1);	
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onSubmit="return ValidateForm();" onload="Disab();">
<%
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
		qry="Select WEBKIOSK.ShowLink('162','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	

		qryd="select to_char(sysdate,'dd-mm-yyyy') from dual";
		rsd=db.getRowset(qryd);
		rsd.next();
		mSysdate=rsd.getString(1);
%>
<table align=center width="100%" bottommargin=0 topmargin=0>
	<tr>
	<TD colspan=0 align=middle width=34%><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Edit Request for NOC Detail</FONT></u></b></td>
	</tr>
	</table>

<%
		qry="SELECT nvl(A.EMPLOYEEID,' ')EMPLOYEEID,nvl(A.REQUESTID,' ')REQUESTID,B.EmployeeName||' ['||B.EmployeeCode||']' EMPLOYEENAME ,nvl(A.TYPE,' ')TYPE, nvl(to_char(A.REPORTINGDATE,'dd-mm-yyyy'),' ')REPORTINGDATE,nvl(to_char(A.DATEOFRELIEVING,'dd-mm-yyyy'),' ')DATEOFRELIEVING,nvl(A.REMARKS,' ')REMARKS,decode(NOTICEDAYS,'',' ',NOTICEDAYS)NOTICEDAYS FROM EMPLOYEELEAVING A,EMPLOYEEMASTER B where A.EMPLOYEEID='"+mEID+"' AND A.EMPLOYEEID=B.EMPLOYEEID";
		//out.print(qry);
		rs=db.getRowset(qry);
		if(rs.next())
			{
				mEname=rs.getString("EMPLOYEENAME");
				mRID=rs.getString("REQUESTID");
				mReportDt=rs.getString("REPORTINGDATE");
				mRelivingDt=rs.getString("DATEOFRELIEVING");
				mNoticeDays=rs.getInt("NOTICEDAYS");
				mRemarks=rs.getString("REMARKS");
				mType=rs.getString("TYPE");
			}
	%>
	<form name="frm"  method="post" action="EditRequestNOCAction.jsp"> 
	<input id="x" name="x" type=hidden>
		<input id="RID" name="RID" type=hidden value="<%=mRID%>">
	<table>
	<tr><td>
	<font color=black size=2 face=arial>
	<strong>Employee Name :</strong></font>
	<FONT COLOR=GREEN SIZE=2 FACE=ARIAL><b><%=mEname%></b></font>
	</td></tr>
	</table>
	
	<table align=center bottommargin=0 cellspacing=1 cellpadding=2 topmargin=0 border=1  width="100%">
	<tr>
	<td><font color=black size=2 face=arial><b>Reporting Date<b></font>
	<input readonly type=text name="ReportDate" id="ReportDate" size=10 value='<%=mReportDt%>' maxlength=10 >&nbsp;<a href="javascript:NewCal('ReportDate','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
	</td>
	<td><font color=black size=2 face=arial><b>Releving Date<b></font>

	<input readonly type=text name="RelevingDate" id="RelevingDate" size=10 value='<%=mRelivingDt%>' maxlength=10 >&nbsp;<a href="javascript:NewCal('RelevingDate','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>

	</td>
	<td><font color=black size=2 face=arial><b>Type<b></font>
		<select name="NType" id="NType">
	<%
	if(mType.equals("R"))
		{
			%>
			<option value="R" Selected>Resign</option>
			<option value="T">Transfer</option>
			<%
		}
	else
		{
			%>
			<option value="R" >Resign</option>
			<option value="T" Selected>Transfer</option>
			<%
		}
    	%>
	</select>
	</td></tr>
	<tr>
	<td><font color=black size=2 face=arial><b>Notice Days<b></font>&nbsp; &nbsp; &nbsp;
	<input type=text name="NoticeDays" id="NoticeDays" size=5 maxlength=3 value="<%=mNoticeDays%>" onkeypress="return isNumber(event)">
	</td>
	<td colspan=3><font color=black size=2 face=arial><b>Remarks<b></font>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
	<input type=text name="Remarks" id="Remarks" value="<%=mRemarks%>" size=50 >
	</td>
	</tr>
		<input type=hidden ID="EID" NAME="EID" value=<%=mEID%>>
	<tr>

	<td colspan=4 align=center>
	<input type=submit value="Save" onClick="return Validate();">
	</td>
	</tr>
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
	<h3>	<br><img src='../../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>  
   <%
}
//-----------------------------
}
else
{
	out.print("<br><img src='../../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
//out.print(e);
}
%>
</form>
</body>
</html>
