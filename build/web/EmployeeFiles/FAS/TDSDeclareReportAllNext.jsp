<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try{

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Tax Decleration Form/Screen] </TITLE>




<script type="text/javascript" src="js/sortabletable.js"></script>
	<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
	<script language="JavaScript" type ="text/javascript" src="../PersonalInfo/js/datetimepicker.js"></script>
<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>

<script language=javascript>

	function RefreshContents()
	{ 	
    	document.frm.x.value='ddd';
    	document.frm.submit();
	}
//-->
</SCRIPT>
<script>


function Validate()
{

		var sn=document.TDS.sno.value;
	var othersno=document.TDS.parasno.value;
	var flag=0,flag1=0;
	var finalflag=0,finalflag1=0;

for (var i=1; i<=sn ; i++)
	{
if(document.getElementById("DeclarationAmt"+i)==null)
		{
			//flag=1;
		}		
else if(document.getElementById("DeclarationAmt"+i).value!='')
		{
			flag=1;
			//alert(i +"iiii"+flag);			
		}

		if(document.getElementById("ReceiptAmt"+i)==null)
		{
			//flag=1;
		}		
else if(document.getElementById("ReceiptAmt"+i).value!='')
		{
			finalflag=1;
			//alert(i +"iiii"+flag);			
		}
	}

//alert(othersno+"othersnoothersno");
for (var j=1; j<=othersno ; j++)
	{
//alert(document.getElementById("DeclarationAmt"+i)+"88888");

if(document.getElementById("IAMOUNT"+j)==null)
		{
			//flag=1;
		}		
else if(document.getElementById("IAMOUNT"+j).value!='')
		{
			flag1=1;
			//alert(i +"iiii"+flag);			
		}

		if(document.getElementById("ACTUALAMOUNT"+j)==null)
		{
			//flag=1;
		}		
else if(document.getElementById("ACTUALAMOUNT"+j).value!='')
		{
			finalflag1=1;
			//alert(i +"iiii"+flag);			
		}
	}




//alert("sdfsdfsfsfsffsdfsdfsf");
/*if(flag==0 )
		{
			 if(flag1!=0)
			{
				//alert("done done ");
				return true;
			}
			else
			{
			alert("Please Enter Declaration Amount !");
			return false;
			}


		}*/

if(finalflag==0 )
		{
			 if(finalflag1!=0)
			{
				//alert("done done ");
				return true;
			}
			else
			{
			alert("Please Enter Receipt Amount !");
			return false;
			}


		}



if((document.getElementById("ReceiptAmt"+13).value=='') || (document.getElementById("ReceiptAmt"+13).value==null))
	{
	//alert(document.TDS.PARAMETERVALUE.value+"sdsfd");
if((document.getElementById("DeclarationAmt"+13).value!='') &&  (document.TDS.PARAMETERVALUE.value==' ' ||  document.TDS.PARAMETERVALUE.value==null || document.TDS.PARAMETERVALUE.value==''))
		{
			alert("Please Enter the Date of Possession !");
			document.TDS.PARAMETERVALUE.disabled=false;
			TDS.PARAMETERVALUE.focus();
			return false;
		}
if ((document.getElementById("DeclarationAmt"+13).value=='' ) &&  (document.TDS.PARAMETERVALUE.value!='' ))
	{
			alert("Please Enter Declaration Amount against Date of Possession !");
			//document.TDS.PARAMETERVALUE.disabled=false;
			//TDS.PARAMETERVALUE.focus();
			return false;
	
	}
	}
	
		if((document.getElementById("ReceiptAmt"+13).value!='') &&  (document.TDS.PARAMETERVALUE.value==' ' ||  document.TDS.PARAMETERVALUE.value==null || document.TDS.PARAMETERVALUE.value==''))
		{
			alert("Please Enter the Date of Possession !");
			document.TDS.PARAMETERVALUE.disabled=false;
			TDS.PARAMETERVALUE.focus();
			return false;
		}
if ((document.getElementById("ReceiptAmt"+13).value=='' ) &&  (document.TDS.PARAMETERVALUE.value!='' ))
	{
			alert("Please Enter Receipt Amount against Date of Possession !");
			//document.TDS.PARAMETERVALUE.disabled=false;
			//TDS.PARAMETERVALUE.focus();
			return false;
	
	}
	
	
	var pDate1=document.TDS.PARAMETERVALUE.value;
	var mSysdates=document.frm.sysdates.value;
var mDate1=pDate1.substring(10,6)+pDate1.substring(5,3)+pDate1.substring(2,0);
//alert(document.TDS.PARAMETERVALUE.value+"dfgdgf"+mSysdates+"xxx"+mDate1+"aca"+(mDate1 > mSysdates));

	if(mDate1 > mSysdates)
	{
		alert("Please do not enter future date in Date of Possession !");
			document.TDS.PARAMETERVALUE.disabled=false;
			TDS.PARAMETERVALUE.focus();
			return false;
	}
	//return false;
if(document.frm.Panno.value==null || document.frm.Panno.value=='')
	{
		alert("Please enter your PAN No. ");
		frm.Panno.focus();
		return false;
	}

	if(document.frm.Panno.value.length <10 )
	{
		alert("PAN No. should be of 10 characters");
		frm.Panno.focus();
		return false;
	}


if(document.TDS.PrintFreeze.value=="Freeze & Submit")
{

//window.print();

var answer=confirm('Are you sure,you want to Freeze ? After this  action you cannot change your declaration !');

if (answer ==1)
{
return true;
}
else if (answer==0)
{
return false;
}

}
//return false;
}

function ValidatePan()
{
//	alert(document.frm.Panno.value.length+"sdfsf");
if(document.frm.Panno.value==null || document.frm.Panno.value=='')
	{
		alert("Please enter your PAN. ");
		frm.Panno.focus();
		return false;
	}

	if(document.frm.Panno.value.length <10 )
	{
		alert("Invalid PAN..!! Enter Correct PAN.");
		frm.Panno.focus();
		return false;
	}

}

function capitalchar()
{
    document.frm.Panno.value=document.frm.Panno.value.toUpperCase();
}

function checkOtherPara()
{
alert("sdf");
document.TDS.PARAMETERVALUE.disabled=false;

//if(document.TDS.PARAMETERVALUE.)
}


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

function Validatedate()
{

	var sn=document.TDS.sno.value;
	var othersno=document.TDS.parasno.value;
	var flag=0,flag1=0;

		var finalflag=0,finalflag1=0;

for (var i=1; i<=sn ; i++)
	{
//alert(document.getElementById("DeclarationAmt"+i)+"88888");

if(document.getElementById("DeclarationAmt"+i)==null)
		{
			//flag=1;
		}		
else if(document.getElementById("DeclarationAmt"+i).value!='')
		{
			flag=1;
			//alert(i +"iiii"+flag);			
		}

		if(document.getElementById("ReceiptAmt"+i)==null)
		{
			//flag=1;
		}		
else if(document.getElementById("ReceiptAmt"+i).value!='')
		{
			finalflag=1;
			//alert(i +"iiii"+flag);			
		}
	}

//alert(othersno+"othersnoothersno");
for (var j=1; j<=othersno ; j++)
	{
//alert(document.getElementById("DeclarationAmt"+i)+"88888");

if(document.getElementById("IAMOUNT"+j)==null)
		{
			//flag=1;
		}		
else if(document.getElementById("IAMOUNT"+j).value!='')
		{
			flag1=1;
			//alert(i +"iiii"+flag);			
		}

		if(document.getElementById("ACTUALAMOUNT"+j)==null)
		{
			//flag=1;
		}		
else if(document.getElementById("ACTUALAMOUNT"+j).value!='')
		{
			finalflag1=1;
			//alert(i +"iiii"+flag);			
		}
	}




//alert("sdfsdfsfsfsffsdfsdfsf");
/*if(flag==0 )
		{
			 if(flag1!=0)
			{
				//alert("done done ");
				return true;
			}
			else
			{
			alert("Please Enter Declaration Amount !");
			return false;
			}


		}*/

if(finalflag==0 )
		{
			 if(finalflag1!=0)
			{
				//alert("done done ");
				return true;
			}
			else
			{
			alert("Please Enter Receipt Amount !");
			return false;
			}


		}

if((document.getElementById("ReceiptAmt"+13).value=='') || (document.getElementById("ReceiptAmt"+13).value==null))
	{
	//alert(document.TDS.PARAMETERVALUE.value+"sdsfd");
if((document.getElementById("DeclarationAmt"+13).value!='') &&  (document.TDS.PARAMETERVALUE.value==' ' ||  document.TDS.PARAMETERVALUE.value==null || document.TDS.PARAMETERVALUE.value==''))
		{
			alert("Please Enter the Date of Possession !");
			document.TDS.PARAMETERVALUE.disabled=false;
			TDS.PARAMETERVALUE.focus();
			return false;
		}
if ((document.getElementById("DeclarationAmt"+13).value=='' ) &&  (document.TDS.PARAMETERVALUE.value!='' ))
	{
			alert("Please Enter Declaration Amount against Date of Possession !");
			//document.TDS.PARAMETERVALUE.disabled=false;
			//TDS.PARAMETERVALUE.focus();
			return false;
	
	}
	}
	
	if((document.getElementById("ReceiptAmt"+13).value!='') &&  (document.TDS.PARAMETERVALUE.value==' ' ||  document.TDS.PARAMETERVALUE.value==null || document.TDS.PARAMETERVALUE.value==''))
		{
			alert("Please Enter the Date of Possession !");
			document.TDS.PARAMETERVALUE.disabled=false;
			TDS.PARAMETERVALUE.focus();
			return false;
		}
if ((document.getElementById("ReceiptAmt"+13).value=='' ) &&  (document.TDS.PARAMETERVALUE.value!='' ))
	{
			alert("Please Enter Receipt Amount against Date of Possession !");
			//document.TDS.PARAMETERVALUE.disabled=false;
			//TDS.PARAMETERVALUE.focus();
			return false;
	
	}
	
	
	
	var pDate1=document.TDS.PARAMETERVALUE.value;
	var mSysdates=document.frm.sysdates.value;
var mDate1=pDate1.substring(10,6)+pDate1.substring(5,3)+pDate1.substring(2,0);
//alert(document.TDS.PARAMETERVALUE.value+"dfgdgf"+mSysdates+"xxx"+mDate1+"aca"+(mDate1 > mSysdates));

	/*if(mDate1 > mSysdates)
	{
		alert("Please do not enter future date in Date of Possession !");
			document.TDS.PARAMETERVALUE.disabled=false;
			TDS.PARAMETERVALUE.focus();
			return false;
	}*/
	//return false;
if(document.frm.Panno.value==null || document.frm.Panno.value=='')
	{
		alert("Please enter your PAN No. ");
		frm.Panno.focus();
		return false;
	}

	if(document.frm.Panno.value.length <10 )
	{
		alert("PAN No. should be of 10 characters");
		frm.Panno.focus();
		return false;
	}
}



function iSValidDate(pDate)
{

//1 
if(document.TDS.PARAMETERVALUE.value!="" && document.TDS.PARAMETERVALUE.value!=" ")
{
    var dn, mn, yn, maxday;
    var mDate = pDate;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDate = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if (parseInt(mDate.substring(0,2).trim()) >= 1 &&
              parseInt(mDate.substring(0,2).trim()) <=31 &&
              parseInt(mDate.substring(3, 5).trim()) <= 12 &&
              parseInt(mDate.substring(3, 5).trim()) >= 1 &&
              parseInt(mDate.substring(6).trim()) >= 1900 &&
              parseInt(mDate.substring(6).trim()) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2).trim());
            mn = parseInt(mDate.substring(3,5).trim());
            yn = parseInt(mDate.substring(6).trim());
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
  			alert('Please Enter the valid date format in Date of Possession  field i.e DD-MM-YYYY.'); 
			document.TDS.PARAMETERVALUE.value="";
			TDS.PARAMETERVALUE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in Date of Possession  field i.e DD-MM-YYYY.'); 
			document.TDS.PARAMETERVALUE.value="";
			TDS.PARAMETERVALUE.focus();
		  }
      } //3
	  else
		  {
		  alert('Please Enter the valid date format in Date of Possession field i.e DD-MM-YYYY.'); 
			document.TDS.PARAMETERVALUE.value="";
			TDS.PARAMETERVALUE.focus();
		  }
 //   } //2
  return (mISValidDate);
}
else
	 {
		  alert('Please Enter the valid date format in Date of Possession  field i.e DD-MM-YYYY.'); 

	 }




}

</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mFinYear="";
String mDMemberCode="",mDDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String mExam="",mexam="",mFacltyID="",mSubj="",msubj="";
String qry="",qry1="",qry2="",qry3="",x="",qrymEventsubevent="",mTDSCode="E";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0,mchkmarks=0;
String mmvalue="";
String mEdCode="",qrymEdCode="",mCatCode="";
int ctr=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mFaculty=""; 
ResultSet rsSub =null,rs=null,rss=null,rs1=null,rs2=null,rs3=null,rsfac=null,rse=null,rsm=null,rsi=null,rstable=null,rsTableData=null,rsTime=null;
String mMOP="",mName5="",mlistorder="",qrymCatCode="",mSysdate1="";		

int kk=0,i=0;	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName8="";
String mName6="",mName7="";		
String mFacltyID1="",mSubj1="",qrymFinYear="",finyear="",msubj1="";
String mType="";
int mRights=0,j=0,p=0,k=0;
String SubQry="",mySub="";
String mDMemberType="I",mCOMPASSESSMENT="";
String mComp="",mAssesmentYear="",mTDSDesc="",mFinancialYear="",mFINANCIALYEAR1="";			
String mSave="0",mEDTYPE="";			
String mAssYear="",qrymAssYear="";
		String mDeclAmt="",mActAmt="";
	double mTotalSalary=0,mRecvDeclAmount=0;
	double mTaxAmount=0,mPaidTaxAmount=0,mTotalIncome=0;

  String mStatus="",mFreeze="",mTextReadonly="";


if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
	


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}


if (request.getParameter("Faculty")==null)
{
	mMemberID="";
}
else
{
	mMemberID=request.getParameter("Faculty").toString().trim();
}





if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


	qry="select distinct nvl(EMPLOYEENAME,' ')EMPLOYEENAME ,nvl(employeeid,' ')employeeid, nvl(employeename,' ')FacultyName,nvl(employeecode,' ')employeecode,nvl(EMPLOYEETYPE,' ')EMPLOYEETYPE from employeemaster where ";
	qry=qry +" companycode='"+mComp+"' and nvl(deactive,'N')='N' and employeeid='"+mMemberID+"'  ";
	//out.print(qry);
	rs=db.getRowset(qry);
	if(rs.next())
	{
mMemberCode=rs.getString("employeecode").toString().trim();
//mMemberType=rs.getString("EMPLOYEETYPE").toString().trim();
mMemberID=rs.getString("employeeid").toString().trim();
mMemberName=rs.getString("EMPLOYEENAME").toString().trim();
	}

mMemberType="E";
OLTEncryption enc=new OLTEncryption();
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
  {
	mDMemberCode=mMemberCode;
	mDDMemberType=mMemberType;
	mDMemberID=mMemberID;

	String mChkMemID=mMemberID;
	String mChkMType=mMemberType;

	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk1=null;
	ResultSet r=null;

	
	// ------------------------------
	// out.print(qry);
	// ------------------------------
      // -- Enable Security Page Level  
      // ------------------------------

	if(mType.equals("D"))
	{
	   mRights=166;
	}
	else if(mType.equals("H"))
	{
	   mRights=167; 	
	}
	else 
		//if(mType.equals("I"))
	{
	   mRights=168;
	}
qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";	
      RsChk1= db.getRowset(qry);
	
	//out.print(qry);

	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{



qry="Select TDSCODE ,TDSDESC From TDS#TDSMASTER Where COMPANYCODE='"+mComp+"' And SLTYPE='"+mMemberType+"'";
//out.print(qry);
	r=db.getRowset(qry);	
	if( r.next() )
	{
	   mTDSCode=r.getString("TDSCODE");
	   mTDSDesc=r.getString("TDSDESC");
	}	


   
	  //----------------------
String mSysdate="",mDateFrom="",mDateTo="",mFYear="",Panno="",Gender="", mFinYear1="",mDOB="",mSeniorCitizen="";
String mYearFrom="",mSrCitizen="",Gender1="";
		int mEmpAge=0,mSeniorCitizenAge=0;

		qry="SELECT to_char(FROMPERIOD,'dd-mm-yyyy')FROMPERIOD, to_char(TOPERIOD,'dd-mm-yyyy')TOPERIOD, NVL(STATUS,'N')STATUS ,NVL(ASSESSMENTYEAR,' ')ASSESSMENTYEAR , NVL(FINYEAR,' ')FINYEAR		FROM TDS#PARAMETER where  COMPANYCODE='"+mComp+"' ";
		//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
		{
		mDateFrom=rs.getString("FROMPERIOD");
		mDateTo=rs.getString("TOPERIOD");
		mStatus=rs.getString("STATUS");
		mAssYear=rs.getString("ASSESSMENTYEAR");
		mFYear=rs.getString("FINYEAR");
		

	 mFinYear1= "20"+mFYear.substring(0,2)+"-20"+mFYear.substring(2,4);

		qry1="select nvl(a.panno,' ')panno,nvl(sex,'N')sex1,decode(b.sex,'M','Male','F','Female',b.sex)sex,nvl(to_char(DateofBirth, 'dd-mm-yyyy'),'N')DOB from employeedetail a,employeemaster b where a.EMPLOYEEID='"+mChkMemID+"' and a.employeeid=b.employeeid ";

		rs1=db.getRowset(qry1);
		if(rs1.next())
			{
			Panno=rs1.getString("panno").toString().trim();
			Gender=rs1.getString("sex");
			Gender1=rs1.getString("sex1");
			mDOB=rs1.getString("DOB");

			}

		if(mDOB.equals("N"))
			{
				mSeniorCitizen="N";
			}
		else
			{
				qry2=" Select to_char(YearFrom,'dd-mm-yyyy')YearFrom   From   FinancialYearMaster         Where         CompanyCode    = '"+mComp+"' And FinancialYearCode ='"+mFYear+"'  ";
				rs2=db.getRowset(qry2);
				if(rs2.next())
					mYearFrom=rs2.getString("YearFrom");

				
				qry1="select To_Number(SubStr((COMMON.Period(TO_DATE('"+mDOB+"' ,'DD-MM-YYYY'), TO_DATE('"+mYearFrom+"','DD-MM-YYYY'),'YYMMDD')),1,2))age  from employeemaster where employeeid='"+mChkMemID+"' ";
				//out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
					mEmpAge=rs1.getInt("age");


				qry=" Select    nvl(SeniorCitizenAge,0)SeniorCitizenAge    From         Tds#AssessmentYear   Where     to_char(to_number(Substr(AssessmentYear,3,2))-1)||Substr(AssessmentYear,3,2) = '"+mFYear+"'  And         CompanyCode     = '"+mComp+"' And RowNum  = 1";
				rs=db.getRowset(qry);
				if(rs.next())
					mSeniorCitizenAge=rs.getInt("SeniorCitizenAge");

				
					if(mEmpAge>=mSeniorCitizenAge)
						mSeniorCitizen="Y";
					else
						mSeniorCitizen="N";
				


			}


			//	out.print(mEmpAge+"mEmpAge"+mSeniorCitizenAge);

		%>	
	<Table ALIGN=CENTER BottomMargin=0  Topmargin=0>
		<tr><TD align=middle>
			<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>Tax Declaration Form</b></font>
		    </td>
		</tr>
	</table>

	<form name="frm" method=post>
	<INPUT TYPE="hidden" NAME="Faculty" id="Faculty" value="<%=mMemberID%>">
	<table bordercolor=maroon cellpadding=1 cellspacing=1  align=center rules=groups  border=1  >
		<input id="x" name="x" type=hidden>
				<input id="x" name="x" type=hidden>
		<tr>
		<td>
		<font face=arial size=2><STRONG>
		&nbsp;Employee Name 
		</STRONG></FONT>
		</td>
	
		<%
		if(!mDesg.equals("DEAN"))
		{
		%>
			<td  ><input type=text name="Employeename" value="<%=mMemberName%>" readonly size=30>
			</td>
			<td>
			<font  face=arial size=2><STRONG>Designation 
			</TD>
			<TD>
			<input type=text name="Designation" size=30 value="<%=GlobalFunctions.toTtitleCase(mDesg)%>" readonly >
			</td>
		<%
		}
		else
		{
		%>
			<td>
			<input type=text name="Employeename" value="<%=mMemberName%>" readonly size=30 >
			</td>
			<td>
			<font  face=arial size=2><STRONG>Designation
			</TD>
			<TD>
			<input type=text name="Designation" size=30 value="<%=GlobalFunctions.toTtitleCase(mDesg)%>" readonly ></td>
		<%
		}
		%>
		<!-- Institute **************** ********************** *******************-->
		
		<INPUT Type="Hidden" Name="Inst" id=Inst Value=<%=mInst%>>
		
	
</tr>

<tr>

<td>
<FONT face=Arial size=2><STRONG>&nbsp;Employee Code  
</td>
<td>
<INPUT TYPE="text" NAME="EmployeeCode" value="<%=mDMemberCode%>" size=6 readonly >
</td>
<%
	if(request.getParameter("Panno")==null || request.getParameter("Panno").equals(""))
			{
				//if(request.getParameter("Panno")==null || request.getParameter("Panno").equals(""))
				Panno=Panno;
			}
			else
			{
				Panno=request.getParameter("Panno").toString().trim();
			}
	%>


<td>
<FONT face=Arial size=2><STRONG>PAN   
</td>
<td>
<INPUT TYPE="text" NAME="Panno" id="Panno" value="<%=Panno%>" maxlength=10
onchange="return capitalchar();"  onKeyPress="return capitalchar();"  >
<FONT COLOR="RED" FACE="ARIAL">*</FONT>
</td>

</tr>

<tr>

<td>
<FONT face=Arial size=2><STRONG>&nbsp;Gender  
</td>
<td>
<input type=text Value ="<%=Gender%>" Name="Gender" size=6  tabindex="0" id="Gender" readonly>		

	</td>
<%
if(mSeniorCitizen.equals("Y"))
		mSrCitizen="YES";
	else
		mSrCitizen="NO";

		%>

<td>
<FONT face=Arial size=2><STRONG>Senior Citizen  
</td>
<td>
<INPUT TYPE="text" NAME="SrCitizen" id="SrCitizen" value="<%=mSrCitizen%>" size=3 readonly >

</td>
</tr>

<tr>
<td>
<FONT face=Arial size=2><STRONG>&nbsp;Assessment Year  
</td>
<td>
<input type=text Name="ASSESYEAR"  tabindex="0" id="ASSESYEAR"  Value ="<%=mAssYear%>" size=8 readonly>
</td>
<td nowrap>

	<FONT color=black><FONT face=Arial size=2><STRONG>Financial Year  </STRONG></FONT>
	
	</TD>
	<TD>
	<input type Name="FINANCIALYEAR1"  tabindex="0" id="FINANCIALYEAR1" size=8 Value ="<%=mFinYear1%>" readonly>
	<INPUT TYPE="hidden" NAME="FINANCIALYEAR" id="FINANCIALYEAR" Value ="<%=mFYear%>" >
	</td>

</tr>



<% 


qry="select to_char(sysdate,'dd-mm-yyyy')sysdate1,to_char(sysdate,'yyyymmdd')sysdate2  from dual ";
rs=db.getRowset(qry);
if(rs.next())
			{
	mSysdate=rs.getString("sysdate1");
mSysdate1=rs.getString("sysdate2");
			}

	%>
<input type=hidden name="sysdates" id="sysdates" value="<%=mSysdate1%>">
<tr>
<td nowrap>
<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Declaration Date</strong>
</font>
</td>
<td>
<INPUT TYPE="text" NAME="DECLARATIONDATE" ID="DECLARATIONDATE" size=9 tabindex=1 VALUE='<%=mSysdate%>' readonly>

</td>

<td nowrap colspan=2>
<marquee style="FONT-FAMILY: fantasy; FONT-SIZE: smaller; FONT-VARIANT: normal; FONT-WEIGHT: normal; HEIGHT: 15px; WIDTH: 297px" behavior=alternate  scrolldelay=200><FONT face="Arial" size=2 color=blue><b>Submission Date from <%=mDateFrom%> to <%=mDateTo%></b></FONT></marquee>
</td>

</tr>

<tr>
<td colspan=4 align=center>
<INPUT TYPE="submit" name="submit" value="Submit" onclick="return ValidatePan();">
</td></tr>
</table>
</Form>

<%
if(request.getParameter("x")!=null)
		{
	

//out.print(mSeniorCitizen+"sadfsdmSeniorCitizen"+Gender1);	
	%>
<form Name="TDS" Action='TDSDeclareReportAllNextAction.jsp' method=post >
<input type="hidden" name="y" id="y" >
<INPUT TYPE="hidden" NAME="Faculty" id="Faculty" value="<%=mMemberID%>">

<input id="x" name="x" type="hidden">


<%


String  mFinal="",mAReceipt="",mDeclareDate="",mCatCodee="",mEDCODE="",mAssessYear="",mDisablecombo="";
	
long mReceiptAmt=0,mDeclareAmt=0;

mFinancialYear=request.getParameter("FINANCIALYEAR");

mDeclareDate=request.getParameter("DECLARATIONDATE");
mAssessYear=request.getParameter("ASSESYEAR");

Panno=request.getParameter("Panno").toString().trim().toUpperCase();

%>
<INPUT TYPE="hidden"NAME="Panno" id="Panno" value="<%=Panno%>" >
<INPUT TYPE="hidden"NAME="SrCitizen" id="SrCitizen" value="<%=mSrCitizen%>" >
<INPUT TYPE="hidden" NAME="FINANCIALYEAR1" id="FINANCIALYEAR1" Value ="<%=mFinYear1%>">

	<INPUT TYPE="hidden" NAME="mFinancialYear" value="<%=mFinancialYear%>" id="mFinancialYear">
	<INPUT TYPE="hidden" NAME="mDeclareDate" value="<%=mDeclareDate%>" id="mDeclareDate">
	<INPUT TYPE="hidden" NAME="mAssessYear" value="<%=mAssessYear%>" id="mAssessYear">
	<INPUT TYPE="hidden" NAME="mTDSCode" value="<%=mTDSCode%>" id="mTDSCode">

<%
	
try
  {

	
		

 qry1="select  nvl(FREEZE,' ')FREEZE  from TDS#EDIDECLARATIONHEADER where  COMPANYCODE='"+mComp+"' and  TDSCODE='"+mTDSCode+"' and ASSESSMENTYEAR='"+mAssessYear+"' and EMPLOYEEID='"+mDMemberID+"' ";
// out.print(qry1);
rs=db.getRowset(qry1);
if(rs.next())
	mFreeze=rs.getString("FREEZE");
	

	/*if(mFreeze.equals("Y"))
	  {
		mTextReadonly="readonly";
		mDisablecombo="disabled";
	  }
	else
	  {*/
		mTextReadonly=" ";
		mDisablecombo="";
	//  }



	%>

<TABLE valign=top  align=center rules=rows cellSpacing=1 cellPadding=1 width="100%" border=1 >
<thead>
<tr bgcolor="#ff8c00"><td colspan=6 align=center ><Font face='arial' size=3 color='white'><b>Available Option</b></font>
    </td>
<tr bgcolor="#ff8c00" >
		<td align=center><Font face='arial' COLOR=WHITE size=3><b>Sr.No.</b></font></td>
	<!-- 	<td align=left><Font face='arial' size=2 COLOR=WHITE ><b>Section</b></font></td> -->
		<td align=left><Font face='arial' size=3 COLOR=WHITE ><b>Proposed Tax Saving Investment/Payments </b></font></td>
		<!-- <td align=center><Font face='arial' size=2><b>Category Code</b></font></td> -->

	<td align=center><Font face='arial' size=3 COLOR=WHITE ><b>Declaration Amount </b></font></td>

<%
	if(mStatus.equals("F"))
	  {
	%>
	<td align=center><Font face='arial' size=3 COLOR=WHITE ><b>Receipt Amount </b></font></td>
	
	<%
	  }
		%>

</Tr>
</thead>
<%

int sno=0,srno=0;
String mEDITYPE="",mEDIDCODE="",FINAL="",sectionCode="",CATEGORYCODE="",sectionCode1="",mOtherPara="",mParaValue="";
String	monClick="",mdisable="";
/*qry="SELECT a.edicode, b.eddescription,A.EDITYPE,decode(A.EDITYPE,'E','Earnings','I','Investment','D','Deduction',a.EDITYPE)EDTypeDescription , a.EDICode CategoryCode,a.EDICode CategoryDescription  FROM tds#edideclaration a, edmaster b WHERE a.companycode = '" + mComp + "'   AND a.tdscode = '"+mTDSCode+"'   AND a.finyear = '"+mFinancialYear+"'   AND b.companycode = a.companycode   AND b.edid = a.edicode   AND b.TYPE = a.editype UNION ALL SELECT a.edicode, b.investrebatedesc,A.EDITYPE,decode(A.EDITYPE,'E','Earnings','I','Investment','D','Deduction',a.EDITYPE)EDTypeDescription, a.EDICode CategoryCode,a.EDICode CategoryDescription  FROM tds#edideclaration a, tds#investrebatemaster b WHERE a.companycode = '" + mComp + "'   AND a.tdscode = '"+mTDSCode+"'   AND a.finyear = '"+mFinancialYear+"'   AND b.companycode = a.companycode   AND b.tdscode = a.tdscode   AND b.investrebatecode = a.edicode order by edicode ";*/

int mflag=0;

		qry1="SELECT 'Y' FROM TDS#OTHERDECLARATION WHERE COMPANYCODE= '" + mComp + "' 	AND  TDSCODE='"+mTDSCode+"' AND  ASSESSMENTYEAR='"+mAssessYear+"' AND EMPLOYEEID='"+mChkMemID+"'  ";
		rs1=db.getRowset(qry1);
		if(rs1.next())
			mflag=1;
		else
			mflag=0;

		
		qry2="SELECT  nvl(PARAMETERVALUE,' ')PARAMETERVALUE FROM TDS#DECLARATIONPARADETAIL WHERE COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' AND  employeeid='"+mChkMemID+"' ";
	//	out.print(qry2);
		rs2=db.getRowset(qry2);
		if(rs2.next())
			mParaValue=rs2.getString("PARAMETERVALUE").toString().trim();

//out.print(mSeniorCitizen+"sadfsdmSeniorCitizen"+Gender1);	

qry="SELECT distinct  a.edicode, nvl(a.EDIDESCRIPTION,' ') eddescription, a.editype,DECODE (a.editype,'E', 'Earnings','I', 'Investment','D', 'Deduction',    a.editype  ) edtypedescription,         a.edicode categorycode, a.edicode categorydescription,c.SECTIONDESC,c.DECLARATIONSEQID,c.SECTIONCODE,nvl(a.OTHERPARAMETER,'N')OTHERPARAMETER ,nvl(a.OTHERPARAMETER,'N')OTHERInvestPARAMETER ,D.SEQUENCEID   FROM tds#edideclaration a, edmaster b,TDS#SECTIONMASTER c,  TDS#TDSSECTIONTAGGING d   WHERE a.companycode ='" + mComp + "'      AND a.tdscode = '"+mTDSCode+"'      AND a.ASSESSMENTYEAR = '"+mAssessYear+"'   and a.FINYEAR='"+mFinancialYear+"'             and d.SENIORCITIZEN='"+mSeniorCitizen+"'            and d.GENDER='"+Gender1+"'  AND b.companycode = a.companycode     AND b.edid = a.edicode     AND b.TYPE = a.editype     and c.COMPANYCODE=d.COMPANYCODE     and c.TDSCODE=d.TDSCODE     and c.SECTIONCODE=d.SECTIONCODE     and a.COMPANYCODE=d.COMPANYCODE     and a.TDSCODE=d.TDSCODE     and a.FINYEAR=d.FINYEAR     and a.EDICODE=d.EDICODE     and a.EDITYPE=d.EDITYPE   UNION ALL   SELECT  distinct a.edicode, nvl(a.EDIDESCRIPTION,' ')eddescription, a.editype,         DECODE (a.editype, 'E', 'Earnings','I', 'Investment', 'D', 'Deduction',  a.editype          ) edtypedescription,         a.edicode categorycode, a.edicode categorydescription,c.SECTIONDESC,c.DECLARATIONSEQID ,c.SECTIONCODE ,nvl(a.OTHERPARAMETER,'N')OTHERPARAMETER ,nvl(b.OTHERPARAMETER,' ')OTHERInvestPARAMETER ,D.SEQUENCEID    FROM tds#edideclaration a, tds#investrebatemaster b,TDS#SECTIONMASTER c,  TDS#TDSSECTIONTAGGING d   WHERE a.companycode ='" + mComp + "'      AND a.tdscode ='"+mTDSCode+"'      AND a.ASSESSMENTYEAR = '"+mAssessYear+"'     AND b.companycode = a.companycode     AND b.tdscode = a.tdscode     AND b.investrebatecode = a.edicode      and c.COMPANYCODE=d.COMPANYCODE     and c.TDSCODE=d.TDSCODE     and c.SECTIONCODE=d.SECTIONCODE     and a.COMPANYCODE=d.COMPANYCODE     and a.TDSCODE=d.TDSCODE     and a.FINYEAR=d.FINYEAR     and a.EDICODE=d.EDICODE     and a.EDITYPE=d.EDITYPE   and a.FINYEAR='"+mFinancialYear+"'             and d.SENIORCITIZEN='"+mSeniorCitizen+"'            and d.GENDER='"+Gender1+"'             ORDER BY DECLARATIONSEQID,SEQUENCEID";
//out.print(qry);
rstable = db.getRowset(qry);  		
mSave = "0";
while (rstable.next())
	{
	sno++;
	
		mSave="1";

		mEDITYPE=rstable.getString("EDITYPE");
		mEDIDCODE=rstable.getString("edicode");
		mOtherPara=rstable.getString("OTHERPARAMETER");
		
	
		qry="SELECT DISTINCT CATEGORYCODE, EDICODE,  nvl(decode(DECLARATIONAMOUNT,'0','',DECLARATIONAMOUNT),' ')DECLARATIONAMOUNT, FINYEAR, ACTUALRECEIVED, nvl(FINAL,' ')FINAL, nvl(decode(actualamount,'0','',actualamount),' ')actualamount, EXEMPTEDAMOUNT FROM TDS#EDIDECLARATIONDETAIL WHERE COMPANYCODE= '" + mComp + "' 	AND  TDSCODE='"+mTDSCode+"' AND  ASSESSMENTYEAR='"+mAssessYear+"' AND EMPLOYEEID='"+mChkMemID+"' AND EDITYPE='"+rstable.getString("EDITYPE")+"' AND EDICODE='"+rstable.getString("EDICODE")+"'";
	//out.print(qry);
	rs=db.getRowset(qry);
	if(rs.next())
		{

			mDeclAmt=rs.getString("DECLARATIONAMOUNT").toString().trim();
			mActAmt=rs.getString("ACTUALAMOUNT").toString().trim();
		
			CATEGORYCODE=rs.getString("CATEGORYCODE");
			
		}
		else
		{
			mDeclAmt="";
			mActAmt="";
		}
		

		

		
		%>
		<tr>
		<INPUT TYPE="hidden" NAME="mEDIDCODE<%=sno%>" value="<%=mEDIDCODE%>" id="mEDIDCODE">
		<INPUT TYPE="hidden" NAME="mEDITYPE<%=sno%>" value="<%=mEDITYPE%>" id="mEDITYPE">
		<td nowrap align='center' valign=top>
		<%
		if(!sectionCode1.equals(rstable.getString("SECTIONCODE").toString().trim()))
		{srno++;
			%>
		<%=srno%>.
			<%
				sectionCode1=rstable.getString("SECTIONCODE").toString().trim();
		}
		%>
		</td>
	
		
		<td nowrap align='left' valign="top"><font face=arial size=2>
	
		<%
		if(!sectionCode.equals(rstable.getString("SECTIONCODE").toString().trim()))
		{
			%>
			<U><b><%=rstable.getString("SECTIONDESC").toString().trim()%>.</b></U><BR>
			<%
				sectionCode=rstable.getString("SECTIONCODE").toString().trim();
		}
	
			  
//Others Investment ,Please Specify 
		if(rstable.getString("OTHERInvestPARAMETER").equals("Y") && rstable.getString("EDITYPE").equals("I"))
		{
					%>
					<font size=2  FACE=ARIAL color=blue><b><%=rstable.getString("eddescription")%></b></font>
					 
						<TABLE valign=top align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1  cellPadding=1 border=1>
		<thead>
		<tr><!-- <td colspan=6 align=center ><Font face='ari' size=2 color='Blue'><b>Details </b></font>
			</td>
		 --><tr bgcolor="#ff8c00" >
				<td align=center><Font face='ARIAL' color=white size=2><b>SrNo</b></font></td>
				<td align=center><Font face='ARIAL' size=2 color=white><b>Investment Description</b></font></td>
				<td align=center><Font face='ARIAL' size=2 color=white><b>Investment Amount</b></font></td>
						<%
				
			if(mStatus.equals("F"))
			  {
			%>
					<td align=center><Font face='ARIAL' size=2 color=white><b>Actual Amount</b></font></td>
			<%}
				%>
		</tr>
		</thead>

		<tbody>
			
			<%
			
			qry2="SELECT decode(INVESTMENTAMOUNT,0,' ',INVESTMENTAMOUNT)INVESTMENTAMOUNT,nvl(INVESTMENTDESC,'')INVESTMENTDESC,decode(ACTUALAMOUNT,'0',' ',ACTUALAMOUNT)ACTUALAMOUNT FROM TDS#OTHERDECLARATION WHERE 	 COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+mChkMemID+"'  AND nvl(ADDITIONALINFO,'N')<>'Y'";
		//		out.print(qry2);
			rs2=db.getRowset(qry2);
			rs1=db.getRowset(qry2);

			if(rs1.next())
			{
				while(rs2.next())
				{ i++;
						%>
								<tr>
					<td><%=i%> </td>
					<td> <INPUT TYPE="text" NAME="IDESCRIPTION<%=i%>" ID="IDESCRIPTION" value="<%=rs2.getString("INVESTMENTDESC")%>" <%=mTextReadonly%> maxlength="75" > </td>

					<td> <INPUT TYPE="text" NAME="IAMOUNT<%=i%>" ID="IAMOUNT" value="<%=rs2.getString("INVESTMENTAMOUNT")%>" onKeyPress="return numbersonly(this, event);" <%=mTextReadonly%> size=7 maxlength="10"  style="TEXT-ALIGN:right;" > </td>
							<%
					if(mStatus.equals("F"))
					  {
					%>
						<td> <INPUT TYPE="text" NAME="ACTUALAMOUNT<%=i%>" ID="ACTUALAMOUNT" value="<%=rs2.getString("ACTUALAMOUNT")%>" onKeyPress="return numbersonly(this, event);" size=7 maxlength="10"  style="TEXT-ALIGN:right;" > </td>
					<%
					  }
						%>
					</tr><%

				}
				j=i+1;
			}
			else
			{
				j=1;
			}
			//out.print(j+"sdfsfsfsf");
			//else
			//{
			for( i=j;i<=5;i++ )
			{	
				
				%>
			<tr>
			<td><%=i%> </td>
			<td> <INPUT TYPE="text" NAME="IDESCRIPTION<%=i%>" <%=mTextReadonly%> ID="IDESCRIPTION"  maxlength="75"> </td>
			<td> <INPUT TYPE="text" NAME="IAMOUNT<%=i%>" <%=mTextReadonly%> ID="IAMOUNT" onKeyPress="return numbersonly(this, event);" size=7 maxlength="10"  style="TEXT-ALIGN:right;" > </td>
					<%
			if(mStatus.equals("F"))
			  {
			%>
				<td> <INPUT TYPE="text" NAME="ACTUALAMOUNT<%=i%>"  ID="ACTUALAMOUNT" onKeyPress="return numbersonly(this, event);" maxlength="10" size=7  style="TEXT-ALIGN:right;" > </td>
			<%
			  }
				%>
			</tr>
			<%
			}
			//}
				%>
				<input id="SectionCode" name="SectionCode" value="<%=rstable.getString("SECTIONCODE")%>" type=hidden>
				<INPUT TYPE="HIDDEN" NAME="parasno" value="<%=i%>" id="parasno">
				</TBODY>
			</TABLE>
					 <%




		}
		else
		{	%>
				<%=rstable.getString("eddescription")%>
			<%
		}
				
			
			if(rstable.getString("EDITYPE").equals("E"))
		{
			qry1=" Select CategoryCode,CategoryDescription From   TDS#EDRates Where  companycode = '" + mComp + "' AND tdscode = '"+mTDSCode+"' AND finyear = '"+mFinancialYear+"' And    EDITYPE     ='"+rstable.getString("EDITYPE")+"'";
			//out.print(qry1);
			rs1=db.getRowset(qry1);
						%>
			<SELECT NAME="CategoryDesc<%=sno%>" ID="CategoryDesc<%=sno%>" <%=mDisablecombo%> >
			<%
			while(rs1.next())
			{
				
				if(CATEGORYCODE.equals(rs1.getString("CategoryCode")))
				{
					%>
					<OPTION VALUE="<%=rs1.getString("CategoryCode")%>" SELECTED><%=rs1.getString("CategoryDescription")%></OPTION>
					<%
				}
					else
				{
					%>
					<OPTION VALUE="<%=rs1.getString("CategoryCode")%>" ><%=rs1.getString("CategoryDescription")%></OPTION>
					<%
				}

			
			}
			%>
		</SELECT>
				<%
		}
//	TDS#EDIDECLARATIONPARA  Date of Possession		
	if(mOtherPara.equals("Y"))
		{
		
			qry="SELECT  COMPANYCODE, TDSCODE, ASSESSMENTYEAR,   EDITYPE, EDICODE, FINYEAR,   PARAMETERID, PARAMETERDESC,DATATYPE FROM TDS#EDIDECLARATIONPARA where   COMPANYCODE= '" + mComp + "' 	AND  TDSCODE='"+mTDSCode+"' AND  ASSESSMENTYEAR='"+mAssessYear+"' AND EDITYPE='"+rstable.getString("EDITYPE")+"' AND EDICODE='"+rstable.getString("EDICODE")+"'";
			rs=db.getRowset(qry);
			if(rs.next())
			{

			

			%>
		<br>
			<FONT color=black><FONT face=Arial color=blue size=2><STRONG><%=rs.getString("PARAMETERDESC")%>   </STRONG></FONT>

				
			<INPUT TYPE=HIDDEN Name="PARAEDICODE"  id="PARAEDICODE" VALUE="<%=rs.getString("EDICODE")%>">	
			
			<INPUT TYPE=HIDDEN Name="PARAMETERID"  id="PARAMETERID" VALUE="<%=rs.getString("PARAMETERID")%>">	

			<INPUT TYPE=HIDDEN Name="PARAEDITYPE"  id="PARAEDITYPE" VALUE="<%=rs.getString("EDITYPE")%>">		

			<INPUT TYPE=HIDDEN Name="PARAMETERDESC"  id="PARAMETERDESC" VALUE="<%=rs.getString("PARAMETERDESC")%>">	

	
			<%
			if(rs.getString("DATATYPE").equals("D"))
			{	%>	
				<INPUT TYPE=TEXT Name="PARAMETERVALUE" <%=mTextReadonly%> <%=mdisable%> id="PARAMETERVALUE" value="<%=mParaValue%>" MAXLENGTH=10 SIZE=10  onchange="return iSValidDate(PARAMETERVALUE.value);">		
				<font face=arial size=1 color=green><b>DD-MM-YYYY</b></font>
				<%
			}
			else
			{
				%>
				<INPUT TYPE=TEXT Name="PARAMETERVALUE" <%=mTextReadonly%> <%=mdisable%> id="PARAMETERVALUE" value="<%=mParaValue%>" MAXLENGTH=75 SIZE=10 >		
				<%
				
			}
			monClick="return checkOtherPara();";
			}
				
				
			
		}
		else
		{
			monClick="";
		}
				%>

		</td>
	
		

		<td align='Center'>&nbsp;
		<%
		if(!rstable.getString("OTHERInvestPARAMETER").equals("Y"))
		{
		
		
		%>
		 <img SRC="images/Rs.jpg.png" > 
		<Input maxlength=15 size=8 Type=Text value="<%=mDeclAmt%>" ID='DeclarationAmt<%=sno%>' Name='DeclarationAmt<%=sno%>' <%=mTextReadonly%> onChange="<%=monClick%>" onKeyPress="return numbersonly(this, event);"  style="TEXT-ALIGN:right;" >
		<%


		}
		%>
		</td>
		<td align='Center'>&nbsp;
		<%

	if(!rstable.getString("OTHERInvestPARAMETER").equals("Y"))
	{
	
	if(mStatus.equals("F"))
	  {
	%>
	 <img SRC="images/Rs.jpg.png" > 
	 <Input maxlength=15 size=8 Type=Text ID='ReceiptAmt<%=sno%>' Name='ReceiptAmt<%=sno%>' value="<%=mActAmt%>"  onKeyPress="return numbersonly(this, event);"  onChange="<%=monClick%>"  style="TEXT-ALIGN:right;"  >

		
		<%
	  }
	}
		%>
		</td>
	</tr>
		<%
	}





//if(mSave.equals("1"))
//{
%>
<tr>
<td colspan=4>


	
<TABLE valign=top width="60%" align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1  cellPadding=1 border=1 >
<thead>
<tr bgcolor="#ff8c00"><td colspan=6 align=center ><Font face='arial' size=3 color='white'><b>Additional Information if any </b></font>
    </td>
 <tr bgcolor="#ff8c00" >
		<td align=center><Font face='ARIAL' color=white size=2><b>SrNo</b></font></td>
		<td align=center><Font face='ARIAL' color=white size=2><b>Additional Investment Description</b></font></td>
		<td align=center><Font face='ARIAL' color=white size=2><b>Investment Amount</b></font></td>
				<%
		
	if(mStatus.equals("F"))
	  {
	%>
			<td align=center><Font face='ARIAL' size=2><b>Actual Amount</b></font></td>
	<%}
		%>
</tr>
</thead>

<tbody>
	
	<%
	
	qry2="SELECT decode(INVESTMENTAMOUNT,0,' ',INVESTMENTAMOUNT)INVESTMENTAMOUNT,nvl(INVESTMENTDESC,'')INVESTMENTDESC,decode(ACTUALAMOUNT,'0',' ',ACTUALAMOUNT)ACTUALAMOUNT FROM TDS#OTHERDECLARATION WHERE 	 COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+mChkMemID+"' AND nvl(ADDITIONALINFO,'N')='Y'";
	//	out.print(qry2);
	rs2=db.getRowset(qry2);
	rs1=db.getRowset(qry2);

	if(rs1.next())
	{
		while(rs2.next())
		{ k++;
				%>
						<tr>
			<td><%=k%> </td>
			<td> <INPUT TYPE="text" NAME="ADDIDESCRIPTION<%=k%>" ID="ADDIDESCRIPTION" value="<%=rs2.getString("INVESTMENTDESC")%>" <%=mTextReadonly%> maxlength="75"  size=40> </td>

			<td> <INPUT TYPE="text" NAME="ADDIAMOUNT<%=k%>" ID="ADDIAMOUNT" value="<%=rs2.getString("INVESTMENTAMOUNT")%>" onKeyPress="return numbersonly(this, event);" <%=mTextReadonly%> size=7 maxlength="10"  style="TEXT-ALIGN:right;" > </td>
					<%
			if(mStatus.equals("F"))
			  {
			%>
				<td> <INPUT TYPE="text" NAME="ADDACTUALAMOUNT<%=k%>" ID="ADDACTUALAMOUNT" value="<%=rs2.getString("ACTUALAMOUNT")%>" onKeyPress="return numbersonly(this, event);" size=7 maxlength="10"  style="TEXT-ALIGN:right;" > </td>
			<%
			  }
				%>
			</tr><%

		}
		p=k+1;
	}
	else
	{
		p=1;
	}
	//out.print(j+"sdfsfsfsf");
	//else
	//{
	for( k=p;k<=5;k++ )
	{	
		
		%>
	<tr>
	<td><%=k%> </td>
	<td> <INPUT TYPE="text" NAME="ADDIDESCRIPTION<%=k%>" <%=mTextReadonly%> ID="ADDIDESCRIPTION" size=40 maxlength="75"> </td>
	<td> <INPUT TYPE="text" NAME="ADDIAMOUNT<%=k%>" <%=mTextReadonly%> onKeyPress="return numbersonly(this, event);" ID="ADDIAMOUNT" size=7 maxlength="10"  style="TEXT-ALIGN:right;" > </td>
			<%
	if(mStatus.equals("F"))
	  {
	%>
		<td> <INPUT TYPE="text" NAME="ADDACTUALAMOUNT<%=k%>" onKeyPress="return numbersonly(this, event);"  ID="ADDACTUALAMOUNT" maxlength="10" size=7  style="TEXT-ALIGN:right;" > </td>
	<%
	  }
		%>
	</tr>
	<%
	}
	//}
		%>
		
		<INPUT TYPE="HIDDEN" NAME="addparasno" value="<%=k%>" id="addparasno">
		</TBODY>
	</TABLE>
	</td>
	</tr>
<centeR>
<INPUT TYPE="hidden" NAME="mStatus" value="<%=mStatus%>" id="mStatus">
<INPUT TYPE="hidden" NAME="sno" value="<%=sno%>" id="sno">


<tr><td colspan=10 align=center>
			
	<Input Type='Submit' Value='Save' name="Save"  onclick="return Validatedate();" >
	
	</td>
</tr>

</centeR>
</table>
</form>

	<%	
	}
      catch(Exception e)
	{
		 out.println("Error : "+e);
	}
		//	}
		}
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------

	}
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> TDS Declaration Form Date has not been declared or Declaration Date is Over !   </font> <br>");	

	}


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
		// out.println("Error : "+e);
	}
%>
</body>
</html>
