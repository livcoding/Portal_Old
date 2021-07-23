<%@ page language="java" import="java.sql.*,java.math.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null, rs1=null,rsBatchDate=null,rsyyyy=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="",mLTP="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="",mREGCONFIRMATIONDATE1="",qrtyyy="";
String mMemberCode="", mDMemberCode="";
String mMemberName="", mExam="",mSubject="",mexam="",mSubj="",mColor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="", mSExam="", mSES="";
String QryExam="",QrySubj="",QryLTP="",QrySecBr="", QrySubSec="", QryStID="", QryFSTID="";
String mltp1="", mRollno="",mStName="";
String mInst="",QryType="R", mComp="",mDate1="",mDate2="",mFacultyName="",mFaculty="",QryFaculty="",mREGCONFIRMATIONDATE="";
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

	String QrySemType="",mStudentid="",mSpecialApproval="",TRCOLOR1="",QryAcad="",QryProgramCode="";
			double mPresent=0, mL=0, mT=0, mP=0, mLP=0, mTP=0, mPP=0;

								double mPercL=0,mPercT=0,mPercP=0,mPercLT=0;
			

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
			aa.twait1.value='';
		
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
		var v1=DataCombo.options[i].value;
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
			optn.text=DataCombo.options[i].text;
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
		var v1s=DataComboSec.options[i].value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		if (exams==Exam && subj==scs)
		{ 				
			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options[i].text;
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
		var v1s1=DataComboSub.options[i].value;

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
			optns1.text=DataComboSub.options[i].text;
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
		var v1s=DataComboSec.options[i].value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		if (exams==Exam && subj==scs)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options[i].text;
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
		var v1s1=DataComboSub.options[i].value;

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
			optns1.text=DataComboSub.options[i].text;
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
		var v1s1=DataComboSub.options[i].value;

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
			optns1.text=DataComboSub.options[i].text;
			optns1.value=subsec;
			SubSection.options.add(optns1);
		}
		else if(exams==Exam && subj==scs1 && ssec==scse1)
		{
			var optns1 = document.createElement("OPTION");
			optns1.text=DataComboSub.options[i].text;
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
			%><form name="aa" id="aa">
<center>
<input style="width:150px;font-size:15px; 
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ; background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden;"  name="twait1" readonly id="twait1" type="text" value="Please Wait.......">
</center>
</form>
		
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
				qry=" Select Exam, EXAMPERIODFROM ,EXAMPERIODTO,((TO_char(   EXAMPERIODTO, 'YYYYMMDD')) - (TO_char(examperiodfrom , 'YYYYMMDD')))  ddd  from (";
				qry+=" Select nvl(EXAMCODE,' ') Exam,  EXAMPERIODFROM ,EXAMPERIODTO,((TO_char(   EXAMPERIODTO, 'YYYYMMDD')) - (TO_char(examperiodfrom , 'YYYYMMDD')))  ddd  from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(LOCKEXAM,'N')='N' AND ";
            	      qry+=" nvl(Deactive,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
				qry+=" and examcode in (Select examcode from facultysubjecttagging where fstid in (select fstid from studentattendance))";
	                  //qry+=" and examcode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
      	            qry+="order by ddd DESC";
				qry+=") where rownum<15"; 
			//	out.print(qry);
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
				<Select Name=DataCombo id="DataCombo" style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
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
				<Select Name=DataCombo id="DataCombo" style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
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
				<select name=DataComboSec tabindex="0" id="DataComboSec" style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
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
				<select name=DataComboSec tabindex="0" id="DataComboSec" style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
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
				<select name=DataComboSub tabindex="0" id="DataComboSub" style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
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
				<select name=DataComboSub tabindex="0" id="DataComboSub" style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
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


%>

	
	<table border=1 bgcolor=#fce9c5  leftmargin=0 cellpadding=0 cellspacing=0 align=center>
<tr>

<td  valign=top >
	<table border=1 bgcolor=#fce9c5 class="sort-table" leftmargin=0 cellpadding=0 cellspacing=0 align=center>

	<thead>
	<tr  bgcolor="#ff8c00">
		<td rowspan=2 Title="Sort on SlNo" style="height:30px" >
				<font color="White" face="arial" size=2><b>Sr.<br>No.</b><br>&nbsp;</font>
		</td>
	</tr>
	</thead>
		<tbody>

		<%
int j=0;
			//out.print("Fac - "+QryFaculty+" Exam - "+mExam+" Subj - "+mSubject+" LTP - "+mLTP+" Sec - "+mSection+" SubSec - "+mSubsection+" DtFr - "+mDate1+" DtTo - "+mDate2);
			qry="select A.FSTID FSTID1, A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE SUBSEC, A.STUDENTID STID,  DECODE (a.enrollmentno,NULL,A.RANKNO,A.ENROLLMENTNO ) ENNO, A.STUDENTNAME STNM,A.LTP LTP,A.EXAMCODE EXAMCODE, nvl(A.SEMESTER,0) SEMESTER,NVL(a.SEMESTERTYPE,' ')SEMESTERTYPE";
				qry=qry+" , A.AcademicYear AcademicYear from V#STUDENTLTPDETAIL A where  NVL(A.DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' and A.examcode='"+mExam+"' and A.subjectid='"+mSubject+"' and A.LTP='"+mLTP+"'";
				qry=qry+" and ((A.employeeid='"+mDMemberID+"') OR (A.FSTID IN (SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mChkMemID+"')))";
				qry=qry+" and A.SECTIONBRANCH=decode('"+mSection+"','ALL',A.SECTIONBRANCH,'"+mSection+"') and A.SUBSECTIONCODE=decode('"+mSubsection+"','ALL',A.SUBSECTIONCODE,'"+mSubsection+"') AND a.institutecode ='"+mInst+"'   	order by A.ENROLLMENTNO";
				ResultSet rs12=db.getRowset(qry);
				
while(rs12.next())
		{		
	j++;
						if(j%2==0)
							TRCOLOR1="White";
						else
							TRCOLOR1="#F8F8F8";

				%>
				<tr  bgcolor="<%=TRCOLOR1%>" >
			<td  style="height:26px" >		
			<font size=2 face=arial> <%=j%> 
			</font>
			</td>
			</tr>
			
				<%
		}
		%>

	</tbody>
	</table>
	</td>

	<td>

			<table  bgcolor=#fce9c5 class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center >

			<!-- 
						<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center> -->
						<thead>
					<tr bgcolor="#ff8c00" style="height:30px" >
						
						<td rowspan=2  Title="Sort on Enrollment No"><font color="White"><b>Roll No.</b></font></td>
						<td rowspan=2  Title="Sort on Name"><font color="White"><b>Name</b></font></td>
						<td rowspan=2  Title="Sort on Section/Subsection"><font color="White"><b>Section / SubSection.</b></font></td>
					<td Colspan="3" Title="Student % Attendance" align="center" nowrap><font color="White"><b>% Attendance Till Today</b></font></td>
                    </tr>
                    <tr bgcolor="#ff8c00">
					<td rowspan=2 Align=left Title="Student Lecture % Attendance"><font color="White"><b><%=mLTP%> (%)</b></font></td>
						<%
					     qry = "Select DISTINCT A.LTP, DECODE(A.LTP,'L',1,'T',2,'P',3,4)LTPSEQ from facultysubjecttagging A where A.INSTITUTECODE='" + mInst + "' and A.EXAMCODE='" + QryExam + "' and A.SubjectID='" + QrySubj + "' and NVL(A.PROJECTSUBJECT,'N')='N' ORDER BY LTPSEQ";
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
				                        <td Align=center Title="Student Lecture And Tutorial % Attendance Cummulatively"><font color="White"><b>L+T  (%)</b></font></td>
				                        <%
							}
					      }
						%>
						</tr>
						</thead>
						<tbody>
		<%

			if((!mDate1.equals("") && gb.iSValidDate(mDate1)==true ||mDate1.equals("")) && (!mDate2.equals("") && gb.iSValidDate(mDate2)==true ||mDate2.equals("")))
			{	
		try
		{
				qry="select A.FSTID FSTID1, A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE SUBSEC, A.STUDENTID STID,  DECODE (a.enrollmentno,NULL,A.RANKNO,A.ENROLLMENTNO ) ENNO, A.STUDENTNAME STNM,A.LTP LTP,A.EXAMCODE EXAMCODE, nvl(A.SEMESTER,0) SEMESTER,NVL(a.SEMESTERTYPE,' ')SEMESTERTYPE";
				qry=qry+" , A.AcademicYear AcademicYear,A.ProgramCode ProgramCode from V#STUDENTLTPDETAIL A where  NVL(A.DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' and A.examcode='"+mExam+"' and A.subjectid='"+mSubject+"' and A.LTP='"+mLTP+"'";
				qry=qry+" and ((A.employeeid='"+mDMemberID+"') OR (A.FSTID IN (SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mChkMemID+"')))";
				qry=qry+" and A.SECTIONBRANCH=decode('"+mSection+"','ALL',A.SECTIONBRANCH,'"+mSection+"') and A.SUBSECTIONCODE=decode('"+mSubsection+"','ALL',A.SUBSECTIONCODE,'"+mSubsection+"') AND a.institutecode ='"+mInst+"'   	order by SUBSEC,A.ENROLLMENTNO";
				ResultSet rs11=db.getRowset(qry);
 //out.print(qry);
				
				while(rs11.next())
				{
					check=1;
					mREGCONFIRMATIONDATE="";
		 			qry=" Select nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE ,nvl(to_char(REGCONFIRMATIONDATE,'yyyymmdd'),' ') REGCONFIRMATIONDATE1 ,nvl(SPECIALAPPROVAL,'N')SPECIALAPPROVAL From StudentRegistration Where INSTITUTECODE='"+mInst+"'";
					qry=qry+" AND EXAMCODE='"+mExam+"'";
					//qry=qry+"   AND NVL(SEMESTERTYPE,' ')='REG'";
					qry=qry+" AND STUDENTID='"+rs11.getString("STID")+"'";					
					qry=qry+" AND ACADEMICYEAR='"+rs11.getString("ACADEMICYEAR")+"'";
					 //out.print(qry);
					rsBatchDate=db.getRowset(qry);
					 if(rsBatchDate.next())
					{
						
						mSpecialApproval=rsBatchDate.getString("SPECIALAPPROVAL");
							mREGCONFIRMATIONDATE1=rsBatchDate.getString("REGCONFIRMATIONDATE1");
						
						if(rsBatchDate.getString("REGCONFIRMATIONDATE")==null) 
							mREGCONFIRMATIONDATE="";
						else
							mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
					}
					else
					{
						mREGCONFIRMATIONDATE="";
					}
	
	
				if(!mStudentid.equals(rs11.getString("STID")))
				{		
					mStudentid=rs11.getString("STID");

					Ctr++;
					if(Ctr==1)
					{					
					
						
					}
					
					mRollno=rs11.getString("ENNO").toString().trim();
					mStName=rs11.getString("STNM").toString().trim();
					QryLTP=rs11.getString("LTP").toString().trim();
					QryStID=rs11.getString("STID").toString().trim();
					QrySecBr=rs11.getString("SECBR").toString().trim();
					QrySubSec=rs11.getString("SUBSEC").toString().trim();
					QryAcad=rs11.getString("AcademicYear").toString().trim();
QryProgramCode=rs11.getString("ProgramCode").toString().trim();	
					QrySemType=rs11.getString("SEMESTERTYPE").toString().trim();
					//out.println(QryLTP+"QryLTPQryLTP");
					%>
					<tr style="height:26px">				
					<td><%=mRollno%></td>
					<td nowrap><%=GlobalFunctions.toTtitleCase(mStName)%></td>
					<td><%=QrySecBr%>(<%=QrySubSec%>)</td>
					<%

		
String mLFSTID="";
String mTFSTID="";
String mPFSTID="";
String prevLFSTID="";
String prevTFSTID="";
String prevPFSTID="";
  mMemberID=QryStID;
String mINSTITUTECODE=mInst;

 QryExam=mExam;
long mNotAttendedAttendance=0;
int QrySem=rs11.getInt("SEMESTER");




//----------------------------------------  1314  B.T DUAL  JIIT J128------
int hghg=0,hhhhhhh=0;
if( (mINSTITUTECODE.equals("JIIT") || mINSTITUTECODE.equals("J128")) && (QryProgramCode.equals("B.T") || QryProgramCode.equals("DUAL"))
&& QryAcad.equals("1314")  
	&& 8==9)
					{

	hghg++;
				QrySem=1;
					//mREGCONFIRMATIONDATE="16-08-2013";
					//out.print("&**&*&*&**&*&*&*&*&8");
					}else if( (mINSTITUTECODE.equals("JPBS") ) && (QryProgramCode.equals("MBA") )
&& QryAcad.equals("1314")  
	&& 9==7)
					{

	hhhhhhh++;
				QrySem=1;
					//mREGCONFIRMATIONDATE="16-08-2013";
					//out.print("&**&*&*&**&*&*&*&*&8");
					}
					else
					{
						hghg=0;
				QrySem=QrySem;
				mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE;
					}




//----------------------------------------special case -----------------------------//

if(mSpecialApproval.equals("Y"))
	QrySem=1;
else
	QrySem=QrySem;

//----------------------------------------special case -----------------------------//

int mREGCONFIRMATIONDATE1int = Integer.parseInt(mREGCONFIRMATIONDATE1); 


if(QrySem==1 && mREGCONFIRMATIONDATE1int<=(20130816) && hghg>0 ){
	mREGCONFIRMATIONDATE="16-08-2013";
	//out.print(mREGCONFIRMATIONDATE1int+"20130816");

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int >(20130816)  && hghg>0  ){
	//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"****1111111111*******"+mREGCONFIRMATIONDATE+"    &nbsp;&nbsp;&nbsp;&nbsp;"); 
//	mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE+1;
 	
qrtyyy="select to_char(to_date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')+1,'dd-mm-yyyy')Regdate from dual";
rsyyyy=db.getRowset(qrtyyy);
if(rsyyyy.next()){
mREGCONFIRMATIONDATE=rsyyyy.getString("Regdate");
//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"*****22222222222******"+mREGCONFIRMATIONDATE);
}

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int<=(20130630) && hhhhhhh>0  ){
	mREGCONFIRMATIONDATE="30-06-2013";
	//out.print(mREGCONFIRMATIONDATE1int+"20130816");

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int >(20130630) && hhhhhhh>0  ){
	//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"****1111111111*******"+mREGCONFIRMATIONDATE+"    &nbsp;&nbsp;&nbsp;&nbsp;"); 
//	mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE+1;
 	
qrtyyy="select to_char(to_date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')+1,'dd-mm-yyyy')Regdate from dual";
rsyyyy=db.getRowset(qrtyyy);
if(rsyyyy.next()){
mREGCONFIRMATIONDATE=rsyyyy.getString("Regdate");
//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"*****22222222222******"+mREGCONFIRMATIONDATE);
}

}else{

mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE;
///out.print(mREGCONFIRMATIONDATE1int+"20130816"+"################");
}
//----------------------------------------special case -----------------------------//

					
					
if(flag1==true)
{
			
qry1="select  LTP,fstid from V#StudentLTPDetail a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' and a.LTP in('L','T') group by LTP,fstid";
 
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		if(rs1.getString("LTP").equals("L"))			
			mLFSTID=rs1.getString("fstid");			
		if(rs1.getString("LTP").equals("T"))
			mTFSTID=rs1.getString("fstid");	
		
		}



	qry1="select  LTP, fstid from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' and a.LTP in('L','T')  group by LTP,fstid ";

//out.print(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		if(rs1.getString("LTP").equals("L"))
				prevLFSTID=rs1.getString("fstid");	
		if(rs1.getString("LTP").equals("T"))
				prevTFSTID=rs1.getString("fstid");	
		
		}


// Process for L Type
mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select distinct  CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='L' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mLFSTID+"'   OR (A.FSTID  IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='L' and b.FSTID='"+mLFSTID+"')))  ";
qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) >=trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  nvl((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'  and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')))) ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )   ";
qry=qry+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   )";
//out.print(qry);
//if(mMemberID.equals("J1281100708"))
//	out.print(qry);
rs1=db.getRowset(qry);
  
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
			
		}

if(!prevLFSTID.equals(""))
	{
qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSubject+"'  and LTP='L' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevLFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubject+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='L' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevLFSTID+"' ) ";
qry=qry+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
					qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";     

//if(mMemberID.equals("J1281100708"))
 //	out.print(qry);
rs1=db.getRowset(qry);

while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}
	}
 
qry1="SELECT   count(pcount ) pcount FROM (select distinct  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.ltp='L' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1)  )  ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select   distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE a where  subjectid ='"+mSubject+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1)  )  ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   )";
//if(mMemberID.equals("J1281100708"))
	//out.print(qry1);

 

rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mL=rs1.getLong("pcount");
			
		}
mL=mL+mNotAttendedAttendance;

qry1="SELECT   count(pcount ) pcount FROM (select distinct   CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND   a.ltp='L' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE a where  subjectid ='"+mSubject+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   )";
//if(mMemberID.equals("J1281100708"))
 //out.print(qry1);
rs1=db.getRowset(qry1);

while(rs1.next())
		{
		mLP=rs1.getLong("pcount");
			
		}




//-- For T

mNotAttendedAttendance=0;

if(!mTFSTID.equals(""))
	{

qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select  distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='T' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mTFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='T' and b.FSTID='"+mTFSTID+"')))  ";                           
qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";

 qry=qry+" and trunc(a.classtimefrom)<  nvl((                   SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='T' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
 qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )   ";
qry=qry+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   )";

rs1=db.getRowset(qry);

 //out.print(qry);
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
		//out.print("mNotAttendedAttendance  First"+mNotAttendedAttendance);		
		}
	}

if(!prevTFSTID.equals(""))
	{
 qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSubject+"'  and LTP='T' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevTFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='T' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubject+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='T' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevTFSTID+"' )  ";
qry=qry+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
										qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";     

//					out.print(qry);
rs1=db.getRowset(qry);

while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
		}
	}

qry1="SELECT   count(pcount ) pcount FROM (select  distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.ltp='T' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select distinct   CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE a where  subjectid ='"+mSubject+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   )";

//out.print(qry1);
rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mT=rs1.getLong("pcount");
		//out.print("MT"+mT);
			
		}
mT=mT+mNotAttendedAttendance;

qry1="SELECT   count(pcount ) pcount FROM (select distinct  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' and a.ltp='T' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE  a where  subjectid ='"+mSubject+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   )";
 //out.print(qry1);
rs1=db.getRowset(qry1);
  
while(rs1.next())
		{
		mTP=rs1.getLong("pcount");
			
		}

if(mL>0 )
	{
mPercL=Math.ceil(((mLP*100)/mL));
mPercLT=Math.ceil(((mLP+mTP)*100)/(mL+mT));

	}
	if(mT>0)
	{
mPercT=Math.ceil((mTP*100)/mT);
mPercLT=Math.ceil(((mLP+mTP)*100)/(mL+mT));

	}

if(QryLTP.equals("L"))
{
		
		

			//out.print(mPercLT+"sdff");
		%>
	
	
	<td align=left><a Title="View Date wise Lecture Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=mSubject%>&amp;LTP=L&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>&amp;mMemberID=<%=mMemberID%>&amp;prevLFSTID=<%=prevLFSTID%>&amp;mLFSTID=<%=mLFSTID%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>'><font color=blue><b><%=mPercL%></a>%</font></td>
<%
		
}
else if(QryLTP.equals("T"))
{
		
		
		%>
		 <td align=left>&nbsp;<a Title="View Date wise Tutorial Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=mSubject%>&amp;LTP=T&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>&amp;mMemberID=<%=mMemberID%>&amp;prevTFSTID=<%=prevTFSTID%>&amp;mTFSTID=<%=mTFSTID%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>'><font color=blue><b><%=mPercT%></b> %</a></td> 

		
		<%
		
}
%>
<td align=left>&nbsp;<a Title="View Date wise Lecture + Tutorial Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=mSubject%>&amp;LTP=LT&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>&amp;mMemberID=<%=mMemberID%>&amp;prevTFSTID=<%=prevTFSTID%>&amp;prevLFSTID=<%=prevLFSTID%>&amp;mLFSTID=<%=mLFSTID%>&amp;mTFSTID=<%=mTFSTID%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>'><font color=blue><b><%=mPercLT%></b> %</a></td>
<%

}
else
					{
	
		qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='"+QryLTP+"' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mPFSTID=rs1.getString("fstid");			
		}

			qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='"+QryLTP+"' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevPFSTID=rs1.getString("fstid");			
		}



//		For P

mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select distinct  CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='"+QryLTP+"' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mPFSTID+"'   OR ( A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='"+QryLTP+"' and b.FSTID='"+mPFSTID+"')))  ";                            
qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) > trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";

 qry=qry+" and trunc(a.classtimefrom)<  nvl((                   SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='"+QryLTP+"' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
 qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='"+QryLTP+"' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";

qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )     ";
qry=qry+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   )";
rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
			
		}




if(!prevPFSTID.equals(""))
	{
 qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSubject+"'  and LTP='"+QryLTP+"' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevPFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='"+QryLTP+"' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubject+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='"+QryLTP+"' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevPFSTID+"' )  ";
qry=qry+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
//out.print(qry);
rs1=db.getRowset(qry);

//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}
	}

qry1="SELECT   count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' and a.ltp='"+QryLTP+"' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE a where  subjectid ='"+mSubject+"'     AND ltp ='"+QryLTP+"'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' ";  
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))  ) ";
 //out.print(qry1);


rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mP=rs1.getLong("pcount");
			
		}

		//out.print(mNotAttendedAttendance+"***"+mP+"-");
mP=mP+mNotAttendedAttendance;

qry1="SELECT   count(pcount ) pcount FROM (select  distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  and a.ltp='"+QryLTP+"' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE a where  subjectid ='"+mSubject+"'     AND ltp ='"+QryLTP+"'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  " ;       
qry1=qry1+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
					qry1=qry1+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))  ) ";
//out.print(qry1);
rs1=db.getRowset(qry1);

while(rs1.next())
		{
		mPP=rs1.getLong("pcount");
			
		}
if(mP>0)
{

	//out.print(mPP+"-"+mP);
	mPercP=Math.ceil((mPP*100)/mP);
		
		if(QryLTP.equals("P"))
		{
		%>
		<td align=left><a Title="View Date wise Practical Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=mSubject%>&amp;LTP=P&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>&amp;mMemberID=<%=mMemberID%>&amp;prevPFSTID=<%=prevPFSTID%>&amp;mPFSTID=<%=mPFSTID%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>'><font color=blue><b><%=mPercP%></b></a>%</td>
		<%
		}
		else if(QryLTP.equals("L"))
		{
			%>
		 <td align=left>&nbsp;<a Title="View Date wise Lecture Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=mSubject%>&amp;LTP=L&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>&amp;mMemberID=<%=mMemberID%>&amp;prevLFSTID=<%=prevPFSTID%>&amp;mLFSTID=<%=mPFSTID%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>'><font color=blue><b><%=mPercP%></b> </font></a></td>
			<%
		}
		
}
					}



mL=0;
mT=0;
mP=0;
mLP=0;
mTP=0;
mPP=0;			
				
					
					
				%>
				</tr>
				<%          						
			}
				}
				
				

			}// closing of time 
			
			
catch(Exception e)
{
	 out.print("error"+e);	
}
}// closing of time 
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid time format. </font> <br><br>");
			}
			%>
			</tbody>
			</table>
			<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString", "Number", "Number"]);
			</script>

			

<td></tr>


</table>



			<%

				if (check==0)
				{
					out.print("&nbsp;&nbsp;&nbsp<center> <b><font size=3 face='Arial' color='Red'>No Record Found ! </font></center>");
				}
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