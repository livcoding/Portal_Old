/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class IndustrialInteractionsFeedbackDB {

    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;

    public IndustrialInteractionsFeedbackDB() {
        dbConnection = DBUtility.getConnection();
    }

    private enum scase {

        selectHeadingInfo, saveupdate, select, Delete, SelectforUpdate, chkUniqueValue
    }

    public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {
            });

            switch (IndustrialInteractionsFeedbackDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectHeadingInfo:

                    responseString = mapper.writeValueAsString(selectHeadingInfo(hm));
                    break;
                case saveupdate:
                    responseString = SaveUpdateData(hm);
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
                case chkUniqueValue:
//                    reponcestring = mapper.writeValueAsString(chkUniqueValue(hm));
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }

    private String SaveUpdateData(Map hm) {
        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        Map tablehm = (HashMap) hm.get("para");
        String transactionIDCount = "";
        try {

            String countQuery = "select count(transactionid) from ap#psaindustrialfeedback where transactionid='" + tablehm.get("transactionID") + "'";
            pStmt = dbConnection.prepareStatement(countQuery);
            rs = pStmt.executeQuery();
            if (rs.next()) {
                transactionIDCount = rs.getString(1);
            }


            if (transactionIDCount.equals("0")) {
                eqry.append("insert into  AP#PSAINDUSTRIALFEEDBACK ( COMPANYID,INSTITUTEID,TRANSACTIONID,TRANSACTIONDATE,");
                eqry.append("DEPARTMENTCODE,PSAPROGRAMTYPE,PSAPROGRAMTITLE,PSASTARTDATE,");
                eqry.append("PSAENDDATE,PSAGUESTSPEAKERFEEDBACK,PSAGUESTPARTICIPANTSFEEDBACK,");
                eqry.append("PSAINDUSTRIALVISITFEEDBACK,PSAINDPARTICIPANTSFEEDBACK,PSAINDUSTRYFEEDBACK,");
                eqry.append("PSAINDUSTRIALSUGGESTIONS,PSAOVERALLPROJECTFEEDBACK,PSAPICOPIFEEDBACK,PSAPROJECTSUGGESTIONS,");
                eqry.append("PSAINDLEDINSTRUCTORFEEDBACK,PSAINDLEDPARTICIPANTFEEDBACK,PSARESOURCEPERSONFEEDBACK,PSAINDLEDSUGGESTIONS,PSAREMARKS,ENTRYBY,ENTRYDATE)");
                eqry.append(" VALUES('").append(tablehm.get("companyid")).append("','").append(tablehm.get("instituteid")).append("','").append(tablehm.get("transactionID")).append("',to_date('").append(tablehm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(getDepartmentCode(tablehm.get("departmentName").toString().replaceAll("@@@", "&"))).append("',");
                eqry.append("'").append(tablehm.get("programType").toString()).append("','").append(tablehm.get("titleOfTheProgram")).append("',to_date('").append(tablehm.get("startDate")).append("','dd-mm-yyyy'),to_date('").append(tablehm.get("endDate")).append("','dd-mm-yyyy'),");
                eqry.append("'").append(tablehm.get("speakerFeedback")).append("','").append(tablehm.get("guestParticipantsFeedback")).append("',");
                eqry.append("'").append(tablehm.get("industrialVisitFeedback")).append("','").append(tablehm.get("feedbackOfParticipants")).append("',");
                eqry.append("'").append(tablehm.get("feedbackOfIndustry")).append("','").append(tablehm.get("industrialSuggestions")).append("',");
                eqry.append("'").append(tablehm.get("overallProjectFeedback")).append("','").append(tablehm.get("feedbackOfPICOPI")).append("',");
                eqry.append("'").append(tablehm.get("projectSuggestions")).append("','").append(tablehm.get("instructorFeedback")).append("',");
                eqry.append("'").append(tablehm.get("industryLedParticipantsFeedback")).append("','").append(tablehm.get("resourcePersonFeedback")).append("',");
                eqry.append("'").append(tablehm.get("industryLedSuggestions")).append("','").append(tablehm.get("remarks")).append("','").append(hm.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
            } else {
                sqry.append("Update AP#PSAINDUSTRIALFEEDBACK set COMPANYID='").append(tablehm.get("companyid"));
                sqry.append("',INSTITUTEID='").append(tablehm.get("instituteid"));
                sqry.append("',TRANSACTIONDATE=to_date('").append(tablehm.get("transactionDate")).append("','dd-mm-yyyy')");
                sqry.append(",DEPARTMENTCODE='").append(getDepartmentCode(tablehm.get("departmentName").toString().replaceAll("@@@", "&")));
                sqry.append("',PSAPROGRAMTYPE='").append(tablehm.get("programType").toString());
                sqry.append("',PSAPROGRAMTITLE='").append(tablehm.get("titleOfTheProgram"));
                sqry.append("',PSASTARTDATE=to_date('").append(tablehm.get("startDate")).append("','dd-mm-yyyy')");
                sqry.append(",PSAENDDATE=to_date('").append(tablehm.get("endDate")).append("','dd-mm-yyyy')");
                sqry.append(",PSAGUESTSPEAKERFEEDBACK='").append(tablehm.get("speakerFeedback"));
                sqry.append("',PSAGUESTPARTICIPANTSFEEDBACK='").append(tablehm.get("guestParticipantsFeedback"));
                sqry.append("',PSAINDUSTRIALVISITFEEDBACK='").append(tablehm.get("industrialVisitFeedback"));
                sqry.append("',PSAINDPARTICIPANTSFEEDBACK='").append(tablehm.get("feedbackOfParticipants"));
                sqry.append("',PSAINDUSTRYFEEDBACK='").append(tablehm.get("feedbackOfIndustry"));
                sqry.append("',PSAINDUSTRIALSUGGESTIONS='").append(tablehm.get("industrialSuggestions"));
                sqry.append("',PSAOVERALLPROJECTFEEDBACK='").append(tablehm.get("overallProjectFeedback"));
                sqry.append("',PSAPICOPIFEEDBACK='").append(tablehm.get("feedbackOfPICOPI"));
                sqry.append("',PSAPROJECTSUGGESTIONS='").append(tablehm.get("projectSuggestions"));
                sqry.append("',PSAINDLEDINSTRUCTORFEEDBACK='").append(tablehm.get("instructorFeedback"));
                sqry.append("',PSAINDLEDPARTICIPANTFEEDBACK='").append(tablehm.get("industryLedParticipantsFeedback"));
                sqry.append("',PSARESOURCEPERSONFEEDBACK='").append(tablehm.get("resourcePersonFeedback"));
                sqry.append("',PSAINDLEDSUGGESTIONS='").append(tablehm.get("industryLedSuggestions"));
                sqry.append("',PSAREMARKS='").append(tablehm.get("remarks")).append("'");
                sqry.append(",ENTRYBY='").append(hm.get("entryBy")).append("'");
                sqry.append(",ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM')");
                sqry.append(" where TRANSACTIONID='").append(tablehm.get("transactionID")).append("'");
            }

            String qry = sqry.append(eqry).toString();
            pStmt = dbConnection.prepareStatement(qry);
            pStmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }


        return "";
    }

    private Map selectHeadingInfo(Map hm) {
        StringBuilder sqry = new StringBuilder();
        Map SelectData = new HashMap();
        try {


            sqry.append("select to_char(aid.transactiondate,'dd-mm-yyyy')transactiondate,");
            sqry.append("nvl(dm.department,'')department,");
            sqry.append("nvl(aif.psaprogramtitle,'')programtitle,");
            sqry.append("nvl(aif.psaprogramtype,'')programtype,");
            sqry.append("to_char(aif.psastartdate,'dd-mm-yyyy')startdate,");
            sqry.append("to_char(aif.psaenddate,'dd-mm-yyyy')enddate,");
            sqry.append("nvl(aif.PSAGUESTSPEAKERFEEDBACK,'')PSAGUESTSPEAKERFEEDBACK,");
            sqry.append("nvl(aif.PSAGUESTPARTICIPANTSFEEDBACK,'')PSAGUESTPARTICIPANTSFEEDBACK,");
            sqry.append("nvl(aif.PSAINDUSTRIALVISITFEEDBACK,'')PSAINDUSTRIALVISITFEEDBACK,");
            sqry.append("nvl(aif.PSAINDPARTICIPANTSFEEDBACK,'')PSAINDPARTICIPANTSFEEDBACK,");
            sqry.append("nvl(aif.PSAINDUSTRYFEEDBACK,'')PSAINDUSTRYFEEDBACK,");
            sqry.append("nvl(aif.PSAINDUSTRIALSUGGESTIONS,'')PSAINDUSTRIALSUGGESTIONS,");
            sqry.append("nvl(aif.PSAOVERALLPROJECTFEEDBACK,'')PSAOVERALLPROJECTFEEDBACK,");
            sqry.append("nvl(aif.PSAPICOPIFEEDBACK,'')PSAPICOPIFEEDBACK,");
            sqry.append("nvl(aif.PSAPROJECTSUGGESTIONS,'')PSAPROJECTSUGGESTIONS,");
            sqry.append("nvl(aif.PSAINDLEDINSTRUCTORFEEDBACK,'')PSAINDLEDINSTRUCTORFEEDBACK,");
            sqry.append("nvl(aif.PSAINDLEDPARTICIPANTFEEDBACK,'')PSAINDLEDPARTICIPANTFEEDBACK, ");
            sqry.append("nvl(aif.PSARESOURCEPERSONFEEDBACK,'')PSARESOURCEPERSONFEEDBACK, ");
            sqry.append("nvl(aif.PSAINDLEDSUGGESTIONS,'')PSAINDLEDSUGGESTIONS,");
            sqry.append("nvl(aif.PSAREMARKS,'')PSAREMARKS ");
            sqry.append("from ap#psaindustrialdetails aid left join departmentmaster dm on dm.departmentcode=aid.departmentcode left join ap#psaindustrialfeedback aif on ");
            sqry.append("  aid.companyid=aif.companyid and aid.instituteid=aif.instituteid");
            sqry.append(" and aid.transactionid=aif.transactionid and aid.transactiondate=aif.transactiondate and aid.departmentcode=aif.departmentcode");
            sqry.append(" where aid.transactionid='" + hm.get("transactionID") + "'");


            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {

                SelectData.put("transactionID", hm.get("transactionID"));
                SelectData.put("transactionDate", rs.getString(1));
                SelectData.put("programTitle", rs.getString(3));
                SelectData.put("programType", rs.getString(4));
                SelectData.put("startDate", rs.getString(5));
                SelectData.put("endDate", rs.getString(6));
                SelectData.put("speakerFeedback", rs.getString(7));
                SelectData.put("guestParticipantsFeedback", rs.getString(8));
                SelectData.put("industrialVisitFeedback", rs.getString(9));
                SelectData.put("feedbackOfParticipants", rs.getString(10));
                SelectData.put("feedbackOfIndustry", rs.getString(11));
                SelectData.put("industrialSuggestions", rs.getString(12));
                SelectData.put("overallProjectFeedback", rs.getString(13));
                SelectData.put("feedbackOfPICOPI", rs.getString(14));
                SelectData.put("projectSuggestions", rs.getString(15));
                SelectData.put("instructorFeedback", rs.getString(16));
                SelectData.put("industryLedParticipantsFeedback", rs.getString(17));
                SelectData.put("resourcePersonFeedback", rs.getString(18));
                SelectData.put("industryLedSuggestions", rs.getString(19));
                SelectData.put("remarks", rs.getString(20));
                SelectData.put("department", rs.getString(2));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return SelectData;
    }

    public String getProgramType(String programType) {
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

    public String getDepartmentCode(String department) {
        String departmentCode = "";
        try {
            String qry = "select departmentcode from departmentmaster where department='" + department + "'";
            pStmt = dbConnection.prepareStatement(qry);
            rs = pStmt.executeQuery();
            if (rs.next()) {
                departmentCode = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();;
        }
        return departmentCode;
    }

    private Map getSelectData(Map hm) {
        Map data = new HashMap();
        TreeMap tm = new TreeMap();
        String searchBoxValue = "";
        StringBuffer sqry = new StringBuffer();
        try {
            if (!hm.get("searchbox").equals("")) {
                searchBoxValue = "and (aif.transactionid like '%" + hm.get("searchbox") + "%' or aif.transactiondate like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or dm.department like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or aif.psaprogramtitle like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or aif.psastartdate like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or aif.psaenddate like '%" + hm.get("searchbox") + "%')";
            }

            sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (transactionid) Totalrecord FROM  ap#psaindustrialfeedback) a,\n"
                    + "  (SELECT *\n"
                    + "  FROM (select nvl(aif.transactionid,'')transactionid,"
                    + "to_char(aif.transactiondate,'dd-mm-yyyy')transactiondate,"
                    + "nvl(dm.department,'')department,"
                    + "nvl(aif.psaprogramtitle,'') programtitle,"
                    + "nvl(aif.psaprogramtype,'')psaprogramtype,"
                    + "to_char(aif.PSASTARTDATE,'dd-mm-yyyy')PSASTARTDATE,"
                    + "to_char(aif.PSAENDDATE,'dd-mm-yyyy')PSAENDDATE,"
                    + "row_number() over (order by aif.transactionid desc)  R from ap#psaindustrialfeedback aif,departmentmaster dm"
                    + " where dm.departmentcode=aif.departmentcode  "+searchBoxValue+")\n"
                    + "         WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
            int k = 1;
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("slno", rs.getString(9));
                data.put("totalrecords", rs.getString(1));
                data.put("transactionID", rs.getString(2));
                data.put("transactionDate", rs.getString(3));
                data.put("department", rs.getString(4));
                data.put("programTitle", rs.getString(5));
                data.put("programType", rs.getString(6));
                data.put("startDate", rs.getString(7));
                data.put("endDate", rs.getString(8));
                tm.put(k, data);
                k++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (tm.isEmpty()) {
            tm.put("0", "0");
        }
        return tm;

    }

    private Map selectForUpdate(Map hm) {
        StringBuffer sqry = new StringBuffer();
        Map SelectData = new HashMap();
        try {


            sqry.append(" select nvl(aif.TRANSACTIONID,'')TRANSACTIONID,");
            sqry.append("to_char(aif.TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,");
            sqry.append("nvl(aif.DEPARTMENTCODE,'')DEPARTMENTCODE,");
            sqry.append("nvl(aif.PSAPROGRAMTYPE,'')PSAPROGRAMTYPE,");
            sqry.append("nvl(aif.PSAPROGRAMTITLE,'')PSAPROGRAMTITLE,");
            sqry.append("to_char(aif.PSASTARTDATE,'dd-mm-yyyy')PSASTARTDATE,");
            sqry.append("to_char(aif.PSAENDDATE,'dd-mm-yyyy')PSAENDDATE,");
            sqry.append("nvl(aif.PSAGUESTSPEAKERFEEDBACK,'')PSAGUESTSPEAKERFEEDBACK,");
            sqry.append("nvl(aif.PSAGUESTPARTICIPANTSFEEDBACK,'')PSAGUESTPARTICIPANTSFEEDBACK,");
            sqry.append("nvl(aif.PSAINDUSTRIALVISITFEEDBACK,'')PSAINDUSTRIALVISITFEEDBACK,");
            sqry.append("nvl(aif.PSAINDPARTICIPANTSFEEDBACK,'')PSAINDPARTICIPANTSFEEDBACK,");
            sqry.append("nvl(aif.PSAINDUSTRYFEEDBACK,'')PSAINDUSTRYFEEDBACK,");
            sqry.append("nvl(aif.PSAINDUSTRIALSUGGESTIONS,'')PSAINDUSTRIALSUGGESTIONS,");
            sqry.append("nvl(aif.PSAOVERALLPROJECTFEEDBACK,'')PSAOVERALLPROJECTFEEDBACK,");
            sqry.append("nvl(aif.PSAPICOPIFEEDBACK,'')PSAPICOPIFEEDBACK,");
            sqry.append("nvl(aif.PSAPROJECTSUGGESTIONS,'')PSAPROJECTSUGGESTIONS,");
            sqry.append("nvl(aif.PSAINDLEDINSTRUCTORFEEDBACK,'')PSAINDLEDINSTRUCTORFEEDBACK,");
            sqry.append("nvl(aif.PSAINDLEDPARTICIPANTFEEDBACK,'')PSAINDLEDPARTICIPANTFEEDBACK,");
            sqry.append("nvl(aif.PSARESOURCEPERSONFEEDBACK,'')PSARESOURCEPERSONFEEDBACK,");
            sqry.append("nvl(aif.PSAINDLEDSUGGESTIONS,'')PSAINDLEDSUGGESTIONS,");
            sqry.append("nvl(aif.PSAREMARKS,'')PSAREMARKS");
            sqry.append(" from AP#PSAINDUSTRIALFEEDBACK aif");
            sqry.append(" where aif.transactionid='").append(hm.get("transactionID")).append("'");


            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {

                SelectData.put("transactionID", rs.getString(1));
                SelectData.put("transactionDate", rs.getString(2));
                
                SelectData.put("programType", rs.getString(4));
                SelectData.put("programTitle", rs.getString(5));
                SelectData.put("startDate", rs.getString(6));
                SelectData.put("endDate", rs.getString(7));
                SelectData.put("speakerFeedback", rs.getString(8));
                SelectData.put("guestParticipantsFeedback", rs.getString(9));
                SelectData.put("industrialVisitFeedback", rs.getString(10));
                SelectData.put("feedbackOfParticipants", rs.getString(11));
                SelectData.put("feedbackOfIndustry", rs.getString(12));
                SelectData.put("industrialSuggestions", rs.getString(13));
                SelectData.put("overallProjectFeedback", rs.getString(14));
                SelectData.put("feedbackOfPICOPI", rs.getString(15));
                SelectData.put("projectSuggestions", rs.getString(16));
                SelectData.put("instructorFeedback", rs.getString(17));
                SelectData.put("industryLedParticipantsFeedback", rs.getString(18));
                SelectData.put("resourcePersonFeedback", rs.getString(19));
                SelectData.put("industryLedSuggestions", rs.getString(20));
                SelectData.put("remarks", rs.getString(21));
                SelectData.put("department", getDepartmentName(rs.getString(3)));


            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return SelectData;
    }

    private Map getDeleteData(Map hm) {
        try {
            String Querry = " delete from AP#PSAINDUSTRIALFEEDBACK where transactionid = '" + hm.get("transactionID") + "'";
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new HashMap();
    }
    
    public String getDepartmentName(String department) {
        String departmentCode = "";
        try {
            String qry = "select department from departmentmaster where departmentcode='" + department + "'";
            pStmt = dbConnection.prepareStatement(qry);
            rs = pStmt.executeQuery();
            if (rs.next()) {
                departmentCode = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();;
        }
        return departmentCode;
    }

}
