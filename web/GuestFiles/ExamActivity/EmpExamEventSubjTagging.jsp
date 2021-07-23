<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
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
<TITLE>#### <%=mHead%> [ Examination Event/Sub Event Tagging ] </TITLE>


<script language=javascript>

function RefreshContents()
{ 		
	document.frm.x.value='ddd';
	document.frm.submit();
}
//-->		
function ChangeCombo(Event,DataCombo,SubEvent)
{
	removeAllOptions(SubEvent);
	var optn = document.createElement("OPTION");
			optn.text='No Sub-Event Required';
			optn.value='NONE';
		SubEvent.options.add(optn);
	for(i=0;i<DataCombo.options.length;i++)
      {
		var v1;
		var pos;
		var examevent;
		var subevent;
		var len;
		var v1=DataCombo.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		examevent=v1.substring(0,pos);
		subevent=v1.substring(pos+3,len);
		if (examevent==Event)
		{ 	
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=subevent;
			SubEvent.options.add(optn);
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
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script language=javascript>

function trim(str) 
{
 s = str.replace(/^(\s)*/, ''); 
 s = s.replace(/(\s)*$/, ''); 
 return s; 
} 

function validate()
{
  	var expw=trim(document.frm2.EXPWEIGHTAGE.value);
	var wtg=trim(document.frm2.WEIGHTAGE.value);
	var mmax=trim(document.frm2.MAXMARKS.value);
	if (expw=='')
		expw=0;
	if (wtg=='')
		wtg=0;
	if (mmax=='')
		mmax=0;

	if (isNaN(parseFloat(expw)) || isNaN(parseFloat(wtg)) || isNaN(parseFloat(mmax)))
      { 
		alert('Weightae and Maximum Marks must be Numeric');
		return false;
	}
	else
	{
		expw=parseFloat(expw);
		wtg=parseFloat(wtg);
		mmax=parseFloat(mmax);
		if (expw<1)
		{
			alert('You have allready taken Maximum allowed Weightage. No more weightage allowed for this Event/Sub Event'); 
			document.frm2.WEIGHTAGE.focus();
			return false;
		}
		 
		if (parseFloat(wtg)>parseFloat(expw) ||parseFloat(wtg)<1)
		{
			alert('Weightage must be between 1 and '+expw ); 
			document.frm2.WEIGHTAGE.focus();
			return false;
		}
		if(mmax<1)
		{
			alert('Maximum Marks must be >0'); 
			document.frm2.MAXMARKS.focus();
			return false;
		}
		return true;
		}
	}

//-->
 </script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mComp="",mDMemberID="";
String mExamID="",mexam="",mExamid="",meventcode="",mSubEventCode="",mEventCode="",mSubj="",msubj="";
String qry="",mDualMarks="",MOM="",Dt1="",Dt2="",mEventCode1="",mEE="",meventcode1="";
double mAllowedWeightage=0,MaxAW=100;
int msno=0, len=0, pos=0, ctr=0;
String mCurDate="", mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null;
String msubeven="",mMarks="",mPerc="",mName1="",mSem="",mMark="",mName2="",mName3="";
String mDate1="", mDate2="";
try
{
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

	qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";
	rs=db.getRowset(qry);
	if (rs.next())
		mCurDate=rs.getString(1);

	if (request.getParameter("x")!=null)
	{
		if(request.getParameter("TXT1")==null)
			mDate1="";
		else
			mDate1=request.getParameter("TXT1").toString().trim();

		if(request.getParameter("TXT2")==null)
			mDate2="";
		else
			mDate2=request.getParameter("TXT2").toString().trim();
	}
	else
	{
		mDate1=mCurDate;
		mDate2=mCurDate;
	}

	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberID=enc.decode(mMemberID);
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
		qry="Select WEBKIOSK.ShowLink('58','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
  //----------------------
			qry="Select distinct NVL(GRADEENTRYEXAMID,' ')Exam from COMPANYINSTITUTETAGGING Where InstituteCode='"+mInst+"' And CompanyCode='"+mComp+"'";
			rs=db.getRowset(qry);
			if(rs.next())
			{
				mExamid=rs.getString("Exam");
			}
			mDMemberCode=enc.decode(mMemberCode);
			mDMemberType=enc.decode(mMemberType);
			mDMemberID=enc.decode(mMemberID);
			%>
			<form name="frm" method="post" >
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Students <%=msubeven%>Exam Event/Sub Event Subject Tagging</B></TD>
			</font></td></tr>
			</TABLE>
			<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
			<tr><td colspan=2 align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Employee : &nbsp;</STRONG></font><font color=black face=arial size=2><%=mMemberName%>[<%=mDMemberCode%>]
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDept)%>
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesg)%>
			<hr></td></tr>
		<!--Institute****-->
			<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
			&nbsp; &nbsp;<select name=InstCode tabindex="0" id="InstCode">	
			<%
			try
			{ 
			 qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster WHERE INSTITUTECODE='"+mInst+"' and nvl(Deactive,'N')='N' ORDER BY InstCode";
			 rs=db.getRowset(qry);
			 if (request.getParameter("x")==null)
			 {
				while(rs.next())
				{
					mInst=rs.getString("InstCode");
					if(minst.equals(""))
					{
			 			minst=mInst;
						%>
						<OPTION selected Value =<%=mInst%>><%=mInst%></option>
						<%
					}
					else
					{
			 			minst=mInst;
						%>
						<OPTION Value =<%=mInst%>><%=mInst%></option>
						<%
					}
				}
			 }
			 else
			 {
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
			}
		     }
		     catch(Exception e)
		     {
			    //out.println(e.getMessage());
		     }
			%>
			</select>
			&nbsp; &nbsp;
			<a target=NEW href='EmpExamEventSubjCoordinator.jsp'><font  size=2 color=blue><b>Click to View My Batches</b></font></a>
			</td>
		<!--*********Exam**********-->
			<td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT> <select name=Exam tabindex="0" id="Exam">	
			<OPTION Value=<%=mExamid%>><%=mExamid%></option>
			</select>
			</td></tr>
		<!--*********Exam Event Code**********-->
			<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Event</STRONG></FONT></FONT>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name=Event tabindex="0" id="Event" onclick="ChangeCombo(Event.value,DataCombo,SubEvent);" onChange="ChangeCombo(Event.value,DataCombo,SubEvent);">	
			<%
			try
			{ 
			 qry="Select Distinct NVL(EXAMEVENTCODE,' ')EXAMEVENTCODE, EXAMEVENTDESC ||'('||EXAMEVENTCODE||')' ExamEvent from EXAMEVENTMASTER WHERE ExamCode='"+mExamid+"' and nvl(Deactive,'N')='N' ";
			 rs=db.getRowset(qry);

			 if (request.getParameter("x")==null)
			 {
				 while(rs.next())
				 {
					 mEventCode=rs.getString("EXAMEVENTCODE");
					 if(meventcode1.equals(""))
 					 {
						meventcode=mEventCode;
						meventcode1=mEventCode;
						%>
						<OPTION selected Value =<%=mEventCode%>><%=rs.getString("ExamEvent")%></option>
						<%			
					 }
					 else
					 {
						%>
						<OPTION Value =<%=mEventCode%>><%=rs.getString("ExamEvent")%></option>
						<%			
					 }
				}
			}
			else
			{
				while(rs.next())
				{
					mEventCode=rs.getString("EXAMEVENTCODE");
					if(mEventCode.equals(request.getParameter("Event")))
	 				{
						meventcode=mEventCode;
						meventcode1=mEventCode;
						%>
						<OPTION selected Value =<%=mEventCode%>><%=rs.getString("ExamEvent")%></option>
						<%
					}
					else
					{
						%>
						<OPTION Value =<%=mEventCode%>><%=rs.getString("ExamEvent")%></option>
						<%
					}
				}
			}
		     }    
		     catch(Exception e)
	     	     {
		    	//out.println(e.getMessage());
		     }
		     %>
	           </select>
		<!-- *****************DataCombo******************* -->
			<%
			try
			{
			 qry="Select Distinct NVL(SUBEVENTCODE,' ')EXAMEVENTCODE,nvl(EXAMEVENTCODE,' ')EXAMEVENT1, SUBEVENTDESC||'('||SUBEVENTCODE||')' ExamEvent from EXAMSUBEVENTMASTER WHERE ExamCode='"+mExamid+"' and nvl(Deactive,'N')='N' order by EXAMEVENT1 ";
			 rs=db.getRowset(qry);
			 %>
			 <select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH:0px">
			 <%
	
			 if (request.getParameter("x")==null)
			 {
				while(rs.next())
				{
					//System.out.print(qry);
					mEventCode=rs.getString("EXAMEVENTCODE");
 					mEventCode1=rs.getString("EXAMEVENT1");
	            	     	mEE=mEventCode1+"***"+mEventCode;
					%>
					<OPTION Value =<%=mEE%>><%=rs.getString("ExamEvent")%></option> 
					<%
				}
			 }
			 else
			 {
				while(rs.next())
				{
					mEventCode=rs.getString("EXAMEVENTCODE");
 					mEventCode1=rs.getString("EXAMEVENT1");
		                  mEE=mEventCode1+"***"+mEventCode;			
					if(mEventCode.equals(request.getParameter("DataCombo").toString().trim()))
	 				{
					%>
					 <OPTION selected Value =<%=mEE%>><%=rs.getString("ExamEvent")%></option> 
					<%			
					}
					else
					{
					%>
					 <OPTION Value =<%=mEE%>><%=rs.getString("ExamEvent")%></option> 
					<%			
					}
				}
			 }
			}
			catch(Exception e)
			{
			}
			%>
			<select>
			</td>
		<!-----------Exam Sub Event--------->
			<td><FONT color=black face=Arial size=2><STRONG>Sub-Event</STRONG>&nbsp;&nbsp;</FONT>
			<select name="SubEvent" tabindex="0" id="SubEvent">	
			<%
			try
			{ 
				qry="Select Distinct NVL(SUBEVENTCODE,' ')EXAMEVENTCODE, SUBEVENTDESC||'('||SUBEVENTCODE||')' ExamEvent ";
				qry=qry+" from EXAMSUBEVENTMASTER WHERE ExamCode='"+mExamid+"' and  ";
				qry=qry+" exameventcode='"+meventcode1+"' and  nvl(Deactive,'N')='N' ";
				rs=db.getRowset(qry);
				if (request.getParameter("SubEvent")==null)
				{
					%>
					<option value='NONE'>No Sub-Event Required</option>
					<%

					while(rs.next())
					{
						mEventCode=rs.getString("EXAMEVENTCODE");
						%>
						<OPTION Value =<%=mEventCode%>><%=rs.getString("ExamEvent")%></option>
						<%
					}
				}
				else
				{
					if(request.getParameter("SubEvent").toString().trim().equals("NONE"))
 					{
					%>
					<OPTION selected Value=NONE>No Sub-Event Required</option>
					<%			
					}
					else
 					{
					%>
					<OPTION Value =NONE>No Sub-Event Required</option>
					<%		
					}
					while(rs.next())
					{
						mEventCode=rs.getString("EXAMEVENTCODE");
						if(mEventCode.equals(request.getParameter("SubEvent").toString().trim()))
 						{
							meventcode=mEventCode;
							%>
							<OPTION selected Value =<%=mEventCode%>><%=rs.getString("ExamEvent")%></option>
							<%		
						}
						else
						{
							%>
							<OPTION Value =<%=mEventCode%>><%=rs.getString("ExamEvent")%></option>
							<%			
						}
					}
				}
			}
			catch(Exception e)
			{
			}
			%>
			</select>
			</td></tr>
		<!--********Subject*****-->
			<tr><td colspan=2>
			<%
			qry="Select distinct subject, subjectID From (";
		 	qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
			qry=qry+" subjectmaster B where (A.LTP='L' OR A.PROJECTSUBJECT='Y') and A.employeeid='"+mDMemberID+"' and A.examcode='"+mExamid+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
			qry=qry+" UNION";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where A.LTP='L' and A.COORDINATORID='"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.COORDINATORTYPE=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" MINUS";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where A.LTP='L' and A.EMPLOYEEID='"+mDMemberID+"' and A.COORDINATORID<>'"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mDMemberID+"')";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" )";
			rss=db.getRowset(qry);
			//out.print(qry);
			%>
			<FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
			&nbsp;&nbsp;&nbsp;<select name=Subject tabindex="0" id="Subject">	
			<%
			try
			{
				if (request.getParameter("x")==null) 
				{
					while(rss.next())
					{
						mSubj=rss.getString("SubjectID");
						if(msubj.equals(""))
			 			msubj=mSubj;
						%>
						<OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
						<%			
					}
				}
				else
				{
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
				}
			}
			catch(Exception e)
			{
				//out.print(qry);
			}
			%>
			</select>
			</td></tr>
			<tr>
			<td colspan=5><b>Dual Marks Entry System &nbsp; &nbsp; <select Name=DualEntry Id=DualEntry>
			<option>Yes</option>
			</select>
			</b>
                     &nbsp; &nbsp; &nbsp;
			<b>Mode of Marks Entry &nbsp; &nbsp; </b>
			<select Name=ModeOfEntry Id=ModOfEntry>
			<%
			if (request.getParameter("x")==null)
			{
				%>
				<option Value=M Selected>Marks Value</option>
				<option Value=P>Marks in % &nbsp; &nbsp; &nbsp; &nbsp; </option>
				<%
			}
			else
			{
				if(request.getParameter("ModeOfEntry").equals("M"))
				{
					%>
					<option Value=M Selected>Marks Value</option>
					<%
				}
				else
				{
					%>
					<option Value=M>Marks Value</option>	
					<%
				}
				if(request.getParameter("ModeOfEntry").equals("P"))
				{
					%>
					<option Value=P Selected>Marks in %</option>
					<%
				}
				else
				{
					%>
					<option Value=P>Marks in %</option>
					<%
				}
			}
			%>
			</select>
			&nbsp; &nbsp;
			<INPUT Type="submit" Value="&nbsp; OK &nbsp;">
			</td>
			</tr>
			<tr>
			<td colspan=2>
			<table width=100%>
			<tr><td colspan=2><UL><font color=red><li>All Fields are mandatory &amp; valid <b>Event Date</b> Format is <font color=darkgreen size=2>DD-MM-YYYY</font> only. <li>Once you tag a subject with any event/sub-event then Students of all Batches (taken Lecture by you) having same Exam Code and Subject will require Marks for the same event.<LI>Once Grade Calculation of a subject is finalized, further Marks entry/event creation will be restricted for the same subject.</font></td></tr> 
			</table>
			</td></tr>
			 </table></form>
			<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("Exam")!=null && request.getParameter("Event")!=null && request.getParameter("Subject")!=null )
				{
					mInst=request.getParameter("InstCode").toString().trim();
					mExamID=request.getParameter("Exam").toString().trim();
					mSubj=request.getParameter("Subject").toString().trim();
					mEventCode=request.getParameter("Event").toString().trim();
					mSubEventCode=request.getParameter("SubEvent").toString().trim();
					MOM=request.getParameter("ModeOfEntry").toString().trim();
					mDualMarks=request.getParameter("DualEntry").toString().trim();
					
					qry="select distinct nvl(A.studentid,' ')studentid,nvl(B.studentname,' ')studentname, ";
					double WEIGHTAGE=0,MAXMARKS=0,mW=0;

					String mEv="";
					if(mSubEventCode.equals("NONE"))
						mEv=mEventCode;
					else
						mEv=mEventCode+"#"+mSubEventCode;

				 	qry="select	to_char(EVENTFROM,'dd-mm-yyyy')MDF,to_char(EVENTUPTO,'dd-mm-yyyy')MDU from EXAMEVENTMASTER where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamID+"'";
					qry=qry+" and EXAMEVENTCODE='"+mEventCode+"' and nvl(Deactive,'N')='N'";
					rs=db.getRowset(qry);
					if(rs.next())
					{
						mDate1=rs.getString("MDF");
						mDate2=rs.getString("MDU");
					}

//*******************************************************************
					qry="Select distinct FSTID FROM (";
		 			qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
					qry=qry+" subjectmaster B where (A.LTP='L' OR A.PROJECTSUBJECT='Y') and A.employeeid='"+mDMemberID+"' and A.examcode='"+mExamid+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
					qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
					qry=qry+" UNION";
				 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
					qry=qry+" SUBJECTMASTER B where A.LTP='L' and A.COORDINATORID='"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.COORDINATORTYPE=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
					qry=qry+" MINUS";
				 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
					qry=qry+" SUBJECTMASTER B where A.LTP='L' and A.EMPLOYEEID='"+mDMemberID+"' and A.COORDINATORID<>'"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
					qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mDMemberID+"')";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
					qry=qry+" ) order by fstid";
					rss=db.getRowset(qry);
					//out.print(qry);
					%>
					<table align=center border=1 cellsapcing=0 cellpadding=0>
					<%
					String QryFSTID="";
					while(rss.next())
					{
						if(QryFSTID.equals(""))
							QryFSTID="'"+rss.getString(1)+"'";
						else
							QryFSTID=QryFSTID+",'"+rss.getString(1)+"'";
					}
					qry="select nvl(B.EMPLOYEENAME,' ')||' ('||EMPLOYEECODE||')' EMPNM, nvl(A.SECTIONBRANCH,' ')SECBR, nvl(A.SUBSECTIONCODE,' ')SUBSEC, nvl(A.SEMESTER,0)SEM";
					qry=qry+" FROM FACULTYSUBJECTTAGGING A, EMPLOYEEMASTER B WHERE A.EMPLOYEEID=B.EMPLOYEEID AND A.FSTID in ("+QryFSTID+")";
					qry=qry+" ORDER BY EMPNM, SECBR, SUBSEC";
					rs1=db.getRowset(qry);
					//out.print(qry);
					while(rs1.next())
					{
						%>
						<tr><td><font size=2><%=rs1.getString("EMPNM")%> : <%=rs1.getString("SECBR")%>-<%=rs1.getString("SUBSEC")%></b></font></td></tr>
						<%
					}
					//out.print(QryFSTID);
					%>
					</table>
					<%
//*******************************************************************
					// Find EventCode weightage
					qry="Select "+MaxAW+" Weightage from EXAMEVENTMASTER where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamID+"'";
					qry=qry+" and EXAMEVENTCODE='"+mEventCode+"' and nvl(Deactive,'N')='N'";
				 	 //out.print(qry);
					try
					{
						rs=db.getRowset(qry);	
						if (rs.next())
						{
							WEIGHTAGE=rs.getDouble("Weightage");
						}
					}
					catch(Exception e)
					{
					}

					// Find in Subject Event/Sub Event Tagging

					qry="Select nvl(A.EVENTSUBEVENT,' ') EVENTSUBEVENT,nvl(A.WEIGHTAGE,0) WEIGHTAGE  From V#EXAMEVENTSUBJECTTAGGING A ";
					qry=qry+" WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mExamID+"' AND A.SUBJECTID='"+mSubj+"' And (LTP='L' OR NVL(PROJECTSUBJECT,'N')='Y')";
					qry=qry+" and (A.EMPLOYEEID='"+mDMemberID+"' OR A.CORDFACULTYID='"+mDMemberID+"') Group By A.EVENTSUBEVENT, A.WEIGHTAGE ORDER BY EVENTSUBEVENT,nvl(A.WEIGHTAGE,0)";
					//out.print(qry);
					rs=db.getRowset(qry);
					mAllowedWeightage=0;
					while(rs.next())
					{
						mAllowedWeightage=mAllowedWeightage+rs.getDouble("WEIGHTAGE");
					}
					mAllowedWeightage=MaxAW-mAllowedWeightage;
		
					qry="Select nvl(sum(Weightage),0) Weightage from (select distinct EVENTSUBEVENT, nvl(Weightage,0) Weightage from V#EXAMEVENTSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamID+"'";
					qry=qry+" and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') AND EmployeeID='"+mDMemberID+"' and SubjectID='"+mSubj+"' and (LTP='L' OR NVL(PROJECTSUBJECT,'N')='Y'))";
					// out.println(qry);
					try
					{
						rs=db.getRowset(qry);
						mW=0;
						if (rs.next() && rs.getDouble("Weightage")>0)
						{
							mW=rs.getDouble("Weightage");
						}
						WEIGHTAGE=WEIGHTAGE-mW;
					}
					catch(Exception e)
					{
					}
					%>						
					<table align=center border=1 >
					<form name=frm2 action='EmpExamEventSubjTaggingAction.jsp' method=post onsubmit="return validate();">
					<tr><TD colspan=5><b>Event-Marks Entry From &nbsp; <input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>' readonly> to <input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10 readonly>
					</b></td></tr>
					<tr>
						
					<td colspan=5 align=left><b>Maximum Allowed Weightage: <%=mAllowedWeightage%> out of <%=MaxAW%></b></td></tr>
					<tr>
					<td><b>Weightage of Event (in %):<b></td><td><input  size=5 maxlength=11 Type=text name='WEIGHTAGE' id='WEIGHTAGE'></td>
					<td><b>Full Marks :<b></td><td><input size=5 maxlength=11  Type=text name='MAXMARKS' id='MAXMARKS'></td>
					<input Type=hidden value=<%=mInst%> Name=Inst ID=Inst>
					<input Type=hidden value=<%=mExamID%> Name=ExamCode ID=ExamCode>
					<input Type=hidden value=<%=mSubj%> Name=SubjectID ID=SubjectID>
				 	<input Type=hidden value=<%=mEv%> Name=EventSubEventCode ID=EventSubEventCode>
					<input Type=hidden value=<%=MOM%> Name='ModeOfEntry' ID='ModeOfEntry'>
					<input Type=hidden value=<%=mDualMarks%>Name=DualEntry ID=DualEntry>
					<input Type=hidden value=<%=WEIGHTAGE%> Name='EXPWEIGHTAGE' ID='EXPWEIGHTAGE'>
					<input Type=hidden value=<%=mDate1%> Name='Date1' ID='Date1'>
					<input Type=hidden value=<%=mDate2%> Name='Date2' ID='Date2'>
					<td><input Type=Submit value='Tagg Event/Sub-Event' Name=btn2 id=btn2></td>
					</tr>
					</form>
					</table>
					<%
				} // Mandatory Items cannot be null
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> All Items are mandatory</font> <br>");	
				}
			}
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
}
%>