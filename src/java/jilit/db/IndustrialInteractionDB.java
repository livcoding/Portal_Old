/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
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
public class IndustrialInteractionDB {
    
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public IndustrialInteractionDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectPersonsInfo,saveUpdate,select, Delete, SelectforUpdate,chkUniqueValue
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (IndustrialInteractionDB.scase.valueOf((String) hm.get("handller").toString())) {
                case saveUpdate:
                    responseString = SaveUpdate(hm);
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
     
     private String SaveUpdate(Map hm) 
   {

       StringBuilder sqry = new StringBuilder();
       StringBuilder eqry = new StringBuilder();
       ArrayList guestLectureList = (ArrayList) hm.get("para");
       ArrayList industryVisitedList = (ArrayList) hm.get("para1");
       ArrayList industryLedTrainingList = (ArrayList) hm.get("para2");
       String id = "";
       String guestLectureID = "";
       String industryVisitedID="";
       String industryLedTrainingID="";
       try {
           if (hm.get("transactionID").equals("0")) {
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

               eqry.append("insert into  AP#PSAINDUSTRIALDETAILS ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
               eqry.append("DEPARTMENTCODE,PSARANDDLABDETAILS,PSASCHOLARFELLOWDETAILS,PSACOLLABORATIVEDEGREEDETAILS,PSAAUTHARTPUBDETAILS,PSAINDSUPEDUCONFDETAILS,PSAGIFTCOMPENDETAILS,");
               eqry.append("PSAOTHERINDUSTRYDETAILS,PSAHODAPPROVAL,PSAVCAPPROVAL,PSAPROGRAMREMARKS,ENTRYBY,ENTRYDATE)");
               eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(hm.get("departmentName")).append("',");
               eqry.append("'").append(hm.get("rdLab")).append("','").append(hm.get("scholarship")).append("','").append(hm.get("collaborativeDegree")).append("','").append(hm.get("authorshipAttribution")).append("',");
               eqry.append("'").append(hm.get("industrySupport")).append("','").append(hm.get("giftCompensation")).append("',");
               eqry.append("'").append(hm.get("industryRelatedActivity")).append("','").append(hm.get("approvalOfHOD")).append("',");
               eqry.append("'").append(hm.get("approvalOfVC")).append("','").append(hm.get("programRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               pStmt = dbConnection.prepareStatement(eqry.toString());
               pStmt.executeUpdate();

           } else {
               sqry.append("Update AP#PSAINDUSTRIALDETAILS set COMPANYID='").append(hm.get("companyid")).append("',INSTITUTEID='").append(hm.get("instituteid")).append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
               sqry.append(",DEPARTMENTCODE='").append(hm.get("departmentName")).append("',PSARANDDLABDETAILS='").append(hm.get("rdLab")).append("',PSASCHOLARFELLOWDETAILS='").append(hm.get("scholarship")).append("',");
               sqry.append("PSACOLLABORATIVEDEGREEDETAILS='").append(hm.get("collaborativeDegree")).append("',PSAAUTHARTPUBDETAILS='").append(hm.get("authorshipAttribution")).append("',PSAINDSUPEDUCONFDETAILS='").append(hm.get("industrySupport")).append("'");
               sqry.append(",PSAGIFTCOMPENDETAILS='").append(hm.get("giftCompensation")).append("',PSAOTHERINDUSTRYDETAILS='").append(hm.get("industryRelatedActivity")).append("',");
               sqry.append("PSAHODAPPROVAL='").append(hm.get("approvalOfHOD")).append("',PSAVCAPPROVAL='").append(hm.get("approvalOfVC")).append("',PSAPROGRAMREMARKS='").append(hm.get("programRemarks")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where TRANSACTIONID='").append(hm.get("transactionID")).append("'");
               pStmt = dbConnection.prepareStatement(sqry.toString());
               pStmt.executeUpdate();

           }



                String Querry = " delete from AP#PSAINDGLECTUREDETAILS where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 

           if (hm.get("transactionID").equals("0")) {
               for (int x = 0; x < guestLectureList.size(); x++) {
                   eqry = new StringBuilder();
                   Map mp = (Map) guestLectureList.get(x);
                   try {
                       callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                       callableStatement.setString(1, "0001");
                       callableStatement.setString(2, "FBMId");
                       callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                       callableStatement.execute();
                       guestLectureID = callableStatement.getString(3);
                   } catch (Exception e) {
                       e.printStackTrace();
                   } finally {
                       if (callableStatement != null) {
                           callableStatement.close();
                       }
                   }
                   eqry.append("insert into  AP#PSAINDGLECTUREDETAILS ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                   eqry.append("PSAGUSETLECTUREID,PSAGUSETLECTURENAME,PSAGUESTLECTURETOPIC,PSASTARTDATE,");
                   eqry.append("PSAENDDATE,PSANOOFPARTICIPANTS,PSAGUESTLECTUREREMARKS,ENTRYBY,ENTRYDATE)");
                   eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(guestLectureID).append("',");
                   eqry.append("'").append(mp.get("guestLectureName")).append("','").append(mp.get("topic")).append("',");
                   eqry.append("to_date('").append(mp.get("glFromDate")).append("','dd-mm-yyyy'),to_date('").append(mp.get("glToDate")).append("','dd-mm-yyyy'),'");
                   eqry.append(mp.get("guestLectureNoOfParticipants")).append("','").append(mp.get("guestLectureRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                   pStmt = dbConnection.prepareStatement(eqry.toString());
                   pStmt.executeUpdate();
               }

           } else {
               for (int x = 0; x < guestLectureList.size(); x++) {
                   eqry = new StringBuilder();
                   Map mp = (Map) guestLectureList.get(x);
                   try {
                       callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                       callableStatement.setString(1, "0001");
                       callableStatement.setString(2, "FBMId");
                       callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                       callableStatement.execute();
                       guestLectureID = callableStatement.getString(3);
                   } catch (Exception e) {
                       e.printStackTrace();
                   } finally {
                       if (callableStatement != null) {
                           callableStatement.close();
                       }
                   }
                   eqry.append("insert into  AP#PSAINDGLECTUREDETAILS ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                   eqry.append("PSAGUSETLECTUREID,PSAGUSETLECTURENAME,PSAGUESTLECTURETOPIC,PSASTARTDATE,");
                   eqry.append("PSAENDDATE,PSANOOFPARTICIPANTS,PSAGUESTLECTUREREMARKS,ENTRYBY,ENTRYDATE)");
                   eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(hm.get("transactionID")).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(guestLectureID).append("',");
                   eqry.append("'").append(mp.get("guestLectureName")).append("','").append(mp.get("topic")).append("',");
                   eqry.append("to_date('").append(mp.get("glFromDate")).append("','dd-mm-yyyy'),to_date('").append(mp.get("glToDate")).append("','dd-mm-yyyy'),'");
                   eqry.append(mp.get("guestLectureNoOfParticipants")).append("','").append(mp.get("guestLectureRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                   pStmt = dbConnection.prepareStatement(eqry.toString());
                   pStmt.executeUpdate();
               }
           }
           
                Querry = " delete from AP#PSAINDVISITTOURDETAILS where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 

           if (hm.get("transactionID").equals("0")) {
               for (int x = 0; x < industryVisitedList.size(); x++) {
                   eqry = new StringBuilder();
                   Map mp = (Map) industryVisitedList.get(x);
                   try {
                       callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                       callableStatement.setString(1, "0001");
                       callableStatement.setString(2, "FBMId");
                       callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                       callableStatement.execute();
                       industryVisitedID = callableStatement.getString(3);
                   } catch (Exception e) {
                       e.printStackTrace();
                   } finally {
                       if (callableStatement != null) {
                           callableStatement.close();
                       }
                   }
                   eqry.append("insert into  AP#PSAINDVISITTOURDETAILS ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                   eqry.append("PSAINDUSTRIALVISITNAMEID,PSAINDUSTRIALVISITNAME,PSAINDTOURDETAILS,PSASTARTDATE,");
                   eqry.append("PSAENDDATE,PSANOOFPARTICIPANTS,PSAINDVISITREMARKS,ENTRYBY,ENTRYDATE)");
                   eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(industryVisitedID).append("',");
                   eqry.append("'").append(mp.get("industryVisitedName")).append("','").append(mp.get("tourDetails")).append("',");
                   eqry.append("to_date('").append(mp.get("ivFromDate")).append("','dd-mm-yyyy'),to_date('").append(mp.get("ivToDate")).append("','dd-mm-yyyy'),'");
                   eqry.append(mp.get("industryVisitedNoOfParticipants")).append("','").append(mp.get("industryVisitedRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                   pStmt = dbConnection.prepareStatement(eqry.toString());
                   pStmt.executeUpdate();
               }

           } else {
               for (int x = 0; x < industryVisitedList.size(); x++) {
                   eqry = new StringBuilder();
                   Map mp = (Map) industryVisitedList.get(x);
                   try {
                       callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                       callableStatement.setString(1, "0001");
                       callableStatement.setString(2, "FBMId");
                       callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                       callableStatement.execute();
                       industryVisitedID = callableStatement.getString(3);
                   } catch (Exception e) {
                       e.printStackTrace();
                   } finally {
                       if (callableStatement != null) {
                           callableStatement.close();
                       }
                   }
                   eqry.append("insert into  AP#PSAINDVISITTOURDETAILS ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                   eqry.append("PSAINDUSTRIALVISITNAMEID,PSAINDUSTRIALVISITNAME,PSAINDTOURDETAILS,PSASTARTDATE,");
                   eqry.append("PSAENDDATE,PSANOOFPARTICIPANTS,PSAINDVISITREMARKS,ENTRYBY,ENTRYDATE)");
                   eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(hm.get("transactionID")).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(industryVisitedID).append("',");
                   eqry.append("'").append(mp.get("industryVisitedName")).append("','").append(mp.get("tourDetails")).append("',");
                   eqry.append("to_date('").append(mp.get("ivFromDate")).append("','dd-mm-yyyy'),to_date('").append(mp.get("ivToDate")).append("','dd-mm-yyyy'),'");
                   eqry.append(mp.get("industryVisitedNoOfParticipants")).append("','").append(mp.get("industryVisitedRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                   pStmt = dbConnection.prepareStatement(eqry.toString());
                   pStmt.executeUpdate();
               }
           }
           
           
                Querry = " delete from AP#PSAINDLEDTRAINDETAILS where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 

           if (hm.get("transactionID").equals("0")) {
               for (int x = 0; x < industryLedTrainingList.size(); x++) {
                   eqry = new StringBuilder();
                   Map mp = (Map) industryLedTrainingList.get(x);
                   try {
                       callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                       callableStatement.setString(1, "0001");
                       callableStatement.setString(2, "FBMId");
                       callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                       callableStatement.execute();
                       industryLedTrainingID = callableStatement.getString(3);
                   } catch (Exception e) {
                       e.printStackTrace();
                   } finally {
                       if (callableStatement != null) {
                           callableStatement.close();
                       }
                   }
                   eqry.append("insert into  AP#PSAINDLEDTRAINDETAILS ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                   eqry.append("PSAINDLEDTRAININGID,PSAINDLEDTRAININGNAME,PSAINDLEDTRAININGTOPIC,PSASTARTDATE,");
                   eqry.append("PSAENDDATE,PSANOOFPARTICIPANTS,PSAINDLEDTRAININGREMARKS,ENTRYBY,ENTRYDATE)");
                   eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(industryLedTrainingID).append("',");
                   eqry.append("'").append(mp.get("industryLedTrainingName")).append("','").append(mp.get("topicOfTheTraining")).append("',");
                   eqry.append("to_date('").append(mp.get("itFromDate")).append("','dd-mm-yyyy'),to_date('").append(mp.get("itToDate")).append("','dd-mm-yyyy'),'");
                   eqry.append(mp.get("industryLedTrainingNoOfParticipants")).append("','").append(mp.get("industryLedTrainingRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                   pStmt = dbConnection.prepareStatement(eqry.toString());
                   pStmt.executeUpdate();
               }

           } else {
               for (int x = 0; x < industryLedTrainingList.size(); x++) {
                   eqry = new StringBuilder();
                   Map mp = (Map) industryLedTrainingList.get(x);
                   try {
                       callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                       callableStatement.setString(1, "0001");
                       callableStatement.setString(2, "FBMId");
                       callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                       callableStatement.execute();
                       industryLedTrainingID = callableStatement.getString(3);
                   } catch (Exception e) {
                       e.printStackTrace();
                   } finally {
                       if (callableStatement != null) {
                           callableStatement.close();
                       }
                   }
                    eqry.append("insert into  AP#PSAINDLEDTRAINDETAILS ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                   eqry.append("PSAINDLEDTRAININGID,PSAINDLEDTRAININGNAME,PSAINDLEDTRAININGTOPIC,PSASTARTDATE,");
                   eqry.append("PSAENDDATE,PSANOOFPARTICIPANTS,PSAINDLEDTRAININGREMARKS,ENTRYBY,ENTRYDATE)");
                   eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(hm.get("transactionID")).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(industryLedTrainingID).append("',");
                   eqry.append("'").append(mp.get("industryLedTrainingName")).append("','").append(mp.get("topicOfTheTraining")).append("',");
                   eqry.append("to_date('").append(mp.get("itFromDate")).append("','dd-mm-yyyy'),to_date('").append(mp.get("itToDate")).append("','dd-mm-yyyy'),'");
                   eqry.append(mp.get("industryLedTrainingNoOfParticipants")).append("','").append(mp.get("industryLedTrainingRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                   pStmt = dbConnection.prepareStatement(eqry.toString());
                   pStmt.executeUpdate();
               }
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
              if(!hm.get("searchbox").equals("")){
              searchBoxValue="and (AD.TRANSACTIONID like '%"+hm.get("searchbox")+"%' or dm.department like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or AD.TRANSACTIONDATE like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or AD.PSARANDDLABDETAILS like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or AD.PSAOTHERINDUSTRYDETAILS like '%"+hm.get("searchbox")+"%')";
              }
             
               sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (TRANSACTIONID) Totalrecord FROM  AP#PSAINDUSTRIALDETAILS) a,\n"
                      + "  (SELECT *\n"
                      + "  FROM (select NVL(AD.TRANSACTIONID,'')TRANSACTIONID,"
                      + "to_char(AD.TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                      + "NVL(dm.department,'')department,"
                      + "NVL(AD.PSARANDDLABDETAILS,'') PSARANDDLABDETAILS,"
                      + "NVL(AD.PSAOTHERINDUSTRYDETAILS,'')PSAOTHERINDUSTRYDETAILS,"
                      + "row_number() over (order by AD.transactionid desc)  R from AP#PSAINDUSTRIALDETAILS AD,DEPARTMENTMASTER DM"
                      + " where AD.DEPARTMENTCODE=DM.DEPARTMENTCODE " + searchBoxValue + ")\n"
                      + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
              int k = 1;
              pStmt = dbConnection.prepareStatement(sqry.toString());
              rs = pStmt.executeQuery();
              while (rs.next()) {
                  data = new HashMap();
                  data.put("slno",rs.getString(7));
                  data.put("totalrecords", rs.getString(1));
                  data.put("transactionID", rs.getString(2));
                  data.put("transactiondate", rs.getString(3));
                  data.put("department", rs.getString(4));
                  data.put("rdLab", rs.getString(5));
                  data.put("industryRelatedActivity", rs.getString(6));
                  tm.put(k, data);
                  k++;
              }
          } catch (Exception e) {
              e.printStackTrace();
          }
           if(tm.isEmpty())
          {
              tm.put("0","0");
          }
          return tm;
      }
        
        private Map selectForUpdate(Map hm) {
         StringBuffer sqry = new StringBuffer();
         TreeMap tm =new TreeMap();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
         Map SelectData2 = new HashMap();
         Map SelectData3 = new HashMap();
         int k = 1;
             try {
                sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                        + "nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(PSARANDDLABDETAILS,'')PSARANDDLABDETAILS,"
                        + "nvl(PSASCHOLARFELLOWDETAILS,'')PSASCHOLARFELLOWDETAILS,nvl(PSACOLLABORATIVEDEGREEDETAILS,'')PSACOLLABORATIVEDEGREEDETAILS,"
                        + "nvl(PSAAUTHARTPUBDETAILS,'')PSAAUTHARTPUBDETAILS,nvl(PSAINDSUPEDUCONFDETAILS,'')PSAINDSUPEDUCONFDETAILS,"
                        + "nvl(PSAGIFTCOMPENDETAILS,'')PSAGIFTCOMPENDETAILS,"
                        + "nvl(PSAOTHERINDUSTRYDETAILS,'')PSAOTHERINDUSTRYDETAILS,nvl(PSAHODAPPROVAL,'')PSAHODAPPROVAL,"
                        + "nvl(PSAVCAPPROVAL,'')PSAVCAPPROVAL,"
                        + "nvl(PSAPROGRAMREMARKS,'')PSAPROGRAMREMARKS from AP#PSAINDUSTRIALDETAILS");
                sqry.append(" where ").append( "TRANSACTIONID='").append(hm.get("transactionID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    
                        SelectData.put("transactionID",hm.get("transactionID"));
                        SelectData.put("transactionDate",rs.getString(1));
                        SelectData.put("departmentCode",rs.getString(2));
                        SelectData.put("randDLabDetails",rs.getString(3));
                        SelectData.put("scholarFellowshipDetails",rs.getString(4));
                        SelectData.put("collaborativeDegreeDetails",rs.getString(5));
                        SelectData.put("authorShipAttributionDetails",rs.getString(6));
                        SelectData.put("industrySupportDetails",rs.getString(7));
                        SelectData.put("giftCompensationDetails",rs.getString(8));
                        SelectData.put("industryRelatedActivityDetails",rs.getString(9));
                        SelectData.put("hodApproval",rs.getString(10));
                        SelectData.put("vcApproval",rs.getString(11));
                        SelectData.put("programRemarks",rs.getString(12));
                        
                   
                }
                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,"
                        + "to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,nvl(PSAGUSETLECTUREID,'')PSAGUSETLECTUREID,"
                        + "nvl(PSAGUSETLECTURENAME,'')PSAGUSETLECTURENAME,nvl(PSAGUESTLECTURETOPIC,'')PSAGUESTLECTURETOPIC,"
                        + "to_char(PSASTARTDATE,'dd-mm-yyyy')PSASTARTDATE,to_char(PSAENDDATE,'dd-mm-yyyy')PSAENDDATE,"
                        + "nvl(PSANOOFPARTICIPANTS,'')PSANOOFPARTICIPANTS,nvl(PSAGUESTLECTUREREMARKS,'')PSAGUESTLECTUREREMARKS"
                        + " FROM AP#PSAINDGLECTUREDETAILS");
                sqry.append(" where ").append( "TRANSACTIONID='").append(hm.get("transactionID")).append("'");
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData1 = new HashMap();
                        SelectData1.put("transactionID",rs.getString(1));
                        SelectData1.put("transactionDate",rs.getString(2));
                        SelectData1.put("guestLectureID",rs.getString(3));
                        SelectData1.put("guestLectureName",rs.getString(4));
                        SelectData1.put("topic",rs.getString(5));
                        SelectData1.put("glFromDate",rs.getString(6));
                        SelectData1.put("glToDate",rs.getString(7));
                        SelectData1.put("guestLectureNoOfParticipants",rs.getString(8));
                        SelectData1.put("guestLectureRemarks",rs.getString(9));
                        tm.put(k, SelectData1);
                        k++;
                        
                   
                }
                SelectData.put("guestLectureMap", tm);
                k=1;
                sqry = new StringBuffer();
                tm =new TreeMap();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,"
                        + "to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,nvl(PSAINDUSTRIALVISITNAMEID,'')PSAINDUSTRIALVISITNAMEID,"
                        + "nvl(PSAINDUSTRIALVISITNAME,'')PSAINDUSTRIALVISITNAME,nvl(PSAINDTOURDETAILS,'')PSAINDTOURDETAILS,"
                        + "to_char(PSASTARTDATE,'dd-mm-yyyy')PSASTARTDATE,to_char(PSAENDDATE,'dd-mm-yyyy')PSAENDDATE,"
                        + "nvl(PSANOOFPARTICIPANTS,'')PSANOOFPARTICIPANTS,nvl(PSAINDVISITREMARKS,'')PSAINDVISITREMARKS"
                        + " FROM AP#PSAINDVISITTOURDETAILS");
                sqry.append(" where ").append( "TRANSACTIONID='").append(hm.get("transactionID")).append("'");
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData2 = new HashMap();
                        SelectData2.put("transactionID",rs.getString(1));
                        SelectData2.put("transactionDate",rs.getString(2));
                        SelectData2.put("industrialVisitNameID",rs.getString(3));
                        SelectData2.put("industryVisitedName",rs.getString(4));
                        SelectData2.put("tourDetails",rs.getString(5));
                        SelectData2.put("ivFromDate",rs.getString(6));
                        SelectData2.put("ivToDate",rs.getString(7));
                        SelectData2.put("industryVisitedNoOfParticipants",rs.getString(8));
                        SelectData2.put("industryVisitedRemarks",rs.getString(9));
                        tm.put(k, SelectData2);
                        k++;
                        
                   
                }
                SelectData.put("industryVisitedMap", tm);
                k=1;
                sqry = new StringBuffer();
                tm =new TreeMap();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,"
                        + "to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,nvl(PSAINDLEDTRAININGID,'')PSAINDLEDTRAININGID,"
                        + "nvl(PSAINDLEDTRAININGNAME,'')PSAINDLEDTRAININGNAME,nvl(PSAINDLEDTRAININGTOPIC,'')PSAINDLEDTRAININGTOPIC,"
                        + "to_char(PSASTARTDATE,'dd-mm-yyyy')PSASTARTDATE,to_char(PSAENDDATE,'dd-mm-yyyy')PSAENDDATE,"
                        + "nvl(PSANOOFPARTICIPANTS,'')PSANOOFPARTICIPANTS,nvl(PSAINDLEDTRAININGREMARKS,'')PSAINDLEDTRAININGREMARKS"
                        + " FROM AP#PSAINDLEDTRAINDETAILS");
                sqry.append(" where ").append( "TRANSACTIONID='").append(hm.get("transactionID")).append("'");
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData3 = new HashMap();
                        SelectData3.put("transactionID",rs.getString(1));
                        SelectData3.put("transactionDate",rs.getString(2));
                        SelectData3.put("industryLedTrainingID",rs.getString(3));
                        SelectData3.put("industryLedTrainingName",rs.getString(4));
                        SelectData3.put("topicOfTheTraining",rs.getString(5));
                        SelectData3.put("itFromDate",rs.getString(6));
                        SelectData3.put("itToDate",rs.getString(7));
                        SelectData3.put("industryLedTrainingNoOfParticipants",rs.getString(8));
                        SelectData3.put("industryLedTrainingRemarks",rs.getString(9));
                        tm.put(k, SelectData3);
                        k++;
                        
                   
                }
                SelectData.put("industryLedTrainingMap", tm);
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
      
      
      
    public String getDepartmentCode(String department)
     {
     String departmentCode="";
     try{
     String qry="select departmentcode from departmentmaster where department='"+department+"'";
     pStmt = dbConnection.prepareStatement(qry);
     rs = pStmt.executeQuery();
     if(rs.next())
     {
         departmentCode=rs.getString(1);
     }
     }catch(Exception e)
     {
         e.printStackTrace();;
     }
     return departmentCode;
     }
    
    
    private Map getDeleteData(Map hm) {
        int k[]={};
          try {
           Statement st= dbConnection.createStatement();
            String qry1 = "delete from AP#PSAINDUSTRIALFEEDBACK where transactionid = '" + hm.get("transactionID") + "'";
            st.addBatch(qry1);
            String qry2 = "delete from AP#PSAINDGLECTUREDETAILS where transactionid = '" + hm.get("transactionID") + "'";
            st.addBatch(qry2);
            String qry3 = "delete from AP#PSAINDVISITTOURDETAILS where transactionid = '" + hm.get("transactionID") + "'";
            st.addBatch(qry3);
            String qry4 = "delete from AP#PSAINDLEDTRAINDETAILS where transactionid = '" + hm.get("transactionID") + "'";
            st.addBatch(qry4);
            String qry5 = "delete from AP#PSAINDUSTRIALDETAILS where transactionid = '" + hm.get("transactionID") + "'";
            st.addBatch(qry5);
            st.executeBatch();

        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return new HashMap();
    }
}
