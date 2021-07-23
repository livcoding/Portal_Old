<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*,pgwebkiosk.*,java.io.*" %>
<%@ page import="com.CheckSumRequestBean"%>


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
String instituteCode=session.getAttribute("InstituteCode")==null?"":session.getAttribute("InstituteCode")+"";
String mIPAddress=session.getAttribute("IPADD")==null?"":(session.getAttribute("IPADD").toString().trim());
String feeAmt=request.getParameter("feeamount")==null?"":request.getParameter("feeamount").toString();

String transType=request.getParameter("options")==null?"":request.getParameter("options");
strBankCode="N/A";
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
String strPropPath="";


if("JPBS".equalsIgnoreCase(instituteCode))
{
	strMarketCode="L2839";


	strPropPath="/u01/jboss/EAP/standalone/MerchantDetails1.properties";
}
else
{
	strMarketCode= "L2835";
	strPropPath="/u01/jboss/EAP/standalone/MerchantDetails.properties";
}


String regCode=request.getParameter("regcode")==null?"":request.getParameter("regcode");
enrollNo=request.getParameter("enrollno")==null?"":request.getParameter("enrollno");
stdName=request.getParameter("studentname")==null?"":request.getParameter("studentname");
stdFName=request.getParameter("fathername")==null?"":request.getParameter("fathername");
dateofbirth=request.getParameter("dateofbirth")==null?"":request.getParameter("dateofbirth");
String mTime="";
qry="select to_char(TRANSDATETIME,'dd-mm-yyyy hh:mi:ss am')TRANSDATETIME  from (select * from LOGTRANSINFO  a where a.MEMBERID ='"+mChkMemID+"'  and a.TRANSTYPE='LASTLOGIN' AND A.TRANSDATETIME < SYSDATE  and a.TRANSDATETIME not in (select max(TRANSDATETIME) from LOGTRANSINFO where MEMBERID ='"+mChkMemID+"'  and TRANSTYPE='LASTLOGIN') ORDER BY A.TRANSDATETIME desc) where rownum<2";

rs=db.getRowset(qry);
if(rs.next())
{
	mTime=rs.getString("TRANSDATETIME");
}

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

<form  id="pgform"action="https://www.tpsl-india.in/PaymentGateway/TransactionRequest.jsp" method="post">
<input type="hidden" name="msg"  value="<%=strMsg%>"/>
</form>

<%
}else if(myprocs==2)
{
response.sendRedirect("https://www.tpsl-india.in/PaymentGateway/TransactionRequest.jsp?msg="+strMsg);
}
}catch(Exception e){
System.out.println(e);
}
}// end of session.
%>
</body>
</html>