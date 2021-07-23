/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import jdbc.DBUtility;

/**
 *
 * @author nipun.gupta
 */
public class SubjectAllocationDB {

    private Connection dbConnection;
    private PreparedStatement pStmt;
    private ResultSet rs;

    public SubjectAllocationDB() {
        dbConnection = DBUtility.getConnection();
    }

    public String getProgramCode(String instCode, String examCode, String id) {
        StringBuilder queryForProgramCode = new StringBuilder();
        String _programcode = "";
        try {
            queryForProgramCode.append("SELECT DISTINCT NVL(BDT.PROGRAMCODE,'')PROGRAMCODE,NVL(BDT.PROGRAMCODE,'')PROGRAMCODE1 FROM SUBJECTMASTER A,PR#STUDENTSUBJECTCHOICE B,PR#ELECTIVESUBJECTS C,");
            queryForProgramCode.append("PR#DepartmentSubjectTagging BDT WHERE A.INSTITUTECODE = B.INSTITUTECODE AND A.INSTITUTECODE = C.INSTITUTECODE AND B.SUBJECTTYPE = 'E' AND B.INSTITUTECODE = '" + instCode + "'");
            queryForProgramCode.append(" AND A.SUBJECTID = B.SUBJECTID AND A.SUBJECTID = C.SUBJECTID AND b.ExamCode = C.ExamCode AND B.EXAMCODE = '" + examCode + "'");
            queryForProgramCode.append(" AND B.SEMESTERTYPE = DECODE ('ALL', 'ALL', B.SEMESTERTYPE, 'ALL') AND B.SUBJECTTYPE = 'E' AND (b.INSTITUTECODE, b.EXAMCODE) IN");
            queryForProgramCode.append(" (SELECT PE.INSTITUTECODE, PE.ExamCode FROM PREVENTMASTER PE WHERE PE.INSTITUTECODE = '" + instCode + "' AND PE.EXAMCODE = '" + examCode + "' AND NVL (PE.PRCOMPLETED, 'N') = 'N'");
            queryForProgramCode.append(" AND NVL (PE.PRBROADCAST, 'N') = 'Y' AND NVL (PE.PRREQUIREDFOR, 'N') <> 'S' AND NVL (PE.DEACTIVE, 'N') = 'N' AND (PE.INSTITUTECODE, PE.PREVENTCODE) IN");
            queryForProgramCode.append(" (SELECT D.INSTITUTECODE, D.PREVENTCODE FROM PREVENTS D WHERE D.MEMBERTYPE <> 'S' AND MEMBERID = '" + id + "' AND NVL (D.LOADDISTRIBUTIONSTATUS, 'N') ='N'");
            queryForProgramCode.append(" AND NVL (D.DEACTIVE, 'N') = 'N')) AND NVL (A.DEACTIVE, 'N') = 'N' AND NVL (B.DEACTIVE, 'N') = 'N' AND NVL (C.Deactive, 'N') = 'N' AND B.INSTITUTECODE = BDT.INSTITUTECODE");
            queryForProgramCode.append(" AND B.ACADEMICYEAR = BDT.ACADEMICYEAR AND B.PROGRAMCODE = BDT.PROGRAMCODE AND B.TAGGINGFOR = BDT.TAGGINGFOR AND B.SECTIONBRANCH = BDT.SECTIONBRANCH");
            queryForProgramCode.append(" AND C.INSTITUTECODE = BDT.INSTITUTECODE AND BDT.DEPARTMENTCODE IN (SELECT Departmentcode FROM HODList WHERE EmployeeID = '" + id + "')");
            queryForProgramCode.append(" AND a.SUBJECTID = BDT.SUBJECTID AND b.SUBJECTID = bdt.SUBJECTID AND b.EXAMCODE = bdt.EXAMCODE AND c.SUBJECTID = bdt.SUBJECTID AND c.EXAMCODE = bdt.examcode GROUP BY BDT.PROGRAMCODE");
            pStmt = dbConnection.prepareStatement(queryForProgramCode.toString());
            rs = pStmt.executeQuery();

            while (rs.next()) {
                _programcode = _programcode + "'" + rs.getString("PROGRAMCODE1") + "'" + ",";
            }
            _programcode = _programcode.substring(0, _programcode.length() - 1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return _programcode;
    }
    
    public String getSectionBranch(String progCode,String instCode,String examCode,String id)
    {
        StringBuilder queryForBranch = new StringBuilder();
        String _branch = "";
        try {
            queryForBranch.append("SELECT DISTINCT NVL(BDT.SECTIONBRANCH,'')SECTIONBRANCH,NVL(BDT.SECTIONBRANCH,'')SECTIONBRANCH1 FROM SUBJECTMASTER A, PR#STUDENTSUBJECTCHOICE B,");
            queryForBranch.append(" PR#ELECTIVESUBJECTS C,PR#DepartmentSubjectTagging BDT WHERE A.INSTITUTECODE = B.INSTITUTECODE AND A.INSTITUTECODE = C.INSTITUTECODE");
            queryForBranch.append(" AND B.SUBJECTTYPE = 'E' AND B.INSTITUTECODE = '" + instCode + "' AND A.SUBJECTID = B.SUBJECTID AND A.SUBJECTID = C.SUBJECTID AND b.ExamCode = C.ExamCode");
            queryForBranch.append(" AND B.EXAMCODE = '" + examCode + "' AND B.SEMESTERTYPE = DECODE ('ALL', 'ALL', B.SEMESTERTYPE, 'ALL') AND B.SUBJECTTYPE = 'E'");
            queryForBranch.append(" AND (b.INSTITUTECODE, b.EXAMCODE) IN (SELECT PE.INSTITUTECODE, PE.ExamCode FROM PREVENTMASTER PE WHERE PE.INSTITUTECODE = '" + instCode + "'");
            queryForBranch.append(" AND PE.EXAMCODE = '" + examCode + "' AND NVL (PE.PRCOMPLETED, 'N') = 'N' AND NVL (PE.PRBROADCAST, 'N') = 'Y' AND NVL (PE.PRREQUIREDFOR, 'N') <> 'S'");
            queryForBranch.append(" AND NVL (PE.DEACTIVE, 'N') = 'N' AND (PE.INSTITUTECODE, PE.PREVENTCODE) IN (SELECT D.INSTITUTECODE, D.PREVENTCODE FROM PREVENTS D");
            queryForBranch.append(" WHERE D.MEMBERTYPE <> 'S' AND MEMBERID = '" + id + "' AND NVL (D.LOADDISTRIBUTIONSTATUS, 'N') ='N' AND NVL (D.DEACTIVE, 'N') = 'N'))");
            queryForBranch.append(" AND NVL (A.DEACTIVE, 'N') = 'N' AND NVL (B.DEACTIVE, 'N') = 'N' AND NVL (C.Deactive, 'N') = 'N' AND B.INSTITUTECODE = BDT.INSTITUTECODE");
            queryForBranch.append(" AND B.ACADEMICYEAR = BDT.ACADEMICYEAR AND B.PROGRAMCODE = BDT.PROGRAMCODE AND B.TAGGINGFOR = BDT.TAGGINGFOR AND B.SECTIONBRANCH = BDT.SECTIONBRANCH");
            queryForBranch.append(" AND C.INSTITUTECODE = BDT.INSTITUTECODE AND BDT.DEPARTMENTCODE IN (SELECT Departmentcode FROM HODList WHERE EmployeeID = '" + id + "')");
            queryForBranch.append(" AND a.SUBJECTID = BDT.SUBJECTID AND b.SUBJECTID = bdt.SUBJECTID AND b.EXAMCODE = bdt.EXAMCODE AND c.SUBJECTID = bdt.SUBJECTID AND c.EXAMCODE = bdt.examcode");
            queryForBranch.append(" AND BDT.PROGRAMCODE IN(" + progCode + ") GROUP BY BDT.SECTIONBRANCH");
            pStmt = dbConnection.prepareStatement(queryForBranch.toString());
            rs = pStmt.executeQuery();

            while (rs.next()) {
                _branch = _branch + "'" + rs.getString("SECTIONBRANCH1") + "'" + ",";
            }
            _branch = _branch.substring(0, _branch.length() - 1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return _branch;
    }
}
