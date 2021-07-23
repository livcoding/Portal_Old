<%@page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%
DBHandler db = new DBHandler();
 ResultSet rs =  null ,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
 String qry="",qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",mInst="",mCritvales="",eventyear="";
   int n=0 ,i=0,j=1,csst=0,num_participant=0,pstudents=0,balance=0;
   double percentage=0.0;
  
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
	$('#tableone').tableHover();	
});

function getNewWindow(url) {

    window.open(url,'_blank','width=500,height=250,resizable=yes,left=460,top=200,screenX=50,screenY=50');
	
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
td.hover
{
	background-color: #69f;
}
th.hover, tfoot td.hover
{
	background-color: lightivory;
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
  <br><center><font color="#a52a2a" ><FONT SIZE="4" COLOR=""><B><u>Placement Summary</u></B></FONT></font></center>
   <br>
  <table id="tableone" cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
		<thead>
			<tr bgcolor="silver">
			<th nowrap>Placement Year</th>
			
			<th nowrap>No of Participant</th>
			<th nowrap>Placed Students</th>
			<th nowrap>Balance</th>
			<th nowrap>Percentage</th>
			</tr>
			
		</thead>
		
		<tbody>
<%try{
qry="select distinct to_char(a.EVENTEndDATE,'yyyy') EVENTEndDATE from TP#EVENTMASTER  a where nvl(a.LOCKEVENT,'N')='N' and rownum<=5 order by to_char(a.EVENTEndDATE,'yyyy') desc";
rs=db.getRowset(qry);
//out.print(qry);
while(rs.next())
{
	eventyear=rs.getString("EVENTEndDATE");

%>
	<tr style="cursor:pointer" onclick="getNewWindow('tab2.jsp?id=<%=eventyear%>')">
			<td><font size="2">
			<%=eventyear%>
			</td>
<%
	
qry5=" select studentid,Institutecode,Academicyear,Enrollmentno, Studentname,programcode,branchcode,sectioncode,SUBSECTIONCODE,semester from ( select studentid studentid ,nvl(Institutecode,'')Institutecode,nvl(Academicyear,'') Academicyear,nvl(Enrollmentno,'')Enrollmentno,nvl(Studentname,'')Studentname,nvl(programcode,'')programcode,nvl(branchcode,'')branchcode,nvl(sectioncode,'')sectioncode,nvl(SUBSECTIONCODE,'')SUBSECTIONCODE,nvl(semester,'')semester from v#studentmaster k where nvl(deactive,'N')='N' and studentid IS NOT NULL ";

qry6=" select  distinct cset from  TP#ELIGIBILITYCRITERIA where eventcode in (select eventcode from TP#EVENTMASTER c where to_char(c.EVENTENDDATE,'yyyy')= ('"+eventyear+"') ) and cset=decode('ALL','ALL',cset,'ALL' )  ";
rs6=db.getRowset(qry6);
 //out.print(qry6);
while(rs6.next())
	{

	csst++;
	//out.print("********##########*******"+csst);
	if(csst>2) {
	 qry5=qry5+" ";
	}
qry2=" select CRITERIAID ,CRITERIAOPERATORBEFORE  ,slno  from  TP#ELIGIBILITYCRITERIA where  eventcode in (select eventcode from TP#EVENTMASTER c where to_char(c.EVENTENDDATE,'yyyy')= ('"+eventyear+"') ) and cset='"+rs6.getString("cset")+"' order by cset ";
//out.print(qry2);
rs2=db.getRowset(qry2);

while(rs2.next())
{
mCritvales="";
	//
qry4=" select CRITERIAID ,CRITERIATABLE ,CRITERIAFIELD  from TP#CRITERIAMASTER where criteriaid='"+rs2.getString("CRITERIAID")+"' ";
//out.print(qry4);
rs4=db.getRowset(qry4);
if(rs4.next())
{

	//if(csst>2){
	// qry=qry+"     ";
	//}else{
	// qry=qry+" and    ";
	//}
 qry5=qry5+" and  studentid IN ( select studentid from "+rs4.getString("CRITERIATABLE")+" where   ";
//out.print(qry5);
 qry3=" select CRITERIAVALUE,SUBSLNO  from  TP#ELIGIBILITYCRITERIAVALUE  where  eventcode in (select eventcode from TP#EVENTMASTER c where to_char(c.EVENTENDDATE,'yyyy')= ('"+eventyear+"') ) and cset='"+rs6.getString("cset")+"' and  criteriaid='"+rs2.getString("CRITERIAID")+"' and    slno='"+rs2.getString("slno")+"'  ";
	//out.print(qry3);
rs3=db.getRowset(qry3);
while(rs3.next())
{
if (mCritvales.equals("")){
    mCritvales = mCritvales + "'" +rs3.getString("CRITERIAVALUE")+ "'";
} 
else {
    mCritvales = mCritvales + ",'" +rs3.getString("CRITERIAVALUE")+ "'";
}
	 
}

qry3=" select CRITERIAVALUE,SUBSLNO  from  TP#ELIGIBILITYCRITERIAVALUE  where  eventcode in (select eventcode from TP#EVENTMASTER c where to_char(c.EVENTENDDATE,'yyyy')= ('"+eventyear+"') )  and cset='"+rs6.getString("cset")+"'  and  criteriaid='"+rs2.getString("CRITERIAID")+"' and    slno='"+rs2.getString("slno")+"'  ";
//out.print("Gyan"+qry3);
rs3=db.getRowset(qry3);
if(rs3.next())
{
	
if(rs4.getString("CRITERIAFIELD").equals("YEAROFPASSING")){

qry5=qry5+"  1=1    ";

}
else if(rs4.getString("CRITERIAFIELD").equals("FAIL")){

qry5=qry5+"  1=1    ";

}
else{

qry5=qry5+"   "+rs4.getString("CRITERIAFIELD")+" "+rs2.getString("CRITERIAOPERATORBEFORE")+"  ("+mCritvales+")     ";

}
qry5=qry5+"   )   "; 

}
}
}
}
if(csst>2){
	 qry5=qry5+" )  ";
	}
 qry5=qry5+" union        SELECT b.studentid studentid ,   NVL (b.institutecode, '') institutecode,  NVL (b.academicyear, '') academicyear,   NVL (b.enrollmentno, '') enrollmentno,  NVL (b.studentname, '') studentname, NVL (b.programcode, '') programcode,   NVL (b.branchcode, '') branchcode, NVL (b.sectioncode, '') sectioncode,   NVL (b.subsectioncode, '') subsectioncode, NVL (b.semester, '') semester ";
   // qry=qry+" , (SELECT   DISTINCT COUNT (SUBJECTID)";
    //qry=qry+"   FROM   StudentRESULT e";
   // qry=qry+"   WHERE       e.studentid = b.studentid";
    //qry=qry+"   AND e.Institutecode = b.institutecode";
   // qry=qry+"   AND e.FAIL = 'Y') FAILTOTAL ";
    qry5=qry5+"     FROM TEMP#TPSTUDENTMASTER a,v#studentmaster b    where a.studentid=b.studentid  ";
  
 qry5=qry5+" union     SELECT b.studentid studentid ,   NVL (b.institutecode, '') institutecode,  NVL (b.academicyear, '') academicyear,   NVL (b.enrollmentno, '') enrollmentno,  NVL (b.studentname,'' ) studentname, NVL (b.programcode, '') programcode,   NVL (b.branchcode, '') branchcode, NVL (b.sectioncode, '') sectioncode,   NVL (b.subsectioncode, '') subsectioncode, NVL (b.semester, '') semester";

//out.print(qry5);


	
qry1=" SELECT  nvl(count(studentid),'0') num_participant  FROM tp#eventparticipents a where a.REGISTERED='Y' and a.EVENTCODE in (select eventcode from TP#EVENTMASTER c where to_char(c.EVENTENDDATE,'yyyy')in ('"+eventyear+"') )"; 
//out.print(qry1);
 rs1=db.getRowset(qry1);
if(rs1.next())
	{
	num_participant=rs1.getInt("num_participant");
	}%>
			<td>
		<font size="2"><%=num_participant%></font>
			</td>
<%qry2=" select nvl(count(studentid),'0') pstudents from TP#AFTERINTERVIEW where nvl(selected,'N')='Y' and eventcode in (select eventcode from tp#eventmaster where to_char(EVENTEndDATE,'yyyy')='"+eventyear+"' )";
	//out.print(qry2);
	rs2=db.getRowset(qry2);
if(rs2.next())
	{
	pstudents=rs2.getInt("pstudents");
	}
	%>
			<td>
		<font size="2"><%=pstudents%></font>
			</td>
			<font size="2"><%balance=num_participant-pstudents;%></font>
			<td>
		<font size="2"><%=balance%></font>
			</td>
			<%
	if(num_participant==0)
	{percentage=0;
	}
	else{
		percentage=(pstudents*100)/num_participant;
	}
	%>
			<td>
			<font size="2"><%=percentage+" %"%></font>
			</td>
			</tr>
		<%}%></tbody>
	</table>
	<%}catch(Exception e)
	{
//out.print(e);
}%>			