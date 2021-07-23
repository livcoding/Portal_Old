<%@ page language="java"  import="java.sql.*,tietwebkiosk.*" %>
<html>
<head>
<TITLE>#### JIIT </TITLE>
<link type="text/css" rel="StyleSheet" href="css/style.css" />

<script language="javascript"  ID=clientEventHandlersJS>
     function detect()
	{
//screen.width=800;
//screen.height=600;

screen.height=800;
screen.width=600;

	 }
      detect();
	 </script>
		

</head>
<BODY STYLE="width:600;height:800" vLink=#00000b link=#00000b bgcolor="#fce9c5" leftMargin=1 topMargin=0 marginheight="0" marginwidth="0" >
<link  rel="stylesheet" type="text/css" href="css/style.css">
<div id="header">
<table width="60%" align=center border=0 cellpadding=0 cellspacing=0>
<tr><td align=center>
<h1>Complaint Detail</h1>
</td></tr>
</table>
</div>
<form name="frm1" method=post action="MedicalDetailAction.jsp">
<table width="100%" border=1  rules=none align=center   topmargin=0 cellspacing=0 cellpadding=1 borderColor="#D98242" >
<td class="labelcell" >
Ref.No. <input type="text" id="" />
<td class="labelcell" >
Complaint No.<input type="text" id="" /></td>
<td class="labelcell">
Complaint Date<input type="text" id="" /></td>
</tr>
</table>
<table width="100%" border=1  rules=none align=center bottommargin=0  topmargin=0 cellspacing=0 cellpadding=1 borderColor=#D98242>
<tr>
<td class="labelcell">   
Complaint :
</td>
<td class="labelcell">
<textarea id="" rows="" cols=""></textarea>
</td>
</tr>
<tr>
<td class="labelcell">
Treatment:
</td>
<td>
<textarea id="" rows="" cols=""></textarea>
</td>
</tr>
<tr>
<td class="labelcell">
Suggestion:
</td>
<td>
<textarea id="" rows="" cols=""></textarea>
</td>
</tr>
<tr>
<tr><td class="labelcell">
Investigation Required &nbsp;<select  name="Alleg" id="Alleg" style="width:215px">
<option selected value='N'><-Select-></option>
<option value='y'>YES</option>
<option value='N'>NO</option></select>
<font size="2" color="Black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(If Yes Then Detail): <td></font><textarea id="" rows="" cols=""></textarea>
</tr>
</tr>
</tr>
</td>
</tr>
</table>
<table border="1"  cellspacing=0 cellpadding=2 borderColor=#D98242  width="100%">
<TR>
<h2><center>Investigation Result Detail</center></h2>
<tr>
<td class="labelcell">
Result Recieved <select  name="result" id="result" style="width:115px">
<option value='Y'>YES</option>
<option value='N'>NO</option></select>
Date Of Recieve<input type="text" id=""/>
Result Detail <input type="text" id="" style="width=250px" /></tr>
</table>
<table border="1"  cellspacing=0 cellpadding=2 borderColor=#D98242  width="100%">
<tr><td class="labelcell">
Remark:
<textarea id="" rows="" cols=""></textarea></td>
</td>
</tr>
<table align=center bottommargin=0 rules=none topmargin=0 cellspacing=0 cellpadding=0 border=0 >
<tr><br><input type=Submit  border= "3px" name="submit" id="submit" value="&nbsp; Submit & Back &nbsp;" onClick="return Validate();" ></br></td></tr>
</table>
</tr>
</td>
</form>


