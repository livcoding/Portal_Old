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
ResultSet rs=null,rs1=null;

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

if (request.getParameter("Exam").toString().trim()==null)
	{
		mExamcode="";
	}
	else
	{	
		mExamcode=request.getParameter("Exam").toString().trim();
	}

if (request.getParameter("PreEvent").toString().trim()==null)
	{
		mPreEvent="";
	}
	else
	{	
		mPreEvent=request.getParameter("PreEvent").toString().trim();
	}


try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
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
		out.println(e.getMessage());
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

%>
<form name="frm" method=get>
<input id="x" name="x" type=hidden>


<center><b>List of Subject/Choice for Regular Semester</b></center>

            <input type=hidden name="Examcode" id="Examcode" value="<%=mExamcode%>">
            <input type=hidden name="PreEvent" id="PreEvent" value="<%=mPreEvent%>">

 <table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
<thead>
<tr bgcolor="#ff8c00">
  <td><b><font color=white>SNo.</font></b></td>
  <td><b><font color=white>Elective Type</font></b></td>	
  <td><b><font color=white>Subject</font></b></td>
  <td><b><font color=white>Choice</font></b></td>
  <td><b><font color=white>Status</font></b></td>
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

	qry="select nvl(SENDTOHOD,' ') SENDTOHOD  from PREVENTS where PREVENTCODE='"+mPreEvent+"'and MEMBERTYPE='"+mChkMType+"' and MEMBERID='"+mMemberID+"'";
	rs=db.getRowset(qry);
	while(rs.next())
	{
	mSENDTOHOD=rs.getString("SENDTOHOD");
	}

	qry="select DISTINCT nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+"nvl(B.CHOICE,'') CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,nvl(B.ELECTIVECODE,'') ELECTIVECODE,";
	qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE, nvl(B.SEMESTERTYPE,'')SEMESTERTYPE  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
	qry=qry+" Where B.examcode='"+mExamcode+"' and B.institutecode='"+mINSTITUTECODE+"'";
	qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID ";
	qry=qry+" order by SUBJECT, CHOICE,SUBJECTRUNNING,ELECTIVECODE,SUBJECTTYPE,SEMESTERTYPE  ";
	
	//out.print(qry);	
	rs1=db.getRowset(qry);
	msno=0;
      msno1=0;
	while(rs1.next())
	{
       	msno1++;
	      mSemtype=rs1.getString("SEMESTERTYPE");
	 	if(mSemtype.equals("REG"))
		{
            msno++ ;
	%>
	   	<tr>
		<td><%=msno%></td>
		<%
			/*if(rs1.getString("SUBJECTTYPE").equals("F"))
				mSubtype="Free";
			else
				mSubtype=rs1.getString("ELECTIVECODE");	
	*/

			if(rs1.getString("SUBJECTTYPE").equals("F"))
				mSubtype="Free";
			else
			if(rs1.getString("SUBJECTTYPE").equals("E"))
				mSubtype="Elective";
			else
				mSubtype="Core";	

			%>

		<td><%=mSubtype%></TD>
		<td><%=rs1.getString("SUBJECT")%></td>
		<td><%=rs1.getString("CHOICE")%></TD>
<%
		if(mSENDTOHOD.equals("Y"))
				msg="Sent";
					else
				msg="Not Sent";
					%>
				<td><%=msg%></td>

		</tr>	

    		<%
	}

	
}	
%>
</tbody>
		</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
</script>

<%
if(msno1>msno)
{
%>

<br>
<center><b>List of Choice for Back Log Papers</b></center>


   <table bgcolor=#fce9c5 class="sort-table" id="table-2" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
	<thead>
	<tr bgcolor="#ff8c00">
  <td><b><font color=white>SNo.</font></b></td>
  <td><b><font color=white>Elective Type</font></b></td>	
  <td><b><font color=white>Subject</font></b></td>
  <td><b><font color=white>Choice</font></b></td>
  <td><b><font color=white>Status</font></b></td>
  </tr>
</thead>
	<tbody>

<%

	qry="select DISTINCT nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+"nvl(B.CHOICE,'') CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,nvl(B.ELECTIVECODE,'') ELECTIVECODE,";
	qry=qry+"nvl(B.SUBJECTTYPE,' ')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
	qry=qry+" where B.examcode='"+mExamcode+"' and B.institutecode='"+mINSTITUTECODE+"'";
	qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID order by SUBJECT";

	//out.print(qry);
	rs1=db.getRowset(qry);
	msno=0;
	while(rs1.next())
	{
		
       	
	      mSemtype=rs1.getString("SEMESTERTYPE");
           	if(mSemtype.equals("RWJ"))
		{
		msno++ ;

	%>
	   <tr>
		<td><%=msno%></td>	
<%

			if(rs1.getString("SUBJECTTYPE").equals("F"))
				mSubtype="Free";
			else
			if(rs1.getString("SUBJECTTYPE").equals("E"))
				mSubtype="Elective";
			else
				mSubtype="Core";	
	
			%>
		<td><%=mSubtype%></TD>
		<td><%=rs1.getString("SUBJECT")%></td>
		<td><%=rs1.getString("Choice")%></TD>
		<%
		if(mSENDTOHOD.equals("Y"))
			msg="Sent";
		else
			msg="Not Sent";
		%>
		<td><%=msg%></td></tr>	


	   
    <%
	}
}
%>
</tbody>
</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-2"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
</script>

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
  }   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	
}
%>
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









