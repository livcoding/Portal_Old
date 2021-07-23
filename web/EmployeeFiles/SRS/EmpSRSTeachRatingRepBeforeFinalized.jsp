<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student Reaction Survey Report (SRS After approval and Before Finalization-for Admin User)] </TITLE>
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
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rs2=null,rssrtype=null,rsc=null,rsc1=null;
//GlobalFunctions gb =new GlobalFunctions();

long mTotStrength=0,mTotSentStrength=0;
String qry="";
String qry1="",qry2="";
String x="",yy="",y="",z="",mRsExam="",t="";
int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mOA="";
double mMarks=0,mEval=0,mPerc=0;
String mInst="";
String minst="";

String mExam="";
String mexam="";

String mEvent="";
String mevent="";

String mLTP="";
String mltp="";
String MLTP="";

String mPCode="";
String mpcode="";

String mSubj="";
String msubj="";

String mFaculty="";
String mFacultyID="";
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

try
{
	OLTEncryption enc=new OLTEncryption();

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('78','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------



%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD align=middle><font color="#c00000" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>SRS Report [Overall % Rating] - Before Finalization</b></font></td>
</tr>
</TABLE>
<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>

<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(FINALIZED,'N')='Y' and nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}
%>
<!--Program**********-->
<tr><td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Program</STRONG></FONT></FONT>
<%
try
{
	qry="Select Distinct nvl(B.PROGRAMCODE,' ')PROGRAMCODE, A.PROGRAMNAME||' ('||B.PROGRAMCODE||') ' Program from PROGRAMMASTER A, V#SRSEVENTS B where A.ProgramCode=B.ProgramCode and nvl(APPROVED,'N')='Y' and nvl(FINALIZED,'N')='N' and nvl(B.deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Program tabindex="0" id="Program" style="WIDTH: 325px">	
		<OPTION selected value=ALL>ALL</option>
		<%   
		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			if(mpcode.equals(""))
 			mpcode=mPCode;
			%>
			<OPTION Value =<%=mPCode%>><%=rs.getString("Program")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Program tabindex="0" id="Program" style="WIDTH: 325px">	
		<%
		if (request.getParameter("Program").toString().trim().equals("ALL"))
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
			mPCode=rs.getString("PROGRAMCODE");
			if(mPCode.equals(request.getParameter("Program").toString().trim()))
 			{
				mpcode=mPCode;
				%>
				<OPTION selected Value =<%=mPCode%>><%=rs.getString("Program")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mPCode%>><%=rs.getString("Program")%></option>
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
//	out.println("MSG5");
}
%>
</td>
<!--SRSEVENTCODE****-->
<td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>SRS Event</STRONG></FONT></FONT>
<%
try
{
	qry="Select Distinct nvl(SRSEVENTCODE,' ')Exam from v#SRSEVENTS WHERE nvl(APPROVED,'N')='Y' and NVL(FINALIZED,'N')='N' and nvl(deactive,'N')='N'";
	rs=db.getRowset(qry);
//	out.print(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mexam.equals(""))
 			mexam=mExam;
			%>
			<OPTION selected Value =<%=mExam%>><%=mExam%></option>
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
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				%>
				<OPTION selected Value =<%=mExam%>><%=mExam%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mExam%>><%=mExam%></option>
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
//	out.println("MSG2");
}
%>
</td></tr>
<!--SUBJECT**************-->
<tr><td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG>&nbsp;&nbsp;</FONT></FONT>
<%
try
{ 
	qry1="Select Distinct B.SubjectID SubjectID, B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj from v#SRSEVENTS B where nvl(APPROVED,'N')='Y' and NVL(FINALIZED,'N')='N' and nvl(B.deactive,'N')='N' ORDER BY B.SUBJECT";
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 325px">	
		<OPTION selected Value=ALL>ALL</option>
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			if(msubj.equals(""))
 			msubj=mSubj;
			%>
			<OPTION Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 325px">	
		<%
		if (request.getParameter("Subject").toString().trim().equals("ALL"))
 		{
			%>
	 		<OPTION Value=ALL Selected>ALL</option>

			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}

		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
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
</td>
<!--LTP***********-->
<td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>LTP</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT>
<%
try
{ 
	qry1="select 'ALL' LTP,'ALL' LTPDesc from dual UNION select distinct LTP, decode(LTP,'L','Lecture','T','Tutorial','Practical') LTPDesc from v#SRSevents where nvl(APPROVED,'N')='Y' and NVL(FINALIZED,'N')='N' and nvl(deactive,'N')='N'";
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select ID="LTP" Name=LTP tabindex="0" style="WIDTH: 120px">
		<%   
		while(rs1.next())
		{
			mLTP=rs1.getString("LTP");
			if(mltp.equals(""))
 			{mltp=mLTP;
			%>
			<OPTION selected Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
			<%			
			}
			else
			{
			%>
			<OPTION Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
			<%			

			}
		}
		%>
		</select><font color='green'>#</font>
		<%
	}
	else
	{
		%>	
		<select ID="LTP" Name=LTP tabindex="0" style="WIDTH: 120px">
		<%		 
		while(rs1.next())
		{
			mLTP=rs1.getString("LTP");
			if(mLTP.equals(request.getParameter("LTP").toString().trim()))
 			{
				mltp=mLTP;
				%>
				<OPTION selected Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
		      	<%			
		   	}
		}
		%>
		</select><font color='green'>#</font>
	  	<%
	 }
 }    
catch(Exception e)
{
	out.println("");
}
%>
</td></tr>
<!--Faculty***********-->
<tr><td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Faculty</STRONG>&nbsp;&nbsp;</FONT></FONT>
<%
try
{ 
	qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from V#SRSEVENTS A Where nvl(A.APPROVED,'N')='Y' and nvl(A.FINALIZED,'N')='N' and nvl(Deactive,'N')='N' ORDER BY EMPLOYEENAME";
//	out.print(qry);
	rs=db.getRowset(qry);
	if (request.getParameter("Faculty")==null)
	{
		%>
		<select name=Faculty id="Faculty" style="WIDTH: 325px">	
		<OPTION selected value=ALL>ALL</option>
		<%
		while(rs.next())
		{
			mFacultyID=rs.getString("EMPLOYEEID");
			mFaculty=rs.getString("EMPLOYEENAME");
			if(mfaculty.equals(""))
 			mfaculty=mFacultyID;
			%>
			<OPTION Value =<%=mFacultyID%>><%=mFaculty%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 325px">	
		<%
		if (request.getParameter("Faculty").toString().trim().equals("ALL"))
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
			mFaculty=rs.getString("EMPLOYEENAME");
			mFacultyID=rs.getString("EMPLOYEEID");
			if(mFacultyID.equals(request.getParameter("Faculty").toString().trim()))
 			{
				mfaculty=mFacultyID;
				%>
				<OPTION selected Value =<%=mFacultyID%>><%=mFaculty%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mFacultyID%>><%=mFaculty%></option>
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
	out.println("");
}
%>
</td>
<td><INPUT Type="submit" Value="Show"></td>
</tr>
</table>
</form>
<%
String mE="";
String mP="";
String mS="";
String mL="";
String mF="";
%>

<TABLE rules=Rows cellSpacing=0 cellPadding=0 width="100%" border=1 >
<form name="frm1" method=post>
<tr bgcolor="#ff8c00">
 <td><b><font color="white">Teacher Name</font></td>
 <td><b><font color="white">Subject</font></td>
 <td><b><font color="white">&nbsp;LTP</font></td>
 <td><b><font color="white" size=2>Total Count<br>of Group</font></td>
 <td><b><font color="white" size=2>Total no. of<br>Submitted </font></td>

 <%
      if(request.getParameter("x")!=null)
	{
	 mE=request.getParameter("Exam").toString().trim();
	 mP=request.getParameter("Program").toString().trim();
	 mS=request.getParameter("Subject").toString().trim();
	 mL=request.getParameter("LTP").toString().trim();
	 mF=request.getParameter("Faculty").toString().trim();

	qry="select SRSCODE, SRSDESCRIPTION from SRSTYPEMASTER where srseventcode='"+(request.getParameter("Exam").toString().trim())+"' Order by SEQID";
	rs=db.getRowset(qry);
	while(rs.next())
	{	
		String mmOA="";
		mOA=rs.getString("SRSDESCRIPTION");
		int pos = 0;
		pos=mOA.indexOf(" ");
		if (pos>0)
    		{
			mmOA=mOA.substring(0,pos+1);
			%>
			<td><b><font color="white" size=2><%=mmOA%></font></td>
			<%
		}
		else
		{
			mmOA=mOA.substring(0,7);
			%>
			<td><b><font color="white" size=2><%=mmOA%></font></td>
			<%			
		}

	}
%>
</tr>
<% 

qry1 =" select distinct A.INSTITUTECODE, A.COMPANYCODE,A.SRSEVENTCODE,A.FACULTYTYPE,A.EMPLOYEEID, ";
qry1 = qry1 + "a.EXAMCODE,A.SUBJECTCODE,A.SUBJECTID,A.LTP, ";
qry1 = qry1 + "A.EMPLOYEENAME,A.SUBJECT ";
qry1 = qry1 + "from v#SRSEVENTDETAIL A Where A.INSTITUTECODE='"+mInst+"' AND A.SRSEVENTCODE='"+mE+"'";
qry1 = qry1 + "And A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"') ";
qry1 = qry1 + "And A.SUBJECTID=decode('"+mS+"','ALL',A.SUBJECTID, '"+mS+"') ";
qry1 = qry1 + "and A.LTP=decode('"+mL+"','ALL',LTP, '"+mL+"') ";
qry1 = qry1 + "and A.EMPLOYEEID=decode('"+mF+"','ALL',A.EMPLOYEEID, '"+mF+"') ";
qry1 = qry1 + "and nvl(A.DEACTIVE,'N')='N'";
qry1 = qry1 + "And (A.FSTID) in (select FSTID from v#SRSEvents where nvl(APPROVED,'N')='Y' and NVL(FINALIZED,'N')='N' and nvl(Deactive,'N')='N')";
qry1 = qry1 + "order by A.Employeename,A.EMPLOYEEID,A.SUBJECTCODE,A.LTP";

      mMarks=0;
	mEval=0;
	mPerc=0;
	String p="";
	rs1=db.getRowset(qry1);
	while(rs1.next())
	{ 	
	try{
		if(x.equals("") || y.equals("") || yy.equals("") || z.equals(""))
		{ 
		      mRsExam=rs1.getString("EXAMCODE").trim();
			x=rs1.getString("EMPLOYEEID");
			y=rs1.getString("SUBJECTID");
			yy=rs1.getString("SUBJECTCODE");
			z="'"+rs1.getString("LTP")+"'";
			t=rs1.getString("LTP");
			p=rs1.getString("EMPLOYEENAME");

		}
     		else if (!(rs1.getString("EMPLOYEEID").equals(x) && rs1.getString("SUBJECTID").equals(y)&& rs1.getString("SUBJECTCODE").equals(yy)) )
		{

// counting strength of students in subject and faculty

if (!z.equals(""))
	{
	//	kk++;
		qry="SELECT count(distinct studentid) from V#STUDENTLTPDETAIL where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') ";
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+x+"' and LTP in("+z+") and nvl(deactive,'N')='N'";
		rsc=db.getRowset(qry);
//out.print("total count of group"+ qry);

		if (rsc.next())
		{
			mTotStrength=rsc.getLong(1);
		}
		else
		{
			mTotStrength=0;
		}
		
		qry="SELECT count(distinct studentid) mtot from v#SRSEVENTSUGGESTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+"and SRSEVENTCODE='"+mE+"'";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') " ;
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+x+"' And LTP in ("+z+") and nvl(deactive,'N')='N'";
		rsc1=db.getRowset(qry);
//out.print("total count of submitted"+ qry);

		if (rsc1.next())
		{
			mTotSentStrength=rsc1.getLong("mtot");
		}
		else
		{
			mTotSentStrength=0;
		}
	}
//-----------------------------
	%>
	   		<tr>
			 <td><font size=2><%=p%></font></td> 
			 <td><%=yy%></td> 
			 <td>&nbsp;<%=GlobalFunctions.getSortedLTPSQ(z)%></td>
			 <td align=center><%=mTotStrength%></td>
			 <td align=center><a  target=_New href="SrsEventSuggestionBeforeFinalized.jsp?ICD=<%=mInst%>&amp;SEC=<%=mE%>&amp;EC=<%=mRsExam%>&amp;SID=<%=y%>&amp;SC=<%=yy%>&amp;LTP=<%=t%>&amp;EMPID=<%=x%>"><%=mTotSentStrength%></a></td>
		<%
		qry="select SRSCODE from SRSTYPEMASTER WHERE SRSEVENTCODE='"+mE+"' Order by SEQID ";
		rssrtype=db.getRowset(qry);
		while(rssrtype.next())
		{	
			qry2="select NVL(A.RATINGVALUE,0)RATINGVALUE,NVL(NASELECTED,'N')NASELECTED,NVL(B.EVALUATIONUPTO,0)EVALUATIONUPTO FROM v#SRSEVENTDETAIL A,SRSRATINGMASTER B ";
			qry2=qry2 + " WHERE A.INSTITUTECODE='"+mInst+"' AND A.SRSEVENTCODE='"+mE+"' ";
			qry2=qry2 + " AND A.EXAMCODE='"+mRsExam+"' AND  A.RATINGCODE=B.RATINGCODE AND ";
			qry2=qry2 + " A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"')  AND ";
			qry2=qry2 + " A.SUBJECTID='"+y+"' AND ";
			qry2=qry2 + " A.EMPLOYEEID='"+x+"' AND ";
			qry2=qry2 + " A.LTP IN ("+z+") AND A.SRSCODE='"+rssrtype.getString("SRSCODE")+"' ";
			qry2=qry2 + " AND  nvl(A.DEACTIVE,'N')='N'  ";
			rs2=db.getRowset(qry2);
			mMarks=0;
			mEval=0;
			mPerc=0;
			   while(rs2.next())
	   		   {	
			 	if(rs2.getString("NASELECTED").equals("N"))
	 			{
				   mMarks=mMarks + (rs2.getDouble("RATINGVALUE"));
				   mEval=mEval + (rs2.getDouble("EVALUATIONUPTO"));
		 		}
	   		  }
				if(mMarks==0)
				{
			%>		<TD>&nbsp;</td>
			<%
				}
				else
				{
					mPerc=Math.round((mMarks/mEval)*100 );
			//	mPerc=((mMarks/mEval)*100 );
			%>
				<TD><%=mPerc%>%</td>
			<%
			} 
			}

	//---------------
	
	%>
	     </tr> 
	 <%	mRsExam=rs1.getString("EXAMCODE").trim();
		x=rs1.getString("EMPLOYEEID");
		y=rs1.getString("SUBJECTID");
		yy=rs1.getString("SUBJECTCODE");
		z="'"+rs1.getString("LTP")+"'";
		t=rs1.getString("LTP");
		p=rs1.getString("EMPLOYEENAME");
		}
	  else
	  {
		z=z+",'"+rs1.getString("LTP")+"'";	
		t=t+rs1.getString("LTP");
	  }		

	}


	catch(Exception e)
	{
	}

   }  //closing of while rs1


//--------counting of students....

if (!z.equals(""))
	{
	//	kk++;
		qry="SELECT count(distinct studentid) from V#STUDENTLTPDETAIL where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') ";
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+x+"' and LTP in("+z+") and nvl(deactive,'N')='N'";
		rsc=db.getRowset(qry);

		if (rsc.next())
		{
			mTotStrength=rsc.getLong(1);
		}
		else
		{
			mTotStrength=0;
		}
		
		qry="SELECT count(distinct studentid) mtot from v#SRSEVENTSUGGESTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+"and SRSEVENTCODE='"+mE+"'";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') " ;
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+x+"' And LTP in ("+z+") and nvl(deactive,'N')='N'";
		rsc1=db.getRowset(qry);
//out.print("total count of submitted"+ qry);

		if (rsc1.next())
		{
			mTotSentStrength=rsc1.getLong("mtot");
		}
		else
		{
			mTotSentStrength=0;
		}
	}

if(!x.equals("") && !y.equals("") && !z.equals(""))
 	{

//--------------------------------------------------
	%>
	       <tr>
		 <td><font size=2><%=p%></font></td> 
		 <td><%=yy%></td> 
		 <td>&nbsp;<%=GlobalFunctions.getSortedLTPSQ(z)%></td>
		 <td align=center><%=mTotStrength%></td>
		 <td align=center><a  target=_New href="SrsEventSuggestionBeforeFinalized.jsp?ICD=<%=mInst%>&amp;SEC=<%=mE%>&amp;EC=<%=mRsExam%>&amp;SC=<%=yy%>&amp;SID=<%=y%>&amp;LTP=<%=t%>&amp;EMPID=<%=x%>"><%=mTotSentStrength%></a></td>
	<%   try{
		qry="select SRSCODE from SRSTYPEMASTER WHERE SRSEVENTCODE='"+mE+"' Order by SEQID ";
		rssrtype=db.getRowset(qry);
		while(rssrtype.next())
		{	
			qry2="select NVL(A.RATINGVALUE,0)RATINGVALUE,NVL(NASELECTED,'N')NASELECTED,NVL(B.EVALUATIONUPTO,0)EVALUATIONUPTO FROM v#SRSEVENTDETAIL A,SRSRATINGMASTER B ";
			qry2=qry2 + " WHERE A.INSTITUTECODE='"+mInst+"' AND A.SRSEVENTCODE='"+mE+"' ";
			qry2=qry2 + " AND A.EXAMCODE='"+mRsExam+"' AND  A.RATINGCODE=B.RATINGCODE AND ";
			qry2=qry2 + " A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"')  AND ";
			qry2=qry2 + " A.SUBJECTID='"+y+"' AND ";
			qry2=qry2 + " A.EMPLOYEEID='"+x+"' AND ";
			qry2=qry2 + " A.LTP IN ("+z+") AND A.SRSCODE='"+rssrtype.getString("SRSCODE")+"' ";
			qry2=qry2 + " AND  nvl(A.DEACTIVE,'N')='N'  ";
			rs2=db.getRowset(qry2);

	//		out.print(qry2);
			mMarks=0;
			mEval=0;
			mPerc=0;
			// out.print("abc");
			   while(rs2.next())
	   		   {				
			 	if(rs2.getString("NASELECTED").equals("N"))
	 			{
				   mMarks=mMarks + (rs2.getDouble("RATINGVALUE"));
				   mEval=mEval + (rs2.getDouble("EVALUATIONUPTO"));
		 		}
	   		  }

				if(mMarks==0)
				{
		%>				<TD>&nbsp;</td>
<%
				}
				else
				{
					mPerc=Math.round((mMarks/mEval)*100 );
			//	mPerc=((mMarks/mEval)*100 );
			%>
				<TD><%=mPerc%>%</td>
			<%
			} 
			}
}
catch(Exception e)
{
//	 out.print(qry);
}
  }   //-------- closing of if(!x.equals("") && !y.equals("") && !z.equals(""))

%>
    </tr> 

</form>
		</TABLE>
<center><FONT size=2 color=green># LTP will be merged in a single row if Lecture,Tutorial or Practical of the selected subject is taken by the same Faculty.</FONT></center> 
<center><MARQUEE style="COLOR: #63756d; FONT-FAMILY: Arial; FONT-SIZE: x-small; FONT-STYLE: normal; FONT-VARIANT: normal; FONT-WEIGHT: bold; HEIGHT: 8px; " Behavior='alternate' scrolldelay=225>Click Total no. of Submitted to view the respective suggestions.</MARQUEE>
</center> 

 <%
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
	}
%>
</body>
</html>