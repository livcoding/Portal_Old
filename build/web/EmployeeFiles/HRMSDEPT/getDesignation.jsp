
<%@ page language="java" contentType="text/html;charset=UTF-8" import="java.sql.*, tietwebkiosk.*,java.util.*, java.io.*" pageEncoding="UTF-8"%>
<%
String mDepartmentCode="";
String mMemberID="",mChkMemID="";



	   
try{
	String qry="";
	DBHandler db=new DBHandler();
	ResultSet rs=null;
	ResultSet rs2=null;
	
	String msg="";
    String vacancy=request.getParameter("vacancy")==null?"":request.getParameter("vacancy").trim();
	//String TimeId=request.getParameter("time")==null?"":request.getParameter("time").trim();


 String department=request.getParameter("departmentcode")==null?"":request.getParameter("departmentcode").trim();
	//System.out.print("@@@@@@@@@@@@@@@"+vacancy+"############"+department+"\n");
	String result="";
    String qry2="",qry3="",qry4="", qry5="";


 qry="SELECT DISTINCT nvl(DESIGNATIONCODE,' ')DESIGNATIONCODE, nvl(DESIGNATIOn,' ')DESIGNATIOn FROM DESIGNATIONMASTER          WHERE NVL (deactive, 'N') = 'N'            AND DESIGNATIONCODE IN (SELECT DESIGNATIONCODE                                     FROM HR#VACANCYDEPDESIGTAGGING                                     WHERE   DEPARTMENTCODE ='"+department+"'    and VACANCYCODE='"+vacancy+"'  )";
   
// System.out.print(qry);
	rs2=db.getRowset(qry);
	while(rs2.next()) {
		result=result+rs2.getString("DESIGNATIONCODE")+"@"+rs2.getString("DESIGNATIOn")+"~";
	}

	//result=result+">"+TimeId;
	
	out.println(result);
	
	}
catch(Exception e)
{
	System.out.println(e);
}
%>
