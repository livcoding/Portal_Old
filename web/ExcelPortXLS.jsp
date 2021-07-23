<%-- 
    Document   : ExcelPortXLS
    Created on : Oct 8, 2012, 12:56:32 PM
    Author     : ankur.verma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.lang.*, javax.servlet.*, tietwebkiosk.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<%@ page import ="java.io.*,java.util.*,org.jfree.data.*, org.jfree.chart.JFreeChart, org.jfree.chart.ChartFactory,
org.jfree.chart.ChartUtilities, org.jfree.chart.plot.PlotOrientation, org.apache.poi.hssf.usermodel.HSSFRow,
org.apache.poi.hssf.usermodel.HSSFCell,org.apache.poi.hssf.usermodel.HSSFSheet, org.apache.poi.hssf.usermodel.HSSFWorkbook,
org.jfree.data.category.DefaultCategoryDataset"%>

<%
try{
File file=null ;
DBHandler db=new DBHandler();
ResultSet rs=null;
String qry="";
long maxFileSize = 2000 * 1024;
int maxMemSize = 2000 * 1024;
ServletContext context = pageContext.getServletContext();
String filePath = context.getInitParameter("file-upload");
String fileSave="";
int p=0;
double mm=1.0;
String aa="";
// Verify the content type
String contentType = request.getContentType();
if ((contentType.indexOf("multipart/form-data") >= 0)) {

DiskFileItemFactory factory = new DiskFileItemFactory();
// maximum size that will be stored in memory
factory.setSizeThreshold(maxMemSize);
// Location to save data that is larger than maxMemSize.
factory.setRepository(new File("c:\\temp"));

// Create a new file upload handler
ServletFileUpload upload = new ServletFileUpload(factory);
// maximum file size to be uploaded.
upload.setSizeMax( maxFileSize );

try{
// Parse the request to get file items.
List fileItems = upload.parseRequest(request);
// Process the uploaded file items
Iterator i = fileItems.iterator();

out.println("<html>");
out.println("<head>");
out.println("<title>JSP File upload</title>");
out.println("</head>");
out.println("<body  aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >");
String mMax="";
String  filename1="";
String filename2="";
while ( i.hasNext () )
{
try{

FileItem fi = (FileItem)i.next();
if ( !fi.isFormField () )
{
// Get the uploaded file parameters
String fieldName = fi.getFieldName();
String fileName = fi.getName();

//out.print(fileName+"fileName");
short a=2;
short b=1;
List list1=new ArrayList();
//List list2 = new ArrayList();
String x,y;
int  v=1;

FileInputStream fs=new FileInputStream(fileName);
HSSFWorkbook wb=new HSSFWorkbook(fs);

for (int k=0;k<wb.getNumberOfSheets();k++)
    {
        int j=p+1;
        HSSFSheet sheet=wb.getSheetAt(k);
        //int rows=sheet.getPhysicalNumberOfRows();
          Iterator rows = sheet.rowIterator();
         // int o=0;
            while (rows.hasNext()) {
               // out.print(o++);
                HSSFRow row = (HSSFRow) rows.next();
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
                while (cells.hasNext()) {
                    HSSFCell cell = (HSSFCell) cells.next();
                    data.add(cell);
                }

               
                list1.add(data);
            }
      
//reading table

for (int t = 0; t < list1.size(); t++) {
        List list2 = (List) list1.get(t);
        for (int u = 0; u < list2.size(); u++) {
            HSSFCell table = (HSSFCell) list2.get(u);
          //  System.out.print(employeeid.getStringCellValue());
            String tablevalue="";
              switch (table.getCellType()){
 case HSSFCell.CELL_TYPE_FORMULA :
 tablevalue = "FORMULA ";
 break;

 case HSSFCell.CELL_TYPE_NUMERIC :
 tablevalue = ""+table.getNumericCellValue();
 break;

 case HSSFCell.CELL_TYPE_STRING :
 tablevalue = table.getStringCellValue();
 break;

 default:
}

            if (u < t ) {

//out.print(tablevalue);

          //    out.print(u +"- "+t+" ,");


            }
        }
        out.println("");
    }
///////////////////////////////////////////////////////////////////////////////

 for (int h = 0; h < list1.size(); h++) {
            List list = (List) list1.get(h);
            //for (int j = 0; j < list.size(); j++) {
                HSSFCell cc1 = (HSSFCell) list.get(0);
                HSSFCell cc2 = (HSSFCell) list.get(1);
                 HSSFCell cc22 = (HSSFCell) list.get(2);
                HSSFCell cc33 = (HSSFCell) list.get(3);
                 HSSFCell cc44= (HSSFCell) list.get(4);
                HSSFCell cc55 = (HSSFCell) list.get(5);




        String ccStr1="",ccStr2="",ccStr22="",ccStr33="",ccStr44="",ccStr55="";
double pp=0.0;
        switch (cc1.getCellType()){
 case HSSFCell.CELL_TYPE_FORMULA :
 ccStr1 = "FORMULA ";
 break;

 case HSSFCell.CELL_TYPE_NUMERIC :
 ccStr1 = ""+cc1.getNumericCellValue();
   pp=cc1.getNumericCellValue();
 break;

 case HSSFCell.CELL_TYPE_STRING :
 ccStr1 = cc1.getStringCellValue();
 break;

 default:
}

      switch (cc2.getCellType()){
 case HSSFCell.CELL_TYPE_FORMULA :
 ccStr2 = "FORMULA ";
 break;

 case HSSFCell.CELL_TYPE_NUMERIC :
 ccStr2 = ""+cc2.getNumericCellValue();
 break;

 case HSSFCell.CELL_TYPE_STRING :
 ccStr2= cc2.getStringCellValue();
 break;
 

 default:
}


           switch (cc22.getCellType()){
 case HSSFCell.CELL_TYPE_FORMULA :
 ccStr22 = "FORMULA ";
 break;

 case HSSFCell.CELL_TYPE_NUMERIC :
 ccStr22 = ""+cc22.getNumericCellValue();
 break;

 case HSSFCell.CELL_TYPE_STRING :
 ccStr22 = cc22.getStringCellValue();
 break;

 default:
}

      switch (cc33.getCellType()){
 case HSSFCell.CELL_TYPE_FORMULA :
 ccStr33 = "FORMULA ";
 break;

 case HSSFCell.CELL_TYPE_NUMERIC :
 ccStr33 = ""+cc33.getNumericCellValue();
 break;

 case HSSFCell.CELL_TYPE_STRING :
 ccStr33= cc33.getStringCellValue();
 break;


 default:
}

 switch (cc44.getCellType()){
 case HSSFCell.CELL_TYPE_FORMULA :
 ccStr44 = "FORMULA ";
 break;

 case HSSFCell.CELL_TYPE_NUMERIC :
 ccStr44 = ""+cc44.getNumericCellValue();
 break;

 case HSSFCell.CELL_TYPE_STRING :
 ccStr44= cc44.getStringCellValue();
 break;


 default:
}

 switch (cc55.getCellType()){
 case HSSFCell.CELL_TYPE_FORMULA :
 ccStr55 = "FORMULA ";
 break;

 case HSSFCell.CELL_TYPE_NUMERIC :
 ccStr55 = ""+cc55.getNumericCellValue();
 break;

 case HSSFCell.CELL_TYPE_STRING :
 ccStr55= cc55.getStringCellValue();
 break;


 default:
}

 //out.print(ccStr2);
 //if(ccStr1.equals("1.0"))
  //   {
 if(pp!=1.0)
     {
 while(mm==pp)
   {

     out.print(mm+"--"+pp);

    // mm=mm+1.0;
 }
 }
//}
/*
while(pp>0)
         {
 aa=v+".0";
out.print(aa);
  if(ccStr1.equals(aa)   )
      {

  //    String t1=ccStr2;
     out.print("<br>"+ccStr2+","+ccStr22+","+ccStr33+","+ccStr44+","+ccStr55);

      }

   // v++;

  }*/


// if(pp<)
  //   {
  //    out.print(ccStr2  +" - ");
//     }



           //     HSSFCell date = (HSSFCell) list.get(3);
      if(!ccStr1.equals("") ||  ccStr1!=""  )
          {

            if(ccStr1.equals("Course:"))
                {
                //out.print(ccStr2  +" , ");
                String Course=ccStr2  ;
               out.print(Course  +" - ");
                }

            if(ccStr1.equals("Discipline:"))
                {
                //out.print(ccStr2  +" , ");
                String Discipline=ccStr2  ;
               out.print(Discipline  +" - ");
                }
              if(ccStr1.equals("Batch:"))
                {
                //out.print(ccStr2  +" , ");
                String Batch=ccStr2  ;
                out.print(Batch  +" - ");
                }

                  if(ccStr1.equals("Semester:"))
                {
                //out.print(ccStr2  +" , ");
                String Semester =ccStr2  ;
                out.print(Semester   +" - ");
                }

               if(ccStr1.equals("Subject:"))
                {
                //out.print(ccStr2  +" , ");
                String Subject =ccStr2  ;
                out.print(Subject   +" - ");
                }

          }

      /////////////////////////////////////////////////////////////////////////////////////

       HSSFCell cc4 = (HSSFCell) list.get(3);
                HSSFCell cc5 = (HSSFCell) list.get(4);
        String ccStr5="",ccStr4="";

        switch (cc4.getCellType()){
 case HSSFCell.CELL_TYPE_FORMULA :
 ccStr4 = "FORMULA ";
 break;

 case HSSFCell.CELL_TYPE_NUMERIC :
 ccStr4 = ""+cc4.getNumericCellValue();
 break;

 case HSSFCell.CELL_TYPE_STRING :
 ccStr4 = cc4.getStringCellValue();
 break;

 default:
}

      switch (cc5.getCellType()){
 case HSSFCell.CELL_TYPE_FORMULA :
 ccStr5 = "FORMULA ";
 break;

 case HSSFCell.CELL_TYPE_NUMERIC :
 ccStr5 = ""+cc5.getNumericCellValue();
 break;

 case HSSFCell.CELL_TYPE_STRING :
 ccStr5= cc5.getStringCellValue();
 break;


 default:
}

    //  out.print(ccStr4  +" , ");
      if(!ccStr4.equals("") ||  ccStr4!=""  )
          {
            
 if(ccStr4.equals("Run Date:"))
                {
                //out.print(ccStr2  +" , ");
                String RunDate=ccStr5  ;
                out.print(RunDate  +" - ");
                }


 if(ccStr4.equals("Run Time:"))
                {
                //out.print(ccStr2  +" , ");
                String RunTime=ccStr5  ;
                out.print(RunTime  +" - ");
                }

            }


       //         out.print(ccStr2  +" , ");

            //    out.print(date.getStringCellValue()+"<br>");
                //if (j < list.size() - 1) {
                   // System.out.print(", ");
                //}
           // }
            System.out.println("");
        }
      p++;


}

%>
<center>
<a href="javascript:window.close()"><FONT SIZE=2 COLOR=BLUE FACE=VERDANA>
Click to Close</FONT></a>
</center>
<%
//response.sendRedirect("ApplicationForms.jsp");
}
}catch(Exception ex) {
out.println("<font color=red face=verdana>Error : The size of your CV should be less then 2MB !"+ex);
}
}
out.println("</body>");
out.println("</html>");
// Uploading up = new Uploading();
// up.write("OA00000016", fileSave);
}catch(Exception ex) {
out.println("<font color=red face=verdana>Error : The size of your CV should be less then 2MB !");
}
}else{
out.println("<html>");
out.println("<head>");
out.println("<title>Servlet upload</title>");
out.println("</head>");
out.println("<body>");
out.println("<p>No file uploaded</p>");
out.println("</body>");
out.println("</html>");
}
}
catch(Exception e)
{
out.println("<font color=red face=verdana>Error : The size of your CV should be less then 2MB !");
}
%> 