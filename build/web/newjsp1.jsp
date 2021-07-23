<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%-- 
    Document   : newjsp1
    Created on : 9 Nov, 2017, 2:20:36 PM
    Author     : VIVEK.SONI
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
<TITLE>####  [ Test Page] </TITLE>

</head>

   <body>
        <h1>Hello WorldPPddddd!</h1>

<%

try{
    DBHandler db=new DBHandler();
ResultSet rs=null;
String qry="";
qry="select * from COMPANYMASTER";
rs=db.getRowset(qry);
if(rs.next())
{
    %>
<td><b><font color="green"><%=rs.getString("COMPANYNAME")%></font></b></td>
<%}

}


catch (SQLException e) {
    e.printStackTrace();
  }


%>


    </body>
</html>
