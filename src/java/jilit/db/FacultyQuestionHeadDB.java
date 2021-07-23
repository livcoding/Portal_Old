/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class FacultyQuestionHeadDB {
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public FacultyQuestionHeadDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        saveupdate, select, Delete, SelectforUpdate,saveupdatesubhead,selectsubheadcount,popupSubHeadData
    }
     
      public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (FacultyQuestionHeadDB.scase.valueOf((String) hm.get("handller").toString())) {
                case saveupdate:
                    responseString = SaveUpdateData(hm);
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
                case saveupdatesubhead:
                    responseString = mapper.writeValueAsString(saveUpdateSubHead(hm));
                    break;
                case selectsubheadcount:
                    responseString = selectSubHeadCount(hm);
                    break;
                case popupSubHeadData:
                    responseString = mapper.writeValueAsString(selectSubHeadData(hm));
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
      
      
      private String SaveUpdateData(Map hm) 
   {
       
        StringBuilder eqry = new StringBuilder();
        StringBuilder sqry = new StringBuilder();
        Map tablehm = (HashMap) hm.get("para");
        
         String id = "";
        try {
              if(hm.get("headid").equals("0")){
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

                eqry.append("insert into  AP#FACULTYQUESTIONHEAD ( COMPANYCODE,INSTITUTECODE,EXAMCODE,FEEDBACKID,");
                eqry.append("COMPONENTTYPE,HEADID,HEADCODE,HEADDESC,WEIGTAGE,SEQID,DEACTIVE,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(tablehm.get("companyid")).append("','").append(tablehm.get("instituteid")).append("','").append(tablehm.get("examcode")).append("','") .append(tablehm.get("feedbackid")).append("',");
                eqry.append("'").append(tablehm.get("componenttype")).append("','").append(id).append("','").append(tablehm.get("headcode")).append("','").append(tablehm.get("headdesc")).append("','").append(tablehm.get("weigtage")).append("',");
                eqry.append("'").append(tablehm.get("seqid")).append("','").append("N").append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
           
            pStmt = dbConnection.prepareStatement(eqry.toString());
            pStmt.executeUpdate();
              }else
              {
                sqry.append("Update ap#facultyquestionhead set examcode='").append(tablehm.get("examcode")).append("',feedbackid='").append(tablehm.get("feedbackid")).append("',componenttype='").append(tablehm.get("componenttype")).append("'");
                sqry.append(",headcode='").append(tablehm.get("headcode")).append("',headdesc='").append(tablehm.get("headdesc")).append("',weigtage='").append(tablehm.get("weigtage")).append("',seqid='").append(tablehm.get("seqid")).append("',entryby='").append(hm.get("entryBy")).append("',entrydate=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where headid='").append(hm.get("headid")).append("'");   
               pStmt = dbConnection.prepareStatement(sqry.toString());
               pStmt.executeUpdate();
               id=hm.get("headid").toString();
              }
        }catch(Exception e)
         {
            
             e.printStackTrace();
         }
        
        
    return id;
   }
      
      
      private String saveUpdateSubHead(Map hm) 
   {
        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        ArrayList list = (ArrayList) hm.get("para");
        String id = "";
        
          
               
        
        try {
          
            for(int x=0;x<list.size();x++){
                 Map mp=(Map)list.get(x);
                 if(mp.get("headid").equals("0")){
                try {
                   callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                   callableStatement.setString(1, "0001");
                   callableStatement.setString(2, "FBMId");
                   callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                   callableStatement.execute();
                   id = callableStatement.getString(3);
                    callableStatement.close();
               } catch (Exception e) {
                   e.printStackTrace();
               } finally {
                   if (callableStatement != null) {
                      
                   }
               }
               
                eqry.append("insert into  AP#FACULTYQUESTIONHEAD ( ");
                        eqry.append( "COMPANYCODE,");//1
                        eqry.append( "INSTITUTECODE,");//2
                        eqry.append( "EXAMCODE,");
                        eqry.append( "FEEDBACKID,");
                        eqry.append( "COMPONENTTYPE,");
                        eqry.append( "HEADID,");
                        eqry.append( "HEADCODE,");
                        eqry.append( "HEADDESC,");
                        eqry.append( "WEIGTAGE,");
                        eqry.append( "PARENTHEADID,");
                        eqry.append( "SEQID,");
                        eqry.append( "DEACTIVE,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").
                        append(hm.get("companyid")).append("','")
                        .append(hm.get("instituteid")).append("','").
                        append(hm.get("examcode")).append("','") 
                        .append(hm.get("feedbackid")).append("',");
                eqry.append("'").append(hm.get("componenttype")).append("','").append(id).append("','").append(mp.get("headcode")).append("','").append(mp.get("headdesc")).append("','")
                        .append(mp.get("weigtage")).append("','")
                 .append(hm.get("parentheadid").toString().trim()).append("','").append(mp.get("seqid")).append("','").append("N").append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
            pStmt = dbConnection.prepareStatement(eqry.toString());
            pStmt.executeUpdate();
            eqry=new StringBuilder();
                 }else
                 {
                sqry.append("Update ap#facultyquestionhead set headcode='").append(mp.get("headcode")).append("',headdesc='").append(mp.get("headdesc")).append("',weigtage='").append(mp.get("weigtage")).append("'");
                sqry.append(",seqid='").append(mp.get("seqid")).append("',entryby='").append(hm.get("entryBy")).append("',entrydate=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where headid='").append(mp.get("headid")).append("'");   
               pStmt = dbConnection.prepareStatement(sqry.toString());
               pStmt.executeUpdate();
               sqry=new StringBuilder();
                 }
                  
            }
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
              searchBoxValue="and (aqh.headcode like '%"+hm.get("searchbox")+"%' or aqh.headdesc like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or aqh.weigtage like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or aqh.seqid like '%"+hm.get("searchbox")+"%')";
              }
              
              sqry.append("SELECT a.*, B.*\n" +
              "  FROM (SELECT COUNT (nvl(parentheadid,'0')) Totalrecord\n" +
"          FROM ap#facultyquestionhead  WHERE parentheadid IS NULL) a,(SELECT *\n" +
              "          FROM (select nvl(headid,'')headid,nvl(aqh.examcode,'') examcode,"
                      + "nvl(aqh.feedbackid,'')feedbackid,"
                      + "nvl(aqh.headcode,'')headcode,"
                      + "nvl(aqh.headdesc,'')headdesc,"
                      + "nvl(aqh.weigtage,'')weigtage,"
                      + "nvl(aqh.seqid,'')seqid,ROWNUM R from ap#facultyquestionhead aqh "
                      + "where parentheadid is null "+searchBoxValue+" order by R)WHERE r > "+hm.get("spg")+" AND r <= "+hm.get("epg")+") b  ");
              int k = 1;
              pStmt = dbConnection.prepareStatement(sqry.toString());
              rs = pStmt.executeQuery();
              while (rs.next()) {
                  data = new HashMap();
                  data.put("slno", rs.getString(9));
                  data.put("totalrecords", rs.getString(1));
                  data.put("headid", rs.getString(2));
                  data.put("examcode", rs.getString(3));
                  data.put("feedbackid", rs.getString(4));
                  data.put("headcode", rs.getString(5));
                  data.put("headdesc", rs.getString(6));
                  data.put("weigtage", rs.getString(7));
                  data.put("seqid", rs.getString(8));
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
            
            
                sqry.append(" select nvl(headid,'')headid,nvl(examcode,'')examcode,");
                sqry.append("nvl(feedbackid,'')feedbackid,nvl(componenttype,'')componenttype,nvl(headcode,'')headcode,nvl(headdesc,'')headdesc,nvl(weigtage,'')weigtage,nvl(seqid,'')seqid from ap#facultyquestionhead");
                sqry.append(" where parentheadid is null").append( " and headid='").append(hm.get("headid")).append("'");
                
                
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    
                        SelectData.put("headid",rs.getString(1));
                        SelectData.put("examcode",rs.getString(2));
                        SelectData.put("feedbackid",rs.getString(3));
                        SelectData.put("componenttype",rs.getString(4));
                        SelectData.put("headcode",rs.getString(5));
                        SelectData.put("headdesc",rs.getString(6));
                        SelectData.put("weigtage",rs.getString(7));
                        SelectData.put("seqid",rs.getString(8));
                        
                   
                }
            
        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return SelectData;
    }
      
   private String selectSubHeadCount(Map hm)
   {
       StringBuffer sqry = new StringBuffer();
       String count="";
        try {
       sqry.append("select count(headid) from ap#facultyquestionhead where parentheadid='"+hm.get("headid")+"'");
       pStmt = dbConnection.prepareStatement(sqry.toString());
       rs = pStmt.executeQuery();
       if(rs.next())
       {
        count=rs.getString(1);
       }
       } catch (Exception e) {
           
            e.printStackTrace();
        }
   return count;
   }
   
   
     private Map selectSubHeadData(Map hm) {
        StringBuffer sqry = new StringBuffer();
        Map SelectData = new HashMap();
        TreeMap tm = new TreeMap();
         int k = 1;
        try {
            
            
                sqry.append(" select nvl(headid,'')headid,nvl(examcode,'')examcode,");
                sqry.append("nvl(feedbackid,'')feedbackid,nvl(componenttype,'')componenttype,nvl(headcode,'')headcode,nvl(headdesc,'')headdesc,nvl(weigtage,'')weigtage,nvl(seqid,'')seqid from ap#facultyquestionhead");
                sqry.append(" where ").append( "parentheadid='").append(hm.get("parentheadid")).append("'");
                
                
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("headid",rs.getString(1));
                        SelectData.put("examcode",rs.getString(2));
                        SelectData.put("feedbackid",rs.getString(3));
                        SelectData.put("componenttype",rs.getString(4));
                        SelectData.put("headcode",rs.getString(5));
                        SelectData.put("headdesc",rs.getString(6));
                        SelectData.put("weigtage",rs.getString(7));
                        SelectData.put("seqid",rs.getString(8));
                        tm.put(k, SelectData);
                        k++;
                        
                   
                }
            
        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return tm;
    }
      
     
      private Map getDeleteData(Map hm) {
        int k[]={};
          try {
           Statement st= dbConnection.createStatement();
            String qry1 = "delete from ap#facultyquestionhead where parentheadid = '" + hm.get("headid") + "'";
            st.addBatch(qry1);
            String qry2 = "delete from ap#facultyquestionhead where headid = '" + hm.get("headid") + "'";
            st.addBatch(qry2);
            st.executeBatch();

        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return new HashMap();
    }
    
    
    
}
