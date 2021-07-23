/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package jilit.db;



import java.util.List;

import javax.servlet.ServletOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.io.*;
import java.util.ArrayList;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdbc.DBUtility;
import tietwebkiosk.DBHandler;
import tietwebkiosk.GlobalFunctions;

/**
 *
 * @author VIVEK.SONI
 */
public class AutoReconMarksEntryExcel {

     private Connection dbConnection;
    Map<String, Object[]> data = new LinkedHashMap<String, Object[]>();
    GlobalFunctions gb = new GlobalFunctions();
    DBHandler db = new DBHandler();
    ResultSet rs = null, rssub = null, rsm = null, newrs = null, rs1 = null;
    String mChkMemID = "", mMemberID = "", mMemberType = "", mDMemberType = "", mMemberName = "", mMemberCode = "", mInst = "", mDMemberCode = "", mCheckFstid = "", mSMarks = "";
    String mComp = "", mSelf = "", mIC = "", mEC = "", mSC = "", mList = "", mOrder = "", mEvent = "", mSE = "", qry = "", qry1 = "", qry2 = "", mMOP = "";
    String time = " ";
    int len = 0, pos = 0, ctr = 0, counter = 1;
    double mWeight = 0, mMaxmarks = 0;


    public AutoReconMarksEntryExcel() {
        dbConnection = DBUtility.getConnection();
    }


    public void downloadExcel(HttpServletRequest req, HttpServletResponse res) throws IOException {

       //p int a=10;

                String filepath = req.getSession().getAttribute("svrpath").toString();
                res.setContentType("Content-type: text/zip");
		res.setHeader("Content-Disposition",
				"attachment; filename=mytest.zip");
                String val=req.getAttribute("filename").toString();
                 List<File> files22 = new ArrayList();
                 String []filename=val.split("\\,");
                 for(int i=0;i<filename.length;i++){
                     if(filename!=null && !filename.equals(" ")&& !filename.equals(",")){
                 files22.add(new File(filepath+filename));
                     }
                 }
              
                ServletOutputStream out33 = res.getOutputStream();
		ZipOutputStream zos = new ZipOutputStream(new BufferedOutputStream(out33));

		for (File file : files22) {

			//System.out.println("Adding " + file.getName());
			zos.putNextEntry(new ZipEntry(file.getName()));

			// Get the file
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(file);

			} catch (FileNotFoundException fnfe) {
				// If the file does not exists, write an error entry instead of
				// file
				// contents
				//zos.write(("ERRORld not find file " + file.getName()).getBytes());
				zos.closeEntry();
				//System.out.println("Couldfind file "+ file.getAbsolutePath());
				continue;
			}

			BufferedInputStream fif = new BufferedInputStream(fis);

			// Write the contents of the file
			int data = 0;
			while ((data = fif.read()) != -1) {
				zos.write(data);
			}
			fif.close();

			zos.closeEntry();
			//System.out.println("Finishedng file " + file.getName());
		}

		zos.close();
    }  // End of Excel Download

}
