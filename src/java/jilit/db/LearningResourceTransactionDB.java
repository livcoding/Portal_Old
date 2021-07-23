/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class LearningResourceTransactionDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    private ResultSet rs1;

    public LearningResourceTransactionDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectLearningResourceData,saveupdate, setHeaderData, validateData, selectForUpgrade,feedbackID,selectLowerGridData,selectDataForUpgrade
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (LearningResourceTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectLearningResourceData:
                    responseString = mapper.writeValueAsString(getSelectLearningResourceData(hm));
                    break;
                case saveupdate:
                    responseString =SaveUpdateData(hm);
                    break;
                case setHeaderData:
                    //responseString = mapper.writeValueAsString(getSelectHeaderData(hm));
                    break;
                case validateData:
                    responseString = getValidateData(hm);
                    break;
                case feedbackID:
                   // responseString = getFeedBackID(hm);
                    break;
                case selectLowerGridData:
                    responseString = mapper.writeValueAsString(getLowerGridData(hm));
                    break;
                case selectForUpgrade:
                    responseString = mapper.writeValueAsString(getSelectDataForUpgrade(hm));
                    break;
                
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     private Map getSelectLearningResourceData(Map hm) {
         StringBuffer sqry = new StringBuffer();
         Map SelectData = new HashMap();
         
             try {
                sqry.append(" select NVL(LEARNRESOURCEID,'')LEARNRESOURCEID,NVL(LEARNRESOURCECODE,'')LEARNRESOURCECODE,"
                        + "nvl(LEARNRESOURCENAME,'')LEARNRESOURCENAME,"
                        + "to_char(LSDEVELOPEDDATE,'dd-mm-yyyy')LSDEVELOPEDDATE,nvl(LSDEVELOPEDAMOUNT,'')LSDEVELOPEDAMOUNT"
                        +" from AP#LEARNRESOURCEMASTER");
                sqry.append(" where ").append( "LEARNRESOURCEID='").append(hm.get("learnResourceID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("learnResourceID",rs.getString(1));
                        SelectData.put("learnResourceCode",rs.getString(2));
                        SelectData.put("learnResourceName",rs.getString(3));
                        SelectData.put("learnResourceDate",rs.getString(4));
                        SelectData.put("learnResourceAmount",rs.getString(5));
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

                eqry.append("insert into  AP#LEARNRESOURCEHEADER ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APACADEMICYEAR,DEPARTMENTCODE,STAFFID,HEADERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),");
                eqry.append("'").append(hm.get("academicYear")).append("','").append(hm.get("departmentCode")).append("','").append(hm.get("facultyName")).append("','").append(hm.get("headerRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                
            } else {
                sqry.append("Update AP#LEARNRESOURCEHEADER set COMPANYID='").append(hm.get("companyid")).append("',INSTITUTEID='").append(hm.get("instituteid")).append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",APACADEMICYEAR='").append(hm.get("academicYear")).append("',DEPARTMENTCODE='").append(hm.get("departmentCode")).append("',STAFFID='"+hm.get("facultyName")+"',HEADERREMARKS='").append(hm.get("headerRemarks")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')");
                sqry.append(" where TRANSACTIONID='").append(hm.get("transactionID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                pStmt.executeUpdate(); 
                id=hm.get("transactionID").toString();
                
           }
           
           
            
                String Querry = " delete from AP#LEARNRESOURCEDETAIL where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 
           
                if(hm.get("transactionID").equals("0")){
                for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#LEARNRESOURCEDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("LEARNRESOURCEID,LEARNRESOURCEUSAGE,DETAILREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(mp.get("instituteID")).append("','").append(id).append("',to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("learnResourceID")).append("',");
                eqry.append("'").append(getLearnResourceUsage(mp.get("learnResourceUsage").toString())).append("','").append(mp.get("detailRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                }
                
            }else
                {
                    for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                 eqry.append("insert into AP#LEARNRESOURCEDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("LEARNRESOURCEID,LEARNRESOURCEUSAGE,DETAILREMARKS,ENTRYBY,ENTRYDATE)");
                 eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(mp.get("instituteID")).append("','").append(id).append("',to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("learnResourceID")).append("',");
                eqry.append("'").append(getLearnResourceUsage(mp.get("learnResourceUsage").toString())).append("','").append(mp.get("detailRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
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
     
     public String getLearnResourceUsage(String softwareUsage)
       {
           String tempString="";
      if (softwareUsage.equals("High") )
    {
        tempString = "H";
    } else if (softwareUsage.equals("Medium"))
    {
        tempString = "M";
    } else if (softwareUsage.equals("Low"))
    {
        tempString = "L";
    } else
    {
        tempString = "N";
    }
       return tempString;
       }
       
     
     private Map getLowerGridData(Map hm) {
         StringBuffer sqry = new StringBuffer();
         Map SelectData = new HashMap();
         Map mainMap=new HashMap();
         int k=1;
             try {
                sqry.append(" select NVL(TRANSACTIONID,'')TRANSACTIONID,"
                        + "to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,nvl(DEPARTMENTCODE,'')EQUIPMENTDETAILDESC,"
                        + "nvl(APACADEMICYEAR,'')APACADEMICYEAR,nvl(STAFFID,'')STAFFID"
                        +" from AP#LEARNRESOURCEHEADER");
                sqry.append(" where ").append( "APACADEMICYEAR='").append(hm.get("academicYear")).append("' AND DEPARTMENTCODE='"+hm.get("departmentCode")+"'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("transactionID",rs.getString(1));
                        SelectData.put("transactionDate",rs.getString(2));
                        SelectData.put("departmentName",rs.getString(3));
                        SelectData.put("academicYear",rs.getString(4));
                        SelectData.put("staffID",getFacultyName(rs.getString(5)));
                        mainMap.put(k, SelectData);
                        k++;
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return mainMap;
    }
     
     public String getFacultyName(String empID)
     {
         String tempName="";
         StringBuilder sb=new StringBuilder();
         try{
         sb.append("select employeename from employeemaster where employeeid='"+empID+"'");
         pStmt = dbConnection.prepareStatement(sb.toString());
         rs1 = pStmt.executeQuery();
         if(rs1.next())
         {
          tempName=rs1.getString(1);
         }
         }catch(Exception e)
         {
             e.printStackTrace();
         }
         return tempName;
     }
     
     private Map getSelectDataForUpgrade(Map hm) {
         StringBuilder sqry = new StringBuilder();
         StringBuilder eqry = new StringBuilder();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
         Map SelectData2 = new HashMap();
         Map mainMap = new HashMap();
         
         int k=1;
             try {
                sqry.append(" select NVL(AD.LEARNRESOURCEID,'')LEARNRESOURCEID,NVL(AM.LEARNRESOURCECODE,'')LEARNRESOURCECODE,"
                        + "nvl(AM.LEARNRESOURCENAME,'')LEARNRESOURCENAME,"
                        + "nvl(AD.LEARNRESOURCEUSAGE,'')LEARNRESOURCEUSAGE,to_char(AM.LSDEVELOPEDDATE,'dd-mm-yyyy')LSDEVELOPEDDATE,nvl(AM.LSDEVELOPEDAMOUNT,'')LSDEVELOPEDAMOUNT,nvl(AD.DETAILREMARKS,'')DETAILREMARKS"
                        +" from AP#LEARNRESOURCEDETAIL AD,AP#LEARNRESOURCEMASTER AM");
                sqry.append(" where AD.INSTITUTEID=AM.INSTITUTEID AND AD.COMPANYID=AM.COMPANYID AND AD.LEARNRESOURCEID=AM.LEARNRESOURCEID AND  ").append( "TRANSACTIONID='").append(hm.get("transactionID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("learnResourceID",rs.getString(1));
                        SelectData.put("learnResourceCode",rs.getString(2));
                        SelectData.put("learnResourceName",rs.getString(3));
                        SelectData.put("learnResourceUsage",rs.getString(4));
                        SelectData.put("learnResourceDate",rs.getString(5));
                        SelectData.put("learnResourceAmount",rs.getString(6));
                        SelectData.put("detailRemarks",rs.getString(7));
                        SelectData2.put(k, SelectData);
                        k++;
                }
                mainMap.put("childMap", SelectData2);
                eqry.append("select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,nvl(APACADEMICYEAR,'')APACADEMICYEAR,");
                eqry.append("nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(STAFFID,'')STAFFID,nvl(HEADERREMARKS,'')HEADERREMARKS from AP#LEARNRESOURCEHEADER");
                eqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                       
                        SelectData1.put("transactionDate",rs.getString(1));
                        SelectData1.put("academicYear",rs.getString(2));
                        SelectData1.put("departmentCode",rs.getString(3));
                        SelectData1.put("staffID",rs.getString(4));
                        SelectData1.put("headerRemarks",rs.getString(5));
                }
                mainMap.put("parentMap", SelectData1);
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return mainMap;
    }
     
     public String getValidateData(Map hm)
       {
           String tempVal="false";
           StringBuilder sb=new StringBuilder();
           try
           {
               sb.append("select ah.transactionid from AP#LEARNRESOURCEHEADER ah,AP#LEARNRESOURCEDETAIL ad where ah.companyid=ad.companyid and ah.instituteid=ad.instituteid and ah.transactionid=ad.transactionid and ah.transactiondate=ad.transactiondate and ah.apacademicyear='"+hm.get("academicYear")+"' and ah.departmentcode='"+hm.get("departmentName")+"' and ad.learnresourceid='"+hm.get("learningResourceName")+"'");
           pStmt = dbConnection.prepareStatement(sb.toString());
           rs = pStmt.executeQuery();
           if(rs.next())
           {
               tempVal="true";
           }
           }catch(Exception e)
           {
               e.printStackTrace();
           }
           return tempVal;
       }
}
