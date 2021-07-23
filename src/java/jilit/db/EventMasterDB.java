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
public class EventMasterDB {
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public EventMasterDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        formNameCombo,saveupdate, select,SelectforUpdate,Delete
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (EventMasterDB.scase.valueOf((String) hm.get("handller").toString())) {
                case formNameCombo:
                    responseString = mapper.writeValueAsString(getFormNameCombo(hm));
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
                case Delete:
                    responseString = mapper.writeValueAsString(getDeleteData(hm));
                    break;
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     public String getFormNameCombo(Map mp)
     {
         StringBuilder sb=new StringBuilder();
         StringBuilder op=new StringBuilder();
         try
         {
             sb.append("SELECT APFORMID,APFORMTITLE FROM AP#FORMMASTER WHERE APCATEGORYID='" + mp.get("categoryID") + "'");
             op.append("<option value='' selected>Select Form Name</option>");
             pStmt = dbConnection.prepareStatement(sb.toString());
             rs = pStmt.executeQuery();

             while (rs.next()) {
                      if(mp.get("formID").toString().equals(rs.getString(1)))
                      {
                      op.append("<option selected value='" + rs.getString(1) + "' >" + rs.getString(2) + "</option>");
                      }else{
                     op.append("<option value='" + rs.getString(1) + "' >" + rs.getString(2) + "</option>");
                      }
                
             }
         }catch(Exception e)
         {
             e.printStackTrace();
         }
         return op.toString();
     }
     
      private String SaveUpdateData(Map hm) 
   {
       
       StringBuilder sqry = new StringBuilder();
       StringBuilder eqry = new StringBuilder();
       StringBuilder insertQuery=new StringBuilder();
       String id = "";
       try {
           if (hm.get("eventID").equals("0")) {
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

               eqry.append("insert into  AP#EVENTMASTER ( COMPANYID,APCATEGORYID,APEVENTID,APEVENTACADEMICYEAR,");
               eqry.append("APEVENTCODE,APEVENTDESCRIPTION,APEVENTFROMDATE,APEVENTTODATE,DEACTIVE,ENTRYBY,ENTRYDATE)");
               eqry.append(" VALUES('").append(hm.get("companyid")).append("','")
                       .append(hm.get("categoryName")).append("','")
                       .append(id).append("','")
                       .append(hm.get("academicYear")).append("','")
                       .append(hm.get("eventCode")).append("',");
               eqry.append("'").append(hm.get("eventDescription")).append("',");
               eqry.append("to_date('").append(hm.get("eventFromDate")).append("','dd-mm-yyyy'),");
               eqry.append("to_date('").append(hm.get("eventToDate")).append("','dd-mm-yyyy'),'")
               .append(hm.get("deactive")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               pStmt = dbConnection.prepareStatement(eqry.toString());
               pStmt.executeUpdate();
           } else {
               sqry.append("Update AP#EVENTMASTER set COMPANYID='").append(hm.get("companyid"));
               sqry.append("',APCATEGORYID='").append(hm.get("categoryName"));
               sqry.append("',APEVENTACADEMICYEAR='").append(hm.get("academicYear"))
                       .append("',APEVENTCODE='").append(hm.get("eventCode"))
                       .append("',APEVENTDESCRIPTION='").append(hm.get("eventDescription")).append("',");
               sqry.append("APEVENTFROMDATE=to_date('").append(hm.get("eventFromDate")).append("','dd-mm-yyyy')")
                       .append(",APEVENTTODATE=to_date('").append(hm.get("eventToDate")).append("','dd-mm-yyyy'),");
                       sqry.append("DEACTIVE='").append(hm.get("deactive"))
                       .append("',ENTRYBY='").append(hm.get("entryBy"))
                       .append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')")
                       .append(" where APEVENTID='").append(hm.get("eventID")).append("'");
               pStmt = dbConnection.prepareStatement(sqry.toString());
               pStmt.executeUpdate();
               id = hm.get("eventID").toString();
           }
           
            String Querry = " delete from AP#FORMEVENTTAGGING where APEVENTID = '" + hm.get("eventID") + "'";
           pStmt = dbConnection.prepareStatement(Querry);
           pStmt.executeUpdate();

           if (hm.get("eventID").equals("0")) {
               insertQuery.append("insert into  AP#FORMEVENTTAGGING ( COMPANYID,APCATEGORYID,APEVENTID,APFORMID,");
               insertQuery.append("APEVENTFROMDATE,APEVENTTODATE,DEACTIVE,ENTRYBY,ENTRYDATE)");
               insertQuery.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("categoryName")).append("','").append(id).append("','").append(hm.get("formName")).append("',to_date('").append(hm.get("eventFromDate")).append("','dd-mm-yyyy'),");
               insertQuery.append("to_date('").append(hm.get("eventToDate")).append("','dd-mm-yyyy'),'").append(hm.get("deactive")).append("',");
               insertQuery.append("'").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               pStmt = dbConnection.prepareStatement(insertQuery.toString());
               pStmt.executeUpdate();
           } else {
               insertQuery.append("insert into  AP#FORMEVENTTAGGING ( COMPANYID,APCATEGORYID,APEVENTID,APFORMID,");
               insertQuery.append("APEVENTFROMDATE,APEVENTTODATE,DEACTIVE,ENTRYBY,ENTRYDATE)");
               insertQuery.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("categoryName")).append("','").append(hm.get("eventID")).append("','").append(hm.get("formName")).append("',to_date('").append(hm.get("eventFromDate")).append("','dd-mm-yyyy'),");
               insertQuery.append("to_date('").append(hm.get("eventToDate")).append("','dd-mm-yyyy'),'").append(hm.get("deactive")).append("',");
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
                 searchBoxValue = "and (cm.APCATEGORYDESCRIPTION like '%" + hm.get("searchbox") + "%' or am.APEVENTACADEMICYEAR like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.APEVENTCODE like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.APEVENTDESCRIPTION like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.APEVENTFROMDATE like '%" + hm.get("searchbox") + "%'";
                 searchBoxValue = searchBoxValue + " or am.APEVENTTODATE like '%" + hm.get("searchbox") + "%')";
             }

             sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (APEVENTID) Totalrecord FROM  AP#EVENTMASTER) a,\n"
                     + "  (SELECT *\n"
                     + "  FROM (select nvl(am.APEVENTID,'')APEVENTID,"
                     + "nvl(cm.APCATEGORYDESCRIPTION,'')APCATEGORYDESCRIPTION,"
                     + "nvl(am.APEVENTACADEMICYEAR,'') APEVENTACADEMICYEAR,"
                     + "nvl(am.APEVENTCODE,'')APEVENTCODE,"
                     + "nvl(am.APEVENTDESCRIPTION,'')APEVENTDESCRIPTION,"
                     + "to_char(am.APEVENTFROMDATE,'dd-mm-yyyy')APEVENTFROMDATE,"
                     + "to_char(am.APEVENTTODATE,'dd-mm-yyyy')APEVENTTODATE,"
                     + "nvl(am.DEACTIVE,'')DEACTIVE,"
                     + " row_number() over (order by am.APEVENTID desc)  R from AP#EVENTMASTER am,AP#CATEGORYMASTER cm"
                     + " where cm.COMPANYID=am.COMPANYID and cm.APCATEGORYID=am.APCATEGORYID " + searchBoxValue + ")\n"
                     + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
             int k = 1;
             pStmt = dbConnection.prepareStatement(sqry.toString());
             rs = pStmt.executeQuery();
             while (rs.next()) {
                 data = new HashMap();
                 data.put("slno", rs.getString(10));
                 data.put("totalrecords", rs.getString(1));
                 data.put("eventID", rs.getString(2));
                 data.put("category", rs.getString(3));
                 data.put("academicYear", rs.getString(4));
                 data.put("eventCode", rs.getString(5));
                 data.put("eventDescription", rs.getString(6));
                 data.put("eventFromDate", rs.getString(7));
                 data.put("eventToDate", rs.getString(8));
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
                sqry.append(" select nvl(am.APCATEGORYID,'')APCATEGORYID,");
                sqry.append("nvl(am.APEVENTACADEMICYEAR,'')APEVENTACADEMICYEAR,nvl(am.APEVENTCODE,'')APEVENTCODE,");
                sqry.append("nvl(am.APEVENTDESCRIPTION,'')APEVENTDESCRIPTION,to_char(am.APEVENTFROMDATE,'dd-mm-yyyy')APEVENTFROMDATE,");
                sqry.append("to_char(am.APEVENTTODATE,'dd-mm-yyyy')APEVENTTODATE,nvl(am.DEACTIVE,'')DEACTIVE,nvl(at.APFORMID,'')APFORMID from AP#EVENTMASTER am,AP#FORMEVENTTAGGING at ");
                sqry.append(" where ").append( "am.COMPANYID=at.COMPANYID and at.APCATEGORYID=am.APCATEGORYID and am.APEVENTID=at.APEVENTID and am.APEVENTID='").append(hm.get("eventID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("eventID",hm.get("eventID"));
                        SelectData.put("categoryID",rs.getString(1));
                        SelectData.put("academicYear",rs.getString(2));
                        SelectData.put("eventCode",rs.getString(3));
                        SelectData.put("eventDescription",rs.getString(4));
                        SelectData.put("eventFromDate",rs.getString(5));
                        SelectData.put("eventToDate",rs.getString(6));
                        SelectData.put("deactive",rs.getString(7));
                        SelectData.put("formID",rs.getString(8));
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
       
       private Map getDeleteData(Map hm) {
        try {
            String Querry = " delete from AP#FORMEVENTTAGGING where APEVENTID = '" + hm.get("eventID") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();
            String Querry1 = " delete from AP#EVENTMASTER where APEVENTID = '" + hm.get("eventID") + "'";
            pStmt = dbConnection.prepareStatement(Querry1);
            pStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new HashMap();
    }
}
