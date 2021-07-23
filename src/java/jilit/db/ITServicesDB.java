package jilit.db;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;


/**
 *
 * @author VIVEK.SONI
 */
public class ITServicesDB {
    private Connection dbConnection;
   // private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs=null;
    private ResultSet rs1=null;

    public ITServicesDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectGridData,saveupdate, selectData, headID, SelectforUpdate,feedbackID,finalsave,selectDataForUpgrade,checkExpiryDate,validateData
    }


     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (ITServicesDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectGridData:
                    responseString = mapper.writeValueAsString(selectGridData(hm));
                    break;
                    //----------------------Draft Function---------------------------------
                case saveupdate:
                    responseString =SaveUpdateData(hm);
                    break;
               case feedbackID:
                    responseString = getFeedBackID(hm);
                    break;
                case finalsave:
                    responseString = mapper.writeValueAsString(finalsave(hm));
                    break;


            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseString;
    }

  //--------------------------------- On Selection of Event Code Data Will Display in Grid---------------------------------

     private Map selectGridData(Map hm) throws SQLException {
         StringBuffer sqry = new StringBuffer();
         StringBuffer sqry1 = new StringBuffer();
         StringBuffer sqry2 = new StringBuffer();
         Map SelectData = new HashMap();
         Map outerData=new HashMap();
         Map tm=new HashMap();
         Map evalution=new HashMap();
         ArrayList arr=new ArrayList();
         Statement sta=null,sta1=null,sta2=null;
         ResultSet rsa=null,rsa1=null,rsa2=null;

         String path="PATH";
         int k=1,l=1;
         try {
          sqry.append("select TRANSID, DOCMODE,REMARKS from AP#ITFeedbackHeader where INSTITUTECODE='"+hm.get("institute").toString().trim()+"' and ITEVENTID ='"+hm.get("EventCode").toString().trim()+"' and FEEDBACKBY ='"+hm.get("entryBy")+"'");
         if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
          sta=dbConnection.createStatement();
         rsa= sta.executeQuery(sqry.toString());
         // If transaction is not created than Ceate and insert Data
         if(!rsa.next()){
         sqry1.append("select QUESTIONID,QUESTIONBODY, RATINGID ,nvl(PARENTQUESTIONID,' ') ,SEQID  ,nvl( MANDATORYQUESTION,'N') ,level ," +
                 "SYS_CONNECT_BY_PATH(QUESTIONID, '/') "+'"'+path+'"'+" from ap#iteventquestion a START WITH parentQUESTIONID IS NULL  CONNECT BY" +
                 " PRIOR QUESTIONID = parentQUESTIONID ");
         if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
         sta1=dbConnection.createStatement();
         rsa1= sta1.executeQuery(sqry1.toString());
         while (rsa1.next()) {

                        SelectData = new HashMap();

                        SelectData.put("QUESTIONID",rsa1.getString(1));
                        SelectData.put("QUESTIONBODY",rsa1.getString(2));
                        String rateid=rsa1.getString(3);
                        SelectData.put("RATINGID",rateid);
                        SelectData.put("PARENTQUESTIONID",rsa1.getString(4));
                        SelectData.put("SEQID",rsa1.getString(5));
                        SelectData.put("MANDATORYQUESTION",rsa1.getString(6));
                        if(rsa1.getString(7)!=null && rsa1.getString(7).equalsIgnoreCase("1")){
                         SelectData.put("slno",l);
                         l++;
                         }else if(rsa1.getString(7)!=null && !rsa1.getString(7).equalsIgnoreCase("1")){
                          SelectData.put("slno","-->");
                         }

                        tm.put(k,SelectData);
                        k++;

                }
         }else{

             String tranID=rsa.getString(1);
             String docMode=rsa.getString(2);
              String headerRmk=rsa.getString(3);
             String selqry;

             ResultSet rso;

              sqry1.append("select b.QUESTIONID QUESTIONID , b.QUESTIONBODY , b.RATINGID , b.PARENTQUESTIONID ,b.SEQID , b.MANDATORYQUESTION ," +
                     " nvl(a.SUBJECTIVEANSWER,'')SUBJECTIVEANSWER,nvl(a.QUESTIONID,' ') FbQUESTIONID ,nvl(a.evaluationvalue,-1)evaluationvalue ,   nvl( a.evaluationvalue,'-1') FBevaluationvalue , level,nvl(a.REMARKS,'')REMARKS from " +
                     " (select QUESTIONID, evaluationvalue,SUBJECTIVEANSWER ,REMARKS from AP#ITFeedbackdetail where transid='"+tranID+"') a, AP#ITEVENTQUESTION b where " +
                     " INSTITUTECODE='"+hm.get("institute").toString().trim()+"' and ITEVENTID ='"+hm.get("EventCode").toString().trim()+"'  and a.questionid(+)=b.questionid START WITH parentQUESTIONID IS NULL CONNECT " +
                     " BY  PRIOR b.QUESTIONID = b.parentQUESTIONID order by SEQID");

         if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
         sta1=dbConnection.createStatement();
         rsa1= sta1.executeQuery(sqry1.toString());
         while (rsa1.next()) {
                        SelectData = new HashMap();
                        SelectData.put("QUESTIONID",rsa1.getString(1));
                        SelectData.put("QUESTIONBODY",rsa1.getString(2));
                        String rateid=rsa1.getString(3);
                        SelectData.put("RATINGID",rateid);
                        SelectData.put("PARENTQUESTIONID",rsa1.getString(4));
                        SelectData.put("SEQID",rsa1.getString(5));
                        SelectData.put("MANDATORYQUESTION",rsa1.getString(6));
                        SelectData.put("FBQUESTIONID",rsa1.getString(8));
                        String evevalue=rsa1.getString(9);
                        SelectData.put("EVALUATIONVALUE",evevalue);
                        SelectData.put("FBEVALUATIONVALUE",rsa1.getString(10));
                        SelectData.put("docMode",docMode);
                        SelectData.put("remarks",rsa1.getString(12));

                        if(rsa1.getString(11)!=null && rsa1.getString(11).equalsIgnoreCase("1")){
                         SelectData.put("slno",l);
                         l++;
                         }else if(rsa1.getString(11)!=null && !rsa1.getString(11).equalsIgnoreCase("1")){
                          SelectData.put("slno","-->");
                         }
                        selqry=" SELECT RATINGDESC FROM ap#ratingdetail  WHERE RATINGID='"+rateid+"' AND EVALUATIONVALUE='"+evevalue+"'";
                        if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                        sta2=dbConnection.createStatement();
                        rso= sta2.executeQuery(selqry.toString());
                        String flag;
                        if(rso.next()){
                         String Desc=rso.getString(1);
                         if(!Desc.equalsIgnoreCase("0")){
                         SelectData.put("ratingdes",Desc);
                         }
                        }else if(evevalue.equalsIgnoreCase("0")){
                         SelectData.put("ratingdes",rsa1.getString(7));
                         flag="y";
                        }else if(evevalue.equalsIgnoreCase("-1")){
                         SelectData.put("ratingdes","<--Select-->");
                        }else if(!evevalue.equalsIgnoreCase("-1") &&!evevalue.equalsIgnoreCase("0") ){
                         SelectData.put("ratingdes",evevalue);
                        }


                        tm.put(k,SelectData);
                        k++;
         }// End of while loop
         if(headerRmk==null){
         headerRmk=" ";
         }
           tm.put("headerremarks",headerRmk);
         }

          tm.put("rating",getRatingCombo());



        } catch (Exception e) {
            e.printStackTrace();
        }

         finally{
             if(sta!=null){
            sta.close();
             }
             if(rsa!=null){
            rsa.close();
             }
             if(sta1!=null){
            sta1.close();
             }
             if(rsa1!=null){
            rsa1.close();
             }


 }
        return tm;
     }
     //----------------Will Add All Rating in Map--------------------------------------------------------
     public Map getRatingCombo() throws SQLException
     {
     Map al=new HashMap();
     String ratingID="";
     String questionType="";
     StringBuilder sb=new StringBuilder();
     Statement statmtt=null;
          ResultSet rssett=null;
     try{
     //sb.append("select  RATINGID,wm_concat( '\"'||rating||'@@'||ratingdesc||'\"') from ap#ratingdetail group by RATINGID");
     sb.append(" SELECT nvl(rd.RATINGID ,rm.RATINGID),  wm_concat ( DISTINCT '\"' || rd.rating || '@@' || rd.ratingdesc || '\"'),  rm.subjective  FROM ap#ratingdetail rd, ap#ratingmaster rm  WHERE       rd.ratingid(+) = rm.ratingid GROUP BY nvl(rd.RATINGID,rm.RATINGID), rm.subjective");
//     pStmt = dbConnection.prepareStatement(sb.toString());
//     rs = pStmt.executeQuery();
     if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
     statmtt=dbConnection.createStatement();
     rssett= statmtt.executeQuery(sb.toString());
     while (rssett.next()) {
                 if(rssett.getString(3).equalsIgnoreCase("Y"))
                 {
                 al.put(rssett.getString(1),"[\"@@\"]");
                 }else if(rssett.getString(3).equalsIgnoreCase("X")){
                   al.put(rssett.getString(1),"[\"blank\"]");
                 }else {
                 al.put(rssett.getString(1),"["+rssett.getString(2)+"]");
                 }
                }
     }catch(Exception e)
     {
         e.printStackTrace();
     }
      finally{
          if(statmtt!=null){
            statmtt.close();
          }
          if(rssett!=null){
            rssett.close();
          }

 }
          return al;
     }



//----------------------------------------------------Using for Draft Function---------------------------------------------------------------------------

      private String SaveUpdateData(Map hm) throws SQLException
   {

        StringBuffer sqry = new StringBuffer();
        StringBuffer sqry1 = new StringBuffer();
        StringBuffer sqry2 = new StringBuffer();
        ArrayList list = (ArrayList) hm.get("para");
        String Draft="";
        Set st=new HashSet();
        String tempValue="";
        String id = "";
        PreparedStatement pst1=null;
        ResultSet rss1=null,rssett=null;
        StringBuilder eqry = new StringBuilder();
        Statement state2=null,statmtt=null,ustatmtt=null;
        try {

        sqry.append(" select Transid,DOCMODE  from AP#ITFeedbackHeader where INSTITUTECODE='"+hm.get("instituteid")+"' and ITEVENTID ='"+hm.get("EventCode")+"' and FEEDBACKBY ='"+hm.get("entryBy")+"'");
        if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
        statmtt=dbConnection.createStatement();
        rssett= statmtt.executeQuery(sqry.toString());
        if (rssett.next()) {
                id=rssett.getString("TRANSID");
                Draft=rssett.getString("DOCMODE");
                for(int x=0;x<list.size();x++){
                  Map mp=(Map)list.get(x);
                  eqry = new StringBuilder();
                  String issubjective="";
                  String ratinId="";
                  if(mp.get("issubjective").toString().equalsIgnoreCase("N") ){
                  ratinId=mp.get("rating").toString();
                  issubjective=" ";
                  }else {
                  issubjective=mp.get("rating").toString();
                  ratinId="0";
                  }
                  Statement  upsta=null,ustate=null;
                   ResultSet uprsa=null;
                  try{
                  String upqry="select  * from AP#ITFeedbackdetail  where transid='"+id+"' and questionid='"+mp.get("questionID")+"'";
                  upsta=dbConnection.createStatement();
                  uprsa= upsta.executeQuery(upqry.toString());
                  StringBuilder saqry = new StringBuilder();
                  if(uprsa.next()) {
                  saqry.append("update AP#ITFeedbackDetail set EVALUATIONVALUE='"+ratinId+"',SUBJECTIVEANSWER='"+issubjective+"' ,REMARKS='"+mp.get("Remarks")+"',feedbackdate=sysdate where transid='"+id+"' and questionid='"+mp.get("questionID")+"'");
                  if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                  upsta=dbConnection.createStatement();
                  upsta.executeUpdate(saqry.toString());
                  }else{
                saqry.append(" insert into AP#ITFeedbackDetail (TRANSID, QUESTIONID ,RatingId , SUBJECTIVEANSWER, EVALUATIONVALUE , REMARKS ,DEACTIVE ,FeedbackBY, FeedbackDate) ");
                saqry.append(" VALUES('").append(id).append("','").append(mp.get("questionID")).append("','").append(mp.get("ratingid")).append("','").append(issubjective).append("','").append(ratinId).append("','").append(mp.get("Remarks")).append("','").append("N");
                saqry.append("','").append(mp.get("entryBy").toString().trim()).append("',").append("sysdate)");
                if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                ustate=dbConnection.createStatement();
                ustate.executeUpdate(saqry.toString());


                   }
                }catch(Exception e){

                }finally{
                if(upsta!=null){
                upsta.close();
                }
                if(uprsa!=null){
                uprsa.close();
                }
                if(ustate!=null){
                ustate.close();
                }
                }

        }
                //--------------update Header Remarks---------------------------------------
                Statement  upsta=null;
                String saqry;
                saqry="update AP#ITFeedbackHeader set REMARKS='"+hm.get("headerremarks")+"'";
                upsta=dbConnection.createStatement();
                upsta.executeUpdate(saqry.toString());

        }//--------------------------First Time Draft While ID Not Generated-----------------------------------------------------
        else{
               try {
                   if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                   callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                   callableStatement.setString(1, "0001");
                   callableStatement.setString(2, "ITFBTid");
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

                String headerremarks;
                      if(hm.get("headerremarks")==null){
                 headerremarks=" ";
                 }else{
                 headerremarks=hm.get("headerremarks").toString();
                 }

                eqry.append("insert into AP#ITFeedbackHeader (TRANSID ,INSTITUTECODE,ITEVENTID,TRANSACTIONDATE,DOCMODE,DEACTIVE ,FeedbackBY ,REMARKS, FeedBackDATE)");
                eqry.append(" VALUES('").append(id).append("','").append(hm.get("instituteid")).append("','").append(hm.get("EventCode")).append("',").append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append("D','N").append("',");
                eqry.append("'").append(hm.get("entryBy").toString().trim()).append("','").append(headerremarks).append("',").append("sysdate)");


               if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                state2=dbConnection.createStatement();
                state2.executeUpdate(eqry.toString());

                for(int x=0;x<list.size();x++){

                 Map mp=(Map)list.get(x);
                  eqry = new StringBuilder();
                  String issubjective="";
                  String ratinId="";

                  if(mp.get("issubjective").toString().equalsIgnoreCase("N") ){
                  ratinId=mp.get("rating").toString();
                  issubjective=" ";

                  }else {
                  issubjective=mp.get("rating").toString();
                  ratinId="0";


                  }
                eqry.append(" insert into AP#ITFeedbackDetail (TRANSID, QUESTIONID ,RatingId , SUBJECTIVEANSWER, EVALUATIONVALUE , REMARKS ,DEACTIVE ,FeedbackBY, FeedbackDate) ");
                eqry.append(" VALUES('").append(id).append("','").append(mp.get("questionID")).append("','").append(mp.get("ratingid")).append("','").append(issubjective).append("','").append(ratinId).append("','").append(mp.get("Remarks")).append("','").append("N");
                eqry.append("','").append(mp.get("entryBy").toString().trim()).append("',").append("sysdate)");

                if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                statmtt=dbConnection.createStatement();
                 statmtt.executeUpdate(eqry.toString());
                }
        }// End of Else insert if id not generated

        }catch(Exception e)
         {

             e.printStackTrace();
             return "";
         }
          finally{
          if(state2!=null){
          state2.close();
          }if(statmtt!=null){
            statmtt.close();
             }
             if(state2!=null){
            state2.close();
             }

 }


    return id;
   }




      public String getFeedBackID(Map hm) throws SQLException
      {
      String feedbackID="";
      String feedbackDesc="";
      String concat="";
      StringBuilder sb =new StringBuilder();
      Statement  sttmm=null;
      ResultSet   rsat=null;
     // PreparedStatement ptsa=null;
    // ResultSet rsa=null;
      try{
      sb.append("select APFEEDBACKID,APFEEDBACKNAME from AP#FEEDBACKTYPEMASTER where APFEEDBACKTYPE='SHFACULTY'");

      if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
      sttmm=dbConnection.createStatement();
      rsat= sttmm.executeQuery(sb.toString());

     // ptsa = dbConnection.prepareStatement(sb.toString());
     //  rsa = ptsa.executeQuery();
      while(rsat.next()){
         feedbackID=rsat.getString(1);
         feedbackDesc=rsat.getString(2);
         }
      concat=feedbackID+"/"+feedbackDesc;

      }catch(Exception e)
      {
      e.printStackTrace();
      }
      finally{
      if(sttmm!=null){
        sttmm.close();
      }if(rsat!=null){
      rsat.close();
      }
      }
      return concat;
      }


      // --------------------------------Final Save-----------------------------------

      private String finalsave(Map hm) throws SQLException {


        StringBuffer sqry = new StringBuffer();
        StringBuffer sqry1 = new StringBuffer();
        StringBuffer sqry2 = new StringBuffer();
        ArrayList list = (ArrayList) hm.get("para");
        String Draft="";
        Set st=new HashSet();
        String tempValue="";
        String id = "";
        PreparedStatement pst1=null;
        ResultSet rss1=null,rssett=null;
          StringBuilder eqry = new StringBuilder();
           StringBuilder eqry2 = new StringBuilder();
           StringBuilder uqry = new StringBuilder();
           StringBuilder uqry2 = new StringBuilder();
        Statement state2=null,statmtt=null,ustate=null,ustatmtt=null;
        try {

        sqry.append(" select Transid,DOCMODE  from AP#ITFeedbackHeader where INSTITUTECODE='"+hm.get("instituteid")+"' and ITEVENTID ='"+hm.get("EventCode")+"' and FEEDBACKBY ='"+hm.get("entryBy")+"'");
        if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
        statmtt=dbConnection.createStatement();
        rssett= statmtt.executeQuery(sqry.toString());
        if (rssett.next()) {
                id=rssett.getString("TRANSID");
                Draft=rssett.getString("DOCMODE");
                for(int x=0;x<list.size();x++){
                  Map mp=(Map)list.get(x);
                  eqry = new StringBuilder();
                  String issubjective="";
                  String ratinId="";
                  if(mp.get("issubjective").toString().equalsIgnoreCase("N") ){
                  ratinId=mp.get("rating").toString();
                  issubjective=" ";
                  }else {
                  issubjective=mp.get("rating").toString();
                  ratinId="0";
                  }

                  String upqry="select  * from AP#ITFeedbackdetail  where transid='"+id+"' and questionid='"+mp.get("questionID")+"'";
                  Statement  upsta=dbConnection.createStatement();
                  ResultSet uprsa= upsta.executeQuery(upqry.toString());
                  StringBuilder saqry = new StringBuilder();
                   if(uprsa.next()) {
                  saqry.append("update AP#ITFeedbackDetail set EVALUATIONVALUE='"+ratinId+"',SUBJECTIVEANSWER='"+issubjective+"' ,REMARKS='"+mp.get("Remarks")+"',feedbackdate=sysdate where transid='"+id+"' and questionid='"+mp.get("questionID")+"'");
                  if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                  upsta=dbConnection.createStatement();
                  upsta.executeUpdate(saqry.toString());

                   }else{
                 String headerremarks;
                      if(hm.get("headerremarks")==null){
                 headerremarks=" ";
                 }else{
                 headerremarks=hm.get("headerremarks").toString();
                 }

                eqry.append("insert into AP#ITFeedbackHeader (TRANSID ,INSTITUTECODE,ITEVENTID,TRANSACTIONDATE,DOCMODE,DEACTIVE ,FeedbackBY ,REMARKS, FeedBackDATE)");
                eqry.append(" VALUES('").append(id).append("','").append(hm.get("instituteid")).append("','").append(hm.get("EventCode")).append("',").append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append("D','N").append("',");
                eqry.append("'").append(hm.get("entryBy").toString().trim()).append("','").append(headerremarks).append("',").append("sysdate)");
                if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                statmtt=dbConnection.createStatement();
                statmtt.executeUpdate(saqry.toString());


                   }
                }
                //--------------------Update Docmode D to F------------------------------------

                sqry1.append(" update AP#ITFeedbackHeader set DOCMODE='F'  where INSTITUTECODE='"+hm.get("instituteid")+"' and ITEVENTID ='"+hm.get("EventCode")+"' and FEEDBACKBY ='"+hm.get("entryBy")+"'");
                ustatmtt=dbConnection.createStatement();
                ustatmtt.executeUpdate(sqry1.toString());

        }//--------------------------First Time Final Save While ID Not Generated-----------------------------------------------------
        else{
               try {
                   if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                   callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                   callableStatement.setString(1, "0001");
                   callableStatement.setString(2, "ITFBMid");
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



                eqry.append("insert into AP#ITFeedbackHeader (TRANSID ,INSTITUTECODE,ITEVENTID,TRANSACTIONDATE,DOCMODE,DEACTIVE ,FeedbackBY , FeedBackDATE)");
                eqry.append(" VALUES('").append(id).append("','").append(hm.get("instituteid")).append("','").append(hm.get("EventCode")).append("',").append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append("F','N").append("',");
                eqry.append("'").append(hm.get("entryBy").toString().trim()).append("',").append("sysdate)");


                if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                state2=dbConnection.createStatement();
                state2.executeUpdate(eqry.toString());

                for(int x=0;x<list.size();x++){

                 Map mp=(Map)list.get(x);
                  eqry = new StringBuilder();
                  String issubjective="";
                  String ratinId="";

                  if(mp.get("issubjective").toString().equalsIgnoreCase("N") ){
                  ratinId=mp.get("rating").toString();
                  issubjective=" ";

                  }else {
                  issubjective=mp.get("rating").toString();
                  ratinId="0";


                  }
                eqry.append(" insert into AP#ITFeedbackDetail (TRANSID, QUESTIONID ,RatingId , SUBJECTIVEANSWER, EVALUATIONVALUE , REMARKS ,DEACTIVE ,FeedbackBY, FeedbackDate) ");
                eqry.append(" VALUES('").append(id).append("','").append(mp.get("questionID")).append("','").append(mp.get("ratingid")).append("','").append(issubjective).append("','").append(ratinId).append("','").append(mp.get("Remarks")).append("','").append("N");
                eqry.append("','").append(mp.get("entryBy").toString().trim()).append("',").append("sysdate)");

                if(dbConnection.isClosed()){
                     dbConnection=DBUtility.getConnection(dbConnection);
            }
                statmtt=dbConnection.createStatement();
                 statmtt.executeUpdate(eqry.toString());
                }
        }// End of Else insert if id not generated

        }
        catch(Exception e)
         {
            e.printStackTrace();
             return "";
         }
          finally{
 if(state2!=null){
            state2.close();
          }
 }
    return id;
   }


}

