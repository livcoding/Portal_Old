<%@ page language="java" import="java.sql.*,jpalumni.*" %>
<%
DBHandler db = new DBHandler();
ResultSet rs = null, Rs = null;
String mPADDRESS1="",mLoginID="",mCOUNSID ="",mChkOBC="",mPADDRESS2="",mPADDRESS3="";




if (request.getParameter("APPID") == null) {
mLoginID = "";
} else {
mLoginID = request.getParameter("APPID").toString().trim();
}


if (request.getParameter("COUNSID") == null) {
mCOUNSID = "";
} else {
mCOUNSID = request.getParameter("COUNSID").toString().trim();
}








try {
%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Counselling</title>


<meta http-equiv="Page-Enter" content="revealTrans(Duration=1.0,Transition=1)">

<link href="../Resources/CSS/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type ="text/javascript">

if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script language="javascript">
javascript:window.history.forward(1);
</script>



<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>


function UnLoadWindows()
{
alert("For better security you must close this window....");
top.close();
window.open("../SignOut.jsp");
}

function isNumber(e)
{
var unicode=e.charCode? e.charCode : e.keyCode
if (unicode!=8)
{ //if the key isn't the backspace key (which we should allow)
if ((unicode<48||unicode>57)) //if not a number
return false //disable key press
}
}
function isNumber1(e)
{
var unicode=e.charCode? e.charCode : e.keyCode
if (unicode!=8 &&  unicode!=43)
{ //if the key isn't the backspace key (which we should allow)
if ((unicode<48||unicode>57)) //if not a number
return false //disable key press
}
}
function ChangeCase()
{
document.LoginForm.FirstName.value = LoginForm.FirstName.value.toUpperCase();
document.LoginForm.MiddleName.value = LoginForm.MiddleName.value.toUpperCase();
document.LoginForm.LastName.value = LoginForm.LastName.value.toUpperCase();
document.LoginForm.HOUSENO.value = LoginForm.HOUSENO.value.toUpperCase();
document.LoginForm.STREET.value = LoginForm.STREET.value.toUpperCase();

document.LoginForm.DISTRICT.value = LoginForm.DISTRICT.value.toUpperCase();


document.LoginForm.TEHSIL.value = LoginForm.TEHSIL.value.toUpperCase();
document.LoginForm.DISTRICT.value = LoginForm.DISTRICT.value.toUpperCase();

document.LoginForm.CITY.value = LoginForm.CITY.value.toUpperCase();
document.LoginForm.FatherName.value = LoginForm.FatherName.value.toUpperCase();
document.LoginForm.MotherName.value = LoginForm.MotherName.value.toUpperCase();

}

function echeck(str) {

		var at="@";
		var dot=".";
		var lat=str.indexOf(at);
		var lstr=str.length;
		var ldot=str.indexOf(dot);

	

		if (str.indexOf(at)==-1){
		   alert("Invalid E-mail ID");
		   return false;
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Invalid E-mail ID");
		   return false;
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Invalid E-mail ID");
		    return false;
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Invalid E-mail ID");
		    return false;
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Invalid E-mail ID");
		    return false;
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Invalid E-mail ID");
		    return false;
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Invalid E-mail ID");
		    return false;
		 }
	
 		 return true	;				
	}

function button1_onclick()
{
if(document.LoginForm("chkDeclare").checked==false)
{
alert('Please Read declaration and click to accept the same');
return(false);
}

if(document.LoginForm.FirstName.value=='')
{
alert('First Name Should not be left blank');
LoginForm.FirstName.focus();
return(false);
}


if(document.getElementById("Gender1").checked==false && document.getElementById("Gender2").checked==false)
	{
		alert('Please Select Gender !');
		LoginForm.Gender1.focus();
		return(false);	
	}



var my =document.LoginForm.DOB_YYYY.value;
var mM =document.LoginForm.DOB_MM.value;
var mD =document.LoginForm.DOB_DD.value;
var mMaxday=0;

if(mM=='04' || mM=='06' || mM=='09' || mM=='11')
mMaxday=30;
else if(mM=='01' || mM=='03' || mM=='05' || mM=='07' || mM=='08' || mM=='10'|| mM=='12')
mMaxday=31;
else if(my%4==0 && mM=='02')
mMaxday=29;
else
mMaxday=28;

if(mD>mMaxday)
{
alert('Please enter correct Date of Birth');
document.LoginForm.DOB_DD.focus();
return(false);
}

var mDOB =document.LoginForm.DOB_YYYY.value+document.LoginForm.DOB_MM.value+document.LoginForm.DOB_DD.value;


if(parseInt(mDOB)<19891001)
{
alert('Date of Birth must fall on or after October 01,1989');
document.LoginForm.DOB_YYYY.focus();
return(false);
}


if(mD=="DD" )
	{
		alert("Please Select Date of Birth Day !");
		document.LoginForm.DOB_DD.focus();
		return false;
	}
	if( mM=="MM")
	{
		alert("Please Select Date of Birth Month!");
		document.LoginForm.DOB_MM.focus();
		return false;

	}
	if( my=="YYYY")
	{
		alert("Please Select Date of Birth Year !");
		document.LoginForm.DOB_YYYY.focus();
		return false;

	}

//alert(document.getElementById("Category").checked+"sdsd");
if(document.getElementById("Category1").checked==false && document.getElementById("Category2").checked==false && document.getElementById("Category3").checked==false && document.getElementById("Category4").checked==false)
	{
		alert('Please Select Category !');
		LoginForm.Category1.focus();
		return(false);	
	}


if(document.LoginForm.Institute3.checked==false && document.LoginForm.Institute2.checked==false && document.LoginForm.Institute1.checked==false)
	{
		alert('Please Select My Candidature for !');
		LoginForm.Institute1.focus();
		return(false);	
			
	}
if(document.LoginForm.QYear.value=="Select")
	{
		alert('Please Select Year of Qualifying Examination  !');
		LoginForm.QYear.focus();
		return(false);	
	}


if(document.LoginForm.MotherName.value=='' && document.LoginForm.FatherName.value=='' )
{
alert('Father Name or Mother Name Should not be left blank');
LoginForm.FatherName.focus();

return(false);
}


if(document.LoginForm.AIEEEROLL.value=='')
{
alert('AIEEE Roll no. can not be left blank');
LoginForm.AIEEEROLL.focus();
return(false);
}

var maieee=document.LoginForm.AIEEEROLL.value;



if(maieee.substring(0,1)!='2' || maieee.length!=8)
{
var c=confirm('Your AIEEE Roll no. seems to be wrong! Please recheck with AIEEE admit card before clicking OK.');
if(!c)
{

LoginForm.AIEEEROLL.focus();
return(false);
}
else
{
LoginForm.AIEEEROLL.focus();
return(false);
}

}



if(document.LoginForm.CADDRESS1.value=='')
{
alert('Complete Address Should not be left blank');
LoginForm.CADDRESS1.focus();
return(false);
}

if(document.LoginForm.CITY.value==''   )
{
alert('City Name should not be left blank');
LoginForm.CITY.focus();
return(false);
}

if(document.LoginForm.DISTRICT.value=='')
{
alert('District Should not be left blank');
LoginForm.DISTRICT.focus();
return(false);
}
if(document.LoginForm.CSTATE.value=='SelectState')
{
alert('Please Select State Name ');
LoginForm.CSTATE.focus();
return(false);
}

if(document.LoginForm.PADDRESS1.value=='')
{
alert('Permanent address of Should not be left blank');
LoginForm.PADDRESS1.focus();
return(false);
}

if(document.LoginForm.PCITY.value==''  )
{
alert('Permanent address of City Name should not be left blank');
LoginForm.PCITY.focus();
return(false);
}

if(document.LoginForm.PDISTRICT.value=='')
{
alert('Permanent address of District Should not be left blank');
LoginForm.PDISTRICT.focus();
return(false);
}

if(document.LoginForm.PSTATE.value=='SelectState1')
{
alert('Please Select Permanent State Name ');
LoginForm.PSTATE.focus();
return(false);
}


var lenpin=LoginForm.PIN.value.length;

if(lenpin < 6 && lenpin>=1 )
{
alert('PIN code cannot be less than 6 characters');
LoginForm.PIN.focus();
return(false);
}



var lenpin1=LoginForm.PPIN.value.length;

if(lenpin1 < 6 && lenpin1>=1 )
{
alert('Permanet address PIN code cannot be less than 6 characters');
LoginForm.PPIN.focus();
return(false);
}



//alert(document.getElementById("HIMACHAL").checked);

if(document.getElementById("HIMACHAL").checked==false && document.getElementById("HIMACHAL1").checked==false && document.LoginForm.Institute3.checked!=false && document.LoginForm.HP.checked==true)
	{
		alert('You have not selected Have you passed/appearing in your 10+2 examination from a school located in HimachalPradesh');
		return (false);
	}
/*
if(document.getElementById("HIMACHAL").checked==true && document.LoginForm.HP.checked==false)
	{
			
		var b=callMsgBox2('You have not selected HP category in para 5. Do you wish to be considered under HP Category .');
		if (b==6)
		{
		document.LoginForm.HP.checked=true;
		document.getElementById("HIMACHAL").checked=true;
		document.LoginForm.HP.focus();
		return false;
		}
		else
		{
		document.getElementById("HIMACHAL1").checked=true;
		// return false;
		}
	}*/

//if(document.getElementById("HIMACHAL").disabled=false;
//document.getElementById("HIMACHAL1").disabled=false;

/*if(document.getElementById("HIMACHAL").value=="Y" && document.LoginForm.HP.checked==false && document.LoginForm.Institute3.checked==true )
{

var b=callMsgBox2('You have not selected HP category in para 4. Do you wish to be considered under HP Category .');
if (b==6)
{
document.LoginForm.HP.checked=true;
document.getElementById("HIMACHAL").checked=true;
document.LoginForm.HP.focus();
return false;
}
else
{
document.getElementById("HIMACHAL1").checked=true;
// return false;
}

}*/




if(document.LoginForm.Institute1.checked==false &&  document.LoginForm.Institute2.checked==false && document.LoginForm.Institute3.checked==false)
{
alert(' Please Select Candidature for which you want to apply ');
document.LoginForm.Institute1.focus();
return(false);

}

//alert(document.LoginForm.EMAIL.value+"asdasd");
if(document.LoginForm.EMAIL.value!="")
	{
		if (echeck(document.LoginForm.EMAIL.value)==false){
				document.LoginForm.EMAIL.value="";
				document.LoginForm.EMAIL.focus();
				return false
			}
	}


ChangeCase();
}



function ChkJIIT()
{
//  alert(document.LoginForm.Institute1.checked+"sss");
/*
if(document.LoginForm.Institute1.checked==false )
	{
		alert("You are not considered for JIIT  ! ");

	}
	if(document.LoginForm.Institute2.checked==false )
	{
		alert("You are not considered for JIET  ! ");

	}*/


if(document.LoginForm.Institute1.checked==true ||  document.LoginForm.Institute2.checked==true )
{
document.LoginForm.HP.disabled=true;
//      document.LoginForm.HIMACHAL.disabled=true;
//      document.LoginForm.HIMACHAL1.disabled=true;
//document.getElementById("HIMACHAL").disabled=true
//document.getElementById("HIMACHAL1").disabled=true
}
else if(document.LoginForm.Institute1.checked==false ||  document.LoginForm.Institute2.checked==false )
{
document.LoginForm.HP.disabled=false;
//      document.LoginForm.HIMACHAL.disabled=true;
//document.LoginForm.HIMACHAL1.checked=true;
//document.getElementById("HIMACHAL").disabled=false;
//document.getElementById("HIMACHAL1").disabled=false;
}

if (document.LoginForm.Institute1.checked==true &&  document.LoginForm.Institute2.checked==true && document.LoginForm.Institute3.checked==true)
{
document.LoginForm.HP.disabled=false;
//      document.LoginForm.HIMACHAL.disabled=true;
//document.LoginForm.HIMACHAL1.checked=true;
//document.getElementById("HIMACHAL").disabled=false;
//document.getElementById("HIMACHAL1").disabled=false;
}

if ( document.LoginForm.Institute2.checked==true && document.LoginForm.Institute3.checked==true)
{
document.LoginForm.HP.disabled=false;
//      document.LoginForm.HIMACHAL.disabled=true;
//document.LoginForm.HIMACHAL1.checked=true;
//document.getElementById("HIMACHAL").disabled=false;
//document.getElementById("HIMACHAL1").disabled=false;
}
if ( document.LoginForm.Institute1.checked==true && document.LoginForm.Institute3.checked==true)
{
document.LoginForm.HP.disabled=false;
//      document.LoginForm.HIMACHAL.disabled=true;
//document.LoginForm.HIMACHAL1.checked=true;
//document.getElementById("HIMACHAL").disabled=false;
//document.getElementById("HIMACHAL1").disabled=false;
}
}



function ChkJUIT()
{

	/*if(document.LoginForm.Institute3.checked==false )
	{
		alert("You are not considered for JUIT  ! ");

	}
	*/
//  alert(document.getElementById("Institute1").value+"sss");
if(document.LoginForm.Institute3.checked==true  )
{
document.LoginForm.HP.disabled=false;

//document.getElementById("HIMACHAL").disabled=false;
//document.getElementById("HIMACHAL1").disabled=false;
}
else if (document.LoginForm.Institute3.checked==false  )
{
document.LoginForm.HP.disabled=true;
document.LoginForm.HP.checked=false;
     // document.LoginForm.HIMACHAL.disabled=true;
      //document.LoginForm.HIMACHAL1.disabled=true;
	  document.getElementById("HIMACHAL").checked=false
document.getElementById("HIMACHAL1").checked=false
document.getElementById("HIMACHAL").disabled=true
document.getElementById("HIMACHAL1").disabled=true
}

if (document.LoginForm.Institute1.checked==true &&  document.LoginForm.Institute2.checked==true && document.LoginForm.Institute3.checked==true)
{
document.LoginForm.HP.disabled=false;
//      document.LoginForm.HIMACHAL.disabled=true;
//document.LoginForm.HIMACHAL1.checked=true;
//document.getElementById("HIMACHAL").disabled=false;
//document.getElementById("HIMACHAL1").disabled=false;
}

}



function ChkHP()
{


/*
if(document.getElementById("HIMACHAL").value=="Y" && document.LoginForm.HP.checked==false)
{
var b=callMsgBox2('You have not selected HP category in para 4 Do you wish to be considered under HP Category .');

if (b==6)
{

document.LoginForm.HP.checked=true;
document.LoginForm.HP.focus();
}
else
{
document.LoginForm.HP.checked=false;

}
}*/

//alert("sdfdsf");
 if(document.getElementById("HIMACHAL").value=="Y")
	{
		document.LoginForm.Institute3.checked=true;  
		document.LoginForm.HP.disabled=false;
		//document.LoginForm.HP.checked=true;
		
	}

}



function ChkNoHP()
{
	//alert("sdfdsf");
if(document.getElementById("HIMACHAL1").value=="N" )
{

alert("You cannot be considered for H.P Quota because you have not qualified from the school located in H.P.");
document.LoginForm.HP.checked=false;
document.LoginForm.HP.disabled=true;
LoginForm.HIMACHAL1.focus();

/*var retVal = callMsgBox2('You cannot be considered for H.P Quota because you have not qualified from the school located in H.P.');

if (retVal == 6)
{

document.LoginForm.HP.checked=false;
document.LoginForm.HP.disabled=true;
LoginForm.HIMACHAL1.focus();
//return(true);
}
else
{
document.LoginForm.HP.checked=false;
LoginForm.HIMACHAL1.focus();
//return(false);
}
*/
}
}

function SelectInst()
{
	/*if(document.LoginForm.Institute3.checked==false && document.LoginForm.Institute2.checked==false && document.LoginForm.Institute1.checked==false)
	{
			document.LoginForm.Institute3.checked=true;
			document.LoginForm.Institute2.checked=true;
			document.LoginForm.Institute1.checked=true;
		//	document.LoginForm.HP.checked=true;
			//document.LoginForm.HIMACHAL1.checked=true;
	}*/

	if(document.LoginForm.Institute3.checked==false)
	{
			document.LoginForm.HP.disabled=true;
			document.getElementById("HIMACHAL").disabled=true;
			document.getElementById("HIMACHAL1").disabled=true;
	}
if (document.LoginForm.HP.checked==false)
	{
			document.getElementById("HIMACHAL").disabled=true;
			document.getElementById("HIMACHAL1").disabled=true;
	}

}

function HPCategory()
	{
		if (document.LoginForm.HP.checked==true)
		{
			document.getElementById("HIMACHAL").disabled=false;
			document.getElementById("HIMACHAL1").disabled=false;
		}
	
		if (document.LoginForm.HP.checked==false)
		{
			document.getElementById("HIMACHAL").disabled=true;
			document.getElementById("HIMACHAL1").disabled=true;
		}
	}


function Copy()
	{
	   
		if(document.LoginForm.Copythis.checked==true)
					{
								document.LoginForm.PADDRESS1.value=document.LoginForm.CADDRESS1.value;
								document.LoginForm.PCITY.value=document.LoginForm.CITY.value;
								document.LoginForm.PADDRESS2.value=document.LoginForm.CADDRESS2.value;
								document.LoginForm.PADDRESS3.value=document.LoginForm.CADDRESS3.value;
								document.LoginForm.PPIN.value=document.LoginForm.PIN.value;
								document.LoginForm.PDISTRICT.value=document.LoginForm.DISTRICT.value;
								document.LoginForm.PSTATE.value=document.LoginForm.CSTATE.value;

					}
	}

</SCRIPT>
<SCRIPT LANGUAGE=vbscript>
function callMsgBox2(strMsg){
callMsgBox2 = msgBox(strMsg,4,"Counselling:- Please Confirm")
}
</SCRIPT>

</head>
<BODY  bgcolor=#fce9c5  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  onLoad="SelectInst();">

<%

String mFName = "", mMName = "", mLName = "", mSex = "", mDOB_DD = "", mDOB_MM = "", mDOB_YYYY = "";
String mQYear = "", mCategory = "", mFatherName = "", mMotherName = "", mAIEEEROLL = "";
String  mCITY = "", mPIN = "", mDISTRICT = "";
String mCADDRESS1 = "", mCADDRESS2 = "",mCADDRESS3 ="", mMOBILE = "";
String mSTDCODE = "", mPHONENO = "", mEMAILID = "";
String mSTATE = "", mSTREET = "", mHOUSENO = "", mTEHSIL = "";
String mCSTATE = "", mPSTATE = "", mDATEOFBIRTH = "", mQHPEXAM = "", mOTHERCAT = "", mROLLAIEEE = "", mAPPINST = "";

String mAPPLNO = "", mAPPLID = "", mDDOB = "";
String DOBDD = "", DOBMM = "", DOBYY = "";
String qry = "", str1 = "", str11 = "", str12 = "";
String mCouns = "";
int mDOBMaxYear = 1989;
int mDOBMinYear = 2000;
String mFLAG = "",mInst="";
String mChkST="",mChkSC="",mChkGEN="",mOnlineConfirm="";
String mHYes="",mHNo="";
String mAPPJIIT="",mAPPJUIT="",mAPPJIET="";
String mCheck1="N",mCheck2="N",mCheck3="N";
String  mPHOUSENO ="",mPCITY ="", mPTEHSIL ="",mPSTREET="",mPPIN="",mPDISTRICT="";
// session.setAttribute("Institute", mInst);







qry = "SELECT DISTINCT NVL (a.counsellingid, ' ') counsellingid,                NVL (a.applicationid, ' ') applicationid,                NVL (a.applicationno, ' ') applicationno,                NVL (a.firstname, ' ') firstname,                NVL (a.middlename, ' ') middlename,                NVL (a.lastname, ' ') lastname,                NVL (a.fathername, ' ') fathername,                NVL (a.mothername, ' ') mothername, NVL (a.ccity, ' ') ccity,                NVL (a.caddress1, ' ') caddress1,                NVL (a.caddress3, ' ') caddress3,                NVL (a.caddress2, ' ') caddress2,                NVL (a.district, ' ') district,                NVL (a.cstatecode, ' ') cstatecode,                NVL (a.paddress1, ' ') paddress1,                NVL (a.paddress3, ' ') paddress3,                NVL (a.pdistrict, ' ') pdistrict,                NVL (a.pstatecode, ' ') pstatecode,                NVL (DECODE (a.ppin, '', ' ', a.ppin), ' ') ppin,                NVL (a.pdistrict, ' ') pdistrict,                NVL (DECODE (a.ppin, '', ' ', a.ppin), ' ') ppin,                NVL (a.phoneno, ' ') phoneno, NVL (a.mobileno, ' ') mobileno,                NVL (a.email, ' ') email, NVL (a.sex, ' ') sex,                TO_CHAR (a.dateofbirth, 'DD-MM-YYYY') dateofbirth,                a.yearofqualifyingexam yearofqualifyingexam,                NVL (a.qualifiedexamfromhp, 'N') qualifiedexamfromhp,                NVL (a.categorycode, ' ') categorycode,                NVL (a.othercategory, ' ') othercategory,                NVL (a.applicationconfirmed, ' ') applicationconfirmed,                NVL (b.rollnoofaieee, ' ') rollnoofaieee,                NVL (b.onlineconfirmation, ' ') onlineconfirmation             FROM c#applicationmaster a,                c#applicationmasterdetail b                     WHERE a.counsellingid = b.counsellingid(+)            AND a.applicationid = b.applicationid(+) " + "  AND A.COUNSELLINGID='" + mCOUNSID + "' and a.applicationid= '" + mLoginID + "' ";
 //out.print(qry);
rs = db.getRowset(qry);
while (rs.next()) {


mAPPLNO = rs.getString("applicationno").toString().trim();
mAPPLID = rs.getString("applicationid").toString().trim();
mFName = rs.getString("firstname").toString().trim();
mMName = rs.getString("middlename").toString().trim();
mLName = rs.getString("lastname").toString().trim();
mFatherName = rs.getString("fathername").toString().trim();
mMotherName = rs.getString("mothername").toString().trim();


mCITY = rs.getString("ccity").toString().trim();
mDISTRICT = rs.getString("district").toString().trim();
mCSTATE = rs.getString("cstatecode").toString().trim();


mPDISTRICT = rs.getString("pdistrict").toString().trim();
mPPIN = rs.getString("ppin").toString().trim();
mPSTATE = rs.getString("pstatecode").toString().trim();


mPHONENO = rs.getString("phoneno").toString().trim();
mMOBILE = rs.getString("mobileno").toString().trim();
mEMAILID = rs.getString("email").toString().trim();
mSex = rs.getString("sex").toString().trim();

mQYear = rs.getString("yearofqualifyingexam").toString().trim();
mQHPEXAM = rs.getString("qualifiedexamfromhp").toString().trim();
mCategory = rs.getString("categorycode").toString().trim();
mAIEEEROLL = rs.getString("rollnoofaieee").toString().trim();
mOnlineConfirm = rs.getString("ONLINECONFIRMATION").toString().trim();
mDDOB = rs.getString("dateofbirth").toString().trim();


DOBDD = mDDOB.substring(0, 2);
DOBMM = mDDOB.substring(3, 5);
DOBYY = mDDOB.substring(6, 10);


}


%>


<TABLE align=center border=2 bordercolor=red >
<TR>
	<TD>
	<CENTER><B><FONT SIZE="3" COLOR="Red">Filled-Application Form of &nbsp;<%=mFName%>&nbsp;<%=mMName%>&nbsp;<%=mLName%> (<%=mAPPLID%>)</FONT></B></CENTER>
	
	</TD>
</TR>
</TABLE>

<table   cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"    valign="middle" align=center   width="100%">



</table>

<table width="98%" bordercolor=black   border="1" cellpadding="2" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center  border=1 >
<input type="hidden" name="APPNO" id="APPNO" value="<%=mAPPLNO%>">



<input type="hidden" name="APPID" id="APPID" value="<%=mAPPLID%>">

<tr><td nowrap colspan="3" class="tablecell">1. Name of Candidate (IN CAPITAL LETTERS) </td></tr>
<tr>
<td  colspan="3"  ALIGN="left" class="tablecell" >  &nbsp;&nbsp;&nbsp;(First)<FONT face="Times New Roman"
color=#ff4500>*</FONT><INPUT value="<%=mFName%>" ID="FirstName" Name="FirstName"
tabIndex=1 LANGUAGE=javascript maxlength="18"  onfocusout="return ChangeCase()"
>
&nbsp;&nbsp;&nbsp;(Middle)<INPUT value="<%=mMName%>" ID="MiddleName" Name="MiddleName"
tabIndex=2  LANGUAGE=javascript maxlength="15" onfocusout="return ChangeCase()"
>
&nbsp;&nbsp;&nbsp;(Last)<INPUT value="<%=mLName%>" ID="LastName" Name="LastName"
tabIndex=3  LANGUAGE=javascript maxlength="15" onfocusout="return ChangeCase()"
></td>
</tr>

<tr>
<td nowrap colspan="3" class="tablecell" >2. Gender
(Check)<FONT color=tomato>*</FONT>

<%
if (mSex.equals("F")) {
%>
<INPUT Type="radio" ID="Gender1" Name="Gender" Value="M"  tabIndex=4>Male
<INPUT Type="radio" ID="Gender2" Name="Gender" checked Value="F"
tabIndex=5>Female
<%        } else if (mSex.equals("M")) {
%>
<INPUT Type="radio" ID="Gender1" Name="Gender" Value="M" checked tabIndex=4>Male
<INPUT Type="radio" ID="Gender2" Name="Gender" Value="F"
tabIndex=5>Female</FONT><FONT face=Verdana>
</FONT>
<%    }
else {
%>
<INPUT Type="radio" ID="Gender1" Name="Gender" Value="M"  tabIndex=4>Male
<INPUT Type="radio" ID="Gender2" Name="Gender" Value="F"
tabIndex=5>Female</FONT><FONT face=Verdana>
</FONT>
<%    }
%>
</td>
</tr>
<tr>

<td colspan="3" class="tablecell">

3. Date of Birth  <B>(Not , before 1st OCT,1989)</B><FONT
face="Times New Roman"
color=#ff4500>*</FONT>

&nbsp; Day</FONT>
<select Name="DOB_DD" tabIndex=6>
<option  Value="DD">DD</option>
<%
for (int jp = 1; jp <= 31; jp++) {
str1 = String.valueOf(jp);
if (jp < 10) {
str1 = "0" + str1;
}
if (mDOB_DD.equals(str1) || DOBDD.equals(str1)) {
%>
<option selected Value="<%=str1%>"><%=str1%></option>
<%
} else {
%>
<option Value="<%=str1%>"><%=str1%></option>
<%
}

}
%>
</select><FONT face=Verdana>
Month</FONT>
<select Name="DOB_MM"
tabIndex=7>
<option  Value="MM">MM</option>
<%
for (int jp = 1; jp <= 12; jp++) {
str1 = String.valueOf(jp);
if (jp < 10) {
str1 = "0" + str1;
}
if (mDOB_MM.equals(str1) || DOBMM.equals(str1)) {
%>
<option selected Value="<%=str1%>"><%=str1%></option>
<%
} else {
%>
<option Value="<%=str1%>"><%=str1%></option>
<%
}
}
%>
</select><FONT face=Verdana>
Year</FONT>
<select Name="DOB_YYYY"
tabIndex=8>
<option  Value="YYYY">YYYY</option>
<%
int jp = mDOBMaxYear;
for (; jp <= mDOBMinYear; jp++) {
str1 = String.valueOf(jp);
if (mDOB_YYYY.equals(str1) || DOBYY.equals(str1)) {
%>
<option selected Value="<%=str1%>"><%=str1%></option>
<%
} else {
%>
<option Value="<%=str1%>"><%=str1%></option>
<%
}


}
%>

</select>
<!-- <FONT
face=Verdana size=1><STRONG>(Date of Birth must fall on or after October
01,1988)</STRONG></FONT> -->

</td>
</tr>
<tr>
<td  class="tablecell" >
4. Category<FONT face="Times New Roman"
color=#ff4500>*</FONT>

<%

if (mCategory.equals("ST"))
{
mChkST="checked";
}
else if (mCategory.equals("OBC"))
{
mChkOBC="checked";
}
else if (mCategory.equals("SC"))
{
mChkSC="checked";
}
else  if (mCategory.equals("GEN"))
{
mChkGEN="checked";
}


%>

&nbsp;&nbsp;&nbsp;&nbsp;  <INPUT Type="radio" ID="Category1" Name="Category" Value="GEN" <%=mChkGEN%> tabIndex=9>General (GEN)
<INPUT Type="radio"  ID="Category2" Name="Category" Value="SC" <%=mChkSC%> tabIndex=10>SC
<INPUT Type="radio" ID="Category3" Name="Category" Value="ST" <%=mChkST%> tabIndex=11>ST
<INPUT Type="radio"  ID="Category4" Name="Category" Value="OBC" <%=mChkOBC%> tabIndex=12>OBC
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;





</td>
</tr>
<%


if(mAPPJIIT.equals("Y") )
{
mCheck1="Checked";
}

if(mAPPJIET.equals("Y"))
{
mCheck2="Checked";
}
if(mAPPJUIT.equals("Y"))
{
mCheck3="Checked";
}



if(mQHPEXAM.equals("Y") )
{
mHYes="checked";
}
else if( mQHPEXAM.equals("N") )
{
mHNo="checked";
}

%>


<tr>
<td  class=tablecell>5.<STRONG>  Please Consider my Candidature for</FONT></STRONG><FONT color=#ff4500>*</FONT>

<br>
<input type="CHECKBOX"  name="Institute1" id="Institute1" VALUE="JIIT" <%=mCheck1%>  onclick="return ChkJIIT();"  tabIndex=12 >
<font size="2" face="verdana" color="green"><b>JIIT </b></font>
&nbsp;
<input type="CHECKBOX"  name="Institute2" id="Institute2" VALUE="JIET" <%=mCheck2%>  onclick="return ChkJIIT();"  tabIndex=12>	
<font size="2" face="verdana" color="green"><b>JIET</b></font>
&nbsp;
<input type="CHECKBOX"  name="Institute3" id="Institute3" VALUE="JUIT" <%=mCheck3%>  onclick="return ChkJUIT();" tabIndex=12>
<font size="2" face="verdana" color="green"><b>JUIT</b></font>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<B>Consider me for Himachal Pradesh(H.P) Category Quota</B>
<%
if(mQHPEXAM.equals("Y"))
{
%>
<INPUT Type="checkbox" checked ID="HP" Name="HP" onclick="return HPCategory();" Value="Y" tabIndex=13>
<%
}
else
{
%>
<INPUT Type="checkbox"  ID="HP" Name="HP" Value="Y" onclick="return HPCategory();" tabIndex=13>	
<%
}
%>
</td>
</tr>
<tr><td class="tablecell">

Have you passed/appearing in your 10+2 examination from a school located in <B>HimachalPradesh(Tick)</b><FONT color=#ff4500>*</FONT>

<INPUT Type="radio"   ID="HIMACHAL" Name="HIMACHAL" Value="Y" <%=mHYes%> onclick="return ChkHP();" tabIndex=14>Yes
<INPUT Type="radio"   ID="HIMACHAL1" Name="HIMACHAL" Value="N" <%=mHNo%>  onClick="return ChkNoHP();" tabIndex=14>No
<br>
<%


/*else
{
mHNo="checked";
}*/

%>


<br>
</td>



</tr>

<tr>
<td colspan=3 class="tablecell">6. Year of Qualifying
Examination<FONT color=#ff4500>*</FONT> <select Name="QYear"  ID="QYear" tabIndex=14>
<%
if (mQYear.equals("2011")) {
%>


<OPTION Value="2008">2008
<OPTION Value="2009">2009
<OPTION Value="2012">2012
<OPTION selected Value="2011">2011</OPTION>
<%  
	} else if (mQYear.equals("2009")) {
%>

<OPTION  Value="2008">2008
<OPTION selected Value="2009">2009
<OPTION Value="2011">2011
<OPTION Value="2012">2012
</OPTION>
<%  
	} else if (mQYear.equals("2012")) {
%>

<OPTION  Value="2008">2008
<OPTION selected Value="2012">2012
<OPTION  Value="2009">2009
<OPTION Value="2011">2011
</OPTION>

<%  
	} else if (mQYear.equals("2008")){
%>

<OPTION selected Value="2008">2008
<OPTION   Value="2009">2009
<OPTION   Value="2012">2012
<OPTION  Value="2011">2011
</OPTION>
<% 
	}
else
	{
%>
<OPTION   Value="Select"><--Select Exam-->
<OPTION  Value="2008">2008
<OPTION   Value="2009">2009
<OPTION   Value="2012">2012
<OPTION  Value="2011">2011
</OPTION>
<% 
	}
%>
</select>
<br>
<b>(Passed 10+2 or its
equivalent exam not before year 2008)</b>
</td>
</tr>
<tr>
<td colspan=3 align=left class="tablecell"><FONT face=Verdana> 7. Father's Name <FONT
face="Times New Roman" color=#ff4500>*</FONT>  &nbsp;&nbsp; &nbsp;</FONT>   <INPUT size=60 value="<%=mFatherName%>" onfocusout="return ChangeCase()" maxlength=80 Id="FatherName" Name="FatherName"
tabIndex=14><FONT
face=Verdana></FONT>
</td>
</tr>
<TR>
<td colspan=3 align=left class="tablecell"><FONT face=Verdana>8. Mother's Name <FONT
color=#ff4500>*</FONT>&nbsp; &nbsp;&nbsp;</FONT>   <INPUT size=60 value="<%=mMotherName%>" onfocusout="return ChangeCase()" maxlength=80 Id="MotherName" Name="MotherName" tabIndex=15>
</td></TR>

<tr>
<td colspan=3 class="tablecell" nowrap>9. AIEEE 2011 Roll
Number<FONT color=#ff4500>* </font>
<INPUT size=10 value="<%=mAIEEEROLL%>" maxlength=8 Id="AIEEEROLL" Name="AIEEEROLL" tabIndex=16 onkeypress="return isNumber(event)">&nbsp; 
</td>
</tr>
<tr><td nowrap >
<table border="1" cellpadding="2" cellspacing="0" style="FONT-SIZE: x-small"  align=left  rules=groups >

<tr>
<td class="tablecell"  nowrap>10 a. Complete mailing address of the candidate.
<BR>&nbsp;
<table border="1" cellpadding="2" cellspacing="0" style="FONT-SIZE: x-small"   align=left rules=groups >
<tr><td  class="tablecell">Address 1<FONT color=#ff4500>*</FONT>
</td>          
<td>  
<input value="<%=mCADDRESS1%>" ID="CADDRESS1" Name="CADDRESS1" MaxLength=50 Size=30 tabIndex=17  LANGUAGE=javascript onfocusout="return ChangeCase()">
</td></tr>
<tr><td  class="tablecell">Address 2
</td>     
<td>
<input ID="CADDRESS2" Name="CADDRESS2" value="<%=mCADDRESS2%>"
MaxLength=50 Size=30 tabIndex=18 LANGUAGE="javascript" onfocusout="return ChangeCase()"></td>
</tr>
</tr>
<tr><td class="tablecell" nowrap>Address 3 <FONT color=#ff4500>*</FONT>
</td>
<td>
<input type="text" ID="CADDRESS3" Name="CADDRESS3" value="<%=mCADDRESS3%>" tabIndex=19 size="30" maxlength="50"  onfocusout="return ChangeCase()">
</td>
</tr>
<tr>
<td class="tablecell" nowrap >City
</td>
<td>
<input value="<%=mCITY%>" ID="CITY" Name="CITY" MaxLength=25 Size=30 tabIndex=20 LANGUAGE=javascript onfocusout="return ChangeCase()">
</td></tr>

<tr><td class="tablecell">
PIN </td>
<td><input type="text" name="PIN" id ="PIN" onkeypress="return isNumber(event)" value="<%=mPIN%>" tabindex="21" size="10" maxlength="6">
</td>
</tr>
<td class="tablecell"  nowrap><FONT face=Verdana size=2>District<FONT color=#ff4500>*</FONT>
</td>
<td>  <input value="<%=mDISTRICT%>" ID="DISTRICT" Name="DISTRICT" MaxLength=25 Size=25 tabIndex=22 LANGUAGE=javascript onfocusout="return ChangeCase()">
</td></tr>
<tr><td class="tablecell" >
State Name(Code) <FONT color=#ff4500>*</FONT></td>
<td> <SELECT ID="CSTATE" Name="CSTATE" tabIndex=23>
<option Value="SelectState"><--Select State Name-->
<%
qry = "Select STATENAME,STATECODE FROM C#STATEMASTER order by STATENAME";
Rs = db.getRowset(qry);

while (Rs.next()) {
if (Rs.getString("STATECODE").equals(mCSTATE)) {
%>
<option selected Value="<%=Rs.getString("STATECODE")%>"><%=Rs.getString("STATENAME")%> (<%=Rs.getString("STATECODE")%>)
<%
} else {
%>
<option Value="<%=Rs.getString("STATECODE")%>"><%=Rs.getString("STATENAME")%> (<%=Rs.getString("STATECODE")%>)
<%
}
}
%>
</SELECT>


</td>
</tr>
</table>
</table>
<!-- </td>




<td nowrap align=left> -->

<table border="1" cellpadding="2" cellspacing="0" align=right valign=top style="FONT-SIZE: x-small"    rules=groups >

<tr>
<td class="tablecell" colspan=10 nowrap>10 b. Permanent mailing address of the candidate . 
 <br> <input type=checkbox name="Copythis" id="Copythis"  onclick="Copy();" ><font size=1><b>Permanent Address is same as Contact Address	</b>

<table border="1" cellpadding="2" cellspacing="0" style="FONT-SIZE: x-small"   align=right valign=top rules=groups >
<tr><td  class="tablecell">Address 1<FONT color=#ff4500>*</FONT>
</td>
<td>
<input value="<%=mPADDRESS1%>" ID="PADDRESS1" Name="PADDRESS1" MaxLength=50 Size=30 tabIndex=24  LANGUAGE=javascript onfocusout="return ChangeCase()"> 
</td></tr>
<tr><td  class="tablecell">Address 2
</td>
<td>
<input ID="PADDRESS2" Name="PADDRESS2" value="<%=mPADDRESS2%>"
MaxLength=50 Size=30 tabIndex=25 LANGUAGE=javascript onfocusout="return ChangeCase()"></td>
</tr>
</tr>

<tr>
<td class="tablecell" nowrap >Address 3
</td>
<td>
<input value="<%=mPADDRESS3%>" ID="PADDRESS3" Name="PADDRESS3" MaxLength=25 Size=30 tabIndex=27 LANGUAGE=javascript onfocusout="return ChangeCase()">
</td></tr>


<tr><td class="tablecell" nowrap>City<FONT color=#ff4500>*</FONT>
</td>
<td>
<input type="text" ID="PCITY" Name="PCITY" tabIndex=26 size="30" maxlength="25" value="<%=mPCITY%>" onfocusout="return ChangeCase()"> 
</td>
</tr>

<tr><td class="tablecell" >
PIN </td>
<td><input type="text" name="PPIN" id ="PPIN" onkeypress="return isNumber(event)" value="<%=mPPIN%>" tabindex="28" size="10" maxlength="6">
</td>
</tr>
<td class="tablecell"  nowrap><FONT face=Verdana size=2>District <FONT color=#ff4500>*</FONT>
</td>
<td>  <input value="<%=mPDISTRICT%>" ID="PDISTRICT" Name="PDISTRICT" MaxLength=25 Size=25 tabIndex=29 LANGUAGE=javascript onfocusout="return ChangeCase()"> 
</td></tr>
<tr><td class="tablecell" >
State Name(Code) <FONT color=#ff4500>*</FONT></td>
<td> <SELECT ID="PSTATE" Name="PSTATE" tabIndex=30>
<option Value="SelectState1"><--Select State Name-->
<%
qry = "Select STATENAME,STATECODE FROM C#STATEMASTER order by STATENAME";
Rs = db.getRowset(qry);

while (Rs.next()) {
if (Rs.getString("STATECODE").equals(mPSTATE)) {
%>
<option selected Value="<%=Rs.getString("STATECODE")%>"><%=Rs.getString("STATENAME")%> (<%=Rs.getString("STATECODE")%>)
<%
} else {
%>
<option Value="<%=Rs.getString("STATECODE")%>"><%=Rs.getString("STATENAME")%> (<%=Rs.getString("STATECODE")%>)
<%
}
}
%>
</SELECT>


</td>
</tr>
</table>
</table>
</td>
</tr>


<tr>
<td nowrap class="tablecell" colspan="5">11. Contact Details

<table width="98%" border="1" cellpadding="2" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups >
<tr>
<td class="tablecell">Telephone Number
STDCode<input value="<%=mSTDCODE%>" ID="STDCODE" Name="STDCODE" MaxLength=10 Size=7 tabIndex=31 onkeypress="return isNumber(event)" ></FONT>
Phone No.<input value="<%=mPHONENO%>" ID="PHONENO" Name="PHONENO" MaxLength=30 Size=20 tabIndex=32 onkeypress="return isNumber(event)"></FONT>
</tr>
<tr>
<td class="tablecell" >
Mobile No.
&nbsp;&nbsp;&nbsp;&nbsp; <input value="<%=mMOBILE%>" ID="MOBILENO" Name="MOBILENO" MaxLength=35 Size=15 tabIndex=33 >

</td>

</tr>
<tr>
<td nowrap class="tablecell" >
Email Address <INPUT value="<%=mEMAILID%>" ID="EMAIL" Name="EMAIL"  maxLength=80 size=50 tabIndex=34>
</td>
</tr>
</table>
</td>
</tr>








<br>


</center>


<%  

} catch (Exception e) {
}

%>
</form>
</BODY></HTML>