<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null,rst=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
int count= 0;
String qry="",qry1="",qry2="";
String mComp="";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInst="",mtext="",mCurrDate="";
String mDepartment1="",mLeaveYearCode="",mNatureOfJob="";
String mValDate="",mDay="",mFromDate="",mToDate="",mCategoryCode="",mSex=""; 
String mPresentDays="",mLeaveCode="",mLeaveTaken="",mBalance="";

String mRegCode = "";
        String mFeeHead = "";
        String mAcademicYear = "";
        String mProgramCode = "";
        String mBranchCode = "";
        String mInstCode = "JIIT";
		String mqryENROLLMENTNO="",mqrystudentname="",mqrySEMESTER="";
int flag=0;
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();


if(session.getAttribute("CompanyPersonal")!=null)
{
	mComp=session.getAttribute("CompanyPersonal").toString().trim();
}

if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();
if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();


if (request.getParameter("AcademicYear") == null) { 
                mAcademicYear = "";
            } else {
                mAcademicYear = request.getParameter("AcademicYear").toString().trim();
            }

            if (request.getParameter("RegCode") == null) {
                mRegCode = "";
            } else {
                mRegCode = request.getParameter("RegCode").toString().trim();
            }
            if (request.getParameter("ProgramCode") == null) {
                mProgramCode = "";
            } else {
                mProgramCode = request.getParameter("ProgramCode").toString().trim();
            }
            if (request.getParameter("FeeHead") == null) {
                mFeeHead = "";
            } else {
                mFeeHead = request.getParameter("FeeHead").toString().trim();
            }
            if (request.getParameter("BranchCode") == null) {
                mBranchCode = "";
            } else {
                mBranchCode = request.getParameter("BranchCode").toString().trim();
            }

if (request.getParameter("ENROLLMENTNO").toString().trim()==null)
{
	mqryENROLLMENTNO="";    
}
else
{	
	mqryENROLLMENTNO=request.getParameter("ENROLLMENTNO").toString().trim();
}
if (request.getParameter("studentname").toString().trim()==null)
{
	mqrystudentname="";
}
else
{	
	mqrystudentname=request.getParameter("studentname").toString().trim();
}
if (request.getParameter("SEMESTER").toString().trim()==null)
{
	mqrySEMESTER="";
}
else
{	
	mqrySEMESTER=request.getParameter("SEMESTER").toString().trim();
}
if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Mis_Report] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
<script language=javascript>
<!--
function RefreshContents()
{ 	
	document.frm.x.value='ddd';
	document.frm.submit();
}
//-->
if(window.history.forward(1) != null)
window.history.forward(1);	
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin="0" topmargin="0">
<%
try
{
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
		//-----------------------------
		//-- Enable Security Page Level  @mohit
		//-----------------------------
		qry="Select WEBKIOSK.ShowLink('303','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	 	RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		%>
			<form name="frm"  method="post">
			<input id="x" name="x" type="hidden">
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
			<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Student Wise Mis_Report</FONT></u></b></td>
			</tr>
			</table>
			</center>
			<!----------qry	 -->
			<center>
			<table align=center cellpadding="0" cellspacing="0" border="0" rules="groups">   
			<tr>
				<td colspan=8><hr>
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Enrollment No.: </font><%=mqryENROLLMENTNO %></B>
				
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Student Name : </font><%=mqrystudentname %></B>
				
				<b><FONT face=Arial size=2>&nbsp; Semester : </font><%=mqrySEMESTER %></B><hr>
				</td>
			</tr>							
			</table>
			</center>		
			
			<center>
			<font face="Arial" size=3><u><b>Student Wise Mis_Report</b></u></font>
			<br>
			</br>
			</center>
			<center>
			<TABLE frame=box style="FONT-FAMILY: Arial; FONT-SIZE: x-small"  border=1 bordercolor=Black bordercolordark=White cellpadding=2 cellspacing=0 width="100%">
			<TR bgcolor="#ff8c00">
				
				<TH><font face="Arial" size=2 color="white">Sr.No.</font></TH>
				<TH><font face="Arial" size=2 color="white">Fee Heads</font></TH>
				<TH><font face="Arial" size=2 color="white">Payable Amount</font></TH>
				<TH><font face="Arial" size=2 color="white">Paid Amount</font></TH>
				<TH><font face="Arial" size=2 color="white">Balance Amount</font></TH>
			</TR>		
			<%
				try
			{
qry="SELECT  a.feehead, a.feeamount AS payableamount, a.paidamount, b.enrollmentno ,a.paidamount ,(SUM (a.feeamount) - SUM (a.paidamount)) balanceAmount FROM studentfeesummary a, studentmaster b WHERE a.studentid = b.studentid            AND a.semester = '"+mqrySEMESTER+"' AND b.studentname = '"+mqrystudentname+"'  AND b.enrollmentno = '"+mqryENROLLMENTNO+"' GROUP BY a.feehead, a.feeamount, a.paidamount, b.enrollmentno ORDER BY a.feehead, a.feeamount, a.paidamount, b.enrollmentno";
rst=db.getRowset(qry);
//out.print(qry);

while (rst.next())      
{ 		
%>			
<center>
<TR bgcolor="white">
						   <TD align="center">&nbsp;<b><%=++count%></b></TD>
						   <TD bgcolor=white align=center><Font face=Arial color=blue size=2><%=rst.getString("FEEHEAD")%></Font></a></TD>                           
						   <TD bgcolor=white align=center><Font face=Arial color=blue size=2><%=rst.getString("payableamount")%></Font></a></TD>
						   <TD bgcolor=white align=center><Font face=Arial color=blue size=2><%=rst.getString("PAIDAMOUNT")%></Font></a></TD>							
						   <TD align="center">&nbsp;<%=rst.getString("balanceAmount")%></TD>	
						   </TR>
<%				
}
}
catch(Exception e)
{				
}
%>
</table>
</center>
<%				
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3><br><img src='images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br> 
			<%
		}
	}
	else
	{
		out.print("<br><img src='images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{	
  	
}
%>
</form>
</body>
</html>