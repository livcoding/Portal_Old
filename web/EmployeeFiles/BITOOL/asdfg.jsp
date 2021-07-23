<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        DBHandler db = new DBHandler();
        ResultSet rs = null;
        ResultSet rsd = null;
        String qry = "";
       	int count=0;
%>
<html>
<TITLE>Companies Visited For Placement </TITLE>
 <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >


			<form name="frm"  method="get" >
            <input id="x" name="x" type=hidden>
			<table align=center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR="">Comapanies Visited For Placement</b></FONT>
</font><BR><img src="images/ornament.gif" width="474" height="11" alt="" /></td></tr>
</table>
			<table width="80%" ALIGN=CENTER bottommargin=0  topmargin=0 id=id2>
            <tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><FONT SIZE="6" COLOR=""><U><B> </B></U></FONT>
            </font></td></tr>
			</table>
			<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
            <tr>
               
			   <td allign="left"><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;INSTITUTE CODE:&nbsp;&nbsp;&nbsp&nbsp&nbsp&nbsp&nbsp;<select  NAME="institutecode"  ID="institutecode" style="width:150px">
     <%

try {

//          qry1="select 'ALL' section from dual union all";
qry = "select 'ALL'  institutecode from dual union all select distinct institutecode from institutemaster where nvl(deactive,'N')='N' ";
rsd = db.getRowset(qry);
//out.print(qry);
while (rsd.next()) {
%>

<option value="<%=rsd.getString("institutecode")%> "><%=rsd.getString("institutecode")%></option>
<%
}
} catch (Exception e) {
}
%>
</select></td>		                                                                                                                     			   <td allign="left"><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;EVENT CODE:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<select  NAME="eventcode"  ID="eventcode" style="width:150px"> 
<%

try {

//qry1="select 'ALL' section from dual union all";

qry = " select 'ALL'  eventcode, 'ALL' EventDesc from dual union all select distinct eventcode, EventDescription EventDesc from tp#eventmaster where nvl(deactive,'N')='N' ";
rsd = db.getRowset(qry);

while (rsd.next()) {
%>
<option value="<%=rsd.getString("eventcode")%>"><%=rsd.getString("EventDesc")%></option>
<%
}
} catch (Exception e) {
}
%>
</select></td>
</tr>
 <tr>
           <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit" ></td>
		</tr>
        </tr>
 </table>
 </form>
<%
try
{
String mInst="";
if(request.getParameter("x")!=null)
	{
if(request.getParameter("institutecode")==null)
	mInst="";
else

	mInst=request.getParameter("institutecode").toString().trim();
	String kacd="";
	if(request.getParameter("eventcode")==null)
	kacd="";
else
	kacd=request.getParameter("eventcode").toString().trim();

%>
<br>
				<table align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="40%" border=1 >
				<thead>
                <tr bgcolor="#ff8c00">
                <td><font color="white">S.NO </font></b></td>
				<td><font color="white">COMPANY NAME </font></b></td>
                <td><font color="white">VISITING DATE</font></b></td>
               	</tr>
				</thead>
				<tbody>
				 <%                                 					
				
				qry="SELECT distinct a.companycode,to_char(a.REGISTRATIONDATE,'dd-mm-yyyy')REGISTRATIONDATE from TP#EVENTPARTICIPENTS a,TP#EVENTMASTER b,institutemaster c WHERE a.institutecode=c.institutecode and a.eventcode=b.eventcode order by a.companycode " ;				
					
					if (!mInst.equals("ALL")) {
					qry = qry + "and  c.institutecode='" + mInst + "' ";
						}
					 
					if (!kacd.equals("ALL")) {

					qry = qry + "and  b.eventcode='" + kacd + "' ";

					}
					//out.print(qry);
					 rs = db.getRowset(qry);
					 while (rs.next()) {
                    %>
				
					 <td bgcolor="white"><font color="black"><B><%=++count%></B></td>
					 <TD bgcolor=white align=left><a href="kya.jsp?ViewType=CNF&amp;COMP=<%=rs.getString("companycode")%>&amp;EMPTY=<%=rs.getString("REGISTRATIONDATE")%>" target=_new><Font face=Arial color=blue size=2><%=rs.getString("companycode")%></Font></a></TD>
                   
                    <td bgcolor="white"><font color="black"><%=rs.getString("REGISTRATIONDATE")%></td>
                                  
                    </tr>
				   <%
						 }
						 }
						 } catch (Exception e) {
						 //out.print(e);
						 }
				     %>
                 </tbody>
</table>
</body>
</html>