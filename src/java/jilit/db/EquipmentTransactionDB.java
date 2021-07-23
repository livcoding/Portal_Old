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
import java.util.TreeMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class EquipmentTransactionDB {
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public EquipmentTransactionDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectEqptSoftData,saveupdate, setHeaderData, validateData, selectForUpgrade,feedbackID,selectLowerGridData,selectDataForUpgrade,getEqptSoftNames
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (EquipmentTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectEqptSoftData:
                    responseString = mapper.writeValueAsString(getSelectEqptSoftData(hm));
                    break;
                case saveupdate:
                    responseString =SaveUpdateData(hm);
                    break;
                case setHeaderData:
                    responseString = mapper.writeValueAsString(getSelectHeaderData(hm));
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
                case getEqptSoftNames:
                    responseString = mapper.writeValueAsString(getEqptSoftNames(hm));
                    break;
                
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     
      private Map getSelectEqptSoftData(Map hm) {
         StringBuffer sqry = new StringBuffer();
         Map SelectData = new HashMap();
         
             try {
                sqry.append(" select NVL(EQUIPMENTID,'')EQUIPMENTID,NVL(EQUIPMENTCODE,'')EQUIPMENTCODE,"
                        + "nvl(EQUIPMENTNAME,'')EQUIPMENTNAME,nvl(EQUIPMENTDETAILDESC,'')EQUIPMENTDETAILDESC,"
                        + "to_char(PROCUREMENTDATE,'dd-mm-yyyy')PROCUREMENTDATE,nvl(PROCUREMENTCOST,'')PROCUREMENTCOST"
                        +" from AP#EQPTSOFTMASTER");
                sqry.append(" where ").append( "EQUIPMENTID='").append(hm.get("eqptSoftID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("equipmentID",rs.getString(1));
                        SelectData.put("equipmentCode",rs.getString(2));
                        SelectData.put("equipmentName",rs.getString(3));
                        SelectData.put("equipmentDetailDesc",rs.getString(4));
                        SelectData.put("procurementDate",rs.getString(5));
                        SelectData.put("procurementCost",rs.getString(6));
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

                eqry.append("insert into  AP#EQPTSOFTHEADER ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APACADEMICYEAR,DEPARTMENTCODE,HEADERREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),");
                eqry.append("'").append(hm.get("academicYear")).append("','").append(hm.get("departmentCode")).append("','").append(hm.get("headerRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                
            } else {
                sqry.append("Update AP#EQPTSOFTHEADER set COMPANYID='").append(hm.get("companyid")).append("',INSTITUTEID='").append(hm.get("instituteid")).append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",APACADEMICYEAR='").append(hm.get("academicYear")).append("',DEPARTMENTCODE='").append(hm.get("departmentCode")).append("',HEADERREMARKS='").append(hm.get("headerRemarks")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')");
                sqry.append(" where TRANSACTIONID='").append(hm.get("transactionID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                pStmt.executeUpdate(); 
                id=hm.get("transactionID").toString();
                
           }
           
           
            
                String Querry = " delete from AP#EQPTSOFTDETAIL where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 
           
                if(hm.get("transactionID").equals("0")){
                for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#EQPTSOFTDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("EQUIPMENTID,EQUIPMENTUSAGE,DETAILREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(mp.get("instituteID")).append("','").append(id).append("',to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("equipmentID")).append("',");
                eqry.append("'").append(getSoftwareUsage(mp.get("equipmentUsage").toString())).append("','").append(mp.get("detailRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                }
                
            }else
                {
                    for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                 eqry.append("insert into AP#EQPTSOFTDETAIL ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("EQUIPMENTID,EQUIPMENTUSAGE,DETAILREMARKS,ENTRYBY,ENTRYDATE)");
                 eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(mp.get("instituteID")).append("','").append(id).append("',to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("equipmentID")).append("',");
                eqry.append("'").append(getSoftwareUsage(mp.get("equipmentUsage").toString())).append("','").append(mp.get("detailRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
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
       
       private Map getLowerGridData(Map hm) {
         StringBuffer sqry = new StringBuffer();
         Map SelectData = new HashMap();
         Map mainMap=new HashMap();
         int k=1;
             try {
                sqry.append(" select NVL(TRANSACTIONID,'')TRANSACTIONID,"
                        + "to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,nvl(DEPARTMENTCODE,'')EQUIPMENTDETAILDESC,"
                        + "nvl(APACADEMICYEAR,'')APACADEMICYEAR"
                        +" from AP#EQPTSOFTHEADER");
                sqry.append(" where ").append( "APACADEMICYEAR='").append(hm.get("academicYear")).append("' AND DEPARTMENTCODE='"+hm.get("departmentCode")+"'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("transactionID",rs.getString(1));
                        SelectData.put("transactionDate",rs.getString(2));
                        SelectData.put("departmentName",rs.getString(3));
                        SelectData.put("academicYear",rs.getString(4));
                        mainMap.put(k, SelectData);
                        k++;
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return mainMap;
    }
       
       private Map getSelectDataForUpgrade(Map hm) {
         StringBuilder sqry = new StringBuilder();
         StringBuilder eqry = new StringBuilder();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
         Map SelectData2 = new HashMap();
         Map mainMap = new HashMap();
         List dataList=new ArrayList();
         int k=1;
             try {
                sqry.append(" select NVL(AD.EQUIPMENTID,'')EQUIPMENTID,NVL(AM.EQUIPMENTCODE,'')EQUIPMENTCODE,"
                        + "nvl(AM.EQUIPMENTNAME,'')EQUIPMENTNAME,nvl(AM.EQUIPMENTDETAILDESC,'')EQUIPMENTDETAILDESC,"
                        + "nvl(AD.EQUIPMENTUSAGE,'')EQUIPMENTUSAGE,to_char(AM.PROCUREMENTDATE,'dd-mm-yyyy')PROCUREMENTDATE,nvl(AM.PROCUREMENTCOST,'')PROCUREMENTCOST,nvl(AD.DETAILREMARKS,'')DETAILREMARKS"
                        +" from AP#EQPTSOFTDETAIL AD,AP#EQPTSOFTMASTER AM");
                sqry.append(" where AD.INSTITUTEID=AM.INSTITUTEID AND AD.COMPANYID=AM.COMPANYID AND AD.EQUIPMENTID=AM.EQUIPMENTID AND  ").append( "TRANSACTIONID='").append(hm.get("transactionID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("equipmentID",rs.getString(1));
                        SelectData.put("equipmentCode",rs.getString(2));
                        SelectData.put("equipmentName",rs.getString(3));
                        SelectData.put("equipmentDetailDesc",rs.getString(4));
                        SelectData.put("equipmentUsage",rs.getString(5));
                        SelectData.put("procurementDate",rs.getString(6));
                        SelectData.put("procurementCost",rs.getString(7));
                        SelectData.put("detailRemarks",rs.getString(8));
                        SelectData2.put(k, SelectData);
                        k++;
                }
                mainMap.put("childMap", SelectData2);
                eqry.append("select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,nvl(APACADEMICYEAR,'')APACADEMICYEAR,");
                eqry.append("nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(HEADERREMARKS,'')HEADERREMARKS from AP#EQPTSOFTHEADER");
                eqry.append(" where ").append( "transactionid='").append(hm.get("transactionID")).append("'");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                       
                        SelectData1.put("transactionDate",rs.getString(1));
                        SelectData1.put("academicYear",rs.getString(2));
                        SelectData1.put("departmentCode",rs.getString(3));
                        SelectData1.put("headerRemarks",rs.getString(4));
                }
                mainMap.put("parentMap", SelectData1);
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return mainMap;
    }
       
       public String getSoftwareUsage(String softwareUsage)
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
       
       
       private Map getSelectHeaderData(Map hm) {
         StringBuffer sqry = new StringBuffer();
         Map SelectData = new HashMap();
         
             try {
                sqry.append(" select NVL(AM.EQUIPMENTID,'')EQUIPMENTID,NVL(AM.EQUIPMENTDETAILDESC,'')EQUIPMENTDETAILDESC,"
                        + "nvl(AD.EQUIPMENTUSAGE,'')EQUIPMENTUSAGE,to_char(PROCUREMENTDATE,'dd-mm-yyyy')PROCUREMENTDATE,"
                        + "nvl(AM.PROCUREMENTCOST,'')PROCUREMENTCOST,nvl(AD.DETAILREMARKS,'')DETAILREMARKS"
                        +" from AP#EQPTSOFTMASTER AM,AP#EQPTSOFTDETAIL AD WHERE AM.COMPANYID=AD.COMPANYID"
                        +" AND AD.INSTITUTEID=AM.INSTITUTEID AND AD.EQUIPMENTID=AM.EQUIPMENTID");
                sqry.append(" AND ").append( "AD.EQUIPMENTID='").append(hm.get("equipmentID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData.put("equipmentID",rs.getString(1));
                        SelectData.put("equipmentDetailDesc",rs.getString(2));
                        SelectData.put("equipmentUsage",rs.getString(3));
                        SelectData.put("procurementDate",rs.getString(4));
                        SelectData.put("procurementCost",rs.getString(5));
                        SelectData.put("detailRemarks",rs.getString(6));
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }
       
       public String getValidateData(Map hm)
       {
           String tempVal="false";
           StringBuilder sb=new StringBuilder();
           try
           {
               sb.append("select ah.transactionid from AP#EQPTSOFTHEADER ah,AP#EQPTSOFTDETAIL ad where ah.companyid=ad.companyid and ah.instituteid=ad.instituteid and ah.transactionid=ad.transactionid and ah.transactiondate=ad.transactiondate and ah.apacademicyear='"+hm.get("academicYear")+"' and ah.departmentcode='"+hm.get("departmentName")+"' and ad.equipmentid='"+hm.get("eqptSoftwareName")+"'");
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
       
       public String getEqptSoftNames(Map jdata) {
        Map hm = new HashMap();
        ObjectMapper mapper = new ObjectMapper();
        StringBuilder sb = new StringBuilder();
        StringBuilder op = new StringBuilder();
        
          try{
            
            sb.append("  SELECT DISTINCT NVL (AESM.EQUIPMENTID, '') AS EQUIPMENTID,NVL (AESM.EQUIPMENTNAME, '') AS EQUIPMENTNAME FROM AP#EQPTSOFTMASTER AESM WHERE  NVL (AESM.deactive, 'N') = 'N' AND DEPARTMENTCODE='"+jdata.get("departmentName")+"' order by EQUIPMENTNAME ");
            pStmt = dbConnection.prepareStatement(sb.toString());
            rs = pStmt.executeQuery();
            op.append("<option value='' selected>Select Eqpt/Software Name</option>"); 
            while (rs.next()) {
                op.append("<option value='" + rs.getString(1) + "' >" + rs.getString(2) + "</option>");
                }
           
        } catch (Exception e) {
            e.printStackTrace();
        }
        return op.toString();
    }
}
