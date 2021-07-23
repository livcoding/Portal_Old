<%-- 
    Document   : NonAcademictempaction
    Created on : 1 Jul, 2020, 12:52:02 PM
    Author     : anoop.tiwari
--%>
<!--15-07-2020 Anoop-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page  language="java" import="java.sql.*,tietwebkiosk.*,java.text.SimpleDateFormat" %>

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
String pCurSemester1="";
String pSemester1="";

String pInstituteCode="";	String  pGlobalCompany="";	String  pWithRegCode="";	String pAcademicYear="";	String pStudentID="";
			String  pForREGCODE="";		String  pCategoryCode="";	String pQuota="";			String  pProgramCode="";
String pBranchCode="";		String  pSectionCode="";	String  pSubSectionCode="";	int pSemester=0;		    int pCurSemester=0;
String pSemesterType="";	String  pHostelAllow="";	String  pHostelType="";		String pEnrollmentNo="";	double pTotalFeeAmount=0.0d;
Date pTransDateTime=null;   String  pCurrencyCode="";  	String pPGTransactionID="";
String mMemberID="";String pFeeheads1="";String pFeeheads="";

SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh24:mm:ss");

double pTotalFeePaidAmount=0.0d;

//String	pFeeheads=session.getAttribute("feeHead")==null?"":session.getAttribute("feeHead").toString();
String	pAcademicYear1=session.getAttribute("pacademicyear")==null?"":session.getAttribute("pacademicyear").toString();
String pEnrollmentNo1=session.getAttribute("penrollmentno")==null?"":session.getAttribute("penrollmentno").toString();
strResponseMsg=request.getParameter("msg")==null?"":request.getParameter("msg");

//strResponseMsg="GbWZh2VKmU+utC2bjNRyPS/bp+VTg1eb3oKy9o0BQa74+n5hcwQtik5ew80+HVn06AGQUeIF+w2HvZA2sNNYHeIoFI+mhA5Ykc+ZBM2NDGswg5Wr5mj9ICFbA8hVEJfQ19CASD3CGSl+rLgWW5MzvhdjijNEbLWpCV6YZ+OcbGka2i0iHgcOiwd8NhG+GVEOmZPyYpJrje4/u0hsZYK3slSpa3T7qpLajNsAGITuOs7nIvadbDbv4thk8upllufUpGEP1iN6cuitbZVMffhrynxeSydJmNfrYXq+01kiECJPzVUk7cUStqZ4BQb5TtZhbwcniTrI90RJYvk8ZjFWfqNgXpInzdaUwY1LkQqkLowf+j0mhesbjPTgMz0kVIKXMVuRrsdB6cRPNqoCOKoXBZS4Koo3aWhqkjAW8Ad3pslWlDWd9f1lp7pd5klLEkQ4CdXxJF+ORPTnPpv4sqkEXCWQFyCHqMF2jzDprz6U5JL1VzCC+D8hYGcremmxGJ62";
//System.out.println("strResponseMsg "+strResponseMsg);


if(strResponseMsg!=null && !strResponseMsg.equalsIgnoreCase("")){

        com.tp.pg.util.TransactionResponseBean beanObj=new com.tp.pg.util.TransactionResponseBean();
	// String key="5858078564YPSXUK";
	// String iv="3652599254QRSGAB";
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
        //out.println(resrString);
        System.out.println("Return String "+resrString);
       // String realRespMsg="txn_status=0300|txn_msg=success|txn_err_msg=NA|clnt_txn_ref=PGTX2019010000000088|tpsl_bank_cd=1170|tpsl_txn_id=667552334|txn_amt=10000.00|clnt_rqst_meta={itc:JIIT1501384~FASTRACK19~JIIT~10000.00~UNIV~Y~FASTRACK19~7~REG~Y~N~8}|tpsl_txn_time=11-01-2019 16:35:16|tpsl_rfnd_id=NA|bal_amt=NA|rqst_token=97090e5d-2c8d-4570-a945-aba392862a50|hash=60efce879afda405b549dd7efc3a3f468ceac974";//resrString;";//resrString;
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
        // txnDate="18-07-2019 11:05:05";
         authStatus=testString[0];


         metaData1=metaData1.substring(metaData1.lastIndexOf(":")+1);

         String[] metaArr = metaData1.split("~");
         pStudentID=metaArr[0];
         pForREGCODE=metaArr[1];
         pInstituteCode=metaArr[2];
         pTotalFeeAmount=Double.parseDouble(metaArr[3].toString());
         pGlobalCompany=metaArr[4];
         pWithRegCode=metaArr[5];
         pFeeheads=metaArr[6];
         pCurSemester1=metaArr[7];
         pSemesterType=metaArr[8];
         pHostelAllow=metaArr[9];
         pFeeheads1=metaArr[10];
         pSemester1=metaArr[11];
         //pAcademicYear=metaArr[2];
         
       //  pEnrollmentNo=metaArr[4];
           //enstudentId+"~"+regCode+"~"+instituteCode+"~"+feeAmt+"~"+pGlobalCompany+"~"+pWithRegCode+"~"+pForREGCODE+"~"+pCurSemester+"~"+pSemesterType+"~"+pHostelAllow+"~"+pHostelType+"~"+pSemester);
         //pFeeheads=metaArr[6];
         //pGlobalCompany=metaArr[4];
         //pWithRegCode=metaArr[5];
        // pForREGCODE=metaArr[6];
         //pCurSemester=Integer.parseInt(metaArr[7]);
        // pSemesterType=metaArr[8];
       //  pHostelAllow=metaArr[9];
       //  pHostelType=metaArr[10];
      //   pSemester=Integer.parseInt(metaArr[11].replace("}", ""));


        qry="select nvl(ACADEMICYEAR,' ')ACADEMICYEAR,nvl(PROGRAMCODE,' ')PROGRAMCODE, ";
        qry=qry +" nvl(BRANCHCODE,' ')BRANCHCODE,nvl(SEMESTER,0)SEMESTER, ";
	qry=qry +"nvl(SECTIONCODE,' ')SECTIONCODE,nvl(SUBSECTIONCODE,' ')SUBSECTIONCODE,nvl(ENROLLMENTNO,' ')ENROLLMENTNO ,nvl(QUOTA,' ')QUOTA,nvl(CATEGORY,' ')CATEGORY from STUDENTMASTER ";
 	qry=qry +" where STUDENTID='"+pStudentID+"' and INSTITUTECODE='"+pInstituteCode+"' ";

        ResultSet rs4=db.getRowset(qry);
	if (rs4.next())
	{
        pAcademicYear=rs4.getString("ACADEMICYEAR");
	pProgramCode=rs4.getString("PROGRAMCODE");
	pBranchCode=rs4.getString("BRANCHCODE");
	pSemester=Integer.parseInt(rs4.getString("SEMESTER"));
        pSectionCode=rs4.getString("SECTIONCODE");
	pSubSectionCode=rs4.getString("SUBSECTIONCODE");
	pEnrollmentNo=rs4.getString("ENROLLMENTNO");
        pQuota=rs4.getString("QUOTA");
	pCategoryCode=rs4.getString("CATEGORY");


        }
        pStudentID=pStudentID;
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
    " values('"+customerID+"','"+resrString+"','"+txnreferenceNo+"','"+bankReferenceNo+"',to_date('"+txnDate+"','dd-mm-yyyy hh24:mi:ss'),'"+txnAmount+"')";
n=db.insertRow(qry);
// to insert into PG#FEETRANSACTIONMASTER

//-----------pending params---------------

qry="select CURRENCYCODE from currencymaster where accountingcurrency='Y' and nvl(deactive,'N')='N'";
rs=db.getRowset(qry);
if(rs.next()){
	pCurrencyCode=rs.getString(1)==null?"":rs.getString(1);
	paymentCurrencyCode=rs.getString(1)==null?"":rs.getString(1);
	}
//-------------------------------------------
qry="insert into PG#FEETRANSACTIONMASTER( "+
	" COMPANYCODE,TID,INSTITUTECODE,REGCODE,STUDENTID,TRANSDATETIME,FEECURRENCYCODE,FEEDUEAMOUNT,FEEPAIDAMOUNT, "+
	" OTHERCHARGESAMOUNT, PAYMENTCURRENCYCODE, TOTALPAIDAMOUNT, TRANSACTIONDONEBY,TRANSACTIONSTATUS, TRANSACTIONID, REMARKS) "+
	" values ('"+pGlobalCompany+"','"+customerID+"','"+pInstituteCode+"','NONACADEMIC','"+pStudentID+"',to_date('"+txnDate+"','dd-mm-yyyy hh24:mi:ss'),"+
	"'"+pCurrencyCode+"','"+pTotalFeeAmount+"','"+txnAmount+"',"+
	"'"+transCarges+"','"+paymentCurrencyCode+"','"+pTotalFeeAmount+"','"+pStudentID+"','"+statusFlag+"','"+customerID+"', '')";
	n=db.insertRow(qry);

        pTotalFeePaidAmount=Double.parseDouble(txnAmount);
        //pTotalFeePaidAmount=200.0;

        String mPostingCompany="";
        String mFINYEAR="";
        String vVoucherCode="";
        String vVoucherNo="";
        String vVOUCHERID="";
        String vPRNO="";
        String vSEM="";
        String link="";

        mTempStr=db.PostPGNAFee(pInstituteCode,pGlobalCompany,pAcademicYear,pStudentID,pEnrollmentNo,pTotalFeeAmount,pTotalFeePaidAmount,pFeeheads,pTransDateTime,pCurrencyCode,txnreferenceNo);
        System.out.println(pInstituteCode+" "+ pGlobalCompany+" "+pAcademicYear+" "+pStudentID+" "+pEnrollmentNo+" "+ pTotalFeeAmount+" "+pTotalFeePaidAmount+" "+pFeeheads+" "+pTransDateTime+" "+pCurrencyCode+" "+txnreferenceNo);
        if(mTempStr!=null  && !"".equals(mTempStr)){
            String stemp[]=mTempStr.split("<->");
            if(stemp.length>0){
            if(stemp[0].equals("Success:")){
             mPostingCompany=stemp[1];
             mFINYEAR=stemp[2];
             vVoucherCode=stemp[3];
             vVoucherNo=stemp[4];
             vVOUCHERID=stemp[5];
             //vPRNO=stemp[6];
            // vSEM=stemp[7];
             %>
             <center>
            <br/>
             <br/>
             <%
            //  link="../NonAcademicPDFFeeReceipt.jsp?CompanyCode="+pGlobalCompany+"&ProgramCode="+pProgramCode+"&BranchCode="+pBranchCode+"&InstituteCode="+pInstituteCode+"&STUDENTID="+pStudentID;
             %>
            <!-- <a href="<%=link%>" target="_blank">Click to Print Fee Receipt</a>-->

             <center>
            <b>
                <BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=no>
           <font>
              <br>
	<font color=blue>
	<h3>	<br> Transaction  completed  </h3><br>
		<br>	<br>
           </font>
            </body>

            </center>

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
	<br>	<br>	<br>	<br>
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

