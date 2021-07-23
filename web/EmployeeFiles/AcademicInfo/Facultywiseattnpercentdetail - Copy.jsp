<%--
    Document   : Facultywiseattnpercentdetail
    Created on : Sep 11, 2012, 12:20:30 PM
    Author     : Mohit.sharma
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        DBHandler db = new DBHandler();


        ResultSet rst = null;

        ResultSet rs1 = null,rs = null;

        String qry = "",mSUBJECT="", mSUBB = "", mTNOOFCLASS="",mSUBN = "", mLTP = "";
        String qryt = "";
        GlobalFunctions gb = new GlobalFunctions();
        //--------ADDED CODE------DATE-3/28/2012 @mohit sharma
        String mEXAMCODE = "", mSubjectcode="", mFLAG = "", mSubjID = "", DataSublist = "";
        String mInstCode = "";
        String mInst = "", mSubject = "", minst = "",qry1 ="";
        int count = 0, Flag = 0;
        if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        }else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }

%>
<HTML>
    <head>
        <TITLE>#### JIIT [Attendance PercentageWise BreakUp Detail]</TITLE>
  

  
   
        <script>
            if(window.history.forward(1) != null)
                window.history.forward(1);
        </script>
        <script type="text/javascript" src="../js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

    </head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

        <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
            <tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>
			
			Student Attendance Date wise Percentage wise Breakup Detail 
			</B></FONT>
                        <!-- <BR><img src="images/ornament.gif" width="474" height="11" alt="" /> -->
            </font></td></tr>
        </table>

        <%

            if (request.getParameter("INSTITUTE") == null) {
                mInstCode = "";
            } else {
                mInstCode = request.getParameter("INSTITUTE").toString().trim();
            }
            if (request.getParameter("LTP") == null) {
                mLTP = "";
            } else {
                mLTP = request.getParameter("LTP").toString().trim();
            }
            if (request.getParameter("FLAG") == null) {
                mFLAG = "";
            } else {
                mFLAG = request.getParameter("FLAG").toString().trim();
            }


         if (request.getParameter("TNOOFCLASS") == null) {
                mTNOOFCLASS = "";
            } else {
                mTNOOFCLASS = request.getParameter("TNOOFCLASS").toString().trim();
            }

            int iFLAG = java.lang.Integer.parseInt(mFLAG);

            if (request.getParameter("SUBJECTCODE") == null) {
                mSubjectcode = "";
            } else {
                mSubjectcode = request.getParameter("SUBJECTCODE").toString().trim();
            }

            String mPROG[] = {"ALL"};

            mPROG = request.getParameterValues("PROGRAMCODE");



                      try {
                          if (mPROG.equals("") || mPROG == null) {
                              mPROG[0] = "ALL";
                              mSubject = "ALL";
                          }
                          for (int i = 0; i < mPROG.length; i++) {
                              if (mSubject.equals("")) {
                                  mSubject = "" + mPROG[i] + "";
                                 } else {
                                  mSubject = mSubject + "," + mPROG[i] + "";
                                 }
                          }
                      } catch (Exception e) {
                          mSubject = "ALL";
                      }
                      if (mSubject.indexOf("ALL") > 0) {
                          mSubject = "ALL";
                      }


            if (request.getParameter("SUBJECT") == null) {
                          mSUBJECT = "";
                      } else {
                          mSUBJECT = request.getParameter("SUBJECT").toString().trim();
                      }

				String SUBCODE="",EMPID="";

            if (request.getParameter("SUBCODE") == null) {
                          SUBCODE = "";
                      } else {
                          SUBCODE = request.getParameter("SUBCODE").toString().trim();
                      }

                      if (request.getParameter("EXAMCODE") == null) {
                          mEXAMCODE = "";
                      } else {
                          mEXAMCODE = request.getParameter("EXAMCODE").toString().trim();
                      }

					  
                      if (request.getParameter("EXAMCODE") == null) {
                          mEXAMCODE = "";
                      } else {
                          mEXAMCODE = request.getParameter("EXAMCODE").toString().trim();
                      }

						 if (request.getParameter("EMPID") == null) {
                          EMPID = "";
                      } else {
                          EMPID = request.getParameter("EMPID").toString().trim();
                      }

					  

                      %>
        <br>
        <table align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1  border=1 >
                <thead>
                <tr bgcolor="#ff8c00">
                      <td><b><font color="white">Sr.no.</font></b></td>
                      <td align=center><b><font color="white">Subject (Code)</font></b></td>
  <td align=center><b><font color="white">SubSectionCode</font></b></td>
                           <td align=center><b><font color="white">Enrollment No.</font></b></td>
                           <td align=center><b><font color="white">Student Name</font></b></td>
              
                 <td align=center><b><font color="white">Attendance(%)-   <<%=mFLAG%></font></b></td>
                <td><b><font color="white">Entryby Faculty</font></b></td>
                       
              
               
                </thead>
                <tbody>
                      <%
String mDate1="";


if(request.getParameter("Date1")==null)
	mDate1="";
else
mDate1=request.getParameter("Date1");

                      //mTNOOFCLASS
try{

                      qry = "SELECT distinct SEMESTERTYPE, SECTIONBRANCH,subjectid, enrollmentno,subsectioncode,  studentid,ENTRYBYFACULTYID,ENTRYBYFACULTYNAME,studentname ,COUNT (*) noofclass    FROM v#studentattendance a  Where  a.LTP in ("+mLTP+") and a.ENTRYBYFACULTYID='"+EMPID+"'  and a.subsectioncode='"+SUBCODE+"' and a.subjectcode='"+mSubjectcode+"' AND NVL (a.present, 'N') = 'Y' and nvl(Studentdeactive,'N')='N'  and nvl(deactive,'N')='N'   and attendancetype in ('E','R')";
					  qry=qry+ "        AND TRUNC (a.attendancedate) BETWEEN TRUNC                                               (DECODE (TO_DATE ('', 'dd-mm-yyyy'),'', a.attendancedate, TO_DATE ('','dd-mm-yyyy' )   ) )  AND TRUNC (DECODE (TO_DATE ('"+mDate1+"',                                                                'dd-mm-yyyy'                                                               ),                                                       '', a.attendancedate,                                                       TO_DATE ('"+mDate1+"',                                                                'dd-mm-yyyy'                                                             )                                                      )                                              )";
                      if (!mInstCode.equals("ALL")) {
                      qry = qry + " and  a.institutecode='" + mInstCode + "' ";
                      }
                      if (!mEXAMCODE.equals("ALL")) {
                      qry = qry + "and  a.examcode='" + mEXAMCODE + "' ";
                      }
                      if (mSubject.equals("ALL")) {
                      qry = qry + "  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  ";
                      } else {
                      qry = qry + "  and a.programcode in (" + mSubject + ")   ";
                      }
                      qry = qry + " group by SEMESTERTYPE, SECTIONBRANCH,subjectid,  enrollmentno, studentid,ENTRYBYFACULTYID,ENTRYBYFACULTYNAME,studentname ,subsectioncode";
                      if(mFLAG.equals("80")){
                      qry = qry + " Having ((Count(*) * 100)/'"+mTNOOFCLASS+"')<80 ";
                      }else if(mFLAG.equals("70")){
                      qry = qry + " Having ((Count(*) * 100)/'"+mTNOOFCLASS+"')<70 ";
                      }
                      else if(mFLAG.equals("60")){
                      qry = qry + " Having ((Count(*) * 100)/'"+mTNOOFCLASS+"')<60 ";
                      }
                      else if(mFLAG.equals("50")){
                      qry = qry + " Having ((Count(*) * 100)/'"+mTNOOFCLASS+"')<50 ";
                      }
                      else if(mFLAG.equals("40")){
                      qry = qry + " Having ((Count(*) * 100)/'"+mTNOOFCLASS+"')<40 ";
                      }
                      else if(mFLAG.equals("30")){
                      qry = qry + " Having ((Count(*) * 100)/'"+mTNOOFCLASS+"')<30 ";
                      }
                      qry = qry + " order by ENTRYBYFACULTYNAME ";
                          rs1 = db.getRowset(qry);

out.print(qry);
                          while (rs1.next()) {
                          int nocd = Integer.parseInt(rs1.getString("noofclass"));
                        
						 int tnoc = 0;

						   qry1 = "SELECT distinct SEMESTERTYPE, SECTIONBRANCH,subjectid, enrollmentno,subsectioncode,  studentid,ENTRYBYFACULTYID,ENTRYBYFACULTYNAME,studentname ,COUNT (*) mTNOOFCLASS    FROM v#studentattendance a  Where a.studentid='"+rs1.getString("studentid")+"' and  a.LTP in ("+mLTP+") and a.ENTRYBYFACULTYID='"+EMPID+"'  and a.subsectioncode='"+SUBCODE+"' and a.subjectcode='"+mSubjectcode+"'  and nvl(Studentdeactive,'N')='N'  and nvl(deactive,'N')='N'   and attendancetype in ('E','R')";
					  qry1=qry1+ "        AND TRUNC (a.attendancedate) BETWEEN TRUNC                                               (DECODE (TO_DATE ('', 'dd-mm-yyyy'),'', a.attendancedate, TO_DATE ('','dd-mm-yyyy' )   ) )  AND TRUNC (DECODE (TO_DATE ('"+mDate1+"',                                                                'dd-mm-yyyy'                                                               ),                                                       '', a.attendancedate,                                                       TO_DATE ('"+mDate1+"',                                                                'dd-mm-yyyy'                                                             )                                                      )                                              )";
                      if (!mInstCode.equals("ALL")) {
                      qry1 = qry1 + " and  a.institutecode='" + mInstCode + "' ";
                      }
                      if (!mEXAMCODE.equals("ALL")) {
                      qry1 = qry1 + "and  a.examcode='" + mEXAMCODE + "' ";
                      }
                      if (mSubject.equals("ALL")) {
                      qry1 = qry1 + "  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  ";
                      } else {
                      qry1 = qry1 + "  and a.programcode in (" + mSubject + ")   ";
                      }
                      qry1 = qry1 + " group by SEMESTERTYPE, SECTIONBRANCH,subjectid,  enrollmentno, studentid,ENTRYBYFACULTYID,ENTRYBYFACULTYNAME,studentname ,subsectioncode";
					
						
						rs=db.getRowset(qry1);
						if(rs.next())
							  {
								  tnoc = rs.getInt("mTNOOFCLASS");

							
							  }
						  
						 
                          
						 	  int sper=0;
                          
						  sper=(((nocd)*100)/(tnoc));
                  
						  
		     	   if(sper<80)
			       {
//
//?EXAM=2012ODDSEM&CTYPE=R&SC=110050&LTP=L&SEC=ECE&SUBSEC=ECE1&SEMESTERTYPE=REG&mMemberID=00011200137&prevLFSTID=&mLFSTID=JIIT1202892
//DateWiseAttendanceStudentDetail			  
								  %>
							<tr><td><B><%=++count%></B></td>
							<td align=left><%=mSUBJECT%>(<%=mSubjectcode%>)</td>
							   <td nowrap align=left> <%=rs1.getString("subsectioncode")%></td>
							<td nowrap align=left> <%=rs1.getString("enrollmentno")%></td>
							<td nowrap align=left> 
							<a target="NEW" href="ViewDatewiseAttendanceDean.jsp?CTYPE=&EXAM=<%=mEXAMCODE%>&SC=<%=rs1.getString("subjectid")%>&LTP=<%=mLTP%>&SEC=<%=rs1.getString("SECTIONBRANCH")%>&SUBSEC=<%=rs1.getString("subsectioncode")%>&SEMESTERTYPE=<%=rs1.getString("SEMESTERTYPE")%>&mMemberID=<%=rs1.getString("studentid")%>&mMemberType='S'&mMemberCode=<%=rs1.getString("enrollmentno")%>&Date2=<%=mDate1%>">
							<%=rs1.getString("studentname")%>
							</a>
							</td>
							<td nowrap align=center><%=sper%></td>
							<td nowrap align=left ><%=rs1.getString("ENTRYBYFACULTYNAME")%></td>
							</tr>
							<%
					  }
                    }
}
catch(Exception e)
	{
	out.print(e);
	}

                    %>
                    </tbody>
                    </table>
                    <form><CENTER>
                    <input type="button" value=" Print this page "
                    onclick="window.print();return false;" /></CENTER>
                    </form>
        <script type="text/javascript">
            var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
        </script>
       


    </body>
</html>


