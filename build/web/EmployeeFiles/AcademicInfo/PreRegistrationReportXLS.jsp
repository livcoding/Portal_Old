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
String mElective="",mBack="",mCore="",mSem="",mCHOICE="",mExists="",mStatus="";
String mExists1="",mStatus1="",mStatus2="";

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

		
if (session.getAttribute("DepartmentCode")==null)
				mDept="";
			else
				mDept=session.getAttribute("DepartmentCode").toString().trim();




				

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIET";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Pre Registration Report] </TITLE>
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

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>

 <%@page contentType="text/html"%>
	   	<%
		response.setContentType("application/vnd.ms-excel");
		%>  

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
		
	
//out.print(mType+1111111111);
		mRights=123;
		qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
	//	out.println(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
			
			String mCheck="",mCheck1="",mCheck2="",mchk="",mchk1="";

			
		if(request.getParameter("Elective")!=null)
			{
				if (request.getParameter("Elective").equals("E"))
				{
					mCheck="checked";
				}
			}
			
			
		if(request.getParameter("Back")!=null)
			{
				if (request.getParameter("Back").equals("B"))
				{
					mCheck1="checked";
				}
			}
			

		if (request.getParameter("Core")!=null)
			{
				if (request.getParameter("Core").equals("C"))
				{
					mCheck2="checked";
				}
			}
			
	if (request.getParameter("CHOICE")!=null)
			{
			if (request.getParameter("CHOICE").equals("Y"))
					mchk="checked";
				else
					mchk1="checked";
			}
			else
			{
					mchk="checked";
			}
	
		

				if (request.getParameter("InstCode")==null)
						mInstitute=mInst;
					else		
						mInstitute=request.getParameter("InstCode").toString().trim();
		
				
				if (request.getParameter("CHOICE")==null)
					mCHOICE="";
				else
					mCHOICE=request.getParameter("CHOICE").toString().trim();

				if (request.getParameter("Exam")==null)
					mE="";
				else
					mE=request.getParameter("Exam").toString().trim();
			
				if (request.getParameter("Elective")==null)
					mElective="";
				else
					mElective=request.getParameter("Elective").toString().trim();
			
				if (request.getParameter("Back")==null)
					mBack="";
				else
					mBack=request.getParameter("Back").toString().trim();

				if (request.getParameter("Core")==null)
					mCore="";
				else
					mCore=request.getParameter("Core").toString().trim();

				mInst=mInstitute;
				%>
				<form name="frm"  >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Pre Registration Report</B></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 width="100%" align=center  border=2>
				<!--Institute****-->
					<tr><td colspan=3><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
			&nbsp; &nbsp;	:	
						<%=mInst%>
					&nbsp;&nbsp;&nbsp;
				<!--*********Exam**********-->
			<FONT color=black><FONT face=Arial size=2><STRONG>Pre Reg Exam Code</STRONG></FONT></FONT> : <%=mE%>
				
				
				</td>
				<!--SubJect Type**********-->
				
				</tr>

				
				<%
				if(mCHOICE.equals("Y"))
				{
					%>
				<TR><TD colspan=3>
				<FONT face=Arial size=2><b>Student have Given Preferences</b></FONT>	
				</TD></TR>
				<%
				}
				else
				{	
				%>
					
				<TR><TD colspan=3>
			
				<FONT face=Arial size=2><b>Student have Not Given Preferences</b></FONT>	
				</TD></TR>
				<%
				}
				%>
				<TR><TD  colspan=3>
				<FONT FACE='ARIAL' COLOR='#a52a2a' SIZE=3><B>REPORT TYPE</B></FONT>
				</TD></TR>
				

				<%
					if(mElective.equals("E"))
					{
					%>
						<tr><td colspan=3>
							<b><FONT face=Arial size=2>Students Having Elective Subjects.</font></b>
						</td></tr>
						<%
					}
					
					if(mBack.equals("B"))
					{
						%>
						
						<tr><td colspan=3>
							<b><FONT face=Arial size=2>Students BackLog in Subjects (Offered Now)</font></b>
						</td></tr>
						<%
					}
					if(mCore.equals("C"))
					{
							%>
						<tr><td colspan=3>
							<b><FONT face=Arial size=2>Students Having Core Subjects.</font></b>
						</td></tr>
						<%
					}
								%>
	
	
				
				</table>
				
			<br>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1"  bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
				<thead>
				<tr bgcolor='#e68a06'>
				 <td nowrap><font color=white><b>SNo.</b></font></td>
				 <td align=center><font color=white><b>Enrollment No.</font></b></td>
				 <td align=center><font color=white><b>Student Name</font></b></td>
 				 <td align=center><font color=white><b>Program</font></b></td>
 				 <td align=center><font color=white><b>Branch</font></b></td>
 				 <td align=center><font color=white><b>Semester</font></b></td>
				 <td align=center><font color=white><b>Status</b></font></td>
				</tr>
				</thead>
				<%

				if(mElective.equals("E"))
				{
					if(mCHOICE.equals("Y"))
					{
						mExists="Exists";
						mStatus="Given Elective Choice";
					}
					else if(mCHOICE.equals("N"))
					{
						mExists="Not Exists";	
						mStatus="Not Given Elective Choice";
					}
					qry="SELECT DISTINCT A.STUDENTID,nvl(C.ENROLLMENTNO,' ')ENROLLMENTNO,nvl(C.STUDENTNAME,' ')STUDENTNAME,nvl(A.PROGRAMCODE,' ')PROGRAMCODE,nvl(A.BRANCHCODE,' ')BRANCHCODE,A.SEMESTER SEMESTER FROM  STUDENTREGISTRATION A,PR#ELECTIVESUBJECTS B,STUDENTMASTER C WHERE NVL(A.REGALLOW,'N')='Y' and nvl(c.PROGRAMCOMPLETED,'N')='N'  and c.ENROLLMENTNO is not null   AND  A.EXAMCODE='"+mE+"' AND A.INSTITUTECODE='"+mInstitute+"' AND A.INSTITUTECODE=B.INSTITUTECODE AND A.STUDENTID=C.STUDENTID AND A.EXAMCODE=B.EXAMCODE AND A.ACADEMICYEAR=B.ACADEMICYEAR AND A.PROGRAMCODE=B.PROGRAMCODE AND A.TAGGINGFOR=B.TAGGINGFOR AND A.SECTIONBRANCH=B.SECTIONBRANCH AND A.SEMESTER=B.SEMESTER and  nvl(b.deactive,'N')='N' and  nvl(c.deactive,'N')='N'  and "+mExists+" (select studentid from pr#studentsubjectchoice ee where   ee.examcode = '"+mE+"' AND ee.institutecode = '"+mInstitute+"'  and  NVL (ee.deactive, 'N') = 'N'     AND a.institutecode = ee.institutecode  AND a.studentid =ee.studentid      AND a.examcode = ee.examcode  ) ORDER BY enrollmentno    ";
					
				//out.print(qry);

				rs=db.getRowset(qry);
				while (rs.next())
					{
						%>
						<tr  bgcolor='white'>
						<td><font color=black><b><%=++ctr%></b></font></td>
						 <td align=center><font color=black><%=rs.getString("ENROLLMENTNO")%></font></td>
						 <td ><font color=black><%=rs.getString("STUDENTNAME")%></font></td>
						 <td align=center><font color=black><%=rs.getString("PROGRAMCODE")%></font></td>
						 <td align=center><font color=black><%=rs.getString("BRANCHCODE")%></font></td>
						 <td align=center><font color=black><%=rs.getString("SEMESTER")%></font></td>
						 <td align=center><font color=Green><b><%=mStatus%></b></font></td>
						 </tr>

						 <INPUT TYPE="hidden" NAME="Elective" id="Elective" value="E">

							<%
					}

				}

				if(mBack.equals("B"))
				{
					
					if(mCHOICE.equals("Y"))
					{
						mExists="Exists";
						mStatus2="Given Back Log Choice";
					}
					else if(mCHOICE.equals("N"))
					{
						mExists="Not Exists";	
						mStatus2="Not Given Back Log Choice";
					}

					qry="sELECT DISTINCT b.studentid,nvl(e.ENROLLMENTNO,' ')ENROLLMENTNO,nvl(e.STUDENTNAME,' ')STUDENTNAME,nvl(b.PROGRAMCODE,' ')PROGRAMCODE,nvl(b.BRANCHCODE,' ')BRANCHCODE,b.SEMESTER   FROM studentresult a, subjectmaster c,studentregistration b,studentmaster e WHERE nvl(e.deactive,'N')='N'  And nvl(b.REGALLOW,'N')='Y'  and e.ENROLLMENTNO is not null    and nvl(e.PROGRAMCOMPLETED,'N')='N'  and  nvl(c.deactive,'N')='N' and  nvl(a.deactive,'N')='N' and a.institutecode = '"+mInstitute+"' AND nvl(a.grade,'N') = 'F' AND a.institutecode = c.institutecode  AND a.subjectid = c.subjectid and a.STUDENTID=b.STUDENTID and a.INSTITUTECODE=b.INSTITUTECODE and a.SEMESTER<(b.SEMESTER-1) And b.examcode='"+mE+"' and a.STUDENTID=e.STUDENTid and c.subjectid in (SELECT subjectid FROM ((SELECT b.subjectid FROM programsubjecttagging b          WHERE b.institutecode = '"+mInstitute+"' AND b.examcode = '"+mE+"' and nvl(b.deactive,'N')='N')      UNION (SELECT a.subjectid FROM pr#electivesubjects a WHERE a.institutecode = '"+mInstitute+"' AND a.examcode = '"+mE+"' and nvl(a.deactive,'N')='N'  ) UNION (SELECT a.subjectid  FROM offersubjecttagging a WHERE a.institutecode = '"+mInstitute+"'      AND a.examcode = '"+mE+"'  and nvl(a.deactive,'N')='N'  )))  AND  "+mExists+" ( select studentid from pr#studentsubjectchoice ee where    ee.examcode =  '"+mE+"' AND ee.institutecode =  '"+mInstitute+"'  and  NVL (ee.deactive, 'N') = 'N'   AND b.institutecode = ee.institutecode AND b.studentid =ee.studentid AND b.examcode = ee.examcode  ) UNION sELECT DISTINCT b.studentid,e.ENROLLMENTNO,e.STUDENTNAME,b.PROGRAMCODE,b.BRANCHCODE,b.SEMESTER FROM NRSTUDENTFAILSUBJECTS a, subjectmaster c,studentregistration b,studentmaster e WHERE nvl(e.deactive,'N')='N' and  nvl(a.REGISTERED,'N')='N' and  nvl(c.deactive,'N')='N'  and e.ENROLLMENTNO is not null   and  nvl(a.deactive,'N')='N' and a.institutecode = '"+mInstitute+"' AND a.institutecode = c.institutecode AND a.subjectid = c.subjectid and a.STUDENTID=b.STUDENTID  and a.INSTITUTECODE=b.INSTITUTECODE and a.SEMESTER<(b.SEMESTER) AND a.academicyear=b.ACADEMICYEAR and a.programcode=b.PROGRAMCODE            and a.taggingfor=b.TAGGINGFOR and a.sectionbranch=b.SECTIONBRANCH          And b.examcode='"+mE+"' and a.STUDENTID=e.STUDENTid and a.BASKET IN ('A') and nvl(a.REGISTEREXAMCODE,'"+mE+"')='"+mE+"'	and c.subjectid in (SELECT subjectid FROM ((SELECT b.subjectid FROM programsubjecttagging b          WHERE b.institutecode = '"+mInstitute+"' AND b.examcode = '"+mE+"'  and nvl(b.deactive,'N')='N'   )        UNION  (SELECT a.subjectid  FROM pr#electivesubjects a   WHERE a.institutecode = '"+mInstitute+"' AND a.examcode = '"+mE+"'  and nvl(a.deactive,'N')='N'  ) UNION        (SELECT a.subjectid  FROM offersubjecttagging a WHERE a.institutecode = '"+mInstitute+"' AND a.examcode = '"+mE+"'  and nvl(a.deactive,'N')='N'    ))) AND  "+mExists+" ( select studentid from pr#studentsubjectchoice ee where    ee.examcode =  '"+mE+"' AND ee.institutecode =  '"+mInstitute+"'  and  NVL (ee.deactive, 'N') = 'N'   AND b.institutecode = ee.institutecode AND b.studentid =ee.studentid AND b.examcode = ee.examcode  ) order by enrollmentno";
					//out.print(qry);
					rs=db.getRowset(qry);
					while(rs.next())
					{
						%>
						<tr  bgcolor='white'>
						<td><font color=black><b><%=++ctr%></b></font></td>
						 <td align=center><font color=black><%=rs.getString("ENROLLMENTNO")%></font></td>
						 <td ><font color=black><%=rs.getString("STUDENTNAME")%></font></td>
						 <td align=center><font color=black><%=rs.getString("PROGRAMCODE")%></font></td>
						 <td align=center><font color=black><%=rs.getString("BRANCHCODE")%></font></td>
						 <td align=center><font color=black><%=rs.getString("SEMESTER")%></font></td>
						 <td align=center><font color=REd><b><%=mStatus2%></b></font></td>
						 </tr>
						<INPUT TYPE="hidden" NAME="Back" id="Back"    value="B">
							<%


					}
							


					

				}
				
				if(mCore.equals("C"))
				{
					if(mCHOICE.equals("Y"))
					{
						mExists1="Exists";
						mStatus1="Pre-Registration Done by Student";
					
						qry="SELECT DISTINCT b.studentid, NVL (e.enrollmentno, ' ') enrollmentno,                NVL (e.studentname, ' ') studentname, NVL (b.programcode, ' ') programcode,                NVL (b.branchcode, ' ') branchcode, b.semester        FROM studentregistration b, studentmaster e   WHERE NVL (e.deactive, 'N') = 'N'            AND e.institutecode = '"+mInstitute+"'  AND e.studentid = b.studentid AND e.institutecode = b.institutecode  AND b.examcode = '"+mE+"'   AND e.enrollmentno IS NOT NULL AND NVL (b.regallow, 'N') = 'Y'    AND NVL (e.programcompleted, 'N') = 'N'   AND   EXISTS (SELECT studentid                     FROM pr#studentsubjectchoice ee  WHERE ee.examcode = '"+mE+"'                        AND ee.institutecode ='"+mInstitute+"'   AND NVL (ee.deactive, 'N') = 'N'                      AND b.institutecode = ee.institutecode  AND b.studentid = ee.studentid                      AND b.examcode = ee.examcode)  AND EXISTS (   SELECT SUBJECTID FROM programsubjecttagging b    WHERE b.institutecode = '"+mInstitute+"' AND b.examcode = '"+mE+"'   and nvl(b.deactive,'N')='N' ) ORDER BY enrollmentno";
					}
					else if(mCHOICE.equals("N"))
					{
						mExists1="Not Exists";	
						mStatus1="Pre-Registration Not Done by Student";
					

						qry="SELECT DISTINCT b.studentid, nvl(e.enrollmentno,' ')enrollmentno, nvl(e.studentname,' ')studentname, nvl(b.programcode,' ')programcode, nvl(b.branchcode,' ')branchcode, b.semester FROM studentregistration b,                studentmaster e   WHERE NVL (e.deactive, 'N') = 'N'       AND e.institutecode ='"+mInstitute+"'  AND e.studentid = b.studentid  AND e.institutecode = b.institutecode   AND b.examcode = '"+mE+"'  and e.ENROLLMENTNO is not null   And nvl(b.REGALLOW,'N')='Y'   and nvl(e.PROGRAMCOMPLETED,'N')='N' And "+mExists1+" (Select subjectid From nrstudentfailsubjects  pp Where NVL (pp.deactive, 'N') = 'N' And b.Studentid=pp.StudentiD AND pp.institutecode ='"+mInstitute+"' And pp.Semester < b.Semester  and nvl(pp.REGISTERED,'N')='N'     and pp.subjectid in (SELECT b.subjectid FROM programsubjecttagging b                                WHERE b.institutecode = '"+mInstitute+"'    AND b.examcode = '"+mE+"'                                and nvl(b.deactive,'N')='N')) And "+mExists1+" (select subjectid From StudentResult pp1 Where NVL (pp1.deactive, 'N') = 'N'                     And b.Studentid=pp1.StudentiD AND pp1.institutecode = '"+mInstitute+"'       And pp1.Semester<(b.Semester-1) And nvl(Fail,'N')='Y' and pp1.subjectid                                in (SELECT b.subjectid FROM programsubjecttagging b   WHERE b.institutecode = '"+mInstitute+"' AND b.examcode =  '"+mE+"'  and nvl(b.deactive,'N')='N') )  And "+mExists1+" (select subjectid From PR#ElectiveSubjects pp1  Where pp1.institutecode = '"+mInstitute+"' And pp1.EXAMCODE=b.EXAMCODE  And pp1.ACADEMICYEAR=b.ACADEMICYEAR And pp1.PROGRAMCODE=b.PROGRAMCODE            And pp1.TAGGINGFOR=b.TAGGINGFOR And pp1.SECTIONBRANCH=b.SECTIONBRANCH          And pp1.SEMESTER=pp1.SEMESTER  AND NVL (pp1.deactive, 'N') = 'N')   and  "+mExists1+" ( select studentid from pr#studentsubjectchoice ee where    ee.examcode =  '"+mE+"'  AND ee.institutecode = '"+mInstitute+"'  and  NVL (ee.deactive, 'N') = 'N'  AND b.institutecode = ee.institutecode AND b.studentid =ee.studentid            AND b.examcode = ee.examcode    ) order by enrollmentno";
					}
				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
					{
					%>
						<tr  bgcolor='white'>
						<td><font color=black><b><%=++ctr%></b></font></td>
						 <td align=center><font color=black><%=rs.getString("ENROLLMENTNO")%></font></td>
						 <td ><font color=black><%=rs.getString("STUDENTNAME")%></font></td>
						 <td align=center><font color=black><%=rs.getString("PROGRAMCODE")%></font></td>
						 <td align=center><font color=black><%=rs.getString("BRANCHCODE")%></font></td>
						 <td align=center><font color=black><%=rs.getString("SEMESTER")%></font></td>
						 <td align=center><font color=blue><b><%=mStatus1%></b></font></td>
						 </tr>
						 <INPUT TYPE="hidden" NAME="Core" id="Core"  value="C">
							<%
					}
				}

				%>
					
					
					
	<INPUT TYPE="hidden" NAME="CHOICE" value='<%=mCHOICE%>'  > 

	
	<INPUT TYPE="hidden" NAME="Exam" value='<%=mE%>'  > 

	<INPUT TYPE="hidden" NAME="InstCode" value='<%=mInstitute%>'  > 
					
					
					
					</table>
	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
</script>
					</script>
					</form>
				<%
			
		  		
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