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
	        String realpath = getServletConfig().getServletContext().getRealPath("StudentFiles/images/nophoto.jpg"); 
		 
            nophoto = realpath;
		  
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
		            e.printStackTrace();
				}
    }
        %>
        <%
			response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
			response.setContentType("image/jpeg");
		%>
        
        <%
		try
		{
		
			OutputStream sos=null;
			
			String mStudentID=(String)session.getAttribute("mStudentID");
			File f=new File("temp.txt");
			DBConn dbconn=new DBConn();
			Connection conn=dbconn.DBConOpen();
			String Query ="SELECT STUDENTPIC,STUDENTID FROM STUDENTPHOTOGRAPH WHERE STUDENTID='"+mStudentID+"'";
			//System.out.println(Query);
			PreparedStatement stmt=conn.prepareStatement(Query);
			ResultSet rsImage=stmt.executeQuery();
		
			if(rsImage.next())
			{
			
				Blob photo = rsImage.getBlob("STUDENTPIC");	
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
					sos.flush();
					sos.close();				    
				} 
				else 
				{
					 showDefaultPhoto(request, response);
					System.out.println("No Photo");
				}
			}
			else
			{
				 showDefaultPhoto(request, response);
				//System.out.println("sdfsfdsfdsd");
			}
			conn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
        %>
        
    </body>
</html>
