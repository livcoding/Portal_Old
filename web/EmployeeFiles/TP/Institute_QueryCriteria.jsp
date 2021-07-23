<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.regex.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>

<%--
    Document   : Set_QueryCriteria
    Created on : Jul 12, 2014, 11:42:31 AM
    Author     : Gyanendra.Bhatt
--%>
<%try{
String result="";
ResultSet rs=null;
DBHandler db=new DBHandler();
String event=request.getParameter("event")==null?"":request.getParameter("event").trim();
String comp=request.getParameter("comp")==null?"":request.getParameter("comp").trim();

String   qry = " select distinct Institutecode from  TP#INSTITUTE where companycode='"+comp+"' and eventcode='"+event+"' ";
     rs = db.getRowset(qry);
    while(rs.next())
     {
    result=result+rs.getString("Institutecode")+"$";
    }
    
    out.println(result);
}catch(Exception e)
        {
        out.print(e);
        }
%>
