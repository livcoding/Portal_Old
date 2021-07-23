<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [View Department Load Distribution]</TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<%
try
{
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet RS1=null;

GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="", qry2="";
int msno=0;
String mMemberID="",mFSTID="",mLTP="";
String mMemberType="",mEID="";
String mDMemberType="";
String mMemberCode="", mFaculty="", mFacCode="", mEvent="",mFacid="",mSEMEID="";
String mDMemberCode="",mexam="",mSubject="",mFac="";
String mMemberName="",mSubjectcode="",mExamCode="",mSem="",mLoad="";
String mEXAMCODE1="",mFacultyId1="",mSUBJECTCODE1="",mSub="",mClass="",mClasstype="";
String mPREFTIMEFROM="",mPREFTIMETO="",mREQROOMTYPE="",mcolor="";
String mInst="",mHOD="";
String mSUBJECT="", mSECTIONBRANCH="";
String mFACULTYID="",mFACULTYID1="",mFACULTYID2="",mDept="",mDeptCode="",mDeptment="";

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
		mExamCode="";
	}
	else
	{
		mExamCode=request.getParameter("EXAM").toString().trim();
	}


	

	
	if (request.getParameter("SEMTYPE").toString().trim()==null)
	{
		mSem="";
	}
	else
	{
		mSem=request.getParameter("SEMTYPE").toString().trim();
	}
		
	if (request.getParameter("DEPT").toString().trim()==null)
	{
		mDept="";
	}
	else
	{
		mDept=request.getParameter("DEPT").toString().trim();
	}
	


	
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
	qry="Select WEBKIOSK.ShowLink('114','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	//out.print(qry);
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

//--------------------------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>

<table width="90%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>View Department Load Distribution</b></font></td>
</tr>

</TABLE>
		
	
		<input type=hidden name="INST" id="INST" value="<%=mInst%>">
		<input type=hidden name="EXAMCODE" id="EXAMCODE" value="<%=mExamCode%>"> 
		<input type=hidden name="SemesterType" id="SemesterType" value="<%=mSem%>"> 
 		<input type=hidden name="Department" id="Department" value="<%=mDept%>">
<% 
qry1="select nvl(A.DEPARTMENT,' ')DEPARTMENT,nvl(A.DEPARTMENTCODE,' ')DEPARTMENTCODE,nvl(B.EMPLOYEEID,' ')EMPLOYEEID,nvl(C.EMPLOYEENAME,' ') EMPLOYEENAME  from DEPARTMENTMASTER A,HODLIST B,EMPLOYEEMASTER C where  A.DEPARTMENTCODE='"+mDept+"' and A.DEPARTMENTCODE=B.DEPARTMENTCODE and B.EMPLOYEEID =C.EMPLOYEEID";
rs1=db.getRowset(qry1);
while(rs1.next())
{
mDeptment=rs1.getString("DEPARTMENT");
mDeptCode=rs1.getString("DEPARTMENTCODE");
mHOD=rs1.getString("EMPLOYEENAME");
}
%>
<table align=center bottommargin=0  topmargin=0>
<tr>
<td align=center><center><font color="#00008b">List of HOD Load Distribution of <b><u><%=GlobalFunctions.toTtitleCase(mDeptment)%> (<%=mDeptCode%>)</u></b> Department</font></center><td>
</tr>
</TABLE>

<table class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center >
	<thead>
  <tr bgcolor='#0e68a06'>
  <td align=center title="Subject"><b><font color=white>Subject</font></b></td>	
  <td align=center title="LTP"><b><font color=white>LTP</font></b></td>
  <td align=center title="Section/Subsection"><b><font color=white>Group</font></b></td>
  <td align=center title="Employee Name"><b><font color=white>Faculty</font></b></td>
  </tr>
</thead>
<tbody>
<%
	mcolor="Black";

qry="select Distinct  nvl(B.SUBJECTCODE,' ')SUBJECTCODE,decode(A.LTP,'L','Lecture','T','Tutorial','P','Practical')LTP,decode(A.LTP,'L',1,'T',2,3) LTPORD ,NVL(A.SECTIONBRANCH,' ')|| '-'||A.SUBSECTIONCODE SECTIONBRANCH ,nvl(A.FACULTYID,' ')FACULTYID,nvl(B.SUBJECT,' ')SUBJECT,nvl(C.EMPLOYEENAME,' ') EMPLOYEENAME ";
qry=qry+" From PR#HODLOADDISTRIBUTION A,SUBJECTMASTER B,EMPLOYEEMASTER C where A.SUBJECTID=B.SUBJECTID and A.FACULTYID=C.EMPLOYEEID And A.INSTITUTECODE='"+mInst+"' AND ";
qry=qry+" A.EXAMCODE='"+mExamCode+"' and  A.SEMESTERTYPE=decode('"+mSem+"','ALL',A.SEMESTERTYPE,'"+mSem+"')and A.DEPARTMENTRUNNIG='"+mDept+"' and nvl(A.Deactive,'N')='N' order by EMPLOYEENAME,SECTIONBRANCH,SUBJECT,LTPORD";
//out.print(qry);
rs=db.getRowset(qry);
int Ctr=0;
		while(rs.next())
		{
			mSUBJECT=rs.getString("SUBJECT");
			mLTP=rs.getString("LTP");
			mSECTIONBRANCH =rs.getString("SECTIONBRANCH");
			mFACULTYID=rs.getString("EMPLOYEENAME");
		/*	int len=0;
			int pos1=0;
			len=mFACULTYID.length();
			pos1=mFACULTYID.indexOf("(");
			if(pos1==0)
			{
				mFACULTYID1=mFACULTYID;
			}
			else
			{
				mFACULTYID1=mFACULTYID.substring(0,pos1);
				mFACULTYID2=mFACULTYID.substring(pos1,len);
			}	*/
			
			Ctr++;
			if(Ctr%2==0)
			{
			%>
			<tr bgcolor=white>
			<%
			}
			else
			{
			%>
			<tr bgcolor=white>
			<%
			}	
			%>
			<td><font color=<%=mcolor%>><%=mSUBJECT%> (<%=rs.getString("SUBJECTCODE")%>)</font>
			<td align=center><font color=<%=mcolor%>><%=mLTP%></font></td>
			<td><font color=<%=mcolor%>><%=mSECTIONBRANCH%></font></td>
			<td><font color=<%=mcolor%>><%=mFACULTYID%></font></td>
			<!--<font color=<%=mcolor%>><%=GlobalFunctions.toTtitleCase(mFACULTYID1)%> <%=mFACULTYID2%></font></td>-->
			</tr>	
			<%
		}
		%>
	
	
</tbody>
		</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString"]);
</script>

</form>
		
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







