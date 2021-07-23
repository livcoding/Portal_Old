/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.Array;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class TrusteeFeedbackTransactionDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    private ResultSet rs1;

    public TrusteeFeedbackTransactionDB() {
        dbConnection = DBUtility.getConnection();
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

            switch (TrusteeFeedbackTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
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
     
     
     private Map selectGridData(Map hm) {
        StringBuilder sqry = new StringBuilder();
        StringBuffer eqry = new StringBuffer();
        List l = new ArrayList();
        l.add("abc");
        Map tm = new HashMap();
        Map SelectData = new HashMap();
        int k = 1;
        int p = 1;
        try {
            sqry.append("SELECT NVL(AM.HEADID,'')HEADID,NVL(QUESTIONID,' ')QUESTIONID,NVL(QUESTIONBODY,' ')QUESTIONBODY,NVL(RATINGID,' ') RATING,NVL(AH.PARENTHEADID,'')PARENTHEADID,nvl( (select decode(x.headid,'','N','Y') from AP#SHQUESTIONMASTER x where X.HEADID in  (select parentheadid from AP#SHQUESTIONHEAD) and x.headid = am.headid and rownum =1),'N') flag,NVL (AM.MANDATORYQUESTION, 'N')MANDATORYQUESTION FROM AP#SHQUESTIONMASTER AM,AP#SHQUESTIONHEAD AH WHERE AM.COMPANYCODE=AH.COMPANYCODE AND AM.INSTITUTECODE=AH.INSTITUTECODE AND AM.FEEDBACKID=AH.FEEDBACKID AND AM.COMPONENTTYPE=AH.COMPONENTTYPE AND AM.HEADID=AH.HEADID AND AM.EXAMCODE=AH.EXAMCODE AND AM.COMPONENTTYPE='S' AND AM.FEEDBACKID='" + hm.get("feedbackid") + "'  ORDER BY AM.QUESTIONID");
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
             int u = 1;
            while (rs.next()) {
                SelectData = new HashMap();
                SelectData.put("slno", k);
                SelectData.put("headid", rs.getString(1));
                l.add(rs.getString(1));
                eqry = new StringBuffer();
                eqry.append("SELECT count(AM.HEADID) ");
                eqry.append("FROM AP#SHQUESTIONMASTER AM, AP#SHQUESTIONHEAD AH ");
                eqry.append("WHERE     AM.COMPANYCODE = AH.COMPANYCODE ");
                eqry.append("AND AM.INSTITUTECODE = AH.INSTITUTECODE ");
                eqry.append("AND AM.FEEDBACKID = AH.FEEDBACKID ");
                eqry.append("AND AM.COMPONENTTYPE = AH.COMPONENTTYPE ");
                eqry.append("AND AM.HEADID = AH.HEADID ");
                eqry.append("AND AM.EXAMCODE = AH.EXAMCODE ");
                eqry.append("AND AM.COMPONENTTYPE = 'S' ");
                eqry.append("and AM.HEADID='").append(rs.getString(1)).append("' ");
                eqry.append("and AH.PARENTHEADID='").append(l.get(l.size() - 2)).append("'");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                rs1 = pStmt.executeQuery();
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
                    SelectData.put("mandatoryQuestion", rs.getString(7));
                    tm.put(p, SelectData);
                p++;
                
               
            }
            tm.put("rating", getRatingCombo());
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
     sb.append("select  rd.RATINGID,wm_concat(distinct '\"'||rd.rating||'@@'||rd.ratingdesc||'\"'),rm.subjective from ap#shratingdetail rd,ap#shratingmaster rm where rd.companycode=rm.companycode and rd.institutecode=rm.institutecode and rd.examcode=rm.examcode and rd.feedbackid=rm.feedbackid and rd.ratingid=rm.ratingid group by  rd.RATINGID,rm.subjective ");
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
    
     public String checkQuestionType(String ratingid){
         String questionType="";
         StringBuilder sb=new StringBuilder();
         try{
         sb.append("select subjective from ap#shratingmaster where ratingid='"+ratingid+"'");
         pStmt = dbConnection.prepareStatement(sb.toString());
         rs = pStmt.executeQuery();
         if(rs.next())
         {
         questionType=rs.getString(1);
         }
         }catch(Exception e){
         e.printStackTrace();
         }
     return questionType;
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

                eqry.append("insert into  AP#TRUSTEEFEEDBACKHEADER ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APACADEMICYEAR,PROGRAMCODE,APFEEDBACKREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(hm.get("feedbackName")).append("',");
                eqry.append("'").append(hm.get("academicYear")).append("','").append(hm.get("programName")).append("','").append(hm.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");;
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                
            } else {
                sqry.append("Update AP#TRUSTEEFEEDBACKHEADER set COMPANYID='").append(hm.get("companyid")).append("',INSTITUTEID='").append(hm.get("instituteid")).append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",APFEEDBACKID='").append(hm.get("feedbackName")).append("',APACADEMICYEAR='").append(hm.get("academicYear")).append("',PROGRAMCODE='").append(hm.get("programName")).append("',");
                sqry.append(" APFEEDBACKREMARKS='").append(hm.get("remarks")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where TRANSACTIONID='").append(hm.get("transactionID")).append("'");;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                pStmt.executeUpdate(); 
                id=hm.get("transactionID").toString();
                
           }
           
           
            
                String Querry = " delete from AP#TRUSTEEFEEDBACKDETAIL where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 
           
                if(hm.get("transactionID").equals("0")){
                for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#TRUSTEEFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");;
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                }
                
            }else
                {
                    for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#TRUSTEEFEEDBACKDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APFEEDBACKID,APFEEDBACKITEMID,APFEEDBACKITEMREMARKS,APFEEDBACKRATINGID,APFEEDBACKRATING,APFEEDBACKUSERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("feedbackName")).append("',");
                eqry.append("'").append(mp.get("questionID")).append("','").append(mp.get("appfeedbackItemRemarks")).append("',");
                eqry.append("'").append(mp.get("ratingid")).append("','").append(mp.get("rating")==null?"":mp.get("rating")).append("','").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");;
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                } 
                }
           
            
            
        }catch(Exception e)
         {
             
             e.printStackTrace();
             return "Record Not Saved";
         }
        
        
    return id;
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
                        + "nvl(APACADEMICYEAR,'')APACADEMICYEAR,nvl(PROGRAMCODE,'')PROGRAMCODE,"
                        + "nvl(APFEEDBACKREMARKS,'')APFEEDBACKREMARKS "
                        +" from AP#TRUSTEEFEEDBACKHEADER");
                sqry.append(" where ").append( "APFEEDBACKID='").append(hm.get("feedbackid")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    
                        SelectData.put("transactiondate",rs.getString(1));
                        SelectData.put("transactionID",rs.getString(2));
                        SelectData.put("feedbackID",rs.getString(3));
                        SelectData.put("academicYear",rs.getString(4));
                        SelectData.put("programcode",rs.getString(5));
                        //SelectData.put("semester",rs.getString(6));
                        SelectData.put("feedbackRemarks",rs.getString(6));
                        
                        
                   
                }
                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE, NVL (APFEEDBACKID, '') APFEEDBACKID,"
                        + "nvl(APFEEDBACKITEMID,'')APFEEDBACKITEMID,nvl(APFEEDBACKITEMREMARKS,'')APFEEDBACKITEMREMARKS,"
                        + "nvl(APFEEDBACKRATINGID,'')APFEEDBACKRATINGID,nvl(APFEEDBACKRATING,'')APFEEDBACKRATING,"
                        + "nvl(APFEEDBACKUSERREMARKS,'')APFEEDBACKUSERREMARKS FROM AP#TRUSTEEFEEDBACKDETAIL ");
                sqry.append(" where ").append( "APFEEDBACKID='").append(hm.get("feedbackid")).append("'");
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
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
        return SelectData;
    }
      
      public String getParentQuestion(Map hm)
      {
      String tempVal="false";
      String tempVal1="";
      StringBuilder sb=new StringBuilder();
      try
      {
      sb.append("select parentheadid from ap#shquestionhead where headid='"+hm.get("headid")+"'");
       pStmt = dbConnection.prepareStatement(sb.toString());
       rs = pStmt.executeQuery();
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
      }
      
      return tempVal;
      }

      public String getFeedBackID(Map hm)
      {
      String feedbackID="";
      String feedbackDesc="";
      String concat="";
      StringBuilder sb =new StringBuilder();
      try{
      sb.append("select APFEEDBACKID,APFEEDBACKNAME from AP#FEEDBACKTYPEMASTER where APFEEDBACKTYPE='SHTRUSTEE'");
       pStmt = dbConnection.prepareStatement(sb.toString());
       rs = pStmt.executeQuery();
      while(rs.next()){
         feedbackID=rs.getString(1);
         feedbackDesc=rs.getString(2);
         }
      concat=feedbackID+"/"+feedbackDesc;
      }catch(Exception e)
      {
      e.printStackTrace();
      }
      return concat;
      }
      
      private Map getLowerGridData(Map hm) {
        StringBuffer sqry = new StringBuffer();
        Map SelectData = new HashMap();
        Map outerData=new HashMap();
        int k=1;
        try {
          sqry.append("select ah.transactionid,ah.apfeedbackid,ah.apacademicyear,ah.apfeedbackremarks from ap#trusteefeedbackheader ah where  ah.apacademicyear='"+hm.get("academicYear")+"' and ah.entryby='"+hm.get("entryBy")+"'");
          pStmt = dbConnection.prepareStatement(sqry.toString());
          rs = pStmt.executeQuery();
          while (rs.next()) {
                       SelectData = new HashMap();
                       SelectData.put("transactionID",rs.getString(1));
                        SelectData.put("feedbackid",rs.getString(2));
                        
                        SelectData.put("academicyear",rs.getString(3));
                        SelectData.put("remarks",rs.getString(4));
                        
                        outerData.put(k,SelectData);
                        k++;
                  
                }  
          
        } catch (Exception e) {
            e.printStackTrace();
        }
        return outerData;
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
                        + "nvl(APFEEDBACKREMARKS,'')APFEEDBACKREMARKS "
                        +" from AP#TRUSTEEFEEDBACKHEADER");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    
                        SelectData.put("transactiondate",rs.getString(1));
                        SelectData.put("transactionID",rs.getString(2));
                        SelectData.put("feedbackID",rs.getString(3));
                        SelectData.put("academicYear",rs.getString(4));
                        
                        SelectData.put("feedbackRemarks",rs.getString(6));
                        SelectData.put("programcode",rs.getString(5));
                        
                        
                   
                }
                sqry = new StringBuffer();
                sqry.append(" select nvl(TRANSACTIONID,'')TRANSACTIONID,to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE, NVL (APFEEDBACKID, '') APFEEDBACKID,"
                        + "nvl(APFEEDBACKITEMID,'')APFEEDBACKITEMID,nvl(APFEEDBACKITEMREMARKS,'')APFEEDBACKITEMREMARKS,"
                        + "nvl(APFEEDBACKRATINGID,'')APFEEDBACKRATINGID,nvl(APFEEDBACKRATING,'')APFEEDBACKRATING,"
                        + "nvl(APFEEDBACKUSERREMARKS,'')APFEEDBACKUSERREMARKS FROM AP#TRUSTEEFEEDBACKDETAIL ");
                sqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
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
        return SelectData;
    }
      
      public String getProgramName(String programcode)
     {
     String programCode="";
     try{
     String qry="select programname from programmaster where programcode='"+programcode+"'";
     pStmt = dbConnection.prepareStatement(qry);
     rs = pStmt.executeQuery();
     if(rs.next())
     {
         programCode=rs.getString(1);
     }
     }catch(Exception e)
     {
         e.printStackTrace();;
     }
     return programCode;
     }
      
      
      public String getExpiryDate(Map hm)
    {
        String tempVariable="false";
        StringBuilder sb=new StringBuilder();
        try
        {
        sb.append("select apfeedbackid from AP#FEEDBACKTYPEMASTER where to_date('"+hm.get("todayDate")+"','dd-mm-yyyy')  between apfeedbackfromdate and apfeedbacktodate and apfeedbacktype='SHTRUSTEE'");
        pStmt = dbConnection.prepareStatement(sb.toString());
        rs = pStmt.executeQuery();
        if(rs.next())
        {
          tempVariable="true";  
        }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        
        return tempVariable;
    }
      
      public String getValidateData(Map hm)
       {
       String tempVal="00";
       StringBuilder sb=new StringBuilder();
       try{
       sb.append("select transactionid from AP#TRUSTEEFEEDBACKHEADER where apfeedbackid='"+hm.get("feedbackID")+"' and apacademicyear='"+hm.get("academicYear")+"' and entryby='"+hm.get("entryBy")+"'");
       pStmt = dbConnection.prepareStatement(sb.toString());
       rs = pStmt.executeQuery();
       if(rs.next())
       {
        tempVal="11";   
       }
       }catch(Exception e)
       {
       e.printStackTrace();
       }
       
       return tempVal;
       }
}
