<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>

<% 
	String qry="";
	DBHandler db=new DBHandler();
	ResultSet rs=null;
	String mInstCode="JIIT";	
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Resouce Booking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
  </head>
  <body style="margin-top:50px;">
    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span4 offset4">
          <form class="form-inline">
           <input type="submit" value="<" class="btn">
            <input type="text" Placeholder="AcademicYear" class="input-small">
			<input type="submit" value=">" class="btn">
          </form>
        </div>
      </div>
    </div>
	<div class="row-fluid">
          <div  class="span4 offset8">
            <form>
              <label class="checkbox">
                <input type="checkbox"> Active
              </label>
            </form>
          </div>
        </div>
		<div class="row-fluid">
          <div class="span12">
            <form class="form-inline">
              <label style="margin-right:15px;">
                <strong>Time Slot Breakup:</strong>
                <input type="submit" value="-" class="btn">
                <input type="text" class="input-mini">
                <input type="submit" value="+" class="btn">
              </label>          
              <strong>Start Time: </strong>
              <input type="time" class="input-mini">
              <label style="margin-right:15px;">
              &nbsp;&nbsp; &nbsp;<strong>End Time: </strong>
              <input type="time" class="input-mini">
             </label>
           </form>
          </div>
        </div>
		<div class="row-fluid">
          <div class="span12">
            <form class="form-inline">
        <table width="100%" cellspacing="3">
		<tr>
		<td>
		<strong>Beyond Time Slot Booking:</strong>
		</td>
		<td>
		<select class="input-small">
                <option>Yes</option>
                <option>No</option>
              </select>
		</td>
			  <td>
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
			  <td>
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
			  <td>
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
		<input type="time" Placeholder="before hour" class="input-medium">
		</td>
			  <td>
			  <strong>After Hours:</strong>
			  </td>
		<td>
		<input type="time"  class="input-medium">
		</td></tr><tr><td></td></tr></tr><tr><td></td></tr>
<tr>
		<td valign="top">
		<strong>Valid Booking Days</strong>
		</td>
		<td>
		 <table>
              <tr>
                <td>
                  <label class="checkbox">
                <input type="checkbox"> 
              </td>
              <td>
                MON
                </label>
              </td>
            </tr>
             <tr>
                <td>
                  <label class="checkbox">
                <input type="checkbox"> 
              </td>
              <td>
                TUE
                </label>
              </td>
            </tr>
            <tr>
                <td>
                  <label class="checkbox">
                <input type="checkbox"> 
              
                </td>
              <td>
                WED
                </label>
              </td>
            </tr>
             <tr>
                <td>
                  <label class="checkbox">
                <input type="checkbox"> 
              
                </td>
              <td>
                THU
                </label>
              </td>
            </tr> 
            <tr>
                <td>
                  <label class="checkbox">
                <input type="checkbox"> 
              </td>
              <td>
                FRI
                </label>
              </td>
            </tr> <tr>
                <td>
                  <label class="checkbox">
                <input type="checkbox"> 
              
                </td>
              <td>
                SAT
                </label>
              </td>
            </tr> <tr>
                <td>
                  <label class="checkbox">
                <input type="checkbox"> 
              
                </td>
              <td>
                SUN
                </label>
              </td>
            </tr>
               </table>
		</td>
			 <td valign="top">
			  <strong>Selected Days:</strong>
			  </td>
		<td valign="top">
		<table><tr><td>
		<input type="time" Placeholder="before hour" class="input-long">
		</td>
		
		<tr><tr><td></td></tr></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
		<td valign="top">
           <input type="submit" value="UPDATE" class="btn">
           <input type="Reset" value="CANCEL" class="btn">
		</td></tr></tr></table></td></form>
			
         </div>
          </div>
        </div>