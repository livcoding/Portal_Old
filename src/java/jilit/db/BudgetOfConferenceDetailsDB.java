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
public class BudgetOfConferenceDetailsDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public BudgetOfConferenceDetailsDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectConferenceInfo,saveupdate, select, Delete, SelectforUpdate,setReceiptName,setExpenditureName
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (BudgetOfConferenceDetailsDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectConferenceInfo:
                    responseString = mapper.writeValueAsString(selectConferenceInfo(hm));
                    break;
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
                case setReceiptName:
                    responseString = mapper.writeValueAsString(setReceiptName(hm));
                    break;
                case setExpenditureName:
                    responseString = mapper.writeValueAsString(setExpenditureName(hm));
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     private Map selectConferenceInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();
        try {
            
            if(!hm.get("searchNames").equals("")){
              searchBoxValue="AND (ad.CONFERENCENAME like '%"+hm.get("searchNames")+"%')";
              }
            
                sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (CONFERENCEID) Totalrecord FROM AP#PSACONFERENCEDETAILS) a,\n"
                        +"(SELECT * FROM ( select nvl(ad.CONFERENCEID,'')CONFERENCEID,nvl(dm.DEPARTMENT,'')DEPARTMENT,nvl(ad.CONFERENCETYPE,'')CONFERENCETYPE,"
                        + "nvl(ad.CONFERENCENAME,'')CONFERENCENAME,nvl(ad.SPECIFICFOCUSAREA,'')SPECIFICFOCUSAREA,"
                        + "nvl(ad.OBJECTIVES,'')OBJECTIVES,nvl(ad.PROPOSEDOUTCOMES,'')PROPOSEDOUTCOMES,"
                        + "nvl(ad.PROPOSEDBUDGET,'')PROPOSEDBUDGET,nvl(ad.SUPPORTORGNAME,'')SUPPORTORGNAME,"
                        + "nvl(ad.SUPPORTORGBUDGET,'')SUPPORTORGBUDGET,to_char(ad.CONFERENCESTARTDATE,'dd-mm-yyyy')CONFERENCESTARTDATE,"
                        + "to_char(ad.CONFERENCEENDDATE,'dd-mm-yyyy')CONFERENCEENDDATE,nvl(ad.PARTICIPANTSNO,'')PARTICIPANTSNO,"
                        + "nvl(ad.PAPERSNO,'')PAPERSNO,nvl(ad.KEYNOTESPEAKERSNO,'')KEYNOTESPEAKERSNO,"
                        + "nvl(ad.KEYNOTESPEAKERSNAMES,'')KEYNOTESPEAKERSNAMES,nvl(ad.INVITEDSPEAKERSNO,'')INVITEDSPEAKERSNO,"
                        + "nvl(ad.INVITEDSPEAKERSNAMES,'')INVITEDSPEAKERSNAMES,nvl(ad.PARALLELSESSIONNO,'')PARALLELSESSIONNO,"
                        + "nvl(ad.TUTORIALWITHCONFERENCE,'')TUTORIALWITHCONFERENCE,nvl(ad.ANNUALEVENT,'')ANNUALEVENT,"
                        + "nvl(ad.GAINAREA,'')GAINAREA,nvl(ad.ORGANIZINGSECRETARYNAME,'')ORGANIZINGSECRETARYNAME,"
                        + "nvl(ad.HODAPPROVAL,'')HODAPPROVAL,nvl(ad.VCAPPROVAL,'')VCAPPROVAL,nvl(ad.DEPARTMENTCODE,'')DEPARTMENTCODE,ROWNUM R "
                        + "from AP#PSACONFERENCEDETAILS ad,departmentmaster dm WHERE ad.DEPARTMENTCODE=dm.DEPARTMENTCODE "
                        + ""+searchBoxValue+" order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                
                int k = 1;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("totalrecords",rs.getString(1));
                        SelectData.put("conferenceID",rs.getString(2));
                        SelectData.put("department",rs.getString(3));
                        SelectData.put("conferenceType",rs.getString(4));
                        SelectData.put("conferenceName",rs.getString(5));
                        SelectData.put("specificFocusArea",rs.getString(6));
                        SelectData.put("objectives",rs.getString(7));
                        SelectData.put("proposedOutComes",rs.getString(8));
                        SelectData.put("proposedBudget",rs.getString(9));
                        SelectData.put("supportOrgName",rs.getString(10));
                        SelectData.put("supportOrgBudget",rs.getString(11));
                        SelectData.put("conferenceStartDate",rs.getString(12));
                        SelectData.put("conferenceEndDate",rs.getString(13));
                        SelectData.put("participantsNo",rs.getString(14));
                        SelectData.put("papersNo",rs.getString(15));
                        SelectData.put("keyNoteSpeakerNo",rs.getString(16));
                        SelectData.put("keyNoteSpeakerName",rs.getString(17));
                        SelectData.put("invitedSpeakerNo",rs.getString(18));
                        SelectData.put("invitedSpeakerName",rs.getString(19));
                        SelectData.put("parallelSessionNo",rs.getString(20));
                        SelectData.put("tutorialWithConference",rs.getString(21));
                        SelectData.put("annualEvent",rs.getString(22));
                        SelectData.put("gainArea",rs.getString(23));
                        SelectData.put("organizingSecretaryName",rs.getString(24));
                        SelectData.put("hodApproval",rs.getString(25));
                        SelectData.put("vcApproval",rs.getString(26));
                        SelectData.put("departmentCode",rs.getString(27));
                        SelectData.put("sno", rs.getString(28));
                        tm.put(k, SelectData);
                        k++;
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
     
     public Map setReceiptName(Map hm1)
     {
         Map tempMap=new HashMap();
         try{
         String qry="select psarecexpname,aprecexptype from ap#psarecexpmaster where psarecexpcode='"+hm1.get("receiptCode")+"'";
         pStmt = dbConnection.prepareStatement(qry);
         rs = pStmt.executeQuery();
         while(rs.next())
         {
             tempMap.put("receiptName", rs.getString(1));
             tempMap.put("receiptType", rs.getString(2));
         }
         }catch(Exception e)
         {
             e.printStackTrace();
         }
         return tempMap;
     }
            
     public Map setExpenditureName(Map hm1)
     {
         Map tempMap=new HashMap();
         try{
         String qry="select psarecexpname,aprecexptype from ap#psarecexpmaster where psarecexpcode='"+hm1.get("expenditureCode")+"'";
         pStmt = dbConnection.prepareStatement(qry);
         rs = pStmt.executeQuery();
         while(rs.next())
         {
             tempMap.put("expenditureName", rs.getString(1));
             tempMap.put("expenditureType", rs.getString(2));
         }
         }catch(Exception e)
         {
             e.printStackTrace();
         }
         return tempMap;
     }
     
     
     private String SaveUpdateData(Map hm) {

        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        StringBuilder qryForReceipt = new StringBuilder();
        StringBuilder qryForExpenditure = new StringBuilder();
        String id = "";
        try {
            if (hm.get("budgetID").equals("0")) {
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

                eqry.append("insert into  AP#PSACONFERENCEBUDGET ( COMPANYID,INSTITUTEID,DEPARTMENTCODE,CONFERENCEID,");
                eqry.append("CONFERENCETYPE,CONFERENCENAME,BUDGETID,");
                eqry.append("KEYNOTESPEAKERSNO,KEYNOTESPEAKERSNAMES,INVITEDSPEAKERSNO,INVITEDSPEAKERSNAMES,SUPPORTORGNAME,");
                eqry.append("SUPPORTORGBUDGET,CONFERENCESTARTDATE,CONFERENCEENDDATE,");
                eqry.append("ORGANIZINGSECRETARYNAME,HODAPPROVAL,");
                eqry.append("VCAPPROVAL,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','")
                .append(hm.get("instituteid")).append("','")
                .append(hm.get("departmentCode")).append("','")
                .append(hm.get("conferenceID")).append("','")
                .append(hm.get("typeOfConference")).append("','")
                .append(hm.get("proposedConferenceName")).append("','")
                .append(id).append("','")
                .append(hm.get("noOfKeynoteSpeakers")).append("','")
                .append(hm.get("keynoteSpeakerName")).append("','")
                .append(hm.get("noOfInvitedSpeakers")).append("','")
                .append(hm.get("invitedSpeakerName")).append("','")
                .append(hm.get("supportingOrgName")).append("','")
                .append(hm.get("supportingOrgAmount")).append("',to_date('")
                .append(hm.get("conferenceStartDate")).append("','dd-mm-yyyy'),to_date('")
                .append(hm.get("conferenceEndDate")).append("','dd-mm-yyyy'),'")
                .append(hm.get("nameOfOrganizingSecretary")).append("','")
                .append(hm.get("approvalOfHOD")).append("','")
                .append(hm.get("approvalOfVC")).append("','")
                .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                
                if(hm.get("receiptType")!=null && !hm.get("receiptType").equals("") && hm.get("receiptCode")!=null && !hm.get("receiptCode").equals("")){
                qryForReceipt.append("insert into  AP#PSACONFRECEXP ( COMPANYID,INSTITUTEID,DEPARTMENTCODE,CONFERENCEID,");
                qryForReceipt.append("CONFERENCETYPE,CONFERENCENAME,BUDGETID,");
                qryForReceipt.append("RECEXPTYPE,RECEXPCODE,RECEXPNAME,RECEXPNO,RECEXPRATE,");
                qryForReceipt.append("RECEXPAMOUNT,ENTRYBY,ENTRYDATE)");
                qryForReceipt.append(" VALUES('").append(hm.get("companyid")).append("','")
                .append(hm.get("instituteid")).append("','")
                .append(hm.get("departmentCode")).append("','")
                .append(hm.get("conferenceID")).append("','")
                .append(hm.get("typeOfConference")).append("','")
                .append(hm.get("proposedConferenceName")).append("','")
                .append(id).append("','")
                .append(hm.get("receiptType")).append("','")
                .append(hm.get("receiptCode")).append("','")
                .append(hm.get("receiptName")).append("','")
                .append(hm.get("receiptNo")).append("','")
                .append(hm.get("receiptValue")).append("','")
                .append(hm.get("receiptAmount")).append("','")
                .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(qryForReceipt.toString());
                pStmt.executeUpdate();
                }
                if(hm.get("expenditureType")!=null && !hm.get("expenditureType").equals("") && hm.get("expenditureCode")!=null && !hm.get("expenditureCode").equals("")){
                qryForExpenditure.append("insert into  AP#PSACONFRECEXP ( COMPANYID,INSTITUTEID,DEPARTMENTCODE,CONFERENCEID,");
                qryForExpenditure.append("CONFERENCETYPE,CONFERENCENAME,BUDGETID,");
                qryForExpenditure.append("RECEXPTYPE,RECEXPCODE,RECEXPNAME,RECEXPNO,RECEXPRATE,");
                qryForExpenditure.append("RECEXPAMOUNT,ENTRYBY,ENTRYDATE)");
                qryForExpenditure.append(" VALUES('").append(hm.get("companyid")).append("','")
                .append(hm.get("instituteid")).append("','")
                .append(hm.get("departmentCode")).append("','")
                .append(hm.get("conferenceID")).append("','")
                .append(hm.get("typeOfConference")).append("','")
                .append(hm.get("proposedConferenceName")).append("','")
                .append(id).append("','")
                .append(hm.get("expenditureType")).append("','")
                .append(hm.get("expenditureCode")).append("','")
                .append(hm.get("expenditureName")).append("','")
                .append(hm.get("expenditureNo")).append("','")
                .append(hm.get("expenditureValue")).append("','")
                .append(hm.get("expenditureAmount")).append("','")
                .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(qryForExpenditure.toString());
                pStmt.executeUpdate();
                }

            } else {
                try{
                    sqry.append("Update AP#PSACONFERENCEBUDGET set COMPANYID='").append(hm.get("companyid"))
                            .append("',INSTITUTEID='").append(hm.get("instituteid"))
                            .append("',DEPARTMENTCODE='").append(hm.get("departmentCode"))
                            .append("',CONFERENCEID='").append(hm.get("conferenceID"))
                            .append("',CONFERENCETYPE='").append(hm.get("typeOfConference"));
                    sqry.append("',CONFERENCENAME='").append(hm.get("proposedConferenceName"));
                    sqry.append("',KEYNOTESPEAKERSNO='").append(hm.get("noOfKeynoteSpeakers"))
                            .append("',KEYNOTESPEAKERSNAMES='").append(hm.get("keynoteSpeakerName"))
                            .append("',INVITEDSPEAKERSNO='").append(hm.get("noOfInvitedSpeakers"))
                            .append("',INVITEDSPEAKERSNAMES='").append(hm.get("invitedSpeakerName"))
                            .append("',SUPPORTORGNAME='").append(hm.get("supportingOrgName"))
                            .append("',SUPPORTORGBUDGET='").append(hm.get("supportingOrgAmount"))
                            .append("',CONFERENCESTARTDATE=to_date('").append(hm.get("conferenceStartDate")).append("','dd-mm-yyyy')")
                            .append(",CONFERENCEENDDATE=to_date('").append(hm.get("conferenceEndDate")).append("','dd-mm-yyyy')")
                            .append(",ORGANIZINGSECRETARYNAME='").append(hm.get("nameOfOrganizingSecretary"))
                            .append("',HODAPPROVAL='").append(hm.get("approvalOfHOD"))
                            .append("',VCAPPROVAL='").append(hm.get("approvalOfVC"))
                            .append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where BUDGETID='").append(hm.get("budgetID")).append("'");;
                    pStmt = dbConnection.prepareStatement(sqry.toString());
                    pStmt.executeUpdate();
                }catch(Exception e)
                {
                    e.printStackTrace();
                }
                
                if(hm.get("receiptType")!=null && !hm.get("receiptType").equals("")){
                String Querry = " delete from AP#PSACONFRECEXP where BUDGETID = '" + hm.get("budgetID") + "' and RECEXPTYPE='"+hm.get("receiptType")+"'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 
                }
                if(hm.get("expenditureType")!=null && !hm.get("expenditureType").equals("")){
                String Querry = " delete from AP#PSACONFRECEXP where BUDGETID = '" + hm.get("budgetID") + "' and RECEXPTYPE='"+hm.get("expenditureType")+"'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 
                }
                if(hm.get("receiptType")!=null && !hm.get("receiptType").equals("") && hm.get("receiptCode")!=null && !hm.get("receiptCode").equals("")){
                qryForReceipt=new StringBuilder();
                qryForReceipt.append("insert into  AP#PSACONFRECEXP ( COMPANYID,INSTITUTEID,DEPARTMENTCODE,CONFERENCEID,");
                qryForReceipt.append("CONFERENCETYPE,CONFERENCENAME,BUDGETID,RECEXPTYPE,");
                qryForReceipt.append("RECEXPCODE,RECEXPNAME,RECEXPNO,RECEXPRATE,RECEXPAMOUNT,ENTRYBY,ENTRYDATE)");
                qryForReceipt.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(hm.get("departmentCode")).append("',");
                qryForReceipt.append("'").append(hm.get("conferenceID")).append("','").append(hm.get("typeOfConference")).append("',");
                qryForReceipt.append("'").append(hm.get("proposedConferenceName")).append("','").append(hm.get("budgetID")).append("',");
                qryForReceipt.append("'").append(hm.get("receiptType")).append("','").append(hm.get("receiptCode")).append("',");
                qryForReceipt.append("'").append(hm.get("receiptName")).append("','").append(hm.get("receiptNo")).append("',");
                qryForReceipt.append("'").append(hm.get("receiptValue")).append("','").append(hm.get("receiptAmount")).append("',");
                qryForReceipt.append("'").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(qryForReceipt.toString());
                pStmt.executeUpdate();
                }
                if(hm.get("expenditureType")!=null && !hm.get("expenditureType").equals("") && hm.get("expenditureCode")!=null && !hm.get("expenditureCode").equals("")){
                qryForExpenditure = new StringBuilder();
                qryForExpenditure.append("insert into  AP#PSACONFRECEXP ( COMPANYID,INSTITUTEID,DEPARTMENTCODE,CONFERENCEID,");
                qryForExpenditure.append("CONFERENCETYPE,CONFERENCENAME,BUDGETID,RECEXPTYPE,");
                qryForExpenditure.append("RECEXPCODE,RECEXPNAME,RECEXPNO,RECEXPRATE,RECEXPAMOUNT,ENTRYBY,ENTRYDATE)");
                qryForExpenditure.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(hm.get("departmentCode")).append("',");
                qryForExpenditure.append("'").append(hm.get("conferenceID")).append("','").append(hm.get("typeOfConference")).append("',");
                qryForExpenditure.append("'").append(hm.get("proposedConferenceName")).append("','").append(hm.get("budgetID")).append("',");
                qryForExpenditure.append("'").append(hm.get("expenditureType")).append("','").append(hm.get("expenditureCode")).append("',");
                qryForExpenditure.append("'").append(hm.get("expenditureName")).append("','").append(hm.get("expenditureNo")).append("',");
                qryForExpenditure.append("'").append(hm.get("expenditureValue")).append("','").append(hm.get("expenditureAmount")).append("',");
                qryForExpenditure.append("'").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(qryForExpenditure.toString());
                pStmt.executeUpdate();
                }
                id = hm.get("budgetID").toString();

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
              searchBoxValue="where (ae.RECEXPTYPE like '%"+hm.get("searchbox")+"%' or ae.RECEXPCODE like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or ae.RECEXPNAME like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or ae.RECEXPNO like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or ae.RECEXPRATE like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or ae.RECEXPAMOUNT like '%"+hm.get("searchbox")+"%')";
              }
             
               sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (budgetid) Totalrecord FROM  ap#psaconfrecexp) a,\n"
                      + "  (SELECT *\n"
                      + "  FROM (select nvl(ae.budgetid,'')budgetid,"
                      + "nvl(ae.RECEXPTYPE,'')RECEXPTYPE,"
                      + "nvl(ae.RECEXPCODE,'')RECEXPCODE,"
                      + "nvl(ae.RECEXPNAME,'')RECEXPNAME,"
                      + "nvl(ae.RECEXPNO,'')RECEXPNO,"
                      + "nvl(ae.RECEXPRATE,'')RECEXPRATE,"
                      + "nvl(ae.RECEXPAMOUNT,'')RECEXPAMOUNT,"
                      + " row_number() over (order by ae.budgetid desc)  R from ap#psaconfrecexp ae "
                      + "" + searchBoxValue + ")\n"
                      + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
              int k = 1;
              pStmt = dbConnection.prepareStatement(sqry.toString());
              rs = pStmt.executeQuery();
              while (rs.next()) {
                  data = new HashMap();
                  data.put("slno",rs.getString(9));
                  data.put("totalrecords", rs.getString(1));
                  data.put("budgetID", rs.getString(2));
                  data.put("recExpType", rs.getString(3));
                  data.put("recExpCode", rs.getString(4));
                  data.put("recExpName", rs.getString(5));
                  data.put("recExpNo", rs.getString(6));
                  data.put("recExpRate", rs.getString(7));
                  data.put("recExpAmount", rs.getString(8));
                  tm.put(k, data);
                  k++;
              }
          } catch (Exception e) {
              e.printStackTrace();
          }
          return tm;
      }
    
     
     private Map selectForUpdate(Map hm) {
         StringBuilder sqry = new StringBuilder();
         StringBuilder receiptQry = new StringBuilder();
         StringBuilder expenditureQry = new StringBuilder();
         Map SelectData = new HashMap();
         Map receiptData = new HashMap();
         Map expenditureData = new HashMap();
        
             try {
                sqry.append(" select nvl(ab.DEPARTMENTCODE,'')DEPARTMENTCODE,"
                        + "nvl(ab.CONFERENCEID,'')CONFERENCEID,nvl(ab.CONFERENCETYPE,'')CONFERENCETYPE,"
                        + "nvl(ab.CONFERENCENAME,'')CONFERENCENAME,nvl(ab.KEYNOTESPEAKERSNO,'')KEYNOTESPEAKERSNO,"
                        + "nvl(ab.KEYNOTESPEAKERSNAMES,'')KEYNOTESPEAKERSNAMES,nvl(ab.INVITEDSPEAKERSNO,'')INVITEDSPEAKERSNO,"
                        + "nvl(ab.INVITEDSPEAKERSNAMES,'')INVITEDSPEAKERSNAMES,"
                        + "nvl(ab.SUPPORTORGNAME,'')SUPPORTORGNAME,nvl(ab.SUPPORTORGBUDGET,'')SUPPORTORGBUDGET,"
                        + "to_char(ab.CONFERENCESTARTDATE,'dd-mm-yyyy')CONFERENCESTARTDATE,"
                        + "to_char(ab.CONFERENCEENDDATE,'dd-mm-yyyy')CONFERENCEENDDATE,"
                        + "nvl(ab.ORGANIZINGSECRETARYNAME,'')ORGANIZINGSECRETARYNAME,nvl(ab.HODAPPROVAL,'')HODAPPROVAL,"
                        + "nvl(ab.VCAPPROVAL,'')VCAPPROVAL,nvl(dm.department,'')department"
                        + " from AP#PSACONFERENCEBUDGET ab,departmentmaster dm");
                sqry.append(" where dm.departmentcode=ab.departmentcode and ").append( "BUDGETID='").append(hm.get("budgetID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("budgetID",hm.get("budgetID"));
                        SelectData.put("departmentCode",rs.getString(1));
                        SelectData.put("conferenceID",rs.getString(2));
                        SelectData.put("conferenceType",rs.getString(3));
                        SelectData.put("conferenceName",rs.getString(4));
                        SelectData.put("keyNoteSpeakerNo",rs.getString(5));
                        SelectData.put("keyNoteSpeakerName",rs.getString(6));
                        SelectData.put("invitedSpeakerNo",rs.getString(7));
                        SelectData.put("invitedSpeakerName",rs.getString(8));
                        SelectData.put("supportOrgName",rs.getString(9));
                        SelectData.put("supportOrgBudget",rs.getString(10));
                        SelectData.put("conferenceStartDate",rs.getString(11));
                        SelectData.put("conferenceEndDate",rs.getString(12));
                        SelectData.put("organizingSecretaryName",rs.getString(13));
                        SelectData.put("hodApproval",rs.getString(14));
                        SelectData.put("vcApproval",rs.getString(15));
                        SelectData.put("department",rs.getString(16));
                }
                if(hm.get("recExpType").equals("R"))
                {
                receiptQry.append(" select nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,"
                        + "nvl(CONFERENCEID,'')CONFERENCEID,nvl(CONFERENCETYPE,'')CONFERENCETYPE,"
                        + "nvl(CONFERENCENAME,'')CONFERENCENAME,nvl(RECEXPTYPE,'')RECEXPTYPE,"
                        + "nvl(RECEXPCODE,'')RECEXPCODE,nvl(RECEXPNAME,'')RECEXPNAME,"
                        + "nvl(RECEXPNO,'')RECEXPNO,"
                        + "nvl(RECEXPRATE,'')RECEXPRATE,nvl(RECEXPAMOUNT,'')RECEXPAMOUNT"
                        + " from AP#PSACONFRECEXP");
                receiptQry.append(" where ").append( "BUDGETID='").append(hm.get("budgetID")).append("' and RECEXPCODE='"+hm.get("recExpCode")+"'");
                 pStmt = dbConnection.prepareStatement(receiptQry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        receiptData.put("budgetID",hm.get("budgetID"));
                        receiptData.put("departmentCode",rs.getString(1));
                        receiptData.put("conferenceID",rs.getString(2));
                        receiptData.put("conferenceType",rs.getString(3));
                        receiptData.put("conferenceName",rs.getString(4));
                        receiptData.put("receiptType",rs.getString(5));
                        receiptData.put("receiptCode",rs.getString(6));
                        receiptData.put("receiptName",rs.getString(7));
                        receiptData.put("receiptNo",rs.getString(8));
                        receiptData.put("receiptValue",rs.getString(9));
                        receiptData.put("receiptAmount",rs.getString(10));
                }
                }
                
                if(hm.get("recExpType").equals("E"))
                {
                expenditureQry.append(" select nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,"
                        + "nvl(CONFERENCEID,'')CONFERENCEID,nvl(CONFERENCETYPE,'')CONFERENCETYPE,"
                        + "nvl(CONFERENCENAME,'')CONFERENCENAME,nvl(RECEXPTYPE,'')RECEXPTYPE,"
                        + "nvl(RECEXPCODE,'')RECEXPCODE,nvl(RECEXPNAME,'')RECEXPNAME,"
                        + "nvl(RECEXPNO,'')RECEXPNO,"
                        + "nvl(RECEXPRATE,'')RECEXPRATE,nvl(RECEXPAMOUNT,'')RECEXPAMOUNT"
                        + " from AP#PSACONFRECEXP");
                expenditureQry.append(" where ").append( "BUDGETID='").append(hm.get("budgetID")).append("' and RECEXPCODE='"+hm.get("recExpCode")+"'");
                 pStmt = dbConnection.prepareStatement(expenditureQry.toString());
                rs = pStmt.executeQuery();
               while (rs.next()) {
                        expenditureData.put("budgetID",hm.get("budgetID"));
                        expenditureData.put("departmentCode",rs.getString(1));
                        expenditureData.put("conferenceID",rs.getString(2));
                        expenditureData.put("conferenceType",rs.getString(3));
                        expenditureData.put("conferenceName",rs.getString(4));
                        expenditureData.put("expenditureType",rs.getString(5));
                        expenditureData.put("expenditureCode",rs.getString(6));
                        expenditureData.put("expenditureName",rs.getString(7));
                        expenditureData.put("expenditureNo",rs.getString(8));
                        expenditureData.put("expenditureValue",rs.getString(9));
                        expenditureData.put("expenditureAmount",rs.getString(10));
                }
                }
                SelectData.put("receiptMap", receiptData);
                SelectData.put("expenditureMap", expenditureData);
                
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
     
      private Map getDeleteData(Map hm) {
        try {
            String Querry = " delete from AP#PSACONFRECEXP where budgetid = '" + hm.get("budgetID") + "' and recexptype='"+hm.get("recExpType")+"' and recexpcode='"+hm.get("recExpCode")+"'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new HashMap();
    }
}
