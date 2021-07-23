<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%@ page import="java.util.ArrayList,java.util.Iterator" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT"; 
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="",mDate1="",mCurrDate="";
int mStudent=0,mFaculty=0,mDefault=15,mNoStudent=0;
double mRequiredFaculty=0;
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
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
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Caluclate Required Faculty] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
		qry="Select WEBKIOSK.ShowLink('141','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			// For Log Entry Purpose
			//--------------------------------------
			String mLogEntryMemberID="",mLogEntryMemberType="";
			if (session.getAttribute("LogEntryMemberID")==null ||	session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
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
			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
				<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Caluclate Required Faculty</FONT></u></b></td>
			</tr>
			</table>
			</center>
			<%
			qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
			rsi=db.getRowset(qry);
			while(rsi.next())
			{
				mInst=rsi.getString("IC");
			}
			if(request.getParameter("DeptCode")==null)
				mDepartment="";
			else
				mDepartment=request.getParameter("DeptCode");
			try
			{
				qry="Select count(Studentid)Studentid from STUDENTMASTER where (INSTITUTECODE, ACADEMICYEAR, PROGRAMCODE, branchcode) in (Select INSTITUTECODE, ACADEMICYEAR, PROGRAMCODE, SECTIONBRANCH from BRANCHDEPTTAGGING where DEPARTMENTCODE='"+mDepartment+"')";
				//out.println(qry);
				rs=db.getRowset(qry);
				if(rs.next())
					mStudent=rs.getInt("Studentid");
				//mStudent=10000;
				qry="Select count(EMPLOYEEID)EMPLOYEEID from EMPLOYEEMASTER Where DEPARTMENTCODE='"+mDepartment+"' and nvl(Deactive,' ')<>'Y'";
				//out.println(qry);
				rs=db.getRowset(qry);
				if(rs.next())
					mFaculty=rs.getInt("EMPLOYEEID");				
			}catch(Exception e)
			{
				/*out.println("Exception e:"+e);*/
			}
			%>
			<center>
			<table cellpadding="2" cellspacing="0" border="1" rules="groups">
			<%
			if(request.getParameter("x")==null)
				mDefault=15;
			else if(request.getParameter("noStudent")==null)
					mDefault=15;
			else
			{
			  try
				{
					mDefault=Integer.parseInt(request.getParameter("noStudent"));
				}catch(Exception e)
				{
					out.print("<center><img src='../../../Images/Error1.jpg'> ");
					out.println("<font size=2 face='arial' color=red><b>Please Enter Numeric value</center></b></font>");
				}
			}
			%>
			<tr>
				<td align=center colspan=2><font face="arial" size="2" color=navy><b>Current Strength</b></font></td>
			</tr>			
			<tr>
				<td><font face="arial" size="2"><b>No. of Student :</b></font>&nbsp;<%=mStudent%></td>
				<td>&nbsp;<font face="arial" size="2"><b>No. of Faculty :</font></b>&nbsp;<%=mFaculty%></td>
			</tr>
			<tr>
				<td><font face="arial" size="2"><b>No. of Student Per Faculty : </b></td>
				<td align="left">&nbsp;<input type="text" name="noStudent" id="noStudent" Value="<%=mDefault%>" size="4" maxlength="4"></td>
			</tr>
			<tr>
				<td align="center" colspan=4><input style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 80px; HEIGHT: 23px; FONT-VARIANT: normal" type="submit" name="submit" value="Calculate"></td>
			</tr>
			</table>
			</center>
			<input type="hidden" value="<%=mDepartment%>" name="DeptCode">			
			<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("noStudent")==null)
					mNoStudent=0;
				else
					mNoStudent=Integer.parseInt(request.getParameter("noStudent"));				
				if(mNoStudent>0)
				{
					mRequiredFaculty=((double)(mStudent)/mNoStudent)-mFaculty;
					mRequiredFaculty*=100;
					mRequiredFaculty=(double)Math.round(mRequiredFaculty)/100;	
					if(mRequiredFaculty<0)
						mRequiredFaculty=0;
					out.print("<center><font face=arial size=3><b>Required Faculty :</font></b> <font color='navy'><b>"+mRequiredFaculty+"</b>	</font></center>");
				}						
				else
				{
					out.print("<center><img src='../../../Images/Error1.jpg'> ");
					out.println("<font size=2 face='arial' color=red><b>Number of Student must be greater than 1</center></b></font>");
				}
			}
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3>	<br><img src='../../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
	//out.print("Catch Block");	
}
%>
</form>
</body>
</html>