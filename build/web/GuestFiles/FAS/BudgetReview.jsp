<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String mHead="";
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberID="",mDMemberCode="",mDMemberType="";
String mInst="";
String mDepartmentCode="",mCompanyCode="";
String mSrcType="";
int mRights=0;
String qry="";
String qry1="";
String qry2="";
String qry3="";
String qryb="";
String mDept="",mCC="",mFin="",mBug="";
String mCmp="",mDc="",mFy="",mBid="",mFp="",mTp="";
String mExhaust="";
int ctr=0;
int ctr1=0;
int ctr3=0;
int ctr4=0;
int ctr5=0;
int mHSID=0;
int mFlag=0;
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet rsb=null;
String mRevOn="",mAllTyp="",mBT="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
{
	mHead=session.getAttribute("PageHeading").toString().trim();
}
else
{
	mHead="JIIT ";
}
if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("DepartmentCode")==null)
{
	mDepartmentCode="";
}
else
{
	mDepartmentCode=session.getAttribute("DepartmentCode").toString().trim();
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

if (request.getParameter("SrcType")==null)
{
	mSrcType="";
}
else
{
	mSrcType=request.getParameter("SrcType").toString().trim();
}

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Budget Review] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
	if(window.history.forward(1)!=null)
	window.history.forward(1);	
</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function iSValidDate(pDate)
 {
//1 
if(document.frm.FromPeriod.value!="" && document.frm.FromPeriod.value!=" ")
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
  			alert('Please Enter the valid date format in From Period date field i.e DD-MM-YYYY.'); 
			document.frm.FromPeriod.value="";
			frm.FromPeriod.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in From Period date field i.e DD-MM-YYYY.'); 
			document.frm.FromPeriod.value="";
			frm.FromPeriod.focus();
		  }
      } //3
	  else
		  {
		  alert('Please Enter the valid date format in From Period date field i.e DD-MM-YYYY.'); 
			document.frm.FromPeriod.value="";
			frm.FromPeriod.focus();
		  }
 //   } //2
  return (mISValidDate);
}
}


function iSValidDate1(pDate)
 {
//1 
if(document.frm.ToPeriod.value!="" && document.frm.ToPeriod.value!=" ")
{
    var dn, mn, yn, maxday;
    var mDate = pDate;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDate1 = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]

	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
//alert(mDate.substring(0,2)+'=='+mDate.substring(3, 5)+'=='+parseInt(mDate.substring(6)));
           if (parseInt(mDate.substring(0,2).trim()) >= 1 &&
              parseInt(mDate.substring(0,2).trim()) <=31 &&
              parseInt(mDate.substring(3, 5).trim()) <= 12 &&
               parseInt(mDate.substring(3, 5).trim()) >= 1 &&
              parseInt(mDate.substring(6).trim()) >= 1900 &&
              parseInt(mDate.substring(6).trim()) <= 3000)
			 { //5
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
              mISValidDate1 =true;
          } //5
		  else
		  {
  		alert('Please Enter the valid date format in Period upto date field i.e DD-MM-YYYY.'); 
			document.frm.ToPeriod.value="";
			frm.ToPeriod.focus();
		  }
        } //4
		else
		  {
			alert('Please Enter the valid date format in Period upto date field i.e DD-MM-YYYY.'); 
			document.frm.ToPeriod.value="";
			frm.ToPeriod.focus();
		  }
      } //3
	  else
		  {
			 alert('Please Enter the valid date format in Period upto date field i.e DD-MM-YYYY.'); 
			document.frm.ToPeriod.value="";
			frm.ToPeriod.focus();
		  }
 //   } //2
  return (mISValidDate1);
}
}
//-->
</SCRIPT>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  >
<%
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

	if(mSrcType.equals("H"))
	{
	   mRights=154;
	//  Heading="Admin.";	
	}
	else 
	{
	   mRights=155;
	//  Heading="DepartmentWise";	
	}
	
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	    qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	    {
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	
	%>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
			<TD colspan=0 align=middle width=34%><font color="#a52a2a" 
style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>
Budget Review</FONT></u></b></td>
			</tr>
			</table>
  <form name="frm"  method="post"> 
<input id="x" name="x" type=hidden>
<table align=center bottommargin=0 cellspacing=0 cellpadding=2 topmargin=0 border=1 rule=rows width="98%">
<tr>
<td>
<b>Company Code</b>
<select name="CompanyCode" id="CompanyCode" style="WIDTH: 100px">
<%
	qry="select distinct companycode from companymaster where nvl(DEACTIVE,'N')='N' ";
	rs=db.getRowset(qry);
	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mCC=rs.getString("companycode");
		%>				
			<option value="<%=mCC%>"><%=rs.getString("companycode")%></option>
		<%
		}
	}
	else
	{
		while(rs.next())
		{
		mCC=rs.getString("companycode");		
		if(mDept.equals(request.getParameter("CompanyCode")))	
		{
		%>				
			<option selected  value="<%=mCC%>"><%=rs.getString("companycode")%></option>
		<%
		}
		else
		{
		%>				
			<option value="<%=mCC%>"><%=rs.getString("companycode")%></option>
		<%
		}
		} // closing of while
	}

%>
</select>
</td>
<td>
<b>Department</b>&nbsp;
<select name="Department" id="Department" style="WIDTH: 250px">
<%
	if(mSrcType.equals("H"))
	{
		qry="select distinct A.DEPARTMENT DEPARTMENT,B.Departmentcode Departmentcode from DEPARTMENTMASTER A,FAS#BUDGETDETAIL B ";
		qry=qry+" WHERE A.DEPARTMENTCODE=B.DEPARTMENTCODE AND NVL(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' and A.departmentcode='"+mDepartmentCode+"' "; 
	}
	else
	{
	qry="select distinct A.DEPARTMENT DEPARTMENT,B.Departmentcode Departmentcode from DEPARTMENTMASTER A,FAS#BUDGETDETAIL B ";
	qry=qry+" WHERE A.DEPARTMENTCODE=B.DEPARTMENTCODE AND NVL(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' "; 
	}
	rs=db.getRowset(qry);
	
	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mDept=rs.getString("Departmentcode");
		%>				
			<option value="<%=mDept%>"><%=rs.getString("DEPARTMENT")%></option>
		<%
		}
	}
	else
	{
		while(rs.next())
		{
		mDept=rs.getString("Departmentcode");		
		if(mDept.equals(request.getParameter("Department")))	
		{
		%>				
			<option selected  value="<%=mDept%>"><%=rs.getString("DEPARTMENT")%></option>
		<%
		}
		else
		{
		%>				
			<option value="<%=mDept%>"><%=rs.getString("DEPARTMENT")%></option>
		<%
		}
		} // closing of while
	}

%>
</select>
</td>
</tr>
<tr>
<td>
<b>Financial Year</b>&nbsp;
 <select name="FinancialYear" id="FinancialYear" style="WIDTH: 100px">
<%
	qry="select distinct FINANCIALYEARCODE,YEARFROM,YEARTO from FINANCIALYEARMASTER  ";
	qry=qry+"WHERE  FINANCIALYEARCODE in (select distinct FINANCIALYEAR from FAS#BUDGETMASTER ";
	qry=qry+" where NVL(DEACTIVE,'N')='N') and NVL(DEACTIVE,'N')='N'  order by 1"; 
	rs=db.getRowset(qry);
	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mFin=rs.getString("FINANCIALYEARCODE");
		%>				
			<option value="<%=mFin%>"><%=rs.getString("FINANCIALYEARCODE")%></option>
		<%
		}
	}
	else
	{
		while(rs.next())
		{
		mFin=rs.getString("FINANCIALYEARCODE");		
		if(mFin.equals(request.getParameter("FinancialYear")))	
		{
		%>				
			<option selected  value="<%=mFin%>"><%=rs.getString("FINANCIALYEARCODE")%></option>
		<%
		}
		else
		{
		%>				
			<option value="<%=mFin%>"><%=rs.getString("FINANCIALYEARCODE")%></option>
		<%
		}
		} // closing of while
	}
%>
</select>

</td>
<td>
<b>Budget ID</b>&nbsp;&nbsp;&nbsp;
 <select name="BudgetID" id="BudgetID" style="WIDTH: 250px">
<%
	qry="select distinct BUDGETID,FINANCIALYEAR,BUDGETDESCRIPTION from FAS#BUDGETMASTER";
	qry=qry+" WHERE  NVL(DEACTIVE,'N')='N'  order by BUDGETDESCRIPTION "; 
	rs=db.getRowset(qry);
	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mBug=rs.getString("BUDGETID");
		%>				
			<option value="<%=mBug%>"><%=rs.getString("BUDGETDESCRIPTION")%>&nbsp;(<%=rs.getString("FINANCIALYEAR")%>)&nbsp;(<%=rs.getString("BUDGETID")%>)</option>
		<%
		}
	}
	else
	{
		while(rs.next())
		{
		mBug=rs.getString("BUDGETID");		
		if(mBug.equals(request.getParameter("BudgetID")))	
		{
		%>				
			<option selected value="<%=mBug%>"><%=rs.getString("BUDGETDESCRIPTION")%>&nbsp;(<%=rs.getString("FINANCIALYEAR")%>)&nbsp;(<%=rs.getString("BUDGETID")%>)</option>
		<%
		}
		else
		{
		%>				
			<option value="<%=mBug%>"><%=rs.getString("BUDGETDESCRIPTION")%>&nbsp;(<%=rs.getString("FINANCIALYEAR")%>)&nbsp;(<%=rs.getString("BUDGETID")%>)</option>
		<%
		}
		} // closing of while
	}
%>
</select>
</td>
</tr>
<tr>
<%
		if(request.getParameter("FromPeriod")==null)
			mFp="";
		else
			mFp=request.getParameter("FromPeriod").toString().trim();
		if(request.getParameter("ToPeriod")==null)
			mTp="";
		else
			mTp=request.getParameter("ToPeriod").toString().trim();
%>
<td colspan=2>
<b>Period From</b>&nbsp; &nbsp;&nbsp;
<input type=text value="<%=mFp%>" name="FromPeriod" id="FromPeriod" maxlength=10 size=9 onchange="return iSValidDate(FromPeriod.value);">
<b>To</b>
<input type=text value="<%=mTp%>" name="ToPeriod" id="ToPeriod" maxlength=10 size=9 onchange="return iSValidDate1(ToPeriod.value);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<input type=submit value="Show/Refresh">
</td>
</tr>
</table>		
</form>
<%
	if(request.getParameter("x")!=null)
	{
		if(request.getParameter("CompanyCode")==null)
			mCmp="";
		else
			mCmp=request.getParameter("CompanyCode").toString().trim();

		if(request.getParameter("Department")==null)
			mDc="";
		else
			mDc=request.getParameter("Department").toString().trim();

		if(request.getParameter("FinancialYear")==null)
			mFy="";
		else
			mFy=request.getParameter("FinancialYear").toString().trim();

		if(request.getParameter("BudgetID")==null)
			mBid="";
		else
			mBid=request.getParameter("BudgetID").toString().trim();

		if(request.getParameter("FromPeriod")==null)
			mFp="";
		else
			mFp=request.getParameter("FromPeriod").toString().trim();

		if(request.getParameter("ToPeriod")==null)
			mTp="";
		else
			mTp=request.getParameter("ToPeriod").toString().trim();
	if(!mDc.equals("") && !mFy.equals("") && !mBid.equals(""))
		{
		qry="SELECT HSID,HSCODE,HSCODEDESC,nvl(REQUIREDAMOUNT,0)REQUIREDAMOUNT,nvl(PROPOSEDAMOUNT,0)PROPOSEDAMOUNT,nvl(APPROVEDAMOUNT,0)APPROVEDAMOUNT, ";
		qry=qry+" nvl(ALLOTEDAMOUNT,0)ALLOTEDAMOUNT,EXHAUSTON,BUDGETTYPE,BUDGETCATEGORY "; 
		qry=qry+" FROM FAS#BUDGETDETAIL where companycode='"+mCmp+"' and departmentcode='"+mDc+"' ";
		qry=qry+" and financialyear='"+mFy+"' and budgetid='"+mBid+"' and nvl(DEACTIVE,'N')='N' and nvl(APPROVALREQUIRED,'Y')='N' ";	
		rs=db.getRowset(qry);

		while(rs.next())
		{
					
			ctr++;
			mHSID=rs.getInt("HSID");	
			mExhaust=rs.getString("EXHAUSTON");
	if(ctr==1)	
		{
			%>	
	<TABLE bgcolor=#fce9c5 class="sort-table"  width=98% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
	<thead>
	<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Sno.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Budget Head(code)<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>From Date<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>To Date<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Req. Amt. <B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Prop. Amt.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Appr. Amt.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Allo. Amt.<B><font></TD>
		<!--<TD ALIGN=CENTER><font color=white><b>Utilised Amt.<B><font></TD>-->
		<TD ALIGN=CENTER><font color=white><b>Budget Type<B><font></TD>
	</tr>
	</thead>	
	<%
	}
			qryb="SELECT BUDGETTYPEDESCRIPTION FROM FAS#BUDGETTYPEMASTER where ";
			qryb=qryb+"companycode='"+mCmp+"' and BUDGETTYPE='"+rs.getString("BUDGETTYPE")+"' ";
			rsb=db.getRowset(qryb);
			rsb.next();
			mBT=rsb.getString("BUDGETTYPEDESCRIPTION");
		
		qry1="select REVISIONCODE,nvl(REVISEDALLOTEDAMOUNT,0)REVISEDALLOTEDAMOUNT,REVISEDALLOCATIONTYPE FROM FAS#BUDGETREVISION ";
		qry1=qry1+" where companycode='"+mCmp+"' and budgetid='"+mBid+"' and HSID='"+mHSID+"' ";
		qry1=qry1+" and trunc(REVISIONDATE) between trunc(decode(to_date('"+mFp+"','dd-mm-yyyy'),'',REVISIONDATE,to_date('"+mFp+"','dd-mm-yyyy'))) ";
		qry1=qry1+" and trunc(decode(to_date('"+mTp+"','dd-mm-yyyy'),'',REVISIONDATE,to_date('"+mTp+"','dd-mm-yyyy'))) order by REVISIONDATE desc ";
		rs1=db.getRowset(qry1);
		if(rs1.next())
		{
			mFlag=1;
			
		%>
		<tr>
		<td><%=ctr%></td>
		<td nowrap><%=rs.getString("HSCODEDESC")%></td>
		<%	
			qry2="SELECT nvl(to_char(FROMDATE,'dd-mm-yyyy'),' ')FROMDATE,nvl(to_char(TODATE,'dd-mm-yyyy'),' ')TODATE,";
			qry2=qry2+"nvl(to_char(REVISEDTODATE,'dd-mm-yyyy'),' ')REVISEDTODATE,nvl(to_char(REVISEDFROMDATE,'dd-mm-yyyy'),' ')REVISEDFROMDATE,";
			qry2=qry2+"nvl(ALLOTEDAMOUNT,0)ALLOTEDAMOUNT,";
			qry2=qry2+"nvl(REVISEDALLOTEDAMOUNT,0)REVISEDALLOTEDAMOUNT FROM FAS#BUDGETALLOCATIONREVISION ";
			qry2=qry2+"where companycode='"+mCmp+"' and budgetid='"+mBid+"' and HSID='"+mHSID+"' ";
			qry2=qry2+"and REVISIONCODE='"+rs1.getString("REVISIONCODE")+"'  ";
			qry2=qry2+" and trunc(REVISEDFROMDATE) between trunc(decode(to_date('"+mFp+"','dd-mm-yyyy'),'',REVISEDFROMDATE,to_date('"+mFp+"','dd-mm-yyyy'))) ";
			qry2=qry2+" and trunc(decode(to_date('"+mTp+"','dd-mm-yyyy'),'',REVISEDFROMDATE,to_date('"+mTp+"','dd-mm-yyyy'))) ";
		  //qry2=qry2+" And ( to_date('"+mFp+"','dd-mm-yyyy') between REVISEDFROMDATE and REVISEDTODATE ";
		  //qry2=qry2+" or to_date('"+mTp+"','dd-mm-yyyy') between REVISEDFROMDATE and REVISEDTODATE)";
			rs2=db.getRowset(qry2);
			while(rs2.next())
			{
				ctr1++;
				if(ctr1>1)
				{
				%>
					<td>&nbsp;</td>
					<td nowrap>&nbsp;</td>
				<%
				}
				%>
					<td nowrap><%=rs2.getString("REVISEDFROMDATE")%></td>
					<td nowrap><%=rs2.getString("REVISEDTODATE")%></td>
					<td align=right><%=rs.getString("REQUIREDAMOUNT")%></td>
					<td align=right><%=rs.getString("PROPOSEDAMOUNT")%></td>
					<td align=right><%=rs.getString("APPROVEDAMOUNT")%></td>
					<td align=right><%=rs2.getString("REVISEDALLOTEDAMOUNT")%></td>
					<!--<td>&nbsp;</td>-->
					<td><%=mBT%></td>
					</tr>
				<%
			} // closing of while rs2
		} 
		else
		{
			if(!mExhaust.equals("T"))
			{
		if(ctr4==0)
		{
			ctr5++;
		%>
			<tr>
			<td><%=ctr5%></td>
		<%
		}
		else
		{
		%>
		<tr>
		<td><%=ctr%></td>
	<%
	}
	%>
		<td nowrap><%=rs.getString("HSCODEDESC")%></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td align=right><%=rs.getString("REQUIREDAMOUNT")%></td>
		<td align=right><%=rs.getString("PROPOSEDAMOUNT")%></td>
		<td align=right><%=rs.getString("APPROVEDAMOUNT")%></td>
		<td align=right><%=rs.getString("ALLOTEDAMOUNT")%></td>
		<!--<td >&nbsp;</td>-->
		<td><%=mBT%></td>
		</tr>  
	<% 
		}
   }
if(mFlag==0 && mExhaust.equals("T"))
{
qry3="SELECT nvl(to_char(FROMDATE,'dd-mm-yyyy'),' ')FROMDATE,nvl(to_char(TODATE,'dd-mm-yyyy'),' ')TODATE, ";
qry3=qry3+" nvl(ALLOTEDAMOUNT,0)ALLOTEDAMOUNT FROM FAS#BUDGETALLOCATIONPERIOD ";
qry3=qry3+" where companycode='"+mCmp+"' and budgetid='"+mBid+"' and hsid='"+mHSID+"' ";
qry3=qry3+" and trunc(FROMDATE) between trunc(decode(to_date('"+mFp+"','dd-mm-yyyy'),'',FROMDATE,to_date('"+mFp+"','dd-mm-yyyy'))) ";
qry3=qry3+" and trunc(decode(to_date('"+mTp+"','dd-mm-yyyy'),'',FROMDATE,to_date('"+mTp+"','dd-mm-yyyy'))) ";
rs3=db.getRowset(qry3);
while(rs3.next())
{
	ctr3++;
	ctr4++;
	if(ctr3==1)
	{
%>
		<tr>
		<td><%=ctr%></td>
		<td nowrap><%=rs.getString("HSCODEDESC")%></td>
<%
	}
	if(ctr3>1)
	{
%>
		<tr>
		<td>&nbsp;</td>
		<td nowrap>&nbsp;</td>
		<%
}
%>
		<td nowrap><%=rs3.getString("FROMDATE")%></td>
		<td nowrap><%=rs3.getString("TODATE")%></td>
		<td align=right><%=rs.getString("REQUIREDAMOUNT")%></td>
		<td align=right><%=rs.getString("PROPOSEDAMOUNT")%></td>
		<td align=right><%=rs.getString("APPROVEDAMOUNT")%></td>
		<td align=right><%=rs3.getString("ALLOTEDAMOUNT")%></td>
		<!--<td >&nbsp;</td>-->
		<td><%=mBT%></td>
		</tr>
<%
	} // closing of while rs3
ctr3=0;
	} // closing of if(mFlag==0 && mExhaust.equals("T"))
		mFlag=0;
 }	// closing of while
	if(ctr==0)
	{
		out.println("&nbsp;&nbsp;&nbsp;<b><font color=red>No matching record found...</font></b><br>");
	}

	}
	else
	{
		out.print("<font color=red>Please select the mandatory items...</font>");
	}
	} // closing of if(request.getParameter("x")!=null)
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
}
else
{
 %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br><br><br>  
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
	out.print(e);
}   
%>
</body>
</html>


