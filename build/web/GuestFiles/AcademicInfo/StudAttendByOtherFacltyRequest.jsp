<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rsDate=null,rs=null;
ResultSet rs1=null;
ResultSet rsTmp=null;
ResultSet rs2=null;
String QryExam="";
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry2="";
String qry1="",mLTP="";
long mSNo=0;
long mTransDay =0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mFactID="",mDateFrom="",mDateTo="",mREmarks="";	
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mComp="",mInst="";
String mExam="",mSubject="",mexam="",mSubj="",mcolor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="";
String mSExam="",mFaculty="";
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

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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
<TITLE>#### <%=mHead%> [ Student Attendance by Other Faclty Approval/Authorization Screen ] </TITLE>

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
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
	    qry="Select WEBKIOSK.ShowLink('89','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{
  //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Special Approval to Faculty to take attendance of other Batches</TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<!--*********Exam**********-->
<tr><td><FONT color=black face=Arial size=2><b><font color=red><sup>*</sup></font>Exam Code</b></FONT>
<%
try
{
qry="Select Distinct nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where ";
qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and ExamCode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mInst+"')";
	qry=qry+" order by EXAMPERIODFROM DESC";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mexam.equals(""))
 			{
			mexam=mExam;
			qryexam=mExam;
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
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				qryexam=mExam;
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
<!-----***************Faculty**********************-->
<FONT color=black face=Arial size=2><b><font color=red><sup>*</sup></font>Faculty</b></FONT>
<%	
	qry=" Select Distinct A.EmployeeID EmployeeID, nvl(A.EmployeeName,' ') EmployeeName ";
	qry=qry+" from EMPLOYEEMASTER A where A.EMPLOYEETYPE='TEC' and NVL(DEACTIVE,'N')='N' order by 2";
	rs=db.getRowset(qry);


%>
	<select name=Faculty tabindex="1" id="Faculty" style="WIDTH: 360px">
<% 
if (request.getParameter("x")==null) 
{
		while(rs.next())
	{
		if(mFaculty.equals(""))
		{
		  mFaculty=rs.getString("EmployeeID");
		  
 		%>
			<OPTION selected Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
		<%
		}
		else
		{
 		%>
			<OPTION Value ='<%=rs.getString("EmployeeID")%>'><%=rs.getString("EmployeeName")%></option>
		<%
		}
	}
}
else
{
		while(rs.next())
		{
			mFaculty=rs.getString("EmployeeID");
			if (mFaculty.equals(request.getParameter("Faculty").toString().trim()))
			{			
		%>
			<OPTION selected Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
		<%
		}
		else
		{
		%>
      		<OPTION Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
     		<%			
	   	}
	}
  }
%>
</select>
</td></tr>
<tr>	
	<%
	qry1="select to_char(Sysdate,'dd-MM-yyyy') CurDate from dual";
	rsDate=db.getRowset(qry1);
	rsDate.next();
	
	if(request.getParameter("DTFrom")==null||request.getParameter("DTFrom").equals(""))
		mDateFrom=rsDate.getString(1);	
	else
		mDateFrom=request.getParameter("DTFrom").toString().trim();	

	if(request.getParameter("DTTo")==null||request.getParameter("DTTo").equals(""))
		mDateTo=rsDate.getString(1);
	else
		mDateTo=request.getParameter("DTTo").toString().trim();

	if(request.getParameter("Remarks")==null||request.getParameter("Remarks").toString().trim().equals(""))
		mREmarks="";
	else
		mREmarks=request.getParameter("Remarks").toString().trim();	
		%>
	
<td><FONT color=black face=Arial size=2><b><font color=red><sup>*</sup></font>Attendance Approval for the Period <Input ID=DTFrom Name=DTFrom Type=Text maxlength=10 size=10 Value=<%=mDateFrom%>> To <Input Type=Text ID=DTTo Name=DTTo  maxlength=10 size=10 value=<%=mDateTo%>></b></FONT>
<font color=darkgreen size=2>Hint: Valid Date Format: DD-MM-YYYY</font></td></tr>	
<tr>
<td><FONT color=black face=Arial size=2>
<STRONG><font color=red><sup>*</sup></font>Remarks </STRONG></FONT><INPUT Type="Text" value='<%=mREmarks%>' ID=Remarks Name=Remarks size=90 maxlength=250>
</td></tr>
<tr>
<td>

<!--******************DataCombo**************-->
<%
try														
{     
	qry=" Select Distinct nvl(A.subjectid,' ') subjectid,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B";
	qry=qry+" Where A.examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry=qry+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) AND A.SUBJECTID=B.SUBJECTID"; 
	qry=qry+" order by subject";
	rs=db.getRowset(qry);
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
		<Select Name=DataCombo tabindex="0" id="DataCombo" style="WIDTH:0px">	
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

%>
<!-----***************Subject**********************-->
<FONT color=black face=Arial size=2><b><font color=red><sup>*</sup></font>Subject</b>&nbsp;</FONT>
<%	
	qry=" Select Distinct nvl(A.subjectid,' ') subjectid,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A, SUBJECTMASTER B";
	qry=qry+" Where A.examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry=qry+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) AND A.SUBJECTID=B.SUBJECTID"; 
	qry=qry+" and A.EXAMCODE='"+qryexam+"' order by subject";
	rs=db.getRowset(qry);
%>
	<select name=Subject tabindex="5" id="Subject" style="WIDTH: 360px" onclick="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);">	
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
&nbsp;
 <!******************Group/Section**************-->
<FONT color=black><FONT face=Arial size=2><STRONG><font color=red><sup>*</sup></font>Section/Branch</STRONG></FONT></FONT>
<%
try
{ 
	qry1="Select Distinct nvl(SECTIONBRANCH,' ') Section from  facultysubjecttagging";
	qry1=qry1+" Where examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"' order by Section";
	//out.print("sec"+qry1);
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="Section" tabindex="6" id="Section" style="WIDTH: 90px" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">	
			<option selected Value="ALL">ALL</option>
		<%   		
		qrysec="ALL";
		while(rs1.next())
		{
			mSubj=rs1.getString("Section");
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
		<select name=Section tabindex="6" id="Section" style="WIDTH: 90px" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">	
		<%
		if(request.getParameter("Section").toString().trim().equals("ALL"))
		{
			qrysec="ALL";
			%>
				<option selected VALUE="ALL">ALL</option>
			<%
		}
	else
		{
		%>
				<option Value="ALL">ALL</option>
			<%
		}
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
%>
</td></tr>
<%
// DataComboSec
try
{ 
	qry1=" select Distinct nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging";
	qry1=qry1+" Where examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
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
<tr> 
<td valign=top><table valign=top width='100%' border=1 valign=top rules='groups' cellpadding=0 cellspacing=0><tr><td width='250px'>
&nbsp;
 <!******************Sub Group/Sub Section**************-->
<FONT color=black><FONT face=Arial size=2><STRONG><font color=red><sup>*</sup></font>Sub Section (select Multiple Sub Section(s) using CTRL/SHIFT key)</STRONG></FONT></FONT>
</td><td valign=top>
<%
try
{ 
	if (request.getParameter("x")==null) 
	{		
		qry1="Select Distinct SUBSECTIONCODE SubSection from  facultysubjecttagging ";
		qry1=qry1+" Where examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
		qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
		qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"'";
		qry1=qry1+" and sectionbranch=decode('"+qrysec+"','ALL',sectionbranch,'"+qrysec+"') order by SubSection ";
		
		rs1=db.getRowset(qry1);

		%>
		<select name=SubSection multiple size=3 tabindex="7" id="SubSection" style="WIDTH: 90px">	
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
		<select name=SubSection multiple size=3 tabindex="7" id="SubSection" style="WIDTH: 90px">	
		<%
			int j,mFlag=0;
			String farray []=request.getParameterValues("SubSection");
						
		qry1="Select Distinct SUBSECTIONCODE SubSection from  facultysubjecttagging ";
		qry1=qry1+" Where examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
		qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
		qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"'";
		qry1=qry1+" and sectionbranch=decode('"+qrysec+"','ALL',sectionbranch,'"+qrysec+"') order by SubSection ";
		
		rs1=db.getRowset(qry1);
		while(rs1.next())
		{
			j=0;			
			mFlag=0;
			try
			{
			mSubj=rs1.getString("SubSection");						
			for(j=0;j<farray.length;++j)	
			{
			 if(mSubj.equals(farray[j]))
		    { 
		     mFlag=1;
		   	 break;
	      }
	    }
	    }
	    catch(Exception e)
	    {
	    mFlag=0;
			}
			
			if(mFlag==1)
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
// *************DataComboSub************
try
{ 
	qry1="Select Distinct SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ')subjectid from  facultysubjecttagging  ";
	qry1=qry1+" Where examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
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

%>
</td>
<td>
<FONT color=black face=Arial size=2>
	<STRONG><font color=red><sup>*</sup></font>LTP</STRONG>
	</FONT>
<select name="LTP" tabindex="7" id="LTP" style="WIDTH: 90px">
<% 	if(request.getParameter("x")==null)
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

&nbsp; &nbsp; &nbsp;<INPUT Type="submit" Value="Save/Refresh">
<br>
<font size=2 face=verdana color=red><sup>*</sup>Mandatory items must be entered to save</font>
</td>
</tr>
</table>
	<td></tr>
	</table>
	</form>
	<%	
	if(request.getParameter("x")!=null)
	{
	try
	{	
	mExam=request.getParameter("Exam").toString().trim();
	QryExam=mExam;
	
	if(request.getParameter("Subject").equals(""))
		mSubject="";
	else
		mSubject=request.getParameter("Subject").toString().trim();

	if(request.getParameter("LTP").equals(""))
		mLTP="";
	else
		mLTP=request.getParameter("LTP").toString().trim();

	if(request.getParameter("Section").equals(""))
		mSection="";
	else
		mSection=request.getParameter("Section").toString().trim();	

	int i;
	String fieldarray [];
	try{
	fieldarray = request.getParameterValues("SubSection");
	mSubsection="";
	for(i=0;i<fieldarray.length;++i)
	{
		if(mSubsection.equals(""))
		  mSubsection="'"+fieldarray[i]+"'";
	      else
		  mSubsection=mSubsection+",'"+fieldarray[i]+"'";		
	}
	}
	catch(Exception e)
		{
		}	
	if(request.getParameter("Faculty")==null||request.getParameter("Faculty").equals(""))
		mFactID="";
	else
		mFactID=request.getParameter("Faculty").toString().trim();	

	if(request.getParameter("DTFrom")==null||request.getParameter("DTFrom").equals(""))
		mDateFrom="";	
	else
		mDateFrom=request.getParameter("DTFrom").toString().trim();	

	if(request.getParameter("DTTo")==null||request.getParameter("DTTo").equals(""))
		mDateTo="";
	else
		mDateTo=request.getParameter("DTTo").toString().trim();

	if(request.getParameter("Remarks")==null||request.getParameter("Remarks").equals(""))
		mREmarks="";
	else
		mREmarks=GlobalFunctions.replaceSignleQuot(request.getParameter("Remarks").toString().trim());	
	
    String mData="";
    if (!mFactID.equals("") && !mDateFrom.equals("") && !mDateTo.equals("") &&  !mREmarks.equals(""))
	 {		
       if(GlobalFunctions.iSValidDate(mDateFrom)==true && GlobalFunctions.iSValidDate(mDateTo)==true)
	   {
	    qry="Select WEBKIOSK.IsFacultyForAttendanceOk('"+mExam+"','"+ mSubject+"','"+mLTP+"','"+mSection+"','"+mFactID+"',to_date('"+mDateFrom+"','dd-mm-yyyy'),to_date('"+mDateTo +"','dd-mm-yyyy'),'"+mREmarks+"')  RDesc from dual"	;
	    rs1=db.getRowset(qry);	
	    if (rs1.next())
 	    {
		  int pos=rs1.getString(1).trim().indexOf("#");			
		  int mLen=rs1.getString(1).trim().indexOf("#");			
		  mData=rs1.getString(1).trim().substring(0,pos);

		  mTransDay=Long.parseLong(mData);
		  if(mTransDay<0) mData=rs1.getString(1).trim().substring(pos+1,mLen);
		  if(mSubsection.equals("")) mData=mData+" SubSection/Group Must be selected...";
		  

	        long jk=0;
	    	  if( mTransDay>=0 && !mSubsection.equals(""))
		   {
		   // Insert Row here		
		   String mEmpType="I";		
		   qry="select Distinct FSTID from FacultySubjectTagging";
		   qry=qry + " where ExamCode='"+mExam+"'";
		   qry=qry + " And Subjectid='"+mSubject+"' And LTP='"+mLTP+"' and  SectionBranch=decode('"+mSection+"','ALL',SectionBranch,'"+mSection+"')"; 
		   qry=qry + " And SubsectionCode in ("+mSubsection+") ";	
		   qry=qry + "  and nvl(Deactive,'N')='N' order by FSTID";	
		   rsTmp=db.getRowset(qry);	
			

		   while (rsTmp.next())
		   {
		      jk=0;
			    while(jk<=mTransDay)
			    {			
					qry="select 'Y' from STUDATTENDANCEBYSPECIALFACULTY  Where "; 
					qry=qry+" FACULTYID='"+ mFactID  +"' and FACULTYTYPE='"+mEmpType+"' and ATTENDANCEDATE=(to_date('"+mDateFrom +"','dd-mm-yyyy'))+"+jk;
					qry=qry+" And FSTID='"+rsTmp.getString("FSTID")+"'";
					
					rs=db.getRowset(qry);	
					if (rs.next())
					{
					// Record Already exist/.....
					}
					else
					{
						qry="INSERT INTO STUDATTENDANCEBYSPECIALFACULTY (FACULTYID, FACULTYTYPE, ATTENDANCEDATE,"; 
						qry=qry+" FSTID, REMARKS) VALUES ('"+ mFactID  +"' ,'"+mEmpType+"',(to_date('"+mDateFrom +"','dd-mm-yyyy'))+"+jk;
						qry=qry+" ,'"+rsTmp.getString("FSTID")+"','"+mREmarks+"')";
						
						int r=db.update(qry);
					}
					jk++;
			} //while close of jk<=mTransDay
		 } //while close of rsTmp.next()


	} //mTransDay>=0
    else
	{
	%>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'><%=mData%></h3><br>
	</font>	
	<%	
	}	
	}
	else
	{
	%>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>Invalid Input</h3><br>
	</font>	
	<%	
	}
   }
  else
  {
	%>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>Invalid Date Format: Valid Format : DD-MM-YYYY only</h3><br>
	</font>	
	<%	
  }
 }	//All Enterd Data is Valid then
 }
 catch(Exception e){}
}//	  

// Show /Refresh data here

	%>
	<p Align=center><font color=darkbrown size2 face='verdana'>List of Faculties permited/allowed for attendance of other subjects/groups</font>
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=group/s topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
	<thead>
	<tr bgcolor="#ff8c00">
	<td Title="Click to Sort on SlNo"><font color="White"><b>SNo.</b></font></td>
	<td Title="Click to Sort on Attendance Date"><font color="White"><b>Attend. Date</b></font></td>
	<td Title="Click to Sort on Employee Name"><font color="White"><b>Employee Name</b></font></td>	
	<td Title="Click to Sort on Subject"><font color="White"><b>Subject (LTP)</b></font></td>
	<td Title="Click to Sort on Section/Group"><font color="White"><b>Group</b></font></td>	
	<td Title="Click to Sort on Remarks"><font color="White"><b>Remarks</b></font></td>
	</tr>
	</thead>
	<tbody>
	<%
		qry="select distinct (select employeeName from EmployeeMaster C where C.EmployeeID=B.FacultyID) EMPLOYEENAME, A.SubjectCode SubjectCode , A.LTP LTP, NVL(A.SECTIONBRANCH,' ')|| '-'||A.SUBSECTIONCODE SECTIONBRANCH,";
		qry=qry + " to_char(B.ATTENDANCEDATE,'dd-MM-YYYY') ATTENDANCEDATE , nvl(b.Remarks,' ') Remarks ";
		qry=qry + " from V#StudentLTPDETAIL A, STUDATTENDANCEBYSPECIALFACULTY B"; 
		qry=qry + " where A.FSTID=B.FSTID and A.ExamCode='"+QryExam+"'";
		qry=qry + "  and trunc(B.ATTENDANCEDATE) >= trunc(sysdate)";	
		//qry=qry + " And A.Subjectid='"+mSubject+"' And LTP='"+mLTP+"' and  A.SectionBranch=decode('"+mSection+"','ALL',A.SectionBranch,'"+mSection+"')"; 
		//qry=qry + " And SubsectionCode in ("+mSubsection+") ";	
		qry=qry + "  and nvl(B.Deactive,'N')='N' order by ATTENDANCEDATE,employeeName";	

		rs1=db.getRowset(qry);	
 		int Ctr=0;
		while(rs1.next())
		 {
			Ctr++;
			mcolor="Black";
			%>
			<tr>
			<td><font color=<%=mcolor%>><%=Ctr%></font></td>
			<td><font color=<%=mcolor%>><%=rs1.getString("ATTENDANCEDATE")%></font>
			<td><font color=<%=mcolor%>><%=rs1.getString("employeeName")%></font></td>
			<td><font color=<%=mcolor%>><%=rs1.getString("SubjectCode")%>(<%=rs1.getString("LTP")%>)</font></td>		
			<td><font color=<%=mcolor%>><%=rs1.getString("SECTIONBRANCH")%></font>		
			<td><font color=<%=mcolor%>><%=rs1.getString("Remarks")%></font>
			</tr>		
			<%          						
		 }	
		%>
		</tbody>
		</table>	
		<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number", "Date", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString"]);
		</script>
		<%
      
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
}
%>
</body>
</html>
