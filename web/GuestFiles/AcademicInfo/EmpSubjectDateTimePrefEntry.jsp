<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null, RS=null;
ResultSet rs1=null, rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="",qry1="",qry2="", Qry="";
String mfactype="", mSType="", mLTP1="L", mLTP2="T", mLTP3="P";
int ctr=0;
int n1=0, n2=0, n3=0, n4=0, n5=0, n6=0, n7=0, mFlag=0;
String QryRoom="", QrySubject="", mSubjDesc="", mSubjType="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mExam="",mE="";
String mexam="";
String mMon="", mTue="", mWed="", mThu="", mFri="", mSat="", mSun="";
String mTmpTimeFr1="",mTmpTimeFr2="",mTmpTimeFr3="",mTmpTimeFr4="", mTmpTimeFr5="", mTmpTimeFr6="", mTmpTimeFr7="";
String mTmpTimeTo1="",mTmpTimeTo2="",mTmpTimeTo3="",mTmpTimeTo4="", mTmpTimeTo5="", mTmpTimeTo6="", mTmpTimeTo7="";
String timepickerF1="",timepickerF2="",timepickerF3="",timepickerF4="", timepickerF5="", timepickerF6="", timepickerF7="";
String timepickerT1="",timepickerT2="",timepickerT3="",timepickerT4="", timepickerT5="", timepickerT6="", timepickerT7="";

String mMonChk="",mTueChk="",mWedChk="",mThuChk="", mFriChk="", mSatChk="", mSunChk="";
String qryss="",QrySubject1="";
ResultSet rss=null;

String msubj="", mSubj="";
String mRoom="", mROOM="";
String CurrDate="", mRTYPE="";


if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
}


qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";
rs=db.getRowset(qry);
if(rs.next())
  CurrDate=rs.getString(1);
else
  CurrDate="";	

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
 
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Class Day Time Preference entry by Employee ] </TITLE>
<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
 for (var i = 0; i < document.frm1.elements.length; i++) 
 {
  var e = document.frm1.elements[i]; 
  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
  { 
   e.checked = document.frm1.allbox.checked;
  }
 }
}

function un_check1(chk1,txt1,txt2)
{
  if ((chk1.name != 'allbox') && (chk1.type == 'checkbox')) 
  {
    if (chk1.checked==false)
    {
   	document.frm1.allbox.checked=chk1.checked;
	txt1.value='';
	txt2.value='';
    }
    else
    {
	var mStat=0;
	for (var i = 0; i < document.frm1.elements.length; i++) 
	{
	  var e = document.frm1.elements[i]; 
	  if ((e.name != 'allbox') && (e.type == 'checkbox') && (e.checked ==false)) 
	  { 
		mStat=1;
	  }
	}
	if(mStat==0)
	{
	   document.frm1.allbox.checked=true;
	}
	else
	{
	  document.frm1.allbox.checked=false;
	}
    }
  }
}
</SCRIPT>

<script type="text/javascript" src="js/TimePicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
	//-->
</script>
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

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
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
		qry="Select WEBKIOSK.ShowLink('110','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		String mPRCode="";
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
			qry=" Select PREVENTCODE from PREVENTS WHERE INSTITUTECODE='"+ mInstitute +"'";
			qry=qry+" AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInstitute +"'";
			qry=qry+" AND nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='E'";
			qry=qry+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='E' and MEMBERID='"+mDMemberID+"'";
			//qry=qry+" AND MEMBERID IN (select EmployeeID from hodlist where departmentcode in (select departmentcode from employeemaster where employeeid='"+mDMemberID+"'))";
			qry=qry+" AND trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N'";
			 //out.print(qry);
			rs=db.getRowset(qry);

			if(rs.next())
			{
			mPRCode=rs.getString("PREVENTCODE");
			qry=" Select nvl(LOADDISTRIBUTIONSTATUS,'D') LDS from PREVENTS WHERE INSTITUTECODE='"+ mInstitute +"'";
			qry=qry+" AND (PREVENTCODE)='"+mPRCode+"' and MEMBERTYPE<>'S' ";
			//qry=qry+" AND MEMBERID IN (select EmployeeID from hodlist where departmentcode in (select departmentcode from employeemaster where employeeid='"+mDMemberID+"'))";
			rs=db.getRowset(qry);

				if(rs.next() && !rs.getString("LDS").equals("A"))
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

				%>
				<form name="frm"  method="get" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Faculty Room Type and Class Day Time Preference [Pre Registration]</b></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>
				<tr>
				<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Exam Code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				try
				{
					qry="Select Distinct nvl(PREREGEXAMID,' ') Exam from DEFAULTVALUES";
					rs=db.getRowset(qry);
					if (request.getParameter("x")==null) 
				 	{
						%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%   
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mexam.equals(""))
							{
 							mexam=mExam;
							%>
							<OPTION Selected Value=<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
							}
							else
							{
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
							}
						}
						%>
						</select>
						<%
					}
					else
					{
						%>	
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mExam.equals(request.getParameter("Exam").toString().trim()))
				 			{
								mexam=mExam;
								%>
								<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
								<%			
						     	}
						     	else
							{
								%>
							      <OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
						      	<%			
						   	}
						}
						%>
						</select>
					  	<%
					 }
				}
				catch(Exception e)
				{
				}
				%>
				</td>
				<!--*********Subject**********-->
				<td>&nbsp; &nbsp; &nbsp; &nbsp;<FONT color=black face=Arial size=2><b>Subject</b></FONT>&nbsp; &nbsp;
				<%
				qry="Select Distinct nvl(A.SUBJECTID,' ')||'('||nvl(A.SUBJECTTYPE,'C')||')' SDESC, nvl(B.SUBJECTCODE,' ') SCode, nvl(B.SUBJECT,' ')Subj from PR#FACULTYSUBJECTCHOICES A, SUBJECTMASTER B where A.SUBJECTID=B.SUBJECTID ";
				qry=qry+"AND A.INSTITUTECODE='"+mInstitute+"' and A.FACULTYID='"+mChkMemID+"' and nvl(A.DEACTIVE,'N')='N' order by Subj";
				//out.print(qry);
				rs=db.getRowset(qry);
				if (request.getParameter("x")==null) 
				{
					%>
					<select name=Subj tabindex="0" id="Subj" style="WIDTH: 270px">
					<%
					while(rs.next())
					{
						msubj=rs.getString("SDESC");
						if(QrySubject.equals(""))
						{
							QrySubject=msubj;
							%>
							<OPTION Selected Value=<%=rs.getString("SDesc")%>><%=rs.getString("Subj")%> [<%=rs.getString("SCode")%>]</option>
							<%
						}
						else
						{
							%>
							<OPTION Value=<%=rs.getString("SDesc")%>><%=rs.getString("Subj")%> [<%=rs.getString("SCode")%>]</option>
							<%
						}
					}
					%>
					</select>
					<%
				}
				else
				{
					%>
					<select name=Subj tabindex="0" id="Subj" style="WIDTH: 270px">
					<%
					while(rs.next())
					{
						QrySubject=rs.getString("SDESC");
						if(QrySubject.equals(request.getParameter("Subj").toString().trim()))
		 				{
							msubj=QrySubject;
							%>
							<OPTION Selected Value =<%=rs.getString("SDesc")%>><%=rs.getString("Subj")%> [<%=rs.getString("SCode")%>]</option>
							<%			
					     	}
					     	else
				      	{
							%>
							<OPTION Value =<%=rs.getString("SDesc")%>><%=rs.getString("Subj")%> [<%=rs.getString("SCode")%>]</option>
					      	<%			
					   	}
					}
					%>
					</select>
				  	<%
				}
				%>
				<INPUT id=submit style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="OK" name=submit>
				</table>
				</form>
				<%
				if (request.getParameter("Exam")==null)
					mE=mExam;
				else
					mE=request.getParameter("Exam").toString().trim();
		
				if (request.getParameter("Subj")==null)
					mSubjDesc=QrySubject;
				else
				{
					mSubjDesc=request.getParameter("Subj").toString().trim();					
				}
				int len=0;
				int pos1=0;
				len=mSubjDesc.length();
				pos1=mSubjDesc.indexOf("(");
				QrySubject=mSubjDesc.substring(0,pos1);
				mSubjType=mSubjDesc.substring(pos1+1,len-1);

				if(mDMemberType.equals("E"))
					 mfactype="I";	
				else if(mDMemberType.equals("V"))
					 mfactype="E";

				qryss="select subjectcode from subjectmaster where subjectid='"+QrySubject+"' ";
				rss=db.getRowset(qryss);
				rss.next();
			QrySubject1=rss.getString(1);

		
				%>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<form name="frm1" ID="frm1" Action="EmpSubjectDateTimePrefAction.jsp" method=post>
				<input id="y" name="y" type=hidden>
				<tr bgcolor=lightyellow><td colspan=3 align=center><FONT color=black face=Arial size=2><STRONG>&nbsp;Prefered Room Type for <font color="#00008b"><u><%=QrySubject1%></u></font>&nbsp;</STRONG></FONT>
				<!--*********Room Type**********-->
				<%
				qry2="Select Distinct nvl(REQROOMTYPE,' ') ROOMTYPE from PR#FACULTYDAYTIMEPREFERENCE A Where ";
				qry2=qry2+" A.INSTITUTECODE='"+mInstitute+"' AND A.EXAMCODE='"+mE+"' AND A.FACULTYID='"+mChkMemID+"'";
				qry2=qry2+" and A.SUBJECTID='"+QrySubject+"' and nvl(A.DEACTIVE,'N')='N'";
				rs2=db.getRowset(qry2);
				//out.print(qry2);
				if(rs2.next())
					mROOM=rs2.getString("ROOMTYPE");
				else
					mROOM="";
				try
				{
					qry1="Select Distinct nvl(ROOMTYPE,' ') ROOMTYPE, NVL(ROOMTYPEDESC,' ')ROOMTYPEDESC from ROOMTYPE Where nvl(Deactive,'N')='N' order by ROOMTYPEDESC";
					rs1=db.getRowset(qry1);
					//out.print(qry1);
	
					%>
					 <Select Name="RoomType" tabindex="0" id="RoomType" style="WIDTH: 140px">
					<%
						QryRoom="NONE";
					%>
				 		<OPTION selected value=NONE>Select Room Type</option>
					<%
						while(rs1.next())
						{
					   		mRoom=rs1.getString("ROOMTYPE");
							if(mRoom.equals(mROOM.toString().trim()))
							{
								QryRoom=mRoom;
								%>
							    	<OPTION SELECTED Value=<%=mRoom%>><%=GlobalFunctions.toTtitleCase(rs1.getString("ROOMTYPEDESC"))%></option>
								<%
							}
							else
						      {
							    	%>
							    	<OPTION Value=<%=mRoom%>><%=GlobalFunctions.toTtitleCase(rs1.getString("ROOMTYPEDESC"))%></option>
						   		<%
					    		}
						}
					
					%>
					</select>
				  	<%
				}
				catch(Exception e)
				{
					//out.println("Error Msg");
				}
				%>
				</td></tr></table><br>

				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<tr bgcolor='#e68a06'>
				 <th valign=top><font color=White>Prefered Day</font></th>
				 <th valign=top><font color=White>Pref.<br><input onClick="un_check()" type="checkbox" id='allbox' name='allbox' value='Y'></font></th>
				 <th valign=top><font color=White>Prefered Class Time</font><br><font size=1 face='Arial' color='lightyellow'>Time Format: HH:MI am/pm</font></th>
				</tr>
				<%
					qry="select Distinct nvl(A.PREFDAY,' ')PREFDAY, ";
					qry=qry+" nvl(A.PREFFROMTIME,' ') PTF, nvl(A.PREFTOTIME,' ') PTT, nvl(A.REQROOMTYPE,' ')RMT";
					qry=qry+" from PR#FACULTYDAYTIMEPREFERENCE A where A.SUBJECTID='"+QrySubject+"' AND";
					qry=qry+" A.INSTITUTECODE='"+mInstitute+"' AND A.EXAMCODE='"+mE+"' AND A.FACULTYID='"+mChkMemID+"'";
					qry=qry+" AND A.FACULTYTYPE='"+mfactype+"' and nvl(A.DEACTIVE,'N')='N' ";
					//out.print(qry);
					rs=db.getRowset(qry);
					%>
					<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
					<input type=hidden Name='ExamCode' ID='ExamCode' value='<%=mE%>'>
					<input type=hidden Name='Subject' ID='Subject' value='<%=mSubjDesc%>'>
					<%
					while(rs.next())
					{
						if(rs.getString("PREFDAY").equals("MON"))
						{
							mMon=rs.getString("PREFDAY");
							mTmpTimeFr1=rs.getString("PTF");
							mTmpTimeTo1=rs.getString("PTT");
						}
						if(rs.getString("PREFDAY").equals("TUE"))
						{
							mTue=rs.getString("PREFDAY");
							mTmpTimeFr2=rs.getString("PTF");
							mTmpTimeTo2=rs.getString("PTT");
						}
						if(rs.getString("PREFDAY").equals("WED"))
						{
							mWed=rs.getString("PREFDAY");
							mTmpTimeFr3=rs.getString("PTF");
							mTmpTimeTo3=rs.getString("PTT");
						}
						if(rs.getString("PREFDAY").equals("THU"))
						{
							mThu=rs.getString("PREFDAY");
							mTmpTimeFr4=rs.getString("PTF");
							mTmpTimeTo4=rs.getString("PTT");
						}
						if(rs.getString("PREFDAY").equals("FRI"))
						{
							mFri=rs.getString("PREFDAY");
							mTmpTimeFr5=rs.getString("PTF");
							mTmpTimeTo5=rs.getString("PTT");
						}
						if(rs.getString("PREFDAY").equals("SAT"))
						{
							mSat=rs.getString("PREFDAY");
							mTmpTimeFr6=rs.getString("PTF");
							mTmpTimeTo6=rs.getString("PTT");
						}
						if(rs.getString("PREFDAY").equals("SUN"))
						{
							mSun=rs.getString("PREFDAY");
							mTmpTimeFr7=rs.getString("PTF");
							mTmpTimeTo7=rs.getString("PTT");
						}
					}
					%>
					<tr>
						<td><FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Monday</STRONG></FONT></td>
						<%
						if(mTmpTimeFr1.toString().trim().equals("") && mTmpTimeTo1.toString().trim().equals(""))
						{
						%>
						<td align=center><input onClick="un_check1(MonChk,timepickerF1,timepickerT1)" type='checkbox' name='MonChk' id='MonChk' value='MON'></td>
						<%
						}
						else
						{
						%>
						<td align=center><input onClick="un_check1(MonChk,timepickerF1,timepickerT1)" type='checkbox' checked name='MonChk' id='MonChk' value='MON'></td>
						<%
						}
						%>
						<td nowrap><input id='timepickerF1' name='timepickerF1' type='text' value='<%=mTmpTimeFr1%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerF1)" STYLE="cursor:hand">
						<STRONG><FONT color=black face=Arial size=2>to</FONT></STRONG>
						<input id='timepickerT1' name='timepickerT1' type='text' value='<%=mTmpTimeTo1%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerT1)" STYLE="cursor:hand"></td>
					</tr>
					<tr>
						<td><FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Tuesday</STRONG></FONT></td>
						<%
						if(mTmpTimeFr2.toString().trim().equals("") && mTmpTimeTo2.toString().trim().equals(""))
						{
						%>
						<td align=center><input onClick="un_check1(TueChk,timepickerF2,timepickerT2)" type='checkbox' name='TueChk' id='TueChk' value='TUE'></td>
						<%
						}
						else
						{
						%>
						<td align=center><input onClick="un_check1(TueChk,timepickerF2,timepickerT2)" type='checkbox' checked name='TueChk' id='TueChk' value='TUE'></td>
						<%
						}
						%>
						<td nowrap><input id='timepickerF2' name='timepickerF2' type='text' value='<%=mTmpTimeFr2%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerF2)" STYLE="cursor:hand">
						<STRONG><FONT color=black face=Arial size=2>to</FONT></STRONG>
						<input id='timepickerT2' name='timepickerT2' type='text' value='<%=mTmpTimeTo2%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerT2)" STYLE="cursor:hand"></td>
					</tr>
					<tr>
						<td><FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Wednessday&nbsp;</STRONG></FONT></td>
						<%
						if(mTmpTimeFr3.toString().trim().equals("") && mTmpTimeTo3.toString().trim().equals(""))
						{
						%>
						<td align=center><input onClick="un_check1(WedChk,timepickerF3,timepickerT3)" type='checkbox' name='WedChk' id='WedChk' value='WED'></td>
						<%
						}
						else
						{
						%>
						<td align=center><input onClick="un_check1(WedChk,timepickerF3,timepickerT3)" type='checkbox' checked name='WedChk' id='WedChk' value='WED'></td>
						<%
						}
						%>
						<td nowrap><input id='timepickerF3' name='timepickerF3' type='text' value='<%=mTmpTimeFr3%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerF3)" STYLE="cursor:hand">
						<STRONG><FONT color=black face=Arial size=2>to</FONT></STRONG>
						<input id='timepickerT3' name='timepickerT3' type='text' value='<%=mTmpTimeTo3%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerT3)" STYLE="cursor:hand"></td>
					</tr>
					<tr>
						<td><FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Thrusday</STRONG></FONT></td>
						<%
						if(mTmpTimeFr4.toString().trim().equals("") && mTmpTimeTo4.toString().trim().equals(""))
						{
						%>
						<td align=center><input onClick="un_check1(ThuChk,timepickerF4,timepickerT4)" type='checkbox' name='ThuChk' id='ThuChk' value='THU'></td>
						<%
						}
						else
						{
						%>
						<td align=center><input onClick="un_check1(ThuChk,timepickerF4,timepickerT4)" type='checkbox' checked name='ThuChk' id='ThuChk' value='THU'></td>
						<%
						}
						%>
						<td nowrap><input id='timepickerF4' name='timepickerF4' type='text' value='<%=mTmpTimeFr4%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerF4)" STYLE="cursor:hand">
						<STRONG><FONT color=black face=Arial size=2>to</FONT></STRONG>
						<input id='timepickerT4' name='timepickerT4' type='text' value='<%=mTmpTimeTo4%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerT4)" STYLE="cursor:hand"></td>
					</tr>
					<tr>
						<td><FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Friday</STRONG></FONT></td>
						<%
						if(mTmpTimeFr5.toString().trim().equals("") && mTmpTimeTo5.toString().trim().equals(""))
						{
						%>
						<td align=center><input onClick="un_check1(FriChk,timepickerF5,timepickerT5)" type='checkbox' name='FriChk' id='FriChk' value='FRI'></td>
						<%
						}
						else
						{
						%>
						<td align=center><input onClick="un_check1(FriChk,timepickerF5,timepickerT5)" type='checkbox' checked name='FriChk' id='FriChk' value='FRI'></td>
						<%
						}
						%>
						<td nowrap><input id='timepickerF5' name='timepickerF5' type='text' value='<%=mTmpTimeFr5%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerF5)" STYLE="cursor:hand">
						<STRONG><FONT color=black face=Arial size=2>to</FONT></STRONG>
						<input id='timepickerT5' name='timepickerT5' type='text' value='<%=mTmpTimeTo5%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerT5)" STYLE="cursor:hand"></td>
					</tr>
					<tr>
						<td><FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Saturday</STRONG></FONT></td>
						<%
						if(mTmpTimeFr6.toString().trim().equals("") && mTmpTimeTo6.toString().trim().equals(""))
						{
						%>
						<td align=center><input onClick="un_check1(SatChk,timepickerF6,timepickerT6)" type='checkbox' name='SatChk' id='SatChk' value='SAT'></td>
						<%
						}
						else
						{
						%>
						<td align=center><input onClick="un_check1(SatChk,timepickerF6,timepickerT6)" type='checkbox' checked name='SatChk' id='SatChk' value='SAT'></td>
						<%
						}
						%>
						<td nowrap><input id='timepickerF6' name='timepickerF6' type='text' value='<%=mTmpTimeFr6%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerF6)" STYLE="cursor:hand">
						<STRONG><FONT color=black face=Arial size=2>to</FONT></STRONG>
						<input id='timepickerT6' name='timepickerT6' type='text' value='<%=mTmpTimeTo6%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerT6)" STYLE="cursor:hand"></td>
					</tr>
					<tr>
						<td><FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Sunday</STRONG></FONT></td>
						<%
						if(mTmpTimeFr7.toString().trim().equals("") && mTmpTimeTo7.toString().trim().equals(""))
						{
						%>
						<td align=center><input onClick="un_check1(SunChk,timepickerF7,timepickerT7)" type='checkbox' name='SunChk' id='SunChk' value='SUN'></td>
						<%
						}
						else
						{
						%>
						<td align=center><input onClick="un_check1(SunChk,timepickerF7,timepickerT7)" type='checkbox' checked name='SunChk' id='SunChk' value='SUN'></td>
						<%
						}
						%>
						<td nowrap><input id='timepickerF7' name='timepickerF7' type='text' value='<%=mTmpTimeFr7%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerF7)" STYLE="cursor:hand">
						<STRONG><FONT color=black face=Arial size=2>to</FONT></STRONG>
						<input id='timepickerT7' name='timepickerT7' type='text' value='<%=mTmpTimeTo7%>' size=6 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepickerT7)" STYLE="cursor:hand"></td>
					</tr>

					<TR><TD colspan=3 ALIGN=CENTER>&nbsp; &nbsp;<INPUT Type="submit" Value="Save"></TD></TR>
					</form>
					</TABLE>
					<%
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

					mTmpTimeFr1=mTmpTimeFr1.toLowerCase();
					mTmpTimeTo1=mTmpTimeTo1.toLowerCase();

					mTmpTimeFr2=mTmpTimeFr2.toLowerCase();
					mTmpTimeTo2=mTmpTimeTo2.toLowerCase();

					mTmpTimeFr3=mTmpTimeFr3.toLowerCase();
					mTmpTimeTo3=mTmpTimeTo3.toLowerCase();

					mTmpTimeFr4=mTmpTimeFr4.toLowerCase();
					mTmpTimeTo4=mTmpTimeTo4.toLowerCase();

					mTmpTimeFr5=mTmpTimeFr5.toLowerCase();
					mTmpTimeTo5=mTmpTimeTo5.toLowerCase();

					mTmpTimeFr6=mTmpTimeFr6.toLowerCase();
					mTmpTimeTo6=mTmpTimeTo6.toLowerCase();

					mTmpTimeFr7=mTmpTimeFr7.toLowerCase();
					mTmpTimeTo7=mTmpTimeTo7.toLowerCase();

					%>
					<input type=hidden Name='RoomType' ID='RoomType' value='<%=QryRoom%>'>
					<input type=hidden Name='MonChk' ID='MonChk' value='<%=mMonChk%>'>
					<input type=hidden Name='TueChk' ID='TueChk' value='<%=mTueChk%>'>
					<input type=hidden Name='WedChk' ID='WedChk' value='<%=mWedChk%>'>
					<input type=hidden Name='ThuChk' ID='ThuChk' value='<%=mThuChk%>'>
					<input type=hidden Name='FriChk' ID='FriChk' value='<%=mFriChk%>'>
					<input type=hidden Name='SatChk' ID='SatChk' value='<%=mSatChk%>'>
					<input type=hidden Name='SunChk' ID='SunChk' value='<%=mSunChk%>'>
					<input type=hidden Name='timepickerF1' ID='timepickerF1' value='<%=mTmpTimeFr1%>'>
					<input type=hidden Name='timepickerF2' ID='timepickerF2' value='<%=mTmpTimeFr2%>'>
					<input type=hidden Name='timepickerF3' ID='timepickerF3' value='<%=mTmpTimeFr3%>'>
					<input type=hidden Name='timepickerF4' ID='timepickerF4' value='<%=mTmpTimeFr4%>'>
					<input type=hidden Name='timepickerF5' ID='timepickerF5' value='<%=mTmpTimeFr5%>'>
					<input type=hidden Name='timepickerF6' ID='timepickerF6' value='<%=mTmpTimeFr6%>'>
					<input type=hidden Name='timepickerF7' ID='timepickerF7' value='<%=mTmpTimeFr7%>'>
					<input type=hidden Name='timepickerT1' ID='timepickerT1' value='<%=mTmpTimeTo1%>'>
					<input type=hidden Name='timepickerT2' ID='timepickerT2' value='<%=mTmpTimeTo2%>'>
					<input type=hidden Name='timepickerT3' ID='timepickerT3' value='<%=mTmpTimeTo3%>'>
					<input type=hidden Name='timepickerT4' ID='timepickerT4' value='<%=mTmpTimeTo4%>'>
					<input type=hidden Name='timepickerT5' ID='timepickerT5' value='<%=mTmpTimeTo5%>'>
					<input type=hidden Name='timepickerT6' ID='timepickerT6' value='<%=mTmpTimeTo6%>'>
					<input type=hidden Name='timepickerT7' ID='timepickerT7' value='<%=mTmpTimeTo7%>'>
					<%
				}
				else
				{
					%>
					<font color=red>
					<h3><br><img src='../../Images/Error1.jpg'>
					Pre- Registration Load Distribution has been approved! <br><b>Click to view <a href='EmpSubjectChoiceView.jsp'><font color=blue>Subject Choices and its Class-Time Preferences </font></a></b>
					<%
				}
			}
  			else
			{
			%>
			<font color=red>
			<h3>	<br><img src='../../Images/Error1.jpg'>
			Pre- Registration Event has not been declared or Registration completed</FONT></P>
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
		<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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