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
String mL="",mT="",mP="",mCurPRCode="";
int kk1=0,mkk1;
String qry="", qry1="", qry2="";
String mFINALIZED="",mFacultyID="";
String mPreEvent="",mInst1="";
String mMemberID="",mFSTID="",mLTP="";
String mMemberType="";
String mDMemberType="",mFaultyType ="",msg="";
String mMemberCode="", mFaculty="", mFacCode="", mEvent="",mFacid="";
String mDMemberCode="",mexam="",mSubject="",mFac="";
String mMemberName="",mExamcode="";
String mInst="";

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

	if (request.getParameter("institute").toString().trim()==null)
	{
		mInst="";
	}
	else
	{
		mInst=request.getParameter("institute").toString().trim();
	}
	if (request.getParameter("Exam").toString().trim()==null)
	{
		mExamcode="";
	}
	else
	{	
		mExamcode=request.getParameter("Exam").toString().trim();
	}

	if (request.getParameter("FaultyType").toString().trim()==null)
	{
		mFaultyType ="";
	}
	else
	{	
		mFaultyType =request.getParameter("FaultyType").toString().trim();
	}
	
if (request.getParameter("FacultyID").toString().trim()==null)
	{
		mFacultyID="";
	}
	else
	{	
		mFacultyID=request.getParameter("FacultyID").toString().trim();
	}
if (request.getParameter("PreEvent").toString().trim()==null)
	{
		mPreEvent="";
	}
	else
	{	
		mPreEvent=request.getParameter("PreEvent").toString().trim();
	}


	//out.print(mPreEvent);
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		mHead=session.getAttribute("PageHeading").toString().trim();
	else
		mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Teaching Load Modify]</TITLE>
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
	qry="Select WEBKIOSK.ShowLink('50','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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

<br><br><table cellpadding=2 cellspacing=0  rules=groups width=80% border=0>
<FONT color=green><FONT face=Arial size=3><STRONG> Preference of Subject/Time has been Successfully sent to HOD.....</STRONG></FONT></FONT></table><br>
		
		<input type=hidden name="INST" id="INST" value="<%=mInst%>">
            <input type=hidden name="Examcode" id="Examcode" value="<%=mExamcode%>">
            <input type=hidden name="Facultytype" id="Facultytype" value="<%=mFaultyType%>">
            <input type=hidden name="PreEvent" id="PreEvent" value="<%=mPreEvent%>">

<table cellspacing=0 cellpadding=0 width=100% border=1 align=center>

<tr bgcolor='#e68a06'>
 <td><b><font color="#00008b">SNo.</font></td>
 <td><b><font color="#00008b">Subject</font></td>
 <td><b><font color="#00008b">Elective Code</font></td>
 <td><b><font color="#00008b">Lecture</font></td>
 <td><b><font color="#00008b">Tutorial</font></td>
 <td><b><font color="#00008b">Practical</font></td>
 <td nowrap><b><font color="#00008b">Status</font></td>

</tr>
 <%
		
	try
	{
	qry="Update PREVENTS set SENDTOHOD='Y',SENTBY='"+mFacultyID+"',SENTDATE=sysdate";
     	qry=qry +" where institutecode='"+mInst+"' and PREVENTCODE='"+mPreEvent+"'and MEMBERID='"+mFacultyID+"'and MEMBERTYPE='"+mChkMType+"'";
	int n=db.update(qry);
		if(n>0)
				{
					
				// Log Entry
				//-----------------
			    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Subject Choices Send To HOD", "ExamCode: "+mExamcode,"NO MAC Address",mIPAddress);
	
	//-----------------
				
}


qry="select nvl(SENDTOHOD,' ') SENDTOHOD  from PREVENTS where PREVENTCODE='"+mPreEvent+"'and MEMBERTYPE='"+mChkMType+"' and MEMBERID='"+mChkMemID+"'";
	rs=db.getRowset(qry);
while(rs.next())
{
mFINALIZED=rs.getString("SENDTOHOD");
}

	qry="select A.SUBJECTCODE, A.LTP, decode(A.LTP,'L',1,'T',2,3) LTPORD , B.subject,decode(A.SUBJECTTYPE,'E',A.ELECTIVECODE,'C','Core','Free Elective')  ELECTIVECODE from PR#FACULTYSUBJECTCHOICES A,subjectmaster B where A.institutecode='"+mInst+"' and A.examcode='"+mExamcode+"' ";
	qry=qry+" and A.facultytype='"+mFaultyType+"' and A.facultyid='"+mChkMemID+"'";
	qry=qry+" and A.subjectcode=B.subjectcode group by A.SUBJECTCODE, A.LTP, decode(A.LTP,'L',1,'T',2,3),B.subject,decode(A.SUBJECTTYPE,'E',A.ELECTIVECODE,'C','Core','Free Elective') ";
	qry=qry+"  ORDER BY B.SUBJECT,LTPORD,A.LTP ";
	//out.print(qry);
	rs1=db.getRowset(qry);
	mL="";
	String mOldSubj="",mOldSubjCD="";
	while(rs1.next()) 
	  {  	 
		 if(mOldSubj.equals("")||!mOldSubj.equals(rs1.getString("SUBJECT")))
		  {
			kk1++;
			if(!mOldSubj.equals(""))
			  {
					
					if(mL.equals("L"))
					  {
					 %>
			      		<td><input id='nm1' Checked type=checkbox name='nm1' disabled <%=mL%>>
							<br>
						</td>
					 <%	
					  }
					  else
					  {
					  %>
						<td><input id='nm1' type=checkbox name='nm1' disabled <%=mL%>><br></td>
					  <%
					   }
					 
					 if(mT.equals("T"))
					  {
					 %>
			      		<td><input id='nm1' Checked type=checkbox name='nm1' disabled <%=mL%>>
						<br></td>
					 <%	
					  }
					  else
					  {
					  %>
						<td><input id='nm1' type=checkbox name='nm1' disabled <%=mL%>><br></td>
					  <%
					   }
					
			  
					if(mP.equals("P"))
					  {
					 %>
			      		<td><input id='nm1' Checked type=checkbox name='nm1' disabled <%=mL%>>
						<br>
						</td>
					 <%	
					  }
					  else
					  {
					  %>
						<td><input id='nm1' type=checkbox name='nm1' disabled <%=mL%>><br></td>
					  <%
					   }
				if(mFINALIZED.equals("Y"))
				msg="Sent";
					else
				msg="Not Sent";
					%>
				<td><%=msg%></td>
				</tr>
				<%
			  }			
			mOldSubj=rs1.getString("SUBJECT");
			mOldSubjCD=rs1.getString("SUBJECTCODE");
			mL="";
			mP="";
			mT="";
			%>	
			<tr>
			<td><%=kk1%></td>
			<td nowrap><%=rs1.getString("subject")%>(<%=rs1.getString("subjectcode")%>)</td>
			<td nowrap><%=rs1.getString("ELECTIVECODE")%></td>

		      <%
		  }
	
			if(rs1.getString("LTP").equals("L"))
				mL="L";
			else if(rs1.getString("LTP").equals("T"))
				mT="T";
			else if(rs1.getString("LTP").equals("P"))
				mP="P";


	  } //closing of while


			if(!mOldSubj.equals(""))
			  {
					
					if(mL.equals("L"))
					  {
					 %>
			      		<td><input id='nm1' Checked type=checkbox name='nm1' disabled <%=mL%>>
						<br>
						</td>
					 <%	
					  }
					  else
					  {
					  %>
						<td><input id='nm1' type=checkbox name='nm1' disabled <%=mL%>>
						<br></td>
					  <%
					   }
					 
					 if(mT.equals("T"))
					  {
					 %>
			      		<td><input id='nm1' Checked type=checkbox name='nm1' disabled <%=mL%>>
						<br>
						</td>
					 <%	
					  }
					  else
					  {
					  %>
						<td><input id='nm1' type=checkbox name='nm1' disabled <%=mL%>>
						<br></td>
					  <%
					   }
					
			  
					if(mP.equals("P"))
					  {
					 %>
			      		<td><input id='nm1' Checked type=checkbox name='nm1' disabled <%=mL%>>
						<br>
						</td>
					 <%	
					  }
					  else
					  {
					  %>
						<td><input id='nm1' type=checkbox name='nm1' disabled <%=mL%>>
						<br></td>
					  <%
					   }
					if(mFINALIZED.equals("Y"))
				msg="Sent";
					else
				msg="Not Sent";
					%>
			<td nowrap><%=msg%></td></tr>
				<%

			  }			

   } //closing of try

	catch(Exception e)
	{
	
	}
	
%>
	</table></form>	
		
	<%						
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
</body>
</html>

