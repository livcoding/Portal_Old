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

<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

</head>



<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();

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
	mCompanyCode="JUIT";
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
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana">
    <b> Fee Payment- Punjab National Bank Pay In Slip </b> </TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 align=center rules=groups border=1 bordercolor="#a52a2a">

 <tr>
    <td>&nbsp;
     <FONT face=Arial size=2><STRONG> Registration Code   &nbsp;&nbsp;</STRONG> </FONT>
    </td>   
    <td >
    <%
ResultSet rs=null;
String mRegCode="",QryRegCode="";

/*
qry="SELECT b.regcode, b.regdesc,a.SEMESTER  FROM registrationmaster b ,studentregistration a   WHERE " +
        "            a.COMPANYCODE=b.COMPANYCODE and  a.INSTITUTECODE=b.INSTITUTECODE and a.REGCODE=b.REGCODE and" +
        "           NVL (a.feespaid, 'N') = 'N'             AND a.studentid ='"+mMemberID+"'" +
        "             AND a.institutecode = '"+mInstituteCode+"' and nvl(a.regallow,'N')='Y'" ;*/
/*
qry="SELECT  B.REGCODE, A.programcode, A.branchcode, A.semester,         A.semester || ' (' || A.semestertype || ')' sem, A.currencycode," +
        "        ( SUM (NVL (feeamount, 0)) - (SUM (NVL (paidamount, 0)) +  SUM (NVL (discountamount, 0)) ) )DUESfeeamount  " +
        "        ,Sum(nvl(FEEAMOUNT,0)) FEEAMOUNT,  sum(nvl(PAIDAMOUNT,0)) PAIDAMOUNT,sum(nvl(DISCOUNTAMOUNT,0)) DISCOUNTAMOUNT " +
        "                 FROM studentfeesummary A, STUDENTREGISTRATION B" +
        "   WHERE A.institutecode = '"+mInstituteCode+"'" +
       "     AND A.companycode IN (SELECT companytagging" +
       "                           FROM institutemaster                          WHERE institutecode = '"+mInstituteCode+"')" +
       "    AND A.studentid = '"+mMemberID+"'    AND A.STUDENTID=B.STUDENTID" +
       "   AND A.INSTITUTECODE=B.INSTITUTECODE    AND A.ACADEMICYEAR=B.ACADEMICYEAR" +
       "     AND A.SEMESTER=B.SEMESTER     AND A.SEMESTERTYPE=B.SEMESTERTYPE" +
       "     AND A.PROGRAMCODE=B.PROGRAMCODE     AND A.BRANCHCODE=B.BRANCHCODE     GROUP BY      B.REGCODE," +
       "     A.companycode,         A.institutecode,         A.studentid,         A.academicyear," +
       "         A.programcode,         A.branchcode,         A.semester,        " +
       "  A.semester || ' (' || A.semestertype || ')',         A.currencycode ORDER BY A.semester";*/
qry="SELECT nvl(a.studentid,'') studentid, nvl(a.companycode,'') companycode,nvl(a.regcode,'') regcode, nvl(a.programcode,'') programcode, nvl(a.branchcode,'') branchcode, nvl(a.semester,'') semester,      " +
        "   a.semester || ' (' || a.semestertype || ')' sem" +
        "  , ' ' DUESfeeamount FROM studentregistration a, STUDENTMASTER B   WHERE a.institutecode ='"+mInstituteCode+"'" +
        "   AND A.INSTITUTECODE=B.INSTITUTECODE      AND a.companycode IN (SELECT companytagging" +
        "                             FROM institutemaster                            WHERE a.examcode NOT LIKE('SUM%') and institutecode = '"+mInstituteCode+"')" +
        "     AND a.studentid = '"+mMemberID+"'    and NVL(a.REGALLOW,'N')='Y'      and NVL(B.DEACTIVE  ,'N')='N' " +
        "      and a.SEMESTERTYPE <>'GIP'     GROUP BY a.regcode,         a.companycode,         a.institutecode,         a.studentid," +
        "         a.academicyear,         a.programcode,         a.branchcode,    " +
        "     a.semester,         a.semester || ' (' || a.semestertype || ')'     ORDER BY a.semester DESC";
         rs=db.getRowset(qry);
         String msem="",mchk="";//out.print(qry);

%>
	<select name=RegCode tabindex="0" id="RegCode" >
<%

		   try{if(request.getParameter("x")==null)
	{//System.out.print("Gyan");
		while(rs.next())
		{

            qry1=" select  duesem('"+rs.getString("companycode").trim()+"','"+rs.getString("studentid").trim()+"','"+rs.getString("regcode").trim()+"')DUES from dual ";
         //out.print(qry1);
			RsChk=db.getRowset(qry1);  
			//System.out.print(qry1);
            if(RsChk.next())
                mchk=RsChk.getString("DUES");
				//System.out.print("mchk : "+mchk);
            if(mchk.equals("1"))
             { 
				mRegCode=rs.getString("regcode")==null?"":rs.getString("regcode").trim();
				msem=rs.getString("semester")==null?"":rs.getString("semester").trim();
            //out.print("mRegCode : "+mRegCode+"#################### "+msem);
         
           

      
                    if(QryRegCode.equals(""))
                    {
                    QryRegCode=mRegCode;
                    %>
                    <OPTION Selected Value ="<%=mRegCode%>"><%=mRegCode%> - <%=msem%> Semester </option>
                    <%
                    }
                    else
                    {
                %>
                    <option value="<%=mRegCode%>"><%=mRegCode%> - <%=msem%> Semester</option>
                <%
                    }
           }
		}
	}
	else
	{
		while(rs.next())
	  {
	  qry1=" select  duesem('"+rs.getString("companycode")+"','"+rs.getString("studentid")+"','"+rs.getString("regcode")+"')DUES from dual ";
	  //out.print(qry1);
            RsChk=db.getRowset(qry1);
            if(RsChk.next())
                mchk=RsChk.getString("DUES");

            if(mchk.equals("1"))
             {  mRegCode=rs.getString("REGCODE");
            msem=rs.getString("SEMESTER");
     


           if(mRegCode.equals(request.getParameter("RegCode").toString().trim()))
           {
                QryRegCode=mRegCode;
           %>
            <option selected value="<%=mRegCode%>"><%=mRegCode%> - <%=msem%> Semester</option>
             <%
           }
         else
         {
           %>
            <option  value="<%=mRegCode%>"><%=mRegCode%> - <%=msem%> Semester</option>
           <%
           }
}
     
	  }
  }}catch(Exception e)
	  {
	System.out.print(e);
	}
 %>
 </select>
    </td>

    <td colspan="2">
        &nbsp; &nbsp; &nbsp;<input type="submit" value="Submit" >
    </td>
 </tr>


</table>
<br>
<table cellpadding="0" cellspacing="0" border="1"  bordercolor="#a52a2a">



 <tr>
     <td align="left" >
     <font face="verdana" size="2">
      * Take a print out of 'Pay In Slip' and visit to the nearest punjab national bank branch  for fee payment.
     </font>
     </td>
     </tr>


 <tr>
     <td align="left" >
     <font face="verdana" size="2">
         * In case of fees is not showing / available in your login, kindly contact on mail ID sanjay.bhatt@juit.ac.in.
     </font>
     </td>
     </tr>
</table>
</form>
<br>
    <form name="form1" id="form1" method="post" action="PDF.jsp">
<%
if(request.getParameter("x")!=null)
   {
String RegCode=request.getParameter("RegCode");
String mSem1="",mSemType="",mHostel="",mQuota="";
ResultSet rs1=null;
ResultSet Rsf=null;
int slno=0;
    // String path=request.getContextPath();
    //s out.print(path);

qry1="SELECT nvl(a.HOSTELALLOW,'N')HOSTELALLOW, nvl(a.PROGRAMCODE,' ')PROGRAMCODE,nvl( a.BRANCHCODE,' ') BRANCHCODE,  " +
        " nvl(a.SEMESTERTYPE,' ')SEMESTERTYPE, a.SEMESTER, a.SEMESTER||' ('|| a.SEMESTERTYPE||')' Sem " +
        " ,nvl(b.quota,' ') quota  from studentregistration a, studentmaster b where a.INSTITUTECODE='"+mInstituteCode+"'" +
        " And a.STUDENTID='"+mChkMemID+"' and  a.regcode='"+RegCode+"' and NVL(a.REGALLOW,'N')='Y'  and a.SEMESTERTYPE <>'GIP' " +
        "  and a.studentid=b.studentid  ";
rs1=db.getRowset(qry1);
if(rs1.next())
{
       mSem1=rs1.getString("SEMESTER");
mSemType=rs1.getString("SEMESTERTYPE");
mHostel=rs1.getString("HOSTELALLOW");
mQuota=rs1.getString("quota");
}
else
    {
    %>
    <input type="hidden" name="regallow" id="regallow" value="Y" >
    <%
    }
/*
String qryst="SELECT 'Y' FROM FEESTRUCTURE where companycode = '"+mCompanyCode+"'  " +
        "               AND academicyear = '"+mAcademicYearCode+"'" +
        "               AND programcode = '"+mProgramCode+"'" +
        "               AND branchcode = '"+mBranchCode+"'" +
        "               AND currencycode = '"+Currencycode+"' and semestertype ='"+mSemType+"' " +
        "              AND SEMESTER='"+mSemType+"' AND  QUOTA = '"+mQuota+"' AND  FEEHEAD, CURRENCYCODE    ";
ResultSet rs2*/



String mInstName="",mInstAddress="",mFeehead="",mFeeamt="",Currencycode="";
float DueAmts=0;
int mflag=0;

qry="select a.INSTITUTECODE,a.INSTITUTENAME,  a.ADDRESS1 ||' '||  a.ADDRESS2 ||' '|| a.ADDRESS3 ||' '|| a.CITY ||' '|| a.STATE aaa " +
        " from institutemaster a where a.institutecode='"+mInstituteCode+"'";
rs=db.getRowset(qry);
if(rs.next())
{
    mInstName=rs.getString("INSTITUTENAME");
   mInstAddress=rs.getString("aaa");
}

 qry=" select CURRENCYCODE from currencymaster where  nvl(ACCOUNTINGCURRENCY,'N')='Y' ";
 rs=db.getRowset(qry);
// out.println(qry1);
if(rs.next())
{    Currencycode=rs.getString("CURRENCYCODE");
}

//out.println(filePath);
        
            qry1="SELECT   s.collseqid, g.currencycode, g.feehead,InitCap(s.FEEHEADDESC)FEEHEADDESC," +
        "         g.postingcompany postingcompany, g.glid, g.feeamount," +
        "         'Academic Year Wise' feesource, feetype" +
        "    FROM feestructure g, feeheads s   WHERE g.institutecode = '"+mInstituteCode+"'     AND g.companycode = '"+mCompanyCode+"'" +
        "     AND g.QUOTA = '"+mQuota+"'     AND g.academicyear = '"+mAcademicYearCode+"'" +
        "     AND g.programcode = '"+mProgramCode+"'     AND g.branchcode = '"+mBranchCode+"'" +
        "     AND g.semester = "+mSem1+"     AND g.semestertype ='"+mSemType+"'" +
        "     AND g.currencycode = '"+Currencycode+"'     AND NVL (g.feeamount, 0) > 0" +
        "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
        "     AND s.companycode = g.companycode     AND NVL (s.deactive, 'N') = 'N'" +
        "     AND g.feehead NOT IN (            SELECT f.feehead              FROM feeheads f" +
        "             WHERE f.institutecode = '"+mInstituteCode+"'               AND f.companycode = '"+mCompanyCode+"'" +
        "               AND f.feetype = 'H'               AND '"+mHostel+"' = 'N')     AND NOT EXISTS (   SELECT NULL" +
        "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '"+mInstituteCode+"'" +
        "               AND fsi1.companycode = '"+mCompanyCode+"'               AND fsi1.studentid = '"+mChkMemID+"'" +
        "               AND fsi1.academicyear = '"+mAcademicYearCode+"'" +
        "               AND fsi1.programcode = '"+mProgramCode+"'" +
        "               AND fsi1.branchcode = '"+mBranchCode+"'" +
        "               AND fsi1.currencycode = '"+Currencycode+"'            AND NVL (fsi1.deactive, 'N') = 'N'" +
        "               AND fsi1.semester = g.semester               AND fsi1.semestertype = g.semestertype" +
        "               AND fsi1.regcode ='"+RegCode+"'" +
        "               AND fsi1.feehead = g.feehead)     AND NOT EXISTS (" +
        "            SELECT NULL              FROM feestructurecriteria fsc" +
        "             WHERE fsc.institutecode = '"+mInstituteCode+"'" +
        "               AND fsc.companycode = '"+mCompanyCode+"'" +
        "               AND fsc.academicyear = '"+mAcademicYearCode+"'" +
        "               AND fsc.programcode = '"+mProgramCode+"'" +
        "               AND fsc.branchcode = '"+mBranchCode+"'               AND fsc.currencycode = '"+Currencycode+"' " +
        "               AND fsc.semester = g.semester               AND fsc.semestertype = g.semestertype" +
        "               AND fsc.feehead = g.feehead               AND fsc.QUOTA = g.QUOTA" +
        "               AND (    fsc.OPERATOR IN ('IN', '=')                    AND fsc.criteriavalue = 'N'" +
        "                   )) UNION ALL SELECT   s.collseqid, g.currencycode, g.feehead ,InitCap(s.FEEHEADDESC)FEEHEADDESC ,  " +
        "       g.postingcompany postingcompany, g.glid, g.feeamount,         'Criteria Wise' feesource, feetype" +
        "    FROM feestructurecriteria g, feeheads s   WHERE g.institutecode = '"+mInstituteCode+"'" +
        "     AND g.companycode = '"+mCompanyCode+"'     AND g.QUOTA = '"+mQuota+"' " +
        "     AND g.academicyear = '"+mAcademicYearCode+"'     AND g.programcode = '"+mProgramCode+"'" +
        "     AND g.branchcode = '"+mBranchCode+"'     AND g.semester = "+mSem1+" " +
        "     AND g.semestertype = '"+mSemType+"'     AND g.currencycode = '"+Currencycode+"' " +
        "     AND (g.OPERATOR IN ('IN', '=') AND g.criteriavalue = 'N'  )" +
               "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
               "     AND s.companycode = g.companycode     AND NVL (g.feeamount, 0) > 0" +
               "     AND NVL (s.deactive, 'N') = 'N'     AND g.feehead NOT IN (" +
               "            SELECT f.feehead              FROM feeheads f" +
               "             WHERE f.institutecode = '"+mInstituteCode+"'" +
               "               AND f.companycode = '"+mCompanyCode+"'" +
               "               AND f.feetype = 'H'" +
               "               AND '"+mHostel+"' = 'N')     AND NOT EXISTS (            SELECT NULL" +
               "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '"+mInstituteCode+"'" +
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
               "SELECT   s.collseqid, fi.currencycode, fi.feehead, InitCap(s.FEEHEADDESC)FEEHEADDESC   ,      fi.postingcompany postingcompany, fi.glid, feeamount," +
               "         'Individual' feesource, feetype   FROM feestructureindividual fi, feeheads s" +
               "   WHERE fi.institutecode = '"+mInstituteCode+"'     AND fi.companycode = '"+mCompanyCode+"'" +
               "     AND fi.studentid = '"+mChkMemID+"'     AND fi.academicyear = '"+mAcademicYearCode+"'" +
               "     AND fi.programcode = '"+mProgramCode+"'     AND fi.branchcode = '"+mBranchCode+"'" +
               "     AND NVL (fi.deactive, 'N') = 'N'     AND fi.regcode = '"+RegCode+"'" +
               "     AND fi.semester = "+mSem1+"     AND fi.semestertype = '"+mSemType+"'" +
               "     AND fi.currencycode = '"+Currencycode+"'     AND s.feehead = fi.feehead" +
               "     AND s.institutecode = fi.institutecode     AND s.companycode = fi.companycode" +
               "     AND NVL (s.deactive, 'N') = 'N'     AND fi.feehead NOT IN (" +
               "            SELECT f.feehead              FROM feeheads f" +
               "             WHERE f.institutecode = '"+mInstituteCode+"'" +
               "               AND f.companycode = '"+mCompanyCode+"'" +
               "               AND f.feetype = 'H'               AND  '"+mHostel+"' = 'N')" +
               "               UNION ALL SELECT   collseqid, '"+Currencycode+"'   currencycode, feehead, InitCap(FEEHEADDESC)FEEHEADDESC ," +
              "         postingcompany postingcompany, glid, 0 feeamount,         'FeeHeads' feesource, feetype" +
              "    FROM feeheads   WHERE companycode = '"+mCompanyCode+"'" +
              "     AND institutecode = '"+mInstituteCode+"'     AND NVL (deactive, 'N') = 'N'" +
              "     AND feetype IN ('A','E') ORDER BY 1 ";

      /*      qry1="SELECT  c.FEEHEADDESC,A.FEEHEAD, B.REGCODE, A.programcode, A.branchcode, A.semester,         A.semester || ' (' || A.semestertype || ')' sem, A.currencycode," +
        "        ( SUM (NVL (feeamount, 0)) - (SUM (NVL (paidamount, 0)) +  SUM (NVL (discountamount, 0)) ) )feeamount  " +
        "        ,Sum(nvl(FEEAMOUNT,0)) FEEAMOUNT,  sum(nvl(PAIDAMOUNT,0)) PAIDAMOUNT,sum(nvl(DISCOUNTAMOUNT,0)) DISCOUNTAMOUNT " +
        "                 FROM studentfeesummary A, STUDENTREGISTRATION B ,feeheads c" +
        "   WHERE  a.INSTITUTECODE=c.INSTITUTECODE and a.FEEHEAD=c.FEEHEAD and A.institutecode = '"+mInstituteCode+"'" +
       "     AND A.companycode IN (SELECT companytagging" +
       "                           FROM institutemaster                          WHERE institutecode = '"+mInstituteCode+"')" +
       "    AND A.studentid = '"+mMemberID+"'    AND A.STUDENTID=B.STUDENTID" +
       "   AND A.INSTITUTECODE=B.INSTITUTECODE    AND A.ACADEMICYEAR=B.ACADEMICYEAR" +
       "     AND A.SEMESTER=B.SEMESTER     AND A.SEMESTERTYPE=B.SEMESTERTYPE" +
       "     AND A.PROGRAMCODE=B.PROGRAMCODE     AND A.BRANCHCODE=B.BRANCHCODE     GROUP BY  c.FEEHEADDESC,  A.FEEHEAD,   B.REGCODE," +
       "     A.companycode,         A.institutecode,         A.studentid,         A.academicyear," +
       "         A.programcode,         A.branchcode,         A.semester,        " +
       "  A.semester || ' (' || A.semestertype || ')',         A.currencycode ORDER BY A.semester";*/

            //feedues('JIIT','UNIV','00010901622',1,'REG','2009ODD','Y','HF','','INR')sdd
//out.print(qry1);
 
Rsf=db.getRowset(qry1);
 float sum=0;

 if(Rsf.next())
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
             <input type="hidden" name="InstituteCode" id="InstituteCode" value="<%=mInstituteCode%>">

        <input type="hidden" name="Enrollment" id="Enrollment" value="<%=mDMemberCode%>">
            <input type="hidden" name="Program" id="Program" value="<%=mProgramCode%>">
                <input type="hidden" name="Branch" id="Branch" value="<%=mBranchCode%>">
 <input type="hidden" name="mAcademicYearCode" id="mAcademicYearCode" value="<%=mAcademicYearCode%>">
                        <input type="hidden" name="mSem1" id="mSem1" value="<%=mSem1%>">
                          
                          <input type="hidden" name="RegCode" id="RegCode" value="<%=RegCode%>">

                            
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <!--DWLayoutTable-->
  <tr>
    <td valign="top" ><font  face="Arial"><strong>PUNJAB NATIONAL BANK</strong></font>
      <p><font size="2" face="Arial">Deposited at Branch</font></p></td>
    <td valign="top"><font  face="Arial"><strong>PAY-IN-SLIP</strong></font>
      <p><font size="2" face="Arial">Date :-</font></p></td>
    <td colspan="2" valign="top"><font face="Arial"><strong>BANK
    COPY</strong></font>
      <p><strong><font face="Arial">INSTITUTE ID:JPUIT 
	
	  </font></strong></p></td>
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
    <td  align="center"><p align="left"><font size="2" face="Arial">Enrol.No.
    :-<%=mDMemberCode%></font></p></td>
    <td  align="center"><p align="left"><font size="2" face="Arial">
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
		 rs1= db.getRowset(qry1);
            while(rs1.next())
                {
                    mFeehead=rs1.getString("feehead");
                    mFeeamt=rs1.getString("feeamount");
                  qry="select  feedues( '"+mInstituteCode+"', '"+mCompanyCode+"','"+mChkMemID+"',"+mSem1+",'"+mSemType+"','"+RegCode+"'," +
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
             2000 *
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
<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
</script>
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
