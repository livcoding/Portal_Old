<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null, rs1=null, rs2=null;
ResultSet RsChk1=null, rsdt=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="", mLTP="";
long dt=0;
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String mMemberName="";
String mInstitute="",mtime1="",mtime2="";
String mExam="",mSubject="",mexam="",mSubj="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="";
String mSExam="", mSES="";
String qryexam="",qrysubj="",qrysec="";
String qsysdate="";
String mDate="",mType="",mltp1="";
String mRollno="",mName="",mradio1="";
String mDTfrom="", mDTupto="";
int Ctr=0, mDiffInDate=0;
String mtimepicker1="", mtimepicker2="";
String mInst="", mComp="";
String mPresent="";


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

mInstitute=mInst;

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


String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Edit Students Class Attendance ] </TITLE>

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
<script language="JavaScript" type ="text/javascript">
   function rad_check()
   { 
	
	var p=0;
	var a=0;

	for (var i = 0; i < document.frm1.elements.length; i++) 
	{
        var e=document.frm1.elements[i]; 
        if ((e.name != 'allbox') && (e.type == 'radio') && (e.value=='P') && (e.checked==true)  ) 
	  { 
		p++;	
        }
       else if((e.name != 'allbox1') && (e.type == 'radio') && (e.value=='A') && (e.checked==true)) 
        {
 		a++;
	  }	
      }
   if(p>0 && a>0)	
   {
	document.frm1.allbox.checked=false;
	document.frm1.allbox1.checked=false;
   }
   else if(p>0 && a<=0)
   {
	document.frm1.allbox.checked=true;
	document.frm1.allbox1.checked=false;
   }
   else if (a>0 && p<=0)
   {
	document.frm1.allbox.checked=false;
	document.frm1.allbox1.checked=true;
   }				
   else if(a<=0 && p<=0)
  {
	document.frm1.allbox.checked=false;
	document.frm1.allbox1.checked=false;
   }		
 }
</script>
<script type="text/javascript" src="js/TimePicker.js"></script>
<SCRIPT LANGUAGE="JavaScript"> 
 function un_check()
{
var mFlag=0;
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'allbox') && (e.type == 'radio') &&(e.value=='P')) 
{ 
e.checked = document.frm1.allbox.checked;
if (mFlag==0 && document.frm1.allbox.checked==true)
	{ 
	document.frm1.allbox1.checked=false;
	mFlag=1;
	}
 } } }
 </SCRIPT>

<SCRIPT LANGUAGE="JavaScript"> 
function un_check1()
{
	var mFlag=0;
	 for (var i = 0; i < document.frm1.elements.length; i++) 
     {
	 var e = document.frm1.elements[i]; 
	if ((e.name != 'allbox1') && (e.type == 'radio') &&(e.value=='A')) 
	{ 
	e.checked = document.frm1.allbox1.checked;
 	}

	if (mFlag==0 && document.frm1.allbox1.checked==true)
	{ 
	document.frm1.allbox.checked=false;
	mFlag=1;
	}

    }
}


function un_check2()
	{
	var mFlag=0;
	 for (var i = 0; i < document.frm1.elements.length; i++) 
     {
	 var e = document.frm1.elements[i]; 
	if ((e.name != 'allbox2') && (e.type == 'radio') &&(e.value=='L')) 
	{ 
	e.checked = document.frm1.allbox2.checked;
 	}

	if (mFlag==0 && document.frm1.allbox2.checked==true)
	{ 
	document.frm1.allbox1.checked=false;
	document.frm1.allbox.checked=false;
	mFlag=1;
	}
    }
    }
 </SCRIPT>
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
<body aLink=#ff00ff bgcolor="" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onload="return rad_check();">
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	OLTEncryption enc=new OLTEncryption();
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
		
		qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";

		rs=db.getRowset(qry);

		if(rs.next())
			qsysdate=rs.getString(1);
		else
			qsysdate="";	

	if (request.getParameter("x")!=null)
	{
		mDate=request.getParameter("qsysdate").toString().trim();
	}
	else
	{
		mDate=qsysdate;
	}
  //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table align=center><font color="#008AB8" style="FONT-SIZE: medium; FONT-FAMILY: arial">Edit Today's or Previous Day's Class Attendance</font></TABLE>
<table id=id2 cellpadding=1 cellspacing=1 width="90%" align=center rules=groups border=2>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<tr><td nowrap colspan=2>
<FONT color=black face=Arial size=2><b>&nbsp;Exam Code</b>
<%
try
  { 	

	qry="SELECT Exam from(";
	qry=qry+" Select nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where InstituteCode='"+mInst+"' AND ";
	qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
//-----
	//qry=qry+" and examcode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where InstituteCode='"+mInst+"' And CompanyCode='"+mLoginComp+"')";
//-----
//--OR--
//-----
	qry=qry+" and (examcode in (select ExamCode from facultysubjecttagging where employeeid='"+mDMemberID+"' AND  fstid in (select fstid from studentltpdetail))";
	qry=qry+" OR examcode in (select ExamCode from MultiFacultysubjecttagging where employeeid='"+mDMemberID+"' AND  fstid in (select fstid from studentltpdetail)))";
//-----
	qry=qry+" order by EXAMPERIODFROM DESC)";
	qry=qry+" WHERE ROWNUM<=5";
//out.print(qry);
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 110px" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mexam.equals(""))
 			{
			mexam=mExam;
			qryexam=mExam;
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
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 110px" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				qryexam=mExam;
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
 <b>  &nbsp; Attendance Date&nbsp;</b><input type='text' name='qsysdate' id='qsysdate' value=<%=mDate%> style="width=70px" MAXLENGTH=10>&nbsp;  
 
<!-- <input type='text' name='ClassFrom' id='ClassFrom' style="width=50px"><b> To</B>  <input type='text' name='ClassUpto' id='ClassUpto' style="width=50px">-->  

<%
if(request.getParameter("radio1")==null)
			{
			%>
<b> &nbsp; Attendance Type</b> &nbsp;<input type=radio name=radio1 id=radio1  value='R' checked><b><font color= green>Regular</font></b> 
<input type=radio name=radio1 id=radio1 value='E'><b><font color=brown>Extra</font></b>
			<%
			}
			else
			{
				mradio1=request.getParameter("radio1").toString().trim();
				if(mradio1.equals("R"))
				{
			%>
	<b>Attendance Type</b> &nbsp;<input type=radio name=radio1 id=radio1  value='R' checked><b><font color= green>Regular</font></b> 
<input type=radio name=radio1 id=radio1 value='E'><b><font color=brown>Extra</font></b>

			<%
				}
				else
				{
			%>
	<b>Attendance Type</b> &nbsp;<input type=radio name=radio1 id=radio1  value='R' ><b><font color= green>Regular</font></b> 
<input type=radio name=radio1 id=radio1 value='E' checked><b><font color=brown>Extra</font></b>

			<%
				}
			}	
%>
</td>
<!--*********Exam**********-->
<!--******************DataCombo**************-->
<%
try														
{     
qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from facultysubjecttagging A,SUBJECTMASTER B";
qry=qry+" where a.employeeid='"+mDMemberID+"'";
qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='"+mInst+"' and ";
qry=qry+" Nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE ";
qry=qry+" union ";
qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from facultysubjecttagging A,SUBJECTMASTER B";
qry=qry+" where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')";
qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='"+mInst+"' and ";
qry=qry+" Nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE ";
qry=qry+" union ";
qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"' ) AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE ";
qry=qry+" order by subject ";
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
</tr><tr><td nowrap colspan=2>
<FONT color=black face=Arial size=2><b>&nbsp;Subject</b>&nbsp;  </FONT>
<%	
	qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from facultysubjecttagging A, SUBJECTMASTER B";
	qry=qry+" where a.employeeid='"+mDMemberID+"'";
	qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"' and A.EXAMCODE='"+qryexam+"' AND  A.INSTITUTECODE=B.INSTITUTECODE " ;
	qry=qry+" union ";
	qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from facultysubjecttagging A, SUBJECTMASTER B";
	qry=qry+" where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')";
	qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"' and A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+"  AND A.INSTITUTECODE=B.INSTITUTECODE union ";
	qry=qry+" Select  nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"' )AND A.SUBJECTID=B.SUBJECTID   AND A.INSTITUTECODE=B.INSTITUTECODE and B.InstituteCode='"+mInst+"' ";
	qry=qry+" and A.EXAMCODE='"+qryexam+"' order by subject";
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
			qrysubj=mSubj1;
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
			qrysubj=mSubj1;
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
	qry="Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and A.fstid not in (select fstid from  ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') ";//and  A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+" union ";
	qry=qry+" Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where A.employeeid='"+mDMemberID+"' and A.fstid not in (select fstid from  ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') ";//and A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+" union ";
	qry=qry+" Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc ,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where A.fstid in (select fstid from ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"') ";//and A.EXAMCODE='"+qryexam+"' ";
	qry=qry+" ORDER BY orderltp ";

	rs=db.getRowset(qry);

//	out.print(qry);

%>
	<select name=LTP tabindex="0" id="LTP" style="WIDTH: 90px" >	
<% 
if (request.getParameter("x")==null) 
{
	while(rs.next())
	{
		mltp1=rs.getString("LTP");
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
<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Section</STRONG>&nbsp;</FONT></FONT>
<%
try
{ 
	qry1="select 'ALL' section from dual union all";
	qry1=qry1+" select nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where facultytype=decode('"+mDMemberType+"','E','I','E')";
	qry1=qry1+" and employeeid='"+mDMemberID+"' and institutecode='"+mInst+"' and";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"' Group By nvl(SECTIONBRANCH,' ')";
	qry1=qry1+" UNION";
	qry1=qry1+" select nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where ";
	qry1=qry1+" fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"' and institutecode='"+mInst+"' Group By nvl(SECTIONBRANCH,' ') order by Section";
	
	//out.print(qry1);

	rs1=db.getRowset(qry1);

	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Section tabindex="0" id="Section" style="WIDTH: 90px" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">	
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("Section");
			
			qrysec=mSubj;
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
		<select name=Section  tabindex="0" id="Section" style="WIDTH: 90px" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">	
		<%
		while(rs1.next())
		{
			mSubj=rs1.getString("Section");
			if(mSubj.equals(request.getParameter("Section").toString().trim()))
 			{
				qrysec=mSubj;
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
	qry1=qry1+" UNION";
	qry1=qry1+" select nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging where  ";
	qry1=qry1+" fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and ";
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
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"'";
	qry1=qry1+" and sectionbranch=decode('"+qrysec+"','ALL',sectionbranch,'"+qrysec+"') ";
	qry1=qry1+" and institutecode='"+mInst+"' Group By SUBSECTIONCODE";
	qry1=qry1+" UNION";
	qry1=qry1+" Select SUBSECTIONCODE SubSection from  facultysubjecttagging where  ";
	qry1=qry1+" fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and	 NVL(DEACTIVE,'N')='Y' )  ";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"'";
	qry1=qry1+" and sectionbranch=decode('"+qrysec+"','ALL',sectionbranch,'"+qrysec+"') ";
	qry1=qry1+" and institutecode='"+mInst+"' Group By SUBSECTIONCODE order by SubSection ";
//	out.print(qry1);
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{		
		%>
		<select name=SubSection tabindex="0" id="SubSection" style="WIDTH: 90px">	
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
		<select name=SubSection tabindex="0" id="SubSection" style="WIDTH: 90px">	
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
	qry1="Select  SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ') subjectid from  facultysubjecttagging where employeeid='"+mDMemberID+"' ";
	qry1=qry1+" and facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where InstituteCode='"+mInst+"' And ( nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' ) )";
	qry1=qry1+" Group By SUBSECTIONCODE,nvl(SECTIONBRANCH,' '),nvl(Examcode,' ') ,nvl(subjectid,' ')  ";
	qry1=qry1+" UNION Select SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ') subjectid from  facultysubjecttagging where      ";
	qry1=qry1+" fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where  institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where InstituteCode='"+mInst+"' And ( nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' ) ) Group By SUBSECTIONCODE,nvl(SECTIONBRANCH,' '),nvl(Examcode,' ') ,nvl(subjectid,' ') ";
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
</td></tr>
<%
if(request.getParameter("timepicker1")==null)
mtimepicker1="12:00 pm" ;
else
mtimepicker1=request.getParameter("timepicker1");	

if(request.getParameter("timepicker2")==null)
mtimepicker2="08:00 pm" ;
else
mtimepicker2=request.getParameter("timepicker2");	

%>
<tr><td colspan=2 nowrap><FONT face=Arial size=2>
<b>&nbsp;Class Period</b>
<input id='timepicker1' name='timepicker1' type='text' value='<%=mtimepicker1%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepicker1)" STYLE="cursor:hand">
&nbsp;&nbsp;<STRONG><FONT color=black face=Arial size=2>&nbsp;  To &nbsp; </FONT></STRONG>
<input id='timepicker2' name='timepicker2' type='text' value='<%=mtimepicker2%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepicker2)" STYLE="cursor:hand">
&nbsp; &nbsp; <INPUT Type="submit" Value="Show/Refresh">
</td></tr>
	</table>
	</form>
	<form name="frm1"  method="post" action="DailyStudentAttendanceEditActionbfgi.jsp"> 
	<table bgcolor="" class="sort-table" id="table-1" width='90%' bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
	<thead>
	<tr bgcolor="#008AB8">
	<td Title="Sort on SlNo"><font color="White"><b>SNo.</b></font></td>
	<td Title="Sort on Enrollment No"><font color="White"><b>Roll No.</b></font></td>
	<td Title="Sort on Name [CaseInsensitive]"><font color="White"><b>Name</b></font></td>
	<td Title="Sort on Registration Date"><font color="White"><b>Sec/SubSec.</b></font></td>
	<td><font color="Green"><input onClick="un_check()"  type="checkbox" id='allbox' name='allbox' value='P' checked>&nbsp;<b>Present</b></font></td>
	<td><font color="darkbrown"><input onClick="un_check1()"  type="checkbox" id='allbox1' name='allbox1' value='A'>&nbsp;<b>Absent</b></font></td> 
	<td rowspan=2><font color="darkblue"><input onClick="un_check2()"  type="checkbox" id='allbox2' name='allbox2' value='A'>&nbsp;<b>Leave</b></font></td> 
	</tr>
	</thead>
	<tbody>
<%	
	if(request.getParameter("x")!=null)
	{


	if (request.getParameter("qsysdate")!=null)
			mDate=request.getParameter("qsysdate").toString().trim();
		else
			mDate="";

		mtime1=request.getParameter("timepicker1").toString().trim().toUpperCase();
		mtime2=request.getParameter("timepicker2").toString().trim().toUpperCase();



	qry="select nvl(to_date('"+qsysdate+"','DD-MM-YYYY')-to_date('"+mDate+"','DD-MM-YYYY'),0) DiffInDate from dual";
	rs2=db.getRowset(qry);
	//out.print(qry);
	if(rs2.next())
		mDiffInDate = rs2.getInt("DiffInDate");
	if(mDiffInDate>=0)
	{
		if (GlobalFunctions.iSValidDate(mDate)==true)
		{	
			qry="Select WEBKIOSK.IsValidTimeFormat('"+mtime1+"')SL,WEBKIOSK.IsValidTimeFormat('"+mtime2+"')SL1 from dual";
			RsChk1= db.getRowset(qry);
			if (RsChk1.next() && RsChk1.getString("SL").equals("Y") && RsChk1.getString("SL1").equals("Y"))
			{
				mExam=request.getParameter("Exam").toString().trim();

				mSubject=request.getParameter("Subject").toString().trim();

				mLTP=request.getParameter("LTP").toString().trim();
				mSection=request.getParameter("Section").toString().trim();	

				mSubsection=request.getParameter("SubSection").toString().trim();	

				mType=request.getParameter("radio1").toString().trim();			

				mDTfrom= mDate+" "+request.getParameter("timepicker1").toString().trim().toUpperCase();
				mDTupto= mDate+" "+request.getParameter("timepicker2").toString().trim().toUpperCase();

				qry=" SELECT TO_CHAR(TO_DATE('"+mDTupto+"','DD-MM-YYYY HH:MI PM'),'YYYYMMDDHH24MI') ";
				qry=qry+" - TO_CHAR(TO_DATE('"+mDTfrom+"','DD-MM-YYYY HH:MI PM'),'YYYYMMDDHH24MI') ";
				qry=qry+" from dual ";	
				rsdt=db.getRowset(qry);
				rsdt.next();
				dt=rsdt.getLong(1);
				if(dt>0)
				{	
					qry="select  nvl(A.EMPLOYEEID,' ')employeeid,nvl(A.FSTID,' ')fstid,nvl(A.enrollmentno,' ')enrollmentno,nvl(A.studentname,' ')studentname, NVL(A.studentid,' ')studentid,";
					qry=qry+" NVL(A.SECTIONBRANCH,' ')|| '('||A.SUBSECTIONCODE||')' sectionbranch ,nvl(to_char(B.REGCONFIRMATIONDATE,'dd-mm-yy'),' ') REGCONFIRMATIONDATE ,nvl(B.REGCONFIRMATION,'N')REGCONFIRMATION, ";
					qry=qry+" A.SUBSECTIONCODE, C.SemesterType,C.LTP LTP ,nvl(C.SLNO,-1) SLNO ";
					qry=qry+" from V#STUDENTLTPDETAIL A,STUDENTREGISTRATION B, SUBJECTWISESLNO C "; 
					//qry=qry+" where C.COMPANYCODE=A.COMPANYCODE ";
					//qry=qry+" AND C.INSTITUTECODE = A.INSTITUTECODE";
					qry=qry+" Where C.INSTITUTECODE = A.INSTITUTECODE";
				qry=qry+" AND NVL(a.studentdeactive,'N')='N' AND NVL(a.deactive,'N')='N' ";
					qry=qry+" AND C.EXAMCODE=A.EXAMCODE";
					qry=qry+" AND C.studentid=A.studentid";
					qry=qry+" AND C.INSTITUTECODE= A.INSTITUTECODE";
					qry=qry+" AND C.EXAMCODE=A.EXAMCODE";
					qry=qry+" AND C.ACADEMICYEAR=A.ACADEMICYEAR ";
					qry=qry+" AND C.PROGRAMCODE=A.PROGRAMCODE ";
					qry=qry+" AND C.TAGGINGFOR=A.TAGGINGFOR ";
					qry=qry+" AND C.SECTIONBRANCH=A.SECTIONBRANCH ";
					qry=qry+" AND C.SUBSECTIONCODE=A.SUBSECTIONCODE ";
					qry=qry+" AND C.SUBJECTID=A.SUBJECTID ";
					qry=qry+" AND C.LTP=A.LTP ";
					//qry=qry+" AND C.COMPANYCODE=B.COMPANYCODE";
					qry=qry+" AND C.INSTITUTECODE=B.INSTITUTECODE";
					qry=qry+" AND C.EXAMCODE=B.EXAMCODE";
					qry=qry+" AND C.REGCODE=B.REGCODE";
					qry=qry+" AND C.STUDENTID=B.STUDENTID";
					qry=qry+" AND C.studentid=A.studentid";
					qry=qry+" AND B.INSTITUTECODE=A.INSTITUTECODE";
					//qry=qry+" AND B.COMPANYCODE=A.COMPANYCODE";
					qry=qry+" AND B.EXAMCODE=A.EXAMCODE";
					qry=qry+" AND B.ACADEMICYEAR=A.ACADEMICYEAR";
					qry=qry+" AND B.STUDENTID=A.STUDENTID";
//qry=qry+" and ( A.EMPLOYEEID in (select '"+mDMemberID+"' from Dual ";
//qry=qry+" where not exists (select 'y' from STUDATTENDANCEBYSPECIALFACULTY ssf Where ";
//------------OR-------------
qry=qry+" and (A.EMPLOYEEID in (select employeeid from facultysubjecttagging where employeeid='"+mDMemberID+"' OR (fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and fstid in (select fstid from facultysubjecttagging where examcode='"+mExam+"' and subjectid='"+mSubject+"' and LTP in ('"+mLTP+"'))))";
qry=qry+" and not exists (select 'y' from STUDATTENDANCEBYSPECIALFACULTY ssf Where ";
					qry=qry+" trunc(sysdate)=trunc(sSF.attendancedate) and nvl(sSF.deactive,'N')='N' and A.fstid=ssf.fstid))";
					qry=qry+" or A.EMPLOYEEID in (Select sf.FACULTYID from  STUDATTENDANCEBYSPECIALFACULTY SF ";
					qry=qry+" where trunc(sysdate)=trunc(SF.attendancedate) and nvl(SF.deactive,'N')='N' and A.fstid=sf.fstid)";
					qry=qry+" )"; 
					qry=qry+" and A.SUBJECTID='"+mSubject+"'";
					qry=qry+" and A.LTP in ('"+mLTP+"')";
					qry=qry+" and A.ExamCode='"+mExam+"'";
					qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"') ";
					qry=qry+" and A.sectionbranch=decode('"+mSection+"','ALL',A.sectionbranch,'"+mSection+"') "; 	

					if (mType.equals("R"))
					{
						qry=qry+" And FSTID in (Select  FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"' and ATTENDANCETYPE='R' )";
					}
					
					else
					{
						qry=qry+" And FSTID in (Select FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"' and ATTENDANCETYPE='E' ";
						qry=qry+" And ( to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
						qry=qry+" or  to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO))";
					}
					

					qry=qry+" And FSTID in (Select FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"'";
					qry=qry+" And ( to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
					qry=qry+" or  to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO))";

					qry=qry+" And FSTID not in (Select FSTID from STUDENTATTENDANCEEXCUSED where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"'";
					qry=qry+" And ( to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
					qry=qry+" or  to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO))";
					qry=qry+" order by SLNO";
					//out.print(qry);
					rs1=db.getRowset(qry);
					while(rs1.next())
					{
						Ctr++;
						mRollno=rs1.getString("enrollmentno").toString().trim();
						mName=rs1.getString("studentname").toString().trim();
						mName1="Present"+String.valueOf(Ctr).trim(); 	
						mName2="Absent"+String.valueOf(Ctr).trim(); 	
						mName3="Fstid"+String.valueOf(Ctr).trim();
						mName4="StudID"+String.valueOf(Ctr).trim();
						mName5="Employeeid"+String.valueOf(Ctr).trim();
						mName6="Enrollment"+String.valueOf(Ctr).trim();
						mName7="SNo"+String.valueOf(Ctr).trim();
						%>
						<tr>
						<td><%=rs1.getLong("SLNO")%>.</td>
						<td><%=mRollno%></td>
						<td nowrap><%=GlobalFunctions.toTtitleCase(mName)%></td>
						<!-- <td><%=rs1.getString("sectionbranch")%>/<%=rs1.getString("subsectioncode")%></td> -->
						<td><%=rs1.getString("sectionbranch")%></td>
						<%
						qry="SELECT nvl(PRESENT,'N')PRESENT FROM STUDENTATTENDANCE WHERE to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"'";
						qry=qry+" And ( to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
						qry=qry+" or  to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO)";
						qry=qry+" AND STUDENTID='"+rs1.getString("STUDENTID")+"' AND FSTID='"+rs1.getString("FSTID")+"'";
						//out.print(qry);
						rs2=db.getRowset(qry);
						if(rs2.next())
							mPresent=rs2.getString("PRESENT");
						if(mPresent.equals("Y"))
						{
							%>
							<td><input type='radio' value='P' ID='<%=mName1%>' Name='<%=mName1%>' checked onclick="return rad_check();"><font color=green>&nbsp;<b>P</b></font></td>
							<td><input type='radio' value='A' ID='<%=mName1%>' Name='<%=mName1%>' onclick="return rad_check();"><font color=red>&nbsp;<b>A</b></font></td>
							<td><input type='radio' value='L' ID='<%=mName1%>' Name='<%=mName1%>' onclick="return rad_check();"><font color=darkblue>&nbsp;<b>L</b></font></td>
							<%
						}
						else if(mPresent.equals("N"))
						{
							%>
							<td><input type='radio' value='P' ID='<%=mName1%>' Name='<%=mName1%>' onclick="return rad_check();"><font color=green>&nbsp;<b>P</b></font></td>
							<td><input type='radio' value='A' ID='<%=mName1%>' Name='<%=mName1%>' checked onclick="return rad_check();"><font color=red>&nbsp;<b>A</b></font></td>
							<td><input type='radio' value='L' ID='<%=mName1%>' Name='<%=mName1%>' onclick="return rad_check();"><font color=darkblue>&nbsp;<b>L</b></font></td>
							<%
						}
						else
						{
							%>
							<td><input type='radio' value='P' ID='<%=mName1%>' Name='<%=mName1%>' onclick="return rad_check();"><font color=green>&nbsp;<b>P</b></font></td>
							<td><input type='radio' value='A' ID='<%=mName1%>' Name='<%=mName1%>'  onclick="return rad_check();"><font color=red>&nbsp;<b>A</b></font></td>
							<td><input type='radio' checked value='L' ID='<%=mName1%>' Name='<%=mName1%>' onclick="return rad_check();"><font color=darkblue>&nbsp;<b>L</b></font></td>
							<%
						}
								
						%>
						</tr>
						<input type=hidden name=<%=mName3%> ID=<%=mName3%> value='<%=rs1.getString("Fstid")%>'>
						<input type=hidden name=<%=mName4%> ID=<%=mName4%> value='<%=rs1.getString("studentid")%>'>
						<input type=hidden name=<%=mName5%> ID=<%=mName5%> value='<%=rs1.getString("employeeid")%>'>
						<input type=hidden name=<%=mName6%> ID=<%=mName6%> value='<%=mRollno%>'>
						<input type=hidden name=<%=mName7%> ID=<%=mName7%> value='<%=rs1.getLong("SLNO")%>'>
						<%          						
					}
				}// closing of time 
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid time format. </font> <br><br>");
				}
			}
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid time format. </font> <br><br>");	
			}
		} // closing of Global Validate
		else
		{
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Valid Date Format is DD-MM-YYYY only error in time</font> <br><br>");
	     }
	} // Date Checking if it exceeds beyond the sysdate
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print("&nbsp; <b><font size=3 face='Arial' color='Red'> Sorry ! &nbsp; Future Date Attendance is not allowed...</font> <br><br>");
	}
	%>	
	<td><Input Type=hidden name=INSTITUTE ID=INSTITUTE Value='<%=mInstitute%>'></td>
	<td><input type=hidden name=ADATE ID=ADATE value='<%=mDate%>'></td>
	<td><input type=hidden name=ATYPE ID=ATYPE value='<%=mType%>'></td>
	<td><input type=hidden name=TotalRec ID=TotalRec value='<%=Ctr%>'></td>
	<td><input type=hidden name=Timefrom ID=Timefrom value='<%=mDTfrom%>'></td>
	<td><input type=hidden name=Timeupto ID=Timeupto value='<%=mDTupto%>'></td>
	</tbody>
	</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number", "Number", "CaseInsensitiveString"]);
	</script>
	<table align=center bgcolor=white width=90% cellmargin=0 bottommargin=0 border=1>
	<tr>
	<td align=middle>
	<input type=submit value=Update>
	</td>
	</tr>
	</table>
	<!--<font color=green><b>&nbsp; &nbsp; &nbsp; &nbsp; # Once you submit the attendance, you can further change the same.</b></font>-->
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