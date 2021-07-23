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

String msm="",msm1="",msm2="",msmv="",mSmv="",sql="";
String MonthName[]={"January","Febuary","March","April","May","June","July","August","September","October","November","December"};
int i=0,j=0;
String mComp="";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mLeaveCode="",mFromDate="",mToDate="", qry="";
DBHandler db=new DBHandler(); 
ResultSet rs=null,rst=null;

if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();


if(session.getAttribute("CompanyPersonal")!=null)
{
	mComp=session.getAttribute("CompanyPersonal").toString().trim();
}


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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";

if(session.getAttribute("MemberName")==null)
	mEmployeeName=session.getAttribute("MemberName").toString().trim();
else
	mEmployeeName=session.getAttribute("MemberName").toString().trim();

%>
<Html>
<head>
<title>Payslip (Salary)</title> 
</head>
<body  topmargin=0 rightmargin=0 leftmargin=0 bottommargin=0 bgColor=#fce9c5>
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
			%>
			<center>
			<p align=center><FONT face="arial" size=3 color=navy><u>Employee Name: <%=mEmployeeName%></u></font> 
			<center><br>
			&nbsp;&nbsp;&nbsp;<HR><HR align=center color=black noshade scrollleft="10" style="BACKGROUND-POSITION-X: 10px; HEIGHT: 2px; VERTICAL-ALIGN: middle; WIDTH: 650px">
			<br><br><br>
			<p valign="top">
			<form method="post" action="PaySlipHistory.jsp" id=form1 name=form1>
			<FONT face="Arial" size=3><B>Salary/Pay Slip for the Month-Year<B></font>  
			<%
			ResultSet Rst;
			sql="Select distinct YearMonth from Salary where CompanyCode='" + mComp + "' and EmployeeID='" + mDMemberID + "' order by YearMonth DESC";
			//out.print(sql);
			%>
			<select name=SalaryMonth id=SalaryMonth tabindex="0">
			<%
			rst=db.getRowset(sql);
			while(rst.next())
			{
				msmv=rst.getString(1);
				out.print(msmv);
				msm1=(msmv.substring(4,6));
				msm2=(msmv.substring(0,4));
				if(msm1.equals("01"))
					msm1="January";
				else if(msm1.equals("02"))
					msm1="February";
				else if(msm1.equals("03"))
					msm1="March";
				else if(msm1.equals("04"))
					msm1="April";
				else if(msm1.equals("05"))
					msm1="May";
				else if(msm1.equals("06"))
					msm1="June";
				else if(msm1.equals("07"))
					msm1="July";
				else if(msm1.equals("08"))
					msm1="August";
				else if(msm1.equals("09"))
					msm1="September";
				else if(msm1.equals("10"))
					msm1="October";
				else if(msm1.equals("11"))
					msm1="November";
				else if(msm1.equals("12"))
					msm1="December";

				msm=msm1+" "+msm2;
				//msm=MonthName[Integer.parseInt(msmv.substring(5,6))]+" "+msmv.substring(0,4);		
				if(mSmv.equals(""))
				{
					mSmv=msmv;
					%>
					<OPTION selected Value ='<%=msmv%>'><font name="Arial" ><%=msm%></font></option>
					<%
				}
				else
				{
					%>
					<OPTION Value ='<%=msmv%>'><font name="Arial" ><%=msm%></font></option>
					<%
				}
			}
			%>
			</select>
			<br><br>
			<INPUT id=submit1 type="submit" style="font-size: x-small;font-family: Arial; height: 25; width: 135" value="Show Salary/Pay Slip" tabindex=1 valign="top">
			</form>
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
<br>

</body>
</Html>