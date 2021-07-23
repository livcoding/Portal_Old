/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.io.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdbc.DBUtility;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import tietwebkiosk.DBHandler;
import tietwebkiosk.GlobalFunctions;
import tietwebkiosk.OLTEncryption;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

/**
 *
 * @author nipun.gupta
 */
public class ReconMarksEntryExcelGenerateDB extends HttpServlet {

    private Connection dbConnection;
    private PreparedStatement pStmt;
    Map<String, Object[]> data = new LinkedHashMap<String, Object[]>();
    GlobalFunctions gb = new GlobalFunctions();
    DBHandler db = new DBHandler();
    ResultSet rs = null, rssub = null, rsm = null, newrs = null, rs1 = null;
    String mChkMemID = "", mMemberID = "", mMemberType = "", mDMemberType = "", mMemberName = "", mMemberCode = "", mInst = "", mDMemberCode = "", mCheckFstid = "", mSMarks = "";
    String mComp = "", mSelf = "", mIC = "", mEC = "", mSC = "", mList = "", mOrder = "", mEvent = "", mSE = "", qry = "", qry1 = "", qry2 = "", mMOP = "";
    String time = " ";
    int len = 0, pos = 0, ctr = 0, counter = 1;
    double mWeight = 0, mMaxmarks = 0;
    StringBuffer filename;
    public ReconMarksEntryExcelGenerateDB() {
        dbConnection = DBUtility.getConnection();
    }

    public void selectSaveUpdateData(HttpServletRequest req, HttpServletResponse res) throws IOException {

        try {
            OLTEncryption enc = new OLTEncryption();
            if (req.getSession().getAttribute("MemberID") == null) {
                mMemberID = "";
            } else {
                mMemberID = req.getSession().getAttribute("MemberID").toString().trim();
            }

            if (req.getSession().getAttribute("MemberType") == null) {
                mMemberType = "";
            } else {
                mMemberType = req.getSession().getAttribute("MemberType").toString().trim();
            }

            if (req.getSession().getAttribute("MemberName") == null) {
                mMemberName = "";
            } else {
                mMemberName = req.getSession().getAttribute("MemberName").toString().trim();
            }

            if (req.getSession().getAttribute("MemberCode") == null) {
                mMemberCode = "";
            } else {
                mMemberCode = req.getSession().getAttribute("MemberCode").toString().trim();
            }

            if (req.getSession().getAttribute("InstituteCode") == null) {
                mInst = "";
            } else {
                mInst = req.getSession().getAttribute("InstituteCode").toString().trim();
            }

            if (req.getSession().getAttribute("CompanyCode") == null) {
                mComp = "";
            } else {
                mComp = req.getSession().getAttribute("CompanyCode").toString().trim();
            }

            if (req.getSession().getAttribute("Click") != null) {
                mSelf = req.getSession().getAttribute("Click").toString().trim();
            } else {
                mSelf = "";
            }
            if (req.getSession().getAttribute("InstCode") != null) {
                mIC = req.getSession().getAttribute("InstCode").toString().trim();
            } else {
                mIC = "";
            }
            if (req.getSession().getAttribute("Exam") != null) {
                mEC = req.getSession().getAttribute("Exam").toString().trim();
            } else {
                mEC = "";
            }
            if (req.getSession().getAttribute("Subject") != null) {
                mSC = req.getSession().getAttribute("Subject").toString().trim();
            } else {
                mSC = "";
            }
            if (req.getSession().getAttribute("listorder") != null) {
                mList = req.getSession().getAttribute("listorder").toString().trim();
            } else {
                mList = "EnrollNo";
            }
            if (req.getSession().getAttribute("order") != null) {
                mOrder = req.getSession().getAttribute("order").toString().trim();
            } else {
                mOrder = "";
            }
            if (req.getSession().getAttribute("Event") != null) {
                mEvent = req.getSession().getAttribute("Event").toString().trim();
            } else {
                mEvent = "";
            }
            len = mEvent.length();
            pos = mEvent.indexOf("#");
            if (pos > 0) {
                mSE = mEvent.substring(0, pos);
            } else {
                mSE = mEvent.toString().trim();
            }


            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
                mDMemberCode = enc.decode(mMemberCode);
                mDMemberType = enc.decode(mMemberType);
                String mCode = enc.decode(mMemberCode);
                mChkMemID = enc.decode(req.getSession().getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(req.getSession().getAttribute("MemberType").toString().trim());
                String mIPAddress = req.getSession().getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(req.getSession().getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk = null;
              //  filelist=new ArrayList();
                filename=new StringBuffer();
               
                //-----------------------------
                //-- Enable Security Page Level
                //-----------------------------
                qry = "Select WEBKIOSK.ShowLink('401','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk = db.getRowset(qry);
                if (RsChk.next() && RsChk.getString("SL").equals("Y")) {

                    String mSubcode = "", qrysub = "", mNam = "";
                    qrysub = "select subject,subjectcode from subjectmaster where InstituteCode='" + mIC + "' and subjectID='" + mSC + "' and nvl(deactive,'N')='N' ";
                    //System.out.println(qrysub);
                    rssub = db.getRowset(qrysub);
                    if (rssub.next()) {
                        mNam = rssub.getString("subject");
                        mSubcode = rssub.getString("subjectcode");
                    } else {
                        mNam = "";
                        mSubcode = "";
                    }
                    /*String qryy = "Select to_char(sysdate,'DD/MM/YYYY HH:MI:SS AM')dd from dual";*/
                    String name = "";
                    String query123 = "select employeename,to_char(sysdate,'DDMMYYYY HHMI AM')dd from employeemaster where employeeid='" + mChkMemID + "'";
                    //out.println(query123);
                    /*rssub = db.getRowset(qryy);
                    if (rssub.next()) {
                    time = rssub.getString("dd");
                    }*/
                    rssub = db.getRowset(query123);
                    if (rssub.next()) {
                        name = rssub.getString("employeename");
                        time = rssub.getString("dd");
                    }
                    String Evename = "";
                    String evequery = "";

                    if (mSelf.equals("Self")) {
                        /*    qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                        qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                        qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N' and ";
                        qry = qry + " examcode='" + mEC + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
                        //qry=qry+" AND employeeid='"+mChkMemID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry = qry + " AND ((EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mIC + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mChkMemID + "')) and facultytype=decode('" + mDMemberType + "','E','I','E'))";
                        //qry=qry+" AND employeeid in (Select '"+mChkMemID+"' EmployeeID from dual UNION Select EmployeeID from FacultySubjectTagging where FSTID in (SELECT FSTID FROM MULTIFACULTYSUBJECTTAGGING WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and EMPLOYEEID='"+mChkMemID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry = qry + " AND EVENTSUBEVENT='" + mEvent + "' ";
                        qry = qry + "  AND ( (studentid, fstid) IN (SELECT studentid, fstid FROM StudentEventSubjectMarks WHERE EVENTSUBEVENT = '"+mEvent+"'";
                        qry = qry + " AND NVL (DEACTIVE, 'N') = 'N' AND NVL (locked, 'N') = 'N') OR (studentid, fstid) NOT IN (SELECT studentid, fstid ";
                        qry = qry + " FROM StudentEventSubjectMarks WHERE EVENTSUBEVENT = '"+mEvent+"' AND NVL (DEACTIVE, 'N') = 'N' ";
                        qry = qry + " AND NVL (locked, 'N') = 'N')) AND STUDENTID NOT IN (SELECT DISTINCT studentid FROM debarstudentdetail WHERE NVL (REEXAMINATION, 'N') = 'Y') ";
                        qry = qry + " GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                        qry = qry + " order by " + mList + " " + mOrder + " ";*/
                        ctr = 0;
                        counter = 0;
                        data.clear();

                        evequery="SELECT  DISTINCT EMPLOYEEID , EVENTSUBEVENT  FROM MR#ReconciledDetail WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='" + mEC + "'" +
                                " AND SUBJECTID= '" + mSC + "' AND  RECONCILED='V' AND EMPLOYEEID='" + mChkMemID + "'  UNION" +
                                " SELECT '"+mChkMemID+"' , '"+ mEvent +"'  FROM DUAL";
                         ResultSet rsmeve = db.getRowset(evequery);
                         while(rsmeve.next()){
                        ctr = 0;
                        counter = 0;
                        data.clear();
                         Evename=rsmeve.getString("EVENTSUBEVENT");
                         String EmployeeID=rsmeve.getString("EMPLOYEEID");
                         createexcel(EmployeeID, req, res,Evename);
                          System.out.println("Excel db calling....");
                         }
                       
                    } else if (!mSelf.equals("Self")) {

                        qry=" Select  distinct B.EMPLOYEEID ,'"+mEvent+"' event  from EX#SUBJECTGRADECOORDINATOR A,FacultySubjectTagging B  WHERE" +
                                "  A.INSTITUTECODE=B.INSTITUTECODE   AND    A.FSTID= B.FSTID   AND    A.FACULTYID='" + mChkMemID + "' AND" +
                                "  B.INSTITUTECODE='" + mIC + "' And B.ExamCode='" + mEC + "' and B.SubjectID='" + mSC + "' and (B.LTP='L' OR B.PROJECTSUBJECT='Y'" +
                                " OR B.LTP='P') union  select employeeid ,EVENTSUBEVENT from MR#ReconciledDetail where  employeeid in" +
                                "( Select  distinct B.EMPLOYEEID   from EX#SUBJECTGRADECOORDINATOR A,FacultySubjectTagging B  WHERE" +
                                "  A.INSTITUTECODE=B.INSTITUTECODE   AND    A.FSTID= B.FSTID   AND    A.FACULTYID='" + mChkMemID + "' AND" +
                                "  B.INSTITUTECODE='" + mIC + "' And B.ExamCode='" + mEC + "' and B.SubjectID='" + mSC + "' and (B.LTP='L' OR B.PROJECTSUBJECT='Y'" +
                                " OR B.LTP='P') )  and forEVENTSUBEVENT ='"+mEvent+"'  and reconciled ='V'";

                        /*qry = "select  distinct EmployeeID,EmployeeCode from V#EXAMEVENTSUBJECTTAGGING ";
                        qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N' and ";
                        qry = qry + " examcode='" + mEC + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
                        qry = qry + " And EVENTSUBEVENT='" + mEvent + "' ";
                        qry = qry + " AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='" + mComp + "' and INSTITUTECODE='" + mIC + "' and FACULTYTYPE=decode('" + mDMemberType + "','E','I','E') and FACULTYID='" + mChkMemID + "')";*/

                        newrs = db.getRowset(qry);
                        ArrayList empList = new ArrayList();
                        while (newrs.next()) {
                            String EmpId = newrs.getString("EMPLOYEEID");
                             String DBevent = newrs.getString("event");
                            if (EmpId != null && !EmpId.equalsIgnoreCase("")) {
                                empList.add(EmpId+"*"+DBevent);

                            }
                        }
                        for (int i = 0; i < empList.size(); i++) {
                            ctr = 0;
                            counter = 0;
                            data.clear();
                            String emp = empList.get(i).toString();
                            if (emp != null && !emp.equals("")) {
                                String []data=emp.split("\\*");
                                String eve=data[1].toString();
                                String Ecode=data[0].toString();
                                createexcel(Ecode, req, res,eve);
                               
                            }
                        }
                    }
                    //req.setAttribute("List", filename.toString());
                    req.getSession().setAttribute("downfilename", filename.toString());
                    res.sendRedirect(req.getContextPath() + "/EmployeeFiles/ExamActivity/Reconsuccess.jsp");



                }
            }


        } catch (Exception e) {

            e.printStackTrace();

        }


    }

    public void createexcel(String EmpID, HttpServletRequest req, HttpServletResponse res,String Evename) {

        if (mSelf.equals("Self")) {
            qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
            qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course  ,EmployeeCode from V#EXAMEVENTSUBJECTTAGGING ";
            qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N'  and  nvl(STUDENTLTPDEACTIVE,'N')='N' and studentid   IN  (select studentid from studentregistration  where nvl(REGALLOW,'N')='Y' and EXAMCODE='" + mEC + "'  and institutecode='" + mIC + "'   ) and ";
            qry = qry + " examcode='" + mEC + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
            qry = qry + " AND (EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) ";
            qry = qry + " AND EVENTSUBEVENT='" + Evename + "'  and ( (studentid,fstid) in (select  studentid,fstid from StudentEventSubjectMarks  where EVENTSUBEVENT='" + Evename + "'  and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N'	) OR  (studentid,fstid) NOT in (select  studentid,fstid from StudentEventSubjectMarks  where EVENTSUBEVENT='" + Evename + "'  and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N'	)  )";
            qry = qry + " and ltp IN ( decode((select APPLICABLEFOR from  exameventmaster where examcode = '" + mEC + "' AND EXAMEVENTCODE = '" + Evename + "' and institutecode = '" + mIC + "'),'LT','L','LP','L','P' ) )   GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode ,EmployeeCode ";
            qry = qry + " order by " + mList + " " + mOrder + " ";

            qry1 = "select WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
            qry1 += " where institutecode='" + mIC + "' and  examcode='" + mEC + "' ";
            qry1 += " AND ((EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mChkMemID + "')) and facultytype=decode('" + mDMemberType + "','E','I','E'))";
            qry1 += " And EVENTSUBEVENT='" + Evename + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' AND  NVL (deactive, 'N') = 'N' ";

        } else {
            qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
            qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course ,EmployeeCode from V#EXAMEVENTSUBJECTTAGGING ";
            qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N'  and nvl(locked,'N')='N'  and ";
            qry = qry + " examcode='" + mEC + "'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
            qry = qry + " And EVENTSUBEVENT='" + mEvent + "' ";
            qry = qry + " And Employeeid='" + EmpID + "' ";
            qry = qry + " AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='" + mComp + "' and INSTITUTECODE='" + mIC + "' and FACULTYTYPE=decode('" + mDMemberType + "','E','I','E') and FACULTYID='" + mChkMemID + "')";
            qry = qry + " GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode ,EmployeeCode ";
            qry = qry + " order by " + mList + " " + mOrder + " ";

            qry1 = "select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
            qry1 += " where institutecode='" + mIC + "' and  examcode='" + mEC + "' ";
            qry1 += " And EVENTSUBEVENT='" + mEvent + "'  ";
            qry1 += " and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' AND  NVL (deactive, 'N') = 'N'";
        }
        try {
            rsm = db.getRowset(qry1);
            if (rsm.next()) {
                mMOP = rsm.getString("MARKSORPERCENTAGE");
                mMaxmarks = rsm.getDouble("MAXMARKS");
                mWeight = rsm.getDouble("WEIGHTAGE");
            }

            rs = db.getRowset(qry);
            String Empcode="";

           
            while (rs.next()) {
                Empcode=rs.getString("EMPLOYEECODE");

                if (ctr == 0) {
                    data.put(String.valueOf(ctr), new Object[]{"Sr. No.", "Enrollment No.", "Student Name", Evename + " Marks", "Course(Section/Branch)", "Sem."});
                }
                qry2 = "Select fstid,studentid,nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
                qry2 = qry2 + " nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
                qry2 = qry2 + " where INSTITUTECODE='" + mIC + "' and EXAMCODE='" + mEC + "' and ";
                qry2 = qry2 + " EVENTSUBEVENT='" + Evename + "' and   ";
                qry2 = qry2 + " fstid='" + rs.getString("fstid") + "' and STUDENTID='" + rs.getString("studentid") + "' ";
                //System.out.print("JILIT - "+qry);
                rs1 = db.getRowset(qry2);
                if (rs1.next()) {
                    mSMarks = rs1.getString("MARKSAWARDED1");
                    if (mSMarks != null && mSMarks.equalsIgnoreCase("-1")) {
                        mSMarks = rs1.getString("DETAINED");
                    }

                }
                ctr++;
                counter++;
                if (mSMarks.equalsIgnoreCase("M") || mSMarks.equalsIgnoreCase("A") || mSMarks.equalsIgnoreCase("D")|| mSMarks.equalsIgnoreCase("U")) {
                    data.put(String.valueOf(counter), new Object[]{counter, rs.getString("EnrollNo"), rs.getString("StudentName"), mSMarks, rs.getString("Course"), rs.getString("Semester")});
                } else {

                    data.put(String.valueOf(counter), new Object[]{counter, rs.getString("EnrollNo"), rs.getString("StudentName"), Double.parseDouble(mSMarks), rs.getString("Course"), rs.getString("Semester")});
                }
                
            }

            HSSFWorkbook workbook = new HSSFWorkbook();



            //Create a blank sheet
            HSSFSheet sheet = workbook.createSheet("Employee Data");

            sheet.setColumnWidth((short) 0, (short) (2000));
            sheet.setColumnWidth((short) 1, (short) (5000));
            sheet.setColumnWidth((short) 2, (short) (10000));
            sheet.setColumnWidth((short) 3, (short) (4000));
            sheet.setColumnWidth((short) 4, (short) (5900));
//

            HSSFFont font = workbook.createFont();
            font.setFontName(HSSFFont.FONT_ARIAL);
            font.setFontHeightInPoints((short) 10);
            font.setBoldweight(font.BOLDWEIGHT_NORMAL);
            //   font.setBoldweight((short)12);



            HSSFCellStyle unlockedCellStyle = workbook.createCellStyle();
            unlockedCellStyle.setWrapText(true);
            //  unlockedCellStyle.set
            unlockedCellStyle.setLocked(true);


            //This data needs to be written (Object[])




            //Iterate over data and write to sheet
            Set<String> keyset = data.keySet();
            int rownum = 0;
            for (String key : keyset) {
                HSSFRow row = sheet.createRow(rownum++);
                Object[] objArr = data.get(key);
                int cellnum = 0;
                for (Object obj : objArr) {
                    HSSFCell cell = row.createCell((short) cellnum++);
                    if (obj instanceof String) {
                        HSSFCellStyle style = workbook.createCellStyle();//Create style
                        font.setBoldweight(font.BOLDWEIGHT_BOLD);//Make font bold
                        font = workbook.createFont();//Create font
                        style.setFont(font);
                        style.setFillBackgroundColor(new HSSFColor.YELLOW().getIndex());
                        //     style.setFillBackgroundColor(new HSSFColor.RED().getIndex());
                        // style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
                        style.setWrapText(true);
                        cell.setCellValue((String) obj);


                        if (rownum == 1) {
                            cell.setCellStyle(style);

                        }
                    } else if (obj instanceof Double) {
                        cell.setCellValue((Double) obj);
                        cell.setCellStyle(unlockedCellStyle);
                    } else if (obj instanceof Integer) {
                        cell.setCellValue((Integer) obj);
                        cell.setCellStyle(unlockedCellStyle);

                    }
                }
            }
            try {
                //Write the workbook in file system
                sheet.setProtect(true);

                // Create file on Desktop Name Institute Code+Event+Subject+Sub-Event+Employee Code===========
                String fileType = mIC + "-" + mEC + "-" + mSC + "-" + Evename + "-" + Empcode + ".xls";
                String filepath = req.getSession().getAttribute("svrpath").toString();

                //C:\\Program Files\\Apache Software Foundation\\Apache Tomcat 6.0.18\\webapps\\Excel\\

                // Create file on Server  Name Institute Code+Event+Subject+Sub-Event+Employee Code===========
                FileOutputStream out2 = new FileOutputStream(new File(filepath + fileType));
                //  FileOutputStream out2 = new FileOutputStream(new File("C:\\jboss\\jboss-as-7.1.1.Final\\standalone\\deployments\\ROOT.war\\Excel\\"+fileType));
                filename.append(fileType+",");
              //  filelist.add(fileType);
                workbook.write(out2);
                out2.close();

                 if(Evename.equalsIgnoreCase(mEvent)){
                 OLTEncryption enc = new OLTEncryption();
                 String mCode = enc.decode(mMemberCode);
                 String Insqry="insert into mr#excelfiledetail ( INSTITUTECODE ,EXAMCODE,SUBJECTID,EVENTSUBEVENT,EMPLOYEEID,FILENAME,LASTBACKUPFILE" +
                 ",STATUS,LASTACCESS,CREATEDBY,CREATEDDATE )" +
                 " Values('"+mIC+"','"+mEC+"','"+mSC+"','"+mEvent+"','"+EmpID+"','"+fileType+"','','N',sysdate,'"+mCode+"',sysdate)";
                 int ins= db.insertRow(Insqry);
               //  System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"+ins+"   " +mCode);
                 }else{
                 String updevent="update MR#ReconciledDetail set RECONCILED ='R'  where INSTITUTECODE='"+mIC+"'  and SubjectID='"+mSC+"' " +
                  "And ExamCode='"+mEC+"'  and EventSubEvent='"+Evename+"' And Employeeid='"+EmpID+"' and foreventsubevent='"+mEvent+"' ";
                 int upd = db.update(updevent);
               //   System.out.println("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"+upd);
                 }

                //     req.setAttribute("mEvent",mEvent);
                //    String newfilepath=URLEncoder.encode(fileType,"UTF-8");
                req.getSession().setAttribute("Excel", fileType);



            } catch (Exception e) {
                e.printStackTrace();

            }
        } catch (Exception e) {
            e.printStackTrace();
        }



    }
}
