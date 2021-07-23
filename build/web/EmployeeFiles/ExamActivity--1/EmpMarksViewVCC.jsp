

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ 	Complete Marks View of Student : Administrator ] </TITLE>


<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
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
</SCRIPT>	
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(Exam,DataEvent,DataCombo,Event,Subject)
{    
     removeAllOptions(Event);	
	var QryEvent='';
     for(i=0;i<DataEvent.options.length;i++)
       {
		var v1;
		var pos;
		var ec;
		var ev;
		var len;
		var otext;
		var v1=DataEvent.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		ec=v1.substring(0,pos);
		ev=v1.substring(pos+3,len);
		if (ec==Exam)
		 { 	
			var optn = document.createElement("OPTION");
			optn.text=DataEvent.options(i).text;
			optn.value=ev;
			if (QryEvent=='') QryEvent=ev;
			Event.options.add(optn);
			
		}
		
	 }
 	    removeAllOptions(Subject);	 
	    for(i=0;i<DataCombo.options.length;i++)
	      {  
			var v1s;
			var pos1;
			var pos2;
			var exams;
			var evs;
			var lens;
			var sc;
			var otexts;
			var v1s=DataCombo.options(i).value;
			lens= v1s.length ;	
			pos1=v1s.indexOf('***');
			pos2=v1s.indexOf('///');
			exams=v1s.substring(0,pos1);
			evs=v1s.substring(pos1+3,pos2);
			sc=v1s.substring(pos2+3,lens);

		if (exams==Exam && QryEvent==evs)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataCombo.options(i).text;
			optns.value=sc;
			Subject.options.add(optns);
		}
		
	 }
  	}
// ----------click event on EventSubevent------------

function ChangeOptions1(Exam,QryEvent,DataCombo,Subject)
{    
     	removeAllOptions(Subject);	
	
	for(i=0;i<DataCombo.options.length;i++)
       {       	
			var v1s1;
			var pos11;
			var pos21;
			var exams1;
			var evs1;
			var lens1;
			var sc1;
			var otexts1;
			var v1s1=DataCombo.options(i).value;
			
			lens1= v1s1.length ;
			pos11=v1s1.indexOf('***');
			pos21=v1s1.indexOf('///');
			exams1=v1s1.substring(0,pos11);
			evs1=v1s1.substring(pos11+3,pos21);
			sc1=v1s1.substring(pos21+3,lens1);
			if (exams1==Exam && QryEvent==evs1)
	    	 {	
				var optns1 = document.createElement("OPTION");
				optns1.text=DataCombo.options(i).text;
				optns1.value=sc1;
				
				Subject.options.add(optns1);
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

</SCRIPT>	

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>


<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",mComp="", mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="",msubj="";
String qry="",qry1="",x="",QryEventSubevent="";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0,mchkmarks=0;
String mmvalue="";
int ctr=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent=""; //,mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null,rsi=null;
String mMOP="",mName5="",mlistorder="";		
int kk=0;	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName8="";
String mName6="",mName7="", TRCOLOR="White";		
String mEventsubevent1="",mSubj1="",QryExam="",examidm="",msubj1="";	

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
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
							
if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
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

	qry="Select WEBKIOSK.ShowLink('266','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk1= db.getRowset(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
  //----------------------
%>
	<form name="frm" method=get>
	<input id="x" name="x" type=hidden>
	<table ALIGN=CENTER cellpadding=0 cellspacing=0 topmargin=0 >
	<tr><TD align=middle><font color="#a52a2a" size=4 face=verdana >	Complete Marks View of Student : Administrator 	</td></tr>
	</table>
	<table cellpadding=3 cellspacing=0 align=center rules=groups border=1>
	<tr><td>&nbsp; <font color=Green face=arial size=2><STRONG><%=mMemberName%> [<%=mDMemberCode%>]
	&nbsp;: &nbsp; &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp;<!--Institute****-->
	</td></tr>
	<tr><td>
<!--*********Exam**********-->
	<FONT color=black><FONT face=Arial size=2>&nbsp; Exam Code</FONT></FONT>
<%  
	try
	{
		qry=" Select GRADEENTRYEXAMID from (";
		qry+=" Select distinct nvl(EXAMCODE,' ') GRADEENTRYEXAMID , EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(lockexam,'N')='N' AND nvl(Deactive,'N')='N' ";
		qry+=" and examcode in (Select examcode from facultysubjecttagging where fstid in (select fstid from StudentEventSubjectMarks))";
      		qry+=" order by EXAMPERIODFROM DESC";
		qry+=") where rownum<8"; 
		rs=db.getRowset(qry);
		//out.print(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);" onChange="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);">	
		<%   
			while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				if(QryExam.equals(""))
				{
					QryExam=mExamid;
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
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);" onChange="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);">	
			<%
			while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				
				if(mExamid.equals(request.getParameter("Exam").toString().trim()))
 				{
					QryExam=mExamid;
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
//********************DataEvent Combo*************/

	try
	{
/*

qry="select distinct A.EVENTSUBEVENT EVENTSUBEVENT, A.ExamCode ExamCode from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"'  and (A.fstid) in ("; 
	qry+=" select AA.fstid from facultysubjecttagging AA where aa.INSTITUTECODE='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and nvl(deactive,'N')='N' AND employeeid='"+mDMemberID+"'  AND (LTP='L' or LTP='P' OR NVL(PROJECTSUBJECT,'N')='Y')";
	qry+=" UNION select AA.fstid from MultiFacultySubjectTagging aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.EMPLOYEEID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N' ";
	//qry+=" UNION select AA.fstid from Ex#SubjectGradeCoordinator aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.FACULTYID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks1 aa where aa.MARKS1ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks2 aa where aa.MARKS2ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from StudentEventSubjectMarks aa where aa.ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
      qry+=" ) and nvl(A.PUBLISHED,'N')='Y' order by ExamCode ";
	  
	  Quite simply, object serialization provides a program the ability to read or write a whole object to and from a raw byte stream. It allows Java objects and primitives to be encoded into a byte stream suitable for streaming to some type of network or to a file-system, or more generally, to a transmission medium or storage facility. A seralizable object must implement the Serilizable interface. We use ObjectOutputStream to write this object to a stream and ObjectInputStream to read it from the stream.
	  
	  */

	
	qry="SELECT DISTINCT a.eventsubevent eventsubevent, a.examcode examcode           FROM v#studenteventsubjectmarks a          WHERE a.institutecode = '"+mInst+"'                      AND NVL (a.published, 'N') = 'Y' and  nvl(a.LOCKED,'N')='Y'  group by a.eventsubevent , a.examcode        ORDER BY examcode ";
	
	rse=db.getRowset(qry);
//	out.print(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=DataEvent tabindex="0" id="DataEvent" style="WIDTH: 0px">	
		<%   
		while(rse.next())
		{
			mEventsubevent1=rse.getString("examcode")+"***"+rse.getString("EVENTSUBEVENT").toString().trim();
			%>
			<OPTION Value ="<%=mEventsubevent1%>"><%=rse.getString("EVENTSUBEVENT")%></option> 
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=DataEvent tabindex="0" id="DataEvent" style="WIDTH: 0px">	
		<%
		while(rse.next())
		{
			mEventsubevent1=rse.getString("examcode")+"***"+rse.getString("EVENTSUBEVENT").toString().trim();
			if(mEventsubevent1.equals(request.getParameter("DataEvent").toString().trim()))
 			{
				%>
				<OPTION selected Value ="<%=mEventsubevent1%>"><%=rse.getString("EVENTSUBEVENT")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mEventsubevent1%>"><%=rse.getString("EVENTSUBEVENT")%></option>  
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
	//********************Event Combo************/

	%>
	&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2>Event-Subevent</FONT></FONT>
	<%
	try
	{
	/*out.print(mExamid+" "+QryExam);%><BR><%*/
/*	qry="select distinct A.EVENTSUBEVENT from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"' and  (A.fstid) in ("; 
	qry+=" select AA.fstid from facultysubjecttagging AA where aa.INSTITUTECODE='"+mInst+"'  and facultytype=decode('"+mDMemberType+"','E','I','E') and nvl(deactive,'N')='N' AND employeeid='"+mDMemberID+"'  AND (LTP='L' or LTP='P' OR NVL(PROJECTSUBJECT,'N')='Y')";
	qry+=" UNION select AA.fstid from MultiFacultySubjectTagging aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.EMPLOYEEID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from Ex#SubjectGradeCoordinator aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.FACULTYID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks1 aa where aa.MARKS1ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks2 aa where aa.MARKS2ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from StudentEventSubjectMarks aa where  aa.ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
      qry=qry+" ) and nvl(A.PUBLISHED,'N')='Y' order by eventsubevent";*/

qry="SELECT DISTINCT a.eventsubevent eventsubevent, a.examcode examcode           FROM v#studenteventsubjectmarks a          WHERE a.institutecode = '"+mInst+"'                      AND NVL (a.published, 'N') = 'Y' and  nvl(a.LOCKED,'N')='Y' group by a.eventsubevent , a.examcode        ORDER BY examcode ";
rse=db.getRowset(qry);
	//out.print(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="Event" tabindex="0" id="Event" style="WIDTH: 160px" onclick="ChangeOptions1(Exam.value,Event.value,DataCombo,Subject);" onChange="ChangeOptions1(Exam.value,Event.value,DataCombo,Subject);">	
		<%   
		while(rse.next())
		{
			mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
			if(QryEventSubevent.equals(""))
				QryEventSubevent=mEventsubevent;
			%>
			<OPTION selected Value ="<%=mEventsubevent%>"><%=rse.getString("EVENTSUBEVENT")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="Event" tabindex="0" id="Event" style="WIDTH: 160px" onclick="ChangeOptions1(Exam.value,Event.value,DataCombo,Subject);" onChange="ChangeOptions1(Exam.value,Event.value,DataCombo,Subject);">	
		<%
		while(rse.next())
		{
			mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
			
			if(mEventsubevent.equals(request.getParameter("Event").toString().trim()))
 			{QryEventSubevent=mEventsubevent;
			%>
				<OPTION selected Value ="<%=mEventsubevent%>"><%=rse.getString("EVENTSUBEVENT")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mEventsubevent%>"><%=rse.getString("EVENTSUBEVENT")%></option>
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
<%
//******************DataCombo Subject********************/
try
{
	/*qry="select A.subject ||' ( '||A.subjectcode||' )' subject,A.subjectID,A.examcode,A.eventsubevent from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"'  and (A.fstid) in ("; 
	qry+=" select AA.fstid from facultysubjecttagging AA where aa.INSTITUTECODE='"+mInst+"'  and facultytype=decode('"+mDMemberType+"','E','I','E') and nvl(deactive,'N')='N' AND employeeid='"+mDMemberID+"'  AND (LTP='L' or LTP='P' OR NVL(PROJECTSUBJECT,'N')='Y')";
	qry+=" UNION select AA.fstid from MultiFacultySubjectTagging aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.EMPLOYEEID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from Ex#SubjectGradeCoordinator aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.FACULTYID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks1 aa where aa.MARKS1ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks2 aa where aa.MARKS2ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventSubjectMarks aa where aa.INSTITUTECODE='"+mInst+"'  and aa.ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" ) and nvl(A.PUBLISHED,'N')='Y' ";
	qry+=" GROUP BY A.subject ||' ( '||A.subjectcode||' )',A.subjectID,A.examcode,A.eventsubevent order by examcode, eventsubevent ";*/

	qry="SELECT   a.subject || ' ( ' || a.subjectcode || ' )' subject, a.subjectid,         a.examcode, a.eventsubevent    FROM v#studenteventsubjectmarks a   WHERE a.institutecode = '"+mInst+"'     and  nvl(a.LOCKED,'N')='Y'      AND NVL (a.published, 'N') = 'Y' GROUP BY a.subject || ' ( ' || a.subjectcode || ' )',         a.subjectid,         a.examcode,         a.eventsubevent ORDER BY examcode, eventsubevent ";
	//out.print(qry);
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	
		<%   
		while(rss.next())
		{
			mSubj1=rss.getString("examcode")+"***"+rss.getString("eventsubevent").toString().trim()+"///"+rss.getString("SubjectID");
			
			if(msubj.equals(""))
 			msubj=mSubj1;
			%>
			<OPTION Value ="<%=mSubj1%>"><%=rss.getString("Subject")%></option> 
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="DataCombo" tabindex="0" id="DataCombo" style="WIDTH: 0px">	
		<%
		while(rss.next())
		{
		mSubj1=rss.getString("examcode")+"***"+rss.getString("eventsubevent").toString().trim()+"///"+rss.getString("SubjectID");

			if(mSubj1.equals(request.getParameter("DataCombo").toString().trim()))
 			{
				msubj=mSubj1;
				%>
				 <OPTION selected Value ="<%=mSubj1%>"><%=rss.getString("Subject")%></option> 
				<%			
		     	}
		     	else
		      {
				%>
			     	<OPTION Value ="<%=mSubj1%>"><%=rss.getString("Subject")%></option> 
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
<tr><td>
<!--SUBJECT**************-->
<FONT color=black><FONT face=Arial size=2>&nbsp; Subject</FONT></FONT>
<%
	try
	{
	/*
	qry="select A.subject ||' ( '||A.subjectcode||' )' subject, A.subjectID from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"'  and  (A.fstid) in ("; 
	qry+=" select AA.fstid from facultysubjecttagging AA where aa.INSTITUTECODE='"+mInst+"'  and facultytype=decode('"+mDMemberType+"','E','I','E') and nvl(deactive,'N')='N' AND employeeid='"+mDMemberID+"'  AND (LTP='L' or LTP='P' OR NVL(PROJECTSUBJECT,'N')='Y')";
	qry+=" UNION select AA.fstid from MultiFacultySubjectTagging aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.EMPLOYEEID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from Ex#SubjectGradeCoordinator aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.FACULTYID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks1 aa where aa.MARKS1ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks2 aa where aa.MARKS2ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventSubjectMarks aa where aa.INSTITUTECODE='"+mInst+"'  and  aa.ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry=qry+" )and nvl(PUBLISHED,'N')='Y' and eventsubevent='"+QryEventSubevent+"' and examcode='"+QryExam+"' ";
	qry=qry+" GROUP BY A.subject ||' ( '||A.subjectcode||' )',A.subjectID ";
	qry=qry+" order by subject";
	
	Singleton is a design pattern meant to provide one and only one instance of an object. Other objects can get a reference to this instance through a static method (class constructor is kept private). Why do we need one? Sometimes it is necessary, and often sufficient, to create a single instance of a given class. This has advantages in memory management, and for Java, in garbage collection. Moreover, restricting the number of instances may be necessary or desirable for technological or business reasons--for example, we may only want a single instance of a pool of database connections.

	Transient variable can't be serialize. For example if a variable is declared as transient in a Serializable class and the class is written to an ObjectStream, the value of the variable can't be written to the stream instead when the class is retrieved from the ObjectStream the value of the variable becomes null.

Hash Map
The Map interface maps unique keys to value means it associate value to unique keys which you use to retrieve value at a later date. Some of the key points are :

•Using a key and a value, you can store the value in Map object. You can retrieve it later by using it's key.
•When no element exists in the invoking Map, many methods throw a  'NoSuchElementException'.
•A ClassCastException is thrown when an object is incompatible with the elements in a map.
•A NullPointerException is thrown if an attempt is made to use a null object and null is not allowed in the map.
•An UnsupportedOperationException is thrown when an attempt is made to change an unmodifiable map. 

	*/

	qry="SELECT   a.subject || ' ( ' || a.subjectcode || ' )' subject, a.subjectid,         a.examcode, a.eventsubevent    FROM v#studenteventsubjectmarks a   WHERE a.institutecode = '"+mInst+"'     and  nvl(a.LOCKED,'N')='Y'      AND NVL (a.published, 'N') = 'Y' GROUP BY a.subject || ' ( ' || a.subjectcode || ' )',         a.subjectid,         a.examcode,         a.eventsubevent ORDER BY subject ";
	
	
	//out.print(qry);
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="Subject" tabindex="0" id="Subject"  style="WIDTH: 454px">	
		<%   
		while(rss.next())
		{
			mSubj=rss.getString("SubjectID").toString().trim();
			if(msubj1.equals(""))
 			msubj1=mSubj;
			%>
			<OPTION selected Value="<%=mSubj%>"><%=rss.getString("Subject")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="Subject" tabindex="0" id="Subject" style="WIDTH: 454px">	
		<%
		while(rss.next())
		{
			mSubj=rss.getString("SubjectID").toString().trim();
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj1=mSubj;
				%>
				<OPTION selected Value ="<%=mSubj%>"><%=rss.getString("Subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSubj%>"><%=rss.getString("Subject")%></option>
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
	&nbsp; &nbsp; &nbsp;&nbsp;<INPUT Type="submit" Value="Show/Refresh">&nbsp;&nbsp;
	</td></tr>
	</table></form>
	<%	
		if(request.getParameter("x")!=null)
		{
		if(request.getParameter("Exam")!=null)
			mEC=request.getParameter("Exam").toString().trim();
		else
			mEC=QryExam;
		
		if(request.getParameter("Subject")!=null)
			mSC=request.getParameter("Subject").toString().trim();
		else
			mSC=msubj1;

		if(request.getParameter("Event")!=null)
			mEvent=request.getParameter("Event").toString().trim();		
		else
			mEvent=QryEventSubevent;
		
		//out.print(mEvent);

		String mSC1="";
		qry="select SubjectCode from SUBJECTMASTER where InstituteCode='"+mInst+"' and SubjectID='"+mSC+"' ";
		//out.print(qry);
		rsm=db.getRowset(qry);
		if(rsm.next())
		mSC1=rsm.getString(1);


		qry="select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
 		qry=qry+" where institutecode='"+mInst+"' and EVENTSUBEVENT='"+mEvent+"' And ";
		qry=qry+" examcode='"+mEC+"' and (ltp='L' OR PROJECTSUBJECT='Y' OR LTP='P')and subjectID='"+mSC+"' ";
		
		rsm=db.getRowset(qry);
		//out.print(qry);
		if(rsm.next())
		{
			mMOP=rsm.getString("MARKSORPERCENTAGE");
			mMaxmarks=rsm.getDouble("MAXMARKS");		
		}		
		if (mMOP.equals("M"))
			MyMax=mMaxmarks;
		else	
			MyMax=100;

		if(mMOP.equals("M"))
		{
			%>
			<CENTER><FONT face=Arial size=2><STRONG>Maximum Marks (Full Marks for Evaluation) : </STRONG><%=mMaxmarks%></FONT>
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Subject :</STRONG></FONT>&nbsp;<%=mSC1%>&nbsp;(<%=mEvent%>) 
			&nbsp;&nbsp;&nbsp;<font color=blue><a style="cursor:hand" onClick="window.print();"><img src="../../Images/printer.gif"><b>Click to Print</b></a></font>
			<%
		}
		else
		{
			%>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Percentage
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:&nbsp;</STRONG></FONT><%=mMaxmarks%>
			<%
		}
		%>	
		<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='100%' bottommargin=0 rules=ROWS topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
		<thead>
		<tr bgcolor="#ff8c00">	
		<td><b><font color=white>Sl No.</font></b></td>
		<td><b><font color=white>Roll No.</font></b></td>
		<td><b><font color=white>Student Name</font></b></td>
		<td><b><font color=white>Status</font></b></td>
		<td align=center><b><font color=white>Marks Obtained out of <%=mMaxmarks%></font></b></td>
		<td title="Course(Section Branch)"><b><font color=white>Group<font></b></td>
		<td align=center><b><font color=white>Sem.<font></b></td>
		</tr>
		</thead>
		<tbody>
	<%		
try{
	//and A.employeeid='"+mDMemberID+"'

	qry="select A.fstid,nvl(A.studentid,' ')studentid,nvl(A.studentname,' ')studentname, ";
	qry=qry+" nvl(A.enrollmentno,' ')enrollmentno,nvl(A.semester,0)semester,A.subsectioncode, ";
	qry=qry+ " nvl(A.programcode,' ')programcode,nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH  from V#STUDENTEVENTSUBJECTMARKS A  ";
	qry=qry+" where A.institutecode='"+mInst+"'  AND NVL(A.DEACTIVE,'N')='N'  and nvl(A.PUBLISHED,'N')='Y' and EVENTSUBEVENT='"+mEvent+"' And ";
	qry=qry+" A.examcode='"+mEC+"'   and (A.ltp='L' OR A.PROJECTSUBJECT='Y' OR A.LTP='P') and A.subjectID='"+mSC+"' ";
	qry=qry+" GROUP BY A.fstid,nvl(A.studentid,' '),nvl(A.studentname,' '), ";
	qry=qry+" nvl(A.enrollmentno,' '),nvl(A.semester,0),A.subsectioncode, ";
	qry=qry+ " nvl(A.programcode,' '),nvl(A.SECTIONBRANCH,' ') Order by enrollmentno" ;
	//out.println(qry);
	rs1=db.getRowset(qry);
	msno=0;
	ctr=0;
	while(rs1.next())
	{	ctr++;
		if(ctr%2==0)
			TRCOLOR="White";
		else
			TRCOLOR="#F8F8F8";
    		msno++;
		mName1="Semester"+String.valueOf(ctr).trim();  
		mName2="Studentid"+String.valueOf(ctr).trim();
		mName3="Marks"+String.valueOf(ctr).trim();
		mName4="Detained"+String.valueOf(ctr).trim();
		mName5="Fstid"+String.valueOf(ctr).trim();
  %>	
	
	<tr BGCOLOR=<%=TRCOLOR%>>
		<td><%=ctr%></td>
	<td><%=rs1.getString("enrollmentno")%></td>
	<td><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>
	<%
		
		qry="Select nvl(MARKSAWARDED2,-1)MARKSAWARDED1,nvl(MARKSAWARDED1,-1)OLDMARKSAWARDED, ";
		qry=qry+" decode(nvl(DETAINED2,' '),'D','Detained','M','Make Up','A','Absent',' ') DETAINED , decode(nvl(DETAINED,' '),'D','Detained','M','Make Up','A','Absent',' ') OLDDETAINED  from V#STUDENTEVENTSUBJECTMARKS ";
		qry=qry+" where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mEC+"' and ";
		qry=qry+" EVENTSUBEVENT='"+mEvent+"'   AND NVL(DEACTIVE,'N')='N' and   ";
		qry=qry+"  fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
		rs3=db.getRowset(qry);
		//out.print(qry);
		x="";
		kk=0;
		if(mMOP.equals("P"))
		x="%";
		 if(rs3.next())
		{	
			mName6="OLDMARKSAWARDED"+String.valueOf(ctr).trim();
			mName7="OLDDETAINED"+String.valueOf(ctr).trim();
			mName8="Chkmarks"+String.valueOf(ctr).trim();
		
		  if(rs3.getDouble("MARKSAWARDED1")==-1 && ((rs3.getString("Detained")).equals("Detained") || rs3.getString("Detained").equals("Make Up") || rs3.getString("Detained").equals("Absent") || rs3.getString("OLDDETAINED").equals("Absent") ))
		  {
		%>
			<td align=Left><font color=red><%=rs3.getString("Detained")%></font></td>
			<td align=center>&nbsp; &nbsp; -- &nbsp; &nbsp;</td>
		<%
		  }	
		  else if(rs3.getDouble("MARKSAWARDED1")>=0 && ((rs3.getString("Detained")).equals("Detained")||rs3.getString("Detained").equals("Make Up")||rs3.getString("Detained").equals("Absent")))
		{
				if(mMOP.equals("P"))
				mvalue=(rs3.getDouble("MARKSAWARDED1")*100)/mMaxmarks;
				else
				mvalue=rs3.getDouble("MARKSAWARDED1");
				if(mvalue<0)
				mmvalue="";
				else
				mmvalue=String.valueOf(mvalue);
		%>
			<td align=Left><font color=red><%=rs3.getString("Detained")%></font></td>
			<td align=left>&nbsp; &nbsp; &nbsp; &nbsp;<%=mmvalue%><%=x%></td>
			
		<%   
 			}
			else if(rs3.getDouble("MARKSAWARDED1")>=0)
			{
				if(mMOP.equals("P"))
				mvalue=(rs3.getDouble("MARKSAWARDED1")*100)/mMaxmarks;
				else
				mvalue=rs3.getDouble("MARKSAWARDED1");
				if(mvalue<0)
				mmvalue="";
				else
				mmvalue=String.valueOf(mvalue);
		%>
			<td align=Left><font color=green><%=rs3.getString("Detained")%></font></td>
			<td align=center>&nbsp; &nbsp; &nbsp; &nbsp;<%=mmvalue%><%=x%></td>
			
		<%   
 			}
			
			
	
		}
	%>
		<td><%=rs1.getString("programcode")%>&nbsp;(<%=rs1.getString("SECTIONBRANCH")%>)</td>
		<td>&nbsp; &nbsp; &nbsp; &nbsp;<%=rs1.getString("semester")%></td>
		</tr>
	<%
	   } 
	}
	catch(Exception e)
	{
	//	out.print("error"+qry);
	}
	%>
		<table>	
		</tbody>
<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),[ "Number", "CaseInsensitiveString", "CaseInsensitiveString", "Number", "CaseInsensitiveString", "Number"]);
		</script>

		
	<%
/*
}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Mandatory items(Event,Subject,Exam.,etc.) must be entered. </font> <br>");

	}
*/	

	}// closing of request.getParameter("x")
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
%>
</body>
</html>