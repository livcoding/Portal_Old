<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>  
<%  

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	AdminFramePage.JSP		[For Admin]						           *
	' * Author:		Vijay Kumar							           *
	' * Date:		9th Mar 2007
	' * Version:	1.0									   *	
	' **********************************************************************************************************

*/

String mTitle = "JIIT"; 

//if (session.getAttribute("MemberCode")!=null && session.getAttribute("MemberType")!=null)
if (session.getAttribute("BASELOGINID")!=null && session.getAttribute("BASELOGINTYPE")!=null)
{
%>
<html>
   <frameset border=0 Rows = "9%,91%" FrameBorder=0>
      <frame  noresize  scrolling=no border=0 Name="TopSection" src = "AdminRoleTitleHeading.jsp"/>
	      <frameset border=0 cols = "30%,70%" FrameBorder=0>
      	    <frame noresize  scrolling=Auto  border=0 src ="DeptwiseEmpRoleTitleInfo.jsp"/>
	          <frame noresize  scrolling=Auto   border=0 Name="DetSection" src ="IndvDeptEmpRoleTitleInfo.jsp" SCROLLING=AUTO/>
      	</frameset>
   </frameset>
</html>
<%
}
else
{
 %>
	<br>
	Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
 <%

}
%>