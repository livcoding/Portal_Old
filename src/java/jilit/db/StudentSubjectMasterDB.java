/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class StudentSubjectMasterDB {
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public StudentSubjectMasterDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
       generateReport,exportReport,exportSubjects
    }
    
     
     public String selectSaveUpdateData(HttpServletRequest request, HttpServletResponse response) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(request.getParameter("jdata"), new TypeReference<HashMap>() {});

            switch (StudentSubjectMasterDB.scase.valueOf((String) hm.get("handller").toString())) {
                case generateReport:
                    responseString = mapper.writeValueAsString(generateReport(hm));
                    break;
                case exportReport:
                    response.reset();
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-Disposition", "attachment;filename=studentSubjectMaster.xls");
                    responseString = exportReport(hm);
                    break;
                case exportSubjects:
                    response.reset();
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-Disposition", "attachment;filename=registeredSubjects.xls");
                    responseString = exportSubjects(hm);
                    break;
                
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
      private Map generateReport(Map hm) {
        Map data = new HashMap();
        Map tm = new HashMap();
        String searchBoxValue = "",total="";
        StringBuilder sqry = new StringBuilder();
        StringBuilder sqry1=new StringBuilder();
        int k = 1;
       
        try {
            
            
            sqry.append("select INSTITUTECODE,EMPLOYEENAME ,EMPLOYEECODE, ACADEMICYEAR,");
            sqry.append("EXAMCODE,PROGRAMCODE,SECTIONBRANCH,SUBSECTIONCODE,");
            sqry.append("SEMESTER,SEMESTERTYPE,SUBJECTTYPE,SUBJECTCODE,SUBJECT ,LTP ,");
            sqry.append("ENROLLMENTNO,STUDENTNAME, STUDENTDEACTIVE AS STUDENTDEACTIVESTATUS from v#studentltpdetail");
            sqry.append(" where ");
            sqry.append("INSTITUTECODE ='"+hm.get("instituteCode")+"' AND ");
            sqry.append("EXAMCODE ='"+hm.get("examCode")+"' AND ");
            sqry.append("LTP ='"+hm.get("ltp")+"' AND ");
            sqry.append("NVL(STUDENTDEACTIVE,'N')='"+hm.get("deactive")+"' AND ");
            sqry.append("SUBJECTID='"+hm.get("subject")+"'");
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("instituteCode", (rs.getString(1)==null?"":rs.getString(1)));
                data.put("employeeName", (rs.getString(2)==null?"":rs.getString(2)));
                data.put("employeeCode", (rs.getString(3)==null?"":rs.getString(3)));
                data.put("academicYear", (rs.getString(4)==null?"": rs.getString(4)));
                data.put("examCode", (rs.getString(5)==null?"":rs.getString(5)));
                data.put("programCode", (rs.getString(6)==null?"":rs.getString(6)));
                data.put("sectionBranch", (rs.getString(7)==null?"":rs.getString(7)));
                data.put("subsectionCode", (rs.getString(8)==null?"":rs.getString(8)));
                data.put("semester", (rs.getString(9)==null?"":rs.getString(9)));
                data.put("semesterType", (rs.getString(10)==null?"":rs.getString(10)));
                data.put("subjectType", (rs.getString(11)==null?"":rs.getString(11)));
                data.put("subjectCode", (rs.getString(12)==null?"":rs.getString(12)));
                data.put("subject", (rs.getString(13)==null?"":rs.getString(13)));
                data.put("ltp", (rs.getString(14)==null?"":rs.getString(14)));
                data.put("enrollmentNo", (rs.getString(15)==null?"":rs.getString(15)));
                data.put("studentName", (rs.getString(16)==null?"":rs.getString(16)));
                data.put("deactive",(rs.getString(17)==null?"":rs.getString(17)));
                tm.put(k, data);
                k++;
            }
             //total=String.valueOf(k);
            if(tm.isEmpty())
        {
            tm.put("0","0");
        }
       tm.put("totalrecords", tm.size());
       
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return tm;
    }

private String exportReport(Map hm){
  Map data= generateReport(hm);
  data.remove("totalrecords");
  StringBuilder sb=new StringBuilder();
    sb.append("<html><body><table boder='1'><tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Institute Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Employee Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Employee Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Academic Year</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Exam Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Program Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Section Branch</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Subsection Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Semester</font></td><td nowrap><b><font color='white' size='1' style='font-family:arial;width:5%'>Semester Type</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Subject Type</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Subject Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:13%'>Subject</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>LTP</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Enrollment No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:10%'>Student Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Student Deactive</font></td></tr>");
for(int i=1;i<=data.size();i++){
        sb.append("<tr><td  style='width: 2%'><font size='1' style='font-family:arial'>").append(i).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("instituteCode")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("employeeName")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("employeeCode")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("academicYear")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("examCode")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("programCode")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("sectionBranch")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("subsectionCode")).append("</font></td>");
        sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("semester")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("semesterType")).append("</font></td><td  style='width: 8%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("subjectType")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("subjectCode")).append("</font></td><td  style='width: 13%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("subject")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("ltp")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("enrollmentNo")).append("</font></td><td  style='width: 10%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("studentName")).append("</font></td><td  style='width:5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("deactive")).append("</font></td></tr>");
}
sb.append("</table></body></html>");
   return sb.toString();
}


    private String exportSubjects(Map hm) {
        Map data = new HashMap();
        Map tm = new HashMap();
        String sqry = "";
        int k = 1;
        try {
            if(hm.get("subject").equals("ALL")){

             sqry = "select distinct nvl(A.SUBJECTCODE,'')SUBJECTCODE ,NVL(A.SUBJECT,'')SUBJECT,count(studentid) studentcount from v#studentltpdetail A  where institutecode='" + hm.get("instituteCode") + "' and examcode='" + hm.get("examCode") + "' and LTP='" + hm.get("ltp") +  "'group by a.subjectcode ,a.subject order by SUBJECT";
             pStmt = dbConnection.prepareStatement(sqry.toString());
             rs = pStmt.executeQuery();

            }else{
            sqry = "select distinct nvl(A.SUBJECTCODE,'')SUBJECTCODE ,NVL(A.SUBJECT,'')SUBJECT,count(studentid) studentcount from v#studentltpdetail A  where institutecode='" + hm.get("instituteCode") + "' and examcode='" + hm.get("examCode") + "' and LTP='" + hm.get("ltp") +  "' and SUBJECTID= '"+hm.get("subject")+"' group by a.subjectcode ,a.subject order by SUBJECT";
            
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            }
            while (rs.next()) {
                data = new HashMap();
                data.put("subjectCode", (rs.getString(1) == null ? "" : rs.getString(1)));
                data.put("subject", (rs.getString(2) == null ? "" : rs.getString(2)));
                data.put("studentcount", (rs.getString(3) == null ? "" : rs.getString(3)));
                tm.put(k, data);
                k++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        StringBuilder sb = new StringBuilder();
        sb.append("<html><body><table boder='1'><tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:49%'>Subject Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:49%'>Subject</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:49%'>Student Count</font></td></tr>");
        for (int i = 1; i <= tm.size(); i++) {
            sb.append("<tr><td  style='width: 2%'><font size='1' style='font-family:arial'>").append(i).append("</font></td><td  style='width: 49%'><font size='1' style='font-family:arial'>").append(((HashMap) tm.get(i)).get("subjectCode")).append("</font></td><td  style='width: 49%'><font size='1' style='font-family:arial'>").append(((HashMap) tm.get(i)).get("subject")).append("</font></td><td  style='width: 49%'><font size='1' style='font-family:arial'>").append(((HashMap) tm.get(i)).get("studentcount")).append("</font></td></tr>");
        }
        sb.append("</table></body></html>");
        return sb.toString();
    }
}
