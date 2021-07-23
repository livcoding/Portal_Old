/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
public class ProjectMasterDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public ProjectMasterDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        setDuration,saveupdate, select,SelectforUpdate
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (ProjectMasterDB.scase.valueOf((String) hm.get("handller").toString())) {
                case setDuration:
                    responseString = mapper.writeValueAsString(getDurationInMonths(hm));
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
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     public int getDurationInMonths(Map hm) throws ParseException{
         String startDate = hm.get("projectStartDate").toString();
         String endDate = hm.get("projectEndDate").toString();
         Date fromDate = formatter.parse(startDate);
         Date toDate = formatter.parse(endDate);
         int monthCount = 0;
         Calendar cal = Calendar.getInstance();
         cal.setTime(fromDate);
         int c1date = cal.get(Calendar.DATE);
         int c1month = cal.get(Calendar.MONTH);
         int c1year = cal.get(Calendar.YEAR);
         cal.setTime(toDate);
         int c2date = cal.get(Calendar.DATE);
         int c2month = cal.get(Calendar.MONTH);
         int c2year = cal.get(Calendar.YEAR);

         monthCount = ((c2year - c1year) * 12) + (c2month - c1month) + ((c2date >= c1date) ? 1 : 0);

         return monthCount;
        }
     
     
     private String SaveUpdateData(Map hm) 
   {
       
        StringBuilder sqry = new StringBuilder();
       StringBuilder eqry = new StringBuilder();
       StringBuilder historyQry = new StringBuilder();
       String id = "";
       boolean flag = false;
       String dCode = "";
       String pCode = "";
       try {
           if (hm.get("projectID").equals("0")) {
               try {
                   if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
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

               eqry.append("insert into  AP#PROJECTMASTER ( COMPANYID,DEPARTMENTCODE,PROJECTID,PROJECTCODE,");
               eqry.append("PROJECTTITLE,PROJECTTYPE,PROJECTCOST,PROJECTAUTHORITY,PROJECTGRANTAMOUNT,PROJECTGRANTAUTHORITY,PROJECTSTARTDATE,");
               eqry.append("PROJECTENDDATE,PROJECTPERSTATUS,PROJECTSTATUS,PROJECTSTATUSDATE,APISCORE,PROJECTREMARKS,DEACTIVE,ENTRYBY,ENTRYDATE)");
               eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("departmentName")).append("','").append(id).append("','").append(hm.get("projectCode")).append("','").append(hm.get("projectTitle")).append("',");
               eqry.append("'").append(hm.get("projectType")).append("','").append(hm.get("projectGrandAmount")).append("','").append(hm.get("projectAuthority")).append("','").append(hm.get("projectGrandAmount")).append("',");
               eqry.append("'").append(hm.get("sponsoredAuthority")).append("',to_date('").append(hm.get("projectStartDate")).append("','dd-mm-yyyy'),");
               eqry.append("to_date('").append(hm.get("projectEndDate")).append("','dd-mm-yyyy'),'").append(hm.get("projectPerStatus")).append("',");
               eqry.append("'").append(hm.get("projectStatus")).append("',to_date('").append(hm.get("projectStatusAsOnDate")).append("','dd-mm-yyyy'),'").append(hm.get("projectAPIScore")).append("','").append(hm.get("projectRemarks")).append("','").append(hm.get("deactive")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
               pStmt = dbConnection.prepareStatement(eqry.toString());
               pStmt.executeUpdate();

               historyQry.append("insert into  AP#PROJECTMASTERHISTORY ( COMPANYID,DEPARTMENTCODE,PROJECTID,PROJECTCODE,");
               historyQry.append("PROJECTTITLE,PROJECTTYPE,PROJECTCOST,PROJECTAUTHORITY,PROJECTGRANTAMOUNT,PROJECTGRANTAUTHORITY,PROJECTSTARTDATE,");
               historyQry.append("PROJECTENDDATE,PROJECTPERSTATUS,PROJECTSTATUS,PROJECTSTATUSDATE,APISCORE,PROJECTREMARKS,DEACTIVE,ENTRYBY,ENTRYDATE)");
               historyQry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("departmentName")).append("','").append(id).append("','").append(hm.get("projectCode")).append("','").append(hm.get("projectTitle")).append("',");
               historyQry.append("'").append(hm.get("projectType")).append("','").append(hm.get("projectGrandAmount")).append("','").append(hm.get("projectAuthority")).append("','").append(hm.get("projectGrandAmount")).append("',");
               historyQry.append("'").append(hm.get("sponsoredAuthority")).append("',to_date('").append(hm.get("projectStartDate")).append("','dd-mm-yyyy'),");
               historyQry.append("to_date('").append(hm.get("projectEndDate")).append("','dd-mm-yyyy'),'").append(hm.get("projectPerStatus")).append("',");
               historyQry.append("'").append(hm.get("projectStatus")).append("',to_date('").append(hm.get("projectStatusAsOnDate")).append("','dd-mm-yyyy'),'").append(hm.get("projectAPIScore")).append("','").append(hm.get("projectRemarks")).append("','").append(hm.get("deactive")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
               pStmt = dbConnection.prepareStatement(historyQry.toString());
               pStmt.executeUpdate();

           } else {
               String qry = "SELECT DEPARTMENTCODE FROM AP#PROJECTMASTER WHERE PROJECTID='" + hm.get("projectID") + "'";
               if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
               pStmt = dbConnection.prepareStatement(qry);
               rs = pStmt.executeQuery();
               if (rs.next()) {
                   dCode = rs.getString(1);
               }
               if (!dCode.equals(hm.get("departmentName"))) {
                   flag = true;
               }

               String qry1 = "SELECT PROJECTCODE FROM AP#PROJECTMASTER WHERE PROJECTID='" + hm.get("projectID") + "'";
               if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
               pStmt = dbConnection.prepareStatement(qry1);
               rs = pStmt.executeQuery();
               if (rs.next()) {
                   pCode = rs.getString(1);
               }
               if (!pCode.equals(hm.get("projectCode"))) {
                   flag = true;
               }
               if (flag == true) {
                   String query = "DELETE FROM AP#PROJECTMASTERHISTORY WHERE PROJECTID='" + hm.get("projectID") + "'";
                   if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
                   pStmt = dbConnection.prepareStatement(query.toString());
                   pStmt.executeUpdate();
               } else {
                   String query = "DELETE FROM AP#PROJECTMASTERHISTORY WHERE PROJECTSTATUSDATE=to_date('" + hm.get("projectStatusAsOnDate") + "','dd-mm-yyyy') and PROJECTID='" + hm.get("projectID") + "'";
                   if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
                   pStmt = dbConnection.prepareStatement(query.toString());
                   pStmt.executeUpdate();
               }
               sqry.append("Update AP#PROJECTMASTER set COMPANYID='").append(hm.get("companyid"));
               sqry.append("',DEPARTMENTCODE='").append(hm.get("departmentName"));
               sqry.append("',PROJECTCODE='").append(hm.get("projectCode"))
                       .append("',PROJECTTITLE='").append(hm.get("projectTitle"))
                       .append("',PROJECTTYPE='").append(hm.get("projectType")).append("',");
               sqry.append("PROJECTCOST='").append(hm.get("projectGrandAmount"))
                       .append("',PROJECTAUTHORITY='").append(hm.get("projectAuthority")).append("',");
               sqry.append("PROJECTGRANTAMOUNT='").append(hm.get("projectGrandAmount"))
                       .append("',PROJECTGRANTAUTHORITY='").append(hm.get("sponsoredAuthority"))
                       .append("',PROJECTSTARTDATE=to_date('").append(hm.get("projectStartDate")).append("','dd-mm-yyyy')")
                       .append(",PROJECTENDDATE=to_date('").append(hm.get("projectEndDate")).append("','dd-mm-yyyy')")
                       .append(",PROJECTPERSTATUS='").append(hm.get("projectPerStatus"))
                       .append("',PROJECTSTATUS='").append(hm.get("projectStatus"))
                       .append("',PROJECTSTATUSDATE=to_date('").append(hm.get("projectStatusAsOnDate")).append("','dd-mm-yyyy')")
                       .append(",APISCORE='").append(hm.get("projectAPIScore"))
                       .append("',PROJECTREMARKS='").append(hm.get("projectRemarks"))
                       .append("',DEACTIVE='").append(hm.get("deactive"))
                       .append("',ENTRYBY='").append(hm.get("entryBy"))
                       .append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')")
                       .append(" where PROJECTID='").append(hm.get("projectID")).append("'");
               if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
               pStmt = dbConnection.prepareStatement(sqry.toString());
               pStmt.executeUpdate();




               historyQry.append("insert into  AP#PROJECTMASTERHISTORY ( COMPANYID,DEPARTMENTCODE,PROJECTID,PROJECTCODE,");
               historyQry.append("PROJECTTITLE,PROJECTTYPE,PROJECTCOST,PROJECTAUTHORITY,PROJECTGRANTAMOUNT,PROJECTGRANTAUTHORITY,PROJECTSTARTDATE,");
               historyQry.append("PROJECTENDDATE,PROJECTPERSTATUS,PROJECTSTATUS,PROJECTSTATUSDATE,APISCORE,PROJECTREMARKS,DEACTIVE,ENTRYBY,ENTRYDATE)");
               historyQry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("departmentName")).append("','").append(hm.get("projectID")).append("','").append(hm.get("projectCode")).append("','").append(hm.get("projectTitle")).append("',");
               historyQry.append("'").append(hm.get("projectType")).append("','").append(hm.get("projectGrandAmount")).append("','").append(hm.get("projectAuthority")).append("','").append(hm.get("projectGrandAmount")).append("',");
               historyQry.append("'").append(hm.get("sponsoredAuthority")).append("',to_date('").append(hm.get("projectStartDate")).append("','dd-mm-yyyy'),");
               historyQry.append("to_date('").append(hm.get("projectEndDate")).append("','dd-mm-yyyy'),'").append(hm.get("projectPerStatus")).append("',");
               historyQry.append("'").append(hm.get("projectStatus")).append("',to_date('").append(hm.get("projectStatusAsOnDate")).append("','dd-mm-yyyy'),'").append(hm.get("projectAPIScore")).append("','").append(hm.get("projectRemarks")).append("','").append(hm.get("deactive")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
               pStmt = dbConnection.prepareStatement(historyQry.toString());
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
                 searchBoxValue = searchBoxValue + " or am.projectstartdate like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projectenddate like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projectgrantamount like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projectauthority like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projectgrantauthority like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projectperstatus like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projectremarks like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.apiscore like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.projectcost like '%" + hm.get("searchbox") + "%')";
             }

             sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (projectid) Totalrecord FROM  ap#projectmaster) a,\n"
                     + "  (SELECT *\n"
                     + "  FROM (select nvl(am.projectid,'')projectid,"
                     + "nvl(dm.department,'')department,"
                     + "nvl(am.projectcode,'')projectcode,"
                     + "nvl(am.projecttitle,'') projecttitle,"
                     + "nvl(am.projecttype,'')projecttype,"
                     + "nvl(am.projectcost,'')projectcost,"
                     + "nvl(am.projectauthority,'')projectauthority,"
                     + "nvl(am.projectgrantamount,'')projectgrantamount,"
                     + "nvl(am.projectgrantauthority,'')projectgrantauthority,"
                     + "to_char(am.projectstartdate,'dd-mm-yyyy')projectstartdate,"
                     + "to_char(am.projectenddate,'dd-mm-yyyy')projectenddate,"
                     + "nvl(am.projectperstatus,'')projectperstatus,"
                     + "nvl(am.projectstatus,'')projectstatus,"
                     + "nvl(am.apiscore,'')apiscore,"
                     + "nvl(am.projectremarks,'')projectremarks,"
                     + "nvl(am.deactive,'')deactive,"
                     + " row_number() over (order by am.projectid desc)  R from ap#projectmaster am,departmentmaster dm"
                     + " where dm.departmentcode=am.departmentcode " + searchBoxValue + ")\n"
                     + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
             int k = 1;
             if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
             pStmt = dbConnection.prepareStatement(sqry.toString());
             rs = pStmt.executeQuery();
             while (rs.next()) {
                 data = new HashMap();
                 data.put("slno", rs.getString(18));
                 data.put("totalrecords", rs.getString(1));
                 data.put("projectID", rs.getString(2));
                 data.put("departmentName", rs.getString(3));
                 data.put("projectCode", rs.getString(4));
                 data.put("projectTitle", rs.getString(5));
                 data.put("projectType", rs.getString(6));
                 data.put("projectCost", rs.getString(7));
                 data.put("projectAuthority", rs.getString(8));
                 data.put("projectGrandAmount", rs.getString(9));
                 data.put("sponsoredAuthority", rs.getString(10));
                 data.put("projectStartDate", rs.getString(11));
                 data.put("projectEndDate", rs.getString(12));
                 data.put("projectPerStatus", rs.getString(13));
                 data.put("projectStatus", rs.getString(14));
                 data.put("projectAPIScore", rs.getString(15));
                 data.put("projectRemarks", rs.getString(16));
                 if(rs.getString(17).equals("N"))
                 {
                 data.put("active", "Y");
                 }else{
                 data.put("active", "N");
                 }
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
                sqry.append(" select nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,"
                        + "nvl(PROJECTCODE,'')PROJECTCODE,nvl(PROJECTTITLE,'')PROJECTTITLE,"
                        + "nvl(PROJECTTYPE,'')PROJECTTYPE,nvl(PROJECTCOST,'')PROJECTCOST,"
                        + "nvl(PROJECTAUTHORITY,'')PROJECTAUTHORITY,nvl(PROJECTGRANTAMOUNT,'')PROJECTGRANTAMOUNT,"
                        + "nvl(PROJECTGRANTAUTHORITY,'')PROJECTGRANTAUTHORITY,"
                        + "to_char(PROJECTSTARTDATE,'dd-mm-yyyy')PROJECTSTARTDATE,to_char(PROJECTENDDATE,'dd-mm-yyyy')PROJECTENDDATE,"
                        + "nvl(PROJECTPERSTATUS,'')PROJECTPERSTATUS,nvl(PROJECTSTATUS,'')PROJECTSTATUS,to_char(PROJECTSTATUSDATE,'dd-mm-yyyy')PROJECTSTATUSDATE,"
                        + "nvl(APISCORE,'')APISCORE,nvl(PROJECTREMARKS,'')PROJECTREMARKS,nvl(DEACTIVE,'')DEACTIVE from AP#PROJECTMASTER");
                sqry.append(" where ").append( "PROJECTID='").append(hm.get("projectID")).append("'");
                if(dbConnection.isClosed()){
            dbConnection=DBUtility.getConnection(dbConnection);
          }
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("projectID", hm.get("projectID"));
                     SelectData.put("departmentName", rs.getString(1));
                     SelectData.put("projectCode", rs.getString(2));
                     SelectData.put("projectTitle", rs.getString(3));
                     SelectData.put("projectType", rs.getString(4));
                     SelectData.put("projectCost", rs.getString(5));
                     SelectData.put("projectAuthority", rs.getString(6));
                     SelectData.put("projectGrandAmount", rs.getString(7));
                     SelectData.put("sponsoredAuthority", rs.getString(8));
                     SelectData.put("projectStartDate", rs.getString(9));
                     SelectData.put("projectEndDate", rs.getString(10));
                     SelectData.put("projectPerStatus", rs.getString(11));
                     SelectData.put("projectStatus", rs.getString(12));
                     SelectData.put("projectStatusOnDate", rs.getString(13));
                     SelectData.put("projectAPIScore", rs.getString(14));
                     SelectData.put("projectRemarks", rs.getString(15));
                     if (rs.getString(16).equals("N")) {
                         SelectData.put("active", "Y");
                     } else {
                         SelectData.put("active", "N");
                     }
                     
                 }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
}
