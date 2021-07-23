<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String x="",y="";
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null,rsec=null,rss=null,rsi=null,rsc=null,RsChk1=null;
String mWidth="100";
int kk=0,mSNo=0;
String qry="";
String qry1="";
String mInst="",mAcad="",mFacultyID="",mFaculty="",mfaculty="",mSubhead="";
String mFac="",mexam="",mExam="",msrs="";
String mMemberID="";
String mMemberType="";
String mMemberCode="",LTP="";
String mDMemberCode="",mDMemberID="";
String mMemberName="",mDMemberType="";
String mWebEmail="";
String mSrsevent="";
int msno=0;
String mSRSCont="",mDate1="",mDate2="",mEventCode="",mEmployee="";
String mLTP="",myLTP="",mSubj="",mT="",srsevent="",Faculty="",Subject="",date="";
long Ltot=0,Ptot=0,Ttot=0;
String mLtot="",mPtot="",mTtot="",msent="";
String mS="";

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
<TITLE>#### <%=mHead%> [DateWise Student Reaction Survey detailed report ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


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
try{
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
	
	qry="Select WEBKIOSK.ShowLink('77','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);

 	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {

	if(request.getParameter("Width")!=null)
		mWidth=request.getParameter("Width").toString().trim();
	else
		mWidth="100";
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width='<%=mWidth%>%' ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"> DateWise SRS Rating Detail Report
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
qry="select distinct nvl(SRSEVENTCODE,' ')SRSEVENTCODE,entrydate from srseventmaster where srseventcode in ( ";
qry=qry+" select distinct nvl(SRSEVENTCODE,' ')SRSEVENTCODE from v#SRSEVENTS WHERE  NVL(FINALIZED,'N')='Y' and NVL(APPROVED,'N')='Y' and nvl(deactive,'N')='N' ) order by entrydate desc "; 

//qry="select distinct nvl(SRSEVENTCODE,' ')SRSEVENTCODE,eventfrom from v#SRSEVENTS WHERE  NVL(FINALIZED,'N')='Y' and NVL(APPROVED,'N')='Y' and nvl(deactive,'N')='N' order by eventfrom desc "; 
rsec=db.getRowset(qry);
%>
<select name=srsevent tabindex="0" id="srsevent" style="WIDTH: 150px">
<%
if(request.getParameter("srsevent")==null)
{

	while(rsec.next())
	{
	msrs=rsec.getString("SRSEVENTCODE");
	if(mS.equals(""))
		{
		mS=msrs;
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
<!--Faculty***********-->
 <td colspan=0><FONT color=black><FONT face=Arial size=2><STRONG>Faculty</STRONG></FONT>&nbsp; </FONT>
<%
try
{ 
	qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(EMPLOYEENAME,' ') EMPLOYEENAME from v#SRSEvents A";
	qry=qry +" Where NVL(A.FINALIZED,'N')='Y' and NVL(A.APPROVED,'N')='Y' and nvl(A.deactive,'N')='N'  order by EMPLOYEENAME ";
 // qry=qry +" Where NVL(A.FINALIZED,'N')='Y' and NVL(A.APPROVED,'N')='Y' and nvl(A.deactive,'N')='N' and A.employeeid in (select distinct employeeid from v#srseventsuggestion where srseventcode=A.srseventcode  and nvl(deactive,'N')='N') order by EMPLOYEENAME ";

	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 245px">	
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
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 245px">	
		<%
		
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
		</td>
		</tr>
	  	<%
	 }
 }    
catch(Exception e)
{
	out.println(e.getMessage());
} 
%>
<tr><TD colspan=3><b>SRS Events From &nbsp; <input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> to <input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10 >
</b>
<%	
if(request.getParameter("mCount")==null)
	mT="10";
else
	mT=request.getParameter("mCount").toString().trim();

%> 
<FONT color=black face=Arial size=2><strong>No.of Sugg. to be displayed&nbsp;</strong></FONT>
<INPUT Type="Text" size=3 Name=mCount id=mCount  Value=<%=mT%>>
&nbsp; &nbsp; 
<INPUT Type="submit" Value="&nbsp;OK&nbsp;"></td></tr></table></form>
<table class="sort-table" id="table-1"  width=100% bottommargin=0 rules=groups topmargin=0 cellspacing=1 cellpadding=0 border=1 >
<thead>
<tr bgcolor="#ff8c00">
<td Title="Click here to sort Table Data on SNO"><b><font color=white>SNo.</font></b></td>
<td Title="Click here to sort Table Data on Sbject"><b><font color=white>Subject</font></b></td>
<td Title="Click here to sort Table Data on LTP"><b><font color=white>LTP</font></b></td>
<td colspan=3 align=center Title="Click here to sort Table Data on Student Strength"><b><font color="white">Responded</font></b></td>
<td Title="Click here to sort Table Data on SRS Event Date"><b><font color=white>EventDate</font></b></td>
</tr>
<tr bgcolor="#ff8c00">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td><b><font color=white>L</font></b></td> 
<td><b><font color=white>T</font></b></td> 
<td><b><font color=white>P</font></b></td> 
<td>&nbsp;</td>
</tr>

</thead>
<tbody>
<%
if(request.getParameter("x")!=null)
	{
if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
	mDate1="**";
else
	mDate1=request.getParameter("TXT1").toString().trim();
	
if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals(""))
	mDate2="**";
else
	mDate2=request.getParameter("TXT2").toString().trim();
	

	
if ((mDate1.equals("**") || GlobalFunctions.iSValidDate(mDate1)==true )&& (mDate2.equals("**") || GlobalFunctions.iSValidDate(mDate2)))
		{	
			/*
			qry="Select WEBKIOSK.IsValidDateRange(to_date('"+ mDate1+"','dd-mm-yyyy'),to_date('"+mDate2+"','dd-mm-yyyy')) SL from dual";
			

			RsChk1= db.getRowset(qry);
			if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   	{
 				*/
				
			mEventCode=request.getParameter("srsevent").toString().trim();
			mEmployee=request.getParameter("Faculty").toString().trim();
							 
			qry1="Select distinct subjectid, subjectcode, B.Subject||' ('||B.SubjectCode||') ' Subj,NVL(B.LTP,' ')LTP ,";
			qry1=qry1 + " to_char(B.ENTRYDATE,'dd-mm-yyyy') EntryDate,DECODE(B.LTP,'L',1,'T',2,'P',3)SNO,count(distinct B.StudentID) CNTSID From v#srseventsuggestion B where B.Employeeid='"+mEmployee+"' ";
			qry1=qry1+" and B.institutecode='"+mInst+"' and B.facultytype=decode('"+mDMemberType+"','E','I','E') ";
			qry1=qry1 + " And B.srseventcode='"+mEventCode+"' and Nvl(B.deactive,'N')='N' ";
			qry1=qry1+" and trunc(B.EntryDate) between decode('"+mDate1+"','**',trunc(B.EntryDate),to_Date('"+mDate1+"','dd-mm-yyyy')) and decode('"+mDate2+"','**',trunc(B.EntryDate),to_Date('"+mDate2+"','dd-mm-yyyy')) ";
			qry1=qry1+"  And B.FSTID in (Select  A.FSTID from v#SRSEVENTS A where nvl(A.FINALIZED,'N')='Y' and NVL(A.APPROVED,'N')='Y' AND nvl(A.deactive,'N')='N') ";
			qry1=qry1+" group by B.subjectid, B.subjectcode ,B.SUBJECT ,to_char(B.ENTRYDATE,'dd-mm-yyyy'),LTP ";
			qry1=qry1+" order by to_char(B.ENTRYDATE,'dd-mm-yyyy') ,Subj,SNO  ";
			rss=db.getRowset(qry1);
		// out.print(qry1);
		
		mSNo=0;
		mLTP="";
		myLTP="";
			 Ltot=0;
		Ttot=0;
		Ptot=0;
		String mOldSubj="",mOldDate="",mOldSubjCode="", mOldSubjID="";
		int	mOldCount=0;
		while(rss.next())
		{
			if (mLTP.equals(""))	
			{
				mLTP="'"+rss.getString("LTP")+"'" ;
				myLTP=rss.getString("LTP");
				mOldSubj=rss.getString("Subj");
			//	mOldCount=rss.getInt("CNTSID");
				mOldDate=rss.getString("EntryDate");
				mOldSubjID=rss.getString("SubjectId");
				mOldSubjCode=rss.getString("SubjectCode");
				if(rss.getString("LTP").equals("L"))
					Ltot=rss.getLong("CNTSID");
				else if(rss.getString("LTP").equals("T"))
					Ttot=rss.getLong("CNTSID");
				else if(rss.getString("LTP").equals("P"))
					Ptot=rss.getLong("CNTSID");

			}
			else if(mOldDate.equals(rss.getString("EntryDate")) && mOldSubj.equals(rss.getString("Subj")))
	   		{
				 mLTP=mLTP+",'"+rss.getString("LTP")+"'" ; 		
				 myLTP=myLTP+rss.getString("LTP");
				if(rss.getString("LTP").equals("L"))
				Ltot=rss.getLong("CNTSID");
			else if(rss.getString("LTP").equals("T"))
				Ttot=rss.getLong("CNTSID");
			else if(rss.getString("LTP").equals("P"))
				Ptot=rss.getLong("CNTSID");

			}
			else
			{
			mSNo++;
if(Ltot>0)
			{
			msent="L="+Ltot;
			mLtot=String.valueOf(Ltot);
			}
			else
			mLtot="";
			if(Ttot>0)
			{
			msent=msent+" T="+Ttot;
			mTtot=String.valueOf(Ttot);
			}
			else
			mTtot="";
			if(Ptot>0)
			{
			msent=msent+" P="+Ptot;
			mPtot=String.valueOf(Ptot);
			}
			else
			mPtot="";

			%>

			<tr>
            	<td><%=mSNo%></td>	
			<td><a href="DatewiseSRSAction.jsp?SubjectID=<%=mOldSubjID%>&amp;Subject=<%=mOldSubjCode%>&amp;LTP=<%=myLTP%>&amp;Faculty=<%=mEmployee%>&amp;srsevent=<%=mEventCode%>&amp;mInst=<%=mInst%>&amp;mT=<%=mT%>&amp;date=<%=mOldDate%>&amp;mSize=<%=msent%>" target=_Blank><%=mOldSubj%></a></td>				
			<td><%=mLTP%></td>	
			<td><%=mLtot%></td>	
			<td><%=mTtot%></td>
			<td><%=mPtot%></td> 

			<td><%=mOldDate%></td>
			</tr>
            	<%	
					Ltot=0;
				Ptot=0;
				Ttot=0;
				if(rss.getString("LTP").equals("L"))
					Ltot=rss.getLong("CNTSID");
				else if(rss.getString("LTP").equals("T"))
					Ttot=rss.getLong("CNTSID");
				else if(rss.getString("LTP").equals("P"))
					Ptot=rss.getLong("CNTSID");
						
				mLTP="'"+rss.getString("LTP")+"'" ;
				myLTP=rss.getString("LTP");
				mOldSubj=rss.getString("Subj");
				mOldCount=rss.getInt("CNTSID");
				mOldDate=rss.getString("EntryDate");
				mOldSubjID=rss.getString("SubjectID");
				mOldSubjCode=rss.getString("SubjectCode");
				msent="";
			}
		}


		if(!mOldSubj.equals(""))
			{		
			mSNo++;
			if(Ltot>0)
			{
			msent="L="+Ltot;
			mLtot=String.valueOf(Ltot);
			}
			else
			mLtot="";
			if(Ttot>0)
			{
			msent=msent+" T="+Ttot;
			mTtot=String.valueOf(Ttot);
			}
			else
			mTtot="";
			if(Ptot>0)
			{
			msent=msent+" P="+Ptot;
			mPtot=String.valueOf(Ptot);
			}
			else
			mPtot="";

			%>
			<tr>
            	<td><%=mSNo%></td>	
			<td><a href="DatewiseSRSAction.jsp?Subject=<%=mOldSubjCode%>&amp;LTP=<%=myLTP%>&amp;Faculty=<%=mEmployee%>&amp;srsevent=<%=mEventCode%>&amp;mInst=<%=mInst%>&amp;mT=<%=mT%>&amp;date=<%=mOldDate%>&amp;mSize=<%=msent%>" target=_New><%=mOldSubj%></a></td>	
			<td><%=mLTP%></td>	
			<td><%=mLtot%></td>	
			<td><%=mTtot%></td>
			<td><%=mPtot%></td> 

			<td><%=mOldDate%></td>
			</tr>
			<%
			}

		%>
		</tbody>
		</table>

		<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","Date"]);
		</script>



		<%	
		/*
		}
		else
		{
			out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Date Range </font> <br>");

		}
		*/
		}	// Validate Date
		else
		{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Valid Date Format is DD-MM-YYYY only</font> <br>");
		}
		}  //*************** closing of (request.getParameter("x")!=null)
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


}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
// out.print("error"+qry1);
}      
%>
</body>
</html>







