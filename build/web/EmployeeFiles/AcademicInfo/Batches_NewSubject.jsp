<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<%-- 
    Document   : Batches_NewSubject.jsp
    Created on : Feb 3, 2016, 11:45:45 AM
    Author     : Gyanendra.Bhatt
--%>
<%
String institute=request.getParameter("institute")==null?"":request.getParameter("institute").trim();
String examcode=request.getParameter("examcode")==null?"":request.getParameter("examcode").trim();
String department=request.getParameter("department")==null?"":request.getParameter("department").trim();
String subject=request.getParameter("subject")==null?"":request.getParameter("subject").trim();
String ltp=request.getParameter("ltp")==null?"":request.getParameter("ltp").trim();
String company=request.getParameter("company")==null?"":request.getParameter("company").trim();
String qry="",qry1="",mEmpname="",qryinn="";
DBHandler db=new DBHandler();
ResultSet rs=null,rs1=null;
StringBuilder sb=new StringBuilder();
//System.out.print(institute+"@@@@"+examcode+"$$$$"+department);

                                sb.append("<TABLE border='1' width=100% class=sort-table id=table-2>");
                                sb.append("<tr bgcolor='#ff8c00'>");
                                sb.append("<TD>&nbsp;</TD>");
								sb.append("<TD><B>Faculty</B></TD>");
								sb.append("<TD><B>Pro<br>Code</B></TD>");
								sb.append("<TD><B>Sec<br> Branch</B></TD>");
								sb.append("<TD><B>Sub<br>Sect</B></TD>");
								sb.append("<TD><B>Sem</B></TD>");
								sb.append("<TD><B>Count<br>(Stud)</B></TD>");
                                sb.append("</TR>");


qry="SELECT  a.programcode, a.sectionbranch, a.subsectioncode, a.semester,a.ACADEMICYEAR,a.semestertype,a.fstid, " +
                                        "a.companycode,a.employeeid facultyid,a.facultytype,a.ltp,a.basket,a.TAGGINGFOR," +
                                        "nvl(a.SUBJECTTYPE,' ')SUBJECTTYPE,nvl(a.NOOFCLASSINAWEEK,0)NOOFCLASSINAWEEK," +
                                        "nvl(a.DURATIONOFCLASS,0)DURATIONOFCLASS,a.subjectid,nvl(a.ELECTIVECODE,' ')ELECTIVECODE " +
                                        " FROM FACULTYSUBJECTTAGGING a WHERE   a.subjectid = '"+subject+"'   AND " +
                                        "a.examcode = '"+examcode+"'   AND a.ltp = '"+ltp+"' and a.InstituteCode='"+institute+"' " +
                                        "and a.semestertype='REG' and a.companycode='"+company+"' " +
                                        "order by programcode,sectionbranch,subsectioncode,semester";
rs=db.getRowset(qry);

while(rs.next())
								{
									String aa=rs.getString("fstid")+"!!!"+rs.getString("companycode")+"@@@"+rs.getString("facultyid")+"###"+rs.getString("facultytype")+"$$$"+rs.getString("ltp")+"^^^"+rs.getString("ACADEMICYEAR")+"&&&"+rs.getString("programcode")+"```"+rs.getString("sectionbranch")+"~~~"+rs.getString("semester")+">>>"+rs.getString("basket")+"???"+rs.getString("TAGGINGFOR")+"+++"+rs.getString("subsectioncode")+"___"+rs.getString("SUBJECTTYPE")+"---"+rs.getString("ELECTIVECODE")+"///"+rs.getString("NOOFCLASSINAWEEK")+"<<<"+rs.getString("DURATIONOFCLASS");

									qry1="select A.employeeid,A.employeename,A.employeecode from employeemaster A where " +
                                            "  A.employeeid='"+rs.getString("facultyid")+"' ";
									rs1=db.getRowset(qry1);
									if(rs1.next())
									{
										mEmpname=rs1.getString("employeename")+"-"+rs1.getString("employeecode");

									}
									else
									{
										mEmpname="--";
									}

                                        sb.append("<TR>");
                                        sb.append("<TD><INPUT TYPE='radio' NAME='regbatch' value='"+aa+"'></TD>");
										sb.append("<TD>"+mEmpname+" </TD>");
										sb.append("<TD><CENTER>"+rs.getString("programcode")+"</CENTER></TD>");
										sb.append("<TD><CENTER>"+rs.getString("sectionbranch")+"</CENTER></TD>");
										sb.append("<TD><CENTER>"+rs.getString("subsectioncode")+"</CENTER></TD>");
										sb.append("<TD><CENTER>"+rs.getString("semester")+"</CENTER></TD>");
										
										 qryinn="select count(distinct studentid)aa From V#Studentltpdetail where " +
                                                "institutecode='"+institute+"' and subjectid='"+subject+"' and semestertype='REG' " +
                                                "and nvl(deactive,'N')='N' and nvl(studentdeactive,'N')='N' and EXAMCODE =  '"+examcode+"'" +
                                                " and sectionbranch='"+rs.getString("sectionbranch")+"' and" +
                                                " programcode='"+rs.getString("programcode")+"' and " +
                                                "subsectioncode='"+rs.getString("subsectioncode")+"' " +
                                                "and semester= '"+rs.getString("semester")+"' and " +
                                                "ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' " +
                                                "and semestertype='"+rs.getString("semestertype")+"' " +
                                                "AND subsectioncode IS NOT NULL";
										//out.println(qryinn);
										ResultSet rsinn=db.getRowset(qryinn);
										if(rsinn.next()){
									
											sb.append("<TD><CENTER>"+rsinn.getString("aa")+"</CENTER></TD>");
										}else{
										sb.append("<TD>-</TD>");
										}
										sb.append("</TR>");
									
								}
                                out.print(sb.toString());
%>