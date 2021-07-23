<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rsd=null,rs1=null;
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
String mDCode="";
String mDcode="";
String mDataCode="";
String moldDate="";
int ctr=0,msno=0;
int mRights=0;
String Heading="",DSC1="",mType="";
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


	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		   mHead=session.getAttribute("PageHeading").toString().trim();
	else
		   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey detailed report ] </TITLE>
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
		
   	  mRights=118;
	  Heading="Students";	
		
	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
	%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width='100%' ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">View Invigilation Duty Plan By <%=Heading%>
	</font></td></tr>
	</TABLE>
	<table border=2 align=center bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0>
	<!--************Institute*************-->
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
	<%
	qry="select WEBKIOSK.GetSeatingPlanCodes('"+mInst+"') DS from dual ";
	rsd=db.getRowset(qry);
	if (rsd.next() && !rsd.getString("DS").equals("N"))
	   {
	//out.print(qry);
	int len=0;
	int pos1=0;

	DSC=rsd.getString("DS")	;	
	len=DSC.length();
	pos1=DSC.indexOf(")");
	DSC1=DSC.substring(0,pos1+1)+"'";	
    %>
 <!--*********Datesheet Code*************-->
 <tr>
<td colspan=5>
  <font face=arial size=2><b>&nbsp; DateSheet Code :</b></font>
  <%
 try{
    qry="select distinct EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE dscode from V#CENTREWISEROOMALLOCATION where ";
    qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in (select EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE from SEATINGPLAN where ";
    qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in ("+DSC+") and nvl(Status,'N')='F') ";	
    rs=db.getRowset(qry);	
//	out.print(qry);
  %>
	 <select name=DScode tabindex="0" id="DScode" style="WIDTH: 250px">	   
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
&nbsp; <input type='submit' value=Show/Refresh> &nbsp;
</td></tr>
</table>
</form>
<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='100%' bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=2 align=center>
<tr bgcolor="#ff8c00">
<td><b><font color="white">SNo.</font></b></td>
<td><b><font color="white">Date/time</font></b></td>
<td><b><font color="white">Exam center</font></b></td>
<td align=center><b><font color="white">Room code</font></b></td>
<td align=center><b><font color="white">Invigilator Role</font></b></td>
</tr> 
<%
		
	

	if(request.getParameter("x")!=null)
	   mDCode=request.getParameter("DScode");     	
	else
	   	mDCode=mDcode;

	qry="Select To_Char(A.DATETIME,'dd-mm-yyyy')||' At '||to_char(A.DATETIME,'hh:mi PM')DateTime, ";
	qry=qry+" B.EXAMCENTERNAME examcentername, A.INVIGILATORID, A.INVIGILATORTYPE,A.EXAMCENTERCODE,A.ROOMCODE,C.ROOMDESC roomdesc From INVIGILATIONDUTYALLOCATION A,examcentermaster B,roommaster C";
	qry=qry+" where A.institutecode='"+mInst+"' and  ";
	qry=qry+" A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in('"+mDCode+"') ";
	qry=qry+" and A.INVIGILATORID='"+mDMemberID+"' and A.INVIGILATORTYPE='S'"; 
	qry=qry+" and A.EXAMCENTERCODE=B.EXAMCENTERCODE AND A.ROOMCODE=C.ROOMCODE ";
	qry=qry+" and A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in (select S.EXAMCODE||'('||S.EXAMEVENTCODE||')-'||S.SPCODE from SEATINGPLAN S where ";
	qry=qry+" S.EXAMCODE||'('||S.EXAMEVENTCODE||')-'||S.SPCODE in ("+DSC+") and nvl(S.Status,'N')='F') ";	
	qry=qry+"  group by A.institutecode,A.examcode,A.exameventcode,A.INVIGILATORID, ";
	qry=qry+" A.EXAMCENTERCODE,A.INVIGILATORTYPE,A.spcode,A.roomcode,A.datetime, ";
	qry=qry+" B.examcentername,C.roomdesc ";
	qry=qry+" order by A.DATETIME ";
	rs=db.getRowset(qry);
	//out.print(qry);
	ctr=0;
	while(rs.next())
	{
		msno++;
		if(!moldDate.equals(rs.getString("DateTime")))
	 	{
			moldDate=rs.getString("DateTime");	
			%>
			<tr>
			<td><%=msno%></td>
			<td><%=moldDate%></td>	
			<td><%=rs.getString("examcentername")%></td>
			<td align=center><%=rs.getString("roomdesc")%></td>
			<td align=center><font color="black" size=2>To collect Answer Scripts</font></td>
			</tr>
		 	<%	
		}
		else
		{
			%>
			<tr>
			<td><%=msno%></td>
			<td>&nbsp;</td>	
 			<td><%=rs.getString("examcentername")%></td>
			<td align=center><%=rs.getString("roomdesc")%></td>
			<td align=center><font color="black" size=2>To collect Answer Scripts</font></td>
			</tr>
	 		<%	
		}
	} // closing of while
	%>
	</table>
	<%
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
