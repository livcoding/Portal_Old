<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JUIT ";
%>
<HTML>
<head>
 <TITLE>#### <%=mHead%> [ View Academic Fee Receipt  ] </TITLE>
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
ResultSet rs=null;
String qry1="",mWebEmail="";
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

String pCur="",pSem="",Shortdesc1 ="";
 double mFeeAmount = 0.0, FeeCurrencyAmount = 0.0;
        String FeeHeadDesc = "", Shortdesc = "", mInstName = "", mInstAddress = "",  mFatherName = "", PRDATE = "";

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
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('31','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------


String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

		//out.print("basePath"+basePath);


String mPRNO = request.getParameter("PRNO").toString().trim();

%>

<form name="frm"  method="post" action="PDFFeeReceipt.jsp" >
<input id="x" name="x" type=hidden>


<input id="InstituteCode" name="InstituteCode" type=hidden VALUE="<%=mInstituteCode%>">

<input id="ProgramCode" name="ProgramCode" type=hidden VALUE="<%=mProgramCode%>">

<input id="BranchCode" name="BranchCode" type=hidden VALUE="<%=mBranchCode%>">

<input id="CompanyCode" name="CompanyCode" type=hidden VALUE="<%=mCompanyCode%>">

<input id="STUDENTID" name="STUDENTID" type=hidden VALUE="<%=mChkMemID%>">

<input id="basePath" name="basePath" type=hidden VALUE="<%=basePath%>">

<input id="SEM" name="SEM" type=hidden VALUE="<%=pSem%>">
<input id="PRNO" name="PRNO" type=hidden VALUE="<%=mPRNO%>">

<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana">Registration Fee Receipt</TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
<tr>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Name(Enrolment No.) :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td nowrap><FONT color=black>&nbsp; <FONT face=Arial size=2><%=mmMemberName%>(<%=mDMemberCode%>)</FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Program-Branch :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=mProgramCode%>-<%=mBranchCode%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 </tr>
 <tr>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Academic Year :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=mAcademicYearCode%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG> Semester :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=pSem%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 </tr>
 <tr> 
</table>
<br>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="70%" border=1 >
<thead>
<tr bgcolor="#ff8c00">
<td><b><font color="white" size=2 >Semester</font></b></td>
<td><b><font color="white" size=2 >Fee Head</font></b></td>
<td><b><font color="white" size=2 >Fee Currency</font></b></td>
<td><b><font color="white" size=2 >Fee Amount</font></b></td>
<td><b><font color="white" size=2 >Pr.No.</font></b></td>
</tr>
</thead>
<tbody>
<%
 qry1 = " select distinct  ft.FeePAidSemester,ft.SemesterType,ft.FeeHead FeeHead , fh.FeeHeadDesc FeeHeadDesc ," +
                    " ft.FeeCurrencycode FeeCurrencycode," +
                    " ft.FeeCurrencyAmount FeeCurrencyAmount,ft.prno prno,ft.transactiontype transactiontype, " +
                    " InitCap(cm.ShortDesc) Shortdesc,TO_CHAR(d.PRDATE,'DD-MM-YYYY')PRDATE from   FeeTransactiondetail FT, FeeHeads FH,CurrencyMaster Cm,Feetransaction d" +
                    " where  Ft.Feehead          = fh.FeeHead and    ft.Institutecode    = fh.Institutecode" +
                    " and    ft.CompanyCode      = fh.CompanyCode and    ft.COmpanyCode      = '" + mCompanyCode + "'" +
                    " and    ft.prno             = '" + mPRNO + "' and    ft.TransactionType  = 'R' and  " +
                    "  nvl(fh.Deactive,'N')= 'N' And  cm.CurrencyCode = ft.CurrencyCode " +
                    "and ft.COMPANYCODE=d.COMPANYCODE and ft.INSTITUTECODE=d.INSTITUTECODE and ft.PRNO=d.PRNO " +
                    "  and d.STUDENTID='" + mChkMemID + "' " +
                    " and ft.TRANSACTIONTYPE=d.TRANSACTIONTYPE and ft.FINANCIALYEAR=d.FINANCIALYEAR";
          \\out.print(qry1);
            rs = db.getRowset(qry1);

            while (rs.next()) {
                FeeHeadDesc=rs.getString("FeeHeadDesc");
                Shortdesc1 = rs.getString("Shortdesc");
                FeeCurrencyAmount=rs.getDouble("FeeCurrencyAmount");

                mFeeAmount = mFeeAmount + rs.getDouble("FeeCurrencyAmount");
                PRDATE = rs.getString("PRDATE");

				%>
	<tr>
	<td align=center><%=pSem%>&nbsp; &nbsp;</td>
	<td align=center><%=rs.getString("FEEHEADDESC")%>&nbsp; &nbsp;</td>
<td align=center><%=rs.getString("FeeCurrencycode")%>&nbsp; &nbsp;</td>
	<td align=right><%=Shortdesc1%> &nbsp;<%=FeeCurrencyAmount%>&nbsp; &nbsp;</td>
		<td align=center><%=mPRNO%>&nbsp; &nbsp;</td>
<%
            }
%>

	<tr bgcolor=white>
	<td align=right>&nbsp; &nbsp;</td>
	<td align=right>&nbsp; &nbsp;</td>

	<td align=right><b>Total Amount</b>&nbsp; &nbsp;</td>
	<td align=right><b><%=Shortdesc1%> &nbsp;<%=mFeeAmount%></b>&nbsp; &nbsp;</td>
	<td align=right>&nbsp; &nbsp;</td>
	</tr>
	

</tbody>
</Table>

<TABLE ALIGN=CENTER>
<TR>
	<TD><INPUT TYPE="submit" VALUE="Click to Print in PDF"> </TD>
</TR>
</TABLE>


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

</body>
</html>