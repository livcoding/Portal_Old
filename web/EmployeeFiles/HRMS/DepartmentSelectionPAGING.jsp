<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
        try {
            String mVacCode = "", mVacDesc = "";
			String mMemberID ="",mMemberType="",mMemberName="",mMemberCode="";
            String mInst="",mComp="",mDept="";

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

    if (request.getParameter("VacancyCode")==null)
{
	mVacCode="";
}
else
{
	mVacCode=request.getParameter("VacancyCode").toString().trim();
}

     




String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <TITLE>#### <%=mHead%> [ DepartmentSelection ]</TITLE>
        <link  rel="stylesheet" type="text/css" href="css/style.css">
        
<script language="JavaScript" type ="text/javascript">

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
			
		if(ab>=0)
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
	}

/*
 function un_checkAllSelect()
{
var mFlag=0;
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'AllSelect') && (e.type == 'radio') &&(e.value=='S')) 
{ 
e.checked = document.frm1.AllSelect.checked;
if (mFlag==0 && document.frm1.AllSelect.checked==true)
	{ 
	document.frm1.AllReject.checked=false;
	mFlag=1;
	}
 } } }


 function un_checkAllNotSelect()
{
var mFlag=0;
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'AllNotSelect') && (e.type == 'radio') &&(e.value=='N')) 
{ 
e.checked = document.frm1.AllNotSelect.checked;
if (mFlag==0 && document.frm1.AllNotSelect.checked==true)
	{ 
	document.frm1.AllReject.checked=false;
	mFlag=1;
	}
 } } }

 function un_checkAllReject()
{
var mFlag=0;
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'AllReject') && (e.type == 'radio') &&(e.value=='R')) 
{ 
e.checked = document.frm1.AllReject.checked;
if (mFlag==0 && document.frm1.AllReject.checked==true)
	{ 
	document.frm1.AllSelect.checked=false;
	mFlag=1;
	}
 } } }*/

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

function ColorCheck1(slno)
	{
	//alert(document.getElementById("TableRow"+slno).bgColor+"KK");
	
		document.getElementById("TableRow"+slno).bgColor='lightgreen';

	}

function ColorCheck2(slno)
	{
	
				document.getElementById("TableRow"+slno).bgColor='pink';
	}
	function ColorCheck3(slno)
	{
	
				document.getElementById("TableRow"+slno).bgColor='lightblue';

	}

	function openWordDocPath(strLocation) {
		//alert("sdsdsdsd"+strLocation);
		var objWord;
		
		objWord = new ActiveXObject("Word.Application");
		//	alert("25215"+objWord);
		objWord.Visible = true;
		objWord.Documents.Open(strLocation);
	}
</script>
<SCRIPT LANGUAGE=vbscript>
function callMsgBox2(strMsg){
callMsgBox2 = msgBox(strMsg,4,"Application Selection:- Please Confirm")
}
</SCRIPT>
    </head>
    <body id="top" aLink=#ff00ff rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
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
    ResultSet rsss = null;
    String mDDS = "";
    String mS = "";
    String mPS = "";
    session.setAttribute("APPLICANTID", null);
    session.setAttribute("MFLAG", null);
   String mPrev = "", mPostheld = "", mNatureofJob = "", mTypeofExp = "";
            String mTODATE="",mFROMDATE="";

			String mDMemberID ="",mDMemberCode ="",mDMemberType="",mRightID="255";
    
        
        String mAppName = "", mDOB = "", mAdd1 = "", mAdd2 = "", mAdd3 = "", mCity = "", mState = "", mDistrict = "", mApplicantID = "",mStatus="",mReject="",mSelect="",mSelectedStatus="",mRemarks="",mFinalShortList="";
		String mDisable="",mTabColor="";
        int slno=0;
        int mSHORTLISTSEQNO=0,mShortSeq=0;


         if (request.getParameter("TotalCount")==null)
{
	slno=0;
}
else
{
	slno=Integer.parseInt(request.getParameter("TotalCount").trim());
}

     if (request.getParameter("ShortlistSeq")==null)
{
	mSHORTLISTSEQNO=0;
}
else
{
	mSHORTLISTSEQNO=Integer.parseInt(request.getParameter("ShortlistSeq").trim());
}

//---------------------------------MODIFICATIONS--------------------------------

    String qqry="",qryy="";
    int start,last,custom,count=0;

  /*  if(request.getParameter("ccustom")==null)
    {
        custom=3;
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
        start=Integer.parseInt(request.getParameter("sstart"))+custom;
    }
    
    
    if(request.getParameter("llast")==null)
    {
        last=custom;
    }
    else
    {
        last=Integer.parseInt(request.getParameter("llast"))+custom;
    }

    out.print(mVacCode+"---"+mSHORTLISTSEQNO+"///"+slno+"*(&"+last+"abc"+start);*/
	%>


   

<%
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
        <table  align=center >
            <tr><td ><h2>&nbsp;&nbsp; Initial ShortListing by Nominated Members &nbsp;&nbsp;</h2></td></tr>
        </table>
        <br>
        <form name="frm" method=post >    
            <input type=hidden name="x" id="x">
		<%	
			String mTSelected="" ;
		qry1="select count(c.applicantid)selected from   hr#applicantshortlistmaster c,  hr#applicationmaster a where a.vacancycode in (select vacancycode from HR#VACANCYMASTER WHERE institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD ) and a.departmentcode ='"+mDept+"'         and c.STATUS='S'   and c.SHORTLISTSEQNO=2     AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode";
		//out.print(qry1);
		rs1=db.getRowset(qry1);
		if(rs1.next())
			mTSelected=rs1.getString("selected");
		else
			mTSelected="";


			String mTReject="" ;
		qry2="select count(c.applicantid)reject from   hr#applicantshortlistmaster c,  hr#applicationmaster a where a.vacancycode in (select vacancycode from HR#VACANCYMASTER WHERE institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD ) and a.departmentcode ='"+mDept+"'         and c.STATUS='R'   and c.SHORTLISTSEQNO=2     AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode";
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mTReject=rs1.getString("reject");
		else
			mTReject="";

			String mTNotProcess="" ;
		qry1="select count(c.applicantid)NotProcess from   hr#applicantshortlistmaster c,  hr#applicationmaster a where a.vacancycode in (select vacancycode from HR#VACANCYMASTER WHERE institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD ) and a.departmentcode ='"+mDept+"'         and c.STATUS='N'   and c.SHORTLISTSEQNO=2     AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode";
		rs1=db.getRowset(qry1);
		if(rs1.next())
			mTNotProcess=rs1.getString("NotProcess");
		else
			mTNotProcess="";
		%>
		
		
		<table borderColor="#D98242" align=left  rules=none topmargin=0 cellspacing=2 cellpadding=7 border=1 >
		<tr bgColor="lightgreen">
		<td class="labelcell"><font Color=green><b> Total Selected  : &nbsp; &nbsp; &nbsp; <%=mTSelected%></b></td>
		</tr>

		<tr bgColor="pink">
		<td class="labelcell"><font Color=red> <b>Total Rejected  :  &nbsp; &nbsp; &nbsp; <%=mTReject%></b></td>
		</tr>

		<tr bgColor="lightblue">
		<td class="labelcell"><font Color=blue><b> Total Not Process :<%=mTNotProcess%></b></font></td>
		</tr>
		</table>
		

       <table borderColor="#D98242" align=center rules=none topmargin=0 cellspacing=0 cellpadding=4  border=1 >
               
				
				<tr> 
                    <td align="left" class="labelcell"><br>
                       <strong>Vacancy&nbsp;&nbsp;
					</td>
					<td><br>
					<%
	    qry = "SELECT distinct COMPANYCODE, INSTITUTECODE, VACANCYCODE, VACANCYDESCRIPTION," +
            " FROMPERIOD, TOPERIOD, BROADCAST, CLOSED, CLOSINGDATE FROM HR#VACANCYMASTER" +
            " WHERE NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD and" +
            " VACANCYCODE in (select VACANCYCODE from HR#APPLICATIONMASTER  where INSTITUTECODE='"+mInst+"')";
 //  	out.print("ssdsd"+qry);
	rs = db.getRowset(qry);

//out.print(qry);
	%>
                            <select name="Vacancy" id="Vacancy" tabindex=1>

                                <%



   if(request.getParameter("x")==null)
	{

		while (rs.next()) 
			{
		    mVacCode = rs.getString("VACANCYCODE").toString().trim();
			mVacDesc = rs.getString("VACANCYDESCRIPTION").toString().toUpperCase().trim();
                                %>
                                <option value="<%=mVacCode%>"><%=mVacDesc%></option>
                                <%
	        }
	}
	else
	{
			while (rs.next()) 
			{
				 mVacCode = rs.getString("VACANCYCODE").toString().trim();
				 mVacDesc = rs.getString("VACANCYDESCRIPTION").toString().toUpperCase().trim();
				 if(mVacCode.equals(request.getParameter("Vacancy").toString().trim()))
				{
					 %>
						 <option selected value="<%=mVacCode%>"><%=mVacDesc%></option>
					 <%
				}
				else
				{
						 %>
						 <option value="<%=mVacCode%>"><%=mVacDesc%></option>
					 <%
			
				}

			}

	} %>
                            </select>
                       </strong>

					
                      &nbsp;&nbsp;  </td>
             
                    <td align=left class="labelcell"><br>
					<strong>Department &nbsp;&nbsp;
					</td>
					<td  class="labelcell"><br>
  
						<%
					
try {
qry = "select distinct departmentcode,department from DEPARTMENTMASTER where" +
" nvl(DEACTIVE,'N')='N' and  departmentcode ='"+mDept+"' and departmentcode in (select distinct DEPARTMENTCODE from " +
"HR#APPLICATIONMASTER where INSTITUTECODE='"+mInst+"') order by DEPARTMENT";
//out.print(qry);
rsd = db.getRowset(qry);
							%>

                           <select NAME="Departmentcode" ID="Departmentcode" >
<%
while (rsd.next()) {
%>
<option value="<%=rsd.getString("DEPARTMENTCODE")%>"><%=rsd.getString("Department")%>  -  <%=rsd.getString("DEPARTMENTCODE")%></option>
<%
}
} catch (Exception e) {
//out.print(e+"  tyyyyy");
}
%>
                            </select>
                        </strong>
               </td>
                
<%
String mShowSelect="";

String mSelectN="",mSelectR="",mSelectS="",mSelectALL="";

//out.print(request.getParameter("x")+"mShowSelect");

if(request.getParameter("x")==null)
{
//mShowSelect=""request.getParameter("Show").toString().trim();
mSelectN="selected";
}
else
{
mShowSelect=request.getParameter("Show").toString().trim();	

if(mShowSelect.equals("ALL") )
	mSelectALL="selected";
else if(mShowSelect.equals("S") )
	mSelectS="selected";
else if(mShowSelect.equals("R") )
	mSelectR="selected";
else if(mShowSelect.equals("N") )
	mSelectN="selected";
else
	mSelectALL="selected";
		}

	%>

 <td align=left class="labelcell"><br>
<strong>&nbsp;&nbsp;Show &nbsp;&nbsp;
</td>
<td  class="labelcell"><br>
<select name="Show" ID="Show" >
<option <%=mSelectALL%> value='ALL'>ALL</option>
<option <%=mSelectS%> value='S'>Selected</option>
<option <%=mSelectR%> value='R'>Rejected</option>
<option <%=mSelectN%> value='N'>Pending</option>
</td>

</td>
</tr>
                <tr>
                    <td align=center colspan=6><br><input type=Submit style="background-color:#FFCF83" border= "3px" name=button id=button4 value="&nbsp; Click To View Detail &nbsp;" onClick="return Validate();" ></br></td>
                </tr>
            </table>
			</form>
            <%
           
    if (request.getParameter("x") != null) {
       
        String mDeptCode = "",mShow="",mNotSelect="",mFinal="";
		String mPage="";

		int mMaxSeq=0;
        mDeptCode = request.getParameter("Departmentcode").toString().trim();
		mVacCode= request.getParameter("Vacancy").toString().trim();
			mShow= request.getParameter("Show").toString().trim();

 if(request.getParameter("ccustom")==null)
    {
        custom=3;
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
			last=3;
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
 out.print(last+"**last"+start+"&&&start"+custom+"ss+<BR>");
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


 out.print(last+"**last"+start+"&&&start"+custom);

		//First Time Selection  //

qry="SELECT   (MAX (d.shortlistseqno))AA   FROM hr#applicantshortlistmaster d    WHERE d.institutecode = '"+mInst+"' AND d.vacancycode = '"+mVacCode+"' ";
rs=db.getRowset(qry);
//out.print(qry+"---");
if(rs.next())
mMaxSeq=rs.getInt("AA");

if(mMaxSeq==1)
	mShow="S";
else if (mMaxSeq==3)
	mMaxSeq=2;
	//out.print(mDeptCode + "sads");
%>


<form method=post name="frm1" action="DepartmentSelectAction.jsp"  >
 <INPUT TYPE="hidden" NAME="Show" ID="Show" VALUE="<%=mShow%>">
 <table width="100%" border=1  borderColor=#D98242 rules=group align=center bottommargin=1 topmargin=0 cellspacing=0 cellpadding=2>
     <br>
     <tr bgcolor="#FFCF83">
	  <td  class="labelcell"><b><CENTER>Sr.No.</CENTER></b></td>
       <td  class="labelcell"><b><CENTER>Candidate<br>Selection</CENTER></b></td>
         <td  class="labelcell"><b><CENTER>Name<br><br>DOB</CENTER></b></td>
                  <td  class="labelcell"><b><CENTER>Address</CENTER></b></td>
         <TD  align=left class="labelcell" nowrap valign=top> <table cellspacing=10 cellpadding=2 > <td class="labelcell" nowrap colspan=4><b> Applicant Qualification
				 <hr> </td>
				  <tr >
                <td class="labelcell" valign="top"><b>Degree </b></td>
				<td class="labelcell" valign="top"><b>Institute</b></td>
                <td class="labelcell" valign="top"><b>Year</b></td>
             	</tr>
				</table></TD>
		          <!-- <TD  align=left class="labelcell" nowrap><b> Applicant Experience <hr> <br> Designation &nbsp;Company &nbsp; PFrom &nbsp; PTo &nbsp; &nbsp; &nbsp; &nbsp;TotalExp.</b></TD> -->

				  <td valign=top>
				  <table cellspacing=10 cellpadding=2 > <td class="labelcell" nowrap colspan=6><b> Applicant Experience
				 <hr> </td>
				  <tr >
                <td class="labelcell" valign="top"><b>Designation</b></td>
				<td class="labelcell" valign="top"><b>Institute<br>Company</b></td>
                <td class="labelcell" valign="top"><b>Period<br>From</b></td>
                <td class="labelcell" valign="top"><b>Period<br>To</b></td>
				<td class="labelcell" valign="top"><b>Total<br>Experience</b></td>
				</tr>
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
         <td class="labelcell"><b><CENTER> Remark</CENTER></b> </td>
     </tr>

     <%
	out.print("111");
        qry = " SELECT round(months_between(sysdate,dateofbirth)/12)AGE , nvl(a.SHORTLISTED,' ')SHORTLISTED, decode(a.SHORTLISTED,'S','Selected','R','Rejected','',' ',a.SHORTLISTED)FINALSHORTLISTED,c.SHORTLISTSEQNO,a.APPLICANTID,nvl(a.firstname,' ') firstname,nvl(a.middlename,' ') middlename,nvl(a.lastname,' ') lastname,to_char(a.dateofbirth,'DD-MM-YYYY')dateofbirth " +
                ",nvl(b.CADDRESS1,' ')CADDRESS1, nvl(b.CADDRESS2,' ')CADDRESS2, nvl(b.CADDRESS3,' ')CADDRESS3, " +
                "nvl(b.CCITY,' ')ccity, nvl(b.CDISTRICT,' ')CDISTRICT, nvl(b.CSTATE,' ')CSTATE, b.CPIN,nvl(c.STATUS ,'N')STATUS ,nvl(c.REMARKS,' ')REMARKS ,nvl(C.final,'N') final   " +
"  FROM hr#applicationmaster a, hr#applicantaddress b,HR#APPLICANTSHORTLISTMASTER c" +
" WHERE a.applicantid = b.applicantid and	c.status =decode  ('"+mShow+"' ,'ALL',nvl(c.status,'N'),'"+mShow+"' ) " +                "   AND a.vacancycode = '" + mVacCode + "'" +
                "   AND a.departmentcode = '" + mDeptCode + "'    and a.APPLICANTID=c.APPLICANTID   and b.APPLICANTID=c.APPLICANTID   and a.VACANCYCODE=c.VACANCYCODE   and a.INSTITUTECODE=c.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE     AND A.INSTITUTECODE=C.INSTITUTECODE     AND a.institutecode = c.institutecode   AND c.shortlistseqno = "+mMaxSeq+"    ORDER BY a.firstname";	 

    qqry="select * from (select a.*, rownum rn from("+qry+") a where rownum<='"+last+"') where rn>='"+start+"'";
                rs = db.getRowset(qqry);
out.print(qqry);
        while (rs.next())
        {//out.print("LLLLLLLL");	
            slno++;
					
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
			
			if(mSHORTLISTSEQNO==1)
			mShortSeq=mSHORTLISTSEQNO+1;
				else
			mShortSeq=mSHORTLISTSEQNO;

	//out.print(mStatus+"sdsss"+rs.getString("STATUS").toString().trim());		
							
			
				qry1="SELECT  SHORTLISTSEQNO, STATUS,nvl(REMARKS,' ')REMARKS  FROM HR#APPLICANTSHORTLISTMASTER WHERE INSTITUTECODE='"+mInst+"' AND  VACANCYCODE='" + mVacCode + "' AND APPLICANTID ='"+mApplicantID+"' and SHORTLISTSEQNO= "+mShortSeq+" AND status =decode  ('"+mShow+"' ,'ALL',nvl(status,'N'),'"+mShow+"' ) ";
			//	out.print(qry1);
                //qqry="select * from (select a.*, rownum rn from("+qry1+") a where rownum<='"+last+"') where rn>='"+start+"'";
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
	mTabColor="lightblue";
     %>
	 <input type="Hidden" name="ApplicationID<%=slno%>" id="ApplicationID<%=slno%>" value="<%=mApplicantID%>">
     <tr bgColor="<%=mTabColor%>" id="TableRow<%=slno%>" name="TableRow<%=slno%>"> 
	 <td  class="labelcell"  valign=top> <%=slno%>.</td>
	  <td nowrap valign=top class="labelcell">
             <input type="radio" name="Status<%=slno%>" value="S" id="Status<%=slno%>" <%=mDisable%> <%=mSelect%> onclick="ColorCheck1('<%=slno%>')" >
			 <font color=green > <b> Selected</b></font>
			 <br>
			 <input type="radio"  name="Status<%=slno%>" id="Status<%=slno%>" value="R" <%=mDisable%> <%=mReject%> onclick="ColorCheck2('<%=slno%>')">
			 <font color=red > <b> Rejected</b></font>
			 <br>
			 <input type="radio"  name="Status<%=slno%>" id="Status<%=slno%>" value="N" <%=mDisable%> <%=mNotSelect%>  onclick="ColorCheck3('<%=slno%>')">
			 <font color=blue > <b> Not Selected</b></font>
         </td>
		  	<%
			 mReject="";
			 mSelect="";
			 mNotSelect="";
			%>
         <td  class="labelcell" nowrap valign=top>
             <%=mAppName%><br><br> DOB :<%=mDOB%> <BR>Age :<%=rs.getString("Age")%>
         </td>
         <td class="labelcell" valign=top>
             <%=mAdd1%>&nbsp;<%=mAdd2%>&nbsp;<%=mAdd3%><br>
             <%=mCity%>&nbsp;<%=mState%>&nbsp;<%=mDistrict%>
         </td>

             <td class="labelcell" valign=top>
                 <table borderColor=#D98242 rules=group cellspacing=2 cellpadding=0>
                   
					 <!-- <tr>
                         <td class="labelcell" valign="top"><b>Degree&nbsp;</b></td>
                         <td class="labelcell" valign="top"><b>Institute<br>University
						 </b></td>
                         <td class="labelcell" valign="top"><b>Year</b></td>
						 	
                     </tr>
					 	<tr>  <td class="labelcell" colspan=4><hr></hr></td> </tr> -->
				
<%
try{
String mQCode = "", mINSTITUTION= "", mYEAROFPASSING = "", mArea = "";
qry1 = " SELECT nvl(a.QUALIFICATIONCODE,' ')QUALIFICATIONCODE, nvl(a.INSTITUTION,' ')INSTITUTION, a.APPLICANTID, " +
"  nvl(a.AREAOFQUALIFICATION,' ')AREAOFQUALIFICATION ,decode(a.yearofpassing,'0',' ',a.yearofpassing )yearofpassing,nvl(b.shortname ,' ')shortname ,b.SEQNO,nvl(a.QUALIFICATIONINSTITUTE,' ')QUALIFICATIONINSTITUTE FROM HR#APPLICANTQUALIFICATION a,HR#QUALIFICATIONTAGGING b where a.APPLICANTID='" + mApplicantID + "' and b.INSTITUTECODE='"+mInst+"' AND  b.VACANCYCODE='" + mVacCode + "' and a.COMPANYCODE=b.COMPANYCODE and  a.INSTITUTECODE=b.INSTITUTECODE  and  a.QUALIFICATIONCODE=b.QUALIFICATIONCODE  order by b.SEQNO";
//out.print(qry1);
//qqry="select * from (select a.*, rownum rn from("+qry1+") a where rownum<='"+last+"') where rn>='"+start+"'";
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
<td class="labelcell">&nbsp;<%=rs1.getString("QUALIFICATIONINSTITUTE")%>&nbsp;<%=mINSTITUTION%></td>
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
        <table borderColor="#D98242" rules=group cellspacing=2 cellpadding=0 >
          <!--   <tr >
                <td class="labelcell" valign="top"><b>Designation</b></td>
				<td class="labelcell" valign="top"><b>Institute<br>Company</b></td>
                <td class="labelcell" valign="top"><b>Period<br>From</b></td>
                <td class="labelcell" valign="top"><b>Period<br>To</b></td>
				<td class="labelcell" valign="top"><b>Total<br>Experience</b></td>
            </tr>
			<tr>  <td class="labelcell" colspan=5><hr></hr></td> </tr> -->
                     <%
            try{
String mYear="";
int mMonth=0;
            qry2 = "SELECT nvl(a.prevorganisation,' ')prevorganisation, " +
                    " nvl(a.postheld,' ')postheld, nvl(a.natureofjob,' ')natureofjob, " +
                    " nvl(to_char(FROMDATE,'FMMon DD,yyyy'),' ')FROMDATE, nvl(to_char(TODATE,'FMMon DD,yyyy'),' ')TODATE" +
                    " ,   nvl(SUBSTR (MONTHS_BETWEEN ( a.TODATE,a.FROMDATE) / 12,1,INSTR (MONTHS_BETWEEN (a.TODATE,a.FROMDATE) / 12, '.') - 1  ),'N') year1, nvl(ROUND (  SUBSTR (MONTHS_BETWEEN (a.TODATE,a.FROMDATE) / 12,INSTR (MONTHS_BETWEEN (a.TODATE,FROMDATE) / 12,'.')) * 12 ),'0') month1 FROM hr#applicantexperience a WHERE applicantid = '" + mApplicantID + "'";
                   // qqry="select * from (select a.*, rownum rn from("+qry2+") a where rownum<='"+last+"') where rn>='"+start+"'";
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
					mYear=mYear+"YY";
			
				


                     %>
                     <tr  >
					
                         <td class="labelcell" ><%=mPostheld%>&nbsp;</td>
                         <td class="labelcell"  ><%=mPrev%>&nbsp;</td>
                         <td class="labelcell" nowrap valign="top" ><%=mFROMDATE%>&nbsp;</td>
                         <td class="labelcell" nowrap valign="top" ><%=mTODATE%>&nbsp;</td>
						 <td class="labelcell" nowrap valign="top" ><%=mYear%><%=mMonth%>MM</td>
						 
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
//qqry="select * from (select a.*, rownum rn from("+qry4+") a where rownum<='"+last+"') where rn>='"+start+"'";
                  rs4=db.getRowset(qry4);
                         if(rs4.next())
                             {
                            link=rs4.getString("CVFILENAME").toString().trim();                                                                                                                                                                                    //link="//172.16.5.45/"+link;
                                 //link="data/HOLIDAYS 2011.doc";
                                 //link=link.substring( link.lastIndexOf("/data")+1);
                                 //out.print(link.substring( link.lastIndexOf("/data/")+1));
                                 //	out.print(link);
%>
                 <!--  <INPUT TYPE="button" name="ViewCV" value="Click to View"  title="Click to View CV"  onClick="openWordDocPath('<%=link%>')"   > -->
                 <a href="<%=link%>" title="C.V.<%=link%>" target="_NEW" >View C.V.</a> 
             </td>
                 
             <%
                }
 //----------------------------query change for count------------------------------------

            } catch (Exception e) {
                out.print(e + "  Error");
            }
                
             %>
                 
                 
                 
             <td valign=top class="labelcell">
                 <input name="DeptRemarks<%=slno%>" id="DeptRemarks<%=slno%>" <%=mDisable%>  style="width:150px" value="<%=mRemarks%>"  maxlength=200>
             </td>
                 
         </tr>
         <%
            //mSelect=""; 
            mDisable = "";
        }

        qryy= "select count(*) count from ("+qry+")";

         rsss=db.getRowset(qryy);
         //out.print(qryy);
         if(rsss.next())
         {
         count=Integer.parseInt(rsss.getString("count").trim());
         //out.print(count);
         }

         %>
         <tr>
             <td colspan="11" align="left">
                 <%
        if (!mDisable.equals("disabled")) {
                 %>
                 <INPUT TYPE="submit" name="Submit1" value="Click To Save">       
                 &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;
                 <INPUT TYPE="submit" name="Freeze" value="Click To Freeze" onClick="return onFreeze('<%=slno%>');">
                 <%}
                 %>
             </td>
         </tr>
     </table>
     <input type="Hidden" name="ShortlistSeq" id="ShortlistSeq" value="<%=mSHORTLISTSEQNO%>">
     <input type="Hidden" name="TotalCount" id="TotalCount" value="<%=slno%>">
     <input type="Hidden" name="Vacancy" id="Vacancy" value="<%=mVacCode%>">
	  <input type="Hidden" name="Departmentcode" id="Departmentcode" value="<%=mDeptCode%>">
         
     <input type="Hidden" name="Institute" id="Institute" value="<%=mInst%>">
     <input type="Hidden" name="CompanyCode" id="CompanyCode" value="<%=mComp%>">
           <input type="hidden" name="sstart" value="<%=start%>">
		    <input type="hidden" name="llast" value="<%=last%>">
			  <input type="hidden" name="ccustom" value="<%=custom%>">
 </form>
     <%
   
     if(start!=1)
         {


                 %>
 <form method="post" action="DepartmentSelectionPAGING.jsp">
      <input type="hidden" name="x" id="x">
	  	<INPUT TYPE="hidden" NAME="Paging" VALUE="substract">
     <input type="hidden" name="sstart" value="<%=start%>">
	 <INPUT TYPE="hidden" NAME="Show" ID="Show" VALUE="<%=mShow%>">
     <input type="hidden" name="llast" value="<%=last%>">
     <input type="hidden" name="ccustom" value="<%=custom%>">
     <input type="Hidden" name="ShortlistSeq" id="ShortlistSeq" value="<%=mSHORTLISTSEQNO%>">
     <input type="Hidden" name="TotalCount" id="TotalCount" value="<%=slno%>">
     <input type="Hidden" name="Vacancy" id="Vacancy" value="<%=mVacCode%>">      
	 <input type="Hidden" name="Departmentcode" id="Departmentcode" value="<%=mDeptCode%>">
     <input type="Hidden" name="Institute" id="Institute" value="<%=mInst%>">
     <input type="Hidden" name="CompanyCode" id="CompanyCode" value="<%=mComp%>">
     <input TYPE="submit" value="Previous" name="Previous">
 </form>
     <%
     }
     if(last<count)
         {
     %>
 <form method="post" action="DepartmentSelectionPAGING.jsp">
 <INPUT TYPE="hidden" NAME="Paging" VALUE="add">
     <input type="hidden" name="sstart" value="<%=start%>">
     <input type="hidden" name="llast" value="<%=last%>">
	 <INPUT TYPE="hidden" NAME="Show" ID="Show" VALUE="<%=mShow%>">
     <input type="hidden" name="ccustom" value="<%=custom%>">
     <input type="Hidden" name="ShortlistSeq" id="ShortlistSeq" value="<%=mSHORTLISTSEQNO%>">
     <input type="Hidden" name="TotalCount" id="TotalCount" value="<%=slno%>">
     <input type="Hidden" name="Vacancy" id="Vacancy" value="<%=mVacCode%>">
	 <input type="Hidden" name="Departmentcode" id="Departmentcode" value="<%=mDeptCode%>">
     <input type="hidden" name="x" id="x">
     <input type="Hidden" name="Institute" id="Institute" value="<%=mInst%>">
     <input type="Hidden" name="CompanyCode" id="CompanyCode" value="<%=mComp%>">
     <INPUT TYPE="submit" value="Next"  name="Next">
 </form>
 </body>
</html>
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
        } catch (Exception e) {
            out.print(e+" zzzzz");
        }
%>

