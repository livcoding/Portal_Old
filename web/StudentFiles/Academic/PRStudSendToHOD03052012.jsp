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
<TITLE>#### <%=mHead%> [ Pre-Registration Choice Send to HOD ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

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

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mComp="", mInst="";
int msno=0,msno1=0;
String mSem="";
int mSemPlusOne=0;
String mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mName="";
String mEmployeeID="";
String mSUBJECTID="",mE="",msg="";
String mEName="",mSemtype="",mSubtype="",mCurPRCode="",mPreEvent="",mSentToHOD="";
ResultSet rs=null,rs1=null;

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
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";

}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
	mSemPlusOne=(Integer.parseInt(mSem))+1;
}

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}

try 
{  //1
	if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{  //2
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('52','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
  //----------------------
			try
			{	
				mDMemberCode=enc.decode(mMemberCode);
				mMemberID=enc.decode(mMemberID);
				mMemberType=enc.decode(mMemberType);
			}
			catch(Exception e)
			{
				//out.println(e.getMessage());
			}
			qry=" select 'y' from ";
			qry=qry +" StudentMaster where StudentID='" +mMemberID+ "' and  InstituteCode='" + mInst+ "' and ";
			qry=qry+" STUDENTID=(SELECT MemberID FROM PREVENTS WHERE INSTITUTECODE='"+ mInst+"' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst+"'";
			qry=qry+" and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
			qry=qry+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='S' and MEMBERID='"+mMemberID+"'";
			qry=qry+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N')";
			rs=db.getRowset(qry);
			if(rs.next())
			{
				qry1= " Select 'y', PREVENTCODE from PREVENTS WHERE INSTITUTECODE='"+ mInst+"' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst+"'";
				qry1=qry1+ " and NVL(APPROVED,'N')='N' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
				qry1=qry1+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='S' and MEMBERID='"+mMemberID+"'";
				qry1=qry1+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N'";
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{		
					mCurPRCode=rs1.getString("PREVENTCODE");
					qry="select nvl(SENDTOHOD,' ') SENDTOHOD  from PREVENTS where PREVENTCODE='"+mCurPRCode+"'and MEMBERTYPE='"+mChkMType+"' and MEMBERID='"+mChkMemID+"'";
					rs=db.getRowset(qry);
					while(rs.next())
					{
						mSentToHOD=rs.getString("SENDTOHOD");
					}
					%>
					<table width=100% rules=groups cellspacing=1 cellpadding=1 align=center border=1>
					<form name="frm1" method=post>
					<input id="x" name="x" type=hidden>
					<tr bgcolor="#ff8c00">
					<td colspan=3 align=center><b><font color=white>PRE REGISTRATION SUBJECT CHOICE</font></B></td>
					</tr>

					<tr><td>&nbsp;<font color=black face=arial size=2><STRONG> Name:&nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mName)%> [<%=mDMemberCode%>]</td>
					<td><font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><%=mProg%> [<%=mBranch%>]</td>
					<td><font color=black face=arial size=2><STRONG>Pre Reg. for Semester:&nbsp;</STRONG></font><%=mSemPlusOne%></td></tr>

					<tr><td colspan=3 align=center>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
					<%
					qry="select nvl(PREREGEXAMID,' ') examcode from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mInst+"'";
					rs=db.getRowset(qry);
					%>
					<select name=exam tabindex="0" id="exam" style="WIDTH: 140px">	
					<%
				  	if(request.getParameter("x")==null)
					{
						while(rs.next())
						{
							mexamcode=rs.getString("examcode");
							mE=mexamcode;
							%>
							<option selected value=<%=mexamcode%>><%=mexamcode%></option>
							<%
						}
					}
					else
					{
						while(rs.next())
						{
							mexamcode=rs.getString("examcode");	
							mE=mexamcode;
							if(mexamcode.equals(request.getParameter("exam").toString().trim()))
							{	
							%>
							    <option selected value=<%=mexamcode%>><%=mexamcode%></option>
							<%
						}
						else
						{
							%>
							<option  value=<%=mexamcode%>><%=mexamcode%></option>
							<%
						}
					}
				}
				%>
				</select>
				&nbsp; &nbsp; &nbsp; &nbsp;
				<input type="submit" value="Show"></td></tr>
				</table></form>
				<form name="frm1" method="post" action="PRStudSendToHODAction.jsp">
				<table width=100%><tr><td><center><font color="#00008b" face="Verdana" size=2><b>List of Subject-Choice for Regular Semester</b></font></center></td></tr></table>
				<table bgcolor=#fce9c5 width=98% class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
				<thead>
				<tr bgcolor="#ff8c00">
				  <td><b><font color=white>SNo.</font></b></td>
				  <td><b><font color=white>Subject</font></b></td>
				  <td><b><font color=white>Subject Type</font></b></td>	
				  <td align=center><b><font color=white>Choice</font></b></td>
				  <td align=center><b><font color=white>Sent to HOD?&nbsp;</font></b></td>
				</tr>
				</thead>
				<tbody>
				<%
				if (request.getParameter("Exam")==null)
						mE=mexamcode;
				else
						mE=request.getParameter("Exam").toString().trim();
			
				qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
				qry=qry+"nvl(B.CHOICE,'') CHOICE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,nvl(B.ELECTIVECODE,'') ELECTIVECODE,";
				qry=qry+"nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SEMESTERTYPE,'')SEMESTERTYPE  from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
				qry=qry+" where B.examcode='"+mE+"' and B.institutecode='"+mInst+"'";
				qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID order by CHOICE, SUBJECT";

				rs1=db.getRowset(qry);
				msno=0;
			      msno1=0;
				while(rs1.next())
				{
			       	msno1++;
				      mSemtype=rs1.getString("SEMESTERTYPE");
				 	if(mSemtype.equals("REG"))
					{
				            msno++ ;
						%>
					   	<tr>
						<td align=center><%=msno%>.</td>
						<%
						if(rs1.getString("SUBJECTTYPE").equals("F"))
							mSubtype="Free Elective";
						else if(rs1.getString("SUBJECTTYPE").equals("C"))
							mSubtype="Core";
						else
						{
							mSubtype=rs1.getString("ELECTIVECODE");	
							mSubtype="Elective ["+mSubtype+"]";
						}
						%>
						<td><%=rs1.getString("SUBJECT")%></td>
						<td><%=mSubtype%></TD>
						<td align=center><%=rs1.getString("CHOICE")%></TD>
						<%
						if(mSentToHOD.equals("Y"))
							msg="Sent";
						else
							msg="Not Sent";
						%>
						<td nowrap align=center><%=msg%></td></tr>
				    		<%
					}
				}
				%>
				</tbody>
				</table>
				<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
				</script>
				<%
				if(!mSentToHOD.equals("Y"))
				{
					if(msno1<=msno)
					{
						if(msno>0)
						{
							%>
							<table cellspacing=0 cellpadding=0 width=100% border=1 align=center>
							<tr bgcolor=white>
							<td colspan=8 align=center>
							<INPUT Type="submit"  Value="Send To HOD"></td></tr>
							<input type=hidden name='Exam' id='Exam' value=<%=mE%>>
							<input type=hidden name='PreEvent' id='PreEvent' value=<%=mCurPRCode%>>
							</table></form>
							<%
						}
					}
				}
				if(msno1>msno)
				{
					%>
					<table width=100%><tr><td><center><font color="#00008b" face="Verdana" size=2><b>List of Subject-Choice for Back Log Papers</b></font></center></td></tr></table>
					<form name="frm1"  method="post" action="PRStudSendToHODAction.jsp">
					<table bgcolor=#fce9c5 width=98% class="sort-table" id="table-2" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
					<thead>
					<tr bgcolor="#ff8c00">
					  <td><b><font color=white>SNo.</font></b></td>
					  <td><b><font color=white>Subject</font></b></td>
					  <td><b><font color=white>Subject Type</font></b></td>	
					  <td><b><font color=white>Choice</font></b></td>
					  <td align=center><b><font color=white>Sent to HOD?&nbsp;</font></b></td>
					</tr>
					</thead>
					<tbody>
					<%
					qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
					qry=qry+" B.CHOICE CHOICE,nvl(B.SUBJECTTYPE,'')SUBJECTTYPE,nvl(B.SUBJECTRUNNING,' ')SUBJECTRUNNING,nvl(B.SEMESTERTYPE,' ') SEMESTERTYPE from SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B";
					qry=qry+" where B.examcode='"+mE+"' and B.institutecode='"+mInst+"'";
					qry=qry+" and B.studentid='"+mMemberID+"' and A.subjectID=B.subjectID order by CHOICE, SUBJECT";
					rs1=db.getRowset(qry);
					msno=0;
					while(rs1.next())
					{
					      mSemtype=rs1.getString("SEMESTERTYPE");
			      	     	if(mSemtype.equals("RWJ"))
						{
							msno++ ;
							%>
							<tr>
							<td align=center><%=msno%>.</td>	
							<%
							if(rs1.getString("SUBJECTTYPE").equals("F"))
								mSubtype="Free";
							else if(rs1.getString("SUBJECTTYPE").equals("E"))
								mSubtype="Elective";
							else
								mSubtype="Core";	
							%>
							<td><%=rs1.getString("SUBJECT")%></td>
							<td><%=mSubtype%></TD>
							<td align=center><%=rs1.getString("Choice")%></TD>
							<%
							if(mSentToHOD.equals("Y"))
								msg="Sent";
							else
								msg="Not Sent";
							%>
							<td nowrap align=center><%=msg%></td></tr>
							<%
						}
					}
					%>
					</tbody>
					</table>	
					<script type="text/javascript">
					var st1 = new SortableTable(document.getElementById("table-2"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
					</script>
					<%
					if(!mSentToHOD.equals("Y"))
					{		
						%>
						<table cellspacing=0 cellpadding=0 align=center>
						<tr>
						<td colspan=8 align=center>
						<INPUT Type="submit" Value="Send To HOD"></td></tr>
						<input type=hidden name='Exam' id='Exam' value=<%=mE%>>
						<input type=hidden name='PreEvent' id='PreEvent' value=<%=mCurPRCode%>>
						<tr><TD colspan=5 align=left>
						<font size=2 color=green># You are recommended to register Regular and Backlog Papers before <u>Send to HOD</u>.
						<br># Please prefer your first Choice to the Subjects, which are currently running in junior's batches.
						<br># Once you <u>Send to HOD</u>, you cann't submit or delete any registration /Choice.</font>
						</td></tr>
						</table></form>
						<%
					}
				}
			}
		}
//------------------------------
		else
		{
			%>
			<font color=red>
			<h3>	<br><img src='../../Images/Error1.jpg'>
			Pre- Registration Event has not been declared or Registration completed</FONT></P>
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
}   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	
}
%>
<table ALIGN=Center VALIGN=TOP>
	<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td>
	</tr>
</table>
</body>
</html>