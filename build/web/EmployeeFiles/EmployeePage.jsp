<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>  
<%  

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	MainFrame.JSP		[For Students]						           *
	' * Author:		Ashok Kumar Singh 							           *
	' * Date:		20th Oct 2006
	' * Version:		1.0									   *	
	' ********************************************************************************************************** @

*/

  String mTitle = "TIET"; 

if (session.getAttribute("MemberCode")!=null && session.getAttribute("MemberType")!=null)
{
%>
<html>
<HEAD>
</HEAD>
   <frameset border=0 Rows = "15%,85%" FrameBorder=0 nowrap=true>
      <frame  noresize  scrolling=yes border=0 src = "../CommonFiles/TopTitle.jsp"/>
      <frameset border=0 cols = "14.00%,86.00%" FrameBorder=0>
  <frameset border=0 Rows = "11.8%,89.2%" FrameBorder=0>
				 <frame noresize  scrolling=no  border=0 src ="../CommonFiles/leftstart.jsp"/>
				  <frame noresize  scrolling=auto  border=0 src ="FrameLeftEmployee.jsp"/>
			</frameset>
          <frame noresize  scrolling=Auto   border=0 Name="DetailSection" src ="PersonalInfo/ShowAlertMessageEMP.jsp" SCROLLING=AUTO/>
      <frame src="UntitledFrame-1"></frameset>
   </frameset><noframes></noframes>
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