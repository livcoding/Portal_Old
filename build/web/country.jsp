<%@page import="java.sql.*"%>
 <html>
      <head>  
      <script language="javascript" type="text/javascript">  
      var xmlHttp  
      var xmlHttp
      function showState(str){
      if (typeof XMLHttpRequest != "undefined"){
      xmlHttp= new XMLHttpRequest();
      }
      else if (window.ActiveXObject){
      xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
      }
      if (xmlHttp==null){
      alert("Browser does not support XMLHTTP Request")
      return;
      } 
      var url="state.jsp";
      url +="?count=" +str;
      xmlHttp.onreadystatechange = stateChange;
      xmlHttp.open("GET", url, true);
      xmlHttp.send(null);
      }

      function stateChange(){   
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
      document.getElementById("state").innerHTML=xmlHttp.responseText   
      }   
      }
      </script>  
      </head>  
      <body bgcolor="#009AB0"> 
	  <form name=frm>
	  <INPUT TYPE="hidden" NAME="x">
	  <table border=1 rules=grooups cellspacing=5 cellpadding=5 bgcolor="">
	  <tr>
	  <td>
	  
<font color="white"	>  Country : </font>
	  </td>
	  <td>

      <select name='country' onchange="showState(this.value)">  
       <option value="none">Select</option>  
    <%
 Class.forName("oracle.jdbc.OracleDriver").newInstance();  
 Connection con = DriverManager.getConnection("jdbc:oracle:thin:@172.16.4.118:1521:camp11","jiit1110","jiit1110");  
 Statement stmt = con.createStatement();  
 ResultSet rs = stmt.executeQuery("Select COUNTRYCODE, COUNTRYNAME from COUNTRYMASTER");
 while(rs.next()){
     %>
      <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
      <%
 }
     %>
      </select>  
	  </td>
	  </tr>
	  <tr>
<td>
<font color="white"	>  State : </font>
</td>


	  <td>  
      <div id='state'>  
     <select name='state' >  
      <option value='-1'></option>  
      </select>  
      </div>  
	  </td>
	  </tr>
<tr>
<td>
<input type=submit name="Submit" value="Submit">

</td>
</tr>
</form>

<%
if(request.getParameter("x")!=null)
{
out.print("Country : "+request.getParameter("country")+"<br>"+"State : "+request.getParameter("state"));
}
%>
      </body> 
      </html>
