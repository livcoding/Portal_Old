<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";
%>
<HTML>
<head>
 <TITLE>#### <%=mHead%> [ Paid Fee detail  ] </TITLE>
  
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

DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet RsFee=null,rs=null,rs1=null,rs2=null;
String qry1="",qry="",qry2="",mWebEmail="";
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
String mMS="",mRegCode="";
String mInstituteCode="",mHostel="";
String mStudID="",mQuota="",mSem="",mAcadYear="",mProCode="",mBranCode="",mSemType="",mCat="",mSemFeeTranDet="";
double Total=0.0,TotalRefund=0.0;

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

if (request.getParameter("academicyear")==null)
{
	mAcadYear="";
}
else
{
	mAcadYear=request.getParameter("academicyear").toString().trim();
}


if (request.getParameter("programcode")==null)
{
	mProCode="";
}
else
{
	mProCode=request.getParameter("programcode").toString().trim();
}
if (request.getParameter("branchcode")==null)
{
	mBranCode="";
}
else
{
	mBranCode=request.getParameter("branchcode").toString().trim();
}
if (request.getParameter("semestertype")==null)
{
	mSemType="";
}
else
{
	mSemType=request.getParameter("semestertype").toString().trim();
}

if (request.getParameter("semester")==null)
{
	mSem="";
}
else
{
	mSem=request.getParameter("semester").toString().trim();
}
if (request.getParameter("STUDENTID")==null)
{
	mStudID="";
}
else
{
	mStudID=request.getParameter("STUDENTID").toString().trim();
}
if (request.getParameter("Quota")==null)
{
	mQuota="";
}
else
{
	mQuota=request.getParameter("Quota").toString().trim();
}
if (request.getParameter("Hostel")==null)
{
	mHostel="";
}
else
{
	mHostel=request.getParameter("Hostel").toString().trim();
}


if (request.getParameter("RegCode")==null)
{
	mRegCode="";
}
else
{
	mRegCode=request.getParameter("RegCode").toString().trim();
}
if (session.getAttribute("InstituteCode")==null)
{
	mInstituteCode="";
}
else
{
	mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
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
	qry="Select WEBKIOSK.ShowLink('249','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	
		%>
		<form name=frm1 method=Post>
			<TABLE align=center width="100%" rules=group cellspacing=1 cellpadding=3>
			<tr><td  align=center colspan=2>
			<font size=4 face=arial color=#a52a2a><b>Paid Fee Details</b> </font>
			</td></tr>
			
			</table>
			<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=2 cellPadding=4 width="90%" border=1 >
			<thead>
			<tr bgcolor="#ff8c00">
		
			<td><b><font color="white" size=2>Fee Head Description</font></b></td>
			<td><b><font color="white" size=2>Mode</font></b></td>
			<td><b><font color="white" size=2>Payment Receipt No.</font></b></td>
			<td><b><font color="white" size=2>Date</font></b></td>
				<td><b><font color="white" size=2>Type</font></b></td>
					<td><b><font color="white" size=2> Currency</font></b></td>
			<td><b><font color="white" size=2>Receive Amount</font></b></td>
			<td><b><font color="white">Status</font></b></td> 
		
			</tr>
			</thead>
			<tbody> 
			<tr bgcolor=white>
		<%
qry="SELECT nvl(H.FEEHEADDESC ,' ')FEEHEADDESC ,nvl(D.FeeHead,' ')FeeHead,nvl(D.CurrencyCode,' ') CurrencyCode,nvl(M.Prno,' ') PRNO,D.FeePaidSemester,nvl(D.FeeCurrencyCode,' ') FeeCurrencyCode , Nvl(D.FeeCurrencyAmount,0) feecurrencyAmount,D.FeeAmount,to_char(M.PRDATE,'dd-mm-yyyy') PRDATE,decode(M.TransactionType,'P','REFUND','R','COLLECTION',M.TransactionType)TransactionType, decode(m.receiptmode,'B','BANK','J','JV','C','CASH',m.receiptmode)receiptmode,decode(M.DocMode,'D','DRAFT','F','FINAL','A','APPROVED','C','CANCEL',' ',M.DocMode)DocMode,D.Slno,0 Ord FROM feetransaction m, feetransactiondetail d, feeheads h WHERE m.institutecode = '"+mInstituteCode+"'   AND m.companycode = '"+mCompanyCode+"'   AND m.academicyear = '"+mAcadYear+"'   AND m.studentid = '"+mStudID+"' AND m.forregcode =  '"+mRegCode+"'     AND d.feepaidsemester = '"+mSem+"' AND d.semestertype = '"+mSemType+"' AND m.companycode = d.companycode AND m.institutecode = d.institutecode AND m.financialyear = d.financialyear AND m.transactiontype = d.transactiontype AND m.prno = d.prno AND d.feehead = h.feehead AND d.companycode = h.companycode AND m.docmode != 'C' UNION ALL SELECT nvl(H.FEEHEADDESC ,' ')FEEHEADDESC ,nvl(D.FromFeeHead,' ') feeHead,Null CurrencyCode,nvl(M.Tno,' ')Tno,D.Semester,nvl(D.TOCurrencyCode ,' ')FeeCurrencyCode, Sum(Nvl(D.FeeCurrencyAmount,0)) feecurrencyAmount,Sum(D.FeeAmount) FeeAmount,to_char(M.TDATE,'dd-mm-yyyy')PRDATE,'TRANSFEROUT' TransactionType, decode(m.receiptmode,'B','BANK','J','JV','C','CASH',m.receiptmode)receiptmode,decode(M.DocMode,'D','DRAFT','F','FINAL','A','APPROVED','C','CANCEL',' ',M.DocMode)DocMode,D.Slno,1 ord FROM feetransfer m, feetransferhead d, feeheads h WHERE m.institutecode = '"+mInstituteCode+"'   AND m.companycode = '"+mCompanyCode+"'   AND m.fromacademicyear = '"+mAcadYear+"'   AND m.fromstudentid = '"+mStudID+"' AND m.fromregcode =  '"+mRegCode+"'     AND d.fromsemester = '"+mSem+"' AND d.fromsemestertype = '"+mSemType+"' AND m.companycode = d.companycode AND m.institutecode = d.institutecode AND m.financialyear = d.financialyear AND m.tno = d.tno AND m.tdate = d.tdate AND d.fromfeehead = h.feehead AND d.companycode = h.companycode AND m.docmode != 'C' AND d.fromcurrencycode = d.tocurrencycode Group by H.FEEHEADDESC,D.FromFeeHead , Null,M.Tno,D.Semester,D.TOCurrencyCode, M.TDATE,'TRANSFEROUT' ,M.Receiptmode,M.DocMode,D.Slno,1 UNION ALL SELECT nvl(H.FEEHEADDESC ,' ')FEEHEADDESC ,nvl(D.FromFeeHead,' ') feeHead, Null CurrencyCode,nvl(M.Tno,' ')Tno,D.Semester,nvl(D.TOCurrencyCode,' ') FeeCurrencyCode, Sum(Nvl(D.FeeCurrencyAmount,0)) feecurrencyAmount,Sum(D.FeeAmount) FeeAmount,to_char(M.TDATE,'dd-mm-yyyy')PRDATE,'TRANSFEROUT' TransactionType, decode(m.receiptmode,'B','BANK','J','JV','C','CASH',m.receiptmode)receiptmode, decode(M.DocMode,'D','DRAFT','F','FINAL','A','APPROVED','C','CANCEL',' ',M.DocMode)DocMode, D.Slno,1 ord FROM feetransfer m, feetransferhead d, feeheads h, feetransferdetailfc fc  WHERE m.institutecode = '"+mInstituteCode+"'   AND m.companycode = '"+mCompanyCode+"'   AND m.fromacademicyear = '"+mAcadYear+"'    AND m.fromstudentid = '"+mStudID+"' AND m.fromregcode =  '"+mRegCode+"'     AND d.fromsemester = '"+mSem+"' AND d.fromsemestertype = '"+mSemType+"' AND m.companycode = d.companycode  AND m.institutecode = d.institutecode AND m.financialyear = d.financialyear  AND m.tno = d.tno AND m.tdate = d.tdate AND d.fromfeehead = h.feehead  AND d.companycode = h.companycode AND m.docmode != 'C'  AND d.fromcurrencycode <> d.tocurrencycode AND fc.companycode = d.companycode  AND fc.financialyear = d.financialyear AND fc.institutecode = d.institutecode  AND fc.tno = d.tno AND fc.slno = d.slno  Group by H.FEEHEADDESC,D.FromFeeHead , Null,M.Tno,D.Semester,D.TOCurrencyCode,  M.TDATE,'TRANSFEROUT' , M.Receiptmode,M.DocMode,D.Slno,1   UNION ALL   SELECT nvl(H.FEEHEADDESC ,' ')FEEHEADDESC , nvl(D.ToFeeHeadORGlID,' ') feeHead,Null CurrencyCode,nvl( M.Tno,' ')Tno,D.Semester,nvl(D.ToCurrencyCode,' ') FeeCurrencyCode, Sum(Nvl(D.FeeCurrencyAmount,0)) feecurrencyAmount, Sum(D.FeeAmount) FeeAmount,to_char(M.TDATE,'dd-mm-yyyy')PRDATE,'TRANSFERIN' TransactionType,  decode(m.receiptmode,'B','BANK','J','JV','C','CASH',m.receiptmode)receiptmode, decode(M.DocMode,'D','DRAFT','F','FINAL','A','APPROVED','C','CANCEL',' ',M.DocMode)DocMode,D.Slno,1 ord  FROM feetransfer m, feetransferhead d, feeheads h WHERE m.institutecode = '"+mInstituteCode+"'   AND  m.companycode = '"+mCompanyCode+"'    AND m.academicyear = '"+mAcadYear+"'    AND m.studentid = '"+mStudID+"'  AND m.forregcode =  '"+mRegCode+"'      AND d.semester = '"+mSem+"'     AND d.semestertype ='"+mSemType+"'  AND m.companycode = d.companycode AND m.institutecode = d.institutecode  AND m.financialyear = d.financialyear AND m.tno = d.tno AND m.tdate = d.tdate  AND d.tofeeheadorglid = h.feehead AND d.companycode = h.companycode AND m.docmode != 'C'  Group by H.FEEHEADDESC,D.ToFeeHeadORGlID , Null,M.Tno,D.Semester,D.ToCurrencyCode, M.TDATE,'TRANSFERIN'  ,M.Receiptmode,M.DocMode,D.Slno,2 ";



			
	//out.print(qry);	
		rs=db.getRowset(qry);
		while(rs.next())
		{
			
			if(rs.getString("TransactionType").equals("COLLECTION") || rs.getString("TransactionType").equals("TRANSFERIN"))
			{
				Total=Total+rs.getDouble("feeamount");
			}
			if(rs.getString("TransactionType").equals("REFUND") || rs.getString("TransactionType").equals("TRANSFEROUT"))
			{
				TotalRefund=TotalRefund+rs.getDouble("feeamount");
			}

			%>
				<tr bgcolor=white >
			
				<td nowrap><%=rs.getString("FEEHEADDESC")%></td>
				<td><%=rs.getString("receiptmode")%></td>
				<td><%=rs.getString("Prno")%></td>
				<td nowrap><%=rs.getString("PRDATE")%></td>
				<td><%=rs.getString("TransactionType")%></td>
				<td><%=rs.getString("FeeCurrencyCode")%></td>
				<td align=right><b><%=rs.getDouble("feeamount")%></b></td>
				 <td align=right><%=rs.getString("DocMode")%></td> 
				
				</tr>
			<%
					
		}
		%>
		 <td colspan=6 align=right valign=top>
			&nbsp;&nbsp;&nbsp;	 
		 <font size=2 color=blue face=arial><b>Total Receipt :&nbsp; 
		 </td><td align=right>
		  <font size=2 color=blue face=arial><b><%=Total%></b></font></td>
		 <TD>&nbsp;</TD>
		 </tr><tr>
		  <td colspan=6 align=right valign=top>
			&nbsp;&nbsp;&nbsp;	 
		 <font size=2 color=blue face=arial><b>Total Refund :&nbsp; 
		 </td><td align=right>
		  <font size=2 color=blue face=arial><b><%=TotalRefund%></b></font></td>
		 <TD>&nbsp;</TD>
		  </tr>
		</tbody>
		</TABLE>
		</form>


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
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
	</td>
</tr>
</table>
</body>
</html>
