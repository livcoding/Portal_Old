<%@ page  buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsjj1=null,rsjj=null,rs1=null,rsj1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="",qry1="";
int ctr=1;
int mRights=56;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="",mCompany="",mComp="";
String mExam="",mE="";
String mexam="",ProgramCode="";
String QryDept="", mDeptCode="", mDeptName="", mShowLoadOn="",mcolor="Black";
String Heading="", mType="", mGetFacLoad="", mLLoad="", mTLoad="", mPLoad="", mTotalLoad="";
int len=0, pos1=0, pos2=0, pos3=0, posL=0, posT=0, posP=0;
String OldStudent="",mProg="",mprog="",mExamCode="",mSubjectid="",mLoginComp="",subjects="";
String mAcademicYear="",mAcad="",AcadYear="";
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

if (session.getAttribute("InstituteCode")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}
mCompany=mLoginComp;
mInstitute=mInst;
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Backlog Subject Load Distribution Status] </TITLE>

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
		

		qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
	
			qry="Select  nvl(PREREGEXAMID,' ') Exam from CompanyInstituteTagging where  InstituteCode='"+mInst+"' and CompanyCode='"+mLoginComp+"' ";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next()){
				mExamCode=rs.getString("Exam");						
			}
//mExamCode="2009ODDSEM";
				%>
				<form name="frm"  method="post">
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>Back Log Subject Load Distribution Status</B></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 rules=group cellspacing=1 align=center  border=3>

				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInst%>'>

				<!--Company****-->
				<INPUT name=CompCode TYPE=HIDDEN id="CompCode" VALUE='<%=mComp%>'>

				<!--Type****-->
				<input type=hidden Name='Type' ID='Type' value='<%=mType%>'>

				<tr>
				<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Exam Code</STRONG></FONT></FONT>
				&nbsp; &nbsp;&nbsp;
				<%
				try
				{
					qry="Select distinct ExamCode Exam from PR#HODLOADDISTRIBUTION where nvl(DEACTIVE,'N')='N' and institutecode='"+mInst+"' and examcode='"+mExamCode+"' ";
					//out.print(qry);
					rs=db.getRowset(qry);
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
				}
				%>
				<!--*********Department**********-->
				&nbsp; &nbsp; <FONT color=black><FONT face=Arial size=2><STRONG>Program Code</STRONG></FONT></FONT>
&nbsp;&nbsp;
	<%
	try
	{
			qry="select distinct programcode from PR#STUDENTSUBJECTCHOICE where ";
			qry=qry+" INSTITUTECODE='"+ mInst +"' AND EXAMCODE='"+mExamCode+"' and nvl(DEACTIVE,'N')='N'  ";
		qry=qry+"  order by programcode";
			rs=db.getRowset(qry);
%>	
															
		<select name=ProgramCode tabindex="0" id="ProgramCode" style="WIDTH: 80px" >
		<OPTION selected Value ='ALL'>ALL</option>
<%   
	if (request.getParameter("x")==null) 
	 {
		while(rs.next())
		{
			mProg=rs.getString("programcode");
			if(mprog.equals(""))
			{
				mprog=mProg;
			%>
				<OPTION   Value=<%=mProg%>><%=rs.getString("programcode")%></option>
			<%
			}
			else
			{
			%>
				<OPTION Value=<%=mProg%>><%=rs.getString("programcode")%></option>
			<%
			}
		} // closing of while
	 } // closing of if 
	 else
	{
		while(rs.next())
		{
			mProg=rs.getString("programcode");
			if(mProg.equals(request.getParameter("ProgramCode").toString().trim()))
 			{
			   mprog=mProg;
			%>
				<OPTION selected Value=<%=mProg%>><%=rs.getString("programcode")%></option>
			<%			
			}
			else
 	            {
				%>
					<OPTION Value =<%=mProg%>><%=rs.getString("programcode")%></option>
			    	<%			
			}
		 } // closing of while
 } // closing of else
					%>
						</select>
					  	<%
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}
				
				%>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<FONT color=black><FONT face=Arial size=2><STRONG>Academic Year</STRONG></FONT></FONT>
&nbsp;&nbsp;
	<%
	try
	{


 qry = "select distinct nvl(ACADEMICYEAR,' ') ACADEMICYEAR from ACADEMICYEARMASTER where  INSTITUTECODE='"+ mInst +"' AND nvl(deactive,'N')='N' order by ACADEMICYEAR";
            rs = db.getRowset(qry);

		%>	
															
		<select name=AcademicYear tabindex="0" id="AcademicYear" style="WIDTH: 80px" >
		<OPTION selected Value ='ALL'>ALL</option>
<%   
	if (request.getParameter("x")==null) 
	 {
		while(rs.next())
		{
			mAcademicYear=rs.getString("ACADEMICYEAR");
			if(mAcad.equals(""))
			{
				mAcad=mAcademicYear;
			%>
				<OPTION   Value=<%=mAcademicYear%>><%=rs.getString("ACADEMICYEAR")%></option>
			<%
			}
			else
			{
			%>
				<OPTION Value=<%=mAcademicYear%>><%=rs.getString("ACADEMICYEAR")%></option>
			<%
			}
		} // closing of while
	 } // closing of if 
	 else
	{
		while(rs.next())
		{
			mAcademicYear=rs.getString("ACADEMICYEAR");
			if(mAcademicYear.equals(request.getParameter("AcademicYear").toString().trim()))
 			{
			   mAcad=mAcademicYear;
			%>
				<OPTION selected Value=<%=mAcademicYear%>><%=rs.getString("ACADEMICYEAR")%></option>
			<%			
			}
			else
 	            {
				%>
					<OPTION Value =<%=mAcademicYear%>><%=rs.getString("ACADEMICYEAR")%></option>
			    	<%			
			}
		 } // closing of while
 } // closing of else
					%>
						</select>
					  	<%
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}
				
				%>
				</td>
				
				
				</tr>

				<!--***********Load status for HOD or DOAA**********-->
				<tr>
				<td ><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Subject&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</STRONG></FONT></FONT>
						
						<%
							if(request.getParameter("x")==null)
								mSubjectid="";
							else
								mSubjectid=request.getParameter("subjects");
						%>
							<select name="subjects" tabindex="0" id="subjects">
							<OPTION selected Value ='ALL'>All</option>
							<%
							qry="SELECT DISTINCT a.subjectid subjectid,b.subject || ' (' || b.subjectcode || ')' subject FROM pr#studentsubjectchoice a, subjectmaster b WHERE a.examcode = '"+mExamCode+"' AND a.semestertype IN ('RWJ', 'SAP') AND NVL (a.deactive, 'N') = 'N' AND NVL (b.deactive, 'N') = 'N' AND a.subjectid = b.subjectid and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode order by subject";
							rs=db.getRowset(qry);
							//System.out.println(qry);
							while(rs.next()){
								if(!mSubjectid.equals("") && mSubjectid.equals(rs.getString("subjectid"))){
									%>
									<OPTION selected Value =<%=rs.getString("subjectid")%>><%=rs.getString("subject")%></option>
									<%
								}
								else
								{
									%>
									<OPTION Value =<%=rs.getString("subjectid")%>><%=rs.getString("subject")%></option>
									<%
								}
							}
							%>
							</select>
				<INPUT Type="submit" Value="&nbsp;Show&nbsp;"></td></tr>
				</table>
				</form>
				<table width=100%>
				<%
					String mEx=request.getParameter("Exam").toString().trim();
				
				%>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
				<thead>
				<tr bgcolor="#ff8c00">
				 <td nowrap align=left><font color=white><b>Sr<br>No</b></font></td>
				 <td nowrap align=center><font color=white><b>Name of Student</b></font></td>
				
				 <td nowrap align=center><font color=white><b>Program Code</b></font></td>
				 				 <td nowrap align=center><font color=white><b>Academic Year</b></font></td>
				 <td nowrap title="Total Assigned Load" align=center><font color=white><b>  Tagged SubSection </b></font></td>
				</tr>
				</thead>
				<tbody>
				<%
					 						String query="";
				

					if (request.getParameter("Exam")==null)
						mE=mexam;
					else
						mE=request.getParameter("Exam").toString().trim();
			
					if(request.getParameter("subjects")==null)
						subjects="";
					else
						subjects=request.getParameter("subjects").toString().trim();

					if(request.getParameter("ProgramCode")!=null)	
						ProgramCode=request.getParameter("ProgramCode").toString().trim();
					else
						ProgramCode="";

					if(request.getParameter("AcademicYear")!=null)	
						AcadYear=request.getParameter("AcademicYear").toString().trim();
					else
						AcadYear="";

					/*
//--------------------------------------------HOD-------------------------------------
					if(mType.equals("H"))
					{
						qry=" select Distinct A.FACULTYID, A.FACULTYTYPE,a.ACADEMICYEAR, B.EMPLOYEENAME||' ['||B.EMPLOYEECODE||']' EMPLOYEENAME,";
						qry=qry+" C.DEPARTMENT||' ['||B.DEPARTMENTCODE||']' Dept, D.DESIGNATION||' ['||B.DESIGNATIONCODE||']' Degs, A.SUBJECTID SUBJECTID, E.SUBJECTCODE SUBJECTCODE, E.SUBJECT Subject,";
						qry=qry+" WEBKIOSK.getFacultyLoadDetails('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,'"+mE+"',A.SUBJECTID) FacLoadDet,";
						qry=qry+" WEBKIOSK.getAssignedTeachLoad('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,A.SUBJECTID) AssignedLoad, ";
						qry=qry+" WEBKIOSK.getMaxTeachLoad('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,'"+mE+"') MaxLoad";
						qry=qry+" From PR#HODLOADDISTRIBUTION A, V#STAFF B, DEPARTMENTMASTER C, DESIGNATIONMASTER D, SUBJECTMASTER E where A.FACULTYID=B.EMPLOYEEID";
						qry=qry+" and A.COMPANYCODE=b.COMPANYCODE and A.facultyTYPE=b.EMPLOYEETYPE and ";
						qry=qry+" B.DEPARTMENTCODE=C.DEPARTMENTCODE AND B.DESIGNATIONCODE=D.DESIGNATIONCODE AND A.SUBJECTID=E.SUBJECTID and a.institutecode=e.institutecode";
						qry=qry+" and A.INSTITUTECODE='"+mInstitute+"' and a.COMPANYCODE='"+mCompany+"' And EXAMCODE='"+mE+"' and STATUS='"+mShowLoadOn+"' and B.DEPARTMENTCODE='"+QryDept+"'";
						qry=qry+" And A.FACULTYID IN (Select EMPLOYEEID from V#STAFF  where DEPARTMENTCODE IN (Select DEPARTMENTCODE from HODLIST ";
						qry=qry+" where INSTITUTECODE='"+mInstitute+"' And COMPANYCODE='"+mCompany+"' And EMPLOYEEID='"+mChkMemID+"')) and nvl(b.deactive,'N')='N' Order By EMPLOYEENAME";
					}
//--------------------------------------------DOAA-------------------------------------
					else if(mType.equals("D"))
					{
						qry=" select Distinct A.FACULTYID, A.FACULTYTYPE,a.ACADEMICYEAR,B.EMPLOYEENAME||' ['||B.EMPLOYEECODE||']' EMPLOYEENAME,";
						qry=qry+" C.DEPARTMENT||' ['||B.DEPARTMENTCODE||']' Dept, D.DESIGNATION||' ['||B.DESIGNATIONCODE||']' Degs, A.SUBJECTID SUBJECTID, E.SUBJECTCODE SUBJECTCODE, E.SUBJECT Subject,";
						qry=qry+" WEBKIOSK.getFacultyLoadDetails('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,'"+mE+"',A.SUBJECTID) FacLoadDet,";
						qry=qry+" WEBKIOSK.getAssignedTeachLoad('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,A.SUBJECTID) AssignedLoad, ";
						qry=qry+" WEBKIOSK.getMaxTeachLoad('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,'"+mE+"') MaxLoad";
						qry=qry+" From PR#HODLOADDISTRIBUTION A, V#STAFF B, DEPARTMENTMASTER C, DESIGNATIONMASTER D, SUBJECTMASTER E where A.FACULTYID=B.EMPLOYEEID";
						qry=qry+" and A.COMPANYCODE=b.COMPANYCODE and A.facultyTYPE=b.EMPLOYEETYPE and ";
						qry=qry+" B.DEPARTMENTCODE=C.DEPARTMENTCODE AND B.DESIGNATIONCODE=D.DESIGNATIONCODE AND A.SUBJECTID=E.SUBJECTID and a.institutecode=e.institutecode";
						qry=qry+" and A.INSTITUTECODE='"+mInstitute+"' and a.COMPANYCODE='"+mCompany+"' And EXAMCODE='"+mE+"' and STATUS='"+mShowLoadOn+"' and B.DEPARTMENTCODE='"+QryDept+"' and nvl(b.deactive,'N')='N' Order By EMPLOYEENAME";
					}
//--------------------------------------------SELF-------------------------------------
					else
					{
						qry=" select Distinct A.FACULTYID, A.FACULTYTYPE,a.ACADEMICYEAR, B.EMPLOYEENAME||' ['||B.EMPLOYEECODE||']' EMPLOYEENAME,";
						qry=qry+" C.DEPARTMENT||' ['||B.DEPARTMENTCODE||']' Dept, D.DESIGNATION||' ['||B.DESIGNATIONCODE||']' Degs, A.SUBJECTID SUBJECTID, E.SUBJECTCODE SUBJECTCODE, E.SUBJECT Subject,";
						qry=qry+" WEBKIOSK.getFacultyLoadDetails('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,'"+mE+"',A.SUBJECTID) FacLoadDet,";
						qry=qry+" WEBKIOSK.getAssignedTeachLoad('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,A.SUBJECTID) AssignedLoad, ";
						qry=qry+" WEBKIOSK.getMaxTeachLoad('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,'"+mE+"') MaxLoad";
						qry=qry+" From PR#HODLOADDISTRIBUTION A, V#STAFF B, DEPARTMENTMASTER C, DESIGNATIONMASTER D, SUBJECTMASTER E where A.FACULTYID=B.EMPLOYEEID";
						qry=qry+" and A.COMPANYCODE=b.COMPANYCODE and A.facultyTYPE=b.EMPLOYEETYPE and ";
						qry=qry+" B.DEPARTMENTCODE=C.DEPARTMENTCODE AND B.DESIGNATIONCODE=D.DESIGNATIONCODE AND A.SUBJECTID=E.SUBJECTID and a.institutecode=e.institutecode";
						qry=qry+" and A.INSTITUTECODE='"+mInstitute+"' and a.COMPANYCODE='"+mCompany+"' And EXAMCODE='"+mE+"' and STATUS='"+mShowLoadOn+"' and B.DEPARTMENTCODE='"+QryDept+"'";
						qry=qry+" And A.FACULTYID='"+mChkMemID+"' and  nvl(b.deactive,'N')='N' Order By EMPLOYEENAME ";
					}*/
//					mE="2009ODDSEM";
					qry="SELECT DISTINCT  a.studentid ,a.programcode,a.academicyear ,c.STUDENTNAME STUDENTNAME,c.ENROLLMENTNO  FROM pr#studentsubjectchoice a, subjectmaster b,studentmaster c          WHERE a.examcode = '"+mE+"'        AND a.semestertype IN ('RWJ', 'SAP')            AND NVL (a.deactive, 'N') = 'N'            AND NVL (c.deactive, 'N') = 'N'            AND NVL (b.deactive, 'N') = 'N' AND a.subjectid = b.subjectid  and a.STUDENTID=c.STUDENTID  AND NVL(a.SUBJECTRUNNING,'N')='Y'   and a.subjectid =decode('"+subjects+"','ALL',a.subjectid ,'"+subjects+"') 	and a.programcode =decode('"+ProgramCode+"','ALL',a.programcode ,'"+ProgramCode+"') and a.academicyear=decode('"+AcadYear+"','ALL',a.academicyear,'"+AcadYear+"')    and a.INSTITUTECODE=c.INSTITUTECODE            AND a.institutecode = '"+mInst+"'  and a.PROGRAMCODE=c.PROGRAMCODE             and a.SUBJECTID=b.SUBJECTID   AND a.institutecode = '"+mInst+"'        AND a.institutecode = b.institutecode order by studentname";
					//out.println(qry);
					rs=db.getRowset(qry);
					while(rs.next())
					{ 
						
					%>
							<tr>
							<td nowrap><font color=<%=mcolor%>><%=ctr++%>.</font></td>
							<td nowrap ><font color=<%=mcolor%>><%=rs.getString("STUDENTNAME")%> (<%=rs.getString("ENROLLMENTNO")%>)</font></td>
						
						

						<td nowrap ><font color=<%=mcolor%>><%=rs.getString("programcode")%></font></td>
						<td nowrap ><font color=<%=mcolor%>><%=rs.getString("academicyear")%></font></td>
						

						<%

							


					query="SELECT DISTINCT  e.subjectid subjectid, e.subjectcode subjectcode,  e.subject subject, to_number(d.l) l, to_number(d.t) t, to_number(d.p) p, NVL(B.LFSTID,'N')LFSTID ,NVL(B.TFSTID,'N')  TFSTID,NVL(B.PFSTID,'N') PFSTID                 FROM            pr#studentsubjectchoice b,                subjectmaster e,                programsubjecttagging d          WHERE             NVL (b.deactive, 'N') = 'N'            AND NVL (d.deactive, 'N') = 'N'            AND b.institutecode = d.institutecode           and b.SUBJECTID=e.SUBJECTID            AND D.SUBJECTID=E.SUBJECTID            AND  b.subjectid = d.subjectid            AND b.semestertype IN ('RWJ', 'SAP')             AND NVL (b.subjectrunning, 'N') = 'Y'            AND b.institutecode = '"+mInstitute+"'            AND b.examcode = '"+mE+"'                AND NVL (b.deactive, 'N') = 'N'            AND b.subjectid = DECODE ('"+subjects+"', 'ALL', b.subjectid,'"+subjects+"')            AND b.programcode = DECODE ('"+ProgramCode+"', 'ALL', b.programcode, '"+ProgramCode+"')            AND b.academicyear = DECODE ('"+AcadYear+"', 'ALL', b.academicyear,'"+AcadYear+"')            AND b.studentid = '"+rs.getString("studentid")+"' and b.sectionbranch = d.sectionbranch  and b.EXAMCODE=d.EXAMCODE and  b.programcode = d.programcode and			b.academicyear = d.academicyear 					 UNION                        SELECT DISTINCT e.subjectid subjectid, e.subjectcode subjectcode,                e.subject subject, NVL (d.l, '') l, NVL (d.t, '') t,                NVL (d.p, '') p, NVL (b.lfstid, 'N') lfstid,                NVL (b.tfstid, 'N') tfstid, NVL (b.pfstid, 'N') pfstid           FROM pr#studentsubjectchoice b, subjectmaster e, Pr#electivesubjects d          WHERE NVL (b.deactive, 'N') = 'N'            AND NVL (d.deactive, 'N') = 'N'            AND b.institutecode = d.institutecode            AND b.subjectid = e.subjectid            AND d.subjectid = e.subjectid            AND b.subjectid = d.subjectid            AND b.semestertype IN ('RWJ', 'SAP')            AND NVL (b.subjectrunning, 'N') = 'Y'  AND NVL (d.subjectrunning, 'N') = 'Y'           AND b.institutecode ='"+mInstitute+"'              AND b.examcode = '"+mE+"'              AND NVL (b.deactive, 'N') = 'N'            AND b.subjectid = DECODE ('"+subjects+"', 'ALL', b.subjectid, '"+subjects+"')            AND b.programcode = DECODE ('"+ProgramCode+"', 'ALL', b.programcode, '"+ProgramCode+"')            AND b.academicyear = DECODE ('"+AcadYear+"', 'ALL', b.academicyear, '"+AcadYear+"')            AND b.studentid ='"+rs.getString("studentid")+"'            AND b.programcode = d.programcode and  b.sectionbranch = d.sectionbranch           and	b.academicyear = d.academicyear                UNION                        SELECT DISTINCT e.subjectid subjectid, e.subjectcode subjectcode,                e.subject subject, NVL (d.l, '') l, NVL (d.t, '') t,                NVL (d.p, '') p, NVL (b.lfstid, 'N') lfstid,                NVL (b.tfstid, 'N') tfstid, NVL (b.pfstid, 'N') pfstid           FROM pr#studentsubjectchoice b, subjectmaster e, OFFERSUBJECTTAGGING d          WHERE NVL (b.deactive, 'N') = 'N'            AND NVL (d.deactive, 'N') = 'N'            AND b.institutecode = d.institutecode            AND b.subjectid = e.subjectid            AND d.subjectid = e.subjectid            AND b.subjectid = d.subjectid            AND b.semestertype IN ('RWJ', 'SAP')            AND NVL (b.subjectrunning, 'N') = 'Y'            AND b.institutecode = '"+mInstitute+"'             AND b.examcode = '"+mE+"'              and b.EXAMCODE=d.EXAMCODE            AND NVL (b.deactive, 'N') = 'N'            AND b.subjectid = DECODE ('"+subjects+"', 'ALL', b.subjectid, '"+subjects+"')            AND b.programcode = DECODE ('"+ProgramCode+"', 'ALL', b.programcode,'"+ProgramCode+"')            AND b.academicyear = DECODE ('"+AcadYear+"', 'ALL', b.academicyear, '"+AcadYear+"')            AND b.studentid = '"+rs.getString("studentid")+"'";		
					//and			b.academicyear = d.academicyear            AND b.programcode = d.programcode   ";      //   AND b.sectionbranch = d.sectionbranch            AND*/

	

					/*query="SELECT DISTINCT  b.STUDENTID, a.subjectid subjectid, e.subjectcode subjectcode,                e.subject subject  ,nvl(L.ltp,'N') L,nvl(T.ltp,'N') T,nvl(P.LTP,'N') P,nvl(B.LFSTID,'N')LFSTID,NVL(B.TFSTID,'N')TFSTID,NVL(B.PFSTID,'N')PFSTID           FROM pr#hodloaddistribution a,                pr#studentsubjectchoice b,                subjectmaster e,                studentmaster c,(select g.ltp,subjectid,institutecode,academicyear,examcode,programcode                 ,sectionbranch,semester,SEMESTERTYPE from pr#hodloaddistribution g                 where g.ltp='L')L  ,                 (select g.ltp,subjectid,institutecode,academicyear,examcode,programcode                 ,sectionbranch,semester,SEMESTERTYPE from pr#hodloaddistribution g                 where g.ltp='T')T ,                 (select g.ltp,subjectid,institutecode,academicyear,examcode,programcode                 ,sectionbranch,semester,SEMESTERTYPE from pr#hodloaddistribution g                 where g.ltp='P')P                          WHERE a.subjectid = e.subjectid            AND a.subjectid = b.subjectid            AND NVL (a.deactive, 'N') = 'N'            AND NVL (c.deactive, 'N') = 'N'             AND a.subjectid = L.subjectid(+)            AND a.institutecode = L.institutecode(+)            AND a.academicyear =L.academicyear(+)            AND a.examcode =L.examcode(+)            AND a.programcode = L.programcode(+)            AND a.sectionbranch = L.sectionbranch(+)            AND a.semestertype = L.semestertype(+)            AND a.semester = L.semester(+)            AND a.subjectid = T.subjectid(+)            AND a.institutecode = T.institutecode(+)            AND a.academicyear =T.academicyear(+)            AND a.examcode =T.examcode(+)            AND a.programcode = T.programcode(+)            AND a.sectionbranch = T.sectionbranch(+)            AND a.semestertype = T.semestertype(+)            AND a.semester = T.semester(+)                        AND a.subjectid = P.subjectid(+)            AND a.institutecode = P.institutecode(+)            AND a.academicyear =P.academicyear(+)            AND a.examcode =P.examcode(+)            AND a.programcode = P.programcode(+)            AND a.sectionbranch = P.sectionbranch(+)            AND a.semestertype = P.semestertype(+)            AND a.semester = P.semester(+)                        AND a.subjectid = b.subjectid            AND a.institutecode = b.institutecode            AND a.academicyear = b.academicyear            AND a.examcode = b.examcode            AND a.programcode = b.programcode            AND a.sectionbranch = b.sectionbranch            AND b.studentid = c.studentid            AND b.institutecode = c.institutecode            AND b.semestertype IN ('RWJ', 'SAP')            AND a.semestertype = b.semestertype            AND a.semester = b.semester            AND a.institutecode = e.institutecode            AND NVL (b.subjectrunning, 'N') = 'Y'            AND a.institutecode = '"+mInstitute+"'                  AND a.examcode =  '"+mE+"'            AND NVL (b.deactive, 'N') = 'N'            AND a.subjectid = DECODE ('"+subjects+"', 'ALL', a.subjectid, '"+subjects+"')            AND a.programcode = DECODE ('"+ProgramCode+"', 'ALL', a.programcode, '"+ProgramCode+"')            AND a.academicyear = DECODE ('"+AcadYear+"', 'ALL', a.academicyear,'"+AcadYear+"')            AND b.studentid = '"+rs.getString("studentid")+"' ";*/
						//out.println(query);
						int count=0;
						
						 rsjj1=db.getRowset(query);
						 rsjj=db.getRowset(query);
//out.print(query);
						if (rsjj.next())
						{
							
						//count++;
						%>
						<td>
							<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
							<thead>
								<tr bgcolor="#ff8c00">				
									<TD><font color=white><b>Subject Name</b></font></TD>
									<TD align=center><font color=white><b>L</b></font></TD>
									<TD align=center><font color=white><b>T</b></font></TD>
									<TD align=center><font color=white><b>P</b></font></TD>
								</TR>
								<%
							while(rsjj1.next())
								{
						//out.println("SDFSFSDDFS");
							
								
							
							%>
								
								<TR>
									<TD><%=rsjj1.getString("subject")%>(<%=rsjj1.getString("subjectcode")%>)</TD>
									<%
									if(rsjj1.getInt("L")>0  )
									{
									if(!rsjj1.getString("LFSTID").equals("N"))
										{

											qry1="select programcode,academicyear, sectionbranch, subsectioncode from pr#hodloaddistribution where EXAMCODE = '"+mE+"' AND FSTID = '"+rsjj1.getString("LFSTID")+"' and  institutecode = '"+mInstitute+"'     ";
											rs1=db.getRowset(qry1);
											if(rs1.next())
												{
												%>
												<TD nowrap><font color=green ><b> <%=rs1.getString("programcode")%> - <%=rs1.getString("sectionbranch")%> - <%=rs1.getString("subsectioncode")%>  </font></TD>
												<%
												}
												else
												{
													%>
														<TD>NOT  ASSIGN</TD>	
													<%
												}
										
										}
										else
										{
											%>
											<TD>NOT ASSIGN</TD>
												<%
										}
									
									}
									else
									{
										%>
									<TD>--&nbsp;</TD>
									<%
									}
									
									if(rsjj1.getInt("T")>0)
									{
									if(!rsjj1.getString("TFSTID").equals("N"))
										{

											qry1="select programcode,academicyear, sectionbranch, subsectioncode from pr#hodloaddistribution where EXAMCODE = '"+mE+"' AND FSTID = '"+rsjj1.getString("TFSTID")+"' and  institutecode = '"+mInstitute+"'     ";
											rs1=db.getRowset(qry1);
											if(rs1.next())
												{
												%>
												<TD nowrap><font color=green ><b> <%=rs1.getString("programcode")%> - <%=rs1.getString("sectionbranch")%> - <%=rs1.getString("subsectioncode")%>  </font></TD>
												<%
												}
												else
												{
													%>
														<TD>NOT  ASSIGN</TD>	
													<%
												}
										}
										else
										{
											%>
											<TD>NOT ASSIGN</TD>
												<%
										}
									
									}
									else
									{
										%>
									<TD>--&nbsp;</TD>
									<%
									}
								
									if(rsjj1.getInt("P")>0)
									{
									if(!rsjj1.getString("PFSTID").equals("N"))
										{

											qry1="select programcode,academicyear, sectionbranch, subsectioncode from pr#hodloaddistribution where EXAMCODE = '"+mE+"' AND FSTID = '"+rsjj1.getString("PFSTID")+"' and  institutecode = '"+mInstitute+"'     ";
											rs1=db.getRowset(qry1);
											if(rs1.next())
												{
												%>
												<TD nowrap><font color=green ><b> <%=rs1.getString("programcode")%> - <%=rs1.getString("sectionbranch")%> - <%=rs1.getString("subsectioncode")%>  </font></TD>
												<%
												}
												else
												{
													%>
														<TD>NOT  ASSIGN</TD>	
													<%
												}
										}
										else
										{
											%>
											<TD>NOT ASSIGN</TD>
												<%
										}
									
									}
									else
									{
										%>
									<TD>--&nbsp;</TD>
									<%
									}
										%>
								</TR>
							<%
									}
								%>							
							</table>	
							</td>								
							</tr>
						
								
						<%
						}
						
					}
					%>			
				
				</tbody>
				</TABLE>
				<TABLE width=80% align=center>
				
				<tr>
				<td colspan=3 align=center title="Click to Print"><font color=blue><a onClick="window.print();"><img src="../../Images/printer.gif">Click to Print</a></font></td>
				</tr>
				</TABLE>
				<script type="text/javascript">
				//var st1 = new SortableTable(document.getElementById("table-1"),[,,,,,,,"Number"]);
				</script>
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