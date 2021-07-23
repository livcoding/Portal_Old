<%-- 
    Document   : StudentFeeSlip
    Created on : Jun 17, 2011, 12:13:14 PM
    Author     : ankur.verma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
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
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
 <TITLE>#### <%=mHead%> [ View Academic Fee detail  ] </TITLE>
    <script language="JavaScript" type ="text/javascript">
	<!--
	  if (top != self) top.document.title = document.title;
	-->
</script>


<script language="javascript" >
function validate()
{

//alert("sdfsadfsfsfs"+document.form1.NoDuesAmt.value);
    if(document.form1.NoDuesAmt.value=="Y")
                       {
                           alert("No Dues for you !");
                           return false;
                       }


    if(document.form1.regallow.value=="Y")
                       {
                           alert("Please Allow Registration for Semester ! ");
                           return false;
                       }

if(document.form1.feestructure.value=="Y")
                       {
                           alert("Please save Feestructure for Semester ! ");
                           return false;
                       }
}
</script>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


<style type="text/css">
.h2 {
font: 1.0em Georgia, "Times New Roman", Times, serif;
color: #3F0707;
background-color: #FFCF83;
border: 1px solid #D98242;
padding: 2px 0 2px 9px;
margin-bottom: 9px;
letter-spacing: 1px;
}
.labelcell {    
 font: 12px Verdana, Geneva, Arial, Helvetica, sans-serif;    
 font-size:x-medium;
 color: #3F0707;    
 font-weight:Normal;
}   
</style>
</head>


<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet RsFee=null,RsChk=null;
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
String mMaxSemester="";
String mSCode="",qry1="",mChkMemID="";
ResultSet rs=null;
String mRegCode="",QryRegCode="";
String msem="",mchk="",mInst ="",minst ="";
//out.print(qry);
String mSem1="",mSemType="",mHostel="",mQuota="",mEnrollment="";
ResultSet rs1=null;
	String mexamcode ="" , QryExam="";
int slno=0;
try
{
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table align=center>
<tr>
<TD align=center class="h2">
JIIT, NOIDA- PAYMENT OF FEE 
</td>
</tr>

<tr>
<TD align=center class="h2">
Generate Fee Payment Pay In Slip - Axis Bank&nbsp;  </TD>
</td></tr>
</TABLE>
<table cellpadding=5 cellspacing=0 align=center rules=groups border=1 width="48%" borderColor="#D98242" >
<tr>
<td  class="labelcell">&nbsp;
      Institute Code
</td>   
<td nowrap align=left>
<%
                        try {
qry="select INSTITUTECODE InstCode  from institutemaster where INSTITUTECODE in ('JIIT','J128')  ";
         rs=db.getRowset(qry);                           

                            if (request.getParameter("x") == null) {
                    %>
                    <select name=InstCode tabindex="1" id="InstCode" >
                        <%
                            while (rs.next()) {
                                mInst = rs.getString("InstCode");
                                if (mInst.equals("")) {
                                    minst = mInst;
                                }
                        %>
                        <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                        <%
                            }
                        %>
                    </select>
                    <%
                        } else {
                    %>
                    <select name=InstCode tabindex="1" id="InstCode" >
                        <%
                            while (rs.next()) {
                                mInst = rs.getString("InstCode");
                                if (mInst.equals(request.getParameter("InstCode").toString().trim())) {
                        %>
                        <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                        <%
                            } else {
                        %>
                        <OPTION Value =<%=mInst%>><%=mInst%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <%
                            }
                        } catch (Exception e) {
                            //out.println(e.getMessage());
                        }
%>
    </td>
</tr>

<tr>
<td class="labelcell">
&nbsp; 
Registration Code
</td>
<td  align=left>
<%

		qry="SELECT DISTINCT EXAMCODE FROM   exammaster where institutecode in ('JIIT','J128')  and NVL(FEEPAYINSLIP,'N')='Y' ";
		//out.print(qry);
  

  rs=db.getRowset(qry);
//out.print(qry);
%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 140px">	
<%   	
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mexamcode=rs.getString("examcode");
			if(QryExam.equals(""))
 			{			
			QryExam=mexamcode;
			%>
			<OPTION Selected Value =<%=mexamcode%>><%=mexamcode%></option>
			<%
			}
			else
			{
		%>
			<option value=<%=mexamcode%>><%=mexamcode%></option>
		<%
			}
		}
	}
	else
	{
		while(rs.next())
	  {
	   mexamcode=rs.getString("examcode");			
	   if(mexamcode.equals(request.getParameter("exam").toString().trim()))
	   {	
			QryExam=mexamcode;
	   %>
	    <option selected value=<%=mexamcode%>><%=mexamcode%></option>
	 	 <%
	   }	
     else
     {		
	   %>
	    <option  value=<%=mexamcode%>><%=mexamcode%></option>
	   <%
	   }	
	  }
  }
 %>
 </select>
</td>
</tr>

<tr>
<td class="labelcell">&nbsp;
Enrollment No.  
</td>
<td align=left>
 <INPUT TYPE="text" NAME="EnrollmentNo" ID="EnrollmentNo" size=17 maxlength=20>
</td>
</tr>
<tr>
    <td  align=right >
        <input type="submit" value="Submit" >
    </td>
	<td align=right>
	<a href="axisbank-feepaymentinstn-evensem-Jan2013.doc" target="NEW" >Instruction for Pay-In-Slip</a>
	</td>
 </tr>


</table>
<br>
<table cellpadding="0" align="center" cellspacing="0" border="2"  borderColor="#D98242">
 <tr>
     <td align="left" >
     <font face="verdana" size="2">
      * Take a print out of 'Pay In Slip' and visit to the nearest axis bank branch  for fee payment.
     </font>
     </td>
     </tr>


 <tr>
     <td align="left" >
     <font face="verdana" size="2">
         * In case of fees is not showing / available in your login, kindly contact deputy registrar on mail ID mihirk.jha@jiit.ac.in or deepak.gupta@jiit.ac.in.
     </font>
     </td>
     </tr>
</table>
</form>
<br>
    <form name="form1" id="form1" method="post" action="AxisBankPayInSlipPDF.jsp">
<%
if(request.getParameter("x")!=null)
   {
String RegCode=request.getParameter("exam");
    // String path=request.getContextPath();
    //s out.print(path);
String mEnrollmentno="";


mInst = request.getParameter("InstCode");
mEnrollment= request.getParameter("EnrollmentNo");



%>
 <input type="hidden" name="InstCode" id="InstCode" value="<%=mInst%>" >
<%


	int mValid=0;

	for(int ii=0;ii<mEnrollment.length();ii++)
	{

		if (mEnrollment.charAt(ii)>=65 && mEnrollment.charAt(ii)<=90)
		{
		  mValid=1;	
		}
		else if (mEnrollment.charAt(ii)>=97 && mEnrollment.charAt(ii)<=122)
		{
		  mValid=1;	
		}

		else if (mEnrollment.charAt(ii)>=48 && mEnrollment.charAt(ii)<=57)
		{
		  mValid=1;	
		}
		else
		{
		mValid=0;	
		break;
		}	
	}

	String mChkSttring=mEnrollment.toUpperCase();

	int start = mChkSttring.indexOf("INSERT");
	if (start<0)
		start = mChkSttring.indexOf("UPDATE");
	if (start<0)
		start = mChkSttring.indexOf("DELETE");
	if (start<0)
		start = mChkSttring.indexOf("TRUNCATE");
	if (start<0)
		start = mChkSttring.indexOf("DROP");
	if (start<0)
		start = mChkSttring.indexOf("CREATE");
	if (start<0)
		start = mChkSttring.indexOf("ALTER");
	
	
	// Make Invalid If any DML string found
        if (start>=0)
	   mValid=0;

	if(mValid>0 )
	   {



qry="select distinct studentname,Enrollmentno,Studentid from studentmaster where enrollmentno='"+mEnrollment+"'  and nvl(deactive,'N')='N' and INSTITUTECODE='"+mInst+"' ";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
	   {
mChkMemID=rs.getString("Studentid");
mEnrollmentno=rs.getString("Enrollmentno");
mmMemberName=rs.getString("studentname");


qry1="SELECT a.companycode, a.ACADEMICYEAR, nvl(a.HOSTELALLOW,'N')HOSTELALLOW, nvl(a.PROGRAMCODE,' ')PROGRAMCODE,nvl( a.BRANCHCODE,' ') BRANCHCODE,  " +
        " nvl(a.SEMESTERTYPE,' ')SEMESTERTYPE, a.SEMESTER, a.SEMESTER||' ('|| a.SEMESTERTYPE||')' Sem " +
        " ,nvl(b.quota,' ') quota  from studentregistration a, studentmaster b where a.INSTITUTECODE='"+mInst+"'" +
        " And a.STUDENTID='"+mChkMemID+"' and  a.regcode='"+RegCode+"' and NVL(a.REGALLOW,'N')='Y'" +
        "  and a.studentid=b.studentid  and a.SEMESTERTYPE <>'GIP' ";
//out.print(qry1);

rs=db.getRowset(qry1);

if(rs.next())

		   {

rs1=db.getRowset(qry1);
if(rs1.next())
{
       mSem1=rs1.getString("SEMESTER");
mSemType=rs1.getString("SEMESTERTYPE");
mHostel=rs1.getString("HOSTELALLOW");
mQuota=rs1.getString("quota");
mAcademicYearCode=rs1.getString("ACADEMICYEAR");
mCompanyCode=rs1.getString("companycode");	
mProgramCode=rs1.getString("PROGRAMCODE");	
mBranchCode=rs1.getString("BRANCHCODE");	
}
else
    {
    %>
    <input type="hidden" name="regallow" id="regallow" value="Y" >
    <%
    }



String mInstName="",mInstAddress="",mFeehead="",mFeeamt="",Currencycode="";
float DueAmts=0;
int mflag=0;

qry="select  a.INSTITUTECODE,a.INSTITUTENAME,  a.ADDRESS1 ||' '||  a.ADDRESS2 ||' '|| a.ADDRESS3 ||' '|| a.CITY ||' '|| a.STATE aaa " +
        " from institutemaster a where a.institutecode='"+mInst+"'";
rs=db.getRowset(qry);
if(rs.next())
{
   mInstName=rs.getString("INSTITUTENAME");
   mInstAddress=rs.getString("aaa");



}

 qry1=" select CURRENCYCODE from currencymaster where  nvl(ACCOUNTINGCURRENCY,'N')='Y' ";
 rs1=db.getRowset(qry1);
// out.println(qry1);
if(rs1.next())
{    Currencycode=rs1.getString("CURRENCYCODE");
}

//out.println(filePath);
        
            qry1="SELECT   s.collseqid, g.currencycode, g.feehead,InitCap(s.FEEHEADDESC)FEEHEADDESC," +
        "         g.postingcompany postingcompany, g.glid, g.feeamount," +
        "         'Academic Year Wise' feesource, feetype" +
        "    FROM feestructure g, feeheads s   WHERE g.institutecode = '"+mInst+"'     AND g.companycode = '"+mCompanyCode+"'" +
        "     AND g.QUOTA = '"+mQuota+"'     AND g.academicyear = '"+mAcademicYearCode+"'" +
        "     AND g.programcode = '"+mProgramCode+"'     AND g.branchcode = '"+mBranchCode+"'" +
        "     AND g.semester = "+mSem1+"     AND g.semestertype ='"+mSemType+"'" +
        "     AND g.currencycode = '"+Currencycode+"'     AND NVL (g.feeamount, 0) > 0" +
        "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
        "     AND s.companycode = g.companycode     AND NVL (s.deactive, 'N') = 'N'" +
        "     AND g.feehead NOT IN (            SELECT f.feehead              FROM feeheads f" +
        "             WHERE f.institutecode = '"+mInst+"'               AND f.companycode = '"+mCompanyCode+"'" +
        "               AND f.feetype = 'H'               AND '"+mHostel+"' = 'N')     AND NOT EXISTS (   SELECT NULL" +
        "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '"+mInst+"'" +
        "               AND fsi1.companycode = '"+mCompanyCode+"'               AND fsi1.studentid = '"+mChkMemID+"'" +
        "               AND fsi1.academicyear = '"+mAcademicYearCode+"'" +
        "               AND fsi1.programcode = '"+mProgramCode+"'" +
        "               AND fsi1.branchcode = '"+mBranchCode+"'" +
        "               AND fsi1.currencycode = '"+Currencycode+"'            AND NVL (fsi1.deactive, 'N') = 'N'" +
        "               AND fsi1.semester = g.semester               AND fsi1.semestertype = g.semestertype" +
        "               AND fsi1.regcode ='"+RegCode+"'" +
        "               AND fsi1.feehead = g.feehead)     AND NOT EXISTS (" +
        "            SELECT NULL              FROM feestructurecriteria fsc" +
        "             WHERE fsc.institutecode = '"+mInst+"'" +
        "               AND fsc.companycode = '"+mCompanyCode+"'" +
        "               AND fsc.academicyear = '"+mAcademicYearCode+"'" +
        "               AND fsc.programcode = '"+mProgramCode+"'" +
        "               AND fsc.branchcode = '"+mBranchCode+"'               AND fsc.currencycode = '"+Currencycode+"' " +
        "               AND fsc.semester = g.semester               AND fsc.semestertype = g.semestertype" +
        "               AND fsc.feehead = g.feehead               AND fsc.QUOTA = g.QUOTA" +
        "               AND (    fsc.OPERATOR IN ('IN', '=')                    AND fsc.criteriavalue = 'N'" +
        "                   )) UNION ALL SELECT   s.collseqid, g.currencycode, g.feehead ,InitCap(s.FEEHEADDESC)FEEHEADDESC ,  " +
        "       g.postingcompany postingcompany, g.glid, g.feeamount,         'Criteria Wise' feesource, feetype" +
        "    FROM feestructurecriteria g, feeheads s   WHERE g.institutecode = '"+mInst+"'" +
        "     AND g.companycode = '"+mCompanyCode+"'     AND g.QUOTA = '"+mQuota+"' " +
        "     AND g.academicyear = '"+mAcademicYearCode+"'     AND g.programcode = '"+mProgramCode+"'" +
        "     AND g.branchcode = '"+mBranchCode+"'     AND g.semester = "+mSem1+" " +
        "     AND g.semestertype = '"+mSemType+"'     AND g.currencycode = '"+Currencycode+"' " +
        "     AND (g.OPERATOR IN ('IN', '=') AND g.criteriavalue = 'N'  )" +
               "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
               "     AND s.companycode = g.companycode     AND NVL (g.feeamount, 0) > 0" +
               "     AND NVL (s.deactive, 'N') = 'N'     AND g.feehead NOT IN (" +
               "            SELECT f.feehead              FROM feeheads f" +
               "             WHERE f.institutecode = '"+mInst+"'" +
               "               AND f.companycode = '"+mCompanyCode+"'" +
               "               AND f.feetype = 'H'" +
               "               AND '"+mHostel+"' = 'N')     AND NOT EXISTS (            SELECT NULL" +
               "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '"+mInst+"'" +
               "               AND fsi1.companycode = '"+mCompanyCode+"'" +
               "               AND fsi1.studentid = '"+mChkMemID+"'" +
               "               AND fsi1.academicyear = '"+mAcademicYearCode+"'" +
               "               AND fsi1.programcode = '"+mProgramCode+"'" +
               "               AND fsi1.branchcode = '"+mBranchCode+"'" +
               "               AND fsi1.currencycode = '"+Currencycode+"' " +
               "               AND NVL (fsi1.deactive, 'N') = 'N'" +
               "               AND fsi1.regcode = '"+RegCode+"'" +
               "               AND fsi1.semester = g.semester" +
               "               AND fsi1.semestertype = g.semestertype" +
               "               AND fsi1.feehead = g.feehead) UNION ALL " +
               "  SELECT   s.collseqid, fi.currencycode, fi.feehead, InitCap(s.FEEHEADDESC)FEEHEADDESC   ,      fi.postingcompany postingcompany, fi.glid, feeamount," +
               "         'Individual' feesource, feetype   FROM feestructureindividual fi, feeheads s" +
               "   WHERE fi.institutecode = '"+mInst+"'     AND fi.companycode = '"+mCompanyCode+"'" +
               "     AND fi.studentid = '"+mChkMemID+"'  and    fi.SEMESTERTYPE <>'GIP'   AND fi.academicyear = '"+mAcademicYearCode+"'" +
               "     AND fi.programcode = '"+mProgramCode+"'     AND fi.branchcode = '"+mBranchCode+"'" +
               "     AND NVL (fi.deactive, 'N') = 'N'     AND fi.regcode = '"+RegCode+"'" +
               "     AND fi.semester = "+mSem1+"     AND fi.semestertype = '"+mSemType+"'" +
               "     AND fi.currencycode = '"+Currencycode+"'     AND s.feehead = fi.feehead" +
               "     AND s.institutecode = fi.institutecode     AND s.companycode = fi.companycode" +
               "     AND NVL (s.deactive, 'N') = 'N'     AND fi.feehead NOT IN (" +
               "            SELECT f.feehead              FROM feeheads f" +
               "             WHERE f.institutecode = '"+mInst+"'" +
               "               AND f.companycode = '"+mCompanyCode+"'" +
               "               AND f.feetype = 'H'               AND  '"+mHostel+"' = 'N')" +
               "               UNION ALL SELECT   collseqid, '"+Currencycode+"'   currencycode, feehead, InitCap(FEEHEADDESC)FEEHEADDESC ," +
              "         postingcompany postingcompany, glid, 0 feeamount,         'FeeHeads' feesource, feetype" +
              "    FROM feeheads   WHERE companycode = '"+mCompanyCode+"'" +
              "     AND institutecode = '"+mInst+"'     AND NVL (deactive, 'N') = 'N'" +
              "     AND feetype IN ('A','E') ORDER BY 1 ";

      /*      qry1="SELECT  c.FEEHEADDESC,A.FEEHEAD, B.REGCODE, A.programcode, A.branchcode, A.semester,         A.semester || ' (' || A.semestertype || ')' sem, A.currencycode," +
        "        ( SUM (NVL (feeamount, 0)) - (SUM (NVL (paidamount, 0)) +  SUM (NVL (discountamount, 0)) ) )feeamount  " +
        "        ,Sum(nvl(FEEAMOUNT,0)) FEEAMOUNT,  sum(nvl(PAIDAMOUNT,0)) PAIDAMOUNT,sum(nvl(DISCOUNTAMOUNT,0)) DISCOUNTAMOUNT " +
        "                 FROM studentfeesummary A, STUDENTREGISTRATION B ,feeheads c" +
        "   WHERE  a.INSTITUTECODE=c.INSTITUTECODE and a.FEEHEAD=c.FEEHEAD and A.institutecode = '"+mInst+"'" +
       "     AND A.companycode IN (SELECT companytagging" +
       "                           FROM institutemaster                          WHERE institutecode = '"+mInst+"')" +
       "    AND A.studentid = '"+mMemberID+"'    AND A.STUDENTID=B.STUDENTID" +
       "   AND A.INSTITUTECODE=B.INSTITUTECODE    AND A.ACADEMICYEAR=B.ACADEMICYEAR" +
       "     AND A.SEMESTER=B.SEMESTER     AND A.SEMESTERTYPE=B.SEMESTERTYPE" +
       "     AND A.PROGRAMCODE=B.PROGRAMCODE     AND A.BRANCHCODE=B.BRANCHCODE     GROUP BY  c.FEEHEADDESC,  A.FEEHEAD,   B.REGCODE," +
       "     A.companycode,         A.institutecode,         A.studentid,         A.academicyear," +
       "         A.programcode,         A.branchcode,         A.semester,        " +
       "  A.semester || ' (' || A.semestertype || ')',         A.currencycode ORDER BY A.semester";*/

            //feedues('JIIT','UNIV','00010901622',1,'REG','2009ODD','Y','HF','','INR')sdd
//out.print(qry1);
 rs1= db.getRowset(qry1);
RsFee=db.getRowset(qry1);
 float sum=0;

 if(RsFee.next())
     {


%>



<input type="hidden" name="Currencycode" id="Currencycode" value="<%=Currencycode%>">
 <input type="hidden" name="mQuota" id="mQuota" value="<%=mQuota%>">
 <input type="hidden" name="mCompanyCode" id="mCompanyCode" value="<%=mCompanyCode%>">
   <input type="hidden" name="mSemType" id="mSemType" value="<%=mSemType%>">
   <input type="hidden" name="Hostel" id="Hostel" value="<%=mHostel%>">
   <input type="hidden" name="mInstName" id="mInstName" value="<%=mInstName%>">
        <input type="hidden" name="mInstAddress" id="mInstAddress" value="<%=mInstAddress%>">
    <input type="hidden" name="StudentName" id="StudentName" value="<%=mmMemberName%>">
         <input type="hidden" name="StudentID" id="StudentID" value="<%=mChkMemID%>">
             <input type="hidden" name="InstituteCode" id="InstituteCode" value="<%=mInst%>">

        <input type="hidden" name="Enrollment" id="Enrollment" value="<%=mEnrollmentno%>">
            <input type="hidden" name="Program" id="Program" value="<%=mProgramCode%>">
                <input type="hidden" name="Branch" id="Branch" value="<%=mBranchCode%>">
 <input type="hidden" name="mAcademicYearCode" id="mAcademicYearCode" value="<%=mAcademicYearCode%>">
                        <input type="hidden" name="mSem1" id="mSem1" value="<%=mSem1%>">
                          
                          <input type="hidden" name="RegCode" id="RegCode" value="<%=RegCode%>">

                            
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <!--DWLayoutTable-->
  <tr>
    <td valign="top" ><font  face="Arial"><strong>AXIS-BANK</strong></font>
      <p><font size="2" face="Arial">Deposited at Branch</font></p></td>
    <td valign="top"><font  face="Arial"><strong>PAY-IN-SLIP</strong></font>
      <p><font size="2" face="Arial">Date :-</font></p></td>
    <td colspan="2" valign="top"><font face="Arial"><strong>BANK
    COPY</strong></font>
      <p><strong><font face="Arial">A/C :- 910010050443719</font></strong></p></td>
  </tr>
  <tr>
    <td  colspan="4" align="center" valign="top"><font size="2" face="Arial"><strong><%=mInstName%>
      <%=mInstAddress%></strong></font></td>
  </tr>
  <tr>
    <td  colspan="4" align="center" valign="top"><font face="Arial"><strong>DETAIL
        OF THE STUDENT</strong></font></td>
    </tr>
  <tr>
    <td  align="center"><p align="left"><font size="2" face="Arial">Roll
    No.:-<%=mEnrollmentno%></font></p></td>
    <td  align="center"><p align="left"><font size="2" face="Arial">Student
        Name:- <%=mmMemberName%></font></p></td>
    <td   align="center"><p align="left"><font size="2" face="Arial">Program:-<%=mProgramCode%> <BR>
        Branch:-<%=mBranchCode%>
        </font></p></td>
    <td   align="center"><p align="left"><font size="2" face="Arial">Semester:-<%=mSem1%>
        </font></p></td>
  </tr>
  <tr>
    <td  align="center" colspan="2" valign="top"><div align="center">
        <font size="2" face="Arial"><strong>FEE
    FOR THE SEMESTER <%=mSem1%></strong></font></div>


<table bordercolor="#000000" border="1" align="center" cellspacing="0" cellpadding="0" width="100%">

     <tr>
    <%
            while(rs1.next())
                {
                    mFeehead=rs1.getString("feehead");
                    mFeeamt=rs1.getString("feeamount");
                  qry="select  feedues( '"+mInst+"', '"+mCompanyCode+"','"+mChkMemID+"',"+mSem1+",'"+mSemType+"','"+RegCode+"'," +
                          " '"+mHostel+"' ,'"+mFeehead+"', '"+mFeeamt+"' ,'"+Currencycode+"'  )amount from dual";
                 //     out.print(qry);
                  rs=db.getRowset(qry);
                  if(rs.next())
                  {
                      DueAmts=rs.getFloat("amount");

                     if(DueAmts!=0)
                     {  slno++;
                        sum=sum+DueAmts;
                        %>
                        <tr>
                        <td align="left">
                               <%=rs1.getString("FEEHEADDESC")%>
                        </td>
                        <td align="right">
                            <%=DueAmts%>
                        </td>
                        </tr>


                    <% mflag=1;
                    }
                     
                  }
                }
// out.print(slno);
 for(int i=slno;i<9;i++)
     {
        %>
            <tr>
            <td align="left">
                &nbsp;
            </td>
            <td align="right">
                 &nbsp;
            </td>
            </tr>


                <%

     }
 

           if (mflag==0)
               {
                    %>
<input type="hidden" name="NoDuesAmt" id="NoDuesAmt" value="Y">

    <%}
            else
                {
                %>
                <input type="hidden" name="NoDuesAmt" id="NoDuesAmt" value="N">
                    <%
                }
           
    %>
<input type="hidden" name="sum" id="sum" value="<%=sum%>">
           <td  align="right"><font face="Arial"><strong>Total</strong></font></td>

    <td  align="right"><font face="Arial"><strong>Rs. <%=sum%></strong></font></td>

        </tr>

</table>
</td>

      <td colspan="2" align="center" valign="top"><font size="2" face="Arial"><strong>CASH DEPOSIT</strong>
            </font>



<table bordercolor="#000000" border="1" align="center" cellspacing="0" cellpadding="0" width="100%">

     <tr>
         <td align="right">
             1000 *
         </td>
         <td align="left">
             Rs.
         </td>
     </tr>
     <tr>
         <td align="right">
             500 *
         </td>
         <td align="left">
             Rs.
         </td>
     </tr>
     <tr>
         <td align="right">
             100 *
         </td>
         <td align="left">
             Rs.
         </td>
     </tr>

     <tr>
         <td align="right">
             50 *
         </td>
         <td align="left">
             Rs.
         </td>
     </tr>

     <tr>
         <td align="right">
             20 *
         </td>
         <td align="left">
             Rs.
         </td>
     </tr>
      <tr>
         <td align="right">
             10 *
         </td>
         <td align="left">
             Rs.
         </td>
     </tr>
      <tr>
         <td align="right">
             5 *
         </td>
         <td align="left">
             Rs.
         </td>
     </tr>

      <tr>
         <td align="right">
             2 *
         </td>
         <td align="left">
             Rs.
         </td>
     </tr>

      <tr>
         <td align="right">
             1 *
         </td>
         <td align="left">
             Rs.
         </td>
     </tr>



     <tr>
<td  align="right"><font face="Arial"><strong>Total</strong></font></td>
    <td  align="left"><font face="Arial"><strong>Rs.</strong></font></td>
     </tr>
</table>
      </td>
  </tr>
 



   <tr>
    <td  colspan="4" align="center" valign="top">
        <font face="Arial"><strong>DD DETAILS	</strong></font></td>
    </tr>

	<tr>
    <td  align="left"><font size="2" face="Arial">BANK</font></td>
    <td  align="left"><font size="2" face="Arial">BRANCH</font></td>
    <td   align="left"><font size="2" face="Arial">DD NO.</font></td>
    <td   align="left"><font size="2" face="Arial">AMOUNT
        </font></td>
  </tr>

  <tr>
    <td  align="left"><font face="Arial"> &nbsp;</font></td>
    <td  align="left"><font face="Arial">&nbsp;</font></td>
    <td  align="left"><font face="Arial">&nbsp;</font></td>
    <td   align="left"><font size="2" face="Arial">Rs.______
        (In World) </font>
      </td>
  </tr>

    <tr>
    <td  align="center" colspan="2"><p align="left"><font size="2" face="Arial"> SIGNATURE OF DEPOSITOR & CONTACT NO</font></p></td>

    <td colspan="2" align="center"><p align="center"><font size="2" face="Arial">&nbsp;(FOR
        OFFICE USE)</font></p>
      <p align="left"><font size="2" face="Arial">TRAN.ID.NO. _______
        ENTERED________ VERIFIED______</font></p></td>

  </tr>
</table>


<style type="text/css">
				@media print
				{
				input#btnPrint
				{
					display: none;
				}
				}
				</style>
				<center>
          

                <input name="Submit" type="submit" value="Print in PDF" onclick="return validate();">
                            <br>
                                      <font face="verdana"  size="3">Download Fees Payment Sheet </font>

                            <br>
                 <font face="verdana" color="red" size="4">Note:-</font>
        
                 <font face="verdana"  size="2">
                     1.  In case of any deviation/Queries related with Fees/Dues.Contact Registrar's Office and then make Payment.
                 </font>
                </center>

</form>
<%
}
else
    {
     %>
     <center><font face="verdana" color="red" size="2">Student have no dues !</font></center>
     <%
     }

}
else
    {
     %>
     <center><font face="verdana" color="red" size="2">Select correct registration code !</font></center>
     <%
     }



	   }
else
	   {%>
		 <center><font face="verdana" color="red" size="2">No such Enrollment no exists!</font></center>
		 <%
	   }
}

 
	else 
      {
      out.print("<center>");
		
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please enter correct Enrollment No.! </font> <br>");
		out.print("</center>");

		//out.print("<p><a href=../index.jsp><img src=Images/Back.jpg border=0 ></a></p><br><br><br><br><br><br>");  
	} 

  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
  
}  

}
catch(Exception e)
{
}
%>

</body>
</html>
