<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
String qry="",qryV="",mWebEmail="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();



GlobalFunctions gb =new GlobalFunctions();
int penaltyTime=0,i=0;
ResultSet rs=null, Rs=null,rss=null, rs1=null;
String mWorkDate="",qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mCurDate="", mHeading="", mFaculty="", mDeptCode="", mMemID="",startday="",halfday="",empType="";
String mDateFrom="",mCurFDate="",mDateTo="",mEmpName="",mCompCode="",mInst="", mRightsID="", mSRCType="",mCDate="",mWAIVER="",wDate="";

qry="select 26 ||'-'|| (to_Char(Sysdate,'MM')-01 )||'-'||to_Char(Sysdate,'YYYY') date3 ,to_Char(Sysdate,'dd-mm-yyyy')date1, to_Char(Sysdate,'yyyymmdd')date2 from dual";
rs=db.getRowset(qry);
rs.next();
mCurDate=rs.getString("date1");
mCurFDate=rs.getString("date3");
mCDate=rs.getString("date2");

//out.print(mCDate);

try
{
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mCompCode="";
}
else
{
	mCompCode=session.getAttribute("CompanyCode").toString().trim();
}
//out.println(mCompCode);

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

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}


if (session.getAttribute("InstPersonal")!=null)
{
	mInst=session.getAttribute("InstPersonal").toString().trim();
}

//out.print(mInst);

if (session.getAttribute("DepartmentCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
}



//out.print(mDeptCode);
String mHead="",mInstCode="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";

if(request.getParameter("SRCType")==null)
	mSRCType="I";
else
	mSRCType=request.getParameter("SRCType").toString().trim();

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Employee Penalty Attendance Detail] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
</head>
<body  topmargin=4 rightmargin=0 leftmargin=0 bottommargin=0 bgColor="#fce9c5">
<%
	//System.out.println ("=======++++++++++==========");
if(!mMemberID.equals("") || !mMemberCode.equals(""))
{

	mMemberID=enc.decode(mMemberID);
	mMemberCode=enc.decode(mMemberCode);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
   // out.print(mRole +"------"+mChkMemID);
	String  LoginIDTime="";
	HttpSession sess = request.getSession();
	LoginIDTime= sess.getId();

	if(LoginIDTime.length() >= 20)
		LoginIDTime=LoginIDTime.substring(0,20);
	//out.println(LoginIDTime);


		mRightsID="269";
		mHeading="Employee Penalty Attendance Detail";

	//out.print(" - - - - "+mRightsID);

	qryV= " select EMPLOYEETYPE from employeemaster where EMPLOYEEID='"+mChkMemID+"'";
	rss=db.getRowset(qryV);
		if(rss.next())
		{
			empType=rss.getString("EMPLOYEETYPE");
		//out.print(empType);

		}

	qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	RsChk= db.getRowset(qry);
	//out.print(qry);
	if (RsChk.next() )
	{

		qry="SELECT COMPANYCODE,EMPLOYEENAME FROM EMPLOYEEMASTER where EMPLOYEEID='"+mChkMemID+"' and COMPANYCODE='"+mCompCode+"' ";
		//out.println(qry);
		rs=db.getRowset(qry);
		if(rs.next())
		{
			mEmpName=rs.getString("EMPLOYEENAME");


		}

		%>
		<form name="frm"  method="post" >
		<input id="x" name="x" type=hidden>
		<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><%=mHeading%></font></TD>
		</font></td></tr>
		</TABLE>
		<%
		if (request.getParameter("x")!=null)
		{
			mDateFrom=request.getParameter("DATE1").toString().trim();
			mDateTo=request.getParameter("DATE2").toString().trim();
		}
		else
		{
			mDateFrom=mCurDate;
			mDateTo=mCurDate;
		}
		%>
		<TABLE rules=none cellSpacing=1 cellPadding=4 border=2 align=center width=70%>
		<tr><td nowrap>
		<FONT color=black face=Arial size=2><b>Employee &nbsp;</b></FONT>
		<%

			qry=" Select Distinct  A.EmployeeId FacultyID, nvl(A.EMPLOYEENAME,' ') EmployeeName ";
			qry=qry+" from V#STAFF A where A.COMPANYCODE IN (SELECT nvl(COMPANYTAGGING,' ')COMPANYCODE FROM INSTITUTEMASTER WHERE INSTITUTECODE='"+mInst+"') and A.EmployeeId ='"+mChkMemID+"' order by EmployeeName";
		//out.print(qry);
		rs=db.getRowset(qry);
		%>
		<select name=Faculty tabindex="0" id="Faculty">
		<%
		if (request.getParameter("x")==null)
		{
			while(rs.next())
			{
				if(mFaculty.equals(""))
				{
					mFaculty=rs.getString("FacultyID");
				  	%>
					<OPTION Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
				  	<%
				}
				else
				{
					%>
					<OPTION Value ='<%=rs.getString("FacultyID")%>'><%=rs.getString("EmployeeName")%></option>
		 			<%
				}
			}
		}
		else
		{
			while(rs.next())
			{
				mFaculty=rs.getString("FacultyID");
				if (mFaculty.equals(request.getParameter("Faculty").toString().trim()))
				{
					%>
					<OPTION selected Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
					<%
				}
				else
				{
					%>
					<OPTION Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
					<%
				}
			}
		}
	%>
	</select>
	<font color=black face=arial font size=2><b>&nbsp; &nbsp; Attendance From</b></font><font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font></td>
	<td><INPUT TYPE="text" NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE='<%=mCurFDate%>' readonly
	><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
	</td><td><b>&nbsp;To&nbsp;</b></td>
	<td><INPUT TYPE="text" NAME=DATE2 ID=DATE2 size=9 tabindex=2
	VALUE='<%=mDateTo%>' readonly><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;</td>
	<TD><INPUT TYPE="submit"  VALUE="Show"></TD>
	</tr>
	</table>
	</form>
	<%



	if (request.getParameter("x")!=null)
	{
		if(request.getParameter("Faculty")==null)
			mFaculty="";
		else
			mFaculty=request.getParameter("Faculty").toString().trim();

		if(request.getParameter("DATE1")==null)
			mDateFrom="";
		else
			mDateFrom=request.getParameter("DATE1").toString().trim();

		if(request.getParameter("DATE2")==null)
			mDateTo="";
		else
			mDateTo=request.getParameter("DATE2").toString().trim();

		db.WeekReg4JSP(mDateFrom,mDateTo,mChkMemID,mChkMType,mCompCode,LoginIDTime,"Y","Y","Y","Y","Y","Y","Y","Y",mInst,"Y");

		%>
		<table ALIGN=CENTER bottommargin=0  topmargin=0 WIDTH="100%">
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><u>Available List</u> </TD>
		</font></td>
		</table>
		<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center    WIDTH="50%">
		<thead>
		<tr bgcolor="#ff8c00">
		<td align=center nowrap><font color=white><B>Working Date</B></font></td>

		<td align=center nowrap><font color=white><B>IN Time</B></font></td>
	<td align=center nowrap><font color=white><B>OUT Time</B></font></td>


		<td align=center nowrap><font color=white><B>Remarks </B></font></td>



		</tr>
		</thead>
		<tbody>
		<%

//try{

int mPInTime=0,mPOutTime=0,mHalfDayTime=0,mInMaxTime=0,mOutMaxTime=0;
int mIngtime=0,mOutgtime=0,mAInTime=0,mAOutTime=0,mAHalfDayTime=0;
String mHalfDay="";


//PARAMETER TABLE ..... ....
	qry="SELECT    nvl((to_char(INTIME,'HH24MI') + INGRACETIME),0)INGRACE  , nvl( TO_CHAR(outtime - (.000694 * outgracetime),'hh24mi'),0) OUTGRACE,  nvl(TO_CHAR(HALFDAYTIME,'HH24MI'),0)HALFDAYGRACE,nvl( (TO_CHAR (halfdaytime, 'HH24MI')-outgracetime) ,0) halfdaytime1,TO_CHAR(INTIME,'HH24MI') INTIME  ,   TO_CHAR( OUTTIME,'HH24MI')OUTTIME ,  nvl(INMAXIMUMATTEMPTS,0)INMAXIMUMATTEMPTS ,    nvl(OUTGRACETIME,0)OUTGRACETIME , HALFDAY, HALFONSTARTDAYENDDAY,   nvl( OUTMAXIMUMATTEMPTS,0)OUTMAXIMUMATTEMPTS FROM ATT#PARAMETERS where COMPANYCODE ='"+mCompCode+"'   AND  INSTITUTECODE='"+mInst+"'  ";
//out.print(qry);
	rs=db.getRowset(qry);
	if(rs.next())
		{

			mPInTime= rs.getInt("INGRACE") ;
			mPOutTime=rs.getInt("OUTGRACE") ;

			mAInTime= rs.getInt("INTIME") ;
			mAOutTime=rs.getInt("OUTTIME") ;



		mHalfDayTime=rs.getInt("HALFDAYGRACE");
		mAHalfDayTime= rs.getInt("halfdaytime1");




		mHalfDay=rs.getString("HALFDAY");

mInMaxTime=rs.getInt("INMAXIMUMATTEMPTS");

mOutMaxTime=rs.getInt("OUTMAXIMUMATTEMPTS");

//out.print(mPInTime+" cccc ");

		}


String mssDay="";




//out.print(mPInTime+" 999999999 ");
//}
//catch (Exception e)
//		{
//			out.print(e);
	//	}




int nointime=0, noouttime=0,mSpecialCase=0,mLeave=0;
String mSatDay="",qry2="",qry3="",mWorkDate1="";
ResultSet rs2=null,rs3=null;

	String qry4="",mDayss="";
	ResultSet rs4=null;
		int mVacation=0;

		qry="SELECT  MEMBERID, to_char(WORKINGDATE,'dd-mm-yyyy')WORKINGDATE, to_char(WORKINGDATE,'yyyymmdd')WORKINGDATE1,nvl(LEAVESTATUS,'N')LEAVESTATUS,COMPANYCODE,MEMBERTYPE,LOGINCARDIDTIME FROM ATT_TEMPWEEKREC where  MEMBERID='"+mFaculty+"' and COMPANYCODE='"+mCompCode+"'  and MEMBERID IN (SELECT EMPLOYEEID FROM EMPLOYEEMASTER WHERE NVL(DEACTIVE,'N')='N') and LOGINCARDIDTIME='"+LoginIDTime+"' and trunc(WORKINGDATE) between trunc(decode(to_date('"+mDateFrom+"','dd-mm-yyyy'),'',WORKINGDATE,to_date('"+mDateFrom+"','dd-mm-yyyy'))) and trunc(decode(to_date('"+mDateTo+"','dd-mm-yyyy'),'',WORKINGDATE,to_date('"+mDateTo+"','dd-mm-yyyy')))  order by to_date(workingdate, 'dd-mm-yyyy')";

		rs=db.getRowset(qry);
		while(rs.next())
		{//out.println (qry+"<br><br>");
			mWorkDate=rs.getString("WORKINGDATE");

//for sunday
			qry1="select to_char(to_date('"+mWorkDate+"','dd-mm-yyyy'),'day')dayss from dual ";
			rs1=db.getRowset(qry1);
				if(rs1.next())
			{
					mDayss=rs1.getString("dayss").toString().trim();
			}

			//out.print(mDayss+"::"+mWorkDate+"LL"+ !mDayss.equals("sunday") );




			mWorkDate1=rs.getString("WORKINGDATE1");

	//OTHER  DUTY		 IF ANY  (to_char(INTIME,'HH24MI') + INGRACETIME)INGRACE  , TO_CHAR(outtime - (.000694 * outgracetime),'hh24mi')OUTGRACE,
qry2="SELECT DISTINCT a.membercode, a.employeename, a.designation,                                TO_CHAR (b.intime, 'hh:mi PM') intime,                NVL (TO_CHAR (b.outtime, 'HH:MI PM'), ' ') outtime,                NVL (TO_CHAR (b.intime, 'hh24mi'), '0') ingtime,                NVL (TO_CHAR (b.outtime, 'HH24MI'), '0') outgtime ,to_char(to_date('"+mWorkDate+"','dd-mm-yyyy'),'Day')ssDay ,					 TO_CHAR (b.satintime, 'hh24mi') satintime,                NVL (TO_CHAR (b.satouttime, 'hh24mi'), ' ') satouttime	  , nvl((TO_CHAR (b.intime, 'HH24MI') + b.ingracetime),0) ingrace,       nvl(TO_CHAR (b.outtime - (.000694 * b.outgracetime), 'hh24mi'),0) outgrace			           FROM ATT#OTHERDUTYTIMING b, v#allmembers a          WHERE b.institutecode = a.institutecode            AND a.institutecode = '"+mInst+"'            AND a.memberid = b.userid            AND a.membertype = b.usertype            AND a.membertype = 'E'            AND a.memberid ='"+mFaculty+"'                     and  trunc(to_date('"+mWorkDate+"','dd-mm-yyyy')) >= trunc(b.FROMDATE)          and trunc(to_date('"+mWorkDate+"','dd-mm-yyyy')) <=trunc(b.TODATE)";

	//
	rs2=db.getRowset(qry2);
	if(rs2.next())
		{//out.print(qry2+"<br><br>");

			//mPInTime= rs2.getInt("ingtime") ;
		//	mPOutTime=rs2.getInt("outgtime") ;

				mPInTime= rs2.getInt("INGRACE") ;
			mPOutTime=rs2.getInt("OUTGRACE") ;
	//	out.print(mPInTime+"mPInTime"+"<br>");

			mAInTime= rs2.getInt("ingtime") ;
			mAOutTime=rs2.getInt("outgtime") ;



			if(mPInTime==0)
					mPInTime=mAInTime;

			if(mPOutTime==0)
					mPOutTime=mAOutTime;

		mssDay=rs2.getString("ssDay").toString().trim().toUpperCase();
		//mHalfDay=rs.getString("HALFDAY");

			if(mssDay.equals("SATURDAY"))
			{
					mAInTime= rs2.getInt("satintime") ;
			mAOutTime=rs2.getInt("satouttime") ;
			mHalfDayTime=rs2.getInt("satouttime") ;

			mAHalfDayTime=mHalfDayTime;
			}

		}

	// special case
	qry3="SELECT 'Y'  FROM ATT#SPECIALGRACE WHERE USERID  ='"+mFaculty+"' AND USERTYPE='E' AND institutecode = '"+mInst+"' AND trunc(to_date('"+mWorkDate+"','dd-mm-yyyy')) >= trunc(FROMDATE)          and trunc(to_date('"+mWorkDate+"','dd-mm-yyyy')) <=trunc(TODATE)  ";
	rs3=db.getRowset(qry3);
	if(rs3.next())
			{
				mSpecialCase=1;
			}
			else
			{
				mSpecialCase=0;
			}

	if(!empType.equals("NTEC"))
			{
	//vACATION DATE
	 qry4="SELECT  'Y' FROM VACATIONDATES where INSTITUTECODE='"+mInst+"'   AND trunc(to_date('"+mWorkDate+"','dd-mm-yyyy')) >= trunc(FROMDATE)          and trunc(to_date('"+mWorkDate+"','dd-mm-yyyy')) <=trunc(TODATE)   ";
	// out.print(qry4);
	rs4=db.getRowset(qry4);
	if(rs4.next())
			{
				mVacation=1;
			}
			else
			{
				mVacation=0;
			}

			}
	 qry1="SELECT  'Y' FROM leavetransaction where EMPLOYEEID='"+mFaculty+"'   AND trunc(to_date('"+mWorkDate+"','dd-mm-yyyy')) >= trunc(STARTDATE)          and trunc(to_date('"+mWorkDate+"','dd-mm-yyyy')) <=trunc(ENDDATE)   ";
	// out.print(qry4);
	rs1=db.getRowset(qry1);
	if(rs1.next())
			{
				mLeave=1;
			}
			else
			{
				mLeave=0;
			}
				//	out.print(!mWorkDate1.equals(mCDate) +"sss" );
				//mCDate="20120216";

//	out.print("nointime"+nointime+"<br>");

			%>
			<tr>
			<td>
			<%=rs.getString("WORKINGDATE")%></td>
			<%
				qry1="select distinct nvl(b.WAIVER,'N')WAIVER ,a.MemberCode, a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),'---')OUTTIME,nvl(to_char(b.INTIME,'hh24mi') ,'0') InGTime,nvl(to_char(OUTTIME,'HH24MI'),'0')OUTGTIME, to_char(to_date('"+mWorkDate+"','dd-mm-yyyy'),'Day')sDay from  ATT_ATTENDLOG  b, v#allmembers a    where b.InstiTuteCode=a.InstituteCode and a.InstituteCode='"+mInst+"'   and a.MEMBERID=b.USERID  and a.MemberType= b.USERTYPE and     a.MemberType='E'  and A.MEMBERID='"+mFaculty+"'      AND B.WORKINGDATE =TO_DATE ('"+mWorkDate+"','dd-mm-yyyy' ) ";
			//and  b.workhrs_minute <>0 ";
				//out.println (qry1+"<br>");
			rs1=db.getRowset(qry1);
			rs2=db.getRowset(qry1);
			if(rs1.next())
			{


				mWAIVER=rs1.getString("WAIVER");
			    mIngtime=rs1.getInt("InGTime");
				mOutgtime=rs1.getInt("OUTGTIME");

				mSatDay=rs1.getString("sDay").toString().trim().toUpperCase();

				startday=mWorkDate.substring(0,2);
				//out.print(mWorkDate+"-----"+mIngtime + "---" +mPInTime +"-----" + mAInTime);
	//out.print((nointime!=-1)+"@@@@"+ (noouttime!=-1)+"####"+( mVacation!=1) +"$$$$$"+(mLeave!=1) +"%%%%%"+(mSpecialCase!=1) +"^^^^"+ (!mWorkDate1.equals(mCDate)) +"####"+(!mDayss.equals("sunday"))+"^^^^^"+( !mWAIVER.equals("Y")));
	//out.print(nointime+"---"+noouttime+"-----"+mVacation+"-----"+ mLeave+"-------"+ mSpecialCase+"----"+mWorkDate1+"-----"+mDayss+"------"+mWAIVER );
				if(nointime!=-1 && noouttime!=-1 && mVacation!=1 && mLeave!=1 && mSpecialCase!=1 && !mWorkDate1.equals(mCDate) && !mDayss.equals("sunday") && !mWAIVER.equals("Y") )
				{
				//out.print(mIngtime+"@@@@@"+mPInTime);
				//out.print("BEFOREIFBLOCK");
				if (mIngtime > mPInTime  )
					{
						halfday="halfday";
						//
				//penaltyTime=1;
				//
					}
					else
					{//out.print(mIngtime+"@@@@"+mPInTime+"####"+mAInTime+"^^^"+mDayss+"<br>");
				halfday="";
				nointime=nointime;
                // out.print("BEFOREPRINT"+nointime );
				if( (mIngtime < mPInTime ) &&  (mIngtime > mAInTime)  )
				{
					// out.print("BEFOREPRINT");
					++nointime;
					//out.print(nointime+"HELLO_________");
if(Integer.parseInt(startday)>26&&Integer.parseInt(startday)<=31)
	{
if( (mIngtime < mPInTime ) &&  (mIngtime > mAInTime)  )
				{
					++i;
				}
	nointime=i;


	}
//out.print(Integer.parseInt(startday));
if(nointime>5&&(Integer.parseInt(startday)==26))
{
nointime=0;
}

				//out.print(mWorkDate1+" -- "+nointime+" I --- N"+noouttime +" --- "+mIngtime+" -- "+mPInTime +" -- "+mAInTime+"<br>" );

					//out.print(mWorkDate1+" --- "+mInMaxTime+"ss"+ mOutMaxTime +":nointime:"+nointime+":noouttime:"+noouttime+":::"+mPInTime+":::mPOutTime"+mPOutTime);
				}

					}
				//out.print("@@@"+halfday);

				if(mSatDay.equals(mHalfDay))
				{//out.print("####"+mSatDay+"<br>");

					if(mOutgtime < mAHalfDayTime&&(!mSatDay.equals("SATURDAY")))
					{
						halfday="halfday";
				//out.print(noouttime);//out.print("HiMohit");
					}
					else
					{
						//out.print((mOutgtime)+"OUT"+(mHalfDayTime)+"IN"+mAHalfDayTime );

						//out.print("OUT");
						if( (mOutgtime  >  mAHalfDayTime ) && (mOutgtime < mHalfDayTime  ) )
						{

							++noouttime;

									//	out.print("IN");

									//out.print(mWorkDate1+" - 3 - "+nointime+" --- "+noouttime);
						}
					}
				}
				else
				{
//out.print("Gyan");

					if(mOutgtime < mPOutTime &&(!mSatDay.equals("SATURDAY")))
					{
					halfday="halfday";
					//	out.print(mOutgtime+"Gyan"+mPOutTime+"<br>");
					}
					else
					{halfday="";

						if((mOutgtime < mPOutTime ) && (mOutgtime > mAOutTime))
						{
							++noouttime;
							//out.print("HiMohit");

							//out.print(mWorkDate1+" --1---- "+nointime+"IN"+noouttime);
						}
					}

					//mSatDay="";
				}
				}





				%>
				<td nowrap align=center>&nbsp;<%=rs1.getString("InTime")%></td>
			<td nowrap align=center>&nbsp;<%=rs1.getString("OutTime")%></td>
				<%
			}
				else

			{
				wDate=rs.getString("WORKINGDATE");
				out.print("HELLO" + wDate);

				%>

				<td nowrap align=center>&nbsp;--- </td>
			<td nowrap align=center>&nbsp;--- </td>
				<%
			//String wDate=rs.getString("WORKINGDATE");
			//String str=rs.getString("LEAVESTATUS");
					//when mIngtime and mOutgtime is null then
              //out.print("PRINT"+wDate+"---gggggg-----"+str+"--ggggg--"+mSpecialCase+"---gggg---"+nointime+"--gggggg------"+noouttime+"---gggg--"+mVacation+"---gggggg--"+ mLeave+"---gggg----"+ mSpecialCase+"-ggggg---"+mWorkDate1+"--ggggg---"+mDayss+"--gggggg----"+mWAIVER );
				 if(rs.getString("LEAVESTATUS").equals("N") && mSpecialCase!=1  && mVacation!=1 && !mDayss.equals("sunday") && mLeave!=1 &&  !mWAIVER.equals("Y") )
				{
                                          wDate=rs.getString("WORKINGDATE");
										  out.print("HELLO" + wDate);
						++nointime;

						++noouttime;
							//out.print(mWorkDate1+" -- "+nointime+"IN"+noouttime);
				}


			}





//out.print("LLLLLL"+mSatDay.equals("SATURDAY"));
//out.print(mInMaxTime+"<<InmaxTime,"+mOutMaxTime+"<<mOutMaxTime"+mIngtime+"<<mIngtime,"+mOutgtime+"<mOutgtime,"+nointime+"<<nouttime,"+noouttime+"<<noouttime,"+mPInTime+"<< mPInTime,"+mPOutTime+"<<mPOutTime,"+mSpecialCase+"<<mSpecialCase,"+mVacation+"<<mVacation,"+mWorkDate1+"<<mWorkDate1,"+mDayss+"<<mDayss,"+mLeave+"<<<mLeave,"+mWAIVER+"<<mWAIVER");

//20150410 --- 5ss5:nointime:6:noouttime:0:::930:::mPOutTime1630  5 5
////out.print("CONDITION 1 : "+(mInMaxTime <= nointime)+"Condition 2 : "+(mOutMaxTime <= noouttime)+"Condition 3 :"+ (mSpecialCase!=1)+"Condition 4 : "+( mSpecialCase!=1)+" Condition 5 : "+!mWorkDate1.equals(mCDate)+"Condition 6  : "+(mVacation!=1)+" Condition 7 : "+(!mDayss.equals("sunday"))+" Condition 8 :"+(mLeave!=1)+"Condition 9 : "+(!mWAIVER.equals("Y"))+"<br><br>");
 /*if((penaltyTime==1))
				{*/%>
				 <!--td align=center><font color=red size=2><b>-456PENALITY-</b></font-->
				<%
				//penaltyTime=0;}else
				//out.print((mInMaxTime +"@@@"+nointime+"<br>"));


//out.print(((mInMaxTime +"######"+ nointime))+"<br>");

			 if ( ((mInMaxTime < nointime) ||  (mOutMaxTime < noouttime) &&  mSpecialCase!=1  && !mWorkDate1.equals(mCDate) && mVacation!=1 && !mDayss.equals("sunday") && mLeave!=1 && !mWAIVER.equals("Y")))
			{
				//	if(mInMaxTime==nointime ||   ( mOutMaxTime==noouttime) )
				//	{
//out.print(mInMaxTime+"<<InmaxTime,"+mOutMaxTime+"<<mOutMaxTime"+mIngtime+"<<mIngtime,"+mOutgtime+"<mOutgtime,"+nointime+"<<nouttime,"+noouttime+"<<noouttime,"+mPInTime+"<< mPInTime,"+mPOutTime+"<<mPOutTime,"+mSpecialCase+"<<mSpecialCase,"+mVacation+"<<mVacation,"+mWorkDate1+"<<mWorkDate1,"+mDayss+"<<mDayss,"+mLeave+"<<<mLeave,"+mWAIVER+"<<mWAIVER");
 //out.print(mSpecialCase+"***"+"CDATE>>"+mCDate+"WorkDate1>>"+mWorkDate1+" --- "+mInMaxTime+"ss"+ mOutMaxTime +":nointime:"+nointime+":noouttime:"+noouttime+":::"+mPInTime+":::mPOutTime"+mPOutTime);
					%>
					  <td align=center><font color=red size=2><b>-PENALITY-</b></font>

                      <%
                      //out.print(mWorkDate1+" --- "+mInMaxTime+"ss"+ mOutMaxTime +":nointime:"+nointime+":noouttime:"+noouttime+":::"+mPInTime+":::mPOutTime"+mPOutTime);
                      %>

                      </td>
					<%
					nointime=-1;
					noouttime=-1;

				//}
			}

//		else if( (mPInTime < mIngtime)  || if(mPOutTime > mOutgtime) )
//when nointime is < 5  noouttime <5
else if(nointime==-1 && noouttime==-1 &&  (rs.getString("LEAVESTATUS").equals("P")) &&  mSpecialCase!=1 && !mWorkDate1.equals(mCDate) && mVacation!=1 && !mDayss.equals("sunday") && mLeave!=1 && !mWAIVER.equals("Y"))
			{
	//out.print(mPOutTime+" -- "+mOutgtime+"<br>");

				 if(mPInTime < mIngtime)
					{
					%>
					  <td align=center><font color=red size=2><b>-PENALITY-</b></font></td>
					<%
					}
					else
					{


						if(mSatDay.equals(mHalfDay))
						{
							//out.print("LLLLLL"+mSatDay);
							//	out.print(mAHalfDayTime+"mWorkDate"+mHalfDayTime+"PENALITY::"+mOutgtime+( mOutgtime < mAHalfDayTime		));
							if( mOutgtime < mAHalfDayTime )
							//	if( (mOutgtime  >  mAHalfDayTime ) && (mOutgtime < mHalfDayTime  ) )
							{
						%>
						  <td align=center><font color=red size=2><b>-PENALITY-</b></font></td>
						<%
							}
						else
							{
							%>
						  <td align=center><font color=red size=2><b>----</b></font></td>
						<%
							}
							//mSatDay="";
						}
						else //if(!mSatDay.equals(mHalfDay))
						{
							if (mPOutTime > mOutgtime )
							{
								%>
							<td align=center><font color=red size=2><b>-PENALITY-</b></font></td>
							<%
							}
								else
							{
								%>

								<td align=center><font color=black size=2><b>----</b></font></td>
								<%
							}

						}

					}

				//rs.getString("LEAVESTATUS").equals("F/H")
			}

		else if((rs.getString("LEAVESTATUS").equals("P") ||  rs.getString("LEAVESTATUS").equals("F/H"))&&(!halfday.trim().equals("halfday") ) )
			{
			%>

			<td align=center><font color=black size=2><b>----</b></font></td>
			<%
			}%><%else if((rs.getString("LEAVESTATUS").equals("P")|| rs.getString("LEAVESTATUS").equals("F/H"))&&(halfday.trim().equals("halfday")))
				{
               if(mIngtime ==0 ||  mOutgtime == 0 )
               {
                   %>
                    <td align=center><font color=brown size=2><b>HALF DAY ABSENT</b></font></td>
                   <%
                }
                else{ %>
			<td align=center><font color=brown size=2><b>HALF DAY</b></font></td>
            <%}%>
			<%halfday=""; }
			else if(rs.getString("LEAVESTATUS").substring(0,1).equals("F")  && (!mSatDay.equals("SATURDAY"))&&(!rs.getString("LEAVESTATUS").equals("F/T")))
			{
			%>

			<td align=center><font color=brown size=2><b>HALF DAY</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("A"))
			{
			%>
			<td align=center><font color=red size=2><b>ABSENT</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("W"))
			{
			%>

			<td align=center><font color=yellow size=2><b>LWP</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("O"))
			{
			%>

			<td align=center><font color=purple size=2><b>WEEKLY OFF</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("IN"))
			{
			%>
			<td align=center><font color=mazenta size=2><b>CURRENT DAY</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("L"))
			{
			%>

			<td align=center><font color=#EE82EE size=2><b>LEAVE</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("H") ||  mDayss.equals("sunday"))
			{
			%>

			<td align=center><font color=GREEN size=2><b>HOLIDAY</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").equals("V")  )
			{   //||  mVacation==1
			%>

			<td align=center><font color=#0a0403 size=2><b>VACATION</b></font></td>
			<%
			}
			else if((rs.getString("LEAVESTATUS").equals("T"))||(rs.getString("LEAVESTATUS").equals("F/T")))
			{
			%>

			<td align=center><font color=#ff4443 size=2>TOUR</font></td>
			<%
			}
			else
			{
					%>

			<td align=center><font  size=2>---</font></td>
			<%
			}
			%>
			 </tr>
			 <%
		}
		%>
		</tbody>
		</table>
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
	<h3>	<br><img src='.../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}//end of try
catch(Exception e)
{
	//out.println(e.getMessage());
}

%>

</body>
</Html>
