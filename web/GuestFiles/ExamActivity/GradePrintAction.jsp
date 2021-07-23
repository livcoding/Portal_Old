<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null;
String qrys="";
ResultSet rss=null;
ResultSet rss1=null;
int mSno1=0;
String mNames="";
DBHandler db=new DBHandler();
String mInst="",mDefault="";
int ctr=0;
String mHead="";
String mysubjcode="",mETOD="",mDet="";
String qrysub="",mNam="",mSc="",mCheckFstid="",mWeightageInit="",qry2="",qryi=""; 
ResultSet rssub=null,rs2=null,rsi=null;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
try
{
OLTEncryption enc=new OLTEncryption();
int mFlag=0;
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="";
String mECode="",mecode="";
int mSno=0;
String mName="";
String mSCode="",mscode="";
String mEC="",mSC="";
String mName1="";

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
<form name="frm"  method="post"  >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: large; FONT-FAMILY: fantasy"><b>Grade Sheet</b></TD>
</font></td></tr>
</TABLE>
<%

		int len=0,pos1=0;
		String mSem1="",mSC11="";
if(request.getParameter("Subject")!=null)
{
			mEC=request.getParameter("ExamCode").toString().trim();
			mSC11=request.getParameter("Subject").toString().trim();
            len=mSC11.length();
		  	pos1=mSC11.indexOf("***");
			mSC=mSC11.substring(0,pos1);
			mSem1=mSC11.substring(pos1+3,len);
			mETOD=request.getParameter("ETOD").toString().trim();

	qrysub="select subject,SUBJECTCODE from subjectmaster where subjectID='"+mSC+"' and nvl(deactive,'N')='N' ";
	rssub=db.getRowset(qrysub);
	if(rssub.next())
		{
	 		mNam=rssub.getString("subject");
			mSc=rssub.getString("SUBJECTCODE");
		}
		else
		{
			mNam="";
			mSc="";
		}
if(mEC.equals("2007EVESEM") || mEC.equals("0708SUMMER") || mEC.equals("2006ODDSEM") )
{
qry="select distinct fstid, subjectid from (select distinct fstid,subjectID from ";
qry=qry+" facultysubjecttagging where semester='"+mSem1+"' and institutecode='"+mInst+"' and examcode='"+mEC+"' ";
qry=qry+"  and (LTP='L' OR PROJECTSUBJECT='Y')  and subjectID='"+mSC+"' ";
qry=qry+" union ";
qry=qry+" select distinct fstid,subjectID from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
qry=qry+" examcode='"+mEC+"' and semester='"+mSem1+"'  and subjectID='"+mSC+"' ";
qry=qry+" MINUS ";
qry=qry+" select distinct fstid,subjectID from V#EX#SUBJECTGRADECOORDINATOR  ";
qry=qry+" where   InstituteCode='"+mInst+"' And examcode='"+mEC+"' and semester='"+mSem1+"'  and subjectID='"+mSC+"' ) ";
}
else
{
qry="select distinct fstid, subjectid from (select distinct fstid,subjectID from ";
qry=qry+" facultysubjecttagging where semester='"+mSem1+"' and institutecode='"+mInst+"' and examcode='"+mEC+"' ";
qry=qry+" and employeeid='"+mChkMemID+"' and (LTP='L' OR PROJECTSUBJECT='Y')  and subjectID='"+mSC+"' ";
qry=qry+" union ";
qry=qry+" select distinct fstid,subjectID from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
qry=qry+" examcode='"+mEC+"' and semester='"+mSem1+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
qry=qry+" MINUS ";
qry=qry+" select distinct fstid,subjectID from V#EX#SUBJECTGRADECOORDINATOR  ";
qry=qry+" where   examcode='"+mEC+"' and semester='"+mSem1+"' and employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' ) ";
// qry=qry+" where fstid in (select fstid from EX#GRADESUBJECTBREAKUP where  employeeid='"+mChkMemID+"')" ;
}
rs=db.getRowset(qry);

while(rs.next())
{
	
	if(mCheckFstid.equals(""))
	{
	mCheckFstid="'"+rs.getString("fstid")+"'" ;
	}
	else
	{
		mCheckFstid=mCheckFstid+",'"+rs.getString("fstid")+"'" ;
	}
} // closing of outer rs while

String mBreakSl="";

qry="SELECT BREAK#SLNO fROM EX#GRADESUBJECTBREAKUP where employeeid='"+mChkMemID+"' ";
qry=qry+" and fstid in("+mCheckFstid+") ";
rs=db.getRowset(qry);
while(rs.next())
{
	if(mBreakSl.equals(""))
	{
	mBreakSl="'"+rs.getString("BREAK#SLNO")+"'" ;
	}
	else
	{
		mBreakSl=mBreakSl+",'"+rs.getString("BREAK#SLNO")+"'" ;
	}
}
if(!mBreakSl.equals("") && !mCheckFstid.equals(""))
	{
%>
<TABLE ALIGN=CENTER rules=COLUMNS rules=groups  cELLSPACING=0 BORDER=0>
<tr><td colspan=3><b>CoOrdinator Name/Member name : </b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
	<TR>
		<TD><b>Exam Code :</b><%=mEC%></TD>
		<TD nowrap ><b>&nbsp; Subject Code :</b><%=mNam%>&nbsp(<%=mSc%>)</TD>
	</TR>
	</TABLE>
<br>
<TABLE ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=0>
<ol>
<%
qry="select question ,questionid from EXAMGRADEQUESTION where institutecode='"+mInst+"' and examcode='"+mEC+"' and nvl(DEACTIVE,'N')='N' order by questionid ";
rs=db.getRowset(qry);
while(rs.next())
{
%>
<TR>
<td><li><%=rs.getString("question")%>?&nbsp;Yes</br></td>
</tr>
<%
} // closing of while
%>
</table>
<br>
<table align=center>
<tr>
<td align=center><b>General Information</B>
</td>
</tr>
</table>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=76% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Total<br>Students<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Rejected<br>Students<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Students<br>Considered<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Mean<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Standard<br>Deviation<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Initial<br>AVGP<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>AVGP<B><font></TD>
	</TR>
<%
	if(mEC.equals("2007EVESEM") || mEC.equals("0708SUMMER") || mEC.equals("2006ODDSEM") )
{
	qry=" SELECT TOTALSTUDENT, REJECTEDSTUDENT,STUDENTCONSIDERED, MEAN, INITIALAVGP, ";
	qry=qry+" AVGP,DEVIATION FROM GRADECALCULATION where institutecode='"+mInst+"' and ";
	qry=qry+" examcode='"+mEC+"' and subjectid='"+mSC+"' and break#slno in("+mBreakSl+") and entryby='CAMPUS' ";
}
else
{
	qry=" SELECT TOTALSTUDENT, REJECTEDSTUDENT,STUDENTCONSIDERED, MEAN, INITIALAVGP, ";
	qry=qry+" AVGP,DEVIATION FROM GRADECALCULATION where institutecode='"+mInst+"' and ";
	qry=qry+" examcode='"+mEC+"' and subjectid='"+mSC+"' and break#slno in("+mBreakSl+") and entryby='"+mChkMemID+"' ";
}
	rs=db.getRowset(qry);
	//out.print(qry);
	while(rs.next())
	{
	%>
		<tr>
		<TD ALIGN=CENTER><%=rs.getInt("TOTALSTUDENT")%></TD>
		<TD ALIGN=CENTER><%=rs.getInt("REJECTEDSTUDENT")%></TD>
		<TD ALIGN=CENTER><%=rs.getInt("STUDENTCONSIDERED")%></TD>
		<TD ALIGN=CENTER><%=rs.getDouble("MEAN")%></TD>
		<TD ALIGN=CENTER><%=rs.getDouble("DEVIATION")%></TD>
		<TD ALIGN=CENTER><%=rs.getDouble("INITIALAVGP")%></TD>
		<TD ALIGN=CENTER><%=rs.getDouble("AVGP")%></TD>
		</tr>
	<%
	}// closing of while
%>
	</table>
<table align=center>
<tr>
<td align=center><b>Grades</B>
</td>
</tr>
</table>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=76% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<thead>
<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Grade<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Recommended<br>From<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Recommended<br>To<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Standered<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Initial<br>Count<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Count<B><font></TD>
</tr>
</thead>
<%
	qry=" SELECT GRADE, RECOMMENDEDFROM, RECOMMENDEDTO, STANDEREDLOWERLIMIT, INITIALCOUNT, ";
	qry=qry+" FINALCOUNT FROM GRADECALCULATIONGRADES where institutecode='"+mInst+"' and ";
	qry=qry+" examcode='"+mEC+"' and subjectid='"+mSC+"' and BREAK#SLNO in ("+mBreakSl+") order by grade ";
	rs=db.getRowset(qry);
	while(rs.next())
	{	
	%>
		<tr>
		<TD ALIGN=right><%=rs.getString("GRADE")%>&nbsp; &nbsp; &nbsp; &nbsp;</TD>
		<TD ALIGN=right><%=rs.getDouble("RECOMMENDEDFROM")%>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</TD>
		<TD ALIGN=right><%=rs.getDouble("RECOMMENDEDTO")%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</TD>
		<TD ALIGN=right><%=rs.getDouble("STANDEREDLOWERLIMIT")%>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</TD>
		<TD ALIGN=right><%=rs.getInt("INITIALCOUNT")%>&nbsp; &nbsp; &nbsp; &nbsp;</TD>
		<TD ALIGN=right><%=rs.getInt("FINALCOUNT")%>&nbsp; &nbsp; &nbsp; &nbsp;</TD>
		</tr>
	<%
	} // closing of while
%>
</table>
<br>
<table align=center>
<tr>
<td align=center><b>Final Examination of students Semester-<%=mSem1%></B>
</td>
</tr>
</table>
 <TABLE bgcolor=#fce9c5 class="sort-table" id="table-1" width=76% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<thead>
<tr bgcolor="#ff8c00">
	<td><b><font color=white>SNo.</font></b></td>
	<td><b><font color=white >Roll No.</font></b></td>
	<td><b><font color=white >Masscuts</font></b></td>
	<td><b><font color=white >Student Name</font></b></td>
	<td><b><font color=white >Marks</font></b></td>
	<td><b><font color=white >Grade</font></b></td>
</tr>
</thead>
<tbody>
<%
/*
qry2="select a.studentid studentid,";
qry2=qry2+" round(sum((a.marksawarded2/a.maxmarks)*b.weightage),2)marksawarded2, ";
qry2=qry2+" a.studentname,sum(b.weightage)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") ";
qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry2=qry2+" institutecode='"+mInst+"' and  nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mEC+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSC+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
qry2=qry2+" group by A.SUBJECTID,a.studentid, ";
qry2=qry2+" a.studentname ";
rs2=db.getRowset(qry2);
if(rs2.next())
{
	mWeightageInit=rs2.getString("weightage");
}
*/
if(mEC.equals("2007EVESEM") || mEC.equals("0708SUMMER") || mEC.equals("2006ODDSEM") )
{
qryi=" SELECT distinct B.enrollmentno,B.studentname,A.STUDENTID,A.INITIALMARKS,A.INITIALGRADE,A.MASSCUTS,A.FINALMARKS,";
qryi=qryi+" A.FINALGRADE FROM STUDENTWISEGRADE A,V#STUDENTEVENTSUBJECTMARKS  B where A.fstid in ("+mCheckFstid+") and gradeflag='"+mETOD+"' ";
qryi=qryi+" and A.INSTITUTECODE='"+mInst+"' AND A.FSTID=B.FSTID and A.EXAMCODE='"+mEC+"' and A.entryby='CAMPUS' AND A.STUDENTID=B.STUDENTID AND NVL(A.DEACTIVE,'N')='N' ";
}
else
{
qryi=" SELECT distinct B.enrollmentno,B.studentname,A.STUDENTID,A.INITIALMARKS,A.INITIALGRADE,A.MASSCUTS,A.FINALMARKS,";
qryi=qryi+" A.FINALGRADE FROM STUDENTWISEGRADE A,V#STUDENTEVENTSUBJECTMARKS  B where A.fstid in ("+mCheckFstid+") and gradeflag='"+mETOD+"' ";
qryi=qryi+" and A.INSTITUTECODE='"+mInst+"' AND A.FSTID=B.FSTID and A.EXAMCODE='"+mEC+"' and A.entryby='"+mChkMemID+"' AND A.STUDENTID=B.STUDENTID AND NVL(A.DEACTIVE,'N')='N' ";
}
rsi=db.getRowset(qryi);
while(rsi.next())
{
	ctr++;
	mDet=rsi.getString("FINALGRADE");
%>
		<tr bgcolor=white>
		<td><%=ctr%></td>
		<td><%=rsi.getString("enrollmentno")%></td>
	<!--	<td><%=mWeightageInit%></td>
		<td><%=rsi.getDouble("INITIALMARKS")%></td>
		<td><%=rsi.getString("INITIALGRADE")%></td> -->
		<td><%=rsi.getDouble("MASSCUTS")%></td>
<%
	if(mDet.equals("F"))
	{
	%>
			<td><%=GlobalFunctions.toTtitleCase(rsi.getString("studentname"))%>*</td>
	<%

	}
	else
	{
		%>
			<td><%=GlobalFunctions.toTtitleCase(rsi.getString("studentname"))%></td>
		<%
	}
	%>
		<td><%=rsi.getDouble("FINALMARKS")%></td>
		<td><%=rsi.getString("FINALGRADE")%></td>
		</tr>
<%
} // closing of while rsi
qry="select to_char(sysdate,'dd-mm-yyyy hh:mi:ss PM') from dual";
rs=db.getRowset(qry);
rs.next();
String mDat=rs.getString(1);

%>
</tbody>
		</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","Number","Number","CaseInsensitiveString","Number","CaseInsensitiveString"]);
</script>
<br>
<table width=76% align=center>
<tr>
<td align=left>
Name:-<br>
Signature of Instructor:<br>
Submitted on..<%=mDat%>
</td>
<td align=right>*Detained Candidate 
</td>
</tr>
</table>

<table width=80% align=center>
<tr>
<td nowrap align=center title="Click to Print" valign=top>
<table width=10% align=center border=2 bordercolor=magroon><tr><td align=center nowrap><font color=blue>
<b>Click  <a style="CURSOR:hand" onClick="window.print();"><img src="../../Images/printer.gif"></a> To Print</b></font></td></tr></table></td>
</tr>
</table>
</form>
  <%
	}
  else
 {
 out.print("<font color=red>No Record Found... </font>");
  }
 }
  else
 {
 out.print("<font color=red>No Record Found... </font>");
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