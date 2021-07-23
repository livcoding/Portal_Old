<%-- 
    Document   : NonAcademicFeeHistory
    Created on : 29 Jun, 2020, 12:18:34 PM
    Author     : anoop.tiwari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*,pgwebkiosk.*" %>

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="";
%>
<HTML>
<head>
 <TITLE>#### <%=mHead%> [ View Academic Fee detail  ] </TITLE>
  <script type="text/javascript" src="js/jquery-1.4.2.js"></script>
    <script language="JavaScript" type ="text/javascript">

	<!--
	  if (top != self) top.document.title = document.title;
	-->



</script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>



<script type="text/javascript">
function validateValues()
{
var totamt=document.getElementById('feeamount');
var x=true;
 if(totamt.value==null || totamt.value==""  || parseFloat(totamt.value)<=0 )
{
alert("Invalid Fee Amount, Fee Amt cant be zero or less then zero.");
x= false;
}
return x;
}


// for when use payment options
function validateValues2()
{
var n=document.getElementById('netbanks');
var ctype=document.getElementById('options');
var ntype=document.getElementById('options2');
var totamt=document.getElementById('feeamount');
var x=true;
if(ctype!=null){
if(ctype.checked==false && ntype.checked==false){
alert("Please Select One Fee Payment Option");
x=false;
}
}
 if(ntype.checked==true && (n.value=="" || n.value==null) )
{
alert("Please Select One Bank Name for Net Banking.");
x= false;
}

 if(totamt.value==null || totamt.value=="" || parseFloat(totamt.value)<=0 )
{
alert("Invalid Fee Amount, Fee Amt cant be zero or less then zero.");
x= false;
}

return x;


}



function onbankchange(){
document.getElementById('options2').checked = true;
var n=$("#netbanks");
var feeamt=$("#feeamount").val();
var chargeType="";
var chargerate="";
var chargedAmt="";
var totAmt="";
if(n!=null && !n.val()==""){
document.getElementById('btn1').disabled=false;
var s=n.val();
var st=s.split("XXXXXXX");
chargeType=st[1];
chargerate=st[2];

if(chargeType=="P"){
//percentage
chargedAmt=(parseFloat(feeamt)*parseFloat(chargerate)/100);
}
else if(chargeType=="F"){
// fix
chargedAmt=chargerate;
}
totAmt=parseFloat(feeamt)+parseFloat(chargedAmt);
$("#totfeeamount").val(totAmt);
chargedAmt=chargedAmt.toFixed(2);
totAmt=totAmt.toFixed(2);

$('#transCharges').val(chargedAmt);
chargedAmt=chargedAmt+" /-";
totAmt=totAmt+" /-"
$("#charges").empty();
$("#charges").append(chargedAmt + "");
$("#totamt").empty();
$("#totamt").append(totAmt + "");
}else{

$("#charges").empty();
$("#charges").append("");
$("#totamt").empty();
$("#totamt").append("");
document.getElementById('btn1').disabled=true;
}

}


function onbankchange1(){
document.getElementById('options2').checked = true;
var n=$("#netbanks");
if(n!=null && !n.val()==""){
document.getElementById('btn1').disabled=false;
}else{
document.getElementById('btn1').disabled=true;
}
}

function oncardselect(){

var x=document.getElementById('options').checked;
//alert("on chaange"+x);
if(x==true){
document.getElementById('btn1').disabled=false;
document.getElementById('netbanks').selectedIndex =0 ;
}
}
function resetAmt(){
$("#totamt").empty();
$("#totamt").append("");
document.getElementById('btn1').disabled=true;
}


function changeURL(){
setTimeout(function(){document.location.href = "http://"+location.host+"/pgfiles/BlankPage.jsp;"},0);
}



</script>
<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 20px;
}
-->
</style>
</head>
<body aLink=#ff00ff bgcolor="#F5F5F5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet RsFee=null;
ResultSet rs=null;
String qry1="",mWebEmail="";
int mSNO=0;
int mData=0;
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mmMemberName="";
String mCompanyCode="";
String mAcademicYearCode="";
String mProgramCode="";
String mBranchCode="";
String mCurrentSem="";
int mCurSem=0;
String mMS="";
String mInstituteCode="";

String mMaxSemester="";

String mSCode="";

String regcode="NONACADEMIC";
//String regcode= request.getParameter("regcode")==null?"":request.getParameter("regcode");
String pAmt=request.getParameter("pamt")==null?"":request.getParameter("pamt");
String sName=request.getParameter("sname")==null?"":request.getParameter("sname");
String enrollNo=request.getParameter("enrollno")==null?"":request.getParameter("enrollno");
String prog=request.getParameter("prog")==null?"":request.getParameter("prog");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String academicyear=request.getParameter("academicyear")==null?"":request.getParameter("academicyear");
String currsem=request.getParameter("currsem")==null?"":request.getParameter("currsem");
String sFName=request.getParameter("sfname")==null?"":request.getParameter("sfname");
String dob=request.getParameter("dob")==null?"":request.getParameter("dob");
String feeHead=request.getParameter("feeHead")==null?"":request.getParameter("feeHead");


//regcode=enc.decode(regcode);
//enrollNo=enc.decode(enrollNo);
//pAmt=enc.decrypt(pAmt);


try
{
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
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

if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
	mmMemberName=GlobalFunctions.toTtitleCase(mMemberName.trim());
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("AcademicYearCode")==null)
{
	mAcademicYearCode="";
}
else
{
	mAcademicYearCode=session.getAttribute("AcademicYearCode").toString().trim();
}

if (session.getAttribute("ProgramCode")==null)
{
	mProgramCode="";
}
else
{
	mProgramCode=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranchCode="";
}
else
{
	mBranchCode=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mCurrentSem="";
}
else
{
	mCurrentSem=session.getAttribute("CurrentSem").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstituteCode="";
}
else
{
	mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
}
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
{
	try
	{
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
String seqqry="Select WEBKIOSK.ShowLink('416','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  RsChk= db.getRowset(seqqry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

	session.setAttribute("pinstitutecode",mInstituteCode);
	session.setAttribute("pglobalcompany",mCompanyCode);
	session.setAttribute("pwithregcode",request.getParameter("WithRegCode")==null?"":request.getParameter("WithRegCode"));
	session.setAttribute("pacademicyear",request.getParameter("mAcademicYearCode")==null?"":request.getParameter("mAcademicYearCode"));
	session.setAttribute("pstudentid",request.getParameter("memberid")==null?"":mChkMemID);
	//session.setAttribute("pregcode",request.getParameter("regcode")==null?"":regcode);
	//session.setAttribute("pforregcode",request.getParameter("regcode")==null?"":regcode);
	session.setAttribute("pcategorycode",request.getParameter("mcategorycode")==null?"":request.getParameter("mcategorycode"));
	session.setAttribute("pquota",request.getParameter("mquota")==null?"":request.getParameter("mquota"));
	session.setAttribute("pprogramcode",request.getParameter("prog")==null?"":request.getParameter("prog"));
	session.setAttribute("pbranchcode",request.getParameter("branch")==null?"":request.getParameter("branch"));
	session.setAttribute("psectioncode",request.getParameter("section")==null?"":request.getParameter("section"));
	session.setAttribute("psubsectioncode",request.getParameter("subsection")==null?"":request.getParameter("subsection"));
	session.setAttribute("psemester",request.getParameter("msem")==null?"":request.getParameter("msem"));
	session.setAttribute("pcurSemester",request.getParameter("currsem")==null?"":request.getParameter("currsem"));
	session.setAttribute("psemestertype",request.getParameter("msemtype")==null?"":request.getParameter("msemtype"));
	session.setAttribute("phostelallow",request.getParameter("mhostel")==null?"":request.getParameter("mhostel"));
	session.setAttribute("phosteltype",request.getParameter("mhosteltype")==null?"":request.getParameter("mhosteltype"));
	session.setAttribute("penrollmentno",request.getParameter("enrollno")==null?"":request.getParameter("enrollno"));
	session.setAttribute("ptotalfeeamount",request.getParameter("pamt")==null?"":request.getParameter("pamt"));
	session.setAttribute("ptotalfeepaidamount",request.getParameter("")==null?"":request.getParameter(""));
	//session.setAttribute("ptransdatetime",request.getParameter("")==null?"":request.getParameter(""));
	session.setAttribute("pcurrencycode",request.getParameter("currecyc")==null?"":request.getParameter("currecyc"));
	session.setAttribute("feeHead",request.getParameter("feeHead")==null?"":request.getParameter("feeHead"));




%>


<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana">Registration Fee Receipt
</font></td></tr>
</TABLE>
<hr>
<table cellpadding=0 cellspacing=0 align=center rules=groups border=0>
<tr>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Name(Enrolment No.) :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td nowrap><FONT color=black>&nbsp; <FONT face=Arial size=2><%=mMemberName%>(<%=enrollNo%>)</FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Program-Branch :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=prog%>-<%=branch%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 </tr>
 <tr>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Academic Year :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=academicyear%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Current Semester :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=currsem%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 </tr>
 <tr>
</table>
<hr>



<form name="bankoptions" id="bankoptions" methods="post" action="NonAcademicMakePayment.jsp" target="_blank" onSubmit="javascript:changeURL();">



<br/>

<Table width="681" height="215" border="0" cellpadding="0" cellspacing="0" align="center">
<tr>
  <td height="38" colspan=4 align="center" bgcolor="#E18700"><span class="style1"><b>On Line Fee Payment Options
    </span>
    <input type="hidden" name="feeamount" id="feeamount" value=<%=pAmt%> />
	<!--
	<input type="hidden" name="othercharges" id="othercharges"  value="" />

    <input type="hidden" name="totfeeamount" id="totfeeamount"  value="" />
    -->

	<input type="hidden" name="enrollno" id="enrollno" value="<%=enrollNo%>" />
	<input type="hidden" name="studentname" id="studentname"  value="<%=mMemberName%>" />
	<input type="hidden" name="dateofbirth" id="dateofbirth" value="<%=dob%>" />
	<input type="hidden" name="fathername" id="fathername"  value="<%=sFName%>" />
	<input type="hidden" name="regcode" id="regcode"  value="<%=regcode%>" />
	<!--
	<input type="hidden" name="transCharges" id="transCharges"  value="0.0" />
		-->

   <b>   </td>
</tr>

<tr><td height="97" colspan="4" bgcolor="#F9F4C1" style="height:10px">

<table width="354" align="center">
  <tr><td width="200"><div align="right">Fee Amount(Rs.)  &nbsp;&nbsp;:&nbsp;&nbsp;</div></td>
  <td width="142" style="text-align:right" ><font color="#660000"><strong>
    <%=pAmt%>  /-</strong></font></td>
</tr>
</table>
<br>
</td>
</tr>
<tr>
<td height="50" colspan=4 align="center"   bgcolor="#E18700" style="text-align:center;vertical-align:middle">
<input type="submit" id="btn1" name="btn1" style="height:35px;" onClick="return  validateValues()"   value="Pay Now">
</td>
</tr>
</Table>
</form>
<hr>
<table width="581">
<tr><td><font color="#990000"/></font></td></tr>
<tr><td><font color="#990000"/></font></td></tr>
</table>



<%
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	<br>	<br>	<br>	<br>
   <%
	}
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
System.out.println(e);
}
%>

</body>
</html>
