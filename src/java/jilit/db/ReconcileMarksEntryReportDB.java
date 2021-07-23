
package jilit.db;

import com.itextpdf.text.pdf.codec.Base64.InputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.ResultSet;
import java.util.Iterator;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import tietwebkiosk.DBHandler;
import tietwebkiosk.GlobalFunctions;
import tietwebkiosk.OLTEncryption;

/**
 *
 * @author nipun.gupta
 */
public class ReconcileMarksEntryReportDB {
    

    public void selectSaveUpdateData(HttpServletRequest req, HttpServletResponse res){
        try {
            //******************READ FROM JSP**********************************************************************************
            GlobalFunctions gb = new GlobalFunctions();
            OLTEncryption enc = new OLTEncryption();
            DBHandler db = new DBHandler();
            ResultSet rs = null, rssub = null, rsm = null, rs1 = null;
            String fstid="",studentid="";
            String mMemberID = "", mMemberType = "", mDMemberType = "", mMemberName = "", mMemberCode = "", mInst = "", mDMemberCode = "", mCheckFstid = "", mSMarks = "";
            String mComp = "", mSelf = "", mIC = "", mEC = "", mSC = "", mList = "", mOrder = "", mEvent = "", mSE = "", qry = "", qry1 = "", qry2 = "", mMOP = "",jspMarks="",excelMarks="";
            int len = 0, pos = 0, ctr = 0,counter=1;
            double mWeight = 0, mMaxmarks = 0;
            String mMemberName1="",mIC1="",mEC1="",mSC1="";


  if (req.getSession().getAttribute("MemberName") == null) {
                mMemberName1 = "";
            } else {
                mMemberName1 = req.getSession().getAttribute("MemberName").toString().trim();
            }
if (req.getSession().getAttribute("InstituteCode") == null) {
                mIC1 = "";
            } else {
                mIC1 = req.getSession().getAttribute("InstituteCode").toString().trim();
            }

if (req.getSession().getAttribute("Exam") != null) {
                mEC1 = req.getSession().getAttribute("Exam").toString().trim();
            } else {
                mEC1 = "";
            }
if (req.getSession().getAttribute("Subject") != null) {
                mSC1 = req.getSession().getAttribute("Subject").toString().trim();
            } else {
                mSC1 = "";
            }

   // System.out.print("D:/UPLOAD/"+mIC1+"\'"+mEC1+"'\'"+mMemberName1+"'\'"+mSC1+".xlsx");

    

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
                qry = "Select WEBKIOSK.ShowLink('399','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
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
                    String name = "", time = "";
                    String query123 ="select employeename,to_char(sysdate,'DD/MM/YYYY HH:MI:SS AM')dd from employeemaster where employeeid='" + mChkMemID + "'";
                    //out.println(query123);
                    rssub = db.getRowset(query123);  
                    if (rssub.next()) {
                        name = rssub.getString("employeename");
                        time = rssub.getString("dd");
                    }
                    if (mSelf.equals("Self")) {
                        //--------------------Queryy Commented as per Deepak Sir--------------------------------------------------------------//
                      /*  qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                        qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                        qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                        qry = qry + " examcode='" + mEC + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
                        //qry=qry+" AND employeeid='"+mChkMemID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry = qry + " AND ((EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mIC + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mChkMemID + "')) and facultytype=decode('" + mDMemberType + "','E','I','E'))";
                        //qry=qry+" AND employeeid in (Select '"+mChkMemID+"' EmployeeID from dual UNION Select EmployeeID from FacultySubjectTagging where FSTID in (SELECT FSTID FROM MULTIFACULTYSUBJECTTAGGING WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and EMPLOYEEID='"+mChkMemID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry = qry + " AND EVENTSUBEVENT='" + mEvent + "' ";
                        qry = qry + "  AND ( (studentid, fstid) IN (SELECT studentid, fstid FROM StudentEventSubjectMarks WHERE EVENTSUBEVENT = '"+mEvent+"'";
                        qry = qry + " AND NVL (DEACTIVE, 'N') = 'N' AND NVL (locked, 'N') = 'N') OR (studentid, fstid) NOT IN (SELECT studentid, fstid ";
                        qry = qry + " FROM StudentEventSubjectMarks WHERE EVENTSUBEVENT = '"+mEvent+"' AND NVL (DEACTIVE, 'N') = 'N' ";
                        qry = qry + " AND NVL (locked, 'N') = 'Y')) AND STUDENTID NOT IN (SELECT DISTINCT studentid FROM debarstudentdetail WHERE NVL (REEXAMINATION, 'N') = 'Y') ";
                        qry = qry + " GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                        qry = qry + " order by " + mList + " " + mOrder + " ";  */

                        //--------------------------------------New Added By Satendra------------------------------------------------//

                     /*  qry="SELECT fstid,NVL (studentid, ' ') studentid,NVL (studentname, ' ') StudentName,NVL (enrollmentno, ' ') EnrollNo,NVL (semester, 0) Semester,NVL (programcode, ' ')|| ' ('  || NVL (SECTIONBRANCH, ' ')|| ' - ' || subsectioncode || ')'";
                        qry=qry+" Course";
                        qry=qry+" FROM  V#EXAMEVENTSUBJECTTAGGING WHERE     institutecode = '" + mIC + "' AND NVL (DEACTIVE, 'N') = 'N' AND NVL (PROCEEDSECOND, 'N') = 'N' AND NVL (locked, 'N') = 'N' AND NVL (PUBLISHED, 'N') = 'N' AND examcode ='" + mEC + "' AND (ltp = 'L' OR (LTP = 'E' AND PROJECTSUBJECT = 'Y') OR LTP = 'P')  AND subjectID = '" + mSC + "'";
                        qry=qry+"AND ( (EMPLOYEEID = (SELECT  '" + mChkMemID + "' EmployeeID FROM DUAL)) OR (fstid IN (SELECT fstid FROM FACULTYSUBJECTTAGGING WHERE     companycode ='" + mComp + "'  AND institutecode = '" + mIC + "' AND facultytype = DECODE ('" + mDMemberType + "', 'E', 'I', 'E')    AND employeeid = '" + mChkMemID + "'))   AND facultytype = DECODE ('" + mDMemberType + "', 'E', 'I', 'E'))";
                        qry=qry+" AND ( (studentid, fstid) IN (SELECT studentid, fstid  FROM StudentEventSubjectMarks  WHERE   EVENTSUBEVENT = '"+mEvent+"' AND NVL (DEACTIVE, 'N') = 'N' ) OR (studentid, fstid) NOT IN  (SELECT studentid, fstid  FROM StudentEventSubjectMarks";
                        qry=qry+" WHERE     EVENTSUBEVENT ='"+mEvent+"'  AND NVL (DEACTIVE, 'N') = 'N'   ))  AND STUDENTID NOT IN (SELECT DISTINCT studentid FROM debarstudentdetail  WHERE NVL (REEXAMINATION, 'N') = 'Y')";
                        qry=qry+"GROUP BY fstid,studentid,  StudentName,  enrollmentno,  Semester,  programcode,  SECTIONBRANCH,  subsectioncode ORDER BY " + mList + " " + mOrder + " ";*/

                        qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
		qry=qry+ " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
		qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N'  and  nvl(STUDENTLTPDEACTIVE,'N')='N' and studentid   IN  (select studentid from studentregistration  where nvl(REGALLOW,'N')='Y' and EXAMCODE='"+mEC+"'  and institutecode='"+mIC+"'   ) and ";
		qry=qry+" examcode='"+mEC+"' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
		//qry=qry+" AND employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
                qry=qry+" AND (EMPLOYEEID=(Select '"+mChkMemID+"' EmployeeID from dual)) ";
		//qry=qry+" AND employeeid in (Select '"+mDMemberID+"' EmployeeID from dual UNION Select EmployeeID from FacultySubjectTagging where FSTID in (SELECT FSTID FROM MULTIFACULTYSUBJECTTAGGING WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and EMPLOYEEID='"+mDMemberID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                qry=qry+" AND EVENTSUBEVENT='"+mEvent+"'  and ( (studentid,fstid) in (select  studentid,fstid from StudentEventSubjectMarks  where EVENTSUBEVENT='"+mEvent+"'  and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N'	) OR  (studentid,fstid) NOT in (select  studentid,fstid from StudentEventSubjectMarks  where EVENTSUBEVENT='"+mEvent+"'  and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N'	)  )" ;
		//qry=qry+"  and STUDENTID NOT  IN (Select distinct studentid from debarstudentdetail where nvl(REEXAMINATION,'N' )='Y' and subjectID='"+mSC+"' and institutecode='"+mIC+"'  AND EVENTSUBEVENT = '"+mEvent+"' and examcode='"+mEC+"') ";
                qry=qry+" and ltp IN ( decode((select APPLICABLEFOR from  exameventmaster where examcode = '"+mEC+"' AND EXAMEVENTCODE = '"+mSE+"' and institutecode = '"+mIC+"'),'LT','L','LP','L','P' ) )   GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";


                        qry1 = "select WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                        qry1 += " where institutecode='" + mIC + "' and  examcode='" + mEC + "' ";
                        qry1 += " AND ((EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mChkMemID + "')) and facultytype=decode('" + mDMemberType + "','E','I','E'))";
                        qry1 += " And EVENTSUBEVENT='" + mEvent + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' AND  NVL (deactive, 'N') = 'N' ";

                    } else if (!mSelf.equals("Self")) {

                        // New Query changes 10.02.2017 
                        /*  qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                        qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                        qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                        qry = qry + " examcode='" + mEC + "'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
                        qry = qry + " And EVENTSUBEVENT='" + mEvent + "' ";
                        qry = qry + " AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='" + mComp + "' and INSTITUTECODE='" + mIC + "' and FACULTYTYPE=decode('" + mDMemberType + "','E','I','E') and FACULTYID='" + mChkMemID + "')";
                        qry = qry + " GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                        qry = qry + " order by " + mList + " " + mOrder + " ";*/
                        qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                        qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                        qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N'  and nvl(locked,'N')='N'  and ";
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


                             fstid=rs.getString("fstid");
                              studentid=rs.getString("studentid");

                        
                        if (ctr == 0) {
                            
                        }
                        qry2 = "Select fstid,studentid,nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
                        qry2 = qry2 + " nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
                        qry2 = qry2 + " where INSTITUTECODE='" + mIC + "' and EXAMCODE='" + mEC + "' and ";
                        qry2 = qry2 + " EVENTSUBEVENT='" + mEvent + "' and   ";
                        qry2 = qry2 + " fstid='" + rs.getString("fstid") + "' and STUDENTID='" + rs.getString("studentid") + "' ";

                       	//System.out.print("JILIT - "+qry+"<br><br><br><br>");

                        rs1 = db.getRowset(qry2);
                        if (rs1.next()) { 
                            mSMarks = rs1.getString("MARKSAWARDED1");
                            if(mSMarks!=null&& mSMarks.equalsIgnoreCase("-1")){
                                 mSMarks = rs1.getString("DETAINED");
                            }
                        }
                        jspMarks=jspMarks+mSMarks+",";

                         //System.out.print("jsp marks hhhhh"+mSMarks);
                        
                        ctr++;
                        counter++;
                    }
                    

                }
            }

           // System.out.print(db);
      //**********************************************READ FROM EXCEL*******************************************************************************
             try {

              String fileType=mIC+"-"+mEC+"-"+mSC+"-"+mEvent+"-"+mDMemberCode+".xls";
              req.getSession().setAttribute("filetype", fileType);
              String filepath2 = req.getSession().getAttribute("svrpath").toString();
              
              FileInputStream ExcelFileToRead = new FileInputStream(filepath2+fileType);
	      HSSFWorkbook  wb = new HSSFWorkbook(ExcelFileToRead);

	//	XSSFWorkbook test = new XSSFWorkbook();
		HSSFSheet sheet = wb.getSheetAt(0);

             int lastrow=sheet.getLastRowNum();
            //Iterate through each rows one by one
            //  Iterator<Row> rowIterator = sheet.iterator();
            for (int i=1;i<=lastrow;i++) {
                HSSFRow row=sheet.getRow(i);
                for (int cn = 0; cn < row.getLastCellNum(); cn++) {

                    HSSFCell cell = row.getCell((short)cn);
                    double stmarks = 0;
                    String smarks = "";
                     String convetred="";
                    //System.out.println("CELL: " + cn + " --> " + cell.toString());
                    if(cn==3){
                          if(cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                           String sValue=cell.getStringCellValue();

                        if(sValue.equalsIgnoreCase("M") || sValue.equalsIgnoreCase("A") || sValue.equalsIgnoreCase("D")|| sValue.equalsIgnoreCase("U")){
                        convetred=sValue;
                        }
                          }else{
                    stmarks=cell.getNumericCellValue();
                    smarks=Double.toString(stmarks);
                    convetred=convertItToString(smarks);
                     }
                    
                    excelMarks = excelMarks+","+convetred;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
             int count=0;
             String jspMarksArray[]=jspMarks.split(",");
             String excelMarksArray[]=excelMarks.split(",");
             String excelMarksArrayNew[]=new String[excelMarksArray.length-1];
             for(int x=1;x<excelMarksArray.length;x++)
             {
                 excelMarksArrayNew[count]=excelMarksArray[x];
                 count++;
             }
             
             String noDataFound="0";
             String foundInJspNotInExcel="0";
             String foundInExcelNotInJsp="0";
             String misMatchData="0"; 
             String dataMatches="0";
             for(int i=0;i<jspMarksArray.length;i++)
             {
                if (jspMarksArray[i].equals(""))
                {
                    jspMarksArray[i] = "-1.0"  ; 
                }

                  if (excelMarksArrayNew[i].equals("") && jspMarksArray[i].equals("")) {
                     noDataFound = "1";
                 }
                 
                 if (excelMarksArrayNew[i].equals("") && !jspMarksArray[i].equals("")) {
                     foundInJspNotInExcel = "1";
                 }
                 if (!excelMarksArrayNew[i].equals("") && jspMarksArray[i].equals("")) {
                     foundInExcelNotInJsp = "1";
                 }
                 
                 if (!excelMarksArrayNew[i].equals("") && !jspMarksArray[i].equals("") && !excelMarksArrayNew[i].equals(jspMarksArray[i])) {
                     misMatchData = "1";
                 }
                 if(!foundInJspNotInExcel.equals("1") && !foundInExcelNotInJsp.equals("1") && !misMatchData.equals("1") && !noDataFound.equals("1")){
                 if(!excelMarksArrayNew[i].equals("") && !jspMarksArray[i].equals("") && excelMarksArrayNew[i].equals(jspMarksArray[i]))
                 {
                 dataMatches="1";
                 }
                 }
                  if(misMatchData.equals("1")){

                      dataMatches="0";

                  }

             }


             //*************************************************************************************************************************
            res.sendRedirect(req.getContextPath()+"/EmployeeFiles/ExamActivity/ReconcileReport.jsp?noDataFound="+noDataFound+"&foundInJspNotInExcel="+foundInJspNotInExcel+"&foundInExcelNotInJsp="+foundInExcelNotInJsp+"&misMatchData="+misMatchData+"&dataMatches="+dataMatches);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    public String convertItToString(String number)
    {
        if(number.equals("0.0"))
    {
        number="0";
    }
    if(number.equals("1.0"))
    {
        number="1";
    }else if(number.equals("2.0"))
    {
      number="2";  
    }else if(number.equals("3.0"))
    {
      number="3";  
    }else if(number.equals("4.0"))
    {
      number="4";  
    }else if(number.equals("5.0"))
    {
      number="5";  
    }else if(number.equals("6.0"))
    {
      number="6";  
    }else if(number.equals("7.0"))
    {
      number="7";  
    }else if(number.equals("8.0"))
    {
      number="8";  
    }else if(number.equals("9.0"))
    {
      number="9";  
    }else if(number.equals("10.0"))
    {
      number="10";  
    }else if(number.equals("11.0"))
    {
      number="11";  
    }else if(number.equals("12.0"))
    {
      number="12";  
    }else if(number.equals("13.0"))
    {
      number="13";  
    }else if(number.equals("14.0"))
    {
      number="14";  
    }else if(number.equals("15.0"))
    {
      number="15";  
    }else if(number.equals("16.0"))
    {
      number="16";  
    }else if(number.equals("17.0"))
    {
      number="17";  
    }else if(number.equals("18.0"))
    {
      number="18";  
    }else if(number.equals("19.0"))
    {
      number="19";  
    }else if(number.equals("20.0"))
    {
      number="20";  
    }
    else if(number.equals("21.0"))
    {
      number="21";
    }else if(number.equals("22.0"))
    {
      number="22";
    }else if(number.equals("23.0"))
    {
      number="23";
    }else if(number.equals("24.0"))
    {
      number="24";
    }else if(number.equals("25.0"))
    {
      number="25";
    }else if(number.equals("26.0"))
    {
      number="26";
    }else if(number.equals("27.0"))
    {
      number="27";
    }else if(number.equals("28.0"))
    {
      number="28";
    }else if(number.equals("29.0"))
    {
      number="29";
    }else if(number.equals("30.0"))
    {
      number="30";
    }else if(number.equals("31.0"))
    {
      number="31";
    }
    else if(number.equals("32.0"))
    {
      number="32";
    }else if(number.equals("33.0"))
    {
      number="33";
    }else if(number.equals("34.0"))
    {
      number="34";
    }else if(number.equals("35.0"))
    {
      number="35";
    }else if(number.equals("36.0"))
    { 
      number="36";
    }else if(number.equals("37.0"))
    {
      number="37";
    }else if(number.equals("38.0"))
    {
      number="38";
    }else if(number.equals("39.0"))
    {
      number="39";
    }else if(number.equals("40.0"))
    {
      number="40";
    }else if(number.equals("41.0"))
    {
      number="41";
    }else if(number.equals("42.0"))
    {
      number="42";
    }
    return number;
    }
}
