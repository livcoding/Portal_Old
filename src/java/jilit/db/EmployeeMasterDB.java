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
public class EmployeeMasterDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public EmployeeMasterDB() {
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

            switch (EmployeeMasterDB.scase.valueOf((String) hm.get("handller").toString())) {
                case generateReport:
                    responseString = mapper.writeValueAsString(generateReport(hm));
                    break;
                case exportReport:
                     response.reset();
                     response.setContentType("application/vnd.ms-excel");
                     response.setHeader("Content-Disposition", "attachment;filename=employeeMaster.xls");
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
            sqry.append("SELECT A.COMPANYCODE,A.EMPLOYEECODE,A.EMPLOYEENAME,A.FATHERNAME,C.DESIGNATION,D.DEPARTMENT,");
            sqry.append("a.basicpay,to_char(A.DATEOFBIRTH,'dd-mm-yyyy')DATEOFBIRTH,to_char(A.DATEOFJOINING,'dd-mm-yyyy')DATEOFJOINING,A.EMPLOYEETYPE,A.GRADEcode,A.CATEGORYCODE,A.EMPCATEGORYCODE,A.SEX");
            sqry.append(" AS GENDER,NVL(A.DEACTIVE,'N')ASDEACTIVESTATUS,");
            sqry.append(" B.CADDRESS1||','||B.CADDRESS2||','||B.CADDRESS3||','||B.CCITY");
            sqry.append(" AS CURRENTADDRESS,B.CDISTRICT AS CURRENTDISTRICT,B.CSTATE AS CURRENTSTATE,");
            sqry.append(" B.PADDRESS1||','||B.PADDRESS2||','||B.PADDRESS3||','||B.PCITY");
            sqry.append(" AS PERMANENTADDRESS ,PDISTRICT AS PERMANENTDISTRICT,PSTATE AS PERMANENTSTATE,");
            sqry.append(" B.PPHONENOS,B.MOBILE,B.OFFICEPHONENOS,B.EMAILID ");
            sqry.append(" FROM EMPLOYEEMASTER A,EMPLOYEEADDRESS B ,DESIGNATIONMASTER C,DEPARTMENTMASTER D");
            sqry.append(" WHERE"); 
            if(hm.get("companyCode")!=null && !hm.get("companyCode").equals("") && !hm.get("companyCode").equals("ALL") ){
            sqry.append(" A.COMPANYCODE='").append(hm.get("companyCode")).append("' AND");
            }
            if(!hm.get("deactive").equals("ALL") && !hm.get("deactive").equals("0")){
            sqry.append(" NVL(A.DEACTIVE,'N')='").append(hm.get("deactive")).append("' AND ");
            }
            if(hm.get("employeeType")!=null && !hm.get("employeeType").equals("") && !hm.get("employeeType").equals("ALL") ){
            sqry.append(" A.EMPLOYEETYPE ='").append(hm.get("employeeType")).append("' AND ");
            }
            if(hm.get("designation")!=null && !hm.get("designation").equals("") && !hm.get("designation").equals("ALL") && !hm.get("designation").equals("0") ){
            sqry.append(" C.DESIGNATIONCODE ='").append(hm.get("designation")).append("' AND ");
            }
            if(hm.get("department")!=null && !hm.get("department").equals("") && !hm.get("department").equals("ALL") && !hm.get("department").equals("0") ){
            sqry.append(" D.DEPARTMENTCODE ='").append(hm.get("department")).append("' AND ");
            }
            if(hm.get("grade")!=null && !hm.get("grade").equals("") && !hm.get("grade").equals("ALL") && !hm.get("grade").equals("0") ){
            sqry.append(" A.GRADECODE ='").append(hm.get("grade")).append("' AND ");
            }
            if(!hm.get("gender").equals("ALL") && !hm.get("gender").equals("0")){
            sqry.append(" A.SEX ='").append(hm.get("gender")).append("' AND ");
            }
            sqry.append("  A.EMPLOYEEID=B.EMPLOYEEID(+)");
            sqry.append(" AND A.DESIGNATIONCODE=C.DESIGNATIONCODE AND A.DEPARTMENTCODE=D.DEPARTMENTCODE");
            sqry.append(" ORDER BY COMPANYCODE");
            
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("companyCode", (rs.getString(1)==null?"":rs.getString(1)));
                data.put("employeeCode", (rs.getString(2)==null?"":rs.getString(2)));
                data.put("employeeName", (rs.getString(3)==null?"":rs.getString(3)));
                data.put("fatherName", (rs.getString(4)==null?"": rs.getString(4)));
                data.put("designation", (rs.getString(5)==null?"":rs.getString(5)));
                data.put("department", (rs.getString(6)==null?"":rs.getString(6)));
                data.put("basicPay", (rs.getString(7)==null?"":rs.getString(7)));
                data.put("dateOfBoirth", (rs.getString(8)==null?"":rs.getString(8)));
                data.put("dateOfJoining", (rs.getString(9)==null?"":rs.getString(9)));
                data.put("employeeType", (rs.getString(10)==null?"":rs.getString(10)));
                data.put("gradeCode", (rs.getString(11)==null?"":rs.getString(11)));
                data.put("categoryCode", (rs.getString(12)==null?"":rs.getString(12)));
                data.put("empCategoryCode", (rs.getString(13)==null?"":rs.getString(13)));
                data.put("gender", (rs.getString(14)==null?"":rs.getString(14)));
                data.put("deactive", (rs.getString(15)==null?"":rs.getString(15)));
                data.put("currentAddress", (rs.getString(16)==null?"":rs.getString(16)));
                data.put("currentDistrict", (rs.getString(17)==null?"":rs.getString(17)));
                data.put("currentState", (rs.getString(18)==null?"":rs.getString(18)));
                data.put("permanentAddress", (rs.getString(19)==null?"":rs.getString(19)));
                data.put("permanentDistrict", (rs.getString(20)==null?"":rs.getString(20)));
                data.put("permanentState", (rs.getString(21)==null?"":rs.getString(21)));
                data.put("phoneNo", (rs.getString(22)==null?"":rs.getString(22)));
                data.put("mobile", (rs.getString(23)==null?"":rs.getString(23)));
                data.put("officePhone", (rs.getString(24)==null?"":rs.getString(24)));
                data.put("emailID",(rs.getString(25)==null?"":rs.getString(25)));
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
    sb.append("<html><body><table boder='1'><tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Company Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Employee Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Employee Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Father Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Designation</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Department</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Basic Pay</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Date of Birth</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Date of Joining</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Employee Type</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Grade</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Category Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Emp. Category Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Gender</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Deactive</font></td><td nowrap><b><font color='white' size='1' style='font-family:arial;width:7%'>Current Address</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Current District</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Current State</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:7%'>Permanent Address</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Permanent District</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Permanent State</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Phone No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Mobile</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Office Phone</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Email ID</font></td></tr>");
for(int i=1;i<=data.size();i++){
        sb.append("<tr><td  style='width: 2%'><font size='1' style='font-family:arial'>").append(i).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("companyCode")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("employeeCode")).append("</font></td>");
        sb.append("<td  style='width: 7%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("employeeName")).append("</font></td>");
        sb.append("<td  style='width: 7%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("fatherName")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("designation")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("department")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("basicPay")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("dateOfBoirth")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("dateOfJoining")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("employeeType")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("gradeCode")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("categoryCode")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("empCategoryCode")).append("</font></td>");
        sb.append("<td  style='width: 4%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("gender")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("deactive")).append("</font></td>");
        sb.append("<td  style='width: 10%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("currentAddress")).append("</font></td>");
        sb.append("<td  style='width: 10%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("currentDistrict")).append("</font></td>");
        sb.append("<td  style='width: 10%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("currentState")).append("</font></td>");
        sb.append("<td  style='width: 10%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("permanentAddress")).append("</font></td>");
        sb.append("<td  style='width: 10%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("permanentDistrict")).append("</font></td>");
        sb.append("<td  style='width: 10%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("permanentState")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("phoneNo")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("mobile")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("officePhone")).append("</font></td>");
        sb.append("<td  style='width: 5%'><font size='1' style='font-family:arial'>").append(((HashMap)data.get(i)).get("emailID")).append("</font></td></tr>");
}
sb.append("</table></body></html>");
   return sb.toString();
}
}
