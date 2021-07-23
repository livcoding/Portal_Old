	<%@	page language="java" import="java.sql.*,jpalumni.*"	%>
	<%
	/*
	' ********************************************************************************
	' *													   *
	' *	File Name:	ApplicationQuery.JSP
	' *	Author:		Ashok Kumar	Singh
	' *	Date (Modified on):	10 Apr 2009
	' *	Version:	1.1
	' *	Description:	Displays Application form status by	the	candidates itself
	' **********************************************************************************
	*/

	String PUBLIC_YEAR="2012";
	%>
	<html>
	<head>
	<script	language="JavaScript" type ="text/javascript">
	if(window.history.forward(1) !=	null)
	window.history.forward(1);
	</script>
	<style type="text/css">
	table
	{
	background-repeat: no-repeat
	}
	</style>
	<meta http-equiv="Content-Type"	content="text/html;	charset=windows-1252">
	<title>Jaypee Institute	of Information Technology</title>
	<meta http-equiv="Page-Enter" content="revealTrans(Duration=1.0,Transition=1)">
	<link href="../Resources/CSS/style.css"	rel="stylesheet" type="text/css" />
	<SCRIPT	ID=clientEventHandlersJS LANGUAGE=javascript>
	/*function txtValue_onchange1()
	{
	var	mtxtValue;
	mtxtValue=LoginForm.TXT1.value;
	LoginForm.TXT1.value = mtxtValue.toUpperCase();
	}
	function txtValue_onchange2()
	{
	var	mtxtValue;
	mtxtValue=LoginForm.TXT2.value;
	LoginForm.TXT2.value = mtxtValue.toUpperCase();
	}
	
	
	
	
	
	
	
	
	*/

	function checkRadio()
	{
		


	if(document.LoginForm.QryType[0].checked==true)
	{
	//document.LoginForm.TXT1.disabled=false;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=false;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=true;
	//document.LoginForm.TXT2.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT5.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT10.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}
	if(document.LoginForm.QryType[1].checked==true)
	{	
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=false;
	document.LoginForm.TXT3.disabled=false;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=true;
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT5.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT10.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}

	
	if(document.LoginForm.QryType[2].checked==true)
	{
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT5.disabled=false;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=true;
	//document.LoginForm.TXT2.value='';
	document.LoginForm.TXT3.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT5.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT10.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}
	if(document.LoginForm.QryType[3].checked==true)
	{
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT6.disabled=false;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=true;
	//document.LoginForm.TXT2.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT5.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT10.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}
	if(document.LoginForm.QryType[4].checked==true)
	{
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=false;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=true;
	//document.LoginForm.TXT2.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT10.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}
	
	
	if(document.LoginForm.QryType[5].checked==true)
	{
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=false;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=true;

	//document.LoginForm.TXT2.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT5.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT10.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}
		if(document.LoginForm.QryType[6].checked==true)
	{
	
	
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT9.disabled=false;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=true;

	//document.LoginForm.TXT2.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT5.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT10.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}


	if(document.LoginForm.QryType[7].checked==true)
	{
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT10.disabled=false;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=true;

	//document.LoginForm.TXT2.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT5.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT10.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}
	if(document.LoginForm.QryType[8].checked==true)
	{
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT11.disabled=false;
	document.LoginForm.TXT12.disabled=true;

	//document.LoginForm.TXT2.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT5.value='';
	document.LoginForm.TXT10.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}

	if(document.LoginForm.QryType[9].checked==true)
	{
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=false;

	//document.LoginForm.TXT2.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT5.value='';
	document.LoginForm.TXT11.value='';
	document.LoginForm.TXT12.value='';

	}

/*	if(document.LoginForm.QryType[10].checked==true)
	{
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT11.disabled=false;
	document.LoginForm.TXT12.disabled=true;

	//document.LoginForm.TXT2.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT5.value='';
	
	document.LoginForm.TXT12.value='';

	}

		if(document.LoginForm.QryType[11].checked==true)
	{
	//document.LoginForm.TXT1.disabled=true;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=false;

	//document.LoginForm.TXT2.value='';
	//document.LoginForm.TXT1.value='';
	document.LoginForm.TXT4.value='';
	document.LoginForm.TXT3.value='';
	document.LoginForm.TXT6.value='';
	document.LoginForm.TXT7.value='';
	document.LoginForm.TXT8.value='';
	document.LoginForm.TXT9.value='';
	document.LoginForm.TXT5.value='';
	
	document.LoginForm.TXT11.value='';

	}*/

	}


	function bodyLoadFunc()
	{
	//document.LoginForm.TXT1.disabled=false;
	//document.LoginForm.TXT2.disabled=true;
	document.LoginForm.TXT3.disabled=true;
	document.LoginForm.TXT4.disabled=true;
	document.LoginForm.TXT5.disabled=true;
	document.LoginForm.TXT6.disabled=true;
	document.LoginForm.TXT7.disabled=true;
	document.LoginForm.TXT8.disabled=true;
	document.LoginForm.TXT9.disabled=true;
	document.LoginForm.TXT10.disabled=true;
	document.LoginForm.TXT11.disabled=true;
	document.LoginForm.TXT12.disabled=true;
	//document.LoginForm.TXT2.focus;
	}

	</script>


	<script	type="text/javascript">
	/**--------------------------
	//*	Validate Date Field	script-	By JavaScriptKit.com
	//*	For	this script	and	100s more, visit http://www.javascriptkit.com
	//*	This notice	must stay intact for usage
	---------------------------**/
/*
	function checkdate(input)
	{
	if(document.LoginForm.QryType[11].checked==true)
	{
	var	validformat=/^\d{2}\/\d{2}\/\d{4}$/	//Basic	check for format validity
	var	returnval=false
	if (!validformat.test(input.value))
	alert("Invalid Date	Format.	Please correct and submit again.")
	else
	{
	//Detailed check for valid date	ranges
	var	monthfield=input.value.split("/")[1]
	var	dayfield=input.value.split("/")[0]
	var	yearfield=input.value.split("/")[2]
	var	dayobj = new Date(yearfield, monthfield-1, dayfield)
	if ((dayobj.getMonth()+1!=monthfield)||(dayobj.getDate()!=dayfield)||(dayobj.getFullYear()!=yearfield))
	alert("Invalid Day,	Month, or Year range detected. Please correct and submit again.")
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
	}*/
	</script>

	</head>
	<BODY id="top">
	<form method=post action="AppicationQueryActionJIIT.jsp" name="LoginForm" onSubmit="return checkdate(TXT3);">
	
	<div id="header">
<!-- 	<center><img height="70" src="../Images/header.jpg"	alt="header"></center> -->
	<table border=0	align=center  >
	<tr><td	 align=center>
	<h1> Application Status for JIIT,JUIT & JUET Program-2012</h1>
	<!-- <h1>Find Application status (Based on the method adopted for applying)
	</h1> --></td></tr>
	</table>
	<br>
 <!-- <h1>B.P.S MAHILA VISHWAVIDYALAYA</h1> -->
	</div>
	<table    rules="none" cellpadding="0"  cellspacing="0" border=0	align=center>
<Tr>
	<td  class="tablecell"><font size=4>
	<U>Find Application status (Based on the method adopted for applying)</u>
	
	</td>
	</tr>
	</table>
	<br>
	<!-- <table  WIDTH='70%'  rules="none" cellpadding="0" bordercolor="#D98242" cellspacing="0" 	align=center>
	
<tr>

<td align=LEFT colspan=4><h2>&nbsp;&nbsp; <b>AIEEE </b> </h2></td></tr>

	 <TR	 ><td  class="tablecell" valign="top"	align=left><INPUT name="QryType" TYPE="radio" checked tabindex="1" VALUE="A" onClick="return checkRadio();">Application Form Number
	<br>
	<font size=2>(For Purchased Form/On Line Application Form)</font>
	</td>
	<td align="left" class="tablecell" colspan=3>
	&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
	<Input	name="TXT1"	id="TXT1" size="13"	tabindex="2" LANGUAGE=javascript onchange="txtValue_onchange1();" style="VERTICAL-ALIGN: middle; WIDTH: 120px; HEIGHT: 22px">	
	<FONT color=red><sub>*</sub></FONT></TD></TR>
	<TR	><td  class="tablecell" colspan=4	align=left> &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;OR	</TD></TR>
	<TR	><td  class="tablecell"	align=left><INPUT name="QryType" TYPE="radio" tabindex="3"	VALUE="R" onClick="return	checkRadio();">	AIEEE Roll Number
	</td>
	<td class="tablecell" align="left" colspan=3 >
		&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;   &nbsp;<input name="TXT2" maxlength="8" id="TXT2" tabindex="4"	LANGUAGE=javascript	onchange="txtValue_onchange2();" style="VERTICAL-ALIGN:	middle;	WIDTH: 120px; HEIGHT:22px">	<FONT color=red><sub>*</sub></FONT></td></tr>
	</TABLE>
 -->



 <table  WIDTH='70%' bordercolor="#D98242"   rules="none" cellpadding="0" cellspacing="0" 	align=center>
		<Br><tr>
		<td  align=LEFT colspan=4><h2>&nbsp;&nbsp;<b>BIO/PHARMACY (JIIT,Noida Application Only)
</b></font>
	</td></tr>
	<TR ><td 	class="tablecell" valign="top"	align=left>
	<INPUT	name="QryType" TYPE="radio"	tabindex="5"  VALUE="P"	onClick="return	checkRadio();">Application Number <br><font size=2>(Purchased Application form for Non AIEEE Category)</font> 
	</td>
	<td align="left" class="tablecell" colspan=3>
	<input name="TXT4" maxlength="15" id="TXT4" tabindex="6" LANGUAGE=javascript style="VERTICAL-ALIGN: middle; WIDTH: 120px; HEIGHT:22px"><FONT color=red><sub>*</sub></FONT></td></tr>
	

	<TR><td	 class="tablecell" colspan=4	align=left>&nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;OR </TD></TR>

	<TR><td	class="tablecell" align=LEFT><INPUT	name="QryType" TYPE="radio"	tabindex="7"  VALUE="D"	onClick="return	checkRadio();">10+2	Roll Number	 </font>	<br> <font size=2>(For Downloaded Application form for Non AIEEE Category) 
	</font></td>
	<td class="tablecell" align="left" colspan=3><input name="TXT3" maxlength="15" id="TXT3" tabindex="8" LANGUAGE=javascript style="VERTICAL-ALIGN: middle; WIDTH:	120px; HEIGHT:22px"><FONT color=red><sub>*</sub></FONT> </td></tr>
</TABLE>



<table WIDTH='70%'   bordercolor="#D98242"   rules="none" cellpadding="0" cellspacing="0" 	align=center>
	<Br><Tr>
	<td align=LEFT colspan=4><h2>&nbsp;&nbsp;<b>LATERAL</b></font> </td></tr>
	<TR	><td class="tablecell" valign="top"	align=left><INPUT name="QryType" TYPE="radio" tabindex="9"	VALUE="L1" onClick="return	checkRadio();">Application Number <br><font size=2>(Purchased Application form for Lateral Entry) <font>
	</td>
	<td align="left" class="tablecell" colspan=3 > 
	&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
		&nbsp;&nbsp; &nbsp; &nbsp;   &nbsp;<input name="TXT5"	maxlength="15" id="TXT5" tabindex="10" LANGUAGE=javascript style="VERTICAL-ALIGN: middle; WIDTH: 120px; HEIGHT:22px"><FONT color=red><sub>*</sub></FONT></td></tr>

	<TR	><td class="tablecell" colspan=4	align=left>&nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;OR	</TD></TR>
	<TR	><td class="tablecell" align=LEFT><INPUT name="QryType" TYPE="radio" tabindex="11"	 VALUE="L2"	onClick="return	checkRadio();">10+2	Roll Number	<br><font Size=2>(For Downloaded  Application form for Lateral Entry) </font>
	</td>
	<td    class="tablecell" align="left"   colspan=3>
		  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
		&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;<input name="TXT6" maxlength="15"	id="TXT6" tabindex="12"	LANGUAGE=javascript	style="VERTICAL-ALIGN: middle; WIDTH: 120px; HEIGHT:22px"><FONT	color=red><sub>*</sub></FONT> </td></tr>
</TABLE>




<table WIDTH='70%'   bordercolor="#D98242"   rules="none"   cellpadding="0" cellspacing="0" 	align=center>
		<Br><tr>
	<td  align=LEFT colspan=4 ><h2>&nbsp;&nbsp;<b>NRI (JIIT,Noida Application Only)
</b></font> </td></tr>
	<TR><td	 valign="top"	 class="tablecell"  align=left><INPUT name="QryType" TYPE="radio" tabindex="12"	VALUE="N1" onClick="return checkRadio();">Application Number <br><font size=2>(Purchased Application Form for NRI/NRI Sponsored category) </font>
	</td>
	<td   align="left" class="tablecell" colspan=3 > 
<input name="TXT7" maxlength="15" id="TXT7" tabindex="14" LANGUAGE=javascript style="VERTICAL-ALIGN: middle; WIDTH: 120px;	HEIGHT:22px"><FONT color=red><sub>*</sub></FONT></td></tr>

	<TR ><td	class="tablecell" colspan=4	align=left>&nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;OR </TD></TR>

	<TR><td	class="tablecell" align=LEFT><INPUT	name="QryType" TYPE="radio"	tabindex="15"  VALUE="N2" onClick="return checkRadio();">10+2	Roll Number	<br><font size=2>(For Downloaded Application Form for NRI/NRI Sponsored category) </font>
	</td>
	<td   class="tablecell" align="left" colspan=3 >
<input name="TXT8" maxlength="15" id="TXT8" tabindex="16" LANGUAGE=javascript style="VERTICAL-ALIGN: middle; WIDTH: 120px; HEIGHT:22px"><FONT color=red><sub>*</sub></FONT> </td></tr>
</table> 
 



<table WIDTH='70%'     bordercolor="#D98242"   rules="none" cellpadding="0" cellspacing="0" 	align=center>
	<Br><Tr>
	<td align=LEFT colspan=4><h2>&nbsp;&nbsp;<b>M.TECH </b></font> </td></tr>
	<TR	><td align=LEFT  class="tablecell" ><INPUT name="QryType" TYPE="radio"	tabindex="17"  VALUE="M1" onClick="return checkRadio();">Application Number	<br><font size=2>(Purchased Application Form for M.Tech Program) </font>
	</td>
	<td  align="left" class="tablecell" colspan=3 >	
	&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
		&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; <input name="TXT9" maxlength="15" id="TXT9" tabindex="18" LANGUAGE=javascript	style="VERTICAL-ALIGN: middle; WIDTH: 120px;	HEIGHT:22px"><FONT color=red><sub>*</sub></FONT></td></tr>
	<TR	><td class="tablecell" colspan=4	align=left>&nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;OR	</TD></TR>
	<TR	><td class="tablecell"	align=LEFT><INPUT name="QryType" TYPE="radio" tabindex="19"	 VALUE="M2"	onClick="return	checkRadio();">10+2	Roll Number<br><font size=2>(For Downloaded	Application	Form for M.Tech Program) </font>
	</td>
	<td class="tablecell" align="left" colspan=3>
	&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
		&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; <input name="TXT10"	maxlength="15" id="TXT10" tabindex="20"	LANGUAGE=javascript	style="VERTICAL-ALIGN: middle; WIDTH: 120px; HEIGHT:22px"><FONT	color=red><sub>*</sub></FONT> </td></tr>
		 
	</table>


<table WIDTH='70%'     bordercolor="#D98242"   rules="none" cellpadding="0" cellspacing="0" 	align=center>
	<Br><Tr>
	<td align=LEFT colspan=4><h2>&nbsp;&nbsp;<b>PHD </b></font> </td></tr>
	<TR	><td align=LEFT  class="tablecell" ><INPUT name="QryType" TYPE="radio"	tabindex="17"  VALUE="P1" onClick="return checkRadio();">Application Number	<br><font size=2>(Purchased Application Form For PHD Program) </font>
	</td>
	<td  align="left" class="tablecell" colspan=3 >	
	&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
	&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
	<input name="TXT11" maxlength="15" id="TXT11" tabindex="18" LANGUAGE=javascript	style="VERTICAL-ALIGN: middle; WIDTH: 120px;	HEIGHT:22px"><FONT color=red><sub>*</sub></FONT></td></tr>
	<TR	><td class="tablecell" colspan=4	align=left>&nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;OR	</TD></TR>
	<TR	><td class="tablecell"	align=LEFT><INPUT name="QryType" TYPE="radio" tabindex="19"	 VALUE="P2"	onClick="return	checkRadio();">Date	of Birth  <font size=1>Format (<font color=red	face=verdana size=1><b>DD/MM/YYYY</b></font>)<br><font size=2>(For Downloaded Application Form for PHD Program) </font>
	</td>
	<td class="tablecell" align="left" colspan=3>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
		&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;  &nbsp;
	<input name="TXT12"	maxlength="15" id="TXT12" tabindex="20"	LANGUAGE=javascript	style="VERTICAL-ALIGN: middle; WIDTH: 120px; HEIGHT:22px"><FONT	color=red><sub>*</sub></FONT> </td></tr>
		 
	</table>



<TABLE WIDTH='70%'    cellpadding="0" cellspacing="0" 	align=center>
<TR	bgcolor="#D98242"><td class="tablecell" colspan=4 align=CENTER><INPUT id=BTNSubmit	style="FONT-SIZE: x-small; VERTICAL-ALIGN:	top; WIDTH:	95px; FONT-FAMILY:	  Arial; HEIGHT: 25px" tabIndex=13 type=submit size=30 value=Submit name=BTNSubmit	height="25">	  <INPUT id=BTNReset style="FONT-SIZE: x-small;	VERTICAL-ALIGN:	top; WIDTH: 94px; FONT-FAMILY:	 Arial;	HEIGHT:	25px" tabIndex=22 type=reset size=30 value=Reset name=BTNReset height="25"></td></tr>
</TABLE>

	</form>
	<table align=center><tr><td align=center>
<IMG  src="../Images/CampusLynx.png">
</td>
<td >
<FONT size =4 style="FONT-FAMILY: ARIal"><b>Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href="mailto:mailto:jiiterp@jiit.ac.in">jiiterp@jiit.ac.in</A></FONT> 	
</td>
</tr>
</table>
	</BODY>
	</HTML>