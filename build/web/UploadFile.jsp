

<%@ page language="java" import="java.sql.*,tietwebkiosk.*"%>
<%@ page import="java.io.*" %>

<%
ResultSet rsImage=null;
String qry="";
DBHandler db=new DBHandler();
%>
<html>
<head>
<title>File Uploading Form</title>
   
 
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  >

<br>
<br>
<h2>File Upload </h2>
<br>
<Br>

<form action="ImageUpload.jsp" method="post"  enctype="multipart/form-data">
<input type="hidden" name="x" id="x" >

    <br>
        Select a file to upload : <br />
<input type="file" name="employeephoto" id="employeephoto" size="40" />
<br><br>
<input type="submit" value="Upload File" />


</form>

<%



if(request.getParameter("x")==null)
    {
    try
{
       String mempid=request.getParameter("employeeid");
	//System.out.println("dddddd");
	 qry="select EMPLOYEEID, photo from" +
            " EMPLOYEEPHOTO where EMPLOYEEID='UNIV-V00022' ";
	out.println(qry);
	int j=0;
	int k=0;
	 rsImage=db.getRowset(qry);
	while(rsImage.next())
	{
		//System.out.println("dddd");
		InputStream in=rsImage.getBinaryStream("ANSWERIMAGE");
		int len=in.available();
		byte barray[]=new byte[len];
		while(k<len)
		{
			j = in.read(barray, k, len);
			k += j;
		}
		response.setContentLength(barray.length);
		response.getOutputStream().write(barray);
	}
	response.getOutputStream().flush();
	response.getOutputStream().close();
}
catch(Exception e)
{
//	out.println(e);
}

    }
%>
</body>
</html>
