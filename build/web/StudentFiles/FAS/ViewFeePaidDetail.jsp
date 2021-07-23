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
 <TITLE>#### <%=mHead%> [ View Academic Fee detail  ] </TITLE>

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
String mMS="";
String mInstituteCode="",mHostel="";
String mStudID="",mQuota="",mSem="",mAcadYear="",mProCode="",mBranCode="",mSemType="",mCat="",mSemFeeTranDet="";
double Total=0.0,mPaidFee=0.0,mProgFee=0.0	;

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


qry="SELECT  nvl(a.studentname,' ')studentname,nvl(a.enrollmentno,' ')enrollmentno, nvl(a.studentid,' ')studentid,a.semester semester,a.QUOTA QUOTA ,nvl(a.academicyear,' ') academicyear, nvl(a.programcode,' ') programcode, nvl(a.branchcode,' ') branchcode, NVL(a.CATEGORY,' ') CATEGORY FROM studentmaster a  WHERE a.institutecode = '"+mInstituteCode+"'       AND a.enrollmentno ='"+mDMemberCode+"' ";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next() )
	{


		mStudID=rs.getString("studentid");		
		mQuota=rs.getString("QUOTA");
		mSem=rs.getString("semester");
		mAcadYear=rs.getString("academicyear");
		mProCode=rs.getString("programcode");
		mBranCode=rs.getString("branchcode");
	
		mCat=rs.getString("CATEGORY");
		%>
			<form name=frm1 method=Post>
			<TABLE align=center width="100%" rules=group cellspacing=1 cellpadding=3>
			<tr><td  align=center colspan=2>
			<font size=4 face=arial color=#a52a2a><b>View Program Fee Details</b> </font>
			</td></tr>
			
			</table>
	<TABLE align=center width="90%"  rules=group cellspacing=2 cellpadding=3>
			<tr><td  align=left colspan=4>
			<font size=3 face=arial color=#a52a2a><u><b>Student Details </b></u> </font>
			</td></tr>
			<tr> 
			 <td > <FONT face=Verdana size=2 color=darkmaroon><STRONG>Name(Enrolment No.) </STRONG></FONT></td>
			 <td nowrap colspan=2> <FONT face=verdana size=2><B>: <%=rs.getString ("StudentName")%>(<%=rs.getString ("enrollmentno")%>)</b></FONT>&nbsp;&nbsp; </FONT></td>
			 </TR>

			<tr><td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Academic Year : </STRONG><font color=black><b><%=mAcadYear%></b></font></FONT>
			</td>
			<td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Program : </STRONG><font color=black><b><%=mProCode%></b></font></FONT>
			</td>
			<td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Branch : </STRONG><font color=black><b><%=mBranCode%></b></font></FONT>
			</td></tr>
			<tr><td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Quota : </STRONG><font color=black><b><%=mQuota%></b></font></FONT>
			</td><td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Current Sem : </STRONG><font color=black><b><%=mSem%></b></font></FONT>
			</td>
			</tr>
			</table>
	
	
		<TABLE align=center width="90%" rules=group cellspacing=1 cellpadding=3>
			<tr><td  align=left colspan=2>
			<font size=3 face=arial color=#a52a2a><u><b>Program Fee Details :</b></u> </font>
			</td></tr>
			
			</table>
			<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=2 cellPadding=2 width="90%" border=1 >
			<thead>
			<tr bgcolor="#ff8c00" >
		
			<td><b><font color="white" size=2>Semester & Sem Type</font></b></td>
			<td><b><font color="white" size=2>Quota</font></b></td>
			<td><b><font color="white" size=2>Program Fee</font></b></td>
			<td><b><font color="white" size=2> Paid</font></b></td>
		<td><b><font color="white" size=2> Dues</font></b></td> 
		
			</tr>
			</thead>
			<tbody> 
			<tr bgcolor=white>
		<%

	qry="SELECT DISTINCT a.semester semester, nvl(a.semestertype,' ')semestertype, NVL (a.feespaid, 'N') feespaid, NVL (a.hostelallow, 'N') hostelallow, nvl(a.regcode,' ') regcode,nvl(b.CURRENCYCODE,' ') CURRENCYCODE      FROM v#sfmstudentregistration A, FeeStructure b          WHERE a.studentid = '"+mStudID+"' AND a.institutecode = '"+mInstituteCode+"'             AND a.companycode = '"+mCompanyCode+"'    AND a.academicyear = '"+mAcadYear+"'             AND a.programcode = '"+mProCode+"'            AND a.branchcode = '"+mBranCode+"'        and b.QUOTA='"+mQuota+"'            and a.INSTITUTECODE=b.INSTITUTECODE            and a.ACADEMICYEAR=b.ACADEMICYEAR            and  a.PROGRAMCODE=b.PROGRAMCODE            and a.BRANCHCODE=b.BRANCHCODE            and a.SEMESTER=b.SEMESTER            and a.SEMESTERTYPE=b.SEMESTERTYPE                   ORDER BY semester";
		rs=db.getRowset(qry);
		while(rs.next())
		{



			mHostel=rs.getString("HOSTELALLOW");

				qry1="SELECT SUM(DECODE(transactiontype,'R',FEEAMOUNT,0)+DECODE(transactiontype,'TIN',FEEAMOUNT,0))-SUM(DECODE(transactiontype,'P',FEEAMOUNT,0)+DECODE(transactiontype,'TOUT',FEEAMOUNT,0))Paidfeeamount FROM (SELECT d.feeamount feeamount, m.transactiontype transactiontype  FROM feetransaction m, feetransactiondetail d, feeheads h WHERE m.institutecode =  '"+mInstituteCode+"'     AND m.companycode = '"+mCompanyCode+"'   AND m.academicyear = '"+mAcadYear+"'  AND m.studentid =  '"+mStudID+"'   AND m.forregcode = '"+rs.getString("regcode")+"'   AND d.feepaidsemester = '"+rs.getString("Semester")+"'   AND d.semestertype = '"+rs.getString("semestertype")+"'   AND m.companycode = d.companycode   AND m.institutecode = d.institutecode   AND m.financialyear = d.financialyear   AND m.transactiontype = d.transactiontype   AND m.prno = d.prno   AND d.feehead = h.feehead   AND d.companycode = h.companycode   AND m.docmode != 'C'         UNION ALL SELECT   d.feeamount feeamount, 'TOUT' transactiontype            FROM feetransfer m, feetransferhead d, feeheads h   WHERE m.institutecode = '"+mInstituteCode+"'       AND m.companycode ='"+mCompanyCode+"'      AND m.fromacademicyear =  '"+mAcadYear+"'     AND m.fromstudentid =   '"+mStudID+"'     AND m.fromregcode = '"+rs.getString("regcode")+"'     AND d.fromsemester ='"+rs.getString("Semester")+"' AND d.fromsemestertype ='"+rs.getString("semestertype")+"'     AND m.companycode = d.companycode     AND m.institutecode = d.institutecode     AND m.financialyear = d.financialyear     AND m.tno = d.tno     AND m.tdate = d.tdate     AND d.fromfeehead = h.feehead     AND d.companycode = h.companycode     AND m.docmode != 'C'     AND d.fromcurrencycode = d.tocurrencycode UNION ALL SELECT  d.feeamount feeamount, 'TOUT' transactiontype   FROM feetransfer m, feetransferhead d, feeheads h, feetransferdetailfc fc   WHERE m.institutecode = '"+mInstituteCode+"'       AND m.companycode ='"+mCompanyCode+"'      AND m.fromacademicyear = '"+mAcadYear+"'     AND m.fromstudentid = '"+mStudID+"'     AND m.fromregcode = '"+rs.getString("regcode")+"'     AND d.fromsemester ='"+rs.getString("Semester")+"' AND d.fromsemestertype ='"+rs.getString("semestertype")+"'     AND m.companycode = d.companycode     AND m.institutecode = d.institutecode     AND m.financialyear = d.financialyear     AND m.tno = d.tno     AND m.tdate = d.tdate     AND d.fromfeehead = h.feehead     AND d.companycode = h.companycode     AND m.docmode != 'C'     AND d.fromcurrencycode <> d.tocurrencycode     AND fc.companycode = d.companycode     AND fc.financialyear = d.financialyear     AND fc.institutecode = d.institutecode     AND fc.tno = d.tno     AND fc.slno = d.slno UNION ALL SELECT   d.feeamount feeamount, 'TIN' transactiontype            FROM feetransfer m, feetransferhead d, feeheads h   WHERE m.institutecode = '"+mInstituteCode+"'       AND m.companycode ='"+mCompanyCode+"'      AND m.academicyear = '"+mAcadYear+"'     AND m.studentid = '"+mStudID+"'     AND m.forregcode = '"+rs.getString("regcode")+"'     AND d.semester = '"+rs.getString("Semester")+"'     AND d.semestertype ='"+rs.getString("semestertype")+"'     AND m.companycode = d.companycode     AND m.institutecode = d.institutecode     AND m.financialyear = d.financialyear     AND m.tno = d.tno     AND m.tdate = d.tdate     AND d.tofeeheadorglid = h.feehead     AND d.companycode = h.companycode     AND m.docmode != 'C' )X";
			//out.print(qry1);
			rs1=db.getRowset(qry1);	
				if(rs1.next())
					mPaidFee=rs1.getDouble("Paidfeeamount");

			qry2="select sum(x.feeamount)ProgFee from ( select a.feeamount feeamount from   feestructureindividual a,feeheads b    WHERE a.institutecode = '"+mInstituteCode+"'   AND a.companycode = '"+mCompanyCode+"'     AND a.academicyear ='"+mAcadYear+"'   AND a.programcode =  '"+mProCode+"'   AND a.branchcode =  '"+mBranCode+"'    AND a.semestertype = '"+rs.getString("semestertype")+"'   AND a.semester = '"+rs.getString("Semester")+"'   and a.STUDENTID= '"+mStudID+"'  and a.FEEHEAD=b.FEEHEAD   and a.INSTITUTECODE=b.INSTITUTECODE   and a.COMPANYCODE=b.COMPANYCODE   AND NVL (a.deactive, 'N') = 'N'    AND NVL (b.deactive, 'N') = 'N'      ANd (b.Feetype in (select Feetype From feeheads where 'Y' = '"+mHostel+"')     Or b.Feetype not in (select Feetype From feeheads where 'N' ='"+mHostel+"' ANd Feetype = 'H'))      union SELECT  a.feeamount feeamount     FROM feestructure a,feeheads b WHERE a.institutecode = '"+mInstituteCode+"'   AND a.companycode = '"+mCompanyCode+"'     AND a.academicyear = '"+mAcadYear+"'   AND a.programcode =  '"+mProCode+"'   AND a.branchcode =  '"+mBranCode+"'    AND a.QUOTA =  '"+mQuota+"'   AND a.semestertype = '"+rs.getString("semestertype")+"'   AND a.semester = '"+rs.getString("Semester")+"' and a.FEEHEAD=b.FEEHEAD   and a.INSTITUTECODE=b.INSTITUTECODE   and a.COMPANYCODE=b.COMPANYCODE   AND NVL (a.deactive, 'N') = 'N'    AND NVL (b.deactive, 'N') = 'N'   AND NVL (a.deactive, 'N') = 'N'   ANd (b.Feetype in (select Feetype From feeheads where 'Y' ='"+mHostel+"')     Or b.Feetype not in (select Feetype From feeheads where 'N' ='"+mHostel+"' ANd Feetype = 'H')))x";
			rs2=db.getRowset(qry2);	
			//out.print(qry2);
				if(rs2.next())
					mProgFee=rs2.getDouble("ProgFee");
			
			
			
			
			
			%>
				<tr bgcolor=white >
		
				<td><a href="ViewFeeDetail.jsp?academicyear=<%=mAcadYear%>&amp;programcode=<%=mProCode%>&amp;branchcode=<%=mBranCode%>&amp;semestertype=<%=rs.getString("semestertype")%>&amp;semester=<%=rs.getString("semester")%>&amp;STUDENTID=<%=mStudID%>&amp;Quota=<%=mQuota%>&amp;Hostel=<%=mHostel%>" title="View Detail" target=_NEW >  <b>Sem - <%=rs.getString("semester")%> ( <%=rs.getString("semestertype")%> )</b> </a></td>
				<td><b><%=mQuota%></b></td>
				
				<td><b> <%=rs.getString("CURRENCYCODE")%>  <%=mProgFee%></b></td>

				<td><b> <%=rs.getString("CURRENCYCODE")%> <%=mPaidFee%></b></td>
			<td><b><%=mProgFee-mPaidFee%></b></td>
				
				</tr>
			<%
					
		}
		%>
		 
		  </tr>
		</tbody>
		</TABLE>
		</form>


<%
	}
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
