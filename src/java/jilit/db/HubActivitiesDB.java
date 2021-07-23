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
import java.text.SimpleDateFormat;
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
 * @author ashish1.kumar
 */
public class HubActivitiesDB {
 //private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    private ResultSet rs1;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    IQACconnection db = new IQACconnection();

    public HubActivitiesDB() {
        //dbConnection = DBUtility.getConnection();
    }

    private enum scase {

       saveupdate,selectDepartmentInfo,select,SelectforUpdate,Delete
               //select, SelectforUpdate
    }

    public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {
            });

            switch (HubActivitiesDB.scase.valueOf((String) hm.get("handller").toString())) {

                 case selectDepartmentInfo:
                    responseString = mapper.writeValueAsString(selectDepartmentInfo(hm));
                    break;

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
  private Map selectDepartmentInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();

        try {
              if(!hm.get("searchNames").equals("")){
              searchBoxValue="and (employeename like '%"+hm.get("searchNames")+"%')";
}
           // sqry.append("SELECT DISTINCT NVL (dm.DEPARTMENTCODE, '') AS DEPARTMENTCODE,NVL (dm.DEPARTMENT, '') AS DEPARTMENT,ROWNUM R FROM departmentmaster dm WHERE  NVL (dm.deactive, 'N') = 'N' and departmenttype='T' and department is not null order by DEPARTMENT ");
             sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (employeeid) Totalrecord FROM v#staff where nvl(deactive,'N')='N') a,\n"
                        +"(SELECT * FROM ( select nvl(vs.employeeid,'')employeeid,nvl(vs.employeecode,'')employeecode,nvl(vs.employeename,'')employeename,ROWNUM R"
                        + " from v#staff vs where nvl(vs.deactive,'N')='N'" + "" + searchBoxValue + "  ORDER BY R) )b");
          //   "SELECT a.*, B.*" + "  FROM (SELECT COUNT (studentid) Totalrecord FROM studentmaster where programcode in('M.T','M.T-P','PHD','PHDP')) a,\n" + "(SELECT * FROM ( select nvl(sm.studentid,'')studentid,nvl(sm.enrollmentno,'')enrollmentno,nvl(sm.studentname,'')studentname,nvl(sm.programcode,'')programcode,nvl(sm.branchcode,'')branchcode,ROWNUM R " + "from studentmaster sm where programcode in('M.T','M.T-P','PHD','PHDP') " + "" + searchBoxValue + " order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                int k = 1;
              //  System.out.println("DEPARTMENT"+sqry);
                // if(dbConnection.isClosed()){
               // dbConnection=DBUtility.getConnection(dbConnection);
              //  }
               // pStmt = dbConnection.prepareStatement(sqry.toString());

                rs = db.getRowset(sqry.toString());
              //  System.out.println("HELLO"+rs);
                while (rs.next()) {
                    SelectData =  new HashMap();
                    SelectData.put("totalrecords",rs.getString(1));
                    SelectData.put("employeeId",rs.getString(2));
                     SelectData.put("employeecode",rs.getString(3));
                     SelectData.put("employeename",rs.getString(4));
                    SelectData.put("sno", rs.getString(5));

                       tm.put(k, SelectData);
                        k++;
                }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
    private String SaveUpdateData(Map hm) {

        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        ArrayList list = (ArrayList) hm.get("para");
        String id = "";
        int slno=0 ;
        int nsrno=0 ;
        try {
            if (hm.get("interdispID").equals("0")) {
                try {
                     
                    id = db.generateID();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (callableStatement != null) {
                        callableStatement.close();
                    }
                }
// COMPANYID  INSTITUTEID APFACULTYID TRANSACTIONID TRANSACTIONDATE  HUBNAME  FACUTLYID  ENTRYBY  ENTRYDATE
                eqry.append("insert into AP#HUBACTIVITYHEADER ( COMPANYID,");
                eqry.append("INSTITUTEID,APFACULTYID,TRANSACTIONID,TRANSACTIONDATE,HUBNAME,FACUTLYID,");
                eqry.append("ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyID")).append("','").append(hm.get("instID")).append("','").append(hm.get("staffID")).append("','")
                        .append(id).append("',");
                eqry.append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'")
                     .append(hm.get("hubName")).append("','").append(hm.get("fIds")).append("','")
                        .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-YYYY HH24:MI:SS'))");

                 
                //pStmt = dbConnection.prepareStatement(eqry.toString());
                db.insertRow(eqry.toString());


            } else {
                sqry.append("Update AP#HUBACTIVITYHEADER set COMPANYID='").append(hm.get("companyID"))
                        .append("',INSTITUTEID='") .append(hm.get("instID"))
                       .append("',APFACULTYID='").append(hm.get("staffID")).append("'");
                sqry.append(",TRANSACTIONDATE=to_date('").append(hm.get("transactionDate"))
                        .append("','dd-mm-yyyy'),HUBNAME='").append(hm.get("hubName")).append("',")
                        .append("FACUTLYID='").append(hm.get("fIds")).append("',")
                        .append("ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-YYYY HH24:MI:SS') where TRANSACTIONID='").append(hm.get("interdispID")).append("'");

                
                db.update(sqry.toString());
                id = hm.get("interdispID").toString();

            }


          
              //--------------------------------------------------This Part On Test-----------------------------------------------

                       String Querry = " delete from AP#HUBACTIVITYDETAIL where TRANSACTIONID = '" + hm.get("interdispID") + "'";

                
                db.update(Querry.toString());
//activity detailName financeName
            if (hm.get("interdispID").equals("0")) {
                for (int x = 0; x < list.size(); x++) {
                    eqry = new StringBuilder();
                    Map mp = (Map) list.get(x); 
                   String query= ("select max(SLNO) slno from AP#HUBACTIVITYDETAIL");
            
            rs = db.getRowset(query.toString());
            while (rs.next()){
             slno = rs.getInt("slno");
             nsrno = slno + 1;


                        eqry.append("insert into    AP#HUBACTIVITYDETAIL ( COMPANYID,");
                eqry.append("INSTITUTEID,APFACULTYID,TRANSACTIONID,TRANSACTIONDATE,SLNO,ACTIVITY, DETAILEVENT,FINANCESUPPORT,");
                eqry.append("ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(mp.get("instID")).append("','").append(mp.get("staffID")).append("','")
                        .append(id).append("',");
                eqry.append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(nsrno).append("','")
                .append(mp.get("activity")).append("',");
                eqry.append("'").append(mp.get("detailName")).append("','")
                        .append(mp.get("financeName")).append("','")
                        .append(mp.get("entryBy")).append("',to_date(sysdate,'dd-MM-YYYY HH24:MI:SS'))");
           
                db.insertRow(eqry.toString());
            }
                }
//// AP#HUBACTIVITYDETAIL COMPANYID INSTITUTEID  APFACULTYID TRANSACTIONID TRANSACTIONDATE SLNO ACTIVITY  DETAILEVENT FINANCESUPPORT ENTRYBY ENTRYDATE
            } else {
                for (int x = 0; x < list.size(); x++) {
                    eqry = new StringBuilder();
                    Map mp = (Map) list.get(x);
                     String query= ("select max(SLNO) slno from AP#HUBACTIVITYDETAIL");
              
            rs = db.getRowset(query.toString());
            while (rs.next()){
             slno = rs.getInt("slno");
             nsrno = slno + 1;
                   eqry.append("insert into     AP#HUBACTIVITYDETAIL ( COMPANYID,");
                eqry.append("INSTITUTEID,APFACULTYID,TRANSACTIONID,TRANSACTIONDATE,SLNO,ACTIVITY, DETAILEVENT,FINANCESUPPORT,");
                eqry.append("ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(mp.get("instID")).append("','").append(mp.get("staffID")).append("','")
                    .append(id).append("',");
                eqry.append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(nsrno).append("','")
                    .append(mp.get("activity")).append("',");
                eqry.append("'").append(mp.get("detailName")).append("','")
                        .append(mp.get("financeName")).append("','")
                        .append(mp.get("entryBy")).append("',to_date(sysdate,'dd-MM-YYYY HH24:MI:SS'))");
                
                db.insertRow(eqry.toString());
                }
            } 
            }
        } catch (Exception e) {

            e.printStackTrace();
            return "Record Not Saved";
        }
        return id;

    }
private Map getSelectData(Map hm) {
        Map data = new HashMap();
        TreeMap tm = new TreeMap();
        String searchBoxValue = "";
        StringBuilder sqry = new StringBuilder();
        try {
            //-----------------------------------------------------------Search box work pending--------------------------------------------------------------------
           //if (!hm.get("searchbox").equals("")) {
               //searchBoxValue = "and (ar.HUBNAME like '%" + hm.get("searchbox") + "%')";
            //or sm.STUDENTNAME like '%" + hm.get("searchbox") + "%')";
//                searchBoxValue = searchBoxValue + " or am.INTERDISPYEAR like '%" + hm.get("searchbox") + "%'";
//               searchBoxValue = searchBoxValue + " or am.DETAILSOFWORKDONE like '%" + hm.get("searchbox") + "%'";
//                searchBoxValue = searchBoxValue + " or am.REMARKS like '%" + hm.get("searchbox") + "%')"; 
          //  }

           sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (ah.TRANSACTIONID) Totalrecord FROM v#staff vs,AP#HUBACTIVITYDETAIL ah, AP#HUBACTIVITYHEADER ar WHERE ah.apfacultyid = vs.employeeid and  ah.apfacultyid = '" + hm.get("staffID") + "' And vs.employeetype= 'I' and ah.TRANSACTIONID = ar.TRANSACTIONID ) a,\n"
                    + "  (SELECT *\n"
                    + "  FROM (select  nvl(ad.TRANSACTIONID,'')TRANSACTIONID,"
                    + "to_char(ad.TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE," 
                    + "nvl(ar.HUBNAME,'')HUBNAME,"
                    + "nvl(vs.EMPLOYEENAME,'')EMPLOYEENAME,"
                    + " row_number() over (order by ad.TRANSACTIONID )  R from  v#staff vs,  AP#HUBACTIVITYDETAIL ad,  AP#HUBACTIVITYHEADER ar"
                    + " where ad.APFACULTYID = vs.EMPLOYEEID and ad.APFACULTYID= '" + hm.get("staffID") + "'  And vs.employeetype= 'I' and ad.TRANSACTIONID=ar.TRANSACTIONID " + searchBoxValue + ")\n"
                    + " WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
            int k = 1;
            
            rs = db.getRowset(sqry.toString());
            while (rs.next()) {
                data = new HashMap();
                data.put("slno", rs.getString(6));
                data.put("totalrecords", rs.getString(1)); 
                data.put("interdispID", rs.getString(2));
                data.put("transactionDate", rs.getString(3));
                data.put("hubName", rs.getString(4));
                data.put("employeeName", rs.getString(5));
                

                tm.put(k, data);
                k++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
 private Map selectForUpdate(Map hm) {
        StringBuilder sqry = new StringBuilder();
        TreeMap tm = new TreeMap();
        Map SelectData = new HashMap();
        Map SelectData1 = new HashMap();
        int k = 1;
        try {
            // AP#HUBACTIVITYDETAIL ah, AP#HUBACTIVITYHEADER ar
            // sqry.append(" where VS.EMPLOYEEID=AD.STAFFID AND DM.DEPARTMENTCODE=AD.DEPARTMENTCODE AND ").append("TRANSACTIONID='").append(hm.get("interdispID")).append("'");
            sqry.append(" select to_char(AD.TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,");
            sqry.append("nvl(vs.EMPLOYEENAME,'')EMPLOYEENAME,");
            sqry.append("nvl(vs.EMPLOYEEID,'')EMPLOYEEID,");
            sqry.append("nvl(AD.HUBNAME,'')HUBNAME");//HUBNAME
            sqry.append(" from  AP#HUBACTIVITYHEADER AD,v#staff vs");
            sqry.append(" where vs.EMPLOYEEID=AD.FACUTLYID AND  ").append("TRANSACTIONID='").append(hm.get("interdispID")).append("'");
            rs = db.getRowset(sqry.toString());
            while (rs.next()) {

                SelectData.put("interdispID", hm.get("interdispID"));
                SelectData.put("transactionDate", rs.getString(1));
                SelectData.put("empNAME", rs.getString(2));
                SelectData.put("empID", rs.getString(3));
                  SelectData.put("hubName", rs.getString(4));
            }
           
            sqry = new StringBuilder();
           sqry.append(" select nvl(vs.EMPLOYEEID,'')EMPLOYEEID,nvl(AD.ACTIVITY,'')ACTIVITY,nvl(AD.DETAILEVENT,'')DETAILEVENT,nvl(AD.FINANCESUPPORT,'')FINANCESUPPORT "
                    + " FROM  AP#HUBACTIVITYDETAIL AD ,v#staff vs, AP#HUBACTIVITYHEADER ar");
            sqry.append(" where ar.FACUTLYID =vs.EMPLOYEEID AND AD.TRANSACTIONID = ar.TRANSACTIONID AND ").append("AD.TRANSACTIONID='").append(hm.get("interdispID")).append("'");

             rs = db.getRowset(sqry.toString());
            while (rs.next()) {
                SelectData1 = new HashMap();

               // SelectData1.put("transactionID", rs.getString(1));
               // SelectData1.put("transactionDate", rs.getString(2));
                SelectData1.put("facultyID", rs.getString(1));
                SelectData1.put("activity", rs.getString(2));
                SelectData1.put("detailEvent", rs.getString(3));
                SelectData1.put("fSupport", rs.getString(4));
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
               
            String qry1 = "delete from AP#HUBACTIVITYDETAIL  where transactionid = '" + hm.get("interdispID") + "'";
            db.update(qry1.toString());
            String qry2 = "delete from AP#HUBACTIVITYHEADER where transactionid = '" + hm.get("interdispID") + "'";
            db.update(qry2.toString());
        } catch (Exception e) {

            e.printStackTrace();
        }
        return new HashMap();
    }
}
