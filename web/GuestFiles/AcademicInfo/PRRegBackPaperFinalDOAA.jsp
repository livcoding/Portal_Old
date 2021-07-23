<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="";
String mfactype="";
int ctr=0;
int kk1=0;
int Data=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mExam="",mE="";
String mexam="";
String mName1="",mName2="",mName3="",mName4="",mName5="";
String mSubj="",mELECTIVECODE="";
String mSCode="",mSID="";


if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
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
<html>
<head>
<title>#### <%=mHead%> [ Elective Subject to be Run by DOAA ] </title>
<script LANGUAGE="JavaScript"> 
 function un_check()
{
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'allbox') && (e.type == 'checkbox')) 
{ 
e.checked = document.frm1.allbox.checked;
 } } }
 </SCRIPT>
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
		qry="Select WEBKIOSK.ShowLink('112','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
			qry=" SELECT distinct a.EXAMCODE from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and NVL(a.BACKLOGSUBJECTFINALIZED,'N')='N' and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
			qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
			qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
			qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
			rs= db.getRowset(qry);
			//out.print(qry);
			if(rs.next())
			{		
				%>
				<form name="frm" method="post" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Back Log Paper Approval/Finalization Entry [Pre Registration]</b>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>

				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>
				<tr>
				<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2>&nbsp; &nbsp;<STRONG>Exam Code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				try
				{
					qry=" SELECT distinct a.EXAMCODE exam from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and NVL(a.BACKLOGSUBJECTFINALIZED,'N')='N' and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
					qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
					qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
					qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
					rs=db.getRowset(qry);
					//out.print(qry);
					if (request.getParameter("x")==null) 
				 	{
						%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%   
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mExam.equals(""))
 							mexam=mExam;
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
							%>
						</select>
						<%
					}
					else
					{
						%>	
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mExam.equals(request.getParameter("Exam").toString().trim()))
				 			{
								mexam=mExam;
								%>
								<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
								<%			
						     	}
						     	else
						      {
								%>
							     	<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
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
				&nbsp; &nbsp;
				<INPUT Type="submit" Value="&nbsp;OK&nbsp;">&nbsp; &nbsp;</td></tr>
				</table>
				</form>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<form name="frm1" ID="frm1" Action="PRegBackPaperFinalAction.jsp" method=post>
				<tr bgcolor='#ff8c00'>
				 <th><font color="white">SNo.</font></th>
				 <th><font color="white">Subject</font></th>
				 <th><font color="white">Subject Type</font></th>
				 <th><b><font color="white" size=3><input onClick="un_check()" type="checkbox" id='allbox' name='allbox' value='Y'>&nbsp; Approve? &nbsp;</font></b></th>
				 <th><font color="white">Total Backlogger</font></th>
				</tr>
				<%
				if (request.getParameter("Exam")==null)
					mExam=mExam;
				else
					mExam=request.getParameter("Exam").toString().trim();
				if(mDMemberType.equals("E"))
					mfactype="I";	
				else if(mDMemberType.equals("V"))
					mfactype="E";

				qry="select Distinct NVL(A.Subject,' ') SUBJECT, nvl(A.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID";
				qry=qry+" from SUBJECTMASTER A, PR#STUDENTSUBJECTCHOICE B where A.INSTITUTECODE=B.INSTITUTECODE AND B.SEMESTERTYPE='RWJ'";
				qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and EXAMCODE='"+mExam+"'";
				qry=qry+" And (b.INSTITUTECODE,b.EXAMCODE) in (Select INSTITUTECODE, EXAMCODE from PREVENTMASTER D Where D.EXAMCODE='"+mExam+"' And nvl(BACKLOGSUBJECTFINALIZED,'N')='N' and nvl(DEACTIVE,'N')='N') ";
				qry=qry+" and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' ";
				qry=qry+" MINUS ";
				qry=qry+"((select Distinct NVL(A.Subject,' ') SUBJECT, nvl(B.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID from SUBJECTMASTER A, PROGRAMSUBJECTTAGGING B where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mExam+"' AND A.SUBJECTID=B.SUBJECTID) UNION";
				qry=qry+" (select Distinct NVL(A.Subject,' ') SUBJECT, nvl(B.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID from SUBJECTMASTER A, PR#ELECTIVESUBJECTS B where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mExam+"' AND A.SUBJECTID=B.SUBJECTID AND NVL(B.SUBJECTRUNNING,'N')='Y') UNION";
				qry=qry+" (select Distinct NVL(A.Subject,' ') SUBJECT, nvl(B.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID from SUBJECTMASTER A, FREEELECTIVE B where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mExam+"' AND A.SUBJECTID=B.SUBJECTID AND NVL(B.SUBJECTRUNNING,'N')='Y'))";
				qry=qry+" Order by Subject";
				//out.print(qry);
				rs2=db.getRowset(qry);
				while(rs2.next())
				{
				mSCode=rs2.getString("SC");
				mSID=rs2.getString("SID");

				qry="select Distinct NVL(A.Subject,' ') SUBJECT, nvl(A.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID, decode(B.SubjectType,'C','Core','E','Elective','F','Free Elective',' ') STYPE, nvl(B.ElectiveCode,' ') ElectiveCode, nvl(B.SUBJECTRUNNING,' ')SRUN, Count(distinct B.STUDENTID)TotBackLog";
				qry=qry+" from SUBJECTMASTER A, PR#STUDENTSUBJECTCHOICE B where A.INSTITUTECODE=B.INSTITUTECODE AND B.SEMESTERTYPE='RWJ'";
				qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and EXAMCODE='"+mExam+"' and B.SUBJECTID='"+mSID+"'";
				qry=qry+" And (b.INSTITUTECODE,b.EXAMCODE) in (Select INSTITUTECODE, EXAMCODE from PREVENTMASTER D Where D.EXAMCODE='"+mExam+"' And nvl(BACKLOGSUBJECTFINALIZED,'N')='N' and nvl(DEACTIVE,'N')='N') ";
				qry=qry+" and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' Group By A.Subject, B.SubjectCode, B.SubjectID, B.SubjectType, B.ElectiveCode, B.SUBJECTRUNNING Order by Subject";

				//out.print(qry);
				rs=db.getRowset(qry);
				%>
				<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
				<input type=hidden Name='ExamCode' ID='ExamCode' value='<%=mExam%>'>
				<%
				while(rs.next())
				{
					ctr++;
					if(rs.getString("STYPE").equals("Elective"))
						mELECTIVECODE=rs.getString("STYPE");
					else
						mELECTIVECODE=" ";
					mName1="checked_"+String.valueOf(ctr).trim();
					mName2="Subject_"+String.valueOf(ctr).trim();
					mName3="Elective_"+String.valueOf(ctr).trim();
					mName4="SubjectType_"+String.valueOf(ctr).trim();
					mName5="SID_"+String.valueOf(ctr).trim();
					%>
					<tr>
					<input type=hidden Name=<%=mName2%> ID=<%=mName2%> value='<%=mSCode%>'>
					<input type=hidden Name=<%=mName3%> ID=<%=mName3%> value='<%=mELECTIVECODE%>'>
					<input type=hidden Name=<%=mName4%> ID=<%=mName4%> value='<%=rs.getString("STYPE")%>'>
					<input type=hidden Name=<%=mName5%> ID=<%=mName5%> value='<%=mSID%>'>
					<td>&nbsp;<%=ctr%>.</td>
					<td nowrap><%=rs.getString("SUBJECT")%>&nbsp;(<%=mSCode%>)&nbsp;
					<td nowrap><%=rs.getString("STYPE")%>&nbsp;
					<%
					if(rs.getString("SRUN").equals("Y"))
					{
						%>
						<td nowrap align=left><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' checked value='Y'"></FONT>
						<font color=Green>Approved &nbsp; &nbsp;</font></td>
						<%
					}
					else
					{
						%>
						<td nowrap align=left><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' value='Y'"></FONT>
						<font color=red>Unapproved</font></td>
						<%
					}
					%>
					<td align=center><a Title="View Back Logger Detail" target=_New href='ViewSubjwiseBackloggers.jsp?EXAM=<%=mExam%>&amp;SUBJCODE=<%=mSCode%>&amp;STYPE=<%=rs.getString("STYPE")%>&amp;BACKFACFLAG=S'><%=rs.getString("TotBackLog")%></a></td>
					<%
  				}
				}
				%>				
				</tr>
				<tr><TD colspan=6><font color="blue" size=3><b>&nbsp; &nbsp; &nbsp; &nbsp; Freeze <u>Back Log Approval?</u> &nbsp;</b></font>
			      <INPUT id=ChkAllSudent type=radio name=ChkBackLog title='Lock Back Log Approval' value =Y><b>Yes</b>
			      &nbsp;<font color=red><b>/</b></font>&nbsp;
				<INPUT id=ChkBackLog title='Unlock Back Log Approval' type=radio checked value=N name=ChkBackLog><b>No</b></td></tr>

				<TR><TD colspan=6 ALIGN=CENTER><INPUT Type="submit" Value="Save"></TD><TD></TD></TR>
				<input type=hidden Name='TotalCount' ID='TotalCount' value='<%=ctr%>'>
				</form>
				</TABLE>
				<font size=2 color=green># You are recommended to approve all backloggers including Core, Elective and Free Elective before you Freeze the approval. Once you mark to 'Yes', you cann't change that entry!</font>
				<%
	  		}
			else
			{		
				%>
				<form name="frm"  method="get" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Back Log Paper Approval/Finalization Status [Pre Registration]</b>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>
				<tr>
				<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2>&nbsp; &nbsp;<STRONG>Exam Code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				try
				{
					qry=" SELECT distinct a.EXAMCODE exam from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and NVL(a.BACKLOGSUBJECTFINALIZED,'N')='Y' and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
					qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
					qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
					qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";

					rs=db.getRowset(qry);
					if (request.getParameter("x")==null) 
			 		{
						%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%   
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mExam.equals(""))
 							mexam=mExam;
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
							%>
						</select>
						<%
					}
					else
					{
						%>	
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mExam.equals(request.getParameter("Exam").toString().trim()))
				 			{
								mexam=mExam;
								%>
								<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
								<%			
						     	}
						     	else
						      {
								%>
						     		<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
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
				&nbsp; &nbsp;
				<INPUT Type="submit" Value="&nbsp;OK&nbsp;">&nbsp; &nbsp;</td></tr>
				</table>
				</form>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<form name="frm1" ID="frm1" method=post>
				<tr bgcolor='#e68a06'>
				 <th><font color="white">SNo.</font></th>
				 <th><font color="white">Subject</font></th>
				 <th><font color="white">Subject Type</font></th>
				 <th><font color="white">Status</font></th>
				 <th><font color="white">Total Backlogger</font></th>
				</tr>
				<%
					if (request.getParameter("Exam")==null)
						mExam=mExam;
					else
						mExam=request.getParameter("Exam").toString().trim();
					if(mDMemberType.equals("E"))
						 mfactype="I";	
					else if(mDMemberType.equals("V"))
						 mfactype="E";

				qry="select Distinct NVL(A.Subject,' ') SUBJECT, nvl(A.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID";
				qry=qry+" from SUBJECTMASTER A, PR#STUDENTSUBJECTCHOICE B where A.INSTITUTECODE=B.INSTITUTECODE AND B.SEMESTERTYPE='RWJ'";
				qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and EXAMCODE='"+mExam+"'";
				qry=qry+" And (b.INSTITUTECODE,b.EXAMCODE) in (Select INSTITUTECODE, EXAMCODE from PREVENTMASTER D Where D.EXAMCODE='"+mExam+"' And nvl(BACKLOGSUBJECTFINALIZED,'N')='Y' and nvl(DEACTIVE,'N')='N') ";
				qry=qry+" and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' ";
				qry=qry+" MINUS ";
				qry=qry+"((select Distinct NVL(A.Subject,' ') SUBJECT, nvl(A.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID from SUBJECTMASTER A, PROGRAMSUBJECTTAGGING B where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mExam+"' AND A.SUBJECTID=B.SUBJECTID) UNION";
				qry=qry+" (select Distinct NVL(A.Subject,' ') SUBJECT, nvl(A.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID from SUBJECTMASTER A, PR#ELECTIVESUBJECTS B where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mExam+"' AND A.SUBJECTID=B.SUBJECTID AND NVL(B.SUBJECTRUNNING,'N')='Y') UNION";
				qry=qry+" (select Distinct NVL(A.Subject,' ') SUBJECT, nvl(A.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID from SUBJECTMASTER A, FREEELECTIVE B where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mExam+"' AND A.SUBJECTID=B.SUBJECTID AND NVL(B.SUBJECTRUNNING,'N')='Y'))";
				qry=qry+" Order by Subject";
				//out.print(qry);
				rs2=db.getRowset(qry);
				while(rs2.next())
				{
				mSCode=rs2.getString("SC");
				mSID=rs2.getString("SID");

				qry="select Distinct NVL(A.Subject,' ') SUBJECT, nvl(A.SubjectCode,' ') SC, nvl(B.SubjectID,' ') SID, decode(B.SUBJECTTYPE,'C','Core','E','Elective','F','Free Elective',' ') STYPE, nvl(B.ElectiveCode,' ') ElectiveCode, nvl(B.SUBJECTRUNNING,' ')SRUN, Count(distinct B.STUDENTID)TotBackLog from SUBJECTMASTER A, ";
				qry=qry+" PR#STUDENTSUBJECTCHOICE B where A.INSTITUTECODE=B.INSTITUTECODE AND B.SEMESTERTYPE='RWJ'";
				qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and EXAMCODE='"+mExam+"' and B.SUBJECTID='"+mSID+"'";
				qry=qry+" And (b.INSTITUTECODE,b.EXAMCODE) in (Select INSTITUTECODE, EXAMCODE from PREVENTMASTER D Where D.EXAMCODE='"+mExam+"' And nvl(BACKLOGSUBJECTFINALIZED,'N')='Y' and nvl(DEACTIVE,'N')='N') ";
				qry=qry+" and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' Group By A.Subject, B.SubjectCode, B.SubjectID, B.SUBJECTTYPE, B.ElectiveCode, B.SUBJECTRUNNING Order by Subject";

				//out.print(qry);
				rs=db.getRowset(qry);
				while(rs.next())

				{ 
					ctr++;
						mELECTIVECODE=" ";
					mName1="checked_"+String.valueOf(ctr).trim();
					mName2="Subject_"+String.valueOf(ctr).trim();
					mName3="Elective_"+String.valueOf(ctr).trim();
					%>
					<tr>
					<td>&nbsp;<%=ctr%>.</td>
					<td nowrap><%=rs.getString("SUBJECT")%>&nbsp;(<%=mSCode%>)&nbsp;
					<td><%=rs.getString("STYPE")%>&nbsp;
					<%
					if(rs.getString("SRUN").equals("Y"))
					{
						%>
						<td align=left nowrap><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' disabled checked value='Y'"></FONT>
						<font color=green>Approved</font></td>
						<%
					}
					else
					{
						%>
						<td nowrap align=left nowrap><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' disabled value='Y'"></FONT>
						<font color=red>Unapproved</font></td>
						<%
					}
					%>
					<td align=center><a Title="View Back Logger Detail" target=_New href='ViewSubjwiseBackloggers.jsp?EXAM=<%=mExam%>&amp;SUBJCODE=<%=mSCode%>&amp;SUBJID=<%=mSID%>&amp;STYPE=<%=rs.getString("STYPE")%>&amp;BACKFACFLAG=S'><%=rs.getString("TotBackLog")%></a></td>
					<%
				}
				}
				%>				
				</tr>
				<tr><TD colspan=6><font color="blue" size=3><b>&nbsp; &nbsp; &nbsp; &nbsp; <u>Back Log Approval</u> Status :&nbsp;</b></font><font color="RED" size=3><b>&nbsp; &nbsp; &nbsp; &nbsp; Locked</b></font></td></tr>
				</form>
				</TABLE>
				<font size=2 color=green># Back Logger's Approval has been Freezed. Now you cann't change any approval entry.</font><br>
				<font size=2 color=green># Now the respective students can see their approval status.</font>
				<%
	  		}

/*		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
		 <%
		}*/

		 //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------
		}
	 	else
   		{
   		%>
		<br>
		<font color=red>
		<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
	//out.print(qry);
}
%>
</body>
</html>