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
<TITLE>#### <%=mHead%> [Student Reaction Survey Report (All Employee-for Admin Users)]</TITLE>

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
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;
String qry="",mWebEmail="";
String qry1="",myLTP="",mChkvalue="";
int mSNO=0;
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mrfay="";
String mRFAY="";
String mName1=""	,mName2="",mName3="",mName4="",mName5="",mName6="",mName7="";
String mName8="";
String mName9="";
long mLtot=0,mTtot=0,mPtot=0;
long Ltot=0,Ttot=0,Ptot=0;
String mInst="";
String minst="";

String mCCode="";
String mccode="",mExam="",mexam="",lpc="",lpc1="",mPc="",mSP="",mFacultyID="",mDsub="",mSF="";

String mSRSEventCode="",mDMemberType="";
String msrseventcode="";
String mName="";
String mPCode="",mpcode="";
String mBCode="";
String mbcode="";

String mSem="";
String msem="";

String mSubj="";
String msubj="";

String mLTP="";
String mltp="",paraL="L",paraT="T",paraP="P";

String mFaculty="";
String mfaculty="";

String mEmp1="";
String mEName="";
String ass="";

String mSRSCont="";
long mLtotal=0;
long mTtotal=0;
long mPtotal=0;

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
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('79','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Requested-Responded-Left Students</b></TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>

<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(deactive,'N')='N' ";
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
	qry="Select Distinct nvl(B.PROGRAMCODE,' ')PROGRAMCODE, A.PROGRAMNAME||' ('||B.PROGRAMCODE||') ' Program from PROGRAMMASTER A, V#SRSEVENTS B where A.ProgramCode=B.ProgramCode and nvl(B.deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Program tabindex="0" id="Program" style="WIDTH: 350px" onclick="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);" onChange="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);">	
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
		<select name=Program tabindex="0" id="Program" style="WIDTH: 350px" onclick="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);" onChange="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);">	
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
	qry="select  Distinct nvl(SRSEVENTCODE,' ')Exam ,entrydate from srseventmaster where srseventcode in ( ";
	qry=qry+ "Select Distinct nvl(SRSEVENTCODE,' ')Exam from v#SRSEVENTS WHERE   nvl(deactive,'N')='N' )" ;
	qry=qry+" order by entrydate desc ";
	rs=db.getRowset(qry);
//	out.print(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px">	
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
			<OPTION Value =<%=mExam%>><%=mExam%></option>
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
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px">	
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
<!--SUBJECT**************-->
<tr><td><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Subject</STRONG>&nbsp;&nbsp;</FONT></FONT>

<select name="Subject" ID="Subject" tabindex="0" style="WIDTH: 350px" onclick="ChangeCombo(Subject.value,DataComboFac,Faculty);" onChange="ChangeCombo(Subject.value,DataComboFac,Faculty);">
<%
if(request.getParameter("x")==null)
{
	qry1="Select Distinct B.SubjectID, B.SubjectCode, B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj from v#SRSEVENTS B  where  nvl(B.deactive,'N')='N' ORDER BY B.SUBJECTCODE";
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
qry1="Select Distinct B.SubjectID, B.SubjectCode, B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj from v#SRSEVENTS B  where  nvl(B.deactive,'N')='N' ";
qry1=qry1+" and B.programcode=decode('"+lpc+"','ALL',B.programcode,'"+lpc+"') ORDER BY B.SUBJECTCODE";
	rs1=db.getRowset(qry1);
	//mSubj ="";
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
	qry1="Select Distinct B.SubjectID, B.SubjectCode,B.Programcode, B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj from v#SRSEVENTS B  where  nvl(B.deactive,'N')='N' ORDER BY B.SUBJECTCODE";
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
			mSubj=rs1.getString("SubjectID");
			mPc=rs1.getString("Programcode");
			mSP=mPc+"***"+mSubj;
			//mSP=mPc;
			if(mSP.equals(""))
 			msubj=mSubj;
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
			mSubj=rs1.getString("SubjectID");
			mPc=rs1.getString("Programcode");
			mSP=mPc+"***"+mSubj;
			if(mSP.equals(request.getParameter("DataCombo").toString().trim()))
 			{
				msubj=mSubj;
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
<!--********DataComboFac***********-->
<%
try
{ 
	qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(A.SubjectID,' ') SubjectID,nvl(A.SubjectCode,' ') SubjectCode,nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from V#SRSEVENTS A Where  nvl(Deactive,'N')='N' ORDER BY  EMPLOYEENAME,subjectcode";
	rs=db.getRowset(qry);
	if (request.getParameter("DataComboFac")==null)
	{
		%>
		<select name='DataComboFac' id="DataComboFac" style="WIDTH:0px">	
		<%   
		while(rs.next())
		{
			mFacultyID=rs.getString("EMPLOYEEID");
			mDsub=rs.getString("SubjectID");
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
	out.println("");
}
%>
</td></tr>
<!--Faculty***********-->
<tr><td colspan=2><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Faculty</STRONG>&nbsp;&nbsp;</FONT></FONT>
<select name="Faculty" ID="Faculty" tabindex="0" style="WIDTH: 350px">
<%
if(request.getParameter("Faculty")==null)
{
qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID, ";
qry=qry+" nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from V#SRSEVENTS A Where  ";
qry=qry+"  nvl(Deactive,'N')='N' ORDER BY  EMPLOYEENAME";
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
qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID, ";
qry=qry+" nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from V#SRSEVENTS A Where  ";
qry=qry+"  nvl(Deactive,'N')='N' and A.SubjectID=decode('"+lpc1+"','ALL',A.SubjectID,'"+lpc1+"') order by employeename";
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
 <INPUT Type="submit" Value="Show/Refresh"></td>
 </tr>
 </table>
 </form>
<!--  <TABLE  rules=Rows cellSpacing=0 cellPadding=0 width="100%" border=1 > -->
<TABLE  align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1  border=1 >
<form name=frm1 method=post>
<thead>
<TR bgcolor="#ff8c00">
<td Title="Click on Program to Sort "><b><font color="white">Program</font></td>
<td Title="Click on Section/Subsection to Sort"><b><font color="white">Section-<br>Subsection</font></td>
<td Title="Click on Subject to Sort"><b><font color="white">Subject</font></td>
<td Title="Click on Faculty Name to Sort"><b><font color="white">Faculty Name </font></td>
<td Title="Click on LTP to Sort"><b><font color="white">LTP</font></td>
<td title='Click on Requested to sort table data' nowrap>
<table class="sort-table" id="table-2"  border=0 cellpadding=0 cellspacing=0 width="100%"><thead>
<tr bgcolor="#ff8c00"><td colspan=3><b><font color="white" >Requested</font></b></td></tr><tr bgcolor="#ff8c00"><td><b><font color="white" >L</font></b></td>
<td><b><font color="white" >T</font></b></td><td><b><font color="white" >P</font></b></td></tr></thead></table></td>
 <td title='Click on Responded to sort table data' nowrap>
<table class="sort-table" id="table-3"  border=0 cellpadding=0 cellspacing=0 width="100%"><thead>
<tr bgcolor="#ff8c00"><td colspan=3><b><font color="white" >Responded</font></b></td></tr><tr bgcolor="#ff8c00"><td><b><font color="white" >L</font></b></td>
<td><b><font color="white" >T</font></b></td><td><b><font color="white" >P</font></b></td></tr></thead></table></td>

<td title='Click on SRS Left to sort table data' >
<table align=center width=100% class="sort-table" id="table-4"  border=0 cellpadding=0 cellspacing=0><thead>
<tr bgcolor="#ff8c00"><td colspan=3 nowrap><b><font color="white" >SRS Left</font></b></td></tr><tr bgcolor="#ff8c00"><td><b><font color="white" >L</font></b></td>
<td><b><font color="white" >T</font></b></td><td><b><font color="white" >P</font></b></td></tr></thead></table></td>
</tr>
</thead>
<tbody>
 <%
//------------------

	msubj=request.getParameter("Subject").toString().trim();
	mfaculty=request.getParameter("Faculty").toString().trim();
	mpcode=request.getParameter("Program").toString().trim();
	msrseventcode=request.getParameter("Exam").toString().trim();
	
	qry="select Distinct ExamCode, FACULTYTYPE, A.EMPLOYEEID, PROGRAMCODE ,SECTIONBRANCH, SUBSECTIONCODE, SUBJECTID, SUBJECTCODE ";
	qry=qry+" FROM V#SRSEVENTS A where A.INSTITUTECODE='"+ mInst + "' and SRSEVENTCODE='"+msrseventcode+"'";
	qry=qry+" and A.EmployeeID=decode('"+mfaculty+"','ALL',A.EmployeeID,'"+mfaculty+"') ";
	qry=qry+" And A.PROGRAMCODE=decode('"+mpcode+"','ALL',A.PROGRAMCODE,'"+mpcode+"')";
	qry=qry+" And nvl(A.deactive,'N')='N' And A.SUBJECTID=decode('"+msubj+"','ALL',A.SUBJECTID,'"+msubj +"')  ";
	qry=qry+" Order By PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE, SUBJECTCODE";   
	  rs=db.getRowset(qry);
	  int kk=0;
	 while(rs.next())
	{
  /*
	****************LTP genertaion*******************
  */
	try {
		qry="select Distinct nvl(S.EMPLOYEEID,' ') EMPLOYEEID,'TRUE' mchk,nvl(Initials,' ')||nvl(E.EMPLOYEENAME,' ')||' ('||nvl(SHORTNAME,' ')||')' EMPLOYEENAME, nvl(LTP,' ')LTP from v#SRSEVENTSUGGESTION S, EmployeeMaster E ";
		qry=qry +" Where E.EmployeeID=S.EmployeeID and nvl(E.DEACTIVE,'N')='N' and nvl(s.deactive,'N')='N'";
		qry=qry+" and S.INSTITUTECODE='"+mInst+"' and S.FACULTYTYPE='"+rs.getString("FacultyType")+"' and S.EMPLOYEEID='"+rs.getString("EmployeeID")+"' and S.EXAMCODE='"+rs.getString("ExamCode")+"'";
		qry=qry+" and S.PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"' and  S.SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"'";
		qry=qry+" And SUBSECTIONCODE='"+rs.getString("SUBSECTIONCODE")+"' and S.SUBJECTID='"+rs.getString("SUBJECTID")+"'";
		qry=qry +" And (S.INSTITUTECODE, S.FACULTYTYPE, S.EMPLOYEEID, S.EXAMCODE, S.PROGRAMCODE, S.SECTIONBRANCH,SUBSECTIONCODE, S.SUBJECTID, S.SUBJECTCODE,S.LTP) ";
		qry=qry +" In (select INSTITUTECODE, FACULTYTYPE, EMPLOYEEID, EXAMCODE, PROGRAMCODE, SECTIONBRANCH,SUBSECTIONCODE, SUBJECTID, SUBJECTCODE,LTP  ";
		qry=qry+" from v#SRSEVENTS SS where  SRSEVENTCODE='"+ msrseventcode+"' And SUBJECTID='"+rs.getString("SUBJECTID")+"' and nvl(DEACTIVE,'N')='N')";
		rs2=db.getRowset(qry);
      	rs3=db.getRowset(qry);
		while (rs2.next())
	 	{  
   			if ((rs2.getString("mchk")).equals("TRUE"))	
	           	{
				mEmp1=rs2.getString("EMPLOYEEID");
				mEName=rs2.getString("EMPLOYEENAME"); 
			}
		}
     		mLTP="";
		myLTP="";
	  	while (rs3.next())
 		{
       	    ass=rs3.getString("EMPLOYEEID").toString().trim();
      	    if (ass.equals(mEmp1))
  			{	
	  	 	if (mLTP.equals(""))	
		   		{
				mLTP="'"+rs3.getString("LTP")+"'" ;
				myLTP=rs3.getString("LTP");
				}
			else 
	   			{
			 	 mLTP=mLTP+",'"+rs3.getString("LTP")+"'" ; 		
				 myLTP=myLTP+rs3.getString("LTP");
				}
	     	}    }
	}
	catch(Exception e)
	{
//	out.println("err"+qry);
	}
	if (!mLTP.equals(""))
	{
		kk++;
		qry="SELECT count(distinct studentid),LTP from v#STUDENTLTPDETAIL where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+rs.getString("EXAMCODE")+"'";
		qry=qry+" and  PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"'";
		qry=qry+" and SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"' and SUBSECTIONCODE='"+rs.getString("SUBSECTIONCODE")+"'";
		qry=qry+" and SUBJECTID='"+rs.getString("SUBJECTID")+"' and EmployeeID='"+rs.getString("EmployeeID")+"' and LTP in("+mLTP+") and nvl(deactive,'N')='N'";
		qry=qry+" group by subjectcode,ltp ";
		rs1=db.getRowset(qry);
		Ltot=0 ;
		Ttot=0 ;
		Ptot=0;
		while(rs1.next())
		{
			if(rs1.getString("LTP").equals("L"))
			Ltot=rs1.getLong(1);
			else if(rs1.getString("LTP").equals("P"))
			Ptot=rs1.getLong(1);
			else if(rs1.getString("LTP").equals("T"))
			Ttot=rs1.getLong(1);
		}
		try{
		qry="SELECT count(distinct studentid) mtot ,LTP from v#SRSEVENTSUGGESTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+rs.getString("EXAMCODE")+"'";
		qry=qry+" and SRSEVENTCODE='"+msrseventcode+"' and  PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"'";
		qry=qry+" and SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"' and SUBSECTIONCODE='"+rs.getString("SUBSECTIONCODE")+"'";
		qry=qry+" and SUBJECTID='"+rs.getString("SUBJECTID")+"' And LTP in ("+mLTP+") and nvl(deactive,'N')='N'";
		qry=qry+" Group by SubjectCode,LTP ";
		rs1=db.getRowset(qry);
		 mLtot=0 ;
		mTtot=0 ;
		mPtot=0;
		while(rs1.next())
		{
			if(rs1.getString("LTP").equals("L"))
			mLtot=rs1.getLong(1);
			else if(rs1.getString("LTP").equals("P"))
			mPtot=rs1.getLong(1);
			else if(rs1.getString("LTP").equals("T"))
			mTtot=rs1.getLong(1);
	
		}

		}
		catch(Exception e){}
	%>
		<TR>            
		<td><%=rs.getString("PROGRAMCODE")%></td>
 		<td><%=rs.getString("SECTIONBRANCH")%>-<%=rs.getString("SUBSECTIONCODE")%></td>
		<td><%=rs.getString("SUBJECTCODE")%></td>
		<td><%=mEName%></td>
		<td><%=GlobalFunctions.getSortedLTPSQ(mLTP)%></td>
		<td align=center>
		<table><tr><td><font size=2 face=Tahoma><%=Ltot%></font></td>
		<td><font size=2 face=Tahoma><%=Ttot%></font></td>
		<td><font size=2 face=Tahoma><%=Ptot%></font></td></tr></table>
		</td>
		<td align=center><table><tr>
		<td><a Title="SRS Submitted by Students" target=_New href="TotalSrsSubmitted.jsp?PROG=<%=rs.getString("PROGRAMCODE")%>&amp;SEC=<%=rs.getString("SECTIONBRANCH")%>&amp;SUBSEC=<%=rs.getString("SUBSECTIONCODE")%>&amp;SID=<%=rs.getString("SUBJECTID")%>&amp;SC=<%=rs.getString("SUBJECTCODE")%>&amp;LTP=<%=paraL%>&amp;EID=<%=ass%>"><font size=2 face=Tahoma><%=mLtot%></font></a></td>
		<td><a Title="SRS Submitted by Students" target=_New href="TotalSrsSubmitted.jsp?PROG=<%=rs.getString("PROGRAMCODE")%>&amp;SEC=<%=rs.getString("SECTIONBRANCH")%>&amp;SUBSEC=<%=rs.getString("SUBSECTIONCODE")%>&amp;SID=<%=rs.getString("SUBJECTID")%>&amp;SC=<%=rs.getString("SUBJECTCODE")%>&amp;LTP=<%=paraT%>&amp;EID=<%=ass%>"><font size=2 face=Tahoma><%=mTtot%></font></a></td>
		<td><a Title="SRS Submitted by Students" target=_New href="TotalSrsSubmitted.jsp?PROG=<%=rs.getString("PROGRAMCODE")%>&amp;SEC=<%=rs.getString("SECTIONBRANCH")%>&amp;SUBSEC=<%=rs.getString("SUBSECTIONCODE")%>&amp;SID=<%=rs.getString("SUBJECTID")%>&amp;SC=<%=rs.getString("SUBJECTCODE")%>&amp;LTP=<%=paraP%>&amp;EID=<%=ass%>"><font size=2 face=Tahoma><%=mPtot%></font></a></td>
		</tr></table>
		</td>
		
	<%	
			mLtotal=Ltot-mLtot;
			mTtotal=Ttot-mTtot;
			mPtotal=Ptot-mPtot;	
					
	%>
		<td align=center nowrap>
		<table><tr>
		<td><font size=2 face=Tahoma><a Title="SRS left by Students" target=_New href="TotalSrsLeft.jsp?PROG=<%=rs.getString("PROGRAMCODE")%>&amp;SEC=<%=rs.getString("SECTIONBRANCH")%>&amp;SUBSEC=<%=rs.getString("SUBSECTIONCODE")%>&amp;SID=<%=rs.getString("SUBJECTID")%>&amp;SC=<%=rs.getString("SUBJECTCODE")%>&amp;LTP=L&amp;EID=<%=ass%>"><%=mLtotal%></a></font></td>
		<td><font size=2 face=Tahoma><a Title="SRS left by Students" target=_New href="TotalSrsLeft.jsp?PROG=<%=rs.getString("PROGRAMCODE")%>&amp;SEC=<%=rs.getString("SECTIONBRANCH")%>&amp;SUBSEC=<%=rs.getString("SUBSECTIONCODE")%>&amp;SID=<%=rs.getString("SUBJECTID")%>&amp;SC=<%=rs.getString("SUBJECTCODE")%>&amp;LTP=T&amp;EID=<%=ass%>"><%=mTtotal%></a></font></td>
		<td><font size=2 face=Tahoma><a Title="SRS left by Students" target=_New href="TotalSrsLeft.jsp?PROG=<%=rs.getString("PROGRAMCODE")%>&amp;SEC=<%=rs.getString("SECTIONBRANCH")%>&amp;SUBSEC=<%=rs.getString("SUBSECTIONCODE")%>&amp;SID=<%=rs.getString("SUBJECTID")%>&amp;SC=<%=rs.getString("SUBJECTCODE")%>&amp;LTP=P&amp;EID=<%=ass%>"><%=mPtotal%></a></font></td>
		</tr></table>
		</td>
		</tr> 

	<%
		}
	}
%>
</form>
</tbody>
</TABLE>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number"]);
</script>
<%
	 //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed)</h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br><br><br>
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

<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle><br>

<br>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>