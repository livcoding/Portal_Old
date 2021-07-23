<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Makeup Marks Entry] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script language="javascript">
function kH(e) 
{
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
 function ChangeOptions(Exam,DataComboEvent,Event,DataComboSubject,Subject)
  {
    removeAllOptions(Event);
	var mevent='?';
	var mflag=0;
	
	for(i=0;i<DataComboEvent.options.length;i++)
       {	
		var v1;
		var pos;
		var exam;
		var event;
		var len;
		var otext;
		var v1=DataComboEvent.options(i).value;

		len= v1.length ;	
		pos=v1.indexOf('***');
		exam=v1.substring(0,pos);
		event=v1.substring(pos+3,len);
		if (exam==Exam)
		 { 	if(mflag==0) 
			{
			mevent=event;
			mflag=1;
			}
			var optn = document.createElement("OPTION");
			optn.text=DataComboEvent.options(i).text;
			optn.value=event;
			Event.options.add(optn);   
		}
	}
	removeAllOptions(Subject);
	 mflag=0;
	for(i=0;i<DataComboSubject.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var event;
		var lens;
		var subject;
		var v1s=DataComboSubject.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///');
		exams=v1s.substring(0,pos1);
		event=v1s.substring(pos1+3,pos2);
		subject=v1s.substring(pos2+3,lens);
		if (exams==Exam && mevent==event)
		 { 	
			var optns = document.createElement("OPTION");
			optns.text=DataComboSubject.options(i).text;
			optns.value=subject;
			Subject.options.add(optns);
		}

	}	
}
//********Click event on subject**********
   function ChangeOpt(Exam,mevent,DataComboSubject,Subject)
  {
   	var mflag=0;
	var ssec='?';
	removeAllOptions(Subject);
	 mflag=0;
			
	for(i=0;i<DataComboSubject.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var events;
		var lens;
		var subjects;
		var otexts;
		var v1s=DataComboSubject.options(i).value;
		lens=v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///');
		exams=v1s.substring(0,pos1);
		events=v1s.substring(pos1+3,pos2);
		subjects=v1s.substring(pos2+3,lens);
		if (exams==Exam && mevent==events)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataComboSubject.options(i).text;
			optns.value=subjects;
			Subject.options.add(optns);
		}
	}	
}

function removeAllOptions(selectbox)
{
var i;
for(i=selectbox.options.length-1;i>=0;i--)
{
selectbox.remove(i);
}
}




 
 function Marks_Check(objtxt,mMax)
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
ResultSet rsse=null,rsdc=null,rsds=null;
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="",msubj="";
String qry="",qry1="",x="",msubsection="",mPrint="";
int msno=0;
int len =0;
int pos=0;
String mSE="",qryexam="",qrymevent="";
String mEventsubevent1="";
String mEventsubevent2="";
String mEF="";
String mSubj1="";
double mMarksawarded=0;
double mWeight=0;
double mvalue=0,mMaxmarks=0,MyMax=0;
int ctr=0;
String mStatus="";
int mFlag=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent=""; //,mExamsubevent="",mExamevent="";

ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null;

String mMOP="",mName5="",mlistorder="",mctr="",qrys="";		
	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName7="";
			
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

		qry="Select WEBKIOSK.ShowLink('124','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
	  //----------------------

qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
rs=db.getRowset(qry);
if (rs.next())
	mInst=rs.getString(1);
else
	mInst="JIIT";


%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">MakeUp Marks Entry</TD>
</font></td></tr>
</TABLE>

	<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
	<tr><td><font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]
	&nbsp;&nbsp; : &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (
	<%=GlobalFunctions.toTtitleCase(mDept)%>)
	</td></tr>

<TR><TD>
<!--*********Exam**********-->
&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Exam.code</STRONG></FONT></FONT>
<%  
	try
	{
	qry="select distinct nvl(EXAMCODE,' ')GRADEENTRYEXAMID  From V#EXAMEVENTSUBJECTTAGGING";
	qry=qry+" Where Institutecode='"+mInst+"'  and nvl(Locked,'N')='N'  ";
	qry=qry+" AND EMPLOYEEID='"+mDMemberID+"' ";

	rs=db.getRowset(qry);
		//out.print(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="2" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataComboEvent,Event,DataComboSubject,Subject);" onChange="ChangeOptions(Exam.value,DataComboEvent,Event,DataComboSubject,Subject);">	
		<%   
			while(rs.next())
			{
			mExamid=rs.getString("GRADEENTRYEXAMID");
			if(qryexam.equals(""))
	 			{
				qryexam=mExamid;
			%>
				<OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
			<%		
				}
				else
				{
			%>
				<OPTION  Value =<%=mExamid%>><%=mExamid%></option>
			<%		
				}	
			}
		%>
			</select>
		<%
		}
	else
	{
		%>	
			<select name=Exam tabindex="2" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataComboEvent,Event,DataComboSubject,Subject);" onChange="ChangeOptions(Exam.value,DataComboEvent,Event,DataComboSubject,Subject);">	
		<%
			while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				if(mExamid.equals(request.getParameter("Exam").toString().trim()))
 				{
					qryexam=mExamid;
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
//*******************DataComboEvent***********************	

try
	{
	qry="select distinct nvl(EXAMCODE,' ')GRADEENTRYEXAMID,EVENTSUBEVENT from V#EXAMEVENTSUBJECTTAGGING";
	qry=qry+" where institutecode='"+mInst+"'  and nvl(LOCKED,'N')='N'  ";
	qry=qry+" AND EMPLOYEEID='"+mDMemberID+"' order by GRADEENTRYEXAMID,EVENTSUBEVENT ";
	rsdc=db.getRowset(qry);
	%>
		<select name=DataComboEvent tabindex="3" id="DataComboEvent" style="WIDTH: 0px">	
	<%   
	if (request.getParameter("x")==null) 
	{
		while(rsdc.next())
		{
			mEventsubevent1=rsdc.getString("GRADEENTRYEXAMID");
			mEventsubevent2=rsdc.getString("EVENTSUBEVENT");
			mEF=mEventsubevent1+"***"+mEventsubevent2;
		%>
			<OPTION Value =<%=mEF%>><%=rsdc.getString("EVENTSUBEVENT")%></option>
		<%			
		}
	}
	else
	{
		while(rsdc.next())
		{
			mEventsubevent1=rsdc.getString("GRADEENTRYEXAMID");
			mEventsubevent2=rsdc.getString("EVENTSUBEVENT");
			mEF=mEventsubevent1+"***"+mEventsubevent2;

			if(mEF.equals(request.getParameter("DataComboEvent").toString().trim()))
 			{
			%>
				<OPTION selected Value =<%=mEF%>><%=rsdc.getString("EVENTSUBEVENT")%></option>
			<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mEF%>><%=rsdc.getString("EVENTSUBEVENT")%></option>
		      	<%			
		   	}
		}
	 }
	%>
		</select>
  	<%
	}
	catch(Exception e)
	{
		//out.print("error");
	}	
%>
	<!--***************EventSubevent****************-->
	&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 
	<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent</STRONG></FONT></FONT>
	<%    
	try
	{
	qry="select distinct EVENTSUBEVENT from V#EXAMEVENTSUBJECTTAGGING";
	qry=qry+" where institutecode='"+mInst+"'  and nvl(LOCKED,'N')='N' and examcode='"+qryexam+"'  ";
	qry=qry+" AND EMPLOYEEID='"+mDMemberID+"' ";
	rse=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Event tabindex="3" id="Event" style="WIDTH: 156px" onclick="ChangeOpt(Exam.value,Event.value,DataComboSubject,Subject);" onChange="ChangeOpt(Exam.value,Event.value,DataComboSubject,Subject);">	
		<%   
		while(rse.next())
		{
			mEventsubevent=rse.getString("EVENTSUBEVENT");
			if(qrymevent.equals(""))
			{
			qrymevent=mEventsubevent;
			%>
			<OPTION selected Value =<%=mEventsubevent%>><%=rse.getString("EVENTSUBEVENT")%></option>
			<%
			}
			else
			{
			%>
			<OPTION Value =<%=mEventsubevent%>><%=rse.getString("EVENTSUBEVENT")%></option>
			<%

			}
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Event tabindex="3" id="Event" style="WIDTH: 156px" onclick="ChangeOpt(Exam.value,Event.value,DataComboSubject,Subject);" onChange="ChangeOpt(Exam.value,Event.value,DataComboSubject,Subject);">	
		<%
		while(rse.next())
		{
			mEventsubevent=rse.getString("EVENTSUBEVENT");
			if(mEventsubevent.equals(request.getParameter("Event").toString().trim()))
 			{
				qrymevent=mEventsubevent;
			%>
				<OPTION selected Value =<%=mEventsubevent%>><%=rse.getString("EVENTSUBEVENT")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mEventsubevent%>><%=rse.getString("EVENTSUBEVENT")%></option>
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
		//out.print("error");
	}	
%>

	</td></tr>

<!--********DataComboSubject*****-->

<tr>
<td>
<%
try
{
	qry="select distinct examcode examcode,EVENTSUBEVENT eventsubevent,subject||' ( '||subjectcode||' )' subject,subjectID from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" institutecode='"+mInst+"'  and nvl(LOCKED,'N')='N'  ";
	qry=qry+" AND EMPLOYEEID='"+mDMemberID+"' order by examcode,eventsubevent,subject";

	rsds=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=DataComboSubject tabindex="4" id="DataComboSubject" style="WIDTH: 0px">	
		<%   
		while(rsds.next())
		{
		mSubj1=rsds.getString("examcode")+"***"+rsds.getString("eventsubevent")+"///"+rsds.getString("SubjectID") ;
			if(msubj.equals(""))
 			msubj=mSubj1;
			%>
			<OPTION Value =<%=mSubj1%>><%=rsds.getString("Subject")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=DataComboSubject tabindex="4" id="DataComboSubject" style="WIDTH: 0px">	
		<%
		while(rsds.next())
		{
		mSubj1=rsds.getString("examcode")+"***"+rsds.getString("eventsubevent")+"///"+rsds.getString("SubjectID") ;

			if(mSubj1.equals(request.getParameter("DataComboSubject").toString().trim()))
 			{
				msubj=mSubj1;
				%>
				<OPTION selected Value =<%=mSubj1%>><%=rsds.getString("Subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj1%>><%=rsds.getString("Subject")%></option>
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
<!--SUBJECT**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
<%
	try
	{
	qry="select distinct subject||' ( '||subjectcode||' )' subject,subjectID from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" institutecode='"+mInst+"'  and nvl(LOCKED,'N')='N' and eventsubevent='"+qrymevent+"' and examcode='"+qryexam+"'  ";
	qry=qry+" AND EMPLOYEEID='"+mDMemberID+"' ";

	//out.print(qry);

	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="4" id="Subject" style="WIDTH: 290px">	
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
		<select name=Subject tabindex="4" id="Subject" style="WIDTH: 290px">	
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
<FONT color=black><FONT face=Arial size=2><STRONG>List order in:</STRONG></FONT></FONT>
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

<% 	if(request.getParameter("order")==null)
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
<tr><td align=right>
<INPUT Type="submit" tabindex="7" Value="Show/Refresh">&nbsp;&nbsp;&nbsp;
		</td></tr>
		</table></form>
	<%	
		int tabctrtxt=7;
		int tabctrchk=1000;		

		if(request.getParameter("x")!=null)
		{
			if( request.getParameter("Subject")!=null && request.getParameter("Event")!=null && request.getParameter("Exam")!=null)
			{
		mIC=mInst;
		mEC=request.getParameter("Exam").toString().trim();
		mSC=request.getParameter("Subject").toString().trim();
		mList=request.getParameter("listorder").toString().trim();
		mOrder=request.getParameter("order").toString().trim();
		mEvent=request.getParameter("Event").toString().trim();	
		len=mEvent.length();
		pos=mEvent.indexOf("#");
		if(pos>0)
		{
			mSE=mEvent.substring(0,pos);
		}
		else
		{
			mSE=mEvent;
		}
	
		
		qry="select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
 		qry=qry+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' and employeeid='"+mDMemberID+"'";
		qry=qry+" And EVENTSUBEVENT='"+mEvent+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and (ltp='L' OR PROJECTSUBJECT='Y') and subjectID='"+mSC+"' ";
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
			&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Marks
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:</STRONG></FONT><%=mMaxmarks%>
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Weightage:</STRONG></FONT><%=mWeight%>

		<%
			}
			else
			{
		%>
			&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Percentage
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:&nbsp;</STRONG></FONT><%=mMaxmarks%>
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Weightage:</STRONG></FONT><%=mWeight%>
		<%
		}

	%>	
		<table cellspacing=0 cellpadding=0 width=98% border=1 align=center>
		<form name="frm1"  method="post" action="MakeupMarksEntryAction.jsp">
		<tr bgcolor="#c00000">
		<td><b><font color=white>SNo.</font></b></td>
		<td><b><font color=white>Enroll. No</font></b></td>
		<td><b><font color=white>Student name</font></b></td>
		<td><b><font color=white>Marks</font></b></td>
		<td><b><font color=white>Course (Section<br>Branch)<font></b></td>
		<td><b><font color=white>Sem.<font></b></td>
		</tr>	
	<%
	
try
{
qry="select distinct fstid,nvl(MARKSAWARDED1,-1)MARKSAWARDED1,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester,subsectioncode, ";
qry=qry+ "nvl(programcode,' ')programcode,nvl(SECTIONBRANCH,' ')SECTIONBRANCH from V#STUDENTEVENTSUBJECTMARKS ";
qry=qry+" where institutecode='"+mIC+"' and (nvl(DETAINED,'N')='M' or nvl(DETAINED2,'N')='M') ";
qry=qry+" AND examcode='"+mEC+"' and employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and (ltp='L' OR PROJECTSUBJECT='Y') and subjectID='"+mSC+"' ";
qry=qry+"  And EVENTSUBEVENT='"+mEvent+"' order by "+mList+ " "+mOrder+ " ,enrollmentno " ;
rs1=db.getRowset(qry);
msno=0;
ctr=0;
while(rs1.next())
{	
	mFlag=1;
	ctr++;
	tabctrtxt++;
	tabctrchk++;
	mctr=String.valueOf(ctr).trim();
    	msno++;

	
	
		mName1="Semester"+String.valueOf(ctr).trim();  
		mName2="Studentid"+String.valueOf(ctr).trim();
		mName3="Marks"+String.valueOf(ctr).trim();
		mName5="Fstid"+String.valueOf(ctr).trim();

  %>	
	<tr>
	<td><%=msno%></td>
	<td><%=rs1.getString("enrollmentno")%></td>
	<td><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>
  <%
		x="";
		if(mMOP.equals("P"))
		x="%";
mMarksawarded=rs1.getDouble("MARKSAWARDED1");
	if(mMarksawarded<0)
	{
	%>
	<td align=center><input  tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>' value="" style="WIDTH: 40px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName3%>,<%=MyMax%>);"  onchange="Marks_Check(<%=mName3%>,<%=MyMax%>);"><%=x%></td>
	<%
	}
	else
	{
	mvalue=mMarksawarded;
	%>
	<td align=center><input  tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>' value='<%=mvalue%>' style="WIDTH: 40px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName3%>,<%=MyMax%>);"  onchange="Marks_Check(<%=mName3%>,<%=MyMax%>);"><%=x%></td>
	<%
	}
		%>
		
		<td><%=rs1.getString("programcode")%>&nbsp;(<%=rs1.getString("SECTIONBRANCH")%>)</td>
		<td><%=rs1.getString("semester")%></td>
		</tr>
		<input type=hidden name='<%=mName1%>' id='<%=mName1%>' value='<%=rs1.getString("semester")%>'>
		<input type=hidden name='<%=mName2%>' id='<%=mName2%>' value='<%=rs1.getString("studentid")%>'>	
		<input type=hidden name='<%=mName5%>' id='<%=mName5%>' value='<%=rs1.getString("fstid")%>'>
	<%	 
	   }  //closing of while
	if(mFlag==0)
	{
out.print("<br><img src='../../Images/Error1.jpg'>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No Student for MakeUp Marks Entry.</font> <br>");
	}
	}
	catch(Exception e)
	{
		//out.print("error");
	}
	%>
		<tr><td colspan=8 align=center>
		<INPUT Type="submit"  tabindex="<%=tabctrtxt%>"  Value="Save MakeUp Marks "></td></tr>
		<input type=hidden name='institute' id='institute' value=<%=mIC%>>
		<input type=hidden name='Exam' id='Exam' value=<%=mEC%>>
		<input type=hidden name='EventSubevent' id='EventSubevent' value=<%=mEvent%>>
		<input type=hidden name='TotalCount' id='TotalCount' value=<%=ctr%>>
      	<input type=hidden name='MaxMarks' id='MaxMarks' value=<%=mMaxmarks%>>
		<input type=hidden name='subjectcode' id='subjectcode' value=<%=mSC%>>
		<input type=hidden name='Marksorpercentage' id='Marksorpercentage' value=<%=mMOP%>>
		<input type=hidden name='Status' id='Status' value='<%=mStatus%>'>
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
//out.print("aaaaaaaaaaaaa");
}
%>