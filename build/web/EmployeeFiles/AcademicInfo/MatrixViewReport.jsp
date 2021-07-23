<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<%
String mHead="";
String qrymass="";
double mNETTAMARKS=0;
ResultSet rsmass=null;
String qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",xDetained="",qry7="";
ResultSet rs1=null, rs2=null,rs3=null,rs4=null,rs5=null,rs6=null ,rs7=null ;
int ii=0,v=0,minQuartermarks=0,nCount=0,m=0;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>####[Quarter Matrix Report ] </TITLE>


<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>


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
		var v1=DataEvent.options[i].value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		ec=v1.substring(0,pos);
		ev=v1.substring(pos+3,len);
		if (ec==Exam)
		 { 	
			var optn = document.createElement("OPTION");
			optn.text=DataEvent.options[i].text;
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
			var v1s=DataCombo.options[i].value;
			lens= v1s.length ;	
			pos1=v1s.indexOf('***');
			pos2=v1s.indexOf('///')
			exams=v1s.substring(0,pos1);
			evs=v1s.substring(pos1+3,pos2);
			sc=v1s.substring(pos2+3,lens);

		if (exams==Exam && QryEvent==evs)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataCombo.options[i].text;
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
			var v1s1=DataCombo.options[i].value;
			
			lens1= v1s1.length ;
			pos11=v1s1.indexOf('***');
			pos21=v1s1.indexOf('///');
			exams1=v1s1.substring(0,pos11);
			evs1=v1s1.substring(pos11+3,pos21);
			sc1=v1s1.substring(pos21+3,lens1);
			if (exams1==Exam && QryEvent==evs1)
	    	 {	
				var optns1 = document.createElement("OPTION");
				optns1.text=DataCombo.options[i].text;
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

<CENTER><div align="center" style="width: 415px; height: 20px;  padding:0px;" id="status"><BR><div id="prcnt" align="center" style="height:18px;width:30px;overflow:hidden; position:middle; align:center"><BR></div><IMG  align="center" SRC="ajax-loader.gif" WIDTH="192" HEIGHT="9" BORDER="0" ALT=""></div> </CENTER>	 
<% 
//call my fist stuff 
out.println("<script>updatePercent(" + 30 + ")</script>\n"); 
out.flush(); 
// the second part 
out.println("<script>updatePercent(" + 30 + ")</script>\n"); 
out.flush(); 
// the fthird parth 
out.println("<script>updatePercent(" + 30 + ")</script>\n"); 
out.flush(); 
//done 
%> 
<script> 
document.getElementById("status").style.display = "none"; 
</script> 

<!-- <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 > -->
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",mComp="", mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="",msubj="";
String qry="",x="",QryEventSubevent="";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0,mchkmarks=0;
String mmvalue="";
int ctr=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent=""; //,mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rse=null,rsm=null,rsi=null;
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

	qry="Select WEBKIOSK.ShowLink('61','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk1= db.getRowset(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
  //----------------------
%>
	<form name="frm" method=get>
	<input id="x" name="x" type=hidden>
	<table ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" size=4 face=verdana >Subject Quarter Matrix Report</font></td></tr>
	</table>
	<table cellpadding=2 cellspacing=2 align=center rules=groups border=1>
	<!-- <tr><td>&nbsp; <font color=Green face=arial size=2><STRONG><%=mMemberName%> [<%=mDMemberCode%>]
	&nbsp;: &nbsp; &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; [<%=GlobalFunctions.toTtitleCase(mDept)%>] -->

	<!--Institute****-->

	</td></tr>
	<tr><td>
<!--*********Exam**********-->
	<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; Exam Code:</STRONG></FONT></FONT>
<%  
	try
	{
		qry=" Select GRADEENTRYEXAMID from (";
		qry+=" Select distinct nvl(EXAMCODE,' ') GRADEENTRYEXAMID , EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(lockexam,'N')='N' AND nvl(Deactive,'N')='N' ";
		//qry+=" ";
      		qry+=" order by EXAMPERIODFROM DESC";
		qry+=")  "; 
		rs=db.getRowset(qry);
		//out.print(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);" onChange="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);">	
			<OPTION selected Value ="">--Select--</option>
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
			<OPTION selected Value ="">--Select--</option>
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
	qry="select distinct A.EVENTSUBEVENT EVENTSUBEVENT, A.ExamCode ExamCode from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"'  and nvl(A.PUBLISHED,'N')='Y' order by ExamCode ";
	rse=db.getRowset(qry);
	//out.print(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=DataEvent tabindex="0" id="DataEvent" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
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
		<select name=DataEvent tabindex="0" id="DataEvent" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
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
	&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent:</STRONG></FONT></FONT>
	<%
	try
	{
	//out.print(mExamid+" ffffffffffff "+QryExam);

	if (request.getParameter("x")==null) 
	{

	qry="select distinct A.EVENTSUBEVENT from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"' and nvl(A.PUBLISHED,'N')='Y' order by eventsubevent";
	}
	else
		{
		qry="select distinct A.EVENTSUBEVENT from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"' and a.examcode='"+QryExam+"' and  nvl(A.PUBLISHED,'N')='Y' order by eventsubevent";

		}

	rse=db.getRowset(qry);
	/// out.print(qry);
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
	qry="select distinct A.programcode ||' ( '||A.programcode||' )' subject,A.programcode programcode,A.examcode examcode ,A.eventsubevent eventsubevent from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"'  and nvl(A.PUBLISHED,'N')='Y' ";
	qry+=" GROUP BY A.programcode ||' ( '||A.programcode||' )',A.programcode,A.examcode,A.eventsubevent order by examcode, eventsubevent ";
	//out.print(qry);
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		//out.print("***********1****************");
		%>
		<select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
		<%   
		while(rss.next())
		{

			mSubj1=rss.getString("examcode")+"***"+rss.getString("eventsubevent").toString().trim()+"///"+rss.getString("programcode");
			
			if(msubj.equals(""))
 			msubj=mSubj1;
			%>
			<OPTION Value ="<%=mSubj1%>"><%=rss.getString("subject")%></option> 
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		//System.out.println("***********2****************");
		%>	
		<select name="DataCombo" tabindex="0" id="DataCombo" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
		<%
	//System.out.println("***********2**2* 2*************");
		while(rss.next())
		{
			//System.out.println("***********2**2**************");
		mSubj1=rss.getString("examcode")+"***"+rss.getString("eventsubevent").toString().trim()+"///"+rss.getString("programcode");
//System.out.println(mSubj1+"***********pp**pp*************"+request.getParameter("DataCombo"));
			if(mSubj1.equals(request.getParameter("DataCombo").toString().trim()))
 			{

				//System.out.println("***********77**77*************");
				msubj=mSubj1;
				//System.out.println("***********88**88*************");
				%>
				 <OPTION selected Value ="<%=mSubj1%>"><%=rss.getString("subject")%></option> 
				<%			
		     	}
		     	else
		      {

					//System.out.println("*****xxxxxx****####################*********");
				%>
			     	 <OPTION  Value ="<%=mSubj1%>"><%=rss.getString("subject")%></option> 
		      	<%
					
		//System.out.println("*****yyyyyy****yyyyy*********");

		   	}
			//System.out.println("*****zzzzz****zzzzzzzzzz*********");
		}
		//System.out.println("*****cccccccccc****cccccccccc*********");
		%>
		</select>
	  	<%
				//System.out.println("*****bbbbb****bbbb*********");
	 }
 }    
catch(Exception e)
	
{
	//System.out.print("****"+e);
}
%>
<tr><td>
<!--SUBJECT**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; Program :&nbsp;&nbsp;&nbsp;&nbsp;</STRONG></FONT></FONT>
<%
	//System.out.println("*****bbbbb****bbbb*********");

	try
	{
//System.out.println("*****bbbbb222****bbbb2222*********");

	//out.print("***********3****************");
	qry="select distinct A.programcode ||' ( '||A.programcode||' )' subject, A.programcode programcode from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"' and nvl(PUBLISHED,'N')='Y' and eventsubevent='"+QryEventSubevent+"' and examcode='"+QryExam+"' ";
	qry=qry+" GROUP BY A.programcode ||' ( '||A.programcode||' )',A.programcode ";
	qry=qry+" order by subject";
	//System.out.println(qry+"************");
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		//System.out.print("***********4***************");
		%>
		<select name="Subject" tabindex="0" id="Subject"  style="WIDTH: 150px">	
		<%   
		while(rss.next())
		{
			mSubj=rss.getString("programcode").toString().trim();
			if(msubj1.equals(""))
 			msubj1=mSubj;
			%>
			<OPTION selected Value="<%=mSubj%>"><%=rss.getString("subject")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		
		//System.out.print("***********5****************");
		%>	
		<select name="Subject" tabindex="0" id="Subject" style="WIDTH: 150px">	
		<%
		while(rss.next())
		{
			mSubj=rss.getString("programcode").toString().trim();
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj1=mSubj;
				%>
				<OPTION selected Value ="<%=mSubj%>"><%=rss.getString("subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSubj%>"><%=rss.getString("subject")%></option>
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

//System.out.print("***********6*6*6*6*6*6*6*6**6*6*66*6*6*6*6*");

	%>
	&nbsp; &nbsp; &nbsp;&nbsp;<INPUT Type="submit" Value="Show/Refresh">&nbsp;&nbsp;
	</td></tr>
	</table></form>
	<%	
		//System.out.print("***********6****************");
		if(request.getParameter("x")!=null)
		{

			//System.out.print("***********7****************");
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
		
//System.out.print(mEC+"*****"+mSC+"****"+mEvent+"*****"+mInst);


String xTotalStud="";

%>
<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='90%' bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
                <thead>
                    <tr bgcolor="#ff8c00">
                        <td   Title="Sort on SlNo"><font color="White"><b>SR.<br>NO.</b></font></td>
                        <td   Title="Sort on Enrollment No" nowrap><font color="White"><b>SUBJECT</b></font></td>
                        <td  Title="Class Student Name"><font color="White"><b>STUDENT COUNT</b></font></td>
                        <td  Title="Sort on Section/Subsection"><font color="White"><b>DETAINED<br>(A/D/M/U)</b></font></td>
                       
                        <td   Title="Student % Attendance" align="center" nowrap><font color="White"><b>MAX MARKS</b></font></td>

						  <td   Title="Student % Attendance" align="center" nowrap><font color="White"><b>MIN MARKS</b></font></td>
						    <td  Title="Student % Attendance" align="center" nowrap><font color="White"><b>AVG MARKS</b></font></td>
							  <td  Title="Student % Attendance" align="center" nowrap><font color="White"><b>STD DEVIATION</b></font></td>
							    <td  Title="Student % Attendance" align="center" nowrap><font color="White"><b>&nbsp;&nbsp;&nbsp;1<sup>st</sup> QUARTER&nbsp;&nbsp;&nbsp;</b></font></td>



<td   Title="Student % Attendance" align="center" nowrap><font color="White"><b>&nbsp;&nbsp;&nbsp;2<sup>nd</sup> QUARTER&nbsp;&nbsp;&nbsp;</b></font></td>

<td   Title="Student % Attendance" align="center" nowrap><font color="White"><b>&nbsp;&nbsp;&nbsp;3<sup>rd</sup> QUARTER&nbsp;&nbsp;&nbsp;</b></font></td>
<td   Title="Student % Attendance" align="center" nowrap><font color="White"><b>&nbsp;&nbsp;&nbsp;4<sup>th</sup> QUARTER&nbsp;&nbsp;&nbsp;</b></font></td>
                    </tr>

<%
qry1="select count(distinct studentid)totalstud,SUBJECT,subjectid from v#studenteventsubjectmarks where institutecode='"+mInst+"' and EXAMCODE='"+mEC+"' and  PROGRAMCODE='"+mSC+"' and  EVENTSUBEVENT='"+mEvent+"' group by SUBJECT,subjectid order by  subject ";
//System.out.println(qry1);
	rs1=db.getRowset(qry1);


while(rs1.next())
		{
	nCount++;

	xTotalStud=rs1.getString("totalstud");
%>
<tr><td><%=nCount%></td><td><%=rs1.getString("SUBJECT")%></td><td><%=xTotalStud%></td>
<%


qry2="select count(distinct studentid)detained,SUBJECT  from v#studenteventsubjectmarks where institutecode='"+mInst+"' and EXAMCODE='"+mEC+"' and PROGRAMCODE='"+mSC+"' and subjectid='"+rs1.getString("subjectid")+"'  and  EVENTSUBEVENT='"+mEvent+"' and  NVL (DETAINED, 'N') <> 'N'  group by SUBJECT order by subject";

rs2=db.getRowset(qry2);
//System.out.println(qry2);


if(rs2.next()){

xDetained=rs2.getString("detained");
%>
 <td><%=xDetained%></td>
<%

}else{
%>
<td>0</td>
<%
}



qry3="select subjectid, min(MARKSAWARDED1)minmarks ,max(MARKSAWARDED1)maxmarks,count(distinct studentid)NOOFSTUD ,round(nvl(sum(MARKSAWARDED1)/count(distinct studentid) ,'0'),2)AVGMARKS,SUBJECT from v#studenteventsubjectmarks where institutecode='"+mInst+"' and EXAMCODE='"+mEC+"' and PROGRAMCODE='"+mSC+"' and  EVENTSUBEVENT='"+mEvent+"' and subjectid='"+rs1.getString("subjectid")+"'  group by SUBJECT,subjectid order by subject ";
rs3=db.getRowset(qry3);
//System.out.println(qry3);


if(rs3.next()){

%>
 <td><%=rs3.getDouble("maxmarks")%></td><td><%=rs3.getDouble("minmarks")%></td><td><%=rs3.getDouble("AVGMARKS")%></td>
<%
}else{
%>
<td>0</td><td>0</td><td>0</td>
<%
}
//System.out.println("######################################");

qry4=" select round(avg(DEVIATION),2)SubjectDaviation,subjectid from gradecalculation where institutecode='"+mInst+"' and  EXAMCODE='"+mEC+"' and subjectid='"+rs1.getString("subjectid")+"' group by subjectid   ";
//System.out.println(qry4);
rs4=db.getRowset(qry4);



if(rs4.next()){

%>
 <td><%=rs4.getDouble("SubjectDaviation")%></td>
<%
}else{
%>
<td>0</td>
<%
}



/*qry5="  select studentid,nvl(MARKSAWARDED1,0)marks from v#studenteventsubjectmarks where  institutecode='"+mInst+"' and EXAMCODE='"+mEC+"' and PROGRAMCODE='"+mSC+"'  and  EVENTSUBEVENT='"+mEvent+"' and nvl(detained,'N')='N' and subjectid='"+rs1.getString("subjectid")+"' order by marks desc ";

rs5=db.getRowset(qry5);


if(rs5.next()){
 
}
*/

v=0;
	for( ii=1; ii<=4; ii++)
			{
qry6="select count(studentid) -'"+v+"' Coutquater ,min(marks)Minquater from ( ";
    qry6 = qry6 + " select studentid,nvl(MARKSAWARDED1,0)marks from v#studenteventsubjectmarks ";
   qry6 = qry6 + " where  institutecode='"+mInst+"' and EXAMCODE='"+mEC+"' and PROGRAMCODE='"+mSC+"' ";
   qry6 = qry6 + " and  EVENTSUBEVENT='"+mEvent+"' and nvl(detained,'N')='N' and subjectid='"+rs1.getString("subjectid")+"' ";
   qry6 = qry6 + " and  MARKSAWARDED1  IN (";
   qry6 = qry6 + " select marks from ( ";
    qry6 = qry6 + " select studentid,nvl(MARKSAWARDED1,0)marks from v#studenteventsubjectmarks  ";
   qry6 = qry6 + " where institutecode='"+mInst+"' and EXAMCODE='"+mEC+"' and PROGRAMCODE='"+mSC+"'  ";
   qry6 = qry6 + " and  EVENTSUBEVENT='"+mEvent+"' and nvl(detained,'N')='N' and subjectid='"+rs1.getString("subjectid")+"'  ";
    qry6 = qry6 + " order by marks desc) where rownum < =   ";
     qry6 = qry6 + " (select ceil(count(studentid )/4) + '"+v+"' count from v#studenteventsubjectmarks ";
   qry6 = qry6 + " where institutecode='"+mInst+"' and EXAMCODE='"+mEC+"' and PROGRAMCODE='"+mSC+"' ";
   qry6 = qry6 + " and  EVENTSUBEVENT='"+mEvent+"' and nvl(detained,'N')='N' and subjectid='"+rs1.getString("subjectid")+"')";
   qry6 = qry6 + "  ) order by marks desc) ";
//System.out.println(qry6);
rs6=db.getRowset(qry6);
if(rs6.next()){

m=v;
v=v+rs6.getInt("Coutquater");
 




%>
 <td>Student Count:&nbsp;&nbsp;<B><%=rs6.getInt("Coutquater")%></B>&nbsp;<BR>Min. Marks:&nbsp;&nbsp;<B><%=rs6.getDouble("Minquater")%></B><BR>
<%}else{
%>
<td>0</td>
<%
}

qry7="select MARKS MAXMARKS    from ( select a.*, rownum rnum      from ( select studentid,nvl(MARKSAWARDED1,0)marks from v#studenteventsubjectmarks  where  institutecode='"+mInst+"' and EXAMCODE='"+mEC+"' and PROGRAMCODE='"+mSC+"'  and  EVENTSUBEVENT='"+mEvent+"' and nvl(detained,'N')='N' and subjectid='"+rs1.getString("subjectid")+"'  order by marks desc  ) a           where rownum <= '"+m+"' +1 )  where rnum >= '"+m+"' +1";
rs7=db.getRowset(qry7);
if(rs7.next()){
%>&nbsp;Max.Marks:&nbsp;&nbsp;<B><%=rs7.getDouble("MAXMARKS")%></B></td><%
}else{
%>&nbsp;Max.Marks:&nbsp;&nbsp;<B>0</td><%
}


		}



}%>

</tr></table>
<%









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