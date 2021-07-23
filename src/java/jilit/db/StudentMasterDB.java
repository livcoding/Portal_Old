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
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class StudentMasterDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public StudentMasterDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
       generateReport,exportReport
    }
    
     
     public String selectSaveUpdateData(HttpServletRequest request, HttpServletResponse response) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(request.getParameter("jdata"), new TypeReference<HashMap>() {});

            switch (StudentMasterDB.scase.valueOf((String) hm.get("handller").toString())) {
                case generateReport:
                    responseString = mapper.writeValueAsString(generateReport(hm));
                    break;
                case exportReport:
                     response.reset();
                     response.setContentType("application/vnd.ms-excel");
                     response.setHeader("Content-Disposition", "attachment;filename=studentMaster.xls");
                     responseString =  exportReport(hm);
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
            
            
            sqry.append("select distinct NVL(A.INSTITUTECODE,'') ,NVL(A.ACADEMICYEAR,''),NVL(A.ENROLLMENTNO,''),NVL(A.STUDENTNAME,'') ,NVL(A.PROGRAMCODE,''),NVL(A.BRANCHCODE,'')");
            sqry.append(",NVL(A.SUBSECTIONCODE,''),NVL(A.SEMESTER,''),A.DEACTIVE DEACTIVESTATUS,to_char(A.DATEOFBIRTH,'dd-mm-yyyy'),");
            sqry.append("A.FATHERNAME,A.QUOTA,B.REGCONFIRMATION REGISTRATIONCONFIRMATION ,C.STCELLNO STUDENTPHONENUMBER,C.STEMAILID STUDENTEMAILID ,");
            sqry.append("D.CADDRESS1||','||D.CADDRESS2||','||D.CADDRESS3||','||D.CDISTRICT||','||D.CSTATE AS CURRENTADDRESS,");
            sqry.append("D.PADDRESS1||','||D.PADDRESS2||','||D.PADDRESS3||','||D.PDISTRICT||','||D.PSTATE AS PURMANENTADDRESS, B.EXAMCODE, A.SEX");
            sqry.append(" from studentmaster A,STUDENTREGISTRATION B , STUDENTPHONE C ,STUDENTADDRESS D");
            sqry.append(" where ");
            if(!hm.get("instituteCode").equals("ALL")){        
            sqry.append("A.INSTITUTECODE ='"+hm.get("instituteCode")+"' AND ");
            }
            if(!hm.get("academicYear").equals("ALL")){
            sqry.append(" A.ACADEMICYEAR ='"+hm.get("academicYear")+"' AND ");
            }
            if(!hm.get("programCode").equals("ALL") && hm.get("programCode")!=null && !hm.get("programCode").equals("") && !hm.get("programCode").equals("0")){
            sqry.append(" A.PROGRAMCODE ='"+hm.get("programCode")+"' AND ");
            }
            if(!hm.get("branchCode").equals("ALL") && hm.get("branchCode")!=null && !hm.get("branchCode").equals("") && !hm.get("branchCode").equals("0")){
            sqry.append(" A.BRANCHCODE ='"+hm.get("branchCode")+"' AND ");
            }
            if(!hm.get("deactive").equals("ALL") && !hm.get("deactive").equals("0")){
            sqry.append(" NVL(A.DEACTIVE,'N')='"+hm.get("deactive")+"' AND ");
            }
            if(!hm.get("regConfirmation").equals("ALL") && !hm.get("regConfirmation").equals("0")){
            sqry.append(" b.regconfirmation ='"+hm.get("regConfirmation")+"' AND ");
            }
            if(hm.get("examCode")!=null && !hm.get("examCode").equals("") && !hm.get("examCode").equals("0"))
            {
            sqry.append(" b.EXAMCODE ='"+hm.get("examCode")+"' AND ");   
            }
            if(!hm.get("quota").equals("ALL") && hm.get("quota")!=null && !hm.get("quota").equals("") && !hm.get("quota").equals("0"))
            {
            sqry.append(" A.QUOTA ='"+hm.get("quota")+"' AND ");   
            }
            if(!hm.get("gender").equals("ALL") && !hm.get("gender").equals("0")){
            sqry.append(" A.SEX ='"+hm.get("gender")+"' AND ");
            }
            sqry.append(" A.STUDENTID =B.STUDENTID ");
            sqry.append("AND A.STUDENTID =C.STUDENTID(+) ");
            sqry.append("AND A.STUDENTID =D.STUDENTID(+) ");
            sqry.append("AND A.ACADEMICYEAR=B.ACADEMICYEAR ");
            
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("instituteCode", (rs.getString(1)==null?"":rs.getString(1)));
                data.put("academicYear", (rs.getString(2)==null?"":rs.getString(2)));
                data.put("enrollmentNo", (rs.getString(3)==null?"":rs.getString(3)));
                data.put("studentName", (rs.getString(4)==null?"": rs.getString(4)));
                data.put("programCode", (rs.getString(5)==null?"":rs.getString(5)));
                data.put("branchCode", (rs.getString(6)==null?"":rs.getString(6)));
                data.put("subSectionCode", (rs.getString(7)==null?"":rs.getString(7)));
                data.put("Semester", (rs.getString(8)==null?"":rs.getString(8)));
                data.put("deactive", (rs.getString(9)==null?"":rs.getString(9)));
                data.put("dateOfBirth", (rs.getString(10)==null?"":rs.getString(10)));
                data.put("fatherName", (rs.getString(11)==null?"":rs.getString(11)));
                data.put("quota", (rs.getString(12)==null?"":rs.getString(12)));
                data.put("regConfirmation", (rs.getString(13)==null?"":rs.getString(13)));
                data.put("phoneNo", (rs.getString(14)==null?"":rs.getString(14)));
                data.put("mailID", (rs.getString(15)==null?"":rs.getString(15)));
                data.put("currentAddress", (rs.getString(16)==null?"":rs.getString(16)));
                data.put("permanentAddress",(rs.getString(17)==null?"":rs.getString(17)));
                data.put("examCode",(rs.getString(18)==null?"":rs.getString(18)));
                data.put("gender",(rs.getString(19)==null?"":rs.getString(19)));
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
    sb.append("<html><body><table boder='1'><tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Institute Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Academic Year</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Enrollment No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Enrollment No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Student Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Program Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Branch Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Subsection Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Semester</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Deactive</font></td><td nowrap><b><font color='white' size='1' style='font-family:arial;width:5%'>Date of Birth</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Father Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Quota</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Reg Confirmation</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Phone Number</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Mail ID</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Current Address</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Permanent Address</font></td>");
for(int i=1;i<=data.size();i++){
        sb.append("<tr><td  style='width: 2%'><font size='1' style='font-family:arial'>").append(i).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("instituteCode")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("academicYear")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("enrollmentNo")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("examCode")).append("</font></td><td  style='width: 8%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("studentName")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("programCode")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("branchCode")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("subSectionCode")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("Semester")).append("</font></td>");
        sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("deactive")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("dateOfBirth")).append("</font></td><td  style='width: 8%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("fatherName")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("quota")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("regConfirmation")).append("</font></td><td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("phoneNo")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("mailID")).append("</font></td><td  style='width: 10%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("currentAddress")).append("</font></td><td  style='width:10%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("permanentAddress")).append("</font></td>");
}
sb.append("</table></body></html>");
   return sb.toString();
}

}
