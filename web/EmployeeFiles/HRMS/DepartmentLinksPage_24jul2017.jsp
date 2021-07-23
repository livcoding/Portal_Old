<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
     
            String mVacCode = "";
			String mMemberID ="",mMemberType="",mMemberName="",mMemberCode="";
            String mInst="",mComp="",mDept="",mAppRefNo="",mPVacccCode="";
            
 int start=0,last=0,custom=0,count=0;
	 String mPage="",qqry="",mAbsent="";



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


if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
}





String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<html>
    <head>
     
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>#### <%=mHead%> [ DepartmentSelection ]</TITLE>
        <link  rel="stylesheet" type="text/css" href="css/style.css">
       
<script language="JavaScript" type ="text/javascript">


function isNumber(e)
{
var unicode=e.charCode? e.charCode : e.keyCode;
//alert(unicode);
if (unicode!=8)
{ //if the key isn't the backspace key (which we should allow)
if (((unicode<48||unicode>57) && (unicode<96 || unicode>105))) //if not a number
return false //disable key press
}
}


function Validate()
{
	if(document.frm.ccustom.value=="" ||  document.frm.ccustom.value==" " || document.frm.ccustom.value==0)
	{
		alert("Please enter the number of Applicants to View");
		frm.ccustom.focus();
		return false;
	}

if(document.frm.ccustom.value>20)
	{
		alert("This will take time to load "+document.frm.ccustom.value+" data/records ");
	//	frm.ccustom.focus();
		return true;
	}


}

function onFreeze(slno)
	{

		//alert(document.getElementById("Status"+slno)+"ddd");
		var ab=0;
		for(i=1; i<document.frm1.elements.length;i++)
		{
			 var e = document.frm1.elements[i]; 
			 var aa="Status";
			
		if (e.value=="N" && e.checked==true)
			{
				ab++;
				//alert("sddsd");
			}
				
		}
			
		if(ab>0)
		{
		var b=callMsgBox2('You have still '+ab+' record which are not processed are you still want to Freeze.');
		if (b==6)
		{
		return true;
		}
		else
		{		
		 return false;
		}
		}
		else
		{
		/*var b=callMsgBox2(' Are you sure you want to Freeze !');
		if (b==6)
		{
		return true;
		}
		else
		{		
		 return false;
		}*/
		}


	}
function EnterRemarks(ss,slno)
	{
	//alert(document.getElementById("Status"+slno).value+"sdds"+ss);

		if(document.getElementById("Status"+slno).value=="R")
		{
			alert("Please Enter Remarks ");
			document.getElementById("DeptRemarks"+slno).value="";
			document.getElementById("DeptRemarks"+slno).focus();
			return false;

		}

		//if(document.getElementByID(ss).value)
	}
	
	function GetXmlHttpObject()
	{
		var xmlHttp=null;
		try
		{
			// Firefox, Opera 8.0+, Safari
			xmlHttp=new XMLHttpRequest();
		}
		catch (e)
		{
			// Internet Explorer
			try
			{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch (e)
			{
				xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}

	var xmlHttp;


	function ColorCheck1(slno)
	{
	
		xmlHttp = GetXmlHttpObject();

     
		if (xmlHttp==null)
		{
			alert("Browser does not support XMLHTTP Request")
			return;
		}


		Institute =	document.getElementById("Institute").value;
		CompanyCode= document.getElementById("CompanyCode").value;
		ccustom=document.getElementById("ccustom").value;
		DeptCode=document.getElementById("DeptCode").value;



		VacancyCode=document.getElementById("VacancyCode").value;
		ShowStatus=document.getElementById("ShowStatus").value;




   //alert(ShowStatus +"  - - "+document.getElementById("sstart").value);
		sstart=document.getElementById("sstart").value;




		llast=document.getElementById("llast").value;




		ShortlistSeq=document.getElementById("ShortlistSeq").value;
		TotalCount=document.getElementById("TotalCount").value;
		DeptRemarks=document.getElementById("DeptRemarks"+slno).value;

		ApplicationID=document.getElementById("ApplicationID"+slno).value;

		mChkMemID=document.getElementById("mChkMemID").value;



		Status=document.getElementById("StatusS"+slno).value;


//alert(Status +"  - - "+slno);


//alert(slno+" :Institute: "+Institute+" :CompanyCode: "+CompanyCode+" :DeptCode: "+DeptCode+" :VacancyCode: "+VacancyCode+" :ShowStatus: "+ShowStatus+" :sstart: "+sstart+" :llast: "+llast+" :ShortlistSeq: "+ShortlistSeq+" :TotalCount: "+TotalCount+" :DeptRemarks: "+DeptRemarks+" :Status: "+Status+" :ApplicationID: "+ApplicationID+" : mChkMemID  : "+mChkMemID);

	var flag=0;

      var url="DepartmentSaveAjax.jsp";
	  url+="?slno="+slno+"&Institute="+Institute+"&CompanyCode="+CompanyCode+"&DeptCode="+DeptCode+"&VacancyCode="+VacancyCode+"&ShortlistSeq="+ShortlistSeq+"&TotalCount="+TotalCount+"&DeptRemarks="+DeptRemarks+"&Status="+Status+"&ApplicationID="+ApplicationID+"&mChkMemID="+mChkMemID;
//	  alert(url);
	  
	  xmlHttp.onreadystatechange = function()
        {
            if (xmlHttp.readyState==4 && xmlHttp.status==200)
            {		
					document.getElementById("TableRow"+slno).bgColor='lightgreen';
				flag=1;
            }			
        }
/*
if(flag==1)
		{
	alert("Record Saved Successfully");
		}*/

      xmlHttp.open("GET", url, true);
      xmlHttp.send();
	}


function ColorCheck2(slno)
	{
		xmlHttp = GetXmlHttpObject();
		if (xmlHttp==null)
		{
			alert("Browser does not support XMLHTTP Request")
			return;
		}


	Institute =	document.getElementById("Institute").value;
	CompanyCode= document.getElementById("CompanyCode").value;
	ccustom=document.getElementById("ccustom").value;
	DeptCode=document.getElementById("DeptCode").value;
	VacancyCode=document.getElementById("VacancyCode").value;
	ShowStatus=document.getElementById("ShowStatus").value;

	sstart=document.getElementById("sstart").value;
	llast=document.getElementById("llast").value;

	ShortlistSeq=document.getElementById("ShortlistSeq").value;
	TotalCount=document.getElementById("TotalCount").value;
	DeptRemarks=document.getElementById("DeptRemarks"+slno).value;
	
	
	ApplicationID=document.getElementById("ApplicationID"+slno).value;

	mChkMemID=document.getElementById("mChkMemID").value;

	Status=document.getElementById("StatusR"+slno).value;
	


//alert(Status +"  - - "+slno);


//alert(slno+" :Institute: "+Institute+" :CompanyCode: "+CompanyCode+" :DeptCode: "+DeptCode+" :VacancyCode: "+VacancyCode+" :ShowStatus: "+ShowStatus+" :sstart: "+sstart+" :llast: "+llast+" :ShortlistSeq: "+ShortlistSeq+" :TotalCount: "+TotalCount+" :DeptRemarks: "+DeptRemarks+" :Status: "+Status+" :ApplicationID: "+ApplicationID+" : mChkMemID  : "+mChkMemID);

      var url="DepartmentSaveAjax.jsp";
	  url+="?slno="+slno+"&Institute="+Institute+"&CompanyCode="+CompanyCode+"&DeptCode="+DeptCode+"&VacancyCode="+VacancyCode+"&ShortlistSeq="+ShortlistSeq+"&TotalCount="+TotalCount+"&DeptRemarks="+DeptRemarks+"&Status="+Status+"&ApplicationID="+ApplicationID+"&mChkMemID="+mChkMemID;
	  
	  
	  xmlHttp.onreadystatechange = function()
        {
            if (xmlHttp.readyState==4 && xmlHttp.status==200)
            {
				//alert("here");
				document.getElementById("TableRow"+slno).bgColor='pink';
                //document.getElementById("myDiv").innerHTML=xmlHttp.responseText;
            }
			
        }

      xmlHttp.open("GET", url, true);
      xmlHttp.send();

	}



	function ColorCheck3(slno)
	{
	
				document.getElementById("TableRow"+slno).bgColor='lightblue';
				//this.frm1.submit();

	}

	function openWordDocPath(strLocation) {
		//alert("sdsdsdsd"+strLocation);
		var objWord;
		
		objWord = new ActiveXObject("Word.Application");
		//	alert("25215"+objWord);
		objWord.Visible = true;
		objWord.Documents.Open(strLocation);
	}



function AlertMe()
{
	document.dd.twait.value='';
}
</script>
<SCRIPT LANGUAGE=vbscript>
function callMsgBox2(strMsg){
callMsgBox2 = msgBox(strMsg,4,"Application Selection:- Please Confirm")
}
</SCRIPT>
    </head>
    <body id="top" aLink=#ff00ff rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  onload="AlertMe()" >


    <%

    GlobalFunctions gb = new GlobalFunctions();
    DBHandler db = new DBHandler();
    String qry = "";
    String qry1="",qry2="",qry3="",qry4="";
    ResultSet rsd = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;
    ResultSet rs4 = null;
	   ResultSet rs5 = null,rs6=null;
    String mDDS = "";
    String mS = "";
    String mPS = "",qry5="";
    session.setAttribute("APPLICANTID", null);
    session.setAttribute("MFLAG", null);
   String mPrev = "", mPostheld = "", mNatureofJob = "", mTypeofExp = "";
            String mTODATE="",mFROMDATE="";

			String mDMemberID ="",mDMemberCode ="",mDMemberType="",mRightID="255";
    
        int slno = 0,mSHORTLISTSEQNO=0,mShortSeq=0;
        String mAppName = "", mDOB = "", mAdd1 = "", mAdd2 = "", mAdd3 = "", mCity = "", mState = "", mDistrict = "", mApplicantID = "",mStatus="",mReject="",mSelect="",mSelectedStatus="",mRemarks="",mFinalShortList="";
		String mDisable="",mTabColor="";
	
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

		

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('"+mRightID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		//out.print(qry);
		
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
%>
	<form method="get" name="frm" >
	<INPUT TYPE="hidden" NAME="x"  id="x"> 
<%
	String mDeptCode="",mShow="",mNotSelect="",mFinal="",mDesignation="";
int mMaxSeq=0;
//First Time Selection  //

if(request.getParameter("VacancyCode")==null)
		mVacCode="";
	else
		mVacCode=request.getParameter("VacancyCode").toString().trim();


if(request.getParameter("DeptCode")==null)
		mDeptCode="";
	else
		mDeptCode=request.getParameter("DeptCode").toString().trim();


if(request.getParameter("DESCODE")==null)
		mDesignation="";
	else
		mDesignation=request.getParameter("DESCODE").toString().trim();



	if(request.getParameter("ShowStatus")==null)
		mShow="";
	else
		mShow=request.getParameter("ShowStatus");


if(request.getParameter("ccustom")==null)
    {
        custom=0;
    }
    else
    {
        custom=Integer.parseInt(request.getParameter("ccustom"));
    }


qry="SELECT   (MAX (d.shortlistseqno))AA                FROM hr#applicantshortlistmaster d               WHERE d.institutecode = '"+mInst+"'           " +
        "      AND d.vacancycode = '"+mVacCode+"' and d.APPLICANTID in (select applicantid " +
        "from hr#applicationmaster where institutecode = '"+mInst+"' and DEPARTMENTCODE='"+mDeptCode+"' and DESIGNATIONCODE='"+mDesignation+"'   ) ";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
mMaxSeq=rs.getInt("AA");

/*
if(mMaxSeq==1)
	mShow="N";
else if (mMaxSeq==3)
	mMaxSeq=2;
*/


String mVacDesc="",mDeptDesc="";

   qry = "SELECT distinct COMPANYCODE, INSTITUTECODE, VACANCYCODE, VACANCYDESCRIPTION," +
            " FROMPERIOD, TOPERIOD, BROADCAST, CLOSED, CLOSINGDATE FROM HR#VACANCYMASTER" +
            " WHERE NVL(BROADCAST,'N')='Y' AND " +
            " INSTITUTECODE='"+mInst+"' and VACANCYCODE='"+mVacCode+"' ";
//  	out.print("ssdsd"+qry);
	rs = db.getRowset(qry);
	if(rs.next())
		mVacDesc=rs.getString("VACANCYDESCRIPTION");

qry1 = "select distinct departmentcode,department from DEPARTMENTMASTER where" +
" nvl(DEACTIVE,'N')='N' and   departmentcode in (select distinct DEPARTMENTCODE from " +
"HR#VACANCYDEPARTMENTSELECTION   where INSTITUTECODE='"+mInst+"' AND GUESTID='"+mChkMemID+"' AND DEPARTMENTCODE='"+mDeptCode+"'  ) order by DEPARTMENT";
//out.print(qry1);
rsd = db.getRowset(qry1);
	if(rsd.next())
		mDeptDesc=rsd.getString("department");
		


		

int mTSelected=0 ;
		qry1="select count(c.applicantid)selected from   hr#applicantshortlistmaster c," +
                "  hr#applicationmaster a,hr#applicantaddress D where a.vacancycode in (select vacancycode from " +
                "HR#VACANCYMASTER WHERE a.vacancycode='"+mVacCode+"' and institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y'" +
                "  ) and a.departmentcode ='"+mDeptCode+"'   and a.DESIGNATIONCODE='"+mDesignation+"'   " +
                "   and c.STATUS='S'   and  c.SHORTLISTSEQNO =2  and a.vacancycode ='"+mVacCode+"'   " +
                " AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' " +
                "AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode  " +
                "AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid ";
		//out.print(qry1);
		rs1=db.getRowset(qry1);
		if(rs1.next())
			mTSelected=rs1.getInt("selected");
		else
			mTSelected=0;

//192.168.4.221   juet4guna

		int mTReject=0 ;
			qry2="select count(c.applicantid)reject from   hr#applicantshortlistmaster c,  hr#applicationmaster a ,hr#applicantaddress D where a.vacancycode in (select vacancycode from HR#VACANCYMASTER WHERE a.vacancycode='"+mVacCode+"' and institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y'  ) " +
                    "and a.departmentcode ='"+mDeptCode+"'   and a.DESIGNATIONCODE='"+mDesignation+"'      and nvl(c.STATUS,'N')='R' " +
                    "  and  c.SHORTLISTSEQNO =2  and a.vacancycode ='"+mVacCode+"'          " +
                    "    AND a.applicantid = c.applicantid		" +
                    "	and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode " +
                    "AND a.institutecode = c.institutecode  AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid ";
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mTReject=rs1.getInt("reject");
		else
			mTReject=0;

	




		int mALLSum=0;
		qry2="select count(c.applicantid)AllResume from   hr#applicantshortlistmaster c, " +
                " hr#applicationmaster a ,hr#applicantaddress D where a.vacancycode in" +
                " (select vacancycode from HR#VACANCYMASTER WHERE institutecode='"+mInst+"'" +
                " and NVL(BROADCAST,'N')='Y'  ) and a.departmentcode ='"+mDeptCode+"'  and a.DESIGNATIONCODE='"+mDesignation+"'" +
                "        and  c.SHORTLISTSEQNO =1  and a.vacancycode ='"+mVacCode+"'  " +
                " AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid AND a.applicantid = c.applicantid	" +
                "		and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode";
		//out.print(qry2);
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mALLSum=rs1.getInt("AllResume");
		else
			mALLSum=0;



			int mTNotProcess=0;
			qry2="select count(c.applicantid)mTNotProcess from   hr#applicantshortlistmaster c,  " +
                    "hr#applicationmaster a,hr#applicantaddress D where a.vacancycode in (select vacancycode " +
                    "from HR#VACANCYMASTER WHERE a.vacancycode='"+mVacCode+"' and institutecode='"+mInst+"'" +
                    " and NVL(BROADCAST,'N')='Y'  ) and a.departmentcode ='"+mDeptCode+"' and a.DESIGNATIONCODE='"+mDesignation+"' " +
                    "       and nvl(c.STATUS,'N')='N'   and  c.SHORTLISTSEQNO =2  and a.vacancycode ='"+mVacCode+"'   " +
                    "           AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' AND " +
                    "a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode  AND a.applicantid = D.applicantid " +
                    "AND C.applicantid = D.applicantid";
			//out.print(qry2);
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mTNotProcess=rs1.getInt("mTNotProcess");
		else
			mTNotProcess=0;

		mTNotProcess=mALLSum-(mTReject+mTSelected);
		//int mTNotProcess=( Integer.parseInt(mALLSum) ) - (Integer.parseInt(mTSelected)+Integer.parseInt(mTReject));

if(custom==0)
		{
	if(mShow.equals("ALL"))
		custom=mALLSum;
	else if(mShow.equals("S"))
		custom=mTSelected;
	else if(mShow.equals("R"))
		custom=mTReject;
	else if(mShow.equals("N"))
		custom=mTNotProcess;


	}

		%>
		
		<table  border=1  borderColor=#D98242 rules=group align=left  topmargin=0 cellspacing=0 cellpadding=0>
		  
 <tr bgcolor="#FFCF83">

		<td colspan=2 class="labelcell" align=left>
		<A href="DepartmentSelectionPage.jsp"><font face=verdana size=5 ><b><<-Go Back </b></b></A></td>
		</tr>
	
			 
			 
			 <tr bgcolor="#FFCF83">

		<td class="labelcell" >
		<!-- <a href="DepartmentLinks.jsp?ShowStatus=ALL&amp;Vacancy=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>"> --> <font  size=2><b>	Resumes to be reviewed </td><td> <%=mALLSum%> </td>
		</tr>
		
		<tr bgColor="lightgreen">
		<td class="labelcell">
		<!-- <a href="DepartmentLinks.jsp?ShowStatus=S&amp;Vacancy=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>">  -->	<font color=green size=2><b> Resumes Shortlisted  </a></td><td> <%=mTSelected%> </td>
		</tr>

		<tr bgColor="pink">
		<td class="labelcell">
		<!-- <a href="DepartmentLinks.jsp?ShowStatus=R&amp;Vacancy=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>"> --><font color=red size=2><b>	Resumes Not Shortlisted. </a> </td><td> <%=mTReject%> 		</td>
		</tr>
	
		
		<tr bgColor="white">
		<td class="labelcell">
		<!-- <a href="DepartmentLinks.jsp?ShowStatus=N&amp;Vacancy=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>"> -->	<font color=blue size=2><b>Resume Yet to be Processed   </a></td><td> <%=mTNotProcess%> 		</td>
		</tr>


		
		</table>



   <table  align=center >
            <tr><td align=center ><h2>&nbsp;&nbsp; Initial ShortListing by Nominated Members &nbsp;&nbsp;</h2></td></tr>

			   <tr><td align=center ><h2>Vacancy-<%=mVacDesc%> &nbsp;&nbsp; Department-<%=mDeptDesc%> </h2></td></tr>

			   <tr><td align=center class="labelcell"><b>Name : <%=mMemberName%></td></tr>

			   <tr>
					<td ><font size=3 color="dark brown" face=verdana>
					Enter No. of Applicant to be viewed and click to submit:</b>	
					&nbsp;&nbsp;

<%String mCust="";

	if(request.getParameter("ccustom")==null)
	mCust="20";
else
	mCust=request.getParameter("ccustom");
	%>

					
					<INPUT TYPE="text" NAME="ccustom"  id="ccustom"  onkeydown="return isNumber(event);"  onkeypress="return isNumber(event)" maxlength=5 value="<%=mCust%>" size=3>
 </font></td>
				
				</tr>

				 <tr>


 <td align="center" >           &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;  
 &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; 
 &nbsp;&nbsp;&nbsp; 
 &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; <input type="submit" tabindex="5" value="Submit" onClick="return Validate();"></td>
        </tr>
        </table>
		
 <input type="hidden" name="VacancyCode" id="VacancyCode" value="<%=mVacCode%>">
  <input type="hidden" name="DeptCode" id="DeptCode" value="<%=mDeptCode%>">
 <INPUT TYPE="hidden" NAME="ShowStatus" ID="ShowStatus" VALUE="<%=mShow%>">

      <input type="hidden" name="DESCODE" id="DESCODE" value="<%=mDesignation%>">

</form>






<%
if(request.getParameter("x")!=null)
		{

%>

<form name="dd" id="dd">
<center>
<input style="width:220px;font-size:18px;position:absolute;text-align:middle;
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ; background-color:transparent"  name="twait" id="twait" readonly type="text" value="Please Wait...">
</center>
</form>



<form  method="post" name="frm1" action="DepartmentSelectActionPage.jsp"  >
<%


String mCust1="";

if(request.getParameter("VacancyCode")==null)
		mVacCode="";
	else
		mVacCode=request.getParameter("VacancyCode").toString().trim();


if(request.getParameter("DeptCode")==null)
		mDeptCode="";
	else
		mDeptCode=request.getParameter("DeptCode").toString().trim();




if(request.getParameter("DESCODE")==null)
		mDesignation="";
	else
		mDesignation=request.getParameter("DESCODE").toString().trim();




	if(request.getParameter("ShowStatus")==null)
		mShow="";
	else
		mShow=request.getParameter("ShowStatus");

	
	if(request.getParameter("ccustom")==null)
		mCust1="";
	else
		mCust1=request.getParameter("ccustom");
	%>



<input type="hidden" name="mChkMemID" id="mChkMemID" value="<%=mChkMemID%>">
<input type="hidden" name="VacancyCode" id="VacancyCode" value="<%=mVacCode%>">
  <input type="hidden" name="DeptCode" id="DeptCode" value="<%=mDeptCode%>">
            <input type="hidden" name="DESCODE" id="DESCODE" value="<%=mDesignation%>">

 <INPUT TYPE="hidden" NAME="ShowStatus" ID="ShowStatus" VALUE="<%=mShow%>">
 <table width="100%" border=1  borderColor=#D98242 rules=group align=center bottommargin=1 topmargin=0 cellspacing=0 cellpadding=2>
     <br>
     <tr bgcolor="#FFCF83">
	  <td  class="labelcell"><b><CENTER>SrNo.</CENTER></b></td>
	 <!--  <td  class="labelcell"><b><CENTER>Candidate<br>ReferenceNo.</CENTER></b></td> -->
       <td  class="labelcell"><b><CENTER>Candidate<br>Selection Status</CENTER></b></td>
         <td  class="labelcell"><b><CENTER>Name<br><br>Date of Birth</CENTER></b></td>
                  <td  class="labelcell"><b><CENTER>Address</CENTER></b></td>
         <TD  align=left class="labelcell" nowrap > <table cellspacing=0 cellpadding=0 width="100%" align=left> <td class="labelcell" nowrap colspan=4><b> Applicant Qualification
				  </td>
				 <!--  <tr >
                <td class="labelcell" valign="top"><b>Degree </b></td>
				<td class="labelcell" valign="top"><b>Institute</b></td>
                <td class="labelcell" valign="top"><b>Year</b></td>
             	</tr> -->
				</table></TD>
		          <!-- <TD  align=left class="labelcell" nowrap><b> Applicant Experience <hr> <br> Designation &nbsp;Company &nbsp; PFrom &nbsp; PTo &nbsp; &nbsp; &nbsp; &nbsp;TotalExp.</b></TD> -->

				  <td  align=left>
				  <table width="100%" align=left cellspacing=0 cellpadding=0  border=0> <td class="labelcell" nowrap colspan=6><b> Applicant Experience
				<!--  <hr>
				  <tr  >
                <td class="labelcell" valign="top" width="100px" align=left><b>Designation</b></td>
				<td class="labelcell" valign="top" width="100px" align=left><b>Institute<br>Company</b></td>
                <td class="labelcell" valign="top" width="70px" align=left><b>Period<br>From</b></td>
                <td class="labelcell" valign="top" width="70px" align=left><b>Period<br>To</b></td>
				<td class="labelcell" valign="top" width="70px" align=left><b>Total<br>Exp.</b></td>
				</tr> -->
				</table>
				</td>
   <TD  align=center class="labelcell"><b>Click to View CV </b></TD>
       
         <!-- <td  class="labelcell" nowrap><b>
		 <INPUT TYPE="checkbox" onClick="un_checkAllSelect()"  NAME="AllSelect" ID="AllSelect" value="S">Select All</b>
		 </td> 
		 <td  class="labelcell" nowrap><b>
		 <INPUT TYPE="checkbox" NAME="AllReject" ID="AllReject" onClick="un_checkAllReject()" value="R">Reject ALL</b>
		 </td>
		  <td  class="labelcell" nowrap><b>
		 <INPUT TYPE="checkbox" NAME="AllNotSelect" ID="AllNotSelect" onClick="un_checkAllNotSelect()" value="N">Not Selected</b>
		 </td> -->
         <td class="labelcell"><b><CENTER> Remarks of Shortlisting Member<br>(max. 100 words)</CENTER></b> </td>
     </tr>

     <%

 if(request.getParameter("ccustom")==null)
    {
        custom=custom;
    }
    else
    {
        custom=Integer.parseInt(request.getParameter("ccustom"));
    }
    
    if(request.getParameter("sstart")==null)
    {
        start=1;
    }
    else
    {
        start=Integer.parseInt(request.getParameter("sstart"));
    }
    
    
       if(request.getParameter("llast")==null)
    {
			if(request.getParameter("ccustom")==null)
		{
			last=custom;
		}
		else
		{
			last=Integer.parseInt(request.getParameter("ccustom"));
		}
    }
    else
    {
        last=Integer.parseInt(request.getParameter("llast"));
    }

// out.print(last+"last"+start+"start"+custom+"ss<BR>");
if (request.getParameter("Paging")==null)
					mPage="";
				else
					mPage=request.getParameter("Paging").trim();
				if(mPage.equals("add"))
				{
					
					start=start+custom;
					
					last=last+custom;
					
				}
				else if(mPage.equals("substract"))
				{
					
					start=start-custom;


					last=last-custom;

				}


// out.print(last+"**last"+start+"&&&start"+custom);

        qry = " SELECT round(months_between(sysdate,dateofbirth)/12)AGE , nvl(a.SHORTLISTED,' ')SHORTLISTED, decode(a.SHORTLISTED,'S','Selected','R','Rejected','',' ',a.SHORTLISTED)FINALSHORTLISTED,c.SHORTLISTSEQNO,a.APPLICANTID,nvl(a.firstname,' ') firstname,nvl(a.middlename,' ') middlename,nvl(a.lastname,' ') lastname,to_char(a.dateofbirth,'DD-MM-YYYY')dateofbirth, decode(a.GENDER,'M','Male','F','Female')GENDER " +
                ",nvl(b.CADDRESS1,' ')CADDRESS1, nvl(b.CADDRESS2,' ')CADDRESS2, nvl(b.CADDRESS3,' ')CADDRESS3, " +
                "nvl(b.CCITY,' ')ccity, nvl(b.CDISTRICT,' ')CDISTRICT, nvl(b.CSTATE,' ')CSTATE, b.CPIN,nvl(c.STATUS ,'N')STATUS ,nvl(c.REMARKS,' ')REMARKS ,nvl(C.final,'N') final   " +
"  FROM hr#applicationmaster a, hr#applicantaddress b,HR#APPLICANTSHORTLISTMASTER c" +
" WHERE a.applicantid = b.applicantid  " +                "   AND a.vacancycode = '" + mVacCode + "'" +
                "   AND a.departmentcode = '" + mDeptCode + "'  and a.DESIGNATIONCODE='"+mDesignation+"'  and a.institutecode =  '"+mInst+"'    and a.APPLICANTID=c.APPLICANTID   and b.APPLICANTID=c.APPLICANTID   and a.VACANCYCODE=c.VACANCYCODE   and a.INSTITUTECODE=c.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE     AND A.INSTITUTECODE=C.INSTITUTECODE     AND a.institutecode = c.institutecode   AND  ";
		if(mShow.equals("ALL"))
		{
		qry=qry+" 	c.status =decode  ('"+mShow+"' ,'ALL',nvl(c.status,'N'),'"+mShow+"' ) and shortlistseqno  in(                      SELECT (MAX (d.shortlistseqno))                        FROM hr#applicantshortlistmaster d                       WHERE d.institutecode =  '"+mInst+"'        and d.vacancycode = '" + mVacCode + "' and a.APPLICANTID=d.APPLICANTID )   ";
		}
		else if(mShow.equals("S") ||  mShow.equals("R"))
		{
		qry=qry+"  	c.status =decode  ('"+mShow+"' ,'ALL',nvl(c.status,'N'),'"+mShow+"' ) and c.shortlistseqno = 2  ";
		}
		else if (mShow.equals("N"))
		{
			qry=qry+"     (c.shortlistseqno = 1   AND c.status ='S' ) and not exists(select 'x'               from hr#applicantshortlistmaster b   where b.shortlistseqno = '2'       and b.status in('S','R')                and b.applicantid = a.applicantid   AND b.vacancycode =  '" + mVacCode + "'  and b.institutecode =  '"+mInst+"' AND b.applicantid = c.applicantid)  ";
		}				
		qry=qry+" ORDER BY c.STATUS desc";	
	//	out.print(qry);
rs2= db.getRowset(qry);
while(rs2.next())
		{
   count++;
		}


String memailid="",memailmsg="";
	
qry = " SELECT nvl(B.EMAILID,' ')EMAILID , nvl(APPLICANTREFNO,' ')APPLICANTREFNO,  " +
            "Decode(c.status, 'S','1','R','2','3') forsorting," +
             " to_char(c.SHORTLISTDATE,'yyymmddhhmiss')datee," +
              "round(months_between(sysdate,dateofbirth)/12)AGE ," +
             " nvl(a.SHORTLISTED,' ')SHORTLISTED, " +
              "decode(a.SHORTLISTED,'S','Selected','R','Rejected','',' ',a.SHORTLISTED)FINALSHORTLISTED," +
             " nvl(c.SHORTLISTSEQNO,0) SHORTLISTSEQNO," +
            " a.APPLICANTID,nvl(a.firstname,' ') firstname,nvl(a.middlename,' ') middlename,nvl(a.lastname,' ') lastname," +
            "to_char(a.dateofbirth,'DD-MM-YYYY')dateofbirth, decode(a.GENDER,'M','Male','F','Female')GENDER , " +
               " nvl(b.CADDRESS1,' ')CADDRESS1, nvl(b.CADDRESS2,' ')CADDRESS2, nvl(b.CADDRESS3,' ')CADDRESS3, " +
                "nvl(b.CCITY,' ')ccity, nvl(b.CDISTRICT,' ')CDISTRICT, nvl(b.CSTATE,' ')CSTATE, nvl(c.STATUS ,'N')STATUS ," +
                " nvl(c.REMARKS,' ')REMARKS ,nvl(C.final,'N') final   " +
"  FROM hr#applicationmaster a, hr#applicantaddress b,HR#APPLICANTSHORTLISTMASTER c" +
" WHERE a.applicantid = b.applicantid  " +                "   AND a.vacancycode = '" + mVacCode + "'" +
                "   AND a.departmentcode = '" + mDeptCode + "'  and a.DESIGNATIONCODE='"+mDesignation+"'  and a.institutecode =  '"+mInst+"'    and a.APPLICANTID=c.APPLICANTID   and b.APPLICANTID=c.APPLICANTID   and a.VACANCYCODE=c.VACANCYCODE   and a.INSTITUTECODE=c.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE     AND A.INSTITUTECODE=C.INSTITUTECODE     AND a.institutecode = c.institutecode   AND  ";
		if(mShow.equals("ALL"))
		{
		qry=qry+" 	c.status =decode  ('"+mShow+"' ,'ALL',nvl(c.status,'N'),'"+mShow+"' ) and shortlistseqno  in(                      SELECT (MAX (d.shortlistseqno))                        FROM hr#applicantshortlistmaster d                       WHERE d.institutecode =  '"+mInst+"'        and d.vacancycode = '" + mVacCode + "' and a.APPLICANTID=d.APPLICANTID )   ";
		}
		else if(mShow.equals("S") ||  mShow.equals("R"))
		{
		qry=qry+"  	c.status =decode  ('"+mShow+"' ,'ALL',nvl(c.status,'N'),'"+mShow+"' ) and c.shortlistseqno = 2  ";
		}
		else if (mShow.equals("N"))
		{
			qry=qry+"     (c.shortlistseqno = 1   AND c.status ='S' ) and not exists(select 'x'        " +
                    "       from hr#applicantshortlistmaster b   where b.shortlistseqno = '2'     " +
                    "  and b.status in('S','R')                and b.applicantid = a.applicantid   " +
                    "AND b.vacancycode =  '" + mVacCode + "'  and b.institutecode =  '"+mInst+"' AND b.applicantid = c.applicantid)  ";
		}				
		qry=qry+" order by firstname,shortlistseqno desc ,forsorting";

		//out.print(qry);
qqry="select * from (select  emailid,      " +
        "             applicantrefno,     " +
        "       to_char(forsorting,0)forsorting,   " +
        "       to_char(datee),  " +
        "          to_char(age)age , " +
        "   shortlisted," +
       "    finalshortlisted,                " +
        "     to_char(shortlistseqno)shortlistseqno  ," +
        " a.applicantid,                     " +
       "     firstname," +
       "         nvl( middlename,' ') middlename,                         lastname,          " +
       "                 dateofbirth," +
        "          gender,        " +
        "              caddress1,                         caddress2," +
        "            nvl(caddress3,' ')caddress3, " +
        "                 ccity,                         cdistrict," +
       "                 cstate,  " +
       "        status,         " +
        "                 nvl(remarks,' ')remarks," +
        "              FINAL " +
      " , to_char(ROWNUM) rn " +
        " from("+qry+") a where rownum<="+last+" )" +
        " where  rn>="+start+" and rn<="+last+" order by rn,firstname,shortlistseqno desc ,forsorting ";

        
				rs = db.getRowset(qqry);
//out.print(qry);
	 /*
        qry = " SELECT round(months_between(sysdate,dateofbirth)/12)AGE , nvl(a.SHORTLISTED,' ')SHORTLISTED, decode(a.SHORTLISTED,'S','Selected','R','Rejected','',' ',a.SHORTLISTED)FINALSHORTLISTED,c.SHORTLISTSEQNO,a.APPLICANTID,nvl(a.firstname,' ') firstname,nvl(a.middlename,' ') middlename,nvl(a.lastname,' ') lastname,to_char(a.dateofbirth,'DD-MM-YYYY')dateofbirth " +
                ",nvl(b.CADDRESS1,' ')CADDRESS1, nvl(b.CADDRESS2,' ')CADDRESS2, nvl(b.CADDRESS3,' ')CADDRESS3, " +
                "nvl(b.CCITY,' ')ccity, nvl(b.CDISTRICT,' ')CDISTRICT, nvl(b.CSTATE,' ')CSTATE, b.CPIN,nvl(c.STATUS ,'N')STATUS ,nvl(c.REMARKS,' ')REMARKS ,nvl(a.final,'N') final   " +
"  FROM hr#applicationmaster a, hr#applicantaddress b,HR#APPLICANTSHORTLISTMASTER c" +
" WHERE a.applicantid = b.applicantid and	c.status =decode  ('"+mShow+"' ,'ALL',nvl(c.status,'N'),'"+mShow+"' ) " +                "   AND a.vacancycode = '" + mVacCode + "'" +
                "   AND a.departmentcode = '" + mDeptCode + "'    and a.APPLICANTID=c.APPLICANTID   and b.APPLICANTID=c.APPLICANTID   and a.VACANCYCODE=c.VACANCYCODE   and a.INSTITUTECODE=c.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE     AND A.INSTITUTECODE=C.INSTITUTECODE     AND a.institutecode = c.institutecode   AND (c.shortlistseqno) IN (                      SELECT (MAX (d.shortlistseqno))                        FROM hr#applicantshortlistmaster d                       WHERE d.institutecode =  '"+mInst+"'       and  nvl(status,'N')=decode  ('"+mShow+"' ,'ALL',nvl(d.status,'N'),'"+mShow+"' )                 AND d.vacancycode = '" + mVacCode + "'                              And a.applicantid=d.applicantid                             group by d.applicantid)     ORDER BY a.firstname";*/
   //     rs = db.getRowset(qry);
//out.print(qqry);

rs6=db.getRowset(qqry);

if(rs6.next())
{

        while (rs.next())
        {
       
		     slno=rs.getInt("rn");
		//out.print(slno+"sdsd");

			//slno++;
			mAppRefNo=rs.getString("APPLICANTREFNO").toString().trim();
			
		mFinalShortList=rs.getString("SHORTLISTED").toString().trim();
		mFinal=rs.getString("final").toString().trim();
	mSHORTLISTSEQNO=rs.getInt("SHORTLISTSEQNO");
      mApplicantID = rs.getString("APPLICANTID").toString();
 mAppName = rs.getString("firstname").toString().toUpperCase()+" "+rs.getString("middlename").toString().toUpperCase()+" "+rs.getString("lastname").toString().toUpperCase();
          mDOB = rs.getString("dateofbirth").toString();
          mAdd1 = rs.getString("CADDRESS1").toString().trim();
          mAdd2 = rs.getString("CADDRESS2").toString().trim();
          mAdd3 = rs.getString("CADDRESS3").toString().trim();
          mCity = rs.getString("ccity").toString().trim();
          mState = rs.getString("CSTATE").toString().trim();
          mDistrict = rs.getString("CDISTRICT").toString().trim();
			mStatus= rs.getString("STATUS").toString().trim();
			
memailid=rs.getString("EMAILID").toString().trim();
			

//out.print(mSHORTLISTSEQNO+"mSHORTLISTSEQNO");

			if(mSHORTLISTSEQNO==1)
			mShortSeq=mSHORTLISTSEQNO+1;
				else
			mShortSeq=mSHORTLISTSEQNO;

	//out.print(mStatus+"sdsss"+rs.getString("STATUS").toString().trim());


				qry1="SELECT  nvl(SHORTLISTSEQNO,0)SHORTLISTSEQNO," +
                        " nvl(STATUS,' ')STATUS,nvl(REMARKS,' ')REMARKS " +
                        " FROM HR#APPLICANTSHORTLISTMASTER a WHERE INSTITUTECODE='"+mInst+"' AND  " +
                        "VACANCYCODE='" + mVacCode + "' AND APPLICANTID ='"+mApplicantID+"' and  " +
                        "status =decode  ('"+mShow+"' ,'ALL',nvl(status,'N'),'"+mShow+"' ) and ";
				if(mShow.equals("ALL"))
		{
				//	qry1=qry1+" shortlistseqno =2";
		qry1=qry1+" shortlistseqno  in(                      SELECT (MAX (d.shortlistseqno))                        FROM hr#applicantshortlistmaster d                       WHERE d.institutecode =  '"+mInst+"'       and   d.vacancycode = '" + mVacCode + "' and a.APPLICANTID=d.APPLICANTID )   ";
		}
		else if(mShow.equals("S") ||  mShow.equals("R"))
		{
		qry1=qry1+" shortlistseqno = 2  ";
		}
		else if (mShow.equals("N"))
		{
			qry1=qry1+" shortlistseqno =2  ";
		}			qry1=qry1+" ORDER BY STATUS desc";
			//out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{
					mSelectedStatus=rs1.getString("STATUS").toString().trim();
					mRemarks=rs1.getString("REMARKS").toString().trim();
					if(mSelectedStatus.equals("S"))
							{
								mSelect="checked";
							}
							else if(mSelectedStatus.equals("R"))
							{
								mReject="checked";
							}
							else if(mSelectedStatus.equals("N"))
							{
								mNotSelect="checked";
							}
				}
				else
				{
					mRemarks=rs.getString("REMARKS").toString().trim();
					/*if(mStatus.equals("S"))
							{
								mSelect="checked";

							}
							else if(mStatus.equals("R"))
							{
								mReject="checked";
							}
							else if(mStatus.equals("N"))
							{
									mNotSelect="checked";
							}*/
					mNotSelect="checked";
				}



				if(mFinal.equals("Y"))
			{
				//mSelect="checked";
				mDisable="disabled";

			}


//out.print(mFinal+"mFinal");

		/*if(mFinalShortList.equals("S"))
			{
				mSelect="checked";
				//mDisable="disabled";

			}
			else if(mFinalShortList.equals("R"))
			{
				mReject="checked";
				//mDisable="disabled";
			}*/

//	out.print(mSelect+"fff");\\

if(mSelect.equals("checked"))
	mTabColor="lightgreen";
else if(mReject.equals("checked"))
	mTabColor="pink";
else if(mNotSelect.equals("checked"))
	mTabColor="white";



// Email id chaeck as old  -----------------------------------------------
qry2="select distinct nvl(A.NOTESOFINTERVIEWER,' ')NOTESOFINTERVIEWER  ,X.EMAILID      ,NVL( c.vacancycode,' ')vacancycode1   " +
        "         from hr#applicantaddress x ,HR#INTERVIEWRESULT A ,hr#applicationmaster c            " +
        "      where  a.APPLICANTID=c.APPLICANTID and x.APPLICANTID=c.APPLICANTID and A.APPLICANTID=X.APPLICANTID      " +
        "              AND X.EMAILID=LTRIM('"+memailid+"')                     AND             " +
        "        x.applicantid in(select y.applicantid                                          from hr#applicationmaster y    " +
        "                                      where x.applicantid = y.applicantid                        " +
        "                     and y.applicantid in(select i.applicantid                                  " +
        "                               from hr#interviewResult i                                                    " +
        "             where i.applicantid = y.applicantid                                                    " +
        "            and  i.RESULT<>'S'                                                                )                       " +
        "                  ) ";
qry2="SELECT DISTINCT NVL (a.notesofinterviewer, ' ') notesofinterviewer, x.emailid,                 NVL (c.vacancycode, ' ') vacancycode1            FROM hr#applicantaddress x,                 hr#interviewresult a,                 hr#applicationmaster c WHERE x.emailid = LTRIM ('"+memailid+"')             AND x.applicantid  = c.applicantid             And c.VACANCYCODE  <> '" + mVacCode + "'            And c.COMPANYCODE = a.companycode             and c.institutecode = a.institutecode             and c.applicantid = a.applicantid             AND nvl(a.RESULT,'N') <> 'S'        ";
qry2=qry2+"  union SELECT DISTINCT NVL (a.INTERVIEWNOTE, ' ') notesofinterviewer, x.emailid,' ' vacancycode1               " +
        "          FROM hr#applicantaddress x,               HR#OLDAPPLICATIONMASTER a               " +
        "   WHERE a.EMAILID = x.emailid            AND x.emailid = LTRIM ('"+memailid+"')";

//out.print(qry2);
rs2=db.getRowset(qry2);
rs3=db.getRowset(qry2);
if(rs3.next())
			{
while(rs2.next())
			{
//	mPVacccCode= rs2.getString("VACANCYCODE") ;

memailmsg=memailmsg+" --> "+rs2.getString("vacancycode1")+" - "+ rs2.getString("NOTESOFINTERVIEWER")+"<br>" ;

			}
			}
			else
			{
memailmsg="";
//mPVacccCode="";
//mTabColor="";
			}



// ------------------------------------------------------------Absent not attended interview
qry5="                  select  a.VACANCYCODE,a.APPLICANTID              from HR#SHORTLISTAPPLICANT a,hr#applicantaddress c      " +
        "         where  a.APPLICANTID=c.APPLICANTID                                                and NVL(a.ATTENDANCESTATUS,'N')='N'  " +
        "          AND NVL(A.SHORTLISTEDSTATUS,'N')='Y'                 AND c.emailid = LTRIM ('"+memailid+"')   " +
        " and a.vacancycode <>  '" + mVacCode + "'                and a.applicantid not in(select d.applicantid       " +
        "                                     from HR#interviewResult d                                      " +
        "      where d.vacancycode = a.vacancycode                                           " +
        " and d.applicantid = a.applicantid                                            and d.RESULT in ('R','S')        " +
        "                                    AND d.INSTITUTECODE=a.INSTITUTECODE                                     " +
        "       and d.COMPANYCODE=a.COMPANYCODE                                            and d.INTERVIEWCODE=a.INTERVIEWCODE     " +
        "                                    )";
//out.print(qry5);
rs5=db.getRowset(qry5);
if(rs5.next())
			{
	mAbsent="Previously shortlisted in "+rs5.getString("VACANCYCODE")+" ,Not attended";
			}
			else
			{
mAbsent="";
			}





//------------------------------------------------------
if(mSHORTLISTSEQNO==1)
			{
			mNotSelect="checked";
			mTabColor="white";
			}
if(mMaxSeq==3 && mSHORTLISTSEQNO==3)
			{
	mDisable="disabled";
			}



//out.print(mSelect+" :: "+ mReject);
	 %>

	 <input type="Hidden" name="ApplicationID<%=slno%>" id="ApplicationID<%=slno%>" value="<%=mApplicantID%>">
     <tr bgColor="<%=mTabColor%>" id="TableRow<%=slno%>" name="TableRow<%=slno%>">
	 <td  class="labelcell"  valign=top> <%=slno%>.</td>
<!-- 	 <td  class="labelcell"  valign=top> <B><%=mAppRefNo%></B></td> -->

	  <td  valign=top class="labelcell" nowrap>
             <input type="radio" name="Status<%=slno%>" value="S" id="StatusS<%=slno%>" <%=mDisable%> <%=mSelect%> onclick=" ColorCheck1('<%=slno%>');"  >


			 <font color=green > <b> Selected</b></font>
			 <br>

			 <input type="radio"  name="Status<%=slno%>" id="StatusR<%=slno%>" value="R" <%=mDisable%> <%=mReject%> onclick="ColorCheck2('<%=slno%>')">

			 <font color=red > <b> Rejected</b></font>
			 <br>
			 <input type="radio"  name="Status<%=slno%>" id="StatusN<%=slno%>" value="N" <%=mDisable%> <%=mNotSelect%>  onclick="ColorCheck3('<%=slno%>')">
			 <font color=blue > <b> Not Processed</b></font>



         </td>
		  	<%
			 mReject="";
			 mSelect="";
			 mNotSelect="";
			%>
         <td  class="labelcell" nowrap valign=top>
             <%=mAppName%><br><br> DOB :<%=mDOB%> <BR>Age :<%=rs.getString("Age")%> <BR> <BR> Gender :<%=rs.getString("GENDER")%>


		 </td>
         <td class="labelcell" valign=top >
             <%=mAdd1%>&nbsp;<%=mAdd2%>&nbsp;<%=mAdd3%><br>
             <%=mCity%>&nbsp;<%=mState%>&nbsp;<%=mDistrict%>
<BR>
<p style="background-color:GREEN" >
		<!-- <marquee behavior=alternate scrolldelay=300 direction=right> -->	<FONT SIZE="3" COLOR="WHITE" face="verdana"><B>  <%=mAbsent%></B></FONT>
		</B><!-- </marquee> -->
		</p>

<BR>	<%
	//if(!memailmsg.equals(""))
	//		{
	%>
		<p style="background-color:red" >
		<!-- <marquee behavior=alternate scrolldelay=300 direction=right> -->	<FONT SIZE="3" COLOR="WHITE" face="verdana"><B>  <%=memailmsg%></B></FONT>
		</B><!-- </marquee> -->
		</p>
		<%
		//	}
		%>
         </td>

             <td class="labelcell" valign=top>
                 <table borderColor=#D98242 rules=group border=1 width="100%" cellspacing=2 cellpadding=0>

					<tr>
                         <td class="labelcell" valign="top"><b>Degree&nbsp;</b></td>
                         <td class="labelcell" valign="top"><b>University/Institute
						 </b></td>
                         <td class="labelcell" valign="top"><b>Year</b></td>

                     </tr>
					 	<!-- <tr>  <td class="labelcell" colspan=4><hr></hr></td> </tr> -->

<%
try{
String mQCode = "", mINSTITUTION= "", mYEAROFPASSING = "", mArea = "";
qry1 = " SELECT nvl(a.QUALIFICATIONCODE,' ')QUALIFICATIONCODE, nvl(a.INSTITUTION,' ')INSTITUTION, a.APPLICANTID, " +
"  nvl(a.AREAOFQUALIFICATION,' ')AREAOFQUALIFICATION ,decode(a.yearofpassing,'0',' ',a.yearofpassing )yearofpassing,nvl(b.shortname ,' ')shortname ,nvl(b.SEQNO,0)SEQNO,nvl(a.QUALIFICATIONINSTITUTE,' ')QUALIFICATIONINSTITUTE, DECODE (a.yearofpassing, '0','2012' , a.yearofpassing) yearofpassing1 FROM HR#APPLICANTQUALIFICATION a,HR#QUALIFICATIONTAGGING b where a.APPLICANTID='" + mApplicantID + "' and b.INSTITUTECODE='"+mInst+"' AND  b.VACANCYCODE='" + mVacCode + "' and a.COMPANYCODE=b.COMPANYCODE and  a.INSTITUTECODE=b.INSTITUTECODE  and  a.QUALIFICATIONCODE=b.QUALIFICATIONCODE  order by yearofpassing1 desc";
//out.print(qry1);
rs1 = db.getRowset(qry1);
while (rs1.next()) {
mQCode = rs1.getString("shortname").toUpperCase();
mINSTITUTION = rs1.getString("INSTITUTION").toString();
mYEAROFPASSING = rs1.getString("YEAROFPASSING").toString();
mArea = rs1.getString("AREAOFQUALIFICATION").toString().toUpperCase();

//out.print(mYEAROFPASSING);
%>
<tr >
<td nowrap class="labelcell" align=left><%=mQCode%></td>
<td class="labelcell">&nbsp;<%=mINSTITUTION%></td>
<td class="labelcell" align=right>&nbsp;&nbsp;<%=mYEAROFPASSING%></td>
</tr>
<%

}

}
catch(Exception e)
{
//out.print(e+"   12345");
}
%>
        </table>
    </td>
    <td valign=top  class="labelcell" >
        <table borderColor="#D98242" rules=group width="100%"  cellspacing=2 cellpadding=0 border=1 >
             <tr >
                <td class="labelcell" valign="top"><font size=2><b>Designation</b></td>
				<td class="labelcell" valign="top"><font size=2><b>Institute/Company</b></td>
                <td class="labelcell" valign="top"><font size=2><b>Period From</b></td>
                <td class="labelcell" valign="top"><font size=2><b>Period To</b></td>
				<td class="labelcell" valign="top"><font size=2><b>Total Exp.</b></td>
            </tr>
	<!-- 		<tr>  <td class="labelcell" colspan=5><hr></hr></td> </tr>  -->
                     <%
            try{
String mYear="",mMonth1="";
int mMonth=0;
            qry2 = "SELECT nvl(a.prevorganisation,' ')prevorganisation, " +
                    " nvl(a.postheld,' ')postheld, nvl(a.natureofjob,' ')natureofjob, " +
                    " nvl(to_char(FROMDATE,'FMMon DD,yyyy'),' ')FROMDATE, nvl(to_char(TODATE,'FMMon DD,yyyy'),' ')TODATE" +
                    " ,   nvl(SUBSTR (MONTHS_BETWEEN ( decode(a.TILLDATE,'Y',sysdate, a.todate),a.FROMDATE) / 12,1,INSTR (MONTHS_BETWEEN (decode(a.TILLDATE,'Y',sysdate, a.todate),a.FROMDATE) / 12, '.') - 1  ),'N') year1, nvl(ROUND (  SUBSTR (MONTHS_BETWEEN (decode(a.TILLDATE,'Y',sysdate, a.todate),a.FROMDATE) / 12,INSTR (MONTHS_BETWEEN (decode(a.TILLDATE,'Y',sysdate, a.todate),FROMDATE) / 12,'.')) * 12 ),'0') month1, decode(a.tillDate,'Y','TillDate','',' ',a.tillDate)tillDate,to_char(a.todate,'yyymmdd')todatee FROM hr#applicantexperience a WHERE applicantid = '" + mApplicantID + "' order by  todatee desc";
       // out.print(qry2);
            rs2 = db.getRowset(qry2);
            while (rs2.next()) {
                mPrev = rs2.getString("prevorganisation").toUpperCase();
                mPostheld = rs2.getString("postheld").toString();
                mFROMDATE = rs2.getString("FROMDATE").toString();
                mTODATE = rs2.getString("TODATE").toString();
				mYear= rs2.getString("year1");
				mMonth= rs2.getInt("month1");
				if(mYear.equals("N"))
					mYear="";
				else
					mYear=mYear+"Year";

				if(mMonth==0)
					 mMonth1="";
				else
					 mMonth1=mMonth+"Month";

				//if(mTODATE.euqals(""))

                     %>
                     <tr  >

                         <td class="labelcell" valign="top" ><%=mPostheld%>&nbsp;</td>
                         <td class="labelcell" valign="top" ><%=mPrev%>&nbsp;</td>
                         <td class="labelcell" nowrap valign="top" ><%=mFROMDATE%>&nbsp;</td>
                         <td class="labelcell" nowrap valign="top" ><%=mTODATE%>&nbsp;<%= rs2.getString("tilldate")%></td>
						 <td class="labelcell" nowrap valign="top" ><%=mYear%><%=mMonth1%>&nbsp;</td>

                     </tr>
                     <%
                     }

            }
            catch(Exception e)
                    {
                        out.print(e+"  Error");
                    }
                     %>
                 </table>

             </td>
             <td class="labelcell" nowrap valign=top>
                 <%
				 try{
                 String link="";
                 qry4="select nvl(CVFILENAME,'N')CVFILENAME  from HR#APPLICANTRESUME " +
                         "where APPLICANTID='" + mApplicantID + "'";
                         rs4=db.getRowset(qry4);
                         if(rs4.next())
                             {
                            link=rs4.getString("CVFILENAME").toString().trim();
							//link="//172.16.5.45/"+link;
							//link="data/HOLIDAYS 2011.doc";
							//link=link.substring( link.lastIndexOf("/data")+1);
							//out.print(link.substring( link.lastIndexOf("/data/")+1));
						//	out.print(link);
                                %>
                <!--  <INPUT TYPE="button" name="ViewCV" value="Click to View"  title="Click to View CV"  onClick="openWordDocPath('<%=link%>')"   > -->
                  <a href="<%=link%>" title="C.V.<%=link%>" target="_NEW" > <font color=blue > View C.V. </font></a>
                 </td>

             <%
                           }
			   }
            catch(Exception e)
                    {
                        out.print(e+"  Error");
                    }

           %>



			     <td valign=top class="labelcell">
                 <input name="DeptRemarks<%=slno%>" id="DeptRemarks<%=slno%>" <%=mDisable%>  style="width:150px" value="<%=mRemarks%>"  maxlength=200>
              </td>

         </tr>
         <%
				 	//mSelect="";
				mDisable="";
				mTabColor="";
				
        }	
   //out.print(count+"dsfsfd");
	 %>
	 <tr>
	 <td colspan="11" align="left">
	 <%
		 if(!mDisable.equals("disabled"))
		{
		 %>


	<!--  <INPUT TYPE="submit" name="Submit1" value="Click To Save"> -->
&nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;
		  <INPUT TYPE="submit" name="Freeze" value="Click to Freeze" onClick="return onFreeze('<%=slno%>');">	
	 <%
		 }

		}
			 %>
	 </td>
	 </tr>
     </table>
	 <INPUT TYPE="hidden" NAME="Paging" VALUE="substract">


     <input type="hidden" name="sstart" id="sstart"  value="<%=start%>">
	   <input type="hidden" name="llast" id="llast" value="<%=last%>">
	  <input type="hidden" name="ShortlistSeq" id="ShortlistSeq" value="<%=mSHORTLISTSEQNO%>">
 <input type="Hidden" name="TotalCount" id="TotalCount" value="<%=slno%>">
 <input type="Hidden" name="VacancyCode" id="VacancyCode" value="<%=mVacCode%>">
  <input type="Hidden" name="DeptCode" id="DeptCode" value="<%=mDeptCode%>">
 <input type="hidden" name="DESCODE" id="DESCODE" value="<%=mDesignation%>">
  <INPUT TYPE="hidden" NAME="ShowStatus" ID="ShowStatus" VALUE="<%=mShow%>">
 <input type="Hidden" name="Institute" id="Institute" value="<%=mInst%>">
  <input type="Hidden" name="CompanyCode" id="CompanyCode" value="<%=mComp%>">
<input type="hidden" name="llast" value="<%=last%>">
			  <input type="hidden" name="ccustom" value="<%=custom%>">

			  
 </form>

 <%
     if(last<count)
         {
		// slno=slno+20;
		// out.print(slno+"slnoslno");
     %>
 <form method="post" action="DepartmentLinksPage.jsp">
 <INPUT TYPE="hidden" NAME="Paging" VALUE="add">
  <INPUT TYPE="hidden" NAME="ShowStatus" ID="ShowStatus" VALUE="<%=mShow%>">

     <input type="hidden" name="sstart" id="sstart" value="<%=start%>">
     <input type="hidden" name="llast"  id="llast" value="<%=last%>">
	 <INPUT TYPE="hidden" NAME="Show" ID="Show" VALUE="<%=mShow%>">
     <input type="hidden" name="ccustom" value="<%=custom%>">
     <input type="hidden" name="ShortlistSeq" id="ShortlistSeq" value="<%=mSHORTLISTSEQNO%>">
     <input type="Hidden" name="TotalCount" id="TotalCount" value="<%=slno%>">
     <input type="Hidden" name="VacancyCode" id="VacancyCode" value="<%=mVacCode%>">
	 <input type="Hidden" name="DeptCode" id="DeptCode" value="<%=mDeptCode%>">
         <input type="hidden" name="DESCODE" id="DESCODE" value="<%=mDesignation%>">
     <input type="hidden" name="x" id="x">
     <input type="Hidden" name="Institute" id="Institute" value="<%=mInst%>">
     <input type="Hidden" name="CompanyCode" id="CompanyCode" value="<%=mComp%>">

	 		  
	<br>
     <INPUT TYPE="submit" value="Next>>"  name="Next">
	
 </form>
 <%
		 }

     if(start!=1)
         {
		 //slno=slno-20;


                 %>
				 <br>
 <form method="post" action="DepartmentLinksPage.jsp">
      <input type="hidden" name="x" id="x">
 <INPUT TYPE="hidden" NAME="ShowStatus" ID="ShowStatus" VALUE="<%=mShow%>">
	  	<INPUT TYPE="hidden" NAME="Paging" VALUE="substract">
     <input type="hidden" name="sstart" id="sstart" value="<%=start%>">
	 <INPUT TYPE="hidden" NAME="Show" ID="Show" VALUE="<%=mShow%>">
     <input type="hidden" name="llast"  id="llast" value="<%=last%>">
     <input type="hidden" name="ccustom" value="<%=custom%>">
     <input type="hidden" name="ShortlistSeq" id="ShortlistSeq" value="<%=mSHORTLISTSEQNO%>">
     <input type="Hidden" name="TotalCount" id="TotalCount" value="<%=slno%>">
     <input type="Hidden" name="VacancyCode" id="VacancyCode" value="<%=mVacCode%>">      
	 <input type="Hidden" name="DeptCode" id="DeptCode" value="<%=mDeptCode%>">
         <input type="hidden" name="DESCODE" id="DESCODE" value="<%=mDesignation%>">
     <input type="Hidden" name="Institute" id="Institute" value="<%=mInst%>">
     <input type="Hidden" name="CompanyCode" id="CompanyCode" value="<%=mComp%>">
	   <INPUT TYPE="hidden" NAME="ShowStatus" ID="ShowStatus" VALUE="<%=mShow%>">
 		  
	 <input TYPE="submit" value="<<Previous" name="Previous">

	 </form>
     <%

     }
		}
 }
else
{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
	//out.print("Exception "+e);
}
%>