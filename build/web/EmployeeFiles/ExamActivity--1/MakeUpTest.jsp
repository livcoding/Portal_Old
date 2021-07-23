<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try{
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Allow Students for MakeUp Test ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script language="JavaScript" type ="text/javascript">
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
		 var optn = document.createElement("OPTION");
			optn.text='ALL';
			optn.value='ALL';
			Subject.options.add(optn);

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
	
	var optn = document.createElement("OPTION");
			optn.text='ALL';
			optn.value='ALL';
			Subject.options.add(optn);
    	
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
function detained_check(objchk,objchkm,mFlag)
 { 
	
   if(mFlag=='Y')
    {
	if (objchk.checked==true)
		objchkm.checked=false;
	else
		objchkm.checked=true;

    }

   if(mFlag=='N')
    {
	if(objchkm.checked==true)
		objchk.checked=false;
	else
		objchk.checked=true;
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
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="",msubj="",mComp="";
String qry="",qry1="",x="",msubsection="",qrys="";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0;
int len=0;
int pos=0;
int ctr=0;
int pos1=0;
double mchkmarks=0;
String mName6="",mName7="",mName8="",mStatus="",mPrint="";
String mSubjectcode="",mEmployeecode="",mFacultytype="";
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent=""; //,mExamsubevent="",mExamevent="";

ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null;

String mMOP="",mName5="",mlistorder="",mctr="",qrymevent="",meven="",qryexam="";		
	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="";


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
	qry="Select WEBKIOSK.ShowLink('103','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk1= db.getRowset(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	   {
  //----------------------
%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana">Allow Students for MakeUp Test</TD>
	</font></td></tr>
	</TABLE>
	<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
	<!*********--Institute--************>
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
	<%
		
        if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        } else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }

		 if (session.getAttribute("CompanyCode") == null) {
            mComp = "";
        } else {
            mComp = session.getAttribute("CompanyCode").toString().trim();
        }
	%>
<tr><td >
<!--*********Exam**********-->
&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
<%  
	try
	{
		
	  qry = "Select distinct NVL(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "'";
		rs=db.getRowset(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="2" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataComboEvent,Event,DataComboSubject,Subject);" onChange="ChangeOptions(Exam.value,DataComboEvent,Event,DataComboSubject,Subject);">	
		<%   
			while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				if(mexam.equals(""))
	 			{
				mexam=mExamid;
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

	
	%>
	<!-- *************************Event SubEvent************ -->	
	</td><td>
	<%
	// *************DataComboEvent********* 
	qry="select  EVENTSUBEVENT,examcode   from V#STUDENTEVENTSUBJECTMARKS  ";
	qry=qry+" WHERE Institutecode='"+mInst+"' And examcode in (select examid from DEFAULTVALUES) ";
	qry=qry+" and nvl(PUBLISHED,'N')='Y' AND NVL(LOCKED,'N')='Y'  ";
	qry=qry+" and (nvl(Detained,'N')='D' or nvl(Detained,'N')='A' or nvl(Detained,'N')='M') "; 		
	qry=qry+" group by examcode,EVENTSUBEVENT ";
	qry=qry+" order by examcode,EVENTSUBEVENT ";

	rse=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=DataComboEvent tabindex="0" id="DataComboEvent" style="WIDTH:0px">	
		<%   
		while(rse.next())
		{
		   mEventsubevent=rse.getString("examcode")+"***"+rse.getString("EVENTSUBEVENT");
		%>
		    <OPTION Value =<%=mEventsubevent%>><%=rse.getString("EVENTSUBEVENT")%></option> 
		   	 
		<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=DataComboEvent tabindex="0" id="DataComboEvent" style="WIDTH: 0px">	
		<%
		while(rse.next())
		{
			mEventsubevent=rse.getString("examcode")+"***"+rse.getString("EVENTSUBEVENT");
			if(mEventsubevent.equals(request.getParameter("DataComboEvent").toString().trim()))
 			{
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
	%>
	&nbsp;&nbsp;
	<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent</STRONG></FONT></FONT>
 <%  
  try{
	qry="select EVENTSUBEVENT  from V#STUDENTEVENTSUBJECTMARKS  WHERE Institutecode='"+mInst+"' ";
	qry=qry+" And examcode  in (select examid from DEFAULTVALUES) ";
	qry=qry+" and nvl(PUBLISHED,'N')='Y' AND NVL(LOCKED,'N')='Y'  ";
	qry=qry+" and (nvl(Detained,'N')='D' or nvl(Detained,'N')='A' or nvl(Detained,'N')='M') and examcode='"+qryexam+"' "; 		
	qry=qry+" group by EVENTSUBEVENT ";
	qry=qry+" order by EVENTSUBEVENT ";
	//out.print(qry);
	rse=db.getRowset(qry);

	if (request.getParameter("x")==null) 
	{
		%>						
	<select name=Event tabindex="3" id="Event" style="WIDTH: 156px" onclick="ChangeOpt(Exam.value,Event.value,DataComboSubject,Subject);" onChange="ChangeOpt(Exam.value,Event.value,DataComboSubject,Subject);">	
		<%   
		while(rse.next())
		{
			mEventsubevent=rse.getString("EVENTSUBEVENT");
			if(meven.equals(""))
			{
			meven=mEventsubevent;
			qrymevent=mEventsubevent;
		%>
			<OPTION Value =<%=mEventsubevent%>><%=rse.getString("EVENTSUBEVENT")%></option>
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
		
	}	
  %>
	</td></tr>
	<!-- ********DataComboSubject***** -->
<%
	
	qry="select Subject||'('||subjectcode||')' subject,examcode,eventsubevent, ";
	qry=qry+" subjectID from V#STUDENTEVENTSUBJECTMARKS  ";
	qry=qry+" WHERE Institutecode='"+mInst+"' ";
	qry=qry+" And examcode in (select examid from DEFAULTVALUES) ";
	qry=qry+" And subjectID not in (";
	qry=qry+" select subjectID FROM v#STUDENTLTPDETAIL WHERE examcode in (select examid from DEFAULTVALUES) AND FSTID IN (SELECT FSTID from studentwisegrade where examcode in (select examid from DEFAULTVALUES))) ";
	qry=qry+" and nvl(PUBLISHED,'N')='Y' AND NVL(LOCKED,'N')='Y'  ";
	qry=qry+" and (nvl(Detained,'N')='D' or nvl(Detained,'N')='A' or nvl(Detained,'N')='M') "; 		
	qry=qry+" group by subject||'('||subjectcode||')',examcode,eventsubevent,subjectID ";
	qry=qry+" order by examcode,subject ";

	rss=db.getRowset(qry);
	
	if (request.getParameter("x")==null) 
	{
		
		%>
		<select name=DataComboSubject tabindex="0" id="DataComboSubject" style="WIDTH:0px">	
		<%   
		while(rss.next())
		{
			mSubj=rss.getString("examcode")+"***"+rss.getString("eventsubevent")+"///"+rss.getString("SubjectID") ;
			%>
			<OPTION  Value =<%=mSubj%>><%=rss.getString("subject")%></option> 
			<%			
			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=DataComboSubject tabindex="0" id="DataComboSubject" style="WIDTH:0px">	
		<%

		while(rss.next())
		{
			mSubj=rss.getString("examcode")+"***"+rss.getString("eventsubevent")+"///"+rss.getString("SubjectID") ;
			if(mSubj.equals(request.getParameter("DataComboSubject").toString().trim()))
 			{
				msubj=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rss.getString("subject")%></option> 
			
				<%			
		     	}
		     	else
		      {
				%>
		      	 <OPTION Value =<%=mSubj%>><%=rss.getString("subject")%></option> 
				<%			
		   	}
		}
		%>
		</select>
	  	<%
	 }
%>
	<tr>
	<td colspan=3>
<!-- **********SUBJECT************** -->
&nbsp;&nbsp;
<FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>&nbsp; &nbsp; &nbsp;
<%
	try
	{
	qry="select  subject||'('||subjectcode||')' subject, SubjectID from V#STUDENTEVENTSUBJECTMARKS  ";
	qry=qry+" WHERE Institutecode='"+mInst+"' And examcode in (select examid from DEFAULTVALUES) ";
	qry=qry+" And subjectID not in (";
	qry=qry+" select subjectID FROM v#STUDENTLTPDETAIL WHERE examcode in (select examid from DEFAULTVALUES) AND FSTID IN (SELECT FSTID from studentwisegrade where examcode in (select examid from DEFAULTVALUES)) )";
	qry=qry+" and nvl(PUBLISHED,'N')='Y' AND NVL(LOCKED,'N')='Y'  ";
	qry=qry+" and (nvl(Detained,'N')='D' or nvl(Detained,'N')='A' or nvl(Detained,'N')='M') and eventsubevent='"+qrymevent+"' and examcode='"+qryexam+"' "; 		
	qry=qry+" group by subject||'('||subjectcode||')', subjectID ";
	qry=qry+" order by subject ";
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 380px">	
		<OPTION selected Value=ALL>ALL</option>
		<%   
		while(rss.next())
		{
			mSubj=rss.getString("SubjectID") ;
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
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 380px">	
		<%
		if (request.getParameter("Subject").toString().trim().equals("ALL"))
 		{
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}

		while(rss.next())
		{
			mSubj=rss.getString("SubjectID") ;
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
&nbsp; &nbsp; &nbsp;
<INPUT Type="submit" Value="Show/Refresh">
</td></tr>
</table></form>
<%
if(request.getParameter("x")!=null)
		{
		if( request.getParameter("Subject")!=null && request.getParameter("Event")!=null && request.getParameter("Exam")!=null)
		{
		mIC=mInst;
		mEC=request.getParameter("Exam").toString().trim();
		mSC=request.getParameter("Subject").toString().trim();
		mEvent=request.getParameter("Event").toString().trim();	
		try
		{
		qrys="select nvl(detainedstatus,'A')detainedstatus from exameventmaster ";  
		qrys=qrys+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' and  exameventcode='"+mEvent+"' ";
		//out.print(qrys);
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
		else
		mPrint="Absent";		
	
	%>	
	<form name="frm1"  method="post" action="MakeUpTestAction.jsp">
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='98%' bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
	<thead>
	<tr bgcolor="#ff8c00">
	
		<td><b><font color=white>Enroll. No</font></b></td>
		<td><b><font color=white>Student name</font></b></td>
		<td><b><font color=white>Subject Code</font></b></td>
		<td><b><font color=white>Faculty Name (Short Name)</font></b></td>
		<td><b><font color=white>Section-<br>Subsection</font></b></td>
		<td><b><font color=white><%=mPrint%><font></b></td>
		<td><b><font color=white>Allow for MakeUp Test<font></b></td>
		</tr>	
	</thead>
<tbody>
	<%
try
{  
	qry="select distinct fstid,SUBJECTCODE SUBCODE,subjectID,detained2,maxmarks,sectionbranch,subsectioncode,EMPLOYEECODE,employeename,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
	qry=qry+" nvl(enrollmentno,' ')enrollmentno from V#STUDENTEVENTSUBJECTMARKS ";
	qry=qry+" where institutecode='"+mIC+"' and nvl(locked,'N')='Y' and MARKSAWARDED1 is  null and MARKSAWARDED2 is null  ";
	qry=qry+"and  examcode='"+mEC+"' and subjectID=decode('"+mSC+"','ALL',subjectID,'"+mSC+"') and EVENTSUBEVENT='"+mEvent+"' and (ltp='P' OR LTP='L' OR (LTP='E' AND PROJECTSUBJECT='Y') ) and nvl(PUBLISHED,'N')='Y' ";
	qry=qry+" and (nvl(Detained,'N')='D' or nvl(Detained,'N')='A' or nvl(Detained,'N')='M') "; 		
	//out.print(qry);
    rs1=db.getRowset(qry);
	 msno=0;
	 ctr=0;
	while(rs1.next())
	{	
	ctr++;
	mctr=String.valueOf(ctr).trim();
    	msno++;
			
		mName1="Detab"+String.valueOf(ctr).trim();
		mName2="Makeup"+String.valueOf(ctr).trim();
		mName3="Studentid"+String.valueOf(ctr).trim();
		mName4="Fstid"+String.valueOf(ctr).trim();
		mName5="SUBJECTCODE"+String.valueOf(ctr).trim();
  %>	
	<tr>
	
	<td ><%=rs1.getString("enrollmentno")%></td>
	<td nowrap><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>
	<td nowrap><%=rs1.getString("SUBCODE")%></td>
	<td nowrap><%=GlobalFunctions.toTtitleCase(rs1.getString("employeename"))%>-<%=rs1.getString("EMPLOYEECODE")%></td>
	<td><%=rs1.getString("sectionbranch")%>-<%=rs1.getString("subsectioncode")%></td>
  <%
	if(rs1.getString("detained2").equals("A") )	
	{
   %>
	<td align=center><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' value='Y' checked  onclick="return detained_check(<%=mName1%>,<%=mName2%>,'Y');"></td>
	<td align=center><input type='checkbox' name='<%=mName2%>' id='<%=mName2%>' value='M' onclick="return detained_check(<%=mName1%>,<%=mName2%>,'N');"></td>
	</tr>
   <%
	}	
	else if(rs1.getString("detained2").equals("D"))
	{ 
   %>	
	<td align=center><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' value='Y' checked  onclick="return detained_check(<%=mName1%>,<%=mName2%>,'Y');"></td>
 	<td align=center><input type='checkbox' name='<%=mName2%>' id='<%=mName2%>' value='M'  onclick="return detained_check(<%=mName1%>,<%=mName2%>,'N');"></td>
	</tr>
   <%
     }
	else
	{
   %>	
	<td align=center><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' value='Y'  onclick="return detained_check(<%=mName1%>,<%=mName2%>,'Y');"></td>
 	<td align=center><input type='checkbox' name='<%=mName2%>' id='<%=mName2%>' value='M' checked onclick="return detained_check(<%=mName1%>,<%=mName2%>,'N');"></td>
	</tr>
  <%
     }
  %>	
	<input type=hidden name='<%=mName3%>' id='<%=mName3%>' value='<%=rs1.getString("studentid")%>'>	
	<input type=hidden name='<%=mName4%>' id='<%=mName4%>' value='<%=rs1.getString("fstid")%>'>
	<input type=hidden name='<%=mName5%>' id='<%=mName5%>' value='<%=rs1.getString("SUBCODE")%>'>	

  <%	
     }  //closing of while 

      }
	catch(Exception e)
	{
	
	}
    %>
	<table width=98% border=1 bgcolor=white align=center>
	<tr bg color=white>
 	<td colspan=10 align=center>
	<INPUT Type="submit" Value="Save Status">
	</td></tr>
	</table>
	<input type=hidden name='institute' id='institute' value=<%=mInst%>>
	<input type=hidden name='Exam' id='Exam' value=<%=mEC%>>
	<input type=hidden name='EventSubevent' id='EventSubevent' value=<%=mEvent%>>
	<input type=hidden name='TotalCount' id='TotalCount' value=<%=ctr%>>
      <input type=hidden name='Status' id='Status' value=<%=mStatus%>>
	</tbody>
	</table>
	</form>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number", "CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
	</script>

	<%
	}
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Mandatory items(Event,Subject,Exam.,etc.) must be entered. </font> <br>");
	}
	}
   //--------------------------
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