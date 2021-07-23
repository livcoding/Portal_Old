<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modified Date 15-07-2020 Anoop -->
<%@ page language="java" import="java.sql.*,pgwebkiosk.*,java.io.*" %>
<%@ page import="com.CheckSumRequestBean"%>
<%@page import="com.tp.pg.util.TransactionRequestBean"%>


<html>
<head>
 <script type="text/javascript" src="js/jquery-1.4.2.js"></script>

<script type="text/javascript">

$(document).ready(function(){

$("#pgform").submit();
      });

</script>


</head>


<body>
<%

if(session.getAttribute("MemberID")==null){
	response.sendRedirect("StudentFeeHistory.jsp");
}else{

String browserType=request.getHeader("User-Agent");
int myprocs=0;
if(browserType.indexOf("MSIE") > 0) {
myprocs=1;
}
else {
myprocs=2;
}

/*if(!session.getAttribute("ptotalfeeamount").toString().equalsIgnoreCase(request.getParameter("feeamount"))){
response.sendRedirect("tempared.jsp");
}*/

OLTEncryption enc=new OLTEncryption();
String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());

String s=null;
String qry="";
DBHandler db=new DBHandler();
ResultSet rs=null;
int n=0;
String strBankCode="";
String enrollNo="";
String stdName="";
String stdFName="";
String dateofbirth="";
String logintimdeate="";
String remarks="";
String poid="";
String txdttime="";
String txtprocess="";
String sCurrancycode="INR";
//String locatatorURL="https://www.tpsl-india.in/PaymentGateway/services/TransactionDetailsNew";

String locatatorURL="https://payments.paynimo.com/PaynimoProxy/services/TransactionLiveDetails";


String instituteCode=session.getAttribute("InstituteCode")==null?"":session.getAttribute("InstituteCode")+"";
String mIPAddress=session.getAttribute("IPADD")==null?"":(session.getAttribute("IPADD").toString().trim());
String feeAmt=request.getParameter("feeamount")==null?"":request.getParameter("feeamount").toString();
String transType=request.getParameter("options")==null?"":request.getParameter("options");
strBankCode="NA";

String  pGlobalCompany=session.getAttribute("pglobalcompany")==null?"":session.getAttribute("pglobalcompany").toString();
//String	pWithRegCode=session.getAttribute("pwithregcode")==null?"":session.getAttribute("pwithregcode").toString();
String	pWithRegCode="Y";
//String	pForREGCODE=session.getAttribute("pforregcode")==null?"":session.getAttribute("pforregcode").toString();
//String	pForREGCODE="NONACADEMIC";
String	pForREGCODE=session.getAttribute("feeHead")==null?"":session.getAttribute("feeHead").toString();
String	pCurSemester=session.getAttribute("pcurSemester")==null?"0":session.getAttribute("pcurSemester").toString();
//String	pCurSemester="REG";
//String	pSemesterType=session.getAttribute("psemestertype")==null?"":session.getAttribute("psemestertype").toString();
String	pSemesterType="REG";
//String	pHostelAllow=session.getAttribute("phostelallow")==null?"":session.getAttribute("phostelallow").toString();
String	pHostelAllow="N";
//String	pHostelType=session.getAttribute("phosteltype")==null?"":session.getAttribute("phosteltype").toString();
String	pHostelType=session.getAttribute("feeHead")==null?"":session.getAttribute("feeHead").toString();
//String  pSemester=session.getAttribute("psemester")==null?"0":session.getAttribute("psemester").toString();
String  pSemester=session.getAttribute("pcurSemester")==null?"0":session.getAttribute("pcurSemester").toString();
//String  pSemester="REG";







/*
if("C".equals(transType)){
strBankCode=request.getParameter("cpocode")==null?"":request.getParameter("cpocode");//"670";
poid=request.getParameter("cpoid")==null?"":request.getParameter("cpoid");//"670";
}else if("N".equals(transType))
{
strBankCode=request.getParameter("netbanks")==null?"":request.getParameter("netbanks");
poid=request.getParameter("bpoid")==null?"":request.getParameter("bpoid");;
}
*/
String TXID=db.GenerateID(instituteCode, "PGTRANS") ;

try{
String strTranID=TXID;
String strMarketCode= "";
String strAcctNo="1";
String strTxnAmount=request.getParameter("feeamount")==null?"":request.getParameter("feeamount");
//strTxnAmount=enc.decode(strTxnAmount);
//feeAmt=enc.decode(feeAmt);

//String strTxnAmount="2";//request.getParameter("feeamount")==null?"":request.getParameter("feeamount");

String strPropPath="";


/*strMarketCode= "L2837";
strPropPath=application.getRealPath("")+"\\pgfiles\\MerchantDetails.properties";*/

//String regCode=request.getParameter("regcode")==null?"":request.getParameter("regcode");
String regCode="NONACADEMIC";
enrollNo=request.getParameter("enrollno")==null?"":request.getParameter("enrollno");
stdName=request.getParameter("studentname")==null?"":request.getParameter("studentname");
stdFName=request.getParameter("fathername")==null?"":request.getParameter("fathername");
dateofbirth=request.getParameter("dateofbirth")==null?"":request.getParameter("dateofbirth");
String mTime="";
String mTranDate="";

//regCode=enc.decode(regCode);
//enrollNo=enc.decode(enrollNo);



qry="SELECT TO_CHAR (max(LOGINDATETIME), 'dd-mm-yyyy hh:mi:ss am') TRANSDATETIME FROM MEMBERLOGINFO a WHERE a.MEMBERID = '"+mChkMemID+"' ";
rs=db.getRowset(qry);
if(rs.next())
{
	mTime=rs.getString("TRANSDATETIME");
}

String[] testString = mTime.split(" ");
mTranDate=testString[0];

// mTranDate=mTime.split(" ").toString();


String enstudentId=enc.decode(session.getAttribute("MemberID").toString().trim());

TransactionRequestBean objTransactionRequestBean = new TransactionRequestBean();

    objTransactionRequestBean.setStrRequestType("T");
    //objTransactionRequestBean.setStrMerchantCode(strMarketCode);
    objTransactionRequestBean.setStrMerchantCode("T554891");  //T2835 for test and amount T554891 must be 2 user will be test and password will be test
    objTransactionRequestBean.setMerchantTxnRefNumber(strTranID);
    //objTransactionRequestBean.setStrAmount(feeAmt);
    String schema="";
    pHostelType="N";
    objTransactionRequestBean.setStrAmount("2");                        // to be change with strTxnAmount
    objTransactionRequestBean.setStrCurrencyCode(sCurrancycode);
    objTransactionRequestBean.setStrITC(enstudentId+"~"+regCode+"~"+instituteCode+"~"+feeAmt+"~"+pGlobalCompany+"~"+pWithRegCode+"~"+pForREGCODE+"~"+pCurSemester+"~"+pSemesterType+"~"+pHostelAllow+"~"+pHostelType+"~"+pSemester);
   // String schema="JPBS_"+strTxnAmount+"_0.0";
    if(instituteCode.equals("JPBS"))
    {
    //schema="JPBS_"+strTxnAmount+"_0.0";
    objTransactionRequestBean.setStrShoppingCartDetails("JPBS_2_0.0");
    }
    else
    {
     //schema="FIRST_"+strTxnAmount+"_0.0";
      objTransactionRequestBean.setStrShoppingCartDetails("FIRST_2_0.0");
    }
    //objTransactionRequestBean.setStrShoppingCartDetails(schema);

    objTransactionRequestBean.setTxnDate(mTranDate);                 // to be change
    System.out.println("Heeee");
    //objTransactionRequestBean.setStrBankCode("470");                    // to be change
    objTransactionRequestBean.setWebServiceLocator(locatatorURL);
    objTransactionRequestBean.setStrTPSLTxnID("");
    objTransactionRequestBean.setCardID("");
   // objTransactionRequestBean.setCustID(session.getAttribute("MemberID").toString().trim());
    //objTransactionRequestBean.setAdditionalInfo(regCode);
    objTransactionRequestBean.setAccountNo("");
    objTransactionRequestBean.setStrTimeOut("");
    objTransactionRequestBean.setStrS2SReturnURL("");
    objTransactionRequestBean.setStrMobileNumber("");
    objTransactionRequestBean.setStrEmail("");
   // objTransactionRequestBean.set
    objTransactionRequestBean.setStrReturnURL("http://172.16.5.181:8084/JIIT2020/pgfiles/NonAcademictempaction.jsp");//http://172.16.5.219:8084 //https://webkiosk.juet.ac.in

    //String enkey = "5858078564YPSXUK";
    //String eniv = "3652599254QRSGAB";
   // String enkey = "5858078564YPSXUK";
   // String eniv = "3652599254QRSGAB";
   String enkey = "9907488675SXEMER";
   String eniv = "5195881443DEQBSO";

    objTransactionRequestBean.setKey(enkey.getBytes());
    System.out.println("Key: "+enkey);
    System.out.println("IV: "+eniv);
    objTransactionRequestBean.setIv(eniv.getBytes());
    String token=objTransactionRequestBean.getTransactionToken();
    System.out.println("token: "+token);



qry="insert into PG#TRANSACTION(TID,SOURCEFLAG,TRANSDATETIME,CUSTOMERTYPE,ENROLLMENTNO,COUNSELLINGRANK,STUDENTNAME, "+
           " FATHERSNAME,DOB,LOGINDATETIME,IPADDRESS,REMARKS,INSTITUTECODE,POID,TRANSACTIONFLAG,StudentID,ExamCode)"+
           " values('"+strTranID+"','F',sysdate,'K','"+enrollNo+"','','"+stdName+"','"+stdFName+"',to_date('"+dateofbirth+"','dd/mm/yyyy'),"+
		   " to_date('"+mTime+"','dd-mm-yyyy hh:mi:ss am'),"+
		   "'"+mIPAddress+"','"+remarks+"','"+instituteCode+"','"+poid+"','P','"+mChkMemID+"','"+regCode+"')";

		   session.setAttribute("regcode1",regCode);
		   session.setAttribute("feeAmt",feeAmt);
		   session.setAttribute("totalfeeAmt",strTxnAmount);
		   session.setAttribute("txid",strTranID);
	n=db.insertRow(qry);

         response.sendRedirect(token);
System.out.println("");
/*


//	strTxnAmount="20";
CheckSumRequestBean objTranDetails = new CheckSumRequestBean();
objTranDetails.setStrMerchantTranId(strTranID);
objTranDetails.setStrMarketCode(strMarketCode);
objTranDetails.setStrAccountNo(strAcctNo);
objTranDetails.setStrAmt(strTxnAmount);
objTranDetails.setStrBankCode(strBankCode);
objTranDetails.setStrPropertyPath(strPropPath);
com.TPSLUtil util = new com.TPSLUtil();

String strMsg = "";
strMsg=util.transactionRequestMessage(objTranDetails);

if(myprocs==1)
{
%>
<!--
<form  id="pgform"action="https://www.tpsl-india.in/PaymentGateway/TransactionRequest.jsp" method="post">
<input type="hidden" name="msg"  value="<%=strMsg%>"/>
</form>

<%
}else if(myprocs==2)
{
response.sendRedirect("https://www.tpsl-india.in/PaymentGateway/TransactionRequest.jsp?msg="+strMsg);
}* */
}catch(Exception e){
System.out.println(e);
}
}// end of session.
%>
-->
</body>
</html>