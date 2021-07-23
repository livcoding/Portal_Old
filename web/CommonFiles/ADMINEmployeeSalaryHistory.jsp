<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mtext="",mCurrDate="";
String mDepartment1="",mYearMonth="";
String mYMDate="";
String mHead="", mEmpType="", mEmpID="";
double mTotal=0,mEarningTotal=0,mPay=0;
double mDeductionTotal=0,mdTotal=0;
double mPFLoanRecovery=0,mAdvanceRecovey=0,mBasicActRecovery=0;
double mPresentPayable=0, mPresentDays=0,mWeeklyOfDays=0,mHolidays=0;
double mPaidLeave=0,mLWPDays=0,mAbsentDays=0;

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
if (session.getAttribute("CompanyCode")==null)
	mComp="UNIV";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();
if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();
if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();
if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
if (session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

if (request.getParameter("mType")==null)
	mEmpType="";
else
	mEmpType=request.getParameter("mType").toString().trim();
if (request.getParameter("SID")==null)
	mEmpID="";
else
	mEmpID=request.getParameter("SID").toString().trim();

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Employee Salary History ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
<script language=javascript>
<!--
function RefreshContents()
{ 	
	document.frm.x.value='ddd';
	document.frm.submit();
}
//-->
if(window.history.forward(1) != null)
window.history.forward(1);	
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin="0" topmargin="0">
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	
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
		qry="Select WEBKIOSK.ShowLink('215','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			%>
			<form name="frm"  method="post">
			<input id="x" name="x" type="hidden">
			<%
			try
			{
				qry="select distinct nvl(A.EMPLOYEENAME,' ')EMPLOYEENAME,B.DEPARTMENT DEPARTMENT," +
                        "C.DESIGNATION DESIGNATION from EMPLOYEEMASTER A,DEPARTMENTMASTER B," +
                        " DESIGNATIONMASTER C where A.employeeid='"+mEmpID+"'" +
                        " and A.DEPARTMENTCODE=B.DEPARTMENTCODE and A.DESIGNATIONCODE=C.DESIGNATIONCODE " +
                        "and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' and nvl(C.DEACTIVE,'N')='N' ";
				//out.println(qry);
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mEmployeeName=rs.getString("EMPLOYEENAME");					
					mDepartment1=rs.getString("DEPARTMENT");
					mDesignation1=rs.getString("DESIGNATION");
				}
			}
			catch(Exception e)
			{
			}
			%>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			  <tr>
			   <td align=left nowrap><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial">Employee Salary History</FONT></td>
			   <td align=right nowrap><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial">Login User :&nbsp; &nbsp;<%=mMemberName%>[Emp. Code: <%=mDMemberCode%>]</font></td>
			  </tr>
			</table>
			<center>			
			<table align=center cellpadding="0" cellspacing="0" border="0" rules="groups" width=100%>
			<tr>
				<td colspan=8 align=center><font color="#00008b" face=times new roman size=2><hr><b>&nbsp;<%=mEmployeeName%> </b></font>
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Designation </font> </B>
				<font color="#00008b" face=times new roman><b> &nbsp;<%=GlobalFunctions.toTtitleCase(mDesignation1)%> </b></font>
				<b><FONT face=Arial size=2>&nbsp; Department </font></B><font color="#00008b" face=times new roman><b>&nbsp;&nbsp;<%=GlobalFunctions.toTtitleCase(mDepartment1)%></b></font><hr>
				</td>
			</tr>							
			</table>
			</center>
			<center>
			<table cellpadding="3" cellspacing="0" border=1 rules="groups">
			<tr>
			<td><font face="arial" size=2><b> Salary for Month-Year </b></font>
			<%
			qry="select to_char(to_Date(YEARMONTH,'yyyymm'),'MON-YYYY')YEARMONTH, to_char(to_Date(YEARMONTH,'yyyymm'),'yyyymm')YEARMONTH1 ";
			qry=qry+" From salary where COMPANYCODE in ('UNIV','JPBS') and EMPLOYEEID='"+mEmpID+"' ORDER BY YEARMONTH1 desc ";
			//out.print(qry);
			rs=db.getRowset(qry);
			%>
			&nbsp;&nbsp;<select name="MonthYear" id="MonthYear">
			<%
			if(request.getParameter("x")==null)
			{
				while(rs.next())
				{
					if(mYearMonth.equals(""))
					{
						mYearMonth=rs.getString("YEARMONTH1");
					}
					%>
					<option value=<%=rs.getString("YEARMONTH1")%>><%=rs.getString("YEARMONTH")%></option>	
					<%
				}						
			}
			else
			{						
				while(rs.next())
				{
					if(request.getParameter("MonthYear").equals(rs.getString("YEARMONTH1")))
					{
						%>
						<option value=<%=rs.getString("YEARMONTH1")%> selected><%=rs.getString("YEARMONTH")%></option>	
						<%
					}
					else
					{
						%>
						<option value=<%=rs.getString("YEARMONTH1")%>><%=rs.getString("YEARMONTH")%></option>	
						<%
					}
				}
			}
			%>
			</select>
			</TD>			
			<TD align="center"><input type="submit" name="show" value="Show" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 60px; HEIGHT: 20px; FONT-VARIANT: normal; cursor:hand; background-color:transparent; border-width:1; border-color:black;"></TD>
			</TR>
			</table>
			</center>
			<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("MonthYear")==null)
					mYearMonth="";
				else
					mYearMonth=request.getParameter("MonthYear");
			}
			try
			{
				qry="select nvl(PFLOANRECOVERY,0)PFLOANRECOVERY,nvl(ADVANCERECOVERY,0)ADVANCERECOVERY,nvl(BASICACTRECOVERY,0)BASICACTRECOVERY,nvl(PRESENTDAYS,0)PRESENTDAYS,nvl(WEEKLYOFFDAYS,0)WEEKLYOFFDAYS,nvl(HOLIDAYDAYS,0)HOLIDAYDAYS,nvl(PAIDLEAVE,0)PAIDLEAVE,nvl(LWPDAYS,0)LWPDAYS,nvl(ABSENTDAYS,0)ABSENTDAYS from SALARY where  COMPANYCODE in ('UNIV','JPBS')  and EMPLOYEEID='"+mEmpID+"' and YEARMONTH=(select to_char(to_date('"+mYearMonth+"','YYYYMM'),'yyyymm') from dual)";
				//out.print(qry);
				rs=db.getRowset(qry);
				if(rs.next())
				{
					//out.print("aaa"+rs.getString("PRESENTDAYS"));
					mPresentPayable=rs.getDouble("PRESENTDAYS");
					mWeeklyOfDays=rs.getDouble("WEEKLYOFFDAYS");
					mHolidays=rs.getDouble("HOLIDAYDAYS");
					mPaidLeave=rs.getDouble("PAIDLEAVE");
					mLWPDays=rs.getDouble("LWPDAYS");
					mAbsentDays=rs.getDouble("ABSENTDAYS");						
					mPFLoanRecovery=rs.getDouble("PFLOANRECOVERY");
					mAdvanceRecovey=rs.getDouble("ADVANCERECOVERY");
					mBasicActRecovery=rs.getDouble("BASICACTRECOVERY");			
				}
				mPresentDays=mPresentPayable-(mWeeklyOfDays+mHolidays+mPaidLeave+mLWPDays+mAbsentDays);
			}
			catch(Exception e)
			{
				/*out.print("Exception e"+e);*/
			}
			%>	
			<center><br>
			<table border=5 align=center style="FONT-SIZE: smaller; WIDTH: 588px; FONT-FAMILY: cursive; HEIGHT: 15px; BACKGROUND-COLOR: gainsboro" borderColor=lightslategray cellSpacing=0 cellPadding=2 bgColor=lightgrey>
			<tr>
				<td align="center"><font face="arial" size=2><b>Days Payable</b></font></td>
				<td align="center">&nbsp;<%=mPresentPayable%></td>
				<td bgcolor="#fce9c5"></td>
				<td align="center"><font face="arial" size=2><b>Days Present</b></font></td>
				<td align="center">&nbsp;<%=mPresentDays%></td>
				<td bgcolor="#fce9c5"></td>
				<td align="center"><font face="arial" size=2><b>Paid Leave</b></font></td>
				<td align="center">&nbsp;<%=mPaidLeave%></td>
				<td bgcolor="#fce9c5"></td>
				<td align="center"><font face="arial" size=2><b>LWP Days</b></font></td>
				<td align="center">&nbsp;<%=mLWPDays%></td>
				<td bgcolor="#fce9c5"></td>
				<td align="center"><font face="arial" size=2><b>Absent Days</b></font></td>
				<td align="center">&nbsp;<%=mAbsentDays%></td>
				<td bgcolor="#fce9c5"></td>
				<td align="center"><font face="arial" size=2><b>Weekly Days</b></font></td>
				<td align="center">&nbsp;<%=mWeeklyOfDays%></td>
				<td bgcolor="#fce9c5"></td>
				<td align="center"><font face="arial" size=2><b>Holidays</b></font></td>
				<td align="center">&nbsp;<%=mHolidays%></td>
			</tr>
			</table>
			</center>
			<FONT size=2 face=Arial color=maroon>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<U>Earnings</U></FONT>   
			<table  class="sort-table" id="table-1" align="center" border=1 cellSpacing=0 cellPadding=0 width="70%">
			<tr align=middle bgcolor="#ff8c00">
				<td><P><STRONG><FONT color=white face=Arial>Head</FONT></STRONG></P></td>
				<td><STRONG><FONT color=white face=Arial>Regular Amount </FONT></STRONG> </td>
				<td><STRONG><FONT color=white face=Arial>Arrear Amount </FONT></STRONG> </td>
				<td><FONT color=white face=Arial><STRONG>Total</STRONG></FONT></td>
			</tr>
			<%
			qry="SELECT NVL(BASICPBL,0)CURRBASIC, NVL(BASICPBLARREAR,0)ARRBASIC FROM SALARY WHERE COMPANYCODE in ('UNIV','JPBS') AND EMPLOYEEID='"+mEmpID+"' AND YEARMONTH=(select to_char(to_date('"+mYearMonth+"','YYYYMM'),'yyyymm') from dual)";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				%>
				<tr>
					<td width="15%">&nbsp;&nbsp;Basic</td>
					<td noWrap align="center"><%=rs.getDouble("CURRBASIC")%></td>
					<td noWrap align="center"><%=rs.getDouble("ARRBASIC")%></td>
					<%
						mTotal=rs.getDouble("CURRBASIC")+rs.getDouble("ARRBASIC");
					%>
					<td noWrap align="center"><%=mTotal%></td>   
				</tr>
				<%	
				mEarningTotal+=mTotal;
			}
			qry="Select nvl(e.EDDESCRIPTION,0) EDID, nvl(S.EDAMOUNT,0) EDAMOUNT, nvl(S.ARREARAMOUNT,0) ARREARAMOUNT from PayableSalary S, EDMASTER E ";
			qry=qry+" where S.COMPANYCODE=E.COMPANYCODE AND S.EDID=E.EDID AND S.COMPANYCODE IN ('UNIV','JPBS')  and S.EMPLOYEEID='"+mEmpID+"'";
			qry=qry+" and S.YEARMONTH=(select to_char(to_date('"+mYearMonth+"','YYYYMM'),'yyyymm') from dual) and S.PRFLAG='P' and E.TYPE='E'";
			//out.print(qry);
			rs=db.getRowset(qry);
			while(rs.next())
			{
				mTotal=0;
				mTotal=mTotal+(rs.getDouble("EDAMOUNT")+rs.getDouble("ARREARAMOUNT"));
				mEarningTotal+=mTotal;
				%>
				<tr>
					<td width="15%">&nbsp;&nbsp;<%=rs.getString("EDID")%></td>
					<td noWrap align="center"><%=rs.getDouble("EDAMOUNT")%></td>
					<td noWrap align="center"><%=rs.getDouble("ARREARAMOUNT")%></td>
					<td noWrap align="center"><%=mTotal%></td>   
				</tr>
				<%
			}					
			%>
			</table>
			<FONT size=2 face=Arial color=maroon>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<U>Deduction</U></font>
			<table  class="sort-table" id="table-1" align=center cellSpacing=0 cellPadding=0 width="70%" border=1>
			<tr bgcolor="#ff8c00" align="center">    
				<td><STRONG><FONT color=white face=Arial>Head</FONT></STRONG></td>
				<td><STRONG><FONT color=white face=Arial>Regular Amount</FONT></STRONG></td>
				<td><STRONG><FONT color=white face=Arial>Arrear Amount</FONT></STRONG> </td>
				<td><FONT color=white face=Arial><STRONG>Total</STRONG></FONT></td>
			</tr>  
			<%
			qry="Select nvl(e.EDDESCRIPTION,0) EDID, nvl(S.EDAMOUNT,0) EDAMOUNT, nvl(S.ARREARAMOUNT,0) ARREARAMOUNT from PayableSalary S, EDMASTER E ";
			qry=qry+" where S.COMPANYCODE=E.COMPANYCODE AND S.EDID=E.EDID AND S.COMPANYCODE IN ('UNIV','JPBS') and S.EMPLOYEEID='"+mEmpID+"'";
			qry=qry+" and S.YEARMONTH=(select to_char(to_date('"+mYearMonth+"','YYYYMM'),'yyyymm') from dual) and S.PRFLAG='R' and E.TYPE='D'";
			//out.println(qry);
			rs=db.getRowset(qry);
			while(rs.next())
			{
				mdTotal=0;
				mdTotal=rs.getDouble("EDAMOUNT")+rs.getDouble("ARREARAMOUNT");
				mDeductionTotal+=mdTotal;
				%>
				<tr>
					<td width="15%">&nbsp;&nbsp;<%=rs.getString("EDID")%></td>
					<td noWrap align="center"><%=rs.getDouble("EDAMOUNT")%></td>
					<td noWrap align="center"><%=rs.getDouble("ARREARAMOUNT")%></td>
					<td noWrap align="center"><%=mdTotal%></td>   
				</tr>
				<%					
			}		
			if(mBasicActRecovery>0)
			{
				mDeductionTotal+=mBasicActRecovery;
				%>
				<tr>
					<td width="15%">&nbsp;&nbsp;<FONT face=Arial>Basic Rec</FONT></td>
					<td noWrap align="center"><%=mBasicActRecovery%></td>
					<td noWrap align="center"><%=0.0%></td>
					<td noWrap align="center"><%=mBasicActRecovery%></td>   
				</tr>
				<%
			}
			if(mAdvanceRecovey>0)
			{
				mDeductionTotal+=mAdvanceRecovey;
				%>
				<tr>
					<td width="15%">&nbsp;&nbsp;<FONT face=Arial>AdvRec</FONT></td>
					<td noWrap align="center"><%=mAdvanceRecovey%></td>
					<td noWrap align="center"><%=0.0%></td>
					<td noWrap align="center"><%=mAdvanceRecovey%></td>   
				</tr>
				<%
			}
			if(mPFLoanRecovery>0)
			{
				mDeductionTotal+=mPFLoanRecovery;
				%>
				<tr>
					<td width="15%">&nbsp;&nbsp;<FONT face=Arial>PFLoan</FONT></td>
					<td noWrap align="center"><%=mPFLoanRecovery%></td>
					<td noWrap align="center"><%=0.0%></td>
					<td noWrap align="center"><%=mPFLoanRecovery%></td>   
				</tr>
				<%
			}
			%>
			</table>
			<%
			try
			{
				qry="select to_char(to_date('"+mYearMonth+"','YYYYMM'),'YYYYMM')YMDate from dual";
				rs=db.getRowset(qry);
				while(rs.next())
				{
					mYMDate=rs.getString("YMDate");
				}
				qry="Select Payroll.NetPay('"+mComp+"','"+mEmpID+"','"+mYMDate+"') Pay from dual";
				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					mPay=rs.getDouble("pay");
				}
			}
			catch(Exception e)
			{
				/*out.print("Exception e:-"+e);*/
			}
			%>
			<hr>
			<center><FONT size=2 face=Arial color=navy><b>
			Total Payable (Rs.) :</b></font>&nbsp;<b><FONT size=2 face=Arial><%=mEarningTotal%></font></b>&nbsp;&nbsp;<FONT size=2 face=Arial color=navy><b> 
			Total Deduction (Rs.) :</b></font>&nbsp;<b><FONT size=2 face=Arial><%=mDeductionTotal%></font></b>&nbsp;&nbsp;<font face="arial" size="2" color="navy"><b> 
			Net Payable (Rs.) :</b></font>&nbsp;<b><FONT size=2 face=Arial><%=mPay%></font></b>&nbsp; 
			</FONT><hr>
			<%
		}
		else
		{
			%>
				<br>
				<font color=red>
				<h3><br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
				<P>	This page is not authorized/available for you.
				<br>For assistance, contact your network support team. 
				</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{	
	/*out.print("Exception e"+e);	*/
}
%>
</form>
</body>
</html>