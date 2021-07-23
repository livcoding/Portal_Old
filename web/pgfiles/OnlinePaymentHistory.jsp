<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,pgwebkiosk.*,java.text.SimpleDateFormat" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<%
String mHead="";
String colorcode="#FFFFFF";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	{mHead=session.getAttribute("PageHeading").toString().trim();}
else
	{mHead="";}
%>

<title>#### <%=mHead%> [ Online Payment Details  ]</title>
<style type="text/css">
<!--
.style5 {color: #FFFFFF; font-weight: bold; }
-->
</style>
</head>

<body style="width:96%"; aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
String qry="";
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet RsChk=null;
int n=0;
OLTEncryption enc=new OLTEncryption();
          

String mCompanyCode="";
String mInstituteCode="";
String studentId="";
String mProgramCode="";
String mBranchCode="";
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstituteCode="";
}
else
{
	mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
}


if (session.getAttribute("MemberID")==null)
{
	studentId="";
}
else
{
	studentId=enc.decode(session.getAttribute("MemberID").toString().trim());
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

if(!studentId.equals("") && !studentId.equals("") && !studentId.equals(""))
{
try{


 //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
String seqqry="Select WEBKIOSK.ShowLink('275','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  RsChk= db.getRowset(seqqry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>
<center>
<table ><tr><td><strong><font color="#4A0000" size="+1"> Online Payment History Details.</font></strong></td>
</tr></table>
</center>
<%


 qry="select  REGCODE, FEECURRENCYCODE, to_char(nvl(FEEDUEAMOUNT,0),'99999999999.99') FEEDUEAMOUNT, to_char(nvl(FEEPAIDAMOUNT,0),'99999999999.99') FEEPAIDAMOUNT, TRANSACTIONID, to_char(TRANSDATETIME,'dd/mm/yy hh24:mm:ss')  TRANSDATETIME, TRANSACTIONSTATUS status  from                 PG#FEETRANSACTIONMASTER  A where a.STUDENTID='"+studentId+"' and a.COMPANYCODE='"+mCompanyCode+"' and a.INSTITUTECODE='"+mInstituteCode+"'  order by a.TRANSDATETIME desc ";

String regCode="";
String feecurrencycode="";
String feeAmt="";
String feePaidAmt="";
String transactionId="";
String transactionDt="";
String transactionStatus="";

int srno=1;



rs=db.getRowset(qry);
if(rs.next())
{
%>

<center>
  <br/>
<table style="width:90%"  BORDER=1 RULES=NONE FRAME=BOX bgcolor="#FFFFFF"  bordercolor="#000000">
<tr bgcolor="#ff8c00"><td><span class="style5">Sr No.</span></td>
<td><span class="style5">Reg. Code</span></td>
<td><span class="style5">Currency Code</span></td>
<td><span class="style5">Fee Amount</span></td>
<td><span class="style5">Paid Fee Amount</span></td>
<td><span class="style5">Transaction ID</span></td>
<td><span class="style5">Transaction Date</span></td>
<td style="text-align:center"><span class="style5">Status</span></td>
</tr>
<%


do{
 regCode=rs.getString("REGCODE")==null?"":rs.getString("REGCODE");
 feecurrencycode=rs.getString("FEECURRENCYCODE")==null?"":rs.getString("FEECURRENCYCODE");
 feeAmt=rs.getString("FEEDUEAMOUNT")==null?"":rs.getString("FEEDUEAMOUNT");
 feePaidAmt=rs.getString("FEEPAIDAMOUNT")==null?"":rs.getString("FEEPAIDAMOUNT");
 transactionId=rs.getString("TRANSACTIONID")==null?"":rs.getString("TRANSACTIONID");
 transactionDt=rs.getString("TRANSDATETIME")==null?"":rs.getString("TRANSDATETIME");
 transactionStatus=rs.getString("status")==null?"":rs.getString("status");
if("S".equals(transactionStatus)){
transactionStatus="Success";
colorcode="#1FBC0E";
}else if("F".equals(transactionStatus)){
transactionStatus="Failed";
colorcode="#FF0000";
}else{
transactionStatus="Pending";
colorcode="#A6A600";
}


%>
<tr>



<td><%=srno++%></td>
<td><%=regCode%></td>
<td ><%=feecurrencycode%></td>
<td><%=feeAmt%></td>
<td><%=feePaidAmt%></td>
<td><%=transactionId%></td>
<td><%=transactionDt%></td>
<td style="text-align:center" bgcolor=<%=colorcode%>><span class="style5"><%=transactionStatus%></span></td>
</tr>


<%
}while(rs.next());

%>
</table>
<%
}
else{

%>
<center>
<br/><br/>
<font color="#FF0000" size="+2">
Online Fee Payment Details does Not Exist.
</font>
</center>
<%

}
%>
</center>



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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	<br>	<br>	<br>	<br></P>
   <%
	}

}catch(Exception e)
{
System.out.println(e);
}

}
else
{

	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}




%>





</body>
</html>
