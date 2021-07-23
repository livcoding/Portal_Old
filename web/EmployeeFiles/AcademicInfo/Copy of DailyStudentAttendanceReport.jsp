<%@ page language="java" import="java.sql.*,java.math.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null, rs1=null,rsBatchDate=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="",mLTP="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String mMemberName="", mExam="",mSubject="",mexam="",mSubj="",mColor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="", mSExam="", mSES="";
String QryExam="",QrySubj="",QryLTP="",QrySecBr="", QrySubSec="", QryStID="", QryFSTID="";
String mltp1="", mRollno="",mStName="";
String mInst="", mComp="",mDate1="",mDate2="",mFacultyName="",mFaculty="",QryFaculty="",mREGCONFIRMATIONDATE="";
boolean flag = false, flag1 = false;
int Ctr=0, mDiffInDate=0,mSem=0,check=0;
double QryTotCls=0, QryTotPrs=0, QryPercAtt=0,QryLTCls=0, QryLTPrs=0, QryLTPercAtt=0;

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1, to_Char((Sysdate-6),'dd-mm-yyyy') date2 from dual";
rs=db.getRowset(qry);
rs.next();
String mCurrDate=rs.getString("date1");
String mPrevDate=rs.getString("date2");
 BigDecimal  QryLTPPercDecimal=new  BigDecimal("0.00");
  BigDecimal  QryPercDecimal=new  BigDecimal("0.00");


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
function AlertMe()
		{
			
			dd.twait.value='';
		}	
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
<body onload="AlertMe()"  aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
			<center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial">Student Wise Class Attendance</font></center>
			<table id=id2 cellpadding=1 cellspacing=1 align=center rules=groups border=2>
			<!--Institute****-->
			<Input Type=hidden name=InstCode Value=<%=mInst%>>
			<tr><td nowrap colspan=4>
			<FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
			<%
			try
			{ 	
				qry=" Select Exam from (";
				qry+=" Select nvl(EXAMCODE,' ') Exam, EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(LOCKEXAM,'N')='N' AND ";
            	      qry+=" nvl(Deactive,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
				qry+=" and examcode in (Select examcode from facultysubjecttagging where fstid in (select fstid from studentattendance))";
	                  //qry+=" and examcode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
      	            qry+=" order by EXAMPERIODFROM DESC";
				qry+=") where rownum<8"; 
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
			qry="select nvl(A.entrybyfacultyid,' ')Faculty, nvl(b.employeename,' ')FacultyName from studentattendance A, Employeemaster B where nvl(A.deactive,'N')='N' and A.ENTRYBYFACULTYID='"+mChkMemID+"' and A.ENTRYBYFACULTYID=B.EMPLOYEEID";
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
			qry=qry+" From  facultysubjecttagging A,SUBJECTMASTER B where (   (a.employeeid = '"+mDMemberID+"')       OR (a.fstid IN ( SELECT C.fstid                        FROM multifacultysubjecttagging C                       WHERE a.fstid = C.fstid                             AND C.employeeid = '"+mDMemberID+"')             )      ) and A.fstid not in (select fstid from  ";
			qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='"+mInst+"' and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode   and ";
			qry=qry+" Nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') AND A.SUBJECTID=B.SUBJECTID  and a.INSTITUTECODE=b.INSTITUTECODE and a.INSTITUTECODE='"+mInst+"'  ";
			qry=qry+" union ";
			qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
			qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
			qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
			qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"') and  A.employeeid='"+mDMemberID+"' and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode  AND A.SUBJECTID=B.SUBJECTID ";
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
		qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where ((A.employeeid='"+mDMemberID+"') OR (A.FSTID IN (SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mDMemberID+"')))  ";
		qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
		qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID and A.EXAMCODE='"+QryExam+"'  AND a.institutecode ='"+mInst+"'     and a.INSTITUTECODE=b.INSTITUTECODE  " ;
		qry=qry+" union ";
		qry=qry+" Select  nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
		qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
		qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
		qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"')AND A.SUBJECTID=B.SUBJECTID ";
		qry=qry+" and A.EXAMCODE='"+QryExam+"'  AND a.institutecode ='"+mInst+"'     and a.INSTITUTECODE=b.INSTITUTECODE order by subject";
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
/*
		qry="Select LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
		qry=qry+" Decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
		qry=qry+" from  facultysubjecttagging A where A.employeeid='"+mDMemberID+"' and A.fstid not in (select fstid from  ";
		qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
		qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"' And InstituteCode='"+mInst+"') and  A.EXAMCODE='"+QryExam+"' " ;
		qry=qry+" union ";
		qry=qry+" Select  LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc ,";
		qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
		qry=qry+" from  facultysubjecttagging A where A.fstid in (select fstid from ";
		qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
		qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"') ";
		qry=qry+" and A.EXAMCODE='"+QryExam+"' ORDER BY orderltp ";
*/
	qry="Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and A.fstid not in (select fstid from  ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"')  " ;
	qry=qry+" union ";
	qry=qry+" Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where A.employeeid='"+mDMemberID+"' and A.fstid not in (select fstid from  ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"')  " ;
	qry=qry+" union ";
	qry=qry+" Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc ,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where A.fstid in (select fstid from ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"') ";
	qry=qry+"  ORDER BY orderltp ";
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
			qry1=qry1+" select nvl(A.SECTIONBRANCH,' ') Section from facultysubjecttagging A where   ";
			qry1=qry1+" ((A.employeeid='"+mDMemberID+"') OR (A.FSTID IN (SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mChkMemID+"')))";
			qry1=qry1+" and A.examcode='"+QryExam+"' and A.subjectid='"+QrySubj+"' and a.institutecode ='"+mInst+"'   Group By nvl(A.SECTIONBRANCH,' ') order by Section";
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
			qry1="select nvl(A.SECTIONBRANCH,' ') Section,nvl(A.subjectid,' ')subjectid,nvl(A.EXAMCODE,' ')examcode from  facultysubjecttagging A where";
			qry1=qry1+" ((A.employeeid='"+mDMemberID+"') or (A.FSTID IN(SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mChkMemID+"')))";
			qry1=qry1+" AND a.institutecode ='"+mInst+"'   Group by SECTIONBRANCH ,subjectid,EXAMCODE";
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
			qry1="Select A.SUBSECTIONCODE SubSection from facultysubjecttagging A where";
			qry1=qry1+" ((A.employeeid='"+mDMemberID+"') or (A.FSTID IN(SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mChkMemID+"')))";
			qry1=qry1+" and A.examcode='"+QryExam+"' and A.subjectid='"+QrySubj+"'";
			qry1=qry1+" and A.sectionbranch=decode('"+QrySecBr+"','ALL',A.sectionbranch,'"+QrySecBr+"') AND a.institutecode ='"+mInst+"'   Group By A.SUBSECTIONCODE order by SubSection ";
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
			qry1="Select A.SUBSECTIONCODE SubSection, nvl(A.SECTIONBRANCH,' ') Section, nvl(A.Examcode,' ')examcode, nvl(A.SubjectID,' ')subjectid from  facultysubjecttagging A where ";
			qry1=qry1+" ((A.employeeid='"+mDMemberID+"') or (A.FSTID IN(SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mChkMemID+"')))";
			qry1=qry1+" AND a.institutecode ='"+mInst+"'   Group By A.SUBSECTIONCODE ,nvl(A.SECTIONBRANCH,' ') ,nvl(A.Examcode,' '),nvl(A.SubjectID,' ') order by SubSection ";

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
		</form>
<form name="dd" id="dd">
<center>
<input style="width:200px;font-size:20px; 
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ; background-color:transparent"  name="twait" readonly id="twait" type="text" value="Please Wait.......">
</center>
</form>
		
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
			
			String QrySemType="";

			if((!mDate1.equals("") && gb.iSValidDate(mDate1)==true ||mDate1.equals("")) && (!mDate2.equals("") && gb.iSValidDate(mDate2)==true ||mDate2.equals("")))
			{
				qry="select A.FSTID FSTID, A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE SUBSEC, A.STUDENTID STID, A.ENROLLMENTNO ENNO, A.STUDENTNAME STNM,A.LTP LTP,A.EXAMCODE EXAMCODE, nvl(A.SEMESTER,0) SEMESTER,NVL(a.SEMESTERTYPE,' ')SEMESTERTYPE";
				qry=qry+" , A.AcademicYear AcademicYear from V#STUDENTLTPDETAIL A where  NVL(A.DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' and A.examcode='"+mExam+"' and A.subjectid='"+mSubject+"' and A.LTP='"+mLTP+"'";
				qry=qry+" and ((A.employeeid='"+mDMemberID+"') OR (A.FSTID IN (SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mChkMemID+"')))";
				qry=qry+" and A.SECTIONBRANCH=decode('"+mSection+"','ALL',A.SECTIONBRANCH,'"+mSection+"') and A.SUBSECTIONCODE=decode('"+mSubsection+"','ALL',A.SUBSECTIONCODE,'"+mSubsection+"') AND a.institutecode ='"+mInst+"' 	order by A.ENROLLMENTNO";
				rs1=db.getRowset(qry);
				//	out.print(qry);
				
				while(rs1.next())
				{
					check=1;
					mREGCONFIRMATIONDATE="";
		 			qry=" Select nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE  From StudentRegistration Where INSTITUTECODE='"+mInst+"'";
					qry=qry+" AND EXAMCODE='"+mExam+"'";
					qry=qry+" AND SEMESTER='"+rs1.getString("SEMESTER")+"' AND NVL(SEMESTERTYPE,' ')='REG'";
					qry=qry+" AND STUDENTID='"+rs1.getString("STID")+"'";					
					qry=qry+" AND ACADEMICYEAR='"+rs1.getString("ACADEMICYEAR")+"'";
					//out.print(qry);
					rsBatchDate=db.getRowset(qry);
					 if(rsBatchDate.next())
					{
						if(rsBatchDate.getString("REGCONFIRMATIONDATE")==null) 
							mREGCONFIRMATIONDATE="";
						else
							mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
					}
					else
					{
						mREGCONFIRMATIONDATE="";
					}
	
	
				
					Ctr++;
					if(Ctr==1)
					{					
						%>
						<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
						<thead>
						<tr bgcolor="#ff8c00">
						<td Title="Sort on SlNo"><font color="White"><b>SNo.</b></font></td>
						<td Title="Sort on Enrollment No"><font color="White"><b>Roll No.</b></font></td>
						<td Title="Sort on Name"><font color="White"><b>Name</b></font></td>
						<td Title="Sort on Section/Subsection"><font color="White"><b>Sec/SubSec.</b></font></td>
						<td Title="Sort on Percentage Value"><font color="White"><b>Percentage(%)</b></font></td>
						<%
					    qry = "Select DISTINCT A.LTP, DECODE(A.LTP,'L',1,'T',2,'P',3,4)LTPSEQ from facultysubjecttagging A where A.INSTITUTECODE='" + mInst + "' and A.COMPANYCODE='" + mComp + "' and A.EXAMCODE='" + QryExam + "' and A.SubjectID='" + QrySubj + "' and NVL(A.PROJECTSUBJECT,'N')='N' ORDER BY LTPSEQ";
						rs=db.getRowset(qry);
						//out.print(qry);
						while (rs.next())
						{
							if(rs.getString(1).equals("L"))
							{
								flag = true;
							}
							else if(rs.getString(1).equals("T") && flag == true)
							{
								flag1=true;
				                        %>
				                        <td Align=center Title="Student Lecture And Tutorial % Attendance Cummulatively"><font color="White"><b>L+T</b></font></td>
				                        <%
							}
					      }
						%>
						</tr>
						</thead>
						<tbody>
						<%
					}
					QryFSTID=rs1.getString("FSTID").toString().trim();	
					mRollno=rs1.getString("ENNO").toString().trim();
					mStName=rs1.getString("STNM").toString().trim();
					QryLTP=rs1.getString("LTP").toString().trim();
					QryStID=rs1.getString("STID").toString().trim();
					QrySecBr=rs1.getString("SECBR").toString().trim();
					QrySubSec=rs1.getString("SUBSEC").toString().trim();
					QryExam=rs1.getString("EXAMCODE").toString().trim();

					QrySemType=rs1.getString("SEMESTERTYPE").toString().trim();

					qry1="SELECT distinct count(tcount )tcount FROM (select distinct A.CLASSTIMEFROM Tcount from V#STUDENTATTENDANCE a where  a.SubjectID='"+mSubject+"' and a.LTP='"+QryLTP+"'";
					qry1=qry1+" and a.EXAMCODE='"+QryExam+"' and a.INSTITUTECODE='"+mInst+"' and nvl(a.DEACTIVE,'N')='N'   ";
				//	qry1=qry1+"  and FSTID='"+QryFSTID+"'	";
					qry1=qry1+"  AND  A.semestertype='"+QrySemType+"'	";  
					//		qry1=qry1+"  and a.employeeid = '"+mChkMemID+"'     		";  
						qry1=qry1+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
						qry1=qry1+" and trunc(a.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and a.SECTIONBRANCH=decode('"+QrySecBr+"','ALL',a.SECTIONBRANCH,'"+QrySecBr+"') and a.SUBSECTIONCODE=decode('"+QrySubSec+"','ALL',a.SUBSECTIONCODE,'"+QrySubSec+"')";
					qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))";
					qry1=qry1+"  UNION all select   distinct A.CLASSTIMEFROM Tcount from STUDENTPREVATTENDENCE a where  a.subjectid = '"+mSubject+"'     AND a.ltp ='"+QryLTP+"'     AND a.examcode = '"+QryExam+"'  and   NVL (a.deactive, 'N') = 'N' AND A.STUDENTID='"+QryStID+"' ";
					//	qry1=qry1+"  and FSTID='"+QryFSTID+"'		";  
					//		qry1=qry1+"  and a.employeeid = '"+mChkMemID+"'     		";  
					qry1=qry1+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
					qry1=qry1+"  AND  A.semestertype='"+QrySemType+"'	";  
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
						qry1=qry1+" and trunc(a.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and a.INSTITUTECODE='"+mInst+"')";

					rs=db.getRowset(qry1);
					//out.print(qry1);
					if(rs.next())
						QryTotCls=rs.getLong("Tcount");
					else
						QryTotCls=0;

					/*qry1="SELECT SUM (pcount)pcount FROM (select count(*)Pcount from V#STUDENTATTENDANCE where FSTID='"+QryFSTID+"' and SubjectID='"+mSubject+"' and LTP='"+QryLTP+"'  and  EXAMCODE='"+QryExam+"'";
					qry1=qry1+" and STUDENTID='"+QryStID+"' and INSTITUTECODE='"+mInst+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N'";
					qry1=qry1+" and SECTIONBRANCH=decode('"+QrySecBr+"','ALL',SECTIONBRANCH,'"+QrySecBr+"') and SUBSECTIONCODE=decode('"+QrySubSec+"','ALL',SUBSECTIONCODE,'"+QrySubSec+"')";
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
					qry1=qry1+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy hh:mi'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy hh:mi')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy hh:mi'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy hh:mi')))";
					qry1=qry1+"   UNION all select  COUNT(classtimefrom) pcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'     AND ltp ='"+QryLTP+"'   AND NVL (present, 'N') = 'Y'   AND examcode = '"+QryExam+"'  AND studentid = '"+QryStID+"'  and    NVL (deactive, 'N') = 'N' ";        
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
					qry1=qry1+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and INSTITUTECODE='"+mInst+"')";*/


					qry1="SELECT distinct count(pcount )pcount FROM (select distinct A.CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a where  a.SubjectID='"+mSubject+"' and a.LTP='"+QryLTP+"'";
					qry1=qry1+" and a.EXAMCODE='"+QryExam+"' and a.INSTITUTECODE='"+mInst+"' and nvl(a.DEACTIVE,'N')='N'  AND NVL (a.present, 'N') = 'Y'  ";
					//	qry1=qry1+"  and FSTID='"+QryFSTID+"'		";
					//qry1=qry1+"  and a.employeeid = '"+mChkMemID+"'     		";
					qry1=qry1+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
					qry1=qry1+"  AND  A.semestertype='"+QrySemType+"'	";  
					qry1=qry1+" and STUDENTID='"+QryStID+"' 	";  
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
						qry1=qry1+" and trunc(a.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and a.SECTIONBRANCH=decode('"+QrySecBr+"','ALL',a.SECTIONBRANCH,'"+QrySecBr+"') and a.SUBSECTIONCODE=decode('"+QrySubSec+"','ALL',a.SUBSECTIONCODE,'"+QrySubSec+"')";
					qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))";
					qry1=qry1+"  UNION all select   distinct A.CLASSTIMEFROM pcount from STUDENTPREVATTENDENCE a where  a.subjectid = '"+mSubject+"'     AND a.ltp ='"+QryLTP+"'     AND a.examcode = '"+QryExam+"'  and   NVL (a.deactive, 'N') = 'N' AND NVL (a.present, 'N') = 'Y'  ";
					qry1=qry1+" and a.STUDENTID='"+QryStID+"' 	";  
					qry1=qry1+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
					//		qry1=qry1+"  and a.employeeid = '"+mChkMemID+"'     		";  
					//qry1=qry1+"  and FSTID='"+QryFSTID+"'		";  
					qry1=qry1+"  AND  A.semestertype='"+QrySemType+"'	";  
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
						qry1=qry1+" and trunc(a.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and a.INSTITUTECODE='"+mInst+"')";


					rs=db.getRowset(qry1);
					//out.print(qry1);
					if(rs.next())
						QryTotPrs=rs.getLong("Pcount");
					else
						QryTotPrs=0;
					try
					{
						if(QryTotCls==0)
						{
							QryPercAtt=0;
							QryPercDecimal=new  BigDecimal("0.00");
						}
						else
						{	QryPercAtt=((QryTotPrs*100)/QryTotCls);
						     //QryPercAtt=Math.round(QryPercAtt);
							  QryPercDecimal=new BigDecimal(QryPercAtt);
                                   // out.println ( bd.setScale ( 2,BigDecimal.ROUND_HALF_UP )  ) ;
                                    QryPercDecimal= QryPercDecimal.setScale ( 2,BigDecimal.ROUND_HALF_UP ) ;
						}

		//out.print(QryTotCls+" "+QryTotPrs+" Tot Percentage - "+QryPercAtt+" QryPercDecimal "+QryPercDecimal);
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
					/*if(QryPercAtt>=75)
						mColor="GREEN";
					else
						mColor="RED";*/
					%>
					<td ALIGN=LEFT>&nbsp;<a Title="View Date wise <%=mStName%>'s Attendance" target=_New href="DailyStudentAttendanceReportDet.jsp?RightsID=82&amp;EXAM=<%=mExam%>&amp;SID=<%=QryStID%>&amp;SC=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;FSTID=<%=QryFSTID%>&amp;SEMESTERTYPE=<%=QrySemType%>"><font color=<%=mColor%>><b><%=QryPercDecimal%></b> %</font></a></td>
					<%
					if(flag1==true)
					{

						/*
		                  qry1="SELECT SUM (Tcount)Tcount FROM (select count(CLASSTIMEFROM)Tcount from V#STUDENTATTENDANCE where  SubjectID='"+mSubject+"' and LTP in ('L','T')  ";
					qry1=qry1+" and EXAMCODE='"+QryExam+"' and INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N'";
					qry1=qry1+" and STUDENTID='"+QryStID+"'";
					qry1=qry1+" and SECTIONBRANCH=decode('"+QrySecBr+"','ALL',SECTIONBRANCH,'"+QrySecBr+"') and SUBSECTIONCODE=decode('"+QrySubSec+"','ALL',SUBSECTIONCODE,'"+QrySubSec+"')";
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
					qry1=qry1+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))";
					qry1=qry1+"  UNION all  select  COUNT (classtimefrom) Tcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'     AND LTP in ('L','T')     and  examcode = '"+QryExam+"'  AND studentid = '"+QryStID+"' ";  
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
					qry1=qry1+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" And NVL (deactive, 'N') = 'N'   and INSTITUTECODE='"+mInst+"'         )";*/
					
qry1="SELECT distinct count(tcount )tcount FROM (select distinct A.CLASSTIMEFROM Tcount,a.ltp from V#STUDENTATTENDANCE a where  a.SubjectID='"+mSubject+"' and a.LTP in ('L','T')  ";
					qry1=qry1+" and a.EXAMCODE='"+QryExam+"' and a.INSTITUTECODE='"+mInst+"' and nvl(a.DEACTIVE,'N')='N' AND  A.semestertype='"+QrySemType+"'  ";
		//qry1=qry1+"  and a.employeeid = '"+mChkMemID+"'     		";  
				qry1=qry1+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
				//	qry1=qry1+"  and a.FSTID='"+QryFSTID+"'		";  
				//	qry1=qry1+" and STUDENTID='"+QryStID+"' and FSTID='"+QryFSTID+"'		";  
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
						qry1=qry1+" and trunc(a.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and a.SECTIONBRANCH=decode('"+QrySecBr+"','ALL',a.SECTIONBRANCH,'"+QrySecBr+"') and a.SUBSECTIONCODE=decode('"+QrySubSec+"','ALL',a.SUBSECTIONCODE,'"+QrySubSec+"')";
					qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))";
					qry1=qry1+"  UNION all select   distinct A.CLASSTIMEFROM Tcount,a.ltp from STUDENTPREVATTENDENCE a where  a.subjectid = '"+mSubject+"'  AND  A.semestertype='"+QrySemType+"'    AND a.LTP in ('L','T')      AND a.examcode = '"+QryExam+"'  and   NVL (a.deactive, 'N') = 'N' AND A.STUDENTID='"+QryStID+"' ";
				//	qry1=qry1+"  and a.employeeid = '"+mChkMemID+"'     		";  
					qry1=qry1+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
				//	qry1=qry1+"  and a.FSTID='"+QryFSTID+"'		";  
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
						qry1=qry1+" and trunc(a.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and a.INSTITUTECODE='"+mInst+"')";
				//	out.print(qry1);
					rs=db.getRowset(qry1);
					if(rs.next())
						QryLTCls=rs.getLong("Tcount");
					else
						QryLTCls=0;


					

					/*qry1="SELECT SUM (Pcount)Pcount FROM (select count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"'   and LTP in ('L','T') and EXAMCODE='"+QryExam+"'  ";
					qry1=qry1+" and STUDENTID='"+QryStID+"' and INSTITUTECODE='"+mInst+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N'";
					qry1=qry1+" and SECTIONBRANCH=decode('"+QrySecBr+"','ALL',SECTIONBRANCH,'"+QrySecBr+"') and SUBSECTIONCODE=decode('"+QrySubSec+"','ALL',SUBSECTIONCODE,'"+QrySubSec+"')";
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
					qry1=qry1+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))";
					qry1=qry1+"   UNION all  select  COUNT (classtimefrom) Pcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'     AND LTP in ('L','T')  AND NVL (present, 'N') = 'Y'   AND examcode = '"+QryExam+"'  AND studentid = '"+QryStID+"' and   NVL (deactive, 'N') = 'N'        ";
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
					qry1=qry1+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and INSTITUTECODE='"+mInst+"')";*/

				qry1="SELECT distinct count(pcount )pcount FROM (select distinct A.CLASSTIMEFROM pcount ,a.ltp from V#STUDENTATTENDANCE a where  a.SubjectID='"+mSubject+"' and a.LTP in ('L','T') ";
				qry1=qry1+" and a.EXAMCODE='"+QryExam+"' and a.INSTITUTECODE='"+mInst+"' and nvl(a.DEACTIVE,'N')='N'  AND NVL (a.present, 'N') = 'Y' AND  A.semestertype='"+QrySemType+"'   ";
				//	qry1=qry1+"  and a.FSTID='"+QryFSTID+"'		";  
				qry1=qry1+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
					qry1=qry1+" and STUDENTID='"+QryStID+"' 	";  
					//		qry1=qry1+"  and employeeid = '"+mChkMemID+"'     		";  
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
						qry1=qry1+" and trunc(a.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and a.SECTIONBRANCH=decode('"+QrySecBr+"','ALL',a.SECTIONBRANCH,'"+QrySecBr+"') and a.SUBSECTIONCODE=decode('"+QrySubSec+"','ALL',a.SUBSECTIONCODE,'"+QrySubSec+"')";
					qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))";
					qry1=qry1+"  UNION all select   distinct A.CLASSTIMEFROM pcount ,a.ltp from STUDENTPREVATTENDENCE a where  a.subjectid = '"+mSubject+"'  AND  A.semestertype='"+QrySemType+"'    AND a.LTP in ('L','T')    AND a.examcode = '"+QryExam+"'  and   NVL (a.deactive, 'N') = 'N' AND NVL (a.present, 'N') = 'Y'  ";
					qry1=qry1+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
						qry1=qry1+" and a.STUDENTID='"+QryStID+"' 	";  
					//			qry1=qry1+"  and a.employeeid = '"+mChkMemID+"'     		";  
					//qry1=qry1+"  and a.FSTID='"+QryFSTID+"'		";  
					if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(""))
						{
						qry1=qry1+" and trunc(a.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					qry1=qry1+" and a.INSTITUTECODE='"+mInst+"')";

				//	out.print(qry1);
					rs=db.getRowset(qry1);
						
					if(rs.next())
						QryLTPrs=rs.getLong("Pcount");
					else
						QryLTPrs=0;
					try
					{
						if(QryLTCls==0)
						{ QryLTPercAtt=0;
							QryLTPPercDecimal=new  BigDecimal("0.00");
						}
						else
						{	QryLTPercAtt=((QryLTPrs*100)/QryLTCls);
							// QryLTPercAtt=Math.round(QryLTPercAtt);
							   QryLTPPercDecimal=new BigDecimal(QryLTPercAtt);
                                   // out.println ( bd.setScale ( 2,BigDecimal.ROUND_HALF_UP )  ) ;
                                    QryLTPPercDecimal= QryLTPPercDecimal.setScale ( 2,BigDecimal.ROUND_HALF_UP ) ;
						}
					//out.print(QryLTCls+" "+QryLTPrs+" Tot Percentage - "+QryLTPercAtt);
					}
					catch(ArithmeticException e)
					{
						//out.print(e);
					}
                  	
				/*	if(QryLTPercAtt>=50)
						mColor="GREEN";
					else
						mColor="RED";*/
					%>
					<td ALIGN=LEFT>&nbsp;<a Title="View Date wise <%=mStName%>'s Attendance" target=_New href="DailyStudentAttendanceReportDet.jsp?RightsID=82&amp;EXAM=<%=mExam%>&amp;SID=<%=QryStID%>&amp;SC=<%=mSubject%>&amp;LTP=LT&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>"><font color=<%=mColor%>><b><%=QryLTPPercDecimal%></b> %</font></a></td>
					<%
                        }
				%>
				</tr>
				<%          						
			}
				
				if (check==0)
				{
					out.print("&nbsp;&nbsp;&nbsp<center> <b><font size=3 face='Arial' color='Red'>No Record Found ! </font></center>");
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
			var st1 = new SortableTable(document.getElementById("table-1"),["Number", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString", "Number", "Number"]);
			</script>
			
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
	// out.print("error"+qry1);	
}
%>
</body>
</html>