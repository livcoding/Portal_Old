<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
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
String qry="",qryt="" ,qryst="",qryssa="",qrydis="",qryr="",qryp="",qryad="",qryadr="" ,qryqu="";
DBHandler db=new DBHandler();
ArrayList feeevents=new ArrayList();
GlobalFunctions gb =new GlobalFunctions();
ResultSet RsFee=null,rset=null ,rspfee=null,rsamtt=null,rsdis=null,rsPaid=null,rsref=null,rsadv=null,rsrad=null ,rsqu=null;
String qry1="",mWebEmail="";
int mSNO=0;
double mFeeAmt=0,mSsaAmt=0,mDisAmt=0,mRefAmt=0,mPaidAmt=0,mAdvAmt=0,mAdvRef=0 ,mNetPaidAmt=0 , mDueAmt=0;
double mTotFeeAmt=0,mTotDisAmt=0,mTotPaidAmt=0,mTotRefundAmt=0,mTotDueAmt=0;
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
int mCurSem=0,sem=0;//
String mMS="",sType="",host="",hType="",cCode="" ,mQuota="" ,mQuotad="",mQuotat="" ,mCur="";
String mInstituteCode="";
String mMaxSemester="";

String mSCode="";
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

%>

<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana">Registration Fee Detail (Paid/Dues/Advance etc.)</TD>
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
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Current Semester :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=mCurrentSem%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 </tr>
 <tr>
</table>
<br>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
<thead>
<tr bgcolor="#ff8c00">
<td><b><font color="white" size=2 >Semester</font></b></td>
<td align=center><b><font color="white" size=2 >Fee Currency</font></b></td>
<td align=right><b><font color="white" size=2 >Fee Amount</font></b></td>
<td align=right><b><font color="white" size=2 >Discount </font></b></td>
<td align=right><b><font color="white" size=2 >Net Paid</font></b></td>
<!-- <td align=right><b><font color="white" size=2 >Refund</font></b>< /td> -->
<td align=right><b><font color="white" size=2 >Dues (if any)</font></b></td>
</tr>
</thead>
<tbody>
<%

qryqu = " select QUOTA from studentmaster where " ;
qryqu=qryqu+ " Institutecode          = '"+mInstituteCode+"'";
qryqu=qryqu+ " And    StudentID    ='"+mChkMemID+"'";
//out.print(qryqu);
rsqu=db.getRowset(qryqu);

if(rsqu.next())//sType="",host="",hType="";
   {
    mQuotad=rsqu.getString("QUOTA");
   // out.print("abc"+mQuotad);
}


qryt="Select  b.ProgramCode,b.BranchCode,Nvl(b.HostelAllow,'N') HostelAllow,Nvl(b.HostelType,'*') HostelType,";
qryt=qryt+ " rm.RegCode, b.Semester, b.SemesterType From V#SFmStudentRegistration b,RegistrationMaster rm   " ;
qryt=qryt+ " Where rm.RegCode = b.RegCode ";
qryt=qryt+ " And   rm.InstituteCode = b.InstituteCode  ";
qryt=qryt+ " And   rm.CompanyCode   = b.CompanyCode";
qryt=qryt+ " ANd   Nvl(rm.FeeCollection,'N')    = 'Y'";
qryt=qryt+ " And    b.Institutecode          = '"+mInstituteCode+"'";
qryt=qryt+ " And    b.CompanyCode    = '"+mCompanyCode+"'";
qryt=qryt+ " And    b.StudentID    ='"+mChkMemID+"'";
qryt=qryt+ " And    Nvl(b.RegAllow,'N')      = 'Y'    ";
qryt=qryt+ " And b.AcademicYear    =  '"+mAcademicYearCode+"'  ";
qryt=qryt+ " And    nvl(b.ProgramCode,'*') = Nvl('"+mProgramCode+"','*')";
qryt=qryt+ " And    nvl(b.BranchCode,'*') = nvl('"+mBranchCode+"','*')";
qryt=qryt+ " order by b.Semester, b.SemesterType,rm.RegDateFrom ";
rset=db.getRowset(qryt);
while (rset.next())//sType="",host="",hType="";
   {
  //  out.println("HELLO");
    cCode=rset.getString("RegCode");
  //  out.println(cCode);
    hType=rset.getString("HostelType");
 //   out.println(hType);
     sem=rset.getInt("Semester");
   //   out.println(sem);
    sType=rset.getString("SemesterType");
    host=rset.getString("HostelAllow");
   // hType=rset.getString("HostelType");
   // sem=rset.getInt("Semester");
    mFeeAmt=0;
 //mDueAmt=0;
 mDisAmt=0;
// mNetPaidAmt=0;
 mSsaAmt =0;
 mPaidAmt=0;
 mRefAmt=0;

/*--------- Paid Amount-------------------------*/ /*,max(quota) quota*/
qryp =" select sum(nvl(x.PaidAmount,0)) PaidAmount ,max(quota) quota from (Select Sum(Nvl(d.FeeCurrencyAmount,0)) PaidAmount ,max(quota) quota From FeeTransactionDetail d, FeeTransaction m,Feeheads h Where m.InstituteCode  = '"+mInstituteCode+"' ";
qryp =qryp+" And m.CompanyCode = '"+mCompanyCode+"' And m.StudentID =  '"+mChkMemID+"' And m.AcademicYear= '"+mAcademicYearCode+"'  ";
qryp =qryp+"  And m.ForRegCode = '"+cCode+"' ANd m.CompanyCode = d.CompanyCode And   m.InstituteCode   = d.InstituteCode ";
qryp =qryp+" And m.FinancialYear= d.FinancialYear And m.TransactionType = d.TranSactionType And m.TransactionType = 'R' ";
qryp =qryp+" And m.PRNO = d.PRNO And D.Feehead = h.FeeHead And d.CompanyCode = h.Companycode And h.FeeType Not In ('A','V') ";
qryp =qryp+" And Nvl(d.FeePaidSemester,0) = Nvl("+sem+",0)And Nvl(d.SemesterType,'*') = Nvl('"+sType+"','*') And    m.DocMode != 'C' ";
qryp =qryp+" AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE  fc.Prno = d.prno And fc.Slno = d.slno AND fc.feehead = d.Feehead ";
qryp =qryp+"    And fc.CompanyCode = d.CompanyCode  And fc.InstituteCode = d.InstituteCode And fc.FinancialYear = d.FinancialYear ";
qryp =qryp+"    And TransactionType = d.Transactiontype AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.FeeCurrencyCode) ";
qryp =qryp+" Union All ";
qryp =qryp+" Select Sum(Nvl(d.FeeCurrencyAmount,0)) PaidAmount ,max(quota) quota From FeeTransferHead d, FeeTransfer m,Feeheads h ";
qryp =qryp+" Where m.InstituteCode = '"+mInstituteCode+"' And m.CompanyCode  = '"+mCompanyCode+"' And m.StudentID = '"+mChkMemID+"' ";
qryp =qryp+" And m.AcademicYear = '"+mAcademicYearCode+"'  And m.ForRegCode = '"+cCode+"' ANd m.CompanyCode= d.CompanyCode ";
qryp =qryp+" And m.InstituteCode = d.InstituteCode And   m.FinancialYear =d.FinancialYear And m.TNO = d.TNO And D.TOFeeheadOrGlID = h.FeeHead  ";
qryp =qryp+" And d.CompanyCode = h.Companycode And h.FeeType Not In ('A','V') And Nvl(d.Semester,0)= Nvl("+sem+",0) ";
qryp =qryp+" And Nvl(d.SemesterType,'*')=    Nvl('"+sType+"','*')And m.Docmode != 'C' "  ;
qryp =qryp+" AND NOT EXISTS (SELECT 'Y' FROM FeeTransferDetailFC fc WHERE fc.Tno = d.Tno And fc.Slno = d.slno AND fc.Tofeehead = d.ToFeeheadOrGlID ";
qryp =qryp+"    And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode And fc.FinancialYear = d.FinancialYear ";
qryp =qryp+"    AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.ToCurrencyCode))x ";
//out.print(qryp);
rsPaid=db.getRowset(qryp);
mQuota="";
while(rsPaid.next()){

mPaidAmt+=rsPaid.getDouble("PaidAmount");
mQuota=rsPaid.getString("QUOTA");
}


if(mQuota==null ||mQuota.equalsIgnoreCase("") )
 {
  mQuota=mQuotad;
  //out.print("sajjad"+mQuota);
}


//out.print("Paid"+mPaidAmt);

/*--------- Program Fee-------------------------*/
qryst=" SELECT s.collseqid,g.currencycode,g.feehead,INITCAP (s.FEEHEADDESC) FEEHEADDESC,g.postingcompany postingcompany,g.glid, ";
qryst=qryst+ " g.feeamount,'Academic Year Wise' feesource,feetype FROM feestructure g, feeheads s ";
qryst=qryst+ " WHERE g.institutecode = '"+mInstituteCode+"' AND g.companycode = '"+mCompanyCode+"' AND g.QUOTA = '"+mQuota+"' AND g.academicyear = '"+mAcademicYearCode+"'  ";
qryst=qryst+ " AND g.programcode = '"+mProgramCode+"' AND g.branchcode = '"+mBranchCode+"' AND g.semester = "+sem+" AND g.semestertype = '"+sType+"' ";
qryst=qryst+ " /*AND g.currencycode = 'INR'*/ AND NVL (g.feeamount, 0) > 0 AND s.feehead = g.feehead AND s.institutecode = g.institutecode ";
qryst=qryst+ " AND s.companycode = g.companycode AND NVL (s.deactive, 'N') = 'N' AND g.feehead NOT IN ";
qryst=qryst+    " (SELECT f.feehead FROM feeheads f WHERE f.institutecode = '"+mInstituteCode+"' AND f.companycode = '"+mCompanyCode+"' ";
qryst=qryst+    " AND f.feetype = 'H' AND '"+host+"' = 'N')   ";
qryst=qryst+ "AND NOT EXISTS  (SELECT NULL FROM feestructureindividual fsi1  ";
qryst=qryst+    " WHERE fsi1.institutecode = '"+mInstituteCode+"' AND fsi1.companycode = '"+mCompanyCode+"' AND fsi1.studentid = '"+mChkMemID+"' ";
qryst=qryst+    " AND fsi1.academicyear = '"+mAcademicYearCode+"' AND fsi1.programcode = '"+mProgramCode+"' AND fsi1.branchcode = '"+mBranchCode+"' ";
qryst=qryst+    " /*AND fsi1.currencycode = 'INR'*/ AND NVL (fsi1.deactive, 'N') = 'N' AND fsi1.semester = g.semester ";
qryst=qryst+    " AND fsi1.semestertype = g.semestertype AND fsi1.regcode = '"+cCode+"' ";
qryst=qryst+    " AND fsi1.feehead = g.feehead) ";
qryst=qryst+ " AND NOT EXISTS (SELECT NULL FROM feestructurecriteria fsc ";
qryst=qryst+    " WHERE fsc.institutecode = '"+mInstituteCode+"' AND fsc.companycode = '"+mCompanyCode+"' AND fsc.academicyear = '"+mAcademicYearCode+"' ";
qryst=qryst+    " AND fsc.programcode = '"+mProgramCode+"' AND fsc.branchcode = '"+mBranchCode+"'/* AND fsc.currencycode = 'INR'*/ AND fsc.semester = g.semester ";
qryst=qryst+    " AND fsc.semestertype = g.semestertype AND fsc.feehead = g.feehead AND fsc.QUOTA = g.QUOTA  ";
qryst=qryst+    " AND (fsc.OPERATOR IN ('IN', '=') AND fsc.criteriavalue = '"+hType+"')) ";
qryst=qryst+ " UNION ALL";
qryst=qryst+ " SELECT s.collseqid,g.currencycode,g.feehead,INITCAP (s.FEEHEADDESC) FEEHEADDESC,g.postingcompany postingcompany,g.glid,g.feeamount,";
qryst=qryst+ " 'Criteria Wise' feesource,feetype FROM feestructurecriteria g, feeheads s WHERE g.institutecode = '"+mInstituteCode+"' ";
qryst=qryst+ " AND g.companycode = '"+mCompanyCode+"' AND g.QUOTA = '"+mQuota+"' AND g.academicyear = '"+mAcademicYearCode+"' AND g.programcode = '"+mProgramCode+"' AND g.branchcode = '"+mBranchCode+"'";
qryst=qryst+ " AND g.semester = "+sem+" AND g.semestertype = '"+sType+"' /*AND g.currencycode = 'INR'*/ AND (g.OPERATOR IN ('IN', '=') AND g.criteriavalue = '"+hType+"')";
qryst=qryst+ " AND s.feehead = g.feehead AND s.institutecode = g.institutecode AND s.companycode = g.companycode AND NVL (g.feeamount, 0) > 0";
qryst=qryst+ " AND NVL (s.deactive, 'N') = 'N' AND g.feehead NOT IN (SELECT f.feehead FROM feeheads f WHERE f.institutecode = '"+mInstituteCode+"'";
qryst=qryst+ " AND f.companycode = '"+mCompanyCode+"' AND f.feetype = 'H' AND '"+host+"' = 'N') AND NOT EXISTS (SELECT NULL ";
qryst=qryst+    " FROM feestructureindividual fsi1 WHERE fsi1.institutecode = '"+mInstituteCode+"' AND fsi1.companycode = '"+mCompanyCode+"' AND fsi1.studentid = '"+mChkMemID+"'";
qryst=qryst+    " AND fsi1.academicyear = '"+mAcademicYearCode+"' AND fsi1.programcode = '"+mProgramCode+"' AND fsi1.branchcode = '"+mBranchCode+"' /*AND fsi1.currencycode = 'INR'*/";
qryst=qryst+    " AND NVL (fsi1.deactive, 'N') = 'N' AND fsi1.regcode = '"+cCode+"' AND fsi1.semester = g.semester";
qryst=qryst+    " AND fsi1.semestertype = g.semestertype AND fsi1.feehead = g.feehead)";
qryst=qryst+ " UNION ALL";
qryst=qryst+ " SELECT s.collseqid, fi.currencycode,fi.feehead,INITCAP (s.FEEHEADDESC) FEEHEADDESC,fi.postingcompany postingcompany,fi.glid,feeamount,";
qryst=qryst+ " 'Individual' feesource,feetype FROM feestructureindividual fi, feeheads s WHERE fi.institutecode = '"+mInstituteCode+"' ";
qryst=qryst+ " AND fi.companycode = '"+mCompanyCode+"' AND fi.studentid = '"+mChkMemID+"' AND fi.academicyear = '"+mAcademicYearCode+"' AND fi.programcode ='"+mProgramCode+"'";
qryst=qryst+ " AND fi.branchcode = '"+mBranchCode+"' AND NVL (fi.deactive, 'N') = 'N' AND fi.regcode = '"+cCode+"' AND fi.semester ="+sem+"";
qryst=qryst+ " AND fi.semestertype = '"+sType+"' /*AND fi.currencycode = 'INR'*/ AND s.feehead = fi.feehead AND s.institutecode = fi.institutecode";
qryst=qryst+ " AND s.companycode = fi.companycode AND NVL (s.deactive, 'N') = 'N' AND fi.feehead NOT IN (SELECT f.feehead FROM feeheads f";
qryst=qryst+ " WHERE f.institutecode = '"+mInstituteCode+"' AND f.companycode = '"+mCompanyCode+"' AND f.feetype = 'H' AND '"+host+"' = 'N') ";
//out.print(qryst);

rspfee=db.getRowset(qryst);


while (rspfee.next())//sType="",host="",hType="";
   {
//feeevents.add(rspfee.getString("FEEHEAD")+"$$$"+rspfee.getString("FEEHEADDESC")+ "@@@"+rspfee.getString("FEEAMOUNT"));
mFeeAmt+=rspfee.getDouble("FEEAMOUNT");
mCur=rspfee.getString("CURRENCYCODE");
}

/*--------- Student special Approval Fee-------------------------*/
 qryssa ="  Select Sum(nvl(ApprovalAmount,0)) ApprovalAmount 	From	 StudentSpecialApproval ";
 qryssa =qryssa+" Where InstituteCode	= '"+mInstituteCode+"' And     CompanyCode ='"+mCompanyCode+"' ";
 qryssa =qryssa+" And ForSemester = "+sem+" And SemesterType = '"+sType+"' ";
 qryssa =qryssa+" And StudentID = '"+mChkMemID+"' And RegCode ='"+cCode+"' And Trunc(DateOfApproval)<= Trunc(Sysdate) ";
 qryssa =qryssa+" And nvl(Trunc(ApprovalUpTo),Trunc(Sysdate)) >= Trunc(Sysdate) And  Nvl(Status,'P')='P' ";
 qryssa =qryssa+" And Feehead Not in (Select F.FeeHead From FeeHeads f Where f.InstituteCode = '"+mInstituteCode+"' ";
 qryssa =qryssa+    " And  F.CompanyCode    = '"+mCompanyCode+"' And f.Feetype ='H' And '"+host+"' = 'N' ) ";
rsamtt=db.getRowset(qryssa);
while(rsamtt.next()){
mSsaAmt+=rsamtt.getDouble("ApprovalAmount");
//out.print(mSsaAmt);
}
/*--------- Discount Fee-------------------------*/
qrydis = " Select 	Sum(nvl(DiscountAmount,0)) DisAmount From StudentFeeDiscount Where	InstituteCode = '"+mInstituteCode+"' ";
qrydis =qrydis+ " And CompanyCode ='"+mCompanyCode+"' And AcademicYear	= '"+mAcademicYearCode+"' And	Nvl(ProgramCode,'*')= Nvl('"+mProgramCode+"','*') ";
qrydis =qrydis+ " And Nvl(BranchCode,'*')	= Nvl('"+mBranchCode+"','*')And StudentID	= '"+mChkMemID+"' ";
qrydis =qrydis+ " And RegCode =	'"+cCode+"' And Semester = "+sem+" And SemesterType	= '"+sType+"'  ";
qrydis =qrydis+ " And Feehead Not in (Select F.FeeHead From FeeHeads f Where f.InstituteCode = '"+mInstituteCode+"' ";
qrydis =qrydis+ "    And  F.CompanyCode = '"+mCompanyCode+"' And f.Feetype = 'H'  And '"+host+"' = 'N'  ) ";
rsdis=db.getRowset(qrydis);
while(rsdis.next()) {
mDisAmt+=rsdis.getDouble("DisAmount");
//out.print("DiscountFee");
}




/*--------- Refund Amount-------------------------*/

qryr =" select sum(nvl(x.PaidAmount,0)) PaidAmount from (Select Sum(Nvl(d.FeeCurrencyAmount,0)) PaidAmount From FeeTransactionDetail d, FeeTransaction m,FeeHeads h ";
qryr =qryr+" Where m.InstituteCode 	= '"+mInstituteCode+"' And m.CompanyCode = '"+mCompanyCode+"' And	m.StudentID	='"+mChkMemID+"'";
qryr =qryr+" And m.AcademicYear	= '"+mAcademicYearCode+"' And m.Quota	='"+mQuota+"' And m.ForRegCode = '"+cCode+"' ANd	m.CompanyCode = d.CompanyCode";
qryr =qryr+" And m.TransactionType	='P' And m.PRNO	=d.PRNO And	m.Transactiontype =	d.TransactionType And m.FinancialYear = d.FinancialYear";
qryr =qryr+" And m.instituteCode =d.InstituteCode And D.Feehead	= h.FeeHead And	d.CompanyCode = h.Companycode And 	h.FeeType Not in ('A','V')";
qryr =qryr+" And nvl(d.RefundType,'*') <> 'R'And Nvl(d.FeePaidSemester,0)= Nvl("+sem+",0)	And	Nvl(d.SemesterType,'*')= Nvl('"+sType+"','*')";
qryr =qryr+" And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE fc.Prno = d.prno And fc.Slno = d.Slno";
qryr =qryr+" And fc.CompanyCode = d.CompanyCode And fc.FinancialYear = d.Financialyear And fc.TransactionType = d.TransactionType";
qryr =qryr+" And InstituteCode = d.InstituteCode AND fc.feehead = d.Feehead And Fc.RecvCurrencyCode != D.FeeCurrencyCode AND ConversionRateFlag = 'N')";
qryr =qryr+" Union All  ";
qryr =qryr+" Select Sum(Nvl(d.FeeCurrencyAmount,0)) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h	Where m.InstituteCode 	='"+mInstituteCode+"'";
qryr =qryr+" And m.CompanyCode = '"+mCompanyCode+"' And	m.FromStudentID	= '"+mChkMemID+"' And m.FromAcademicYear	= '"+mAcademicYearCode+"'";
qryr =qryr+" And Nvl(m.FromProgramCode,'*')= Nvl('"+mProgramCode+"','*') And Nvl(m.FromBranchCode,'*')	= Nvl('"+mBranchCode+"','*')";
qryr =qryr+" And  m.FromQuota = '"+mQuota+"'	And	m.FromRegCode =	'"+cCode+"' ANd m.CompanyCode = d.CompanyCode 	And   m.InstituteCode   = d.InstituteCode";
qryr =qryr+" And  m.FinancialYear = d.FinancialYear And m.TNO = d.TNO 	And D.FromFeehead =	h.FeeHead And d.CompanyCode     = h.Companycode  ";
qryr =qryr+" And h.FeeType	Not In ('A','V')	And Nvl(d.FromSemester,0)= Nvl("+sem+",0)	And	Nvl(d.FromSemesterType,'*') = Nvl('"+sType+"','*')";
qryr =qryr+" And m.DocMode != 'C' And d.FromCurrencyCode = d.ToCurrencyCode	AND NOT EXISTS (SELECT null FROM FeeTransferDetailFC fc WHERE ";
qryr =qryr+" fc.Tno = d.Tno 	And fc.Slno = d.slno AND fc.FromFeehead = d.FromFeehead And fc.CompanyCode = d.CompanyCode";
qryr =qryr+" And fc.InstituteCode = d.InstituteCode	And fc.FinancialYear = d.FinancialYear AND ConversionRateFlag = 'N'	And Fc.RecvCurrencyCode != D.FromCurrencyCode)";
qryr =qryr+" Union All ";
qryr =qryr+" Select Sum(Nvl(Fc.RecvCurrencyAmount,0)) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h,FeetransferDetailFc Fc";
qryr =qryr+" Where m.InstituteCode 	= '"+mInstituteCode+"' And 	m.CompanyCode = '"+mCompanyCode+"'	And	m.FromStudentID	= '"+mChkMemID+"'";
qryr =qryr+" And m.FromAcademicYear	= '"+mAcademicYearCode+"'	And		Nvl(m.FromProgramCode,'*')		= Nvl('"+mProgramCode+"','*')";
qryr =qryr+" And Nvl(m.FromBranchCode,'*') = Nvl('"+mBranchCode+"','*') And  m.FromQuota =	'"+mQuota+"' 	And	m.FromRegCode =	'"+cCode+"'";
qryr =qryr+" ANd m.CompanyCode  = d.CompanyCode And   m.InstituteCode  = d.InstituteCode	And   m.FinancialYear =	d.FinancialYear";
qryr =qryr+" And m.TNO = d.TNO 	And 	D.FromFeehead =	h.FeeHead And d.CompanyCode = h.Companycode	And h.FeeType Not In ('A','V')";
qryr =qryr+" And Nvl(d.FromSemester,0) = Nvl("+sem+",0) And Nvl(d.FromSemesterType,'*')= Nvl('"+sType+"','*') And m.DocMode != 'C'";
qryr =qryr+" And d.FromCurrencyCode <> d.ToCurrencyCode	AND fc.Tno = d.Tno 	And fc.Slno = d.slno And fc.CompanyCode = d.CompanyCode";
qryr =qryr+" And fc.InstituteCode = d.InstituteCode	And fc.FinancialYear = d.FinancialYear)X";
//out.print(qryr);
rsref=db.getRowset(qryr);
while(rsref.next()){
mRefAmt+=rsref.getDouble("PaidAmount");
//out.print("refund"+mRefAmt);
}
/*--------- Advance Fee-------------------------
qryad =" Select Sum(Nvl(d.FeeAmount,0)) AdvanceAmount From FeeTransactionDetail d, FeeTransaction m,FeeHeads h Where m.InstituteCode 	= '"+mInstituteCode+"' ";
qryad =qryad+" And m.CompanyCode = '"+mCompanyCode+"' And 	m.StudentID	='"+mChkMemID+"' And	m.AcademicYear= '"+mAcademicYearCode+"' And   m.Quota =	'GENERAL' ";
qryad =qryad+" And m.ForRegCode	= '"+cCode+"' ANd m.CompanyCode = d.CompanyCode And m.TransactionType='R'And m.PRNO = d.PRNO ";
qryad =qryad+" And m.TransactionType = d.TransactionType And m.InstituteCode = d.InstituteCode And m.FinancialYear = d.FinancialYear ";
qryad =qryad+" And d.FeeHead	=h.FeeHead And d.CompanyCode = h.Companycode And h.Feetype in ('A','V')And Nvl(d.FeePaidSemester,0)		= Nvl("+sem+",0) ";
qryad =qryad+" And Nvl(d.SemesterType,'*')=	Nvl('"+sType+"','*')And	m.DocMode != 'C'AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE ";
qryad =qryad+" fc.Prno = d.prno	And fc.Slno = d.Slno AND fc.feehead = d.Feehead And fc.FinancialYear = d.FinancialYear And fc.InstituteCode = d.InstituteCode ";
qryad =qryad+" And fc.CompanyCode = d.CompanyCode And fc.Transactiontype = d.TransactionType And Fc.RecvCurrencyCode != D.FeeCurrencyCode AND ConversionRateFlag = 'N') ";
qryad =qryad+" Union All";
qryad =qryad+" Select Sum(Nvl(d.FeeAmount,0)) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h Where m.InstituteCode = '"+mInstituteCode+"' ";
qryad =qryad+" And m.CompanyCode ='"+mCompanyCode+"' And m.StudentID =	'"+mChkMemID+"' And m.AcademicYear= '"+mAcademicYearCode+"' And   m.Quota ='GENERAL' ";
qryad =qryad+" And m.ForRegCode	='"+cCode+"' ANd m.CompanyCode  = d.CompanyCode And   m.InstituteCode = d.InstituteCode And m.FinancialYear		=	d.FinancialYear ";
qryad =qryad+" And m.TNO =d.TNO	And	D.ToFeeheadOrGlID  =h.FeeHead And d.CompanyCode = h.Companycode And	h.FeeType In ('A','V') ";
qryad =qryad+" And Nvl(d.Semester,0) = Nvl("+sem+",0)	And	Nvl(d.SemesterType,'*')	=Nvl('"+sType+"','*')And	m.DocMode != 'C' ";
qryad =qryad+" AND NOT EXISTS (SELECT 'Y' FROM FeeTransferDetailFC fc WHERE	fc.Tno = d.Tno And fc.Slno = d.slno AND fc.Tofeehead = d.ToFeeheadOrGlID ";
qryad =qryad+" And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode And fc.FinancialYear = d.FinancialYear ";
qryad =qryad+" AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.ToCurrencyCode) ";
//mAdvAmt rsadv
rsadv=db.getRowset(qryad);
while(rsadv.next()){

mAdvAmt+=rsadv.getDouble("AdvanceAmount");
out.print("AdvanceFee");
}
    /*--------- Advance Fee Refund -------------------------
qryadr= "Select Sum(Nvl(d.FeeAmount,0)) AdvanceAmountRefund	From FeeTransactionDetail d, FeeTransaction m,FeeHeads h ";
qryadr =qryadr+=" Where m.InstituteCode 	= '"+mInstituteCode+"'	And m.CompanyCode = '"+mCompanyCode+"' And	m.StudentID	='"+mChkMemID+"' ";
qryadr =qryadr+=" And	m.AcademicYear = '"+mAcademicYearCode+"' And m.Quota ='GENERAL' And	m.ForRegCode =	'"+cCode+"' ANd m.CompanyCode = d.CompanyCode ";
qryadr =qryadr+=" And	m.TransactionType ='P' And m.PRNO =d.PRNO And m.InstituteCode = d.InstituteCode And m.Transactiontype = d.TransactionType ";
qryadr =qryadr+=" And	m.FinancialYear = d.FinancialYear And d.FeeHead	=h.FeeHead And d.CompanyCode = h.Companycode And h.Feetype in ('A','V') ";
qryadr =qryadr+=" And Nvl(d.FeePaidSemester,0)= Nvl("+sem+",0) And Nvl(d.SemesterType,'*')	=Nvl('"+sType+"','*')	And	m.DocMode != 'C' ";
qryadr =qryadr+=" AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE fc.Prno = d.prno And fc.Slno = d.slno AND fc.feehead = d.Feehead ";
qryadr =qryadr+=" And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode And fc.FinancialYear = d.FinancialYear And TransactionType = d.Transactiontype ";
qryadr =qryadr+=" And Fc.RecvCurrencyCode != D.FeeCurrencyCode AND ConversionRateFlag = 'N') ";
qryadr =qryadr+=" Union All ";
qryadr =qryadr+=" Select Sum(Nvl(d.FeeAmount,0)) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h Where m.InstituteCode = '"+mInstituteCode+"' ";
qryadr =qryadr+=" And m.CompanyCode = '"+mCompanyCode+"' And	m.FromStudentID	='"+mChkMemID+"'	And	m.FromAcademicYear = '"+mAcademicYearCode+"' ";
qryadr =qryadr+=" And m.FROMQuota	= 'GENERAL' And m.FromRegCode = '"+cCode+"' ANd m.CompanyCode = d.CompanyCode And m.InstituteCode = d.InstituteCode ";
qryadr =qryadr+=" And m.FinancialYear	=	d.FinancialYear	And	m.TNO = d.TNO And D.FromFeehead	=h.FeeHead And d.CompanyCode  = h.Companycode ";
qryadr =qryadr+=" And h.FeeType In ('A','V')And Nvl(d.FromSemester,0)= Nvl("+sem+",0)And	Nvl(d.FromSemesterType,'*')=Nvl('"+sType+"','*') ";
qryadr =qryadr+=" And	m.DocMode != 'C' And d.FromCurrencyCode = d.ToCurrencyCode AND NOT EXISTS (SELECT 'Y' FROM FeeTransferDetailFC fc WHERE ";
qryadr =qryadr+=" fc.Tno = d.Tno 	And fc.Slno = d.slno AND fc.FromFeehead = d.FromFeehead And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode ";
qryadr =qryadr+=" And fc.FinancialYear = d.FinancialYear AND ConversionRateFlag = 'N'And Fc.RecvCurrencyCode != D.FromCurrencyCode) ";
qryadr =qryadr+=" Union All ";
qryadr =qryadr+=" Select Sum(Nvl(Fc.RecvCurrencyAmount,0)) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h,FeetransferDetailFc Fc ";
qryadr =qryadr+=" Where m.InstituteCode = '"+mInstituteCode+"' And m.CompanyCode = '"+mCompanyCode+"' And m.FromStudentID ='"+mChkMemID+"' ";
qryadr =qryadr+=" And	m.FromAcademicYear= '"+mAcademicYearCode+"' And m.FromQuota ='GENERAL' And m.FromRegCode ='"+cCode+"' ANd m.CompanyCode= d.CompanyCode ";
qryadr =qryadr+=" And m.InstituteCode  = d.InstituteCode And m.FinancialYear =	d.FinancialYear	And	m.TNO =	d.TNO And D.FromFeehead	=h.FeeHead ";
qryadr =qryadr+=" And		d.CompanyCode     = h.Companycode And h.FeeType	In ('A','V')	And Nvl(d.FromSemester,0)		= Nvl("+sem+",0) ";
qryadr =qryadr+=" And	Nvl(d.FromSemesterType,'*')	=Nvl('"+sType+"','*')	And	m.DocMode != 'C'And d.FromCurrencyCode <> d.ToCurrencyCode ";
qryadr =qryadr+=" AND fc.Tno = d.Tno 	And fc.Slno = d.slno And fc.CompanyCode = d.CompanyCode	And fc.InstituteCode = d.InstituteCode ";
qryadr =qryadr+=" And fc.FinancialYear = d.FinancialYear ";
//mAdvRef rsrad
//out.print(qryadr);
rsadv=db.getRowset(qryadr);
while(rsadv.next()){

mAdvRef+=rsadv.getDouble("AdvanceAmountRefund");

out.print("FEEREFUND");
}
*/
mNetPaidAmt=mPaidAmt-mRefAmt;
mDueAmt=mFeeAmt-(mDisAmt+mNetPaidAmt+mSsaAmt );
%>
	<tr>
	<td align=left><font face=arial size=2 ><%=sem+"("+sType+")"%>&nbsp; &nbsp;</td>
	<td align=center><font face=arial size=2 ><%=mCur%>&nbsp; &nbsp;</td>
    <td align=right><font face=arial size=2  ><A target=_new href="StudRegFeeDetail.jsp?SEM=<%=sem%>&amp;CC=<%=mCur%>&amp;SEMTYPE=<%=sType%>&amp;REGCODE=<%=cCode%>&amp;HOSTEL=<%=host%>&amp;HTYPE=<%=hType%>&amp;Quota=<%=mQuota%>"><%=mFeeAmt%></A>&nbsp;&nbsp;</td>
 <!--   <td align=center><font face=arial size=2 ><%=mFeeAmt%>&nbsp; &nbsp;</td> -->
	<td align=right><font face=arial size=2  ><%=mDisAmt%>&nbsp; &nbsp;</td>
	<td align=right><font face=arial size=2  ><%=mNetPaidAmt%> &nbsp; &nbsp;</td>
    <!--<td align=right><font face=arial size=2 ><%=0%>&nbsp; &nbsp;</td> -->
	<td align=right><font face=arial size=2  ><%=mDueAmt%>&nbsp; &nbsp;</td>
	</tr>
	<%
mTotFeeAmt+=mFeeAmt;
mTotDisAmt+=mDisAmt ;
mTotPaidAmt+=mNetPaidAmt ;
mTotDueAmt+=mDueAmt;
}





 //out.print(qry);
//double mDueAmt=0;
//double mTotFeeAmt=0,mTotDisAmt=0,mTotPaidAmt=0,mTotRefundAmt=0,mTotDueAmt=0;

%>

	<tr bgcolor=white >
	<td colspan=2 align=right><b>Total Amount</b>&nbsp; &nbsp;</td>
	<td align=right><b><%=mTotFeeAmt %></b>&nbsp; &nbsp;</td>
	<td align=right><b><%=mTotDisAmt%></b>&nbsp; &nbsp;</td>
	<td align=right><b><%=mTotPaidAmt%></b>&nbsp; &nbsp;</td>
	<!-- <td align=right><b><%=20%></b>&nbsp; &nbsp;</td> -->
	<td align=right><b><%=mTotDueAmt%></b>&nbsp; &nbsp;</td>
	</tr>


<tr><td colspan=7><marquee scrolldelay=250 behavior=alternate>Click on Fee amount to view detail..</marquee></td></tr>
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

</body>
</html>
