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
public class LRMasterDB {
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public LRMasterDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        saveupdate, select,SelectforUpdate,Delete
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (LRMasterDB.scase.valueOf((String) hm.get("handller").toString())) {
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
           if (hm.get("lrID").equals("0")) {
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

               eqry.append("insert into AP#LEARNRESOURCEMASTER(COMPANYID,INSTITUTEID,LEARNRESOURCEID,LEARNRESOURCECODE,");
               eqry.append("LEARNRESOURCENAME,LEARNRESOURCETYPE,LSDEVELOPEDDATE,LSDEVELOPEDAMOUNT,DEACTIVE,ENTRYBY,ENTRYDATE,");
               eqry.append("DEPARTMENTCODE,LRDETAILDESC)");
               eqry.append(" VALUES('").append(hm.get("companyID")).append("','")
                       .append(hm.get("instituteID")).append("','")
                       .append(id).append("','")
                       .append(hm.get("lrCode")).append("','")
                       .append(hm.get("lrName")).append("','")
                       .append(hm.get("lrType")).append("',to_date('");
                       eqry.append(hm.get("procurmentDate")).append("','dd-mm-yyyy'),'");
                       eqry.append(hm.get("procurmentCost")).append("','")
                       .append(hm.get("deactive")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'),'").append(hm.get("departmentName")).append("','").append(hm.get("lrDescription")).append("')");
               pStmt = dbConnection.prepareStatement(eqry.toString());
               pStmt.executeUpdate();
           } else {
               sqry.append("Update AP#LEARNRESOURCEMASTER set COMPANYID='").append(hm.get("companyID"));
               sqry.append("',INSTITUTEID='").append(hm.get("instituteID"));
               sqry.append("',LEARNRESOURCECODE='").append(hm.get("lrCode"))
                       .append("',LEARNRESOURCENAME='").append(hm.get("lrName"))
                       .append("',LEARNRESOURCETYPE='").append(hm.get("lrType"));
               sqry.append("',LSDEVELOPEDDATE=to_date('").append(hm.get("procurmentDate")).append("','dd-mm-yyyy'),");
               sqry.append("LSDEVELOPEDAMOUNT='").append(hm.get("procurmentCost"))
                       .append("',DEACTIVE='").append(hm.get("deactive"))
                       .append("',ENTRYBY='").append(hm.get("entryBy"))
                       .append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')")
                       .append(",DEPARTMENTCODE='").append(hm.get("departmentName"))
                       .append("',LRDETAILDESC='").append(hm.get("lrDescription"))
                       .append("' where LEARNRESOURCEID='").append(hm.get("lrID")).append("'");
               pStmt = dbConnection.prepareStatement(sqry.toString());
               pStmt.executeUpdate();
               id = hm.get("lrID").toString();

           }
       } catch (Exception e) {

           e.printStackTrace();
           
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
                 searchBoxValue = "and (dm.department like '%" + hm.get("searchbox") + "%' or am.LEARNRESOURCECODE like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.LEARNRESOURCENAME like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.LRDETAILDESC like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.LSDEVELOPEDDATE like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.LSDEVELOPEDAMOUNT like '%" + hm.get("searchbox") + "%')";
             }

             sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (LEARNRESOURCEID) Totalrecord FROM  AP#LEARNRESOURCEMASTER) a,\n"
                     + "  (SELECT *\n"
                     + "  FROM (select nvl(am.LEARNRESOURCEID,'')LEARNRESOURCEID,"
                     + "nvl(dm.department,'')department,"
                     + "nvl(am.LEARNRESOURCECODE,'')LEARNRESOURCECODE,"
                     + "nvl(am.LEARNRESOURCENAME,'')LEARNRESOURCENAME,"
                     + "nvl(am.LRDETAILDESC,'')LRDETAILDESC,"
                     + "to_char(am.LSDEVELOPEDDATE,'dd-mm-yyyy')LSDEVELOPEDDATE,"
                     + "nvl(am.LSDEVELOPEDAMOUNT,'')LSDEVELOPEDAMOUNT,"
                     + "nvl(am.DEACTIVE,'')DEACTIVE,"
                     + " row_number() over (order by am.LEARNRESOURCEID desc)  R from AP#LEARNRESOURCEMASTER am,departmentmaster dm"
                     + " where dm.departmentcode=am.departmentcode " + searchBoxValue + ")\n"
                     + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
             int k = 1;
             pStmt = dbConnection.prepareStatement(sqry.toString());
             rs = pStmt.executeQuery();
             while (rs.next()) {
                 data = new HashMap();
                 data.put("slno", rs.getString(10));
                 data.put("totalrecords", rs.getString(1));
                 data.put("lrID", rs.getString(2));
                 data.put("departmentName", rs.getString(3));
                 data.put("lrCode", rs.getString(4));
                 data.put("lrName", rs.getString(5));
                 data.put("lrDescription", rs.getString(6));
                 data.put("procurmentDate", rs.getString(7));
                 data.put("procurmentCost", rs.getString(8));
                 data.put("deactive", rs.getString(9));
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
                sqry.append("nvl(LEARNRESOURCECODE,'')LEARNRESOURCECODE,nvl(LEARNRESOURCENAME,'')LEARNRESOURCENAME,");
                sqry.append("nvl(LRDETAILDESC,'')LRDETAILDESC,to_char(LSDEVELOPEDDATE,'dd-mm-yyyy')LSDEVELOPEDDATE,");
                sqry.append("nvl(LSDEVELOPEDAMOUNT,'')LSDEVELOPEDAMOUNT,nvl(DEACTIVE,'')DEACTIVE,nvl(LEARNRESOURCETYPE,'')LEARNRESOURCETYPE from AP#LEARNRESOURCEMASTER");
                sqry.append(" where ").append( "LEARNRESOURCEID='").append(hm.get("lrID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("lrID",hm.get("lrID"));
                        SelectData.put("departmentName",rs.getString(1));
                        SelectData.put("lrCode",rs.getString(2));
                        SelectData.put("lrName",rs.getString(3));
                        SelectData.put("lrDescription",rs.getString(4));
                        SelectData.put("procurmentDate",rs.getString(5));
                        SelectData.put("procurmentCost",rs.getString(6));
                        SelectData.put("deactive",rs.getString(7));
                        SelectData.put("lrType",rs.getString(8));
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
     
     private String deleteFromMasterData(Map hm) {
          String tempValue="";
        try {
            String countQuery="SELECT COUNT(LEARNRESOURCEID) FROM  AP#LEARNRESOURCEDETAIL WHERE LEARNRESOURCEID='"+hm.get("lrID")+"'";
            pStmt = dbConnection.prepareStatement(countQuery);
            pStmt.executeUpdate();
            rs = pStmt.executeQuery();
            if(rs.next())
            {
                tempValue=rs.getString(1);
            }
            if(tempValue.equals("0"))
            {
            String Querry = " DELETE FROM AP#LEARNRESOURCEMASTER WHERE LEARNRESOURCEID = '" + hm.get("lrID") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tempValue;
    }
}
