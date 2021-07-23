<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rst=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="";

int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mOA="";

String mInst="";
String mEvent="";
String mExam="";
String mSubj="";
String mSubjID="";
String mLTP="";
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

	if (request.getParameter("ICD").toString().trim()==null)
	{
		mInst="";
	}
	else
	{	

		mInst=request.getParameter("ICD").toString().trim();
	}
	if (request.getParameter("SEC").toString().trim()==null)
	{
		mEvent="";
	}
	else
	{
		mEvent=request.getParameter("SEC").toString().trim();
	}

	if (request.getParameter("EC").toString().trim()==null)
	{
		mExam="";
	}	
	else
	{
		mExam=request.getParameter("EC").toString().trim();
	}	

	if (request.getParameter("SC").toString().trim()==null)
	{
		mSubj="";
	}
	else
	{
		mSubj=request.getParameter("SC").toString().trim();
	}

	if (request.getParameter("SID").toString().trim()==null)
	{
		mSubjID="";
	}
	else
	{
		mSubjID=request.getParameter("SID").toString().trim();
	}

	if (request.getParameter("LTP").toString().trim()==null)
	{
		mLTP="";
	}
	else
	{	
		mLTP=request.getParameter("LTP").toString().trim();
	}

	if (request.getParameter("EMPID").toString().trim()==null)
	{
		mEMPID="";
	}
	else
	{	
		mEMPID=request.getParameter("EMPID").toString().trim();
	}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey Suggestions ] </TITLE>
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

%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>SRS Event Suggestion</b></TD>
</font></td></tr>
</TABLE>
<%
String mEnm="";
qry="select EmployeeName from EmployeeMaster where EmployeeID='"+mEMPID+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mEnm=rs1.getString(1);
}
%>
 <font color="#00008b">Subject Code: <b><%=mSubj%></B> &nbsp; &nbsp;Faculty Name: <B><%=mEnm%></B> &nbsp; &nbsp; LTP: <B><%=GlobalFunctions.getLTPDescWSQ(mLTP)%></B>
 </font> 
 <TABLE  rules=Rows cellSpacing=1 cellPadding=1 width="100%" border=1 >
<tr>
 <td ><b><font color="#00008b">SNo</font></b></td>
 <td ><b><font color="#00008b">&nbsp; &nbsp; &nbsp;Suggestion</font></b></td>
</tr>
<%
qry="SELECT distinct trim(SUGGESTION) sugg , LTP, decode(LTP,'L',1,'T',2,3) LTPNO from v#SRSEVENTSUGGESTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"'";
qry=qry+" and SRSEVENTCODE='"+mEvent+"'  ";
qry=qry+" and SUBJECTID='"+mSubjID+"' And EmployeeID='"+mEMPID+"' and '"+mLTP+"' like '%'||ltp||'%'  and SUGGESTION is not null and nvl(deactive,'N')='N' and nvl(IsAbusing, 'N')='N'";
qry=qry+" Order By LTPNO ";

rs1=db.getRowset(qry);
//out.print(qry);
mSNO=0;
String mLTPDesc="",mLTPDesc1="";
while(rs1.next())
{
	if(!mLTPDesc.equals(rs1.getString("LTP")))
	{
		mLTPDesc=rs1.getString("LTP");
		qry1="select Distinct HEADINGTEXT HL from SRSLTPSUGGESTIONHEADING where LTP='"+mLTPDesc+"' and nvl(Deactive,'N')='N'";
		rst=db.getRowset(qry1);
		mSNO=0;
		if(rst.next())
		{
		mLTPDesc1=rst.getString("HL");
		}
		%>
		<tr>
		<td colspan=2><b><%=mLTPDesc1%></b></td></tr>
		<td colspan=2></td></tr>
		<%
	}
	
	mSNO++;
	%>
	<tr>
	<td><%=mSNO%></td>
	<td><%=rs1.getString("sugg")%></td></tr>
	<%
}
%>
</TABLE>
<%
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