<%-- 
    Document   : testStudent
    Created on : Sep 1, 2020, 3:31:04 PM
    Author     : mohd.uvesh
--%>

<%@page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*,com.itextpdf.text.*,com.itextpdf.text.pdf.*,java.io.FileOutputStream"%>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>



<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
           </script>
        <% %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Details</title>
    </head>
    <body aLink="black" bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
        <h1>
            <%--<a href="https://www.w3schools.com">click</a>--%>
            <script>
                $(document).ready(function(){
                    $("#btn").click(function(){
                        alert("helloo");
                    })
                });
                    </script>
<table align="center" style="padding-top: 12px; padding-bottom: 12px; border: solid 1px">
<style type="text/css">

</style>
         <TR>
<%
String qry="";
String qry1="";
String qry2="";
String dob="";
String m="";
String mChkMemID="";
String cap="";
DBHandler db=new DBHandler();
ResultSet rs=null;
//
 Integer hitsCount = (Integer)application.getAttribute("hitCounter");
         if( hitsCount ==null || hitsCount == 0 ) {
            /* First visit */
            hitsCount = 1;
         } else {
            /* return visit */

            hitsCount += 1;
         }
         application.setAttribute("hitCounter", hitsCount);


         Random random = new Random();
  int length = 5;
  StringBuffer captchaStringBuffer = new StringBuffer();
  for (int i = 0; i < length; i++) {
   int captchaNumber = Math.abs(random.nextInt()) % 60;
   int charNumber = 0;
   if (captchaNumber < 26) {
    charNumber = 65 + captchaNumber;
   }
   else if (captchaNumber < 52){
    charNumber = 97 + (captchaNumber - 26);
   }
   else {
    charNumber = 48 + (captchaNumber - 52);
   }
   captchaStringBuffer.append((char)charNumber);
  }

cap=captchaStringBuffer.toString();

OLTEncryption enc=new OLTEncryption();
session.setAttribute("cptid",enc.encode(cap));
//
try{
m=session.getAttribute("MemberName").toString();
}
catch(Exception ex){}
qry1="Select To_char(Sysdate,'mmddyyyy') Dat from dual";
qry="select DATEOFBIRTH from STUDENTMASTER where ENROLLMENTNO='18103132'";
qry2="select nvl(CADDRESS1,' ')CADDRESS1, nvl(CADDRESS3,' ')CADDRESS3,nvl(CADDRESS2,' ')CADDRESS2,nvl(CDISTRICT,' ')CDISTRICT,nvl(CSTATE,'')CSTATE ,nvl(PPHONENO,' ')PPHONENO,nvl(CPIN,'0')CPIN from STUDENTADDRESS where STUDENTID='"+mChkMemID+"'";
rs = db.getRowset(qry);
  while(rs.next()){
   dob= rs.getString("DATEOFBIRTH");
  }
 String FILE = "PositionPdf.pdf";
        try {
            Document d=new Document();

             Scanner sc=new Scanner(System.in);

            Document document = new Document();
            PdfWriter.getInstance(document, new FileOutputStream(FILE));
            document.open();
            // Left
            Paragraph paragraph=new Paragraph("this is Right String");
            paragraph.setAlignment(Element.ALIGN_RIGHT);
            document.add(paragraph);
            // Centered
            paragraph = new Paragraph("This is centered text");
            paragraph.setAlignment(Element.ALIGN_CENTER);
            document.add(paragraph);
            // Left
            paragraph = new Paragraph("This is left aligned text");
            paragraph.setAlignment(Element.ALIGN_LEFT);
            document.add(paragraph);

           // DataTable dt=new
            // Left with indentation
            paragraph = new Paragraph(
                    "This is left aligned text with indentation");
            paragraph.setAlignment(Element.ALIGN_LEFT);
            paragraph.setIndentationLeft(50);
            document.add(paragraph);
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
%>
<TD colspan="3"><FONT color=black face=Arial>&nbsp;DOB</FONT></TD>
<td colspan="3"><FONT color=black>&nbsp;<%=dob%> </FONT>&nbsp;</td>
 </TR>
       <TR>
       <td>
       <input type="text"  id="MemberCode" name="MemberCode" value="Enter Roll NO"   style="HEIGHT: 20px; WIDTH: 150px"></b><FONT color=black><sub>*</sub></FONT>


       <input type="submit" id="btn" value="click me" onclick="getValue()">
       <script>
       function getValue(){
       var v1=document.getElementById("MemberCode");
       alert("Hello");   
       }


         <%-- function func(){
       var x=document.getElementById('MemberCode').value;
       alert(""+x);
            }--%>             
           <%-- $.ajax({
                type:'POST',
                timeout:50000,
                    dataType:"json",
                    handler: para.handler,
                    url:'../' + para.service,
                    data:'jdata='+JSON.stringify(para).replace(/&/g,"").replace(/%/g,"")+'&d='+new Date(),
                    error:function() {
                rc++;
                if (rc != 3) {}
                $("errorDiv").html("An Error Occured With Request.....");}
            })--%>              
       </script>
            </td>
            </TR>
         </table>
        </h1>
       <table border="0" cellpadding="0" cellspacing="0" bgcolor="#D5D6D8" align="center">

    <tbody>
        <tr>
            <td colspan="2" align="center"><div style="background-color: #D5D6D8"><s><i><font face="casteller" size="5"><%=cap%></font></i></s></div></td>
        </tr>
        <tr>
              <td> <b><INPUT Readonly name=txtCode value="Enter Captcha     " style ="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: normal; HEIGHT: 22px; TEXT-ALIGN: right;background-color:#D5D6D8;
      VERTICAL-ALIGN: middle; WIDTH: 79px" size=12 lowsrc="" tabIndex=101 width="79" ></b></td>
        <td><input type="text" id ="txtcap" name="txtcap" value=""  size="11" tabindex="2" LANGUAGE=javascript  style="VERTICAL-ALIGN: middle; WIDTH: 85px"></b> <FONT color=red><sub>*</sub></FONT>
		<br><div id = "mydiv1" /></td>
        </tr>
    </tbody>
</table>
    </body>
</html>
