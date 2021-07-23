<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rsyyyy=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="",qrtyyy="";
String  QryAcad="",QryProgramCode="" ,xLTP="";
String qertu=""; ResultSet rsqertu=null;

int mSNO=0;
String mMemberID="",mREGCONFIRMATIONDATE1="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";



String mSubj="", mStatus="", mCtype="";
String mExam="";
String mLTP="";
String mTotal="";
String mStudID="";
String mCType="ALL" ,mInst="",mColor="",mColor1="";

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

	if (request.getParameter("EXAM").toString().trim()==null)
	{
		mExam="";
	}
	else
	{
		mExam=request.getParameter("EXAM").toString().trim();
	}



	if (request.getParameter("CTYPE").toString().trim()==null)
	{
		mCType="";
	}
	else
	{
		mCType=request.getParameter("CTYPE").toString().trim();
	}

	if (request.getParameter("SC").toString().trim()==null)
	{
		mSubj="";
	}
	else
	{
		mSubj=request.getParameter("SC").toString().trim();
	}

	if (request.getParameter("LTP").toString().trim()==null)
	{
		mLTP="";
	}
	else
	{
		mLTP=request.getParameter("LTP").toString().trim();
	}

//out.print(xLTP);

if(mLTP.equals("LT")){

xLTP="'L'"+","+"'T'";
}else{

xLTP="'"+mLTP+"'";
}
//out.print(xLTP);

	String QryFSTID="",QrySemType="",mSec="",mSubSec="",mSID="",QryEmpID="";
	long QrySem=4;

	if (request.getParameter("EMPLOYEEID")==null)
	{
		QryEmpID="";
	}
	else
	{
		QryEmpID=request.getParameter("EMPLOYEEID").toString().trim();
	}

//out.print(QryEmpID+"LLL");

	if (request.getParameter("SEMESTERTYPE")==null)
	{
		QrySemType="";
	}
	else
	{
		QrySemType=request.getParameter("SEMESTERTYPE").toString().trim();
	}

	if (request.getParameter("SEC")==null)
	{
		mSec="";
	}
	else
	{
		mSec=request.getParameter("SEC").toString().trim();
	}

	if (request.getParameter("SUBSEC")==null)
	{
		mSubSec="";
	}
	else
	{
		mSubSec=request.getParameter("SUBSEC").toString().trim();
	}

//&amp;prevPFSTID=<%=prevPFSTID

String 	prevTFSTID="",prevPFSTID="",prevLFSTID="";


	if (request.getParameter("prevPFSTID")==null)
	{
		prevPFSTID="";
	}
	else
	{
		prevPFSTID=request.getParameter("prevPFSTID").toString().trim();
	}

if (request.getParameter("prevLFSTID")==null)
	{
		prevLFSTID="";
	}
	else
	{
		prevLFSTID=request.getParameter("prevLFSTID").toString().trim();
	}
if (request.getParameter("prevTFSTID")==null)
	{
		prevTFSTID="";
		}
	else
	{
		prevTFSTID=request.getParameter("prevTFSTID").toString().trim();
	}


String mLFSTID="",mTFSTID="",mPFSTID="";

if (request.getParameter("mLFSTID")==null)
	{
		mLFSTID="";
	}
	else
	{
		mLFSTID=request.getParameter("mLFSTID").toString().trim();
	}

if (request.getParameter("mTFSTID")==null)
	{
		mTFSTID="";
	}
	else
	{
		mTFSTID=request.getParameter("mTFSTID").toString().trim();
	}
if (request.getParameter("mPFSTID")==null)
	{
		mPFSTID="";
		}
	else
	{
		mPFSTID=request.getParameter("mPFSTID").toString().trim();
	}


String mDate1="",mDate2="";

	if (request.getParameter("Date1")==null)
	{
		mDate1="";
	}
	else
	{
		mDate1=request.getParameter("Date1").toString().trim();
	}

	if (request.getParameter("Date2")==null)
	{
		mDate2="";
	}
	else
	{
		mDate2=request.getParameter("Date2").toString().trim();
	}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student Attendance Report (Lecture Attendance Detail)]</TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals(""))
	{
	mDMemberCode=enc.decode(mMemberCode);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
	String mINSTITUTECODE=mInst;
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
  //mMemberID=mChkMemID;

	if (request.getParameter("mMemberID")==null)
	{
		mMemberID="";
		}
	else
	{
		mMemberID=request.getParameter("mMemberID").toString().trim();
	}





	qry="Select WEBKIOSK.ShowLink('88','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
			if (1==1)//RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {


				mSID=mChkMemID;
          //      mMemberID=mChkMemID;
  //----------------------

%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>Student Lecture Attendance Detail</b></font></td>
</tr>
</TABLE>
<%
String mSnm="", mENo="",mSubject="",mSubSection="";





qry="select distinct StudentName, Enrollmentno,ACADEMICYEAR, SEMESTER, STUDENTID,NVL(SEMESTERTYPE,' ')SEMESTERTYPE, " +
        " AcademicYear AcademicYear,ProgramCode ProgramCode from  V#STUDENTLTPDETAIL  where StudentID='"+mMemberID+"'" +
        "  and INSTITUTECODE='"+mInst+"'  and EXAMCODE='"+mExam+"' ";
//out.print(qry);
rs1=db.getRowset(qry);
if(rs1.next())
{


QryAcad=rs1.getString("AcademicYear").toString().trim();
QryProgramCode=rs1.getString("ProgramCode").toString().trim();
QrySemType=rs1.getString("SEMESTERTYPE").toString().trim();
QrySem=rs1.getInt("SEMESTER");
mSnm=rs1.getString(1);
mENo=rs1.getString(2);

}



qry="select distinct SUBSECTIONCODE from V#STUDENTLTPDETAIL where examcode='"+mExam+"'   and academicyear='"+QryAcad+"' and programcode='"+QryProgramCode+"' and  StudentID='"+mMemberID+"'  and INSTITUTECODE='"+mInst+"' and LTP IN ("+xLTP+") and subjectid='"+ mSubj +"'";
rs1=db.getRowset(qry);
 //out.print(qry);
while(rs1.next())
{


 if (mSubSection == null ||  mSubSection.equals("")) {
          mSubSection=rs1.getString("SUBSECTIONCODE");
        } else {
          mSubSection=mSubSection+","+rs1.getString("SUBSECTIONCODE");
        }


	//mSubSection=rs1.getString("SUBSECTIONCODE");
	//mSubSection=mSubSection+","+rs1.getString("SUBSECTIONCODE");

}




qry="select subject||'('|| subjectcode ||')' subject From subjectmaster where subjectid='"+ mSubj +"'  and INSTITUTECODE='"+mInst+"'";
	rs1=db.getRowset(qry);
	if(rs1.next())
	{
		mSubject=rs1.getString(1);
	}

 String mREGCONFIRMATIONDATE="",mSpecialApproval="";
 ResultSet rsBatchDate=null;
 int mSem=0;
  String qry22=" Select nvl(to_char(SUBJECTREGISTRATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE,nvl(to_char(SUBJECTREGISTRATIONDATE,'yyyymmdd'),' ') REGCONFIRMATIONDATE1 ,nvl(SPECIALAPPROVAL,'N')SPECIALAPPROVAL   From studentltpdetail a ,facultysubjecttagging b Where a.fstid=b.fstid and b.INSTITUTECODE='"+mINSTITUTECODE+"'";
					qry22=qry22+" and b.examcode= '"+mExam+"' AND STUDENTID='"+mMemberID+"' and subjectid= '"+ mSubj +"' and rownum=1 and nvl(SPECIALAPPROVAL,'N')= 'Y' ";


             ResultSet  rsBatchDate1=db.getRowset(qry22);
if(rsBatchDate1.next())
					{
							mSpecialApproval=rsBatchDate1.getString("SPECIALAPPROVAL");

						    mREGCONFIRMATIONDATE=rsBatchDate1.getString("REGCONFIRMATIONDATE");

    }

else {
       	mSpecialApproval="N";
}
qry="Select nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE,nvl(to_char(REGCONFIRMATIONDATE,'yyyymmdd'),' ') REGCONFIRMATIONDATE1 ,nvl(SPECIALAPPROVAL,'N')SPECIALAPPROVAL,a.semester  From StudentRegistration a , studentmaster b Where a.INSTITUTECODE='"+mInst+"'";
					qry=qry+" AND a.EXAMCODE='"+mExam+"'";
					qry=qry+"and a.STUDENTID='"+mMemberID+"' and  a.INSTITUTECODE=b.INSTITUTECODE and a.studentid=b.studentid ";

					rsBatchDate=db.getRowset(qry);

					 if(rsBatchDate.next())
					{
						// mSpecialApproval=rsBatchDate.getString("SPECIALAPPROVAL");

							mREGCONFIRMATIONDATE1=rsBatchDate.getString("REGCONFIRMATIONDATE1");

if(!mSpecialApproval.equals("Y")){
						mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
					}
                        mSem=rsBatchDate.getInt("semester");


					}



int hghg=0,hhhhhhh=0;
if( (mINSTITUTECODE.equals("JIIT") || mINSTITUTECODE.equals("J128")) && (QryProgramCode.equals("B.T") || QryProgramCode.equals("DUAL"))
&& QryAcad.equals("1314")
	&& 9==8)
					{

	hghg++;
				QrySem=1;
					//mREGCONFIRMATIONDATE="16-08-2013";
					//out.print("&**&*&*&**&*&*&*&*&8");
					} else if( (mINSTITUTECODE.equals("JPBS")  ) && (QryProgramCode.equals("MBA")  )
&& QryAcad.equals("1314")
	&& 8==9)
					{


	hhhhhhh++;
				QrySem=QrySem;
					//mREGCONFIRMATIONDATE="16-08-2013";
					//out.print("&**&*&*&**&*&*&*&*&8"); 
					}
					else
					{
						hghg=0;
				QrySem=QrySem;
				mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE;
					}




//----------------------------------------special case -----------------------------//

 if(mSpecialApproval.equals("Y"))
	 QrySem=1;
 else
QrySem=QrySem;

//----------------------------------------special case -----------------------------//

int mREGCONFIRMATIONDATE1int = Integer.parseInt(mREGCONFIRMATIONDATE1);


if(QrySem==1 && mREGCONFIRMATIONDATE1int<=(20130816) && hghg>0  ){
	mREGCONFIRMATIONDATE="16-08-2013";
	//out.print(mREGCONFIRMATIONDATE1int+"20130816");

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int >(20130816) && hghg>0  ){
	//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"****1111111111*******"+mREGCONFIRMATIONDATE+"    &nbsp;&nbsp;&nbsp;&nbsp;");
//	mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE+1;

qrtyyy="select to_char(to_date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')+1,'dd-mm-yyyy')Regdate from dual";
rsyyyy=db.getRowset(qrtyyy);
if(rsyyyy.next()){
mREGCONFIRMATIONDATE=rsyyyy.getString("Regdate");
//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"*****22222222222******"+mREGCONFIRMATIONDATE);
}

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int<=(20130630) && hhhhhhh>0  ){
	mREGCONFIRMATIONDATE="30-06-2013";
	//out.print(mREGCONFIRMATIONDATE1int+"20130816");

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int >(20130630) && hhhhhhh>0  ){
	//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"****1111111111*******"+mREGCONFIRMATIONDATE+"    &nbsp;&nbsp;&nbsp;&nbsp;");
//	mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE+1;

qrtyyy="select to_char(to_date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')+1,'dd-mm-yyyy')Regdate from dual";
rsyyyy=db.getRowset(qrtyyy);
if(rsyyyy.next()){
mREGCONFIRMATIONDATE=rsyyyy.getString("Regdate");
//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"*****22222222222******"+mREGCONFIRMATIONDATE);
}

}else{

mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE;
///out.print(mREGCONFIRMATIONDATE1int+"20130816"+"################");
}







%>
<table width="100%">
<tr><td align=center>
 <font color="#00008b">Subject Code- <b><%=mSubject%></B> &nbsp; &nbsp;Student Name-<B><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</B> &nbsp; &nbsp; LTP- <B><%=GlobalFunctions.getLTPDescWSQ(mLTP)%> Sub-Section-  <%=mSubSection%></B></font>
</td></tr></table>
 <TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="70%" border=1 >
<thead>
<tr bgcolor="#c00000">
 <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td Title="Click on Date to Sort"><b><font color="White">Date</font></b></td>
 <td Title="Click on Attendance by to Sort"><b><font color="White">Attendance By</font></b></td>
 <td align=center Title="Click on Status to Sort"><b><font color="White">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status</font></b></td>
 <td Title="Click on Class Type to Sort"><b><font color="White">Class Type</font></b></td>
  <%
if(mLTP.equals("'L','T'"))
		   {
mLTP="LT";
		   }
		   else if(mLTP.equals("'L'"))
		   {
mLTP="L";
		   }
		    else if(mLTP.equals("'T'"))
		   {
mLTP="T";
		   }
		       else if(mLTP.equals("'P'"))
		   {
		   mLTP="P";
		   }

if(mLTP.equals("LT")  )
    {
     %><td align=center Title=""><b><font color="White">LTP</font></b></td> <%
    }
 %>
</tr>
</thead>
<tbody>
<%


 mLFSTID="";
 mTFSTID="";
 mPFSTID="";
String test="";

qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+mSubj+"' and EXAMCODE= '"+mExam+"' AND  a.LTP='L' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mLFSTID=rs1.getString("fstid");
		}

qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+mSubj+"' and EXAMCODE= '"+mExam+"' AND  a.LTP='T' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
//out.println(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mTFSTID=rs1.getString("fstid");
		}

		qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+mSubj+"' and EXAMCODE= '"+mExam+"' AND  a.LTP='P' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mPFSTID=rs1.getString("fstid");
		}

String QryMainL="";
//out.print("mLTP "+mLTP);
String qry2="",qry3="",qry4="",qry5="",qry6="",qry7="",qry8="",qry9="";
//-------------------------- For L Type Subject -------------------------------------
if(mLTP.equals("L") || mLTP.equals("LT"))
 {
	 QryMainL=" select    to_Char(CLASSTIMEFROM,'dd-mm-rrrr hh:mi am') CLASSTIMEFROM ,to_Char(CLASSTIMEFROMX,'dd-mm-yyyy') CLASSTIMEFROMX  , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,'Lecture' LTP,EMPLOYEENAME from ( ";
	 qry1=" select distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, 'N' PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME from V#STUDENTATTENDANCE a where SubjectID= '"+mSubj+"'  and LTP='L' and EXAMCODE= '"+mExam+"'  AND  ( A.FSTID='"+mLFSTID+"'   OR ( A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+mExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubj+"' and  b.LTP='L' and b.FSTID='"+mLFSTID+"')))  ";
	 qry1=qry1+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
	 qry1=qry1+" and trunc(a.classtimefrom)<  NVL((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubj+"'  and c.LTP='L' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"'),a.classtimefrom)";
	qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  NVL((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubj+"'  and c.LTP='L' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ) ,a.classtimefrom)";
	qry1=qry1+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
	qry1=qry1+"   or ("+QrySem+">1)           ";
		qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))  ) ";

 //	out.print(qry1);

	 qry2=" select distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE,  'N'  PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME  from V#StudentAttendance  a where SubjectID= '"+mSubj+"'  and LTP='L' and EXAMCODE=  '"+mExam+"' ";
	qry2=qry2+"  AND  A.FSTID='"+prevLFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
	qry2=qry2+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubj+"' and c.studentid='"+mMemberID+"' ";
	qry2=qry2+"  and c.LTP='L' and c.EXAMCODE=  '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevLFSTID+"' )";
	qry2=qry2+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubj+"'  and c.LTP='L' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
	qry2=qry2+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry2=qry2+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
	qry2=qry2+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
	qry2=qry2+"   or ("+QrySem+">1)        )    ";



	 //out.print(qry2);
	 qry3="SELECT distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME  from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubj+"' and EXAMCODE= '"+mExam+"'  and a.ltp='L' and a.studentid='"+mMemberID+"'   ";
	qry3=qry3+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
	qry3=qry3+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry3=qry3+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
	qry3=qry3+" UNION   ";
	qry3=qry3+" select  distinct CLASSTIMEFROM ,CLASSTIMEFROM CLASSTIMEFROMX, ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,(select EMPLOYEENAME from V#Staff v where v.employeeid=sp1.employeeid and rownum=1) EMPLOYEENAME from STUDENTPREVATTENDENCE sp1 where  subjectid ='"+mSubj+"'     AND ltp ='L'    ";
	qry3=qry3+" AND examcode =  '"+mExam+"'   AND studentid = '"+mMemberID+"'   ";
	qry3=qry3+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'";
	qry3=qry3+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
	qry3=qry3+" and trunc(sp1.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry3=qry3+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
					qry3=qry3+"  and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";

//	out.print(qry3);

	 qry4="SELECT distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubj+"' and EXAMCODE= '"+mExam+"'  and a.ltp='L' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
	qry4=qry4+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
			qry4=qry4+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
		qry4=qry4+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
	qry4=qry4+" UNION   ";
	qry4=qry4+" select  distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,(select EMPLOYEENAME from V#Staff v where v.employeeid=sp1.employeeid  and rownum=1) EMPLOYEENAME from STUDENTPREVATTENDENCE sp1 where  subjectid ='"+mSubj+"'     AND ltp ='L'    ";
	qry4=qry4+" AND examcode =  '"+mExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";
	qry4=qry4+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'";
	qry4=qry4+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry4=qry4+" and trunc(sp1.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry4=qry4+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
							qry4=qry4+"   and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";

	//out.print(qry4);
	//Finally Merging Queries -----------
 }
		if(mLTP.equals("L"))
		 {
			QryMainL=QryMainL+" ("+qry1+") union ("+qry2+") union ("+qry3+") union ("+qry4+") ) group by  CLASSTIMEFROM, CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N'),'Lecture',EMPLOYEENAME order by to_date(CLASSTIMEFROM,'dd-mm-rrrr hh:mi am')  ";
			//out.print("aaa"+QryMainL);
			rs1=db.getRowset(QryMainL);
		 }


String QryMainT="";
if(mLTP.equals("T") || mLTP.equals("LT"))
 {
//-------------------------- For T Type Subject -------------------------------------
	 QryMainT=" select     to_Char(CLASSTIMEFROM,'dd-mm-rrrr hh:mi am') CLASSTIMEFROM ,to_Char(CLASSTIMEFROMX,'dd-mm-yyyy') CLASSTIMEFROMX, ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,'Tutorial' LTP,EMPLOYEENAME from ( ";
	 qry5=" select distinct CLASSTIMEFROM, CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, 'N' PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME from V#STUDENTATTENDANCE a where SubjectID= '"+mSubj+"'  and LTP='T' and EXAMCODE= '"+mExam+"'  AND  ( A.FSTID='"+mTFSTID+"'   OR (A.FSTID  IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+mExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubj+"' and  b.LTP='T' and B.FSTID='"+mTFSTID+"')))  ";
	 qry5=qry5+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
	 qry5=qry5+" and trunc(a.classtimefrom)<  NVL(( SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubj+"'  and c.LTP='T' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
	qry5=qry5+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)< nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubj+"'  and c.LTP='T' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ) , a.classtimefrom )";
	qry5=qry5+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
	qry5=qry5+"   or ("+QrySem+">1)            ";
	qry5=qry5+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry5=qry5+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))  ) ";

	//out.print(qry5);

	 qry6=" select distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE,  'N'  PRESENT,ENTRYBYFACULTYNAME  EMPLOYEENAME from V#StudentAttendance  a where SubjectID= '"+mSubj+"'  and LTP='T' and EXAMCODE=  '"+mExam+"' ";
	qry6=qry6+"  AND  A.FSTID='"+prevTFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
	qry6=qry6+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubj+"' and c.studentid='"+mMemberID+"' ";
	qry6=qry6+"  and c.LTP='T' and c.EXAMCODE=  '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevTFSTID+"' )";
	qry6=qry6+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubj+"'  and c.LTP='T' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
		qry6=qry6+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry6=qry6+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
					qry6=qry6+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
	qry6=qry6+"   or ("+QrySem+">1)        )    ";

	//out.print(qry2);


	 qry7="SELECT distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubj+"' and EXAMCODE= '"+mExam+"'    and a.ltp='T' and a.studentid='"+mMemberID+"'   ";
	qry7=qry7+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
	qry7=qry7+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry7=qry7+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
	qry7=qry7+" UNION   ";
	qry7=qry7+" select  distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,(select EMPLOYEENAME from V#Staff v where v.employeeid=sp1.employeeid and rownum=1) EMPLOYEENAME from STUDENTPREVATTENDENCE sp1 where  subjectid ='"+mSubj+"'     AND ltp ='T'    ";
	qry7=qry7+" AND examcode =  '"+mExam+"'   AND studentid = '"+mMemberID+"'   ";
	qry7=qry7+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'";
	qry7=qry7+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
	qry7=qry7+" and trunc(sp1.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry7=qry7+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";

	//out.print(qry3);

	 qry8="SELECT distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubj+"' and EXAMCODE= '"+mExam+"'  and a.ltp='T' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
	qry8=qry8+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
	qry8=qry8+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
	qry8=qry8+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
	qry8=qry8+" UNION   ";
	qry8=qry8+" select  distinct CLASSTIMEFROM,CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,(select EMPLOYEENAME from V#Staff v where v.employeeid=sp1.employeeid  and rownum=1) EMPLOYEENAME from STUDENTPREVATTENDENCE sp1 where  subjectid ='"+mSubj+"'     AND ltp ='T'    ";
	qry8=qry8+" AND examcode =  '"+mExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";
	qry8=qry8+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'";
	qry8=qry8+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
	qry8=qry8+" and trunc(sp1.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry8=qry8+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
	//out.print(qry4);
//Finally Merging Queries -----------
 }
if(mLTP.equals("T") )
   {
		QryMainT=QryMainT+" ("+qry5+") union ("+qry5+") union ("+qry7+") union ("+qry8+") ) group by  CLASSTIMEFROM ,CLASSTIMEFROMX, ATTENDANCETYPE, nvl(PRESENT,'N'),'Tutorial',EMPLOYEENAME order by to_date(CLASSTIMEFROM,'dd-mm-rrrr hh:mi am')  ";
		//out.print(QryMainT);
		rs1=db.getRowset(QryMainT);
   }

 if(mLTP.equals("LT"))
		   {

			QryMainL=QryMainL+" ("+qry1+") union ("+qry2+") union ("+qry3+") union ("+qry4+") ) group by CLASSTIMEFROMX, CLASSTIMEFROM , ATTENDANCETYPE, nvl(PRESENT,'N'),'Lecture',EMPLOYEENAME ";
			QryMainT=QryMainT+" ("+qry5+") union ("+qry6+") union ("+qry7+") union ("+qry8+") ) group by CLASSTIMEFROMX, CLASSTIMEFROM , ATTENDANCETYPE, nvl(PRESENT,'N'),'Tutorial',EMPLOYEENAME ";
			String QryMainLT=" SELECT * FROM   ("+QryMainL+" UNION "+QryMainT+")  order by to_date(CLASSTIMEFROM,'dd-mm-rrrr hh:mi am')  ";
			//----(@)-----//out.print(QryMainLT);
			rs1=db.getRowset(QryMainLT);
		   }
//-----------------------------=============================================================
String QryMainP="";
if(mLTP.equals("P"))
		   {
		//-------------------------- For P Type Subject -------------------------------------
		  QryMainP=" select     to_Char(CLASSTIMEFROM,'dd-mm-rrrr hh:mi am') CLASSTIMEFROM, to_Char(CLASSTIMEFROMX,'dd-mm-yyyy') CLASSTIMEFROMX   , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,'Tutorial' LTP,EMPLOYEENAME from ( ";
		 qry1=" select distinct CLASSTIMEFROM , CLASSTIMEFROM CLASSTIMEFROMX, ATTENDANCETYPE, 'N' PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME   from V#STUDENTATTENDANCE a where SubjectID= '"+mSubj+"'  and LTP='P' and EXAMCODE= '"+mExam+"'  AND  ( A.FSTID='"+mPFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+mExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubj+"' and  b.LTP='P' and B.FSTID='"+mPFSTID+"'  )))  ";
		 qry1=qry1+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
		  qry1=qry1+" and trunc(a.classtimefrom)<  NVL((  SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubj+"'  and c.LTP='P' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
		qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)< NVL(( SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubj+"'  and c.LTP='P' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ) ,a.classtimefrom)";
		qry1=qry1+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
		qry1=qry1+"   or ("+QrySem+">1)            ";

		qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))  ) ";
		 //System.out.println(qry1);

		  qry2=" select distinct CLASSTIMEFROM , CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE,  'N'  PRESENT,ENTRYBYFACULTYNAME  EMPLOYEENAME from V#StudentAttendance  a where SubjectID= '"+mSubj+"'  and LTP='P' and EXAMCODE=  '"+mExam+"' ";
		qry2=qry2+"  AND  A.FSTID='"+prevPFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
		qry2=qry2+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubj+"' and c.studentid='"+mMemberID+"' ";
		qry2=qry2+"  and c.LTP='P' and c.EXAMCODE=  '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevPFSTID+"' )";
	  qry2=qry2+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubj+"'  and c.LTP='P' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
		qry2=qry2+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry2=qry2+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
					qry2=qry2+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
		qry2=qry2+"   or ("+QrySem+">1)        )    ";

		//out.print(qry2);

		  qry3="SELECT distinct CLASSTIMEFROM , CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubj+"' and EXAMCODE= '"+mExam+"' AND      a.ltp='P' and a.studentid='"+mMemberID+"'   ";
		qry3=qry3+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
		qry3=qry3+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
		qry3=qry3+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
		qry3=qry3+" UNION   ";
		qry3=qry3+" select  distinct CLASSTIMEFROM , CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,(select EMPLOYEENAME from V#Staff v where v.employeeid=sp1.employeeid and rownum=1) EMPLOYEENAME from STUDENTPREVATTENDENCE sp1 where  subjectid ='"+mSubj+"'     AND ltp ='P'    ";
		qry3=qry3+" AND examcode =  '"+mExam+"'   AND studentid = '"+mMemberID+"'   ";
		qry3=qry3+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'";
		qry3=qry3+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
		qry3=qry3+" and trunc(sp1.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry3=qry3+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
					qry3=qry3+"  and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";

//		out.print(qry3);

		  qry4="SELECT distinct CLASSTIMEFROM , CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,ENTRYBYFACULTYNAME EMPLOYEENAME from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubj+"' and EXAMCODE= '"+mExam+"' AND    a.ltp='P' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
		qry4=qry4+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
			qry4=qry4+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
		qry4=qry4+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
		qry4=qry4+" UNION   ";
		qry4=qry4+" select  distinct CLASSTIMEFROM , CLASSTIMEFROM CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N') PRESENT,(select EMPLOYEENAME from V#Staff v where v.employeeid=sp1.employeeid  and rownum=1) EMPLOYEENAME from STUDENTPREVATTENDENCE sp1 where  subjectid ='"+mSubj+"'     AND ltp ='P'    ";
		qry4=qry4+" AND examcode =  '"+mExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";  qry4=qry4+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'";
		qry4=qry4+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
		qry4=qry4+" and trunc(sp1.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry4=qry4+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',sp1.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
					qry4=qry4+"  and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
		 // out.print(qry4);
		//Finally Merging Queries -----------           <===================( select )===================>
	   }
		if(mLTP.equals("P"))
		   {

			QryMainP=QryMainP+" ("+qry1+") union ("+qry2+") union ("+qry3+") union ("+qry4+") ) group by  CLASSTIMEFROM,CLASSTIMEFROMX , ATTENDANCETYPE, nvl(PRESENT,'N'),'Tutorial',EMPLOYEENAME order by to_date(CLASSTIMEFROM,'dd-mm-rrrr hh:mi am')  ";
			//out.print(QryMainP);
			rs1=db.getRowset(QryMainP);
		   }



///out.print(QryMainT);

 mSNO=0;


		while(rs1.next())
		{
		mSNO++;

		if(rs1.getString("ATTENDANCETYPE").equals("R"))
			mCtype="Regular";
		else
			mCtype="Extra";


			if(rs1.getString("PRESENT").equals("Y"))
			{
				mStatus="Present";
				mColor="Green";
			}
			else
			{


qertu=" select 'Y' from ATTENDANCESPECIALAPPROVAL where INSTITUTECODE ='"+mINSTITUTECODE+"'  and EXAMCODE ='"+mExam+"' and SUBJECTID ='"+mSubj+"' and STUDENTID ='"+mMemberID+"'  and  ((TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') BETWEEN FROMPERIOD AND TOPERIOD ) OR (TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')                BETWEEN FROMPERIOD AND TOPERIOD ) OR (FROMPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')) OR (TOPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')))      ";







rsqertu=db.getRowset(qertu);
 //out.println(qertu);
if(rsqertu.next()){

mStatus="Special Approval";
				mColor="darkblue";


}else{

mStatus="Absent";
				mColor="RED";


}
			}

			%>
			<tr>
			<td align=center NOWRAP><%=mSNO%>.</td>
			<td align=center NOWRAP><%=rs1.getString("CLASSTIMEFROM")%></td>
			<td align=center NOWRAP><%=rs1.getString("EMPLOYEENAME")%></td>
			<td align=center NOWRAP><font color=<%=mColor%>><B><%=mStatus%></B></font></td>
				<td><%=mCtype%></td>
            <%
            if(mLTP.equals("LT"))
            {

		if(rs1.getString("LTP").equals("Lecture"))
				{
				mColor1="Blue";
				}
				else
				{
					mColor1="Black";
				}
            %>
            <td align=center Title=""><b><font color="<%=mColor1%>"><%=rs1.getString("LTP")%></font></b></td>
            <%
            }
		    %></tr>
			 <%


	}
%>
</tbody>
</TABLE>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","Number"]);
</script>

<%
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
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{

}
%>
</body>
</html>