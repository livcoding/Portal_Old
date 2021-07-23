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
public class PatentTransactionReportDB {
     private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    public PatentTransactionReportDB() {
        dbConnection = DBUtility.getConnection();
    }

    private enum scase {

        generateReport
    }

    public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {
            });

            switch (PatentTransactionReportDB.scase.valueOf((String) hm.get("handller").toString())) {
                case generateReport:
                    responseString = mapper.writeValueAsString(generateReport(hm));
                    break;
               

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
    
    private Map generateReport(Map hm) {
        Map data = new HashMap();
        TreeMap tm = new TreeMap();
        String searchBoxValue = "";
        StringBuilder sqry = new StringBuilder();
        try {
            

            sqry.append("SELECT NVL(VS.EMPLOYEENAME,'')EMPLOYEENAME,NVL(AM.PATENTTITLE,'')PATENTTITLE,");
            sqry.append("NVL(AM.PATENTTYPE,'')PATENTTYPE,to_char(AM.PATENTFILINGDATE,'dd-mm-yyyy')PATENTFILINGDATE,");
            sqry.append("NVL(AM.PATENTSTATUS,'')PATENTSTATUS,NVL(AM.APISCORE,'')APISCORE");
            sqry.append(" FROM AP#PATENTMASTER AM,AP#PATENTDETAIL AD,V#STAFF VS WHERE");
            sqry.append(" AM.COMPANYID=AD.COMPANYID AND AM.APCATEGORYID=AD.APCATEGORYID");
            sqry.append(" AND AM.APEVENTID=AD.APEVENTID AND AM.APFORMID=AD.APFORMID AND ");
            sqry.append("AM.PATENTID=AD.PATENTID AND VS.EMPLOYEEID=AD.STAFFID AND AD.DEPARTMENTCODE='"+hm.get("department")+"' ");
            sqry.append("AND AM.COMPANYID='"+hm.get("company")+"' AND AM.PATENTFILINGDATE BETWEEN to_date('"+hm.get("startdate")+"','dd-mm-yyyy') AND to_date('"+hm.get("enddate")+"','dd-mm-yyyy')");
            sqry.append(" AND AM.PATENTVALIDTILLDATE BETWEEN to_date('"+hm.get("startdate")+"','dd-mm-yyyy') AND to_date('"+hm.get("enddate")+"','dd-mm-yyyy')");
            int k = 1;
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("employeeName", rs.getString(1));
                data.put("patentTitle", rs.getString(2));
                data.put("patentType", rs.getString(3));
                data.put("patentFilingDate", rs.getString(4));
                data.put("patentStatus", rs.getString(5));
                data.put("apiScore", rs.getString(6));
                tm.put(k, data);
                k++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
}
