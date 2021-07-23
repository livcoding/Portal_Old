<%@ page language="java" import="java.sql.*,jpalumni.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null,rst=null;
int count= 0;
String mTYPE="", academicyear="", companycode="" ,qry="";

			if (request.getParameter("TYPE") == null) { 
                mTYPE = "";
            } else {
                mTYPE = request.getParameter("TYPE").toString().trim();
            }
			%>
			<HTML>
			<head>
			<TITLE>#### [ Applicant Detail ] </TITLE>
			<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
			<script language="javascript" type="text/javascript" src="js/jquery.min.js"></script>
			<script type="text/javascript" src="js/sortabletable.js"></script>
			<link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
			<link type="text/css" rel="StyleSheet" href="css/filtergrid.css"/>
			<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
			<script type="text/javascript" src="js/sortabletable.js"></script>
			<link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
			</HEAD>
			</head>
			<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin="0" topmargin="0">
			<form name="frm"  method="post" >
			<input id="x" name="x" type=hidden>
			<center>
			<table width=80% align=center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
			<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Applicant Detail</FONT></u></b></td>
			</tr>
			</table>
			</center>
			<!--------------------------qry@5/10/2012----------------------------->
			<center>
			<table align=center cellpadding="0" cellspacing="0" border="0" rules="groups">   
			<tr>
			<td colspan=8><hr>
			
			<%
			if(mTYPE.equals("JIITOL") ){
			%>
			<b><FONT face=Arial size=2>&nbsp; Apllication Submission Mode : <FONT SIZE="3" COLOR="red">Online </FONT></font></B>
			<%
			}
			else {
			%>
			<b><FONT face=Arial size=2>&nbsp; Apllication Submission Mode : <FONT SIZE="3" COLOR="red">Through OMR Sheet </FONT></font></B>
			<%
			}	
			%>
			<hr>
			</td>
			</tr>							
			</table>
			</center>	
			
	<CENTER><tr><td><INPUT Value="View Detail" TYPE="submit"></td></tr></CENTER>
	</table>
	<%
				//--------updated on -5/10/2012 by mohit sharma-------//
	try
	   {
	%>
	<center>
	<table width=10% align=center border=2 bordercolor=magroon><tr><td align=center nowrap><font color=blue>
	<b>Click  <a style="CURSOR:hand" onClick="window.print();"><img src="../../Images/printer.gif"></a> To Print</b></font></td></tr></table></td>
	</tr>
	</table>
	<TABLE  id="tblSearch" cellspacing="0" class="mytable filterable" rules=Rows  frame=box style="FONT-FAMILY: Arial; FONT-SIZE: x-small"  border=1 bordercolor=Black bordercolordark=White cellpadding=2 cellspacing=0 width="65%">
	<TR bgcolor="#ff8c00">
	<TH><font face="Arial" size=2 color="white">Sr.No.</font></TH>
	<TH><font face="Arial" size=2 color="white">Counselling-ID</font></TH>
	<TH><font face="Arial" size=2 color="white">Aplication-ID</font></TH>
	<TH><font face="Arial" size=2 color="white">Applicant Name</font></TH>
	<TH><font face="Arial" size=2 color="white">Father Name</font></TH>
	<TH><font face="Arial" size=2 color="white">Address</font></TH>
	<TH width="10%"><font face="Arial" size=2 color="white">AIEEE-RollNumber</font></TH>
	</TR>		 
	<%
	try
	{
	qry="SELECT DISTINCT applicationid,counsellingid , firstname || '-' || middlename || '-' || lastname namestud, fathername, caddress1 || ',' || caddress2   || ','  || caddress3                || ','  || pcity || ',' || pcountry adrs,AIEEEROLLNUMBER  FROM c#applicationmaster  ";
		
	if(mTYPE.equals("JIITOL") ){
	qry=qry+"where applicationid LIKE '%JIITOL%'";
		
		}
	else{
	qry=qry+"where applicationid LIKE '%JIITOM%'";
		
	}
	rst=db.getRowset(qry);
	//out.print(qry);
	while (rst.next())      
	{ 	
	%>			
	<center>
	<TR bgcolor="white" width="65%">
	<TD align="left">&nbsp;<b><%=++count%></b></TD>
	<TD bgcolor=white align=center><Font face=Arial color=black size=2><%=rst.getString("counsellingid")%></Font></a></TD>
	<TD bgcolor=white align=center><Font face=Arial color=black size=2><A HREF="Applicationfrm.jsp?ViewType=CNF&amp;COUNSID=<%=rst.getString("counsellingid")%>&amp;APPID=<%=rst.getString("applicationid")%>" target=_new><%=rst.getString("applicationid")%></A></Font></a></TD>
	<TD align="left">&nbsp;<%=rst.getString("namestud")%></TD>	
	<TD bgcolor=white align=left><Font face=Arial color=black size=2><%=rst.getString("fathername")%></Font></TD>
	<TD bgcolor=white align=left><Font face=Arial color=black size=2><%=rst.getString("adrs")%></Font></TD>
	<TD align="left">&nbsp;<%=rst.getString("AIEEEROLLNUMBER")%></TD>	
	</TR>     
	<%				
	}
	}
	catch(Exception e)
	{				
	}
	%>
	</table>
	</form>
	<script language="javascript" type="text/javascript">

			  jQuery.expr[":"].containsNoCase = function(el, i, m) {

              var search = m[3];

              if (!search) return false;

              return eval("/" + search + "/i").test($(el).text());
			  };

			jQuery(document).ready(function() {

               // used for the first example in the blog post

               jQuery('li:contains(\'DotNetNuke\')').css('color', '#0000ff').css('font-weight', 'bold');

  

              // hide the cancel search image

               jQuery('#imgSearch').hide();

  

              // reset the search when the cancel image is clicked

               jQuery('#imgSearch').click(function() {

                  resetSearch();

               });

   
             // cancel the search if the user presses the ESC key

               jQuery('#txtSearch').keyup(function(event) {

                 if (event.keyCode == 27) {

                     resetSearch();

               }

              });  

              // execute the search

               jQuery('#txtSearch').keyup(function() {

                  // only search when there are 3 or more characters in the textbox

                 if (jQuery('#txtSearch').val().length > 2) {

                 // hide all rows

                 jQuery('#tblSearch tr').hide();

                 // show the header row

                 jQuery('#tblSearch tr:first').show();

                 // show the matching rows (using the containsNoCase from Rick Strahl)

                       jQuery('#tblSearch tr td:containsNoCase(\'' + jQuery('#txtSearch').val() + '\')').parent().show();

                      // show the cancel search image

                    jQuery('#imgSearch').show();

                  }

                else if (jQuery('#txtSearch').val().length == 0) {

                      // if the user removed all of the text, reset the search

                    resetSearch();
                  }
                   // if there were no matching rows, tell the user

                if (jQuery('#tblSearch tr:visible').length == 1) {

                     // remove the norecords row if it already exists

                      jQuery('.norecords').remove();

                      // add the norecords row

                     jQuery('#tblSearch').append('<tr class="norecords"><td colspan="5" class="Normal">No records were found</td></tr>');

                  }

             });

          });

          function resetSearch() {

             // clear the textbox

             jQuery('#txtSearch').val('');

            // show all table rows

            jQuery('#tblSearch tr').show();

             // remove any no records rows

             jQuery('.norecords').remove();

             // remove the cancel search image

             jQuery('#imgSearch').hide();

             // make sure we re-focus on the textbox for usability

             jQuery('#txtSearch').focus();

         }

</script>
	</center>
	
	<%
		 
           }catch(Exception e)
            {
               out.print(e);
           }
        %>
</body>
</html>