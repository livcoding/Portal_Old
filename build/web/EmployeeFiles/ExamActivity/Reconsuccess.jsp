<%--
    Document   : Reconsuccess
    Created on : 24 Dec, 2016, 11:03:48 AM
    Author     : VIVEK.SONI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@ page import = "java.io.*,java.util.*,javax.servlet.*,java.net.URLDecoder" %>

<%

            GlobalFunctions gb = new GlobalFunctions();
            OLTEncryption enc = new OLTEncryption();
            DBHandler db = new DBHandler();
            ResultSet rs = null, rssub = null, rsm = null, rs1 = null;
            String mMemberID = "", fname = "", mMemberType = "", mDMemberType = "", mMemberName = "", mMemberCode = "", mInst = "", mDMemberCode = "", mCheckFstid = "", mSMarks = "";
            String mComp = "", mSelf = "", mIC = "", mEC = "", mSC = "", mList = "", mOrder = "", mEvent = "", mSE = "", qry = "", qry1 = "", qry2 = "", mMOP = "";
if (request.getParameter("fname") != null){

              fname=request.getParameter("fname");
             // mIC=enc.decode(fname);
}if (session.getAttribute("Excel")==null)
{
	mIC="";
}
else
{
	mIC=session.getAttribute("Excel").toString().trim();
}

            if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

%>
<html>
    <form name ="frm2" id="frm2" method="post" >
         <input id="x" name="x" type=hidden>
    <head>
       
        <title>Down-load File</title>
    </head>
    <body bgcolor="#fce9c5">
       <br><hr><p><font color=Green size=4><ul>
			<li>Marks Entry For this Event-Subevent has been locked successfully!
			<li>Now you can not change students Marks or Detained/Absent status.
			<li>For any changes take a written permission from VC/Dean and then contact Registrar/Dy. Registrar.
                        <li><b>Excel File Save in Server,Download Copy of Excel of future use<font color="red"><br><br><br>
          <input type="Submit" value="DownLoad Copy"  >
      </form>
  <%
   if(request.getParameter("x")!=null){

          /*      try{
            RequestDispatcher rd= request.getRequestDispatcher("../../ReconMarksEntryExceldownload");
            rd.forward(request, response);
           
                 }catch (Exception e){}*/
                String filename = mIC;
                String filepath2 =request.getSession().getAttribute("svrpath").toString();
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("Content-Disposition", "attachment; filename="+mIC);
                File fileToDownload = new File(filepath2+filename);

                InputStream in = null;
                ServletOutputStream outs=null;

                try {outs=response.getOutputStream();
                in = new BufferedInputStream(new FileInputStream(fileToDownload));
                int ch;
                while ((ch = in.read()) != -1) {
                outs.print((char) ch);
                }
                }
                finally {
                if (in != null) in.close(); outs.close(); outs.flush(); // very important
                }

               
}
%></b></font>
		</ul></font><hr>
    </body>
</html>
