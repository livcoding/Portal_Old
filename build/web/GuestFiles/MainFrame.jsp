<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>  
<%  

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	MainFrame.JSP		[For Students]						           *
	' * Author:		Ashok Kumar Singh 							           *
	' * Date:		02nd May 2005	   *
	' * Version:		1.1									   *	
	' **********************************************************************************************************
*/
%>
<html>
   <frameset border=0 Rows = "12%,88%" FRAMEBORDER=0>
      <frame  border=0 src = "../CommonFiles/TopTitle.jsp"/>
      <frameset border=0 cols = "15%,85%" FRAMEBORDER=0>
          <frame  border=0 src ="FrameLeftStudent.jsp"/ >
          <frame border=0 Name="DetailSection" src ="../CommonFiles/About.htm" SCROLLING=AUTO/>
      </frameset>
   </frameset>
</html>