<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, tietwebkiosk.*, java.text.SimpleDateFormat, java.util.*, java.io.*" pageEncoding="UTF-8"%>
<%

try{
	String qry="";
	DBHandler db=new DBHandler();
	ResultSet rs=null;
	ResultSet rs2=null;
    String msg="";
	String ExamCode=request.getParameter("Exam")==null?"":request.getParameter("Exam");
	String Subject=request.getParameter("Subject")==null?"":request.getParameter("Subject");
	String Student=request.getParameter("Student")==null?"":request.getParameter("Student");
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
    String todate=request.getParameter("todate")==null?"":request.getParameter("todate");

int i=0;


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




/*qry="SELECT DISTINCT CLASSTIMEFROM FROM   v#studentattendance WHERE   examcode = '"+ExamCode+"' AND " +
        "subjectid = '"+Subject+"' AND fstid IN (SELECT   DISTINCT FSTID FROM   v#studentltpdetail WHERE " +
        "  examcode = '"+ExamCode+"' AND subjectid = '"+Subject+"') AND ATTENDANCEDATE BETWEEN " +
        "TO_DATE ('"+fromdate+"', 'dd-mm-yyyy') AND  TO_DATE ('"+todate+"', 'dd-mm-yyyy')AND " +
        "subsectioncode IN (select subsectioncode from studentmaster where studentid='"+Student+"' )";*/

qry=" SELECT   DISTINCT CLASSTIMEFROM  FROM   v#studentattendance T WHERE   t.examcode = '"+ExamCode+"' AND t.subjectid = '"+Subject+"'  "+
"AND EXISTS   (SELECT   DISTINCT FSTID    "+
"   FROM   v#studentltpdetail E     WHERE   e.examcode = '"+ExamCode+"' AND e.subjectid = '"+Subject+"' "+
"and e.fstid=t.fstid)    AND ATTENDANCEDATE BETWEEN TO_DATE ('"+fromdate+"', 'dd-mm-yyyy') "+
" AND  TO_DATE ('"+todate+"', 'dd-mm-yyyy')  AND subsectioncode IN  (SELECT   subsectioncode   "+
" FROM   v#studentltpdetail r   WHERE   r.studentid = '"+Student+"' "+
"and r.studentid=t.studentid) ";
//System.out.print(qry);
//out.print(qry);




rs=db.getRowset(qry);
	while(rs.next()) {
		i++;

    }
    out.println(i);	
	
	
	}
	catch(Exception e)
	{
		System.out.println("Error in days"+e);
	}
%>
