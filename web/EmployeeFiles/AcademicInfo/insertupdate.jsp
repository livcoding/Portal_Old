<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, tietwebkiosk.*, java.text.SimpleDateFormat, java.util.*, java.io.*" pageEncoding="UTF-8"%>
<%

try
{
	String qry="";
	DBHandler db=new DBHandler();
	OLTEncryption enc=new OLTEncryption();
    ResultSet rs=null;
	ResultSet rs2=null,rs1=null;
    String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String msg="";
	String ExamCode=request.getParameter("Exam")==null?"":request.getParameter("Exam");
	String Subject=request.getParameter("Subject")==null?"":request.getParameter("Subject");
	String Student=request.getParameter("Student")==null?"":request.getParameter("Student");
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
    String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
    String reason=request.getParameter("reason")==null?"":request.getParameter("reason");
    int days=Integer.parseInt(request.getParameter("days"));
   // System.out.print("@@@@Days"+days);
    int i=0,seqid=0;
    int status=0;

    String mInst=session.getAttribute("InstituteCode").toString().trim();
	String result="",result2="",qry1="",qryx="";
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


try{
                
             }catch(Exception e)
             {
            // System.out.print("Gyan"+e);
             }
			qry="select nvl(max(SEQID),0)+1 SEQID from ATTENDANCESPECIALAPPROVAL WHERE companycode = '"+mComp+"' AND institutecode = '"+mInst+"' AND" +
                " examcode = '"+ExamCode+"' AND subjectid = '"+Subject+"' AND studentid = '"+Student+"'";
			//out.print(qry);
            rs=db.getRowset(qry);
			 if(rs.next())
				 {
		 seqid=rs.getInt("SEQID")==0?0:rs.getInt("SEQID");


		qry1="SELECT 'Y',seqid sid FROM attendancespecialapproval WHERE companycode = '"+mComp+"' AND institutecode = '"+mInst+"' AND" +
                " examcode = '"+ExamCode+"' AND subjectid = '"+Subject+"' AND studentid = '"+Student+"' and  " +
                "  ((TO_DATE ('"+fromdate+"', 'dd-MM-yyyy') BETWEEN FROMPERIOD AND TOPERIOD ) OR (TO_DATE ('"+todate+"', 'dd-MM-yyyy')" +
                "BETWEEN FROMPERIOD AND TOPERIOD ) OR (FROMPERIOD between TO_DATE ('"+fromdate+"', 'dd-MM-yyyy') and " +
                "TO_DATE('"+todate+"', 'dd-MM-yyyy')) OR (TOPERIOD between TO_DATE ('"+fromdate+"', 'dd-MM-yyyy') and " +
                "TO_DATE('"+todate+"', 'dd-MM-yyyy'))) ";
			//out.print(qry1);
		rs1=db.getRowset(qry1);
		if(rs1.next())
		{seqid=rs1.getInt("sid")==0?0:rs1.getInt("sid");
		/*qry="update ATTENDANCESPECIALAPPROVAL set  FROMPERIOD=" +
                "to_date('"+fromdate.toString().trim()+"','dd-mm-yyyy')," +
                "TOPERIOD=to_date('"+todate.toString().trim()+"','dd-mm-yyyy')," +
                "NOOFDAYS='"+days+"',REASONFORAPPROVAL='"+reason+"' where " +
                "companycode = '"+mComp+"' AND institutecode = '"+mInst+"'" +
                " AND examcode = '"+ExamCode+"' AND subjectid = '"+Subject+"' " +
                "AND seqid='"+seqid+"' and  studentid = '"+Student+"'";*/
		//	out.print(qry);


         qry="delete from attendancespecialapproval WHERE companycode = '"+mComp+"' AND institutecode = '"+mInst+"' AND" +
                " examcode = '"+ExamCode+"' AND subjectid = '"+Subject+"' AND studentid = '"+Student+"' and  " +
                "  ((TO_DATE ('"+fromdate+"', 'dd-MM-yyyy') BETWEEN FROMPERIOD AND TOPERIOD ) OR (TO_DATE ('"+todate+"', 'dd-MM-yyyy')" +
                "BETWEEN FROMPERIOD AND TOPERIOD ) OR (FROMPERIOD between TO_DATE ('"+fromdate+"', 'dd-MM-yyyy') and " +
                "TO_DATE('"+todate+"', 'dd-MM-yyyy')) OR (TOPERIOD between TO_DATE ('"+fromdate+"', 'dd-MM-yyyy') and " +
                "TO_DATE('"+todate+"', 'dd-MM-yyyy')))";
			int h=db.insertRow(qry);
			if(h>0)
			{
            qryx="INSERT INTO ATTENDANCESPECIALAPPROVAL (COMPANYCODE, INSTITUTECODE, EXAMCODE, SUBJECTID, STUDENTID, FROMPERIOD, " +
                "TOPERIOD,NOOFDAYS,REASONFORAPPROVAL,SEQID)VALUES('"+mComp+"','"+mInst+"','"+ExamCode+"','"+Subject+"','"+Student+"'," +
                "to_date('"+fromdate+"','dd-mm-yyyy'),to_date('"+todate+"','dd-mm-yyyy'),'"+days+"','"+reason+"','"+seqid+"')";

              int q=db.insertRow(qryx);
			if(q>0)
			{
             status=1;
             msg="Record Update Sucessfully.";
            }
            }
        }
		else
			{
		qry="INSERT INTO ATTENDANCESPECIALAPPROVAL (COMPANYCODE, INSTITUTECODE, EXAMCODE, SUBJECTID," +
                " STUDENTID, FROMPERIOD, TOPERIOD,NOOFDAYS,REASONFORAPPROVAL,SEQID)VALUES('"+mComp+"','"+mInst+"','"+ExamCode+"'," +
                "'"+Subject+"','"+Student+"',to_date('"+fromdate+"','dd-mm-yyyy'),to_date('"+todate+"','dd-mm-yyyy'),'"+days+"'," +
                "'"+reason+"','"+seqid+"')";
			//out.print(qry);
			int n=db.insertRow(qry);
			if(n>0)
			{
                status=1;
			msg="Record Saved Sucessfully.";
		}
		else
			{
                status=0;
			msg="Error.";
			}
		}
       }
            StringBuffer br=new StringBuffer("");
            ////////////////////////////////
            ///////////////////////////////
            br.append(msg);
            br.append("<table bgcolor='#fce9c5' class='sort-table' id='table-1' bottommargin='0' rules='groups' topmargin='0' cellspacing='0' cellpadding='0' border='1' align='center' width='80%'><thead><tr bgcolor='#ff8c00'>");
            br.append("<td rowspan=2 nowrap Title='Sort on Name'><font color='White' size='2'><b>Student Name</b></font></td>");
            br.append("<td rowspan=2 nowrap Title=Sort on reason><font color=White size='2'><b>Exam Code</b></font></td>");
            br.append("<td rowspan=2 nowrap Title=Sort on Subject><font color=White size='2'><b>Subject Name</b></font></td>");
			br.append("<td rowspan=2 nowrap Title=Sort on from date><font color=White size='2'><b>From Period</b></font></td>");
			br.append("<td rowspan=2 nowrap Title=Sort on reason><font color=White size='2'><b>To Period</b></font></td>");
			br.append("<td rowspan=2 nowrap Title=Sort on reason><font color=White size='2'><b>No of Classes</b></font></td>");
			br.append("<td rowspan=2 nowrap Title=Sort on reason><font color=White size='2'><b>Reason</b></font></td></tr></thead");
            br.append("</tr></thead>");


      qry="SELECT DISTINCT b.seqid seqid,b.examcode examcode,nvl (TO_CHAR(b.fromperiod,'dd-mm-yyyy'),'-') " +
        "fromperiod,nvl (TO_CHAR(b.toperiod,'dd-mm-yyyy'),'-') toperiod, nvl(b.noofdays,0) noofdays," +
        " nvl(b.reasonforapproval,'N/A') reasonforapproval,S.STUDENTNAME,J.SUBJECT FROM " +
        " attendancespecialapproval b,StudentMaster S,SubjectMaster J,FACULTYSUBJECTTAGGING F Where B.STUDENTID=S.STUDENTID " +
        "And B.INSTITUTECODE=s.INSTITUTECODE And B.SUBJECTID=J.SUBJECTID And B.INSTITUTECODE=j.INSTITUTECODE" +
        " and b.examcode='"+ExamCode+"'and f.EMPLOYEEID='"+mChkMemID+"' and b.INSTITUTECODE='"+mInst+"' and  " +
        " B.INSTITUTECODE=f.INSTITUTECODE and b.companycode=f.companycode and b.examcode=f.examcode" +
        " and b.subjectid=f.subjectid order by SUBJECT,STUDENTNAME ";
			//out.print(qry);
			rs=db.getRowset(qry);
			while(rs.next())
					{
				
					br.append("<tr bgcolor=white>");
					br.append("<td nowrap>"+rs.getString("StudentName").trim()+"</td>");
					br.append("<td nowrap>"+rs.getString("EXAMCODE").trim()+"</td>");
                    br.append("<td nowrap>"+rs.getString("Subject").trim()+"</td>");
					br.append("<td nowrap>"+rs.getString("FROMPERIOD").trim()+"</td>");
					br.append("<td nowrap>"+rs.getString("TOPERIOD").trim()+"</td>");
					br.append("<td nowrap align='center'>"+rs.getString("NOOFDAYS").trim()+"</td>");
					br.append("<td nowrap>"+rs.getString("REASONFORAPPROVAL").trim()+"</td>");
					br.append("</tr>");
			}
		
                    br.append("</table>");
            ////////////////////////////
            ////////////////////////////
                out.print(br);

} // end of try
        catch(Exception e)
        {
            System.out.print("Error is "+e);
        }
%>
