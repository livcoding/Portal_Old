/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdbc.DBUtility;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import tietwebkiosk.IQACconnection;

/**
 *
 * @author nipun.gupta
 */
public class FeedbackTransactionDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private ResultSet rs;
    IQACconnection db=new IQACconnection();

    public FeedbackTransactionDB() {
        //dbConnection = DBUtility.getConnection();
    }

     private enum scase {
        saveupdate, select, Delete, SelectforUpdate,chkUniqueValue
    }

    public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String reponcestring = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {});

            switch (FeedbackTransactionDB.scase.valueOf((String) hm.get("handller").toString())) {
               case saveupdate:
                  reponcestring = mapper.writeValueAsString(SaveUpdateData(hm));
                    break;
                case select:
                    reponcestring = mapper.writeValueAsString(getSelectData(hm));
                    break;
//                case Delete:
//                    reponcestring = mapper.writeValueAsString(getDeleteData(hm));
//                    break;
//                case SelectforUpdate:
//                    reponcestring = mapper.writeValueAsString(selectForUpdate(hm));
//                    break;
//                case chkUniqueValue:
//                    reponcestring = mapper.writeValueAsString(chkUniqueValue(hm));
//                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reponcestring;
    }

   private String SaveUpdateData(Map hm)
   {
        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        Map tablehm = (HashMap) hm.get("para");
        Map tablegrid = (HashMap) hm.get("grid");
         String id = "";
        try{
        rs=db.getRowset("SELECT SUBSTR ('AP#FACULTYFEEDBACKHEADER', 4, 6) || LPAD (NVL (SUBSTR (MAX (transactionid), 7), 0) + 1, 14, 0)  id FROM AP#FACULTYFEEDBACKHEADER");
        //rs = pStmt.executeQuery();
                if (rs.next()) {
                    id = rs.getString("id");
                }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        eqry.append("insert into  AP#FACULTYFEEDBACKHEADER ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
        eqry.append("APFEEDBACKID,APFACULTYID,APACADEMICYEAR,DEPARTMENTCODE,PROGRAMCODE,APSEMESTER,APFEEDBACKCOUNT)");
        eqry.append(" VALUES('"+tablehm.get("companyid")+"','"+tablehm.get("instituteid")+"','"+id+"',to_date('"+tablehm.get("transactionDate")+"','dd-mm-yyyy'),'"+tablehm.get("feedbackcode")+"',");
        eqry.append("'"+tablehm.get("facultycode")+"','"+tablehm.get("academicyear")+"','"+tablehm.get("departmentcode")+"','"+tablehm.get("coursecode")+"',");
        eqry.append("'"+tablehm.get("semester")+"','"+tablehm.get("feedbackcount")+"')");
        try {
        db.insertRow(eqry.toString());
        // pStmt.executeQuery();
         }catch(Exception e)
         {
             e.printStackTrace();
         }

        for(Object key:tablegrid.keySet()){
            Map m = (HashMap)tablegrid.get(key.toString());
           sqry = new StringBuilder();
      // if(m.get("checkbox").equals("Y")){
        sqry.append("INSERT INTO AP#FACULTYFEEDBACKDETAIL ( COMPANYID, INSTITUTEID, TRANSACTIONID, APFEEDBACKID,");
        sqry.append(" APFEEDBACKITEMID, APFEEDBACKITEMREMARKS, APFEEDBACKRATING,APFEEDBACKUSERREMARKS");
        sqry.append(" ) VALUES ( '"+tablehm.get("companyid")+"', '"+tablehm.get("instituteid")+"', '"+id+"', ");
        sqry.append("'"+tablehm.get("feedbackcode")+"','"+m.get("feedbackitemid")+"', '"+tablehm.get("remarks")+"', '"+m.get("Rating")+"','"+m.get("userremarks")+"'");
    //    + "'"+tablehm.get("Ratting")+"','"+tablehm.get("feedbackcode")+"',"
        sqry.append(" )");
         try {
         db.insertRow(sqry.toString());
         //pStmt.executeQuery();
         }catch(Exception e)
         {
             e.printStackTrace();
         }


   }
    return "";
   }



      private Map getSelectData(Map hm) {
        Map data = new HashMap();
        Map datahm=(HashMap)hm.get("para");
          TreeMap tm = new TreeMap();
          StringBuffer sqry = new StringBuffer();
        try {
            sqry.append("SELECT NVL (FM.apfeedbackitemid, ' ')");
            sqry.append(" apfeedbackitemid,NVL (FM.apfeedbackitemcode, ' ') "
                    + "apfeedbackitemcode, NVL (FM.apfeedbackitemdescription, ' ') "
                    + "apfeedbackitemdescription,"
                    + "nvl(FM.apfeedbackremarks,' ')apfeedbackremarks,nvl(FD.FEEDBACKREMARKS,' ')FEEDBACKREMARKS  "
                    + "FROM ap#feedbackitemmaster "
                    + "FM,AP#FACULTYFEEDBACKDETAIL FD,AP#FACULTYFEEDBACKHEADER FH "
                    + "WHERE FM.apfeedbackid = '"+datahm.get("feedbackcode")+"' "
                    + " and FM.APFEEDBACKID=FD.FEEDBACKID "
                    + "and FM.INSTITUTEID=FD.INSTITUTECODE "
                    + "and FM.COMPANYID=FD.COMPANYCODE "
                    + "and FM.APFEEDBACKID=FH.APFEEDBACKID "
                    + "and FM.INSTITUTEID=FH.INSTITUTEID "
                    + "and FM.COMPANYID=FH.COMPANYID and FD.TRANSID=FH.TRANSACTIONID");


            int k=1;
              rs=db.getRowset(sqry.toString());
                while (rs.next()) {
                     data = new HashMap();
                  data.put("slno",k);
                  data.put("feedbackitemid", rs.getString(1));
                  data.put("ItemCode", rs.getString(2));
                  data.put("ItemDesc", rs.getString(3));
                  data.put("itemremarks", rs.getString(4));
                  data.put("userremarks", rs.getString(5));
                 // data.put("userremark", );


                  tm.put(k, data);
                  k++;
                }


        } catch (Exception e) {
            e.printStackTrace();
        }finally{
        if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    //Logger.getLogger(FeedbackTransactionDB.class.getName()).log(Level.SEVERE, null, ex);
                }
        }
        }
        return tm;
    }

}