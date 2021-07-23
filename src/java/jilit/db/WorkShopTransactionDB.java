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
import java.util.Map;
import java.util.TreeMap;
import jdbc.DBUtility;
import jdbc.RequestInterface;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class WorkShopTransactionDB implements RequestInterface{
    
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public WorkShopTransactionDB() {
        dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        selectPersonsInfo,saveupdate, select, Delete, SelectforUpdate,chkUniqueValue
    }
    
     
     public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (WorkShopTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectPersonsInfo:
                    responseString = mapper.writeValueAsString(selectPersonsInfo(hm));
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
                case SelectforUpdate:
                    responseString = mapper.writeValueAsString(selectForUpdate(hm));
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
     
     
        private Map selectPersonsInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();
        try {
            
            if(!hm.get("searchNames").equals("")){
              searchBoxValue="and (vs.employeename like '%"+hm.get("searchNames")+"%')";
              }
            
                sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (employeeid) Totalrecord FROM v#staff where nvl(deactive,'N')='N') a,\n"
                        +"(SELECT * FROM ( select nvl(vs.employeeid,'')employeeid,nvl(vs.employeecode,'')employeecode,nvl(vs.employeename,'')employeename,"
                        + "nvl(dm.department,'')department,nvl(dsm.designation,'')designation, ROWNUM R "
                        + "from v#staff vs,departmentmaster dm,designationmaster dsm where VS.DEPARTMENTCODE=DM.DEPARTMENTCODE"
                        + " and DSM.DESIGNATIONCODE=VS.DESIGNATIONCODE "+searchBoxValue+" and nvl(vs.deactive,'N')='N' and vs.employeeid not in("+hm.get("personsIDS")+")  and vs.employeeid not in(select  PSARESOURCEPERSONID from AP#PSAWORKSHOPRESOURCE where TRANSACTIONDATE=to_date('"+hm.get("transactionDate")+"','dd-mm-yyyy'))order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                
                int k = 1;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData = new HashMap();
                        SelectData.put("totalrecords",rs.getString(1));
                        SelectData.put("employeeid",rs.getString(2));
                        SelectData.put("employeecode",rs.getString(3));
                        SelectData.put("employeename",rs.getString(4));
                        SelectData.put("department",rs.getString(5));
                        SelectData.put("designation",rs.getString(6));
                        SelectData.put("sno", rs.getString(7));
                        tm.put(k, SelectData);
                        k++;
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
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

                eqry.append("insert into  AP#PSAWORKSHOPDETAILS ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("DEPARTMENTCODE,PSAPROGRAMTYPE,PSAPROGRAMTITLE,PSASTARTDATE,PSAENDDATE,PSARESOURCEPERSONGROUPID,PSAPROGRAMOBJECTIVE,");
                eqry.append("PSATARGETAUDIENCE,PSATENTATIVEBUDGET,PSAHODAPPROVAL,PSAVCAPPROVAL,PSAPROGRAMREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(hm.get("departmentName")).append("',");
                eqry.append("'").append(hm.get("programType")).append("','").append(hm.get("titleOfTheProgram")).append("',to_date('").append(hm.get("startDate")).append("','dd-mm-yyyy'),to_date('").append(hm.get("endDate")).append("','dd-mm-yyyy'),");
                eqry.append("'").append(id).append("','").append(hm.get("objectiveOfProgram")).append("',");
                eqry.append("'").append(hm.get("targetAudience")).append("','").append(hm.get("tentativeBudget")).append("',");
                eqry.append("'").append(hm.get("approvalOfHOD")).append("','").append(hm.get("approvalOfVC")).append("','").append(hm.get("programRemarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");;
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                
            } else {
                sqry.append("Update AP#PSAWORKSHOPDETAILS set COMPANYID='").append(hm.get("companyid")).append("',INSTITUTEID='").append(hm.get("instituteid")).append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",DEPARTMENTCODE='").append(hm.get("departmentName")).append("',PSAPROGRAMTYPE='").append(hm.get("programType")).append("',PSAPROGRAMTITLE='").append(hm.get("titleOfTheProgram")).append("',");
                sqry.append("PSASTARTDATE=to_date('").append(hm.get("startDate")).append("','dd-mm-yyyy'),PSAENDDATE=to_date('").append(hm.get("endDate")).append("','dd-mm-yyyy'),PSAPROGRAMOBJECTIVE='").append(hm.get("objectiveOfProgram")).append("'");
                sqry.append(",PSATARGETAUDIENCE='").append(hm.get("targetAudience")).append("',PSATENTATIVEBUDGET='").append(hm.get("tentativeBudget")).append("',");
                sqry.append("PSAHODAPPROVAL='").append(hm.get("approvalOfHOD")).append("',PSAVCAPPROVAL='").append(hm.get("approvalOfVC")).append("',PSAPROGRAMREMARKS='").append(hm.get("programRemarks")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where TRANSACTIONID='").append(hm.get("transactionID")).append("'");;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                pStmt.executeUpdate(); 
                id=hm.get("transactionID").toString();
                
           }
           
           
            
                String Querry = " delete from AP#PSAWORKSHOPRESOURCE where TRANSACTIONID = '" + hm.get("transactionID") + "'";
                pStmt = dbConnection.prepareStatement(Querry);
                pStmt.executeUpdate(); 
           
                if(hm.get("transactionID").equals("0")){
                for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#PSAWORKSHOPRESOURCE ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("PSARESOURCEPERSONID,PSARESOURCEPERSONAFFILIATION,PSARESOURCEPERSONEXPERTISE,PSARESOURCEREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(id).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("employeeid")).append("',");
                eqry.append("'").append(mp.get("affiliation")).append("','").append(mp.get("expertise")).append("',");
                eqry.append("'").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();
                }
                
            }else
                {
                    for(int x=0;x<list.size();x++){
                eqry = new StringBuilder();
                Map mp=(Map)list.get(x);
                eqry.append("insert into  AP#PSAWORKSHOPRESOURCE ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("PSARESOURCEPERSONID,PSARESOURCEPERSONAFFILIATION,PSARESOURCEPERSONEXPERTISE,PSARESOURCEREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyid")).append("','").append(hm.get("instituteid")).append("','").append(hm.get("transactionID")).append("',to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(mp.get("employeeid")).append("',");
                eqry.append("'").append(mp.get("affiliation")).append("','").append(mp.get("expertise")).append("',");
                eqry.append("'").append(mp.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
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
          Map data = new HashMap();
          TreeMap tm = new TreeMap();
          String searchBoxValue="";
          StringBuffer sqry = new StringBuffer();
          try {
              if(!hm.get("searchbox").equals("")){
              searchBoxValue="and (awd.transactiondate like '%"+hm.get("searchbox")+"%' or dm.department like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or awd.psaprogramtitle like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or awd.psastartdate like '%"+hm.get("searchbox")+"%'";
              searchBoxValue=searchBoxValue+" or awd.psaenddate like '%"+hm.get("searchbox")+"%')";
              }
             
               sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (transactionid) Totalrecord FROM  ap#psaworkshopdetails) a,\n" +
                        "  (SELECT *\n" +
                        "  FROM (select nvl(awd.transactionid,'')transactionid,"
                       + "to_char(awd.transactiondate,'dd-mm-yyyy')transactiondate,"
                       + "nvl(dm.department,'')department,"
                       + "nvl(awd.psaprogramtitle,'') programtitle,"
                       + "nvl(awd.psaprogramtype,'')psaprogramtype,"
                      + "to_char(awd.psastartdate,'dd-mm-yyyy')psastartdate,"
                      + "to_char(awd.psaenddate,'dd-mm-yyyy')psaenddate,"
                       + " row_number() over (order by awd.transactionid desc)  R from ap#psaworkshopdetails awd,departmentmaster dm"
                      + " where dm.departmentcode=awd.departmentcode "+searchBoxValue+")\n" +
"         WHERE r > "+hm.get("spg")+" AND r <= "+hm.get("epg")+") b ");
              int k = 1;
              pStmt = dbConnection.prepareStatement(sqry.toString());
              rs = pStmt.executeQuery();
              while (rs.next()) {
                  data = new HashMap();
                  data.put("slno",rs.getString(9));
                  data.put("totalrecords", rs.getString(1));
                  data.put("transactionid", rs.getString(2));
                  data.put("transactiondate", rs.getString(3));
                  data.put("department", rs.getString(4));
                  data.put("programtitle", rs.getString(5));
                  data.put("programtype", getProgramType(rs.getString(6)));
                  data.put("startdate", rs.getString(7));
                  data.put("enddate", rs.getString(8));
                  tm.put(k, data);
                  k++;
              }
          } catch (Exception e) {
              e.printStackTrace();
          }
          return tm;
      }
      
         
         private Map selectForUpdate(Map hm) {
         StringBuffer sqry = new StringBuffer();
         TreeMap tm =new TreeMap();
         Map SelectData = new HashMap();
         Map SelectData1 = new HashMap();
         int k = 1;
             try {
                sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                        + "nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(PSAPROGRAMTYPE,'')PROGRAMTYPE,"
                        + "nvl(PSAPROGRAMTITLE,'')PROGRAMTITLE,to_char(PSASTARTDATE,'dd-mm-yyyy')STARTDATE,"
                        + "to_char(PSAENDDATE,'dd-mm-yyyy')ENDDATE,nvl(PSAPROGRAMOBJECTIVE,'')PROGRAMOBJECTIVE,"
                        + "nvl(PSATARGETAUDIENCE,'')TARGETAUDIENCE,"
                        + "nvl(PSATENTATIVEBUDGET,'')TENTATIVEBUDGET,nvl(PSAHODAPPROVAL,'')HODAPPROVAL,"
                        + "nvl(PSAVCAPPROVAL,'')VCAPPROVAL,"
                        + "nvl(PSAPROGRAMREMARKS,'')PROGRAMREMARKS from AP#PSAWORKSHOPDETAILS");
                sqry.append(" where ").append( "TRANSACTIONID='").append(hm.get("transactionid")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    
                        SelectData.put("transactionID",hm.get("transactionid"));
                        SelectData.put("transactiondate",rs.getString(1));
                        SelectData.put("departmentcode",rs.getString(2));
                        SelectData.put("programtype",rs.getString(3));
                        SelectData.put("programtitle",rs.getString(4));
                        SelectData.put("startdate",rs.getString(5));
                        SelectData.put("enddate",rs.getString(6));
                        SelectData.put("programobjective",rs.getString(7));
                        SelectData.put("targetaudience",rs.getString(8));
                        SelectData.put("tentativebudget",rs.getString(9));
                        SelectData.put("hodapproval",rs.getString(10));
                        SelectData.put("vcapproval",rs.getString(11));
                        SelectData.put("programremarks",rs.getString(12));
                        
                   
                }
                sqry = new StringBuffer();
                sqry.append(" select nvl(AWR.TRANSACTIONID,'')TRANSACTIONID,NVL (DM.DESIGNATION, '') DESIGNATION, NVL (vs.EMPLOYEENAME, '') EMPLOYEENAME,"
                        + "to_char(AWR.TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,nvl(AWR.PSARESOURCEPERSONID,'')PSARESOURCEPERSONID,"
                        + "nvl(AWR.PSARESOURCEPERSONAFFILIATION,'')PSARESOURCEPERSONAFFILIATION,nvl(AWR.PSARESOURCEPERSONEXPERTISE,'')PSARESOURCEPERSONEXPERTISE,"
                        + "nvl(AWR.PSARESOURCEREMARKS,'')PSARESOURCEREMARKS FROM AP#PSAWORKSHOPRESOURCE AWR ,V#STAFF VS,DESIGNATIONMASTER DM");
                sqry.append(" where VS.DESIGNATIONCODE=DM.DESIGNATIONCODE AND VS.EMPLOYEEID=awr.PSARESOURCEPERSONID AND ").append( "TRANSACTIONID='").append(hm.get("transactionid")).append("'");
                 pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                        SelectData1 = new HashMap();
                        SelectData1.put("designation",rs.getString(2));
                        SelectData1.put("personName",rs.getString(3));
                        SelectData1.put("transactiondate",rs.getString(4));
                        SelectData1.put("employeeid",rs.getString(5));
                        SelectData1.put("affiliation",rs.getString(6));
                        SelectData1.put("expertise",rs.getString(7));
                        SelectData1.put("remarks",rs.getString(8));
                        tm.put(k, SelectData1);
                        k++;
                        
                   
                }
                SelectData.put("childMap", tm);
             } catch (Exception e) {
                 e.printStackTrace();
             }
        return SelectData;
    }

         
          private Map getDeleteData(Map hm) {
        int k[]={};
          try {
           Statement st= dbConnection.createStatement();
            String qry1 = "delete from ap#psaworkshopfeedback where transactionid = '" + hm.get("transactionID") + "'";
            st.addBatch(qry1);
            String qry2 = "delete from ap#psaworkshopresource where transactionid = '" + hm.get("transactionID") + "'";
            st.addBatch(qry2);
            String qry3 = "delete from ap#psaworkshopdetails where transactionid = '" + hm.get("transactionID") + "'";
            st.addBatch(qry3);
            st.executeBatch();

        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return new HashMap();
    }
    
          
    public String getProgramType(String programType)
    {
        String programTypeValue = "";
        if (programType.equals("W")) {
            programTypeValue = "Work Shop";
        } else if (programType.equals("S")) {
            programTypeValue = "Special Course";
        } else if (programType.equals("G")) {
            programTypeValue = "Guest Lecture";
        } else {
            programTypeValue = "Faculty Development Program";
        }

        return programTypeValue;
    }
}
