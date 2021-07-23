<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String mEID="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mE="";
String mST="";
String mSemType="";
String mRunStatus="", mDept="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="";



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
<HTML>
<head>
<TITLE>#### <%=mHead%> [ List of Finalized Elective Subject(s) to be Approved by DOAAA ] </TITLE>
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

		qry="Select WEBKIOSK.ShowLink('123','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
			if (request.getParameter("EX")==null)
				mE="";
			else
				mE=request.getParameter("EX").toString().trim();

			mST="E";
			if (request.getParameter("EID")==null)
				mEID="";
			else
				mEID=request.getParameter("EID").toString().trim();

			

			if (request.getParameter("DID")==null)
				mDept="";
			else
				mDept=request.getParameter("DID").toString().trim();

			if (request.getParameter("STYP")==null)
				mSemType="ALL";
			else
				mSemType=request.getParameter("DID").toString().trim();

			if (request.getParameter("ST")==null)
				mRunStatus="N";
			else
				mRunStatus=request.getParameter("ST").toString().trim();
				int mData=0;
				int maxCol=0,ctr=0;
			//	int mSbjChoice=0;


			qry="Select nvl(APPROVED,'N') APPROVED from  PREVENTS E Where E.INSTITUTECODE='"+mInstitute+"' And E.MEMBERTYPE<>'S' ";
			qry=qry+" And E.MEMBERID='"+mEID+"' And nvl(E.ELRNNINGFINALIZEDBYHOD,'N')='Y' and nvl(E.LOADDISTRIBUTIONSTATUS,'N')='N' ";
			qry=qry+" and nvl(E.DEACTIVE,'N')='N'  And (E.INSTITUTECODE,E.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
			qry=qry+" from PREVENTMASTER D Where D.EXAMCODE='"+mE+"' and nvl(PRCOMPLETED,'N')='N' and nvl(PRREQUIREDFOR,'S')<>'S' and nvl(D.DEACTIVE,'N')='N')";

			String mok="N"	;
			rs=db.getRowset(qry);
			if (rs.next())
				{
					if(rs.getString(1).equals("N"))
					{
						mok="Y";
					}
					else
					{
						mok="N";
					}
				}
			
			
			if (mRunStatus.equals("No") && mok.equals("Y"))
				{

				

				%>				
				<Center><font color'darkbrown' face='Arial' size=3'><b>List of Finalized Elective Subject(s) to be Approved by DOAA</b></font>				
				<hr>
				 &nbsp; &nbsp; &nbsp; <b>Login Member:<%=mMemberName%> &nbsp; &nbsp; &nbsp; Exam Code:<%=mE%> &nbsp; &nbsp; &nbsp; &nbsp;Department: <%=mDept%></b>	
				<hr></center>

				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<form name="frm1" ID="frm1" Action="PRRegELApprActAction.jsp" method=post>
				<tr bgcolor='#e68a06'>
				<th align=left>Program-Branch (Academic Year)
				<th>Subject</th>
				<th>Is Approved?</th>
				<%
				qry="select max(B.CHOICE) CHOICE from  PR#STUDENTSUBJECTCHOICE B where ";
				qry=qry+" B.INSTITUTECODE='"+mInstitute+"' And B.EXAMCODE='"+mE+"' And B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') ";
				qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (Select D.INSTITUTECODE, D.EXAMCODE ";
				qry=qry+" from PREVENTMASTER D Where D.EXAMCODE='"+mE+"' and nvl(D.DEACTIVE,'N')='N' ";
				qry=qry+" And (D.INSTITUTECODE, D.PREVENTCODE) in (Select E.INSTITUTECODE, E.PREVENTCODE ";
				qry=qry+" from PREVENTS E Where E.MEMBERTYPE<>'S' and E.MEMBERID='"+mEID+"' And nvl(E.ELRNNINGFINALIZEDBYHOD,'N')='Y' and nvl(E.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(E.DEACTIVE,'N')='N') )";
					rs=db.getRowset(qry);

					if (rs.next()) 
						maxCol=rs.getInt(1); 
					else 
						maxCol=0;

					for(int i=1;i<=maxCol;i++)
					{
					%>
					 <th>Choice-<%=i%></th>
					<%
					}
					%>
					</tr>
					<%
					qry="select BDT.PROGRAMCODE PROGRAMCODE ,BDT.ACADEMICYEAR ACADEMICYEAR,BDT.TAGGINGFOR TAGGINGFOR, BDT.SECTIONBRANCH SECTIONBRANCH, nvl(A.Subject,A.SubjectID ) SUBJECT , B.SubjectID SC, nvl(B.ElectiveCode, ' ') ElectiveCode, max(B.CHOICE) MaxChoice, nvl(C.SubjectRunning,'N') LastStatus from SUBJECTMASTER A, ";
					qry=qry+" PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C, BRANCHDEPTTAGGING BDT  where A.INSTITUTECODE=B.INSTITUTECODE And A.INSTITUTECODE=C.INSTITUTECODE And B.SUBJECTTYPE='"+mST+"'";
					qry=qry+" And NVL(C.SubjectRunning,'N')='Y'";
					qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and A.SUBJECTID=C.SUBJECTID and b.ExamCode=C.ExamCode and B.EXAMCODE='"+mE+"' And B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') ";
					qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
					qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
					qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and D.MEMBERID='"+mEID+"' And nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='Y' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
					qry=qry+" And nvl(A.DEACTIVE,'N')='N' And nvl(B.DEACTIVE,'N')='N' And nvl(C.Deactive,'N')='N'";
					qry=qry+" And B.INSTITUTECODE=BDT.INSTITUTECODE and B.ACADEMICYEAR=BDT.ACADEMICYEAR and B.PROGRAMCODE=BDT.PROGRAMCODE and B.TAGGINGFOR=BDT.TAGGINGFOR and B.SECTIONBRANCH=BDT.SECTIONBRANCH";
					qry=qry+" And C.INSTITUTECODE=BDT.INSTITUTECODE and C.ACADEMICYEAR=BDT.ACADEMICYEAR and C.PROGRAMCODE=BDT.PROGRAMCODE and c.TAGGINGFOR=BDT.TAGGINGFOR and c.SECTIONBRANCH=BDT.SECTIONBRANCH";
					qry=qry+" Group By BDT.PROGRAMCODE ,BDT.ACADEMICYEAR,BDT.TAGGINGFOR, BDT.SECTIONBRANCH,B.ElectiveCode,B.SubjectID,nvl(A.Subject,A.SubjectID), nvl(C.SubjectRunning,'N')";					
					qry=qry+" Order by ElectiveCode,count(*) Desc,Subject";
					//out.print(qry);
					rs=db.getRowset(qry);
	
					%>
					<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
					<input type=hidden Name='ExamCode' ID='ExamCode' value='<%=mE%>'>
					<input type=hidden Name='SubjectType' ID='SubjectType' value='<%=mST%>'>
					<input type=hidden Name='SemType' ID='SemType' value='<%=mSemType%>'>
					<input type=hidden Name='EID' ID='EID' value='<%=mEID%>'>

					<%

					String mColor="";
					int mChoice=0;
					String mELECTIVECODE="";
					int mSbjChoice=0;

					String mLastStatus="";
					String mCol1="LightGrey";
					String mCol2="#ffffff";
					String mChkCode="",mChkOldCode="";

					while(rs.next())
					{ 
						mData=1;
						ctr++;
						mName1="SUBJCODE"+ctr;
						mName2="RUNNING"+ctr;
						mName3="ELECTIVE"+ctr;
						mName4="LASTSTATUS"+ctr;
						mName5="PRGCODE"+ctr;
						mName6="TAGGINGFOR"+ctr;
						mName7="SECIONBRANCH"+ctr;
						mName8="ACYEAR"+ctr;
						mChkCode=rs.getString("PROGRAMCODE")+rs.getString("SECTIONBRANCH") +rs.getString("ACADEMICYEAR")+rs.getString("ELECTIVECODE");
						if (mST.equals("E"))
							mELECTIVECODE=rs.getString("ELECTIVECODE");
						else
							mELECTIVECODE=" ";

						mSbjChoice=rs.getInt("MaxChoice");


						if (!mChkCode.equals(mChkOldCode))
							{
							   if (mChoice==0)
								mChoice=1 ;
							   else
								mChoice=0 ;
							   mChkCode=mChkOldCode;
							}

						if (mChoice==0) 
							mColor=mCol1;
						else
						      mColor=mCol2;

						mLastStatus=rs.getString("LastStatus");
						%>
						<tr bgcolor="<%=mColor%>">
						<td>&nbsp;<%=rs.getString("PROGRAMCODE")%>-<%=rs.getString("SECTIONBRANCH")%>
						 &nbsp;(<%=rs.getString("ACADEMICYEAR")%>)</td>
						<td>&nbsp;<%=rs.getString("SC")%>&nbsp; - &nbsp;
						<%
						      if (mELECTIVECODE.equals(" "))
					      	{
							%>	
								<%=rs.getString("SUBJECT")%>
							<%
							}
							else	
							{		
							%>
								<%=rs.getString("SUBJECT")%>&nbsp;(<%=mELECTIVECODE%>)&nbsp;
							<%		
							}

						%>
						</td>
						<input type=hidden Name=<%=mName1%> ID=<%=mName1%> value='<%=rs.getString("SC")%>'>
						<input type=hidden Name=<%=mName3%> ID=<%=mName3%> value='<%=mELECTIVECODE%>'>
						<input type=hidden Name=<%=mName4%> ID=<%=mName4%> value='<%=mLastStatus%>'>
						<input type=hidden Name=<%=mName5%> ID=<%=mName5%> value='<%=rs.getString("PROGRAMCODE")%>'>
						<input type=hidden Name=<%=mName6%> ID=<%=mName6%> value='<%=rs.getString("TAGGINGFOR")%>'>
						<input type=hidden Name=<%=mName7%> ID=<%=mName7%> value='<%=rs.getString("SECTIONBRANCH")%>'>
						<input type=hidden Name=<%=mName8%> ID=<%=mName8%> value='<%=rs.getString("ACADEMICYEAR")%>'>
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

								qry="select nvl(count(B.CHOICE),-1) Tot from  PR#STUDENTSUBJECTCHOICE B Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And B.SUBJECTTYPE='"+mST+"'";
								qry=qry+" And B.SubjectID='"+rs.getString("SC")+"' And B.Choice="+mCh+" And (b.INSTITUTECODE,b.EXAMCODE) ";
								qry=qry+" in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
								qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
								qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and D.MEMBERID='"+mEID+"' And nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='Y' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
								
								qry=qry+" And B.ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and B.PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"'";
								qry=qry+" And B.TAGGINGFOR='"+rs.getString("TAGGINGFOR")+"' and B.SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"'";
								qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								qry=qry+" Order by Choice";

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
				
				%>				 
				<tr><td colspan=<%=maxCol+5%> ALIGN=CENTER><font color=Blue size=3><b>Elective Subject(s) to be Run is <sup>#</sup>Approve</b>?&nbsp; <input name=finalized id=finalized type="Radio" Value="YES"><b>Yes</b>&nbsp; &nbsp; &nbsp;<input Type="Radio" value="NO" checked name=finalized id=finalized><b>No</b> </font></td></tr>

				<TR><TD colspan=<%=maxCol+5%> ALIGN=CENTER><INPUT Type="submit" Value="Approve Running Subjects"></TD></TR>
				<%
				%>
				<input type=hidden Name='Total' ID='Total' value='<%=ctr%>'>
				<tr><td colspan=<%=maxCol+5%>
				<b><u>Note:</u></b><br>
				<font color=red><b><sup>#</sup>Approve:</b>Once You <b>Approved</b> (Select <b>YES</b>) then further modification of Elective Subjects to be run will not be possible<br>Approval of Elective Subjects Running (irrespective of existence of Electie Sbjects) is mandatory in order to procceed for <b>Load Distribution by HOD</b>
				</red></td></tr>
			</form>
			</TABLE>
		<%
		}
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration : Elective Subject Rnning is already approved/finalized</FONT><br>
		Click here to see a list of finalized <a href='ElectiveSubjectRunningList.jsp'>Elective Sbjects(Running)</a></P>

		</P>
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
out.print("error ");
}
%>
</body>
</html>