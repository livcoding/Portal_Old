<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Class Day Time Preference entry by Employee ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


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
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

DBHandler db=new DBHandler();
ResultSet rs=null, rs1=null, rs2=null, RS=null;
GlobalFunctions gb =new GlobalFunctions();
int kk1=0;
String qry="", qry1="", qry2="", Qry="";
String x="",mySect="",mfactype="";
int mTotal=0;
int n=0;
int mFlag=0;
String mName1="",mName2="",mName3="",mName6="", timepicker1="", timepicker2="";
String mELECTIVECODE="";
String QrySubject="", mSubjType="", mSubjDesc="";
String QryRoom="", mSubj="";
String mSType="", mLTP1="L", mLTP2="T", mLTP3="P", memLTP="";
int mL=0, mT=0, mP=0;
int n1=0, n2=0, n3=0, n4=0, n5=0, n6=0, n7=0;
String mLTP="",mQryDateTimeFr="", mQryDateTimeTo="", mPREFTIMEFR="", mPREFTIMETO="", mRTYPE="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mECode="",mE="",CurrDate="";
String mWebEmail="";
String mMon="", mTue="", mWed="", mThu="", mFri="", mSat="", mSun="";
String mTmpTimeFr1="",mTmpTimeFr2="",mTmpTimeFr3="",mTmpTimeFr4="", mTmpTimeFr5="", mTmpTimeFr6="", mTmpTimeFr7="";
String mTmpTimeTo1="",mTmpTimeTo2="",mTmpTimeTo3="",mTmpTimeTo4="", mTmpTimeTo5="", mTmpTimeTo6="", mTmpTimeTo7="";
String timepickerF1="",timepickerF2="",timepickerF3="",timepickerF4="", timepickerF5="", timepickerF6="", timepickerF7="";
String timepickerT1="",timepickerT2="",timepickerT3="",timepickerT4="", timepickerT5="", timepickerT6="", timepickerT7="";
String mMonChk="",mTueChk="",mWedChk="",mThuChk="", mFriChk="", mSatChk="", mSunChk="";

try
{

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";
rs=db.getRowset(qry);
if(rs.next())
  CurrDate=rs.getString(1);
else
  CurrDate="";	

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

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

if (request.getParameter("TotalCount")==null)
{
	mTotal=0;
}
else
{
	mTotal=Integer.parseInt(request.getParameter("TotalCount").toString().trim());
}

if (request.getParameter("InstCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=request.getParameter("InstCode").toString().trim();
}
if (request.getParameter("ExamCode")==null)
{
	mE="";
}
else
{
	mE=request.getParameter("ExamCode").toString().trim();
}

if (request.getParameter("Subject")==null)
{
	mSubjDesc="";
}
else
{
	mSubjDesc=request.getParameter("Subject").toString().trim();
}
mSubjDesc=request.getParameter("Subject").toString().trim();
int len=0;
int pos1=0;
len=mSubjDesc.length();
pos1=mSubjDesc.indexOf("(");
QrySubject=mSubjDesc.substring(0,pos1);
mSubjType=mSubjDesc.substring(pos1+1,len-1);

/*
if(mSubjType.equals("C"))
{
	qry="Select nvl(L,0)L, nvl(T,0)T, nvl(P,0)P from PROGRAMSCHEME where INSTITUTECODE='"+mInstitute+"' and SUBJECTID='"+QrySubject+"'";
	//qry=qry+" and SECTIONBRANCH in ( select SECTIONBRANCH from PR#DEPARTMENTSUBJECTTAGGING where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"')";
}
else if(mSubjType.equals("E"))
{
	qry="Select nvl(L,0)L, nvl(T,0)T, nvl(P,0)P from PR#ELECTIVESUBJECTS where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"'";
	//qry=qry+" and SECTIONBRANCH in ( select SECTIONBRANCH from PR#DEPARTMENTSUBJECTTAGGING where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"')";
}
else if(mSubjType.equals("F"))
{
	qry="Select nvl(L,0)L, nvl(T,0)T, nvl(P,0)P from FREEELECTIVE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"'";
	//qry=qry+" and SECTIONBRANCH in ( select SECTIONBRANCH from PR#DEPARTMENTSUBJECTTAGGING where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"')";
}
*/

qry="Select Distinct LTP LTP from PR#FACULTYSUBJECTCHOICES where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"'";
//out.print(qry);
rs1=db.getRowset(qry);
while(rs1.next())
{
	memLTP=rs1.getString("LTP");
	if(memLTP.equals("L"))
		mL=1;
	else if(memLTP.equals("T"))
		mT=1;
	else if(memLTP.equals("P"))
		mP=1;
}
//out.print("L is:"+mL+" T is:"+mT+" P is:"+mP);
%>
	<center><font size=4 face=Verdana color=green>Class Day-Time Preference Detail</font>
	<hr>
	<%
	String mtyp="";
	if(mSubjType.equals("C")) mtyp="Core";
	if(mSubjType.equals("F")) mtyp="Free Elective";
	if(mSubjType.equals("E")) mtyp="Elective";
	%>
	<font size=2 face='Verdana'><b>Subject Code: <%=QrySubject%></b></font>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<font size=2 face='Verdana'><b>Subject Type : <%=mtyp%></b></font></center>
<%
}
catch(Exception e)
{
}
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('110','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			if(mDMemberType.equals("E"))
			{
			 mfactype="I";	
			}
			else if(mDMemberType.equals("V"))
			{
			 mfactype="E";
			} 

			// For Log Entry Purpose
			//--------------------------------------
			String mLogEntryMemberID="",mLogEntryMemberType="";
			if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
				mLogEntryMemberID="";
			else
				mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();

			if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
				mLogEntryMemberType="";
			else
				mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

			if (mLogEntryMemberType.equals(""))
				mLogEntryMemberType=mMemberType;

			if (mLogEntryMemberID.equals(""))
				mLogEntryMemberID=mMemberID;

			if (!mLogEntryMemberType.equals(""))
				mLogEntryMemberType=enc.decode(mLogEntryMemberType);

			if (!mLogEntryMemberID.equals(""))
				mLogEntryMemberID=enc.decode(mLogEntryMemberID);

			//--------------------------------------

			if(request.getParameter("RoomType")!=null)
				QryRoom=request.getParameter("RoomType");
			else
				QryRoom="";

			if(request.getParameter("MonChk")!=null)
				mMonChk=request.getParameter("MonChk");
			else
				mMonChk="";

			if(request.getParameter("TueChk")!=null)
				mTueChk=request.getParameter("TueChk");
			else
				mTueChk="";

			if(request.getParameter("WedChk")!=null)
				mWedChk=request.getParameter("WedChk");
			else
				mWedChk="";

			if(request.getParameter("ThuChk")!=null)
				mThuChk=request.getParameter("ThuChk");
			else
				mThuChk="";

			if(request.getParameter("FriChk")!=null)
				mFriChk=request.getParameter("FriChk");
			else
				mFriChk="";

			if(request.getParameter("SatChk")!=null)
				mSatChk=request.getParameter("SatChk");
			else
				mSatChk="";

			if(request.getParameter("SunChk")!=null)
				mSunChk=request.getParameter("SunChk");
			else
				mSunChk="";

//			if(mMonChk!=null || mTueChk!=null || mWedChk!=null || mThuChk!=null || mFriChk!=null || mSatChk!=null || mSunChk!=null)
			if(mMonChk.equals("MON") || mTueChk.equals("TUE") || mWedChk.equals("WED") || mThuChk.equals("THU") || mFriChk.equals("FRI") || mSatChk.equals("SAT") || mSunChk.equals("SUN"))
			{
				if(request.getParameter("timepickerF1")!=null)
					mTmpTimeFr1=request.getParameter("timepickerF1");
				else
					mTmpTimeFr1="";

				if(request.getParameter("timepickerF2")!=null)
					mTmpTimeFr2=request.getParameter("timepickerF2");
				else
					mTmpTimeFr2="";

				if(request.getParameter("timepickerF3")!=null)
					mTmpTimeFr3=request.getParameter("timepickerF3");
				else
					mTmpTimeFr3="";

				if(request.getParameter("timepickerF4")!=null)
					mTmpTimeFr4=request.getParameter("timepickerF4");
				else
					mTmpTimeFr4="";

				if(request.getParameter("timepickerF5")!=null)
					mTmpTimeFr5=request.getParameter("timepickerF5");
				else
					mTmpTimeFr5="";

				if(request.getParameter("timepickerF6")!=null)
					mTmpTimeFr6=request.getParameter("timepickerF6");
				else
					mTmpTimeFr6="";

				if(request.getParameter("timepickerF7")!=null)
					mTmpTimeFr7=request.getParameter("timepickerF7");
				else
					mTmpTimeFr7="";

				if(request.getParameter("timepickerT1")!=null)
					mTmpTimeTo1=request.getParameter("timepickerT1");
				else
					mTmpTimeTo1="";

				if(request.getParameter("timepickerT2")!=null)
					mTmpTimeTo2=request.getParameter("timepickerT2");
				else
					mTmpTimeTo2="";

				if(request.getParameter("timepickerT3")!=null)
					mTmpTimeTo3=request.getParameter("timepickerT3");
				else
					mTmpTimeTo3="";

				if(request.getParameter("timepickerT4")!=null)
					mTmpTimeTo4=request.getParameter("timepickerT4");
				else
					mTmpTimeTo4="";

				if(request.getParameter("timepickerT5")!=null)
					mTmpTimeTo5=request.getParameter("timepickerT5");
				else
					mTmpTimeTo5="";

				if(request.getParameter("timepickerT6")!=null)
					mTmpTimeTo6=request.getParameter("timepickerT6");
				else
					mTmpTimeTo6="";

				if(request.getParameter("timepickerT7")!=null)
					mTmpTimeTo7=request.getParameter("timepickerT7");
				else
					mTmpTimeTo7="";



				%>
				<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
				<tr bgcolor=ff8c00>
				<td><b>Day</b></td>
				<td align=center><b>Prefered<br>Room Type</b></td>
				<td><b>Prefered Class Time<br><table width=100%><tr><td align=left><b>From</b></td><td align=right><b>To &nbsp; &nbsp;</b></td></tr></table></b></td>
				</tr>
				<%
					if(mMonChk.equals("MON"))
					{

                    // out.print("122"+mL+" "+mT+" "+mP);

					   if(mL>0)
					   {

Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP1+"' and PREFDAY='MON'";

						RS=db.getRowset(Qry);
						
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP1+"','MON','"+mTmpTimeFr1+"','"+mTmpTimeTo1+"','"+QryRoom+"')";
							//out.print("Insert :"+qry);
							n1=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='MON', PREFFROMTIME='"+mTmpTimeFr1+"', PREFTOTIME='"+mTmpTimeTo1+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP1+"' AND PREFDAY='MON' AND NVL(DEACTIVE,'N')='N'";
							//out.print("Update :"+qry);
							n1=db.update(qry);
							 //out.print(qry);
						}
						if(n1>0)
						{
							mFlag=1;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mT>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP2+"' and PREFDAY='MON'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP2+"','MON','"+mTmpTimeFr1+"','"+mTmpTimeTo1+"','"+QryRoom+"')";
							n1=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='MON', PREFFROMTIME='"+mTmpTimeFr1+"', PREFTOTIME='"+mTmpTimeTo1+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP2+"' AND PREFDAY='MON' AND NVL(DEACTIVE,'N')='N'";
							n1=db.update(qry);
							//out.print(qry);
						}
						if(n1>0)
						{
							mFlag=1;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mP>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP3+"' and PREFDAY='MON'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP3+"','MON','"+mTmpTimeFr1+"','"+mTmpTimeTo1+"','"+QryRoom+"')";
							n1=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='MON', PREFFROMTIME='"+mTmpTimeFr1+"', PREFTOTIME='"+mTmpTimeTo1+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP3+"' AND PREFDAY='MON' AND NVL(DEACTIVE,'N')='N'";
							n1=db.update(qry);
							//out.print(qry);
						}
						if(n1>0)
						{
							mFlag=1;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					}

					if(mTueChk.equals("TUE"))
					{
					   if(mL>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP1+"' and PREFDAY='TUE'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP1+"','TUE','"+mTmpTimeFr2+"','"+mTmpTimeTo2+"','"+QryRoom+"')";
							n2=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='TUE', PREFFROMTIME='"+mTmpTimeFr2+"', PREFTOTIME='"+mTmpTimeTo2+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP1+"' AND PREFDAY='TUE' AND NVL(DEACTIVE,'N')='N'";
							n2=db.update(qry);
							//out.print(qry);
						}
						if(n2>0)
						{
							mFlag=2;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mP>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP2+"' and PREFDAY='TUE'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP2+"','TUE','"+mTmpTimeFr2+"','"+mTmpTimeTo2+"','"+QryRoom+"')";
							n2=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='TUE', PREFFROMTIME='"+mTmpTimeFr2+"', PREFTOTIME='"+mTmpTimeTo2+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP2+"' AND PREFDAY='TUE' AND NVL(DEACTIVE,'N')='N'";
							n2=db.update(qry);
							//out.print(qry);
						}
						if(n2>0)
						{
							mFlag=2;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mP>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP3+"' and PREFDAY='TUE'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP3+"','TUE','"+mTmpTimeFr2+"','"+mTmpTimeTo2+"','"+QryRoom+"')";
							n2=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='TUE', PREFFROMTIME='"+mTmpTimeFr2+"', PREFTOTIME='"+mTmpTimeTo2+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP3+"' AND PREFDAY='TUE' AND NVL(DEACTIVE,'N')='N'";
							n2=db.update(qry);
							//out.print(qry);
						}
						if(n2>0)
						{
							mFlag=2;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					}
					if(mWedChk.equals("WED"))
					{
					   if(mL>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP1+"' and PREFDAY='WED'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP1+"','WED','"+mTmpTimeFr3+"','"+mTmpTimeTo3+"','"+QryRoom+"')";
							n3=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='WED', PREFFROMTIME='"+mTmpTimeFr3+"', PREFTOTIME='"+mTmpTimeTo3+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP1+"' AND PREFDAY='WED' AND NVL(DEACTIVE,'N')='N'";
							n3=db.update(qry);
							//out.print(qry);
						}
						if(n3>0)
						{
							mFlag=3;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mT>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP2+"' and PREFDAY='WED'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP2+"','WED','"+mTmpTimeFr3+"','"+mTmpTimeTo3+"','"+QryRoom+"')";
							n3=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='WED', PREFFROMTIME='"+mTmpTimeFr3+"', PREFTOTIME='"+mTmpTimeTo3+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP2+"' AND PREFDAY='WED' AND NVL(DEACTIVE,'N')='N'";
							n3=db.update(qry);
							//out.print(qry);
						}
						if(n3>0)
						{
							mFlag=3;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mP>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP3+"' and PREFDAY='WED'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP3+"','WED','"+mTmpTimeFr3+"','"+mTmpTimeTo3+"','"+QryRoom+"')";
							n3=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='WED', PREFFROMTIME='"+mTmpTimeFr3+"', PREFTOTIME='"+mTmpTimeTo3+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP3+"' AND PREFDAY='WED' AND NVL(DEACTIVE,'N')='N'";
							n3=db.update(qry);
							//out.print(qry);
						}
						if(n3>0)
						{
							mFlag=3;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					}
					if(mThuChk.equals("THU"))
					{
					   if(mL>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP1+"' and PREFDAY='THU'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP1+"','THU','"+mTmpTimeFr4+"','"+mTmpTimeTo4+"','"+QryRoom+"')";
							n4=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='THU', PREFFROMTIME='"+mTmpTimeFr4+"', PREFTOTIME='"+mTmpTimeTo4+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP1+"' AND PREFDAY='THU' AND NVL(DEACTIVE,'N')='N'";
							n4=db.update(qry);
							//out.print(qry);
						}
						if(n4>0)
						{
							mFlag=4;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mT>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP2+"' and PREFDAY='THU'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP2+"','THU','"+mTmpTimeFr4+"','"+mTmpTimeTo4+"','"+QryRoom+"')";
							n4=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='THU', PREFFROMTIME='"+mTmpTimeFr4+"', PREFTOTIME='"+mTmpTimeTo4+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP2+"' AND PREFDAY='THU' AND NVL(DEACTIVE,'N')='N'";
							n4=db.update(qry);
							//out.print(qry);
						}
						if(n4>0)
						{
							mFlag=4;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mP>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP3+"' and PREFDAY='THU'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP3+"','THU','"+mTmpTimeFr4+"','"+mTmpTimeTo4+"','"+QryRoom+"')";
							n4=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='THU', PREFFROMTIME='"+mTmpTimeFr4+"', PREFTOTIME='"+mTmpTimeTo4+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP3+"' AND PREFDAY='THU' AND NVL(DEACTIVE,'N')='N'";
							n4=db.update(qry);
							//out.print(qry);
						}
						if(n4>0)
						{
							mFlag=4;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					}
					if(mFriChk.equals("FRI"))
					{
					   if(mL>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP1+"' and PREFDAY='FRI'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP1+"','FRI','"+mTmpTimeTo5+"','"+mTmpTimeTo5+"','"+QryRoom+"')";
							n5=db.insertRow(qry);
							//out.print(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='FRI', PREFFROMTIME='"+mTmpTimeFr5+"', PREFTOTIME='"+mTmpTimeTo5+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP1+"' AND PREFDAY='FRI' AND NVL(DEACTIVE,'N')='N'";
							n5=db.update(qry);
							//out.print(qry);
						}
						if(n5>0)
						{
							mFlag=5;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mT>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP2+"' and PREFDAY='FRI'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP2+"','FRI','"+mTmpTimeTo5+"','"+mTmpTimeTo5+"','"+QryRoom+"')";
							n5=db.insertRow(qry);
							//out.print(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='FRI', PREFFROMTIME='"+mTmpTimeFr5+"', PREFTOTIME='"+mTmpTimeTo5+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP2+"' AND PREFDAY='FRI' AND NVL(DEACTIVE,'N')='N'";
							n5=db.update(qry);
							//out.print(qry);
						}
						if(n5>0)
						{
							mFlag=5;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mP>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP3+"' and PREFDAY='FRI'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP3+"','FRI','"+mTmpTimeTo5+"','"+mTmpTimeTo5+"','"+QryRoom+"')";
							n5=db.insertRow(qry);
							//out.print(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='FRI', PREFFROMTIME='"+mTmpTimeFr5+"', PREFTOTIME='"+mTmpTimeTo5+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP3+"' AND PREFDAY='FRI' AND NVL(DEACTIVE,'N')='N'";
							n5=db.update(qry);
							//out.print(qry);
						}
						if(n5>0)
						{
							mFlag=5;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					}
					if(mSatChk.equals("SAT"))
					{
					   if(mL>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP1+"' and PREFDAY='SAT'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP1+"','SAT','"+mTmpTimeFr6+"','"+mTmpTimeTo6+"','"+QryRoom+"')";
							n6=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='SAT', PREFFROMTIME='"+mTmpTimeFr6+"', PREFTOTIME='"+mTmpTimeTo6+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP1+"' AND PREFDAY='SAT' AND NVL(DEACTIVE,'N')='N'";
							n6=db.update(qry);
							//out.print(qry);
						}
						if(n6>0)
						{
							mFlag=6;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mT>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP2+"' and PREFDAY='SAT'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP2+"','SAT','"+mTmpTimeFr6+"','"+mTmpTimeTo6+"','"+QryRoom+"')";
							n6=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='SAT', PREFFROMTIME='"+mTmpTimeFr6+"', PREFTOTIME='"+mTmpTimeTo6+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP2+"' AND PREFDAY='SAT' AND NVL(DEACTIVE,'N')='N'";
							n6=db.update(qry);
							//out.print(qry);
						}
						if(n6>0)
						{
							mFlag=6;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mP>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP3+"' and PREFDAY='SAT'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP3+"','SAT','"+mTmpTimeFr6+"','"+mTmpTimeTo6+"','"+QryRoom+"')";
							n6=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='SAT', PREFFROMTIME='"+mTmpTimeFr6+"', PREFTOTIME='"+mTmpTimeTo6+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP3+"' AND PREFDAY='SAT' AND NVL(DEACTIVE,'N')='N'";
							n6=db.update(qry);
							//out.print(qry);
						}
						if(n6>0)
						{
							mFlag=6;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					}
					if(mSunChk.equals("SUN"))
					{
					   if(mL>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP1+"' and PREFDAY='SUN'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP1+"','SUN','"+mTmpTimeFr7+"','"+mTmpTimeTo7+"','"+QryRoom+"')";
							n7=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='SUN', PREFFROMTIME='"+mTmpTimeFr7+"', PREFTOTIME='"+mTmpTimeTo7+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP1+"' AND PREFDAY='SUN' AND NVL(DEACTIVE,'N')='N'";
							n7=db.update(qry);
							//out.print(qry);
						}
						if(n7>0)
						{
							mFlag=7;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mT>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP2+"' and PREFDAY='SUN'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP2+"','SUN','"+mTmpTimeFr7+"','"+mTmpTimeTo7+"','"+QryRoom+"')";
							n7=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='SUN', PREFFROMTIME='"+mTmpTimeFr7+"', PREFTOTIME='"+mTmpTimeTo7+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP2+"' AND PREFDAY='SUN' AND NVL(DEACTIVE,'N')='N'";
							n7=db.update(qry);
							//out.print(qry);
						}
						if(n7>0)
						{
							mFlag=7;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					   if(mP>0)
					   {
						Qry="Select SUBJECTID from PR#FACULTYDAYTIMEPREFERENCE where INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and SUBJECTID='"+QrySubject+"' and FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mChkMemID+"' and LTP='"+mLTP3+"' and PREFDAY='SUN'";
						RS=db.getRowset(Qry);
						//out.print(Qry);
						if(!RS.next())
						{
							//-------------
							//--Insert here
							//-------------
							qry="INSERT INTO PR#FACULTYDAYTIMEPREFERENCE (INSTITUTECODE, EXAMCODE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, PREFDAY, PREFFROMTIME, PREFTOTIME, REQROOMTYPE) VALUES ('"+mInstitute+"','"+mE+"', '"+QrySubject+"','"+mfactype+"','"+mChkMemID+"','"+mLTP3+"','SUN','"+mTmpTimeFr7+"','"+mTmpTimeTo7+"','"+QryRoom+"')";
							n7=db.insertRow(qry);
						}
						else
						{
							//-------------
							//--Update here
							//-------------
							qry="UPDATE PR#FACULTYDAYTIMEPREFERENCE SET PREFDAY='SUN', PREFFROMTIME='"+mTmpTimeFr7+"', PREFTOTIME='"+mTmpTimeTo7+"', REQROOMTYPE='"+QryRoom+"'";
							qry=qry+" WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE='"+mE+"' AND SUBJECTID='"+QrySubject+"' AND FACULTYTYPE='"+mfactype+"'";
							qry=qry+" AND FACULTYID='"+mChkMemID+"' AND LTP='"+mLTP3+"' AND PREFDAY='SUN' AND NVL(DEACTIVE,'N')='N'";
							n7=db.update(qry);
							//out.print(qry);
						}
						if(n7>0)
						{
							mFlag=7;
							// Log Entry
							//-----------------
						      db.saveTransLog(mInstitute,mLogEntryMemberID,mLogEntryMemberType ,"PRE-REG TIME PREFERENCE ENTRY", "ExamCode:"+mE +" Subject:"+ mSubj+ " LTP=L", "NO MAC Address" , mIPAddress);
							//-----------------
						}
					   }
					}
					if(mFlag>0)
					{
						mFlag=0;
						%><br><Center><Font size=3 color=Green><b><%
						out.print("Day-Time Preference(s) saved successfully...");
						%></Center></Font></b><%						
						//response.sendRedirect("EmpSubjectDateTimePrefEntry.jsp");
					}
				qry="select Distinct decode(A.PREFDAY,'MON','Monday','TUE','Tuesday','WED','Wednessday','THU','Thrusday','FRI','Friday','SAT','Saturday','SUN','Sunday')PREFDAY, ";
				qry=qry+" decode(A.PREFDAY,'MON',1,'TUE',2,'WED',3,'THU',4,'FRI',5,'SAT',6,'SUN',7)PREFDAY2, ";
				qry=qry+" nvl(A.PREFFROMTIME,' ') PTF, nvl(A.PREFTOTIME,' ') PTT, decode(ltrim(rtrim(A.REQROOMTYPE)),'LT','Lecture Theater 1','LT2','Lecture Theater 2','PR','Projector Room','TR','Tutorial Room','CL','Class Room','NONE','None')RMT";
				qry=qry+" from PR#FACULTYDAYTIMEPREFERENCE A where A.SUBJECTID='"+QrySubject+"' AND";
				qry=qry+" A.INSTITUTECODE='"+mInstitute+"' AND A.EXAMCODE='"+mE+"' AND A.FACULTYID='"+mChkMemID+"'";
				qry=qry+" AND A.FACULTYTYPE='"+mfactype+"' and nvl(A.DEACTIVE,'N')='N' Order By PREFDAY2";
				//out.print(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
				%>
				<tr bgcolor=white>
				<td><%=rs.getString("PREFDAY")%></td>
				<td align=center><%=rs.getString("RMT")%></td>
				<td><table width=100%><tr><td align=left><%=rs.getString("PTF")%></td><td align=right><%=rs.getString("PTT")%></td></tr></table></td>
				</tr>
				<%
				}
			}
			else
			{
				%><br><br><Center><Font size=3 color=Red><b><img src='../../Images/Error1.jpg'>&nbsp;<%
				out.print("No Record Selected...<br>&nbsp; &nbsp; &nbsp; Please select the specific Day(s)...");
				%></Center></Font></b><%
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
			</font><br><br><br><br>
			<%
		}
  //-----------------------------
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
}
%><br>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>