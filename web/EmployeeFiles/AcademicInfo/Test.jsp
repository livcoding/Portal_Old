<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        DBHandler db = new DBHandler();
        ResultSet rs = null;
        ResultSet rsd = null;
        ResultSet rs1 = null;
		ResultSet rs111 = null;
		ResultSet rs1111 = null;
        ResultSet rs2 = null;
        String qry = "";
        GlobalFunctions gb = new GlobalFunctions();
//-----------------ADDED CODE----------------------DATE-28-MARCH-2011@mohit sharma
        String mRegCode = "";
        String mFeeHead = "";
        String mAcademicYear = "",mCheck="",cInst="" ,mINSTITUTECODE="";
        String mProgramCode = "";
        String mBranchCode = "";
        String minst="" ,mInst="" , mIntscode = "";
		int count=0;
		int counte=0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv= "Content-Type" content="text/html; charset=utf-8" />
<script type= "text/javascript" src="js/jquery.min.js"></script>
<script type= "text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
<link type="text/css" rel="StyleSheet" href="css/newtest.css" />
<title>Programm wise strenght</title>
<script type='text/javascript'>
function sldeUpDown(id,header){
 if($("#"+id).css('display') == 'block'){
 $("#"+id).slideUp('slow');
 $('#'+header).html('Click To Expand Program Code   -  Values');
 }
 else {
 $("#"+id).slideDown('slow');
 $('#'+header).html('Click To Collapse Program Code   -  Values ');
}
}
function expandAll(){
 $(".demo").slideDown('slow');
 $(".demo1").slideDown('slow');
 $('.header1').html('Click To Collapse Program Code   -  Values');
 $('.header2').html('Click To Collapse Program Code   -  Values');
}
function colapseAll(){
 $(".demo").slideUp('slow');
 $(".demo1").slideUp('slow');
 $('.header1').html('Click To Expand Program Code   -  Values');
 $('.header2').html('Click To Expand Program Code   -  Values');
}
</script>
<TITLE>#### JIIT [ View Academic Fee detail ] 
</TITLE>
<script language="JavaScript" type ="text/javascript">
//-------------------------------------branch code------------------------------------------//
function removeAllOptions(selectbox)
{
var i;
for(i=selectbox.options.length-1;i>=0;i--)
{
selectbox.remove(i);
}
}
</script>
<script type="text/javascript">
jQuery(document).ready(function() {
  jQuery(".content").hide();
  //toggle the componenet with class msg_body
  jQuery(".heading").click(function()
  {
    jQuery(this).next(".content").slideToggle(500);
  });
});
</script>
<script language=javascript>
<!--
function RefreshContents()
{
document.frm.x.value='ddd';
document.frm.submit();
}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR="">Program Wise Student Strenght</FONT>
</font><BR><img src="images/ornament.gif" width="474" height="11" alt="" /></td></tr>
</table>
<table  bottommargin=0  topmargin=0 cellpadding=1 cellspacing=0 align=center rules=groups border=1 bordercolor="brown">
<tr><td >&nbsp;&nbsp;<STRONG><FONT color=black face=Arial size=2>Institute :</STRONG></FONT>
            <%
            qry="select distinct institutecode from companyinstitutetagging where nvl(deactive,'N')='N' order by institutecode ";
            rs=db.getRowset(qry);
            while(rs.next())
            {
            if(request.getParameter("x")!=null)
			{
            if(request.getParameter("radio1").equals(rs.getString(1).toString().trim()))
            {
                      
             %><input type="radio" name="radio1" id="<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" checked ><%=rs.getString(1)%> &nbsp;<%
                
            }
               else
                   {
                    %><input type="radio" name="radio1" id="<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" ><%=rs.getString(1)%> &nbsp;<%
                   }
            }
               else
            {
                   
					if(rs.getString(1).equals("JIIT"))
						mCheck="checked";
					else
						mCheck="";
				   %>
				   
				   
				   <input type="radio" name="radio1" id="<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" <%=mCheck%> ><%=rs.getString(1)%> &nbsp;
				   
				   <%
             }
             }
                
           if(request.getParameter("x")!=null)
		   {
           if(request.getParameter("radio1").equals("All"))
           {
           %>
            <input type="radio" name="radio1" id="radio3" value="All" checked>All
            <%
            }
            else
            {
            %>
            <input type="radio" name="radio1" id="radio3" value="All" >All
            <%
            }
            }
            else
            {
            %>
            <input type="radio" name="radio1" id="radio3" value="All" >All
            <%
            }
            %>
            </td>
            </tr>
<TR>
<td align="center"><INPUT Type="submit" Value="Show/Refresh"></td>
</TR>

</table>
</form>        <%

//----------------------updated by mohit on 1/4/2012-----------------------------------------
           try
              { 
        if (request.getParameter("x") != null) {

			if (request.getParameter("radio1")==null)
					cInst="";
				else
					cInst=request.getParameter("radio1").toString().trim();

	 //------------ADDED CODE--------------DATE-30-MARCH-2011---------
           
    //out.print(mAcademicYear + "---" + mBranchCode + "---" + mFeeHead + "---" + mProgramCode + "---" + mRegCode);
   // session.setAttribute("listorder",mList);
      //-------------------------------------------------------------------
%>
        <br>
        <table align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
        <thead>
        <tr bgcolor="#ff8c00">
		<td><b><font color="white">Sr.no.</font></b></td>
		<td><b><font color="white">Institute Code</font></b></td>
        <td><b><font color="white">Academic Year</font></b></td>
        <td><b><font color="white">Program Code</font></b></td>
        <td><b><font color="white">Total Student</font></b></td>
		</tr>
		</thead>
		<tbody>
		<tr>
	    <%
		//---Query To Display records---------Qry Added on 9/30/2011 by mohit
		qry="SELECT   a.INSTITUTECODE INSTITUTECODE , a.academicyear academicyear, nvl( a.programcode,' ') programcode, nvl(a.branchcode ,' ') branchcode, COUNT (DISTINCT a.studentid) totalstudents          FROM studentmaster a ";
		qry=qry+" Where a.InstituteCode= decode( '"+cInst +"','All',a.InstituteCode,'"+cInst +"') and NVL (a.deactive, 'N') = 'N' ";
		qry=qry+"GROUP BY a.INSTITUTECODE ,a.academicyear, a.programcode, a.branchcode ORDER BY a.INSTITUTECODE ,a.academicyear, a.programcode, a.branchcode";
		out.print("&nbsp;&nbsp;>>Result Shown for the Following parameter- (Institute-"+cInst+")");
		rs = db.getRowset(qry);  
		//out.print(qry);
		while (rs.next())
		{
		%>
<td><B><%=++counte%></B></td>
<TD bgcolor=white align=center><a href="Studentdetal.jsp?ViewType=CNF&amp;academicyear=<%=rs.getString("academicyear")%>&amp;programcode=<%=rs.getString("programcode")%>&amp;INSTITUTECODE=<%=rs.getString("INSTITUTECODE")%>&amp;branchcode=<%=rs.getString("branchcode")%>" target=_new><Font face=Arial color=blue size=2><%=rs.getString("INSTITUTECODE")%></Font></a></TD>
<TD bgcolor=white align=center><a href="Studentdetal.jsp?ViewType=CNF&amp;academicyear=<%=rs.getString("academicyear")%>&amp;programcode=<%=rs.getString("programcode")%>&amp;INSTITUTECODE=<%=rs.getString("INSTITUTECODE")%>&amp;branchcode=<%=rs.getString("branchcode")%>" target=_new><Font face=Arial color=blue size=2><%=rs.getString("academicyear")%></Font></a></TD>
<td align="center"><div class="layer1">
<p class="heading">Click to view the Branch wise detail for the Program Code >> <%=rs.getString("programcode")%></p>
<div class="content"><a href="Studentdetal.jsp?ViewType=CNF&amp;academicyear=<%=rs.getString("academicyear")%>&amp;programcode=<%=rs.getString("programcode")%>&amp;INSTITUTECODE=<%=rs.getString("INSTITUTECODE")%>&amp;branchcode=<%=rs.getString("branchcode")%>" target=_new><Font face=Arial color=blue size=2><%=rs.getString("branchcode")%>--<%=rs.getString("totalstudents")%></Font></a></div>
</div>
</td>
<td><%=rs.getString("totalstudents")%></td>
</tr>
<% 
session.setAttribute("academicyear",mAcademicYear);
session.setAttribute("programcode",mProgramCode);
session.setAttribute("branchcode",mBranchCode);
session.setAttribute("INSTITUTECODE",mINSTITUTECODE);
%>
<%
//-----------ADDED CODE---------ON/12/24/2011
}
qry = "select SUM(totalstudents) b  from (" +qry+ ")";
//out.print(qry);
            rs = db.getRowset(qry);
            if (rs.next()) 
				{
				%>
            <tr bgcolor=white ><td></td>			
            <td colspan=3 align=right><b>Total Student</b>&nbsp; &nbsp;</td>
            <td align=left><b><%=rs.getString("b")%></b>&nbsp; &nbsp;</td>
                <%
				}
				%>
            </tr>
                <tr><td colspan=11><marquee scrolldelay=300 behavior=alternate>Click to view the Branch wise detail....</marquee></td></tr>
			    </tbody>
			    </table>
			    <form>
				<input type="button" value="Print this page"
				onclick="window.print();return false;"/>
				</form>
				<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
			</script>
			<table ALIGN=Center VALIGN=TOP>
            <tr>
            <td valign=middle><br><br>
            <IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:info@jiit.ac.in'>info@jiit.ac.in</A></FONT>
           </td>
		   </tr>     
		   </table>
		   <%
		   }
           }
		   catch(Exception e)
           {
           out.print(e);
           }
		   %>
</body>
</html>
