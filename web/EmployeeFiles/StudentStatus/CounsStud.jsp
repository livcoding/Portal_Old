<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
String mHead="JAYPEE INSTITUTE OF IN INFORMATION TECHNOLOGY UNIVERSITY, NOIDA ### COUNSELLING 2009 ###";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%></TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
String qry="";
String mInst="";
String mName="";

try
   {
	if(1==1)
	{
		if (1==1)
		{
		%>	
	
		<form name=frm1 method=post Action="ShowFrameStud.jsp">
		<table border=4 bordercolor=green align=center>
		<tr><td align=center><font color=brown face='Arial' size=4>Setup for Students Admission Status</font>
		<table border=1 bordercolor=blue rules=groups  cellpadding=0 cellspacing=0 width='100%'>
		<tr><td><font color=Red><b>Display Institute</b></font></td></tr>
		<%
		String mCDay="",mLDay="";
			qry="Select to_char(sysdate,'DD-MM-YYYY') CDay,to_char(sysdate-1,'DD-MM-YYYY') PDay from C#SEATDISPLAY A, C#INSTITUTEMASTER B Where A.INSTITUTECODE is not null and A.InstituteCode=b.InstituteCode and nvl(A.NOOFSEATS,0)>0 and rownum<=1 group by A.INSTITUTECODE,B.INSTITUTENAME";	 

			rs=db.getRowset(qry);			
			if (rs.next())
			{
			  mCDay=rs.getString(1);
			  mLDay=rs.getString(2);
			}
			qry="Select A.INSTITUTECODE INSTITUTECODE, nvl(B.INSTITUTEName,A.INSTITUTECODE) IName from C#SEATDISPLAY A, C#INSTITUTEMASTER B Where A.INSTITUTECODE is not null and A.InstituteCode=b.InstituteCode and nvl(A.NOOFSEATS,0)>0 group by A.INSTITUTECODE,B.INSTITUTENAME";	 
			rs=db.getRowset(qry);			
			while (rs.next())
			{			
			mName="I"+rs.getString("INSTITUTECODE");
			%>
			<tr><td>
			<input checked type='checkbox' Vale="Y" name=<%=mName%>><%=rs.getString("IName")%>
			</td></tr>
			<%
			}
		
		%>
			</table>
		<br>
		<table width='100%' rules=groups  border=1 bordercolor=black cellpadding=0 cellspacing=0>
			<tr><td><font color=red><b>Display Categories</b></font></tr></tr>
		<%
			qry="SELECT A.CATEGORYCODE CATEGORYCODE,nvl(B.CATEGORYDESC,A.CATEGORYCODE)||' ('||A.CATEGORYCODE||' )' cat from C#SEATDISPLAY A, C#CATEGORYMASTER B Where A.CATEGORYCODE=B.CATEGORYCODE And A.INSTITUTECODE is not null and nvl(A.NOOFSEATS,0)>0 Group By A.CATEGORYCODE,nvl(B.CATEGORYDESC,A.CATEGORYCODE)||' ('||A.CATEGORYCODE||' )' order by A.CATEGORYCODE";

 
			rs=db.getRowset(qry);			
			while (rs.next())
			{			
			mName="C"+rs.getString("CATEGORYCODE").trim();
			%>
			<tr><td>
			<input type='checkbox' name="<%=mName%>" id=name="<%=mName%>"><%=rs.getString("cat")%>
			</td></tr>
			<%
			}
			%>		
			</table>

			</td></tr>
			<tr><td>
			<font color=red><b>Refresh Rate in Second(s):</font> <input type=text id=second name=second value="60" size=5 maxlength=5>
			<font color=red><b>Counseling for the Year:</b></font> <INPUT id=TxtYear style="WIDTH: 36px; HEIGHT: 22px" size=4 value="2009" name=TxtYear>
			</b></td></tr>
			<tr><td><font color=red><b>Counselling for the Period (Formt: DD-MM-YYYY)</b></font>
			<input type="Text" ID="dtFrom" Name="dtFrom" value="<%=mLDay%>" style="WIDTH: 80px; HEIGHT: 22px" size=10> And <input type="Text" ID="dtTo" Name="dtTo" style="WIDTH: 80px; HEIGHT: 22px" value="<%=mCDay%>" size=10>			
			</td></tr>
			<tr><td align=center><STRONG><input type="submit" name=btn1 id=btn1 value="Show Seat Status"></td></tr>
			</table>
			</form>
			<%
    		
		   }
		  else
		{
	         %>
	<br>
	<font color=red>
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br><br><br>
   	<%

        	   }   
	     }   
           else 
           {
                   out.print("<br><img src='../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
            } 
   } 
   catch(Exception e)
  {
 
   }


 %>
		</BODY>
		</HTML>