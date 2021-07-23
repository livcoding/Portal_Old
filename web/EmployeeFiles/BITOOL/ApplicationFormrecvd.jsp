<%--
    Document   : CounsLogin
    Created on : March 28, 2009, 12:46:34 PM
    Author     : Sunny Singhal
--%>

<%@ page language="java" import="java.sql.*,jpalumni.*" %>
<%
	try
	{
		%>
		<html>
		<head>
			<title>Counselling Application Form Recived</title>
				<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
				<link href="../Resources/CSS/stylesheet.css" rel="stylesheet" type="text/css" />
			<script language="JavaScript" type ="text/javascript">
				if(window.history.forward(1) != null)
					window.history.forward(1);
			</script>
		</head>
		<%
		DBHandler db=new DBHandler();
		ResultSet rs=null;
		String applicationno="",counsid="",qry="";
		%>
		<BODY bgcolor=white  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  CLASS="table" >
		<br>
			<FORM NAME="form" METHOD=post ACTION="ApplicationFormrecvd.jsp">
			<input type="hidden" name="x"> 
				<center><img src="../Images/header.jpg" alt="header"></center><br>
				<table border=0 align=center>
					<tr>
						<td align=center class="pageheading">Application Status
						</td>
					</tr>
				</table><br>
				<table border=1 rules="none"  width="30%" cellspacing="0" cellpadding="5" align=center>
					<tr>
						<td class="tablecell" align="left">&nbsp; &nbsp;Application Number </td>
						<td class="tablecell"><input type="text" name="applicationno" maxlength="30" size="15"></td>
					</tr>
					<tr>
						<td class="tablecell" align="left">&nbsp; &nbsp;Couselling ID </td>
						<td class="tablecell"><input type="text" name="counsid" maxlength="4" size="15"></td>
					</tr>
					<tr>
						<td colspan="2" align="center" class="tablecell"><input type="submit" value="Save"></td>
					</tr>
				</table>	
				<%
				if(request.getParameter("x")!=null)
				{	
					
					if(request.getParameter("applicationno")==null)
						applicationno="";	
					else
						applicationno=request.getParameter("applicationno");
					if(request.getParameter("counsid")==null)
						counsid="";
					else
						counsid=request.getParameter("counsid");
					if(!applicationno.equals("") && !counsid.equals(""))
					{
						try
						{
							qry="select 'y' from C#APPLICATIONFORMRECVD where APPLICATIONNO='"+applicationno+"'";
							rs=db.getRowset(qry);
							if(rs.next())
							{
								out.print("<br><center><font color=red size=3><b>Application No. Already Present....</b></font></center>");	
							}
							else
							{
								qry="insert into C#APPLICATIONFORMRECVD (COUNSELLINGID, APPLICATIONNO) values ('"+counsid+"','"+applicationno+"')";
								int j = db.insertRow(qry);
								if(j==0)
									out.print("<br><center><font color=red size=3><b>Error while saving record..</b></font></center>");
								if(j>0)
									out.print("<br><center><font color=green size=3><b>Rercord Saved Sucessfully....</b></font></center>");	
							}
						}catch(SQLException e)
						{ //out.println(e);
						}
						
					}
					else
					{
						 out.print("<br><center><font color=red size=3><b>Please Enter All Field....</b></font></center>");
					}
					
				}
				%>

			</FORM>
		</BODY>
		</HTML>
		<%
	}
	catch(Exception e)
	{
//		out.println(e);
	}
%>
