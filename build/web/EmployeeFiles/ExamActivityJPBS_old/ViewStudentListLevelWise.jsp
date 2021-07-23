<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="", qry2="";
String moldDate="";
int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="", mRightsID="";
String mSubj="", mSubjID="", mCtype="", mProg="",mSec="",mSub="";
String mExam="", mFaculty="", mFSTID="", mDate1="", mDate2="";
String mColor="", mLTP="", mTotal="";
String mCType="", mAttDate="", mClassFr="", mClassTo="",mFstid="";
double mPerc=0, mTotalStrength=0, mTotalPresent=0;

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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

	if (request.getParameter("FSTID").toString().trim()==null)
	{
		mFstid="";
	}
	else
	{	
		mFstid=request.getParameter("FSTID").toString().trim();
	}
	
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [View Level Wise List of Students]</TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />



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
	qry="Select WEBKIOSK.ShowLink('218','"+mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
		%>
		<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr>
		<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>View Level Wise List of Students</b></font></td>
		</tr>
		</TABLE>
		
		
		
		<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1  border=1 >
		<thead>
		<tr bgcolor="#ff8c00">
		<td Title="Click to sort SNo"><b><font color="White">SNo</font></b></td>
		<td align=center nowrap Title="Click to Sort Enrollemnt No"><b><font color="White">Enrollment No</font></b></td>
		<td nowrap Title="Click to Sort Student Name"><b><font color="White">Student Name</font></b></td>
		<td nowrap Title="Click to SortClass Type"><b><font color="White">Section/SubSec</font></b></td> 
		</tr>
		</thead>
		<tbody>
		<%
		qry2="SELECT distinct STUDENTNAME,ENROLLMENTNO,nvl(EMPLOYEENAME,'')EMPLOYEENAME,NVL(EMPLOYEECODE,'')EMPLOYEECODE,NVL(SECTIONBRANCH,'')SECTIONBRANCH,NVL(SUBJECT,'')SUBJECT,NVL(SUBSECTIONCODE,'')SUBSECTIONCODE FROM V#EXAMEVENTSUBJECTTAGGING WHERE EXAMCODE='"+mExam+"' and FSTID='"+mFstid+"'";
		//out.print(qry2);
		rs=db.getRowset(qry2);
		mSNO=0;
		while(rs.next())
		{
          		mSNO++;
			
			%>
			<tr>
			<td nowrap><font face=arial><%=mSNO%>.</font></td>
			<td nowrap><font face=arial><%=rs.getString("ENROLLMENTNO")%></font></td>
			<td nowrap><font face=arial><%=rs.getString("STUDENTNAME")%></font></td>
			<td nowrap><font face=arial ><%=rs.getString("SECTIONBRANCH")%>(<%=rs.getString("SUBSECTIONCODE")%>)</font></td>
			
			</tr>
			<%
		}
		%>
		</tbody>
		</TABLE>
		<script type="text/javascript">
		var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
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
