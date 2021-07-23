<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db = new DBHandler();
ResultSet rs = null;
ResultSet rsd = null;
ResultSet rs1 = null;
ResultSet rs2 = null;
String qry = "";
GlobalFunctions gb = new GlobalFunctions();
//-----------------ADDED CODE----------------------DATE-28-MARCH-2011@mohit sharma
String mRegCode = "";
String mHOSTELTYPE = "";
String mAcademicYear = "";
String mProgramCode = "";
String mBranchCode = "";
String mInst="",minst="" ,mInstCode="";
int count=0;
%>
<HTML>
<head>
<TITLE>#### JIIT [ View Hostel detail  ] </TITLE>
<script language="JavaScript" type ="text/javascript">
function ChangeOptions(InstCode,DataRegCode,RegCode,DataProg,Prog,DataBranch,Branch)
{
//,DataAcad,Acad,DataProg,Prog,DataBranch,Branch)
removeAllOptions(RegCode);
var optns = document.createElement("OPTION");
optns.text='ALL';
optns.value='ALL';
RegCode.options.add(optns);
rgd='ALL';
var QryReg='';
var QryAcad='';
var QryProg='';
var QryBran='';
for(i=0;i<DataRegCode.options.length;i++)
{
var v1;
var pos;
var ic;
var rc;
var len;
var otext;
var v1=DataRegCode.options(i).value;
len= v1.length ;
pos=v1.indexOf('***');
ic=v1.substring(0,pos);
rc=v1.substring(pos+3,len);
if (ic==InstCode && rgd=='ALL' )
{
var optn = document.createElement("OPTION");
optn.text=DataRegCode.options(i).text;
optn.value=rc;
//          alert(ic+"LLLL"+rc);
if (QryReg=='') QryReg=rc;
RegCode.options.add(optn);
}
}
//-----------------------------Program Code---------------------------------------//
removeAllOptions(Prog);
mflag=0;
var optns = document.createElement("OPTION");
optns.text='ALL';
optns.value='ALL';
Prog.options.add(optns);
prg='ALL';
for(i=0;i<DataProg.options.length;i++)
{
var v1s1;
var pos11;
var pos21;
var pos31;
var inst1;
var reg1;
var lens1;
var acad1;
var otexts;
var v1s1=DataProg.options(i).value;
lens1= v1s1.length ;
pos11=v1s1.indexOf('***');
//pos21=v1s1.indexOf('///');
pos21=v1s1.indexOf('&&&');
inst1=v1s1.substring(0,pos11);
reg1=v1s1.substring(pos11+3,pos21);
//acad1=v1s1.substring(pos21+3,pos31);
prog1=v1s1.substring(pos21+3,lens1);
//alert(inst1+"dd"+InstCode+"lll"+reg1+"sss"+QryReg+"ggg"+acad1+"xx"+acad)   ;
if (inst1==InstCode && reg1==QryReg  && prg=='ALL' )
{
var optns1 = document.createElement("OPTION");
optns1.text=DataProg.options(i).text;
optns1.value=prog1;
//alert(optns1.value+"PPPP");
Prog.options.add(optns1);
}
}
//-----------------branch code-------------------------

removeAllOptions(Branch);
mflag=0;
var optns = document.createElement("OPTION");
optns.text='ALL';
optns.value='ALL';
Branch.options.add(optns);
bran='ALL';
for(i=0;i<DataBranch.options.length;i++)
{
var v1s1;
var pos11;
var pos21;
var pos31,pos41;
var inst1;
var reg1;
var lens1;
var acad1;
var otexts;
var v1s1=DataBranch.options(i).value;
lens1= v1s1.length ;
pos11=v1s1.indexOf('***');

inst1=v1s1.substring(0,pos11);
bran1=v1s1.substring(pos11+3,lens1);

if (inst1==InstCode &&  prg=='ALL'  )
{
//alert(inst1+"dd"+InstCode+"lll"+reg1+"sss"+QryReg+"ggg"+aca+"xx"+bran1);
var optns1 = document.createElement("OPTION");
optns1.text=DataBranch.options(i).text;
optns1.value=bran1;
//alert(optns1.value+"PPPP");

Branch.options.add(optns1);
}
}
//-------------------------------------------------//
}
function ChangeOptions1(InstCode,RegCode,DataAcad,Acad,DataProg,Prog,DataBranch,Branch)
{
removeAllOptions(Acad);
mflag=0;
var optns = document.createElement("OPTION");
var QryReg=RegCode;
optns.text='ALL';
optns.value='ALL';
Acad.options.add(optns);
aca='ALL';
for(i=0;i<DataAcad.options.length;i++)
{
var v1s;
var pos1;
var pos2;
var inst;
var reg;
var lens;
var acad;
var otexts;
var v1s=DataAcad.options(i).value;
lens= v1s.length ;
pos1=v1s.indexOf('***');
pos2=v1s.indexOf('///');
inst=v1s.substring(0,pos1);
reg=v1s.substring(pos1+3,pos2);
acad=v1s.substring(pos2+3,lens);
//alert(inst+"dd"+reg+"sss"+acad);
if (inst==InstCode && reg==QryReg && aca=='ALL')
{
var optns = document.createElement("OPTION");
optns.text=DataAcad.options(i).text;
optns.value=acad;
Acad.options.add(optns);
}
}
//-----------------------------Program Code---------------------------------------//
removeAllOptions(Prog);
mflag=0;
var optns = document.createElement("OPTION");
optns.text='ALL';
optns.value='ALL';
Prog.options.add(optns);
prg='ALL';
for(i=0;i<DataProg.options.length;i++)
{
var v1s1;
var pos11;
var pos21;
var pos31;
var inst1;
var reg1;
var lens1;
var acad1;
var otexts;
var v1s1=DataProg.options(i).value;
lens1= v1s1.length ;
pos11=v1s1.indexOf('***');
//pos21=v1s1.indexOf('///');
pos21=v1s1.indexOf('&&&');
inst1=v1s1.substring(0,pos11);
reg1=v1s1.substring(pos11+3,pos21);
//acad1=v1s1.substring(pos21+3,pos31);
prog1=v1s1.substring(pos21+3,lens1);
//alert(inst1+"dd"+InstCode+"lll"+reg1+"sss"+QryReg+"ggg"+acad1+"xx"+acad)   ;
if (inst1==InstCode && reg1==QryReg && aca=='ALL' && prg=='ALL' )
{
var optns1 = document.createElement("OPTION");
optns1.text=DataProg.options(i).text;
optns1.value=prog1;
//alert(optns1.value+"PPPP");
Prog.options.add(optns1);
}
}
//-------------------------------------branch code------------------------------------------//
removeAllOptions(Branch);
mflag=0;
var optns = document.createElement("OPTION");
optns.text='ALL';
optns.value='ALL';
Branch.options.add(optns);
bran='ALL';
for(i=0;i<DataBranch.options.length;i++)
{
var v1s1;
var pos11;
var pos21;
var pos31,pos41;
var inst1;
var reg1;
var lens1;
var acad1;
var otexts;
var v1s1=DataBranch.options(i).value;
lens1= v1s1.length ;
pos11=v1s1.indexOf('***');

inst1=v1s1.substring(0,pos11);
bran1=v1s1.substring(pos11+3,lens1);
//acad1=v1s1.substring(pos21+3,pos31);
//prog1=v1s1.substring(pos31+3,pos41);
//bran1=v1s1.substring(pos41+3,lens1);
if (inst1==InstCode && aca=='ALL' && prg=='ALL'  )
{
//alert(inst1+"dd"+InstCode+"lll"+reg1+"sss"+QryReg+"ggg"+aca+"xx"+bran1)   ;
var optns1 = document.createElement("OPTION");
optns1.text=DataBranch.options(i).text;
optns1.value=bran1;
//alert(optns1.value+"PPPP");

Branch.options.add(optns1);
}
}
}
function removeAllOptions(selectbox)
{
var i;
for(i=selectbox.options.length-1;i>=0;i--)
{
selectbox.remove(i);
}
}
</script>
<script language=javascript>
<!--
function RefreshContents()
{
document.frm.x.value='ddd';
document.frm.submit();
}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR="">Hostel Allotment Status</FONT>
<BR><img src="images/ornament.gif" width="474" height="11" alt="" />
</font></td></tr>
</table>
<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
<tr>
<td>
<FONT face=Arial size=2><STRONG>Institute Code:&nbsp;</STRONG></FONT>
<%
try
{
qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster Where nvl(Deactive,'N')='N' and INSTITUTECODE in (select INSTITUTECODE from studentregistration) ";
rs=db.getRowset(qry);
if (request.getParameter("x")==null)
{
%>
&nbsp;&nbsp;<select name="InstCode" tabindex="1" id="InstCode" style="WIDTH: 150px"
onclick="ChangeOptions(InstCode.value,DataRegCode,RegCode,DataProg,Prog,DataBranch,Branch);"
onChange="ChangeOptions(InstCode.value,DataRegCode,RegCode,DataProg,Prog,DataBranch,Branch);">
<%
while(rs.next())
{
mInst=rs.getString("InstCode");
if(mInst.equals(""))
minst=mInst;
%>
<OPTION selected Value ="<%=mInst%>"><%=mInst%></option>
<%
}
%>
</select>
<%
}
else
{
%>
&nbsp;<select name="InstCode" tabindex="1" id="InstCode" style="WIDTH: 150px">
<option  selected value="ALL">ALL</option>
<%
while(rs.next())
{
mInst=rs.getString("InstCode");
if(mInst.equals(request.getParameter("InstCode").toString().trim()))
{
%>
<OPTION selected Value ="<%=mInst%>"><%=mInst%></option>
<%
}
else
{
%>
<OPTION Value ="<%=mInst%>"><%=mInst%></option>
<%
}
}
%>
</select>
<%
}
}
catch(Exception e)
{
}
%>
</td>
<td>
<%
ResultSet rsfd=null;
String mReg="",mReg1="";
qry="select INSTITUTECODE,regcode from registrationmaster WHERE NVL (deactive, 'N') = 'N' ORDER BY regcode ";
rsfd=db.getRowset(qry);
if (request.getParameter("x")==null)
{
%>
<select name="DataRegCode" tabindex="0" id="DataRegCode" style="WIDTH:0px">
<%
while(rsfd.next())
{
mReg=rsfd.getString("INSTITUTECODE")+"***"+rsfd.getString("regcode");
if(mReg1.equals(""))
mReg1=mReg;
%>
<OPTION selected Value="<%=mReg%>"><%=rsfd.getString("regcode")%></option>
<%
}
%>
</select>
<%
}
else
{
%>
<select name=DataRegCode tabindex="0" id="DataRegCode" style="WIDTH: 0px">
<%
while(rsfd.next())
{
mReg=rsfd.getString("INSTITUTECODE")+"***"+rsfd.getString("regcode");
if(mReg.equals(request.getParameter("DataRegCode").toString().trim()))
{
mReg1=mReg;
%>
<OPTION selected Value="<%=mReg%>"><%=rsfd.getString("regcode")%></option>
<%
}
else
{
%>
<OPTION Value="<%=mReg%>"><%=rsfd.getString("regcode")%></option>
<%
}
}
%>
</select>
<%
}
%>
<FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Reg.Code :&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</STRONG></FONT></FONT>&nbsp;&nbsp;<select  name="RegCode" id="RegCode" 
onclick="ChangeOptions1(InstCode.value,RegCode.value,DataAcad,Acad,DataProg,Prog,DataBranch,Branch);"
onChange="ChangeOptions1(InstCode.value,RegCode.value,DataAcad,Acad,DataProg,Prog,DataBranch,Branch);"
style="width:150px">
<option  selected value="ALL">ALL</option>
<%
qry = "SELECT DISTINCT regcode FROM registrationmaster WHERE NVL (deactive, 'N') = 'N' ORDER BY regcode";
rs = db.getRowset(qry);
while (rs.next()) {
%>
<option Value ='<%=rs.getString("regcode")%>'><%=rs.getString("regcode")%></option>
<%
}
%>
</select></td>
<td>
<FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Hostel Type:&nbsp;</STRONG></FONT><select  name="HOSTELTYPE"  id="HOSTELTYPE"  style="width:150px" >
<option  selected value="ALL">Boys & Girls</option>
<option  selected value="B">Boys</option>
<option  selected value="G">Girls</option>
</select>
</FONT></td>
<TR>
<td NOWRAP>
<%
ResultSet rsf=null;
String mAcad="",mAcad1="";
qry = " select distinct a.INSTITUTECODE,a.REGCODE,a.academicyear from studentregistration a ";
rsf=db.getRowset(qry);
if (request.getParameter("x")==null)
{
%>
<select name="DataAcad" tabindex="0" id="DataAcad" style="WIDTH:0px">
<%
while(rsf.next())
{
mAcad=rsf.getString("INSTITUTECODE")+"***"+rsf.getString("REGCODE")+"///"+rsf.getString("academicyear");
if(mAcad1.equals(""))
mAcad1=mAcad;
%>
<OPTION selected Value="<%=mAcad%>"><%=rsf.getString("academicyear")%></option>
<%
}
%>
</select>
<%
}
else
{
%>
<select name="DataAcad" tabindex="0" id="DataAcad" style="WIDTH: 0px">
<%
while(rsf.next())
{
mAcad=rsf.getString("INSTITUTECODE")+"***"+rsf.getString("REGCODE")+"///"+rsf.getString("academicyear");
if(mAcad.equals(request.getParameter("DataAcad").toString().trim()))
{
mAcad1=mAcad;
%>
<OPTION selected Value="<%=mAcad%>"><%=rsf.getString("academicyear")%></option>
<%
}
else
{
%>
<OPTION Value="<%=mAcad%>"><%=rsf.getString("academicyear")%></option>
<%
}
}
%>
</select>
<%
}
%>
<FONT color=black><FONT face=Arial size=2><STRONG>Academic Year:&nbsp</STRONG></FONT><select  name="Acad"  id="Acad" style="width:150px">
<option  selected value="ALL">ALL</option>
<%
try {
qry = "  select distinct a.academicyear from studentregistration a order by a.academicyear";
rsd = db.getRowset(qry);
while (rsd.next()) {
%>
<option value="<%=rsd.getString("academicyear")%> "><%=rsd.getString("academicyear")%></option>
<%
}
} catch (Exception e) {
}
%>
</select>
&nbsp;&nbsp;&nbsp;</FONT></td>
<td NOWRAP>
<%
String mPrg="",mPrg1="";
qry = " select distinct a.INSTITUTECODE,a.REGCODE,a.programcode from studentregistration a order by a.programcode";
rsf=db.getRowset(qry);
if (request.getParameter("x")==null)
{
%>
<select name="DataProg" tabindex="0" id="DataProg" style="WIDTH:0px">
<%
while(rsf.next())
{
//+"///"+rsf.getString("academicyear")
mPrg=rsf.getString("INSTITUTECODE")+"***"+rsf.getString("REGCODE")+"&&&"+rsf.getString("programcode");
if(mPrg1.equals(""))
mPrg1=mPrg;
%>
<OPTION selected Value="<%=mPrg%>"><%=rsf.getString("programcode")%></option>
<%
}
%>
</select>
<%
}
else
{
%>
<select name="DataProg" tabindex="0" id="DataProg" style="WIDTH: 0px">
<%
while(rsf.next())
{
mPrg=rsf.getString("INSTITUTECODE")+"***"+rsf.getString("REGCODE")+"&&&"+rsf.getString("programcode");
if(mPrg.equals(request.getParameter("DataProg").toString().trim()))
{
mPrg1=mPrg;
%>
<OPTION selected Value="<%=mPrg%>"><%=rsf.getString("programcode")%></option>
<%
}
else
{
%>
<OPTION Value="<%=mPrg%>"><%=rsf.getString("programcode")%></option>
<%
}
}
%>
</select>
<%
}
%>

<FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Program Code:&nbsp&nbsp&nbsp&nbsp</STRONG></FONT><select  name="Prog"  id="Prog" style="width:150px">
<option  selected value="ALL">ALL</option>
<%
try {
qry = " select distinct a.programcode from studentregistration a order by a.programcode";

rsd = db.getRowset(qry);
while (rsd.next()) {
%>
<option value="<%=rsd.getString("programcode")%> "><%=rsd.getString("programcode")%></option>
<%
}
} catch (Exception e) {
}
%>
</select>
</FONT></td>
<td NOWRAP>
<%
String mBranch="",mBranch1="";
qry = " select distinct a.INSTITUTECODE,a.SECTIONBRANCH from studentregistration a order by a.SECTIONBRANCH";
rsf=db.getRowset(qry);
if (request.getParameter("x")==null)
{
%>
<select name="DataBranch" tabindex="0" id="DataBranch" style="WIDTH:0px">
<%
while(rsf.next())
{
mBranch=rsf.getString("INSTITUTECODE")+"***"+rsf.getString("SECTIONBRANCH");
if(mBranch1.equals(""))
mBranch1=mBranch;
%>
<OPTION selected Value="<%=mBranch%>"><%=rsf.getString("SECTIONBRANCH")%></option>
<%
}
%>
</select>
<%
}
else
{
%>
<select name="DataBranch" tabindex="0" id="DataBranch" style="WIDTH: 0px">
<%
while(rsf.next())
{
mBranch=rsf.getString("INSTITUTECODE")+"***"+rsf.getString("SECTIONBRANCH");
if(mBranch.equals(request.getParameter("DataBranch").toString().trim()))
{
mBranch1=mBranch;
%>
<OPTION selected Value="<%=mBranch%>"><%=rsf.getString("SECTIONBRANCH")%></option>
<%
}
else
{
%>
<OPTION Value="<%=mBranch%>"><%=rsf.getString("SECTIONBRANCH")%></option>
<%
}
}
%>
</select>
<%
}
%>
<FONT color=black><FONT face=Arial size=2><STRONG>Branch Code:&nbsp;</STRONG></FONT></FONT><select  NAME="Branch"  ID="Branch" style="width:150px">
<option  selected value="ALL">ALL</option>
<%
try {
qry = " select distinct a.SECTIONBRANCH branchcode from studentregistration a  order by branchcode";
rsd = db.getRowset(qry);
//out.print(qry);
while (rsd.next()) {
%>
<option value="<%=rsd.getString("branchcode")%> "><%=rsd.getString("branchcode")%></option>
<%
}
} catch (Exception e) {
}
%>
</select>
</TD>
</TR>
<TR>
<td COLSPAN=6 ALIGN=CENTER><BR><INPUT Type="submit" Value="Show/Refresh"></td>
</TR>
<tr><td nowrap colspan=6>
<marquee  scrolldelay=225 width:700 behavior=alternate><a href="../../Images/PageSetupXL.bmp" Title="Instruction before print a Students List" Target=_New><font size=3 color=Blue><b>Recommended Page Setup: Paper Size - A4 and Top/Bottom Margin - .25</b></font></a></marquee></td></tr>
<tr>
</table>
</form>
<%  //-----------------------------------------------------------------------
try
{
if(request.getParameter("x") != null) {

//------------ADDED CODE--------------DATE-30-MARCH-2011-------------InstCode  b.REGCODE
if (request.getParameter("Acad") == null) {
mAcademicYear = "";
} else {
mAcademicYear = request.getParameter("Acad").toString().trim();
}


	if (request.getParameter("InstCode") == null) {
mInstCode = "";
} else {
mInstCode = request.getParameter("InstCode").toString().trim();
}

if (request.getParameter("RegCode") == null) {
mRegCode = "";
} else {
mRegCode = request.getParameter("RegCode").toString().trim();
}
if (request.getParameter("Prog") == null) {
mProgramCode = "";
} else {
mProgramCode = request.getParameter("Prog").toString().trim();
}
if (request.getParameter("HOSTELTYPE") == null) {
mHOSTELTYPE = "";
} else {
mHOSTELTYPE = request.getParameter("HOSTELTYPE").toString().trim();
}
if (request.getParameter("Branch") == null) {
mBranchCode = "";
} else {
mBranchCode = request.getParameter("Branch").toString().trim();
}
//out.print(mAcademicYear + "---" + mBranchCode + "---" + mFeeHead + "---" + mProgramCode + "---" + mRegCode);
 // session.setAttribute("listorder",mList);
//------------------------------------------
%>
<br>
<table align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
<thead>
<tr bgcolor="#ff8c00">
<td><b><font color="white">Sr.no.</font></b></td>
<td><b><font color="white">Institute name</font></b></td>
<td><b><font color="white">Hostel Code</font></b></td>
<td><b><font color="white">Total bed capacity</font></b></td>
<td><b><font color="white">Total  Allotted seat</font></b></td>
<td><b><font color="white">Balance Seats Avialable </font></b></td>
</tr>
</thead>
<tbody>
<tr>
<%
qry =" SELECT A.INSTITUTECODE institutecode, a.HOSTELDESCRIPTION  HOSTELDESCRIPTION,  a.totalbedcapacity totalbedcapacity, COUNT (Distinct b.studentid) studenthostelalloted, a.totalbedcapacity - COUNT (Distinct b.studentid) Balancehostelseat    FROM hostelmaster a, studenthosteldetail b,  StudentMaster c,     StudentREGISTRATION D    WHERE     a.institutecode = b.institutecode  AND a.HOSTELCODE = b.HOSTELCODE    AND TRUNC (LEFTHOSTELON) > TRUNC (SYSDATE)  AND B.INSTITUTECODE = C.INSTITUTECODE     AND b.studentid = c.studentid  AND NVL (c.deactive, 'N') = 'N' AND a.institutecode = D.institutecode    AND b.REGCODE = d.RegCode ";

//AND TRUNC(D.REGDATEFROM) >= TO_DATE('01052011','DDMMYYYY') b.REGCODE

if (!mInstCode.equals("ALL")) {
qry = qry + "and  a.INSTITUTECODE='" + mInstCode + "' ";
}

if (!mRegCode.equals("ALL")) {
qry = qry + "and  b.REGCODE='" + mRegCode + "' ";
}

if (!mBranchCode.equals("ALL")) {
qry = qry + "and  c.branchcode='" + mBranchCode + "' ";
}

if (!mProgramCode.equals("ALL")) {
qry = qry + "and  c.programcode='" + mProgramCode + "' ";
}

if (!mHOSTELTYPE.equals("ALL")) {
qry = qry + "and a.HOSTELFOR='" + mHOSTELTYPE + "' ";
}

if (!mAcademicYear.equals("ALL")) {
qry = qry + "and c.academicyear='" + mAcademicYear + "' ";
}

qry=qry+"group by A.INSTITUTECODE, a.HOSTELDESCRIPTION,a.totalbedcapacity order by a.HOSTELDESCRIPTION   ";

out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>>Result Shown For the Following Parameter&nbsp;&nbsp;  (Institute-"+mInstCode+") &nbsp;( RegCode -"+mRegCode+")&nbsp;(Prog.Code-"+mProgramCode+")  &nbsp;( AcademicYear -"+mAcademicYear+")&nbsp; &nbsp;( BranchCode -"+mBranchCode+")&nbsp; &nbsp;( HostelType -"+mHOSTELTYPE+")&nbsp; ");
//out.print(qry);
rs = db.getRowset(qry);
while (rs.next()) {
%>
<td><B><%=++count%></B></td>
<td><%=rs.getString("institutecode")%></td>
<td><%=rs.getString("HOSTELDESCRIPTION")%></td>
<td><%=rs.getString("totalbedcapacity")%></td>
<td><%=rs.getString("studenthostelalloted")%></td>
<td><%=rs.getString("Balancehostelseat")%></td>
</tr>

<%
//-----------------------ADDED CODE------------------ON/27-apl-2011
}
%>
</b>&nbsp; &nbsp;</td>
</tr>
<tr><td colspan=11><marquee scrolldelay=300 behavior=alternate>Click to show detailed of fee structure..</marquee></td></tr>
</tbody>
</table>
<form><input type="button" value=" Print this page "
onclick="window.print();return false;" /></form>

<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
</script>
<table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle><br><br>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp"> <FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:info@jiit.ac.in'>info@jiit.ac.in</A></FONT>
</td>
</tr>
</table>
<%
}
}catch(Exception e)
{
out.print(e);
}
%>
</body>
</html>
