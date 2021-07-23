/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class BBAApplicantDetailDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private ResultSet rs;
    public BBAApplicantDetailDB() {
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

            switch (BBAApplicantDetailDB.scase.valueOf((String) hm.get("handller").toString())) {
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
            sqry.append("select a.APPLICATIONSLNO,APPLICATIONNO,STUDENTNAME,");
            sqry.append(" FATHERNAME,to_char(DATEOFBIRTH,'dd-mm-yyyy')DATEOFBIRTH,CATEGORY,SEX GENDER,");
            sqry.append(" ADDRESS1,ADDRESS2,CITY,STATENAME,PIN,PHONE,EMAILID,");
            sqry.append(" C#M.CHEQUEDDNO,to_char(C#M.CHEQUEDDDATE,'dd-mm-yyyy')CHEQUEDDDATE,C#M.CHQDDTYPE,C#M.AMOUNT,C#M.BANKNAME,");
            sqry.append("C.PERCENTAGE,  C.BOARD,TWE.PERCENTAGE, TWE.BOARD,TEN.PERCENTAGE, TEN.BOARD");
            sqry.append(" from c#bbaapplicationmaster a,C#BBAAPPLICANTADDRESS b,C#BBAQUALIFICATION C, C#BBAQUALIFICATION TEN,  C#BBAQUALIFICATION TWE, C#STATEMASTER D,C#BBAFEE C#M ");
            sqry.append(" where a.applicationslno=b.applicationslno(+)");
            sqry.append(" AND a.applicationslno=C.applicationslno(+)");
            sqry.append(" AND a.applicationslno=TEN.applicationslno(+)");
            sqry.append(" AND a.applicationslno=TWE.applicationslno(+)");
            sqry.append(" AND A.APPLICATIONSLNO = C#M.APPLICATIONSLNO(+)");
            sqry.append(" AND C.QUALIFICATIONCODE  in ('12TH','12th') ");
            sqry.append("AND TWE.QUALIFICATIONCODE = '12TH'");
            sqry.append("AND TEN.QUALIFICATIONCODE = '10TH'");
            sqry.append(" AND B.STATE=D.STATECODE");
            if(hm.get("admissionYear")!=null && !hm.get("admissionYear").equals("") && !hm.get("admissionYear").equals("0")){
            sqry.append(" AND A.APPLICATIONslNO like '").append(hm.get("admissionYear")).append("%' ");
            }
            if(hm.get("applicationType")!=null && !hm.get("applicationType").equals("") && !hm.get("applicationType").equals("0") && hm.get("applicationType").equals("ON")){
            sqry.append(" AND (SUBSTR(APPLICATIONNO,1,3)='INT' OR SUBSTR(APPLICATIONNO,1,3) LIKE 'MBO%') ");
            }
            if(hm.get("applicationType")!=null && !hm.get("applicationType").equals("") && !hm.get("applicationType").equals("0") && hm.get("applicationType").equals("OF")){
            sqry.append(" AND SUBSTR(APPLICATIONNO,1,3) NOT IN 'INT' AND SUBSTR(APPLICATIONNO,1,3) NOT LIKE 'MBO%' ");
            }
            if(hm.get("sortBy")!=null && !hm.get("sortBy").equals("") && !hm.get("sortBy").equals("0") && hm.get("sortBy").equals("ASN")){
            sqry.append(" ORDER BY APPLICATIONSLNO ");
            }
            if(hm.get("sortBy")!=null && !hm.get("sortBy").equals("") && !hm.get("sortBy").equals("0") && hm.get("sortBy").equals("AN")){
            sqry.append(" ORDER BY APPLICATIONNO ");
            }
            if(hm.get("sortBy")!=null && !hm.get("sortBy").equals("") && !hm.get("sortBy").equals("0") && hm.get("sortBy").equals("SN")){
            sqry.append(" ORDER BY STUDENTNAME ");
            }

            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("applicationSLNO", (rs.getString(1)==null?"":rs.getString(1)));
                data.put("applicationNO", (rs.getString(2)==null?"":rs.getString(2)));
                data.put("studentName", (rs.getString(3)==null?"":rs.getString(3)));
                data.put("fatherName", (rs.getString(4)==null?"": rs.getString(4)));
                data.put("dateOfBirth", (rs.getString(5)==null?"":rs.getString(5)));
                data.put("category", (rs.getString(6)==null?"":rs.getString(6)));
                data.put("gender", (rs.getString(7)==null?"":rs.getString(7)));
                data.put("address1", (rs.getString(8)==null?"":rs.getString(8)));
                data.put("address2", (rs.getString(9)==null?"":rs.getString(9)));
                data.put("city", (rs.getString(10)==null?"":rs.getString(10)));
                data.put("stateName", (rs.getString(11)==null?"":rs.getString(11)));
                data.put("pin", (rs.getString(12)==null?"":rs.getString(12)));
                data.put("phone", (rs.getString(13)==null?"":rs.getString(13)));
                data.put("emailID", (rs.getString(14)==null?"":rs.getString(14)));  
                data.put("chequeDDNo",(rs.getString(15)==null?"":rs.getString(15)));
                data.put("chequeDDDate",(rs.getString(16)==null?"":rs.getString(16)));
                data.put("chequeDDType",(rs.getString(17)==null?"":rs.getString(17)));
                data.put("amount",(rs.getString(18)==null?"":rs.getString(18)));
                data.put("bankName",(rs.getString(19)==null?"":rs.getString(19)));                
                data.put("twePer",(rs.getString(22)==null?"":rs.getString(20)));
                data.put("tweBrd",(rs.getString(23)==null?"":rs.getString(21)));
                data.put("tenPer",(rs.getString(24)==null?"":rs.getString(22)));
                data.put("tenBrd",(rs.getString(25)==null?"":rs.getString(23)));

                tm.put(k, data);
                k++;
            }
             //total=String.valueOf(k);
            if(tm.isEmpty())
        {
            tm.put("0","0");
        }

            System.out.println("total--"+tm.size());
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
    sb.append("<html><body><table boder='1'><tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Application SL No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Application No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Student Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Father Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Date of Birth</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Category</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Gender</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:6%'>Address1</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:6%'>Address2</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>City</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>State</font></td><td nowrap><b><font color='white' size='1' style='font-family:arial;width:3%'>Pin</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Phone No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Email ID</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Cheque DD No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Cheque DD Date</font></td> <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Cheque DD Type</font></td> <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Amount</font></td> <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Bank Name</font></td> <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>12th Per(%)</font></td> <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>12th BOARD</font></td> <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>10th Per(%)</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>BOARD</font></td></tr>");
for(int i=1;i<=data.size();i++){
       sb.append("<tr><td  style='width: 1%'><font size='1' style='font-family:arial'>").append(i).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("applicationSLNO")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append("&nbsp;"+((HashMap) data.get(i)).get("applicationNO")).append("</font></td>");
       sb.append("<td  style='width: 3%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("studentName")).append("</font></td>");
       sb.append("<td  style='width: 3%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("fatherName")).append("</font></td>");
       sb.append("<td  style='width: 3%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("dateOfBirth")).append("</font></td>");
       sb.append("<td  style='width: 3%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("category")).append("</font></td>");
       sb.append("<td  style='width: 1%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("gender")).append("</font></td>");
       sb.append("<td  style='width: 6%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("address1")).append("</font></td>");
       sb.append("<td  style='width: 6%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("address2")).append("</font></td>");
       sb.append("<td  style='width: 3%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("city")).append("</font></td>");
       sb.append("<td  style='width: 3%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("stateName")).append("</font></td>");
       sb.append("<td  style='width: 3%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("pin")).append("</font></td>");
       sb.append("<td  style='width: 3%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("phone")).append("</font></td>");
       sb.append("<td  style='width: 3%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("emailID")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("chequeDDNo")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("chequeDDDate")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("chequeDDType")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("amount")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("bankName")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("twePer")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("tweBrd")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("tenPer")).append("</font></td>");
       sb.append("<td  style='width: 2%'><font size='1' style='font-family:arial'>").append(((HashMap) data.get(i)).get("tenBrd")).append("</font></td></tr>");

}
sb.append("</table></body></html>");
   return sb.toString();
}
}
