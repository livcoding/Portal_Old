 <%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %>
<!-- Modified Date 15-06-2020 -->
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
qry="select 'Y' from    c#BBAAPPLICATIONMASTER where APPLICATIONSLNO='"+mApplicantSlno+"' " +
        "and nvl(deactive,'N')='N'  and  APPLICATIONSLNO like '"+mAppYear+"%'  ";
//
rs=db.getRowset(qry);
//out.print(qry);
if(rs.next())
{

//*************Inserting Records in Master********************//
//out.print(mCategory);

qry="UPDATE    C#BBAAPPLICATIONMASTER SET  APPLICATIONNO = '"+mAppNo+"',STUDENTNAME= '"+mFName+"',FATHERNAME = '"+mFatherName+"', DATEOFBIRTH =to_date('"+mDOB+"','dd-mm-yyyy') ,CATEGORY ='"+mCategory+"' , SEX = '"+mSex+"',ENTRYBY ='"+mChkMemID+"' ,ENTRYDATE =Sysdate  ,NATIONALITY  ='"+mNationality+"'  WHERE  APPLICATIONSLNO ='"+mApplicantSlno+"' ";


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

qry="select 'Y' from    C#BBAAPPLICANTADDRESS where APPLICATIONSLNO='"+mApplicantSlno+"' and nvl(deactive,'N')='N' and  APPLICATIONSLNO like '"+mAppYear+"%'  ";

rs=db.getRowset(qry);

if(rs.next())
{

qry1="UPDATE    C#BBAAPPLICANTADDRESS SET   ADDRESS1='"+mADDRESS1+"' , ADDRESS2='"+mADDRESS2+"' ,CITY = '"+mCITY+"' ,STATE = '"+mSTATE+"' , PIN  ='"+mPIN+"' , COUNTRY ='"+mCountry+"',PHONE='"+mMOBILE+"' ,EMAILID ='"+memail+"' , ENTRYBY ='"+mChkMemID+"' , ENTRYDATE =sysdate  WHERE  APPLICATIONSLNO='"+mApplicantSlno+"' and  nvl(DEACTIVE,'N')='N' ";

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

qry1="INSERT INTO    C#BBAAPPLICANTADDRESS (APPLICATIONSLNO, ADDRESS1, ADDRESS2,  CITY, STATE, PIN,  COUNTRY, PHONE, EMAILID,  ENTRYBY, ENTRYDATE, DEACTIVE) VALUES ( '"+mApplicantSlno+"','"+mADDRESS1+"' ,'"+mADDRESS2+"' ,'"+mCITY+"'    ,'"+mSTATE+"' , '"+mPIN+"',  '"+mCountry+"'  , '"+mMOBILE+"', '"+memail+"',  '"+mChkMemID+"'  ,  sysdate , 'N')";

int x=db.insertRow(qry1);

if(x>0)
	 {
	//	mFlag=1;
	//out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'> Record Inserted !!!  <br>");
	 }


	}




//------------------------------------work experience


String WORKDATETO="",COMPANY="N",AREA="",DESIGNATION="",WORKDATEFROM="";
String qryexp="";
int exp=0;
//int  totalexp=Integer.parseInt(request.getParameter("totalexp"));



//------------------------------------




//----------carreer goal


if( !mDDNO.equals("") &&  !mDDAMT.equals("") )
	{

qryfee="UPDATE    c#BBAFEE SET  CHEQUEDDNO = '"+mDDNO+"',  CHEQUEDDDATE= to_date('"+mDDDATE+"','dd-mm-yyyy'), CHQDDTYPE = 'D',AMOUNT= '"+mDDAMT+"',BANKNAME='"+mBANK+"'  WHERE  APPLICATIONSLNO = '"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
	}
	else
	{
qryfee="UPDATE    c#BBAFEE SET  CHQDDTYPE = 'P',AMOUNT= '"+mPurchAmt+"' WHERE  APPLICATIONSLNO= '"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";

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
qryup="SELECT 'Y' FROM    C#BBAQUALIFICATION where APPLICATIONSLNO = '"+mApplicantSlno+"' AND QUALIFICATIONCODE ='"+m10TH+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";

rsup=db.getRowset(qryup);

if(rsup.next())
{
	if(m10TH.equals("10TH"))
	{
	qryten="UPDATE    C#BBAQUALIFICATION SET   PERCENTAGE ='"+TenPercent+"', BOARD='"+TenBoard+"', PASSING_YEAR='"+TenYear+"' ,DOCUMENT ='"+Doc10+"'  WHERE  APPLICATIONSLNO='"+mApplicantSlno+"' AND QUALIFICATIONCODE ='"+m10TH+"' ";
	int ten=db.update(qryten);
	}
}
else
{
	if(  !TenPercent.equals("") && m10TH.equals("10TH"))
	{
	qry10="insert into     C#BBAQUALIFICATION   (APPLICATIONSLNO,QUALIFICATIONCODE,QUALIFICATIONDESC,PERCENTAGE,BOARD,PASSINGYEAR,DOCUMENT ) values ('"+mApplicantSlno+"','"+m10TH+"','TENTH' ,'"+TenPercent+"','"+TenBoard+"','"+TenYear+"','"+Doc10+"')";
	int rs10=db.insertRow(qry10);
	}
}


/******12th update and insert */
qrytwel="SELECT 'Y' FROM    C#BBAQUALIFICATION where APPLICATIONSLNO = '"+mApplicantSlno+"'  AND QUALIFICATIONCODE ='"+m12TH+"' and  APPLICATIONSLNO like '"+mAppYear+"%' ";
rstwel=db.getRowset(qrytwel);
if(rstwel.next())
{


if(m12TH.equals("12TH")  )
	{
	qrytw="UPDATE    C#BBAQUALIFICATION SET   PERCENTAGE ='"+TewPercent+"', BOARD='"+TewBoard+"', PASSING_YEAR='"+TewYear+"', SUBJECTS='"+TewStream+"'  ,DOCUMENT ='"+Doc12+"'  WHERE  APPLICATIONSLNO='"+mApplicantSlno+"' AND QUALIFICATIONCODE ='"+m12TH+"' ";
	int tw=db.update(qrytw);
	}
}
else
{
	if(  !TewPercent.equals("") && m12TH.equals("12TH"))
	{
	qry12="insert into     C#BBAQUALIFICATION   (APPLICATIONSLNO,QUALIFICATIONCODE,QUALIFICATIONDESC,PERCENTAGE,BOARD,PASSING_YEAR,SUBJECTS,DOCUMENT ) values ('"+mApplicantSlno+"','"+m12TH+"','TWELFTH' ,'"+mPer12+"','"+TewBoard+"','"+TewYear+"','"+TewStream+"','"+Doc12+"')";

	int rs12=db.insertRow(qry12);
	}
}


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
<STRONG><FONT face=Verdana size=4>BBA APPLICATION FORM - <%=mAppYear%> </FONT><br><FONT size=2>(Do not submit without copy of  CAT/MAT/CMAT/GMAT/XAT/ATMA score card)</FONT></STRONG>
<BR>
</td></tr>
</table>
<%
qry="SELECT a.applicationslno, a.applicationno, a.studentname, a.fathername,   " +
        "    TRUNC (TO_DATE (a.dateofbirth, 'dd-mm-rrrr')) dob,     " +
        " decode(a.CATEGORY,'GN','General','SC','SC','ST','ST','OBC','OBC',a.CATEGORY)CATEGORY,    " +
        "   DECODE(a.sex,'F','Female','M','Male')SEX, nvl(a.nationality, '')nationality," +
        //" decode(a.checkscorecard,'Y','Yes','N','No','No')checkscorecard, " +
        //"decode(a.APPEARINGININST,'Y','Yes','N','No','No')appearingininst, " +
        "nvl(b.ADDRESS1,' ')ADDRESS1, nvl(b.ADDRESS2,' ')ADDRESS2, nvl(b.CITY,' ')CITY, " +
        "nvl(b.STATE,' ')STATE, nvl(b.PIN, ' ')PIN, nvl(b.COUNTRY,' ')COUNTRY, nvl(b.PHONE,' ')PHONE, " +
        "nvl(b.EMAILID,' ')EMAILID FROM   C#BBAAPPLICATIONMASTER a,  C#BBAAPPLICANTADDRESS b " +
        "WHERE a.applicationslno = '"+mApplicantSlno+"'  and a.APPLICATIONSLNO=b.APPLICATIONSLNO and " +
        " a.APPLICATIONSLNO like '"+mAppYear+"%'";

//out.print(qry);
rs=db.getRowset(qry);

if(rs.next())
{
//mVenueqry=rs.getString("VENUECHOICE")==null?"":rs.getString("VENUECHOICE").toString();
//mAppearIn=rs.getString("APPEARINGININST")==null?"":rs.getString("APPEARINGININST").toString();
//mCheckScore=rs.getString("checkscorecard")==null?"":rs.getString("checkscorecard").toString();

%>
<table width="98%" border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small" valign="middle" align=center rules=groups>
<tr>
<td> <FONT face=Verdana color="blue" size=2><b>Application Slno : <%=rs.getString("APPLICATIONSLNO")%> </b></font></td>
</TR>
<TR>
<td colspan=3><FONT face=Verdana>1. Name of Candidate (IN CAPITAL LETTERS) <%=rs.getString("STUDENTNAME")%></FONT>
</td></tr>
<tr><td colspan=3 align=left><FONT face=Verdana> 2. Father's Name :&nbsp;&nbsp;&nbsp;<%=rs.getString("FATHERNAME")%> </FONT></td></tr>
<tr><td><FONT face=Verdana>3. Gender :
<%=rs.getString("SEX")%>
</FONT>
</td>
<td><FONT face=Verdana>4. Date of Birth : &nbsp;&nbsp;<%=mDOB%></FONT><br>
</td></tr>
<tr><td colspan=3><FONT face=Verdana>5. Category:<%=rs.getString("CATEGORY")==null?"":rs.getString("CATEGORY").trim()%></FONT></td></tr>
<tr><td colspan=3><FONT face=Verdana size=2>6. Contact Address of the Candidate(IN CAPITAL LETTERS)
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
<FONT face=Verdana> 7. Email Address (if any):&nbsp; <%=rs.getString("EMAILID")%>
</FONT>
</td>
</tr>

<tr>
<td colspan=3><FONT face=Verdana>8. Nationality:  &nbsp;<%=rs.getString("NATIONALITY")%>
</FONT>
</td>
</tr>

<%

	qryqua="SELECT distinct QUALIFICATIONCODE, QUALIFICATIONDESC,PERCENTAGE,decode(DOCUMENT,'Y','Yes','N','No',' ','No')DOCUMENT FROM   C#bbaqualification WHERE APPLICATIONSLNO='"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%'  ";
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
<td colspan=3 align=left><FONT face=Verdana>9. Current Qualification
<TABLE BORDER=1 ALIGN=center>
<tr>

			<td><font face='Verdana' size=2 ><b>Year of Completion</b></td>
			<td><font face='Verdana' size=2 ><b>Stream </b></td>
			<td><font face='Verdana' size=2 ><b>Board / University</b></td>
			<td><font face='Verdana' size=2 ><b>% of Marks</b></td>
</tr>
<%
qry="SELECT distinct  nvl(PASSING_YEAR,' ')PASSING_YEAR, nvl(SUBJECTS,' ')SUBJECTS, nvl(BOARD,' ')BOARD, PERCENTAGE from   C#bbaqualification where APPLICATIONSLNO='"+mApplicantSlno+"' and  APPLICATIONSLNO like '"+mAppYear+"%' order by PASSING_YEAR desc ";
rs=db.getRowset(qry);
while(rs.next())
{
%>
	<tr>

		<td><font face='Verdana' size=2 ><b><%=rs.getString("PASSING_YEAR")%></b></td>
		<td><font face='Verdana' size=2 ><b><%=rs.getString("SUBJECTS")%></b></td>
		<td><font face='Verdana' size=2 ><b><%=rs.getString("BOARD")%></b></td>
		<td><font face='Verdana' size=2 ><b><%=rs.getDouble("PERCENTAGE")%></b></td>

	</tr>


	<%
}

		%>
		</table>

<br>


<BR>

</td></TR>





</td>
</tr>
<tr><td colspan=4>
<font face='Verdana' size=2 >
<!---satendra --->


<br>








<tr><td colspan=2>
<font face='Verdana' size=2 >
14. Documents Attached :  CheckSheet <br>
a) 10TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
<%=mDoc10%>
<br>
b) 12TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
<%=mDoc12%>
<br>


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
<FONT face=Verdana>15. Application Fee -Demand Draft(DD) details:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
<FONT face=Verdana>15. Purchased Form :  Rs. 1000/-
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