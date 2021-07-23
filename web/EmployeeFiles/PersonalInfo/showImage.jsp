<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%@ page import="java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="image/jpeg">
</head>
<body>
<%!  //declaration 
private void showDefaultPhoto(HttpServletRequest request, HttpServletResponse response)
{
	try 
	{
		String nophoto = null;
	      String realpath = getServletConfig().getServletContext().getRealPath("EmployeeFiles/PersonalInfo/images/nophoto.jpg"); //System.out.print(realpath);
		 
            nophoto = realpath ;
            java.io.FileInputStream fin = new java.io.FileInputStream(nophoto);
            response.setContentType("images/jpeg");
            java.io.PrintWriter out = response.getWriter();
            int i = 0;
            while ((i = fin.read()) != -1) 
		{
			out.write(i);
		}
	      out.flush();
		out.close();
	}
	catch (Exception e) 
	{
		//e.printStackTrace();
	}
}
//------------
%><%
//------------
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setContentType("image/jpeg");
//------------
%><%
//------------
try
{
	OutputStream sos=null;
	String mMemberID=(String)session.getAttribute("mMemberID");
	File f=new File("temp.txt");
	DBConn dbconn=new DBConn();
	Connection conn=dbconn.DBConOpen();
	String Query ="SELECT Employeeid,PHOTO FROM EMPLOYEEPHOTO where EMPLOYEEID='"+mMemberID+"'";
	//	System.out.println(Query);
	PreparedStatement stmt=conn.prepareStatement(Query);
			
	ResultSet rsImage=stmt.executeQuery();
	if(rsImage.next())
	{
		Blob photo = rsImage.getBlob("PHOTO");	
		if (photo != null)
		{
			
				
			response.setContentType("image/jpeg");
			response.setContentLength((int)photo.length());
			InputStream in= photo.getBinaryStream();
			int a=0;
			while((a=in.read())!=-1)
			{
				sos = response.getOutputStream();
				sos.write(a);
			}
			//sos.flush();
			//sos.close();				    
		}	 
		else 
		{
            	showDefaultPhoto(request, response);
		}
	}
	else
	{
		showDefaultPhoto(request, response);
	}
	conn.close();
}
catch(Exception e)
{
	//e.printStackTrace();
}
%>
</body>
</html>