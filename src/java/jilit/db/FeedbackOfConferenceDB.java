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
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class FeedbackOfConferenceDB {
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public FeedbackOfConferenceDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectConferenceInform,saveupdate, select, Delete, SelectforUpdate,setReceiptName,setExpenditureName,feedbackID,selectGridDataForQuestions,upgradeForQuestions
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (FeedbackOfConferenceDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectConferenceInform:
                    responseString = mapper.writeValueAsString(selectConferenceInform(hm));
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
                case feedbackID:
                    responseString = getFeedBackID(hm);
                    break;
                case selectGridDataForQuestions:
                    responseString = mapper.writeValueAsString(selectGridDataForQuestions(hm));
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
                case upgradeForQuestions:
                    responseString = mapper.writeValueAsString(upgradeForQuestions(hm));
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
            
                sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (BUDGETID) Totalrecord FROM AP#PSACONFERENCEBUDGET) a,\n"
                        +"(SELECT * FROM ( select nvl(ad.BUDGETID,'')BUDGETID,nvl(ad.CONFERENCEID,'')CONFERENCEID,"
                        + "nvl(dm.DEPARTMENT,'')DEPARTMENT,nvl(ad.CONFERENCETYPE,'')CONFERENCETYPE,"
                        + "nvl(ad.CONFERENCENAME,'')CONFERENCENAME,"
                        + "nvl(ad.SUPPORTORGNAME,'')SUPPORTORGNAME,"
                        + "nvl(ad.SUPPORTORGBUDGET,'')SUPPORTORGBUDGET,to_char(ad.CONFERENCESTARTDATE,'dd-mm-yyyy')CONFERENCESTARTDATE,"
                        + "to_char(ad.CONFERENCEENDDATE,'dd-mm-yyyy')CONFERENCEENDDATE,"
                        + "nvl(ad.KEYNOTESPEAKERSNO,'')KEYNOTESPEAKERSNO,"
                        + "nvl(ad.KEYNOTESPEAKERSNAMES,'')KEYNOTESPEAKERSNAMES,nvl(ad.INVITEDSPEAKERSNO,'')INVITEDSPEAKERSNO,"
                        + "nvl(ad.INVITEDSPEAKERSNAMES,'')INVITEDSPEAKERSNAMES,"
                        + "nvl(ad.ORGANIZINGSECRETARYNAME,'')ORGANIZINGSECRETARYNAME,"
                        + "nvl(ad.HODAPPROVAL,'')HODAPPROVAL,nvl(ad.VCAPPROVAL,'')VCAPPROVAL,nvl(ad.DEPARTMENTCODE,'')DEPARTMENTCODE,ROWNUM R "
                        + "from AP#PSACONFERENCEBUDGET ad,departmentmaster dm WHERE ad.DEPARTMENTCODE=dm.DEPARTMENTCODE "
                        + ""+searchBoxValue+" order by R > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                
                int k = 1;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("totalrecords",rs.getString(1)); 
                        SelectData.put("budgetID",rs.getString(2));
                        SelectData.put("conferenceID",rs.getString(3)); 
                        SelectData.put("departmentName",rs.getString(4));
                        SelectData.put("conferenceType",rs.getString(5));
                        SelectData.put("conferenceName",rs.getString(6));
                        SelectData.put("supportOrgName",rs.getString(7));
                        SelectData.put("supportOrgBudget",rs.getString(8));
                        SelectData.put("conferenceStartDate",rs.getString(9));
                        SelectData.put("conferenceEndDate",rs.getString(10));
                        SelectData.put("keyNoteSpeakerNo",rs.getString(11));
                        SelectData.put("keyNoteSpeakerName",rs.getString(12));
                        SelectData.put("invitedSpeakerNo",rs.getString(13));
                        SelectData.put("invitedSpeakerName",rs.getString(14));
                        SelectData.put("organizingSecretaryName",rs.getString(15));
                        SelectData.put("hodApproval",rs.getString(16));
                        SelectData.put("vcApproval",rs.getString(17));
                        SelectData.put("departmentCode",rs.getString(18));
                        SelectData.put("sno", rs.getString(19));
                        tm.put(k, SelectData);
                        k++;
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    } 
     //------------------------------------//
     private Map selectConferenceInform(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();
        try {

            if(!hm.get("searchNames").equals("")){
              searchBoxValue="AND (ad.CONFERENCENAME like '%"+hm.get("searchNames")+"%')";
              }
 
                sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (BUDGETID) Totalrecord FROM AP#PSACONFERENCEBUDGET) a,\n"
                        +"(SELECT * FROM ( select distinct nvl(ad.CONFERENCEID,'')CONFERENCEID,"
                        + "nvl(dm.DEPARTMENT,'')DEPARTMENT,nvl(ad.CONFERENCETYPE,'')CONFERENCETYPE,"
                        + "nvl(ad.CONFERENCENAME,'')CONFERENCENAME,"
                        + "nvl(ad.SUPPORTORGNAME,'')SUPPORTORGNAME,"
                        + "nvl(ad.SUPPORTORGBUDGET,'')SUPPORTORGBUDGET,to_char(ad.CONFERENCESTARTDATE,'dd-mm-yyyy')CONFERENCESTARTDATE,"
                        + "to_char(ad.CONFERENCEENDDATE,'dd-mm-yyyy')CONFERENCEENDDATE,"
                        + "nvl(ad.KEYNOTESPEAKERSNO,'')KEYNOTESPEAKERSNO,"
                        + "nvl(ad.KEYNOTESPEAKERSNAMES,'')KEYNOTESPEAKERSNAMES,nvl(ad.INVITEDSPEAKERSNO,'')INVITEDSPEAKERSNO,"
                        + "nvl(ad.INVITEDSPEAKERSNAMES,'')INVITEDSPEAKERSNAMES,"
                        + "nvl(ad.ORGANIZINGSECRETARYNAME,'')ORGANIZINGSECRETARYNAME,"
                        + "nvl(ad.HODAPPROVAL,'')HODAPPROVAL,nvl(ad.VCAPPROVAL,'')VCAPPROVAL,nvl(ad.DEPARTMENTCODE,'')" 
                        + "DEPARTMENTCODE  from AP#PSACONFERENCEBUDGET ad,departmentmaster dm WHERE ad.DEPARTMENTCODE=dm.DEPARTMENTCODE "
                        + ""+searchBoxValue+" ) ) b"); 

                int k = 1;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("totalrecords",rs.getString(1));
                       // SelectData.put("budgetID",rs.getString(2));
                        SelectData.put("conferenceID",rs.getString(2));
                        SelectData.put("departmentName",rs.getString(3));
                        SelectData.put("conferenceType",rs.getString(4));
                        SelectData.put("conferenceName",rs.getString(5));
                        SelectData.put("supportOrgName",rs.getString(6));
                        SelectData.put("supportOrgBudget",rs.getString(7));
                        SelectData.put("conferenceStartDate",rs.getString(8));
                        SelectData.put("conferenceEndDate",rs.getString(9));
                        SelectData.put("keyNoteSpeakerNo",rs.getString(10));
                        SelectData.put("keyNoteSpeakerName",rs.getString(11)); 
                        SelectData.put("invitedSpeakerNo",rs.getString(12));
                        SelectData.put("invitedSpeakerName",rs.getString(13));
                        SelectData.put("organizingSecretaryName",rs.getString(14));
                        SelectData.put("hodApproval",rs.getString(15));
                        SelectData.put("vcApproval",rs.getString(16));
                        SelectData.put("departmentCode",rs.getString(17));
                        SelectData.put("sno",k);
                        tm.put(k, SelectData);
                        k++;
                }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }

     //-----------------------------------//

     
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
        StringBuilder qryForReceiptExp = new StringBuilder();
        ArrayList list = (ArrayList) hm.get("para");
        HashMap recExpMapMainMap=(HashMap)hm.get("para1");
        HashMap childMap=new HashMap();
        HashMap childMap1=new HashMap();
        HashMap childMap2=new HashMap();
        String budgetIDCount = "";
        String id = "";
        try {
             String countQuery = "select count(BUDGETID) from AP#PSACONFERENCEBUDGETACT where BUDGETID='" + hm.get("budgetID") + "'";
            pStmt = dbConnection.prepareStatement(countQuery);
            rs = pStmt.executeQuery();
            if (rs.next()) {
                budgetIDCount = rs.getString(1);
            }

            if (budgetIDCount.equals("0")) {
                eqry.append("insert into  AP#PSACONFERENCEBUDGETACT ( COMPANYID,INSTITUTEID,DEPARTMENTCODE,CONFERENCEID,");
                eqry.append("CONFERENCETYPE,CONFERENCENAME,BUDGETID,");
                eqry.append("KEYNOTESPEAKERSNO,KEYNOTESPEAKERSNAMES,INVITEDSPEAKERSNO,INVITEDSPEAKERSNAMES,SUPPORTORGNAME,");
                eqry.append("SUPPORTORGBUDGET,CONFERENCESTARTDATE,CONFERENCEENDDATE,");
                eqry.append("ORGANIZINGSECRETARYNAME,ACTUALOUTCOMES,ACTUALBUDGET,HODAPPROVAL,");
                eqry.append("VCAPPROVAL,ENTRYBY,ENTRYDATE,SPECIFICFOCUSAREA,OBJECTIVES)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','")
                .append(hm.get("instituteid")).append("','")
                .append(hm.get("departmentCode")).append("','")
                .append(hm.get("conferenceID")).append("','")
                .append(hm.get("typeOfConference")).append("','")
                .append(hm.get("actualConferenceName")).append("','")
                .append(hm.get("budgetID")).append("','")
                .append(hm.get("noOfKeynoteSpeakers")).append("','")
                .append(hm.get("keynoteSpeakerName")).append("','")
                .append(hm.get("noOfInvitedSpeakers")).append("','")
                .append(hm.get("invitedSpeakerName")).append("','")
                .append(hm.get("supportingOrgName")).append("','")
                .append(hm.get("supportingOrgAmount")).append("',to_date('")
                .append(hm.get("conferenceStartDate")).append("','dd-mm-yyyy'),to_date('")
                .append(hm.get("conferenceEndDate")).append("','dd-mm-yyyy'),'")
                .append(hm.get("nameOfOrganizingSecretary")).append("','")
                .append(hm.get("actualOutComes")).append("','")
                .append(hm.get("actualBudget")).append("','")
                .append(hm.get("approvalOfHOD")).append("','")
                .append(hm.get("approvalOfVC")).append("','")
                .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'),").append("'").append(hm.get("specificFocusArea")).append("','").append(hm.get("objectives")).append("')");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                
                Iterator it=recExpMapMainMap.entrySet().iterator();
                while(it.hasNext())
                {
                    Map.Entry mp=(Map.Entry)it.next();
                    childMap=(HashMap)mp.getValue();
                if(childMap.get("recexptype")!=null && !childMap.get("recexptype").equals("") && childMap.get("recexpcode")!=null && !childMap.get("recexpcode").equals("")){
                qryForReceiptExp=new StringBuilder();
                qryForReceiptExp.append("insert into  AP#PSACONFRECEXPACTUAL ( COMPANYID,INSTITUTEID,DEPARTMENTCODE,CONFERENCEID,");
                qryForReceiptExp.append("CONFERENCETYPE,CONFERENCENAME,BUDGETID,");
                qryForReceiptExp.append("RECEXPTYPE,RECEXPCODE,RECEXPNAME,RECEXPNO,RECEXPRATE,");
                qryForReceiptExp.append("RECEXPAMOUNT,ENTRYBY,ENTRYDATE)");
                qryForReceiptExp.append(" VALUES('").append(hm.get("companyid")).append("','")
                .append(hm.get("instituteid")).append("','")
                .append(hm.get("departmentCode")).append("','")
                .append(hm.get("conferenceID")).append("','")
                .append(hm.get("typeOfConference")).append("','")
                .append(hm.get("actualConferenceName")).append("','")
                .append(hm.get("budgetID")).append("','")
                .append(childMap.get("recexptype")).append("','")
                .append(childMap.get("recexpcode")).append("','")
                .append(childMap.get("recexpname")).append("','")
                .append(childMap.get("recexpno")).append("','")
                .append(childMap.get("recexpvalue")).append("','")
                .append(childMap.get("recexpamount")).append("','")
                .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(qryForReceiptExp.toString());
                pStmt.executeUpdate();
                }
                }
            } else {
                try{
                    sqry.append("Update AP#PSACONFERENCEBUDGETACT set COMPANYID='").append(hm.get("companyid"))
                            .append("',INSTITUTEID='").append(hm.get("instituteid"))
                            .append("',DEPARTMENTCODE='").append(hm.get("departmentCode"))
                            .append("',CONFERENCEID='").append(hm.get("conferenceID"))
                            .append("',CONFERENCETYPE='").append(hm.get("typeOfConference"));
                    sqry.append("',CONFERENCENAME='").append(hm.get("actualConferenceName"));
                    sqry.append("',KEYNOTESPEAKERSNO='").append(hm.get("noOfKeynoteSpeakers"))
                            .append("',KEYNOTESPEAKERSNAMES='").append(hm.get("keynoteSpeakerName"))
                            .append("',INVITEDSPEAKERSNO='").append(hm.get("noOfInvitedSpeakers"))
                            .append("',INVITEDSPEAKERSNAMES='").append(hm.get("invitedSpeakerName"))
                            .append("',SUPPORTORGNAME='").append(hm.get("supportingOrgName"))
                            .append("',SUPPORTORGBUDGET='").append(hm.get("supportingOrgAmount"))
                            .append("',CONFERENCESTARTDATE=to_date('").append(hm.get("conferenceStartDate")).append("','dd-mm-yyyy')")
                            .append(",CONFERENCEENDDATE=to_date('").append(hm.get("conferenceEndDate")).append("','dd-mm-yyyy')")
                            .append(",ORGANIZINGSECRETARYNAME='").append(hm.get("nameOfOrganizingSecretary"))
                            .append("',ACTUALOUTCOMES='").append(hm.get("actualOutComes"))
                            .append("',ACTUALBUDGET='").append(hm.get("actualBudget"))
                            .append("',HODAPPROVAL='").append(hm.get("approvalOfHOD"))
                            .append("',VCAPPROVAL='").append(hm.get("approvalOfVC"))
                            .append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM'),SPECIFICFOCUSAREA='"+hm.get("specificFocusArea")+"',OBJECTIVES='"+hm.get("objectives")+"' where BUDGETID='").append(hm.get("budgetID")).append("'");;
                    pStmt = dbConnection.prepareStatement(sqry.toString());
                    pStmt.executeUpdate();
                }catch(Exception e)
                {
                    e.printStackTrace();
                }
                
                Iterator it2=recExpMapMainMap.entrySet().iterator();
                while(it2.hasNext())
                {
                    Map.Entry mp2=(Map.Entry)it2.next();
                    childMap1=(HashMap)mp2.getValue();
                if(childMap1.get("recexptype")!=null && !childMap1.get("recexptype").equals("")){
                String Querry = " delete from AP#PSACONFRECEXPACTUAL where BUDGETID = '" + hm.get("budgetID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 
                }
                }
                Iterator it1=recExpMapMainMap.entrySet().iterator();
                while(it1.hasNext())
                {
                    Map.Entry mp1=(Map.Entry)it1.next();
                    childMap2=(HashMap)mp1.getValue();
                if(childMap2.get("recexptype")!=null && !childMap2.get("recexptype").equals("") && childMap2.get("recexpcode")!=null && !childMap2.get("recexpcode").equals("")){
                qryForReceiptExp=new StringBuilder();
                qryForReceiptExp.append("insert into  AP#PSACONFRECEXPACTUAL ( COMPANYID,INSTITUTEID,DEPARTMENTCODE,CONFERENCEID,");
                qryForReceiptExp.append("CONFERENCETYPE,CONFERENCENAME,BUDGETID,");
                qryForReceiptExp.append("RECEXPTYPE,RECEXPCODE,RECEXPNAME,RECEXPNO,RECEXPRATE,");
                qryForReceiptExp.append("RECEXPAMOUNT,ENTRYBY,ENTRYDATE)");
                qryForReceiptExp.append(" VALUES('").append(hm.get("companyid")).append("','")
                .append(hm.get("instituteid")).append("','")
                .append(hm.get("departmentCode")).append("','")
                .append(hm.get("conferenceID")).append("','")
                .append(hm.get("typeOfConference")).append("','")
                .append(hm.get("actualConferenceName")).append("','")
                .append(hm.get("budgetID")).append("','")
                .append(childMap2.get("recexptype")).append("','")
                .append(childMap2.get("recexpcode")).append("','")
                .append(childMap2.get("recexpname")).append("','")
                .append(childMap2.get("recexpno")).append("','")
                .append(childMap2.get("recexpvalue")).append("','")
                .append(childMap2.get("recexpamount")).append("','")
                .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(qryForReceiptExp.toString());
                pStmt.executeUpdate();
                }
                }
               
                id = hm.get("budgetID").toString();

            }
            
            
             String Querry = " delete from AP#PSAFEEDBACKDETAIL where CONFERENCEID = '" + hm.get("conferenceID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 
           
                if(hm.get("conferenceID").equals("0")){
                for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#PSAFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,CONFERENCEID,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(mp.get("companyid")).append("','").append(mp.get("instituteid")).append("','").append(mp.get("conferenceID")).append("','").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                }
                
            }else
                {
                    for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#PSAFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,CONFERENCEID,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(mp.get("conferenceID")).append("','").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                } 
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
          Map SelectData1 = new HashMap();
          StringBuffer sqry = new StringBuffer();
          try {

             
               sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (BUDGETID) Totalrecord FROM  AP#PSACONFERENCEBUDGETACT) a,\n"
                      + "  (SELECT *\n"
                      + "  FROM (select nvl(ae.BUDGETID,'')BUDGETID,"
                      + "nvl(ae.CONFERENCENAME,'')CONFERENCENAME,"
                      + "nvl(ae.ORGANIZINGSECRETARYNAME,'')ORGANIZINGSECRETARYNAME,"
                      + "nvl(dm.DEPARTMENT,'')DEPARTMENT,"
                      + "nvl(ae.SUPPORTORGNAME,'')SUPPORTORGNAME,"
                      + "nvl(ae.SUPPORTORGBUDGET,'')SUPPORTORGBUDGET,"
                      + "nvl(ae.SPECIFICFOCUSAREA,'')SPECIFICFOCUSAREA,"
                      + " row_number() over (order by ae.BUDGETID desc)  R from AP#PSACONFERENCEBUDGETACT ae,DEPARTMENTMASTER dm "
                      + " where ae.DEPARTMENTCODE=dm.DEPARTMENTCODE " + searchBoxValue + ")\n"
                      + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
              int k = 1;
              pStmt = dbConnection.prepareStatement(sqry.toString());
              rs = pStmt.executeQuery();
              while (rs.next()) {
                  data = new HashMap();
                  data.put("slno",rs.getString(9));
                  data.put("totalrecords", rs.getString(1));
                  data.put("budgetID", rs.getString(2));
                  data.put("conferenceName", rs.getString(3));
                  data.put("organizingSecretaryName", rs.getString(4));
                  data.put("departmentName", rs.getString(5));
                  data.put("supportOrgName", rs.getString(6));
                  data.put("supportOrgAmount", rs.getString(7));
                  data.put("specificFocusArea", rs.getString(8));
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
         HashMap recExpMap = new HashMap();
        
             try {
                sqry.append(" select nvl(ab.DEPARTMENTCODE,'')DEPARTMENTCODE,"
                        + "nvl(ab.CONFERENCEID,'')CONFERENCEID,nvl(ab.CONFERENCETYPE,'')CONFERENCETYPE,"
                        + "nvl(ab.CONFERENCENAME,'')CONFERENCENAME,nvl(ab.KEYNOTESPEAKERSNO,'')KEYNOTESPEAKERSNO,"
                        + "nvl(ab.KEYNOTESPEAKERSNAMES,'')KEYNOTESPEAKERSNAMES,nvl(ab.INVITEDSPEAKERSNO,'')INVITEDSPEAKERSNO,"
                        + "nvl(ab.INVITEDSPEAKERSNAMES,'')INVITEDSPEAKERSNAMES,"
                        + "nvl(ab.SUPPORTORGNAME,'')SUPPORTORGNAME,nvl(ab.SUPPORTORGBUDGET,'')SUPPORTORGBUDGET,"
                        + "to_char(ab.CONFERENCESTARTDATE,'dd-mm-yyyy')CONFERENCESTARTDATE,"
                        + "to_char(ab.CONFERENCEENDDATE,'dd-mm-yyyy')CONFERENCEENDDATE,"
                        + "nvl(ab.ORGANIZINGSECRETARYNAME,'')ORGANIZINGSECRETARYNAME,nvl(ab.ACTUALOUTCOMES,'')ACTUALOUTCOMES,nvl(ab.ACTUALBUDGET,'')ACTUALBUDGET,nvl(ab.HODAPPROVAL,'')HODAPPROVAL,"
                        + "nvl(ab.VCAPPROVAL,'')VCAPPROVAL,nvl(dm.department,'')department,nvl(ab.SPECIFICFOCUSAREA,'')SPECIFICFOCUSAREA,nvl(ab.OBJECTIVES,'')OBJECTIVES"
                        + " from AP#PSACONFERENCEBUDGETACT ab,departmentmaster dm");
                sqry.append(" where dm.departmentcode=ab.departmentcode and ").append( "BUDGETID='").append(hm.get("budgetID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("budgetID",hm.get("budgetID"));
                        SelectData.put("departmentCode",rs.getString(1));
                        SelectData.put("conferenceID",rs.getString(2));
                        SelectData.put("conferenceType",rs.getString(3));
                        SelectData.put("actualConferenceName",rs.getString(4));
                        SelectData.put("keyNoteSpeakerNo",rs.getString(5));
                        SelectData.put("keyNoteSpeakerName",rs.getString(6));
                        SelectData.put("invitedSpeakerNo",rs.getString(7));
                        SelectData.put("invitedSpeakerName",rs.getString(8));
                        SelectData.put("supportOrgName",rs.getString(9));
                        SelectData.put("supportOrgBudget",rs.getString(10));
                        SelectData.put("conferenceStartDate",rs.getString(11));
                        SelectData.put("conferenceEndDate",rs.getString(12));
                        SelectData.put("organizingSecretary",rs.getString(13));
                        SelectData.put("actualOutComes",rs.getString(14));
                        SelectData.put("actualBudget",rs.getString(15));
                        SelectData.put("hodApproval",rs.getString(16));
                        SelectData.put("vcApproval",rs.getString(17));
                        SelectData.put("department",rs.getString(18));
                        SelectData.put("specificFocusArea",rs.getString(19));
                        SelectData.put("objectives",rs.getString(20));
                }
                int k=0;
                receiptQry.append(" select nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,"
                        + "nvl(CONFERENCEID,'')CONFERENCEID,nvl(CONFERENCETYPE,'')CONFERENCETYPE,"
                        + "nvl(CONFERENCENAME,'')CONFERENCENAME,nvl(RECEXPTYPE,'')RECEXPTYPE,"
                        + "nvl(RECEXPCODE,'')RECEXPCODE,nvl(RECEXPNAME,'')RECEXPNAME,"
                        + "nvl(RECEXPNO,'')RECEXPNO,"
                        + "nvl(RECEXPRATE,'')RECEXPRATE,nvl(RECEXPAMOUNT,'')RECEXPAMOUNT"
                        + " from AP#PSACONFRECEXPACTUAL");
                receiptQry.append(" where ").append( "BUDGETID='").append(hm.get("budgetID")).append("'");
                 pStmt = dbConnection.prepareStatement(receiptQry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        receiptData = new HashMap();
                        receiptData.put("budgetID",hm.get("budgetID"));
                        receiptData.put("departmentCode",rs.getString(1));
                        receiptData.put("conferenceID",rs.getString(2));
                        receiptData.put("conferenceType",rs.getString(3));
                        receiptData.put("actualConferenceName",rs.getString(4));
                        receiptData.put("recexptype",rs.getString(5));
                        receiptData.put("recexpcode",rs.getString(6));
                        receiptData.put("recexpname",rs.getString(7));
                        receiptData.put("recexpno",rs.getString(8));
                        receiptData.put("recexpvalue",rs.getString(9));
                        receiptData.put("recexpamount",rs.getString(10));
                        recExpMap.put(k, receiptData);
                        k++;
                }
                
                SelectData.put("recExpMap", recExpMap);
                
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
     
     public String getFeedBackID(Map hm)
      {
      String feedbackID="";
      StringBuilder sb =new StringBuilder();
      try{
      sb.append("select APFEEDBACKID from AP#FEEDBACKTYPEMASTER where APFEEDBACKTYPE='PSAFEEDBACK'");
       pStmt = dbConnection.prepareStatement(sb.toString());
       rs = pStmt.executeQuery();
      while(rs.next()){
         feedbackID=rs.getString(1);
         }
      }catch(Exception e)
      {
      e.printStackTrace();
      }
      return feedbackID;
      }
     
     private Map selectGridDataForQuestions(Map hm) {
        StringBuffer sqry = new StringBuffer();
       Map tm = new HashMap();
        Map SelectData = new HashMap();
        int k = 1;
        try {
          sqry.append("SELECT NVL(AM.HEADID,'')HEADID,NVL(QUESTIONID,' ')QUESTIONID,NVL(QUESTIONBODY,' ')QUESTIONBODY,NVL(RATINGID,' ') RATING,NVL(AH.PARENTHEADID,'')PARENTHEADID,nvl( (select decode(x.headid,'','N','Y') from AP#FACULTYQUESTIONMASTER x where X.HEADID in  (select parentheadid from AP#FACULTYQUESTIONHEAD WHERE FEEDBACKID = X.FEEDBACKID AND HEADID = X.HEADID ) and x.headid = am.headid and rownum =1),'N') flag FROM AP#FACULTYQUESTIONMASTER AM,AP#FACULTYQUESTIONHEAD AH WHERE AM.COMPANYCODE=AH.COMPANYCODE AND AM.INSTITUTECODE=AH.INSTITUTECODE AND AM.FEEDBACKID=AH.FEEDBACKID AND AM.COMPONENTTYPE=AH.COMPONENTTYPE AND AM.HEADID=AH.HEADID AND AM.EXAMCODE=AH.EXAMCODE AND AM.COMPONENTTYPE='C' AND AM.FEEDBACKID='"+hm.get("feedbackID")+"' ORDER BY AM.QUESTIONID");
          pStmt = dbConnection.prepareStatement(sqry.toString());
          rs = pStmt.executeQuery();
          while (rs.next()) {
                        SelectData= new HashMap();
                        SelectData.put("slno",k);
                        SelectData.put("headid",rs.getString(1));
                        SelectData.put("questionid",rs.getString(2));
                        SelectData.put("questionbody",rs.getString(3));
                        SelectData.put("ratingid",rs.getString(4));
                        SelectData.put("parentHeadID",rs.getString(5));
                        SelectData.put("flag",rs.getString(6));
                        tm.put(k,SelectData);
                  k++; 
                }  
          tm.put("rating",getRatingCombo());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
     public Map getRatingCombo()
     {
     Map al=new HashMap();
     String ratingID="";
     String questionType="";
     StringBuilder sb=new StringBuilder();
     try{
     //sb.append("select  RATINGID,wm_concat( '\"'||rating||'@@'||ratingdesc||'\"') from ap#ratingdetail group by RATINGID");
     sb.append("select  rd.RATINGID,wm_concat(distinct '\"'||rd.rating||'@@'||rd.ratingdesc||'\"'),rm.subjective from AP#RATINGDETAIL rd,AP#RATINGMASTER rm where rd.companycode=rm.companycode and rd.institutecode=rm.institutecode and rd.examcode=rm.examcode and rd.feedbackid=rm.feedbackid and rd.ratingid=rm.ratingid group by  rd.RATINGID,rm.subjective ");
     pStmt = dbConnection.prepareStatement(sb.toString());
     rs = pStmt.executeQuery();
          while (rs.next()) {
                 if(rs.getString(3).equals("Y"))
                 {
                 al.put(rs.getString(1),"[\"@@\"]");
                 }else{
                 al.put(rs.getString(1),"["+rs.getString(2)+"]");
                 }
                } 
     }catch(Exception e)
     {
         e.printStackTrace();
     }
          return al;
     }
     
      
      
      private Map getDeleteData(Map hm) {
        
          try {
           Statement st= dbConnection.createStatement();
            String qry1 = "delete from AP#PSACONFRECEXPACTUAL where budgetid = '" + hm.get("budgetID") + "'";
            st.addBatch(qry1);
            String qry2 = "delete from AP#PSACONFERENCEBUDGETACT where budgetid = '" + hm.get("budgetID") + "'";
            st.addBatch(qry2);
            st.executeBatch();

        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return new HashMap();
    }
      
      
      private Map upgradeForQuestions(Map hm) {
         StringBuffer sqry = new StringBuffer();
         TreeMap tm =new TreeMap();
         Map SelectData = new HashMap();
         int k = 1;
            try {
               
                sqry = new StringBuffer();
                sqry.append(" select NVL (APFEEDBACKID, '') APFEEDBACKID,"
                        + "nvl(APFEEDBACKITEMID,'')APFEEDBACKITEMID,nvl(APFEEDBACKITEMREMARKS,'')APFEEDBACKITEMREMARKS,"
                        + "nvl(APFEEDBACKRATINGID,'')APFEEDBACKRATINGID,nvl(APFEEDBACKRATING,'')APFEEDBACKRATING,"
                        + "nvl(APFEEDBACKUSERREMARKS,'')APFEEDBACKUSERREMARKS FROM AP#PSAFEEDBACKDETAIL ");
                sqry.append(" where ").append( "CONFERENCEID='").append(hm.get("conferenceID")).append("'");
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("feedbackID",rs.getString(1));
                        SelectData.put("questionID",rs.getString(2));
                        SelectData.put("questionRemarks",rs.getString(3));
                        SelectData.put("ratingID",rs.getString(4));
                        SelectData.put("rating",rs.getString(5));
                        SelectData.put("userRemarks",rs.getString(6));
                        tm.put(k, SelectData);
                        k++;
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return tm;
    }
}
