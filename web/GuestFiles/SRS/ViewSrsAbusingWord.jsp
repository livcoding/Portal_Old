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
<TITLE>#### <%=mHead%> [ View Abusing words related Student Reaction Survey (SRS) ] </TITLE>
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
	document.frm.x.value='ddd';
	}
	//-->
    </script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
	OLTEncryption enc=new OLTEncryption();
try
{
	DBHandler db=new DBHandler();
	ResultSet rs=null, rs1=null;
	String qry="", qry1="";

	int SNo=0;	
	String mMemberID="";
	String mMemberType="";

	String mMemberCode="";
	String mEMemberCode="";

	String mSRSEventCode="";
	String msrseventcode="";

	String mSemester="";
	String msemester="";

	String mSubject="";
	String msubject="";

	String mFaculty="";
	String mfaculty="";

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

	if(!mMemberID.equals("") && !mMemberType.equals("")) 
	{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();

	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('69','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	%>
<form name="frm">
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>View Abusing Suggestions [Admin User Only]</b></font></td></tr>
</table>
<table cellpadding=2 align=center rules=groups border=2 style="WIDTH: 100%; HEIGHT: 61px">

<!--SRSEventCode****-->
<tr><td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>SRS Event Code</STRONG></FONT>&nbsp;&nbsp; </FONT></td><td nowrap>
<%
try
{
	qry="Select Distinct nvl(SRSEventCode,' ')SRSEVENTCODE from v#SRSEVENTSUGGESTION Where nvl(ISABUSING,'N')='Y' and nvl(Deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=SRSEventCode tabindex="0" id="SRSEventCode" style="WIDTH: 120px">	
		<%   
		while(rs.next())
		{
			mSRSEventCode=rs.getString("SRSEVENTCODE");
			if(msrseventcode.equals(""))
 			msrseventcode=mSRSEventCode;
			%>
			<OPTION selected Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=SRSEventCode tabindex="0" id="SRSEventCode" style="WIDTH: 120px">	
		<%
		while(rs.next())
		{
			mSRSEventCode=rs.getString("SRSEventCode");
			if(msrseventcode.equals(request.getParameter("SRSEventCode").toString().trim()))
 			{
				msrseventcode=mSRSEventCode;
				%>
				<OPTION selected Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
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
		out.println(e.getMessage());
}
%>
</td>
<!--SUBJECT**********-->
<td nowrap><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<STRONG>Subject</STRONG></FONT>&nbsp;</FONT></td><td nowrap>
<%
try
{ 
 	qry="Select Distinct nvl(Subjectid,' ') Subjectid, Subject||' ('||SubjectCode||')' Subject from v#SRSEVENTSUGGESTION where nvl(ISABUSING,'N')='Y' and nvl(deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 320px">
		<OPTION selected Value=ALL>ALL</option>
		<%   
		while(rs.next())
		{
			mSubject=rs.getString("SubjectID");
			if(mSubject.equals(""))
 			{
			msubject=mSubject;
			%>
			<OPTION selected Value =<%=mSubject%>><%=rs.getString("Subject")%></option>
			<%			
			}
			else
			{	
			%>
			<OPTION Value =<%=mSubject%>><%=rs.getString("Subject")%></option>
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
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 320px">	
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
		while(rs.next())
		{
			mSubject=rs.getString("SubjectID");
			if(mSubject.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubject=mSubject;
				%>
				<OPTION selected Value =<%=mSubject%>><%=rs.getString("Subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubject%>><%=rs.getString("Subject")%></option>
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
	out.println(e.getMessage());
}
%>
</td></tr>
<!--SEMESTER**************-->
<tr>
<td nowrap align=left><FONT color=black><FONT face=Arial size=2><STRONG>Semester</STRONG></FONT>&nbsp; </FONT></td><td nowrap>
<%
try
{ 
	qry="Select Distinct nvl(SEMESTER,0) Semester from v#SRSEVENTSUGGESTION Where nvl(ISABUSING,'N')='Y'  and nvl(Deactive,'N')='N'";
	rs=db.getRowset(qry);
//	out.print(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Semester tabindex="0" id="Semester" style="WIDTH: 60px">	
		<OPTION selected Value=ALL>ALL</option>
		
		<%   
		while(rs.next())
		{
			mSemester=rs.getString("Semester");
			if(mSemester.equals(""))			
 			msemester=mSemester;
			%>
			<OPTION Value =<%=mSemester%>><%=rs.getString("Semester")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Semester tabindex="0" id="Semester" style="WIDTH: 60px">	
		<%
		if(request.getParameter("Semester").toString().trim().equals("ALL"))
		{
		%>
			<OPTION Value=ALL Selected>ALL</option>
		<%
		}
		else
		{
		%>
			<OPTION Value=ALL>ALL</option>
		<%
		}
		while(rs.next())
		{
			mSemester=rs.getString("Semester");
			if(mSemester.equals(request.getParameter("Semester").toString().trim()))
 			{
				msemester=mSemester;
				%>
				<OPTION selected Value =<%=mSemester%>><%=rs.getString("Semester")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSemester%>><%=rs.getString("Semester")%></option>
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
	out.println(e.getMessage());
} 
%> 
</td>
<!--Faculty***********-->
<td nowrap align=left><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<STRONG>Faculty</STRONG></FONT>&nbsp; </FONT></td><td nowrap>
<%
try
{ 
	qry="Select Distinct nvl(EMPLOYEEID,' ')EMPLOYEEID, nvl(EMPLOYEENAME,' ') EMPLOYEENAME from v#SRSEVENTSUGGESTION Where nvl(ISABUSING,'N')='Y'  and nvl(Deactive,'N')='N'";
	rs=db.getRowset(qry);
//	out.print(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 265px">	
		<OPTION selected Value=ALL>ALL</option>
		
		<%   
		while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEEID");
			if(mFaculty.equals(""))			
 			mfaculty=mFaculty;
			%>
			<OPTION Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 265px">	
		<%
		if(request.getParameter("Faculty").toString().trim().equals("ALL"))
		{
		%>
			<OPTION Value=ALL Selected>ALL</option>
		<%
		}
		else
		{
		%>
			<OPTION Value=ALL>ALL</option>
		<%
		}
		while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEEID");
			if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
 			{
				mfaculty=mFaculty;
				%>
				<OPTION selected Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
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
	out.println(e.getMessage());
} 
%> 
<INPUT Type="submit" Value="Show"></td></tr>
</table>
</form>
<table width=100% bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 >
<tr bgcolor="#ff8c00">
<td align=left valign=top><b><font color=white>SlNo.</font></b>&nbsp;</td>
<td align=left valign=top><b><font color=white>Emp.<br>Name</font></b>&nbsp;</td>
<td align=left valign=top><b><font color=white>Subj.<br>Code</font></b>&nbsp;</td>
<td align=left valign=top><b><font color=white>Abusing Suggestions</font></b>&nbsp;</td>
</tr>
<%
	String Event="";
	String Semester="";
	String Subject="";
	String Faculty="";

	if(request.getParameter("x")!=null)
	{
		if (request.getParameter("SRSEventCode")==null)
		{
			Event="";
		}
		else
		{
			Event=request.getParameter("SRSEventCode").toString().trim();
		}

		if(request.getParameter("Subject")==null)
		{
			Subject="";
		}
		else
		{
			Subject=request.getParameter("Subject").toString().trim();
		}

		if(request.getParameter("Semester")==null)
		{
			Semester="";
		}
		else
		{
			Semester=request.getParameter("Semester").toString().trim();
		}

		if(request.getParameter("Faculty")==null)
		{
			Faculty="";
		}
		else
		{
			Faculty=request.getParameter("Faculty").toString().trim();
		}
		qry="select nvl(A.SUGGESTION,' ') SUGGESTION, B.SHORTNAME SN, nvl(A.SubjectCode,' ')Subj, nvl(A.SubjectID,' ')SubjID from V#SRSEVENTSUGGESTION A, EMPLOYEEMASTER B where A.EMPLOYEEID=B.EMPLOYEEID and ";
		qry=qry+" A.SubjectID=Decode('"+Subject + "','ALL',A.SubjectID,'"+ Subject+"')";
		qry=qry+" and to_char(A.Semester)=Decode('"+Semester + "','ALL',to_char(A.Semester),'"+ Semester +"')";
		qry=qry+" and A.EMPLOYEEID=Decode('"+Faculty+ "','ALL',A.EMPLOYEEID,'"+ Faculty+"') and SRSEVENTCODE='"+Event+"'";
		qry=qry+" and nvl(A.ISABUSING,'N')='Y'";
		rs=db.getRowset(qry);
		SNo=0;
		while(rs.next())
		{
			SNo++;
			%>
			<tr><td valign=top colspan=0><b><%=SNo%>.</b>&nbsp;</td>
			<td colspan=0 valign=top><%=rs.getString("SN")%>&nbsp;</td>
			<td valign=top><%=rs.getString("Subj")%>&nbsp;</td>
			<td valign=top><font color="indigo"><%=rs.getString("SUGGESTION")%></font></td>
			</tr>
			<%
		}
	}

 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  	}
 	 else
   	{
   %>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br>
   <%
   }
  //-----------------------------
	}
	else
	{
	out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font></b></center>");
	}
}
catch(Exception e)
{
}
%>
</table>
</body>
</html>