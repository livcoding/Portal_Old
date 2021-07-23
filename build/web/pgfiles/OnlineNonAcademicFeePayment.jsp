<%-- 
    Document   : OnlineNonAcademicFeePayment
    Created on : 29 Jun, 2020, 12:12:45 PM
    Author     : anoop.tiwari
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,pgwebkiosk.*,java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map,java.text.DecimalFormat" %>

<%

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="";

%>
<HTML>

<head>
<style type="text/css">
body{

font-size:12px;
}
table{
font-size:12px;
}

.datafont
{
color:red;
color:#590000;
font-weight:bold;
border:#fce9c5;
background:transparent


}
</style>
 <TITLE>#### <%=mHead%> [ View Academic Fee detail  ] </TITLE>
 <script type="text/javascript" src="js/jquery-1.4.2.js"></script>
    <script language="JavaScript" type ="text/javascript">
	<!--
	  if (top != self) top.document.title = document.title;
	-->

</script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>





</head>
<body style="width:96%"; aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<center>
<%
OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs3=null;
String currencyCodeofAccounting="",errorStr="";
String mWebEmail="";
int mSNO=0;
int mData=0;
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mmMemberName="";
String mCompanyCode="";
String mAcademicYearCode="";
String mProgramCode="";
String mBranchCode="";
String mCurrentSem="";
int mCurSem=0;
String mMS="";
String mInstituteCode="";
String mMaxSemester="";

String mSCode="";
int tempc=0;
String pStudentID="";
String programCode="";
String pQuota="";
String academicYear="";
String branchCode="";
String pInstitutecode= "";
String pGlobalCompanyCode="";
String CategoryCode="";
String regCode="";
String progCode="";

String enrollmentno1=request.getParameter("enrollno")==null?"":request.getParameter("enrollno");
String quota1=request.getParameter("quota")==null?"":request.getParameter("quota");
String program1=request.getParameter("programcode")==null?"":request.getParameter("programcode");
String branch1=request.getParameter("branchcode")==null?"":request.getParameter("branchcode");
String studentName1=request.getParameter("studentname")==null?"":request.getParameter("studentname");
String academicYear1=request.getParameter("academicyear")==null?"":request.getParameter("academicyear");
String currSecm1=request.getParameter("semester")==null?"":request.getParameter("semester");
String setType1=request.getParameter("semestertype")==null?"":request.getParameter("semestertype");
String sfName=request.getParameter("stdfname")==null?"":request.getParameter("stdfname");
String dob=request.getParameter("stddob")==null?"":request.getParameter("stddob");
String regforsemester1=request.getParameter("regforsemester")==null?"":request.getParameter("regforsemester");
DecimalFormat df = new DecimalFormat("0.00");
boolean validateStudentForFee=false;

try{
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
	mmMemberName=GlobalFunctions.toTtitleCase(mMemberName.trim());
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
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();

}

if (session.getAttribute("AcademicYearCode")==null)
{
	mAcademicYearCode="";
}
else
{
	mAcademicYearCode=session.getAttribute("AcademicYearCode").toString().trim();
}

if (session.getAttribute("ProgramCode")==null)
{
	mProgramCode="";
}
else
{
	mProgramCode=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranchCode="";
}
else
{
	mBranchCode=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mCurrentSem="";
}
else
{
	mCurrentSem=session.getAttribute("CurrentSem").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstituteCode="";
}
else
{
	mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
}
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
{
	try
	{
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());


	ResultSet RsChk=null;

 pStudentID=mMemberID;
 programCode=request.getParameter("programcode")==null?"":request.getParameter("programcode");
 pQuota=request.getParameter("quota")==null?"":request.getParameter("quota");
 academicYear=request.getParameter("academicyear")==null?"":request.getParameter("academicyear");
 branchCode=request.getParameter("branchcode")==null?"":request.getParameter("branchcode");
 pInstitutecode=  mInstituteCode;
 pGlobalCompanyCode=request.getParameter("companycode")==null?"":request.getParameter("companycode");
 CategoryCode=request.getParameter("categorycode")==null?"":request.getParameter("categorycode");
 regCode=request.getParameter("registrationcode")==null?"":request.getParameter("registrationcode");
 progCode=request.getParameter("progcode")==null?"":request.getParameter("progcode");



  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
String seqqry="Select WEBKIOSK.ShowLink('416','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  RsChk= db.getRowset(seqqry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------


%>
<input id="x" name="x" type=hidden>
<table width="90%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>

<TD colspan=0 align=middle><span style="font-weight: bold"><font color="#a52a2a" style="FONT-SIZE: 15px; FONT-FAMILY: verdana">Non Academic Student On-line fee Payment</font></span></td>
</tr>
</TABLE>
<br>

<table width="90%" style="width:90%" >
  <tr><td width="100%">
<div id="form" style="width:100%;overflow:auto">
<fieldset>
    <legend style="color:#550000;font-weight:bold; ">Student Detail</legend>
    <table width="100%" style="width:100%"  border="0" cellpadding="2" cellspacing="2">
 <tr>
 <td  nowrap="nowrap" ><strong>Enrollment No:</strong></td>
 <td  style="font-weight:bold" ><input type="text" id="enrollno" style="width:100px;height:22px;"  class="datafont" name="enrollno"   readonly  value="<%=mDMemberCode%>"/> </td>
 <td   nowrap="nowrap"><strong>Student Name:</strong></td>
 <td  colspan="3"><input type="text" id="studentname" name="studentname" style="width:300px;height:22px;"  class="datafont"  value="<%=mMemberName%>" readonly/></td>
 <tr>
 <td  nowrap="nowrap"><strong>Academic Year:</strong></td>
 <td><input type="text" id="academicyear" name="academicyear" value="<%=mAcademicYearCode%>" style="width:100px;height:22px;" class="datafont" size="30px;" readonly/></td>
 </tr>
 <tr>
 <td   nowrap="nowrap" > <strong>Program:</strong> </td>
 <td> <input type="text" id="programcode" name="programcode" size="12px;"  value="<%=mProgramCode%>" style="width:100px;height:22px;" class="datafont" readonly/></td>
 <td  nowrap="nowrap"><strong>Branch:</strong></td>
 <td><input type="text" id="branchcode" name="branchcode" size="12px;"  value="<%=mBranchCode%>"  style="width:100px;height:22px;" class="datafont"  readonly/></td>
 </tr>

</table>
</fieldset>
</div>
</td>
</tr>
</table>
</form>

<div id="tabdiv" style="width:90%">
<center>
<table  style="width:100%" >
<tr>
    <td width="54%"><legend style="color:#550000;font-weight:bold;" >&nbsp;Fee Details</legend></td><td width="2%" >&nbsp;</td>
</tr>
</table>
<hr>
</center>
<TABLE cellspacing=0  cellpadding=1 frame =box align="center" border=1
	 borderColor=black borderColorDark=white  style="width:100%">
    <TR align="middle" bgcolor="#ff8c00">
	   <TD width="7%"><P align=center><strong><FONT color=white face=Arial >&nbsp;FeeHead</FONT></strong></P></TD>
	   <TD width="11%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Dues</FONT></strong></P></TD>
           <TD width="13%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Pay Now</FONT></strong></P></TD>
    </TR>

<%

String qry3="Select Distinct CurrencyCode 	From CurrencyMaster	Where NVl(Deactive,'N')= 'N'	And AccountingCurrency = 'Y'";
rs3=db.getRowset(qry3);

if(rs3.next()){
currencyCodeofAccounting=rs3.getString(1);
}

if(currencyCodeofAccounting==null || !"".equals(currencyCodeofAccounting))
{
errorStr="Accounting Currency not Found in Currency Master. Contact Administrator..";
}



qry="select feeheads,sum(amount) amount from na#studentfeedetail where studentid='"+mMemberID+"' and VOUCHERCODE is null group by feeheads";
rs=db.getRowset(qry);
while(rs.next())
{
%>
<TR>
<TD bgcolor="#FFFFFF"><FONT color=black face=Arial ><%=rs.getString("feeheads")%></FONT></TD>
<TD bgcolor="#FFFFFF"><FONT color=black face=Arial><%=rs.getString("amount")%></FONT></TD>
<TD bgcolor="#FFFFFF" style="text-align:center;" > <FONT color=black face=Arial >

        <a href="NonAcademicFeeHistory.jsp?pamt=<%=rs.getString("amount")%>
&feeHead=<%=rs.getString("feeheads")%>
&enrollno=<%=mDMemberCode%>
&prog=<%=mProgramCode%>
&branch=<%=mBranchCode%>
&academicyear=<%=mAcademicYearCode%>
&currsem=<%=mCurrentSem%>
&mcategorycode=<%=CategoryCode%>
&mquota=<%=pQuota%>
&currecyc=<%=currencyCodeofAccounting%>
"
>
Pay Now
 </a>


    </FONT></TD>
</TR>
<%
  }
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	<br>	<br>	<br>	<br></P>
   <%
	}
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
    System.out.println(e);
}

%>
</center>
<div></div>
</body>
</html>
