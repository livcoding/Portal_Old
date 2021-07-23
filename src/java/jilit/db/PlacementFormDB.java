/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package jilit.db;

import java.sql.SQLException;
import jdbc.DBUtility;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
/**
 *
 * @author ashish1.kumar
 */
public class PlacementFormDB {
   private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public PlacementFormDB() {
        dbConnection = DBUtility.getConnection();
        
    }

     private enum scase {
        saveupdate, select, Delete, SelectforUpdate,chkUniqueValue
    }
 public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {
            });

            switch (PlacementFormDB.scase.valueOf((String) hm.get("handller").toString())) {


                case saveupdate:
                    responseString = SaveUpdateData(hm);
                   break;
                case select:
                     responseString = mapper.writeValueAsString(getSelectData(hm));
                   break;
               case SelectforUpdate:
                     responseString = mapper.writeValueAsString(selectForUpdate(hm));
                    break;
               case Delete:
                    responseString = mapper.writeValueAsString(getDeleteData(hm));
                    break;



            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }



       private String SaveUpdateData(Map hm) throws SQLException 
   {
          StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
         Statement pStmtt=null;
        ResultSet rstt=null;
        ArrayList list = (ArrayList) hm.get("para");
        String id = "";
        int slno=0 ;
        int nsrno=0 ;
        try {
            if (hm.get("interdispID").equals("0")) {
                try {
                    if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                    }
                    callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                    callableStatement.setString(1, "0001");
                    callableStatement.setString(2, "FBMId");
                    callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                    callableStatement.execute();
                    id = callableStatement.getString(3);
                } catch (Exception e) {
                    e.printStackTrace();
                }
//              
             eqry.append("insert into AP#JOBPLACEMENTHEADER  ( COMPANYID,");
                eqry.append("INSTITUTEID,APFACULTYID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyID")).append("','").append(hm.get("instID")).append("','").append(hm.get("staffID")).append("','")
                .append(id).append("',");
                eqry.append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'")
                .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-YYYY HH24:MI:SS'))");
//              
            }
           
      //
            else{ 
            sqry.append("Update AP#JOBPLACEMENTDETAIL set COMPANYID='").append(hm.get("companyID")).append("").append("',INSTITUTEID='").append(hm.get("instID")).append("',NOOFSTUDENT='").append(hm.get("apstud")).append("',APFACULTYID='").append(hm.get("staffID")).append("',");
            sqry.append("TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy')");
            sqry.append(",SLNO='").append(hm.get("slNo")).append("',NAMEOFCOMPANY='").append(hm.get("cName")).append("',NUMBEROFOFFERS='").append(hm.get("offer")).append("',PLACEMENTBRANCH='").append(hm.get("branch")).append("'");
            sqry.append(",PLACEMENTAREA='").append(hm.get("area")).append("',COMPANYNATURE='").append(hm.get("nature")).append("',COMPANYSIZE='").append(hm.get("size")).append("',");
            sqry.append("PACKAGEOFFER='").append(hm.get("salPkg")).append("',CAMPUSTYPE='").append(hm.get("onOff")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-YYYY') where TRANSACTIONID='").append(hm.get("interdispID")).append("'");
            }
            
//            pStmtt = dbConnection.createStatement();
//                pStmtt.executeUpdate(eqry.toString());
          
            String qry=sqry.append(eqry).toString();
            if(dbConnection.isClosed()){
              dbConnection=DBUtility.getConnection(dbConnection);
            }
            pStmtt = dbConnection.createStatement();
            pStmtt.executeUpdate(qry.toString());
           
            if (hm.get("interdispID").equals("0")) {
                for (int x = 0; x < list.size(); x++) {
                    eqry = new StringBuilder();
                    Map mp = (Map) list.get(x);
                   String query= ("select max(SLNO) slno from AP#JOBPLACEMENTDETAIL");
            if(dbConnection.isClosed()){
              dbConnection=DBUtility.getConnection(dbConnection);
            }
            pStmtt = dbConnection.createStatement();
            rstt = pStmtt.executeQuery(query.toString());
            while (rstt.next()){
             slno = rstt.getInt("slno");
            nsrno = slno + 1;
               eqry.append("INSERT INTO AP#JOBPLACEMENTDETAIL ( NOOFSTUDENT, COMPANYID, INSTITUTEID, APFACULTYID,TRANSACTIONID, TRANSACTIONDATE,SLNO,");
        eqry.append(" NAMEOFCOMPANY, NUMBEROFOFFERS, PLACEMENTBRANCH,PLACEMENTAREA,COMPANYNATURE,COMPANYSIZE,PACKAGEOFFER,CAMPUSTYPE,ENTRYBY,ENTRYDATE");
        eqry.append(" ) VALUES ("+mp.get("apstud")+", '"+mp.get("companyID")+"', '"+mp.get("instID")+"','"+mp.get("staffID")+"', '"+id+"',to_date('"+mp.get("transactionDate")+"','dd-mm-yyyy'),"+nsrno+",'"+mp.get("cName")+"',"+mp.get("offer")+", '"+mp.get("branch")+"', '"+mp.get("area")+"','"+mp.get("nature")+"','"+mp.get("size")+"','"+mp.get("salPkg")+"','"+mp.get("onOff")+"','"+mp.get("entryBy")+"',to_date(sysdate,'dd-MM-YYYY HH24:MI:SS') ");// .append(mp.get("entryBy")).append("',to_date(sysdate,'dd-MM-YYYY HH24:MI:SS'))
        eqry.append(" )");

                if(dbConnection.isClosed()){
              dbConnection=DBUtility.getConnection(dbConnection);
            }
                pStmtt = dbConnection.createStatement();
                pStmtt.executeUpdate(eqry.toString());
            }
                }

            }
        } catch(Exception e)
         {
             e.printStackTrace();
         }
         finally{
          if(pStmtt!=null){
            pStmtt.close();
          }

          }
            return id;

    }



    private Map getSelectData(Map hm) throws SQLException {
        Map data = new HashMap();
        TreeMap tm = new TreeMap();
         Statement ptq=null;
        ResultSet rst=null;
        String searchBoxValue = "";
        StringBuilder sqry = new StringBuilder();
        try {
           

           sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (ah.TRANSACTIONID) Totalrecord FROM  AP#JOBPLACEMENTDETAIL  ah, AP#JOBPLACEMENTHEADER ar WHERE  ah.TRANSACTIONID = ar.TRANSACTIONID ) a,\n"
                    + "  (SELECT *\n"
                    + "  FROM (select  nvl(ah.TRANSACTIONID,'')TRANSACTIONID,"
                    + "to_char(ar.TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                    + "nvl(ah.NAMEOFCOMPANY,'')NAMEOFCOMPANY,"
                    + "nvl(ah.NUMBEROFOFFERS,'')NUMBEROFOFFERS,"
                      + "nvl(ah.PLACEMENTBRANCH,'')PLACEMENTBRANCH,"
                        + "nvl(ah.PLACEMENTAREA,'')PLACEMENTAREA,"
                          + "nvl(ah.COMPANYNATURE,'')COMPANYNATURE,"
                            + "nvl(ah.NOOFSTUDENT,'')NOOFSTUDENT,"
                    + " row_number() over (order by ah.TRANSACTIONID )  R from  AP#JOBPLACEMENTDETAIL  ah, AP#JOBPLACEMENTHEADER ar "
                    + " where  ah.TRANSACTIONID=ar.TRANSACTIONID " + searchBoxValue + ")\n"
                    + " WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
            int k = 1;
            if(dbConnection.isClosed()){
              dbConnection=DBUtility.getConnection(dbConnection);
            }
            ptq = dbConnection.createStatement();
            rst = ptq.executeQuery(sqry.toString());
            while (rst.next()) {
                data = new HashMap();
                data.put("slno", rst.getString(10));
                data.put("totalrecords", rst.getString(1));
                data.put("interdispID", rst.getString(2));
                data.put("transactionDate", rst.getString(3));
                data.put("cName", rst.getString(4));
                data.put("offer", rst.getString(5));
                data.put("branch", rst.getString(6));
                data.put("area", rst.getString(7));
                 data.put("nature", rst.getString(8));
                 data.put("tstud", rst.getString(9));


                tm.put(k, data);
                k++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
         finally{
          if(ptq!=null){
            ptq.close();
          }
          if(rst!=null){
            rst.close();
          }
        }
        return tm;
    }
     private Map selectForUpdate(Map hm) throws SQLException {
        StringBuffer sqry = new StringBuffer();
        Map SelectData = new HashMap();
         Statement psmt=null;
        ResultSet rsrt=null;
        try {
//NAMEOFCOMPANY  NUMBEROFOFFERS PLACEMENTBRANCH PLACEMENTAREA COMPANYNATURE COMPANYSIZE PACKAGEOFFER CAMPUSTYPE

                sqry.append(" select nvl(NAMEOFCOMPANY,'')NAMEOFCOMPANY,nvl(NUMBEROFOFFERS,'')NUMBEROFOFFERS,nvl(PLACEMENTBRANCH,'')PLACEMENTBRANCH,nvl(PLACEMENTAREA,'')PLACEMENTAREA" );
                sqry.append(",nvl(COMPANYNATURE,'')COMPANYNATURE,nvl(COMPANYSIZE,'')COMPANYSIZE,nvl(PACKAGEOFFER,'')PACKAGEOFFER,nvl(CAMPUSTYPE,'')CAMPUSTYPE,nvl(SLNO,'')SLNO,nvl(NOOFSTUDENT,'')NOOFSTUDENT from AP#JOBPLACEMENTDETAIL");
                sqry.append(" where  TRANSACTIONID='").append(hm.get("interdispID")).append("'");

                if(dbConnection.isClosed()){
                dbConnection=DBUtility.getConnection(dbConnection);
                }
                psmt = dbConnection.createStatement();
                rsrt = psmt.executeQuery(sqry.toString());
                while (rsrt.next()) {

                        SelectData.put("intDisp",hm.get("interdispID"));
                        SelectData.put("cName",rsrt.getString(1));
                        SelectData.put("nOffer",rsrt.getString(2));
                        SelectData.put("plaBranch",rsrt.getString(3));
                        SelectData.put("plaArea",rsrt.getString(4));
                        SelectData.put("cNature",rsrt.getString(5));
                        SelectData.put("cSize",rsrt.getString(6));
                        SelectData.put("pkgOffer",rsrt.getString(7));
                        SelectData.put("cType",rsrt.getString(8));
                        SelectData.put("SLNO", rsrt.getString(9));
                         SelectData.put("tstud", rsrt.getString(10));

                }

        } catch (Exception e) {
            e.printStackTrace();
        }
  finally{
          if(psmt!=null){
            psmt.close();
          }
          if(rsrt!=null){
            rsrt.close();
          }
        }
        return SelectData;
    }
    private Map getDeleteData(Map hm) throws SQLException {
        int k[]={};
         Statement st=null;
          try {
              if(dbConnection.isClosed()){
              dbConnection=DBUtility.getConnection(dbConnection);
            }
            st= dbConnection.createStatement();
            String qry1 = "delete from AP#JOBPLACEMENTDETAIL  where transactionid = '" + hm.get("interdispID") + "'";
            st.addBatch(qry1);
            String qry2 = "delete from AP#JOBPLACEMENTHEADER  where transactionid = '" + hm.get("interdispID") + "'";
            st.addBatch(qry2);
            st.executeBatch();

        } catch (Exception e) {

            e.printStackTrace();
        }
         finally{
          if(st!=null){
            st.close();
          }
         }
        return new HashMap();
    }
}