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
<TITLE>#### <%=mHead%> [ Grade Entry Status Studentwise ] </TITLE>
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
String qry="",qry1="", mDeptCode="", QryDept="", QryDeptName="", mDeptName="", QryEmpName="", QryLTP="", QryProjSubj="N";
int msno=0, len=0, pos=0, ctr=0;
String mCurDate="", mLocked="",mPublish="";
String mCheck="",mCheck1="",mCheck2="";
String mCNDefine="",mGNEnter="",mGNLock="";
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
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><B>Grade Entry Status Studentwise </B></TD>
			</font></td></tr>
			</TABLE>

			<table width="90%"  cellpadding=1 cellspacing=0  align=center rules=groups border=1>
			<tr><td colspan=3  align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Employee : &nbsp;</STRONG></font><font color=black face=arial size=2><%=mMemberName%>[<%=mDMemberCode%>]
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDept)%>
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesg)%>
			<hr></td></tr>
			</table>
			<table width="90%"  cellpadding=3 cellspacing=0  align=center rules=groups border=1>
		<!--*********Exam**********-->
			<tr>
			<td  ><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT> 
			<select name=Exam tabindex="1" id="Exam">	
			<%
				
	
		qry=" Select distinct nvl(EXAMCODE,' ') EXAMCODE , EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(Deactive,'N')='N' ";
		qry+=" and examcode in (Select examcode from facultysubjecttagging where fstid in (select fstid from StudentEventSubjectMarks))";
      	qry+=" order by EXAMCODE DESC";
		


		
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
				</td>
				
			
		
			
		<%
				
		if(request.getParameter("GNEnter")!=null || request.getParameter("x")==null)
			{
				if ( request.getParameter("x")==null || request.getParameter("GNEnter").equals("GNE"))
				{
					mCheck="checked";
				}
			}
			
			
		if(request.getParameter("GNLock")!=null)
			{
				if (request.getParameter("GNLock").equals("GNL"))
				{
					mCheck1="checked";
				}
			}
			

	
			%>
			<!--*********Exam Event Code**********-->
										
			
		
				<td >
					<INPUT TYPE="checkbox" NAME="GNEnter" id="GNEnter" <%=mCheck%> value="GNE"><b><FONT face=Arial size=2>Grade Not Entered.</font></b>
				</td>
				
				
				</tr>
					
				<tr><td align=center colspan=3>
					<INPUT Type="submit" Value="&nbsp; Submit &nbsp;">
					</td></tr>
			</table>
			</form>
		<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("Exam")!=null && !request.getParameter("Exam").equals("NONE"))
				{
				mExamID=request.getParameter("Exam").toString().trim();
				}
				else
				{
					mExamID="";
				}
		
			
				
				if(request.getParameter("GNEnter")==null)
					mGNEnter="";
				else
					mGNEnter=request.getParameter("GNEnter").toString().trim();

				
				if(request.getParameter("GNLock")==null)
					mGNLock="";
				else
					mGNLock=request.getParameter("GNLock").toString().trim();

				
				
			
			%>
			<form name="frm2" method="post" action="GradeEntryStatusStudentXLS.jsp">
			
			<input id="Exam" name="Exam" type=hidden value="<%=mExamID%>">
			<INPUT TYPE="hidden" NAME="InstCode" value='<%=mInst%>'  > 
		
			
			<input id="GNEnter" name="GNEnter" type=hidden value="<%=mGNEnter%>">
			<input id="GNLock" name="GNLock" type=hidden value="<%=mGNLock%>">
			

			<table width="100%" ALIGN=CENTER bottommargin=0 cellspacing=0 cellpadding=0 topmargin=0 border=1>
			
			<tr>
			<td align=center><font face=arial size=3 color=Black><B>Grade Entry Status Studentwise</font></B></td>
			
			</tr>
			<tr>
			<td nowrap valign=top>
			<Table valign=top width=100% border=1 bgcolor=white cellspacing=1 cellpadding=1 rules="row">
			<thead>
			<tr bgcolor="#ff8c00">
			<td nowrap><font color=white size=3 face=arial><B>Student  </B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Subject</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Batch</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Status</B></font></td>
			</tr>
			</thead>
			<%
			rs=null;
			
		if(mGNEnter.equals("GNE") )
		{
			qry="SELECT DISTINCT a.studentid studentid,a.subjectid subjectid, a.employeeid employeeid,                a.programcode pc, a.sectionbranch sec,  a.subsectioncode subsec,                   NVL (b.subject, ' ') || ' ( '|| NVL (b.subjectcode, ' ')  || ')' subject,                   NVL (a.STUDENTNAME , ' ')  || ' (' || NVL (a.ENROLLMENTNO , ' ')                || ')' student,'Grade Not Entered' status  FROM v#studentltpdetail a, subjectmaster b          WHERE a.institutecode = '"+mInst+"'   AND a.examcode = '"+mExamID+"'  AND A.PROGRAMCODE NOT IN ('PHD','PHDP')  AND	 a.institutecode = b.institutecode   AND a.subjectid = b.subjectid AND a.SUBJECTID not in (select subjectid from gradecalculation where institutecode = '"+mInst+"'  AND examcode = '"+mExamID+"' )     AND a.fstid IN (                   SELECT fstid   FROM facultysubjecttagging   WHERE institutecode = '"+mInst+"'                       AND examcode = '"+mExamID+"' AND NVL (deactive, 'N') = 'N' )            AND NVL (a.deactive, 'N') = 'N' and   NVL (a.studentdeactive, 'N') = 'N'          ORDER BY  student,subject, programcode, sectionbranch, subsectioncode";
				

			//out.print(qry);
			rs=db.getRowset(qry);
			String mSub="",mStudent="";
			while(rs.next())
			{
		
				%>
				<tr>
				
				<%
				if(!mStudent.equals(rs.getString("studentid")))
				{
					%>
					<td nowrap><Font size=2><%=rs.getString("student")%></font></td>
					<%
						mStudent=rs.getString("studentid");
				}
				else
				{
					%>
					<td nowrap><Font size=2>-------do-------</font></td>
					<%
				}
		
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
					<td nowrap><Font size=2>-------do-------</font></td>
					<%
				}
				%>
				
				<td nowrap><Font size=2><%=rs.getString("PC")%> (<%=rs.getString("SEC")%>-<%=rs.getString("SUBSEC")%>)</font></td>
				
				<td nowrap><Font size=2 COLOR=DarkBrown face=arial><b><%=rs.getString("status")%></b></font></td>
				
				
				</tr>
				<%
			}
	
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