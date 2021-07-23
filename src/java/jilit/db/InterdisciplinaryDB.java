/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class InterdisciplinaryDB {

    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    private ResultSet rs1;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    public InterdisciplinaryDB() {
        dbConnection = DBUtility.getConnection();
    }

    private enum scase {

        selectFacultyInfo, saveupdate, select, SelectforUpdate
    }

    public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {
            });

            switch (InterdisciplinaryDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectFacultyInfo:
                    responseString = mapper.writeValueAsString(selectFacultyInfo(hm));
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
                

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }

    private Map selectFacultyInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue = "";
        Map SelectData = new HashMap();
        try {

            if (!hm.get("searchNames").equals("")) {
                searchBoxValue = "and (UPPER(vs.employeename) like '%" + hm.get("searchNames").toString().toUpperCase() + "%')";
            }
            sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (v.employeeid) Totalrecord FROM v#staff v,departmentmaster d where v.departmentcode = d.departmentcode and nvl(v.deactive,'N')='N' and v.employeeid not in(" + hm.get("totalStaffIDS") + ")) a,\n"
                    + "(SELECT * FROM ( select nvl(vs.employeeid,'')employeeid,nvl(vs.employeetype,'')employeetype,nvl(vs.employeename,'')employeename,"
                    + "nvl(dm.department,'')department,nvl(vs.departmentcode,'')departmentcode, ROWNUM R "
                    + "from v#staff vs,departmentmaster dm where VS.DEPARTMENTCODE=DM.DEPARTMENTCODE and nvl(vs.deactive,'N')='N'"
                    //  + " and vs.employeeid not in(" + hm.get("totalStaffIDS") + ") " + searchBoxValue + "  and vs.employeeid not in(select  STAFFID from AP#PATENTDETAIL where PATENTID='" + hm.get("patentID") + "')order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                    + " and vs.employeeid not in(" + hm.get("totalStaffIDS") + ") " + searchBoxValue + " order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");

            int k = 1;
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData = new HashMap();
                SelectData.put("totalrecords", rs.getString(1));
                SelectData.put("facultyID", rs.getString(2));
                SelectData.put("facultyType", rs.getString(3));
                SelectData.put("facultyName", rs.getString(4));
                SelectData.put("departmentName", rs.getString(5));
                SelectData.put("departmentCode", rs.getString(6));
                SelectData.put("sno", rs.getString(7));
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
        try {
            if (hm.get("interdispID").equals("0")) {
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

                eqry.append("insert into  AP#INTERDISPHEADER ( COMPANYID,");
                eqry.append("TRANSACTIONID,TRANSACTIONDATE,DEPARTMENTCODE,TYPEOFINTERDISP,INTERDISPYEAR,DETAILSOFWORKDONE,REMARKS,");
                eqry.append("ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(hm.get("companyID")).append("','")
                        .append(id).append("',");
                eqry.append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'")
                        .append(hm.get("departmentCombo")).append("','")
                        .append(hm.get("typeOfWorkDone")).append("','")
                        .append(hm.get("forTheYear")).append("',");
                eqry.append("'").append(hm.get("detailsOfWorkDone")).append("','")
                        .append(hm.get("remarks")).append("','")
                        .append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();

            } else {
                sqry.append("Update AP#INTERDISPHEADER set COMPANYID='").append(hm.get("companyID")).append("'");
                sqry.append(",TRANSACTIONDATE=to_date('").append(hm.get("transactionDate"))
                        .append("','dd-mm-yyyy'),DEPARTMENTCODE='").append(hm.get("departmentCombo")).append("',");
                sqry.append("TYPEOFINTERDISP='").append(hm.get("typeOfWorkDone"))
                        .append("',INTERDISPYEAR='").append(hm.get("forTheYear"))
                        .append("',DETAILSOFWORKDONE='").append(hm.get("detailsOfWorkDone")).append("'");
                sqry.append(",REMARKS='").append(hm.get("remarks"))
                        .append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM') where TRANSACTIONID='").append(hm.get("interdispID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                pStmt.executeUpdate();
                id = hm.get("interdispID").toString();

            }



            String Querry = " delete from AP#INTERDISPDETAIL where TRANSACTIONID = '" + hm.get("interdispID") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

            if (hm.get("interdispID").equals("0")) {
                for (int x = 0; x < list.size(); x++) {
                    eqry = new StringBuilder();
                    Map mp = (Map) list.get(x);
                    eqry.append("insert into  AP#INTERDISPDETAIL ( COMPANYID,");
                    eqry.append("TRANSACTIONID,TRANSACTIONDATE,STAFFTYPE,STAFFID,DEPARTMENTCODE,ROLE,ENTRYBY,ENTRYDATE)");
                    eqry.append(" VALUES('").append(mp.get("companyID")).append("','")
                            .append(id).append("',");
                    eqry.append("to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'")
                            .append(mp.get("facultyType")).append("',");
                    eqry.append("'").append(mp.get("facultyID")).append("','")
                            .append(mp.get("departmentCode")).append("',");
                    eqry.append("'").append(mp.get("roleOfFaculty")).append("','")
                            .append(mp.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                    pStmt = dbConnection.prepareStatement(eqry.toString());
                    pStmt.executeUpdate();
                }

            } else {
                for (int x = 0; x < list.size(); x++) {
                    eqry = new StringBuilder();
                    Map mp = (Map) list.get(x);
                    eqry.append("insert into  AP#INTERDISPDETAIL ( COMPANYID,");
                    eqry.append("TRANSACTIONID,TRANSACTIONDATE,STAFFTYPE,STAFFID,DEPARTMENTCODE,ROLE,ENTRYBY,ENTRYDATE)");
                    eqry.append(" VALUES('").append(mp.get("companyID")).append("','")
                            .append(id).append("',");
                    eqry.append("to_date('").append(mp.get("transactionDate")).append("','dd-mm-yyyy'),'")
                            .append(mp.get("facultyType")).append("',");
                    eqry.append("'").append(mp.get("facultyID")).append("','")
                            .append(mp.get("departmentCode")).append("',");
                    eqry.append("'").append(mp.get("roleOfFaculty")).append("','")
                            .append(mp.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                    pStmt = dbConnection.prepareStatement(eqry.toString());
                    pStmt.executeUpdate();
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
            if (!hm.get("searchbox").equals("")) {
                searchBoxValue = "and (ah.TRANSACTIONDATE like '%" + hm.get("searchbox") + "%' or dm.DEPARTMENT like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.INTERDISPYEAR like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.DETAILSOFWORKDONE like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.REMARKS like '%" + hm.get("searchbox") + "%')";
            }

            sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (a.TRANSACTIONID) Totalrecord FROM  AP#INTERDISPHEADER a,DEPARTMENTMASTER d where a.DEPARTMENTCODE=d.DEPARTMENTCODE) a,\n"
                    + "  (SELECT *\n"
                    + "  FROM (select nvl(ah.TRANSACTIONID,'')TRANSACTIONID,"
                    + "to_char(ah.TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                    + "nvl(dm.DEPARTMENT,'') DEPARTMENT,"
                    + "nvl(ah.DEPARTMENTCODE,'')DEPARTMENTCODE,"
                    + "nvl(ah.TYPEOFINTERDISP,'')TYPEOFINTERDISP,"
                    + "nvl(ah.INTERDISPYEAR,'')INTERDISPYEAR,"
                    + "nvl(ah.DETAILSOFWORKDONE,'')DETAILSOFWORKDONE,"
                    + "nvl(ah.REMARKS,'')REMARKS,"
                    + " row_number() over (order by ah.TRANSACTIONID desc)  R from AP#INTERDISPHEADER ah,DEPARTMENTMASTER dm"
                    + " where ah.DEPARTMENTCODE=dm.DEPARTMENTCODE " + searchBoxValue + ")\n"
                    + " WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
            int k = 1;
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("slno", rs.getString(10));
                data.put("totalrecords", rs.getString(1));
                data.put("interdispID", rs.getString(2));
                data.put("transactionDate", rs.getString(3));
                data.put("department", rs.getString(4));
                data.put("departmentCode", rs.getString(5));
                data.put("typeOfWorkDone", rs.getString(6));
                data.put("forTheYear", rs.getString(7));
                data.put("detailsOfWorkDone", rs.getString(8));
                data.put("remarks", rs.getString(9));
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
            sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,");
            sqry.append("nvl(DEPARTMENTCODE,'')DEPARTMENTCODE,");
            sqry.append("nvl(TYPEOFINTERDISP,'')TYPEOFINTERDISP,nvl(INTERDISPYEAR,'')INTERDISPYEAR,");
            sqry.append("nvl(DETAILSOFWORKDONE,'')DETAILSOFWORKDONE,");
            sqry.append("nvl(REMARKS,'')REMARKS from AP#INTERDISPHEADER");
            sqry.append(" where ").append("TRANSACTIONID='").append(hm.get("interdispID")).append("'");
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {

                SelectData.put("interdispID", hm.get("interdispID"));
                SelectData.put("transactionDate", rs.getString(1));
                SelectData.put("departmentCode", rs.getString(2));
                SelectData.put("typeOfWorkDone", rs.getString(3));
                SelectData.put("forTheYear", rs.getString(4));
                SelectData.put("detailsOfWorkDone", rs.getString(5));
                SelectData.put("remarks", rs.getString(6));

            }
            sqry = new StringBuilder();
            sqry.append(" select nvl(AD.STAFFTYPE,'')STAFFTYPE,NVL (AD.STAFFID, '') STAFFID, NVL (vs.EMPLOYEENAME, '') EMPLOYEENAME,"
                    + "NVL(AD.DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(DM.DEPARTMENT,'')DEPARTMENT,nvl(AD.ROLE,'')ROLE"
                    + " FROM AP#INTERDISPDETAIL AD ,V#STAFF VS,DEPARTMENTMASTER DM");
            sqry.append(" where VS.EMPLOYEEID=AD.STAFFID AND DM.DEPARTMENTCODE=AD.DEPARTMENTCODE AND ").append("TRANSACTIONID='").append(hm.get("interdispID")).append("'");
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData1 = new HashMap();
                SelectData1.put("facultyType", rs.getString(1));
                SelectData1.put("facultyID", rs.getString(2));
                SelectData1.put("facultyName", rs.getString(3));
                SelectData1.put("departmentCode", rs.getString(4));
                SelectData1.put("departmentName", rs.getString(5));
                SelectData1.put("roleOfFaculty", rs.getString(6));
                tm.put(k, SelectData1);
                k++;
            }
            
            SelectData.put("childMap", tm);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SelectData;
    }
    
}
