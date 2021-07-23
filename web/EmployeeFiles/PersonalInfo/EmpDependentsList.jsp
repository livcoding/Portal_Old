<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

ResultSet rs=null, Qrs=null, rs1=null;
String qry="", Qqry="", qry1="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
/*
	' 
*************************************************************************************************
	' *												
	' * File Name		:	EmpDependentsList.JSP
	' * Author			:	Vijay
	' * Date			:	15th Feb 2007								
	' * Version			:	1.0								
	' * Description		:	Displays Employee's Spouse/Dependent List.
*************************************************************************************************
*/

String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Employee Dependents Detail] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

 <script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<% 
String mEmpCode="", mEmpName="", mDesignation="", mDepartment="";
String mInst="",mWebEmail="", mSex="", mDOB="", mAge="";
try{
// session.getAttribute("MemberID").toString().trim()
OLTEncryption enc=new OLTEncryption();
if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('2','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

if (session.getAttribute("InstituteCode")==null || session.getAttribute("InstituteCode").toString().equals(""))
   mInst="";
else
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}
mInst=session.getAttribute("InstituteCode").toString().trim();

qry="Select nvl(a.EMPLOYEECODE,' ') EMPLOYEECODE, nvl(a.EMPLOYEENAME, ' ') EMPLOYEENAME, ";
qry=qry+" nvl(b.DESIGNATION,' ') DESIGNATION, nvl(c.DEPARTMENT,' ') DEPARTMENT from ";
qry=qry+" EmployeeMaster a, DESIGNATIONMASTER b, DEPARTMENTMASTER c Where a.EmployeeID='"+mChkMemID+"'";
qry=qry+" and a.DESIGNATIONCODE=b.DESIGNATIONCODE and a.DEPARTMENTCODE=c.DEPARTMENTCODE";
qry=qry+" and nvl(a.DEACTIVE,'N')='N' and nvl(b.DEACTIVE,'N')='N' and nvl(c.DEACTIVE,'N')='N'";
rs=db.getRowset(qry);
//out.print(qry);
if(rs.next())
{
	if (rs.getString("EMPLOYEECODE") ==null)
		mEmpCode="";
	else
		mEmpCode=rs.getString("EMPLOYEECODE");

	if (rs.getString("EMPLOYEENAME") ==null)
		mEmpName="";
	else
		mEmpName=rs.getString("EMPLOYEENAME");

	if (rs.getString("DESIGNATION") ==null)
		mDesignation="";
	else
		mDesignation=rs.getString("DESIGNATION");

	if (rs.getString("DEPARTMENT")==null)
		mDepartment="";
	else
		mDepartment=rs.getString("DEPARTMENT");
%> 
<CENTER><STRONG><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Dependent Detail</FONT></u></b></font></STRONG></CENTER>
<br>
 <font color='#00008b' size=3 face='Times New Roman'><b>Employee Name: &nbsp;&nbsp;<%=mEmpName%> [<%=mEmpCode%>]<br>
 Department: &nbsp;&nbsp;<%=GlobalFunctions.toTtitleCase(mDepartment)%><br>
 Designation: &nbsp;&nbsp;<%=GlobalFunctions.toTtitleCase(mDesignation)%><br>
<br>
<TABLE align=left rules=Columns class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1>
<thead>
	<tr bgcolor="#ff8c00">
	  <TD nowrap><font color=white><b>SlNo.</b></font></TD>
	  <TD nowrap><font color=white><b>Dependent Name</b></font></TD>
	  <TD nowrap><font color=white><b>Date of Birth (Age)</b></font></TD>
	  <TD nowrap><font color=white><b>Sex</b></font></TD>
	  <TD nowrap><font color=white><b>Relation</b></font></TD>
	  <TD nowrap><font color=white><b>Occupation</b></font></TD>
	  <!--<TD nowrap><font color=white><b>Remarks (if any?)</b></font></TD>-->
  </tr>
</thead>
<tbody>
<%
Qqry="select nvl(DEPENDENTNO,0) DEPENDENTNO, nvl(DEPENDENTNAME,' ') DEPENDENTNAME, nvl(OCCUPATION,'-') OCCUPATION, nvl(SEX,' ')SEX, nvl(to_char(DATEOFBIRTH,'DD-MM-YYYY'),' ')DOB, nvl(RELATION,' ') RELATION, nvl(REMARKS,' ') REMARKS";
Qqry=Qqry+" from EMPLOYEEDEPENDENT where EMPLOYEEID='"+mChkMemID+"' Order by to_char(DateOfBirth,'YYYY') asc";
Qrs=db.getRowset(Qqry);	
//out.print(Qqry);
int mSNo=0;
 	 while (Qrs.next())
	 {
	 mSNo++;
	 mDOB=Qrs.getString("DOB");
%>
  <tr>
		<td nowrap><%=mSNo%>.</td>
		<td nowrap><%=Qrs.getString("DEPENDENTNAME")%></td>
		<%
		if(mDOB.equals(" "))
			mDOB="";
		qry1="select trunc(sysdate)-to_date('"+mDOB+"','dd-MM-yyyy') from dual ";
		//out.print(qry1);
		rs1=db.getRowset(qry1);
		rs1.next();
		long msys=rs1.getLong(1);
		long myage=(4*msys)/1461; 
		%>
		
		<td nowrap><%=Qrs.getString("DOB")%> (<%=myage%>)</font></td>
<%
if(Qrs.getString("SEX").equals("F"))
	mSex="Female";
else
	mSex="Male";	
%>
		<td nowrap><%=mSex%></td>
		<td nowrap><%=Qrs.getString("Relation")%></td>
		<td nowrap><%=Qrs.getString("OCCUPATION")%></td>
		<!--<td nowrap><%=Qrs.getString("REMARKS")%></td>-->
  </tr>
<%
   }
%>
</tbody>
</TABLE>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>
<%
}
else
{
%>
<P><FONT face=Arial size="2"><FONT color=black>Dependent not found...</FONT></FONT></P>
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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
<%
}
//-----------------------------
}
else
{
%>
<br>
Session timeout! Please <a href="../index.jsp">Login</a> to continue...
<%
}
}
catch(Exception e)
{
}
%>
<BR><BR><BR><BR><BR><BR><BR><BR>

</body>
</Html>