<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>

<HTML>
<head>
<TITLE>#### <%=mHead%> [ DR/CR Advice Report ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

/*
***************************************************************************************
	' * File Name:		DetailStudEmpDrCrAdvice.JSP			[For Students]					
	' * Developed By:	Rajiv Srivastava
	' * Date:			17th Dec 07								
	' * Description:	Current Student Debit/Credit Advice Detail
***************************************************************************************
*/

DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",mWebEmail="";
String mPrevDay="", mPrevMonth="", mPrevYear="", mCurrentDay="", mCurrentMonth="", mCurrentYear="";
int PrevDay=0,PrevMonth=0,PrevYear=0,CurrentDay=0, CurrentMonth=0,CurrentYear=0;
int FromDate=0;
int ToDate=0;
String dam="";
String cam="";
String mFromDate="";
String mToDate="";
int count=0;int dAmount=0; int cAmount=0; int diff=0;
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mSem="";
int mSemPlusOne=0;
String mProg="",mBranch="",mName="",mDesignation="",mDepartment="";
String mINSTITUTECODE="",mComp="",mSID="",mEnrollment="", mType="", mSName="", mEmpName="";
ResultSet Rs=null,rs=null,rs1=null;

//****************************************************************************//

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
		mINSTITUTECODE="";
	}
	else
	{
		mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
	}

	if (session.getAttribute("ProgramCode")==null)
	{
		mProg="";
	}
	else
	{
		mProg=session.getAttribute("ProgramCode").toString().trim();
	}

	if (session.getAttribute("BranchCode")==null)
	{
		mBranch="";
	}
	else
	{
		mBranch=session.getAttribute("BranchCode").toString().trim();
	}

	if (session.getAttribute("CurrentSem")==null)
	{
		mSem="";
	}
	else
	{
		mSem=session.getAttribute("CurrentSem").toString().trim();
		mSemPlusOne=(Integer.parseInt(mSem))+0;
	}

	if (session.getAttribute("MemberName")==null)
	{
		mName="";
	}
	else
	{
		mName=session.getAttribute("MemberName").toString().trim();
	}

	if (request.getParameter("SID")==null)
	{
		mSID ="";
	}
	else
	{
		mSID =request.getParameter("SID").toString().trim();
	}

//*********************************************************************************

try
{//1

	//-----------------------------------------------------------------------
	//----------------------- Enable Security Page Level --------------------  
	//----------------------------------------------------------------------- 
	int mRID=0;
	mType=request.getParameter("mMType").toString().trim();
	
	if (mType.equals("E"))
	    mRID=153;
	else if	(mType.equals("S"))
		mRID=152;
	
	qry="Select COMPANYTAGGING From InstituteMaster Where InstituteCode='"+mINSTITUTECODE+"'";
	Rs= db.getRowset(qry);
	if (Rs.next())
		{
		  mComp=Rs.getString("COMPANYTAGGING");
		}

	if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{  //2
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mMacAddress =" "; 
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
		
		qry="Select WEBKIOSK.ShowLink('"+mRID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";

		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{//3
	  
			try
			{	
				mDMemberCode=enc.decode(mMemberCode);
				mMemberID=enc.decode(mMemberID);
				mMemberType=enc.decode(mMemberType);
			}

			catch(Exception e)
			{
				//out.println(e.getMessage());
			}
%>	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	  <tr>
	   <td align=left><font color="#a52a2a" style="FONT-SIZE: medium"><b>Debit/Credit Advice</b></font>
	   </td>
	   <td align=right><font color=brown><b>Login User :&nbsp; &nbsp;<%=mName%>[Emp. Code: <%=mDMemberCode%>]</b></font>
	   </td>
	  </tr>
	</table>

	<FORM METHOD=POST ACTION="DetailEmpStudDrCrAdvice.jsp">
	<table width=100% rules=groups cellspacing=1 cellpadding=1 align=center border=1>
	  <tr>
<%  
		if(mType.equals("E"))
		{	
		qry="Select nvl(a.EMPLOYEECODE,' ') EMPLOYEECODE, nvl(a.EMPLOYEENAME, ' ') EMPLOYEENAME, ";
		qry=qry+" nvl(b.DESIGNATION,' ') DESIGNATION, nvl(c.DEPARTMENT,' ') DEPARTMENT from ";
		qry=qry+" EmployeeMaster a, DESIGNATIONMASTER b, DEPARTMENTMASTER c Where a.EmployeeID='"+mSID+"'";
		qry=qry+" and a.DESIGNATIONCODE=b.DESIGNATIONCODE and a.DEPARTMENTCODE=c.DEPARTMENTCODE";
	
		rs=db.getRowset(qry);
	
			if(rs.next())
			{
				if (rs.getString("EMPLOYEENAME") ==null)
				mEmpName="";
				else
				mEmpName=rs.getString("EMPLOYEENAME");

				if (rs.getString("DESIGNATION") ==null)
				mDesignation="";
				else
				mDesignation=rs.getString("DESIGNATION");

				if (rs.getString("DEPARTMENT")==null)
				mDepartment="";
				else
				mDepartment=rs.getString("DEPARTMENT");
%>		
	   <td><font color=black face=arial size=2>										 <STRONG>Name:&nbsp;</STRONG></font><%=mEmpName%>
	   </td>

	   <td><font color=black face=arial size=2>											<STRONG>Department:&nbsp;</STRONG></font><%=mDepartment%>
	   </td>

	   <td><font color=black face=arial size=2>
        <STRONG>Designation:&nbsp;</STRONG></font><%=mDesignation%>
	   </td>
	  </tr>
<%
  			}
		}

		else if(mType.equals("S"))
		{
		qry="Select nvl(ACADEMICYEAR,' ') ACADEMICYEARCODE, nvl(ENROLLMENTNO,' ') ENROLLMENTNO, nvl(STUDENTNAME,' ') STUDENTNAME, nvl(PROGRAMCODE,' ') COURSECODE, nvl(BRANCHCODE,' ') BRANCHCODE,nvl(SEMESTER,0) SEMESTER , StudentID SID from StudentMaster  where InstituteCode='"+mINSTITUTECODE+"' and StudentID='"+mSID+"' and enrollmentno is not null order by StudentName,AcademicYearCode";

		rs=db.getRowset(qry);
	
			if(rs.next())
			{
			mSName=rs.getString("STUDENTNAME");
			mEnrollment=rs.getString("ENROLLMENTNO");
			mSem=rs.getString("SEMESTER");
			mProg=rs.getString("COURSECODE");
			mBranch=rs.getString("BRANCHCODE");
%>
	   <td><font color=black face=arial size=2> 
		<STRONG>Name:&nbsp;</STRONG></font><%=mSName%>[<%=mEnrollment%>]&nbsp;&nbsp;
	   </td>	
	   <td><font color=black face=arial size=2>     <STRONG>&nbsp;&nbsp;Course/Branch:&nbsp;</STRONG></font> <%=mProg%>/<%=mBranch%>&nbsp;&nbsp; 
	   </td>
	   <td><font color=black face=arial size=2>                         <STRONG>&nbsp;&nbsp;&nbsp;&nbsp;Present Semester&nbsp;:&nbsp; </STRONG></font><%=mSem%>
	   </td>
      </tr>
<%
			}
		}
%>
	</table>
<%

		 qry1="Select count(*) count from SLDRCRADVICEDETAIL ";
		 qry1=qry1+" Where COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mINSTITUTECODE+"' And SLTYPE='"+mType+"' and SLCODE ='"+mSID+"'";

			rs=db.getRowset(qry1);
			if(rs.next())
			{
				String cnt=rs.getString(1);
				count=Integer.parseInt(cnt);
			}
			if(count<1)
			{
				out.print(" <center><b><font size=4 face='Arial' color='Red'>DEBIT/CREDIT ADVICE Not Found.</font>");

			}
			else
			{
			qry2="select to_char(a.ADVICEDATE,'dd/mm/yyyy hh:mi:ss') ADVICEDATE, nvl(a.AMOUNT,0) AMOUNT,";
			qry2=qry2+" decode(a.ADVICETYPE,'D','Debit','Credit')  ADVICETYPE, a.VOUCHERCODE, a.VOUCHERNO, to_char(a.VOUCHERDATE,'dd/mm/yyyy hh:mi:ss') VOUCHERDATE, a.SLNO, decode(a.TRANSACTIONTYPE,'D','Debit','Credit') TRANSACTIONTYPE from SLDRCRADVICEDETAIL a, SLDRCRADVICE b";
			qry2=qry2+" Where  a.ADVICEDATE = b.ADVICEDATE and a.COMPANYCODE='"+mComp+"' And a.INSTITUTECODE='"+mINSTITUTECODE+"' And a.SLTYPE='"+mType+"' and a.SLCODE ='"+mSID+"'";

%>
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	<thead>
	<tr bgcolor="#ff8c00">
	 <td align=center Title="Click on Advice Date to sort"><b><font    color="White">Advice Date</font></b></td>
	 <td align=center Title="Click on Advice Type to Sort"><b><font color="White">Advice Type </font></b></td> 
	 <td align=center Title="Click on Amount to Sort"><b><font color="White">Amount</font></b></td> 
	 <td align=center Title="Click on Location to Sort"><b><font color="White">Voucher Date</font></b></td>
	 <td align=center Title="Click on Reason to Sort"><b><font  color="White">Voucher Code </font></b></td>
	 <td align=center Title="Click on Status to Sort"><b><font  color="White">Voucher No. </font></b></td> 
	 <td align=center Title="Click on Location to Sort"><b><font color="White">Transaction Type</font></b></td>
	</tr>
	</thead>
	<tbody>
<%
			  rs=db.getRowset(qry2);
			
			  while(rs.next())
			  {
%>				
				<tr>
				 <td class="tablecell"> &nbsp;<%=rs.getString("ADVICEDATE")%></td>
				 <td class="tablecell"> &nbsp;<%=rs.getString("ADVICETYPE")%></td>
				 <td class="tablecell"> &nbsp;<%=rs.getString("AMOUNT")%></td>
				 <td class="tablecell"> &nbsp;<%=rs.getString("VOUCHERDATE")%></td>
				 <td class="tablecell"> &nbsp;<%=rs.getString("VOUCHERCODE")%></td>
				 <td class="tablecell"> &nbsp;<%=rs.getString("VOUCHERNO")%></td>
				 <td class="tablecell"> &nbsp;<%=rs.getString("TRANSACTIONTYPE")%></td>
				</tr>	
<%
			  }
%>
	</tbody>
	</table>
	</form>

	<table width="100%">
	<tr>
		<FORM METHOD=POST ACTION="DetailStudEmpDrCrAdvice.jsp">
		<input type="hidden" Name="MemberName" value="<%=mName%>">
		<input id="hidden" name="MemberCode" type=hidden value="<%=mDMemberCode%>">
		<input id="hidden" name="ProgramCode" type=hidden value="<%=mProg%>">
		<input id="hidden" name="BranchCode" type=hidden value="<%=mBranch%>">
		<input id="hidden" name="ProgramCode" type=hidden value="<%=mDesignation%>">
		<input id="hidden" name="BranchCode" type=hidden value="<%=mDepartment%>">
		<input type="hidden" Name="CurrentSem" value="<%=mSemPlusOne%>">
		</FORM>
	</tr>
	</table>

	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
	</script>

<%
			}
		}//3
		else
		{

		//-----------------------------------------------------
		//--------------- Enable Security Links ---------------  
		//-----------------------------------------------------
		
		// closing of Webkiosk Showlink if
	   
%>
		<br>
		<font color=red>
		<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
		<P>	This page is not authorized/available to you.
		<br>For assistance, contact your network support team. 
		</font>	<br>	<br>	<br>	<br> 
<%
		}
	}//2
	else
	{
		out.print("<br><img src='../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}    
}//1
catch(Exception e)
{
	//out.println(e.getMessage());
}
%>
</body>
</html>