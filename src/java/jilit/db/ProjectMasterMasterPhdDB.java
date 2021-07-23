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
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class ProjectMasterMasterPhdDB {
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public ProjectMasterMasterPhdDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectSupervisorInfo,selectStudentInfo,saveupdate, select,SelectforUpdate,setDepartment
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (ProjectMasterMasterPhdDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectSupervisorInfo:
                    responseString = mapper.writeValueAsString(selectSupervisorInfo(hm));
                    break;
                case selectStudentInfo:
                    responseString = mapper.writeValueAsString(selectStudentInfo(hm));
                    break;
                case saveupdate:
                    responseString =SaveUpdateData(hm);
                    break;
                case select:
                    responseString = mapper.writeValueAsString(getSelectData(hm));
                    break;
                case SelectforUpdate:
                    responseString = mapper.writeValueAsString(selectForUpdate(hm));
                    break;
                case setDepartment:
                    responseString = mapper.writeValueAsString(selectDepartment(hm));
                    break;    
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     private Map selectSupervisorInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();
        try {
            
            if(!hm.get("searchNames").equals("")){
              searchBoxValue="and (vs.employeename like '%"+hm.get("searchNames")+"%')";
              }
            
                sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (employeeid) Totalrecord FROM v#staff where nvl(deactive,'N')='N' and employeeid in(select employeeid from employeemaster where employeetype='TEC') and companycode='"+hm.get("companyID")+"') a,\n"
                        +"(SELECT * FROM ( select nvl(vs.employeeid,'')employeeid,nvl(vs.employeecode,'')employeecode,nvl(vs.employeename,'')employeename,ROWNUM R "
                        + "from v#staff vs where nvl(vs.deactive,'N')='N' and employeeid in(select employeeid from employeemaster where employeetype='TEC' and companycode='"+hm.get("companyID")+"') "
                        + ""+searchBoxValue+" order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                
                int k = 1;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("totalrecords",rs.getString(1));
                        SelectData.put("employeeID",rs.getString(2));
                        SelectData.put("employeeCode",rs.getString(3));
                        SelectData.put("employeename",rs.getString(4));
                        SelectData.put("sno", rs.getString(5));
                        tm.put(k, SelectData);
                        k++;
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
     
     private Map selectStudentInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();
        try {
            
            if(!hm.get("searchNames").equals("")){
              searchBoxValue="and (sm.studentname like '%"+hm.get("searchNames")+"%')";
              }
            
                sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (studentid) Totalrecord FROM studentmaster where nvl(deactive,'N')='N' and programcode in('M.T','M.T-P','PHD')) a,\n"
                        +"(SELECT * FROM ( select nvl(sm.studentid,'')studentid,nvl(sm.enrollmentno,'')enrollmentno,nvl(sm.studentname,'')studentname,nvl(sm.programcode,'')programcode,nvl(sm.branchcode,'')branchcode,ROWNUM R "
                        + "from studentmaster sm where nvl(sm.deactive,'N')='N' and programcode in('M.T','M.T-P','PHD') "
                        + ""+searchBoxValue+" order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                
                int k = 1;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("totalrecords",rs.getString(1));
                        SelectData.put("studentID",rs.getString(2));
                        SelectData.put("enrollmentNo",rs.getString(3));
                        SelectData.put("studentName",rs.getString(4));
                        SelectData.put("programCode",rs.getString(5));
                        SelectData.put("branchCode",rs.getString(6));
                        SelectData.put("sno", rs.getString(7));
                        tm.put(k, SelectData);
                        k++;
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
     
     private String SaveUpdateData(Map hm) 
   {
       
        StringBuilder sqry = new StringBuilder();
       StringBuilder eqry = new StringBuilder();
       String id = "";
       try {
           if (hm.get("projectID").equals("0")) {
               try {
                   callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                   callableStatement.setString(1, "0001");
                   callableStatement.setString(2, "FBMId");
                   callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                   callableStatement.execute();
                   id = callableStatement.getString(3);
               } catch (Exception e) {
                   e.printStackTrace();
               } finally {
                   if (callableStatement != null) {
                       callableStatement.close();
                   }
               }

               eqry.append("insert into  AP#PROJECTMASTERPHD ( COMPANYID,DEPARTMENTCODE,PROJECTID,PROJECTCODE,");
               eqry.append("PROJECTTITLE,PROJECTLEVEL,ACADEMICYEAR,STUDENTID,STAFFID,PROJECTPERSTATUS,PROJECTSTATUS,");
               eqry.append("PROJECTSTATUSDATE,APISCORE,PROJECTREMARKS,DEACTIVE,ENTRYBY,ENTRYDATE)");
               eqry.append(" VALUES('").append(hm.get("companyid")).append("','");
               eqry.append(hm.get("departmentCode")).append("','");
               eqry.append(id).append("','");
               if (hm.get("projectCode").toString() == null || hm.get("projectCode").toString().equals("")) {
                   eqry.append(id).append("','");
               } else {
                   eqry.append(hm.get("projectCode")).append("','");
               }
               eqry.append(hm.get("projectTitle")).append("',");
               eqry.append("'").append(hm.get("projectLevel")).append("','")
                       .append(hm.get("academicYear")).append("','")
                       .append(hm.get("studentID")).append("','")
                       .append(hm.get("staffID")).append("',");
               eqry.append("'").append(hm.get("projectPerStatus"))
                       .append("','").append(hm.get("projectStatus")).append("',");
               eqry.append("to_date('").append(hm.get("projectStatusAsOnDate")).append("','dd-mm-yyyy'),'")
                       .append(hm.get("projectAPIScore")).append("','")
                       .append(hm.get("projectRemarks")).append("','").append(hm.get("deactive")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               pStmt = dbConnection.prepareStatement(eqry.toString());
               pStmt.executeUpdate();
           } else {
               sqry.append("Update AP#PROJECTMASTERPHD set COMPANYID='").append(hm.get("companyid"));
               sqry.append("',DEPARTMENTCODE='").append(hm.get("departmentCode"));
               if (hm.get("projectCode").toString() == null || hm.get("projectCode").toString().equals("")) {
                   sqry.append("',PROJECTCODE='").append(hm.get("projectID"));
               } else {
                   sqry.append("',PROJECTCODE='").append(hm.get("projectCode"));
               }
               sqry.append("',PROJECTTITLE='").append(hm.get("projectTitle"))
                       .append("',PROJECTLEVEL='").append(hm.get("projectLevel")).append("',");
               sqry.append("ACADEMICYEAR='").append(hm.get("academicYear"))
                       .append("',STUDENTID='").append(hm.get("studentID")).append("',");
               sqry.append("STAFFID='").append(hm.get("staffID"))
                       .append("',PROJECTPERSTATUS='").append(hm.get("projectPerStatus"))
                       .append("',PROJECTSTATUS='").append(hm.get("projectStatus"))
                       .append("',PROJECTSTATUSDATE=to_date('").append(hm.get("projectStatusAsOnDate")).append("','dd-mm-yyyy')")
                       .append(",APISCORE='").append(hm.get("projectAPIScore"))
                       .append("',PROJECTREMARKS='").append(hm.get("projectRemarks"))
                       .append("',DEACTIVE='").append(hm.get("deactive"))
                       .append("',ENTRYBY='").append(hm.get("entryBy"))
                       .append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')")
                       .append(" where PROJECTID='").append(hm.get("projectID")).append("'");
               pStmt = dbConnection.prepareStatement(sqry.toString());
               pStmt.executeUpdate();
               id = hm.get("projectID").toString();

           }
       } catch (Exception e) {

           e.printStackTrace();
           return "Record Not Saved";
       }
    return id;
   }
     
     private Map getSelectData(Map hm) {
          Map data = new HashMap();
          TreeMap tm = new TreeMap();
          String searchBoxValue="";
          StringBuffer sqry = new StringBuffer();
          try {
             if (!hm.get("searchbox").equals("")) {
                 searchBoxValue = "and (dm.department like '%" + hm.get("searchbox") + "%' or am.projectcode like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projecttitle like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or sm.studentname like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or vs.employeename like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projectperstatus like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projectremarks like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.apiscore like '%" + hm.get("searchbox") + "%')";
             }

             sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (projectid) Totalrecord FROM  ap#projectmasterphd where companyid='"+hm.get("companyID")+"') a,\n"
                     + "  (SELECT *\n"
                     + "  FROM (select nvl(am.projectid,'')projectid,"
                     + "nvl(dm.department,'')department,"
                     + "nvl(am.projectcode,'')projectcode,"
                     + "nvl(am.projecttitle,'') projecttitle,"
                     + "nvl(am.projectlevel,'')projectlevel,"
                     + "nvl(am.academicyear,'')academicyear,"
                     + "nvl(vs.employeename,'')employeename,"
                     + "nvl(sm.studentname,'')studentname,"
                     + "nvl(am.projectperstatus,'')projectperstatus,"
                     + "nvl(am.projectstatus,'')projectstatus,"
                     + "to_char(am.projectstatusdate,'dd-mm-yyyy')projectstatusdate,"
                     + "nvl(am.apiscore,'')apiscore,"
                     + "nvl(am.projectremarks,'')projectremarks,"
                     + "nvl(am.deactive,'')deactive,nvl(sm.ENROLLMENTNO,'')ENROLLMENTNO,"
                     + " row_number() over (order by am.projectid desc)  R from ap#projectmasterphd am,departmentmaster dm,v#staff vs,studentmaster sm"
                     + " where dm.departmentcode=am.departmentcode and vs.employeeid=am.staffid and vs.companycode=am.companyid and sm.studentid=am.studentid and companyid='"+hm.get("companyID")+"' " + searchBoxValue + ")\n"
                     + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
             int k = 1;
             pStmt = dbConnection.prepareStatement(sqry.toString());
             rs = pStmt.executeQuery();
             while (rs.next()) {
                 data = new HashMap();
                 data.put("slno", rs.getString(17));
                 data.put("totalrecords", rs.getString(1));
                 data.put("projectID", rs.getString(2));
                 data.put("departmentName", rs.getString(3));
                 data.put("projectCode", rs.getString(4));
                 data.put("projectTitle", rs.getString(5));
                 data.put("projectLevel", rs.getString(6));
                 data.put("academicYear", rs.getString(7));
                 data.put("employeeName", rs.getString(8));
                 data.put("studentName", rs.getString(9));
                 data.put("projectPerStatus", rs.getString(10));
                 data.put("projectStatus", rs.getString(11));
                 data.put("projectStatusDate", rs.getString(12));
                 data.put("projectAPIScore", rs.getString(13));
                 data.put("projectRemarks", rs.getString(14));
                 if(rs.getString(15).equals("N"))
                 {
                 data.put("active", "Y");
                 }else{
                 data.put("active", "N");
                 }
                 data.put("enrollNo", rs.getString(16));
                 tm.put(k, data);
                 k++;
             }
         } catch (Exception e) {
             e.printStackTrace();
         }
         if (tm.isEmpty()) {
             tm.put("0", "0");
         }
          return tm;
      }
     
     
     private Map selectForUpdate(Map hm) {
         StringBuffer sqry = new StringBuffer();
         Map SelectData = new HashMap();
         int k = 1;
             try {
                 sqry.append(" select nvl(am.DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(dm.DEPARTMENT,'')DEPARTMENT,"
                         + "nvl(am.PROJECTCODE,'')PROJECTCODE,nvl(am.PROJECTTITLE,'')PROJECTTITLE,"
                         + "nvl(am.PROJECTLEVEL,'')PROJECTLEVEL,nvl(am.ACADEMICYEAR,'')ACADEMICYEAR,"
                         + "nvl(sm.STUDENTNAME,'')STUDENTNAME,nvl(vs.EMPLOYEENAME,'')EMPLOYEENAME,"
                         + "nvl(am.STUDENTID,'')STUDENTID,nvl(am.STAFFID,'')STAFFID,"
                         + "nvl(am.PROJECTPERSTATUS,'')PROJECTPERSTATUS,"
                         + "nvl(am.PROJECTSTATUS,'')PROJECTSTATUS,to_char(am.PROJECTSTATUSDATE,'dd-mm-yyyy')PROJECTSTATUSDATE,"
                         + "nvl(am.APISCORE,'')APISCORE,nvl(am.PROJECTREMARKS,'')PROJECTREMARKS,"
                         + "nvl(am.DEACTIVE,'')DEACTIVE,nvl(sm.ENROLLMENTNO,'')ENROLLMENTNO from AP#PROJECTMASTERPHD am,v#staff vs,STUDENTMASTER sm,departmentmaster dm");
                 sqry.append(" where am.departmentcode=dm.departmentcode and vs.COMPANYCODE=am.COMPANYID and vs.EMPLOYEEID=am.STAFFID and sm.studentid=am.studentid");
                sqry.append(" and ").append( "PROJECTID='").append(hm.get("projectID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("projectID", hm.get("projectID"));
                    SelectData.put("departmentCode", rs.getString(1));
                    SelectData.put("departmentName", rs.getString(2));
                    SelectData.put("projectCode", rs.getString(3));
                    SelectData.put("projectTitle", rs.getString(4));
                    SelectData.put("projectLevel", rs.getString(5));
                    SelectData.put("academicYear", rs.getString(6));
                    SelectData.put("studentName", rs.getString(7));
                    SelectData.put("employeeName", rs.getString(8));
                    SelectData.put("studentID", rs.getString(9));
                    SelectData.put("staffID", rs.getString(10));
                    SelectData.put("projectPerStaus", rs.getString(11));
                    SelectData.put("projectStatus", rs.getString(12));
                    SelectData.put("projectStatusOnDate", rs.getString(13));
                    SelectData.put("projectAPIScore", rs.getString(14));
                    SelectData.put("projectRemarks", rs.getString(15));
                    if (rs.getString(16).equals("N")) {
                        SelectData.put("active", "Y");
                    } else {
                        SelectData.put("active", "N");
                    }
                    SelectData.put("enrollNo", rs.getString(17));
                        
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
     
      private Map selectDepartment(Map hm) {
         StringBuffer sqry = new StringBuffer();
         Map SelectData = new HashMap();
             try {
                sqry.append("select distinct  bt.departmentcode,dm.department from branchdepttagging bt,departmentmaster dm where bt.departmentcode=dm.departmentcode and bt.programcode='"+hm.get("programCode")+"' and bt.sectionbranch='"+hm.get("branchCode")+"'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    SelectData.put("departmentCode",rs.getString(1));
                    SelectData.put("departmentName", rs.getString(2));   
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
}
