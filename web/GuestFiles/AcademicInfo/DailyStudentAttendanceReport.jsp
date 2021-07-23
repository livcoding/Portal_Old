<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null, rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="",mLTP="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String mMemberName="", mExam="",mSubject="",mexam="",mSubj="",mColor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="", mSExam="", mSES="";
String QryExam="",QrySubj="",QryLTP="",QrySecBr="", QrySubSec="", QryStID="", QryFSTID="";
String mltp1="", mRollno="",mStName="";
String mInst="", mComp="",mDate1="",mDate2="",mFacultyName="",mFaculty="",QryFaculty="";
int Ctr=0, mDiffInDate=0;
long QryTotCls=0, QryTotPrs=0, QryPercAtt=0;

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1, to_Char((Sysdate-6),'dd-mm-yyyy') date2 from dual";
rs=db.getRowset(qry);
rs.next();
String mCurrDate=rs.getString("date1");
String mPrevDate=rs.getString("date2");

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
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
<TITLE>#### <%=mHead%> [ Students Class Attendance in Percentage(%) ] </TITLE>

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
<script type="text/javascript" src="js/TimePicker.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(Exam,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection)
{
	removeAllOptions(Subject);
	var subj='?';
	var mflag=0;
	var ssec='?';
	for(i=0;i<DataCombo.options.length;i++)
      {	
		var v1;
		var pos;
		var exam;
		var sc;
		var len;
		var otext;
		var v1=DataCombo.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		exam=v1.substring(0,pos);
		sc=v1.substring(pos+3,len);
		if (exam==Exam)
		{ 	if(mflag==0) 
			{
			subj=sc;
			mflag=1;
			}
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=sc;
			Subject.options.add(optn);
		}
	}
	removeAllOptions(Section);
	mflag=0;
	var optns = document.createElement("OPTION");
	optns.text='ALL';
	optns.value='ALL';
	Section.options.add(optns);
	ssec='ALL';
	for(i=0;i<DataComboSec.options.length;i++)
	{	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var scse;
		var otexts;
		var v1s=DataComboSec.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		if (exams==Exam && subj==scs)
		{ 				
			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options(i).text;
			optns.value=scse;
			Section.options.add(optns);
		}
	}	
	removeAllOptions(SubSection);
	var optns1 = document.createElement("OPTION");
	optns1.text='ALL';
	optns1.value='ALL';
	SubSection.options.add(optns1);
	for(i=0;i<DataComboSub.options.length;i++)
	{	
		var v1s1;
		var pos1;
		var pos2;
		var pos3;
		var exams1;
		var scs1;
		var lens1;
		var scse1;
		var otexts1;
		var subsec;
		var v1s1=DataComboSub.options(i).value;

		lens1= v1s1.length ;	
		pos11=v1s1.indexOf('***');
		pos21=v1s1.indexOf('///');
		pos3=v1s1.indexOf('*****');
		exams=v1s1.substring(0,pos11);
		scs1=v1s1.substring(pos11+3,pos21);
		scse1=v1s1.substring(pos21+3,pos3);
		subsec=v1s1.substring(pos3+5,lens1);
		if (exams==Exam && subj==scs1 && ssec=='ALL')
		{ 			
					
			var optns1 = document.createElement("OPTION");
			optns1.text=DataComboSub.options(i).text;
			optns1.value=subsec;
			SubSection.options.add(optns1);
		}
	}		
}
//********Click event on subject**********
function ChangeSubject(Exam,subj,DataComboSec,Section,DataComboSub,SubSection)
{
	var mflag=0;
	var ssec='?';
	removeAllOptions(Section);
	mflag=0;
	var optns = document.createElement("OPTION");
	optns.text='ALL';
	optns.value='ALL';
	Section.options.add(optns);
	ssec='ALL';
	for(i=0;i<DataComboSec.options.length;i++)
	{	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var scse;
		var otexts;
		var v1s=DataComboSec.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		if (exams==Exam && subj==scs)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options(i).text;
			optns.value=scse;
			Section.options.add(optns);
		}
	}	
	removeAllOptions(SubSection);
	var optns1 = document.createElement("OPTION");
	optns1.text='ALL';
	optns1.value='ALL';
	SubSection.options.add(optns1);
	for(i=0;i<DataComboSub.options.length;i++)
	{	
		var v1s1;
		var pos1;
		var pos2;
		var pos3;
		var exams1;
		var scs1;
		var lens1;
		var scse1;
		var otexts1;
		var subsec;
		var v1s1=DataComboSub.options(i).value;

		lens1= v1s1.length ;	
		pos11=v1s1.indexOf('***');
		pos21=v1s1.indexOf('///');
		pos3=v1s1.indexOf('*****');
		exams=v1s1.substring(0,pos11);
		scs1=v1s1.substring(pos11+3,pos21);
		scse1=v1s1.substring(pos21+3,pos3);
		subsec=v1s1.substring(pos3+5,lens1);

		if (exams==Exam && subj==scs1)// && ssec=='ALL')
		{ 			
			var optns1 = document.createElement("OPTION");
			optns1.text=DataComboSub.options(i).text;
			optns1.value=subsec;
			SubSection.options.add(optns1);
		}
	}		
}
//************click event on section***********
function ChangeSection(Exam,subj,ssec,DataComboSub,SubSection)
{
	removeAllOptions(SubSection);
	var optns1 = document.createElement("OPTION");
	optns1.text='ALL';
	optns1.value='ALL';
	SubSection.options.add(optns1);

	for(i=0;i<DataComboSub.options.length;i++)
	{	
		var v1s1;
		var pos1;
		var pos2;
		var pos3;
		var exams1;
		var scs1;
		var lens1;
		var scse1;
		var otexts1;
		var subsec;
		var v1s1=DataComboSub.options(i).value;

		lens1= v1s1.length ;	
		pos11=v1s1.indexOf('***');
		pos21=v1s1.indexOf('///');
		pos3=v1s1.indexOf('*****');
		exams=v1s1.substring(0,pos11);
		scs1=v1s1.substring(pos11+3,pos21);
		scse1=v1s1.substring(pos21+3,pos3);
		subsec=v1s1.substring(pos3+5,lens1);

		if (exams==Exam && subj==scs1 && ssec=='ALL')
		{ 			
			var optns1 = document.createElement("OPTION");
			optns1.text=DataComboSub.options(i).text;
			optns1.value=subsec;
			SubSection.options.add(optns1);
		}
		else if(exams==Exam && subj==scs1 && ssec==scse1)
		{
			var optns1 = document.createElement("OPTION");
			optns1.text=DataComboSub.options(i).text;
			optns1.value=subsec;
			SubSection.options.add(optns1);
		}
	}		
}
function removeAllOptions(selectbox)
{
	var i;
	for(i=selectbox.options.length-1;i>=0;i--)
	{
		selectbox.remove(i);
	}
}
</SCRIPT>	
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
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
		qry="Select WEBKIOSK.ShowLink('82','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	 	RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
  //----------------------
			%>
			<form name="frm" method="post">
			<input id="x" name="x" type=hidden>
			<center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Student Wise Class Attendance</b></font></center>
			<table id=id2 cellpadding=1 cellspacing=1 align=center rules=groups border=2>
			<!--Institute****-->
			<Input Type=hidden name=InstCode Value=<%=mInst%>>
			<tr><td nowrap colspan=4>
			<FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
			<%
			try
			{ 	
				qry="Select nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where ";
				qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
				qry=qry+" and examcode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where InstituteCode='"+mInst+"' And CompanyCode='"+mComp+"') ";
				qry=qry+" order by EXAMPERIODFROM ";
				//out.print(qry);
				rs=db.getRowset(qry);
				if (request.getParameter("x")==null) 
				{
					%>
					<Select Name=Exam tabindex="0" id="Exam" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">	
					<%
					while(rs.next())
					{
						mExam=rs.getString("Exam");
						if(mexam.equals(""))
			 			{
							mexam=mExam;
							QryExam=mExam;
							%>
							<OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
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
					<select name=Exam tabindex="0" id="Exam" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">	
					<%
					while(rs.next())
					{
						mExam=rs.getString("Exam");
						if(mExam.equals(request.getParameter("Exam").toString().trim()))
 						{
							mexam=mExam;
							QryExam=mExam;
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
				// out.println("Error Msg");
			}
			%>
			<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; Faculty&nbsp;</STRONG>
			<%
			qry="select nvl(A.entrybyfacultyid,' ')Faculty, nvl(b.employeename,' ')FacultyName from v#studentattendance A, Employeemaster B where nvl(A.deactive,'N')='N' and A.EMPLOYEEID='"+mChkMemID+"' and A.EMPLOYEEID=B.EMPLOYEEID";
			qry=qry+" union select nvl(A.entrybyfacultyid,' ')Faculty, nvl(b.employeename,' ') FacultyName from studentattendanceexcused A, Employeemaster B where A.ENTRYBYFACULTYID=B.EMPLOYEEID and nvl(A.deactive,'N')='N' and A.ENTRYBYFACULTYID='"+mChkMemID+"' order by Faculty asc";
			rs=db.getRowset(qry);
			//out.print(qry);
			%>
			<select name=Faculty tabindex="0" id="Faculty">
			<%
		 	if(request.getParameter("x")==null)
			{
				while(rs.next())
				{
				 	mFaculty=rs.getString("Faculty");
				 	mFacultyName=rs.getString("FacultyName");
					if(QryFaculty.equals(""))
		 			{			
						QryFaculty=mFaculty;
						%>
						<option selected value=<%=mFaculty%>><%=mFacultyName%></option>
						<%
					}
					else
					{
						%>
						<option value=<%=mFaculty%>><%=mFacultyName%></option>
						<%
					}
				}
			}
			else
			{
				while(rs.next())
				{
					mFaculty=rs.getString("Faculty");
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
						<option value=<%=mFaculty%>><%=mFacultyName%></option>
						<%
					}
				}
			}
			%>
			</select>
			</td>
<!--*********Exam*****************DataCombo**************-->
		<%
		try														
		{
			qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
			qry=qry+" From  facultysubjecttagging A,SUBJECTMASTER B where A.employeeid='"+mDMemberID+"' and A.fstid not in (select fstid from  ";
			qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='"+mInst+"' and ";
			qry=qry+" Nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') AND A.SUBJECTID=B.SUBJECTID";
			qry=qry+" union ";
			qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
			qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
			qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
			qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID ";
			qry=qry+" order by subject";
			//out.print(qry);
			rs=db.getRowset(qry);
			//out.print(qry);
			if (request.getParameter("x")==null) 
			{
				%>
				<Select Name=DataCombo id="DataCombo" style="WIDTH:0px">	
				<%   
				while(rs.next())
				{
					mExam=rs.getString("subjectid");
					mCode=rs.getString("examcode");
					mES=mCode+"***"+mExam;
					%>
					<OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
					<%
				}
				%>
				</select>
				<%
			}
			else
			{
				%>	
				<Select Name=DataCombo id="DataCombo" style="WIDTH:0px">	
				<%
				while(rs.next())
				{
					mExam=rs.getString("subjectid");
					mCode=rs.getString("examcode");
					mES=mCode+"***"+mExam;
					if(mExam.equals(request.getParameter("Subject").toString().trim()))
		 			{
						%>
						<OPTION selected Value=<%=mES%>><%=rs.getString("subject")%></option>
						<%			
				     	}
				     	else
				      {
						%>
				      	<OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
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
			// out.println("Error Msg");
		}
//----***************Subject**********************
		%>
		</tr>
		<tr><td nowrap>
		<FONT color=black face=Arial size=2><b>Subject</b>&nbsp;  </FONT>
		<%	
		qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
		qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.employeeid='"+mDMemberID+"' and A.fstid not in (select fstid from  ";
		qry=qry+"  STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
		qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID and A.EXAMCODE='"+QryExam+"' " ;
		qry=qry+" union ";
		qry=qry+" Select  nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
		qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
		qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
		qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"')AND A.SUBJECTID=B.SUBJECTID ";
		qry=qry+" and A.EXAMCODE='"+QryExam+"' order by subject";
		rs=db.getRowset(qry);
		//out.print(qry);
		%>
		<select name=Subject tabindex="0" id="Subject" onclick="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);">
		<%
		if (request.getParameter("x")==null) 
		{
			while(rs.next())
			{
				if(mSubj1.equals(""))
				{
					mSubj1=rs.getString("subjectid");
					QrySubj=mSubj1;
			 		%>
					<OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
					<%
				}
				else
				{
			 		%>
					<OPTION Value ='<%=rs.getString("subjectid")%>'><%=rs.getString("subject")%></option>
					<%
				}
			}
		}
		else
		{
			while(rs.next())
			{
				mSubj1=rs.getString("subjectid");
				if (mSubj1.equals(request.getParameter("Subject").toString().trim()))
				{
					QrySubj=mSubj1;
					%>
					<OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
					<%
				}
				else
				{
					%>
      				<OPTION Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
			     		<%
			   	}
			}
		}
		%>
		</select>
		&nbsp;
		<FONT color=black><FONT face=Arial size=2><STRONG>LTP </STRONG></FONT></FONT>
		&nbsp; 
		<%
		qry="Select LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical') LtpDesc,";
		qry=qry+"  Decode(nvl(LTP,' '),'L','1','T','2','P','3') orderltp ";
		qry=qry+" from  facultysubjecttagging A where A.employeeid='"+mDMemberID+"' and A.fstid not in (select fstid from  ";
		qry=qry+"  STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
		qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"' And InstituteCode='"+mInst+"') and  A.EXAMCODE='"+QryExam+"' " ;
		qry=qry+" union ";
		qry=qry+" Select  LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical') LtpDesc ,";
		qry=qry+"  decode(nvl(LTP,' '),'L','1','T','2','P','3') orderltp ";
		qry=qry+" from  facultysubjecttagging A where A.fstid in (select fstid from ";
		qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
		qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"') ";
		qry=qry+" and A.EXAMCODE='"+QryExam+"' ORDER BY orderltp ";
		rs=db.getRowset(qry);
		//out.print(qry);
		%>
		<select name=LTP tabindex="0" id="LTP">	
		<%
		if (request.getParameter("x")==null) 
		{
			while(rs.next())
			{
				mltp1=rs.getString("LTP");
				if(QryLTP.equals(""))
					QryLTP=mltp1;
				if(mltp1.equals("L"))
				{
			 		%>
					<OPTION selected Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
					<%
				}
				else
				{
			 		%>
					<OPTION Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
					<%
				}
			}
		}
		else
		{
			while(rs.next())
			{
				mltp1=rs.getString("LTP");
				if(QryLTP.equals(""))
					QryLTP=mltp1;
				if (mltp1.equals(request.getParameter("LTP").toString().trim()))
				{
					%>
					<OPTION selected Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
					<%
				}
				else
				{
					%>
		      		<OPTION Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
			     		<%
			   	}
			}
		}
		%>
		</select>
		</td></tr>
		<tr><td>
 <!******************Group/Section**************-->
		<FONT color=black><FONT face=Arial size=2><STRONG>Section</STRONG>&nbsp;</FONT></FONT>
		<%
		try
		{ 
			qry1="select 'ALL' section from dual union all";
			qry1=qry1+" select nvl(SECTIONBRANCH,' ') Section from  facultysubjecttagging where   ";
			qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and ";
			qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
			qry1=qry1+" or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y'  ) ";
			qry1=qry1+" and examcode='"+QryExam+"' and subjectid='"+QrySubj+"' Group By nvl(SECTIONBRANCH,' ') order by Section";
			//out.print(qry1);
			rs1=db.getRowset(qry1);
			if (request.getParameter("x")==null) 
			{
				%>
				<select name=Section tabindex="0" id="Section" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">	
				<%   
				while(rs1.next())
				{
					mSubj=rs1.getString("Section");
					QrySecBr=mSubj;
					%>
					<OPTION Value =<%=mSubj%>><%=rs1.getString("Section")%></option>
					<%			
				}
				%>
				</select>
				<%
			}
			else
			{
				%>	
				<select name=Section tabindex="0" id="Section" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">	
				<%
				while(rs1.next())
				{
					mSubj=rs1.getString("Section");
					if(mSubj.equals(request.getParameter("Section").toString().trim()))
		 			{
						QrySecBr=mSubj;
						%>
						<OPTION selected Value =<%=mSubj%>><%=rs1.getString("Section")%></option>
						<%			
				     	}
				     	else
				      {
						%>
				      	<OPTION Value =<%=mSubj%>><%=rs1.getString("Section")%></option>
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
//**********************DataComboSec***************
		try
		{ 
			qry1=" select nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging where  ";
			qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and ";
			qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
			qry1=qry1+" or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' )  Group by SECTIONBRANCH ,subjectid,EXAMCODE";
			qry1=qry1+" order by Section";
			//out.print(qry1);
			rs1=db.getRowset(qry1);
			if (request.getParameter("x")==null) 
			{
				%>
				<select name=DataComboSec tabindex="0" id="DataComboSec" style="WIDTH: 0px">	
				<%   
				while(rs1.next())
				{
					mSubj=rs1.getString("subjectid");
					mSExam=rs1.getString("examcode");
					mSES=mSExam+"***"+mSubj+"///"+rs1.getString("Section");
					%>
					<OPTION Value =<%=mSES%>><%=rs1.getString("Section")%></option>
					<%			
				}
				%>
				</select>
				<%
			}
			else
			{
				%>	
				<select name=DataComboSec tabindex="0" id="DataComboSec" style="WIDTH:0px">	
				<%
				while(rs1.next())
				{
					mSubj=rs1.getString("subjectid");
					mSExam=rs1.getString("examcode");
					mSES=mSExam+"***"+mSubj+"///"+rs1.getString("Section");

					if(mSES.equals(request.getParameter("Section").toString().trim()))
		 			{
						%>
						<OPTION selected Value =<%=mSES%>><%=rs1.getString("Section")%></option>
						<%			
				     	}
				     	else
				      {
						%>
				      	<OPTION Value =<%=mSES%>><%=rs1.getString("Section")%></option>
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
 <!******************Sub Group/Sub Section**************-->
		<FONT color=black><FONT face=Arial size=2><STRONG>Sub Sec.</STRONG></FONT></FONT>
		<%
		try
		{ 
			qry1="Select SUBSECTIONCODE SubSection from  facultysubjecttagging where  ";
			qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and ";
			qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
			qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
			qry1=qry1+" and examcode='"+QryExam+"' and subjectid='"+QrySubj+"'";
			qry1=qry1+" and sectionbranch=decode('"+QrySecBr+"','ALL',sectionbranch,'"+QrySecBr+"') Group By SUBSECTIONCODE order by SubSection ";
			//out.print(qry1);
			rs1=db.getRowset(qry1);
			if (request.getParameter("x")==null) 
			{		
				%>
				<select name=SubSection tabindex="0" id="SubSection">	
				<option Selected value='ALL'>ALL</option>
				<%   
				while(rs1.next())
				{
					mSubj=rs1.getString("SubSection");
					%>
					<OPTION Value =<%=mSubj%>><%=rs1.getString("SubSection")%></option>
					<%			
				}
				%>
				</select>
				<%
			}
			else
			{
				%>	
				<select name=SubSection tabindex="0" id="SubSection">	
				<%
				if("ALL".equals(request.getParameter("SubSection").toString().trim()))
	 			{
					%>
					<OPTION selected Value =ALL>ALL</option>
					<%			
		     		}
			     	else
			      {
					%>
					<OPTION Value =ALL>ALL</option>
		      		<%			
			   	}
				while(rs1.next())
				{
					mSubj=rs1.getString("SubSection");
					if(mSubj.equals(request.getParameter("SubSection").toString().trim()))
		 			{
						%>
						<OPTION selected Value =<%=mSubj%>><%=rs1.getString("SubSection")%></option>
						<%			
				     	}
				     	else
				      {
						%>
				      	<OPTION Value =<%=mSubj%>><%=rs1.getString("SubSection")%></option>
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
//*************DataComboSub************
		try
		{ 
			qry1="Select SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ')subjectid from  facultysubjecttagging where   ";
			qry1=qry1+"  facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and ";
			qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
			qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
			qry1=qry1+" Group By SUBSECTIONCODE ,nvl(SECTIONBRANCH,' ') ,nvl(Examcode,' '),nvl(subjectid,' ') order by SubSection ";
			rs1=db.getRowset(qry1);
			if (request.getParameter("x")==null) 
			{
				%>
				<select name=DataComboSub tabindex="0" id="DataComboSub" style="WIDTH: 0px">	
				<%   
				while(rs1.next())
				{	
					mSubj=rs1.getString("subjectid");
					mSExam=rs1.getString("examcode");
					mSES=mSExam+"***"+mSubj+"///"+rs1.getString("Section")+"*****"+rs1.getString("SubSection");
					%>
					<OPTION Value =<%=mSES%>><%=rs1.getString("SubSection")%></option>
					<%			
				}
				%>
				</select>
				<%
			}
			else
			{
				%>	
				<select name=DataComboSub tabindex="0" id="DataComboSub" style="WIDTH: 0px">	
				<%
				while(rs1.next())
				{
					mSubj=rs1.getString("subjectid");
					mSExam=rs1.getString("examcode");
					mSES=mSExam+"***"+mSubj+"///"+rs1.getString("Section")+"*****"+rs1.getString("SubSection");
					if(mSES.equals(request.getParameter("DataComboSub").toString().trim()))
		 			{
						%>
						<OPTION selected Value =<%=mSES%>><%=rs1.getString("SubSection")%></option>
						<%			
				     	}
				     	else
				      {
						%>
				      	<OPTION Value =<%=mSES%>><%=rs1.getString("SubSection")%></option>
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
		&nbsp; 
		<%
		if (request.getParameter("x")!=null)
		{
			mDate1=request.getParameter("TXT1").toString().trim();
			mDate2=request.getParameter("TXT2").toString().trim();
		}
		else
		{
			mDate1=mPrevDate;
			mDate2=mCurrDate;
		}
		%>
		<font color=black face=arial size=2><STRONG>Attendance From</font><font face=arialblack size=2 color=Green>&nbsp;&nbsp;(DD-MM-YYYY)&nbsp;</font></STRONG></font>&nbsp;<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'>
		<!-- READONLY><a href="javascript:NewCal('TXT1','ddmmyyyy')"><img src="../../../../Images/cal.gif" width=16 height=16 border=0 alt="Pick a Date"></a>-->
		<font color=black face=arial size=2><STRONG>To</STRONG></font> <input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10>
		<!-- READONLY><a href="javascript:NewCal('TXT2','ddmmyyyy')"><img src="../../../../Images/cal.gif" width=16 height=16 border=0 alt="Pick a Date"></a>-->
		</td></tr>
		<tr><td align=center><input type="submit" value="View Attendance"></td></tr>
		</table>
		<table align=center><tr><td align=center><font size=2 color=red face=arialblack>&nbsp;Hint: </font><font face=arialblack size=2 color=Green>In case of <b>Dates</b> remain blank, the whole attendance will be displayed</font></td></tr></table>
		<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
		<thead>
		<tr bgcolor="#ff8c00">
		<td Title="Sort on SlNo"><font color="White"><b>SNo.</b></font></td>
		<td Title="Sort on Enrollment No"><font color="White"><b>Roll No.</b></font></td>
		<td Title="Sort on Name [CaseInsensitive]"><font color="White"><b>Name</b></font></td>
		<td Title="Sort on Registration Date"><font color="White"><b>Sec/SubSec.</b></font></td>
		<td Title="Sort on Registration Date"><font color="White"><b>Percentage(%)</b></font></td>
		</tr>
		</thead>
		<tbody>
		<%
		if(request.getParameter("x")!=null)
		{
			if(request.getParameter("Faculty")==null)
			{
				QryFaculty="";
			}
			else
			{
				QryFaculty=request.getParameter("Faculty").toString().trim();
			}
	
			mExam=request.getParameter("Exam").toString().trim();
			mSubject=request.getParameter("Subject").toString().trim();
			mLTP=request.getParameter("LTP").toString().trim();
			mSection=request.getParameter("Section").toString().trim();	
			mSubsection=request.getParameter("SubSection").toString().trim();	

			if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
				mDate1="";
			else
				mDate1=request.getParameter("TXT1").toString().trim();

			if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals(""))
				mDate2="";
			else
				mDate2=request.getParameter("TXT2").toString().trim();
			//out.print("Fac - "+QryFaculty+" Exam - "+mExam+" Subj - "+mSubject+" LTP - "+mLTP+" Sec - "+mSection+" SubSec - "+mSubsection+" DtFr - "+mDate1+" DtTo - "+mDate2);
			if((!mDate1.equals("") && gb.iSValidDate(mDate1)==true ||mDate1.equals("")) && (!mDate2.equals("") && gb.iSValidDate(mDate2)==true ||mDate2.equals("")))
			{
				qry="select FSTID FSTID, SECTIONBRANCH SECBR, SUBSECTIONCODE SUBSEC, STUDENTID STID, ENROLLMENTNO ENNO, STUDENTNAME STNM,LTP LTP,EXAMCODE EXAMCODE";
				qry=qry+" from V#STUDENTLTPDETAIL where employeeid='"+mDMemberID+"' and examcode='"+mExam+"' and subjectid='"+mSubject+"' and LTP='"+mLTP+"'";
				qry=qry+" and SECTIONBRANCH=decode('"+mSection+"','ALL',SECTIONBRANCH,'"+mSection+"') and SUBSECTIONCODE=decode('"+mSubsection+"','ALL',SUBSECTIONCODE,'"+mSubsection+"') order by ENNO";
				rs1=db.getRowset(qry);
				//out.print(qry);
				while(rs1.next())
				{
					Ctr++;
					QryFSTID=rs1.getString("FSTID").toString().trim();	
					mRollno=rs1.getString("ENNO").toString().trim();
					mStName=rs1.getString("STNM").toString().trim();
					QryLTP=rs1.getString("LTP").toString().trim();
					QryStID=rs1.getString("STID").toString().trim();
					QrySecBr=rs1.getString("SECBR").toString().trim();
					QrySubSec=rs1.getString("SUBSEC").toString().trim();
					QryExam=rs1.getString("EXAMCODE").toString().trim();

					qry1="select count(*)Tcount from V#STUDENTATTENDANCE where FSTID='"+QryFSTID+"' and SubjectID='"+mSubject+"' and LTP='"+QryLTP+"'";
					qry1=qry1+" and EXAMCODE='"+QryExam+"' and STUDENTID='"+QryStID+"' and INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N'";
					qry1=qry1+" and SECTIONBRANCH=decode('"+QrySecBr+"','ALL',SECTIONBRANCH,'"+QrySecBr+"') and SUBSECTIONCODE=decode('"+QrySubSec+"','ALL',SUBSECTIONCODE,'"+QrySubSec+"')";
					qry1=qry1+" and trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))";
					qry1=qry1+" GROUP BY EXAMCODE, SubjectID, LTP";
					rs=db.getRowset(qry1);
					//out.print(qry1);
					if(rs.next())
						QryTotCls=rs.getLong("Tcount");
					else
						QryTotCls=0;
					qry1="select count(*)Pcount from V#STUDENTATTENDANCE where FSTID='"+QryFSTID+"' and SubjectID='"+mSubject+"' and LTP='"+QryLTP+"' and EXAMCODE='"+QryExam+"'";
					qry1=qry1+" and STUDENTID='"+QryStID+"' and INSTITUTECODE='"+mInst+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N'";
					qry1=qry1+" and SECTIONBRANCH=decode('"+QrySecBr+"','ALL',SECTIONBRANCH,'"+QrySecBr+"') and SUBSECTIONCODE=decode('"+QrySubSec+"','ALL',SUBSECTIONCODE,'"+QrySubSec+"')";
					qry1=qry1+" and trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))";
					qry1=qry1+" GROUP BY EXAMCODE, SubjectID, LTP";
					rs=db.getRowset(qry1);
					//out.print(qry1);
					if(rs.next())
						QryTotPrs=rs.getLong("Pcount");
					else
						QryTotPrs=0;
					try
					{
						if(QryTotCls==0)
							QryPercAtt=0;
						else
							QryPercAtt=((QryTotPrs*100)/QryTotCls);

					//out.print(QryTotCls+" "+QryTotPrs+" Tot Percentage - "+QryPercAtt);
					}
					catch(ArithmeticException e)
					{
						//out.print(e);
					}
					%>
					<tr>
					<td><%=Ctr%>.</td>
					<td><%=mRollno%></td>
					<td nowrap><%=GlobalFunctions.toTtitleCase(mStName)%></td>
					<td><%=QrySecBr%>(<%=QrySubSec%>)</td>
					<%
					if(QryPercAtt>=50)
						mColor="GREEN";
					else
						mColor="RED";
					%>
					<td ALIGN=CENTER>&nbsp;<a Title="View Date wise <%=mStName%>'s Attendance" target=_New href=DailyStudentAttendanceReportDet.jsp?EXAM=<%=mExam%>&amp;SID=<%=QryStID%>&amp;SC=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>><font color=<%=mColor%>><b><%=QryPercAtt%></b> %</font></a></td>
					</tr>
					<%          						
					}
			}// closing of time 
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid time format. </font> <br><br>");
			}
			%>
			</tbod>
			</table>
			<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number", "Number", "CaseInsensitiveString"]);
			</script>
			</form>
			<%
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
		<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
	 //out.print("error");	
}
%>
</body>
</html>