<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.regex.*,Com.Jiit.TnP.*;" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%-- 
    Document   : Info_StudentMessage
    Created on : Oct 7, 2014, 4:30:21 PM
    Author     : Gyanendra.Bhatt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%try{
DBHandler db = new DBHandler();
OLTEncryption enc=new OLTEncryption();
String insti="",qry="",academicyear="",result="",institues="",program="",branch="";
StringBuilder sb  =new StringBuilder();
ResultSet rs=null,rs1=null;
int i=0;


int sid=request.getParameter("sid")!=null?Integer.parseInt(request.getParameter("sid").toString()):0;

switch(sid){
case 1:
    institues=request.getParameter("instid");
    qry="SELECT  nvl(academicyear,'') academicyear  FROM (select  distinct academicyear from studentmaster where institutecode in ('"+institues.replace(",", "','")+"')  order by academicyear desc) where rownum<=10";
    sb.append("<option value='' name='all_year' id='all_year'>All</option>");
    rs=db.getRowset(qry);
while(rs.next())
{i++;
 academicyear=rs.getString(1)==null?"":rs.getString(1).toString().trim();
    sb.append("<option value='"+academicyear+"' name='acad_year' id='acad_year"+i+"'>"+academicyear+"</option>");

}
break;
case 2:
     institues=request.getParameter("instid");
     academicyear=request.getParameter("academicyear");
    qry="select distinct nvl(programcode,'') programcode  from studentmaster where   institutecode in ('"+institues.replace(",", "','")+"') and academicyear in ('"+academicyear.replace(",", "','")+"')  order by programcode ";
    sb.append("<option value='' name='all_prog' id='all_prog'>All</option>");
    rs=db.getRowset(qry);
while(rs.next())
{i++;
 program=rs.getString(1)==null?"":rs.getString(1).toString().trim();
    sb.append("<option value='"+program+"' name='prog' id='prog"+i+"'>"+program+"</option>");

}
break;

case 3:
     institues=request.getParameter("instid");
     academicyear=request.getParameter("academicyear");
     program=request.getParameter("program");
    qry="select distinct nvl(branchcode,'') branchcode from studentmaster where   institutecode in ('"+institues.replace(",", "','")+"') and academicyear in ('"+academicyear.replace(",", "','")+"')  and programcode in ('"+program.replace(",", "','")+"')   order by branchcode ";
    sb.append("<option value='' name='all_branch' id='all_branch'>All</option>");
    rs=db.getRowset(qry);
while(rs.next())
{i++;
 program=rs.getString(1)==null?"":rs.getString(1).toString().trim();
    sb.append("<option value='"+program+"' name='branch' id='branch"+i+"'>"+program+"</option>");

}
break;

}


out.print(sb.toString()+"@"+i);




}catch(Exception e)
{
System.out.print("@@@@"+e);
}%>