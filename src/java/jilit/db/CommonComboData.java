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
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author Mohit.sharma
 */
public class CommonComboData {

    private static Connection dbConnection = null; 
    private PreparedStatement pStmt=null;
    private ResultSet rs=null;
    

    public CommonComboData() {
       
    }

//    public CommonComboData(boolean mkconnection) throws SQLException{
//       if(mkconnection==true){
//        dbConnection = DBUtility.getConnection();
//       }

//    }
    private enum mcase {

        categorycombo, publicationtypecombo, formcombo, feedbackcombo, facultycombo,
        examcobmo, academicyearcombo, semestercombo,subjectcombo,programecombo,departmentcombo1,
        ratingcombo,examcode,feedbackcodecombo,departmentCombo,transactionidcombo,transactionIDCombo,
        feedbackcombodata,departmentComboShortNameisNull,departmentComboShortNameIsNotNull,programecomboFaculty,
        eqptSoftwareCombo,learningResourceCombo,departmentComboAbroad,courseCodeCombo,publicationTypeCombo1,
        publicationCombo,indexingBodyCombo,academicYearCombo,receiptCodeCombo,expenditureCodeCombo,EventCombo,
        academicyearcomboAllYear,eventCombo,companyMasterCombo,feedBackIDForReport,instituteCombo,programCombo,
        instituteCodeCombo,programCodeCombo,branchCodeCombo,academicyearcomboAllYearWithAll,examCodeCombo,subjectCombo,
        quotaCombo,companyCodeCombo,employeeTypeCombo,academicYearComboWithInstCode,examCodeComboSSM,programComboAE,
        branchComboAE,subjectsComboAE,admissionYearCombo,bbaadmissionYearCombo,designationComboReport,departmentComboReport,gradeComboReport,
        instituteCodeCombo1,academicYearComboWithInstCode1,programCodeCombo1,branchCodeCombo1,EnrollmentNoCombo
    }

    public String getCommonCombo(String jdata) throws SQLException  {
        Map hm = new HashMap();
        ObjectMapper mapper = new ObjectMapper();
        StringBuffer sb = new StringBuffer();
        StringBuffer op = new StringBuffer();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap<String, String>>() {
            });

            switch (CommonComboData.mcase.valueOf((String) hm.get("comboId").toString())) {
                case categorycombo:
                    sb.append("select distinct nvl(A.APCATEGORYID,'')categorycode ,nvl(A.APCATEGORYDESCRIPTION,'')category from ap#categorymaster a where nvl(deactive,'N')='N' order by category ");
                    op.append("<option value='' selected>Select Category</option>");
                    break;
                case publicationtypecombo:
                    sb.append("  select distinct nvl(A.APPUBLICATIONTYPECODE,'')publicationtypecode ,nvl(A.APPUBLICATIONTYPEDESCRIPTION,'')publicationtype from AP#PUBLICATIONTYPEMASTER a where nvl(deactive,'N')='N' order by publicationtype ");
                    op.append("<option value='' selected>Select Publication Type</option>");
                    break;

                case formcombo:
                    sb.append("  select distinct nvl(A.APFORMID,'')formid ,nvl(A.APFORMTITLE,'')form from AP#FORMMASTER a where nvl(deactive,'N')='N' order by form ");
                    op.append("<option value='' selected>Select Form</option>");
                    break;

                case feedbackcombo:
                    sb.append("select distinct nvl(A.APFEEDBACKID,'') as formid ,nvl(A.APFEEDBACKCODE,'') as APFEEDBACKCODE from AP#FEEDBACKMASTER A  where nvl(deactive,'N')='N' order by APFEEDBACKCODE ");
                    op.append("<option value='' selected>Select FeedBack Code</option>");
                    break;

                case facultycombo:
                   // sb.append("  select distinct nvl(A.Employeeid,'')employeeid ,nvl(A.Employeecode,'') || '-'  || nvl(employeename,'') employee from employeemaster A  where nvl(deactive,'N')='N' order by employee");
                     sb.append("  select  nvl(A.Employeeid,'')employeeid ,nvl(A.Employeecode,'') || '-'  || nvl(employeename,'') employee  from employeemaster A  where nvl(deactive,'N')='N' group by A.Employeeid,employeeid ,A.Employeecode,employeename  order by A.employeename");
                    op.append("<option value='' selected>Select Faculty</option>");
                    break;

                case examcobmo:
                    sb.append("  select distinct nvl(A.examcode,'')examcode ,nvl(A.EXAMDESCRIPTION,'') EXAMDESCRIPTION from exammaster A  where nvl(deactive,'N')='N' and EXAMPERIODTO > sysdate order by EXAMDESCRIPTION");
                    op.append("<option value='' selected>Select Exam Code</option>");
                    break;

                case academicyearcombo:
                    sb.append("  select distinct nvl(A.academicyear,'')academicyear ,nvl(A.academicyear,'') academicyear1 from academicyearmaster A  where nvl(deactive,'N')='N' and nvl(closed,'N')='N' and to_number(ACADEMICYEAR)>1415  order by academicyear desc ");
                    op.append("<option value='' selected>Select Academic Year</option>");
                    break;

                case semestercombo:
                    sb.append(" select distinct semester as s1,semester as s2   from STUDENTMASTER A   WHERE SEMESTER IS NOT NULL ORDER BY SEMESTER  ");
                    op.append("<option value='' selected>Select Semester</option>");
                    break;
                case subjectcombo:
                    sb.append("  select distinct nvl(sm.subjectid,'')subjectid ,nvl(sm.subject,'') as subject from subjectmaster sm  where nvl(deactive,'N')='N'  order by subject  ");
                    op.append("<option value='' selected>Select Subject</option>");
                    break;
                case programecombo:
                    sb.append("  select distinct nvl(pm.programcode,'')as programcode ,nvl(pm.programname,'') as programname from programmaster pm  where nvl(deactive,'N')='N'  order by programname  ");
                    op.append("<option value='' selected>Select Course</option>");
                    break;
                case departmentcombo1:
                    sb.append("  SELECT DISTINCT NVL (dm.departmentcode, '') AS departmentcode,NVL (dm.department, '') AS department FROM departmentmaster dm, employeemaster em WHERE em.departmentcode=dm.departmentcode and NVL (dm.deactive, 'N') = 'N'  and EM.EMPLOYEEID='"+hm.get("empID").toString()+"' order by department ");
                    op.append("<option value='' selected>Select Department</option>");
                    break;
                case ratingcombo:
                    sb.append(" select distinct nvl(afr.apfeedbackratingid,'')as apfeedbackratingid ,nvl(afr.apfeedbackratingdesc,'') as apfeedbackratingdesc from ap#feedbackrating afr  where nvl(deactive,'N')='N'  order by apfeedbackratingdesc   ");
                    op.append("<option value='' selected>Select Rating</option>");
                    break;
                case examcode:
                    sb.append(" select distinct nvl(em.examcode,'')as examcode ,nvl(em.examcode,'') as examcode1 from exammaster em  where nvl(deactive,'N')='N'  order by examcode1   ");
                    op.append("<option value='' selected>Select Rating</option>");
                    break;
                case feedbackcodecombo:
                    sb.append("  SELECT DISTINCT NVL (ffm.FEEDBACKID, '') AS FEEDBACKID,NVL (ffm.FEEDBACKCODE, '') AS FEEDBACKCODE FROM ap#facultyfeedbackmaster ffm WHERE  NVL (ffm.deactive, 'N') = 'N'  and ffm.examcode='"+hm.get("examcode").toString()+"' order by FEEDBACKCODE ");
                    op.append("<option value='' selected>Select Feedback Code</option>");
                    break;
                case departmentCombo:
                    sb.append("  SELECT DISTINCT NVL (dm.DEPARTMENTCODE, '') AS DEPARTMENTCODE,NVL (dm.DEPARTMENT, '') AS DEPARTMENT FROM departmentmaster dm WHERE  NVL (dm.deactive, 'N') = 'N' and  departmenttype='T' order by DEPARTMENT ");
                    op.append("<option value='' selected>Select Department Name</option>");
                    break;
                case transactionidcombo:
                    sb.append("  SELECT NVL(awd.transactionid, '') transactionid,wm_concat (awd.psaprogramtitle|| '['|| TO_CHAR (awd.psastartdate, 'dd-mm-yyyy')|| ':'|| TO_CHAR (awd.psaenddate, 'dd-mm-yyyy')||']') abc FROM ap#psaworkshopdetails awd group by transactionid ORDER BY transactionid, abc ");
                    op.append("<option value='' selected>Select Program Details</option>");
                    break;
                case transactionIDCombo:
                    sb.append("  SELECT  NVL (aid.transactionid, '')transactionid,wm_concat(AID.PSARANDDLABDETAILS||'-'||AID.PSASCHOLARFELLOWDETAILS) interactiondetails FROM AP#PSAINDUSTRIALDETAILS aid group by transactionid   order by transactionid ,interactiondetails");
                    op.append("<option value='' selected>Select Interactions Details</option>");
                    break;
                case feedbackcombodata:
                    sb.append("  SELECT DISTINCT NVL (ASM.FEEDBACKID, '') AS FEEDBACKID,NVL (ASM.FEEDBACKID, '') AS FEEDBACKID1 FROM AP#SHFEEDBACKMASTER ASM  order by FEEDBACKID ");
                    op.append("<option value='' selected>Select Feedback ID</option>");
                    break;
                case departmentComboShortNameisNull:
                    sb.append("  SELECT DISTINCT NVL (dm.DEPARTMENTCODE, '') AS DEPARTMENTCODE,NVL (dm.DEPARTMENT, '') AS DEPARTMENT FROM departmentmaster dm WHERE  NVL (dm.deactive, 'N') = 'N' and departmenttype='T' and department is not null order by DEPARTMENT ");
                    op.append("<option value='' selected>Select Department Name</option>");
                    break;
                case departmentComboShortNameIsNotNull:
                    sb.append("  SELECT DISTINCT NVL (dm.DEPARTMENTCODE, '') AS DEPARTMENTCODE,NVL (dm.DEPARTMENT, '') AS DEPARTMENT FROM departmentmaster dm WHERE  NVL (dm.deactive, 'N') = 'N' and  DEPARTMENTTYPE='N' and department is not null order by DEPARTMENT ");
                    op.append("<option value='' selected>Select Department Name</option>");
                    break;
                case programecomboFaculty:
                    sb.append("  select distinct nvl(pm.programcode,'')as programcode ,nvl(pm.programname,'') as programname from programmaster pm  where nvl(deactive,'N')='N'  order by programname  ");
                    break;
                case eqptSoftwareCombo:
                    sb.append("  SELECT DISTINCT NVL (AESM.EQUIPMENTID, '') AS EQUIPMENTID,NVL (AESM.EQUIPMENTNAME, '') AS EQUIPMENTNAME FROM AP#EQPTSOFTMASTER AESM WHERE  NVL (AESM.deactive, 'N') = 'N' order by EQUIPMENTNAME ");
                    op.append("<option value='' selected>Select Eqpt/Software Name</option>");
                    break;
                case learningResourceCombo:
                    sb.append("  SELECT DISTINCT NVL (ALRM.LEARNRESOURCEID, '') AS LEARNRESOURCEID,NVL (ALRM.LEARNRESOURCENAME, '') AS LEARNRESOURCENAME FROM AP#LEARNRESOURCEMASTER ALRM WHERE  NVL (ALRM.deactive, 'N') = 'N' order by LEARNRESOURCENAME ");
                    op.append("<option value='' selected>Select Learning Resource Name</option>");
                    break;
                case departmentComboAbroad:
                    sb.append("  SELECT DISTINCT NVL (dm.DEPARTMENTCODE, '') AS DEPARTMENTCODE,NVL (dm.DEPARTMENT, '') AS DEPARTMENT FROM departmentmaster dm WHERE  NVL (dm.deactive, 'Y') = 'Y' and departmenttype='A' and department is not null order by DEPARTMENT ");
                    op.append("<option value='' selected>Select Department Name</option>");
                    break;
                case publicationTypeCombo1:
                    sb.append("  SELECT DISTINCT NVL (am.appublicationtypeid, '') AS appublicationtypeid, NVL (am.appublicationtypedescription, '') AS appublicationtypedescription FROM ap#publicationtypemaster am WHERE  NVL (am.deactive, 'N') = 'N' order by appublicationtypedescription ");
                    op.append("<option value='' selected>Select Publication Type</option>");
                    break;
                case indexingBodyCombo:
                    sb.append("  SELECT DISTINCT NVL (am.indexingbodyid, '') AS indexingbodyid,NVL (am.indexingbodydescription, '') AS indexingbodydescription FROM ap#indexingbodymaster am WHERE  NVL (am.deactive, 'N') = 'N' order by indexingbodydescription ");
                    op.append("<option value='' selected>Select Indexing Body</option>");
                    break;
                case academicYearCombo:
                    sb.append("  select distinct nvl(A.parametervalue,'')parametervalue ,nvl(A.parametervalue,'') parametervalue1 from AP#CONTROLMASTER A  where nvl(A.deactive,'N')='N' and to_date(sysdate,'dd-MM-RRRR') between TO_DATE (A.parameterfromdate, 'dd-mm-RRRR') AND TO_DATE (A.parametertodate, 'dd-mm-RRRR') AND parameterid = 'QA-SR-3' ");
                    op.append("<option value='' selected>Select Academic Year</option>");
                    break;
                case receiptCodeCombo:
                    sb.append("  select distinct nvl(am.psarecexpcode,'')psarecexpcode ,nvl(am.psarecexpcode||'-'||am.psarecexpname,'') psarecexpcode1 from AP#PSARECEXPMASTER am  where aprecexptype='R' and nvl(am.deactive,'N')='N' order by psarecexpcode");
                    op.append("<option value='' selected>Select Receipt Code</option>");
                    break;
                case expenditureCodeCombo:
                    sb.append("  select distinct nvl(am.psarecexpcode,'')psarecexpcode ,nvl(am.psarecexpcode||'-'||am.psarecexpname,'') psarecexpcode1 from AP#PSARECEXPMASTER am  where aprecexptype='E' and nvl(am.deactive,'N')='N' order by psarecexpcode");
                    op.append("<option value='' selected>Select Expenditure Code</option>");
                    break;
                case academicyearcomboAllYear:
                    sb.append(" select distinct nvl(A.academicyear,'')academicyear ,nvl(A.academicyear,'') academicyear1 from academicyearmaster A  where nvl(deactive,'N')='N' and nvl(closed,'N')='N' and rownum<=10  order by academicyear desc");
                    op.append("<option value='' selected>Select Academic Year</option>");
                    break;
                case eventCombo:
                    sb.append("select distinct nvl(a.APEVENTID,'')EVENTID ,nvl(a.APEVENTDESCRIPTION,'')EVENTDESCRIPTION from AP#EVENTMASTER a where nvl(deactive,'N')='N' order by EVENTDESCRIPTION ");
                    op.append("<option value='' selected>Select Event</option>");
                    break;
                case companyMasterCombo:
                    sb.append("select nvl(cm.COMPANYCODE,'')COMPANYCODE ,nvl(cm.COMPANYNAME,'')COMPANYNAME from COMPANYMASTER cm where nvl(deactive,'N')='N' order by COMPANYNAME ");
                    op.append("<option value='' selected>Select Company</option>");
                    break;
                case feedBackIDForReport:
                    sb.append("select nvl(am.APFEEDBACKID,'')APFEEDBACKID,nvl(am.APFEEDBACKID,'')APFEEDBACKID1 from AP#FEEDBACKTYPEMASTER am where APFEEDBACKTYPE='SHFACULTY'");
                    op.append("<option value='' selected>Select Feedback ID</option>");
                    break;
                case instituteCombo:
                    sb.append("select nvl(im.INSTITUTECODE,'')INSTITUTECODE ,nvl(im.INSTITUTENAME,'')INSTITUTENAME from INSTITUTEMASTER im where nvl(deactive,'N')='N' and institutecode='JIIT' ");
                    op.append("<option value='' selected>Select Institute</option>");
                    break;
                case programCombo:
                    sb.append("select nvl(pm.INSTITUTECODE,'')INSTITUTECODE ,nvl(pm.PROGRAMNAME,'')PROGRAMNAME from programmaster pm where nvl(deactive,'N')='N' and institutecode='JIIT' ");
                    op.append("<option value='' selected>Select Institute</option>");
                    break;
                case instituteCodeCombo:
                    sb.append("select nvl(im.INSTITUTECODE,'')INSTITUTECODE ,nvl(im.INSTITUTECODE,'')INSTITUTECODE1 from INSTITUTEMASTER im where nvl(deactive,'N')='N'");
                    op.append("<option value='' selected>Select Institute Code</option>");
                    break;
                case programCodeCombo:
                    sb.append("  select distinct nvl(sm.programcode,'')programcode ,nvl(sm.programcode,'')programcode1 from studentmaster sm  where institutecode='"+hm.get("instituteCode")+"' and academicyear='"+hm.get("academicYear")+"' and programcode is not null");
                    op.append("<option value='' selected>Select Program Code</option>");
                    if(hm.get("instituteCode")!=null && !hm.get("academicYear").equals("0") && !hm.get("instituteCode").equals("") && !hm.get("academicYear").equals(""))
                    op.append("<option value='ALL'>All</option>");
                    break;
                case branchCodeCombo:
                    sb.append("  select distinct nvl(sm.branchcode,'')branchcode ,nvl(sm.branchcode,'')branchcode1 from studentmaster sm  where institutecode='"+hm.get("instituteCode")+"' and academicyear='"+hm.get("academicYear")+"' and programcode='"+hm.get("programCode")+"'");
                    op.append("<option value='' selected>Select Branch Code</option>");
                    if(hm.get("instituteCode")!=null && !hm.get("instituteCode").equals("") && !hm.get("academicYear").equals("0") && !hm.get("academicYear").equals("") && !hm.get("programCode").equals("0") && !hm.get("programCode").equals(""))
                    op.append("<option value='ALL'>All</option>");
                    break;
                case instituteCodeCombo1:
                    sb.append("select nvl(im.INSTITUTECODE,'')INSTITUTECODE ,nvl(im.INSTITUTECODE,'')INSTITUTECODE1 from INSTITUTEMASTER im where nvl(deactive,'N')='N'");
                    op.append("<option value='' selected>Select Institute Code</option>");
                    break;
                case academicYearComboWithInstCode1:
                    sb.append(" select distinct nvl(A.academicyear,'')academicyear ,nvl(A.academicyear,'') academicyear1 from academicyearmaster A  where nvl(deactive,'N')='N' and nvl(closed,'N')='N' and institutecode='" + hm.get("instituteCode") + "' order by academicyear desc");
                    op.append("<option value='' selected>Select Academic Year</option>");
                    break;
                case programCodeCombo1:
                    sb.append("  select distinct nvl(sm.programcode,'')programcode ,nvl(sm.programcode,'')programcode1 from studentmaster sm  where institutecode='"+hm.get("instituteCode")+"' and academicyear='"+hm.get("academicYear")+"' and programcode is not null");
                    op.append("<option value='' selected>Select Program Code</option>");
                    //if(hm.get("instituteCode")!=null && !hm.get("academicYear").equals("0") && !hm.get("instituteCode").equals("") && !hm.get("academicYear").equals(""))
                    //op.append("<option value='ALL'>All</option>");
                    break;
                case branchCodeCombo1:
                    sb.append("  select distinct nvl(sm.branchcode,'')branchcode ,nvl(sm.branchcode,'')branchcode1 from studentmaster sm  where institutecode='"+hm.get("instituteCode")+"' and academicyear='"+hm.get("academicYear")+"' and programcode='"+hm.get("programCode")+"'");
                    op.append("<option value='' selected>Select Branch Code</option>");
                   // if(hm.get("instituteCode")!=null && !hm.get("instituteCode").equals("") && !hm.get("academicYear").equals("0") && !hm.get("academicYear").equals("") && !hm.get("programCode").equals("0") && !hm.get("programCode").equals(""))
                   // op.append("<option value='ALL'>All</option>");
                    break;

                case EnrollmentNoCombo:
                    sb.append("select distinct nvl(ENROLLMENTNO || '[' || studentname,' ') || ']' as ENROLLMENTNO ,nvl(ENROLLMENTNO || '[' || studentname,' ') || ']' as ENROLLMENTNO1 from studentmaster sm  where DEACTIVE='N' and institutecode='"+hm.get("instituteCode")+"' and academicyear='"+hm.get("academicYear")+"' and programcode='"+hm.get("programCode")+"'  and branchcode='"+hm.get("branchCode")+"'");
                   // System.out.println(""+sb.toString());
                    op.append("<option value='' selected>Select EnrollMent No</option>");
                   // if(hm.get("instituteCode")!=null && !hm.get("instituteCode").equals("") && !hm.get("academicYear").equals("0") && !hm.get("academicYear").equals("") && !hm.get("programCode").equals("0") && !hm.get("programCode").equals("") &&!hm.get("branchCode").equals("0") && !hm.get("branchCode").equals(""))
                   // op.append("<option value=''></option>");
                    break;

                case EventCombo:
                    sb.append(" select ITEVENTID , ITEVENTCODE ||' - '||ITEVENTDESCRIPTION from AP#ITEVENTMASTER where INSTITUTECODE='JIIT' and sysdate between ITEVENTFROMDATE and ITEVENTTODATE and nvl(EVENTCOMPLETED,'N') <>'Y' and nvl(DEACTIVE,'N')='N' ");
                    op.append("<option value='' selected>Select Event Code</option>");
                    break;
                case academicyearcomboAllYearWithAll:
                    sb.append(" select distinct nvl(A.academicyear,'')academicyear ,nvl(A.academicyear,'') academicyear1 from academicyearmaster A  where nvl(deactive,'N')='N' and nvl(closed,'N')='N' and rownum<=10  order by academicyear desc");
                    op.append("<option value='' selected>Select Academic Year</option>");
                    break;
                case examCodeCombo:
                    if(hm.get("programCode").equals("ALL"))
                    {
                    sb.append("  select distinct nvl(A.EXAMCODE,'')EXAMCODE ,nvl(A.EXAMCODE,'') EXAMCODE1 from STUDENTREGISTRATION A  where institutecode='" + hm.get("instituteCode") + "' and academicyear='" + hm.get("academicYear") + "'");
                    }else if(hm.get("branchCode").equals("ALL")){
                    sb.append("  select distinct nvl(A.EXAMCODE,'')EXAMCODE ,nvl(A.EXAMCODE,'') EXAMCODE1 from STUDENTREGISTRATION A  where institutecode='" + hm.get("instituteCode") + "' and academicyear='" + hm.get("academicYear") + "' and programcode='" + hm.get("programCode") + "'");
                    }else if(hm.get("programCode").equals("") && hm.get("branchCode").equals(""))
                    {
                    sb.append("  select distinct nvl(A.EXAMCODE,'')EXAMCODE ,nvl(A.EXAMCODE,'') EXAMCODE1 from STUDENTREGISTRATION A  where institutecode='" + hm.get("instituteCode") + "' and academicyear='" + hm.get("academicYear") + "'");
                    }else if(!hm.get("programCode").equals("") && hm.get("branchCode").equals(""))
                    {
                        sb.append("  select distinct nvl(A.EXAMCODE,'')EXAMCODE ,nvl(A.EXAMCODE,'') EXAMCODE1 from STUDENTREGISTRATION A  where institutecode='" + hm.get("instituteCode") + "' and academicyear='" + hm.get("academicYear") + "' and programcode='" + hm.get("programCode") + "' ");
                    }else
                    {
                        sb.append("  select distinct nvl(A.EXAMCODE,'')EXAMCODE ,nvl(A.EXAMCODE,'') EXAMCODE1 from STUDENTREGISTRATION A  where institutecode='" + hm.get("instituteCode") + "' and academicyear='" + hm.get("academicYear") + "' and programcode='" + hm.get("programCode") + "' and branchcode='" + hm.get("branchCode") + "'");
                    }
                    op.append("<option value='' selected>Select Exam Code</option>");
                    break;
                case subjectCombo:
                    sb.append("  select distinct nvl(A.SUBJECTID,'')SUBJECTID ,NVL(A.SUBJECTCODE||'-'||A.SUBJECT,'')SUBJECT, A.Subject from v#studentltpdetail A  where institutecode='" + hm.get("instituteCode") + "' and examcode='" + hm.get("examCode") + "' and LTP='" + hm.get("ltp") + "' order by A.SUBJECT");
                    break;
                case quotaCombo:
                    sb.append("  select distinct nvl(A.QUOTA,'')QUOTA ,nvl(A.QUOTA,'') QUOTA1 from studentmaster A  where QUOTA IS NOT NULL and institutecode='"+hm.get("instituteCode")+"' and academicyear='"+hm.get("academicYear")+"' ORDER BY QUOTA ");
                    op.append("<option value='' selected>Select Quota</option>");
                    if(hm.get("instituteCode")!=null && !hm.get("instituteCode").equals("") && !hm.get("academicYear").equals("0") && !hm.get("academicYear").equals(""))
                    op.append("<option value='ALL'>All</option>");
                    break;
                case companyCodeCombo:
                    sb.append("  select distinct nvl(A.COMPANYCODE,'')COMPANYCODE ,nvl(A.COMPANYCODE,'') COMPANYCODE1 from companymaster A  where NVL(A.DEACTIVE,'N')='N' ");
                    op.append("<option value='' selected>Select Company Code</option>");
                    op.append("<option value='ALL'>ALL</option>");
                    break;
                case employeeTypeCombo:
                    sb.append("  select distinct nvl(A.EMPLOYEETYPE,'')EMPLOYEETYPE ,nvl(A.EMPLOYEETYPE,'') EMPLOYEETYPE1 from EMPLOYEEMASTER A  where A.EMPLOYEETYPE IS NOT NULL ");
                    op.append("<option value='' selected>Select Employee Type</option>");
                    op.append("<option value='ALL'>ALL</option>");
                    break;
                case academicYearComboWithInstCode:
                    sb.append(" select distinct nvl(A.academicyear,'')academicyear ,nvl(A.academicyear,'') academicyear1 from academicyearmaster A  where nvl(deactive,'N')='N' and nvl(closed,'N')='N' and institutecode='" + hm.get("instituteCode") + "' order by academicyear desc");
                    op.append("<option value='' selected>Select Academic Year</option>");
                    break;
                case examCodeComboSSM:
                    sb.append(" select distinct nvl(A.EXAMCODE,'')EXAMCODE ,nvl(A.EXAMCODE,'') EXAMCODE1 from EXAMMASTER A  where nvl(A.deactive,'N')='N' and A.institutecode='" + hm.get("instituteCode") + "' order by EXAMCODE");
                    op.append("<option value='' selected>Select Academic Year</option>");
                    break;
                case programComboAE:
                    sb.append(" SELECT DISTINCT NVL(BDT.PROGRAMCODE,'')PROGRAMCODE,NVL(BDT.PROGRAMCODE,'')PROGRAMCODE1\n"
                            + "    FROM SUBJECTMASTER A,\n"
                            + "         PR#STUDENTSUBJECTCHOICE B,\n"
                            + "         PR#ELECTIVESUBJECTS C,\n"
                            + "         PR#DepartmentSubjectTagging BDT\n"
                            + "   WHERE     A.INSTITUTECODE = B.INSTITUTECODE\n"
                            + "         AND A.INSTITUTECODE = C.INSTITUTECODE\n"
                            + "         AND B.SUBJECTTYPE = 'E'\n"
                            + "         AND B.INSTITUTECODE = '"+hm.get("instituteCode")+"'\n"
                            + "         AND A.SUBJECTID = B.SUBJECTID\n"
                            + "         AND A.SUBJECTID = C.SUBJECTID\n"
                            + "         AND b.ExamCode = C.ExamCode\n"
                            + "         AND B.EXAMCODE = '"+hm.get("examCode")+"'\n"
                            + "         AND B.SEMESTERTYPE = DECODE ('ALL', 'ALL', B.SEMESTERTYPE, 'ALL')\n"
                            + "         AND B.SUBJECTTYPE = 'E'\n"
                            + "         AND (b.INSTITUTECODE, b.EXAMCODE) IN\n"
                            + "                (SELECT PE.INSTITUTECODE, PE.ExamCode\n"
                            + "                   FROM PREVENTMASTER PE\n"
                            + "                  WHERE     PE.INSTITUTECODE = '"+hm.get("instituteCode")+"'\n"
                            + "                        AND PE.EXAMCODE = '"+hm.get("examCode")+"'\n"
                            + "                        AND NVL (PE.PRCOMPLETED, 'N') = 'N'\n"
                            + "                        AND NVL (PE.PRBROADCAST, 'N') = 'Y'\n"
                            + "                        AND NVL (PE.PRREQUIREDFOR, 'N') <> 'S'\n"
                            + "                        AND NVL (PE.DEACTIVE, 'N') = 'N'\n"
                            + "                        AND (PE.INSTITUTECODE, PE.PREVENTCODE) IN\n"
                            + "                               (SELECT D.INSTITUTECODE, D.PREVENTCODE\n"
                            + "                                  FROM PREVENTS D\n"
                            + "                                 WHERE D.MEMBERTYPE <> 'S'\n"
                            + "                                       AND MEMBERID = '"+hm.get("employeeID")+"'\n"
                            + "                                       AND NVL (D.LOADDISTRIBUTIONSTATUS, 'N') =\n"
                            + "                                              'N'\n"
                            + "                                       AND NVL (D.DEACTIVE, 'N') = 'N'))\n"
                            + "         AND NVL (A.DEACTIVE, 'N') = 'N'\n"
                            + "         AND NVL (B.DEACTIVE, 'N') = 'N'\n"
                            + "         AND NVL (C.Deactive, 'N') = 'N'\n"
                            + "         AND B.INSTITUTECODE = BDT.INSTITUTECODE\n"
                            + "         AND B.ACADEMICYEAR = BDT.ACADEMICYEAR\n"
                            + "         AND B.PROGRAMCODE = BDT.PROGRAMCODE\n"
                            + "         AND B.TAGGINGFOR = BDT.TAGGINGFOR\n"
                            + "         AND B.SECTIONBRANCH = BDT.SECTIONBRANCH\n"
                            + "         AND C.INSTITUTECODE = BDT.INSTITUTECODE\n"
                            + "         AND BDT.DEPARTMENTCODE IN (SELECT Departmentcode\n"
                            + "                                      FROM HODList\n"
                            + "                                     WHERE EmployeeID = '"+hm.get("employeeID")+"')\n"
                            + "         AND a.SUBJECTID = BDT.SUBJECTID\n"
                            + "         AND b.SUBJECTID = bdt.SUBJECTID\n"
                            + "         AND b.EXAMCODE = bdt.EXAMCODE\n"
                            + "         AND c.SUBJECTID = bdt.SUBJECTID\n"
                            + "         AND c.EXAMCODE = bdt.examcode\n"
                            + "GROUP BY BDT.PROGRAMCODE");
                    break;
                case branchComboAE:
                    sb.append("  SELECT DISTINCT NVL(BDT.SECTIONBRANCH,'')SECTIONBRANCH,NVL(BDT.SECTIONBRANCH,'')SECTIONBRANCH1\n"
                            + "    FROM SUBJECTMASTER A,\n"
                            + "         PR#STUDENTSUBJECTCHOICE B,\n"
                            + "         PR#ELECTIVESUBJECTS C,\n"
                            + "         PR#DepartmentSubjectTagging BDT\n"
                            + "   WHERE     A.INSTITUTECODE = B.INSTITUTECODE\n"
                            + "         AND A.INSTITUTECODE = C.INSTITUTECODE\n"
                            + "         AND B.SUBJECTTYPE = 'E'\n"
                            + "         AND B.INSTITUTECODE = '"+hm.get("instituteCode")+"'\n"
                            + "         AND A.SUBJECTID = B.SUBJECTID\n"
                            + "         AND A.SUBJECTID = C.SUBJECTID\n"
                            + "         AND b.ExamCode = C.ExamCode\n"
                            + "         AND B.EXAMCODE = '"+hm.get("examCode")+"'\n"
                            + "         AND B.SEMESTERTYPE = DECODE ('ALL', 'ALL', B.SEMESTERTYPE, 'ALL')\n"
                            + "         AND B.SUBJECTTYPE = 'E'\n"
                            + "         AND (b.INSTITUTECODE, b.EXAMCODE) IN\n"
                            + "                (SELECT PE.INSTITUTECODE, PE.ExamCode\n"
                            + "                   FROM PREVENTMASTER PE\n"
                            + "                  WHERE     PE.INSTITUTECODE = '"+hm.get("instituteCode")+"'\n"
                            + "                        AND PE.EXAMCODE = '"+hm.get("examCode")+"'\n"
                            + "                        AND NVL (PE.PRCOMPLETED, 'N') = 'N'\n"
                            + "                        AND NVL (PE.PRBROADCAST, 'N') = 'Y'\n"
                            + "                        AND NVL (PE.PRREQUIREDFOR, 'N') <> 'S'\n"
                            + "                        AND NVL (PE.DEACTIVE, 'N') = 'N'\n"
                            + "                        AND (PE.INSTITUTECODE, PE.PREVENTCODE) IN\n"
                            + "                               (SELECT D.INSTITUTECODE, D.PREVENTCODE\n"
                            + "                                  FROM PREVENTS D\n"
                            + "                                 WHERE D.MEMBERTYPE <> 'S'\n"
                            + "                                       AND MEMBERID = '"+hm.get("employeeID")+"'\n"
                            + "                                       AND NVL (D.LOADDISTRIBUTIONSTATUS, 'N') =\n"
                            + "                                              'N'\n"
                            + "                                       AND NVL (D.DEACTIVE, 'N') = 'N'))\n"
                            + "         AND NVL (A.DEACTIVE, 'N') = 'N'\n"
                            + "         AND NVL (B.DEACTIVE, 'N') = 'N'\n"
                            + "         AND NVL (C.Deactive, 'N') = 'N'\n"
                            + "         AND B.INSTITUTECODE = BDT.INSTITUTECODE\n"
                            + "         AND B.ACADEMICYEAR = BDT.ACADEMICYEAR\n"
                            + "         AND B.PROGRAMCODE = BDT.PROGRAMCODE\n"
                            + "         AND B.TAGGINGFOR = BDT.TAGGINGFOR\n"
                            + "         AND B.SECTIONBRANCH = BDT.SECTIONBRANCH\n"
                            + "         AND C.INSTITUTECODE = BDT.INSTITUTECODE\n"
                            + "         AND BDT.DEPARTMENTCODE IN (SELECT Departmentcode\n"
                            + "                                      FROM HODList\n"
                            + "                                     WHERE EmployeeID = '"+hm.get("employeeID")+"')\n"
                            + "         AND a.SUBJECTID = BDT.SUBJECTID\n"
                            + "         AND b.SUBJECTID = bdt.SUBJECTID\n"
                            + "         AND b.EXAMCODE = bdt.EXAMCODE\n"
                            + "         AND c.SUBJECTID = bdt.SUBJECTID\n"
                            + "         AND c.EXAMCODE = bdt.examcode\n"
                            +"          AND BDT.PROGRAMCODE IN("+hm.get("programName")+")"
                            + "GROUP BY BDT.SECTIONBRANCH");
                    break;
                case subjectsComboAE:
                    sb.append("  SELECT DISTINCT NVL(A.SUBJECTID,'')SUBJECTID,NVL(A.SUBJECT,'')SUBJECT\n"
                            + "    FROM SUBJECTMASTER A,\n"
                            + "         PR#STUDENTSUBJECTCHOICE B,\n"
                            + "         PR#ELECTIVESUBJECTS C,\n"
                            + "         PR#DepartmentSubjectTagging BDT\n"
                            + "   WHERE     A.INSTITUTECODE = B.INSTITUTECODE\n"
                            + "         AND A.INSTITUTECODE = C.INSTITUTECODE\n"
                            + "         AND B.SUBJECTTYPE = 'E'\n"
                            + "         AND B.INSTITUTECODE = '" + hm.get("instituteCode") + "'\n"
                            + "         AND A.SUBJECTID = B.SUBJECTID\n"
                            + "         AND A.SUBJECTID = C.SUBJECTID\n"
                            + "         AND b.ExamCode = C.ExamCode\n"
                            + "         AND B.EXAMCODE = '" + hm.get("examCode") + "'\n"
                            + "         AND B.SEMESTERTYPE = DECODE ('ALL', 'ALL', B.SEMESTERTYPE, 'ALL')\n"
                            + "         AND B.SUBJECTTYPE = 'E'\n"
                            + "         AND (b.INSTITUTECODE, b.EXAMCODE) IN\n"
                            + "                (SELECT PE.INSTITUTECODE, PE.ExamCode\n"
                            + "                   FROM PREVENTMASTER PE\n"
                            + "                  WHERE     PE.INSTITUTECODE = '" + hm.get("instituteCode") + "'\n"
                            + "                        AND PE.EXAMCODE = '" + hm.get("examCode") + "'\n"
                            + "                        AND NVL (PE.PRCOMPLETED, 'N') = 'N'\n"
                            + "                        AND NVL (PE.PRBROADCAST, 'N') = 'Y'\n"
                            + "                        AND NVL (PE.PRREQUIREDFOR, 'N') <> 'S'\n"
                            + "                        AND NVL (PE.DEACTIVE, 'N') = 'N'\n"
                            + "                        AND (PE.INSTITUTECODE, PE.PREVENTCODE) IN\n"
                            + "                               (SELECT D.INSTITUTECODE, D.PREVENTCODE\n"
                            + "                                  FROM PREVENTS D\n"
                            + "                                 WHERE D.MEMBERTYPE <> 'S'\n"
                            + "                                       AND MEMBERID = '" + hm.get("employeeID") + "'\n"
                            + "                                       AND NVL (D.LOADDISTRIBUTIONSTATUS, 'N') =\n"
                            + "                                              'N'\n"
                            + "                                       AND NVL (D.DEACTIVE, 'N') = 'N'))\n"
                            + "         AND NVL (A.DEACTIVE, 'N') = 'N'\n"
                            + "         AND NVL (B.DEACTIVE, 'N') = 'N'\n"
                            + "         AND NVL (C.Deactive, 'N') = 'N'\n"
                            + "         AND B.INSTITUTECODE = BDT.INSTITUTECODE\n"
                            + "         AND B.ACADEMICYEAR = BDT.ACADEMICYEAR\n"
                            + "         AND B.PROGRAMCODE = BDT.PROGRAMCODE\n"
                            + "         AND B.TAGGINGFOR = BDT.TAGGINGFOR\n"
                            + "         AND B.SECTIONBRANCH = BDT.SECTIONBRANCH\n"
                            + "         AND C.INSTITUTECODE = BDT.INSTITUTECODE\n"
                            + "         AND BDT.DEPARTMENTCODE IN (SELECT Departmentcode\n"
                            + "                                      FROM HODList\n"
                            + "                                     WHERE EmployeeID = '" + hm.get("employeeID") + "')\n"
                            + "         AND a.SUBJECTID = BDT.SUBJECTID\n"
                            + "         AND b.SUBJECTID = bdt.SUBJECTID\n"
                            + "         AND b.EXAMCODE = bdt.EXAMCODE\n"
                            + "         AND c.SUBJECTID = bdt.SUBJECTID\n"
                            + "         AND c.EXAMCODE = bdt.examcode\n"
                            + "         AND BDT.PROGRAMCODE IN(" + hm.get("programName") + ")\n"
                            + "         AND BDT.SECTIONBRANCH IN(" + hm.get("branch") + ")\n"
                            + "GROUP BY BDT.SECTIONBRANCH,\n"
                            + "         BDT.ACADEMICYEAR,\n"
                            + "         BDT.TAGGINGFOR,\n"
                            + "         BDT.SECTIONBRANCH,\n"
                            + "         B.ElectiveCode,\n"
                            + "          A.SUBJECTID,\n"
                            + "         NVL (A.Subject,''),\n"
                            + "         NVL (C.SubjectRunning, 'N'),\n"
                            + "         C.CUSTOMFINALIZED,\n"
                            + "         B.SUBJECTTYPE,\n"
                            + "         B.SEMESTER,\n"
                            + "         B.SEMESTERTYPE,\n"
                            + "         B.EXAMCODE");
                    break;
                case admissionYearCombo:
                    sb.append(" SELECT DISTINCT substr(APPLICATIONSLNO ,1,7)applicationslno,substr(APPLICATIONSLNO ,1,7)applicationslno1 FROM c#mbaapplicationmaster order by applicationslno");
                    op.append("<option value='' selected>Select Admission Year</option>");
                    break;
                case bbaadmissionYearCombo:
                    sb.append(" SELECT DISTINCT substr(APPLICATIONSLNO ,1,7)applicationslno,substr(APPLICATIONSLNO ,1,7)applicationslno1 FROM c#bbaapplicationmaster order by applicationslno");
                    op.append("<option value='' selected>Select Admission Year</option>");
                    break;
                case designationComboReport:
                    if (hm.get("employeeType").equals("ALL") && hm.get("companyCode").equals("ALL")) {
                        sb.append(" select distinct em.designationcode,dm.designation from employeemaster em,designationmaster dm where EM.DESIGNATIONCODE=DM.DESIGNATIONCODE and  EM.DESIGNATIONCODE is not null order by designation");
                    } else if (hm.get("employeeType").equals("ALL") && !hm.get("companyCode").equals("ALL")) {
                        sb.append(" select distinct em.designationcode,dm.designation from employeemaster em,designationmaster dm where EM.DESIGNATIONCODE=DM.DESIGNATIONCODE and  EM.DESIGNATIONCODE is not null AND COMPANYCODE='" + hm.get("companyCode") + "' order by designation");
                    } else if (!hm.get("employeeType").equals("ALL") && hm.get("companyCode").equals("ALL")) {
                        sb.append(" select distinct em.designationcode,dm.designation from employeemaster em,designationmaster dm where EM.DESIGNATIONCODE=DM.DESIGNATIONCODE and  EM.DESIGNATIONCODE is not null AND EMPLOYEETYPE='" + hm.get("employeeType") + "' order by designation");
                    } else if (!hm.get("employeeType").equals("ALL") && !hm.get("companyCode").equals("ALL")) {
                        sb.append(" select distinct em.designationcode,dm.designation from employeemaster em,designationmaster dm where EM.DESIGNATIONCODE=DM.DESIGNATIONCODE and  EM.DESIGNATIONCODE is not null AND EMPLOYEETYPE='" + hm.get("employeeType") + "' AND COMPANYCODE='" + hm.get("companyCode") + "' order by designation");
                    }
                    op.append("<option value='0' selected>Select Designation</option>");
                    if (hm.get("employeeType") != null && !hm.get("employeeType").equals("") && hm.get("companyCode") != null && !hm.get("companyCode").equals("")) {
                        op.append("<option value='ALL'>ALL</option>");
                    }
                    break;
                case departmentComboReport:
                    if (hm.get("employeeType").equals("ALL") && hm.get("companyCode").equals("ALL")) {
                        sb.append(" SELECT DISTINCT em.DEPARTMENTCODE,DM.DEPARTMENT FROM EMPLOYEEMASTER em,DEPARTMENTMASTER dm WHERE EM.DEPARTMENTCODE=DM.DEPARTMENTCODE and  EM.DEPARTMENTCODE is not null order by DEPARTMENT");
                    } else if (hm.get("employeeType").equals("ALL") && !hm.get("companyCode").equals("ALL")) {
                        sb.append(" SELECT DISTINCT em.DEPARTMENTCODE,DM.DEPARTMENT FROM EMPLOYEEMASTER em,DEPARTMENTMASTER dm WHERE EM.DEPARTMENTCODE=DM.DEPARTMENTCODE and  EM.DEPARTMENTCODE is not null AND COMPANYCODE='" + hm.get("companyCode") + "'  order by DEPARTMENT");
                    } else if (!hm.get("employeeType").equals("ALL") && hm.get("companyCode").equals("ALL")) {
                        sb.append(" SELECT DISTINCT em.DEPARTMENTCODE,DM.DEPARTMENT FROM EMPLOYEEMASTER em,DEPARTMENTMASTER dm WHERE EM.DEPARTMENTCODE=DM.DEPARTMENTCODE and  EM.DEPARTMENTCODE is not null AND EMPLOYEETYPE='" + hm.get("employeeType") + "'  order by DEPARTMENT");
                    } else if (!hm.get("employeeType").equals("ALL") && !hm.get("companyCode").equals("ALL")) {
                        sb.append("SELECT DISTINCT em.DEPARTMENTCODE,DM.DEPARTMENT FROM EMPLOYEEMASTER em,DEPARTMENTMASTER dm WHERE EM.DEPARTMENTCODE=DM.DEPARTMENTCODE and  EM.DEPARTMENTCODE is not null AND EMPLOYEETYPE='" + hm.get("employeeType") + "' AND COMPANYCODE='" + hm.get("companyCode") + "'  order by DEPARTMENT");
                    }
                    op.append("<option value='0' selected>Select Department</option>");
                    if (hm.get("employeeType") != null && !hm.get("employeeType").equals("") && hm.get("companyCode") != null && !hm.get("companyCode").equals("")) {
                        op.append("<option value='ALL'>ALL</option>");
                    }
                    break;
                case gradeComboReport:
                    if (hm.get("employeeType").equals("ALL") && hm.get("companyCode").equals("ALL")) {
                        sb.append(" SELECT DISTINCT NVL(GRADECODE,'')GRADECODE,NVL(GRADECODE,'')GRADECODE1 FROM EMPLOYEEMASTER  WHERE  GRADECODE is not null  order by GRADECODE");
                    } else if (hm.get("employeeType").equals("ALL") && !hm.get("companyCode").equals("ALL")) {
                        sb.append(" SELECT DISTINCT NVL(GRADECODE,'')GRADECODE,NVL(GRADECODE,'')GRADECODE1 FROM EMPLOYEEMASTER  WHERE  GRADECODE is not null AND COMPANYCODE='"+hm.get("companyCode")+"'  order by GRADECODE");
                    } else if (!hm.get("employeeType").equals("ALL") && hm.get("companyCode").equals("ALL")) {
                        sb.append(" SELECT DISTINCT NVL(GRADECODE,'')GRADECODE,NVL(GRADECODE,'')GRADECODE1 FROM EMPLOYEEMASTER  WHERE  GRADECODE is not null AND EMPLOYEETYPE='"+hm.get("employeeType")+"'  order by GRADECODE");
                    } else if (!hm.get("employeeType").equals("ALL") && !hm.get("companyCode").equals("ALL")) {
                        sb.append("SELECT DISTINCT NVL(GRADECODE,'')GRADECODE,NVL(GRADECODE,'')GRADECODE1 FROM EMPLOYEEMASTER  WHERE  GRADECODE is not null AND EMPLOYEETYPE='"+hm.get("employeeType")+"' AND COMPANYCODE='"+hm.get("companyCode")+"'  order by GRADECODE");
                    }
                    op.append("<option value='0' selected>Select Grade</option>");
                    if (hm.get("employeeType") != null && !hm.get("employeeType").equals("") && hm.get("companyCode") != null && !hm.get("companyCode").equals("")) {
                       op.append("<option value='ALL'>ALL</option>");
                    }
                    break;
            }
            ///////////////////////////////////////////////////////////////////////////////
          dbConnection = getcomboConnection();

          Statement stmt=dbConnection.createStatement();

          rs=stmt.executeQuery(sb.toString());
           while (rs.next()) {
                if(hm.containsKey("preselect") && rs.getString(1).equals(hm.get("preselect").toString())){
                op.append("<option selected value='" + rs.getString(1) + "' >" + rs.getString(2) + "</option>");

                }else{
                op.append("<option value='" + rs.getString(1) + "' >" + rs.getString(2) + "</option>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            rs=null;
            dbConnection.close();
            }
            return op.toString();
    }

    public void closeconnection() throws SQLException
    {
        dbConnection.close();
    }
   

    public String getMultiCommonCombo(String jdata) throws SQLException  {
        Map hm = new HashMap();
        ObjectMapper mapper = new ObjectMapper();
        StringBuilder sb = new StringBuilder();
        StringBuilder op = new StringBuilder();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap<String, String>>() {
            });

            switch (CommonComboData.mcase.valueOf((String) hm.get("comboId").toString())) {
                case programecomboFaculty:
                    sb.append("  select distinct nvl(pm.programcode,'')as programcode ,nvl(pm.programname,'') as programname from programmaster pm  where nvl(deactive,'N')='N' and programcode not in('M.T-P','PHDI','PHDP','PHDS','VEDANT') AND PROGRAMNAME NOT IN('MASTER OF TECHNOLOGY','5 YEAR DUAL DEGREE PROGRAMME  BACHELOR OF TECHNOLOGY-MASTER','5 YEAR DUAL DEGREE PROGRAMME BACHELOR OF TECHNOLOGY - MASTER OF BUSINESS ADMINIS')  order by programname  ");
                    break;
            }
            ///////////////////////////////////////////////////////////////////////////////
               dbConnection =getcomboConnection();
//             if(dbConnection.isClosed()){
//                dbConnection=DBUtility.getConnection(dbConnection);
//                 }
            pStmt = dbConnection.prepareStatement(sb.toString());
//            if (rs != null) {
//            try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
//            rs = null;
//            }
            rs = pStmt.executeQuery();
             String selectedValues="";
             if(!hm.get("selectedValues").toString().equals("") && hm.get("selectedValues").toString()!=null){
            selectedValues=hm.get("selectedValues").toString();
             }

            while (rs.next()) {
              if(hm.containsKey("selectedValues") && selectedValues.contains(rs.getString(1))){
                op.append("<option  value='" + rs.getString(1) + "' selected>" + rs.getString(2) + "</option>");
               }else
               {
                   op.append("<option  value='" + rs.getString(1) + "'  >" + rs.getString(2) + "</option>");
               }


            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally
        {
            //try {
                rs=null;
            dbConnection.close();
        }
        return op.toString();
    }

    public String getDepartmentCombo(String jdata)throws SQLException  {
        Map hm = new HashMap();
        ObjectMapper mapper = new ObjectMapper();
        StringBuilder sb = new StringBuilder();
        StringBuilder op = new StringBuilder();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap<String, String>>() {
            });

            switch (CommonComboData.mcase.valueOf((String) hm.get("comboId").toString())) {
                case departmentComboShortNameisNull:
                    sb.append("  SELECT DISTINCT NVL (dm.DEPARTMENTCODE, '') AS DEPARTMENTCODE,NVL (dm.DEPARTMENT, '') AS DEPARTMENT FROM departmentmaster dm WHERE  NVL (dm.deactive, 'N') = 'N' and department is not null order by DEPARTMENT ");
                    op.append("<option value='' selected>Select Department Name</option>");
            }
            ///////////////////////////////////////////////////////////////////////////////
               dbConnection = getcomboConnection();
            pStmt = dbConnection.prepareStatement(sb.toString());
//            if (rs != null) {
//            try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
//            rs = null;
//            }
            rs = pStmt.executeQuery();
             String selectedValue="";
             if(!hm.get("selectedValue").toString().equals("") && hm.get("selectedValue").toString()!=null){
            selectedValue=hm.get("selectedValue").toString();
             }

            while (rs.next()) {
              if(hm.containsKey("selectedValue") && selectedValue.equals(rs.getString(1))){
                op.append("<option selected value='" + rs.getString(1) + "' >" + rs.getString(2) + "</option>");
               }else
               {
                   op.append("<option  value='" + rs.getString(1) + "'  >" + rs.getString(2) + "</option>");
               }


            }
        } catch (Exception e) {
            e.printStackTrace();
        }
         finally
        {
//            try {
            rs=null;
            dbConnection.close();

  //          } catch (SQLException ex) {
    //            ex.printStackTrace();//Logger.getLogger(CommonComboData.class.getName()).log(Level.SEVERE, null, ex);
      //      }
        }
        return op.toString();
    }

    public String getCourseCodeCombo(String jdata) throws SQLException {
        Map hm = new HashMap();
        ObjectMapper mapper = new ObjectMapper();
        StringBuilder sb = new StringBuilder();
        StringBuilder op = new StringBuilder();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap<String, String>>() {
            });

            switch (CommonComboData.mcase.valueOf((String) hm.get("comboId").toString())) {
                case courseCodeCombo:
                    sb.append("select distinct nvl(pm.programcode,'')as programcode ,nvl(pm.programcode,'') as programcode1 from programmaster pm  where nvl(pm.deactive,'N')='N' and pm.programcode not in('M.T-P','PHDI','PHDP','PHDS','VEDANT') AND pm.PROGRAMNAME NOT IN('MASTER OF TECHNOLOGY','5 YEAR DUAL DEGREE PROGRAMME  BACHELOR OF TECHNOLOGY-MASTER','5 YEAR DUAL DEGREE PROGRAMME BACHELOR OF TECHNOLOGY - MASTER OF BUSINESS ADMINIS') order by programcode");
                    op.append("<option value='' selected>Select Course Code</option>");
            }
            ///////////////////////////////////////////////////////////////////////////////
             dbConnection =getcomboConnection();
            pStmt = dbConnection.prepareStatement(sb.toString());
//            if (rs != null) {
//            try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
//            rs = null;
//            }
            rs = pStmt.executeQuery();
            while (rs.next()) {

                   op.append("<option  value='" + rs.getString(1) + "'  >" + rs.getString(2) + "</option>");



            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally
        {
          rs=null;
         dbConnection.close();
        }
        return op.toString();
    }

    public String getPublicationCombo(String jdata)throws SQLException {
        Map hm = new HashMap();
        ObjectMapper mapper = new ObjectMapper();
        StringBuilder sb = new StringBuilder();
        StringBuilder op = new StringBuilder();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap<String, String>>() {
            });

            switch (CommonComboData.mcase.valueOf((String) hm.get("comboId").toString())) {
                case publicationCombo:
                    sb.append("  SELECT DISTINCT NVL (am.publicationid, '') AS publicationid,NVL (am.title, '') AS title FROM ap#publicationmaster am WHERE  NVL (am.deactive, 'N') = 'N' and appublicationtypeid='"+hm.get("publicationTypeID")+"' order by title ");
                    op.append("<option value='' selected>Select Publication Name</option>");
                    break;
            }
            ///////////////////////////////////////////////////////////////////////////////
             dbConnection = getcomboConnection();
            pStmt = dbConnection.prepareStatement(sb.toString());
//            if (rs != null) {
//            try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
//            rs = null;
//            }
            rs = pStmt.executeQuery();


            while (rs.next()) {

                   if(hm.containsKey("preselect") && hm.get("preselect").equals(rs.getString(1))){
                op.append("<option selected value='" + rs.getString(1) + "' >" + rs.getString(2) + "</option>");
               }else
               {
                   op.append("<option  value='" + rs.getString(1) + "'  >" + rs.getString(2) + "</option>");
               }




            }
        } catch (Exception e) {
            e.printStackTrace();
        }
         finally
        {
          rs=null;
          dbConnection.close();
        }
        return op.toString();
    }

    public String commonJspCombo (String jdata) throws SQLException
    {
    return getCommonCombo(jdata);
    }
    public String commonMultiJspCombo(String jdata) throws SQLException
    {
    return getMultiCommonCombo(jdata);
    }
    public String commonDepartmentCombo(String jdata)throws SQLException
    {
    return getDepartmentCombo(jdata);
    }
    public String commonCourseCodeCombo(String jdata) throws SQLException
    {
    return getCourseCodeCombo(jdata);
    }
    public String commonPublicationCombo(String jdata) throws SQLException
    {
    return getPublicationCombo(jdata);
    }


    public boolean getCheck(String st)
    {
        if(!st.equals("") && !st.equals("0"))
        {
            return true;
        }else
        {
            return false;
        }
    }


   public Connection getcomboConnection(){
    try {
            if (dbConnection != null && !dbConnection.isClosed()) {
                return dbConnection;
            }
            String serverName = "172.16.7.156";
            String portNumber = "1521";
            String sid = "cmp11";
            String dbUrl = "jdbc:oracle:thin:@" + serverName + ":" + portNumber + ":" + sid;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                dbConnection = DriverManager.getConnection(dbUrl, "JIIT16072020", "JIIT16072020");
            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
          return dbConnection;

   }

}