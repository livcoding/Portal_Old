<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey detailed report(Department wise) ] </TITLE>
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
function ChangeOptions(Program,DataCombo,DataComboFac,Subject,Faculty)
  {
	removeAllOptions(Subject);
	var optn = document.createElement("OPTION");
			optn.text='ALL';
			optn.value='ALL';
			Subject.options.add(optn);
    for(i=0;i<DataCombo.options.length;i++)
       {
		var v1;
		var pos;
		var pc;
		var sc;
		var len;
		var otext;
		var v1=DataCombo.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		pc=v1.substring(0,pos);
		sc=v1.substring(pos+3,len);
		if (pc==Program)
		 { 	
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=sc;
			Subject.options.add(optn);
		}
		else if (Program=='ALL')
		{
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=sc;
			if(optn.text!=otext)
			{
			Subject.options.add(optn);
			otext=optn.text;
			}
		}

	}
			
 removeAllOptions(Faculty);

			var optn1 = document.createElement("OPTION");
			optn1.text='ALL';
			optn1.value='ALL';
			Faculty.options.add(optn1);

    for(i=0;i<DataComboFac.options.length;i++)
       {  
		var v11;
		var pos1;
		var id;
		var sc1;
		var len1;
		var otext1;
		var v11=DataComboFac.options(i).value;

		len1= v11.length ;	
		pos1=v11.indexOf('///');
		id=v11.substring(0,pos1);
		sc1=v11.substring(pos1+3,len1);
		var optn1 = document.createElement("OPTION");
			optn1.text=DataComboFac.options(i).text;
			optn1.value=id;
			if(optn1.text!=otext1)
			{
			Faculty.options.add(optn1);
			otext1=optn1.text;
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
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeCombo(Subject,DataComboFac,Faculty)
  {
    removeAllOptions(Faculty);

			var optn1 = document.createElement("OPTION");
			optn1.text='ALL';
			optn1.value='ALL';
			Faculty.options.add(optn1);

    for(i=0;i<DataComboFac.options.length;i++)
       {  
		var v11;
		var pos1;
		var id;
		var sc1;
		var len1;
		var otext1;
		var v11=DataComboFac.options(i).value;

		len1= v11.length ;	
		pos1=v11.indexOf('///');
		id=v11.substring(0,pos1);
		sc1=v11.substring(pos1+3,len1);

		if (sc1==Subject)
		 { 	
			var optn1 = document.createElement("OPTION");
			optn1.text=DataComboFac.options(i).text;
			optn1.value=id;
			
			Faculty.options.add(optn1);
		}
		else if (Subject=='ALL')
		{
			var optn1 = document.createElement("OPTION");
			optn1.text=DataComboFac.options(i).text;
			optn1.value=id;
			if(optn1.text!=otext1)
			{
			Faculty.options.add(optn1);
			otext1=optn1.text;
			}
		}
	}
  	}
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rs2=null,rssrtype=null,rsc=null,rsc1=null;
GlobalFunctions gb =new GlobalFunctions();

long mTotStrength=0,mTotSentStrength=0;
String qry="";
String qry1="",qry2="";
String x="",y="",z="",mRsExam="",t="",mSP="",mPc="";
int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mOA="",mPC="",msc="";
double mMarks=0,mEval=0,mPerc=0,mMarks1=0,cnt1=0,a=0,rating=0,rating1=0,ev=0,ev1=0,avg=0;
double mExTot=0;
double exev1=0;
double exavg=0;
String mInst="";
String minst="";
String lpc="",lpc1=""; 
String mDsub="",mSF="";
String mExam="";
String mexam="";
String mDMemberID="";
String mEvent="";
String mevent="";
double mTotPrecent=0;
double mTotDivide=0;
String mLTP="";
String mltp="";
String MLTP=""; 
long mLtot=0,mTtot=0,mPtot=0;
long Ltot=0,Ttot=0,Ptot=0;
String mSubjID="",yy="";
String mPCode="";
String mpcode="";

String mSubj="";
String msubj="";

String mFaculty="";
String mFacultyID="";
String mfaculty="";
String mcolor="",mColor="";


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

try
{
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
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('41','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">SRS Teacher Rating Report [Overall Average] - Departmentwise</TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>

<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(FINALIZED,'N')='Y' and nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}
%>
<!--Program**********-->
<tr><td><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Program</STRONG></FONT></FONT>
<%
try
{

	qry="Select Distinct nvl(B.PROGRAMCODE,' ')PROGRAMCODE, A.PROGRAMNAME||' ('||B.PROGRAMCODE||') ' Program from PROGRAMMASTER A, v#SRSEVENTS B where A.ProgramCode=B.ProgramCode and B.Employeeid in (select Employeeid ";
	qry=qry +" from EMPLOYEEMASTER where nvl(deactive,'N')='N' and DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) ";
	qry=qry+" and nvl(B.FINALIZED,'N')='Y' and nvl(B.deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Program tabindex="0" id="Program" style="WIDTH: 300px" onclick="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);" onChange="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);">	
		<OPTION selected value=ALL>ALL</option>
		<%   
		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			if(mpcode.equals(""))
 			mpcode=mPCode;
			%>
			<OPTION Value =<%=mPCode%>><%=rs.getString("Program")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Program tabindex="0" id="Program" style="WIDTH: 300px" onclick="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);" onChange="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);">	
		<%
		if (request.getParameter("Program").toString().trim().equals("ALL"))
 		{
			lpc="ALL";
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}

		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			if(mPCode.equals(request.getParameter("Program").toString().trim()))
 			{
				mpcode=mPCode;
				lpc=mPCode;
				%>
				<OPTION selected Value =<%=mPCode%>><%=rs.getString("Program")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mPCode%>><%=rs.getString("Program")%></option>
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
//	out.println("MSG5");
}
%>
</td>
<!--SRSEVENTCODE****-->
<td callspan=2><FONT color=black><FONT face=Arial size=2><STRONG>SRS Event</STRONG></FONT></FONT>
<%
try
{ 
	qry="Select Distinct nvl(SRSEVENTCODE,' ')Exam,entrydate from srseventmaster where srseventcode in ( ";
	qry=qry+" Select Distinct nvl(SRSEVENTCODE,' ')Exam from V#SRSEVENTS WHERE   Employeeid in (select Employeeid ";
	qry=qry +" from EMPLOYEEMASTER where nvl(deactive,'N')='N' and DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) ";
	qry=qry +" and NVL(FINALIZED,'N')='Y' and nvl(deactive,'N')='N' ) order by entrydate desc ";
	
/*
	qry="Select Distinct nvl(SRSEVENTCODE,' ')Exam from V#SRSEVENTS WHERE   Employeeid in (select Employeeid ";
	qry=qry +" from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) ";
	qry=qry +" and NVL(FINALIZED,'N')='Y' and nvl(deactive,'N')='N'  ";
	*/
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 140px">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mexam.equals(""))
			{
 			mexam=mExam;
			%>
			<OPTION selected Value =<%=mExam%>><%=mExam%></option>
			<%			
			}
			else
			{
			%>
			<OPTION  Value =<%=mExam%>><%=mExam%></option>
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
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 140px">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				%>
				<OPTION selected Value =<%=mExam%>><%=mExam%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mExam%>><%=mExam%></option>
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
//	out.println("MSG2");
}
%>
</td></tr>
<!--*********SUBJECT**************-->
<tr><td><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Subject</STRONG>&nbsp;&nbsp;</FONT></FONT>
<select name="Subject" ID="Subject" tabindex="0" style="WIDTH: 350px" onclick="ChangeCombo(Subject.value,DataComboFac,Faculty);" onChange="ChangeCombo(Subject.value,DataComboFac,Faculty);">
<%
if(request.getParameter("x")==null)
{
	qry1="Select Distinct B.SubjectID,B.SubjectCode,B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj ";
	qry1=qry1 +" from v#SRSEVENTS B where B.Employeeid in (select Employeeid ";
	qry1=qry1 +" from EMPLOYEEMASTER where nvl(deactive,'N')='N' and  DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry1=qry1 +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) ";
	qry1=qry1 +" and nvl(B.FINALIZED,'N')='Y' and nvl(B.deactive,'N')='N' order by B.SUBJECTCODE "; 
	rs1=db.getRowset(qry1);

%>
	<OPTION selected Value=ALL>ALL</option>
<%
	while(rs1.next())
	{
		mSubj=rs1.getString("SubjectID");
		if(mSubj.equals(""))
 		%>
		<OPTION Value ="<%=mSubj%>"><%=rs1.getString("Subj")%></option>
		<%			
	}

}
else
{
	qry1="Select Distinct B.SubjectID,B.SubjectCode,B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj ";
	qry1=qry1 +" from v#SRSEVENTS B where B.Employeeid in (select Employeeid ";
	qry1=qry1 +" from EMPLOYEEMASTER where nvl(deactive,'N')='N' and DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry1=qry1 +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) ";
	qry1=qry1 +" and nvl(B.FINALIZED,'N')='Y' and nvl(B.deactive,'N')='N' and ";
	qry1=qry1+" B.programcode=decode('"+lpc+"','ALL',B.programcode,'"+lpc+"') order by B.SUBJECTCODE "; 
	rs1=db.getRowset(qry1);
	
	if (request.getParameter("Subject").toString().trim().equals("ALL"))
 		{
			lpc1="ALL";
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}
	while(rs1.next())
	{
		
	
		 mSubj=rs1.getString("SubjectID");
if (mSubj.equals(request.getParameter("Subject").toString().trim()))
{		lpc1=mSubj;


 		%>
		<OPTION selected Value ="<%=mSubj%>"><%=rs1.getString("Subj")%></option>
		<%
		}	
		else
		{
		mSubj=rs1.getString("SubjectID");
	%>
      	<OPTION Value ="<%=mSubj%>"><%=rs1.getString("Subj")%></option>
     	<%			
	   	}
		
	}

}
%>
</select>

<!-- *****New Data combo****** -->

<%
try
{ 
	qry1="Select Distinct B.SubjectID,B.SubjectCode,B.Programcode,B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj ";
	qry1=qry1 +" from v#SRSEVENTS B where B.Employeeid in (select Employeeid ";
	qry1=qry1 +" from EMPLOYEEMASTER where nvl(deactive,'N')='N' and  DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry1=qry1 +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) ";
	qry1=qry1 +" and nvl(B.FINALIZED,'N')='Y' and nvl(B.deactive,'N')='N' order by B.SUBJECTCODE "; 
	rs1=db.getRowset(qry1);
	//out.print(qry1);	
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	
	<!-- <OPTION selected Value=ALL>ALL</option> -->
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectCode");
			mSubjID=rs1.getString("SubjectID");
			mPc=rs1.getString("Programcode");
			mSP=mPc+"***"+mSubj;
			//mSP=mPc;
			if(mSP.equals(""))
 			msubj=mSubjID;
			%>
			<OPTION Value ="<%=mSP%>"><%=rs1.getString("Subj")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	
		<%
		
		while(rs1.next())
		{
mSubjID=rs1.getString("SubjectID");
			mSubj=rs1.getString("SubjectCode");
			mPc=rs1.getString("Programcode");
			mSP=mPc+"***"+mSubj;
			if(mSP.equals(request.getParameter("DataCombo").toString().trim()))
 			{
				msubj=mSubjID;
				%>
				<OPTION selected Value ="<%=mSP%>"><%=rs1.getString("Subj")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSP%>"><%=rs1.getString("Subj")%></option>
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


<!--LTP***********-->
<td><FONT color=black><FONT face=Arial size=2><STRONG>LTP</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT>
<%
try
{ 

	qry1="select 'ALL' LTP,'ALL' LTPDesc,'0' ono from dual UNION select distinct LTP, decode(LTP,'L','Lecture','T','Tutorial','Practical') LTPDesc,decode(ltp,'L','1','T','2','3') ono from v#SRSevents where   Employeeid in (select Employeeid ";
	qry1=qry1 +" from EMPLOYEEMASTER where  nvl(deactive,'N')='N' and  DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry1=qry1 +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and nvl(deactive,'N')='N' order by ono";
	//out.print(qry1);
	
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select ID="LTP" Name=LTP tabindex="0" style="WIDTH: 120px">
		<%   
		while(rs1.next())
		{
			mLTP=rs1.getString("LTP");
			if(mltp.equals(""))
 			{mltp=mLTP;
			%>
			<OPTION selected Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
			<%			
			}
			else
			{
			%>
			<OPTION Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
			<%			

			}
		}
		%>
		</select><font color='green'>#</font>
		<%
	}
	else
	{
		%>	
		<select ID="LTP" Name=LTP tabindex="0" style="WIDTH: 120px">
		<%		 
		while(rs1.next())
		{
			mLTP=rs1.getString("LTP");
			if(mLTP.equals(request.getParameter("LTP").toString().trim()))
 			{
				mltp=mLTP;
				%>
				<OPTION selected Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
		      	<%			
		   	}
		}
		%>
		</select><font color='green'>#</font>
	  	<%
	 }
 }    
catch(Exception e)
{
	out.println("");
}
%>

<!--********DataComboFac***********-->
<%
try
{ 
	qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(A.subjectid,' ') subjectid,nvl(A.subjectcode,' ') subjectcode,nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from v#SRSEVENTS A";
	qry=qry +" Where A.Employeeid in (select Employeeid ";
	qry=qry +" from EMPLOYEEMASTER where nvl(deactive,'N')='N' and  DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) and nvl(A.FINALIZED,'N')='Y' and nvl(A.deactive,'N')='N'";
	qry=qry +" ORDER BY employeename,subjectcode ";
	rs=db.getRowset(qry);
	if (request.getParameter("DataComboFac")==null)
	{
		%>
		<select name='DataComboFac' id="DataComboFac" style="WIDTH:0px">	
		<%   
		while(rs.next())
		{
			mFacultyID=rs.getString("EMPLOYEEID");
	//		mDsub=rs.getString("subjectcode");
			mDsub=rs.getString("subjectid");
			mSF=mFacultyID+"///"+mDsub;
              	mFaculty=rs.getString("EMPLOYEENAME");
			if(mSF.equals(""))
 			%>
			<OPTION Value =<%=mSF%>><%=mFaculty%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name='DataComboFac' tabindex="0" id="DataComboFac" style="WIDTH:0px">	
		<%
		  while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEENAME");
			mDsub=rs.getString("subjectid");
			mFacultyID=rs.getString("EMPLOYEEID");
			mSF=mFacultyID+"///"+mDsub;
			if(mSF.equals(request.getParameter("DataComboFac").toString().trim()))
 			{
				mfaculty=mFacultyID;
				%>
				<OPTION selected Value =<%=mSF%>><%=mFaculty%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSF%>><%=mFaculty%></option>
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
//	out.println("");
}
%>
</td></tr>
<!--Faculty***********-->
<tr><td colspan=2><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Faculty</STRONG>&nbsp;&nbsp;</FONT></FONT>
<select name="Faculty" ID="Faculty" tabindex="0" style="WIDTH: 300px">
<%	
if(request.getParameter("Faculty")==null)
{
	qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from v#SRSEVENTS A";
	qry=qry +" Where A.Employeeid in (select Employeeid ";
	qry=qry +" from EMPLOYEEMASTER where nvl(deactive,'N')='N' and DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) and nvl(A.FINALIZED,'N')='Y' and nvl(A.deactive,'N')='N'";
	qry=qry +" ORDER BY employeename ";

	rs=db.getRowset(qry);
	
%>
	<OPTION selected Value=ALL>ALL</option>
<%
		while(rs.next())
		{
			mFacultyID=rs.getString("EMPLOYEEID");
			mFaculty=rs.getString("EMPLOYEENAME");
			if(mFacultyID.equals(""))
 			%>
			<OPTION Value =<%=mFacultyID%>><%=mFaculty%></option>
			<%			
		}
}
else
{

qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from v#SRSEVENTS A";
qry=qry +" Where A.Employeeid in (select Employeeid ";
qry=qry +" from EMPLOYEEMASTER where nvl(deactive,'N')='N' and  DEPARTMENTCODE in (select DEPARTMENTCODE from ";
qry=qry +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) and nvl(A.FINALIZED,'N')='Y' and nvl(A.deactive,'N')='N'";
qry=qry +" and A.subjectid=decode('"+lpc1+"','ALL',A.subjectid,'"+lpc1+"') ORDER BY EMPLOYEENAME ";
rs=db.getRowset(qry);
if (request.getParameter("Faculty").toString().trim().equals("ALL"))
 		{
	
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}
		while(rs.next())
		{
		mFacultyID=rs.getString("EMPLOYEEID");
		mFaculty=rs.getString("EMPLOYEENAME");
if (mFacultyID.equals(request.getParameter("Faculty").toString().trim()))
{

 		%>
		<OPTION selected Value ="<%=mFacultyID%>"><%=mFaculty%></option>
		<%
		}	
		else
		{
	%>
      	<OPTION Value ="<%=mFacultyID%>"><%=mFaculty%></option>
     	<%			
	   	}
		
	}

}
%>
</select>
<INPUT Type="submit" Value="Show"></td>
</tr>
</table>
</form>
<%
String mE="";
String mP="";
String mS="";
String mL="";
String mF="";

%>

<TABLE rules=Rows cellSpacing=0 cellPadding=0 width="100%" border=1 >
<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='100%' bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
<thead>
<form name="frm1" method=post>
<TR bgcolor="#c00000">
 <td align=middle title='Click on Teacher Name to sort table data'><b><font color="white">Teacher Name</font></td>
 <td align=middle title='Click on Subject Name to sort table data'><b><font color="white">Subject</font></td>
 <td align=middle title='Click on LTP to sort table data'><b><font color="white">&nbsp;LTP</font></td>
<td align=middle  nowrap>
<table class="sort-table" id="table-2"  border=0 cellpadding=0 cellspacing=0 width="70%" align=middle><thead>
<tr bgcolor="#c00000">
<td colspan=3 align=middle><b><font color="white" >Resp./Regd.</font></b></td>
</tr><tr bgcolor="#c00000">
<td align=middle><b><font color="white" >L</font></b></td>
<td align=middle><b><font color="white" >T</font></b></td>
<td align=middle><b><font color="white" >P</font></b></td>
</tr></thead></table></td>

<!--
 <td title='Click on Responded to sort table data' nowrap>
<table class="sort-table" id="table-3"  border=0 cellpadding=0 cellspacing=0 width="100%"><thead>
<tr bgcolor="#c00000"><td colspan=3><b><font color="white" >Responded</font></b></td></tr><tr bgcolor="#c00000"><td><b><font color="white" >L</font></b></td>
<td><b><font color="white" >T</font></b></td><td><b><font color="white" >P</font></b></td></tr></thead></table></td>
-->
 <%
      if(request.getParameter("x")!=null)
	{
	 mE=request.getParameter("Exam").toString().trim();
	 mP=request.getParameter("Program").toString().trim();
	 mS=request.getParameter("Subject").toString().trim();
		
	 mL=request.getParameter("LTP").toString().trim();
	 mF=request.getParameter("Faculty").toString().trim();
	
	qry="select SRSHEADING,SRSCODE, SRSDESCRIPTION from SRSTYPEMASTER where srseventcode='"+(request.getParameter("Exam").toString().trim())+"' Order by SEQID";
	rs=db.getRowset(qry);
	while(rs.next())
	{	
	%>
		<td align=middle><b><font color='White'><%=GlobalFunctions.toTtitleCase(rs.getString("SRSHEADING"))%></font></td> 
	<%	
	}
	%>
		<td align=middle ><b><font color="white" >Compre.</font></td>
		</tr></thead><tbody>
	<% 


qry1 =" select distinct A.INSTITUTECODE, A.COMPANYCODE,A.SRSEVENTCODE,A.FACULTYTYPE,A.EMPLOYEEID, ";
qry1 = qry1 + "A.EXAMCODE,A.SUBJECTID,A.SUBJECTCODE,A.LTP, ";
qry1 = qry1 + "A.EMPLOYEENAME,A.SUBJECT ";
qry1 = qry1 + "from v#SRSEVENTDETAIL A ";
qry1 = qry1 + " Where A.INSTITUTECODE='"+mInst+"' AND A.SRSEVENTCODE='"+mE+"'";
qry1 = qry1 + "And A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"') ";
qry1 = qry1 + "And A.SUBJECTID=decode('"+mS+"','ALL',A.SUBJECTID, '"+mS+"') ";
qry1 = qry1 + "and A.LTP=decode('"+mL+"','ALL',LTP, '"+mL+"') ";
qry1 = qry1 + "and A.EMPLOYEEID=decode('"+mF+"','ALL',A.EMPLOYEEID, '"+mF+"') ";
qry1 = qry1 + "and nvl(A.DEACTIVE,'N')='N'";
qry1 = qry1 + "And (A.FSTID) in (select FSTID from V#SRSEvents where EMPLOYEEID in (select Employeeid ";
qry1=qry1 +" from EMPLOYEEMASTER where nvl(deactive,'N')='N' and  DEPARTMENTCODE in (select DEPARTMENTCODE from ";
qry1=qry1 +" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N'))  and nvl(FINALIZED,'N')='Y' and nvl(Deactive,'N')='N')";
qry1 = qry1 + "order by A.Employeename,A.EMPLOYEEID,A.SUBJECTCODE,A.LTP";

      mMarks=0;
	mEval=0;
	mPerc=0;
	String p="";
	rs1=db.getRowset(qry1);
	while(rs1.next())
	{ 	
	try{
		if(x.equals("") || y.equals("") || z.equals(""))
		{ 
		      mRsExam=rs1.getString("EXAMCODE").trim();
			x=rs1.getString("EMPLOYEEID");
			y=rs1.getString("SUBJECTID");
			yy=rs1.getString("SUBJECTCODE");
			z="'"+rs1.getString("LTP")+"'";
			t=rs1.getString("LTP");
			p=rs1.getString("EMPLOYEENAME");

		}
     		else if (!(rs1.getString("EMPLOYEEID").equals(x) && rs1.getString("SUBJECTID").equals(y)) )
		{

// counting strength of students in subject and faculty

if (!z.equals(""))
	{
	//	kk++;
		qry="SELECT count(distinct studentid),LTP from V#STUDENTLTPDETAIL where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') ";
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+x+"' and LTP in("+z+") and nvl(deactive,'N')='N'";
		qry=qry+" group by subjectcode,ltp ";


		rsc=db.getRowset(qry);
		Ltot=0 ;
		Ttot=0 ;
		Ptot=0;
		while(rsc.next())
		{
			if(rsc.getString("LTP").equals("L"))
			Ltot=rsc.getLong(1);
			else if(rsc.getString("LTP").equals("P"))
			Ptot=rsc.getLong(1);
			else if(rsc.getString("LTP").equals("T"))
			Ttot=rsc.getLong(1);
	
		}
		
	//	out.print(qry);
		qry="SELECT count(distinct studentid) mtot,LTP from V#SRSEVENTSUGGESTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+"and SRSEVENTCODE='"+mE+"' ";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') " ;
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+ x +"'  And LTP in ("+z+") and nvl(deactive,'N')='N'";
		qry=qry+" group by subjectcode,ltp ";
		//out.print(qry);
		rsc1=db.getRowset(qry);
		 mLtot=0 ;
		mTtot=0 ;
		mPtot=0;
	//	out.print(qry);
		while(rsc1.next())
		{
			if(rsc1.getString("LTP").equals("L"))
			mLtot=rsc1.getLong(1);
			else if(rsc1.getString("LTP").equals("P"))
			mPtot=rsc1.getLong(1);
			else if(rsc1.getString("LTP").equals("T"))
			mTtot=rsc1.getLong(1);
	
		}


	}

//-----------------------------

	%>
	   		<tr>
			 <td  nowrap ><font size=2><%=p%></font></td> 
			 <td align=middle><a target=_New href="SrsEventSuggestion.jsp?ICD=<%=mInst%>&amp;SEC=<%=mE%>&amp;EC=<%=mRsExam%>&amp;SC=<%=yy%>&amp;SID=<%=y%>&amp;LTP=<%=t%>&amp;EMPID=<%=x%>"><%=yy%></a></td> 
			 <td ><%=GlobalFunctions.getSortedLTPSQ(z)%></td>
			 <td align=center><table><tr>
			<td align=middle><font size=2 face=Tahoma><%=mLtot%>/<%=Ltot%></font></td>
			<td align=middle><font size=2 face=Tahoma><%=mTtot%>/<%=Ttot%></font></td>
			<td align=middle><font size=2 face=Tahoma><%=mPtot%>/<%=Ptot%></font></td>
			</tr></table>
			</td>
		<!--
		 <td align=center>
		<table><tr><td><font size=2 face=Tahoma><%=mLtot%></font></td><td><font size=2 face=Tahoma><%=mTtot%></font></td><td><font size=2 face=Tahoma><%=mPtot%></font></td></tr></table>
		</td>
		-->
		<%
			mTotPrecent=0;
			 mTotDivide=0;
		qry="select SRSCODE, nvl(Weightage,0) Weightage from SRSTYPEMASTER WHERE SRSEVENTCODE='"+mE+"' Order by SEQID ";
		rssrtype=db.getRowset(qry);
		while(rssrtype.next())
		{	
	qry2="select NVL(D.EVALUATIONUPTO,0)EVALUATIONUPTO,COUNT(*) cnt, nvl(A.NASELECTED,'N')NASELECTED, A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,nvl(C.EXCLUDINGREQUIRED,'N') EXCLUDINGREQUIRED,sum(A.RatingValue) RatingValue from V#SRSEVENTDETAIL A,SRSTYPEMASTER B,SRSSUBTYPEMASTER C,SRSRATINGMASTER D";
	qry2=qry2+ " where A.SRSEVENTCODE='"+mE+"' AND A.SRSEVENTCODE=B.SRSEVENTCODE AND A.SRSEVENTCODE=C.SRSEVENTCODE  and A.SRSCODE=B.SRSCODE AND A.SRSSUBCODE=C.SRSSUBCODE AND A.SRSCODE=C.SRSCODE AND A.institutecode='"+mInst+"'";
	qry2=qry2 + " AND A.EXAMCODE='"+mRsExam+"' ";
	qry2=qry2+"  AND  A.RATINGCODE=D.RATINGCODE  ";
	qry2=qry2+ " and A.Employeeid='"+x+"' and  ";
	qry2=qry2 + " A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"')  AND ";
	qry2=qry2 + " A.LTP IN ("+z+") AND A.SRSCODE='"+rssrtype.getString("SRSCODE")+"' ";
	qry2=qry2+ " and A.SUBJECTID='"+y+"' and nvl(A.naselected,'N')='N' ";
	qry2=qry2+" and nvl(APPROVED,'N')='Y' and nvl(FINALIZED,'N')='Y' ";
	qry2=qry2 + " AND  nvl(A.DEACTIVE,'N')='N'  ";
	qry2=qry2+" Group by D.EVALUATIONUPTO,A.NASELECTED,A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,C.EXCLUDINGREQUIRED ORDER BY B.SEQID,C.SEQID ";
	rs2=db.getRowset(qry2);
	//out.print(qry2);
	
	rs2=db.getRowset(qry2);
		mMarks=0;
		mEval=0;
		mPerc=0;
		a=0;
		cnt1=0;
		rating=0;
		rating1=0;
		ev=0;
		ev1=0;
		avg=0;
		mExTot=0;
		exev1=0;
		exavg=0;
				
			   while(rs2.next())
	   		   {
			
				ev=rs2.getDouble("EVALUATIONUPTO");
			 	if(rs2.getString("NASELECTED").equals("N"))
	 			{
					a=rs2.getDouble("RatingValue");
					cnt1=rs2.getDouble("cnt");
					rating=a/cnt1;	
					rating=gb.getRound(rating,2);
					rating1=rating1+rating ;
					ev1=ev1+ev;
					if (rs2.getString("EXCLUDINGREQUIRED").equals("Y"))
				     {
						mExTot=mExTot+rating;
						mExTot=gb.getRound(mExTot,2);
						exev1=exev1+ev;
		                 }
					
		 		 } //closing of if
	   		  }  //closing of rs2..while
				if(rating1==0)
				{
			%>	
				<TD>&nbsp;</td>
			<%
				}
				else
				{
					if(mExTot>0)
					{
					   exavg=((rating1-mExTot)/(ev1-exev1))*100;
					 mTotPrecent=mTotPrecent+(exavg*rssrtype.getDouble("Weightage")/100);
					   mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);

						if(exavg<50)
						mcolor="red";
						else
						mcolor="black";
								
					%>
					   <td align=middle><font color=<%=mcolor%>><%=gb.getRound(exavg,2)%></font></td>
					<%
					}
					else
					{
						avg=(rating1/ev1)*100;
				      mTotPrecent=mTotPrecent+(avg*rssrtype.getDouble("Weightage")/100);
					mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);
						if(avg<50)
						mcolor="red";
						else
						mcolor="black";
					
					%>
						<TD align=middle><font color=<%=mcolor%>><%=gb.getRound(avg,2)%></font></td>
					<%
					}	
				   } 
				}
			if(mTotDivide>0)
			{
			if((mTotPrecent/mTotDivide)<50)
			mColor="red";
			else
			mColor="black";
			%>		
			<td align=middle><font color=<%=mColor%>><%=gb.getRound((mTotPrecent/mTotDivide),2)%></font></td>
			<%

			}
			else
			{
			%><td>&nbsp;</td><%
			}
			mTotPrecent=0;
			mTotDivide=0;

	//---------------
	
	%>
	     </tr> 
	 <%	mRsExam=rs1.getString("EXAMCODE").trim();
		x=rs1.getString("EMPLOYEEID");
		y=rs1.getString("SUBJECTID");
		yy=rs1.getString("SUBJECTCODE");
		z="'"+rs1.getString("LTP")+"'";	
		p=rs1.getString("EMPLOYEENAME");
		t=rs1.getString("LTP");	

		}
	  else
	  {
		z=z+",'"+rs1.getString("LTP")+"'";	
		t=t+rs1.getString("LTP");	

		
	  }		

	}

	catch(Exception e)
	{
//	out.print("in catch block"+qry);
	}

   }  //closing of while rs1


//--------counting of students....

if (!z.equals(""))
	{
		qry="SELECT count(distinct studentid),LTP from V#STUDENTLTPDETAIL where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') ";
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+x+"' and LTP in("+z+") and nvl(deactive,'N')='N'";
		qry=qry+" group by subjectcode,ltp ";
		rsc=db.getRowset(qry);
		Ltot=0 ;
		Ttot=0 ;
		Ptot=0;
		while(rsc.next())
		{
			if(rsc.getString("LTP").equals("L"))
			Ltot=rsc.getLong(1);
			else if(rsc.getString("LTP").equals("P"))
			Ptot=rsc.getLong(1);
			else if(rsc.getString("LTP").equals("T"))
			Ttot=rsc.getLong(1);
	
		}
		
	//	out.print(qry);
		qry="SELECT count(distinct studentid) mtot,LTP from V#SRSEVENTSUGGESTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+"and SRSEVENTCODE='"+mE+"' ";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') " ;
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+ x +"'  And LTP in ("+z+") and nvl(deactive,'N')='N'";
		qry=qry+" group by subjectcode,ltp ";
		rsc1=db.getRowset(qry);
		 mLtot=0 ;
		mTtot=0 ;
		mPtot=0;
	//	out.print(qry);
		while(rsc1.next())
		{
			if(rsc1.getString("LTP").equals("L"))
			mLtot=rsc1.getLong(1);
			else if(rsc1.getString("LTP").equals("P"))
			mPtot=rsc1.getLong(1);
			else if(rsc1.getString("LTP").equals("T"))
			mTtot=rsc1.getLong(1);
	
		}


	}   
	if(!x.equals("") && !y.equals("") && !z.equals(""))
 	{
	//--------------------------------------------------
	%>
		<tr>
		 <td nowrap><font size=2><%=p%></font></td> 
 
 <td align=middle><a target=_New href="SrsEventSuggestion.jsp?ICD=<%=mInst%>&amp;SEC=<%=mE%>&amp;EC=<%=mRsExam%>&amp;SID=<%=y%>&amp;SC=<%=yy%>&amp;LTP=<%=t%>&amp;EMPID=<%=x%>"><%=yy%></a></td> 
		 <td><%=GlobalFunctions.getSortedLTPSQ(z)%></td>
		<td align=center><table><tr>
		<td align=middle><font size=2 face=Tahoma><%=mLtot%>/<%=Ltot%></font></td>
		<td align=middle><font size=2 face=Tahoma><%=mTtot%>/<%=Ttot%></font></td>
		<td align=middle><font size=2 face=Tahoma><%=mPtot%>/<%=Ptot%></font></td>
		</tr></table>
		</td>
		<!--
		 <td align=center>
		<table><tr><td><font size=2 face=Tahoma><%=mLtot%></font></td><td><font size=2 face=Tahoma><%=mTtot%></font></td><td><font size=2 face=Tahoma><%=mPtot%></font></td></tr></table>
		</td> -->


	<%   try{
		qry="select SRSCODE, nvl(Weightage,0) Weightage from SRSTYPEMASTER WHERE SRSEVENTCODE='"+mE+"' Order by SEQID ";
		rssrtype=db.getRowset(qry);
		while(rssrtype.next())
		{
					 
	qry2="select NVL(D.EVALUATIONUPTO,0)EVALUATIONUPTO,COUNT(*) cnt, nvl(A.NASELECTED,'N')NASELECTED, A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,nvl(C.EXCLUDINGREQUIRED,'N') EXCLUDINGREQUIRED,sum(A.RatingValue) RatingValue from V#SRSEVENTDETAIL A,SRSTYPEMASTER B,SRSSUBTYPEMASTER C,SRSRATINGMASTER D";
	qry2=qry2+ " where A.SRSEVENTCODE='"+mE+"' AND A.SRSEVENTCODE=B.SRSEVENTCODE AND A.SRSEVENTCODE=C.SRSEVENTCODE  and A.SRSCODE=B.SRSCODE AND A.SRSSUBCODE=C.SRSSUBCODE AND A.SRSCODE=C.SRSCODE AND A.institutecode='"+mInst+"'";
	qry2=qry2 + " AND A.EXAMCODE='"+mRsExam+"' ";
	qry2=qry2+"  AND  A.RATINGCODE=D.RATINGCODE  ";
	qry2=qry2+ " and A.Employeeid='"+x+"' and  ";
	qry2=qry2 + " A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"')  AND ";
	qry2=qry2 + " A.LTP IN ("+z+") AND A.SRSCODE='"+rssrtype.getString("SRSCODE")+"' ";
	qry2=qry2+ " and A.SUBJECTID='"+y+"' and nvl(A.naselected,'N')='N' ";
	qry2=qry2+" and nvl(APPROVED,'N')='Y' and nvl(FINALIZED,'N')='Y' ";
	qry2=qry2 + " AND  nvl(A.DEACTIVE,'N')='N'  ";
	qry2=qry2+" Group by D.EVALUATIONUPTO,A.NASELECTED,A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,C.EXCLUDINGREQUIRED ORDER BY B.SEQID,C.SEQID ";
	rs2=db.getRowset(qry2);
	//out.print(qry2);

		mMarks=0;
		mEval=0;
		mPerc=0;
		a=0;
		cnt1=0;
		rating=0;
		rating1=0;
		ev=0;
		ev1=0;
		avg=0;
		mExTot=0;
		exev1=0;
		exavg=0;
				
			   while(rs2.next())
	   		   {
			
				ev=rs2.getDouble("EVALUATIONUPTO");
				
			 	if(rs2.getString("NASELECTED").equals("N"))
	 			{
					a=rs2.getDouble("RatingValue");
					cnt1=rs2.getDouble("cnt");
					rating=a/cnt1;	
					rating=gb.getRound(rating,2);
					rating1=rating1+rating ;
					ev1=ev1+ev;
						
				if (rs2.getString("EXCLUDINGREQUIRED").equals("Y"))
				  {
					mExTot=mExTot+rating;
					mExTot=gb.getRound(mExTot,2);
					exev1=exev1+ev;
				  }
					
		 		}
	   		  }

				if(rating1==0)
				{
		%>				<TD>&nbsp;</td>
<%
				}
				else
				{
				if(mExTot>0)
				{
				exavg=((rating1-mExTot)/(ev1-exev1))*100;			
				 mTotPrecent=mTotPrecent+(exavg*rssrtype.getDouble("Weightage")/100);
				   mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);
						if(exavg<50)
						mcolor="red";
						else
						mcolor="black";

				%>
				<td align=middle><font color=<%=mcolor%>><%=gb.getRound(exavg,2)%><font></td>
				<%
				}
				else
				{
					avg=(rating1/ev1)*100;
				mTotPrecent=mTotPrecent+(avg*rssrtype.getDouble("Weightage")/100);
			   mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);
						if(avg<50)
						mcolor="red";
						else
						mcolor="black";

				%>
					<TD align=middle><font color=<%=mcolor%>><%=gb.getRound(avg,2)%></font></td>
				<%
				}	

			} 
			}
if(mTotDivide>0)
			{
			if((mTotPrecent/mTotDivide)<50)
			mColor="red";
			else
			mColor="black";
			%>		
			<td align=middle><font color=<%=mColor%>><%=gb.getRound((mTotPrecent/mTotDivide),2)%></font></td>
			<%

			}
			else
			{
			%>
			<td>&nbsp;</td>
			<%
			}
			mTotPrecent=0;
			mTotDivide=0;


}
catch(Exception e)
{
// out.print(qry);
}
}
%>
	       </tr> 
</tbody>
</form>
</TABLE>

		<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString"]);
		</script>


<center><FONT size=2 color=green># LTP will be merged in a single row if Lecture,Tutorial or Practical of the selected subject is taken by the same Faculty.</FONT></center> 
<center><MARQUEE style="COLOR: #63756d; FONT-FAMILY: Arial; FONT-SIZE: x-small; FONT-STYLE: normal; FONT-VARIANT: normal; FONT-WEIGHT: bold; HEIGHT: 8px; " Behavior='alternate' scrolldelay=225>Click on subject to view the respective suggestions.</MARQUEE>
</center> 

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
