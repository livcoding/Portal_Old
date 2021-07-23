<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.* ,java.math.* " %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
 

<script language="javascript">
    function printPage() {
         window.print();
    }
</script>

<html>
   <body>
     
       <input type="button" value="Print" onclick="printPage();"></input>
  </body>
</html>

 
