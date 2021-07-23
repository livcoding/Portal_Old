<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";

%>

<html>
<head>
<TITLE>#### <%=mHead%> [ Eventwise Marks Entry] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

 <script language="javascript">
function kH(e) {

var pK = document.all? window.event.keyCode:e.which;
return pK != 13;
}

document.onkeypress = kH;
if (document.layers) document.captureEvents(Event.KEYPRESS);
</script>


<script language=javascript>
<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
 function detained_check(objchk,objtxt)
 { 
	if(objchk.value!='N')
		{
		objtxt.value='';
		objchk.focus;
		}

 }
 
 function Marks_Check(objchk,objtxt,mMax)
 {
	

	if(objtxt.value!='' && objtxt.value.length>0)
	{
 	var entry=objtxt.value;
	
	if(parseFloat(entry)>=0 )
	{


	if(objtxt.value>mMax)
		{
			alert('Marks Must be <='+mMax);
			objtxt.value='';
			objtxt.focus;
		}
 	else if(objtxt.value<=mMax)
		{
			objchk.value=='N';
			objtxt.focus;

		}

	}
	else
	{
	alert('Invalid Marks!');
	objtxt.value='';
  	objtxt.focus;
	}
 }
}
function showAlert()
{
 if(document.frm1("Proceed").checked==true)
 {
	alert('Once You will check and Lock , You cannot enter marks of the rest students further');
 }
 else
 {
	alert('You cannot proceed for Grade Entry until you check it and Lock it.');
 }
}

//-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rsse=null;
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="",msubj="";
String qry="",qry1="",x="",msubsection="",mPrint="";
int msno=0;
int len =0;
int pos=0;
String mSE="";
double mWeight=0;
double mvalue=0,mMaxmarks=0,MyMax=0;
int ctr=0;
String mStatus="";

//out.println("Global Maximum Inactive Interval of Session in Seconds is : " +session.getMaxInactiveInterval()); 
session.setMaxInactiveInterval(10800); 
//out.println("Special Maximum Inactive Interval of Session in Seconds is : " +session.getMaxInactiveInterval()); 


String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent=""; //,mExamsubevent="",mExamevent="";

ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null;

String mMOP="",mName5="",mlistorder="",mctr="",qrys="",mSelf="";		
	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName7="";

session.setAttribute("Click",mSelf);

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

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------

		qry="Select WEBKIOSK.ShowLink('60','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
	  //----------------------
	%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Event/Sub Event wise Students Marks Entry</B></TD>
	</font></td></tr>
	</TABLE>

	<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
	<tr><td><font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]
	&nbsp;&nbsp; : &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (
	<%=GlobalFunctions.toTtitleCase(mDept)%>)
	</td></tr>
	<!--Institute****-->
	<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
	<%
	try
	{ 
	qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster Where InstituteCode='"+mInst+"' and nvl(Deactive,'N')='N' ";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">	
		<%   
		while(rs.next())
		{
			mInst=rs.getString("InstCode");
			if(mInst.equals(""))
				minst=mInst;
			%>
			<OPTION selected Value =<%=mInst%>><%=mInst%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">	
		<%
		while(rs.next())
		{
			mInst=rs.getString("InstCode");
			if(mInst.equals(request.getParameter("InstCode").toString().trim()))
 			{
				%>
				<OPTION selected Value =<%=mInst%>><%=mInst%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mInst%>><%=mInst%></option>
		      	<%			
		   	}
		}
		%>
		</select>
	  	<%
	 }
 	}    
	catch(Exception e)
	{
	    //out.println(e.getMessage());
	}
%>
<!--*********Exam**********-->
&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
<%
	try
	{
		qry="Select distinct NVL(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='"+mInst+"' And CompanyCode='"+mComp+"'";
		//out.print(qry);
		rs=db.getRowset(qry);
		if (request.getParameter("x")==null)
		{
			%>
			<select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px">	
			<%   
			while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				%>
				<OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
				<%			
			}
			%>
			</select>
			<%
		}
		else
		{
			%>	
			<select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px">	
			<%
			while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				if(mExamid.equals(request.getParameter("Exam").toString().trim()))
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
			%>
			</select>
		  	<%
		}
	}
	catch(Exception e)
	{
	    //out.println(e.getMessage());
	}
	%>
	&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent</STRONG></FONT></FONT>
	<%
	try
	{	
		qry="select EVENTSUBEVENT from V#EXAMEVENTSUBJECTTAGGING where ";
		qry=qry+" trunc(sysdate) between trunc(FROMDATE) and trunc(TODATE) and (fstid) in (select "; 
		qry=qry+" fstid from  facultysubjecttagging  ";
		qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N' AND (LTP='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P')) ";  
		//qry=qry+" and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' ";
		//qry=qry+" and nvl(PROCEEDSECOND,'N')='N'
		qry=qry+"GROUP BY EVENTSUBEVENT "; 
		//out.print(qry);
		rse=db.getRowset(qry);
	
		if (request.getParameter("x")==null) 
		{
			%>
			<select name="Event" tabindex="3" id="Event" style="WIDTH: 200px">	
			<%   
			while(rse.next())
			{
				mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
				%>
				<OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
				<%
			}
			%>
			</select>
			<%
		}
		else
		{
			%>	
			<select name="Event" tabindex="3" id="Event" style="WIDTH: 200px">	
			<%
			while(rse.next())
			{
				mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
				if(mEventsubevent.equals(request.getParameter("Event").toString().trim()))
 				{
					%>
					<OPTION selected Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
					<%			
			     	}
		     		else
			      {
					%>
			      	<OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
		      		<%			
			   	}
			}
			%>
			</select>
		  	<%
		 }
		//out.println("Subevent"+mEventsubevent);
	}
	catch(Exception e)
	{
		//out.print("error");
	}	
%>
</td></tr>
<tr><td>
<!--SUBJECT**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
<%
	try
	{
	qry="select subject||' ( '||subjectcode||' )' subject, subjectID from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" trunc(sysdate) between trunc(FROMDATE) and trunc(TODATE) and (fstid) in (select "; 
	qry=qry+" fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N' AND (LTP='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') ) ";  
	//qry=qry+" and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' ";
	//qry=qry+" and nvl(PROCEEDSECOND,'N')='N' 
	qry=qry+" GROUP BY subject||' ( '||subjectcode||' )',subjectID"; 
	//out.print(qry);
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="4" id="Subject" style="WIDTH: 400px">	
		<%   
		while(rss.next())
		{
			mSubj=rss.getString("SubjectID");
			if(msubj.equals(""))
 			msubj=mSubj;
			%>
			<OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Subject tabindex="4" id="Subject" style="WIDTH: 400px">	
		<%
		while(rss.next())
		{
			mSubj=rss.getString("SubjectID");
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
		      	<%			
		   	}
		}
		%>
		</select>
	  	<%
	 }
 }    
catch(Exception e)
{
}
%>
<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; List order in:</STRONG></FONT></FONT>
<select name=listorder tabindex="5" id="listorder" style="WIDTH: 120px">
<% 	if(request.getParameter("listorder")==null)
   	{
 %>			
	<OPTION Value =Enrollmentno selected>Enrollment no.</option>
	<OPTION Value =Studentname>Student Name</option>
	<OPTION Value =Subsectioncode >Subsection/Group</option>
<%
  	}
  else
   {
	mlistorder=request.getParameter("listorder");
	if(mlistorder.equals("Enrollmentno"))
	{
%>
	<OPTION Value =Enrollmentno selected>Enrollment no.</option>
	<OPTION Value =Studentname >Student Name</option>
	<OPTION Value =Subsectioncode >Subsection/Group</option> 
<%
      }
	else if(mlistorder.equals("Studentname"))
	{
	%>
		<OPTION Value =Enrollmentno >Enrollment no.</option>
		<OPTION Value =Studentname selected>Student Name</option>
		<OPTION Value =Subsectioncode >Subsection/Group</option> 
	<%		
	}
	else if(mlistorder.equals("Subsectioncode"))
	{
	%>
		<OPTION Value =Enrollmentno >Enrollment no.</option>
		<OPTION Value =Studentname >Student Name</option>
		<OPTION Value =Subsectioncode selected >Subsection/Group</option> 
	<%		
	}

    }		
%>
</select>
<select name=order tabindex="6" id="order" style="WIDTH: 95px">	
<%
 	if(request.getParameter("order")==null)
   	{
		%>			
		<OPTION Value =Asc selected>Ascending</option>
		<OPTION Value =Desc>Descending</option>
		<%
  	}
	else
	{
		mlistorder=request.getParameter("order");
		if(mlistorder.equals("Asc"))
		{
			%>
			<OPTION Value =Asc selected>Ascending</option>
			<OPTION Value =Desc>Descending</option>
			<%
	      }
		else 
		{
			%>
			<OPTION Value =Asc >Ascending</option>
			<OPTION Value =Desc selected>Descending</option>
			<%		
		}
	}
%>
</select>
</td></tr>
<tr><td>
<%
String sel="";
if(request.getParameter("x")==null)
{
	%>
	<INPUT TYPE="radio" NAME="Click" Value='Self' checked>
	<FONT color=black><FONT face=Arial size=2><STRONG>Self Batch  Marks Entry</STRONG></FONT>
	&nbsp;&nbsp;
	<INPUT TYPE="radio" NAME="Click" Value='All' >
	<FONT color=black><FONT face=Arial size=2><STRONG>All Batches Marks Entry</STRONG></FONT>
	<%
}
else
{
	if(request.getParameter("Click")!=null)
	{
		if(request.getParameter("Click").equals("Self")) 
		{
			%>
			<INPUT TYPE="radio" NAME="Click" Value='Self' checked>
			<FONT color=black><FONT face=Arial size=2><STRONG>Self Batch  Marks Entry</STRONG></FONT>
			&nbsp;&nbsp;
			<INPUT TYPE="radio" NAME="Click" Value='All' >
			<FONT color=black><FONT face=Arial size=2><STRONG>All Batch  Marks Entry</STRONG></FONT>
			<%
		}
		else
		{
			%>
			<INPUT TYPE="radio" NAME="Click" Value='Self'>
			<FONT color=black><FONT face=Arial size=2><STRONG>Self Batch  Marks Entry</STRONG></FONT>
			&nbsp;&nbsp;
			<INPUT TYPE="radio" NAME="Click" Value='All' checked>
			<FONT color=black><FONT face=Arial size=2><STRONG>All Batch  Marks Entry</STRONG></FONT>
			<%
		}
	}
	else
	{
		%>
		<INPUT TYPE="radio" NAME="Click" Value='Self' checked>
		<FONT color=black><FONT face=Arial size=2><STRONG>Self Batch  Marks Entry</STRONG></FONT>
		&nbsp;&nbsp;
		<INPUT TYPE="radio" NAME="Click" Value='All' checked>
		<FONT color=black><FONT face=Arial size=2><STRONG>All Batch  Marks Entry</STRONG></FONT>
		<%
	}
}
%>
&nbsp; &nbsp;
<INPUT Type="submit" tabindex="7" Value="Show/Refresh">&nbsp;&nbsp;&nbsp;
</td></tr>
</table>
</form>
<%	
int tabctrtxt=7;
int tabctrchk=1000;		
if(request.getParameter("x")!=null)
{
	if(request.getParameter("Click")==null)
	{
		mSelf="";
	}
	else
	{
		mSelf=request.getParameter("Click");
	}
	//out.print("mSelf"+mSelf);
	if( request.getParameter("Subject")!=null && request.getParameter("Event")!=null && request.getParameter("Exam")!=null)
	{
		mIC=request.getParameter("InstCode").toString().trim();
		mEC=request.getParameter("Exam").toString().trim();
		mSC=request.getParameter("Subject").toString().trim();
		mList=request.getParameter("listorder").toString().trim();
		mOrder=request.getParameter("order").toString().trim();

		mEvent=request.getParameter("Event").toString().trim();	
		//out.println(mEvent);
		len=mEvent.length();
		pos=mEvent.indexOf("#");
		if(pos>0)
		{
			mSE=mEvent.substring(0,pos);
		}
		else
		{
			mSE=mEvent.toString().trim();
		}
		try
		{
	

		qrys="select nvl(detainedstatus,'A')detainedstatus from exameventmaster ";  
		qrys=qrys+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' and  exameventcode='"+mSE+"' ";
		//out.println("dfs "+qrys);
		ResultSet rsStatus=db.getRowset(qrys);
		if(rsStatus.next())
		{
			mStatus=rsStatus.getString("detainedstatus");	

		}
		}
		catch(Exception e)
		{
		}
		if(mStatus.equals("D"))
			mPrint="Detained";
		else if(mStatus.equals("A"))
			mPrint="Absent";		
		else
			mPrint="Absent/Detained";

		if(mSelf.equals("Self"))
		{
			qry="select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
 			qry=qry+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' and employeeid='"+mDMemberID+"'";
			qry=qry+" And EVENTSUBEVENT='"+mEvent+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='"+mSC+"' AND  NVL (deactive, 'N') = 'N' ";
		}
		else 
		{
			qry="select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
 			qry=qry+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' ";
			qry=qry+" And EVENTSUBEVENT='"+mEvent+"'  ";
			qry=qry+" and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='"+mSC+"' AND  NVL (deactive, 'N') = 'N'";
		}
		//out.print(qry);
		rsm=db.getRowset(qry);
		if(rsm.next())
		{
			mMOP=rsm.getString("MARKSORPERCENTAGE");
			mMaxmarks=rsm.getDouble("MAXMARKS");
			mWeight=rsm.getDouble("WEIGHTAGE");		
		}		
		
		if (mMOP.equals("M"))
			MyMax=mMaxmarks;
		else	
			MyMax=100;

		if(mMOP.equals("M"))
		{
			%>
			<CENTER><FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Marks
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks: </STRONG></FONT><%=mMaxmarks%>
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Weightage: </STRONG></FONT><%=mWeight%></CENTER>
			<%
		}
		else
		{
			%>
			<CENTER><FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Percentage
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:&nbsp;</STRONG></FONT><%=mMaxmarks%>
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Weightage: </STRONG></FONT><%=mWeight%></CENTER>
			<%
		}
		%>	
		<table cellspacing=0 cellpadding=0 width=98% border=1 align=center>
		<form name="frm1"  method="post" action="MarksEntryLvl1Action.jsp">
		<tr bgcolor="#ff8c00" height=40px>
		<td align=center><b><font color=white face=arial size=2>SNo.</font></b></td>
		<td align=center><b><font color=white face=arial size=2>Enroll. No</font></b></td>
		<td align=left><b><font color=white face=arial size=2>Student Name</font></b></td>
		<td align=center><b><font color=white face=arial size=2><%=mPrint%></font></b></td>
		<td align=center><b><font color=white face=arial size=2>Marks</font></b></td>
		<td align=left><b><font color=white face=arial size=2>Course (Section/Branch)<font></b></td>
		<td align=center><b><font color=white face=arial size=2>Sem.<font></b></td>
		</tr>	
		<%
		//len=mEvent.length();
		//pos=mEvent.indexOf("#");
		//mExamevent=mEvent.substring(0,pos);
		//mExamsubevent=mEvent.substring(pos+1,len);
		try
		{
		if(mSelf.equals("Self"))
		{
		qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
		qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester,subsectioncode, ";
		qry=qry+ " nvl(programcode,' ')programcode,nvl(SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING ";
		qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
		qry=qry+" examcode='"+mEC+"' and employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
		qry=qry+" And EVENTSUBEVENT='"+mEvent+"' " ;
		qry=qry+" GROUP BY fstid,nvl(studentid,' '),nvl(studentname,' '), ";
		qry=qry+" nvl(enrollmentno,' '),nvl(semester,0),subsectioncode, ";
		qry=qry+ " nvl(programcode,' '),nvl(SECTIONBRANCH,' ') order by "+mList+ " "+mOrder+ " ,enrollmentno ";
		}
		else
		{
		qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
		qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester,subsectioncode, ";
		qry=qry+ " nvl(programcode,' ')programcode,nvl(SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING ";
		qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
		qry=qry+" examcode='"+mEC+"'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
		qry=qry+" And EVENTSUBEVENT='"+mEvent+"' " ;
		qry=qry+" AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mInst+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mChkMemID+"')";
		qry=qry+" GROUP BY fstid,nvl(studentid,' '),nvl(studentname,' '), ";
		qry=qry+" nvl(enrollmentno,' '),nvl(semester,0),subsectioncode, ";
		qry=qry+ " nvl(programcode,' '),nvl(SECTIONBRANCH,' ') order by "+mList+ " "+mOrder+ " ,enrollmentno ";	
		}
		//out.print(qry);
		rs1=db.getRowset(qry);
		msno=0;
		ctr=0;
		//out.print(mMOP);
		//out.print(mMaxmarks);
		while(rs1.next())
		{
			ctr++;
			tabctrtxt++;
			tabctrchk++;
			mctr=String.valueOf(ctr).trim();
		    	msno++;
			mName1="Semester"+String.valueOf(ctr).trim();  
			mName2="Studentid"+String.valueOf(ctr).trim();
			mName3="Marks"+String.valueOf(ctr).trim();
			mName4="Detained"+String.valueOf(ctr).trim();
			mName5="Fstid"+String.valueOf(ctr).trim();
			%>	
			<tr>
			<td><%=msno%></td>
			<td><%=rs1.getString("enrollmentno")%></td>
			<td><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>
			<%
		
		qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		qry=qry+" EVENTSUBEVENT='"+mEvent+"' and   ";
		qry=qry+" fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
		rs3=db.getRowset(qry);
		//out.print(qry);
		x="";
		if(mMOP.equals("P"))
		x="%";
		if(rs3.next())
		{	
		  if((rs3.getString("Detained")).equals("D") || rs3.getString("Detained").equals("A") )
		  {
//**************************************************************
			if(mStatus.equals("B"))
			{
				if((rs3.getString("Detained")).equals("D"))
				{
			%>
			<td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option value="N">NA</option>
			<option value="A">Absent</option>
			<option selected value="D">Detained</option>
			</select></td>
			<%
				}
				else if((rs3.getString("Detained")).equals("A"))
			{
			%>
			<td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option value="N">NA</option>
			<option selected value="A">Absent</option>
			<option  value="D">Detained</option>
			</select></td>
			<%
			}
			else
			{
			%>
			<td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option selected value="N">NA</option>
			<option  value="A">Absent</option>
			<option  value="D">Detained</option>
			</select></td>
			<%
			}
			//}
			//else
			}
			else if(mStatus.equals("D"))
			{
				if((rs3.getString("Detained")).equals("D"))
				{
			%><td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option  value="N">NA</option>
			<option selected value="D">Detained</option>
			</select></td>
			<%
				}
			else
				{
			%><td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option selected value="N">NA</option>
			<option value="D">Detained</option>
			</select></td>
			<%
				}
			}
			else
			{
			%><td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option selected value="N">NA</option>
			<option value="A">Absent</option>
			</select></td>
			<%
			}
//******************************************************************
		%>
	<!--<td align=center><input  tabindex="<%=tabctrchk%>" type='checkbox' name='<%=mName4%>' id='<%=mName4%>' value='Y' checked onclick="return detained_check(<%=mName4%>,<%=mName3%>);"></td> -->
			<td align=center><input  tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>' value="" style="WIDTH: 40px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);" onchange="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);" ><%=x%></td>
		<%
		  }	
			else
			{	if(mMOP.equals("P"))
				mvalue=(rs3.getDouble("MARKSAWARDED1")*100)/mMaxmarks;
				else
				mvalue=rs3.getDouble("MARKSAWARDED1");

		if(mStatus.equals("B"))
			{
			%><td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option selected value="N">NA</option>
			<option value="A">Absent</option>
			<option value="D">Detained</option>
			</select></td>
			<%
			}
			else if(mStatus.equals("D"))
			{
			%><td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option selected value="N">NA</option>
			<option value="D">Detained</option>
			</select></td>
			<%
			}
			else
			{
			%><td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option selected value="N">NA</option>
			<option value="A">Absent</option>
			</select></td>
			<%
			}
		%>	
		<!-- <td align=center><input  tabindex="<%=tabctrchk%>" type='checkbox' name='<%=mName4%>' id='<%=mName4%>' value='Y' onclick="return detained_check(<%=mName4%>,<%=mName3%>);"></td> -->
			<td align=center><input  tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>' value='<%=mvalue%>' style="WIDTH: 40px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);" onchange="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);"><%=x%></td>
			
		<%   
 			}
		}
		else
		{
			if(mStatus.equals("B"))
			{
			%><td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option selected value="N">NA</option>
			<option value="A">Absent</option>
			<option value="D">Detained</option>
			</select></td>
			<%
			}
			else if(mStatus.equals("D"))
			{
			%><td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option selected value="N">NA</option>
			<option value="D">Detained</option>
			</select></td>
			<%
			}
			else
			{
			%><td align=center>
			<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>);" onclick="return detained_check(<%=mName4%>,<%=mName3%>);">
			<option selected value="N">NA</option>
			<option value="A">Absent</option>
			</select></td>
			<%
			}

		%>
		<!--<td align=center><input  tabindex="<%=tabctrchk%>" type='checkbox' name='<%=mName4%>' id='<%=mName4%>' value='Y' onclick="return detained_check(<%=mName4%>,<%=mName3%>);"></td>-->
		<td align=center><input  tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>' value="" style="WIDTH: 40px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);"  onchange="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);"><%=x%></td>
		<%
		}
	%>	
		<td><%=rs1.getString("programcode")%>&nbsp;(<%=rs1.getString("SECTIONBRANCH")%>)</td>
		<td align=center><%=rs1.getString("semester")%></td>
		</tr>
		<input type=hidden name='<%=mName1%>' id='<%=mName1%>' value='<%=rs1.getString("semester")%>'>
		<input type=hidden name='<%=mName2%>' id='<%=mName2%>' value='<%=rs1.getString("studentid")%>'>	
		<input type=hidden name='<%=mName5%>' id='<%=mName5%>' value='<%=rs1.getString("fstid")%>'>
	<%	 
	   } 
	}
	catch(Exception e)
	{
		//out.print("error");
	}
	session.setAttribute("Click",mSelf);
	%>
	<tr><td colspan=8 align=center>
	<%
		if(ctr>0)
		{
			%>
			<INPUT Type="submit"  tabindex="<%=tabctrtxt%>" Value="Save Marks"></td></tr>
			<%
		}
		else
		{
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Contact Subject/Grade Coordinator ! </font> <br>");
			%>
			</td></tr>
			<%
		}
		%>
	
		<input type=hidden name='institute' id='institute' value="<%=mIC%>">
		<input type=hidden name='Exam' id='Exam' value="<%=mEC%>">
		<input type=hidden name='EventSubevent' id='EventSubevent' value="<%=mEvent%>">
		<input type=hidden name='TotalCount' id='TotalCount' value="<%=ctr%>">
      	<input type=hidden name='MaxMarks' id='MaxMarks' value="<%=mMaxmarks%>">
		<input type=hidden name='subjectcode' id='subjectcode' value="<%=mSC%>">
		<input type=hidden name='Marksorpercentage' id='Marksorpercentage' value="<%=mMOP%>">
		<input type=hidden name='Status' id='Status' value="<%=mStatus%>">
	</form><table>	
	<%
	
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Mandatory items(Event,Subject,Exam.,etc.) must be entered. </font> <br>");

	}
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
// out.print("aaaaaaaaaaaaa");
}
%>