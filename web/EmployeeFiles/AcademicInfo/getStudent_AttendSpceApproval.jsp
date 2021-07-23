<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, tietwebkiosk.*, java.text.SimpleDateFormat, java.util.*, java.io.*" pageEncoding="UTF-8"%>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

try{
	String qry="";
	DBHandler db=new DBHandler();
	OLTEncryption enc=new OLTEncryption();
	ResultSet rs=null;
	ResultSet rs2=null,rsx=null;
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String msg="";
	String ExamCode=request.getParameter("exam").toString().trim()==null?"":request.getParameter("exam").toString().trim();
	String Subject=request.getParameter("subj").toString().trim()==null?"":request.getParameter("subj").toString().trim();
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




qry="Select Distinct StudentId,StudentName||' ( '||ENROLLMENTNO||' ) ' StudentName From V#StudentLTPDetail V  WHERE " +
        "V.institutecode = '"+mInst+"' AND V.examcode = '"+ExamCode+"' And v.SubjectId='"+Subject+"' and V.EMPLOYEEID='"+mChkMemID+"' " +
        "  ORDER BY 2";
		
	 //System.out.println("Mohit"+qry);
	rsx=db.getRowset(qry);
	//System.out.println("######################1111111111111111113#############################");
	while(rsx.next()) {
		//System.out.println("######################2222222222222222222#############################");
		result=result+rsx.getString(1)+"@"+rsx.getString(2)+"$";
		 
	}

 
	out.println(result);
	}
	catch(Exception e)
	{
		System.out.println("Error in student "+e);
	}
%>
