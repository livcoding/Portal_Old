<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rs2=null,rssrtype=null,rsc=null,rsc1=null;
GlobalFunctions gb =new GlobalFunctions();
double mTotPrecent=0;
double mTotDivide=0;
long mTotStrength=0,mTotSentStrength=0;
String qry="";
String qry1="",qry2="";
String x="",y="",yy="",z="",mRsExam="",t="";
int mSNO=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mOA="";
double mMarks=0,mEval=0,mPerc=0,mMarks1=0,cnt1=0,a=0,rating=0,rating1=0,ev=0,ev1=0,avg=0;
double mExTot=0;
double exev1=0;
double exavg=0;
long mLtot=0,mTtot=0,mPtot=0;
long Ltot=0,Ttot=0,Ptot=0;

String mInst="";
String mExam="";
String mexam="";
String mLTP="";
String mltp="";
String mPCode="";
String mpcode="";
String mSubj="";
String msubj="";
String mcolor="",mColor="";


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


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Personal SRS Report ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberType=enc.decode(mMemberType);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberID=enc.decode(mMemberID);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('40','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Personal SRS Teacher Rating Report [Overall Average]</B></TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>

<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="Select Distinct NVL(INSTITUTECODE,' ') IC from V#SRSEVENTS where  nvl(Approved,'N')='N' and nvl(Deactive,'N')='N'";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}
%>
<!--Program**********-->
<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Program</STRONG></FONT></FONT>
<%
try
{
	qry="Select Distinct nvl(B.PROGRAMCODE,' ')PROGRAMCODE, A.PROGRAMNAME||' ('||B.PROGRAMCODE||') ' Program from PROGRAMMASTER A, v#SRSEVENTS B where EmployeeID='"+mDMemberID +"' and A.ProgramCode=B.ProgramCode and nvl(Finalized,'N')='Y' and nvl(B.deactive,'N')='N'";
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
<td><FONT color=black><FONT face=Arial size=2><STRONG>SRS Event</STRONG></FONT></FONT>
<%
try
{ 
	qry="Select Distinct nvl(SRSEVENTCODE,' ')Exam from v#SRSEVENTS WHERE  EmployeeID='"+mDMemberID +"' and NVL(Finalized,'N')='Y' and nvl(deactive,'N')='N'";
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
<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG>&nbsp;&nbsp;</FONT></FONT>
<%
try
{ 
	qry1="Select Distinct SubjectID, SubjectCode, Subject, Subject||' ('||SubjectCode||') ' Subj from  v#SRSEVENTS  where Employeeid='"+mDMemberID+"' and nvl(Finalized,'N')='Y' and nvl(deactive,'N')='N' order by Subject";
		
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 325px">	
		<OPTION selected value=ALL>ALL</option>
		<%
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			if(msubj.equals(""))
 			msubj=mSubj;
			%>
			<OPTION  Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
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
	 		<OPTION selected value=ALL>ALL</option>
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
//	out.println("MSG6");
}
%>
</td>
<!--LTP***********-->
<td><FONT color=black><FONT face=Arial size=2><STRONG>LTP</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT>
<%
try
{ 
	qry1="select Distinct 'ALL' LTP,'ALL' LTPDesc,0 from dual UNION select distinct LTP, decode(LTP,'L','Lecture','T','Tutorial','Practical') LTPDesc, decode(LTP,'L',1,'T',2,3) LTPNO   from v#SRSevents where EmployeeID='"+mDMemberID +"' and nvl(Finalized,'N')='Y' and nvl(deactive,'N')='N' order by 3";	
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select ID='LTP' Name=LTP style="WIDTH: 120px">
		<%   
		mltp="";
		while(rs1.next())
		{
			mLTP=rs1.getString("LTP");
			if(mltp.equals(""))
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
	else
	{
		%>	
		<select ID='LTP' Name=LTP style="WIDTH: 120px">
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
	//out.println();
}
%>
</td></tr>
<!--Faculty***********-->
<tr><td colspan=2><FONT color=black><FONT face=Arial size=2><STRONG>Faculty</STRONG></FONT>&nbsp; &nbsp;</FONT>
<%
try
{ 
%>
		<select name=Faculty id="Faculty" style="WIDTH: 325px">	
			<OPTION selected Value =<%=mDMemberID%>><%=mMemberName%></option>
		</select>
			
<%
 }    
catch(Exception e)
{
	out.println("");
}
%>
<INPUT Type="submit" Value="Show"></td>
</tr>
</table>
</form>
<%
String mI="";
String mE="";
String mP="";
String mS="";
String mL="";
String mF="";
%>

<!-- <TABLE rules=Rows cellSpacing=0 cellPadding=0 width="100%" border=1 > -->
<table bgcolor=#fce9c5 width="100%" class="sort-table" id="table-1" bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
<thead>
<form name="frm1" method=post>
<TR bgcolor="#ff8c00">
 <td align=middle title='Click on Subject Name to sort table data'><b><font color="white">Subject</font></td>
 <td align=middle title='Click on LTP to sort table data'><b><font color="white">&nbsp;LTP</font></td>
 <td align=middle  nowrap>

<table class="sort-table" id="table-2"  border=0 cellpadding=0 cellspacing=0 width="70%"><thead>
<tr bgcolor="#ff8c00"><td colspan=3 align=middle><b><font color="white" >Resp./Regd.</font></b></td></tr><tr bgcolor="#ff8c00"><td align=middle><b><font color="white" >L</font></b></td>
<td align=middle><b><font color="white">T</font></b></td><td align=middle><b><font color="white" >P</font></b></td></tr></thead></table></td>
 
<!--
<td title='Click on Responded to sort table data' nowrap>
<table class="sort-table" id="table-3"  border=0 cellpadding=0 cellspacing=0 width="100%"><thead>
<tr bgcolor="#ff8c00"><td colspan=3><b><font color="white" >Responded</font></b></td></tr><tr bgcolor="#ff8c00"><td><b><font color="white" >L</font></b></td>
<td><b><font color="white" >T</font></b></td><td><b><font color="white" >P</font></b></td></tr></thead></table></td>
-->
 <%
      if(request.getParameter("x")!=null)
	{
	 mI=request.getParameter("Inst").toString().trim();
	 mE=request.getParameter("Exam").toString().trim();
	 mP=request.getParameter("Program").toString().trim();
	 mS=request.getParameter("Subject").toString().trim();
	 mL=request.getParameter("LTP").toString().trim();
	 mF=request.getParameter("Faculty").toString().trim();

	qry="select SRSHEADING,SRSCODE, SRSDESCRIPTION from SRSTYPEMASTER where srseventcode='"+(request.getParameter("Exam").toString().trim())+"' Order by SEQID";
	rs=db.getRowset(qry);
	while(rs.next())
	{	
	%>
		<td align=middle ><b><font color='White'><%=GlobalFunctions.toTtitleCase(rs.getString("SRSHEADING"))%></font></td> 
	<%	
	}
%>
<td align=middle ><b><font color="white" >Compre.</font></td>
</tr></thead><tbody>
<% 

	qry1 =" select distinct EXAMCODE,EMPLOYEEID,SUBJECTID,SUBJECTCODE,LTP,EMPLOYEENAME,SUBJECT from v#SRSEVENTDETAIL A Where ";
	qry1 = qry1 + " EMPLOYEEID='"+mDMemberID+"' And SRSEVENTCODE='"+mE+"'";
	qry1 = qry1 + " And PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') ";
	qry1 = qry1 + " And SUBJECTID=decode('"+mS+"','ALL',SUBJECTID, '"+mS+"') ";
	qry1 = qry1 + " and LTP=decode('"+mL+"','ALL',LTP, '"+mL+"') ";
	qry1 = qry1 + " and EMPLOYEEID=decode('"+mF+"','ALL',EMPLOYEEID, '"+mF+"') ";
	qry1 = qry1 + " and nvl(DEACTIVE,'N')='N' And nvl(Approved,'N')='Y' and nvl(Finalized,'N')='Y'";
	qry1 = qry1 + " Order by EMPLOYEEID,SUBJECTCODE,LTP";
      mMarks=0;
	mEval=0;
	mPerc=0;
	String p="";
	rs1=db.getRowset(qry1);
	while(rs1.next())
	{ 	
	try{
		if(x.equals("") || y.equals("") || z.equals(""))
		{ 
			mRsExam=rs1.getString("EXAMCODE").trim();
			x=rs1.getString("EMPLOYEEID");
			y=rs1.getString("SUBJECTID");
			yy=rs1.getString("SUBJECTCODE");
			z="'"+rs1.getString("LTP")+"'";
			p=rs1.getString("EMPLOYEENAME");
			t=rs1.getString("LTP");

		}
     		else if ((!rs1.getString("EMPLOYEEID").equals(x)) || (!rs1.getString("SUBJECTID").equals(y)))
		{

		// counting strength of students in subject and faculty

		if (!z.equals(""))
		{		
			qry="SELECT count(distinct studentid),LTP from V#STUDENTLTPDETAIL where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') ";
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+x+"' and LTP in("+z+") and nvl(deactive,'N')='N'";
		qry=qry+" group by SUBJECTID,ltp ";
		rsc=db.getRowset(qry);
		Ltot=0 ;
		Ttot=0 ;
		Ptot=0;
		while(rsc.next())
		{
			if(rsc.getString("LTP").equals("L"))
			Ltot=rsc.getLong(1);
			else if(rsc.getString("LTP").equals("P"))
			Ptot=rsc.getLong(1);
			else if(rsc.getString("LTP").equals("T"))
			Ttot=rsc.getLong(1);
	
		}
		
	//	out.print(qry);
		qry="SELECT count(distinct studentid) mtot,LTP from V#SRSEVENTSUGGESTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+"and SRSEVENTCODE='"+mE+"' and EMPLOYEEID='"+mDMemberID+"'";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') " ;
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+ x +"'  And LTP in ("+z+") and nvl(deactive,'N')='N'";
		qry=qry+" group by SUBJECTID,ltp ";
		rsc1=db.getRowset(qry);
		 mLtot=0 ;
		mTtot=0 ;
		mPtot=0;
	//	out.print(qry);
		while(rsc1.next())
		{
			if(rsc1.getString("LTP").equals("L"))
			mLtot=rsc1.getLong(1);
			else if(rsc1.getString("LTP").equals("P"))
			mPtot=rsc1.getLong(1);
			else if(rsc1.getString("LTP").equals("T"))
			mTtot=rsc1.getLong(1);
	
		}

		}

//-----------------------------

	%>
	   		<tr>			
			 <td align=middle><a target=_New href="SrsEventSuggestion.jsp?ICD=<%=mInst%>&amp;SEC=<%=mE%>&amp;EC=<%=mRsExam%>&amp;SID=<%=y%>&amp;SC=<%=yy%>&amp;LTP=<%=t%>&amp;EMPID=<%=x%>"><%=yy%></a></td> 
			 <td align=middle><%=GlobalFunctions.getSortedLTPSQ(z)%></td>
			 <td align=center><table><tr><td><font size=2 face=Tahoma><%=mLtot%>/<%=Ltot%></font></td><td><font size=2 face=Tahoma><%=mTtot%>/<%=Ttot%></font></td><td><font size=2 face=Tahoma><%=mPtot%>/<%=Ptot%></font></td></tr></table>
		</td>
		<!--
		 <td align=center>
		<table><tr><td><font size=2 face=Tahoma><%=mLtot%></font></td><td><font size=2 face=Tahoma><%=mTtot%></font></td><td><font size=2 face=Tahoma><%=mPtot%></font></td></tr></table>
		</td>
		-->

		<%
		 mTotPrecent=0;
		 mTotDivide=0;
		qry="select SRSCODE, nvl(Weightage,0) Weightage from SRSTYPEMASTER WHERE SRSEVENTCODE='"+mE+"' Order by SEQID ";
		rssrtype=db.getRowset(qry);
		while(rssrtype.next())
		{	
			qry2="select NVL(D.EVALUATIONUPTO,0)EVALUATIONUPTO,COUNT(*) cnt, nvl(A.NASELECTED,'N')NASELECTED, A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
			qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,nvl(C.EXCLUDINGREQUIRED,'N') EXCLUDINGREQUIRED,sum(A.RatingValue) RatingValue from V#SRSEVENTDETAIL A,SRSTYPEMASTER B,SRSSUBTYPEMASTER C,SRSRATINGMASTER D";
			qry2=qry2+ " where A.SRSEVENTCODE='"+mE+"' AND A.SRSEVENTCODE=B.SRSEVENTCODE AND A.SRSEVENTCODE=C.SRSEVENTCODE  and A.SRSCODE=B.SRSCODE AND A.SRSSUBCODE=C.SRSSUBCODE AND A.SRSCODE=C.SRSCODE AND A.institutecode='"+mInst+"'";
			qry2=qry2 + " AND A.EXAMCODE='"+mRsExam+"' ";
			qry2=qry2+"  AND  A.RATINGCODE=D.RATINGCODE  ";
			qry2=qry2+ " and A.Employeeid='"+x+"' and  ";
			qry2=qry2 + " A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"')  AND ";
			qry2=qry2 + " A.LTP IN ("+z+") AND A.SRSCODE='"+rssrtype.getString("SRSCODE")+"' ";
			qry2=qry2+ " and A.SUBJECTID='"+y+"' and nvl(A.naselected,'N')='N' ";
			qry2=qry2+" and nvl(APPROVED,'N')='Y' and nvl(FINALIZED,'N')='Y' ";
			qry2=qry2 + " AND  nvl(A.DEACTIVE,'N')='N'  ";
			qry2=qry2+" Group by D.EVALUATIONUPTO,A.NASELECTED,A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
			qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,C.EXCLUDINGREQUIRED ORDER BY B.SEQID,C.SEQID ";
			rs2=db.getRowset(qry2);
	//out.print(qry2);

		mMarks=0;
		mEval=0;
		mPerc=0;
		a=0;
		cnt1=0;
		rating=0;
		rating1=0;
		ev=0;
		ev1=0;
		avg=0;
		mExTot=0;
		exev1=0;
		exavg=0;
			   while(rs2.next())
	   		   {
				ev=rs2.getDouble("EVALUATIONUPTO");
			 	if(rs2.getString("NASELECTED").equals("N"))
	 			{
					a=rs2.getDouble("RatingValue");
					cnt1=rs2.getDouble("cnt");
					rating=a/cnt1;	
					rating=gb.getRound(rating,2);
					rating1=rating1+rating ;
					ev1=ev1+ev;
					if (rs2.getString("EXCLUDINGREQUIRED").equals("Y"))
				     {
						mExTot=mExTot+rating;
						mExTot=gb.getRound(mExTot,2);
						exev1=exev1+ev;
		                 }
					
		 		 } //closing of if
	   		  }  //closing of rs2..while
				if(rating1==0)
				{
			%>	
				<TD>&nbsp;</td>
			<%
				}
				else
				{   // *****2
					if(mExTot>0)
					{
					   exavg=((rating1-mExTot)/(ev1-exev1))*100;
		   			   mTotPrecent=mTotPrecent+(exavg*rssrtype.getDouble("Weightage")/100);
					   mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);
					   if(exavg<50)
                                 mcolor="red";
					   else
					   mcolor="black";
					%>
					   <td align=middle><font color=<%=mcolor%>><%=gb.getRound(exavg,2)%></font></td>
					<%
					}
					else
					{
						avg=(rating1/ev1)*100;
		   			      mTotPrecent=mTotPrecent+(avg*rssrtype.getDouble("Weightage")/100);
						mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);
						if(avg<50)
						mcolor="red";
						else
						mcolor="black";
					
					%>
						<TD align=middle><font color=<%=mcolor%>><%=gb.getRound(avg,2)%></font></td>
					<%
					}	
				} //closing of *****2 else
			}  //***** closing of srscode while loop
			
			if(mTotDivide>0)
			{
			if((mTotPrecent/mTotDivide)<50)
			mColor="red";
			else
			mColor="black";
			%>		
			<td align=middle><font color=<%=mColor%>><%=gb.getRound((mTotPrecent/mTotDivide),2)%></font></td>
			<%

			}
			else
			{
			%><td>&nbsp;</td><%
			}
			mTotPrecent=0;
			mTotDivide=0;
	//---------------
	
	%>
	     </tr> 
	 <%	mRsExam=rs1.getString("EXAMCODE").trim();
		x=rs1.getString("EMPLOYEEID");
		y=rs1.getString("SUBJECTID");
		yy=rs1.getString("SUBJECTCODE");
		z="'"+rs1.getString("LTP")+"'";	
		p=rs1.getString("EMPLOYEENAME");
		t=rs1.getString("LTP");	

		}
	  else
	  {
		z=z+",'"+rs1.getString("LTP")+"'";	
		t=t+rs1.getString("LTP");	

		
	  }		

	}

	catch(Exception e)
	{
//	out.print("in catch block"+qry);
	}

   }  //closing of while rs1


//--------counting of students....

if (!z.equals(""))
	{
		qry="SELECT count(distinct studentid),LTP from V#STUDENTLTPDETAIL where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+" and PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') ";
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+x+"' and LTP in("+z+") and nvl(deactive,'N')='N'";
		qry=qry+" group by SUBJECTID,ltp ";
		rsc=db.getRowset(qry);
		Ltot=0 ;
		Ttot=0 ;
		Ptot=0;
		while(rsc.next())
		{
			if(rsc.getString("LTP").equals("L"))
			Ltot=rsc.getLong(1);
			else if(rsc.getString("LTP").equals("P"))
			Ptot=rsc.getLong(1);
			else if(rsc.getString("LTP").equals("T"))
			Ttot=rsc.getLong(1);
	
		}
		
	//	out.print(qry);
		qry="SELECT count(distinct studentid) mtot,LTP from V#SRSEVENTSUGGESTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mRsExam+"'";
		qry=qry+"and SRSEVENTCODE='"+mE+"' and EMPLOYEEID='"+mDMemberID+"'";
		qry=qry+" and  PROGRAMCODE=decode('"+mP+"','ALL',PROGRAMCODE, '"+mP+"') " ;
		qry=qry+" and SUBJECTID='"+y+"' and EmployeeID='"+ x +"'  And LTP in ("+z+") and nvl(deactive,'N')='N'";
		qry=qry+" group by SUBJECTID,ltp ";
		rsc1=db.getRowset(qry);
		 mLtot=0 ;
		mTtot=0 ;
		mPtot=0;
	//	out.print(qry);
		while(rsc1.next())
		{
			if(rsc1.getString("LTP").equals("L"))
			mLtot=rsc1.getLong(1);
			else if(rsc1.getString("LTP").equals("P"))
			mPtot=rsc1.getLong(1);
			else if(rsc1.getString("LTP").equals("T"))
			mTtot=rsc1.getLong(1);
	
		}

	}   
	if(!x.equals("") && !y.equals("") && !z.equals(""))
 	{
	//--------------------------------------------------
	%>
		<tr>		 
		 <td align=middle><a target=_New href="SrsEventSuggestion.jsp?ICD=<%=mInst%>&amp;SEC=<%=mE%>&amp;EC=<%=mRsExam%>&amp;SID=<%=y%>&amp;SC=<%=yy%>&amp;LTP=<%=t%>&amp;EMPID=<%=x%>"><%=yy%></a></td> 
		 <td align=middle><%=GlobalFunctions.getSortedLTPSQ(z)%></td>
		 <td align=center><table><tr><td><font size=2 face=Tahoma><%=mLtot%>/<%=Ltot%></font></td><td><font size=2 face=Tahoma><%=mTtot%>/<%=Ttot%></font></td><td><font size=2 face=Tahoma><%=mPtot%>/<%=Ptot%></font></td></tr></table>
		</td>


		<!--
		 <td align=center>
		<table><tr><td><font size=2 face=Tahoma><%=mLtot%></font></td><td><font size=2 face=Tahoma><%=mTtot%></font></td><td><font size=2 face=Tahoma><%=mPtot%></font></td></tr></table>
		</td>
		-->
	<%   try{
		qry="select SRSCODE, nvl(Weightage,0) Weightage from SRSTYPEMASTER WHERE SRSEVENTCODE='"+mE+"' Order by SEQID ";
		rssrtype=db.getRowset(qry);
		while(rssrtype.next())
		{
					 
	qry2="select NVL(D.EVALUATIONUPTO,0)EVALUATIONUPTO,COUNT(*) cnt, nvl(A.NASELECTED,'N')NASELECTED, A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,nvl(C.EXCLUDINGREQUIRED,'N') EXCLUDINGREQUIRED,sum(A.RatingValue) RatingValue from V#SRSEVENTDETAIL A,SRSTYPEMASTER B,SRSSUBTYPEMASTER C,SRSRATINGMASTER D";
	qry2=qry2+ " where A.SRSEVENTCODE='"+mE+"' AND A.SRSEVENTCODE=B.SRSEVENTCODE AND A.SRSEVENTCODE=C.SRSEVENTCODE  and A.SRSCODE=B.SRSCODE AND A.SRSSUBCODE=C.SRSSUBCODE AND A.SRSCODE=C.SRSCODE AND A.institutecode='"+mInst+"'";
	qry2=qry2 + " AND A.EXAMCODE='"+mRsExam+"' ";
	qry2=qry2+"  AND  A.RATINGCODE=D.RATINGCODE  ";
	qry2=qry2+ " and A.Employeeid='"+x+"' and  ";
	qry2=qry2 + " A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"')  AND ";
	qry2=qry2 + " A.LTP IN ("+z+") AND A.SRSCODE='"+rssrtype.getString("SRSCODE")+"' ";
	qry2=qry2+ " and A.SUBJECTID='"+y+"' and nvl(A.naselected,'N')='N' ";
	qry2=qry2+" and nvl(APPROVED,'N')='Y' and nvl(FINALIZED,'N')='Y' ";
	qry2=qry2 + " AND  nvl(A.DEACTIVE,'N')='N'  ";
	qry2=qry2+" Group by D.EVALUATIONUPTO,A.NASELECTED,A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,C.EXCLUDINGREQUIRED ORDER BY B.SEQID,C.SEQID ";
	rs2=db.getRowset(qry2);
	//out.print(qry2);

		mMarks=0;
		mEval=0;
		mPerc=0;
		a=0;
		cnt1=0;
		rating=0;
		rating1=0;
		ev=0;
		ev1=0;
		avg=0;
		mExTot=0;
		exev1=0;
		exavg=0;
				
			   while(rs2.next())
	   		   {
				ev=rs2.getDouble("EVALUATIONUPTO");
				if(rs2.getString("NASELECTED").equals("N"))
	 			{
					a=rs2.getDouble("RatingValue");
					cnt1=rs2.getDouble("cnt");
					rating=a/cnt1;	
					rating=gb.getRound(rating,2);
					rating1=rating1+rating ;
					ev1=ev1+ev;
				if (rs2.getString("EXCLUDINGREQUIRED").equals("Y"))
				{
					mExTot=mExTot+rating;
					mExTot=gb.getRound(mExTot,2);
					exev1=exev1+ev;
				  }
					
		 		}
	   		  }

				if(rating1==0)
				{
				%>
				<TD>&nbsp;</td>
				<%
				}
				else
				{
				if(mExTot>0)
				{
				exavg=((rating1-mExTot)/(ev1-exev1))*100;			
					
	   			   mTotPrecent=mTotPrecent+(exavg*rssrtype.getDouble("Weightage")/100);
				   mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);
				if(exavg<50)
						mcolor="red";
						else
						mcolor="black";

				%>
				<td align=middle><font color=<%=mcolor%>><%=gb.getRound(exavg,2)%><font></td>
				<%
				}
				else
				{
					avg=(rating1/ev1)*100;
		   			   mTotPrecent=mTotPrecent+(avg*rssrtype.getDouble("Weightage")/100);
					   mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);

						if(avg<50)
						mcolor="red";
						else
						mcolor="black";

				%>
					<TD align=middle><font color=<%=mcolor%>><%=gb.getRound(avg,2)%></font></td>
				<%
				}	
				

			}			 
			}


			if(mTotDivide>0)
			{
			if((mTotPrecent/mTotDivide)<50)
			mColor="red";
			else
			mColor="black";
			%>		
			<td align=middle><font color=<%=mColor%>><%=gb.getRound((mTotPrecent/mTotDivide),2)%></font></td>
			<%

			}
			else
			{
			%>
			<td>&nbsp;</td>
			<%
			}
			mTotPrecent=0;
			mTotDivide=0;

			
}
catch(Exception e)
{
// out.print(qry);
}
}
%>
	       </tr> 
</tbody>
</form>
</TABLE>


		<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString", "CaseInsensitiveString" ]);
		</script>


<center><FONT size=2 color=green># LTP will be merged in a single row if Lecture,Tutorial or Practical of the selected subject is taken by the same Faculty.</FONT></center> 
<center><MARQUEE style="COLOR: #63756d; FONT-FAMILY: Arial; FONT-SIZE: x-small; FONT-STYLE: normal; FONT-VARIANT: normal; FONT-WEIGHT: bold; HEIGHT: 8px; " Behavior='alternate' scrolldelay=225>Click on subject to view the respective suggestions.</MARQUEE>
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