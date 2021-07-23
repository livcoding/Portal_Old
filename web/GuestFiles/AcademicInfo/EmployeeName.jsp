<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
//ResultSet rs2=null;
String mI="";
String mE="", mCh="", mch="";
String qry="";
String qry1="";
String mEmployeeID="",mDesignation="",mDepartmentCode="",mDesignationCode="",mEmp="",mDepartment="";
String mEmployeeType="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mExam="";
String mexam="";
String mStatus="",qry2="";
String mChoice="",mcolor="",mDesiCode="",mDepcode="",mDept="",mDesi="",mEmpcode="";
int sn=0;


if (session.getAttribute("MemberID")==null)
	{
		mMemberID="";
	}
	else
	{
		mMemberID=session.getAttribute("MemberID").toString().trim();
	}

if (session.getAttribute("InstituteCode")==null)
	{
		mInstitute="";
	}
	else
	{
		mInstitute=session.getAttribute("InstituteCode").toString().trim();
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
			out.print(mEmp);

if (request.getParameter("Emp")!=null)
	{
		mEmp=request.getParameter("Emp").toString().trim();
	}
			
if (request.getParameter("Depcode")!=null)

	{			
	mDepcode=request.getParameter("Depcode").toString().trim();
	}
if (request.getParameter("DesiCode")!=null)

	{			
	mDesiCode=request.getParameter("DesiCode").toString().trim();
	}
if (request.getParameter("Empcode")!=null)

	{			
	mEmpcode=request.getParameter("Empcode").toString().trim();
	}
if (request.getParameter("Choice")!=null)

	{			
	mChoice=request.getParameter("Choice").toString().trim();
	}

	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
	else
	mHead="JIIT ";		


%>

	<HTML>
	<head>
	<TITLE>#### <%=mHead%> [Subject Choice Submission/Not Submission ] </TITLE>
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
		-->
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
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
		{	
		OLTEncryption enc=new OLTEncryption();
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
		qry="Select WEBKIOSK.ShowLink('113','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
	//qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from PREVENTS WHERE nvl(APPROVED,'N')='N' and nvl(Deactive,'N')='N' ";
	//rs=db.getRowset(qry);

	//if  (rs.next())
	 // mInstitute=rs.getString(1);
	//else
	 // mInstitute="JIIT";
	
        mI=mInstitute;

	%>
<form name="frm"  method="get">
<input id="x" name="x" type=hidden>
<table width="100%%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">[Faculty Subject Choices Submission Details]</font></td></tr>
			</TABLE>
			<table cellpadding=1 cellspacing=0 align=center rules=groups border=3 width="100%">
			<!--Institute****-->
			<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
			<Input Type=hidden name=EmployeeName Value=<%=mEmp%>>
			
			<Input Type=hidden name=DepartCode Value=<%=mDepcode%>>
			<Input Type=hidden name=DesiCode Value=<%=mDesiCode%>>
			<Input Type=hidden name=EmpCode Value=<%=mEmpcode%>>
			<Input Type=hidden name=Choice Value=<%=mChoice%>>


		<%	
			{
			qry1="select distinct nvl(Designation,' ')Designation from Designationmaster where DESIGNATIONCODE='"+mDesiCode+"'";
			//out.print(qry1);
			rs1=db.getRowset(qry1);
			
			while(rs1.next())
			{
			mDesi=rs1.getString("Designation");
			}				
			qry="select distinct nvl(Department,' ')Department from Departmentmaster where departmentcode='"+mDepcode+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			while(rs.next())
			{
			mDept=rs.getString("Department");
			}	


			
	%>

				<!--Employee Name****-->
				<tr><td><FONT color=#00008b><FONT face=Arial size=2><STRONG>Employee Name &nbsp;&nbsp;&nbsp; :&nbsp;&nbsp;</STRONG></FONT></FONT><%=mEmp%><br>	
				
				<!--Designation****-->
				<FONT color=#00008b><FONT face=Arial size=2><STRONG>Designation &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;</STRONG></FONT></FONT><%=mDesi%>(<%=mDesiCode%>)</td></tr>
	
   				<!--Department Name****-->
				<tr><td><FONT color=00008b><FONT face=Arial size=2><STRONG>Department Name&nbsp;&nbsp;:&nbsp;&nbsp;</STRONG></FONT></FONT><%=mDept%>(<%=mDepcode%>)</td></tr>

				
				
				</table></form>

	
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
				<thead>
			 	<tr bgcolor="#ff8c00">
			 	<td align=center><b><font color=white>S.No.</font></td>
			  	<td align=center><b><font color=white>Subject</font></td>
			  	<td align=center><b><font color=white>Choice Preference</font></td>
			  	<td align=center><b><font color=white>Prefered Room</font></td>
			 	</tr>
				</thead>
				</tbody>
			
					<%
						try
						{
						qry1="select distinct nvl(A.Subject,' ')Subject,decode(B.CHOICE,'1','First','2','Second','3','Third')CHOICE ,nvl(B.REQROOMTYPE,' ')REQROOMTYPE,nvl(A.SubjectCode,' ')SubjectCode,nvl(B.SubjectID,' ')SubjectID from ";
						qry1=qry1+"PR#FACULTYSUBJECTCHOICES B,SUBJECTMASTER A where B.SubjectID=A.SubjectID and B.FACULTYID='"+mEmpcode+"'  order by CHOICE";
						//out.print(qry1);
						rs1=db.getRowset(qry1);
						while(rs1.next())
						{
						sn++;
					%>
					<tr>
					<td nowrap><font color=<%=mcolor%>>&nbsp;<%=sn%></font></td>
					<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("Subject")%>&nbsp;&nbsp;(<%=rs1.getString("SubjectCode")%>)</font></td>
					<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("CHOICE")%></font></td>
					<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("REQROOMTYPE")%></font></td>
					</tr>		
					<%
						}          //Closing Of While
					%>
	
					</tbody>
					</table>	
					<script type="text/javascript">
					var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
					</script>
					
					<%	
						}
						catch(Exception e)
						{
						}
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
			</body>
			</html>
