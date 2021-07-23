/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
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
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author nipun.gupta
 */
public class MarksEntryExcelGenerateDB {

    private Connection dbConnection;
    private PreparedStatement pStmt;

    public MarksEntryExcelGenerateDB() {
        dbConnection = DBUtility.getConnection();
    }

    public void selectSaveUpdateData(HttpServletRequest req, HttpServletResponse res) throws IOException {

        try {
            Map<String, Object[]> data = new LinkedHashMap<String, Object[]>();
            GlobalFunctions gb = new GlobalFunctions();
            OLTEncryption enc = new OLTEncryption();
            DBHandler db = new DBHandler();
            ResultSet rs = null, rssub = null, rsm = null, rs1 = null;
            String mMemberID = "", mMemberType = "", mDMemberType = "", mMemberName = "", mMemberCode = "", mInst = "", mDMemberCode = "", mCheckFstid = "", mSMarks = "";
            String mComp = "", mSelf = "", mIC = "", mEC = "", mSC = "", mList = "", mOrder = "", mEvent = "", mSE = "", qry = "", qry1 = "", qry2 = "", mMOP = "";
            String time=" ";
            int len = 0, pos = 0, ctr = 0,counter=1;
            double mWeight = 0, mMaxmarks = 0;
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
                String mChkMemID = enc.decode(req.getSession().getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(req.getSession().getAttribute("MemberType").toString().trim());
                String mIPAddress = req.getSession().getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(req.getSession().getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk = null;
                //-----------------------------
                //-- Enable Security Page Level
                //-----------------------------
                qry = "Select WEBKIOSK.ShowLink('60','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
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
                    if (mSelf.equals("Self")) {
                        qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
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
                        qry = qry + " order by " + mList + " " + mOrder + " ";

                        qry1 = "select WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                        qry1 += " where institutecode='" + mIC + "' and  examcode='" + mEC + "' ";
                        qry1 += " AND ((EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mChkMemID + "')) and facultytype=decode('" + mDMemberType + "','E','I','E'))";
                        qry1 += " And EVENTSUBEVENT='" + mEvent + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' AND  NVL (deactive, 'N') = 'N' ";

                    } else if (!mSelf.equals("Self")) {
                        qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                        qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                        qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                        qry = qry + " examcode='" + mEC + "'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
                        qry = qry + " And EVENTSUBEVENT='" + mEvent + "' ";
                        qry = qry + " AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='" + mComp + "' and INSTITUTECODE='" + mIC + "' and FACULTYTYPE=decode('" + mDMemberType + "','E','I','E') and FACULTYID='" + mChkMemID + "')";
                        qry = qry + " GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                        qry = qry + " order by " + mList + " " + mOrder + " ";

                        qry1 = "select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                        qry1 += " where institutecode='" + mIC + "' and  examcode='" + mEC + "' ";
                        qry1 += " And EVENTSUBEVENT='" + mEvent + "'  ";
                        qry1 += " and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' AND  NVL (deactive, 'N') = 'N'";
                    }
                    //System.out.println(qry);
                    rsm = db.getRowset(qry1);
                    if (rsm.next()) {
                        mMOP = rsm.getString("MARKSORPERCENTAGE");
                        mMaxmarks = rsm.getDouble("MAXMARKS"); 
                        mWeight = rsm.getDouble("WEIGHTAGE");
                    }

                    rs = db.getRowset(qry);

                    while (rs.next()) {  






                        if (ctr == 0) {
                            data.put(String.valueOf(ctr), new Object[]{"Sr. No.", "Enrollment No.", "Student Name", mEvent + " Marks", "Course(Section/Branch)", "Sem."});
                        }
                        qry2 = "Select fstid,studentid,nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
                        qry2 = qry2 + " nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
                        qry2 = qry2 + " where INSTITUTECODE='" + mIC + "' and EXAMCODE='" + mEC + "' and ";
                        qry2 = qry2 + " EVENTSUBEVENT='" + mEvent + "' and   ";
                        qry2 = qry2 + " fstid='" + rs.getString("fstid") + "' and STUDENTID='" + rs.getString("studentid") + "' ";
                          	System.out.print("JILIT - "+qry);
                        rs1 = db.getRowset(qry2);
                        if (rs1.next()) {
                            mSMarks = rs1.getString("MARKSAWARDED1");

                        }
//                        boolean isChar = mSMarks.matches("[a-zA-z]{1}");
//                        boolean isDigit = mSMarks.matches("\\d{1}");
//                        System.out.println("isChar>>>>>>>>>>"+isChar);
//                        System.out.println("isDigit>>>>>>>>>>"+isDigit);
                        data.put(String.valueOf(counter), new Object[]{counter, rs.getString("EnrollNo"), rs.getString("StudentName"), Double.parseDouble(mSMarks), rs.getString("Course"), rs.getString("Semester")});
                        ctr++;
                        counter++;
                    }


                }
            }

           HSSFWorkbook  workbook = new HSSFWorkbook ();



            //Create a blank sheet
            HSSFSheet  sheet = workbook.createSheet("Employee Data");

            sheet.setColumnWidth((short)0,(short)(2000));
            sheet.setColumnWidth((short)1,(short)(5000));
            sheet.setColumnWidth((short)2,(short)(10000));
            sheet.setColumnWidth((short)3,(short)(4000));
            sheet.setColumnWidth((short)4,(short)(5900));
//

            HSSFFont font = workbook.createFont();
            font.setFontName(HSSFFont.FONT_ARIAL);
            font.setFontHeightInPoints((short)10);
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


                        if(rownum==1){
                        cell.setCellStyle(style);

                        }
                    } else if (obj instanceof Double) {
                        cell.setCellValue((Double) obj);
                        cell.setCellStyle(unlockedCellStyle);
                    }else if (obj instanceof Integer) {
                        cell.setCellValue((Integer) obj);
                        cell.setCellStyle(unlockedCellStyle);

                    }
                }
            }
            try {
                //Write the workbook in file system
                 sheet.setProtect(true);
               // FileOutputStream out = new FileOutputStream(new File("D://"+mIC+"\'"+mEC+"'\'"+mMemberName+"'\'"+mSC+"'\'"+time+".xlsx"));
                 FileOutputStream out = new FileOutputStream(new File("D://"+mIC+"\'"+mEC+"'\'"+mMemberName+"'\'"+mSC+".xls"));
                workbook.write(out);
                out.close();


                    String INPUT_FILE = "D://"+mIC+"\'"+mEC+"'\'"+mMemberName+"'\'"+mSC+".xls";
	            String OUTPUT_FILE = "D://"+mIC+"\'"+mEC+"'\'"+mMemberName+"'\'"+mSC+".zip";
                    File inputFile=new File(INPUT_FILE);
                    File zipOutPutFile=new File(OUTPUT_FILE);
                    FileOutputStream fileOutputStream = new FileOutputStream(zipOutPutFile);
	            ZipOutputStream zipOutputStream = new ZipOutputStream(fileOutputStream);
	            // a ZipEntry represents a file entry in the zip archive
	            // We name the ZipEntry after the original file's name
	            ZipEntry zipEntry = new ZipEntry(inputFile.getName());
	            zipOutputStream.putNextEntry(zipEntry);
	            FileInputStream fileInputStream = new FileInputStream(INPUT_FILE);
	            byte[] buf = new byte[1024];
	            int bytesRead;
	            // Read the input file by chucks of 1024 bytes
	            // and write the read bytes to the zip stream
	            while ((bytesRead = fileInputStream.read(buf)) > 0) {
	                zipOutputStream.write(buf, 0, bytesRead);
	            }
	            // close ZipEntry to store the stream to the file
	            zipOutputStream.closeEntry();
	            zipOutputStream.close();
	            fileOutputStream.close();
	           // System.out.println("Regular file :" + inputFile.getCanonicalPath()+" is zipped to archive :"+zipOutPutFile);

                res.setContentType("text/html");
                PrintWriter out_zipfile = res.getWriter();
                String filename = ""+mIC+"\'"+mEC+"'\'"+mMemberName+"'\'"+mSC+".zip";
                String filepath = "D://";
                res.setContentType("APPLICATION/OCTET-STREAM");
                res.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

                FileInputStream fileInputStream_zipfile = new FileInputStream(filepath + filename);

                int i;
                while ((i = fileInputStream_zipfile.read()) != -1) {
                    out_zipfile.write(i);
                }
                fileInputStream_zipfile.close();
                out_zipfile.close();



            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
