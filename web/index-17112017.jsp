<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
// Author:	Design and developed by Mohit Sharma

/*	 **********************************************************************************************************
	 *
	 * File Name:	Index.JSP		[For All Users]
	 * Author:	Design and developed by Mohit Sharma 							           *
	 * Date:		01-05-2015								   *
	 * Version:		2.0										   0
	 **********************************************************************************************************

*/


	String qry="",musertype="";
	DBHandler db=new DBHandler();
	ResultSet rs=null;
	String mInstCode="JIIT";
	try
	{
		session.setAttribute("LogEntryMemberID","");
		session.setAttribute("LogEntryMemberType","");
   		session.setAttribute("MemberName", "" );
	   	session.setAttribute("MemberID", "" );
   		session.setAttribute("MemberType", "" );
	   	session.setAttribute("MemberCode", "" );
		session.invalidate(); //close and destroy the active session
	}
	catch(Exception ex)
	{
	}
%>
<html>
<head>
<script type="text/javascript">
<!--
var image1=new Image()
image1.src="imagesuit/image1.jpg"
var image2=new Image()
image2.src="imagesuit/image2.jpg"
var image3=new Image()
image3.src="imagesuit/image3.jpg"

var image4=new Image()
image4.src="imagesuit/image4.jpg"

var image5=new Image()
image5.src="imagesuit/image5.jpg"
var image6=new Image()
image6.src="imagesuit/image6.jpg"

var image7=new Image()
image7.src="imagesuit/image7.jpg"

var image8=new Image()
image8.src="imagesuit/image8.jpg"


var image9=new Image()
image9.src="imagesuit/image9.jpg"

var image10=new Image()
image10.src="imagesuit/image10.jpg"

var image11=new Image()
image11.src="imagesuit/image11.jpg"

var image12=new Image()
image12.src="imagesuit/image12.jpg"

var image13=new Image()
image13.src="imagesuit/image13.jpg"


var image14=new Image()
image14.src="imagesuit/image14.jpg"

var image15=new Image()
image15.src="imagesuit/image15.jpg"

var image16=new Image()
image16.src="imagesuit/image16.jpg"

var image17=new Image()
image17.src="imagesuit/image17.jpg"

var image18=new Image()
image18.src="imagesuit/image18.jpg"

var image19=new Image()
image19.src="imagesuit/image19.jpg"

var image20=new Image()
image20.src="imagesuit/image20.jpg"

var image21=new Image()
image21.src="imagesuit/image21.jpg"

var image22=new Image()
image22.src="imagesuit/image22.jpg"

var image23=new Image()
image23.src="imagesuit/image23.jpg"

var image24=new Image()
image24.src="imagesuit/image24.jpg"

var image25=new Image()
image25.src="imagesuit/image25.jpg"

var image26=new Image()
image26.src="imagesuit/image26.jpg"

var image27=new Image()
image27.src="imagesuit/image27.jpg"

var image28=new Image()
image28.src="imagesuit/image28.jpg"

var image29=new Image()
image29.src="imagesuit/image29.jpg"

var image30=new Image()
image30.src="imagesuit/image30.jpg"

var image31=new Image()
image31.src="imagesuit/image31.jpg"

var image32=new Image()
image32.src="imagesuit/image32.jpg"

var image33=new Image()
image33.src="imagesuit/image33.jpg"

var image34=new Image()
image34.src="imagesuit/image34.jpg"

var image35=new Image()
image35.src="imagesuit/image35.jpg"


//-->
</script>

<script type = "text/javascript">
function forDate() {
var p = document.getElementById("UserType").value;
//alert(p);
if (p == 'S'||p=='P') {document.getElementById("mydiv1").style.display="block";
document.getElementById("mydiv2").style.display="block"}
else {document.getElementById("mydiv1").style.display="none";
document.getElementById("mydiv2").style.display="none";}
}
</script>

<script>
	window.history.forward(1);
</script>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Jaypee Institute of Information Technology University</title>
<script type="text/javascript">

       function getCurrentDateTime()
			{
				var currentDate;
				var retDateTime;
				currentDate = new Date();
                retDateTime=""+currentDate.getDate()+currentDate.getMonth()+currentDate.getFullYear()+currentDate.getHours()+currentDate.getMinutes()+currentDate.getSeconds();
				return retDateTime;
			}
	$(document).ready(function(){
			$("#Password").keyup(function(){
             $("#MemberCode").val();
              $("#DATE1").val();
              $("#UserType").val();
		if(this.id=="Password" &&  $("#UserType").val()=="S"|| $("#UserType").val()=="P"){
		//	alert($("#MemberCode").val()+"...."+$("#DATE1").val());
		$.post("get_DATEANDENROLLMENT.jsp",{Date:$("#DATE1").val(),member:$("#MemberCode").val(),dt:getCurrentDateTime()},successfunction);
		//$.get("get_DATEANDENROLLMENT.jsp",{member:$("#MemberCode").val(),Date:$("#DATE1").val(),dt:getCurrentDateTime()},successfunction);
            }

			});
		});

        function successfunction(response)
    {//alert(response)
        if(response){
	//var x=response;
  function trim(str) {
    return str.replace(/^\s+|\s+$/g,'');
}
if( document.getElementById("DATE1").value)
     {
var x=response;;
var y = trim(x);
//  Author:	Design and developed by Mohit Sharma
if(y=='Y')
  {
      return (true);
  }
  else
    {
      document.getElementById("MemberCode").value="";
      document.getElementById("DATE1").value="";
      document.getElementById("Password").value="";
      alert(y);
        return (false) ;
    }
  }
 }
}

</script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>


if (navigator.appName=='Netscape' || navigator.appName=='Firefox' || navigator.appName=='Google Chrome' || navigator.appName=='Safari' || navigator.appName=='Opera' || navigator.appName=='Opera' )
	{
	//alert('This website can only be viewed with Internet Explorer');
	//window.history.go(-1);
//	window.history.forward(1);
	}

function UserType_onchange()
{
	var mUserType;
	mUserType=LoginForm.UserType.value;
	if (mUserType == 'S' ||mUserType == 'P')
	{
	   LoginForm.DOB.value  ="DOB";
	}
    else if (mUserType=='E')
	{
	   LoginForm.DOB.value  ="";
	}
	else
	{
	   LoginForm.DOB.value  ="";
	}

    if (mUserType == 'S' ||mUserType == 'P')
	{
	   LoginForm.txtCode.value  ="Enrollment No";
	}
	else if (mUserType=='E')
	{
	   LoginForm.txtCode.value  ="Employee Code";
	}
	else
	{
	   LoginForm.txtCode.value  ="Guest ID";
	}
}

function MemberCode_onchange()
{
	var mUserCode;
	mUserCode=LoginForm.MemberCode.value;
	LoginForm.MemberCode.value = mUserCode.toUpperCase();
}
function openSignupWindow()
{
	var signupWindow;
	//alert('fdsafsfdsf');
	signupWindow=window.open('CommonFiles/StudentSignUp.jsp','_new','height=600,width=800,minimize=no,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes');
	signupWindow.moveTo(125,50)
}
function openFPassWindow()
{
	var signupWindow;
	//alert('fdsafsfdsf');
	signupWindow=window.open('CommonFiles/ForgetPasswordLogin.jsp','_new','height=600,width=800,minimize=no,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes');
	signupWindow.moveTo(125,50)
}
function  Validate()
{
    alert("hello");
    var mUserType=LoginForm.UserType.value;
if(mUserType == 'S'||mUserType == 'P')
            {
                if(document.LoginForm.DATE1.value==''){
                alert("Date Of Birth Should not be blank");
                LoginForm.DATE1.focus();
                return(false);
            }
        }

}
function  valpass()
{
   // alert("aaa");
   var mUserType=LoginForm.UserType.value;
   var date=LoginForm.DATE1.value;
var login=document.LoginForm.txtCode.value;
if(mUserType == 'S'||mUserType == 'P')
          {
               LoginForm.DATE1.focus();
               LoginForm.Password.value='';
                return(false);
          }
}

function  valEnroll()
{
   var mUserType=LoginForm.UserType.value;
var login=document.LoginForm.txtCode.value;
if(mUserType == 'S'||mUserType == 'P')
            if(document.LoginForm.MemberCode.value=='')
            {

                alert( login+" Should not be blank");
                LoginForm.MemberCode.focus();
                return(false);
            }
}

function  Validation()
{var mUserType=LoginForm.UserType.value;
var login=document.LoginForm.txtCode.value;

if(document.LoginForm.MemberCode.value=='')
            {

                alert( login+" Should not be blank");
                LoginForm.MemberCode.focus();
                return(false);
            }

if(mUserType == 'S'||mUserType == 'P')
            {
                if(document.LoginForm.DATE1.value==''){
                alert("Date Of Birth Should not be blank");
                LoginForm.DATE1.focus();
                return(false);
            }
        }

if(document.LoginForm.Password.value=='')
            {
                alert("Password Should not be blank");
                LoginForm.Password.focus();
                return(false);
            }
}

</SCRIPT>
<!--
<script language="Javascript1.1">
function detect()
{
	if(screen.width>800||screen.height>600)
	{
		 alert("This web page is best viewed with a screen resolution of 800 * 600. Your current resolution is "+screen.width+" by "+screen.height+". If possible please change your monitor resolution as 800 * 600 ")
	}
}
 detect();
</script>
-->


</head>
 <style type="text/css">
        .backform

        h2
        {
            font-size:10pt;
        }
        h4
        {
            font-size:10pt;
        }
        br
        {
            height:20;
        }
        .HEAD
        {
            font-size:12pt;
        }
        .HEADP
        {
            font-size:20pt;
        }

        .bk3
        {
            background-image: url(images2/Webkiosk---final_03.jpg) no-repeat;
            background-attachment:fixed;
        }
    </STYLE>

<body  id="top" bgcolor="white"  >
    <FORM NAME="LoginForm" method=post action="CommonFiles/UserActionn.jsp">
	<input type="hidden" name="x" id="x">
       <BR><BR><BR> <table align="center" id="Table_01" width="728" height="572" border="" rules="none" frame="box" style="border-color:gray;" cellpadding="0" cellspacing="0">
            <tr>
                <td background="images2/Webkiosk---final_01.jpg" width="248" height="0" align="center" valign="top">
                </td>
                <td background="images2/Webkiosk---final_02.jpg" width="480" height="0" align="left" valign="top">
                </td>
            </tr>
            <tr>
                <td background="images2/Webkiosk---final_03.jpg" width="252" height="152" align="left" valign="top">
                <table width="100%" height="85%">
                <td align="left" valign="top" width="11%" height="22.2%"></td>
                <td align="left" valign="top" width="60%" height="22.2%"></td>
                <td align="left" valign="top" width="29%" height="22.2%">
                <P  align="left" CLASS="HEAD"><B></B></P>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top" width="11.5%" height="88.5%"></td>
                <td align="left" valign="top" width="44%" height="62%">
                <img src="images2/logo.png" valign="center" width="61%" height="85%"></td>
                <td align="left"  valign="top" width="34.5%" height="22.2%"></td>
            </tr>
        </table>
        </td>


		<td background="images2/Webkiosk---final_04.jpg" width="480" height="152" align="left" valign="top">
            <TABLE cellpadding="0">

                    <BR><TD cellpadding="0" nowrap>
                        <font face="cambria"   CLASS="HEAD"><B><h3 >

						<FONT SIZE="6.5" COLOR="">J</FONT><U>AYPEE INSTITUTE OF INFORMATION TECHNOLOGY </U></h2></b></font>
                    </TD>

				<tr>
                    <TD cellpadding>
                      <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Declared Deemed To be University Under Section 3 of UGC  Act &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
                    </TD>
              </tr>

            </TABLE>
        </td>
        <tr>
          <div>  <td background='images2/Webkiosk---final_05i.jpg' width="248" height="347" align="left" valign="top"   border='0'>
                <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" align="left">



                    <tr >
					<br>
                        <td align="left" valign="top" width="11.4%" height="70%">
                        </td>
                        <td  align="left" valign="top" class="backform" width="88.6%" height="70%" >
  <br>
  <center><font face="COMIC SANS MS" color='blue' size=4 ><U><br><br>LOGIN</U></font></center><br>

                           <b> <INPUT background='#D5D6D8' id=txtInst style="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; background-color:d5d6d8;FONT-SIZE: x-small; FONT-STYLE: bold; HEIGHT: 19px; TEXT-ALIGN: right; VERTICAL-ALIGN: middle; WIDTH: 79px" size='4'  value="Institute" background='#D5D6D8' name=txtInst readOnly tabIndex=100 height="22" width="99" align='right'></b>




      <select size="1" name="InstCode" tabindex="1" style="VERTICAL-ALIGN: middle; WIDTH: 85px">
      <OPTION Value="JIIT" selected>JIIT</OPTION>
      <OPTION Value="JPBS">JPBS</OPTION>
	   <OPTION Value="J128">J128</OPTION>
      </select>
	<FONT color=red><sub>*</sub></FONT><br>
	<b><INPUT id=txtUType style="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; background-color:#D5D6D8;BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: normal; HEIGHT: 19px; TEXT-ALIGN: right; VERTICAL-ALIGN: middle; WIDTH: 79px"
      size=12 value="Member Type" name=txtuType readOnly tabIndex=100 height="22" width="81" align=right></b>
      <select size="1" name="UserType" id="UserType" tabindex="1" language="Javascript" onchange="forDate();UserType_onchange();"  onkeypress="return UserType_onchange();" style="VERTICAL-ALIGN: middle; WIDTH: 85px">
      <OPTION Value="S" >Student</OPTION>
      <OPTION Value="E">Employee</OPTION>
      <OPTION Value="G">Guest </OPTION>
      <OPTION Value="P">Parents</OPTION>
      </select>
	<FONT color=red><sub>*</sub></FONT><br>


    <b><INPUT Readonly name=txtCode value="Enrollment No" style ="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: normal; HEIGHT: 22px; TEXT-ALIGN: right;background-color:#D5D6D8;
      VERTICAL-ALIGN: middle; WIDTH: 79px" size=12 lowsrc="" tabIndex=101 width="79" ></b>
	<b>


	<input   name="MemberCode" id="MemberCode" size="11" tabindex="2" LANGUAGE=javascript onchange="MemberCode_onchange();" style="VERTICAL-ALIGN: middle; WIDTH: 85px"></b> <FONT color=red><sub>*</sub></FONT>
		<br><div id = "mydiv1"><b>

		<INPUT Readonly name="DOB" value="DOB" style ="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: normal; HEIGHT: 22px; TEXT-ALIGN: right;background-color:d5d6d8;
      VERTICAL-ALIGN: middle; WIDTH: 79px" size=10 lowsrc="" tabIndex=101 width="79" ></b>


		  <INPUT TYPE="text"  style=" WIDTH: 85px" NAME=DATE1 ID=DATE1 size="8"  tabindex=2 VALUE='' onclick="return valEnroll();" onfocus="return valpass();"
	maxlength=10><a href="javascript:NewCal('DATE1','ddmmyyyy')"  onclick="return valEnroll();" onmouseup="return valpass();">


	<img src="Images/cal.gif" width="13" height="13" border="0" alt="Pick a Date"></a>
<FONT color=red><sub>*</sub></FONT></div>
&nbsp;&nbsp;&nbsp;<b><INPUT id=txtPIN style="BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: normal;background-color:d5d6d8; HEIGHT: 19px; TEXT-ALIGN: right; VERTICAL-ALIGN: middle; WIDTH: 67px" size= "24" name =txtPin readOnly value="Password/Pin" tabIndex=103 width="79"></b>
<input type="password" name="Password"  id="Password" size="12" tabindex="2" style="HEIGHT: 22px; VERTICAL-ALIGN: middle; WIDTH: 85px"  onkeypress=" return Validate();"  ><font color="red">&nbsp;<sub>*</sub></font>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id=BTNSubmit style="FONT-FAMILY: Arial; FONT-SIZE: x-small; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 70px" tabIndex=5 type=submit size=20 value=Submit  name=BTNSubmit id="BTNSubmit" height="25"  onclick=" return Validation();"  ONsubmit="return valpass();"  >
<INPUT id=BTNReset style="FONT-FAMILY: Arial; FONT-SIZE: x-small; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 70px" tabIndex=6 type=reset size=20 value=Reset name=BTNReset height="25">
       <BR></div>

		 <br>
         <div id="mydiv2"><font color="Green" size="2">Valid Date Format : (DD-MM-YYYY)</font></div><input type="checkbox" checked  id="chkShowPassword" />
                <FONT SIZE="2" COLOR="">Show/Hide?</FONT>&nbsp;<A style="cursor:hand" Title="Forgot Password! Click here to recover your password..." Target=_New OnClick="return openFPassWindow();"><FONT size=3 color=blue name="arial"><u>Forgot Password?</u></FONT></A>
				<script type="text/javascript">
    $(function () {
        $("#chkShowPassword").bind("click", function () {
            var MemberCode = $("#MemberCode");
            if ($(this).is(":checked")) {
				MemberCode.val(MemberCode.next().val());
                MemberCode.next().remove();
                MemberCode.show()

            } else {

				 MemberCode.after('<input  style=" WIDTH: 85px" type="password" onchange = "PasswordChanged(this);" id = "txt_' + MemberCode.attr("id") + '" type = "text" value = "' + MemberCode.val() + '" />');
                MemberCode.hide();
                ;
            }
        });
    });
    function PasswordChanged(txt) {
        $(txt).prev().val($(txt).val());
    }
</script>



	</tr></TD>
			</TR>
   </TABLE>






			<td background="images2/Webkiosk---final_06.jpg" width="480" height="347" align="left" valign="top">
			<table width="100%" height="100%">

	<tr>

                        <td align="left" valign="top"  width="95.6%" height="100%"> <center>
                                <font face="comic sans"  CLASS="HEADP"><B><var> Photo Gallery </var> </b></font><br>
							<img src="image1.jpg" name="slide" width="87%" height="82%" />

<script>
<!--
//variable that will increment through the images
var step=1
function slideit(){
//if browser does not support the image object, exit.
if (!document.images)
return
document.images.slide.src=eval("image"+step+".src")
if (step<35)
step++
else
step=1
//call function "slideit()" every 2.5 seconds
setTimeout("slideit()",2500)
}
slideit()
//-->
</script><br><br></td>
</tr>

</table>
</td>


  <tr><td align='center' colspan=2 valign="center" WIDTH ='728'; HEIGHT= '4'>
	<table bgcolor='black' cellpadding=0 cellspacing=0 border=0 background="Images/footer.jpg"  style="WIDTH: 726; HEIGHT: 47">
<tr><td align=right valign=middle  >
	<A Target=_New href="AdminLogin.jsp"><FONT size=3 color=blue name="arial"><B>Admin Login</B></FONT></A>
			<!-- <INPUT TYPE="image" SRC="Images/arrow_cool.gif">
			 <a href="JPAlumni/index.jsp"><font face="Comic sans ms" color=white size=3>For JPAlumni Users
			 </a></font> -->&nbsp;&nbsp;</td></tr>






        </table>
		</td>
		</tr>



<!--
          <tr> <td><embed  src="PassportApplicationForm_Main_English_V1.0.pdf" width="100%" height="100%">sdsd
                             </embed>
                        </td>
                    </tr>-->


</table>


</form>
</body>
</HTML>












