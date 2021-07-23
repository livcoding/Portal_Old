/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class WorkShopFeedbackDB {
    
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public WorkShopFeedbackDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectHeadingInfo,saveupdate, select, Delete, SelectforUpdate,chkUniqueValue
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (WorkShopFeedbackDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectHeadingInfo:
                    responseString = mapper.writeValueAsString(selectHeadingInfo(hm));
                    break;
                case saveupdate:
                    responseString =mapper.writeValueAsString(SaveUpdateData(hm));
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
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     
     private Map selectHeadingInfo(Map hm) {
        StringBuilder sqry = new StringBuilder();
        Map SelectData = new HashMap();
        try {
            
            
            sqry.append("select to_char(awd.transactiondate,'dd-mm-yyyy')transactiondate,");
            sqry.append("nvl(dm.department,'')department,");
            sqry.append("nvl(awd.psaprogramtitle,'')programtitle,");
            sqry.append("nvl(awd.psaprogramtype,'')programtype,");
            sqry.append("to_char(awd.psastartdate,'dd-mm-yyyy')startdate,");
            sqry.append("to_char(awd.psaenddate,'dd-mm-yyyy')enddate,");
            sqry.append("nvl(awd.psatentativebudget,'')tentativebudget,");
            sqry.append("nvl(awd.psatargetaudience,'')targetaudience,");
            sqry.append("nvl(awf.psafundsraised,'')fundsraised,");
            sqry.append("nvl(awf.psafundsspent,'')fundsspent,");
            sqry.append("nvl(awf.psawebsiteupdate,'')websiteupdate,");
            sqry.append("nvl(awf.psadepartmentdatabaseupdate,'')databaseupdate,");
            sqry.append("nvl(awf.psaprogramremarks,'')programremarks,");
            sqry.append("nvl(awf.psaparticipantsfeedback,'')participantsfeedback,");
            sqry.append("nvl(awf.psaparticipantsfeedbackcomment,'')participantsfeedbackcomment,");
            sqry.append("nvl(awf.psaresourcepersonfeedback,'')resourcepersonfeedback,");
            sqry.append("nvl(awf.psaresourcepersonfbcomment,'')resourcepersonfbcomment, ");
            sqry.append("nvl(awf.psaorganizerfeedback,'')organizerfeedback,");
            sqry.append("nvl(awf.psaorganizercomment,'')organizercomment ");
            sqry.append("from ap#psaworkshopdetails awd left join departmentmaster dm on dm.departmentcode=awd.departmentcode left join ap#psaworkshopfeedback awf on ");
            sqry.append("  awd.companyid=awf.companyid and awd.instituteid=awf.instituteid");
            sqry.append(" and awd.transactionid=awf.transactionid and awd.transactiondate=awf.transactiondate");
            sqry.append(" where awd.transactionid='"+hm.get("transactionID")+"'");

                
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    
                        SelectData.put("transactionID",hm.get("transactionID"));
                        SelectData.put("transactionDate",rs.getString(1));
                        SelectData.put("department",rs.getString(2));
                        SelectData.put("programTitle",rs.getString(3));
                        SelectData.put("programType",getProgramType(rs.getString(4)));
                        SelectData.put("startDate",rs.getString(5));
                        SelectData.put("endDate",rs.getString(6));
                        SelectData.put("tentativeBudget",rs.getString(7));
                        SelectData.put("targetaudience",rs.getString(8));
                        SelectData.put("fundsraised",rs.getString(9));
                        SelectData.put("fundsspent",rs.getString(10));
                        SelectData.put("websiteupdate",rs.getString(11));
                        SelectData.put("databaseupdate",rs.getString(12));
                        SelectData.put("programremarks",rs.getString(13));
                        SelectData.put("participantsfeedback",rs.getString(14));
                        SelectData.put("participantsfeedbackcomment",rs.getString(15));
                        SelectData.put("resourcepersonfeedback",rs.getString(16));
                        SelectData.put("resourcepersonfbcomment",rs.getString(17));
                        SelectData.put("organizerFeedbackValue",rs.getString(18));
                        SelectData.put("organizerFeedbackComment",rs.getString(19));
                   
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SelectData;
    }
     
     private String SaveUpdateData(Map hm) 
   {
        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        Map tablehm = (HashMap) hm.get("para");
        String transactionIDCount="";
        try {
                String countQuery = "select count(transactionid) from ap#psaworkshopfeedback where transactionid='"+tablehm.get("transactionID")+"'";
            pStmt = dbConnection.prepareStatement(countQuery);
            rs = pStmt.executeQuery();
            if (rs.next()) {
                transactionIDCount = rs.getString(1);
            }
            
            if(transactionIDCount.equals("0")){
                eqry.append("insert into  AP#PSAWORKSHOPFEEDBACK ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("DEPARTMENTCODE,PSAPROGRAMTYPE,PSAPROGRAMTITLE,PSASTARTDATE,PSAENDDATE,PSAPARTICIPANTSFEEDBACK,PSAPARTICIPANTSFEEDBACKCOMMENT,");
                eqry.append("PSARESOURCEPERSONFEEDBACK,PSARESOURCEPERSONFBCOMMENT,PSAFUNDSRAISED,PSAFUNDSSPENT,PSAWEBSITEUPDATE,PSADEPARTMENTDATABASEUPDATE,PSAPROGRAMREMARKS,ENTRYBY,ENTRYDATE,PSAORGANIZERFEEDBACK,PSAORGANIZERCOMMENT)");
                eqry.append(" VALUES('").append(tablehm.get("companyid")).append("','").append(tablehm.get("instituteid")).append("','").append(tablehm.get("transactionID")).append("',to_date('").append(tablehm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(getDepartmentCode(tablehm.get("departmentName").toString().replaceAll("@@@", "&"))).append("',");
                eqry.append("'").append(getProgramTypeCode(tablehm.get("programType").toString())).append("','").append(tablehm.get("titleOfTheProgram")).append("',to_date('").append(tablehm.get("startDate")).append("','dd-mm-yyyy'),to_date('").append(tablehm.get("endDate")).append("','dd-mm-yyyy'),");
                eqry.append("'").append(tablehm.get("participantsFeedbackValue")).append("','").append(tablehm.get("participantsFeedbackComment")).append("',");
                eqry.append("'").append(tablehm.get("resourcePersonFeedbackValue")).append("','").append(tablehm.get("resourcePersonFeedbackComment")).append("',");
                eqry.append("'").append(tablehm.get("fundRaised")).append("','").append(tablehm.get("fundSpent")).append("',");
                eqry.append("'").append(tablehm.get("websiteUpdate")).append("','").append(tablehm.get("databaseUpdate")).append("',");
                eqry.append("'").append(tablehm.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'),").append("'").append(tablehm.get("organizerFeedbackValue")).append("','").append(tablehm.get("organizerFeedbackComment")).append("')");
            }else
            {
                sqry.append("Update AP#PSAWORKSHOPFEEDBACK set COMPANYID='").append(tablehm.get("companyid"));
                sqry.append("',INSTITUTEID='").append(tablehm.get("instituteid"));
                sqry.append("',TRANSACTIONDATE=to_date('").append(tablehm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",DEPARTMENTCODE='").append(getDepartmentCode(tablehm.get("departmentName").toString()));
                sqry.append("',PSAPROGRAMTYPE='").append(getProgramTypeCode(tablehm.get("programType").toString()));
                sqry.append("',PSAPROGRAMTITLE='").append(tablehm.get("titleOfTheProgram"));
                sqry.append("',PSASTARTDATE=to_date('").append(tablehm.get("startDate")).append("','dd-mm-yyyy')");
                sqry.append(",PSAENDDATE=to_date('").append(tablehm.get("endDate")).append("','dd-mm-yyyy')");
                sqry.append(",PSAPARTICIPANTSFEEDBACK='").append(tablehm.get("participantsFeedbackValue"));
                sqry.append("',PSAPARTICIPANTSFEEDBACKCOMMENT='").append(tablehm.get("participantsFeedbackComment"));
                sqry.append("',PSARESOURCEPERSONFEEDBACK='").append(tablehm.get("resourcePersonFeedbackValue"));
                sqry.append("',PSARESOURCEPERSONFBCOMMENT='").append(tablehm.get("resourcePersonFeedbackComment"));
                sqry.append("',PSAFUNDSRAISED='").append(tablehm.get("fundRaised"));
                sqry.append("',PSAFUNDSSPENT='").append(tablehm.get("fundSpent"));
                sqry.append("',PSAWEBSITEUPDATE='").append(tablehm.get("websiteUpdate"));
                sqry.append("',PSADEPARTMENTDATABASEUPDATE='").append(tablehm.get("databaseUpdate"));
                sqry.append("',PSAPROGRAMREMARKS='").append(tablehm.get("remarks")).append("'");
                sqry.append(",ENTRYBY='").append(hm.get("entryBy")).append("'");
                sqry.append(",ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')");
                sqry.append(",PSAORGANIZERFEEDBACK='").append(tablehm.get("organizerFeedbackValue")).append("'");
                sqry.append(",PSAORGANIZERCOMMENT='").append(tablehm.get("organizerFeedbackComment")).append("'");
                sqry.append(" where TRANSACTIONID='").append(tablehm.get("transactionID")).append("'");
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
    
     
     public String getProgramType(String programType)
    {
        String programTypeValue = "";
        if (programType.equals("W")) {
            programTypeValue = "Work Shop";
        } else if (programType.equals("S")) {
            programTypeValue = "Special Course";
        } else if (programType.equals("G")) {
            programTypeValue = "Guest Lecture";
        } else {
            programTypeValue = "Faculty Development Program";
        }

        return programTypeValue;
    }
     
     public String getProgramTypeCode(String program)
    {
        String programTypeValue = "";
        if (program.equals("Work Shop")) {
            programTypeValue = "W";
        } else if (program.equals("Special Course")) {
            programTypeValue = "S";
        } else if (program.equals("Guest Lecture")) {
            programTypeValue = "G";
        } else {
            programTypeValue = "F";
        }

        return programTypeValue;
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
     
     
     private Map getSelectData(Map hm) {
          Map data = new HashMap();
          TreeMap tm = new TreeMap();
          String searchBoxValue="";
          StringBuffer sqry = new StringBuffer();
          try {
              if(!hm.get("searchbox").equals("")){
              searchBoxValue="and (awf.transactionid like '%"+hm.get("searchbox")+"%' or awf.transactiondate like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or dm.department like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or awf.psaprogramtitle like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or awf.psastartdate like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or awf.psaenddate like '%"+hm.get("searchbox")+"%')";
              }
             
               sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (transactionid) Totalrecord FROM  ap#psaworkshopfeedback) a,\n" +
                        "  (SELECT *\n" +
                        "  FROM (select nvl(awf.transactionid,'')transactionid,"
                       + "to_char(awf.transactiondate,'dd-mm-yyyy')transactiondate,"
                       + "nvl(dm.department,'')department,"
                       + "nvl(awf.psaprogramtitle,'') programtitle,"
                      + "to_char(awf.psastartdate,'dd-mm-yyyy')psastartdate,"
                      + "to_char(awf.psaenddate,'dd-mm-yyyy')psaenddate,"
                       + "row_number() over (order by awf.transactionid desc)  R from ap#psaworkshopfeedback awf,departmentmaster dm"
                      + " where dm.departmentcode=awf.departmentcode "+searchBoxValue+")\n" +
"         WHERE r > "+hm.get("spg")+" AND r <= "+hm.get("epg")+") b ");
              int k = 1;
              pStmt = dbConnection.prepareStatement(sqry.toString());
              rs = pStmt.executeQuery();
              while (rs.next()) {
                  data = new HashMap();
                  data.put("slno",rs.getString(8));
                  data.put("totalrecords", rs.getString(1));
                  data.put("transactionid", rs.getString(2));
                  data.put("transactiondate", rs.getString(3));
                  data.put("department", rs.getString(4));
                  data.put("programtitle", rs.getString(5));
                  data.put("startdate", rs.getString(6));
                  data.put("enddate", rs.getString(7));
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
        Map SelectData = new HashMap();
        try {
            
            
                sqry.append(" select nvl(awf.transactionid,'')transactionid," );
                sqry.append("to_char(awf.transactiondate,'dd-mm-yyyy')transactiondate," );
                sqry.append("nvl(dm.department,'')department," );
                sqry.append("nvl(awf.psaprogramtype,'')programtype," );
                sqry.append("nvl(awf.psaprogramtitle,'')programtitle,");
                sqry.append("to_char(awf.psastartdate,'dd-mm-yyyy')startdate," );
                sqry.append("to_char(awf.psaenddate,'dd-mm-yyyy')enddate," );
                sqry.append("nvl(awd.psatargetaudience,'')targetaudience,");
                sqry.append("nvl(awd.psatentativebudget,'')tentativebudget,");
                sqry.append("nvl(awf.psaparticipantsfeedback,'')participantsfeedback,");
                sqry.append("nvl(awf.psaparticipantsfeedbackcomment,'')participantsfeedbackcomment,");
                sqry.append("nvl(awf.psaresourcepersonfeedback,'')resourcepersonfeedback,");
                sqry.append("nvl(awf.psaresourcepersonfbcomment,'')resourcepersonfbcomment,");
                sqry.append("nvl(awf.psafundsraised,'')fundsraised,");
                sqry.append("nvl(awf.psafundsspent,'')fundsspent,");
                sqry.append("nvl(awf.psawebsiteupdate,'')websiteupdate,");
                sqry.append("nvl(awf.psadepartmentdatabaseupdate,'')databaseupdate,");
                sqry.append("nvl(awf.psaprogramremarks,'')programremarks,");
                sqry.append("nvl(awf.psaorganizerfeedback,'')organizerfeedback,");
                sqry.append("nvl(awf.psaorganizercomment,'')organizercomment ");
                sqry.append(" from ap#psaworkshopfeedback awf,departmentmaster dm,ap#psaworkshopdetails awd where dm.departmentcode=awf.departmentcode");
                sqry.append(" and awf.companyid=awd.companyid and awf.instituteid=awd.instituteid");
                sqry.append(" and awf.transactionid=awd.transactionid and awf.transactiondate=awd.transactiondate");
                sqry.append(" and awf.transactionid='").append(hm.get("transactionid")).append("'");
                
                
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    
                        SelectData.put("transactionid",rs.getString(1));
                        SelectData.put("transactiondate",rs.getString(2));
                        SelectData.put("department",rs.getString(3));
                        SelectData.put("programtype",getProgramType(rs.getString(4)));
                        SelectData.put("programtitle",rs.getString(5));
                        SelectData.put("startdate",rs.getString(6));
                        SelectData.put("enddate",rs.getString(7));
                        SelectData.put("targetaudience",rs.getString(8));
                        SelectData.put("tentativebudget",rs.getString(9));
                        SelectData.put("participantsfeedback",rs.getString(10));
                        SelectData.put("participantsfeedbackcomment",rs.getString(11));
                        SelectData.put("resourcepersonfeedback",rs.getString(12));
                        SelectData.put("resourcepersonfbcomment",rs.getString(13));
                        SelectData.put("fundsraised",rs.getString(14));
                        SelectData.put("fundsspent",rs.getString(15));
                        SelectData.put("websiteupdate",rs.getString(16));
                        SelectData.put("databaseupdate",rs.getString(17));
                        SelectData.put("programremarks",rs.getString(18));
                        SelectData.put("organizerFeedbackValue",rs.getString(19));
                        SelectData.put("organizerFeedbackComment",rs.getString(20));
                        
                   
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SelectData;
    }
      
       private Map getDeleteData(Map hm) {
        try {
            String Querry = " delete from ap#psaworkshopfeedback where transactionid = '" + hm.get("transactionID") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new HashMap();
    }
      
}
