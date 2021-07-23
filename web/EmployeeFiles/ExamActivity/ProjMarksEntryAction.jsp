<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mDesg="",mDept="",mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDMemberID="",mTotalRec="",mFstid="";
int ctr=0, Counter=0;
int mTotalCount=0;
String mExam="",mSemester="",mStudentid="",mINSTITUTECODE="",mEventsubevent="";
String mSubject="",mSID="",mDetained1="N", mDetained2="N", mProceed="", StudID="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName7="";
double mMax=0;
String mMarks1="", mMarks2="";
ResultSet rss=null,rs=null,RsChk=null;
String qry="";
String mDualMarks="",mMOP="",mSPrint1="",mSPrint2="",mStatus="";
double mPercMarks1=0,mPercMarks2=0,mMax1=0;

if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
//out.println(mself);
if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";

%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Project Marks Entry Action ] </TITLE>
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
function showAlert()
{
	if(document.frm2("Proceed").checked==true)
	{
		var mChoice=confirm('Once You will check and Lock Marks Entry, You cannot change marks of the students using this form! Continue...?');
		if (mChoice)
		{
			document.frm2("Proceed").checked=true;
		}
		else
		{
			document.frm2("Proceed").checked=false;
		}
	}
	else
	{
		alert('You cannot proceed for Grade entry until you check it and Lock Marks Entry!');
	}
	document.frm2("Proceed").focus;
}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
try
{
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

		qry="Select WEBKIOSK.ShowLink('60','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		{
  //----------------------
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
			if(request.getParameter("DualMarks")==null)
				mDualMarks="Y";
			else
				mDualMarks=request.getParameter("DualMarks").toString().trim();

			mDualMarks=mDualMarks.substring(0,1);

			%>
			<center><font size=4 color=green face="verdana"><B>Saved/Modified Project Marks Entry Status</B></font></center>
			<hr>
			<table align='center' width='70%'>
			<tr><td bgcolor=Green>&nbsp;&nbsp;&nbsp</td><td>Marks Saved/Updated</td>
			<td bgcolor=red>&nbsp;&nbsp;&nbsp</td><td>Absent Saved/Updated</td>
			<td bgcolor="#3399cc">&nbsp;&nbsp;&nbsp</td><td>Detained Saved/Updated</td>
			</tr></table>
			<table border=1 cellpadding=0 cellspacing=0 rules="rows" align=center width=100%>
			<tr bgcolor=ff8c00>
			<td><font face=arial color=white size=2><b>Sr. No.</b></font></td>
			<td><font face=arial color=white size=2><b>Enroll. No.</b></font></td>
			<td><font face=arial color=white size=2><b>Student Name</b></font></td>
			<td align=center><font face=arial color=white size=2><b>Marks By Examiner-I</b></font></td>
			<td align=center><font face=arial color=white size=2><b>Absent<br>Detained</b></font></td>
			<%
			if(mDualMarks.equals("Y"))
			{
			%>
			<td align=center><font face=arial color=white size=2><b>Marks By Examiner-II</b></font></td>
			<td align=center><font face=arial color=white size=2><b>Absent<br>Detained</b></font></td>
			<%
			}
			%>
			<td><font face=arial color=white size=2><b>Saving Status</b></font></td>
			</tr>
			<%
			mINSTITUTECODE=request.getParameter("institute");
			mEventsubevent=request.getParameter("EventSubevent").toString().trim();
			mExam=request.getParameter("Exam");
			mMax=Double.parseDouble(request.getParameter("MaxMarks"));
			mSubject=request.getParameter("subjectcode");
			mMOP=request.getParameter("Marksorpercentage");
			if(mMOP.equals("P"))
      		{
				mMax1=mMax;
				mMax=100;
			}
			mStatus=request.getParameter("Status");
			if(request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
			{
				mTotalCount =Integer.parseInt(request.getParameter("TotalCount").toString().trim());
				for (ctr=1;ctr<=mTotalCount;ctr++)
				{
					int mSaveFlag=0;
					mMarks1=""; mMarks2=""; mDetained1=""; mDetained2="";
					mName1="Semester"+String.valueOf(ctr).trim();
					mName2="Studentid"+String.valueOf(ctr).trim();
					mName3="Marks1"+String.valueOf(ctr).trim();
					mName4="Marks2"+String.valueOf(ctr).trim();
					mName5="Fstid"+String.valueOf(ctr).trim();
					mName7="Status"+String.valueOf(ctr).trim();

					mSemester=request.getParameter(mName1);
					mStudentid=request.getParameter(mName2);
				   // mMarks1=Double.parseDouble(request.getParameter(mName3));
					try
					{
						if(request.getParameter(mName3)==null || request.getParameter(mName3).equals(""))
						{
							mMarks1="-1";
						}
						else
						{
							mMarks1=request.getParameter(mName3);
						}
						if(request.getParameter(mName4)==null || request.getParameter(mName4).equals(""))
						{
							mMarks2="-1";
						}
						else
						{
							mMarks2=request.getParameter(mName4);
						}
					}
					catch(Exception e)
					{
						mMarks1="-1";
						mMarks2="-1";
					}
					mFstid=request.getParameter(mName5);
					try
					{
					   if(!mMarks1.equals("-1") || !mMarks2.equals("-1"))
					   {
//out.print(mMarks1+" - "+mMarks2);
						double SPMarks1=0, SPMarks2=0;
						if(mMarks1.equals("A") || mMarks1.equals("D"))
						{
							mDetained1=mMarks1;
							mMarks1="";
							if(mDetained1.equals("A"))
								mSPrint1="Absent";
							else if(mDetained1.equals("D"))
								mSPrint1="Detained";
						}
						else
							SPMarks1=Double.parseDouble(mMarks1);

						if(mMarks2.equals("A") || mMarks2.equals("D"))
						{
							mDetained2=mMarks2;
							mMarks2="";
							if(mDetained2.equals("A"))
								mSPrint2="Absent";
							else if(mDetained2.equals("D"))
								mSPrint2="Detained";
						}
						else
							SPMarks2=Double.parseDouble(mMarks2);

						if(1==1)
						{	//--1
//out.print(mMarks1+" - "+mMarks2+" \\\\ "+SPMarks1+" - "+SPMarks2);
//out.print(SPMarks1+" - "+SPMarks2);
//out.print(mMarks1+" - "+mMarks2+" = "+mMax1);


							if(mMOP.equals("P"))
							{
								mPercMarks1=(Double.parseDouble(mMarks1)*mMax1)/100 ;
								mPercMarks2=(Double.parseDouble(mMarks2)*mMax1)/100 ;


//-----------Marks1 IF Type-P------------
							if((mPercMarks1>=0 && mPercMarks1<=mMax) || (mDetained1.equals("A") || mDetained1.equals("D")))
							{
								if(mMarks1.equals("-1"))
									mDetained1="";
								qry="Select nvl(PROJMARKS1,-1)MARKSAWARDED1, nvl(PROJDETAINED1,'N') DETAINED1, nvl(MARKS1ENTRYBY,' ')ENTBY1 from STUDENTEVENTPROJECTMARKS1";
								qry=qry+" where EVENTSUBEVENT='"+mEventsubevent+"' and fstid='"+mFstid+"' and STUDENTID='"+mStudentid+"' ";
								//out.print(qry);
								rs=db.getRowset(qry);
								if(rs.next() && rs.getString("ENTBY1").equals(mDMemberID))
								{
									qry="update STUDENTEVENTPROJECTMARKS1 set PROJMARKS1="+mPercMarks1+", PROJDETAINED1='"+mDetained1+"', ";
									qry=qry+" where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' and studentid='"+mStudentid+"' ";
									int n=db.update(qry);
									//out.println(qry);
								}
								else
								{
									qry="INSERT INTO STUDENTEVENTPROJECTMARKS1 (FSTID, EVENTSUBEVENT, STUDENTID, PROJMARKS1, PROJDETAINED1, PROJLOCKED1, MARKS1ENTRYDATE, MARKS1ENTRYBY, DEACTIVE)";
									qry=qry+" values ('"+mFstid+"','"+mEventsubevent+"','"+mStudentid+"',"+mPercMarks1+",'"+mDetained1+"',null, sysdate, '"+mDMemberID+"', sysdate, '"+mDMemberID+"', null) ";
									//out.println(qry);
	      							int n=db.insertRow(qry);
								}
							}
//---------------------------------------
//-----------Marks2 IF Type-P------------

						
							if((mPercMarks2>=0 && mPercMarks2<=mMax) || (mDetained2.equals("A") || mDetained2.equals("D")))
							{
								if(mMarks2.equals("-1"))
									mDetained2="";
								qry="Select nvl(PROJMARKS2,-1)MARKSAWARDED2, nvl(PROJDETAINED2,'N') DETAINED2, nvl(MARKS2ENTRYBY,' ')ENTBY2 from STUDENTEVENTPROJECTMARKS2";
								qry=qry+" where EVENTSUBEVENT='"+mEventsubevent+"' and fstid='"+mFstid+"' and STUDENTID='"+mStudentid+"' ";
								//out.print(qry);
								rs=db.getRowset(qry);
								if(rs.next() && rs.getString("ENTBY2").equals(mDMemberID))
								{
									qry="update STUDENTEVENTPROJECTMARKS2 set PROJMARKS2='"+mPercMarks2+"', PROJDETAINED2='"+mDetained2+"', ";
									qry=qry+" where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' and studentid='"+mStudentid+"' ";
									int n=db.update(qry);
									out.println(qry);
								}
								else
								{
									qry="INSERT INTO STUDENTEVENTPROJECTMARKS2 (FSTID, EVENTSUBEVENT, STUDENTID, PROJMARKS2, PROJDETAINED2, PROJLOCKED2, MARKS2ENTRYDATE, MARKS2ENTRYBY, DEACTIVE)";
									qry=qry+" values ('"+mFstid+"','"+mEventsubevent+"','"+mStudentid+"','"+mPercMarks2+"','"+mDetained2+"',null, sysdate, '"+mDMemberID+"', null) ";
									//out.println(qry);
	      							int n=db.insertRow(qry);
								}
							}
//---------------------------------------
							}
							else
							{    //-----------2 if Marks type then
//-----------Marks1 IF Type-M------------

//out.print(SPMarks1+" LL "+SPMarks2);

							if((SPMarks1>=0 && SPMarks1<=mMax) || (mDetained1.equals("A") || mDetained1.equals("D")))
							{
								if(mMarks1.equals("-1"))
										mDetained1="";
							
								qry="Select nvl(PROJMARKS1,-1)MARKSAWARDED1, nvl(PROJDETAINED1,'N') DETAINED1, nvl(MARKS1ENTRYBY,' ')ENTBY1 from STUDENTEVENTPROJECTMARKS1";
								qry=qry+" where EVENTSUBEVENT='"+mEventsubevent+"' and fstid='"+mFstid+"' and STUDENTID='"+mStudentid+"' ";
								//out.print(qry);
								rs=db.getRowset(qry);
								if(rs.next() && rs.getString("ENTBY1").equals(mDMemberID))
								{
									qry="update STUDENTEVENTPROJECTMARKS1 set PROJMARKS1='"+mMarks1+"', PROJDETAINED1='"+mDetained1+"' ";
									qry=qry+" where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' and studentid='"+mStudentid+"' ";
									int n=db.update(qry);
									//out.println(qry);
								}
								else
								{
									qry="INSERT INTO STUDENTEVENTPROJECTMARKS1 (FSTID, EVENTSUBEVENT, STUDENTID, PROJMARKS1, PROJDETAINED1, PROJLOCKED1, MARKS1ENTRYDATE, MARKS1ENTRYBY, DEACTIVE)";
									qry=qry+" values ('"+mFstid+"','"+mEventsubevent+"','"+mStudentid+"','"+mMarks1+"','"+mDetained1+"',null, sysdate, '"+mDMemberID+"', null) ";
									//out.println(qry);
							      	int n=db.insertRow(qry);
								}
							}

//---------------------------------------
//-----------Marks1 IF Type-M------------

							if((SPMarks2>=0 &&  SPMarks2<=mMax) || (mDetained2.equals("A") || mDetained2.equals("D")))
							{
								if(mMarks2.equals("-1"))
									mDetained2="";
								


								qry="Select nvl(PROJMARKS2,-1)MARKSAWARDED2, nvl(PROJDETAINED2,'N') DETAINED2, nvl(MARKS2ENTRYBY,' ')ENTBY2 from STUDENTEVENTPROJECTMARKS2";
								qry=qry+" where EVENTSUBEVENT='"+mEventsubevent+"' and fstid='"+mFstid+"' and STUDENTID='"+mStudentid+"' ";
								//out.print(qry);
								rs=db.getRowset(qry);
								if(rs.next() && rs.getString("ENTBY2").equals(mDMemberID))
								{
									qry="update STUDENTEVENTPROJECTMARKS2 set PROJMARKS2='"+mMarks2+"', PROJDETAINED2='"+mDetained2+"' ";
									qry=qry+" where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' and studentid='"+mStudentid+"' ";
									int n=db.update(qry);
									//out.println(qry);
								}
								else
								{
									qry="INSERT INTO STUDENTEVENTPROJECTMARKS2 (FSTID, EVENTSUBEVENT, STUDENTID, PROJMARKS2, PROJDETAINED2, PROJLOCKED2, MARKS2ENTRYDATE, MARKS2ENTRYBY, DEACTIVE)";
									qry=qry+" values ('"+mFstid+"','"+mEventsubevent+"','"+mStudentid+"','"+mMarks2+"','"+mDetained2+"',null, sysdate, '"+mDMemberID+"', null) ";
									//out.println(qry);
							      	int n=db.insertRow(qry);
								}
							}
//---------------------------------------
							}  //-------closing of mMOP else 2
						} //----else 1
					   }
					}
					catch(Exception e)
					{
						//out.print("error"+qry);
					}
					// Log Entry
					//-----------------
					    db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"PROJECT-MARKS-ENTRY", "ExamCode: "+mExam +"EventSubevent "+ mEventsubevent+ "SubjectID"+mSubject+"Fstid:"+mFstid +"MaxMarks: "+mMax, "NO MAC Address" , mIPAddress);
					//-----------------

					Counter++;
					%>
					<TR>
					<td><%=Counter%>.</td>
					<%
					qry="Select nvl(ENROLLMENTNO,' ') ENO from STUDENTMASTER where studentid='"+mStudentid+"'";
					rs=db.getRowset(qry);
					rs.next();
					%>
					<td><%=rs.getString("ENO")%></td>
					<%

					qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
					RsChk= db.getRowset(qry);
					if(RsChk.next())
					  mSID=RsChk.getString(1);
					%>
					<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
					<%

					qry="SELECT NVL(C.ENROLLMENTNO,' ') ENO, A.STUDENTID SID, NVL(A.PROJMARKS1,-1) PM1, DECODE(A.PROJDETAINED1,'A','<font color=red>Absent</font>','D','<font color=#3399cc>Detained</font>',' ') PD1, NVL(A.MARKS1ENTRYBY,' ') EBY1, to_char(A.MARKS1ENTRYDATE,'dd/mm/yyyy') EDT1, NVL(A.GROUPIDNO,0)GROUPIDNO1 ";
					qry=qry+" FROM STUDENTEVENTPROJECTMARKS1 A, STUDENTMASTER C";
					qry=qry+" WHERE NVL(A.DEACTIVE,'N')='N' AND A.STUDENTID=C.STUDENTID AND A.EVENTSUBEVENT='"+mEventsubevent+"' ";
					qry=qry+" AND A.FSTID='"+mFstid+"' AND A.StudentID='"+mStudentid+"'";
					//out.print(qry);
					rs=db.getRowset(qry);
					if(rs.next())
					{
						mSaveFlag++;
						if(!rs.getString("PM1").equals("-1"))
						{
							if(rs.getString("EBY1").equals(mChkMemID))
							{
								%><td align=center><font color=green><%=rs.getString("PM1")%></font></td><%
							}
							else
							{
								%><td align=center><Font Color=darkPink>Invisible(entered by others)</font></td><%
							}
						}
						else
						{
							%>
							<td>&nbsp;</td>
							<%
						}
						%>
						<td align=center><%=rs.getString("PD1")%></td>
						<%
					}
					else
					{
						%>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%
					}
					if(mDualMarks.equals("Y"))
					{
					qry="SELECT NVL(C.ENROLLMENTNO,' ') ENO, A.STUDENTID SID, NVL(A.PROJMARKS2,-1) PM2, DECODE(A.PROJDETAINED2,'A','<font color=red>Absent</font>','D','<font color=#3399cc>Detained</font>',' ') PD2, NVL(A.MARKS2ENTRYBY,' ') EBY2, to_char(A.MARKS2ENTRYDATE,'dd/mm/yyyy') EDT2, NVL(A.GROUPIDNO,0)GROUPIDNO2 ";
					qry=qry+" FROM STUDENTEVENTPROJECTMARKS2 A, STUDENTMASTER C";
					qry=qry+" WHERE NVL(A.DEACTIVE,'N')='N' AND A.STUDENTID=C.STUDENTID AND A.EVENTSUBEVENT='"+mEventsubevent+"' ";
					qry=qry+" AND A.FSTID='"+mFstid+"' AND A.StudentID='"+mStudentid+"'";
					//out.print(qry);
					rs=db.getRowset(qry);
					if(rs.next())
					{
						mSaveFlag++;
						if(!rs.getString("PM2").equals("-1"))
						{
							if(rs.getString("EBY2").equals(mChkMemID))
							{
								%><td align=center><font color=green><%=rs.getString("PM2")%></font></td><%
							}
							else
							{
								%><td align=center><Font Color=darkPink>Invisible(entered by others)</font></td><%
							}
						}
						else
						{
							%>
							<td>&nbsp;</td>
							<%
						}
						%>
						<td align=center><%=rs.getString("PD2")%></td>
						<%
					}
					else
					{
						%>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%
					}
					}
					if(mSaveFlag>0)
					{
						%><td><Font color=green face=arial>Saved/Updated</font></td><%
					}
					else
					{
						%><td><Font color=red face=arial>Not Entered</font></td><%
					}

				}    //----------closing of for loop
/*%><CENTER>These are the student id whose marks is not entered due to same faculty - <%=StudID%></CENTER><%*/
//-----------------------------
/*
				%>
				</tr>
				<tr>
				<form name="frm2" id="frm2" method="post" action="LockProjMarksEntry.jsp">
				<td colspan=5 align=center valign=top><font size=2 color="#993300" face=arial>
				<b>** Lock Marks Entry
				<input type=checkbox name='Proceed' id='Proceed' value='Y' onclick="return showAlert();">
				<INPUT Type="submit" Value="Lock Marks Entry Now"></td>
				<input type=hidden name='institute' id='institute' value="<%=mINSTITUTECODE%>">
				<input type=hidden name='Exam' id='Exam' value="<%=mExam%>">
				<input type=hidden name='EventSubevent' id='EventSubevent' value="<%=mEventsubevent%>">
				<input type=hidden name='subjectcode' id='subjectcode' value="<%=mSubject%>">
				</form>
				</tr>
				</table>
				<p>**<font color="gray" face=verdana size=2>
				 Once You check the Locked Marks Checkbox and lock it then marks entry will be closed for this event of this subject.
<%
*/
%>
				</table>
				<%
				 //---------closing of totalcount loop
			}
			else
			{
				out.print("No record entered...");
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
			</font>	<br>	<br>	<br>	<br>
			<%
		}
	//-----------------------------
	//---------closing of session loop
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
	//------------------try
     	}
catch(Exception e)
{
	//out.print("last catch"+qry);
}
%>
</body>
</html>
