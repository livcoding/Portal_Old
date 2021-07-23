/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Test;

/**
 *
 * @author VIVEK.SONI
 */

/**
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import org.apache.poi.hssf.record.crypto.Biff8EncryptionKey;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;

public class ProtectedExcelFile {

   public static void main(final String... args) throws Exception {

        String fname = "C:\\Documents and Settings\\sadutta\\Desktop\\sample.xls";

        FileInputStream fileInput = null;
        BufferedInputStream bufferInput = null;
        POIFSFileSystem poiFileSystem = null;
        FileOutputStream fileOut = null;

        try {

            fileInput = new FileInputStream(fname);
            bufferInput = new BufferedInputStream(fileInput);
            poiFileSystem = new POIFSFileSystem(bufferInput);

            Biff8EncryptionKey.setCurrentUserPassword("secret");
            HSSFWorkbook workbook = new HSSFWorkbook(poiFileSystem, true);
            HSSFSheet sheet = workbook.createSheet();

            HSSFRow row = sheet.createRow(0);
            HSSFCell cell = row.createCell(0);

            cell.setCellValue("THIS WORKS!");

            fileOut = new FileOutputStream(fname);
            workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
            workbook.write(fileOut);



        } catch (Exception ex) {

            System.out.println(ex.getMessage());

        } finally {

              try {

                  bufferInput.close();

              } catch (IOException ex) {

                  System.out.println(ex.getMessage());

              }

              try {

                  fileOut.close();

              } catch (IOException ex) {

                  System.out.println(ex.getMessage());

              }
        }

    }
  
}
 *  */