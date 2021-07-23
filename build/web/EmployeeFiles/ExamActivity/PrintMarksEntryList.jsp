<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  

try
{
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mComp="",mDMemberID="";
String mExamID="",mExamid="",QryExamid="",meventcode="",mEventCode="",mSubj="",msubj="";
String qry="", mDeptCode="", QryDept="", QryDeptName="", mDeptName="", QryEmpName="", QryLTP="", QryProjSubj="N";
int msno=0, len=0, pos=0, ctr=0,flag=0;
String mCurDate="", mLocked="",mPublish="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rschk1=null,rschk2=null;
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

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	PrintMarksEntryList.JSP		[For Employee]			   *
	' * Author:		Ankur 						         *
	' * Date:		10th jan 2009	 							   *
	' * Version:	1.0									   *	
	' **********************************************************************************************************
*/
%>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 

<title>Hide Stuff and Print</title>
</head>
<body leftmargin=5 topmargin=5>
<%
	ctr=0;
	if (request.getParameter("Exam")==null)	
		mExamID="";
	else
		mExamID=request.getParameter("Exam").toString().trim();

	if (request.getParameter("Event")==null)	
		mEventCode="";
	else
		mEventCode=request.getParameter("Event").toString().trim();

	if (request.getParameter("Dept")==null)	
		QryDept="";
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
	//out.print(mExamID+" "+mEventCode+" "+QryDept+" "+QryLTP);

	if(!mExamID.equals("") && !mEventCode.equals("") && !QryDept.equals(""))
	{
		%>
		<LEFT>
			<Font color=black size=3><b>Exam Code : </B></font><Font color=navy size=3><%=mExamID%></font>
			<Font color=black size=3><B>&nbsp; &nbsp; Event Code : </B></font><Font color=navy size=3><%=mEventCode%></font><br>
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
					<Font color=black size=3><b>Department : </B></font><Font color=navy size=3><%=QryDeptName%></font>
					<Font color=black size=3><B>&nbsp; &nbsp; Head of Department : </B></font><Font color=navy size=3><%=QryEmpName%></font>
					<%
				}
			}
			%>
	</LEFT>
		<START OF FILE>
		 <%@page contentType="text/html"%>
	   	<%
		response.setContentType("application/vnd.ms-excel");
		%>  
			<Table valign=top width=100% border=0 bgcolor=white>
			<tr>
			<td align=center colspan=3><font face=arial color=Black size=4><B>Marks Entry Status  <%=mEventCode%></font></B></td>
			</tr>
			<tr bgcolor="#ff8c00">
			<td nowrap><font color=white size=3 face=arial><B>Subject</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Co-Ordinator</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Faculty</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Batch</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Status</B></font></td>
			</tr>
			<%
			rs=null;

		/*String 	qrys="SELECT distinct FSTID FROM V#STUDENTLTPDETAIL WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+mExamID+"' AND nvl(DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' ";
			qrys=qrys+" AND FSTID  IN (SELECT FSTID FROM v#studenteventsubjectmarks  WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EVENTSUBEVENT like  '%"+mEventCode+"%'  and NVL(DEACTIVE,'N')='N')";
			//out.print(qrys);
		rss=db.getRowset(qrys);
		if(rss.next())
		{*/


			if(QryLTP.equals("L"))
			{
			

			qry="Select DISTINCT A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.EMPLOYEEID EMPLOYEEID, A.PROGRAMCODE PC, A.SECTIONBRANCH SEC, A.SUBSECTIONCODE SUBSEC, nvl(B.subject,' ')||' ('|| nvl(B.subjectcode,' ')||')' Subject, nvl(C.EmployeeName,' ') Faculty, nvl(C.EmployeeCode,' ')EmployeeCode FROM FACULTYSUBJECTTAGGING A, SubjectMaster B, EmployeeMaster C WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mExamID+"'";
			qry=qry+" AND A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and A.EMPLOYEEID=C.EMPLOYEEID AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"')";
			qry=qry+" AND A.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND nvl(DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' )";
			qry=qry+" AND A.FSTID NOT IN (SELECT FSTID FROM v#studenteventsubjectmarks  WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EVENTSUBEVENT= '"+mEventCode+"'  and NVL(DEACTIVE,'N')='N')";
			qry=qry+" AND A.LTP='"+QryLTP+"'  AND NVL(A.DEACTIVE,'N')='N' AND A.PROJECTSUBJECT='"+QryProjSubj+"' ORDER BY SUBJECT, Faculty, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE";
			}
		
			else if ( QryLTP.equals("P")  || QryLTP.equals("E"))
			{
			qry="Select DISTINCT A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.EMPLOYEEID EMPLOYEEID, A.PROGRAMCODE PC, A.SECTIONBRANCH SEC, A.SUBSECTIONCODE SUBSEC, nvl(B.subject,' ')||' ('|| nvl(B.subjectcode,' ')||')' Subject, nvl(C.EmployeeName,' ') Faculty, nvl(C.EmployeeCode,' ')EmployeeCode FROM FACULTYSUBJECTTAGGING A, SubjectMaster B, EmployeeMaster C WHERE A.INSTITUTECODE='"+mInst+"' AND PROGRAMCODE NOT IN('PHD','PHDP') AND A.EXAMCODE='"+mExamID+"'";
			qry=qry+" AND A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and A.EMPLOYEEID=C.EMPLOYEEID AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"') ";
			qry=qry+"  AND A.SUBJECTID IN (SELECT SUBJECTID FROM PROGRAMSUBJECTTAGGING WHERE  EXAMCODE='"+mExamID+"' AND INSTITUTECODE='"+mInst+"' AND P <> 0  and NVL(DEACTIVE,'N')='N') AND  A.SUBJECTID NOT IN(SELECT SUBJECTID FROM v#studenteventsubjectmarks      WHERE institutecode ='"+mInst+"'  AND examcode = '"+mExamID+"' AND NVL (deactive, 'N') = 'N' ) ";
			qry=qry+" AND A.FSTID NOT IN (SELECT FSTID FROM v#studenteventsubjectmarks WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EVENTSUBEVENT LIKE '%"+mEventCode+"%'   and NVL(DEACTIVE,'N')='N')";
			qry=qry+" AND A.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND nvl(DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' ) ";
			qry=qry+" AND A.LTP='"+QryLTP+"'  AND NVL(A.DEACTIVE,'N')='N' AND A.PROJECTSUBJECT='"+QryProjSubj+"' ORDER BY SUBJECT, Faculty, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE";
			}
			//out.print(qry);
			rs=db.getRowset(qry);
			String mSub="",mFac="";
			while(rs.next() )
			{
				flag=1;
				//out.print("sdfsfsfd");
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
				String qryf="select COORDINATORNAME,COORDINATORcode from V#EX#SUBJECTGRADECOORDINATOR where FSTID='"+rs.getString("FSTID")+"' and subjectid='"+rs.getString("SUBJECTID")+"' AND examcode='"+mExamID+"' AND INSTITUTECODE='"+mInst+"' ";
					//out.print(qryf);
					ResultSet rsf=db.getRowset(qryf);
			if(rsf.next())
				{
					%>
					<td nowrap><Font size=2 color=red face=arial><%=rsf.getString("COORDINATORNAME")%><br>
					<%=rsf.getString("COORDINATORCODE")%></font></td>
					<%
				}
				else
				{
					%>
					<td nowrap><Font size=2 color=red face=arial>Co-ordinator <BR>Not Defined</font></td>
					<%
				}
				
				if(!mFac.equals(rs.getString("EMPLOYEEID")) )
				{

					%>
					<td nowrap><Font size=2 face=arial><%=rs.getString("Faculty")%><br><%=rs.getString("EmployeeCode")%></font></td>
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
				qry="Select nvl(EVENTSUBEVENT,' ')EVENTSUBEVENT  FROM EXAMEVENTSUBJECTTAGGING WHERE FSTID='"+rs.getString("FSTID")+"' AND EVENTSUBEVENT like '%"+mEventCode+"%' AND nvl(DEACTIVE,'N')='N'";
				//out.print(qry);
				rs1=db.getRowset(qry);
				if(rs1.next())
				{
					qry="select 'Y' from studenteventsubjectmarks where FSTID='"+rs.getString("FSTID")+"' AND EVENTSUBEVENT='"+mEventCode+"' AND nvl(DETAINED,'N')='N'  and nvl(LOCKED,'N')='N' ";
					//and and MARKSAWARDED1 isNOT null and MARKSAWARDED2 isNOT null";
					rschk1=db.getRowset(qry);
					//out.print(qry);
					if(rschk1.next())
					{
						%>							
							<td nowrap><b><%=rs1.getString("EVENTSUBEVENT")%></b>--<Font size=2 COLOR=RED face=arial><b>Marks  Entered but not locked</b></font></td>
						<%
						
					}
					else
					{
					
							%>							
							<td nowrap><b><%=rs1.getString("EVENTSUBEVENT")%></b>--<Font size=2 COLOR=Blue face=arial><b>Marks Not Entered </b></font></td>
							<%
						
						
					}
				}
				else 
				{
					String qry1="select COORDINATORNAME from V#EX#SUBJECTGRADECOORDINATOR where FSTID='"+rs.getString("FSTID")+"' AND examcode='"+mExamID+"' ";
					//out.print(qry1);
					ResultSet rsg=db.getRowset(qry1);
					if(rsg.next())
					{
					%>
					<td nowrap><Font size=2 COLOR=PURPLE face=arial><b>Pre-Marks Entry Not Done by Faculty</b></font></td>
					<%
					}
					else
					{
						%>
					<td nowrap><Font size=2 COLOR=red face=arial><b>Co-ordinator Not Defined</b></font></td>
					<%
					}
				}
				%>
				</tr>
				<%
			}
			if(flag==0)
				{
					%>
					<tr><td nowrap align=center colspan=5><Font size=4 COLOR=green face=arial><b>Marks Entry done by All Faculty !</b></font></td></tr>
					<%
				}
		//}	
	//	else
		//{
			%>
		<!-- 	<tr><td nowrap align=center colspan=5><Font size=4 COLOR=red face=arial><b>Data is Not Found !</b></font></td></tr> -->
			<%

		//}
			%>
			</table>
	
		<END OF FILE>
		<%
	}
}
catch(Exception e)
{
	//out.println(e);
}
%>
</body>
</html> 
     
