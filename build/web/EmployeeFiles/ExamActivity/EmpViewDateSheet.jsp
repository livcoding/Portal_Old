<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rsd=null;
String qry="";
String DSC="";
String mWebEmail="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="";
String mDMemberType="";
String mDMemberCode="";
String mDMemberID="";
String mInst="";
String mDSheet="";
String mDatesheet="";
String mSubject="";
String msubject="";
String mSubj="";
String mDCode="";
String mDcode="";
String mDataCode="";
String moldDate="";
int ctr=0;
int mRights=0;
String mSrcType="";
String mSrcType1="";
String mSrcType2="";
String Heading="";
 

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
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (request.getParameter("SrcType")==null)
{
	mSrcType="";
}
else
{
	mSrcType=request.getParameter("SrcType").toString().trim();
}


	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		   mHead=session.getAttribute("PageHeading").toString().trim();
	else
		   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey detailed report ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5   rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%	
try
{
OLTEncryption enc=new OLTEncryption();
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
	mDMemberType=enc.decode(mMemberType);
	mDMemberCode=enc.decode(mMemberCode);
	mDMemberID=enc.decode(mMemberID);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
	
	//-----------------------------
	//-- Enable Security Page Level  
	//-----------------------------
		
	if(mSrcType.equals("A"))
	{
	   mRights=20;
	  Heading="Admin.";	
	}
	else if(mSrcType.equals("H"))
	{
	   mRights=97;
	  Heading="DepartmentWise";	
	}
	else
	{
	   mRights=98;
	  Heading="Individual Member";	
	}
		
	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
	%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width='100%' ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">DateSheet View By <%=Heading%>
	</font></td></tr>
	</TABLE>
	<table width=100% bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0>
	<!--************Institute*************-->
	<INPUT Type="hidden" Name=SrcType id=SrcType Value=<%=mSrcType%>>
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
	<%
	qry="select WEBKIOSK.GetDateSheetCodes('"+mInst+"') DS from dual ";
	rsd=db.getRowset(qry);
	if (rsd.next() && !rsd.getString("DS").equals("N"))
	{
	DSC=rsd.getString("DS")	;	
	%>
 <!--*********Datesheet Code*************-->
 <tr>
<td colspan=5>
  <font face=arial size=2><b>DateSheet Code :</b></font>
  <%
 try{
    qry="select distinct EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE dscode from DATESHEETDATA where ";
    qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in (select EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE from DateSheet where ";
    qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in ("+DSC+") and nvl(Status,'N')='F') ";	
	//out.print(qry);
    rs=db.getRowset(qry);	
	
  %>
	 <select name=DScode tabindex="0" id="DScode" style="WIDTH: 210px">	   
 <%

    if (request.getParameter("x")==null)				
   {
	while(rs.next())
	{
        mDataCode=rs.getString("dscode"); 
	  if(mDcode.equals(""))	
	   mDcode=mDataCode;
       %>
 	  <option value=<%=mDataCode%>><%=mDataCode%></option>  	
	<%	 	
  	}
   } //closing of if
   else
   {
     while(rs.next())
     {
         mDataCode=rs.getString("dscode"); 
	  if(mDataCode.equals(request.getParameter("DScode").toString().trim()))
 			{
  		mDcode=mDataCode;
				%>
				<OPTION selected Value =<%=mDataCode%>><%=mDataCode%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mDataCode%>><%=mDataCode%></option>
		      	<%			
		   	}	
       }	//closing of while
   }	 //closing of else		
 %>
  </select>
<%
}
catch(Exception e)
{
//out.print("error"+qry);
}
%>
</td>
</tr>
<!--****************Subject*****************-->
<tr>
<td>
  <font face=arial size=2><b>Subject : &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</b></font>
  <%
 try{
	
	if(mSrcType.equals("A"))
	{
	//	out.print("Admin Subject");		
    	qry="select distinct nvl(A.SUBJECTID,' ')SUBJECTID,nvl(B.SUBJECT,' ')||' ('||nvl(B.SUBJECTCODE,' ')|| ')' Subject from DATESHEETDATA A,SUBJECTMASTER B";
    	qry=qry+" where EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in  (select EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE from DateSheet where ";
    	qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in ("+DSC+") and nvl(Status,'N')='F') ";	
    	qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE AND A.subjectID=B.subjectID order by subject";
	}
	else if(mSrcType.equals("H"))
	{
	qry="select distinct nvl(A.SUBJECTID,' ')SUBJECTID,nvl(B.SUBJECT,' ')||' ('||nvl(B.SUBJECTCODE,' ')|| ')' Subject from DATESHEETDATA A,SUBJECTMASTER B";
	qry=qry+" where EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in ( select EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE from DateSheet where ";
      qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in ("+DSC+") and nvl(Status,'N')='F') ";
	qry=qry+" and  A.INSTITUTECODE=B.INSTITUTECODE AND A.subjectID in ";
	qry=qry+" (Select FF.subjectID from facultysubjecttagging FF where FF.examcode in (Select DD.ExamCode from DATESHEET DD ";
	qry=qry+" where  DD.EXAMCODE||'('||DD.EXAMEVENTCODE||')-'||DD.DSCODE in ("+DSC+") and nvl(DD.Status,'N')='F')";
	qry=qry+" and employeeid in (select Employeeid ";
	qry=qry+" from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry+" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) )";
      qry=qry+" and A.subjectID=B.subjectID order by subject";
	}
	else
	{
	    qry="select distinct nvl(A.SUBJECTID,' ')SUBJECTID,nvl(B.SUBJECT,' ')||' ('||nvl(B.SUBJECTCODE,' ')|| ')' Subject from DATESHEETDATA A,SUBJECTMASTER B";
	    qry=qry+" where EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in (select EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE from DateSheet where ";
	    qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in ("+DSC+") and nvl(Status,'N')='F') ";
	    qry=qry+"  and A.INSTITUTECODE=B.INSTITUTECODE AND A.subjectID in (select subjectID from facultysubjecttagging where examcode in (Select ExamCode from DATESHEET ";
	    qry=qry+" where EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in ("+DSC+") and nvl(Status,'N')='F')";
	    qry=qry+" and employeeid ='"+mDMemberID+"')	";	
	    qry=qry+" and A.subjectID=B.subjectID order by subject";

	}
//out.print(qry);

    rs=db.getRowset(qry);	
   if (request.getParameter("x")==null)				
   {
%>
      <select name=Subject tabindex="0" id="Subject" style="WIDTH: 350px">	
	<option value='ALL' selected >ALL</option>   
<%
	while(rs.next())
	{
        mSubject=rs.getString("SUBJECTID"); 
	  if(msubject.equals(""))	
	   msubject=mSubject;
       %>
 	  <option value=<%=mSubject%>><%=rs.getString("Subject")%></option>  	
	<%	 	
  	}
%>
</select>
<%
   } //closing of if

  else
  {
%>
	 <select name=Subject tabindex="0" id="Subject" style="WIDTH: 350px">	
 <%
  if((request.getParameter("Subject").toString().trim()).equals("ALL"))
  {
 %>	
	<option value='ALL' selected >ALL</option>
<%	
  }
  else
  {
	%>
		<option value='ALL' >ALL</option>
	<%
  }
     while(rs.next())
     {
         mSubject=rs.getString("SUBJECTID"); 

	  if(mSubject.equals(request.getParameter("Subject").toString().trim()))
 			{
  			    msubject=mSubject;
				%>
				<OPTION selected Value =<%=mSubject%>><%=rs.getString("Subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubject%>><%=rs.getString("Subject")%></option>
		      	<%			
		   	}	
       }	//closing of while
   }	 //closing of else		
 %>
  </select>
<%
}
catch(Exception e)
{
//out.print("error"+qry);
}
%>
</td>
	 	
<td align=center colspan=4>
<input type='submit' value=Show/Refresh>
</td></tr>
</table>
</form>
<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='90%' bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=2 align=center>	
<tr bgcolor="#ff8c00">
<td><b><font color="white">SNo.</font></b></td>
<td><b><font color="white">Date/Day</font></b></td>
<td><b><font color="white">Time</font></b></td>
<td align=center><b><font color="white">Course code</font></b></td>
<td><b><font color="white">Course Name</font></b></td>
</tr>
<%
     // if(request.getParameter("x")!=null)
//	{
	  	

	if(request.getParameter("x")!=null)
	 	   mSubj=request.getParameter("Subject");			
	   else
		mSubj="ALL";
	if(request.getParameter("x")!=null)
		   mDCode=request.getParameter("DScode");     	
	 else
	  mDCode=mDcode;	

	
	if(mSrcType.equals("A"))
	{
	//	out.print("Admin Select");
	qry="select distinct nvl(A.subjectID,' ')subjectID,to_char(A.DATETIME,'dd-mm-yyyy') DATE1,to_char(A.DATETIME,'hh:mi PM') TIME1, ";
	qry=qry+" nvl(B.subject,' ')||' ('||nvl(B.subjectcode,' ')||')' subject from DATESHEETDATA A, ";
	qry=qry+" SUBJECTMASTER B where A.institutecode='"+mInst+"'  and a.INSTITUTECODE=b.INSTITUTECODE and  ";
	qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in('"+mDCode+"') ";
	qry=qry+" and A.subjectID=decode('"+mSubj+"','ALL',A.subjectID,'"+mSubj+"') AND A.SUBJECTID=B.SUBJECTID order by to_date(Date1,'dd-mm-yyyy'), to_date(Time1,'hh:mi PM')";
	}
	else if(mSrcType.equals("H"))
	{
		//			out.print(" HOD Select");
	qry="select distinct nvl(A.subjectID,' ')subjectID,to_char(A.DATETIME,'dd-mm-yyyy') DATE1,to_char(A.DATETIME,'hh:mi PM') TIME1, ";
	qry=qry+" nvl(B.subject,' ')||' ('||nvl(B.subjectcode,' ')||')' subject from DATESHEETDATA A, ";
	qry=qry+" SUBJECTMASTER B where A.institutecode='"+mInst+"'  and a.INSTITUTECODE=b.INSTITUTECODE and A.subjectID in ";
	qry=qry+" (Select subjectID from facultysubjecttagging where ExamCode in (Select ExamCode from DATESHEET ";
      qry=qry+" where EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in ("+DSC+") and nvl(Status,'N')='F')";
	qry=qry+" and employeeid in (select Employeeid ";
	qry=qry+" from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry+" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N'))) ";
	qry=qry+" and EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in('"+mDCode+"') ";
	qry=qry+" and A.subjectID=decode('"+mSubj+"','ALL',A.subjectID,'"+mSubj+"') AND A.SUBJECTID=B.SUBJECTID order by to_date(Date1,'dd-mm-yyyy'), to_date(Time1,'hh:mi PM')";
	}
	else
	{
		//			out.print("Individual Select");
  	qry="select distinct nvl(A.subjectID,' ')subjectID,to_char(A.DATETIME,'dd-mm-yyyy') DATE1,to_char(A.DATETIME,'hh:mi PM') TIME1, ";
	qry=qry+" nvl(B.subject,' ') ||' ('||nvl(B.subjectcode,' ')||')' subject from DATESHEETDATA A, ";
	qry=qry+" SUBJECTMASTER B where A.institutecode='"+mInst+"'  and a.INSTITUTECODE=b.INSTITUTECODE and A.subjectID in ";
	qry=qry+" (Select subjectID from facultysubjecttagging where ExamCode in (Select ExamCode from DATESHEET ";
      qry=qry+" where EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in ("+DSC+") and nvl(Status,'N')='F')";
	qry=qry+" and employeeid='"+mDMemberID+"' )";
	qry=qry+" and EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in('"+mDCode+"') ";
	qry=qry+" and A.subjectID=decode('"+mSubj+"','ALL',A.subjectID,'"+mSubj+"') AND A.SUBJECTID=B.SUBJECTID order by to_date(Date1,'dd-mm-yyyy'), to_date(Time1,'hh:mi PM')";

	}
	rs=db.getRowset(qry);
	ctr=0;
	//out.print(qry);
	while(rs.next())
	{
	  if(!moldDate.equals(rs.getString("DATE1")))
	 {	
            ctr++;
		moldDate=rs.getString("DATE1");
 %> 
	<tr>
	<td><%=ctr%>.</td>
      <td><%=rs.getString("DATE1")%></td>
      <td><%=rs.getString("TIME1")%></td>
      <td COLSPAN=2><%=rs.getString("subject")%></td>
	</tr>
  <%
	}
	else
	{
%>
	<tr>
	<td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><%=rs.getString("TIME1")%></td>
      <td COLSPAN=2><%=rs.getString("subject")%></td>
	</tr>
 <%
	
	}
    } // closing of while
 %>

	</table>
<%
//	   }  //closing of if request.getParameter("x")!=null
	}  // closing of ds code
//----------------------
//-security link
//----------------------
  } // closing of Webkiosk Showlink if
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
   } //closing of Session if 
 }
 else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
} // closing of outer try
catch(Exception e)
{
}      
%>
</body>
</html>
