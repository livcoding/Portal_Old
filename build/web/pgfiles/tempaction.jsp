<%--
    Document   : tempaction
    Created on : 18 Sep, 2018, 3:44:29 PM
    Author     : VIVEK.SONI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page  language="java" import="java.sql.*,pgwebkiosk.*,java.text.SimpleDateFormat" %>

<%

response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

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
String invalidPNRNoMsg="";
String mProgramCode="";
String mBranchCode="";
String mCurrentSem="";
String sysDate="";
String statusFlag="";
String metaData1="";
String metaData="";
String studentId="";
String transCarges="0";
String mInstituteCode="";
String mCompanyCode="";
String feecurrencycode="";
String paymentCurrencyCode="";
String mAcademicYearCode="";
String mTempStr="";
String pRegCode="";

String pInstituteCode="";	String  pGlobalCompany="";	String  pWithRegCode="";	String pAcademicYear="";	String pStudentID="";
			String  pForREGCODE="";		String  pCategoryCode="";	String pQuota="";			String  pProgramCode="";
String pBranchCode="";		String  pSectionCode="";	String  pSubSectionCode="";	int pSemester=0;		    int pCurSemester=0;
String pSemesterType="";	String  pHostelAllow="";	String  pHostelType="";		String pEnrollmentNo="";	double pTotalFeeAmount=0.0d;
Date pTransDateTime=null;   String  pCurrencyCode="";  	String pPGTransactionID="";
String mMemberID="";

SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh24:mm:ss");

double pTotalFeePaidAmount=0.0d;


strResponseMsg=request.getParameter("msg")==null?"":request.getParameter("msg");

System.out.println("strResponseMsg "+strResponseMsg);


if(strResponseMsg!=null && !strResponseMsg.equalsIgnoreCase("")){

        com.tp.pg.util.TransactionResponseBean beanObj=new com.tp.pg.util.TransactionResponseBean();
	 String key="9907488675SXEMER";
	 String iv="5195881443DEQBSO";
         if(session.getAttribute("KEY")!=null){
		key=(String)session.getAttribute("KEY");
		iv=(String)session.getAttribute("IV");
	}
	beanObj.setIv(iv.getBytes());
	beanObj.setKey(key.getBytes());
	beanObj.setResponsePayload(strResponseMsg);
	beanObj.setLogPath("D://abc.log");
	String resrString=beanObj.getResponsePayload();
       // out.println(resrString);
        System.out.println("Return String "+resrString);
        String realRespMsg=resrString;
        String temp=resrString.replace('|', '<');
        String[] testString = temp.split("<");
        String auth=testString[0].substring(testString[0].lastIndexOf("=")+1);

        //-------------if Success Transaction than---------
        if(auth.equals("0300")  ){
         statusFlag="S";
         customerID=testString[3].substring(testString[3].lastIndexOf("=")+1); // transaction id which is send to pg at time of request
         txnreferenceNo=testString[5].substring(testString[5].lastIndexOf("=")+1);
         bankReferenceNo=testString[4].substring(testString[4].lastIndexOf("=")+1);
         txnAmount=testString[6].substring(testString[6].lastIndexOf("=")+1);
         metaData1=testString[7];
         bankID="NA";
         bankMERCHANTID="NA";
         txnType="NA";
         currencyName="INR";
         itemCode="NA";
         securityType="NA";
         securityID="NA";
         securityPassword="NA";
         txnDate=testString[8].substring(testString[8].lastIndexOf("=")+1);
         authStatus=testString[0];


         metaData1=metaData1.substring(metaData1.lastIndexOf(":")+1);

         String[] metaArr = metaData1.split("~");
         studentId=metaArr[0];
         pRegCode=metaArr[1];
         pInstituteCode=metaArr[2];

         pTotalFeeAmount=Double.parseDouble(metaArr[3].toString());  //enstudentId+"~"+regCode+"~"+instituteCode+"~"+feeAmt+"~"+pGlobalCompany+"~"+pWithRegCode+"~"+pForREGCODE+"~"+pCurSemester+"~"+pSemesterType+"~"+pHostelAllow+"~"+pHostelType+"~"+pSemester);
         pGlobalCompany=metaArr[4];
         pWithRegCode=metaArr[5];
         pForREGCODE=metaArr[6];
         pCurSemester=Integer.parseInt(metaArr[7]);
         pSemesterType=metaArr[8];
         pHostelAllow=metaArr[9];
         pHostelType=metaArr[10];
         pSemester=Integer.parseInt(metaArr[11].replace("}", ""));

        qry="select nvl(ACADEMICYEAR,' ')ACADEMICYEAR,nvl(PROGRAMCODE,' ')PROGRAMCODE, ";
        qry=qry +" nvl(BRANCHCODE,' ')BRANCHCODE,nvl(SEMESTER,0)SEMESTER, ";
	qry=qry +"nvl(SECTIONCODE,' ')SECTIONCODE,nvl(SUBSECTIONCODE,' ')SUBSECTIONCODE,nvl(ENROLLMENTNO,' ')ENROLLMENTNO ,nvl(QUOTA,' ')QUOTA,nvl(CATEGORY,' ')CATEGORY from STUDENTMASTER ";
 	qry=qry +" where STUDENTID='"+studentId+"' and INSTITUTECODE='"+pInstituteCode+"' ";

        ResultSet rs4=db.getRowset(qry);
	if (rs4.next())
	{
        pAcademicYear=rs4.getString("ACADEMICYEAR");
	pProgramCode=rs4.getString("PROGRAMCODE");
	pBranchCode=rs4.getString("BRANCHCODE");

        pSectionCode=rs4.getString("SECTIONCODE");
	pSubSectionCode=rs4.getString("SUBSECTIONCODE");
	pEnrollmentNo=rs4.getString("ENROLLMENTNO");
        pQuota=rs4.getString("QUOTA");
	pCategoryCode=rs4.getString("CATEGORY");


        }
        pStudentID=studentId;
        try{
            java.util.Date dt=null;
            SimpleDateFormat sdFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            dt = sdFormat.parse(txnDate);
            pTransDateTime=new Date(dt.getTime());
            }catch(Exception  e){
            System.out.println(e);
        }

        String seqqry1="Select to_char(sysdate,'dd-mm-yyyy hh24:mi:ss') from dual";
        rs= db.getRowset(seqqry1);
	if (rs.next())
	   {
		txnDate=rs.getString(1);
	   }

           qry=" update PG#TRANSACTION set TRANSACTIONFLAG='"+statusFlag+"' where tid='"+customerID+"'";
          n=db.update(qry);

// to insert into PG#TRANSACTIONREPLY
qry=" insert into PG#TRANSACTIONREPLY(TID,RESPONSEMESSAGE,BANKREFNO,BANKCODE,TRANSDATE,TRANSAMT ) "+
    " values('"+customerID+"','"+realRespMsg+"','"+txnreferenceNo+"','"+bankReferenceNo+"',to_date('"+txnDate+"','dd-mm-yyyy hh24:mi:ss'),'"+txnAmount+"')";
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
	" values ('"+pGlobalCompany+"','"+customerID+"','"+pInstituteCode+"','"+pRegCode+"','"+studentId+"',to_date('"+txnDate+"','dd-mm-yyyy hh24:mi:ss'),"+
	"'"+feecurrencycode+"','"+pTotalFeeAmount+"','"+txnAmount+"',"+
	"'"+transCarges+"','"+paymentCurrencyCode+"','"+pTotalFeeAmount+"','"+studentId+"','"+statusFlag+"','"+customerID+"', '')";
	n=db.insertRow(qry);

        pTotalFeePaidAmount=Double.parseDouble(txnAmount);

        String mPostingCompany="";
        String mFINYEAR="";
        String vVoucherCode="";
        String vVoucherNo="";
        String vVOUCHERID="";
        String vPRNO="";
        String vSEM="";
        String link="";

        mTempStr=db.postPGFeeData(pInstituteCode, pGlobalCompany,pWithRegCode,pAcademicYear,pStudentID, pRegCode,pForREGCODE,pCategoryCode,pQuota,pProgramCode,pBranchCode, pSectionCode,pSubSectionCode,pSemester,pCurSemester,pSemesterType, pHostelAllow, pHostelType,pEnrollmentNo,	pTotalFeeAmount,pTotalFeePaidAmount,pTransDateTime, feecurrencycode,txnreferenceNo);
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
              link="../StudentFiles/FAS/PDFFeeReceipt.jsp?CompanyCode="+pGlobalCompany+"&ProgramCode="+pProgramCode+"&BranchCode="+pBranchCode+"&InstituteCode="+pInstituteCode+"&SEM="+vSEM+"&PRNO="+vPRNO+"&STUDENTID="+studentId;
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
            <b>
                <BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=no>
           <font>
              <br>
	<font color=blue>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Transaction  completed  </h3><br>
		<br>For assistance, contact your network support team.
	<br>	<br>	<br>	<br><
           </font>
            </body>

            </center>

            <%
            }
            }
            }


        }
        //---conditional check if not success response found ----------------
        else{%>

       <BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=no>
           <font>
              <br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Transaction Not completed .........Please Try again Later  </h3><br>
	<P>
	<br>For assistance, contact your network support team.
	<br>	<br>	<br>	<br></P>
           </font>
            </body>

            <%}

 }
            %>
