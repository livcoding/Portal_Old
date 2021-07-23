/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import jdbc.DBUtility;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class FacultyFeedbackMasterDB {
    
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public FacultyFeedbackMasterDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        saveupdate, select, Delete, SelectforUpdate,chkUniqueValue
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (FacultyFeedbackMasterDB.scase.valueOf((String) hm.get("handller").toString())) {
                case saveupdate:
                    responseString = mapper.writeValueAsString(SaveUpdateData(hm));
                    break;
                case select:
                    responseString = mapper.writeValueAsString(getSelectData(hm));
                    break;
                case Delete:
                    responseString = mapper.writeValueAsString(getDeleteData(hm));
                    break;
                case SelectforUpdate:
                    responseString = mapper.writeValueAsString(selectForUpdate(hm));
                    break;
//                case chkUniqueValue:
//                    reponcestring = mapper.writeValueAsString(chkUniqueValue(hm));
//                    break;
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
        Map tablehm = (HashMap) hm.get("para");
        Map tablegrid = (HashMap) hm.get("grid");
         String id = "";
        try {
           if (tablehm.get("feedbackid").equals("0")) {
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

                eqry.append("insert into  AP#FACULTYFEEDBACKMASTER ( COMPANYCODE,INSTITUTECODE,EXAMCODE,FEEDBACKID,");
                eqry.append("FEEDBACKCODE,FEEDBACKDESC,EVENTFROMDATE,EVENTTODATE,EVENTCOMPLETED,EVENTBROADCAST,FEEDBACKREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(tablehm.get("companyid")).append("','").append(tablehm.get("instituteid")).append("','").append(tablehm.get("examcode")).append("','").append(id).append("','").append(tablehm.get("feedbackcode")).append("',");
                eqry.append("'").append(tablehm.get("feedbackdesc")).append("',to_date('").append(tablehm.get("eventfromdate")).append("','dd-mm-yyyy'),to_date('").append(tablehm.get("eventtodate")).append("','dd-mm-yyyy'),'").append(tablehm.get("eventcompleted")).append("',");
                eqry.append("'").append(tablehm.get("eventbroadcast")).append("','").append(tablehm.get("feedbackremarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
            } else {
                sqry.append("Update AP#FACULTYFEEDBACKMASTER set COMPANYCODE='").append(tablehm.get("companyid")).append("',INSTITUTECODE='").append(tablehm.get("instituteid")).append("',EXAMCODE='").append(tablehm.get("examcode")).append("'");
                sqry.append(",FEEDBACKCODE='").append(tablehm.get("feedbackcode")).append("',FEEDBACKDESC='").append(tablehm.get("feedbackdesc")).append("',EVENTFROMDATE=to_date('").append(tablehm.get("eventfromdate")).append("','dd-mm-yyyy'),");
                sqry.append("EVENTTODATE=to_date('").append(tablehm.get("eventtodate")).append("','dd-mm-yyyy'),EVENTCOMPLETED='").append(tablehm.get("eventcompleted")).append("',EVENTBROADCAST='").append(tablehm.get("eventbroadcast")).append("'").append(",ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')");
                sqry.append(",FEEDBACKREMARKS='").append(tablehm.get("feedbackremarks")).append("' where feedbackid='").append(tablehm.get("feedbackid")).append("'");
            }
            String qry=sqry.append(eqry).toString();
            pStmt = dbConnection.prepareStatement(qry);
            pStmt.executeUpdate();
        }catch(Exception e)
         {
             e.printStackTrace();
         }
        
        
    return "";
   }
     
     
      private Map getSelectData(Map hm) {
          Map data = new HashMap();
          TreeMap tm = new TreeMap();
          String searchBoxValue="";
          StringBuffer sqry = new StringBuffer();
          try {
              if(!hm.get("searchbox").equals("")){
              searchBoxValue="WHERE (b.examcode like '%"+hm.get("searchbox")+"%' or b.feedbackcode like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or b.feedbackdesc like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or b.feedbackremarks like '%"+hm.get("searchbox")+"%')";
              }
              sqry.append("SELECT a.*, B.*\n" +
              "  FROM (SELECT COUNT (feedbackid) Totalrecord FROM AP#FACULTYFEEDBACKMASTER) a,\n" +
              "       (SELECT *\n" +
              "          FROM (select feedbackid,"
                      + "nvl(em.examcode,' ')examcode,"
                      + "nvl(em.EXAMDESCRIPTION,' ')examdescription,"
                      + "nvl(afbm.feedbackcode,' ')feedbackcode,"
                      + "nvl(afbm.feedbackdesc,' ')feedbackdesc,"
                      + "to_char(afbm.eventfromdate,'dd-mm-yyyy')eventfromdate,");
              sqry.append("to_char(afbm.eventtodate,'dd-mm-yyyy')eventtodate,"
                      + "nvl(afbm.eventcompleted,'')eventcompleted,"
                      + "nvl(afbm.eventbroadcast,'')eventbroadcast,"
                      + "nvl(afbm.feedbackremarks,'')feedbackremarks,row_number() over (order by afbm.feedbackid desc)  R"
                      + " from AP#FACULTYFEEDBACKMASTER afbm,exammaster em where em.INSTITUTECODE=afbm.INSTITUTECODE and em.EXAMCODE=afbm.EXAMCODE)\n" +
                      " WHERE r > "+hm.get("spg")+" AND r <= "+hm.get("epg")+") b  "+searchBoxValue);
              int k = 1;
              pStmt = dbConnection.prepareStatement(sqry.toString());
              rs = pStmt.executeQuery();
              while (rs.next()) {
                  data = new HashMap();
                  data.put("slno", rs.getString(12));
                  data.put("totalrecords", rs.getString(1));
                  data.put("feedbackid", rs.getString(2));
                  data.put("examcode", rs.getString(3));
                  data.put("examdescription", rs.getString(4));
                  data.put("feedbackcode", rs.getString(5));
                  data.put("feedbackdesc", rs.getString(6));
                  data.put("eventfromdate", rs.getString(7));
                  data.put("eventtodate", rs.getString(8));
                  data.put("eventcompleted", rs.getString(9));
                  data.put("eventbroadcast", rs.getString(10));
                  data.put("feedbackremarks", rs.getString(11));
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
        try {
            
            
                sqry.append(" select nvl(feedbackcode,'')feedbackcode,nvl(feedbackdesc,'')feedbackdesc,to_char(eventfromdate,'dd-mm-yyyy')eventfromdate,to_char(eventtodate,'dd-mm-yyyy')eventtodate" );
                sqry.append(",nvl(eventcompleted,'')eventcompleted,nvl(eventbroadcast,'')eventbroadcast,nvl(feedbackremarks,'')feedbackremarks from ap#facultyfeedbackmaster");
                sqry.append(" where examcode='").append(hm.get("examcode")).append("' and feedbackid='").append(hm.get("feedbackid")).append("'");
                
                
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    
                        SelectData.put("feedbackid",hm.get("feedbackid"));
                        SelectData.put("examcode",hm.get("examcode"));
                        SelectData.put("feedbackcode",rs.getString(1));
                        SelectData.put("feedbackdesc",rs.getString(2));
                        SelectData.put("eventfromdate",rs.getString(3));
                        SelectData.put("eventtodate",rs.getString(4));
                        SelectData.put("eventcompleted",rs.getString(5));
                        SelectData.put("eventbroadcast",rs.getString(6));
                        SelectData.put("feedbackremarks",rs.getString(7));
                   
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SelectData;
    }
      
      
      private Map getDeleteData(Map hm) {
        try {
            String Querry = " delete from ap#facultyfeedbackmaster where examcode = '" + hm.get("examcode") + "' and feedbackid= '" + hm.get("feedbackid") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new HashMap();
    }
    
}
