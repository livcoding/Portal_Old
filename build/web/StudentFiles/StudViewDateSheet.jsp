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
	mInst="";
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
<TITLE>#### <%=mHead%> [ Student Date Sheet ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5   rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%	
try{
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
		
			
	qry="Select WEBKIOSK.ShowLink('99','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
	%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width='100%' ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">DateSheet View By Student
	</font></td></tr>
	</TABLE>
	<table width=100% bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0>
	<!--************Institute*************-->
	<INPUT Type="hidden" Name=SrcType id=SrcType Value=<%=mSrcType%>>
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
	<%
	qry="select WEBKIOSK.GetDateSheetCodes('"+mInst+"') DS from dual ";
	rsd=db.getRowset(qry);
	//out.print(qry);
	if (rsd.next() && !rsd.getString("DS").equals("N"))
	   {
	//out.print(qry);
	DSC=rsd.getString("DS");
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

    rs=db.getRowset(qry);	
// out.print(qry);
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
    qry="select nvl(A.SUBJECTID,' ')SUBJECTID, nvl(B.SUBJECT,' ')||' ('||nvl(B.SUBJECTCODE,' ')|| ')' Subject from DATESHEETDATA A,SUBJECTMASTER B";
    qry=qry+" where EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in (select EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE from DateSheet where ";
    qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in ("+DSC+") and nvl(Status,'N')='F') ";
    qry=qry+" and A.subjectID in (select subjectID from V#STUDENTLTPDETAIL where examcode in(select examcode from datesheet where EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE in("+DSC+")) and studentid='"+mDMemberID+"')	";	
    qry=qry+" and A.subjectID=B.subjectID GROUP BY nvl(A.SUBJECTID,' '),nvl(B.SUBJECT,' ')||' ('||nvl(B.SUBJECTCODE,' ')|| ')' order by subject";

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
	if(request.getParameter("x")!=null)
		msubject=request.getParameter("Subject");
	else
		msubject="ALL";
	if(request.getParameter("x")!=null)
		mDCode=request.getParameter("DScode");     	
	else
	   	mDCode=mDcode;
	
  	qry="select to_char(A.DATETIME,'dd-mm-yyyy') DATE1,to_char(A.DATETIME,'hh:mi PM') TIME1, ";
	qry=qry+" nvl(A.subjectID,' ')subjectID, nvl(B.subject,' ')||'('||B.SUBJECTCODE||')' subject from DATESHEETDATA A, ";
	qry=qry+" SUBJECTMASTER B where A.institutecode='"+mInst+"' and A.subjectID in ";
	qry=qry+" (Select subjectID from V#STUDENTLTPDETAIL where examcode in(select examcode from datesheet where nvl(Status,'N')='F' and EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE ='"+mDCode+"') and studentid='"+mDMemberID+"')	";	
    	qry=qry+" and A.subjectID=B.SubjectID and A.subjectID=decode('"+msubject+"','ALL',A.subjectID,'"+msubject+"') AND A.SUBJECTID=B.SUBJECTID ";
	qry=qry+" And EXAMCODE||'('||EXAMEVENTCODE||')-'||DSCODE ='"+mDCode+"' order by trunc(DATETIME)";

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
	<td><%=ctr%></td>
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
	<BR>
	<left><FONT size=2 face=arial><B>In case of any variation observed, please mail back to jiiterp@jiit.ac.in and contact ERP Personnel in booths next to LT-1</B></FONT></left>
	<BR>
	<left><FONT size=2 face=arial><B>Must recheck the final seating plan and date sheet on 25th August 2008 after 5:00 P.M.</B></FONT></lEFT>
<%
	   }  //closing of if request.getParameter("x")!=null
	}  // closing of ds code
//----------------------
//-security link
//----------------------
//  } // closing of Webkiosk Showlink if
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
