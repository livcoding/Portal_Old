<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Level Wise Marks Entry List ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mComp="",mDMemberID="";
String mExamID="",mExamid="",QryExamid="",meventcode="",mEventCode="",mSubj="",msubj="";
String qry="", mDeptCode="", QryDept="", QryDeptName="", mDeptName="", QryEmpName="", QryLTP="", QryProjSubj="N";
int msno=0, len=0, pos=0, ctr=0;
String mCurDate="", mLocked="",mPublish="";
ResultSet rs=null,rss=null,rs1=null,rs2=null;
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
		qry="Select WEBKIOSK.ShowLink('218','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
  //----------------------
			mDMemberCode=enc.decode(mMemberCode);
			mDMemberType=enc.decode(mMemberType);
			mDMemberID=enc.decode(mMemberID);
			%>
			<form name="frm1" method="post" >
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Level Wise Marks Entry List </B></TD>
			</font></td></tr>
			</TABLE>

			<table cellpadding=1 cellspacing=0  align=center rules=groups border=1>
			<tr><td colspan=3  align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Employee : &nbsp;</STRONG></font><font color=black face=arial size=2><%=mMemberName%>[<%=mDMemberCode%>]
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDept)%>
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesg)%>
			<hr></td></tr>

		<!--*********Exam**********-->
			<td colspan=3 ALIGN=CENTER><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT> 
			<select name=Exam tabindex="1" id="Exam">	
			<%
				
		qry=" Select EXAMCODE from (";
		qry+=" Select distinct nvl(EXAMCODE,' ') EXAMCODE , EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(Deactive,'N')='N' ";
		qry+=" and examcode in (Select examcode from facultysubjecttagging where fstid in (select fstid from StudentEventSubjectMarks))";
      	qry+=" order by EXAMPERIODFROM DESC";
		qry+=") where rownum<8"; 


		
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null)
			{
				while(rs.next())
				{
					mExamid=rs.getString("EXAMCODE");
					if(QryExamid.equals(""))
 					{
						QryExamid=mExamid;
						%>
						<OPTION selected Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%			
					}
					else
					{
						%>
						<OPTION Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%			
					}
				}
			}
			else
			{
				while(rs.next())
				{
					mExamid=rs.getString("EXAMCODE");
					if(mExamid.equals(request.getParameter("Exam")))
	 				{
						QryExamid=mExamid;
						%>
						<OPTION selected Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%
					}
					else
					{
						%>
						<OPTION Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%
					}
				}
			}
			%>
		      </select>
			<INPUT Type="submit" Value="&nbsp; OK &nbsp;">
			</tr></td>
			</table>
			</form>
			<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("Exam")!=null && !request.getParameter("Exam").equals("NONE"))
				{
				mExamid=request.getParameter("Exam").toString().trim();
				}
				else
				{
					mExamid="";
				}
			%>
			<!--*********Exam Event Code**********-->
			
			<form name="frm" method="post" >
			<input id="y" name="y" type=hidden>
			<input id="x" name="x" type=hidden>
			<input id="Exam" name="Exam" type=hidden value="<%=mExamid%>">
			
			<table border=1 align=center cellspacing=1 cellpadding=1>
			<tr><td>

			<FONT color=black face=Arial size=2><STRONG>Event-Sub-Event</STRONG></FONT>
			</td>
			<td>
			<%
			qry="Select Distinct NVL(EXAMEVENTCODE,' ')EXAMEVENTCODE, EXAMEVENTDESC ||'('||EXAMEVENTCODE||')' ExamEvent, to_char(EVENTFROM,'dd-mm-yyyy')EVENTFROM from EXAMEVENTMASTER WHERE InstituteCode='"+mInst+"' and examcode='"+mExamid+"' and nvl(Deactive,'N')='N' ORDER BY to_date(EVENTFROM,'dd-mm-yyyy') asc";
			//out.print(qry);
			rs=db.getRowset(qry);
			%>
			<select name=Event tabindex="2" id="Event">	
			<%
			if (request.getParameter("x")==null)
			{
				while(rs.next())
				{
					meventcode=rs.getString("EXAMEVENTCODE").toString().trim();
					if(mEventCode.equals(""))
 					{
						mEventCode=meventcode;
						%>
						<OPTION selected Value ="<%=meventcode%>"><%=rs.getString("ExamEvent")%></option>
						<%			
					}
					else
					{
						%>
						<OPTION Value ="<%=meventcode%>"><%=rs.getString("ExamEvent")%></option>
						<%			
					}
				}
			}
			else
			{
				while(rs.next())
				{
					meventcode=rs.getString("EXAMEVENTCODE").toString().trim();
					if(meventcode.equals(request.getParameter("Event")))
	 				{
						mEventCode=meventcode;
						%>
						<OPTION selected Value ="<%=meventcode%>"><%=rs.getString("ExamEvent")%></option>
						<%
					}
					else
					{
						%>
						<OPTION Value="<%=meventcode%>"><%=rs.getString("ExamEvent")%></option>
						<%
					}
				}
			}
			%>
	      	</select>
			</td>
			</TR>
			<!--*********Department**********-->
			<tr><td >
			<FONT color=black face=Arial size=2><STRONG>Department</STRONG></FONT>
			</td><td>
			<%
			qry="select distinct B.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N'";
			//qry=qry+" AND A.DepartmentCode IN (SELECT DEPARTMENTCODE FROM BRANCHDEPTTAGGING WHERE //INSTITUTECODE='"+mInst+"') order by DeptName";
			//out.print(qry);
			rs=db.getRowset(qry);
			%>
			<select name="Dept" tabindex="3" id="Dept">
			<option value="All">All</option>
			<%
			if(request.getParameter("y")==null)
			{
				while(rs.next())
				{
					mDeptCode=rs.getString("DeptCode");
					if(QryDept.equals(""))
						QryDept=mDeptCode;
					mDeptName=rs.getString("DeptName");
					%>
					<option value=<%=mDeptCode%>><%=(mDeptName)%> (<%=mDeptCode%>)</option>
					<%
				}
			}
			else
			{
				while(rs.next())
				{
					mDeptCode=rs.getString("DeptCode");
					//System.out.print("mDeptCode :"+mDeptCode);
					mDeptName=rs.getString("DeptName");
					//System.out.print("mDeptName :"+mDeptName);
					if(mDeptCode.equals(request.getParameter("Dept").toString().trim()))
					{
						QryDept=mDeptCode;
						%>
						<option selected value=<%=mDeptCode%>><%=(mDeptName)%> (<%=mDeptCode%>)</option>
						<%
					}
					else
					{
						%>
						<option  value=<%=mDeptCode%>><%=(mDeptName)%> (<%=mDeptCode%>)</option>
						<%
					}
				}
			}
			%>
			</select>&nbsp;
			</td>
			</tr>
			<tr><td >
		<!--*********LTP**********-->
			<FONT color=black face=Arial size=2><STRONG>LTP</STRONG></FONT>
			</td>
			<td>
			<select name="LTP" tabindex="4" id="LTP">
			
			<%
			if(request.getParameter("y")==null)
			{
				%>

				<option value="L" Selected>Lecture</option>
				<option value="P">Practical</option>
				<option value="E">Project</option>
				<%
			}
			else
			{
				if((request.getParameter("LTP").toString().trim()).equals("L"))
				{
					%>

					<option value="L" Selected>Lecture</option>
					<option value="P">Practical</option>
					<option value="E">Project</option>
					<%
				}
				else if((request.getParameter("LTP").toString().trim()).equals("P"))
				{
					%>

					<option value="L">Lecture</option>
					<option value="P" Selected>Practical</option>
					<option value="E">Project</option>
					<%
				}
				else if((request.getParameter("LTP").toString().trim()).equals("E"))
				{
					%>

					<option value="L">Lecture</option>
					<option value="P">Practical</option>
					<option value="E" Selected>Project</option>
					<%
				}
				
			}
			%>
			</select>&nbsp;
			&nbsp;<INPUT Type="submit" Value="&nbsp; OK &nbsp;"></td></tr>
			</table>
			</form>
			<%
			
			
			if(request.getParameter("Exam")!=null && !request.getParameter("Exam").equals("NONE"))
			mExamID=request.getParameter("Exam").toString().trim();
				else
			mExamID="";

			if (request.getParameter("Event")==null)	
				mEventCode=mEventCode;
			else
				mEventCode=request.getParameter("Event").toString().trim();

			if (request.getParameter("Dept")==null)
				QryDept="All";
			else
				QryDept=request.getParameter("Dept").toString().trim();

			if (request.getParameter("LTP")==null)	
			{
				QryLTP="All";
				QryProjSubj="N";
			}
			else
			{
				QryLTP=request.getParameter("LTP").toString().trim();
				if(QryLTP.equals("E"))
					QryProjSubj="Y";
			}
			//out.print("MeVENTCODE :"+mEventCode );

/*********************************/
			%>
			<form name="frm2" method="post" action="PrintMarksEntryList.jsp">
			
			<input id="Exam" name="Exam" type=hidden value="<%=mExamID%>">
			<input id="Event" name="Event" type=hidden value="<%=mEventCode%>">
			<input id="Dept" name="Dept" type=hidden value="<%=QryDept%>">
				<input id="LTP" name="LTP" type=hidden value="<%=QryLTP%>">
			<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0 border=1>
			<%
			if(!QryDept.equals("All"))
			{
				qry="Select A.Department||' ('||A.DepartmentCode||')' Department, B.EmployeeName||' ('||b.EmployeeCode||')' Employee From DepartmentMaster A, EmployeeMaster B where A.DepartmentCode=B.DepartmentCode and B.EmployeeId in (Select EmployeeId from HODLIST Where DepartmentCode='"+QryDept+"')";
				//out.print(qry);
				rs=db.getRowset(qry);
				if(rs.next())
				{
					QryDeptName=rs.getString(1);
					QryEmpName=rs.getString(2);
					%>
					<tr><td colspan=3 align=left>
					<Font color=black face=arial size=3><b>Department : </B></font><Font color=navy size=3 face=arial ><%=QryDeptName%></font>
					<Font color=black face=arial  size=3><B>&nbsp; &nbsp; Head of Department : </B></font><Font color=navy size=3 face=arial ><%=QryEmpName%></font>
					</td></tr>
					<%
				}
			}
			%>
			<tr>
			<td align=center><font face=arial size=3 color=Black><B>Marks Entry Status <%=mEventCode%></font></B></td>
			
			</tr>
			<tr>
			<td nowrap valign=top>
			<Table valign=top width=100% border=0 bgcolor=white>
			<tr bgcolor="#ff8c00">
			<td nowrap><font color=white size=3 face=arial><B>Subject</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Faculty</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Batch</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Status</B></font></td>
			</tr>
			<%
			rs=null;
			if(QryLTP.equals("L"))
			{
			qry="Select DISTINCT A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.EMPLOYEEID EMPLOYEEID, A.PROGRAMCODE PC, A.SECTIONBRANCH SEC, A.SUBSECTIONCODE SUBSEC, nvl(B.subject,' ')||' ('|| nvl(B.subjectcode,' ')||')' Subject, nvl(C.EmployeeName,' ')||' ('|| nvl(C.EmployeeCode,' ')||')' Faculty FROM FACULTYSUBJECTTAGGING A, SubjectMaster B, EmployeeMaster C WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mExamID+"'";
			qry=qry+" AND A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and A.EMPLOYEEID=C.EMPLOYEEID AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"')";
			qry=qry+" AND A.SUBJECTID IN (SELECT SUBJECTID FROM DATESHEETDATA where INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EXAMEVENTCODE='"+mEventCode+"' AND SUBJECTID NOT IN (SELECT SUBJECTID FROM DATESHEETSUBJECTS WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EXAMEVENTCODE= '"+mEventCode+"' and nvl(EXCLUDE,'N')='Y' ))";
			qry=qry+" AND A.FSTID NOT IN (SELECT FSTID FROM V#EXAMEVENTSUBJECTTAGGING WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EVENTSUBEVENT= '"+mEventCode+"' AND NVL(PROCEEDSECOND,'N')='Y'   and nvl(published,'N')='Y'  and NVL(DEACTIVE,'N')='N')";
			qry=qry+" AND A.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+mExamID+"' AND nvl(DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' )";
			qry=qry+" AND A.LTP='"+QryLTP+"'  AND NVL(A.DEACTIVE,'N')='N' AND A.PROJECTSUBJECT='"+QryProjSubj+"' ORDER BY SUBJECT, Faculty, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE";
			}
		
			else if ( QryLTP.equals("P")  || QryLTP.equals("E"))
			{
			qry="Select DISTINCT A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.EMPLOYEEID EMPLOYEEID, A.PROGRAMCODE PC, A.SECTIONBRANCH SEC, A.SUBSECTIONCODE SUBSEC, nvl(B.subject,' ')||' ('|| nvl(B.subjectcode,' ')||')' Subject, nvl(C.EmployeeName,' ')||' ('|| nvl(C.EmployeeCode,' ')||')' Faculty FROM FACULTYSUBJECTTAGGING A, SubjectMaster B, EmployeeMaster C WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mExamID+"'";
			qry=qry+" AND A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and A.EMPLOYEEID=C.EMPLOYEEID AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"') ";
			qry=qry+"  AND A.SUBJECTID IN (SELECT SUBJECTID FROM PROGRAMSUBJECTTAGGING WHERE  EXAMCODE='"+mExamID+"' AND INSTITUTECODE='"+mInst+"' AND P <> 0  and NVL(DEACTIVE,'N')='N') ";
			qry=qry+" AND A.FSTID NOT IN (SELECT FSTID FROM V#EXAMEVENTSUBJECTTAGGING WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EVENTSUBEVENT= '"+mEventCode+"' AND NVL(PROCEEDSECOND,'N')='Y' and nvl(published,'N')='Y'  and NVL(DEACTIVE,'N')='N')";
			qry=qry+" AND A.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+mExamID+"' AND nvl(DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' ) ";
			qry=qry+" AND A.LTP='"+QryLTP+"'  AND NVL(A.DEACTIVE,'N')='N' AND A.PROJECTSUBJECT='"+QryProjSubj+"' ORDER BY SUBJECT, Faculty, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE";
			}
		//	out.print(qry);
			rs=db.getRowset(qry);
			String mSub="",mFac="";
			while(rs.next())
			{
		
				%>
				<tr>
				<%
				if(!mSub.equals(rs.getString("SUBJECTID")))
				{
					%>
					<td nowrap><Font size=2><%=rs.getString("Subject")%></font></td>
					<%
						mSub=rs.getString("SUBJECTID");
				}
				else
				{
					%>
					<td nowrap><Font size=2>-------""-------</font></td>
					<%
				}
				if(!mFac.equals(rs.getString("EMPLOYEEID")))
				{
					%>
					<td nowrap><Font size=2><%=rs.getString("Faculty")%></font></td>
					<%
						mFac=rs.getString("EMPLOYEEID");
				}
				else
				{
					%>
					<td nowrap><Font size=2>-------""-------</font></td>
					<%
				}
					%>
				<td nowrap><Font size=2><%=rs.getString("PC")%> (<%=rs.getString("SEC")%>-<%=rs.getString("SUBSEC")%>)</font></td>
				<%
				qry="Select nvl(EVENTSUBEVENT,' ')EVENTSUBEVENT  FROM EXAMEVENTSUBJECTTAGGING WHERE FSTID='"+rs.getString("FSTID")+"' AND EVENTSUBEVENT='"+mEventCode+"' AND nvl(DEACTIVE,'N')='N'";
				//out.print(qry);
				rs1=db.getRowset(qry);
				if(rs1.next())
				{
					%>
					<td nowrap><b><%=rs1.getString("EVENTSUBEVENT")%></b>--<Font size=2 COLOR=GREEN face=arial><b>Pending to Lock Marks</b></font></td>
					<%
				}
				else
				{
					%>
					<td nowrap><Font size=2 COLOR=red face=arial><b>Weightage Not Defined</b></font></td>
					<%
				}
				%>
				</tr>
				<%
			}
	
		
			%>
			</table>
		</TD>
		</TR>
			<tr><td colspan=3 align=left><INPUT Type="submit" Value="Make Printable Format"></td></tr>
			</table>
			</form>
			<%

/*********************************/
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