<%@ page isErrorPage="true"%>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Logout/Signout ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body topmargin=10 rightmargin=10 leftmargin=10 bottommargin=10 bgproperties="fixed" bgcolor=#fce9c5>
<center>
<%
	String mStatus="";
	try
	{
	if (session.getAttribute("LOGINID").toString().trim().equals("") && session.getAttribute("LOGINID").toString().trim().equals(""))
	    mStatus="N";
	else
	    mStatus="Y";
	}
	catch(Exception e)
	{
	    mStatus="N";
	}	
	
	try
	{
		session.setAttribute("BASELOGINPASSWORD","");	
		session.setAttribute("BASELOGINTYPE","");
		session.setAttribute("BASELOGINID","");
		session.setAttribute("LOGINID","");
		session.setAttribute("ISADMINUSER","");
		session.setAttribute("USERNAME","");
		session.setAttribute("INSTITUTECODE","");
		session.setAttribute("CURRENTTESTCODE","");
		session.setAttribute("SPCLPERMIT","");
		session.setAttribute("CANDIDATECODE","");
		session.setAttribute("CANDIDATENAME","");
		session.setAttribute("EXAMSTARTDATETIME","");
		session.setAttribute("REMAININGTIME","");
		session.setAttribute("TOTALQUESTION","");
		session.setAttribute("LASTQUESTION","");
		session.invalidate();	
	}

	catch(Exception e)	{	}

	if (mStatus.equals("Y")) 
	{
	%>
<TR>
<TD>
<STRONG><FONT face=Verdana color=lightseagreen>You have Logout successfully</FONT></STRONG>      
	<BR><BR><FONT face=Verdana color=#eb922c><STRONG>If your Main or any related window is still open then close it for better security.</STRONG></FONT>          
<BR>
</td>
</tr>
	<%
	}
	else
	{
	%>
<TR>
<TD> 
<STRONG><FONT face=Verdana color=lightseagreen>You were not SignIn or Your session has expired (Session Timeout)</br><BR>
<FONT face=Verdana color=#eb922c><STRONG>If your Main or any related window is still open then close it for better security.</STRONG></FONT>        
<BR>
</td>
</tr>

	<%
	}
	%>
<table align=center>
<tr><td colspan=2 nowrap align=center>
	<hr>&nbsp;
	<marquee direction="right" height="125" scrolldelay="300" scrollamount="10" behavior="alternate" loop="0" style="font-family:Verdana;font-size:13px;text-decoration:none;color:#FFFFFF;background-color:transparent;" id="Marquee2"><img src="../PhotoImages/1.jpg">&nbsp;&nbsp;<img src="../PhotoImages/2.jpg">&nbsp;&nbsp;<img src="../PhotoImages/3.jpg">&nbsp;&nbsp;<img src="../PhotoImages/5.jpg">&nbsp;&nbsp;<img src="../PhotoImages/6.jpg">&nbsp;&nbsp;<img src="../PhotoImages/7.jpg">&nbsp;&nbsp;<img src="../PhotoImages/8.jpg">&nbsp;&nbsp;<img src="../PhotoImages/9.jpg"></marquee>
	<hr><br><br><br><br>
	</td></tr>
	<tr><td colspan=3 align=center color=green ><b><a href=../index.jsp> Login</a> again to continue</b><br><br><br><br></td></tr>

  <table border="1" class="table" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small;border-spacing:1px;border-style:outset;border-color:grey" align=center bordercolor="grey">
                    <TR bgcolor=white>
                    <td>				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A style="color: white"  href="http://www.campuslynx.in" target=new  color=white><IMG align=center src="../../Images/CampusLynx.png" style="border-color: white">
					</A><br><FONT size =2 style="FONT-FAMILY: ARIal"><b>&nbsp;Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =1 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution&nbsp;</FONT>
					</td><td>
					<FONT size =1 color=BLACK>&nbsp;Software developed and maintained by </font><br>
					<STRONG>&nbsp;<A HREF="http://www.jilit.co.in" target=new><FONT SIZE="2" COLOR="BLACK">JIL Information Technology Ltd.</FONT></A>&nbsp;</STRONG></FONT>
					</td>
					</tr>
					</table>
</center>

</table>
</body>
</html>	