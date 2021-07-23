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

if (session.getAttribute("MemberCode")!=null && session.getAttribute("MemberType")!=null)
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
else
{
 %>
	<br>
	Session timeout! Please <a href="../index.jsp">Login</a> to continue...
 <%
}
%>