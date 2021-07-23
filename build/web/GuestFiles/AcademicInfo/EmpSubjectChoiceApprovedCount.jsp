<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
String mI="";
String mE="";
GlobalFunctions gb =new GlobalFunctions();
String mL="",mT="",mP="",mCurPRCode="";
String qry="";
String qry1="";
String x="",t="",mfactype="";
int ctr=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mExam="", mexam="";
String mProgSecBr="", mProgsecbr="";
String mProg="", mSecBr="";
String mLTP="";
String mSubj="";
int kk1=0;


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
<TITLE>#### <%=mHead%> [ View Submitted Subject Choices and Preferences] </TITLE>
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

	if(mDMemberType.equals("E"))
	{
		 mfactype="I";	
	}
	else if(mDMemberType.equals("V"))
	{
		 mfactype="E";
	}
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('51','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{

	mI=mInstitute;


  //----------------------
		qry= " Select 'y', PREVENTCODE from PREVENTS WHERE INSTITUTECODE='"+ mInstitute +"' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInstitute +"'";
		qry=qry+ " and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='E'";
		qry=qry+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='E' and MEMBERID='"+mDMemberID+"'";
		qry=qry+" and nvl(DEACTIVE,'N')='N'";
		//qry=qry+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO)";
		
		rs=db.getRowset(qry);
		if(rs.next())
		{		
		mCurPRCode=rs.getString("PREVENTCODE");
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Approved Elective Subject Preferences Count</b></TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<!--*********Exam**********-->
<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
&nbsp; &nbsp;
<%
try
{
qry="Select  nvl(PREREGEXAMID,' ')Exam from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mInstitute+"'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mE.equals(""))
 			mE=mExam;
			%>
			<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mE=mExam;
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
<!--*********Exam**********-->
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Program Code [Section-Branch]</STRONG></FONT></FONT>
&nbsp; &nbsp;
<%
try
{
	qry="Select distinct nvl(PROGRAMCODE,' ')||'['|| nvl(SECTIONBRANCH,' ') ||']' ProgSecBr from PR#ELECTIVESUBJECTS ORDER BY ProgSecBr";
	rs=db.getRowset(qry);
	%>
	<select name="ProgSecBr" tabindex="0" id="ProgSecBr" style="WIDTH: 120px">
	<%
	if (request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mProgSecBr=rs.getString("ProgSecBr");
			if(mProgsecbr.equals(""))
 			mProgsecbr=mProgSecBr;
			%>
			<OPTION Value =<%=mProgSecBr%>><%=mProgSecBr%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		while(rs.next())
		{
			mProgSecBr=rs.getString("ProgSecBr");
			if(mProgSecBr.equals(request.getParameter("ProgSecBr").toString().trim()))
 			{
				mProgsecbr=mProgSecBr;
				%>
				<OPTION selected Value =<%=mProgSecBr%>><%=mProgSecBr%></option>
				<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value=<%=mProgSecBr%>><%=mProgSecBr%></option>
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
<INPUT Type="submit" Value="&nbsp;OK&nbsp;">
</td>
</tr>
</table>
</form>
<%
	if (request.getParameter("InstCode")!=null)
		mI=request.getParameter("InstCode").toString().trim();
	else
		mI="";

	if (request.getParameter("Exam")!=null)
		mE=request.getParameter("Exam").toString().trim();
	else
		mE="";
	if (request.getParameter("ProgSecBr")!=null)
		mProgsecbr=request.getParameter("ProgSecBr").toString().trim();
	else
		mProgsecbr="";

	if(!mProgsecbr.equals(""))
	{
		int mlen=0, mpos1=0, mpos2=0;
		mlen=mProgsecbr.length();
		mpos1=mProgsecbr.indexOf("[");
		mpos2=mProgsecbr.indexOf("]");
		mProg=mProgsecbr.substring(0,mpos1);
		mSecBr=mProgsecbr.substring(mpos1+1,mpos2);
	}
	try
	{

	qry="Select Subjectid, Count(Subjectid) Total From";
	qry=qry+" (Select StudentID, Subjectid From Pr#StudentSubjectChoice A";
	qry=qry+" Where Choice = (Select Min(Choice) From PR#StudentSubjectChoice ";
	qry=qry+" Where Subjectid IN(select Subjectid from PR#ElectiveSubjects where ExamCode='"+mE+"' and ProgramCode='"+mProg+"' and SECTIONBRANCH='"+mSecBr+"' and SUBJECTRUNNING='Y') And StudentID = A.StudentID )";
	qry=qry+" and ExamCode='"+mE+"' and ProgramCode='"+mProg+"' and SECTIONBRANCH='"+mSecBr+"')";
	qry=qry+" Group By Subjectid Having Subjectid in";
	qry=qry+" (select Subjectid from PR#ElectiveSubjects where ExamCode='"+mE+"' and ProgramCode='"+mProg+"' and SECTIONBRANCH='"+mSecBr+"' and SUBJECTRUNNING='Y')";
	qry=qry+" Order By Subjectid";

	rs1=db.getRowset(qry);
	//out.print(qry);
	if(rs1.next())
	{
	%>
	<TABLE rules=ALL align=center cellSpacing=0 cellPadding=0 border=1 >
	<tr bgcolor='#ff8c00'>
	 <td><b><font color="white">SNo.</font></td>
	 <td><b><font color="white">Subject</font></td>
	 <td><b><font color="white" title="Total Student whose Preferences were same as Approved">Total Student</font></td>
	</tr>
	<%
	   while(rs1.next())
	   {  	
		qry="select subject,subjectcode from subjectmaster where Subjectid='"+rs1.getString("Subjectid")+"'";
		rs=db.getRowset(qry);
		rs.next();
		kk1++;
		%>	
		<tr>
		  <td><%=kk1%>.</td>
		  <td><%=rs.getString("subject")%> [<%=rs.getString("subjectcode")%>]</td>
		  <td align=right><%=rs1.getInt("Total")%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </td>
	      </tr>
	      <%
	   } //closing of while
	}
	else
	{
		%>
		<CENTER><font color=red><h3><br><img src='../../Images/Error1.jpg'> No Record Found...</FONT></CENTER>
		<%
     	}
	%>
	</table>
	<%
	} //closing of try
	catch(Exception e)
	{
	}	
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
  	}
	else
	{
		%>
		<font color=red>
		<h3><br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
		<%
      	}
	}
	else
	{
		%>
		<br>
		<font color=red>
		<h3><br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
		<P>This page is not authorized/available for you.
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
</body>
</html>