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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import tietwebkiosk.IQACconnection;
/**
 *
 * @author nipun.gupta
 */
public class StudentFeedbackTransactionDB {
    //private Connection dbConnection;
    private PreparedStatement pStmt=null;
    private CallableStatement callableStatement = null;
    private ResultSet rs=null;
    private ResultSet rs1=null;
    IQACconnection db=new IQACconnection();
    public StudentFeedbackTransactionDB() {
       // dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectGridData,saveupdate, selectData, headID, SelectforUpdate,feedbackID,lowerGrid,selectDataForUpgrade,studentNamesInPopUp,validateData,checkExpiryDate
    }


     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (StudentFeedbackTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectGridData:
                    responseString = mapper.writeValueAsString(selectGridData(hm));
                    break;
                case studentNamesInPopUp:
                     responseString = mapper.writeValueAsString(getStudentsName(hm));
                    break;
                case saveupdate:
                    responseString =SaveUpdateData(hm);
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
                case validateData:
                    responseString = getValidateData(hm);
                    break;
               case checkExpiryDate:
                    responseString = getExpiryDate(hm);
                    break;

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            return responseString;
    }

    }


     public String getFeedBackID(Map hm)
      {
      String feedbackID="";
      String feedbackDesc="";
      String concat="";
      StringBuilder sb =new StringBuilder();
      try{
      sb.append("select APFEEDBACKID,APFEEDBACKNAME from AP#FEEDBACKTYPEMASTER where APFEEDBACKTYPE='SHSTUDENT'");
      //if(dbConnection.isClosed()){
       //              dbConnection=DBUtility.getConnection(dbConnection);
         //         }
     // pStmt = dbConnection.prepareStatement(sb.toString());
       rs = db.getRowset(sb.toString());
      while(rs.next()){
         feedbackID=rs.getString(1);
         feedbackDesc=rs.getString(2);
         }
      concat=feedbackID+"/"+feedbackDesc;
      }catch(Exception e)
      {
      e.printStackTrace();
      }
      finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            return concat;
    }

      }

     private Map selectGridData(Map hm) {
        StringBuffer sqry = new StringBuffer();
       Map tm = new HashMap();
        Map SelectData = new HashMap();
        int k = 1;
        try {
          sqry.append("SELECT NVL(AM.HEADID,'')HEADID,NVL(QUESTIONID,' ')QUESTIONID,NVL(QUESTIONBODY,' ')QUESTIONBODY,NVL(RATINGID,' ') RATING,NVL(AH.PARENTHEADID,'')PARENTHEADID,nvl( (select decode(x.headid,'','N','Y') from AP#SHQUESTIONMASTER x where X.HEADID in  (select parentheadid from AP#SHQUESTIONHEAD WHERE FEEDBACKID = X.FEEDBACKID AND HEADID = X.HEADID ) and x.headid = am.headid and rownum =1),'N') flag,NVL (AM.MANDATORYQUESTION, 'N')MANDATORYQUESTION FROM AP#SHQUESTIONMASTER AM,AP#SHQUESTIONHEAD AH WHERE AM.COMPANYCODE=AH.COMPANYCODE AND AM.INSTITUTECODE=AH.INSTITUTECODE AND AM.FEEDBACKID=AH.FEEDBACKID AND AM.COMPONENTTYPE=AH.COMPONENTTYPE AND AM.HEADID=AH.HEADID AND AM.EXAMCODE=AH.EXAMCODE AND AM.COMPONENTTYPE='D' AND AM.FEEDBACKID='"+hm.get("feedbackid")+"' ORDER BY AM.QUESTIONID");
          //pStmt = dbConnection.prepareStatement(sqry.toString());
          rs = db.getRowset(sqry.toString());
          while (rs.next()) {
                        SelectData= new HashMap();
                        SelectData.put("slno",k);
                        SelectData.put("headid",rs.getString(1));
                        SelectData.put("questionid",rs.getString(2));
                        SelectData.put("questionbody",rs.getString(3));
                        SelectData.put("ratingid",rs.getString(4));
                        SelectData.put("parentHeadID",rs.getString(5));
                        SelectData.put("flag",rs.getString(6));
                        SelectData.put("mandatoryQuestion",rs.getString(7));
                        tm.put(k,SelectData);
                  k++;
                }
          tm.put("rating",getRatingCombo());
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            return tm;
    }

    }

     public Map getRatingCombo()
     {
     Map al=new HashMap();
     String ratingID="";
     String questionType="";
     StringBuilder sb=new StringBuilder();
     try{
     //sb.append("select  RATINGID,wm_concat( '\"'||rating||'@@'||ratingdesc||'\"') from ap#ratingdetail group by RATINGID");
     sb.append("select  rd.RATINGID,wm_concat(distinct '\"'||rd.rating||'@@'||rd.ratingdesc||'\"'),rm.subjective from ap#shratingdetail rd,ap#shratingmaster rm where rd.companycode=rm.companycode and rd.institutecode=rm.institutecode and rd.examcode=rm.examcode and rd.feedbackid=rm.feedbackid and rd.ratingid=rm.ratingid group by  rd.RATINGID,rm.subjective ");
    //if(dbConnection.isClosed()){
      //               dbConnection=DBUtility.getConnection(dbConnection);
        //          }
    // pStmt = dbConnection.prepareStatement(sb.toString());
     rs = db.getRowset(sb.toString());
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
     finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            return al;
    }

     }


     private Map getStudentsName(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();
        try {

            if(!hm.get("searchNames").equals("")){
              searchBoxValue="and (studentname like '%"+hm.get("searchNames")+"%')";
              }

                sqry.append(" SELECT a.*, B.*\n" +
                "  FROM (SELECT COUNT (studentid) Totalrecord FROM studentmaster where programcode is not null) a,\n" +
"       (SELECT *\n" +
"          FROM (SELECT NVL (studentid, '') studentid,\n" +
"       NVL (studentname, '') studentname,\n" +
"       NVL (programcode, '') programcode,\n" +
"       NVL (academicyear, '') academicyear,\n" +
"       ROWNUM R\n" +
"  FROM studentmaster\n" +
" WHERE programcode IS NOT NULL "+searchBoxValue+"  ORDER BY R)\n" +
"         WHERE r > "+hm.get("spg")+" AND r <= "+hm.get("epg")+") b  ");


                int k = 1;
               // if(dbConnection.isClosed()){
                 //    dbConnection=DBUtility.getConnection(dbConnection);
                  //}
               // pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = db.getRowset(sqry.toString());
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("totalrecords",rs.getString(1));
                        SelectData.put("studentID",rs.getString(2));
                        SelectData.put("studentName",rs.getString(3));
                        SelectData.put("academicYear",rs.getString(5));
                        SelectData.put("sno", rs.getString(6));
                        SelectData.put("programCode",getProgramName(rs.getString(4)));
                        tm.put(k, SelectData);
                        k++;
                }

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            return tm;
    }

    }

      private String SaveUpdateData(Map hm)
   {

        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        ArrayList list = (ArrayList) hm.get("para");
         String id = "";
        try {
           if (hm.get("transactionID").equals("0")) {
               try {
                  // if(dbConnection.isClosed()){
                    // dbConnection=DBUtility.getConnection(dbConnection);
                 // }
                   //callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                  // callableStatement.setString(1, "0001");
                  // callableStatement.setString(2, "FBMId");
                 //  callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                 //  callableStatement.execute();
                  // id = callableStatement.getString(3);
                   id=db.generateID();
               } catch (Exception e) {
                   e.printStackTrace();
               } finally {
                    if (callableStatement != null) {
                       callableStatement.close();
                   }
               }

                eqry.append("insert into  AP#STUDENTFEEDBACKHEADER ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APSTUDENTID,APACADEMICYEAR,PROGRAMCODE,APFEEDBACKFIRSTREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(hm.get("feedbackName")).append("',");
                eqry.append("'").append(hm.get("studentID")).append("','").append(hm.get("academicYear")).append("','").append(getProgramCode(hm.get("programName").toString())).append("','").append(hm.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               // if(dbConnection.isClosed()){
               //      dbConnection=DBUtility.getConnection(dbConnection);
                //  }
               // pStmt = dbConnection.prepareStatement(eqry.toString());
               db.insertRow(eqry.toString());

            } else {
                sqry.append("Update AP#STUDENTFEEDBACKHEADER set COMPANYID='").append(hm.get("companyid")).append("',INSTITUTEID='").append(hm.get("instituteid")).append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",APFEEDBACKID='").append(hm.get("feedbackName")).append("',APSTUDENTID='").append(hm.get("studentID")).append("',APACADEMICYEAR='").append(hm.get("academicYear")).append("',PROGRAMCODE='").append(getProgramCode(hm.get("programName").toString())).append("',");
                sqry.append("APFEEDBACKFIRSTREMARKS='").append(hm.get("remarks")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where TRANSACTIONID='").append(hm.get("transactionID")).append("'");
              //  if(dbConnection.isClosed()){
                 //    dbConnection=DBUtility.getConnection(dbConnection);
                  //}
               // pStmt = dbConnection.prepareStatement(sqry.toString());
               // pStmt.executeUpdate();
                db.insertRow(eqry.toString());
                id=hm.get("transactionID").toString();

           }



                String Querry = " delete from AP#STUDENTFEEDBACKDETAIL where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                //if(dbConnection.isClosed()){
                 //    dbConnection=DBUtility.getConnection(dbConnection);
                 // }
                //pStmt = dbConnection.prepareStatement(Querry);
                db.update(Querry.toString());

                if(hm.get("transactionID").equals("0")){
                for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#STUDENTFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               // if(dbConnection.isClosed()){
               //      dbConnection=DBUtility.getConnection(dbConnection);
                //  }
                //pStmt = dbConnection.prepareStatement(eqry.toString());
                db.insertRow(eqry.toString());
                }

            }else
                {
                    for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#STUDENTFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                //if(dbConnection.isClosed()){
                  //   dbConnection=DBUtility.getConnection(dbConnection);
                 // }
               // pStmt = dbConnection.prepareStatement(eqry.toString());
               // pStmt.executeUpdate();
                db.insertRow(eqry.toString());
                }
                }



        }catch(Exception e)
         {

             e.printStackTrace();
             return "Record Not Saved";
         }
         finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

           return id;
    }



   }

      private Map getLowerGridData(Map hm) {
        StringBuffer sqry = new StringBuffer();
        Map SelectData = new HashMap();
        Map outerData=new HashMap();
        int k=1;
        try {
          sqry.append("select ah.transactionid,ah.apfeedbackid,ah.programcode,ah.apacademicyear,ah.apfeedbackfirstremarks from ap#studentfeedbackheader ah where ah.apacademicyear='"+hm.get("academicYear")+"' and apstudentid='"+hm.get("studentID")+"'");
         // if(dbConnection.isClosed()){
            //         dbConnection=DBUtility.getConnection(dbConnection);
            //      }
         // pStmt = dbConnection.prepareStatement(sqry.toString());
          rs = db.getRowset(sqry.toString());
          while (rs.next()) {
                       SelectData = new HashMap();
                       SelectData.put("transactionID",rs.getString(1));
                        SelectData.put("feedbackid",rs.getString(2));
                        SelectData.put("programcode",getProgramName(rs.getString(3)));
                        SelectData.put("academicyear",rs.getString(4));
                        SelectData.put("remarks",rs.getString(5));

                        outerData.put(k,SelectData);
                        k++;

                }

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

             return outerData;
    }

    }

       private Map getSelectDataForUpgrade(Map hm) {
         StringBuffer sqry = new StringBuffer();
         StringBuffer equery = new StringBuffer();
         TreeMap tm =new TreeMap();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
         int k = 1;
            try {
                sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                        + "nvl(TRANSACTIONID,'')TRANSACTIONID,nvl(APFEEDBACKID,'')APFEEDBACKID,"
                        + "nvl(APACADEMICYEAR,'')APACADEMICYEAR,nvl(PROGRAMCODE,'')PROGRAMCODE,"
                        + "nvl(APFEEDBACKFIRSTREMARKS,'')APFEEDBACKFIRSTREMARKS,NVL(APSTUDENTID,'')APSTUDENTID "
                        +" from AP#STUDENTFEEDBACKHEADER");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
               // if(dbConnection.isClosed()){
               //      dbConnection=DBUtility.getConnection(dbConnection);
                //  }
               // pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = db.getRowset(sqry.toString());
                while (rs.next()) {

                        SelectData.put("transactiondate",rs.getString(1));
                        SelectData.put("transactionID",rs.getString(2));
                        SelectData.put("feedbackID",rs.getString(3));
                        SelectData.put("academicYear",rs.getString(4));
                        SelectData.put("feedbackRemarks",rs.getString(6));
                        SelectData.put("studentName",getStudentName(rs.getString(7)));
                        SelectData.put("programcode",getProgramName(rs.getString(5)));



                }
                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE, NVL (APFEEDBACKID, '') APFEEDBACKID,"
                        + "nvl(APFEEDBACKITEMID,'')APFEEDBACKITEMID,nvl(APFEEDBACKITEMREMARKS,'')APFEEDBACKITEMREMARKS,"
                        + "nvl(APFEEDBACKRATINGID,'')APFEEDBACKRATINGID,nvl(APFEEDBACKRATING,'')APFEEDBACKRATING,"
                        + "nvl(APFEEDBACKUSERREMARKS,'')APFEEDBACKUSERREMARKS FROM AP#STUDENTFEEDBACKDETAIL ");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                //if(dbConnection.isClosed()){
                  //   dbConnection=DBUtility.getConnection(dbConnection);
                 // }
               // pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = db.getRowset(sqry.toString());
                while (rs.next()) {
                        SelectData1 = new HashMap();
                        SelectData1.put("transactionID",rs.getString(1));
                        SelectData1.put("transactionDate",rs.getString(2));
                        SelectData1.put("feedbackID",rs.getString(3));
                        SelectData1.put("questionID",rs.getString(4));
                        SelectData1.put("questionRemarks",rs.getString(5));
                        SelectData1.put("ratingID",rs.getString(6));
                        SelectData1.put("rating",rs.getString(7));
                        SelectData1.put("userRemarks",rs.getString(8));
                        tm.put(k, SelectData1);
                        k++;


                }
                SelectData.put("childMap", tm);
             } catch (Exception e) {
                 e.printStackTrace();
             }
         finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            return SelectData;
    }

    }

       public String getProgramName(String programCode)
       {
       StringBuilder sb=new StringBuilder();
       String progName="";
       try{
       sb.append("select programname from programmaster where programcode='"+programCode+"'");
      // if(dbConnection.isClosed()){
         //            dbConnection=DBUtility.getConnection(dbConnection);
        //          }
      // pStmt = dbConnection.prepareStatement(sb.toString());
       rs1 = db.getRowset(sb.toString());
       if(rs1.next())
       {
       progName=rs1.getString(1);
       }
       }catch(Exception e)
       {
           e.printStackTrace();
       }
       finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            return progName;
    }

       }

       public String getProgramCode(String programname)
       {
       StringBuilder sb=new StringBuilder();
       String progName="";
       try{
       sb.append("select programcode from programmaster where programname='"+programname+"'");
       //if(dbConnection.isClosed()){
                   //  dbConnection=DBUtility.getConnection(dbConnection);
                 // }
      // pStmt = dbConnection.prepareStatement(sb.toString());
       rs1 = db.getRowset(sb.toString());
       if(rs1.next())
       {
       progName=rs1.getString(1);
       }
       }catch(Exception e)
       {
           e.printStackTrace();
       }
       finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

             return progName;
    }

       }

       public String getStudentName(String studentID)
       {
       StringBuilder sb=new StringBuilder();
       String studentName="";
       try{
       sb.append("select studentname from studentmaster where studentid='"+studentID+"'");
       //if(dbConnection.isClosed()){
                  //   dbConnection=DBUtility.getConnection(dbConnection);
                //  }
      // pStmt = dbConnection.prepareStatement(sb.toString());
       rs1 = db.getRowset(sb.toString());
       if(rs1.next())
       {
       studentName=rs1.getString(1);
       }
       }catch(Exception e)
       {
           e.printStackTrace();
       }
       finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            return studentName;
    }

       }

       public String getValidateData(Map hm)
       {
       String tempVal="00";
       String programCode=getProgramCode(hm.get("programName").toString());
       StringBuilder sb=new StringBuilder();
       try{
       sb.append("select transactionid from ap#studentfeedbackheader where apstudentid='"+hm.get("studentID")+"' and apacademicyear='"+hm.get("academicYear")+"' and programcode='"+programCode+"'");
      // if(dbConnection.isClosed()){
               //      dbConnection=DBUtility.getConnection(dbConnection);
               //   }
      // pStmt = dbConnection.prepareStatement(sb.toString());
       rs = db.getRowset(sb.toString());
       if(rs.next())
       {
        tempVal="11";
       }
       }catch(Exception e)
       {
       e.printStackTrace();
       }
       finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

             return tempVal;
    }

       }

       public String getExpiryDate(Map hm)
    {
        String tempVariable="false";
        StringBuilder sb=new StringBuilder();
        try
        {
        sb.append("select apfeedbackid from AP#FEEDBACKTYPEMASTER where to_date('"+hm.get("todayDate")+"','dd-mm-yyyy')  between apfeedbackfromdate and apfeedbacktodate and apfeedbacktype='SHSTUDENT'");
        //if(dbConnection.isClosed()){
                   //  dbConnection=DBUtility.getConnection(dbConnection);
                //  }
       // pStmt = dbConnection.prepareStatement(sb.toString());
        rs = db.getRowset(sb.toString());
        if(rs.next())
        {
          tempVariable="true";
        }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }if(pStmt!=null){
                try {
                    pStmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            return tempVariable;
    }


    }

}