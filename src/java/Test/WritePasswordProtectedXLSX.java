/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.security.GeneralSecurityException;
import java.util.Date;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.openxml4j.opc.PackageAccess;
import org.apache.poi.poifs.crypt.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
//apache poi imports
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class WritePasswordProtectedXLSX {

    /**
     * @param args
     * @throws IOException
     * @throws InvalidFormatException
     * @throws GeneralSecurityException
     */
    public static void main(String[] args) throws IOException, InvalidFormatException, GeneralSecurityException {

        //create a new workbook
        Workbook wb = new XSSFWorkbook();

        //add a new sheet to the workbook
        Sheet sheet1 = wb.createSheet("Sheet1");

        //add 2 row to the sheet
        Row row1 = sheet1.createRow(0);
        Row row2 = sheet1.createRow(1);

        //create cells in the row
        Cell row1col1 = row1.createCell(0);
        Cell row1col2 = row1.createCell(1);

        //add data to the cells
        row1col1.setCellValue("Top Secret Data 1");
        row1col2.setCellValue("Top Secret Data 2");

        //write the excel to a file
        try {
            FileOutputStream fileOut = new FileOutputStream("c:/test/excel.xlsx");
            wb.write(fileOut);
            fileOut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        //Add password protection and encrypt the file
        POIFSFileSystem fs = new POIFSFileSystem();
        EncryptionInfo info = new EncryptionInfo(fs, EncryptionMode.agile);

        Encryptor enc = info.getEncryptor();
        enc.confirmPassword("s3cr3t");

        OPCPackage opc = OPCPackage.open(new File("c:/excel.xlsx"), PackageAccess.READ_WRITE);
        OutputStream os = enc.getDataStream(fs);
        opc.save(os);
        opc.close();

        FileOutputStream fos = new FileOutputStream("c:/excel.xlsx");
        fs.writeFilesystem(fos);
        fos.close();

        System.out.println("File created!!");

    }

}