
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JUET ";
%>
<HTML>
<head>

<style type="text/css"> 
body{

scrollbar-3dlight-color:#ffd700;
scrollbar-arrow-color:#ff0; 
scrollbar-base-color:#000ff0;
scrollbar-darkshadow-color:#000000; 
scrollbar-face-color:#de6400; 
scrollbar-highlight-color:#9900005;
scrollbar-shadow-color:#f0f

} 
</style> 

<TITLE>#### <%=mHead%> [Change Contact information] </TITLE>
  <script language="JavaScript" type ="text/javascript">
	<!-- 
	  if (top != self) top.document.title = document.title;
	-->
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
<SCRIPT TYPE="text/javascript">
<!--
// copyright 1999 Idocs, Inc. http://www.idocs.com
// Distribute this script freely but keep this notice in place
function numbersonly(myfield, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

// control keys
if ((key==null) || (key==0) || (key==8) || 
    (key==9) || (key==13) || (key==27) )
   return true;

// numbers
else if ((("0123456789.").indexOf(keychar) > -1))
   return true;

// decimal point jump
else if (dec && (keychar == "."))
   {
   myfield.form.elements[dec].focus();
   return false;
   }
else
   return false;
}
//Year of Passing validate
function yearofPass(slno)
{
//alert(document.getElementById("yearofpassing"+slno).value.length+"dd");
if(document.getElementById("yearofpassing"+slno).value.length <4 )
{
alert("Please Enter correct Year of Passing");
document.getElementById("yearofpassing"+slno).value="";
return(false);
//document.getElementById("yearofpassing"+slno).focus();
}
}


function percentage(DPERCENT,slno)
	{
	if(DPERCENT<33)
	{
			 alert('Percentage should be greater than 33 ');
			 document.getElementById("PerMarks"+slno).value="";
			  return false;
	}

if(DPERCENT>100.0)
	{
			 alert('Percentage should be less than 100 ');
			 document.getElementById("PerMarks"+slno).value="";
			  return false;
	}
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

    }


//-->
</SCRIPT>
<script language = "Javascript">


function ValidateForm(){
	var emailID=document.frm.SEMail
	
	if ((emailID.value==null)||(emailID.value=="")){
		alert("Please Enter your Email ID")
		emailID.focus()
		return false
	}
	if (echeck(emailID.value)==false){
		emailID.value=""
		emailID.focus()
		return false
	}
	return true
 }
</script>

</head>
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<%
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="",bankCode="",bankName="";
String mInstC="",mWebEmail="",mMemberID="",mADDRESS1="",mADDRESS2="",mADDRESS3="";
String mMem="",mCITY="",mPIN="",mPOSTOFFICE="",mRAILSTATION="";
String mMemID="",mPOLSTATION="",mDISTRICT="",mSTATE="";
String mDID="";
String qry="",qry1="";
String mScellNo="",mMemberType="";
String mStelNo="";
String mSstd="";
String mSemail="";
String mPcellNo="";
String mPstd="";
String mPtelNo="";
String mPemail="",mInst="",mCD="";
String x="";
ResultSet rs=null,rsi=null,rs1=null,rs2=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String qualificationcode ="";
String mCat="",catDesc="";
int slno=0;
    String catcode=""       ;
            
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
if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}

if(session.getAttribute("MemberCode")==null)
{
	mMem="";	
}
else
{
	mMem=session.getAttribute("MemberCode").toString().trim();
}
if(session.getAttribute("MemberID")==null)
{
	mMemID="";	
}
else
{
	mMemID=session.getAttribute("MemberID").toString().trim();
}
if(session.getAttribute("MemberID")==null)
{
	mMemberID="";	
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	OLTEncryption enc=new OLTEncryption();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
	mCD=enc.decode(session.getAttribute("MemberCode").toString().trim());
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
    String dateofBirth="",fatherName="",motherName="",nationality="",parentEdu="",category="",parentOccupation="",bloodGroup="",bankAccountNo="",BankCode="", parentDesg="";
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();


if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;


if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('29','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
qry=" select nvl(to_char(s.dateofbirth,'dd-mm-yyyy'),'') dateofbirth,nvl(s.fathername,'') fathername," +
        "nvl(s.mothername,'') mothername,nvl(s.nationality,'') nationality,nvl(s.category,'') category," +
        "nvl(PARENTOCCUPATION,'') PARENTOCCUPATION,nvl(s.BLOODGROUP,'') BLOODGROUP," +
        "nvl(s.BANKACCOUNTNUMBER,'') BANKACCOUNTNUMBER,nvl(s.BANKCODE,'') BANKCODE," +
        "nvl(s.PARENTDESIGNATION,'') PARENTDESIGNATION,nvl(s.PARENTEDUCATIONALBACKGROUND,'') parentedu from studentmaster s where studentid='" +mDID+ "'";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
dateofBirth=rs.getString("dateofbirth")==null?"":rs.getString("dateofbirth").trim();
fatherName=rs.getString("fathername")==null?"":rs.getString("fathername").trim();
motherName=rs.getString("mothername")==null?"":rs.getString("mothername").trim();
nationality=rs.getString("nationality")==null?"":rs.getString("nationality").trim();
category=rs.getString("category")==null?"":rs.getString("category").trim();
parentOccupation=rs.getString("PARENTOCCUPATION")==null?"":rs.getString("PARENTOCCUPATION").trim();
bloodGroup=rs.getString("BLOODGROUP")==null?"":rs.getString("BLOODGROUP").trim();
bankAccountNo=rs.getString("BANKACCOUNTNUMBER")==null?"":rs.getString("BANKACCOUNTNUMBER").trim();
BankCode=rs.getString("BANKCODE")==null?"":rs.getString("BANKCODE").trim();
parentDesg=rs.getString("PARENTDESIGNATION")==null?"":rs.getString("PARENTDESIGNATION").trim();
parentEdu=rs.getString("parentedu")==null?"":rs.getString("parentedu").trim();

}

qry="select nvl(StStdCode,' ') Sstd, nvl(StTelNo,' ') sTel,nvl(StCellNo,' ') SCell,nvl(StEmailid,' ') sEmail,nvl(PaStdCode,' ') Pstd, nvl(PaTelNo,' ') pTel,nvl(PaCellNo,'') pCell, nvl(PaEmailid,' ') pEmail from Studentphone where STUDENTID='" +mDID+ "'";
rs=db.getRowset(qry);
if ( rs.next())
{
	if (rs.getString("SCell")==null)
		mSCellNo="";
	else
	   	mSCellNo=rs.getString("SCell");

	if (rs.getString("pCell")==null)
		 mPCellNo="";
	else
		 mPCellNo=rs.getString("pCell");

	if(rs.getString("SSTD")==null)
		 mSstd="";
	else
		mSstd=rs.getString("SSTD");

	if(rs.getString("PSTD")==null)
		 mPstd="";
	else
		mPstd=rs.getString("PSTD");

	if(rs.getString("sTel")==null)
		 mSTelNo="";
	else
		mSTelNo=rs.getString("sTel");

	if(rs.getString("pTel")==null)
		mPTelNo="";
	else
		mPTelNo=rs.getString("pTel");

	if(rs.getString("sEmail")==null)
		 mSEmail=rs.getString("sEmail");
	else
		 mSEmail=rs.getString("sEmail");

	if(rs.getString("pEmail")==null)
		 mPEmail=rs.getString("pEmail");
	else
		 mPEmail=rs.getString("pEmail");
	
 }
 qry="SELECT NVL(CADDRESS1,' ')ADDRESS1, NVL(CADDRESS2,' ')ADDRESS2,NVL(CADDRESS3,' ')ADDRESS3,NVL(CCITY,' ')CITY,NVL(CPIN,'')PIN," +
         "NVL(CDISTRICT,' ')DISTRICT,NVL(CPOSTOFFICE,' ')POSTOFFICE,NVL(CRAILSTATION,' ')RAILSTATION,NVL(CPOLICESTATION,' ')POLSTATION," +
         " NVL(CSTATE,' ')STATE FROM STUDENTADDRESS WHERE STUDENTID='" +mDID+ "'";
// out.print(qry);
 rs=db.getRowset(qry);
 if(rs.next())
		   {
	 if (rs.getString("ADDRESS1").equals(" "))
		mADDRESS1=" ";
	else
	   	mADDRESS1=rs.getString("ADDRESS1");

	if (rs.getString("ADDRESS2").equals(" "))
		mADDRESS2=" ";
	else
	   	mADDRESS2=rs.getString("ADDRESS2");
	if (rs.getString("ADDRESS3").equals(" "))
		mADDRESS3=" ";
	else
	   	mADDRESS3=rs.getString("ADDRESS3");
	
	if (rs.getString("CITY").equals(" "))
		mCITY=" ";
	else
	   	mCITY=rs.getString("CITY");
	if (rs.getString("PIN")==null)
		mPIN="";
	else
	   	mPIN=rs.getString("PIN");
	if (rs.getString("DISTRICT").equals(" "))
		mDISTRICT=" ";
	else
	   	mDISTRICT=rs.getString("DISTRICT");
	if (rs.getString("POSTOFFICE").equals(" "))
		mPOSTOFFICE=" ";
	else
	   	mPOSTOFFICE=rs.getString("POSTOFFICE");
	if (rs.getString("RAILSTATION").equals(" "))
		mRAILSTATION=" ";
	else
	   	mRAILSTATION=rs.getString("RAILSTATION");
	if (rs.getString("POLSTATION").equals(" "))
		mPOLSTATION=" ";
	else
	   	mPOLSTATION=rs.getString("POLSTATION");
	if (rs.getString("STATE").equals(" "))
		mSTATE=" ";
	else
	   	mSTATE=rs.getString("STATE");

		   }
%>
<form name="frm"  method="post" action="StudModifyEmailIDTelephoneActionNEW.jsp" onSubmit="return ValidateForm();">
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"><B>Change Student/Parent Information</B></font>
</td>
</tr>
</TABLE>

<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
	rsi=db.getRowset(qry);
	while(rsi.next())
	{
		mInstC=rsi.getString("IC");
	}

  /*
 date of birth
-mother name
-nationality
-bloodgroup
-bank a/c number
-bank name
-parent /guardian occuption
-parent /guardian designation
-parent educational background
-annual income
-state of domicile
-mother tongue
-reigon
  */
String mDOB="",MotherName="",FatherName="",Nationality="",BankACNo="",BankName="",POcc="",PDesg="",PEdu="",BloodGroup="";

%>
<TABLE cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; 
	FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>

     <TR align="middle" bgcolor="#ff8c00">
		<TD colspan="4"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Student Personal Detail</STRONG></FONT></P></TD>
		
	</TR>


	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Date of Birth :</FONT></FONT></TD>
		
		<td><INPUT ID="DOB" Name="DOB" Type="text" value="<%=dateofBirth%>" style="WIDTH: 80px; HEIGHT: 22px" maxLength=10><FONT COLOR="GREEN">
            
        <B>(DD-MM-YYYY) </B></FONT>  </td>

        <TD><FONT color=black face=Arial size=2>&nbsp;Parents/Guardian Occupation :</FONT></TD>

		<td><INPUT ID="POcc" Name="POcc" Type="text" value="<%=parentOccupation%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=30></td>
	</TR>


    <TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Father Name:</td>
		
		<td><INPUT ID="FatherName" Name="FatherName" Type="text" value="<%=fatherName%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=60></td>

        <TD><FONT color=black face=Arial size=2>&nbsp;Parents/Guardian Designation :<FONT color=black>&nbsp;<%=PDesg%> </FONT></FONT></TD>

		<td><INPUT ID="PDesg" Name="PDesg" Type="text" value="<%=parentDesg%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=60></td>
	</TR>

     <TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Mother Name</FONT></TD>
		
		<td><INPUT ID="MotherName" Name="MotherName" Type="text" value="<%=motherName%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=60></td>

        <TD><FONT color=black face=Arial size=2>&nbsp;Parents Educational Background :</FONT></TD>

		<td><INPUT ID="PEdu" Name="PEdu" Type="text" value="<%=parentEdu%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
	</TR>

     <TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Nationality</FONT></TD>
	
		<td><INPUT ID="Nationality" Name="Nationality" Type="text" value="<%=nationality%>" style="WIDTH: 100px; HEIGHT: 22px" maxLength=30></td>


		<TD><FONT color=black face=Arial size=2>&nbsp;Blood Group</FONT></TD>

		<td><INPUT ID="BloodGroup" Name="BloodGroup" Type="text" value="<%=bloodGroup%>" style="WIDTH: 60px; HEIGHT: 22px" maxLength=3>
            like (A,A+,B,B+ etc..)
            </td>

	</TR>


 <TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Category</FONT></TD>

		<td>
            <%
        
	qry = "select distinct nvl(a.INSTITUTECODE,'N')INSTITUTECODE,a.CATEGORYCODE,a.CATEGORYDESC from STUDENTCATEGORY a where " +
            " a.institutecode = '"+mInst+"' ORDER BY CATEGORYDESC " ;
 //out.print(qry);

    %>
<select name="Category"  id="Category"  >
<option selected  value="N"><-Select-></option>
<%


rs = db.getRowset(qry);

    while (rs.next())
{//out.print(rs.getString("QUALIFICATION"));
catcode = rs.getString("CATEGORYCODE").trim();
if(category.equals(catcode))
    {
%>
<option selected  value="<%=catcode%>"><%=rs.getString("CATEGORYDESC")%></option>
<%
}
else
    {
%>
<option   value="<%=catcode%>"><%=rs.getString("CATEGORYDESC")%></option>
<%
    }
    }
//out.print("aewae");

%>

</select>
</td>
        <TD><FONT color=black face=Arial size=2>&nbsp;Bank A/C No.</FONT></TD>
		<td><INPUT ID="BankACNo" Name="BankACNo" Type="text" value="<%=bankAccountNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>
</TR>
<TR>
        <TD>&nbsp;</TD>
		<td>&nbsp; </td>
		<TD><FONT color=black face=Arial size=2>&nbsp;Bank Name.</FONT></TD>

		<td>
            <%
       
String bankcode="";
	qry = "  select  bankcode bc,bankname bn from studentbankmaster " ;

rs = db.getRowset(qry);

%>
<select name="Bankcode"  id="Bankcode">
<option  selected value="N"><-Select-></option>
<%
while (rs.next())
{
    bankCode=rs.getString("bc")==null?"":rs.getString("bc").trim();
    bankName=rs.getString("bn")==null?"":rs.getString("bn").trim();

     if(rs.getString("bc").equals(BankCode))
     {
         %>
        <option selected value="<%=bankCode%>"><%=bankName%></option>
        <%
       }
    else
        {
        %>
        <option  value="<%=bankCode%>"><%=bankName%></option>
        <%
        }
    }



%>
</select>
</td>
</TR>

    <TR align="middle" bgcolor="#ff8c00">
		<TD colspan="4"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Student Contact Detail</STRONG></FONT></P></TD>
	</TR>

    <TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile </FONT></TD>
		
		<td><INPUT ID="SCellNo" Name="SCellNo" Type="text" value="<%=mSCellNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>

        <td><FONT color=black face=Arial size=2>&nbsp;STD Code - Phone</FONT></td>
		<td colspan="3"><INPUT ID="SSTD" Name="SSTD" Type="text" value="<%=mSstd%>" style="WIDTH: 50px; HEIGHT: 22px" maxLength=20>
		<FONT color=black face=Arial size=2>&nbsp;Phone</FONT>
		<INPUT ID="STelNo" Name="STelNo" Type="text" value="<%=mSTelNo%>" style="WIDTH: 100px; HEIGHT: 22px" maxLength=50></td>
	</TR>	
			
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>

		<td><INPUT ID="SEMail" Name="SEMail" Type="text" value="<%=mSEmail%>" onchange="return echeck(SEMail.value)" style="WIDTH: 300px; HEIGHT: 22px" maxLength=60><font color=red>*</font></td>
	</TR>
	 <TR align="middle" bgcolor="#ff8c00">
		<TD colspan="4"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Correspondance Address </STRONG></FONT></P></TD>
		
	</TR>
    <TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Address 1</FONT></TD>
		
		<td><INPUT ID="Address1" Name="Address1" Type="text" value="<%=mADDRESS1%>" style="WIDTH: 350px; HEIGHT: 22px" maxLength=60></td>


		<TD><FONT color=black face=Arial size=2>&nbsp;Post Office</FONT></TD>

		<td><INPUT ID="Post0ffice" Name="Post0ffice" Type="text" value="<%=mPOSTOFFICE%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>


	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Address 2</FONT></TD>
		
		<td><INPUT ID="Address2" Name="Address2" Type="text" value="<%=mADDRESS2%>" style="WIDTH: 350px; HEIGHT: 22px" maxLength=60></td>


		<TD><FONT color=black face=Arial size=2>&nbsp;Railway Station</FONT></TD>

		<td><INPUT ID="RailStation" Name="RailStation" Type="text" value="<%=mRAILSTATION%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>

	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Address 3</FONT></TD>
		
		<td><INPUT ID="Address3" Name="Address3" Type="text" value="<%=mADDRESS3%>" style="WIDTH: 350px; HEIGHT: 22px" maxLength=60></td>

		<TD><FONT color=black face=Arial size=2>&nbsp;Police Station</FONT></TD>

		<td><INPUT ID="PolStation" Name="PolStation" Type="text" value="<%=mPOLSTATION%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>

	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;City</FONT></TD>
		
		<td><INPUT ID="City" Name="City" Type="text" value="<%=mCITY%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>


		<TD><FONT color=black face=Arial size=2>&nbsp;District</FONT></TD>

		<td><INPUT ID="District" Name="District" Type="text" value="<%=mDISTRICT%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>


	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Pin</FONT></TD>
		
		<td><INPUT ID="Pin" Name="Pin" Type="text" value="<%=mPIN%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=6 onKeyPress="return numbersonly(this, event);"></td>


	
		<TD><FONT color=black face=Arial size=2>&nbsp;State</FONT></TD>

		<td><INPUT ID="State" Name="State" Type="text" value="<%=mSTATE%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>



    </TR>
	
	

<TR align="middle" bgcolor="#ff8c00">
<TD colspan="4"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Parent/Guardian Contact Detail (Current)</STRONG></FONT></P></TD>
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
		
		<td><INPUT ID="PCellNo" Name="PCellNo" Type="text" value="<%=mPCellNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>
        <TD><FONT color=black face=Arial size=2>&nbsp;STD Code - Phone</FONT></TD>

		<td colspan="3"><INPUT ID="PSTD" Name="PSTD" Type="text" value="<%=mPstd%>" style="WIDTH: 50px; HEIGHT: 22px" maxLength=20>
		<FONT color=black face=Arial size=2>&nbsp;Phone</FONT>
		<INPUT ID="PTelNo" Name="PTelNo" Type="text" value="<%=mPTelNo%>" style="WIDTH: 100px; HEIGHT: 22px" maxLength=50></td>
	</TR>	
	
		
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
	
		<td><INPUT ID="PEMail" Name="PEMail" Type="text" value="<%=mPEmail%>" onchange="return echeck(SEMail.value)"  style="WIDTH: 300px; HEIGHT: 22px" maxLength=60></td>
	</TR>
 <TR bgcolor="#ff8c00">
<TD COLSPAN=10 align=left><FONT color=white face=Arial size=2><STRONG>
    Academic Qualification Detail :- Chronological,latest first (upto 10th standard) </TD>
</TR>
    <tr bgcolor="#ff8c00">

<TABLE cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial;
	FONT-SIZE: x-small" borderColor=blacks borderColorDark=white width=100%>

       
<thead>
<tr  bgcolor="#ff8c00">
<B><td ><FONT color=white face=Arial size=2><STRONG>Name of Board</td>
<td ><FONT color=white face=Arial size=2><STRONG>Qualification</td>
<td  ><FONT color=white face=Arial size=2><STRONG>Exam Passed <br> like(X,XI etc)</td>
<td ><FONT color=white face=Arial size=2><STRONG>Year of Passing</B></td>
<td ><FONT color=white face=Arial size=2><STRONG>Division</B><br> (like 1ST,2ND,3RD...) </td>

<td ><FONT color=white face=Arial size=2><STRONG>Max. Marks</B> </td>
<td ><FONT color=white face=Arial size=2><STRONG>Max. Marks<BR>Obtained</B> </td>

<td ><FONT color=white face=Arial size=2><STRONG>Percentage<Br>of Marks %</B></td>
<td ><FONT color=white face=Arial size=2><STRONG>CGPA</B> </td>
<td ><FONT color=white face=Arial size=2><STRONG>Grade</B> <br>(like A,A+,B...) </td>

</tr>
</thead>

<%
try
{
 qry="SELECT nvl(QUALIFICATIONCODE,' ')QUALIFICATIONCODE, nvl(NAMEOFBOARD,' ')NAMEOFBOARD, " +
         "nvl( EXAMPASSED,' ') EXAMPASSED, nvl(YEAROFPASSING,0)YEAROFPASSING, nvl(DIVISION,' ')DIVISION," +
         " nvl(MAXMARKS,0)MAXMARKS, nvl(MARKSOBTAINED,0)MARKSOBTAINED, nvl(PERCENTOFMARKS,0)PERCENTOFMARKS, nvl(GRADE,' ')GRADE, nvl(CGPA,0)CGPA  " +
            " FROM STUDENTQUALIFICATION A where A.STUDENTID='"+mDID+"'";
   // out.print(qry);
   
    rs2=db.getRowset(qry);
    if(rs2.next())
     {
         rs1=db.getRowset(qry);
    while(rs1.next())
     {
                  slno++;

                   %>
<tr>
<td nowrap>
<select name="Board<%=slno%>"  id="Board<%=slno%>" >
<option selected value="N"><-Select-></option>
<%
qry="SELECT nvl(BOARDCODE,'N')BOARDCODE,nvl(BOARDNAME,'N')BOARDNAME  FROM boardmaster order by BOARDNAME";

rs = db.getRowset(qry);
while (rs.next())
{

    if(rs.getString("BOARDNAME").equals(rs1.getString("NAMEOFBOARD")))
        {
%>
<option selected value="<%=rs.getString("BOARDNAME")%>"><%=rs.getString("BOARDNAME")%></option>
<%
        }
    else
        {
%>
<option  value="<%=rs.getString("BOARDNAME")%>"><%=rs.getString("BOARDNAME")%></option>
<%

        }

}
%>
</select>
</td>

<td nowrap>
<select name="Qual<%=slno%>"  id="Qual<%=slno%>" >
<option selected value="N"><-Select-></option>
<%
qry="SELECT nvl(QUALIFICATIONCODE,'N')QUALIFICATIONCODE,nvl(QUALIFICATION,'N')QUALIFICATION  FROM QUALIFICATIONMASTER  where" +
        " QUALIFICATION not in('10TH','11TH','12TH' ) order by QUALIFICATION DESC";
rs = db.getRowset(qry);
while (rs.next())
{
//out.print(rs.getString("QUALIFICATION"));

    if(rs.getString("QUALIFICATIONCODE").equals(rs1.getString("QUALIFICATIONCODE")))
        {
%>
<option selected value="<%=rs.getString("QUALIFICATIONCODE")%>"><%=rs.getString("QUALIFICATION")%></option>
<%
        }
    else
        {
%>
<option  value="<%=rs.getString("QUALIFICATIONCODE")%>"><%=rs.getString("QUALIFICATION")%></option>
<%
}
//out.print("aewae");
}

%>
</select>
</td>
<td nowrap> <input  value="<%=rs1.getString("EXAMPASSED")%>" name="ExamPass<%=slno%>" id="ExamPass<%=slno%>" style="width:50px" maxlength=60> </td>
<td nowrap> <input  value="<%=rs1.getInt("YEAROFPASSING")%>" name="Year<%=slno%>" id="Year<%=slno%>" style="width:50px" maxlength=4 onchange="return yearofPass('<%=slno%>')"  style="width:50px"  onkeypress="return isNumber(event)">  </td>
<td nowrap> <input  value="<%=rs1.getString("DIVISION")%>" name="Div<%=slno%>" id="Div<%=slno%>" style="width:40px" maxlength=10>  </td>
<td nowrap> <input  value="<%=rs1.getDouble("MAXMARKS")%>" name="MMarks<%=slno%>" id="MMarks<%=slno%>" style="width:50px" onKeyPress="return numbersonly(this,event)" maxlength=4>  </td>
<td nowrap> <input  value="<%=rs1.getDouble("MARKSOBTAINED")%>" name="MMarksObt<%=slno%>" id="MMarksObt<%=slno%>" style="width:50px" onKeyPress="return numbersonly(this,event)" maxlength=5>  </td>
<td nowrap> <input  value="<%=rs1.getDouble("PERCENTOFMARKS")%>" name="PerMarks<%=slno%>" id="PerMarks<%=slno%>" style="width:50px" maxlength=4 onchange="return percentage(PerMarks<%=slno%>.value,<%=slno%>)" onKeyPress="return numbersonly(this,event)">%  </td>
<td nowrap> <input  value="<%=rs1.getDouble("CGPA")%>" name="CGPA<%=slno%>" id="CGPA<%=slno%>" style="width:40px" maxlength=5 onKeyPress="return numbersonly(this,event)" onchange="return cgpa_Value(CGPA<%=slno%>.value,<%=slno%>)">  </td>
<td nowrap> <input  value="<%=rs1.getString("GRADE")%>" name="Grade<%=slno%>" id="Grade<%=slno%>" style="width:50px" maxlength=5>  </td>

</tr>
<%
}
//slno++;	


                    



        }
    else
        {
        for ( slno = 1; slno <= 3; slno++)

        {
%>
<tr>
<td nowrap>
<select name="Board<%=slno%>"  id="Board<%=slno%>" >
<option  selected value="N"><-Select-></option>
<%
qry="SELECT nvl(BOARDCODE,'N')BOARDCODE,nvl(BOARDNAME,'N')BOARDNAME  FROM boardmaster order by BOARDNAME";
rs = db.getRowset(qry);
while (rs.next())
{
%>
<option  value="<%=rs.getString("BOARDNAME")%>"><%=rs.getString("BOARDCODE")%></option>
<%
}
%>
</select>
</td>

<td nowrap>
<select name="Qual<%=slno%>"  id="Qual<%=slno%>" >
<option selected value="N"><-Select-></option>
<%
qry="SELECT nvl(QUALIFICATIONCODE,'N')QUALIFICATIONCODE,nvl(QUALIFICATION,'N')QUALIFICATION  FROM QUALIFICATIONMASTER  where" +
        " QUALIFICATION not in('10TH','11TH','12TH' ) order by QUALIFICATION DESC";
rs = db.getRowset(qry);
while (rs.next())
{
//out.print(rs.getString("QUALIFICATION"));
%>
<option  value="<%=rs.getString("QUALIFICATIONCODE")%>"><%=rs.getString("QUALIFICATION")%></option>
<%
//out.print("aewae");
}

%>
</select>
</td>
<td nowrap> <input   name="ExamPass<%=slno%>" id="ExamPass<%=slno%>" style="width:50px" maxlength=60> like(X,XI etc) </td>
<td nowrap> <input   name="Year<%=slno%>" id="Year<%=slno%>" style="width:50px" maxlength=4  onKeyPress="return numbersonly(this,event)" 
 style="width:50px"  onkeypress="return isNumber(event)">(like 2009,2010...)  </td>
<td nowrap> <input   name="Div<%=slno%>" id="Div<%=slno%>" style="width:40px" maxlength=10>(like 1ST,2ND,3RD...)  </td>
<td nowrap> <input   name="MMarks<%=slno%>" id="MMarks<%=slno%>" style="width:50px" onKeyPress="return numbersonly(this,event)" maxlength=4>  </td>
<td nowrap> <input   name="MMarksObt<%=slno%>" id="MMarksObt<%=slno%>" style="width:50px" onKeyPress="return numbersonly(this,event)" maxlength=5>  </td>
<td nowrap> <input   name="PerMarks<%=slno%>" id="PerMarks<%=slno%>" style="width:50px" maxlength=4 onchange="return percentage(PerMarks<%=slno%>.value,<%=slno%>)" onKeyPress="return numbersonly(this,event)">%  </td>
<td nowrap> <input   name="CGPA<%=slno%>" id="CGPA<%=slno%>" style="width:40px" maxlength=5 onKeyPress="return numbersonly(this,event)" onchange="return cgpa_Value(CGPA<%=slno%>.value,<%=slno%>)">  </td>
<td nowrap> <input   name="Grade<%=slno%>" id="Grade<%=slno%>" style="width:50px" maxlength=5>(like A,A+,B,B+...)  </td>

</tr>
<%
        }

        }






%>
<tr><td colspan="10" align="center"><INPUT Type="submit" Value="Save"></td></tr>
	</table>
   
<%
}
catch(Exception e)
    {
    out.print("Error : "+e);
    }
	

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
   <%
	
	
   }
  //-----------------------------

}
else
{
%>
<br>Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
 <%
	}

}
catch(Exception e)
{
}
%>

</form>
</body>
</html> 
