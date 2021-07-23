<%@ page language="java" import="java.sql.*,java.util.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="";
String WFCode="LEAVE";
String QryAOS1="", QryAOS2="", QryAOS3="", QryCity="";
String QryState="", QryDist="", QryCnt="", QryPh="", QryMbl="";
String QryArrOfCl="", QryPOS="", QryPin="", FlagJDate="", mJDate="";
double mLvPayable=0, mLvWithout=0;
double mLeaveDays=0;
String mLeaveReq="";
String QryFaculty="";
String QryLeave="", mLeaveYear="";
String mStartHalfDay="",mEndHalfDay="";
String mCategoryCode="";
String QryReason="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String mInst="";
String mDate1="", mDate2="", mCurrDate="", mNextDate="";
String mTotLvTermFlag="";
int NoOfTimeInYr=0,NoOfTimeInTr=0,mTermInYr=0,mTermInTr=0, mLvTermFlag=0;

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
<head>
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
	if (myDate1 > myDate2) 
	//alert('"Leave Period To" must be greater than or equal to "Leave Period From" !');
	return true;
}
function ChangeOnLeaveStatus()
{
	alert('Hello');
	document.frm1.action="LeaveRequestSelf.jsp";
	document.frm1.submit();
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
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
		qry="Select WEBKIOSK.ShowLink('142','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
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
			qry="Select nvl(EMPCATEGORYCODE,'REG')CATEGORYCODE from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"'";
			rs=db.getRowset(qry);
			if(rs.next())
			{
				mCategoryCode=rs.getString("CATEGORYCODE");
			}
			if (request.getParameter("Comp")!=null)
				mComp=request.getParameter("Comp").toString().trim();
			else
				mComp="";
			if (request.getParameter("Inst")!=null)
				mInst=request.getParameter("Inst").toString().trim();
			else
				mInst="";
			if (request.getParameter("LeaveDays")!=null)
				mLeaveDays=Double.parseDouble(request.getParameter("LeaveDays"));
			else
				mLeaveDays=0;
			if (request.getParameter("Pay")!=null)
				mLvPayable=Double.parseDouble(request.getParameter("Pay"));
			else
				mLvPayable=0;
			if (request.getParameter("WithoutPay")!=null)
				mLvWithout=Double.parseDouble(request.getParameter("WithoutPay"));
			else
				mLvWithout=0;
			if (request.getParameter("FromLunch")!=null)
				mStartHalfDay=request.getParameter("FromLunch").toString().trim();
			else
				mStartHalfDay="N";
			if (request.getParameter("ToLunch")!=null)
				mEndHalfDay=request.getParameter("ToLunch").toString().trim();
			else
				mEndHalfDay="N";
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
				mStartHalfDay="N";
			if (request.getParameter("ToLunch")!=null)
				mEndHalfDay=request.getParameter("ToLunch").toString().trim();
			else
				mEndHalfDay="N";
			if (request.getParameter("PurposeOfLeave")!=null)
				QryReason=request.getParameter("PurposeOfLeave").toString().trim();
			else
				QryReason="";
			if (request.getParameter("PeriodOfStation")!=null)
				QryPOS=request.getParameter("PeriodOfStation").toString().trim();
			else
				QryPOS="";
			if (request.getParameter("AOS1")!=null)
				QryAOS1=request.getParameter("AOS1").toString().trim();
			else
				QryAOS1="";
			if (request.getParameter("AOS2")!=null)
				QryAOS2=request.getParameter("AOS2").toString().trim();
			else
				QryAOS2="";
			if (request.getParameter("AOS3")!=null)
				QryAOS3=request.getParameter("AOS3").toString().trim();
			else
				QryAOS3="";
			if (request.getParameter("City")!=null)
				QryCity=request.getParameter("City").toString().trim();
			else
				QryCity="";
			if (request.getParameter("Dist")!=null)
				QryDist=request.getParameter("Dist").toString().trim();
			else
				QryDist="";
			if (request.getParameter("Pin")!=null)
				QryPin=request.getParameter("Pin").toString().trim();
			else
				QryPin="";
			if (request.getParameter("State")!=null)
				QryState=request.getParameter("State").toString().trim();
			else
				QryState="";
			if (request.getParameter("Cnt")!=null)
				QryCnt=request.getParameter("Cnt").toString().trim();
			else
				QryCnt="";
			if (request.getParameter("Phone")!=null)
				QryPh=request.getParameter("Phone").toString().trim();
			else
				QryPh="";
			if (request.getParameter("Mobile")!=null)
				QryMbl=request.getParameter("Mobile").toString().trim();
			else
				QryMbl="";
			if (request.getParameter("JDate")!=null)
				FlagJDate=request.getParameter("JDate").toString().trim();
			else
				FlagJDate="";
			if(FlagJDate.equals("Last"))
			{
				mJDate=mDate2;
			}
			else
			{
				qry="select to_char(to_date('"+mDate2+"','dd-mm-yyyy')+1) JDate from dual";
				rs=db.getRowset(qry);
				if(rs.next())
				mJDate=rs.getString("JDate");
			}
			if (request.getParameter("Arrangement")!=null)
				QryArrOfCl=request.getParameter("Arrangement").toString().trim();
			else
				QryArrOfCl="";
			if (request.getParameter("TERMINYR")!=null)
				NoOfTimeInYr=Integer.parseInt(request.getParameter("TERMINYR").toString().trim());
			else
				NoOfTimeInYr=0;

			if (request.getParameter("TERMINTR")!=null)
				NoOfTimeInTr=Integer.parseInt(request.getParameter("TERMINTR").toString().trim());
			else
				NoOfTimeInTr=0;

			if(mStartHalfDay.equals("None"))
				mStartHalfDay="N";
			if(mEndHalfDay.equals("None"))
				mEndHalfDay="N";

			%>
			<table width=100% align=center><tr><td align=center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> Leave Application Entry </FONT></u></b></font></td></tr></table>
			<%
			if(mLeaveDays>0)
			{
				if(!QryReason.equals(""))
				{
				   if(gb.isNumeric(QryPin)==true || QryPin.equals(""))
				   {
					//out.print(QryArrOfCl+" "+QryAOS1+" "+QryAOS2+" "+QryAOS3+" "+QryPOS);
					qry="Select 'Y' from LeaveRequest where EMPLOYEEID='"+mChkMemID+"' ";
					qry=qry+" and (STARTDATE between (to_date('"+mDate1+"','dd-mm-yyyy'))";
					qry=qry+" and (to_date('"+mDate2+"','dd-mm-yyyy'))";
					qry=qry+" or ENDDATE between (to_date('"+mDate1+"','dd-mm-yyyy'))";
					qry=qry+" and (to_date('"+mDate2+"','dd-mm-yyyy')))";
					qry=qry+" UNION Select 'Y' from LeaveTransaction where EMPLOYEEID='"+mChkMemID+"' ";
					qry=qry+" and (STARTDATE between (to_date('"+mDate1+"','dd-mm-yyyy'))";
					qry=qry+" and (to_date('"+mDate2+"','dd-mm-yyyy'))";
					qry=qry+" or ENDDATE between (to_date('"+mDate1+"','dd-mm-yyyy'))";
					qry=qry+" and (to_date('"+mDate2+"','dd-mm-yyyy')))";
					rs=db.getRowset(qry);
					//out.print(qry);
					if(!rs.next())
					{
						mLeaveReq=db.GetRequestID(mComp,mInst,WFCode);
						qry="Select nvl(LEAVEYEARCODE,' ') LC From LEAVEYEAR WHERE COMPANYCODE='"+mComp+"' AND (to_date('"+mDate1+"','dd-mm-yyyy')) between FROMDATE and TODATE";
						rs=db.getRowset(qry);
						//out.print(qry);
						if(rs.next())
						{
							mLeaveYear=rs.getString("LC");
						}
						if(NoOfTimeInYr>0 || NoOfTimeInTr>0)
						{
							qry="SELECT count(*) TermInYr from LEAVETRANSACTION where COMPANYCODE='"+mComp+"' and EMPCATEGORYCODE IN ('"+mCategoryCode+"','ALL') and EMPLOYEEID = '"+mChkMemID+"' and LEAVECODE='"+QryLeave+"' and LEAVEYEARCODE='"+mLeaveYear+"' GROUP BY COMPANYCODE, EMPCATEGORYCODE, EMPLOYEEID, LEAVECODE, LEAVEYEARCODE";
							rs=db.getRowset(qry);
							//out.print(qry);
							if(rs.next())
							{
								mTermInYr=rs.getInt("TermInYr");
							}
							qry="SELECT count(*) TermInTr from LEAVETRANSACTION where COMPANYCODE='"+mComp+"' and EMPCATEGORYCODE IN ('"+mCategoryCode+"','ALL') and EMPLOYEEID = '"+mChkMemID+"' and LEAVECODE='"+QryLeave+"' GROUP BY COMPANYCODE, EMPCATEGORYCODE, EMPLOYEEID, LEAVECODE";
							rs=db.getRowset(qry);
							//out.print(qry);
							if(rs.next())
							{
								mTermInTr=rs.getInt("TermInTr");
							}
							mTotLvTermFlag="Y";
						}
					//-----------------Start Insert Here---------------
						qry="";
						if(mTotLvTermFlag.equals("Y"))
						{
							if(mTermInYr<=NoOfTimeInYr || mTermInTr<=NoOfTimeInTr)
							{
								qry="INSERT INTO LEAVEREQUEST (COMPANYCODE, EMPCATEGORYCODE, EMPLOYEEID, LEAVECODE, STARTDATE, ENDDATE, STARTHALFDAY, ENDHALFDAY, PAID, WITHOUTPAY, LEAVEYEARCODE, PURPOSEOFLEAVE, STATIONLEAVE, ARRFORCLASSESREMARKS, ADDRESS1, ADDRESS2, ADDRESS3, CITY, DISTRICT, STATE, PIN, COUNTRY, PHONENOS, MOBILE, JOININGDATE, REQUESTID, ENTRYBY, ENTRYDATE, WORKFLOWCODE, WORKFLOWTYPE) ";
								qry=qry+" VALUES ('"+mComp+"','"+mCategoryCode+"','"+mChkMemID+"','"+QryLeave+"',(to_date('"+mDate1+"','dd-mm-yyyy')),(to_date('"+mDate2+"','dd-mm-yyyy')),'"+mStartHalfDay+"','"+mEndHalfDay+"','"+mLvPayable+"','"+mLvWithout+"','"+mLeaveYear+"','"+QryReason+"','"+QryPOS+"','"+QryArrOfCl+"','"+QryAOS1+"','"+QryAOS2+"','"+QryAOS3+"','"+QryCity+"','"+QryDist+"','"+QryState+"','"+QryPin+"','"+QryCnt+"','"+QryPh+"','"+QryMbl+"',(to_date('"+mJDate+"','dd-mm-yyyy')),'"+mLeaveReq+"','"+mDMemberID+"',SYSDATE,'LEAVE','"+QryLeave+"')";
							}
							else
							{
								mLvTermFlag++;
							}
						}
						else
						{
							qry="INSERT INTO LEAVEREQUEST (COMPANYCODE, EMPCATEGORYCODE, EMPLOYEEID, LEAVECODE, STARTDATE, ENDDATE, STARTHALFDAY, ENDHALFDAY, PAID, WITHOUTPAY, LEAVEYEARCODE, PURPOSEOFLEAVE, STATIONLEAVE, ARRFORCLASSESREMARKS, ADDRESS1, ADDRESS2, ADDRESS3, CITY, DISTRICT, STATE, PIN, COUNTRY, PHONENOS, MOBILE, JOININGDATE, REQUESTID, ENTRYBY, ENTRYDATE, WORKFLOWCODE, WORKFLOWTYPE) ";
							qry=qry+" VALUES ('"+mComp+"','"+mCategoryCode+"','"+mChkMemID+"','"+QryLeave+"',(to_date('"+mDate1+"','dd-mm-yyyy')),(to_date('"+mDate2+"','dd-mm-yyyy')),'"+mStartHalfDay+"','"+mEndHalfDay+"','"+mLvPayable+"','"+mLvWithout+"','"+mLeaveYear+"','"+QryReason+"','"+QryPOS+"','"+QryArrOfCl+"','"+QryAOS1+"','"+QryAOS2+"','"+QryAOS3+"','"+QryCity+"','"+QryDist+"','"+QryState+"','"+QryPin+"','"+QryCnt+"','"+QryPh+"','"+QryMbl+"',(to_date('"+mJDate+"','dd-mm-yyyy')),'"+mLeaveReq+"','"+mDMemberID+"',SYSDATE,'LEAVE','"+QryLeave+"')";
						}
						int n=0;
						n=db.insertRow(qry);
						//out.print(qry);
						if(n>0)
						{
							%><CENTER><br><br><%
							out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>Leave Request Successful...</font> <br>");
							%></CENTER><%
							qry="Select Employeecode from Employeemaster where employeeid='"+QryFaculty+"'";
							rs=db.getRowset(qry);
							rs.next();
						  //-----------Log Entry------------
							db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"LEAVE APPLICATION ENTRY BY INDV. LOGIN", "Staff: "+rs.getString(1)+" Leave From: "+mDate1+" To: "+mDate2+" Start HalfDay: "+mStartHalfDay+" End HalfDay: "+mEndHalfDay, "No MAC Address" , mIPAddress);
						  //----------------------------------
							RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestSelf.jsp");
							request.setAttribute("message","Msg1");
							rd.forward(request,response);
						}
						else if(mLvTermFlag>0)
						{
							RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestSelf.jsp");
							request.setAttribute("message","Msg8");
							rd.forward(request,response);
							%><CENTER><br><br><%
							out.print("<img src='../../../Images/Error1.jpg'>");
							out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Total Terms of Leave in the Year or Tenure have been availed!</font> <br>");
							%></CENTER><%
						}
						else
						{
							RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestSelf.jsp");
							request.setAttribute("message","Msg2");
							rd.forward(request,response);
							%><CENTER><br><br><%
							out.print("<img src='../../../Images/Error1.jpg'>");
							out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error while Leave Request! &nbsp; Kindly review the Leave criteria...</font> <br>");
							%></CENTER><%
						}
					//-----------------End Insert Here-----------------
					}
					else
					{
						RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestSelf.jsp");
						request.setAttribute("message","Msg3");
						rd.forward(request,response);
						%><CENTER><br><br><%
						out.print("<img src='../../../Images/Error1.jpg'>");
						out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Leave already requested during this period! &nbsp; Kindly choose different Date(s)...</font> <br>");
						%></CENTER><%
					}
				   }
				   else
				   {
					   RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestSelf.jsp");
					   request.setAttribute("message","Msg4");
					   rd.forward(request,response);
					   %><CENTER><br><br><%
					   out.print("<img src='../../../Images/Error1.jpg'>");
					   out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>PIN No should be Numeric only!</font> <br>");
					   %></CENTER><%
				   }
				}
				else
				{
					RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestSelf.jsp");
					request.setAttribute("message","Msg5");
					rd.forward(request,response);
					%><CENTER><br><br><%
					out.print("<img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Purpose of Leave can't be Empty!</font> <br>");
					%></CENTER><%
				}
			}
			else
			{
				RequestDispatcher rd=request.getRequestDispatcher("LeaveRequestSelf.jsp");
				request.setAttribute("message","Msg7");
				rd.forward(request,response);
				%><CENTER><br><br><%
				out.print("<img src='../../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>'Leave Period To' must be greater than or equal to 'Leave Period From' !</font>");
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
			<h3><br><img src='../../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team.
			</font><br><br><br><br>
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
	//out.print("Catch Block");	
}
%>
</body>
</html>