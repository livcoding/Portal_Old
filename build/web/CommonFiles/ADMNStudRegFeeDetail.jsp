<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
 <TITLE>#### <%=mHead%> [ View Academic Fee detail  ] </TITLE>
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
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet RsFee=null;
String qry1="",mWebEmail="";
int mSNO=0;
int mData=0;
String pCur="",pSem="";

String mMemberID="",mSnm="",mENo="";
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
String mMS="",mSID="";
String mInstituteCode="";
String mMaxSemester="";

String mSCode="";

if (request.getParameter("CC")==null)
{
	 pCur="";
}	 
else
{
	pCur=request.getParameter("CC").toString().trim();
}

if (request.getParameter("SEM")==null)
{
	 pSem="";
}	 
else
{
	pSem=request.getParameter("SEM").toString().trim();
}


try
{
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}


if (request.getParameter("SID")==null)
{
	mSID="";
}
else
{
	mSID=request.getParameter("SID").toString().trim();
}


if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
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
	mInstituteCode="";
}
else
{
	mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
}
int mSem=0;
ResultSet rs1=null;
qry="select StudentName, Enrollmentno ,semester from StudentMaster where StudentID='"+mSID+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mSnm=rs1.getString(1);
mENo=rs1.getString(2);
mSem=rs1.getInt(3);	
}

if(!mMemberID.equals("") && !mMemberCode.equals("") ) 
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
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('150','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>

<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Registration Fee Detail (Paid/Dues/Advance etc.)</TD>
</font></td></tr>
</TABLE>
<table width="100%" BORDER=1 RULES=NONE>
<tr><td align=center>
<font color="#00008b"><B>Student Name:</B><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</font>
</TD><TD><font color="#00008b">
<b>Current Semester:</b>&nbsp;<%=mSem%></font>
</td></tr></table>
<br>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
<thead>
<tr bgcolor="#ff8c00">
<td><b><font color="white">Fee Head</font></b></td>
<td><b><font color="white">Fee Amount</font></b></td>
<td><b><font color="white">Discount Amt</font></b></td>
<td><b><font color="white">Fees Paid</font></b></td>
<td><b><font color="white">Adv. Paid</font></b></td>
<td><b><font color="white">Dues (if any)</font></b></td>
</tr>
</thead>
<tbody>
<%
qry="SELECT FEEHEADDESC, nvl(FEEAMOUNT,0) FEEAMOUNT,  nvl(PAIDAMOUNT,0) PAIDAMOUNT,  PAIDINACCOUNTINGCURRENCY, Nvl(REFUNDAMOUNT,0) REFUNDAMOUNT, REFUNDINACCOUNTINGCURRENCY, ";
qry=qry+" nvl(DISCOUNTAMOUNT,0) DISCOUNTAMOUNT,  nvl(APPROVALAMOUNT,0) APPROVALAMOUNT FROM STUDENTFEESUMMARY a,FEEHEADS B Where A.INSTITUTECODE='"+mInstituteCode+"'";
qry=qry+" And A.COMPANYCODE in (select COMPANYTAGGING from INSTITUTEMASTER where INSTITUTECODE='"+mInstituteCode+"') ";
qry=qry+" And STUDENTID='"+mSID+"' and SEMESTER="+pSem+" And CURRENCYCODE='"+pCur+"'";
qry=qry+" And A.INSTITUTECODE = B.INSTITUTECODE And A.FEEHEAD=B.FEEHEAD";
qry=qry+" order by SEMESTER ";

RsFee= db.getRowset(qry);
double mDueAmt=0;
double mTotFeeAmt=0,mTotDisAmt=0,mTotPaidAmt=0,mTotRefundAmt=0,mTotDueAmt=0;
while (RsFee.next())
   {
	mDueAmt=RsFee.getDouble("FEEAMOUNT")-(RsFee.getDouble("PAIDAMOUNT")+RsFee.getDouble("DISCOUNTAMOUNT")); 
	mTotFeeAmt+=RsFee.getDouble("FEEAMOUNT");
	mTotDisAmt+=RsFee.getDouble("DISCOUNTAMOUNT");
	mTotPaidAmt+=RsFee.getDouble("PAIDAMOUNT");
	mTotRefundAmt+=RsFee.getDouble("REFUNDAMOUNT");
	mTotDueAmt+=mDueAmt;

	%>
	<tr>
	<td align=center><%=RsFee.getString("FEEHEADDESC")%>&nbsp; &nbsp;</td>
      <td align=right><%=RsFee.getDouble("FEEAMOUNT")%>&nbsp; &nbsp;</td>
	<td align=right><%=RsFee.getDouble("DISCOUNTAMOUNT")%>&nbsp; &nbsp;</td>
	<td align=right><%=RsFee.getDouble("PAIDAMOUNT")%> (<%=RsFee.getDouble("PAIDINACCOUNTINGCURRENCY")%>)&nbsp; &nbsp;</td>
	<td align=right><%=RsFee.getDouble("REFUNDAMOUNT")%>(<%=RsFee.getDouble("REFUNDINACCOUNTINGCURRENCY")%>)&nbsp; &nbsp;</td>
	<td align=right><%=mDueAmt%>&nbsp; &nbsp;</td>
	</tr>
	<%
   }

%>

	<tr bgcolor=white>
	<td align=right><b>Total Amount</b>&nbsp; &nbsp;</td>
	<td align=right><b><%=mTotFeeAmt%></b>&nbsp; &nbsp;</td>
	<td align=right><b><%=mTotDisAmt%></b>&nbsp; &nbsp;</td>
	<td align=right><b><%=mTotPaidAmt%></b>&nbsp; &nbsp;</td>
	<td align=right><b><%=mTotRefundAmt%></b>&nbsp; &nbsp;</td>
	<td align=right><b><%=mTotDueAmt%></b>&nbsp; &nbsp;</td>
	</tr>
	

</tbody>
</Table>

<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
</script>

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
	</font>	<br>	<br>	<br>	<br>
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
}
%>
<table ALIGN=Center VALIGN=TOP>
<tr>
	<td valign=middle><br><br>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp"><FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
	</td>
</tr>
</table>
</body>
</html>