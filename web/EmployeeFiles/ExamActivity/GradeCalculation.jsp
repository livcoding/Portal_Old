<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String temp="" ,qrtchck="",mDEL="DEL"; 
String QryCheck="",Action=""; ResultSet rsChk=null;
String qrybrk="",xBrkSlno=""; ResultSet rsbrk=null;
String qry="";
String qrtyt="",xProg="",xAcad=""; ResultSet rsty=null;
ResultSet rschk=null;
String qryi=""; ResultSet rsi=null;
ResultSet rs=null;
String qrys="";
ResultSet rss=null;
ResultSet rss1=null;
String mInst="", mComp="";
int mSno1=0 ,ptr=0;
String mNames="";
DBHandler db=new DBHandler();
String mDefault="",mPROG1="",mACAD=""; 
int ctr=0;
String mHead="", mExamid="";
String mysubjcode="",mETOD="",mSem1="",mLoginComp="";
String mfst="";
session.setAttribute("GRADEMASTERSET",null);
session.setAttribute("GRADEINITIALCOUNT",null);
session.setAttribute("GRADECHECKED",null);
session.setAttribute("GRADEUNCHECKED",null);
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";
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

	//if(temp=='')
//	{

	//alert(temp+"LL");
	var val;
	val=document.frm1.jss.value;
	var mNames;
	var val1=parseInt(val);
	var i=1;
	//	alert(val+"LL");
	
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
//	}
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


<script> 
function updatePercent(percent) 
{ 
 var oneprcnt = 4.15; 
 var prcnt = document.getElementById('prcnt'); 
 prcnt.style.width = percent*oneprcnt; 
prcnt.innerHTML = "<FONT SIZE=3 COLOR=red><b>Please Wait....</b></FONT>"; 

} 
</script> 


<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<CENTER><div align="center" style="width: 415px; height: 20px;  padding:0px;" id="status"><BR><div id="prcnt" align="center" style="height:18px;width:30px;overflow:hidden; position:middle; align:center"><BR> </div><IMG  align="center" SRC="ajax-loader.gif" WIDTH="192" HEIGHT="9" BORDER="0" ALT=""></div> </CENTER>	 
<% 
//call my fist stuff 
out.println("<script>updatePercent(" + 30 + ")</script>\n"); 
out.flush(); 
// the second part 
out.println("<script>updatePercent(" + 30 + ")</script>\n"); 
out.flush(); 
// the fthird parth 
out.println("<script>updatePerceGrade freezed!!nt(" + 30 + ")</script>\n");
out.flush(); 
//done 
%> 
<script> 
document.getElementById("status").style.display = "none"; 
</script> 



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
if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
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
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><u>Grade Calculation</u></b></TD>
	</font></td></tr>
	</TABLE>
	<table cellpadding=1 cellspacing=0 width="75%" align=center rules=groups border=1>
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
		qry+=" nvl(Deactive,'N')='N' AND NVL(LOCKEXAM,'N')='N' and examcode in (Select examcode from facultysubjecttagging)";
		 qry+=" and examcode in (select nvl(examcode,' ')examcode from v#studenteventsubjectmarks Where InstituteCode='" + mInst + "' And CompanyCode='" + mLoginComp + "') ";
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





//Add Auto mannual Condition if Start 'A'



		mDefault=mExamid;
		%>
		<form name="frm"  method="post" >
		<input id="xx" name="xx" type=hidden>
		<input id="x" name="x" type=hidden>
		<input type=hidden value=<%=mInst%>id="InstCode" name="InstCode">
		<input type=hidden value=<%=mExamid%> id="ExamCode" name="ExamCode">
		<table cellpadding=1 width="75%" cellspacing=0 align=center rules=groups border=1>
		<!--Institute-->
		<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
		<tr><td colspan=3><FONT color=black face=Arial size=2><STRONG>Co Ordinator Name : </STRONG></FONT><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
		<tr>
		<td colspan=2>
		<FONT color=black face=Arial size=2><STRONG>Subject</STRONG></FONT>
		<%
		qry="select distinct A.subjectID SUBJECTID,B.subject||'('|| B.SUBJECTCODE ||')' SUBJECT from ( select distinct subjectID,fstid from ";
		qry=qry+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mDefault+"'  AND NVL(DEACTIVE,'N')='N' ";
		qry=qry+" and employeeid='"+mChkMemID+"' and (LTP='L' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='P' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )))";
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
	//	out.println(qry);
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

			qry="select 'y' from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and a.INSTITUTECODE='"+mInst+"' and ";
			qry=qry+" a.subjectid='"+mSC+"' and a.CORDFACULTYID='"+mChkMemID+"' and exists ";
			qry=qry+" (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
			qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='N' and  a.examcode=b.examcode and ";
			qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid )";
			//out.print(qry);

			rs=db.getRowset(qry);
			if(!rs.next())
			{
				qry="Select nvl(A.EVENTSUBEVENT,' ') EVENTSUBEVENT,nvl(A.WEIGHTAGE,0) WEIGHTAGE  from V#EXAMEVENTSUBJECTTAGGING A ";
				qry=qry+" WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mEC+"' AND A.SUBJECTID='"+mSC+"' AND  NVL(A.PUBLISHED,'N')='Y'";
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
					




QryCheck=" select 'Y' from exammaster where examcode='"+mEC+"' and institutecode='"+mInst+"' and nvl(gradeentrytype,'A')='A'  ";
rsChk=db.getRowset(QryCheck);
		 
			if(rsChk.next())
			{
%>

<form name="frm1"  method="post" action="GradeCalculationAction.jsp" >
<%
			}else{
			
		%>
		<form name="frm1"  method="post" action="..\ExamActivitySUP\GradeCalculationAction.jsp" >
		
	 
			<%
			}
 %>
			 



					<input id="y" name="y" type=hidden>
					<input id="xx" name="xx" type=hidden>
					<input type=hidden value=<%=mInst%>id="InstCode" name="InstCode">
					<input type=hidden value=<%=mExamid%> id="ExamCode" name="ExamCode">
				 
					<TABLE align=center class="sort-table"  rules=group border=1 cellspacing=0 width="75%" >
					<%
					qry="select distinct fstid,ACADEMICYEAR, subjectid,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from ( select distinct fstid,ACADEMICYEAR,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from ";
					qry=qry+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mEC+"' ";
					qry=qry+" and employeeid='"+mChkMemID+"' and (LTP='L' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='P' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 ))) and subjectID='"+mSC+"' ";//(LTP='L' or LTP='P' OR (LTP='P' and PROJECTSUBJECT='Y'))
					qry=qry+" union ";
					qry=qry+" select distinct fstid,ACADEMICYEAR,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
					qry=qry+" examcode='"+mEC+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
					qry=qry+" union ";
					qry=qry+" select distinct fstid,ACADEMICYEAR,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
					qry=qry+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N'";
					qry=qry+" MINUS ";
					qry=qry+" select distinct fstid,ACADEMICYEAR,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR  ";
					qry=qry+" where   examcode='"+mEC+"' and employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' ) ";
					qry=qry+" where fstid not in (select A.fstid from EX#GRADESUBJECTBREAKUP a, GRADECALCULATION c where  A.employeeid='"+mChkMemID+"' AND c.subjectID='"+mSC+"' and c.institutecode='"+mInst+"' and c.examcode='"+mDefault+"'  AND A.BREAK#SLNO=C.BREAK#SLNO 		AND nvl(C.finalized,'N')='Y' )" ;
					/*qry=qry+" where fstid not in (select A.fstid from EX#GRADESUBJECTBREAKUP a, FACULTYSUBJECTTAGGING b, GRADECALCULATION c where  A.employeeid='"+mChkMemID+"' AND A.fstid =B.FSTID AND B.INSTITUTECODE=c.INSTITUTECODE AND B.EXAMCODE=C.EXAMCODE 	AND B.SUBJECTID=C.SUBJECTID 	AND A.BREAK#SLNO=C.BREAK#SLNO 	AND A.EMPLOYEEID=B.EMPLOYEEID 	AND nvl(C.finalized,'N')='Y' )" ;*/
					rs=db.getRowset(qry);
				 //out.print(qry+"check");	
					while(rs.next())
					{
						if(ctr==0)
						{
							%>
							<thead>
							<tr bgcolor="#ff8c00">
							<TD><Font color=white size=2><b>Sr.No.</TD>
							<TD><Font color=white size=2><b>Subject Code</b></TD>
							<TD><Font color=white size=2><b>Programe Code</b></TD>
							<TD><Font color=white size=2><b>Section Branch</b></TD>
							<TD><Font color=white size=2><b>SubSection Code</b></TD>
							<TD><Font color=white size=2><b>Semester<b></TD>
							</TR><%
						}
						ctr++;
						mSem1=rs.getString("SEMESTER");
						mPROG1=rs.getString("programcode");
						mACAD=rs.getString("ACADEMICYEAR");
						mName1="FSTID"+ctr;
						qry="select  subjectcode from subjectmaster where  INSTITUTECODE='"+mInst+"' and subjectid='"+rs.getString("subjectid")+"'";
						rss1=db.getRowset(qry);	
						if(rss1.next())
						{
							mysubjcode=rss1.getString(1);	
						}
						//String query1111="SELECT 'Y' FROM ex#gradesubjectbreakup a,facultysubjecttagging b,                   gradecalculation c WHERE a.employeeid = '"+mChkMemID+"' AND a.fstid = b.fstid and  b.institutecode = c.institutecode AND b.examcode = c.examcode AND b.subjectid = c.subjectid AND a.break#slno = c.break#slno AND a.employeeid = b.employeeid  AND c.status <> 'A'";
						String query1111="SELECT 'Y' FROM ex#gradesubjectbreakup a,facultysubjecttagging b,  gradecalculation c WHERE a.employeeid = '"+mChkMemID+"' AND a.fstid = b.fstid and  b.institutecode = c.institutecode AND b.examcode = c.examcode AND b.subjectid = c.subjectid AND a.break#slno = c.break#slno AND c.status <> 'A'";
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
						<INPUT checked TYPE="CHECKBOX"  NAME="<%=mName1%>" ID="<%=mName1%>" VALUE="<%=rs.getString("fstid")%>"><Font  size=2><%=ctr%>.</TD> 
						<TD><Font  size=2><%=mysubjcode%></TD>
						<TD><Font  size=2><%=rs.getString("programcode")%></TD>
						<TD><Font  size=2><%=rs.getString("SECTIONBRANCH")%></TD>
						<TD><Font  size=2><%=rs.getString("SUBSECTIONCODE")%></TD>
						<TD><Font  size=2><%=rs.getString("SEMESTER")%></TD>
						</TR>
						<%
					} // closing of while
					if(ctr==0)
					{
						//out.print(" &nbsp;&nbsp;&nbsp <p align=center><b><font size=3 face='Arial' color='Red'>Grade already freezed</font> <br>");
					}
					%>
					<INPUT TYPE="hidden" NAME="checkctr" value="<%=ctr%>">
					</table>    
					<br>
					<TABLE align=center class="sort-table"  rules=group border=1 cellspacing=0 width="75%" >


					<%

						if(ctr>0)
					{
					qry="select question ,questionid from EXAMGRADEQUESTION where institutecode='"+mInst+"' and examcode='"+mDefault+"' and nvl(DEACTIVE,'N')='N' order by questionid ";
					rs=db.getRowset(qry);
					//out.print(qry);
					while(rs.next())
					{	
						mSno++;
						mName="RADIO"+mSno;
						if(mFlag==0)
						{
							%><thead>
							<tr bgcolor="#ff8c00">
							<TD><Font color=white size=2>&nbsp;</td>
						<TD><Font color=white size=2><b> SNo.</b></td>
							<TD><Font color=white size=2><b>Question Descscription</b></td>
							</tr>
							<%
						}
						mFlag=1;
						%>
						<tr>
						<td nowrap>
						<input type="radio" value="Y" name="<%=mName%>" id="<%=mName%>" ><b>Yes</b>
						<input type="radio" value="N" name="<%=mName%>" id="<%=mName%>" checked=true><b>No</b></td>
						<td size=2><%=rs.getString("questionid")%>
						</td>
						<td size=2 ><%=rs.getString("question")%>?</td>
						</tr>
						<%
					}
				 	%>
					<input type="hidden" name="jss" id="jss" value="<%=mSno%>">
					<input type="hidden" name="ExamCode" id="ExamCode" value="<%=mEC%>">
					<input type="hidden" name="Subject" id="Subject" value="<%=mSC%>">
					<input type="hidden" name="ETOD" id="ETOD" value="<%=mETOD%>">
					<input type="hidden" name="SEMESTER" id="SEMESTER" value="<%=mSem1%>">
					<input type="hidden" name="prog" id="prog" value="<%=mPROG1%>">
<input type="hidden" name="ACAD" id="ACAD" value="<%=mACAD%>">
					
					 
					
					<%
					}
					if(ctr>0)
					{
						%>
						 
					<tr >
					<td colspan=3 align=center><input type=submit value="Continue" onClick="return checkradio(<%=temp%>)"></td>
					</tr>
					</table>
						<%
					}
					%>
					
					</form>



<%
	if(ctr==0)
					{

qrtchck= "  select 'Y' from EXAMEVENTSUBJECTTAGGING where nvl(locked,'N')='N' and  fstid IN ( select distinct fstid from ( select distinct fstid from ";
					qrtchck=qrtchck+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mEC+"' ";
					qrtchck=qrtchck+" and employeeid='"+mChkMemID+"' and (LTP='L' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='P' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 ))) and subjectID='"+mSC+"' ";//(LTP='L' or LTP='P' OR (LTP='P' and PROJECTSUBJECT='Y'))
					qrtchck=qrtchck+" union ";
					qrtchck=qrtchck+" select distinct fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
					qrtchck=qrtchck+" examcode='"+mEC+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
					qrtchck=qrtchck+" union ";
					qrtchck=qrtchck+" select distinct fstid from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
					qrtchck=qrtchck+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N'";
					qrtchck=qrtchck+" MINUS ";
					qrtchck=qrtchck+" select distinct fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
					qrtchck=qrtchck+" where   examcode='"+mEC+"' and employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' )   )  ";
rschk=db.getRowset(qrtchck);
  //out.print(qrtchck+"fs");
if(rschk.next()  )
{



//out.print(qrtchck);
// i am here
out.print(" &nbsp;&nbsp;&nbsp <p align=center><b><font size=3 face='Arial' color='Red'>Please Continue to freeze saved grade(s)...</font> <br>");
%>
<form name="frm11"  method="post" action="FreezeGrade.jsp" >
					<input id="xx" name="xx" type=hidden>
					
				
					<input id="z" name="z"  type=hidden>

 
<TABLE width="75%" class="sort-table" id="table-91"   ALIGN=center rules=COLUMNS CELLSPACING=0   BORDER=1> 
<thead>
<tr bgcolor="#ff8c00">
	<td align=left><b><font color=white>&nbsp;SNo.</font></b></td>
	<td><b><font color=white >Roll No.</font></b></td>
	
	<td><b><font color=white >Student Name</font></b></td>
<!-- <td><b><font color=white >MarksCut</font></b></td> -->


	 <td><b><font color=white >Marks</font></b></td> 
	<td><b><font color=white >Grade</font></b></td>
</tr>
</thead>
<tbody><%

					qryi="select distinct fstid  from ( select distinct fstid,ACADEMICYEAR,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from ";
					qryi=qryi+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mEC+"' ";
					qryi=qryi+" and employeeid='"+mChkMemID+"' and (LTP='L' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='P' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 ))) and subjectID='"+mSC+"' ";//(LTP='L' or LTP='P' OR (LTP='P' and PROJECTSUBJECT='Y'))
					qryi=qryi+" union ";
					qryi=qryi+" select distinct fstid,ACADEMICYEAR,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
					qryi=qryi+" examcode='"+mEC+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
					qryi=qryi+" union ";
					qryi=qryi+" select distinct fstid,ACADEMICYEAR,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
					qryi=qryi+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N'";
					qryi=qryi+" MINUS ";
					qryi=qryi+" select distinct fstid,ACADEMICYEAR,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR  ";
					qryi=qryi+" where   examcode='"+mEC+"' and employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' ) ";
					qryi=qryi+" where fstid  in (select A.fstid from EX#GRADESUBJECTBREAKUP a, GRADECALCULATION c where  A.employeeid='"+mChkMemID+"' AND c.subjectID='"+mSC+"' and c.institutecode='"+mInst+"' and c.examcode='"+mDefault+"'  AND A.BREAK#SLNO=C.BREAK#SLNO 		AND nvl(C.finalized,'N')='Y' )" ;
rsi=db.getRowset(qryi);
  // out.print(qryi);
while(rsi.next())
{
if(mfst.equals(""))
			{
				mfst="'"+rsi.getString("fstid")+"'";
			}
			else
			{
				mfst=mfst+",'"+rsi.getString("fstid")+"'";
			}

}







qryi=" SELECT distinct a.fstid, b.subjectid,B.enrollmentno,B.studentname,A.STUDENTID,A.INITIALMARKS,A.INITIALGRADE,A.MASSCUTS,A.FINALMARKS,";
qryi=qryi+" nvl(A.FINALGRADE,' ')FINALGRADE,nvl(A.MASSCUTS,0)MASSCUTS FROM STUDENTWISEGRADE A,V#STUDENTEVENTSUBJECTMARKS  B where A.BREAK#SLNO IN ( select BREAK#SLNO from  EX#GRADESUBJECTBREAKUP  where fstid IN ( select distinct fstid from ( select distinct fstid from ";
					qryi=qryi+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mEC+"' ";
					qryi=qryi+" and employeeid='"+mChkMemID+"' and (LTP='L' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='P' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 ))) and subjectID='"+mSC+"' ";//(LTP='L' or LTP='P' OR (LTP='P' and PROJECTSUBJECT='Y'))
					qryi=qryi+" union ";
					qryi=qryi+" select distinct fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
					qryi=qryi+" examcode='"+mEC+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
					qryi=qryi+" union ";
					qryi=qryi+" select distinct fstid from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
					qryi=qryi+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N'";
					qryi=qryi+" MINUS ";
					qryi=qryi+" select distinct fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
					qryi=qryi+" where   examcode='"+mEC+"' and employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' ) ";
					qryi=qryi+"  ))  ";
qryi=qryi+" and A.INSTITUTECODE='"+mInst+"' and a.institutecode=b.institutecode AND A.FSTID=B.FSTID and A.EXAMCODE='"+mEC+"'  AND A.STUDENTID=B.STUDENTID AND NVL(A.DEACTIVE,'N')='N'  order by a.FINALMARKS  desc";
rsi=db.getRowset(qryi);
  //out.print(qryi);
while(rsi.next())
{
 

ptr++;
	//mDet=rsi.getString("FINALGRADE");
%>
		<tr bgcolor=white >
		<td align='left'><B><%=ptr%>.</B></td>
		<td><%=rsi.getString("enrollmentno")%></td>
		<td><%=rsi.getString("studentname")%></b></font> </td>
		<!-- <td><%=rsi.getString("MASSCUTS")%></b></font> </td>	 -->
		<td>&nbsp;<%=rsi.getDouble("FINALMARKS")%></td>
		<td align=center>&nbsp;<%=rsi.getString("FINALGRADE")%></td>
		</tr>
	
 


<%
	}
qrtyt=" select distinct academicyear , programcode from facultysubjecttagging where fstid in ("+mfst+")";
rsty=db.getRowset(qrtyt);
if(rsty.next())
{
xProg=rsty.getString("programcode");
	xAcad= rsty.getString("academicyear");
}

qrybrk=" select distinct BREAK#SLNO from EX#GRADESUBJECTBREAKUP where fstid in ("+mfst+")";
rsbrk=db.getRowset(qrybrk);
if(rsbrk.next())
{
xBrkSlno=rsbrk.getString("BREAK#SLNO");
	 
}

		session.setAttribute("pxFSTID",mfst);

%><input type=hidden value="<%=mfst%>" id="mFSTD" name="mFSTD">
					<input type=hidden value="F" id="freeze" name="freeze">
		<tr><td COLSPAN=6 ALIGN=CENTER><input type=submit value="FREEZE GRADE" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="GradeCalculationAction.jsp?ACAD=<%=xAcad%>&amp;prog=<%=xProg%>&amp;BRK=<%=xBrkSlno%>&amp;EXAM=<%=mEC%>&amp;DELETE=<%=mDEL%>&amp;SUB=<%=mSC%>&amp;FSTIDL=<%=mfst%>&amp;ETOD=<%=mETOD%>"><font color=blue>Re-Evaluate the students Grade</font></a></td></tr></tbody></table>
		<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-91"),[ "Number","Number","CaseInsensitiveString", "Number","CaseInsensitiveString" ]);
	</script><BR><BR>
</form>
<%



					}else{
						out.print(" &nbsp;&nbsp;&nbsp <p align=center><b><font size=3 face='Arial' color='Red'>Grade freezed!!</font> <br>");
					
					}


					}
					%>


					<form name="frm11"  method="post" action="DeleteGradeCalculation.jsp" >
					<input id="xx" name="xx" type=hidden>
					<input type=hidden value=<%=mInst%>id="InstCode" name="InstCode">
					<input type=hidden value=<%=mExamid%> id="ExamCode" name="ExamCode">
					<input id="z" name="z"  type=hidden>
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
					<table align=center border=1 cellpadding=0 cellspacing=0 width="75%">
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
				qry="select distinct EVENTSUBEVENT,weightage  from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and ";
				qry=qry+" a.subjectid='"+mSC+"' and a.CORDFACULTYID='"+mChkMemID+"' and exists ";
				qry=qry+" (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
				qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='N' and  a.examcode=b.examcode and ";
				qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid )";
				//out.print(qry);
				rs=db.getRowset(qry);
				%>
				<br>
				<table align=center border=1 cellpadding=0 cellspacing=0 width="75%">
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
				<table width=80% align=center>
<tr>
<td nowrap align=center title="Click to Print" valign=top>
<table width="75%" align=center border=1 bordercolor=magroon><tr><td align=center nowrap><font color=blue>
<b>Click  <a style="CURSOR:hand" onClick="window.print();"><img src="../../Images/printer.gif"></a> To Print</b></font></td></tr></table></td>
</tr>
</table>
				<%
			}
		}




// Else For mannual Entry 'M'


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
	<br><BR>
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