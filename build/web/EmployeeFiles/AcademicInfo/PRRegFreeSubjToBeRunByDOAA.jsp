<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="";
String x="",t="",mfactype="",mSemType="",msemtype="";
int ctr=0;
int kk1=0;
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
String mLTP="";
String mltp="";

String mName1="",mName2="",mName4="",mName5="",mName6="",mName7="",mName8="", mName9="";

String mSubj="";
String msubj="";
String mSubjType="";
String msubjType="",mST="";

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
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Approval of Free Elective Subject(s) to be Run by DOAA ] </TITLE>
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

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInstitute=rs.getString(1);	
		else
			mInstitute="JIIT";
	     //-----------------------------
	     //-- Enable Security Page Level  
	     //-----------------------------
		
		mInst=mInstitute;

		qry="Select WEBKIOSK.ShowLink('123','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
	
			qry=" SELECT  a.EXAMCODE Exam,ENDATE from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and nvl(a.PRCOMPLETED,'N')='N' and ENDate is not null and fromdate is not null and nvl(a.PRBROADCAST,'N')='Y'";
			qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
			qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
			qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
			//out.print(qry);
			rs= db.getRowset(qry);			
			if(rs.next())
			{		
			mExam=rs.getString("Exam");
			%>
				<form name="frm"  method="get" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Free Elective Subject(s) Running Finalization by DOAA [Pre registration]</b></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>
				<tr>
				<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				try
				{ 
					if (request.getParameter("x")==null) 
				 	  {
						%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%   
						 
							
							if(mexam.equals(""))
 							mexam=mExam;
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>							
						</select>
						<%
					 }
					else
					{
					%>	
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%
						
							 
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
				<td>				

				<B> &nbsp; &nbsp; Semester Type &nbsp; </b><select ID=SemType Name=SemType style="WIDTH: 60px">
				<%
					msemtype="ALL";
					%>
				<option selected value="ALL">ALL</option>			     	
			 	</select>
				<INPUT Type="submit" Value="&nbsp;OK&nbsp;"></td></tr>
				</table>
				</form>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<form name="frm1" ID="frm1" Action="PRRegFreeELSubjToBeRunAction.jsp" method=post>
				<tr bgcolor='#ff8c00'>
				<th><font color=white>Program-Branch Academic Year</font></th>
				<th><font color=white>Subject</font></th>
				<th><font color=white>To Be Offered</font></th>
				<%
				int mData=1;
				int maxCol=0;
				int mSbjChoice=0;
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
				
				mST="F";
				qry="Select nvl(FREEELECTIVERUNFINALIZED,'N') from preventmaster where";
				qry=qry+" INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and nvl(PRCOMPLETED,'N') ='N'";
				qry=qry+" And nvl(PRREQUIREDFOR,'E')<>'S' and nvl(FREEELECTIVERUNFINALIZED,'N')='N' ";
				qry=qry+" and nvl(DEACTIVE,'N')='N'";
				rs=db.getRowset(qry);
				if (rs.next() && rs.getString(1).equals("N"))
				{
				qry="Select Max(B.CHOICE) CHOICE from  PR#STUDENTSUBJECTCHOICE B Where ";
				qry=qry+" B.INSTITUTECODE='"+mInstitute+"' And B.EXAMCODE='"+mE+"' And B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') ";
				qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (Select D.INSTITUTECODE, D.EXAMCODE ";
				qry=qry+" From PREVENTMASTER D Where D.EXAMCODE='"+mE+"' and nvl(D.DEACTIVE,'N')='N' ";
				qry=qry+" AND NVL(D.FREEELECTIVERUNFINALIZED,'N')='N' And (D.INSTITUTECODE, D.PREVENTCODE) not in (Select E.INSTITUTECODE, E.PREVENTCODE ";
				qry=qry+" From PREVENTS E Where E.MEMBERTYPE<>'S' and nvl(E.LOADDISTRIBUTIONSTATUS,'N')='Y' and nvl(E.DEACTIVE,'N')='N') )";
				rs=db.getRowset(qry);

					if (rs.next()) 
						maxCol=rs.getInt(1); 
					else 
						maxCol=0;

					for(int i=1;i<=maxCol;i++)
					{
					%>
					 <th><font color=white>Choice-<%=i%></font></th>
					<%
					}
					%>
					</tr>
					<%
					if(mST.equals("F"))
					{
						qry="select nvl(A.Subject,A.SubjectCode ) SUBJECT, A.SubjectID SID, A.SubjectCode SC, max(B.CHOICE) MaxChoice,  NVL(c.ACADEMICYEAR,' ') ACADEMICYEAR, c.PROGRAMCODE, c.TAGGINGFOR, c.SECTIONBRANCH SECTIONBRANCH, c.SEMESTER SEMESTER, nvl(C.SubjectRunning,'N') LastStatus from SUBJECTMASTER A, ";
						qry=qry+" PR#STUDENTSUBJECTCHOICE B, FREEELECTIVE C  where A.INSTITUTECODE=B.INSTITUTECODE And A.INSTITUTECODE=C.INSTITUTECODE And B.SUBJECTTYPE='"+mST+"'";
						qry=qry+" And B.INSTITUTECODE=C.INSTITUTECODE And B.EXAMCODE=C.EXAMCODE and b.ACADEMICYEAR=C.ACADEMICYEAR And B.PROGRAMCODE=C.PROGRAMCODE and B.TAGGINGFOR=C.TAGGINGFOR ";
						qry=qry+" And B.SECTIONBRANCH=C.SECTIONBRANCH and b.SEMESTER=C.SEMESTER AND B.SUBJECTID=C.SUBJECTID";
						qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and A.SUBJECTID=C.SUBJECTID and b.ExamCode=C.ExamCode and B.EXAMCODE='"+mE+"'  And  B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') "; 
						qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(pe.FREEELECTIVERUNFINALIZED,'N')='N' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
						qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) not in (Select D.INSTITUTECODE, D.PREVENTCODE ";
						qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='Y' and nvl(D.DEACTIVE,'N')='N') )";
						qry=qry+" And nvl(A.DEACTIVE,'N')='N' And nvl(B.DEACTIVE,'N')='N' And nvl(C.Deactive,'N')='N'";
						qry=qry+" Group By A.Subject, A.SubjectCode, A.SubjectID, c.ACADEMICYEAR , c.PROGRAMCODE, c.TAGGINGFOR , c.SECTIONBRANCH , c.SEMESTER, C.SubjectRunning ";
						qry=qry+" Order by A.SubjectCode ,count(*) Desc,Subject";
					}
					//out.print(qry);
					rs=db.getRowset(qry);	
					%>
					<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
					<input type=hidden Name='ExamCode' ID='ExamCode' value='<%=mE%>'>
					<input type=hidden Name='SubjectType' ID='SubjectType' value='<%=mST%>'>
					<input type=hidden Name='SemType' ID='SemType' value='<%=mSemType%>'>
					<%
					int mChoice=0;
					String mLastStatus="";
					//out.print("Vijay");
					while(rs.next())
					{ 
						mData=1;
						ctr++;

						mName1="SUBJCODE"+ctr;
						mName2="RUNNING"+ctr;
						mName4="LASTSTATUS"+ctr;
						mName5="PRGCODE"+ctr;
						mName6="TAGGINGFOR"+ctr;
						mName7="SECIONBRANCH"+ctr;
						mName8="ACYEAR"+ctr;
						mName8="SUBJID"+ctr;

						mLastStatus=rs.getString("LastStatus");
						%>
						<tr>
						<td>&nbsp;<%=rs.getString("PROGRAMCODE")%>-<%=rs.getString("SECTIONBRANCH")%>
						 &nbsp;(<%=rs.getString("ACADEMICYEAR")%>)</td>
						<td nowrap><%=rs.getString("SC")%>&nbsp;-&nbsp;<%=rs.getString("SUBJECT")%></td>
						<input type=hidden Name=<%=mName1%> ID=<%=mName1%> value='<%=rs.getString("SC")%>'>
						<input type=hidden Name=<%=mName4%> ID=<%=mName4%> value='<%=mLastStatus%>'>
						<input type=hidden Name=<%=mName5%> ID=<%=mName5%> value='<%=rs.getString("PROGRAMCODE")%>'>
						<input type=hidden Name=<%=mName6%> ID=<%=mName6%> value='<%=rs.getString("TAGGINGFOR")%>'>
						<input type=hidden Name=<%=mName7%> ID=<%=mName7%> value='<%=rs.getString("SECTIONBRANCH")%>'>
						<input type=hidden Name=<%=mName8%> ID=<%=mName8%> value='<%=rs.getString("ACADEMICYEAR")%>'>
						<input type=hidden Name=<%=mName9%> ID=<%=mName9%> value='<%=rs.getString("SID")%>'>
					 	<td><select name="<%=mName2%>" id="<%=mName2%>">
								<%
								 if (mLastStatus.equals("Y"))
								 {
								 %>
							        <option selected Value=Y>Yes</option>
						 		  <option Value=N>No</option>
								 <%
								  }
								 else
								  {
								 %>
							        <option selected Value=N>No</option>
								  <option Value=Y>Yes</option>
								 <%
								  }
							        %>
							   </select>
						</td>
						<%
							// Subject cum Choice wise Student Count
							
						    for (int mCh=1;mCh<=maxCol;mCh++)
							{
								qry="Select nvl(count(B.CHOICE),-1) Tot from  PR#STUDENTSUBJECTCHOICE B Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And B.SUBJECTTYPE='"+mST+"'";
								qry=qry+" And b.SubjectID='"+rs.getString("SID")+"' And B.Choice="+mCh+" And nvl(B.DEACTIVE,'N')='N'";
								qry=qry+" And b.ACADEMICYEAR='"+rs.getString("ACADEMICYEAR") +"' And  PROGRAMCODE='"+rs.getString("PROGRAMCODE") +"' and b.TAGGINGFOR='"+rs.getString("TAGGINGFOR")+"'";
								qry=qry+" And b.SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"' and b.SEMESTER='"+rs.getString("SEMESTER")+"'";

								//out.print(qry);
								rs1=db.getRowset(qry);
							      if (rs1.next() && rs1.getInt(1)>0)
								   {
									%>
										<td align=right><%=rs1.getInt(1)%>&nbsp;&nbsp;</td>
									<%
								    }		
								else
								   {
									%>
										<td>&nbsp;</td>
									<%

								   }			
							  }
					


					%>
					</tr>
					<%
					
  					}

			if (mData==1)
				{
				%>				 
				<tr><td colspan=<%=maxCol+5%> ALIGN=CENTER><font color=Blue size=3><b>Free Elective Subject(s) to be Run is <sup>#</sup>Finalized</b>?&nbsp; <input name=finalized id=finalized type="Radio" Value="YES"><b>Yes</b>&nbsp; &nbsp; &nbsp;<input Type="Radio" value="NO" checked name=finalized id=finalized><b>No</b> </font></td></tr>

				<TR><TD colspan=<%=maxCol+5%> ALIGN=CENTER><INPUT Type="submit" Value="Save Running Subjects"></TD></TR>
				<%
				}
				%>
				<input type=hidden Name='Total' ID='Total' value='<%=ctr%>'>
				<tr><td colspan=<%=maxCol+5%>
				<b><u>Note:</u></b><br>
				<font color=red><b><sup>#</sup>Finalized:</b>
					Once You <b>Finalized</b> (Select <b>YES</b> and click on <b>SAVE</b>) then further modification of Free Elective Subjects will not be possible.
					<br>Secondly, Until you Lock and Finalized it, Load Distribution by HOD can not take place.
				</red></td></tr>
			</form>
			</TABLE>
			 <%
			}
			else
			{
			%></TABLE>

			<font color=red>
			<h3>	<br><img src='../../Images/Error1.jpg'>
			Pre- Registration Free Elective Sbjects already finalized and locked</FONT><br>
			Click here to see a list of finalized <a href='ElectiveSubjectRunningList.jsp'>Free Elective Sbjects(Running)</a></P>

			 <%

			}
		
  		}
		else
		{
		%></TABLE>

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
	<br></TABLE>

	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>This page is not authorized/available for you.
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
//out.print("error");
}
%>
</body>
</html>