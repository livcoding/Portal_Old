<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	SignUpMemberBulk.JSP		[For Employee]			   *
	' * Author:		Ashok Kumar Singh 						         *
	' * Date:		3rd Nov 2006	 							   *
	' * Version:		1.0									   *	
	' **********************************************************************************************************
*/

String qry="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
ResultSet rs=null;

String mMemberID="",mMemberType="",mMemberCode="";
int mMaxPWD=20;
int mMinPWD=5;

try{


if (session.getAttribute("MinPasswordLength")==null)
{
	mMinPWD=5;
}
else
{
	mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());
 

}


if (session.getAttribute("MaxPasswordLength")==null)
{
	mMaxPWD=20;
}
else
{
	mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());
		 

}

}
catch(Exception e)
{
mMaxPWD=20;
mMinPWD=4;

}


if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
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
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</HEAD>
<BODY bgcolor="#fce9c5" rightmargin=5 leftmargin=1 topmargin=1 bottommargin=0 scroll=auto>
<% 
try
{ 
if(!mMemberID.equals("") || !mMemberCode.equals(""))
{
mMemberID=enc.decode(mMemberID);
mMemberCode=enc.decode(mMemberCode);
%>
<center><U><FONT face='arial' color=darkbrown size=4>New Member Signup Screen </FONT></U>
<font size=3 color='#008080'><br><marquee behavior=alternate scrolldelay=250>For each Member Type (Student, Employee, Guest etc.], process will be repeated seperatly </marquee></FONT></center>
<TABLE cellSpacing=2 cellPadding=3 width="100%" border=2 rules="rows" bordercolor=black>
  <TR style="BACKGROUND-COLOR: maroon">
    <TD><FONT style="BACKGROUND-COLOR: #800000" face=arial color=ivory>Member Type</FONT></TD>
    <TD><FONT style="BACKGROUND-COLOR: #800000" face=arial color=snow>Criteria for Members - All or Selected</FONT></TD></TR>
  <TR>
  <form name=frm1 action="SignUpActionStud.jsp" methd=post>
    <TD align=center><b>Students</b>
	<br>Role to be assigned<br><select style="WIDTH: 155px;" name=RoleName id=RoleName><option value="STUD">Students</option></select><br>
 Default Password<br>
	<input Type=Text ID=StdPwd Name=StdPwd Size=>	<font color=red>*</font>
	<font color=green>Password Length <%=mMinPWD%> to <%=mMaxPWD%></font>			
<BR>&nbsp;<input type="Submit" value="Create LoginID Now" name=btn1>
  </TD>
    <TD>	
      <INPUT id=ChkAllSudent type=radio checked name=ChkAllSudent title='LoginID for All Students' value =A>Login for all Students
      &nbsp;<font color=red><b>or</b></font>&nbsp;<INPUT id=ChkAllSudent title='For selected Students-Program wise' type=radio value=S name=ChkAllSudent>
      Selected Students- Program based only
      <br>

	<SELECT id=ProgramCode style="WIDTH: 450px; HEIGHT: 136px" multiple size=2 name=ProgramCode>
	<%
	qry="Select PROGRAMCODE, PROGRAMNAME from ProgramMaster where nvl(DEACTIVE,'N')='N' order by PROGRAMNAME ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
	%>
	<OPTION value=<%=rs.getString("PROGRAMCODE")%>><%=rs.getString("PROGRAMNAME")%>-<%=rs.getString("PROGRAMCODE")%></OPTION>
	<%
	}
	%>
	</SELECT>
	</TD></TR>
	</form>
  <TR>
<form name=frm2 action="SignUpActionEmp.jsp" methd=post>
    <TD align=center><b>Employee</b><br>
	Role to be assigned<br><select style="WIDTH: 155px;" name=RoleName id=RoleName><option value="EMP">Employee</option></select><br>
	Default Password
    <input Type=Text ID=EmpPwd Name=EmpPwd Size=><font color=red>*</font>
 	<font color=green>Password Length <%=mMinPWD%> to <%=mMaxPWD%></font>			
<BR>&nbsp;<input type="Submit" value="Create LoginID Now" name=btn2>
</TD>
    <TD>
      <INPUT id=ChkAllEmployee checked title='Login ID for All Employee' type=radio value=A name=ChkAllEmployee>Login for 
      all Employee&nbsp;<font color=red><b>or</b></font>&nbsp;
	<INPUT id=ChkAllEmployee title='Select Employee - Departmentwise' type=radio value=S name=ChkAllEmployee>      Selected Employee - Department based<br>
      <SELECT id=DepartmentCode style="WIDTH: 450px; HEIGHT: 136px" multiple size=2 name=DepartmentCode>
	<%
	qry="Select DEPARTMENTCODE,DEPARTMENT,DEPARTMENT||' ( '||DEPARTMENTCODE||' )' Dept from DEPARTMENTMASTER where nvl(DEACTIVE,'N')='N' order by DEPARTMENT";
	rs=db.getRowset(qry);
	while(rs.next())
	{
	%>
	<OPTION value=<%=rs.getString("DEPARTMENTCODE")%>><%=rs.getString("DEPT")%></OPTION>
	<%
	}
	%>
	</SELECT></TD></form></TR>
  <TR>
<!--<form name=frm3 action="SignUpActionVisitingFaclty.jsp" methd=post>
    <TD align=center><SUP>#</SUP><b>Visiting Faculty</b><br>Default Password
    <input Type=Text ID=VisPwd Name=VisPwd Size=><font color=red>*</font>
	<font color=green>Password Length <%=mMinPWD%> to <%=mMaxPWD%></font>			
 <BR>&nbsp;<input type="Submit" value="Create LoginID Now" name=btn3>
	</TD>
    <TD>
      <INPUT id=ChkAllVisiting checked title='LoginID for All Employee' type=radio size=37 value=Y name=ChkAllVisiting>All Visiting Faculties
	&nbsp;<font color=red><b>or</b></font>&nbsp;
	<INPUT id=ChkAllVisiting title='LoginID All Visiting Faculties' type=radio value=Y name=ChkAllVisiting>Selected Visiting Faculties<br>
      <SELECT id=VisitingID style="WIDTH: 450px; HEIGHT: 136px" multiple size=2 name=VisitingID>
	<%
	qry="Select FACULTYID, FACULTYNAME||' ( '|| INITIALS ||' )' Fname from VISITINGFACULTYMASTER where nvl(DEACTIVE,'N')='N' order by Fname  ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
	%>
	<OPTION value=<%=rs.getString("FACULTYID")%>><%=rs.getString("Fname")%></OPTION>
	<%
	}
	%>

	</SELECT></TD>	</form></TR>
  <TR>
    <TD><SUP>#</SUP>Guest</TD>
    <TD></TD></TR></TABLE></P>
<FORM id=FORM2>
<P><SUP></SUP>&nbsp;</P>
<P><SUP>#<STRONG><SUB> Not active 
presently</SUB></STRONG></SUP></P></FORM>-->
<%
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

</BODY>
</HTML>
