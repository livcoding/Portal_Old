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
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.ConcurrentHashMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class PublicationTransactionDB {
  private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    private ResultSet rs1;

    public PublicationTransactionDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectAuthorInfo,saveupdate, select, validateData, selectForUpgrade,setCompleteReferenceAndApiScore,selectLowerGridData
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (PublicationTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectAuthorInfo:
                    responseString = mapper.writeValueAsString(selectAuthorInfo(hm));
                    break;
                case saveupdate:
                    responseString =SaveUpdateData(hm);
                    break;
                case select:
                   // responseString = mapper.writeValueAsString(getSelectData(hm));
                    break;
                case validateData:
                    responseString = getValidateData(hm);
                    break;
                case selectForUpgrade:
                    responseString = mapper.writeValueAsString(getSelectDataForUpgrade(hm));
                    break;
                case setCompleteReferenceAndApiScore:
                    responseString = mapper.writeValueAsString(setCompleteReferenceAndApiScore(hm));
                    break;
                case selectLowerGridData:
                    responseString = mapper.writeValueAsString(getLowerGridData(hm));
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     private Map selectAuthorInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();
        try {
            
            if(!hm.get("searchNames").equals("")){
              searchBoxValue="and (vs.employeename like '%"+hm.get("searchNames")+"%')";
              }
            
                sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (employeeid) Totalrecord FROM v#staff where nvl(deactive,'N')='N' and employeeid not in(" + hm.get("totalStaffIDS") + ")) a,\n"
                        +"(SELECT * FROM ( select nvl(vs.employeeid,'')employeeid,nvl(vs.employeecode,'')employeecode,nvl(vs.employeename,'')employeename,nvl(vs.EMPLOYEETYPE,'')EMPLOYEETYPE,nvl(vs.departmentcode,'')departmentcode,nvl(dm.department,'')department,ROWNUM R "
                        + "from v#staff vs,departmentmaster dm where vs.departmentcode=dm.departmentcode and nvl(vs.deactive,'N')='N' "
                        + " and vs.employeeid not in(" + hm.get("totalStaffIDS") + ") "+searchBoxValue+" order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                
                int k = 1;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("totalrecords",rs.getString(1));
                        SelectData.put("employeeID",rs.getString(2));
                        SelectData.put("employeeCode",rs.getString(3));
                        SelectData.put("employeename",rs.getString(4));
                        SelectData.put("employeeType",rs.getString(5));
                        SelectData.put("departmentCode",rs.getString(6));
                        SelectData.put("departmentName",rs.getString(7));
                        SelectData.put("sno", rs.getString(8));
                        tm.put(k, SelectData);
                        k++;
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
       
     
     public Map setCompleteReferenceAndApiScore(Map hm)
     {
         Map selectData=new HashMap();
         String qry="";
        try {
                qry="select title,jcname,apiscore from ap#publicationmaster where publicationid='"+hm.get("publicationID")+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                  selectData.put("completeReference","Title-"+rs.getString(1)+",JCName-"+rs.getString(2));
                  selectData.put("apiScore", rs.getString(3));
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         
     return selectData;
     }
     
     private String SaveUpdateData(Map hm) 
   {
       
        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        StringBuilder authorInfoQuery = new StringBuilder();
        ArrayList list = (ArrayList) hm.get("para");
        ArrayList list1 = (ArrayList) hm.get("para1");
         String id = "";
        try {
           
                if(hm.get("transactionID").equals("0")){
                    
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
                for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#ARPUBLICATIONTRN ( COMPANYID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APPUBLICATIONTYPEID,APPUBLICATIONTYPECODE,PUBLICATIONID,");
                eqry.append("PUBLICATIONCODE,TITLE,");
                eqry.append("IMPACTFACTOR,INDEXINGBODYID,ENTRYBY,ENTRYDATE,PUBLICATIONYEAR,IMPACTFACTORVALUE,COMPLETEREFERENCE)");
                eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(id).append("',to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'")
                .append(mp.get("publicationTypeID")).append("','");
                eqry.append(getPublicationTypeCode(mp.get("publicationTypeID").toString())).append("','")
                .append(id).append("','");
                eqry.append(id).append("','");
                eqry.append(mp.get("publicationName")).append("','");
                eqry.append(mp.get("impactFactorID")).append("','");
                eqry.append(mp.get("indexingBodyID")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM')").append(",'").append(mp.get("publicationYear")).append("','").append(mp.get("impactFactorValue")).append("','").append(mp.get("completeReference")).append("')");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                }
                
                for(int x=0;x<list1.size();x++){ 
                authorInfoQuery = new StringBuilder();
                Map mp=(Map)list1.get(x);
                authorInfoQuery.append("insert into  AP#ARPUBLICATIONTRNAUTHOR (COMPANYID,TRANSACTIONID,TRANSACTIONDATE,APPUBLICATIONTYPEID,");
                authorInfoQuery.append("APPUBLICATIONTYPECODE,PUBLICATIONID,PUBLICATIONCODE,");
                authorInfoQuery.append("TITLE,STAFFTYPE,STAFFID,");
                authorInfoQuery.append("DEPARTMENTCODE,ENTRYBY,ENTRYDATE)");
                authorInfoQuery.append(" VALUES('").append(mp.get("companyID")).append("','").append(id).append("',to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'")
                .append(mp.get("publicationTypeID")).append("','");
                authorInfoQuery.append(getPublicationTypeCode(mp.get("publicationTypeID").toString())).append("','")
                .append(id).append("','");
                authorInfoQuery.append(id).append("','");
                authorInfoQuery.append(mp.get("publicationName")).append("','");
                authorInfoQuery.append(mp.get("staffType")).append("','");
                authorInfoQuery.append(mp.get("staffID")).append("','");
                authorInfoQuery.append(mp.get("departmentCode")).append("','");
                authorInfoQuery.append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(authorInfoQuery.toString());
                pStmt.executeUpdate();
                }
                
            }else
                {
                String Querry1 = " delete from AP#ARPUBLICATIONTRNAUTHOR where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                pStmt = dbConnection.prepareStatement(Querry1);
                pStmt.executeUpdate();
                
                String Querry = " delete from AP#ARPUBLICATIONTRN where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 
                
                 for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                 eqry.append("insert into  AP#ARPUBLICATIONTRN ( COMPANYID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("APPUBLICATIONTYPEID,APPUBLICATIONTYPECODE,PUBLICATIONID,");
                eqry.append("PUBLICATIONCODE,TITLE,");
                eqry.append("IMPACTFACTOR,INDEXINGBODYID,ENTRYBY,ENTRYDATE,PUBLICATIONYEAR,IMPACTFACTORVALUE,COMPLETEREFERENCE)");
                eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(hm.get("transactionID")).append("',to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'")
                .append(mp.get("publicationTypeID")).append("','");
                eqry.append(getPublicationTypeCode(mp.get("publicationTypeID").toString())).append("','")
                .append(hm.get("transactionID")).append("','");
                eqry.append(hm.get("transactionID")).append("','");
                eqry.append(mp.get("publicationName")).append("','");
                eqry.append(mp.get("impactFactorID")).append("','");
                eqry.append(mp.get("indexingBodyID")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM')").append(",'").append(mp.get("publicationYear")).append("','").append(mp.get("impactFactorValue")).append("','").append(mp.get("completeReference")).append("')");;
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                } 
                 
                for(int x=0;x<list1.size();x++){
                authorInfoQuery = new StringBuilder();
                Map mp=(Map)list1.get(x);
                authorInfoQuery.append("insert into  AP#ARPUBLICATIONTRNAUTHOR (COMPANYID,TRANSACTIONID,TRANSACTIONDATE,APPUBLICATIONTYPEID,");
                authorInfoQuery.append("APPUBLICATIONTYPECODE,PUBLICATIONID,PUBLICATIONCODE,");
                authorInfoQuery.append("TITLE,STAFFTYPE,STAFFID,");
                authorInfoQuery.append("DEPARTMENTCODE,ENTRYBY,ENTRYDATE)");
                authorInfoQuery.append(" VALUES('").append(mp.get("companyID")).append("','").append(hm.get("transactionID")).append("',to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'")
                .append(mp.get("publicationTypeID")).append("','");
                authorInfoQuery.append(getPublicationTypeCode(mp.get("publicationTypeID").toString())).append("','")
                .append(hm.get("transactionID")).append("','");
                authorInfoQuery.append(hm.get("transactionID")).append("','");
                authorInfoQuery.append(mp.get("publicationName")).append("','");
                authorInfoQuery.append(mp.get("staffType")).append("','");
                authorInfoQuery.append(mp.get("staffID")).append("','");
                authorInfoQuery.append(mp.get("departmentCode")).append("','");
                authorInfoQuery.append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(authorInfoQuery.toString());
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
     
     public String getPublicationTypeCode(String publicationTypeID)
     {
         String tempValue="";
         String qry="";
         try {
                qry="select appublicationtypecode from ap#publicationtypemaster where appublicationtypeid='"+publicationTypeID+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs = pStmt.executeQuery();
                if (rs.next()) {
                tempValue=rs.getString(1);
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         return tempValue;
     }
     
     public String getPublicationCode(String publicationID)
     {
         String tempValue="";
         String qry="";
         try {
                qry="select publicationcode from ap#publicationmaster where publicationid='"+publicationID+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs = pStmt.executeQuery();
                if (rs.next()) {
                tempValue=rs.getString(1);
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         return tempValue;
     }
     
     private Map getLowerGridData(Map hm) {
         StringBuffer sqry = new StringBuffer();
         ConcurrentHashMap SelectData = new ConcurrentHashMap();
         ConcurrentHashMap mainMap=new ConcurrentHashMap();
         int k=1;
             try {
                sqry.append(" select NVL(TRANSACTIONID,'')TRANSACTIONID,"
                        + "to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                        + "nvl(APPUBLICATIONTYPEID,'')APPUBLICATIONTYPEID,"
                        + "nvl(TITLE,'')TITLE,nvl(PUBLICATIONYEAR,'')PUBLICATIONYEAR,nvl(IMPACTFACTORVALUE,'')IMPACTFACTORVALUE"
                        +" from AP#ARPUBLICATIONTRN order by transactionid desc");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new ConcurrentHashMap();
                        SelectData.put("transactionID",rs.getString(1));
                        SelectData.put("transactionDate",rs.getString(2));
                        SelectData.put("publicationTypeName",rs.getString(3));
                        SelectData.put("publicationName",rs.getString(4));
                        SelectData.put("publicationYear",rs.getString(5));
                        SelectData.put("impactFactorValue",rs.getString(6));
                        mainMap.put(k, SelectData);
                        k++;
                }
             } catch (Exception e) {
                 e.printStackTrace();
             }
        ConcurrentHashMap mainMap1=getModifyMap(mainMap);  
        return mainMap1;
    }
     
     public String getDepartmentName(String departmentCode)
     {
         String tempValue="";
         String qry="";
         try {
                qry="select department from departmentmaster where departmentcode='"+departmentCode+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs1 = pStmt.executeQuery();
                if (rs1.next()) {
                tempValue=rs1.getString(1);
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         return tempValue;
     }
     public String getPublicationTypeName(String publicationTypeID)
     {
         String tempValue="";
         String qry="";
         try {
                qry="select APPUBLICATIONTYPEDESCRIPTION from AP#PUBLICATIONTYPEMASTER where APPUBLICATIONTYPEID='"+publicationTypeID+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs1 = pStmt.executeQuery();
                if (rs1.next()) {
                tempValue=rs1.getString(1);
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         return tempValue;
     }
     
     public String getAuthorName(String staffID)
     {
         String tempValue="";
         String qry="";
         try {
                qry="select EMPLOYEENAME from V#STAFF where EMPLOYEEID='"+staffID+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs1 = pStmt.executeQuery();
                if (rs1.next()) {
                tempValue=rs1.getString(1);
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         return tempValue;
     }
     
      public String getPublicationName(String publicationID)
     {
         String tempValue="";
         String qry="";
         try {
                qry="select TITLE from AP#PUBLICATIONMASTER where PUBLICATIONID='"+publicationID+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs1 = pStmt.executeQuery();
                if (rs1.next()) {
                tempValue=rs1.getString(1);
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         return tempValue;
     }
      
      
      public String getValidateData(Map hm)
      {
          String tempVal="false";
          String qry="";
         try {
                qry="select transactionid from AP#ARPUBLICATIONTRN where APPUBLICATIONTYPEID='"+hm.get("publicationTypeID")+"' and PUBLICATIONID='"+hm.get("publicationID")+"' and IMPACTFACTOR='"+hm.get("impactFactor")+"' and INDEXINGBODYID='"+hm.get("indexingBodyID")+"' and PUBLICATIONYEAR='"+hm.get("publicationYear")+"' and IMPACTFACTORVALUE='"+hm.get("impactFactorValue")+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs1 = pStmt.executeQuery();
                if (rs1.next()) {
                tempVal="true";
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         return tempVal;
      }
      
      
      private List getSelectDataForUpgrade(Map hm) {
         StringBuilder sqry = new StringBuilder();
         TreeMap tm = new TreeMap();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
         List dataList=new ArrayList();
         int k=0;
         int n=1;
             try {
                sqry.append("SELECT NVL(at.TRANSACTIONID,'')TRANSACTIONID,to_char(at.TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,");
                sqry.append("NVL(at.APPUBLICATIONTYPEID,'')APPUBLICATIONTYPEID,NVL(atm.APPUBLICATIONTYPEDESCRIPTION,'')APPUBLICATIONTYPEDESCRIPTION,");
              
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("transactionID",rs.getString(1));
                        SelectData.put("transactionDate",rs.getString(2));
                        SelectData.put("publicationTypeID",rs.getString(3));
                        SelectData.put("publicationType",rs.getString(4));
                        SelectData.put("publicationID",rs.getString(5));
                        SelectData.put("apiScore",getAPIScore(rs.getString(5)));
                        SelectData.put("publicationName",rs.getString(6));
                        SelectData.put("impactFactorID",rs.getString(7));
                        SelectData.put("impactFactor",getImpactFactor(rs.getString(7)));
                        SelectData.put("indexingBodyID",rs.getString(8));
                        SelectData.put("indexingBody",rs.getString(9));
                        SelectData.put("publicationYear",rs.getString(10));
                        SelectData.put("impactFactorValue",rs.getString(11));
                        SelectData.put("completeReference",rs.getString(12));
                        dataList.add(k, SelectData);
                        k++;
                }
                
                sqry = new StringBuilder();
            sqry.append(" select nvl(AA.STAFFTYPE,'')STAFFTYPE,NVL (AA.STAFFID, '') STAFFID, NVL (vs.EMPLOYEENAME, '') EMPLOYEENAME,"
                    + "NVL(AA.DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(DM.DEPARTMENT,'')DEPARTMENT"
                    + " FROM AP#ARPUBLICATIONTRNAUTHOR AA ,V#STAFF VS,DEPARTMENTMASTER DM");
            sqry.append(" where VS.EMPLOYEEID=AA.STAFFID AND DM.DEPARTMENTCODE=AA.DEPARTMENTCODE AND ").append("TRANSACTIONID='").append(hm.get("transactionID")).append("'");
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData1 = new HashMap();
                SelectData1.put("authorType", rs.getString(1));
                SelectData1.put("staffType", rs.getString(1));
                SelectData1.put("staffID", rs.getString(2));
                SelectData1.put("authorName", rs.getString(3));
                SelectData1.put("departmentCode", rs.getString(4));
                SelectData1.put("departmentName", rs.getString(5));
                tm.put(n, SelectData1);
                n++;


            }
             dataList.add(1, tm);
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return dataList;
    }
      
      
      public String getImpactFactor(String imID)
      {
          String tempValue="";
          if(imID.equals("J"))
          {
              tempValue="JCR";
          }else
          {
              tempValue="SJR";
          }
          return tempValue;
      }
      
      public String getAPIScore(String publicationID)
     {
         String tempValue="";
         String qry="";
         try {
                qry="select APISCORE from AP#PUBLICATIONMASTER where PUBLICATIONID='"+publicationID+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs1 = pStmt.executeQuery();
                if (rs1.next()) {
                tempValue=rs1.getString(1);
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         return tempValue;
     }
      
      public String getCompleteReference(String publicationID)
     {
         String tempValue="";
         String qry="";
         try {
                qry="select TITLE,JCNAME from AP#PUBLICATIONMASTER where PUBLICATIONID='"+publicationID+"'";
                pStmt = dbConnection.prepareStatement(qry.toString());
                rs1 = pStmt.executeQuery();
                if (rs1.next()) {
                tempValue="Title-"+rs1.getString(1)+",JCName-"+rs1.getString(2);
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
         return tempValue;
     }
      
      public ConcurrentHashMap getModifyMap(ConcurrentHashMap hm)
      {
          String tempKey="";
          ConcurrentHashMap tempValue=new ConcurrentHashMap();
          ConcurrentHashMap cm=new ConcurrentHashMap();
          Iterator it=hm.entrySet().iterator();
          while(it.hasNext())
          {
              Map.Entry mp=(Map.Entry)it.next();
              tempKey=mp.getKey().toString();
              tempValue=(ConcurrentHashMap)mp.getValue();
              Iterator it1=tempValue.entrySet().iterator();
              while(it1.hasNext()){
               Map.Entry mp1=(Map.Entry)it1.next();   
              
              if(mp1.getKey().equals("publicationTypeName"))
              {
               tempValue.put("publicationTypeName", getPublicationTypeName(mp1.getValue().toString()));
              }
              if(mp1.getKey().equals("publicationName"))
              {
               tempValue.put("publicationName", mp1.getValue().toString());
              }
              if(mp1.getKey().equals("transactionID"))
              {
               tempValue.put("transactionID", mp1.getValue().toString());
              }
              if(mp1.getKey().equals("transactionDate"))
              {
               tempValue.put("transactionDate", mp1.getValue().toString());
              }
              if(mp1.getKey().equals("publicationYear"))
              {
               tempValue.put("publicationYear", mp1.getValue().toString());
              }
              if(mp1.getKey().equals("impactFactorValue"))
              {
               tempValue.put("impactFactorValue", mp1.getValue().toString());
              }
              
              }
             cm.put(tempKey, tempValue); 
          }
          
          
          return cm;
      }
}
