<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 

<%
String mHead="",mSID="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Student Grades ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

 

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
	' * File Name:	EmpStudGradeView.JSP		[For Adminuser User-Marks of Students]					
	' * Author:		Vijay
	' * Date:		23rd May 2007
	' * Version:	1.0						
	' * Description:	Students Grade
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="";
int msno=0;
String mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mSem="",mName="";
String mINSTITUTECODE="";
String mEmployeeID="";
String mSUBJECTCODE="";
String mEName="",msubj="",mSubj="",mSubjcode="";
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
	qry="Select WEBKIOSK.ShowLink('23','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	//out.print(qry);
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
		//out.println(e.getMessage());
	}
	
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Student Subject Grade</b></font></td>
<td align=right><font color=brown><b>Login User :&nbsp; &nbsp;<%=mName%>[Emp. Code: <%=mDMemberCode%>]</b></font>
</td>
</tr>
</table>

<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<input type=hidden value=<%=mSID%> id=SID Name=SID>
<table rules=groups cellspacing=1 cellpadding=1 align=center border=3>
<tr><td><font color=black face=arial size=2><STRONG>Student Name :&nbsp; &nbsp;</STRONG></font><b><font face=verdana size=3><%=GlobalFunctions.getUserName(mSID,"S")%></font></b>
&nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
<%
  qry="select distinct nvl(examcode,' ')examcode from exammaster where institutecode='"+mINSTITUTECODE+"' and nvl(deactive,'N')='N'";		
  rs=db.getRowset(qry);
//out.print(qry);
%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 120px">		
<%   	
  	if(request.getParameter("x")==null)
	{
	%>	
	<OPTION selected value=ALL>ALL</option>
<%
		while(rs.next())
		{
		 mexamcode=rs.getString("examcode");
	%>
		<option  value=<%=mexamcode%>><%=mexamcode%></option>
	<%		
		}
	  mexamcode="ALL";
	 }
	else
	{
		if (request.getParameter("exam").toString().trim().equals("ALL"))
 		{
			mexamcode="ALL";
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
&nbsp;<input type="submit" value="Show/Refresh"></td></tr>
</table></form>
<%
   if(request.getParameter("x")!=null)
	{
	   mexamcode=request.getParameter("exam").toString().trim();	
	}					
%>
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=group/s topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">	
	<thead>
	<tr bgcolor="#ff8c00">
  <td><b><font color=white>SNo.</font></b></td>
  <td><b><font color=white>Exam Code</td>
  <td><b><font color=white>Subject(Code)</font></b></td>	
  <td><b><font color=white>Grade</td>
 </tr>
</thead>
	<tbody>

<%
	qry="select distinct nvl(B.SUBJECT,' ')||'('||NVL(B.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+" nvl(A.GRADEAWARDED,' ')Grade,nvl(A.EXAMCODE,' ')EXAMCODE from STUDENTSUBJECTGRADE A, SUBJECTMASTER B";
	qry=qry+" where A.SUBJECTID=B.SUBJECTID and studentid='"+mSID+"' and examcode=decode('"+mexamcode+"','ALL',examcode,'"+mexamcode+"') ";
      qry=qry+" order by examcode desc ";
	rs1=db.getRowset(qry);
	//out.print(qry);
	msno=0;
	while(rs1.next())
	{
		msno++ ;
	%>
	   <tr>
		<td>&nbsp;<%=msno%>.</td>
		<td><%=rs1.getString("EXAMCODE")%></td>
		<td><%=rs1.getString("SUBJECT")%></td>
		<td><%=rs1.getString("Grade")%></td>
	  </tr>
	  <%
	}
%>
</tbody>
 </table>	
<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
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
}
%><br><br><br><br><br><br>
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