<%@ page import="java.io.*,java.util.*,java.lang.*, javax.servlet.*, MyPackage.*,tietwebkiosk.*,java.sql.*" %> 
<%@ page import="javax.servlet.http.*" %> 
<%@ page import="org.apache.commons.fileupload.*" %> 
<%@ page import="org.apache.commons.fileupload.disk.*" %> 
<%@ page import="org.apache.commons.fileupload.servlet.*" %> 
<%@ page import="org.apache.commons.io.output.*" %> 


<% 
String mEnroll="",mMemberID="",qry="",mChkMemID=""; ResultSet rs=null;
try{ 

	
	GlobalFunctions gb =new GlobalFunctions();
File file=null ; 
DBHandler db=new DBHandler(); 
OLTEncryption enc=new OLTEncryption();
 if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

	 mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
qry="Select   nvl(enrollmentno,'0')Enroll  from studentmaster  Where studentid='"+mChkMemID+"' "; 
 //out.print(qry); 
rs=db.getRowset(qry); 
if(rs.next()) 
{ 
mEnroll=rs.getString("Enroll"); 
} 
else 
{ 
mEnroll=mChkMemID;
} 

 
long maxFileSize = 2000 * 1024; 
int maxMemSize = 2000 * 1024; 
ServletContext context = pageContext.getServletContext(); 
String filePath = context.getInitParameter("file-upload"); 
String fileSave=""; 

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
 


 


String mYear="",mID="";

qry="select to_Char(Sysdate,'yyyy') date1 from dual";
rs=db.getRowset(qry);
if(rs.next())
 mYear=rs.getString("date1");

//mID=mYear;

//mMax=db.GenerateApplicationCVFileID("JIIT");

mMax="";

//out.print(mMax+"LLL");

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
boolean isInMemory = fi.isInMemory(); 
long sizeInBytes = fi.getSize(); 
//out.print((sizeInBytes+"____"+maxFileSize)+"sddsd"); 

if(sizeInBytes<maxFileSize) 
{ 

// Write the file 
//System.out.println("\n Finle bname "+fileName); 
//System.out.println("\n Index of "+fileName.lastIndexOf("\\")) ; 
//System.out.println("\n Index of "+fileName.lastIndexOf("//")) ; 
int mflag=0; 
try 
        {         
        mflag=fileName.lastIndexOf("\\") ;         
        } 
        catch(Exception e) 
        { 
                mflag=0; 
        } 
if(  mflag >= -1 ) 
        { 
filename1=fileName;//.substring(mflag);
//out.print(filename1.substring(0,1)+"filename1");
 
//filename2= "C"+mMax+filename1.substring(filename1.lastIndexOf("\\")+1);

filename2=mEnroll+"_"+filename1.substring(filename1.lastIndexOf("\\")+1);
//out.print(filename2+"filename2");
int mflag1=filename2.lastIndexOf("\\") ;    
// out.print((filename2.substring(filename2.lastIndexOf("\\")))+"SSSS");      
//out.print(filename2+"-----filename2");

if(mflag1==-1) 
        { 
                file = new File( filePath +filename2);   
        } 
else 
        { 
                file = new File( filePath +filename2.substring(filename2.lastIndexOf("\\"))) ; 
        } 
//out.print(file+" ---- fileSave");


fileSave="http://www.jiit.ac.in:8080/ROOT/StudentFiles/TP/resume/"+filename2; 


fi.write( file ) ; 
} 

if(!fileSave.equals(" ") && !fileSave.equals("") && !fileSave.equals("N") && fileSave!=null)
	{
//out.print(" ----------------"+fileSave);

out.println("<br><Br><center><font face=arial color=green size=4> File Uploaded Successfully!!  <center><br>"); 

session.setAttribute("file",fileSave); 


fileSave=gb.replaceSignleQuot(fileSave);
	}
} 
else 
{ 
out.println("<br><Br><center><font face=arial color=red size=4> File size should be less than 2 MB<center><br>"); 

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
out.println("<font color=red face=verdana>Error : The size of your CV should be less then 2MB !"); 
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