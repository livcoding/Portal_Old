<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rsAtt=null, rsRowNum=null, RsChk1=null, rsdt=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry2="";
String qry1="",mLTP="";
long mSNo=0,dt=0;
String mMemberID="";
String mDMemberID="", mEmpID="", QryEmpID="", mSrcType="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="",mtime1="",mtime2="";
String mMemberName="";
String mInstitute="";
String mExam="",mSubject="",mexam="",mSubj="",mGroup="",TRCOLOR="#F8F8F8",mcolor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="";
String mSExam="";
String mSES="";
String qryexam="",qrysubj="",qrysec="";
String mPrn="N",qsysdate="";
String mDate="",mType="",mltp1="";
String mRollno="",mName="",mradio1="";
String mDTfrom="";
String mDTupto="";
int Ctr=0, mDiffInDate=0;
int LFST=0, TFST=0, PFST=0, mRowNum=4;
long QryTotCls=0, QryTotPrs=0, QryPercAtt=0,mTotLCls=0,mTotTCls=0,mTotLPrs=0,mTotTPrs=0,mTLTCls=0,mTLTPrs=0,mPercAtt=0;
String mtimepicker1="";
String mtimepicker2="";
String mInst="", mComp="";

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


String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
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
<TITLE>#### <%=mHead%> [ Subjectwise Students Class Attendance ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<SCRIPT TYPE="text/javascript">

// copyright 1999 Idocs, Inc. http://www.idocs.com
// Distribute this script freely but keep this notice in place
function numbersonly(myfield, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

// control keys
if ((key==null) || (key==0) || (key==8) ||
    (key==9) || (key==13) || (key==27) )
   return true;

// numbers
else if ((("0123456789").indexOf(keychar) > -1))
   return true;

// decimal point jump
else if (dec && (keychar == "."))
   {
   myfield.form.elements[dec].focus();
   return false;
   }
else
   return false;
}
//-->

</SCRIPT>

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
	qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
   //out.print(qry);
 	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

		qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";

		rs=db.getRowset(qry);

		if(rs.next())
			qsysdate=rs.getString(1);
		else
			qsysdate="";

	  //----------------------
%>
<form name="frm1" method="post">
<input id="p" name="p" type=hidden>
<table align=center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Student Wise Class Attendance</b></font></TABLE>
<table id=id-1 cellpadding=1 cellspacing=1 align=center rules=groups border=2>
<tr>
<td nowrap>
<FONT color=black face=Arial size=2><b>Faculty</b></FONT>
<%
try
{
	if(mSrcType.equals("I"))
	{
		mRightsID="83";
		qry="Select EmployeeID EmpID, nvl(EmployeeName,' ')||' ('||nvl(EmployeeCode,' ')||')' EmpName From EMPLOYEEMASTER where nvl(EMPLOYEETYPE,'TEC')='TEC' and nvl(deactive,'N')='N' and employeeid='"+mDMemberID+"'";
		qry+="and employeeid in (select employeeid from facultysubjecttagging where fstid in (select fstid from studentattendance)) Order By EmpName";
	}
	if(mSrcType.equals("H"))
	{
		qry="Select EmployeeID EmpID, nvl(EmployeeName,' ')||' ('||nvl(EmployeeCode,' ')||')' EmpName From EMPLOYEEMASTER where nvl(EMPLOYEETYPE,'TEC')='TEC' and nvl(deactive,'N')='N' and Departmentcode in (select departmentcode from hodlist where Institutecode='"+mInst+"' And Companycode='"+mComp+"' and employeeid='"+mDMemberID+"')";
		qry+="and employeeid in (select employeeid from facultysubjecttagging where fstid in (select fstid from studentattendance)) Order By EmpName";
	}
	if(mSrcType.equals("A"))
	{
		mRightsID="87";
		qry="Select EmployeeID EmpID, nvl(EmployeeName,' ')||' ('||nvl(EmployeeCode,' ')||')' EmpName From EMPLOYEEMASTER where nvl(EMPLOYEETYPE,'TEC')='TEC' and nvl(deactive,'N')='N'";
		qry+="and employeeid in (select employeeid from facultysubjecttagging where fstid in (select fstid from studentattendance)) Order By EmpName";
	}
	if(mSrcType.equals("C"))
	{
	}
	//out.print(qry);
	rs=db.getRowset(qry);
	%>
	<Select Name=Faculty tabindex="0" id="Faculty">
	<%
	if (request.getParameter("p")==null)
	{
		while(rs.next())
		{
			mEmpID=rs.getString("EmpID");
			if(QryEmpID.equals(""))
 			{
				QryEmpID=mEmpID;
				%>
				<OPTION Selected Value =<%=mEmpID%>><%=rs.getString("EmpName")%></option>
				<%
			}
			else
			{
				%>
				<OPTION Value =<%=mEmpID%>><%=rs.getString("EmpName")%></option>
				<%
			}
		}
	}
	else
	{
		while(rs.next())
		{
			mEmpID=rs.getString("EmpID");
			if(mEmpID.equals(request.getParameter("Faculty").toString().trim()))
 			{
				mEmpID=rs.getString("EmpID");
				QryEmpID=mEmpID;
				%>
				<OPTION selected Value =<%=mEmpID%>><%=rs.getString("EmpName")%></option>
				<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mEmpID%>><%=rs.getString("EmpName")%></option>
		      	<%
		   	}
		}
	}
	%>
	</select>
  	<%
}
catch(Exception e)
{
	// out.println("Error Msg");
}
%>
</td>
<td><INPUT Name="Submit1" Type="submit" Value="&nbsp; OK &nbsp;"></td>
</tr>
</table>
</form>
<%
if(request.getParameter("p")!=null)
{
	QryEmpID=request.getParameter("Faculty").toString().trim();
}
%>
<form name="frm2"  method="post">
<input id="p" name="p" type=hidden>
<input id="Faculty" name="Faculty" value=<%=QryEmpID%> type=hidden>
<input id="x" name="x" type=hidden>
<table id=id2 cellpadding=1 cellspacing=1 width="80%" align=center rules=groups border=2>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<tr><td nowrap>
<FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
<%
try
  {

qry="Select nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM ";
qry=qry+" from EXAMMASTER Where ";
qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
qry=qry+" and examcode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where InstituteCode='"+mInst+"' And CompanyCode='"+mLoginComp+"') ";
qry=qry+" order by EXAMPERIODFROM ";
//out.print(qry);
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
&nbsp;
<!--*********Exam**********-->
<!--******************DataCombo**************-->
<%
try
{

qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from facultysubjecttagging A,SUBJECTMASTER B";
qry=qry+" where a.employeeid='"+QryEmpID+"'";
qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='"+mInst+"' and ";
qry=qry+" Nvl(deactive,'N')='N' and facultyid<>'"+QryEmpID+"') AND A.SUBJECTID=B.SUBJECTID";
qry=qry+" union ";
qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from facultysubjecttagging A,SUBJECTMASTER B";
qry=qry+" where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"')";
qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='"+mInst+"' and ";
qry=qry+" Nvl(deactive,'N')='N' and facultyid<>'"+QryEmpID+"') AND A.SUBJECTID=B.SUBJECTID";
qry=qry+" union ";
qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
qry=qry+" nvl(deactive,'N')='N' and facultyid='"+QryEmpID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID ";
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

<FONT color=black face=Arial size=2><b>Subject</b>&nbsp;  </FONT>
<%
	qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from facultysubjecttagging A, SUBJECTMASTER B";
	qry=qry+" where a.employeeid='"+QryEmpID+"'";
	qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+QryEmpID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID and A.EXAMCODE='"+qryexam+"' AND nvl(a.PROJECTSUBJECT,'N')='N' " ;
	qry=qry+" union ";
	qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from facultysubjecttagging A, SUBJECTMASTER B";
	qry=qry+" where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"')";
	qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+QryEmpID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID and A.EXAMCODE='"+qryexam+"' AND nvl(a.PROJECTSUBJECT,'N')='N'" ;
	qry=qry+" union ";
	qry=qry+" Select  nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid='"+QryEmpID+"' And InstituteCode='"+mInst+"')AND A.SUBJECTID=B.SUBJECTID ";
	qry=qry+" and A.EXAMCODE='"+qryexam+"' AND nvl(a.PROJECTSUBJECT,'N')='N' order by subject";
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
</select></td></tr>
&nbsp;
<tr><td>
<%--<FONT color=black><FONT face=Arial size=2><STRONG>LTP </STRONG></FONT></FONT>
&nbsp;
<%--
	qry="Select LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical',' ') LtpDesc, Decode(nvl(LTP,' '),'L','1','T','2','P','3') orderltp ";
	qry=qry+" from  facultysubjecttagging A where a.employeeid='"+QryEmpID+"' ";
	qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+QryEmpID+"' And InstituteCode='"+mInst+"') and  A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+" union ";
	qry=qry+" Select LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical') LtpDesc, Decode(nvl(LTP,' '),'L','1','T','2','P','3') orderltp ";
	qry=qry+" from  facultysubjecttagging A where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"')";
	qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+QryEmpID+"' And InstituteCode='"+mInst+"') and  A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+" union ";
	qry=qry+" Select  LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical') LtpDesc ,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3') orderltp ";
	qry=qry+" from  facultysubjecttagging A where A.fstid in (select fstid from ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid='"+QryEmpID+"' And InstituteCode='"+mInst+"') ";
	qry=qry+" and A.EXAMCODE='"+qryexam+"' ORDER BY orderltp ";

	rs=db.getRowset(qry);

	//out.print(qry);

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
			<OPTION selected Value ='<%=mltp1%>'>&nbsp;<%=rs.getString("LtpDesc")%></option>
			<%
		}
		else
		{
	 		%>
			<OPTION Value ='<%=mltp1%>'>&nbsp;<%=rs.getString("LtpDesc")%></option>
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
</select>--%>


 <!******************Group/Section**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>Section</STRONG>&nbsp;</FONT></FONT>
<%
try
{
	qry1="select 'ALL' section from dual union all";
	qry1=qry1+" select nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where facultytype=decode('"+mDMemberType+"','E','I','E')";
	qry1=qry1+" and employeeid='"+QryEmpID+"' and";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"' Group By nvl(SECTIONBRANCH,' ')";
	qry1=qry1+" UNION";
	qry1=qry1+" select nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where facultytype=decode('"+mDMemberType+"','E','I','E')";
	qry1=qry1+" and fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"') and";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"' Group By nvl(SECTIONBRANCH,' ') order by Section";
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
		<select name=Section tabindex="0" id="Section" style="WIDTH: 90px" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">
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
	qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"' and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' )  Group by SECTIONBRANCH ,subjectid,EXAMCODE";
	qry1=qry1+" UNION";
	qry1=qry1+" select nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging where  ";
	qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"') and ";
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
&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Sub Sec.</STRONG></FONT></FONT>
<%
try
{
	qry1="Select SUBSECTIONCODE SubSection from  facultysubjecttagging where  ";
	qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"' and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"'";
	qry1=qry1+" and sectionbranch=decode('"+qrysec+"','ALL',sectionbranch,'"+qrysec+"') Group By SUBSECTIONCODE";
	qry1=qry1+" UNION";
	qry1=qry1+" Select SUBSECTIONCODE SubSection from  facultysubjecttagging where  ";
	qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"'";
	qry1=qry1+" and sectionbranch=decode('"+qrysec+"','ALL',sectionbranch,'"+qrysec+"') Group By SUBSECTIONCODE order by SubSection ";
	//out.print(qry1);
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
	qry1="Select SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ')subjectid from  facultysubjecttagging where   ";
	qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"' and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
	qry1=qry1+" Group By SUBSECTIONCODE ,nvl(SECTIONBRANCH,' ') ,nvl(Examcode,' '),nvl(subjectid,' ')";
	qry1=qry1+" UNION";
	qry1=qry1+" Select SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ')subjectid from  facultysubjecttagging where ";
	qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
	qry1=qry1+" Group By SUBSECTIONCODE ,nvl(SECTIONBRANCH,' ') ,nvl(Examcode,' '),nvl(subjectid,' ') order by SubSection ";
	//out.print(qry1);
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT Name="Submit2" Type="submit" Value="Show/Refresh"></td></tr>
<TR>
<TD width=50% nowrap>
<marquee behavior=alternate scrolldelay=300 direction=right>
<a href='DailyStudentAttendanceReport.jsp?EmpID=<%=QryEmpID%>'><font color=blue><b>LTP Wise Class Attendance</b></font></a>
</marquee>
</TD>
</TR>
</table>
</form>
<%

if(request.getParameter("x")!=null)
{
	mExam=request.getParameter("Exam").toString().trim();

	mSubject=request.getParameter("Subject").toString().trim();

	//mLTP=request.getParameter("LTP").toString().trim();
	mSection=request.getParameter("Section").toString().trim();

	mSubsection=request.getParameter("SubSection").toString().trim();
//out.print(mExam+" "+mSubject+" "+mLTP+" "+mSection+" "+mSubsection);
	%>
	<form name="frm1"  method="post" action="">
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='90%' bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
	<thead>
	<tr bgcolor="#ff8c00">
	<td rowspan=2 Title="Sort on SlNo"><font color="White"><b>Sr.<br>No.</b></font></td>
	<td rowspan=2 Title="Sort on Enrollment No" nowrap><font color="White"><b>Roll No.</b></font></td>
	<td rowspan=2 Title="Class Student Name"><font color="White"><b>Name</b></font></td>
	<td rowspan=2 Title="Sort on Section/Subsection"><font color="White"><b>Section<br>(SubSec.)</b></font></td>
    <%
    qry="Select DISTINCT A.LTP, DECODE(A.LTP,'L',1,'T',2,'P',3,4)LTPSEQ from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.EMPLOYEEID in ((select '"+QryEmpID+"' from Dual)UNION(Select B.EMPLOYEEID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID)) and NVL(A.PROJECTSUBJECT,'N')='N' ORDER BY LTPSEQ";
    rs=db.getRowset(qry);
    //out.print(qry);
    int count=0;
    boolean flag1=false;
    while(rs.next())
        {
        if(rs.getString(1).equals("L"))
            {
            flag1=true;
            count++;
            }
        else if(rs.getString(1).equals("T") && flag1==true)
            {
            count=count+2;
            }
        else
            count++;
        }
   // out.print(count);
    %>
	<td Colspan="<%=count%>" Title="Student % Attendance" align="center" nowrap><font color="White"><b>% Attendance Till Today</b></font></td>
	</tr>
    <tr bgcolor="#ff8c00">
    <%
    //qry="SELECT DISTINCT a.LTP, DECODE(a.LTP,'L',1,'T',2,'P',3,4)LTPSEQ FROM FACULTYSUBJECTTAGGING a WHERE a.employeeid = '"+QryEmpID+"' and a.subjectid = '"+mSubject+"' and a.examcode = '"+qryexam+"' and NVL(PROJECTSUBJECT,'N')='N' ORDER BY LTPSEQ";
    qry="Select DISTINCT A.LTP, DECODE(A.LTP,'L',1,'T',2,'P',3,4)LTPSEQ from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.EMPLOYEEID in ((select '"+QryEmpID+"' from Dual)UNION(Select B.EMPLOYEEID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID)) and NVL(A.PROJECTSUBJECT,'N')='N' ORDER BY LTPSEQ";
    rs=db.getRowset(qry);
   // out.print(qry);
    boolean flag=false;
    while(rs.next())
        {
        if(rs.getString(1).equals("L"))
            {
            flag=true;
            %><td rowspan=2 Align=center Title="Student Lecture % Attendance"><font color="White"><b><%=rs.getString(1)%></b></font></td><%
            }
        else if(rs.getString(1).equals("T") && flag==true)
            {
             %><td rowspan=2 Align=center Title="Student Lecture % Attendance"><font color="White"><b><%=rs.getString(1)%></b></font></td>
             <td rowspan=2 Align=center Title="Student Lecture And Tutorial % Attendance"><font color="White"><b>L+T</b></font></td>
             <%
            }
        else
            {
             %><td rowspan=2 Align=center Title="Student Lecture % Attendance"><font color="White"><b><%=rs.getString(1)%></b></font></td><%
            }
         }
    %>
    </tr>
	</thead>
    <tbody>
	<%
				try
				{
					qry="Select A.fstid from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.LTP='L' and A.EMPLOYEEID in ((select '"+QryEmpID+"' from Dual)UNION(Select B.EMPLOYEEID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID))";
					//out.print(qry);
                    rsdt=db.getRowset(qry);
					if(rsdt.next())
						LFST++;
					qry="Select A.fstid from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.LTP='T' and A.EMPLOYEEID in ((select '"+QryEmpID+"' from Dual)UNION(Select B.EMPLOYEEID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID))";
					//out.print(qry);
                    rsdt=db.getRowset(qry);
					if(rsdt.next())
						TFST++;
					qry="Select A.fstid from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.LTP='P' and A.EMPLOYEEID in ((select '"+QryEmpID+"' from Dual)UNION(Select B.EMPLOYEEID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID))";
					//out.print(qry);
                    rsdt=db.getRowset(qry);
					if(rsdt.next())
						PFST++;
				}
				catch(Exception e)
				{
				}
     				qry="select  nvl(A.EMPLOYEEID,' ')employeeid,nvl(A.FSTID,' ')fstid,nvl(A.enrollmentno,' ')enrollmentno,nvl(A.studentname,' ')studentname, NVL(A.studentid,' ')studentid,";
					qry=qry+" NVL(A.SECTIONBRANCH,' ')|| '('||A.SUBSECTIONCODE||')' sectionbranch, nvl(B.SEMESTER,1) SEMESTER, nvl(to_char(B.REGCONFIRMATIONDATE,'dd-mm-yy'),' ') REGCONFIRMATIONDATE ,nvl(B.REGCONFIRMATION,'N')REGCONFIRMATION, ";
					qry=qry+" A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE, C.SemesterType,C.LTP LTP ,nvl(C.SLNO,-1) SLNO ";
					qry=qry+" from V#STUDENTLTPDETAIL A,STUDENTREGISTRATION B, SUBJECTWISESLNO C ,studentmaster D " ;
					//qry=qry+" where C.COMPANYCODE=A.COMPANYCODE ";
					//qry=qry+" AND C.INSTITUTECODE = A.INSTITUTECODE";
					qry=qry+" Where C.INSTITUTECODE = A.INSTITUTECODE ";
					qry=qry+" AND A.STUDENTID=D.STUDENTID AND NVL(D.DEACTIVE,'N')='N' ";
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
//qry=qry+" and (A.EMPLOYEEID in (select '"+QryEmpID+"' from Dual ";
//qry=qry+" where not exists (select 'y' from STUDATTENDANCEBYSPECIALFACULTY ssf Where ";
//------------OR-------------
qry=qry+" and (A.EMPLOYEEID in (select employeeid from facultysubjecttagging where employeeid='"+QryEmpID+"' OR (fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+QryEmpID+"' and fstid in (select fstid from facultysubjecttagging where examcode='"+mExam+"' and subjectid='"+mSubject+"')))";
qry=qry+" and not exists (select 'y' from STUDATTENDANCEBYSPECIALFACULTY ssf Where ";
					qry=qry+" trunc(sysdate)=trunc(sSF.attendancedate) and nvl(sSF.deactive,'N')='N' and A.fstid=ssf.fstid))";
					qry=qry+" or A.EMPLOYEEID in (Select sf.FACULTYID from  STUDATTENDANCEBYSPECIALFACULTY SF ";
					qry=qry+" where trunc(sysdate)=trunc(SF.attendancedate) and nvl(SF.deactive,'N')='N' and A.fstid=sf.fstid)";
					qry=qry+" )";
					qry=qry+" and A.SUBJECTID='"+mSubject+"'";
					//qry=qry+" and A.LTP in ('"+mLTP+"')";
					qry=qry+" and A.ExamCode='"+mExam+"'";
					qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"') ";
					qry=qry+" and A.sectionbranch=decode('"+mSection+"','ALL',A.sectionbranch,'"+mSection+"') ";

					
				    //qry=qry+" And FSTID not in (Select  FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"' and ATTENDANCETYPE='R' )";
					
					

					//qry=qry+" And FSTID not in (Select FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"'";
					//qry=qry+" And (to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
					//qry=qry+" or to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO))";
					//qry=qry+" And FSTID not in (Select FSTID from STUDENTATTENDANCEEXCUSED where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"'";
					//qry=qry+" And (to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
					//qry=qry+" or to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO))";
					qry=qry+" order by SLNO";
					//out.print(qry);
					rs1=db.getRowset(qry);
					while(rs1.next())
					{
						Ctr++;
						if(Ctr%2==0)
							TRCOLOR="White";
						else
							TRCOLOR="#F8F8F8";

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
						<tr bgcolor=<%=TRCOLOR%>>
						<td><%=Ctr%>.</td>
						<td><%=mRollno%></td>
						<td nowrap><%=GlobalFunctions.toTtitleCase(mName)%></td>
						<td><%=rs1.getString("sectionbranch")%></td>
						
						<%
						if(LFST>0)
						{
//------------------Start of 'L' Percentage--------------------
						QryTotCls=0;
						QryTotPrs=0;
                        mTotLCls=0;
                        mTotLPrs=0;

						qry1="select count(Distinct CLASSTIMEFROM)Tcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='L'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+" and EXAMCODE='"+mExam+"' and INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N'";
						if(rs1.getInt("SEMESTER")==1)
						{
							qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"'";
						}
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+" GROUP BY EXAMCODE, SubjectID, LTP";
						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
                            {
							QryTotCls=rs.getLong("Tcount");
                            mTotLCls=QryTotCls;
                            }
						else
                            {
							QryTotCls=0;
                            mTotLCls=0;
                            }
						qry1="select count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='L' and EXAMCODE='"+mExam+"'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"' and INSTITUTECODE='"+mInst+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N'";
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+" GROUP BY EXAMCODE, SubjectID, LTP";
						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
                            {
							QryTotPrs=rs.getLong("Pcount");
                            mTotLPrs=QryTotPrs;
                            }
						else
                            {
							QryTotPrs=0;
                            mTotLPrs=0;
                            }
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
//------------------End of 'L' Percentage--------------------
						%>
						<td ALIGN=CENTER>&nbsp;<a Title="View Date wise Student 'L' Attendance" target=_New href=DailyStudentAttendanceReportDet.jsp?EXAM=<%=mExam%>&amp;SID=<%=rs1.getString("studentid")%>&amp;SC=<%=mSubject%>&amp;LTP=L&amp;SEC=<%=rs1.getString("SECBR")%>&amp;SUBSEC=<%=rs1.getString("subsectioncode")%>><font color=""><b><%=QryPercAtt%></b> %</font></a></td>
						<%
						}
						//else
						//{
						%>
						<!--<td ALIGN=CENTER>-</td>-->
						<%
						//}
						if(TFST>0)
						{
//------------------Start of 'T' Percentage--------------------
						QryTotCls=0;
						QryTotPrs=0;
                        mTotTCls=0;
                        mTotTPrs=0;
						qry1="select count(Distinct CLASSTIMEFROM)Tcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='T'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+" and EXAMCODE='"+mExam+"' and INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N'";
						if(rs1.getInt("SEMESTER")==1)
						{
							qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"'";
						}
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+" GROUP BY EXAMCODE, SubjectID, LTP";
						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
                            {
							QryTotCls=rs.getLong("Tcount");
                            mTotTCls=QryTotCls;
                            }
						else
                            {
							QryTotCls=0;
                            mTotTCls=0;
                            }
						qry1="select count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='T' and EXAMCODE='"+mExam+"'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"' and INSTITUTECODE='"+mInst+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N'";
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+" GROUP BY EXAMCODE, SubjectID, LTP";
						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
                            {
							QryTotPrs=rs.getLong("Pcount");
                            mTotTPrs=QryTotPrs;
                            }
						else
                            {
							QryTotPrs=0;
                            mTotTPrs=0;
                            }
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
//------------------End of 'T' Percentage--------------------
						%>
						<td ALIGN=CENTER>&nbsp;<a Title="View Date wise Student 'T' Attendance" target=_New href=DailyStudentAttendanceReportDet.jsp?EXAM=<%=mExam%>&amp;SID=<%=rs1.getString("studentid")%>&amp;SC=<%=mSubject%>&amp;LTP=T&amp;SEC=<%=rs1.getString("SECBR")%>&amp;SUBSEC=<%=rs1.getString("subsectioncode")%>><font color=""><b><%=QryPercAtt%></b> %</font></a></td>
						<%
						}
						//else
						//{
						%>
						<!--<td ALIGN=CENTER>-</td>-->
						<%
						//}
            // ---------Start of 'L+T' Percentage--------------------
                        if(TFST > 0 && LFST > 0)
                            {
                        try
                        {
                        mTLTCls=mTotLCls+mTotTCls;
                        mTLTPrs=mTotLPrs+mTotTPrs;
                        if(mTLTCls==0)
                            mPercAtt=0;
                        else
                            mPercAtt=((mTLTPrs*100)/mTLTCls);
                        }
                        catch(ArithmeticException e)
						{
							//out.print(e);
						}
                        %>
						<td ALIGN=CENTER>&nbsp;<a Title="View Date wise Student 'P' Attendance" target=_New href=DailyStudentAttendanceReportDet.jsp?EXAM=<%=mExam%>&amp;SID=<%=rs1.getString("studentid")%>&amp;SC=<%=mSubject%>&amp;LTP=LT&amp;SEC=<%=rs1.getString("SECBR")%>&amp;SUBSEC=<%=rs1.getString("subsectioncode")%>><font color=""><b><%=mPercAtt%></b> %</font></a></td>
						<%
                        }
                        //else
						//{
						%>
					<!--	<td ALIGN=CENTER>-</td>-->
						<%
						//}
						if(PFST>0)
						{
//------------------Start of 'P' Percentage--------------------
						QryTotCls=0;
						QryTotPrs=0;
						qry1="select count(Distinct CLASSTIMEFROM)Tcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='P'";
						if(rs1.getInt("SEMESTER")==1)
						{
							qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"'";
						}
						qry1=qry1+" and EXAMCODE='"+mExam+"' and INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N'";
						//qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"'";
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+" GROUP BY EXAMCODE, SubjectID, LTP";
						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
							QryTotCls=rs.getLong("Tcount");
						else
							QryTotCls=0;
						qry1="select count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='P' and EXAMCODE='"+mExam+"'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"' and INSTITUTECODE='"+mInst+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N'";
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
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
//------------------End of 'P' Percentage--------------------
						%>
						<td ALIGN=CENTER>&nbsp;<a Title="View Date wise Student 'P' Attendance" target=_New href=DailyStudentAttendanceReportDet.jsp?EXAM=<%=mExam%>&amp;SID=<%=rs1.getString("studentid")%>&amp;SC=<%=mSubject%>&amp;LTP=P&amp;SEC=<%=rs1.getString("SECBR")%>&amp;SUBSEC=<%=rs1.getString("subsectioncode")%>><font color=""><b><%=QryPercAtt%></b> %</font></a></td>
						<%
						}
						//else
						//{
						%>
						<!--<td ALIGN=CENTER>-</td>-->
						<%
						//}
           				%>

						</tr>
						
						<%
					}
				%>
	</tbody>
	</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number", "Number", "CaseInsensitiveString"]);
	</script>
	<table align=center bgcolor=white width=90% cellmargin=0 bottommargin=0 border=1>
	<tr>
	<td align=middle><font color=blue face=arial size=3><b>Total Student(s) - <%=Ctr%></b></font></td>
	</tr>
	</table>
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