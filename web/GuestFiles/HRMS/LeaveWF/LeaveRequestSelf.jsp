<%@ page language="java" import="java.sql.*,java.util.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null, rsMnMx=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="", mComp="";
double mMaxBal=0, mAvailed=0, mTotBal=0, mTotalBal=0;
double LeaveDays=0, mLvPayable=0, mLvWithout=0;
double mMaxLvBal=0, mLvAvailed=0, mMaxLvAppl=0;
double mMinDays=0, mMaxDays=0;
int mSno=0, mFlag=0, NoOfTimeInYr=0, NoOfTimeInTr=0;
String HalfDayFlag="", AdvLvFlag="", ProRataFlag="";
String mFacultyName="",mFaculty="",QryFaculty="";
String mLeave="",mLeaveDesc="",QryLeave="";
String mStartHalfDay="",mEndHalfDay="";
String mCategoryCode="", mMsg="";
String QryReason="", mAllowLeave="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String mDeptCode="", mInst="", mDate1="", mDate2="", mCurrDate="", mNextDate="";
String mColor="Black", mFlagJDate="", mRightsID="142";

qry="select to_Char(Sysdate+1,'dd-mm-yyyy') date1, to_Char(Sysdate+1,'dd-mm-yyyy') date2 from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
mNextDate=rs.getString("date2");

if (session.getAttribute("CompanyCode")==null)
{
	mComp="JIIT";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

if (session.getAttribute("DepartmentCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
}

if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<HEAD>
<TITLE>#### <%=mHead%> [ Leave Application Entry ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="javascript" >
function CheckDate()
{
	var myDate1 = new Date; 
	var myDate2 = new Date; 
	myDate1=document.frm1.TXT1.value;
	myDate2=document.frm1.TXT2.value;
	/*
	myDate.setDate(15);
	myDate.setMonth(3); // January = 0
	myDate.setFullYear(2006);
	var today = new Date;
	*/
	if (myDate1 > myDate2) 
	//alert('"Leave Period To" must be greater than or equal to "Leave Period From" !');
	return true;
}
function ChangeOnLeaveStatus()
{
	document.frm1.action="LeaveRequestSelf.jsp";
	document.frm1.submit();
	return true;
}
function submitActive1()
{
	if (document.frm2.PurposeOfLeave.value!="")
	{
		document.frm2.submit1.disabled=false;
	}
	else
	{
		document.frm2.submit1.disabled=true;
	}
}
function submitActive2()
{
	var POL=document.frm2.PurposeOfLeave.value;
	if(POL!="")
	{
		document.frm2.submit1.disabled=false;
	}
	else
	{
		document.frm2.submit1.disabled=true;
	}
}
</script>
<script language=javascript>
function validate()
{
	maxlength=300;
	for (var i = 0; i < document.frm2.elements.length; i++) 
	{
		var e = document.frm2.elements[i]; 
		if (e.type == 'textarea') 
		{ 
			if(e.value.length>=maxlength)
			{
				alert("Your comments must be 300 characters or less");
				e.focus();
				return false;
			}
 		} 
	}
	return true;
}
</script>
<script language=javascript>
<!--
	function RefreshContents()
	{ 	
    	  document.frm1.x.value='ddd';
    	  document.frm1.submit();
	}
//-->
</script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onLoad=submitActive1()>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals(""))
	{
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
		qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			qry="Select nvl(ALLOWLEAVEENTRY,'Y')ALE from EMPLOYEEMASTER WHERE EMPLOYEEID='"+mChkMemID+"' AND EMPLOYEETYPE='"+mChkMType+"' AND NVL(DEACTIVE,'N')<>'Y'";
			rs=db.getRowset(qry);
			//out.print(qry);
			if(rs.next())
			{
				mAllowLeave=rs.getString(1);
			}
			if(!mAllowLeave.equals("N"))
			{
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
				//----------------------
				%>
				<form name="frm1"  method="post" >
				<input id="x" name="x" type=hidden>
					<table id=id1 width="100%" ALIGN=CENTER  topmargin=0 cellspacing=0 cellpadding=0>

<!-------------Page Heading and Marquee Message----------------------->
				<%
				try
				{
					String mPageHeader="Leave Application Entry", mMarqMsg="", CurrDate="";
					qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
					//out.print(qry);
					rs=db.getRowset(qry);
					if(rs.next())
					{
						CurrDate=rs.getString("CurrDate");
					}
					qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightsID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
					rs=db.getRowset(qry);
					if(rs.next())
					{
						mMarqMsg=rs.getString("MarqMsg");
						%>
						<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
						<%
					}
					qry="Select nvl(B.PAGEHEADER,'"+mPageHeader+"')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
					rs=db.getRowset(qry);
					if(rs.next())
					{
						mPageHeader=rs.getString("PageHeader");
						%>
						<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
						<%
					}
					else
					{
						%>
						<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
						<%
					}
				}
				catch(Exception e)
				{}
				%>
<!-------------Page Heading and Marquee Message----------------------->
				</table>
				<table valign=top cellpadding=0 cellspacing=0 width="100%" align=center rules=groups border=1>
				<!*********--Institute--************>
				<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
				<%
				qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
				rsi=db.getRowset(qry);
				while(rsi.next())
				{
					mInst=rsi.getString("IC");
				}
				%>
				<tr><td nowrap width=50%>
				<table valign=top cellpadding=3 cellspacing=0 width="100%" align=center rules=groups border=0>
				<tr><td colspan=2 nowrap><font color=black face=arial size=2><STRONG>Staff&nbsp;</STRONG>
				<%
				qry="select distinct nvl(EMPLOYEEID,' ')Faculty, nvl(EMPLOYEENAME,' ')FacultyName from V#STAFF where employeeid='"+mChkMemID+"' and nvl(deactive,'N')='N'";
				//out.print(qry);
				rs=db.getRowset(qry);
				%>
				<select name="Faculty" tabindex="0" id="Faculty" style="WIDTH: 230px" >
				<%
				if(request.getParameter("x")==null)
				{	
					while(rs.next())
					{
					 	mFaculty=rs.getString("Faculty");
						if(QryFaculty.equals(""))
						{
							QryFaculty=mFaculty;
						}
					 	mFacultyName=rs.getString("FacultyName");
						%>
						<option value=<%=mFaculty%>><%=mFacultyName%></option>
						<%
					}
				}
				else
				{
					while(rs.next())
					{
				   		mFaculty=rs.getString("Faculty");
						QryFaculty="mFaculty";
					   	mFacultyName=rs.getString("FacultyName");
					   	if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
						{
							QryFaculty=mFaculty;
							%>
			    				<option selected value=<%=mFaculty%>><%=mFacultyName%></option>
							<%
					  	}
						else
			      		{
							%>
				    			<option  value=<%=mFaculty%>><%=mFacultyName%></option>
	   						<%
						}	
					}
				}
				%>
				</select>
				</td></tr>
				<tr><td nowrap colspan=2><b><font color=black face=arial size=2>Leave Code &nbsp;</font></b>
				<%
				qry="select distinct nvl(LEAVECODE,' ')Leave, nvl(LEAVEDESCRIPTION,' ')LeaveDesc from LEAVEMASTER";
				qry=qry+" Where EMPCATEGORYCODE in ((Select nvl(EMPCATEGORYCODE,'REG') from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"') Union Select 'ALL' from Dual)";
				qry=qry+" and LEAVEAPPLICABLETO in ((Select nvl(EMPLOYEETYPE,'TEC') from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"')Union Select 'ALL' from Dual)";
				qry=qry+" and SEXSPECIFIC In ((Select nvl(SEX,'M') from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"') Union Select 'B' from Dual)";
				qry=qry+" order by LeaveDesc";
				//out.print(qry);
				rs=db.getRowset(qry);
				%>
				<select name="Leave" tabindex="0" id="Leave" style="WIDTH: 185px" >
				<%
				if(request.getParameter("x")==null)
				{	
					while(rs.next())
					{
					 	mLeave=rs.getString("Leave");
						if(QryLeave.equals(""))
						{
							QryLeave=mLeave;
						}
		 				mLeaveDesc=rs.getString("LeaveDesc");
						%>
						<option value=<%=mLeave%>><%=mLeave%> (<%=mLeaveDesc%>)</option>
						<%
					}
				}
				else
				{
					while(rs.next())
					{
				   		mLeave=rs.getString("Leave");
						QryLeave=mLeave;
					   	mLeaveDesc=rs.getString("LeaveDesc");
					   	if(mLeave.equals(request.getParameter("Leave").toString().trim()))
						{
							QryLeave=mLeave;
							%>
				    			<option selected value=<%=mLeave%>><%=mLeave%> (<%=mLeaveDesc%>)</option>
							<%
					  	}
						else
			      		{
	   						%>
				    			<option  value=<%=mLeave%>><%=mLeave%> (<%=mLeaveDesc%>)</option>
	   						<%
						}	
					}
				}
				%>
				</select>
				</td></tr>
				<tr><td nowrap colspan=2><b><font color=black face=arial size=2>Leave Period</font></b>&nbsp; <img src="../../../Images/arrow.gif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b><font color=black face=arial size=2>Half Day</font></b>&nbsp; <img src="../../../Images/arrow.gif"></TD></TR>
				<tr><td nowrap colspan=2>
				<%
				if (request.getParameter("x")!=null)
				{
					mDate1=request.getParameter("TXT1").toString().trim();
					mDate2=request.getParameter("TXT2").toString().trim();
				}
				else
				{
					mDate1=mCurrDate;
					mDate2=mNextDate;
				}
				%>
				<b><font color=navy face=arial size=2>From </font><b><input Name=TXT1 Id=TXT1 style="height:22px" Type=text maxlength=10 size=8 value='<%=mDate1%>' onTextChange="ChangeOnLeaveStatus()" READONLY><a href="javascript:NewCal('TXT1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
				&nbsp; &nbsp;
				<select name="FromLunch" tabindex="3" id="FromLunch" style="WIDTH: 90px">
				<%
				if(request.getParameter("x")==null)
				{
					mStartHalfDay="None";
					%>
					<OPTION Value=None selected>None</option>
					<OPTION Value=PreFrom>Pre Lunch</option>
					<OPTION Value=PostFrom>Post Lunch</option>
					<%
				}
				else
				{
					if (request.getParameter("FromLunch").toString().trim().equals("PostFrom"))
					{
						%>
					 	<OPTION value=None>None</option>
						<OPTION Value=PreFrom>Pre Lunch</option>
						<OPTION selected Value=PostFrom>Post Lunch</option>
						<%
					}
					else if (request.getParameter("FromLunch").toString().trim().equals("PreFrom"))
					{
						%>
					 	<OPTION value=None>None</option>
						<OPTION Value=PreFrom Selected>Pre Lunch</option>
						<OPTION Value=PostFrom>Post Lunch</option>
						<%
					}
					else
					{
						%>
					 	<OPTION value=None Selected>None</option>
						<OPTION Value=PreFrom>Pre Lunch</option>
						<OPTION Value=PostFrom>Post Lunch</option>
						<%
					}
				}
				%>
				</select>
				</td></tr>
				<tr><td nowrap colspan=2>
				<b>&nbsp; &nbsp;<font color=navy face=arial size=2>To</font> &nbsp;<b><input Name=TXT2 Id=TXT2 style="height:22px" Type=text maxlength=10 size=8 value='<%=mDate2%>' READONLY><a href="javascript:NewCal('TXT2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
				&nbsp; &nbsp; 
				<select name="ToLunch" tabindex="7" id="ToLunch" style="WIDTH: 90px">
				<%
				if(request.getParameter("x")==null)
				{
					mEndHalfDay="None";
					%>
					<OPTION Value=None selected>None</option>
					<OPTION Value=PreTo>Pre Lunch</option>
					<!--<OPTION Value=PostTo>Post Lunch</option>-->
					<%
				}
				else
				{
					if (request.getParameter("ToLunch").toString().trim().equals("None"))
					{
						%>
						<OPTION Value=None selected>None</option>
						<OPTION Value=PreTo>Pre Lunch</option>
						<!--<OPTION Value=PostTo>Post Lunch</option>-->
						<%
					}
					else if (request.getParameter("ToLunch").toString().trim().equals("PreTo"))
					{
						%>
						<OPTION Value=None>None</option>
						<OPTION Value=PreTo selected>Pre Lunch</option>
						<!--<OPTION Value=PostTo>Post Lunch</option>-->
						<%
					}
					else
					{
						%>
						<OPTION Value=None>None</option>
						<OPTION Value=PreTo>Pre Lunch</option>
						<!--<OPTION Value=PostTo selected>Post Lunch</option>-->
						<%
					}
				}
				%>
				</select>
				</td></tr>
				<TR><TD colspan=2 align=center>
				<INPUT id=submit style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 105px; HEIGHT: 24px; FONT-VARIANT: normal" type=submit size=5 value="Leave Status" name=submit title="Get Leave Status as on Given Date" onclick="return CheckDate();"></td></tr>
				<tr><td><a target=_new href="../WorkFlowApprovalLevel.jsp?WFC=LEAVE&amp;DEPTCODE=<%=mDeptCode%>" title="Click to View Default (Departmentwise) Approval Level"><marquee behavior=alternate scrolldelay=100 width=100% style="cursor:hand"><font color="blue" face=arial size=2><STRONG>Click To View Default Work Flow</STRONG></font></marquee></a></td></tr>
				</table></td>
				<td nowrap width=50%>
				<table valign=top class="sort-table" id="table-2" border=1 width="100%" cellpadding=0 cellspacing=0 align=center>
				<thead>
				<tr bgcolor="#ff8c00">
				<td align=center nowrap><font color=white><B>Leave...</B></font></td>
				<td align=center nowrap><font color=white><B>Max<br>Leave</B></font></td>
				<td align=center nowrap><font color=white><B>Availed<br>Leave</B></font></td>
				<td align=center nowrap><font color=white><B>Balance<br>Leave</B></font></td>						
				<td align=center nowrap><font color=white><B>Balance<br>As on<br>Date</B></font></td>
				<td align=center nowrap><font color=white><B>Balance<br>As on<br>Lv. Date</B></font></td>
				</tr>
				</thead>
				<tbody>
				<%
				qry="Select nvl(EMPCATEGORYCODE,'REG')CATEGORYCODE from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"'";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mCategoryCode=rs.getString("CATEGORYCODE");
				}
				qry="select distinct nvl(LEAVECODE,' ')Leave, nvl(LEAVEDESCRIPTION,' ')LeaveDesc, nvl(MAXBALANCE,0)MaxBal from LEAVEMASTER";
				qry=qry+" Where EMPCATEGORYCODE in ((Select nvl(EMPCATEGORYCODE,'REG') from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"') Union Select 'ALL' from Dual)";
				qry=qry+" and LEAVEAPPLICABLETO in ((Select nvl(EMPLOYEETYPE,'TEC') from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"') Union Select 'ALL' from Dual)";
				qry=qry+" and SEXSPECIFIC In ((Select nvl(SEX,'M') from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"') Union Select 'B' from Dual)";
				qry=qry+" order by LeaveDesc";
				//out.print(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					mMaxBal=rs.getDouble("MaxBal");
					%>
					<tr>
					<td nowrap><%=rs.getString("Leave")%> (<%=rs.getString("LeaveDesc")%>)</td>
					<td align=RIGHT><%=mMaxBal%>&nbsp;</td>
					<%
					qry="Select nvl(PAID,0)Availed From LEAVETRANSACTION where ";
					qry=qry+" EMPCATEGORYCODE='"+mCategoryCode+"' and";
					qry=qry+" COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"' and LEAVECODE='"+rs.getString("Leave")+"'";
					RsChk= db.getRowset(qry);
					//out.print(qry);
					if(RsChk.next())
					{
						mAvailed=RsChk.getDouble("Availed");
						mTotBal=mMaxBal-mAvailed;
						//out.print(mAvailed+" "+mTotBal);
						%>
						<td align=RIGHT><%=mAvailed%>&nbsp;</td>
						<td align=RIGHT><%=mTotBal%>&nbsp;</td>
						<%
					}
					else
					{
						mAvailed=0;
						mTotBal=mMaxBal-mAvailed;
						//out.print(mAvailed+" "+mTotBal);
						%>
						<td align=RIGHT><%=mAvailed%>&nbsp;</td>
						<td align=RIGHT><%=mTotBal%>&nbsp;</td>
						<%
					}
					qry="Select LEAVE.LeaveBalance('"+mComp+"','"+mCategoryCode+"','"+ mChkMemID+"','"+rs.getString("Leave")+"',trunc(SYSDATE)) LD from dual";
					RsChk= db.getRowset(qry);
					//out.print(qry);
					if(RsChk.next())
					{
						%>
						<td align=RIGHT><%=RsChk.getDouble(1)%>&nbsp;</td>
						<%
					}
					qry="Select LEAVE.LeaveBalance('"+mComp+"','"+mCategoryCode+"','"+ mChkMemID+"','"+rs.getString("Leave")+"',trunc(to_date('"+mDate1+"','dd-mm-yyyy'))) LD from dual";
					RsChk= db.getRowset(qry);
					//out.print(qry);
					if(RsChk.next())
					{
						%>
						<td align=RIGHT><%=RsChk.getDouble(1)%>&nbsp;</td>
						<%
					}
					else
					{
						%>
						<td align=RIGHT>&nbsp;</td>
						<%
					}
					%>
					<tr>
					<%
				}
				%>
				</tbody>
				</table>
				<script type="text/javascript">
				//var st1 = new SortableTable(document.getElementById("table-2"),[,"CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
				</script>
				</td></tr></table>
				</form>
				<%
				if(request.getParameter("x")!=null)
				{
					if (request.getParameter("Faculty")!=null)
						QryFaculty=request.getParameter("Faculty").toString().trim();
					else
						QryFaculty="";
					if (request.getParameter("Leave")!=null)
						QryLeave=request.getParameter("Leave").toString().trim();
					else
						QryLeave="";
					if (request.getParameter("TXT1")!=null)
						mDate1=request.getParameter("TXT1").toString().trim();
					else
						mDate1="";
					if (request.getParameter("TXT2")!=null)
						mDate2=request.getParameter("TXT2").toString().trim();
					else
						mDate2="";
					if (request.getParameter("FromLunch")!=null)
						mStartHalfDay=request.getParameter("FromLunch").toString().trim();
					else
						mStartHalfDay="";
					if (request.getParameter("ToLunch")!=null)
						mEndHalfDay=request.getParameter("ToLunch").toString().trim();
					else
						mEndHalfDay="";
				//-------------------------------------
					qry="Select nvl(HALFDAY,'N')HALFDAY, nvl(PRORATA,'N')PRORATA, nvl(ADVANCELEAVE,'N')ADVLV, nvl(NOOFTIMESPERYEAR,0)NOTYR, nvl(NOOFTIMESINTENNURE,0)NOTTR ";
					qry=qry+" from LEAVEMASTER where CompanyCode='"+mComp+"' and LEAVECODE='"+QryLeave+"' and EMPCATEGORYCODE IN ('"+mCategoryCode+"','ALL')";
					rsi=db.getRowset(qry);
					//out.print(qry);
					if(rsi.next())
					{
						HalfDayFlag=rsi.getString("HALFDAY");
						AdvLvFlag=rsi.getString("ADVLV");
						ProRataFlag=rsi.getString("PRORATA");
						NoOfTimeInYr=rsi.getInt("NOTYR");
						NoOfTimeInTr=rsi.getInt("NOTTR");
					}
					if(HalfDayFlag.equals("Y"))
					{
						if(mStartHalfDay.equals("None") && mEndHalfDay.equals("None"))
						{
							mStartHalfDay="";
							mEndHalfDay="";
						}
						else if(mStartHalfDay.equals("None") && mEndHalfDay.equals("PreTo"))
						{
							mStartHalfDay="";
							mEndHalfDay=mEndHalfDay;
							mFlagJDate="Last";
						}
						else if(mStartHalfDay.equals("PreFrom") && mEndHalfDay.equals("None"))
						{
							mStartHalfDay=mStartHalfDay;
							mEndHalfDay="";
						}
						else if(mStartHalfDay.equals("PreFrom") && mEndHalfDay.equals("PreTo"))
						{
							%><CENTER><%
							out.print("<img src='../../../Images/Error1.jpg'>");
							out.print("&nbsp;<b><font size=2 face='Arial' color='Red'>'Pre Lunch' to 'Pre Lunch' Not Allowed! &nbsp; Kindly select different Half Day option...</font>");
							%></CENTER><%
							mStartHalfDay=mStartHalfDay;
							mEndHalfDay="";
							mFlag=1;
						}
						else if(mStartHalfDay.equals("PostFrom") && mEndHalfDay.equals("None"))
						{
							mStartHalfDay=mStartHalfDay;
							mEndHalfDay="";
						}
						else if(mStartHalfDay.equals("PostFrom") && mEndHalfDay.equals("PreTo"))
						{
							mStartHalfDay=mStartHalfDay;
							mEndHalfDay=mEndHalfDay;
							mFlagJDate="Last";
						}
						else
						{
							mStartHalfDay="";
							mEndHalfDay="";
						}
					//-------------------------------------
					//-------------------------------------
						if(mStartHalfDay.equals("PreFrom"))
						{
							mStartHalfDay="B";
							//---B for Before Lunch----
						}
						else if(mStartHalfDay.equals("PostFrom"))
						{
							mStartHalfDay="A";
							//---A for After Lunch----
						}
						else if(mStartHalfDay.equals("None"))
						{
							mStartHalfDay="";
						}
						if(mEndHalfDay.equals("PreTo"))
						{
							mEndHalfDay="B";
							//---B for Before Lunch----
						}
						else if(mEndHalfDay.equals("PostTo"))
						{
							mEndHalfDay="A";
							//---A for After Lunch----
						}
						else if(mEndHalfDay.equals("None"))
						{
							mEndHalfDay="";
						}
					}
					else
					{
						if((!mStartHalfDay.equals("None") || !mEndHalfDay.equals("None")) && (request.getParameter("y")==null))
						{
							out.print(mStartHalfDay+" A "+mEndHalfDay);
							%><table align=center border=0><tr><td align=center nowrap>
							<img src='../../../Images/Error1.jpg'>&nbsp; &nbsp;<font size=2 face='Arial' color='Red'><b>Half Day Leave(<%=QryLeave%>) is not allowed! Kindly choose different Leave Code...</b></font> <br>
							</td></tr></table><%
							mStartHalfDay="";
							mEndHalfDay="";
							LeaveDays=0;
						}
					}
				}
				if(mStartHalfDay.equals("None"))
				{
					mStartHalfDay="";
				}
				if(mEndHalfDay.equals("None"))
				{
					mEndHalfDay="";
				}
			//-------------------------------------
				int len1=0, len2=0;
				int pos1=0, pos2=0, pos3=0, pos4=0;
				int hyphenpos1=0, hyphenpos2=0;
				String mDt1="", mDt2="", mMon1="", mMon2="", mYr1="", mYr2="";
				int mDtFr=0, mDtTo=0, mMonFr=0, mMonTo=0, mYrFr=0, mYrTo=0;
				len1=mDate1.length();
				len2=mDate2.length();
				pos1=mDate1.indexOf("-");
				pos2=pos1+3;
				pos3=mDate2.indexOf("-");
				pos4=pos3+3;

				mDt1=mDate1.substring(0,pos1);
				mDt2=mDate2.substring(0,pos3);
	
				hyphenpos1=mMon1.indexOf("-");
				hyphenpos2=mMon2.indexOf("-");
				if(hyphenpos1!=0)
				{
					mMon1=mDate1.substring(pos1+1,pos2-1);
				}
				else
				{
					mMon1=mDate1.substring(pos1+1,pos2);
				}
				if(hyphenpos2!=0)
				{
					mMon2=mDate2.substring(pos3+1,pos4-1);
				}
				else
				{
					mMon2=mDate2.substring(pos3+1,pos4);
				}
				mYr1=mDate1.substring(pos2+1,len1);
				mYr2=mDate2.substring(pos4+1,len2);

				mDtFr=Integer.parseInt(mDt1);
				mDtTo=Integer.parseInt(mDt2);
				try
				{
					mMonFr=Integer.parseInt(mMon1);
					mMonTo=Integer.parseInt(mMon2);
				}
				catch(Exception e)
				{
				}
				mYrFr=Integer.parseInt(mYr1);
				mYrTo=Integer.parseInt(mYr2);
				int syear = mYrFr;
				int eyear = mYrTo;
				int smonth = mMonFr;//Feb
				int emonth = mMonTo;//Mar
				int sday = mDtFr;
				int eday = mDtTo;
			//	java.util.Date startDate = new java.util.Date(syear-1900,smonth-1,sday);
			//	java.util.Date endDate = new java.util.Date(eyear-1900,emonth-1,eday);
			//	double difInDays = (int) ((endDate.getTime() - startDate.getTime())/(1000*60*60*24));
			/*
				Calendar scal = Calendar.getInstance();
				Calendar ecal = Calendar.getInstance();
				scal.set(syear-1900,smonth-1,sday);
				ecal.set(eyear-1900,emonth-1,eday);
				double difInDays = ((ecal.getTime().getTime() - scal.getTime().getTime())/(1000*60*60*24));
			*/
				qry="Select to_date('"+mDate2+"','dd-mm-yyyy') - to_date('"+mDate1+"','dd-mm-yyyy') difInDays From Dual";
				rs=db.getRowset(qry);
				double difInDays = 0;
				if(rs.next())
				{
					difInDays=rs.getDouble("difInDays");;
				}
				LeaveDays=difInDays +1;
				/*out.print(startDate);
				%><br><%
				out.print(endDate);
				%><br><%
				out.print(LeaveDays);*/
				//out.print(difInDays);
			//----------------------------
			//----------------------------
				if((mStartHalfDay.equals("") && difInDays==0) && mEndHalfDay.equals("B"))
				{
					%><CENTER><%
					out.print("<img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;<b><font size=2 face='Arial' color='red'>On the same day, 'None' to 'Pre Lunch' Not Allowed! Kindly select different Half Day option...</font>");
					%></CENTER><%
					mFlag=3;
				}
				if((!mStartHalfDay.equals("") && difInDays==0) || (!mEndHalfDay.equals("") && difInDays>0))
				{
					LeaveDays=LeaveDays-0.5;
				}
				if((mStartHalfDay.equals("A") && mEndHalfDay.equals("B") && difInDays==0))
				{
					%><CENTER><%
					out.print("<img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;<b><font size=2 face='Arial' color='red'>On the same day, 'Post Lunch' to 'Pre Lunch' Not Allowed! Kindly select different Half Day option...</font>");
					%></CENTER><%
					mFlag=2;
				}
				if(!mStartHalfDay.equals("") && !mEndHalfDay.equals("") && difInDays>0)
				{
					LeaveDays=LeaveDays-0.5;
				}
				if(!mStartHalfDay.equals("") && mEndHalfDay.equals("") && difInDays>0)
				{
					LeaveDays=LeaveDays-0.5;
				}
				%>
				<form name="frm2" method="post" action="LeaveRequestSelfAction.jsp" onsubmit='return validate()'>
				<input id="x" name="x" type=hidden>
				<input id="y" name="y" type=hidden>
				<input id="TXT1" name="TXT1" type=hidden value=<%=mDate1%>>
				<input id="TXT2" name="TXT2" type=hidden value=<%=mDate2%>>
				<input id="Faculty" name="Faculty" type=hidden value=<%=QryFaculty%>>
				<input id="Leave" name="Leave" type=hidden value=<%=QryLeave%>>
				<input id="FromLunch" name="FromLunch" type=hidden value=<%=mStartHalfDay%>>
				<input id="ToLunch" name="ToLunch" type=hidden value=<%=mEndHalfDay%>>
				<input id="LeaveDays" name="LeaveDays" type=hidden value=<%=LeaveDays%>>
				<input id="Inst" name="Inst" type=hidden value=<%=mInst%>>
				<input id="Comp" name="Comp" type=hidden value=<%=mComp%>>
				<%
				if(NoOfTimeInYr>0)
				{
					%><input id="TERMINYR" name="TERMINYR" type=hidden value=<%=NoOfTimeInYr%>><%
				}
				if(NoOfTimeInTr>0)
				{
					%><input id="TERMINTR" name="TERMINTR" type=hidden value=<%=NoOfTimeInTr%>><%
				}
				if(mFlagJDate.equals("Last"))
				{
					%>
					<input id="JDate" name="JDate" type=hidden value="Last">
					<%
				}
				if(request.getAttribute("message")==null)
					mMsg="";
				else
					mMsg=(String)request.getAttribute("message");
				if(mMsg.equals("Msg1"))
				{
					%><CENTER><%
					out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Green'>Your Request for Leave has been sent Successfully...</font><br><br>");
					%></CENTER><%
				}
				else if(mMsg.equals("Msg2"))
				{
					%><CENTER><%
					out.print("<img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'>Error while Leave Request! &nbsp; Kindly review the Leave criteria...</font><br><br>");
					%></CENTER><%
				}
				else if(mMsg.equals("Msg3"))
				{
					%><CENTER><%
					out.print("<img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'>Leave already requested during this period! &nbsp; Kindly choose different Date(s)...</font><br><br>");
					%></CENTER><%
				}
				else if(mMsg.equals("Msg4"))
				{
					%><CENTER><%
					out.print("<img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'>PIN No should be Numeric only!</font><br><br>");
					%></CENTER><%
				}
				else if(mMsg.equals("Msg5"))
				{
					%><CENTER><%
					out.print("<img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'>Purpose of Leave can't be Empty!</font><br><br>");
					%></CENTER><%
				}
				else if(mMsg.equals("Msg8"))
				{
					%><CENTER><%
					out.print("<img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'>Total Terms of Leave in the Year or Tenure have been availed!</font><br><br>");
					%></CENTER><%
				}
				qry="select nvl(MAXBALANCE,0)MaxBal from LEAVEMASTER Where COMPANYCODE='"+mComp+"' and EMPCATEGORYCODE IN ('"+mCategoryCode+"','ALL') and LEAVECODE='"+QryLeave+"'";
				RsChk=db.getRowset(qry);
				//out.print(qry);
				if(RsChk.next())
				{
					mMaxBal=RsChk.getDouble("MaxBal");
				}
				qry="Select nvl(PAID,0)Availed From LEAVETRANSACTION where ";
				qry=qry+" EMPCATEGORYCODE IN ('"+mCategoryCode+"','ALL') and COMPANYCODE='"+mComp+"'";
				qry=qry+" and EMPLOYEEID='"+mChkMemID+"' and LEAVECODE='"+QryLeave+"'";
				RsChk= db.getRowset(qry);
				//out.print(qry);
				if(RsChk.next())
				{
					mAvailed=RsChk.getDouble("Availed");
					mTotBal=mMaxBal-mAvailed;
				}
				else
				{
					mAvailed=0;
					mTotBal=mMaxBal-mAvailed;
				}
				//out.print(mMaxBal+" "+mAvailed+" "+mTotBal);
				if(LeaveDays>0)
				{
					qry="select 'Y' from LEAVEMASTER where COMPANYCODE='"+mComp+"' AND  EMPCATEGORYCODE IN ('ALL','"+mCategoryCode+"') AND LEAVECODE='"+QryLeave+"' AND '"+LeaveDays+"' between MINDAYS and MAXDAYS";
					rsMnMx=db.getRowset(qry);
					//out.print(qry);
					if(rsMnMx.next())
					{
						%>
						<table valign=middle cellpadding=0 cellspacing=0 width="100%" align=center rules=groups border=1>
						<tr><td><b><font face=arial size=2>&nbsp;Leave Status :</font></td>
						<%
					//--------------Prorata(Y/N) Advance(Y/N)-------------
						if(ProRataFlag.equals("N") && AdvLvFlag.equals("N"))
						{
							mMaxLvBal=mTotBal;
						}
						else if((ProRataFlag.equals("N") && AdvLvFlag.equals("Y")) || (ProRataFlag.equals("Y") && AdvLvFlag.equals("Y")))
						{
							mMaxLvBal=LeaveDays;
						}
						else
						{
							qry="Select LEAVE.LeaveBalance('"+mComp+"','"+mCategoryCode+"','"+ mChkMemID+"','"+QryLeave+"',trunc(to_date('"+mDate1+"','dd-mm-yyyy'))) LD from dual";
							RsChk= db.getRowset(qry);
							//out.print(qry);
							if(RsChk.next())
							mMaxLvBal=RsChk.getDouble(1);
						}
					//--------------Prorata(Y/N) Advance(Y/N)-------------
						if(request.getParameter("x")!=null)
						{
							mMaxLvBal=(int)mMaxLvBal;
							mMaxLvAppl=mMaxLvBal-LeaveDays;
							if(mFlag>0)
							{
								mLvPayable=0;
								mLvWithout=0;
							}
							else if(mMaxLvAppl>0)
							{
								mLvPayable=LeaveDays;
							mLvWithout=0;
							}
							else if(mMaxLvAppl<0)
							{
								mMaxLvAppl=LeaveDays-mMaxLvBal;
								mLvWithout=mMaxLvAppl;
								mLvPayable=mMaxLvBal;
							}
							else
							{
								mLvPayable=mMaxLvBal;
								mLvWithout=0;
							}
						}
						//out.print(mMaxLvBal+" "+mLvPayable+" "+mLvWithout);
						%>
						<input id="Pay" name="Pay" type=hidden value=<%=mLvPayable%>>
						<input id="WithoutPay" name="WithoutPay" type=hidden value=<%=mLvWithout%>>
						<td nowrap colspan=3><Input style="text-align=right" type="text" id="Payable" name="Payable" align=right maxlength=6 size=8 Value="<%=gb.getRound(mLvPayable,2)%>" ReadOnly><font color=navy face=arial size=2><b>&nbsp;Payable&nbsp;</b></font>
						&nbsp; &nbsp; &nbsp; 
						<Input style="text-align=right" type="text" id="Withoutpay" name="Withoutpay" align=right maxlength=6 size=8 Value="<%=gb.getRound(mLvWithout,2)%>" ReadOnly><font color=navy face=arial size=2><b>&nbsp;Withoutpay&nbsp;</b></font>
						</td></tr>
						<%
						if(request.getParameter("x")!=null)
						{
							%>
							<tr><td nowrap><b><font face=arial size=2>&nbsp;Purpose of Leave :&nbsp;</font></b></td>
							<td nowrap colspan=1><TextArea type="text" OnChange="submitActive2()" id="PurposeOfLeave" name="PurposeOfLeave" maxlength=160 cols=53 rows=2></TextArea><FONT color=red>*</FONT></td></tr>
							<%
						}
						else
						{
							%>
							<tr><td nowrap><b><font face=arial size=2>&nbsp;Purpose of Leave :&nbsp;</font></b></td>
							<td nowrap colspan=1><TextArea type="text" OnChange="submitActive2()" id="PurposeOfLeave" name="PurposeOfLeave" maxlength=160 cols=53 rows=2 READONLY></TextArea><FONT color=red>*</FONT></td></tr>
							<%
						}
						%>
						<tr><td nowrap><b><font face=arial size=2>&nbsp;Period of Station <br>&nbsp;Leave (If Required) :&nbsp;</font></b></td>
						<td nowrap colspan=3><Input style="text-align=right" type="text" OnClick="submitActive2()" id="PeriodOfStation" name="PeriodOfStation" maxlength=3 size=7></td></tr>

						<tr><td nowrap colspan=4><b><font face=arial size=2>&nbsp;Address During the Station Leave : &nbsp;</font></b></td></tr>
						<tr><td nowrap align=right><b><font face=arial size=1>&nbsp;Address 1 : &nbsp;</font></b></td>
						<td nowrap colspan=3><Input style="text-align=left" type="text" style="position:relative;width:200px;font-size:10px" OnClick="submitActive2()" id="AOS1" name="AOS1" maxlength=60 size=28>
						<b><font face=arial size=1>Address 2 :</font></b>
						<Input style="text-align=left" type="text" style="position:relative;width:200px;font-size:10px" OnClick="submitActive2()" id="AOS2" name="AOS2" maxlength=60 size=29>
						</td></tr>

						<tr><td nowrap align=right><b><font face=arial size=1>&nbsp;Address 3 : &nbsp;</font></b></td>
						<td nowrap colspan=3><Input style="text-align=left" type="text" style="position:relative;width:200px;font-size:10px" OnClick="submitActive2()" id="AOS3" name="AOS3" maxlength=60 size=28>
						<b><font face=arial size=1>City :</font></b>
						<Input style="text-align=left" type="text" style="position:relative;width:150px;font-size:10px" OnClick="submitActive2()" id="City" name="City" maxlength=30 size=20>
						<b><font face=arial size=1>PIN :</font></b>
						<Input style="text-align=left" type="text" style="position:relative;width:50px;font-size:10px" OnClick="submitActive2()" id="Pin" name="Pin" maxlength=6 size=5>
						</td></tr>

						<tr><td nowrap align=right><b><font face=arial size=1>&nbsp;District : &nbsp;</font></b></td>
						<td nowrap colspan=3><Input style="text-align=left" type="text" style="position:relative;width:125px;font-size:10px" OnClick="submitActive2()" id="Dist" name="Dist" maxlength=30 size=20>
						<b><font face=arial size=1>State :</font></b>
						<Input style="text-align=left" type="text" style="position:relative;width:125px;font-size:10px" OnClick="submitActive2()" id="State" name="State" maxlength=30 size=15>
						<b><font face=arial size=1>Country :</font></b>
						<Input style="text-align=left" type="text" style="position:relative;width:123px;font-size:10px" OnClick="submitActive2()" id="Cnt" name="Cnt" maxlength=30 size=12>
						</td></tr>

						<tr><td nowrap align=right><b><font face=arial size=1>&nbsp;Phone No. : &nbsp;</font></b></td>
						<td nowrap colspan=3><Input style="text-align=left" type="text" style="position:relative;width:125px;font-size:10px" OnClick="submitActive2()" id="Phone" name="Phone" maxlength=30 size=20>
						<b><font face=arial size=1>Mobile No. :</font></b>
						<Input style="text-align=left" type="text" style="position:relative;width:125px;font-size:10px" OnClick="submitActive2()" id="Mobile" name="Mobile" maxlength=30 size=20>
						</td></tr>

						<tr><td nowrap><b><font face=arial size=2>&nbsp;Details about Arrangement&nbsp;<br>&nbsp;for Classes (If Applicable) :&nbsp;</font></b></td>
						<td nowrap colspan=3><TextArea type="text" OnClick="submitActive2()" id="Arrangement" name="Arrangement" maxlength=300 cols=53 rows=2></TextArea></td></tr>
						<td colspan=4 align=center><INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 55px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Apply" name=submit1 title="Apply your Leave Request"></td></tr>
						</table>
						<%
						if(request.getParameter("y")!=null)
						{
							if (request.getParameter("PurposeOfLeave")!=null)
								QryReason=request.getParameter("PurposeOfLeave").toString().trim();
							else
								QryReason="";
							%>
							<input id="PurposeofLeave" name="PurposeofLeave" type=Hidden value=<%=QryReason%>>
							<%
						}
					}
					else
					{
						if(request.getParameter("x")!=null)
						{
						   qry="Select nvl(Mindays,0)MND, nvl(Maxdays,0)MXD from LEAVEMASTER where CompanyCode='"+mComp+"' and LEAVECODE='"+QryLeave+"' and EMPCATEGORYCODE IN ('"+mCategoryCode+"','ALL')";
						   //out.print(qry);
						   rsi=db.getRowset(qry);
						   if(rsi.next())
						   {
							mMinDays=rsi.getDouble("MND");
							mMaxDays=rsi.getDouble("MXD");
						   }
						   %>
						   <table align=center border=0><tr><td align=center nowrap>
						   <img src='../../../Images/Error1.jpg'>&nbsp; &nbsp;<font size=2 face='Arial' color='Red'><b><%=LeaveDays%> Day(s) Leave(<%=QryLeave%>) is not permissible! The permissible Leave(<%=QryLeave%>) must be between <%=mMinDays%> and <%=mMaxDays%>...</b></font> <br>
						   </td></tr></table>
						   <%
						}
					}
				}
				else
				{
					%><CENTER><%
					out.print("<img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='Red'>'Leave Period To' must be greater than or equal to 'Leave Period From' !</font>");
					%></CENTER><%
				}
				qry="Select Distinct LeaveCode LCODE, to_char(STARTDATE,'dd-mm-yyyy') SDATE, nvl(to_char(ENDDATE,'dd-mm-yyyy'),' ')EDATE, Decode(STARTHALFDAY,'B','Pre Lunch','A','Post Lunch','No Half Day')SHDAY, Decode(ENDHALFDAY,'B','Pre Lunch','A','Post Lunch','No Half Day')EHDAY,";
				qry=qry+" nvl(PAID,0)PAID, nvl(WITHOUTPAY,0)LWP, nvl(ABSENT,0)ABSENT, nvl(to_char(trunc(JOININGDATE),'dd-mm-yyyy'),' ') JDATE, Decode(STATUS,'J','Joined','Not Joined')JSTATUS";
				qry=qry+" FROM LEAVETRANSACTION where companycode='"+mComp+"' and EmpCategorycode In((Select nvl(EMPCATEGORYCODE,'REG')CATEGORYCODE from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"')Union(Select 'ALL' from dual))";
				qry=qry+" and Employeeid='"+QryFaculty+"'";
				qry=qry+" and LEAVECODE=Decode('ALL','ALL',LEAVECODE,'ALL') and trunc(STARTDATE)<=trunc(sysdate) ORDER BY SDATE, LCODE";
				//out.print(qry);
			    	rs=db.getRowset(qry);
				%>
				<table align=center width="100%" bottommargin=0 topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Availed Leaves</FONT></u></b></font></td></tr>
				</table>
				<table class="sort-table" id="table-1" border=1 cellpadding=0 cellspacing=0 align=center>
				<thead>
				<tr bgcolor="#ff8c00">
				<td align=center rowspan=2 nowrap><font color=white><B>Leave<br>Code</B></font></td>
				<td align=center nowrap colspan=2><font color=white><B>Period</B></font></td>
				<td align=center nowrap colspan=2><font color=white><B>Half Day</B></font></td>
				<td align=center nowrap colspan=3><font color=white><B>Leave Type</B></font></td>						
				<td align=center nowrap colspan=2><font color=white><B>Joining</B></font></td>
				</tr>
				<tr bgcolor="#ff8c00">
				<td align=center nowrap><font color=white><B>Start Date</B></font></td>
				<td align=center nowrap><font color=white><B>End Date</B></font></td>
				<td align=center nowrap><font color=white><B>Start</B></font></td>
				<td align=center nowrap><font color=white><B>End</B></font></td>
				<td align=center nowrap><font color=white><B>Paid</B></font></td>
				<td align=center nowrap><font color=white><B>LWP</B></font></td>
				<td align=center nowrap><font color=white><B>Absent</B></font></td>
				<td align=center nowrap><font color=white><B>Status</B></font></td>						
				<td align=center nowrap><font color=white><B>Date</B></font></td>
				</tr>
				</thead>
				<tbody>
				<%
				mSno=0;
				while(rs.next())
				{
					mSno++;
					//out.print(mSno);
					%>
					<tr>
					<td align=center><font color=<%=mColor%>><%=rs.getString("LCODE")%></font></td>
					<td align=center><font color=<%=mColor%>><%=rs.getString("SDATE")%></font></td>
					<td align=center><font color=<%=mColor%>><%=rs.getString("EDATE")%></font></td>
					<td align=center><font color=<%=mColor%>><%=rs.getString("SHDAY")%></font></td>
					<td align=center><font color=<%=mColor%>><%=rs.getString("EHDAY")%></font></td>
					<td align=right><font color=<%=mColor%>><%=rs.getDouble("PAID")%></font></td>
					<td align=right><font color=<%=mColor%>><%=rs.getDouble("LWP")%></font></td>
					<td align=right><font color=<%=mColor%>><%=rs.getDouble("ABSENT")%></font></td>
					<td align=left><font color=<%=mColor%>><%=rs.getString("JSTATUS")%></font></td>
					<td align=center><font color=<%=mColor%>><%=rs.getString("JDATE")%></font></td>
					</tr>
					<%
				}
				%>
				</tbody>
				</table>
				<%
			}
			else
			{
				%><CENTER><%
				out.print("<br><br>&nbsp <img src='../../../Images/Error1.jpg'>");
				out.print("&nbsp;<b><font size=3 face='Arial' color='Red'>Leave Application Entry not allowed to you!<br>&nbsp; &nbsp; &nbsp;&nbsp Kindly contact to concerned Department...</font> <br>");
				%></CENTER><%
			}
		//-----------------------------
		//---Enable Security Page Level  
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
}
%>
</form>
</body>
</html>