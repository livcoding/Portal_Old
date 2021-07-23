/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jpalumni.DBHandler;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import pgwebkiosk.OLTEncryption;

/**
 *
 * @author nipun.gupta
 */
public class ReconMarksEntryExcelFileUploadDB {

    private final String UPLOAD_DIRECTORY = "D:\\";
    String marks = "";

    public void selectSaveUpdateData(HttpServletRequest req, HttpServletResponse res) throws IOException {
               
            String mMemberID = "", name="",rssub="", mMemberType = "", mDMemberType = "", mMemberName = "", mMemberCode = "", mInst = "", mDMemberCode = "", mCheckFstid = "", mSMarks = "";
            String mComp = "", mSelf = "", mIC = "", mEC = "", mSC = "", mList = "", mOrder = "", mEvent = "", mSE = "", qry = "", qry1 = "", qry2 = "", mMOP = "";
            String time=" ";
            ResultSet rs = null, rssub1 = null;
            int len = 0, pos = 0, ctr = 0,counter=1;
            double mWeight = 0, mMaxmarks = 0;
             DBHandler db = new DBHandler();
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

           //   System.out.println("Before if");
       /* if (ServletFileUpload.isMultipartContent(req)) {
             System.out.println("Before try after if");
            try {
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
                System.out.println("After Try");
                for (FileItem item : multiparts) {
                    if (!item.isFormField()) {
                        System.out.println("coming in file name");
                         name = new File(item.getName()).getName();
                        item.write(new File(UPLOAD_DIRECTORY + File.separator + name));
                        System.out.println("Write file name "+name);
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }*/


    

        try {
           OLTEncryption enc=new OLTEncryption();
           mDMemberCode = enc.decode(mMemberCode);
           String fileType=mIC+"-"+mEC+"-"+mSC+"-"+mEvent+"-"+mDMemberCode+".xls";
            String filepath2 = req.getSession().getAttribute("svrpath").toString();
            File f = new File(filepath2+fileType);
            try{
	    if(f.exists()){
            FileInputStream file = new FileInputStream(new File(filepath2+fileType));
            HSSFWorkbook  workbook2 = new HSSFWorkbook (file);
            HSSFSheet sheet = workbook2.getSheetAt(0);

            int lastrow=sheet.getLastRowNum();
             for (int i=1;i<=lastrow;i++) {
                HSSFRow row=sheet.getRow(i);
                for (int cn = 0; cn < row.getLastCellNum(); cn++) {

                    HSSFCell cell = row.getCell((short)cn);
                    //System.out.println("CELL: " + cn + " --> " + cell.toString());
                    if(cn==3){
                       double stmarks = 0;
                       String smarks = "";
                       if(cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                       String sValue=cell.getStringCellValue();
                     
                        if(sValue.equalsIgnoreCase("M") || sValue.equalsIgnoreCase("A") || sValue.equalsIgnoreCase("D")|| sValue.equalsIgnoreCase("U")){
                        smarks=sValue;
                        }
                       }else{
                    stmarks=cell.getNumericCellValue();
                    smarks=Double.toString(stmarks);
                        }
                  
                    marks=marks+smarks+",";
                    }
                }
            }
            file.close();
            try {
            res.sendRedirect(req.getContextPath()+ "/EmployeeFiles/ExamActivity/Reconuploadexcel.jsp?testMarks=" + marks);
            } catch (Exception e) {
            e.printStackTrace();
            }
            }else{  // if file not exist for Reconciliation 
             res.sendRedirect(req.getContextPath()+ "/EmployeeFiles/ExamActivity/Reconuploadexcel.jsp?testMarks=fnf");
            }
            }catch(FileNotFoundException e){
                 //res.sendRedirect(req.getContextPath()+ "/EmployeeFiles/ExamActivity/Reconuploadexcel.jsp?testMarks=fnf");
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        } finally {  
        }
        

    }
}
