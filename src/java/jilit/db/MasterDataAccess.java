/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import jdbc.DBUtility;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author Mohit.sharma
 */
public class MasterDataAccess {

    private Connection dbConnection;
    private PreparedStatement pStmt;
    private ResultSet rs;

    public MasterDataAccess() {
        dbConnection = DBUtility.getConnection();
    }

    private enum scase {

        saveupdate, select, Delete, SelectforUpdate,chkUniqueValue
    }

    public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String reponcestring = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {
            });

            switch (scase.valueOf((String) hm.get("handller").toString())) {
                case saveupdate:
                    reponcestring = mapper.writeValueAsString(SaveUpdateData(hm));
                    break;
                case select:
                    reponcestring = mapper.writeValueAsString(getSelectData(hm));
                    break;
                case Delete:
                    reponcestring = mapper.writeValueAsString(getDeleteData(hm));
                    break;
                case SelectforUpdate:
                    reponcestring = mapper.writeValueAsString(selectForUpdate(hm));
                    break;
                case chkUniqueValue:
                    reponcestring = mapper.writeValueAsString(chkUniqueValue(hm));
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reponcestring;
    }

    private Map SaveUpdateData(Map hm) {
        StringBuffer sqry = new StringBuffer();
        StringBuffer eqry = new StringBuffer();
        Map tablehm = (HashMap) hm.get("para");
        String id = "";

        try {
            List li = (ArrayList) tablehm.get("column");
            if (tablehm.get(li.get(0)).equals("0")) {

                pStmt = dbConnection.prepareStatement("select  substr('" + tablehm.get("tablename").toString() + "',4,6) || lpad( nvl( substr(max(" + li.get(0) + "),7) ,0 )+1,14,0)id from  " + tablehm.get("tablename").toString());
                rs = pStmt.executeQuery();
                if (rs.next()) {
                    id = rs.getString("id");
                }
                sqry.append("INSERT INTO ").append(tablehm.get("tablename").toString()).append("(");
                sqry.append(li.get(0));
                eqry.append(") VALUES ('" + id + "'");
                for (int i = 1; i < li.size(); i++) {
                    if(li.get(i).equals("entrydate")){
                    sqry.append("," + li.get(i));
                    eqry.append(","+tablehm.get(li.get(i)) +""); 
                    }else{
                    sqry.append("," + li.get(i));
                    eqry.append(",'" + tablehm.get(li.get(i)) + "'");
                    }
                }
                eqry.append(")");
            } else {
                sqry.append("UPDATE " + tablehm.get("tablename").toString() + " set ");
                sqry.append(li.get(1) + "='" + tablehm.get(li.get(1)) + "'");
                for (int i = 2; i < li.size(); i++) {
                    if(li.get(i).equals("entrydate")){
                    sqry.append("," + li.get(i) + "=" + tablehm.get(li.get(i)) + "");  
                    }else{
                    sqry.append("," + li.get(i) + "='" + tablehm.get(li.get(i)) + "'");
                    }
                }
                sqry.append(" where " + li.get(0) + "='" + tablehm.get(li.get(0)) + "'");

            }
            String qry = sqry.append(eqry).toString();
            pStmt = dbConnection.prepareStatement(qry);
            pStmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }

        return new HashMap();
    }

    private Map getSelectData(Map hm) {
        Map tablehm = (HashMap) hm.get("para");
        Map reqcol = (HashMap) tablehm.get("gridcolumn");
        Map finaldata = new HashMap();
        StringBuffer sqry = new StringBuffer();
        Map datarow = null;
        List datalist = new ArrayList();
        List dataorderlist = new ArrayList();

        try {
            List li = (ArrayList) tablehm.get("column");
            if (!li.isEmpty()) {
                sqry.append(" SELECT   a.*, B.* ");
                sqry.append(" FROM   (SELECT   COUNT(DISTINCT " + li.get(0) + ") Totalrecord ");
                sqry.append(" FROM   " + tablehm.get("tablename").toString() + ") a, ");
                sqry.append(" (SELECT   * ");
                sqry.append(" FROM   (SELECT   M." + li.get(0) + " ");
                for (Object key : reqcol.keySet()) {
                    sqry.append(",M." + key.toString());
                }
                sqry.append(",ROWNUM R");
                sqry.append(" FROM   " + tablehm.get("tablename").toString() + " M ");
                sqry.append(" where ( 1=2   ");
                for (Object key : reqcol.keySet()) {
                    sqry.append(" OR UPPER(M." + key.toString() + ") LIKE upper('%" + tablehm.get("searchbox").toString() + "%')");
                }
                sqry.append("  )");
                sqry.append(") WHERE   r >"+tablehm.get("spg")+" AND r <= "+tablehm.get("epg")+") b ");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    datarow = new HashMap();
                    datarow.put(li.get(0).toString(), rs.getString(li.get(0).toString()));
                    datarow.put("sno", rs.getString("R"));
                    for (Object key : reqcol.keySet()) {
                        datarow.put(key.toString(), rs.getString(key.toString()));
                        finaldata.put("totalrecords", rs.getString("Totalrecord"));
                    }
                    datalist.add(datarow);
                }
            }
            finaldata.put("gridrowdata", datalist);
            for (int j = 0; j < li.size(); j++) {
                if (reqcol.containsKey((li.get(j)))) {
                    dataorderlist.add(li.get(j).toString());
                }
            }
            finaldata.put("gridheaderorder", dataorderlist);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return finaldata;
    }

    private Map getDeleteData(Map hm) {
        try {
            String Querry = " delete from " + hm.get("tablename") + " where " + hm.get("Colname") + " = '" + hm.get("id") + "' ";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new HashMap();
    }

    private Map selectForUpdate(Map hm) {
        StringBuffer sqry = new StringBuffer();
        Map SelectData = new HashMap();
        try {
            List li = (ArrayList) hm.get("Colname");
            if (!li.isEmpty()) {
                sqry.append(" SELECT   " + li.get(0) + " ");
                for (int i = 1; i < li.size(); i++) {
                    if(li.get(i).equals("entrydate"))
                    {
                        continue;
                    }
                    sqry.append("," + li.get(i));
                }
                sqry.append(" FROM   " + hm.get("tablename").toString() + "  ");
                sqry.append(" where  " + li.get(0) + "= '" + hm.get("id") + "' ");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                    for (int i = 0; i <li.size(); i++) {
                        if(li.get(i).equals("entrydate"))
                    {
                        continue;
                    }
                        SelectData.put(li.get(i).toString(), rs.getString(li.get(i).toString()));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SelectData;
    }
    private Map chkUniqueValue(Map hm) {
        StringBuffer sqry = new StringBuffer();
        Map SelectData = new HashMap();
        SelectData.put("col",hm.get("Colname"));
        try {
                sqry.append(" select count(*) su from "+hm.get("tablename")+"  where  UPPER("+hm.get("Colname")+")= UPPER('"+hm.get("Colnameval")+"') and "+hm.get("id")+"<>'"+hm.get("idval")+"' ");
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
                while (rs.next()) {
                   SelectData.put("success", rs.getString("su"));
                }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SelectData;
    }
}
