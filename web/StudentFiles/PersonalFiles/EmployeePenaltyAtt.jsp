<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  
String qry="",mWebEmail="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

GlobalFunctions gb =new GlobalFunctions();

ResultSet rs=null, Rs=null, rs1	=null;
String mWorkDate="",qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mCurDate="", mHeading="", mFaculty="", mDeptCode="", mMemID="";
String mDateFrom="",mDateTo="",mEmpName="",mCompCode="",mInst="", mRightsID="", mSRCType="",mCDate="";

qry="select to_Char(Sysdate,'dd-mm-yyyy')date1, to_Char(Sysdate,'yyyymmdd')date2 from dual";
rs=db.getRowset(qry);
rs.next();
mCurDate=rs.getString("date1");
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

	String  LoginIDTime="";
	HttpSession sess = request.getSession();
	LoginIDTime= sess.getId();

	if(LoginIDTime.length() >= 20)
		LoginIDTime=LoginIDTime.substring(0,20);
	//out.println(LoginIDTime);

	
		mRightsID="185";
		mHeading="Employee Penalty Attendance Detail";
	
	//out.print(" - - - - "+mRightsID);

	qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	RsChk= db.getRowset(qry);
	//out.print(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
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
	<td><INPUT TYPE="text" NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE='<%=mDateFrom%>' readonly
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
		<table ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><u>Available List</u> </TD>
		</font></td>	
		</table>
		<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center  >
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
	qry="SELECT    (to_char(INTIME,'HH24MI') + INGRACETIME)INGRACE  , TO_CHAR(outtime - (.000694 * outgracetime),'hh24mi')OUTGRACE,  TO_CHAR(HALFDAYTIME,'HH24MI')HALFDAYGRACE,(TO_CHAR (halfdaytime, 'HH24MI')-outgracetime) halfdaytime1,TO_CHAR(INTIME,'HH24MI') INTIME  ,   TO_CHAR( OUTTIME,'HH24MI')OUTTIME ,  INMAXIMUMATTEMPTS,    OUTGRACETIME, HALFDAY, HALFONSTARTDAYENDDAY,    OUTMAXIMUMATTEMPTS FROM ATT#PARAMETERS where COMPANYCODE ='"+mCompCode+"'   AND  INSTITUTECODE='"+mInst+"'  ";
//	out.print(qry);
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

		}


String mssDay="";




//out.print(mPInTime);
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
	//out.println (qry);
		rs=db.getRowset(qry);
		while(rs.next())
		{
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
	
	//out.print(qry2);
	rs2=db.getRowset(qry2);
	if(rs2.next())
		{
			
			//mPInTime= rs2.getInt("ingtime") ;
		//	mPOutTime=rs2.getInt("outgtime") ;
		
				mPInTime= rs2.getInt("INGRACE") ;
			mPOutTime=rs2.getInt("OUTGRACE") ;
		//out.print(mPInTime+"mPInTime");
			
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

		//out.print(rs.getString("LEAVESTATUS"));

			%>
			<tr>
			<td>
			<%=rs.getString("WORKINGDATE")%></td>
			<%
				qry1="select distinct a.MemberCode, a.EmployeeName,a.Designation, to_char(b.WORKINGDATE,'dd-Mon-yyyy') WORKINGDATE, to_char(b.INTIME,'hh:mi PM') InTime, nvl(to_char(OUTTIME,'HH:MI PM'),'---')OUTTIME,nvl(to_char(b.INTIME,'hh24mi') ,'0') InGTime,nvl(to_char(OUTTIME,'HH24MI'),'0')OUTGTIME, to_char(to_date('"+mWorkDate+"','dd-mm-yyyy'),'Day')sDay from  ATT_ATTENDLOG  b, v#allmembers a    where b.InstiTuteCode=a.InstituteCode and a.InstituteCode='"+mInst+"'   and a.MEMBERID=b.USERID  and a.MemberType= b.USERTYPE and     a.MemberType='E'  and A.MEMBERID='"+mFaculty+"'      AND B.WORKINGDATE =TO_DATE ('"+mWorkDate+"','dd-mm-yyyy' ) ";
			//and  b.workhrs_minute <>0 ";
			//	out.println (qry1);
			rs1=db.getRowset(qry1);
			rs2=db.getRowset(qry1);
			if(rs1.next())
			{



			    mIngtime=rs1.getInt("InGTime");
				mOutgtime=rs1.getInt("OUTGTIME");

				mSatDay=rs1.getString("sDay").toString().trim().toUpperCase();

		//	out.print(mSatDay+"OUT"+mHalfDay);
	
				if(nointime!=-1 && noouttime!=-1 && mVacation!=1 && mLeave!=1 && mSpecialCase!=1 && !mWorkDate1.equals(mCDate) && !mDayss.equals("sunday"))
				{
				
				if (mIngtime > mPInTime )
					{
						nointime=mInMaxTime;
					}
					else
					{
				
				if( (mIngtime < mPInTime ) &&  (mIngtime > mAInTime) )
				{
					++nointime;
				}
					}
				
						
				if(mSatDay.equals(mHalfDay))
				{
					
					if(mOutgtime < mAHalfDayTime)
					{
						noouttime=mOutMaxTime;
					}
					else
					{ 
						//out.print((mOutgtime)+"OUT"+(mHalfDayTime)+"IN"+mAHalfDayTime );
						
						//out.print("OUT");
						if( (mOutgtime  >  mAHalfDayTime ) && (mOutgtime < mHalfDayTime  ) )
						{
					
							++noouttime;

									//	out.print("IN");
						}
					}
				}
				else
				{


					if(mOutgtime < mPOutTime )
					{
						noouttime=mOutMaxTime;
					}
					else
					{
						
						if((mOutgtime < mPOutTime ) && (mOutgtime > mAOutTime))
						{ 
						
							++noouttime;
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
				
				%>
				
				<td nowrap align=center>&nbsp;--- </td>	
			<td nowrap align=center>&nbsp;--- </td>	
				<%
			
			
					//when mIngtime and mOutgtime is null then 

				 if(rs.getString("LEAVESTATUS").equals("N") && mSpecialCase!=1  && mVacation!=1 && !mDayss.equals("sunday") && mLeave!=1)
				{
						++nointime;
						++noouttime;
							//out.print(nointime+"IN"+noouttime);
				}
				

			}

	//out.print(mIngtime+"ss"+mOutgtime+":nointime:"+nointime+":noouttime:"+noouttime+":::"+mPInTime+":::mPOutTime"+mPOutTime);
	
//out.print("LLLLLL"+mSatDay.equals("SATURDAY"));	

			if ( (mInMaxTime == nointime) ||  (mOutMaxTime == noouttime) &&  mSpecialCase!=1  && !mWorkDate1.equals(mCDate) && mVacation!=1 && !mDayss.equals("sunday") && mLeave!=1 )
			{
				//	if(mInMaxTime==nointime ||   ( mOutMaxTime==noouttime) )
				//	{

					%>
					  <td align=center><font color=red size=2><b>-PENALITY-</b></font></td>
					<%
					nointime=-1;
					noouttime=-1;
						
				//}
			}

//		else if( (mPInTime < mIngtime)  || if(mPOutTime > mOutgtime) )
//when nointime is < 5  noouttime <5 
else if(nointime==-1 && noouttime==-1 &&  (rs.getString("LEAVESTATUS").equals("P")) &&  mSpecialCase!=1 && !mWorkDate1.equals(mCDate) && mVacation!=1 && !mDayss.equals("sunday") && mLeave!=1)
			{
	
			
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
		
		else if(rs.getString("LEAVESTATUS").equals("P") ||  rs.getString("LEAVESTATUS").equals("F/H")  )
			{
			%>
		
			<td align=center><font color=black size=2><b>----</b></font></td>
			<%
			}
			else if(rs.getString("LEAVESTATUS").substring(0,1).equals("F")  && (!mSatDay.equals("SATURDAY")))
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
			else if(rs.getString("LEAVESTATUS").equals("T"))
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
<!-- <center>
	<table ALIGN=Center VALIGN=TOP>
	<tr>
	<td valign=middle>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
	A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
	<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 		</td></tr></table> -->
</body>
</Html>
