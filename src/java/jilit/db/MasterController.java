/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import jilit.html.CommonHtmlComponent;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author Mohit.sharma
 */
public class MasterController {

    private enum mcase {

        categorymaster, equipmentmaster, publicationtypemaster, publicationmaster,
        indexingbodymaster, feedbackmaster, feedbackratingmaster, calendermaster, formmaster, formtransaction,feedbackheader,feedbacktransaction,facultyfeedbackmaster
    }

    public String getCommonmasterDesign(String jdata) {
        Map hm = new HashMap();
        String reponcestring = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap<String, String>>() {
            });

            switch (mcase.valueOf((String) hm.get("menuid").toString())) {
                case categorymaster:
                    reponcestring = mapper.writeValueAsString(getCategorymasterData());
                    break;
                case equipmentmaster:
                    reponcestring = mapper.writeValueAsString(getEquipmentmasterData());
                    break;
                case publicationtypemaster:
                    reponcestring = mapper.writeValueAsString(getPublicationtypemasterData());
                    break;
                case publicationmaster:
                    reponcestring = mapper.writeValueAsString(getPublicationmasterData());
                    break;
                case indexingbodymaster:
                    reponcestring = mapper.writeValueAsString(getIndexingbodtmasterData());
                    break;
                case feedbackmaster:
                    reponcestring = mapper.writeValueAsString(getFeedbackmasterData());
                    break;
                case feedbackratingmaster:
                    reponcestring = mapper.writeValueAsString(getFeedbackRatingmasterData());
                    break;
                case calendermaster:
                    reponcestring = mapper.writeValueAsString(getCalendermasterData());
                    break;
                case formmaster:
                    reponcestring = mapper.writeValueAsString(getFormmasterData());
                    break;
                case formtransaction:
                    reponcestring = mapper.writeValueAsString(getFormTransData());
                    break;
                case feedbackheader:
                    reponcestring = mapper.writeValueAsString(getFeedbackheader());
                    break;
                case feedbacktransaction:
                    reponcestring = mapper.writeValueAsString(getfeedbacktransaction());
                    break;
                case facultyfeedbackmaster:
                    reponcestring = mapper.writeValueAsString(getfacultyfeedbackmaster());
                    break;
                    
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reponcestring;
    }
    //Category Master
    private Map getCategorymasterData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            /////////////////////////////////////////////////
            cmap.put("tablename", "AP#CATEGORYMASTER");
            //cmap.put("column", mapper.readValue("[\"apcategoryid\",\"instituteid\",\"companyid\",\"apcategorycode\",\"apcategorydescription\",\"apcategoryremarks\",\"apcategorytype\",\"deactive\"]", new TypeReference<ArrayList>() {
            cmap.put("column", mapper.readValue("[\"apcategoryid\",\"companyid\",\"apcategorycode\",\"apcategorydescription\",\"apcategoryremarks\",\"apcategorytype\",\"deactive\",\"entryby\",\"entrydate\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("apcategoryid", "apcategoryid", "textbox", "20", "0", "", "", "hidden", ""))));
            //tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Category Code", "Y")) + chc.td_with_style(chc.inputBox("apcategorycode", "apcategorycode", "textbox", "20", "", "Category Code", "", "text", "onblur='getUniqueValue(3)'"))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Category Description", "Y")) + chc.td(chc.inputBox("apcategorydescription", "apcategorydescription", "textbox", "100", "", "Category Description", "width:800px", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Category Remarks", "Y")) + chc.td(chc.inputBox("apcategoryremarks", "apcategoryremarks", "textbox", "30", "", "Category Remarks", "width:800px", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Category Type", "Y")) + chc.td_with_style(chc.comboBox("apcategorytype", "apcategorytype", "combo", "Category Type", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Active", "N")) + chc.td_with_style(chc.checkBox("deactive", "deactive", "chkbox", "N", "", "Y"))));
            cmap.put("required", mapper.readValue("[\"apcategorycode\",\"apcategorydescription\",\"apcategoryremarks\",\"apcategorytype\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"apcategorycode\":\"Category Code\",\"apcategorydescription\":\"Category Description\",\"apcategoryremarks\":\"Category Remarks\",\"deactive\":\"Deactive\",\"apcategorytype\":\"Category Type\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "Category Master");
            cmap.put("combocolumn", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    /// Equipmentmaster
    private Map getEquipmentmasterData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            /////////////////////////////////////////////////
            cmap.put("tablename", "AP#EQUIPMENTMASTER");
            cmap.put("column", mapper.readValue("[\"EQUIPMENTID\",\"instituteid\",\"companyid\",\"DEPARTMENTID\",\"EQUIPMENTCODE\",\"EQUIPMENTNAME\",\"EQUIPMENTDETAILDESC\",\"PROCURMENTDATE\",\"PROCURMENTCOST\",\"deactive\",\"entryby\",\"entrydate\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("EQUIPMENTID", "EQUIPMENTID", "textbox", "20", "0", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Department Name", "Y")) + chc.td(chc.comboBox("DEPARTMENTID", "DEPARTMENTID", "combo", "Department Name", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Equipment Code", "Y")) + chc.td(chc.inputBox("EQUIPMENTCODE", "EQUIPMENTCODE", "textbox", "20", "", "Equipment Code", "", "text", "onblur='getUniqueValue(3)'"))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Equipment Name", "Y")) + chc.td(chc.inputBox("EQUIPMENTNAME", "EQUIPMENTNAME", "textbox", "100", "", "Equipment Name", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Equipment Description", "Y")) + chc.td(chc.inputBox("EQUIPMENTDETAILDESC", "EQUIPMENTDETAILDESC", "textbox", "30", "", "Equipment Description", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Procurment Date", "Y")) + chc.td(chc.inputBox("PROCURMENTDATE", "PROCURMENTDATE", "date", "10", "", "Procurment Date", "", "text", "readonly"))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Procurment Cost", "Y")) + chc.td(chc.inputBox("PROCURMENTCOST", "PROCURMENTCOST", "number", "14", "", "Procurment Cost", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Active", "N")) + chc.td(chc.checkBox("deactive", "deactive", "chkbox", "N", "", "Y"))));
            cmap.put("required", mapper.readValue("[\"EQUIPMENTCODE\",\"EQUIPMENTNAME\",\"EQUIPMENTDETAILDESC\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"EQUIPMENTCODE\":\"Equipment Code\",\"EQUIPMENTNAME\":\"Equipment Name\",\"deactive\":\"Deactive\",\"EQUIPMENTDETAILDESC\":\"Equipment Description\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "Equipment Master");
            cmap.put("combocolumn", mapper.readValue("{\"DEPARTMENTID\":\"departmentCombo\" }", new TypeReference<HashMap>() {
            }));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
//publicationtypemaster
    private Map getPublicationtypemasterData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            /////////////////////////////////////////////////
            cmap.put("tablename", "AP#PUBLICATIONTYPEMASTER");
            //cmap.put("column", mapper.readValue("[\"APPUBLICATIONTYPEID\",\"instituteid\",\"companyid\",\"APPUBLICATIONTYPECODE\",\"APPUBLICATIONTYPEDESCRIPTION\",\"APPUBLICATIONTYPEREMARKS\",\"deactive\"]", new TypeReference<ArrayList>() {
            cmap.put("column", mapper.readValue("[\"APPUBLICATIONTYPEID\",\"companyid\",\"APPUBLICATIONTYPECODE\",\"APPUBLICATIONTYPEDESCRIPTION\",\"APPUBLICATIONTYPEREMARKS\",\"deactive\",\"entryby\",\"entrydate\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("APPUBLICATIONTYPEID", "APPUBLICATIONTYPEID", "textbox", "20", "0", "", "", "hidden", ""))));
            //tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            //tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Publication Type Code", "Y")) + chc.td_with_style(chc.inputBox("APPUBLICATIONTYPECODE", "APPUBLICATIONTYPECODE", "textbox", "20", "", "Publication Type Code", "", "text", "onblur='getUniqueValue(2)'"))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Publication Type Desc.", "Y")) + chc.td(chc.inputBox("APPUBLICATIONTYPEDESCRIPTION", "APPUBLICATIONTYPEDESCRIPTION", "textbox", "100", "", "Publication Type Master", "width:800px", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Publication Type Remark", "Y")) + chc.td(chc.inputBox("APPUBLICATIONTYPEREMARKS", "APPUBLICATIONTYPEREMARKS", "textbox", "100", "", "Publication Type Remark", "width:800px", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Active", "N")) + chc.td_with_style(chc.checkBox("deactive", "deactive", "chkbox", "N", "", "Y"))));
            cmap.put("required", mapper.readValue("[\"APPUBLICATIONTYPECODE\",\"APPUBLICATIONTYPEDESCRIPTION\",\"APPUBLICATIONTYPEREMARKS\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"APPUBLICATIONTYPECODE\":\"Publication Type Code\",\"APPUBLICATIONTYPEDESCRIPTION\":\"Publication Type Desc.\",\"APPUBLICATIONTYPEREMARKS\":\"Publication Type Remark\",\"deactive\":\"Deactive\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "Publication Type Master");
              cmap.put("combocolumn", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    //AP#PUBLICATIONMASTER

    private Map getPublicationmasterData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            /////////////////////////////////////////////////
            cmap.put("tablename", "AP#PUBLICATIONMASTER");//
            cmap.put("column", mapper.readValue("[\"APPUBLICATIONID\",\"instituteid\",\"companyid\",\"APPUBLICATIONTYPE\",\"APPUBLICATIONCODE\",\"APPUBLICATIONDESCRIPTION\",\"APPUBLICATIONREMARKS\",\"deactive\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("APPUBLICATIONID", "APPUBLICATIONID", "textbox", "20", "0", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Publication Type123", "Y")) + chc.td(chc.comboBox("APPUBLICATIONTYPE", "APPUBLICATIONTYPE", "combo", "Publication Type", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Publication Code", "Y")) + chc.td(chc.inputBox("APPUBLICATIONCODE", "APPUBLICATIONCODE", "textbox", "20", "", "Publication Code", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Publication Desc.", "Y")) + chc.td(chc.inputBox("APPUBLICATIONDESCRIPTION", "APPUBLICATIONDESCRIPTION", "textbox", "100", "", "Publication Desc.", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Publication Remark", "Y")) + chc.td(chc.inputBox("APPUBLICATIONREMARKS", "APPUBLICATIONREMARKS", "textbox", "100", "", "Publication Remark", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Active", "N")) + chc.td(chc.checkBox("deactive", "deactive", "chkbox", "N", "", "Y"))));
            cmap.put("required", mapper.readValue("[\"APPUBLICATIONCODE\",\"APPUBLICATIONTYPE\",\"APPUBLICATIONDESCRIPTION\",\"APPUBLICATIONREMARKS\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"APPUBLICATIONTYPE\":\"Publication Type\",\"APPUBLICATIONCODE\":\"Publication Code\",\"APPUBLICATIONDESCRIPTION\":\"Publication Description\",\"APPUBLICATIONREMARKS\":\"Publication Remark\",\"deactive\":\"Deactive\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "Publication Master");
            cmap.put("combocolumn", mapper.readValue("{\"APPUBLICATIONTYPE\":\"publicationtypecombo\" }", new TypeReference<HashMap>() {
            }));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    //IndexingBodyMaster  ////AP#INDEXINGBODYMASTER    

    private Map getIndexingbodtmasterData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            //////////////////
            cmap.put("tablename", "AP#INDEXINGBODYMASTER");
            cmap.put("column", mapper.readValue("[\"APINDEXINGBODYID\",\"instituteid\",\"companyid\",\"APINDEXINGBODYCODE\",\"APINDEXINGBODYDESCRIPTION\",\"APINDEXINGBODYREMARKS\",\"deactive\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("APINDEXINGBODYID", "APINDEXINGBODYID", "textbox", "20", "0", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("IndexingBody Code", "Y")) + chc.td(chc.inputBox("APINDEXINGBODYCODE", "APINDEXINGBODYCODE", "textbox", "20", "", "IndexingBody Code", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("IndexingBody Desc.", "Y")) + chc.td(chc.inputBox("APINDEXINGBODYDESCRIPTION", "APINDEXINGBODYDESCRIPTION", "textbox", "100", "", "IndexingBody Desc.", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("IndexingBody Remark", "Y")) + chc.td(chc.inputBox("APINDEXINGBODYREMARKS", "APINDEXINGBODYREMARKS", "textbox", "100", "", "IndexingBody Remark", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Active", "N")) + chc.td(chc.checkBox("deactive", "deactive", "chkbox", "N", "", "Y"))));
            cmap.put("required", mapper.readValue("[\"APINDEXINGBODYCODE\",\"APINDEXINGBODYDESCRIPTION\",\"APINDEXINGBODYREMARKS\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"APINDEXINGBODYCODE\":\"IndexingBody Code\",\"APINDEXINGBODYDESCRIPTION\":\"IndexingBody Description\",\"APINDEXINGBODYREMARKS\":\"IndexingBody Remark\",\"DEACTIVE\":\"Deactive\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "Indexing Body Master");
            cmap.put("combocolumn", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    ///  Feedback MAster

    private Map getFeedbackmasterData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            cmap.put("tablename", "AP#FEEDBACKMASTER");//
            cmap.put("column", mapper.readValue("[\"APFEEDBACKID\",\"instituteid\",\"companyid\",\"APFEEDBACKTYPE\",\"APFEEDBACKCODE\",\"APFEEDBACKITEM\",\"APFEEDBACKREMARKS\",\"APFEEDBACKYEAR\",\"FEEDBACKSTATUS\",\"deactive\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("APFEEDBACKID", "APFEEDBACKID", "textbox", "20", "0", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Type", "Y")) + chc.td(chc.comboBox("APFEEDBACKTYPE", "APFEEDBACKTYPE", "combo", "Feedback Type", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Code", "Y")) + chc.td(chc.inputBox("APFEEDBACKCODE", "APFEEDBACKCODE", "textbox", "20", "", "Feedback Code", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Item", "Y")) + chc.td(chc.inputBox("APFEEDBACKITEM", "APFEEDBACKITEM", "textbox", "100", "", "Feedback Desc.", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Remark", "Y")) + chc.td(chc.inputBox("APFEEDBACKREMARKS", "APFEEDBACKREMARKS", "textbox", "100", "", "Feedback Remark", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("FeedBack Year", "Y")) + chc.td(chc.inputBox("APFEEDBACKYEAR", "APFEEDBACKYEAR", "textbox", "4", "", "Feedback Year", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Status", "Y")) + chc.td(chc.inputBox("FEEDBACKSTATUS", "FEEDBACKSTATUS", "textbox", "1", "", "Feedback Status", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Active", "N")) + chc.td(chc.checkBox("deactive", "deactive", "chkbox", "N", "", "Y"))));
            cmap.put("required", mapper.readValue("[\"APFEEDBACKTYPE\",\"APFEEDBACKCODE\",\"APFEEDBACKITEM\",\"APFEEDBACKREMARKS\",\"APFEEDBACKYEAR\",\"FEEDBACKSTATUS\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"APFEEDBACKTYPE\":\"FeedBack Type\",\"APFEEDBACKCODE\":\"FeedBack Code\",\"APFEEDBACKITEM\":\"FeedBack Item\",\"APFEEDBACKREMARKS\":\"FeedBack Remark\",\"APFEEDBACKYEAR\":\"FeedBack Year\",\"FEEDBACKSTATUS\":\"FeedBack Status\",\"deactive\":\"Deactive\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "FeedBack Master");
              cmap.put("combocolumn", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    //FeedBakRatingMasterData

    private Map getFeedbackRatingmasterData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            cmap.put("tablename", "AP#FEEDBACKRATINGMASTER");//
            cmap.put("column", mapper.readValue("[\"APFEEDBACKRATINGID\",\"instituteid\",\"companyid\",\"APFEEDBACKRATINGTYPE\",\"APFEEDBACKRATINGCODE\",\"APFEEDBACKRATINGNAME\",\"APFEEDBACKRATING\",\"deactive\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("APFEEDBACKRATINGID", "APFEEDBACKRATINGID", "textbox", "20", "0", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("FeedbackRating Type", "Y")) + chc.td(chc.comboBox("APFEEDBACKRATINGTYPE", "APFEEDBACKRATINGTYPE", "combo", "FeedbackRating Type", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("FeedbackRating Code", "Y")) + chc.td(chc.inputBox("APFEEDBACKRATINGCODE", "APFEEDBACKRATINGCODE", "textbox", "20", "", "FeedbackRating Code", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("FeedbackRating Name", "Y")) + chc.td(chc.inputBox("APFEEDBACKRATINGNAME", "APFEEDBACKRATINGNAME", "textbox", "100", "", "FeedbackRating Name", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Rating", "Y")) + chc.td(chc.inputBox("APFEEDBACKRATING", "APFEEDBACKRATING", "nondecimal", "6", "", "Feedback Rating nubers Only", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Active", "N")) + chc.td(chc.checkBox("deactive", "deactive", "chkbox", "N", "", "Y"))));
            cmap.put("required", mapper.readValue("[\"APFEEDBACKRATINGTYPE\",\"APFEEDBACKRATINGCODE\",\"APFEEDBACKRATINGNAME\",\"APFEEDBACKRATING\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"APFEEDBACKRATINGTYPE\":\"FeedBackRating Type\",\"APFEEDBACKRATINGCODE\":\"FeedBackRating Code\",\"APFEEDBACKRATINGNAME\":\"FeedBackRating Name\",\"APFEEDBACKRATING\":\"FeedBack Rating\",\"deactive\":\"Deactive\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "FeedBack Rating Master");
              cmap.put("combocolumn", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    // CalanderMaster AP#CALENDARMASTER   

    private Map getCalendermasterData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            cmap.put("tablename", "AP#CALENDARMASTER");// APCALENDARDESCRIPTION
            cmap.put("column", mapper.readValue("[\"APCALENDARID\",\"companyid\",\"APCALENDARCODE\",\"APCALENDARFROMDATE\",\"APCALENDARTODATE\",\"APCALENDARDESCRIPTION\",\"APCATEGORYCODE\",\"deactive\",\"entryby\",\"entrydate\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("APCALENDARID", "APCALENDARID", "textbox", "20", "0", "", "", "hidden", ""))));
            //tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            //tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Calender Code", "Y")) + chc.td_with_style(chc.inputBox("APCALENDARCODE", "APCALENDARCODE", "textbox", "20", "", "Calender Code", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Calender From Date", "Y")) + chc.td_with_style(chc.inputBox("APCALENDARFROMDATE", "APCALENDARFROMDATE", "date", "10", "", "Calender From Date", "", "text", "readonly"))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Calender To Date", "Y")) + chc.td_with_style(chc.inputBox("APCALENDARTODATE", "APCALENDARTODATE", "date", "10", "", "Calender To Date", "", "text", "readonly"))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Calender Desc.", "Y")) + chc.td(chc.inputBox("APCALENDARDESCRIPTION", "APCALENDARDESCRIPTION", "textbox", "100", "", "Calender Desc.", "width:800px", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Category Code", "Y")) + chc.td_with_style(chc.comboBox("APCATEGORYCODE", "APCATEGORYCODE", "combo", "Category Code", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Active", "N")) + chc.td_with_style(chc.checkBox("deactive", "deactive", "chkbox", "N", "", "Y"))));
            cmap.put("required", mapper.readValue("[\"APCALENDARCODE\",\"APCALENDARFROMDATE\",\"APCALENDARTODATE\",\"APCALENDARDESCRIPTION\",\"APCATEGORYCODE\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"APCALENDARCODE\":\"Calender Code\",\"APCALENDARFROMDATE\":\"Calender From Date\",\"APCALENDARTODATE\":\"Calender To Date\",\"APCALENDARDESCRIPTION\":\"Calender Desc.\",\"deactive\":\"Deactive\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "Calender Master");
            cmap.put("combocolumn", mapper.readValue("{\"APCATEGORYCODE\":\"categorycombo\" }", new TypeReference<HashMap>() {
            }));// for dynamic  combo values effected from common combo data at two places one is querry part second add in enum value
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    //Form Master

    private Map getFormmasterData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            cmap.put("tablename", "AP#FORMMASTER");// APCALENDARDESCRIPTION
            //cmap.put("column", mapper.readValue("[\"APFORMID\",\"instituteid\",\"companyid\",\"APFORMNO\",\"APCATEGORYID\",\"APFORMTITLE\",\"deactive\"]", new TypeReference<ArrayList>() {
            cmap.put("column", mapper.readValue("[\"APFORMID\",\"companyid\",\"APFORMNO\",\"APCATEGORYID\",\"APFORMTITLE\",\"APFORMREMARKS\",\"deactive\",\"entryby\",\"entrydate\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("APFORMID", "APFORMID", "textbox", "20", "0", "", "", "hidden", ""))));
            //tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
           // tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Form No.", "Y")) + chc.td_with_style(chc.inputBox("APFORMNO", "APFORMNO", "textbox", "20", "", "Form No.", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Category Code", "Y")) + chc.td_with_style(chc.comboBox("APCATEGORYID", "APCATEGORYID", "combo", "Category Code", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Form Title", "Y")) + chc.td_with_style(chc.inputBox("APFORMTITLE", "APFORMTITLE", "textbox", "100", "", "Form Tittle", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Remarks", "N")) + chc.td(chc.inputBox("APFORMREMARKS", "APFORMREMARKS", "textbox", "160", "", "Remarks", "width:800px", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Active", "N")) + chc.td_with_style(chc.checkBox("deactive", "deactive", "chkbox", "N", "", "Y"))));
            cmap.put("required", mapper.readValue("[\"APCATEGORYID\",\"APFORMNO\",\"APFORMTITLE\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"APCATEGORYID\":\"Category \",\"APFORMNO\":\"Form No.\",\"APFORMTITLE\":\"Form Title\",\"deactive\":\"Deactive\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "Form Master");
            cmap.put("combocolumn", mapper.readValue("{\"APCATEGORYID\":\"categorycombo\" }", new TypeReference<HashMap>() {
            }));// for dynamic  combo values effected from common combo data at two places one is querry part second add in enum value
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    //Form Detail/Header 

    private Map getFormTransData() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            cmap.put("tablename", "AP#FORMTRANSACTION");
            cmap.put("column", mapper.readValue("[\"TRANSACTIONID\",\"instituteid\",\"companyid\",\"APCATEGORYID\",\"APFORMID\",\"FORMFILLEDBY\",\"DATEOFFILLING\",\"TRANSACTIONDATE\",\"APFORMREMARKS\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("TRANSACTIONID", "TRANSACTIONID", "textbox", "20", "0", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Category Code", "Y")) + chc.td(chc.comboBox("APCATEGORYID", "APCATEGORYID", "combo", "Category Code", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Form Code", "Y")) + chc.td(chc.comboBox("APFORMID", "APFORMID", "combo", "Form Code", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Form Filled By", "Y")) + chc.td(chc.inputBox("FORMFILLEDBY", "FORMFILLEDBY", "textbox", "20", "", "Form Filled By", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Date of Filling", "Y")) + chc.td(chc.inputBox("DATEOFFILLING", "DATEOFFILLING", "date", "10", "", "Date of Filling", "", "text", "readonly"))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Transection Date", "Y")) + chc.td(chc.inputBox("TRANSACTIONDATE", "TRANSACTIONDATE", "date", "10", "", "Transection Date", "", "text", "readonly"))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Form Remark", "Y")) + chc.td(chc.inputBox("APFORMREMARKS", "APFORMREMARKS", "textbox", "100", "", "Form Remark", "", "text", ""))));
            cmap.put("required", mapper.readValue("[\"TRANSACTIONDATE\",\"APCATEGORYID\",\"APFORMID\",\"FORMFILLEDBY\",\"DATEOFFILLING\",\"APFORMREMARKS\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"APCATEGORYID\":\"Category\",\"APFORMID\":\"Form\",\"TRANSACTIONDATE\":\"Transection Date\",\"DATEOFFILLING\":\"Date of Filling\",\"FORMFILLEDBY\":\"Form Filled by\",\"APFORMREMARKS\":\"Reamrks\" }", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "Form Deatil/Transection");
            cmap.put("combocolumn", mapper.readValue("{\"APCATEGORYID\":\"categorycombo\" ,\"APFORMID\":\"formcombo\"}", new TypeReference<HashMap>() {
            }));// for dynamic  combo values effected from common combo data at two places one is querry part second add in enum value
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    
    // AP#FEEDBACKHEADER getFeedbackheader
    
    private Map getFeedbackheader() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            cmap.put("tablename", "AP#FEEDBACKHEADER");
            cmap.put("column", mapper.readValue("[\"TRANSACTIONID\",\"TRANSACTIONDATE\",\"instituteid\",\"companyid\",\"APFEEDBACKID\",\"APFACULTYID\",\"APEXAMCODE\",\"APREGSTUDENTNO\",\"APACADEMICYEAR\",\"APSEMESTER\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("TRANSACTIONID", "TRANSACTIONID", "textbox", "20", "0", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Transection Date", "Y")) + chc.td(chc.inputBox("TRANSACTIONDATE", "TRANSACTIONDATE", "date", "10", "", "Transection Date", "", "text", "readonly"))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("FeedBack Code", "Y")) + chc.td(chc.comboBox("APFEEDBACKID", "APFEEDBACKID", "combo", "FeedBack Code", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Faculty Name", "Y")) + chc.td(chc.comboBox("APFACULTYID", "APFACULTYID", "combo", "Faculty Name", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Exam Code", "Y")) + chc.td(chc.comboBox("APEXAMCODE", "APEXAMCODE", "combo", "Exam Code", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("No. of Reg.Student", "Y")) + chc.td(chc.inputBox("APREGSTUDENTNO", "APREGSTUDENTNO", "textbox", "5", "", "No. of Reg.Student", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Academic Year", "Y")) + chc.td(chc.comboBox("APACADEMICYEAR", "APACADEMICYEAR", "combo", "Academic Year", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Semester", "Y")) + chc.td(chc.comboBox("APSEMESTER", "APSEMESTER", "combo", "Semester", ""))));

            cmap.put("required", mapper.readValue("[\"TRANSACTIONDATE\",\"APFEEDBACKID\",\"APFACULTYID\",\"APEXAMCODE\",\"APREGSTUDENTNO\",\"APACADEMICYEAR\",\"APSEMESTER\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"TRANSACTIONDATE\":\"Trans. Date\",\"APFEEDBACKID\":\"FeedBack Code\",\"APFACULTYID\":\"Faculty Name\",\"APEXAMCODE\":\"Exam Code\",\"APREGSTUDENTNO\":\"No. Of Reg. Student\",\"APACADEMICYEAR\":\"Academic Year\" ,\"APSEMESTER\":\"Semester\"}", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "FeedBack Header");
            cmap.put("combocolumn", mapper.readValue("{\"APCATEGORYID\":\"categorycombo\" ,\"APFORMID\":\"formcombo\"}", new TypeReference<HashMap>() {
            }));// for dynamic  combo values effected from common combo data at two places one is querry part second add in enum value
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    
    
    
    private Map getfeedbacktransaction() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            cmap.put("tablename", "AP#FEEDBACKHEADER");
            cmap.put("column", mapper.readValue("[\"TRANSACTIONID\",\"instituteid\",\"companyid\",\"TRANSACTIONDATE\",\"APFEEDBACKID\",\"APFACULTYID\",\"PROGRAMCODE\",\"APFEEDBACKCOUNT\",\"DEPARTMENTCODE\",\"APACADEMICYEAR\",\"APSEMESTER\",\"APFEEDBACKHEADERREMARKS\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("TRANSACTIONID", "TRANSACTIONID", "textbox", "20", "0", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Transection Date", "Y")) + chc.td(chc.inputBox("TRANSACTIONDATE", "TRANSACTIONDATE", "date", "10", "", "Transection Date", "", "text", "readonly"))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("instituteid", "instituteid", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("companyid", "companyid", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("FeedBack Code", "Y")) + chc.td(chc.comboBox("APFEEDBACKID", "APFEEDBACKID", "combo", "FeedBack Code", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Faculty Code", "Y")) + chc.td(chc.comboBox("APFACULTYID", "APFACULTYID", "combo", "Faculty Name", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Course Code", "Y")) + chc.td(chc.comboBox("PROGRAMCODE", "PROGRAMCODE", "combo", "Course Name", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Academic Year", "Y")) + chc.td(chc.inputBox("APACADEMICYEAR", "APACADEMICYEAR", "textbox", "100", "", "Academic Year", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Remarks", "Y")) + chc.td(chc.inputBox("APFEEDBACKHEADERREMARKS", "APFEEDBACKHEADERREMARKS", "textbox", "100", "", "Remarks", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Count", "Y")) + chc.td(chc.inputBox("APFEEDBACKCOUNT", "APFEEDBACKCOUNT", "textbox", "100", "", "Feedback Count", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Department Code", "Y")) + chc.td(chc.comboBox("DEPARTMENTCODE", "DEPARTMENTCODE", "combo", "Department Name", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Semester", "Y")) + chc.td(chc.comboBox("APSEMESTER", "APSEMESTER", "combo", "Semester", ""))));
            cmap.put("required", mapper.readValue("[\"TRANSACTIONDATE\",\"APFEEDBACKID\",\"APFACULTYID\",\"PROGRAMCODE\",\"APACADEMICYEAR\",\"APFEEDBACKHEADERREMARKS\",\"APFEEDBACKCOUNT\",\"DEPARTMENTCODE\",\"APSEMESTER\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"TRANSACTIONDATE\":\"Trans. Date\",\"APFEEDBACKID\":\"FeedBack Code\",\"APFACULTYID\":\"Faculty Name\",\"PROGRAMCODE\":\"Course Code\",\"APACADEMICYEAR\":\"Academic Year\",\"APFEEDBACKHEADERREMARKS\":\"Remarks\",\"APFEEDBACKCOUNT\":\"Feedback Count\" ,\"DEPARTMENTCODE\":\"Department Code\",\"APSEMESTER\":\"Semester\"}", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "FeedBack Transaction");
            cmap.put("combocolumn", mapper.readValue("{\"APFEEDBACKID\":\"feedbackcombo\" ,\"APFACULTYID\":\"facultycombo\",\"PROGRAMCODE\":\"programecombo\",\"DEPARTMENTCODE\":\"departmentcombo\",\"APSEMESTER\":\"semestercombo\"}", new TypeReference<HashMap>() {
            }));// for dynamic  combo values effected from common combo data at two places one is querry part second add in enum value
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
    
 private Map getfacultyfeedbackmaster() {
        Map cmap = new HashMap();
        CommonHtmlComponent chc = new CommonHtmlComponent();
        StringBuffer tablerow = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        try {
            cmap.put("tablename", "AP#FACULTYFEEDBACKMASTER");
            cmap.put("column", mapper.readValue("[\"FEEDBACKID\",\"INSTITUTECODE\",\"COMPANYCODE\",\"EXAMCODE\",\"FEEDBACKCODE\",\"FEEDBACKDESC\",\"EVENTFROMDATE\",\"EVENTTODATE\",\"FEEDBACKREMARKS\"]", new TypeReference<ArrayList>() {
            }));
            tablerow.append(chc.tr(chc.td(chc.inputBox("FEEDBACKID", "FEEDBACKID", "textbox", "20", "0", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("INSTITUTECODE", "INSTITUTECODE", "textbox", "20", "JIIT", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.inputBox("COMPANYCODE", "COMPANYCODE", "textbox", "20", "UNIV", "", "", "hidden", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Exam Code", "Y")) + chc.td(chc.comboBox("EXAMCODE", "EXAMCODE", "combo", "Exam Code", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Code", "Y")) + chc.td(chc.inputBox("FEEDBACKCODE", "FEEDBACKCODE", "textbox", "100", "", "Feedback Code", "", "text", ""))+chc.td(chc.hLable("Feedback Description", "Y")) + chc.td(chc.inputBox("FEEDBACKDESC", "FEEDBACKDESC", "textbox", "100", "", "Feedback Description", "", "text", ""))));
           // tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Description", "Y")) + chc.td(chc.inputBox("FEEDBACKDESC", "FEEDBACKDESC", "textbox", "100", "", "Feedback Description", "", "text", ""))));
            tablerow.append(chc.tr(chc.td(chc.hLable("EventFrom Date", "Y")) + chc.td(chc.inputBox("EVENTFROMDATE", "EVENTFROMDATE", "date", "10", "", "EventFrom Date", "", "text", "readonly"))+chc.td(chc.hLable("EventTo Date", "Y")) + chc.td(chc.inputBox("EVENTTODATE", "EVENTTODATE", "date", "10", "", "EventTo Date", "", "text", "readonly"))));
           // tablerow.append(chc.tr(chc.td(chc.hLable("EventTo Date", "Y")) + chc.td(chc.inputBox("EVENTTODATE", "EVENTTODATE", "date", "10", "", "EventTo Date", "", "text", "readonly"))));
            tablerow.append(chc.tr(chc.td(chc.hLable("Feedback Remarks", "Y")) + chc.td(chc.inputBox("FEEDBACKREMARKS", "FEEDBACKREMARKS", "textbox", "100", "", "Feedback Remarks", "", "text", ""))));
            cmap.put("required", mapper.readValue("[\"EXAMCODE\",\"FEEDBACKCODE\",\"FEEDBACKDESC\",\"EVENTFROMDATE\",\"EVENTTODATE\",\"FEEDBACKREMARKS\"]", new TypeReference<ArrayList>() {
            }));
            cmap.put("gridcolumn", mapper.readValue("{\"EXAMCODE\":\"Exam Code\",\"FEEDBACKCODE\":\"Feedback Code\",\"FEEDBACKDESC\":\"Feedback Description\",\"EVENTFROMDATE\":\"EventFrom Date\",\"EVENTTODATE\":\"EventTo Date\",\"FEEDBACKREMARKS\":\"Feedback Remarks\"}", new TypeReference<HashMap>() {
            }));
            cmap.put("tabledesign", tablerow.toString());
            cmap.put("windowheader", "Faculty FeedBack Master");
            cmap.put("combocolumn", mapper.readValue("{\"EXAMCODE\":\"examcode\"}", new TypeReference<HashMap>() {
            }));// for dynamic  combo values effected from common combo data at two places one is querry part second add in enum value
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmap;
    }
}
