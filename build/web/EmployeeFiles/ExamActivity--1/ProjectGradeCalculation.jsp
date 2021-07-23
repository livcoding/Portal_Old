<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String temp="";
String qry="";
ResultSet rs=null,rs1=null;
String qrys="";
ResultSet rss=null;
ResultSet rss1=null;
String mInst="", mComp="";
int mSno1=0;
String mNames="";
DBHandler db=new DBHandler();
String mDefault="";
int ctr=0;
String mHead="", mExamid="";
String mysubjcode="",mETOD="",mSem1="",qry1="";
session.setAttribute("GRADEMASTERSET",null);
session.setAttribute("GRADEINITIALCOUNT",null);
session.setAttribute("GRADECHECKED",null);
session.setAttribute("GRADEUNCHECKED",null);
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) 
  top.document.title = document.title;
//-->
</script>
<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);
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
<script language=javascript>
function checkradio(temp)
{
	if(temp=='')
	{
	var val;
	val=document.frm1.jss.value;
	var mNames;
	var val1=parseInt(val);
	var i=1;
	
	while(i<=val1)
	{
		mNames="RADIO"+i;

		if(document.frm1[mNames][0].checked==false)
		{
			alert('Please select the Yes option to Proceed');
			return false;
		}
		else
		{
		
		}
		i++;
	}
	var ret=checkBox();
	
	return ret;
	}
}

function checkBox()
{
	var val;
	val=document.frm1.checkctr.value;
	var mNames;
	var val1=parseInt(val);
	var i=1;
	while(i<=val1)
	{
		mNames="FSTID"+i;
		if(document.frm1[mNames].checked==true)
		{
			return true;
		}
		
		i++;
	}
	alert('Please select the atleast one checkbox');

	return false;
}
</script>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
try
{
OLTEncryption enc=new OLTEncryption();
int mFlag=0;
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="";
String mECode="",mecode="", mDesg="", mDept="";
int mSno=0;
String mName="";
String mSCode="",mscode="";
String mEC="",mSC="";
String mName1="", 	PREVIOUSEXAMCODE="",PREVIOUSSUBJECTID="";

if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
							
if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
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
if (session.getAttribute("CompanyCode")==null)
{
 	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
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
   qry="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
   RsChk= db.getRowset(qry);
   if (RsChk.next() && RsChk.getString("SL").equals("Y"))
   {
	%>
	<form name="frm0" method="post" >
	<input id="xx" name="xx" type=hidden>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Project Grade Calculation</b></TD>
	</font></td></tr>
	</TABLE>
	<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
	<tr><td colspan=2 align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Employee : &nbsp;</STRONG></font><font color=black face=arial size=2><%=mMemberName%>[<%=mDMemberCode%>]
	&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDept)%>
	&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesg)%>
	<hr></td></tr>

	<!--Institute****-->
	<tr><td colspam=2 align=center><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
	&nbsp; &nbsp;<select name=InstCode tabindex="0" id="InstCode">
	<OPTION selected Value =<%=mInst%>><%=mInst%></option>
	</select>
	&nbsp; &nbsp; &nbsp;
	<FONT color=black face=Arial size=2><STRONG>Exam Code</STRONG></FONT>
	<%
	
//**************CHANGE THE QUERY 27/01/2010**************************


	qry=" Select nvl(EXAMCODE,' ') Exam from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND";
	qry+=" nvl(Deactive,'N')='N' AND NVL(LOCKEXAM,'N')='N' and examcode in (Select examcode from facultysubjecttagging WHERE  (NVL(LTP,'N')='P' OR  NVL(PROJECTSUBJECT,'N')='Y' ) )";
      //qry+=" and examcode in (select nvl(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
	qry+=" order by Exam DESC";
	
	//out.print(qry);
	rs=db.getRowset(qry);
	%>
	<select name="ExamCode" tabindex="0" id="ExamCode">	
	<%
	try
	{ 
		if (request.getParameter("xx")==null)
		{
			%>
			<OPTION selected Value="NONE"><b><-- Select an Exam Code --></b></option>
			<%
			while(rs.next())
			{
				mExamid=rs.getString("Exam");
				%>
				<OPTION Value =<%=mExamid%>><%=mExamid%></option>
				<%
			}
		}
		else
		{
			%>
			<OPTION Value="NONE"><b><-- Select an Exam Code --></b></option>
			<%
	 		while(rs.next())
			{
				mExamid=rs.getString("Exam");
				if(mExamid.equals(request.getParameter("ExamCode").toString().trim()))
				{
					%>
					<OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
					<%			
				}
			     	else
			      {
					%>
		     			<OPTION Value =<%=mExamid%>><%=mExamid%></option>
		     			<%			
			   	}
		 	}
		}
	}
	catch(Exception e)
	{
		//out.println(e.getMessage());
	}
	%>
	</select>
	&nbsp; &nbsp; &nbsp;
	<INPUT Type="submit" Value="&nbsp; OK &nbsp;">
	</tr></td>
	</table>
	</form>
	<%
	if(request.getParameter("xx")!=null)
	{
	   if(request.getParameter("ExamCode")!=null && !request.getParameter("ExamCode").equals("NONE"))
	   {
		mExamid=request.getParameter("ExamCode").toString().trim();
		mDefault=mExamid;
		%>
		<form name="frm"  method="post" >
		<input id="xx" name="xx" type=hidden>
		<input id="x" name="x" type=hidden>
		<input type=hidden value=<%=mInst%>id="InstCode" name="InstCode">
		<input type=hidden value=<%=mExamid%> id="ExamCode" name="ExamCode">
		<table cellpadding=1 cellspacing=0 align=center rules=groups border=1>
		<!--Institute-->
		<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
		<tr><td colspan=3><FONT color=black face=Arial size=2><STRONG>Co Ordinator Name : </STRONG></FONT><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
		<tr>
		<td colspan=2>
		<FONT color=black face=Arial size=2><STRONG>Subject</STRONG></FONT>
		<%
	

		qry="SELECT DISTINCT a.subjectid subjectid, b.subject || '(' || b.subjectcode || ')' subject           FROM (SELECT DISTINCT subjectid, fstid FROM facultysubjecttagging aa                           WHERE institutecode = '"+mInst+"'   AND examcode = '"+mDefault+"'  AND NVL (deactive, 'N') = 'N'               AND employeeid = '"+mChkMemID+"' AND (      ltp = 'P'  AND projectsubject = 'Y'                                      AND EXISTS ( SELECT 1 FROM programsubjecttagging                                             WHERE examcode = '"+mDefault+"'  AND institutecode ='"+mInst+"'                                                AND subjectid = aa.subjectid  AND l = 0   AND p > 0 AND  NVL(DUALSEMSUBJECT,'N')='N')    )";
		qry=qry+" union ";
		qry=qry+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
		qry=qry+" examcode='"+mDefault+"' and COORDINATORID='"+mChkMemID+"' and LTP='P' ";
		qry=qry+" union ";
		qry=qry+" select distinct subjectID,fstid from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
		qry=qry+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' AND NVL(DEACTIVE,'N')='N' and LTP='P'";
		qry=qry+" MINUS ";
		qry=qry+" (select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
		qry=qry+" where  employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and LTP='P' ";
		qry=qry+" union ";
		qry=qry+" select distinct subjectID,fstid from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
		qry=qry+" examcode='"+mDefault+"' and CORDFACULTYID<>'"+mChkMemID+"' AND NVL(DEACTIVE,'N')='N' and LTP='P') ) A,subjectmaster B where A.subjectID=B.subjectID and b.INSTITUTECODE='"+mInst+"'";
		//out.println(qry);
		%><select name=Subject tabindex="0" id="Subject" style="WIDTH: 510px" > <%
		rs=db.getRowset(qry);
		if (request.getParameter("x")==null) 
		{
			while(rs.next())
			{  
				mSCode=rs.getString("SUBJECTID");
				if(mscode.equals(""))
				%>
				<OPTION Value =<%=mSCode%>><%=rs.getString("SUBJECT")%></option>
				<%
			}
		} // closing of if 
		else
		{
			while(rs.next())
			{
				mSCode=rs.getString("SUBJECTID");
				if(mSCode.equals(request.getParameter("Subject").toString().trim()))
				{
					%>
					<OPTION selected Value =<%=mSCode%>><%=rs.getString("SUBJECT")%></option>
					<%
				}
				else
				{
					%>
					<OPTION Value =<%=mSCode%>><%=rs.getString("SUBJECT")%></option>
					<%
				}
			} //closing of while
		} // closing of else
		%>
		</select>
		<input type=HIDDEN name=ETOD id=ETOD VALUE="N" checked=true ><!--<b>Normal</b>-->
		<input type=HIDDEN name=ETOD id=ETOD VALUE="E" ><!--<b>EtoD</b>-->
		<input type=submit value="Continue" >
		</td>
		</tr>
		</TABLE>
		</FORM>
		<%
		if(request.getParameter("x")!=null)
		{
			mEC=request.getParameter("ExamCode").toString().trim();
			mSC=request.getParameter("Subject").toString().trim();
			mETOD=request.getParameter("ETOD").toString().trim();

			/*qry="select 'y' from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and ";
			qry=qry+" a.subjectid='"+mSC+"' and a.employeeid='"+mChkMemID+"' and exists ";
			qry=qry+" (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
			qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='N' and  a.examcode=b.examcode and ";
			qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid )";
			*/

	
			qry1="SELECT DISTINCT  NVL (a.currentexamcode, 'N') currentexamcode,       NVL (a.previousexamcode, 'N') previousexamcode,  NVL (a.previoussubjectid, ' ') previoussubjectid  FROM dualsemsubjmapping a, Programsubjecttagging b WHERE a.currentexamcode = '"+mEC+"' and nvl(b.DUALSEMSUBJECT,'N')='Y'   AND a.institutecode = '"+mInst+"'   AND a.currentsubjectid = '"+mSC+"'    and a.CURRENTEXAMCODE=b.EXAMCODE   and a.CURRENTSUBJECTID=b.SUBJECTID and a.INSTITUTECODE=b.INSTITUTECODE  AND NVL (a.deactive, 'N') = 'N' "	;
	//out.print(qry1);
			rs1=db.getRowset(qry1);

			if(rs1.next())
		
			{
			 	PREVIOUSEXAMCODE=rs1.getString("PREVIOUSEXAMCODE");
				PREVIOUSSUBJECTID=rs1.getString("PREVIOUSSUBJECTID");

			qry="select 'Y' from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and ";
			qry=qry+" a.subjectid='"+mSC+"' and a.CORDFACULTYID='"+mChkMemID+"' and LTP='P' and exists ";
			qry=qry+" (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
			qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='Y'  and  a.examcode=b.examcode and ";
			qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid and LTP='P'  )";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				qry="Select nvl(A.EVENTSUBEVENT,' ') EVENTSUBEVENT,nvl(A.WEIGHTAGE,0) WEIGHTAGE  from V#EXAMEVENTSUBJECTTAGGING A ";
				qry=qry+" WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mEC+"' AND A.SUBJECTID='"+mSC+"' ";
				qry=qry+" and A.CORDFACULTYID='"+mChkMemID+"' and LTP='P' Group By A.EVENTSUBEVENT, A.WEIGHTAGE ORDER BY EVENTSUBEVENT,nvl(A.WEIGHTAGE,0)";
				//out.print(qry);
				rs=db.getRowset(qry);
				double  mAllowedWeightage=0;
				double  MaxAW=100;
				while(rs.next())
				{
					mAllowedWeightage=mAllowedWeightage+rs.getDouble("WEIGHTAGE");
				}
				mAllowedWeightage = MaxAW-mAllowedWeightage;
				//out.println(mAllowedWeightage);
				if(mAllowedWeightage==0.0)
				{
					%>
					<form name="frm1"  method="post" action="ProjectGradeCalculationAction.jsp" >
					<input id="y" name="y" type=hidden>
					<input id="xx" name="xx" type=hidden>
					<input type=hidden value=<%=mInst%>id="InstCode" name="InstCode">
					<input type=hidden value=<%=mExamid%> id="ExamCode" name="ExamCode">
					<table>
					<TABLE align=center rules=group border=1 cellspacing=0 width=98%>
					<%

					qry="SELECT DISTINCT fstid, subjectid, programcode, sectionbranch, subsectioncode,            semester  FROM (SELECT DISTINCT fstid, subjectid, programcode, sectionbranch,              subsectioncode, semester  FROM facultysubjecttagging aa    WHERE institutecode = '"+mInst+"'   AND examcode = '"+mEC+"'   AND employeeid ='"+mChkMemID+"'    AND ( ltp = 'P'  AND projectsubject = 'Y'      AND EXISTS (   SELECT 1  FROM programsubjecttagging     WHERE examcode = '"+mEC+"'    AND institutecode = '"+mInst+"'  AND subjectid = aa.subjectid  AND l = 0 AND p > 0)) AND subjectid = '"+mSC+"'  ";
					qry=qry+" union ";
					qry=qry+" select distinct fstid,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
					qry=qry+" examcode='"+mEC+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
					qry=qry+" union ";
					qry=qry+" select distinct fstid,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
					qry=qry+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N'";
					qry=qry+" MINUS ";
					qry=qry+" select distinct fstid,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR  ";
					qry=qry+" where   examcode='"+mEC+"' and employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' ) ";
					qry=qry+" where fstid not in (select A.fstid from EX#GRADESUBJECTBREAKUP a, GRADECALCULATION c where  A.employeeid='"+mChkMemID+"' AND c.subjectID='"+mSC+"' and c.institutecode='"+mInst+"' and c.examcode='"+mDefault+"'  AND A.BREAK#SLNO=C.BREAK#SLNO 		AND nvl(C.finalized,'N')='Y' )" ;
					/*qry=qry+" where fstid not in (select A.fstid from EX#GRADESUBJECTBREAKUP a, FACULTYSUBJECTTAGGING b, GRADECALCULATION c where  A.employeeid='"+mChkMemID+"' AND A.fstid =B.FSTID AND B.INSTITUTECODE=c.INSTITUTECODE AND B.EXAMCODE=C.EXAMCODE 	AND B.SUBJECTID=C.SUBJECTID 	AND A.BREAK#SLNO=C.BREAK#SLNO 	AND A.EMPLOYEEID=B.EMPLOYEEID 	AND nvl(C.finalized,'N')='Y' )" ;*/
					rs=db.getRowset(qry);
					//out.print(qry);	
					while(rs.next())
					{
						if(ctr==0)
						{
							%><TR>
							<TD>&nbsp;</TD>
							<TD><b>Subject Code</b></TD>
							<TD><b>Programe Code</b></TD>
							<TD><b>Section Branch</b></TD>
							<TD><b>SubSection Code</b></TD>
							<TD><b>Semester<b></TD>
							</TR><%
						}
						ctr++;
						mSem1=rs.getString("SEMESTER");
						mName1="FSTID"+ctr;
						qry="select  subjectcode from subjectmaster where  INSTITUTECODE='"+mInst+"' and subjectid='"+rs.getString("subjectid")+"'";
						rss1=db.getRowset(qry);	
						if(rss1.next())
						{
							mysubjcode=rss1.getString(1);	
						}
						//String query1111="SELECT 'Y' FROM ex#gradesubjectbreakup a,facultysubjecttagging b,                   gradecalculation c WHERE a.employeeid = '"+mChkMemID+"' AND a.fstid = b.fstid and  b.institutecode = c.institutecode AND b.examcode = c.examcode AND b.subjectid = c.subjectid AND a.break#slno = c.break#slno AND a.employeeid = b.employeeid  AND c.status <> 'A'";
						String query1111="SELECT 'Y' FROM ex#gradesubjectbreakup a,facultysubjecttagging b,                   gradecalculation c WHERE a.employeeid = '"+mChkMemID+"' AND a.fstid = b.fstid and  b.institutecode = c.institutecode AND b.examcode = c.examcode AND b.subjectid = c.subjectid AND a.break#slno = c.break#slno AND c.status <> 'A'";
						ResultSet rssss1=db.getRowset(query1111);
						if(rssss1.next())
						{
							//	String query111="SELECT a.fstid FROM ex#gradesubjectbreakup a,facultysubjecttagging b,                   gradecalculation c WHERE a.employeeid = '"+mChkMemID+"' AND a.fstid = b.fstid AND a.fstid = '"+rs.getString("fstid")+"' AND b.institutecode = c.institutecode AND b.examcode = c.examcode AND b.subjectid = c.subjectid AND a.break#slno = c.break#slno AND a.employeeid = b.employeeid  AND c.status <> 'A'";
							String query111="SELECT a.fstid FROM ex#gradesubjectbreakup a,facultysubjecttagging b,                   gradecalculation c WHERE a.employeeid = '"+mChkMemID+"' AND a.fstid = b.fstid AND a.fstid = '"+rs.getString("fstid")+"' AND b.institutecode = c.institutecode AND b.examcode = c.examcode AND b.subjectid = c.subjectid AND a.break#slno = c.break#slno   AND c.status <> 'A'";
							ResultSet rssss=db.getRowset(query111);
							if(rssss.next())
							{
								temp="hidden";
							}
							else
							{
								temp="";
							}
						}
						else
						temp="";
						%>
						<TR>
						<TD>
						<INPUT TYPE="hidden" NAME="<%=mName1%>" ID="<%=mName1%>" VALUE="<%=rs.getString("fstid")%>">selected</TD> 
						<TD><%=mysubjcode%></TD>
						<TD><%=rs.getString("programcode")%></TD>
						<TD><%=rs.getString("SECTIONBRANCH")%></TD>
						<TD><%=rs.getString("SUBSECTIONCODE")%></TD>
						<TD><%=rs.getString("SEMESTER")%></TD>
						</TR>
						<%
					} // closing of while
					if(ctr==0)
					{
						out.print(" &nbsp;&nbsp;&nbsp <p align=center><b><font size=3 face='Arial' color='Red'>Grade already freezed</font> <br>");
					}
					%>
					<INPUT TYPE="hidden" NAME="checkctr" value="<%=ctr%>">
					</table>
					<br>
					<table align=center rules=group border=1 cellspacing=0 width=98%> 
					<%
					qry="select question ,questionid from EXAMGRADEQUESTION where institutecode='"+mInst+"' and examcode='"+mDefault+"' and nvl(DEACTIVE,'N')='N' order by questionid ";
					rs=db.getRowset(qry);
					while(rs.next())
					{	
						mSno++;
						mName="RADIO"+mSno;
						if(mFlag==0)
						{
							%>
							<tr>
							<td>&nbsp;</td>
							<td><b> SNo.</b></td>
							<td nowrap><b>Question Descscription</b></td>
							</tr>
							<%
						}
						mFlag=1;
						%>
						<tr>
						<td nowrap>
						<input type="radio" value="Y" name="<%=mName%>" id="<%=mName%>" ><b>Yes</b>
						<input type="radio" value="N" name="<%=mName%>" id="<%=mName%>" checked=true><b>No</b></td>
						<td><%=rs.getString("questionid")%>
						</td>
						<td nowrap><%=rs.getString("question")%></td>
						</tr>
						<%
					}
				 	%>
					<input type="hidden" name="jss" id="jss" value="<%=mSno%>">
					<input type="hidden" name="ExamCode" id="ExamCode" value="<%=mEC%>">
						<input type="hidden" name="PREVIOUSEXAMCODE" id="PREVIOUSEXAMCODE" value="<%=PREVIOUSEXAMCODE%>">
						<input type="hidden" name="PREVIOUSSUBJECTID" id="PREVIOUSSUBJECTID" value="<%=PREVIOUSSUBJECTID%>">
					<input type="hidden" name="Subject" id="Subject" value="<%=mSC%>">
					<input type="hidden" name="ETOD" id="ETOD" value="<%=mETOD%>">
					<input type="hidden" name="SEMESTER" id="SEMESTER" value="<%=mSem1%>">
					</table>
					<table align=center rules=group border=1 cellspacing=0 width=98%>
					<tr>
					<td  align=center>
					<%
					if(ctr>0)
					{
						%>
						<input type=submit value="Continue" onClick="return checkradio(<%=temp%>)">
						<%
					}
					%>
					</td>
					</tr>
					</table>
					</form>
					<form name="frm11"  method="post" action="DeleteGradeCalculation.jsp" >
					<input id="xx" name="xx" type=hidden>
					<input type=hidden value=<%=mInst%>id="InstCode" name="InstCode">
					<input type=hidden value=<%=mExamid%> id="ExamCode" name="ExamCode">
					<input id="z" name="z" type=hidden>
					<%
					qry=" select 'y' from gradecalculation where examcode='"+mEC+"' and subjectid='"+mSC+"' ";
					qry=qry+" and status='D' and entryby='"+mChkMemID+"'";
					rs=db.getRowset(qry);
					if(rs.next())
					{
						%>
						<!--
						<table align=center rules=group border=1 cellspacing=0 width=98%>
						<tr>
						<td  align=center>
						<input type=submit value="Delete Previous Saved Grades">
						</td>
						</tr>
						<input type="hidden" name="ExamCode" id="ExamCode" value="<%=mEC%>">
						<input type="hidden" name="Subject" id="Subject" value="<%=mSC%>">
						</table>
						-->
						<%
					}
					%>
					</form>
					<%
				}
				else
				{
					out.print(" &nbsp;&nbsp;&nbsp <p align=center><b><font size=3 face='Arial' color='Red'>Exam Events for Marks entry of 100 weightage has not been Created.</font> <br>");
					//out.print(qry);
					rs=db.getRowset(qry);
					%>
					<br>
					<table align=center border=1 cellpadding=0 cellspacing=0>
					<tr>
					<Th>Event/Sub Event</Th>
					<Th>Weightae</Th>
					</tr>
					<%
					double d=0;
					while(rs.next())
					{
						%>
						<tr>
						<td align=center><%=rs.getString("EVENTSUBEVENT")%></td>
						<td align=Right><%=rs.getString("WEIGHTAGE")%>&nbsp; &nbsp;</td>	
						</tr>
						<%
						d+=rs.getDouble("WEIGHTAGE");
					}
					%>
					<tr>
					<TD align=Center>Total: </td><td align=right><b><%=d%></b>&nbsp; &nbsp;</TD>
					</tr>
					<tr><td colspan=2><font color= red><b>Total assigned weightage is <%=d%> out of 100</b></font></td></tr>
					</table>
					<%
				}
			} // closing of !rs.next
			else
			{
				out.print(" &nbsp;&nbsp;&nbsp <center><b><font size=3 face='Arial' color='Red'>Marks Entry and Locking of following events is/are not completed.</font> <br>");
				qry="select distinct EVENTSUBEVENT,weightage,decode(a.PUBLISHED,'N','Marks are not Locked','Y','Marks are Locked',a.PUBLISHED)PUBLISHED  from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and ";
				qry=qry+" a.subjectid='"+mSC+"' and a.CORDFACULTYID='"+mChkMemID+"' "; 
				
				/*exists ";
				qry=qry+" (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
				qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='N' and  a.examcode=b.examcode and ";
				qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid )";*/
				//out.print(qry);
				rs=db.getRowset(qry);
				%>
				<br>
				<table align=center border=1 cellpadding=0 cellspacing=0>
				<tr>
				<Th>Event/Sub Event</Th>
				<Th>Weightae</Th>
					<Th>Status</Th>
				</tr>
				<%
				double d=0;
				while(rs.next())
				{
					%>
					<tr>
					<td align=center><%=rs.getString("EVENTSUBEVENT")%></td>
					<td align=Right><%=rs.getString("WEIGHTAGE")%>&nbsp; &nbsp;</td>
					<td align=Right><%=rs.getString("PUBLISHED")%>&nbsp; &nbsp;</td>
					</tr>
					<%
					d+=rs.getDouble("WEIGHTAGE");
				}
				%>
				<tr>
				<TD align=Center>Total: </td>
				<td align=right><b><%=d%></b>&nbsp; &nbsp;</TD>
				<TD >&nbsp;&nbsp;</td>
				
				</tr>
				<tr><td colspan=3><font color= red><b>Total assigned weightage is <%=d%> out of 100</b></font></td></tr>
				</table>
				<%
			}
		}
		else
		   {
			
				out.print(" &nbsp;&nbsp;&nbsp <center><b><font size=3 face='Arial' color='Red'>Please check If this Subject is For Dual Grade Entry in this ExamCode!</font></center> <br>");
		   }
		}
	   }
	   else
	   {
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Select an Exam Code !</font> <br>");
	   }
	}
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
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}    
}
catch(Exception e)
{
//out.print(e+qry);
}
%>