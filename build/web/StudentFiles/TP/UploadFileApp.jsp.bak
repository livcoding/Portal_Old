<%@ page import="java.io.*" %> 

<%

String mEnroll="";
if(request.getParameter("Enroll")==null)
	{
		mEnroll="";
	}
	else
	{
		mEnroll=request.getParameter("Enroll").toString().trim();
	}
%>

<html>
<head>
<title>File Uploading Form<%=mEnroll%></title>
  
<script language="JavaScript" type ="text/javascript">


		function Validate()
		{
			//alert(opener.document.getElementById("CVOpen").value+"dd");
			opener.document.getElementById("CVOpen").value="Y";

					
			var aa=document.frm.file.value;
			var filename=aa.substring(aa.lastIndexOf("\\"));
			var filename1=filename.substring( filename.indexOf("."));
			var filename2=filename1.substring(1);
			var file1=filename2;
			//alert(file1+"asas"+filename1);
			//var filename2=filename1.toUpperCase();
			if(file1=='doc' || file1=='docx' || file1=='pdf' )
			{
					return true;
			}
			else
			{
				alert("Please Select correct CV File Name like xyz.doc,xyz.docx,xyz.pdf" );
				//alert(document.frm1.file.value);
				document.frm.file.value="";
							return false;
			}

			

			
		}
	</script>
	  <link  rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 leftmargin=0 topmargin=0  >
<%
try
{

%>
<br>
<br>
<h2>File Upload </h2>

<Br>
Select a file to upload : <br />
<form action="UploadFile.jsp" method="post" name="frm" enctype="multipart/form-data">


<INPUT TYPE="hidden" NAME="Enroll" VALUE=<%=mEnroll%>>

<input type="file" name="file" size="40" />
<br><br>
<input type="submit" value="Upload File" onClick="return Validate();"/>
<br>
<br> <font face=verdana size=2 color=red><b>The size of your CV should be less then 2MB </b></font>
<%
//	out.print("@@@@@@@@@@"+mEnroll+"$$$$$$$$$$$$");
}
catch (Exception e)
{
	out.print(e);
}
	
	%>
</form>
</body>
</html>
