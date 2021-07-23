<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rs2=null,rss=null,rsc=null,rse=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="",qrys="",qryc="",qrye="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="",mInstitute="",mDMemberCode="",mWebEmail="",mSID="", mProg="",mAYear="";
String mComp="",mPCode="",mSubjectID="",mSecBranch="",mInst="",mDMemberID="",mDMemberType="",mExamID="";
int mSems=0;
int mFlag=0;
String mEarned="",mCGPA="",mSGPA="",mradio1="",mradio2="",mradio3="";
String mRadio1="",mRadio2="",mRadio3="",mFail="";
String mSEMTYPE="",mSUBTYPE="",mSEMESTER="",mEARNED="",mSemType="";
String  mSTUDID="",mAYEAR="",mPCODE="",mSECTION="",mEXAMID="",mSUBID="",mSemester="",mSubjectType=""	;					
String mName0="",mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="";
String mName10="",mName11="",mName12="";

int mSNo=1,mECount=0,mCCount=0,mSCount=0;


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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

if (request.getParameter("PCode")==null)
{
	mPCode="";
}
else
{
	mPCode=request.getParameter("PCode").toString().trim();
}
if (request.getParameter("SubjectID")==null)
{
	mSubjectID="";
}
else
{
	mSubjectID=request.getParameter("SubjectID").toString().trim();
}
if (request.getParameter("SecBranch")==null)
{
	mSecBranch="";
}
else
{
	mSecBranch=request.getParameter("SecBranch").toString().trim();
} 

if (request.getParameter("AYear")==null)
{
	mAYear="";
}
else
{
	mAYear=request.getParameter("AYear").toString().trim();
} 
if (request.getParameter("SubjectType")==null)
{
	mSubjectType="";
}
else
{
	mSubjectType=request.getParameter("SubjectType").toString().trim();
} 
if (request.getParameter("Semester")==null)
{
	mSemester="";
}
else
{
	mSemester=request.getParameter("Semester").toString().trim();
} 
if (request.getParameter("SemType")==null)
{
	mSemType="";
}
else
{
	mSemType=request.getParameter("SemType").toString().trim();
} 



			if(request.getParameter("Earned")==null)
				mEarned="0";
			else
				mEarned=request.getParameter("Earned");

			if(request.getParameter("CGPA")==null)
				mCGPA="0";
			else
				mCGPA=request.getParameter("CGPA");

			if(request.getParameter("SGPA")==null)
				mSGPA="0";
			else
				mSGPA=request.getParameter("SGPA");
			


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Pre-Elective Subject Choices Finalization by HOD]</TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
 for (var i = 0; i < document.frm1.elements.length; i++) 
 {
  var e = document.frm1.elements[i]; 
  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
  { 
   e.checked = document.frm1.allbox.checked;
  }
 }
}
 </SCRIPT>




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

		qry="Select WEBKIOSK.ShowLink('114','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	

	%>



<form name="frm"  method="post" >
<input id="x" name="x" type=hidden>


<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Pre-Elective Subjects Choice Finalization by HOD </b></font></td>
</tr>
</TABLE>
<BR>
<%

	qry1="Select PREREGEXAMID Exam from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mLoginComp+"' And INSTITUTECODE='"+mInst+"'";

	rs1=db.getRowset(qry1);
	if(rs1.next())
		{
			mExamID=rs1.getString("Exam");
		}

	qry="select DISTINCT C.PROGRAMCODE PROGRAMCODE,C.ACADEMICYEAR ACADEMICYEAR,C.TAGGINGFOR TAGGINGFOR, C.SECTIONBRANCH SECTIONBRANCH,  nvl(A.Subject,A.SubjectCode ) SUBJECT , A.SubjectCode SC, B.SubjectID SID  from SUBJECTMASTER A, PR#STUDENTSUBJECTCHOICE B, BRANCHDEPTTAGGING C  where A.INSTITUTECODE=B.INSTITUTECODE  And A.INSTITUTECODE=C.INSTITUTECODE  And B.INSTITUTECODE='"+mInst+"'  AND A.SUBJECTID=B.SUBJECTID AND C.PROGRAMCODE='"+mPCode+"' AND C.SECTIONBRANCH='"+mSecBranch+"' AND A.SUBJECTID='"+mSubjectID+"' AND C.ACADEMICYEAR='"+mAYear+"' and B.EXAMCODE='"+mExamID+"' and B.SubjectType='"+mSubjectType+"' AND B.SEMESTER='"+mSemester+"' and B.SEMESTERTYPE='"+mSemType+"' " ;
	//out.println(qry);
	rs=db.getRowset(qry);
	if(rs.next())
		{
		%>
			<table rules=NONE cellspacing=1 cellpadding=1 align=center border=1>
			<tr>
				<td align=center><font color="#00008b" ><B>Program-Branch :	</B><%=rs.getString("PROGRAMCODE")%>-<%=rs.getString("SECTIONBRANCH")%></font></TD>
				<TD align=center><font color="#00008b"><b>&nbsp;&nbsp;Subject : </b>&nbsp;<%=rs.getString("SUBJECT")%></font></td>
			</tr>
			</table>
			<%
	}
%>
<br>
<TABLE align=center   cellSpacing=1 cellPadding=1 border=1 >
<thead>
 <tr bgcolor="#ff8c00">
 <td nowrap ><b><font color="White">Criteria on<br>the basis of</font></b></td>
 <td  ><b><font color="White">Pick up in Order</font></b></td> 
 <td  ><b><font color="White">Allow No. of Students</font></b></td> 
</tr>
</thead>
<tbody>
	<tr>
		<td><b>Earned Credit</font></b></td> 
		<td>	
		<%
		if(request.getParameter("radio1")==null)
		{
			%>
			<b><INPUT TYPE="radio" NAME="radio1" ID="radio1" value=Asc checked>Ascending&nbsp;&nbsp;<INPUT TYPE="radio" NAME="radio1" ID="radio1" value=Desc >Descending</b>
			<%
		}
		else
		{
			mradio1=request.getParameter("radio1").toString().trim();
			if(mradio1.equals("Asc"))
			{
			%>
			<b><INPUT TYPE="radio" NAME="radio1" ID="radio1" value=Asc checked>Ascending&nbsp;&nbsp;<INPUT TYPE="radio" NAME="radio1" ID="radio1" value=Desc >Descending</b>
			<%
			}
			else
			{
			%>
			<b><INPUT TYPE="radio" NAME="radio1" ID="radio1" value=Asc >Ascending&nbsp;&nbsp;<INPUT TYPE="radio" NAME="radio1" ID="radio1" value=Desc checked >Descending</b>
			<%
			}
		}	
		%>
		
		
		</td> 
		<td><b>No. of Students &nbsp;<INPUT TYPE="text" NAME="Earned" size=3></b></td>			
		<tr>
		<td><b>CGPA</font></b></td> 

		<td>	
		<%
		if(request.getParameter("radio2")==null)
		{
			%>
			<b><INPUT TYPE="radio" NAME="radio2" ID="radio2" value=Asc checked>Ascending&nbsp;&nbsp;<INPUT TYPE="radio" NAME="radio2" ID="radio2" value=Desc >Descending</b>
			<%
		}
		else
		{
			mradio2=request.getParameter("radio2").toString().trim();
			if(mradio2.equals("Asc"))
			{
			%>
			<b><INPUT TYPE="radio" NAME="radio2" ID="radio2" value=Asc checked>Ascending&nbsp;&nbsp;<INPUT TYPE="radio" NAME="radio2" ID="radio2" value=Desc >Descending</b>
			<%
			}
			else
			{
			%>
			<b><INPUT TYPE="radio" NAME="radio2" ID="radio2" value=Asc>Ascending&nbsp;&nbsp;<INPUT TYPE="radio" NAME="radio2" ID="radio2" value=Desc checked >Descending</b>
			<%
			}
		}	
		%>
		
		
		</td> 
		
		<td><b>No. of Students &nbsp;<INPUT TYPE="text" NAME="CGPA" size=3></b></td>
		</tr>
		<tr>
		<td><b>SGPA</font></b></td> 

		<td>	
		<%
		if(request.getParameter("radio3")==null)
		{
			%>
			<b><INPUT TYPE="radio" NAME="radio3" ID="radio3" value=Asc checked>Ascending&nbsp;&nbsp;<INPUT TYPE="radio" NAME="radio3" ID="radio3" value=Dsc >Descending</b>
			<%
		}
		else
		{
			mradio3=request.getParameter("radio3").toString().trim();
			if(mradio3.equals("Asc"))
			{
			%>
			<b><INPUT TYPE="radio" NAME="radio3" ID="radio3" value=Asc checked>Ascending&nbsp;&nbsp;<INPUT TYPE="radio" NAME="radio3" ID="radio3" value=Desc >Descending</b>
			<%
			}
			else
			{
			%>
			<b><INPUT TYPE="radio" NAME="radio3" ID="radio3" value=Asc>Ascending&nbsp;&nbsp;<INPUT TYPE="radio" NAME="radio3" ID="radio3" value=Desc checked >Descending</b>
			<%
			}
		}	
		%>
		
		
		</td> 
		
		<td><b>No. of Students &nbsp;<INPUT TYPE="text" NAME="SGPA" size=3></b></td>

	</tr>

<tr><td colspan=3>
	<b>Maximum No.of Subject Fails </b><INPUT TYPE="text" NAME="Fail" id="Fail" size=3>
	&nbsp;&nbsp;<INPUT TYPE="submit" Value="Show/Refresh" >
</td></tr>
</tbody>


</table>
</form>
<%

	if(request.getParameter("x")!=null)
		{	
			if(request.getParameter("Earned")==null)
				mEarned="0";
			else
				mEarned=request.getParameter("Earned").toString().trim();

			if(request.getParameter("CGPA")==null)
				mCGPA="0";
			else
				mCGPA=request.getParameter("CGPA").toString().trim();

			if(request.getParameter("SGPA")==null)
				mSGPA="0";
			else
				mSGPA=request.getParameter("SGPA").toString().trim();

			
			if(request.getParameter("radio1")==null)
				mRadio1="Asc";			
			else
				mRadio1=request.getParameter("radio1").toString().trim();			
		
			if(request.getParameter("radio2")==null)
				mRadio2="Asc";			
			else
				mRadio2=request.getParameter("radio2").toString().trim();			

			if(request.getParameter("radio3")==null)
				mRadio3="Asc";			
			else
				mRadio3=request.getParameter("radio3").toString().trim();	

			if(request.getParameter("Fail")==null)
				mFail="";			
			else
				mFail=request.getParameter("Fail").toString().trim();	 
		
		
			String mMCGPA="",mSSCGPA="",mSubjectRunning="";
	%>

	<form name="frm1" method="Post" action="RePRRegElectiveSubjectAction.jsp" >
	<input id="x" name="x" type=hidden>
	<input id="Earned" name="Earned" type=hidden value='<%=mEarned%>'>
	<input id="mCGPA" name="mCGPA" type=hidden value='<%=mCGPA%>'>
	<input id="mSGPA" name="mSGPA" type=hidden value='<%=mSGPA%>'>

	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="70%" border=1 >
		<thead>
		 <tr bgcolor="#ff8c00"> 
		 <td><b><font color="White" size=2 face="Times"><INPUT TYPE="checkbox" NAME="allbox" ID="allbox" onClick="un_check()" value='A' >ALL </font></b></td>
		 <td Title="Click on SNo. to Sort" ><b><font color="White" size=2 face="Times">SrNo.</font></b></td>
		 <td Title="Click on Student Name to Sort"><b><font color="White" size=2 face="Times">Student Name</font></b></td> 
		 <td Title="Click on Enrollment Wise to Sort"><b><font color="White" size=2 face="Times">Enrollment No.</font></b></td> 
		 <td ><b><font color="White" size=2 face="Times">Choice</font></b></td>
		 <td ><b><font color="White" size=2 face="Times">Course/Branch</font></b></td>
		 </tr>
		</thead>
		<tbody>
		
		<% 	
			String mChk="",mStudentID="",mSubRun="",mTAGG="",mName13="";
		int Count1=0,Count2=0,Count3=0,chk=0;



		if(!mEarned.equals("") || !mFail.equals(""))
			{

			qry="SELECT distinct A.ACADEMICYEAR ACADEMICYEAR,A.PROGRAMCODE PROGRAMCODE,A.SECTIONBRANCH SECTIONBRANCH,A.STUDENTID STUDENTID,A.CHOICE CHOICE,B.STUDENTNAME STUDENTNAME,B.ENROLLMENTNO ENROLLMENTNO,A.EXAMCODE EXAMCODE,A.SUBJECTID SUBJECTID,A.SEMESTER SEMESTER,A.SEMESTERTYPE SEMESTERTYPE,A.SUBJECTTYPE SUBJECTTYPE,A.TAGGINGFOR TAGGINGFOR  FROM PR#STUDENTSUBJECTCHOICE A,STUDENTMASTER B WHERE A.ACADEMICYEAR=B.ACADEMICYEAR AND A.STUDENTID=B.STUDENTID AND A.EXAMCODE='"+mExamID+"' AND A.PROGRAMCODE='"+mPCode+"' AND A.SECTIONBRANCH='"+mSecBranch+"' AND A.ACADEMICYEAR='"+mAYear+"' AND A.SUBJECTID='"+mSubjectID+"' and A.SubjectType='"+mSubjectType+"' AND A.SEMESTER='"+mSemester+"' and A.SEMESTERTYPE='"+mSemType+"' and NVL(A.DEACTIVE,'N')='N' AND " ;
			qry=qry+"NVL(B.DEACTIVE,'N')='N' ";
		
			if(!mFail.equals(""))
			{
				qry=qry+"And EXISTS (Select D.StudentID StudentID from STUDENTRESULT D where D.InstituteCode='"+mInst+"' and D.StudentID=A.STUDENTID AND A.SUBJECTID=D.SUBJECTID AND  D.SEMESTER=A.SEMESTER and D.INSTITUTECODE=A.INSTITUTECODE  And nvl(D.Fail,'N')='Y' And D.SubjectID not in (Select B.SubjectID From STUDENTRESULT B where B.InstituteCode='"+mInst+"' And B.SubjectID=D.SubjectID and nvl(B.Fail,'N')='N') Group By D.StudentID Having Count(D.StudentID)>='"+mFail+"') ";
			}
			qry=qry+"and a.studentid IN (SELECT STUDENTID FROM STUDENTSGPACGPA) order by STUDENTNAME "+mRadio1+" ";
			//out.print(qry);
			rs=db.getRowset(qry);
			
			while(rs.next())
			{
				
				mECount++;
				//out.println(mECount+"mECount");
				if((mECount <= Integer.parseInt(mEarned)))	
				{
					qrys="SELECT  MAX(TOTALEARNEDCREDIT)TEC FROM STUDENTSGPACGPA WHERE STUDENTID='"+rs.getString("STUDENTID")+"' order by TEC  ";
				
					rss=db.getRowset(qrys);
					if(rss.next())
					{	
						Count1++;
					
						%>
						<tr>
						<%
							qry1="SELECT NVL(A.CUSTOMFINALIZED,'N')CUSTOMFINALIZED,A.STUDENTID STUDENTID FROM PR#STUDENTSUBJECTCHOICE A,PR#CUSTOMEELECTIVEFINALIZATION B WHERE A.ACADEMICYEAR=B.ACADEMICYEAR AND A.PROGRAMCODE=B.PROGRAMCODE AND A.SECTIONBRANCH=B.SECTIONBRANCH AND A.EXAMCODE=B.EXAMCODE AND A.SEMESTER=B.SEMESTER AND A.SEMESTERTYPE=B.SEMESTERTYPE AND A.SUBJECTID=B.SUBJECTID AND A.EXAMCODE='"+mExamID+"' AND A.PROGRAMCODE='"+mPCode+"' AND A.SECTIONBRANCH='"+mSecBranch+"' AND A.ACADEMICYEAR='"+mAYear+"' AND A.SUBJECTID='"+mSubjectID+"' AND  A.SubjectType='"+mSubjectType+"' AND A.SEMESTER='"+mSemester+"' and A.SEMESTERTYPE='"+mSemType+"' AND A.STUDENTID='"+rs.getString("STUDENTID")+"' and NVL(A.DEACTIVE,'N')='N' AND  NVL(B.DEACTIVE,'N')='N'";
							//out.println(qry1);
							rs2=db.getRowset(qry1);
							
						if(rs2.next() && (!rs2.getString("CUSTOMFINALIZED").equals("")))	
						{	
							
							do
							{
								//chk++;
								//Count1++;
								mStudentID=rs2.getString("STUDENTID");
								mSubRun=rs2.getString("CUSTOMFINALIZED").toString().trim();
								
								mName1="Checked1_"+String.valueOf(Count1).trim();
								mSubjectRunning="RUNNING_"+String.valueOf(Count1).trim();
							
								if(mSubRun.equals("Y") )
								{
									//out.print(mSubRun+" Y");
									%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' checked value='Y' ></td>
									<%
								}
								else 
								{
									//out.print(mSubRun+" N");	%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' ></td>
									<%
								}
								
							} while(rs2.next());
						}
						else
						{
							//out.print("else");
							mName1="Checked1_"+String.valueOf(Count1).trim();

							if(mSubRun.equals(""))
								{
								
							%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' ></td>
							<%
								}
							else
							{
							
								%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='N' ></td>
								<%
							}
						}
								
						
						%>	
						
						<td><font size=2 face="Times"><%=mSNo++%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("STUDENTNAME")%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("ENROLLMENTNO")%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("CHOICE")%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("PROGRAMCODE")%>-<%=rs.getString("SECTIONBRANCH")%></td></font>
						</tr>
						<%
						mSTUDID=rs.getString("STUDENTID");
						mAYEAR=rs.getString("ACADEMICYEAR");
						mPCODE=rs.getString("PROGRAMCODE");
						mSECTION=rs.getString("SECTIONBRANCH");
						mEXAMID=rs.getString("EXAMCODE");
						mSUBID=rs.getString("SUBJECTID");
						
						mSUBTYPE=rs.getString("SUBJECTTYPE");
						mSEMESTER=rs.getString("SEMESTER");
						mSEMTYPE=rs.getString("SEMESTERTYPE");
						mTAGG=rs.getString("TAGGINGFOR");
						
						mEARNED=rss.getString("TEC");
					
						mName2="Earned_"+String.valueOf(Count1).trim();

						mName4="StudentID_"+String.valueOf(Count1).trim(); 
						mName5="ExamID_"+String.valueOf(Count1).trim(); 
						mName6="Academic_"+String.valueOf(Count1).trim(); 
						mName7="SubjectID_"+String.valueOf(Count1).trim();
						mName8="Section_"+String.valueOf(Count1).trim();
						mName9="ProgramCode_"+String.valueOf(Count1).trim();

						mName10="SubjectType_"+String.valueOf(Count1).trim();
						mName11="Semester_"+String.valueOf(Count1).trim();
						mName12="SemType_"+String.valueOf(Count1).trim();
						mName13="Tagg_"+String.valueOf(Count1).trim();
						//out.print(mSEMTYPE+"sEMESTER tYPE");
						%>
					
						<input type=hidden Name='<%=mSubjectRunning%>' ID='<%=mSubjectRunning%>' value='<%=mSubRun%>'>
						<input type=hidden Name='<%=mName2%>' ID='<%=mName2%>' value='<%=mEARNED%>'>
						<input type=hidden Name='<%=mName4%>' ID='<%=mName4%>' value='<%=mSTUDID%>'>
						<input type=hidden ID='<%=mName5%>' NAME='<%=mName5%>' value='<%=mEXAMID%>'> 
						<input type=hidden ID='<%=mName6%>' NAME='<%=mName6%>' value='<%=mAYEAR%>'> 
						<input type=hidden Name='<%=mName7%>' ID='<%=mName7%>' value='<%=mSUBID%>'>
						<input type=hidden Name='<%=mName8%>' ID='<%=mName8%>' value='<%=mSECTION%>'>
						<input type=hidden Name='<%=mName9%>' ID='<%=mName9%>' value='<%=mPCODE%>'>

						<input type=hidden Name='<%=mName10%>' ID='<%=mName10%>' value='<%=mSUBTYPE%>'>
						<input type=hidden Name='<%=mName11%>' ID='<%=mName11%>' value='<%=mSEMESTER%>'>
						<input type=hidden Name='<%=mName12%>' ID='<%=mName12%>' value='<%=mSEMTYPE%>'>
						<input type=hidden Name='<%=mName13%>' ID='<%=mName13%>' value='<%=mTAGG%>'>
						<%
					}
					else
					{
						break;
					}
					
				}
			}
			
			}

			if(!mCGPA.equals("") || !mFail.equals(""))
			{

			qry="SELECT distinct A.ACADEMICYEAR ACADEMICYEAR,A.PROGRAMCODE PROGRAMCODE,A.SECTIONBRANCH SECTIONBRANCH,A.STUDENTID STUDENTID,A.CHOICE CHOICE,B.STUDENTNAME STUDENTNAME,B.ENROLLMENTNO ENROLLMENTNO,A.EXAMCODE EXAMCODE,A.SUBJECTID SUBJECTID,A.SEMESTER SEMESTER,A.SEMESTERTYPE SEMESTERTYPE,A.SUBJECTTYPE SUBJECTTYPE,A.TAGGINGFOR TAGGINGFOR  FROM PR#STUDENTSUBJECTCHOICE A,STUDENTMASTER B WHERE A.ACADEMICYEAR=B.ACADEMICYEAR AND A.STUDENTID=B.STUDENTID AND A.EXAMCODE='"+mExamID+"' AND A.PROGRAMCODE='"+mPCode+"' AND A.SECTIONBRANCH='"+mSecBranch+"' AND A.ACADEMICYEAR='"+mAYear+"' AND A.SUBJECTID='"+mSubjectID+"' and A.SubjectType='"+mSubjectType+"' AND A.SEMESTER='"+mSemester+"' and A.SEMESTERTYPE='"+mSemType+"' and NVL(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' ";
			
			if(!mFail.equals(""))
			{
				qry=qry+"And EXISTS (Select D.StudentID StudentID from STUDENTRESULT D where D.InstituteCode='"+mInst+"' and D.StudentID=A.STUDENTID AND A.SUBJECTID=D.SUBJECTID AND  D.SEMESTER=A.SEMESTER and D.INSTITUTECODE=A.INSTITUTECODE  And nvl(D.Fail,'N')='Y' And D.SubjectID not in (Select B.SubjectID From STUDENTRESULT B where B.InstituteCode='"+mInst+"' And B.SubjectID=D.SubjectID and nvl(B.Fail,'N')='N') Group By D.StudentID Having Count(D.StudentID)>='"+mFail+"') ";
			}
			qry=qry+"and a.studentid IN (SELECT STUDENTID FROM STUDENTSGPACGPA) order by STUDENTNAME "+mRadio2+" ";

			rs=db.getRowset(qry);
			
			while(rs.next())
			{			
				mCCount++;
				if((mCCount <= Integer.parseInt(mCGPA)) && !mCGPA.equals(""))
				{
				
				if(!mEarned.equals(""))
					{
				qryc="SELECT  nvl(MAX(CGPA),'0')MCGPA FROM STUDENTSGPACGPA WHERE STUDENTID='"+rs.getString("STUDENTID")+"' and STUDENTID NOT IN(SELECT STUDENTID FROM STUDENTSGPACGPA) order by MCGPA  ";
					}
					else
					{
					qryc="SELECT  nvl(MAX(CGPA),'0')MCGPA FROM STUDENTSGPACGPA WHERE STUDENTID='"+rs.getString("STUDENTID")+"' order by MCGPA ";
					}
				//out.println("<br>"+qryc);
				rsc=db.getRowset(qryc);
				if(rsc.next() && !rsc.getString("MCGPA").equals("0"))
				{
						Count1++;
						%>
						<tr>
						<%
						qry1="SELECT NVL(A.CUSTOMFINALIZED,'N')CUSTOMFINALIZED,A.STUDENTID STUDENTID FROM PR#STUDENTSUBJECTCHOICE A,PR#CUSTOMEELECTIVEFINALIZATION B WHERE A.ACADEMICYEAR=B.ACADEMICYEAR AND A.PROGRAMCODE=B.PROGRAMCODE AND A.SECTIONBRANCH=B.SECTIONBRANCH AND A.EXAMCODE=B.EXAMCODE AND A.SEMESTER=B.SEMESTER AND A.SEMESTERTYPE=B.SEMESTERTYPE AND A.SUBJECTID=B.SUBJECTID AND A.EXAMCODE='"+mExamID+"' AND A.PROGRAMCODE='"+mPCode+"' AND A.SECTIONBRANCH='"+mSecBranch+"' AND A.ACADEMICYEAR='"+mAYear+"' AND A.SUBJECTID='"+mSubjectID+"' and A.STUDENTID='"+rs.getString("STUDENTID")+"' and A.SubjectType='"+mSubjectType+"' AND A.SEMESTER='"+mSemester+"' and A.SEMESTERTYPE='"+mSemType+"' and NVL(A.DEACTIVE,'N')='N' AND  NVL(B.DEACTIVE,'N')='N'";
						//out.println(qry1);
						rs1=db.getRowset(qry1);
							
						if(rs1.next() && (!rs1.getString("CUSTOMFINALIZED").equals("")))
						{	
						
							//while(rs1.next() )
							do
							{
							
								//chk++;
								//Count1++;
								mStudentID=rs1.getString("STUDENTID");
								mSubRun=rs1.getString("CUSTOMFINALIZED").toString().trim();
								
								mSubjectRunning="RUNNING_"+String.valueOf(Count1).trim();
								mName1="Checked1_"+String.valueOf(Count1).trim();
					
								if(mSubRun.equals("Y") )
								{
									//out.print(mSubRun+" Y");
									%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' checked value='Y' ></td>
									<%
								}
								else 
								{
									//out.print(mSubRun+" N");	%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' ></td>
									<%
								}
								
							} while(rs1.next());
						}
						else
						{	mName1="Checked1_"+String.valueOf(Count1).trim();
							if(mSubRun.equals(""))
								{
							
							%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' ></td>
							<%
								}
							else
							{
								
								%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='N' ></td>
								<%
							}

						}
								
						%>
						
						<td><font size=2 face="Times"><%=mSNo++%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("STUDENTNAME")%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("ENROLLMENTNO")%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("CHOICE")%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("PROGRAMCODE")%>-<%=rs.getString("SECTIONBRANCH")%></td></font>
						</tr>

						<%
						mSTUDID=rs.getString("STUDENTID");
						mAYEAR=rs.getString("ACADEMICYEAR");
						mPCODE=rs.getString("PROGRAMCODE");
						mSECTION=rs.getString("SECTIONBRANCH");
						mEXAMID=rs.getString("EXAMCODE");
						mSUBID=rs.getString("SUBJECTID");
						mSUBTYPE=rs.getString("SUBJECTTYPE");
						mSEMESTER=rs.getString("SEMESTER");
						mSEMTYPE=rs.getString("SEMESTERTYPE");
						mTAGG=rs.getString("TAGGINGFOR");

						mMCGPA=rsc.getString("MCGPA");
											
						mName3="CGPA_"+String.valueOf(Count1).trim();
						mName4="StudentID_"+String.valueOf(Count1).trim(); 
						mName5="ExamID_"+String.valueOf(Count1).trim(); 
						mName6="Academic_"+String.valueOf(Count1).trim(); 
						mName7="SubjectID_"+String.valueOf(Count1).trim();
						mName8="Section_"+String.valueOf(Count1).trim();
						mName9="ProgramCode_"+String.valueOf(Count1).trim();
						mName10="SubjectType_"+String.valueOf(Count1).trim();
						mName11="Semester_"+String.valueOf(Count1).trim();
						mName12="SemType_"+String.valueOf(Count1).trim();
						mName13="Tagg_"+String.valueOf(Count1).trim();
					    %>
						<input type=hidden Name='<%=mSubjectRunning%>' ID='<%=mSubjectRunning%>' value='<%=mSubRun%>'>
						<input type=hidden Name='<%=mName3%>' ID='<%=mName3%>' value='<%=mMCGPA%>'>
						<input type=hidden Name='<%=mName4%>' ID='<%=mName4%>' value='<%=mSTUDID%>'>
						<input type=hidden ID='<%=mName5%>' NAME='<%=mName5%>' value='<%=mEXAMID%>'> 
						<input type=hidden ID='<%=mName6%>' NAME='<%=mName6%>' value='<%=mAYEAR%>'> 
						<input type=hidden Name='<%=mName7%>' ID='<%=mName7%>' value='<%=mSUBID%>'>
						<input type=hidden Name='<%=mName8%>' ID='<%=mName8%>' value='<%=mSECTION%>'>
						<input type=hidden Name='<%=mName9%>' ID='<%=mName9%>' value='<%=mPCODE%>'>

						<input type=hidden Name='<%=mName10%>' ID='<%=mName10%>' value='<%=mSUBTYPE%>'>
						<input type=hidden Name='<%=mName11%>' ID='<%=mName11%>' value='<%=mSEMESTER%>'>
						<input type=hidden Name='<%=mName12%>' ID='<%=mName12%>' value='<%=mSEMTYPE%>'>  
						<input type=hidden Name='<%=mName13%>' ID='<%=mName13%>' value='<%=mTAGG%>'>
						<%
				}
				else
				{
					
					break;
				}
				}
			}

			}

			if(!mSGPA.equals("") || !mFail.equals(""))
			{
		
			qry="SELECT distinct A.ACADEMICYEAR ACADEMICYEAR,A.PROGRAMCODE PROGRAMCODE,A.SECTIONBRANCH SECTIONBRANCH,A.STUDENTID STUDENTID,A.CHOICE CHOICE,B.STUDENTNAME STUDENTNAME,B.ENROLLMENTNO ENROLLMENTNO,A.EXAMCODE EXAMCODE,A.SUBJECTID SUBJECTID,A.SEMESTER SEMESTER,A.SEMESTERTYPE SEMESTERTYPE,A.SUBJECTTYPE SUBJECTTYPE,A.TAGGINGFOR TAGGINGFOR  FROM PR#STUDENTSUBJECTCHOICE A,STUDENTMASTER B WHERE A.ACADEMICYEAR=B.ACADEMICYEAR AND A.STUDENTID=B.STUDENTID AND A.EXAMCODE='"+mExamID+"' AND A.PROGRAMCODE='"+mPCode+"' AND A.SECTIONBRANCH='"+mSecBranch+"' AND A.ACADEMICYEAR='"+mAYear+"' AND A.SUBJECTID='"+mSubjectID+"' and A.SubjectType='"+mSubjectType+"' AND A.SEMESTER='"+mSemester+"' and A.SEMESTERTYPE='"+mSemType+"' and  NVL(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' ";

			if(!mFail.equals(""))
			{
				qry=qry+"And EXISTS (Select D.StudentID StudentID from STUDENTRESULT D where D.InstituteCode='"+mInst+"' and D.StudentID=A.STUDENTID AND A.SUBJECTID=D.SUBJECTID AND  D.SEMESTER=A.SEMESTER and D.INSTITUTECODE=A.INSTITUTECODE  And nvl(D.Fail,'N')='Y' And D.SubjectID not in (Select B.SubjectID From STUDENTRESULT B where B.InstituteCode='"+mInst+"' And B.SubjectID=D.SubjectID and nvl(B.Fail,'N')='N') Group By D.StudentID Having Count(D.StudentID)>='"+mFail+"') ";
			}
			qry=qry+"and a.studentid IN (SELECT STUDENTID FROM STUDENTSGPACGPA) order by STUDENTNAME "+mRadio3+" ";

			rs=db.getRowset(qry);
			//out.print("<br><br>"+qry);
			while(rs.next())
			{		
			
				mSCount++;
				if((mSCount <= Integer.parseInt(mSGPA)) && !mSGPA.equals(""))
				{

				if(!mCGPA.equals(""))
					{
				qrye="SELECT  nvl(MAX(SGPA),'0')SCGPA FROM STUDENTSGPACGPA WHERE STUDENTID='"+rs.getString("STUDENTID")+"' and STUDENTID NOT IN(SELECT STUDENTID FROM STUDENTSGPACGPA) order by SCGPA  ";
					}
					else
					{
						qrye="SELECT  nvl(MAX(SGPA),'0')SCGPA FROM STUDENTSGPACGPA WHERE STUDENTID='"+rs.getString("STUDENTID")+"' order by SCGPA  ";
					}
				//out.println("<br><br>"+qrye);
				rse=db.getRowset(qrye);
				if(rse.next() && !rse.getString("SCGPA").equals("0"))
				{
						
						Count1++;
						%>
							<tr>
						<%
						qry1="SELECT NVL(A.CUSTOMFINALIZED,'N')CUSTOMFINALIZED,A.STUDENTID STUDENTID FROM PR#STUDENTSUBJECTCHOICE A,PR#CUSTOMEELECTIVEFINALIZATION B WHERE A.ACADEMICYEAR=B.ACADEMICYEAR AND A.PROGRAMCODE=B.PROGRAMCODE AND A.SECTIONBRANCH=B.SECTIONBRANCH AND A.EXAMCODE=B.EXAMCODE AND A.SEMESTER=B.SEMESTER AND A.SEMESTERTYPE=B.SEMESTERTYPE AND A.SUBJECTID=B.SUBJECTID AND A.EXAMCODE='"+mExamID+"' AND A.PROGRAMCODE='"+mPCode+"' AND A.SECTIONBRANCH='"+mSecBranch+"' AND A.ACADEMICYEAR='"+mAYear+"' AND A.SUBJECTID='"+mSubjectID+"' and A.STUDENTID='"+rs.getString("STUDENTID")+"' and A.SubjectType='"+mSubjectType+"' AND A.SEMESTER='"+mSemester+"' and A.SEMESTERTYPE='"+mSemType+"' and  NVL(A.DEACTIVE,'N')='N' AND  NVL(B.DEACTIVE,'N')='N'";
						//out.println(qry1);
						rs1=db.getRowset(qry1);
							
						if(rs1.next() && (!rs1.getString("CUSTOMFINALIZED").equals("")))
						{	
						
							//while(rs1.next() )
							do
							{
								//chk++;
								//Count1++;
								mStudentID=rs1.getString("STUDENTID");
								mSubRun=rs1.getString("CUSTOMFINALIZED").toString().trim();

								mSubjectRunning="RUNNING_"+String.valueOf(Count1).trim();
								mName1="Checked1_"+String.valueOf(Count1).trim();
								
							//	out.println(mSubRun+"Subject Running");
									 if(mSubRun.equals("Y") )
								{
									%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' checked value='Y' ></td>
									<%
								}
								else 
								{
									%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' ></td>
									<%
								}
								
							}while(rs1.next());
						}
						else
						{	mName1="Checked1_"+String.valueOf(Count1).trim();
							if(mSubRun.equals(""))
								{
								
							%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' ></td>
							<%
								}
							else
							{
							
								%>
									<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='N' ></td>
								<%
							}

						}
					
						%>
														
						<td><font size=2 face="Times"><%=mSNo++%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("STUDENTNAME")%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("ENROLLMENTNO")%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("CHOICE")%></font></td>
						<td><font size=2 face="Times"><%=rs.getString("PROGRAMCODE")%>-<%=rs.getString("SECTIONBRANCH")%></td></font>
						</tr>
						<%
						mSSCGPA=rse.getString("SCGPA");

						mSTUDID=rs.getString("STUDENTID");
						mAYEAR=rs.getString("ACADEMICYEAR");
						mPCODE=rs.getString("PROGRAMCODE");
						mSECTION=rs.getString("SECTIONBRANCH");
						mEXAMID=rs.getString("EXAMCODE");
						mSUBID=rs.getString("SUBJECTID");
						
						mSUBTYPE=rs.getString("SUBJECTTYPE");
						mSEMESTER=rs.getString("SEMESTER");
						mSEMTYPE=rs.getString("SEMESTERTYPE");
						mTAGG=rs.getString("TAGGINGFOR");
						
						mName0="SCGPA_"+String.valueOf(Count1).trim();

						mName4="StudentID_"+String.valueOf(Count1).trim(); 
						mName5="ExamID_"+String.valueOf(Count1).trim(); 
						mName6="Academic_"+String.valueOf(Count1).trim(); 
						mName7="SubjectID_"+String.valueOf(Count1).trim();
						mName8="Section_"+String.valueOf(Count1).trim();
						mName9="ProgramCode_"+String.valueOf(Count1).trim();

						mName10="SubjectType_"+String.valueOf(Count1).trim();
						mName11="Semester_"+String.valueOf(Count1).trim();
						mName12="SemType_"+String.valueOf(Count1).trim();
						mName13="Tagg_"+String.valueOf(Count1).trim();
						%>
						
						<input type=hidden Name='<%=mSubjectRunning%>' ID='<%=mSubjectRunning%>' value='<%=mSubRun%>'>
						<input type=hidden Name='<%=mName0%>' ID='<%=mName0%>' value='<%=mSSCGPA%>'>
						
						<input type=hidden Name='<%=mName4%>' ID='<%=mName4%>' value='<%=mSTUDID%>'>
						<input type=hidden ID='<%=mName5%>' NAME='<%=mName5%>' value='<%=mEXAMID%>'> 
						<input type=hidden ID='<%=mName6%>' NAME='<%=mName6%>' value='<%=mAYEAR%>'> 
						<input type=hidden Name='<%=mName7%>' ID='<%=mName7%>' value='<%=mSUBID%>'>
						<input type=hidden Name='<%=mName8%>' ID='<%=mName8%>' value='<%=mSECTION%>'>
						<input type=hidden Name='<%=mName9%>' ID='<%=mName9%>' value='<%=mPCODE%>'>

						<input type=hidden Name='<%=mName10%>' ID='<%=mName10%>' value='<%=mSUBTYPE%>'>
						<input type=hidden Name='<%=mName11%>' ID='<%=mName11%>' value='<%=mSEMESTER%>'>
						<input type=hidden Name='<%=mName12%>' ID='<%=mName12%>' value='<%=mSEMTYPE%>'>
							<input type=hidden Name='<%=mName13%>' ID='<%=mName13%>' value='<%=mTAGG%>'>
						
						<%
					
				}
				else
				{
					break;
				}
				
				}
			}
			}
			%>
			<tr><td colspan=6>
			<input type=hidden name=TotalRec1 id=TotalRec1 value='<%=Count1%>'>			
		
			<input type=hidden name=ProCode id=ProCode value='<%=mPCODE%>'>
			<input type=hidden name=ProCode id=ProCode value='<%=mPCODE%>'>
			<input type=hidden name=SubID id=SubID value='<%=mSUBID%>'>
			<input type=hidden name=Section id=Section value='<%=mSECTION%>'>
			<input type=hidden name=ADYear id=ADYear value='<%=mAYEAR%>'>
			<input type=hidden name=Exam id=Exam value='<%=mEXAMID%>'> 
			<input type=hidden name=Semester id=Semester value='<%=mSEMESTER%>'>
			<input type=hidden name=SemType id=SemType value='<%=mSEMTYPE%>'>
			<input type=hidden name=SubjectType id=SubjectType value='<%=mSUBTYPE%>'>


			<input type=hidden ID=INSTITUTECODE NAME=INSTITUTECODE value=<%=mInst%>>
			<INPUT TYPE="submit" value=Save>
			</td></tr>
			
		</tbody>
		</TABLE>
		<script type="text/javascript">
		var st1 = new SortableTable(document.getElementById("table-1"),[,"Number","CaseInsensitiveString","Number"]);
		</script>
	</form>

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
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
   }
  //-----------------------------
}
else
{
	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}		
catch(Exception e)
{
}
%>
<br><BR>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>

</body>
</html>



