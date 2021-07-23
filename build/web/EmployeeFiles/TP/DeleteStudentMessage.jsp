<%-- 
    Document   : DeleteStudentMessage
    Created on : Sep 3, 2014, 12:16:00 PM
    Author     : Gyanendra.Bhatt
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*;" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%try{
String msgContent=request.getParameter("msgContent")==null?"":request.getParameter("msgContent").trim();
//out.print(msgContent);
String qry="",action="";
ResultSet rs=null;
int i=0,j=0,k=0;
String MESSAGEID="",ACADEMICYEARCODE="",BRANCHCODE="",INSTITUTECODE="",PROGRAMCODE="";
DBHandler db=new DBHandler();
qry="  SELECT DISTINCT   NVL (MESSAGEDETAIL, '') MESSAGEDETAIL, NVL (MESSAGEID, '') msgid," +
        "nvl(ACADEMICYEARCODE,'') ACADEMICYEARCODE ,nvl(BRANCHCODE,'') BRANCHCODE,nvl(INSTITUTECODE,'') INSTITUTECODE," +
        " nvl( PROGRAMCODE,'') PROGRAMCODE    FROM TP#STUDENTMESSAGE  where MESSAGEID='"+msgContent+"'";
//out.print(qry);
rs=db.getRowset(qry);
while(rs.next())
{

MESSAGEID=msgContent;
ACADEMICYEARCODE=rs.getString("ACADEMICYEARCODE")==null?"":rs.getString("ACADEMICYEARCODE").trim();
BRANCHCODE=rs.getString("BRANCHCODE")==null?"":rs.getString("BRANCHCODE").trim();
INSTITUTECODE=rs.getString("INSTITUTECODE")==null?"":rs.getString("INSTITUTECODE").trim();
PROGRAMCODE=rs.getString("PROGRAMCODE")==null?"":rs.getString("PROGRAMCODE").trim();
qry="delete from tp#studentmessage A  where A.MESSAGEID='"+MESSAGEID+"' and A.ACADEMICYEARCODE='"+ACADEMICYEARCODE+"'" +
        " and A.BRANCHCODE='"+BRANCHCODE+"' and A.INSTITUTECODE='"+INSTITUTECODE+"' and A.PROGRAMCODE='"+PROGRAMCODE+"'";
//out.print(qry);
j=db.update(qry);
}



//out.print(j+"---"+k);
if(j>0)
{
response.sendRedirect("ForStudentMessage.jsp?deletemessage=Record Deleted successfully");
    }
}catch(Exception e)
    {
    System.out.print(e);
    }
%>