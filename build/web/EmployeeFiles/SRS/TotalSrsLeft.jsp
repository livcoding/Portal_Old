<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="";

int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";

String mProg="";
String mSec="";
String mSubs="";
String mSubj="";
String mLTP="";
String mEmp="";
String mTotal="";
String mTotSent="";
String mTotLeft="";
String mEMPID="";


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

	if (request.getParameter("PROG").toString().trim()==null)
	{
		mProg="";
	}
	else
	{	
		mProg=request.getParameter("PROG").toString().trim();
	}
	if (request.getParameter("SEC").toString().trim()==null)
	{
		mSec="";
	}
	else
	{
		mSec=request.getParameter("SEC").toString().trim();
	}

	if (request.getParameter("SUBSEC").toString().trim()==null)
	{
		mSubs="";
	}	
	else
	{
		mSubs=request.getParameter("SUBSEC").toString().trim();
	}	

	if (request.getParameter("SC").toString().trim()==null)
	{
		mSubj="";
	}
	else
	{
		mSubj=request.getParameter("SC").toString().trim();
	}

	if (request.getParameter("LTP").toString().trim()==null)
	{
		mLTP="";
	}
	else
	{	
		mLTP=request.getParameter("LTP").toString().trim();
	}

	if (request.getParameter("EID").toString().trim()==null)
	{
		mEmp="";
	}
	else
	{	
		mEmp=request.getParameter("EID").toString().trim();
	}

	

//out.print(mProg+" - "+mSec+" - "+mSubs+" - "+mSubj+" - "+mLTP+" - "+mEmp+" - "+mTotal+" - "+mTotSent+" - "+mTotLeft+" - "+mEMPID+" - "+mRType);
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey Report (Name of Sent/Left Student) ]</TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{	
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("")) 
	{
	mDMemberCode=enc.decode(mMemberCode);
String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('79','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

	
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>SRS Left by Students</b></font></td>
</tr>
</TABLE>
<%
String mEnm="";

qry="select EmployeeName from EmployeeMaster where EmployeeID='"+mEmp+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mEnm=rs1.getString(1);
}
%>
<table  width="100%">
<tr><td align=middle>
 <font color="#00008b">Subject Code: <b><%=mSubj%></B> &nbsp; &nbsp;Faculty Name: <B><%=mEnm%></B> &nbsp; &nbsp; LTP: <B><%=GlobalFunctions.getLTPDescWSQ(mLTP)%></B>
 </font>
</td></tr></table>
 <TABLE  align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="70%" border=1 >

<thead>
<tr bgcolor="#c00000">
 <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td Title="Click on Student Name to Sort"><b><font color="White">Student Name</font></b></td>
 <td Title="Click on Enrollment No to Sort"><b><font color="White">Enrollment No.</font></b></td> 
</tr>
</thead>
<tbody>
<%
	qry="select distinct nvl(STUDENTNAME,' ')SN, nvl(ENROLLMENTNO,' ')EN from V#STUDENTLTPDETAIL ";
	qry=qry+" where PROGRAMCODE='"+mProg+"'";
	qry=qry+" and SECTIONBRANCH='"+mSec+"'";
	qry=qry+" and SUBSECTIONCODE='"+mSubs+"'";
	qry=qry+" and SUBJECTCODE='"+mSubj+"'";
	qry=qry+" and '"+mLTP+"' like '%'||LTP|| '%' ";
	qry=qry+" and EMPLOYEEID='"+mEmp+"'";
	qry=qry+" and (FSTID, studentid) not IN(select FSTID, studentid from V#SRSEVENTDETAIL";
	qry=qry+" where PROGRAMCODE='"+mProg+"'";
	qry=qry+" and SECTIONBRANCH='"+mSec+"'";
	qry=qry+" and SUBSECTIONCODE='"+mSubs+"'";
	qry=qry+" and SUBJECTCODE='"+mSubj+"'";
	qry=qry+" and '"+mLTP+"' like '%'||LTP|| '%' ";
	qry=qry+" and EMPLOYEEID='"+mEmp+"') ";
	qry=qry+" order by sn";
	rs=db.getRowset(qry);
	mSNO=0;
	while(rs.next())
	{
		mSNO++;
	%>
	<tr>
	<td><%=mSNO%>.</td>
	<td><%=GlobalFunctions.toTtitleCase(rs.getString("SN"))%></td>
	<td><%=rs.getString("EN")%></td>
	</tr>
	<%
}
%>
</tbody>
</TABLE>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString"]);
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
