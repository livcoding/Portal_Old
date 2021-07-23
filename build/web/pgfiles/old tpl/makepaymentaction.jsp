<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,pgwebkiosk.*,java.text.SimpleDateFormat" %>

<%


String qry="";
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet RsChk=null;

int n=0;
OLTEncryption enc=new OLTEncryption();
String strResponseMsg="";
String strCheckSumValue="";
String mERCHANTID="";
String customerID="";
String txnreferenceNo="";
String bankReferenceNo="";
String txnAmount="";
String bankID="";
String bankMERCHANTID="";
String txnType="";
String currencyName="";
String itemCode="";
String securityType="";
String securityID="";
String securityPassword="";
String txnDate="";
String authStatus="";
String settlementType="";

String additionalInfo1="";
String additionalInfo2="";
String additionalInfo3="";
String additionalInfo4="";
String additionalInfo5="";
String additionalInfo6="";
String additionalInfo7="";
String errorStatus="";
String errorDescription="";
String checkSum="";
String invalidPNRNoMsg="";
String mProgramCode="";
String mBranchCode="";
String mCurrentSem="";
String sysDate="";
SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh24:mm:ss");

String txid=session.getAttribute("txid")==null?"":session.getAttribute("txid").toString();
String regCode=session.getAttribute("regcode1")==null?"":session.getAttribute("regcode1").toString(); 

String feeAmt=session.getAttribute("feeAmt")==null?"0":session.getAttribute("feeAmt").toString(); 
String transCarges=session.getAttribute("transcharges")==null?"0":session.getAttribute("transcharges").toString(); 
String totalFeeAmt=session.getAttribute("totalfeeAmt")==null?"0":session.getAttribute("totalfeeAmt").toString(); 
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());  
String studentId=""; 
String statusFlag="";
String mInstituteCode="";
String mCompanyCode="";
String feecurrencycode="";
String paymentCurrencyCode="";
String mAcademicYearCode="";	
String mTempStr="";	
java.util.Date dt=null;
try{

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





if(!studentId.equals("") && !mCompanyCode.equals("") && !mAcademicYearCode.equals("") && !mProgramCode.equals("") && !mBranchCode.equals(""))
{

//-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
String seqqry="Select WEBKIOSK.ShowLink('275','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  RsChk= db.getRowset(seqqry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------








strResponseMsg=request.getParameter("msg")==null?"":request.getParameter("msg");
//out.println(strResponseMsg);
if("".equals(strResponseMsg)){
%>
<br/>
<center>
<b><font color="#FF0000"  size="+2">
<%out.println("Invalid Response. Please Try Again Later.");


%>
<%

  String link2="../StudentFiles/FAS/PDFFeeReceipt.jsp?CompanyCode="+"temp"+"&ProgramCode="+"tes"+"&BranchCode="+"aee"+"&InstituteCode="+"rdd"+"&SEM="+"5"+"&PRNO="+"td"+"&STUDENTID="+"ssd";

 
 %>

 <a href="<%//=link2%>" target="_blank">Click to Print Fee Receipt</a>
 

 </center>

</font></b>
</center>

<%
}else{
String realRespMsg=strResponseMsg;
String temp=strResponseMsg.replace('|', '<');
String[] testString = temp.split("<");
String auth=testString[14];
if("0300".equals(auth)  ){
statusFlag="S";
%>
<br/>
<center>
<b><font color="#006600"  size="+2">
<%out.println("Your Transaction Completed Sucessfully");
%>
</font></b>
</center>
<%
}else if("0399".equals(auth) ){
statusFlag="F";
%>
<br/>
<center>
<b><font color="#FF0000"  size="+2">
<%out.println("Transaction has been Cancelled,Please try again later.");
%>
</font></b>
</center>
<%
}
 if("S".equals(statusFlag)){
 customerID=testString[1]; // transaction id which is send to pg at time of request
 txnreferenceNo=testString[2];
 bankReferenceNo=testString[3];
 txnAmount=testString[4];
 bankID=testString[5];
 bankMERCHANTID=testString[6];
 txnType=testString[7];
 currencyName=testString[8];
 itemCode=testString[9];
 securityType=testString[10];
 securityID=testString[11];
 securityPassword=testString[12];
 txnDate=testString[13];
 authStatus=testString[14];
 settlementType=testString[15];
 additionalInfo1=testString[16];
 additionalInfo2=testString[17];
 additionalInfo3=testString[18];
 additionalInfo4=testString[19];
 additionalInfo5=testString[20];
 additionalInfo6=testString[21];

 additionalInfo7=testString[22];
 errorStatus=testString[23];
 errorDescription=testString[24];
 checkSum=testString[25];

 String seqqry1="Select to_char(sysdate,'dd-mm-yyyy hh24:mi:ss') from dual";
  rs= db.getRowset(seqqry1);
	if (rs.next())
	   {
		txnDate=rs.getString(1);
	   }
  //----------------------




//to update status of PG#TRANSACTION
   qry=" update PG#TRANSACTION set TRANSACTIONFLAG='"+statusFlag+"' where tid='"+txid+"'";
   n=db.update(qry);
 
// to insert into PG#TRANSACTIONREPLY
qry=" insert into PG#TRANSACTIONREPLY(TID,RESPONSEMESSAGE,BANKREFNO,BANKCODE,TRANSDATE,TRANSAMT ) "+
    " values('"+customerID+"','"+realRespMsg+"','"+bankReferenceNo+"','"+bankID+"',to_date('"+txnDate+"','dd-mm-yyyy hh24:mi:ss'),'"+txnAmount+"')";
n=db.insertRow(qry);
// to insert into PG#FEETRANSACTIONMASTER

//-----------pending params---------------

qry="select CURRENCYCODE from currencymaster where accountingcurrency='Y' and nvl(deactive,'N')='N'";
rs=db.getRowset(qry);
if(rs.next()){
	feecurrencycode=rs.getString(1)==null?"":rs.getString(1);			
	paymentCurrencyCode=rs.getString(1)==null?"":rs.getString(1);		
	}
//-------------------------------------------	
qry="insert into PG#FEETRANSACTIONMASTER( "+
	" COMPANYCODE,TID,INSTITUTECODE,REGCODE,STUDENTID,TRANSDATETIME,FEECURRENCYCODE,FEEDUEAMOUNT,FEEPAIDAMOUNT, "+
	" OTHERCHARGESAMOUNT, PAYMENTCURRENCYCODE, TOTALPAIDAMOUNT, TRANSACTIONDONEBY,TRANSACTIONSTATUS, TRANSACTIONID, REMARKS) "+
	" values ('"+mCompanyCode+"','"+customerID+"','"+mInstituteCode+"','"+regCode+"','"+studentId+"',to_date('"+txnDate+"','dd-mm-yyyy hh24:mi:ss'),"+
	"'"+feecurrencycode+"','"+feeAmt+"','"+txnAmount+"',"+
	"'"+transCarges+"','"+paymentCurrencyCode+"','"+totalFeeAmt+"','"+studentId+"','"+statusFlag+"','"+customerID+"', '')";
	n=db.insertRow(qry);

if("S".equals(statusFlag)){// if paymen successfully done then Call postPGFeeData preocedure.
String pInstituteCode="";	String  pGlobalCompany="";	String  pWithRegCode="";	String pAcademicYear="";	String pStudentID="";
String pRegCode="";			String  pForREGCODE="";		String  pCategoryCode="";	String pQuota="";			String  pProgramCode="";
String pBranchCode="";		String  pSectionCode="";	String  pSubSectionCode="";	int pSemester=0;		    int pCurSemester=0;
String pSemesterType="";	String  pHostelAllow="";	String  pHostelType="";		String pEnrollmentNo="";	double pTotalFeeAmount=0.0d;
double pTotalFeePaidAmount=0.0d; 						Date pTransDateTime=null;   String  pCurrencyCode="";  	String pPGTransactionID="";
String mMemberID="";
    
SimpleDateFormat sdFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
try{
dt = sdFormat.parse(txnDate);
}catch(Exception  e){
System.out.println(e);
}
   	pInstituteCode= session.getAttribute("pinstitutecode")==null?"":session.getAttribute("pinstitutecode").toString();
	pGlobalCompany=session.getAttribute("pglobalcompany")==null?"":session.getAttribute("pglobalcompany").toString();
	pWithRegCode=session.getAttribute("pwithregcode")==null?"":session.getAttribute("pwithregcode").toString();  
	pAcademicYear=session.getAttribute("pacademicyear")==null?"":session.getAttribute("pacademicyear").toString();  
	pStudentID=session.getAttribute("pstudentid")==null?"":session.getAttribute("pstudentid").toString();  
	pRegCode=session.getAttribute("pregcode")==null?"":session.getAttribute("pregcode").toString();  
	pForREGCODE=session.getAttribute("pforregcode")==null?"":session.getAttribute("pforregcode").toString();  
	pCategoryCode=session.getAttribute("pcategorycode")==null?"":session.getAttribute("pcategorycode").toString();  
	pQuota=session.getAttribute("pquota")==null?"":session.getAttribute("pquota").toString();  
	pProgramCode=session.getAttribute("pprogramcode")==null?"":session.getAttribute("pprogramcode").toString();  
	pBranchCode=session.getAttribute("pbranchcode")==null?"":session.getAttribute("pbranchcode").toString();  
	pSectionCode=session.getAttribute("psectioncode")==null?"":session.getAttribute("psectioncode").toString();  
	pSubSectionCode=session.getAttribute("psubsectioncode")==null?"":session.getAttribute("psubsectioncode").toString();  
	pSemester=Integer.parseInt(session.getAttribute("psemester")==null?"0":session.getAttribute("psemester").toString());  
	pCurSemester=Integer.parseInt(session.getAttribute("pcurSemester")==null?"0":session.getAttribute("pcurSemester").toString());  
	pSemesterType=session.getAttribute("psemestertype")==null?"":session.getAttribute("psemestertype").toString();  
	pHostelAllow=session.getAttribute("phostelallow")==null?"":session.getAttribute("phostelallow").toString();  
	pHostelType=session.getAttribute("phosteltype")==null?"":session.getAttribute("phosteltype").toString();  
	pEnrollmentNo=session.getAttribute("penrollmentno")==null?"":session.getAttribute("penrollmentno").toString();  
	pTotalFeeAmount=Double.parseDouble(session.getAttribute("feeAmt")==null?"0":session.getAttribute("feeAmt").toString());  
	pTotalFeePaidAmount=Double.parseDouble(txnAmount);
	pTransDateTime=new Date(dt.getTime());
	pCurrencyCode=session.getAttribute("pcurrencycode")==null?"":session.getAttribute("pcurrencycode").toString();  
	pPGTransactionID=customerID;

String mPostingCompany="";
String mFINYEAR="";
String vVoucherCode="";
String vVoucherNo="";
String vVOUCHERID="";
String vPRNO="";
String vSEM="";
String link="";

//mTempStr=db.postPGFeeData(pInstituteCode, pGlobalCompany,pWithRegCode,pAcademicYear,pStudentID, pRegCode,pForREGCODE,pCategoryCode,pQuota,pProgramCode,pBranchCode, pSectionCode,pSubSectionCode,pSemester,pCurSemester,pSemesterType, pHostelAllow, pHostelType,pEnrollmentNo,	pTotalFeeAmount,pTotalFeePaidAmount,pTransDateTime, pCurrencyCode,pPGTransactionID);

mTempStr=db.postPGFeeData(pInstituteCode, pGlobalCompany,pWithRegCode,pAcademicYear,pStudentID, pRegCode,pForREGCODE,pCategoryCode,pQuota,pProgramCode,pBranchCode, pSectionCode,pSubSectionCode,pSemester,pCurSemester,pSemesterType, pHostelAllow, pHostelType,pEnrollmentNo,	pTotalFeeAmount,pTotalFeePaidAmount,pTransDateTime, pCurrencyCode,txnreferenceNo);



if(mTempStr!=null  && !"".equals(mTempStr)){
String stemp[]=mTempStr.split("<->");
if(stemp.length>0){
if(stemp[0].equals("Success:")){
 mPostingCompany=stemp[1];
 mFINYEAR=stemp[2];
 vVoucherCode=stemp[3];
 vVoucherNo=stemp[4];
 vVOUCHERID=stemp[5];
 vPRNO=stemp[6];
 vSEM=stemp[7];
 %>
 <center>
<br/>
 <br/>
 <%
  link="../StudentFiles/FAS/PDFFeeReceipt.jsp?CompanyCode="+mCompanyCode+"&ProgramCode="+mProgramCode+"&BranchCode="+mBranchCode+"&InstituteCode="+mInstituteCode+"&SEM="+vSEM+"&PRNO="+vPRNO+"&STUDENTID="+studentId;
 %>
 <a href="<%=link%>" target="_blank">Click to Print Fee Receipt</a>
 </center>
 <%
qry="update PG#TRANSACTIONREPLY set vouchercode='"+vVoucherCode+"' ,voucherid='"+vVOUCHERID+"' ,tpslno='"+txnreferenceNo+"' where TID='"+customerID+"'" ;
n=db.update(qry);
}
else{
%>

<br/>
<center>
<b><font color="#FF0000"  size="+2">
<%out.println(stemp[0]);%>
</font></b>
</center>

<%
}
}
}  // end of if
}
}// end of  if("S".equals(statusFlag)){
}// end of if("".equals(responsemsg))
%>

<%


		session.setAttribute("regcode1","");
		session.setAttribute("feeAmt","");
		session.setAttribute("totalfeeAmt","");
		session.setAttribute("transcharges","");
		session.setAttribute("pinstitutecode","");
		session.setAttribute("pglobalcompany","");
		session.setAttribute("pwithregcode","");  
		session.setAttribute("pacademicyear","");  
		session.setAttribute("pstudentid","");  
		session.setAttribute("pregcode","");  
		session.setAttribute("pforregcode","");  
		session.setAttribute("pcategorycode","");  
		session.setAttribute("pquota","");  
		session.setAttribute("pprogramcode","");  
		session.setAttribute("pbranchcode","");  
		session.setAttribute("psectioncode","");  
		session.setAttribute("psubsectioncode","");  
		session.setAttribute("psemester","");  
		session.setAttribute("pcurSemester","");  
		session.setAttribute("psemestertype","");  
		session.setAttribute("phostelallow","");  
		session.setAttribute("phosteltype","");  
		session.setAttribute("penrollmentno","");  
		session.setAttribute("ptotalfeeamount","");  
		session.setAttribute("ptotalfeepaidamount","");  
		session.setAttribute("ptransdatetime","");  
		session.setAttribute("pcurrencycode","");  
		session.setAttribute("ppgtransactionID","");  
	



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
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}

}catch(Exception e){
System.out.println(e);
}

%>
