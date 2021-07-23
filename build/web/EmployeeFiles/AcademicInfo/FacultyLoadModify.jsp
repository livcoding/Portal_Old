<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet RS1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="", qry2="";

String mMemberID="",mFSTID="",mLTP="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="", mFaculty="", mFacCode="", mEvent="", mSubevent="",mGroup="",mFacid="";
String mDMemberCode="",mexam="",mSubject="",mFac="";
String mFST1="",mLTP1="",mexam1="",mSubject1="",mSem1="",mGroup1="",mFac1="";
String mMemberName="",mcolor="",QryFac="",mSem="",mfaculty="";
String mECode="", mSubjCode="", mSubj="", mSubEvent="", mFMarks="", mInst="", mWValue="", mEntryDate="";
long mCurrWValue=0, mCurrMarks=0, mNewWValue=0, mNewMarks=0, mTotalUsed=0, mTotalAvl=0, mTotalInUse=0;
long mAvailable=0, mWeight=0, mTotPerm=100, mAbcd=0;

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

	if (request.getParameter("INST").toString().trim()==null)
	{
		mInst="";
	}
	else
	{
		mInst=request.getParameter("INST").toString().trim();
	}
	if (request.getParameter("FSTID").toString().trim()==null)
	{
		mFSTID="";
	}
	else
	{	
		mFSTID=request.getParameter("FSTID").toString().trim();
	}
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		mHead=session.getAttribute("PageHeading").toString().trim();
	else
		mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Teaching Load Modify]</TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
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
	qry="Select WEBKIOSK.ShowLink('106','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();


if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="90%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Teaching Load Modify</b></font></td>
</tr>
</TABLE>
		
	
<table cellpadding=2 cellspacing=0 align=center rules=groups width=90% border=2>
<tr>
		<input type=hidden name="INST" id="INST" value="<%=mInst%>">
            <input type=hidden name="FSTID" id="FSTID" value="<%=mFSTID%>">
<%
qry="select nvl(EmployeeName,' ')EN, nvl(EmployeeCode,' ')EC from EmployeeMaster where EmployeeID='"+mChkMemID+"' and nvl(Deactive,'N')='N'";
rs=db.getRowset(qry);
while(rs.next())
{
mFaculty=rs.getString("EN");
mFacCode=rs.getString("EC");
}
%>

<td colspan=2>
<font color="#00008b" face=arial size=2>&nbsp;<STRONG>Login Member:</STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mFaculty%>(<%=mFacCode%>)</FONT></td></tr>

<tr bgcolor=white><td></td><td></td></tr>
<tr bgcolor=white><td></td><td></td></tr>
</table>
<table  align=center rules=groups width=90% border=2>
<%

qry="select distinct A.employeeid employeeid,A.Examcode Examcode,C.SubjectCode SubjectCode,A.LTP LTP,A.Semester Semester,A.FSTID FSTID,A.SECTIONBRANCH||'-'||A.SUBSECTIONCODE SECTIONBRANCH,B.EMPLOYEENAME EMPLOYEENAME";
qry=qry+" from facultysubjecttagging A,EmployeeMaster B, SUBJECTMASTER C where B.EmployeeID=A.EmployeeID and A.SubjectID=C.SubjectID and A.FSTID='"+mFSTID+"'";
rs=db.getRowset(qry);
//out.print(qry);
if(rs.next())
{
mexam=rs.getString("Examcode");
mSubject=rs.getString("SubjectCode");
mLTP=rs.getString("LTP");
mSem=rs.getString("Semester");
mGroup=rs.getString("SECTIONBRANCH");
mFacid=rs.getString("employeeid");
mFac=rs.getString("EMPLOYEENAME");
}
%>
<tr><td><FONT color=black face=Arial size=2><STRONG>&nbsp;ExamCode&nbsp;:&nbsp; </STRONG><%=mexam%></FONT>&nbsp;

<td><FONT color=black face=Arial size=2><STRONG>&nbsp;Subject&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</STRONG><%=mSubject%></FONT>&nbsp;

<tr><td><FONT color=black face=Arial size=2><STRONG>&nbsp;LTP &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</STRONG><%=mLTP%></FONT>&nbsp;

<td><FONT color=black face=Arial size=2><STRONG>&nbsp;Semester&nbsp;:&nbsp;</STRONG><%=mSem%></FONT>&nbsp;

<tr><td><FONT color=black face=Arial size=2><STRONG>&nbsp;Group&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp; </STRONG><%=mGroup%></FONT>&nbsp;
</TABLE>
<table align=center width=90% border=0>
<tr><td><FONT color=black face=Arial size=2><STRONG>Tagged With Faculty &nbsp;:</STRONG><%=mFac%></FONT>&nbsp;
<tr><td nowrap>
<!-----***************Faculty**********************-->
	<FONT color=black><FONT face=Arial size=2><STRONG>Assigned Load To &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</STRONG></FONT></FONT>
<%
	qry=" Select Distinct A.EmployeeID EmployeeID, nvl(A.EmployeeName,' ') EmployeeName ";
	qry=qry+" from EMPLOYEEMASTER A where  NVL(DEACTIVE,'N')='N' order by 2";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 245px">	
		<%   
		while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEEID");
			if(mFaculty.equals(""))			
 			mfaculty=mFaculty;
			%>
			<OPTION Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 245px">	
		<%
		
		while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEEID");
			if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
 			{
				mfaculty=mFaculty;
				%>
				<OPTION selected Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
		      	<%			
		   	}
		}
}

		%>
		</select><INPUT Type="submit" Value="Save Teaching Load"></td></tr></table>
<%
		if(request.getParameter("x")!=null)
		{
			
			mFST1=request.getParameter("FSTID").toString().trim();
			mFac1=request.getParameter("Faculty").toString().trim();
           		
            qry="Update FACULTYSUBJECTTAGGING set EMPLOYEEID='"+mFac1+"'";
         	qry=qry +"where institutecode='"+mInst+"' and FSTID='"+mFST1+"' ";
            int n=db.update(qry);
		if(n>0)
		{
		 //----------- Log Entry
		 //-----------------
			  db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"MODIFY TEACHING LOAD", "Exam Code: "+mexam+"  Subject: "+mSubject+" New TaggedFacultyID: "+mFac1+" Old Faultyid : "+mFacid, "No MAC Address" , mIPAddress);
		 //-----------------
		//out.print(qry);
		%><Br><CENTER><%
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>Teaching Load assigned tp Others successfully...</font> <br>");
		response.sendRedirect("TeachingLoad.jsp");
		%></CENTER><%
		}
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
</form>
</body>
</html>
