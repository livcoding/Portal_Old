<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, tietwebkiosk.*, java.text.SimpleDateFormat, java.util.*, java.io.*" pageEncoding="UTF-8"%>
<%

try{
	String qry="";
	DBHandler db=new DBHandler();
	OLTEncryption enc=new OLTEncryption();
	ResultSet rs=null;
	ResultSet rs2=null;
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String msg="";
	String ExamCode=request.getParameter("exam")==null?"":request.getParameter("exam");
	String mInst=session.getAttribute("InstituteCode").toString().trim();
	String result="",result2="";
    String qry2="",qry3="",qry4="", qry5="";

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}



	qry= "Select  Distinct F.SubjectID,S.SUBJECT||'-'||S.SUBJECTCODE SUBJECT " +
            "From  FACULTYSUBJECTTAGGING F,SubjectMaster S Where   F.INSTITUTECODE =S.INSTITUTECODE And " +
            "    F.SUBJECTID=S.SUBJECTID And     F.InstituteCode = '"+mInst+"' And    " +
            " F.ExamCode = '"+ExamCode+"' and F.EMPLOYEEID='"+mChkMemID+"'  Order By 2";
	
	
	rs2=db.getRowset(qry);
	while(rs2.next()) {
		result=result+rs2.getString("SubjectID")+"@"+rs2.getString("SUBJECT")+"$";
	}
	//result=result+"~"+result2;//+">"+TimeId;
      out.println(result);
	}
	catch(Exception e)
	{
		System.out.println("error in subject"+e);
	}
%>
