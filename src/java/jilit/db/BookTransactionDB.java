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
import java.util.TreeSet;
import java.util.concurrent.ConcurrentHashMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class BookTransactionDB {

    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    public BookTransactionDB() {
        dbConnection = DBUtility.getConnection();
    }

    private enum scase {

        selectStaffInfo, saveupdate, select, SelectforUpdate,Delete,selectStudentInfo
    }

    public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {
            });

            switch (BookTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectStaffInfo:
                    responseString = mapper.writeValueAsString(selectStaffInfo(hm));
                    break;
                case selectStudentInfo:
                    responseString = mapper.writeValueAsString(selectStudentInfo(hm));
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
    
    
    private Map selectStudentInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        Map tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();
        try {
            
            if(!hm.get("searchNames").equals("")){
              searchBoxValue="and (studentname like '%"+hm.get("searchNames")+"%')";
              }
            
                sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (sm.studentid) Totalrecord FROM studentmaster sm,branchdepttagging bt,departmentmaster dm where nvl(sm.deactive,'N')='N' and sm.programcode is not null and BT.INSTITUTECODE=SM.INSTITUTECODE and BT.ACADEMICYEAR=SM.ACADEMICYEAR and BT.SECTIONBRANCH=SM.BRANCHCODE and BT.PROGRAMCODE=SM.PROGRAMCODE and BT.DEPARTMENTCODE=DM.DEPARTMENTCODE and bt.departmentcode='"+hm.get("departmentID")+"' and sm.studentid not in(" + hm.get("totalStudentIDS") + ")) a,\n"
                        +"(SELECT * FROM ( select nvl(sm.studentid,'')studentid,nvl(sm.studentname,'')studentname,nvl(sm.programcode,'')programcode,nvl(sm.branchcode,'')branchcode,"
                        + "NVL (bt.departmentcode, '') departmentcode, NVL (dm.department, '') department,ROWNUM R "
                        + "from studentmaster sm,branchdepttagging bt,departmentmaster dm where nvl(sm.deactive,'N')='N' AND sm.programcode IS NOT NULL "
                        + " and BT.INSTITUTECODE=SM.INSTITUTECODE and BT.ACADEMICYEAR=SM.ACADEMICYEAR and BT.SECTIONBRANCH=SM.BRANCHCODE and BT.PROGRAMCODE=SM.PROGRAMCODE and BT.DEPARTMENTCODE=DM.DEPARTMENTCODE and bt.departmentcode='"+hm.get("departmentID")+"' "
                        + " and sm.studentid not in(" + hm.get("totalStudentIDS") + ") "+searchBoxValue+" order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                        
                
                int k = 1;
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData = new HashMap();
                SelectData.put("totalrecords", rs.getString(1));
                SelectData.put("memberID", rs.getString(2));
                SelectData.put("memberType", "S");
                SelectData.put("memberName", rs.getString(3));
                SelectData.put("departmentCode", rs.getString(6));
                SelectData.put("department",rs.getString(7));
                SelectData.put("sno", rs.getString(8));
                tm.put(k, SelectData);
                k++;
            }
           
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }

    private Map selectStaffInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue = "";
        Map SelectData = new HashMap();
        try {

            if (!hm.get("searchNames").equals("")) {
                searchBoxValue = "and (vs.employeename like '%" + hm.get("searchNames") + "%')";
            }
            sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (employeeid) Totalrecord FROM v#staff where nvl(deactive,'N')='N' and departmentcode='"+hm.get("departmentID")+"' and employeeid not in(" + hm.get("totalStaffIDS") + ")) a,\n"
                    + "(SELECT * FROM ( select nvl(vs.employeeid,'')employeeid,nvl(vs.employeetype,'')employeetype,nvl(vs.employeename,'')employeename,"
                    + "nvl(dm.department,'')department,nvl(vs.departmentcode,'')departmentcode, ROWNUM R "
                    + "from v#staff vs,departmentmaster dm where VS.DEPARTMENTCODE=DM.DEPARTMENTCODE and nvl(vs.deactive,'N')='N' and vs.departmentcode='"+hm.get("departmentID")+"'"
                    + " and vs.employeeid not in(" + hm.get("totalStaffIDS") + ") " + searchBoxValue + "  and vs.employeeid not in(select  STAFFID from ap#bookdetail where BOOKID='" + hm.get("bookID") + "')order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");

            int k = 1;
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData = new HashMap();
                SelectData.put("totalrecords", rs.getString(1));
                SelectData.put("memberID", rs.getString(2));
                SelectData.put("memberType", rs.getString(3));
                SelectData.put("memberName", rs.getString(4));
                SelectData.put("department", rs.getString(5));
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
            if (hm.get("bookID").equals("0")) {
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

                eqry.append("insert into  AP#BOOKMASTER ( COMPANYID,");
                eqry.append("BOOKID,TRANSACTIONDATE,ROLE,BOOKCODE,BOOKTITLE1,BOOKTITL2,BOOKNATURE,");
                eqry.append("BOOKREMARKS,BOOKCHAPTERNAME,APISCORE,ENTRYBY,ENTRYDATE,PUBLICATIONYEAR,ACADEMICYEAR)");
                eqry.append(" VALUES('").append(hm.get("companyID")).append("','").append(id).append("',");
                eqry.append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(hm.get("role")).append("','").append(hm.get("bookCode")).append("','").append(hm.get("bookTitle1")).append("',");
                eqry.append("'").append(hm.get("bookTitle2")).append("','").append(hm.get("bookNature")).append("',");
                eqry.append("'").append(hm.get("bookRemarks")).append("','").append(hm.get("bookChapter")).append("','").append(hm.get("apiScore")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM')");
                eqry.append(",'").append(hm.get("publicationYear")).append("','").append(hm.get("academicYear")).append("')");
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();

            } else {
                sqry.append("Update AP#BOOKMASTER set COMPANYID='").append(hm.get("companyID"));
                sqry.append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),ROLE='").append(hm.get("role")).append("',");
                sqry.append("BOOKCODE='").append(hm.get("bookCode")).append("',BOOKTITLE1='").append(hm.get("bookTitle1")).append("',BOOKTITL2='").append(hm.get("bookTitle2")).append("'");
                sqry.append(",BOOKNATURE='").append(hm.get("bookNature"));
                sqry.append("',BOOKREMARKS='").append(hm.get("bookRemarks")).append("',BOOKCHAPTERNAME='").append(hm.get("bookChapter")).append("',APISCORE='").append(hm.get("apiScore")).append("',ENTRYBY='").append(hm.get("entryBy")).append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM'),PUBLICATIONYEAR='"+hm.get("publicationYear")+"',ACADEMICYEAR='"+hm.get("academicYear")+"' where BOOKID='").append(hm.get("bookID")).append("'");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                pStmt.executeUpdate();
                id = hm.get("bookID").toString();

            }



            String Querry = " delete from AP#BOOKDETAIL where BOOKID = '" + hm.get("bookID") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

            if (hm.get("bookID").equals("0")) {
                for (int x = 0; x < list.size(); x++) {
                    eqry = new StringBuilder();
                    Map mp = (Map) list.get(x);
                    eqry.append("insert into  AP#BOOKDETAIL ( COMPANYID,");
                    eqry.append("BOOKID,STAFFTYPE,STAFFID,DEPARTMENTCODE,ENTRYBY,ENTRYDATE)");
                    eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(id).append("',");
                    eqry.append("'").append(mp.get("employeeType")).append("','").append(mp.get("staffID")).append("',");
                    eqry.append("'").append(mp.get("departmentCode")).append("','").append(mp.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                    pStmt = dbConnection.prepareStatement(eqry.toString());
                    pStmt.executeUpdate();
                }

            } else {
                for (int x = 0; x < list.size(); x++) {
                    eqry = new StringBuilder();
                    Map mp = (Map) list.get(x);
                    eqry.append("insert into  AP#BOOKDETAIL ( COMPANYID,");
                    eqry.append("BOOKID,STAFFTYPE,STAFFID,DEPARTMENTCODE,ENTRYBY,ENTRYDATE)");
                    eqry.append(" VALUES('").append(mp.get("companyID")).append("','").append(mp.get("bookID")).append("',");
                    eqry.append("'").append(mp.get("employeeType")).append("','").append(mp.get("staffID")).append("',");
                    eqry.append("'").append(mp.get("departmentCode")).append("','").append(mp.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
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
                searchBoxValue = "where (am.BOOKCODE like '%" + hm.get("searchbox") + "%' or am.BOOKTITLE1 like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.BOOKTITL2 like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.BOOKNATURE like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.BOOKREMARKS like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.PUBLICATIONYEAR like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.ACADEMICYEAR like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.APISCORE like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.BOOKCHAPTERNAME like '%" + hm.get("searchbox") + "%')";
            }

            sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (BOOKID) Totalrecord FROM  AP#BOOKMASTER) a,\n"
                    + "  (SELECT *\n"
                    + "  FROM (select nvl(am.BOOKID,'')BOOKID,"
                    + "nvl(am.BOOKCODE,'')BOOKCODE,"
                    + "nvl(am.BOOKTITLE1,'') BOOKTITLE1,"
                    + "nvl(am.BOOKTITL2,'')BOOKTITL2,"
                    + "nvl(am.BOOKNATURE,'')BOOKNATURE,"
                    + "nvl(am.BOOKREMARKS,'')BOOKREMARKS,"
                    + "nvl(am.APISCORE,'')APISCORE,"
                    + "nvl(am.BOOKCHAPTERNAME,'')BOOKCHAPTERNAME,nvl(am.PUBLICATIONYEAR,'')PUBLICATIONYEAR,"
                    + "nvl(am.ACADEMICYEAR,'')ACADEMICYEAR,"
                    + " row_number() over (order by am.BOOKID desc)  R from AP#BOOKMASTER am"
                    + " " + searchBoxValue + ")\n"
                    + " WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
            int k = 1;
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("slno", rs.getString(12));
                data.put("totalrecords", rs.getString(1));
                data.put("bookID", rs.getString(2));
                data.put("bookCode", rs.getString(3));
                data.put("bookTitle1", rs.getString(4));
                data.put("bookTitle2", rs.getString(5));
                data.put("bookNature", rs.getString(6));
                data.put("bookRemarks", rs.getString(7));
                data.put("apiScore", rs.getString(8));
                data.put("bookChapterName", rs.getString(9));
                data.put("publicationYear", rs.getString(10));
                data.put("academicYear", rs.getString(11));
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
        StringBuilder sqry1 =new StringBuilder();
        TreeMap tm = new TreeMap();
        Map SelectData = new HashMap();
        Map SelectData1 = new HashMap();
        int k = 1;
        try {
            sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                    + "nvl(ROLE,'')ROLE,nvl(BOOKCODE,'')BOOKCODE,"
                    + "nvl(BOOKTITLE1,'')BOOKTITLE1,nvl(BOOKTITL2,'')BOOKTITL2,nvl(BOOKNATURE,'')BOOKNATURE,"
                    + "nvl(BOOKREMARKS,'')BOOKREMARKS,"
                    + "nvl(BOOKCHAPTERNAME,'')BOOKCHAPTERNAME,"
                    + "nvl(APISCORE,'')APISCORE,nvl(PUBLICATIONYEAR,'')PUBLICATIONYEAR,nvl(ACADEMICYEAR,'')ACADEMICYEAR from AP#BOOKMASTER");
            sqry.append(" where ").append("BOOKID='").append(hm.get("bookID")).append("'");
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {

                SelectData.put("bookID", hm.get("bookID"));
                SelectData.put("transactionDate", rs.getString(1));
                SelectData.put("role", rs.getString(2));
                SelectData.put("bookCode", rs.getString(3));
                SelectData.put("bookTitle1", rs.getString(4));
                SelectData.put("bookTitle2", rs.getString(5));
                SelectData.put("bookNature", rs.getString(6));
                SelectData.put("bookRemarks", rs.getString(7));
                SelectData.put("chapterName", rs.getString(8));
                SelectData.put("apiScore", rs.getString(9));
                SelectData.put("publicationYear", rs.getString(10));
                SelectData.put("academicYear", rs.getString(11));


            }
            sqry = new StringBuilder();
            sqry.append(" select nvl(AD.STAFFTYPE,'')STAFFTYPE,NVL (AD.STAFFID, '') STAFFID, NVL (vs.EMPLOYEENAME, '') EMPLOYEENAME,"
                    + "NVL(AD.DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(DM.DEPARTMENT,'')DEPARTMENT"
                    + " FROM AP#BOOKDETAIL AD ,V#STAFF VS,DEPARTMENTMASTER DM");
            sqry.append(" where VS.EMPLOYEEID=AD.STAFFID AND DM.DEPARTMENTCODE=AD.DEPARTMENTCODE AND ").append("BOOKID='").append(hm.get("bookID")).append("'");
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData1 = new HashMap();
                SelectData1.put("memberType", rs.getString(1));
                SelectData1.put("choose", rs.getString(1));
                SelectData1.put("memberID", rs.getString(2));
                SelectData1.put("memberName", rs.getString(3));
                SelectData1.put("departmentCode", rs.getString(4));
                SelectData1.put("departmentName", rs.getString(5));
                tm.put(k, SelectData1);
                k++;


            }
            sqry1 = new StringBuilder();
            sqry1.append(" select nvl(AD.STAFFTYPE,'')STAFFTYPE,NVL (AD.STAFFID, '') STAFFID, NVL (SM.STUDENTNAME, '') STUDENTNAME,"
                    + "NVL(AD.DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(DM.DEPARTMENT,'')DEPARTMENT"
                    + " FROM AP#BOOKDETAIL AD ,STUDENTMASTER SM,DEPARTMENTMASTER DM");
            sqry1.append(" where SM.STUDENTID=AD.STAFFID AND DM.DEPARTMENTCODE=AD.DEPARTMENTCODE AND STAFFTYPE='S' AND ").append("BOOKID='").append(hm.get("bookID")).append("'");
            pStmt = dbConnection.prepareStatement(sqry1.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData1 = new HashMap();
                SelectData1.put("memberType", rs.getString(1));
                SelectData1.put("choose", rs.getString(1));
                SelectData1.put("memberID", rs.getString(2));
                SelectData1.put("memberName", rs.getString(3));
                SelectData1.put("departmentCode", rs.getString(4));
                SelectData1.put("departmentName", rs.getString(5));
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
            String qry1 = "delete from AP#BOOKDETAIL where BOOKID = '" + hm.get("bookID") + "'";
            st.addBatch(qry1);
            String qry2 = "delete from AP#BOOKMASTER where BOOKID = '" + hm.get("bookID") + "'";
            st.addBatch(qry2);
            st.executeBatch();

        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return new HashMap();
    }
}
