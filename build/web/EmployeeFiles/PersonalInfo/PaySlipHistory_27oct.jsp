<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<% 
/*
	' **********************************************************************************************************
	' * File Name:	SalaryDetails.jsp		[For Employee]						           *
	' * Author:		Ashok Kumar Singh 							           *
	' * Date:		1st Feb 2008								   *
	' * Version:	2.0								   *	
	' **********************************************************************************************************	
*/
String msmv="",WPay ="";
int i=0,j=0;
int mChk=0;
String mComp="";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="",mCurrDate="";
String mDepartment1="";
String mLeaveCode="",mFromDate="",mToDate="";
String sql="",qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
DBHandler db=new DBHandler(); 
ResultSet rs=null,Ern=null,Ded=null;
String MonthName[]={" ","January","Febuary","March","April","May","June","July","August","September","October","November","December"};
double ErnTot=0,mPresent=0 ;

rs=db.getRowset(qry);
ResultSet NetPay =null;
String myDate="";

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


if(mComp.equals("J128"))
{
	mComp=session.getAttribute("CompanyPersonal").toString().trim();
}

if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

if (request.getParameter("SalaryMonth")==null)
{
	myDate="";
}
else
{
	myDate=request.getParameter("SalaryMonth").toString().trim();
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


if (session.getAttribute("InstPersonal")!=null)
{
	mInst=session.getAttribute("InstPersonal").toString().trim();
}


%>
<html>
<head>
<style fprolloverstyle>A:hover {color: #FF0000; font-size: 14pt; font-weight: bold}
</style> 
<title>Payslip of Employee</title>
</head>
<body style="Font: Verdana" topmargin=0 rightmargin=0 leftmargin=0 bottommargin=0 bgColor=#fce9c5 bgProperties=fixed>



<style type="text/css">
				@media print 
				{
				input#btnPrint 
				{
					display: none;
				}
				}
				</style>

<center>
        <input type="button" name='submit'  id="btnPrint"  onClick='window.print()' value='Click To Print'></td>
</center>

<br>   
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
		qry="Select WEBKIOSK.ShowLink('161','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
	 
String EDID="";
double NPay;
double DedTot=0, EDAmt=0;
double BasicPBL=0, Tot1=0, BasicPBLArrear=0,Present=0 ,Paid=0 , Lwp=0,BASICPBLRECOVERY=0;
double Absent=0, Weekly=0,Holiday=0,  EdAmt=0, Tot2=0;
double EDArrAmt=0, EdTot=0;
double AdvanceRecovery=0,PFLoan=0; 
double PFLoanRecovery=0, RecNetPay=0,ArrearAmount=0;    	    
String mInstNm="",mInstAdd="",PF="",Bank="",dept="",desig="";

sql = " Select INSTITUTENAME, ADDRESS1||' '||nvl(ADDRESS2,' ')||' '||nvl(ADDRESS3,' ') ADDRESS from InstituteMaster where InstituteCode='" + mInst + "'";
NetPay = db.getRowset(sql);
if (NetPay.next())
{
	mInstNm=NetPay.getString("INSTITUTENAME");
	mInstAdd=NetPay.getString("ADDRESS");
}
else
{
	mInstNm="";
	mInstAdd="";
}
 
sql="select PFNUMBER, BANKACCOUNTNO From EMPLOYEEDETAIL where EMPLOYEEID='" + mDMemberID +"'";
NetPay = db.getRowset(sql);

if(NetPay.next())
{
 PF=NetPay.getString("PFNUMBER");
 Bank=NetPay.getString("BANKACCOUNTNO");
}

sql="select DEPARTMENT From DEPARTMENTMASTER where departmentCode =(select departmentCode from employeemaster where EMPLOYEEID='"+mDMemberID+"')";
NetPay = db.getRowset(sql);

if(NetPay.next())
  {
	dept=NetPay.getString("DEPARTMENT");	
  }

sql="select DESIGNATION From DESIGNATIONMASTER where DESIGNATIONCODE =(select DESIGNATIONCODE from employeemaster where EMPLOYEEID='"+mDMemberID+"')";
NetPay = db.getRowset(sql);

if (NetPay.next())
    desig=NetPay.getString("DESIGNATION");	

int my=0,mm=0,maxday=0;
 	 

if(!myDate.equals(""))
{	
	mm=Integer.parseInt(myDate.substring(4,6));
	my=Integer.parseInt(myDate.substring(0,4));
	
	if (mm==4 || mm==6 || mm==9 || mm==11)
		maxday=30;
	else if (mm==1 || mm==3 || mm==5 || mm==7 || mm==8 || mm==10 || mm==12)
		maxday=31;
	else if (mm==2 && ( my % 4==0 || my%400==0 ))
		maxday=29;
	else
		maxday=28;

}
	
  sql = "Select nvl(BasicPbl,0) BasicPbl ,nvl(BasicPblArrear,0) BasicPblArrear, nvl(PresentDays,0) PresentDays, nvl(PaidLeave,0) PaidLeave, nvl(LWPDays,0) LWPDays, nvl(AbsentDays,0) AbsentDays , nvl(WeeklyOffDays,0) WeeklyOffDays, nvl(HoliDayDays,0) HoliDayDays  from Salary where companyCode='" +mComp+ "' and EmployeeId ='" + mDMemberID+ "' and YearMonth = '" + myDate + "'";   
//out.print(sql);
  Ern = db.getRowset(sql);
  if(Ern.next())
	{
        BasicPBL=Ern.getDouble("BasicPBL");         
        BasicPBLArrear= Ern.getDouble("BasicPBLArrear");
        Tot1= BasicPBL + BasicPBLArrear;
        ErnTot = ErnTot + Tot1;      
        Paid = Ern.getDouble("PaidLeave");
        Lwp = Ern.getDouble("LWPDays");
        Absent = Ern.getDouble("AbsentDays");
        Weekly = Ern.getDouble("WeeklyOffDays");
        Holiday = Ern.getDouble("HolidayDays");
	  mPresent = maxday-(Paid +Lwp +Absent) ;
	  Present = Ern.getDouble("PresentDays");
       } 
    else
      {
	  Present = 0;
        Paid = 0;
        Lwp = 0;
        Absent = 0;
        Weekly = 0;
        Holiday = 0;    
	  mPresent=0; 
	}
    sql = "Select  Nvl(AdvanceRecovery,0) AdvanceRecovery , nvl(PFLoanRecovery,0) PFLoanRecovery ,nvl(BASICPBLRECOVERY,0) BASICPBLRECOVERY from Salary where CompanyCode='" + mComp +  "' and EmployeeId ='" + mDMemberID + "' and YearMonth = '" + myDate + "'" ;

    Ded = db.getRowset(sql) ;
    if (Ded.next())
	{
	  AdvanceRecovery = Ded.getDouble("AdvanceRecovery");       	 
	  PFLoanRecovery   =Ded.getDouble("PFLoanRecovery");
	  BASICPBLRECOVERY =Ded.getDouble("BASICPBLRECOVERY");
	}
    else
	{
    	  AdvanceRecovery = 0;
	  PFLoanRecovery   = 0;
	  BASICPBLRECOVERY = 0;
	}
 %>  
<TABLE  width="100%" border=1 align=left cellpadding=0 cellspacing=0>
<tr><td  Rowspan=4><IMG height= 100 src="..\..\Images\logo-jiit.gif" width=100></td>
    <td colspan=5 align=middle nowrap><font name="Verdana" Size=3><b><%=mInstNm%></b></font><br><font name="Verdana" Size=2><%=mInstAdd%></b></font></td>
</tr>
<tr>
    <td colspan=5 align=middle><font name="Verdana" Size=3><b>Payslip for the Month <%=MonthName[Integer.parseInt(myDate.substring(4,6))]%>-<%=myDate.substring(0,4)%></b> <br>&nbsp;</B> </FONT></td>
</tr>
<tr>
	<td align=middle><font name="Verdana" Size=2><b>Total Working Days</b></font></td>
	<td align=middle><font name="Verdana" Size=2><b>Days Present</b></font></td>
	<td align=middle><font name="Verdana" Size=2><b>Paid Leave</b></font></td>
	<td  align=middle><font name="Verdana" Size=2><b>LWP</b></td>
	<td align=middle><font name="Verdana" Size=2><b>Total days Payable</b></font></td>
<tr>
<td align=middle><font name="Verdana" Size=2><%=maxday%></font></td>
<td  align=middle><font name="Verdana" Size=2><%=mPresent%></font></td>
<td align=middle><font name="Verdana" Size=2><%=Paid%></font></td>
<td  align=middle><font name="Verdana" Size=2><%=Lwp %></font></td>
<td align=middle><font name="Verdana" Size=2><%=Present%></font></td>
</tr>
<tr>
<td align=middle><font name="Verdana" Size=2><b>Employee Code:</b></font></td>
<td align=middle><font name="Verdana" Size=2><%=mDMemberCode%></font></td>
<td><font name="Verdana" Size=2><font name="Verdana" Size=2><b>PF No.:</b></font></td>
<td align=middle><font name="Verdana" Size=2><%=PF%></font></td>
<td nowrap><font name="Verdana" Size=2 ><b>Bank A/c:</b></td>
<td align=middle ><font name="Verdana" Size=2><%=Bank%></font></td>
</tr>
<tr>
<td nowrap align=middle><font name="Verdana" Size=2><b>Employee Name:</b></font></td>
<td align=middle nowrap><font name="Verdana" Size=2><%=mMemberName%></font> </td>
<td nowrap><font name="Verdana" Size=2><font name="Verdana" Size=2><b>Designation:</b></font></td>
<td align=middle><font name="Verdana" Size=2><%=desig%></font></td>
<td nowrap><font name="Verdana" Size=2><b>Deptt.:</b></font></td>
<td align=middle><font name="Verdana" Size=2><%=dept%></font></td>
</tr>
<tr>
<td colspan=3 align=middle width='100%'> 
<table width="100%" rules="group" BORDER=1 CELLPADDING=0 CELLSPACING=0>
<tr><td colspan=5 align=center><font name="Verdana" Size=2 ><b>Earnings</b></font>
</td>
</tr>
<tr>
<td align=middle>&nbsp;</td>
<td align=middle><font name="Verdana" Size=2><b>Regular</b></font></td>
<td align=middle><font name="Verdana" Size=2><b>Arrear</b></font></td>
<td align=middle><font name="Verdana" Size=2><b>Total</b></font></td>
<td align=middle><font name="Verdana" Size=2><b>Total Earnings</b></font></td>
</tr>

<tr>
<td>Basic</td>
<td  align=right noWrap><font name="Verdana" Size=2><%=BasicPBL%></font></td>
<td  align=right noWrap><font name="Verdana" Size=2><%=BasicPBLArrear%></font></td>
<td  align=right noWrap><font name="Verdana" Size=2><%=Tot1%></font></td>   
<td  align=right noWrap>&nbsp;</td> 
</tr>

<%
int mFlag=0;
double EDTotal=0,mNoMoveEr=0, Count_DED=0, Count_ERN=0;
double ArrAmt =0;

sql = " Select nvl(A.EDID,'UNK') EDID, nvl(B.EDDESCRIPTION,' ') EDDES, nvl(A.EDAmount,0)EDAmount , nvl(A.ArrearAmount,0) ArrearAmount,B.SEQID SEQID from PayableSalary A, EDMaster B where A.COMPANYcODE= B.COMPANYcODE And A.EDID= B.EDID And A.CompanyCode='"  + mComp + "' and EmployeeId ='" +mDMemberID + "' and YearMonth = '" + myDate + "' and A.PRFlag = 'R'";
if (AdvanceRecovery>0)
  sql =sql+ " UNION select 'AdvRec' EDID, 'AdvRec' EDDES, nvl(" + AdvanceRecovery + ",0) EDAmount,0 ArrearAmount,-1 SEQID from dual ";
if (PFLoanRecovery>0)
	sql =sql+ " UNION select 'PFLoan' EDID, 'PFLoan' EDDES, nvl(" + PFLoanRecovery + ",0) EDAmount,0 ArrearAmount,-1 SEQID  from dual ";
sql=sql+ " order by seqid"; 
//out.print(sql);

Ded = db.getRowset(sql);
double mDedCount=0;
while (Ded.next())
  mDedCount=mDedCount+1;

Ded = db.getRowset(sql);
sql = "Select nvl(A.EDID,'UNK') EDID, nvl(B.EDDESCRIPTION,' ') EDDES , nvl(A.EDAmount,0) EDAmount , nvl(A.ArrearAmount,0) ArrearAmount,B.SEQID  from PayableSalary A, EDMaster B where A.COMPANYcODE= B.COMPANYcODE And A.EDID= B.EDID And A.COMPANYcODE='" + mComp + "' AND EmployeeId ='" + mDMemberID+ "'" + " and YearMonth = '" + myDate + "' and A.PRFlag = 'P' order by B.seqid";
Ern = db.getRowset(sql);

sql = " Select nvl(Payroll.NetPay('" + mComp + "','" + mDMemberID+ "','" + myDate + "'),0) Pay from dual";
NetPay = db.getRowset(sql);

if(NetPay.next())
   NPay = NetPay.getDouble("Pay");
else
  NPay=0;

sql = "Select nvl(Common.ToWord(" + NPay + "),0) Pay from dual";
NetPay = db.getRowset(sql);
if(NetPay.next())
	WPay = NetPay.getString("Pay");


if (mFlag==1 && BASICPBLRECOVERY >0)
	{
        DedTot = DedTot + BASICPBLRECOVERY;
        mChk=1;
         %>        
		<TR>
		<td><FONT face=Arial>Basic Rec</FONT></td>
		<td  align=right noWrap><font name="Verdana" Size=2><%=BASICPBLRECOVERY%></font></td>
		<td  align=right noWrap><font name="Verdana" Size=2><%=0%></font></td>
		<td  align=right noWrap><font name="Verdana" Size=2><%=BASICPBLRECOVERY%></font></td>   					
		<td>&nbsp;</td>
		</TR>
		<%
	}

while(Ern.next())
	{	
	mChk=1;
	EDID = Ern.getString("EDDES");
	EdAmt  = Ern.getDouble("EDAmount");
	ArrAmt =Ern.getDouble("ArrearAmount");
	Tot2 =  EdAmt + ArrAmt;
	ErnTot = ErnTot + Tot2;		
	%>						
	<tr><td><%=EDID%></td>
	<td  align=right noWrap><font name="Verdana" Size=2><%=EdAmt%></font></td>
	<td  align=right noWrap><font name="Verdana" Size=2><%=ArrAmt%></font></td>
	<td  align=right noWrap><font name="Verdana" Size=2><%=Tot2%></font></td>
	<td>&nbsp;</td>
	</TR>
	<%
	}
	%>
	<tr>
	<td colspan=5  align=right noWrap><font name="Verdana" Size=2><b>Total: <%=ErnTot%></b></font></td>
	</tr>
</table>
</td>
<td valign=top colspan=3 align=middle width='100%'> 
<table width="100%" rules="group" BORDER=1 CELLPADDING=0 CELLSPACING=0>
<tr><td colspan=5 align=center><font name="Verdana" Size=2 ><b>Deductions</b></font></td></tr> 
<tr>
<td align=middle>&nbsp</td>
<td align=middle><font name="Verdana" Size=2><b>Regular</b></font></td>
<td align=middle><font name="Verdana" Size=2><b>Arrear</b></font></td>
<td align=middle><font name="Verdana" Size=2><b>Total</b></font></td>
<td align=middle><font name="Verdana" Size=2><b>Total Deductions</b></font></td>
</tr>
<%
while(Ded.next()) 
	  {
		EDID = Ded.getString("EDDES");
		EDAmt= Ded.getDouble("EDAmount");
		ArrearAmount= Ded.getDouble("ArrearAmount");
		EdTot= EDAmt + ArrearAmount;
		DedTot = DedTot +EdTot;
		
		%>		          
		<tr>	
		<td><%=EDID%></td>
		<td  align=right noWrap><font name="Verdana" Size=2><%=EDAmt%></font></td>
		<td  align=right noWrap><font name="Verdana" Size=2><%=ArrearAmount%> </font></td>
		<td  align=right noWrap><font name="Verdana" Size=2><%=EdTot%></font></td>
		<td>&nbsp;</td>		
		</tr>
		<%
	  }
 %>

  <tr>
   <td  align=right colspan=5   noWrap><font name="Verdana" Size=2><b>Total: <%=DedTot%></b></font></td>
    </tr>
	</table>
</td>
</tr>
<tr><td colspan=10><font name="Verdana" Size=2><B>Net payable: <%=NPay%></B> <font size=2>&nbsp; &nbsp; In Words: <%=WPay%></font></font></td>
</tr>	
</TABLE> 
<%
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
}
else
{
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.gif'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>  
   <%
}
//-----------------------------
}
else
{
	out.print("<br><img src='../../Images/Error1.gif'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
}
%>
</body>
</Html>

