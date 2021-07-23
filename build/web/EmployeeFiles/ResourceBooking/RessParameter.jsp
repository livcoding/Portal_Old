<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<html>
  <head>
    <title>Resouce Booking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
  </head>
   <body style="margin-top:30px;">
   <table width="100%">
   <tr align="center"><td>
            <input type="submit" value="<" style="width:25" >
            <input type="text" Placeholder="AcademicYear" class="input-small">
			<input type="submit" value=">" style="width:25">
	</td></tr></table>
	<table>
	     <tr align="right"> 
		 <td align="right">
		 <strong>Active:</strong></td>
		 <td align="left"><input type="checkbox">
         </td>
		</tr>
</table>
<table width=100%> 
<tr><td><strong>Time Slot Breat UP</strong></td>
<td > <input type="submit" value="-" style="width:25">
                <input type="text" class="input-mini">
                <input type="submit" value="+" style="width:25"></td>
				<td align="right"><strong>Start Time: </strong></td>
				<td align="left"><input type="time" class="input-small"></td>
				<td align="right"><strong>End Time: </strong></td>
				<td align="left"><input type="time" class="input-small"></td>
				</tr></table>
</td></tr>
		<tr><td colspan="2">
 <table width="100%" cellspacing="3">
		
		
		<tr>
		<td width="30%">
		<strong>Beyond Time Slot Booking:</strong>
		</td>
		<td>
		<select class="input-small">
                <option>Yes</option>
                <option>No</option>
              </select>
		</td>
			  <td width="30%" align="center">
			  <strong>Holiday Booking:</strong>
			  </td>
		<td>
		<select class="input-small">
                <option>Yes</option>
                <option>No</option>
              </select>
		</td></tr>
		<tr>
		<td>
		<strong>Time Table Integration:</strong>
		</td>
		<td>
		<select class="input-small">
                <option>Yes</option>
                <option>No</option>
              </select>
		</td>
			  <td align=center>
			  <strong>Vocation Booking:</strong>
			  </td>
		<td>
		<select class="input-small">
                <option>Yes</option>
                <option>No</option>
              </select>
		</td></tr>
	<tr>
		<td>
		<strong>Mail Integrated:</strong>
		</td>
		<td>
		<select class="input-small">
                <option>Yes</option>
                <option>No</option>
              </select>
		</td>
			  <td align="center">
			  <strong>Queuing Allowed:</strong>
			  </td>
		<td>
		<select class="input-small">
                <option>Yes</option>
                <option>No</option>
              </select>
		</td></tr>
			<tr>
		<td>
		<strong>Booking Before Hour:</strong>
		</td>
		<td>
		<input type="time" Placeholder="before hour" class="input-small">
		</td>
			  <td align="center">
			  <strong>After Hours:</strong>
			  </td>
		<td>
		<input type="time" Placeholder="before hour" class="input-small">
		</td></tr><tr><td></td></tr></tr><tr><td></td></tr>
<tr>
		<td valign="top">
		<strong>Valid Booking Days:</strong>
		</td>

		<td width=5%><table  width=60% >
		<tr><td width=15%><input type="checkbox" style="width:25px"></td><td align=left >Mon</td></tr>
		<tr><td><input type="checkbox" style="width:25px"></td><td align=left >Tue</td></tr>
		<tr><td><input type="checkbox" style="width:25px"></td><td align=left >Wed</td></tr>
		<tr><td><input type="checkbox" style="width:25px"></td><td align=left >Thu</td></tr>
		<tr><td><input type="checkbox" style="width:25px"></td><td align=left >Fri</td></tr>
		<tr><td><input type="checkbox" style="width:25px"></td><td align=left >Sat</td></tr>
		<tr><td><input type="checkbox" style="width:25px"></td><td align=left >Sun</td></tr>
		 </table>
		 <td valign="top" align="center">
			  <strong>Selected Days:</strong>
			  </td>
		<td valign="top">
		<table><tr><td>
		<input type="time" Placeholder="before hour" class="input-long">
		</td>
		
		<tr><tr><td></td></tr></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><tr><td></td></tr></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><tr><td></td></tr></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><tr><td></td></tr></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
		<td valign="top">
           <input type="submit" value="UPDATE" style="width:50px">
           <input type="Reset" value="CANCEL" style="width:25px">
		</td></tr></tr>
		</table>
		</body>
		</html>	 
