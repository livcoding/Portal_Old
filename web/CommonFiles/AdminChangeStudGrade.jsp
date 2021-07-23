

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
<script language="JavaScript" type ="text/javascript">
function ChkMaxLenth()
{
    var remarks=document.SaveGrades.RemToAppr.value;
    if(trim(remarks,' ')==null || trim(remarks,' ')=='')
        {
        alert('Remarks for Approval should not be blank...!');
        return false;
        }
	if(remarks.length>250)
	{
		alert('Remarks for Approval should not exceed 250 characters..!');
		return false;
	}
    return true;
}
function trim(str, chars) {
	return ltrim(rtrim(str, chars), chars);
}

function ltrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}

function rtrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
' 
*************************************************************************************************
	' *												
	' * File Name:	AdminChangeStudGrade.JSP		[For Admin]					
	' * Author:		Vijay Kumar
	' * Date:		4th Jun 2009
	' * Version:	1.0
	' * Description:	Grade Card of Students
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String qry1="", qry2="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="", mGFlag="";
String QryExam="", mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mSem="",mName="";
String mINSTITUTECODE="";
String mEmployeeID="";
String mSUBJECTCODE="", ABC="";
String mEName="",mSID="";
ResultSet rs=null,rs1=null,rs2=null,rss1=null;

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
if (request.getParameter("INSCODE")==null)
{
	mINSTITUTECODE ="";
}
else
{
	mINSTITUTECODE =request.getParameter("INSCODE").toString().trim();
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

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
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
	qry="Select WEBKIOSK.ShowLink('159','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
	<input id="INSCODE" name="INSCODE" value="<%=mINSTITUTECODE%>" type="hidden">
	<input type=hidden value=<%=mSID%> id=SID Name=SID>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr>
	<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Change Student Grade</b></font></td>
	</tr>
	</table>

	<table rules=groups cellspacing=1 cellpadding=1 align=center border=2>
	<tr><td NOWRAP><font color=black face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="Vardana"><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</font>
	&nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="Vardana"><%=mProgr%>(<%=mBran%>)</font>
	&nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="Vardana"><%=mSem1%></font>
	&nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>&nbsp; Exam Code</STRONG></font>
	<%
	qry="select Distinct nvl(examcode,' ')examcode, examperiodfrom From ExamMaster a Where InstituteCode='"+mINSTITUTECODE+"'";
	qry=qry+" And nvl(Finalized, 'N') = 'N' ";
	qry=qry+" And nvl(deactive,'N')='N' and a.EXAMCODE IN (SELECT b.EXAMCODE FROM STUDENTWISEGRADE b where studentid='"+mSID+"') Order By examperiodfrom Desc";
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
			if (QryExam.equals(""))
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
	</form>
	<%
	if(request.getParameter("x")!=null)
	{
		if(request.getParameter("exam")==null)
		{
			 QryExam=QryExam;
		}
		else
		{
			 QryExam=request.getParameter("exam").toString().trim();
		}
		 
	}
	%>
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 border=1>
	<thead>
 	<tr bgcolor="#ff8c00">
	 <td nowrap ALIGN=CENTER><b><font color=white>Subject</font></b></td>
	 <td nowrap ALIGN=CENTER><b><font color=white>Marks Obtained</b></td>
	 <td nowrap ALIGN=CENTER><b><font color=white>Grade Awarded</b></td>
	 <td nowrap ALIGN=CENTER><b><font color=white>New Grade</font></b></td>
	</tr>
	</thead>
	<tbody>
	<%
/*
	qry="select A.FSTID,A.BREAK#SLNO,b.subjectid subjectid, nvl(c.EXAMCODE,' ')EXAMCODE, nvl(B.SUBJECT,' ')||'('||NVL(B.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+ " NVL(A.FINALMARKS,0) FINALMARKS, NVL(A.FINALGRADE,0) FINALGRADE, nvl(A.GRADEFLAG,' ')ETOD, SUM(NVL(C.WEIGHTAGE,0)) MAXMARKS from STUDENTWISEGRADE A, SUBJECTMASTER B, V#EXAMEVENTSUBJECTTAGGING C";
	qry=qry+ " where A.studentid='"+mSID+"' AND a.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL V WHERE v.studentid='"+mSID+"'  ";
	qry=qry+ " and v.examcode=decode('"+QryExam+"','ALL',v.examcode,'"+QryExam+"' ) )";
	qry=qry+ " and A.fstid=C.fstid and nvl(A.DOCMODE,'N')='A'  AND A.STUDENTID=C.STUDENTID AND b.SUBJECTid=C.SUBJECTid";
	qry=qry+ " GROUP BY A.FSTID,A.BREAK#SLNO,c.EXAMCODE,b.subjectid, nvl(B.SUBJECT,' ')||'('||NVL(B.SUBJECTCODE,' ')||')', A.FINALMARKS, A.FINALGRADE, A.GRADEFLAG";
	qry=qry+ " ORDER BY EXAMCODE, SUBJECT, FINALMARKS";
*/
	qry="select A.FSTID,A.BREAK#SLNO,b.subjectid subjectid, nvl(A.EXAMCODE,' ')EXAMCODE, nvl(B.SUBJECT,' ')||' ['||NVL(B.SUBJECTCODE,' ')||']' SUBJECT, ";
	qry=qry+ " NVL(A.FINALMARKS,0) FINALMARKS, NVL(A.FINALGRADE,0) FINALGRADE, nvl(A.GRADEFLAG,' ')ETOD from STUDENTWISEGRADE A, SUBJECTMASTER B, FACULTYSUBJECTTAGGING C";
	qry=qry+ " where A.studentid='"+mSID+"' AND a.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL V WHERE v.studentid='"+mSID+"'  ";
	qry=qry+ " and v.examcode=decode('"+QryExam+"','ALL',v.examcode,'"+QryExam+"' ) )";
	qry=qry+ " and nvl(A.DOCMODE,'N')='A' and A.fstid=C.fstid AND B.SUBJECTID=C.SUBJECTID";
	qry=qry+ " GROUP BY A.FSTID,A.BREAK#SLNO,A.EXAMCODE,b.subjectid, nvl(B.SUBJECT,' ')||' ['||NVL(B.SUBJECTCODE,' ')||']', A.FINALMARKS, A.FINALGRADE, A.GRADEFLAG";
	qry=qry+ " ORDER BY EXAMCODE, SUBJECT, FINALMARKS";
	//out.print(qry);
	rs1=db.getRowset(qry);
	int SNO=0;
	String mObjName="";

	%>
	<form Method=POST Name="SaveGrades" Action="AdminChangeStudGradeAction.jsp">
	<input type="HIDDEN" id='SID' name='SID' Value='<%=mSID%>'>
	<input id="INSCODE" name="INSCODE" value="<%=mINSTITUTECODE%>" type="hidden">
	<%
	while(rs1.next())
	{
		SNO++;
		if(rs1.getString("ETOD").equals("N"))
			mGFlag=" ";
		else
			mGFlag="Yes";

		mObjName="SUBJ"+SNO;
		%>
		<input type="HIDDEN" id='<%=mObjName%>' name='<%=mObjName%>' Value='<%=rs1.getString("SUBJECTID")%>'>
		<%
		mObjName="OLDGRADE"+SNO;
		%>
		<input type="HIDDEN" id='<%=mObjName%>' name='<%=mObjName%>' Value='<%=rs1.getString("FinalGrade")%>'>
		<%
		mObjName="FSTID"+SNO;
		%>
		<input type="HIDDEN" id='<%=mObjName%>' name='<%=mObjName%>' Value='<%=rs1.getString("FSTID")%>'>
	 	<%
		mObjName="BRKNO"+SNO;
		%>
		<input type="HIDDEN" id='<%=mObjName%>' name='<%=mObjName%>' Value='<%=rs1.getString("BREAK#SLNO")%>'>
		<tr>
		<td nowrap><%=rs1.getString("SUBJECT")%></td>		 
		<td nowrap ALIGN=CENTER>&nbsp; &nbsp; <%=rs1.getString("FINALMARKS")%></td>
		<td nowrap align=center><b><%=rs1.getString("FinalGrade")%><b></td>
		<td nowrap align=center>
		<%
		mObjName="NEWGRADE"+SNO;
		%>
		<select Name='<%=mObjName%>' id='<%=mObjName%>'>
		<%
		qry="Select distinct GRADE From GRADEMASTER Where INSTITUTECODE='"+mINSTITUTECODE+"' and GRADE is not null And EXAMCODE='"+QryExam+"' And  nvl(DEACTIVE,'N')='N' order by grade asc";
		rss1=db.getRowset(qry);				
		while(rss1.next())
		{
			if(rs1.getString("FinalGrade").equals(rss1.getString("GRADE")))
			{
				%>
				<option selected Value=<%=rss1.getString("GRADE")%>><%=rss1.getString("GRADE")%></option>
				<%
			}
			else
			{
				%>
				<option Value=<%=rss1.getString("GRADE")%>><%=rss1.getString("GRADE")%></option>
				<%
			}
		}
		%>
		</select>
		</td>
		</tr>	
		<%
	}
	%>
	<tr><td valign=middle align=left colspan=5><BR><Font color=black face=arial size=3><B>Remarks for Approval Request : </B></Font><Br>
	<TextArea Name="RemToAppr" Id="RemToAppr" maxlength=250 cols=68 rows=3 OnChange="return ChkMaxLenth();"></TextArea><font color="red">*</font>
	</td></tr>
	<tr><td align=right colspan=5>
	<input type=hidden id="Tot" name="Tot" value=<%=SNO%>>
	<Input Type="Submit" Value="Save New Grades" OnClick="return ChkMaxLenth();">
	<Input Type="Reset" Value="Reset"></td></tr>
	</form>
	</tbody>
	</table>		
	<%
	if(!ABC.equals(""))
	{
		%>
		<table><tr><td><font size=2 color=red face=arialblack>&nbsp;Hint: </font><font face=arialblack size=2 color=Green>NG* - Not Given</font></td></tr></table>
		<%
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
		<h3>	<br><img src='../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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
</body>
</html>