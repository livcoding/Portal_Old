<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Student Grade Card (Eventwise) ] </TITLE>
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
	' * File Name:	StudentEventGradesViewjsp.JSP		[For Students]					
	' * Author:		Vijay Kumar
	' * Date:		3rd Aug 2007
	' * Version:	2.0							
	' * Description:	Grade Card of Students
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="";
int mTotGrPt=0, mTotCoCrPt=0, msno=0;
String QryExam="", mexamcode="",mProg="",mBranch="",mName="";
String mInst="";
String mEmployeeID="";
String mSUBJECTCODE="";
String mSID="";
ResultSet rs=null,rs1=null,rse=null;
String qrye="";
String QryExam11="";

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
if (request.getParameter("INSCODE")==null)
{
	mInst ="";
}
else
{
	mInst =request.getParameter("INSCODE").toString().trim();
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
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	try
	{	
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		//out.println(e.getMessage());
	}


String mSnm="", mENo="";
String mProgr="",mBran="";
int mSem1=0;

qry="select StudentName, Enrollmentno ,semester,programcode,branchcode from StudentMaster where StudentID='"+mSID+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mSnm=rs1.getString("StudentName");
mENo=rs1.getString("Enrollmentno");
mSem1=rs1.getInt("semester");	
mProgr=rs1.getString("programcode");
mBran=rs1.getString("branchcode");
}

	
%>
<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<input id="INSCODE" name="INSCODE" value="<%=mInst%>" type="hidden">
<input type=hidden value=<%=mSID%> id=SID Name=SID>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Student Grade Card </b></font>
</td>
</tr>
</table>
<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td NOWRAP><font color=black face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="Vardana"><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</font>
&nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="Vardana"><%=mProgr%>(<%=mBran%>)</font>
&nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="Vardana"><%=mSem1%></font></td></tr>

<tr><td NOWRAP><font color=black face=arial size=2><STRONG>&nbsp; Exam Code</STRONG></font>
<%
  qry="select distinct nvl(examcode,' ')examcode, Examperiodfrom from exammaster a where institutecode='"+mInst+"'";
  qry=qry+" and nvl(deactive,'N')='N' and a.EXAMCODE IN (SELECT b.EXAMCODE FROM STUDENTWISEGRADE b where studentid='"+mSID+"') order by Examperiodfrom desc";
  rs=db.getRowset(qry);
  //out.print(qry);
	%>
	<select name="exam" tabindex="0" id="exam" style="WIDTH: 120px">	
	<%   	
	if(request.getParameter("x")==null)
	{	
		
		while(rs.next())
		{
		 	mexamcode=rs.getString("examcode");
			if(QryExam.equals(""))
				QryExam=mexamcode;
			%>
				<option value=<%=mexamcode%>><%=mexamcode%></option>
			<%
		}
	}
	else
	{
		
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
	</select>


	&nbsp;<input type="submit" value="Show"></td></tr>
	</table>
	<%
	if(request.getParameter("x")!=null)
	{
		 QryExam=request.getParameter("exam").toString().trim();
	}

//qry="select 'Y' from HOLDRESULTLIST#PUB where  hold='Y' and INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and studentid='"+mSID+"' ";


qry="select 'Y' from HOLDRESULTLIST#PUB A where NVL(A.hold,'N')='Y' and A.INSTITUTECODE='"+mInst+"' and A.EXAMCODE='"+QryExam+"' and A.studentid='"+mSID+"'     AND EXISTS ( SELECT 'Y' FROM PUBLISHRESULT#PUB B WHERE NVL(B.PUBLISH,'N')='Y' AND B.INSTITUTECODE='"+mInst+"'  AND  A.INSTITUTECODE=B.INSTITUTECODE  AND A.ACADEMICYEAR =B.ACADEMICYEAR  AND A.PROGRAMCODE=B.PROGRAMCODE  AND B.SECTIONBRANCH=A.SECTIONBRANCH  AND A.EXAMCODE=B.EXAMCODE  AND A.SEMESTER=B.SEMESTER) ";
rs=db.getRowset(qry);
if(!rs.next())
		{
%>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
<thead>
<!--<#c00000>-->
<tr bgcolor="#ff8c00">
  <td nowrap><b><font color=white>Exam Code</font></b></td>
  <td nowrap><b><font color=white>Subject</font></b></td>
  <td nowrap align=center><b><font color=white>Grade Awarded</b></td>
  <td nowrap align=center><b><font color=white>Course Credit Point</b></td>
  <td nowrap align=center><b><font color=white>Grade Point</b></td>
</tr>
</thead>
<tbody>
<%
	qrye="select distinct nvl(E2DEXAMCODE,'**')E2DEXAMCODE from studentwisegrade where studentid='"+mSID+"' and examcode='"+QryExam+"' ";
	rse=db.getRowset(qrye);
	//out.print(qrye);
	if(rse.next())
		{
			QryExam11=rse.getString(1);
		}
		else
		{
			QryExam11="**";
		}

	if(QryExam11.equals("**"))
	{
	qry="select distinct C.semester SEMESTER,nvl(c.EXAMCODE,' ')EXAMCODE, nvl(c.SUBJECTID,' ')SUBJECTID, nvl(B.SUBJECT,' ')||' ('||NVL(B.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+ " NVL(A.FINALGRADE,0) FINALGRADE, nvl(A.GRADEFLAG,' ')ETOD from STUDENTWISEGRADE A, SUBJECTMASTER B, V#EXAMEVENTSUBJECTTAGGING C";
	qry=qry+ " where A.studentid='"+mSID+"' and a.INSTITUTECODE='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE and a.INSTITUTECODE=c.INSTITUTECODE AND a.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL V WHERE v.studentid='"+mSID+"' and v.INSTITUTECODE='"+mInst+"' and v.examcode='"+QryExam+"')";
	qry=qry+ " and A.fstid=C.fstid and nvl(A.DOCMODE,'N')='A'  AND A.STUDENTID=C.STUDENTID AND b.SUBJECTid=C.SUBJECTid";

	}
	else
	{
	qry="select distinct C.semester SEMESTER,nvl(A.EXAMCODE,' ')EXAMCODE, nvl(c.SUBJECTID,' ')SUBJECTID, nvl(C.SUBJECT,' ')||' ('||NVL(C.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+ " NVL(A.FINALGRADE,0) FINALGRADE, nvl(A.GRADEFLAG,' ')ETOD  from STUDENTWISEGRADE A, SUBJECTMASTER B, V#STUDENTLTPDETAIL C";
	qry=qry+ " where A.studentid='"+mSID+"' and a.INSTITUTECODE='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE and a.INSTITUTECODE=c.INSTITUTECODE  AND a.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL V WHERE v.studentid='"+mSID+"' and v.INSTITUTECODE='"+mInst+"'  and v.examcode='"+QryExam+"' )";
	qry=qry+ " and nvl(A.DOCMODE,'N')='A' and A.fstid=C.fstid and A.studentid=C.studentid and A.examcode=C.examcode  ";

	}
	qry=qry+ "  and c.studentid not in (select studentid from HOLDRESULTLIST#PUB where  hold='Y' and INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and studentid='"+mSID+"'  ) ";
		qry=qry+ " ORDER BY EXAMCODE, SUBJECT";

	rs1=db.getRowset(qry);
//out.print(qry);
	msno=0;
	while(rs1.next())
	{
		msno++ ;
		qry="Select nvl(GRADEPOINT,0)GRADEPOINT, nvl(COURSECREDITPOINT,0)COURSECREDITPOINT From STUDENTRESULT#PUB Where INSTITUTECODE='"+mInst+"' and STUDENTID='"+mSID+"' and SEMESTER='"+rs1.getString("SEMESTER")+"' and SUBJECTID='"+rs1.getString("SUBJECTID")+"'";
		rse=db.getRowset(qry);
		//out.print(qry);
		if(rse.next())
		{
			mTotGrPt=rse.getInt(1);
			mTotCoCrPt=rse.getInt(2);
		}
		%>
		<tr>
		<td nowrap><%=rs1.getString("EXAMCODE")%></TD>
		<td nowrap><%=rs1.getString("SUBJECT")%></td>
		<td nowrap align=center><b><%=rs1.getString("FINALGRADE")%><b></td>
		<td nowrap align=center><b><%=mTotCoCrPt%><b></td>
		<td nowrap align=center><b><%=mTotGrPt%><b></td>
	 	</tr>	
		<%
	}
	%>
	</tbody>
	</table>		
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>
<%
		}
else
		{
out.print(" &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<BR><b><font size=3 face='Arial' color='Red'> >> Result withheld due to fee deficiency/document deficiency/other reason please contact to registry. </font> <br>");
		}
//-----------------------------
//-- Enable Security Page Level  
//-----------------------------
	}//3
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
%>
</form>
</body>
</html>