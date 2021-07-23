<%-- 
    Document   : CounsellingFrame.jsp
    Created on : Feb 27, 2009, 4:57:55 PM
    Author     : ANKUR VERMA
--%>

<%@ page language="java" import="java.sql.*,jpalumni.*,encryption.*" %>
<%

String mInst="";

if(request.getParameter("Institute")==null)
     mInst="";
else
     mInst=request.getParameter("Institute").toString().trim();


if (session.getAttribute("LoginID")!=null)
{
  
%>


     
   <frameset border=0 Rows = "13.5%,86.5%" FrameBorder=0>
      <frame   noresize  scrolling=no  border=0 src = "Views/TopBar.jsp"/>
      <frameset border=0 cols = "16.5%,83.5%" FrameBorder=0>
          <frame noresize  scrolling=no  border=0 src ="FrameLeft.jsp?Institute=<%=mInst%>" />
          <frame noresize  scrolling=Auto   border=0 Name="DetailSection"
          src ="Views/ApplyOnLine.jsp?Institute=<%=mInst%>" SCROLLING=AUTO/>
      </frameset>
   </frameset>
     
   

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
