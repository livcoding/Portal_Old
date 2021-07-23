<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
ResultSet rs=null,rs2=null,rs1=null,rss1=null,rsc=null,rse=null, Rs=null;
String qry="", qry1="", qry2="", Qry="";
String mDID="",mProg="", mSCode="", mSecBr="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
int mSem=0;
int n1=0;
int LockFlag=0;
String mSubjSemSubjtype="", mSendToHOD="";
String mTag="",mElective="";
String mExam="", mPrECode="";
String mName1="";
String mName2="",mName4="",meid="",mEl="",mAca="";
String mName3="";
String mName5="";
String msubject="",mSubject="",mCh="", mSubjType="", mEleCode="";
String msubject1="",mSubject1="",mMS="", mSubj="", QrySem="";
String mSemes="",mChoice="",mSemType="",mSubjectType="",mMemberType="",mMemberID="",mEc="",mSc="",mSid="";
long mSemester=0;
int msno=0;	
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
/*
	' 
*************************************************************************************************
	' *												
	' * File Name:	PRStudentEntryBackPaper.JSP		[For Students]					
	' * Author:		Rituraj Tyagi + Vijay Kumar
	' * Date:		02-May-2007								
	' * Version:	1.0
	' * Description:	Pre Registration of Students (Back Papers)
*************************************************************************************************
*/

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subject Selection for the comming classes(Pre Registration of Students) ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<Html>
<head>
<title>Back Paper Choice Entry</title>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
-->
</script>


<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
-->
 </script>

 <script>
<!--
if(window.history.forward(1) != null)
window.history.forward(1);
-->
</script>

</head>
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<cenTer>
<% 
String mSEMESTER  ="";
String mSname="";
String mCOURSENAME ="";
String mBranch="",mAcad="";
String mInst="",mWebEmail="";
try{
OLTEncryption enc=new OLTEncryption();
if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry1="Select WEBKIOSK.ShowLink('109','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry1);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
		if (session.getAttribute("InstituteCode")==null || session.getAttribute("InstituteCode").toString().equals(""))
		   mInst="";
		else
		if (session.getAttribute("WebAdminEmail")==null)
		{
		 mWebEmail="";
		}	 
		else
		{
		mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
	      }
	mInst=session.getAttribute("InstituteCode").toString().trim();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());


//-------------------------------------
//----- For Log Entry Purpose
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

	qry1="select PREREGEXAMID EXAMID from defaultValues";
	rs=db.getRowset(qry1);
	if (rs.next())
		mExam=rs.getString(1);


	qry1= " Select nvl(STUDENTID, ' ') STUDENTID, nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
	qry1=qry1+" nvl(SEMESTER,0) SEMESTER, decode(SEMESTER,1,'S','B') TaggingFor, ACADEMICYEAR, SECTIONBRANCH from ";
	qry1=qry1+" STUDENTREGISTRATION where StudentID='" +mDID+ "' and  InstituteCode='"+mInst+"' and EXAMCODE='"+mExam+"' and";
	qry1=qry1+" STUDENTID IN (SELECT MemberID FROM PREVENTS WHERE INSTITUTECODE='"+ mInst +"' and nvl(SSTPOPULATED,'N')='N'";
	//qry1=qry1+" and nvl(SENDTOHOD,'N')='N' ";
	qry1=qry1+" AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst +"'";
	qry1=qry1+" and nvl(BACKLOGSUBJECTFINALIZED,'N')='N'";
	qry1=qry1+" and NVL(APPROVED,'N')='N' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
	qry1=qry1+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='S' and MEMBERID='"+mDID+"'";
	qry1=qry1+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N')";
	rs=db.getRowset(qry1);

	if(rs.next())
	{
		mSEMESTER=rs.getString("SEMESTER");
		mSem=rs.getInt("SEMESTER");
		mSname=session.getAttribute("MemberName").toString().trim();
		mSCode=enc.decode(session.getAttribute("MemberCode").toString().trim());
		mSecBr=rs.getString("SECTIONBRANCH");
		mProg=rs.getString("PROGRAMCODE");
		mBranch=rs.getString("BRANCHCODE");
		mTag=rs.getString("TaggingFor");
		mAcad=rs.getString("ACADEMICYEAR");
		
		int mSno=0, mTot=0;
		String mEnm="",mEmpid="",mySect="";

	   Qry="select nvl(SENDTOHOD,'N') SToHod, nvl(PREVENTCODE,' ') PREC from PREVENTS where INSTITUTECODE='"+ mInst +"' and nvl(SSTPOPULATED,'N')='N' and MEMBERID='"+mDID+"' and MEMBERTYPE='S'";
	   Qry=Qry+" and (InstituteCode, PrEventCode) In (Select InstituteCode, PrEventCode from PREVENTMaster where ExamCode='"+mExam+"' and PRCompleted='N' and ";
	   Qry=Qry+" nvl(PRBROADCAST,'N')='Y' and nvl(FREEELECTIVERUNFINALIZED,'N')='N' and nvl(BACKLOGSUBJECTFINALIZED,'N')='N' and nvl(PRREQUIREDFOR,'N')='S')";
	   Rs=db.getRowset(Qry);
	   Rs.next();
	   mPrECode=Rs.getString("PREC");
	   //out.print(Qry);
	   if(!Rs.getString("SToHod").equals("Y"))
	   {
		%>
		<table border=1 cellspacing=0 width='100%'>
		<form name="frm1" method=post>
		<input id="x" name="x" type=hidden>
		<!-- <tr  bgcolor="#c0000"> -->
		<tr bgcolor="#ff8c00">
		<td colspan=6 align=center><b><font color=white>STUDENT PRE-REGISTRATION / BACKPAPER-CHOICE ENTRY </font></B>
		</td>
		</tr>
		<tr>
			<td colspan=4><font face=arial size=2><b>Student Name : </b></font><font color=gray><b><%=GlobalFunctions.toTtitleCase(mSname)%> (<%=mSCode%>)</b></font></td>
		    	<td><font face=arial size=2><b>Institute Code</b></font></td><td><select name=InstCode id=InstCode><option selected value='<%=mInst%>'><%=mInst%></option></select></td>
		</tr>
		<tr>
			<td><font face=arial size=2><b>Exam Code</b></font></td><td><select name=ExamCode id=ExamCode><option selected value=<%=mExam%>><%=mExam%></option></select></td>
			<td><font face=arial size=2><b>Academic Year</b></font></td><td><select name=AcadYear id=AcadYear><option selected value='<%=mAcad%>'><%=mAcad%></option></select></td>
			<td><font face=arial size=2><b>Program Code</b></font></td><td><select id=ProgCode Name=ProgCode><option selected value='<%=mProg%>'><%=mProg%></option></select></td>
		</tr>
		<tr>
			<td><font face=arial size=2><b>Branch</b></font></td><td><select name=Branch id=Branch><option selected value=<%=mBranch%>><%=mBranch%></option></select></td>
			<td><font face=arial size=2><b>Pre Reg for Semester</b></font></td>
			<td><select name=sem id=sem><option selected value=<%=String.valueOf(mSem)%>><%=mSem%></option></select></td>
			<!--<td><select name=sem id=sem>
			<%
			for(int k1=1;k1<=mSem;k1++)
			{
			%>
			<OPTION Value =<%=String.valueOf(k1).trim()%>><%=k1%></option>
			<%
			}
			%>
			</select></td>-->
			<td><font face=arial size=2><b>Semester Type</b></font></td><td><select Name=SemType ID=SemType><option selected Value='RWJ'>RWJ</option></td>
		</tr>
		<tr>
			<td colspan=6 align=center><b>Choice Entry for BackLoger Papers</b></td>
		</tr>
			<!--****************Subject*****************-->
	<tr><td colspan=4><font face=arial size=2><b>Subject </b>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</font>
	<%
	try
	{
	   qry="Select distinct Semester, SUBJECTID,SUBJECT||' ( '||SUBJECTCODE|| ')- L:'||L||' T:'||T||' P:'||P Subject";
	   qry=qry+" from ";
	   qry=qry+" (select distinct nvl(A.SUBJECTID,' ')||'@@@'||nvl(A.semester,0)||'###E'||'***'||nvl(A.ELECTIVECODE,' ') Semester, A.SUBJECTID ,nvl(B.SUBJECT,' ')||'('||B.SUBJECTCODE||')' SUBJECT ,A.L,A.T,A.P from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B";
	   qry=qry+" where A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"'";
	   qry=qry+" and A.semester<"+mSem+"  and A.subjectID=B.subjectID ";
	   qry=qry+" union (select distinct nvl(A.SUBJECTID,' ')||'@@@'||nvl(A.semester,0)||'###C'||'***'||null Semester, A.SUBJECTID ,nvl(B.SUBJECT,' ')||'('||B.SUBJECTCODE||')' SUBJECT ,A.L,A.T,A.P from PROGRAMSCHEME A,SUBJECTMASTER B";
	   qry=qry+" where A.institutecode='"+mInst +"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"'";
	   qry=qry+" and A.semester<"+mSem+"  and A.subjectID=B.subjectID ))";
	   qry=qry+" where SubjectID Not In( select SUBJECTID from STUDENTRESULT d where d.institutecode='"+mInst+"' ";
	   qry=qry+" and d.grade<>'F' And d.studentid='"+mChkMemID+"' ) And SubjectID";
	   qry=qry+" Not In( select SUBJECTID from PR#STUDENTSUBJECTCHOICE f where f.INSTITUTECODE='"+mInst+"'";
	   qry=qry+" and f.EXAMCODE='"+mExam+"' And f.SEMESTER<5 and f.SEMESTERTYPE='RWJ' and f.STUDENTID='"+mChkMemID+"') order by Subject";

	 //out.print(qry);
	   rs=db.getRowset(qry);
	   %>
      	<select name=Subject11 tabindex="1" id="Subject11" style="WIDTH: 350px">
	   <%
		if (request.getParameter("x")==null)				
		{
			%>
				<option selected value='NONE'>Select a Subject</option>
			<%
			while(rs.next())
			{
				mSubjSemSubjtype=rs.getString("semester");
				if(msubject1.equals(""))
				msubject1=mSubjSemSubjtype;
				%>
					<option value=<%=mSubjSemSubjtype%>><%=rs.getString("Subject")%></option>
				<%
	  		}
		}	 //closing of if
		else
		{
			if(request.getParameter("Subject11").equals("NONE"))
			{
			 %>
			  <option selected value='NONE'>Select a Subject</option>	
			 <%
			}
			else
			{
			 %>
			  <option value='NONE'>Select a Subject</option>	
			 <%
			}	
			while(rs.next())
			{
				mSubjSemSubjtype=rs.getString("Semester");
				if(mSubjSemSubjtype.equals(request.getParameter("Subject11").toString().trim()))
		 		{
  					msubject1=mSubjSemSubjtype;
					%>
						<option Selected value=<%=mSubjSemSubjtype%>><%=rs.getString("Subject")%></option>  	
					<%
				}
				else
				{
					%>
		      			 <OPTION Value=<%=mSubjSemSubjtype%>><%=rs.getString("Subject")%></option>
			      	<%
			   	}
			}	//closing of while
		}	 //closing of else
	   %>
		</select>
	   <%
	}
	catch(Exception e)
	{
		//out.print("error"+qry);
	}
%>
</td>
<td title='Enter Choice / Priority Preference' valign=middle><font face=arial size=2><b>Choice </b></font>&nbsp;<input Name='Choice' Id='Choice' Type=TEXT tabindex="2" maxlength=2 size=2><FONT color=red>*</FONT></td>
<td align=center><input Type=Submit name=btn1 id=btn1 Value='Save'></td></tr>
</form>
</table>
<%
	if (request.getParameter("x")!=null)
	{
		if(request.getParameter("Choice")!=null && !request.getParameter("Choice").toString().trim().equals(""))
		{
			if(request.getParameter("Subject11").toString().trim().equals("NONE") || request.getParameter("Subject11").toString().trim()==null)
			{
				mSubject=" ";
			}
			else
			mSubject=request.getParameter("Subject11");
			if(!mSubject.equals(" "))
			{
				mSemType=request.getParameter("SemType");
				mChoice=request.getParameter("Choice");
				int len=0;
				int pos1=0;
				int pos2=0;
				int pos3=0;
				len=mSubject.length();
				pos1=mSubject.indexOf("@@@");
				pos2=mSubject.indexOf("###");
				pos3=mSubject.indexOf("***");
				try
				{
					mSubj=mSubject.substring(0,pos1);
				}
				catch(Exception e)
		   		{
		   		}
				mSemes=mSubject.substring(pos1+3,pos2);
				mSubjectType=mSubject.substring(pos2+3,pos3);
				mEleCode=mSubject.substring(pos3+3,len);
				mSemester=Long.parseLong(mSemes.toString().trim());
				//out.print(mSubject+"---"+mSubjectType+"---"+mEleCode+"---"+mSemester);

				if(mSemester<=2)
					mTag="S";
				else
					mTag="B";
				qry1="select 'Y' from PR#STUDENTSUBJECTCHOICE where STUDENTID='"+mDID+"' and EXAMCODE='"+mExam+"' and CHOICE='"+mChoice+"' and SemesterType='"+mSemType+"'";
				//out.print(qry1);
				rs=db.getRowset(qry1);
				if(!rs.next())
				{
					qry=" INSERT INTO PR#STUDENTSUBJECTCHOICE(INSTITUTECODE,EXAMCODE,ACADEMICYEAR,PROGRAMCODE, ";
					qry=qry+" TAGGINGFOR, SECTIONBRANCH, SEMESTER, SEMESTERTYPE, STUDENTID,SUBJECTID, ";
					qry=qry+" SUBJECTTYPE, CHOICE, ENTRYDATE,ENTRYBY)VALUES  ";
					qry=qry+" ('"+mInst+"','"+mExam+"','"+mAcad+"','"+mProg+"','"+mTag+"','"+mSecBr+"',";
				   	qry=qry+" '"+mSemes+"','"+mSemType+"','"+mDID+"','"+mSubj+"','"+mSubjectType+"','"+mChoice+"',sysdate,user)"; 
					//out.print(qry);
			    		int n=db.insertRow(qry);
					if(n>0)
					{
				      	db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"PR-REGISTRATION: STUDENT BACKPAPER CHOICE", "ExamCode: "+mExam+"Academic year :"+ mAcad+ "ProgramCode :"+mProg+"Subject :"+mSubj, "NO MAC Address" , mIPAddress);
						response.sendRedirect("PRStudentEntryBackPaper.jsp");
					}
					else
					{
						%>
						<font color=red><img src='../../Images/Error1.jpg'>&nbsp;<B>Error while filling Back Paper Pre Registration</b>!</FONT>
				 		<%
					}
				}
				else
				{
					%>
					<font color=red><img src='../../Images/Error1.jpg'>&nbsp;<B>Choice must be Unique </B>!</FONT>
				 	<%
				}
			}
			else
			{
			%><font color=red><img src='../../Images/Error1.jpg'>&nbsp;<B>Please Select a Subject </B>!</FONT><%
			}
		}
		else
		{
			%>
			<font color=red><img src='../../Images/Error1.jpg'>&nbsp;<B>Choice cann't be left blank </B>!</FONT>
		 	<%
		}
		
	} // closing of if(request.getParameter("x")!=null)
	%>
	<table width='100%' cellpadding=0 cellspacing=0 rules=groups>
	<tr><td colspan=5 align=center><b>List of Choice for Back Log Papers</b></td></tr>
	<tr bgcolor="#ff8c00">
	<td><font color=white><b>SNo<b></font></td>
	<td><font color=white><b>&nbsp;Subject Name (Subject Code)<b></font></td>
	<td><font color=white><b>Subject Type<b></font></td>
	<td><font color=white><b>Choice<b></font></td>
	<td><font color=white><b>Delete<b></font></td>
	</tr>
	<%	
	qry="select A.subjectID subjectID,A.choice,B.SUBJECT||'('||b.SUBJECTCODE||')' subject, decode(A.SUBJECTTYPE,'C','Core','E','Elective') STYPE, nvl(ELECTIVECODE,' ')ECODE";
	qry=qry+" from PR#STUDENTSUBJECTCHOICE A,SUBJECTMASTER B where A.institutecode='"+mInst+"' ";
	qry=qry+" and A.examcode='"+mExam+"' and A.academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and ";
	qry=qry+" A.semestertype='RWJ' and ";
	qry=qry+" A.studentid='"+mDID+"'  and ";	
	qry=qry+" A.subjectID=B.subjectID Order By A.choice";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		msno++;
		%>
		<tr>
		<td>&nbsp;<%=msno%>.</td>
		<td><%=rs.getString("subject")%></td>
		<%
		if(rs.getString("STYPE").equals("Core"))
		{
			%>
			<td>&nbsp;<%=rs.getString("STYPE")%></td>
			<%
		}
		else if(rs.getString("STYPE").equals("Elective") && !rs.getString("ECODE").equals(" "))
		{
			%>
			<td>&nbsp;<%=rs.getString("STYPE")%> [<%=rs.getString("ECODE")%>]</td>
			<%
		}
		else if(rs.getString("STYPE").equals("Elective") && rs.getString("ECODE").equals(" "))
		{
			%>
			<td>&nbsp;<%=rs.getString("STYPE")%></td>
			<%
		}
		%>
		<td align=left>&nbsp; &nbsp; &nbsp;<b><%=rs.getString("choice")%></b></td>
		<td title='Do you want to delete the record?'><a href ='BackPaperChoiceDelete.jsp?mCh=<%=rs.getString("choice")%>&amp;mSc=<%=rs.getString("subjectcode")%>&amp;mEc=<%=mExam%>&amp;mAca=<%=mAcad%>'><b>Delete?</b><title="Edit the current Candidate"></a></td>
		</tr>
		<%
	   }
	   %>
	   </table>
	   <table width='100%' cellpadding=0 cellspacing=0>
		<tr><TD colspan=5 align=left>
		<br><font size=2 color=green># You are recommended to register Backlog Papers before <u>Send to HOD</u>.
		<br># Please give your first Choice to the Subjects, which are currently running in junior's batches.
		<br># Once you send to HOD, you cann't submit or delete any registration /choice.</font>
		</td></tr>
	   </table>
	   <form name="frm2" method=post>
	   <!--<table width='100%' cellpadding=0 cellspacing=0>
		<tr><TD colspan=5 align=left title='Send to HOD?'><font color="blue" size=3><b>&nbsp; Finalize and Send to HOD?&nbsp;</b></font>
	      <INPUT id=radio1 type=radio name=ChkBackLog title='Send to HOD?' value =Y><b>Yes</b>
	      &nbsp;<font color=red><b>/</b></font>
		<INPUT id=radio2 type=radio checked value=N name=ChkBackLog><b>No</b>
		<INPUT Type="submit" Value="Send to HOD"></TD></TR>
		<tr><TD colspan=5 align=left>
		<br><font size=2 color=green># You are recommended to register Backlog Papers before <u>Send to HOD</u>.
		<br># Please give your first Choice to the Subjects, which are currently running in junior's batches.
		<br># Once you mark to 'Yes' [ Send to HOD ], you cann't register or delete any registration.</font>
		</td></tr>
	   </table>-->
	   <%
		mSendToHOD=request.getParameter("ChkBackLog");
/*		if(mSendToHOD.equals("Y"))
		{
			qry="UPDATE PREVENTS SET SENDTOHOD='Y'";
			qry=qry+" WHERE INSTITUTECODE='"+mInst+"' and PREVENTCODE='"+mPrECode+"' AND MEMBERTYPE='"+mChkMType+"' AND MEMBERID='"+mDID+"'";
			qry=qry+" and (InstituteCode, PrEventCode) In (Select InstituteCode, PrEventCode from PREVENTMaster where ExamCode='"+mExam+"' and PRCompleted='N' and ";
			qry=qry+" nvl(PRBROADCAST,'N')='Y' and nvl(FREEELECTIVERUNFINALIZED,'N')='N' and nvl(BACKLOGSUBJECTFINALIZED,'N')='N' and nvl(PRREQUIREDFOR,'N')='S')";

			//out.print(qry);
			n1=db.update(qry);
			if(n1>0)
			{
				// Log Entry
				//-----------------
				db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"PR-REGISTRATION: STUDENT BACKPAPER CHOICE FINALIZED/SENDTOHOD", "ExamCode: "+mExam+"Subjectcode :"+mSubj, "NO MAC Address" , mIPAddress);
				//-----------------
				response.sendRedirect("PRStudentEntryBackPaper.jsp");
				LockFlag=1;
			}
		}	*/
	   %>
	   </form>
	   <%
	   }	
	   else
	   {
		%>
		<hr>
		<center><font size=4 face=Verdana color=green> Back Paper Choices sent to HOD</FONT></center>
		<hr><br>
		<font color=black size=3><b>List of Choice for Back Log Papers</b><font>
		<table width='100%' cellpadding=0 cellspacing=0 rules=groups>
		<tr bgcolor="#ff8c00">
		<td><font color=white><b>SNo<b></font></td>
		<td><font color=white><b>&nbsp;Subject Name (Subject Code)<b></font></td>
		<td><font color=white><b>Subject Type<b></font></td>
		<td><font color=white><b>Choice<b></font></td>
		<td align=center><font color=white><b>Status<b></font></td>
		</tr>
		<%

	qry="select A.choice,B.SUBJECT||'('||b.sUBJECTcODE||')' subject, decode(A.SUBJECTTYPE,'C','Core','E','Elective') STYPE, nvl(ELECTIVECODE,' ')ECODE";
	qry=qry+" from PR#STUDENTSUBJECTCHOICE A,SUBJECTMASTER B where A.institutecode='"+mInst+"' ";
	qry=qry+" and A.examcode='"+mExam+"' and A.academicyear='"+mAcad+"' and A.programcode='"+mProg+"'";
	qry=qry+" and A.semestertype='RWJ' and ";
	qry=qry+" A.studentid='"+mDID+"'  and ";	
	qry=qry+" A.subjectID=B.subjectID Order By A.choice";
	//out.print(qry);
	rs=db.getRowset(qry);
	while(rs.next())
	{
		msno++;
		%>
		<tr>
		<td>&nbsp;<%=msno%>.</td>
		<td><%=rs.getString("subject")%></td>
		<%
		if(rs.getString("STYPE").equals("Core"))
		{
			%>
			<td>&nbsp;<%=rs.getString("STYPE")%></td>
			<%
		}
		else if(rs.getString("STYPE").equals("Elective") && !rs.getString("ECODE").equals(" "))
		{
			%>
			<td>&nbsp;<%=rs.getString("STYPE")%> [<%=rs.getString("ECODE")%>]</td>
			<%
		}
		else if(rs.getString("STYPE").equals("Elective") && rs.getString("ECODE").equals(" "))
		{
			%>
			<td>&nbsp;<%=rs.getString("STYPE")%></td>
			<%
		}
		%>
		<td align=left>&nbsp; &nbsp; &nbsp;<b><%=rs.getString("choice")%></b></td>
		<td align=center><b><font color=Green>Submitted</font></b></td>
		</tr>
		<%
	   }
	   %>
	   </table>
	   <table align=left width=100%><tr><td align=left><font color=Green size=2>You are recommended to use <u>Send to HOD</u> after submitting your Choice for Regular and Back Paper.</font></td></tr></table>
		<br><br><br><br><table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
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
		<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
		<P>	This page is not authorized/available for you.
		<br>For assistance, contact your network support team. <br><br><br>
		</font>
	   <%
	}
	  //-----------------------------
	}
	else
	{
		%>
		<br>
		Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
		<%
	}
}
catch(Exception e)
{
}
%>
</body>
</Html>