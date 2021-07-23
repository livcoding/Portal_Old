<%-- 
    Document   : feedemand
    Created on : 20 Nov, 2019, 5:02:34 PM
    Author     : VIVEK.SONI
--%>

<%--
    Document   : FeeReceipt
    Created on : Mar 07, 2013, 3:15:58 PM
    Author     : ajay2.kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*,pgwebkiosk.*" %>

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="";
%>
<HTML>
<head>
 <TITLE>#### <%=mHead%> [ Fee-Demand  ] </TITLE>

<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 20px;
}
-->
</style>
</head>
<body aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
 <form  action="Feedemand-pdf.jsp">
<%
OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet RsFee=null;
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
String minst="";
String ENROLLMENTNO="",STUDENTNAME="",PROGRAMCODE="",BRANCHCODE="",STEMAILID="";
String CADDRESS1="",CADDRESS2="",CDISTRICT="",CADDRESS3="",CPIN="",CSTATE="" ,PPHONENO="",Date="",mFeeAmountWord="",mFeeAmount="25500";;

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

if(mInstituteCode.equalsIgnoreCase("JIIT")){
minst="Jaypee Institute of Information Technology";
}else if(mInstituteCode.equalsIgnoreCase("J128")){
minst="Jaypee Institute of Information Technology,Noida-128";
}else if(mInstituteCode.equalsIgnoreCase("JPBS")){
minst="Jaypee Business School";
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
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
        String acdYear="",quota="",semester="",semestertype="";
String seqqry="Select WEBKIOSK.ShowLink('275','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  RsChk= db.getRowset(seqqry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {

            qry="select ACADEMICYEAR,QUOTA,ENROLLMENTNO,STUDENTNAME,PROGRAMCODE,BRANCHCODE from studentmaster where studentid='"+mChkMemID+"'";

            rs = db.getRowset(qry);

            if(rs.next()){
            ENROLLMENTNO=rs.getString("ENROLLMENTNO");
            STUDENTNAME=rs.getString("STUDENTNAME");
            PROGRAMCODE=rs.getString("PROGRAMCODE");
            BRANCHCODE=rs.getString("BRANCHCODE");
            acdYear=rs.getString("ACADEMICYEAR");
            quota=rs.getString("QUOTA");
            }

            qry1="select nvl(CADDRESS1,' ')CADDRESS1, nvl(CADDRESS3,' ')CADDRESS3,nvl(CADDRESS2,' ')CADDRESS2,nvl(CDISTRICT,' ')CDISTRICT,nvl(CSTATE,'')CSTATE ,nvl(PPHONENO,' ')PPHONENO,nvl(CPIN,'0')CPIN from STUDENTADDRESS where STUDENTID='"+mChkMemID+"'";
            RsFee=db.getRowset(qry1);
            if(RsFee.next()){
            CADDRESS1=RsFee.getString("CADDRESS1");
            CADDRESS2=RsFee.getString("CADDRESS2");
            CADDRESS3=RsFee.getString("CADDRESS3");
            CDISTRICT=RsFee.getString("CDISTRICT");
            CPIN=RsFee.getString("CPIN");
            CSTATE=RsFee.getString("CSTATE");
          
            }
            String address=CADDRESS1+" , "+CADDRESS2+" , "+" "+CADDRESS3+" , "+CDISTRICT+" , "+CSTATE+" "+CPIN;  //CADDRESS1="",CADDRESS2="",CDISTRICT="",CADDRESS3="",CPIN="",CSTATE=""

            if(PPHONENO!=null && PPHONENO.equalsIgnoreCase("0")){
                PPHONENO="N/A";
            }



            qry="select to_char(sysdate,'DD-MM-YYYY')ss from dual";
	    rs=db.getRowset(qry);
	    if(rs.next())
	    {
            Date=rs.getString("ss");
            }

            qry=" select nvl(STEMAILID,'N/A')STEMAILID,nvl(STCELLNO,'N/A')STCELLNO from studentphone where STUDENTID='"+mChkMemID+"'";
	    rs=db.getRowset(qry);
	    if(rs.next())
	    {
            STEMAILID=rs.getString("STEMAILID");
            PPHONENO=rs.getString("STCELLNO");
            }

            

            String mcurrentreg="";
            String HOSTELALLOW="",HOSTELTYPE="";

            qry = "select semester,regcode,semestertype,nvl(HOSTELALLOW,'N') HOSTELALLOW,HOSTELTYPE  from  STUDENTREGISTRATION where semester=  (select MAX (semester) from STUDENTREGISTRATION where studentid='"+mChkMemID+"') and studentid='"+mChkMemID+"'";
            ResultSet rss2 = db.getRowset(qry);
            if (rss2.next()) {
            mcurrentreg = rss2.getString("regcode");
            semester = rss2.getString("semester");
            semestertype = rss2.getString("semestertype");
            HOSTELALLOW = rss2.getString("HOSTELALLOW");
            HOSTELTYPE = rss2.getString("HOSTELTYPE");
            rss2.close();
            }

            qry = "select regcode  from studentregistration where studentid='"+mChkMemID+"' and REGALLOW='Y'";
            ResultSet rss3 = db.getRowset(qry);
            double mPreviousdues=0.0;
            double mduesamt=0.0;
            double curremtdues=0.0;
            double totdues=0.0;
            while (rss3.next()) {

            String regcode = rss3.getString("regcode");
            if(!regcode.equalsIgnoreCase(mcurrentreg)){
            qry = " select feeDueSem( '"+mCompanyCode+"' ,'"+mChkMemID+"' ,'"+regcode+"')dues from dual ";
            ResultSet rss4 = db.getRowset(qry);
            String duesamt="";
            if(rss4.next()){
            duesamt= rss4.getString("dues");
            }
            if(!duesamt.equalsIgnoreCase("")){
            mduesamt=Double.parseDouble(duesamt);
            mPreviousdues=mduesamt+mPreviousdues;
            }

            }
            }
            
   
            
            
            %>


            <style type="text/css">
table {
  width: 50%;
  margin: 5px auto;
  table-layout: auto;
}

.fixed {
  table-layout: fixed;
}

table,
td,
th {
  border-collapse: collapse;
}

th,
td {
  padding: 5px;
  border: solid 1px;
  text-align: left;
  word-wrap:break-word;
}

#customers {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 70%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 5px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #4CAF50;
  color: white;
}

</style>
<div align="center">
 <img src="../images2/logo.png" valign="center">
</div>
 
<table  align="center">
 
  <tr>
      <td  colspan="4" align="center">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <b> <font face="tahoma" size="4"> <%=minst%> </font> </b>
        <br>   <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        (Declared Deemed to be University u/s 3 of UGC Act 1956)
      </td>
  </tr>
  
  <tr>
    <td ><B>Name of Student</B></td>
    <td ><%=STUDENTNAME%></td>
    <td ><B>Enrol No.</B></td>
    <td ><%=ENROLLMENTNO%></td>
  </tr>
  <tr>
      <td colspan="1" ><B>Address</td>
    <td colspan="3"><%=address%></td>
   
  </tr>
  <tr>
    <td ><B>Program</B></td>
    <td ><%=PROGRAMCODE%></td>
    <td ><B>Branch</B></td>
    <td ><%=BRANCHCODE%></td>
  </tr>
   <tr>
       <td ><B>Contact No.</B></td>
    <td ><%=PPHONENO%></td>
    <td ><B>Email ID</B></td>
    <td ><%=STEMAILID%></td>
   
  </tr>
  <tr>
      <td colspan="1" ><B>Date</B></td>
      <td colspan="3"><%=Date%></td>
   <tr>
    <td  colspan="4">
        Dear Student <br>
        Please find below the details of Amount / fee due for semester <B> <%=semester%> </B>. <br>
        

    </td>
    
  </tr>
  
      
  <%
 String  query = " Select s.CollSeqID,g.CurrencyCode,g.FeeHead, g.PostingCompany PostingCompany,g.GlID,g.FeeAmount, 'Academic Year Wise' FeeSource,Null Feetype  From FeeStructure g ,FeeHeads s "
    +"  Where g.InstituteCode= '"+mInstituteCode+"' And g.CompanyCode    =     '"+mCompanyCode+"'     And    g.Quota    =   '"+quota+"'   And g.AcademicYear=  '"+acdYear+"'       And    g.ProgramCode= '"+PROGRAMCODE+"'   And    "
   +" g.BranchCode=   '"+BRANCHCODE+"'   And g.Semester=  '"+semester+"'  And    g.SemesterType=  '"+semestertype+"'   And Nvl(g.FeeAmount,0)> 0   And s.FeeHead=    g.FeeHead and s.InstituteCode=g.InstituteCode "
   +"  and s.CompanyCode=g.CompanyCode And g.Feehead Not in( Select f.Feehead From Feeheads f Where f.InstituteCode = '"+mInstituteCode+"' And f.CompanyCode =     '"+mCompanyCode+"'     And FeeType = 'H' And '"+HOSTELALLOW+"' = 'N')   "
   +" And    Not Exists ( Select  Null  From  FeeStructureIndividual FSI1 Where  fsi1.InstituteCode    = '"+mInstituteCode+"' And fsi1.CompanyCode    =     '"+mCompanyCode+"'       And fsi1.StudentID    =  '"+mChkMemID+"' And fsi1.AcademicYear =   '"+acdYear+"'    "
   +"   And     fsi1.ProgramCode= '"+PROGRAMCODE+"'      And    fsi1.BranchCode    =   '"+BRANCHCODE+"'     And Nvl(fsi1.Deactive,'N')= 'N' And fsi1.RegCode     = '"+mcurrentreg+"'     And     fsi1.Semester = g.Semester    And  "
   +"    fsi1.SemesterType= g.SemesterType And fsi1.FeeHead= g.FeeHead)   And    Not Exists ( Select  Null  From  FeeStructureCriteria FSC1 Where  FSC1.InstituteCode    = '"+mInstituteCode+"'  "
   +"  And FSC1.CompanyCode    =     '"+mCompanyCode+"'       And FSC1.AcademicYear =   '"+acdYear+"'        And     FSC1.ProgramCode= '"+PROGRAMCODE+"'      And    FSC1.BranchCode    =   '"+BRANCHCODE+"'     "
   +"  And FSC1.Semester = g.Semester    And    FSC1.SemesterType= g.SemesterType And FSC1.FeeHead= g.FeeHead  And FSC1.Quota= g.Quota    And    "
   +"     (FSC1.Operator IN ('IN','=') And FSC1.CriteriaValue = '"+HOSTELTYPE+"'))    Union All    Select        s.CollSeqID,fc.CurrencyCode,fc.FeeHead,fc.PostingCompany PostingCompany ,fc.GlID,  "
   +"   fc.FeeAmount, 'Academic Year Wise' FeeSource,Null Feetype    From FeeStructureCriteria fc ,FeeHeads s Where fc.InstituteCode    = '"+mInstituteCode+"' and fc.CompanyCode    =     '"+mCompanyCode+"'     "
   +"  and fc.Quota=   '"+quota+"'   And    fc.AcademicYear    =   '"+acdYear+"'        And    fc.ProgramCode    = '"+PROGRAMCODE+"'   And    fc.BranchCode=   '"+BRANCHCODE+"'   And    fc.Semester=  '"+semester+"'  And    "
   +" fc.SemesterType=   '"+semestertype+"'  AND    NVL(fc.FeeAmount,0) >0    And    (fc.Operator In ('IN','=') And fc.CriteriaValue = '"+HOSTELTYPE+"') And s.FeeHead=fc.FeeHead    And   "
   +"  s.InstituteCode    = fc.InstituteCode   And    fc.Feehead Not in( Select f.Feehead From Feeheads f Where f.InstituteCode = '"+mInstituteCode+"'    And f.CompanyCode =     '"+mCompanyCode+"'     "
   +" And FeeType = 'H' And '"+HOSTELALLOW+"' = 'N')    And    Not Exists ( Select  Null  From FeeStructureIndividual FSI1    Where  fsi1.InstituteCode='"+mInstituteCode+"' And fsi1.CompanyCode=     '"+mCompanyCode+"'      "
   +"  And    fsi1.StudentID=  '"+mChkMemID+"'    And    fsi1.AcademicYear=   '"+acdYear+"'     And fsi1.ProgramCode= '"+PROGRAMCODE+"'      And    fsi1.BranchCode    =   '"+BRANCHCODE+"'   And    Nvl(fsi1.Deactive,'N')= 'N'   "
   +"   And    fsi1.RegCode = '"+mcurrentreg+"'     And    fsi1.Semester= fc.Semester    And         fsi1.SemesterType= fc.SemesterType    And fsi1.FeeHead= fc.FeeHead)   Union All    "
   +"    Select  s.CollSeqID,I.CurrencyCode,I.FeeHead, I.PostingCompany PostingCompany ,I.GlID,FeeAmount, 'Individual' FeeSource,Null Feetype     "
   +"    From FeeStructureIndividual I,FeeHeads s Where    I.InstituteCode='"+mInstituteCode+"' And I.CompanyCode=     '"+mCompanyCode+"'     And    I.StudentID    =  '"+mChkMemID+"' And I.AcademicYear    =  '"+acdYear+"'        "
   +"     and    I.ProgramCode= '"+PROGRAMCODE+"'   And    I.BranchCode =  '"+BRANCHCODE+"'   And Nvl(I.Deactive,'N')= 'N' And    I.RegCode ='"+mcurrentreg+"' And    I.Semester    =  '"+semester+"'  And I.SemesterType=  '"+semestertype+"'     "
   +"       And s.FeeHEad  = I.FeeHEad And  s.InstituteCode     = I.InstituteCode      And    I.Feehead Not in( Select f.Feehead From Feeheads f Where f.InstituteCode = '"+mInstituteCode+"'  "
   +"     and f.CompanyCode =     '"+mCompanyCode+"'     And f.FeeType = 'H'       And '"+HOSTELALLOW+"' = 'N')    Order By     1 ";



    System.out.println(query);
    ResultSet rss6 = db.getRowset(query);
    String totfees="",tutionFeeamount="",feehead="",amt="",FEEHEADDESC="";
    Double feeheaddues=0.0,headamt=0.0;
    while(rss6.next()){
        feehead=rss6.getString("FeeHead");
        amt=rss6.getString("FeeAmount");

         if(!feehead.equalsIgnoreCase("")){
         qry="select FEEHEADDESC from FEEHEADS where INSTITUTECODE='"+mInstituteCode+"'  and FEEHEAD='"+feehead+"' ";
         ResultSet rss7 = db.getRowset(qry);
         if(rss7.next()){
         FEEHEADDESC=rss7.getString("FEEHEADDESC");
         }
          qry="select feedues('"+mInstituteCode+"',     '"+mCompanyCode+"'     , '"+mChkMemID+"' ,  '"+semester+"'  ,  '"+semestertype+"'  , '"+mcurrentreg+"' , 'Y' , '"+feehead+"','"+amt+"','INR' )  dues from dual  ";
         ResultSet rss8 = db.getRowset(qry);
         if(rss8.next()){
         tutionFeeamount=rss8.getString("dues");
         }
         headamt=Double.parseDouble(tutionFeeamount);
         feeheaddues=headamt+feeheaddues;
         %>
          <tr>
 <td  colspan="2" align="left">
       <%=FEEHEADDESC%>	
       </td>
        <td  colspan="2" align="left">
        <%=tutionFeeamount%>
       </td>
        </tr>

      <% }
   
    } //End of While 
%>
<tr>
    <td  colspan="2" align="left">
      <B>   Total Fee</B>
       </td>
        <td  colspan="2" align="left">
        <%=feeheaddues%>
       </td>
        </tr>
<tr>
<tr>
    <td  colspan="2" align="left">
       Fines / Other Dues
       </td>
        <td  colspan="2" align="left">
        <%=mPreviousdues%>
       </td>
        </tr>
<tr>
 <%
Double totaldues=0.0;
totaldues=mPreviousdues+feeheaddues;
qry = "SELECT initcap(common.toword(" + totaldues + ")) TOWORDS FROM   dual";
            ResultSet rss = db.getRowset(qry);
            if (rss.next()) {
            mFeeAmountWord = rss.getString("TOWORDS");
            }
%>
 <tr>
    <td  colspan="2" align="left">
        <B>   Total Dues</B>
       </td>
        <td  colspan="2" align="left">
        <%=totaldues%>
       </td>
        </tr>
<tr>
 
   <tr>
       <td  colspan="4" align="left">
       Please pay the total dues a sum of Rs. <%=totaldues%> ( <%=mFeeAmountWord%> ), latest by the date of registration as per academic calendar,
       through online / credit-debit card / Demand Draft. Cash payment is not accepted.
       Any discrepancy in the above may please be brought to the notice of <b> JIIT Finance Department.</b>
        <br>
       <br>
       <b> (Registrar)</b>

    </td>

  </tr>

   <tr>
       <td  colspan="4" align="left">
           <b>Fee Payment Options :</b><br>
           1. <b>Online</b> - through payment gateway available on webkiosk, the student portal. <br>
           2.<b> Demand Draft </b> drawn in favour of “Jaypee Institute of Information Technology” payable at Noida/Delhi. Please mention your enrolment No. and name on the back side of DD. <br>
           3. Demand Draft shall be received only at Accounts & Finance Department of JIIT, Noida.



    </td>

  </tr>
  
</table>
<div align="center">
    <button>
        Download
    </button>
    <br><br><br>
</div>






    </form>





            <%--





            <table align="center">
               
                <tr align="center">
                    <td>
                         <font size="4"><b>(Declared Deemed to be University u/s 3 of UGC Act 1956)</b></font>
                     </td>
                </tr>
                <tr align="center">
                    <td>
                        &nbsp;
                    </td>
                </tr>
               <tr align="center">
                   <td align="left">
                         <font><b>Name of Student </b></font>
                     </td>
                      <td align="left">
                         <font><b>Vivek Kumar Soni </b></font>
                     </td>
                      <td align="left">
                         <font><b>Enrol No.</b></font>
                     </td>
                      <td align="left">
                         <font><b> 123132131</b></font>
                     </td>
                </tr>
            </table>
--%>

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
	<br>	<br>	<br>	<br>
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

</body>
</html>
