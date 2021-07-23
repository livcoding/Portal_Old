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
public class EquipmentMasterDB {
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public EquipmentMasterDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        setDuration,saveupdate, select,SelectforUpdate,Delete
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (EquipmentMasterDB.scase.valueOf((String) hm.get("handller").toString())) {
                case saveupdate:
                    responseString =SaveUpdateData(hm);
                    break;
                case select:
                    responseString = mapper.writeValueAsString(getSelectData(hm));
                    break;
                case SelectforUpdate:
                    responseString = mapper.writeValueAsString(selectForUpdate(hm));
                    break;
                case Delete:
                    responseString = deleteFromMasterData(hm);
                    break;
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     private String SaveUpdateData(Map hm) 
   {
       
        StringBuilder sqry = new StringBuilder();
       StringBuilder eqry = new StringBuilder();
       String id = "";
       try {
           if (hm.get("equipmentID").equals("0")) {
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

               eqry.append("insert into  AP#EQPTSOFTMASTER (COMPANYID,INSTITUTEID,DEPARTMENTCODE,EQUIPMENTID,");
               eqry.append("EQUIPMENTCODE,EQUIPMENTNAME,EQUIPMENTDETAILDESC,EQUIPMENTSOFTWARE,PROCUREMENTDATE,PROCUREMENTCOST,"
                       + "AMCDUEDATE,AMCAMOUNT,DEACTIVE,ENTRYBY,");
               eqry.append("ENTRYDATE)");
               eqry.append(" VALUES('").append(hm.get("companyID")).append("','")
                       .append(hm.get("instituteID")).append("','")
                       .append(hm.get("departmentName")).append("','")
                       .append(id).append("','")
                       .append(hm.get("equipmentCode")).append("','")
                       .append(hm.get("equipmentName")).append("','");
                       eqry.append(hm.get("equipmentDescription")).append("','");
                       eqry.append(hm.get("equipmentSoftware")).append("',to_date('");
                       eqry.append(hm.get("procurmentDate")).append("','dd-mm-yyyy'),'")
                       .append(hm.get("procurmentCost")).append("',to_date('");
                       eqry.append(hm.get("amcDueDate")).append("','dd-mm-yyyy'),'");
                       eqry.append(hm.get("amcAmount")).append("','");
                       eqry.append(hm.get("deactive")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               pStmt = dbConnection.prepareStatement(eqry.toString());
               pStmt.executeUpdate();
           } else {
               sqry.append("Update AP#EQPTSOFTMASTER set COMPANYID='").append(hm.get("companyID"));
               sqry.append("',INSTITUTEID='").append(hm.get("instituteID"));
               sqry.append("',DEPARTMENTCODE='").append(hm.get("departmentName"))
                       .append("',EQUIPMENTCODE='").append(hm.get("equipmentCode"))
                       .append("',EQUIPMENTNAME='").append(hm.get("equipmentName")).append("',");
               sqry.append("EQUIPMENTDETAILDESC='").append(hm.get("equipmentDescription"));
               sqry.append("',EQUIPMENTSOFTWARE='").append(hm.get("equipmentSoftware"))
                       .append("',PROCUREMENTDATE=to_date('").append(hm.get("procurmentDate")).append("','dd-mm-yyyy'),");
               sqry.append("PROCUREMENTCOST='").append(hm.get("procurmentCost"))
                       .append("',AMCDUEDATE=to_date('").append(hm.get("amcDueDate")).append("','dd-mm-yyyy'),")
                       .append("AMCAMOUNT='").append(hm.get("amcAmount"))
                       .append("',DEACTIVE='").append(hm.get("deactive"))
                       .append("',ENTRYBY='").append(hm.get("entryBy"))
                       .append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')")
                       .append(" where EQUIPMENTID='").append(hm.get("equipmentID")).append("'");
               pStmt = dbConnection.prepareStatement(sqry.toString());
               pStmt.executeUpdate();
               id = hm.get("equipmentID").toString();

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
                 searchBoxValue = "and (dm.department like '%" + hm.get("searchbox") + "%' or am.EQUIPMENTCODE like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.EQUIPMENTNAME like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.EQUIPMENTDETAILDESC like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.PROCURMENTDATE like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.PROCURMENTCOST like '%" + hm.get("searchbox") + "%')";
             }

             sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (EQUIPMENTID) Totalrecord FROM  AP#EQPTSOFTMASTER) a,\n"
                     + "  (SELECT *\n"
                     + "  FROM (select nvl(am.EQUIPMENTID,'')EQUIPMENTID,"
                     + "nvl(dm.department,'')department,"
                     + "nvl(am.EQUIPMENTCODE,'')EQUIPMENTCODE,"
                     + "nvl(am.EQUIPMENTNAME,'')EQUIPMENTNAME,"
                     + "nvl(am.EQUIPMENTDETAILDESC,'')EQUIPMENTDETAILDESC,"
                     + "to_char(am.PROCUREMENTDATE,'dd-mm-yyyy')PROCUREMENTDATE,"
                     + "nvl(am.PROCUREMENTCOST,'')PROCUREMENTCOST,"
                     + "nvl(am.DEACTIVE,'')DEACTIVE,"
                     + "nvl(am.departmentcode,'')departmentcode,"
                     + " row_number() over (order by am.EQUIPMENTID desc)  R from AP#EQPTSOFTMASTER am,departmentmaster dm"
                     + " where dm.departmentcode=am.departmentcode " + searchBoxValue + ")\n"
                     + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
             int k = 1;
             pStmt = dbConnection.prepareStatement(sqry.toString());
             rs = pStmt.executeQuery();
             while (rs.next()) {
                 data = new HashMap();
                 data.put("slno", rs.getString(11));
                 data.put("totalrecords", rs.getString(1));
                 data.put("equipmentID", rs.getString(2));
                 data.put("departmentName", rs.getString(3));
                 data.put("equipmentCode", rs.getString(4));
                 data.put("equipmentName", rs.getString(5));
                 data.put("equipmentDesc", rs.getString(6));
                 data.put("procurmentDate", rs.getString(7));
                 data.put("procurmentCost", rs.getString(8));
                 data.put("deactive", rs.getString(9));
                 data.put("departmentCode", rs.getString(10));
                 tm.put(k, data);
                 k++;
             }
         } catch (Exception e) {
             e.printStackTrace();
         }
          return tm;
      }
     
     private Map selectForUpdate(Map hm) {
         StringBuffer sqry = new StringBuffer();
         Map SelectData = new HashMap();
         int k = 1;
             try {
                sqry.append(" select nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,");
                sqry.append("nvl(EQUIPMENTCODE,'')EQUIPMENTCODE,nvl(EQUIPMENTNAME,'')EQUIPMENTNAME,");
                sqry.append("nvl(EQUIPMENTDETAILDESC,'')EQUIPMENTDETAILDESC,nvl(EQUIPMENTSOFTWARE,'')EQUIPMENTSOFTWARE,to_char(PROCUREMENTDATE,'dd-mm-yyyy')PROCUREMENTDATE,");
                sqry.append("nvl(PROCUREMENTCOST,'')PROCUREMENTCOST,to_char(AMCDUEDATE,'dd-mm-yyyy')AMCDUEDATE,nvl(AMCAMOUNT,'')AMCAMOUNT,nvl(DEACTIVE,'')DEACTIVE from AP#EQPTSOFTMASTER");
                sqry.append(" where ").append( "EQUIPMENTID='").append(hm.get("equipmentID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("equipmentID",hm.get("equipmentID"));
                        SelectData.put("departmentName",rs.getString(1));
                        SelectData.put("equipmentCode",rs.getString(2));
                        SelectData.put("equipmentName",rs.getString(3));
                        SelectData.put("equipmentDescription",rs.getString(4));
                        SelectData.put("equipmentSoftware",rs.getString(5));
                        SelectData.put("procurmentDate",rs.getString(6));
                        SelectData.put("procurmentCost",rs.getString(7));
                        SelectData.put("amcDueDate",rs.getString(8));
                        SelectData.put("amcAmount",rs.getString(9));
                        SelectData.put("deactive",rs.getString(10));
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
     
      private String deleteFromMasterData(Map hm) {
          String tempValue="";
        try {
            String countQuery="SELECT COUNT(EQUIPMENTID) FROM  AP#EQPTSOFTDETAIL WHERE EQUIPMENTID='"+hm.get("equipmentID")+"'";
            pStmt = dbConnection.prepareStatement(countQuery);
            pStmt.executeUpdate();
            rs = pStmt.executeQuery();
            if(rs.next())
            {
                tempValue=rs.getString(1);
            }
            if(tempValue.equals("0"))
            {
            String Querry = " DELETE FROM AP#EQPTSOFTMASTER WHERE EQUIPMENTID = '" + hm.get("equipmentID") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tempValue;
    }
}
