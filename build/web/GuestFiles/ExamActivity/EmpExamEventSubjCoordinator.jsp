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
<TITLE>#### <%=mHead%> [ Faculty/Co-Ordinator wise Examination Event/Sub Event Tagging ] </TITLE>
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
<!--
function trim(str) 
{
 s = str.replace(/^(\s)*/, ''); 
 s = s.replace(/(\s)*$/, ''); 
 return s; 
} 
//-->
 </script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mComp="", mDMemberID="";
String mExamID="",mexam="",mExamid="",meventcode="",mSubEventCode="",mEventCode="",mSubj="",msubj="";
String qry="",qry1="",mDualMarks="",MOM="",Dt1="",Dt2="",mEventCode1="",mEE="",meventcode1="";
double mAllowedWeightage=0,MaxAW=100;
int msno=0, len=0, pos=0, ctr=0, mLeft=0, mRight=0;;
String mCurDate="";
String mExamsubevent="",mExamevent="", QryLTP="L";
ResultSet rs=null,rss=null,rs1=null,rs2=null;
String msubeven="",mMarks="",mPerc="",mName1="",mSem="",mMark="",mName2="",mName3="";
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
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Faculty/Co-Ordinator wise Examination Event/Sub Event Tagging View</B></TD>
			</font></td></tr>
			</TABLE>
			<form name="frm" method="post" >
			<input id="x" name="x" type=hidden>
			<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
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
			qry=qry+" subjectmaster B where (A.LTP='"+QryLTP+"' OR A.PROJECTSUBJECT='Y') and A.employeeid='"+mDMemberID+"' and A.examcode='"+mExamid+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
			qry=qry+" UNION";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where A.LTP='"+QryLTP+"' and A.COORDINATORID='"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.COORDINATORTYPE=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
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
			&nbsp;&nbsp;&nbsp;
			<INPUT Type="submit" Value="&nbsp; OK &nbsp;">
			</td>
			</tr>
			 </table></form>
			<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
			<tr bgcolor="#ff8c00"><TD align=center width=50%><Font Color=Black size=3 face=verdana><B>Self/Others Batch Pre Marks Entry By Me</B></font></td><TD align=center width=50%><Font Color=Black size=3 face=verdana><B>Self Batch Pre Marks Entry By Others</B></font></td></tr>

			<tr><TD valign=top>
			<table valign=top bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=0 align=center>
			<thead>
				<tr bgcolor="#ff8c00">
				<td ><font color="White"><b>Employee Name</b></font></td>
				<td ><font color="White"><b>Subject</b></font></td>
				<td ><font color="White"><b>Program</b></font></td>
				<td ><font color="White"><b>Sec/SubSec.</b></font></td>
				<td ><font color="White" title="Total Batch Strength"><b>Strength</b></font></td>
				</tr>
			</thead>
			<tbody>
			<%
			if(request.getParameter("x")!=null)
			{
			   try
			   {
				//String mLTP="";
				if(request.getParameter("Exam")!=null && request.getParameter("Event")!=null && request.getParameter("Subject")!=null )
				{	
					mInst=request.getParameter("InstCode").toString().trim();
					mExamID=request.getParameter("Exam").toString().trim();
					mSubj=request.getParameter("Subject").toString().trim();
					mEventCode=request.getParameter("Event").toString().trim();
					mSubEventCode=request.getParameter("SubEvent").toString().trim();
					//mLTP='"+QryLTP+"';
					qry="select distinct nvl(A.studentid,' ')studentid,nvl(B.studentname,' ')studentname, ";
					double WEIGHTAGE=0,MAXMARKS=0,mW=0;

					String mEv="";
					if(mSubEventCode.equals("NONE"))
						mEv=mEventCode;
					else
						mEv=mEventCode+"#"+mSubEventCode;


//*******************************************************************
					qry="Select distinct FSTID  FROM (";
		 			qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
					qry=qry+" subjectmaster B where (A.LTP='"+QryLTP+"' OR A.PROJECTSUBJECT='Y') and A.employeeid='"+mDMemberID+"' and A.examcode='"+mExamid+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
					qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
					qry=qry+" UNION";
				 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
					qry=qry+" SUBJECTMASTER B where A.LTP='"+QryLTP+"' and A.COORDINATORID='"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.COORDINATORTYPE=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
					qry=qry+" MINUS";
				 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
					qry=qry+" SUBJECTMASTER B where A.LTP='"+QryLTP+"' and A.EMPLOYEEID='"+mDMemberID+"' and A.COORDINATORID<>'"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
					qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mDMemberID+"')";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
					qry=qry+" ) order by fstid";
					rss=db.getRowset(qry);
					//out.print(qry);
				
					String QryFSTID="''";
					int Count=0;

					while(rss.next())
					{
						if(QryFSTID.equals(""))
							QryFSTID="'"+rss.getString(1)+"'";
						else
							QryFSTID=QryFSTID+",'"+rss.getString(1)+"'";
					}
					qry="select A.FSTID FSTID,nvl(B.EMPLOYEENAME,' ')||' ('||EMPLOYEECODE||')' EMPNM, nvl(PROGRAMCODE,' ')PCODE, nvl(A.SECTIONBRANCH,' ')SECBR, nvl(A.SUBSECTIONCODE,' ')SUBSEC, nvl(A.SEMESTER,0)SEM";
					qry=qry+" ,C.SUBJECT SUBJECT FROM FACULTYSUBJECTTAGGING A, EMPLOYEEMASTER B,SUBJECTMASTER C WHERE A.EMPLOYEEID=B.EMPLOYEEID AND A.SUBJECTID=C.SUBJECTID AND A.FSTID in ("+QryFSTID+")";
					qry=qry+" ORDER BY EMPNM, SECBR, SUBSEC";
					rs1=db.getRowset(qry);
					//out.print(qry);
					while(rs1.next())
					{
						mLeft++;
						qry1="select count(FSTID)COUNT1 from STUDENTLTPDETAIL where FSTID='"+rs1.getString("FSTID")+"' ";
						
						rs=db.getRowset(qry1);
						while(rs.next())
						{
							Count=rs.getInt("COUNT1");
							
						}
						%>
						<tr>
						<td><%=rs1.getString("EMPNM")%> </td>
						<td><%=rs1.getString("SUBJECT")%> </td>
						<td><%=rs1.getString("PCODE")%> </td>
						<td><%=rs1.getString("SECBR")%>-<%=rs1.getString("SUBSEC")%></td>
						<td align=center><%=Count%> </td>
						</tr>
						<%
					}
					//out.print(QryFSTID);
					%>
					</tbody>
					</table>
					</td>
					<td valign=top>
					<table valign=top bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=0 align=center>
					<thead>
						<tr bgcolor="#ff8c00">
						<td ><font color="White"><b>Employee Name</b></font></td>
						<td ><font color="White"><b>Subject</b></font></td>
						<td ><font color="White"><b>Program</b></font></td>
						<td ><font color="White"><b>Sec/SubSec.</b></font></td>
						<td ><font color="White" title="Total Batch Strength"><b>Strength</b></font></td>
					</tr>
					</thead>
					<tbody>
					<%
					qry=" select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
					qry=qry+" SUBJECTMASTER B where A.LTP='"+QryLTP+"' and A.EMPLOYEEID='"+mDMemberID+"' and A.COORDINATORID<>'"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
					qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mDMemberID+"')";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID";
					rs1=db.getRowset(qry);
					//out.print(qry);

					String QryFSTID1="''";
					int StdCount=0;
					while(rs1.next())
					{
						if(QryFSTID1.equals(""))
							QryFSTID1="'"+rs1.getString(1)+"'";
						else
							QryFSTID1=QryFSTID1+",'"+rs1.getString(1)+"'";
					}
					if(QryFSTID1.equals(""))
						QryFSTID1="''";
					qry1="select A.FSTID FSTID, nvl(B.EMPLOYEENAME,' ')||' ('||EMPLOYEECODE||')' EMPNM, nvl(PROGRAMCODE,' ')PCODE, nvl(A.SECTIONBRANCH,' ')SECBR, nvl(A.SUBSECTIONCODE,' ')SUBSEC, nvl(A.SEMESTER,0)SEM";
					qry1=qry1+" ,C.SUBJECT SUBJECT FROM V#EX#SUBJECTGRADECOORDINATOR  A, EMPLOYEEMASTER B,SUBJECTMASTER C WHERE A.COORDINATORID=B.EMPLOYEEID AND A.SUBJECTID=C.SUBJECTID AND A.FSTID in ("+QryFSTID1+")";
					qry1=qry1+" ORDER BY EMPNM, SECBR, SUBSEC";
					rs2=db.getRowset(qry1);
					//out.print(qry1);
										
					while(rs2.next())
					{
						mRight++;
						qry1="select count(FSTID)COUNT1 from STUDENTLTPDETAIL where FSTID ='"+rs2.getString("FSTID")+"' ";
						//out.print(qry1);
						rs=db.getRowset(qry1);
						while(rs.next())
						{
							StdCount=rs.getInt("COUNT1");
						}
						%>
						<tr>
						<td><%=rs2.getString("EMPNM")%> </td>
						<td><%=rs2.getString("SUBJECT")%> </td>
						<td><%=rs2.getString("PCODE")%> </td>
						<td><%=rs2.getString("SECBR")%>-<%=rs2.getString("SUBSEC")%></td>
						<td align=center><%=StdCount%> </td>
						</tr>
						<%
					}
					//out.print(QryFSTID);
					%>
					</tbody>
					</table>


					</td>
					</tr>
					<tr>
					<%
					if(mLeft>0)
					{
					%>
					<TD><Font Color=Green size=2 face=verdana><B>
					<ul><li>II-Level Marks & Pre-Marks Entry (Weightage) will be managed by you (<%=mMemberName%>[<%=mDMemberCode%>]) for above batches.
					<li>After completion of I-Level Marks Entry, II-Level Marks Entry & Publishing of Marks would be done by you (<%=mMemberName%>[<%=mDMemberCode%>]).
					<li>You (<%=mMemberName%>[<%=mDMemberCode%>] can enter your self batch I-Level Marks Entry subject to have batch(es) tought by you).
					</B></font>
					</td>
					<%
					}
					else
					{
						%><td>&nbsp;</td><%
					}
					if(mRight>0)
					{
					%>
					<td><Font Color=Green size=2 face=verdana><B>
					<ul><li>You (<%=mMemberName%>[<%=mDMemberCode%>]) can only enter Ist Level Marks Entry.
						<li>You (<%=mMemberName%>[<%=mDMemberCode%>]) can't maintain Weightage & Marks Entry of above Batches.
						<li>You (<%=mMemberName%>[<%=mDMemberCode%>]) can niether enter II-Level Marks Entry nor Publish the Marks. 
					</B></font>
					</td>
					<%
					}
					else
					{
						%><td>&nbsp;</td><%
					}
					%>
					</tr>
					<%
//*******************************************************************
					
				} // Mandatory Items cannot be null
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> All Items are mandatory</font> <br>");	
				}
			   } // End of Try
			   catch(Exception e)
			   {
				//out.print(e);
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