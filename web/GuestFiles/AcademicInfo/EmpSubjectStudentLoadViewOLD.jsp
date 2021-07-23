<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry2="";
String qry1="",mLTP="",mType="",mradio1="";
long mSNo=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mExam="",mSubject="",mexam="",mSubj="",mGroup="",mcolor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="";
String mSExam="";
String mSES="";
String qryexam="",qrysubj="",qrysec="";
String mPrn="N";


if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
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
<TITLE>#### <%=mHead%> [ Subjectwise Students List ] </TITLE>

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
		qry="Select WEBKIOSK.ShowLink('65','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
		  if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{

  //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Faculty cum Subject wise Students List (Class Strength)</TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<!--*********Exam**********-->
<tr><td><FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
<%
try
{
	 qry="Select Distinct nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where ";
	qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' order by EXAMPERIODFROM DESC";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">	
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
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">	
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
<!--******************DataCombo**************-->
<%
try														
{     
	qry=" Select Distinct nvl(A.subjectid,' ') subjectid,nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.employeeid='"+mDMemberID+"' ";
	qry=qry+" and A.facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+" A.examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry=qry+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) AND A.SUBJECTID=B.SUBJECTID"; 
	qry=qry+" order by subject";
	rs=db.getRowset(qry);
	//out.print(qry);
	if (request.getParameter("x")==null) 
	{
	 %>
		<Select Name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	
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
		<Select Name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	
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
<FONT color=black face=Arial size=2><b>Subject</b> </FONT>
<%	
	qry=" Select Distinct nvl(A.subjectid,' ') subjectid,nvl(B.subjectcode,' ') subjectcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.employeeid='"+mDMemberID+"' ";
	qry=qry+" and A.facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+" A.examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry=qry+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) AND A.SUBJECTID=B.SUBJECTID"; 
	qry=qry+" and A.EXAMCODE='"+qryexam+"' order by subject";
	rs=db.getRowset(qry);

%>
	<select name=Subject tabindex="0" id="Subject" style="WIDTH: 330px" onclick="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);">	
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
<select name=LTP tabindex="0" id="LTP" style="WIDTH: 90px">
<% 	if(request.getParameter("LTP")==null)
   	{
 %>			
	<OPTION Value =L selected>Lecture</option>
	<OPTION Value =T>Tutorial</option>
	<OPTION Value =P>Practical</option>
<%
  	}
  else
   {
	mLTP=request.getParameter("LTP");
	if(mLTP.equals("L"))
	{
%>
	<OPTION Value =L selected>Lecture</option>
	<OPTION Value =T>Tutorial</option>
	<OPTION Value =P>Practical</option>
<%
      }
	else if(mLTP.equals("T"))
	{
	%>
	<OPTION Value =L selected>Lecture</option>
	<OPTION Selected Value =T>Tutorial</option>
	<OPTION Value =P>Practical</option>
	<%		
	}
	else if(mLTP.equals("P"))
	{
	%>
	<OPTION Value =L selected>Lecture</option>
	<OPTION Value =T>Tutorial</option>
	<OPTION Value =P Selected>Practical</option>
	<%		
	}
    }		
%>
</select>
</td></tr>
<tr>
<td>
 <!******************Group/Section**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>Section</STRONG></FONT></FONT>
<%
try
{ 
	qry1="select 'ALL' section from dual union all";
	qry1=qry1+" select Distinct nvl(SECTIONBRANCH,' ') Section from  facultysubjecttagging where employeeid='"+mDMemberID+"' ";
	qry1=qry1+" and facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"' order by Section";
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Section tabindex="0" id="Section" style="WIDTH: 85px" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">	
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
		<select name=Section tabindex="0" id="Section" style="WIDTH: 85px" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">	
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
	qry1=" select Distinct nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging where employeeid='"+mDMemberID+"' ";
	qry1=qry1+" and facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
	qry1=qry1+" order by Section";
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
	qry1="Select Distinct SUBSECTIONCODE SubSection from  facultysubjecttagging where employeeid='"+mDMemberID+"' ";
	qry1=qry1+" and facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"'";
	qry1=qry1+" and sectionbranch=decode('"+qrysec+"','ALL',sectionbranch,'"+qrysec+"') order by SubSection ";
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{		
		%>
		<select name=SubSection tabindex="0" id="SubSection" style="WIDTH: 80px">	
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
		<select name=SubSection tabindex="0" id="SubSection" style="WIDTH: 80px">	
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
	qry1="Select Distinct SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ')subjectid from  facultysubjecttagging where employeeid='"+mDMemberID+"' ";
	qry1=qry1+" and facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
	qry1=qry1+" order by SubSection ";
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


if(request.getParameter("radio1")==null)
			{
			%>
<input type=radio id=radio1 name=radio1 checked value='L'><b>Level Printing</b>
<input type=radio id=radio1 name=radio1 value='A'><b>Complete Attendance Register</b>
			<%
			}
			else
			{
				mradio1=request.getParameter("radio1").toString().trim();
				if(mradio1.equals("L"))
				{
			%>
<input type=radio id=radio1 name=radio1 checked value='L'><b>Level Printing</b>
<input type=radio id=radio1 name=radio1 value='A'><b>Complete Attendance Register</b>

			<%
				}
				else
				{
			%>
	<input type=radio id=radio1 name=radio1  value='L'><b>Level Printing</b>
<input type=radio id=radio1 name=radio1 value='A' checked ><b>Complete Attendance Register</b>
			<%
				}
			}	
%>




	<INPUT Type="submit" Value="Show/Refresh">
</td></tr>
<tr><td colspan=6>
	&nbsp;
	<marquee  scrolldelay=225 width=700 behavior=alternate><A href="../../Images/PageSetupXL.bmp" Title="Instruction before print a Students List" Target=_New><font size=3 color=Blue><b>Recommended Page Setup: Paper Size - A4 and Top/Bottom Margin - .25</b></font></a></marquee>
	</td></tr>
	</table>
	</form>
	<%
	 mPrn="N";
	%>
	<form name="frm1"  method="post" action="PrintStudentList.jsp"> 
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='98%' bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
	<thead>
	<tr bgcolor="#ff8c00">
	<td Title="Sort on SlNo"><font color="White"><b>SNo.</b></font></td>
	<td Title="Sort on Enrollment No"><font color="White"><b>Roll No.</b></font></td>
	<td Title="Sort on Name [CaseInsensitive]"><font color="White"><b>Name</b></font></td>
	<td Title="Sort on Registration Date"><font color="White"><b>Reg. Date</b></font></td>
	<td Title="Sort on Section/Group [CaseInsensitiveString]"><font color="White"><b>Group</b></font></td>
	</tr>
	</thead>
	<tbody>
	<%	
	if(request.getParameter("x")!=null)
	{
	mType=request.getParameter("radio1").toString().trim();

	mExam=request.getParameter("Exam").toString().trim();
	mSubject=request.getParameter("Subject").toString().trim();
	mLTP=request.getParameter("LTP").toString().trim();
	mSection=request.getParameter("Section").toString().trim();	
	mSubsection=request.getParameter("SubSection").toString().trim();	
	mGroup=mSection+"-"+	mSubsection;
	qry="select distinct nvl(A.enrollmentno,' ')ENROLLMENTNO,nvl(A.studentname,' ')STUDENTNAME, NVL(A.studentid,' ') STUDENTID,";
	qry=qry+" NVL(A.SECTIONBRANCH,' ')|| '('||A.SUBSECTIONCODE||')' SECTIONBRANCH ,nvl(to_char(B.REGCONFIRMATIONDATE,'dd-mm-yy'),' ') REGCONFIRMATIONDATE ,nvl(B.REGCONFIRMATION,'N')REGCONFIRMATION, ";
	qry=qry+" A.SUBSECTIONCODE, C.SemesterType,C.LTP LTP ,nvl(C.SLNO,-1) SLNO ";
	qry=qry+" from V#STUDENTLTPDETAIL A,STUDENTREGISTRATION B, SUBJECTWISESLNO C"; 
	//qry=qry+" where C.COMPANYCODE=A.COMPANYCODE ";
	//qry=qry+" AND C.INSTITUTECODE = A.INSTITUTECODE";
	qry=qry+" Where C.INSTITUTECODE = A.INSTITUTECODE";
	qry=qry+" AND C.EXAMCODE=A.EXAMCODE";
	qry=qry+" AND C.studentid=A.studentid";
	qry=qry+" AND C.INSTITUTECODE= A.INSTITUTECODE";
	qry=qry+" AND C.EXAMCODE=A.EXAMCODE";
	qry=qry+" AND C.ACADEMICYEAR=A.ACADEMICYEAR ";
	qry=qry+" AND C.PROGRAMCODE=A.PROGRAMCODE ";
	qry=qry+" AND C.TAGGINGFOR=A.TAGGINGFOR ";
	qry=qry+" AND C.SECTIONBRANCH=A.SECTIONBRANCH ";
	qry=qry+" AND C.SUBSECTIONCODE=A.SUBSECTIONCODE ";
	//qry=qry+" AND C.SEMESTER=A.SEMESTER ";
	//qry=qry+" AND C.SEMESTERTYPE=A.SEMESTERTYPE ";
	qry=qry+" AND C.SUBJECTID=A.SUBJECTID";
	qry=qry+" AND C.LTP=A.LTP ";
	//qry=qry+" AND C.COMPANYCODE=B.COMPANYCODE";
	qry=qry+" AND C.INSTITUTECODE=B.INSTITUTECODE";
	qry=qry+" AND C.EXAMCODE=B.EXAMCODE";
	qry=qry+" AND C.REGCODE=B.REGCODE";
	//qry=qry+" AND C.ACADEMICYEAR=B.ACADEMICYEAR";
	//qry=qry+" AND C.PROGRAMCODE=B.PROGRAMCODE";
	//qry=qry+" AND C.TAGGINGFOR=B.TAGGINGFOR";
	//qry=qry+" AND C.SECTIONBRANCH=B.SECTIONBRANCH";
	//qry=qry+" AND C.SEMESTER=B.SEMESTER";
	//qry=qry+" AND C.SEMESTERTYPE=B.SEMESTERTYPE";
	qry=qry+" AND C.STUDENTID=B.STUDENTID";
	qry=qry+" AND C.studentid=A.studentid";
	qry=qry+" AND B.INSTITUTECODE=A.INSTITUTECODE";
	//qry=qry+" AND B.COMPANYCODE=A.COMPANYCODE";
	qry=qry+" AND B.EXAMCODE=A.EXAMCODE";
	qry=qry+" AND B.ACADEMICYEAR=A.ACADEMICYEAR";
	//qry=qry+" AND B.PROGRAMCODE=A.PROGRAMCODE";
	//qry=qry+" AND B.TAGGINGFOR=A.TAGGINGFOR";
	//qry=qry+" AND B.SECTIONBRANCH=A.SECTIONBRANCH";
	//qry=qry+" AND B.SEMESTER=A.SEMESTER";
	//qry=qry+" AND B.SEMESTERTYPE=A.SEMESTERTYPE";
	qry=qry+" AND B.STUDENTID=A.STUDENTID";
	//qry=qry+" AND NVL(B.REGALLOW,'N')='Y'";
	qry=qry+" and A.EMPLOYEEID='"+mDMemberID+"'";
	qry=qry+" and A.SUBJECTID='"+mSubject+"'";
	qry=qry+" and A.LTP='"+mLTP+"'";
	qry=qry+" and A.ExamCode='"+mExam+"'";
	qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode, '"+mSubsection+"') ";
	qry=qry+" and A.SECTIONBRANCH=decode('"+mSection+"','ALL',A.SECTIONBRANCH,'"+mSection+"') "; 
	qry=qry+" and nvl(A.DEACTIVE,'N')='N' ";
	qry=qry+" order by SLNO";

	rs1=db.getRowset(qry);
	//out.print(qry);
 	   int Ctr=0;
	   while(rs1.next())
	   {
		Ctr++;
		 mPrn="Y";
            mSNo=rs1.getLong("SLNO");
		mName1="Studentid"+String.valueOf(Ctr).trim();	
		mName2="mSNo"+String.valueOf(Ctr).trim();	
		mName3="Enroll"+String.valueOf(Ctr).trim();	
		mName4="RegDate"+String.valueOf(Ctr).trim();	
		mName5="Color"+String.valueOf(Ctr).trim();
		if(rs1.getString("REGCONFIRMATION").trim().equals("N"))
		mcolor="red";
		else 
		mcolor="black";

		%>
		<tr>
		<td><font color=<%=mcolor%>><%=rs1.getLong("SLNO")%></font></td>
		<td><font color=<%=mcolor%>><%=rs1.getString("ENROLLMENTNO")%></font></td>
		<td nowrap><font color=<%=mcolor%>><%=GlobalFunctions.toTtitleCase(rs1.getString("STUDENTNAME"))%></font></td>
		<td><font color=<%=mcolor%>><%=rs1.getString("REGCONFIRMATIONDATE")%></font></td>
		<td><font color=<%=mcolor%>><%=rs1.getString("SECTIONBRANCH")%></font>

		<input type=hidden name='<%=mName1%>' id='<%=mName1%>' value='<%=rs1.getString("STUDENTNAME")%>'>
		<input type=hidden name='<%=mName2%>' id='<%=mName2%>' value='<%=mSNo%>'>	
		<input type=hidden name='<%=mName3%>' id='<%=mName3%>' value='<%=rs1.getString("ENROLLMENTNO")%>'>
		<input type=hidden name='<%=mName4%>' id='<%=mName4%>' value='<%=rs1.getString("REGCONFIRMATIONDATE")%>'>	
		<input type=hidden name='<%=mName5%>' id='<%=mName5%>' value='<%=mcolor%>'>	
		</td></tr>
	<%          						
		 }	

	%>
		<input type=hidden name='TotalCount' id='TotalCount' value=<%=Ctr%>>
		<input type=hidden name='Subj' id='Subj' value='<%=mSubject%>'>
		<input type=hidden name='LTP' id='LTP' value='<%=mLTP%>'>
		<input type=hidden name='mGroup' id='mGroup' value='<%=mGroup%>'>	
		<input type=hidden name='ATYPE' ID='ATYPE' value='<%=mType%>'>	
		</tbody>
		</table>
		<%
		if ( mPrn.equals("Y"))
		{
		%>		
		<p Align="right"><INPUT Type="submit" Value="Make Printable Format">&nbsp; &nbsp; &nbsp; &nbsp;</p>
		</FORM>
		<%
		}
		else
		{
		%>
		</FORM>
		<%
		}
		%>

		<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number", "Number", "CaseInsensitiveString", "Date", "CaseInsensitiveString"]);
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
//	out.print("error"+qry);	
}
%>
</body>
</html>
