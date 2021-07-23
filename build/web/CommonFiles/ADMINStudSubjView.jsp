<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="",mSID="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Opted Subjects ] </TITLE> 
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
	' 
*************************************************************************************************
	' *												
	' * File Name:	PRStudentAction.JSP		[For Students]					
	' * Author:		Ashok
	' * Date:		24th Nov 2006								
	' * Version:		1.0								
	' * Description:	Pre Registration of Students
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="",qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="";
int msno=0;
String mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mSem="",mName="",mAcadmeicYear="";
String mINSTITUTECODE="";
String mEmployeeID="";
String mSUBJECTCODE="";
String mEName="";
ResultSet rs=null,rs1=null,rs2=null;
double mTotalCrLmtTkn=0;

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
/*if (session.getAttribute("InstituteCode")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
}*/
if (request.getParameter("INSCODE")==null)
{
	mINSTITUTECODE ="";
}
else
{
	mINSTITUTECODE =request.getParameter("INSCODE").toString().trim();
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

//Added By Anoop 11-01-2020 start
if (session.getAttribute("AcademicYearCode")==null)
{
	mAcadmeicYear="";
}
else
{
	mAcadmeicYear=session.getAttribute("AcademicYearCode").toString().trim();
}

//Added By Anoop 11-01-2020 End

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
}

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}

if (request.getParameter("SID")==null)
{
	mSID="";
}
else
{
	mSID=request.getParameter("SID").toString().trim();
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
	qry="Select WEBKIOSK.ShowLink('80','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
	
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Registered Subjects of Student</B></font>
</td>
<td align=right><font color=brown><b>Login User :&nbsp; &nbsp;</B><%=mName%><B>[Emp. Code: </B><%=mDMemberCode%>]</font></td>
</tr>
</table>
<form name="frm" method=post>
<input id="x" name="x" type=hidden>
<input id="INSCODE" name="INSCODE" value="<%=mINSTITUTECODE%>" type="hidden">
<input type=hidden value=<%=mSID%> id=SID Name=SID>
<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Student Name :&nbsp;</STRONG></font></TD><TD><%=GlobalFunctions.getUserName(mSID,"S")%></td>
</tr>

<tr><td>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Exam Code &nbsp; &nbsp; :</STRONG></font></TD><TD>
<%
  qry="select distinct nvl(examcode,' ')examcode, examperiodfrom from exammaster a where institutecode='"+mINSTITUTECODE+"' and nvl(deactive,'N')='N' ";		
  qry=qry+" And Exists (select 1 from V#STUDENTSUBJECTTAGGING v where v.examcode=a.examcode and StudentID='"+mSID+"') order By examperiodfrom desc";
  rs=db.getRowset(qry);
  //out.print(qry);
%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 140px">	
<%   	
	
  	if(request.getParameter("x")==null)
	{	
		%>
		<option Selected value=ALL>ALL</option>
		<%		
		while(rs.next())
		{
		 mexamcode=rs.getString("examcode");
	%>
		<option value=<%=mexamcode%>><%=mexamcode%></option>
	<%
		}
		mexamcode="ALL";
	 }
	else
	{
	   if(request.getParameter("exam").toString().trim().equals("ALL"))
	    {	
		%>
		<option Selected value=ALL>ALL</option>
		<%		
	    }
	   else
	    {
		%>
		<option value=ALL>ALL</option>
		<%		
	    }

	   while(rs.next())
	   {
	     mexamcode=rs.getString("examcode");			
	   if(mexamcode.equals(request.getParameter("exam").toString().trim()))
	    {	
	  %>
	    <option selected value=<%=mexamcode%>><%=mexamcode%></option>
	  <%
	     }	
         else
          {		
	   %>
	    <option  value=<%=mexamcode%>><%=mexamcode%></option>
	   <%
	    }	
	   }
       }
    %>
</select>
&nbsp; &nbsp;<input type="submit" value="Show"></td></tr>
</table></form>
<%
    if(request.getParameter("x")!=null)
	mexam=request.getParameter("exam");
    else
	mexam="ALL";

%>
  <table width=100% cellspacing=0 cellpading=0 align=middle border=1>
  <tr bgcolor="#c00000" >
  <td><b><font color=white>SNo.</font></b></td>
  <td><b><font color=white>Subject</font></b></td>	
  <td><b><font color=white>Credit</font></b></td>
  <td><b><font color=white>Semester</font></b></td>
  <td><b><font color=white>Core/Elective</font></b></td>
  </tr>
<%
         // Added by Anoop for academicyear programcode and branchcode start 11012020
          qry1="select ACADEMICYEAR,PROGRAMCODE,BRANCHCODE from STUDENTMASTER where STUDENTID='"+mSID+"' AND INSTITUTECODE='"+mINSTITUTECODE+"'";
          rs2=db.getRowset(qry1);
          while(rs2.next())
	  {
              mAcadmeicYear=rs2.getString("ACADEMICYEAR");
              mProg=rs2.getString("PROGRAMCODE");
              mBranch=rs2.getString("BRANCHCODE");

          }

         //End
/*	qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(B.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+" nvl(C.COURSECREDITPOINT,0)COURSECREDITPOINT,nvl(b.BASKET,'A') BASKET,b.SEMESTER||' ('||b.SEMESTERTYPE||')' sem FROM SUBJECTMASTER A, ";
	qry=qry+" V#STUDENTSUBJECTTAGGING B,PROGRAMSUBJECTTAGGING C WHERE B.EXAMCODE=DECODE('"+mexam+"','ALL',B.EXAMCODE,'"+mexam+"') ";
	qry=qry+" and B.studentid='"+mSID+"' and B.institutecode='"+mINSTITUTECODE+"' and ";
	qry=qry+" nvl(B.deactive,'N')='N' and B.SUBJECTID=A.SUBJECTID AND B.INSTITUTECODE=A.INSTITUTECODE and ";
	qry=qry+" nvl(A.deactive,'N')='N' and B.SUBJECTID=C.SUBJECTID AND B.INSTITUTECODE=C.INSTITUTECODE and  B.BASKET=C.BASKET AND C.EXAMCODE=B.EXAMCODE  AND ";
	qry=qry+" nvl(C.deactive,'N')='N' ";   */

	qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+" nvl(b.COURSECREDITPOINT,0)COURSECREDITPOINT, nvl(B.BASKET,'C')BASKET,A.SEMESTER||' ('||A.SEMESTERTYPE||')' sem  ";
	qry=qry+" FROM V#STUDENTSUBJECTTAGGING A, PROGRAMSUBJECTTAGGING B WHERE A.EXAMCODE=DECODE('"+mexam+"','ALL',B.EXAMCODE,'"+mexam+"')";
	qry=qry+" and A.studentid='"+mSID+"' and B.institutecode='"+mINSTITUTECODE+"' and ";
	qry=qry+" nvl(B.deactive,'N')='N' and B.SUBJECTID=A.SUBJECTID and a.semester=b.semester AND B.INSTITUTECODE=A.INSTITUTECODE and ";
	qry=qry+" nvl(A.deactive,'N')='N' and B.BASKET=A.BASKET AND A.EXAMCODE=B.EXAMCODE AND  B.ACADEMICYEAR='"+mAcadmeicYear+"' AND B.PROGRAMCODE='"+mProg+"' AND B.SECTIONBRANCH='"+mBranch+"' ";
	//qry=qry+" B.ACADEMICYEAR=A.ACADEMICYEAR AND B.TAGGINGFOR=A.TAGGINGFOR and ";
	//qry=qry+" Group By A.SUBJECT, A.SUBJECTCODE, B.COURSECREDITPOINT, B.BASKET ";
	qry=qry+" order by basket, COURSECREDITPOINT";
//	out.print(qry);		   
	rs1=db.getRowset(qry);
	msno=0;
	String mstype="";
	while(rs1.next())
	{
		msno++ ;
	%>
	   <tr>
		<td><%=msno%></td>	
		<td><%=rs1.getString("SUBJECT")%></td>
		<td><%=rs1.getString("COURSECREDITPOINT")%></TD>
		<td><%=rs1.getString("sem")%></TD>

		<%
			mTotalCrLmtTkn=mTotalCrLmtTkn+Double.parseDouble(rs1.getString("COURSECREDITPOINT"));

		if (rs1.getString("BASKET").equals("A"))
			mstype="Core";
		else if (rs1.getString("BASKET").equals("B"))
			mstype="Elective";
		else		
			mstype="Elective";
		%>

		<Td><%=mstype%></td>
	   </tr>	
    <%
	}
%>
<tr><td colspan=2 align=right><b>Total Course Credit:</b> </td><td><b><%=mTotalCrLmtTkn%></b></td><td>&nbsp;</td><td>&nbsp;</td></tr>
 </table>		

<%	 		        
//  }					




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
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br> 
   <%
	}
    		 //-----------------------------
  }   //2
else
{
	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	//e.printStackTrace();
}
%>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>

