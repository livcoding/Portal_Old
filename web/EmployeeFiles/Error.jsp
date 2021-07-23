<%--
    Document   : Contact
    Created on : 7 Jan, 2020, 2:49:36 PM
    Author     : VIVEK.SONI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
        <html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./css/homecss.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
  background: #2E86C1;
}

.content {
  max-width: 1200px;
  margin: auto;
  background: white;
  padding: 10px;
}

 input[type=text], input[type=password],input[type=date] {
  width: 50%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 10%;
}
button:hover {
  opacity: 0.8;
}

 table.one {
    border-collapse:separate;
    border:solid black 1px;
    border-radius:22px;
    -moz-border-radius:6px;
    width:50%;
    background:white;
    margin-left:25%;
    margin-right:25%;
     box-shadow:  0 0 10px 5px rgba(0,0,0,0.6);
}

td.a , .th.a {
    border-left:solid black 2px;
    border-top:solid black 2px;
}

th.a {
    background-color: blue;
    border-top: none;
}

td.a:first-child, .th.a:first-child {
     border-left: none;
}

    h1{
    color: green;
    font-size: 24px;
    line-height: 41px;
    font-family: 'helvetica_condensed_lightRg';
    }
     h2{
   color: Red;
    font-size: 24px;
    line-height: 41px;
    font-family: 'helvetica_condensed_lightRg';

    }
     h3{
    color: #2f627f;
    font-size: 20px;
    line-height: 41px;
    font-family: 'helvetica_condensed_lightRg';
    }
    h4{
    color: #2f627f;
    font-size: 18px;
    line-height: 21px;
    font-family: 'helvetica_condensed_lightRg';
    }
</style>
<script language=javascript>
        if(window.history.forward(1) != null)
        window.history.forward(1);
    </script>
<body>
    <div class="content">
      <table width="90%" border="0" >
  <tr>
      <td rowspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td rowspan="3" ><img src="./image/juit.jpg"/></td>
    <td align="right"> <h1>  JAYPEE UNIVERSITY OF INFORMATION TECHNOLOGY </h1></td>
  </tr>
  <tr>
      <td align="right"><font color="#000"> <b> Established under H.P. Legislative Assembly Act No. 14 of 2002</b></font></td>
  </tr>
  <tr>

      <td align="right"> <font color="#000"><b>and Approved by UGC under section 2(f)</b></font></td>

  </tr>

</table>
        
    </head>
    <table width="100%" border="1" bgcolor="#2F4F4F">
        <tr width="100%">
        </tr>
    </table>
    <br><br>
    <body>
        <%
        String sms="";
        if(request.getParameter("sms")!=null &&!request.getParameter("sms").toString().equalsIgnoreCase("")){
        sms=request.getParameter("sms").toString();
        }
        %>
        <br><br><br><br>
        <table width="100%" align="center">
              <tr width="100%" align="center">
                  <td>
                      <h2><%=sms%></h2><br>
                      <h3> Click Here to <a href="./Login.jsp">Login</a> again</h3>
                  </td>
              </tr>
    </table>
        
    </body>
    <br><br><br><br><br><br><br><br><br><br><br>

    <table border="0" align="center" width="50%">
   <tr>

       <td rowspan="2" align="right"><img src="./image/CampusConnectLogo.bmp"/></td>
   <td align="Left"><font color="#641E16" face="Monotype Corsiva" size="4"> <b>  CampusLynx Design & Maintained by </b></font></td>
  </tr>
  <tr>
      <td align="Left"><font color="#666"> <b><a href="http://www.jilit.co.in/" target="_blank"> &nbsp;&nbsp;JIL Information
Technology LTD.</b></a></font></td>
  </tr>
    </table>

</div>
</body>
</html>
</html>
