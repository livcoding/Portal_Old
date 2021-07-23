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
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
  </head>
  <body style="margin-top:50px;">
    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span4 offset4">
          <form class="form-inline">
            <a href="" class="btn btn-mini"><i class="icon-chevron-left"></i></a>
            <input type="text" Placeholder="AcademicYear" class="input-small">
            <a href="" class="btn btn-mini"><i class=" icon-chevron-right"></i></a>
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
                <a href="" class="btn btn-mini"><i class="icon-minus"></i></a>
                <input type="text" class="input-mini">
                <a href="" class="btn btn-mini"><i class="icon-plus"></i></a>
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
              <div class="span4">
              <strong>BeyondbTime Slot Booking:</strong>
              </div>
              <div class="span2">
              <select class="input-small">
                <option>Yes</option>
                <option>No</option>
              </select>
              </div>
              
              <div class="span4">
              &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp; &nbsp;<strong>Holiday Booking:</strong>
              </div>
                <div class="span2">
                <select class="input-small">
                <option>Yes</option>
                <option>No</option>
                </select>
              </div>
             </form>
        </div>
      </div>
      <br>
      <div class="row-fluid">
        <div class="span12">
          	<form class="form-inline">
          		 <div class="span4">
                 <strong>Time Table Integration:</strong>
                 </div>
                 <div class="span2">
                 <select class="input-small">
                 <option>Yes</option>
                 <option>No</option>
                 </select>
                 </div>
                <div >
        		      <div class="span4">
                     <label style="margin-right:15px;"> 
                    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp; &nbsp;<strong>Vocation Booking:</strong>
         		       </div>
                   <div class="span2">
                     &nbsp; &nbsp;
                     <select class="input-small">
                     <option>Yes</option>
                     <option>No</option>
                     </select>
                  </div>  
                </div>            
            </form>
          </div>
        </div>
   <br>
   <div class="row-fluid">
       <div class="span12">
          <form class="form-inline">
            <div class="span4">
           	    <strong>Mail Integrated:</strong>
            </div>
            <div class="span2">
             	<select class="input-small">
              <option>Yes</option>
              <option>No</option>
              </select>
            </div>

    <div>
        <div class="span4">  
	        <label style="margin-right:15px;"> 
            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
             &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<strong>Queuing Allowed:</strong>
        </div>
        <div class="span2">
            &nbsp; &nbsp;
            <select class="input-small">
            <option>Yes</option>
            <option>No</option>
          </select>
        </div>
   </div>
   </form>
  </div>
</div>
<br>
<div class="row-fluid">
          <div class="span12">
          <form class="form-inline">
                <div class="span3">
           	    <strong>Booking Before Hour:</strong>
                </div>
                <div class="span3">
 	            <input type="time" Placeholder="before hour" class="input-medium">
               </div>
               <div class="span3">
           	    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
           	    &nbsp;&nbsp;&nbsp;&nbsp;
           	    <strong>After Hour:</strong>
                </div>
                <div class="span3">
 	            <input type="time" Placeholder="after hour" class="input-medium">
               </div>
           </form>
         </div>
           <br>
           <div class="span12">
           	<form class="form-inline">
            <div class="span3">
           	<strong>Valid Booking Days:</strong>
           </div>
           &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;
                <div class ="span3">
           
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
             </div>
               <div class ="span2"> 
                &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp; &nbsp;<strong>Selected Days:</strong>
                </div>
                <div class ="span4">                                                                       
               <input type="text" Placeholder="selected Days" class="input-long">
              </div>
              </form>
           <br><br><br><br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                 
          
           <input type="submit" value="UPDATE" class="btn">
           <input type="Reset" value="CANCEL" class="btn">
         </div>
          

    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>