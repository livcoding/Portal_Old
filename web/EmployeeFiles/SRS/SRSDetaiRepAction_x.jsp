<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

String x="",y="",mT="",myLTP="";
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
String mInst="",mAcad="",mSubj="",msubj="",mSubjID="",mFacultyID="",mFaculty="",mfaculty="",mSubhead="";
int mSem=0;
String mFac="",mexam="",mExam="",msrs="";
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="",mDMemberID="";
String mMemberName="",mDMemberType="";
String mWebEmail="",LTP="";
String mSrsevent="";
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
   mHead="TIET ";


%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey detailed report ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
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
	mDMemberType=enc.decode(mMemberType);
if(!mMemberID.equals("") && !mDMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
	mDMemberCode=enc.decode(mMemberCode);
	mDMemberID=enc.decode(mMemberID);

	

if (request.getParameter("Width")!=null)
	mWidth=request.getParameter("Width").toString().trim();
else
	mWidth="100";
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width='<%=mWidth%>%' ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">SRS Teacher Rating Detail Report</font></td></tr>
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
</table></form>
<%
  mSubjID=request.getParameter("SubjectID").toString().trim();
  mSubj=request.getParameter("Subject").toString().trim();
	myLTP=request.getParameter("LTP").toString().trim();
	mFac=request.getParameter("Faculty").toString().trim();
	mSrsevent=request.getParameter("srsevent").toString().trim();
	mT=request.getParameter("mT").toString().trim();
	String mSize=request.getParameter("mSize").toString().trim();
	qry="select WEBKIOSK.getMemberName('"+mFac+"','E') from Dual";
	rs=db.getRowset(qry);
	String mFacltyNM="";
if (rs.next())
{
	mFacltyNM=rs.getString(1);
}

	%>
<b>
&nbsp;&nbsp; Faculty Name:&nbsp;<%=mFacltyNM%>
&nbsp;&nbsp; &nbsp; Subject :&nbsp;<%=mSubj%> ( <%=GlobalFunctions.getLTPDescWSQ(myLTP)%>)
&nbsp;&nbsp; &nbsp; No. of Students :&nbsp;<%=mSize%><br>
&nbsp;&nbsp; Lower Rating ---> Highest Rating<br>
&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;1&nbsp; &nbsp; &nbsp;2 &nbsp; &nbsp; &nbsp;3 &nbsp; &nbsp; &nbsp;4 &nbsp; &nbsp; &nbsp;5

</b>
<br>

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
	//if(request.getParameter("x")!=null)	
	//{
	
	
	//----------------------------
	// Outer most for report
	//----------------------------
	qry="select A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry=qry+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,nvl(C.EXCLUDINGREQUIRED,'N') EXCLUDINGREQUIRED,sum(A.RatingValue) RatingValue from V#SRSEVENTDETAIL A,SRSTYPEMASTER B,SRSSUBTYPEMASTER C";
	qry=qry+ " where A.SRSEVENTCODE='"+mSrsevent+"' AND A.SRSEVENTCODE=B.SRSEVENTCODE AND A.SRSEVENTCODE=C.SRSEVENTCODE  and A.SRSCODE=B.SRSCODE AND A.SRSSUBCODE=C.SRSSUBCODE AND A.SRSCODE=C.SRSCODE AND A.institutecode='"+mInst+"'";
	qry=qry+ " and A.Employeeid='"+mFac+"' and '"+myLTP+"' like '%'||A.LTP||'%' ";
	qry=qry+ " and A.subjectID='"+mSubjID+"' and nvl(A.naselected,'N')='N' ";
	qry=qry+" and nvl(APPROVED,'N')='Y' and nvl(FINALIZED,'N')='Y' ";
	qry=qry+" Group by A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry=qry+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,C.EXCLUDINGREQUIRED ORDER BY B.SEQID,C.SEQID ";
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
				qry=qry+ " EMPLOYEEID='"+mFac+"' and '"+myLTP+"' like '%'||LTP||'%'  and ";
				qry=qry+ " SRSEVENTCODE='"+mSrsevent+"' and ";
				qry=qry+ " SRSCODE='"+rs.getString("SRSCODE")+"' and ";
				qry=qry+ " SRSSUBCODE='"+rs.getString("SRSSUBCODE")+"' and ";
				qry=qry+ " SRSQUESTIONCODE='"+rs.getString("SRSQUESTIONCODE")+"' AND NVL(NASELECTED,'N')='N' ";
				qry=qry+"  and institutecode='"+mInst+"' and subjectID='"+mSubjID+"' ";
				qry=qry+" and nvl(APPROVED,'N')='Y' and nvl(FINALIZED,'N')='Y' ";
				rs3=db.getRowset(qry);
				
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

//	} // closing of request.getParameter("x")!=null
	%>
			</table>
			
	<%
	if (mT==null) mT="1";
	qry="select  suggestion from V#SRSEVENTSuggestion";
	qry=qry+ " where SRSEVENTCODE='"+mSrsevent+"'AND institutecode='"+mInst+"'";
	qry=qry+ " and Employeeid='"+mFac+"'";
	qry=qry+ " and subjectID='"+mSubjID+"' and nvl(isabusing,'N')='N' and nvl(deactive,'N')='N' and suggestion is not null";
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
   <%
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

