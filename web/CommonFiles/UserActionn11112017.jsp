<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.net.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%


String mHead="";
OLTEncryption enc=new OLTEncryption();

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Signin Action ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<Script language="Javascript">
function LoadPageS(mWidth, mHeight)
{
var params = "location=no,status=no,toolbar=no,menubar=no,scrollbars=no,resizable=yes,width="+mWidth+",height="+mHeight+",left=0,top=0,resizable=no";
window.opener = top;
window.close();
window.open("../StudentFiles/StudentPage.jsp", "", params);
}
function LoadPageE(mWidth,mHeight)
{
var params = "location=no,status=no,toolbar=no,menubar=no,scrollbars=no,resizable=yes,width="+mWidth+",height="+mHeight+",left=0,top=0,resizable=no";
window.opener = top;
window.close();
window.open("../EmployeeFiles/EmployeePage.jsp", "", params);
}

</script>

</head>
<BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=no>
<%
String FreezeStatus="";
ResultSet Bnkdtl=null;
String UniqueID="";
String qrybankdetails="";
String mMemberType="", mOlldPWD="",qryenroll="";
String mCode="";
String mIPADDRESS="";
String mMACAddress ="";
String mPass="";
String mType="";
String mcode="";
String mpass="";
String mEPass="";
String mEMemberType="";
String mECode="";
String mEId="";
String MemberID="";
String MemberType="";
String MemberCode="";
String MemberName="";
String mId="",mComp1="",mComp2="";
String mDID="";
String qry="";
String mDeac="";
String mMname="";
String mDescode="";
String mParentCompCode="";
String mDesg="";
String mNickname="";
String mDept="";
String mAcadmeicYear="";
String mProgram="";
String mBranchCode="";
String mSemester="";
String mStudentName="";
String mInst="",mInstPersonal="",mCompPersonal="";
String mRole="",mFirst="";
String mComp="";//mcmpcode="";
String ipAddress="",Today="";
String ISP="",lisp="",mEisp="";
String mBASEADMINPWD="",mDeactive="",mInstitute="";
int MAXHINT =0;

		String mMinPass="", mMaxPass="",mMinSRS="",mWebEmail="",mStudDefPWD="",mEmpDefPWD="";
		double mLoginlimit=0;
		double mFla	=0;


ResultSet rs=null,rs5=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet rs11=null;
ResultSet rs4=null;
DBHandler db=new DBHandler();

//-------------------------------------
//-------Session with blank------------
//-------------------------------------
session.setAttribute("MemberID","");
session.setAttribute("MemberType","");
session.setAttribute("IspMemberType","");
session.setAttribute("MemberCode","");
session.setAttribute("MemberName","");
session.setAttribute("SRSEVENTCODE","");
session.setAttribute("ROLENAME","");
session.setAttribute("MinPasswordLength","");
session.setAttribute("MaxPasswordLength","");
session.setAttribute("MinSRSCount","");
session.setAttribute("WebAdminEmail","");
session.setAttribute("LogEntryMemberID","");
session.setAttribute("LogEntryMemberType","");
session.setAttribute("securityval","");
//-------------------------------------
//-------Session with blank------------
//-------------------------------------

if (request.getParameter("InstCode")==null)
{
	mInst="";
}
else
{
	mInst=request.getParameter("InstCode").toString().trim();
}

if (request.getParameter("UserType101117")==null)
{
	mMemberType="";
}
else
{
        lisp=request.getParameter("UserType101117").toString().trim();
        ISP=request.getParameter("UserType101117").toString().trim();
        if(ISP.equalsIgnoreCase("P")){
	mMemberType="S";

        }else{
            mMemberType=request.getParameter("UserType101117").toString().trim();
        }

    session.setAttribute("emptypemsg",mMemberType);
}

if(request.getParameter("MemberCode")==null)
{
	mCode="";
}
else
{
	mCode=request.getParameter("MemberCode").toString().trim();
}

if(request.getParameter("Password101117")==null)
{
	mPass="";
	mOlldPWD="";
}
else
{
	mPass=request.getParameter("Password101117").toString().trim().toUpperCase();
	mOlldPWD=request.getParameter("Password101117").toString().trim().toUpperCase();
}



  if (mMemberType.trim().equals("S")) {
            qryenroll = "select distinct  nvl(institutecode,'') institutecode  from studentmaster where nvl(enrollmentno,'')='" + mCode + "' " +
                    "and institutecode='"+mInst+"'  and nvl(deactive,'N')='N' ";

            rs5 = db.getRowset(qryenroll);
            if (rs5.next()) {
                mInstitute = rs5.getString("institutecode") == null ? "" : rs5.getString("institutecode").trim();
            }
        } else {
            mInstitute = mInst;
        }
        if (!mInstitute.equals(mInst)) {
            out.print("<br><img src='../Images/Error1.jpg'  >");
            out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>Please give the correct Institute name and Enrollment No. !!</b></font> ");
            out.print("<p><a href=../index.jsp><img src=../Images/Back.jpg border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
        } else {

// Password101117
/*
int mValidPwd1=0,mValidPwd2=0,mValidPwd3=0;

//out.print("mValidPwd1::"+mValidPwd1+"::mValidPwd2::"+mValidPwd2+"::mValidPwd3::"+mValidPwd3+"LLLLL"+mPass.length());
if(mPass.length() >=8)
{
for(int ii=0;ii<mPass.length();ii++)
	{

		if ( (mPass.charAt(ii)>=65 && mPass.charAt(ii)<=90) || (mPass.charAt(ii)>=97 && mPass.charAt(ii)<=122))
		{
		  mValidPwd1=1;
		}


		if (mPass.charAt(ii)>=48 && mPass.charAt(ii)<=57)
		{
		  mValidPwd2=1;
		}

		if ( (mPass.charAt(ii)>32 && mPass.charAt(ii)<47)   && !(mPass.charAt(ii)>=65 && mPass.charAt(ii)<=90)  && !(mPass.charAt(ii)>=97 && mPass.charAt(ii)<=122) )
		{
			mValidPwd3=1;

		}

	}


}
else
{
mValidPwd1=0;mValidPwd2=0;mValidPwd3=0;
}
*/
//out.print("mValidPwd1::"+mValidPwd1+"::mValidPwd2::"+mValidPwd2+"::mValidPwd3::"+mValidPwd3+"LLLLL"+mPass.length());
//if(mPass.lengt




// Stop if other than A-Z, a-Z and 0-9 characters found

	int mValid=0;

	for(int ii=0;ii<mCode.length();ii++)
	{

		if (mCode.charAt(ii)>=65 && mCode.charAt(ii)<=90)
		{
		  mValid=1;
		}
		else if (mCode.charAt(ii)>=97 && mCode.charAt(ii)<=122)
		{
		  mValid=1;
		}

		else if (mCode.charAt(ii)>=48 && mCode.charAt(ii)<=57)
		{
		  mValid=1;
		}
		else
		{
		mValid=0;
		break;
		}
	}

	String mChkSttring=mCode.toUpperCase();

	int start = mChkSttring.indexOf("INSERT");
	if (start<0)
		start = mChkSttring.indexOf("UPDATE");
	if (start<0)
		start = mChkSttring.indexOf("DELETE");
	if (start<0)
		start = mChkSttring.indexOf("TRUNCATE");
	if (start<0)
		start = mChkSttring.indexOf("DROP");
	if (start<0)
		start = mChkSttring.indexOf("CREATE");
	if (start<0)
		start = mChkSttring.indexOf("ALTER");


	// Make Invalid If any DML string found
        if (start>=0)
	   mValid=0;



try
{
//INSTITUTECODE MEMBERCODE    MEMBERTYPE     MEMBERPWD     LOGINDATE    IPADDRESS   

	if(mValid>0 && !mMemberType.equals("") && !mCode.equals("") && !mPass.equals(""))

		
	{
		qry="Select nvl(COMPANYTAGGING,'UNIV') from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'";
		rs=db.getRowset(qry);
		if (rs.next())
		   mComp2=rs.getString(1);
		else
		   mComp2="";
		//System.out.print(mComp);
		qry="SELECT NVL(IPVELOCITYCOUNT,-1)COUNT FROM COMPANYINSTITUTETAGGING WHERE COMPANYCODE='"+mComp2+"' AND INSTITUTECODE='"+mInst+"'";
		rs=db.getRowset(qry);
		if(rs.next())
        MAXHINT=rs.getInt(1);
		else
        MAXHINT=-1;
		if(MAXHINT!=-1)
        {
		//InetAddress inet=InetAddress.getLocalHost();
		//ipAddress=inet.getHostAddress();
		try
			{
				if (request.getHeader("HTTP_X_FORWARDED_FOR") == null)
				{
					ipAddress= request.getRemoteAddr();
				}
				else
				{
					ipAddress= request.getHeader("HTTP_X_FORWARDED_FOR");
				}
			}
			catch(Exception e){}

			qry="INSERT INTO LOGINATTEMPT(INSTITUTECODE, MEMBERCODE, MEMBERTYPE, MEMBERPWD,IPADDRESS) VALUES('"+mInst+"','"+mCode+"','"+mMemberType+"','"+mPass+"','"+ipAddress+"')";
		//out.print("TABLEUPDATE"+qry);
		db.insertRow(qry);

		int count=1;
	     qry="SELECT NVL(NOOFHITS,0)NOOFHITS FROM IPVELOCITYCHECK WHERE IPADDRESS='"+ipAddress+"' AND WEBMODULE='WEBKIOSK' AND ACTIONDATE=TO_DATE(TO_CHAR(sysdate,'DD-MM-YYYY'),'DD-MM-YYYY')";
		 rs=db.getRowset(qry);
		 if(rs.next())
		{
         int mNOOFHITS=rs.getInt(1);
		 if(mNOOFHITS < MAXHINT)
			{
			 mNOOFHITS++;
         qry="UPDATE IPVELOCITYCHECK SET  NOOFHITS='"+mNOOFHITS+"'WHERE IPADDRESS='"+ipAddress+"' AND WEBMODULE='WEBKIOSK' AND ACTIONDATE=TO_DATE(TO_CHAR(sysdate,'DD-MM-YYYY'),'DD-MM-YYYY')";
		 db.update(qry);
			}
			else
			{
         response.sendRedirect("LimitErrorPage.jsp");
		}
		}
		else
		{
		qry="INSERT INTO IPVELOCITYCHECK(IPADDRESS, WEBMODULE, ACTIONDATE, NOOFHITS) VALUES('"+ipAddress+"','WEBKIOSK',TO_DATE(TO_CHAR(sysdate,'DD-MM-YYYY'),'DD-MM-YYYY'),'"+count+"')";
		db.insertRow(qry);
		}
		}

		mEPass=enc.encode(mPass);
		mEMemberType=enc.encode(mMemberType);
		mECode=enc.encode(mCode);
                mEisp=enc.encode(lisp);


	      qry="Select PARAMETERID, PARAMETERVALUE,MINRANGE, MAXRANGE,nvl(LOGINTIMELIMIT,0)LOGINTIMELIMIT  From PARAMETERS Where MODULENAME='SIS' And PARAMETERID IN ('B1.1','B1.2','B1.3','B1.4','B1.5','A1.1') and nvl(DEACTIVE,'N')='N' ";
  		rs=db.getRowset(qry);
		while(rs.next())
		{



				//mMinSRS=rs.getString("PARAMETERVALUE");

			if(rs.getString("PARAMETERID").equals("B1.4"))
			{
				mStudDefPWD=rs.getString("PARAMETERVALUE");
				mMinPass=rs.getString("MINRANGE");
				mMaxPass=rs.getString("MAXRANGE");
				mLoginlimit=rs.getDouble("LOGINTIMELIMIT");

			}


			if(rs.getString("PARAMETERID").equals("B1.5"))
			{
				mEmpDefPWD=rs.getString("PARAMETERVALUE");

			}

			if(rs.getString("PARAMETERID").equals("A1.1"))
				mWebEmail=rs.getString("PARAMETERVALUE");
		}
		if(mMinPass.equals("") || mMaxPass.equals(""))
		{
			mMinPass="4";
			mMaxPass="20";
			mMinSRS="5";
			mLoginlimit=5;
		}



                 if(lisp.equalsIgnoreCase("P")){
                 qry="select nvl(ORATYP,' ')ORATYP,nvl(ORACD,' ')ORACD ,nvl(ORAID,' ')ORAID, ";
		qry=qry +" nvl(ORAPW,' ')PWD,nvl(ORAADM,' ') ROLENAME ,nvl(DEACTIVE,'N')DEACTIVE,nvl(FirstLogin,' ') FirstLogin ,nvl(PAGEHEADING,' ') PAGEHEADING";
		qry=qry +"  from Membermaster where trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEisp+"' ";

                 }else{
                 qry="select nvl(ORATYP,' ')ORATYP,nvl(ORACD,' ')ORACD ,nvl(ORAID,' ')ORAID, ";
		qry=qry +" nvl(ORAPW,' ')PWD,nvl(ORAADM,' ') ROLENAME ,nvl(DEACTIVE,'N')DEACTIVE,nvl(FirstLogin,' ') FirstLogin ,nvl(PAGEHEADING,' ') PAGEHEADING";
		qry=qry +"  from Membermaster where trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' ";

                 }
                //out.print(qry);
		rs=db.getRowset(qry);
		if(rs.next())
		{
			mFirst=rs.getString("FirstLogin");
			mDeactive=rs.getString("DEACTIVE");
			try
			{
				if (request.getHeader("HTTP_X_FORWARDED_FOR") == null)
				{
					mIPADDRESS= request.getRemoteAddr();
				}
				else
				{
					mIPADDRESS= request.getHeader("HTTP_X_FORWARDED_FOR");
				}
			}
			catch(Exception e){}

			mType=rs.getString("ORATYP");
	      	        mcode=rs.getString("ORACD");
			mId=rs.getString("ORAID");

                        if(mMemberType.equals("E"))
			{
				qry=" Select EmployeeID,COMPANYCODE from EmployeeMaster where EmployeeCode='"+mCode+"' And CompanyCode='"+mComp2+"' and nvl(DEACTIVE,'N')='N'";
				//out.print(qry);
				rs11=db.getRowset(qry);
				if(rs11.next())
				{
					mId=rs11.getString(1);
					mDID=mId;
					mId=enc.encode(mId);

					mComp1=rs11.getString("COMPANYCODE");
					session.setAttribute("CompanyCode",mComp1);
				}
				else
				{
						qry=" SELECT A.employeeid,B.INSTITUTECODE  INSTITUTECODE,B.COMPANYCODE COMPANYCODE FROM employeemaster A,emp#academicduty B  WHERE A.employeecode = '"+mCode+"' AND A.EMPLOYEEID=B.EMPLOYEEID AND A.COMPANYCODE=B.COMPANYCODE  AND NVL (A.deactive, 'N') = 'N'  AND NVL (B.deactive, 'N') = 'N'";
						//out.print(qry);
						rs11=db.getRowset(qry);
						if(rs11.next())
						{
							mId=rs11.getString(1);
							mDID=mId;
							mId=enc.encode(mId);
							mInstPersonal=rs11.getString("INSTITUTECODE");
							mComp=rs11.getString("COMPANYCODE");

							session.setAttribute("InstPersonal",mInstPersonal);
							session.setAttribute("CompanyCode",mComp);

							//session.setAttribute("CompanyCode",mComp);
							//session.setAttribute("InstituteCode",mInst);

						}
							else
						{
							qry=" Select EmployeeID,COMPANYCODE from EmployeeMaster where EmployeeCode='"+mCode+"'  and nvl(DEACTIVE,'N')='N'";
							//out.print(qry);
							rs11=db.getRowset(qry);
							if(rs11.next())
							{
									mId=rs11.getString(1);
								mDID=mId;
								mId=enc.encode(mId);

								session.setAttribute("CompanyCode",mComp2);
								session.setAttribute("Inst",mInst);

							}

								/*out.print("<br><img src='../Images/Error1.jpg'  >");
								out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Wrong Institute Code Selected or Wrong Emplooyee Code</font> <br>");
								out.print("<p><a href=../index.jsp><img src=../Images/Back.jpg border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");  */
						}
				}

			}
			else if(mMemberType.equals("G"))
			{
				qry=" Select GUESTID,companycode from GUEST where GUESTCODE='"+mCode+"' And CompanyCode='"+mComp2+"' and nvl(DEACTIVE,'N')='N'";
				//out.print(qry);
				rs11=db.getRowset(qry);
				if(rs11.next())
				{
					mId=rs11.getString(1);
					mDID=mId;
					mId=enc.encode(mId);
					mComp=rs11.getString("companycode");
					session.setAttribute("CompanyCode",mComp);
				}
			}
			else if(mMemberType.equals("S"))
			{


				qry="Select a.STUDENTID,b.COMPANYTAGGING companycode from STUDENTMASTER a,institutemaster b where ENROLLMENTNO='"+mCode+"' And a.INSTITUTECODE='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE and (nvl(a.PROGRAMCOMPLETED,'N')='Y' or nvl(a.DEACTIVE,'N')='N')";
				//qry=" Select STUDENTID from STUDENTMASTER where ENROLLMENTNO='"+mCode+"' And INSTITUTECODE='"+mInst+"' And nvl(DEACTIVE,'N')='N'";
				//out.print(qry);
				rs11=db.getRowset(qry);
				if(rs11.next())
				{
					mId=rs11.getString(1);
					mDID=mId;
					mId=enc.encode(mId);
					mComp=rs11.getString("companycode");
					session.setAttribute("CompanyCode",mComp);										
					session.setAttribute("securityval","10#11#2017#");
						

				}
			}
			else
			{
				qry=" Select FACULTYID,companycode from VISITINGFACULTYMASTER where FACULTYCODE='"+mCode+"' And CompanyCode='"+mComp2+"' AND INSTITUTECODE='"+mInst+"'";
				//out.print(qry);
				rs11=db.getRowset(qry);
				if(rs11.next())
				{
					mId=rs11.getString(1);
					mDID=mId;
					mId=enc.encode(mId);
					mComp=rs11.getString("companycode");
					session.setAttribute("CompanyCode",mComp);
				}
			}

			mpass=rs.getString("PWD");
			mRole=rs.getString("ROLENAME");
			mDeac=rs.getString("DEACTIVE");
			mpass=enc.decode(mpass).toUpperCase();
			mpass=enc.encode(mpass);

                        String pass=enc.decrypt(mpass);
                        System.out.println("New=========Password is -----------------" +pass);

			String PAGEHEADING="";
			if(!rs.getString("PAGEHEADING").equals(" ") && rs.getString("PAGEHEADING")!=null)
				PAGEHEADING=mInst+"-"+enc.decode(rs.getString("PAGEHEADING"));
			else
				PAGEHEADING=mInst;


			qry="select to_char(sysdate,'DDMONYYYY')ss from dual";
			rs=db.getRowset(qry);
			if(rs.next())
				{

				mBASEADMINPWD=enc.encode(mInst+"@"+rs.getString("ss"));
              //  mBASEADMINPWD=enc.encode("QAZ@"+mInst+"123");
                }

//	out.print(mBASEADMINPWD+"******"+(mInst+"@"+rs.getString("ss")));
			if(mInst.equals("JIIT"))
			{
				//mBASEADMINPWD="3rgFgHNj7oFJq6GCUeVWyg==";
				if(mWebEmail.equals(""))
					mWebEmail="info@jiit.ac.in";
			}
			else if(mInst.equals("J128"))
			{
				//mBASEADMINPWD="3rgFgHNj7oFJq6GCUeVWyg==";
				if(mWebEmail.equals(""))
					mWebEmail="info@jiit.ac.in";
			}
			else if(mInst.equals("JPBS"))
			{
			//	mBASEADMINPWD="cdOIdB5gHDBJq6GCUeVWyg==";
				if(mWebEmail.equals(""))
					mWebEmail="info@jpbs.ac.in";
			}
			else if(mInst.equals("JUIT"))
			{
				//mBASEADMINPWD="f9ZqxCT1oztJq6GCUeVWyg==";
				if(mWebEmail.equals(""))
					mWebEmail="info@juit.ac.in";
			}
			else if(mInst.equals("JIET"))
			{
				//mBASEADMINPWD="/WUslmXp2zhJq6GCUeVWyg==";
				if(mWebEmail.equals(""))
					mWebEmail="info@jiet.ac.in";
			}

//out.print(mpass+" . "+mEPass);
//out.print("*** "+enc.decode("N8wLgpBv1JX0/1Zqps/PTQ=="));

						//-------------password security

String mAttemptDate="",qry1="";
double mFLAC=0;

qry1="select  nvl(FLAC,0)FLAC from Membermaster where trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' ";
	//out.print(qry1);
	rs1=db.getRowset(qry1);
	if(rs1.next())
		{
	//	mAttemptDate=rs1.getString("ATTEMPTDATE");
		mFLAC=rs1.getDouble("FLAC");


		mFLAC=mFLAC*10;

		}
		else
						{
			mFLAC=0;
						}






		//------------

//out.print(mDeactive+"mDeactive");
if(!mDeactive.equals("Y"))
			{

			if(mpass.equals(mEPass) || mEPass.equals(mBASEADMINPWD))
	            {
                                if(mType.equalsIgnoreCase("TIqmXYrfzGg=")){
                                    session.setAttribute("MemberType","PTUtWaa61uw=");
                                    session.setAttribute("IspMemberType","TIqmXYrfzGg=");
                                }else{
                                    session.setAttribute("MemberType",mType);
                                }

				session.setAttribute("MemberCode",mcode);
				session.setAttribute("LogEntryMemberID",mId);
				session.setAttribute("LogEntryMemberType",mType);
				session.setAttribute("MemberID",mId);
				session.setAttribute("ROLENAME",mRole);
				session.setAttribute("IPADD",mIPADDRESS);
				session.setAttribute("MinPasswordLength",mMinPass);
				session.setAttribute("MaxPasswordLength",mMaxPass);
				session.setAttribute("MinSRSCount",mMinSRS);
				session.setAttribute("WebAdminEmail",mWebEmail);
				session.setAttribute("PageHeading",PAGEHEADING);
				session.setAttribute("InstituteCode",mInst);

			//	session.setAttribute("LoginComp",mComp2);
			session.setAttribute("LoginComp",mComp2);

				if(mDeac.equals("Y"))
				{
                  		out.print("<br><img src='../Images/Error1.jpg'  >");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Login Account Locked</font> <br>");
			      out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");
				out.print("<p><a href=../index.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
				}
				else
				{
					// Success Starts
				if(mMemberType.equals("S"))
					{



						qry="select nvl(ACADEMICYEAR,' ')ACADEMICYEAR,nvl(PROGRAMCODE,' ')PROGRAMCODE, ";
						qry=qry +" nvl(BRANCHCODE,' ')BRANCHCODE,nvl(SEMESTER,0)SEMESTER, ";
						qry=qry +"nvl(STUDENTNAME,' ')STUDENTNAME,nvl(INSTITUTECODE,' ')INSTITUTECODE,nvl(UNIQUEID,' ')UNIQUEID from STUDENTMASTER ";
 						qry=qry +" where STUDENTID='"+mDID+"' and INSTITUTECODE='"+mInst+"' ";
						//out.print(qry);
						rs4=db.getRowset(qry);
						if (rs4.next())
						{
                                                    //mInst=rs4.getString("INSTITUTECODE");
							mAcadmeicYear=rs4.getString("ACADEMICYEAR");
							mProgram=rs4.getString("PROGRAMCODE");
							mBranchCode=rs4.getString("BRANCHCODE");
							mSemester=rs4.getString("SEMESTER");
							mStudentName=rs4.getString("STUDENTNAME");
                                                        UniqueID=rs4.getString("UNIQUEID");
							mNickname=GlobalFunctions.getFirstName(mStudentName.trim());
						//	session.setAttribute("InstituteCode",mInst);
							session.setAttribute("AcademicYearCode",mAcadmeicYear);
                           	                        session.setAttribute("SEMESTER",mSemester);
							session.setAttribute("ProgramCode",mProgram);
							session.setAttribute("BranchCode",mBranchCode );
							session.setAttribute("CurrentSem",mSemester );
							session.setAttribute("MemberName",mStudentName );
							session.setAttribute("NickName",mNickname);
                                                        session.setAttribute("UNIQUEID", UniqueID);
                                                         session.setAttribute("StudentIDD", mDID);

                                                          session.setAttribute("InstituteCode", mInst);

						        db.saveLogEntry(mDID , mMemberType , mMACAddress , mIPADDRESS);

				              qrybankdetails="Select nvl(FREEZED,'N')FREEZED from studentpersonalbankdetail where  STUDENTID='"+mDID+"' and INSTITUTECODE='"+mInst+"'  and UNIQUEID='"+UniqueID+"'";
                                                Bnkdtl=db.getRowset(qrybankdetails);

                                                while(Bnkdtl.next()){

                                                     FreezeStatus=Bnkdtl.getString("FREEZED").toString();


                                                }





							if(mFirst.equals("N"))
								{
									response.sendRedirect("FirstTimeChangePassword.jsp");
								}


						  qry="   update membermaster set  FLAC=0 where trim(ORACD)='"+mECode+"' and	trim(ORATYP)='"+mEMemberType+"' ";
							int y=db.update(qry);

							if (mStudDefPWD.equals(mOlldPWD))
							{      response.sendRedirect("FirstTimeChangePassword.jsp");
							}
							else
							{
								//qry="SELECT nvl(QUESTION,' ')QUESTION, nvl(QUESTYIONTYPE,' ')QUESTYIONTYPE, nvl(ANSWER,' ')ANSWER FROM ASKEDSECRETQUESTION WHERE MEMBERID='"+mDID+"' AND MEMBERTYPE ='"+mMemberType+"'";
								//out.print(qry);
								//rs=db.getRowset(qry);
								//if(rs.next() && !rs.getString("QUESTION").equals(" ") && !rs.getString("QUESTYIONTYPE").equals(" ") && !rs.getString("ANSWER").equals(" ") )
// null

                                                    if(FreezeStatus.equals("N")){

                                                           response.sendRedirect("../StudentFiles/StudentBankDetail.jsp");

                                                    }

						           response.sendRedirect("../StudentFiles/StudentPage.jsp");


								//else
								//	response.sendRedirect("AskSecretQuestion.jsp");
							}
						}

	//	}


					}
					else if(mMemberType.equals("E"))
					{


						qry="select nvl(EMPLOYEENAME,' ')EMPLOYEENAME ,nvl(DESIGNATIONCODE,' ')DESIGNATIONCODE, ";
						qry=qry+" nvl(DEPARTMENTCODE,' ')DEPARTMENTCODE,nvl(COMPANYCODE,' ')COMPANYCODE  ";
						qry=qry+" from EMPLOYEEMASTER where EMPLOYEEID='"+mDID+"' ";
						//qry=qry+" and COMPANYCODE ='"+mComp+"'";
						//out.print("sdfsdfsdf"+qry);
						rs1=db.getRowset(qry);
						if(rs1.next())
						{
							if(1==1)
							{ 	mMname =rs1.getString("EMPLOYEENAME");
							 	mDescode =rs1.getString("DESIGNATIONCODE");
								mParentCompCode =rs1.getString("DEPARTMENTCODE");
								mNickname=GlobalFunctions.getFirstName(mMname.trim());
								session.setAttribute("MemberName",mMname);
								session.setAttribute("NickName",mNickname);
								session.setAttribute("DesignationCode",mDescode );
								session.setAttribute("DepartmentCode",mParentCompCode );
								qry= "select nvl(DESIGNATION,' ')DESIGNATION from DESIGNATIONMASTER ";
								qry=qry +" where DESIGNATIONCODE='"+mDescode+"' ";
								rs2=db.getRowset(qry);
								if(rs2.next())
									mDesg=rs2.getString("DESIGNATION");
								else
									mDesg="N/A";
								session.setAttribute("Designation",mDesg);
								qry="select nvl(DEPARTMENT,' ')DEPARTMENT from DEPARTMENTMASTER ";
								qry=qry +"where DEPARTMENTCODE='"+mParentCompCode+"' ";
								rs3=db.getRowset(qry);
								if(rs3.next())
									mDept=rs3.getString("DEPARTMENT");
								else
									mDept="N/A";
								session.setAttribute("Department",mDept);


								//db.saveLogEntry(mDID , mMemberType , mMACAddress , mIPADDRESS);



								if(mFirst.equals("N"))
								{
									response.sendRedirect("FirstTimeChangePassword.jsp");
								}

								if (mEmpDefPWD.equals(mOlldPWD))
								{
									response.sendRedirect("FirstTimeChangePassword.jsp");
								}
								else
								{
									 qry="   update membermaster set  FLAC=0 where trim(ORACD)='"+mECode+"' and	trim(ORATYP)='"+mEMemberType+"' ";
									int l=db.update(qry);



// Log Entry
	  		   //-----------------
			    db.saveTransLog(mInst,mDID,mMemberType ,"LASTLOGIN", "Last Login " , "No MAC Address" , mIPADDRESS);
			   //-----------------



									response.sendRedirect("../EmployeeFiles/EmployeePage.jsp");
								}
							}
							else
							{
								out.print("<br><img src='../Images/Error1.jpg'  >");
								out.print(" &nbsp;&nbsp;&nbsp <b><font size=5 face='Arial' color='Red'><b>Its Your First Login!</b></font> <br>");
								out.print("<p> &nbsp;&nbsp;&nbsp <b><font size=4 face='Arial' color='Red'>This facility is only available at Computer Centre.</font><br> <br><br><br><br><br><br><br><br><br><br><br><br>");
						            out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");
							}
						}
					}
                              else if(mMemberType.equals("G"))
					{
						qry="select nvl(GUESTNAME,' ')GUESTNAME, nvl(DESIGNATION,' ')DESIGNATION, ";
						qry=qry+" nvl(PARENTCOMPANYNAME,' ')PARENTCOMPANYNAME,nvl(COMPANYCODE,' ')COMPANYCODE  ";
						qry=qry+" from GUEST where GUESTID='"+mDID+"' ";
						qry=qry+" and COMPANYCODE ='"+mComp+"'";
						rs1=db.getRowset(qry);
						//out.print(qry);
						if(rs1.next())
						{

							if(1==1)
							{ 	mMname =rs1.getString("GUESTNAME");
							 	mDescode =rs1.getString("DESIGNATION");
								mParentCompCode =rs1.getString("PARENTCOMPANYNAME");
								//mcmpcode=rs1.getString("COMPANYCODE");
								mNickname=GlobalFunctions.getFirstName(mMname.trim());
								session.setAttribute("MemberName",mMname);
								session.setAttribute("NickName",mNickname);
								session.setAttribute("DesignationCode",mDescode );
								session.setAttribute("ParentCompanyName",mParentCompCode );
								//session.setAttribute("CompanyCode",mcmpcode);
								//session.setAttribute("InstituteCode",mInst);
								qry= "select nvl(DESIGNATION,' ')DESIGNATION from DESIGNATIONMASTER ";
								qry=qry +" where DESIGNATIONCODE='"+mDescode+"' ";
								rs2=db.getRowset(qry);
								if(rs2.next())
									mDesg=rs2.getString("DESIGNATION");
								else
									mDesg="N/A";
								session.setAttribute("Designation",mDesg);
								/*if(mFirst.equals("Y"))
								{
								  qry="Update MemberMaster set FirstLogin='N' where trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' ";
								  int jk=db.update(qry);
								}*/
							//	db.saveLogEntry(mDID , mMemberType , mMACAddress , mIPADDRESS);
								if (mEmpDefPWD.equals(mOlldPWD))
							      	   response.sendRedirect("FirstTimeChangePassword.jsp");
								else
								   response.sendRedirect("../GuestFiles/GuestPage.jsp");
							}
							else
							{
								out.print("<br><img src='../Images/Error1.jpg'  >");
								out.print(" &nbsp;&nbsp;&nbsp <b><font size=5 face='Arial' color='Red'><b>Its Your First Login!</b></font> <br>");
								out.print("<p> &nbsp;&nbsp;&nbsp <b><font size=4 face='Arial' color='Red'>This facility is only available at Computer Centre.</font><br> <br><br><br><br><br><br><br><br><br><br><br><br>");
						            out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");
							}
						}
						else
						{
							%><br><br><br><br><Center><img src='../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'><b>You are not registered in <%=mInst%> ! Re-Login with different Institute...</font></b></Center> <br><%
						}
					}
					//Success End
				}
			}

		 else
        {


	 if(mFLAC==0.0)
		 mFLAC=1.0;


			if(mLoginlimit>mFLAC)     //|| (mpass.equals(mEPass)|| mEPass.equals(mBASEADMINPWD)) )
			{
				 mFla=mFLAC+1;

				if(mLoginlimit==mFla)
				{

				out.print("<br><img src='../Images/Error1.jpg'  >");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>				Wrong password has been entered consecutively  "+(mFLAC)+" times. another wrong try may lock your account.				</font> <br>");
			      out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");
				out.print("<p><a href=../index.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
				}
				else
		    	{

				out.print("<br><img src='../Images/Error1.jpg'  >");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Password</font> <br>");
			      out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");
				out.print("<p><a href=../index.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");

				}



				//out.print(mIPADDRESS+"mIPADDRESS"+mLoginlimit+"mLoginlimit"+mFLAC);


				mFLAC=(mFLAC/10)+0.1;


			//	out.print(mIPADDRESS+"mIPADDRESS"+mLoginlimit+"mLoginlimit"+mFLAC);


				  qry="   update membermaster set  FLAC="+mFLAC+" where trim(ORACD)='"+mECode+"' and	trim(ORATYP)='"+mEMemberType+"' ";
					//out.print(qry);
					int a=db.update(qry);

					qry1="INSERT INTO LOGINFAIL (   INSTITUTECODE, MEMBERCODE, MEMBERTYPE,    MEMBERPWD, LOGINDATE, IPADDRESS) VALUES ('"+mInst+"' ,'"+mCode+"' ,'"+mMemberType+"'  ,  '"+mPass+"'  ,sysdate ,'"+mIPADDRESS+"' )";
							//out.print(qry1);
							int x=db.insertRow(qry1);



			}
             else
             {

					qry="   update membermaster set  deactive='Y' where trim(ORACD)='"+mECode+"' and	trim(ORATYP)='"+mEMemberType+"' ";
							//out.print(qry);
							int b=db.update(qry);


		      	out.print("<br><img src='../Images/Error1.jpg'  >");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Login Account Locked</font> <br>");
			      out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");
				out.print("<p><a href=../index.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");

			}



			}


//----------


			}
			else
			{
				 	out.print("<br><img src='../Images/Error1.jpg'  >");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Login Account Locked</font> <br>");
			      out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");
				out.print("<p><a href=../index.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
			}

//---------

		}
            else
            {
			out.print("<br><img src='../Images/Error1.jpg'  >");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Wrong Member Type or Code</font> <br>");
		     out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");
			out.print("<p><a href=../index.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
		}
	}
	else
      {
      	out.print("<br><img src='../Images/Error1.jpg'  >");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>LoginID and Password are Mandatory</font> <br>");
		out.print("<p><a href=../index.jsp><img src=../Images/Back.jpg border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
	}
}
catch(Exception e)
{
//	out.println(" error "+qry);
}}
%>
</BODY>
</HTML>