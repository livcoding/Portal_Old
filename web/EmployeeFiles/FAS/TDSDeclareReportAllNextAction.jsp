<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
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
<TITLE>#### <%=mHead%> [ Tax Decleration Form/Screen] </TITLE>




<script type="text/javascript" src="js/sortabletable.js"></script>
	<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
	<script language="JavaScript" type ="text/javascript" src="../PersonalInfo/js/datetimepicker.js"></script>
<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>

<script language=javascript>

	function RefreshContents()
	{ 	
    	document.frm.x.value='ddd';
    	document.frm.submit();
	}
//-->
</SCRIPT>


</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mFinYear="";
String mDMemberCode="",mDDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String mType = "",mComp=""; 
String qry="", qryupdate="",EDICODE="",qry2="",qry1="",mStatus="",mSave="",qrypan="";
int mRights=0,w=0;

ResultSet rsSub =null,rs=null,rss=null,rs1=null,rs11=null;


ResultSet rs2=null;
String EDITYPE="",sectionCode="",RecAmt="",DECLARATIONAMOUNT1="",ACTUALAMOUNT1="";
int ctr=0,i=0;
	int parasno=0,addparasno=0;
long IAMOUNT=0,mInvesID=0,ACTUALAMOUNT=0,mSectionInvesID=0,ADDIAMOUNT=0,mADDInvesID=0,ADDACTUALAMOUNT=0,mCountInvestID=0;
		String IDESCRIPTION="",ACTUALRECEIVE="",SectionCode="";
				String ADDIDESCRIPTION="",ADDACTUALRECEIVE="";


if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
							


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}


if (request.getParameter("Faculty")==null)
{
	mMemberID="";
}
else
{
	mMemberID=request.getParameter("Faculty").toString().trim();
}





if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


	qry="select distinct nvl(EMPLOYEENAME,' ')EMPLOYEENAME ,nvl(employeeid,' ')employeeid, nvl(employeename,' ')FacultyName,nvl(employeecode,' ')employeecode,nvl(EMPLOYEETYPE,' ')EMPLOYEETYPE from employeemaster where ";
	qry=qry +" companycode='"+mComp+"' and nvl(deactive,'N')='N' and employeeid='"+mMemberID+"'  ";
	//out.print(qry);
	rs=db.getRowset(qry);
	if(rs.next())
	{
mMemberCode=rs.getString("employeecode").toString().trim();
//mMemberType=rs.getString("EMPLOYEETYPE").toString().trim();
mMemberID=rs.getString("employeeid").toString().trim();
mMemberName=rs.getString("EMPLOYEENAME").toString().trim();
	}

mMemberType="E";
OLTEncryption enc=new OLTEncryption();
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
  {
	mDMemberCode=mMemberCode;
	mDDMemberType=mMemberType;
	mDMemberID=mMemberID;

	String mChkMemID=mMemberID;
	String mChkMType=mMemberType;
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());

	ResultSet RsChk1=null;
	ResultSet r=null;

	
	// ------------------------------
	// out.print(qry);
	// ------------------------------
      // -- Enable Security Page Level  
      // ------------------------------

	if(mType.equals("D"))
	{
	   mRights=166;
	}
	else if(mType.equals("H"))
	{
	   mRights=167; 	
	}
	else 
	{
	   mRights=168;
	}
	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";	
      RsChk1= db.getRowset(qry);
	
	//out.print(qry);

	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
   %>


	<form name="frm" method=post>
	<INPUT TYPE="hidden" NAME="Faculty" id="Faculty" value="<%=mMemberID%>">
<%

int sno=0,mFlag=0,mFlag1=0;
long DeclarationAmt=0,ReceiptAmt=0;

String mEDIDCODE="",mEDITYPE="",mTDSCode="",mFinancialYear="",mDeclareDate="";
String mAssessYear="",FINAL="",qryinsert="",mCategoryCode="",mFreeze="",Panno="";

String mParaValue="",PARAEDICODE="",PARAMETERID="",PARAEDITYPE="",mParaDesc="",SrCitizen="",FINANCIALYEAR1="";


if(request.getParameter("sno")==null)
	sno=0;
else
	sno=Integer.parseInt(request.getParameter("sno"));

if(request.getParameter("mFinancialYear")==null)
	mFinancialYear="";
else
	mFinancialYear=request.getParameter("mFinancialYear");


if(request.getParameter("mDeclareDate")==null)
	mDeclareDate="";
else
	mDeclareDate=request.getParameter("mDeclareDate");


if(request.getParameter("mAssessYear")==null)
	mAssessYear="";
else
	mAssessYear=request.getParameter("mAssessYear");


if(request.getParameter("mTDSCode")==null)
	mTDSCode="";
else
	mTDSCode=request.getParameter("mTDSCode");


if(request.getParameter("SrCitizen")==null)
	SrCitizen="";
else
	SrCitizen=request.getParameter("SrCitizen");

if(request.getParameter("Panno")==null)
	Panno="";
else
	Panno=request.getParameter("Panno").toString().trim();





	if(request.getParameter("FINANCIALYEAR1")==null)
	FINANCIALYEAR1="";
else
	FINANCIALYEAR1=request.getParameter("FINANCIALYEAR1");

//out.print(FINANCIALYEAR1+"adasd"+SrCitizen);

if(request.getParameter("mStatus")==null)
		{
			mStatus="";
		}
		else
		{
			mStatus=request.getParameter("mStatus");
			
		}

String mFinalFreeze="N";

if(mStatus.equals("F"))
	mFinalFreeze="Y";

if(request.getParameter("Save")==null)
		{
			mSave="N";
		}
		else
		{
			mSave=request.getParameter("Save");
			
		}

//out.print(request.getParameter("PrintFreeze")+"ssdfskjhhdfsdf"+request.getParameter("chkDeclare"));

mFreeze="Y";


if(request.getParameter("SectionCode")==null)
			SectionCode="";
		else
			SectionCode=request.getParameter("SectionCode");





		if(request.getParameter("PARAMETERVALUE")==null)
			mParaValue="N";
		else
			mParaValue=request.getParameter("PARAMETERVALUE");

		if(request.getParameter("PARAMETERDESC")==null)
			mParaDesc="N";
		else
			mParaDesc=request.getParameter("PARAMETERDESC");

	
		if(request.getParameter("PARAEDICODE")==null)
			PARAEDICODE="N";
		else
			PARAEDICODE=request.getParameter("PARAEDICODE");


		if(request.getParameter("PARAMETERID")==null)
			PARAMETERID="N";
		else
			PARAMETERID=request.getParameter("PARAMETERID");


		if(request.getParameter("PARAEDITYPE")==null)
			PARAEDITYPE="N";
		else
			PARAEDITYPE=request.getParameter("PARAEDITYPE");



/*qry="SELECT 'Y' FROM EMPLOYEEDETAIL WHERE EMPLOYEEID='"+mDMemberID+"'";
rs=db.getRowset(qry);
if(rs.next())
		{*/
qrypan="update employeedetail set panno='"+Panno+"' where employeeid='"+mDMemberID+"'";
//out.print(qrypan);
int pan=db.update(qrypan);
//		}
/*else
		{
	qrypan="INSERT INTO EMPLOYEEDETAIL (   EMPLOYEEID,   PANNO) VALUES ( '"+mDMemberID+"','"+Panno+"')";	
	int a=db.insertRow(qrypan);
	}*/



if( mSave.equals("Save") || mFreeze.equals("Y") )
{
//out.print(mSave+"78787"+mFreeze);



 qry1="select 'y' from TDS#EDIDECLARATIONHEADER where  COMPANYCODE='"+mComp+"' and  TDSCODE='"+mTDSCode+"' and ASSESSMENTYEAR='"+mAssessYear+"' and EMPLOYEEID='"+mDMemberID+"' ";
rs=db.getRowset(qry1);
if(!rs.next())
{

	qry="INSERT INTO TDS#EDIDECLARATIONHEADER (   COMPANYCODE, TDSCODE, ASSESSMENTYEAR,    EMPLOYEEID, DECLARATIONDATE, FINYEAR,    DEACTIVE, ENTRYBY, ENTRYDATE,    WEBENTRY, FREEZE,FINALFREEZE) VALUES ( '"+mComp+"', '"+mTDSCode+"' ,'"+mAssessYear+"' ,'"+mDMemberID+"',to_date('"  +mDeclareDate+"','dd-mm-rrrr') ,'"+mFinancialYear+"' ,'N' ,'"+mDMemberID+"' ,sysdate ,'W','"+mFreeze+"' ,'"+mFinalFreeze+"' )";
	//out.print(qry);
	int xx=db.insertRow(qry);
		if(xx>0)
		{
			mFlag1=1;
			//out.print("<center><font face=arial size=4 color=green> <b>Record Saved Successfully ..</b></font></center>");
		}
		else
		{
			mFlag1=0;
		}
}
else
{	
	 qryupdate="UPDATE TDS#EDIDECLARATIONHEADER SET  DECLARATIONDATE = to_date('"  +mDeclareDate+"','dd-mm-rrrr'),  FINYEAR = '"+mFinancialYear+"',  ENTRYBY  = '"+mDMemberID+"' ,  ENTRYDATE  = sysdate,WEBENTRY ='W',FREEZE   = '"+mFreeze+"' ,FINALFREEZE='"+mFinalFreeze+"' WHERE  COMPANYCODE = '"+mComp+"' AND    TDSCODE = '"+mTDSCode+"' AND    ASSESSMENTYEAR  ='"+mAssessYear+"' AND    EMPLOYEEID      = '"+mDMemberID+"'";		
	 	//	out.print(qryupdate);
	 int zz=db.update(qryupdate);
	if(zz>0)
		{
			mFlag1=1;
		}
		else
		{
			mFlag1=0;
		}

}


	
		if(request.getParameter("parasno")==null)
			parasno=0;
		else
			parasno=Integer.parseInt(request.getParameter("parasno"));


		String	qrydel="delete from TDS#OTHERDECLARATIONSECTIONS where companycode ='"+mComp+"'   AND tdscode = '"+mTDSCode+"'   AND assessmentyear = '"+mAssessYear+"'   AND employeeid ='"+mChkMemID+"' ";
		int del=db.update(qrydel);

		
		String	qrydel2="delete from TDS#OTHERDECLARATION where companycode ='"+mComp+"'   AND tdscode = '"+mTDSCode+"'   AND assessmentyear = '"+mAssessYear+"'   AND employeeid ='"+mChkMemID+"' ";
		int del2=db.update(qrydel2);

	for(int xx =1; xx<=sno;xx++)
	{
		
		if(request.getParameter("IDESCRIPTION"+xx)==null || request.getParameter("IDESCRIPTION"+xx).equals(""))
		{
			IDESCRIPTION="N";
		}
		else
		{
			IDESCRIPTION=request.getParameter("IDESCRIPTION"+xx);
			
		}

		if(request.getParameter("IAMOUNT"+xx)==null || request.getParameter("IAMOUNT"+xx).equals(""))
		{
			IAMOUNT=0;
		}
		else
		{
			IAMOUNT=Long.parseLong(request.getParameter("IAMOUNT"+xx).toString().trim());
			
		}
		
		if(request.getParameter("ACTUALAMOUNT"+xx)==null || request.getParameter("ACTUALAMOUNT"+xx).equals(""))
		{
			ACTUALAMOUNT=0;
		}
		else
		{
			ACTUALAMOUNT=Long.parseLong(request.getParameter("ACTUALAMOUNT"+xx).toString().trim());
			
		}
		
		if(ACTUALAMOUNT!=0)
			ACTUALRECEIVE="Y";





		if(!IDESCRIPTION.equals("N") &&  IAMOUNT!=0)
		{
		
	//	qry="SELECT COMPANYCODE, TDSCODE, ASSESSMENTYEAR, EMPLOYEEID, INVESTMENTID FROM TDS#OTHERDECLARATION WHERE 	 COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+mChkMemID+"' 
	//	rs=db.getRowset(qry);
			
		/*	qry1="SELECT COUNT(*)SS FROM TDS#OTHERDECLARATION WHERE COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and EMPLOYEEID='"+mChkMemID+"' ";
				out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				mInvesID=rs1.getLong("ss");

				mInvesID=mInvesID+1;*/

		mInvesID=xx;
	//out.print(IDESCRIPTION+"sdsdd");
		qry="SELECT COMPANYCODE, TDSCODE, ASSESSMENTYEAR, EMPLOYEEID, INVESTMENTID FROM TDS#OTHERDECLARATION WHERE 	 COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+mChkMemID+"' and INVESTMENTID='"+mInvesID+"' ";
	//	out.print(qry);
		rs=db.getRowset(qry);
		if(!rs.next())
			{
				qry1="INSERT INTO TDS#OTHERDECLARATION (   COMPANYCODE, TDSCODE, ASSESSMENTYEAR,    EMPLOYEEID, INVESTMENTID, INVESTMENTDESC,    INVESTMENTAMOUNT, FINYEAR, DEACTIVE,    ENTRYBY, ENTRYDATE, ACTUALRECEIVED,    ACTUALAMOUNT) VALUES ('"+mComp+"' ,'"+mTDSCode+"' ,'"+mAssessYear+"' ,'"+mChkMemID+"'  ,"+mInvesID+" ,'"+IDESCRIPTION+"' ,"+IAMOUNT+", '"+mFinancialYear+"' , 'N', '"+mChkMemID+"',sysdate,'"+ACTUALRECEIVE+"', "+ACTUALAMOUNT+"  )";
				//out.print(qry1);
				int c=db.insertRow(qry1);
				if(c>0)
					mFlag1=1;
				else
					mFlag1=0;
	
			}
			else
			{
				qry1="UPDATE TDS#OTHERDECLARATION SET    INVESTMENTDESC   ='"+IDESCRIPTION+"',       INVESTMENTAMOUNT = "+IAMOUNT+",ENTRYBY='"+mChkMemID+"'  , ENTRYDATE = sysdate,ACTUALRECEIVED= '"+ACTUALRECEIVE+"',ACTUALAMOUNT="+ACTUALAMOUNT+" WHERE  COMPANYCODE= '"+mComp+"' AND TDSCODE ='"+mTDSCode+"' AND    ASSESSMENTYEAR   ='"+mAssessYear+"' and INVESTMENTID='"+mInvesID+"'  AND    EMPLOYEEID       ='"+mChkMemID+"' ";
				out.print(qry1);
				int o=db.update(qry1);
				if(o>0)
					mFlag1=1;
				else
					mFlag1=0;

	
			}




			qry1="SELECT COMPANYCODE, TDSCODE, ASSESSMENTYEAR,    EMPLOYEEID, INVESTMENTID, SECTIONCODE,    FINYEAR FROM TDS#OTHERDECLARATIONSECTIONS WHERE  COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+mChkMemID+"'  and SECTIONCODE='"+SectionCode+"' and INVESTMENTID='"+mInvesID+"' ";
		rs1=db.getRowset(qry1);
		if(!rs1.next())
			{


				qry="INSERT INTO TDS#OTHERDECLARATIONSECTIONS (   COMPANYCODE, TDSCODE, ASSESSMENTYEAR,    EMPLOYEEID, INVESTMENTID, SECTIONCODE,    FINYEAR, DEACTIVE, ENTRYBY,    ENTRYDATE) 				VALUES ('"+mComp+"' , '"+mTDSCode+"','"+mAssessYear+"' ,  '"+mChkMemID+"'  ,"+mInvesID+" , '"+SectionCode+"', '"+mFinancialYear+"'  , 'N','"+mChkMemID+"',sysdate  )";
				//out.print(qry);
				int h=db.insertRow(qry);
				if(h>0)
					mFlag1=1;
				else
					mFlag1=0;


			}
		
		}

	}

		if(mCountInvestID==0)	
			mCountInvestID=mInvesID;
	

//out.print(mCountInvestID+"mCountInvestID");
		
//additioanamount	
		if(request.getParameter("addparasno")==null)
			addparasno=0;
		else
			addparasno=Integer.parseInt(request.getParameter("addparasno"));

//out.print(addparasno+"addparasno");
	for(int uu =1; uu<=addparasno;uu++)
	{
		
		if(request.getParameter("ADDIDESCRIPTION"+uu)==null || request.getParameter("ADDIDESCRIPTION"+uu).equals(""))
		{
			ADDIDESCRIPTION="N";
		}
		else
		{
			ADDIDESCRIPTION=request.getParameter("ADDIDESCRIPTION"+uu);
			
		}

		if(request.getParameter("ADDIAMOUNT"+uu)==null || request.getParameter("ADDIAMOUNT"+uu).equals(""))
		{
			ADDIAMOUNT=0;
		}
		else
		{
			ADDIAMOUNT=Long.parseLong(request.getParameter("ADDIAMOUNT"+uu).toString().trim());
			
		}
		
		if(request.getParameter("ADDACTUALAMOUNT"+uu)==null || request.getParameter("ADDACTUALAMOUNT"+uu).equals(""))
		{
			ADDACTUALAMOUNT=0;
		}
		else
		{
			ADDACTUALAMOUNT=Long.parseLong(request.getParameter("ADDACTUALAMOUNT"+uu).toString().trim());
			
		}
		
		if(ADDACTUALAMOUNT!=0)
			ADDACTUALRECEIVE="Y";

		
		if(!ADDIDESCRIPTION.equals("N") &&  ADDIAMOUNT!=0)
		{
		
	if(mCountInvestID!=0)
		mADDInvesID=mCountInvestID+1;
	else
		mADDInvesID=uu;
	//out.print(mADDInvesID+"mADDInvesID");
		qry="SELECT COMPANYCODE, TDSCODE, ASSESSMENTYEAR, EMPLOYEEID, INVESTMENTID FROM TDS#OTHERDECLARATION WHERE 	 COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+mChkMemID+"' and INVESTMENTID='"+mADDInvesID+"' ";
	//	out.print(qry);
		rs=db.getRowset(qry);
		if(!rs.next())
			{
				qry1="INSERT INTO TDS#OTHERDECLARATION (   COMPANYCODE, TDSCODE, ASSESSMENTYEAR,    EMPLOYEEID, INVESTMENTID, INVESTMENTDESC,    INVESTMENTAMOUNT, FINYEAR, DEACTIVE,    ENTRYBY, ENTRYDATE, ACTUALRECEIVED,    ACTUALAMOUNT,ADDITIONALINFO) VALUES ('"+mComp+"' ,'"+mTDSCode+"' ,'"+mAssessYear+"' ,'"+mChkMemID+"'  ,"+mADDInvesID+" ,'"+ADDIDESCRIPTION+"' ,"+ADDIAMOUNT+", '"+mFinancialYear+"' , 'N', '"+mChkMemID+"',sysdate,'"+ADDACTUALRECEIVE+"', "+ADDACTUALAMOUNT+" ,'Y' )";
				//out.print(qry1);
				int P=db.insertRow(qry1);
				if(P>0)
					mFlag1=1;
				else
					mFlag1=0;
	
			}
			else
			{
				qry1="UPDATE TDS#OTHERDECLARATION SET    INVESTMENTDESC   ='"+ADDIDESCRIPTION+"',       INVESTMENTAMOUNT = "+ADDIAMOUNT+",ENTRYBY='"+mChkMemID+"'  , ENTRYDATE = sysdate,ACTUALRECEIVED= '"+ADDACTUALRECEIVE+"',ACTUALAMOUNT="+ADDACTUALAMOUNT+" WHERE  COMPANYCODE= '"+mComp+"' AND TDSCODE ='"+mTDSCode+"' AND    ASSESSMENTYEAR   ='"+mAssessYear+"' and INVESTMENTID='"+mADDInvesID+"'  AND    EMPLOYEEID       ='"+mChkMemID+"' ";
				//out.print(qry1);
				int LL=db.update(qry1);
				if(LL>0)
					mFlag1=1;
				else
					mFlag1=0;

	
			}
			mCountInvestID=mADDInvesID;

		}
	}

	








		

		if(!mParaValue.equals("N") && !mParaValue.equals(""))
		{

		qry="SELECT  'Y' FROM TDS#DECLARATIONPARADETAIL WHERE COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' AND  EDITYPE='"+PARAEDITYPE+"' AND EDICODE='"+PARAEDICODE+"' AND PARAMETERID="+PARAMETERID+" and employeeid='"+mChkMemID+"' ";
		//out.print(qry);
		rs=db.getRowset(qry);
		if(!rs.next())
		{	
			qry1="INSERT INTO TDS#DECLARATIONPARADETAIL (   COMPANYCODE, TDSCODE, ASSESSMENTYEAR,    EDITYPE, EDICODE, PARAMETERID,    FINYEAR, EMPLOYEEID, PARAMETERVALUE,    DEACTIVE, ENTRYBY, ENTRYDATE) VALUES ('"+mComp+"' ,'"+mTDSCode+"' ,'"+mAssessYear+"' ,'"+PARAEDITYPE+"', '"+PARAEDICODE+"', "+PARAMETERID+" ,'"+mFinancialYear+"' ,'"+mChkMemID+"' ,'"+mParaValue+"','N' , '"+mChkMemID+"' ,sysdate)";
			//out.print(qry1);
			int z=db.insertRow(qry1);
			if(z>0)
				mFlag1=1;
			else				
			mFlag1=0;
				

		}
		else
		{
			qry1="UPDATE TDS#DECLARATIONPARADETAIL SET    PARAMETERVALUE = '"+mParaValue+"', ENTRYBY=  '"+mChkMemID+"',       ENTRYDATE      = sysdate	WHERE  COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' AND  EDITYPE='"+PARAEDITYPE+"' AND EDICODE='"+PARAEDICODE+"' AND PARAMETERID="+PARAMETERID+" ";
		//	out.print(qry1);
			int y=db.update(qry1);
			if(y>0)
						mFlag1=1;
			else
						mFlag1=0;
		
		}



		}
		






for(int yy =1; yy<=sno;yy++)
{



if(request.getParameter("DeclarationAmt"+yy)==null || request.getParameter("DeclarationAmt"+yy).equals(""))
		{
			DeclarationAmt=0;
		}
		else
		{
			DeclarationAmt=Long.parseLong(request.getParameter("DeclarationAmt"+yy));
			
		}

	if(request.getParameter("ReceiptAmt"+yy)==null || request.getParameter("ReceiptAmt"+yy).equals(""))
		{
			ReceiptAmt=0;
		}
		else
		{
			ReceiptAmt=Long.parseLong(request.getParameter("ReceiptAmt"+yy));
			
		}





if(request.getParameter("mEDITYPE"+yy)==null)
		{
			mEDITYPE="";
		}
		else
		{
			mEDITYPE=request.getParameter("mEDITYPE"+yy);
			
		}




	if(request.getParameter("mEDIDCODE"+yy)==null)
		{
			mEDIDCODE="";
		}
		else
		{
			mEDIDCODE=request.getParameter("mEDIDCODE"+yy);
			
		}
if(mEDITYPE.equals("E"))
	{
	mCategoryCode=request.getParameter("CategoryDesc"+yy);
	}
	else
	{
		mCategoryCode=mEDIDCODE;
	}
		



//out.print(request.getParameter("CategoryDesc"+yy)+"CategoryDesc");

		


qry="select 'y' from TDS#EDIDECLARATIONDETAIL where  COMPANYCODE='"+mComp+"' and  TDSCODE='"+mTDSCode+"' and ASSESSMENTYEAR='"+mAssessYear+"' and EMPLOYEEID='"+mDMemberID+"' and EDITYPE='"+mEDITYPE+"' and   EDICODE='"+mEDIDCODE+"' ";
rs=db.getRowset(qry);
if(!rs.next())
	{

 qryinsert="INSERT INTO TDS#EDIDECLARATIONDETAIL (   COMPANYCODE, TDSCODE, ASSESSMENTYEAR,    EMPLOYEEID, EDITYPE, CATEGORYCODE,    EDICODE, DECLARATIONAMOUNT, FINYEAR, DEACTIVE, ENTRYBY,    ENTRYDATE,  ACTUALRECEIVED, FINAL  ,    ACTUALAMOUNT) VALUES ( '"+mComp+"', '"+mTDSCode+"' ,'"+mAssessYear+"' ,'"+mDMemberID+"','"+mEDITYPE+"' ,'"+mCategoryCode+"' ,'"+mEDIDCODE+"',"+DeclarationAmt+" ,'"+mFinancialYear+"' ,'N' ,'"+mDMemberID+"' ,sysdate ,  '"+mFinalFreeze+"' ,'"+mFinalFreeze+"' ,"+ReceiptAmt+" )";
//out.print(qryinsert+"<br>");
int aa=db.insertRow(qryinsert);
	if(aa>0)
		mFlag=1;
	else
		mFlag=0;
	}
	else
	{
		qryupdate="UPDATE TDS#EDIDECLARATIONDETAIL 		SET    DECLARATIONAMOUNT = "+DeclarationAmt+" ,       FINYEAR           = '"+mFinancialYear+"',   CATEGORYCODE      ='"+mCategoryCode+"' ,      ENTRYBY           = '"+mDMemberID+"',       ENTRYDATE         = SYSDATE,        ACTUALAMOUNT      = "+ReceiptAmt+"   ,ACTUALRECEIVED='"+mFinalFreeze+"', FINAL='"+mFinalFreeze+"'      WHERE  COMPANYCODE = '"+mComp+"' AND    TDSCODE = '"+mTDSCode+"' AND    ASSESSMENTYEAR  ='"+mAssessYear+"' AND    EMPLOYEEID      = '"+mDMemberID+"' AND    EDITYPE = '"+mEDITYPE+"'  AND    EDICODE           = '"+mEDIDCODE+"' ";
		//out.print(qryupdate);
		int oo = db.update(qryupdate);
		if(oo>0)
					mFlag=1;
				else
					mFlag=0;
		}


}




if((mFlag1==1 && mFlag==1) )
		{
			if(!mFreeze.equals("Y"))
			{
			out.print("<br><center><font face=arial size=4 color=green> <b>Record Saved Successfully .. <br><a href='TDSDeclaration.jsp' title='Go back'>Click to Go Back</a> </b></font> </center>");
			}
		}
		else
		{
			out.print("<br><center><font face=arial size=4 color=green> <b>Error in Saving..<br><a href='TDSDeclaration.jsp' title='Go back'>Click to Go Back</a></b></font></center>");
		}

//out.print("in save");
}
//out.print("outtt");
if( mFreeze.equals("Y"))
		{

	/*	if( mFreeze.equals("Y"))
			{
	 qryupdate="UPDATE TDS#EDIDECLARATIONHEADER SET  DECLARATIONDATE = to_date('"  +mDeclareDate+"','dd-mm-rrrr'),  FINYEAR = '"+mFinancialYear+"',  ENTRYBY  = '"+mDMemberID+"' ,  ENTRYDATE  = sysdate,WEBENTRY ='W',FREEZE   = '"+mFreeze+"' WHERE  COMPANYCODE = '"+mComp+"' AND    TDSCODE = '"+mTDSCode+"' AND    ASSESSMENTYEAR  ='"+mAssessYear+"' AND    EMPLOYEEID      = '"+mDMemberID+"'";		
	 	//	out.print(qryupdate);
	 int ll=db.update(qryupdate);	
			}
*/

try
		{
String CADDRESS3="",CADDRESS2="",CADDRESS1="",mPan="",CCITY="",CDISTRICT="",CSTATE="";
String CPIN="",mGender="";

qry=" select nvl(a.PANNO,' ')PANNO  ,decode(c.sex,'M','Male','F','Female',c.sex)sex   from employeedetail a ,employeemaster c where a.EMPLOYEEID='"+mDMemberID+"' and a.EMPLOYEEID=c.EMPLOYEEID ";
//out.print(qry);
rs=db.getRowset(qry);
 if(rs.next())
			{
			 mPan=rs.getString("PANNO");
			 mGender=rs.getString("sex");
			}



%>

<br>
<table cellpadding=1 cellspacing=0  align=center BORDER=1 width="80%" >
		<input id="x" name="x" type=hidden>
		<tr>
		<td ALIGN=CENTER COLSPAN=2>
		<font size=3 face=arial ><b>TAX DECLARATION FORM
		</td>
		</tr>
		
		<tr>
		<%
		if(!mDesg.equals("DEAN"))
		{
		%>
			<td><font color=black face=arial size=2><STRONG>Name of  Employee &nbsp;
			</td>
			<td>
			<font color=black face=arial size=2><STRONG><%=mMemberName%> 
			
			</strong></font>
			</td>
		<%
		}
		else
		{ 
		%>
			<td><font color=black face=arial size=2><STRONG>Name of  Employee &nbsp;</strong></font>
			</td>
			<td><font color=black face=arial size=2><b> <%=mMemberName%> 
		
			</b></font>
			</td>
		<%
		}
		%>
	
		<INPUT Type="Hidden" Name="Type" id="Type" Value="<%=mType%>">
		<INPUT Type="Hidden" Name="Inst" id="Inst" Value="<%=mInst%>">
		
	
</tr>
<tr><td >
<font color=black face=arial size=2><STRONG>Employee Code </strong>
</font>
</td>
<td >
<font color=black face=arial size=2><STRONG> <%=mDMemberCode%>
</font>
</td>
</tr>

<tr><td >
<font color=black face=arial size=2><STRONG>
Designation</strong>
</font>
</td>
<td >
<font color=black face=arial size=2><STRONG> <%=mDesg%>
</font>
</td>
</tr>

<tr><td >
<font color=black face=arial size=2><STRONG>Pan No. </strong>
</td>
<td>
<font color=black face=arial size=2><STRONG> <%=mPan%>&nbsp;    </strong></font>
</font>
</td></tr>

<tr><td >
<font color=black face=arial size=2><STRONG>Financial Year </strong>
</td>
<td>
<font color=black face=arial size=2><STRONG>  <%=FINANCIALYEAR1%>   </strong></font>
</font>
</td></tr>

<tr><td >
<font color=black face=arial size=2><STRONG>Date of Declaration </strong>
</td>
<td>
<font color=black face=arial size=2><STRONG>  <%=mDeclareDate%>   </strong></font>
</font>
</td></tr>

<tr><td >
<font color=black face=arial size=2><STRONG>Sr Citizen</strong>
</td>
<td>
<font color=black face=arial size=2><STRONG>   <%=SrCitizen%> &nbsp;   </strong></font>
</font>
</td></tr>


<tr><td >
<font color=black face=arial size=2><STRONG>Male / Female</strong>
</td>
<td>
<font color=black face=arial size=2><STRONG>  <%=mGender%>   </strong></font>
</font>
</td></tr>

</table>
<br>


<table cellpadding=0 cellspacing=0 border=1 align=center  rules=groups   width="80%">

<tr>
<td><font face=arial size=3><b>SNo  &nbsp; Proposed Tax Saving Investment/Payments 
</font>
</td>
<td><font face=arial size=3><b>
Amount
</td>
</tr>
<tr><td colspan=3><hr></td></tr>

<%

//913201021449  

qry="SELECT distinct a.COMPANYCODE, a.TDSCODE, a.ASSESSMENTYEAR,    a.EMPLOYEEID, a.EDITYPE, a.CATEGORYCODE,    a.EDICODE, nvl(decode(a.DECLARATIONAMOUNT,'0',' ',a.DECLARATIONAMOUNT),' ')DECLARATIONAMOUNT, a.FINYEAR,    a.ACTUALRECEIVED, nvl(a.FINAL,' ')FINAL,    nvl(decode(a.actualamount,'0',' ',a.actualamount),' ')actualamount, a.EXEMPTEDAMOUNT,b.SECTIONCODE,b.SECTIONDESC,b.DECLARATIONSEQID,c.SEQUENCEID FROM TDS#EDIDECLARATIONDETAIL a,TDS#SECTIONMASTER b, TDS#TDSSECTIONTAGGING c where a.companycode =  '"+mComp+"'     AND a.tdscode =  '"+mTDSCode+"'        AND a.finyear = '"+mFinancialYear+"'     and a.EMPLOYEEID='"+mDMemberID+"'     and a.ASSESSMENTYEAR='"+mAssessYear+"'      and a.EDITYPE=c.EDITYPE     and  a.EDICODE=c.EDICODE     and a.COMPANYCODE=c.COMPANYCODE     and a.FINYEAR=c.FINYEAR     and a.TDSCODE=c.TDSCODE     and a.COMPANYCODE=b.COMPANYCODE     and a.TDSCODE=b.TDSCODE     and b.COMPANYCODE=c.COMPANYCODE     and b.TDSCODE=c.TDSCODE     and b.SECTIONCODE=c.SECTIONCODE order by b.DECLARATIONSEQID,c.SEQUENCEID ";



//out.print(qry);
rs=db.getRowset(qry);

while(rs.next())
		{


		 EDICODE  =rs.getString("EDICODE").toString().trim();
		EDITYPE=rs.getString("EDITYPE").toString().trim();

		DECLARATIONAMOUNT1=rs.getString("DECLARATIONAMOUNT");
		ACTUALAMOUNT1=rs.getString("actualamount").toString().trim();

		if(mStatus.equals("F"))
				RecAmt=ACTUALAMOUNT1;
		else
			RecAmt=DECLARATIONAMOUNT1;
					

		if(!sectionCode.equals(rs.getString("SECTIONCODE").toString().trim()))
			{
				ctr++;
				%>
				<tr><td colspan=2><font color=black face=arial size=2>
				<strong><%=ctr%>.&nbsp;&nbsp;
				
				<U><%=rs.getString("SECTIONDESC").toString().trim()%></u>
				</strong></font>
				<br></td>
				</tr>

				<%
				sectionCode=rs.getString("SECTIONCODE").toString().trim();
			}
			
		


		if(EDITYPE.equals("I"))
			{
				
				qry1="SELECT NVL (edidescription, ' ') edidescription,  NVL (b.otherparameter, 'N') otherinvestparameter ,nvl(a.otherparameter,'N')otherparameter  FROM tds#edideclaration a ,    tds#investrebatemaster b  WHERE a.companycode = '"+rs.getString("COMPANYCODE")+"'    AND a.tdscode ='"+rs.getString("TDSCODE")+"' and a.EDITYPE='"+EDITYPE+"'  AND a.edicode =  '"+EDICODE+"'   and a.COMPANYCODE=b.COMPANYCODE   and a.TDSCODE=b.TDSCODE   and a.EDICODE=b.INVESTREBATECODE    ";
				//out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{
						%>
		<tr>
		<td >
						<%
						//Others Investment ,Please Specify 
		if(rs1.getString("OTHERInvestPARAMETER").equals("Y") )
		{
	
				
	
	qry2="SELECT decode(INVESTMENTAMOUNT,0,' ',INVESTMENTAMOUNT)INVESTMENTAMOUNT,nvl(INVESTMENTDESC,' ')INVESTMENTDESC,decode(ACTUALAMOUNT,'0',' ',ACTUALAMOUNT)ACTUALAMOUNT FROM TDS#OTHERDECLARATION WHERE 	 COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+mChkMemID+"' and nvl(ADDITIONALINFO,'N')<>'Y' ";
//		out.print(qry2);
	rs2=db.getRowset(qry2);
	rs11=db.getRowset(qry2);
			
	if(rs11.next())		
		{	
						%>
				<UL>
				<LI>
				<font size=2  FACE=ARIAL color=blue><b><%=rs1.getString("edidescription")%></b></font>
				</ul>	
						
						
						<TABLE valign=top align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1  cellPadding=1 border=1 >
			<thead>
			<tr><!-- <td colspan=6 align=center ><Font face='ari' size=2 color='Blue'><b>Details </b></font>
				</td>
			 --><tr bgcolor="#ff8c00" >
					<td align=center><Font face='ARIAL' size=1><b>SrNo</b></font></td>
					<td align=center><Font face='ARIAL' size=1><b>Investment Description</b></font></td>
					<td align=center><Font face='ARIAL' size=1><b>Investment Amount</b></font></td>
							<%
					
				if(mStatus.equals("F"))
				  {
				%>
						<td align=center><Font face='ARIAL' size=1><b>Actual Amount</b></font></td>
				<%}
					%>
			</tr>

			</thead>

			<tbody>
				
				<%
				while(rs2.next() )
				{	
					i++;
					%>
				<tr>
				<td><%=i%> </td>
				<td> <%=rs2.getString("INVESTMENTDESC")%> </td>
				<td> <%=rs2.getString("INVESTMENTAMOUNT")%></td>
						<%
				if(mStatus.equals("F"))
				  {
				%>
					<td><%=rs2.getString("ACTUALAMOUNT")%> </td>
				<%
				  }
					%>
				</tr>
				<%
				}
				%>
	
				</TBODY>
			</TABLE>
		<%
		}
			
		}
	else if(rs1.getString("OTHERPARAMETER").equals("Y"))
			{	
					
						%>	
							<UL>
							<LI><font color=black face=arial size=2><%=rs1.getString("edidescription")%></font>
						<li>
							<FONT face=Arial color=blue size=2><STRONG><%=mParaDesc%>   
							<%=mParaValue%></STRONG></FONT>

							</UL>
						<%			
						
			}
		else
		{
			%>
			<UL>
							<LI> &nbsp;<font color=black face=arial size=2><%=rs1.getString("edidescription")%></font>&nbsp;&nbsp;
						</UL>
			<%
		}
			%>
	</td>
	<td>
		<%
		if(!rs1.getString("OTHERInvestPARAMETER").equals("Y") )
		{
		%>
		
				 <img SRC="images/Rs.jpg.png" > 
			<font color=black face=arial size=2><%=RecAmt%></font> 
			<%
		}
			%>&nbsp;
	</td>
	</tr>
				<%
	}
			}



			if(EDITYPE.equals("E"))		
			{

			//	out.print(EDITYPE+"EDITYPExxxx");
					qry1="SELECT NVL (a.edidescription, ' ') edidescription, NVL (a.otherparameter, 'N') otherparameter,NVL(B.CATEGORYDESCRIPTION,' ')CATEGORYDESCRIPTION  FROM tds#edideclaration a,TDS#EDRates b WHERE a.companycode = '"+rs.getString("COMPANYCODE")+"'  AND a.tdscode ='"+rs.getString("TDSCODE")+"' AND a.edicode = '"+EDICODE+"' and a.EDITYPE='"+EDITYPE+"' and b.CATEGORYCODE='"+rs.getString("CATEGORYCODE")+"'  and a.COMPANYCODE=b.COMPANYCODE and a.EDICODE=b.EDICODE and a.EDITYPE=b.EDITYPE and a.FINYEAR=b.FINYEAR";
			//		out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{
					%>
						<tr>
						<td>
						<%
						if(rs1.getString("OTHERPARAMETER").equals("Y"))
						{
									%>		
							<UL>
								<LI>&nbsp;<font color=black face=arial size=2><%=rs1.getString("edidescription")%> &nbsp;&nbsp <%=rs1.getString("CATEGORYDESCRIPTION")%></font>
									
							<LI><FONT color=black><FONT face=Arial color=blue size=2><STRONG><%=mParaDesc%>   </STRONG>
							<%=mParaValue%></FONT>
							</UL>	
						<%			
						}
						else
						{
								%>
							<UL>
								<LI>&nbsp;<font color=black face=arial size=2><%=rs1.getString("edidescription")%> &nbsp;&nbsp
							<%
								//out.print("::Ddd"+RecAmt+"sss");	
								if(RecAmt.equals("0") || RecAmt.equals(" ") || RecAmt.equals(""))
							{
									%>

								<%
							}
									else
							{
										%>
										<%=rs1.getString("CATEGORYDESCRIPTION")%>
										<%
							}
										%>
							
								
								</font>
							</UL>
						<%
						}
						%>
						</td>
						<td><img SRC="images/Rs.jpg.png" > 
							<font color=black face=arial size=2><%=RecAmt%></font>
							 						
						</td>
						</tr>
							<%
				}

			}
		
			
				
			
		

		}
		%>


		<tr>
		<td>
		<%
		qry2="SELECT decode(INVESTMENTAMOUNT,0,' ',INVESTMENTAMOUNT)INVESTMENTAMOUNT,nvl(INVESTMENTDESC,' ')INVESTMENTDESC,decode(ACTUALAMOUNT,'0',' ',ACTUALAMOUNT)ACTUALAMOUNT FROM TDS#OTHERDECLARATION WHERE 	 COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+mChkMemID+"' and nvl(ADDITIONALINFO,'N')='Y' ";
//		out.print(qry2);
	rs2=db.getRowset(qry2);
	rs11=db.getRowset(qry2);
			
	if(rs11.next())		
		{	
						%>	<TABLE valign=top align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1  cellPadding=1 border=1 >
			<thead>
			<tr bgcolor="#ff8c00"><td colspan=6 align=center ><Font face='arial' size=2 color='black'><b>Additional Information if any </b></font>
				</td>
					<tr bgcolor="#ff8c00" >
					<td align=center><Font face='ARIAL' size=1><b>SrNo</b></font></td>
					<td align=center><Font face='ARIAL' size=1><b>Investment Description</b></font></td>
					<td align=center><Font face='ARIAL' size=1><b>Investment Amount</b></font></td>
							<%
					
				if(mStatus.equals("F"))
				  {
				%>
						<td align=center><Font face='ARIAL' size=1><b>Actual Amount</b></font></td>
				<%}
					%>
			</tr>
			</thead>

			<tbody>
				
				<%
				while(rs2.next() )
				{	
					w++;
					%>
				<tr>
				<td><%=w%> </td>
				<td> <%=rs2.getString("INVESTMENTDESC")%> </td>
				<td> <%=rs2.getString("INVESTMENTAMOUNT")%></td>
						<%
				if(mStatus.equals("F"))
				  {
				%>
					<td><%=rs2.getString("ACTUALAMOUNT")%> </td>
				<%
				  }
					%>
				</tr>
				<%
				}
				%>
	
				</TBODY>
			</TABLE>
		<%
		}
%>
		</td>
		</tr>






			<style type="text/css">
				@media print 
				{
				input#btnPrint 
				{
					display: none;
				}
				}
				</style>
		
		<tr>
		<td align="center" colspan=2><br>
			<input type="button" name='submit'  id="btnPrint"  onClick='window.print()' value='Click To Print'>
		</td>
		</tr>
		<tr>
		<td align="right" colspan=2><br> <br> <font color=black face=arial size=2>
		(Signature of Employee)</font>
		</td>
		</tr>
		</table>
		<%
	}
	catch(Exception e)
		{
			out.print(e);
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
  //-----------------------------
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
%>
</form>
</body>
</html>
