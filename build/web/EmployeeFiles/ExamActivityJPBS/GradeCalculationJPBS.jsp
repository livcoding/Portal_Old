<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.* ,java.math.* " %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String temp="";
String qry="";
ResultSet rs=null,rs1=null,rs3=null,rsg=null;
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
String mysubjcode="",mETOD="",mSem1="";
session.setAttribute("GRADEMASTERSET",null);
session.setAttribute("GRADEINITIALCOUNT",null);
session.setAttribute("GRADECHECKED",null);
session.setAttribute("GRADEUNCHECKED",null);
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

	
ResultSet rsm=null;

		
			String mUFM="",mPro="";

String mEs="";

double mWeighatage=0;
		String myEvent[]=new String[100];
		double myWeightage[]=new double[100];
		int mIndx=0;
		double mwTot=0,mvalue=0;
 
 
 




String mDet="";
	double mWeig=0,mMax=0,mvalue1=0,mTot=0;

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
String mName1="";

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
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Verdana"><b>JPBS Grade Entry </b></TD>
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
	
	//************01/02/2010 adding in qry=NVL(LOCKEXAM,'N')='N' ******************
	
	qry=" Select nvl(EXAMCODE,' ') Exam, EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND";
	qry+=" nvl(Deactive,'N')='N' AND NVL(LOCKEXAM,'N')='N' and examcode in (Select examcode from facultysubjecttagging)";
      //qry+=" and examcode in (select nvl(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
	qry+=" order by EXAMPERIODFROM DESC";
	
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
		qry="select distinct A.subjectID SUBJECTID,B.subject||'('|| B.SUBJECTCODE ||')' SUBJECT from ( select distinct subjectID,fstid from ";
		qry=qry+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mDefault+"'  AND NVL(DEACTIVE,'N')='N' ";
		qry=qry+" and employeeid='"+mChkMemID+"' and (LTP='L' or LTP='T' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='E' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )))";
		qry=qry+" union ";
		qry=qry+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
		qry=qry+" examcode='"+mDefault+"' and COORDINATORID='"+mChkMemID+"' ";
		qry=qry+" union ";
		qry=qry+" select distinct subjectID,fstid from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
		qry=qry+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' AND NVL(DEACTIVE,'N')='N'";
		qry=qry+" MINUS ";
		qry=qry+" (select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
		qry=qry+" where  employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' ";
		qry=qry+" union ";
		qry=qry+" select distinct subjectID,fstid from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
		qry=qry+" examcode='"+mDefault+"' and CORDFACULTYID<>'"+mChkMemID+"' AND NVL(DEACTIVE,'N')='N') ) A,subjectmaster B where A.subjectID=B.subjectID and b.INSTITUTECODE='"+mInst+"'";
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

			qry="select 'y' from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and ";
			qry=qry+" a.subjectid='"+mSC+"' and a.CORDFACULTYID='"+mChkMemID+"' and exists ";
			qry=qry+" (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
			qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='N' and  a.examcode=b.examcode and ";
			qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid )";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(!rs.next())
			{
				qry="Select nvl(A.EVENTSUBEVENT,' ') EVENTSUBEVENT,nvl(A.WEIGHTAGE,0) WEIGHTAGE  from V#EXAMEVENTSUBJECTTAGGING A ";
				qry=qry+" WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mEC+"' AND A.SUBJECTID='"+mSC+"' ";
				qry=qry+" and A.CORDFACULTYID='"+mChkMemID+"' Group By A.EVENTSUBEVENT, A.WEIGHTAGE ORDER BY EVENTSUBEVENT,nvl(A.WEIGHTAGE,0)";
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
					<form name="frm1"  method="post" action="GradeCalculationActionJPBS.jsp" >
					<input id="y" name="y" type=hidden>
					<input id="xx" name="xx" type=hidden>
					<input type=hidden value=<%=mInst%>id="InstCode" name="InstCode">
					<input type=hidden value=<%=mExamid%> id="ExamCode" name="ExamCode">
					<table>
					<TABLE align=center rules=group border=1 cellspacing=0 width=98% class="sort-table">

					<%
					qry="select distinct fstid,ltp, subjectid,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from ( select distinct fstid,ltp,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from ";
					qry=qry+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mEC+"' ";
					qry=qry+" and employeeid='"+mChkMemID+"' and (LTP='L' or LTP='T' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='E' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 ))) and subjectID='"+mSC+"' ";//(LTP='L' or LTP='P' OR (LTP='E' and PROJECTSUBJECT='Y'))
					qry=qry+" union ";
					qry=qry+" select distinct fstid,ltp,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
					qry=qry+" examcode='"+mEC+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
					qry=qry+" union ";
					qry=qry+" select distinct fstid,ltp,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
					qry=qry+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N'";
					qry=qry+" MINUS ";
					qry=qry+" select distinct fstid,ltp,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR  ";
					qry=qry+" where   examcode='"+mEC+"' and employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' ) ";
					qry=qry+" where fstid not in (select A.fstid from EX#GRADESUBJECTBREAKUP a, GRADECALCULATION c where  A.employeeid='"+mChkMemID+"' AND c.subjectID='"+mSC+"' and c.institutecode='"+mInst+"' and c.examcode='"+mDefault+"'  AND A.BREAK#SLNO=C.BREAK#SLNO 		AND nvl(C.finalized,'N')='Y' )" ;
					/*qry=qry+" where fstid not in (select A.fstid from EX#GRADESUBJECTBREAKUP a, FACULTYSUBJECTTAGGING b, GRADECALCULATION c where  A.employeeid='"+mChkMemID+"' AND A.fstid =B.FSTID AND B.INSTITUTECODE=c.INSTITUTECODE AND B.EXAMCODE=C.EXAMCODE 	AND B.SUBJECTID=C.SUBJECTID 	AND A.BREAK#SLNO=C.BREAK#SLNO 	AND A.EMPLOYEEID=B.EMPLOYEEID 	AND nvl(C.finalized,'N')='Y' )" ;*/
					rs=db.getRowset(qry);
					//out.print(qry);	
					while(rs.next())
					{
						if(ctr==0)
						{
							%>	
							<THEAD>
							<tr bgcolor="#ff8c00">	
							<TD>&nbsp;</TD>
							<TD><Font color=white><b>Subject Code</b></TD>
							<TD><Font color=white><b>Programe Code</b></TD>
							<TD><Font color=white><b>Section Branch</b></TD>
							<TD><Font color=white><b>SubSection Code</b></TD>
							<TD><Font color=white><b>Semester<b></TD>
							<TD><Font color=white><b>LTP<b></TD>
							</TR>
							</THEAD>
							<%
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
						//out.print(query1111);
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
						<TD><%=rs.getString("ltp")%></TD>
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
					<input type="hidden" name="Subject" id="Subject" value="<%=mSC%>">
					<input type="hidden" name="ETOD" id="ETOD" value="<%=mETOD%>">
					<input type="hidden" name="SEMESTER" id="SEMESTER" value="<%=mSem1%>">
					</table>

				    <CENTER>
					
						<font size=2 color="RED" face=verdana><B>'A' - for Absent &nbsp; &nbsp; 'M' - for Medical &nbsp; &nbsp; 'U' - for UFM &nbsp; &nbsp; 'D' - for Debar   &nbsp; &nbsp; 'P' - for Prorata</B>
						<br>
						<marquee  scrolldelay=300  behavior=alternate><b><font size=2 color="green" face=verdana><U>You may click on any header to sort the list by marks in  ascending  or descending order.</U>
						</b>
						</marquee>
						</font><br>

					</CENTER>
                            


	<table border=1 bgcolor=#fce9c5  leftmargin=0 cellpadding=0 cellspacing=0 align=center >
<tr>

<td  valign=top >
	

	<table border=1 bgcolor=#fce9c5 class="sort-table" leftmargin=0 cellpadding=0 cellspacing=0 align=center>

        
	<thead>
	<tr  bgcolor="#ff8c00">
		<td Title="Sort on SlNo" style="height:30px">
				<font color="White" face="arial" ><b>Sr.No.</b></font>
		</td>
	</tr>
	</thead>
		<tbody>
<%
int j=0;
String TRCOLOR1="";

	qry="select distinct fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
	qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester ";
	qry=qry+"  from V#STUDENTEVENTSUBJECTMARKS ";
	qry=qry+" where institutecode='"+mInst+"'  And ";
	qry=qry+" examcode='"+mEC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N' " +
            "  order by enrollmentno" ;
	//AND ENROLLMENTNO='121319'
	rs=db.getRowset(qry);
	//out.print(qry);
	while(rs.next())
	{
j++;
						if(j%2==0)
							TRCOLOR1="White";
						else
							TRCOLOR1="#F8F8F8";

				%>
				<tr  bgcolor="<%=TRCOLOR1%>" >
			<td  style="height:30px" >
			<font size=2 face=arial> <%=j%>
			</font>
			</td>
			</tr>

				<%
}
    %>

	</tbody>
	</table>
	</td>

	<td>
	
			
			<table  bgcolor=#fce9c5 width="100%" rules=group  class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center >

                <thead>
					<tr bgcolor="#ff8c00" style="height:30px" >
					
						<td nowrap><Font color=white><b>Student Name</b></font></td>
						<td nowrap><Font color=white><b>Enrollment No.</b></font></td>

		<%	

		qry="select EVENTSUBEVENT ,WEIGHTAGE,fromd from ( ";
		qry=qry+" select distinct EVENTSUBEVENT ,WEIGHTAGE,FROMDATE,to_char(fromdate,'yyyymmdd')fromd from V#EXAMEVENTSUBJECTTAGGING ";
		qry=qry+" where institutecode='"+mInst+"' AND NVL(DEACTIVE,'N')='N' and examcode='"+mEC+"'  ";
		qry=qry+" and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"'  ";
		qry=qry+" and eventsubevent  in (select eventsubevent from V#STUDENTEVENTSUBJECTMARKS ";
		qry=qry+" where institutecode='"+mInst+"' AND examcode='"+mEC+"'   ";
		qry=qry+" AND NVL(DEACTIVE,'N')='N'  and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"')";
		qry=qry+") GROUP BY EVENTSUBEVENT ,WEIGHTAGE,fromd order by eventsubevent";
		rsm=db.getRowset(qry);
//out.print(qry);



		while(rsm.next())
		{
			myEvent[mIndx]=rsm.getString("EVENTSUBEVENT");
			myWeightage[mIndx]=rsm.getDouble("WEIGHTAGE");

			mEs=rsm.getString("EVENTSUBEVENT");
			mWeighatage=rsm.getDouble("WEIGHTAGE");
			mwTot+=mWeighatage;
	%>
		<td align=left><Font color=white><b><%=mEs%>(<%=mWeighatage%>)</b></td>
	<%	
		mIndx++;
		}		
	%>	
		<td align=left ><Font color=white><b>Total&nbsp;(<%=mwTot%>)</b></td>
		<td align=left><Font color=white><b>Grade</b></td>
		</tr>
		</thead>
		<tbody>
<%
try{
int c=1;
	qry="select distinct fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
	qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester ";
	qry=qry+"  from V#STUDENTEVENTSUBJECTMARKS ";
	qry=qry+" where institutecode='"+mInst+"'  And ";
	qry=qry+" examcode='"+mEC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N' " +
            "  order by enrollmentno" ;
	//AND ENROLLMENTNO='121319'
	rs1=db.getRowset(qry);
	//out.print(qry);
	while(rs1.next())
	{	

 %>	
	<tr style="height:30px">
	
	<td><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>
	<td><%=rs1.getString("enrollmentno")%></td>
	
	
<%

		for(int jp=0;jp<mIndx;jp++)
		{
		
			qry="Select nvl(A.MARKSAWARDED1,0)MARKSAWARDED1,NVL(A.DETAINED,'N')DETAINED,decode(A.UFMMARKS,'Y','*U','N',' ',' ',A.UFMMARKS)UFMMARKS, DECODE(a.PRORATA,'Y','P','N',' ',' ','',a.PRORATA)PRORATA,nvl(A.MAXMARKS,0)MAXMARKS ";
			qry=qry+" from V#STUDENTEVENTSUBJECTMARKS A ";
			qry=qry+" where A.INSTITUTECODE='"+mInst+"' and A.EXAMCODE='"+mEC+"' and ";
			qry=qry+" A.fstid='"+rs1.getString("fstid")+"' AND NVL(DEACTIVE,'N')='N' and A.STUDENTID='"+rs1.getString("studentid")+"' and A.subjectID='"+mSC+"' ";
			qry=qry+" And A.EVENTSUBEVENT='"+myEvent[jp]+"'";
		//	out.print(qry);
			rs3=db.getRowset(qry);
			if(rs3.next())
			{	


				mDet=rs3.getString("DETAINED");
				mWeig=myWeightage[jp];	
				mMax=rs3.getDouble("MAXMARKS");	
				mvalue=rs3.getDouble("MARKSAWARDED1");	
				mvalue1=(mvalue/mMax)*mWeig ;

				mUFM=rs3.getString("UFMMARKS");
				mPro=rs3.getString("PRORATA");
			//	mvalue1=gb.getRound(mvalue1,2);
		
		 if(mDet.equals("D") || mDet.equals("A") || mDet.equals("M") || mDet.equals("P")  || mDet.equals("U") )
				{
				%>
				<td align="right">&nbsp;<font color=red><B><%=mDet%> </td>
				<%
				}	
				else
				{
				mTot=mTot+mvalue1;
					%>
				<td align="right"><%=rs3.getString("MARKSAWARDED1")%> <FONT SIZE="2" COLOR="#006600"><B><%=mUFM%> <%=mPro%></B></FONT> </td>
				<%
				}
		}
		else
			{
	%>
				<td>  </td>
				<%
			
			}
			// CLOSING OF if rs3
}// CLOSING OF For loop
//mTot=gb.getRound(mTot,2);
	%>
		<td align="right"><%=Math.round(mTot)%></td>
	<%
	mTot=0;

	qry="select Finalgrade from studentwisegrade where STUDENTID='"+rs1.getString("studentid")+"' and fstid in ( ";
	qry=qry+" select fstid from v#studentLtpDetail where INSTITUTECODE='"+mInst+"' ";
	qry=qry+"and EXAMCODE='"+mEC+"' and SUBJECTID='"+mSC+"'  and ";
	qry=qry+" SEMESTER='"+rs1.getString("semester")+"' and STUDENTID='"+rs1.getString("studentid")+"' AND NVL(DEACTIVE,'N')='N' AND NVL(STUDENTDEACTIVE,'N')='N' ) ORDER BY Finalgrade";
	rsg=db.getRowset(qry);
	
	if(rsg.next())
	{
	%>

		<td align="left"><%=rsg.getString("Finalgrade")%></td>
		
	<%
	}
	else
	{
	%>

		<td>&nbsp;</td>
		
	<%

	}
	%>
    </tr>
    <%
	   }  // CLOSING OF WHILE rs1
	}
	catch(Exception e)
	{
		
	}
	%>


<td></tr>


</table>
	
	</tbody>
	
					
					
					
					
					
					
					
					
					
					
					<table align=CENTER  rules=group border=1 cellspacing=0 width="50%">
					<tr>
					<td   align=RIGHT>
					<%
					if(ctr>0)
					{
						%>
						<input type=submit value="Continue" onClick="return checkradio(<%=temp%>)">
						<%
					}
					%>
					</td>
					<td align=RIGHT>
									
						<img src="../../Images/printer.gif"><INPUT id=button1 type=button value="Click to Print" LANGUAGE=javascript onClick="window.print();" tabIndex=40>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
					</td>
					</tr>
					</table>
					</form>
					

	
<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),[ "Number", "CaseInsensitiveString","Number" ,"Number" ,"Number","Number" ,"Number" ,"Number","Number"]);
		</script>
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
			}	 // closing of !rs.next
			else
			{
				out.print(" &nbsp;&nbsp;&nbsp <center><b><font size=3 face='Arial' color='Red'>Marks Entry and Locking of following events is/are not completed.</font> <br>");
				qry="select distinct EVENTSUBEVENT,weightage  from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and ";
				qry=qry+" a.subjectid='"+mSC+"' and a.CORDFACULTYID='"+mChkMemID+"' and exists ";
				qry=qry+" (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
				qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='N' and  a.examcode=b.examcode and ";
				qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid )";
			//	out.print(qry);
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