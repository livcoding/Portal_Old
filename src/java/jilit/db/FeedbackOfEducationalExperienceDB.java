/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
//import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import tietwebkiosk.IQACconnection;

/**
 *
 * @author nipun.gupta
 */
public class FeedbackOfEducationalExperienceDB {
   // private Connection dbConnection;
    private PreparedStatement pStmt=null;
    private CallableStatement callableStatement = null;
    private ResultSet rs=null;
    private ResultSet rs1=null;
    IQACconnection db=new IQACconnection();
    public FeedbackOfEducationalExperienceDB() {
        //dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectProgramName,gradeObtainedCombo,saveupdate, selectData, selectGridData, SelectforUpdate,feedbackID,lowerGrid,selectDataForUpgrade,checkExpiryDate,validateData
    }


     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (FeedbackOfEducationalExperienceDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectProgramName:
                    responseString = mapper.writeValueAsString(getSelectProgramName(hm));
                    break;
                case gradeObtainedCombo:
                    responseString = mapper.writeValueAsString(getGradeObtainedCombo(hm));
                    break;
                case saveupdate:
                    responseString =SaveUpdateData(hm);
                    break;
                case selectData:
                  //  responseString = mapper.writeValueAsString(getSelectData(hm));
                    break;
                case selectGridData:
                  responseString = mapper.writeValueAsString(selectGridData(hm));
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
      sb.append("select APFEEDBACKID,APFEEDBACKNAME from AP#FEEDBACKTYPEMASTER where APFEEDBACKTYPE='ABSTUDENT'");
      // if(dbConnection.isClosed()){
             //      dbConnection=DBUtility.getConnection(dbConnection);
              //     }
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

     public Map getSelectProgramName(Map hm)
     {
         String tempValue="";
         String qry="";
         Map selectData=new HashMap();
         try{
         qry="select PROGRAMNAME from programmaster where programcode='"+hm.get("courseCode")+"'";
         // if(dbConnection.isClosed()){
            //       dbConnection=DBUtility.getConnection(dbConnection);
             //      }
         //pStmt = dbConnection.prepareStatement(qry);
         rs = db.getRowset(qry.toString());
         if(rs.next())
         {
             selectData.put("courseName", rs.getString(1));
         }
         selectData.put("rownum", hm.get("rowno"));
         selectData.put("courseCode", hm.get("courseCode"));
         selectData.put("preselect", hm.get("preselect").toString().replaceAll("2B", "+"));
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

            return selectData;
    }

     }

     private Map selectGridData(Map hm) {
         StringBuffer sqry = new StringBuffer();
         StringBuffer eqry = new StringBuffer();
          List l = new ArrayList();
          l.add("abc");
         Map tm = new LinkedHashMap();
         Map SelectData = new LinkedHashMap();
         int k = 1;
         int p = 1;
         try {
             sqry.append("Select a.HEADID,a.QUESTIONID,a.QUESTIONBODY,a.ratingid,b.parentheadid\n"
                     + ", decode(b.parentheadid,null,'Y','N') flag\n"
                     + "from ap#facultyquestionmaster a,ap#facultyquestionhead b\n"
                     + "where\n"
                     + "a.FEEDBACKID='"+hm.get("feedbackid")+"'\n"
                     + "and a.feedbackid=b.feedbackid\n"
                     + "and a.headid=b.headid\n"
                     + "and a.HEADID in (select parentHEADID from ap#facultyquestionhead)  \n"
                     + "Union all\n"
                     + "Select a.HEADID,a.QUESTIONID,a.QUESTIONBODY,a.ratingid,b.parentheadid\n"
                     + ", decode(b.parentheadid,null,'N','N') flag\n"
                     + "from ap#facultyquestionmaster a,ap#facultyquestionhead b\n"
                     + "where\n"
                     + "a.FEEDBACKID='"+hm.get("feedbackid")+"'\n"
                     + "and a.feedbackid=b.feedbackid\n"
                     + "and a.headid=b.headid\n"
                     + "and a.HEADID  in (\n"
                     + "select HEADID from ap#facultyquestionhead\n"
                     + "minus\n"
                     + "select parentHEADID from ap#facultyquestionhead)  order by 2");
             // if(dbConnection.isClosed()){
              //     dbConnection=DBUtility.getConnection(dbConnection);
              //     }
           //  pStmt = dbConnection.prepareStatement(sqry.toString());
             rs = db.getRowset(sqry.toString());
             int u = 1;
             while (rs.next()) {
                 SelectData = new HashMap();
                SelectData.put("slno", k);
                SelectData.put("headid", rs.getString(1));
                l.add(rs.getString(1));
                eqry = new StringBuffer();
                eqry.append("SELECT count(AM.HEADID) ");
                eqry.append("FROM ap#facultyquestionmaster AM, ap#facultyquestionhead AH ");
                eqry.append("WHERE     AM.COMPANYCODE = AH.COMPANYCODE ");
                eqry.append("AND AM.INSTITUTECODE = AH.INSTITUTECODE ");
                eqry.append("AND AM.FEEDBACKID = AH.FEEDBACKID ");
                eqry.append("AND AM.COMPONENTTYPE = AH.COMPONENTTYPE ");
                eqry.append("AND AM.HEADID = AH.HEADID ");
                eqry.append("AND AM.EXAMCODE = AH.EXAMCODE ");
                eqry.append("AND AM.COMPONENTTYPE = 'A' ");
                eqry.append("and AM.HEADID='").append(rs.getString(1)).append("' ");
                eqry.append("and AH.PARENTHEADID='").append(l.get(l.size() - 2)).append("' order by AM.QUESTIONID");
                 //if(dbConnection.isClosed()){
                 //  dbConnection=DBUtility.getConnection(dbConnection);
                  // }
               // pStmt = dbConnection.prepareStatement(eqry.toString());
                rs1 = db.getRowset(eqry.toString());
                if(rs1.next()){
                if (!rs1.getString(1).equals("0")) {
                        SelectData.put("slno", (k-1) + "." + u);
                        SelectData.put("color", "blue");
                        l.remove(l.size() - 1);
                        u++;
                    }else{
                        k++;
                         u = 1;
                    }}
                else{
                    k++;
                }
                    SelectData.put("questionid", rs.getString(2));
                    SelectData.put("questionbody", rs.getString(3));
                    SelectData.put("ratingid", rs.getString(4));
                    SelectData.put("parentHeadID", rs.getString(5));
                    SelectData.put("flag", rs.getString(6));
                    tm.put(p, SelectData);
                p++;

             }
             tm.put("rating", getRatingCombo());
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
     sb.append("select  rd.RATINGID,wm_concat(distinct '\"'||rd.rating||'@@'||rd.ratingdesc||'\"'),rm.subjective from ap#ratingdetail rd,ap#ratingmaster rm where rd.companycode=rm.companycode and rd.institutecode=rm.institutecode and rd.examcode=rm.examcode and rd.feedbackid=rm.feedbackid and rd.ratingid=rm.ratingid group by  rd.RATINGID,rm.subjective ");
      //if(dbConnection.isClosed()){
        //           dbConnection=DBUtility.getConnection(dbConnection);
           //        }
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

     public Map getGradeObtainedCombo(Map hm) {
        Map selectData=new HashMap();
        ObjectMapper mapper = new ObjectMapper();
        StringBuilder sb = new StringBuilder();
        StringBuilder op = new StringBuilder();
        try {
           sb.append("select distinct nvl(gm.GRADE,'')as GRADE ,nvl(gm.GRADE,'') as GRADE1 from grademaster gm  where nvl(gm.deactive,'N')='N' and gm.PROGRAMCODE='"+hm.get("courseCode")+"' order by grade");
           op.append("<option value='' selected>Select Course Code</option>");

            ///////////////////////////////////////////////////////////////////////////////
           // if(dbConnection.isClosed()){
              //     dbConnection=DBUtility.getConnection(dbConnection);
                //   }
          // pStmt = dbConnection.prepareStatement(sb.toString());
            rs = db.getRowset(sb.toString());


            while (rs.next()) {
                   if(hm.containsKey("preselect") && hm.get("preselect").toString().replaceAll("2B", "+").equals(rs.getString(1))){
                   op.append("<option  selected value='" + rs.getString(1) + "'  >" + rs.getString(2) + "</option>");
                   }else
                   {
                   op.append("<option  value='" + rs.getString(1) + "'  >" + rs.getString(2) + "</option>");
                   }



            }
            selectData.put("combo", op.toString());
            selectData.put("rownum", hm.get("rownum"));
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

            return selectData;
    }

    }

     private String SaveUpdateData(Map hm)
   {

        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        ArrayList list = (ArrayList) hm.get("para");
        ArrayList list1 = (ArrayList) list.get(0);
        ArrayList list2 = (ArrayList) list.get(1);
        Set st=new HashSet();
        String tempValue="";
         String id = "";
        try {
           if (hm.get("transactionID").equals("0")) {
               try {
                   // if(dbConnection.isClosed()){
                  // dbConnection=DBUtility.getConnection(dbConnection);
                   //}
                   //callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                  // callableStatement.setString(1, "0001");
                  // callableStatement.setString(2, "FBMId");
                  // callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                  // callableStatement.execute();
                  // id = callableStatement.getString(3);
                   id=db.generateID();
               } catch (Exception e) {
                   e.printStackTrace();
               } finally {
                    if (callableStatement != null) {
                       callableStatement.close();
                   }
               }


                eqry.append("insert into  AP#STUDENTABROADFBHEADER ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APSTUDENTID,DEPARTMENTCODE,NAMEOFEXCHANGEPROGRAM,UNIVERSITYVISITEDABROAD,");
                eqry.append("DEPARTMENTCODEABROAD,DURATIONFROMDATE,DURATIONTODATE,PURPOSEOFVISIT,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','")
                .append(hm.get("instituteid")).append("','")
                .append(id)
                .append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'")
                .append(hm.get("apFeedbackID")).append("',");
                eqry.append("'").append(hm.get("apStudentID"))
                .append("','").append(hm.get("departmentCode"))
                .append("','").append(hm.get("nameOfExchangeProgram"))
                .append("','").append(hm.get("universityVisitedAbroad"))
                .append("','").append(hm.get("departmentCodeAbroad"))
                .append("',to_date('").append(hm.get("durationFromDate")).append("','dd-mm-yyyy'),");
                 eqry.append("to_date('"+hm.get("durationToDate")).append("','dd-mm-yyyy'),'");
                eqry.append(hm.get("purposeOfVisit")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                 //if(dbConnection.isClosed()){
                  // dbConnection=DBUtility.getConnection(dbConnection);
                  // }
              //  pStmt = dbConnection.prepareStatement(eqry.toString());
                //pStmt.executeUpdate();
                db.insertRow(eqry.toString());

            } else {
                sqry.append("Update AP#STUDENTABROADFBHEADER set COMPANYID='").append(hm.get("companyid"))
                .append("',INSTITUTEID='").append(hm.get("instituteid"))
                .append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",APFEEDBACKID='").append(hm.get("apFeedbackID"))
                .append("',APSTUDENTID='").append(hm.get("apStudentID"))
                .append("',DEPARTMENTCODE='").append(hm.get("departmentCode")).append("',");
                sqry.append("NAMEOFEXCHANGEPROGRAM='").append(hm.get("nameOfExchangeProgram"))
                .append("',UNIVERSITYVISITEDABROAD='").append(hm.get("universityVisitedAbroad"))
                .append("',DEPARTMENTCODEABROAD='").append(hm.get("departmentCodeAbroad"))
                .append("',DURATIONFROMDATE=to_date('").append(hm.get("durationFromDate")).append("','dd-mm-yyyy')");
                sqry.append(",DURATIONTODATE=to_date('").append(hm.get("durationToDate")).append("','dd-mm-yyyy')");
                sqry.append(",PURPOSEOFVISIT='").append(hm.get("purposeOfVisit"));
                sqry.append("',ENTRYBY='").append(hm.get("entryBy"));
                sqry.append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')");
                sqry.append(" where TRANSACTIONID='").append(hm.get("transactionID")).append("'");
               //  if(dbConnection.isClosed()){
                //   dbConnection=DBUtility.getConnection(dbConnection);
                //   }
               // pStmt = dbConnection.prepareStatement(sqry.toString());
                //pStmt.executeUpdate();
                db.insertRow(sqry.toString());
                id=hm.get("transactionID").toString();

           }



                String Querry = " delete from AP#STUDENTABROADFBDETAIL where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                 //if(dbConnection.isClosed()){
                 //  dbConnection=DBUtility.getConnection(dbConnection);
                 //  }
                //pStmt = dbConnection.prepareStatement(Querry);
                //pStmt.executeUpdate();
                db.update(Querry.toString());

                if(hm.get("transactionID").equals("0")){

                for(int x=0;x<list2.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list2.get(x);
                eqry.append("insert into  AP#STUDENTABROADFBDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
               //  if(dbConnection.isClosed()){
                 //  dbConnection=DBUtility.getConnection(dbConnection);
                   //}
                //pStmt = dbConnection.prepareStatement(eqry.toString());
               // pStmt.executeUpdate();
                db.insertRow(eqry.toString());
                }

            }else
                {
                    for(int x=0;x<list2.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list2.get(x);
                eqry.append("insert into  AP#STUDENTABROADFBDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                // if(dbConnection.isClosed()){
               //    dbConnection=DBUtility.getConnection(dbConnection);
                //   }
               // pStmt = dbConnection.prepareStatement(eqry.toString());
               // pStmt.executeUpdate();
                db.insertRow(eqry.toString());
                }
                }



                String Querry1 = " delete from AP#STUDENTABROADCOURSECR where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                // if(dbConnection.isClosed()){
                 //  dbConnection=DBUtility.getConnection(dbConnection);
                //   }
               // pStmt = dbConnection.prepareStatement(Querry1);
               // pStmt.executeUpdate();
                db.update(Querry1.toString());

                if(hm.get("transactionID").equals("0")){

                for(int x=0;x<list1.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list1.get(x);
                eqry.append("insert into  AP#STUDENTABROADCOURSECR ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,PROGRAMCODE,COURSECREDIT,GRADEOBTAINED,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("apFeedbackID")).append("',");
                eqry.append("'").append(mp.get("programCode")).append("','").append(mp.get("courseCredit")).append("',");
                eqry.append("'").append(mp.get("gradeObtained").toString().replaceAll("2B", "+")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                // if(dbConnection.isClosed()){
                 //  dbConnection=DBUtility.getConnection(dbConnection);
                  // }
               // pStmt = dbConnection.prepareStatement(eqry.toString());
               // pStmt.executeUpdate();
                db.insertRow(eqry.toString());
                }

            }else
                {
                    for(int x=0;x<list1.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list1.get(x);
                eqry.append("insert into  AP#STUDENTABROADCOURSECR ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,PROGRAMCODE,COURSECREDIT,GRADEOBTAINED,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("apFeedbackID")).append("',");
                eqry.append("'").append(mp.get("programCode")).append("','").append(mp.get("courseCredit")).append("',");
                eqry.append("'").append(mp.get("gradeObtained").toString().replaceAll("2B", "+")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                // if(dbConnection.isClosed()){
                 //  dbConnection=DBUtility.getConnection(dbConnection);
                 //  }
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
        Map outerData = new HashMap();
        int k = 1;
        try {
            sqry.append("select ah.transactionid,to_char(ah.transactiondate,'dd-mm-yyyy')transactionDate,sm.studentname,dm.department,ah.nameofexchangeprogram,ah.universityvisitedabroad,to_char(ah.durationfromdate,'dd-mm-yyyy')durationFromDate,\n"
                    + "to_char(ah.durationtodate,'dd-mm-yyyy')durationToDate from AP#STUDENTABROADFBHEADER ah,STUDENTMASTER sm,departmentmaster dm where AH.DEPARTMENTCODE=DM.DEPARTMENTCODE\n"
                    + "and AH.APSTUDENTID=SM.STUDENTID and apstudentid='"+hm.get("studentID")+"'");
            // if(dbConnection.isClosed()){
               //    dbConnection=DBUtility.getConnection(dbConnection);
              //     }
           // pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = db.getRowset(sqry.toString());
            while (rs.next()) {
                SelectData = new HashMap();
                SelectData.put("transactionID", rs.getString(1));
                SelectData.put("transactionDate", rs.getString(2));
                SelectData.put("studentName", rs.getString(3));
                SelectData.put("department", rs.getString(4));
                SelectData.put("nameOfExchangeProgram", rs.getString(5));
                SelectData.put("universityVisitedAbroad", rs.getString(6));
                SelectData.put("durationFromDate", rs.getString(7));
                SelectData.put("durationToDate", rs.getString(8));
                outerData.put(k, SelectData);
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
         TreeMap tm1 =new TreeMap();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
         Map SelectData2 = new HashMap();
         Map mainMap = new HashMap();
         int k = 1;
         int j=1;
            try {
                sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,nvl(APFEEDBACKID,'')APFEEDBACKID,"
                        + "nvl(TRANSACTIONID,'')TRANSACTIONID,nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,"
                        + "nvl(NAMEOFEXCHANGEPROGRAM,'')NAMEOFEXCHANGEPROGRAM,nvl(UNIVERSITYVISITEDABROAD,'')UNIVERSITYVISITEDABROAD,"
                        + "nvl(DEPARTMENTCODEABROAD,'')DEPARTMENTCODEABROAD,to_char(DURATIONFROMDATE,'dd-mm-yyyy')DURATIONFROMDATE, "
                        +" to_char(DURATIONTODATE,'dd-mm-yyyy')DURATIONTODATE,nvl(PURPOSEOFVISIT,'')PURPOSEOFVISIT from AP#STUDENTABROADFBHEADER");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                // if(dbConnection.isClosed()){
                //   dbConnection=DBUtility.getConnection(dbConnection);
                //   }
               // pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = db.getRowset(sqry.toString());
                while (rs.next()) {

                        SelectData.put("transactiondate",rs.getString(1));
                        SelectData.put("apFeedbackID",rs.getString(2));
                        SelectData.put("transactionID",rs.getString(3));
                        SelectData.put("departmentCode",rs.getString(4));
                        SelectData.put("nameOfExchangeProgram",rs.getString(5));
                        SelectData.put("universityVisitedAbroad",rs.getString(6));
                        SelectData.put("departmentCodeAbroad",rs.getString(7));
                        SelectData.put("durationFromDate",rs.getString(8));
                        SelectData.put("durationToDate",rs.getString(9));
                        SelectData.put("purposeOfVisit",rs.getString(10));



                }
                mainMap.put("headerMap", SelectData);
                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE, NVL (APFEEDBACKID, '') APFEEDBACKID,"
                        + "nvl(APFEEDBACKITEMID,'')APFEEDBACKITEMID,nvl(APFEEDBACKITEMREMARKS,'')APFEEDBACKITEMREMARKS,"
                        + "nvl(APFEEDBACKRATINGID,'')APFEEDBACKRATINGID,nvl(APFEEDBACKRATING,'')APFEEDBACKRATING,"
                        + "nvl(APFEEDBACKUSERREMARKS,'')APFEEDBACKUSERREMARKS FROM AP#STUDENTABROADFBDETAIL ");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                 //if(dbConnection.isClosed()){
                  // dbConnection=DBUtility.getConnection(dbConnection);
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
                mainMap.put("questionMap", tm);


                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE, NVL (PROGRAMCODE, '') PROGRAMCODE,"
                        + "nvl(COURSECREDIT,'')COURSECREDIT,nvl(GRADEOBTAINED,'')GRADEOBTAINED"
                        + " FROM AP#STUDENTABROADCOURSECR ");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                // if(dbConnection.isClosed()){
                  // dbConnection=DBUtility.getConnection(dbConnection);
                  // }
                //pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = db.getRowset(sqry.toString());
                while (rs.next()) {
                        SelectData2 = new HashMap();
                        SelectData2.put("transactionID",rs.getString(1));
                        SelectData2.put("transactionDate",rs.getString(2));
                        SelectData2.put("programCode",rs.getString(3));
                        SelectData2.put("courseCredit",rs.getString(4));
                        SelectData2.put("gradeObtained",rs.getString(5));
                        tm1.put(j, SelectData2);
                        j++;


                }
                mainMap.put("courseCreditMap", tm1);
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

            return mainMap;
    }

    }

       public String getExpiryDate(Map hm)
    {
        String tempVariable="false";
        StringBuilder sb=new StringBuilder();
        try
        {
        sb.append("select apfeedbackid from AP#FEEDBACKTYPEMASTER where to_date('"+hm.get("todayDate")+"','dd-mm-yyyy')  between apfeedbackfromdate and apfeedbacktodate and apfeedbacktype='ABSTUDENT'");
        // if(dbConnection.isClosed()){
          //         dbConnection=DBUtility.getConnection(dbConnection);
              //     }
        //pStmt = dbConnection.prepareStatement(sb.toString());
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

       public String getValidateData(Map hm)
       {
       String tempVal="00";
       StringBuilder sb=new StringBuilder();
       try{
       sb.append("select transactionid from AP#STUDENTABROADFBHEADER where apstudentid='"+hm.get("studentID")+"' and apfeedbackid='"+hm.get("feedbackid")+"'");
       // if(dbConnection.isClosed()){
         //          dbConnection=DBUtility.getConnection(dbConnection);
           //        }
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
}
