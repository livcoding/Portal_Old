<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
int ctr=0;
int mRights=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="",mCompany="",mComp="";
String mExam="",mE="";
String mexam="";
String QryDept="", mDeptCode="", mDeptName="", mcolor="Black";
String Heading="", mType="", mGetFacLoad="", mLLoad="", mTLoad="", mPLoad="", mTotalLoad="";
int len=0, pos1=0, pos2=0, pos3=0, posL=0, posT=0, posP=0;
String OldEmp="";
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
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Faculty Assigned Load Distribution (Approved by DOAA)] </TITLE>

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

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from FacultySubjectTagging WHERE nvl(Deactive,'N')='N'";
		rs=db.getRowset(qry);
		//out.println(qry);
		if(rs.next())
			mInstitute=rs.getString("InstCode");	
		else
			mInstitute="JIIT";

		qry="Select Distinct NVL(COMPANYCODE,' ')CompCode from FacultySubjectTagging  WHERE nvl(Deactive,'N')='N'";
		rs=db.getRowset(qry);
		//out.println(qry);
		if(rs.next())
			mCompany=rs.getString("CompCode");	
		else
			mCompany="JIIT";
		mCompany="UNIV";

	     //-----------------------------
	     //-- Enable Security Page Level  
	     //-----------------------------
		
		mInst=mInstitute;
		mComp=mCompany;

		if(mType.equals("D"))
		{
		   mRights=129;
		   Heading="DOAA";	
		}
		else if(mType.equals("H"))
		{
		   mRights=130;
		   Heading="HOD";	
		}

		qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
	
				%>
				<form name="frm"  method="get">
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr>
				<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Assigned Load List  (Approved by DOAA)</B></TD>
				</font>
				</td>
				</tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>

				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInst%>'>

				<!--Company****-->
				<INPUT name=CompCode TYPE=HIDDEN id="CompCode" VALUE='<%=mComp%>'>

				<!--Type****-->
				<input type=hidden Name='Type' ID='Type' value='<%=mType%>'>

				<tr>
				<!--*********Exam**********-->
				<td colspan=2><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Exam Code</STRONG></FONT></FONT>
				&nbsp; &nbsp;&nbsp;
				<%
				try
				{
					qry="Select distinct ExamCode Exam from PR#HODLoadDistribution  where nvl(DEACTIVE,'N')='N'";
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
				&nbsp; &nbsp; <FONT color=black><FONT face=Arial size=2><STRONG>Department</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
//--------------------------------------------HOD-------------------------------------
				 if(mType.equals("H"))
				 {
				    //qry="select distinct B.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N'";
				    //qry=qry+" And B.EMPLOYEEID IN (Select EMPLOYEEID from EMPLOYEEMASTER where DEPARTMENTCODE IN (Select DEPARTMENTCODE from HODLIST ";
				    //qry=qry+" where INSTITUTECODE='"+mInstitute+"' And COMPANYCODE='"+mCompany+"' And EMPLOYEEID='"+mChkMemID+"'))  order by DeptName";

				    qry="select distinct A.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A ";
				    qry=qry+" where DEPARTMENTCODE IN (Select DEPARTMENTCODE from HODLIST ";
				    qry=qry+" where INSTITUTECODE='"+mInstitute+"' And COMPANYCODE='"+mCompany+"' And EMPLOYEEID='"+mChkMemID+"') order by DeptName";
				 }
//--------------------------------------------DOAA-------------------------------------
				 else if(mType.equals("D"))
				 {
				    qry="select distinct B.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N' order by DeptName";
			 	 }
//--------------------------------------------SELF-------------------------------------
				 else
				 {
				    qry="select distinct B.DEPARTMENTCODE DeptCode, nvl(A.DEPARTMENT,' ')DeptName from DEPARTMENTMASTER A, V#STAFF B where A.DEPARTMENTCODE = B.DEPARTMENTCODE and nvl(A.deactive,'N')='N'";
				    qry=qry+" And B.EMPLOYEEID='"+mChkMemID+"' order by DeptName";
				 }
				 //out.print(qry);
				 rs=db.getRowset(qry);
				 %>
				 <select name="Dept" tabindex="1" id="Dept">
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
							<option value=<%=mDeptCode%>><%=GlobalFunctions.toTtitleCase(mDeptName)%></option>
						<%
					}
				}
				else
				{
					while(rs.next())
					{
					   	mDeptCode=rs.getString("DeptCode");
					   	mDeptName=rs.getString("DeptName");
					   	if(mDeptCode.equals(request.getParameter("Dept").toString().trim()))
						{
							QryDept=mDeptCode;
							%>
						    		<option selected value=<%=mDeptCode%>><%=GlobalFunctions.toTtitleCase(mDeptName)%></option>
		  					<%
						}
						else
					      {
					   		%>
						    		<option  value=<%=mDeptCode%>><%=GlobalFunctions.toTtitleCase(mDeptName)%></option>
					   		<%
						}	
					}
				}
				%>
				</select>&nbsp;</td></tr>

				<!--***********Load status for HOD or DOAA**********-->
				<tr><td colspan=2 align=right>
				<INPUT Type="submit" Value="&nbsp;Show&nbsp;"></td></tr>
				</table>
				</form>
				<table width=100%>
				<%
					String mEx=request.getParameter("Exam").toString().trim();
				%>
				<tr><td align=center><b>Title: Teaching Load (<%=mEx%>)</b></td></tr>
				<%
				qry="Select department Dept from departmentmaster where departmentcode=decode('"+QryDept+"','ALL',DepartmentCode,'"+QryDept+"')";
				rs=db.getRowset(qry);
				if(rs.next())
				{
				%>
					<tr><td align=center><b>School of <%=GlobalFunctions.toTtitleCase(rs.getString("Dept"))%><b></td></tr>
				<%
				}
				%>
				</table>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
				<thead>
				<tr bgcolor="#ff8c00">
				 <td nowrap align=left><font color=white><b>Sr<br>No</b></font></td>
				 <td nowrap align=center><font color=white><b>Name of Faculty</b></font></td>
				 <td nowrap align=center title="Course Title"><font color=white><b>Course Title</b></font></td>
				 <td nowrap align=left title="Course Code"><font color=white><b>Course<br>Code</b></font></td>
				 <td nowrap align=center nowrap title="Total Assigned Load Against L" align=center><font color=white><b>L</b></font></td>
				 <td nowrap align=center nowrap title="Total Assigned Load Against T" align=center><font color=white><b>T</b></font></td>
				 <td nowrap align=center nowrap title="Total Assigned Load Against P" align=center><font color=white><b>P</b></font></td>
				 <td nowrap title="Total Assigned Load" align=center><font color=white><b>Total</b></font></td>
				</tr>
				</thead>
				<tbody>
				<%
					if (request.getParameter("InstCode")==null)
						mInstitute=mInst;
					else		
						mInstitute=request.getParameter("InstCode").toString().trim();
		
					/*if (request.getParameter("CompCode")==null)
						mCompany=mComp;
					else		
						mCompany=request.getParameter("CompCode").toString().trim();*/

					if (request.getParameter("Exam")==null)
						mE=mexam;
					else
						mE=request.getParameter("Exam").toString().trim();
			
					if(request.getParameter("Dept")!=null)	
						QryDept=request.getParameter("Dept").toString().trim();
					else
						QryDept=QryDept;

					mType=request.getParameter("Type").toString().trim();
					if(mType.equals("D"))
					{
					   mRights=129;
					   Heading="DOAA";	
					}
					else if(mType.equals("H"))
					{
					   mRights=130;
					   Heading="HOD";	
					}

//--------------------------------------------HOD-------------------------------------
					if(mType.equals("H"))
					{
						qry=" select Distinct A.EMPLOYEEID, A.FACULTYTYPE, B.EMPLOYEENAME||' ['||B.EMPLOYEECODE||']' EMPLOYEENAME,";
						qry=qry+" C.DEPARTMENT||' ['||B.DEPARTMENTCODE||']' Dept, D.DESIGNATION||' ['||B.DESIGNATIONCODE||']' Degs, A.SUBJECTID SUBJECTID, E.SUBJECTCODE SUBJECTCODE, E.SUBJECT Subject,";
						qry=qry+" WEBKIOSK.getFacultyLoadDetailsApproved('"+mCompany+"','"+mInstitute+"',A.EMPLOYEEID,A.FACULTYTYPE,'"+mE+"',A.SUBJECTID) FacLoadDet,";
						qry=qry+" WEBKIOSK.getAssignedTeachLoadApproved('"+mCompany+"','"+mInstitute+"',A.EMPLOYEEID,A.FACULTYTYPE,A.SUBJECTID) AssignedLoad, ";
						qry=qry+" WEBKIOSK.getMaxTeachLoad('"+mCompany+"','"+mInstitute+"',A.EMPLOYEEID,A.FACULTYTYPE,'"+mE+"') MaxLoad";
						qry=qry+" From FacultySubjectTagging  A, V#STAFF B, DEPARTMENTMASTER C, DESIGNATIONMASTER D, SUBJECTMASTER E where A.EMPLOYEEID=B.EMPLOYEEID";
						qry=qry+" and A.COMPANYCODE=b.COMPANYCODE and A.facultyTYPE=b.EMPLOYEETYPE and ";
						qry=qry+" B.DEPARTMENTCODE=C.DEPARTMENTCODE AND B.DESIGNATIONCODE=D.DESIGNATIONCODE AND A.SUBJECTID=E.SUBJECTID and a.institutecode=e.institutecode";
						qry=qry+" and A.INSTITUTECODE='"+mInstitute+"' and a.COMPANYCODE='"+mCompany+"' And EXAMCODE='"+mE+"' and B.DEPARTMENTCODE='"+QryDept+"'";
						qry=qry+" And A.EMPLOYEEID IN (Select EMPLOYEEID from V#STAFF  where DEPARTMENTCODE IN (Select DEPARTMENTCODE from HODLIST ";
						qry=qry+" where INSTITUTECODE='"+mInstitute+"' And COMPANYCODE='"+mCompany+"' And EMPLOYEEID='"+mChkMemID+"')) Order By EMPLOYEENAME";
					}

//--------------------------------------------DOAA-------------------------------------
					else if(mType.equals("D"))
					{
						qry=" select Distinct A.EMPLOYEEID, A.FACULTYTYPE, B.EMPLOYEENAME||' ['||B.EMPLOYEECODE||']' EMPLOYEENAME,";
						qry=qry+" C.DEPARTMENT||' ['||B.DEPARTMENTCODE||']' Dept, D.DESIGNATION||' ['||B.DESIGNATIONCODE||']' Degs, A.SUBJECTID SUBJECTID, E.SUBJECTCODE SUBJECTCODE, E.SUBJECT Subject,";
						qry=qry+" WEBKIOSK.getFacultyLoadDetailsApproved('"+mCompany+"','"+mInstitute+"',A.EMPLOYEEID,A.FACULTYTYPE,'"+mE+"',A.SUBJECTID) FacLoadDet,";
						qry=qry+" WEBKIOSK.getAssignedTeachLoadApproved('"+mCompany+"','"+mInstitute+"',A.EMPLOYEEID,A.FACULTYTYPE,A.SUBJECTID) AssignedLoad, ";
						qry=qry+" WEBKIOSK.getMaxTeachLoad('"+mCompany+"','"+mInstitute+"',A.EMPLOYEEID,A.FACULTYTYPE,'"+mE+"') MaxLoad";
						qry=qry+" From FacultySubjectTagging A, V#STAFF B, DEPARTMENTMASTER C, DESIGNATIONMASTER D, SUBJECTMASTER E where A.EMPLOYEEID=B.EMPLOYEEID";
						qry=qry+" and A.COMPANYCODE=b.COMPANYCODE and A.facultyTYPE=b.EMPLOYEETYPE and ";
						qry=qry+" B.DEPARTMENTCODE=C.DEPARTMENTCODE AND B.DESIGNATIONCODE=D.DESIGNATIONCODE AND A.SUBJECTID=E.SUBJECTID and a.institutecode=e.institutecode";
						qry=qry+" and A.INSTITUTECODE='"+mInstitute+"' and a.COMPANYCODE='"+mCompany+"' And EXAMCODE='"+mE+"' and  B.DEPARTMENTCODE='"+QryDept+"' Order By EMPLOYEENAME";
					}
//--------------------------------------------SELF-------------------------------------
					else
					{
						qry=" select Distinct A.EMPLOYEEID, A.FACULTYTYPE, B.EMPLOYEENAME||' ['||B.EMPLOYEECODE||']' EMPLOYEENAME,";
						qry=qry+" C.DEPARTMENT||' ['||B.DEPARTMENTCODE||']' Dept, D.DESIGNATION||' ['||B.DESIGNATIONCODE||']' Degs, A.SUBJECTID SUBJECTID, E.SUBJECTCODE SUBJECTCODE, E.SUBJECT Subject,";
						qry=qry+" WEBKIOSK.getFacultyLoadDetailsApproved('"+mCompany+"','"+mInstitute+"',A.EMPLOYEEID,A.FACULTYTYPE,'"+mE+"',A.SUBJECTID) FacLoadDet,";
						qry=qry+" WEBKIOSK.getAssignedTeachLoadApproved('"+mCompany+"','"+mInstitute+"',A.EMPLOYEEID,A.FACULTYTYPE,A.SUBJECTID) AssignedLoad, ";
						qry=qry+" WEBKIOSK.getMaxTeachLoad('"+mCompany+"','"+mInstitute+"',A.EMPLOYEEID,A.FACULTYTYPE,'"+mE+"') MaxLoad";
						qry=qry+" From FacultySubjectTagging  A, V#STAFF B, DEPARTMENTMASTER C, DESIGNATIONMASTER D, SUBJECTMASTER E where A.EMPLOYEEID=B.EMPLOYEEID";
						qry=qry+" and A.COMPANYCODE=b.COMPANYCODE and A.facultyTYPE=b.EMPLOYEETYPE and ";
						qry=qry+" B.DEPARTMENTCODE=C.DEPARTMENTCODE AND B.DESIGNATIONCODE=D.DESIGNATIONCODE AND A.SUBJECTID=E.SUBJECTID and a.institutecode=e.institutecode";
						qry=qry+" and A.INSTITUTECODE='"+mInstitute+"' and a.COMPANYCODE='"+mCompany+"' And EXAMCODE='"+mE+"' and  B.DEPARTMENTCODE='"+QryDept+"'";
						qry=qry+" And A.EMPLOYEEID='"+mChkMemID+"' Order By EMPLOYEENAME";
					}
					//out.print(qry);
					rs=db.getRowset(qry);
					while(rs.next())
					{ 
						mGetFacLoad=rs.getString("FacLoadDet");
						len=mGetFacLoad.length();
						posL=mGetFacLoad.indexOf("L");
						pos1=mGetFacLoad.indexOf("**");
						posT=mGetFacLoad.indexOf("T");
						pos2=mGetFacLoad.indexOf("##");
						posP=mGetFacLoad.indexOf("P");
						pos3=mGetFacLoad.indexOf("$$");

						mLLoad=mGetFacLoad.substring(posL+1,pos1);
						mTLoad=mGetFacLoad.substring(posT+1,pos2);
						mPLoad=mGetFacLoad.substring(posP+1,pos3);
						mTotalLoad=mGetFacLoad.substring(pos3+2,len);

						if(!OldEmp.equals(rs.getString("EMPLOYEENAME")))
						{
							ctr++;
							OldEmp=rs.getString("EMPLOYEENAME");
							%>
							<tr>
							<td nowrap><font color=<%=mcolor%>><%=ctr%>.</font></td>
							<td nowrap title="<%=rs.getString("Degs")%>, <%=rs.getString("Dept")%>"><font color=<%=mcolor%>><%=rs.getString("EMPLOYEENAME")%></font></td>
						<%
						}
						else
						{
							%>
							<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<%
						}
						%>
						<td nowrap><font color=<%=mcolor%>><%=rs.getString("SUBJECT")%></font></td>
						<td nowrap align=left><font color=<%=mcolor%>><%=rs.getString("SUBJECTCODE")%></font></td>
						<%
						if(mLLoad.equals(""))
						{
						%>
							<td nowrap align=center><font color=<%=mcolor%>>-</font></td>
						<%
						}
						else
						{
						%>
							<td nowrap align=center><font color=<%=mcolor%>><%=mLLoad%></font></td>
						<%
						}

						if(mTLoad.equals(""))
						{
						%>
							<td nowrap align=center><font color=<%=mcolor%>>-</font></td>
						<%
						}
						else
						{
						%>
							<td nowrap align=center><font color=<%=mcolor%>><%=mTLoad%></font></td>
						<%
						}

						if(mPLoad.equals(""))
						{
						%>
							<td nowrap align=center><font color=<%=mcolor%>>-</font></td>
						<%
						}
						else
						{
						%>
							<td nowrap align=center><font color=<%=mcolor%>><%=mPLoad%></font></td>
						<%
						}

						if(mTotalLoad.equals(""))
						{
						%>
							<td nowrap align=center><font color=<%=mcolor%>>-</font></td>
						<%
						}
						else
						{
						%>
							<td nowrap align=center title="Out of <%=rs.getString("MaxLoad")%>"><font color=<%=mcolor%>><%=mTotalLoad%></font></td>
						<%
						}
						
						String query="Select b.employeename ,a.NOFHRS,nvl(a.FACULTYSET,'Not Assigned')FACULTYSET,nvl(a.CLASSINAWEEK ,'0')CLASSINAWEEK from multifacultysubjecttagging a, V#staff b where fstid in (select distinct fstid from pr#hodloaddistribution where INSTITUTECODE	='"+mInstitute+"' AND COMPANYCODE	='"+mCompany+"' AND FACULTYID='"+rs.getString("FACULTYID")+"' AND EXAMCODE='"+mE+"'	 AND SUBJECTID='"+rs.getString("SUBJECTID")+"'	AND ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' )  AND a.companycode = '"+mCompany+"'   and a.COMPANYCODE=b.COMPANYCODE  and a.EMPLOYEEID=b.EMPLOYEEID       and nvl(a.DEACTIVE,'N')<>'Y'       and nvl(B.DEACTIVE,'N')<>'Y' ";
						//out.println(query);
						int count=0;
						ResultSet rsjj=db.getRowset(query);
						ResultSet rsjj1=db.getRowset(query);
						if (rsjj.next())
						{
						//count++;
						%>
						<td>
							<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
							<thead>
								<tr bgcolor="#ff8c00">				
									<TD ><font color=white><b>Faculty Name</b></font></TD>
									<TD ><font color=white><b>Set</b></font></TD>
									<TD ><font color=white><b>Class Week</b></font></TD>
								</TR>
								<%
							while(rsjj1.next())
								{
							%>
								
								<TR>
									<TD><%=rsjj1.getString("employeename")%></TD>
									<TD><%=rsjj1.getString("FACULTYSET")%></TD>
									<TD align=center><%=rsjj1.getString("CLASSINAWEEK")%></TD>
								</TR>
							<%}%>							
							</table>	
							</td>								
							</tr>
						
								
						<%
						}
						else
						{
							%><td>&nbsp;</td></tr><%
						}
						
  					}
				%>
				</tbody>
				</TABLE>
				<TABLE width=80% align=center>
				<tr>
				<td align=center>&nbsp;</td>
				<td align=center>&nbsp;</td>
				<td align=center>&nbsp;</td>
				</tr>
				<tr>
				<td align=center>&nbsp;</td>
				<td align=center>&nbsp;</td>
				<td align=center>&nbsp;</td>
				</tr>
				<tr>
				<td align=center><b><font size=2>Head of Department</font></b></td>
				<td align=center><b><font size=2>Member</font></b></td>
				<td align=center><b><font size=2>Member</font></b></td>
				</tr>
				<tr>
				<td colspan=3 align=center title="Click to Print"><font color=blue><a onClick="window.print();"><img src="../../Images/printer.gif"></a></font></td>
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