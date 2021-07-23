<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="";
int ctr=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="",mfactype="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mExam="";
String mName1="",mName2="",mName3="",mName4="",mName5="";
String mSubj="",mSubjID="",mELECTIVECODE="";
String mSubjType="", mSubjectType="";
String mWebEmail="";

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
 
if (request.getParameter("EXAM").toString().trim()==null)
{
	mExam="";
}
else
{	
	mExam=request.getParameter("EXAM").toString().trim();
}

if (request.getParameter("STYPE").toString().trim()==null)
{
	mSubjType="";
}
else
{	
	mSubjType=request.getParameter("STYPE").toString().trim();
}

if (request.getParameter("SUBJCODE").toString().trim()==null)
{
	mSubj="";
}
else
{	
	mSubj=request.getParameter("SUBJCODE").toString().trim();
}

if (request.getParameter("SUBJID").toString().trim()==null)
{
	mSubjID="";
}
else
{	
	mSubjID=request.getParameter("SUBJID").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Back Log Paper Approval/Finalization by DOAA ] </TITLE>
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
	OLTEncryption enc=new OLTEncryption();

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInstitute=rs.getString(1);	
		else
			mInstitute="JIIT";

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	  
		qry="Select WEBKIOSK.ShowLink('112','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Back Log Paper Approval/Finalization [Pre Registration]</b></font></td></tr>
			</TABLE>

			<%
			String mEnm="";
			qry="select EmployeeName from EmployeeMaster where EmployeeID='"+mChkMemID+"'";
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mEnm=rs1.getString(1);
			}
			if(mSubjType.equals("Core"))
				mSubjectType="C";
			else if(mSubjType.equals("Elective"))
			{
				mSubjectType="E";
				qry="Select nvl(ElectiveCode,' ')ECode from PR#STUDENTSUBJECTCHOICE where subjectid='"+mSubjID+"'";
				rs1=db.getRowset(qry);
				if(rs1.next())
				mELECTIVECODE=rs1.getString("ECode");
			}
			else if(mSubjType.equals("Free Elective"))
				mSubjectType="F";
			%>
			<!--<table width=100%><tr><td align=right> &nbsp; &nbsp; &nbsp;<a href='PRRegBackPaperFinalDOAA.jsp'><font color=GREEN><b>Back...</b></font></a> &nbsp; &nbsp; &nbsp;</td></tr></table>-->
			<%
			if(mELECTIVECODE.equals(""))
			{
			%>
			<center><font color="#00008b">Exam Code: <b><%=mExam%></B> &nbsp; &nbsp;Subject Type: <b><%=mSubjType%></B> &nbsp; &nbsp;Subject Code: <b><%=mSubj%></B></font></center>
			<%
			}
			else
			{
			%>
			<center><font color="#00008b">Exam Code: <b><%=mExam%></B> &nbsp; &nbsp;Subject Type: <b><%=mSubjType%> [<%=mELECTIVECODE%>]</B> &nbsp; &nbsp;Subject Code: <b><%=mSubj%></B></font></center>
			<%
			}
			%>
			<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
			<form name="frm1" ID="frm1" method=post>
			<%
				if(mDMemberType.equals("E"))
					 mfactype="I";	
				else if(mDMemberType.equals("V"))
					 mfactype="E";
				%>	
				<tr bgcolor='#e68a06'>
				 <th><font color="#00008b">SNo.</font></th>
				 <th><font color="#00008b">Student</font></th>
				 <th><font color="#00008b">Acad. Year</font></th>
				 <th><font color="#00008b">Program</font></th>
				</tr>
				<%
				qry="select distinct nvl(B.STUDENTID,' ')StdID, nvl(A.SUBJECT,' ') SUBJECT, nvl(A.SUBJECTCODE,' ') SC, nvl(B.ACADEMICYEAR,' ')AY, nvl(B.PROGRAMCODE,' ')Prog, decode(B.SUBJECTRUNNING,'Y','Yes','No') SRUN, nvl(C.STUDENTNAME,' ')||' ('|| nvl(C.ENROLLMENTNO,' ')||')' StdName from SUBJECTMASTER A, PR#STUDENTSUBJECTCHOICE B, STUDENTMASTER C ";
				qry=qry+" where A.SUBJECTID=B.SUBJECTID AND B.SUBJECTTYPE='"+mSubjectType+"' And B.INSTITUTECODE='"+mInstitute+"' and B.EXAMCODE='"+mExam+"' and B.SUBJECTID='"+mSubjID+"'";
				qry=qry+" AND B.SEMESTERTYPE='RWJ' And (b.INSTITUTECODE,b.EXAMCODE) in (Select E.INSTITUTECODE, E.ExamCode from PREVENTMASTER E Where E.EXAMCODE='" + mExam+ "' and nvl(E.DEACTIVE,'N')='N')";
				qry=qry+" and nvl(B.DEACTIVE,'N')='N' AND B.STUDENTID=C.STUDENTID AND B.INSTITUTECODE=C.INSTITUTECODE";
				rs=db.getRowset(qry);
				//out.print(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					ctr++;
					%>
					<tr bgcolor='white'>
					<td align=right><%=ctr%>.&nbsp; &nbsp;</td>
					<td><%=GlobalFunctions.toTtitleCase(rs.getString("StdName"))%></td>
					<td align=center><%=rs.getString("AY")%></td>
					<td align=center><%=rs.getString("Prog")%></td>
					<%
				}
			%>
			</form>
			</TABLE>
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
<br><br>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>