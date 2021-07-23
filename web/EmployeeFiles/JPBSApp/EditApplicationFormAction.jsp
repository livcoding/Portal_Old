 <%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %>
<%
try{
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JPBS";

GlobalFunctions gb =new GlobalFunctions();

//out.print("sdfsdfsfsdfsdf");
ResultSet rsa=null,rsq=null;
DBHandler db=new DBHandler();
ResultSet rs=null,rsup=null;
ResultSet rsgrd=null,rstwel=null;
String qrygred="",qrytwel="",mVENUE="";
String mCATYEAR="",mMATYEAR="",mGMATYEAR="",mCMATYEAR="",mState="";
String qryprf="";

String qrycomp="",qryup="";
ResultSet rscomp=null,rs1=null;
String qry="",str1="", qryqua="";
String mValue="";
String mFName="",mMName="",mLName="",mSex="";
String mQYear="",mCategory="",mFatherName="",mMotherName="",mVenueqry="";
String mAIEEEROLL="",mADDRESS1="",mADDRESS2="",mADDRESS3="",mCITY="",mPIN="";
String mDISTRICT="",mPOSTOFFICE="",mRAILSTATION="",mPOLICESTATION="",mSTDCODE="",mPHONENO="";
String mMOBILE="",mSTATE="",memail="",mNationality="";
String mDDAMT="",mDDNO="";
String qrya="",qryc="",qryg="",qryx="",qry1="",qryt="";
String qryten="",qrytw="",qrygrd="",qryfee="";
String mBANK="";
String mPer12="",mGradPer="",Appear="",DocScore="",mPer10="",mGradProg="",Doc10="",Doc12="",DocGrade="";
String GMATCOMP="",GMATPER="",CATCOMP="",CATPER="",MATCOMP="",MATPER="";
String mAPPSLNO="",mApplicantSlno="",mStr="",mApplicantName="",mapp="";
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mAppNo="",mCountry="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mDDDATE="",mDOB="",mIntAppNo="",mAppRadio="",mPurchRadio="",mPurchAmt="";
String 	mQual="",mPerQual12="",mPerQual10="",mPerGrade="",mGradeProgr="",mTCODE="";
String mGMATCOMP="",mGMATPER="",mCATCOMP="",mCATPER="",mMATCOMP="",mMATPER="";
String mAppearIn="",mCheckScore="";
String mDoc10="No",mDoc12="No",mDocGrad="No";
String mGMAT="",mMAT="",mCAT="",mRadio1="";
String m10TH="10TH",m12TH="12TH",mGRAD="GRAD";
String qry10="",qry12="";
String mATMAYEAR="",mATMACOMP="",mATMAPER="",mATMADATE="";
String mReligion="",mAadhar="",mNAMEOFACHOLDER="",mNAMEOFBANK="",mBANKACCOUNTNO="",mBRANCHNAME="",mBANKADDRESS="",mIFSCCODE="";

String TenYear="",	TenStream="",TenBoard="",	TenPercent="";
String TewYear="",	TewStream="",TewBoard="",	TewPercent="";

String GradYear="",	GradStream="",GradBoard="",	GradPercent="";

String OtherYear="",	OtherStream="",OtherBoard="",	OtherPercent="",DocOther="N";
String mOTHER="OTHER",mDocOther="No";

String GMATDATE="",MATDATE="",CATDATE="";
String 	mCMAT="",CMATDATE="",CMATCOMP="",CMATPER="",mCMATDATE="",mCMATRANK="";

	String mCMATCOMP="",mCMATPER="";

    String mXATYEAR="",mXATDATE="",mOTHYEAR="",mOTHCOMP="",mOTHPER="",mOTHDATE="";

String mCATDATE="",mMATDATE="",mGMATDATE="";
String mXATCOMP="",mXATPER="";
int mFlag=0;

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
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

session.setMaxInactiveInterval(1800);

	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;

	  //-----------------------------
	  //-- Enable Security Page Level
	  //-----------------------------

		qry="Select WEBKIOSK.ShowLink('228','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
	  //----------------------


if(request.getParameter("AppNo")==null)
	mAppNo="";
else
	mAppNo=request.getParameter("AppNo").toString().trim();


if(request.getParameter("IntAppNo")==null)
	mIntAppNo="";
else
	mIntAppNo=request.getParameter("IntAppNo").toString().trim();

if(request.getParameter("AppRadio")==null)
	mAppRadio="";
else
	mAppRadio=request.getParameter("AppRadio").toString().trim();


if(request.getParameter("FirstName")==null)
	mFName="";
else
	mFName=request.getParameter("FirstName").toString().trim();

if(request.getParameter("Gender")==null)
	mSex="";
else
	mSex=request.getParameter("Gender").toString().trim();

if (request.getParameter("DOB")==null)
	mDOB="";
else
	mDOB=request.getParameter("DOB").toString().trim();

// mDateofBirth=to_date(mDOB,"dd-mm-yyyy");

//out.print(mDateofBirth+"sadad");


if (request.getParameter("QYear")==null)
	mQYear="";
else
	mQYear=request.getParameter("QYear").toString().trim();

if (request.getParameter("Category")==null)
	mCategory="";
else
	mCategory=request.getParameter("Category").toString().trim();
 //out.print(mCategory);
if (request.getParameter("FatherName")==null)
	mFatherName="";
else
 	mFatherName=request.getParameter("FatherName").toString().trim();

if (request.getParameter("MotherName")==null)
	mMotherName="";
else
 	mMotherName=request.getParameter("MotherName").toString().trim();

if (request.getParameter("Religion")==null)
	mReligion="";
else
 	mReligion=request.getParameter("Religion").toString().trim();

if (request.getParameter("Aadhar")==null)
	mAadhar="";
else
 	mAadhar=request.getParameter("Aadhar").toString().trim();

//Bank Detail
if (request.getParameter("NAMEOFACHOLDER")==null)
	mNAMEOFACHOLDER="";
else
 	mNAMEOFACHOLDER=request.getParameter("NAMEOFACHOLDER").toString().trim();

if (request.getParameter("NAMEOFBANK")==null)
	mNAMEOFBANK="";
else
 	mNAMEOFBANK=request.getParameter("NAMEOFBANK").toString().trim();

if (request.getParameter("BANKACCOUNTNO")==null)
	mBANKACCOUNTNO="";
else
 	mBANKACCOUNTNO=request.getParameter("BANKACCOUNTNO").toString().trim();

if (request.getParameter("BRANCHNAME")==null)
	mBRANCHNAME="";
else
 	mBRANCHNAME=request.getParameter("BRANCHNAME").toString().trim();

if (request.getParameter("BANKADDRESS")==null)
	mBANKADDRESS="";
else
 	mBANKADDRESS=request.getParameter("BANKADDRESS").toString().trim();

if (request.getParameter("IFSCCODE")==null)
	mIFSCCODE="";
else
 	mIFSCCODE=request.getParameter("IFSCCODE").toString().trim();


//



if (request.getParameter("ADDRESS1")==null)
	mADDRESS1="";
else
 	mADDRESS1=request.getParameter("ADDRESS1").toString().trim();

if (request.getParameter("ADDRESS2")==null)
	mADDRESS2="";
else
 	mADDRESS2=request.getParameter("ADDRESS2").toString().trim();

if (request.getParameter("CITY")==null)
	mCITY="";
else
 	mCITY=request.getParameter("CITY").toString().trim();

if (request.getParameter("PIN")==null)
	mPIN="";
else
 	mPIN=request.getParameter("PIN").toString().trim();

if (request.getParameter("PHONENO")==null)
	mPHONENO="";
else
 	mPHONENO=request.getParameter("PHONENO").toString().trim();

if (request.getParameter("MOBILE")==null)
	mMOBILE="";
else
 	mMOBILE=request.getParameter("MOBILE").toString().trim();

if (request.getParameter("STATE")==null)
	mSTATE="";
else
 	mSTATE=request.getParameter("STATE").toString().trim();
//out.print(mSTATE);
if (request.getParameter("Country")==null)
	mCountry="";
else
 	mCountry=request.getParameter("Country").toString().trim();



if (request.getParameter("PurchRadio")==null)
	mPurchRadio="";
else
 	mPurchRadio=request.getParameter("PurchRadio").toString().trim();


if (request.getParameter("email")==null)
	memail="";
else
 	memail=request.getParameter("email").toString().trim();

if (request.getParameter("Nationality")==null)
	mNationality="";
else
 	mNationality=request.getParameter("Nationality").toString().trim();

if (request.getParameter("DDAMT")==null)
	mDDAMT="";
else
 	mDDAMT=request.getParameter("DDAMT").toString().trim();

if (request.getParameter("DDNO")==null)
	mDDNO="";
else
 	mDDNO=request.getParameter("DDNO").toString().trim();

if (request.getParameter("DDDATE")==null)
	mDDDATE="";
else
 	mDDDATE=request.getParameter("DDDATE").toString().trim();


	if (request.getParameter("BANK")==null)
	mBANK="";
else
 	mBANK=request.getParameter("BANK").toString().trim();


	if (request.getParameter("PurchAmt")==null)
	mPurchAmt="";
else
 	mPurchAmt=request.getParameter("PurchAmt").toString().trim();

	if (request.getParameter("DDAMT")==null)
	mDDAMT="";
else
 	mDDAMT=request.getParameter("DDAMT").toString().trim();

if (request.getParameter("BANK")==null)
	mBANK="";
else
 	mBANK=request.getParameter("BANK").toString().trim();

if (request.getParameter("Doc10")==null)
	Doc10="N";
else
 	Doc10=request.getParameter("Doc10").toString().trim();

if (request.getParameter("Doc12")==null)
	Doc12="N";
else
 	Doc12=request.getParameter("Doc12").toString().trim();

if (request.getParameter("DocGrade")==null)
	DocGrade="N";
else
 	DocGrade=request.getParameter("DocGrade").toString().trim();

if (request.getParameter("DocScore")==null)
	DocScore="N";
else
 	DocScore=request.getParameter("DocScore").toString().trim();

if (request.getParameter("DocOther")==null)
	DocOther="N";
else
 	DocOther=request.getParameter("DocOther").toString().trim();


if (request.getParameter("TenYear")==null)
	TenYear="";
else
 	TenYear=request.getParameter("TenYear").toString().trim();

if (request.getParameter("TenStream")==null)
	TenStream="";
else
 	TenStream=request.getParameter("TenStream").toString().trim();

if (request.getParameter("TenBoard")==null)
	TenBoard="";
else
 	TenBoard=request.getParameter("TenBoard").toString().trim();

if (request.getParameter("TenPercent")==null)
	TenPercent="";
else
 	TenPercent=request.getParameter("TenPercent").toString().trim();



if (request.getParameter("TewYear")==null)
	TewYear="";
else
 	TewYear=request.getParameter("TewYear").toString().trim();

if (request.getParameter("TewStream")==null)
	TewStream="";
else
 	TewStream=request.getParameter("TewStream").toString().trim();


if (TewStream.equals("Others"))
{
TewStream=request.getParameter("TewStream1").toString().trim();
}



if (request.getParameter("TewBoard")==null)
	TewBoard="";
else
 	TewBoard=request.getParameter("TewBoard").toString().trim();

if (request.getParameter("TewPercent")==null)
	TewPercent="";
else
 	TewPercent=request.getParameter("TewPercent").toString().trim();





if (request.getParameter("GradYear")==null)
	GradYear="";
else
 	GradYear=request.getParameter("GradYear").toString().trim();

if (request.getParameter("GradStream")==null)
	GradStream="";
else
 	GradStream=request.getParameter("GradStream").toString().trim();



if (GradStream.equals("Others"))
{
GradStream=request.getParameter("GradStream1").toString().trim();
}



if (request.getParameter("GradBoard")==null)
	GradBoard="";
else
 	GradBoard=request.getParameter("GradBoard").toString().trim();

if (request.getParameter("GradPercent")==null)
	GradPercent="";
else
 	GradPercent=request.getParameter("GradPercent").toString().trim();


String Careergoal="",Career="";

if (request.getParameter("Career")==null)
	Career="";
else
 	Career=request.getParameter("Career").toString().trim();

if (request.getParameter("Careergoal")==null)
	Careergoal="";
else
 	Careergoal=request.getParameter("Careergoal").toString().trim();




if (request.getParameter("OtherYear")==null)
	OtherYear="";
else
 	OtherYear=request.getParameter("OtherYear").toString().trim();

if (request.getParameter("OtherStream")==null)
	OtherStream="";
else
 	OtherStream=request.getParameter("OtherStream").toString().trim();

if (request.getParameter("OtherBoard")==null)
	OtherBoard="";
else
 	OtherBoard=request.getParameter("OtherBoard").toString().trim();

if (request.getParameter("OtherPercent")==null)
	OtherPercent="";
else
 	OtherPercent=request.getParameter("OtherPercent").toString().trim();

if (request.getParameter("Appear")==null)
	Appear="N";
else
 	Appear=request.getParameter("Appear").toString().trim();

//---APPEARIGNG YEAR


if (request.getParameter("CATYEAR")==null)
	mCATYEAR="";
else
 	mCATYEAR=request.getParameter("CATYEAR").toString().trim();

if (request.getParameter("MATYEAR")==null)
	mMATYEAR="";
else
 	mMATYEAR=request.getParameter("MATYEAR").toString().trim();

if (request.getParameter("GMATYEAR")==null)
	mGMATYEAR="";
else
 	mGMATYEAR=request.getParameter("GMATYEAR").toString().trim();


if (request.getParameter("CMATYEAR")==null)
	mCMATYEAR="";
else
 	mCMATYEAR=request.getParameter("CMATYEAR").toString().trim();



//out.print(mGMATYEAR+"********************"+mCATYEAR+"----"+mMATYEAR+"###############"+mCMATYEAR);

//CATYEAR

if (request.getParameter("CAT")==null)
	mCAT="";
else
 	mCAT=request.getParameter("CAT").toString().trim();

if (request.getParameter("MAT")==null)
	mMAT="";
else
 	mMAT=request.getParameter("MAT").toString().trim();

if (request.getParameter("GMAT")==null)
	mGMAT="";
else
 	mGMAT=request.getParameter("GMAT").toString().trim();


if (request.getParameter("CMAT")==null)
	mCMAT="";
else
 	mCMAT=request.getParameter("CMAT").toString().trim();

String mXAT="",mOTHERS="",mATMA="";

if (request.getParameter("XAT")==null)
	mXAT="";
else
 	mXAT=request.getParameter("XAT").toString().trim();

if (request.getParameter("ATMA")==null)
	mATMA="";
else
 	mATMA=request.getParameter("ATMA").toString().trim();


if (request.getParameter("OTHERS")==null)
	mOTHERS="";
else
 	mOTHERS=request.getParameter("OTHERS").toString().trim();

if (request.getParameter("CMATRANK")==null)
	mCMATRANK="";
else
 	mCMATRANK=request.getParameter("CMATRANK").toString().trim();


if (request.getParameter("CATDATE")==null)
	CATDATE="";
else
 	CATDATE=request.getParameter("CATDATE").toString().trim();



if (request.getParameter("MATDATE")==null)
	MATDATE="";
else
 	MATDATE=request.getParameter("MATDATE").toString().trim();


if (request.getParameter("CMATDATE")==null)
	CMATDATE="";
else
 	CMATDATE=request.getParameter("CMATDATE").toString().trim();

if (request.getParameter("GMATDATE")==null)
	GMATDATE="";
else
 	GMATDATE=request.getParameter("GMATDATE").toString().trim();

if (request.getParameter("CATCOMP")==null)
	CATCOMP="";
else
 	CATCOMP=request.getParameter("CATCOMP").toString().trim();








if (request.getParameter("CATPER")==null)
	CATPER="";
else
 	CATPER=request.getParameter("CATPER").toString().trim();

if (request.getParameter("MATCOMP")==null)
	MATCOMP="";
else
 	MATCOMP=request.getParameter("MATCOMP").toString().trim();

if (request.getParameter("MATPER")==null)
	MATPER="";
else
 	MATPER=request.getParameter("MATPER").toString().trim();




if (request.getParameter("CMATCOMP")==null)
	CMATCOMP="";
else
 	CMATCOMP=request.getParameter("CMATCOMP").toString().trim();


if (request.getParameter("GMATCOMP")==null)
	GMATCOMP="";
else
 	GMATCOMP=request.getParameter("GMATCOMP").toString().trim();






if (request.getParameter("CMATPER")==null)
	CMATPER="";
else
 	CMATPER=request.getParameter("CMATPER").toString().trim();

if (request.getParameter("GMATPER")==null)
	GMATPER="";
else
 	GMATPER=request.getParameter("GMATPER").toString().trim();



String XATYEAR="",XATDATE="",XATCOMP="",XATPER="";


if (request.getParameter("XATCOMP")==null)
	XATCOMP="";
else
 	XATCOMP=request.getParameter("XATCOMP").toString().trim();


if (request.getParameter("XATYEAR")==null)
	XATYEAR="";
else
 	XATYEAR=request.getParameter("XATYEAR").toString().trim();



if (request.getParameter("XATPER")==null)
	XATPER="";
else
 	XATPER=request.getParameter("XATPER").toString().trim();

if (request.getParameter("XATDATE")==null)
	XATDATE="";
else
 	XATDATE=request.getParameter("XATDATE").toString().trim();

String ATMAYEAR="",ATMADATE="",ATMACOMP="",ATMAPER="";


if (request.getParameter("ATMACOMP")==null)
	ATMACOMP="";
else
 	ATMACOMP=request.getParameter("ATMACOMP").toString().trim();


if (request.getParameter("ATMAYEAR")==null)
	ATMAYEAR="";
else
 	ATMAYEAR=request.getParameter("ATMAYEAR").toString().trim();



if (request.getParameter("ATMAPER")==null)
	ATMAPER="";
else
 	ATMAPER=request.getParameter("ATMAPER").toString().trim();

if (request.getParameter("ATMADATE")==null)
	ATMADATE="";
else
 	ATMADATE=request.getParameter("ATMADATE").toString().trim();


String OTHCOMP="",OTHYEAR="",OTHPER="",OTHDATE="";


if (request.getParameter("OTHCOMP")==null)
	OTHCOMP="";
else
 	OTHCOMP=request.getParameter("OTHCOMP").toString().trim();


if (request.getParameter("OTHYEAR")==null)
	OTHYEAR="";
else
 	OTHYEAR=request.getParameter("OTHYEAR").toString().trim();



if (request.getParameter("OTHPER")==null)
	OTHPER="";
else
 	OTHPER=request.getParameter("OTHPER").toString().trim();

if (request.getParameter("OTHDATE")==null)
	OTHDATE="";
else
 	OTHDATE=request.getParameter("OTHDATE").toString().trim();














if (request.getParameter("Radio1")==null)
	mRadio1="";
else
 	mRadio1=request.getParameter("Radio1").toString().trim();

if (request.getParameter("AppSlno")==null)
	mApplicantSlno="";
else
 	mApplicantSlno=request.getParameter("AppSlno").toString().trim();


if (request.getParameter("Venue")==null)
	mVENUE="";
else
 	mVENUE=request.getParameter("Venue").toString().trim();

%><BR><%

String mAppYear="";


String mYear="";

if(request.getParameter("mYear")==null)
 	mAppYear="N";
else
	mAppYear=request.getParameter("mYear").toString().trim();

//out.print(mApplicantSlno);
qry="select 'Y' from    c#MBAAPPLICATIONMASTER where APPLICATIONSLNO='"+mApplicantSlno+"' " +
        "and nvl(deactive,'N')='N'  and  APPLICATIONSLNO like '"+mAppYear+"%'  ";
//
rs=db.getRowset(qry);
//out.print(qry);
if(rs.next())
{

//*************Inserting Records in Master********************//
//out.print(mCategory);

qry="UPDATE    c#MBAAPPLICATIONMASTER SET  APPLICATIONNO = '"+mAppNo+"',STUDENTNAME= '"+mFName+"',FATHERNAME = '"+mFatherName+"',MOTHERNAME='"+mMotherName+"' ,RELIGION='"+mReligion+"' ,AADHARNO='"+mAadhar+"', DATEOFBIRTH =to_date('"+mDOB+"','dd-mm-yyyy') ,CATEGORY ='"+mCategory+"' , SEX = '"+mSex+"',ENTRYBY ='"+mChkMemID+"' ,ENTRYDATE =Sysdate  ,NATIONALITY  ='"+mNationality+"' , CHECKSCORECARD='"+DocScore+"' ,APPEARINGININST = '"+Appear+"'  ,VENUECHOICE='"+mVENUE+"' WHERE  APPLICATIONSLNO ='"+mApplicantSlno+"' ";


int n=db.update(qry);
	if(n>0)
	 {
		mFlag=1;
	  out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'> Record Updated !!!  <br>");
	 }
	 else
	 {
		 mFlag=2;
	 }


//*************Inserting Records in Address********************//
if(mFlag==1)
{

qry="select 'Y' from    c#MBAAPPLICANTADD where APPLICATIONSLNO='"+mApplicantSlno+"' and nvl(deactive,'N')='N' and  APPLICATIONSLNO like '"+mAppYear+"%'  ";

rs=db.getRowset(qry);

if(rs.next())
{

qry1="UPDATE    c#MBAAPPLICANTADD SET   ADDRESS1='"+mADDRESS1+"' , ADDRESS2='"+mADDRESS2+"' ,CITY = '"+mCITY+"' ,STATE = '"+mSTATE+"' , PIN  ='"+mPIN+"' , COUNTRY ='"+mCountry+"',PHONE='"+mMOBILE+"' ,EMAILID ='"+memail+"' , ENTRYBY ='"+mChkMemID+"' , ENTRYDATE =sysdate  WHERE  APPLICATIONSLNO='"+mApplicantSlno+"' and  nvl(DEACTIVE,'N')='N' ";

//out.print(qry1);
int m=db.update(qry1);

if(m>0)
	 {
	//	mFlag=1;
	//out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'> Record Inserted !!!  <br>");
	 }

}
else
	{

qry1="INSERT INTO    c#MBAAPPLICANTADD (APPLICATIONSLNO, ADDRESS1, ADDRESS2,  CITY, STATE, PIN,  COUNTRY, PHONE, EMAILID,  ENTRYBY, ENTRYDATE, DEACTIVE) VALUES ( '"+mApplicantSlno+"','"+mADDRESS1+"' ,'"+mADDRESS2+"' ,'"+mCITY+"'    ,'"+mSTATE+"' , '"+mPIN+"',  '"+mCountry+"'  , '"+mMOBILE+"', '"+memail+"',  '"+mChkMemID+"'  ,  sysdate , 'N')";

int x=db.insertRow(qry1);

if(x>0)
	 {
	//	mFlag=1;
	//out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'> Record Inserted !!!  <br>");
	 }


	}
//Bank detail
qry="select 'Y' from    C#MBAPERSONALBANKDETAIL where APPLICATIONSLNO='"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%'  ";

rs=db.getRowset(qry);

if(rs.next())
{
//String mReligion="",mAadhar="",mNAMEOFACHOLDER="",mNAMEOFBANK="",mBANKACCOUNTNO="",mBRANCHNAME="",mBANKADDRESS="",mIFSCCODE="";
qry1="UPDATE    C#MBAPERSONALBANKDETAIL SET   NAMEOFACHOLDER='"+mNAMEOFACHOLDER+"' ,BANKACCOUNTNO='"+mBANKACCOUNTNO+"', NAMEOFBANK='"+mNAMEOFBANK+"' ,BRANCHNAME = '"+mBRANCHNAME+"' ,BANKADDRESS = '"+mBANKADDRESS+"' , IFSCCODE  ='"+mIFSCCODE+"'  WHERE  APPLICATIONSLNO='"+mApplicantSlno+"' ";

//out.print(qry1);
int m=db.update(qry1);

if(m>0)
	 {
	//	mFlag=1;
	//out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'> Record Inserted !!!  <br>");
	 }

}
else
	{

qry1="INSERT INTO    C#MBAPERSONALBANKDETAIL (APPLICATIONSLNO, NAMEOFACHOLDER,BANKACCOUNTNO, NAMEOFBANK,  BRANCHNAME, BANKADDRESS, IFSCCODE) VALUES ( '"+mApplicantSlno+"','"+mNAMEOFACHOLDER+"' ,'"+mBANKACCOUNTNO+"' ,'"+mNAMEOFBANK+"','"+mBRANCHNAME+"'    ,'"+mBANKADDRESS+"' , '"+mIFSCCODE+"')";

int x=db.insertRow(qry1);

if(x>0)
	 {
	//	mFlag=1;
	//out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'> Record Inserted !!!  <br>");
	 }


	}

//



//------------------------------------work experience


String WORKDATETO="",COMPANY="N",AREA="",DESIGNATION="",WORKDATEFROM="";
String qryexp="";
int exp=0;
int  totalexp=Integer.parseInt(request.getParameter("totalexp"));

for(int yy=1;yy<=totalexp;yy++)
	{
		if(request.getParameter("COMPANY"+yy)==null)
		{
			COMPANY="N";
		}
		else
		{
			COMPANY=request.getParameter("COMPANY"+yy);

		}

		if(request.getParameter("AREA"+yy)==null)
		{
			AREA="N";
		}
		else
		{
			AREA=request.getParameter("AREA"+yy);

		}

		if(request.getParameter("DESIGNATION"+yy)==null)
		{
			DESIGNATION="N";
		}
		else
		{
			DESIGNATION=request.getParameter("DESIGNATION"+yy);

		}

		if(request.getParameter("WORKDATEFROM"+yy)==null)
		{
			WORKDATEFROM="N";
		}
		else
		{
			WORKDATEFROM=request.getParameter("WORKDATEFROM"+yy);

		}

		if(request.getParameter("WORKDATETO"+yy)==null)
		{
			WORKDATETO="N";
		}
		else
		{
			WORKDATETO=request.getParameter("WORKDATETO"+yy);

		}

//out.print(COMPANY+"COMPANY"+COMPANY.equals(""));

		if(!COMPANY.equals("N") && !COMPANY.equals("") )
		{//
				qry="SELECT 'Y' FROM    c#MBAAPPLICANTWORKEXP where APPLICATIONSLNO='"+mApplicantSlno+"' and EXPSLNO="+yy+"";
				rs=db.getRowset(qry);
				if(rs.next())
				{




			 qryexp="UPDATE    c#MBAAPPLICANTWORKEXP SET          COMPANYNAME     = '"+COMPANY+"' ,       DESIGNATION     = '"+DESIGNATION+"' ,       WORKDATEFROM    = to_date('"+WORKDATEFROM+"','dd-mm-yyyy')  ,       WORKDATETO      =  to_date('"+WORKDATETO+"','dd-mm-yyyy')   ,       WORKINGAREA     =  '"+AREA+"' WHERE  APPLICATIONSLNO = '"+mApplicantSlno+"' 	AND    EXPSLNO         = "+yy+" and  APPLICATIONSLNO like '"+mAppYear+"%' ";

	//out.print(qryexp);
			 exp=db.update(qryexp);
				}
				else
			{
			 qryexp="INSERT INTO    c#MBAAPPLICANTWORKEXP (APPLICATIONSLNO, EXPSLNO, COMPANYNAME,    DESIGNATION, WORKDATEFROM, WORKDATETO,    WORKINGAREA, DEACTIVE) VALUES ('"+mApplicantSlno+"' ,"+yy+" ,'"+COMPANY+"' , '"+DESIGNATION+"' ,  to_date('"+WORKDATEFROM+"','dd-mm-yyyy')  , to_date('"+WORKDATETO+"','dd-mm-yyyy')  , '"+AREA+"'    ,'N' )";
	//	out.print(qryexp);
			 exp=db.insertRow(qryexp);

			}



		}



	}



//------------------------------------




//----------carreer goal

if(!Career.equals(""))
	{
//out.print(qry);
qry="UPDATE    c#MBAOBJECTIVE SET           CAREEROBJECTIVE ='"+Career+"' ,    JBSHELP         = '"+Careergoal+"' WHERE APPLICATIONSLNO = '"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
int g=db.insertRow(qry);


	}









//*************Inserting Records in Score********************//

//out.print(mCAT+"=cat"+mMAT+"=mat"+mXAT+"=xat"+mGMAT+"=-GMAT");


String qrycate="SELECT 'Y' FROM    c#MBATESTSCORE WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and TESTCODE='"+mCAT+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
//out.print(qrycate+"xx");
ResultSet rscate=db.getRowset(qrycate);
if(rscate.next())
{
	if(mCAT.equals("CAT") )
	{
	qryc="UPDATE    c#MBATESTSCORE SET PERCENTAGE ='"+CATPER+"'  ,COMPOSITESCORE = '"+CATCOMP+"',CHECKSCORE ='"+DocScore+"',RESULTVALIDUPTO= to_date('"+CATDATE+"','dd-mm-yyyy')  , YEAROFAPPEARING='"+mCATYEAR+"'  where APPLICATIONSLNO='"+mApplicantSlno+"' AND TESTCODE='"+mCAT+"'    ";
//out.print(qryc+"xx");
	int c=db.update(qryc);
	}
}
else
{
	if(!CATPER.equals("") && mCAT.equals("CAT"))
	{
		qryc="INSERT INTO    c#MBATESTSCORE (APPLICATIONSLNO, TESTCODE, PERCENTAGE, COMPOSITESCORE,CHECKSCORE,RESULTVALIDUPTO,YEAROFAPPEARING) VALUES ('"+mApplicantSlno+"' ,'"+mCAT+"' ,'"+CATPER+"' ,'"+CATCOMP+"','"+DocScore+"' , to_date('"+CATDATE+"','dd-mm-yyyy') ,'"+mCATYEAR+"' )";

		int c=db.insertRow(qryc);
	}
}
//		out.print(qryc+"xx");
String qrygmat="SELECT 'Y' FROM    c#MBATESTSCORE WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and TESTCODE='"+mGMAT+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";

ResultSet rsgmat=db.getRowset(qrygmat);
if(rsgmat.next())
{
	if(mGMAT.equals("GMAT") )
	{
		qryg="UPDATE    c#MBATESTSCORE SET PERCENTAGE ='"+GMATPER+"'  ,COMPOSITESCORE = '"+GMATCOMP+"',CHECKSCORE ='"+DocScore+"',RESULTVALIDUPTO= to_date('"+GMATDATE+"','dd-mm-yyyy') , YEAROFAPPEARING='"+mGMATYEAR+"'   where APPLICATIONSLNO='"+mApplicantSlno+"' AND TESTCODE='"+mGMAT+"'   YEAROFAPPEARING='"+mGMATYEAR+"' ";

		int g=db.update(qryg);
	}
}
else
{
	if(!GMATPER.equals("") && mGMAT.equals("GMAT") )
	{
	qryg="INSERT INTO    c#MBATESTSCORE (APPLICATIONSLNO, TESTCODE, PERCENTAGE, COMPOSITESCORE,CHECKSCORE,RESULTVALIDUPTO,YEAROFAPPEARING) VALUES ('"+mApplicantSlno+"' ,'"+mGMAT+"' ,'"+GMATPER+"' ,'"+GMATCOMP+"','"+DocScore+"',to_date('"+GMATDATE+"','dd-mm-yyyy'),'"+mGMATYEAR+"'  )";
	int g=db.insertRow(qryg);
	}
}


String qryCmat="SELECT 'Y' FROM    c#MBATESTSCORE WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and TESTCODE='"+mCMAT+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";

ResultSet rsCmat=db.getRowset(qryCmat);
if(rsCmat.next())
{
	if(mCMAT.equals("CMAT") )
	{
		qryg="UPDATE    c#MBATESTSCORE SET PERCENTAGE ='"+CMATPER+"'  ,COMPOSITESCORE = '"+CMATCOMP+"',CHECKSCORE ='"+DocScore+"',RESULTVALIDUPTO= to_date('"+CMATDATE+"','dd-mm-yyyy'),RANK='"+mCMATRANK+"' , YEAROFAPPEARING='"+mCMATYEAR+"'  where APPLICATIONSLNO='"+mApplicantSlno+"' AND TESTCODE='"+mCMAT+"'    ";
	//out.print(qryg);
		int gG=db.update(qryg);
	}
}
else
{
	if(!CMATPER.equals("") && mCMAT.equals("CMAT") )
	{
	qryg="INSERT INTO    c#MBATESTSCORE (APPLICATIONSLNO, TESTCODE, PERCENTAGE, COMPOSITESCORE,CHECKSCORE,RESULTVALIDUPTO,RANK,YEAROFAPPEARING) VALUES ('"+mApplicantSlno+"' ,'"+mCMAT+"' ,'"+CMATPER+"' ,'"+CMATCOMP+"','"+DocScore+"',to_date('"+CMATDATE+"','dd-mm-yyyy'),'"+mCMATRANK+"','"+mCMATYEAR+"' )";

	///out.print(qryg);
	int gG=db.insertRow(qryg);
	}
}


String qrymat="SELECT 'Y' FROM    c#MBATESTSCORE WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and " +
        " TESTCODE='"+mMAT+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";

ResultSet rsmat=db.getRowset(qrymat);
if(rsmat.next())
{
	if(mMAT.equals("MAT") )
	{
		qryt="UPDATE    c#MBATESTSCORE SET PERCENTAGE ='"+MATPER+"'  ,COMPOSITESCORE = '"+MATCOMP+"',CHECKSCORE ='"+DocScore+"' ,RESULTVALIDUPTO= to_date('"+MATDATE+"','dd-mm-yyyy') , YEAROFAPPEARING='"+mMATYEAR+"'  where APPLICATIONSLNO='"+mApplicantSlno+"' AND TESTCODE='"+mMAT+"'    ";
		//out.print(qryt);
		int a=db.update(qryt);
	}
}
else
{
	if(!MATPER.equals("") && mMAT.equals("MAT") )
	{
	qryt="INSERT INTO    c#MBATESTSCORE (APPLICATIONSLNO, TESTCODE, PERCENTAGE, COMPOSITESCORE,CHECKSCORE,RESULTVALIDUPTO,YEAROFAPPEARING) VALUES ('"+mApplicantSlno+"' ,'"+mMAT+"' ,'"+MATPER+"' ,'"+MATCOMP+"' ,'"+DocScore+"',to_date('"+MATDATE+"','dd-mm-yyyy'),'"+mMATYEAR+"' )";
	int a=db.insertRow(qryt);
	}
}

String qryXat="SELECT 'Y' FROM    c#MBATESTSCORE WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and " +
        " TESTCODE='"+mXAT+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
//
ResultSet rsXat=db.getRowset(qryXat);
//out.print("Gyabn");
if(rsXat.next())
{
	if(mXAT.equals("XAT") )
	{
		qryt="UPDATE    c#MBATESTSCORE SET PERCENTAGE ='"+XATPER+"'  ,COMPOSITESCORE = '"+XATCOMP+"' " +
                ",CHECKSCORE ='"+DocScore+"' ,RESULTVALIDUPTO= to_date('"+XATDATE+"','dd-mm-yyyy') , YEAROFAPPEARING='"+XATYEAR+"' " +
                " where APPLICATIONSLNO='"+mApplicantSlno+"' AND TESTCODE='"+mXAT+"'    ";
		//out.print(qryt);
		int a=db.update(qryt);
	}
}
else
{
	if(!XATPER.equals("") && mXAT.equals("XAT") )
	{
	qryt="INSERT INTO    c#MBATESTSCORE (APPLICATIONSLNO, TESTCODE," +
            " PERCENTAGE, COMPOSITESCORE,CHECKSCORE,RESULTVALIDUPTO,YEAROFAPPEARING)" +
            " VALUES ('"+mApplicantSlno+"' ,'"+mXAT+"' ,'"+XATPER+"' ,'"+XATCOMP+"' ,'"+DocScore+"',to_date('"+XATDATE+"','dd-mm-yyyy'),'"+XATYEAR+"' )";
	int a=db.insertRow(qryt);
	}
}

//ATMA
String qryAtma="SELECT 'Y' FROM    c#MBATESTSCORE WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and " +
        " TESTCODE='"+mATMA+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
//
ResultSet rsAtma=db.getRowset(qryAtma);
//out.print("Gyabn");
if(rsAtma.next())
{
	if(mATMA.equals("ATMA") )
	{
		qryt="UPDATE    c#MBATESTSCORE SET PERCENTAGE ='"+ATMAPER+"'  ,COMPOSITESCORE = '"+ATMACOMP+"' " +
                ",CHECKSCORE ='"+DocScore+"' ,RESULTVALIDUPTO= to_date('"+ATMADATE+"','dd-mm-yyyy') , YEAROFAPPEARING='"+ATMAYEAR+"' " +
                " where APPLICATIONSLNO='"+mApplicantSlno+"' AND TESTCODE='"+mATMA+"'    ";
		//out.print(qryt);
		int a=db.update(qryt);
	}
}
else
{
	if(!ATMAPER.equals("") && mATMA.equals("ATMA") )
	{
	qryt="INSERT INTO    c#MBATESTSCORE (APPLICATIONSLNO, TESTCODE," +
            " PERCENTAGE, COMPOSITESCORE,CHECKSCORE,RESULTVALIDUPTO,YEAROFAPPEARING)" +
            " VALUES ('"+mApplicantSlno+"' ,'"+mATMA+"' ,'"+ATMAPER+"' ,'"+ATMACOMP+"' ,'"+DocScore+"',to_date('"+ATMADATE+"','dd-mm-yyyy'),'"+ATMAYEAR+"' )";
	int a=db.insertRow(qryt);
	}
}
//ATMA

try{
String qryOTH="SELECT 'Y' FROM    c#MBATESTSCORE WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and " +
        " TESTCODE='"+mOTHERS+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";

ResultSet rsOTH=db.getRowset(qryOTH);
if(rsOTH.next())
{
	if(mOTHERS.equals("OTHERS") )
	{
		qryt="UPDATE    c#MBATESTSCORE SET PERCENTAGE ='"+OTHPER+"'  " +
                ",COMPOSITESCORE = '"+OTHCOMP+"',CHECKSCORE ='"+DocScore+"' ," +
                "RESULTVALIDUPTO= to_date('"+OTHDATE+"','dd-mm-yyyy') , YEAROFAPPEARING='"+OTHYEAR+"'  " +
                "where APPLICATIONSLNO='"+mApplicantSlno+"' AND TESTCODE='"+mOTHERS+"'    ";
		//out.print(qryt);
		int a=db.update(qryt);
	}
}
else
{//out.print(qryOTH);
	if(!OTHPER.equals("") && mOTHERS.equals("OTHERS") )
	{
	qryt="INSERT INTO    c#MBATESTSCORE (APPLICATIONSLNO, TESTCODE, PERCENTAGE, COMPOSITESCORE," +
            "CHECKSCORE,RESULTVALIDUPTO,YEAROFAPPEARING) VALUES ('"+mApplicantSlno+"' ,'"+mOTHERS+"'  " +
            " ,'"+OTHPER+"' ,'"+OTHCOMP+"' ,'"+DocScore+"',to_date('"+OTHDATE+"','dd-mm-yyyy'),'"+OTHYEAR+"' )";
	int a=db.insertRow(qryt);
	}
}}catch(Exception e)
{
//out.print("EEEEE"+e);
}
//out.print("Gyan");

if( !mDDNO.equals("") &&  !mDDAMT.equals("") && !mDDDATE.equals(""))
	{

qryfee="UPDATE    c#MBAFEE SET  CHEQUEDDNO = '"+mDDNO+"',  CHEQUEDDDATE= to_date('"+mDDDATE+"','dd-mm-yyyy'), CHQDDTYPE = 'D',AMOUNT= '"+mDDAMT+"',BANKNAME='"+mBANK+"'  WHERE  APPLICATIONSLNO = '"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
	}
	else
	{
qryfee="UPDATE    c#MBAFEE SET  CHQDDTYPE = 'P',AMOUNT= '"+mPurchAmt+"' WHERE  APPLICATIONSLNO= '"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";

	}
	int d=db.update(qryfee);
}
else if(mFlag==2)
{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error While Updating <br>");
}
}
else
{
        out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Already Exists <br>");
}

/******10th update and insert */
qryup="SELECT 'Y' FROM    c#QUALIFICATION where APPLICATIONSLNO = '"+mApplicantSlno+"' AND QUALIFICATIONCODE ='"+m10TH+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";

rsup=db.getRowset(qryup);

if(rsup.next())
{
	if(m10TH.equals("10TH"))
	{
	qryten="UPDATE    c#QUALIFICATION SET   PERCENTAGE ='"+TenPercent+"', BOARD='"+TenBoard+"', PASSINGYEAR='"+TenYear+"' ,DOCUMENT ='"+Doc10+"'  WHERE  APPLICATIONSLNO='"+mApplicantSlno+"' AND QUALIFICATIONCODE ='"+m10TH+"' ";
	int ten=db.update(qryten);
	}
}
else
{
	if(  !TenPercent.equals("") && m10TH.equals("10TH"))
	{
	qry10="insert into     c#QUALIFICATION   (APPLICATIONSLNO,QUALIFICATIONCODE,QUALIFICATIONDESC,PERCENTAGE,BOARD,PASSINGYEAR,DOCUMENT ) values ('"+mApplicantSlno+"','"+m10TH+"','TENTH' ,'"+TenPercent+"','"+TenBoard+"','"+TenYear+"','"+Doc10+"')";
	int rs10=db.insertRow(qry10);
	}
}


/******12th update and insert */
qrytwel="SELECT 'Y' FROM    c#QUALIFICATION where APPLICATIONSLNO = '"+mApplicantSlno+"'  AND QUALIFICATIONCODE ='"+m12TH+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
rstwel=db.getRowset(qrytwel);
if(rstwel.next())
{


if(m12TH.equals("12TH")  )
	{
	qrytw="UPDATE    c#QUALIFICATION SET   PERCENTAGE ='"+TewPercent+"', BOARD='"+TewBoard+"', PASSINGYEAR='"+TewYear+"', STREAM='"+TewStream+"'  ,DOCUMENT ='"+Doc12+"'  WHERE  APPLICATIONSLNO='"+mApplicantSlno+"' AND QUALIFICATIONCODE ='"+m12TH+"' ";
	int tw=db.update(qrytw);
	}
}
else
{
	if(  !TewPercent.equals("") && m12TH.equals("12TH"))
	{
	qry12="insert into     c#QUALIFICATION   (APPLICATIONSLNO,QUALIFICATIONCODE,QUALIFICATIONDESC,PERCENTAGE,BOARD,PASSINGYEAR,STREAM,DOCUMENT ) values ('"+mApplicantSlno+"','"+m12TH+"','TWELFTH' ,'"+mPer12+"','"+TewBoard+"','"+TewYear+"','"+TewStream+"','"+Doc12+"')";

	int rs12=db.insertRow(qry12);
	}
}



/******grade update and insert */
qrygred="SELECT 'Y' FROM    c#QUALIFICATION where APPLICATIONSLNO = '"+mApplicantSlno+"'  AND QUALIFICATIONCODE ='"+mGRAD+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
//out.print(qrygred);
rsgrd=db.getRowset(qrygred);

if(rsgrd.next())
{
if(mGRAD.equals("GRAD") )
	{
	qrygrd="UPDATE    c#QUALIFICATION SET   PERCENTAGE ='"+GradPercent+"', BOARD='"+GradBoard+"', PASSINGYEAR='"+GradYear+"', STREAM='"+GradStream+"' , DOCUMENT ='"+DocGrade+"'  WHERE  APPLICATIONSLNO='"+mApplicantSlno+"' AND QUALIFICATIONCODE ='GRAD' ";
	//out.print(qrygrd);
    int grd=db.update(qrygrd);

	}
}
else if (!GradPercent.equals("") && mGRAD.equals("GRAD") )
{
//out.print(qrygred);
qrygrd="insert into     c#QUALIFICATION   (APPLICATIONSLNO,QUALIFICATIONCODE,QUALIFICATIONDESC,PERCENTAGE,BOARD,PASSINGYEAR,STREAM,DOCUMENT ) values ('"+mApplicantSlno+"','GRAD','GRAD' ,'"+GradPercent+"','"+GradBoard+"','"+GradYear+"','"+GradStream+"','"+DocGrade+"')";
//out.print(qrygrd);
int grd=db.insertRow(qrygrd);

}
//OTHER MARKS

qrygred="SELECT 'Y' FROM    c#QUALIFICATION where APPLICATIONSLNO = '"+mApplicantSlno+"'  AND QUALIFICATIONCODE ='"+mOTHER+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
rsgrd=db.getRowset(qrygred);

if(rsgrd.next())
{
if(mOTHER.equals("OTHER") )
	{
	qrygrd="UPDATE    c#QUALIFICATION SET   PERCENTAGE ='"+OtherPercent+"', BOARD='"+OtherBoard+"', PASSINGYEAR='"+OtherYear+"', STREAM='"+OtherStream+"' , DOCUMENT ='"+DocOther+"'  WHERE  APPLICATIONSLNO='"+mApplicantSlno+"' AND QUALIFICATIONCODE ='"+mOTHER+"' ";
	int ot=db.update(qrygrd);

	}
}
else if (!OtherPercent.equals("") && mOTHER.equals("OTHER") )
{

qrygrd="insert into     c#QUALIFICATION   (APPLICATIONSLNO,QUALIFICATIONCODE,QUALIFICATIONDESC,PERCENTAGE,BOARD,PASSINGYEAR,STREAM,DOCUMENT ) values ('"+mApplicantSlno+"','"+mOTHER+"','"+mOTHER+"' ,'"+OtherPercent+"','"+OtherBoard+"','"+OtherYear+"','"+OtherStream+"','"+DocOther+"')";
	int ot=db.insertRow(qrygrd);

}
//satendra
try{
    String choice="";
for (int i = 1; i <= 3; i++) {
if (request.getParameter("location" + i) == null) {
             choice = "N";
    } else {
   choice = request.getParameter("location" + i).toString().trim();
           }


    //ResultSet loc=null;
   //String qryloc="insert into C#MBALOCATIONPREFERENCE(APPLICATIONSLNO, LOCATIONCODE, PREFERENCE)values('"+mApplicantSlno+"','"+choice+"','"+i+"') ";
     qryprf= " UPDATE C#MBALOCATIONPREFERENCE SET LOCATIONCODE ='"+choice+"' WHERE APPLICATIONSLNO = '"+mApplicantSlno+"'  and PREFERENCE = '"+i+"'";
// String qryloc="INSERT INTO C#QUALIFICATION (   APPLICATIONSLNO, QUALIFICATIONCODE, QUALIFICATIONDESC, PERCENTAGE,DOCUMENT,BOARD, PASSINGYEAR, STREAM) VALUES ('"+mApplicantSlno+"' ,'OTHER' ,'OTHER' , '"+OtherPercent+"','"+DocOther+"','"+OtherBoard+"','"+OtherYear+"','"+OtherStream+"')";
    int awt12=db.update(qryprf);
    //out.print(qryprf);
    if(awt12>0){
        //out.print("Successfully Updated");
        }
    //out.print("choice   " + i+"-"+choice+"<br>");
      }
}
catch(Exception e)
{
	//out.print("Location Exception"+e);
}
//satendra
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Jaypee Institute of Information Technology</title>
</head>
<BODY bgcolor=white  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  >
 <table  border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups borderColor=black>
<tr><td ALIGN=middle>
<FONT face=Verdana size=3 color=brown size=4><STRONG><U>JAYPEE INSTITUTE OF INFORMATION TECHNOLOGY UNIVERSITY  <br>Jaypee Business School</U></STRONG></FONT>
<BR>
<FONT face=Verdana size=1>((Declared Deemed to be University u/s 3 of the UGC Act,1956))</FONT>
</td></tr>
<tr><td ALIGN=middle>
<STRONG><FONT face=Verdana size=4>MBA APPLICATION FORM - <%=mAppYear%> </FONT><br><FONT size=2>(Do not submit without copy of  CAT/MAT/CMAT/GMAT/XAT/ATMA score card)</FONT></STRONG>
<BR>
</td></tr>
</table>
<%
qry="SELECT a.applicationslno, a.applicationno, a.studentname, a.fathername,a.MOTHERNAME,a.RELIGION,a.AADHARNO, a.VENUECHOICE,  " +
        "    TRUNC (TO_DATE (a.dateofbirth, 'dd-mm-rrrr')) dob,     " +
        " decode(a.CATEGORY,'GN','General','SC','SC','ST','ST','OBC','OBC',a.CATEGORY)CATEGORY,    " +
        "   DECODE(a.sex,'F','Female','M','Male')SEX, nvl(a.nationality, '')nationality," +
        " decode(a.checkscorecard,'Y','Yes','N','No','No')checkscorecard, " +
        "decode(a.APPEARINGININST,'Y','Yes','N','No','No')appearingininst, " +
        "nvl(b.ADDRESS1,' ')ADDRESS1, nvl(b.ADDRESS2,' ')ADDRESS2, nvl(b.CITY,' ')CITY, " +
        "nvl(b.STATE,' ')STATE, nvl(b.PIN, ' ')PIN, nvl(b.COUNTRY,' ')COUNTRY, nvl(b.PHONE,' ')PHONE, " +
        "nvl(b.EMAILID,' ')EMAILID FROM   c#mbaapplicationmaster a,  c#MBAAPPLICANTADD b " +
        "WHERE a.applicationslno = '"+mApplicantSlno+"'  and a.APPLICATIONSLNO=b.APPLICATIONSLNO and " +
        " a.APPLICATIONSLNO like '"+mAppYear+"%'";

//out.print(qry);
rs=db.getRowset(qry);

if(rs.next())
{
mVenueqry=rs.getString("VENUECHOICE")==null?"":rs.getString("VENUECHOICE").toString();
mAppearIn=rs.getString("APPEARINGININST")==null?"":rs.getString("APPEARINGININST").toString();
mCheckScore=rs.getString("checkscorecard")==null?"":rs.getString("checkscorecard").toString();

%>
<table width="98%" border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small" valign="middle" align=center rules=groups>
<tr>
<td> <FONT face=Verdana color="blue" size=2><b>Application Slno : <%=rs.getString("APPLICATIONSLNO")%> </b></font></td>
</TR>
<TR>
<td colspan=3><FONT face=Verdana>1. Name of Candidate (IN CAPITAL LETTERS) <%=rs.getString("STUDENTNAME")%></FONT>
</td></tr>
<tr><td colspan=3 align=left><FONT face=Verdana> 2. Father's Name :&nbsp;&nbsp;&nbsp;<%=rs.getString("FATHERNAME")%> </FONT></td></tr>
<tr><td colspan=3 align=left><FONT face=Verdana> 3. MotherMother Name :&nbsp;&nbsp;&nbsp;<%=rs.getString("MOTHERNAME")%> </FONT></td></tr>
<tr><td><FONT face=Verdana>4. Gender :
<%=rs.getString("SEX")%>
</FONT>
</td>
<td><FONT face=Verdana>5. Date of Birth : &nbsp;&nbsp;<%=mDOB%></FONT><br>
</td></tr>
<tr><td colspan=3><FONT face=Verdana>6. Category:<%=rs.getString("CATEGORY")==null?"":rs.getString("CATEGORY").trim()%></FONT></td></tr>
<tr><td colspan=3><FONT face=Verdana>7. Religion : <b><%=rs.getString("RELIGION")%></b></FONT></td></tr>
<tr><td colspan=3><FONT face=Verdana>8. Aadhar No. : <b><%=rs.getString("AADHARNO")%></b></FONT></td></tr>
<tr><td colspan=3><FONT face=Verdana size=2>9. Contact Address of the Candidate(IN CAPITAL LETTERS)
<br>&nbsp; &nbsp; &nbsp; &nbsp;<%=rs.getString("ADDRESS1")%>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs.getString("ADDRESS2")%></FONT>
<br>&nbsp; &nbsp; &nbsp; &nbsp;<FONT face=Verdana size=2>City: <%=rs.getString("CITY")%>  </FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;<FONT face=Verdana size=2>PIN: <%=rs.getString("PIN")%></FONT>
</FONT><br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<FONT face=Verdana size=2>State:
<%qry1="select nvl(statecode,' ')statecode,nvl(statename,'  ') statename  from  c#statemaster" +
        " where nvl(deactive,'N')='N' and statecode='"+rs.getString("STATE")+"'";
    rs1=db.getRowset(qry1);
if(rs1.next())
    {
mState=rs1.getString("statename")==null?"":rs1.getString("statename").trim();
}
%><%=mState%></FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Verdana size=2>PhoneNo or Moblie No: <%=rs.getString("PHONE")%></font>
</FONT>
</td>
</tr>
<tr>
<td colspan=3>
<FONT face=Verdana> 10. Email Address (if any):&nbsp; <%=rs.getString("EMAILID")%>
</FONT>
</td>
</tr>

<tr>
<td colspan=3><FONT face=Verdana>11. Nationality:  &nbsp;<%=rs.getString("NATIONALITY")%>
</FONT>
</td>
</tr>

<%

	qryqua="SELECT distinct QUALIFICATIONCODE, QUALIFICATIONDESC,PERCENTAGE,decode(DOCUMENT,'Y','Yes','N','No',' ','No')DOCUMENT FROM   c#QUALIFICATION WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%'  ";
	//out.print(qryqua);
	rsq=db.getRowset(qryqua);
	while(rsq.next())
    {

		mQual=rsq.getString("QUALIFICATIONCODE");
		if(mQual.equals("10TH"))
		{

		mDoc10=rsq.getString("DOCUMENT");
		}
		if(mQual.equals("12TH"))
		{
		mDoc12=rsq.getString("DOCUMENT");
		}
		if(mQual.equals("GRAD"))
		{

			mDocGrad=rsq.getString("DOCUMENT");
		}
		if(mQual.equals("OTHER"))
		{

			mDocOther=rsq.getString("DOCUMENT");
		}
	}
	%>
	<TR>
<td colspan=3 align=left><FONT face=Verdana>12. Current Qualification
<TABLE BORDER=1 ALIGN=center>
<tr>

			<td><font face='Verdana' size=2 ><b>Year of Completion</b></td>
			<td><font face='Verdana' size=2 ><b>Stream </b></td>
			<td><font face='Verdana' size=2 ><b>Board / University</b></td>
			<td><font face='Verdana' size=2 ><b>% of Marks</b></td>
</tr>
<%
qry="SELECT distinct  nvl(QUALIFICATIONCODE,' ')QUALIFICATIONCODE, nvl(QUALIFICATIONDESC,' ')QUALIFICATIONDESC, PERCENTAGE, nvl(DOCUMENT,' ')DOCUMENT, nvl(BOARD,' ')BOARD,PASSINGYEAR, nvl(STREAM,' ')STREAM from   c#QUALIFICATION where APPLICATIONSLNO='"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%' order by PASSINGYEAR desc ";
rs=db.getRowset(qry);
while(rs.next())
{
%>
	<tr>

		<td><font face='Verdana' size=2 ><b><%=rs.getString("PASSINGYEAR")%></b></td>
		<td><font face='Verdana' size=2 ><b><%=rs.getString("STREAM")%></b></td>
		<td><font face='Verdana' size=2 ><b><%=rs.getString("BOARD")%></b></td>
		<td><font face='Verdana' size=2 ><b><%=rs.getDouble("PERCENTAGE")%></b></td>

	</tr>


	<%
}

		%>
		</table>

<br>
<FONT face=Verdana><sup>*</sup> If appearing,attach certificate from Head of Institution.[e.g Science/Arts/Commerce/Others(specify)] :
<b><%=mAppearIn%>		 </b>
</font> <br>

 <FONT face=Verdana>13. Please Fill as Applicable  (Attach copy of Score Card Mandatory)
<table BORDER=1 ALIGN=center>
<tr>
<td><font face='Verdana' size=2 ><b>Exam</b></td>
<td><font face='Verdana' size=2 ><b>Month & Yr. of Apppering</b></td>
<td><font face='Verdana' size=2 ><b>Composite Score/Total Score</b></td>
<td><font face='Verdana' size=2 ><b>Percentile/Total Percentile	</b></td>
<td><font face='Verdana' size=2 ><b>Rank</b></td>
<td><font face='Verdana' size=2 ><b>Result Valid Upto</b></td>
</tr>
<%
qrycomp="SELECT distinct APPLICATIONSLNO, TESTCODE, PERCENTAGE, COMPOSITESCORE, CHECKSCORE,to_char(RESULTVALIDUPTO,'dd-mm-yyyy')RESULTVALIDUPTO,NVL(RANK,'')RANK  , YEAROFAPPEARING FROM   c#MBATESTSCORE where APPLICATIONSLNO='"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%'  order by YEAROFAPPEARING desc ";
//out.print(qrycomp);
rscomp=db.getRowset(qrycomp);
while(rscomp.next())
{
mTCODE=rscomp.getString("TESTCODE");

if(mTCODE.equals("CAT"))
	{

mCATYEAR=(rscomp.getString("YEAROFAPPEARING")==null)?"":rscomp.getString("YEAROFAPPEARING").trim();

	mCATCOMP=rscomp.getString("COMPOSITESCORE");
	mCATPER=rscomp.getString("PERCENTAGE");
	mCATDATE=rscomp.getString("RESULTVALIDUPTO");

	mCATDATE=(mCATDATE==null)?"":mCATDATE.trim();
	mCATPER=(mCATPER==null)?"":mCATPER.trim();
	mCATCOMP=(mCATCOMP==null)?"":mCATCOMP.trim();

	}
if(mTCODE.equals("MAT"))
	{

	mMATYEAR=(rscomp.getString("YEAROFAPPEARING")==null)?"":rscomp.getString("YEAROFAPPEARING").trim();
	mMATCOMP=rscomp.getString("COMPOSITESCORE");
	mMATPER=rscomp.getString("PERCENTAGE");
	mMATDATE=rscomp.getString("RESULTVALIDUPTO");

	mMATDATE=(mMATDATE==null)?"":mMATDATE.trim();
	mMATPER=(mMATPER==null)?"":mMATPER.trim();
	mMATCOMP=(mMATCOMP==null)?"":mMATCOMP.trim();

	}
	if(mTCODE.equals("GMAT"))
	{
		mGMATYEAR=(rscomp.getString("YEAROFAPPEARING")==null)?"":rscomp.getString("YEAROFAPPEARING").trim();


	mGMATCOMP=rscomp.getString("COMPOSITESCORE");
	mGMATPER=rscomp.getString("PERCENTAGE");
	mGMATDATE=rscomp.getString("RESULTVALIDUPTO");

	mGMATDATE=(mGMATDATE==null)?"":mGMATDATE.trim();
	mGMATPER=(mGMATPER==null)?"":mGMATPER.trim();
	mGMATCOMP=(mGMATCOMP==null)?"":mGMATCOMP.trim();
	}



if(mTCODE.equals("XAT"))
	{
		mXATYEAR=(rscomp.getString("YEAROFAPPEARING")==null)?"":rscomp.getString("YEAROFAPPEARING").trim();
	mXATCOMP=rscomp.getString("COMPOSITESCORE");
	mXATPER=rscomp.getString("PERCENTAGE");
	mXATDATE=rscomp.getString("RESULTVALIDUPTO");
	mXATDATE=(mXATDATE==null)?"":mXATDATE.trim();
	}
if(mTCODE.equals("ATMA"))
	{
		mATMAYEAR=(rscomp.getString("YEAROFAPPEARING")==null)?"":rscomp.getString("YEAROFAPPEARING").trim();
	mATMACOMP=rscomp.getString("COMPOSITESCORE");
	mATMAPER=rscomp.getString("PERCENTAGE");
	mATMADATE=rscomp.getString("RESULTVALIDUPTO");
	mATMADATE=(mATMADATE==null)?"":mATMADATE.trim();


	}



if(mTCODE.equals("OTHERS"))
	{
		mOTHYEAR=(rscomp.getString("YEAROFAPPEARING")==null)?"":rscomp.getString("YEAROFAPPEARING").trim();
	mOTHCOMP=rscomp.getString("COMPOSITESCORE");
	mOTHPER=rscomp.getString("PERCENTAGE");
	mOTHDATE=rscomp.getString("RESULTVALIDUPTO");
	mOTHDATE=(mOTHDATE==null)?"":mOTHDATE.trim();
	}



	 if(mTCODE.equals("CMAT"))
	{

		mCMATYEAR=(rscomp.getString("YEAROFAPPEARING")==null)?"":rscomp.getString("YEAROFAPPEARING").trim();
	mCMATCOMP=rscomp.getString("COMPOSITESCORE");
	mCMATPER=rscomp.getString("PERCENTAGE");
	mCMATDATE=rscomp.getString("RESULTVALIDUPTO");
	mCMATRANK=rscomp.getString("RANK");

	mCMATDATE=(mCMATDATE==null)?"":mCMATDATE.trim();
	mCMATPER=(mCMATPER==null)?"":mCMATPER.trim();
	mCMATCOMP=(mCMATCOMP==null)?"":mCMATCOMP.trim();
	}
}
%>
	<TR>
	<TD><font face='Verdana' size=2 >CAT</TD>


        <TD><font face='Verdana' size=2 ><%=mCATYEAR%> &nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mCATCOMP%> &nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mCATPER%>&nbsp;</FONT></TD>
	<TD><font face='Verdana' size=2 >&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mCATDATE%>&nbsp;</FONT></TD>
	</TR>

	<TR>
	<TD><font face='Verdana' size=2 >MAT</TD>
	<TD><font face='Verdana' size=2 ><%=mMATYEAR%> &nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mMATCOMP%>&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mMATPER%>&nbsp;</TD>
<TD><font face='Verdana' size=2 >&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mMATDATE%>&nbsp;</FONT></TD>
	</TR>

	<TR>
	<TD><font face='Verdana' size=2 >CMAT</TD>

	<TD><font face='Verdana' size=2 ><%=mCMATYEAR%> &nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mCMATCOMP%>&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mCMATPER%>&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mCMATRANK%>&nbsp;</TD>

	<TD><font face='Verdana' size=2 ><%=mCMATDATE%>&nbsp;</FONT></TD>
	</TR>

	<TR>
	<TD><font face='Verdana' size=2 >GMAT</TD>
	<TD><font face='Verdana' size=2 ><%=mGMATYEAR%> &nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mGMATCOMP%>&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mGMATPER%>&nbsp;</TD>
		<TD><font face='Verdana' size=2 >&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><%=mGMATDATE%>&nbsp;</FONT></TD>
	</TR>

<%


if(!mXATCOMP.equals(""))
		{
			%>


	<TR>
	<TD><font face='Verdana' size=2 ><b>XAT</b></TD>
	<TD><font face='Verdana' size=2 ><b><%=mXATYEAR%></b></TD>
	<TD><font face='Verdana' size=2 ><b><%=mXATCOMP%></b>&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><b><%=mXATPER%></b>&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><b></b>&nbsp;</FONT></TD>
	<TD><font face='Verdana' size=2 ><b><%=mXATDATE%></b>&nbsp;</FONT></TD>
	</TR>
<%
		}
if(!mATMACOMP.equals(""))
		{
			%>


	<TR>
	<TD><font face='Verdana' size=2 ><b>ATMA</b></TD>
	<TD><font face='Verdana' size=2 ><b><%=mATMAYEAR%></b></TD>
	<TD><font face='Verdana' size=2 ><b><%=mATMACOMP%></b>&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><b><%=mATMAPER%></b>&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><b></b>&nbsp;</FONT></TD>
	<TD><font face='Verdana' size=2 ><b><%=mATMADATE%></b>&nbsp;</FONT></TD>
	</TR>
<%
		}

if(!mOTHCOMP.equals(""))
		{
			%>


	<TR>
	<TD><font face='Verdana' size=2 ><b>OTHERS</b></TD>
	<TD><font face='Verdana' size=2 ><b><%=mOTHYEAR%></b></TD>
	<TD><font face='Verdana' size=2 ><b><%=mOTHCOMP%></b>&nbsp;</TD>
	<TD><font face='Verdana' size=2 ><b><%=mOTHPER%></b>&nbsp;</TD>
		<TD><font face='Verdana' size=2 ><b></b>&nbsp;</FONT></TD>
	<TD><font face='Verdana' size=2 ><b><%=mOTHDATE%></b>&nbsp;</FONT></TD>
	</TR>
<%
		}
	%>

</TABLE>






<BR>
 <FONT face=Verdana>14.Work Experience
<table BORDER=1 ALIGN=center>
<tr>

			<td><font face='Verdana' size=2 ><b>Postion</b></td>

			<td><font face='Verdana' size=2 ><b>Name of Organisation </b></td>
			<td><font face='Verdana' size=2 ><b>Job Profile</b></td>

			<td><font face='Verdana' size=2 ><b>Duration From</b></td>
			<td><font face='Verdana' size=2 ><b>Duration To</b></td>
</tr>
<%
qrycomp="SELECT APPLICATIONSLNO, EXPSLNO, COMPANYNAME,    DESIGNATION,to_char(nvl(WORKDATEFROM,SYSDATE),'dd-MM-yyyy')  WORKDATEFROM,to_char(nvl(WORKDATETO,SYSDATE),'dd-MM-yyyy')   WORKDATETO,    WORKINGAREA FROM   c#MBAAPPLICANTWORKEXP WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%' order by EXPSLNO";
rscomp=db.getRowset(qrycomp);

//out.println(qrycomp);
while(rscomp.next())
{
%>
<tr>

			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("DESIGNATION")%></b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("COMPANYNAME")%> </b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("WORKINGAREA")%></b></td>

			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("WORKDATEFROM")%></b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("WORKDATETO")%></b></td>
			</tr>
<%
}
%>
</table>



</td></tr>



<tr><td colspan=4>
<%
	String mCareer="",mCareerG="";


qry="SELECT APPLICATIONSLNO, OBJECTIVESLNO, CAREEROBJECTIVE,    JBSHELP FROM   c#MBAOBJECTIVE where APPLICATIONSLNO='"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
rs=db.getRowset(qry);
if(rs.next())
	{
		mCareer=rs.getString("CAREEROBJECTIVE");
		mCareerG=rs.getString("JBSHELP");

	}

	%>


<font face='Verdana' size=2 >
15.Describe how will the JBS MBA help you in achieving the above career goal ? <br>
&nbsp;&nbsp; <B><%=mCareerG%></B>

</td>
</tr>

</td>
</tr>
<tr><td><FONT face=Verdana>16.Bank Details: (Required in case of Refund) (ONLY PARENT/SELF)</td></tr><tr><td>
 <table BORDER=1 ALIGN=center>
<tr>

			<td><font face='Verdana' size=2 ><b>Name of Account Holder</b></td>
			<td><font face='Verdana' size=2 ><b>Bank Name </b></td>
			<td><font face='Verdana' size=2 ><b>Account Number</b></td>
			<td><font face='Verdana' size=2 ><b>Branch Name</b></td>
			<td><font face='Verdana' size=2 ><b>Address of Bank </b></td>
                        <td><font face='Verdana' size=2 ><b>IFSC Code </b></td>
</tr>
<%
qrycomp="SELECT  APPLICATIONSLNO,NAMEOFACHOLDER,BANKACCOUNTNO,NAMEOFBANK,BRANCHNAME,BANKADDRESS, IFSCCODE  FROM C#MBAPERSONALBANKDETAIL WHERE APPLICATIONSLNO='"+mApplicantSlno+"' ";
rscomp=db.getRowset(qrycomp);

//out.println(qrycomp);
while(rscomp.next())
{
%>
<tr>

			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("NAMEOFACHOLDER")%></b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("NAMEOFBANK")%></b></td>
                        <td><font face='Verdana' size=2 ><b><%=rscomp.getString("BANKACCOUNTNO")%></b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("BRANCHNAME")%></b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("BANKADDRESS")%></b></td>
                        <td><font face='Verdana' size=2 ><b><%=rscomp.getString("IFSCCODE")%></b></td>
			</tr>
<%
}
%>
 </table></td></tr>

<tr><td colspan=4>
<font face='Verdana' size=2 >
<!---satendra --->
17.GD/PI Center preferences
<TABLE BORDER=1 ALIGN=center>
<tr>

			<td><font face='Verdana' size=2 ><b>Choice</b></td>
                        <td width="20px"><font face='Verdana' size=2 ><b>Center</b></td>

</tr>
<%
qry="select locationname from C#MBALOCATIONPREFERENCE a, C#MBALOCATIONMASTER b where a.applicationslno='"+mApplicantSlno+"' and a.locationcode=b.locationcode order by preference";
rs=db.getRowset(qry);
 int a=0;
while(rs.next())
{
    a++;
%>
	<tr>

		<td><font face='Verdana' size=2 ><b><%=a%></b></td>
		<td width="20px"><font face='Verdana' size=2 ><b><%=rs.getString("locationname")%></b></td>


	</tr>


	<%
}

		%>
		</table>

<br>








<tr><td colspan=2>
<font face='Verdana' size=2 >
18. Documents Attached :  CheckSheet <br>
a) 10TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
<%=mDoc10%>
<br>
b) 12TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
<%=mDoc12%>
<br>
c) Graduation  :  &nbsp;  &nbsp;   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp;
<%=mDocGrad%>
<br>

d) Other    : &nbsp;  &nbsp;   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;     &nbsp;      &nbsp;  &nbsp; &nbsp;  &nbsp;
&nbsp;  &nbsp;   &nbsp;
<b><%=mDocOther%></b>
<br>

e) Score Card of CAT/MAT/GMAT :
&nbsp;  &nbsp;   &nbsp;    <%=mCheckScore%>
</font><br>
<%
if(!mDDNO.equals("") && !mDDAMT.equals("") && !mDDDATE.equals(""))
{
qryfee=" SELECT APPLICATIONSLNO, CHEQUEDDNO, to_char(CHEQUEDDDATE,'dd-mm-yyyy')CHQDATE,  CHQDDTYPE, nvl(AMOUNT,'')AMOUNT, nvl(BANKNAME,'')BANKNAME  FROM   c#MBAFEE where APPLICATIONSLNO='"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%'  ";
//out.print(qryfee);
//out.print(qryfee);
rs=db.getRowset(qryfee);

if(rs.next() )
 {
	%>
<tr>
<tr>
<td colspan=3>
<FONT face=Verdana>19. Application Fee -Demand Draft(DD) details:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
DD Number: <%=rs.getString("CHEQUEDDNO")%> &nbsp; &nbsp; &nbsp; DD Amount: <%=rs.getString("AMOUNT")%>&nbsp; &nbsp; &nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DD Date:<%=rs.getString("CHQDATE")%>	</font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT face=Verdana> Drawn on/Bank Name:<%=rs.getString("BANKNAME")%>&nbsp;
</FONT>
</td>
</tr>
<%}
}

else
{
	%>
<tr>
<tr>
<td colspan=3>
<FONT face=Verdana>19 . Purchased Form :  Rs. 1000/-
</FONT>
</td>
</tr>
<%
}

%>


</table>
<table align=center>
<tr><td align=center ><img src="../../Images/printer.gif"><INPUT id=button1 type=button value="Print" LANGUAGE=javascript onClick="window.print();" tabIndex=40></td></tr>
</table>
</form>
</BODY>
</HTML>
<%
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
	<h3>	<br><img src='../../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	</font>	<br>	<br>	<br>	<br>
   <%


   }
  //-----------------------------



}
else
{
	out.print("<br><img src='../../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
// out.print("aaaaaaaaaaaaa");
}
%>