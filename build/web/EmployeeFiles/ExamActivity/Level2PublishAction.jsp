<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mDesg="",mDept="",mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDMemberID="";
String mEC="",mSemester="",mStudentid="",mINSTITUTECODE="",mEventsubevent="";
String mExam="",mSC="",mSubject="",mSID="",mProceed="";
ResultSet rs=null;
String qry="",mIC="",mLocked="",qry1="";

if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
							
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
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Marke Entry Publishing Status-Level-2 ] </TITLE>
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<%	try{
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
		
			mIC=request.getParameter("institute");
			mEventsubevent=request.getParameter("EventSubevent").toString().trim();
			mEC=request.getParameter("Exam");			
			mSC=request.getParameter("subjectcode");
			if(request.getParameter("Proceed")!=null)
				mProceed="Y";
			else
				mProceed="N";

			if(request.getParameter("Locked")!=null)
				mLocked="Y";
			else
				mLocked="N";
		qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
		qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester,subsectioncode, ";
		qry=qry+ "nvl(programcode,' ')programcode,nvl(SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a";
		qry=qry+" where institutecode='"+mIC+"' and EVENTSUBEVENT='"+mEventsubevent+"' and nvl(PROCEEDSECOND,'N')='Y' and nvl(a.DEACTIVE,'N')='N' and nvl(a.STUDENTLTPDEACTIVE,'N')='N' and nvl(locked,'N')='N' and  ";
		qry=qry+" examcode='"+mEC+"' and employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') or LTP='P') and subjectID='"+mSC+"' ";
	     	qry=qry+" and not exists (select 'y' from V#STUDENTEVENTSUBJECTMARKS b where a.fstid=b.fstid and a.studentid=b.studentid and a.EVENTSUBEVENT=b.EVENTSUBEVENT and (nvl(detained2,'N')='D' or nvl(detained2,'N')='A' or nvl(marksawarded2,-1)>=0 )) ";
		qry=qry+" GROUP BY fstid,nvl(studentid,' '),nvl(studentname,' '), ";
		qry=qry+" nvl(enrollmentno,' '),nvl(semester,0),subsectioncode, ";
		qry=qry+ "nvl(programcode,' '),nvl(SECTIONBRANCH,' ') ";
		qry=qry+" order by enrollmentno ";
		//	out.print(qry);
		rs=db.getRowset(qry);
          	String mflag="";
		int Sno=0;
		mflag="Y";
		while(rs.next())
		{
		Sno++;
		if(mflag.equals("Y"))
		{
		 mflag="N";
		%>	
			<table border=1 align=center rules='rows' width=75%>
			<tr><td align=center colspan=3><font color=red><b>Warning: First level marks of following students do not match with second level marks.<br>You can not proceed to publish.</b></font>  </td></tr>
			<tr bgcolor=ff8c00>

			<td><b>Sno</b></td>
			<td><b>Enrollment No</b></td>
			<td><b>Student Name</b></td></tr>
		<%
		}
		%>
			<tr><td><%=Sno%></td>
			<td><%=rs.getString("enrollmentno")%></td>
			<td><%=GlobalFunctions.toTtitleCase(rs.getString("studentname"))%></td>
			</tr>
		<%	
		}
		if(mflag.equals("N"))
		{
		%>	<tr><td colspan=3 align=center><a href='MarksEntryLvl2.jsp'><font color=blue><b>Continue IInd Level marks entry</b></font></a></td></tr>
			</table>
		<%
		}
		else
		{


			if (mProceed.equals("Y"))
			{
			  qry="Update EXAMEVENTSUBJECTTAGGING set PUBLISHED='Y' where ";
                    qry=qry+" EVENTSUBEVENT='"+mEventsubevent+"' and	FSTID in (select FSTID from FacultySubjectTagging ";
			  qry=qry+" where INSTITUTECODE='"+mIC+"' and ExamCode='"+mEC+"' and employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
			  qry=qry+" and SubjectID='"+mSC+"' and (LTP='L' OR (LTP='E' AND PROJECTSUBJECT='Y') or LTP='P'))"; 
			//	out.print(qry);
			   int a1=db.update(qry);
			  if (a1>1)
			  {
		// Log Entry
	   //-----------------
	    db.saveTransLog(mIC,mLogEntryMemberID,mLogEntryMemberType," MARKS ENTRYLEVEL-2 PUBLISHED STATUS ='Y' ", "Published Status='Y',EventSubEvent : "+mEventsubevent+"ExamCode :"+ mEC +" SubjectID :"+mSC, "No MAC Address" , mIPAddress);
	   //-----------------
		  %>
			<!--	 <br><hr><p><font color=Green size=4><ul><li>IInd Level entry Completed! Now you can publish marks.
				<li>You cannot change first and second level marks. 
				<li>For the same you can contact your HOD.
				</ul></font><hr>
				-->
		  <%
			  }

	if(mLocked.equals("Y"))
			{
			  
			qry1="Update STUDENTEVENTSUBJECTMARKS set LOCKED='Y' where ";
            qry1=qry1+" EVENTSUBEVENT='"+mEventsubevent+"' and FSTID in (select FSTID from EXAMEVENTSUBJECTTAGGING ";
			qry1=qry1+" where  EVENTSUBEVENT='"+mEventsubevent+"' and CORDFACULTYID='"+mDMemberID+"' and CORDFACULTYTYPE=decode('"+mDMemberType+"','E','I','E')";
			qry1=qry1+" and  PROCEEDSECOND='Y')";

			//out.println(qry1);
                   int a=db.update(qry1);
			 if (a>1)
			 {
// Log Entry
	   //-----------------
	    db.saveTransLog(mIC,mLogEntryMemberID,mLogEntryMemberType," MARKS ENTRYLEVEL-2 LOCKED STATUS ='Y' ", "Locked Status='Y',EventSubEvent : "+mEventsubevent+"ExamCode :"+ mEC +" SubjectID :"+mSC, "No MAC Address" , mIPAddress);
	   //-----------------

			 %>
			<br><hr><p><font color=Green size=4><ul><li>IInd Level entry Completed! .
			<li>Marks are available to view for students and locked.
			<li>Now you cannot change first and second level marks. 
			<li>For the same you can contact your HOD.
			</ul></font><hr>
			  <%
			  }
			}
			else
			{
		%>
			<br><hr><p><font color=Green size=4><ul>
			<li>IInd Level entry Completed!.Now Marks are available to view for students.
			<li>But you can not Finalize until check <b>Locked Marks </b>checkbox.
			<li>Once You Finalize the marks you can not change the first and second level marks. 
			<li>For the same you can contact your HOD.
			</ul></font><hr>
  		<%
			}
			}
			else
			{

                    qry="Update EXAMEVENTSUBJECTTAGGING set PUBLISHED='N' where ";
                    qry=qry+" EVENTSUBEVENT='"+mEventsubevent+"' and FSTID in (select FSTID from FacultySubjectTagging ";
			  qry=qry+" where INSTITUTECODE='"+mIC+"' and ExamCode='"+mEC+"' and employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
			  qry=qry+" and SubjectID='"+mSC+"' and (LTP='L' OR (LTP='E' AND PROJECTSUBJECT='Y') or LTP='P'))"; 
			  int a2=db.update(qry);
				if(a2>1)
				{
		//-------- Log Entry
	   //-----------------
	    db.saveTransLog(mIC,mLogEntryMemberID,mLogEntryMemberType," MARKS ENTRYLEVEL-2 PUBLISHED STATUS ='N' ", "Published Status='N',EventSubEvent : "+mEventsubevent+"ExamCode :"+ mEC +" SubjectID :"+mSC, "No MAC Address" , mIPAddress);
	   //-----------------

				}
 			%>
				<br><hr>
				<p><font color=red size=4><ul>
				<li>Second level entry Completed!
	 			<li> But you can not publish until check <b>Publish Marks</b> checkbox.
				<li> After publish marks will be available to view for students.
				<li> Once you check the<b> Locked marks </b> checkox you can not change the marks.
				<li>For the same you can contact your HOD.
				</ul></font><br><a href='MarksEntryLvl2.jsp'><font color=blue><b>Continue IInd Level marks entry</b></font></a><hr>
		  <%
			}
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
	// out.print("last catch"+qry);
	}	
%>
</body>
</html>


