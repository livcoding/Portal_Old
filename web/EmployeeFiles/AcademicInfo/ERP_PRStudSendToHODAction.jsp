<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Pre-Registration choice Send To HOD ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>


<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

DBHandler db=new DBHandler();
double mCCP=0;
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="";
int msno=0,msno1=0;
String mSem="";
int mSemPlusOne=0;
String mExamcode="",mProg="",mBranch="",mName="";
String mINSTITUTECODE="";
String mSUBJECTID="",msg="";
String mSemtype="",mSubtype="",mPreEvent="",mSENDTOHOD="";
ResultSet rs=null,rs1=null, rsCCP=null,Rsd1=null;
double sumcrt=0;
String mysum="";
String studRoll="",mSubSect="";

if (request.getParameter("mysumm")==null)
{
	 mysum="";
}	 
else
{
	mysum=request.getParameter("mysumm").toString().trim();
}


 
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
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
if (session.getAttribute("InstituteCode")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";

}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
	mSemPlusOne=(Integer.parseInt(mSem))+1;
}

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}

if (request.getParameter("ExamCode").toString().trim()==null)
	{
		mExamcode="";
	}
	else
	{	
		mExamcode=request.getParameter("ExamCode").toString().trim();
	}

if (request.getParameter("PREVENTCODE").toString().trim()==null)
	{
		mPreEvent="";
	}
	else
	{	
		mPreEvent=request.getParameter("PREVENTCODE").toString().trim();
	}


try 
{  //1String studRoll="";
		if(request.getParameter("studentEnRoll")==null)
			studRoll="";
		else
			studRoll=request.getParameter("studentEnRoll");
		%> <INPUT TYPE="hidden" NAME="studentEnRoll" value="<%=studRoll%>"><%		
		//out.println("jjj:-"+studRoll);
		qry="select Studentid,studentname,semester from studentmaster where ENROLLMENTNO='"+studRoll+"'";
		// out.println(qry);
		ResultSet RsChk1= db.getRowset(qry);
		if(RsChk1.next())
		{
			mMemberID=RsChk1.getString("studentid");
			mMemberType="S";
			mMemberName=RsChk1.getString("studentname");
			mSem=RsChk1.getString("semester");
		}
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	/*String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());*/
	ResultSet RsChk=null;
	String mChkMemID=mMemberID;
	String mChkMType=mMemberType;
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole="STUD";
	qry=" SELECT nvl(SUBSECTIONCODE,' ')SUBSECTIONCODE FROM STUDENTMASTER WHERE STUDENTID='"+mChkMemID+"'";
	Rsd1=db.getRowset(qry);
	if(Rsd1.next())
	{
		mSubSect=Rsd1.getString(1);
	}
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('52','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	try
	{	

		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		//out.println("asdsad"+e.getMessage());
	}
 //----------------------
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();


if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------
String mExamDesc="";
qry="SELECT EXAMDESCRIPTION FROM EXAMMASTER where INSTITUTECODE='"+mINSTITUTECODE+"' and EXAMCODE='"+mExamcode+"' ";
rs=db.getRowset(qry);
if(rs.next())
		   {
				mExamDesc=rs.getString("EXAMDESCRIPTION");
		   }
%>

<input id="x" name="x" type=hidden>
	
		<table border=0 width ="68%" align="center">
		<tr>
		<br>
		<td>
			<B>Name: </B><%=mMemberName%>
		</td>
		<td>
		<B>Enrollment No.: </B> <%=studRoll%>
		</tD>
		</tr>
		<%
String pc="",bc="",sc="",SectionB="";
			qry=" Select distinct  nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE,sectionbranch ,";
			qry=qry+" SEMESTER SEMESTER from ";
			qry=qry+" STUDENTREGISTRATION where StudentID='" +mMemberID+ "' and examcode='"+mExamcode+"' and  InstituteCode='" + mINSTITUTECODE + "'  ";
			rs=db.getRowset(qry);
 			//out.print(qry);
			
			
			if (rs.next())
			{
				
				pc=rs.getString("PROGRAMCODE");
				bc=rs.getString("BRANCHCODE");
				sc=rs.getString("SEMESTER");		
				SectionB=rs.getString("sectionbranch");
			
			}
		%>
		<tr>
		<td>
			<B>Program Code:</B> <%=pc%>
		</td>
		<td>
		 <B>Branch Code: </B><%=bc%>
		</tD>
		</tr>
		<tr>
		<td>
			<B>Semester: </B> <%=sc%>
		</td>
		<%
	qry="Select to_char(Sysdate,'dd-mm-yyyy hh:mi PM')date1 from Dual";	
		rs=db.getRowset(qry);
 			//out.print(qry);
			
			
			if (rs.next())
			{
				%>
				<td><b> Run Date :</b>  <%=rs.getString("date1")%></td>
				<%
			}
		%>		</tr>
		
	</table>
		


<BR>
<center><b>PRIORITY OF SUBJECT CHOICES SUBMITTED FOR   <%=mExamDesc%></b></center>

            <input type=hidden name="Examcode" id="Examcode" value="<%=mExamcode%>">
            <input type=hidden name="PreEvent" id="PreEvent" value="<%=mPreEvent%>">

 <table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
<thead>
<tr bgcolor="#ff8c00">
  <td><b><font color=white>SNo.</font></b></td>
  <td><b><font color=white>Course Type</font></b></td>	
  <td><b><font color=white>Subject</font></b></td>
  <td><b><font color=white>Priority</font></b></td>
  <td><b><font color=white>Credit</font></b></td>
  </tr>
</thead>
	<tbody>

	<%	
qry="Update PREVENTS set SENDTOHOD='Y',SENTBY='"+mMemberID+"',SENTDATE=sysdate";
qry=qry +" where institutecode='"+mINSTITUTECODE+"' and PREVENTCODE='"+mPreEvent+"'and MEMBERID='"+mMemberID+"'and MEMBERTYPE='"+mChkMType+"'";
int n=db.update(qry);
		if(n>0)
		{
	  	    // Log Entry
		    //-----------------
		    db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"Pre-Registration Subject Choices Send To HOD", "ExamCode: "+mExamcode,"NO MAC Address",mIPAddress);
	 	   //-----------------
	      }		

qry="select nvl(SENDTOHOD,' ') SENDTOHOD  from PREVENTS where PREVENTCODE='"+mPreEvent+"'and MEMBERTYPE='"+mChkMType+"' and MEMBERID='"+mMemberID+"' ";

	rs=db.getRowset(qry);
	//out.print(qry);
	while(rs.next())
	{
	mSENDTOHOD=rs.getString("SENDTOHOD");
	}

qry="select DISTINCT nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
qry=qry+"nvl(B.CHOICE,0) CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,decode(B.subjecttype,'C','Core','E','Elective')ELECTIVECODE, ";
qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE,nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B,PROGRAMSCHEME C";
qry=qry+" where B.examcode='"+mExamcode+"' And a.subjectid=c.subjectid and b.subjectid=c.subjectid  And B.SemesterType='REG' and B.institutecode='"+mINSTITUTECODE+"'";
qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID AND A.INSTITUTECODE=C.INSTITUTECODE AND C.ACADEMICYEAR=B.ACADEMICYEAR AND C.SECTIONBRANCH=B.SECTIONBRANCH AND C.TAGGINGFOR=B.TAGGINGFOR AND C.SEMESTER=B.SEMESTER   order by SUBJECT ,ELECTIVECODE ";
 
rs1=db.getRowset(qry);
msno=0;
msno1=0;
while(rs1.next())
   {
      msno1++;
      mSubtype=rs1.getString("ELECTIVECODE");	
      msno++ ;
	%>
   	<tr bgcolor='lightgrey'>
	<td><%=msno%></td>
	<td><%=mSubtype%></TD>
	<td><%=rs1.getString("SUBJECT")%></td>
	<td><%=rs1.getString("CHOICE")%></TD>
	<td><%=rs1.getString("COURSECREDITPOINT")%> </td>
	<%	
	sumcrt=sumcrt+rs1.getDouble("COURSECREDITPOINT");
	%>
	</tr>
  	<%
	}


qry="select DISTINCT nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT,decode(c.ELECTIVECODE,'PD',1,'DE',2,c.ELECTIVECODE) type, ";
qry=qry+"nvl(B.CHOICE,0) CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,decode(c.ELECTIVECODE,'PD','Elective(PD)','DE','Elective',c.ELECTIVECODE)ELECTIVECODE, ";
qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE,nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C";
qry=qry+" where B.examcode='"+mExamcode+"'   And a.subjectid=c.subjectid and b.subjectid=c.subjectid And B.SemesterType='REG' and B.institutecode='"+mINSTITUTECODE+"' And C.examcode='"+mExamcode+"' and C.institutecode='"+mINSTITUTECODE+"'";
qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID AND A.INSTITUTECODE=C.INSTITUTECODE AND C.ACADEMICYEAR=B.ACADEMICYEAR AND C.SECTIONBRANCH=B.SECTIONBRANCH AND C.TAGGINGFOR=B.TAGGINGFOR AND C.SEMESTER=B.SEMESTER   order by type,choice ";
rs1=db.getRowset(qry);
//out.print(qry);
while(rs1.next())
     {
	if(rs1.getString("type").equals("1")){
		%><tr bgcolor='lightyellow'><%
	}else if(rs1.getString("type").equals("2")){
			%><tr bgcolor='white'><%
	}else{
				%><tr bgcolor='white'><%
	}
	%>
	   	
		
		
		<td><%=++msno%></td>
		<%		 
		mSubtype=rs1.getString("ELECTIVECODE");	
	
			%>

		<td><%=mSubtype%></TD>
		<td><%=rs1.getString("SUBJECT")%></td>
		<td><%=rs1.getString("CHOICE")%></TD>
		<td><%=rs1.getString("COURSECREDITPOINT")%> </td>
		<%
		//mCourseCrPt=
		sumcrt=sumcrt+Double.parseDouble(rs1.getString("COURSECREDITPOINT"));
		%>
		</tr>	

    		<%
	
	}	





%>
</tbody>
		</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
</script>

<br>

<center><b>LIST OF BACKLOG PAPER REGISTERED </b></center>
<table bgcolor=#fce9c5 class="sort-table" id="table-2" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
<thead>
<tr bgcolor="#ff8c00">
<td><b><font color=white>SNo.</font></b></td>
<td><b><font color=white>Course Type</font></b></td>	
<td><b><font color=white>Subject</font></b></td>
<td><b><font color=white>Priority</font></b></td>
<td><b><font color=white>Credit</font></b></td>
</tr>
</thead>
<tbody>
<%
qry="select DISTINCT a.SubjectID SubjectID, nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT  ,";
qry=qry+"nvl(B.CHOICE,0) CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,decode(B.subjecttype,'C','Core','E','Elective')ELECTIVECODE, ";
qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE   from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
qry=qry+" where B.examcode='"+mExamcode+"' and B.institutecode='"+mINSTITUTECODE+"' And b.semestertype in ('RWJ','SAP') ";
qry=qry+" and B.studentid='"+mMemberID+"' And B.SUBJECTTYPE='C' and  A.subjectID=B.subjectID  ";
//out.print(qry);
	rs1=db.getRowset(qry);
	msno=0;
	while(rs1.next())
	{
	msno++ ;
	qry="select max(COURSECREDITPOINT)COURSECREDITPOINT from (Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT From PROGRAMSUBJECTTAGGING C where examcode='"+mExamcode+"'  And subjectid='"+rs1.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mINSTITUTECODE+"'";
	qry=qry+" UNION Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT   From OfferSubjectTagging C where examcode='"+mExamcode+"'  And subjectid='"+rs1.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mINSTITUTECODE+"')";
	//out.print(qry);
	rsCCP=db.getRowset(qry);
	if (rsCCP.next())
	{
		mCCP=rsCCP.getDouble("COURSECREDITPOINT");
	}
	else
	{
		mCCP=0;
	}
	mSubtype=rs1.getString("ELECTIVECODE");
	%>
	<tr bgcolor='#FFB9B9'>
        <td><%=msno%></td>		
	<td><%=mSubtype%></TD>
	<td><%=rs1.getString("SUBJECT")%></td>
	<td><%=rs1.getString("Choice")%></TD>
	<td><%=mCCP%></td></tr>		   
 	<%
	sumcrt=sumcrt+mCCP;
	}


qry= "select DISTINCT nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
qry=qry+"nvl(B.CHOICE,0) CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,decode(B.subjecttype,'C','Core','E','Elective')ELECTIVECODE, ";
qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE, nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B,PR#ELECTIVESUBJECTS C";
qry=qry+" where B.SUBJECTTYPE<>'C' and  B.examcode='"+mExamcode+"' and B.institutecode='"+mINSTITUTECODE+"' And b.semestertype in('RWJ','SAP') And a.subjectid=b.subjectid and b.subjectid=c.subjectid And c.examcode='"+mExamcode+"' and c.institutecode='"+mINSTITUTECODE+"' ";
qry= qry + " And C.examcode='"+mExamcode+"' and C.institutecode='"+mINSTITUTECODE+"'";
qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID AND A.INSTITUTECODE=C.INSTITUTECODE AND C.ACADEMICYEAR=B.ACADEMICYEAR AND C.SECTIONBRANCH=B.SECTIONBRANCH AND C.TAGGINGFOR=B.TAGGINGFOR AND C.SEMESTER=B.SEMESTER  order by SUBJECT,ELECTIVECODE ";

//out.print(qry);
	rs1=db.getRowset(qry);
	msno=0;
	while(rs1.next())
	{
        msno++ ;
	mSubtype=rs1.getString("ELECTIVECODE");
	%>
	<tr bgcolor='#FFB9B9'>
	<td><%=msno%></td>	
	<td><%=mSubtype%></TD>
	<td><%=rs1.getString("SUBJECT")%></td>
	<td><%=rs1.getString("Choice")%></TD>
	<td><%=rs1.getString("COURSECREDITPOINT")%></td></tr>	
		   
	<%
	sumcrt=sumcrt+Double.parseDouble(rs1.getString("COURSECREDITPOINT"));

	}

%>

</tbody>



</table>	

<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-2"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
</script>
	<table width="100%" align=cetner>
	<tr>
<td  align="center"><font color="green" face=verdana size=3><b>Total Course Credit Point : <%=mysum%></b></font></td>
</tr>
	</table>
	
	<br>

<!--	<form method=post name="frmmm" action="SaveFinalPreg.jsp">-->

		<input type="hidden" name='sum' value='<%=mysum%>'>
		<input type="hidden" name='studentID' value='<%=mMemberID%>'>
		<input type="hidden" name='examcode' value='<%=mExamcode%>'>
		<input type="hidden" name='instituteCode' value='<%=mINSTITUTECODE%>'>
		<input type="hidden" name='PreEvent' value='<%=mPreEvent%>'>
		<input type="hidden" name='secbranch' value='<%=SectionB%>'>
		<input type="hidden" name='programcode' value='<%=pc%>'>
		<input type="hidden" name='semester' value='<%=sc%>'>
	<center>
<INPUT TYPE="button" name="Print" Value="Click to Print"  onClick="window.print();">

	<!--<INPUT TYPE="Submit" name="Save" Value="Save" >-->
     
	
		
	</center>
</form>
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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br> 
   <%
	}
    		 //-----------------------------
  }   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
out.print(e);
}
%>
<br><br>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>

</form></body>
</html>









