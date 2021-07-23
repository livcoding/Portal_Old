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
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import jdbc.DBUtility;
import tietwebkiosk.*;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class NonTeachingFeedbackDB {
   private Connection dbConnection;
    private PreparedStatement pStmt=null;
    private CallableStatement callableStatement = null;
    private ResultSet rs=null;
    private ResultSet rs1=null;
    IQACconnection db = new IQACconnection();

    public NonTeachingFeedbackDB() {
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

            switch (NonTeachingFeedbackDB.scase.valueOf((String) hm.get("handller").toString())) {
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
        }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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


     private Map selectGridData(Map hm) {
        StringBuffer sqry = new StringBuffer();
       Map tm = new HashMap();
        Map SelectData = new HashMap();
        int k = 1;
        try {
          sqry.append("SELECT NVL(AM.HEADID,'')HEADID,NVL(QUESTIONID,' ')QUESTIONID,NVL(QUESTIONBODY,' ')QUESTIONBODY,NVL(RATINGID,' ') RATING,NVL(AH.PARENTHEADID,'')PARENTHEADID,nvl( (select decode(x.headid,'','N','Y') from AP#SHQUESTIONMASTER x where X.HEADID in  (select parentheadid from AP#SHQUESTIONHEAD) and x.headid = am.headid and rownum =1),'N') flag,NVL (AM.MANDATORYQUESTION, 'N')MANDATORYQUESTION FROM AP#SHQUESTIONMASTER AM,AP#SHQUESTIONHEAD AH WHERE AM.COMPANYCODE=AH.COMPANYCODE AND AM.INSTITUTECODE=AH.INSTITUTECODE AND AM.FEEDBACKID=AH.FEEDBACKID AND AM.COMPONENTTYPE=AH.COMPONENTTYPE AND AM.HEADID=AH.HEADID AND AM.EXAMCODE=AH.EXAMCODE AND AM.COMPONENTTYPE='N' AND AM.FEEDBACKID='"+hm.get("feedbackid")+"'  AND NVL(AM.DEACTIVE,'N')<>'Y' ORDER BY am.SEQID ");

       //   pStmt = dbConnection.prepareStatement(sqry.toString());
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
            } if(rs1!=null){
                try {
                    rs1.close();
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
     }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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

     public String checkQuestionType(String ratingid){
         String questionType="";
         StringBuilder sb=new StringBuilder();
         try{
         sb.append("select subjective from ap#shratingmaster where ratingid='"+ratingid+"'");
          rs = db.getRowset(sb.toString());
         if(rs.next())
         {
         questionType=rs.getString(1);
         }
         }catch(Exception e){
         e.printStackTrace();
         }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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
     return questionType;

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
                   id = db.generateID();
               } catch (Exception e) {
                   e.printStackTrace();
               }

                eqry.append("insert into  AP#NONTECHSHFEEDBACKHEADER ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APACADEMICYEAR,DEPARTMENTCODE,APFEEDBACKREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(hm.get("feedbackName")).append("',");
                eqry.append("'").append(hm.get("academicYear").toString().trim()).append("','").append(getDepartmentCode(hm.get("departmentName").toString().replaceAll("@@@", "&"))).append("','").append(hm.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");

               db.update(eqry.toString());
                //pStmt.executeUpdate();

            } else {
                sqry.append("Update AP#NONTECHSHFEEDBACKHEADER set COMPANYID='").append(hm.get("companyid")).append("',INSTITUTEID='").append(hm.get("instituteid")).append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",APFEEDBACKID='").append(hm.get("feedbackName")).append("',APACADEMICYEAR='").append(hm.get("academicYear").toString().trim()).append("',");
                sqry.append("DEPARTMENTCODE='").append(getDepartmentCode(hm.get("departmentName").toString().replaceAll("@@@", "&"))).append("',APFEEDBACKREMARKS='").append(hm.get("remarks")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where TRANSACTIONID='").append(hm.get("transactionID")).append("'");

                db.update(sqry.toString());
              //  pStmt.executeUpdate();
                id=hm.get("transactionID").toString();

           }



                String Querry = " delete from AP#NONTECHSHFEEDBACKDETAIL where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                db.update(Querry);
                if(hm.get("transactionID").equals("0")){
                for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#NONTECHSHFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                db.insertRow(eqry.toString());
                }

            }else
                {
                    for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#NONTECHSHFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                db.insertRow(eqry.toString());
                    }
                }



        }catch(Exception e)
         {

             e.printStackTrace();
             return "Record Not Saved";
         }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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


      private Map getSelectData(Map hm) {
         StringBuffer sqry = new StringBuffer();
         StringBuffer equery = new StringBuffer();
         TreeMap tm =new TreeMap();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
         int k = 1;
            try {
                sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                        + "nvl(TRANSACTIONID,'')TRANSACTIONID,nvl(APFEEDBACKID,'')APFEEDBACKID,"
                        + "nvl(APACADEMICYEAR,'')APACADEMICYEAR,"
                        + "nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(APFEEDBACKREMARKS,'')APFEEDBACKREMARKS "
                        +" from AP#NONTECHSHFEEDBACKHEADER");
                sqry.append(" where ").append( "APFEEDBACKID='").append(hm.get("feedbackid")).append("'");
                rs=db.getRowset(sqry.toString());
                while (rs.next()) {

                        SelectData.put("transactiondate",rs.getString(1));
                        SelectData.put("transactionID",rs.getString(2));
                        SelectData.put("feedbackID",rs.getString(3));
                        SelectData.put("academicYear",rs.getString(4).trim());
                        SelectData.put("department",rs.getString(5));
                        SelectData.put("feedbackRemarks",rs.getString(6));



                }
                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE, NVL (APFEEDBACKID, '') APFEEDBACKID,"
                        + "nvl(APFEEDBACKITEMID,'')APFEEDBACKITEMID,nvl(APFEEDBACKITEMREMARKS,'')APFEEDBACKITEMREMARKS,"
                        + "nvl(APFEEDBACKRATINGID,'')APFEEDBACKRATINGID,nvl(APFEEDBACKRATING,'')APFEEDBACKRATING,"
                        + "nvl(APFEEDBACKUSERREMARKS,'')APFEEDBACKUSERREMARKS FROM AP#NONTECHSHFEEDBACKDETAIL ");
                sqry.append(" where ").append( "APFEEDBACKID='").append(hm.get("feedbackid")).append("'");
                rs=db.getRowset(sqry.toString());
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
             }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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

      public String getParentQuestion(Map hm)
      {
      String tempVal="false";
      String tempVal1="";
      StringBuilder sb=new StringBuilder();
      try
      {
      sb.append("select parentheadid from ap#shquestionhead where headid='"+hm.get("headid")+"'");
      rs=db.getRowset(sb.toString());
       if(rs.next())
       {
        tempVal1=rs.getString(1);
        if(!tempVal1.equals("")){
        tempVal="true";
        }
       }
      }catch(Exception e)
      {
      e.printStackTrace();
      }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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

      public String getFeedBackID(Map hm)
      {
      String feedbackID="";
      String feedbackDesc="";
      String concat="";
      StringBuilder sb =new StringBuilder();
      try{
      sb.append("select APFEEDBACKID,APFEEDBACKNAME from AP#FEEDBACKTYPEMASTER where APFEEDBACKTYPE='SHNON-TEACH'");
      rs = db.getRowset(sb.toString());
      while(rs.next()){
         feedbackID=rs.getString(1);
         feedbackDesc=rs.getString(2);
         }
      concat=feedbackID+"/"+feedbackDesc;
      }catch(Exception e)
      {
      e.printStackTrace();
      }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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

      private Map getLowerGridData(Map hm) {
        StringBuffer sqry = new StringBuffer();
        Map SelectData = new HashMap();
        Map outerData=new HashMap();
        int k=1;
        try {
          sqry.append("select ah.transactionid,ah.apfeedbackid,dm.department,ah.apacademicyear,ah.apfeedbackremarks from AP#NONTECHSHFEEDBACKHEADER ah,departmentmaster dm where  ah.departmentcode=dm.departmentcode and ah.apacademicyear='"+hm.get("academicYear").toString().trim()+"' and ah.entryby='"+hm.get("entryBy")+"'");
          rs=db.getRowset(sqry.toString());
          while (rs.next()) {
                       SelectData = new HashMap();
                       SelectData.put("transactionID", rs.getString(1));
                       SelectData.put("feedbackid", rs.getString(2));
                       SelectData.put("department", rs.getString(3));
                       SelectData.put("academicyear", rs.getString(4).trim());
                       SelectData.put("remarks", rs.getString(5));
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
            } if(rs1!=null){
                try {
                    rs1.close();
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
                        + "nvl(APACADEMICYEAR,'')APACADEMICYEAR,"
                        + "nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(APFEEDBACKREMARKS,'')APFEEDBACKREMARKS "
                        +" from AP#NONTECHSHFEEDBACKHEADER");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                rs=db.getRowset(sqry.toString());
                while (rs.next()) {

                        SelectData.put("transactiondate",rs.getString(1));
                        SelectData.put("transactionID",rs.getString(2));
                        SelectData.put("feedbackID",rs.getString(3));
                        SelectData.put("academicYear",rs.getString(4).trim());
                        SelectData.put("department",getDepartmentName(rs.getString(5)));
                        SelectData.put("feedbackRemarks",rs.getString(6));




                }
                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE, NVL (APFEEDBACKID, '') APFEEDBACKID,"
                        + "nvl(APFEEDBACKITEMID,'')APFEEDBACKITEMID,nvl(APFEEDBACKITEMREMARKS,'')APFEEDBACKITEMREMARKS,"
                        + "nvl(APFEEDBACKRATINGID,'')APFEEDBACKRATINGID,nvl(APFEEDBACKRATING,'')APFEEDBACKRATING,"
                        + "nvl(APFEEDBACKUSERREMARKS,'')APFEEDBACKUSERREMARKS FROM AP#NONTECHSHFEEDBACKDETAIL ");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                rs=db.getRowset(sqry.toString());
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
             }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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

      public String getProgramName(String programcode)
     {
     String programCode="";
     try{
     String qry="select programname from programmaster where programcode='"+programcode+"'";
     rs=db.getRowset(qry);
     if(rs.next())
     {
         programCode=rs.getString(1);
     }
     }catch(Exception e)
     {
         e.printStackTrace();;
     }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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
     return programCode;

    }

     }


      public String getDepartmentCode(String department)
     {
     String departmentCode="";
     try{
     String qry="select departmentcode from departmentmaster where department='"+department.replace("'", "''")+"'";
     rs=db.getRowset(qry);
     if(rs.next())
     {
         departmentCode=rs.getString(1);
     }
     }catch(Exception e)
     {
         e.printStackTrace();;
     }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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
     return departmentCode;

    }

     }
    public String getDepartmentName(String department) {
        String departmentCode = "";
        try {
            String qry = "select department from departmentmaster where departmentcode='" + department + "'";
            rs1=db.getRowset(qry);
            System.out.println(qry);
            if (rs1.next()) {
                departmentCode = rs1.getString(1);
                System.out.println(departmentCode);
            }
        } catch (Exception e) {
            e.printStackTrace();;
        }finally{
          
            if(rs1!=null){
                try {
                    rs1.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        return departmentCode;

    }

    }

    public String getExpiryDate(Map hm)
    {
        String tempVariable="false";
        StringBuilder sb=new StringBuilder();
        try
        {
        sb.append("select apfeedbackid from AP#FEEDBACKTYPEMASTER where to_date('"+hm.get("todayDate")+"','dd-mm-yyyy')  between apfeedbackfromdate and apfeedbacktodate and apfeedbacktype='SHNON-TEACH'");
        rs=db.getRowset(sb.toString());

        if(rs.next())
        {
          tempVariable="true";
        }
        }catch(Exception e)
        {
            e.printStackTrace();
        }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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
       sb.append("select transactionid from AP#NONTECHSHFEEDBACKHEADER where apfeedbackid='"+hm.get("feedbackID")+"' and apacademicyear='"+hm.get("academicYear").toString().trim()+"' and entryby='"+hm.get("entryBy")+"'");
       rs=db.getRowset(sb.toString());
       if(rs.next())
       {
        tempVal="11";
       }
       }catch(Exception e)
       {
       e.printStackTrace();
       }finally{
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } if(rs1!=null){
                try {
                    rs1.close();
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
