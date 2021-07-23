<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null;
String qrys="";
ResultSet rss=null, rss1=null, rsLckChk=null, rsLeftTagging=null;
int mSno1=0;
String mNames="";
DBHandler db=new DBHandler();
String mComp="", mInst="",mDefault="";
int ctr=0, mGradeCompleteFlag=0, mWeightFlag=0;
String mHead="";
String mysubjcode="",mETOD="",mSem1="";
double mAllowedWeightage=0;
double MaxAW=100;

session.setAttribute("GRADEMASTERSET",null);
session.setAttribute("GRADEINITIALCOUNT",null);
session.setAttribute("GRADECHECKED",null);
session.setAttribute("GRADEUNCHECKED",null);

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";

	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}

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
function checkradio()
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
String mECode="",mecode="",mDept="",mDesg="",mLoginComp="";
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
	mComp="JIIT";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
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
   // out.print(qry);
	RsChk= db.getRowset(qry);
	//if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	if(1==1)
	{
		qry="select GRADEENTRYEXAMID  from DEFAULTVALUES ";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mDefault=rs.getString("GRADEENTRYEXAMID");
	}

%>
<form name="frm"  method="post"  >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Grade Calculation</b></TD>
</font></td></tr>
</TABLE>

<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>

<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<tr><td colspan=3><b><font face=arial size=2>&nbsp; Co-ordinator / Faculty Name : </font></b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
<tr>
<td>
	<b><font face=arial size=2>&nbsp; Exam Code</font></b>
	 <select name=ExamCode tabindex="0" id="ExamCode" style="WIDTH: 130px" > 
	<%

	qry=" select nvl(GRADEENTRYEXAMID,'') EXAMCODE from defaultvalues"; 

		rs=db.getRowset(qry);
		if (request.getParameter("x")==null) 
		{
			while(rs.next())
			{  
			mECode=rs.getString("EXAMCODE");
			if(mecode.equals(""))
			%>
			<OPTION Value =<%=mECode%>><%=rs.getString("EXAMCODE")%></option>
			<%			
		}
	} // closing of if 
else
{
	while(rs.next())
	{
	mECode=rs.getString("EXAMCODE");

	if(mECode.equals(request.getParameter("ExamCode").toString().trim()))
	{
%>
			<OPTION selected Value =<%=mECode%>><%=rs.getString("EXAMCODE")%></option>
	<%
	}
	else
	{
%>
		<OPTION Value =<%=mECode%>><%=rs.getString("EXAMCODE")%></option>
<%
	}
  } //closing of while
} // closing of else

	%>
	</select>
</td>
<td>
	<b><font face=arial size=2>&nbsp; Subject</font></b>
	<%
	qry="select distinct A.subjectID SUBJECTID,B.subject||'('|| B.SUBJECTCODE ||')' SUBJECT from ( select distinct subjectID,fstid from ";
	qry=qry+" facultysubjecttagging where institutecode='"+mInst+"' and examcode='"+mDefault+"' ";
	qry=qry+" and employeeid='"+mChkMemID+"' and (LTP='L' OR PROJECTSUBJECT='Y')";
	qry=qry+" union ";
	qry=qry+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
	qry=qry+" examcode='"+mDefault+"' and COORDINATORID='"+mChkMemID+"' ";
	qry=qry+" MINUS ";
	qry=qry+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
	qry=qry+" where  employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' ) A,subjectmaster B where A.subjectID=B.subjectID ";
	//out.print(qry);
	%>
	<select name=Subject tabindex="0" id="Subject" style="WIDTH: 400px" > 
	<%
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
 <input type=RADIO name=ETOD id=ETOD VALUE="N" checked=true><b><font face=arial size=2>Normal</font></b>
 <input type=RADIO name=ETOD id=ETOD VALUE="E"><b><font face=arial size=2>EtoD&nbsp; </font></b>
</td>
</tr>
<tr>
<td>&nbsp; &nbsp; &nbsp; &nbsp;
<a href="GradeMassCuts.jsp" target=_new >
<b>Student MassCut(if any)</b></a>
	<td colspan=2 align=center>
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

	qry="select 'y' from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and ";
	qry=qry+" a.subjectid='"+mSC+"' and a.employeeid='"+mChkMemID+"'";
	qry=qry+" and exists (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
	qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='N' and  a.examcode=b.examcode and ";
	qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid)";

//---------Added as on 15/12/2008---------
//-----------
	qry=qry+" UNION";
	qry=qry+" Select 'y' from v#exameventsubjecttagging a where a.examcode='"+mEC+"' and a.subjectid='"+mSC+"'";
	qry=qry+" and a.fstid in (select fstid from EX#SUBJECTGRADECOORDINATOR EX WHERE EX.COMPANYCODE='"+mComp+"' and EX.INSTITUTECODE='"+mInst+"' and EX.FACULTYID='"+mChkMemID+"')";
	qry=qry+" and exists (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
	qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='N' and  a.examcode=b.examcode and ";
	qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid)";
//-----------
//---------Added as on 15/12/2008---------

	//out.print(qry);
	rs=db.getRowset(qry);
	if(!rs.next())
	{
		qry="Select FSTID FROM EXAMEVENTSUBJECTTAGGING WHERE NVL(LOCKED,'N')='N' AND FSTID IN ";
		qry=qry+"(select FSTID from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and ";
		qry=qry+" a.subjectid='"+mSC+"' and a.employeeid='"+mChkMemID+"'";
		qry=qry+" and exists (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
		qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='Y' and  a.examcode=b.examcode and ";
		qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid)";
		qry=qry+" UNION";
		qry=qry+" Select FSTID from v#exameventsubjecttagging a where a.examcode='"+mEC+"' and a.subjectid='"+mSC+"'";
		qry=qry+" and a.fstid in (select fstid from EX#SUBJECTGRADECOORDINATOR EX WHERE EX.COMPANYCODE='"+mComp+"' and EX.INSTITUTECODE='"+mInst+"' and EX.FACULTYID='"+mChkMemID+"')";
		qry=qry+" and exists (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
		qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='Y' and  a.examcode=b.examcode and ";
		qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid))";
		//out.print(qry);
		rsLckChk=db.getRowset(qry);
		String QryFSTID="";
		while(rsLckChk.next())
		{
			mGradeCompleteFlag++;
			qry="Select nvl(A.EVENTSUBEVENT,' ') EVENTSUBEVENT,nvl(A.WEIGHTAGE,0) WEIGHTAGE  from V#EXAMEVENTSUBJECTTAGGING A ";
			qry=qry+" WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mEC+"' AND A.SUBJECTID='"+mSC+"' ";
			//qry=qry+" and A.EMPLOYEEID='"+mChkMemID+"'";
			qry=qry+" and A.FSTID='"+rsLckChk.getString("FSTID")+"' ";
			qry=qry+" Group By A.EVENTSUBEVENT, A.WEIGHTAGE ORDER BY EVENTSUBEVENT,nvl(A.WEIGHTAGE,0)";
		   // out.print(qry);
			rss=db.getRowset(qry);
			while(rss.next())
			{
				mAllowedWeightage=mAllowedWeightage+rss.getDouble("WEIGHTAGE");
			}
			mAllowedWeightage=MaxAW-mAllowedWeightage;
			if(mAllowedWeightage>0)
			{
				if(QryFSTID.equals(""))
					QryFSTID="'"+rsLckChk.getString(1)+"'";
				else
					QryFSTID=QryFSTID+",'"+rsLckChk.getString(1)+"'";
				mWeightFlag++;
			}
		} // closing of !rsLckChk.next
		if(!QryFSTID.equals(""))
		{
			qry="Select A.EMPLOYEEID EMPLOYEEID, B.EMPLOYEECODE EMPLOYEECODE, B.EMPLOYEENAME EMPLOYEENAME, A.PROGRAMCODE PROGRAMCODE, A.SECTIONBRANCH SECTIONBRANCH, A.SUBSECTIONCODE SUBSECTIONCODE, A.SEMESTER SEMESTER from facultysubjecttagging A, EmployeeMaster B where A.fstid in ("+QryFSTID+") and A.examcode='"+mEC+"' AND A.EMPLOYEEID=B.EMPLOYEEID order by employeeid";
			//out.print(qry);
			rsLeftTagging=db.getRowset(qry);
			%>
			<TABLE align=center rules=group border=1 cellspacing=0 width=98%>
			<TR BGCOLOR=orange>
			<TD><b>Faculty Name</b></TD>
			<TD><b>Programe Code</b></TD>
			<TD><b>Section Branch</b></TD>
			<TD><b>SubSection Code</b></TD>
			<TD><b>Semester<b></TD>
			<TD><b>100% Weightage Tagged ?<b></TD>
			</TR>
			<%
			while(rsLeftTagging.next())
			{
				%>
				<tr bgcolor=white>
				<td align=center><%=rsLeftTagging.getString("EMPLOYEENAME")%> (<%=rsLeftTagging.getString("EMPLOYEECODE")%>)</td>
				<td align=center><%=rsLeftTagging.getString("PROGRAMCODE")%></td>
				<td align=center><%=rsLeftTagging.getString("SECTIONBRANCH")%></td>
				<td align=center><%=rsLeftTagging.getString("SUBSECTIONCODE")%></td>
				<td align=center><%=rsLeftTagging.getString("SEMESTER")%></td>
				<td align=center>NO</td>
				</tr>
				<%
			}
		}
		if(mGradeCompleteFlag>0)
		{
			if(mAllowedWeightage==0.0 && mWeightFlag==0)
			{
				%>
				<form name="frm1"  method="post" action="GradeCalculationAction.jsp" >
				<input id="y" name="y" type=hidden>
				<TABLE align=center rules=group border=1 cellspacing=0 width=98%>
				<TR>
				<TD>&nbsp;</TD>
				<TD><b>Subject Code</b></TD>
				<TD><b>Programe Code</b></TD>
				<TD><b>Section Branch</b></TD>
				<TD><b>SubSection Code</b></TD>
				<TD><b>Semester<b></TD>
				</TR>
				<%
				qry="select distinct fstid, subjectid,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from ( select distinct fstid,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from ";
				qry=qry+" facultysubjecttagging where institutecode='"+mInst+"' and examcode='"+mEC+"' ";
				qry=qry+" and employeeid='"+mChkMemID+"' and (LTP='L' OR PROJECTSUBJECT='Y')  and subjectID='"+mSC+"' ";
				qry=qry+" union ";
				qry=qry+" select distinct fstid,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
				qry=qry+" examcode='"+mEC+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
				qry=qry+" MINUS ";
				qry=qry+" select distinct fstid,subjectID,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from V#EX#SUBJECTGRADECOORDINATOR  ";
				qry=qry+" where examcode='"+mEC+"' and employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' ) ";
				qry=qry+" where fstid not in (select fstid from EX#GRADESUBJECTBREAKUP where nvl(ETOD,'N')='Y' and employeeid='"+mChkMemID+"')" ;
				//qry=qry+" where fstid not in (select fstid from EX#GRADESUBJECTBREAKUP where  employeeid='"+mChkMemID+"')" ;
				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					ctr++;
					mSem1=rs.getString("SEMESTER");
					mName1="FSTID"+ctr;
					qry="select  subjectcode from subjectmaster where subjectid='"+rs.getString("subjectid")+"'";
					rss1=db.getRowset(qry);	
					if(rss1.next())
					{
						mysubjcode=rss1.getString(1);	
					}
					%>
					<TR>
					<TD><INPUT checked TYPE="CHECKBOX" NAME="<%=mName1%>" ID="<%=mName1%>" VALUE="<%=rs.getString("fstid")%>"></TD> 
					<TD><%=mysubjcode%></TD>
					<TD><%=rs.getString("programcode")%></TD>
					<TD><%=rs.getString("SECTIONBRANCH")%></TD>
					<TD><%=rs.getString("SUBSECTIONCODE")%></TD>
					<TD><%=rs.getString("SEMESTER")%></TD>
					</TR>
					<%
				} // closing of while
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
					mName="RADIO"+mSno ;
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
				<table align=center rules=group border=1 cellspacing=0 width=98%>
				<tr>
				<td align=center>
				<input type=submit value="Continue" onClick="return checkradio()">
				</td>
				</tr>
				</table>
				</form>
				<form name="frm11"  method="post" action="DeleteGradeCalculation.jsp" >
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
					<td align=center>
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
				out.print("<br>&nbsp; &nbsp; &nbsp; <img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp; <b><font size=3 face='Arial' color='Red'>Some events have not been tagged </FONT><font size=3 face='Arial' color='BLUE'> &nbsp; OR &nbsp; </FONT><font size=3 face='Arial' color='RED'> 100% Weightage have not been utilized</font> <br>");
			}
		}
		else
		{
			out.print("<br>&nbsp; &nbsp; &nbsp; <img src='../../Images/Error1.jpg'>");
			out.print(" &nbsp;&nbsp;&nbsp; <b><font size=3 face='Arial' color='Red'>Grade Calculation of this subject has already been freezed !</font> <br>");
		}
	} // closing of !rs.next
	else
	{
		out.print("<br>&nbsp; &nbsp; &nbsp; <img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp; &nbsp; &nbsp; <b><font size=3 face='Arial' color='Red'>Some events have not been locked. </font> <br>");
	}
}// closing of request.getParameter("x)!=null

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
//-----------------------------


} // closing of if(!mMemberID.equals(""))
 //-----------------------------
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}    
}
catch(Exception e)
{
	// out.print(e);
}
%>