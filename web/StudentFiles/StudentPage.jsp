<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>  
<%  

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	MainFrame.JSP		[For Employee]						           *
	' * Author:		Ashok Kumar Singh 							           *
	' * Date:		20th Oct 2006
	' * Version:		1.0									   *	
	' **********************************************************************************************************
*/
String URL="";
String qry="";
try
{
if (session.getAttribute("MemberCode")!=null && session.getAttribute("MemberType")!=null)
{
OLTEncryption enc=new OLTEncryption();
String mInst="";
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
qry="Select '1' data From STUDENTRESULT A where A.institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"' and nvl(Fail,'N')='Y'";
qry=qry+" UNION Select '1' Data From NRSTUDENTFAILSUBJECTS A where Institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"'";

DBHandler db=new DBHandler();
ResultSet  rs=null;
rs=db.getRowset(qry);
URL="Academic/NRBackLogSubjectListFistScreen.jsp";

if (rs.next())
{
	response.sendRedirect(URL);  
}
else
{
%>
<html>
 
   <frameset border=0 Rows = "13.5%,86.5%" FrameBorder=0>
      <frame  noresize  scrolling=no border=0 src = "../CommonFiles/TopTitle.jsp"/>
      <frameset border=0 cols = "15.5%,84.5%" FrameBorder=0>
          <frame  noresize  scrolling=no border=0 src ="FrameLeftStudent.jsp"/ >
          <frame noresize  border=0 Name="DetailSection" src ="PersonalFiles/ShowAlertMessageSTUD.jsp" SCROLLING=AUTO/>
      </frameset>
   </frameset>
</html>
<%
}

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