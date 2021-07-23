<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<%

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";

%>
<html>
<head>
   <TITLE>#### <%=mHead%> [Marks Entry by Dean of Academic Affairs (DOAA)]</TITLE>
   <script language="JavaScript" type ="text/javascript">
      <!-- 
  	  if (top != self) top.document.title = document.title;
      -->
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
	if(objchk.checked==true)
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
			objchk.checked=false;
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="",msubj="";
String qry="",qry1="",x="",msubsection="";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0;
int len=0;
int pos=0;
int ctr=0;
int pos1=0;
double mchkmarks=0;
String mName6="",mName7="",mName8="";
String mSubjectcode="",mEmployeecode="",mFacultytype="";
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent=""; //,mExamsubevent="",mExamevent="";

ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null;

String mMOP="",mName5="",mlistorder="",mctr="";		
	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="";
			
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

	qry="Select WEBKIOSK.ShowLink('64','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk1= db.getRowset(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	   {
  //----------------------




%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Event/Sub Event Marks Entry(By DOAA)</TD>
	</font></td></tr>
	</TABLE>

	<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
	<tr><td><font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]
	&nbsp;&nbsp; : &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (
	<%=GlobalFunctions.toTtitleCase(mDept)%>)
	</td></tr>

	<!--Institute****-->

	<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
<%  
	try
	{ 
	qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=InstCode tabindex="0" id="InstCode" style="WIDTH: 80px">	
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
		<select name=InstCode tabindex="0" id="InstCode" style="WIDTH: 80px">	
		<%
		while(rs.next())
		{
			mInst=rs.getString("InstCode");
			if(mInst.equals(request.getParameter("InstCode").toString().trim()))
 			{
			minst=mInst;
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

&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Exam.code</STRONG></FONT></FONT>
<%  
	try
	{
		qry="select distinct NVL(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID FROM DEFAULTVALUES  "; 
		rs=db.getRowset(qry);
		//out.print(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px">	
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
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px">	
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
<%    try{
	
	qry="select distinct EVENTSUBEVENT from V#STUDENTEVENTSUBJECTMARKS where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+" Employeeid in (select Employeeid ";
	qry=qry+" from V#STUDENTEVENTSUBJECTMARKS where nvl(published,'N')='Y' and nvl(Locked,'N')='Y') and nvl(deactive,'N')='N' AND LTP='L') ";  
	qry=qry+"  and nvl(PUBLISHED,'N')='Y' ";
//out.print(qry);
	rse=db.getRowset(qry);
	
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Event tabindex="0" id="Event" style="WIDTH: 156px">	
		<%   
		while(rse.next())
		{
			mEventsubevent=rse.getString("EVENTSUBEVENT");
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
		<select name=Event tabindex="0" id="Event" style="WIDTH: 156px">	
		<%
		while(rse.next())
		{
			mEventsubevent=rse.getString("EVENTSUBEVENT");
			if(mEventsubevent.equals(request.getParameter("Event").toString().trim()))
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

	}
	catch(Exception e)
	{
		//out.print("error");
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


	qry="select distinct subject||' ( '||subjectcode||' )'|| employeename subject,subjectcode,employeeid,facultytype from V#STUDENTEVENTSUBJECTMARKS where ";
	qry=qry+"  (fstid) in (select "; 
	qry=qry+" fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+" Employeeid in (select Employeeid ";
	qry=qry+" from  V#STUDENTEVENTSUBJECTMARKS WHERE  nvl(PUBLISHED,'N')='Y' AND NVL(LOCKED,'N')='Y') ) ";  
	qry=qry+"  and nvl(PUBLISHED,'N')='Y' ";

	//out.print(qry);
	rss=db.getRowset(qry);
	
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 490px">	
		<%   
		while(rss.next())
		{

			mSubj=rss.getString("SubjectCode")+"***"+rss.getString("employeeid")+"///"+rss.getString("facultytype");
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
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 490px">	
		<%
		while(rss.next())
		{
			mSubj=rss.getString("SubjectCode")+"***"+rss.getString("employeeid")+"///"+rss.getString("facultytype");
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
%></td></tr>
<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>List order in:</STRONG></FONT></FONT>
<select name=listorder tabindex="0" id="listorder" style="WIDTH: 120px">
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
<select name=order tabindex="0" id="order" style="WIDTH: 95px">	

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
&nbsp;&nbsp;&nbsp;&nbsp;

<INPUT Type="submit" Value="Show/Refresh">&nbsp;&nbsp;&nbsp;
		</td></tr>
		</table></form>
	<%	
		if(request.getParameter("x")!=null)
		{
			if( request.getParameter("Subject")!=null && request.getParameter("Event")!=null && request.getParameter("Exam")!=null)
			{
		mIC=request.getParameter("InstCode").toString().trim();
		mEC=request.getParameter("Exam").toString().trim();
		mSubjectcode=request.getParameter("Subject").toString().trim();
	
		len=mSubjectcode.length();
		pos=mSubjectcode.indexOf("***");
		pos1=mSubjectcode.indexOf("///");
		mSC=mSubjectcode.substring(0,pos);
		mEmployeecode=mSubjectcode.substring(pos+3,pos1);
		mFacultytype=mSubjectcode.substring(pos1+3,len);
	
		mList=request.getParameter("listorder").toString().trim();
		mOrder=request.getParameter("order").toString().trim();
		mEvent=request.getParameter("Event").toString().trim();		
		qry="select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
 		qry=qry+" where institutecode='"+mIC+"' and ";
		qry=qry+" examcode='"+mEC+"' and employeeid='"+mEmployeecode+"' and facultytype='"+mFacultytype+"' and ltp='L' and subjectcode='"+mSC+"' ";
		rsm=db.getRowset(qry);
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
			&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Marks
			&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:</STRONG></FONT><%=mMaxmarks%>
		<%
			}
			else
			{
		%>
			&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Percentage
		&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:&nbsp;</STRONG></FONT><%=mMaxmarks%>

		<%
		}

	%>	
		<table cellspacing=0 cellpadding=0 width=98% border=1 align=center>
		<form name="frm1"  method="post" action="MarksEntryDOAAAction.jsp">
		<tr bgcolor="#c00000">
		<td><b><font color=white>SNo.</font></b></td>
		<td><b><font color=white>Enroll. No</font></b></td>
		<td><b><font color=white>Student name</font></b></td>
		<td><b><font color=white>Detained/any other<br>unfair means</font></b></td>
		<td><b><font color=white>Marks</font></b></td>
		<td><b><font color=white>Course (Section<br>Branch)<font></b></td>
		<td><b><font color=white>Sem.<font></b></td>
		</tr>	
	<%
		
	
	
try{
qry="select distinct fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester,subsectioncode, ";
qry=qry+ "nvl(programcode,' ')programcode,nvl(SECTIONBRANCH,' ')SECTIONBRANCH from V#STUDENTEVENTSUBJECTMARKS ";
qry=qry+" where institutecode='"+mIC+"' and nvl(locked,'N')='Y' and nvl(PUBLISHED,'N')='Y' and ";
qry=qry+" examcode='"+mEC+"' and employeeid='"+mEmployeecode+"' and facultytype='"+mFacultytype+"' and ltp='L' and subjectcode='"+mSC+"' ";
qry=qry+" order by "+mList+ " "+mOrder+ " ,enrollmentno " ;

rs1=db.getRowset(qry);
msno=0;
ctr=0;
while(rs1.next())
{	ctr++;
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
		qry="Select nvl(MARKSAWARDED2,-1)MARKSAWARDED1,nvl(MARKSAWARDED1,-1)OLDMARKSAWARDED, ";
		qry=qry+" nvl(DETAINED2,'N') DETAINED ,NVL(DETAINED,'N') OLDDETAINED  from V#STUDENTEVENTSUBJECTMARKS ";
		qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		qry=qry+" EVENTSUBEVENT='"+mEvent+"' and   ";
		qry=qry+" fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
		rs3=db.getRowset(qry);
		
		/*		
		qry="Select nvl(MARKSAWARDED2,-1)MARKSAWARDED1, ";
		qry=qry+" nvl(DETAINED2,'N')DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		qry=qry+" EVENTSUBEVENT='"+mEvent+"' and   ";
		qry=qry+" fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
		*/
		rs3=db.getRowset(qry);
		x="";
		if(mMOP.equals("P"))
		x="%";
		if(rs3.next())
		{	
			mName6="OLDMARKSAWARDED"+String.valueOf(ctr).trim();
			mName7="OLDDETAINED"+String.valueOf(ctr).trim();
			mName8="Chkmarks"+String.valueOf(ctr).trim();
		  if((rs3.getString("Detained")).equals("Y"))
		  {
		%>
			<td align=center><input type='checkbox' name='<%=mName4%>' id='<%=mName4%>' value='Y' checked onclick="return detained_check(<%=mName4%>,<%=mName3%>);"></td>
			<td align=center><input type=text name='<%=mName3%>' id='<%=mName3%>' value="" style="WIDTH: 40px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);" onchange="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);" ><%=x%></td>
		<%
		  }	
			else
			{	if(mMOP.equals("P"))
				mvalue=(rs3.getDouble("MARKSAWARDED1")*100)/mMaxmarks;
				else
				mvalue=rs3.getDouble("MARKSAWARDED1");
		%>	<td align=center><input type='checkbox' name='<%=mName4%>' id='<%=mName4%>' value='Y' onclick="return detained_check(<%=mName4%>,<%=mName3%>);"></td>
			<td align=center><input type=text name='<%=mName3%>' id='<%=mName3%>' value='<%=mvalue%>' style="WIDTH: 40px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);" onchange="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);"><%=x%></td>
			
		<%   
 			}
		}
		else
		{
		%>
		<td align=center><input type='checkbox' name='<%=mName4%>' id='<%=mName4%>' value='Y' onclick="return detained_check(<%=mName4%>,<%=mName3%>);"></td>
		<td align=center><input type=text name='<%=mName3%>' id='<%=mName3%>' value="" style="WIDTH: 40px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);"  onchange="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>);"><%=x%></td>
		
		<%
		}
	
		
	%>	<td><%=rs1.getString("programcode")%>&nbsp;(<%=rs1.getString("SECTIONBRANCH")%>)</td>
		<td><%=rs1.getString("semester")%></td>
		</tr>
		<input type=hidden name='<%=mName1%>' id='<%=mName1%>' value='<%=rs1.getString("semester")%>'>
		<input type=hidden name='<%=mName2%>' id='<%=mName2%>' value='<%=rs1.getString("studentid")%>'>	
		<input type=hidden name='<%=mName5%>' id='<%=mName5%>' value='<%=rs1.getString("fstid")%>'>
	<%	 
	  	if(rs3.getString("OLDDETAINED").equals("Y"))
			mchkmarks=-1;
			else if(mMOP.equals("P"))
				mchkmarks=(rs3.getDouble("OLDMARKSAWARDED")*100)/mMaxmarks;
			else
				mchkmarks=rs3.getDouble("OLDMARKSAWARDED");
%>
		<input type=hidden name='<%=mName7%>' id='<%=mName7%>' value=<%=rs3.getString("OLDDETAINED")%>>
		<input type=hidden name='<%=mName8%>' id='<%=mName8%>' value=<%=mchkmarks%>>

<%
 } 
	}
	catch(Exception e)
	{
	//	out.print("error");
	}
			
	%>
		<tr><td colspan=8 align=center>

<tr>
	<form name="frm2" id="frm2" method="post" action="MarksEntryHODAction.jsp" >
	<td colspan=7 align=center valign=top><font size=2 color="#993300" face=arial>
<!--	<b>** Countinue to delete previous grades
	<input type=checkbox name='Proceed' id='Proceed' value='Y' onclick="return showAlert();">   -->
	</font>
	<INPUT Type="submit" Value="Save Marks Entry">
	</td></tr>
		
		<input type=hidden name='institute' id='institute' value=<%=mIC%>>
		<input type=hidden name='Exam' id='Exam' value=<%=mEC%>>
		<input type=hidden name='EventSubevent' id='EventSubevent' value=<%=mEvent%>>
		<input type=hidden name='TotalCount' id='TotalCount' value=<%=ctr%>>
      	<input type=hidden name='MaxMarks' id='MaxMarks' value=<%=mMaxmarks%>>
		<input type=hidden name='subjectcode' id='subjectcode' value=<%=mSC%>>
		<input type=hidden name='Employeecode' id='Employeecode' value=<%=mEmployeecode%>>
		<input type=hidden name='Facultytype' id='Facultytype' value=<%=mFacultytype%>>
		<input type=hidden name='Marksorpercentage' id='Marksorpercentage' value=<%=mMOP%>>
</form><table>	
<p>**<font color="#cc9933" size=3> 
	Once you update the Marks of any student and click over the Save Marks Entry then student subject grade should be reexecuted,
	or calculated since marks have been changed.
	</font>

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