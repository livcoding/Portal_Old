<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";


%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Change Password ] </TITLE>


<script language="JavaScript" type ="text/javascript" src="js/jquery.min.js"></script>

  

<script language="javascript"> 
function  Validation()
{


if(document.ChangePassword.OldPassword.value=='')
            {
                alert('OldPassword Should not be left blank');
				ChangePassword.OldPassword.value="";
				                ChangePassword.OldPassword.focus();
                return(false);
            }


if(document.ChangePassword.NewPassword.value=='')
            {
                alert('NewPassword Should not be left blank');

				ChangePassword.NewPassword.value="";
				                ChangePassword.NewPassword.focus();
                return(false);
            }


if(document.ChangePassword.RetypePassword.value=='')
            {
                alert('RetypePassword Should not be left blank');

				                ChangePassword.RetypePassword.value="";
								                ChangePassword.RetypePassword.focus();
                return(false);
            }


if(document.ChangePassword.OldPassword.value==document.ChangePassword.NewPassword.value)
	{
		  alert('New Password cannot be same as Old Password');
         ChangePassword.OldPassword.value="";
		 ChangePassword.NewPassword.value="";
		  ChangePassword.RetypePassword.value="";
		  ChangePassword.OldPassword.focus();
          return(false);
	}


}



function isStrongPassword(pwd, MinPWD) 
{
	//alert(pwd+"mjjhjh");
   var control =  document.getElementById(pwd);
   //document.ChangePassword.NewPassword;
   var myString= control.value; 
//	alert(myString);
var mflag=0;

   var Stringlen = myString.length;
   var ValidateDigits = /[^0-9]/g;
   var ValidateSpChar = /[a-zA-Z0-9]/g;
   var ValidateChar = /[^a-zA-Z]/g;

   var digitString = myString.replace(ValidateDigits , "");
   var specialString = myString.replace(ValidateSpChar, "");
   var charString = myString.replace(ValidateChar, "");

	//----------------------------------------------------------------------


//alert(Stringlen+"mFlag");

	
   
   if(Stringlen < MinPWD)
   {
   alert("Passwords must be at least 8 characters");
   
   control.value="";
   control.focus();
   mflag=1;
	return false;
   }
   if(specialString < 1)
   {
   alert("Passwords must include at least 1 special (#,@,&,$ etc) characters");
   control.value="";
   control.focus();
      mflag=1;
   return false;
   }
   if(digitString < 1)
   {
   alert("Passwords must include at least 1 numeric characters");
   control.value="";
      mflag=1;
   control.focus();
   return false;
   }
  return false;

/*
if(mflag==0)
	{

if(pwd=="NewPassword")
	{
		
		if(Stringlen ==0)
	{
	  $("label.label2").hide();
	  control.focus();
	}

   
   if(Stringlen < MinPWD)
	{
		//$("label").append("<font size=2 face=arial color=red>Poor password ! </font>"); 
		$("label.label2").html("<font size=2 face=arial color=red>Poor password ! </font>"); 
     	   control.focus();
		//   alert(Stringlen);
	}
		if(Stringlen == MinPWD)
	{
		$("label.label2").html("<font size=2 face=arial color=green> Fair password ! </font>"); 
 	   control.focus();
	}	
   if(Stringlen >= MinPWD  &&  Stringlen <= 12 )
	{
		$("label2").html("<font size=2 face=arial color=green>Good password !</font>"); 
       control.focus();
	}

	 if(Stringlen > 13 )
	{
		//$("label").append("<font size=2 face=arial color=red>Poor password ! </font>"); 
		$("label.label2").html("<font size=2 face=arial color=green>Strong password ! </font>"); 
     	   control.focus();
		//   alert(Stringlen);
	}
	//-----------------------------------------------------------------------

	}
	else
	{
		//alert("dfsf"+$("label1").html("<font size=2 face=arial color=red>Poor password ! </font>"));
			
		if(Stringlen ==0)
	{
	  $("label.label1").hide();
	  control.focus();
	}

   
   if(Stringlen < MinPWD)
	{
		//$("label").append("<font size=2 face=arial color=red>Poor password ! </font>"); 
		$("label.label1").html("<font size=2 face=arial color=red>Poor password ! </font>"); 
     	   control.focus();
		//   alert(Stringlen);
	}
		if(Stringlen == MinPWD)
	{
		$("label.label1").html("<font size=2 face=arial color=green> Fair password ! </font>"); 
 	   control.focus();
	}	
   if(Stringlen >= MinPWD  &&  Stringlen <= 12 )
	{
		$("label.label1").html("<font size=2 face=arial color=green>Good password !</font>"); 
       control.focus();
	}

	 if(Stringlen > 13 )
	{
		//$("label").append("<font size=2 face=arial color=red>Poor password ! </font>"); 
		$("label.label1").html("<font size=2 face=arial color=green>Strong password ! </font>"); 
     	   control.focus();
		//   alert(Stringlen);
	}

	}

	}*/

} 
</script> 



</HEAD>
<%

String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="";
DBHandler db=new DBHandler();
ResultSet rs=null;
String mWebEmail="Deepak.gupta@jiit.ac.in";
int mMaxPWD=20;
int mMinPWD=5;

try{


if (session.getAttribute("MinPasswordLength")==null)
{
	mMinPWD=5;
}
else
{
	mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());
 

}


if (session.getAttribute("MaxPasswordLength")==null)
{
	mMaxPWD=20;
}
else
{
	mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());
}


}
catch(Exception e)
{
mMaxPWD=20;
mMinPWD=4;

}

if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
%>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;

//out.print(enc.decode("LQU+lpwFNmeqfJfGf36rJw=="));

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('46','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
%>

<form name="ChangePassword" ID="ChangePassword" action="FirstTimeChangePasswordAction.jsp" method="post">

<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD  align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana">Change Login Password</font>
</td>
</tr>
<tr>
<td align=center >
<font color=Green face=verdana size=4>
Welcome : <%=session.getAttribute("MemberName")%>
</td>
</tr>
</table>
<table align=center rules=groups border=1  style="WIDTH: 550px;">
<tr><td colspan=3><FONT size=2 color=red face = arial><br>
<b>
<P style="BACKGROUND: #fce9c5; LINE-HEIGHT: 140%; MARGIN-RIGHT: 11.25pt"><B><SPAN 
style="FONT-SIZE: 5pt; COLOR: red; FONT-FAMILY: 'Trebuchet MS'"><FONT 
size=4>&nbsp;Password Should:</FONT></SPAN></B></P>
<UL style="MARGIN-TOP: 0in" type=circle>
  <LI class=MsoNormal 
  style="BACKGROUND: #fce9c5; MARGIN: 0in 11.5pt 0pt 0in; COLOR: #222222; LINE-HEIGHT: 140%; mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo3; tab-stops: list .5in"><B><SPAN 
  style="FONT-FAMILY: Verdana; mso-bidi-font-size: 11.0pt"><FONT color=#954b5c>Minimum length should be of <%=mMinPWD%> characters and maximum of <%=mMaxPWD%>
 <o:p></O:P></FONT></SPAN></B>
  <LI class=MsoNormal 
  style="BACKGROUND: #fce9c5; MARGIN: 0in 11.5pt 0pt 0in; COLOR: #222222; LINE-HEIGHT: 140%; mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo3; tab-stops: list .5in"><B><SPAN 
  style="FONT-FAMILY: Verdana; mso-bidi-font-size: 11.0pt"><FONT color=#954b5c>Password is case sensitive

  <o:p></O:P></FONT></SPAN></B>
  <LI class=MsoNormal 
  style="BACKGROUND: #fce9c5; MARGIN: 0in 11.5pt 0pt 0in; COLOR: #222222; LINE-HEIGHT: 140%; mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo3; tab-stops: list .5in"><B><SPAN 
  style="FONT-FAMILY: Verdana; mso-bidi-font-size: 11.0pt"><FONT color=#954b5c>Must contain at least one numeric, one alphabet and one special character 

  <o:p></O:P></FONT></SPAN></B>

 <LI class=MsoNormal 
  style="BACKGROUND: #fce9c5; MARGIN: 0in 11.5pt 0pt 0in; COLOR: #222222; LINE-HEIGHT: 140%; mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo3; tab-stops: list .5in"><B><SPAN 
  style="FONT-FAMILY: Verdana; mso-bidi-font-size: 11.0pt"><FONT color=#954b5c>Allowed Special characters like @,#,_,-,<,>,?,/,|,},{,*,&,^,%,$,,! etc.
  <o:p></O:P></FONT></SPAN></B>
	<br>
	</FONT>
	</td></tr>
</table>
<table align=center rules=groups border=2 style="WIDTH: 550px; HEIGHT: 100px">

<tr>
	<td><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=black>Old Password</FONT></STRONG></FONT></td>
	<td><INPUT ID="OldPassword" Name="OldPassword" Type="password" style="WIDTH: 160px; HEIGHT: 22px" maxLength=<%=mMaxPWD%>><FONT color=red>*</FONT></td>
</tr>
<tr>
	<td><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=black>New Password</FONT></STRONG></FONT></td>
	<td><INPUT ID="NewPassword" Name="NewPassword" Type="password" style="WIDTH: 160px; HEIGHT: 22px" maxLength=<%=mMaxPWD%>  onchange='return isStrongPassword("NewPassword",<%=mMinPWD%>);'   ><FONT color=red>* </FONT>

	<!-- <label class="label2"  name="label2" id="label2">
	</label> -->
	</td>
</tr>

<tr>
	<td><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=black>Retype Password</FONT></STRONG></FONT></td>
	<td><INPUT ID="RetypePassword" Name="RetypePassword" Type="password" style="WIDTH: 160px; HEIGHT: 22px" maxLength=<%=mMaxPWD%>  onchange='return isStrongPassword("RetypePassword",<%=mMinPWD%>);'><FONT color=red>* </FONT>
	<!-- <label class="label1" name="label1" id="label1">
	</label> -->
	</td>
</tr>	
<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
<tr>
	<td colspan=2 align="center"><INPUT Type="submit" Value="Save" onclick=" return Validation();">
	<INPUT Type="reset" Value="Reset"></td>    
</tr>
<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
<!--<tr>
	<td>&nbsp;<STRONG><FONT color=blue face=Arial size=2><B>Forgot Password?</B></FONT></STRONG></td>
	<td align=right><FONT face=Arial color=teal size=2><FONT color=red>*</FONT>Mandatory Information!</FONT></td>  
	



</tr>-->
</table>
<div align="center">
<h6><font size=2 face=arial>Note: Keep changing your password for better security</font></h6>
<b><hr>
</div>
<%


 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
   {
   %>
<br>	<font color=red>
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }
  //-----------------------------

}
else
{
out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp'>Login</a> to continue</font> <br>");
}
%>

<table align=center><tr><td align=left>
<IMG  src="../../Images/CampusLynx.png">
</td>
<td >
<FONT size =4 style="FONT-FAMILY: ARIal"><b>Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 	
</td>
</tr>
</table>



</BODY>
</HTML>