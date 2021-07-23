<%-- 
    Document   : Reconverificationaction.jsp
    Created on : 30 Mar, 2017, 11:53:08 AM
    Author     : VIVEK.SONI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vefification Action</title>
    </head>
<%
String sms="";
%>
    <body bgcolor=#fce9c5>
        <br><br><br><br>
        <table border="1" align="center">
           <%
          sms=request.getParameter("action");
           %>
            <tbody>
                <tr>
                    <td><font color="black" size="4"><%=sms%></font></td>
                </tr>
            </tbody>
        </table>

    </body>
</html>
