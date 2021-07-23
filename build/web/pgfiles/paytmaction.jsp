<%-- 
    Document   : paytmaction
    Created on : 12 Jul, 2018, 2:24:49 PM
    Author     : VIVEK.SONI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,pgwebkiosk.*,java.io.*,java.util.*,com.paytm.pg.merchant.CheckSumServiceHelper,jilit.PaytmConstantsValue" %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>

    

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

 
 /* public final  String MERCHANT_KEY="kbzk1DSbJiV_O3p5";
  public final  String INDUSTRY_TYPE_ID="Retail";
  public final  String CHANNEL_ID="WEB";
  public final  String WEBSITE="worldpressplg";
  public final  String PAYTM_URL="https://securegw-stage.paytm.in/theia/processTransaction";*/

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
String strTxnAmount=request.getParameter("feeamount")==null?"":request.getParameter("feeamount").toString();
String feeAmt=request.getParameter("feeamount")==null?"":request.getParameter("feeamount").toString();
String transType=request.getParameter("options")==null?"":request.getParameter("options");
strBankCode="N/A";

String regCode=request.getParameter("regcode")==null?"":request.getParameter("regcode");
enrollNo=request.getParameter("enrollno")==null?"":request.getParameter("enrollno");
stdName=request.getParameter("studentname")==null?"":request.getParameter("studentname");
stdFName=request.getParameter("fathername")==null?"":request.getParameter("fathername");
dateofbirth=request.getParameter("dateofbirth")==null?"":request.getParameter("dateofbirth");
String mTime="";

TreeMap<String,String> parameters = new TreeMap<String,String>();
String paytmChecksum =  "";
String TXID=db.GenerateID(instituteCode, "PGTRANS") ;
String strTranID=TXID;

try{
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




parameters.put("trnsID",strTranID);
parameters.put("tamt",strTxnAmount);
parameters.put("MID",PaytmConstantsValue.MID);
parameters.put("CHANNEL_ID",PaytmConstantsValue.CHANNEL_ID);
parameters.put("INDUSTRY_TYPE_ID",PaytmConstantsValue.INDUSTRY_TYPE_ID);
parameters.put("WEBSITE",PaytmConstantsValue.WEBSITE);
parameters.put("CALLBACK_URL", "http://172.16.5.219:8084/pgfiles/paytmResponse.jsp");

String checkSum =  CheckSumServiceHelper.getCheckSumServiceHelper().genrateCheckSum("kbzk1DSbJiV_O3p5", parameters);

StringBuilder outputHtml = new StringBuilder();
outputHtml.append("<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>");
outputHtml.append("<html>");
outputHtml.append("<head>");
outputHtml.append("<title>Merchant Check Out Page</title>");
outputHtml.append("</head>");
outputHtml.append("<body>");
outputHtml.append("<center><h1>Please do not refresh this page...</h1></center>");
outputHtml.append("<form method='post' action='"+ PaytmConstantsValue.PAYTM_URL +"' name='payform'>");
outputHtml.append("<table border='1'>");
outputHtml.append("<tbody>");

for(Map.Entry<String,String> entry : parameters.entrySet()) {
	String key = entry.getKey();
	String value = entry.getValue();
	outputHtml.append("<input type='hidden' name='"+key+"' value='" +value+"'>");
}



outputHtml.append("<input type='hidden' name='CHECKSUMHASH' value='"+checkSum+"'>");
outputHtml.append("</tbody>");
outputHtml.append("</table>");
outputHtml.append("<script type='text/javascript'>");
outputHtml.append("document.payform.submit();");
outputHtml.append("</script>");
outputHtml.append("</form>");
outputHtml.append("</body>");
outputHtml.append("</html>");
out.println(outputHtml);

}catch(Exception ex){
ex.printStackTrace();
}

}
%>
</html>
