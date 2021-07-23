<%-- 
    Document   : Linked
    Created on : 1 Apr, 2019, 4:03:29 PM
    Author     : anoop.tiwari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JIIT</title>
    </head>
    <body>
        <%
            session.setAttribute("mStrInst", null);
            session.setAttribute("mStrAcademicYear",null);
            session.setAttribute("mStrProgramCode11",null);
            session.setAttribute("mStrBranchCode11",null);
            session.setAttribute("mStrExamCode11",null);
            session.setAttribute("mQuota11",null);
            session.setAttribute("inst",null);
            session.setAttribute("gender",null);
            session.setAttribute("deactive",null);
            session.setAttribute("regConfirmation",null);
        %>
        <img src="../Images/bullet4.gif">&nbsp;<a   title="Continue to Student Master (Bulk)" href="../CommonFiles/StudentMasterBulk.jsp" ><FONT face="Arial" color =black size=2 ><STRONG>Continue to Student Master (Bulk)</STRONG></font></a><br>
    </body>
</html>
