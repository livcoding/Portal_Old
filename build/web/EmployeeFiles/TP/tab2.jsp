<%@page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%
DBHandler db = new DBHandler();
 ResultSet rs =  null ,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
 String qry="",qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",mInst="",mCritvales="",eventyear="",institutes="";
   int n=0 ,i=0,j=1,csst=0,num_participant=0,pstudents=0,balance=0;
   double percentage=0.0;
  eventyear=request.getParameter("id")==null?"":request.getParameter("id");
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

function getNewWindow(url) {

    window.open(url,'_blank','width=1500,height=660,scrollbars=1,resizable=yes,left=50,top=50,screenX=50,screenY=50');
	
}
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
	background-color: pink;
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
  <br><center><font color="#a52a2a" ><FONT SIZE="4" COLOR=""><B><u>Placement Summary of <%=eventyear%></u></B></FONT></font></center>
   <br>
  <table id="table1" cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
		<thead>
			<tr bgcolor="silver">
			<th nowrap>Institute</th>
			<th nowrap>No of Participant*</th>
			<th nowrap>Placed Students</th>
			<th nowrap>Balance</th>
			<th nowrap>Percentage</th>
			</tr>
			
		</thead>
		
		<tbody>
<%
qry="SELECT distinct  nvl(institutecode,'') institutecode FROM tp#institute WHERE eventcode in ( SELECT eventcode FROM tp#eventmaster c WHERE TO_CHAR (c.eventenddate, 'yyyy') IN ('"+eventyear+"')) ";
rs=db.getRowset(qry);
//out.print(qry);
while(rs.next())
{
	institutes=rs.getString("institutecode");

%>
	<tr style="cursor:pointer"  onclick="getNewWindow('tab3.jsp?id=<%=eventyear%>&id1=<%=institutes%>')" >
			<td nowrap>
			<font size="2">
			<%=institutes%>
			</font></td>
<%qry1="SELECT  nvl(count(distinct studentid),'0') num_participant  FROM tp#eventparticipents a where a.REGISTERED='Y' and a.institutecode='"+institutes+"' and a.EVENTCODE in (select eventcode from TP#EVENTMASTER c where to_char(c.EVENTENDDATE,'yyyy') in ('"+eventyear+"') )"; 
 //out.print(qry1);
  rs1=db.getRowset(qry1);
  if(rs1.next())
	{
	num_participant=rs1.getInt("num_participant");
	}%>
			<td nowrap>
			<font size="2">
		<%=num_participant%>
			</font></td>
		<%
		qry2="select nvl(count(distinct studentid),'0') pstudents from TP#AFTERINTERVIEW where selected='Y' and institutecode='"+institutes+"'  and eventcode in (select eventcode from tp#eventmaster where to_char(EVENTEndDATE,'yyyy')='"+eventyear+"' )";
	    rs2=db.getRowset(qry2);
        if(rs2.next())
	    {
	   pstudents=rs2.getInt("pstudents");
	   }
	  %>
			<td nowrap>
			<font size="2">
		<%=pstudents%>
			</font></td>
			<%balance=num_participant-pstudents;%>
			<td nowrap >
			<font size="2">
			<%=balance%>
			</font></td>
			<%try{
		  if(num_participant==0)
		  {
			  percentage=0;
		  }else{

		  percentage=(pstudents*100)/num_participant;}
	  }catch (Exception e){
	  //out.print(e);
	  }%>
			<td nowrap >
			<font size="2">
		<%=percentage%>
			</font></td>
			<%percentage=0;%>
			</tr>
		<%}%></tbody>
	</table>