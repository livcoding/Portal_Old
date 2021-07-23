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
<TITLE>#### <%=mHead%> [Grade Entry Status (Faculty/Subjectwise) ] </TITLE>
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
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><B>Grade Entry Status (Faculty/Subjectwise)  </B></TD>
			</font></td></tr>
			</TABLE>

			<table width="90%"  cellpadding=1 cellspacing=0  align=center rules=groups border=1>
			<tr><td colspan=5  align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Employee : &nbsp;</STRONG></font><font color=black face=arial size=2><%=mMemberName%>[<%=mDMemberCode%>]
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDept)%>
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesg)%>
			<hr></td></tr>

		<!--*********Exam**********-->
		<tr>
			<td  ALIGN=CENTER><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT> 
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
				

			<td >
		<!--*********LTP**********-->
			<FONT color=black face=Arial size=2><STRONG>LTP</STRONG></FONT>
			</td>
			<td>
			<select name="LTP" tabindex="2" id="LTP">
			
			<%
			if(request.getParameter("x")==null)
			{
				%>

				<option value="L" Selected>Lecture</option>
				<option value="P">Practical</option>
				
				<%
			}
			else
			{
				if((request.getParameter("LTP").toString().trim()).equals("L"))
				{
					%>

					<option value="L" Selected>Lecture</option>
					<option value="P">Practical</option>
					
					<%
				}
				else if((request.getParameter("LTP").toString().trim()).equals("P"))
				{
					%>

					<option value="L">Lecture</option>
					<option value="P" Selected>Practical</option>
					
					<%
				}
				
				
			}
			%>
			</select>&nbsp;


			<!--*********Department**********-->
			<td >
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
			if(request.getParameter("x")==null)
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
						
			</tr></td>
			</table>
		<%
				
		if(request.getParameter("GNEnter")!=null || request.getParameter("x")==null)
			{
				if(  request.getParameter("x")==null || request.getParameter("GNEnter").equals("GNE")  )
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
			

		if (request.getParameter("CNDefine")!=null)
			{
				if (request.getParameter("CNDefine").equals("CND"))
				{
					mCheck2="checked";
				}
			}

			%>
			<!--*********Exam Event Code**********-->
										
			<table border=1 align=center cellspacing=1 cellpadding=2 width=90% rules=none >
		
				<tr><td >
					<INPUT TYPE="checkbox" NAME="GNEnter" id="GNEnter" <%=mCheck%> value="GNE"><b><FONT face=Arial size=2>Grade Not Entered.</font></b>
				</td>
				<td>
					<INPUT TYPE="checkbox" NAME="GNLock" id="GNLock"   <%=mCheck1%> value="GNL"><b><FONT face=Arial size=2>Grade Entered but Not Locked</font></b>
				</td>
				<td>
					<INPUT TYPE="checkbox" NAME="CNDefine" id="CNDefine" <%=mCheck2%> value="CND"><b><FONT face=Arial size=2>Subject Co-ordinator Not Defined.</font></b>
				</td>
				</tr>
					
				<tr><td align=center>
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
		if (request.getParameter("LTP")==null)	
			{
				QryLTP="All";
				
			}
			else
			{
				QryLTP=request.getParameter("LTP").toString().trim();
				
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
			
			%>
			<form name="frm2" method="post" action="GradeEntryStatusXLS.jsp">
			
			<input id="Exam" name="Exam" type=hidden value="<%=mExamID%>">
			<INPUT TYPE="hidden" NAME="InstCode" value='<%=mInst%>'  > 
			<input id="Dept" name="Dept" type=hidden value="<%=QryDept%>">
							<input id="LTP" name="LTP" type=hidden value="<%=QryLTP%>">
			<input id="GNEnter" name="GNEnter" type=hidden value="<%=mGNEnter%>">
			<input id="GNLock" name="GNLock" type=hidden value="<%=mGNLock%>">
			<input id="CNDefine" name="CNDefine" type=hidden value="<%=mCNDefine%>">

			<table width="100%" ALIGN=CENTER bottommargin=0 cellspacing=0 cellpadding=0 topmargin=0 border=1>
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
			<td align=center><font face=arial size=3 color=Black><B>Grade Entry Status </font></B></td>
			
			</tr>
			<tr>
			<td nowrap valign=top>
			<Table valign=top width=100% border=1 bgcolor=white cellspacing=1 cellpadding=1 rules="row">
			<thead>
			<tr bgcolor="#ff8c00">
			<td nowrap><font color=white size=3 face=arial><B>Subject</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Co-Ordinator</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Faculty</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Batch</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Status</B></font></td>
			</tr>
			</thead>
			<%
			String qryf="";
			rs=null;
			ResultSet rsf=null;

			
		if(mGNEnter.equals("GNE") )
		{

				qry="SELECT DISTINCT a.fstid fstid, a.subjectid subjectid, a.employeeid employeeid,      a.programcode pc, a.sectionbranch sec,a.subsectioncode subsec, NVL (b.subject, ' ') || ' (' || NVL (b.subjectcode, ' ') || ')' subject, NVL (c.employeename, ' ') || ' (' || NVL (c.employeecode, ' ') || ')' faculty,'Grade Not Entered' status  FROM facultysubjecttagging a, subjectmaster b, employeemaster c WHERE  A.LTP='"+QryLTP+"' and a.institutecode = '"+mInst+"'     AND a.examcode = '"+mExamID+"'  AND a.institutecode = b.institutecode AND a.subjectid = b.subjectid AND a.employeeid = c.employeeid  AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"')            AND a.SUBJECTID NOT IN (                   SELECT DISTINCT SUBJECTID                              FROM GRADECALCULATION                             WHERE institutecode = '"+mInst+"'                               AND examcode = '"+mExamID+"'   )     AND  a.fstid IN (          SELECT fstid   FROM v#studentltpdetail  WHERE institutecode =  '"+mInst+"'    AND examcode =  '"+mExamID+"' AND NVL (deactive, 'N') = 'N' AND NVL(STUDENTDEACTIVE,'N')='N')  AND NVL (a.deactive, 'N') = 'N' AND a.projectsubject = 'N'   ORDER BY subject, faculty, programcode, sectionbranch, subsectioncode";

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
					<td ><Font size=2  face=arial><%=rs.getString("Subject")%></font></td>
					<%
						mSub=rs.getString("SUBJECTID");
				}
				else
				{
					%>
					<td ><Font size=2>-------do-------</font></td>
					<%
				}

					 qryf="select COORDINATORNAME,COORDINATORcode from V#EX#SUBJECTGRADECOORDINATOR where subjectid='"+rs.getString("SUBJECTID")+"' AND examcode='"+mExamID+"' AND INSTITUTECODE='"+mInst+"' ";
					//out.print(qryf);
					 rsf=db.getRowset(qryf);
				if(rsf.next())
				{
					%>
					<td ><Font size=2 color=red face=arial><%=rsf.getString("COORDINATORNAME")%><br>
					<%=rsf.getString("COORDINATORCODE")%></font></td>
					<%
				}
				else
				{
					%>
					<td ><Font size=2 color=red face=arial>Co-ordinator Not Defined</font></td>
					<%
				}

				if(!mFac.equals(rs.getString("EMPLOYEEID")))
				{
					%>
					<td ><Font size=2  face=arial><%=rs.getString("Faculty")%></font></td>
					<%
						mFac=rs.getString("EMPLOYEEID");
				}
				else
				{
					%>
					<td ><Font size=2>-------do-------</font></td>
					<%
				}
					%>
				<td ><Font size=2  face=arial><%=rs.getString("PC")%> (<%=rs.getString("SEC")%>-<%=rs.getString("SUBSEC")%>)</font></td>
				
				<td ><Font size=2 COLOR=DarkBrown face=arial><b><%=rs.getString("status")%></b></font></td>
				
				
				</tr>
				<%
			}
	
			}

			if( mGNLock.equals("GNL"))
			{
				qry1="SELECT DISTINCT a.subjectid subjectid, a.employeeid employeeid,      a.programcode pc, a.sectionbranch sec,a.subsectioncode subsec, NVL (b.subject, ' ') || ' (' || NVL (b.subjectcode, ' ') || ')' subject, NVL (c.employeename, ' ') || ' (' || NVL (c.employeecode, ' ') || ')' faculty ,'Grade Entered but not Locked' status FROM facultysubjecttagging a, subjectmaster b, employeemaster c WHERE   A.LTP='"+QryLTP+"' and a.institutecode = '"+mInst+"'     AND a.examcode = '"+mExamID+"'  AND a.institutecode = b.institutecode AND a.subjectid = b.subjectid AND a.employeeid = c.employeeid  AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"')            AND a.SUBJECTID IN (                   SELECT DISTINCT SUBJECTID                              FROM GRADECALCULATION                             WHERE institutecode = '"+mInst+"'                               AND examcode = '"+mExamID+"'                           AND NVL (FINALIZED, 'N') = 'N'                               ) AND a.fstid IN (          SELECT fstid   FROM v#studentltpdetail  WHERE institutecode =  '"+mInst+"'    AND examcode =  '"+mExamID+"' AND NVL (deactive, 'N') = 'N' AND NVL(STUDENTDEACTIVE,'N')='N')  AND NVL (a.deactive, 'N') = 'N' AND a.projectsubject = 'N'   ORDER BY subject, faculty, programcode, sectionbranch, subsectioncode";
			
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
					<td ><Font size=2  face=arial><%=rs.getString("Subject")%></font></td>
					<%
						mSub=rs.getString("SUBJECTID");
				}
				else
				{
					%>
					<td ><Font size=2  face=arial>-------do-------</font></td>
					<%
				}

				qryf="select COORDINATORNAME,COORDINATORcode from V#EX#SUBJECTGRADECOORDINATOR where subjectid='"+rs.getString("SUBJECTID")+"' AND examcode='"+mExamID+"' AND INSTITUTECODE='"+mInst+"' ";
					//out.print(qryf);
					 rsf=db.getRowset(qryf);
				if(rsf.next())
				{
					%>
					<td ><Font size=2 color=red face=arial><%=rsf.getString("COORDINATORNAME")%><br>
					<%=rsf.getString("COORDINATORCODE")%></font></td>
					<%
				}
				else
				{
					%>
					<td ><Font size=2 color=red face=arial>Co-ordinator Not Defined</font></td>
					<%
				}


				if(!mFac.equals(rs.getString("EMPLOYEEID")))
				{
					%>
					<td ><Font size=2  face=arial><%=rs.getString("Faculty")%></font></td>
					<%
						mFac=rs.getString("EMPLOYEEID");
				}
				else
				{
					%>
					<td ><Font size=2  face=arial>-------do-------</font></td>
					<%
				}
					%>
				<td ><Font size=2  face=arial><%=rs.getString("PC")%> (<%=rs.getString("SEC")%>-<%=rs.getString("SUBSEC")%>)</font></td>
				
				<td ><Font size=2 COLOR="DarkBrown" face=arial><b><%=rs.getString("status")%></b></font></td>
				
				
				</tr>
				<%
			}
		
			
			}
				
			if(mCNDefine.equals("CND"))
			{
				qry1="SELECT DISTINCT  a.subjectid subjectid, a.employeeid employeeid,      a.programcode pc, a.sectionbranch sec,a.subsectioncode subsec, NVL (b.subject, ' ') || ' (' || NVL (b.subjectcode, ' ') || ')' subject, NVL (c.employeename, ' ') || ' (' || NVL (c.employeecode, ' ') || ')' faculty ,'Co-ordinator Not Defined' status FROM facultysubjecttagging a, subjectmaster b, employeemaster c WHERE   A.LTP='"+QryLTP+"' and a.institutecode = '"+mInst+"'     AND a.examcode = '"+mExamID+"'  AND a.institutecode = b.institutecode AND a.subjectid = b.subjectid AND a.employeeid = c.employeeid  AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"')             AND A.subjectid not IN (SELECT DISTINCT subjectid FROM v#EX#SUBJECTGRADECOORDINATOR WHERE  institutecode = '"+mInst+"'  AND examcode =  '"+mExamID+"'   )  AND  a.fstid IN (          SELECT fstid   FROM v#studentltpdetail  WHERE institutecode =  '"+mInst+"'    AND examcode =  '"+mExamID+"' AND NVL (deactive, 'N') = 'N' AND NVL(STUDENTDEACTIVE,'N')='N')  AND NVL (a.deactive, 'N') = 'N' AND a.projectsubject = 'N'   ORDER BY subject, faculty, programcode, sectionbranch, subsectioncode";
			
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
					<td ><Font size=2  face=arial><%=rs.getString("Subject")%></font></td>
					<%
						mSub=rs.getString("SUBJECTID");
				}
				else
				{
					%>
					<td ><Font size=2  face=arial>-------do-------</font></td>
					<%
				}

			 qryf="select COORDINATORNAME,COORDINATORcode from V#EX#SUBJECTGRADECOORDINATOR where subjectid='"+rs.getString("SUBJECTID")+"' AND examcode='"+mExamID+"' AND INSTITUTECODE='"+mInst+"' ";
					//out.print(qryf);
					 rsf=db.getRowset(qryf);
				if(rsf.next())
				{
					%>
					<td ><Font size=2 color=red face=arial><%=rsf.getString("COORDINATORNAME")%><br>
					<%=rsf.getString("COORDINATORCODE")%></font></td>
					<%
				}
				else
				{
					%>
					<td ><Font size=2 color=red face=arial>Co-ordinator Not Defined</font></td>
					<%
				}
				if(!mFac.equals(rs.getString("EMPLOYEEID")))
				{
					%>
					<td ><Font size=2  face=arial><%=rs.getString("Faculty")%></font></td>
					<%
						mFac=rs.getString("EMPLOYEEID");
				}
				else
				{
					%>
					<td ><Font size=2>-------do-------</font></td>
					<%
				}
					%>
				<td ><Font size=2  face=arial><%=rs.getString("PC")%> (<%=rs.getString("SEC")%>-<%=rs.getString("SUBSEC")%>)</font></td>
				
				<td ><Font size=2 COLOR="darkOrange" face=arial><b><%=rs.getString("status")%></b></font></td>
				
				
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