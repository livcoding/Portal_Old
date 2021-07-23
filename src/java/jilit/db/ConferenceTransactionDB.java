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
public class ConferenceTransactionDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    public ConferenceTransactionDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        setDays,saveupdate, select, Delete, SelectforUpdate,chkUniqueValue
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (ConferenceTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
                case saveupdate:
                    responseString =SaveUpdateData(hm);
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
                case setDays:
                    responseString = mapper.writeValueAsString(getDays(hm));
                    break;
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     
     
    private String SaveUpdateData(Map hm) {

        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        String id = "";
        try {
            if (hm.get("conferenceID").equals("0")) {
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

                eqry.append("insert into  AP#PSACONFERENCEDETAILS ( COMPANYID,INSTITUTEID,DEPARTMENTCODE,CONFERENCEID,");
                eqry.append("CONFERENCETYPE,CONFERENCENAME,SPECIFICFOCUSAREA,OBJECTIVES,");
                eqry.append("PROPOSEDOUTCOMES,PROPOSEDBUDGET,SUPPORTORGNAME,");
                eqry.append("SUPPORTORGBUDGET,CONFERENCESTARTDATE,CONFERENCEENDDATE,PARTICIPANTSNO,");
                eqry.append("PAPERSNO,KEYNOTESPEAKERSNO,KEYNOTESPEAKERSNAMES,INVITEDSPEAKERSNO,");
                eqry.append("INVITEDSPEAKERSNAMES,PARALLELSESSIONNO,TUTORIALWITHCONFERENCE,ANNUALEVENT,");
                eqry.append("GAINAREA,ORGANIZINGSECRETARYNAME,HODAPPROVAL,");
                eqry.append("VCAPPROVAL,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','")
                .append(hm.get("instituteid")).append("','")
                .append(hm.get("departmentName")).append("','")
                .append(id).append("','")
                .append(hm.get("typeOfConference")).append("','")
                .append(hm.get("proposedConferenceName")).append("','")
                .append(hm.get("specificFocusArea")).append("','")
                .append(hm.get("objectives")).append("','")
                .append(hm.get("proposedOutComes")).append("','")
                .append(hm.get("proposedBudget")).append("','")
                .append(hm.get("supportingOrgName")).append("','")
                .append(hm.get("supportingOrgAmount")).append("',to_date('")
                .append(hm.get("conferenceStartDate")).append("','dd-mm-yyyy'),to_date('")
                .append(hm.get("conferenceEndDate")).append("','dd-mm-yyyy'),'")
                .append(hm.get("expectedParticipants")).append("','")
                .append(hm.get("expectedPapers")).append("','")
                .append(hm.get("noOfKeynoteSpeakers")).append("','")
                .append(hm.get("keynoteSpeakerName")).append("','")
                .append(hm.get("noOfInvitedSpeakers")).append("','")
                .append(hm.get("invitedSpeakerName")).append("','")
                .append(hm.get("noOfParallelSessions")).append("','")
                .append(hm.get("tutorialWithConference")).append("','")
                .append(hm.get("annualEvent")).append("','")
                .append(hm.get("gainArea")).append("','")
                .append(hm.get("nameOfOrganizingSecretary")).append("','")
                .append(hm.get("approvalOfHOD")).append("','")
                .append(hm.get("approvalOfVC")).append("','")
                .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();

            } else {
                sqry.append("Update AP#PSACONFERENCEDETAILS set COMPANYID='").append(hm.get("companyid"))
                .append("',INSTITUTEID='").append(hm.get("instituteid"))
                .append("',DEPARTMENTCODE='").append(hm.get("departmentName"))
                .append("',CONFERENCETYPE='").append(hm.get("typeOfConference"))
                .append("',CONFERENCENAME='").append(hm.get("proposedConferenceName"));
                sqry.append("',SPECIFICFOCUSAREA='").append(hm.get("specificFocusArea"))
                .append("',OBJECTIVES='").append(hm.get("objectives")).append("',");
                sqry.append("PROPOSEDOUTCOMES='").append(hm.get("proposedOutComes"))
                .append("',PROPOSEDBUDGET='").append(hm.get("proposedBudget"))
                .append("',SUPPORTORGNAME='").append(hm.get("supportingOrgName"))
                .append("',SUPPORTORGBUDGET='").append(hm.get("supportingOrgAmount"))
                .append("',CONFERENCESTARTDATE=to_date('").append(hm.get("conferenceStartDate")).append("','dd-mm-yyyy')")
                .append(",CONFERENCEENDDATE=to_date('").append(hm.get("conferenceEndDate")).append("','dd-mm-yyyy')")
                .append(",PARTICIPANTSNO='").append(hm.get("expectedParticipants"))
                .append("',PAPERSNO='").append(hm.get("expectedPapers"))
                .append("',KEYNOTESPEAKERSNO='").append(hm.get("noOfKeynoteSpeakers"))
                .append("',KEYNOTESPEAKERSNAMES='").append(hm.get("keynoteSpeakerName"))
                .append("',INVITEDSPEAKERSNO='").append(hm.get("noOfInvitedSpeakers"))
                .append("',INVITEDSPEAKERSNAMES='").append(hm.get("invitedSpeakerName"))
                .append("',PARALLELSESSIONNO='").append(hm.get("noOfParallelSessions"))
                .append("',TUTORIALWITHCONFERENCE='").append(hm.get("tutorialWithConference"))
                .append("',ANNUALEVENT='").append(hm.get("annualEvent"))
                .append("',GAINAREA='").append(hm.get("gainArea"))
                .append("',ORGANIZINGSECRETARYNAME='").append(hm.get("nameOfOrganizingSecretary"))
                .append("',HODAPPROVAL='").append(hm.get("approvalOfHOD"))
                .append("',VCAPPROVAL='").append(hm.get("approvalOfVC"))
                .append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where CONFERENCEID='").append(hm.get("conferenceID")).append("'");;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                pStmt.executeUpdate();
                id = hm.get("conferenceID").toString();

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
              if(!hm.get("searchbox").equals("")){
              searchBoxValue="and (acd.conferencename like '%"+hm.get("searchbox")+"%' or dm.department like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or acd.proposedbudget like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or acd.conferencestartdate like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or acd.conferenceenddate like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or acd.keynotespeakersno like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or acd.keynotespeakersnames like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or acd.organizingsecretaryname like '%"+hm.get("searchbox")+"%')";
              }
             
               sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (conferenceid) Totalrecord FROM  ap#psaconferencedetails where departmentcode='"+hm.get("departmentName")+"') a,\n"
                      + "  (SELECT *\n"
                      + "  FROM (select nvl(acd.conferenceid,'')conferenceid,"
                      + "nvl(dm.department,'')department,"
                      + "nvl(acd.conferencetype,'')conferencetype,"
                      + "nvl(acd.conferencename,'') conferencename,"
                      + "nvl(acd.specificfocusarea,'')specificfocusarea,"
                      + "nvl(acd.objectives,'')objectives,"
                      + "nvl(acd.proposedoutcomes,'')proposedoutcomes,"
                      + "nvl(acd.proposedbudget,'')proposedbudget,"
                      + "nvl(acd.supportorgname,'')supportorgname,"
                      + "nvl(acd.supportorgbudget,'')supportorgbudget,"
                      + "to_char(acd.conferencestartdate,'dd-mm-yyyy')conferencestartdate,"
                      + "to_char(acd.conferenceenddate,'dd-mm-yyyy')conferenceenddate,"
                      + "nvl(acd.participantsno,'')participantsno,"
                      + "nvl(acd.papersno,'')papersno,"
                      + "nvl(acd.keynotespeakersno,'')keynotespeakersno,"
                      + "nvl(acd.keynotespeakersnames,'')keynotespeakersnames,"
                      + "nvl(acd.invitedspeakersno,'')invitedspeakersno,"
                      + "nvl(acd.invitedspeakersnames,'')invitedspeakersnames,"
                      + "nvl(acd.parallelsessionno,'')parallelsessionno,"
                      + "nvl(acd.tutorialwithconference,'')tutorialwithconference,"
                      + "nvl(acd.annualevent,'')annualevent,"
                      + "nvl(acd.gainarea,'')gainarea,"
                      + "nvl(acd.organizingsecretaryname,'')organizingsecretaryname,"
                      + "nvl(acd.hodapproval,'')hodapproval,"
                      + "nvl(acd.vcapproval,'')vcapproval,"
                      + " row_number() over (order by acd.conferenceid desc)  R from ap#psaconferencedetails acd,departmentmaster dm"
                      + " where dm.departmentcode=acd.departmentcode and acd.departmentcode='"+hm.get("departmentName")+"' " + searchBoxValue + ")\n"
                      + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
              int k = 1;
              pStmt = dbConnection.prepareStatement(sqry.toString());
              rs = pStmt.executeQuery();
              while (rs.next()) {
                  data = new HashMap();
                  data.put("slno",rs.getString(27));
                  data.put("totalrecords", rs.getString(1));
                  data.put("conferenceID", rs.getString(2));
                  data.put("departmentName", rs.getString(3));
                  data.put("conferenceType", rs.getString(4));
                  data.put("conferenceName", rs.getString(5));
                  data.put("specificFocusArea", rs.getString(6));
                  data.put("objectives", rs.getString(7));
                  data.put("proposedOutComes", rs.getString(8));
                  data.put("proposedBudget", rs.getString(9));
                  data.put("supportOrgName", rs.getString(10));
                  data.put("supportOrgBudget", rs.getString(11));
                  data.put("conferenceStartDate", rs.getString(12));
                  data.put("conferenceEndDate", rs.getString(13));
                  data.put("participantsNo", rs.getString(14));
                  data.put("papersNo", rs.getString(15));
                  data.put("keynoteSpeakersNo", rs.getString(16));
                  data.put("keynoteSpeakersName", rs.getString(17));
                  data.put("invitedSpeakersNo", rs.getString(18));
                  data.put("invitedSpeakersNames", rs.getString(19));
                  data.put("parallelSessionNo", rs.getString(20));
                  data.put("tutorialWithConference", rs.getString(21));
                  data.put("annualEvent", rs.getString(22));
                  data.put("gainArea", rs.getString(23));
                  data.put("organizingSecretaryName", rs.getString(24));
                  data.put("hodApproval", rs.getString(25));
                  data.put("vcApproval", rs.getString(26));
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
                sqry.append(" select nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,"
                        + "nvl(CONFERENCETYPE,'')CONFERENCETYPE,nvl(CONFERENCENAME,'')CONFERENCENAME,"
                        + "nvl(SPECIFICFOCUSAREA,'')SPECIFICFOCUSAREA,nvl(OBJECTIVES,'')OBJECTIVES,"
                        + "nvl(PROPOSEDOUTCOMES,'')PROPOSEDOUTCOMES,nvl(PROPOSEDBUDGET,'')PROPOSEDBUDGET,"
                        + "nvl(SUPPORTORGNAME,'')SUPPORTORGNAME,"
                        + "nvl(SUPPORTORGBUDGET,'')SUPPORTORGBUDGET,to_char(CONFERENCESTARTDATE,'dd-mm-yyyy')CONFERENCESTARTDATE,"
                        + "to_char(CONFERENCEENDDATE,'dd-mm-yyyy')CONFERENCEENDDATE,"
                        + "nvl(PARTICIPANTSNO,'')PARTICIPANTSNO,"
                        + "nvl(PAPERSNO,'')PAPERSNO,nvl(KEYNOTESPEAKERSNO,'')KEYNOTESPEAKERSNO,"
                        + "nvl(KEYNOTESPEAKERSNAMES,'')KEYNOTESPEAKERSNAMES,nvl(INVITEDSPEAKERSNO,'')INVITEDSPEAKERSNO,"
                        + "nvl(INVITEDSPEAKERSNAMES,'')INVITEDSPEAKERSNAMES,nvl(PARALLELSESSIONNO,'')PARALLELSESSIONNO,"
                        + "nvl(TUTORIALWITHCONFERENCE,'')TUTORIALWITHCONFERENCE,nvl(ANNUALEVENT,'')ANNUALEVENT,"
                        + "nvl(GAINAREA,'')GAINAREA,nvl(ORGANIZINGSECRETARYNAME,'')ORGANIZINGSECRETARYNAME,"
                        + "nvl(HODAPPROVAL,'')HODAPPROVAL,"
                        + "nvl(VCAPPROVAL,'')VCAPPROVAL from AP#PSACONFERENCEDETAILS");
                sqry.append(" where ").append( "CONFERENCEID='").append(hm.get("conferenceID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("conferenceID",hm.get("conferenceID"));
                        SelectData.put("departmentCode",rs.getString(1));
                        SelectData.put("conferenceType",rs.getString(2));
                        SelectData.put("conferenceName",rs.getString(3));
                        SelectData.put("specificFocusArea",rs.getString(4));
                        SelectData.put("objectives",rs.getString(5));
                        SelectData.put("proposedOutComes",rs.getString(6));
                        SelectData.put("proposedBudget",rs.getString(7));
                        SelectData.put("supportOrgName",rs.getString(8));
                        SelectData.put("supportOrgBudget",rs.getString(9));
                        SelectData.put("conferenceStartDate",rs.getString(10));
                        SelectData.put("conferenceEndDate",rs.getString(11));
                        SelectData.put("participantsNo",rs.getString(12));
                        SelectData.put("papersNo",rs.getString(13));
                        SelectData.put("keyNoteSpeakerNo",rs.getString(14));
                        SelectData.put("keyNoteSpeakerName",rs.getString(15));
                        SelectData.put("invitedSpeakerNo",rs.getString(16));
                        SelectData.put("invitedSpeakerName",rs.getString(17));
                        SelectData.put("parallelSessionNo",rs.getString(18));
                        SelectData.put("tutorialWithConference",rs.getString(19));
                        SelectData.put("annualEvent",rs.getString(20));
                        SelectData.put("gainArea",rs.getString(21));
                        SelectData.put("organizingSecretaryName",rs.getString(22));
                        SelectData.put("hodApproval",rs.getString(23));
                        SelectData.put("vcApproval",rs.getString(24));
                }
                
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
    
     private Map getDeleteData(Map hm) {
        try {
            String Querry = " delete from ap#psaconferencedetails where conferenceid = '" + hm.get("conferenceID") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new HashMap();
    }
     
    public int getDays(Map hm) throws ParseException {
        int noOfDays = 0;
        String startDate = hm.get("conferenceStartDate").toString();
        String endDate = hm.get("conferenceEndDate").toString();
        Date fromDate = formatter.parse(startDate);
        Date toDate = formatter.parse(endDate);
        long diff = toDate.getTime() - fromDate.getTime();
        long diffDays = diff / (24 * 60 * 60 * 1000)+1;
        noOfDays = (int) diffDays;
        return noOfDays;
    }
}
