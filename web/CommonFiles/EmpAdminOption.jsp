<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%

String mHead="",mCompCode ="",mEmpID="";
String mCandCode="", MName="";
String mCandName="";
String AdminEmpId="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Employee Profile/available information ] </TITLE>
 

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>
<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>

<body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<br><br>
<%
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",cInst="";
String qry="",x="";
int msno=0;
ResultSet rs=null;
try
{
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

	if (session.getAttribute("COMPCODE")==null)
	{
		mCompCode="UNIV";
	}
	else
	{
		mCompCode=session.getAttribute("COMPCODE").toString().trim();
	}


String mInstCode="";

if (session.getAttribute("INSCODE")==null)
{
	mInstCode="";
}
else
{
	mInstCode=session.getAttribute("INSCODE").toString().trim();
}

	//out.print(mCompCode);
	if (request.getParameter("SID")==null)
	{
		mEmpID ="";
	}
	else
	{
		mEmpID =request.getParameter("SID").toString().trim();
	}
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mMemberCode=enc.decode(mMemberCode);
		mMemberType=enc.decode(mMemberType);
		mMemberID=enc.decode(mMemberID);
		
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;
		//-- Enable Security Page Level  
		//-----------------------------


 

		qry="Select WEBKIOSK.ShowLink('72','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";

      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
		  //----------------------
			qry="SELECT   a.EMPLOYEEID EMPLOYEEID,B.DEPARTMENT DEPARTMENT,C.DESIGNATION DESIGNATION,         NVL (a.EmployeeCode, ' ') EmployeeCode,         NVL (a.EMPLOYEENAME, ' ') EMPLOYEENAME,          NVL (a.DESIGNATIONCODE, ' ') DESIGNATIONCODE,         NVL (a.DEPARTMENTCODE, ' ') DEPARTMENTCODE,          TO_CHAR (a.DATEOFJOINING, 'dd-mm-yyyy') DATEOFJOINING,          NVL (a.GRADECODE, ' ') GRADECODE,         NVL (a.EMPLOYEETYPE, ' ') EMPLOYEETYPE   FROM   EmployeeMaster a,departmentmaster b,designationmaster c  WHERE    a.EmployeeID='"+mEmpID+"' and A.DEPARTMENTCODE=B.DEPARTMENTCODE  and A.DESIGNATIONCODE=C.DESIGNATIONCODE   ";
			rs=db.getRowset(qry);
		 	//out.print(qry);
			if(rs.next())
			{
				%>
				<table width=90% valign=middle align=center border=1 bordercolor=DarkGreen cellpadding=2 cellspacing=1>
				<tr><td bgcolor='#b22222' colspan=2 align=center><font size=4 color=white><b>Employee Information System [EIS]</b></font></td></tr>
				<tr><td><font color='#b22222'><b>Employee Code :<%=rs.getString("EmployeeCode")%></b></font></td>
				<td><font color='#b22222'><b>Emp. Name: <%=rs.getString("EMPLOYEENAME")%></b></font></td>
				</tr>
				<td><font color='#b22222'><b>Designation-Dept. :<%=rs.getString("DEPARTMENT")%>&nbsp;&nbsp;  -  &nbsp;&nbsp;<%=rs.getString("DESIGNATION")%></b></font> </td>
				<td><font color='#b22222'><b>Emp. Grade-Emp. Type : <%=rs.getString("GRADECODE")%>-<%=rs.getString("EMPLOYEETYPE")%></b></font></td>
				</tr>
				<tr><td colspan=2 align=center><font size=4 color=DarkBrown face='Arial'><br><b>Availabel Options</b></font></td></tr>
				<tr>
				<td colspan=2><b>
				<p><font color=Blue><UL type="square"><br>
				<%
				qry="Select WEBKIOSK.ShowLink('73','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
				//out.print(qry);
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				{
					%>
					<li><a href='ADMNEmpPersonalInfo.jsp?EID=<%=mEmpID%>&amp;INSCODE=<%=cInst%>&amp;COMPCODE=<%=mCompCode%>' Title='Employee Personal information' Target=_NEW><font size=4 color=Blue face='Arial'><b>Employee Personal information/Address</b></font>
					<%
				}
				qry="Select WEBKIOSK.ShowLink('10','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				{
					%>
			      	<li><a href='ADMNEmpSRSTeachRatingDetailInd.jsp?EID=<%=mEmpID%>&amp;INSCODE=<%=cInst%>&amp;COMPCODE=<%=mCompCode%>' Title='SRS Report of Employee' Target=_NEW><font size=4 color=Blue face='Arial'><b>Student Reaction Survey Report</b></font>
					<%
				}
				qry="Select WEBKIOSK.ShowLink('152','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				{
					%>
			      	<!-- <li><a href='ADMNEmpStudDrCrAdvice.jsp?mType=E&amp;SID=<%=mEmpID%>&amp;INSCODE=<%=cInst%>&amp;COMPCODE=<%=mCompCode%>' Title='Debit/Credit Advive of Employee' Target=_NEW><font size=4 color=Blue face='Arial'><b>Debit Credit Advice</b></font> -->
				  	<%
				}
				qry="Select WEBKIOSK.ShowLink('215','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				{
					%>
				      <li><a href='ADMINEmployeeSalaryHistory.jsp?mType=E&amp;SID=<%=mEmpID%>&amp;INSCODE=<%=cInst%>&amp;COMPCODE=<%=mCompCode%>' Title='Employee Salary Information' Target=_NEW><font size=4 color=Blue face='Arial'><b>Employee Salary</b></font>
				  	<%
				}
				qry="Select WEBKIOSK.ShowLink('216','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		      	RsChk1= db.getRowset(qry);
				if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
				{
					%>
				      <li><a href='ADMINEmployeeLeaveInformation.jsp?mType=E&amp;SID=<%=mEmpID%>&amp;INSCODE=<%=cInst%>&amp;COMPCODE=<%=mCompCode%>' Title='Employee Leave Status' Target=_NEW><font size=4 color=Blue face='Arial'><b>Employee Leave Status</b></font>
				  	<%
				}
				%>
			     <!--  <li>
				  
				  <a href='#' Title='Teaching Load of Employee' Target=_NEW><font size=4 color=Blue face='Arial'><b>Employee Teaching Load/Distribution</b></font>
				</OL></b></font> -->
				</p>
				</td>
				</tr>
				</TABLE>
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
			<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br>
			<%
		}
	  //-----------------------------
	}
	else
	{
		out.print("<br><img src='Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
}
	%>
	</body>
	</html>