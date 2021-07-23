/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Iqac.Report;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
//import java.util.List;
import java.util.Map;
import tietwebkiosk.*;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;  
import javax.ws.rs.core.MediaType;
import java.io.FileOutputStream;
import java.io.StringReader;
import com.lowagie.text.*;
import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.pdf.*;
import java.io.ByteArrayOutputStream;
import java.io.File;

import java.io.ObjectOutputStream;
import java.util.*;
import java.util.ArrayList;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;

/**
 *
 * @author Gyanendra.Bhatt
 */
@Path("/IqacReportServices")
public class IqacReportServices
{
  String qry;
  String qry1;
  String qry2;
  ResultSet rs;
  ResultSet rs1;
  ResultSet rs2;
  ResultSet rs3;
  StringBuilder sb = new StringBuilder();
  DBHandler db = new DBHandler();
  HashSet hs = new HashSet();

  public IqacReportServices() {}

  @GET
  @Path("institute")
  @Produces({"application/json"})
  public String getInstitute() throws SQLException {
    qry = "select distinct nvl(a.INSTITUTECODE,'') institutecode,(select institutename from institutemaster where institutecode=a.institutecode) institute  from COMPANYINSTITUTETAGGING a,ap#PARENTFEEDBACKHEADER b where a.companycode=b.companyid and a.INSTITUTECODE=b.INSTITUTEID order by institute";


    rs = db.getRowset(qry);
    sb.append("\"ALL\":\"ALL\",");
    while (rs.next()) {
      sb.append("\"" + rs.getString("institutecode") + "\":\"" + rs.getString("institute") + "-" + rs.getString("institutecode") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("institute_Alumni")
  @Produces({"application/json"})
  public String getinstitute_Alumni() throws SQLException {
    qry = "select distinct nvl(a.INSTITUTECODE,'') institutecode,(select institutename from institutemaster where institutecode=a.institutecode) institute  from COMPANYINSTITUTETAGGING a,al#feedback b where a.INSTITUTECODE=b.INSTITUTECODE order by institute";


    rs = db.getRowset(qry);
    sb.append("\"ALL\":\"ALL\",");
    while (rs.next()) {
      sb.append("\"" + rs.getString("institutecode") + "\":\"" + rs.getString("institute") + "-" + rs.getString("institutecode") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("academicyear_Alumni")
  @Produces({"application/json"})
  public String getAcademic_Alumni(@QueryParam("institute") String institute) throws SQLException
  {
    institute = " and b.INSTITUTECODE='" + institute + "' ";
    qry = (" select distinct nvl(a.academicyearcode,'') academicyear from al#studentmaster a,al#feedback b where (a.institutecode||a.studentid)=b.studentid " + institute + " order by academicyear desc ");

    rs = db.getRowset(qry);
    sb.append("\"ALL\":\"ALL\",");
    while (rs.next()) {
      sb.append("\"" + rs.getString("academicyear") + "\":\"" + rs.getString("academicyear") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("program_Alumni")
  @Produces({"application/json"})
  public String getProgram_Alumni(@QueryParam("academicyear") String academicyear, @QueryParam("institute") String institute) throws SQLException
  {
    institute = " AND a.institutecode = '" + institute + "' ";
    academicyear = " AND s.academicyearcode = '" + academicyear + "'";
    qry = ("SELECT DISTINCT NVL (p.programcode, '') programcode,NVL (p.programname, '') programname FROM programmaster p, al#feedback a, al#studentmaster s WHERE a.studentid = s.institutecode||s.studentid  AND p.programcode = s.coursecode " + institute + "  " + academicyear + " ORDER BY programname");


    rs = db.getRowset(qry);
    sb.append("\"ALL\":\"ALL\",");
    while (rs.next()) {
      sb.append("\"" + rs.getString("PROGRAMCODE") + "\":\"" + rs.getString("programname") + "-" + rs.getString("PROGRAMCODE") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("branch_Alumni")
  @Produces({"application/json"})
  public String getbannch_Alumni(@QueryParam("academicyear") String academicyear, @QueryParam("institute") String institute, @QueryParam("program") String program) throws SQLException {
    academicyear = " AND s.academicyearcode = '" + academicyear + "' ";
    institute = " AND b.institutecode = '" + institute + "' ";
    program = " AND s.coursecode = '" + program + "' ";
    qry = (" SELECT DISTINCT NVL (branchcode, '') branchcode,NVL (branchdesc, '') branchdesc FROM branchmaster a WHERE branchcode IN (SELECT branchcode FROM al#studentmaster s, al#feedback b WHERE s.institutecode||s.studentid = b.studentid   " + program + ") ORDER BY branchdesc");
    rs = db.getRowset(qry);
    sb.append("\"ALL\":\"ALL\",");
    while (rs.next()) {
      sb.append("\"" + rs.getString("branchcode") + "\":\"" + rs.getString("branchdesc") + "-" + rs.getString("branchcode") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("{institute}/{academicyear}")
  @Produces({"application/json"})
  public String getProgram(@PathParam("institute") String institute, @PathParam("academicyear") String academicyear) throws SQLException {
    institute = " a.institutecode = '" + institute + "' and ";
    academicyear = " b.academicyear = '" + academicyear + "' AND  ";


    qry = ("SELECT DISTINCT NVL (a.programcode, '') programcode, NVL (a.programname, '') programname       FROM programmaster a, academicyearmaster b,AP#PARENTFEEDBACKHEADER c   WHERE  " + institute + " " + "  a.institutecode=c.instituteid  and b.academicyear=c.APACADEMICYEAR  and a.PROGRAMCODE=c.PROGRAMCODE  " + " AND a.institutecode = b.institutecode AND " + academicyear + "  NVL (a.deactive, 'N') = 'N'" + " ORDER BY programname");
    rs = db.getRowset(qry);
    sb.append("\"ALL\":\"ALL\",");
    while (rs.next()) {
      sb.append("\"" + rs.getString("programcode") + "\":\"" + rs.getString("programname") + "-" + rs.getString("programcode") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("{institute}/{programcode}/{academicyear}")
  @Produces({"application/json"})
  public String getBranch(@PathParam("institute") String institute, @PathParam("programcode") String program, @PathParam("academicyear") String academic) throws SQLException {
    institute = " a.institutecode = '" + institute + "' and ";
    academic = " b.academicyear = '" + academic + "' AND  ";
    program = " a.programcode = '" + program + "' AND  ";

    qry = (" SELECT NVL (a.branchcode, '') branchcode, NVL (a.branchdesc, '') branchdesc FROM branchmaster a,academicyearmaster b ,ap#parentfeedbackheADER C,studentmaster s WHERE " + institute + " " + program + " " + " a.INSTITUTECODE=b.INSTITUTECODE and " + academic + "  A.PROGRAMCODE=C.PROGRAMCODE AND B.ACADEMICYEAR=C.APACADEMICYEAR AND nvl(a.deactive,'N')='N'  and s.studentid=c.APSTUDENTID  and s.BRANCHCODE=a.BRANCHCODE order by branchdesc");

    rs = db.getRowset(qry);
    sb.append("\"ALL\":\"ALL\",");
    while (rs.next()) {
      sb.append("\"" + rs.getString("branchcode") + "\":\"" + rs.getString("Branchdesc") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("{institute}/{programcode}/{branch}/{academicyear}")
  @Produces({"application/json"})
  public String getStudent(@PathParam("institute") String institute, @PathParam("programcode") String program, @PathParam("branch") String branch, @PathParam("academicyear") String academicyear) throws SQLException {
    qry = (" SELECT NVL (a.studentid, '') studentid,NVL (a.enrollmentno, '') || '-' || NVL (a.studentname, '') student FROM studentmaster a, AP#PARENTFEEDBACKHEADER b WHERE a.institutecode='" + institute + "' and a.programcode='" + program + "'  and a.branchcode='" + branch + "' and a.academicyear='" + academicyear + "' and" + " a.INSTITUTECODE=b.INSTITUTEID and a.studentid=b.APSTUDENTID and a.ACADEMICYEAR=b.APACADEMICYEAR and nvl(a.deactive,'N')='N' order by studentname");


    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("studentid") + "\":\"" + rs.getString("Student") + "\",");
    }
    if (sb.toString().equals("")) {
      sb.append("\"There is no student\":\"There is no student\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("academicyear")
  @Produces({"application/json"})
  public String getAcademicyear(@QueryParam("institute") String institute) throws SQLException {
    institute = "a.INSTITUTECODE='" + institute + "'and ";

    qry = ("SELECT DISTINCT nvl(a.academicyear,'') academicyear FROM academicyearmaster a,ap#parentfeedbackheader b WHERE " + institute + "  a.institutecode=b.instituteid and NVL (a.deactive, 'N') = 'N' " + "ORDER BY academicyear DESC ");


    rs = db.getRowset(qry);
    sb.append("\"ALL\":\"ALL\",");
    while (rs.next()) {
      sb.append("\"" + rs.getString("academicyear") + "\":\"" + rs.getString("academicyear") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("parentreport")
  public String getParentReport(@QueryParam("institute") String institute, @QueryParam("program") String program, @QueryParam("branch") String branch, @QueryParam("acadyear") String acadyear, @QueryParam("studentid") String studentid) throws SQLException {
    String rating = "";
    String parenthead = "";
    String currentdate = "";
    String transId = "";
    String qryx = "";
    int i = 0;
    int j = 0;
    ResultSet rsx = null;
    qry = "select to_char(sysdate,'dd-mm-yyyy') currentdate from dual";
    rs = db.getRowset(qry);
    if (rs.next()) {
      currentdate = rs.getString("currentdate");
    }

    qry = ("select distinct (select nvl(studentname,'') studentname  from studentmaster s where s.studentid=a.apstudentid) studentname, (select nvl(enrollmentno,'') enrollmentno  from studentmaster s where s.studentid=a.apstudentid) enrollmentno, nvl(a.APACADEMICYEAR,'') academicyear from AP#PARENTFEEDBACKHEADER a,AP#PARENTFEEDBACKDETAIL b  where a.APSTUDENTID='" + studentid + "' and a.COMPANYID=b.COMPANYID and a.INSTITUTEID=b.INSTITUTEID and " + " a.transactionid=b.TRANSACTIONID and APACADEMICYEAR='" + acadyear + "' and a.PROGRAMCODE='" + program + "' and " + " a.instituteid='" + institute + "'");
    rs = db.getRowset(qry);
    if (rs.next()) {
      sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
      sb.append("<table id='reporttable' style='z-index:5%'>");
      sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-PSA-4A<br>Frequency-Every Semester Jan/July<br>Date-" + currentdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br></font></td><td></td></tr>");
      sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='2' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Stakeholder Relationship<br>Parents Feedback Report(StudentWise)</u><br><br></font></td><td></td></tr>");
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Name of the Ward(Optional) : " + rs.getString("studentname") + "</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Program Enrollment No.(Optional) : " + rs.getString("enrollmentno") + "</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Year Of Admission : " + rs.getString("academicyear") + "</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");

      qryx = " SELECT distinct nvl(a.transactionid,'') transid  FROM ap#parentfeedbackheader a, ap#parentfeedbackdetail b,studentmaster  c  WHERE a.companyid = b.companyid   AND a.instituteid = b.instituteid   AND a.transactionid = b.transactionid   AND apacademicyear = '" + acadyear + "'   AND a.programcode = '" + program + "'   AND a.instituteid = '" + institute + "'   and" + " a.INSTITUTEID=c.INSTITUTECODE   and a.programcode=c.PROGRAMCODE      and c.studentid=a.apstudentid  and c.branchcode='" + branch + "' and c.studentid='" + studentid + "' ";
      rsx = db.getRowset(qryx);
      while (rsx.next()) {
        transId = transId + "'" + rsx.getString("transid") + "',";
      }
      if (!transId.equals("")) {
        transId = transId.substring(0, transId.length() - 1);
      } else {
        transId = null;
      }
      qry = "SELECT  NVL (c.questionid, '') questionid,NVL (c.questionbody, '') questionbody,NVL (r.subjective, 'N') subjective,nvl(h.parentheadid,'') parentheadid  FROM ap#shquestionmaster c, ap#shratingmaster r,AP#SHQUESTIONHEAD h WHERE c.componenttype = 'R' and c.FEEDBACKID=h.FEEDBACKID and c.headid=h.HEADID   and c.componenttype=h.COMPONENTTYPE  AND c.feedbackid = r.feedbackid  AND c.ratingid = r.ratingid and c.examcode = r.examcode and  c.examcode=h.examcode  ORDER BY c.seqid";
      rs1 = db.getRowset(qry);
      while (rs1.next()) {
        i++;
        parenthead = rs1.getString("parentheadid") == null ? "" : rs1.getString("parentheadid").trim();
        qry1 = ("SELECT DISTINCT nvl(r.ratingdesc,'') Ansprint  FROM ap#shratingdetail r, ap#parentfeedbackdetail b WHERE   r.feedbackid = b.apfeedbackid(+)  and  r.rating = b.apfeedbackrating(+)   AND b.apfeedbackitemid = '" + rs1.getString("questionid") + "' " + "  AND b.APFEEDBACKRATINGID =r.ratingid and b.transactionid in(" + transId + ") union all SELECT DISTINCT nvl(b.APFEEDBACKUSERREMARKS,'') ansPrint  FROM " + " ap#shratingdetail r, ap#parentfeedbackdetail b WHERE  r.feedbackid = b.apfeedbackid(+)   AND   " + " b.apfeedbackitemid = '" + rs1.getString("questionid") + "' and b.transactionid in(" + transId + ") AND " + "b.APFEEDBACKRATINGID =r.ratingid and b.instituteid=r.institutecode order by ansprint");
        rs2 = db.getRowset(qry1);
        if (rs2.next()) {
          rating = rs2.getString("Ansprint") == null ? " " : rs2.getString("Ansprint").trim();
        } else {
          rating = "";
        }
        if (!parenthead.equals("")) {
          i--;
          j++;
        } else {
          j = 0;
        }
        sb.append("<tr><td style='text-align:left;width:25%;height:10%;' colspan='2'  ><font size='2'>" + i + " - " + (j == 0 ? "" : Integer.valueOf(j)) + " : " + rs1.getString("questionbody") + " - " + rating + "</font></td></tr>");
      }
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
      sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
    }
    else {
      sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
    }

    return sb.toString();
  }

  @GET
  @Path("parentreportBranchwise")
  public String getParentReportBranchwise(@QueryParam("institute") String institute, @QueryParam("program") String program, @QueryParam("branch") String branch, @QueryParam("acadyear") String acadyear) throws SQLException
  {
    String rating = "";
    String parenthead = "";
    String currentdate = "";
    String transId = "";
    String qryx = "";
    String totalcount = "";
    String ratingdetail = "";
    String nowrap = "";
    String ratingcount = "";
    ResultSet rsx = null;
    int i = 0;
    int j = 0;
    int totalCount = 0;
    String acadyear1 = acadyear;
    String ratingid = "";
    String program1 = program;
    String institute1 = institute;
    String branch1 = branch;
    acadyear1 = acadyear;
    String program3 = program;
    String institute3 = institute;
    String branch3 = branch;
    String acadyear3 = acadyear;
    acadyear = " and apacademicyear = '" + acadyear + "'  ";
    program = " AND a.programcode = '" + program + "'  ";
    institute = "AND a.instituteid = '" + institute + "'";

    branch = "and s.branchcode='" + branch + "' ";
    qry = "select to_char(sysdate,'dd-mm-yyyy') currentdate from dual";
    rs = db.getRowset(qry);
    if (rs.next()) {
      currentdate = rs.getString("currentdate");
    }

    qry = ("SELECT count(distinct(SELECT NVL (enrollmentno, '') enrollmentno FROM studentmaster s WHERE s.studentid = a.apstudentid " + branch + ")) totalcount FROM ap#parentfeedbackheader a," + " ap#parentfeedbackdetail b WHERE a.companyid = b.companyid AND a.instituteid = b.instituteid AND " + " a.transactionid = b.transactionid  " + acadyear + " " + program + " " + institute + "");
    rs = db.getRowset(qry);
    if (rs.next()) {
      totalcount = rs.getString("totalcount");
      totalCount = Integer.parseInt(totalcount);
    }
    if (totalCount > 0) {
      branch = branch.equals("") ? "All" : branch;
      program = program.equals("") ? "All" : program;
      acadyear = acadyear.equals("") ? "All" : acadyear;

      if (!branch.equals("All")) {
        qry = ("select BRANCHDESC from branchmaster where branchcode='" + branch1 + "'");
        rsx = db.getRowset(qry);
        if (rsx.next()) {
          branch1 = rsx.getString("BRANCHDESC") == null ? "" : rsx.getString("BRANCHDESC").trim();
        }
      }
      if (!program.equals("All")) {
        qry = ("select programname from programmaster where programcode='" + program1 + "'");
        rsx = db.getRowset(qry);
        if (rsx.next()) {
          program1 = rsx.getString("programname") == null ? "" : rsx.getString("programname").trim();
        }
      }
      sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
      sb.append("<table id='reporttable' style='z-index:5%' width='100%'>");
      sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-PSA-4A<br>Frequency-Every Semester Jan/July<br>Date-" + currentdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br></font></td><td></td></tr>");
      sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='2' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Stakeholder Relationship<br>Parents Feedback Report(Branchwise)</u><br><br></font></td><td></td></tr>");
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Branch : " + branch1 + "</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Program  : " + program1 + "</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Year Of Admission : " + acadyear1 + "</font></td><td style='text-align:right;width:75%;' nowrap><font size='2' ><font size='2' >Total Feedback : " + rs.getString("totalcount") + "</font> </td></tr>");
      branch = branch.equals("All") ? "" : branch;
      program = program.equals("All") ? "" : program;
      acadyear = acadyear.equals("All") ? "" : acadyear;
      qryx = " SELECT distinct nvl(a.transactionid,'') transid  FROM ap#parentfeedbackheader a, ap#parentfeedbackdetail b,studentmaster  s  WHERE a.companyid = b.companyid   AND a.instituteid = b.instituteid   AND a.transactionid = b.transactionid    " + acadyear + " " + program + " " + " and a.INSTITUTEID=s.INSTITUTECODE   and a.programcode=s.PROGRAMCODE   " + branch + "     and s.studentid=a.apstudentid  " + institute + "";
      rsx = db.getRowset(qryx);
      while (rsx.next()) {
        transId = transId + "'" + rsx.getString("transid") + "',";
      }
      if (!transId.equals("")) {
        transId = transId.substring(0, transId.length() - 1);
      } else {
        transId = null;
      }
      if (branch3.equals("ALL")) {
        branch3 = "";
      }
      if (program3.equals("ALL")) {
        program3 = "";
      }
      if (acadyear3.equals("ALL")) {
        acadyear3 = "";
      }

      qry = "SELECT  NVL (c.questionid, '') questionid,NVL (c.questionbody, '') questionbody, nvl (r.ratingid,'') ratingid,NVL (r.subjective, 'N') subjective,nvl(h.parentheadid,'') parentheadid  FROM ap#shquestionmaster c, ap#shratingmaster r,AP#SHQUESTIONHEAD h WHERE c.componenttype = 'R' and c.FEEDBACKID=h.FEEDBACKID and c.headid=h.HEADID and c.examcode=h.examcode and c.examcode=r.examcode  and c.componenttype=h.COMPONENTTYPE  AND c.feedbackid = r.feedbackid  AND c.ratingid = r.ratingid ORDER BY c.seqid";
      rs1 = db.getRowset(qry);
      for (; rs1.next();
          ratingcount = "") {
        i++;
        ratingid = rs1.getString("ratingid");
        parenthead = rs1.getString("parentheadid") == null ? "" : rs1.getString("parentheadid").trim();
        if (rs1.getString("subjective").trim().equals("Y")) {
          qry1 = (" SELECT DISTINCT nvl(b.APFEEDBACKUSERREMARKS,'') ansPrint  FROM  ap#shratingdetail r, ap#parentfeedbackdetail b WHERE  r.feedbackid = b.apfeedbackid(+)   AND    b.apfeedbackitemid = '" + rs1.getString("questionid") + "' AND b.APFEEDBACKRATINGID =r.ratingid " + "and b.transactionid in(" + transId + ") and r.institutecode=b.instituteid ");
          rs2 = db.getRowset(qry1);
          ArrayList<String> ratinglist = new ArrayList();
          while (rs2.next()) {
            ratinglist.add(rs2.getString("Ansprint") == null ? "" : rs2.getString("Ansprint").trim());
          }
          for (int k = 0; k <= ratinglist.size() - 1; k++) {
            ratingdetail = "" + ratingdetail + "<br>Ans" + k + ":" + (String)ratinglist.get(k);
          }

          nowrap = "";
        }
        else
        {
          qry1 = ("SELECT NVL (RATINGDESC, '') RATINGDESC,  COUNT (APFEEDBACKRATINGID) ansPrint,  b.seqid FROM ap#parentfeedbackdetail a, ap#shratingdetail b WHERE a.apfeedbackratingid(+) = b.ratingid  AND a.APFEEDBACKRATING(+) = b.RATING  AND a.apfeedbackid(+) = b.feedbackid  AND a.apfeedbackitemid(+) = 'QUS00001' and a.transactionid in (" + transId + ") AND a.apfeedbackratingid(+) = '" + rs1.getString("ratingid") + "'  AND a.instituteid(+) = b.institutecode " + "AND b.RatingId = '" + rs1.getString("ratingid") + "'  AND a.instituteid(+)='" + institute3 + "' and a.instituteid(+) = b.institutecode and b.examcode in(select x.examcode " + "from studentregistration x  where x.Companycode = b.companycode and   x.institutecode = b.institutecode  and   x.examcode = b.examcode and x.academicyear =  '" + acadyear3 + "' " + "AND x.programcode = '" + program3 + "' and   x.SectionBranch = '" + branch3 + "' and   x.semester = 1) GROUP BY RATINGDESC, seqid, seqid ORDER BY b.Seqid desc ");
          rs2 = db.getRowset(qry1);
          while (rs2.next()) {
            ratingdetail = ratingdetail + "<td nowrap><font size='2'>" + rs2.getString("ratingdesc").trim() + "</font></td>";
            ratingcount = ratingcount + "<td nowrap><font size='2'>" + rs2.getString("ansprint").trim() + "</font></td>";
          }


          ratingdetail = "<table width='20%' border='1' bordercolor='black'><tr>" + ratingdetail + "</tr><tr>" + ratingcount + "</tr></table>";
          nowrap = "nowrap";
        }
        if (!parenthead.equals("")) {
          i--;
          j++;
        } else {
          j = 0;
        }
        sb.append("<tr><td style='text-align:left;width:25%;height:10%;'   colspan='2'><font size='2'>" + i + "-" + (j == 0 ? "" : Integer.valueOf(j)) + ":" + rs1.getString("questionbody") + "-" + ratingdetail + "</font></td></tr>");
        ratingdetail = "";
      }
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
      sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
    }
    else {
      sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
    }

    return sb.toString();
  }

  @GET
  @Path("alumnifeedback")
  public String getAlumniReport(@QueryParam("institute") String institute, @QueryParam("program") String program, @QueryParam("branch") String branch, @QueryParam("acadyear") String acadyear) throws SQLException {
    String rating = "";
    String parenthead = "";
    String currentdate = "";
    String ratingcount = "";
    String studentid = "";
    String qryx = "";
    String totalcount = "";
    String ratingdetail = "";
    String nowrap = "";
    ResultSet rsx = null;
    int i = 0;
    int j = 0;
    int totalCount = 0;
    qry = "select to_char(sysdate,'dd-mm-yyyy') currentdate from dual";
    rs = db.getRowset(qry);
    if (rs.next()) {
      currentdate = rs.getString("currentdate");
    }
    String branch1 = " AND s.branchcode = '" + branch + "' ";
    String program1 = " and s.programcode='" + program + "' ";
    String acadyear1 = " and s.academicyear='" + acadyear + "' ";
    String institute1 = " AND a.INSTITUTECODE = '" + institute + "' ";
    qry = ("SELECT COUNT (DISTINCT (SELECT NVL (enrollmentno, '') enrollmentno FROM studentmaster s  WHERE s.institutecode||s.studentid = a.studentid " + branch1 + " " + program1 + " " + " " + acadyear1 + ")) totalcount  FROM al#feedback a, al#feedbackdetail b WHERE a.studentid = b.studentid  " + " and a.FEEDBACKID=b.feedbackid   AND a.INSTITUTECODE = b.INSTITUTECODE   " + institute1 + " ");
    rs = db.getRowset(qry);
    if (rs.next()) {
      totalcount = rs.getString("totalcount");
      totalCount = Integer.parseInt(totalcount);
    }
    if (totalCount > 0) {
      sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
      sb.append("<table id='reporttable' style='z-index:5%' width='100%'>");
      sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-PSA-4A<br>Frequency-Every Semester Jan/July<br>Date-" + currentdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br></font></td><td></td></tr>");
      sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='2' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Stakeholder Relationship<br>Alumni Feedback Report(Branchwise)</u><br><br></font></td><td></td></tr>");
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Branch : " + branch + "</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Program  : " + program + "</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Year Of Admission : " + acadyear + "</font></td><td style='text-align:right;width:75%;' nowrap><font size='2' ><font size='2' >Total Feedback : " + rs.getString("totalcount") + "</font> </td></tr>");

      qryx = " SELECT DISTINCT NVL (a.studentid, '') studentid FROM al#feedback a,al#feedbackdetail b,studentmaster s WHERE  a.institutecode = b.institutecode and a.feedbackid=b.feedbackid     and a.studentid=s.institutecode||s.studentid AND a.studentid = b.studentid  " + acadyear1 + "  AND s.institutecode = 'JIIT' " + branch1 + " " + " " + program1 + " and a.institutecode=s.institutecode ";
      rsx = db.getRowset(qryx);
      while (rsx.next()) {
        studentid = studentid + "'" + rsx.getString("studentid") + "',";
      }
      if (!studentid.equals("")) {
        studentid = studentid.substring(0, studentid.length() - 1);
      } else {
        studentid = null;
      }
      qry = " SELECT   NVL (c.questionid, '') questionid, NVL (c.questionbody, '') questionbody,  NVL (r.ratingid, '') ratingid,NVL (r.subjective, 'N') subjective,NVL (h.parentheadid, '') parentheadid    FROM al#questionmaster c, al#ratingmaster r, al#questionhead h   WHERE c.institutecode = 'JIIT'   and c.institutecode=h.INSTITUTECODE    AND c.feedbackid = h.feedbackid     AND c.headid = h.headid      AND c.feedbackid = r.feedbackid     AND c.ratingid = r.ratingid     and c.institutecode=r.institutecode    ORDER BY c.seqid ";
      rs1 = db.getRowset(qry);
      for (; rs1.next();
          ratingcount = "") {
        i++;
        parenthead = rs1.getString("parentheadid") == null ? "" : rs1.getString("parentheadid").trim();

        if (rs1.getString("subjective").trim().equals("Y")) {
          qry1 = (" SELECT DISTINCT NVL (b.subjectiveanswer, '') ansprint FROM al#ratingdetail r, al#feedbackdetail b ,al#questionmaster c  WHERE r.feedbackid = b.feedbackid(+)     AND b.questionid = '" + rs1.getString("questionid") + "' AND b.studentid IN (" + studentid + ") " + " and b.institutecode='JIIT' and b.institutecode=c.institutecode and   b.institutecode=r.institutecode and b.feedbackid=c.FEEDBACKID and b.questionid=c.questionid and r.feedbackid=c.FEEDBACKID and r.ratingid=c.ratingid  and b.HEADId=c.headid ");


          rs2 = db.getRowset(qry1);
          ArrayList<String> ratinglist = new ArrayList();
          while (rs2.next()) {
            ratinglist.add(rs2.getString("Ansprint") == null ? "" : rs2.getString("Ansprint").trim());
          }
          for (int k = 0; k <= ratinglist.size() - 1; k++) {
            ratingdetail = "" + ratingdetail + "<br>Ans" + k + ":" + (String)ratinglist.get(k);
          }

          nowrap = "";
        } else {
          qry1 = ("SELECT   ratingdesc , COUNT (b.ratingid) ansprint FROM al#feedbackdetail a, al#ratingdetail b ,al#questionmaster c  WHERE a.feedbackid = b.feedbackid(+) AND a.evaluationvalue = b.rating  AND a.studentid IN  (" + studentid + " )      AND a.institutecode = 'JIIT'  and a.questionid=c.QUESTIONID " + "and b.ratingid=c.ratingid and a.headid=c.headid  and a.questionid='" + rs1.getString("questionid") + "' and a.institutecode=b.institutecode and a.institutecode=c.institutecode GROUP BY ratingdesc ");




          rs2 = db.getRowset(qry1);
          while (rs2.next()) {
            ratingdetail = ratingdetail + "<td nowrap><font size='2'>" + rs2.getString("ratingdesc").trim() + "</font></td>";
            ratingcount = ratingcount + "<td nowrap><font size='2'>" + rs2.getString("ansprint").trim() + "</font></td>";
          }


          ratingdetail = "<table width='40%' border='1' bordercolor='black'><tr>" + ratingdetail + "</tr><tr>" + ratingcount + "</tr></table>";
          nowrap = "nowrap";
        }

        if (!parenthead.equals("")) {
          i--;
          j++;
        } else {
          j = 0;
        }
        sb.append("<tr><td style='text-align:left;width:100%;height:10%;' " + nowrap + "   colspan='2'><font size='2'>" + i + "-" + (j == 0 ? "" : Integer.valueOf(j)) + ":" + rs1.getString("questionbody") + "-" + ratingdetail + "</font></td></tr>");
        ratingdetail = "";
      }
      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
      sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
    }
    else {
      sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
    }

    return sb.toString();
  }

  @GET
  @Path("examcode")
  @Produces({"application/json"})
  public String getExamcode(@QueryParam("institute") String institute) throws SQLException
  {
    qry = (" select distinct (select exam.examdEscription from exammaster exam where exam.examcode=apf.examcode AND EXAM.institutecode = 'JIIT') examdiscrip, nvl(apf.examcode,'') examcode  from AP#facultyfeedback apf  where apf.institutecode = '" + institute + "' ");

    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("examcode") + "\":\"" + rs.getString("examdiscrip") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("faculty")
  @Produces({"application/json"})
  public String getFaculty(@QueryParam("institute") String institute, @QueryParam("company") String company, @QueryParam("examcode") String examcode) throws SQLException {
    qry = ("select nvl(employeename||'-'||employeecode,'') employee,nvl(employeeid,'') employeeid from employeemaster where employeeid in( select distinct a.employeeid  from facultysubjecttagging a,ap#facultyfeedback b where a.examcode = '" + examcode + "' AND a.institutecode = '" + institute + "' AND a.companycode ='" + company + "' and a.LTP='L' and a.fstid=b.fstid) ");


    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("employeeid") + "\":\"" + rs.getString("employee") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("academicyearfor_EmpandExamcode")
  public String getAcadmicYear_EmpandExamcode(@QueryParam("institute") String institute, @QueryParam("company") String company, @QueryParam("examcode") String examcode, @QueryParam("faculty") String faculty) throws SQLException {
    qry = (" select distinct nvl(academicyear,'') academicyear from facultysubjecttagging where employeeid = '" + faculty + "' " + "and examcode = '" + examcode + "' and institutecode = '" + institute + "'  and companycode = '" + company + "' order by academicyear desc ");

    rs = db.getRowset(qry);
    if (rs.next()) {
      sb.append(rs.getString("academicyear").trim());
    }
    return sb.toString();
  }

  @GET
  @Path("examcodebasedonfstid")
  @Produces({"application/json"})
  public String getExamCodeBasedonFstid(@QueryParam("fstid") String fstid, @QueryParam("institute") String institute) throws SQLException
  {
    StringBuilder sb2 = new StringBuilder();
    qry = ("select distinct nvl(examcode,'') examcode from ap#facultyfeedback b where feedbackid='" + fstid + "' and INSTITUTECODE='" + institute + "'  ");
    ResultSet rs1 = db.getRowset(qry);
    String exam = null;
    try {
      if (rs1.next())
      {


        sb2.append("\"" + rs1.getString("EXAMCODE") + "\":\"" + rs1.getString("EXAMCODE") + "\",");
      }
    } catch (Exception e) {
      System.out.println("Error is " + e);
    }


    return "{" + sb2.toString().substring(0, sb2.length() - 1) + "}";
  }

  @GET
  @Path("subjecttaggedforEmployee")
  @Produces({"application/json"})
  public String getSubjecttaggedforEmployee(@QueryParam("institute") String institute, @QueryParam("company") String company, @QueryParam("examcode") String examcode, @QueryParam("acdemicyear") String academicyear, @QueryParam("faculty") String faculty) throws SQLException
  {
    qry = ("select distinct nvl(subjectid,'') subjectid,nvl(subject||'-'||subjectcode,'') sscode  from subjectmaster where subjectid in (select subjectid from facultysubjecttagging where employeeid = '" + faculty + "' and examcode = '" + examcode + "' and " + " institutecode = '" + institute + "'  and companycode = '" + company + "' and academicyear = '" + academicyear + "' and LTP='L')");


    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("subjectid") + "\":\"" + rs.getString("sscode") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }






  @GET
  @Path("subjecttaggedEmployee")
  @Produces({"application/json"})
  public String getSubjecttaggedEmployee(@QueryParam("institute") String institute, @QueryParam("company") String company, @QueryParam("faculty") String faculty, @QueryParam("examcode") String examcode, @QueryParam("feedbackid") String feedbackid)
    throws SQLException
  {
    qry = ("SELECT NVL (b.subjectid || '@' || a.Ltp, '') subjectid, NVL (b.subjectcode || '-'|| DECODE (a.Ltp, 'L', 'LECTURE','P', 'PRACTICAL', 'T', 'TUTORIAL'),'') subjectcode, NVL (b.subject, '') subject, NVL (a.ltp, '') ltp FROM facultysubjecttagging a ,subjectmaster b WHERE a.institutecode = b.institutecode and a.subjectid=b.subjectid  and a.institutecode = '" + institute + "' AND EXISTS (SELECT b.fstid FROM ap#facultyfeedback b WHERE a.fstid = b.fstid " + "AND a.institutecode = b.institutecode AND a.examcode = b.examcode AND b.feedbackid = '" + feedbackid + "' " + "AND b.institutecode = '" + institute + "' AND b.examcode = '" + examcode + "' AND NVL (b.deactive, 'N') = 'N') GROUP BY a.ltp, b.subjectid, b.subjectcode, b.subject ORDER BY b.subject ");






    sb.append("\"ALL\":\"ALL\",");
    rs = db.getRowset(qry);
    while (rs.next()) {
      hs.add(rs.getString("subjectid"));
      sb.append("\"" + rs.getString("subjectid") + "\":\"" + rs.getString("subject") + "-" + rs.getString("subjectcode") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("SectionBranchForSubject")
  @Produces({"application/json"})
  public String getSectionBranchForSubject(@QueryParam("institute") String institute, @QueryParam("examcode") String examcode, @QueryParam("faculty") String faculty, @QueryParam("acadyear") String academicyear, @QueryParam("subject") String subjectid) throws SQLException {
    qry = ("    select distinct sectionbranch from v#studentltpdetail where institutecode = '" + institute + "' AND employeeid = '" + faculty + "' " + "and examcode = '" + examcode + "' and subjectid = '" + subjectid + "' and academicyear ='" + academicyear + "' AND LTP='L' and nvl(deactive,'N') = 'N'");


    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("sectionbranch") + "\":\"" + rs.getString("sectionbranch") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("sectionBranchForBrach")
  @Produces({"application/json"})
  public String getsectionBranchForBrach(@QueryParam("institute") String institute, @QueryParam("examcode") String examcode, @QueryParam("faculty") String faculty, @QueryParam("acadyear") String academicyear, @QueryParam("subject") String subjectid, @QueryParam("branch") String branch) throws SQLException {
    qry = ("    SELECT DISTINCT nvl(subsectioncode,'') subsectioncode FROM v#studentltpdetail WHERE institutecode = '" + institute + "' " + "AND employeeid = '" + faculty + "' AND examcode = '" + examcode + "' AND subjectid = '" + subjectid + "'  " + "AND academicyear = '" + academicyear + "' AND ltp = 'L'  AND NVL (deactive, 'N') = 'N' AND sectionbranch ='" + branch + "'");


    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("subsectioncode") + "\":\"" + rs.getString("subsectioncode") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("FacultyFeedbackReort")
  public String getFacultyFeedbackReort(@QueryParam("feedbackid") String feedbackid, @QueryParam("institute") String institute, @QueryParam("company") String company, @QueryParam("examcode") String examcode, @QueryParam("faculty") String sessionfaculty, @QueryParam("subject") String subject1, @QueryParam("department") String department) throws SQLException {
    String ltp = "";String ratingid = "";String raitId = "";String parenthead = "";String qry3 = "";String rating = "";String quesid = "";String classstrength = "";String q = "";String answer = "";String respondent = "";String sysdate = "";String employeename = "";String transId = "";
    int i = 0;int j = 0;int l = 0;int m = 0;int n = 0;
    String subject = "";String faculty = "";String sid = "";String subjectt = "";String ltpp = "";String sujsid = "";
    HashMap<String, String> employee = new HashMap();
    HashMap<String, String> header = new HashMap();
    HashMap<String, String> question = new HashMap();
    HashSet hset = new HashSet();
    StringBuilder pdfData = new StringBuilder();
    StringBuilder pdfFilename = new StringBuilder();
    ArrayList emp = new ArrayList();

    String[] subjectwithltp = new String[2];

    String subjectwithltpNew = subject1;

    if (subjectwithltpNew.equals("ALL"))
    {


      try
      {


        qry = ("SELECT NVL (b.subjectid || '@' || a.Ltp, '') subjectid, NVL (b.subjectcode || '-'|| DECODE (a.Ltp, 'L', 'LECTURE','P', 'PRACTICAL', 'T', 'TUTORIAL'),'') subjectcode, NVL (b.subject, '') subject, NVL (a.ltp, '') ltp FROM facultysubjecttagging a ,subjectmaster b WHERE a.institutecode = b.institutecode and a.subjectid=b.subjectid  and a.institutecode = '" + institute + "' AND EXISTS (SELECT b.fstid FROM ap#facultyfeedback b WHERE a.fstid = b.fstid " + "AND a.institutecode = b.institutecode AND a.examcode = b.examcode AND b.feedbackid = '" + feedbackid + "' " + "AND b.institutecode = '" + institute + "' AND b.examcode = '" + examcode + "' AND NVL (b.deactive, 'N') = 'N') GROUP BY a.ltp, b.subjectid, b.subjectcode, b.subject ORDER BY b.subject ");





        rs = db.getRowset(qry);
        while (rs.next())
        {
          hset.add(rs.getString("subjectid"));
        }
        Iterator itr = hset.iterator();
        int z = 0;
        while (itr.hasNext()) {
          try {
            sujsid = itr.next().toString();
            subjectwithltp = sujsid.split("@");
            subject = subjectwithltp[0];
            ltp = subjectwithltp[1];




            qry = ("SELECT DISTINCT NVL (a.employeeid, '') employeeid  FROM facultysubjecttagging a , ap#facultyfeedback b ,employeemaster c  WHERE a.institutecode = b.institutecode  AND a.examcode = b.examcode  and a.COMPANYCODE =c.COMPANYCODE And a.EMPLOYEEID =c.employeeid  AND a.subjectid = '" + subject + "'  AND a.institutecode = '" + institute + "'  " + "AND a.examcode = '" + examcode + "'  AND a.fstid = b.fstid  AND a.ltp = '" + ltp + "'");



            rs = db.getRowset(qry);
            if (rs.next()) {
              faculty = faculty + "'" + rs.getString("employeeid") + "',";
            }

            if (!faculty.equals("")) {
              faculty = faculty.substring(0, faculty.length() - 1);
            } else {
              faculty = sessionfaculty;
            }

            qry = (" select distinct nvl(B.departmentcode,'') departmentcode,nvl(d.department,'') department,nvl(a.Programcode,' ') Programcode, nvl(c.ProgramName,' ') ProgramName,nvl(a.semester,'') semester,nvl(a.examcode,'') examcode from  v#studentltpdetail a , V#STAFFSTUDENT b,ProgramMaster C, DepartmentMaster d where A.EMPLOYEECODE=b.EMPLOYEECODE  and a.EMPLOYEEID in (" + faculty + ")  and b.departmentCode=d.departmentCode and" + " a.ProgramCode=c.ProgramCode and a.InstituteCode=c.InstituteCode and nvl(c.deactive,'N')='N'  and" + " nvl(d.deactive,'N')='N' and a.subjectid='" + subject + "' and a.examcode='" + examcode + "' and  a.INSTITUTECODE='" + institute + "' " + " AND a. FSTID in (select FSTID from ap#facultyfeedback where  examcode=a.examcode and INSTITUTECODE='" + institute + "' " + " and feedbackid='" + feedbackid + "' ) ");






            rs = db.getRowset(qry);
            while (rs.next()) {
              header.put("departmentcode", rs.getString("departmentcode") == null ? "" : rs.getString("departmentcode"));
              header.put("department", rs.getString("department") == null ? "" : rs.getString("department").trim());
              header.put("programcode", (String)header.get("programcode") + "/" + rs.getString("Programcode").trim());
              header.put("programcodeforqry", (String)header.get("programcodeforqry") + "','" + rs.getString("Programcode").trim());
              header.put("programname", (String)header.get("programname") + "/" + rs.getString("ProgramName").trim());
              header.put("examcode", rs.getString("examcode") == null ? "" : rs.getString("examcode").trim());
            }




            qry = ("SELECT DISTINCT NVL (a.transid, '') transid  FROM ap#facultyfeedback a, facultysubjecttagging b  WHERE a.fstid = b.fstid(+)  AND b.ltp = '" + ltp + "' AND b.subjectid = '" + subject + "'  AND b.institutecode = '" + institute + "'");

            rs = db.getRowset(qry);
            while (rs.next()) {
              transId = transId + "'" + rs.getString("transid") + "',";
            }
            if (!transId.equals("")) {
              transId = transId.substring(0, transId.length() - 1);
            } else {
              transId = null;
            }







            qry = ("SELECT DISTINCT COUNT (DISTINCT studentid) classstrength  FROM facultysubjecttagging a,   studentltpdetail b WHERE a.fstid = b.fstid  And a.subjectid = '" + subject + "'  AND a.institutecode = '" + institute + "'   AND a.examcode = '" + examcode + "' " + " AND a.ltp = '" + ltp + "'  AND a.fstid IN (  SELECT DISTINCT fstid  FROM ap#facultyfeedback b  " + "WHERE transid IN  (" + transId + " ) AND feedbackid = '" + feedbackid + "'  AND institutecode = '" + institute + "'  AND examcode = '" + examcode + "')");




            rs = db.getRowset(qry);
            if (rs.next()) {
              classstrength = rs.getString("ClassStrength");
            }
            header.put("classstrength", classstrength);
            qry = ("SELECT COUNT (*), TO_CHAR (SYSDATE, 'dd-Mon-yyyy') SYS  FROM (SELECT DISTINCT NVL (entryby, '') entryby FROM ap#facultyfeedbackdetail   WHERE transid in (" + transId + ") and feedbackid='" + feedbackid + "' and componenttype='" + ltp + "'" + " and examcode='" + examcode + "' and INSTITUTECODE='" + institute + "')");


            rs = db.getRowset(qry);
            if (rs.next()) {
              respondent = rs.getString(1);
              sysdate = rs.getString(2);
            }
            ArrayList list = new ArrayList();
            qry = (" SELECT DISTINCT NVL (a.headid, '') headid,NVL (a.ratingid, '') ratingid, NVL (a.seqid, '') seqid, NVL (a.questionid, '')  questionid,   NVL (a.questionbody, '') questionbody,  NVL (b.parentheadid, '') parentheadid, NVL (c.subjective, 'N') subjective  FROM ap#facultyquestionmaster a,        ap#facultyquestionhead b,  ap#ratingmaster c WHERE  a.feedbackid = '" + feedbackid + "'  AND a.institutecode = '" + institute + "'   AND a.examcode ='" + examcode + "'" + "  AND a.componenttype = 'L'  AND a.examcode = b.examcode  AND a.companycode = b.companycode  AND a.feedbackid = b.feedbackid  " + "  AND a.headid = b.headid       AND  a.ratingid = c.ratingid       ORDER BY headid, questionid ");






            rs = db.getRowset(qry);
            while (rs.next()) {
              i++;
              question = new HashMap();
              question.put("seqid", rs.getString("seqid") == null ? "" : rs.getString("seqid"));
              question.put("headid", rs.getString("headid") == null ? "" : rs.getString("headid"));
              question.put("parentheadid", rs.getString("parentheadid") == null ? "" : rs.getString("parentheadid"));
              question.put("questionid", rs.getString("questionid") == null ? "" : rs.getString("questionid"));
              question.put("questionbody", rs.getString("questionbody") == null ? "" : rs.getString("questionbody"));
              question.put("ratingid", rs.getString("ratingid") == null ? "" : rs.getString("ratingid"));
              question.put("subjective", rs.getString("Subjective") == null ? "" : rs.getString("Subjective"));

              if (((String)question.get("subjective")).toString().equals("Y")) {
                qry1 = ("SELECT distinct wm_concat(a.subjectiveanswer) subjectiveanswer   FROM ap#facultyfeedbackdetail a WHERE  a.transid in (" + transId + ") " + " AND a.componenttype = '" + ltp + "' AND a.questionid = '" + (String)question.get("questionid") + "'" + " and a.subjectiveanswer<>'N/A' and  a.INSTITUTECODE='" + institute + "'  and a.examcode='" + examcode + "' " + " and a.feedbackid='" + feedbackid + "'");





                rs1 = db.getRowset(qry1);
                if (rs1.next()) {
                  question.put("answer", rs1.getString("subjectiveanswer").trim() + " ");
                }
              }
              else
              {
                l = 0;
                qry1 = ("SELECT distinct  (a.evaluationvalue) evaluationvalue, COUNT (1)  FROM ap#facultyfeedbackdetail a   WHERE a.transid IN (" + transId + ")  " + " AND a.componenttype = '" + ltp + "'  AND a.questionid ='" + (String)question.get("questionid") + "' and a.INSTITUTECODE='" + institute + "'" + "  and a.examcode='" + examcode + "' and a.feedbackid='" + feedbackid + "' GROUP BY a.evaluationvalue");



                rs1 = db.getRowset(qry1);
                while (rs1.next()) {
                  qry2 = (" SELECT distinct NVL(ratingdesc, '') ratingdesc  FROM ap#ratingdetail WHERE ratingid = '" + (String)question.get("ratingid") + "'  " + " AND  evaluationvalue = '" + rs1.getString("evaluationvalue") + "'    " + "   ");





                  rs2 = db.getRowset(qry2);
                  while (rs2.next()) {
                    l++;
                    question.put("ans" + l + "", rs2.getString("ratingdesc").trim() + "-" + rs1.getString(2) + " ");
                  }
                }
                String ans1 = question.get("ans1") == null ? "" : ((String)question.get("ans1")).toString().trim();
                String ans2 = "," + ((String)question.get("ans2")).toString().trim();
                String ans3 = "," + ((String)question.get("ans3")).toString().trim();
                String ans4 = "," + ((String)question.get("ans4")).toString().trim();
                String ans5 = "," + ((String)question.get("ans5")).toString().trim();

                question.put("answer", ans1 + ans2 + ans3 + ans4 + ans5 + " ");
              }


              qry1 = ("SELECT distinct wm_concat(a.FEEDBACKREMARKS) FEEDBACKREMARKS   FROM ap#facultyfeedbackdetail a WHERE  a.transid in (" + transId + ") " + " AND a.componenttype = '" + ltp + "' AND a.questionid = '" + (String)question.get("questionid") + "'" + " and  examcode='" + examcode + "' and INSTITUTECODE='" + institute + "'   and a.feedbackremarks<>'N/A' " + " and a.feedbackid='" + feedbackid + "'");





              rs1 = db.getRowset(qry1);
              if (rs1.next()) {
                question.put("feedbackremark", rs1.getString("FEEDBACKREMARKS").trim() + " ");
              }





              qry1 = ("SELECT DISTINCT NVL (c.subjectid, '') subjectid,  NVL (c.subjectcode, '') subjectcode, NVL (c.subject, '') subject  FROM Facultysubjecttagging a ,subjectmaster c WHERE a.institutecode =c.institutecode  And a.subjectid=c.subjectid   And a.institutecode = '" + institute + "'  AND a.employeeid IN (" + faculty + ")  AND a.subjectid = '" + subject + "' AND a.ltp = '" + ltp + "'  " + " AND EXISTS ( SELECT b.fstid    FROM ap#facultyfeedback b  WHERE a.fstid = b.fstid " + "AND a.institutecode = b.institutecode   AND a.examcode = b.examcode   AND b.feedbackid = '" + feedbackid + "' " + " AND b.institutecode = '" + institute + "'  AND b.examcode = '" + examcode + "'  AND NVL (b.deactive, 'N') = 'N') ");





              rs1 = db.getRowset(qry1);
              if (rs1.next()) {
                header.put("subjectdetail", rs1.getString("subject") + "(" + rs1.getString("subjectcode") + ")");
              }

              list.add(question);
            }
            if (list.isEmpty()) {
              sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
            } else {
              pdfFilename.append(((String)header.get("department")).toString().trim() + "-(" + ((String)header.get("subjectdetail")).toString().trim() + ")");
              sb.append("<br><div style='width: 98%; padding: 10px' id=report>");
              sb.append("<table id='reporttable' style='z-index:5%'>");
              sb.append("<tr><td align='right' style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-AC-R3<br>Frequency-Every Semester<br>Date-" + sysdate + "<br></font></td></tr>");
              sb.append("<tr><td align='center' style='text-align:center;width:100%;height:20%;' colspan='2' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Teaching and Learning)<br>Faculty Feedback(Lecture/Lab Course)</u><br><br></font> <hr style='width:100%'></hr><br></td></tr>");
              sb.append("<tr><td align='left' style='text-align:left;width:100%;height:20%;'  nowrap><font size='2'  >Department : " + ((String)header.get("department")).toString().trim() + "</font></td><td align='left' style='text-align:left;width:100%;height:20%;'  nowrap><font size='2'  >Report for Institute : [" + institute + " ]</font></td><td nowrap style='text-align:left;width:100%;height:20%;'><font size='2' ></font></td></tr>");
              sb.append("<tr><td align='left' style='text-align:left;width:100%;height:20%;' colspan='2' ><font size='2'  >Subject : " + ((String)header.get("subjectdetail")).toString().trim() + "</font></td><!--td  style='text-align:left;width:100%;height:20%;'><font size='2' >Course Name :  + header.get(programname).toString().trim()</font></td--></tr>");
              sb.append("<tr><td align='left' style='text-align:left;width:100%;height:20%;'  nowrap><font size='2'  ></font></td><td nowrap align='right' style='text-align:left;width:100%;height:20%;'><font size='2' >Number of Registered Students in class:" + (String)header.get("classstrength") + " </font></td></tr>");
              sb.append("<tr><td align='left' style='text-align:left;width:100%;height:20%;' nowrap><font size='2'  >Exam Code : " + examcode + "</font></td><td nowrap align='right' style='text-align:left;width:100%;height:20%;'><font size='2' >Maximum Number of Respondents:" + respondent + " </font></td></tr>");
              sb.append("<tr><td style='text-align:left;width:100%;height:20%;' nowrap><font size='2'  ></font></td><td nowrap style='text-align:left;width:100%;height:20%;'><br></td></tr>");













              qry = ("SELECT distinct  c.employeename ||(select ' (C) ' from ex#subjectgradecoordinator d  where d.fstid=a.fstid and d.facultyid = a.employeeid and rownum=1 ) employeename  FROM Facultysubjecttagging a ,v#staff c   WHERE a.Companycode =c.Companycode    And a.Employeeid = c.Employeeid  And a.subjectid = '" + subject + "'   " + "AND a.institutecode = '" + institute + "'  AND a.examcode = '" + examcode + "'   AND a.ltp = '" + ltp + "'   AND " + "a.fstid IN (  SELECT DISTINCT fstid   FROM ap#facultyfeedback b  WHERE feedbackid = '" + feedbackid + "'   " + "AND institutecode = '" + institute + "'  AND examcode = '" + examcode + "')");





              rs = db.getRowset(qry);
              if (rs.next()) {
                employeename = rs.getString("employeename") == null ? "" : rs.getString("employeename").trim();
              }
              sb.append("<tr><td style='text-align:left;width:100%;height:20%;' colspan='2' ><font size='2' >Faculties : " + employeename + "</font></td></tr>");
              sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='2' > <hr style='width:100%'></hr><br><br></td></tr>");

              String tempheadid = "xyz";

              int sn = 0;
              int subsn = 1;
              String sno = "";
              for (int h = 0; h < list.size(); h++) {
                if (!tempheadid.equals(((Map)list.get(h)).get("headid").toString())) {
                  sn++;
                  sno = String.valueOf(sn);
                  tempheadid = ((Map)list.get(h)).get("headid").toString();
                  if ((h != 0) && (((Map)list.get(h - 1)).get("headid").toString().equals(((Map)list.get(h)).get("parentheadid").toString()))) {
                    sn--;
                    sno = String.valueOf(sn) + ".1";
                  }
                } else {
                  subsn++;
                  sno = String.valueOf(sn) + "." + String.valueOf(subsn);
                }

                String remarks = "Remarks :" + ((Map)list.get(h)).get("feedbackremark").toString().trim();
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;'  colspan='2'><font size='2'> QA-AC-R3 . " + sno + " " + ((Map)list.get(h)).get("questionbody") + "-" + ((Map)list.get(h)).get("answer") + "<br>" + remarks + "</td></tr>");
              }
              sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><hr style='width:100%'></hr><br><br><font size='2' >(Name and signature)</font></td></tr>");

              sb.append("</table>");

            }



          }
          catch (Exception e)
          {

            e.printStackTrace();
          }
        }
      }
      catch (Exception e) {
        e.printStackTrace();
      }
    }
    else
    {
      subjectwithltp = subject1.split("@");
      subject = subjectwithltp[0];
      ltp = subjectwithltp[1];





      qry = ("SELECT DISTINCT NVL (a.employeeid, '') employeeid  FROM facultysubjecttagging a , ap#facultyfeedback b ,employeemaster c  WHERE a.institutecode = b.institutecode  AND a.examcode = b.examcode  and a.COMPANYCODE =c.COMPANYCODE And a.EMPLOYEEID =c.employeeid  AND a.subjectid = '" + subject + "'  AND a.institutecode = '" + institute + "'  " + "AND a.examcode = '" + examcode + "'  AND a.fstid = b.fstid  AND a.ltp = '" + ltp + "'");



      rs = db.getRowset(qry);
      if (rs.next()) {
        faculty = faculty + "'" + rs.getString("employeeid") + "',";
      }

      if (!faculty.equals("")) {
        faculty = faculty.substring(0, faculty.length() - 1);
      } else {
        faculty = sessionfaculty;
      }
      qry = (" select distinct nvl(B.departmentcode,'') departmentcode,nvl(d.department,'') department,nvl(a.Programcode,' ') Programcode, nvl(c.ProgramName,' ') ProgramName,nvl(a.semester,'') semester,nvl(a.examcode,'') examcode from  v#studentltpdetail a , V#STAFFSTUDENT b,ProgramMaster C, DepartmentMaster d where A.EMPLOYEECODE=b.EMPLOYEECODE  and a.EMPLOYEEID in (" + faculty + ")  and b.departmentCode=d.departmentCode and" + " a.ProgramCode=c.ProgramCode and a.InstituteCode=c.InstituteCode and nvl(c.deactive,'N')='N'  and" + " nvl(d.deactive,'N')='N' and a.subjectid='" + subject + "' and a.examcode='" + examcode + "' and  a.INSTITUTECODE='" + institute + "' " + " AND a. FSTID in (select FSTID from ap#facultyfeedback where  examcode=a.examcode and INSTITUTECODE='" + institute + "' " + " and feedbackid='" + feedbackid + "' ) ");






      rs = db.getRowset(qry);
      while (rs.next()) {
        header.put("departmentcode", rs.getString("departmentcode") == null ? "" : rs.getString("departmentcode"));
        header.put("department", rs.getString("department") == null ? "" : rs.getString("department").trim());
        header.put("programcode", (String)header.get("programcode") + "/" + rs.getString("Programcode").trim());
        header.put("programcodeforqry", (String)header.get("programcodeforqry") + "','" + rs.getString("Programcode").trim());
        header.put("programname", (String)header.get("programname") + "/" + rs.getString("ProgramName").trim());
        header.put("examcode", rs.getString("examcode") == null ? "" : rs.getString("examcode").trim());
      }




      qry = ("SELECT DISTINCT NVL (a.transid, '') transid  FROM ap#facultyfeedback a, facultysubjecttagging b  WHERE a.fstid = b.fstid(+)  AND b.ltp = '" + ltp + "' AND b.subjectid = '" + subject + "'  AND b.institutecode = '" + institute + "'");


      rs = db.getRowset(qry);
      while (rs.next()) {
        transId = transId + "'" + rs.getString("transid") + "',";
      }
      if (!transId.equals("")) {
        transId = transId.substring(0, transId.length() - 1);
      } else {
        transId = null;
      }







      qry = ("SELECT DISTINCT COUNT (DISTINCT studentid) classstrength  FROM facultysubjecttagging a,   studentltpdetail b WHERE a.fstid = b.fstid  And a.subjectid = '" + subject + "'  AND a.institutecode = '" + institute + "'   AND a.examcode = '" + examcode + "' " + " AND a.ltp = '" + ltp + "'  AND a.fstid IN (  SELECT DISTINCT fstid  FROM ap#facultyfeedback b  " + "WHERE transid IN  (" + transId + " ) AND feedbackid = '" + feedbackid + "'  AND institutecode = '" + institute + "'  AND examcode = '" + examcode + "')");




      rs = db.getRowset(qry);
      if (rs.next()) {
        classstrength = rs.getString("ClassStrength");
      }
      header.put("classstrength", classstrength);


      qry = ("SELECT COUNT (*), TO_CHAR (SYSDATE, 'dd-Mon-yyyy') SYS  FROM (SELECT DISTINCT NVL (entryby, '') entryby FROM ap#facultyfeedbackdetail   WHERE transid in (" + transId + ") and feedbackid='" + feedbackid + "' and componenttype='" + ltp + "'" + " and examcode='" + examcode + "' and INSTITUTECODE='" + institute + "')");


      rs = db.getRowset(qry);
      if (rs.next()) {
        respondent = rs.getString(1);
        sysdate = rs.getString(2);
      }
      ArrayList list = new ArrayList();
      qry = (" SELECT DISTINCT NVL(a.headid, '') headid,NVL (a.ratingid, '') ratingid,nvl(a.seqid,'') seqid, NVL (a.questionid, '') questionid,NVL (a.questionbody, '') questionbody,nvl(b.PARENTHEADID,'') parentheadid, nvl(c.subjective,'N') subjective FROM ap#facultyquestionmaster a,ap#facultyquestionhead b, ap#ratingmaster c where a.feedbackid = '" + feedbackid + "' and a.institutecode = '" + institute + "' AND a.examcode = '" + examcode + "' and a.COMPONENTTYPE='" + ltp + "'" + " and a.examcode=b.examcode and a.COMPANYCODE=b.COMPANYCODE  and a.FEEDBACKID=b.FEEDBACKID  and a.HEADID=b.HEADID " + " and  " + " a.ratingid=c.ratingid  order by  headid,questionid ");







      rs = db.getRowset(qry);
      while (rs.next()) {
        i++;
        question = new HashMap();
        question.put("seqid", rs.getString("seqid") == null ? "" : rs.getString("seqid"));
        question.put("headid", rs.getString("headid") == null ? "" : rs.getString("headid"));
        question.put("parentheadid", rs.getString("parentheadid") == null ? "" : rs.getString("parentheadid"));
        question.put("questionid", rs.getString("questionid") == null ? "" : rs.getString("questionid"));
        question.put("questionbody", rs.getString("questionbody") == null ? "" : rs.getString("questionbody"));
        question.put("ratingid", rs.getString("ratingid") == null ? "" : rs.getString("ratingid"));
        question.put("subjective", rs.getString("Subjective") == null ? "" : rs.getString("Subjective"));

        if (((String)question.get("subjective")).toString().equals("Y")) {
          qry1 = ("SELECT distinct wm_concat(a.subjectiveanswer) subjectiveanswer   FROM ap#facultyfeedbackdetail a WHERE  a.transid in (" + transId + ") " + " AND a.componenttype = '" + ltp + "' AND a.questionid = '" + (String)question.get("questionid") + "'" + " and a.subjectiveanswer<>'N/A' and  a.INSTITUTECODE='" + institute + "'  and a.examcode='" + examcode + "' " + " and a.feedbackid='" + feedbackid + "'");





          rs1 = db.getRowset(qry1);
          if (rs1.next()) {
            question.put("answer", rs1.getString("subjectiveanswer").trim() + " ");
          }
        }
        else
        {
          l = 0;
          qry1 = ("SELECT distinct  (a.evaluationvalue) evaluationvalue, COUNT (1)  FROM ap#facultyfeedbackdetail a   WHERE a.transid IN (" + transId + ")  " + " AND a.componenttype = '" + ltp + "'  AND a.questionid ='" + (String)question.get("questionid") + "' and a.INSTITUTECODE='" + institute + "'" + "  and a.examcode='" + examcode + "' and a.feedbackid='" + feedbackid + "' GROUP BY a.evaluationvalue");



          rs1 = db.getRowset(qry1);
          while (rs1.next()) {
            qry2 = (" SELECT distinct NVL(ratingdesc, '') ratingdesc  FROM ap#ratingdetail WHERE ratingid = '" + (String)question.get("ratingid") + "'  " + "   AND evaluationvalue = '" + rs1.getString("evaluationvalue") + "'    " + "  ");





            rs2 = db.getRowset(qry2);
            while (rs2.next()) {
              l++;
              question.put("ans" + l + "", rs2.getString("ratingdesc").trim() + "-" + rs1.getString(2) + " ");
            }
          }
          String ans1 = question.get("ans1") == null ? "" : ((String)question.get("ans1")).toString().trim();
          String ans2 = "," + ((String)question.get("ans2")).toString().trim();
          String ans3 = "," + ((String)question.get("ans3")).toString().trim();
          String ans4 = "," + ((String)question.get("ans4")).toString().trim();
          String ans5 = "," + ((String)question.get("ans5")).toString().trim();

          question.put("answer", ans1 + ans2 + ans3 + ans4 + ans5 + " ");
        }


        qry1 = ("SELECT distinct wm_concat(a.FEEDBACKREMARKS) FEEDBACKREMARKS   FROM ap#facultyfeedbackdetail a WHERE  a.transid in (" + transId + ") " + " AND a.componenttype = '" + ltp + "' AND a.questionid = '" + (String)question.get("questionid") + "'" + " and  examcode='" + examcode + "' and INSTITUTECODE='" + institute + "'   and a.feedbackremarks<>'N/A' " + " and a.feedbackid='" + feedbackid + "'");





        rs1 = db.getRowset(qry1);
        if (rs1.next()) {
          question.put("feedbackremark", rs1.getString("FEEDBACKREMARKS").trim() + " ");
        }





        qry1 = ("SELECT DISTINCT NVL (c.subjectid, '') subjectid,  NVL (c.subjectcode, '') subjectcode, NVL (c.subject, '') subject  FROM Facultysubjecttagging a ,subjectmaster c WHERE a.institutecode =c.institutecode  And a.subjectid=c.subjectid   And a.institutecode = '" + institute + "'  AND a.employeeid IN (" + faculty + ")  AND a.subjectid = '" + subject + "' AND a.ltp = '" + ltp + "'  " + " AND EXISTS ( SELECT b.fstid    FROM ap#facultyfeedback b  WHERE a.fstid = b.fstid " + "AND a.institutecode = b.institutecode   AND a.examcode = b.examcode   AND b.feedbackid = '" + feedbackid + "' " + " AND b.institutecode = '" + institute + "'  AND b.examcode = '" + examcode + "'  AND NVL (b.deactive, 'N') = 'N') ");






        rs1 = db.getRowset(qry1);
        if (rs1.next()) {
          header.put("subjectdetail", rs1.getString("subject") + "(" + rs1.getString("subjectcode") + ")");
        }

        list.add(question);
      }
      if (list.isEmpty()) {
        sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
      } else {
        pdfFilename.append(((String)header.get("department")).toString().trim() + "-(" + ((String)header.get("subjectdetail")).toString().trim() + ")");
        sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
        sb.append("<table id='reporttable' style='z-index:5%'>");
        sb.append("<tr><td align='right' style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-AC-R3<br>Frequency-Every Semester<br>Date-" + sysdate + "<br></font></td></tr>");
        sb.append("<tr><td align='center' style='text-align:center;width:100%;height:20%;' colspan='2' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Teaching and Learning)<br>Faculty Feedback(Lecture/Lab Course)</u><br><br></font> <hr style='width:100%'></hr><br></td></tr>");
        sb.append("<tr><td align='left' style='text-align:left;width:100%;height:20%;'  nowrap><font size='2'  >Department : " + ((String)header.get("department")).toString().trim() + "</font></td><td align='left' style='text-align:left;width:100%;height:20%;'  nowrap><font size='2'  >Report for Institute : [" + institute + " ]</font></td><td nowrap style='text-align:left;width:100%;height:20%;'><font size='2' ></font></td></tr>");
        sb.append("<tr><td align='left' style='text-align:left;width:100%;height:20%;' colspan='2' ><font size='2'  >Subject : " + ((String)header.get("subjectdetail")).toString().trim() + "</font></td><!--td  style='text-align:left;width:100%;height:20%;'><font size='2' >Course Name :  + header.get(programname).toString().trim()</font></td--></tr>");
        sb.append("<tr><td align='left' style='text-align:left;width:100%;height:20%;'  nowrap><font size='2'  ></font></td><td nowrap align='right' style='text-align:left;width:100%;height:20%;'><font size='2' >Number of Registered Students in class:" + (String)header.get("classstrength") + " </font></td></tr>");
        sb.append("<tr><td align='left' style='text-align:left;width:100%;height:20%;' nowrap><font size='2'  >Exam Code : " + examcode + "</font></td><td nowrap align='right' style='text-align:left;width:100%;height:20%;'><font size='2' >Maximum Number of Respondents:" + respondent + " </font></td></tr>");












        qry = ("SELECT distinct  c.employeename ||(select ' (C) ' from ex#subjectgradecoordinator d  where d.fstid=a.fstid and d.facultyid = a.employeeid and rownum=1 ) employeename  FROM Facultysubjecttagging a ,v#staff c   WHERE a.Companycode =c.Companycode    And a.Employeeid = c.Employeeid  And a.subjectid = '" + subject + "'   " + "AND a.institutecode = '" + institute + "'  AND a.examcode = '" + examcode + "'   AND a.ltp = '" + ltp + "'   AND " + "a.fstid IN (  SELECT DISTINCT fstid   FROM ap#facultyfeedback b  WHERE feedbackid = '" + feedbackid + "'   " + "AND institutecode = '" + institute + "'  AND examcode = '" + examcode + "')");







        rs = db.getRowset(qry);
        if (rs.next()) {
          employeename = rs.getString("employeename") == null ? "" : rs.getString("employeename").trim();
        }
        sb.append("<tr><td style='text-align:left;width:100%;height:20%;' colspan='2' ><font size='2' >Faculties : " + employeename + "</font></td></tr>");
        sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='2' > <hr style='width:100%'></hr><br><br></td></tr>");

        String tempheadid = "xyz";

        int sn = 0;
        int subsn = 1;
        String sno = "";
        for (int h = 0; h < list.size(); h++) {
          if (!tempheadid.equals(((Map)list.get(h)).get("headid").toString())) {
            sn++;
            sno = String.valueOf(sn);
            tempheadid = ((Map)list.get(h)).get("headid").toString();
            if ((h != 0) && (((Map)list.get(h - 1)).get("headid").toString().equals(((Map)list.get(h)).get("parentheadid").toString()))) {
              sn--;
              sno = String.valueOf(sn) + ".1";
            }
          } else {
            subsn++;
            sno = String.valueOf(sn) + "." + String.valueOf(subsn);
          }

          String remarks = "Remarks :" + ((Map)list.get(h)).get("feedbackremark").toString().trim();
          sb.append("<tr><td style='text-align:left;width:25%;height:10%;'  colspan='2'><font size='2'> QA-AC-R3 . " + sno + " " + ((Map)list.get(h)).get("questionbody") + "-" + ((Map)list.get(h)).get("answer") + "<br>" + remarks + "</td></tr>");
        }
        sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><hr style='width:100%'></hr><br><br><font size='2' >(Name and signature)</font></td></tr>");

        sb.append("</table>");



        sb.append("</div><center><button id='Print' onclick='return printDiv();' >Print</button>&nbsp;&nbsp;&nbsp;<input type='button' id='pdfButton'  value='Genrate Pdf' ></center>");
      }
    }



    return sb.toString();
  }

  @GET
  @Path("StudentFeedbackforTheory")
  public String getStudentFeedbackforTheoryReport(@QueryParam("institute") String institute, @QueryParam("company") String company, @QueryParam("examcode") String examcode, @QueryParam("acadyear") String academicyear, @QueryParam("faculty") String faculty, @QueryParam("subject") String subject, @QueryParam("branch") String branch) throws SQLException
  {
    String ratingid = "";
    String parenthead = "";
    String rating = "";
    String quesid = "";
    int i = 0;
    int j = 0;
    qry = (" select distinct nvl(fstid,'') fstid,nvl(SUBJECTID,'') SUBJECTID,nvl(employeename,'') employeename,nvl(examcode,'') examcode,nvl(subjectcode,'') subjectcode,nvl(subject,'') subject  from v#studentltpdetail  where institutecode = '" + institute + "' AND companycode = '" + company + "' AND employeeid = '" + faculty + "' and examcode = '" + examcode + "' " + "and subjectid = '" + subject + "' and academicyear ='" + academicyear + "' AND LTP='L' and nvl(deactive,'N') = 'N' and sectionbranch = '" + branch + "'");

    rs = db.getRowset(qry);
    if (rs.next()) {
      sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
      sb.append("<table id='reporttable' style='z-index:5%'>");
      sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-AC-3<br>Frequency-Every Semester<br>Date-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br></font></td></tr>");
      sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='2' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Teacing and Learning)<br>Faculty Feedback(Lecture/Lab Course)</u><br><br></font></td></tr>");
      sb.append("<tr><td style='text-align:left;width:100%;height:20%;'  nowrap><font size='2'  >Subject Code : " + rs.getString("subjectcode") + "</font></td><td nowrap style='text-align:left;width:100%;height:20%;'><font size='2' >Subject : " + rs.getString("subject") + "</font></td></tr>");
      sb.append("<tr><td style='text-align:left;width:100%;height:20%;'  nowrap><font size='2'  >Faculty Name : " + rs.getString("employeename") + "</font></td><td nowrap style='text-align:left;width:100%;height:20%;'><font size='2' >Number of Registered Students in class: </font></td></tr>");
      sb.append("<tr><td style='text-align:left;width:100%;height:20%;' nowrap><font size='2'  >Exam Code : " + rs.getString("examcode") + "</font><br><br><br><br><br></td><td nowrap style='text-align:left;width:100%;height:20%;'><font size='2' >Maximum Number of Respondents: </font><br><br><br><br><br></td></tr>");

      qry1 = (" SELECT nvl(a.feedbackid,'') feedbackid,nvl(q.questionid,'') questionid,nvl(q.questionbody,'') questionbody,nvl(b.headid,'') headid, nvl(c.parentheadid,'')  parentheadid,nvl(b.evaluationvalue,'') evaluationvalue  ,nvl(q.ratingid,'') ratingid  FROM ap#facultyfeedback a, ap#facultyfeedbackdetail b,ap#facultyquestionmaster q,ap#facultyquestionhead c  WHERE a.fstid = '" + rs.getString("fstid") + "' AND a.transid = b.transid AND a.examcode = b.examcode AND" + " a.feedbackid = b.feedbackid and q.questionid = b.questionid   AND q.examcode = a.examcode " + "  AND q.componenttype = 'L' and c.headid=b.headid and  c.examcode = b.examcode AND" + " c.componenttype = q.componenttype  order by q.seqid ");

      rs1 = db.getRowset(qry1);
      while (rs1.next()) {
        i++;
        parenthead = rs1.getString("parentheadid") == null ? "" : rs1.getString("parentheadid").trim();
        ratingid = rs1.getString("ratingid") == null ? "" : rs1.getString("ratingid").trim();
        quesid = rs1.getString("questionid") == null ? "" : rs1.getString("questionid").trim();
        qry2 = (" SELECT DISTINCT NVL (r.ratingdesc,'') ansprint  FROM ap#ratingdetail r, ap#facultyfeedbackdetail b  WHERE r.feedbackid = b.feedbackid(+) AND r.rating = b.EVALUATIONVALUE(+) AND b.questionid = '" + quesid + "' AND r.ratingid='" + ratingid + "' " + " UNION ALL SELECT DISTINCT NVL (b.SUBJECTIVEANSWER,'') ansprint FROM ap#ratingdetail r, " + " ap#facultyfeedbackdetail b WHERE r.feedbackid = b.feedbackid(+) AND b.questionid = '" + quesid + "' " + " aND r.ratingid='" + ratingid + "' ");
        rs2 = db.getRowset(qry2);
        if (rs2.next()) {
          rating = rs2.getString("Ansprint") == null ? "" : rs2.getString("Ansprint").trim();
        } else {
          rating = "";
        }
        if (!parenthead.equals("")) {
          i--;
          j++;
        } else {
          j = 0;
        }
        sb.append("<tr><td style='text-align:left;width:25%;height:10%;'  colspan='2'><font size='2'>" + i + "-" + (j == 0 ? "" : Integer.valueOf(j)) + ":" + rs1.getString("questionbody") + "-" + rating + "</font></td></tr>");
      }
      sb.append("<tr><br><br><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><br><br><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
      sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
    } else {
      sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
    }
    return sb.toString();
  }

  @GET
  @Path("comapnyforfacultytrans")
  @Produces({"application/json"})
  public String getCompanyForFacultyTrans() throws SQLException {
    qry = "select distinct nvl(a.companycode,'') companycode,nvl(a.companyname,'') companyname  from companymaster a,ap#facultyshfeedbackheader b where a.companycode=b.companyid order by companyname asc";
    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("companycode").trim() + "\":\"" + rs.getString("companyname").trim() + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("instituteforfacultytrans")
  @Produces({"application/json"})
  public String getInstituteForFacultyTrans(@QueryParam("company") String company) throws SQLException {
    qry = (" select distinct nvl(a.institutecode,'') institutecode,nvl(a.institutename,'') institute from institutemaster a,ap#facultyshfeedbackheader b where b.companyid='" + company + "' and a.INSTITUTECODE=b.INSTITUTEID order by institute asc");
    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("institutecode").trim() + "\":\"" + rs.getString("institute").trim() + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("academicyearforfacultytrans")
  @Produces({"application/json"})
  public String getAcademicYearForFacultyTrans(@QueryParam("company") String company, @QueryParam("instititute") String institute) throws SQLException {
    qry = ("    select distinct nvl(academicyear,'') academicyear from academicyearmaster a,ap#facultyshfeedbackheader b where b.companyid='" + company + "' and b.instituteid='" + institute + "' and a.INSTITUTECODE=b.INSTITUTEID " + "and a.academicyear=b.APACADEMICYEAR order by academicyear desc");


    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("academicyear").trim() + "\":\"" + rs.getString("academicyear").trim() + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("departmentforfacultytrans")
  @Produces({"application/json"})
  public String getDepartmentForFacultyTrans(@QueryParam("company") String company, @QueryParam("instititute") String institute, @QueryParam("academicyear") String academicyear) throws SQLException {
    qry = (" select distinct nvl(a.departmentcode,'') departmentcode ,nvl(a.department,'')department  from departmentmaster  a,ap#facultyshfeedbackheader b where b.companyid='" + company + "' and b.instituteid='" + institute + "' and b.APACADEMICYEAR='" + academicyear + "'  and a.DEPARTMENTCODE=b.DEPARTMENTCODE order by department asc");
    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("departmentcode").trim() + "\":\"" + rs.getString("department").trim() + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("programforfacultytrans")
  @Produces({"application/json"})
  public String getProgramForFacultyTrans(@QueryParam("company") String company, @QueryParam("instititute") String institute, @QueryParam("academicyear") String academicyear, @QueryParam("department") String department) throws SQLException {
    qry = ("select distinct nvl(a.PROGRAMCODE,'') PROGRAMCODE,nvl(a.PROGRAMNAME,'') PROGRAMNAME  from programmaster a,ap#facultyshfeedbackheader b  where a.institutecode='" + institute + "' and b.companyid='" + company + "' and a.institutecode=b.INSTITUTEID" + " and b.APACADEMICYEAR='" + academicyear + "'  and b.DEPARTMENTCODE='" + department + "' and a.programcode=b.PROGRAMCODE order by programname asc");


    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("PROGRAMCODE").trim() + "\":\"" + rs.getString("PROGRAMNAME").trim() + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("AcademicyearForNonTec")
  @Produces({"application/json"})
  public String getAcademicYearForNonTec(@QueryParam("institute") String institute) throws SQLException {
    qry = ("select distinct nvl (apacademicyear,'') academicyear from ap#nontechshfeedbackheader where instituteid='" + institute + "'");
    rs = db.getRowset(qry);
    while (rs.next()) {
      sb.append("\"" + rs.getString("academicyear").trim() + "\":\"" + rs.getString("academicyear").trim() + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("DepartmentForNontec")
  @Produces({"application/json"})
  public String getDepartmentForNontec(@QueryParam("academicyear") String academicyear) throws SQLException
  {
    qry = ("select distinct nvl(a.departmentcode,'') departmentcode,(select distinct nvl(department,'') department  from departmentmaster where departmentcode=a.departmentcode) department from ap#nontechshfeedbackheader a where a.APACADEMICYEAR='" + academicyear + "' ");

    rs = db.getRowset(qry);
    sb.append("\"ALL\":\"ALL\",");
    while (rs.next()) {
      sb.append("\"" + rs.getString("departmentcode") + "\":\"" + rs.getString("department") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("feedbakcid")
  @Produces({"application/json"})
  public String getFeedbakcid(@QueryParam("institute") String institute) throws SQLException {
    qry = ("select distinct nvl(b.APFEEDBACKID,'') APFEEDBACKID  from  AP#FACULTYSHFEEDBACKHEADER b where b.instituteid='" + institute + "'");
    rs = db.getRowset(qry);

    while (rs.next()) {
      sb.append("\"" + rs.getString("APFEEDBACKID") + "\":\"" + rs.getString("APFEEDBACKID") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }

  @GET
  @Path("acadmicyear")
  @Produces({"application/json"})
  public String getAcadmicYear(@QueryParam("institute") String institute, @QueryParam("feedbackid") String feedbackid) throws SQLException {
    qry = ("select  distinct apacademicyear   from    AP#FACULTYSHFEEDBACKHEADER  where   instituteid= '" + institute + "' and  Apfeedbackid =  '" + feedbackid + "' order by 1 desc");

    rs = db.getRowset(qry);

    while (rs.next()) {
      sb.append("\"" + rs.getString("apacademicyear") + "\":\"" + rs.getString("apacademicyear") + "\",");
    }
    return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
  }


  @GET
  @Path("ShFacultyFeedBackReport")
  public String getShFacultyFeedBackReport(@QueryParam("feedbackid") String feedbackid, @QueryParam("institute") String institute, @QueryParam("acdyear") String acdyear)
    throws SQLException
  {
    Map<String, String> Department = new TreeMap();
    Map<String, String> row = new TreeMap();
    Map<String, String> questionmap = new TreeMap();
    ArrayList<String> question = new ArrayList();
    ArrayList<String> deptlist = new ArrayList();

    String Date = "";
    int i = 0;
    String QuestionQry = "";
    qry = "Select to_char(Sysdate,'DD-Mon-yyyy') mTime1 from Dual";

    rs = db.getRowset(qry);
    if (rs.next()) {
      Date = rs.getString("mTime1");
    }
    qry = ("select distinct departmentcode,(select department from departmentmaster  a where a.departmentcode=b.departmentcode) department from  AP#FACULTYSHFEEDBACKHEADER b where b.instituteid='" + institute + "'");
    rs = db.getRowset(qry);
    while (rs.next()) {
      deptlist.add(rs.getString("departmentcode"));
      Department.put(rs.getString("departmentcode"), rs.getString("department"));
    }

    Iterator it = Department.entrySet().iterator();

    sb.append("<br><div style='width: 90%; padding: 10px ;border: .2em solid;margin-left:5%;' id=MainReport><div style='width: 90%; padding: 10px ;margin-left:5%;' id=report>");
    sb.append("<center><table id='reporttable' style='z-index:5%;width:100%' >");
    sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-SR-3<br>Frequency-Every Year<br>Date-" + Date + "&nbsp;&nbsp;&nbsp;&nbsp;<br></font></td></tr>");
    sb.append("<tr><td style='text-align:center;width:100%;height:20%;'  colspan='2'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Stackholder Relationship<br>Faculty Feedback Transaction Report<br>FOR Academic Year '" + acdyear + "'</u><br></font></td></tr></table></center>");
    sb.append("</div><div style='width: 90%; padding: 10px ;margin-left:5%;' id=report1><table rules='all' style='z-index:5%;width:100%' border='1' border-color='black' id='mainReport'><tr><thead><th rowspan=2><font size=2>Sl No</font></th><th rowspan=2><font size=2>Parameter</font></th>");
    while (it.hasNext()) {
      Map.Entry dept = (Map.Entry)it.next();
      sb.append("<th colspan=2><font size=2>" + dept.getValue() + "</font></th>");
    }
    sb.append("<th colspan=2><font size=2>Total</font></th><th rowspan='2'><font size=2>Remarks</font></th></tr>");
    sb.append("<tr>");
    for (int k = 0; k < Department.size(); k++) {
      sb.append("<th><font size=2> No Of Entry </font></th><th><font size=2>Sum Of Rating</th></th>");
    }
    sb.append("<th><font size=2>No Of Entry</font></th><th><font size=2>Sum Of Rating </font></th></tr>");
    QuestionQry = "select questionid,QUESTIONBODY from AP#SHQUESTIONmaster  where FEEDBACKID='" + feedbackid + "' order by questionid";
    rs = db.getRowset(QuestionQry);
    while (rs.next()) {
      question.add(rs.getString("questionid"));
      questionmap.put(rs.getString("questionid"), rs.getString("QUESTIONBODY"));
    }


    qry = ("   SELECT   COUNT (a.TRANSACTIONID) NoOfEntry, SUM (nvl(a.APFEEDBACKRATING,0)) SumOFrating, C.QUESTIONBODY,c.questionid,b.departmentcode,  nvl(  wm_concat (DECODE (NVL (a.APFEEDBACKUSERREMARKS, ''), 'null', '',nvl(APFEEDBACKUSERREMARKS,''))),'') Remark    FROM    AP#FACULTYSHFEEDBACKdetail a, AP#SHQUESTIONmaster c,AP#FACULTYSHFEEDBACKHEADER b   WHERE       A.APFEEDBACKITEMID = C.QUESTIONID    AND A.APFEEDBACKID = C.FEEDBACKID         AND a.APFEEDBACKID = '" + feedbackid + "'  " + "   and a.APFEEDBACKID=b.APFEEDBACKID   " + "   and a.INSTITUTEID=b.INSTITUTEID " + " and a.TRANSACTIONID=b.TRANSACTIONID and b.instituteid='" + institute + "' AND a.APFEEDBACKITEMID <>('QUS00017') " + "  AND b.APACADEMICYEAR='" + acdyear + "'GROUP BY " + "  APFEEDBACKITEMID, C.QUESTIONBODY,c.questionid,b.DEPARTMENTCODE ORDER BY   C.QUESTIONBODY ");







    rs = db.getRowset(qry);
    while (rs.next()) {
      i++;
      row.put(rs.getString("questionid") + rs.getString("departmentcode"), rs.getString("NoOfEntry") + "/" + rs.getString("SumOFrating"));
      row.put(rs.getString("questionid") + rs.getString("departmentcode") + "remarks", rs.getString("Remark") == null ? "" : rs.getString("Remark"));
    }

    int entry = 0;
    int ratings = 0;
    int verticalentry = 0;
    int verticalrating = 0;
    int grandentry = 0;
    int grandrating = 0;
    String[] args = null;

    Collections.sort(deptlist);
    for (int l = 0; l < question.size() - 1; l++) {
      entry = 0;
      ratings = 0;

      sb.append("<tr>");
      sb.append("<td><font size=2>" + (l + 1) + "</font></td>");
      sb.append("<td><font size=2>" + (String)questionmap.get(question.get(l)) + "</font></td>");
      String remarks = "";
      for (int j = 0; j < deptlist.size(); j++) {
        if (row.containsKey((String)question.get(l) + (String)deptlist.get(j))) {
          String[] values = ((String)row.get((String)question.get(l) + (String)deptlist.get(j))).toString().split("/");
          sb.append("<td><a href='#'><font size=2>" + values[0] + "</font></a></td><td><a href='#'><font size=2>" + values[1] + "</a></font></td>");
          remarks = row.containsKey((String)question.get(l) + (String)deptlist.get(j) + "remarks") ? remarks + (String)row.get(new StringBuilder().append((String)question.get(l)).append((String)deptlist.get(j)).append("remarks").toString()) : "";
          args = ((String)row.get((String)question.get(l) + (String)deptlist.get(j))).toString().split("/");
          entry += Integer.parseInt(args[0]);
          ratings += Integer.parseInt(args[1]);
        } else {
          sb.append("<td>&nbsp;</td>");
        }
      }
      sb.append("<td><font size=2>" + entry + "</td><td><font size=2>" + ratings + "</font></td>");
      if (remarks.equals("")) {
        sb.append("<td><font size=2></font></td>");
      } else {
        sb.append("<td><font size=2><a href=RemarksPopup.jsp?remarks=" + remarks + " target=popup   onclick=window.open(RemarksPopup.jsp?remarks=" + remarks + ",popup,width=400,height=200,top=500,left=700); return false;>Remarks</a></font></td>");
      }
      sb.append("</tr>");
    }
    sb.append("<tr><td colspan=2><font size=2>Total</td>");

    for (int k = 0; k < deptlist.size(); k++) {
      verticalentry = 0;
      verticalrating = 0;
      for (int l = 0; l < question.size(); l++) {
        if (row.containsKey((String)question.get(l) + (String)deptlist.get(k))) {
          args = ((String)row.get((String)question.get(l) + (String)deptlist.get(k))).toString().split("/");
          verticalentry += Integer.parseInt(args[0]);
          verticalrating += Integer.parseInt(args[1]);
        }
      }
      sb.append("<td><font size=2>" + verticalentry + "</font></td><td><font size=2>" + verticalrating + "</font></td>");
      grandentry += verticalentry;
      grandrating += verticalrating;
    }
    sb.append("<td><font size=2>" + grandentry + "</font></td><td><font size=2>" + grandrating + "</font></td>");
    sb.append("<td><font size=2>&nbsp;</td>");
    sb.append("</table></div></div>");
    sb.append("<center><button onclick='xlsFormatfn();'>Xls Format</button></center>");

    return sb.toString();
  }

  @GET
  @Path("NonTechFacultyFeedBackReport")
  public String getNonTechFacultyFeedBackReportReport(@QueryParam("instititute") String institute, @QueryParam("company") String company, @QueryParam("program") String program, @QueryParam("academicyear") String academicyear, @QueryParam("department") String department) throws SQLException
  {
    String ratingid = "";
    String feedbackid = "";
    String parenthead = "";
    String transId = "";
    String rating = "";
    String quesid = "";
    String employeename = "";
    String departmentdetail = "";
    String Date = "";
    String examcode = "";
    String ratingdetail = "";
    String ratingcount = "";
    int i = 0;
    int j = 0;
    qry = "Select to_char(Sysdate,'DD-Mon-yyyy') mTime1 from Dual";

    rs = db.getRowset(qry);
    if (rs.next()) {
      Date = rs.getString("mTime1");
    }
    if (!department.equals("ALL")) {
      qry = (" select distinct nvl(a.department,'') department  from departmentmaster a where a.departmentcode='" + department + "' ");
      rs = db.getRowset(qry);
      if (rs.next()) {
        departmentdetail = rs.getString("department") + " ";
      }
    } else {
      qry = " select distinct nvl(a.department,'') department  from departmentmaster a  ";
      rs = db.getRowset(qry);
      while (rs.next()) {
        departmentdetail = departmentdetail + rs.getString("department") + " , ";
      }
    }


    if (!departmentdetail.equals("")) {
      departmentdetail = departmentdetail.substring(0, departmentdetail.length() - 1);
    }
    if (!departmentdetail.equals("")) {
      sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
      sb.append("<table id='reporttable' style='z-index:5%'>");
      sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-SR-3<br>Frequency-Every Year<br>Date-" + Date + "&nbsp;&nbsp;&nbsp;&nbsp;<br></font></td></tr>");
      sb.append("<tr><td style='text-align:center;width:100%;height:20%;'  colspan='2'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Stackholder Relationship<br>Faculty Feedback Transaction Report</u><br><br></font></td></tr>");
      sb.append("<tr><td style='text-align:left;width:100%;height:20%;'    ><hr></hr><br><font size='2'  >Name Of Department : " + departmentdetail + "</font></td></tr>");


      if (!department.equals("ALL")) {
        qry = (" SELECT DISTINCT NVL (a.apfeedbackid, '') feedbackid, NVL (a.transactionid, '') transactionid FROM ap#facultyshfeedbackheader a  WHERE a.departmentcode = '" + department + "' AND a.apacademicyear = '" + academicyear + "'");
      } else {
        qry = (" SELECT DISTINCT NVL (a.apfeedbackid, '') feedbackid, NVL (a.transactionid, '') transactionid FROM ap#facultyshfeedbackheader a  WHERE  a.apacademicyear = '" + academicyear + "'");
      }

      rs = db.getRowset(qry);
      while (rs.next()) {
        feedbackid = rs.getString("feedbackid") == null ? "" : rs.getString("feedbackid").trim();
        transId = transId + "'" + rs.getString("transactionid") + "',";
      }
      if (!transId.equals("")) {
        transId = transId.substring(0, transId.length() - 1);
      } else {
        transId = null;
      }
      qry = ("SELECT distinct nvl(employeename,'') employeename FROM employeemaster WHERE employeeid in (SELECT entryby FROM ap#facultyshfeedbackheader  WHERE transactionid IN  (" + transId + "))");

      rs = db.getRowset(qry);
      while (rs.next()) {
        employeename = employeename + rs.getString("employeename") + ",";
      }
      if (!employeename.equals("")) {
        employeename = employeename.substring(0, employeename.length() - 1);
      } else {
        employeename = null;
      }
      qry = ("select distinct nvl (examcode,'') examcode from ap#shquestionmaster where feedbackid='" + feedbackid + "'");
      rs = db.getRowset(qry);
      if (rs.next()) {
        examcode = rs.getString("examcode");
      }
      sb.append("<tr><td style='text-align:left;width:100%;height:20%;'  nowrap  ><font size='2'  >Academic Year: " + academicyear + "</font><br><hr></hr></td></tr>");
      sb.append("<tr><td style='text-align:left;width:100%;height:20%;'    ><font size='2'  >Faculties Name: " + employeename + "</font><br><hr></hr></td></tr>");

      qry = ("SELECT DISTINCT nvl(a.headid,'') headid, nvl(a.questionid,'') questionid, nvl(a.questionbody,'') questionbody, nvl(a.ratingid,'') ratingid, nvl(b.parentheadid,'') parentheadid,  nvl(a.seqid,'') seqid,nvl(c.SUBJECTIVE,'N') SUBJECTIVE FROM ap#shquestionmaster a, ap#shquestionhead b, ap#shratingmaster c WHERE a.feedbackid = b.feedbackid AND a.feedbackid = '" + feedbackid + "'   AND a.componenttype = 'F'  and " + "a.feedbackid=c.feedbackid and a.RATINGID=c.RATINGID ORDER BY seqid");
      rs = db.getRowset(qry);
      while (rs.next()) {
        i++;
        ratingid = rs.getString("ratingid");
        if (rs.getString("SUBJECTIVE").equals("N"))
        {
          qry1 = (" SELECT distinct(SELECT COUNT (*) RATINGCOUNT   FROM ap#facultyshfeedbackdetail a  WHERE     a.companyid = b.COMPANYCODE    AND a.INSTITUTEID = b.INSTITUTECODE   AND a.apfeedbackid = b.FEEDBACKID   AND a.APFEEDBACKRATINGID = b.RATINGID     AND a.APFEEDBACKRATING = b.EVALUATIONVALUE    AND A.APFEEDBACKRATING = b.rating   And a.apfeedbackid = 'FEED0000003'   AND a.apfeedbackitemid = '" + rs.getString("questionid") + "' " + " AND EXISTS  (SELECT NVL (b.transactionid, '') transactionid   FROM ap#facultyshfeedbackheader b   WHERE b.departmentcode = '" + department + "' AND b.apacademicyear =  '" + academicyear + "' " + "   and b.companyid = a.companyid    and b.instituteid = a.instituteid  and b.transactionid= a.transactionid))    ratingcount,    b.RATINGDESC ratingdesc,  b.seqid " + " FROM AP#SHRATINGDETAIL b   WHERE     b.companycode = '" + company + "'   AND b.institutecode = '" + institute + "'    AND b.RatingId = '" + ratingid + "'    AND b.feedbackid = '" + feedbackid + "' ORDER BY b.Seqid ");
          rs1 = db.getRowset(qry1);
          while (rs1.next()) {
            ratingdetail = ratingdetail + "<td nowrap><font size='2'>" + rs1.getString("ratingdesc") + "</font></td>";
            ratingcount = ratingcount + "<td nowrap><font size='2'>" + rs1.getString("ratingcount") + "</font></td>";
          }
          rating = "<table width='20%' border='1' bordercolor='black'><tr>" + ratingdetail + "</tr><tr>" + ratingcount + "</tr></table>";
        } else {
          qry = ("select wm_concat(APFEEDBACKUSERREMARKS) APFEEDBACKUSERREMARKS from ap#facultyshfeedbackdetail where apfeedbackitemid = '" + rs.getString("questionid") + "' AND apfeedbackid = '" + feedbackid + "' AND " + "transactionid IN (" + transId + ") " + " " + " and apfeedbackratingid='" + rs.getString("ratingid") + "' GROUP BY APFEEDBACKRATING");



          rs1 = db.getRowset(qry);
          if (rs1.next()) {
            rating = rs1.getString("APFEEDBACKUSERREMARKS").trim() + " ";
          } else {
            rating = " ";
          }
        }
        sb.append("<tr><td style='text-align:left;width:25%;height:10%;'  colspan='2'><font size='2'>" + i + "-:" + rs.getString("questionbody") + "-" + rating + "</font></td></tr>");
        rating = "";
        ratingdetail = "";
        ratingcount = "";
      }

      sb.append("<tr><br><br><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><hr></hr><br><br><br><br><br><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
      sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
    } else {
      sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
    }
    return sb.toString();
  }

  @GET
  @Path("FacultyFeedbackCount")
  public String getFacultyFeedbackCount(@QueryParam("examcode") String examcode, @QueryParam("LTP") String ltp, @QueryParam("Feedback") String Feedback) throws SQLException
  {
    String rating = "";
    String parenthead = "";
    String currentdate = "";
    String ltpString = "";
    String qryx = "";
    int i = 0;
    int j = 0;
    ResultSet rsx = null;
    qry = "select to_char(sysdate,'dd-mm-yyyy') currentdate from dual";
    rs = db.getRowset(qry);

    if (rs.next()) {
      currentdate = rs.getString("currentdate");
    }

    if (ltp.equals("ALL")) {
      ltpString = "'P','L'";
    } else if (ltp.equals("L")) {
      ltpString = "'L'";
    } else if (ltp.equals("P")) {
      ltpString = "'P'";
    }

    if (Feedback.equals("N")) {
      qryx = "SELECT  DISTINCT nvl(EMPLOYEECODE,'') EMPLOYEECODE,nvl(EMPLOYEENAME,'') EMPLOYEENAME,nvl(SUBJECTCODE,'') SUBJECTCODE,nvl(SUBJECT,'') SUBJECT,nvl(LTP,'') LTP FROM    AP#FEEDBACKSUBJECTTAGGING A,V#STUDENTLTPDETAIL B, MULTIFACULTYSUBJECTTAGGING c WHERE   A.FSTID not IN (SELECT FSTID FROM AP#FACULTYFEEDBACK WHERE  EXAMCODE='" + examcode + "') AND     A.FSTID=B.FSTID AND    " + " LTP IN (" + ltpString + ") AND   " + "  SUBJECT NOT LIKE '%PROJECT%' AND     SUBJECT NOT LIKE '%DISSERTATION%' AND " + "    SUBJECT NOT LIKE '%INTERNSHIP%' AND     SUBJECT NOT LIKE '%PHD%' AND  " + "   SUBJECT NOT LIKE '%SEMINAR%' AND     SEMESTERTYPE='REG' AND    " + " A.EXAMCODE='" + examcode + "' AND     B.EXAMCODE='" + examcode + "' AND   " + "  A.EXAMCODE=B.EXAMCODE and     a.fstid = c.fstid(+) and   " + "  b.employeeid in (select employeeid from employeemaster where" + " nvl(Deactive,'N')='N') union all SELECT  DISTINCT nvl(EMPLOYEECODE,'') EMPLOYEECODE," + "nvl(EMPLOYEENAME,'') EMPLOYEENAME,nvl(SUBJECTCODE,'') SUBJECTCODE," + "nvl(SUBJECT,'') SUBJECT,nvl(LTP,'') LTP FROM    AP#FEEDBACKSUBJECTTAGGING A," + "V#STUDENTLTPDETAIL B, MULTIFACULTYSUBJECTTAGGING c WHERE " + "  A.FSTID not IN (SELECT FSTID FROM AP#FACULTYFEEDBACK WHERE EXAMCODE='" + examcode + "') " + "AND     A.FSTID=B.FSTID AND     LTP IN (" + ltpString + ") AND     SUBJECT NOT LIKE '%PROJECT%'" + " AND     SUBJECT NOT LIKE '%DISSERTATION%' AND     SUBJECT NOT LIKE '%INTERNSHIP%' AND" + "     SUBJECT NOT LIKE '%PHD%' AND     SUBJECT NOT LIKE '%SEMINAR%' AND   " + "  SEMESTERTYPE='REG' AND     A.EXAMCODE='" + examcode + "' AND     B.EXAMCODE='" + examcode + "' AND" + "     A.EXAMCODE=B.EXAMCODE and     a.fstid = c.fstid and     b.employeeid<> c.employeeid" + " and     b.employeeid in (select employeeid from employeemaster where" + " nvl(Deactive,'N')='N') ORDER BY EMPLOYEENAME,SUBJECT";
      rs = db.getRowset(qryx);
      rs1 = db.getRowset(qryx);
      if (rs1.next()) {
        sb.append("<br><div style='width: 70%; padding: 10px ;border: .2em solid;margin-left:17%;' id=report>");
        sb.append("<table id='reporttable' rules='group' style='z-index:5%'>");
        sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='5' ><font size='2' >Form:QA-PSA-4A<br>Frequency-Every Semester Jan/July<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date-" + currentdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br></font></td><td></td></tr>");
        sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='5' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Stakeholder Relationship<br>Faculty Feedback Count Report</u><br><br></font></td><td></td></tr>");
        sb.append("<tr><th nowrap><font size=2>Sl No.</font></th><th nowrap><font size=2>Employee Code</font></th><th nowrap><font size=2>Employee Name</font></th><th nowrap><font size=2>Subject Code</font></th><th nowrap><font size=2>Subject</font></th><th><font size=2>LTP</font></th></tr>");
        while (rs.next()) {
          i++;
          sb.append("<tr><td nowrap><font size=2>" + i + "</font></td><td nowrap><font size=2>" + (rs.getString("EMPLOYEECODE") == null ? "" : rs.getString("EMPLOYEECODE").toString().trim()) + "</font></td><td><font size=2>" + (rs.getString("EMPLOYEENAME") == null ? "" : rs.getString("EMPLOYEENAME").toString().trim()) + "</td><td><font size=2>" + (rs.getString("SUBJECTCODE") == null ? "" : rs.getString("SUBJECTCODE").toString().trim()) + "</td><td><font size=2>" + (rs.getString("SUBJECT") == null ? "" : rs.getString("SUBJECT").toString().trim()) + "</td><td><font size=2>" + (rs.getString("LTP") == null ? "" : rs.getString("LTP").toString().trim()) + "</td></tr>");
        }
        sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
        sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
      }
      else
      {
        sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
      }
    } else {
      qryx = "SELECT  DISTINCT nvl(EMPLOYEECODE,'') EMPLOYEECODE,nvl(EMPLOYEENAME,'') EMPLOYEENAME,nvl(SUBJECTCODE,'') SUBJECTCODE,nvl(SUBJECT,'') SUBJECT,nvl(LTP,'') LTP FROM    AP#FEEDBACKSUBJECTTAGGING A,V#STUDENTLTPDETAIL B, MULTIFACULTYSUBJECTTAGGING c WHERE   A.FSTID IN (SELECT FSTID FROM AP#FACULTYFEEDBACK WHERE  EXAMCODE='" + examcode + "') AND     A.FSTID=B.FSTID AND    " + " LTP IN (" + ltpString + ") AND   " + "  SUBJECT NOT LIKE '%PROJECT%' AND     SUBJECT NOT LIKE '%DISSERTATION%' AND " + "    SUBJECT NOT LIKE '%INTERNSHIP%' AND     SUBJECT NOT LIKE '%PHD%' AND  " + "   SUBJECT NOT LIKE '%SEMINAR%' AND     SEMESTERTYPE='REG' AND    " + " A.EXAMCODE='" + examcode + "' AND     B.EXAMCODE='" + examcode + "' AND   " + "  A.EXAMCODE=B.EXAMCODE and     a.fstid = c.fstid(+) and   " + "  b.employeeid in (select employeeid from employeemaster where" + " nvl(Deactive,'N')='N') union all SELECT  DISTINCT nvl(EMPLOYEECODE,'') EMPLOYEECODE," + "nvl(EMPLOYEENAME,'') EMPLOYEENAME,nvl(SUBJECTCODE,'') SUBJECTCODE," + "nvl(SUBJECT,'') SUBJECT,nvl(LTP,'') LTP FROM    AP#FEEDBACKSUBJECTTAGGING A," + "V#STUDENTLTPDETAIL B, MULTIFACULTYSUBJECTTAGGING c WHERE " + "  A.FSTID IN (SELECT FSTID FROM AP#FACULTYFEEDBACK WHERE EXAMCODE='" + examcode + "') " + "AND     A.FSTID=B.FSTID AND     LTP IN (" + ltpString + ") AND     SUBJECT NOT LIKE '%PROJECT%'" + " AND     SUBJECT NOT LIKE '%DISSERTATION%' AND     SUBJECT NOT LIKE '%INTERNSHIP%' AND" + "     SUBJECT NOT LIKE '%PHD%' AND     SUBJECT NOT LIKE '%SEMINAR%' AND   " + "  SEMESTERTYPE='REG' AND     A.EXAMCODE='" + examcode + "' AND     B.EXAMCODE='" + examcode + "' AND" + "     A.EXAMCODE=B.EXAMCODE and     a.fstid = c.fstid and     b.employeeid<> c.employeeid" + " and     b.employeeid in (select employeeid from employeemaster where" + " nvl(Deactive,'N')='N') ORDER BY EMPLOYEENAME,SUBJECT";
      rs = db.getRowset(qryx);
      rs1 = db.getRowset(qryx);
      if (rs1.next()) {
        sb.append("<br><div style='width: 70%; padding: 10px ;border: .2em solid;margin-left:17%;' id=report>");
        sb.append("<table id='reporttable' rules='group' style='z-index:5%'>");
        sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='5' ><font size='2' >Form:QA-PSA-4A<br>Frequency-Every Semester Jan/July<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date-" + currentdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br></font></td><td></td></tr>");
        sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='5' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Stakeholder Relationship<br>Faculty Feedback Count Report</u><br><br></font></td><td></td></tr>");
        sb.append("<tr><th nowrap><font size=2>Sl No.</font></th><th nowrap><font size=2>Employee Code</font></th><th nowrap><font size=2>Employee Name</font></th><th nowrap><font size=2>Subject Code</font></th><th nowrap><font size=2>Subject</font></th><th><font size=2>LTP</font></th></tr>");
        while (rs.next()) {
          i++;
          sb.append("<tr><td nowrap><font size=2>" + i + "</font></td><td nowrap><font size=2>" + (rs.getString("EMPLOYEECODE") == null ? "" : rs.getString("EMPLOYEECODE").toString().trim()) + "</font></td><td><font size=2>" + (rs.getString("EMPLOYEENAME") == null ? "" : rs.getString("EMPLOYEENAME").toString().trim()) + "</td><td><font size=2>" + (rs.getString("SUBJECTCODE") == null ? "" : rs.getString("SUBJECTCODE").toString().trim()) + "</td><td><font size=2>" + (rs.getString("SUBJECT") == null ? "" : rs.getString("SUBJECT").toString().trim()) + "</td><td><font size=2>" + (rs.getString("LTP") == null ? "" : rs.getString("LTP").toString().trim()) + "</td></tr>");
        }
        sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
        sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
      }
      else
      {
        sb.append("<center><font color='red' size='2'> There is no report for this criteria,Please choose another</center>");
      }
    }

    return sb.toString();
  }

  @GET
  @Path("FacultyFeedbackSummary")
  public String FacultyFeedbackSummary(@QueryParam("instcode") String instcode, @QueryParam("Feedbackcid") String Feedbackcid, @QueryParam("examcode") String examcode, @QueryParam("userid") String userid) throws SQLException
  {
    String rating = "";
    String parenthead = "";
    String currentdate = "";
    String ltpString = "";
    String qryx = "";
    String qryf = "";
    String FeedbackcidN = "";
    int i = 0;
    int j = 0;
    ResultSet rsx = null;
    ResultSet rsf = null;


    qry = "select to_char(sysdate,'dd-mm-yyyy') currentdate from dual";
    rs = db.getRowset(qry);

    if (rs.next()) {
      currentdate = rs.getString("currentdate");
    }
    try {
      qryf = "SELECT DISTINCT feedbackid FROM ap#facultyfeedbackmaster a  WHERE NVL(deactive,'N')='N' AND NVL(a.eventbroadcast,'Y')='Y' AND NVL(a.eventcompleted,'N')='N'  and EXAMCODE='" + examcode + "'";

      rsf = db.getRowset(qryf);
      if (rsf.next())
      {
        FeedbackcidN = rsf.getString("feedbackid");
      }
    }
    catch (Exception e) {}
    try
    {
      db.FacultyFeedbackSummary(instcode, FeedbackcidN, examcode, userid);
    }
    catch (Exception e) {}

    qryx = "SELECT INSTITUTECODE,nvl(DEPARTMENT,'')DEPARTMENTCODE,COURSECOUNT,NVL (PBL, '') AS PBL12, NVL (CLASSATTEN_G, '0') AS CLASSATTENGC,NVL (CLASSATTEN_S, '0') AS CLASSATTENSc,NVL (CLASSATTEN_U, '0') AS CLASSATTENUc,NVL (DISIPLINE_G, '0') AS DISIPLINEGc,NVL (DISIPLINE_S, '0') AS DISIPLINESc,NVL (DISIPLINE_U, '0') AS DISIPLINEUc, NVL (INTERACTIVE_G, '0') AS INTERACTIVEGc,NVL (INTERACTIVE_S, '0') AS INTERACTIVESc,NVL (INTERACTIVE_U, '0')AS INTERACTIVEUc FROM FACULTYFEEDBACKSUMM WHERE ENTRYBY = '" + userid + "' order by INSTITUTECODE,DEPARTMENTCODE ";

    rs = db.getRowset(qryx);
    rs1 = db.getRowset(qryx);
    if (rs1.next()) {
      sb.append("<br><div align='center' style='width: 80%; padding: 10px ;border: .2em solid;margin-left:10%;' id=report>");
      sb.append("<table align='center' id='reporttable' rules='group' style='z-index:5%' border='0' >");
      sb.append("<tr><td align='right' style='text-align:right;width:20%;height:20%;' colspan='14' ><font size='2' >Form:QA-PSA-4A<br>Frequency-Every Semester Jan/July<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date-" + currentdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp<br></font></td><td></td></tr>");
      sb.append("<tr><td align ='center' style='text-align:center;width:100%;height:20%;' colspan='14' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Research)<br>FacultyFeedBackSummary Report View</u><br><br></font></td><td></td></tr>");
      sb.append("<tr><th colspan='5' style='text-align:center;'><font size=2></font></th><th colspan='3'><font size=2>CLASSATTEND</font></th><th colspan='3'><font size=2>DISIPLINE</font></th><th colspan='3'><font size=2>INTERACTIVE</font></th></tr>");
      sb.append("<tr style='text-align:left;'><th nowrap align='left' ><font size=2>Sl No.</font></th><th nowrap ><font size=2>Institute Code</font></th><th nowrap><font size=2>DEPARTMENT</font></th><th nowrap align='left'><font size=2>NO of Courses(L & P)</font></th><th nowrap colspan='1'><font size=2>PBL(%)</font></th><th><font size=2>G(%)</font></th><th><font size=2>S(%)</font></th><th><font size=2>U(%)</font></th><th><font size=2>G(%)</font></th><th><font size=2>S(%)</font></th><th><font size=2>U(%)</font></th><th><font size=2>G(%)</font></th><th><font size=2>S(%)</font></th><th><font size=2>U(%)</font></th></tr>");
      while (rs.next()) {
        String department = "";
        String COURSECOUNT = "";
        String PBL = "";
        String CLASSATTEN_G = "";
        String CLASSATTEN_S = "";
        String CLASSATTEN_U = "";
        String DISIPLINE_G = "";
        String DISIPLINE_S = "";
        String DISIPLINE_U = "";
        String INTERACTIVE_G = "";
        String INTERACTIVE_S = "";
        String INTERACTIVE_U = "";
        COURSECOUNT = rs.getString("COURSECOUNT");
        PBL = rs.getString("PBL12") == null ? "" : rs.getString("PBL12");
        CLASSATTEN_G = rs.getString("CLASSATTENGC");
        CLASSATTEN_S = rs.getString("CLASSATTENSc");
        CLASSATTEN_U = rs.getString("CLASSATTENUc");
        DISIPLINE_G = rs.getString("DISIPLINEGc");
        DISIPLINE_S = rs.getString("DISIPLINESc");
        DISIPLINE_U = rs.getString("DISIPLINEUc");
        INTERACTIVE_G = rs.getString("INTERACTIVEGc");
        INTERACTIVE_S = rs.getString("INTERACTIVESc");
        INTERACTIVE_U = rs.getString("INTERACTIVEUc");




        i++;
        sb.append("<tr><td nowrap><font size=2>" + i + "</font></td>" + "<td nowrap><font size=2>" + (rs.getString("INSTITUTECODE") == null ? "" : rs.getString("INSTITUTECODE").toString().trim()) + "</font></td>" + "<td ><font size=2>" + (rs.getString("DEPARTMENTCODE") == null ? "" : rs.getString("DEPARTMENTCODE").toString().trim()) + "</td>" + "<td align='left'><font size=2>" + (rs.getString("COURSECOUNT") == null ? "" : rs.getString("COURSECOUNT").toString().trim()) + "</td>" + "<td><font size=2>" + PBL + "</td>" + "<td><font size=2>" + CLASSATTEN_G + "</td>" + "<td><font size=2>" + CLASSATTEN_S + "</td>" + "<td><font size=2>" + CLASSATTEN_U + "</td>" + "<td><font size=2>" + DISIPLINE_G + "</td>" + "<td><font size=2>" + DISIPLINE_S + "</td>" + "<td><font size=2>" + DISIPLINE_U + "</td>" + "<td><font size=2>" + INTERACTIVE_G + "</td>" + "<td><font size=2>" + INTERACTIVE_S + "</td>" + "<td><font size=2>" + INTERACTIVE_U + "</td>" + "</tr>");
      }

      sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
      sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
    }
    else
    {
      sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
    }

    return sb.toString();
  }


//----------------------------------------IT Services Report-----------------------------------------------------------------------------

    @GET
    @Path("ITServicesReport")
    public String ITServicesReport(@QueryParam("instcode") String instcode, @QueryParam("EventCombo") String eventcode, @QueryParam("userid") String userid)
            throws SQLException {
        String rating = "";
        String parenthead = "";
        String currentdate = "";
        String ltpString = "";
        String qryx = "";
        String qryf = "";
        String FeedbackcidN = "";
        int i = 0;
        int j = 0;
        ResultSet rsx = null;
        ResultSet rsf = null;


        qry = "select to_char(sysdate,'dd-mm-yyyy') currentdate from dual";
        rs = db.getRowset(qry);

        if (rs.next()) {
            currentdate = rs.getString("currentdate");
        }
      String selqry="select questionid,questionbody, subjective ,a.ratingid ,PARENTQUESTIONID from AP#ITEVENTQUESTION a ,ap#ratingmaster b " +
              "  where a.ratingid=b.ratingid  and a.INSTITUTECODE='"+instcode+"' and a.ITEVENTID ='"+eventcode+"' " +
              "  and nvl(subjective,'N')<>'Y'   order by a.seqid";



        rsx = db.getRowset(selqry);
        String Qid="",Qname="",issub="",ratingid="",parentId="";
        if(rsx.next()){
            int slno=0;
            sb.append("<br><div align='center' style='width: 80%; padding: 10px ;border: .2em solid;margin-left:10%;' id=report>");
            sb.append("<table align='center' id='reporttable' rules='group' style='z-index:5%' border='0' >");
            sb.append("<tr><td align='right' style='text-align:right;width:20%;height:20%;'  ><font size='2' >Form:QA-PSA-4A<br>Frequency-Every Semester Jan/July<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date-" + currentdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp<br></font></td><td></td></tr>");
            sb.append("<tr><td align ='center' style='text-align:center;width:100%;height:20%;' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Research)<br>Feedback ITServices Report View</u><br><br></font></td><td></td></tr>");
            sb.append("</table>");

            sb.append("<table align='center' id='reporttable' rules='group' style='z-index:5%' border='0' >");
            while(rsx.next()){

            Qid=rsx.getString("questionid");
            Qname=rsx.getString("questionbody");
            issub=rsx.getString("subjective");
            ratingid=rsx.getString("RATINGID");
             parentId=rsx.getString("PARENTQUESTIONID");
             if(parentId!=null){
             sb.append("<tr><td  style='text-align:left;'><font size=2> " +"    -->"+Qname+ "</font></td></tr>");
             }else{
               ++slno;
                sb.append("<tr><td  style='text-align:left;'><font size=2> "+"Question No. "+slno+" . "+Qname+ "</font></td></tr>");
             }


             String selqry1="select c.RATINGDESC, c.EVALUATIONVALUE ,nvl(count_1,0) from (select EVALUATIONVALUE,count(*) count_1 from AP#ITFeedbackheader a, " +
                     "  AP#ITFeedbackdetail b  where a.transid =b.transid and   a.INSTITUTECODE='"+instcode+"' and a.ITEVENTID ='"+eventcode+"'   " +
                     "  and QUESTIONID= '"+Qid+"' group by EVALUATIONVALUE )d ,ap#ratingdetail c where d.EVALUATIONVALUE(+)=c.EVALUATIONVALUE  " +
                     "  and c.ratingid ='"+ratingid+"'    order by SEQID ";

             rsf = db.getRowset(selqry1);
             while(rsf.next()){
             String evalution="",count="";
             evalution=rsf.getString(1);
             count=rsf.getString(3);

             sb.append("<tr><td  style='text-align:center;'><font size=2> "+evalution+ "</font></td>" +
                     "<td  style='text-align:left;'><font size=2> "+count+ "</font></td>" +
                     "</tr>");

             }


            }
            sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
            sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
        }else{

        sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
        }






        return sb.toString();
    }

  
  @GET
  @Path("NonTechFeedBackReport")
  public String getNonTechFeedBackReportReport(@QueryParam("academicyear") String academicyear, @QueryParam("department") String department) throws SQLException
  {
    String ratingid = "";
    String feedbackid = "";
    String parenthead = "";
    String transId = "";
    String rating = "";
    String quesid = "";
    String departmentdetail = "";
    String Date = "";
    String examcode = "";
    String ratingdetail = "";
    String ratingcount = "";
    int i = 0;
    int j = 0;
    qry = "Select to_char(Sysdate,'DD-Mon-yyyy') mTime1 from Dual";

    rs = db.getRowset(qry);
    if (rs.next()) {
      Date = rs.getString("mTime1");
    }
    if (!department.equals("ALL")) {
      qry = (" select distinct nvl(a.department,'') department  from departmentmaster a where a.departmentcode='" + department + "' ");
      rs = db.getRowset(qry);
      if (rs.next()) {
        departmentdetail = rs.getString("department") + " ";
      }
    } else {
      qry = " select distinct nvl(a.department,'') department  from departmentmaster a  ";
      rs = db.getRowset(qry);
      while (rs.next()) {
        departmentdetail = departmentdetail + rs.getString("department") + " , ";
      }
    }


    if (!departmentdetail.equals("")) {
      departmentdetail = departmentdetail.substring(0, departmentdetail.length() - 1);
    }
    if (!departmentdetail.equals("")) {
      sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
      sb.append("<table id='reporttable' style='z-index:5%'>");
      sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-SR-3<br>Frequency-Every Year<br>Date-" + Date + "&nbsp;&nbsp;&nbsp;&nbsp;<br></font></td></tr>");
      sb.append("<tr><td style='text-align:center;width:100%;height:20%;'  colspan='2'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Stackholder Relationship<br>Non-Teching Staff Feedback Form</u><br><br></font></td></tr>");
      sb.append("<tr><td style='text-align:left;width:100%;height:20%;'    ><hr></hr><br><font size='2'  >Name Of Department : " + departmentdetail + "</font></td></tr>");


      if (!department.equals("ALL")) {
        qry = (" SELECT DISTINCT NVL (a.apfeedbackid, '') feedbackid, NVL (a.transactionid, '') transactionid FROM ap#nontechshfeedbackheader a  WHERE a.departmentcode = '" + department + "' AND a.apacademicyear = '" + academicyear + "'");
      } else {
        qry = (" SELECT DISTINCT NVL (a.apfeedbackid, '') feedbackid, NVL (a.transactionid, '') transactionid FROM ap#nontechshfeedbackheader a  WHERE  a.apacademicyear = '" + academicyear + "'");
      }

      rs = db.getRowset(qry);
      while (rs.next()) {
        feedbackid = rs.getString("feedbackid") == null ? "" : rs.getString("feedbackid").trim();
        transId = transId + "'" + rs.getString("transactionid") + "',";
      }
      if (!transId.equals("")) {
        transId = transId.substring(0, transId.length() - 1);
      } else {
        transId = null;
      }

      qry = ("select distinct nvl (examcode,'') examcode from ap#shquestionmaster where feedbackid='" + feedbackid + "'");
      rs = db.getRowset(qry);
      if (rs.next()) {
        examcode = rs.getString("examcode");
      }
      sb.append("<tr><td style='text-align:left;width:100%;height:20%;'  nowrap  ><font size='2'  >Academic Year: " + academicyear + "</font><br><hr></hr></td></tr>");
      qry = ("SELECT DISTINCT nvl(a.headid,'') headid, nvl(a.questionid,'') questionid, nvl(a.questionbody,'') questionbody, nvl(a.ratingid,'') ratingid, nvl(b.parentheadid,'') parentheadid,  nvl(a.seqid,'') seqid,nvl(c.SUBJECTIVE,'N') SUBJECTIVE FROM ap#shquestionmaster a, ap#shquestionhead b, ap#shratingmaster c WHERE a.feedbackid = b.feedbackid and a.headid = b.headid AND a.feedbackid = '" + feedbackid + "'   AND a.componenttype = 'N'  and " + "a.feedbackid=c.feedbackid and a.RATINGID=c.RATINGID ORDER BY seqid");
      rs = db.getRowset(qry);
      while (rs.next()) {
        i++;
        ratingid = rs.getString("ratingid");
        if (rs.getString("SUBJECTIVE").equals("N"))
        {
          qry1 = ("SELECT b.RATINGDESC ratingdesc, b.seqid, (SELECT count(*) RATINGCOUNT FROM ap#nontechshfeedbackdetail a  WHERE A.COMPANYID = B.COMPANYCODE AND A.INSTITUTEid = B.INSTITUTECODE  AND A.APFEEDBACKID = b.feedbackid  and a.apfeedbackitemid =  '" + rs.getString("questionid") + "'  and A.APFEEDBACKRATING = b.rating AND a.transactionid IN (" + transId + " )) ratingcount  " + " FROM AP#SHRATINGDETAIL b where B.RatingId = '" + ratingid + "' AND B.feedbackid = '" + feedbackid + "' " + "AND B.INSTITUTECODE = 'JIIT' AND B.COMPANYCODE = 'UNIV' AND B.EXAMCODE = '" + examcode + "'  ORDER BY b.Seqid DESC  ");
          rs1 = db.getRowset(qry1);
          while (rs1.next()) {
            ratingdetail = ratingdetail + "<td nowrap><font size='2'>" + rs1.getString("ratingdesc") + "</font></td>";
            ratingcount = ratingcount + "<td nowrap><font size='2'>" + rs1.getString("ratingcount") + "</font></td>";
          }

          rating = "<table width='20%' border='1' bordercolor='black'><tr>" + ratingdetail + "</tr><tr>" + ratingcount + "</tr></table>";
        } else {
          qry = ("select wm_concat(APFEEDBACKUSERREMARKS) APFEEDBACKUSERREMARKS from ap#nontechshfeedbackdetail where apfeedbackitemid = '" + rs.getString("questionid") + "' AND apfeedbackid = '" + feedbackid + "' AND " + "transactionid IN (" + transId + ") " + " " + " and apfeedbackratingid='" + rs.getString("ratingid") + "' GROUP BY APFEEDBACKRATING");

          rs1 = db.getRowset(qry);
          if (rs1.next()) {
            rating = rs1.getString("APFEEDBACKUSERREMARKS").trim() + " ";
          } else {
            rating = " ";
          }
        }

        sb.append("<tr><td style='text-align:left;width:25%;height:10%;'  colspan='2'><font size='2'>" + i + "-:" + rs.getString("questionbody") + "-" + rating + "</font></td></tr>");
        rating = "";
        ratingdetail = "";
        ratingcount = "";
      }

      sb.append("<tr><br><br><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><hr></hr><br><br><br><br><br><br><br><br><br><br><font size='2' >(Name and signature)<br><br></font></td></tr>");
      sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
    } else {
      sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
    }
    return sb.toString();
  }

  @POST
  @Path("Faculty_FeedBack_Report_Xl")
  @Produces({"application/msexcel"})
  public Response createXl(@FormParam("fileData") String fileData) throws IOException
  {
    Response.ResponseBuilder response = Response.ok(fileData);
    response.header("Content-Disposition", "attachment; filename=Faculty_FeedBack_Report.xls");
    return response.build();
  }

  @POST
  @Path("FacultyFeedbackReortinPdf")
  @Produces({"application/pdf"})
  public Response ReadPDF(@FormParam("pdfData") String pdfData, @FormParam("filename") String filename) throws IOException
  {
    ByteArrayOutputStream out = new ByteArrayOutputStream();
    downloadAdmissionPdf(out, pdfData);
    Response.ResponseBuilder response = Response.ok(out.toByteArray());
    response.header("Content-Disposition", "inline; filename=" + filename.replace(" ", "_") + ".pdf");
    return response.build();
  }

  private void downloadAdmissionPdf(ByteArrayOutputStream out, String html) {
    try {
      ByteArrayOutputStream bstream = new ByteArrayOutputStream();
      Document document = new Document(PageSize.A4, 20.0F, 20.0F, 20.0F, 20.0F);
      PdfWriter pdfWriter = PdfWriter.getInstance(document, bstream);

      document.addAuthor("Campus Lynx");
      document.addCreator("JILIT");
      document.addSubject("Faculty Feedback Report");
      document.addCreationDate();
      document.addTitle("Faculty Feedback Report");
      document.open();
      HTMLWorker htmlWorker = new HTMLWorker(document);
      htmlWorker.parse(new StringReader(html));
      document.close();
      pdfWriter.close();
      bstream.writeTo(out);
      out.flush();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      html = null;
      System.gc();
    }
  }
}