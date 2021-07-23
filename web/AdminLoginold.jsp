<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 

<%
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", 0); 


/*	 **********************************************************************************************************
	 *													  
	 * File Name:	AdminLogin.JSP		[For Admin Users]						          
	 * Author:	Ashok Kumar Singh 							           *
	 * Date:		30th Jan 07								   *
	 * Version:		1.1										   *	
	 **********************************************************************************************************
		 
*/

 
	String qry="";
	DBHandler db=new DBHandler();
	ResultSet rs=null;
	String mInstCode="JIIT";
	try
	{	
   		session.setAttribute("MemberName", "" );
	   	session.setAttribute("MemberID", "" );
   		session.setAttribute("MemberType", "" );
		session.setAttribute("LogEntryMemberID", "" );
		session.setAttribute("LogEntryMemberType", "" );	
	   	session.setAttribute("MemberCode", "" );
		session.invalidate(); //close and destroy the active session
	}catch(Exception ex){}

 %>
<html>
<head>
<script>
	window.history.forward(1);
</script>
<script language="Javascript">
 function MemberCode_onchange() 
	{
	 var mUserCode;
		mUserCode=LoginForm.MemberCode.value;	 
		LoginForm.MemberCode.value = mUserCode.toUpperCase();
	 }
 
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Jaypee Institute of Information Technology University - ADMIN Page</title>
</head>
<BODY  aLink=#ff00ff bgColor='#d6d2d6'  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<table  bgcolor='#a43f06' align=center valign="middle" cellpadding=0 cellspacing=0 border=0 style="WIDTH: 680px; HEIGHT: 500px" rules="none">
<tr><td colspan=2 style="WIDTH: 742px; HEIGHT: 106px">
				<table  bgcolor='#a43f06' cellpadding=0 cellspacing=0 border=0 background="Images/header.jpg"  style="WIDTH: 742px; HEIGHT: 106px">
					<tr><td>&nbsp;</td></tr>
				</table>
	   </td>
   </tr>   
   <tr>
	   <td style="WIDTH: 738px; HEIGHT: 81px" colspan=2>
		  <table  bgcolor='#a43f06' cellpadding=0 cellspacing=0 border=0 background="Images/panel-below-header.jpg"  style="WIDTH: 742px; HEIGHT: 81px"><tr>
          <td>&nbsp;</td></tr></table>
	   </td>
   </tr>
   <tr>
   <td>
   <table  bgcolor='#a43f06' background='Images/centre-left.jpg'  cellpadding=0 cellspacing=0 border=0 style="WIDTH: 430px; HEIGHT: 286px"><tr>
          <td>&nbsp;</td></tr></table>
   	 </td>
     <td>
        <table  bgcolor='#a43f06' align=cenetr background='Images/centre-right.jpg' cellpadding=0 cellspacing=0 border=0 style="WIDTH: 312px; HEIGHT: 286px"  rules=none>
        <form method=post action="CommonFiles/AdminLoginAction.jsp" name="LoginForm">
	<tr><td align=center>
<br><INPUT id=txtInst style="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: normal; HEIGHT: 19px; TEXT-ALIGN: right; VERTICAL-ALIGN: middle; WIDTH: 99px" size=12 value="Institute" name=txtInst readOnly tabIndex=100 height="22" width="99" align=right>
      <select size="1" name="Inst" tabindex="1" style="VERTICAL-ALIGN: middle; WIDTH: 99px">
      <OPTION Value="JIIT" selected>JIIT</OPTION>
      <OPTION Value="JPBS">JPBS</OPTION>
      </select>   
	<FONT color=red><sub>*</sub></FONT><br>
<INPUT id=txtUType style="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: normal; HEIGHT: 19px; TEXT-ALIGN: right; VERTICAL-ALIGN: middle; WIDTH: 99px" size=12 value="Member Type" name=txtuType readOnly tabIndex=100 height="22" width="99" align=right>
          <select size="1" name="UserType" tabindex="1" style="VERTICAL-ALIGN: middle; WIDTH: 95px">
          <OPTION Value="A" selected>Admin</OPTION>          
       </select>   
	<FONT color=red><sub>*</sub></FONT><br><INPUT Readonly name=txtCode value="Admin UserID" style ="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: normal; HEIGHT: 22px; TEXT-ALIGN: right; 
      VERTICAL-ALIGN: middle; WIDTH: 99px" size=12 lowsrc="" tabIndex=101 width="100" >
	<input name="MemberCode" size="11" tabindex="2" LANGUAGE=javascript onchange="MemberCode_onchange();" style="VERTICAL-ALIGN: middle; WIDTH: 95px"> <FONT color=red><sub>*</sub></FONT>     
      <br><INPUT id=txtPIN style="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: normal; HEIGHT: 19px; TEXT-ALIGN: right; VERTICAL-ALIGN: middle; WIDTH: 99px" size =15 name =txtPin readOnly value="Admin Password" tabIndex=102 width="95">	
      <input type="password" name="Password" size="10" tabindex="3" style="HEIGHT: 22px; VERTICAL-ALIGN: middle; WIDTH: 95px">&nbsp;<font color="red"><sub>*</sub></font>
      <br>
      <INPUT id=BTNSubmit style="FONT-FAMILY: Arial; FONT-SIZE: x-small; HEIGHT: 25px; VERTICAL-ALIGN:    top; WIDTH: 95px" tabIndex=4 type=submit size=30 value=Submit name=BTNSubmit height="25">
      <INPUT id=BTNReset style="FONT-FAMILY: Arial; FONT-SIZE: x-small; HEIGHT: 25px; VERTICAL-ALIGN:    top; WIDTH: 94px" tabIndex=5 type=reset size=30 value=Reset name=BTNReset height="25">      
      <BR><BR>&nbsp;&nbsp;&nbsp;<a href="index.jsp" tabIndex=6>Signin</a> with different User 
		    </td> 
			</tr>
			</form>
		</table>     
     </td>
  </tr>         
 <tr><td align=center colspan=2 style="WIDTH: 740px; HEIGHT: 47px">
<table  bgcolor='#a43f06' cellpadding=0 cellspacing=0 border=0 background="Images/footer.jpg"  style="WIDTH: 740px; HEIGHT: 47px">
	<tr><td></td></tr>
				</table>
	   </td>
   </tr>   

</table> 
	</BODY></HTML>

