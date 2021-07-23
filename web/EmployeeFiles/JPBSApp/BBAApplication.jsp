<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %>
<!-- Modified Date 15-06-2020 -->
<%
try{
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JPBS";

GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null;
String qry="",str1="";
String mValue="";

int mDOBMaxYear=1970;
int mDOBMinYear=1992;
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
//session.setAttribute("Click",mSelf);
session.setMaxInactiveInterval(10800);
session.setAttribute("APPLICATIONSLNO",null);
//out.print("sdfsfds"+session.getAttribute("APPLICATIONSLNO"));

session.setAttribute("MFLAG",null);
 ResultSet rss12 = null;
                String location = "",locationcode="";
                int choice = 0;

%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Application Form ] </TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Jaypee Institute of Information Technology</title>
<meta http-equiv="Page-Enter" content="revealTrans(Duration=1.0,Transition=1)">
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>

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
	if ((key==null) || (key==0) || (key==8) || (key==9) || (key==13) || (key==27) )
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




function isNumber(e)
        {

            var unicode=e.charCode? e.charCode : e.keyCode
            if (unicode!=8)
            { //if the key isn't the backspace key (which we should allow)
                if ((unicode<48||unicode>57)) //if not a number
                    return false; //disable key press

            }
        }



function funstate()
				{

					if(LoginForm.OS.checked==true)
					{

						LoginForm.Other.value="";
						LoginForm.GradProg.disabled=true;
						LoginForm.Other.disabled=false;
					}
					else
					{
						LoginForm.Other.value="";
						LoginForm.GradProg.disabled=false;
						LoginForm.Other.disabled=true;

					}
				}


function ChangeCase()
	{
		LoginForm.FirstName.value = LoginForm.FirstName.value.toUpperCase();
		LoginForm.FatherName.value = LoginForm.FatherName.value.toUpperCase();

		LoginForm.ADDRESS1.value = LoginForm.ADDRESS1.value.toUpperCase();
		LoginForm.ADDRESS2.value = LoginForm.ADDRESS2.value.toUpperCase();

		LoginForm.CITY.value = LoginForm.CITY.value.toUpperCase();
		Other();
		Grad();
	}

function ValidPhone()
	{

		var phone=document.LoginForm.MOBILE.value;

		var xx=phone.substring(0,1);
				//alert(phone+"sdfsdf"+xx);
		if(document.LoginForm.MOBILE.value=="+91" || xx=="0" || xx=="+" )
		{
					alert('Please Enter Valid Phone No.');
					return false;
		}
	}

function button1_onclick(currdate)
	{



		if(document.LoginForm.FirstName.value=="" || document.LoginForm.FirstName.value==" ")
			{
				alert('First Name Should not be left blank.');
				LoginForm.FirstName.focus();
					return(false);
			}

			if(document.LoginForm.FatherName.value=="" || document.LoginForm.FatherName.value==" ")
			{
				alert('Father Name  Should not be left blank.');
				LoginForm.FatherName.focus();
					return(false);
			}

		if(document.LoginForm.DOB.value=="" || document.LoginForm.DOB.value==" ")
		{
				alert('Please enter your Date of Birth. ');
				LoginForm.DOB.focus();
					return(false);
		}
		if(document.LoginForm.ADDRESS1.value=="" || document.LoginForm.ADDRESS1.value==" ")
			{
				alert('Address Name Should not be left blank.');
				LoginForm.ADDRESS1.focus();
					return(false);
			}

		if(document.LoginForm.email.value=="" || document.LoginForm.email.value==" ")
		{
				alert('Please enter Email-ID.');
				LoginForm.email.focus();
					return(false);
		}


		if(document.LoginForm.TenYear.value=="" || document.LoginForm.TenYear.value==" ")
		{
				alert('Please enter 10th Year of Passing. ');
				LoginForm.TenYear.focus();
					return(false);
		}
		if(document.LoginForm.TenBoard.value=="" || document.LoginForm.TenBoard.value==" ")
		{
				alert('Please enter 10th Board. ');
				LoginForm.TenBoard.focus();
					return(false);
		}
		if(document.LoginForm.TenPercent.value=="" || document.LoginForm.TenPercent.value==" ")
		{
				alert('Please enter  10th Percentage. ');
				LoginForm.TenPercent.focus();
					return(false);
		}

		if(document.LoginForm.TewYear.value=="" || document.LoginForm.TewYear.value==" ")
		{
				alert('Please enter 12th Year of Passing. ');
				LoginForm.TewYear.focus();
					return(false);
		}
		if(document.LoginForm.TewBoard.value=="" || document.LoginForm.TewBoard.value==" ")
		{
				alert('Please enter 12th Board. ');
				LoginForm.TewBoard.focus();
					return(false);
		}
		if(document.LoginForm.TewPercent.value=="" || document.LoginForm.TewPercent.value==" ")
		{
				alert('Please enter 12th Percentage. ');
				LoginForm.TewPercent.focus();
					return(false);
		}
		if(document.LoginForm.TewStream.value=="Others" && document.LoginForm.TewStream1.value=="")
		{
				alert('Please enter 12th Stream. ');
				LoginForm.TewStream1.focus();
					return(false);
		}



		if(document.LoginForm.GradYear.value=="" || document.LoginForm.GradYear.value==" ")
		{
				alert('Please enter  Graduation Year of Passing. ');
				LoginForm.GradYear.focus();
					return(false);
		}
		if(document.LoginForm.GradBoard.value=="" || document.LoginForm.GradBoard.value==" ")
		{
				alert('Please enter Graduation Board. ');
				LoginForm.GradBoard.focus();
					return(false);
		}
		//if(document.LoginForm.GradPercent.value=="" || document.LoginForm.GradPercent.value==" ")
		//{
		//		alert('Please enter Graduation Percentage. ');
		//		LoginForm.GradPercent.focus();
		//			return(false);
		//}
		if(document.LoginForm.GradStream.value=="Others" && document.LoginForm.GradStream1.value=="")
		{
				alert('Please enter Graduation Stream. ');
				LoginForm.GradStream1.focus();
					return(false);
		}



		if(document.LoginForm.CMATCOMP.value=="" && document.LoginForm.CATCOMP.value=="" && document.LoginForm.MATCOMP.value=="" && document.LoginForm.GMATCOMP.value==""&& document.LoginForm.XATCOMP.value==""&&document.LoginForm.OTHCOMP.value=="")
		{
				alert('Please enter Composite Score.');
				LoginForm.CATCOMP.focus();
					return(false);
		}

		if(document.LoginForm.CMATPER.value=="" && document.LoginForm.CATPER.value=="" && document.LoginForm.MATPER.value=="" && document.LoginForm.GMATPER.value==""&& document.LoginForm.XATPER.value==""&&document.LoginForm.OTHPER.value=="")
		<!--if(document.LoginForm.CATPER.value=="")-->
		{
				alert('Please enter Percentile!.');
				LoginForm.CATPER.focus();
					return(false);
		}

		if(document.LoginForm.TenYear.value=="" && document.LoginForm.TewYear.value=="" && document.LoginForm.GradYear.value==""  && document.LoginForm.OtherYear.value=="")
		{
				alert('Please enter Year of Completion. ');
				LoginForm.TenYear.focus();
					return(false);
		}

if(document.LoginForm.TenPercent.value=="" && document.LoginForm.TewPercent.value=="" && document.LoginForm.OtherPercent.value=="")
		{
				alert('Please enter Percentage of Qualification. ');
				LoginForm.TenPercent.focus();
					return(false);
		}



var TenPercent=document.LoginForm.TenPercent.value;

var TewPercent=document.LoginForm.TewPercent.value;
//var GradPercent=document.LoginForm.GradPercent.value;
var OtherPercent=document.LoginForm.OtherPercent.value;
var Catperctg=document.LoginForm.CATPER.value;
var comp=document.LoginForm.CATCOMP.value;
var matcomp=document.LoginForm.MATCOMP.value;
var gatcomp=document.LoginForm.GMATCOMP.value;


//alert(DPERCENT+"asd"+GPERCENT+"sdfasd"+PGPERCENT+"asd");

if(TenPercent>100.0)
	{
			 alert('10th Percentage Should be less than 100 ');
			  LoginForm.TenPercent.focus();
			  return false;
	}
	 if(TewPercent>100.0)
	{
		 alert('12thPercentage Should be less than 100 ');
			  LoginForm.TewPercent.focus();
			  return false;
	}
	// if  (GradPercent>100.0)
	//{
	//		 alert('Graduation Percentage Should be less than 100 ');
	//		  LoginForm.GradPercent.focus();
	//		  return false;
	//}-->
	if  (OtherPercent>100.0)
	{
			 alert('Other Percentage Should be less than 100 ');
			  LoginForm.OtherPercent.focus();
			  return false;
	}


	if(Catperctg>100.0)
		{
				 alert('Percentage Should be less than 100');
				  LoginForm.CATPER.focus();
				  return false;
		}

	if(comp>1001.0)
		{
				 alert('Composite Score should be less than 1000');
				  LoginForm.CATCOMP.focus();
				  return false;
		}

	if(matcomp>1001.0)
		{
				 alert('Composite Score should be less than 1000');
				  LoginForm.MATCOMP.focus();
				  return false;
		}

	if(gatcomp>1001.0)
		{
				 alert('Composite Score should be less than 1000');
				  LoginForm.GMATCOMP.focus();
				  return false;
		}






	//	alert("sdsd");
/*
if(document.LoginForm.CATDATE.value!="")
{
var CATDATE=document.LoginForm.CATDATE.value;

var bb=CATDATE.substring(10,6)+CATDATE.substring(5,3)+CATDATE.substring(2,0);
//alert(currdate+"sdsd"+bb);
if(currdate>bb )
		{
			alert('Please Enter CAT DATE greater than the Current Date ');
			document.LoginForm.CATDATE.value="";
			LoginForm.CATDATE.focus();
			return false;
		}
}

if(document.LoginForm.MATDATE.value!="")
{
var MATDATE=document.LoginForm.MATDATE.value;
var mm=MATDATE.substring(10,6)+MATDATE.substring(5,3)+MATDATE.substring(2,0);
if(currdate>mm)
		{
			alert('Please Enter MAT DATE greater than the Current Date ');
			document.LoginForm.MATDATE.value="";
			LoginForm.MATDATE.focus();
			return false;
		}
}

if(document.LoginForm.GMATDATE.value!="")
{
var GMATDATE=document.LoginForm.GMATDATE.value;
var GG=GMATDATE.substring(10,6)+GMATDATE.substring(5,3)+GMATDATE.substring(2,0);
if(currdate>GG)
		{
			alert('Please Enter GMAT DATE greater than the Current Date ');
			document.LoginForm.GMATDATE.value="";
			LoginForm.GMATDATE.focus();
			return false ;
		}
}
	*/

		if(document.LoginForm.DDNO.value==" " || document.LoginForm.DDNO.value=="")
		{
				alert('Please Enter DD Number ');
				LoginForm.DDNO.focus();
					return(false);
		}
		if((document.LoginForm.DDNO.value.length)<6)
				{
					alert('DD Number should not less then 6 digit.');
					LoginForm.DDNO.focus();
					return(false);
		}

		if(document.LoginForm.DDAMT.value==" " || document.LoginForm.DDAMT.value=="")
		{
				alert('Please Enter DD Amount ');
				LoginForm.DDAMT.focus();
					return(false);
		}
		if((document.LoginForm.DDAMT.value)<500)
				{
					alert('DD Amount should be 500');
					LoginForm.DDAMT.focus();
					return(false);
		}
		if(document.LoginForm.DDDATE.value==" " || document.LoginForm.DDDATE.value=="")
		{
				alert('Please Enter DD Date ');
				LoginForm.DDDATE.focus();
					return(false);
		}

		if(document.LoginForm.BANK.value==" " || document.LoginForm.BANK.value=="")
		{
				alert('Please Enter Bank Name ');
				LoginForm.BANK.focus();
					return(false);
		}


if(document.LoginForm.DDDATE.value!="")
{
	var dddate=document.LoginForm.DDDATE.value;

	var aa=dddate.substring(10,6)+dddate.substring(5,3)+dddate.substring(2,0);

	if(currdate<aa)
		{
			alert('Please Enter DD Date less than the Current Date ');
			LoginForm.DDDATE.focus();
			return false ;
		}
}
var i=1;
if(document.getElementById('location'+i).value=='NULL'){
                            alert('Select the first choice ....!');
                            return false;
						}

//return false ;
}


function iSValidDate(pDate)
{
//1

if(document.LoginForm.DOB.value!="" && document.LoginForm.DOB.value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = pDate;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDate = false;
//	alert(mDate.length+"sssss");
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if ((mDate.substring(0,2).trim()) >= 1 &&
              (mDate.substring(0,2).trim()) <=31 &&
              (mDate.substring(3, 5).trim()) <= 12 &&
              (mDate.substring(3, 5).trim()) >= 1 &&
              (mDate.substring(6).trim()) >= 1900 &&
              (mDate.substring(6).trim()) <= 3000) { //5
            dn = (mDate.substring(0, 2).trim());
            mn = (mDate.substring(3,5).trim());
            yn = (mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDate =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in DOB date field i.e DD-MM-YYYY.');
			LoginForm.DOB.value="";
			LoginForm.DOB.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in DOB date field i.e DD-MM-YYYY.');
			LoginForm.DOB.value="";
			LoginForm.DOB.focus();
		  }
      } //3
	  else if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in DOB date field i.e DD-MM-YYYY.');
			LoginForm.DOB.value="";
			LoginForm.DOB.focus();
		  }
 //   } //2
  return (mISValidDate);
}
else
	//if(LoginForm.DOB.value==null)
	 {
		  alert('Please Enter the valid date format in DOB date field i.e DD-MM-YYYY.');

	 }
}

function iSValidDDDate(DDDate)
{
//1

if(document.LoginForm.DDDATE.value!="" && document.LoginForm.DDDATE.value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = DDDate;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDDDate = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if ((mDate.substring(0,2).trim()) >= 1 &&
              (mDate.substring(0,2).trim()) <=31 &&
              (mDate.substring(3, 5).trim()) <= 12 &&
              (mDate.substring(3, 5).trim()) >= 1 &&
              (mDate.substring(6).trim()) >= 1900 &&
              (mDate.substring(6).trim()) <= 3000) { //5
            dn = (mDate.substring(0, 2).trim());
            mn = (mDate.substring(3,5).trim());
            yn = (mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDDDate =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in DD  date field i.e DD-MM-YYYY.');
			LoginForm.DDDATE.value="";
			LoginForm.DDDATE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in DD date field i.e DD-MM-YYYY.');
			LoginForm.DDDATE.value="";
			LoginForm.DDDATE.focus();
		  }
      } //3
	  else if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in DD date field i.e DD-MM-YYYY.');
			LoginForm.DDDATE.value="";
			LoginForm.DDDATE.focus();
		  }
 //   } //2
  return (mISValidDDDate);
}
else
	//if(LoginForm.DDDATE.value==null)
	 {
		  alert('Please Enter the valid date format in DD date field i.e DD-MM-YYYY.');

	 }
}
//ValidCATDATE
function ValidCATDATE(CATDATE)
{
//1

if(document.LoginForm.CATDATE.value!="" && document.LoginForm.CATDATE.value!=" "  &&  document.LoginForm.CATDATE!=null)
{
    var dn, mn, yn, maxday;
    var mDate = CATDATE;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidCATDATE = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if ((mDate.substring(0,2).trim()) >= 1 &&
              (mDate.substring(0,2).trim()) <=31 &&
              (mDate.substring(3, 5).trim()) <= 12 &&
              (mDate.substring(3, 5).trim()) >= 1 &&
              (mDate.substring(6).trim()) >= 1900 &&
              (mDate.substring(6).trim()) <= 3000) { //5
            dn = (mDate.substring(0, 2).trim());
            mn = (mDate.substring(3,5).trim());
            yn = (mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidCATDATE =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in CATDATE field i.e DD-MM-YYYY.');
			LoginForm.CATDATE.value="";
			LoginForm.CATDATE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in CATDATE field i.e DD-MM-YYYY.');
			LoginForm.CATDATE.value="";
			LoginForm.CATDATE.focus();
		  }
      } //3
	  else if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in CATDATE field i.e DD-MM-YYYY.');
			LoginForm.CATDATE.value="";
			LoginForm.CATDATE.focus();
		  }
 //   } //2
  return (mISValidCATDATE);
}
else
	//if(LoginForm.CATDATE.value==null)
	 {
		  alert('Please Enter the valid date format in CATDATE field i.e DD-MM-YYYY.');

	 }

}

function ValidMATDATE(MATDATE)
{
//1

if(document.LoginForm.MATDATE.value!="" && document.LoginForm.MATDATE.value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = MATDATE;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidMATDATE = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if ((mDate.substring(0,2).trim()) >= 1 &&
              (mDate.substring(0,2).trim()) <=31 &&
              (mDate.substring(3, 5).trim()) <= 12 &&
              (mDate.substring(3, 5).trim()) >= 1 &&
              (mDate.substring(6).trim()) >= 1900 &&
              (mDate.substring(6).trim()) <= 3000) { //5
            dn = (mDate.substring(0, 2).trim());
            mn = (mDate.substring(3,5).trim());
            yn = (mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidMATDATE =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in MATDATE field i.e DD-MM-YYYY.');
			LoginForm.MATDATE.value="";
			LoginForm.MATDATE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in MATDATE field i.e DD-MM-YYYY.');
			LoginForm.MATDATE.value="";
			LoginForm.MATDATE.focus();
		  }
      } //3
	  else  if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in MATDATE field i.e DD-MM-YYYY.');
			LoginForm.MATDATE.value="";
			LoginForm.MATDATE.focus();
		  }
 //   } //2
  return (mISValidMATDATE);
}
else
	//if(LoginForm.MATDATE.value==null)
	 {
		  alert('Please Enter the valid date format in MATDATE field i.e DD-MM-YYYY.');

	 }

}


function ValidCMATDATE(CMATDATE)
{
//1

if(document.LoginForm.CMATDATE.value!="" && document.LoginForm.CMATDATE.value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = CMATDATE;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidCMATDATE = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if ((mDate.substring(0,2).trim()) >= 1 &&
              (mDate.substring(0,2).trim()) <=31 &&
              (mDate.substring(3, 5).trim()) <= 12 &&
              (mDate.substring(3, 5).trim()) >= 1 &&
              (mDate.substring(6).trim()) >= 1900 &&
              (mDate.substring(6).trim()) <= 3000) { //5
            dn = (mDate.substring(0, 2).trim());
            mn = (mDate.substring(3,5).trim());
            yn = (mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidCMATDATE =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in CMATDATE field i.e DD-MM-YYYY.');
			LoginForm.CMATDATE.value="";
			LoginForm.CMATDATE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in CMATDATE field i.e DD-MM-YYYY.');
			LoginForm.CMATDATE.value="";
			LoginForm.CMATDATE.focus();
		  }
      } //3
	  else  if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in CMATDATE field i.e DD-MM-YYYY.');
			LoginForm.CMATDATE.value="";
			LoginForm.CMATDATE.focus();
		  }
 //   } //2
  return (mISValidCMATDATE);
}
else
	//if(LoginForm.CMATDATE.value==null)
	 {
		  alert('Please Enter the valid date format in CMATDATE field i.e DD-MM-YYYY.');

	 }

}




	function ValidGMATDATE(GMATDATE)
{
//1

if(document.LoginForm.GMATDATE.value!="" && document.LoginForm.GMATDATE.value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = GMATDATE;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidGMATDATE = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if ((mDate.substring(0,2).trim()) >= 1 &&
              (mDate.substring(0,2).trim()) <=31 &&
              (mDate.substring(3, 5).trim()) <= 12 &&
              (mDate.substring(3, 5).trim()) >= 1 &&
              (mDate.substring(6).trim()) >= 1900 &&
              (mDate.substring(6).trim()) <= 3000) { //5
            dn = (mDate.substring(0, 2).trim());
            mn = (mDate.substring(3,5).trim());
            yn = (mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidGMATDATE =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in GMATDATE field i.e DD-MM-YYYY.');
			LoginForm.GMATDATE.value="";
			LoginForm.GMATDATE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in GMATDATE field i.e DD-MM-YYYY.');
			LoginForm.GMATDATE.value="";
			LoginForm.GMATDATE.focus();
		  }
      } //3
	  else  if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in GMATDATE field i.e DD-MM-YYYY.');
			LoginForm.GMATDATE.value="";
			LoginForm.GMATDATE.focus();
		  }
 //   } //2
  return (mISValidGMATDATE);
}
else
	//if(LoginForm.GMATDATE.value==null)
	 {
		  alert('Please Enter the valid date format in GMATDATE field i.e DD-MM-YYYY.');

	 }

}


function ValidDateFrom(DateFrom)
{
//1

//alert(document.getElementById(DateFrom).value+"aa"+DateFrom);
if(document.getElementById(DateFrom).value!="" && document.getElementById(DateFrom).value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = document.getElementById(DateFrom).value;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDateFrom = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3)=="-" && mDate.substring(5, 6)=="-") { //4
           if ((mDate.substring(0, 2)) >= 1 &&
              (mDate.substring(0, 2)) <=31 &&
              (mDate.substring(3, 5)) <= 12 &&
              (mDate.substring(3, 5)) >= 1 &&
              (mDate.substring(6)) >= 1900 &&
              (mDate.substring(6)) <= 3000) { //5
            dn = (mDate.substring(0, 2));
            mn = (mDate.substring(3,5));
            yn = (mDate.substring(6));
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDateFrom =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in DateFrom field i.e DD-MM-YYYY.');
			document.getElementById(DateFrom).value="";
			document.getElementById(DateFrom).focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in DateFrom field i.e DD-MM-YYYY.');
			document.getElementById(DateFrom).value="";
			document.getElementById(DateFrom).focus();
		  }
      } //3
	  else  if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in DateFrom field i.e DD-MM-YYYY.');
			document.getElementById(DateFrom).value="";
			document.getElementById(DateFrom).focus();
		  }
 //   } //2
  return (mISValidDateFrom);
}
else
	//if(LoginForm.DateFrom.value==null)
	 {
		  alert('Please Enter the valid date format in DateFrom field i.e DD-MM-YYYY.');

	 }

}


function ValidDateTo(DateTo)
{
//1
//alert(document.getElementById(DateTo).value+"aa"+DateTo);
if(document.getElementById(DateTo).value!="" && document.getElementById(DateTo).value!=" " )
{
    var dn, mn, yn, maxday;
     mDate = document.getElementById(DateTo).value;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDateTo = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
	//	alert(mDate.substring(0, 2)+"LL"+(mDate.substring(3,5)));
        if (mDate.substring(2, 3)=="-" && mDate.substring(5, 6)=="-") { //4
           if ((mDate.substring(0, 2)) >= 1 &&
              (mDate.substring(0, 2)) <=31 &&
              (mDate.substring(3, 5)) <= 12 &&
              (mDate.substring(3, 5)) >= 1 &&
              (mDate.substring(6)) >= 1900 &&
              (mDate.substring(6)) <= 3000) { //5
            dn = (mDate.substring(0, 2));
            mn = (mDate.substring(3, 5));
            yn = (mDate.substring(6));
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDateTo =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in DateTo field i.e DD-MM-YYYY.');
			document.getElementById(DateTo).value="";
			document.getElementById(DateTo).focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in DateTo field i.e DD-MM-YYYY.');
			document.getElementById(DateTo).value="";
			document.getElementById(DateTo).focus();
		  }
      } //3
	  else  if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in DateTo field i.e DD-MM-YYYY.');
			document.getElementById(DateTo).value="";
			document.getElementById(DateTo).focus();
		  }
 //   } //2
  return (mISValidDateTo);
}
else
	//if(LoginForm.DateTo.value==null)
	 {
		  alert('Please Enter the valid date format in DateTo field i.e DD-MM-YYYY.');

	 }

}


	function RadioCheck()
	{
		//alert("sdas");


		if(document.LoginForm1.AppRadio1.checked==true)
		{
			 document.LoginForm1.AppRadio2.checked=false;
			 document.LoginForm1.AppNo.disabled=false;
			document.LoginForm1.IntAppNo.disabled=true;
			return(false);
		}


	}
	function OnLoad()
	{
	//alert(document.LoginForm1.z.value+"sada"s);
		document.LoginForm1.AppRadio1.checked=true;
		document.LoginForm1.AppNo.disabled=false;
		document.LoginForm1.IntAppNo.disabled=true;



	}


	function Other(stream)
	{
		//alert(stream);

		if(stream=="Others")
		{
				document.LoginForm.TewStream1.disabled=false;
				LoginForm.TewStream1.focus();
				return false;
		}
		else
		{

			document.LoginForm.TewStream1.disabled=true;

		}
	}
	function Grad(stream)
	{
		//alert(stream);

		if(stream=="Others")
		{
				document.LoginForm.GradStream1.disabled=false;
				LoginForm.GradStream1.focus();
				return false;
		}
		else
		{

			document.LoginForm.GradStream1.disabled=true;

		}
	}

	function RadioCheck1()
	{
		  if(document.LoginForm1.AppRadio2.checked==true)
		{
			 document.LoginForm1.AppRadio1.checked=false;
			 document.LoginForm1.IntAppNo.disabled=false;
			document.LoginForm1.AppNo.disabled=true;
			return(false);
		}
	}

	function Check()
	{

		if(document.LoginForm1.AppNo.value=="" && document.LoginForm1.IntAppNo.value=="")
			{
			alert('Application No. Should not be left blank');
				document.LoginForm1.AppRadio1.checked=true;
				document.LoginForm1.AppNo.disabled=false;
				 document.LoginForm1.AppRadio2.checked=false;
				document.LoginForm1.IntAppNo.disabled=true;
				LoginForm1.AppNo.focus();
					return(false);
			}
		//alert(document.LoginForm.TenYear+"sdsd");
	}


</SCRIPT>
 <script language=javascript>
  function Dulicatecheck(b,c){
      var v=document.getElementById(b).value;
              var i=0;
				var flag=0;
				for( i=1;i<=3;i++){

					if(c!=i){
                        if (v!="NULL")
                            {
		if(document.getElementById(b).value==document.getElementById("location"+i).value){
							flag=1;
                            alert("Duplicate selection...!");
                            document.getElementById(b).value="NULL";
                            return false;
                            //alert('choice'+document.getElementById(b).value + "=="+document.getElementById("Branch"+i).value);
						}}}
					}
  }

</script>
<script language="JavaScript" type ="text/javascript" src="../js/datetimepicker.js"></script>
</head>
<BODY bgcolor="lightyellow"  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onLoad="OnLoad();" >
 <table  border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups borderColor=black>
<tr>
<td ALIGN=middle><FONT face=Verdana><STRONG><U><FONT size=3><FONT
      color=brown
      size=4>JAYPEE INSTITUTE OF INFORMATION TECHNOLOGY  <br>Jaypee Business School</FONT>
      </FONT></U></STRONG></FONT><BR><FONT face=Verdana><FONT
      size=1>(Declared Deemed to be University u/s 3 of the UGC Act,1956)</FONT>
  </FONT>
</td>
</tr>
<tr><td ALIGN=middle><FONT
      face=Verdana><STRONG><FONT size=4>BBA APPLICATION FORM - 2020-23 . </font><br>
</FONT>
</td></tr>
</table>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <FONT size=3><b>Eligibility Criteria: </b>Class 10+2 or equivalent examination from any recognized board with minimum 50%
marks or equivalent grade.</FONT></STRONG>
      <BR>
<%


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
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;

	  //-----------------------------
	  //-- Enable Security Page Level
	  //-----------------------------

		qry="Select WEBKIOSK.ShowLink('228','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
	  //----------------------
	  %>
<form method=post name="LoginForm1" >
  <input id="x" name="x" type=hidden>

  <%
if(request.getParameter("x")==null)
{
	%>
<table width="98%" border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups >

<tr><td ><FONT face=Verdana><b><INPUT TYPE="radio" NAME="AppRadio1"  id="AppRadio1" onClick=" RadioCheck();" Value="App" > &nbsp;Application No: (Enter 'O' )</b></FONT><INPUT  Name="AppNo" ID="AppNo" size=6 maxlength=8 tabIndex=1  ><FONT
      face="Times New Roman" color=#ff4500>*</FONT>
&nbsp;&nbsp;
<FONT face=Verdana><b> or &nbsp; &nbsp;
<INPUT TYPE="radio"  onClick=" RadioCheck1();"  NAME="AppRadio2"   id="AppRadio2" Value="IntApp" >Click if InternetApp, Internet App No:&nbsp; INT </b></FONT><INPUT ID="IntAppNo" Name="IntAppNo"  size=3 maxlength=4 tabIndex=1 LANGUAGE=javascript onkeypress="return isNumber(event)"><FONT
      face="Times New Roman" color=#ff4500>*</FONT></td>
</tr>

<tr>

<td colspan =2 align=center><INPUT TYPE="submit" onclick="return Check();" tabIndex=2 value="Submit"></td>
</tr>
<%
}
%>


</form>

<form method=post action="BBAApplicationFormAction.jsp" name="LoginForm">

<%
if(request.getParameter("x")!=null)
{ 



String  mAppNo="",mIntAppNo="",mAppRadio1="",mAppRadio2="",mCurrDate="";



qry="Select To_char(Sysdate,'yyyymmdd' ) Dat from dual  ";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString(1);


if(request.getParameter("AppNo")==null)
	mAppNo="";
else
	mAppNo=request.getParameter("AppNo").toString().trim();


if(request.getParameter("IntAppNo")==null)
	mIntAppNo="";
else
	mIntAppNo=request.getParameter("IntAppNo").toString().trim();

if(request.getParameter("AppRadio1")==null)
	mAppRadio1="";
else
	mAppRadio1=request.getParameter("AppRadio1").toString().trim();


if(request.getParameter("AppRadio2")==null)
	mAppRadio2="";
else
	mAppRadio2=request.getParameter("AppRadio2").toString().trim();

int mFlag=0,mCheckDD=0;
String mIntApplication="";

//out.print(mAppRadio1+"mAppRadio1"+mAppNo);
//out.print(mAppRadio2+"mAppRadio2"+mIntAppNo);
if(mAppRadio1.equals("App") && !mAppNo.equals(" ") )
{
mIntApplication=mAppNo;
mFlag=1;
mCheckDD=1;
}
else if(mAppRadio2.equals("IntApp") && !mIntAppNo.equals(" "))
{
 mIntApplication="INT"+mIntAppNo;
 mFlag=1;

}


//out.print(mIntApplication+"mIntApplication");
//if(!mIntApplication.equals(" ") )
if(mFlag==1 )
{
qry="select 'Y' from C#BBAAPPLICATIONMASTER where APPLICATIONNO='"+mIntApplication+"' and nvl(deactive,'N')='N'  and APPLICATIONSLNO like '2020%' ";
//out.print(qry);
rs=db.getRowset(qry);

if(!rs.next())
{

	%>

<input Type=hidden name="AppNo" id="AppNo" Value="<%=mIntApplication%>">


<table width="98%" border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups >
<tr><td ><FONT face=Verdana color=blue size=3><b>Application No :  <%=mIntApplication%></b></FONT><FONT
       color=#ff4500>*</FONT>
</td></tr>
<tr><td ><FONT face=Verdana>1. Name of Candidate :</FONT><INPUT ID="FirstName" Name="FirstName" size=60 maxlength=60 tabIndex=2 	onfocusout="return ChangeCase()"><FONT
      color=#ff4500>*</FONT></td>
</tr>
<tr>
<td colspan=3 align=left><FONT face=Verdana> 2. Father's Name
      :  &nbsp;   &nbsp; &nbsp;</FONT>   <INPUT size=60 maxlength=60 Id="FatherName" Name="FatherName"
      tabIndex=3  LANGUAGE=javascript onfocusout="return ChangeCase()"><FONT
      face=Verdana><FONT       color=#ff4500>*</FONT> </FONT>
</td>
</tr>
<tr>
<td colspan=3 align=left><FONT face=Verdana> 3. Mother's Name
      :  &nbsp;   &nbsp; </FONT>   <INPUT size=60 maxlength=60 Id="motherName" Name="motherName"
      tabIndex=4  LANGUAGE=javascript onfocusout="return ChangeCase()"><FONT
      face=Verdana><FONT       color=#ff4500>*</FONT> </FONT>
</td>
</tr>
<tr>
<td><FONT face=Verdana>4. Gender <FONT color=tomato>*</FONT>
<INPUT Type="radio" ID="Gender" Name="Gender" Value="M" checked tabIndex=4>Male
<INPUT Type="radio" ID="Gender" Name="Gender" Value="F"
      tabIndex=5>Female</FONT>
      </SELECT>
<FONT face=Verdana>
</FONT>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;<FONT face=Verdana>5. Date of Birth <font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font><FONT
      face="Times New Roman"
      color=#ff4500>*</FONT>
	<INPUT TYPE="text" NAME=DOB ID=DOB size=9 onchange="return iSValidDate(DOB.value)"  onclick="return iSValidDate(DOB.value)" tabindex=6  maxlength=10
	><!-- <a href="javascript:NewCal('DOB','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->

</td>
</tr>
<tr><td colspan=3>

 <FONT face=Verdana>6. Category:<FONT face="Times New Roman"
      color=#ff4500>*</FONT>
		<INPUT Type="radio" ID="Category" Name="Category" Value="GN" checked tabIndex=9>General (GN)
	   <INPUT Type="radio" ID="Category" Name="Category" Value="SC" tabIndex=10>SC
	   <INPUT Type="radio" ID="Category" Name="Category" Value="ST" tabIndex=11>ST
	   <INPUT Type="radio"  ID="Category" Name="Category" Value="OBC" tabIndex=12>OBC
	   </FONT>
      
<FONT face=Verdana size=2>7.Aadhaar No.</FONT>
        <input ID="adhar" Name="adhar" MaxLength=12 Size=12 tabIndex=16 onkeypress="return isNumber(event)"><FONT color=#ff4500></FONT></FONT><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
</td>

</tr>
<br>

<tr>
<td colspan=3><FONT face=Verdana size=2>8. Address of the Candidate</FONT>
<br>
&nbsp; &nbsp; &nbsp; &nbsp;<input ID="ADDRESS1" Name="ADDRESS1" MaxLength=80 Size=70 tabIndex=13  LANGUAGE=javascript onfocusout="return ChangeCase()"><FONT color=#ff4500>*</FONT><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input ID="ADDRESS2" Name="ADDRESS2" MaxLength=75 Size=70 tabIndex=14 LANGUAGE=javascript onfocusout="return ChangeCase()"><br>
&nbsp; &nbsp; &nbsp; &nbsp;<FONT face=Verdana size=2>City:</FONT> <input ID="CITY" Name="CITY" MaxLength=25 Size=25  tabIndex=15 LANGUAGE=javascript onfocusout="return ChangeCase()"><FONT
      color=#ff4500></FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Verdana size=2>PIN: <input ID="PIN" Name="PIN" MaxLength=6 Size=6 tabIndex=16 onkeypress="return isNumber(event)"><FONT color=#ff4500></FONT></FONT><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



 <FONT face=Verdana size=2>Country:
<select name="Country" id="Country" tabIndex=17>
  <option value='INDIA' selected>India</option>
	<%
	/*try{
	   qry="select distinct COUNTRYCODE,COUNTRYNAME FROM COUNTRYMASTER order by 2";

	     rs=db.getRowset(qry);
		while(rs.next())
		{
	%>
		<!--   <option value=<%=rs.getString("COUNTRYCODE")%>><%=rs.getString("COUNTRYNAME")%></option> -->
	<%
	/*	}
		}
		catch(Exception e)
		{

		}*/
	%>
 </select>
 <FONT face=Verdana size=2>State:
<%
qry="select nvl(statecode,' ')statecode,nvl(statename,'  ') statename  from  c#statemaster where nvl(deactive,'N')='N'";
//out.print(qry);
rs=db.getRowset(qry);

%>
<SELECT ID="STATE" Name="STATE" tabIndex=18>
<%while(rs.next())
{%>
<option  value="<%=rs.getString("statecode").trim()%>"><%=rs.getString("statename").trim()%></option>

<%}%>
<!--option Value="Delhi" selected >Delhi
<option Value="AndhraPradesh">Andhra Pradesh
<option Value="Arunachal Pradesh">Arunachal Pradesh
<option Value="Assam">Assam
<option Value="Bihar">Bihar
<option Value="Chhattisgarh">Chhattisgarh
<option Value="Goa">Goa
<option Value="Gujarat">Gujarat
<option Value="Haryana">Haryana
<option Value="Himachal Pradesh">Himachal Pradesh
<option Value="JammuandKashmir">Jammu and Kashmir
<option Value="Jharkhand">Jharkhand
<option Value="Karnataka">Karnataka
<option Value="Kerala">Kerala
<option Value="Maharashtra">Maharashtra
<option Value="Meghalaya">Meghalaya</option>
<option Value="Mizoram">Mizoram</option>
<option Value="Nagaland">Nagaland</option>
<option Value="Orissa">Orissa</option>
<option Value="Punjab">Punjab</option>
<option Value="Rajasthan">Rajasthan</option>
<option Value="TamilNadu">Tamil Nadu</option>
<option Value="Tripura">Tripura</option>
<option Value="UttarPradesh">Uttar Pradesh</option>
<option Value="MadhyaPradesh">Madhya Pradesh</option>
<option Value="Uttarakhand">Uttarakhand</option>
<option Value="WestBengal">West Bengal</option>
<option Value="ANI">Andaman and Nicobar Islands</option>
<option Value="Chandigarh">Chandigarh</option>
<option Value="DNH">Dadra and Nagar Haveli</option>
<option Value="DD">Daman and Diu</option>
<option Value="Lakshadweep">Lakshadweep</option>
<option Value="Puducherry">  Puducherry</option>
<option Value="Other">  Other</option-->

</SELECT>&nbsp;
</FONT><FONT face=Verdana size=2>PhoneNo or Moblie No:<input ID="MOBILE" Name="MOBILE"  onkeypress="return isNumber(event)" MaxLength=20 Size=15 tabIndex=19  ></FONT>
</td>
</tr>

<tr>
<td colspan=3>
<FONT face=Verdana> 9. Email Address (Mandatory	):&nbsp; <INPUT ID="email" Name="email" maxLength=50 size=50 tabIndex=20> <FONT  color=#ff4500>*</FONT>
</FONT>
</td>
</tr>

<tr>
<td colspan=3>
<FONT face=Verdana>10. Nationality: &nbsp;&nbsp;&nbsp;&nbsp; <INPUT Type="radio" ID="Nationality" Name="Nationality" Value="INDIAN" Checked tabIndex=21>Indian
&nbsp;&nbsp;&nbsp;<INPUT Type="radio" ID="Nationality" Name="Nationality" Value="FOREIGN" tabIndex=22>Foreign</FONT>
</td>
</tr>


 <TR>
<td colspan=3 align=left><FONT face=Verdana>11. Current Qualification
(Do not forget to attach copy of marks sheet - Mandatory)

 <br>
 <TABLE BORDER=1 ALIGN=center  cellspacing=2 cellpadding=2>
			<tr>
			<td>&nbsp;</td>
			<td><font face='Verdana' size=1 ><b>Year of Completion</b></td>
			<td><font face='Verdana' size=1 ><b>Stream </b></td>
			<td><font face='Verdana' size=1 ><b>Board / University</b></td>
			<td><font face='Verdana' size=1 ><b>% of Marks</b></td>
			</tr>
			<TR>

				<TD><font face='Verdana' size=2 >10th  &nbsp;&nbsp; <FONT  color=#ff4500>*</FONT>

				</TD>
				<TD><INPUT TYPE="text" NAME="TenYear" id="TenYear" tabIndex=23  SIZE=3 MAXLENGTH=4 onkeypress="return isNumber(event)"><font color=red>*</font></TD>
				<td>&nbsp;</td>

				<TD><INPUT TYPE="text" NAME="TenBoard"   size=20 maxlength=50 tabIndex=25><font color=red>*</font></TD>
				<TD><INPUT TYPE="text" NAME="TenPercent" onchange="OnPercent();"   onKeyPress="return numbersonly(this, event);"  SIZE=3 MAXLENGTH=5 tabIndex=26><font color=red>*</font></TD>
			</TR>
			<TR>

				<TD><font face='Verdana' size=2 >12th &nbsp;&nbsp; <FONT  color=#ff4500>*</FONT>

				</TD>
				<TD><INPUT TYPE="text" NAME="TewYear"   SIZE=3 MAXLENGTH=4 tabIndex=27 onkeypress="return isNumber(event)"></TD>
				<TD><select  Id="TewStream" Name="TewStream" onchange="Other(TewStream.value);" tabIndex=28 >
		<option Value="Science" selected >Science	</option>
		<option Value="Arts">Arts	</option>
		<option Value="Commerce">Commerce	</option>
				<option Value="Others">Others
		</option>
		</SELECT>
		<INPUT TYPE="text" NAME="TewStream1" id="TewStream1" MAXLENGTH=30 size=10 tabIndex=28>
		</TD>
					<TD><INPUT TYPE="text" NAME="TewBoard"   size=20 maxlength=50 tabIndex=29></TD>
						<TD><INPUT TYPE="text" NAME="TewPercent" onchange="OnPercent();"  onKeyPress="return numbersonly(this, event);
"  SIZE=3 MAXLENGTH=5 tabIndex=30></TD>
			</TR>

			<%--<TR>
			<TD><font face='Verdana' size=2 >Graduation&nbsp; <FONT  color=#ff4500>*</FONT>

			</TD>
				<TD><INPUT TYPE="text" NAME="GradYear"   SIZE=15 MAXLENGTH=20 tabIndex=31></TD>
				<TD><select  Id="GradStream" Name="GradStream" onchange="Grad(GradStream.value);" tabIndex=32 >
		<option Value="Science" selected >Science	</option>
		<option Value="Arts">Arts	</option>
		<option Value="Commerce">Commerce	</option>
		<option Value="Engineering">Engineering	</option>
		<option Value="Others">Others		</option>
		</SELECT>
 		<INPUT TYPE="text" NAME="GradStream1" id="GradStream1" tabIndex=32  MAXLENGTH=30 size=10 >
		</TD>
					<TD><INPUT TYPE="text" NAME="GradBoard"   size=20 maxlength=50 tabIndex=33></TD>
						<TD><INPUT TYPE="text" NAME="GradPercent"  onchange="OnPercent();" onKeyPress="return numbersonly(this, event);
"  SIZE=3 MAXLENGTH=5 tabIndex=34></TD>
			</TR>--%>


			<%--<TR>
			<TD><font face='Verdana' size=2 >Other(if any)&nbsp;

			</TD>
				<TD><INPUT TYPE="text" NAME="OtherYear"   SIZE=3 MAXLENGTH=4 tabIndex=35 onkeypress="return isNumber(event)"></TD>
				<TD><INPUT TYPE="text" NAME="OtherStream"   SIZE=15 MAXLENGTH=30 tabIndex=36></TD>
				<TD><INPUT TYPE="text" NAME="OtherBoard"   size=20 maxlength=50 tabIndex=37></TD>
				<TD><INPUT TYPE="text" NAME="OtherPercent" onchange="OnPercent();"  onKeyPress="return numbersonly(this, event);
"   SIZE=3 MAXLENGTH=5 tabIndex=38></TD>
			</TR>--%>
			</TABLE>

<FONT face=Verdana><sup>*</sup> If appearing,attach certificate from Head of Institution.[e.g Science/Arts/Commerce/Others(specify)]<br>&nbsp;&nbsp;&nbsp;<b>Click</b>: <INPUT Type="radio" ID="Appear" Name="Appear" Value="Y"  tabIndex=38>Yes &nbsp;
	   <INPUT Type="radio" ID="Appear" Name="Appear"  checked Value="N" tabIndex=38>No


</td>
</tr>
<%--<!--<TR>

<td colspan=3 align=left><br><FONT face=Verdana>10. Please Fill as Applicable  (Attach copy of Score Card Mandatory) <br>



  <br>
	<TABLE BORDER=1 ALIGN=center cellspacing=2 cellpadding=2>
			<tr>
			<td><font face='Verdana' size=1 ><b>Exam</b></td>
			<td><font face='Verdana' size=1 ><b>Month & Yr. of Apppering</b></td>
			<td><font face='Verdana' size=1 ><b>Composite Score/Total Score</b></td>
			<td><font face='Verdana' size=1 ><b>Percentile/Total Percentile	</b></td>
			<td><font face='Verdana' size=1 ><b>Result Valid Upto</b></td>
			</tr>
			<TR>

				<TD><font face='Verdana' size=2 >CAT <font color=red>*</font> &nbsp;&nbsp;
<INPUT Type="hidden" ID="CAT" Name="CAT" Value="CAT" >


				</TD>
				<TD><INPUT TYPE="text" NAME="CATYEAR" value="" Onblur="return CATValidYear();" tabIndex="41"  SIZE=3 MAXLENGTH=6></TD>
				<TD><INPUT TYPE="text" NAME="CATCOMP" value=""  tabIndex="42"  SIZE=3 MAXLENGTH=6></TD>
				<TD><INPUT TYPE="text" NAME="CATPER" value=""  onKeyPress="return numbersonly(this, event); "   SIZE=3 MAXLENGTH=5 tabIndex="43"></TD>
<TD><INPUT TYPE="text" NAME="CATDATE" id="CATDATE"   value=""  onChange="return ValidCATDATE(CATDATE.value) "  onCLICK="return ValidCATDATE(CATDATE.value) "    tabIndex="44"  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('CATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
			</TR>
			<TR>

				<TD><font face='Verdana' size=2 >MAT <font color=red>*</font> &nbsp;&nbsp;

				<INPUT Type="hidden" ID="MAT" Name="MAT" Value="MAT" >

				</TD>
				<TD><INPUT TYPE="text" NAME="MATYEAR" value="" Onblur="return MATValidYear();" tabIndex="45"  SIZE=3 MAXLENGTH=6></TD>
				<TD><INPUT TYPE="text" NAME="MATCOMP" value="" SIZE=3 MAXLENGTH=6 tabIndex="46"></TD>
				<TD><INPUT TYPE="text" NAME="MATPER" value=""  onKeyPress="return numbersonly(this, event);"  SIZE=3 MAXLENGTH=5 tabIndex="47"></TD>
				<TD><INPUT TYPE="text" NAME="MATDATE"  id="MATDATE"  value=""  onClick="return ValidMATDATE(MATDATE.value) "    onChange="return ValidMATDATE(MATDATE.value) "  tabIndex="48"  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('MATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
			</TR>


 <tr>
<TD><font face='Verdana' size=2 >CMAT <font color=red>*</font>&nbsp;
			<INPUT Type="hidden" ID="CMAT" Name="CMAT" Value="CMAT" >
			</TD>
			<TD><INPUT TYPE="text" NAME="CMATYEAR" value=""  tabIndex="49"  SIZE=3 MAXLENGTH=6></TD>
				<TD><INPUT TYPE="text" NAME="CMATCOMP" onkeypress="return isNumber(event)"  value=""  SIZE=3 MAXLENGTH=6 tabIndex="50"></TD>
				<TD><INPUT TYPE="text" NAME="CMATPER" value=""   SIZE=3 MAXLENGTH=5 tabIndex="51"></TD>
				<TD><INPUT TYPE="text" NAME="CMATDATE"  id="CMATDATE"  value=""  onClick="return ValidCMATDATE(CMATDATE.value) " onChange="return ValidCMATDATE(CMATDATE.value) "    tabIndex="52"  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>

</TD>
</tr>


			<TR>

			<TD><font face='Verdana' size=2 >GMAT <font color=red>*</font>&nbsp;
			<INPUT Type="hidden" ID="GMAT" Name="GMAT" Value="GMAT" >
			</TD>
			<TD><INPUT TYPE="text" NAME="GMATYEAR" value=""  Onblur="return GMATValidYear();" tabIndex="53"  SIZE=3 MAXLENGTH=6></TD>
				<TD><INPUT TYPE="text" NAME="GMATCOMP" onkeypress="return isNumber(event)"  value=""  SIZE=3 MAXLENGTH=6 tabIndex=49></TD>
				<TD><INPUT TYPE="text" NAME="GMATPER" value=""   SIZE=3 MAXLENGTH=5 tabIndex="54"></TD>
				<TD><INPUT TYPE="text" NAME="GMATDATE"  id="GMATDATE"  value=""  onClick="return ValidGMATDATE(GMATDATE.value) " onChange="return ValidGMATDATE(GMATDATE.value) "    tabIndex="55"  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('GMATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
            </TR>



			<TR>

			<TD><font face='Verdana' size=2 >XAT <font color=red>*</font>&nbsp;
			<INPUT Type="hidden" ID="XAT" Name="XAT" Value="XAT" >
			</TD>
			<TD><INPUT TYPE="text" NAME="XATYEAR" value=""  Onblur="return XATValidYear();" tabIndex="56"  SIZE=3 MAXLENGTH=6></TD>
				<TD><INPUT TYPE="text" NAME="XATCOMP" onkeypress="return isNumber(event)"  value=""  SIZE=3 MAXLENGTH=6 tabIndex="57"></TD>
				<TD><INPUT TYPE="text" NAME="XATPER" value=""   SIZE=3 MAXLENGTH=5 tabIndex="58"></TD>
				<TD><INPUT TYPE="text" NAME="XATDATE"  id="XATDATE"  value=""  onClick="return ValidXATDATE(XATDATE.value) " onChange="return ValidXATDATE(XATDATE.value) "    tabIndex="59"  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('GMATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
            </TR>
            <TR>

			<TD><font face='Verdana' size=2 >ATMA <font color=red>*</font>&nbsp;
			<INPUT Type="hidden" ID="ATMA" Name="ATMA" Value="ATMA" >
			</TD>
			<TD><INPUT TYPE="text" NAME="ATMAYEAR" value=""  Onblur="return ATMAValidYear();" tabIndex="56"  SIZE=3 MAXLENGTH=6></TD>
				<TD><INPUT TYPE="text" NAME="ATMACOMP" onkeypress="return isNumber(event)"  value=""  SIZE=3 MAXLENGTH=6 tabIndex="57"></TD>
				<TD><INPUT TYPE="text" NAME="ATMAPER" value=""   SIZE=3 MAXLENGTH=5 tabIndex="58"></TD>
				<TD><INPUT TYPE="text" NAME="ATMADATE"  id="ATMADATE"  value=""  onClick="return ValidATMADATE(ATMADATE.value) " onChange="return ValidATMADATE(ATMADATE.value) "    tabIndex="59"  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('GMATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
            </TR>


			<TR>

			<TD><font face='Verdana' size=2 >OTHERS <font color=red>*</font>&nbsp;
			<INPUT Type="hidden" ID="OTHERS" Name="OTHERS" Value="OTHERS" >
			</TD>
			<TD><INPUT TYPE="text" NAME="OTHYEAR" value=""  Onblur="return OTHValidYear();" tabIndex="60"  SIZE=3 MAXLENGTH=6></TD>
				<TD><INPUT TYPE="text" NAME="OTHCOMP" onkeypress="return isNumber(event)"  value=""  SIZE=3 MAXLENGTH=6 tabIndex="61"></TD>
				<TD><INPUT TYPE="text" NAME="OTHPER" value=""   SIZE=3 MAXLENGTH=5 tabIndex=62></TD>
				<TD><INPUT TYPE="text" NAME="OTHDATE"  id="OTHDATE"  value=""  onClick="return ValidOTHDATE(OTHDATE.value) " onChange="return ValidOTHDATE(OTHDATE.value) "    tabIndex=63  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('GMATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
            </TR>




</TABLE>

			</TR> --%>



<%--<TR>

<td colspan=4 align=left><br><FONT face=Verdana>11. Work Experience <br>
  <br>
	<TABLE BORDER=1 ALIGN=center cellspacing=2 cellpadding=2>
			<tr>
			<td><font face='Verdana' size=1 ><b>Postion</b></td>

			<td><font face='Verdana' size=1 ><b>Name of Organisation </b></td>
			<td><font face='Verdana' size=1 ><b>Job Profile</b></td>
			<td><font face='Verdana' size=1 ><b>Duration From</b></td>
			<td><font face='Verdana' size=1 ><b>Duration To</b></td>
			</tr>

			<%
				for(int i=1; i<=3;i++)
				{
				%>
			<TR>

				<TD valign="top"> <INPUT TYPE="text" NAME="DESIGNATION<%=i%>" id="DESIGNATION<%=i%>"  tabIndex=64 SIZE=25 MAXLENGTH=200>
				</TD>

			<TD valign="top">
				<INPUT TYPE="text" NAME="COMPANY<%=i%>" id="COMPANY<%=i%>"  tabIndex=65  SIZE=25 MAXLENGTH=200>
				</TD>
				<TD valign="top">
				<INPUT TYPE="text" NAME="AREA<%=i%>" id="AREA<%=i%>"    tabIndex=66  SIZE=25 MAXLENGTH=200>
				</TD>



				<TD >
				<INPUT TYPE="text" NAME="WORKDATEFROM<%=i%>"   id="WORKDATEFROM<%=i%>"  onchange="return ValidDateFrom('WORKDATEFROM<%=i%>') ;"   tabIndex=67  SIZE=8 MAXLENGTH=10>
				<font color=green face=arialblack> <font size=1><b> <Br>(DD-MM-YYYY)&nbsp;</b></font>
				</TD>
				<TD>
				<INPUT TYPE="text" NAME="WORKDATETO<%=i%>" id="WORKDATETO<%=i%>"   tabIndex=68  SIZE=8 MAXLENGTH=10  onchange="return ValidDateTo('WORKDATETO<%=i%>'); " >
				<font color=green face=arialblack> <font size=1><b> <br>(DD-MM-YYYY)&nbsp;</b></font>
				</TD>
			</TR>
			<%
				}
					%>


			</TABLE>

</td></TR>







</td></TR>--%>

<TR>

<td align=left><br><FONT face=Verdana>12.DD No 
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="dd" id="dd" maxlength=200 tabIndex=46  size=20 >
<FONT face=Verdana>Date
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="dddate" id="dddate" onchange="return iSValidDate(dddate.value)"   maxlength=10 tabIndex=47  size=20 >
  <FONT face=Verdana>Amount
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="ddamount" id="ddamount" maxlength=6 tabIndex=48  size=20 >
  <FONT face=Verdana>Bank Name
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="ddbankname" id="ddbankname" maxlength=200 tabIndex=49  size=20 >
</td>
</tr>

<TR>

<td align=left><br><FONT face=Verdana>13.Name of the Account Holder
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="acname" id="acname" maxlength=100 tabIndex=50  size=20 >
<FONT face=Verdana>Bank Name
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="acbankname" id="acbankname" maxlength=100 tabIndex=51  size=20 >
  <FONT face=Verdana>Account No  &nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="acno" id="acno" maxlength=100 tabIndex=52  size=20 >
  
 
</td>
</tr>

<TR>
    <TR>

<td align=left><br>
<FONT face=Verdana>Branch Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="acbranch" id="acbranch" maxlength=100 tabIndex=52  size=20 >
  <FONT face=Verdana>Address of Bank
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="acaddress" id="acaddress" maxlength=200 tabIndex=53  size=20 >
  <FONT face=Verdana>IFSC Code
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="acifsc" id="acifsc" maxlength=50 tabIndex=54  size=20 >
  <br>
</td>
</tr>

<%--<TR>

<td colspan=4 align=left><br><FONT face=Verdana>13. Describe how will the JBS MBA help you in achieving the above career goal ? <br>
  &nbsp;&nbsp;&nbsp; <INPUT TYPE="text" NAME="Careergoal" id="Careergoal" maxlength=1000 tabIndex=45  size=120 >

</td>
</tr>
--%>

	<tr><td colspan=2>
 	    	<font face='Verdana' size=2 >
                    <br>
14. Documents Attached :  CheckSheet <br>
a) 10TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;<INPUT Type="checkbox" ID="Doc10" Name="Doc10" Value="Y" tabIndex=45 >

<br>
b) 12TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp;<INPUT Type="checkbox" ID="Doc12" Name="Doc12" Value="Y" tabIndex=46>
	 	   <br>
<%--c) Graduation  :  &nbsp;&nbsp;  &nbsp;   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp; &nbsp;&nbsp;&nbsp;<INPUT Type="checkbox" ID="DocGrade" Name="DocGrade" Value="Y" tabIndex=47>
<br>
d) Other  :  &nbsp;&nbsp;  &nbsp;   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp; <INPUT Type="checkbox" ID="DocOther" Name="DocOther" Value="Y" tabIndex=47>
	 	   <br>
e) Score Card of CAT/MAT/CMAT/GMAT :&nbsp;<INPUT Type="Checkbox" ID="DocScore" Name="DocScore" Value="Y" tabIndex=48>
	  <br>--%>

<tr>
<td colspan=3>
<FONT face=Verdana>
15.
<%
	if(mCheckDD==1)
	{
	%>
&nbsp;
	Purchased Form	of Rs. 500/-<br>
	<%
	}
	else
	{
		%>

 Registration fee of Rs. 1,000/- by a Demand Draft favoring Jaypee Business
School, payable at Noida (UP) 201 307
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DD Number: <input ID="DDNO" Name="DDNO" MaxLength=6 Size=10 tabIndex=51 onkeypress="return isNumber(event)"><FONT 
      color=#ff4500>*</FONT>
DD Amount: <input ID="DDAMT" Name="DDAMT" MaxLength=4 Size=4 onkeypress="return isNumber(event)" tabIndex=52 ><FONT color=#ff4500>*</FONT><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DD Date:  <font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font><FONT
      color=#ff4500>*</FONT>
    </FONT>   <INPUT TYPE="text" NAME="DDDATE" ID="DDDATE" onChange="return iSValidDDDate(DDDATE.value) " size=9  MaxLength=10  tabindex=53
	>

	<!-- <a href="javascript:NewCal('DDDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT face=Verdana> Drawn on/Bank Name:</FONT> <INPUT size=30 maxlength=150 Id="BANK" Name="BANK" tabIndex=54><FONT color=#ff4500>*</FONT>&nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
	}
	%>

</FONT>
</td>
</tr>
 <%--<tr><td><font size="03%"> 16. Mention three GD/PI Center preferences, where you would like to attend. &nbsp;(1=First choice, 2=Second Choice and 3=Third Choice) </font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                             <%

                                                String qryyr = "Select  nvl(LOCATIONCODE,' ')LOCATIONCODE,nvl(LOCATIONNAME,' ')LOCATIONNAME from C#MBALOCATIONMASTER";

                                                for (int a = 1; a <= 3; a++) {

                                                                            %>


                                                                    &nbsp; <font size="02"><b><%=a%>:-&nbsp;</b></font>


                                                                            <select  width="150" style="width: 150px" name ='location<%=a%>'   id='location<%=a%>' onChange="Dulicatecheck('location<%=a%>','<%=a%>')" style="Width:80" >
                                                                                <%

                                                                                 rss12 = db.getRowset(qryyr);
                                                                                %> <option selected value="NULL">Select</option> <%
                                                                                 while (rss12.next()) { 
                                                                                     location = rss12.getString("LOCATIONNAME");
                                                                                     locationcode=rss12.getString("LOCATIONCODE");
                                                                                %><option value="<%=locationcode%>"><%=location%></option>
                                                                                <%}%>
                                                                            </select>
                                                                       
                                                                    <%}%>
                                                                    </tr></table> --%>
              
<table align=center >

<tr>
<td align=center colspan=5>
<INPUT id=button1 type="Submit" value="Save" LANGUAGE="javascript" onClick="return button1_onclick('<%=mCurrDate%>');" tabIndex=55>&nbsp;&nbsp;<INPUT id=button2 type=reset value="Reset" tabIndex="56"></td></tr>
</table>

<%

}
else
{

out.print("<img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Application No. Already Exists <br>");

}


}
else
	{
out.print("<img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Enter Application No.<br>");

	}


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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	</font>	<br>	<br>	<br>	<br>
   <%


   }
  //-----------------------------



}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
// out.print("aaaaaaaaaaaaa");
}
%>
</form>
<br>
</BODY></HTML> 