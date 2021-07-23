<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;

GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String QryExam="",mexamcode="",mcolor="";
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
	mInstitute="";
else
	mInstitute=session.getAttribute("InstituteCode").toString().trim();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Exam Event/Sub Event wise Weightage Detail ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
			
	
	    qry="Select WEBKIOSK.ShowLink('59','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{
  //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Event/Sub Event Weightage Tagging</B></TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="340px" align=center rules=groups border=3>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>

<!--*********Exam**********-->
<tr><td valign=top><font color=black face=arial size=2>&nbsp;<STRONG>Exam Code</STRONG></font>
<%
	qry="Select Distinct nvl(EXAMCODE,' ') examcode from Exammaster where nvl(Deactive,'N')='N'";
	qry=qry+" AND INSTITUTECODE='"+mInstitute+"' and examcode in(select examcode from V#EXAMEVENTSUBJECTTAGGING where EMPLOYEEID ='"+mDMemberID+"' AND INSTITUTECODE='"+mInstitute+"')";
  rs=db.getRowset(qry);
//out.print(qry);
	%>
	<select name="exam" tabindex="0" id="exam" style="WIDTH: 120px">	
	<%   	
	if(request.getParameter("x")==null)
	{	
		QryExam="ALL";
		%>	
			<OPTION selected value=ALL>ALL</option>
		<%
		while(rs.next())
		{
		 	mexamcode=rs.getString("examcode");
			%>
				<option value=<%=mexamcode%>><%=mexamcode%></option>
			<%
		}
	}
	else
	{
		if (request.getParameter("exam").toString().trim().equals("ALL"))
 		{
			QryExam="ALL";
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
		   QryExam=mexamcode;
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
</select><INPUT Type="submit" Value="Show/Refresh">
</td></tr>
</table>
<td></tr>
</table>
</form>
<%	
	if(request.getParameter("x")!=null)
	{
		if(request.getParameter("exam")==null)
		{
			QryExam="";
		}
		else
		{
			QryExam=request.getParameter("exam").toString().trim();	
		}
  } //closing of outer if
%>
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
	<thead>
	<tr bgcolor="#ff8c00">
	<td><font color="White"><b>Subject</b></font></td>
	<td><font color="White"><b>Group</b></font></td>	
	<td nowrap><font color="White"><b>Exam Code</b></font></td>	
	<td><font color="White"><b>Event/Sub Event</b></font></td>	
  <td><font color="White"><b>Weightage</b></font></td>
	<td><font color="White"><b>Max<br>Marks</b></font></td>
	<td><font color="White"><b>Mode of<br> Entry</b></font></td>
	<td><font color="White"><b>Published<br>/Locked</b></font></td>
	</tr>
	</thead>
	<tbody>
<%
		qry=" Select distinct nvl(EXAMCODE,' ')ECode, SUBJECTID, nvl(SUBJECTCODE,' ')SUBJECTCODE, nvl(SUBJECT,' ')SUBJECT, (SECTIONBRANCH||'-'||SUBSECTIONCODE)SecSub, nvl(EVENTSUBEVENT,' ')SubEvent, nvl(WEIGHTAGE,0) WEIGHTAGE,";
		qry=qry+" nvl(MAXMARKS,0) MAXMARKS,decode(nvl(MARKSORPERCENTAGE,' '),'M','Marks','P','Percentage')MOP,";
		qry=qry+" decode(nvl(PUBLISHED,' '),'Y','YES','N','NO') PUBLISHED, decode(nvl(LOCKED,' '),'Y','YES','N','NO') LOCKED ";
		qry=qry+" from V#EXAMEVENTSUBJECTTAGGING WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE=decode('"+QryExam+"','ALL',EXAMCODE,'"+QryExam+"') AND EMPLOYEEID='"+mChkMemID+"'";
		qry=qry+" Group By EXAMCODE, SUBJECTCODE, SECTIONBRANCH, SUBSECTIONCODE, SUBJECTID,SUBJECT, EVENTSUBEVENT, WEIGHTAGE, MAXMARKS, MARKSORPERCENTAGE, PUBLISHED, LOCKED";
		qry=qry+" Order By ECode, SUBJECTCODE, SUBJECT, SecSub, SubEvent, WEIGHTAGE, MAXMARKS, MOP, PUBLISHED, LOCKED";
//out.print(qry);
		rs1=db.getRowset(qry);
 		int Ctr=0;
		while(rs1.next())
		 {
			Ctr++;
			mcolor="Black";
			%>
			<tr>
			<td nowrap><font color=<%=mcolor%>><%=rs1.getString("SUBJECT")%>(<%=rs1.getString("SUBJECTCODE")%>)</font></td>
			<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("SecSub")%></font></td>
			<td nowrap><font color=<%=mcolor%>><%=rs1.getString("ECode")%></font></td>
			<td nowrap><font color=<%=mcolor%>><%=rs1.getString("SubEvent")%></font></td>
			<td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("WEIGHTAGE")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
			<td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("MAXMARKS")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
			<td nowrap><font color=<%=mcolor%>><%=rs1.getString("MOP")%></font></td>	
			<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("PUBLISHED")%></font> /<font color=<%=mcolor%>>&nbsp;<%=rs1.getString("LOCKED")%></font></td>
			</tr>		
			<%  						
		 }	
		%>
		</tbody>
		</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","Number","Number","CaseInsensitiveString","CaseInsensitiveString"]);
</script>
		<%
//-----------------------------
//---Enable Security Page Level  
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
</body>
</html>