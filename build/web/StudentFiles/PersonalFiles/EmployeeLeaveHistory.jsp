<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

/*
	' 
*************************************************************************************************
	' *												
	' * File Name		:	StudentLeaveHistory.JSP
	' * Author			:	Vijay Kumar
	' * Date			:	21st May 2008								
	' * Version			:	1.0						
	' * Description		:	Displays Student's Self Leave History.
*************************************************************************************************
*/

String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Leave History ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

 <script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<%

ResultSet rs=null, Qrs=null, rs1=null;
String qry="", Qqry="", qry1="";
String mComp="", mStartDate="", mEndDate="", mLeaveCode="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String mEmpCode="", mEmpName="", mDesignation="", mDepartment="";
String mInst="",mWebEmail="", mColor="";

if(session.getAttribute("CompanyCode")!=null && !session.getAttribute("CompanyCode").equals(""))
	mComp=session.getAttribute("CompanyCode").toString().trim();
else
	mComp=" ";



if(session.getAttribute("CompanyPersonal")!=null)
{
	mComp=session.getAttribute("CompanyPersonal").toString().trim();
}


if(request.getParameter("LeaveCode")==null)
	mLeaveCode="";
else
	mLeaveCode=request.getParameter("LeaveCode");

if(request.getParameter("FromDate")==null)
	mStartDate="";
else
	mStartDate=request.getParameter("FromDate");

if(request.getParameter("ToDate")==null)
	mEndDate="";
else
	mEndDate=request.getParameter("ToDate");

try
{
   OLTEncryption enc=new OLTEncryption();
   if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
   {
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('272','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------



	if (session.getAttribute("WebAdminEmail")==null)
		 mWebEmail="";
	else
		mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();

	
if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}
/*
	qry="Select nvl(a.EMPLOYEECODE,' ') EMPLOYEECODE, nvl(a.EMPLOYEENAME, ' ') EMPLOYEENAME, ";
	qry=qry+" nvl(b.DESIGNATION,' ') DESIGNATION, nvl(c.DEPARTMENT,' ') DEPARTMENT from ";
	qry=qry+" Studentmaster a, DESIGNATIONMASTER b, DEPARTMENTMASTER c Where a.EmployeeID='"+mChkMemID+"'";
	qry=qry+" and a.DESIGNATIONCODE=b.DESIGNATIONCODE and a.DEPARTMENTCODE=c.DEPARTMENTCODE";
	qry=qry+" and nvl(a.DEACTIVE,'N')='N' and nvl(b.DEACTIVE,'N')='N' and nvl(c.DEACTIVE,'N')='N'";
	*/
	qry="SELECT       NVL (a.STUDENTNAME , ' ') STUDENTNAME,       a.ENROLLMENTNO  , c.DEPARTMENT,c.DEPARTMENTCODE       FROM studentmaster a, EMPLOYEECODEIDTAGGING b,DEPARTMENTMASTER c WHERE a.STUDENTID = '"+mChkMemID+"' and a.institutecode='"+mInst+"'  and a.STUDENTID=b.EMPLOYEEID   and a.INSTITUTECODE=b.INSTITUTECODE   AND b.departmentcode = c.departmentcode   AND NVL (a.deactive, 'N') = 'N'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mEmpCode=rs.getString("ENROLLMENTNO");
		mEmpName=rs.getString("STUDENTNAME");
	
		mDepartment=rs.getString("DEPARTMENT");
		%> 
		<CENTER>
		<STRONG><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b><u><FONT SIZE=4>Student Leave History</FONT></u></b></font></STRONG>
		<br><br>
		<table align=center cellpadding="0" cellspacing="0" border="0" rules="groups">
			<tr>
				<td colspan=8 NOWRAP>
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Student Name : </font> </B>
				<font color="#00008b" face=Arial size=2><b>&nbsp;<%=mEmpName%> [<%=mEmpCode%>] </b></font>
				</font>
				<b><FONT face=Arial size=2>&nbsp; Department : </font></B><font color="#00008b" face=Arial><b>&nbsp;&nbsp;<%=GlobalFunctions.toTtitleCase(mDepartment)%></b></font><hr>
				</td>
			</tr>							
		</table>
		</center>
		<%
		qry="Select Distinct LeaveCode LCODE, to_char(STARTDATE,'dd-mm-yyyy') SDATE, nvl(to_char(ENDDATE,'dd-mm-yyyy'),' ')EDATE, Decode(STARTHALFDAY,'B','Pre Lunch','A','Post Lunch',  'O','Half Day','No Half Day')SHDAY, Decode(ENDHALFDAY,'B','Pre Lunch','A','Post Lunch',  'O','Half Day','No Half Day')EHDAY,";
		qry=qry+" nvl(PAID,0)PAID, nvl(WITHOUTPAY,0)LWP, nvl(ABSENT,0)ABSENT, nvl(to_char(trunc(JOININGDATE),'dd-mm-yyyy'),'-') JDATE, Decode(STATUS,'J','Joined','-')JSTATUS , startdate";
		qry=qry+" FROM STUDENTLEAVETRANSACTION where companycode='"+mComp+"'  AND empcategorycode ='STU' ";
		qry=qry+" and STUDENTID='"+mChkMemID+"' and LEAVECODE='"+mLeaveCode+"'";
		qry=qry+" and (STARTDATE between (to_date('"+mStartDate+"','dd-mm-yyyy'))";
		qry=qry+" and (to_date('"+mEndDate+"','dd-mm-yyyy'))";
		qry=qry+" or ENDDATE between (to_date('"+mStartDate+"','dd-mm-yyyy'))";
		qry=qry+" and (to_date('"+mEndDate+"','dd-mm-yyyy')))";
		qry=qry+" ORDER BY to_char(startdate,'yyyymmdd') DESC";
		//out.print(qry);
		rs=db.getRowset(qry);
		%>
		<table align=center width="100%" bottommargin=0 topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b><u><FONT SIZE=4>Availed Leaves</FONT></u></b></font></td></tr>
		</table>
		<table class="sort-table" id="table-1" border=1 cellpadding=0 cellspacing=0 align=center>
		<thead>
		<tr bgcolor="#ff8c00">
		<td align=center rowspan=2 nowrap><font color=white><B>Leave<br>&nbsp; Code</B></font></td>
		<td align=center nowrap colspan=2><font color=white><B>Period</B></font></td>
		<td align=center nowrap colspan=2><font color=white><B>Half Day</B></font></td>
		<td align=center nowrap colspan=3><font color=white><B>Leave Type</B></font></td>						
		<td align=center nowrap colspan=2><font color=white><B>Joining</B></font></td>
		</tr>
		<tr bgcolor="#ff8c00">
		<td align=center nowrap><font color=white><B>Start Date</B></font></td>
		<td align=center nowrap><font color=white><B>End Date</B></font></td>
		<td align=center nowrap><font color=white><B>Start</B></font></td>
		<td align=center nowrap><font color=white><B>End</B></font></td>
		<td align=center nowrap><font color=white><B>Paid</B></font></td>
		<td align=center nowrap><font color=white><B>LWP</B></font></td>
		<td align=center nowrap><font color=white><B>Absent</B></font></td>
		<td align=center nowrap><font color=white><B>Status</B></font></td>						
		<td align=center nowrap><font color=white><B>Date</B></font></td>
		</tr>
		</thead>
		<tbody>
		<%
		int mSno=0;
		while(rs.next())
		{
			mSno++;
			//out.print(mSno);
			%>
			<tr>
			<td align=center nowrap><font color=<%=mColor%>><%=rs.getString("LCODE")%></font></td>
			<td align=center nowrap><font color=<%=mColor%>><%=rs.getString("SDATE")%></font></td>
			<td align=center nowrap><font color=<%=mColor%>><%=rs.getString("EDATE")%></font></td>
			<td align=center nowrap><font color=<%=mColor%>><%=rs.getString("SHDAY")%></font></td>
			<td align=center nowrap><font color=<%=mColor%>><%=rs.getString("EHDAY")%></font></td>
			<td align=right nowrap><font color=<%=mColor%>><%=rs.getDouble("PAID")%></font></td>
			<td align=right nowrap><font color=<%=mColor%>><%=rs.getDouble("LWP")%></font></td>
			<td align=right nowrap><font color=<%=mColor%>><%=rs.getDouble("ABSENT")%></font></td>
			<td align=center nowrap><font color=<%=mColor%>><%=rs.getString("JSTATUS")%></font></td>
			<td align=center nowrap><font color=<%=mColor%>><%=rs.getString("JDATE")%></font></td>
			</tr>
			<%
		}
		%>
		</tbody>
		</table>
		<BR><BR><center><a href="javascript:window.close()"><FONT SIZE=1 COLOR=BLUE FACE=VERDANA>Close this Window</FONT></a></center>
		<script type="text/javascript">
		var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
		</script>
		<%
		}
		else
		{
		%>
		<P><FONT face=Arial size="2"><FONT color=black>Dependent not found...</FONT></FONT></P>
		<%
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
		<br>For assistance, contact your network support team. <br><br><br>
		</font>
		<%
	}
	//-----------------------------
   }
   else
   {
	%>
	<br>
	Session timeout! Please <a href="../index.jsp">Login</a> to continue...
	<%
   }
}
catch(Exception e)
{
}
%>
<BR><BR><BR><BR><BR><BR><BR><BR>
<center></center>
</body>
</Html>