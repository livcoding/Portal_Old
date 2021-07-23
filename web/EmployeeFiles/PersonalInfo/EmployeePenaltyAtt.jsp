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
String mDateFrom="",mCurFDate="",mDateTo="",mEmpName="",mCompCode="",mInst="", mRightsID="", mSRCType="",mCDate="",mWAIVER="",wDate="",seqID="";

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
		<FONT color=black face=Arial size=2><b>Employeeee &nbsp;</b></FONT>
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
//	db.WeekReg4JSP(mDateFrom,mDateTo,mChkMemID,mChkMType,mCompCode,LoginIDTime,"Y","Y","Y","Y","Y","Y","Y","Y",mInst,"Y");
	seqID=db.WeekReg4JSP(mCompCode,mInst,mChkMemID, mChkMType,mDateFrom, mDateTo);
//pCompanyCode  pInstituteCode pUserid  pUserType pfromdate  ptodate in date ,vSeqid out varchar2
		%>
		<table ALIGN=CENTER bottommargin=0  topmargin=0 WIDTH="100%">
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><u>Available List</u> </TD>
		</font></td>
		</table>
		<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center    WIDTH="50%">
		<thead>
		<tr bgcolor="#ff8c00">
		<td align=center nowrap><font color=white><B>Working DDDDate</B></font></td>

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
	//qry="SELECT    nvl((to_char(INTIME,'HH24MI') ,0)INGRACE  , nvl( TO_CHAR(outtime - (.000694 * outgracetime),'hh24mi'),0) OUTGRACE,  nvl(TO_CHAR(HALFDAYTIME,'HH24MI'),0)HALFDAYGRACE,nvl( (TO_CHAR (halfdaytime, 'HH24MI')-outgracetime) ,0) halfdaytime1,TO_CHAR(INTIME,'HH24MI') INTIME  ,   TO_CHAR( OUTTIME,'HH24MI')OUTTIME ,  nvl(INMAXIMUMATTEMPTS,0)INMAXIMUMATTEMPTS ,    nvl(OUTGRACETIME,0)OUTGRACETIME , HALFDAY, HALFONSTARTDAYENDDAY,   nvl( OUTMAXIMUMATTEMPTS,0)OUTMAXIMUMATTEMPTS FROM ATT#PARAMETERS where COMPANYCODE ='"+mCompCode+"'   AND  INSTITUTECODE='"+mInst+"'  ";

//qry="select  institutecode,seqid,userid,usertype,workingdate,intime,outtime,remarks,entrydate  from  att_webkioskattend" ;
 //qry="SELECT  institutecode,seqid,userid, to_char(WORKINGDATE,'dd-mm-yyyy')WORKINGDATE, TO_CHAR(INTIME,'HH24MI') INTIME, TO_CHAR( OUTTIME,'HH24MI')OUTTIME,REMARKS from  att_webkioskattend where USERID= '"+mChkMemID+"'" ;

//  qry="SELECT TO_CHAR (WORKINGDATE, 'dd-mm-yyyy') WORKINGDATE, TO_CHAR (INTIME, 'HH24MI') INTIME,TO_CHAR (OUTTIME, 'HH24MI') OUTTIME,  REMARKS FROM att_webkioskattend WHERE institutecode='"+mInst+"' and   USERID = '"+mFaculty+"' and  SEQID='"+seqID+"' ";
  qry="SELECT TO_CHAR (WORKINGDATE, 'dd-mm-yyyy') WORKINGDATE,    NVL ( TO_CHAR (INTIME, 'HH:MI PM'),' - - - - - - ') INTIME,   NVL (to_char(OUTTIME,'HH:MI PM'),' - - - - - - ')OUTTIME, nvl(REMARKS,'- - - - -')REMARKS FROM att_webkioskattend WHERE institutecode='"+mInst+"' and   USERID = '"+mFaculty+"' and  SEQID='"+seqID+"' ";
out.print(qry);
	rs=db.getRowset(qry);
	while(rs.next())
		{
    %>    
  <tr>
		<td nowrap><%=rs.getString("WORKINGDATE")%></td>
		<td nowrap><%=rs.getString("INTIME")%></td>
        <td nowrap><%=rs.getString("OUTTIME")%></td>
        <td nowrap><%=rs.getString("REMARKS")%></td>
		
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
