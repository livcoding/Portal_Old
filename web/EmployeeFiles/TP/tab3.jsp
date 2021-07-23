<%@page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%
DBHandler db = new DBHandler();
 ResultSet rs =  null ,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
 String qry="",qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",mInst="",mCritvales="",eventyear="",institutes="",institute="",sname="",enrollno="",academicyear="",branch="";
   int n=0 ,i=0,j=1,csst=0,num_participant=0,pstudents=0,balance=0,semester=0;
   double percentage=0.0;
  eventyear=request.getParameter("id")==null?"":request.getParameter("id");
  institute=request.getParameter("id1")==null?"":request.getParameter("id1");
  
  if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();
	%>

	<?xml version="1.0" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <TITLE>#### JIIT [Querry Criteria]</TITLE>
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<script type="text/javascript" src="js/jquery-1.2.1.pack.js"></script>
<script type="text/javascript" src="js/jquery.tablehover.min.js"></script>
<script type="text/javascript" src="js/jquery.tablehover.js">
</script>
<script type="text/javascript" src="js/chili.js">
</script>
<script type="text/javascript">
<!--
ChiliBook.recipeFolder = "/wp-content/jquery/chili/";
ChiliBook.stylesheetFolder = "/wp-content/jquery/chili/"; 
$(document).ready(function()
{
	$('#table1').tableHover();	
});

$('tr').click( function() {
    window.location = $(this).find('a').attr('href');
}).hover( function() {
    $(this).toggleClass('hover');
});
</script>
<style type="text/css">
table
{
	width: 400px;
}
td.click, th.click
{
	background-color: #bbb;
}
td.hover,tr.hover
{
	background-color: lightyellow;
}
th.hover, tfoot td.hover
{
	background-color: ivory;
}
td.hovercell, th.hovercell
{
	background-color: #abc;
}
td.hoverrow, th.hoverrow
{
	background-color: #6df;
}
tr.hover {
   cursor: pointer;
   /* whatever other hover styles you want */

}
</style>
</head>
    <body  aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
 <form name="a" id="a" method="post">
 <input id="x" name="x" type=hidden>
  <br><center><font color="#a52a2a" ><FONT SIZE="4" COLOR=""><B><u>Placement Summary of <%=institute%> in <%=eventyear%></u></B></FONT></font></center>
   <br>
  <table id="table1" cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
		<thead>
			<tr bgcolor="silver">
			<th nowrap align=left>Sr. No.</th>
			<th nowrap align=left>Student Name</th>
			<th nowrap align=left>Enrollment No.</th>
			<th nowrap align=left>Academic Year</th>
			<th nowrap align=left>Branch</th>
			<th nowrap align=left>Semester</th>
			</tr>
			
		</thead>
		
		<tbody>
<%try{
qry=" select nvl(a.studentname,'-') studentname,nvl(a.ENROLLMENTNO,'-') ENROLLMENTNO," +
        "nvl(a.ACADEMICYEAR,'-') ACADEMICYEAR,nvl(a.BRANCHCODE,'-') BRANCHCODE," +
        "nvl(a.SEMESTER,0) SEMESTER from v#studentmaster a where upper(a.institutecode)" +
        "=upper('"+institute+"') and a.studentid in(SELECT NVL (studentid, '0') pstudents" +
        " FROM  tp#eventparticipents WHERE   " +
        "eventcode IN (SELECT eventcode FROM tp#eventmaster WHERE TO_CHAR (eventenddate, 'yyyy') " +
        "= '"+eventyear+"')) ";
rs=db.getRowset(qry);
 //out.print(qry);
while(rs.next())
{i++;
	sname=rs.getString("studentname")==null?"":rs.getString("studentname").trim();
	enrollno=rs.getString("ENROLLMENTNO")==null?"":rs.getString("ENROLLMENTNO").trim();
	academicyear=rs.getString("ACADEMICYEAR")==null?"":rs.getString("ACADEMICYEAR").trim();
	branch=rs.getString("BRANCHCODE")==null?"":rs.getString("BRANCHCODE").trim();
	semester=rs.getInt("SEMESTER")==0?0:rs.getInt("SEMESTER");

%>
	<tr>
			<td nowrap align=left>
			<font size="2"><%=i%></font>
			</td>


			<td nowrap align=left>
			<font size="2"><%=sname%></font>
			</td>

			<td nowrap align=left >
			<font size="2"><%=enrollno%></font>
			</td>
		
			<td nowrap align=left>
			<font size="2"><%=academicyear%></font>
			</td>
			
			<td nowrap align=left>
			<font size="2"><%=branch%></font>
			</td>
			
			<td nowrap align=left>
			<font size="2"><%=semester%></font>
			</td>
	</tr>
<%}}catch(Exception e)
				{
				out.print(e);
			}%>		</tbody>
	</table>