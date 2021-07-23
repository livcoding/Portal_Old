<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

String x="",y="";
GlobalFunctions gb =new GlobalFunctions();
double exavg=0,rating=0,exev1=0,a=0,cnt1=0,ev=0,rating1=0,ev1=0,avg=0, mExTot=0;
double ef=0;
DBHandler db=new DBHandler();
ResultSet rs=null,rsec=null,rssu=null;
String mWidth="100";
int kk=0;
ResultSet rsi=null,rsa=null,rss=null,rsf=null,rsm=null,rs1=null,rs2=null,rs3=null;
String qry="";
String qry1="";
String mInst="",mAcad="",mSubj="",msubj="",mFacultyID="",mFaculty="",mfaculty="",mSubhead="";
int mSem=0;
String mFac="",mexam="",mExam="",msrs="";
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="",mDMemberID="";
String mMemberName="",mDMemberType="";
String mWebEmail="";
String mSrsevent="";
// String mSrsevent="SRS-10112006";
int msno=0;
String mSRSCont="";


if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";


%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey detailed report (Faculty wise) ] </TITLE>



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>


</head>
<body aLink=#ff00ff bgcolor=lightgoldenrodyellow rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
OLTEncryption enc=new OLTEncryption();
	mDMemberType=enc.decode(mMemberType);
if(!mMemberID.equals("") && !mDMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
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
	qry="Select WEBKIOSK.ShowLink('55','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
 	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {

if (request.getParameter("Width")!=null)
	mWidth=request.getParameter("Width").toString().trim();
else
	mWidth="100";
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width='<%=mWidth%>%' ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">SRS Teacher Rating Detail Report-Faculty wise
</font></td></tr>
</TABLE>
 <table width=100% bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0>
<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
	rsi=db.getRowset(qry);
	while(rsi.next())
	{
		mInst=rsi.getString("IC");
	}
%>
<!*********Srs EventCode*************-->
<tr><td><FONT face=Arial size=2><STRONG>SRS Event</STRONG>&nbsp;&nbsp;&nbsp;</FONT>
<%
qry="select distinct nvl(SRSEVENTCODE,' ')SRSEVENTCODE from v#SRSEVENTS WHERE  NVL(FINALIZED,'N')='Y' and NVL(APPROVED,'N')='Y' and nvl(deactive,'N')='N' "; 
rsec=db.getRowset(qry);
%>
<select name=srsevent tabindex="0" id="srsevent" style="WIDTH: 130px">
<%
if(request.getParameter("srsevent")==null)
{

	while(rsec.next())
	{
	msrs=rsec.getString("SRSEVENTCODE");
%>
	<OPTION selected value=<%=msrs%>><%=msrs%></OPTION>
<%
	}

   }

 else
	{  

   	while(rsec.next())
	{
	msrs=rsec.getString("SRSEVENTCODE");
	if(msrs.equals(request.getParameter("srsevent").toString().trim()))
	{
   %>	
	<OPTION selected value=<%=msrs%>><%=msrs%></OPTION>
   <%			
	}
	else
	{
   %>
        <OPTION  value=<%=msrs%>><%=msrs%></OPTION>
   <%	
	 }
	}

   }
%>
</select>
<!--SUBJECT**************-->
<FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<STRONG>Subject</STRONG>&nbsp;&nbsp;&nbsp;</FONT></FONT>
<%
try
{
 	qry1="Select Distinct B.SubjectCode, B.Subject||' ('||B.SubjectCode||') ' Subj from v#SRSEVENTS B where nvl(B.FINALIZED,'N')='Y' and NVL(B.APPROVED,'N')='Y' AND nvl(B.deactive,'N')='N' ";
	qry1=qry1+" and b.subjectcode in (select distinct subjectcode from v#srseventsuggestion where Employeeid='"+mDMemberID+"' AND srseventcode=B.srseventcode and nvl(deactive,'N')='N') order by Subj";
//out.print(qry1);
	rss=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 340px">	
		<%   
		while(rss.next())
		{
			mSubj=rss.getString("SubjectCode");
			if(msubj.equals(""))
 			msubj=mSubj;
			%>
			<OPTION Value =<%=mSubj%>><%=rss.getString("Subj")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 340px">	
		<%
		while(rss.next())
		{
			mSubj=rss.getString("SubjectCode");
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rss.getString("Subj")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj%>><%=rss.getString("Subj")%></option>
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
</td></tr>
<tr><td>
<!--Faculty***********-->
<FONT color=black><FONT face=Arial size=2><STRONG>Faculty</STRONG>&nbsp;&nbsp;&nbsp;</FONT></FONT>
<%
try
{ 
%>
		<select name=Faculty id="Faculty" style="WIDTH: 250px">	
			<OPTION selected Value =<%=mDMemberID%>><%=mMemberName%></option>
		</select>
			
<%
 }    
catch(Exception e)
{
	out.println("");
}
String mT="";
if(request.getParameter("mCount")==null)
	mT="10";
else
	mT=request.getParameter("mCount").toString().trim();

%> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=black face=Arial size=2><strong>No.of Sugg. to be displayed&nbsp;</strong></FONT>
<INPUT Type="Text" size=3 Name=mCount id=mCount  Value=<%=mT%>>
&nbsp; &nbsp; 
<INPUT Type="submit" Value="Show">
</td></tr>
</table></form>
<table width=100% bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0 border=1 >
<tr bgcolor="#c00000" >
<td colspan=0><b><font color=white>Content</font></b></td>
<td><b><font color=white>Rating</font></b></td>
<td><b><font color=white>Min</font></b></td>
<td><b><font color=white>Max</font></b></td>
<td><b><font color=white>Count</font></b></td>
<td><b><font color=white>Sum</font></b></td>
</tr>
<%	
	if(request.getParameter("x")!=null)	
	{
	mSubj=request.getParameter("Subject").toString().trim();
	mFac=request.getParameter("Faculty").toString().trim();
	mSrsevent=request.getParameter("srsevent").toString().trim();
	//----------------------------
	// Outer most for report
	//----------------------------
	qry="select A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry=qry+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,nvl(C.EXCLUDINGREQUIRED,'N') EXCLUDINGREQUIRED,sum(A.RatingValue) RatingValue from V#SRSEVENTDETAIL A,SRSTYPEMASTER B,SRSSUBTYPEMASTER C";
	qry=qry+ " where A.SRSEVENTCODE='"+mSrsevent+"' AND A.SRSEVENTCODE=B.SRSEVENTCODE AND A.SRSEVENTCODE=C.SRSEVENTCODE  and A.SRSCODE=B.SRSCODE AND A.SRSSUBCODE=C.SRSSUBCODE AND A.SRSCODE=C.SRSCODE AND A.institutecode='"+mInst+"'";
	qry=qry+ " and A.Employeeid='"+mFac+"'";
	qry=qry+ " and A.subjectcode='"+mSubj+"' and nvl(A.naselected,'N')='N' ";
	qry=qry+" Group by A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry=qry+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,C.EXCLUDINGREQUIRED ORDER BY B.SEQID,C.SEQID ";
//	out.print(qry);
	rs=db.getRowset(qry);
	msno=0;
	ev1=0;
      rating1=0;
	String mSubheading="";
//---------------------------------------
// loop at question level,srscode,subcode
//---------------------------------------
	while(rs.next())
	{
		a=rs.getDouble("RatingValue");		
				
		if(x.equals(""))
			{
			%>
				<tr><td colspan=0><b><%=rs.getString("SRSSUBDESCRIPTION")%></b></td></tr>
			 
			<%
				x=rs.getString("SRSCODE");
				y=rs.getString("SRSSUBCODE");
			}		
//----------------------------
// printing for srs type
//------------------------------- 
	
		else if(!x.equals("") && !(x.equals(rs.getString("SRSCODE")))) 
			{
				avg=(rating1/ev1)*100;					
				%>  
				<tr><td colspan=0><b>Overall Average</b></td><td><%=gb.getRound(avg,2)%>%</td></tr>
				<%
				if(mExTot>0)
				{
				exavg=((rating1-mExTot)/(ev1-exev1))*100;			
				%>
				<tr><td colspan=0><b>Overall Average Excluding(<%=mSubheading%>)</b></td><td><%=gb.getRound(exavg,2)%>%</td></tr>

				<%
				}
				%>
			   <tr><td colspan=0><b><%=rs.getString("SRSSUBDESCRIPTION")%></b></td></tr>
			<%
				x=rs.getString("SRSCODE");
				y=rs.getString("SRSSUBCODE");
				rating1=0;
				rating=0;
				exavg=0;
				ev=0;
				avg=0;
				mExTot=0;
				exev1=0;
				msno=0;
				ev1=0;
				mSubheading="";
			} 	
		else if(!x.equals("") && !(y.equals(rs.getString("SRSSUBCODE"))))
			{
//---------------------------			
//Print only subtype heading
//---------------------------
				mSubhead=rs.getString("SRSSUBDESCRIPTION");
				if(mSubheading.equals(""))
					mSubheading=mSubhead.substring(0,10);
				else
					mSubheading=mSubheading+","+mSubhead.substring(0,10);
			%>
			   <tr><td colspan=0><b><%=rs.getString("SRSSUBDESCRIPTION")%></b></td></tr>
			<%
				x=rs.getString("SRSCODE");
				y=rs.getString("SRSSUBCODE");

			}

			msno++;
			qry="select  A.srsquestion,B.ratingcode,B.evaluationupto,B.evaluationfrom from srsquestionmaster A, srsratingmaster B where ";
			qry=qry+ " A.SRSEVENTCODE='"+mSrsevent+"' AND A.RATINGCODE=B.RATINGCODE AND NVL(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' AND A.srsquestioncode='"+rs.getString("srsquestioncode")+"' ";
			qry=qry+ " and A.srscode='"+rs.getString("srscode")+"' and A.srssubcode='"+rs.getString("srssubcode")+"' "; 
			rs2=db.getRowset(qry);
//-------------------------------
// Question description
//-------------------------------
			if(rs2.next())
			{	
				ev=rs2.getDouble("evaluationupto");
				ef=rs2.getDouble("evaluationfrom");
				qry="select sum(RatingValue) MaxValue,count(*) cnt from V#SRSEVENTDETAIL where ";
				qry=qry+ " EMPLOYEEID='"+mFac+"' and ";
				qry=qry+ " SRSEVENTCODE='"+mSrsevent+"' and ";
				qry=qry+ " SRSCODE='"+rs.getString("SRSCODE")+"' and ";
				qry=qry+ " SRSSUBCODE='"+rs.getString("SRSSUBCODE")+"' and ";
				qry=qry+ " SRSQUESTIONCODE='"+rs.getString("SRSQUESTIONCODE")+"' AND NVL(NASELECTED,'N')='N' ";
				rs3=db.getRowset(qry);
				//out.print(qry);
				if(rs3.next())
				{
				cnt1=rs3.getDouble("cnt");
				%>	
				<tr>
				<td ><%=msno%>.<%=rs2.getString("srsquestion")%></td> 
				<%

//---------------------------------------------
// calculate rating of individual question
//---------------------------------------------
				rating=a/cnt1;	
		            rating=gb.getRound(rating,2);
				rating1=rating1+rating ;
				
				ev1=ev1+ev;	
//---------------------------------------------
// for excluding required sub heading
//---------------------------------------------

				if (rs.getString("EXCLUDINGREQUIRED").equals("Y"))
				  {
					mExTot=mExTot+rating;
					mExTot=gb.getRound(mExTot,2);
					exev1=exev1+ev;
				  }

				%>
				<td><%=gb.getRound(rating,2)%></td>
				<td>&nbsp;<%=ef%></td>	
				<td><%=ev%></td>
				<td>&nbsp;<%=rs3.getString("cnt")%></td> 
				<td>&nbsp;<%=rs3.getString("MaxValue")%></td>
				</tr>
		<%		
			}
		 	}	
			  }
		//  closeing of outer loop
			if(rating1>0)
			{
				avg=(rating1/ev1)*100;					
				%>  
				<tr><td colspan=0><b>Overall Average</b></td><td><%=gb.getRound(avg,2)%>%</td></tr>
				<%
				if(mExTot>0)
				{
				exavg=((rating1-mExTot)/(ev1-exev1))*100;			
				
				%>
				<tr><td colspan=0><b>Overall Average Excluding(<%=mSubheading%>)</b></td><td><%=gb.getRound(exavg,2)%>%</td></tr>

				<%
				}	
 		
			}

	} // closing of request.getParameter("x")!=null
	%>
			</table>
			
	<%
	if (mT==null) mT="1";
	qry="select  suggestion from V#SRSEVENTSuggestion";
	qry=qry+ " where SRSEVENTCODE='"+mSrsevent+"'AND institutecode='"+mInst+"'";
	qry=qry+ " and Employeeid='"+mFac+"'";
	qry=qry+ " and subjectcode='"+mSubj+"' and nvl(isabusing,'N')='N' and nvl(deactive,'N')='N' and suggestion is not null";
	qry=qry+" and  rownum<="+mT+"  group by suggestion having suggestion is not null  ";
	rssu=db.getRowset(qry);
    %>
	<br><table border=1 rules=rows cellspacing=0 cellpadding=0 width=100%>
	<tr><td><b>Comments</b></td></tr>
   <%
	while(rssu.next())
	{
   %>
	<tr>
	<td><%=rssu.getString("suggestion")%></td></tr>
   <%		
	}
   %>
	</table>
   <% }
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
//	out.print(qry);
	}
%>
</body>
</html>
