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
public class IndexingBodyMasterDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public IndexingBodyMasterDB() {
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

            switch (IndexingBodyMasterDB.scase.valueOf((String) hm.get("handller").toString())) {
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
       StringBuilder insertQuery=new StringBuilder();
       String id = "";
       try {
           if (hm.get("indexingBodyID").equals("0")) {
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

               eqry.append("insert into  AP#INDEXINGBODYMASTER ( COMPANYID,INDEXINGBODYID,INDEXINGBODYCODE,INDEXINGBODYDESCRIPTION,");
               eqry.append("INDEXINGBODYREMARKS,RATINGNO,DEACTIVE,ENTRYBY,ENTRYDATE)");
               eqry.append(" VALUES('").append(hm.get("companyID")).append("','")
                       .append(id).append("','")
                       .append(hm.get("indexingBodyCode")).append("','")
                       .append(hm.get("indexingBodyName")).append("',");
               eqry.append("'").append(hm.get("indexingBodyRemarks")).append("',");
               eqry.append("'").append(hm.get("indexingBodyRating")).append("','");
               eqry.append(hm.get("deactive")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               pStmt = dbConnection.prepareStatement(eqry.toString());
               pStmt.executeUpdate();
           } else {
               sqry.append("Update AP#INDEXINGBODYMASTER set COMPANYID='").append(hm.get("companyID"));
               sqry.append("',INDEXINGBODYCODE='").append(hm.get("indexingBodyCode"));
               sqry.append("',INDEXINGBODYDESCRIPTION='").append(hm.get("indexingBodyName"))
                       .append("',INDEXINGBODYREMARKS='").append(hm.get("indexingBodyRemarks"))
                       .append("',RATINGNO='").append(hm.get("indexingBodyRating")).append("',");
                       sqry.append("DEACTIVE='").append(hm.get("deactive"))
                       .append("',ENTRYBY='").append(hm.get("entryBy"))
                       .append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')")
                       .append(" where INDEXINGBODYID='").append(hm.get("indexingBodyID")).append("'");
               pStmt = dbConnection.prepareStatement(sqry.toString());
               pStmt.executeUpdate();
               id = hm.get("indexingBodyID").toString();
           }
           
            String Querry = " delete from AP#INDEXINGBODYDETAIL where INDEXINGBODYID = '" + hm.get("indexingBodyID") + "'";
           pStmt = dbConnection.prepareStatement(Querry);
           pStmt.executeUpdate();

           if (hm.get("indexingBodyID").equals("0")) {
               insertQuery.append("insert into  AP#INDEXINGBODYDETAIL ( COMPANYID,INDEXINGBODYID,INDEXINGBODYCODE,APISCORE,");
               insertQuery.append("HINDEX,STARTVALUE,ENDVALUE,REMARKS,DEACTIVE,ENTRYBY,ENTRYDATE)");
               insertQuery.append(" VALUES('").append(hm.get("companyID")).append("','").append(id).append("','").append(hm.get("indexingBodyCode")).append("','").append(hm.get("apiScore")).append("','").append(hm.get("hIndex")).append("',");
               insertQuery.append("'").append(hm.get("startValue")).append("','").append(hm.get("endValue")).append("','").append(hm.get("remarks")).append("','").append(hm.get("deactive")).append("',");
               insertQuery.append("'").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               pStmt = dbConnection.prepareStatement(insertQuery.toString());
               pStmt.executeUpdate();
           } else {
               insertQuery.append("insert into  AP#INDEXINGBODYDETAIL ( COMPANYID,INDEXINGBODYID,INDEXINGBODYCODE,APISCORE,");
               insertQuery.append("HINDEX,STARTVALUE,ENDVALUE,REMARKS,DEACTIVE,ENTRYBY,ENTRYDATE)");
               insertQuery.append(" VALUES('").append(hm.get("companyID")).append("','").append(hm.get("indexingBodyID")).append("','").append(hm.get("indexingBodyCode")).append("','").append(hm.get("apiScore")).append("','").append(hm.get("hIndex")).append("',");
               insertQuery.append("'").append(hm.get("startValue")).append("','").append(hm.get("endValue")).append("','").append(hm.get("remarks")).append("','").append(hm.get("deactive")).append("',");
               insertQuery.append("'").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               pStmt = dbConnection.prepareStatement(insertQuery.toString());
               pStmt.executeUpdate();
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
                 searchBoxValue = "and (am.INDEXINGBODYCODE like '%" + hm.get("searchbox") + "%' or am.INDEXINGBODYDESCRIPTION like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or ad.APISCORE like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or ad.HINDEX like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or ad.STARTVALUE like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or ad.ENDVALUE like '%" + hm.get("searchbox") + "%')";
             }

             sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (INDEXINGBODYID) Totalrecord FROM  AP#INDEXINGBODYMASTER) a,\n"
                     + "  (SELECT *\n"
                     + "  FROM (select nvl(am.INDEXINGBODYID,'')INDEXINGBODYID,"
                     + "nvl(am.INDEXINGBODYCODE,'')INDEXINGBODYCODE,"
                     + "nvl(am.INDEXINGBODYDESCRIPTION,'')INDEXINGBODYDESCRIPTION,"
                     + "nvl(ad.APISCORE,'')APISCORE,"
                     + "nvl(ad.HINDEX,'')HINDEX,"
                     + "nvl(ad.STARTVALUE,'')STARTVALUE,"
                     + "nvl(ad.ENDVALUE,'')ENDVALUE,"
                     + "nvl(am.DEACTIVE,'')DEACTIVE,"
                     + " row_number() over (order by am.INDEXINGBODYID desc)  R from AP#INDEXINGBODYMASTER am,AP#INDEXINGBODYDETAIL ad"
                     + " where am.COMPANYID=ad.COMPANYID and am.INDEXINGBODYID=ad.INDEXINGBODYID and am.INDEXINGBODYCODE=ad.INDEXINGBODYCODE " + searchBoxValue + ")\n"
                     + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
             int k = 1;
             pStmt = dbConnection.prepareStatement(sqry.toString());
             rs = pStmt.executeQuery();
             while (rs.next()) {
                 data = new HashMap();
                 data.put("slno", rs.getString(10));
                 data.put("totalrecords", rs.getString(1));
                 data.put("indexingBodyID", rs.getString(2));
                 data.put("indexingBodyCode", rs.getString(3));
                 data.put("indexingBodyName", rs.getString(4));
                 data.put("apiScore", rs.getString(5));
                 data.put("hIndex", rs.getString(6));
                 data.put("startValue", rs.getString(7));
                 data.put("endValue", rs.getString(8));
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
                sqry.append(" select nvl(am.INDEXINGBODYCODE,'')INDEXINGBODYCODE,");
                sqry.append("nvl(am.INDEXINGBODYDESCRIPTION,'')INDEXINGBODYDESCRIPTION,nvl(am.INDEXINGBODYREMARKS,'')INDEXINGBODYREMARKS,");
                sqry.append("nvl(am.RATINGNO,'')RATINGNO,nvl(am.DEACTIVE,'')DEACTIVE,");
                sqry.append("nvl(ad.APISCORE,'')APISCORE,nvl(ad.HINDEX,'')HINDEX,nvl(ad.STARTVALUE,'')STARTVALUE,nvl(ad.ENDVALUE,'')ENDVALUE,nvl(ad.REMARKS,'')REMARKS from AP#INDEXINGBODYMASTER am,AP#INDEXINGBODYDETAIL ad");
                sqry.append(" where am.COMPANYID=ad.COMPANYID and am.INDEXINGBODYID=ad.INDEXINGBODYID and am.INDEXINGBODYCODE=ad.INDEXINGBODYCODE and ").append( "am.INDEXINGBODYID='").append(hm.get("indexingBodyID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("indexingBodyID",hm.get("indexingBodyID"));
                        SelectData.put("indexingBodyCode",rs.getString(1));
                        SelectData.put("indexingBodyName",rs.getString(2));
                        SelectData.put("indexingBodyRemarks",rs.getString(3));
                        SelectData.put("rating",rs.getString(4));
                        SelectData.put("deactive",rs.getString(5));
                        SelectData.put("apiScore",rs.getString(6));
                        SelectData.put("hIndex",rs.getString(7));
                        SelectData.put("startValue",rs.getString(8));
                        SelectData.put("endValue",rs.getString(9));
                        SelectData.put("remarks",rs.getString(10));
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
     
     private String deleteFromMasterData(Map hm) {
          String tempValue="";
        try {
            String countQuery="SELECT COUNT(INDEXINGBODYID) FROM  AP#ARPUBLICATIONTRN WHERE INDEXINGBODYID='"+hm.get("indexingBodyID")+"'";
            pStmt = dbConnection.prepareStatement(countQuery);
            pStmt.executeUpdate();
            rs = pStmt.executeQuery();
            if(rs.next())
            {
                tempValue=rs.getString(1);
            }
            if(tempValue.equals("0"))
            {
            String Querry = " DELETE FROM AP#INDEXINGBODYDETAIL WHERE INDEXINGBODYID = '" + hm.get("indexingBodyID") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();
            String Querry1 = " DELETE FROM AP#INDEXINGBODYMASTER WHERE INDEXINGBODYID = '" + hm.get("indexingBodyID") + "'";
            pStmt = dbConnection.prepareStatement(Querry1);
            pStmt.executeUpdate();

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tempValue;
    }
}
