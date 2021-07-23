<%@ page language="java" import="java.sql.*,jpalumni.*" %>
<%
/*
    ' ********************************************************************************
    ' *													   *
    ' * File Name		:	ApplicationQuery.JSP
    ' * Author			:	Ashok Kumar Singh
    ' * Date (Modified on)	:	1st June 2009
    ' * Modified Version	:	1.3
    ' * Description		:	Displays Application form status by the candidates itself
    ' **********************************************************************************
*/
DBHandler db=new DBHandler();
ResultSet srs=null ; 
String mYear="2009";
%>
<html>
    <head>
        
        <style type="text/css">
            table
            {
                background-repeat: no-repeat
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Jaypee Institute of Information Technology</title>
        <meta http-equiv="Page-Enter" content="revealTrans(Duration=1.0,Transition=1)">
        <link href="../Resources/CSS/style.css" rel="stylesheet" type="text/css" />        
        <script ID=clientEventHandlersJS LANGUAGE=javascript>
          //  window.location.reload(true);
            function txtValue_onchange1()
            {
                var mtxtValue;
                mtxtValue=LoginForm.TXT1.value;
                LoginForm.TXT1.value = mtxtValue.toUpperCase();
            }
            function txtValue_onchange2()
            {
                var mtxtValue;
                mtxtValue=LoginForm.TXT2.value;
                LoginForm.TXT2.value = mtxtValue.toUpperCase();
            }
            function txtValue_onchange3()
            {
                var mtxtValue;
                mtxtValue=LoginForm.TXT3.value;
                LoginForm.TXT3.value = mtxtValue.toUpperCase();
            }
            function checkRadio()
            {
                if(document.LoginForm.QryType[0].checked==true)
                {
                    document.LoginForm.TXT1.disabled=false;
                    document.LoginForm.TXT2.disabled=true;
                    document.LoginForm.TXT2.value='';
                    document.LoginForm.TXT3.disabled=true;
                    document.LoginForm.TXT3.value='';
                }
                if(document.LoginForm.QryType[1].checked==true)
                {
                    document.LoginForm.TXT2.disabled=false;
                    document.LoginForm.TXT1.disabled=true;
                    document.LoginForm.TXT1.value='';
                    document.LoginForm.TXT3.disabled=true;
                    document.LoginForm.TXT3.value='';
                }
                if(document.LoginForm.QryType[2].checked==true)
                {
                    document.LoginForm.TXT3.disabled=false;
                    document.LoginForm.TXT1.disabled=true;
                    document.LoginForm.TXT1.value='';
                    document.LoginForm.TXT2.disabled=true;
                    document.LoginForm.TXT2.value='';
                }
            }
            function bodyLoadFunc()
            {

                
                document.LoginForm.QryType[0].checked=false;
                document.LoginForm.QryType[1].checked=false;
                document.LoginForm.QryType[2].checked=true;
                document.LoginForm.TXT3.value="";
                document.LoginForm.TXT2.value="";
                document.LoginForm.TXT1.value="";
                document.LoginForm.TXT1.disabled=true;
                document.LoginForm.TXT2.disabled=false;
                document.LoginForm.TXT3.disabled=false;
                
            }

            function validate()
            {
                   if(document.LoginForm.TXT3.value=="")
                    if(document.LoginForm.TXT2.value=="")
                       if(document.LoginForm.TXT1.value=="")
                       {
                           alert("Please Enter AIEEE Roll Number ");
                           return false;
                       }
            }
        </script>
        <script type="text/javascript">
            function checkdate(input)
            {
                if(document.LoginForm.QryType[3].checked==true)
                {
                    var validformat=/^\d{2}\/\d{2}\/\d{4}$/ //Basic check for format validity
                    var returnval=false
                    if (!validformat.test(input.value))
                        alert("Invalid Date Format. Please correct and submit again.")
                    else
                    {
                        //Detailed check for valid date ranges
                        var monthfield=input.value.split("/")[1]
                        var dayfield=input.value.split("/")[0]
                        var yearfield=input.value.split("/")[2]
                        var dayobj = new Date(yearfield, monthfield-1, dayfield)
                        if ((dayobj.getMonth()+1!=monthfield)||(dayobj.getdate()!=dayfield)||(dayobj.getFullYear()!=yearfield))
                            alert("Invalid Day, Month, or Year range detected. Please correct and submit again.")
                        else
                            returnval=true
                    }
                    if (returnval==false)
                        input.select()
                    return returnval
                }
                else
                {
                    return true
                }
            }
        </script>
    </head>
    <BODY aLink=#ff00ff  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onload="return bodyLoadFunc();">
        <form method=post action="AfterCounsellingActionJIIT.jsp" name="LoginForm">
            <center><img height="70" src="../Images/header.jpg" alt="header"></center>		
            <br>
<font color=darkblue size=5 face=verdana><B><center>Jaypee Institute of Information Technology University, Noida</B></center></font>
		<br>
		<font color=green size=4 face=verdana><B><center>AIEEE based Counselling/Admission <%=mYear%> Status</B></center></font>
		<br>
            <br>
		<br>

            <table border="1" class="table" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small" align=center>
               <TR bgcolor=white><td colspan=2>&nbsp;<br></td></tr>			 
               <TR bgcolor=white>
                    <td class="tablecell" align=LEFT>
                       &nbsp; <font color=Darkbrown size=2 face=verdana><b>Your AIEEE Roll Number:</B> &nbsp;</font> <Input name="TXT1" id="TXT1" size="13" tabindex="2">
                        <FONT color=red><sub>*</sub></FONT>
                </td></TR>
                <tr bgcolor=white><td Colspan=2 align=center><br><input Type="submit" name=btn1 Value="Submit" onclick="return validate();"><br>&nbsp;</td></tr>
            </table>
            <br><br><br>
        </form>
        <table WIDTH='100%' ALIGN=CENTER>
            <TR>
                <td align=center VALIGN=BOTTOM>
                    <IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp">
                    <FONT style="FONT-FAMILY: cursive" size=4><B>Campus Connect</B></FONT>   
                    <FONT style="FONT-FAMILY: cursive" size=2>... an <B>IRP</B> Solution</FONT>
                    <BR>A product of <STRONG>JIL Information Technology Ltd.</STRONG></BR>
                    <FONT size=2>For your comments or suggestions please send an email at
                    <A tabIndex=23 href="mailto:jiiterp@jiit.ac.in">jiiterp@jiit.ac.in</A></FONT>
        </td></TR></table>
    </BODY>
</HTML>