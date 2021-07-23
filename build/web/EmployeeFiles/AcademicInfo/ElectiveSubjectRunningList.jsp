<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="",mst="";
String qry1="";
String x="",t="",mfactype="",mSemType="",msemtype="";
int ctr=0;
int kk1=0;
int mRights=0;
String Tagg="";
int Data=0;
String v="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="";
String mExam="",mE="";
String mexam="";
String mLTP="", mL="", mT="", mP="";
String mltp="";
String mSubj="",mELECTIVECODE="",mDepcode="";
String msubj="";
String mSubjType="";
String msubjType="",mST="",mSubcode="",mSubid="",mDept="";
String Heading="", mType="";

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
if (request.getParameter("Type")==null)
{
	mType="";
}
else
{
	mType=request.getParameter("Type").toString().trim();
}

if (request.getParameter("DID")==null)
{
if (session.getAttribute("DepartmentCode")==null)
				mDept="";
			else
				mDept=session.getAttribute("DepartmentCode").toString().trim();
}
else
{
			mDept=request.getParameter("DID").toString().trim();
}



String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Elective Subject Running List] </TITLE>
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
		
		mInst=mInstitute;
//out.print(mType+1111111111);
		if(mType.equals("D"))
		{
		   //out.print(mType);
		   mRights=119;
		   Heading="DOAA";	
		}
		else 
		{
		   mRights=120;
		   Heading="HOD";	
		}

		qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
	//	out.println(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
	
			qry=" SELECT distinct a.EXAMCODE from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInst+"'  and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
			qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
			qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
			qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
			rs= db.getRowset(qry);			
				//out.print(qry);
			if(rs.next())
			{		
				%>
				<form name="frm"  method="get">
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Elective Subject(s) Running List</B></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 width="99%" align=center rules=groups border=3>
				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInst%>'>
				<input type=hidden Name=Type ID=Type value=<%=mType%>>
				<tr>
				<!--*********Exam**********-->
				<td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				try
				{
					qry=" SELECT distinct a.EXAMCODE exam from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and  nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
					qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
					qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
					qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
					rs=db.getRowset(qry);
					//out.println(qry);
					if (request.getParameter("x")==null) 
					{
						%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%   
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mexam.equals(""))
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
				// out.println("Error Msg");
				}
				%>
				</td>
				<!--SubJect Type**********-->
				<td nowrap>
				<FONT color=black><FONT face=Arial size=2><STRONG>Subject Type</STRONG></FONT></FONT>
				<select ID=SubjType Name=SubjType style="WIDTH: 130px">
				<%
				if(request.getParameter("SubjType")==null)
				{	mst="E";
					%>
			     		<option Selected value="E">Elective</option>
			     		<!-- <option value="F">Free Elective</option> -->
					<%
				}
				else
				{
		
					if(request.getParameter("SubjType").toString().trim().equals("E"))
					{
						%>
						<option value="E" Selected>Elective</option>
						<%
					}
					else
					{
					%>
						<option value="E">Elective</option>
					<%
					}

					
				}
				%>
			 	</select>
				<FONT color=black><FONT face=Arial size=2><STRONG>Semester Type</STRONG></FONT></FONT>
				<select ID=SemType Name=SemType style="WIDTH: 60px">
					<%
					msemtype="REG";
					%>
				<option selected value="REG">REG</option>			     	
			 	</select>
				<INPUT Type="submit" Value="&nbsp;OK&nbsp;"></td></tr>
				</table>
				</form>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<tr bgcolor='#e68a06'>
				 <th><font color=white>SNo.</font></th>
				 <th align=center><font color=white>Subject Code</font></th>
				 <th align=center><font color=white>Subject Description</font></th>
				 <th title="Lecture"><font color=white>&nbsp;L&nbsp;</font></th>
				 <th title="Tutorial"><font color=white>&nbsp;T&nbsp;</font></th>
				 <th title="Practical"><font color=white>&nbsp;P&nbsp;</font></th>
				 <th align=center title="Course Credit Point"><font color=white>Credit Point</font></th>
				<%
				int mData=0;
				int maxCol=0;

				if (request.getParameter("InstCode")==null)
						mInstitute=mInst;
					else		
						mInstitute=request.getParameter("InstCode").toString().trim();
		
					if (request.getParameter("Exam")==null)
						mE=mexam;
					else
						mE=request.getParameter("Exam").toString().trim();
			
					if(request.getParameter("SemType")==null)
						mSemType=msemtype;
					else
						mSemType=request.getParameter("SemType").toString().trim();


					if(request.getParameter("SubjType")!=null)	
						mST=request.getParameter("SubjType").toString().trim();
					else
						mST=mst;

				//	mType=request.getParameter("Type").toString().trim();
					if(mType.equals("D"))
					{
					   mRights=119;
					   Heading="DOAA";	
					}
					else 
					{
					   mRights=120;
					   Heading="HOD";	
					}
//--------------------------------------------HOD-------------------------------------
					//if(mType.equals("H"))
					if(1==1)
					{
					   if (mST.equals("E"))
					   {
						//out.println("hello");
						qry="select nvl(A.Subject,A.SubjectCode ) SUBJECT , A.SubjectCode SC, B.SubjectID SID, nvl(B.ElectiveCode, ' ') ElectiveCode, max(B.CHOICE) MaxChoice, nvl(C.SubjectRunning,'N') LastStatus,nvl(C.L,'0') L,nvl(C.T,'0') T,nvl(C.P,'0') P,nvl(c.COURSECREDITPOINT,'0')COURSECREDITPOINT from SUBJECTMASTER A, ";
						qry=qry+" PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C,pR#DepartmentSubjectTagging DST where A.INSTITUTECODE=B.INSTITUTECODE And A.INSTITUTECODE=C.INSTITUTECODE And B.SUBJECTTYPE='"+mST+"'and B.ELECTIVECODE=C.ELECTIVECODE";
						qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and A.SUBJECTID=C.SUBJECTID and b.ExamCode=C.ExamCode and B.EXAMCODE='"+mE+"'  And  B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') "; 
						qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (Select D.INSTITUTECODE, D.EXAMCODE ";
						qry=qry+" from PREVENTMASTER D Where D.EXAMCODE='"+mE+"' And  nvl(D.DEACTIVE,'N')='N') ";
						qry=qry+" And nvl(A.DEACTIVE,'N')='N' And nvl(B.DEACTIVE,'N')='N' And nvl(C.Deactive,'N')='N'";
						qry=qry+" and B.SUBJECTID in (select C.SUBJECTID from PR#DEPARTMENTSUBJECTTAGGING C ";
						qry=qry+" where  departmentcode in (select departmentcode ";
						qry=qry+" from employeemaster where employeeid in (select employeeid from hodlist ";
						qry=qry+" where employeeid='"+mDMemberID+"')))";
						qry=qry+" And B.INSTITUTECODE=DST.INSTITUTECODE and B.ACADEMICYEAR=DST.ACADEMICYEAR and B.PROGRAMCODE=DST.PROGRAMCODE and B.TAGGINGFOR=DST.TAGGINGFOR and B.SECTIONBRANCH=DST.SECTIONBRANCH";
						qry=qry+" And C.INSTITUTECODE=DST.INSTITUTECODE and C.ACADEMICYEAR=DST.ACADEMICYEAR and C.PROGRAMCODE=DST.PROGRAMCODE and c.TAGGINGFOR=DST.TAGGINGFOR and c.SECTIONBRANCH=DST.SECTIONBRANCH";
						qry=qry+" And C.SubjectID=DST.SubjectID and A.SubjectID=DST.SubjectID and B.SubjectID=DST.SubjectID and DST.departmentcode='"+ mDept +"'";
						qry=qry+" Group By B.ElectiveCode,A.SUBJECTCODE, B.SUBJECTID,nvl(A.Subject,A.SUBJECTCODE), nvl(C.SubjectRunning,'N'),C.L,C.T,C.P,C.COURSECREDITPOINT";
						qry=qry+" Order by ElectiveCode,count(*) Desc,Subject";
					   }
					   
					}

//--------------------------------------------DOAA-------------------------------------
					//if(mType.equals("D"))
					if(1==1)
					{
					   if (mST.equals("E"))
					   {
						   						//out.println("hello123");
						/*qry="select nvl(A.Subject,A.SubjectCode ) SUBJECT , A.SubjectCode SC, B.SubjectID SID, nvl(B.ElectiveCode, ' ') ElectiveCode, max(B.CHOICE) MaxChoice, nvl(C.SubjectRunning,'N') LastStatus,nvl(C.L,'0') L,nvl(C.T,'0') T,nvl(C.P,'0') P,nvl(c.COURSECREDITPOINT,'0')COURSECREDITPOINT from SUBJECTMASTER A, ";
						qry=qry+" PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C,pR#DepartmentSubjectTagging DST where A.INSTITUTECODE=B.INSTITUTECODE And A.INSTITUTECODE=C.INSTITUTECODE And B.SUBJECTTYPE='"+mST+"'and B.ELECTIVECODE=C.ELECTIVECODE";
						qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and A.SUBJECTID=C.SUBJECTID and b.ExamCode=C.ExamCode and B.EXAMCODE='"+mE+"'  And  B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') "; 
						qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (Select D.INSTITUTECODE, D.EXAMCODE ";
						qry=qry+" from PREVENTMASTER D Where D.EXAMCODE='"+mE+"' and nvl(D.DEACTIVE,'N')='N') ";
						qry=qry+" And nvl(A.DEACTIVE,'N')='N' And nvl(B.DEACTIVE,'N')='N' And nvl(C.Deactive,'N')='N'";
						qry=qry+" Group By B.ElectiveCode,A.SubjectCode,B.SUBJECTID,nvl(A.Subject,A.SubjectCode), nvl(C.SubjectRunning,'N'),C.L,C.T,C.P,C.COURSECREDITPOINT";
						qry=qry+" Order by ElectiveCode,count(*) Desc,Subject";*/

						qry="select nvl(A.Subject,A.SubjectCode ) SUBJECT , A.SubjectCode SC, B.SubjectID SID, nvl(B.ElectiveCode, ' ') ElectiveCode, max(B.CHOICE) MaxChoice, nvl(C.SubjectRunning,'N') LastStatus,nvl(C.L,'0') L,nvl(C.T,'0') T,nvl(C.P,'0') P,nvl(c.COURSECREDITPOINT,'0')COURSECREDITPOINT from SUBJECTMASTER A, ";
						qry=qry+" PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C,pR#DepartmentSubjectTagging DST where A.INSTITUTECODE=B.INSTITUTECODE And A.INSTITUTECODE=C.INSTITUTECODE And B.SUBJECTTYPE='"+mST+"'and B.ELECTIVECODE=C.ELECTIVECODE";
						qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and A.SUBJECTID=C.SUBJECTID and b.ExamCode=C.ExamCode and B.EXAMCODE='"+mE+"'  And  B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') "; 
						qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (Select D.INSTITUTECODE, D.EXAMCODE ";
						qry=qry+" from PREVENTMASTER D Where D.EXAMCODE='"+mE+"' And  nvl(D.DEACTIVE,'N')='N') ";
						qry=qry+" And nvl(A.DEACTIVE,'N')='N' And nvl(B.DEACTIVE,'N')='N' And nvl(C.Deactive,'N')='N'";
						qry=qry+" And B.INSTITUTECODE=DST.INSTITUTECODE and B.ACADEMICYEAR=DST.ACADEMICYEAR and B.PROGRAMCODE=DST.PROGRAMCODE and B.TAGGINGFOR=DST.TAGGINGFOR and B.SECTIONBRANCH=DST.SECTIONBRANCH";
						qry=qry+" And C.INSTITUTECODE=DST.INSTITUTECODE and C.ACADEMICYEAR=DST.ACADEMICYEAR and C.PROGRAMCODE=DST.PROGRAMCODE and c.TAGGINGFOR=DST.TAGGINGFOR and c.SECTIONBRANCH=DST.SECTIONBRANCH";
						qry=qry+" And C.SubjectID=DST.SubjectID and A.SubjectID=DST.SubjectID and B.SubjectID=DST.SubjectID ";
						qry=qry+" Group By B.ElectiveCode,A.SUBJECTCODE, B.SUBJECTID,nvl(A.Subject,A.SUBJECTCODE), nvl(C.SubjectRunning,'N'),C.L,C.T,C.P,C.COURSECREDITPOINT";
						qry=qry+" Order by ElectiveCode,count(*) Desc,Subject";
					   }
					  
					}
					//out.print(qry);
					rs=db.getRowset(qry);
					String mColor="";
					int mChoice=0;
					String mLastStatus="";
					String mCol1="LightGrey";
					String OldmELECTIVECODE="";
					String mCol2="white";

	while(rs.next())
		{ 
			mLastStatus=rs.getString("LastStatus");
			mSubid=rs.getString("SID");
			mSubcode=rs.getString("SC");
                if(mLastStatus.equals("Y"))
				{
					mData=1;
					ctr++;
					if (mST.equals("E"))
						mELECTIVECODE=rs.getString("ELECTIVECODE");
					else
						mELECTIVECODE=" ";
					if (!mELECTIVECODE.equals(OldmELECTIVECODE))
					{
					   if (mChoice==0)
						mChoice=1 ;
					   else
						mChoice=0 ;
					   OldmELECTIVECODE=mELECTIVECODE;
					}

					if (mChoice==0) 
					      mColor=mCol1;
					else
					      mColor=mCol2;
					%>
					<tr bgcolor="<%=mColor%>">
					<td>&nbsp;<%=ctr%></td>
					<%
							if(mST.equals("E"))
							{
					%>
							<td align=center title="Elective Subject Running Deparment List"><a target=_New href="ElectiveSubjRunningDeptList.jsp?SUBJID=<%=mSubid%>&amp;SUBJ=<%=mSubcode%>&amp;EXAM=<%=mE%>&amp;INST=<%=mInstitute%>&amp;STYPE=<%=mST%>&amp;SEMTYPE=<%=mSemType%>&amp;ELECODE=<%=mELECTIVECODE%>"><%=rs.getString("SC")%></a></td>
							<%
							}
							
							if (mELECTIVECODE.equals(" "))
					      	{
							%>
								<td nowrap><%=rs.getString("SUBJECT")%></td>
							<%
							}
							else	
							{
							%>
								<td nowrap><%=rs.getString("SUBJECT")%>&nbsp;(<%=mELECTIVECODE%>)&nbsp;</td>
							<%		
							}
							if(Integer.parseInt(rs.getString("L"))>0)
							{
							%>
							<td>&nbsp;<%=rs.getString("L")%>&nbsp;</td>
							<%
							}
							else
							{
							%>
							<td>&nbsp;</td>
							<%
							}
							if(Integer.parseInt(rs.getString("T"))>0)
							{
							%>
							<td>&nbsp;<%=rs.getString("T")%>&nbsp;</td>
							<%
							}
							else
							{
							%>
							<td>&nbsp;</td>
							<%
							}
							if(Integer.parseInt(rs.getString("P"))>0)
							{
							%>
							<td>&nbsp;<%=rs.getString("P")%>&nbsp;</td>
							<%
							}
							else
							{
							%>
							<td>&nbsp;</td>
							<%
							}
							%>
							<td align=center title="Course Credit Point">&nbsp;<%=rs.getString("COURSECREDITPOINT")%></td>
							<%
						}
						%>
						</tr>
						<%
  					}
				%>
				</TABLE>
				 <%
		  		}
				else
				{
					%>
					<font color=red>
					<h3>	<br><img src='../../Images/Error1.jpg'> Pre- Registration Event has not been declared</FONT></P>
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
				<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
				<P>This page is not authorized/available for you.
				<br>For assistance, contact your network support team. 
				</font><br><br><br><br>
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
		
	}
%>
</body>
</html>