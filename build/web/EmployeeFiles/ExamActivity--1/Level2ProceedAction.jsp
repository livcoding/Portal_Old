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
String qry="",mIC="";
String mself="";
if (session.getAttribute("Click")==null)
{
	mself="";
}
else
{
	mself=session.getAttribute("Click").toString().trim();
}

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
<html>
<head>
<TITLE>#### <%=mHead%> [ Proceed for Level-II Marks Entry ] </TITLE>
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

  mIC=request.getParameter("institute");
  mEventsubevent=request.getParameter("EventSubevent").toString().trim();			
  mEC=request.getParameter("Exam");			
  mSC=request.getParameter("subjectcode");
  if(request.getParameter("Proceed")!=null)
	mProceed="Y";
  else
       mProceed="N";


  
  qry="select distinct fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
  qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester,subsectioncode, ";
  qry=qry+ "nvl(programcode,' ')programcode,nvl(SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a";
  qry=qry+" where institutecode='"+mIC+"' and EVENTSUBEVENT='"+mEventsubevent+"' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and nvl(a.DEACTIVE,'N')='N' and ";
  qry=qry+" examcode='"+mEC+"'  and (ltp='L' or (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='"+mSC+"' and employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E') ";
  qry=qry+" and not exists (select 'y' from V#STUDENTEVENTSUBJECTMARKS b where a.fstid=b.fstid and a.studentid=b.studentid and a.EVENTSUBEVENT=b.EVENTSUBEVENT and (nvl(detained,'N')='D' or nvl(detained,'N')='A' or nvl(marksawarded1,-1)>=0 )) order by enrollmentno ";
  rs=db.getRowset(qry);
//	out.print(qry);
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
	<tr><td align=center colspan=3><font color=red><b>Warning: Marks of following students have not been entered/Detained.<br>You cant not proceed for IInd level marks entry.</b></font>  </td></tr>
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
	}//END OF WHILE
	 int a=0;
		if(mflag.equals("N"))
		{
		%>	<tr><td colspan=3 align=center><a href='MarksEntryLvl1.jsp'><font color=blue><b>Continue Ist Level marks entry</b></font></a></td></tr>
			</table>
		<%
		}
		else
		{
			
			
			
			
			
			
			if (mProceed.equals("Y"))
			{
			  //out.println(mself);
			  if(mself.equals("Self"))
				{
				  qry="Update EXAMEVENTSUBJECTTAGGING Set PROCEEDSECOND='Y',PUBLISHED='Y' where ";
			  qry=qry+" EVENTSUBEVENT='"+mEventsubevent+"' and FSTID in (select FSTID from FacultySubjectTagging ";
			  qry=qry+" where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"'  and  EMPLOYEEID='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
			  qry=qry+" and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P'))"; 
		//out.println(qry);
              a=db.update(qry);

			  qry="Update STUDENTEVENTSUBJECTMARKS set LOCKED='Y' where ";
	           qry=qry+" EVENTSUBEVENT='"+mEventsubevent+"' and FSTID in (select FSTID from FacultySubjectTagging ";
			  qry=qry+" where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"' and   eMPLOYEEID='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
			  qry=qry+" and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P'))"; 

			//out.println(qry);
                 a=db.update(qry);
				}
				else
				{

			  
			  
			  qry="Update EXAMEVENTSUBJECTTAGGING Set PROCEEDSECOND='Y',PUBLISHED='Y' where ";
			  qry=qry+" EVENTSUBEVENT='"+mEventsubevent+"' and FSTID in (select FSTID from FacultySubjectTagging ";
			  qry=qry+" where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"'  ";
			  //EMPLOYEEID='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
			  qry=qry+" and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P'))"; 
	//	out.println(qry);
                    a=db.update(qry);

			  qry="Update STUDENTEVENTSUBJECTMARKS set LOCKED='Y' where ";
	           qry=qry+" EVENTSUBEVENT='"+mEventsubevent+"' and FSTID in (select FSTID from FacultySubjectTagging ";
			  qry=qry+" where INSTITUTECODE='"+mIC+"' And ExamCode='"+mEC+"'  ";//EMPLOYEEID='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
			  qry=qry+" and SubjectID='"+mSC+"' and (LTP='L' OR PROJECTSUBJECT='Y' OR LTP='P'))"; 

		//	out.println(qry);
                     a=db.update(qry);

				}
			 
			  if (a>0)
			  {
			  %>
			<br><hr><p><font color=Green size=4><ul>
			<li>Marks Entry Process has been locked successfully!
			<li>Now you cannot change marks of students or detailed or Absent status. 
			<li>For the same you can contact your HOD.
			</ul></font><hr>
		  <%
			  }
			}
			else
			{
 			%><br><hr>
				<ul><font color=red size=4><li>Marks has not been locked yet. 
				<li>You can change marks till the Event Date remains.
				<li>You are requested to lock/freeze Marks entry process otherwise Grade Entry process may face problem later.
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

