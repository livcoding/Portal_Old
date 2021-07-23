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
ResultSet rsa=null;
DBHandler db=new DBHandler();
ResultSet rs=null,rsq=null;
String qrycomp="";
ResultSet rscomp=null;
String qry="",str1="",qryqua="";
String mValue="";
String mFName="",mMName="",mLName="",mSex="";
String mQYear="",mCategory="",mFatherName="",mMotherName="";
String mAIEEEROLL="",mADDRESS1="",mADDRESS2="",mADDRESS3="",mCITY="",mPIN="";
String mDISTRICT="",mPOSTOFFICE="",mRAILSTATION="",mPOLICESTATION="",mSTDCODE="",mPHONENO="";
String mMOBILE="",mSTATE="",memail="",mNationality="";
String mDDAMT="",mDDNO="";
String qrya="",qryc="",qryg="",qryx="",qry1="",qryt="";
String qryten="",qrytw="",qrygrd="",qryfee="";
String mBANK="",mchkDeclare="";
String mPer12="",mGradPer="",Appear="",DocScore="",mPer10="",mGradProg="",Doc10="",Doc12="",DocGrade="";
String XATCOMP="",XATPER="",GMATCOMP="",GMATPER="",CATCOMP="",CATPER="",MATCOMP="",MATPER="";
String mXATCOMP="",mXATPER="",mGMATCOMP="",mGMATPER="",mCATCOMP="",mCATPER="",mMATCOMP="",mMATPER="";
String mAPPSLNO="",mApplicantSlno="",mStr="",mApplicantName="",mapp="";
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mAppNo="",mCountry="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mDDDATE="",mDOB="",mIntAppNo="",mAppRadio="",mPurchRadio="";
String 	mQual="",mPerQual12="",mPerGrade="",mGradeProgr="",mAppearIn="",mTCODE="",mCheckScore="";
String mDoc10="No",mDoc12="No",mDocGrad="No";
String mOS="",mOther="",mScoreChk="",mAWT="",mDocOther="No";
int mMax=0,mFlag=0;


String TenYear="",	TenStream="10TH",TenBoard="",	TenPercent="";
String TewYear="",	TewStream="",TewBoard="",	TewPercent="";

String GradYear="",	GradStream="",GradBoard="",	GradPercent="";

String OtherYear="",	OtherStream="",OtherBoard="",	OtherPercent="",DocOther="";
String GMATDATE="",MATDATE="",CATDATE="";
String mGMATDATE="",mMATDATE="",mCATDATE="";

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
 
if (request.getParameter("FatherName")==null)
	mFatherName="";
else
 	mFatherName=request.getParameter("FatherName").toString().trim();
 
if (request.getParameter("MotherName")==null)
	mMotherName="";
else
 	mMotherName=request.getParameter("MotherName").toString().trim();
  
if (request.getParameter("AIEEEROLL")==null)
	mAIEEEROLL="";
else
 	mAIEEEROLL=request.getParameter("AIEEEROLL").toString().trim();

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


	if (request.getParameter("DDAMT")==null)
	mDDAMT="";
else
 	mDDAMT=request.getParameter("DDAMT").toString().trim();

if (request.getParameter("BANK")==null)
	mBANK="";
else
 	mBANK=request.getParameter("BANK").toString().trim();

if (request.getParameter("chkDeclare")==null)
	mchkDeclare="";
else
 	mchkDeclare=request.getParameter("chkDeclare").toString().trim();

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



if (request.getParameter("DocOther")==null)
	DocOther="N";
else
 	DocOther=request.getParameter("DocOther").toString().trim();



if (request.getParameter("DocScore")==null)
	DocScore="";
else
 	DocScore=request.getParameter("DocScore").toString().trim();


if (request.getParameter("TenYear")==null)
	TenYear="";
else
 	TenYear=request.getParameter("TenYear").toString().trim();


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
	Appear="";
else
 	Appear=request.getParameter("Appear").toString().trim();



if(request.getParameter("OS")==null)
 	mOS="N";
else
	mOS=request.getParameter("OS").toString().trim();

if(request.getParameter("Other")==null)
 	mOther="N";
else
	mOther=request.getParameter("Other").toString().trim();


if(request.getParameter("ScoreChk")==null)
 	mScoreChk="N";
else
	mScoreChk=request.getParameter("ScoreChk").toString().trim();



//if(request.getParameter("x")==null)
//	{
try
{


if((session.getAttribute("APPLICATIONSLNO")==null) || (session.getAttribute("APPLICATIONSLNO").equals("null")))
{
	qrya="SELECT NVL (MAX (TO_char (NVL (SUBSTR (APPLICATIONSLNO, -3), 0))), 0) cnt FROM c#mbaapplicationmaster WHERE APPLICATIONSLNO LIKE '2011MBAWE%' ";	

	//out.print(qrya);
	rsa=db.getRowset(qrya);
	if(rsa.next())
	{
		
		mMax=rsa.getInt("cnt")+1;
		//out.print(mMax+"asdsasda");
	}
	else
	{
		mMax=1;
		//out.print(mMax+"asdsasda");
	}

	if(!mFName.equals(""))
	{
		mAPPSLNO= "2011MBAWE" ;
		//out.print(mAPPSLNO+"slno");
	}
	for(int jk=1;jk<=3-String.valueOf(mMax).trim().length();jk++)
	{
		if (mStr.equals("-"))
			mStr="0";			
		else 
			mStr=mStr+"0";			
	}
	mApplicantSlno=mAPPSLNO+ mStr+mMax;
	
//out.print(mApplicantSlno+"slno");
//String mIntApplication="INT"+mIntAppNo;

qry="select 'Y' from C#MBAAPPLICATIONMASTER where APPLICATIONNO='"+mAppNo+"' AND APPLICATIONSLNO LIKE '2011MBAWE%'  and nvl(deactive,'N')='N'  ";
//out.print(qry);
rs=db.getRowset(qry);

if(!rs.next())
{
 
//*************Inserting Records in Master********************//

if(!mAppNo.equals(" ") )
{
qry="INSERT INTO C#MBAAPPLICATIONMASTER (APPLICATIONSLNO, APPLICATIONNO, STUDENTNAME, FATHERNAME, ";
qry=qry+" DATEOFBIRTH, CATEGORY,SEX, ENTRYBY, ENTRYDATE,   DEACTIVE, FLAG,NATIONALITY,CHECKSCORECARD,APPEARINGININST) VALUES ( ";
qry=qry+" '"+mApplicantSlno+"','"+mAppNo+"' ,'"+mFName+"'  ,'"+mFatherName+"' , ";
qry=qry+" to_date('"+mDOB+"','dd-mm-yyyy')  ,'"+mCategory+"' , '"+mSex+"','"+mChkMemID+"',Sysdate ,'N', 'N','"+mNationality+"','"+DocScore+"','"+Appear+"')";
//out.print(qry);
int n=db.insertRow(qry);
	if(n>0)
	 {
		mFlag=1;
	  out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'> Record Saved !!!  <br>");
	 }
	 else
	 {
		 mFlag=2;
	 }
}



//*************Inserting Records in Address********************//
if(mFlag==1)
{
qry1="INSERT INTO C#MBAAPPLICANTADD (APPLICATIONSLNO, ADDRESS1, ADDRESS2,  CITY, STATE, PIN,  COUNTRY, PHONE, EMAILID,  ENTRYBY, ENTRYDATE, DEACTIVE) VALUES ( '"+mApplicantSlno+"','"+mADDRESS1+"' ,'"+mADDRESS2+"' ,'"+mCITY+"'    ,'"+mSTATE+"' , '"+mPIN+"',  '"+mCountry+"'  , '"+mMOBILE+"', '"+memail+"',  '"+mChkMemID+"'  ,  sysdate , 'N')";

int m=db.insertRow(qry1);

if(m>0)
	 {
	//	mFlag=1;
	//out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'> Record Inserted !!!  <br>");
	 }

session.setAttribute("APPLICATIONSLNO",mApplicantSlno);

//*************Inserting Records in Score********************//
String WORKDATETO="",COMPANY="",AREA="",DESIGNATION="",WORKDATEFROM="";


for(int yy=1;yy<=3;yy++)
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

		if(!COMPANY.equals("N"))
		{
			//	qry="SELECT 'Y' FROM C#MBAAPPLICANTWORKEXP where APPLICATIONSLNO='"+mApplicantSlno+"'";
			//	rs=db.getRowset(qry);
			//	if(!rs.next())
			//	{
					String qryexp="INSERT INTO C#MBAAPPLICANTWORKEXP (APPLICATIONSLNO, EXPSLNO, COMPANYNAME,    DESIGNATION, WORKDATEFROM, WORKDATETO,    WORKINGAREA, DEACTIVE) VALUES ('"+mApplicantSlno+"' ,"+yy+" ,'"+COMPANY+"' , '"+DESIGNATION+"' ,  to_date('"+WORKDATEFROM+"','dd-mm-yyyy')  , to_date('"+WORKDATETO+"','dd-mm-yyyy')  , '"+AREA+"'    ,'N' )";
//					out.print(qryexp);
			int exp=db.insertRow(qryexp);

			
				
			
		}

		

	}



if(!mDDNO.equals("") && !mDDAMT.equals("") && !mDDDATE.equals(""))
	{
	qryfee="INSERT INTO C#MBAFEE (   APPLICATIONSLNO, CHEQUEDDNO,  CHEQUEDDDATE, CHQDDTYPE, AMOUNT,    BANKNAME) VALUES ('"+mApplicantSlno+"' ,'"+mDDNO+"' , to_date('"+mDDDATE+"','dd-mm-yyyy')   ,'D' ,'"+mDDAMT+"' , '"+mBANK+"')";
	}
	else 
	{
		mDDAMT="1200";
	qryfee="INSERT INTO C#MBAFEE (   APPLICATIONSLNO,  CHEQUEDDNO,  CHEQUEDDDATE, CHQDDTYPE, AMOUNT,    BANKNAME) VALUES ('"+mApplicantSlno+"',' ' , to_date('"+mDDDATE+"','dd-mm-yyyy'),'P','"+mDDAMT+"' , '')";
//out.print(qryfee);
	}
	int d=db.insertRow(qryfee);



}
else if(mFlag==2)
{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error While Inserting <br>");
}
}
else
{
out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Record Already Exists <br>");
}




if(!TenYear.equals(""))
	{
	qryten="INSERT INTO C#QUALIFICATION (  APPLICATIONSLNO, QUALIFICATIONCODE, QUALIFICATIONDESC, PERCENTAGE,DOCUMENT,BOARD, PASSINGYEAR, STREAM) VALUES ('"+mApplicantSlno+"' ,'10TH' ,'TENTH' , '"+TenPercent+"','"+Doc10+"','"+TenBoard+"','"+TenYear+"','"+TenStream+"')";
		int ten=db.insertRow(qryten);
	//out.print(qryten);
	}
if(!TewYear.equals("") )
	{
		qrytw="INSERT INTO C#QUALIFICATION (   APPLICATIONSLNO, QUALIFICATIONCODE, QUALIFICATIONDESC, PERCENTAGE,DOCUMENT ,BOARD, PASSINGYEAR, STREAM) VALUES ( '"+mApplicantSlno+"','12TH' ,'TWELFTH' , '"+TewPercent+"','"+Doc12+"','"+TewBoard+"','"+TewYear+"','"+TewStream+"')";
		int tw=db.insertRow(qrytw);
	}
if(!GradYear.equals(""))
	{
		
		qrygrd="INSERT INTO C#QUALIFICATION (   APPLICATIONSLNO, QUALIFICATIONCODE, QUALIFICATIONDESC, PERCENTAGE,DOCUMENT,BOARD, PASSINGYEAR, STREAM) VALUES ('"+mApplicantSlno+"' ,'GRAD' ,'GRADUATION' , '"+GradPercent+"','"+DocGrade+"','"+GradBoard+"','"+GradYear+"','"+GradStream+"')";
							
		int grd=db.insertRow(qrygrd);

	}
		
if(!OtherYear.equals("")  )
	{
			String qryawt="INSERT INTO C#QUALIFICATION (   APPLICATIONSLNO, QUALIFICATIONCODE, QUALIFICATIONDESC, PERCENTAGE,DOCUMENT,BOARD, PASSINGYEAR, STREAM) VALUES ('"+mApplicantSlno+"' ,'OTHER' ,'OTHER' , '"+OtherPercent+"','"+DocOther+"','"+OtherBoard+"','"+OtherYear+"','"+OtherStream+"')";
			int awt=db.insertRow(qryawt);
	}

//}
}// closing of session 
else
{
	mApplicantSlno=session.getAttribute("APPLICATIONSLNO").toString().trim();
	
}
}
catch(Exception e)
{
	//out.print(e.getMessage());
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Jaypee Institute of Information Technology</title>
</head>
<BODY bgcolor="lightyellow"  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  >
<form name=frm >
<INPUT TYPE="hidden" NAME="x" id="x">
 <table  border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups borderColor=black>
<tr><td ALIGN=middle>
<FONT face=Verdana size=3 color=brown size=4><STRONG><U>JAYPEE INSTITUTE OF INFORMATION TECHNOLOGY   <br>Jaypee Business School</U></STRONG></FONT>
<BR>
<FONT face=Verdana size=1>(Declared Deemed to be University u/s 3 of the UGC Act,1956)</FONT>
</td></tr>
<tr><td ALIGN=middle>
<STRONG><FONT face=Verdana size=4>MBA APPLICATION FORM - 2011 </FONT><br><FONT size=2>(For Working Executives)</FONT></STRONG>
<BR>
</td></tr>
</table>
<%

//mApplicantSlno=session.getAttribute("APPLICATIONSLNO").toString().trim();

qry="SELECT a.applicationslno, a.applicationno, a.studentname, a.fathername,to_char(nvl(A.DATEOFBIRTH,SYSDATE),'dd-MM-yyyy') DOB,      decode(a.CATEGORY,'GEN','General','SC','SC','ST','ST','OBC','OBC')CATEGORY,       DECODE(a.sex,'F','Female','M','Male')SEX, nvl(a.nationality, '')nationality, decode(a.checkscorecard,'Y','Yes','N','No','No')checkscorecard, decode(a.APPEARINGININST,'Y','Yes','N','No','No')APPEARINGININST, nvl(b.ADDRESS1,' ')ADDRESS1, nvl(b.ADDRESS2,' ')ADDRESS2, nvl(b.CITY,' ')CITY, nvl(b.STATE,' ')STATE, nvl(b.PIN, ' ')PIN, nvl(b.COUNTRY,' ')COUNTRY, nvl(b.PHONE,' ')PHONE, nvl(b.EMAILID,' ')EMAILID FROM c#mbaapplicationmaster a,C#MBAAPPLICANTADD b WHERE a.applicationslno = '"+mApplicantSlno+"'  and a.APPLICATIONSLNO=b.APPLICATIONSLNO";

/*qry="SELECT APPLICATIONSLNO, APPLICATIONNO, STUDENTNAME, FATHERNAME, trunc(to_date(DATEOFBIRTH,'dd-mm-rrrr'))DOB, CATEGORY,   SEX,NATIONALITY,  CHECKSCORECARD, APPEARINGININST FROM C#MBAAPPLICATIONMASTER where APPLICATIONSLNO='"+mApplicantSlno+"' " ;*/
//out.print(qry);
rs=db.getRowset(qry);

if(rs.next())
{

mAppearIn=rs.getString("APPEARINGININST");
mCheckScore=rs.getString("checkscorecard");
%>
<table width="98%" border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small" valign="middle" align=center rules=groups>
<tr>
<td> <FONT face=Verdana COLOR=BLUE SIZE=3><b>Application Slno : <%=rs.getString("APPLICATIONSLNO")%> </b></font></td>
<td> <FONT face=Verdana COLOR=BLUE SIZE=3><b>Application No : <%=rs.getString("applicationno")%> </b></font></td>
</TR>
<TR>
<td colspan=3><FONT face=Verdana>1. Name of Candidate (IN CAPITAL LETTERS) <b><%=rs.getString("STUDENTNAME")%></b></FONT> 
</td></tr>
<tr><td colspan=3 align=left><FONT face=Verdana> 2. Father's Name :&nbsp;&nbsp;&nbsp;<b><%=rs.getString("FATHERNAME")%></b> </FONT></td></tr>
<tr><td><FONT face=Verdana>3. Gender :<b>
<%=rs.getString("SEX")%>       
</b>
</FONT>
</td>
<td><FONT face=Verdana>4. Date of Birth : &nbsp;&nbsp;<b><%=rs.getString("DOB")%></b></FONT><br>         
</td></tr>
<tr><td colspan=3><FONT face=Verdana>5. Category : <b><%=rs.getString("CATEGORY")%></b></FONT></td></tr>
<tr><td colspan=3><FONT face=Verdana size=2>6. Contact Address of the Candidate(IN CAPITAL LETTERS)
<br>&nbsp; &nbsp; &nbsp; &nbsp;<b><%=rs.getString("ADDRESS1")%></b>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><%=rs.getString("ADDRESS2")%></b></FONT>
<br>&nbsp; &nbsp; &nbsp; &nbsp;<FONT face=Verdana size=2>City :<b> <%=rs.getString("CITY")%> </b> </FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;<FONT face=Verdana size=2>PIN: <b><%=rs.getString("PIN")%></b></FONT>
<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<FONT face=Verdana size=2>Country : 
<b><%=rs.getString("COUNTRY")%></b></FONT>&nbsp;&nbsp; &nbsp;&nbsp;<FONT face=Verdana size=2>State : 
<b><%=rs.getString("STATE")%></B></FONT>&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Verdana size=2>PhoneNo or Moblie No : <b><%=rs.getString("PHONE")%></b></font>
</FONT>
</td>
</tr>
<tr>
<td colspan=3>
<FONT face=Verdana> 7. Email Address (if any) :&nbsp; <b><%=rs.getString("EMAILID")%></B>
</FONT>   
</td>
</tr>

<tr>
<td colspan=3><FONT face=Verdana>8. Nationality :&nbsp;<b><%=rs.getString("NATIONALITY")%></b>

</FONT>       
</td>
</tr>
<%
	qryqua="SELECT distinct QUALIFICATIONCODE, QUALIFICATIONDESC,PERCENTAGE, decode(DOCUMENT,'Y','Yes','N','No','No')DOCUMENT FROM C#QUALIFICATION WHERE APPLICATIONSLNO='"+mApplicantSlno+"' " ;
//out.print(qryqua);AND QUALIFICATIONCODE<>'10TH' "
	rsq=db.getRowset(qryqua);
	//out.print(qryqua);
	while(rsq.next())
    {
		mQual=rsq.getString("QUALIFICATIONCODE").toString().trim();
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
qry="SELECT  nvl(QUALIFICATIONCODE,' ')QUALIFICATIONCODE, nvl(QUALIFICATIONDESC,' ')QUALIFICATIONDESC, PERCENTAGE, nvl(DOCUMENT,' ')DOCUMENT, nvl(BOARD,' ')BOARD,PASSINGYEAR, nvl(STREAM,' ')STREAM from C#QUALIFICATION where APPLICATIONSLNO='"+mApplicantSlno+"'";
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

 <FONT face=Verdana>10.Work Experience
<TABLE BORDER=1 ALIGN=center>
<tr>
<td><font face='Verdana' size=2 ><b>Company </b></td>
			<td><font face='Verdana' size=2 ><b>Area</b></td>
			<td><font face='Verdana' size=2 ><b>Postion/Designation</b></td>
			<td><font face='Verdana' size=2 ><b>Duration From</b></td>
			<td><font face='Verdana' size=2 ><b>Duration To</b></td>
</tr>
<%
qrycomp="SELECT APPLICATIONSLNO, EXPSLNO, COMPANYNAME,    DESIGNATION,to_char(nvl(WORKDATEFROM,SYSDATE),'dd-MM-yyyy')  WORKDATEFROM,to_char(nvl(WORKDATETO,SYSDATE),'dd-MM-yyyy')   WORKDATETO,    WORKINGAREA FROM C#MBAAPPLICANTWORKEXP WHERE APPLICATIONSLNO='"+mApplicantSlno+"' order by EXPSLNO";
rscomp=db.getRowset(qrycomp);

//out.println(qrycomp);
while(rscomp.next())
{
%>
<tr>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("COMPANYNAME")%> </b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("WORKINGAREA")%></b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("DESIGNATION")%></b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("WORKDATEFROM")%></b></td>
			<td><font face='Verdana' size=2 ><b><%=rscomp.getString("WORKDATETO")%></b></td>
			</tr>
<%
}
%>
</TABLE>
</td></TR>
<tr><td colspan=2>
<font face='Verdana' size=2 >
11. Documents Attached :  CheckSheet <br>
a) 10TH   &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
:<b><%=mDoc10%></b>
<br>
b) 12TH  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
:<b><%=mDoc12%></b>
<br>
c) Graduation  &nbsp;  &nbsp;   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp;
:<b><%=mDocGrad%></b>
<br>
d) Other     &nbsp;  &nbsp;   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;     &nbsp;      &nbsp;  &nbsp; &nbsp;  &nbsp;
&nbsp;  &nbsp;     &nbsp;
:<b><%=mDocOther%></b>
<br>

</font><br>
<%
if(!mDDNO.equals("") && !mDDAMT.equals("") && !mDDDATE.equals(""))
{
qryfee=" SELECT APPLICATIONSLNO, nvl(CHEQUEDDNO,' ')CHEQUEDDNO,to_char(nvl(CHEQUEDDDATE,SYSDATE),'dd-MM-yyyy')CHQDATE,CHQDDTYPE, nvl(AMOUNT,'')AMOUNT, nvl(BANKNAME,' ')BANKNAME  FROM C#MBAFEE where APPLICATIONSLNO='"+mApplicantSlno+"'  ";
rs=db.getRowset(qryfee);

if(rs.next())
 {
	%>
<tr>
<tr>
<td colspan=3>
<FONT face=Verdana>12. Application Fee -Demand Draft(DD) details:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
DD Number :<b> <%=rs.getString("CHEQUEDDNO")%></b> &nbsp; &nbsp; &nbsp; DD Amount: <b><%=rs.getString("AMOUNT")%></b>&nbsp; &nbsp; &nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DD Date:<b><%=rs.getString("CHQDATE")%></b>	</font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT face=Verdana> Drawn on/Bank Name:<b><%=rs.getString("BANKNAME")%></b>&nbsp;
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
<FONT face=Verdana>12. Purchased Form :  <b>Rs. 1200/-</b>
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