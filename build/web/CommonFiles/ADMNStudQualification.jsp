<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%

ResultSet  rs=null,Qrs=null;
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String Qqry="";
/*
	' 
*************************************************************************************************
	' *												
	' * File Name:	ADMNStudQualification.JSP		[For Admin]					
	' * Author:		Rituraj
	' * Date:		14th Feb 2007								
	' * Version:		1.0								
	' * Description:	Displays Qualifications Info. of Students 					
*************************************************************************************************
*/

String mHead="", mSID="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

if(request.getParameter("SID")==null ||request.getParameter("SID").toString().trim().equals(""))
	mSID="";
else
   	mSID=request.getParameter("SID").toString().trim();

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Qualification details ] </TITLE> 
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

 <script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<% 
String mSEMESTER  ="";
String mSname="",mFATHERNAME;

String mCOURSENAME ="",mBRANCHCODE="";
String mENROLLMENTNO ="", mInst="",mWebEmail="";
try{
// session.getAttribute("MemberID").toString().trim()
OLTEncryption enc=new OLTEncryption();
if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('24','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

if (session.getAttribute("InstituteCode")==null || session.getAttribute("InstituteCode").toString().equals(""))
   mInst="";
else
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}
//mInst=session.getAttribute("InstituteCode").toString().trim();
if (request.getParameter("INSCODE")==null)
{
	mInst ="";
}
else
{
	mInst =request.getParameter("INSCODE").toString().trim();
}

qry= " Select nvl(fathername,' ') fathername,nvl(ENROLLMENTNO, ' ') ENROLLMENTNO, ";
qry=qry +" nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
qry=qry +" nvl(SEMESTER,0) SEMESTER, nvl(studentname,' ') studentname from ";
qry=qry +" StudentMaster a Where a.StudentID='" +mSID+ "'" + " and InstituteCode='" + mInst + "' ";
//out.print(qry);
rs=db.getRowset(qry);
if ( rs.next())
{
mSEMESTER=rs.getString("SEMESTER");
mSname=rs.getString("studentname");
mCOURSENAME=rs.getString("PROGRAMCODE");
if (rs.getString("BRANCHCODE")==null) 
	mBRANCHCODE="";
else
	mBRANCHCODE=rs.getString("BRANCHCODE");
	
if (rs.getString("ENROLLMENTNO") ==null)
	mENROLLMENTNO="";
else
	mENROLLMENTNO=rs.getString("ENROLLMENTNO");

if (rs.getString("fathername")==null)
	mFATHERNAME="";
else
	mFATHERNAME=rs.getString("fathername");


%> 
<br>
 <font size=3 face='Arial'  color='#c00000'><b>Student Name: <%=GlobalFunctions.toTtitleCase(mSname) %> (<%=mENROLLMENTNO%>)<br>
 Father's Name : <%=GlobalFunctions.toTtitleCase(mFATHERNAME)%><br>
 Course-Branch : <%=mCOURSENAME%>( <%=mBRANCHCODE %>)<br>
 Semester	   : <%=mSEMESTER%></b></FONT>&nbsp;
<br>
<%

	Qqry="Select nvl(NameOfBoard,' ') NameOfBoard, nvl(ExamPassed,' ') ExamPassed, nvl(YearOfPassing,0) YearOfPassing, nvl(Division,' ') Division, nvl(MaxMarks,0) MaxMarks, nvl(MarksObtained,0) MarksObtained, ";
	Qqry = Qqry + " nvl(PercentOfMarks,0) PercentOfMarks, nvl(Grade,' ') Grade ";
	Qqry = Qqry + " From STUDENTQUALIFICATION Where StudentID ='" + mSID+ "' order by YearOfPassing desc";
		    
 	//out.print(SID);
   
	Qrs=db.getRowset(Qqry);	
      %>
	<BR><CENTER><STRONG><FONT color=black face=Arial size=2>QUALIFICATION DETAILS</FONT></STRONG></CENTER>

	 <table class="sort-table" id="TblStdView" width=100% bgcolor=#fce9c5 class="sort-table" id="table-1" border=1 cellpadding=0 cellspacing=0 style="face=Arial;size=2">
	 <tr bgcolor="#ff8c00">
	  <TH><font color=white><b>Name of Board</b></font></TH>
	  <TH><font color=white><b>Exam Passed</b></font></TH>
	  <TH><font color=white><b>Year of Passing</b></font></TH>
	  <TH><font color=white><b>Division</b></font></TH>
	  <TH><font color=white><b>Max Marks</b></font></TH>
	  <TH><font color=white><b>Marks Obtained</b></font></TH>
	  <TH><font color=white><b>% of Marks</b></font></TH>
	  <TH><font color=white><b>Grade</b></font></TH>
	  </tr>
	  
	  <%
  	 while (Qrs.next())
	 {
	%>
      <tr>
		<td><%=Qrs.getString("NameOfBoard")%></td>
		<td><Font face=Arial size=2><%=Qrs.getString("ExamPassed")%></font></td>
		<td><%=Qrs.getString("YearOfPassing")%></td>
		<td><%=Qrs.getString("Division")%></td>
		<td align=right><%=Qrs.getString("MaxMarks")%></td>
		<td align=right><%=Qrs.getString("MarksObtained")%></td>
		<td align=right><%=Qrs.getString("PercentOfMarks")%></td>
		<td align=center><%=Qrs.getString("Grade")%></td>
      </tr>
	
    <%
    }
   %>
	</TABLE><BR><BR><BR>
  <%
  }
else
{
%>
<P><FONT face=Arial size="2"><FONT color=black>Name</FONT><FONT 
	color=crimson>:&nbsp;&nbsp; </FONT><FONT color=black>Profile not found</FONT></FONT></P>
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
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
   <%
	
	
   }
  //-----------------------------


}
else
{
%>
<br>
Session timeout! Please <a href="../index.jsp">Login</a> to continue...
<%
}
}
catch(Exception e)
{
out.print("Unable to find profile...");
}
%>
<center>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table></body>
</Html>