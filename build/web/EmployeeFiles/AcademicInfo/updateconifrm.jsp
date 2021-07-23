<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, tietwebkiosk.*, java.text.SimpleDateFormat, java.util.*, java.io.*" pageEncoding="UTF-8"%>
<%

try
{
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
    String qry2="",qry3="",qry4="", qry5="",mComp="";
if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

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

            qry=" SELECT 'Y' FROM attendancespecialapproval WHERE companycode = '"+mComp+"' AND institutecode = '"+mInst+"' AND" +
                " examcode = '"+ExamCode+"' AND subjectid = '"+Subject+"' AND studentid = '"+Student+"' and  " +
                " ((TO_DATE ('"+fromdate+"', 'dd-MM-yyyy') BETWEEN FROMPERIOD AND TOPERIOD ) OR (TO_DATE ('"+todate+"', 'dd-MM-yyyy')" +
                "BETWEEN FROMPERIOD AND TOPERIOD ) OR (FROMPERIOD between TO_DATE ('"+fromdate+"', 'dd-MM-yyyy') and " +
                "TO_DATE('"+todate+"', 'dd-MM-yyyy')) OR (TOPERIOD between TO_DATE ('"+fromdate+"', 'dd-MM-yyyy') and " +
                "TO_DATE('"+todate+"', 'dd-MM-yyyy')))  ";
         //  System.out.println(qry);
            try{
                rs=db.getRowset(qry);
                }catch(Exception e)
                    {
            System.out.print(e);
            }
            if(rs.next())
            {   
            out.println("Y");
            }
           else
            {
            out.println("N");
            }
   


	}
	catch(Exception e)
	{
		System.out.println("8888888888888"+e);
	}
%>
