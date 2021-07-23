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
<TITLE>#### <%=mHead%> [ View Student Opted Subjects ] </TITLE>
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
double mCCP=0;
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="",mSubSect="",mPrcode="";
int msno=0,msno1=0;
String mSem="";
String mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mName="";
String mINSTITUTECODE="",mE="";
String mEmployeeID="";
String mSemtype="",mSubtype="",mComp="";
ResultSet rs=null,rs1=null, rsCCP=null;;

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
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
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

	qry="Select max(Semester) Sem from studentRegistration where studentid='"+mChkMemID+"'";
	//out.print(qry);
	RsChk=db.getRowset(qry);
	if(RsChk.next())
		mSem=RsChk.getString("Sem");


  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('53','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
	qry=" select 'y' from ";
	qry=qry+" StudentMaster where StudentID='" +mMemberID+ "' and  InstituteCode='" + mINSTITUTECODE+ "' and ";
	qry=qry+" STUDENTID in (SELECT MemberID FROM PREVENTS WHERE INSTITUTECODE='"+ mINSTITUTECODE+"' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mINSTITUTECODE+"'  ";
	qry=qry+" and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
	qry=qry+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='S' and MEMBERID='"+mMemberID+"')";
	//qry=qry+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N')";
	//out.println(qry);
	rs=db.getRowset(qry);
	
	if (rs.next())	
	{
		%>
		<table width=100%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
		<form name="frm1" method=post>
		<input id="x" name="x" type=hidden>
		<tr bgcolor="#ff8c00">
		<td colspan=6 align=center><b><font color=white>VIEW STUDENT SUBJECT CHOICE</font></B></td>
		</tr>

		<tr><td>&nbsp;<font color=black face=arial size=2><STRONG> Name:&nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mName)%> [<%=mDMemberCode%>]</td>
		<td><font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><%=mProg%> [<%=mBranch%>]</td>
		<td><font color=black face=arial size=2><STRONG>Semester:&nbsp;</STRONG></font><%=mSem%></td></tr>

		<tr><td colspan=3 align=center>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
		<%
	//	  qry="select distinct nvl(PREREGEXAMID,' ')examcode from companyinstitutetagging where institutecode='"+mINSTITUTECODE+"'    ";	


		 qry="SELECT DISTINCT examcode, FROMDATE           FROM preventmaster          WHERE institutecode = '"+mINSTITUTECODE+"'            AND NVL (prcompleted, 'N') = 'N'            AND NVL (prbroadcast, 'N') = 'Y'            AND prrequiredfor ='"+mChkMType+"'           AND NVL (deactive, 'N') = 'N' and preventcode in (SELECT distinct preventcode            FROM prevents           WHERE institutecode = '"+mINSTITUTECODE+"' and memberid='"+mMemberID+"' and  membertype = '"+mChkMType+"' )           order by FROMDATE ";
		 
	//	 out.print("exam code :"+qry);
		  rs=db.getRowset(qry);
		%>
		<select name=exam tabindex="0" id="exam" style="WIDTH: 140px">	
		<%
	  	if(request.getParameter("x")==null)
		{	
			while(rs.next())
			{
				mexamcode=rs.getString("examcode");
				%>
					<option selected value=<%=mexamcode%>><%=mexamcode%></option>
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
	&nbsp; &nbsp; &nbsp; &nbsp; 
	<input type="submit" value="Show"></td></tr>
	</table>
	
	
	<%
	if (request.getParameter("Exam")==null)
		mE=mexamcode;
	else
		mE=request.getParameter("Exam").toString().trim();

	/*qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+"nvl(B.CHOICE,'') CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,nvl(B.ELECTIVECODE,'') ELECTIVECODE,";
	qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B,OfferSUBJECTTAGGING C";
	qry=qry+" where B.examcode='"+mE+"' AND B.examcode=C.EXAMCODE and B.institutecode='"+mINSTITUTECODE+"' AND B.INSTITUTECODE=C.INSTITUTECODE"; 	
	qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID AND A.subjectID=C.SUBJECTID order by CHOICE, SUBJECT";*/
	
	qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+"nvl(B.CHOICE,'') CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,nvl(B.ELECTIVECODE,'') ELECTIVECODE,";
	qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
	qry=qry+" where B.examcode='"+mE+"' and B.institutecode='"+mINSTITUTECODE+"' and B.SEMESTERTYPE='REG' and B.SUBJECTTYPE='C' "; 	
	qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID order by CHOICE, SUBJECT";
	//out.print("1. "+qry);
	rs1=db.getRowset(qry);
	msno=0;
    //msno1=0;
	while(rs1.next())
	{
       	  msno++;
	     // mSemtype=rs1.getString("SEMESTERTYPE");
		 // mSubtype=rs1.getString("SUBJECTTYPE");
	 	if(msno==1)
		{
       %>
	        
			<table width=100%><tr><td><center><font color="#00008b" face="Verdana" size=2><b>List of Core Subject-Choice for Regular Semester</b></font></center></td></tr></table>
			<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
	        <thead>
	        <tr bgcolor="#ff8c00">
	        <td align=center width=5%><b><font color=white>SNo.</font></b></td>
	        <td width=60%><b><font color=white>Subject</font></b></td>
	        <td width=25%><b><font color=white>Subject Type</font></b></td>	
	        <td width=5% align=center><b><font color=white>Choice</font></b></td>
	        </tr>
	        </thead>
	        <tbody>
			<%
		}
	   
	        %>
		   	<tr>
			<td align=center><%=msno%>.</td>
			<%
			if(rs1.getString("SUBJECTTYPE").equals("F"))
				mSubtype="Free Elective";
			else if(rs1.getString("SUBJECTTYPE").equals("C"))
				mSubtype="Core";
			else
			{
				mSubtype=rs1.getString("ELECTIVECODE");	
				mSubtype="Elective ["+mSubtype+"]";
			}
			%>
			<td><%=rs1.getString("SUBJECT")%></td>
			<td><%=mSubtype%></TD>
			<td align=center><%=rs1.getString("CHOICE")%></TD>
			
	    		<%
			}
	%>
	</tbody>
	</table>
	<script type="text/javascript">
	 var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number"]);
    </script>
	<%
	qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+"nvl(B.CHOICE,'') CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,nvl(B.ELECTIVECODE,'') ELECTIVECODE,";
	qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
	qry=qry+" where B.examcode='"+mE+"' and B.institutecode='"+mINSTITUTECODE+"' and B.SEMESTERTYPE='REG' and B.SUBJECTTYPE='E' "; 	
	qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID order by CHOICE, SUBJECT";
	//out.print("2. "+qry);
	rs1=db.getRowset(qry);
	msno=0;
   // msno1=0;
	while(rs1.next())
	{
       	  msno++;
	      //mSemtype=rs1.getString("SEMESTERTYPE");
		 // mSubtype=rs1.getString("SUBJECTTYPE");
	 	
           if(msno==1)
		{ 	
			
			%>
			
			<table width=100%><tr><td><center><font color="#00008b" face="Verdana" size=2><b>List of Elective Subject-Choice for Regular Semester</b></font></center></td></tr></table>
			<table bgcolor=#fce9c5 class="sort-table" id="table-2" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
	        <thead>
	        <tr bgcolor="#ff8c00">
	        <td align=center width=5%><b><font color=white>SNo.</font></b></td>	
	        <td width=60%><b><font color=white>Subject</font></b></td>
	        <td width=25%><b><font color=white>Subject Type</font></b></td>	
	        <td width=5% align=center><b><font color=white>Choice</font></b></td>
	        </tr>
	        </thead>
	        <tbody>
			<%}%>
		   	<tr>
			<td align=center><%=msno%>.</td>
			<%
			if(rs1.getString("SUBJECTTYPE").equals("F"))
				mSubtype="Free Elective";
			else if(rs1.getString("SUBJECTTYPE").equals("C"))
				mSubtype="Core";
			else
			{
				mSubtype=rs1.getString("ELECTIVECODE");	
				mSubtype="Elective ["+mSubtype+"]";
			}
			%>
			<td><%=rs1.getString("SUBJECT")%></td>
			<td><%=mSubtype%></TD>
			<td align=center><%=rs1.getString("CHOICE")%></TD>
			
	    		<%
			}
	%>
	</tbody>
	</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-2"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number"]);
	</script>	
	
	<%
	qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+"nvl(B.CHOICE,'') CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,nvl(B.ELECTIVECODE,'') ELECTIVECODE,";
	qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
	qry=qry+" where B.examcode='"+mE+"' and B.institutecode='"+mINSTITUTECODE+"' and B.SEMESTERTYPE='REG' and B.SUBJECTTYPE='F' "; 	
	qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID order by CHOICE, SUBJECT";
	//out.print("2. "+qry);
	rs1=db.getRowset(qry);
	msno=0;
   // msno1=0;
	while(rs1.next())
	{
       	  msno++;
	      //mSemtype=rs1.getString("SEMESTERTYPE");
		 // mSubtype=rs1.getString("SUBJECTTYPE");
	 	
           if(msno==1)
		{ 	
			
			%>
			
			<table width=100%><tr><td><center><font color="#00008b" face="Verdana" size=2><b>List of  Free Elective Subject-Choice for Regular Semester</b></font></center></td></tr></table>
			<table bgcolor=#fce9c5 class="sort-table" id="table-3" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
	        <thead>
	        <tr bgcolor="#ff8c00">
	        <td align=center width=5%><b><font color=white>SNo.</font></b></td>
	        <td width=60%><b><font color=white>Subject</font></b></td>
	        <td width=25%><b><font color=white>Subject Type</font></b></td>	
	        <td width=5% align=center><b><font color=white>Choice</font></b></td>
	        </tr>
	        </thead>
	        <tbody>
			<%}%>
		   	<tr>
			<td align=center><%=msno%>.</td>
			<%
			if(rs1.getString("SUBJECTTYPE").equals("F"))
				mSubtype="Free Elective";
			else if(rs1.getString("SUBJECTTYPE").equals("C"))
				mSubtype="Core";
			else
			{
				mSubtype=rs1.getString("ELECTIVECODE");	
				mSubtype="Elective ["+mSubtype+"]";
			}
			%>
			<td><%=rs1.getString("SUBJECT")%></td>
			<td><%=mSubtype%></TD>
			<td align=center><%=rs1.getString("CHOICE")%></TD>
			
	    		<%
			}
	%>
	</tbody>
	</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-3"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number"]);
    </script>	
	
	
	
	<%
	qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry="select DISTINCT a.SubjectID SubjectID, nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT  ,";
qry=qry+"nvl(B.CHOICE,0) CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,decode(B.subjecttype,'C','Core','E','Elective')ELECTIVECODE, ";
qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE   from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
qry=qry+" where B.examcode='"+mE+"' and B.institutecode='"+mINSTITUTECODE+"' And b.semestertype in ('RWJ','SAP') ";
qry=qry+" and B.studentid='"+mMemberID+"' And B.SUBJECTTYPE='C' and  A.subjectID=B.subjectID  ";
//out.print(qry);
	rs1=db.getRowset(qry);
	msno=0;
	while(rs1.next())
	{
	msno++ ;
	qry="select max(COURSECREDITPOINT)COURSECREDITPOINT from (Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT From PROGRAMSUBJECTTAGGING C where examcode='"+mE+"'  And subjectid='"+rs1.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mINSTITUTECODE+"'";
	qry=qry+" UNION Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT   From OfferSubjectTagging C where examcode='"+mE+"'  And subjectid='"+rs1.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mINSTITUTECODE+"')";
	//out.print(qry);
	rsCCP=db.getRowset(qry);
	if (rsCCP.next())
	{
		mCCP=rsCCP.getDouble("COURSECREDITPOINT");
	}
	else
	{
		mCCP=0;
	}
	mSubtype=rs1.getString("ELECTIVECODE");
	     // mSemtype=rs1.getString("SEMESTERTYPE");
		 // mSubtype=rs1.getString("SUBJECTTYPE");
	 	
           if(msno==1)
		{
			
			%>
			
			<table width=100%><tr><td><center><font color="#00008b" face="Verdana" size=2><b>List of  Subject-Choice for Back Log Papers</b></font></center></td></tr></table>
			<table bgcolor=#fce9c5 class="sort-table" id="table-4" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
	        <thead>
	        <tr bgcolor="#ff8c00">
	        <td align=center width=5%><b><font color=white>SNo.</font></b></td>
	        <td width=60%><b><font color=white>Subject</font></b></td>
	        <td width=25%><b><font color=white>Subject Type</font></b></td>	
	        <td width=5% align=center><b><font color=white>Choice</font></b></td>
	        </tr>
	        </thead>
	        <tbody>

			<%}%>
		   	<tr bgcolor='#FFB9B9'>
			<td align=center><%=msno%>.</td>

	<td><%=rs1.getString("SUBJECT")%></td>
		<td><%=mSubtype%></TD>
	<td><%=rs1.getString("Choice")%></TD>
	<!-- <td><%//=mCCP%></td> --></tr>		   
	<%
			}
	%>
    </tbody>
	</table>
	<script type="text/javascript">
	 var st1 = new SortableTable(document.getElementById("table-4"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number"]);
	 </script>
	
				<%
	
	qry="select NOOFELESUBJECTSCHOICES from  prevents  where institutecode = '"+mINSTITUTECODE+"' and  MEMBERID= '"+mChkMemID+"'    and  (preventcode) IN (SELECT preventcode FROM preventmaster   WHERE institutecode = '"+mINSTITUTECODE+"'                        AND examcode = '"+mE+"'                                                AND NVL (prcompleted, 'N') = 'N'                        AND NVL (prbroadcast, 'N') = 'Y'                        AND prrequiredfor = 'S'                        AND NVL (deactive, 'N') = 'N' )  and nvl(deactive,'N')<>'Y' ";
	rs=db.getRowset(qry);
	//out.println(qry);
	if(rs.next() && msno==1)
	{
			out.println("<br><br><center><font size=3 color='red'>You are requested to "+rs.getString(1)+" electives</font></center></b><br>");
			
	}		
	
	}					
	else
	{
	%>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
	 <%
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
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br> 
   <%
	}
    		 //-----------------------------
  }   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
if(msno==0 || msno1==0)
{
%>
<%
}
}//1	
catch(Exception e)
{
	
}
%>
</form>
</body>
</html>