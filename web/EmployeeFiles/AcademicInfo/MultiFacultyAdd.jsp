<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%


DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rsAtt=null, rsRowNum=null, RsChk1=null, rsdt=null;
GlobalFunctions gb=new GlobalFunctions();
String qry="";
String qry2="",mREGCONFIRMATIONDATE="";
String qry1="",mLTP="";
long mSNo=0,dt=0;
String mMemberID="";
String mDMemberID="";
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
int Ctr=0, mDiffInDate=0, mDataComboSubSec=0;
int LFST=0, TFST=0, PFST=0, mRowNum=4,Flag=0,flag1=0;
long QryTotCls=0, QryTotPrs=0, QryPercAtt=0;
String mtimepicker1="";
String mtimepicker2="";
String mInst="", mComp="", mRightsID="",mLoginComp="",qrymSES="";
int check=0;
	
String  DataSublist[]=new String[100];
String  Sublist[]=new String[100];
String mAcademicYear="";
String mAcad="",mACAD1="",mDept="";
 String mAddFaculty="",FSTID="";
   			String mFacultySet="";
				int mNoHrs=0, mSet1=0,mSet2=0,mSet3=0,mClassinweek=0,mflag=0,FNOHR=0,FCLASS=0;

if (session.getAttribute("DepartmentCode")==null)
	{
		mDept="";
	}
	else
	{
		mDept=session.getAttribute("DepartmentCode").toString().trim();
	}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

mInstitute=mInst;

if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
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
	mHead=" ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subjectwise Students Class Attendance ] </TITLE>

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
function ChangeOptions(Exam,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section)
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



	removeAllOptions(AcademicYear);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='-Select-';
			optns.value='-Select-';
			AcademicYear.options.add(optns);
			ssec='-Select-';

	for(i=0;i<DataComboAcad.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var acad;
		var otexts;
		var v1s=DataComboAcad.options[i].value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,lens);
		if (exams==Exam && subj==scs)
		 { 				
			
			var optns = document.createElement("OPTION");
			optns.text=DataComboAcad.options[i].text;
			optns.value=acad;
			AcademicYear.options.add(optns);
		}
	}		


	removeAllOptions(Section);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='-Select-';
			optns.value='-Select-';
			Section.options.add(optns);
			ssec='-Select-';

				//alert("ddddd"+DataComboSec.options.length);

	for(i=0;i<DataComboSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var pos3;
		var exams;
		var scs;
		var lens;
		var scse;
		var acad;
		var otexts;
		var v1s=DataComboSec.options[i].value;
			


		lens= v1s.length ;	
		
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&');
				pos3=v1s.indexOf('///');
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,pos3);
		scse=v1s.substring(pos3+3,lens);

			
		if (exams==Exam && subj==scs)
		 { 		
			
		

			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options[i].text;
			optns.value=scse;
			Section.options.add(optns);
		}
	}	
		
		
}
//********Click event on subject**********
function ChangeSubject(Exam,subj,DataComboAcad,AcademicYear,DataComboSec,Section,DataSubSec,SubSection)
  {
    

	removeAllOptions(AcademicYear);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='-Select-';
			optns.value='-Select-';
			AcademicYear.options.add(optns);
			ssec='-Select-';

	for(i=0;i<DataComboAcad.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var acad;
		var otexts;
		var v1s=DataComboAcad.options[i].value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,lens);
		if (exams==Exam && subj==scs)
		 { 				
			
			var optns = document.createElement("OPTION");
			optns.text=DataComboAcad.options[i].text;
			optns.value=acad;
			AcademicYear.options.add(optns);
		}
	}		


	removeAllOptions(Section);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='-Select-';
			optns.value='-Select-';
			Section.options.add(optns);
			ssec='-Select-';

				//alert("ddddd"+DataComboSec.options.length);

	//alert(acad+"acad"+AcademicYear);
	for(i=0;i<DataComboSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var pos3;
		var exams;
		var scs;
		var lens;
		var scse;
		var acad;
		var otexts;
		var v1s=DataComboSec.options[i].value;
			


		lens= v1s.length ;	
		
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&');
				pos3=v1s.indexOf('///');
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,pos3);
		scse=v1s.substring(pos3+3,lens);

//			alert(acad+"acad"+AcademicYear);
		if (exams==Exam && subj==scs )
		 { 		
			
		

			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options[i].text;
			optns.value=scse;
			Section.options.add(optns);
		}
	}	


//mSubSES=mSExam+"***"+mSubj+"&&&"+rs1.getString("academicyear")+"///"+rs1.getString("Section")+"$$$"+rs1.getString("subsectioncode");



	var mflag=0;
	var ssec='?';
	
	removeAllOptions(SubSection);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='-Select-';
			optns.value='-Select-';
			SubSection.options.add(optns);
			ssec='-Select-';

//	alert(DataSubSec.options.length+"subsec");	

	for(i=0;i<DataSubSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var pos3;
		var pos4;
		var exams;
		var scs;
		var lens;
		var scse;
		var subsec;
		var otexts;
		var v1s=DataSubSec.options[i].value;
		lens= v1s.length ;	
		
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&');
				pos3=v1s.indexOf('///');
						pos4=v1s.indexOf('$$$');
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,pos3);
		scse=v1s.substring(pos3+3,pos4);
		subsec=v1s.substring(pos4+3,lens);

	
		if (exams==Exam && subj==scs   )
		 { 		
			
		

			var optns = document.createElement("OPTION");
			optns.text=DataSubSec.options[i].text;
			optns.value=subsec;
			SubSection.options.add(optns);
		}
	}	
		
	
}




//********Click event on Academic Year  **********
function ChangeAcademic(Exam,subj,AcademicYear,DataComboSec,Section,DataSubSec,SubSection)
  {
    

	removeAllOptions(Section);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='-Select-';
			optns.value='-Select-';
			Section.options.add(optns);
			ssec='-Select-';

				//alert("ddddd"+DataComboSec.options.length);

//	alert("acad"+AcademicYear);
	for(i=0;i<DataComboSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var pos3;
		var exams;
		var scs;
		var lens;
		var scse;
		var acad;
		var otexts;
		var v1s=DataComboSec.options[i].value;
			


		lens= v1s.length ;	
		
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&');
				pos3=v1s.indexOf('///');
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,pos3);
		scse=v1s.substring(pos3+3,lens);

//			alert(acad+"acad"+AcademicYear);
		if (exams==Exam && subj==scs && acad==AcademicYear )
		 { 		
			

			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options[i].text;
			optns.value=scse;
			Section.options.add(optns);
		}
	}	


//mSubSES=mSExam+"***"+mSubj+"&&&"+rs1.getString("academicyear")+"///"+rs1.getString("Section")+"$$$"+rs1.getString("subsectioncode");



	var mflag=0;
	var ssec='?';
	
	removeAllOptions(SubSection);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='-Select-';
			optns.value='-Select-';
			SubSection.options.add(optns);
			ssec='-Select-';

//	alert(DataSubSec.options.length+"subsec");	

	for(i=0;i<DataSubSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var pos3;
		var pos4;
		var exams;
		var scs;
		var lens;
		var scse;
		var subsec;
		var otexts;
		var v1s=DataSubSec.options[i].value;
		lens= v1s.length ;	
		
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&');
				pos3=v1s.indexOf('///');
						pos4=v1s.indexOf('$$$');
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,pos3);
		scse=v1s.substring(pos3+3,pos4);
		subsec=v1s.substring(pos4+3,lens);

	
		if (exams==Exam && subj==scs  &&  acad==AcademicYear )
		 { 		
			
		

			var optns = document.createElement("OPTION");
			optns.text=DataSubSec.options[i].text;
			optns.value=subsec;
			SubSection.options.add(optns);
		}
	}	
		
	
}



//********Click event on Branch Code  **********
function ChangeSection(Exam,subj,AcademicYear,Section,DataSubSec,SubSection)
  {
    



	var mflag=0;
	var ssec='?';
	
	removeAllOptions(SubSection);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='-Select-';
			optns.value='-Select-';
			SubSection.options.add(optns);
			ssec='-Select-';

//	alert(DataSubSec.options.length+"subsec");	

	for(i=0;i<DataSubSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var pos3;
		var pos4;
		var exams;
		var scs;
		var lens;
		var scse;
		var subsec;
		var otexts;
		var v1s=DataSubSec.options[i].value;
		lens= v1s.length ;	
		
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&');
				pos3=v1s.indexOf('///');
						pos4=v1s.indexOf('$$$');
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,pos3);
		scse=v1s.substring(pos3+3,pos4);
		subsec=v1s.substring(pos4+3,lens);

	
		if (exams==Exam && subj==scs  &&  acad==AcademicYear && scse==Section )
		 { 		
			
		

			var optns = document.createElement("OPTION");
			optns.text=DataSubSec.options[i].text;
			optns.value=subsec;
			SubSection.options.add(optns);
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
<body  onload="AlertMe()" aLink=#ff00ff  bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
	qry="Select WEBKIOSK.ShowLink('259','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
		
		
  //----------------------


%>
<form name="frm" method="post" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial">Multi Faculty Addition</TD>
</font></td></tr>
</TABLE>
<table id=id2 cellpadding=1 cellspacing=1 width="90%" align=center rules=rows border=2>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<tr><td nowrap colspan=2>
<FONT color=black face=Arial size=2><b>&nbsp; Exam Code</b></FONT>
<%
try
{ 	
	qry="SELECT Exam from(";
	qry=qry+" Select nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where InstituteCode='"+mInst+"' AND ";
	qry=qry+"  EXAMCODE NOT LIKE '%SUM%' AND  nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N'  ";
	qry=qry+" order by EXAMPERIODFROM DESC)";
	//qry=qry+" WHERE ROWNUM<=3";
	//out.print(qry);
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px"
onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section);"
onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section);">	
		
		
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(qryexam.equals(""))
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
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px"
onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section);"
 onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section);">	
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
</td>
<td nowrap>
<!--*********Exam**********-->
<!--******************DataCombo**************-->
<%
try														
{     

qry="Select distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from facultysubjecttagging A,SUBJECTMASTER B";
qry=qry+" where   A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE AND  A.examcode  in (select examcode from exammaster where institutecode = '"+mInst+"'  AND EXAMCODE NOT LIKE ('%SUP%' ) AND EXAMCODE NOT LIKE ('%SUM%' ) AND nvl(LOCKEXAM,'N')='N' ) and a.subjectid IN ( SELECT C.subjectid" +
                            "                     FROM pr#departmentsubjecttagging C" +
                            "                    WHERE C.institutecode ='" + mInst + "'" +
                            "  AND C.DEPARTMENTCODE='"+mDept+"' " +
                            "                      AND NVL (C.deactive, 'N') = 'N')   ";
qry=qry+" order by subject ";
//out.print(qry);
rs=db.getRowset(qry);

	//out.print(qry);
	if (request.getParameter("x")==null) 
	{
	 %>
		<Select Name=DataCombo id="DataCombo"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("subjectid");
			mCode=rs.getString("examcode");
			mES=mCode+"***"+mExam;
			%>
			<OPTION Value="<%=mES%>"><%=rs.getString("subject")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<Select Name=DataCombo id="DataCombo"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
		<%
		while(rs.next())
		{
			mExam=rs.getString("subjectid");
			mCode=rs.getString("examcode");
			mES=mCode+"***"+mExam;

			if(mExam.equals(request.getParameter("Subject").toString().trim()))
 			{
				%>
				<OPTION selected Value="<%=mES%>"><%=rs.getString("subject")%></option>
				<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value="<%=mES%>"><%=rs.getString("subject")%></option>
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
//----***************Subject**********************
%>
</td></tr>
<tr><td nowrap colspan="3">
<FONT color=black face=Arial size=2><b>&nbsp; &nbsp; &nbsp; &nbsp; Subject</b> </FONT>
<%	


	qry="Select distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from facultysubjecttagging A, SUBJECTMASTER B";
	qry=qry+" where A.SUBJECTID=B.SUBJECTID   AND A.INSTITUTECODE=B.INSTITUTECODE and B.InstituteCode='"+mInst+"' AND  A.examcode  in (select examcode from exammaster where institutecode = '"+mInst+"'  AND EXAMCODE NOT LIKE ('%SUP%' ) AND EXAMCODE NOT LIKE ('%SUM%' ) AND nvl(LOCKEXAM,'N')='N' ) and a.subjectid IN ( SELECT C.subjectid" +
                            "                     FROM pr#departmentsubjecttagging C" +
                            "                    WHERE C.examcode = '" + qryexam + "'" +
                            "                      AND C.institutecode ='" + mInst + "'" +
                            "  AND C.DEPARTMENTCODE='"+mDept+"' " +
                            "                      AND NVL (C.deactive, 'N') = 'N') ";
	qry=qry+" and A.EXAMCODE='"+qryexam+"'  and a.institutecode ='" + mInst + "' order by subject";
	rs=db.getRowset(qry);
//	out.print(qry);
	%>

	<select name=Subject tabindex="0" id="Subject" 
    onclick="ChangeSubject(Exam.value,Subject.value,DataComboAcad,AcademicYear,DataComboSec,Section,DataSubSec,SubSection);"
 onChange="ChangeSubject(Exam.value,Subject.value,DataComboAcad,AcademicYear,DataComboSec,Section,DataSubSec,SubSection);">
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

</td></tr>
<tr><td >
&nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp; &nbsp; 
<FONT color=black><FONT face=Arial size=2><STRONG>LTP </STRONG></FONT></FONT>

<%	
	qry="Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where institutecode='"+mInst+"' and LTP<>'E'  "; 
	qry=qry+" ORDER BY orderltp ";
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
&nbsp;&nbsp;

<FONT color=black><FONT face=Arial size=2><STRONG>Academic Year</STRONG></FONT></FONT>
&nbsp;&nbsp;
	<%
	try
	{


 qry = "select distinct nvl(ACADEMICYEAR,' ')ACADEMICYEAR   from facultysubjecttagging where " +
         " INSTITUTECODE='"+ mInst +"' AND nvl(deactive,'N')='N'   and examcode='"+qryexam+"' and subjectid='"+qrysubj+"'   order by ACADEMICYEAR";
 //out.print(qry);
     rs = db.getRowset(qry);

		%>	
															
<select name="AcademicYear" tabindex="0" id="AcademicYear" style="WIDTH: 80px" 
onclick="ChangeAcademic(Exam.value,Subject.value,AcademicYear.value,DataComboSec,Section,DataSubSec,SubSection);"
onChange="ChangeAcademic(Exam.value,Subject.value,AcademicYear.value,DataComboSec,Section,DataSubSec,SubSection);">

		<OPTION selected Value ='N'>-Select-</option>
<%   
	if (request.getParameter("x")==null) 
	 {
		while(rs.next())
		{
			mAcademicYear=rs.getString("ACADEMICYEAR").toString().trim();
			if(mAcad.equals(""))
			{
				mAcad=mAcademicYear;
			%>
				<OPTION   Value="<%=mAcademicYear%>"><%=rs.getString("ACADEMICYEAR")%></option>
			<%
			}
			else
			{
			%>
				<OPTION Value="<%=mAcademicYear%>"><%=rs.getString("ACADEMICYEAR")%></option>
			<%
			}
		} // closing of while
	 } // closing of if 
	 else
	{
		while(rs.next())
		{
			mAcademicYear=rs.getString("ACADEMICYEAR").toString().trim();
			if(mAcademicYear.equals(request.getParameter("AcademicYear").toString().trim()))
 			{
			   mAcad=mAcademicYear;
			%>
				<OPTION selected Value="<%=mAcademicYear%>"><%=rs.getString("ACADEMICYEAR")%></option>
			<%			
			}
			else
 	            {
				%>
					<OPTION Value ="<%=mAcademicYear%>"><%=rs.getString("ACADEMICYEAR")%></option>
			    	<%			
			}
		 } // closing of while
 } // closing of else
					%>
						</select>
					  	<%
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}
				


//**********************DataComboAcad***************
//out.print(qryexam);
try
{ 
	qry = "select distinct nvl(ACADEMICYEAR,' ')ACADEMICYEAR ,subjectid ,examcode from facultysubjecttagging where " +
         " INSTITUTECODE='"+ mInst +"' AND nvl(deactive,'N')='N'   AND  examcode  in (select examcode from exammaster where  institutecode = '"+mInst+"'  AND EXAMCODE NOT LIKE ('%SUP%' )      AND EXAMCODE NOT LIKE ('%SUM%' ) AND nvl(LOCKEXAM,'N')='N' )  order by ACADEMICYEAR";
		//out.print(qry);
	rs1=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="DataComboAcad" tabindex="0" id="DataComboAcad"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid");
			mSExam=rs1.getString("examcode");
			mACAD1=mSExam+"***"+mSubj+"&&&"+rs1.getString("ACADEMICYEAR");

			%>
			<OPTION Value ="<%=mACAD1%>"><%=rs1.getString("ACADEMICYEAR")%></option>
			
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="DataComboAcad" tabindex="0" id="DataComboAcad"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
		<%
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid").toString().trim();
			mSExam=rs1.getString("examcode");
			mACAD1=mSExam+"***"+mSubj+"&&&"+rs1.getString("ACADEMICYEAR");

			if(mACAD1.equals(request.getParameter("AcademicYear").toString().trim()))
 			{
				%>
				<OPTION selected Value ="<%=mACAD1%>"><%=rs1.getString("ACADEMICYEAR")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mACAD1%>"><%=rs1.getString("ACADEMICYEAR")%></option>
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

			



 <!******************Group/Section**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; &nbsp; &nbsp; Branch Code</STRONG>&nbsp;</FONT></FONT>
<%
try
{ 
	qry1="select '-Select-' section from dual union all";
	qry1=qry1+" select DISTINCT nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where ";
	qry1=qry1+" institutecode='"+mInst+"' and";
	qry1=qry1+" examcode  in (select examcode from exammaster where institutecode = '"+mInst+"'  AND nvl(LOCKEXAM,'N')='N' )";
	qry1=qry1+" and academicyear='"+mAcad+"' and  examcode='"+qryexam+"' and subjectid='"+qrysubj+"' Group By nvl(SECTIONBRANCH,' ') order by Section";
	//out.print(qry1);

	rs1=db.getRowset(qry1);

	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Section tabindex="0" id="Section" style="WIDTH: 80px"
onclick="ChangeSection(Exam.value,Subject.value,AcademicYear.value,Section.value,DataSubSec,SubSection);"
onChange="ChangeSection(Exam.value,Subject.value,AcademicYear.value,Section.value,DataSubSec,SubSection);">
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
		<select name=Section tabindex="0" id="Section" style="WIDTH: 80px" >
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
//out.print(qryexam);
try
{ 
	qry1=" select DISTINCT nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode,academicyear from  facultysubjecttagging where  ";
	qry1=qry1+" institutecode='"+mInst+"' and ";
	qry1=qry1+" examcode  in (select examcode from exammaster where institutecode = '"+mInst+"'  AND  nvl(LOCKEXAM,'N')='N' ";
	qry1=qry1+" )  Group by SECTIONBRANCH ,subjectid,EXAMCODE, academicyear";
		qry1=qry1+" order by Section";
	//out.print(qry1);
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="DataComboSec" tabindex="0" id="DataComboSec"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid");
			mSExam=rs1.getString("examcode");
			mSES=mSExam+"***"+mSubj+"&&&"+rs1.getString("academicyear")+"///"+rs1.getString("Section");

			%>
			<OPTION Value ="<%=mSES%>"><%=rs1.getString("Section")%></option>
			
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="DataComboSec" tabindex="0" id="DataComboSec"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
		<%
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid").toString().trim();
			mSExam=rs1.getString("examcode");
			mSES=mSExam+"***"+mSubj+"&&&"+rs1.getString("academicyear")+"///"+rs1.getString("Section");

			if(mSES.equals(request.getParameter("Section").toString().trim()))
 			{
				%>
				<OPTION selected Value ="<%=mSES%>"><%=rs1.getString("Section")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSES%>"><%=rs1.getString("Section")%></option>
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
<FONT color=black><FONT face=Arial size=2><STRONG>Sub Sec.</STRONG>
 </FONT></FONT>
	 <%
try
{ 
	qry="select '-Select-' subsection from dual union all";
	qry=qry+" select DISTINCT nvl(subsectioncode ,' ') subsectioncode from facultysubjecttagging where ";
	qry=qry+" institutecode='"+mInst+"' and";
	qry=qry+" examcode  in (select examcode from exammaster where  institutecode = '"+mInst+"'  AND nvl(LOCKEXAM,'N')='N' )";
	qry=qry+" and academicyear='"+mAcad+"' and  examcode='"+qryexam+"' and subjectid='"+qrysubj+"' Group By nvl(subsectioncode,' ') order by subsection ";
//	out.print(qry);
	rs1=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="SubSection" tabindex="0" id="SubSection" >	
		<%   
		while(rs1.next())
		{
			mSES=rs1.getString("subsection");
			
			qrymSES=mSES;
			%>
			<OPTION Value ="<%=mSES%>"><%=rs1.getString("subsection")%></option>
			
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="SubSection" tabindex="0" id="SubSection" >	
		<%
		while(rs1.next())
		{
			
			mSES=rs1.getString("subsection");

			if(mSES.equals(request.getParameter("SubSection").toString().trim()))
 			{
				qrymSES=mSES; 
				%>
				<OPTION selected Value ="<%=mSES%>"><%=rs1.getString("subsection")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSES%>"><%=rs1.getString("subsection")%></option>
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

//**********************DataSubSec***************
try
{ 
	String mSubSES="";

	qry=" select DISTINCT nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode,academicyear,nvl(subsectioncode ,' ') subsectioncode from facultysubjecttagging where ";
	qry=qry+" institutecode='"+mInst+"' and";
	qry=qry+" examcode  in (select examcode from exammaster where  institutecode = '"+mInst+"'  AND nvl(LOCKEXAM,'N')='N')";
	qry=qry+"  Group By nvl(subsectioncode,' '), SECTIONBRANCH ,subjectid,EXAMCODE, academicyear order by subsectioncode ";
	//out.print(qry);
	rs1=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="DataSubSec" tabindex="0" id="DataSubSec"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
		<%   
		while(rs1.next())
		{
			

			mSubj=rs1.getString("subjectid");
			mSExam=rs1.getString("examcode");
		mSubSES=mSExam+"***"+mSubj+"&&&"+rs1.getString("academicyear")+"///"+rs1.getString("Section")+"$$$"+rs1.getString("subsectioncode");

			%>
			<OPTION Value ="<%=mSubSES%>"><%=rs1.getString("subsectioncode")%></option>
			
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="DataSubSec" tabindex="0" id="DataSubSec"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
		<%
		while(rs1.next())
		{
			
				mSubj=rs1.getString("subjectid");
			mSExam=rs1.getString("examcode");
	mSubSES=mSExam+"***"+mSubj+"&&&"+rs1.getString("academicyear")+"///"+rs1.getString("Section")+"$$$"+rs1.getString("subsectioncode");

			if(mSubSES.equals(request.getParameter("SubSection").toString().trim()))
 			{
			
				%>
				<OPTION selected Value ="<%=mSubSES%>"><%=rs1.getString("subsectioncode")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSubSES%>"><%=rs1.getString("subsectioncode")%></option>
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
    </tr>
    <tr>
        <td align="center" colspan="4">
            <input type="submit" name="Submit" value="Submit"   >
        </td>
    </tr>
    </table>
</form>

<%

if(request.getParameter("x")!=null)
		{


		  mExam=request.getParameter("Exam").toString().trim();
	   mSubject=request.getParameter("Subject").toString().trim();
	   mLTP=request.getParameter("LTP").toString().trim();
	   mAcad=request.getParameter("AcademicYear").toString().trim();
	   mSection=request.getParameter("Section").toString().trim();
	   mSubsection=request.getParameter("SubSection").toString().trim();

		qry="select DISTINCT fstid,nvl(DURATIONOFCLASS,0)DURATIONOFCLASS, nvl(NOOFCLASSINAWEEK,0)NOOFCLASSINAWEEK from FACULTYSUBJECTTAGGING WHERE INSTITUTECODE='"+mInst+"'  AND EXAMCODE='"+mExam+"' AND SUBJECTID='"+mSubject+"' AND LTP='"+mLTP+"' AND SECTIONBRANCH=DECODE ('"+mSection+"', 'ALL', sectionbranch,'"+mSection+"') AND SUBSECTIONCODE=DECODE ('"+mSubsection+"','ALL', subsectioncode,'"+mSubsection+"' ) and academicyear= DECODE ('"+mAcad+"','ALL', academicyear,'"+mAcad+"' )  ";
//		AND DURATIONOFCLASS IS NOT NULL 
//		out.print(qry);
		rs=db.getRowset(qry);
		if(rs.next())
			{

				FSTID=rs.getString("fstid");
				FNOHR=rs.getInt("DURATIONOFCLASS");
				FCLASS=rs.getInt("NOOFCLASSINAWEEK");
						//		out.print(rs.getString("fstid"));


			}

if(!FSTID.equals(""))
{

       String mcheck="";
%>

<form name="form" method="post">
<input type="hidden" name="y" id="y">
    <input type="hidden" name="x" id="x">

<input type="hidden" name="Exam" value="<%=mExam%>">
    <input type="hidden" name="Subject" value="<%=mSubject%>">
        <input type="hidden" name="LTP" value="<%=mLTP%>">
            <input type="hidden" name="Section" value="<%=mSection%>">
                <input type="hidden" name="SubSection" value="<%=mSubsection%>">
				 <input type="hidden" name="AcademicYear" value="<%=mAcad%>">

<table rules=groups cellspacing=1 cellpadding=2 align=center border=1>
<tr><td>
<font color=black face=arial size=2><STRONG>Add Faculty&nbsp;</STRONG>
<%
	String mFaculty="",mFacultyName="",QryFaculty="";

  qry="select distinct nvl(A.employeeid,' ')Faculty, nvl(A.employeename,' ')FacultyName,nvl(A.employeecode,' ')Facultycode from eMPLOYEEMASTER A where a.companycode='"+mComp+"' and NVL(a.DEACTIVE,' ')='N'   order by FacultyName asc";
  rs=db.getRowset(qry);
 //out.print(qry);
	%>
	<select name=Faculty tabindex="0" id="Faculty">
		<OPTION selected Value ='N'>-Select Faculty-</option>
	<%
 	if(request.getParameter("y")==null)
	{
		while(rs.next())
		{
		 	mFaculty=rs.getString("Faculty");
		 	mFacultyName=rs.getString("FacultyName");
			if(QryFaculty.equals(""))
 			{			
			QryFaculty=mFaculty;
				%>
				<option selected value="<%=mFaculty%>"><%=mFacultyName%>--<%=rs.getString("Facultycode")%></option>
				<%
			}
			else
			{
				%>
				<option value="<%=mFaculty%>"><%=mFacultyName%>--<%=rs.getString("Facultycode")%></option>
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
			<option selected value="<%=mFaculty%>"><%=mFacultyName%>--<%=rs.getString("Facultycode")%></option>
			<%
		}
		else
		{
			%>
			<option value="<%=mFaculty%>"><%=mFacultyName%>--<%=rs.getString("Facultycode")%></option>
			<%
		}
	}
  }
%>
</select>

</td>
</tr>

<tr>
<td ALIGN=CENTER><INPUT TYPE="submit" value="Save">

</td>
</tr>
</table>

	<%




/*
select DISTINCT a.INSTITUTECODE, a.COMPANYCODE, a.FSTID, a.FACULTYTYPE, a.EMPLOYEEID
,b.EMPLOYEENAME,b.EMPLOYEECODE,C.EMPLOYEEID MULTIEMPLOYEE,C.NOFHRS,C.SET1,C.SET2,C.SET3
   from FACULTYSUBJECTTAGGING a,employeemaster b,MULTIFACULTYSUBJECTTAGGING c WHERE
    A.EXAMCODE='2012EVESEM' AND A.SUBJECTID='090198' and a.INSTITUTECODE='JIIT' 
   AND A.LTP='L' AND A.SECTIONBRANCH='ECE' AND A.SUBSECTIONCODE='A5'
   and a.EMPLOYEEID=b.EMPLOYEEID
   and a.INSTITUTECODE=c.INSTITUTECODE and a.COMPANYCODE=c.COMPANYCODE and  a.FSTID=c.FSTID
   */
  

   if(request.getParameter("Faculty")==null)
	   mAddFaculty="";
   else	
	   mAddFaculty=request.getParameter("Faculty").toString().trim();

	//out.print(mAddFaculty+"mAddFaculty");


		qry1="select DISTINCT a.INSTITUTECODE, a.COMPANYCODE, a.FSTID, a.FACULTYTYPE, a.EMPLOYEEID,b.EMPLOYEENAME,b.EMPLOYEECODE,C.EMPLOYEEID MULTIEMPLOYEE,nvl(C.NOFHRS,0)NOFHRS,nvl(C.SET1,0)SET1,nvl(C.SET2,0)SET2,nvl(C.SET3,0)SET3, nvl(c.FACULTYSET,' ')FACULTYSET, nvl(c.CLASSINAWEEK,0)CLASSINAWEEK,c.entryby   from FACULTYSUBJECTTAGGING a,employeemaster b,MULTIFACULTYSUBJECTTAGGING c WHERE	a.fstid='"+FSTID+"' and	a.INSTITUTECODE='"+mInst+"'  AND A.EXAMCODE='"+mExam+"' AND A.SUBJECTID='"+mSubject+"' AND A.LTP='"+mLTP+"' AND A.SECTIONBRANCH=DECODE ('"+mSection+"', 'ALL', A.sectionbranch,'"+mSection+"') AND A.SUBSECTIONCODE=DECODE ('"+mSubsection+"','ALL', A.subsectioncode,'"+mSubsection+"' ) and A.academicyear= DECODE ('"+mAcad+"','ALL', A.academicyear,'"+mAcad+"' )   and a.EMPLOYEEID=b.EMPLOYEEID   and a.INSTITUTECODE=c.INSTITUTECODE and a.COMPANYCODE=c.COMPANYCODE and  a.FSTID=c.FSTID order by entryby ";
	//	out.print(qry1);
		rs=db.getRowset(qry1);
		if(rs.next())
			{
				
				mNoHrs=rs.getInt("NOFHRS");
				mSet1=rs.getInt("SET1");
					mSet2=rs.getInt("SET2");
					mSet3=rs.getInt("SET3");
					mClassinweek=	rs.getInt("CLASSINAWEEK");
				mFacultySet=rs.getString("FACULTYSET").toString().trim();

			}

			//out.print(FCLASS+"--");
if(mNoHrs==0)
	mNoHrs=FNOHR;

if(mClassinweek==0)
	mClassinweek=FCLASS;
		

			qry="select 'Y' from MULTIFACULTYSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' and FSTID='"+FSTID+"' and EMPLOYEEID='"+mAddFaculty+"' ";
		//	out.print(qry);
			rs1=db.getRowset(qry);
			if(!rs1.next())
				{
					qry2="INSERT INTO MULTIFACULTYSUBJECTTAGGING (   INSTITUTECODE, COMPANYCODE, FSTID,    FACULTYTYPE, EMPLOYEEID, NOFHRS,    ENTRYBY, ENTRYDATE, DEACTIVE,    SET1, SET2, SET3,    FACULTYSET, CLASSINAWEEK) VALUES 					('"+mInst+"' , '"+mComp+"' ,'"+FSTID+"' , 'I' , '"+mAddFaculty+"',"+mNoHrs+",'"+mChkMemID+"',sysdate,'',"+mSet1+" ,"+mSet2+","+mSet3+",'"+mFacultySet+"' , "+mClassinweek+")";
					//out.print(qry2);
					int a=db.insertRow(qry2);
					if(a>0)
						mflag=1;
					else
						mflag=0;	
				}

		if(mflag==1)
			  out.print("<center> <font face=verdana  color=green size=2>Record Saved Successfully !</font>   </center>");



		%>
	<TABLE border='1' width="60%" align=center class="sort-table" id="table-1">
                       
<TR>
							<TD colspan=3 align=center	>
							<font size=3 face=arial color=red> Multi Faculty Detail</font>
							</TD>
							</TR>

							<TR bgcolor="#ff8c00">
							  <TD ><B> Delete</B></TD>
                                <TD ><B> Main Faculty</B></TD>
								<TD><B>Added Multi Faculty</B></TD>
							</TR>
<%

qry="select DISTINCT a.INSTITUTECODE, a.COMPANYCODE, a.FSTID, a.FACULTYTYPE, a.EMPLOYEEID,b.EMPLOYEENAME,b.EMPLOYEECODE,C.EMPLOYEEID MULTIEMPLOYEE,nvl(C.NOFHRS,0)NOFHRS,nvl(C.SET1,0)SET1,NVL(C.SET2,0)SET2,NVL(C.SET3,0)SET3, c.FACULTYSET,NVL(c.CLASSINAWEEK,0)CLASSINAWEEK,c.entryby   from FACULTYSUBJECTTAGGING a,employeemaster b,MULTIFACULTYSUBJECTTAGGING c WHERE	a.INSTITUTECODE='"+mInst+"'  AND A.EXAMCODE='"+mExam+"' AND A.SUBJECTID='"+mSubject+"' AND A.LTP='"+mLTP+"' AND A.SECTIONBRANCH=DECODE ('"+mSection+"', 'ALL', A.sectionbranch,'"+mSection+"') AND A.SUBSECTIONCODE=DECODE ('"+mSubsection+"','ALL', A.subsectioncode,'"+mSubsection+"' ) and A.academicyear= DECODE ('"+mAcad+"','ALL', A.academicyear,'"+mAcad+"' )   and a.EMPLOYEEID=b.EMPLOYEEID   and a.INSTITUTECODE=c.INSTITUTECODE and a.COMPANYCODE=c.COMPANYCODE and  a.FSTID=c.FSTID order by entryby";

		rs1=db.getRowset(qry);
		while(rs1.next())
			{

				

			%>
			<tr>
			<td>
			<a Title="Delete this Row" target=_New href="MultiFacultyDelete.jsp?FSTID=<%=rs1.getString("FSTID")%>&amp;EMPLOYEEID=<%=rs1.getString("MULTIEMPLOYEE")%>"><font color=blue ><b>Delete</b></font></a>
			</td>

			<td><%=rs1.getString("EMPLOYEENAME")%> - <%=rs1.getString("EMPLOYEECODE")%> </td>
			<td>
				<%
				qry2="select employeename employeename1,employeecode employeecode1 from employeemaster where employeeid='"+rs1.getString("MULTIEMPLOYEE")+"' and nvl(deactive,'N')='N' ";
					rs=db.getRowset(qry2);
					if(rs.next())
				{
				%>
				
				<%=rs.getString("employeename1")%>-<%=rs.getString("employeecode1")%>
			
				<%
				}
				%>

				
				
			
			</td>
			</tr>	
			<%	

			}


		}
		else
			{
			  out.print("<center> <font face=verdana  color=red size=2><b>No Record Found, Please Select other criteria ! </font>   </center>");

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
	 //out.print("error");	
}
%>
</body>
</html>