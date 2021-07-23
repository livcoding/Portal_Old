<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Level Two Marks Entry ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;



function kH(e) 
{
var pK = document.all? window.event.keyCode:e.which;
return pK != 13;
}

document.onkeypress = kH;
if (document.layers) document.captureEvents(Event.KEYPRESS);

-->

</script>
<SCRIPT LANGUAGE="JavaScript">
<!-- Beginning of JavaScript -


 function Marks_Check(objchknew,objtxtnew,mMax1,objchkold,objtxtold)
{
	var print;
	if(objchkold.value=='D')
	print='Detained';
	else
	print='Absent';	
	
	if(objchkold.value=='N' && objtxtnew.value=='')
	{
		alert('you can not left marks entry field blank! Previous marks is '+ objtxtold.value +'.');	
	
	}
	else
	{
	
	if(objtxtnew.value!='' && objtxtnew.value.length>0)
	{
 	var oldm=0.0;
	var newm=0.0;
	var mMax=0.0;	
	var mNewS='';
	var entry=objtxtnew.value;
	if(parseFloat(entry)>=0)
	{
	mNewS=objtxtnew.value;
	oldm=parseFloat(objtxtold.value);
	newm=parseFloat(objtxtnew.value);
	mMax=parseFloat(mMax1);
	if(objchkold.value=='D' || objchkold.value=='A')
	{ 
		if(newm<=mMax)
//		if(oldm<=mMax1)
		{
		var mChoice=confirm('In Level-I entry Student has been '+print+'! Do You want to remove Old '+print+' Flag? with New Marks : '+ newm +' ?');
		if(mChoice)
			{
				objchknew.checked=false;			
				objchkold.value='N';
				objtxtold.value=newm ;
				objtxtnew.value=newm;
				objtxtnew.focus;
			}
			else
			{
				objtxtnew.value='';			
				objchknew.focus;
			}

		}	
		else
			 alert('Marks must be <='+mMax);
			 objtxtnew.value='';
			 objtxtnew.focus;

		}
	else if(objchkold.value=='N' && newm!=oldm && newm<=mMax)
	{
	var mChoice=confirm('Old marks :'+oldm+'  does not match with new: '+newm+' Replace Old Marks :'+oldm+' with New Marks : '+ newm+' ?');
		if(mChoice)
				{
				   objtxtold.value=newm;
				   objchknew.checked=false;
				   objchkold.value='N';
	                     objtxtnew.value=newm;
				   objtxtnew.focus;
					
				}
			else
				{
				    objtxtnew.value='';
				    objtxtnew.focus;
				}
	}
	else if(objchkold.value=='N' && newm==oldm)
	{
		objchknew.checked=false;
		objtxtnew.focus;
	}
	else if(newm>mMax)
	{
	 alert('Marks must be <='+mMax);
 	 objtxtnew.value='';
	 objtxtnew.focus;
	
	}
}
else
{
alert('Invalid Marks!');
objtxtnew.value='';
  objtxtnew.focus;
 }
	}
}
}

 function detained_check(objchknew,objtxtnew,objchkold,objtxtold,mFlag)
 {
	var print;

	if(mFlag=='D')
	print='Detained';
	else
	print='Absent';
	 
	if(objchknew.value!='N')
	{ 
	  if(objchkold.value==mFlag)
	  {	
		
		objtxtold.value='-1';
		objtxtnew.value='';
	//	objchknew.checked=true;
	//	objchknew.focus;
	   }
	   else
	   {
	    var mChoice=confirm('Old Marks is : '+objtxtold.value +' Do you want to '+print+' Students (old and new marks will be removed)?');
		if(mChoice)
		{
		objtxtold.value='-1';
		objtxtnew.value='';
		//objchknew.checked=true;
		objchkold.value=mFlag;
	//	objchknew.focus;
		}
		else
		{
	//	objchknew.checked=false;
	//	objchknew.focus;
		}			
	   }							
	}
	else
	{
	if(objchkold.value=='N')
	  {
	//	objchknew.checked=false;
	//	objchknew.focus;
	   }
	   else
	   {
	    var mChoice=confirm('Student already '+print+'! Do you want to remove '+print+' flag and enter marks?');
		if(mChoice)
		{
	//	objchknew.checked=false;
		objchkold.value='N';
	//	objchknew.focus;
		}
		else
		{
	//	objchknew.checked=true;
	//	objchknew.focus;
		}			
	   }					
	}			


      }



if(window.history.forward(1) != null)
window.history.forward(1);

// - End of JavaScript - -->
</SCRIPT>



</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", mInst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="",msubj="";
String qry="",qry1="",x="";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0,mchkmarks=0;
String mmvalue="",qrys="";
int ctr=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent=""; //,mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null;
String mMOP="",mName5="",mlistorder="";
double mWeight=0;		
int kk=0;	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName8="";
String mName6="",mName7="",mStatus="",mPrint="",mSE="";

//out.println("Global Maximum Inactive Interval of Session in Seconds is : " +session.getMaxInactiveInterval()); 
session.setMaxInactiveInterval(10800); 
//out.println("Special Maximum Inactive Interval of Session in Seconds is : " +session.getMaxInactiveInterval()); 

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
		
		String mLoginComp="";


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

	qry="Select WEBKIOSK.ShowLink('60','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk1= db.getRowset(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	   {
  //----------------------



%>
  <form name="frm"  method="POST" >
  <input id="x" name="x" type=hidden>
  <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0><tr><TD colspan=0 align=middle>
  <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">IInd Level Marks Entry<br>(After completing Ist level marks entry by all the concerened faculty members.)</TD></font></td></tr></TABLE>
  <table   cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=1>
  <tr><td><font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]&nbsp;&nbsp; : &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (<%=GlobalFunctions.toTtitleCase(mDept)%>)
	</td></tr>
	<tr><td>	<INPUT TYPE='HIDDEN' Name=InstCode tabindex="1" id="InstCode" VALUE=<%=mInst%>>	
<!--*********Exam**********-->
&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>ExamCode</STRONG></FONT></FONT>
<%  
	try
	{
		qry="Select distinct NVL(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='"+mInst+"' And CompanyCode='"+mLoginComp+"'";
		rs=db.getRowset(qry);
		//out.print(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="2" id="Exam" style="WIDTH: 125px">	
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
			<select name=Exam tabindex="2" id="Exam" style="WIDTH: 125px">	
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
	&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Exam Event</STRONG></FONT></FONT>
<%    try{
	

	qry="select EVENTSUBEVENT from V#EXAMEVENTSUBJECTTAGGING a where ";
	qry=qry+" trunc(sysdate) between trunc(FROMDATE) and trunc(TODATE)  "; 
	qry=qry+" aND CORDFACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and CORDFACULTYID='"+mDMemberID+"' ";
	qry=qry+" and fstid not in (select fstid from studenteventsubjectmarks b where ";
	qry=qry+"  nvl(locked,'N')='Y' and a.eventsubevent=b.eventsubevent ) and nvl(deactive,'N')='N' ";  
	qry=qry+" and nvl(locked,'N')='N'  AND ExamCODE='"+mExamid+"'";
//	qry=qry+" and nvl(PUBLISHED,'N')='N' ";
	qry=qry+" and nvl(PROCEEDSECOND,'N')='Y' and nvl(deactive,'N')='N'  GROUP BY EVENTSUBEVENT"; 

	rse=db.getRowset(qry);
 // out.print(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="Event" tabindex="3" id="Event" style="WIDTH: 145px">	
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
		<select name="Event" tabindex="3" id="Event" style="WIDTH: 145px">	
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

	}
	catch(Exception e)
	{
		//out.print("error");
	}	
%>

<FONT color=black><FONT face=Arial size=2><STRONG>Order By</STRONG></FONT></FONT>
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

</td></tr>

<!--********Subject*****-->

<tr>
<td>
<!--SUBJECT**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
<%
	try
	{
	
	qry="select subject ||' ( '||subjectcode||' )' subject,subjectID from V#EXAMEVENTSUBJECTTAGGING a where ";
	qry=qry+" trunc(sysdate) between trunc(FROMDATE) and trunc(TODATE) ";
	qry=qry+" AND CORDFACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and CORDFACULTYID='"+mDMemberID+"' ";
	qry=qry+" and fstid not in (select fstid from studenteventsubjectmarks b where ";
	qry=qry+"  nvl(locked,'N')='Y' and a.eventsubevent=b.eventsubevent ) and nvl(deactive,'N')='N' "; 
	qry=qry+" and nvl(locked,'N')='N' AND ExamCODE='"+mExamid+"'";
	qry=qry+" and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and nvl(PROCEEDSECOND,'N')='Y' GROUP BY subject||' ( '||subjectcode||' )',subjectID"; 
 	
	// out.print(qry);
	
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="4" id="Subject" style="WIDTH: 450px">	
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
		<select name=Subject tabindex="4" id="Subject" style="WIDTH: 450px">	
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
</select>&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT Type="submit" tabindex="7" Value="Submit">&nbsp;&nbsp;
</td></tr>
</table></form>
	<%	
		int tabctrtxt=7;
		int tabctrchk=1000;
		if(request.getParameter("x")!=null)
		{
		 if( request.getParameter("Subject")!=null && request.getParameter("Event")!=null && request.getParameter("Exam")!=null)
			{
			mIC=request.getParameter("InstCode").toString().trim();
			mEC=request.getParameter("Exam").toString().trim();
			mSC=request.getParameter("Subject").toString().trim();
			mList=request.getParameter("listorder").toString().trim();
			mOrder=request.getParameter("order").toString().trim();
			mEvent=request.getParameter("Event").toString().trim();		
			int len=0;
			int pos=0;
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
			try
			{
			qrys="select nvl(detainedstatus,'A')detainedstatus from exameventmaster ";  
			qrys=qrys+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' and  exameventcode='"+mSE+"' ";

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

			
		qry="select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
 		qry=qry+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' and CORDFACULTYID ='"+mDMemberID+"'";
		qry=qry+" And EVENTSUBEVENT='"+mEvent+"' and CORDFACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='"+mSC+"' ";
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
			
try
	{

	qry1="SELECT nvl(B.EMPLOYEENAME,' ')EMPLOYEENAME,nvl(B.EMPLOYEECODE,' ')EMPLOYEECODE,B.SUBJECT SUBJECT,B.SECTIONBRANCH SECTIONBRANCH,B.SUBSECTIONCODE SUBSECTIONCODE FROM  V#EXAMEVENTSUBJECTTAGGING B WHERE B.institutecode='"+mIC+"' AND B.examcode='"+mEC+"' and B.EVENTSUBEVENT='"+mEvent+"' AND nvl(B.PROCEEDSECOND,'N')='N' and nvl(B.DEACTIVE,'N')='N' and nvl(B.locked,'N')='N' AND B.SUBJECTID='"+mSC+"' AND B.CORDFACULTYID='"+mDMemberID+"' AND (B.ltp='L' OR (B.LTP='E' AND B.PROJECTSUBJECT='Y') OR B.LTP='P') AND  EXISTS (SELECT FSTID FROM V#STUDENTEVENTSUBJECTMARKS A WHERE A.EVENTSUBEVENT=B.EVENTSUBEVENT AND a.fstid=b.fstid AND A.STUDENTID=B.STUDENTID AND A.EXAMCODE=B.EXAMCODE and nvl(A.LOCKED,'N')='N' AND (A.LTP='L' OR (A.LTP='E' AND A.PROJECTSUBJECT='Y') OR A.LTP='P') AND A.PUBLISHED='N') GROUP BY B.EMPLOYEENAME,B.EMPLOYEECODE,B.SECTIONBRANCH,B.SUBSECTIONCODE,B.SUBJECT ";
   // out.println(qry1);
	rs=db.getRowset(qry1);

	if(!rs.next())
	{
			if(mMOP.equals("M"))
			{
				%>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Marks
				&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:</STRONG></FONT><%=mMaxmarks%>
				&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Weightage:</STRONG></FONT><%=mWeight%>
				<%
			}
			else
			{
				%>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Percentage
				&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:&nbsp;</STRONG></FONT><%=mMaxmarks%>
				&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Weightage:</STRONG></FONT><%=mWeight%>
			   <%
		    }
			%>	
			<table cellspacing=0 cellpadding=0 width=98% border=1 align=center>
			<form name="frm1"  method="post" action="MarksEntryLvl2Action.jsp">
			<tr bgcolor="#c00000">
			<td><b><font color=white>SNo.</font></b></td>
			<td><b><font color=white>Enroll. No</font></b></td>
			<td><b><font color=white>Student Name</font></b></td>
			<td><b><font color=white><%=mPrint%></font></b></td>
			<td align=center><b><font color=white> Marks</font></b></td>
			<td><b><font color=white>Course(Section<br>Branch)<font></b></td>
			<td><b><font color=white>Sem.<font></b></td>
			<%

			qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
			qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester,subsectioncode, ";
			qry=qry+ "nvl(programcode,' ')programcode,nvl(SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a ";
			qry=qry+" where institutecode='"+mIC+"' and nvl(PROCEEDSECOND,'N')='Y' and nvl(locked,'N')='N' and ";
			qry=qry+" EVENTSUBEVENT='"+mEvent+"' and nvl(a.DEACTIVE,'N')='N' and nvl(a.STUDENTLTPDEACTIVE,'N')='N' and  ";
			qry=qry+" Examcode='"+mEC+"' and CORDFACULTYID='"+mDMemberID+"' and CORDFACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' and ";
			qry=qry+" Exists (select studentid from V#STUDENTEVENTSUBJECTMARKS b where b.fstid=a.fstid and b.EVENTSUBEVENT=a.EVENTSUBEVENT and a.studentid=b.studentid and nvl(b.LOCKED,'N')='N' and (b.LTP='L' OR (B.LTP='E' AND B.PROJECTSUBJECT='Y') OR B.LTP='P')) ";
			qry=qry+" GROUP BY fstid,nvl(studentid,' '),nvl(studentname,' '), ";
			qry=qry+" nvl(enrollmentno,' '),nvl(semester,0),subsectioncode, ";
			qry=qry+" nvl(programcode,' '),nvl(SECTIONBRANCH,' ') ";
			qry=qry+" order by "+mList+ " "+mOrder+ " ,enrollmentno " ;
			//out.println(qry);
			rs1=db.getRowset(qry);
		 	msno=0;
			ctr=0;
			
			while(rs1.next())
			{
				ctr++;
	    			msno++;
				tabctrtxt++;
				tabctrchk++;
				mName1="Semester"+String.valueOf(ctr).trim();  
				mName2="Studentid"+String.valueOf(ctr).trim();
				mName3="Marks"+String.valueOf(ctr).trim();
				mName4="Detained"+String.valueOf(ctr).trim();
				mName5="Fstid"+String.valueOf(ctr).trim();
				%>
				<tr>
				<td><%=msno%>.</td>
				<td><%=rs1.getString("enrollmentno")%></td>
				<td><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>
				<%
				qry="Select nvl(MARKSAWARDED2,-1)MARKSAWARDED1,nvl(MARKSAWARDED1,-1)OLDMARKSAWARDED, ";
				qry=qry+" nvl(DETAINED2,'N') DETAINED ,NVL(DETAINED,'N') OLDDETAINED  from V#STUDENTEVENTSUBJECTMARKS ";
				qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
				qry=qry+" EVENTSUBEVENT='"+mEvent+"' and   ";
				qry=qry+" fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
				//out.print(qry);
				rs3=db.getRowset(qry);
				x="";
				kk=0;
				if(mMOP.equals("P"))
				x="%";
				if(rs3.next())
				{	
					mName6="OLDMARKSAWARDED"+String.valueOf(ctr).trim();
					mName7="OLDDETAINED"+String.valueOf(ctr).trim();
					mName8="Chkmarks"+String.valueOf(ctr).trim();
					if ((rs3.getString("Detained")).equals("D")||(rs3.getString("Detained")).equals("A"))
					{
						//**************************************************************			
				    	if(mStatus.equals("B"))
						{
						    if((rs3.getString("Detained")).equals("D"))
						    {
								%>
								<td align=center>
								<select name='<%=mName4%>' id='<%=mName4%>' onchange="return	detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
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
								<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
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
								<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
								<option selected value="N">NA</option>
								<option  value="A">Absent</option>
								<option  value="D">Detained</option>
								</select></td>
								<%
							}
	
						}//end of mStatus
						else if(mStatus.equals("D"))
						{
							if((rs3.getString("Detained")).equals("D"))
							{
								%><td align=center>
								<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
								<option  value="N">NA</option>
								<option selected value="D">Detained</option>
								</select></td>
								<%
							}
							else
							{
								%><td align=center>
								<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
								<option selected value="N">NA</option>
								<option value="D">Detained</option>
								</select></td>
								<%
							}
		    			}
						else if(mStatus.equals("A"))
						{
							if((rs3.getString("Detained")).equals("A"))
							{
								%><td align=center>
								<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
								<option  value="N">NA</option>
								<option selected value="A">Absent</option>
								</select></td>
								<%
							}
							else
							{
								%><td align=center>
								<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
								<option selected value="N">NA</option>
								<option value="A">Absent</option>
								</select></td>
								<%
							}
					    }
						else 
						{
							%>
							<td align=center>
							<select name='<%=mName4%>' id='<%=mName4%>' onchange="return		detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
							<option selected value="N">NA</option>
							<option value="A">Absent</option>
							</select>
							</td>
							<%
    					}
						//******************************************************************
						%>
						<td align=center><input tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>'  style="WIDTH: 50px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>,<%=mName7%>,<%=mName8%>);"  onChange="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>,<%=mName7%>,<%=mName8%>);"><%=x%></td>		
						<%
				}//end of rs3.getString("Detained");
				else
				{		
					if(mMOP.equals("P"))
						mvalue=gb.getRound((rs3.getDouble("MARKSAWARDED1")*100)/mMaxmarks,2);
					else
						mvalue=rs3.getDouble("MARKSAWARDED1");
					if(mvalue<0)
						mmvalue="";
					else
						mmvalue=String.valueOf(mvalue);
	
					if(mStatus.equals("B"))
					{
						%><td align=center>
						<select name='<%=mName4%>' id='<%=mName4%>' onchange="return	detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
						<option selected value="N">NA</option>
						<option value="A">Absent</option>
						<option value="D">Detained</option>
						</select></td>
						<%
					}
					else if(mStatus.equals("D"))
					{
						%><td align=center>
						<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
						<option selected value="N">NA</option>
						<option value="D">Detained</option>
						</select></td>
						<%
					}
					else
					{
						%><td align=center>
						<select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
						<option selected value="N">NA</option>
						<option value="A">Absent</option>
						</select></td>
						<%
					}
					%>
					<td align=center><input tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>' value='<%=mmvalue%>' style="WIDTH: 50px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>,<%=mName7%>,<%=mName8%>);"  onChange="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>,<%=mName7%>,<%=mName8%>);" ><%=x%></td>
					<%   
 				  }//endof Else
				if(rs3.getString("OLDDETAINED").equals("D") || rs3.getString("OLDDETAINED").equals("A"))
				mchkmarks=-1;
					else if(mMOP.equals("P"))
				mchkmarks=gb.getRound((rs3.getDouble("OLDMARKSAWARDED")*100)/mMaxmarks,2);
				else
					mchkmarks=rs3.getDouble("OLDMARKSAWARDED");
				%>	
				<input type=hidden name='<%=mName1%>' id='<%=mName1%>' value="<%=rs1.getString("semester")%>">
				<input type=hidden name='<%=mName2%>' id='<%=mName2%>' value="<%=rs1.getString("studentid")%>">	
			   	<input type=hidden name='<%=mName5%>' id='<%=mName5%>' value="<%=rs1.getString("fstid")%>">
				<input type=hidden name='<%=mName7%>' id='<%=mName7%>' value="<%=rs3.getString("OLDDETAINED")%>">
				<input type=hidden name='<%=mName8%>' id='<%=mName8%>' value="<%=mchkmarks%>">
				<%	 
		     }//end of rs3.next()
				%>
				<td>&nbsp; <%=rs1.getString("programcode")%>&nbsp;(<%=rs1.getString("SECTIONBRANCH")%>)</td>
				<td><%=rs1.getString("semester")%></td>
				</tr>
				<%
		 }//end of While
		if(ctr>0)
		{
		%>
		<tr><td colspan=7 align=center>
		<input type="submit" tabindex="<%=tabctrtxt%>" Value="Save Second Level Marks Entry"></td></tr>
		<%
		}//end of rs1.next()
		else
		{
			
		}
}
else
{
	%>
	<table align=center border=1 cellspacing=0 cellpadding=0>
	
	<%
	while(rs.next())
	{
	%>
	<tr>	
		<td><font size=2 face='Arial'><strong><%=rs.getString("EMPLOYEENAME")%> (<%=rs.getString("EMPLOYEECODE")%>) </strong></font></td>
		<td><font size=2 face='Arial'><strong><%=rs.getString("SUBJECT")%> : <%=rs.getString("SECTIONBRANCH")%>-<%=rs.getString("SUBSECTIONCODE")%></strong></font></td>
	</tr>
	<%
	}
	%>
	<tr>
	<td colspan=2>
		<font size=2 face='Arial' color='red'><strong>Above Faculty has not properly Locked Marks Entry Level-I  !</strong></font>	
	</td>
	</tr>
	</table>
	<%
}
}
	catch(Exception e)
	{
		//out.print("error"+qry);
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


%>
