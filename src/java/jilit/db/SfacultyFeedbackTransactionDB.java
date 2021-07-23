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
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import jdbc.DBUtility;
import tietwebkiosk.IQACconnection;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class SfacultyFeedbackTransactionDB {
   // private Connection dbConnection;
   // private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs=null;
    private ResultSet rs1=null;
    IQACconnection db=new IQACconnection();

    public SfacultyFeedbackTransactionDB() {
      //  dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectGridData,saveupdate, selectData, headID, SelectforUpdate,feedbackID,lowerGrid,selectDataForUpgrade,checkExpiryDate,validateData
    }


     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (SfacultyFeedbackTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectGridData:
                    responseString = mapper.writeValueAsString(selectGridData(hm));
                    break;
                case saveupdate:
                    responseString =SaveUpdateData(hm);
                    break;
                case selectData:
                    responseString = mapper.writeValueAsString(getSelectData(hm));
                    break;
                case headID:
                    responseString = getParentQuestion(hm);
                    break;
                case feedbackID:
                    responseString = getFeedBackID(hm);
                    break;
                case lowerGrid:
                    responseString = mapper.writeValueAsString(getLowerGridData(hm));
                    break;
                case selectDataForUpgrade:
                    responseString = mapper.writeValueAsString(getSelectDataForUpgrade(hm));
                    break;
                case checkExpiryDate:
                    responseString = getExpiryDate(hm);
                    break;
                case validateData:
                    responseString = getValidateData(hm);
                    break;

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseString;
    }


     private Map selectGridData(Map hm) throws SQLException {
        StringBuffer sqry = new StringBuffer();
        Map tm = new HashMap();
        Map SelectData = new HashMap();
        int k = 1;
        Statement statmt=null;
        ResultSet rsset=null;
        PreparedStatement pt=null;
        ResultSet rsa=null;
        // Statement sta=dbConnection.createStatement();
              //  ResultSet rsa= sta.executeQuery(sqry.toString());
        try {
          sqry.append("SELECT NVL(AM.HEADID,'')HEADID,NVL(QUESTIONID,' ')QUESTIONID,NVL(QUESTIONBODY,' ')QUESTIONBODY,NVL(RATINGID,' ') RATING,NVL(AH.PARENTHEADID,'')PARENTHEADID,nvl( (select decode(x.headid,'','N','Y') from AP#SHQUESTIONMASTER x where X.HEADID in  (select parentheadid from AP#SHQUESTIONHEAD WHERE FEEDBACKID = X.FEEDBACKID AND HEADID = X.HEADID ) and x.headid = am.headid and rownum =1),'N') flag,NVL (AM.MANDATORYQUESTION, 'N')MANDATORYQUESTION FROM AP#SHQUESTIONMASTER AM,AP#SHQUESTIONHEAD AH WHERE AM.COMPANYCODE=AH.COMPANYCODE AND AM.INSTITUTECODE=AH.INSTITUTECODE AND AM.FEEDBACKID=AH.FEEDBACKID AND AM.COMPONENTTYPE=AH.COMPONENTTYPE AND AM.HEADID=AH.HEADID AND AM.EXAMCODE=AH.EXAMCODE AND AM.COMPONENTTYPE='F' AND AM.FEEDBACKID='"+hm.get("feedbackid")+"' ORDER BY AM.SEQID");
         // pt = dbConnection.prepareStatement(sqry.toString());
          rsa=db.getRowset(sqry.toString());
          while (rsa.next()) {
                        SelectData= new HashMap();
                        SelectData.put("slno",k);
                        SelectData.put("headid",rsa.getString(1));
                        SelectData.put("questionid",rsa.getString(2));
                        SelectData.put("questionbody",rsa.getString(3));
                        SelectData.put("ratingid",rsa.getString(4));
                        SelectData.put("parentHeadID",rsa.getString(5));
                        SelectData.put("flag",rsa.getString(6));
                        SelectData.put("mandatoryQuestion",rsa.getString(7));
                        tm.put(k,SelectData);
                  k++;
                }
          tm.put("rating",getRatingCombo());
        } catch (Exception e) {
            e.printStackTrace();
        }

         finally{
             if(statmt!=null){
            statmt.close();
             }
         //   rsset.close();
         //   dbConnection.close();
    //DBUtility.closeConnection(dbConnection);

 }
        return tm;
     }
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
     sb.append("select  rd.RATINGID,wm_concat(distinct '\"'||rd.rating||'@@'||rd.ratingdesc||'\"'),rm.subjective from ap#shratingdetail rd,ap#shratingmaster rm where rd.companycode=rm.companycode and rd.institutecode=rm.institutecode and rd.examcode=rm.examcode and rd.feedbackid=rm.feedbackid and rd.ratingid=rm.ratingid group by  rd.RATINGID,rm.subjective ");
//     pStmt = dbConnection.prepareStatement(sb.toString());
//     rs = pStmt.executeQuery();

      rssett=db.getRowset(sb.toString());
          while (rssett.next()) {
                 if(rssett.getString(3).equals("Y"))
                 {
                 al.put(rssett.getString(1),"[\"@@\"]");
                 }else{
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
         //   dbConnection.close();
   // DBUtility.closeConnection(dbConnection);

 }
          return al;
     }

     public String checkQuestionType(String ratingid) throws SQLException{
         String questionType="";
         StringBuilder sb=new StringBuilder();
          Statement statmte=null;
          ResultSet rssete=null;
         try{
         sb.append("select subjective from ap#shratingmaster where ratingid='"+ratingid+"'");
        rssete= db.getRowset(sb.toString());
         if(rssete.next())
         {
         questionType=rssete.getString(1);
         }
         }catch(Exception e){
         e.printStackTrace();
         }
        finally{
              if(statmte!=null){
            statmte.close();
          }
          if(rssete!=null){
            rssete.close();
          }

           // dbConnection.close();
  //  DBUtility.closeConnection(dbConnection);

 }
     return questionType;
     }



      private String SaveUpdateData(Map hm) throws SQLException
   {

        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        ArrayList list = (ArrayList) hm.get("para");
        Set st=new HashSet();
        String tempValue="";
         String id = "";
         PreparedStatement pst1=null;
         //Statement state=null;
         ResultSet rss1=null;
          Statement state2=null;
        try {
           if (hm.get("transactionID").equals("0")) {
               try {

                
                   id = db.generateID();
                   //System.out.println(" generate Id-----------"+id);
               } catch (Exception e) {
                   e.printStackTrace();
               } 


                eqry.append("insert into  AP#FACULTYSHFEEDBACKHEADER ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APACADEMICYEAR,PROGRAMCODE,DEPARTMENTCODE,APFEEDBACKREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(hm.get("feedbackName")).append("',");
                eqry.append("'").append(hm.get("academicYear").toString().trim()).append("','").append(hm.get("programName")).append("','").append(getDepartmentCode(hm.get("departmentName").toString().replaceAll("@@@", "&"))).append("','").append(hm.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");

                 db.insertRow(eqry.toString());

                  //pst1 = dbConnection.prepareStatement(eqry.toString());
              //  pst1.executeUpdate();

            } else {
                sqry.append("Update AP#FACULTYSHFEEDBACKHEADER set COMPANYID='").append(hm.get("companyid")).append("',INSTITUTEID='").append(hm.get("instituteid")).append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",APFEEDBACKID='").append(hm.get("feedbackName")).append("',APACADEMICYEAR='").append(hm.get("academicYear").toString().trim()).append("',PROGRAMCODE='").append(hm.get("programName")).append("',");
                sqry.append("DEPARTMENTCODE='").append(getDepartmentCode(hm.get("departmentName").toString().replaceAll("@@@", "&"))).append("',APFEEDBACKREMARKS='").append(hm.get("remarks")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where TRANSACTIONID='").append(hm.get("transactionID")).append("'");;
                 db.update(sqry.toString());
                //pst1.executeUpdate();
                id=hm.get("transactionID").toString();

           }



                String Querry = " delete from AP#FACULTYSHFEEDBACKDETAIL where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                 db.update(Querry);
             //   pst1 = dbConnection.prepareStatement(Querry);
             //   pst1.executeUpdate();

                if(hm.get("transactionID").equals("0")){
                for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);


                eqry.append("insert into  AP#FACULTYSHFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");

                //System.out.println(" After Delete Statment============= Printing Again eqry  "+eqry);
                 db.insertRow(eqry.toString());

             //   pst1 = dbConnection.prepareStatement(eqry.toString());
            //    pst1.executeUpdate();
                }

            }else
                {
                    for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#FACULTYSHFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");

                 //System.out.println(" in Else Insert Query ============= Printing Again eqry  "+eqry);
                db.insertRow(eqry.toString());

               //  pst1 = dbConnection.prepareStatement(eqry.toString());
               // pst1.executeUpdate();
                }
                }



        }catch(Exception e)
         {

             e.printStackTrace();
             return "";
         }
          finally{
 if(state2!=null){
            state2.close();
          }

            state2.close();
//            rs1.close();
//            dbConnection.close();
//    DBUtility.closeConnection(dbConnection);

 }


    return id;
   }


      private Map getSelectData(Map hm) throws SQLException {
         StringBuffer sqry = new StringBuffer();
         StringBuffer equery = new StringBuffer();
         TreeMap tm =new TreeMap();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
         Statement sta=null;
          ResultSet rsa=null;
         int k = 1;
            try {
                sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                        + "nvl(TRANSACTIONID,'')TRANSACTIONID,nvl(APFEEDBACKID,'')APFEEDBACKID,"
                        + "nvl(APACADEMICYEAR,'')APACADEMICYEAR,nvl(PROGRAMCODE,'')PROGRAMCODE,"
                        + "nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(APFEEDBACKREMARKS,'')APFEEDBACKREMARKS "
                        +" from AP#FACULTYSHFEEDBACKHEADER");
                sqry.append(" where ").append( "APFEEDBACKID='").append(hm.get("feedbackid")).append("'");


                 
               rsa= db.getRowset(sqry.toString());

                // pStmt = dbConnection.prepareStatement(sqry.toString());
               // rs = pStmt.executeQuery();
                while (rsa.next()) {

                        SelectData.put("transactiondate",rsa.getString(1));
                        SelectData.put("transactionID",rsa.getString(2));
                        SelectData.put("feedbackID",rsa.getString(3));
                        SelectData.put("academicYear",rsa.getString(4).trim());
                        SelectData.put("programcode",rsa.getString(5));
                        SelectData.put("department",rsa.getString(6));
                        SelectData.put("feedbackRemarks",rsa.getString(7));



                }
                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE, NVL (APFEEDBACKID, '') APFEEDBACKID,"
                        + "nvl(APFEEDBACKITEMID,'')APFEEDBACKITEMID,nvl(APFEEDBACKITEMREMARKS,'')APFEEDBACKITEMREMARKS,"
                        + "nvl(APFEEDBACKRATINGID,'')APFEEDBACKRATINGID,nvl(APFEEDBACKRATING,'')APFEEDBACKRATING,"
                        + "nvl(APFEEDBACKUSERREMARKS,'')APFEEDBACKUSERREMARKS FROM AP#FACULTYSHFEEDBACKDETAIL ");
                sqry.append(" where ").append( "APFEEDBACKID='").append(hm.get("feedbackid")).append("'");

                rsa= db.getRowset(sqry.toString());
                //   pStmt = dbConnection.prepareStatement(sqry.toString());
               // rs = pStmt.executeQuery();
                while (rsa.next()) {
                        SelectData1 = new HashMap();
                        SelectData1.put("transactionID",rsa.getString(1));
                        SelectData1.put("transactionDate",rsa.getString(2));
                        SelectData1.put("feedbackID",rsa.getString(3));
                        SelectData1.put("questionID",rsa.getString(4));
                        SelectData1.put("questionRemarks",rsa.getString(5));
                        SelectData1.put("ratingID",rsa.getString(6));
                        SelectData1.put("rating",rsa.getString(7));
                        SelectData1.put("userRemarks",rsa.getString(8));
                        tm.put(k, SelectData1);
                        k++;


                }
                SelectData.put("childMap", tm);
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
//          sta.close();
//         rsa.close();
          //  dbConnection.close();
//    DBUtility.closeConnection(dbConnection);

 }
        return SelectData;
    }

      public String getParentQuestion(Map hm) throws SQLException
      {
      String tempVal="false";
      String tempVal1="";
      StringBuilder sb=new StringBuilder();
      Statement sttm=null;
      ResultSet rstt=null;
      try
      {
      sb.append("select parentheadid from ap#shquestionhead where headid='"+hm.get("headid")+"'");
      
       rstt = db.getRowset(sb.toString());
       if(rstt.next())
       {
        tempVal1=rstt.getString(1);
        if(!tempVal1.equals("")){
        tempVal="true";
        }
       }
      }catch(Exception e)
      {
      e.printStackTrace();
      }
       finally{
            if(sttm!=null){
            sttm.close();
          }
          if(rstt!=null){
            rstt.close();
          }
           // sttm.close();
          //  rstt.close();
//            dbConnection.close();
//    DBUtility.closeConnection(dbConnection);

 }

      return tempVal;
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
       
      rsat= db.getRowset(sb.toString());

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

      private Map getLowerGridData(Map hm) throws SQLException {
        StringBuffer sqry = new StringBuffer();
        Map SelectData = new HashMap();
        Map outerData=new HashMap();
         Statement sta=null;
         ResultSet rsa=null;
        int k=1;
        try {
          sqry.append("select ah.transactionid,ah.apfeedbackid,ah.programcode,dm.department,ah.apacademicyear,ah.apfeedbackremarks from ap#facultyshfeedbackheader ah,departmentmaster dm where  ah.departmentcode=dm.departmentcode and ah.apacademicyear='"+hm.get("academicYear").toString().trim()+"' and ah.entryby='"+hm.get("entryBy")+"'");
       
         rsa= db.getRowset(sqry.toString());

          //  pStmt = dbConnection.prepareStatement(sqry.toString());
        //  rs = pStmt.executeQuery();
          while (rsa.next()) {
                       SelectData = new HashMap();
                       SelectData.put("transactionID",rsa.getString(1));
                        SelectData.put("feedbackid",rsa.getString(2));
                        SelectData.put("department",rsa.getString(4));
                        SelectData.put("academicyear",rsa.getString(5).trim());
                        SelectData.put("remarks",rsa.getString(6));
                        SelectData.put("programcode",rsa.getString(3).replaceAll("[()]", ""));
                        outerData.put(k,SelectData);
                        k++;

                }

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
           //sta.close();
            //rsa.close();
//            dbConnection.close();
//    DBUtility.closeConnection(dbConnection);

 }
        return outerData;
    }

      private Map getSelectDataForUpgrade(Map hm) throws SQLException {
         StringBuffer sqry = new StringBuffer();
         StringBuffer equery = new StringBuffer();
         TreeMap tm =new TreeMap();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
          Statement st=null;
           ResultSet rso=null;

         int k = 1;
            try {
                sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                        + "nvl(TRANSACTIONID,'')TRANSACTIONID,nvl(APFEEDBACKID,'')APFEEDBACKID,"
                        + "nvl(APACADEMICYEAR,'')APACADEMICYEAR,nvl(PROGRAMCODE,'')PROGRAMCODE,"
                        + "nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(APFEEDBACKREMARKS,'')APFEEDBACKREMARKS "
                        +" from AP#FACULTYSHFEEDBACKHEADER");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");

                

         rso=db.getRowset(sqry.toString());

              //  pStmt = dbConnection.prepareStatement(sqry.toString());
              //  rs = pStmt.executeQuery();
                while (rso.next()) {

                        SelectData.put("transactiondate",rso.getString(1));
                        SelectData.put("transactionID",rso.getString(2));
                        SelectData.put("feedbackID",rso.getString(3));
                        SelectData.put("academicYear",rso.getString(4).trim());
                        SelectData.put("department",getDepartmentName(rso.getString(6)));
                        SelectData.put("feedbackRemarks",rso.getString(7));
                        SelectData.put("programcode",rso.getString(5));



                }
                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE, NVL (APFEEDBACKID, '') APFEEDBACKID,"
                        + "nvl(APFEEDBACKITEMID,'')APFEEDBACKITEMID,nvl(APFEEDBACKITEMREMARKS,'')APFEEDBACKITEMREMARKS,"
                        + "nvl(APFEEDBACKRATINGID,'')APFEEDBACKRATINGID,nvl(APFEEDBACKRATING,'')APFEEDBACKRATING,"
                        + "nvl(APFEEDBACKUSERREMARKS,'')APFEEDBACKUSERREMARKS FROM AP#FACULTYSHFEEDBACKDETAIL ");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");

                

                rso=db.getRowset(sqry.toString());

                //    pStmt = dbConnection.prepareStatement(sqry.toString());
            //    rs = pStmt.executeQuery();
                while (rso.next()) {
                        SelectData1 = new HashMap();
                        SelectData1.put("transactionID",rso.getString(1));
                        SelectData1.put("transactionDate",rso.getString(2));
                        SelectData1.put("feedbackID",rso.getString(3));
                        SelectData1.put("questionID",rso.getString(4));
                        SelectData1.put("questionRemarks",rso.getString(5));
                        SelectData1.put("ratingID",rso.getString(6));
                        SelectData1.put("rating",rso.getString(7));
                        SelectData1.put("userRemarks",rso.getString(8));
                        tm.put(k, SelectData1);
                        k++;


                }
                SelectData.put("childMap", tm);
             } catch (Exception e) {
                 e.printStackTrace();
             }

         finally{
          if(st!=null){
            st.close();
          }
          if(rso!=null){
            rso.close();
          }
      //      dbConnection.close();
      //    DBUtility.closeConnection(dbConnection);

 }
        return SelectData;
    }

      public String getProgramName(String programcode) throws SQLException
     {
     String programCode="";
     Statement sttm=null;
     ResultSet rest=null;
     try{
     String qry="select programname from programmaster where programcode='"+programcode+"'";
     
     rest = db.getRowset(qry.toString());
     if(rest.next())
     {
         programCode=rest.getString(1);
     }
     }catch(Exception e)
     {
         e.printStackTrace();;
     }
    finally{
         if(sttm!=null){
            sttm.close();
          }
          if(rest!=null){
            rest.close();
          }
           // sttm.close();
           // rest.close();
           // dbConnection.close();
//    DBUtility.closeConnection(dbConnection);

 }
     return programCode;
     }


      public String getDepartmentCode(String department) throws SQLException
     {
     String departmentCode="";
   Statement pstmtt=null;
     ResultSet rsst=null;
     try{
     String qry="select departmentcode from departmentmaster where department='"+department.replace("'", "''")+"'";

     
     rsst = db.getRowset(qry.toString());
     if(rsst.next())
     {
         departmentCode=rsst.getString(1);
     }
     }catch(Exception e)
     {
         e.printStackTrace();;
     }
     finally{
         if(pstmtt!=null){
            pstmtt.close();
          }
          if(rsst!=null){
            rsst.close();
          }
         //   pstmtt.close();
         //   rsst.close();
           // dbConnection.close();
//    DBUtility.closeConnection(dbConnection);

 }
     return departmentCode;
     }
    public String getDepartmentName(String department) throws SQLException {
        String departmentCode = "";
        Statement stamt=null;
        ResultSet reest=null;
        try {
            String qry = "select department from departmentmaster where departmentcode='" + department + "'";
     
            reest = db.getRowset(qry.toString());
            if (reest.next()) {
                departmentCode = reest.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();;
        }
        finally{
            if(stamt!=null){
            stamt.close();
          }
          if(reest!=null){
            reest.close();
          }
          //  stamt.close();
          //  reest.close();
        //    dbConnection.close();
//    DBUtility.closeConnection(dbConnection);

 }
        return departmentCode;
    }


    public String getExpiryDate(Map hm) throws SQLException
    {
        String tempVariable="false";
        StringBuilder sb=new StringBuilder();
        PreparedStatement ptst=null;
        Statement st=null;
        ResultSet rsa=null;

        try
        {
        sb.append("select apfeedbackid from AP#FEEDBACKTYPEMASTER where to_date('"+hm.get("todayDate")+"','dd-mm-yyyy')  between apfeedbackfromdate and apfeedbacktodate and apfeedbacktype='SHFACULTY'");
        
        rsa = db.getRowset(sb.toString());
        if(rsa.next())
        {
          tempVariable="true";
        }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
         finally{
              if(st!=null){
            st.close();
          }
          if(rsa!=null){
            rsa.close();
          }
           // st.close();
          //  rsa.close();
//            dbConnection.close();
//    DBUtility.closeConnection(dbConnection);

 }


        return tempVariable;
    }


    public String getValidateData(Map hm) throws SQLException
       {
       String tempVal="00";
       StringBuilder sb=new StringBuilder();
       Statement sam=null;
       ResultSet ram=null;
       try{
       sb.append("select transactionid from ap#facultyshfeedbackheader where apfeedbackid='"+hm.get("feedbackID")+"' and apacademicyear='"+hm.get("academicYear").toString().trim()+"' and entryby='"+hm.get("entryBy")+"'");
       
       ram = db.getRowset(sb.toString());
       if(ram.next())
       {
        tempVal="11";
       }
       }catch(Exception e)
       {
       e.printStackTrace();
       }

           finally{
              if(sam!=null){
            sam.close();
          }
          if(ram!=null){
            ram.close();
          }
         // sam.close();
           // ram.close();
//            dbConnection.close();
//    DBUtility.closeConnection(dbConnection);

 }

       return tempVal;
       }
}
