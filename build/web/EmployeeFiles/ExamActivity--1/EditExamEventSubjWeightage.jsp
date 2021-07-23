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

String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="", mFaculty="", mFacCode="", mEvent="", mSubevent="",mSubjID="", QryFSTID="";
String mDMemberCode="";
String mMemberName="",mcolor="";
String mECode="", mSubjCode="", mSubj="", mSubEvent="", mFMarks="", mComp="", mInst="", mWValue="", mEntryDate="";
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

	if (session.getAttribute("CompanyCode")==null)
	{
		mComp="UNIV";
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
	//out.print("Institutecode - "+mInst);
	if (request.getParameter("ECODE")==null)
	{
		mECode="";
	}
	else
	{	
		mECode=request.getParameter("ECODE").toString().trim();
	}

	if (request.getParameter("SUBJCODE")==null)
	{
		mSubjCode="";
	}
	else
	{
		mSubjCode=request.getParameter("SUBJCODE").toString().trim();
	}
	
	if (request.getParameter("SUBJECTID")==null)
	{
		mSubjID="";
	}
	else
	{
		mSubjID=request.getParameter("SUBJECTID").toString().trim();
	}

	if (request.getParameter("SUBJ")==null)
	{
		mSubj="";
	}
	else
	{
		mSubj=request.getParameter("SUBJ").toString().trim();
	}
	if (request.getParameter("EVENT")==null)
	{
		mSubEvent="";
	}
	else
	{
		mSubEvent=request.getParameter("EVENT").toString().trim();
	}

	if (request.getParameter("SUBEVENT")==null)
	{
		mSubevent="";
	}
	else
	{
		mSubevent=request.getParameter("SUBEVENT").toString().trim();
	}

	if(mSubevent.equals(""))
	mEvent=mSubEvent;
	else
	mEvent=mSubEvent+'#'+mSubevent;

	if (request.getParameter("WEIGHTAGE").toString().trim()==null)
	{
		mWValue="";
	}
	else
	{
		mWValue=request.getParameter("WEIGHTAGE").toString().trim();
		mWeight=Long.parseLong(mWValue);
	}
	if (request.getParameter("FMARKS").toString().trim()==null)
	{
		mFMarks="";
	}
	else
	{
		mFMarks=request.getParameter("FMARKS").toString().trim();
	}
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		mHead=session.getAttribute("PageHeading").toString().trim();
	else
		mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Edit Exam Event Subject Weightage]</TITLE>
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
	qry="Select WEBKIOSK.ShowLink('102','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Edit <u>Exam Event Subject</u> Weightage</b></font></td>
</tr>
</TABLE>
		
	
<table cellpadding=2 cellspacing=0 align=center rules=groups width=90% border=2>
<tr>
            <input type=hidden name="ECODE" id="ECODE" value="<%=mECode%>">
            <input type=hidden name="SUBJ" id="SUBJ" value="<%=mSubj%>">
		<input type=hidden name="SUBJCODE" id="SUBJCODE" value="<%=mSubjCode%>">
		<input type=hidden name="SUBJECTID" id="SUBJECTID" value="<%=mSubjID%>">
            <input type=hidden name="EVENT" id="EVENT" value="<%=mSubEvent%>">
            <input type=hidden name="SUBEVENT" id="SUBEVENT" value="<%=mSubevent%>">
            <input type=hidden name="WEIGHTAGE" id="WEIGHTAGE" value="<%=mWValue%>">
            <input type=hidden name="FMARKS" id="FMARKS" value="<%=mFMarks%>">
<%
qry="select nvl(EmployeeName,' ')EN, nvl(EmployeeCode,' ')EC from EmployeeMaster where EmployeeID='"+mChkMemID+"' and nvl(Deactive,'N')='N'";
//out.print(qry);
rs=db.getRowset(qry);
while(rs.next())
{
mFaculty=rs.getString("EN");
mFacCode=rs.getString("EC");
}
%>
<td colspan=2><FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Exam Code:</STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mECode%></FONT>&nbsp;&nbsp;&nbsp;&nbsp;
<FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Event/Sub Event:</STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mEvent%></FONT>&nbsp;&nbsp;&nbsp;&nbsp;
<FONT color="#00008b" face=Arial size=2><STRONG>&nbsp;Current Weightage:</STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mWValue%></FONT></td></tr>

<tr><td colspan=2><font color="#00008b" face=arial size=2>&nbsp;<STRONG>Subject:</STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mSubj%>(<%=mSubjCode%>)</FONT>&nbsp;&nbsp;&nbsp;&nbsp;
<font color="#00008b" face=arial size=2>&nbsp;<STRONG>Faculty:</STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mFaculty%></FONT></td></tr>

<tr bgcolor=white><td></td><td></td></tr>
<tr bgcolor=white><td></td><td></td></tr>

<tr><td><FONT color=black face=Arial size=2><STRONG>&nbsp;Assigned Weightage for </STRONG><%=mEvent%>&nbsp;:</FONT>&nbsp;
<FONT color=black face=Times New Roman size=3><%=mWValue%></FONT></td>

<td><FONT color=black face=Arial size=2><STRONG>&nbsp;Assigned Full Marks for </STRONG><%=mEvent%>&nbsp;:</FONT>&nbsp;
<FONT color=black face=Times New Roman size=3><%=mFMarks%></FONT></td></tr>

<!-- Rewetiage is disabled ********25/02/2010******* >

<tr><td><FONT color=black face=Arial size=2><STRONG>&nbsp;Re-Assign Weightage for </STRONG><%=mEvent%>:</FONT>&nbsp;
<INPUT ID="NewWValue" Name="NewWValue" style="WIDTH: 30px;" maxLength=3 value="<%=mWValue%>" readonly></td>

<td><FONT color=black face=Arial size=2><STRONG>&nbsp;Re-Assign Full Marks for </STRONG><%=mEvent%>:</FONT>&nbsp;
<INPUT ID="NewMarks" Name="NewMarks" style="WIDTH: 30px;" maxLength=3 value="<%=mFMarks%>"></td></tr>

Re Assign=<%=mFMarks%>

<tr><td colspan=2 align=center><INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 102px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Save" name=submit1>
<INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 102px; HEIGHT: 23px; FONT-VARIANT: normal" type=Reset size=5 value="Cancel" name=Reset></td></tr>
</TABLE>
<table width=90%>
<tr><td colspan=5 align=center><font face=arial size=3 color="#a52a2a"><b>Sub Event wise Assigned Weightage Detail</b></font></td></tr>
</table>
<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="90%">
	<thead>
	<tr bgcolor="#ff8c00">
	<td><font color="White"><b>SNo.</b></font></td>
	<td><font color="White"><b>Assigned Date</b></font></td>
	<td><font color="White"><b>Event/Sub Event</b></font></td>	
	<td align=center><font color="White"><b>Weightage (in %)</b></font></td>
	<td align=center><font color="White"><b>Full Marks</b></font></td>
	</tr>
	</thead>
	<tbody>
	<%
		qry2=" Select distinct nvl(A.EXAMCODE,' ')ECode, (A.SUBJECT||'('||A.SUBJECTCODE||')')Subj, nvl(A.EVENTSUBEVENT,' ')SubEvent, ";
		qry2=qry2+" to_char(B.ENTRYDATE,'dd-mm-yyyy')AssignedDate, nvl(A.WEIGHTAGE,0) WEIGHTAGE, nvl(A.MAXMARKS,0) MAXMARKS";
		qry2=qry2+" from V#EXAMEVENTSUBJECTTAGGING A, EXAMEVENTSUBJECTTAGGING B WHERE A.EVENTSUBEVENT=B.EVENTSUBEVENT and A.MAXMARKS=b.MAXMARKS";
		qry2=qry2+" and A.fstid=B.fstid and a.WEIGHTAGE=b.WEIGHTAGE and A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mECode+"' ";
		qry2=qry2+" AND A.SUBJECTID='"+mSubjID+"' and A.CORDFACULTYID='"+mChkMemID+"'";
		qry2=qry2+" Group By A.EXAMCODE, A.SUBJECT, A.SUBJECTCODE, A.EVENTSUBEVENT, B.ENTRYDATE, A.WEIGHTAGE, A.MAXMARKS";
		qry2=qry2+" Order By ECode, SUBJ, SubEvent";
		//out.print(qry2);
		rs1=db.getRowset(qry2);
		int Ctr=0;
		while(rs1.next())
		{
			mEntryDate=rs1.getString("AssignedDate");		
			qry1=" Select Distinct A.EVENTSUBEVENT, A.WEIGHTAGE TotWValue from V#EXAMEVENTSUBJECTTAGGING A WHERE ";
			qry1=qry1+" A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mECode+"' ";
			qry1=qry1+" AND A.SUBJECTID='"+mSubjID+"' and A.CORDFACULTYID='"+mChkMemID+"'";
			//qry1=qry1+" Group By A.EXAMCODE, A.EVENTSUBEVENT, A.SUBJECTCODE";
			//out.print(qry1);
			RS1=db.getRowset(qry1);
			while(RS1.next())
			{
				mTotalInUse=RS1.getLong("TotWValue");
				mAbcd=mAbcd+mTotalInUse;
			}
				mTotalAvl=mTotPerm-mAbcd;
			mAvailable=mWeight+mTotalAvl;
			Ctr++;
			mcolor="Black";
			%>
			<tr>
				<td nowrap><font color=<%=mcolor%>><%=Ctr%>.</font></td>
				<td nowrap><font color=<%=mcolor%>><%=mEntryDate%></font></td>
				<td nowrap><font color=<%=mcolor%>>&nbsp;&nbsp;&nbsp;<%=rs1.getString("SubEvent")%></font></td>
				<td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("WEIGHTAGE")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
				<td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("MAXMARKS")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
			</tr>
			<%  						
			 mAbcd=0;	
		 }
	%>
</tbody>
</table>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number", "CaseInsensitiveString", "CaseInsensitiveString", "Number", "Number"]);
</script>
<table width=50% align=center>
<tr>
<td colspan=0 align=left><FONT color="Blue" face=Arial black size=3><STRONG><u>&nbsp;Max. Permissible Weightage (in %)</u>:</STRONG></FONT></td>
<td colspan=0 align=left><table><tr bgcolor=green><td><FONT color="White" face=Arial black size=3><STRONG>&nbsp;<%=mAvailable%>&nbsp;</STRONG></FONT></td></tr></table></td></tr></table>
<%
		if(request.getParameter("x")!=null)
		{
			mCurrWValue=Long.parseLong(mWValue);
			mCurrMarks=Long.parseLong(mFMarks);
			String mNewVal="", mNewMark="";
			mNewWValue=Long.parseLong(request.getParameter("NewWValue").toString().trim());
			mNewMarks=Long.parseLong(request.getParameter("NewMarks").toString().trim());
			mNewVal=request.getParameter("NewWValue").toString().trim();
			mNewMark=request.getParameter("NewMarks").toString().trim();
			out.print(mNewMark);
			long QryWeightage=mTotalAvl+mCurrWValue;
			if(gb.isNumeric(mNewVal)==true && gb.isNumeric(mNewMark)==true)
			{
			 if(mNewWValue>0 && mNewMarks>0)
			 {
			 if(mNewWValue<=QryWeightage)
			  {
			qry="Select distinct FSTID FROM (";
 			qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
			qry=qry+" subjectmaster B where (A.LTP='L' OR A.PROJECTSUBJECT='Y' or A.LTP='P') and A.employeeid='"+mChkMemID+"' and A.examcode='"+mECode+"' and A.facultytype=decode('"+mChkMType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mECode+"'";
			qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubjID+"' GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
			qry=qry+" UNION";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where A.LTP IN ('L','P')  and A.COORDINATORID='"+mChkMemID+"' and A.EXAMCODE='"+mECode+"' and A.COORDINATORTYPE=decode('"+mChkMType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mECode+"'";
			qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubjID+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" UNION ";
		 	qry=qry+" (Select AA.FSTID, nvl(CC.subject,' ')||'('|| nvl(CC.subjectcode,' ')||')' subject , AA.subjectID subjectID from facultysubjecttagging AA, SubjectMaster CC , ";
			qry=qry+" ProgramSubjectTagging BB where AA.SUBJECTID='"+mSubjID+"' AND AA.LTP='P' AND nvl(AA.PROJECTSUBJECT,'N')<>'Y' And BB.L=0 and BB.T=0 and BB.P>0 And BB.ExamCode='"+mECode+"' And AA.employeeid='"+mChkMemID+"' and AA.examcode='"+mECode+"' ";
			qry=qry+" AND AA.INSTITUTECODE=BB.INSTITUTECODE And AA.EXAMCODE=BB.EXAMCODE And AA.ACADEMICYEAR=BB.ACADEMICYEAR And AA.PROGRAMCODE=BB.PROGRAMCODE And AA.TAGGINGFOR=BB.TAGGINGFOR And AA.SECTIONBRANCH=BB.SECTIONBRANCH And AA.SEMESTER=BB.SEMESTER And AA.BASKET=BB.BASKET And AA.SUBJECTID=BB.SUBJECTID ";
			qry=qry+" And AA.facultytype=decode('"+mChkMType+"','E','I','E') ";	
			qry=qry+" and nvl(AA.deactive,'N')='N' and nvl(BB.Deactive,'N')='N' AND ";
			qry=qry+" AA.INSTITUTECODE=CC.INSTITUTECODE AND BB.INSTITUTECODE=CC.INSTITUTECODE AND cc.SUBJECTID=BB.SUBJECTID AND AA.SUBJECTID=CC.SUBJECTID ";
			qry=qry+" and AA.SUBJECTID not IN (SELECT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mECode+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY AA.FSTID, nvl(CC.subject,' ')||'('|| nvl(CC.subjectcode,' ')||')' , AA.subjectID)";
			qry=qry+" MINUS";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where A.LTP='L' and A.EMPLOYEEID='"+mChkMemID+"' and A.COORDINATORID<>'"+mChkMemID+"' and A.EXAMCODE='"+mECode+"' and A.FACULTYTYPE=decode('"+mChkMType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mChkMemID+"')";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mECode+"'";
			qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubjID+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" ) WHERE FSTID IN (SELECT FSTID FROM EXAMEVENTSUBJECTTAGGING WHERE NVL(DEACTIVE,'N')='N' AND (ENTRYBY='"+mChkMemID+"' OR CORDFACULTYID='"+mChkMemID+"') and fstid in (select fstid from facultysubjecttagging where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' and EXAMCODE='"+mECode+"')) order by fstid";
			rs=db.getRowset(qry);
			//out.print(qry);
			while(rs.next())
			{
				if(QryFSTID.equals(""))
					QryFSTID="'"+rs.getString(1)+"'";
				else
					QryFSTID=QryFSTID+",'"+rs.getString(1)+"'";
			}
			//out.print("QryFSTID - "+QryFSTID);


			//---------------
			//--Update Query
			//---------------

				out.println("The Value is = " + mFMarks);
				qry2="update EXAMEVENTSUBJECTTAGGING set WEIGHTAGE='"+mNewWValue+"', MAXMARKS='"+mNewMarks+"', ENTRYDATE=sysdate";
				qry2=qry2+" Where EVENTSUBEVENT='"+mEvent+"'";
				//qry2=qry2+" and WEIGHTAGE='"+mCurrWValue+"' and MAXMARKS='"+mCurrMarks+"'";
				qry2=qry2+" AND (ENTRYBY='"+mChkMemID+"' OR CORDFACULTYID='"+mChkMemID+"')";
				//qry2=qry2+" and trunc(ENTRYDATE)=to_date('"+mEntryDate+"', 'dd-mm-yyyy')";
				qry2=qry2+" and FSTID IN ("+QryFSTID+")";

/*
				qry2=qry2+" and ENTRYBY='"+mChkMemID+"' and FSTID In(select FSTID from V#EXAMEVENTSUBJECTTAGGING where ";
				qry2=qry2+" EVENTSUBEVENT='"+mEvent+"' and WEIGHTAGE='"+mCurrWValue+"' and MAXMARKS='"+mCurrMarks+"' ";
				qry2=qry2+" and EXAMCODE='"+mECode+"' and SUBJECTID='"+mSubjID+"')";
*/
				out.print(qry2);
				int n=0;
				n=db.update(qry2);
				if(n>0)
				{
				 //----------- Log Entry
		  		 //-----------------
				  db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"EDIT WEIGHTAGE / MARKS", "Exam Code: "+mECode+" Event/SubEvent : "+mEvent+" SubjectID: "+mSubjID+" New Weightage: "+mNewWValue+" New FullMarks : "+mNewMarks, "No MAC Address" , mIPAddress);
				 //-----------------
					response.sendRedirect("ChangeExamEventSubjWeightage.jsp");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>Weightage Updated...</font> <br>");
				}
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error while Updating Weightage or Full Marks!</font> <br>");
				}
			  }
			  else
			  {
			 	  out.print("<br><img src='../../Images/Error1.jpg'>");
				  out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>New Weightage must be within the Permissible Weightage!</font> <br>");
			  }
			 }
			 else
			 {
				 out.print("<br><img src='../../Images/Error1.jpg'>");
				 out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Re-Assigned Weightage and Full Marks must be > '0'</font> <br>");
			 }
			}
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Enter Numeric Weightage and Full Marks!</font> <br>");
			}
			}
	//}  // CLOSING OF RS1.NEXT
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