<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
 <%@page contentType="text/html"%>
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
		response.setContentType("application/vnd.ms-excel");




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

				if(request.getParameter("Exam")!=null && !request.getParameter("Exam").equals("NONE"))
				{
				mExamID=request.getParameter("Exam").toString().trim();
				}
				else
				{
					mExamID="";
				}
		
			
				if (request.getParameter("Dept")==null)
					QryDept="All";
				else
					QryDept=request.getParameter("Dept").toString().trim();

				if(request.getParameter("GNEnter")==null)
					mGNEnter="";
				else
					mGNEnter=request.getParameter("GNEnter").toString().trim();

				
				if(request.getParameter("GNLock")==null)
					mGNLock="";
				else
					mGNLock=request.getParameter("GNLock").toString().trim();

				
				if(request.getParameter("CNDefine")==null)
					mCNDefine="";
				else
					mCNDefine=request.getParameter("CNDefine").toString().trim();


			if(!QryDept.equals("All"))
			{
				qry="Select A.Department||' ('||A.DepartmentCode||')' Department, B.EmployeeName||' ('||b.EmployeeCode||')' Employee From DepartmentMaster A, EmployeeMaster B where A.DepartmentCode=B.DepartmentCode and B.EmployeeId in (Select EmployeeId from HODLIST Where DepartmentCode='"+QryDept+"')";
				//out.print(qry);
				rs=db.getRowset(qry);
				if(rs.next())
				{
					QryDeptName=rs.getString(1);
					QryEmpName=rs.getString(2);
					
				}
			}
			else
			{
				QryDeptName="ALL";
			}
			%>
			<form name="frm1" method="post" >
			<input id="x" name="x" type=hidden>
			<center>
			<table width="100%" valign=top ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD  align=CENTER ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><B>Grade Entry Status (Faculty/Subjectwise)   </B></TD>
			</font></td></tr>
			</TABLE>
			<center>	
			<table width="100%"  cellpadding=1 cellspacing=0  align=center rules=groups border=1>
			<tr>

		<!--*********Exam**********-->
			<td  ALIGN=CENTER><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code   :   <%=mExamID%></STRONG></FONT></FONT>			
				</td>
				
			</tr>
			
			</table>
			<!--*********Exam Event Code**********-->
										
			<table border=1 width="100%" align=center cellspacing=1 cellpadding=1 rules=none >
				<%
				if(request.getParameter("GNEnter").equals("GNE"))
				{
				%>

				<tr><td align=center>
					<b><FONT face=Arial size=3 color=red>Grades Not Entered !</font></b>
				</td></tr>
				<%
				}
				if(request.getParameter("GNLock").equals("GNL"))
				{
					%>
				<tr><td align=center>
					<b><FONT face=Arial size=3 color=red>Grades Entered but Not Locked !</font></b>
				</td></tr>
				<%
				}
				if (request.getParameter("CNDefine").equals("CND"))
				{
						%>

				<tr><td align=center>
					<b><FONT face=Arial size=3 color=red>Co-ordinator Not Defined !</font></b>
				</td></tr>
				<%
				}
					%>
				</table>
		

			<table width="100%" ALIGN=CENTER bottommargin=0 cellspacing=0 cellpadding=0 topmargin=0 border=1>
			
			<%
				if(!QryDept.equals("All"))
				{
				%>
					<tr><td colspan=3 align=left>
					<Font color=black face=arial size=3><b>Department : </B></font><Font color=navy size=3 face=arial ><%=QryDeptName%></font>
					<Font color=black face=arial  size=3><B>&nbsp; &nbsp; Head of Department : </B></font><Font color=navy size=3 face=arial ><%=QryEmpName%></font>
					</td></tr>
					<%
				}
					%>
			
			<tr>
		<!-- 	<td align=center><font face=arial size=3 color=Black><B>Grade Entry Status </font></B></td> -->
			
			</tr>
			<tr>
			<td nowrap valign=top>
			<Table valign=top width=100% border=0 bgcolor=white cellspacing=1 cellpadding=1>
			<tr bgcolor="#ff8c00">
			<td nowrap><font color=white size=3 face=arial><B>Subject</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Faculty</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Batch</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Status</B></font></td>
			</tr>
			<%
			rs=null;
			
		if(mGNEnter.equals("GNE") )
		{


			qry="SELECT DISTINCT  a.subjectid subjectid, a.employeeid employeeid,      a.programcode pc, a.sectionbranch sec,a.subsectioncode subsec, NVL (b.subject, ' ') || ' (' || NVL (b.subjectcode, ' ') || ')' subject, NVL (c.employeename, ' ') || ' (' || NVL (c.employeecode, ' ') || ')' faculty,'Grade Not Entered' status  FROM facultysubjecttagging a, subjectmaster b, employeemaster c WHERE a.institutecode = '"+mInst+"'     AND a.examcode = '"+mExamID+"'  AND a.institutecode = b.institutecode AND a.subjectid = b.subjectid AND a.employeeid = c.employeeid  AND A.PROGRAMCODE NOT IN ('PHD','PHDP')  AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"')           and                a.SUBJECTID not in( select subjectid from gradecalculation where examcode='"+mExamID+"'               AND INSTITUTECODE='"+mInst+"'                 )                         AND A.FSTID NOT IN (SELECT DISTINCT FSTID FROM studentwisegrade WHERE  institutecode = '"+mInst+"'   AND examcode =  '"+mExamID+"' AND NVL (deactive, 'N') = 'N'     )       AND a.fstid IN (          SELECT fstid   FROM v#studentltpdetail  WHERE institutecode =  '"+mInst+"'    AND examcode =  '"+mExamID+"' AND NVL (deactive, 'N') = 'N' AND NVL(STUDENTDEACTIVE,'N')='N')  AND NVL (a.deactive, 'N') = 'N'   ORDER BY subject, faculty, programcode, sectionbranch, subsectioncode";


			//out.print(qry);
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
					<td nowrap><Font size=2>-------do-------</font></td>
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
					<td nowrap><Font size=2>-------do-------</font></td>
					<%
				}
					%>
				<td nowrap><Font size=2><%=rs.getString("PC")%> (<%=rs.getString("SEC")%>-<%=rs.getString("SUBSEC")%>)</font></td>
				
				<td nowrap><Font size=2 COLOR=red face=arial><b><%=rs.getString("status")%></b></font></td>
				
				
				</tr>
				<%
			}
	
			}

			if( mGNLock.equals("GNL"))
			{
			
				qry1="SELECT DISTINCT a.subjectid subjectid, a.employeeid employeeid,      a.programcode pc, a.sectionbranch sec,a.subsectioncode subsec, NVL (b.subject, ' ') || ' (' || NVL (b.subjectcode, ' ') || ')' subject, NVL (c.employeename, ' ') || ' (' || NVL (c.employeecode, ' ') || ')' faculty ,'Grade Entered but not Locked' status FROM facultysubjecttagging a, subjectmaster b, employeemaster c WHERE a.institutecode = '"+mInst+"'     AND a.examcode = '"+mExamID+"'  AND a.institutecode = b.institutecode AND a.subjectid = b.subjectid AND a.employeeid = c.employeeid  AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"')            AND A.SUBJECTID IN (SELECT SUBJECTID FROM GRADECALCULATION WHERE  institutecode = '"+mInst+"'                  AND examcode = '"+mExamID+"' AND NVL(FINALIZED,'N')='N')      AND  a.fstid IN (          SELECT fstid   FROM v#studentltpdetail  WHERE institutecode =  '"+mInst+"'    AND examcode =  '"+mExamID+"' AND NVL (deactive, 'N') = 'N' AND NVL(STUDENTDEACTIVE,'N')='N')  AND NVL (a.deactive, 'N') = 'N' ORDER BY subject, faculty, programcode, sectionbranch, subsectioncode";
			

			
				//out.print(qry1);
			rs=db.getRowset(qry1);
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
					<td nowrap><Font size=2>-------do-------</font></td>
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
					<td nowrap><Font size=2>-------do-------</font></td>
					<%
				}
					%>
				<td nowrap><Font size=2><%=rs.getString("PC")%> (<%=rs.getString("SEC")%>-<%=rs.getString("SUBSEC")%>)</font></td>
				
				<td nowrap><Font size=2 COLOR="red" face=arial><b><%=rs.getString("status")%></b></font></td>
				
				
				</tr>
				<%
			}
		
			
			}
				
			if(mCNDefine.equals("CND"))
			{
				qry1="SELECT DISTINCT a.fstid fstid, a.subjectid subjectid, a.employeeid employeeid,      a.programcode pc, a.sectionbranch sec,a.subsectioncode subsec, NVL (b.subject, ' ') || ' (' || NVL (b.subjectcode, ' ') || ')' subject, NVL (c.employeename, ' ') || ' (' || NVL (c.employeecode, ' ') || ')' faculty ,'Co-ordinator Not Defined' status FROM facultysubjecttagging a, subjectmaster b, employeemaster c WHERE a.institutecode = '"+mInst+"'     AND a.examcode = '"+mExamID+"'  AND a.institutecode = b.institutecode AND a.subjectid = b.subjectid AND a.employeeid = c.employeeid  AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"')             AND A.FSTID not IN (SELECT DISTINCT FSTID FROM v#EX#SUBJECTGRADECOORDINATOR WHERE  institutecode = '"+mInst+"'  AND examcode =  '"+mExamID+"'   )  AND a.subjectid IN (   SELECT subjectid FROM datesheetdata  WHERE institutecode = '"+mInst+"'     AND examcode =  '"+mExamID+"'  AND subjectid NOT IN ( SELECT subjectid  FROM datesheetsubjects    WHERE institutecode = '"+mInst+"'         AND examcode =  '"+mExamID+"'  AND NVL (exclude, 'N') = 'Y'))  AND a.fstid IN (          SELECT fstid   FROM v#studentltpdetail  WHERE institutecode =  '"+mInst+"'    AND examcode =  '"+mExamID+"' AND NVL (deactive, 'N') = 'N' AND NVL(STUDENTDEACTIVE,'N')='N')  AND NVL (a.deactive, 'N') = 'N' AND a.projectsubject = 'N'   ORDER BY subject, faculty, programcode, sectionbranch, subsectioncode";
			
				//out.print(qry1);
			rs=db.getRowset(qry1);
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
					<td nowrap><Font size=2>-------do-------</font></td>
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
					<td nowrap><Font size=2>-------do-------</font></td>
					<%
				}
					%>
				<td nowrap><Font size=2><%=rs.getString("PC")%> (<%=rs.getString("SEC")%>-<%=rs.getString("SUBSEC")%>)</font></td>
				
				<td nowrap><Font size=2 COLOR="red" face=arial><b><%=rs.getString("status")%></b></font></td>
				
				
				</tr>
				<%
			}
					
			}


			%>
			</table>
		</TD>
		</TR>
			
			</table>
			</form>
			<%

/*********************************/
			
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